Return-Path: <SRS0=0vKA=BN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49586C433E0
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Aug 2020 04:47:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F3AA20719
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Aug 2020 04:47:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="YoYZKI3i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F3AA20719
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 578946E113;
	Mon,  3 Aug 2020 04:47:24 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2061.outbound.protection.outlook.com [40.107.244.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0FD006E113
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Aug 2020 04:47:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KBgzU4yhLBrvIHE4wbbtUBLl0CYqfRzhyif7dL7L6oSuRPAnsYnlMPrpWe1V6T0b4Aq7Uwr38+4RBOUdoTjcleOCH+0dkVzuz4o6SL+Xluvps1ByVMO00bfU0G7c1pt9Aea2uSlndAKl3tookYhbX7ymXBH/ZALF6Mthwet0ILWt+FUTtd/DcBClvnDw+yycmQx9dsDM1NsItjCu9S47maaj9uzI8chytEiDowr/iDYQY7K14NkDnF/hClUbCmGSEeUaNr55OwJzeVjtilD5ykP1QL/o5ixxvGH5fKWTajkn09EXTW4RpQj0mH3XUw0Ecaq3iLlQgTFn4CCevXxM2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fFrik2c10tiT3JKwDZknsOWO1cDMcut+g2YClXD8gj4=;
 b=BhctZ4IEdbYED3Q+hUnbmgfL9yO9L6Y7oLyebu1jqU4BxinDcKzeMz6VZjqq/sgrLSfUyqJZumhhDn8nH1JiYcON8GYlXfb59wSTWbjSQxe4wj+itLU54wfk7gSkRzFlMzLaDFNNfeEWICKLBAxpiV1G5A1SmZoasicG92RnrqK6nVdI0utjhimdSC7TlBrU10+i+irhJabS0maR6flkIWzmAkpg1p8mhkTfVj+xVH3ct/XvX1aO6C4QHtCPMb4fvzJOWawDxadPTaL1NcOY+PrA/BtjWz7JD81woneWAf5flZBpa60HyBjZCKt5oCGsh2sFFUzqWlOAAkQh4HkwZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fFrik2c10tiT3JKwDZknsOWO1cDMcut+g2YClXD8gj4=;
 b=YoYZKI3iL9Rx4knt91OHMWUSyPLSmjfxkVoKwBkSPyRiSbSKXiLX1hpQKhddirL7tfhmiYJGu9T1yagJ571bFo2Au+MrJm8ZLzFV6DunLlRoxn+NcGBgQKyEHYmAffYIkvvJWD+dBx4VdQD12y4FAgk9D6lDLlIb1LKuHBEoW/o=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR1201MB0218.namprd12.prod.outlook.com (2603:10b6:4:4d::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3239.20; Mon, 3 Aug 2020 04:47:22 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::fcd0:74a:b9d0:6b66]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::fcd0:74a:b9d0:6b66%2]) with mapi id 15.20.3239.021; Mon, 3 Aug 2020
 04:47:22 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amd/powerplay: put VCN/JPEG into PG ungate state
 before dpm table setup
