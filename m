Return-Path: <SRS0=8n1M=EW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D38EC2D0E4
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Nov 2020 01:35:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB63222265
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Nov 2020 01:35:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="vk/iSRuk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB63222265
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 267E889ECD;
	Mon, 16 Nov 2020 01:35:26 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2072.outbound.protection.outlook.com [40.107.237.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B52FD89EB4
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Nov 2020 01:35:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Duq6lJdy5M3BkfTOi5/qrpHNG1nDRkdnGkWMGN9cl0Z6SFAEgyMAxumx/UZ+dVBXQdxSw06sqkdLgsq5HA0cfxmBv+G2yqG1R3iDCs3PZAv6iMPMjUH3wEN0SsnDf0cnlXCrKSdGu9Uphjc8zPmhZeUQLxAqFFGwpvCCcQ8OJMSu5B5TWXMmItMtu3iC/yVIIZk3bYzKqlD2C9T7XCDs9R1sFaPlaPzlP7XjRNblbl9iPBZdGm4ycULCYugfkSvmKpbmrddH32/0GBfIWeiyyHNDx06IQT68yEkx/2ymZuDzkotI14ls8aH3Uu36JZ4xFiaas2NqfcfzVBv8aeqhTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/zsWppvIE0lmN+1wJ2mLsTdGmljF3JPpiN2kxbTMO5c=;
 b=T9qENtEjs5R37ReYNbjirfG1saVjTbY/cbktq7wwrpIpFI9zSpTom0+vKWBCCvYJMDcxNGKIC42sWxS5PqUniuMiVVOlfVvNIAnFfEnk1q4/EjdEPKTnrqq9EB+DzLiqXYOa8rwb6tT1FmQsEQRdWTqNoDfI2J+49t12GLcrbyWA4EKrObP5Efr6mnolwacLTWcxvHXoDHG1lH0V11bHomLNC6F7epAPfTfD7mGyL6qGN6z5EWw+JVrYNREP/Un+1ckm5YKu1rUtNk2ub/3WHjfyVfR/5sv+zIb228idPOp9mNViPTZgtGRZ/TZcrcMcPiCezkguByWLVH+zUMPncw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/zsWppvIE0lmN+1wJ2mLsTdGmljF3JPpiN2kxbTMO5c=;
 b=vk/iSRukrsjeQGBwqIF1VyRKErTk//F9CtMK3Ulr83x1z81r6M4tGoUJ1pniwqHSjf7MPmvlj52PvTR4LQhNm1YcFKv32Gjxt9UaVUhekFs+nw0+5wRKimUxjjyqNVAk0B/ZhLJBaT1kv7U+FuRQ2KDFxTxIoXIzOIvji55A0uc=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3275.namprd12.prod.outlook.com (2603:10b6:5:185::29) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3564.28; Mon, 16 Nov 2020 01:35:22 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5a6:dfb2:fdfd:2d91]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5a6:dfb2:fdfd:2d91%6]) with mapi id 15.20.3541.025; Mon, 16 Nov 2020
 01:35:21 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Du, Xiaojian" <Xiaojian.Du@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/2] drm/amd/pm: add the fine grain tuning function for
 vangogh
Thread-Topic: [PATCH 1/2] drm/amd/pm: add the fine grain tuning function for
 vangogh
Thread-Index: AQHWu13mKjnXVOSaekWRYoicILjHw6nJ+blw
Date: Mon, 16 Nov 2020 01:35:21 +0000
Message-ID: <DM6PR12MB2619AF271673EDC9282AB4A3E4E30@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20201115144435.15993-1-Xiaojian.Du@amd.com>
In-Reply-To: <20201115144435.15993-1-Xiaojian.Du@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=aea5d0f9-7492-4f5e-8d3b-eb8da63427df;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-11-16T01:31:39Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0060852e-fa88-428f-3acc-08d889cfe238
x-ms-traffictypediagnostic: DM6PR12MB3275:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB327500509DA8BBDCF4B7ED71E4E30@DM6PR12MB3275.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:132;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 39OJTuaIWyIjjFx9AFjDLUIhbYzVDJzcWk6+WajtLVpnTKmtxtpRGIz3eo7C4sJhOrytGwBklH12PdHseTY2+85y43bCiSsOw0l7Z20g4kuUrfvLYYVhsWkz6UN34b3SOmlbyWtNQIZHFyZIIdqUfCjuBhy9ZY3/BFUIB7rDO71Jmp0m/ULVEYHm0DH87OixbTu/klpLzdd3uOIEGyA1zbXSyzf+yhJc+acU+BXyLLRIqJ/SMzKHEh2b5UE3x2t4XtJJpmCT4Hfat+qdlcQbO/Wb3Wb/uLmEBQfmxwcmQ29cut/LUaqqjc+61Y6EpqZmCYeV1Us6fqV33IVOio52kw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(366004)(39860400002)(396003)(136003)(478600001)(76116006)(55016002)(4326008)(66946007)(66556008)(64756008)(66446008)(186003)(6506007)(66476007)(5660300002)(83380400001)(2906002)(8676002)(26005)(54906003)(53546011)(86362001)(110136005)(71200400001)(316002)(8936002)(7696005)(52536014)(9686003)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: T7X6Obs8DEBf2mnwMkvNRvvQHdqn4koxURNV3AIPGd9fzi1OUl0N/MqaikVUtFvs1y3qSi7ThYb75aqKfpSbsQMbUGrA4ORXhNXBeNhNFfLAnlnyCLB/VG0uahS57URB9+11iJhzXNqFutcGNdw+M9EGk4JGYlXkEmz2u02vkrhjw7N8lrUyGvzuIj99QrhZmjytfG84T6a0BdtKLDy3+1edDe0wdcBIorHhGEUARvzx7/9iMj8yQJ7Pqb+WEc+0LOqbW/isda4R0aYEiP8g05h0I32iPP4pYzwtFKWEz7fh6zjG8lPkqFUelIF0liGP//Mt8ngHRe0n/VfBzlFpp+1aJ4woQxzFIwjDqH8x70T9kGAcu8MVfxB1IJS79Jj0ft4HlSFziEwjbG1bJBcpnCENobsbfJ6WEyAlH73Njpc/duUl2QZmlI6wSYO0T9AZgZ4hYhH9SJluci64QMXHS7kdeKbdZt4sOnjAnB50cqdpyFhaHh0eVgVgzx2Nxfzh9n7jjs7fwthfRnhbcMGywOGUxcvSNutS+SOuxBKSIPmYB8DsvSwShknSz5iJQFkYHgyy+dLvD+i2P9mTYDiRu8Z80krpiFKG45XhsVid8Ne/QDQbShJ8Kujb7fPY7KIO0q0t3ABIYmk9fV2pUMdDTA==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0060852e-fa88-428f-3acc-08d889cfe238
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2020 01:35:21.7927 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J65BJ4ZqowBrTjAgG34p2OyWPkXHvrjfdda8dH1iD9ZK92vUrXdZYGZ3hgl11z5P
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3275
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
Cc: "Wang, Kevin\(Yang\)" <Kevin1.Wang@amd.com>, "Liang,
 Prike" <Prike.Liang@amd.com>, "Huang, Shimmer" <Xinmei.Huang@amd.com>, "Huang,
 Ray" <Ray.Huang@amd.com>, "Zhu, Changfeng" <Changfeng.Zhu@amd.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

To be consistent with other ASICs, "echo r" is enough to restore to the default values.
No need to followed by a "echo c".
With that fixed, the series is reviewed-by: Evan Quan <evan.quan@amd.com>

-----Original Message-----
From: Du, Xiaojian <Xiaojian.Du@amd.com>
Sent: Sunday, November 15, 2020 10:45 PM
To: amd-gfx@lists.freedesktop.org
Cc: Huang, Ray <Ray.Huang@amd.com>; Quan, Evan <Evan.Quan@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Wang, Kevin(Yang) <Kevin1.Wang@amd.com>; Huang, Shimmer <Xinmei.Huang@amd.com>; Liang, Prike <Prike.Liang@amd.com>; Zhu, Changfeng <Changfeng.Zhu@amd.com>; Du, Xiaojian <Xiaojian.Du@amd.com>
Subject: [PATCH 1/2] drm/amd/pm: add the fine grain tuning function for vangogh

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
+uint32_t gfx_default_hard_min_freq;
+uint32_t gfx_default_soft_max_freq;
+uint32_t gfx_actual_hard_min_freq;
+uint32_t gfx_actual_soft_max_freq;
 };

 struct i2c_adapter;
