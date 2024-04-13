Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EC3BC4345F
	for <amd-gfx@archiver.kernel.org>; Sat, 13 Apr 2024 23:31:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A96E10E3F2;
	Sat, 13 Apr 2024 23:31:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SjQh9+Of";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2065.outbound.protection.outlook.com [40.107.94.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3820610E3F2
 for <amd-gfx@lists.freedesktop.org>; Sat, 13 Apr 2024 23:31:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a39BBb0H+auWwBi52nBJ6NpLz9AhaZd9/PTXqSVEkKAqNIJTI4pGHCiDiRQ5Am5wBjeDF3R8tHeCCzbsglluyc0Z3EWIsABj9PsAoCvBmcSkYO549ZoOJt445uqkiiczd9QFaTfkpfnRLP9iuZL7ZlCjECHUxHnN8C+KOBZ98+JpV0PjdYPVU18L89OF48v0OmrHFRxKc53ZXJPnyJQe0s4Jd5xFApuLTJuXnnlydNPiNlwdBXOsoHCtFeoJo/Xda4kScAz2xnVx9J9ixvTNN7jKzMZvCwX1jLZL3HS/RTk1TqgzqmmTnKV6JeVm2vW3wMQI56o3LQlO6sRNkwe/gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BeQefTxPE7ejx/nkRoYbFSbSxRpADRXRSElsJbyLe2A=;
 b=Rho7qAwRIvXxJJORZjvMzvof6Awwwjou+laF0MxV4w/5WMahqHv235kcBD0Q8SPu3GNh06TLehCtgBlcojFCgBnUJx0NL+fC/sk9JkLfBpU2SFiTNRX396xCxRJzTFT7leiIoodHROAjRGo/Xnp/SjPwxHA+NvA2NiAdNsSBieVHJDzerS1WlWfvLjL6lV4XiDNHYjqUqvR3xX6nn6OGHi2julIGQA5SdRusq8EvABJZmSKut2f5lQpcVRgiCCYWIX3s6hsQY8HSvcJ6/Mo8KfYzWPrrXBMCURzEbaERTL4kmuyYlSrh0wtdCeIj1sWp7Xa2HYuwFpdHucnhfTfE1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BeQefTxPE7ejx/nkRoYbFSbSxRpADRXRSElsJbyLe2A=;
 b=SjQh9+Of//k4ctvliFRk4EMvSpgBf55NetrRh91BHNkBFw9gv6XLLm3U4lK0dhbdOA5p/TMY5Jqtw0vfYac1pBB2LGcbSBHHfi0krelugM9DRM/xXqcb6hmFgMnBIDVWoTGfjSZTEHE2eVryNEciRkQeNxQZC2NEVjLdusW5ot8=
Received: from PH8PR22CA0004.namprd22.prod.outlook.com (2603:10b6:510:2d1::19)
 by MW6PR12MB8661.namprd12.prod.outlook.com (2603:10b6:303:23f::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Sat, 13 Apr
 2024 23:31:52 +0000
Received: from CY4PEPF0000EE34.namprd05.prod.outlook.com
 (2603:10b6:510:2d1:cafe::7d) by PH8PR22CA0004.outlook.office365.com
 (2603:10b6:510:2d1::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.31 via Frontend
 Transport; Sat, 13 Apr 2024 23:31:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE34.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Sat, 13 Apr 2024 23:31:51 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Sat, 13 Apr
 2024 18:31:49 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Hawking Zhang <Hawking.Zhang@amd.com>, Likun Gao <Likun.Gao@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: rename DBG_DRV to HAD_DRV for psp v14
Date: Sat, 13 Apr 2024 19:31:34 -0400
Message-ID: <20240413233134.3989380-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240413233134.3989380-1-alexander.deucher@amd.com>
References: <20240413233134.3989380-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE34:EE_|MW6PR12MB8661:EE_
X-MS-Office365-Filtering-Correlation-Id: dc1b5b31-459d-4497-f43b-08dc5c11e5ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R4YbEIvpIUk0IPNmcSrXhmD5B9//epPtRzk9Kjo/5fq38yzs7JGsCnb/mDspvRrAD2BoI9iTG379RhNGKZIQS/qJIRMd2Jq95pH0PROZZGJZqkbezHhsUQpjIohx5i9QZfd6Yb6/fiVUGQtkwnHVgfsLAi7QFrNO2PQovZ46IUHi1suBI4jItZlpokPFri04BR0Q+tyDdFZGWMnfipoD1iGzSBTneAE8MFgpqehVwAVkFzoOaschPYZ0SnXK98+NeIqy1I/0a0rwkag2RBcA8/HVSDiez3KIgK7QyL28IG/eihbxoOzyaPMNr7euO4AelFW//mgc6kX3D9iU+OavkRufAP0i+Rf2479pUHwn8JOW4EoSz3IcJg/HFb8G71pvnAPfO/3wFHgl6bEBPgNhQIHASO0eHLlBpAZHFNkESMQ2nNVPYVubGoyaVNipMgg1/wdTXViOqumV/ksgi7NdO5ZjT/s50fNSwUqe4Dx/33NxiWxUyrSZoaZNWycmERGOUSygx2eYw0Bt7iFt4tCtn51UcavzUOBfZv2Xm4ammqvPtV0vDqduSd8gW2BCqiz+NeMROro1Z2Z0xOistmgItKaNnrYdpisKsoJbhUU420dI4/4fh6GW9p1Jk6Uh3ryg4pGphIbBOO7te+d+3JZbDIEPsFk1K1l/e50+ixtAbuMx3ESFUk64g2YbQz8k0uVSP6DShEBg6OvUXaJH/rmH5zznhJEpe1AjNilleXQGuoFD7cG2dospy53yrVcrMChC
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(82310400014)(36860700004)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2024 23:31:51.8447 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc1b5b31-459d-4497-f43b-08dc5c11e5ce
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE34.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8661
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

From: Hawking Zhang <Hawking.Zhang@amd.com>

Add a psp bl command enum for HAD_DRV.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Likun Gao <Likun.Gao@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h | 1 +
 drivers/gpu/drm/amd/amdgpu/psp_v14_0.c  | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
index 66b3f88fbecdd..3635303e65484 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -73,6 +73,7 @@ enum psp_bootloader_cmd {
 	PSP_BL__LOAD_KEY_DATABASE	= 0x80000,
 	PSP_BL__LOAD_SOCDRV             = 0xB0000,
 	PSP_BL__LOAD_DBGDRV             = 0xC0000,
+	PSP_BL__LOAD_HADDRV		= PSP_BL__LOAD_DBGDRV,
 	PSP_BL__LOAD_INTFDRV		= 0xD0000,
 	PSP_BL__LOAD_RASDRV		= 0xE0000,
 	PSP_BL__LOAD_IPKEYMGRDRV	= 0xF0000,
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v14_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v14_0.c
index 241d5ff2ef3cd..f08a32c186946 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v14_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v14_0.c
@@ -169,7 +169,8 @@ static int psp_v14_0_bootloader_load_intf_drv(struct psp_context *psp)
 
 static int psp_v14_0_bootloader_load_dbg_drv(struct psp_context *psp)
 {
-	return psp_v14_0_bootloader_load_component(psp, &psp->dbg_drv, PSP_BL__LOAD_DBGDRV);
+	/* dbg_drv was renamed to had_drv in psp v14 */
+	return psp_v14_0_bootloader_load_component(psp, &psp->dbg_drv, PSP_BL__LOAD_HADDRV);
 }
 
 static int psp_v14_0_bootloader_load_ras_drv(struct psp_context *psp)
-- 
2.44.0