Date: Mon,  3 Aug 2020 12:46:48 +0800
Message-Id: <20200803044648.28805-2-evan.quan@amd.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200803044648.28805-1-evan.quan@amd.com>
References: <20200803044648.28805-1-evan.quan@amd.com>
X-ClientProxiedBy: HKAPR04CA0007.apcprd04.prod.outlook.com
 (2603:1096:203:d0::17) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HKAPR04CA0007.apcprd04.prod.outlook.com (2603:1096:203:d0::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3239.17 via Frontend Transport; Mon, 3 Aug 2020 04:47:20 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8ac9c001-43ee-4f7c-bad3-08d837684f34
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0218:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB021894BFD551902CFFD11C8CE44D0@DM5PR1201MB0218.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:989;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iy7lxuyWQHIDo6NC4mzzi5e61/o+TOg7ZpxSB+FayAg/XOa4/C9TTQDyWFR+yDFjjSbuYwjM/wHz/OXadi3tO7X3nYw6Xu/AdxCPW7bnJJesfFc8GlgLMFp1/CXHxe//76kWOBRic2FShXSBc4cMDVI8VRJZ0zmk3vv+zKQqKSf+3RS0K17NjYUopwZJG3mAV6EZgpf1fgJsV4a1sLxvCJdHpVicq1ieIGlVuqGp9HhVa/O4LSv9RyDrRWpjBAqyF9E809L0VqIX7ZvRj76ZepZ/CkDStw+YGDNRcoL5uZ4KgrPaSWYMyVe3mdwvmEiO
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(396003)(39860400002)(376002)(366004)(346002)(44832011)(86362001)(2616005)(1076003)(6666004)(956004)(2906002)(83380400001)(8676002)(26005)(6916009)(6486002)(8936002)(36756003)(7696005)(66476007)(5660300002)(186003)(316002)(52116002)(66946007)(66556008)(4326008)(16526019)(478600001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 0ITg5J9dnbpuxJQjIDP0TAdo4daMcnLlZLhTMOcdQ+XB6B3Lcu52DGjvt0W+H4ub8T6geskz2E4F5OZKGDJu6uHLfxHE3YF+yX4+gPJ9jYyGI0Fjcjue1XJfe6+Wpiqj2MbftFtLfPGPJCVVB6FeKOhtYKAhYXI83ZKR5tjTcNc9JjsqD8aXAPv4ytc5suFx6cJjCJKaxwi39Xb+1dvAcYoqsHXImcKvn4x1SJKqK1OyrSFabJYQb52RFfVYp7pK7rn7jOlStkYJBUEC4INHUjHGk1xpmLYPXMTKzx8eqEm/n/DuuJVvKLdHwZ/UNC6g9FupLiTri8d793ufj5Bx5+AAMDOWBacf4ohV+6I7QG8quDFx+cv1j8YJNBecHdbAMdFTri8UEqUv7LHzFAQ6uPNUOKUWTEzkTlYnQmticeg1zZKc76MujsdUGKqQD8V+js1hdscZZPzFdF3SlyMdmExibFeM4VmrpDPLLfbOfhAeBRr9rfNMFjXQXM5pQ/4brK+9SL0iQYqrIGo0Jn0CYm1fhxhUia9CIngoPc0+uVfnjCQPXr1yMIkyJN+HNE62Ojic13qW6gUF8NTu/GnRwr3yj5La21dF+A4HmAqe1zIzPBNxXZwX43zjwkI2WI3jsxxpZRU6pHeckS9kQfxE9A==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ac9c001-43ee-4f7c-bad3-08d837684f34
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2020 04:47:22.0695 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XPBgPK0mvCSwISiS0BIzlujCX0BbFsFXxoi9j98wX/vFMsI7lMA4pm5k2H5uzJqc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0218
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
Cc: alexander.deucher@amd.com, mcoffin13@gmail.com,
 Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

As VCN related dpm table setup needs VCN be in PG ungate state. Same logics
applies to JPEG.

Change-Id: I94335efc4e0424cfe0991e984c938998fd8f1287
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c | 38 +++++++++++++++++-----
 1 file changed, 30 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
index 85b04c48bd09..1349d05c5f3d 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -134,7 +134,8 @@ int smu_get_dpm_freq_range(struct smu_context *smu,
 }
 
 static int smu_dpm_set_vcn_enable(struct smu_context *smu,
-				  bool enable)
+				  bool enable,
+				  int *previous_pg_state)
 {
 	struct smu_power_context *smu_power = &smu->smu_power;
 	struct smu_power_gate *power_gate = &smu_power->power_gate;
@@ -148,6 +149,9 @@ static int smu_dpm_set_vcn_enable(struct smu_context *smu,
 	if (atomic_read(&power_gate->vcn_gated) ^ enable)
 		goto out;
 
+	if (previous_pg_state)
+		*previous_pg_state = atomic_read(&power_gate->vcn_gated);
+
 	ret = smu->ppt_funcs->dpm_set_vcn_enable(smu, enable);
 	if (!ret)
 		atomic_set(&power_gate->vcn_gated, !enable);
@@ -159,7 +163,8 @@ static int smu_dpm_set_vcn_enable(struct smu_context *smu,
 }
 
 static int smu_dpm_set_jpeg_enable(struct smu_context *smu,
-				   bool enable)
+				   bool enable,
+				   int *previous_pg_state)
 {
 	struct smu_power_context *smu_power = &smu->smu_power;
 	struct smu_power_gate *power_gate = &smu_power->power_gate;
@@ -173,6 +178,9 @@ static int smu_dpm_set_jpeg_enable(struct smu_context *smu,
 	if (atomic_read(&power_gate->jpeg_gated) ^ enable)
 		goto out;
 
+	if (previous_pg_state)
+		*previous_pg_state = atomic_read(&power_gate->jpeg_gated);
+
 	ret = smu->ppt_funcs->dpm_set_jpeg_enable(smu, enable);
 	if (!ret)
 		atomic_set(&power_gate->jpeg_gated, !enable);
@@ -212,7 +220,7 @@ int smu_dpm_set_power_gate(struct smu_context *smu, uint32_t block_type,
 	 */
 	case AMD_IP_BLOCK_TYPE_UVD:
 	case AMD_IP_BLOCK_TYPE_VCN:
-		ret = smu_dpm_set_vcn_enable(smu, !gate);
+		ret = smu_dpm_set_vcn_enable(smu, !gate, NULL);
 		if (ret)
 			dev_err(smu->adev->dev, "Failed to power %s VCN!\n",
 				gate ? "gate" : "ungate");
@@ -230,7 +238,7 @@ int smu_dpm_set_power_gate(struct smu_context *smu, uint32_t block_type,
 				gate ? "gate" : "ungate");
 		break;
 	case AMD_IP_BLOCK_TYPE_JPEG:
-		ret = smu_dpm_set_jpeg_enable(smu, !gate);
+		ret = smu_dpm_set_jpeg_enable(smu, !gate, NULL);
 		if (ret)
 			dev_err(smu->adev->dev, "Failed to power %s JPEG!\n",
 				gate ? "gate" : "ungate");
@@ -407,6 +415,7 @@ static int smu_late_init(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 	struct smu_context *smu = &adev->smu;
+	int vcn_gate, jpeg_gate;
 	int ret = 0;
 
 	if (!smu->pm_enabled)
@@ -418,6 +427,14 @@ static int smu_late_init(void *handle)
 		return ret;
 	}
 
+	/*
+	 * 1. Power up VCN/JPEG as the succeeding smu_set_default_dpm_table()
+	 *    needs VCN/JPEG up.
+	 * 2. Save original gate states and then we can restore back afterwards.
+	 */
+	smu_dpm_set_vcn_enable(smu, true, &vcn_gate);
+	smu_dpm_set_jpeg_enable(smu, true, &jpeg_gate);
+
 	/*
 	 * Set initialized values (get from vbios) to dpm tables context such as
 	 * gfxclk, memclk, dcefclk, and etc. And enable the DPM feature for each
@@ -429,6 +446,11 @@ static int smu_late_init(void *handle)
 		return ret;
 	}
 
+	/* Restore back to original VCN/JPEG power gate states */
+	smu_dpm_set_vcn_enable(smu, !vcn_gate, NULL);
+	smu_dpm_set_jpeg_enable(smu, !vcn_gate, NULL);
+
+
 	ret = smu_populate_umd_state_clk(smu);
 	if (ret) {
 		dev_err(adev->dev, "Failed to populate UMD state clocks!\n");
@@ -991,8 +1013,8 @@ static int smu_hw_init(void *handle)
 
 	if (smu->is_apu) {
 		smu_powergate_sdma(&adev->smu, false);
-		smu_dpm_set_vcn_enable(smu, true);
-		smu_dpm_set_jpeg_enable(smu, true);
+		smu_dpm_set_vcn_enable(smu, true, NULL);
+		smu_dpm_set_jpeg_enable(smu, true, NULL);
 		smu_set_gfx_cgpg(&adev->smu, true);
 	}
 
@@ -1132,8 +1154,8 @@ static int smu_hw_fini(void *handle)
 
 	if (smu->is_apu) {
 		smu_powergate_sdma(&adev->smu, true);
-		smu_dpm_set_vcn_enable(smu, false);
-		smu_dpm_set_jpeg_enable(smu, false);
+		smu_dpm_set_vcn_enable(smu, false, NULL);
+		smu_dpm_set_jpeg_enable(smu, false, NULL);
 	}
 
 	if (!smu->pm_enabled)
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
