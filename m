Return-Path: <SRS0=9uSV=II=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A6D2C433DB
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Mar 2021 22:47:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3868E64FC6
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Mar 2021 22:47:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3868E64FC6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D684689BDB;
	Wed, 10 Mar 2021 22:47:40 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2064.outbound.protection.outlook.com [40.107.243.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 00E5189BDB
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Mar 2021 22:47:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FGVPeBpWGOHHJzDtuw9OFUgrkrEHNn9fUcyVamLYFyXjkCFfhPtQh5QOcEppwVU0UInjOBAY0iYRrVYV5cfc7d1yc+g67kibVDm9vrzp70wtA9TS0ODQaNQgRDzCYcvEvamSu8pF9HM6QOL/EQpNnrc5yO3f3Stqo0RYcyOrWB8VCC/9SMVEkuNEEfZ+ReZ8Xq9TJ54tllciaN/4I3QffbgDWnJJfZCR9316LBQcCEOnrW8YoNh2bk7T4Gy2145l1Lnrw8M9bo2L5FR8U2RCrqS1oascMq1+xbWYnh6IdUWxJ8Y+b0pqhVERLwkOvJwL2wjF/j9qlnFuAhjjToO2Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4RErS+wjT0tuUq3tdnxbUNKsNBWWIdpRM/8qc4RIPVM=;
 b=FXBEjF+Oj9LFa2cwqt+wwtw57w9a7+yP15w+myNBuEf/MGXqjMRQ/cIstyDs0f9WpSLMnZF6UXNjTuUfwygHQDbb1Ezf06RS/e1GN6LBesi0wOjAgvEk3Yl/02mHYXaEyrmqyD3cOzX7YzOgDJYud6dVNkSfNZb9zTlCTwRM2RVmx8b5wehBXuq8LAC2r0bghKNh6fQYcjyjP0Zfp9sdf1c9kyZ+5FKHyTwryGK/o9B59Q5AWIv1he2UK2Ej5ih+JQo1m4gMhOKIHuJRG7dGFt5nkbNeSYJBSfrAqg8QFEezhJu4OKV9NCjqbyt9wiE7oHt9tUEoWVWddZ6TRE5mPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4RErS+wjT0tuUq3tdnxbUNKsNBWWIdpRM/8qc4RIPVM=;
 b=OgwYJKnvHPcEzouz4ZcRMfk0yspKW4UWHWC9eVh0ifqSi5oiybWIMzxo3jbxhPorA12dvkZNgleB2vX4FiYdV7zxugLUjze5yGAZ3IRYHmIYFx/IutOdH3zfeiCsnKsHpjWRt6pjiGmaIwrHn0qZ8K09kgMN/6Zbm7rAQ4Zzmng=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3835.namprd12.prod.outlook.com (2603:10b6:5:1c7::12)
 by DM6PR12MB4268.namprd12.prod.outlook.com (2603:10b6:5:223::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.28; Wed, 10 Mar
 2021 22:47:38 +0000
Received: from DM6PR12MB3835.namprd12.prod.outlook.com
 ([fe80::102:2c9a:54ce:63e9]) by DM6PR12MB3835.namprd12.prod.outlook.com
 ([fe80::102:2c9a:54ce:63e9%6]) with mapi id 15.20.3912.027; Wed, 10 Mar 2021
 22:47:38 +0000
From: shaoyunl <shaoyun.liu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amd/pm: Add LightSBR SMU MSG support
Date: Wed, 10 Mar 2021 17:47:25 -0500
Message-Id: <20210310224725.10205-1-shaoyun.liu@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.250]
X-ClientProxiedBy: YT2PR01CA0030.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::35) To DM6PR12MB3835.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from shaoyunl-dev1.amd.com (165.204.55.250) by
 YT2PR01CA0030.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:38::35) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3912.26 via Frontend Transport; Wed, 10 Mar 2021 22:47:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 11fc5f89-f435-4a47-8e5d-08d8e416817a
