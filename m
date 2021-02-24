Return-Path: <SRS0=z84W=H2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98DEEC43381
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:20:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64DB964E09
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:20:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64DB964E09
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 118B36EB48;
	Wed, 24 Feb 2021 22:20:30 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2077.outbound.protection.outlook.com [40.107.94.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0904F6EB40
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Feb 2021 22:20:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cu/BOetGXR13ORInmSkorl3nxxRpfAGkzOIfzLtrTJC+RPz3TM0sFzB5lr/9Dcj1fGRXucmR/TZAEkLP296yT0VLKpG7waSDUul0svAAZAqk7zDN7gO5cT2hInOt06xJDbyG6iTnbKLlFxqEbN21vl1aWTgWF2015wlR7YxOto7ATFL3wsP96gyDXdySDhOC9cKjot7SLBjSMsLyk6eXfBKr3hRvd/SXRtcn/yJp7iqSvFjr5zj9GbFx23VpGX5uo60tqaX8usPQEmQR67Ea/y4sWzWCUudkAs8XY79OmYfRlw6Ft+cTSwtVKzvoHWGZz+OE/+yYzyY2p7i4zKGpUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TtUAXl+Z/6+dJpvemwP20dZlfXlHVn9xRzvoUyTVLlo=;
 b=GmCcihy53LjttdPuq/Gn6LmIilt1PqyL/BEleM7dL7+3RV9e2b4Ety5Hke/YoUtwg5KIL/wITyU+naWE9WUCnMTUdSYTqezHZgFCQIxv1WQ0JmlQNFGfewJ+v/EkIUMDaqvK9lTlBfLXeVcOkAQhmA208ZD7jAN7RT9d+IoHoIAY9KJySY1pbU47aZX5sR4CQ3H6xMYv0yLASDOtipw4WZuZjrQQ/8JQ7WvjslHi/mGxsf0NC3GagVXGmQ5P/1RbztSTs1fQGJF+xSi6J8uqUX4hFAbpbJos5Jt1cCh+wS6VhZg7V9IMhxAkTdnsGVjrITirDYXM8p+Gj0ncCvR1+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TtUAXl+Z/6+dJpvemwP20dZlfXlHVn9xRzvoUyTVLlo=;
 b=3Ypz2fF/WqSqogevlw8o7S/0uG1YQmiDOVaboiTsosXxAI1ukgHU7RQPxrUS1Lrs2yLqL/eeL0GDXJx+dKypqew4xAVHQPMvlY/I1K4ooReij5mZlrcM4T7TVgzDjqCOK4nzRGsjusBPHWmGEx4KhvIH4FIZaISZ63b32v0MYmE=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4175.namprd12.prod.outlook.com (2603:10b6:208:1d3::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Wed, 24 Feb
 2021 22:20:24 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af%7]) with mapi id 15.20.3868.033; Wed, 24 Feb 2021
 22:20:23 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 055/159] drm/amdgpu: Clean up mmhub functions for aldebaran
