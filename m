Return-Path: <SRS0=9uSV=II=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBD98C433E6
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Mar 2021 17:55:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72F7864FAB
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Mar 2021 17:55:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72F7864FAB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D60E6EA52;
	Wed, 10 Mar 2021 17:55:14 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2052.outbound.protection.outlook.com [40.107.237.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BCDE56EA52
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Mar 2021 17:55:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VhrZiSRJyYLGH7ky/FTA32pjc/S0ZyKorFEO4g9TgDTX3fFnG9wm4qAOWLm0hWozH/WyE8S2JjzRD8MnvQOCaG9fTHyrC2Emd5CDa7WXNOqP1ivLdRPPxPuSf9ZR1HoJ1iOH7/XNpowXnkPSVjevMCh9lrPVXGH1czsrAC/JDsijrd9yeVHd2MjysWsQRhrAR4MF1aSClP3Tg1uigLvrsNBdyRe5q2Wou51UepuPhGbJl18umYtsiansjkmci/alE90a3h9foXf8xRSd0eds94tv2udBgu+RGpi3hm/+O7lXg39OcvY9ol4KMTklvtOwqZWN3sdCl6qjOkJYjERd9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j14orVFZpqHuhNIGPAYebHYXQc/Nj8QmjlWyHDN8lVI=;
 b=T7c6myf1uYX9ZzG71EkJswXh8grokNLjQnCmPKN4KW5x4tztj5TdOZTmrW/5/zcFfZAfsyvFIgU52oDZeTdU5aUZh/8aYfcDn0362z8+G4Si7RMG08pJPQSsKIJn4XCKjzSoyBtPmLhwgMlyVbMY2AvONpLErbMj6SxRfimEpH63K9BmJIkmf+sLcKmob5kAvsedBPBCh+ISzz2wGKFSxj3+BEqgq3gPfILv5TMe1JRjcloKDcgv6QxOLTYcCRJ1gRZCgmWjITEFAzRfdjWbaDzV4+BQTao9hsy2yXIvHmLl3lQR5pDEISgQHVSOrNpSBI9gh3ABFDm9+0bTzuoZVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j14orVFZpqHuhNIGPAYebHYXQc/Nj8QmjlWyHDN8lVI=;
 b=dPnOsSrjxrCWt8rv06ueR73ZrB4BdLsoY0XdpSuFtbPqaTvKRvfbouQ3aLDrPMwn82OeHpneKle7Z8vUAVVzcpWfewwbPD9IX0V0nIBjQpqn6JVliRWd0pusjqnoq57ROZXZiyK1MuTJkO5A5g2Tbxp/ogR7ja0E3bfY+F/lnUw=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3835.namprd12.prod.outlook.com (2603:10b6:5:1c7::12)
 by DM5PR12MB1658.namprd12.prod.outlook.com (2603:10b6:4:5::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3912.17; Wed, 10 Mar 2021 17:55:10 +0000
Received: from DM6PR12MB3835.namprd12.prod.outlook.com
 ([fe80::102:2c9a:54ce:63e9]) by DM6PR12MB3835.namprd12.prod.outlook.com
 ([fe80::102:2c9a:54ce:63e9%6]) with mapi id 15.20.3912.027; Wed, 10 Mar 2021
 17:55:10 +0000
From: shaoyunl <shaoyun.liu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amd/pm: Add LightSBR SMU MSG support
Date: Wed, 10 Mar 2021 12:54:57 -0500
Message-Id: <20210310175457.9754-1-shaoyun.liu@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.250]
X-ClientProxiedBy: YT1PR01CA0054.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::23) To DM6PR12MB3835.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from shaoyunl-dev1.amd.com (165.204.55.250) by
 YT1PR01CA0054.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2e::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3912.26 via Frontend Transport; Wed, 10 Mar 2021 17:55:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3753cb93-9672-4e7c-5638-08d8e3eda61f
