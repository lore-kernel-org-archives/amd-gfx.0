Return-Path: <SRS0=jKCf=HV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0F80C433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Feb 2021 01:19:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 490B964E44
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Feb 2021 01:19:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 490B964E44
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA34B6EA82;
	Fri, 19 Feb 2021 01:19:49 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2086.outbound.protection.outlook.com [40.107.94.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 54AA56EA78
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Feb 2021 01:19:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mIA/ta5a5N0vS+CUal6eDvdtVR0PLL7eGozzgqyKO2CpXwnLqxFvaoNAnu9rIvK73TX/zb96eq19XjcttLX3ZpN/6D5vhwugyJVCTj9nuU4JifB9yzYlr6sA76i1N/Btdt+nDFkq45JdTIcHs0qVZXqaNwKOeCj3t7nKwBH9wAJHKmmoKbtfEpzDq7ioY+zxjxvK58JdfXmofs2asMn96vNyjZb3DjqhXNRw6PEUb5MsaUCvSxWL6AXY34EOhIG6Z3BopfajeK9QgiEcj6r3WZ+OqO/RTTPgHtSAn8d2XnZkIQ6AD+lhLC7J2VhSFx2FzJWCdLh+I1V4f6X74V3r6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bg5r+5kxGLSiBjCNezucNW+/0MES1T5Ts53SOsTrPq8=;
 b=ClBXFyXKl+l8cm8QiX5LqfyAdIW7Txzwg+HEepNf0lIWr9Jv9uvoY3okC2+wEbZrv7TNM/2N+Rq/CnyBGT6RU3wAPnzq6YNZiKBHooiEU/1iT5JcMBQOSQxady0LURpLma9kk2lYayuBYPws8BRLKHCmbiHgLRyihe5cX6bYW5EPWZaksLK3zUt1cxqSL5nzjRvS2k/i0I76d0daX6lC4XC7UxAeMjoVKHtV7mEu4eZS5vk8KGQZxvbn/h2eXNY/c9W7bAAaVSM31Yok/jLip7y7lVAeRDtE0UHz/VI4aBiIf2TMaEfaBQuzg5utRYrAZMnqzw4Ttg4Nt5vPU4WWzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bg5r+5kxGLSiBjCNezucNW+/0MES1T5Ts53SOsTrPq8=;
 b=3WX7lRXF6M/NQnJUoQgxJL9rK2UthN1xFpFiVRh43M8h0OyD9jxMVd74wtGv5vMB8Zr/6Lu/MvXjowHYv1IyIn2h+7QoiBq62lN24SEio/9pkQqAj2IPQ634I9LAIRDVUffB0A8dYg1O0O4qf2eQgRlfXa24BgMXb0oZ/sSXH8g=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3835.namprd12.prod.outlook.com (2603:10b6:5:1c7::12)
 by DM6PR12MB2860.namprd12.prod.outlook.com (2603:10b6:5:186::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.38; Fri, 19 Feb
 2021 01:19:46 +0000
Received: from DM6PR12MB3835.namprd12.prod.outlook.com
 ([fe80::102:2c9a:54ce:63e9]) by DM6PR12MB3835.namprd12.prod.outlook.com
 ([fe80::102:2c9a:54ce:63e9%6]) with mapi id 15.20.3846.043; Fri, 19 Feb 2021
 01:19:46 +0000
From: shaoyunl <shaoyun.liu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/4] drm/amdgpu: Add kfd init_complete flag to check from
 amdgpu side
Date: Thu, 18 Feb 2021 20:19:34 -0500
Message-Id: <20210219011934.28514-1-shaoyun.liu@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.250]
X-ClientProxiedBy: YT1PR01CA0020.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::33)
 To DM6PR12MB3835.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from shaoyunl-dev1.amd.com (165.204.55.250) by
 YT1PR01CA0020.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3846.38 via Frontend Transport; Fri, 19 Feb 2021 01:19:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 28dbde89-6b5d-4514-3954-08d8d474719a
