Return-Path: <SRS0=NsFz=AV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAA8BC433DF
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jul 2020 05:46:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AD952072E
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jul 2020 05:46:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="JHxsPm9S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AD952072E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 394016EB6B;
	Fri, 10 Jul 2020 05:46:44 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2046.outbound.protection.outlook.com [40.107.220.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 672056EB6B
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jul 2020 05:46:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NwugwTVKWGRAGitcGEBoxoHwgK5e+TqH5uMlSmGhubJT7GRsPnGoZ0rPELuhPKx0BefanAwhSIG9beKZf+ck4qrj+Uqvk/+TvdrA8njQLQBV/3tr63mCIurjfLn3Bwjwiv6t9PFzj1knWPhZE8rceXmhnj9rBSmk665CJG4rKlnl2sG7cNSSNn9C0Mp92aaGwrTWB1vhcH497NvJI4SVUK8cALgME3GbeWpTt4RBL1/CKgCqvmHZC/eMHDT+9bNKvEhjKC+KMzcKTkQV029d39Gn1VTwwiuRDiyTKaeL1w6lmIgx6Zu1MkeL3QBRMeLEy5ho/cq/SsOdvsrJSk9nLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EF1a9VEh73sQv6mdwwQGqyTSUwZB21Tw6C3VPDJPzzQ=;
 b=RV99xYy12BZ8QRhRmah4UiScJBwW6OfZNtI1m8Vmv/qz/FsMzRFX7fRp/fS+LeC1AZcseV90ZTM8azcRTpZzs+joyCryJLst/4ZGQdccePW5TKt8KOuZG7nYhsyyEjBxZ9tbEFs6IM73EcwcphZXntwelTr13eJVCXU5Yi4WrW7yQP7PSQHuITPUFEiG9PkDGCYnZb2fQpfXs/VJDAhjluojw6rmiRxPztVtJtgTtzz2ocqx3MQdr5ytgTTjgnoBYoyER/boz2shnp4DbMecpJpBBty346SAhObA8TcwnWhG24frAZAiXG66A8KYdWduYWoKPndJGxjLOBtfm51nOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EF1a9VEh73sQv6mdwwQGqyTSUwZB21Tw6C3VPDJPzzQ=;
 b=JHxsPm9Shxu2v1Vg9RBrElPNlWdljMWT87XKxKLMvjYJnC6hJl1qqfghwfNfUjEX4aPc6hf8EMzAa2quJm2sNpLrVianPnE2piQvEbOtdq3wWppCo+Rm1fBkVzRLUECCuq1XCJR1+jQlyVqNlKqgc1DqhpVBmObE5o9uZYyK8ZE=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4101.namprd12.prod.outlook.com (2603:10b6:610:a8::22)
 by CH2PR12MB4055.namprd12.prod.outlook.com (2603:10b6:610:78::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.22; Fri, 10 Jul
 2020 05:46:41 +0000
Received: from CH2PR12MB4101.namprd12.prod.outlook.com
 ([fe80::b9c2:5b76:382a:c5d]) by CH2PR12MB4101.namprd12.prod.outlook.com
 ([fe80::b9c2:5b76:382a:c5d%8]) with mapi id 15.20.3174.021; Fri, 10 Jul 2020
 05:46:41 +0000
From: Wenhui Sheng <Wenhui.Sheng@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/4] drm/amdgpu: add psp mode1 reset mode
Date: Fri, 10 Jul 2020 13:46:24 +0800
Message-Id: <20200710054626.2487-2-Wenhui.Sheng@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200710054626.2487-1-Wenhui.Sheng@amd.com>
References: <20200710054626.2487-1-Wenhui.Sheng@amd.com>
X-ClientProxiedBy: HK0PR01CA0056.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::20) To CH2PR12MB4101.namprd12.prod.outlook.com
 (2603:10b6:610:a8::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from HUI.amd.com (58.247.170.242) by
 HK0PR01CA0056.apcprd01.prod.exchangelabs.com (2603:1096:203:a6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.20 via Frontend
 Transport; Fri, 10 Jul 2020 05:46:40 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 991ef78d-40f8-4582-3ee3-08d824949efc
X-MS-TrafficTypeDiagnostic: CH2PR12MB4055:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB4055EB624C146D94BA32888E8C650@CH2PR12MB4055.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1824;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y1Dq1Y6N1vAYyPBN35Cd4zjXjbnx+r2bJYfDWS9XbEB1+L2/7ba2ddtKh0S8qDW2FXEXi4XGmjXkgi5jTtVVA6xtA0yeSC0XOgRvYU6lIgEqOwM+p/ifNVMJOIqmIf0uwo3PWN/AJDS/p9n7sOvp3PNhVoQqkgHXxWIt83nibBEie4cx7PcY/2rtHgjarT3jfY5xriF4KN3bqaXQ9lsiwDyi1Pjo/+J20AYgGkNcPRvWx20XwGUdjFw92XcqkwETnERmgje8d1HsvTH2wmwXNHLKV38K0iJURadu72bGjCFo1D0D6kp+TIHBAieucAEHedj5u0Qeky9dwMQukGtFJg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(39860400002)(346002)(136003)(366004)(396003)(83380400001)(2906002)(6916009)(8936002)(6486002)(8676002)(1076003)(186003)(16526019)(6666004)(956004)(26005)(86362001)(2616005)(36756003)(4326008)(66556008)(66946007)(316002)(54906003)(52116002)(7696005)(5660300002)(66476007)(478600001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: MSfX5zu1A+z8xhT4RCF5RMgighF/xN4EXIOJZz+XnDcpt/WESuhBN0RM9+LHQk6p65Vub1r8ylVVy4RS0Ewy7muJh/8K3Oo0DzGDLtruE3/1Gm+3VzWa8qsa6YP2Uc6e/9MYldjsgoyi61WNl0yiwrh8Ftr+fYa3OXT1XfEH8nDub9a6HRNTxndCHd0pi+VjZ3MfdSnBe+jGzyjfMOtb9psEon0EjRpRUctO9t7Ez1kHOP8wDTy0jZt6amQqHM/Iw9yfKzKuIanHK1ozDz/3iSmeBvmV1hzUz29JBxXXgpppNjp5ejt/5IK7bRiiLmsfsZfBv3a1FC4NgZJKuTsY3ZkBqOzIHjdNxTm+Z7AN8GQNYUyfi5obbs/NiJjH5rrX8+UDZzGsvzsHkM7q1mW3+iY7BADjNXMhFxx7EUHOgrHCO0I7Y+35azQVAoiK3MMxRmx4GdwlGAwTDaE8syhM7nV2cw3Q5aMCI7BVkKPCSrlZ601qhUmOMdc2ZE/qyTSA
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 991ef78d-40f8-4582-3ee3-08d824949efc
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2020 05:46:41.6017 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wUw90LdKg5+J/l/7q2hIiLo+aVsFCmqOzc1FbvBXa+36ZmlxWUpLyaQT/cm4DaD1TITv3nG0CfYTvmykKtYSSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4055
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

AMD_RESET_METHOD_MODE1 will be used by SMU
mode1 reset for sienna cichlid, so add
AMD_RESET_METHOD_PSP_MODE1 for psp mode1 reset.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Signed-off-by: Wenhui Sheng <Wenhui.Sheng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        | 3 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 6 +++---
 drivers/gpu/drm/amd/amdgpu/nv.c            | 6 +++---
 drivers/gpu/drm/amd/amdgpu/soc15.c         | 6 +++---
 4 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 4de93cef79b9..0682a270c17b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -580,7 +580,8 @@ enum amd_reset_method {
 	AMD_RESET_METHOD_MODE0,
 	AMD_RESET_METHOD_MODE1,
 	AMD_RESET_METHOD_MODE2,
-	AMD_RESET_METHOD_BACO
+	AMD_RESET_METHOD_BACO,
+	AMD_RESET_METHOD_PSP_MODE1,
 };
 
 /*
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index fec6cf3f0c8a..565dc59a9e89 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2119,7 +2119,7 @@ static bool amdgpu_device_check_vram_lost(struct amdgpu_device *adev)
 	 */
 	switch (amdgpu_asic_reset_method(adev)) {
 	case AMD_RESET_METHOD_BACO:
-	case AMD_RESET_METHOD_MODE1:
+	case AMD_RESET_METHOD_PSP_MODE1:
 		return true;
 	default:
 		return false;
@@ -4174,7 +4174,7 @@ static bool amdgpu_device_lock_adev(struct amdgpu_device *adev, bool trylock)
 	atomic_inc(&adev->gpu_reset_counter);
 	adev->in_gpu_reset = true;
 	switch (amdgpu_asic_reset_method(adev)) {
-	case AMD_RESET_METHOD_MODE1:
+	case AMD_RESET_METHOD_PSP_MODE1:
 		adev->mp1_state = PP_MP1_STATE_SHUTDOWN;
 		break;
 	case AMD_RESET_METHOD_MODE2:
@@ -4220,7 +4220,7 @@ static int amdgpu_device_suspend_display_audio(struct amdgpu_device *adev)
 	 */
 	reset_method = amdgpu_asic_reset_method(adev);
 	if ((reset_method != AMD_RESET_METHOD_BACO) &&
-	     (reset_method != AMD_RESET_METHOD_MODE1))
+	     (reset_method != AMD_RESET_METHOD_PSP_MODE1))
 		return -EINVAL;
 
 	p = pci_get_domain_bus_and_slot(pci_domain_nr(adev->pdev->bus),
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 356849136d1d..1d27dd3676ad 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -265,7 +265,7 @@ static int nv_asic_mode1_reset(struct amdgpu_device *adev)
 
 	amdgpu_atombios_scratch_regs_engine_hung(adev, true);
 
-	dev_info(adev->dev, "GPU mode1 reset\n");
+	dev_info(adev->dev, "GPU psp mode1 reset\n");
 
 	/* disable BM */
 	pci_clear_master(adev->pdev);
@@ -274,7 +274,7 @@ static int nv_asic_mode1_reset(struct amdgpu_device *adev)
 
 	ret = psp_gpu_reset(adev);
 	if (ret)
-		dev_err(adev->dev, "GPU mode1 reset failed\n");
+		dev_err(adev->dev, "GPU psp mode1 reset failed\n");
 
 	pci_restore_state(adev->pdev);
 
@@ -310,7 +310,7 @@ nv_asic_reset_method(struct amdgpu_device *adev)
 	if (!amdgpu_sriov_vf(adev) && smu_baco_is_support(smu))
 		return AMD_RESET_METHOD_BACO;
 	else
-		return AMD_RESET_METHOD_MODE1;
+		return AMD_RESET_METHOD_PSP_MODE1;
 }
 
 static int nv_asic_reset(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index 8c739b285915..86ce2f165038 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -479,7 +479,7 @@ static int soc15_asic_mode1_reset(struct amdgpu_device *adev)
 
 	amdgpu_atombios_scratch_regs_engine_hung(adev, true);
 
-	dev_info(adev->dev, "GPU mode1 reset\n");
+	dev_info(adev->dev, "GPU psp mode1 reset\n");
 
 	/* disable BM */
 	pci_clear_master(adev->pdev);
@@ -488,7 +488,7 @@ static int soc15_asic_mode1_reset(struct amdgpu_device *adev)
 
 	ret = psp_gpu_reset(adev);
 	if (ret)
-		dev_err(adev->dev, "GPU mode1 reset failed\n");
+		dev_err(adev->dev, "GPU psp mode1 reset failed\n");
 
 	pci_restore_state(adev->pdev);
 
@@ -559,7 +559,7 @@ soc15_asic_reset_method(struct amdgpu_device *adev)
 	if (baco_reset)
 		return AMD_RESET_METHOD_BACO;
 	else
-		return AMD_RESET_METHOD_MODE1;
+		return AMD_RESET_METHOD_PSP_MODE1;
 }
 
 static int soc15_asic_reset(struct amdgpu_device *adev)
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
