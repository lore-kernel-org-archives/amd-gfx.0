Return-Path: <SRS0=XXlo=6X=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A68FC28CBC
	for <amd-gfx@archiver.kernel.org>; Sat,  9 May 2020 07:47:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2C5B20746
	for <amd-gfx@archiver.kernel.org>; Sat,  9 May 2020 07:47:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="okTYAbfA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2C5B20746
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 78F8D6E2EC;
	Sat,  9 May 2020 07:47:52 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2078.outbound.protection.outlook.com [40.107.220.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F181F6E2E8
 for <amd-gfx@lists.freedesktop.org>; Sat,  9 May 2020 07:47:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HJcE0EHRLHSitk08wZh3mlE6mTRAyHxLGxLbA7chMEE+WR9I6qO3z5xOL8q0tskG2A2/NLQkdqSVkRWK7VblqugYqGvkEdUFOpAjazquqyFscdxaedPRHPKQUQv8RnxKPhPxllY2++edGa+wlZQg1bFCQAMuURF09yIewEWSSBGaJsmC6Qs2xfbAUWIa2mIKv9/3Hns7h466jk3SvueXbRpmnFA0X8scXBODL3Zjx4WhVf+OaSBWdPMCzRiVuKXMjwfI+t7SPp6kwCvLNiagRZHl6Cmiw47GX3838HKEC4dqXltd5s0kp90bjtO0Ps39Gqv3i81NjBwdIRNaddH3tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R376whGmvyYQ0jhqb/h6T6wMZEU6o4GZ6hDVRrTYQKQ=;
 b=PNMX5IH0/2k4NenIrI8rElEHtS8u+fPvmvypjIMHvIzUNstCEmK/i+rOj6KxO2r40ieB+HY9STncnVZI1pL683FY8XuvhYq9AsANepxwT2rtZQZ2gP9wiTFWH1/394DwbpoUKhZm59CK8f7xYhs15JkY4k/520D+Yj8USPY2eQ27NdgrdVie6LEEP4IUtYJBL33lHvi/23t11RUkJskppEtDUumkJikKelRh6WULmwn3ZOLvWJnX0ZHCYzBWg9TGWG9q8mwq0zJD5GVKypMu2OFZAlvYduPqg2Cm3qzVV64aQxfj2cPDBvtY9wPNPiwy6tujZAVpPvm3tn2YYSDNHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R376whGmvyYQ0jhqb/h6T6wMZEU6o4GZ6hDVRrTYQKQ=;
 b=okTYAbfAnNX0rSmfgEAYMnY97+bvWwgHn53mnvngvhFtZwRL5lZfZKVoOJE5OaMzOHvGjxGug8QW94baHKF36RkV1CHb695zX5FXS9y29JM0CuCx8fCqP8dKz8OUtwjwcOlsWfaFH6i+55Qo/spDGWqPbQC2qIKZZv0Oz6UmfqM=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3499.namprd12.prod.outlook.com (2603:10b6:5:11e::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2958.29; Sat, 9 May 2020 07:47:51 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5c27:185c:be20:1fb6]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5c27:185c:be20:1fb6%5]) with mapi id 15.20.2958.035; Sat, 9 May 2020
 07:47:51 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amd/powerplay: shutdown on HW CTF