Date: Wed, 24 Feb 2021 17:17:15 -0500
Message-Id: <20210224221859.3068810-48-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210224221859.3068810-1-alexander.deucher@amd.com>
References: <20210224221859.3068810-1-alexander.deucher@amd.com>
X-Originating-IP: [192.161.79.246]
X-ClientProxiedBy: BLAPR03CA0027.namprd03.prod.outlook.com
 (2603:10b6:208:32b::32) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.246) by
 BLAPR03CA0027.namprd03.prod.outlook.com (2603:10b6:208:32b::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend
 Transport; Wed, 24 Feb 2021 22:19:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 562238a3-528b-493e-5646-08d8d91251bf
X-MS-TrafficTypeDiagnostic: MN2PR12MB4175:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB41757CAAD24DF8F9C5EA5A2FF79F9@MN2PR12MB4175.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2803;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SjazIhXdMSs0IinPpOHyKkxeEcItSDvvQloPvAxV2RvAhw1VY9g3meAlbgEDxvQksw0KF4V2kIdZXhTGndynTr1AJKPgbUeKp26sveKEN/wMHMjgaPjXA7bG4EWWbLe848yy+jHpj4Urwm1EktfICEhn/GugNRO1doNbngCmzhst7oLt9KfZBtNUUTReUa1M8TLPFxRLh8dj1NGJJtL4wdhnYRJQxe1+0ACI8cK8Gr51cPNKBVh4onCV37kmsdOl/fy/DTvSRtEPpnN+0buj+Mf+f+u8hpxHVvNQ4dpUafgdmON+u6VxI/zboF1yYIIUxY23taCzAA2aMiVzWvb2LIyy1IklZvg34E/BzadMz55YB/+PZXEXg4yUt4OXJ7cLzH55ypsVbuZ4Wbp8YIaQGQgjxkq/8PnZc3CXF8o1KogiZcLuqp3+GRlRvSLbOl4FB8ydskioGqLeIiqL/CGjwmwbieQrOQX3s859KVX+Dc5B3PdPL9n8hOTcvZLL0iEkv8E6HoTQiii/JqzO7FuBb8BffCSPM1uQ7vVzU1cy/hzsNbeuazFdpEuGSvzzIlaoSq+/mND0/TcFOIZ5/rsCyQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(39860400002)(346002)(396003)(376002)(66946007)(5660300002)(4326008)(6512007)(66476007)(6916009)(26005)(36756003)(66556008)(2616005)(186003)(956004)(16526019)(478600001)(8936002)(6506007)(2906002)(69590400012)(86362001)(1076003)(54906003)(6666004)(83380400001)(52116002)(8676002)(6486002)(316002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?tLMHjqhxgkwnrCOSuOB/aFp8MBQiNkVel3qFnfwYYcQlqorcBQybPi8KNqPw?=
 =?us-ascii?Q?3wAZEIY4ZGu5jZUsQqM9E6UoUAbaD07lPG+FyHUZulb/eIt1/xiAENLEwLFD?=
 =?us-ascii?Q?AnHxB32+vtVg/c1VbzQNlTvVWGKvNFa6YoOMdcrZBz2b9MNBqJrlaL1x98TW?=
 =?us-ascii?Q?9sDnb1WdvVL8+MjGLf5B1jHh47W7Zm6v6vmrA7E+rqBXzeu7UZd+owubZKvA?=
 =?us-ascii?Q?UvDEfkabk/Qk8annPxNDk66kuREC67f1QmTeFwB2su1Gre2SyOt6F2OMMj8r?=
 =?us-ascii?Q?EqC7y2is10JrJ/wREE+vZWjhroAyUfxtuTQzBhgzPsR2yxGFkk3Taj8ZmolB?=
 =?us-ascii?Q?o+1cpHlFjjLvLgXMemEiq0EeKH8rzvRs5h53t8RsDLWc4PSgQQAX/FQKjPvf?=
 =?us-ascii?Q?4DrxhM4nUaR/2hLaMuka8YCP14ZpiYSL65yflfLIe6K43R3sjA9pJSex1lkI?=
 =?us-ascii?Q?9OAdXhjorOnxczimPXITjBPkqSN4p+i0vObb3ixqExP88RhlHxVOMlI18A9V?=
 =?us-ascii?Q?P9CdYxKMMMQjuuZP0LH9r5A02Dczrhf1Nt4BVbZNDzeuOTKVCVoxT6eA+ra4?=
 =?us-ascii?Q?33ZmpJnWdtkKfmLPiX8346SESuJ/bAiQ9VJ4X4ku+5Z2Y5iJruzk5xXJfCTF?=
 =?us-ascii?Q?a42PLViSbT7itGBwKnZMZhc+WbHPaEAUtiusPyaRuDUcoGJX75Rk8aDI8Ny5?=
 =?us-ascii?Q?J4ynMvrq5t2NqTUa5ncfQlnIcZqnLS5m7G0+M9uqFuzwPWgOmW1dAsiCA+VI?=
 =?us-ascii?Q?mX49aTaAu3TAbmcE8BkCcFN/KIlAmNxkHXi7Tv7NoBBqQ11xqC/fBQEz9BB4?=
 =?us-ascii?Q?vBRu7KLciud+Z/e3CFsMwhuxTgYMniQRzSOPIsc0MFFvkODFlpX+b6eIyE0/?=
 =?us-ascii?Q?Gfxl/57ojETLZ4dwpzGZwxREYz7i7JzfC1hJQ1lf76j97PwqGpxr8VSJnNP8?=
 =?us-ascii?Q?JiZ4SIbaxsNBZG0nsWF97lQ5imULTfuXthKLvCbQezSgZQ8qHd9x6XR8eSdz?=
 =?us-ascii?Q?IfRIW5ekQ/o8zwMQqi2CjThD244nWsPDMW6st+zBpDg42EuePjUt+QFoZYt/?=
 =?us-ascii?Q?lhMq26TqpJ8KUFBfaA65fbq5o72JiVbfLiTsLzOzzE1wZmSMvamepYhpQp9R?=
 =?us-ascii?Q?t9NvD6wCp4rJLVet9yMSw0RZFXUZw1Q9p9W3JV7zdgjFz3VDUvpHxusnsXpX?=
 =?us-ascii?Q?8wMnqGirU1C0xHxa+q3vwQP/M+ZJ7kT1jaNHUdOMMphvuF15Qi14ESRxuXhx?=
 =?us-ascii?Q?5VUJQ2rdT2SrrxMNlQsmqFAKcYJZyo5m3GSUnhFxGFldQ37pmPvgIjG0YGzZ?=
 =?us-ascii?Q?pkdi4M1CZFoaOHB0CH/hW1ks?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 562238a3-528b-493e-5646-08d8d91251bf
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2021 22:19:58.0303 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sYKOJke+LbYtPPM0493GmF1/CbjP3DKjCjFe8k5Zij991ZCMe0mmZw5gcP3X0P1RH3wjBMK++UGtayUipbfYFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4175
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Oak Zeng <Oak.Zeng@amd.com>,
 Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Oak Zeng <Oak.Zeng@amd.com>

Add more function pointers to amdgpu_mmhub_funcs. ASIC specific
implementation of most mmhub functions are called from a general
function pointer, instead of calling different function for
different ASIC.

V2: Split patch into upstreamable and aldebaran

Signed-off-by: Oak Zeng <Oak.Zeng@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c   |  3 +++
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c | 35 +++++++++++--------------
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.h | 14 ----------
 3 files changed, 18 insertions(+), 34 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 32b552e54e77..44fc85b78563 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1129,6 +1129,9 @@ static void gmc_v9_0_set_mmhub_funcs(struct amdgpu_device *adev)
 	case CHIP_ARCTURUS:
 		adev->mmhub.funcs = &mmhub_v9_4_funcs;
 		break;
+	case CHIP_ALDEBARAN:
+		adev->mmhub.funcs = &mmhub_v1_7_funcs;
+		break;
 	default:
 		adev->mmhub.funcs = &mmhub_v1_0_funcs;
 		break;
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
index fd9aebb0ca2d..bf339063008c 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
@@ -36,7 +36,7 @@
 #define regVM_L2_CNTL3_DEFAULT	0x80100007
 #define regVM_L2_CNTL4_DEFAULT	0x000000c1
 
-u64 mmhub_v1_7_get_fb_location(struct amdgpu_device *adev)
+static u64 mmhub_v1_7_get_fb_location(struct amdgpu_device *adev)
 {
 	u64 base = RREG32_SOC15(MMHUB, 0, regMC_VM_FB_LOCATION_BASE);
 	u64 top = RREG32_SOC15(MMHUB, 0, regMC_VM_FB_LOCATION_TOP);
@@ -282,20 +282,7 @@ static void mmhub_v1_7_program_invalidation(struct amdgpu_device *adev)
 	}
 }
 
-void mmhub_v1_7_update_power_gating(struct amdgpu_device *adev,
-				bool enable)
-{
-	if (amdgpu_sriov_vf(adev))
-		return;
-
-	if (enable && adev->pg_flags & AMD_PG_SUPPORT_MMHUB) {
-		if (adev->powerplay.pp_funcs && adev->powerplay.pp_funcs->set_powergating_by_smu)
-			amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_GMC, true);
-
-	}
-}
-
-int mmhub_v1_7_gart_enable(struct amdgpu_device *adev)
+static int mmhub_v1_7_gart_enable(struct amdgpu_device *adev)
 {
 	if (amdgpu_sriov_vf(adev)) {
 		/*
@@ -323,7 +310,7 @@ int mmhub_v1_7_gart_enable(struct amdgpu_device *adev)
 	return 0;
 }
 
-void mmhub_v1_7_gart_disable(struct amdgpu_device *adev)
+static void mmhub_v1_7_gart_disable(struct amdgpu_device *adev)
 {
 	u32 tmp;
 	u32 i;
@@ -356,7 +343,7 @@ void mmhub_v1_7_gart_disable(struct amdgpu_device *adev)
  * @adev: amdgpu_device pointer
  * @value: true redirects VM faults to the default page
  */
-void mmhub_v1_7_set_fault_enable_default(struct amdgpu_device *adev, bool value)
+static void mmhub_v1_7_set_fault_enable_default(struct amdgpu_device *adev, bool value)
 {
 	u32 tmp;
 
@@ -398,7 +385,7 @@ void mmhub_v1_7_set_fault_enable_default(struct amdgpu_device *adev, bool value)
 	WREG32_SOC15(MMHUB, 0, regVM_L2_PROTECTION_FAULT_CNTL, tmp);
 }
 
-void mmhub_v1_7_init(struct amdgpu_device *adev)
+static void mmhub_v1_7_init(struct amdgpu_device *adev)
 {
 	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_MMHUB_0];
 
@@ -491,7 +478,7 @@ static void mmhub_v1_7_update_medium_grain_light_sleep(struct amdgpu_device *ade
 		WREG32_SOC15(MMHUB, 0, regATC_L2_MISC_CG, data);
 }
 
-int mmhub_v1_7_set_clockgating(struct amdgpu_device *adev,
+static int mmhub_v1_7_set_clockgating(struct amdgpu_device *adev,
 			       enum amd_clockgating_state state)
 {
 	if (amdgpu_sriov_vf(adev))
@@ -511,7 +498,7 @@ int mmhub_v1_7_set_clockgating(struct amdgpu_device *adev,
 	return 0;
 }
 
-void mmhub_v1_7_get_clockgating(struct amdgpu_device *adev, u32 *flags)
+static void mmhub_v1_7_get_clockgating(struct amdgpu_device *adev, u32 *flags)
 {
 	int data, data1;
 
@@ -595,4 +582,12 @@ static void mmhub_v1_7_query_ras_error_count(struct amdgpu_device *adev,
 const struct amdgpu_mmhub_funcs mmhub_v1_7_funcs = {
 	.ras_late_init = amdgpu_mmhub_ras_late_init,
 	.query_ras_error_count = mmhub_v1_7_query_ras_error_count,
+	.get_fb_location = mmhub_v1_7_get_fb_location,
+	.init = mmhub_v1_7_init,
+	.gart_enable = mmhub_v1_7_gart_enable,
+	.set_fault_enable_default = mmhub_v1_7_set_fault_enable_default,
+	.gart_disable = mmhub_v1_7_gart_disable,
+	.set_clockgating = mmhub_v1_7_set_clockgating,
+	.get_clockgating = mmhub_v1_7_get_clockgating,
+	.setup_vm_pt_regs = mmhub_v1_7_setup_vm_pt_regs,
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.h b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.h
index dc2bb6cfbe73..bf2fbeb172d1 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.h
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.h
@@ -25,18 +25,4 @@
 
 extern const struct amdgpu_mmhub_funcs mmhub_v1_7_funcs;
 
-u64 mmhub_v1_7_get_fb_location(struct amdgpu_device *adev);
-int mmhub_v1_7_gart_enable(struct amdgpu_device *adev);
-void mmhub_v1_7_gart_disable(struct amdgpu_device *adev);
-void mmhub_v1_7_set_fault_enable_default(struct amdgpu_device *adev,
-					 bool value);
-void mmhub_v1_7_init(struct amdgpu_device *adev);
-int mmhub_v1_7_set_clockgating(struct amdgpu_device *adev,
-			       enum amd_clockgating_state state);
-void mmhub_v1_7_get_clockgating(struct amdgpu_device *adev, u32 *flags);
-void mmhub_v1_7_update_power_gating(struct amdgpu_device *adev,
-                                bool enable);
-void mmhub_v1_7_setup_vm_pt_regs(struct amdgpu_device *adev, uint32_t vmid,
-				uint64_t page_table_base);
-
 #endif
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
