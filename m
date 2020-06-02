Return-Path: <SRS0=q3BR=7P=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56781C433E0
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jun 2020 12:53:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E18020663
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jun 2020 12:53:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="kbJtXcRS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E18020663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CFDAE89CF2;
	Tue,  2 Jun 2020 12:53:18 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2045.outbound.protection.outlook.com [40.107.93.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA6DB89CE3
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Jun 2020 12:53:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UVYgkm128EC0osh8wtKQjX2eY7JWRXyUyvtpZ7duwsfuR+k0om7mgSboPRkj9CoX8yngGWBnQFTx3tcKTWCJa93C//Hf1VdoAHrukTrstOfHRa/y7E0nmMGuKemftdjfgH8Pde+Rr7SCYdAM7x5jkJvfv70g01R4Ke9NkiHEg44XCo8QleKPP4FTIqUOlZalAooGyiKdbuCzPQpOgqQV0tfd2fSd8rKNJHXBDI3rpVBZ4aUWHikyT+4xjZmnOwCAuHSu1D34LJt9x8qZ4thpY4wQZqlmUwYAOlMb9u7VnFzHqiC1owqV2v2sBMDtUxceP6YIF8tfSqs+QipRsIN34Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h2L4SPsEHNc9lupYs8OmRYyBnBPhCIHIwk7b+/kuG8g=;
 b=KWF0+6H+b2d8kUQt2mJu/n/QejRJvUUPh+7ZHMG8h9RKtRkdX0AZflMNV+n9nLUUKeyU42+61QtSY/4Wp11xK0JI39FCE9dQcA8Bs/G5mXdP6o95Mg892mtllgJeFnTr/p7r+TflzANmtbYDztTDgpJRg3rD9WEXnmkp1yItYvBLaCNjHvyvVzoBpvJX0N+6yH0FMQypopXwURbWkyKW2UGOZ1sFogTbwUEOw9ka5+oS1NfDfqVnV7xRnAW31nBsHE9iA3JsvfJz1TpcZ4B0tgBvzfYQ7RrkrnIHMn5zmATpvvj+JvpvAc3DHC/W2abt7NBGWMQL5vq3W7QlOiNG2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h2L4SPsEHNc9lupYs8OmRYyBnBPhCIHIwk7b+/kuG8g=;
 b=kbJtXcRSYpTwT6BHSFfIEvQJdd+Cfu95V0wtWXmeJdv+y3Pcho6KbS7dH4RBqYEUV6Oo2bI3KxVdLAKFg46MmoadNWsH2HWk3hSQfTFQIpUt2dNKGiuxLblZAVuo3dOZNL/UQ2GGLPdIUbb8OMhZSnI1AY1AiaYs9UIL8jH24eQ=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3721.namprd12.prod.outlook.com (2603:10b6:5:1c2::18)
 by DM6PR12MB2828.namprd12.prod.outlook.com (2603:10b6:5:77::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.19; Tue, 2 Jun
 2020 12:53:15 +0000
Received: from DM6PR12MB3721.namprd12.prod.outlook.com
 ([fe80::e027:654c:5d9f:a648]) by DM6PR12MB3721.namprd12.prod.outlook.com
 ([fe80::e027:654c:5d9f:a648%3]) with mapi id 15.20.3045.024; Tue, 2 Jun 2020
 12:53:15 +0000
From: Kent Russell <kent.russell@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amdgpu: Add unique_id and serial_number for Arcturus
 v2
Date: Tue,  2 Jun 2020 08:53:02 -0400
Message-Id: <20200602125302.1839-2-kent.russell@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200602125302.1839-1-kent.russell@amd.com>
References: <20200602125302.1839-1-kent.russell@amd.com>
X-ClientProxiedBy: YTXPR0101CA0040.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::17) To DM6PR12MB3721.namprd12.prod.outlook.com
 (2603:10b6:5:1c2::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from krussell.amd.com (165.204.55.251) by
 YTXPR0101CA0040.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18 via Frontend
 Transport; Tue, 2 Jun 2020 12:53:15 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5062cd35-273f-4240-2b26-08d806f3ea7b
X-MS-TrafficTypeDiagnostic: DM6PR12MB2828:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB28284948FC07737DF89CBA33858B0@DM6PR12MB2828.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1002;
X-Forefront-PRVS: 0422860ED4
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MOpn1/pogMjwfD/5I3Li/jYSh8jK9gvSrr6T+brV8lWfhADgFqNRAp91TKs0+QY6fLCw1E5s+pITqJYpn7ot+sx6M21LYlnsyC2yul2osnE3t/3VN9x6OcOrEw1SQR6NipmigYu+u+TXSoI/0qx+I66jIfuBp5oB7R9/t0XqEWuIk6Ow5AYDZpERoirSc0z3NgEgM6szavHGuwZe90Fac7j+bWlvsI29idxfM4VzIaV2wgYrdpG5XhvhTZMPDYK0+btd71cdkqxk6AsPPDdanTb0iMZBWCjkUK2kAlmerfWy9neHs1ooMwCYRgcZYML4
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3721.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(366004)(376002)(136003)(39860400002)(346002)(316002)(66946007)(4326008)(478600001)(44832011)(956004)(2616005)(86362001)(16526019)(186003)(6486002)(6916009)(26005)(5660300002)(66556008)(66476007)(6666004)(8936002)(8676002)(36756003)(2906002)(1076003)(52116002)(83380400001)(7696005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: QilXpxJHhOpp5ue8267Ero00cs5zWqRcPX3e9Ynw778FdknxyrkaIDjy/65oz5pwdq9pcEziGr28L64/BueHJKgLN2G1P+2LeqUIrcAWIshUA7F72CbcEpUaELKhPent0/5WzxFZCZ/2XYxwMW8FcQ7exASngS2U/jeaqb0h9o0IDccICy4Z/wVf3SSpQ19NmZWfLEclX3EV3QS32tGCwGPRBvbTcmqXtr9IARK8yhGZjlMmvQ4YOgQT1FebzC728UG0YhEyUMD5xAf6WsA7X3MLs+T6hUEZrHF8R9sKB9YAKIVfnfXLf7fv+0r5D25HGGdlfm6w6TICbCa5XKKSBpRUctr3SB7ls3SWedl9kODe2ipdMQR47CDnfyTSL769BfEKTwUh9rrUg6wfB3A4b/29k+FL3DPg9klv2CcIjY6hV+OhAJc6vv7QkScBhcFZF64z+Mnw3hSPDga3czwGwS8bdSazpjYzSdsVIcJ7Du31Zw7ObsAyTVbKentGQhOr
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5062cd35-273f-4240-2b26-08d806f3ea7b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2020 12:53:15.5624 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 48xSTvuWcxKVabiO+3e1GiaqbYTYhsMOSvSPaxhpaPzJj1BPUDSOwidBIAO8Ax+pSq8HnqhjyaAv5rF8fJ6a5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2828
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
