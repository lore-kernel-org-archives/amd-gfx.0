Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4678CD98E4
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jun 2026 23:57:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05DBA10E76F;
	Mon, 15 Jun 2026 23:57:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="x3yas4v1";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011048.outbound.protection.outlook.com [52.101.57.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C6E610E70C
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jun 2026 23:57:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UUmY/8qCZoZK7/zUilyU3YJeByLel0GLat6R4cTSp138fIlR5GpZywGAuSKoeVQGXRPrG+S6iqyjJcvbs/Una+kXwV9fF81iYqjvaKqbR4IiZYtTKvGjTGoivnSRnLYBzu4Y05yNBBg7wnWbqAFLTl9s7BFaFXKNO0hKgvleCKsm7o9qd67FIt8lMDD1n5Hq5TF/64d1YwwMEKjodb41q5CnqjN6N+4YDj+tZiJAGDikVcavWzwIiqt8BpbiOwKkdChklbKsZPm0ddeGjfP4J1O9ORiFJ+krrBkOT80YlB9EEDoIwZMxaOWDU5weOnDpRb7g+uJ9qmdBCx1N+Yp+gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7MYYD9qrbCHWeDuvQGgf0io5yg9uQOsiRneO0xIzR8I=;
 b=ZKt9unxzPJ3aqTaLBtnfoJ2qAo0JQtICwlXxSxrjeO6YB0QFSOw0uz1yzsFElv3z0NcYKuaVM8a49wUzGrfiOCxDoczwIeoJpsWLEbvaY0f770S2V7zeaeurx6frrM7sT4klN5HmakpyXKhS4IqTzsl8rGZXNuDaeOZSB1dpYkcUaTPHKlUcNQmDmiKG+JU5ZPglZeeDbAnwDm3XNm/IL+7Zf2Nf7f+70aASqrRTmvSF/p0rWrejkUgSniMqUGSUwtju5XR7gyLzDR61WHQy/NIQLvJQI23jALtfg3fA4pXFwp2/qFxEQOin/vSv2fKlRLeHp/03lxe/Tw06x1pqJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7MYYD9qrbCHWeDuvQGgf0io5yg9uQOsiRneO0xIzR8I=;
 b=x3yas4v1S8kbs/d4PxqY+IiLj1lThDXsCnnTrL9D+uoB8BTptepTkXqTo+j0NLOnKv8kl9hPLihuWySnAzFKS3bjlAhzoWS+uoesqkJXHMii0Ve+UTv4eeuxccLlldmu1MIszNi6m43tMjIazggUckrf+z+BpziBVbA4/aWnJEs=
Received: from SN6PR2101CA0024.namprd21.prod.outlook.com
 (2603:10b6:805:106::34) by IA1PR12MB8079.namprd12.prod.outlook.com
 (2603:10b6:208:3fb::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 23:57:00 +0000
Received: from SA2PEPF00003AE4.namprd02.prod.outlook.com
 (2603:10b6:805:106:cafe::a5) by SN6PR2101CA0024.outlook.office365.com
 (2603:10b6:805:106::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.2 via Frontend Transport; Mon, 15
 Jun 2026 23:57:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003AE4.mail.protection.outlook.com (10.167.248.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Mon, 15 Jun 2026 23:57:00 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 15 Jun
 2026 18:56:59 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 15 Jun
 2026 16:56:59 -0700
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 15 Jun 2026 18:56:59 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 14/43] drm/amdgpu: return an error instead of BUG() for CSA
 bo_va
Date: Mon, 15 Jun 2026 19:56:16 -0400
Message-ID: <20260615235645.737189-14-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260615235645.737189-1-alexander.deucher@amd.com>
References: <20260615235645.737189-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE4:EE_|IA1PR12MB8079:EE_
X-MS-Office365-Filtering-Correlation-Id: 5914ff8d-0482-4872-00c9-08decb39caa1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|376014|23010399003|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: lP75vsKNgxIwfRRY3hl4+QlsB54Iw/MXEWk9b74GcUZ+x9CS59sBBYzBqLYxYqP8SieHGot+h1m0P6m8jTEpgzXDbsU/7VbnIvrXaNlYuqn/2/0OSHn9xS1w8Cdd3U1u++XyrE5VDXxp68edPDbI52fN8PJPoapb19+Lb/JEqZbIUcggTARsLNFZUK+fcHlECUYCi8Fcq1IiU6Wph2YYq62aC7a1bUpSydjWsPP4paTP4ByflT8aLtyEDKWV5yjdULBFcBsS3afTICVUUH/Q+Q1g4F3+dugOL+QtlwabR1q+ulHjrCWgvHZMkUzB3wmIIlzO7WLYNG8svBUEvLXKJdZybkwtA++zuM9W5EAkXPIJ8vXnaMUM0nojdfgnAYbq13SSFR1WiZEOw47HnYFx7IgNksJ51ROm8oM+1z+x4mwUhzf+2HIZEyovqDXS5yUQgKOgafXMl8SljP5/DC70jl8VmZ8PAmBwQKYmUGQCho+y2sdgKfrtmo3Par36HF/Nu8JVK+hYdpDiskIfpS8HT2QjwT5uUS8pWSoe1p6oGBeWN4X7lvzcSwm7nVMh9Uz1G86GGAXp644zpOUkC9kG/LDg3YqtZK+Se4NXcyJmef84hTelFn5/rF/eP0mc3dEssg1xURyJ/MXzqqgZWbTmvaVzmehJgisexXFv2rPTt35rNThw04BrqIQmAA2PwUAcEKQucEg5Do+qDa1S3k73WCLBM8ywfzzRPds3CdWY6/g=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(23010399003)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: g1Wl5U45bTx6KRgGPj1lokqNB37VZvdOCLTAKi6RsjhjrM+dV0IqfEYWg82SgcW8ZzUseK6cXsfZvj9i5w3rx/K/UGS5I/SnKHr6Ck7XOywWmj0eoHmQx12hYwIKaeGtSaOGSVEH71YyXoxWmWySRvU0zaRjGHE5I0MYrV07XJHIYa+r+UBMOXdgtEpWsBS6pmtPjc41ZMImvv2EctxsvGuB8sQ6YlrEh/D3WMy4IccvblJl2S4WNmc3sReZu/z7h7oW5KDncOygIcoppNkNshyz/qgVbmUMS576gZJDtL6oK8mHeNX7oyVn/7wL0fJg6MVE7AMNDR+kUbRcPJxAQ4p4/e2J0Zi489XlRYmKtRMtfY3WFRmJFUbXZx8GOIhXLS+sX3bTII7fFqf85FV8inRlZBIY5/EzqX3wmbg9PJdfOPHcx/CiX+MQYpUmNz/5
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 23:57:00.5415 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5914ff8d-0482-4872-00c9-08decb39caa1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AE4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8079
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

If the bo_va is not present, return an error rather than
crashing the kernel.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index 0416827b4bb45..cebda4784ac3f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -1124,7 +1124,8 @@ static int amdgpu_cs_vm_handling(struct amdgpu_cs_parser *p)
 
 	if (fpriv->csa_va) {
 		bo_va = fpriv->csa_va;
-		BUG_ON(!bo_va);
+		if (!bo_va)
+			return -ENOMEM;
 		r = amdgpu_vm_bo_update(adev, bo_va, false);
 		if (r)
 			return r;
-- 
2.54.0