X-MS-TrafficTypeDiagnostic: DM6PR12MB4268:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB426834B7B6F2218A10B64C40F4919@DM6PR12MB4268.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +FIH+dIgOYmjLVW84cw1BgnAattOUCsn2ozB2SUrHcxWBk1A4WrCe5mTQti5mImQvGZOqzeVd7cKPV8QpEh1UBpngeu07bSkUR0pQdS2zQ7rLwx4BLbO0Ubzd2tEJ/SDrYM/j8l3TMaEFav100MaRq6b2YiICjVL0I3q3ge5rJ0wsZGvGiwi/mP1MDPIS7cNPDDdnn38ks9SSUYmuNWJatZ1fboEN+gJUFTGwHuKcB36/5F/L7lf5L+Xmpg2gn6+IaSRVtfTxED8g1VyqKY0eLMX1zDa8BjMXyhWM3rUhSlaEUrz6SaVS+UlHFmh9GfIyqA0JiBrF0wmxPOoh82dyHSH9Tjoffve/67mhU2aJQU0MHje7Am82QG58cBOFuvt2SyKTW4X+uKzMBZD6LsYF50P29UXJsUngwKG7FbD7JENmXLQgFY4cUx39gD6WIvdmlJMtJ8CAlqCIHnN7Dyx7/hpK368s97b9UVKFW/Qtl06dGCnyRj2GiLqtTEKstUp1+0gnlGLu1aTOCLGm4h+H70zDQ1cmoxrdCYwJMENKb5dtwhr0dxUGpAG01APcDjC
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3835.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(366004)(136003)(396003)(346002)(66556008)(66476007)(19627235002)(2906002)(8936002)(316002)(6486002)(16526019)(6666004)(186003)(86362001)(52116002)(7696005)(956004)(2616005)(4326008)(1076003)(36756003)(478600001)(8676002)(66946007)(26005)(83380400001)(6916009)(5660300002)(43062005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?I1Pae3ReUfbNULqv2IRIvMUYI998dvzQlizIaFGx7K2OuxtEgpJgSr+Xd/wq?=
 =?us-ascii?Q?XyQmlZit2Cvl1zKVA5Sf1VE1j7nc3HkEWoymt6A9MeCegoEGTHps/myOMHqe?=
 =?us-ascii?Q?fR9XwHHvDTgpWjrkI0osX/Y5yRBQgTI+h4puhcOuGGuDXEW4mE6fAiyzR8CT?=
 =?us-ascii?Q?ch+f84wjd4BtrcPCzMJf8/e/7zJjOwEqGmgVugpnoCm07T7vF8OiygwlfX4U?=
 =?us-ascii?Q?qWARe3Gc0zjQ/tI6Iw7S2RWt9TU6zDmejniNplPFD0ys7Pb+u37YqcKxYx6m?=
 =?us-ascii?Q?y6DeCN56bp05CK1U7xBP+QeAz9rJ5m97N491sFIG2qe8IvhmaO9ot3/6JjxO?=
 =?us-ascii?Q?AddchC6PUYlmaG2bPy6InzstgUGBnsPnEfBSEiyeszPxGnDxdaWjXXuF06f+?=
 =?us-ascii?Q?Ol+8wQQkUC6nL160m0QX5BoGHhQhJ2QHeBbjMYklg/JQl7sDhHbX3PNb1Wz5?=
 =?us-ascii?Q?gzPRAw+xZzLogL+oOW8Dq4Ted9aT+SyMLSQwyjbf9ECbdUzZ7tntSStECbBg?=
 =?us-ascii?Q?xGZ8TBPeMUOjjP1hGil8tVp7M+sfmCgb6XtWI0N8QZBUMbLX9Lq/X/GmF6Dc?=
 =?us-ascii?Q?G3deoNdDCzBbBrxpw4WuOFw6bmEYGQ+g8ib2r/vJtoJDIVwNRV7YdOlTWw4d?=
 =?us-ascii?Q?zwzlSSgl4bovxs3J5MhkAeUlrqJdg6O7/Ez9CyqSfP7RJhMsnJ5yrs/PKICw?=
 =?us-ascii?Q?L0vsKBaf9CVKr9HCyZfMVE9O1F4i47S86jSn4oCg4U85JQmpN15yPcRWaNOy?=
 =?us-ascii?Q?H6lgJDdcrn7/+2fQv8Pd3AVtVT+sr8Kw1ZVj54TBcUJwR1G7Bas0bu81iwmr?=
 =?us-ascii?Q?04QQHaDYYKGGRadIhFR6AvfQxlSGrY/LbNR16FRyfDcCbMoI7/9NKyv9XEaD?=
 =?us-ascii?Q?XJWTCsVUVVlAnhG5e3DhAv8XDmLx8IQM3SmduEPYZWsr86I275w36KsIMGHv?=
 =?us-ascii?Q?clChpJflST1LrZGOIAaV4E/+4P0EoyjYl3hsISISPYEtvwLxdMW0jBs0Bfeu?=
 =?us-ascii?Q?PAAmB0AAcGKTd6jsV6tvW0J46X0j3vz2H9LPvg6J0isfd02KOL1k/88ngte/?=
 =?us-ascii?Q?rY11QEcgq9JYJA5APeCO7UZBEkGpOChJdWA7FAvzSXj3izrzjBkf1YXuwtfq?=
 =?us-ascii?Q?2pAGRKCoYrmaVkWkmw/tZuvsA91Mpp09DvuIwSRqSh13ExJ/VTcQxxyB9g+C?=
 =?us-ascii?Q?TRJdROX9DBZVvCnscCgI27zD5YAJq1cJ1AtM1hZU2wP6bzi3mBga/siJ9cpg?=
 =?us-ascii?Q?oRYtHD6bjKTWzxPgoAYO8yJ0AUt3H9g8XaEye4kL5lv9lkViGoEig4iqrfmM?=
 =?us-ascii?Q?F9O290GLCf3w92nL/w3PthzG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11fc5f89-f435-4a47-8e5d-08d8e416817a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3835.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2021 22:47:38.6960 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dgCEEhx1oqH9C8LOMdoOzb+SaZT9HAL/yOXvqZQZNwKD+ssWq0MCnMTOIhhhb9NhOkK7g63dxGBuDGFMzYo+fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4268
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
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c         | 12 ++++++++++++
 drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c |  2 ++
 drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c    | 10 ++++++++++
 7 files changed, 41 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
index 00186a3b29be..ba015816d771 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
@@ -1149,6 +1149,11 @@ struct pptable_funcs {
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
@@ -1350,5 +1355,7 @@ ssize_t smu_sys_get_gpu_metrics(void *handle, void **table);
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
index aa4822202587..92f72d770a99 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu_types.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu_types.h
@@ -214,6 +214,7 @@
        __SMU_DUMMY_MAP(SetSlowPPTLimit),                \
        __SMU_DUMMY_MAP(GetFastPPTLimit),                \
        __SMU_DUMMY_MAP(GetSlowPPTLimit),                \
+       __SMU_DUMMY_MAP(LightSBR),                       \
 
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
index 502e1b926a06..d9baf97ce1c9 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -2934,6 +2934,18 @@ int smu_gfx_state_change_set(struct smu_context *smu, uint32_t state)
 	return ret;
 }
 
+int smu_set_light_sbr(struct smu_context *smu, bool enable)
+{
+	int ret = 0;
+
+	mutex_lock(&smu->mutex);
+	ret = smu->ppt_funcs->set_light_sbr(smu, enable);
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
index 1882a0643f7a..e16e083d84c6 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -1601,6 +1601,16 @@ int smu_v11_0_mode1_reset(struct smu_context *smu)
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
