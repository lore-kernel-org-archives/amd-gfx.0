Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D801C5AC7A
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Aug 2026 10:11:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B6B3C10E410;
	Fri,  7 Aug 2026 10:11:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SjLCFAZG";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010004.outbound.protection.outlook.com [52.101.61.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8AA4810E410
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Aug 2026 10:11:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xwhrpCJS050Uus6S0ofc/R2VtMszLbbLrnAFh8ixPM9WpNN+a08LB+pe1vxs5VFyjZ0yefi7FjqqWKXfsWLXXU14aElepL7htXo/uME7y6/EVP9dSFAVz/8us9EY+HBrwCpphsWHtRCBO6zJexC3xEq/OgQVh5HghxCQitvN/JUkVfzgql6B2lP5m4n9ZGe+osJoz/4ILvJT6xtmt6Ua5mtU2wVAUa/r2UEqZUvBZcGfBB20e9C1y1lGjYcJQ+ffBxWGOwV5vU2m9nXg95eaef2rWl10pN73h0iYXdvDfgwC9G7KTr4Df3I47GUeImMMalOnryFMqttTPTPbKnlYFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gkLQN5EaEs7vqGr4rY+DqVbIpF/eiUANPyk/qoeOZaQ=;
 b=f/0SRsEPNgdB5k80pyKuMr0yuN9kT59p9R2Rq7z/uaVhi6sfQvHuJvV3SB/0ixgTT3wsXbVJ+9qlG392wGnL5jhyA8QPeN3tXaZxyfoyHJ3YgsrxP1MUkZCT+nvBl0e9JuijkEPc0FRBVU89sE0boRC1IJN3dcexsxDR8ZMNJoTrFLAck+zWroFgJmuvPBy1RmhaNrZpdIVt33iwYJPX6SQtxrcY1lICTunLNJuyfU8lJJh8UnN8T7R/NY7/QcmxivE9jUoynAg9Yv4h/BOQ6ffxwd+Kzog/bOfstKhXxMARcdyZX0mOviIi+QJDLHboR1kpxVvzK2Of0GFMS6xtEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gkLQN5EaEs7vqGr4rY+DqVbIpF/eiUANPyk/qoeOZaQ=;
 b=SjLCFAZGxSczUZbW1w8mPEaduZF8SrLEM56tdjk1WyCcAmGgzIn6tY+/j5tUgzaG+s1UM+uvknecQXq0MqonXVOQDfdakauFKa0evT7wpzzlWWS/Llia7DZ8YV+JPXP/iZLZ3coSneO+Wqj2hnX+9TFWdhh4w2zTvbOasRzZDFY=
