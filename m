Return-Path: <SRS0=q3BR=7P=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 675AEC433E0
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jun 2020 16:22:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B5382067B
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jun 2020 16:22:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="g6CB999v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B5382067B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E69236E154;
	Tue,  2 Jun 2020 16:22:02 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2084.outbound.protection.outlook.com [40.107.220.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F234D6E154
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Jun 2020 16:21:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W6Q3ugJv06PJMLdWXTCeUxOd9OPTD4MNNceYNT5StQYRsrsu8iPCBcG0hWV+RtamXpVfRfjcOztc+ZupSlPTPoIuR1AhbMZWUPjyF5EvPrpUwmXMpXNmDCGRDDP0+YXxHeFc+nPkoOj7R1CoQnWgiT82lC6nd6FbkKZGiaZpQlXXbdXlif2qN5BCgItVF0SULZmWzdBvZwEQLZph0eIXG/c/5ju1RhEC7UomCCEppkJ5jA0uYgeQCQ+rc+M7NXMAJKcUTohSvhTVbHNZzjfELABh8MgV0o8zlvZeBM6liHQQhZkt8osDG6QYl0b8V2SEDSzKMM8NpNtt4n0XYflAsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y7ZM955VUbuLv4E0nnXGEVkoA/CsAOWq5R6qj4khzss=;
 b=bXHDIsFNuPefoAhhaJ8WFMoUmjFtmzChH+GsYBA059f0GXvk/4rn4ythCCh9LF05QVmu/6ZvjE/2iAaXR6fCieFnIxEAjvQFxREgH7AZs79/est9Vl8QFq0JSjaEv2PDUAVD0H4cQ3dDW/nh2VDTQ31eGQdfmi8MyoFlzg9dLeaZBS5zbKfwjrvmwRx7LoPNsF1TXX2k/ShBzO+HeFH3U6uGEBkXeiR39kphg3v/6oZIZdYT3v9JuxK5pse9gaCx3bLWap+PSsg0tE3XNoiHX8jF2JbRMn6m//sRkBWNwpP9hYUfTS3g8z564A3yrZXdMKaeTXsbexZoeiOzCW7JdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y7ZM955VUbuLv4E0nnXGEVkoA/CsAOWq5R6qj4khzss=;
 b=g6CB999vvnm+AMSeavLTPPxiEDENTOSuHPuR5qbMx8LvE/f9wA2hiGx4liWyeJgPakHqOvFnNw7u2P+Di/GFm3c1zylY/iFMI4O/w6tXPZwr/Ak/q48iUNfHh8f7GkwPl4U9Ozin/5m92RqQvLuM1skecYEahlpI3J5mz0Pf6Yg=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3721.namprd12.prod.outlook.com (2603:10b6:5:1c2::18)
 by DM6PR12MB3116.namprd12.prod.outlook.com (2603:10b6:5:38::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Tue, 2 Jun
 2020 16:21:59 +0000
Received: from DM6PR12MB3721.namprd12.prod.outlook.com
 ([fe80::e027:654c:5d9f:a648]) by DM6PR12MB3721.namprd12.prod.outlook.com
 ([fe80::e027:654c:5d9f:a648%3]) with mapi id 15.20.3045.024; Tue, 2 Jun 2020
 16:21:59 +0000
From: Kent Russell <kent.russell@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amdgpu: Add unique_id and serial_number for Arcturus
 v3
Date: Tue,  2 Jun 2020 12:21:48 -0400
Message-Id: <20200602162148.21624-2-kent.russell@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200602162148.21624-1-kent.russell@amd.com>
References: <20200602162148.21624-1-kent.russell@amd.com>
X-ClientProxiedBy: YT1PR01CA0153.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::32) To DM6PR12MB3721.namprd12.prod.outlook.com
 (2603:10b6:5:1c2::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from krussell.amd.com (165.204.55.251) by
 YT1PR01CA0153.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2f::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3045.19 via Frontend Transport; Tue, 2 Jun 2020 16:21:58 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7d544244-78f6-423b-6010-08d8071112fd
X-MS-TrafficTypeDiagnostic: DM6PR12MB3116:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3116A3DCE8FDA07A03B665AE858B0@DM6PR12MB3116.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1002;
X-Forefront-PRVS: 0422860ED4
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3AS4GKwgobTg9f/YYW2Q3AdVFzi154iXybgbZ2cWcuykp5CLb/nEyGWM1f0h3lV0sKKTMryklx3iBJhieu50TrUPWNjnq4pAE/c05394zqovzkhlnsGVAlzcq1aPlkOrxgyuCFbMVvpftNkCBc31Yhnv7d3Ca6P+1NePrZE4JqM/GxuZAXWJc5/YqGtrSyFUIfIrU4n4M4FMhtJUEoI5MA3J1quHlHazSEdfgczqk5Z8ZYdm1FIt1Ia0+hXGOsAnAueYkTmO7tNVXt6qtHNF+teZzTaw66/iX3OtgrdwuY+IfSwz32jrjSp9tMf/F0Iu
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3721.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(366004)(376002)(346002)(396003)(136003)(478600001)(44832011)(66476007)(316002)(66556008)(66946007)(52116002)(5660300002)(86362001)(7696005)(1076003)(2616005)(83380400001)(8936002)(16526019)(26005)(36756003)(8676002)(956004)(186003)(4326008)(2906002)(6666004)(6916009)(6486002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: aAANpHp3roXa2tcf9MQ68fbjP15oasAKp935Vc34eHPjRCc5BMzv6ZsNnPXqUtMkmTaKjfqwayEThLKJgwiiXO7Sst6MKMcm3d8ni9bGCiSlTSBMU8TGJAEorZSuO4csDtNbZB54D3wV3mMHeurEVyCupMWUU/FiDL8NK7hcyJCA0dDnXOX8Z+D78qkURXJtPNq2Jau8KTfcLvOT2/Pc9wiXKjLUUEALgc/NYBA5ANMOTxclvYaLKPQs+3xd/HZfZveI7fnyjpMRZg0pyIIJRfiCrqVCBfB1BcVBAJzvGyFc0ftx8SI21xQgpFzj7tRshtVfEqxpcdTWiPZExa420v3OC/2Lj9XR+0y0gRTjOj+zMmP1WTqcO1Lpps+ICqX36W3rH2wL07Yzqi2MwBMvwVRgjscCNe2Ry+1QLZprZj9XlD+EZJ5D6PBRF/qcj2LCF6df7T8bctDkFN7x0SDPeUm1SZXDEPaNI48fYJA2fxUz9twff5nGrLRkPeUcmzQb
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d544244-78f6-423b-6010-08d8071112fd
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2020 16:21:58.8488 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZS3b+EKe87bttTSZ8OLYbNY7UMGH9y0P9EE6HAbhYJ4ok5GWrnNl0wEnLQWS16kOIJuaVnPdBcsBhuL6HSYFMQ==
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
Cc: Kent Russell <kent.russell@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add support for unique_id and serial_number, as these are now
the same value, and will be for future ASICs as well.

v2: Explicitly create unique_id only for VG10/20/ARC
v3: Change set_unique_id to get_unique_id for clarity

Signed-off-by: Kent Russell <kent.russell@amd.com>
Change-Id: I3b036a38b19cd84025399b0706b2dad9b7aff713
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c        |  4 ++-
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c    |  2 ++
 drivers/gpu/drm/amd/powerplay/arcturus_ppt.c  | 32 +++++++++++++++++++
 .../gpu/drm/amd/powerplay/inc/amdgpu_smu.h    |  1 +
 drivers/gpu/drm/amd/powerplay/smu_internal.h  |  2 ++
 5 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
index b0dff9ecfb88..b2cdc8a1268f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
@@ -1940,7 +1940,9 @@ static int default_attr_update(struct amdgpu_device *adev, struct amdgpu_device_
 		if (adev->flags & AMD_IS_APU)
 			*states = ATTR_STATE_UNSUPPORTED;
 	} else if (DEVICE_ATTR_IS(unique_id)) {
-		if (!adev->unique_id)
+		if (asic_type != CHIP_VEGA10 &&
+		    asic_type != CHIP_VEGA20 &&
+		    asic_type != CHIP_ARCTURUS)
 			*states = ATTR_STATE_UNSUPPORTED;
 	} else if (DEVICE_ATTR_IS(pp_features)) {
 		if (adev->flags & AMD_IS_APU || asic_type < CHIP_VEGA10)
diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
index 5294aa7cdde1..847502faca90 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -793,6 +793,8 @@ static int smu_late_init(void *handle)
 	if (!smu->pm_enabled)
 		return 0;
 
+	smu_get_unique_id(smu);
+
 	smu_handle_task(&adev->smu,
 			smu->smu_dpm.dpm_level,
 			AMD_PP_TASK_COMPLETE_INIT,
diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
index d66ac7457574..df7b408319f7 100644
--- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
@@ -2262,6 +2262,37 @@ static void arcturus_i2c_eeprom_control_fini(struct i2c_adapter *control)
 	i2c_del_adapter(control);
 }
 
+static void arcturus_get_unique_id(struct smu_context *smu)
+{
+	struct amdgpu_device *adev = smu->adev;
+	uint32_t top32, bottom32, smu_version, size;
+	char sn[16];
+	uint64_t id;
+
+	if (smu_get_smc_version(smu, NULL, &smu_version)) {
+		pr_warn("Failed to get smu version, cannot get unique_id or serial_number\n");
+		return;
+	}
+
+	/* PPSMC_MSG_ReadSerial* is supported by 54.23.0 and onwards */
+	if (smu_version < 0x361700) {
+		pr_warn("ReadSerial is only supported by PMFW 54.23.0 and onwards\n");
+		return;
+	}
+
+	/* Get the SN to turn into a Unique ID */
+	smu_send_smc_msg(smu, SMU_MSG_ReadSerialNumTop32, &top32);
+	smu_send_smc_msg(smu, SMU_MSG_ReadSerialNumBottom32, &bottom32);
+
+	id = ((uint64_t)bottom32 << 32) | top32;
+	adev->unique_id = id;
+	/* For Arcturus-and-later, unique_id == serial_number, so convert it to a
+	 * 16-digit HEX string for convenience and backwards-compatibility
+	 */
+	size = sprintf(sn, "%llx", id);
+	memcpy(adev->serial, &sn, size);
+}
+
 static bool arcturus_is_baco_supported(struct smu_context *smu)
 {
 	struct amdgpu_device *adev = smu->adev;
@@ -2416,6 +2447,7 @@ static const struct pptable_funcs arcturus_ppt_funcs = {
 	.dpm_set_uvd_enable = arcturus_dpm_set_uvd_enable,
 	.i2c_eeprom_init = arcturus_i2c_eeprom_control_init,
 	.i2c_eeprom_fini = arcturus_i2c_eeprom_control_fini,
+	.get_unique_id = arcturus_get_unique_id,
 	.init_microcode = smu_v11_0_init_microcode,
 	.load_microcode = smu_v11_0_load_microcode,
 	.init_smc_tables = smu_v11_0_init_smc_tables,
diff --git a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
index 5bb1ac821aeb..13fc5773ba45 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
@@ -495,6 +495,7 @@ struct pptable_funcs {
 	int (*update_pcie_parameters)(struct smu_context *smu, uint32_t pcie_gen_cap, uint32_t pcie_width_cap);
 	int (*i2c_eeprom_init)(struct i2c_adapter *control);
 	void (*i2c_eeprom_fini)(struct i2c_adapter *control);
+	void (*get_unique_id)(struct smu_context *smu);
 	int (*get_dpm_clock_table)(struct smu_context *smu, struct dpm_clocks *clock_table);
 	int (*init_microcode)(struct smu_context *smu);
 	int (*load_microcode)(struct smu_context *smu);
diff --git a/drivers/gpu/drm/amd/powerplay/smu_internal.h b/drivers/gpu/drm/amd/powerplay/smu_internal.h
index 6c59eeef2590..c9440c978402 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_internal.h
+++ b/drivers/gpu/drm/amd/powerplay/smu_internal.h
@@ -218,6 +218,8 @@ static inline int smu_send_smc_msg(struct smu_context *smu, enum smu_message_typ
 		((smu)->ppt_funcs->i2c_eeprom_init ? (smu)->ppt_funcs->i2c_eeprom_init((control)) : 0)
 #define smu_i2c_eeprom_fini(smu, control) \
 		((smu)->ppt_funcs->i2c_eeprom_fini ? (smu)->ppt_funcs->i2c_eeprom_fini((control)) : 0)
+#define smu_get_unique_id(smu) \
+		((smu)->ppt_funcs->get_unique_id ? (smu)->ppt_funcs->get_unique_id((smu)) : 0)
 
 #define smu_log_thermal_throttling(smu) \
 		((smu)->ppt_funcs->log_thermal_throttling_event ? (smu)->ppt_funcs->log_thermal_throttling_event((smu)) : 0)
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