X-MS-TrafficTypeDiagnostic: DM6PR12MB2860:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB2860F0A647FE7ABF54C2017CF4849@DM6PR12MB2860.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ksyhgMR2THTie/6nyC2ln3Mulypg6BUZv3yf4jNRb+23qwnixig/LqMi8jRHBuHLU6FRyVZ6skK7ghpk1HPoJPW1okrJO2wT0S7sen5D3dqtPxXb9GDhsEjP0cf2xfVfxeTqM+r5VZGFYqUMXIzVVjl7yTK2vqq43pkW2voaqbLWna5t40V8ARaKki/4l2QviTae0ye1ulY6PEPlN/w89meFIyF0lZm7jQ6IAk24DpkNQhTmSVWuJXNPkKR+JgPGNnUX3A5avrg5f2muWaRJ8/zeJ1SiGBxp6kSRojrRZLGXrdQnOiYeG4Zw4+eocVJYTTCkuvM/Z20gnRbKH1++DHBm0Y5BhmnN1bX4VinJts55iC/+Lm86kyxf6Eou4BW3fpOpVvpDj/P3dSz90sWH9cvI1RqiW+UF0z7Yo4tZ1sZrS3ghc7NwHfQAd0T3+VX4gbqgVAZMhXn4Pefkxq/PteTI303GKkGE8rk/tOzsZRhhA7/7CZbo5PWCRzUyyucEHaZk0jiQf2CTlmNOV6rc7ch+4mBBMgAJ/H6F2OSBlqG16fo3TiDwayvpSESX5dZJ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3835.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(346002)(39860400002)(396003)(136003)(16526019)(478600001)(5660300002)(7696005)(66556008)(8676002)(6916009)(8936002)(6666004)(86362001)(4326008)(1076003)(186003)(52116002)(66946007)(66476007)(26005)(316002)(36756003)(2616005)(2906002)(83380400001)(6486002)(956004)(43062004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Jvlc/YkyEqnsBzTONHcTyiA6NsBd4SvnkmeWpbZccAllY4sMKcCVp70XnuId?=
 =?us-ascii?Q?hQMUg68849+PYRQ172zjibBT2tzxIzMPSD6N7cwMzmqyyhnJZNtUTAosvDQl?=
 =?us-ascii?Q?/WCpbrWUnUReq/eY4p8CdCj0l0QCTITiel5Rx8cPVmkDeW6g1rHLQFztYy7X?=
 =?us-ascii?Q?7/viE1WLEcz4qUO9CQeE6Oc2JbENEzOUxdHJ4GfwEO5uZ/iU6hf+01fRkLgL?=
 =?us-ascii?Q?e4t8fSSsGwMq8wqFpAFr+Ju3E4DIqny7ThfA1Cyz9lY5KyfybK747NVtRMl/?=
 =?us-ascii?Q?veN6bAqW7qPLlB6BjBOLLrgikGcLciUKYD6y3zMRquAx9arPk+29LACfBJiI?=
 =?us-ascii?Q?/c6+3KigzQFzgPgEMYKoODvsVTu0rWcqBoS/a8qtCf8qPwKkuJIhgmTiuI2h?=
 =?us-ascii?Q?tyKE7TE7mQLTaS3Gz5bZhP0ffWvw4N9lBH/Q3b8elRbA7Z6OL//4jAvGddy1?=
 =?us-ascii?Q?PSXOxXlE0isN9obGMFncUWWd7PX52iwSMBimVygYAQMErcXRWvSkuNq93h0J?=
 =?us-ascii?Q?QHBa1Tjd2G2R4cStOUAPxJIsLxeJF4VHtN8EqhOA3xO2qa9wYtsCJfgoBQRa?=
 =?us-ascii?Q?l+yml/xYLJuDC+xGJc9pGe5EfC6SrvVT+3mSZOCHjPcozKMChKjedfOqcT0d?=
 =?us-ascii?Q?UE0QsstqqU+B2oAzcr7PhDwuxgUVJv8HnZSrIskE7yHwrbzC02q7AAI2WI5P?=
 =?us-ascii?Q?QNgsq9vFSuefCjrYwJY1qXd5c1qit3gyJoYmWSG7densEbsKlEBgEwm7v7nJ?=
 =?us-ascii?Q?shcewQZP+OzGYJLJLpHHoXNg4L8F4iI3Z1/c7ScDFTQEa6qk0JsHTRCuMc/U?=
 =?us-ascii?Q?mGEtzDzS8g5/pdwRLJV5tAXx28Y8yl5BU6t/zBDCWSlwa63SFPlqHmuf7tR0?=
 =?us-ascii?Q?FtDj5gGV5kcsVkC+LiYYzj/+R0e1IK+GM8GZmCeF+UkZXccWLPowtDDRk8L4?=
 =?us-ascii?Q?nmCi9FAJ0PzCu1iC+3cT6aPBYCNHbG04ojSWaxzKxCAXFKrKe3HhZBG0w+i4?=
 =?us-ascii?Q?2/fwmcndH2J+V/KCDEqaSUq8SN2QvofXv4qZVsbjqH92C+NfyhDOIyh83JN8?=
 =?us-ascii?Q?I2I5QJUmaYJCyxeYKpx5Qs9TyVfxLlvvbq7RBxrlcySS9hjiLtF3WnxACK0Y?=
 =?us-ascii?Q?NZo5DhcQ9CB4B9as7jSt7BiWnqV3QcBUMSO40lIC0EZm0/0ZwQu69e5A40Gg?=
 =?us-ascii?Q?lUfYaEC6gO0WVXn57XVsmjICwhiINKf3uuit/Rvsx+aawTnQGAFPnW52uDgK?=
 =?us-ascii?Q?+sm8U/x9g553kW18seXFaLEGirQBuJh25Q/WG1/t+DLYD9w9whZmiCuV/tEd?=
 =?us-ascii?Q?gpag+1+K032abEbYrTPPD2t+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28dbde89-6b5d-4514-3954-08d8d474719a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3835.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2021 01:19:46.2001 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l1jq2AfaZ/YEQxydiBBX2h0JBrpFAkCcO2glnSjOBZFAag7UmXWmjsI+aswV/RPb99bJK0GQ6ec24cV3Tliijw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2860
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
Cc: shaoyunl <shaoyun.liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

amdgpu driver may in reset state duirng init which will not initialize the kfd,
driver need to initialize the KFD after reset by check the flag

Signed-off-by: shaoyunl <shaoyun.liu@amd.com>
Change-Id: Ic1684b55b27e0afd42bee8b9b431c4fb0afcec15
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 3 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 7 +++++++
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index c5343a5eecbe..a876dc3af017 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -165,7 +165,8 @@ void amdgpu_amdkfd_device_init(struct amdgpu_device *adev)
 					adev->doorbell_index.last_non_cp;
 		}
 
-		kgd2kfd_device_init(adev->kfd.dev, adev_to_drm(adev), &gpu_resources);
+		adev->kfd.init_complete = kgd2kfd_device_init(adev->kfd.dev,
+						adev_to_drm(adev), &gpu_resources);
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index 4687ff2961e1..3182dd97840e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -80,6 +80,7 @@ struct amdgpu_amdkfd_fence {
 struct amdgpu_kfd_dev {
 	struct kfd_dev *dev;
 	uint64_t vram_used;
+	bool init_complete;
 };
 
 enum kgd_engine_type {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 9f574fd151bc..e898fce96f75 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4841,6 +4841,13 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 		/*unlock kfd: SRIOV would do it separately */
 		if (!need_emergency_restart && !amdgpu_sriov_vf(tmp_adev))
 	                amdgpu_amdkfd_post_reset(tmp_adev);
+
+		/*kfd_post_reset will do nothing if kfd device is not initialized,
+		 *need to bring up kfd here if it's not be initialized before
+		 */
+		if (!adev->kfd.init_complete)
+			amdgpu_amdkfd_device_init(adev);
+
 		if (audio_suspended)
 			amdgpu_device_resume_display_audio(tmp_adev);
 		amdgpu_device_unlock_adev(tmp_adev);
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
