Return-Path: <SRS0=xcSd=EJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B0C5C00A89
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Nov 2020 02:14:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 108D322243
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Nov 2020 02:14:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="VFiFHiim"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 108D322243
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C0E416E150;
	Tue,  3 Nov 2020 02:14:24 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750059.outbound.protection.outlook.com [40.107.75.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E169C6E150
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Nov 2020 02:14:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y1KeZAgKCnRzwSbQ9VsqB8cYL21bJPJ/JFebtqwID1PxnDmoA2qdmTnIaQXiTakUQ3uIkQ+ncjMHBN98C9+grKhaDILRyOZL4atE5fmDq0bs+cV3uRFxaq4wJ43xcprZKt+qVYhpQpPHI9HFcxj841Ckmg+8E4if1Rc7zZr3FoASY7pCLTulBSuoG0H9ifgWOPWwhk2D/kiDlNscFW3y/R3PffVRDZ55T504FafiACgKEoE7NjTXazvn9WATbw4a8UvDREPpLXtUbmc++3qZoCfWW5D5/6RPbZqOLbKQfEFkj/ChOGKmfqBGfNO/SNlntDIvGwQ9KQU+pFQNgq2Rzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ahah9tuWzpeDgtJ5h8QiT/twtE7NROC+h4aSmeyYag4=;
 b=DRx31TvhQkKPBijQ8/FEczOfI8w1RbcSyGKEDRp3bsqDEI7Yi/PK/Ofg/dFL+GcuUSbBpCNjB4ZqUIrRS6UG22Xd48mcWdXV1uhdxKI9Q2Eem7KnoLavQGd/0d9tdxLepaArd5nkA9NZ+ow+tqyAJlY4u8aCu0tS3k71RJXuYmne3opNRaJ/COMMPMZLkOhJ/q5lPg8W/kvy0VKEKu/PYtUt4ISzpV/VK6m7TIFWOA24mjLOlZ5dIP4NcQR7TEFE/9jy5tLjBCiTDjyhNfb8vx+zL3uxkxsBV5+y2qfrjSQ1/N4h8F+6e6JWhMIgh3WYmhylLud1GLo4A1RopLCfgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ahah9tuWzpeDgtJ5h8QiT/twtE7NROC+h4aSmeyYag4=;
 b=VFiFHiimqQPD81162v5YAkXgFCbLtinvRLS9qUwbU+dnm2EuLkoz6qFoyWdS7hzWNnHrsFeIr8072a8IY1QqvYKGhMT5Jnw6NdnflcE7ZrtWqXXgFalMWXizJ7HZGW0g7HZCJYYu9t4sI6e+hEwgxnXFed5dKN8yX2SenpomnJw=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3467.namprd12.prod.outlook.com (2603:10b6:5:3c::10) by
 DM6PR12MB4433.namprd12.prod.outlook.com (2603:10b6:5:2a1::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.18; Tue, 3 Nov 2020 02:14:21 +0000
Received: from DM6PR12MB3467.namprd12.prod.outlook.com
 ([fe80::791c:a3f1:47ad:902e]) by DM6PR12MB3467.namprd12.prod.outlook.com
 ([fe80::791c:a3f1:47ad:902e%4]) with mapi id 15.20.3499.030; Tue, 3 Nov 2020
 02:14:21 +0000
From: "Jinzhou.Su" <Jinzhou.Su@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: Add Fine Grain Clock Gating
Date: Tue,  3 Nov 2020 10:14:01 +0800
Message-Id: <20201103021401.7554-1-Jinzhou.Su@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [58.247.170.242]
X-ClientProxiedBy: HK2PR02CA0151.apcprd02.prod.outlook.com
 (2603:1096:201:1f::11) To DM6PR12MB3467.namprd12.prod.outlook.com
 (2603:10b6:5:3c::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jinzhosu-System-Product-Name.amd.com (58.247.170.242) by
 HK2PR02CA0151.apcprd02.prod.outlook.com (2603:1096:201:1f::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.18 via Frontend Transport; Tue, 3 Nov 2020 02:14:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3e59fbf1-f48a-4481-c322-08d87f9e2cf5
X-MS-TrafficTypeDiagnostic: DM6PR12MB4433:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB44330016CDB5380F957B48F290110@DM6PR12MB4433.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G28b20aTASVHX6ezYMtyP1rORuaEEzgAxXJ8Xe1NBa8NM84nhYo/be0QcgW6R0wdF1LryDZ0dCgwK1vR6uiRHWCi3xYMpaqa7beRAu8WlJzmw5RqXPmmTQtyrKluTbJ94iZaTKoZFDhC+OttJJq2Nc6v/gC9LLg5cfLxGpWs6/fmH5bkYK2JELB5JggJTdk7tXtdj+StiZHMiNvLuqo3IuEtg8V/DnJ6UkCWqZ0JX686LsgAPY+NIIFfiJPca5NN7CQrzc1xUHIz1HxOXbVpxsVD+CJZLpPiIMYRxzVPo8S/XVD9aOEJfREbGTZLjWq8WC+iPtbV5jK/dy0Pl3L+sw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3467.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(366004)(346002)(376002)(136003)(186003)(16526019)(1076003)(956004)(83380400001)(2906002)(4326008)(478600001)(52116002)(26005)(2616005)(7696005)(6486002)(86362001)(5660300002)(8676002)(6916009)(8936002)(6666004)(66556008)(36756003)(316002)(66476007)(66946007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 1F2aLrhR0/8zB6D22geBdXyHNWSMLfsU5t6Q+6SFXesEO0sCFAnGYl/V7FghL+vYvu8fc9aTI8XLbxus8L7RdQfJdPCjSHYVuILUnyRnMWZcrKrYrl6ixT6a/l3vfsA352OQB3qjWXu4V84mmZ6vlmshMQyExeXDL+0Mwk7rD7KZdHBt5WqmSY/eTNNKg70L2+ByHpUA2oUdYopdiYjL/ORR1vt0JIg+33haDjgqslchjCzJE3ocaUwT0LV4sdZGtKKUcnX6lF6IszVYl6kdQ8rra0mF9HiLUGcZKXSVkoSpP8IrZf7ELvLdUz6J476Yejrgbm38NRmY2B1G4SuitD6MrLRNsl9BPOq18zuAufIYbE/nrfmKPoFRbZak2p3mFYFfAE4mJvtBkH9bCKeol2N0UZPqWdUKZX6zGsFUr6coJ5cQeKEZUO4n6cjk96JNDE2ao3RW2ynVn5IPG3sD0ByQS/1EwiDxoMQB+8hArCxhh3JcNWfPsZoN9h0BA3uyHcCYBUHisbr5mONg3Brvzt9zBHnppUC7jw/5cqXY82XSF0uRrOIRVn04y4DvHgTUxOPNhb0fTCA7CWU7f7bQyfAbqOWPMyUxCfx73qNHVAvd7k13jbYkJLvzk0srhdiwivGsAKznilzwBcKBba/HrA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e59fbf1-f48a-4481-c322-08d87f9e2cf5
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3467.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2020 02:14:21.1167 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y8+lz9zivzyjR3SsFDDbU7e2XxPN3wrLcCPcXvWgulzdu2ydR/3sN/HRK5lw4SYq+n2OTAozjHSqhyDvD0MqLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4433
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
Cc: "Jinzhou.Su" <Jinzhou.Su@amd.com>, ray.huang@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

1.Enable Fine Grain Clock Gating - SRAM(SW control) for Vangogh
2.Add FGCG flags on amdgpu_pm_info debugfs

Change-Id: I839a623fcc1a444c880d644035531435c0b0eeb6
Signed-off-by: Jinzhou.Su <Jinzhou.Su@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c   | 45 ++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/nv.c          |  1 +
 drivers/gpu/drm/amd/include/amd_shared.h |  1 +
 drivers/gpu/drm/amd/pm/amdgpu_pm.c       |  1 +
 4 files changed, 48 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index e4c69125805d..1ef738c35b4a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -7657,12 +7657,50 @@ static void gfx_v10_0_update_coarse_grain_clock_gating(struct amdgpu_device *ade
 	}
 }
 
+static void gfx_v10_0_update_fine_grain_clock_gating(struct amdgpu_device *adev,
+						      bool enable)
+{
+	uint32_t def, data;
+
+	if (enable && (adev->cg_flags & AMD_CG_SUPPORT_GFX_FGCG)) {
+		def = data = RREG32_SOC15(GC, 0, mmRLC_CGTT_MGCG_OVERRIDE);
+		/* unset FGCG override */
+		data &= ~RLC_CGTT_MGCG_OVERRIDE__GFXIP_FGCG_OVERRIDE_MASK;
+		/* update FGCG override bits */
+		if (def != data)
+			WREG32_SOC15(GC, 0, mmRLC_CGTT_MGCG_OVERRIDE, data);
+
+		def = data = RREG32_SOC15(GC, 0, mmRLC_CLK_CNTL);
+		/* unset RLC SRAM CLK GATER override */
+		data &= ~RLC_CLK_CNTL__RLC_SRAM_CLK_GATER_OVERRIDE_MASK;
+		/* update RLC SRAM CLK GATER override bits */
+		if (def != data)
+			WREG32_SOC15(GC, 0, mmRLC_CLK_CNTL, data);
+	} else {
+		def = data = RREG32_SOC15(GC, 0, mmRLC_CGTT_MGCG_OVERRIDE);
+		/* reset FGCG bits */
+		data |= RLC_CGTT_MGCG_OVERRIDE__GFXIP_FGCG_OVERRIDE_MASK;
+		/* disable FGCG*/
+		if (def != data)
+			WREG32_SOC15(GC, 0, mmRLC_CGTT_MGCG_OVERRIDE, data);
+
+		def = data = RREG32_SOC15(GC, 0, mmRLC_CLK_CNTL);
+		/* reset RLC SRAM CLK GATER bits */
+		data |= RLC_CLK_CNTL__RLC_SRAM_CLK_GATER_OVERRIDE_MASK;
+		/* disable RLC SRAM CLK*/
+		if (def != data)
+			WREG32_SOC15(GC, 0, mmRLC_CLK_CNTL, data);
+	}
+}
+
 static int gfx_v10_0_update_gfx_clock_gating(struct amdgpu_device *adev,
 					    bool enable)
 {
 	amdgpu_gfx_rlc_enter_safe_mode(adev);
 
 	if (enable) {
+		/* enable FGCG firstly*/
+		gfx_v10_0_update_fine_grain_clock_gating(adev, enable);
 		/* CGCG/CGLS should be enabled after MGCG/MGLS
 		 * ===  MGCG + MGLS ===
 		 */
@@ -7680,6 +7718,8 @@ static int gfx_v10_0_update_gfx_clock_gating(struct amdgpu_device *adev,
 		gfx_v10_0_update_3d_clock_gating(adev, enable);
 		/* ===  MGCG + MGLS === */
 		gfx_v10_0_update_medium_grain_clock_gating(adev, enable);
+		/* disable fgcg at last*/
+		gfx_v10_0_update_fine_grain_clock_gating(adev, enable);
 	}
 
 	if (adev->cg_flags &
@@ -7848,6 +7888,11 @@ static void gfx_v10_0_get_clockgating_state(void *handle, u32 *flags)
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 	int data;
 
+	/* AMD_CG_SUPPORT_GFX_FGCG */
+	data = RREG32_KIQ(SOC15_REG_OFFSET(GC, 0, mmRLC_CGTT_MGCG_OVERRIDE));
+	if (!(data & RLC_CGTT_MGCG_OVERRIDE__GFXIP_FGCG_OVERRIDE_MASK))
+		*flags |= AMD_CG_SUPPORT_GFX_FGCG;
+
 	/* AMD_CG_SUPPORT_GFX_MGCG */
 	data = RREG32_KIQ(SOC15_REG_OFFSET(GC, 0, mmRLC_CGTT_MGCG_OVERRIDE));
 	if (!(data & RLC_CGTT_MGCG_OVERRIDE__GFXIP_MGCG_OVERRIDE_MASK))
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 1f8659a1a4cf..e33d8022cc32 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -953,6 +953,7 @@ static int nv_common_early_init(void *handle)
 			AMD_CG_SUPPORT_GFX_3D_CGLS |
 			AMD_CG_SUPPORT_MC_MGCG |
 			AMD_CG_SUPPORT_MC_LS |
+			AMD_CG_SUPPORT_GFX_FGCG |
 			AMD_CG_SUPPORT_VCN_MGCG |
 			AMD_CG_SUPPORT_JPEG_MGCG;
 		adev->pg_flags = AMD_PG_SUPPORT_GFX_PG |
diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd/include/amd_shared.h
index 412602d84f71..e59501bde5d2 100644
--- a/drivers/gpu/drm/amd/include/amd_shared.h
+++ b/drivers/gpu/drm/amd/include/amd_shared.h
@@ -144,6 +144,7 @@ enum amd_powergating_state {
 #define AMD_CG_SUPPORT_ATHUB_LS			(1 << 28)
 #define AMD_CG_SUPPORT_ATHUB_MGCG		(1 << 29)
 #define AMD_CG_SUPPORT_JPEG_MGCG		(1 << 30)
+#define AMD_CG_SUPPORT_GFX_FGCG         (1 << 31)
 /* PG flags */
 #define AMD_PG_SUPPORT_GFX_PG			(1 << 0)
 #define AMD_PG_SUPPORT_GFX_SMG			(1 << 1)
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 080af05724ed..e57153d1fa24 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -39,6 +39,7 @@
 #include "hwmgr.h"
 
 static const struct cg_flag_name clocks[] = {
+	{AMD_CG_SUPPORT_GFX_FGCG, "Graphics Fine Grain Clock Gating"},
 	{AMD_CG_SUPPORT_GFX_MGCG, "Graphics Medium Grain Clock Gating"},
 	{AMD_CG_SUPPORT_GFX_MGLS, "Graphics Medium Grain memory Light Sleep"},
 	{AMD_CG_SUPPORT_GFX_CGCG, "Graphics Coarse Grain Clock Gating"},
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
