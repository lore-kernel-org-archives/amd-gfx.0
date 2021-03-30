Return-Path: <SRS0=Oizy=I4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19CF5C433E0
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Mar 2021 19:35:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6C9F61994
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Mar 2021 19:35:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6C9F61994
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ECB946E961;
	Tue, 30 Mar 2021 19:35:49 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2088.outbound.protection.outlook.com [40.107.237.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B6B889C29
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Mar 2021 19:35:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kKQbI0BaC3myPSQuA9aMqfdcK49eQvx4E7RIQ6pbu7XqeHAZzUmeU772NL+Oqbut2ChDTNfH11JPYXGBvW5CMTCHmL8Zytjt90NNz2KWh6BwqOijyHBIfTICGZ0LkJp2U6vEnJ+pULYiKKF94cKVXPK8r8kbpoARyzHfmQ6/TBvaAB7yRuQCLsqEgHRfv7/tk87lOCmj4wWRhWMuSuhq6y02Hv20nW0tbUA4botWRFcadjB8Nby/cfS+es6/dmGBdYnDdM2OTpXDenX3g7dbqciD9O9ihDzG/Ohsvr0V0KeKcz9MPwAUwSgy8QeEv3Kga9zpC+w6oj3S/oNVUnULtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gg+WlSkGJu8kPwy/LI2yAMWqGKisNGO050Pckje4vdw=;
 b=d7fv+Dh0cyyhEg+w/SW3HvCv3xIDlqOs46UFBB30b9rdUy6H2eHrGnx0iflbYeGBVcundCIZLfS4LrGpThxz/7GflqWkLBgEdDrDsdkO1m6exz4+npt94665qZsC9+D/C83r+7kxI8tH7p4FDHJ02S1mljpC2oWmFmeuYhi9QlypUrjx22iYEEcveILOK2z85ZKwzIpW6Y1WWdyI5SMX1LpClSoOtMIyfGe5x3eyxEbDnVYeOTBQ2XjI1Xch7CrjYHpATQT6p2UQ9Eh7yjBbeyg+/KzyovL9cuADrWuJ47VfkflKdHip2fL0p6kdWDiV/atSuaOEUSfRROYY5AYgeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gg+WlSkGJu8kPwy/LI2yAMWqGKisNGO050Pckje4vdw=;
 b=LFa5wSLrqsg0ZEH3CssvbCRPesahmCtbdpTU7GhDSnQlCdp47SF7v+GXs3PESeFIA2yR+d4XA81DOe7XPFViPq1qLkh820stcYI8yd3ZteUWRpYYP2cNWWGi0+aQ+SWKL8bhUzGHWv9PtTwdN4p8x3BZnx56+mONM/MSDwwrgYo=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4732.namprd12.prod.outlook.com (2603:10b6:5:32::25) by
 DM6PR12MB3787.namprd12.prod.outlook.com (2603:10b6:5:1c1::29) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3977.30; Tue, 30 Mar 2021 19:35:42 +0000
Received: from DM6PR12MB4732.namprd12.prod.outlook.com
 ([fe80::f40e:1245:84b6:e2a4]) by DM6PR12MB4732.namprd12.prod.outlook.com
 ([fe80::f40e:1245:84b6:e2a4%3]) with mapi id 15.20.3977.033; Tue, 30 Mar 2021
 19:35:42 +0000
From: Oak Zeng <Oak.Zeng@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 4/4] drm/amdgpu: Introduce new SETUP_TMR interface
Date: Tue, 30 Mar 2021 14:35:33 -0500
Message-Id: <1617132933-16843-4-git-send-email-Oak.Zeng@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1617132933-16843-1-git-send-email-Oak.Zeng@amd.com>
References: <1617132933-16843-1-git-send-email-Oak.Zeng@amd.com>
X-Originating-IP: [165.204.55.250]
X-ClientProxiedBy: YT1PR01CA0128.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::7) To DM6PR12MB4732.namprd12.prod.outlook.com
 (2603:10b6:5:32::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ozeng-develop.amd.com (165.204.55.250) by
 YT1PR01CA0128.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2f::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.3977.32 via Frontend Transport; Tue, 30 Mar 2021 19:35:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2ed7f31d-bdfc-46e1-8bb8-08d8f3b30190
X-MS-TrafficTypeDiagnostic: DM6PR12MB3787:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB378703320D9FCF3DADAF90D1807D9@DM6PR12MB3787.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8/tZZ5grMilDgiedo9Jeg1EAaCMJdf1MM47sj9QHGbxoh8fWMDXck44B+fcNF6nt/hTJgCY9DMiwxJR5WKglPvTTVjRFvWF6JELwItpCGj89AyiKsLtPttw9JXS6ZgrgRHrZrorMU5KSjDQfOynMuUVsF2pQjj7tU/odSoHBgIz0CwfFwTvJU62jGKsvMsUZAe6lHLTKqVXwILX9Tixjf3TDburVIRLyK93Csj9S4uOv1F4L3mIhbkhNI5XX0mnLhOTFEVgtCOrzvUhXVhDqqdFtXy/CU9xLirBWNKxn0qTb8UIgVXMYb0zdfVykv3URHSPLND+p2WeMegL5jrP5x6JEkHi9k8R2lKwVFfHNCuQIRJNM4O41BfOp40kZxDNT4lHtv8ccnoRWBJIHmyDZ3n6mLxNu7kSFRrs3aPR6TIAtlNmRGoIoXScxw/h764rH4rNTp1VCifpo8XFDmc80RsrnFBumwTLCnpR/B61puzCYzCg95msC9bV5TAFhrflDYDx3Y2xNOqqwTWtd8hHERWu7jkLqc5VX34idS4A5IxuMSBd6iwcz6lrPXOAFc/TQm/vgZBgZAgZHCrXlH2jgM0DONVcSOngOlKWPixFWuZdNNx7wbKfgYelY3idM6H+4WX1uRvvfxJ+9PjfIKVJABBl9IPL9vMdEtvPdeDfZSRc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4732.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(346002)(396003)(136003)(39860400002)(6916009)(8936002)(4326008)(66476007)(2616005)(52116002)(5660300002)(38100700001)(2906002)(7696005)(86362001)(66556008)(36756003)(6486002)(186003)(26005)(83380400001)(6666004)(956004)(478600001)(16526019)(66946007)(316002)(8676002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?v6Bj+j3FknKtJuHSfDmX77hQeT/afuIGexgy95eznawhiAYJobGGVlyP/M9b?=
 =?us-ascii?Q?wBQWJrvPC3gQfIFlELRnvw0Yq1E01JRArhdCoLytoXWv3wbASXw3vwdKyWYD?=
 =?us-ascii?Q?Rv8kWAb6I4F/y60pmJ3IGMWOTPG6tC0z/PviJSoylx9eAm/IYcLMYyTpVGXE?=
 =?us-ascii?Q?00k+X0vqeA1KuTF9KzoXBBsd/MIrUQZP/7j81vb7LOlk09InlHWwTkwTRtyp?=
 =?us-ascii?Q?ZGoyWsfg/u/ZKIs/PpQR/5vSmZEdPvsD5O+twRPsdxFjLfUHyOWJzCUiWIOR?=
 =?us-ascii?Q?lsoj6jz27D0XJp8LPA+zrXJs3a4D/9J1CZlWfOrt8lUHvOn/vD3ADcalJsdq?=
 =?us-ascii?Q?6RO9vchVEereffd1UJHTxYtTH12FyacaZyXKgyIrsPySVK3LzBqrFPsdaaKp?=
 =?us-ascii?Q?GT85pH5lyM9lSyyRBxcUEdwrw+rfblA4YK2pG7KLxn7Y8z4x0oEyTbjCmodS?=
 =?us-ascii?Q?5r8pnJiGfJGwouA58S96MRzJhO+Aq6sL/QPcoZVbbNxjuNLaf5QW94J5F7yk?=
 =?us-ascii?Q?4V2cEBQQrWjlEvm04LA6xj/oxS4OiRSajR2f8xZ5itXKBCgajOzHlTphDjf1?=
 =?us-ascii?Q?QR4eLupcHfE5CkANhlTqWQy9NrM0Ii2YPKosOoEx565PBK5yvk8USk2RBTT6?=
 =?us-ascii?Q?nfEXf0lPlLWz4+mb3sXPSb36GNNPkxszKBlVKaD7gc2Pwk2qGZmqZDc6esLP?=
 =?us-ascii?Q?a+QHKdhO2So5beMcVpO8xNjwS5fJ8mXPF0EQwfXYpshcifIq+/qJw827Xa15?=
 =?us-ascii?Q?DlwcGmC3avDcQLjj7iZAUgSVTIcTItWGl0d2xeWqy0j7nCZbKiMH/noZBF5b?=
 =?us-ascii?Q?FhDhARfntOFy6AbICZWDA5FhPykwWRzyTT2rQpk5aEd+1Ki3gtflVC5V5ixy?=
 =?us-ascii?Q?1+GRQV9jFpFPdB+SBP0gXrHoNRV4hkyYrvyBHgHol908EivXLGncVKsvKwFV?=
 =?us-ascii?Q?scd/PGZ0Jb4/OjKNhhjEjBhvhVyk/s5mJ6VyVGQqfupaBIp9Ho62/hczgxcn?=
 =?us-ascii?Q?0AaM5/t4gNKw6U9uEJwLTLMcRUffLIf9yq9GI23rQJJeQjXYwIkRSloGmUF1?=
 =?us-ascii?Q?SiYMGBFKPF5VqEpKw8fc22ynQWiv9+zoZjqhZoChZUXNeHgOU+5yyhhlVaEc?=
 =?us-ascii?Q?2zyIx3mziEiI9IxKGFgFuLbuyCQhShkLF56f1lX97yKgA/HusnK2EM0IAGmH?=
 =?us-ascii?Q?b2edsFFNtGYwwdsjnigKZZv0+YHqh13Dc1l7FEfwCGJ2cufoZQrFPJhV1GLE?=
 =?us-ascii?Q?sxLI8EDlfXCD74cOrS9BzWJ5jLUpxjFHrvnkcuh9TlU49Y1776tj74R8GDgQ?=
 =?us-ascii?Q?/F0ZYPYyvL5uV5eycCa9Vo0V?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ed7f31d-bdfc-46e1-8bb8-08d8f3b30190
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4732.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2021 19:35:42.5459 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YV3aPusx2+bRxbMZGj/kRp40gpZ1/MJ2CnHkw849GDeXZRjc7I+7e6WGJ9ZJyRW7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3787
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
Cc: felix.kuehling@amd.com, lijo.lazar@amd.com, christian.koenig@amd.com,
 Oak Zeng <Oak.Zeng@amd.com>, hawking.zhang@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This new interface passes both virtual and physical address
to PSP. It is backword compatible with old interface.

v2: use a macro to simply tmr physical address calc (Lijo)

Signed-off-by: Oak Zeng <Oak.Zeng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 12 +++++++++---
 drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h | 11 ++++++++++-
 2 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index c555fa7..77a9dd1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -328,8 +328,12 @@ psp_cmd_submit_buf(struct psp_context *psp,
 
 static void psp_prep_tmr_cmd_buf(struct psp_context *psp,
 				 struct psp_gfx_cmd_resp *cmd,
-				 uint64_t tmr_mc, uint32_t size)
+				 uint64_t tmr_mc, struct amdgpu_bo *tmr_bo)
 {
+	struct amdgpu_device *adev = psp->adev;
+	uint32_t size = amdgpu_bo_size(tmr_bo);
+	uint64_t tmr_pa = amdgpu_gmc_gpu_pa(adev, tmr_bo);
+
 	if (amdgpu_sriov_vf(psp->adev))
 		cmd->cmd_id = GFX_CMD_ID_SETUP_VMR;
 	else
@@ -337,6 +341,9 @@ static void psp_prep_tmr_cmd_buf(struct psp_context *psp,
 	cmd->cmd.cmd_setup_tmr.buf_phy_addr_lo = lower_32_bits(tmr_mc);
 	cmd->cmd.cmd_setup_tmr.buf_phy_addr_hi = upper_32_bits(tmr_mc);
 	cmd->cmd.cmd_setup_tmr.buf_size = size;
+	cmd->cmd.cmd_setup_tmr.bitfield.virt_phy_addr = 1;
+	cmd->cmd.cmd_setup_tmr.system_phy_addr_lo = lower_32_bits(tmr_pa);
+	cmd->cmd.cmd_setup_tmr.system_phy_addr_hi = upper_32_bits(tmr_pa);
 }
 
 static void psp_prep_load_toc_cmd_buf(struct psp_gfx_cmd_resp *cmd,
@@ -456,8 +463,7 @@ static int psp_tmr_load(struct psp_context *psp)
 	if (!cmd)
 		return -ENOMEM;
 
-	psp_prep_tmr_cmd_buf(psp, cmd, psp->tmr_mc_addr,
-			     amdgpu_bo_size(psp->tmr_bo));
+	psp_prep_tmr_cmd_buf(psp, cmd, psp->tmr_mc_addr, psp->tmr_bo);
 	DRM_INFO("reserve 0x%lx from 0x%llx for PSP TMR\n",
 		 amdgpu_bo_size(psp->tmr_bo), psp->tmr_mc_addr);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h b/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h
index dd4d65f..96064c3 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h
+++ b/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h
@@ -185,10 +185,19 @@ struct psp_gfx_cmd_setup_tmr
     uint32_t        buf_phy_addr_lo;       /* bits [31:0] of GPU Virtual address of TMR buffer (must be 4 KB aligned) */
     uint32_t        buf_phy_addr_hi;       /* bits [63:32] of GPU Virtual address of TMR buffer */
     uint32_t        buf_size;              /* buffer size in bytes (must be multiple of 4 KB) */
+    union {
+	struct {
+		uint32_t	sriov_enabled:1; /* whether the device runs under SR-IOV*/
+		uint32_t	virt_phy_addr:1; /* driver passes both virtual and physical address to PSP*/
+		uint32_t	reserved:30;
+	} bitfield;
+	uint32_t        tmr_flags;
+    };
+    uint32_t        system_phy_addr_lo;        /* bits [31:0] of system physical address of TMR buffer (must be 4 KB aligned) */
+    uint32_t        system_phy_addr_hi;        /* bits [63:32] of system physical address of TMR buffer */
 
 };
 
-
 /* FW types for GFX_CMD_ID_LOAD_IP_FW command. Limit 31. */
 enum psp_gfx_fw_type {
 	GFX_FW_TYPE_NONE        = 0,    /* */
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