@@ -577,6 +582,7 @@ struct pptable_funcs {
 void (*interrupt_work)(struct smu_context *smu);
 int (*gpo_control)(struct smu_context *smu, bool enablement);
 int (*gfx_state_change_set)(struct smu_context *smu, uint32_t state);
+int (*set_fine_grain_gfx_freq_parameters)(struct smu_context *smu);
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
+kfree(smu_table->clocks_table);
 smu_table->gpu_metrics_table = NULL;
 smu_table->boot_overdrive_table = NULL;
 smu_table->overdrive_table = NULL;
 smu_table->max_sustainable_clocks = NULL;
 smu_table->driver_pptable = NULL;
+smu_table->clocks_table = NULL;
 kfree(smu_table->hardcode_pptable);
 smu_table->hardcode_pptable = NULL;

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
index cbcbcd8514f0..299ad695f607 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -200,8 +200,14 @@ static int vangogh_tables_init(struct smu_context *smu)
 if (!smu_table->watermarks_table)
 goto err2_out;

+smu_table->clocks_table = kzalloc(sizeof(DpmClocks_t), GFP_KERNEL);
+if (!smu_table->clocks_table)
+goto err3_out;
+
 return 0;

+err3_out:
+kfree(smu_table->clocks_table);
 err2_out:
 kfree(smu_table->gpu_metrics_table);
 err1_out:
@@ -477,6 +483,35 @@ static int vangogh_get_current_clk_freq_by_table(struct smu_context *smu,
    value);
 }

