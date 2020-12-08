Return-Path: <SRS0=uNpP=FM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DF54C4361B
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Dec 2020 08:28:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CF0923A5B
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Dec 2020 08:28:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CF0923A5B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE69C6E952;
	Tue,  8 Dec 2020 08:28:12 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2069.outbound.protection.outlook.com [40.107.92.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E9E26E0AD
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Dec 2020 08:28:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V7hQRwphl+yTmc24qQs2un95P5uUFtsrzC8VoN8wpCWgtmqWPxzwb30JTPcGa5V0StXRweue7Zrs6/YwI/bXK2NdwqbG82cEGpbIoJpjTXOC1Xp0VaDrDCglBJCvyP0cZlEE44oFWEur1YlRivg0kURmTVaC13fwzNAAVzZinAg6afLhfbQextJWBbxbzEk49BZgy8W/SXMSAdb692CBf58nP/x4XtR+1Z2Otdtnf1DxFQg+IQEjfnFotfYtqldsrojS5aY0OhYdMzSOnsytr5IZMGEVC95DNkQqikJdl8wHP1S8FjRMIJyl02IxqphHiONWkoQ/qPnAzzVxkbQ7Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0nHhqvBB9kor7/dbRPcMQwLnwn3L4VC8ownFc+GmEXE=;
 b=aa/BTITqoaZBeabluYj5jaF6SApyuxwm63gZmYI+Nkbi9ywLoweBh2VVnzw/2N432/NrhiEL6fHCN38BfSdxxNeRrTobLkD9gvFzgT7t+1rDdoCxVwqh9HIUw46EQIH2WKx23du35gsaeZeHupsWNF5jEZYfKAJuY6YeuViYDka6kiCsXvzMbzCoKUOf+81/tQ34PhvT1OQYIl4sdbeYyvtas+dJYf2+XabV+eFOYx/aSP0PdTo1YaBHK2b17HKuORyV+L4tYUH1/XEYqeqxeaJGE6ufDxpaIANf82eNYKoo6uvTnFVm0qwCnNz7g0JVcz2V1Adt+V+9BwvI8BwKNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0nHhqvBB9kor7/dbRPcMQwLnwn3L4VC8ownFc+GmEXE=;
 b=pVnYEK4LjB7gWG3Kn8R8NHq7RCwZV02lA+ZXMlt7Mq4JvxeaGYa9BeHJdyDtFa95S/U7D8vKWlUQkFWeOmPz+Y0PMOsysA5PDYnn3V2sZXF4/ZkbUscf7ghX443/2yYaLTjIalMlofs4aRB4zwqvuLKB3VO1QdpTX/raqqjAMI4=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR1201MB2507.namprd12.prod.outlook.com (2603:10b6:3:e9::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3632.18; Tue, 8 Dec 2020 08:28:10 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5a6:dfb2:fdfd:2d91]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5a6:dfb2:fdfd:2d91%6]) with mapi id 15.20.3632.021; Tue, 8 Dec 2020
 08:28:10 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 5/6] drm/amd/pm: wrapper for applying 2nd usb2.0 port
 workaround
