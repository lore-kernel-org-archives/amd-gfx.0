Return-Path: <SRS0=QzDn=C2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10270C433E2
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Sep 2020 04:16:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BE2C22205
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Sep 2020 04:16:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="H9WqD9J3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BE2C22205
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DAACC6E03A;
	Thu, 17 Sep 2020 04:16:42 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2086.outbound.protection.outlook.com [40.107.94.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 10A9B6E03A
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Sep 2020 04:16:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R7jJQMc4mmIp79ntRTePAtWnlH3qHlJoAb3VOmg0S10xvk6tItQwATULEecnEcwfHNL3KX0jlEWSfdKjzcYHHFlrAkK2BxpbezljaSIFEzHaBFKrsna7hI33P3nqX7sBKaQRIakra7feL7Q1Ds6v1u3i06InNdZuBiQtxxTQqJ6YBG9NQAz6/bVzwPBeN49/nt7C8u+ciFCtvgijmMMf80KLUkIkhwFDRslzFmZp5mI9XR8TuuSH79zpt9YT3W/n2bpkETmZNc1UWlTxNbuUREerT81FDCSPY9v4hCV5rLl5nEN8IngsMZ5HWlkca4UHw+EN0s5l8QcLIokOnezDfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FIrfsZF8MeZ8Fsi2UvsVqOO+ObGMSlzz/+AgJRsXvMA=;
 b=ddmDJA+RE6ysGAu8MGHkqI2TH8oXgBQrqjvOLmvJUVlEBBIwswWSW5wPPKrdQtg71dKOcCFNG0Rn0fXFFmNrKyDQak9uqP8jysB7d1Nk+V0klc1W0G3BZKeoiQwJblstvtsIqhWEAqe6LwGNgP6Fa0rAD2zwPo9/+mNilqvMeTcx9gzJCoZ5cLfrtMJFkjQKxsAecAmgzxUvMrMAO1TFPWZ6zxpuLqKRxFitlwUNwmx8VOiyQzdAVDjElyxlnp3dtqS7ROGvGmYe3dN12V3icCa6a9t/MPIrYUn2C+7SfkTTepxNY2pT4MfQaFJla/nDsjgnAtYrx5V8phYpNIb0Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FIrfsZF8MeZ8Fsi2UvsVqOO+ObGMSlzz/+AgJRsXvMA=;
 b=H9WqD9J3BYigK0R7oOaDTalwiAruOE7nJFBJx5P8yFiBO2V5eOXkQQHbKCycHTZqPG7B3y3zZdVagNhTjWqJgmpjVCBtHcuxv6uHOUJK0AeHLxYXp10WDYT+Y5+EogAXHIWlDC9K00DLO4G4QUIkuP6mPfZ6tLXwXg0dIAOxbWc=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2414.namprd12.prod.outlook.com (2603:10b6:802:2e::31)
 by SN6PR12MB2638.namprd12.prod.outlook.com (2603:10b6:805:6f::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11; Thu, 17 Sep
 2020 04:16:39 +0000
Received: from SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::d548:1236:cb4f:1be9]) by SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::d548:1236:cb4f:1be9%7]) with mapi id 15.20.3391.015; Thu, 17 Sep 2020
 04:16:39 +0000
From: Felix Kuehling <Felix.Kuehling@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/1] drm/amdgpu: Fix handling of KFD initialization failures
Date: Thu, 17 Sep 2020 00:16:20 -0400
Message-Id: <20200917041620.16221-1-Felix.Kuehling@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: YTOPR0101CA0060.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::37) To SN1PR12MB2414.namprd12.prod.outlook.com
 (2603:10b6:802:2e::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (165.204.55.211) by
 YTOPR0101CA0060.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::37) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.13 via Frontend
 Transport; Thu, 17 Sep 2020 04:16:39 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.211]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 14c64135-c45a-44c1-9025-08d85ac079ac