Received: from BLAPR03CA0115.namprd03.prod.outlook.com (2603:10b6:208:32a::30)
 by BL1PR12MB5802.namprd12.prod.outlook.com (2603:10b6:208:392::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.24; Fri, 7 Aug
 2026 10:11:02 +0000
Received: from BL6PEPF0001AB58.namprd02.prod.outlook.com
 (2603:10b6:208:32a:cafe::70) by BLAPR03CA0115.outlook.office365.com
 (2603:10b6:208:32a::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.23 via Frontend Transport; Fri, 7
 Aug 2026 10:11:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB58.mail.protection.outlook.com (10.167.241.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Fri, 7 Aug 2026 10:11:02 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 7 Aug
 2026 05:11:00 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Michael.Chen@amd.com>, Prike Liang <Prike.Liang@amd.com>
Subject: [PATCH] drm/amdgpu/mes11: disable MES RS64 process/gang context
 loading
Date: Fri, 7 Aug 2026 18:10:51 +0800
Message-ID: <20260807101051.367233-1-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB58:EE_|BL1PR12MB5802:EE_
X-MS-Office365-Filtering-Correlation-Id: bd668d2a-9fe4-4814-7598-08def46c2f74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|23010399003|36860700016|18002099003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: ksciQFdbcz0vtjm9OD91vU6uwXbDlxHAQFqQcz4afFiXBsmnH5RJp5pPVNHW33Am2YYp22xAuJrCOH2iS2U10Q2nPaM4LnMlzqXsfuQOEtvR9uFCQyoLgMFozbLgLMiJeELw/yidPbBOjMn+fqK4t2QZQeNUB/QJ9twy35BzX/ODuu8iI53jZCuNao0xDFHx7Hw5Tm78uBLnZUbCbGSKW0zfuPLHi9UNoaSlR7MwNMmqLzP6GUCrsnlZ74KGW3CUjm1mt/R5TDjrhy3FQ6jBF/WnlTUqHpw0joMGIYmIhxMhIffc2x9QcSnL+FgC61xOW/+UQOfxqwFnujmlEIngoPtY/wPhskNNWCp1DMJagRu7SM0ePhqannT9c7xwB0WmpbemEGmlW24LDwXoPGSkEyzEYv2vbgy6LXy+4+26vptb5txR1/f5TxaTMqfUfCDnFbJtsaOJ27qVZUNlL9CSoSlsPhjzRasBEScF1vNXnFNDtxpyoK8/i0ZRBytVjpsgzqUrRWRuhUPsszoSf8MPT3OG9bWwBGAm+pKA8bk/Vcl0TbCxBUVzBxYrHZJaIk56BZDQ+F/cR4UvefqgTAhLDKvQEyR4jL7rFOG2zJFznXBARv9JP8gWGIiRg2oH74Xxbptz3VjieM1vCcFzE7t8KuUmuhcMJ/E/OAgLROVvPQl5VO+ZTTKyl4PWwYXx2SEH
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(23010399003)(36860700016)(18002099003)(11063799006)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: WOGpBR9TKq5sF1bZz+Stm0n9PQbUc/E/UkMrExsRoQvNs43iKjH0cg3w5QkVim0+7agqy77v5g4ko/3Xjjf8vKcR1Os7sGkZKsNRAreEdHHoSNqyaSHxc2GJrTtqpPFbjep4MziQ3sprKQlA/v+jBY7dUTPgoph5rYcCRK2AGAnFS+Qr+ZlIamL3j8g+0GbDS6WjjGkWNrPNpz11gaQljKhlkWdqHD6ARrJW/tBWQ+zwNOuZAAOXcGw3fzeD+0tH1WRTs+KfFp35TvkTTj2lJlZi6IMN5V3aUCsUcAYH8R/jkhgbSh2Ney3qaty0Pr/ed6MNJ3QAh/iMMMEjWr149aPtCBj1Ssv6tU4rfghBz4aG5CllyHizV1Xzm31ZGg3pH9kwSf7zBAdzRb09hE91JdNlI/MClhhpoFaRMe+AoRUf7zUmWVFhYrPqEYs9GHs6
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2026 10:11:02.2662 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd668d2a-9fe4-4814-7598-08def46c2f74
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB58.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5802
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The MES RS64 local memory process/gang context index may be updated,
saved, or restored improperly during queue eviction and restore cycles.
Enabling RS64 memory for MES process/gang context loading introduces
two known issues:
  1. Performance regression on userq due to improper context index
     handling during RS64 memory access.
  2. KFDIPCTest.BasicTest failure on Navi31/32/33: the IPC buffer
     GPU VA mapping is not correctly reflected in the restored RS64
     process context, causing GPU page faults on the IPC shared
     buffer address, which eventually leads to MES firmware becoming
     unresponsive and requiring a full GPU reset to recover.
Temporarily disable MES RS64 process/gang context loading until both
issues are resolved.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index a0b874c9ee7b..c57bcb9a98b1 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -1954,7 +1954,7 @@ static int mes_v11_0_hw_init(struct amdgpu_ip_block *ip_block)
 	if (adev->mes.ring[0].sched.ready)
 		goto out;
 
-	adev->mes.use_rs64mem = true;
+	adev->mes.use_rs64mem = false;
 
 	if (!adev->enable_mes_kiq) {
 		if (adev->firmware.load_type == AMDGPU_FW_LOAD_DIRECT) {
-- 
2.34.1

