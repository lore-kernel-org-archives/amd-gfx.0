Return-Path: <SRS0=Dt/2=AZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3AB1C433DF
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2020 02:29:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA6FE20773
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2020 02:29:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="IQQYMNet"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA6FE20773
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CEFBE6E890;
	Tue, 14 Jul 2020 02:29:32 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2085.outbound.protection.outlook.com [40.107.237.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED8766E88D
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2020 02:29:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AlsKpm23KCbDSK0fEDF6ziLdnAlUqYVXxjiXbPEBa/FqcrVDD303G+zD62Mw4lAkhkRC/0lorKReDuQfeUZ3HDfgDYRFC8VSjJEKi87E1vCQd1TgeG6+FHd5duAaBR4hYWAwqCvd2w7QnmdSRKxB4mzsPzBKa9t2cEqGhaqgceJq9tc835sBXxuHMwdVpbSx9NTndnkvTEywgQBcPPfau6rAxjBEI5sxA6uTdh6Hmgnos2iaYFh1r9TclfLqyM+P8RnK9ipjOtz205wXtdX4HyZqckydw9H90ugimtIkqSasx1Z/P3UoMKj0gosflKCl3gbSrss4lBMlGidPxh56UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aHltCik/saG/9Wf7xt9hkopefQkVUjRaK3ugodPG8SM=;
 b=e1YNZSB7Si0bkOwhi9ZZ2Z3bk3nYId1ajZ9Jz1azRRjyQznyA7cmGj6DWgD7DLcQsKwgTVGkA3Vxl4fgkzc1qGxc+G2ALm32jc17Am91KXQaXqMLSjn2mY6GRveoTdcZCAcCYS00qFz3kKkswfEm89ZF7LjvvEXsTe9F9B8TuQUlvH/UXgAEKRyHi1fv9E6GI1+QaiZebbzUEF3ar6yRT2r43HcU8BUOUZ73Z0G3klwZUCMpedm6oaFu/CnzHmzuRzWnwZJzvaAOHPDBG/rJeZ7VV0DD7RFzd8XAnlaTZ7lcY3k94ZFARmCArtTaDCbiyGWBS8nzJ1keIlNomSS26w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aHltCik/saG/9Wf7xt9hkopefQkVUjRaK3ugodPG8SM=;
 b=IQQYMNetdEvJHnCVcdsSHcb8J85w0hULGHmCH3Okxv1bV6A/6zriW0HK/5vr9gY0h1vhflMJhoK+S1iBxc0y8xeDBpnXV33M0EGOXtO+mhT/hegi/pArPkS7yk1VXJqqhbGKod2RmN4XywLOMxOZ5nN7BHmg/id4BVe4E316nHU=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4101.namprd12.prod.outlook.com (2603:10b6:610:a8::22)
 by CH2PR12MB4232.namprd12.prod.outlook.com (2603:10b6:610:a4::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21; Tue, 14 Jul
 2020 02:29:29 +0000
Received: from CH2PR12MB4101.namprd12.prod.outlook.com
 ([fe80::b9c2:5b76:382a:c5d]) by CH2PR12MB4101.namprd12.prod.outlook.com
 ([fe80::b9c2:5b76:382a:c5d%8]) with mapi id 15.20.3174.025; Tue, 14 Jul 2020
 02:29:29 +0000
From: Wenhui Sheng <Wenhui.Sheng@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/4] drm/amdgpu: enable mode1 reset
Date: Tue, 14 Jul 2020 10:29:10 +0800
Message-Id: <20200714022911.3006-3-Wenhui.Sheng@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200714022911.3006-1-Wenhui.Sheng@amd.com>
References: <20200714022911.3006-1-Wenhui.Sheng@amd.com>
X-ClientProxiedBy: HKAPR03CA0007.apcprd03.prod.outlook.com
 (2603:1096:203:c8::12) To CH2PR12MB4101.namprd12.prod.outlook.com
 (2603:10b6:610:a8::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from HUI.amd.com (58.247.170.242) by
 HKAPR03CA0007.apcprd03.prod.outlook.com (2603:1096:203:c8::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3195.9 via Frontend Transport; Tue, 14 Jul 2020 02:29:27 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 858af629-a7a5-4931-9de8-08d8279dbbf6
X-MS-TrafficTypeDiagnostic: CH2PR12MB4232:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB423207CFDA6BA1700BEC150F8C610@CH2PR12MB4232.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ksiyzLQZKwniS/8gyiZXwSx1RmWoUXd7CitC2vHmeZgKDmr0iLioK7XrzL+NvmbaM5BmKRc3UNxoT84jXYLHvX5B0gXTzZrxHB4NGBRprsD55d6XlRtmt4fWXV5fzWoJZYg4h0GB5caOf2UfXao4EyKdcH8wjyxvWj6ZGzeXz8yJvfF/77lN4dlwLRtw/SetduoFuGEw64rRDnBqFIf+zgrD12F+NNFbHoJZRTkREHEeYwUWFmJDM+EKZ2r9PAOikLuBEmh4JfwC/SZLGEtMgRVdjHCZhRQPjDEcrLDk1r/jnilHKP1xDsl+2o8F41VC
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(366004)(136003)(346002)(376002)(396003)(16526019)(2616005)(2906002)(5660300002)(52116002)(26005)(54906003)(478600001)(8676002)(186003)(956004)(6666004)(1076003)(6486002)(66946007)(66476007)(66556008)(316002)(4326008)(7696005)(83380400001)(8936002)(86362001)(6916009)(36756003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: tB+0h7mQDuIB63sakY9ML533JAuXTZvzzNPZB8Esk10rIki+wirgi2HO17g+zJVtDJAhttVxeJgWdS7fb0F/5YzGApYoX61uyt9CiFKnaAQrgVErD96mc8lrY9J2jbW8zLHtmAhnG1GvlCOjEEQSDMD0zZEMNjGdBM0vHReKmCOilh7q0iuDoJ6L9F8cXdxjKSrOErp5LlvGP/tbJ6VEWeWiHYP3Jm8ioaqzezPd9G431XDmdGakzk9zTy5Mdc0CLEoIjl9BJAqY7CAYjqTrnpHTkFXXpZ5L+DU2wtvYaECKVyGgp45s8Ztbv5/FDrruAuuEyxOBiuZ6NDG6VbSHl7Jz4ZEAWJKxiiLZG64LUdL6U1vcRXrzR+yHHIgRh6FsNR2cVYH55ZVlwMl98rw1WEpYp2ooTulRWpuPa67JQKz7RwToA+aPx52nHS5Ve2DEXVZlxT/Adtpz1qzpJhwMdqS7Lvncw77HMjEEB4vdC+Z1nAPvh4mEwUJnzrlkrEJA
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 858af629-a7a5-4931-9de8-08d8279dbbf6
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2020 02:29:29.1607 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 035Vnks/eL1e/6noteoBCpWVFrquvG2FYkgoDm/HIQTBjlUlird7tSB950gbpZL7EsLJ0O65DGWthKbfMz3T8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4232
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
Cc: Likun Gao <Likun.Gao@amd.com>, Wenhui Sheng <Wenhui.Sheng@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

For sienna cichlid, add mode1 reset path for sGPU.

v2: hiding MP0/MP1 mode1 reset under AMD_RESET_METHOD_MODE1
v3: split emergency restart logic to a new patch

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Signed-off-by: Wenhui Sheng <Wenhui.Sheng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c               | 19 ++++++++++++-------
 drivers/gpu/drm/amd/powerplay/navi10_ppt.c    |  2 +-
 .../drm/amd/powerplay/sienna_cichlid_ppt.c    |  2 +-
 3 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 356849136d1d..9f1240bd0310 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -265,17 +265,21 @@ static int nv_asic_mode1_reset(struct amdgpu_device *adev)
 
 	amdgpu_atombios_scratch_regs_engine_hung(adev, true);
 
-	dev_info(adev->dev, "GPU mode1 reset\n");
-
 	/* disable BM */
 	pci_clear_master(adev->pdev);
 
 	pci_save_state(adev->pdev);
 
-	ret = psp_gpu_reset(adev);
+	if (amdgpu_dpm_is_mode1_reset_supported(adev)) {
+		dev_info(adev->dev, "GPU smu mode1 reset\n");
+		ret = amdgpu_dpm_mode1_reset(adev);
+	} else {
+		dev_info(adev->dev, "GPU psp mode1 reset\n");
+		ret = psp_gpu_reset(adev);
+	}
+
 	if (ret)
 		dev_err(adev->dev, "GPU mode1 reset failed\n");
-
 	pci_restore_state(adev->pdev);
 
 	/* wait for asic to come out of reset */
@@ -307,7 +311,7 @@ nv_asic_reset_method(struct amdgpu_device *adev)
 {
 	struct smu_context *smu = &adev->smu;
 
-	if (!amdgpu_sriov_vf(adev) && smu_baco_is_support(smu))
+	if (smu_baco_is_support(smu))
 		return AMD_RESET_METHOD_BACO;
 	else
 		return AMD_RESET_METHOD_MODE1;
@@ -319,15 +323,16 @@ static int nv_asic_reset(struct amdgpu_device *adev)
 	struct smu_context *smu = &adev->smu;
 
 	if (nv_asic_reset_method(adev) == AMD_RESET_METHOD_BACO) {
+		dev_info(adev->dev, "GPU BACO reset\n");
+
 		ret = smu_baco_enter(smu);
 		if (ret)
 			return ret;
 		ret = smu_baco_exit(smu);
 		if (ret)
 			return ret;
-	} else {
+	} else
 		ret = nv_asic_mode1_reset(adev);
-	}
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
index 4f7d064e16e4..014815bcae93 100644
--- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
@@ -2039,7 +2039,7 @@ static bool navi10_is_baco_supported(struct smu_context *smu)
 	struct amdgpu_device *adev = smu->adev;
 	uint32_t val;
 
-	if (!smu_v11_0_baco_is_support(smu))
+	if (amdgpu_sriov_vf(adev) || (!smu_v11_0_baco_is_support(smu)))
 		return false;
 
 	val = RREG32_SOC15(NBIO, 0, mmRCC_BIF_STRAP0);
diff --git a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
index cd8590aac85d..1949ec3e6b83 100644
--- a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
@@ -1761,7 +1761,7 @@ static bool sienna_cichlid_is_baco_supported(struct smu_context *smu)
 	struct amdgpu_device *adev = smu->adev;
 	uint32_t val;
 
-	if (!smu_v11_0_baco_is_support(smu))
+	if (amdgpu_sriov_vf(adev) || (!smu_v11_0_baco_is_support(smu)))
 		return false;
 
 	val = RREG32_SOC15(NBIO, 0, mmRCC_BIF_STRAP0);
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