X-MS-TrafficTypeDiagnostic: SN6PR12MB2638:
X-Microsoft-Antispam-PRVS: <SN6PR12MB2638978281E4A9BD9090CCE0923E0@SN6PR12MB2638.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2150;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6SPpwsZQ/6RdIsy7ZPr6GkBwDaKAlZNP7ezB6Rv7YtQyH/0CKx2OJdvvk7wXnJJKVxWbb4QSm4+y4+oUSEroOHmvk18z0nwhNBMgr9jdratHlp7p4/W1xpj09tUAxawNeSeIIauCFxizi52ktKdqJs0OWa7TpjKFr59AbvDIVHuYrc4wUBGN1Yz+9vpT6o8wU6mVeKpPYARFq19BaATECyRWNN+OY2jT/Qr+LeXlYZJRDr/Flaap2ZilEz58aDDB2UniXpKC1IXBBbGaLKTwIHlxCn8VruYo3lJ3HirGU3MtAFVtyhsUpvO47wp3jSSH+alqp3Fb5jjnVBwlFVF+qtQ61doTwXeBDA/+qLG5pTNgfxzCFwJ8zg3C5Ba/x8Q1
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2414.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(39860400002)(376002)(396003)(136003)(6506007)(26005)(186003)(6666004)(6486002)(316002)(2616005)(6512007)(86362001)(16526019)(478600001)(6916009)(8936002)(956004)(2906002)(36756003)(69590400008)(66476007)(5660300002)(1076003)(83380400001)(66556008)(52116002)(8676002)(66946007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: hhYjmF8iRoio+VCNoeqVx5B0UjFuLlz8ViPNAbTF0NS5NwiXW/irwe+WwLM916rih5Z2i5GRMbPCQ3bcPzGoRt11alzGIgQDdlstKHo5qllSNqji/iHAZA5hH2HnxTVodxNTrNo3KGxx+1OmzDz+ltGtsDKRlNvrR3GJOt6FhknVPFt7EkfwOKveqjuq1qQIL6TT4jJ7/AiHjRbUkWcFEj/cRI93qdVYsAn3tEJnaI3kHT+WW9Q8aTBnIHBay6ljvglnc7f684mIfufKMz6HoGEYBDtA5vjBf+YOu6yraf9WPsbypnN74AsmKpcSacuK7E08Q6fg0KDf910jt90OggUpG4lbFVfrR10BDc0563Sg0ZvYtBUEqqQ+jciDF/6B54Sy+/p5fOkMnrkKwm/ZRheTJL59XGfKFQ7Ug7zVpNFJzHmrDgum+0ffgqupy2Q8dkgsLB3d0jPPCPMrFVIKGqo2FINXn5WOMwqmmQoXWN8bt0aslUYUXHnNfRC9bwijn11afKl9fTsFQhLTUbw+l23RAeP8iISR4WyjcdO3ff5kgCeXQtCE2ClE1b4OQTwI0zDSiE1uyaFs4YfyZk1r7c1OS8a5eppto+X0CAJgx6m3EhrmvXMU5dJuiWL3/7403LW2flehPeykjYH4GEj/7g==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14c64135-c45a-44c1-9025-08d85ac079ac
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2414.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2020 04:16:39.5907 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l2miInhA/vuZj7CaKywr91/0sT1+qexWDtJ8iMNYjWcpxwjp+xnIKgKSyN19mPaaV26QTRMwz77t/+V2RU+CRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2638
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Remember KFD module initializaton status in a global variable. Skip KFD
device probing when the module was not initialized. Other amdgpu_amdkfd
calls are then protected by the adev->kfd.dev check.

Also print a clear error message when KFD disables itself. Amdgpu
continues its intialization even when KFD failed.

Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 11 ++++++++++-
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c   |  1 +
 drivers/gpu/drm/amd/amdkfd/kfd_module.c    |  1 +
 3 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index d58148f455dd..7f14461f7f40 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -36,6 +36,8 @@
  */
 uint64_t amdgpu_amdkfd_total_mem_size;
 
+bool kfd_initialized;
+
 int amdgpu_amdkfd_init(void)
 {
 	struct sysinfo si;
@@ -51,19 +53,26 @@ int amdgpu_amdkfd_init(void)
 #else
 	ret = -ENOENT;
 #endif
+	kfd_initialized = !ret;
 
 	return ret;
 }
 
 void amdgpu_amdkfd_fini(void)
 {
-	kgd2kfd_exit();
+	if (kfd_initialized) {
+		kgd2kfd_exit();
+		kfd_initialized = false;
+	}
 }
 
 void amdgpu_amdkfd_device_probe(struct amdgpu_device *adev)
 {
 	bool vf = amdgpu_sriov_vf(adev);
 
+	if (!kfd_initialized)
+		return;
+
 	adev->kfd.dev = kgd2kfd_probe((struct kgd_dev *)adev,
 				      adev->pdev, adev->asic_type, vf);
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index b7b16adb0615..297484ca7d19 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -97,6 +97,7 @@ void kfd_chardev_exit(void)
 	device_destroy(kfd_class, MKDEV(kfd_char_dev_major, 0));
 	class_destroy(kfd_class);
 	unregister_chrdev(kfd_char_dev_major, kfd_dev_name);
+	kfd_device = NULL;
 }
 
 struct device *kfd_chardev(void)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_module.c b/drivers/gpu/drm/amd/amdkfd/kfd_module.c
index f4b7f7e6c40e..e5aa51f44dd5 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_module.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_module.c
@@ -70,6 +70,7 @@ static int kfd_init(void)
 err_topology:
 	kfd_chardev_exit();
 err_ioctl:
+	pr_err("KFD is disabled due to module intialization failure\n");
 	return err;
 }
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
