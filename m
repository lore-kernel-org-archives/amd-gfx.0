Return-Path: <SRS0=WIfX=EV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDF16C2D0E4
	for <amd-gfx@archiver.kernel.org>; Sun, 15 Nov 2020 14:45:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DFBC22314
	for <amd-gfx@archiver.kernel.org>; Sun, 15 Nov 2020 14:45:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="xHOaac1x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DFBC22314
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D5FAD89FF7;
	Sun, 15 Nov 2020 14:45:04 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2085.outbound.protection.outlook.com [40.107.220.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD31289FF7
 for <amd-gfx@lists.freedesktop.org>; Sun, 15 Nov 2020 14:45:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B5Eh8S++PTLWeed7bvgeXJzpsd5YARvtsPHKw5Wn0YXcfqbJr0sTdwxD39Rq3Z9D6myxHeNafsxl1k/ig+FjFQ00TYQIWXbDUxJDmGoSHP/Ohw8jcO518t7oI/0YVXsL5CYOC81WzaH483CJJUD610iSH1K5lWhm//g57ambBffEIRF1xRJ0924/cO2Dx77PNdRHqzxnNURXidGBescuV9AbsxtMmNojKiOsnvn/b+Ayp82ov3+y9zT/xl1JWFY0rRmh0jBh1SHcqmcbWAmqJF0CFOI8e/8jskdGfqED8hNdDpKLrh+ZL2rn5rVRr0Rx6oyjtUaupPVrgtlFbHS9aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A3X2/0bK/8jPbCX3g52iGKeo5vIK1pea95nwD3ENCdM=;
 b=hFitJmj37SseKrn8oUkfcF4E1d/xh4iE0IZULHJQifthMXoCF5Ank7/OIY4JjerFBcqr0fzUq2R++bXE4iaf4Xv7xxitBmW/hGtIWF8nWAVUfAy4xwEYeIBHGbGiYtHBquYwW67otvqcj3BzWE5opxifyrTea9KiBbkj5kKGFmhS+t8C1bNw3rdtfXvZivh5qNCUYhuuWMpPCTUdSYjh+uui4wj39QFTnFST4zwOcLZ+6RgPIckvoftSKyFR9QaO8ENv7S5zzFw+C3PAfHNctdT8WmO5DiZ5ip4h7fYCWwQcm7Yrnrx0aCkbi26HgE/s9y2ERFv/gbWI5/qpoVV8pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A3X2/0bK/8jPbCX3g52iGKeo5vIK1pea95nwD3ENCdM=;
 b=xHOaac1xwLSzQdo37Dz8m/S+hv/d3Qaf01EhAwVBIld8e59b3nwHHydzdJT+m5fEh7l4JM5oERJjIPJX0eqzS2kTz0PAxeKgO3VYZaeMxoD5pKhGoW+1HnsG5Y2SfxriNfHCTJe547VMzLnKIxQkG3P3CpR6C8XWlcoYmb9G8/o=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1639.namprd12.prod.outlook.com (2603:10b6:910:f::21)
 by CY4PR1201MB0056.namprd12.prod.outlook.com (2603:10b6:910:1c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.25; Sun, 15 Nov
 2020 14:45:01 +0000
Received: from CY4PR12MB1639.namprd12.prod.outlook.com
 ([fe80::ecae:a003:1c8c:c99f]) by CY4PR12MB1639.namprd12.prod.outlook.com
 ([fe80::ecae:a003:1c8c:c99f%5]) with mapi id 15.20.3541.025; Sun, 15 Nov 2020
 14:45:01 +0000
From: Xiaojian Du <Xiaojian.Du@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amd/pm: add the fine grain tuning function for vangogh
Date: Sun, 15 Nov 2020 22:44:34 +0800
Message-Id: <20201115144435.15993-1-Xiaojian.Du@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [58.247.170.242]
X-ClientProxiedBy: HK2PR02CA0193.apcprd02.prod.outlook.com
 (2603:1096:201:21::29) To CY4PR12MB1639.namprd12.prod.outlook.com
 (2603:10b6:910:f::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jenkins-System-Product-Name.amd.com (58.247.170.242) by
 HK2PR02CA0193.apcprd02.prod.outlook.com (2603:1096:201:21::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3564.25 via Frontend Transport; Sun, 15 Nov 2020 14:44:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e9f1c1f6-afe0-48b7-db0c-08d88975081b
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0056:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR1201MB00563EEC99F3A74DB918FA9DF1E40@CY4PR1201MB0056.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:153;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QXV0DZES0JOD+9rC04hWh/YlUUJZzU+pa2YLaJdPLWw7m5tqLhRB08yT2kIDAodi9F7HK0eGv14+Uc4WfAmW9cVGa+WEmlMnWqHyqQ8qtjCTiSFNx/tPF/eLg5wjvcOXkgB3+q7iEfrc5uK5aBT09qhKBE6rG08O1jaTZZXLNN4kCjoT0s3zucYrFgRpFiE2wrd6uBB/Fs7TcBvMhzsNiAJUP1mo6gDoz8K6QriRXI5aiQwE10RdEOgz5oTV98KbXcYRARwYsTxmWU8h3K6AOlSdbBru2g9za6bxVLYmhH3uRW7xkrR9eWBDr5o51MW/oKb731Eg029fYf82mQhHBg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1639.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(366004)(396003)(136003)(39860400002)(66556008)(36756003)(2616005)(6486002)(66946007)(6916009)(66476007)(26005)(5660300002)(6666004)(4326008)(8936002)(1076003)(2906002)(83380400001)(86362001)(186003)(16526019)(8676002)(478600001)(956004)(316002)(7696005)(52116002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: +o3KiWZgvV32z+ccwJ9dDPk5hCB2FEMA+7s2HkJqZvkcwNY2xX/kvofLoebAUgkM5KEFINPjj150+EoCgZau7THAxVDzlVqsTs6oFviWovC49CLOR3TiT3lvh/bD26eiVQ5DNq7Kd3PUkPR2cAAfTZZn4XaxsBUBt20faZzlpjy1wBmx1Ymi11HDdr36t5DNlWuwnLe3fsNS7b3ayS42kerqseqv+h+nxow4wfMcikw27RK/8uTOvZlLeVQoYZvhw2e629i0gKFSoaGf+0grIB+67QpULBhdOTULnuwGXyvFCsDikmohJrBEX0GAONvajA7XA+peTbJM7HWH9ZXjss7fXfArJm8pSWgKrgTrWjkMRVbsOwVhO0ozfQVrgsd0Oen62nyN79Y0JmI8wCUleNxvItQQk/3sVw63K6Zr2kbykDfliAHcz25IjLlfzO8Mbr4DCm4IJ7MCDuUAMlB+w3hIVy9oJuf3YE/CUUCtqw8NihGhfnDLhJu9BSQAMhI0F1VfgurRBZ0kW2emEWxrubObMWmT7+eMuy41d0//5TEA0C/pDIdsCv5Z3BTs1vyY1XYVhsyeiX6XOT36RJnW45f8TA99pr+8hCb45PD3V4BLt18SAPXyNHnXFAp/oaYMl9yYa1r2GE3ERINn1Pybyw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9f1c1f6-afe0-48b7-db0c-08d88975081b
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1639.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2020 14:45:01.7245 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dNY6Hfjclv3IrfK+mZkQQTqPhdbRSketrkhGHCdSpr3pD7EuwDD72YgQaVVien/hLQQqn9GC7O3OeIkw6SsYtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0056
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
Cc: Xiaojian Du <Xiaojian.Du@amd.com>, kevin1.wang@amd.com, prike.liang@amd.com,
 xinmei.huang@amd.com, ray.huang@amd.com, changfeng.zhu@amd.com,
 Alexander.Deucher@amd.com, evan.quan@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch is to add the fine grain tuning function for vangogh.
This function uses the pp_od_clk_voltage sysfs file to configure the min
and max value of gfx clock frequency or restore the default value.

Command guide:
echo "s level value" > pp_od_clk_voltage
        "s" - set the sclk frequency
        "level" - 0 or 1, "0" represents the min value,  "1" represents
        the max value
        "value" - the target value of sclk frequency, it should be
        limited in the
        safe range.
echo "r" > pp_od_clk_voltage
	"r" - reset the sclk frequency, restore the default value
echo "c" > pp_od_clk_voltage
        "c" - commit the min and max value of sclk frequency to the system.
        only after the commit command, the target values will take
        effect.
Example:
1)check the default sclk frequency
	$ cat pp_od_clk_voltage
	OD_SCLK:
	0:        200Mhz
	1:       1400Mhz
	OD_RANGE:
	SCLK:     200MHz       1400MHz
2)use "s" -- set command to configure the min or max sclk frequency
	$ echo "s 0 600" > pp_od_clk_voltage
	$ echo "s 1 1000" > pp_od_clk_voltage
	$ echo "c" > pp_od_clk_voltage
        $ cat pp_od_clk_voltage
	OD_SCLK:
	0:        600Mhz
	1:       1000Mhz
	OD_RANGE:
	SCLK:     200MHz       1400MHz
3)use "r" -- reset command to restore the min and max sclk frequency
	$ echo "r" > pp_od_clk_voltage
	& echo "c" > pp_od_clk_voltage
        $ cat pp_od_clk_voltage
	OD_SCLK:
	0:        200Mhz
	1:       1400Mhz
	OD_RANGE:
	SCLK:     200MHz       1400MHz

Signed-off-by: Xiaojian Du <Xiaojian.Du@amd.com>
---
 drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h       |   6 +
 .../gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c    |   2 +
 .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  | 135 ++++++++++++++++++
 drivers/gpu/drm/amd/pm/swsmu/smu_internal.h   |   1 +
 4 files changed, 144 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
index ae8ff7b07932..7550757cc059 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
@@ -459,6 +459,11 @@ struct smu_context
 
 	unsigned fan_max_rpm;
 	unsigned manual_fan_speed_rpm;
+
+	uint32_t gfx_default_hard_min_freq;
+	uint32_t gfx_default_soft_max_freq;
+	uint32_t gfx_actual_hard_min_freq;
+	uint32_t gfx_actual_soft_max_freq;
 };
 
 struct i2c_adapter;
@@ -577,6 +582,7 @@ struct pptable_funcs {
 	void (*interrupt_work)(struct smu_context *smu);
 	int (*gpo_control)(struct smu_context *smu, bool enablement);
 	int (*gfx_state_change_set)(struct smu_context *smu, uint32_t state);
+	int (*set_fine_grain_gfx_freq_parameters)(struct smu_context *smu);
 };
 
 typedef enum {
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
index b880c72c322c..b23311096467 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -438,11 +438,13 @@ int smu_v11_0_fini_smc_tables(struct smu_context *smu)
 	kfree(smu_table->overdrive_table);
 	kfree(smu_table->max_sustainable_clocks);
 	kfree(smu_table->driver_pptable);
+	kfree(smu_table->clocks_table);
 	smu_table->gpu_metrics_table = NULL;
 	smu_table->boot_overdrive_table = NULL;
 	smu_table->overdrive_table = NULL;
 	smu_table->max_sustainable_clocks = NULL;
 	smu_table->driver_pptable = NULL;
+	smu_table->clocks_table = NULL;
 	kfree(smu_table->hardcode_pptable);
 	smu_table->hardcode_pptable = NULL;
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
index cbcbcd8514f0..299ad695f607 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -200,8 +200,14 @@ static int vangogh_tables_init(struct smu_context *smu)
 	if (!smu_table->watermarks_table)
 		goto err2_out;
 
+	smu_table->clocks_table = kzalloc(sizeof(DpmClocks_t), GFP_KERNEL);
+	if (!smu_table->clocks_table)
+		goto err3_out;
+
 	return 0;
 
+err3_out:
+	kfree(smu_table->clocks_table);
 err2_out:
 	kfree(smu_table->gpu_metrics_table);
 err1_out:
@@ -477,6 +483,35 @@ static int vangogh_get_current_clk_freq_by_table(struct smu_context *smu,
 					   value);
 }
 
+static int vangogh_print_fine_grain_clk(struct smu_context *smu,
+			enum smu_clk_type clk_type, char *buf)
+{
+	int size = 0;
+
+	switch (clk_type) {
+	case SMU_OD_SCLK:
+		if (smu->od_enabled) {
+			size = sprintf(buf, "%s:\n", "OD_SCLK");
+			size += sprintf(buf + size, "0: %10uMhz\n",
+			(smu->gfx_actual_hard_min_freq > 0) ? smu->gfx_actual_hard_min_freq : smu->gfx_default_hard_min_freq);
+			size += sprintf(buf + size, "1: %10uMhz\n",
+			(smu->gfx_actual_soft_max_freq > 0) ? smu->gfx_actual_soft_max_freq : smu->gfx_default_soft_max_freq);
+		}
+		break;
+	case SMU_OD_RANGE:
+		if (smu->od_enabled) {
+			size = sprintf(buf, "%s:\n", "OD_RANGE");
+			size += sprintf(buf + size, "SCLK: %7uMhz %10uMhz\n",
+				smu->gfx_default_hard_min_freq, smu->gfx_default_soft_max_freq);
+		}
+		break;
+	default:
+		break;
+	}
+
+	return size;
+}
+
 static int vangogh_read_sensor(struct smu_context *smu,
 				 enum amd_pp_sensors sensor,
 				 void *data, uint32_t *size)
@@ -635,6 +670,102 @@ static ssize_t vangogh_get_gpu_metrics(struct smu_context *smu,
 	return sizeof(struct gpu_metrics_v2_0);
 }
 
+static int vangogh_od_edit_dpm_table(struct smu_context *smu, enum PP_OD_DPM_TABLE_COMMAND type,
+							long input[], uint32_t size)
+{
+	int ret = 0;
+
+	if (!smu->od_enabled) {
+		dev_warn(smu->adev->dev, "Fine grain is not enabled!\n");
+		return -EINVAL;
+	}
+
+	switch (type) {
+	case PP_OD_EDIT_SCLK_VDDC_TABLE:
+		if (size != 2) {
+			dev_err(smu->adev->dev, "Input parameter number not correct\n");
+			return -EINVAL;
+		}
+
+		if (input[0] == 0) {
+			if (input[1] < smu->gfx_default_hard_min_freq) {
+				dev_warn(smu->adev->dev, "Fine grain setting minimun sclk (%ld) MHz is less than the minimum allowed (%d) MHz\n",
+					input[1], smu->gfx_default_hard_min_freq);
+				return -EINVAL;
+			}
+			smu->gfx_actual_hard_min_freq = input[1];
+		} else if (input[0] == 1) {
+			if (input[1] > smu->gfx_default_soft_max_freq) {
+				dev_warn(smu->adev->dev, "Fine grain setting maximun sclk (%ld) MHz is greater than the maximum allowed (%d) MHz\n",
+					input[1], smu->gfx_default_soft_max_freq);
+				return -EINVAL;
+			}
+			smu->gfx_actual_soft_max_freq = input[1];
+		} else {
+			return -EINVAL;
+		}
+		break;
+	case PP_OD_RESTORE_DEFAULT_TABLE:
+		if (size != 0) {
+			dev_err(smu->adev->dev, "Input parameter number not correct\n");
+			return -EINVAL;
+		} else {
+			smu->gfx_actual_hard_min_freq = smu->gfx_default_hard_min_freq;
+			smu->gfx_actual_soft_max_freq = smu->gfx_default_soft_max_freq;
+		}
+		break;
+	case PP_OD_COMMIT_DPM_TABLE:
+		if (size != 0) {
+			dev_err(smu->adev->dev, "Input parameter number not correct\n");
+			return -EINVAL;
+		} else {
+			if (smu->gfx_actual_hard_min_freq > smu->gfx_actual_soft_max_freq) {
+				dev_err(smu->adev->dev, "The setting minimun sclk (%d) MHz is greater than the setting maximum sclk (%d) MHz\n",
+				smu->gfx_actual_hard_min_freq, smu->gfx_actual_soft_max_freq);
+				return -EINVAL;
+			}
+
+			ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetHardMinGfxClk,
+									smu->gfx_actual_hard_min_freq, NULL);
+			if (ret) {
+				dev_err(smu->adev->dev, "Set hard min sclk failed!");
+				return ret;
+			}
+
+			ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetSoftMaxGfxClk,
+									smu->gfx_actual_soft_max_freq, NULL);
+			if (ret) {
+				dev_err(smu->adev->dev, "Set soft max sclk failed!");
+				return ret;
+			}
+		}
+		break;
+	default:
+		return -ENOSYS;
+	}
+
+	return ret;
+}
+
+int vangogh_set_default_dpm_tables(struct smu_context *smu)
+{
+	struct smu_table_context *smu_table = &smu->smu_table;
+
+	return smu_cmn_update_table(smu, SMU_TABLE_DPMCLOCKS, 0, smu_table->clocks_table, false);
+}
+
+static int vangogh_set_fine_grain_gfx_freq_parameters(struct smu_context *smu)
+{
+	DpmClocks_t *clk_table = smu->smu_table.clocks_table;
+
+	smu->gfx_default_hard_min_freq = clk_table->MinGfxClk;
+	smu->gfx_default_soft_max_freq = clk_table->MaxGfxClk;
+	smu->gfx_actual_hard_min_freq = 0;
+	smu->gfx_actual_soft_max_freq = 0;
+
+	return 0;
+}
+
 static const struct pptable_funcs vangogh_ppt_funcs = {
 
 	.check_fw_status = smu_v11_0_check_fw_status,
@@ -659,6 +790,10 @@ static const struct pptable_funcs vangogh_ppt_funcs = {
 	.disable_all_features_with_exception = smu_cmn_disable_all_features_with_exception,
 	.interrupt_work = smu_v11_0_interrupt_work,
 	.get_gpu_metrics = vangogh_get_gpu_metrics,
+	.od_edit_dpm_table = vangogh_od_edit_dpm_table,
+	.print_clk_levels = vangogh_print_fine_grain_clk,
+	.set_default_dpm_table = vangogh_set_default_dpm_tables,
+	.set_fine_grain_gfx_freq_parameters = vangogh_set_fine_grain_gfx_freq_parameters,
 };
 
 void vangogh_set_ppt_funcs(struct smu_context *smu)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h b/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h
index f7be2d1a0ff2..68d9464ababc 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h
@@ -90,6 +90,7 @@
 #define smu_get_fan_parameters(smu)					smu_ppt_funcs(get_fan_parameters, 0, smu)
 #define smu_post_init(smu)						smu_ppt_funcs(post_init, 0, smu)
 #define smu_gpo_control(smu, enablement)				smu_ppt_funcs(gpo_control, 0, smu, enablement)
+#define smu_set_fine_grain_gfx_freq_parameters(smu)					smu_ppt_funcs(set_fine_grain_gfx_freq_parameters, 0, smu)
 
 #endif
 #endif
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
