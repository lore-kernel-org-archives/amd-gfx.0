Return-Path: <SRS0=AWwP=FV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BEBCC4361B
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Dec 2020 04:15:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6A912376F
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Dec 2020 04:15:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6A912376F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6DB7F89D99;
	Thu, 17 Dec 2020 04:15:34 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700078.outbound.protection.outlook.com [40.107.70.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2CC5389D6C
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Dec 2020 04:15:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Aqo6IwUmn1oWSM8lm1iCRADFVIkdtModqLFfkXcRfFdWYsZEXVjrlDHHDZS4KB9ATJhU0SrlvgvYFboHygeyxDBmmM5DVkZR3NUsYGgbSFvjzPOLoYYMYpY4pZZCPlFGI0/QoFnutXOZIfZdb/r0mPgem1U3QavvOttKZSKlmAgmJHTry2IAHTeNgz3NjbAVcnHW9Y9ewu/dVuMXv35+P9EMdBBiJMHr9BcHJAfNESatAi1UhQ1u+CN6UrwV/ukXgQ0NzuaP+oDhP0aDtjZhdevbHFHB4W4nuadsHLOIs97USGeo5NbMDgrZxy8NCF8BelWVg+CnbvXGYlrzb6oGnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UzAuMSsLBfZVFu2KbYg9qKvVfMHmV9Aqf/m+mEIPl4E=;
 b=J7omc8hOq1h4lgmsaTHPSTFL3isau592l5MR2VjtPDLGe4WY+gfJLeYlYyi2D6MLXcHNrNttgeql7uxy3ADZVFTA+Oc5OPWvYuLLgWUiF6f/OcvPnZdF7dlA7woj6ROtvCEwJzS8p8C0+jclEY60VqTElyy4OTpvEI8harv3Gxb+A+r1t2ndRzBOBnRMDc+aRp33FCfJ/7JU/q4TmgrVdyPWLX2g3zitJPdGs9JAHuIODBOj8HwzxPr7lN7rQdxPQR/mszWTzgeoYZ6dXi1BDAN00UpKod+4OGxRZWnO0DZwcaOrPTsuF2ZVq2U7lBvIU1JwLhodI35eNsZ8fa/d0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UzAuMSsLBfZVFu2KbYg9qKvVfMHmV9Aqf/m+mEIPl4E=;
 b=LF5bLGL5rHpTFr0fU3SlwH2SYVVPmPSMMbskTAHTW7mvBkJihui53zY6apnVsSD0TjZwDILGRUMwsSeoGGFouzTDZo5QtGWFo2CG8DLYXDyQDUufxVEpah6KJd6v6IHvwa15Qlm8XeZhlANZP125MDisggNHegge9vLoYgRyRng=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR12MB2359.namprd12.prod.outlook.com (2603:10b6:4:b4::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3676.25; Thu, 17 Dec 2020 04:15:31 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5a6:dfb2:fdfd:2d91]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5a6:dfb2:fdfd:2d91%6]) with mapi id 15.20.3654.026; Thu, 17 Dec 2020
 04:15:31 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/3] drm/amd/pm: support overdrive vddgfx offset setting(V2)