+static int vangogh_print_fine_grain_clk(struct smu_context *smu,
+enum smu_clk_type clk_type, char *buf)
+{
+int size = 0;
+
+switch (clk_type) {
+case SMU_OD_SCLK:
+if (smu->od_enabled) {
+size = sprintf(buf, "%s:\n", "OD_SCLK");
+size += sprintf(buf + size, "0: %10uMhz\n",
+(smu->gfx_actual_hard_min_freq > 0) ? smu->gfx_actual_hard_min_freq : smu->gfx_default_hard_min_freq);
+size += sprintf(buf + size, "1: %10uMhz\n",
+(smu->gfx_actual_soft_max_freq > 0) ? smu->gfx_actual_soft_max_freq : smu->gfx_default_soft_max_freq);
+}
+break;
+case SMU_OD_RANGE:
+if (smu->od_enabled) {
+size = sprintf(buf, "%s:\n", "OD_RANGE");
+size += sprintf(buf + size, "SCLK: %7uMhz %10uMhz\n",
+smu->gfx_default_hard_min_freq, smu->gfx_default_soft_max_freq);
+}
+break;
+default:
+break;
+}
+
+return size;
+}
+
 static int vangogh_read_sensor(struct smu_context *smu,
  enum amd_pp_sensors sensor,
  void *data, uint32_t *size)
@@ -635,6 +670,102 @@ static ssize_t vangogh_get_gpu_metrics(struct smu_context *smu,
 return sizeof(struct gpu_metrics_v2_0);
 }

