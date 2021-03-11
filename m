Return-Path: <SRS0=bDL0=IJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF629C433E0
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Mar 2021 01:59:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F26D64F81
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Mar 2021 01:59:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F26D64F81
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2147A6E425;
	Thu, 11 Mar 2021 01:59:22 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770074.outbound.protection.outlook.com [40.107.77.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C54E86E425
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Mar 2021 01:59:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d90iu997NdQ5JBIuqhT3KOnqlF7t3xF+synjltAse2/atykOXpUXwqgwUejfeI0w/LQrgvGNFFPNTWqGqXUyrdN0G47LOjQMygVqsq+1d679Nt+pU83Aw0o2Lu9Vkcb3rFRLgXEFotZAkv6fdgdPXa3ZSwk6xK1FHjWod0cKRZf14R6WoUxzRhssnMb1VeIotPmCSYqhYd1OPATnbfWuB15CO25VuH3Qnn9lPOFbO6iAyzS2gCPbEWdqFFnB9KYaVay+u6Tj9aGHVzCUSFZSNBLtTnAkAEDvOWDqYIygNuDpChO4/aOqTZY79e5JUBRGsiG9d4j2qSi8d0oDBefyqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wkdTMuGGXTtFdC6V1ewuCAl9OZxa2HYQ/YwS5LEKv/4=;
 b=mxqN8OdbmdKWwCh7rLCzHUhYJZqaEIntYgHNrFnDJm1ym8j6Uld0Ye0sp5jvpy2n0RZvJQL2szB8tn0Q1VrTs3g9UcMjA3u7szryjIORNW8yPVeL+8cbm2cRQDJJbdQAZCwZ+VM7dVmVOTu2OsfhCGf20mBNfEYYSkG2Yg1OH8MbeXGaqi1gl+Si1/BRgNeYfhavnEOm+wT41nQF2aYVTfHQYGR8hR5X8fPVdx+ngWAGF1o57I7HiR+GBlobwJsAXSUCpCybTTjtFHt/oiCjgPSDi54F1SaNpDd0w2h18VRq1O2r35V2ht2t3J8HhjJZYClSvg5Q0Y+/CjPu+eGKWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wkdTMuGGXTtFdC6V1ewuCAl9OZxa2HYQ/YwS5LEKv/4=;
 b=CKJZbHcGVbME4dk/ALbagJ2ukXLBzr09tQnsts163RhR6QGEGddxoFnnNgVBjorqHgZZlR/zoqIxm6Aml++uL4CvD0dmMvbDezv/Ny04Fo27iFSNTDDulfhxO0EiQTx/b2vnG9ttnbt7YgqjzFUAWC8iquXo3ze5cgWKdI9QzeI=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3835.namprd12.prod.outlook.com (2603:10b6:5:1c7::12)
 by DM6PR12MB3116.namprd12.prod.outlook.com (2603:10b6:5:38::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Thu, 11 Mar
 2021 01:59:19 +0000
Received: from DM6PR12MB3835.namprd12.prod.outlook.com
 ([fe80::102:2c9a:54ce:63e9]) by DM6PR12MB3835.namprd12.prod.outlook.com
 ([fe80::102:2c9a:54ce:63e9%6]) with mapi id 15.20.3912.027; Thu, 11 Mar 2021
 01:59:18 +0000
From: shaoyunl <shaoyun.liu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amd/pm: Add LightSBR SMU MSG support
Date: Wed, 10 Mar 2021 20:59:07 -0500
Message-Id: <20210311015907.7066-1-shaoyun.liu@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.250]
X-ClientProxiedBy: YTXPR0101CA0048.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::25) To DM6PR12MB3835.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from shaoyunl-dev1.amd.com (165.204.55.250) by
 YTXPR0101CA0048.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.26 via Frontend
 Transport; Thu, 11 Mar 2021 01:59:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 803ec8a9-56f0-49dc-5592-08d8e431480b