Date: Sat,  9 May 2020 15:47:26 +0800
Message-Id: <20200509074726.11573-2-evan.quan@amd.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200509074726.11573-1-evan.quan@amd.com>
References: <20200509074726.11573-1-evan.quan@amd.com>
X-ClientProxiedBy: HK2P15301CA0018.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::28) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK2P15301CA0018.APCP153.PROD.OUTLOOK.COM (2603:1096:202:1::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3000.13 via Frontend Transport; Sat, 9 May 2020 07:47:49 +0000
X-Mailer: git-send-email 2.26.2
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6712b595-d5f5-4124-59f4-08d7f3ed464c
X-MS-TrafficTypeDiagnostic: DM6PR12MB3499:|DM6PR12MB3499:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB34997425889641C00049F331E4A30@DM6PR12MB3499.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:565;
X-Forefront-PRVS: 03982FDC1D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NxVqjzi/u6UEdUClKXmESqb1lt3ZsoqDUlyCKp5Q5wSTMHrdPqUTDPr7tUqA5n7OL3vQPiMZP4GDq6SP/osszVOhT4Ss2Da9MfCPwcKkq0C9F7DUWEoV7a5V6mQSMHLuiT4NjQhC4iJjEQacWkDgo+q8Xup5vyEeoRnx5cxYiQB2bHJx625SWlLFyv7BTVn9n13jXoYUY7L3BuzFQnkJGnaofM/zY4k/dB+OUYfsBKnSYn/l0IfzLsdwBDlxfrh8QniEJxm6/v8eQ3I316SOVbm8UfAGzoLgjNagQLCEcsPUdrQ5aVI5kZT6unG0c7Xvy5cUHrBlvgfZiLWGMTTyRr6xye+DsiYq6I1ij92Gvj8Lqhd4Tx+auY4M0h7IPg+nqVJdM+KyvEqCbSGw8WBAOl0bhGs4m77rbbDS5Mz/OG9daW2mFxvOjrAhByWYPFTRc2mY/Z2UWkGOuxalVpjwVpiEy5bRWzVH0IwPRHp/gqfRFQZM0AFSS1isybjqDquJFIh5PTXnbOJ4aW+06DcRcQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(366004)(39860400002)(136003)(376002)(346002)(33430700001)(33440700001)(956004)(8936002)(52116002)(8676002)(86362001)(7696005)(6666004)(66556008)(6916009)(2616005)(66476007)(4326008)(16526019)(1076003)(36756003)(316002)(2906002)(66946007)(44832011)(26005)(5660300002)(478600001)(186003)(6486002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 6QOJVwLyvelEl7QMet2sF3qrjgutuu9E4hvMfE0XsX6pbxlcH6dyCqo7ZYvoE186waamb8QqhWMqOXxwiuQ/JziTgl7XcdDno2RJ239OUuUK/jKZFS+k24QmkEpWWzO7myOrS6loQ06CFhQBhxsaDHZBvhzRRrrUlPD6N+5e7m/gqxjxrZbZQ6Dk2zuNdBHqsW6DL8mryyrIVU/bGZPx4LTtgcwmDka8PVgb+gn68L5T6zh5s8c+Wtjm/JteLt48I8OW2IreZG+bjCxvrcmtrRRelGhxAHxaeNiXKJwbzNWXpLGmgPtPqiv1ZGdtUB3XRqev6XoTt540PLwjpYq4Xf8GwTqqFh8gNyu8QCYGflZN59Kmt/jq7jpUSw5v2MPXgCvLZT67TqnFvnufA690Zvm24ZTk0fnv4qGzqDWXG1wco9Wse+CWXRoycGNnv0G2pe5Tq7FwYnKXpNF+QHLk6xBJRsHaHafXGXTovkvhhktYUv2G+PGknsxvcco5BUyg
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6712b595-d5f5-4124-59f4-08d7f3ed464c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2020 07:47:51.0458 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 67pUZ85lA6yveAOod1RUMKTUtSnfUJztrQMwNd7yxJoqyvlghGPO5k5RwEUW98t+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3499
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
Cc: alexander.deucher@amd.com, Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

To prevent further damage.

Change-Id: Iae0399001694bb7446bcc6071cd03d8fa47c9d02
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 .../gpu/drm/amd/powerplay/hwmgr/smu_helper.c  | 16 +++++++++++++--
 drivers/gpu/drm/amd/powerplay/smu_v11_0.c     | 20 ++++++++++++++++++-
 2 files changed, 33 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu_helper.c b/drivers/gpu/drm/amd/powerplay/hwmgr/smu_helper.c
index 782f6d295202..4279f95ba779 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu_helper.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/smu_helper.c
@@ -612,11 +612,17 @@ int phm_irq_process(struct amdgpu_device *adev,
 					PCI_BUS_NUM(adev->pdev->devfn),
 					PCI_SLOT(adev->pdev->devfn),
 					PCI_FUNC(adev->pdev->devfn));
-		else if (src_id == VISLANDS30_IV_SRCID_GPIO_19)
+		else if (src_id == VISLANDS30_IV_SRCID_GPIO_19) {
 			pr_warn("GPU Critical Temperature Fault detected on PCIe %d:%d.%d!\n",
 					PCI_BUS_NUM(adev->pdev->devfn),
 					PCI_SLOT(adev->pdev->devfn),
 					PCI_FUNC(adev->pdev->devfn));
+			/*
+			 * HW CTF just occurred. Shutdown to prevent further damage.
+			 */
+			dev_emerg(adev->dev, "System is going to shutdown due to HW CTF!\n");
+			orderly_poweroff(true);
+		}
 	} else if (client_id == SOC15_IH_CLIENTID_THM) {
 		if (src_id == 0) {
 			pr_warn("GPU over temperature range detected on PCIe %d:%d.%d!\n",
@@ -634,11 +640,17 @@ int phm_irq_process(struct amdgpu_device *adev,
 					PCI_BUS_NUM(adev->pdev->devfn),
 					PCI_SLOT(adev->pdev->devfn),
 					PCI_FUNC(adev->pdev->devfn));
-	} else if (client_id == SOC15_IH_CLIENTID_ROM_SMUIO)
+	} else if (client_id == SOC15_IH_CLIENTID_ROM_SMUIO) {
 		pr_warn("GPU Critical Temperature Fault detected on PCIe %d:%d.%d!\n",
 				PCI_BUS_NUM(adev->pdev->devfn),
 				PCI_SLOT(adev->pdev->devfn),
 				PCI_FUNC(adev->pdev->devfn));
+		/*
+		 * HW CTF just occurred. Shutdown to prevent further damage.
+		 */
+		dev_emerg(adev->dev, "System is going to shutdown due to HW CTF!\n");
+		orderly_poweroff(true);
+	}
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
index 5b493f140dda..041aac272a9e 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
@@ -1517,6 +1517,8 @@ static int smu_v11_0_ack_ac_dc_interrupt(struct smu_context *smu)
 #define THM_11_0__SRCID__THM_DIG_THERM_L2H		0		/* ASIC_TEMP > CG_THERMAL_INT.DIG_THERM_INTH  */
 #define THM_11_0__SRCID__THM_DIG_THERM_H2L		1		/* ASIC_TEMP < CG_THERMAL_INT.DIG_THERM_INTL  */
 
+#define SMUIO_11_0__SRCID__SMUIO_GPIO19			83
+
 static int smu_v11_0_irq_process(struct amdgpu_device *adev,
 				 struct amdgpu_irq_src *source,
 				 struct amdgpu_iv_entry *entry)
@@ -1556,8 +1558,17 @@ static int smu_v11_0_irq_process(struct amdgpu_device *adev,
 				PCI_SLOT(adev->pdev->devfn),
 				PCI_FUNC(adev->pdev->devfn));
 		break;
-
 		}
+	} else if (client_id == SOC15_IH_CLIENTID_ROM_SMUIO) {
+		pr_warn("GPU Critical Temperature Fault detected on PCIe %d:%d.%d!\n",
+				PCI_BUS_NUM(adev->pdev->devfn),
+				PCI_SLOT(adev->pdev->devfn),
+				PCI_FUNC(adev->pdev->devfn));
+		/*
+		 * HW CTF just occurred. Shutdown to prevent further damage.
+		 */
+		dev_emerg(adev->dev, "System is going to shutdown due to HW CTF!\n");
+		orderly_poweroff(true);
 	} else if (client_id == SOC15_IH_CLIENTID_MP1) {
 		if (src_id == 0xfe) {
 			switch (ctxid) {
@@ -1610,6 +1621,13 @@ int smu_v11_0_register_irq_handler(struct smu_context *smu)
 	if (ret)
 		return ret;
 
+	/* Register CTF(GPIO_19) interrupt */
+	ret = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_ROM_SMUIO,
+				SMUIO_11_0__SRCID__SMUIO_GPIO19,
+				irq_src);
+	if (ret)
+		return ret;
+
 	ret = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_MP1,
 				0xfe,
 				irq_src);
-- 
2.26.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