+static int vangogh_od_edit_dpm_table(struct smu_context *smu, enum PP_OD_DPM_TABLE_COMMAND type,
+long input[], uint32_t size)
+{
+int ret = 0;
+
+if (!smu->od_enabled) {
+dev_warn(smu->adev->dev, "Fine grain is not enabled!\n");
+return -EINVAL;
+}
+
+switch (type) {
+case PP_OD_EDIT_SCLK_VDDC_TABLE:
+if (size != 2) {
+dev_err(smu->adev->dev, "Input parameter number not correct\n");
+return -EINVAL;
+}
+
+if (input[0] == 0) {
+if (input[1] < smu->gfx_default_hard_min_freq) {
+dev_warn(smu->adev->dev, "Fine grain setting minimun sclk (%ld) MHz is less than the minimum allowed (%d) MHz\n",
+input[1], smu->gfx_default_hard_min_freq);
+return -EINVAL;
+}
+smu->gfx_actual_hard_min_freq = input[1];
+} else if (input[0] == 1) {
+if (input[1] > smu->gfx_default_soft_max_freq) {
+dev_warn(smu->adev->dev, "Fine grain setting maximun sclk (%ld) MHz is greater than the maximum allowed (%d) MHz\n",
+input[1], smu->gfx_default_soft_max_freq);
+return -EINVAL;
+}
+smu->gfx_actual_soft_max_freq = input[1];
+} else {
+return -EINVAL;
+}
+break;
+case PP_OD_RESTORE_DEFAULT_TABLE:
+if (size != 0) {
+dev_err(smu->adev->dev, "Input parameter number not correct\n");
+return -EINVAL;
+} else {
+smu->gfx_actual_hard_min_freq = smu->gfx_default_hard_min_freq;
+smu->gfx_actual_soft_max_freq = smu->gfx_default_soft_max_freq;
+}
+break;
+case PP_OD_COMMIT_DPM_TABLE:
+if (size != 0) {
+dev_err(smu->adev->dev, "Input parameter number not correct\n");
+return -EINVAL;
+} else {
+if (smu->gfx_actual_hard_min_freq > smu->gfx_actual_soft_max_freq) {
+dev_err(smu->adev->dev, "The setting minimun sclk (%d) MHz is greater than the setting maximum sclk (%d) MHz\n",
+smu->gfx_actual_hard_min_freq, smu->gfx_actual_soft_max_freq);
+return -EINVAL;
+}
+
+ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetHardMinGfxClk,
+smu->gfx_actual_hard_min_freq, NULL);
+if (ret) {
+dev_err(smu->adev->dev, "Set hard min sclk failed!");
+return ret;
+}
+
+ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetSoftMaxGfxClk,
+smu->gfx_actual_soft_max_freq, NULL);
+if (ret) {
+dev_err(smu->adev->dev, "Set soft max sclk failed!");
+return ret;
+}
+}
+break;
+default:
+return -ENOSYS;
+}
+
+return ret;
+}
+
+int vangogh_set_default_dpm_tables(struct smu_context *smu)
+{
+struct smu_table_context *smu_table = &smu->smu_table;
+
+return smu_cmn_update_table(smu, SMU_TABLE_DPMCLOCKS, 0, smu_table->clocks_table, false);
+}
+
+static int vangogh_set_fine_grain_gfx_freq_parameters(struct smu_context *smu)
+{
+DpmClocks_t *clk_table = smu->smu_table.clocks_table;
+
+smu->gfx_default_hard_min_freq = clk_table->MinGfxClk;
+smu->gfx_default_soft_max_freq = clk_table->MaxGfxClk;
+smu->gfx_actual_hard_min_freq = 0;
+smu->gfx_actual_soft_max_freq = 0;
+
+return 0;
+}
+
 static const struct pptable_funcs vangogh_ppt_funcs = {

 .check_fw_status = smu_v11_0_check_fw_status,
@@ -659,6 +790,10 @@ static const struct pptable_funcs vangogh_ppt_funcs = {
 .disable_all_features_with_exception = smu_cmn_disable_all_features_with_exception,
 .interrupt_work = smu_v11_0_interrupt_work,
 .get_gpu_metrics = vangogh_get_gpu_metrics,
+.od_edit_dpm_table = vangogh_od_edit_dpm_table,
+.print_clk_levels = vangogh_print_fine_grain_clk,
+.set_default_dpm_table = vangogh_set_default_dpm_tables,
+.set_fine_grain_gfx_freq_parameters = vangogh_set_fine_grain_gfx_freq_parameters,
 };

 void vangogh_set_ppt_funcs(struct smu_context *smu)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h b/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h
index f7be2d1a0ff2..68d9464ababc 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h
@@ -90,6 +90,7 @@
 #define smu_get_fan_parameters(smu)smu_ppt_funcs(get_fan_parameters, 0, smu)
 #define smu_post_init(smu)smu_ppt_funcs(post_init, 0, smu)
 #define smu_gpo_control(smu, enablement)smu_ppt_funcs(gpo_control, 0, smu, enablement)
+#define smu_set_fine_grain_gfx_freq_parameters(smu)smu_ppt_funcs(set_fine_grain_gfx_freq_parameters, 0, smu)

 #endif
 #endif
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