X-MS-TrafficTypeDiagnostic: DM5PR12MB1658:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB165815DD68749D5CC39481A1F4919@DM5PR12MB1658.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pr7JzqywUGMBJV2tuhlEGnsYf7VZL0+RbpLGvj68TOc6WGGUIc6ve27JzjIvSL5/5hNeDj450GhZsx7vh8v6VavTbGewlZQC847oLNBEHfpCPqgaFl1Ii7Xexy/c9eNuT5mXpW1hxIEzXMYb3WjpvMKT6oTmwf5pPliSP/z1saKO3buQgN3NUC609qHNCINtV2mK8MqpafxEglkMTMrDO9vUJE8AEaeJxDWtkna8w4qI2xcdq3SIm2RK+phmewcPi+0/U880y/AgUd4zlsup+ZFiVQ9+DNOcCWhBFoPNaXx5dWja8C26M3DHfcqdVXzzdYjDZwGyBbZkhXrbdPIHXidGsd3cr0nnI/yc4PNPQWZAPQbdOx+OOXylsnStPwv2XrpOcqs0gap7osWqgz8+NVDkjvNEE/n1NRtAYLCDAGyrJ1JchopiHLZpo+YgwAJ8iRlhs+lfSjXm35cSgG+2DgRi2f1Xa/KHVyVKFVcDAoAt0Z3YH/if8CtXEJKVnmCzVBWvZuYWb0K5MhBV+rZNe6r09+Ny1vpbA9oyqd1ZC9y6bv5ZN2y0Dd+LUbEwq9ZZ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3835.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(136003)(39860400002)(376002)(396003)(66556008)(6666004)(66476007)(6486002)(36756003)(2906002)(66946007)(8676002)(316002)(16526019)(26005)(86362001)(19627235002)(5660300002)(478600001)(4326008)(8936002)(956004)(2616005)(7696005)(1076003)(52116002)(6916009)(83380400001)(186003)(43062005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?pEhKoNQISpyrlvAh+gMYLEhbVN0JjkwRx09dLqnOjwcyAsbRJljmJEwlzy6F?=
 =?us-ascii?Q?qA2V4nlaRFhlgwbt5StX6IoR1/apc+ZCbHOy9HRKXvN5fyUk6QXcq6HDFpIZ?=
 =?us-ascii?Q?JpuLa053JU2vd5R0qbFEDHZwonlcKu0rQrRmgHW0dPHSt6bJj15bZmr97x8N?=
 =?us-ascii?Q?K2Rgjjh6E9szpaBPcSHy6raIkolp1eAVwpGFjeMdYYkTxkLuxJV2c0M/dmzR?=
 =?us-ascii?Q?p7x71TXBaLBYdrKwoxvhzTe1OgBAoWXxVycpJpJVqGE6aVwU2iEuF1pHsKkp?=
 =?us-ascii?Q?amoHHLuh4T+8GCx0OGLtLfE8wX+314dljNGMpbuwPNicP2D02LiKAkMAMv/i?=
 =?us-ascii?Q?o3vvFiN4C2gOW3GdEfd6r01vGqDU8dp8J0HgQo5XdXi8O30zAVmm6PdUBd+s?=
 =?us-ascii?Q?StWgfUVrWQTGJUKyi87j+eXyrPqhnxXKFkKFuLdI0VW6QFkDAyIGznvlzkug?=
 =?us-ascii?Q?nHpBXDQ3oR9m3Z211KM3ChRsgo/g4CnTzDUhnR44Ksmnz9xUKPGt55l5rYOK?=
 =?us-ascii?Q?ndekwyIP+7DqlcWVWHeiymw77ZiQ8br87GaGsVgOz8jVCmePzXgntIkQstZd?=
 =?us-ascii?Q?fklAVcACh0lFORbLYXIyDsqP5G2o8Qov6ojH0dyc25q1oOSHUQFLe9u5VLLx?=
 =?us-ascii?Q?5iT1+ZVVgWe6bFvxnI0VBhgIXrMkh2j65wyXh89LMbKB934Lzu0vvd6sPOsp?=
 =?us-ascii?Q?9AREUN47ab2CA4J92i9LyyC8nl3uyyTGMeMBL/gKtecLG2nE7C/gwUfdrsKG?=
 =?us-ascii?Q?QA+uZECAGSvxo05Qf7dBiiM2QTg26KwQe6M++wpxvN5HFU8GzfgO2UQQHn1g?=
 =?us-ascii?Q?75M8IvxIEedo08pVXaj5iVfLbqtXGVzwlBPbO8VNdXhRXvBs1VolYBroNQ52?=
 =?us-ascii?Q?duq4XDeAewodIFQZ1Vf2uy5mxcmUBFeE+X8+C9OYSko7r25RIWD0lEg6zHuR?=
 =?us-ascii?Q?H6znDgqCdq7wIwwJ9veLwBvXM0xE5g657w3/ESfqz5eN7mxb2jRHN5kb3XMi?=
 =?us-ascii?Q?qxw/V/1YCN9i6+Ak+4am6aSauX1hbavdI+FpyDJ5CisfpUcIhTSHRyE0Sevv?=
 =?us-ascii?Q?Lbk1s7BPKbPbW8H1HYktZHJFt/08HsNT53M6Qq7mAvQMFb5IwaVxcj/VwAXQ?=
 =?us-ascii?Q?gIS8Ws5jewj5I1OKCSffre7Nn8kJQcm2usuFO6vDO+US98qPL1DX7ibtVLYT?=
 =?us-ascii?Q?o6BnZCrQnLoShXZ8HKQOJSNw77Yl/lNB4DMghII7ey8k5y7a1w3ayqG2jDn6?=
 =?us-ascii?Q?1oBbrX0VhUY2DFVrFLqekxh4vlmBd4g1zu7xTXMLc+xSnkKX1NMwmmfeN6HX?=
 =?us-ascii?Q?2o50e+gXmr25SrARRIYy1pIe?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3753cb93-9672-4e7c-5638-08d8e3eda61f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3835.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2021 17:55:10.8440 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PIgvCfHsKPUxTBUKePdFyZGnGqhqr9OrY9QZX9vY0jVNuGLQU2kfDVAGciGClpB+s/15jabtHESRpb/X1nwZJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1658
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
index 00186a3b29be..369f0267b1f2 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
@@ -1149,6 +1149,11 @@ struct pptable_funcs {
 	 *                                      parameters to defaults.
 	 */
 	int (*set_fine_grain_gfx_freq_parameters)(struct smu_context *smu);
+
+	/**
+	 * @set_lightSBR: Set lightSBR mode for the SMU.
+	 */
+	int (*set_lightSBR)(struct smu_context *smu, bool enable);
 };
 
 typedef enum {
@@ -1350,5 +1355,7 @@ ssize_t smu_sys_get_gpu_metrics(void *handle, void **table);
 int smu_enable_mgpu_fan_boost(void *handle);
 int smu_gfx_state_change_set(struct smu_context *smu, uint32_t state);
 
+int smu_set_lightSBR(struct smu_context *smu, bool enable);
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
index bf570a7af6a7..7c7b149e7a83 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
@@ -295,5 +295,7 @@ int smu_v11_0_deep_sleep_control(struct smu_context *smu,
 
 void smu_v11_0_interrupt_work(struct smu_context *smu);
 
+int smu_v11_0_set_lightSBR(struct smu_context *smu, bool enable);
+
 #endif
 #endif
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 502e1b926a06..58f508c36084 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -2934,6 +2934,18 @@ int smu_gfx_state_change_set(struct smu_context *smu, uint32_t state)
 	return ret;
 }
 
+int smu_set_lightSBR(struct smu_context *smu, bool enable)
+{
+	int ret = 0;
+
+	mutex_lock(&smu->mutex);
+	ret = smu->ppt_funcs->set_lightSBR(smu, enable);
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
index f76d1b8aeecc..73a30208aa71 100644
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
+	.set_lightSBR = smu_v11_0_set_lightSBR,
 };
 
 void arcturus_set_ppt_funcs(struct smu_context *smu)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
index 1882a0643f7a..29aef6eeb55b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -1601,6 +1601,16 @@ int smu_v11_0_mode1_reset(struct smu_context *smu)
 	return ret;
 }
 
+int smu_v11_0_set_lightSBR(struct smu_context *smu, bool enable)
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
