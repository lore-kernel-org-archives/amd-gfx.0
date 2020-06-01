Return-Path: <SRS0=+jgF=7O=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2501AC433E1
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 17:28:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED1F0206A4
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 17:28:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="0fHFoy9M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED1F0206A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B5C5089D79;
	Mon,  1 Jun 2020 17:28:33 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2046.outbound.protection.outlook.com [40.107.94.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2129F89D4F
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2020 17:28:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lYcFtxA4eBMgFfQXZC4PJXyZIYlUAbJv61A/m64rEFuBp2aW98kTS4VTBwTEyGMmcOdZgFzYIfaqq7m4fFue9KBE2e+yAPdbShE0l74TNCztB+srghLTCpYVurrDtwGb4ggUCc7v0wnokjkiOPrqxV1S9wduTRMAEDkCnWuCPD0PP6GHwD79UNEt4K7nniHbKm8z/QJCxdbgPbtbKBLoVAqPxVQNc9A2ucxLm/zMnQ/MUIYBNTLpNvIEfPWNy9URal+WYUiGHHHIGIVJzSivpElGGwCE+yIlsxOcOYM8HY0whUcpWAR7alk1s0SvxMT8thI3xxyEHt99RrB0xImB0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bEbhfdp9B2cIHSqTIbX1rKUKgC0Y8r2iv4b0zGABXoA=;
 b=eq5O8cWIJZ7GZC1zduEsAxT/9CC5lC7zNAcewZvzysDDz+bH2w4WttbnWN2Ktpo29kvYvMjNZT2h/u8ZUKZPX5fepILYlTCjAjdzwzWLYDb/ACWExyD9Cz0EKVBc90VOlaxLW1z3Gwy4fS+TQAwzQseI1BGU0PRevoMudHWNA9r22XJd//rm/gPAIK3b5+DuOfpN1LNaxI/FjgvCIRrt7enD4kHWpCVB4Je2W05jSIYEJZs2B3zXH+v90mdP1ISi9ObEvtkqsg0QzfCw7/tnY07cvJcPkop2LTsJx2TAnv8fYDTjUFEKny5llB1DHm7PdAzD4ZMPVbmazhzLyU1k8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bEbhfdp9B2cIHSqTIbX1rKUKgC0Y8r2iv4b0zGABXoA=;
 b=0fHFoy9MiwIA65hPw5WHC1IvJhUV1uhAKgOXAo5ep0mVCgorUPGSlP1ZGOz86pIpROLt4MakksK53rrrZWzsIY+c07EGegpztMSBLHz3T8dyqJJZgimXJ+kWhsdEe6gwoXYGxD7dH6S2wNtqQ8g5gYGxuCQK3opI/dcmOtGe1eU=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3721.namprd12.prod.outlook.com (2603:10b6:5:1c2::18)
 by DM6PR12MB2668.namprd12.prod.outlook.com (2603:10b6:5:4a::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.17; Mon, 1 Jun
 2020 17:28:31 +0000
Received: from DM6PR12MB3721.namprd12.prod.outlook.com
 ([fe80::e027:654c:5d9f:a648]) by DM6PR12MB3721.namprd12.prod.outlook.com
 ([fe80::e027:654c:5d9f:a648%3]) with mapi id 15.20.3045.024; Mon, 1 Jun 2020
 17:28:31 +0000
From: Kent Russell <kent.russell@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amdgpu: Add unique_id and serial_number for Arcturus
Date: Mon,  1 Jun 2020 13:28:18 -0400
Message-Id: <20200601172818.5560-2-kent.russell@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200601172818.5560-1-kent.russell@amd.com>
References: <20200601172818.5560-1-kent.russell@amd.com>
X-ClientProxiedBy: YTBPR01CA0033.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::46) To DM6PR12MB3721.namprd12.prod.outlook.com
 (2603:10b6:5:1c2::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from krussell.amd.com (165.204.55.251) by
 YTBPR01CA0033.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::46) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3045.19 via Frontend Transport; Mon, 1 Jun 2020 17:28:30 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 98f4fe3d-f049-40d9-cd2d-08d806513419
X-MS-TrafficTypeDiagnostic: DM6PR12MB2668:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB2668D86A35BCF0F9DFE9C57F858A0@DM6PR12MB2668.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1002;
X-Forefront-PRVS: 0421BF7135
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KeLgDcFy3i6e0QcpIHfYx8wxaGoXtLMEcCJIyJGjjr+dvEesf9YAt9lmBi3QGP5W5aRrI/U4cEb4hD+ZPg+w4w9m94j3Y339ECp7KpPvhojR2yIRCEekxf3E6Rrp62xy5NJ6cTg1hJM6B9ZDr5bB3syDJxoUW2s5eN5UeFo1+mIjQbj/JKcJ5M2dSue6R7ZyEyn8fCBgUy+1A3YN+kiEyR2sSWN4kHSBpzb4ZNCpdUw0+lnRcEhduzHkj9M1ZeGU1vc+2a9CfDSQpWLIcpLlw3tRGbhRUAlJzI/Gqw2wFGRhF5ACW5Iu9wfJtjpuP++m
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3721.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(376002)(346002)(396003)(136003)(366004)(66476007)(2616005)(44832011)(956004)(66946007)(8676002)(83380400001)(4326008)(8936002)(66556008)(6916009)(316002)(36756003)(5660300002)(478600001)(2906002)(7696005)(16526019)(26005)(6486002)(186003)(6666004)(52116002)(86362001)(1076003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: EfsW687nZma3oJFbDob7p56tcPuXFRrpm6usgf4BVUF8+t+KEmzWLd2zDCTaWUzAmqdmnmA4JE47WrUwSnm8HbaZX8PCIO9PSLEFtAsWJK0gd5pv1fUGqoKBgPBU+cmjYTi1r0NOvycOAPnwt2OoGfN0Hp2SsCr78X0QZTIqYx/PwbBjnUALUuHg5BFzscGSpQYBdW6JyN/YBqIAz/mQqOgVYSdaQd2HReSKBs9KZKPiGZ7VYBT36D44D7al0NSCS7Ki1OkrPBX8edGKNDI6RWoV+yrxmGeUb4JxxTdfPUtPZcJCfC2rp7SIYuVXha4m+fLfLn0k3x83+V75TqzeWX3nEqdS+eCQ5sfG6+sGkR298JBdA/ZK3X9yZnlIt1Z8I5/X/Uf5h04bPgsGTklc9mmV/yaGKNXc1Kod5DkRqAQWm/LrXMfyHaMqjMwzO2z/Iz5RhUlZwn3V9fsT3ppAmOwnNb4BVkcXA1vkU05+wYc9fhHxZrrSgGSPCEWPgB3W
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98f4fe3d-f049-40d9-cd2d-08d806513419
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2020 17:28:31.1237 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XJv9vdEgp4BLn12oBg5lX7Cbpgu2zPaEtRpbcRgwEVDjjYzJikNpd0udZnJ5TgPtov1QdYn+2NiHA7OJZ1fjRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2668
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

Signed-off-by: Kent Russell <kent.russell@amd.com>
Change-Id: I3b036a38b19cd84025399b0706b2dad9b7aff713
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c        |  2 +-
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c    |  2 ++
 drivers/gpu/drm/amd/powerplay/arcturus_ppt.c  | 32 +++++++++++++++++++
 .../gpu/drm/amd/powerplay/inc/amdgpu_smu.h    |  1 +
 drivers/gpu/drm/amd/powerplay/smu_internal.h  |  2 ++
 5 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
index b0dff9ecfb88..9136d9022c51 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
@@ -1940,7 +1940,7 @@ static int default_attr_update(struct amdgpu_device *adev, struct amdgpu_device_
 		if (adev->flags & AMD_IS_APU)
 			*states = ATTR_STATE_UNSUPPORTED;
 	} else if (DEVICE_ATTR_IS(unique_id)) {
-		if (!adev->unique_id)
+		if (asic_type < CHIP_VEGA10)
 			*states = ATTR_STATE_UNSUPPORTED;
 	} else if (DEVICE_ATTR_IS(pp_features)) {
 		if (adev->flags & AMD_IS_APU || asic_type < CHIP_VEGA10)
diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
index 5294aa7cdde1..7946fd8444a3 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -793,6 +793,8 @@ static int smu_late_init(void *handle)
 	if (!smu->pm_enabled)
 		return 0;
 
+	smu_set_unique_id(smu);
+
 	smu_handle_task(&adev->smu,
 			smu->smu_dpm.dpm_level,
 			AMD_PP_TASK_COMPLETE_INIT,
diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
index d66ac7457574..855e609650d9 100644
--- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
@@ -2262,6 +2262,37 @@ static void arcturus_i2c_eeprom_control_fini(struct i2c_adapter *control)
 	i2c_del_adapter(control);
 }
 
+static void arcturus_set_unique_id(struct smu_context *smu)
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
+	.set_unique_id = arcturus_set_unique_id,
 	.init_microcode = smu_v11_0_init_microcode,
 	.load_microcode = smu_v11_0_load_microcode,
 	.init_smc_tables = smu_v11_0_init_smc_tables,
diff --git a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
index 5bb1ac821aeb..bfa5211de079 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
@@ -495,6 +495,7 @@ struct pptable_funcs {
 	int (*update_pcie_parameters)(struct smu_context *smu, uint32_t pcie_gen_cap, uint32_t pcie_width_cap);
 	int (*i2c_eeprom_init)(struct i2c_adapter *control);
 	void (*i2c_eeprom_fini)(struct i2c_adapter *control);
+	void (*set_unique_id)(struct smu_context *smu);
 	int (*get_dpm_clock_table)(struct smu_context *smu, struct dpm_clocks *clock_table);
 	int (*init_microcode)(struct smu_context *smu);
 	int (*load_microcode)(struct smu_context *smu);
diff --git a/drivers/gpu/drm/amd/powerplay/smu_internal.h b/drivers/gpu/drm/amd/powerplay/smu_internal.h
index 6c59eeef2590..125d976215a6 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_internal.h
+++ b/drivers/gpu/drm/amd/powerplay/smu_internal.h
@@ -218,6 +218,8 @@ static inline int smu_send_smc_msg(struct smu_context *smu, enum smu_message_typ
 		((smu)->ppt_funcs->i2c_eeprom_init ? (smu)->ppt_funcs->i2c_eeprom_init((control)) : 0)
 #define smu_i2c_eeprom_fini(smu, control) \
 		((smu)->ppt_funcs->i2c_eeprom_fini ? (smu)->ppt_funcs->i2c_eeprom_fini((control)) : 0)
+#define smu_set_unique_id(smu) \
+		((smu)->ppt_funcs->set_unique_id ? (smu)->ppt_funcs->set_unique_id((smu)) : 0)
 
 #define smu_log_thermal_throttling(smu) \
 		((smu)->ppt_funcs->log_thermal_throttling_event ? (smu)->ppt_funcs->log_thermal_throttling_event((smu)) : 0)
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