Date: Tue,  8 Dec 2020 16:27:32 +0800
Message-Id: <20201208082733.126647-5-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20201208082733.126647-1-evan.quan@amd.com>
References: <20201208082733.126647-1-evan.quan@amd.com>
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HK2PR03CA0061.apcprd03.prod.outlook.com
 (2603:1096:202:17::31) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (180.167.199.189) by
 HK2PR03CA0061.apcprd03.prod.outlook.com (2603:1096:202:17::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3654.7 via Frontend Transport; Tue, 8 Dec 2020 08:28:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7223ede9-a24b-4525-95b2-08d89b533287
X-MS-TrafficTypeDiagnostic: DM5PR1201MB2507:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB25078AB97B9AAFDB935AC345E4CD0@DM5PR1201MB2507.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:510;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5LG8RPHeg6fLtlw7J2HeAUk2iL/1qVPW+vr54ISMpzqyzBZhu6YCvRX0L7rFQmu8dDnjOI536UkwlkJMcnn2ze2uiNBL6Aq7iq5NrotifuS89HTwCpVXX8fOC7o38CrK01CUmCi95VyrxGpdf9VMMOnwbeOgSkfKNjxJpQhNRJbL8AUmLux+Nj1cHrCOmi4Hz2+ah0jGjbt3LH4f8kCjjvPx97f6sMEu4Zcc5n/axWcmFRIo8BROK1BF3lqWv9IKbIamqT6d2/Qt/wc2Zlpm2XzCsvxddPQ326e3B40v6y+Tx7zI0MIHMlK6fMISytwb3WyAIB5uk/r/YOhiW9BIUg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(346002)(39860400002)(376002)(396003)(2906002)(4326008)(8676002)(52116002)(66476007)(66556008)(7696005)(66946007)(2616005)(478600001)(316002)(8936002)(26005)(44832011)(956004)(186003)(36756003)(6666004)(16526019)(5660300002)(6916009)(6486002)(1076003)(86362001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Jok93FsB2v/W+hfAoQU+2LfQS8jv7IaRz2fwanYVb72YgHtGARWgjt+symWY?=
 =?us-ascii?Q?pHdKYlxjCmExkiReu8Ft18NJy+8+B05Cf7KTASs6DWFG4txAOyLdgK3v7Kh8?=
 =?us-ascii?Q?Rt+EKZUEMLzmoGT3rctQ9a47dOcSAkGFoWjXVv2ZI19yPbwsWxYr7U1xMB/I?=
 =?us-ascii?Q?MU8CR5gwcMIV6JkgwbqGdh7/qzDfNMnQYZpe7giSzMCs2wrCfpN+LgOs9q8y?=
 =?us-ascii?Q?xRfRClonZDBAPtXFCY2GA6uAxVxc6wogIDEwXDXYmYhYPcJkZt6R9AOdJtiN?=
 =?us-ascii?Q?tlVcLOFWkfue1E6286+qqaZfeZK1vv0ay5uNH99edt180vGXX7J1GkUIbI5F?=
 =?us-ascii?Q?3RWa9g9jF6hP7sldiXlxS/7uwbc6mY2kNIYqL/gf4VJWMWlE/R3Wiu9Oh0n9?=
 =?us-ascii?Q?R3u5R6+17Qa8pyI1pzP/U+Vo9b1pFjHOXMqKNszoIwVP6dTKh7VAyiRninhD?=
 =?us-ascii?Q?Vdjc8i9vpCUR5djyLdQHbcxM4fF4P+ws7+fbmcxLWz8f+c0TBCgyHMh8voDB?=
 =?us-ascii?Q?L3hftj5uaQOOWYLUml3a4uJwQLkvwi8bhaP/gjsD/227KbyCmiz28X8SH6fX?=
 =?us-ascii?Q?oBn8qAhiMlOqk0u4NCVbI30pdM46R+PXE7JpkUeR11UmwhnC0QFGMOPql785?=
 =?us-ascii?Q?T4GHALBp6LJHPAwp9tAknBH2pKgyRv1ToQlGXnCj0RPjOGeESasRa9JDfGLT?=
 =?us-ascii?Q?QCk24d74Dd2LBddCpya/MFj+l2UPPc6YDhzFucXMTjT+BA0hCkYeDCQbCtnh?=
 =?us-ascii?Q?9BTpr8afWUetTqAYsT6leHceCJkXhF/ddArS+ZvIKHsvrfrjjhZavOoVyape?=
 =?us-ascii?Q?mS7qWi1cD+34bsLjRV7znve8cQ7lO+JCmcmG5h3OY5va76eIkS4v8aN0iF4M?=
 =?us-ascii?Q?DtJpq0BrDTqehHfNqZuzFId1IPoKAFlMqS2k7v+dgIPy2CAe9BuhJHZYQizt?=
 =?us-ascii?Q?F8TOuhXESYmAoXNEimVuH5qDn8oKJa9Zde5KL2zQQ4TFVibrffw0nP99Pf+9?=
 =?us-ascii?Q?bkS8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2020 08:28:10.4173 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: 7223ede9-a24b-4525-95b2-08d89b533287
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tJYjNxGCwNMM+E6FeNPp3ES0a3R4QkM7s2Djhxxip+LoUHYRwwI8mIRIz7tC43Zx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB2507
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
Cc: Alexander.Deucher@amd.com, Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

2nd usb2.0 port workaround wrapper.

Change-Id: I615d8a568b1f6623a060ba5081c2d2a1235f32b9
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h     | 1 +
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c   | 6 ++++++
 drivers/gpu/drm/amd/pm/swsmu/smu_internal.h | 1 +
 3 files changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
index cb96466605d5..3d6af881f507 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
@@ -601,6 +601,7 @@ struct pptable_funcs {
 	int (*gpo_control)(struct smu_context *smu, bool enablement);
 	int (*gfx_state_change_set)(struct smu_context *smu, uint32_t state);
 	int (*set_fine_grain_gfx_freq_parameters)(struct smu_context *smu);
+	int (*notify_2nd_usb20_port)(struct smu_context *smu);
 };
 
 typedef enum {
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index e6ae722ca6e6..3515203df2c5 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -935,6 +935,12 @@ static int smu_smc_hw_setup(struct smu_context *smu)
 		return ret;
 	}
 
+	ret = smu_notify_2nd_usb20_port(smu);
+	if (ret) {
+		dev_err(adev->dev, "Failed to notify 2nd usb2.0 port!\n");
+		return ret;
+	}
+
 	ret = smu_set_driver_table_location(smu);
 	if (ret) {
 		dev_err(adev->dev, "Failed to SetDriverDramAddr!\n");
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h b/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h
index 68d9464ababc..2eaec41dc808 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h
@@ -91,6 +91,7 @@
 #define smu_post_init(smu)						smu_ppt_funcs(post_init, 0, smu)
 #define smu_gpo_control(smu, enablement)				smu_ppt_funcs(gpo_control, 0, smu, enablement)
 #define smu_set_fine_grain_gfx_freq_parameters(smu)					smu_ppt_funcs(set_fine_grain_gfx_freq_parameters, 0, smu)
+#define smu_notify_2nd_usb20_port(smu)					smu_ppt_funcs(notify_2nd_usb20_port, 0, smu)
 
 #endif
 #endif
-- 
2.29.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
