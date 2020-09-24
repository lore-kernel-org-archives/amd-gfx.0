Return-Path: <SRS0=YZDW=DB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF34EC4346E
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Sep 2020 04:10:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79A13206DB
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Sep 2020 04:10:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="dS946PL4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79A13206DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 11F0A6EA66;
	Thu, 24 Sep 2020 04:10:19 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2080.outbound.protection.outlook.com [40.107.220.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8FCE66EA66
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Sep 2020 04:10:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F8ugXeo7Ybeya3vc60t2tRsqUh/3FK0sx5T6ZD6Lj5ty9UrpBovngPvX/9/aX7zRkyV58EIAxoca8eJgx3+9AU4ZhBGe3zXQhyEdWQYWGe8Wm+xdWlG9E7dYqNkzY8ceeIYoaR5aNhNNLiNpfjhyIoZ0z2rNQxIwp92ArT7tmdDtwvksRzYtwLZuaWgKh2hLpi9MYAGMp86hVWpqARAsKcayJyN/l86l9PZuN/7Mh5nMRIlytoZ8k492LVEqT5oshVGj1XjDg17Vz3KL/R5MgVFx48YwjGj0e6xlF1wjYz6W90GLdV2h1o74PtA4Hf8wXMj6/ciKMwRg+3LbdP+tCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BAUs8CrEBnV/qWpudG5ji/d/PRAOZByDJfLV5fphb/8=;
 b=IAkvd250kDj/2GOB1k9nSHpbi4vakOBBhccjLTmbBIX3dGDn7sl/v6YFeWx40HPMzfPjnJtbeZuuLRpoJuLUirgdx8Y03a5UF3n3OdgTtHAkg12abfZvjYMpRolppoTylLMZMQH+X2GuyBaLmK7mnthboGNYLKCg6v8MuQU/n1LETWOML+FrZ8ew0dDbIKqgzw9lgePeQ6NNkE4ZpRsUQa6nk2BPqrqbwAvhbM4cgLReAL/CWVKhNWx1OH8OuAvjWCFn6e4+wP3sdtt8joUXdhWUQHlL9/QfCCK/Og5jjoQXGACgUhIq3bhlAYN+Bm8rkH4CIoyVsgF5aQ4Ahr6wJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BAUs8CrEBnV/qWpudG5ji/d/PRAOZByDJfLV5fphb/8=;
 b=dS946PL4oUwAtd25365FmTW6ItdKbbYoQnDO1Pp2rNSdb12Te6kysTENMoptcRU8oU2WNyxLWRQ8Mwl4qxAf8TBLIGh0e0P1JEB7LoSPkMHkWQ2gaqIDQIlfXdaHDS8JbAsrJj4VlnTskk5QbTVAQiCBTKTVWcxCWpdlGvbnPYY=
Received: from DM5PR04CA0069.namprd04.prod.outlook.com (2603:10b6:3:ef::31) by
 SA0PR12MB4525.namprd12.prod.outlook.com (2603:10b6:806:92::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3412.21; Thu, 24 Sep 2020 04:10:16 +0000
Received: from DM6NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:ef:cafe::d6) by DM5PR04CA0069.outlook.office365.com
 (2603:10b6:3:ef::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20 via Frontend
 Transport; Thu, 24 Sep 2020 04:10:15 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM6NAM11FT060.mail.protection.outlook.com (10.13.173.63) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3412.21 via Frontend Transport; Thu, 24 Sep 2020 04:10:15 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 23 Sep
 2020 23:10:14 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 23 Sep
 2020 23:10:14 -0500
Received: from emiy-Z10PA-U8-Series.amd.com (10.180.168.240) by
 SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Wed, 23 Sep 2020 23:10:13 -0500
From: Emily.Deng <Emily.Deng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Remove some useless code
Date: Thu, 24 Sep 2020 12:10:10 +0800
Message-ID: <20200924041010.4036-1-Emily.Deng@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7c866fea-753c-495f-174b-08d8603fbdd0
X-MS-TrafficTypeDiagnostic: SA0PR12MB4525:
X-Microsoft-Antispam-PRVS: <SA0PR12MB45251821A2E3BD8C5572438D8F390@SA0PR12MB4525.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0JAz7Vret0buH8SFwvOgqXjWN6HDRssfZPvtVXNf3TFoopTa+uQRPNTOaktlK4b7xfzTS8DjsJ9Hx1mwCcil77g4RMrXM//ht24kxOQK8d9sk8gUUC/MkhDhpqmQipW38epN0puoTKupPHXcLutLTAlGoLPFOSHwB952beKTINQtDFWb7BTV1V0AGe1klM5ra8+JB/dMhqLvXQbly870DM7wZBz3PF636KqXNbfyEr/q0fsorBSVKh/kWxfj3qlDSeS0TRSlFjmSmzzFdZ3spwtArGxqymaqussEY4Zz+HykKXua4nOoGZdsfJThIArnxO+tSKMInd+S8bxKw0NERLnTUWMD8hZT9q1kdNc2n2vmTOirPm1WPZj1q7AMVVsVly2h41fUo8vll9NmiR6iDQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(346002)(39860400002)(136003)(376002)(46966005)(70586007)(36756003)(70206006)(81166007)(186003)(47076004)(83380400001)(82310400003)(6916009)(356005)(82740400003)(86362001)(2906002)(1076003)(8676002)(5660300002)(316002)(4326008)(478600001)(8936002)(426003)(7696005)(26005)(336012)(2616005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2020 04:10:15.5853 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c866fea-753c-495f-174b-08d8603fbdd0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4525
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
Cc: "Emily.Deng" <Emily.Deng@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Signed-off-by: Emily.Deng <Emily.Deng@amd.com>
Change-Id: I1a14dcc6f2d5395b2c385f4f290494ce7de108b4
---
 drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c            |  5 -----
 drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c             |  5 -----
 drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h             | 13 -------------
 .../gpu/drm/amd/pm/powerplay/smumgr/smu9_smumgr.c   |  7 -------
 4 files changed, 30 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
index b882ac59879a..0905d6397972 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
@@ -153,11 +153,6 @@ static void gfxhub_v2_0_init_system_aperture_regs(struct amdgpu_device *adev)
 	uint64_t value;
 
 	if (!amdgpu_sriov_vf(adev)) {
-		/*
-		 * the new L1 policy will block SRIOV guest from writing
-		 * these regs, and they will be programed at host.
-		 * so skip programing these regs.
-		 */
 		/* Disable AGP. */
 		WREG32_SOC15(GC, 0, mmGCMC_VM_AGP_BASE, 0);
 		WREG32_SOC15(GC, 0, mmGCMC_VM_AGP_TOP, 0);
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
index 2d88278c50bf..5241fa991248 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
@@ -201,11 +201,6 @@ static void mmhub_v2_0_init_system_aperture_regs(struct amdgpu_device *adev)
 	WREG32_SOC15(MMHUB, 0, mmMMMC_VM_AGP_BOT, 0x00FFFFFF);
 
 	if (!amdgpu_sriov_vf(adev)) {
-		/*
-		 * the new L1 policy will block SRIOV guest from writing
-		 * these regs, and they will be programed at host.
-		 * so skip programing these regs.
-		 */
 		/* Program the system aperture low logical page number. */
 		WREG32_SOC15(MMHUB, 0, mmMMMC_VM_SYSTEM_APERTURE_LOW_ADDR,
 			     adev->gmc.vram_start >> 18);
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h b/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h
index cbc04a5c0fe1..1ef2f5b1d828 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h
+++ b/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h
@@ -83,19 +83,6 @@ struct psp_gfx_ctrl
 */
 #define GFX_FLAG_RESPONSE               0x80000000
 
-/* Gbr IH registers ID */
-enum ih_reg_id {
-	IH_RB		= 0,		// IH_RB_CNTL
-	IH_RB_RNG1	= 1,		// IH_RB_CNTL_RING1
-	IH_RB_RNG2	= 2,		// IH_RB_CNTL_RING2
-};
-
-/* Command to setup Gibraltar IH register */
-struct psp_gfx_cmd_gbr_ih_reg {
-	uint32_t		reg_value;	/* Value to be set to the IH_RB_CNTL... register*/
-	enum ih_reg_id		reg_id;		/* ID of the register */
-};
-
 /* TEE Gfx Command IDs for the ring buffer interface. */
 enum psp_gfx_cmd_id
 {
diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/smu9_smumgr.c b/drivers/gpu/drm/amd/pm/powerplay/smumgr/smu9_smumgr.c
index adfbcbe5d113..8a9aee85043e 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/smu9_smumgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/smu9_smumgr.c
@@ -61,9 +61,6 @@ static uint32_t smu9_wait_for_response(struct pp_hwmgr *hwmgr)
 	uint32_t reg;
 	uint32_t ret;
 
-	/* Due to the L1 policy problem under SRIOV, we have to use
-	 * mmMP1_SMN_C2PMSG_103 as the driver response register
-	 */
 	if (hwmgr->pp_one_vf) {
 		reg = SOC15_REG_OFFSET(MP1, 0, mmMP1_SMN_C2PMSG_103);
 
@@ -148,10 +145,6 @@ int smu9_send_msg_to_smc_with_parameter(struct pp_hwmgr *hwmgr,
 
 	smu9_wait_for_response(hwmgr);
 
-	/* Due to the L1 policy problem under SRIOV, we have to use
-	 * mmMP1_SMN_C2PMSG_101 as the driver message register and
-	 * mmMP1_SMN_C2PMSG_102 as the driver parameter register.
-	 */
 	if (hwmgr->pp_one_vf) {
 		WREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_103, 0);
 		WREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_102, parameter);
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