Date: Thu, 17 Dec 2020 12:14:55 +0800
Message-Id: <20201217041455.87870-3-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20201217041455.87870-1-evan.quan@amd.com>
References: <20201217041455.87870-1-evan.quan@amd.com>
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HKAPR03CA0009.apcprd03.prod.outlook.com
 (2603:1096:203:c8::14) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (180.167.199.189) by
 HKAPR03CA0009.apcprd03.prod.outlook.com (2603:1096:203:c8::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3676.9 via Frontend Transport; Thu, 17 Dec 2020 04:15:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3d8d8f6c-5b8a-4272-edf7-08d8a24264e4
X-MS-TrafficTypeDiagnostic: DM5PR12MB2359:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB23590459C76BC17ECB04580AE4C40@DM5PR12MB2359.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:843;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jaOjqc1KW3kmVBqCzVCn5xvE93q2HYjABjB3b3oH6mq2N2OytPpjpBIFfjCtcCHYYokmteTERZXOyLdY6JButyBHAPAOyxJriJ3YiDPWFVRFCuBfyvpaO1vZYYn7FwCt7kcKL+wZ7kY5eGJH1rr7rPoM5+EtWEHFynyX7AzUij4FdEIzwnnWANkGgkejDax/3reKOocW6FOhToj7ifh2dmffpzh7jHVycRpUhjOIdQSJGh9GXoTewQFArhnRak54g8fhmDRboBshoGSToQOFPP4xz27PkMFp9MUVcs0oXYNNIme5LkCPTnCdj3wKuWE5GHpWwBAqiF4vME3chTCI06XSADCm9AKRfg7cTIMqnxamsn+JrK7CM/gNyzAkxxALkkDjYrJc1A8ABtcma4ziIw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(39860400002)(346002)(366004)(376002)(66476007)(66556008)(8936002)(54906003)(36756003)(1076003)(26005)(8676002)(316002)(83380400001)(186003)(16526019)(66946007)(86362001)(7696005)(52116002)(6486002)(2906002)(5660300002)(4326008)(478600001)(6916009)(44832011)(956004)(6666004)(2616005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?5qCPhhuPj81CyeLCqefwh0UNftwnxHTNlcQUWXI8VApufBybOhMCzGGmB4eM?=
 =?us-ascii?Q?/R7XKIl1ZoRmDX4zeWPvREpWCO3MB4v7eVM/JGeMzMtGePuXxlFSNSNXYFCF?=
 =?us-ascii?Q?KnaHCK5mWPePCD6m1PgqT8AmTkN6hBeSKu/0OSgjsMDL2Eqc3p1gGDiKB4Nd?=
 =?us-ascii?Q?Vjzanp3J/he7bZ7pREcueaKkyhdfmhYmizxuaNlSqNZFBHIEhfKgAJaKOdaK?=
 =?us-ascii?Q?IXW8JDlvcAuZVKuy/QMUicyCYQ6kItyPJ7hzugf7XSJWpAZQDDOCuL7cQyhq?=
 =?us-ascii?Q?GIhd5CRUJjgLMLSqJNL8ld/WRUyMwEzGtzxR+RFVVeanCUNPloDpaDyJoUtI?=
 =?us-ascii?Q?zlDJdjWpGdr6dabh9wK5M/I72p0UPcQhpK6C5DJjPhZbE/8kzkzGC+fuiq8v?=
 =?us-ascii?Q?qWtoI2Kn34vMAIWC+mbf0Lv/o+vu04eJ2wzx6Bh3ORBfnd5LOcceczcyTvPX?=
 =?us-ascii?Q?WIzpUvGxKlZoijZ4/2D/dATUPmy0zxIP/hgqkUJ3MmutCfPwmnpt8fWalOUU?=
 =?us-ascii?Q?2gPWC3zxxTwGy6tnH1uZl+J5SBjgAdGLMc1W5GyvwGhYrR2KbvI8BYvtnMx6?=
 =?us-ascii?Q?rgCc3Z/NUXwgiBTXuFADquTdYyMDmnaekXF+EjyAhULPWy8TI0tzpU+FmWoL?=
 =?us-ascii?Q?KKxf5QzTtIJ2fmZ71/6TwXnDLW7tYzp3onUhTO6Il33P+HRNs/ojSyE9IHB8?=
 =?us-ascii?Q?cBPRR/5V6dBuSPEIakutuvaXVJ7Cw77uAhJNq2AO8FNC2e6w7r84YI+ZImJx?=
 =?us-ascii?Q?fN9CQVIR6OOVe2S9CfBLkkLAF5ur+/7FsXPpTH82aUDrI+hPP6gy0HNGlUH1?=
 =?us-ascii?Q?iyOll4y0CSrI7oJfcuniy83C80OGjHFSf4WSvxO3CcmC1Jg/gxL6fp6HqrYO?=
 =?us-ascii?Q?2mgE8epU6wX9hDy7TbVGv/5lZZA/Vi/DEYG3bPpO1H63s0+Os5SVFbf1bbL0?=
 =?us-ascii?Q?JTiILIkavjj+fTZSGsfUXwlaIuZLSHgSEbOcV3jyvKRh5tE5NCRH3sDskFOj?=
 =?us-ascii?Q?lssd?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2020 04:15:31.5841 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d8d8f6c-5b8a-4272-edf7-08d8a24264e4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6ZOvaDeQ3LTFc81YQGWhbgtusmksJO1+UCUYAxKDcd6WC457BuxDfThQhEzT/E6z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2359
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is supported by Sienna Cichlid, Navy Flounder and Dimgrey
Cavefish. For these ASICs, the target voltage calculation can be
illustrated by "voltage = voltage calculated from v/f curve +
overdrive vddgfx offset".

V2: limit the smu_version check for Sienna Cichlid only

Here are some sample usages about this new OD setting:
1. Check current vddgfx offset setting by
cat /sys/class/drm/card0/device/pp_od_clk_voltage
...
...
OD_VDDGFX_OFFSET:
0mV
...
...

2. Set new vddgfx offset by
echo "vo 10" > /sys/class/drm/card0/device/pp_od_clk_voltage
cat /sys/class/drm/card0/device/pp_od_clk_voltage
...
...
OD_VDDGFX_OFFSET:
10mV
...
...
3. Commit the new setting by
echo "c" > /sys/class/drm/card0/device/pp_od_clk_voltage

Change-Id: Ie13c06d9bbcdbeaad4379a7f697510c8d233f4af
Signed-off-by: Evan Quan <evan.quan@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/include/kgd_pp_interface.h    |  3 +-
 drivers/gpu/drm/amd/pm/amdgpu_pm.c            | 17 ++++++-
 drivers/gpu/drm/amd/pm/inc/smu_types.h        |  1 +
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 51 +++++++++++++++++++
 4 files changed, 70 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
index f775aac6c1bd..270f8db5115a 100644
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
@@ -157,7 +157,8 @@ enum PP_OD_DPM_TABLE_COMMAND {
 	PP_OD_EDIT_MCLK_VDDC_TABLE,
 	PP_OD_EDIT_VDDC_CURVE,
 	PP_OD_RESTORE_DEFAULT_TABLE,
-	PP_OD_COMMIT_DPM_TABLE
+	PP_OD_COMMIT_DPM_TABLE,
+	PP_OD_EDIT_VDDGFX_OFFSET
 };
 
 struct pp_states_info {
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 73aa78a158a6..a68c8ba68c55 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -736,6 +736,12 @@ static ssize_t amdgpu_set_pp_table(struct device *dev,
  * - three <frequency, voltage> points labeled OD_VDDC_CURVE.
  *   They can be used to calibrate the sclk voltage curve.
  *
+ * - voltage offset(in mV) applied on target voltage calculation.
+ *   This is available for Sienna Cichlid, Navy Flounder and Dimgrey
+ *   Cavefish. For these ASICs, the target voltage calculation can be
+ *   illustrated by "voltage = voltage calculated from v/f curve +
+ *   overdrive vddgfx offset"
+ *
  * - a list of valid ranges for sclk, mclk, and voltage curve points
  *   labeled OD_RANGE
  *
@@ -756,6 +762,11 @@ static ssize_t amdgpu_set_pp_table(struct device *dev,
  *   600mV. "vc 2 1000 1000" will update point3 with clock set
  *   as 1000Mhz and voltage 1000mV.
  *
+ *   To update the voltage offset applied for gfxclk/voltage calculation,
+ *   enter the new value by writing a string that contains "vo offset".
+ *   This is supported by Sienna Cichlid, Navy Flounder and Dimgrey Cavefish.
+ *   And the offset can be a positive or negative value.
+ *
  * - When you have edited all of the states as needed, write "c" (commit)
  *   to the file to commit your changes
  *
@@ -796,6 +807,8 @@ static ssize_t amdgpu_set_pp_od_clk_voltage(struct device *dev,
 		type = PP_OD_COMMIT_DPM_TABLE;
 	else if (!strncmp(buf, "vc", 2))
 		type = PP_OD_EDIT_VDDC_CURVE;
+	else if (!strncmp(buf, "vo", 2))
+		type = PP_OD_EDIT_VDDGFX_OFFSET;
 	else
 		return -EINVAL;
 
@@ -803,7 +816,8 @@ static ssize_t amdgpu_set_pp_od_clk_voltage(struct device *dev,
 
 	tmp_str = buf_cpy;
 
-	if (type == PP_OD_EDIT_VDDC_CURVE)
+	if ((type == PP_OD_EDIT_VDDC_CURVE) ||
+	     (type == PP_OD_EDIT_VDDGFX_OFFSET))
 		tmp_str++;
 	while (isspace(*++tmp_str));
 
@@ -899,6 +913,7 @@ static ssize_t amdgpu_get_pp_od_clk_voltage(struct device *dev,
 		size = smu_print_clk_levels(&adev->smu, SMU_OD_SCLK, buf);
 		size += smu_print_clk_levels(&adev->smu, SMU_OD_MCLK, buf+size);
 		size += smu_print_clk_levels(&adev->smu, SMU_OD_VDDC_CURVE, buf+size);
+		size += smu_print_clk_levels(&adev->smu, SMU_OD_VDDGFX_OFFSET, buf+size);
 		size += smu_print_clk_levels(&adev->smu, SMU_OD_RANGE, buf+size);
 	} else if (adev->powerplay.pp_funcs->print_clock_levels) {
 		size = amdgpu_dpm_print_clock_levels(adev, OD_SCLK, buf);
diff --git a/drivers/gpu/drm/amd/pm/inc/smu_types.h b/drivers/gpu/drm/amd/pm/inc/smu_types.h
index 720d15612fe1..4a3827c8bfb6 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu_types.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu_types.h
@@ -240,6 +240,7 @@ enum smu_clk_type {
 	SMU_OD_MCLK,
 	SMU_OD_VDDC_CURVE,
 	SMU_OD_RANGE,
+	SMU_OD_VDDGFX_OFFSET,
 	SMU_CLK_COUNT,
 };
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index d1de617e85c6..f6faa90e32c1 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -946,6 +946,7 @@ static int sienna_cichlid_print_clk_levels(struct smu_context *smu,
 	uint32_t mark_index = 0;
 	uint32_t gen_speed, lane_width;
 	uint32_t min_value, max_value;
+	uint32_t smu_version;
 
 	switch (clk_type) {
 	case SMU_GFXCLK:
@@ -1043,6 +1044,23 @@ static int sienna_cichlid_print_clk_levels(struct smu_context *smu,
 		size += sprintf(buf + size, "0: %uMhz\n1: %uMHz\n", od_table->UclkFmin, od_table->UclkFmax);
 		break;
 
+	case SMU_OD_VDDGFX_OFFSET:
+		if (!smu->od_enabled || !od_table || !od_settings)
+			break;
+
+		/*
+		 * OD GFX Voltage Offset functionality is supported only by 58.41.0
+		 * and onwards SMU firmwares.
+		 */
+		smu_cmn_get_smc_version(smu, NULL, &smu_version);
+		if ((adev->asic_type == CHIP_SIENNA_CICHLID) &&
+		     (smu_version < 0x003a2900))
+			break;
+
+		size += sprintf(buf + size, "OD_VDDGFX_OFFSET:\n");
+		size += sprintf(buf + size, "%dmV\n", od_table->VddGfxOffset);
+		break;
+
 	case SMU_OD_RANGE:
 		if (!smu->od_enabled || !od_table || !od_settings)
 			break;
@@ -1770,10 +1788,18 @@ static int sienna_cichlid_get_dpm_ultimate_freq(struct smu_context *smu,
 static void sienna_cichlid_dump_od_table(struct smu_context *smu,
 					 OverDriveTable_t *od_table)
 {
+	struct amdgpu_device *adev = smu->adev;
+	uint32_t smu_version;
+
 	dev_dbg(smu->adev->dev, "OD: Gfxclk: (%d, %d)\n", od_table->GfxclkFmin,
 							  od_table->GfxclkFmax);
 	dev_dbg(smu->adev->dev, "OD: Uclk: (%d, %d)\n", od_table->UclkFmin,
 							od_table->UclkFmax);
+
+	smu_cmn_get_smc_version(smu, NULL, &smu_version);
+	if (!((adev->asic_type == CHIP_SIENNA_CICHLID) &&
+	       (smu_version < 0x003a2900)))
+		dev_dbg(smu->adev->dev, "OD: VddGfxOffset: %d\n", od_table->VddGfxOffset);
 }
 
 static int sienna_cichlid_set_default_od_settings(struct smu_context *smu)
@@ -1826,9 +1852,11 @@ static int sienna_cichlid_od_edit_dpm_table(struct smu_context *smu,
 		(OverDriveTable_t *)table_context->overdrive_table;
 	struct smu_11_0_7_overdrive_table *od_settings =
 		(struct smu_11_0_7_overdrive_table *)smu->od_settings;
+	struct amdgpu_device *adev = smu->adev;
 	enum SMU_11_0_7_ODSETTING_ID freq_setting;
 	uint16_t *freq_ptr;
 	int i, ret = 0;
+	uint32_t smu_version;
 
 	if (!smu->od_enabled) {
 		dev_warn(smu->adev->dev, "OverDrive is not enabled!\n");
@@ -1964,6 +1992,29 @@ static int sienna_cichlid_od_edit_dpm_table(struct smu_context *smu,
 		}
 		break;
 
+	case PP_OD_EDIT_VDDGFX_OFFSET:
+		if (size != 1) {
+			dev_info(smu->adev->dev, "invalid number of parameters: %d\n", size);
+			return -EINVAL;
+		}
+
+		/*
+		 * OD GFX Voltage Offset functionality is supported only by 58.41.0
+		 * and onwards SMU firmwares.
+		 */
+		smu_cmn_get_smc_version(smu, NULL, &smu_version);
+		if ((adev->asic_type == CHIP_SIENNA_CICHLID) &&
+		     (smu_version < 0x003a2900)) {
+			dev_err(smu->adev->dev, "OD GFX Voltage offset functionality is supported "
+						"only by 58.41.0 and onwards SMU firmwares!\n");
+			return -EOPNOTSUPP;
+		}
+
+		od_table->VddGfxOffset = (int16_t)input[0];
+
+		sienna_cichlid_dump_od_table(smu, od_table);
+		break;
+
 	default:
 		return -ENOSYS;
 	}
-- 
2.29.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