X-MS-TrafficTypeDiagnostic: DM6PR12MB3116:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3116B01A0EF76D1BA834FF91F4909@DM6PR12MB3116.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 33in3EykXWaZiBlE0OHuTqSl40Skw88WcYwf11fSrywnM+RdJSh5E8bpG65Fh3zUks0SBshwWFG3+H6BEu1wYZZ+O4w4vRHkTNxQcNvT48F+NtVhcIAufIodkyjaX1cYUwGIDljVO6ueyKhc1xcdWDJSHAhSHIGsf2p+bAKAsQyxfo9sBf0DbGHUXBblHJs9Rdu4QhrMk+Ej9NWEZU2NbyZMw5NBofLgvIGYvfTjYf6wrzvRvV/Cd8CM1tCF5Eeae9UvxzeW8j3Ohw1LEvv9shbHEOlVDWg1V5AqHcpv2ajBTLNdQ4yQ8CSSiKoyT9xcndCWztzFZT9umjk6vtTwDMGpkqr0TM/i4UOkWXNDlV7p8z3R/eL5KpFJjwin1MtDux/i9iFlqCGHmZDIbrzNrKvrstL4T7wIAtmLjwCSpEtU4FH7Lvvg3pzeQNXibSSU7fCgLU4ScFfpkwpGxg94iUcY3oPA8ADvWaKTfx4Gy6UmBw2+Xlkp3LB/+YoaV8HMVrXBN3WOjHmhCrc9a0SxfcCKrS+gLq9vUVr5QElGLK7QvrkvB/frOh4e2lh+I27/
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3835.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(346002)(396003)(39860400002)(136003)(6486002)(956004)(66946007)(8676002)(6666004)(1076003)(2616005)(66556008)(478600001)(8936002)(86362001)(2906002)(186003)(316002)(26005)(4326008)(66476007)(52116002)(5660300002)(83380400001)(19627235002)(36756003)(7696005)(6916009)(16526019)(43062005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?FL6ugXy4y+QG183cH+o3fhuRvf2zrW/MxBU+b2LRY1mgD5IJwCloNMTDqc7L?=
 =?us-ascii?Q?peqPgQZuYyXKI4haAIdHc/gbTdS5qMBU8kJ5D6n9gRuHasItNoyalqkBX48H?=
 =?us-ascii?Q?6N7kAF32mY//CYPwwju8JkNkibHYWCZJUD6ai3Uqg8UKr+VPy35pZbNxsC9+?=
 =?us-ascii?Q?GS+O430v0eX/upLOj9/l+muppCzRiSZUvSdXjunIDwiDPmMi+k+8dVmJVcI8?=
 =?us-ascii?Q?geRs7Pq+VBOV8w4Cukp8PPWcim1x6l/1sboncaVhAnzlhnCjcmGWtu8hUP5+?=
 =?us-ascii?Q?xh9fYmUocurNtkqWGJvzAUaej3bQv7UVz31QvB8BrOK8rLL7CX7X28izR3TV?=
 =?us-ascii?Q?bJ4zZVvX2m625zBVZza+K6ExxPcDXOq3M/Qd5/VWsRIgrAsz9CiWqO5b752e?=
 =?us-ascii?Q?1b450x+n7V+C7v9eLZyb/rnlTTPtfS+ufx8+lEXi5q9IEl1oPLziNIQUxMgh?=
 =?us-ascii?Q?iNYakEya1L5OCbMNFLRgkRNDoPzh9dSAwgjZnCiPnGs1lmBp/E776EIFdDnJ?=
 =?us-ascii?Q?bjsGFE6R0x4Ugm56uJjdMMpWCqwEkWDoBK+vEVvXazH9Mwh7I0MR1FV4LyTH?=
 =?us-ascii?Q?SjWWp515oSY47OCs6cAsvYYS7WRxBpgAQuBSgb0peWOsmfsucAg1aQjZXn/o?=
 =?us-ascii?Q?3quiX7wMtSb4HlGaug0i7Hk/43HRQlx91NbjVxSQIDl83d4eKC0VYsWTqpc6?=
 =?us-ascii?Q?zei3JN8sDlxod0i/xrKO9IAfRkA2xmuW9lmXyiX+76SfKFd+UTaOD/DbhcBO?=
 =?us-ascii?Q?CO7rjZgGlp+mDWRv7OUZ1PAnIPe09TG09+4fL8rH6NWTlwTrygIk0tWImRuR?=
 =?us-ascii?Q?Pf6HIOHK+9Gb+2MGnlUoBFIlH+o5HChbt28AWr7qthCrT/yLkeD4Hk9V+2iH?=
 =?us-ascii?Q?8jYrNCWjuE49KcJ9ABX5PmC61M7P/415Amgl+oadFeCBY4MtNtsVOQE1z6FD?=
 =?us-ascii?Q?p5hnwq6aXNLl5js5vpy17S9ZKHfM2g+M6UG7igf6stMRvPXY78BuzQRu8hqH?=
 =?us-ascii?Q?iGi49RD66SLopyAb82o/x1worLEMPJMnEoTRNXu0uQiSJE9LggX/V+IW1jGu?=
 =?us-ascii?Q?tfgF7KLR/LyAU8v623ShUi4VVJWYc8ap+ljHt/rpJk+nffZHzxbN739idPcJ?=
 =?us-ascii?Q?nmAlNo/8a0RXSfLkkvIKGAPwBrjqpd9vXGOG8WqMaBrQwF29fzpDJ4r8VwW3?=
 =?us-ascii?Q?QsPEFZCIvh3oz2mOWPbihWvYJ8iIt5E0XxRZ1CZnlUWnuKEegDNySZRUFEMl?=
 =?us-ascii?Q?KTc204Um26uepqvYUQyvX+3qJAbRnk37IlZ5y1z0W45wXACSVhptf5jJvUHp?=
 =?us-ascii?Q?uKrmi7WgCK6IBKIOmzvhQkK9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 803ec8a9-56f0-49dc-5592-08d8e431480b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3835.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2021 01:59:18.8916 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AmU6hm9LmiGH4JDn2YLyJIEI6OVpzCzQYQsAW/kWrqNbRnWX5aNS7xZLVct5jfpCfMY7Mb04bg2doJLV05/lXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3116
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

This new MSG provide the interface for driver to enable/disable the Light Secondary Bus Reset
support from SMU. When enabled, SMU will only do minimum NBIO response to the SBR request and
leave the real HW reset to be handled by driver later. When disabled (default state),SMU will
pass the request to PSP for a HW reset

Signed-off-by: shaoyunl <shaoyun.liu@amd.com>
Change-Id: I5f0e48730d2b4b48fed8137aa57c683d5b3d1b9f
---
 drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h           |  7 +++++++
 drivers/gpu/drm/amd/pm/inc/arcturus_ppsmc.h       |  7 +++++++
 drivers/gpu/drm/amd/pm/inc/smu_types.h            |  1 +
 drivers/gpu/drm/amd/pm/inc/smu_v11_0.h            |  2 ++
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c         | 13 +++++++++++++
 drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c |  2 ++
 drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c    | 10 ++++++++++
 7 files changed, 42 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
index c02ffbd1df76..5ac683fd0749 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
@@ -1153,6 +1153,11 @@ struct pptable_funcs {
 	 *                                      parameters to defaults.
 	 */
 	int (*set_fine_grain_gfx_freq_parameters)(struct smu_context *smu);
+
+	/**
+	 * @set_light_sbr:  Set light sbr mode for the SMU.
+	 */
+	int (*set_light_sbr)(struct smu_context *smu, bool enable);
 };
 
 typedef enum {
@@ -1356,5 +1361,7 @@ ssize_t smu_sys_get_gpu_metrics(void *handle, void **table);
 int smu_enable_mgpu_fan_boost(void *handle);
 int smu_gfx_state_change_set(struct smu_context *smu, uint32_t state);
 
+int smu_set_light_sbr(struct smu_context *smu, bool enable);
+
 #endif
 #endif
diff --git a/drivers/gpu/drm/amd/pm/inc/arcturus_ppsmc.h b/drivers/gpu/drm/amd/pm/inc/arcturus_ppsmc.h
index 79afb132164e..45f5d29bc705 100644
--- a/drivers/gpu/drm/amd/pm/inc/arcturus_ppsmc.h
+++ b/drivers/gpu/drm/amd/pm/inc/arcturus_ppsmc.h
@@ -120,6 +120,13 @@
 #define PPSMC_MSG_ReadSerialNumTop32		 0x40
 #define PPSMC_MSG_ReadSerialNumBottom32		 0x41
 
+/* paramater for MSG_LightSBR
+ * 1 -- Enable light secondary bus reset, only do nbio respond without further handling,
+ *      leave driver to handle the real reset
+ * 0 -- Disable LightSBR, default behavior, SMU will pass the reset to PSP
+ */
+#define PPSMC_MSG_LightSBR			 0x42
+
 typedef uint32_t PPSMC_Result;
 typedef uint32_t PPSMC_Msg;
 #pragma pack(pop)
diff --git a/drivers/gpu/drm/amd/pm/inc/smu_types.h b/drivers/gpu/drm/amd/pm/inc/smu_types.h
index e9a0bda98fd7..5bfb60f41dd4 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu_types.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu_types.h
@@ -224,6 +224,7 @@
 	__SMU_DUMMY_MAP(EnableDeterminism),		\
 	__SMU_DUMMY_MAP(DisableDeterminism),		\
 	__SMU_DUMMY_MAP(SetUclkDpmMode),		\
+	__SMU_DUMMY_MAP(LightSBR),			\
 
 #undef __SMU_DUMMY_MAP
 #define __SMU_DUMMY_MAP(type)	SMU_MSG_##type
diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
index bf570a7af6a7..907e0967a9e8 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
@@ -295,5 +295,7 @@ int smu_v11_0_deep_sleep_control(struct smu_context *smu,
 
 void smu_v11_0_interrupt_work(struct smu_context *smu);
 
+int smu_v11_0_set_light_sbr(struct smu_context *smu, bool enable);
+
 #endif
 #endif
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 6a6fafc11588..1202b9e7d0f9 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -2972,6 +2972,19 @@ int smu_gfx_state_change_set(struct smu_context *smu, uint32_t state)
 	return ret;
 }
 
+int smu_set_light_sbr(struct smu_context *smu, bool enable)
+{
+	int ret = 0;
+
+	mutex_lock(&smu->mutex);
+	if (smu->ppt_funcs->set_light_sbr)
+		ret = smu->ppt_funcs->set_light_sbr(smu, enable);
+	mutex_unlock(&smu->mutex);
+
+	return ret;
+}
+
+
 static const struct amd_pm_funcs swsmu_pm_funcs = {
 	/* export for sysfs */
 	.set_fan_control_mode    = smu_pp_set_fan_control_mode,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index f76d1b8aeecc..f82dd8a5c773 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -142,6 +142,7 @@ static const struct cmn2asic_msg_mapping arcturus_message_map[SMU_MSG_MAX_COUNT]
 	MSG_MAP(GmiPwrDnControl,		     PPSMC_MSG_GmiPwrDnControl,			0),
 	MSG_MAP(ReadSerialNumTop32,		     PPSMC_MSG_ReadSerialNumTop32,		1),
 	MSG_MAP(ReadSerialNumBottom32,		     PPSMC_MSG_ReadSerialNumBottom32,		1),
+	MSG_MAP(LightSBR,			     PPSMC_MSG_LightSBR,			0),
 };
 
 static const struct cmn2asic_mapping arcturus_clk_map[SMU_CLK_COUNT] = {
@@ -2363,6 +2364,7 @@ static const struct pptable_funcs arcturus_ppt_funcs = {
 	.deep_sleep_control = smu_v11_0_deep_sleep_control,
 	.get_fan_parameters = arcturus_get_fan_parameters,
 	.interrupt_work = smu_v11_0_interrupt_work,
+	.set_light_sbr = smu_v11_0_set_light_sbr,
 };
 
 void arcturus_set_ppt_funcs(struct smu_context *smu)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
index 97acb04e1b5a..635bd5da2133 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -1603,6 +1603,16 @@ int smu_v11_0_mode1_reset(struct smu_context *smu)
 	return ret;
 }
 
+int smu_v11_0_set_light_sbr(struct smu_context *smu, bool enable)
+{
+	int ret = 0;
+
+	ret =  smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_LightSBR, enable ? 1 : 0, NULL);
+
+	return ret;
+}
+
+
 int smu_v11_0_get_dpm_ultimate_freq(struct smu_context *smu, enum smu_clk_type clk_type,
 						 uint32_t *min, uint32_t *max)
 {
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
