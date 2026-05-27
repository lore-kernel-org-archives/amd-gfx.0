Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE972CD4F54
	for <amd-gfx@archiver.kernel.org>; Wed, 27 May 2026 19:46:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 59C1610E97B;
	Wed, 27 May 2026 19:46:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cXJ97C/q";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013046.outbound.protection.outlook.com
 [40.93.196.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D72D610E97B
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 May 2026 19:46:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fRelwhaYFeT6bL4kOS6eY+5R/Xr2pFjUv6upl6zY05cmsAalq65V+UtOtOS6pgxgbBwSnhADsFxt+0cZBfVF1ZJleUIYXTxBhGTH14gp9UPkp3UHIp3aQn/G8MJTwtpYUXJ/FOLzvviybwtdHygrmhBeb/f9hcV/BFfuV4QrOcSYgn5BTjdf6KmDZci/tzzNhktEySXpUK9emdSUAIdAuWVV3XSp/+x4pZYK+AA2F+m5C4FFdWSlxWsQJPLvKGln9cokPqA+tChmel3leLoZyxFXmYcapUDmTfBoasVCHY5Z6Rd4yPY09kp5GeVAajEly6QwwMfErhB28ygsZKnNpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Yw3Jfhho+GTSjNyJmpGp7xohT9bJSvzQRmpgFYo9zY=;
 b=iSj3ZIV0NDladUaCgYEkaBRmQ7JgROkUSzXneYsRZNzLt7Asj1B7k0KoqH5fi2qDOvKcczaYYV2XFcBnryP+Q1o0wJtCjvNNFEs4xlDExFmmkjXtdMn0TaNFyE2waBdbOPM1dx7ljqCfoUkR1Qkw+nXYMGzagqFtf3oiqJG8EeHMS0pbOCiiSWRN3iXnckanebjDVFnf1Gio5LHwylu+N5n1tq0H6qqoNs5aecrT/bGPHj2C4RXqH8a1byWVHO9ZksHv/8gK0lQVrPxBoQKKuk5S0qlca/WfCyF2Vq+N3Hlf3ADWhAjK1KqZkfwOqZyxFP3+9kDLf3uCrjuW05RUYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Yw3Jfhho+GTSjNyJmpGp7xohT9bJSvzQRmpgFYo9zY=;
 b=cXJ97C/qZbLkDfZkbdxkWXewkFYVl3a+6+6fnBrXWMkACbnKKUSoRbijUnA9B32OoG5G2vIDefgyiSz+jUYs0orApy6pb985tVn63GAXh93aRLR0EM2i75IdRqfPKJM6wM5Er6ujjmaElF/tak7ziuRGzmjYif3WmLse+PK7ZGI=
Received: from BY3PR10CA0020.namprd10.prod.outlook.com (2603:10b6:a03:255::25)
 by CH1PR12MB9720.namprd12.prod.outlook.com (2603:10b6:610:2b2::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Wed, 27 May
 2026 19:46:18 +0000
Received: from SJ1PEPF000026C5.namprd04.prod.outlook.com
 (2603:10b6:a03:255:cafe::96) by BY3PR10CA0020.outlook.office365.com
 (2603:10b6:a03:255::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Wed, 27
 May 2026 19:46:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF000026C5.mail.protection.outlook.com (10.167.244.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Wed, 27 May 2026 19:46:18 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 27 May
 2026 14:46:13 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 27 May 2026 14:46:13 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu/sdma7.1: fix support for disable_kq
Date: Wed, 27 May 2026 15:46:03 -0400
Message-ID: <20260527194603.3976381-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C5:EE_|CH1PR12MB9720:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bd46d69-348f-4758-09bc-08debc289f00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|1800799024|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: qXkX1a6QW0vIWg3tYbIBhXeoB8Dmx6GM9fo4GGiU9dPJfrv8991qt2HgYzra+8WLpy+wsUih+yQr9iuoMcarbxo1E3OOXKo3EA1yvSBDoRbL3eBVmLaxT4BHdLv4ZmQpOEEEi4zfbBjEnT9ol1BUonBAQDpgT9NRXQTxG9yZQ1DB/HRHNKRV0IJG9mpXmoPpIeLJA+hRNR5BKXmLI8loJcYB9f/iKHZRUFOtToN467D8tNS8SXbZ0FFCxKNzq9PZPbVwq88itV+X6PKSLQWxc2xII4qX9Gnv+wgJ+DOn5SS4LgxB4SyX3txvdrK/hFrUZupo3X42h/GKrh1tHesSPPXDFXGv1+OHZ31els2cqu4Nq2ZTnD3gcHMAEFGoEK/QqarP86BD9nWVFijwhNcOvNWuiFhlHiaUrjGj/LI5JuDRMvGsEj81xL34Llaoa2rYL3BQg2GxJjmOLJazdJxF6ow2xgyCi2kAdAh1TBZ/Fz6PoDgv37CQzAP/1a5WGEPImrkuY6b3Gaim541AVHOTND9MzlCntpjXQfwNsOcnYMGdwB4ah0pQFLCLQ539nGX+vaUuY8FvwFja0201BqvAqj4US8D8nzCrUSgnTPqXC8jTISZ/UA+r5CTTwkzKXpQGLV8vVVUBSYbH4PwenuGUAnguwjSKtu+ImiSCHgNRlG+KfWi2uFoFCzL7aD8ahqjFcOgzLLcVwTJPJuLFf+ea9Z1hAHLgJoDXRfZQUkhjJzU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: /bC4yx+xqSwARvevGVjanvh9wQjf7+RiGfex6UmJVtgcp50nnWlJWQ2Dp1jO1+cCgThg0VuEI6FB2UU/SO2Im+usZskcZ1eY8drYNlxtd/WmohyZdb2GB3odIZeu/eo0sA1UeBX4sdg8gANI5MQMPkB3GK7JvCg4B6FamlYYKwBw5XtnjMelZUpIQEODgEavUYgjGMWpWGmPekMlTMKlOPZac/myxVkXpqe8G7sLvSaDIbENm8LfBEsf3idG+PC0A0mXw8tDTnVQ3A80iEhOorFYxltfZ64ZjPD/jdqFdS59Ck98RMWPFQq2K5r6T2huH/RMfBG+NLxUGhHHON7V15q7LhAMf277uQNgB1w2Os865EWCjSybbSsz/yeZX1sDwhlrie4egwhs6iPKJr4LDHYT02gn/Xbd/65+YGNlr699GGj9AawGR0cG4HHDUhQV
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 19:46:18.4210 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bd46d69-348f-4758-09bc-08debc289f00
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9720
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

Set the flag in the ring structure.

Fixes: 80d4d3a45b86 ("drm/amdgpu/sdma7.1: add support for disable_kq")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
index e1c0a4ff0e7ff..cd9668605a501 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
@@ -1315,6 +1315,7 @@ static int sdma_v7_1_sw_init(struct amdgpu_ip_block *ip_block)
 		ring->ring_obj = NULL;
 		ring->use_doorbell = true;
 		ring->me = i;
+		ring->no_user_submission = adev->sdma.no_user_submission;
 
 		for (xcc_id = 0; xcc_id < fls(adev->gfx.xcc_mask); xcc_id++) {
 			if (adev->sdma.instance[i].xcc_id == GET_INST(GC, xcc_id))
-- 
2.54.0

