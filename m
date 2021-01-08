Return-Path: <SRS0=yWhT=GL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14F4EC433E0
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jan 2021 10:01:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B9992368A
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jan 2021 10:01:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B9992368A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A59D6E7DA;
	Fri,  8 Jan 2021 10:01:12 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2066.outbound.protection.outlook.com [40.107.92.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 786076E7EA
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Jan 2021 10:01:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XWqB8rmBdXbbs8XPKuWcd1kmYVB89AVvdugO0SSYwvxk+7C6uvjf53ANiwADD4/fzCxLLDhsIUmNcJsPerVslvXy5t9TXfOgYFK6iXnXsToOnrPjfA0Hlvs8xlQrytUW0kOlMnBZdJH6hjjrPMNnfcFhi589h3dsm3brPDzj5LlpPTZospCWtY1zVlm6PH4O/kzp9HEYOzQj0yJ0RspWXy1Sqjzf+xgqM9bbPSl2CQVqmRDBnUOiwcpN5VOlwN74n2tApG5SlPLwyonG17XZd0ka6YwIq1gOc9iHPIunTipXpb19jDyqt3Jv611dQNGftblynchdNPvDCVuPv9YNdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rzui7tQ8EZjrZmM/kvricfLZcF1z3YhoKX7istnQCV8=;
 b=nWaAjYksfPdTuw42Ake48/yG8HqJFgiZ5hq1nrAndmbWq59mBpuVr5w9S6341ueKZT+OZbIInwPsuJwx3GFFW7gsK+aJk58/RGrFjh4JPamTtqVUbJPyCE0yjiog5NL5mdKjekWeddWa88bDFFHB+MHmvjBkc6GNllJ4ag8I9FDvEEn9s/mm9Ql623bThxzMgWMnK2rBoFv9ixScnjA01n34zNBQbCUfpQxn6QKDzK3NshNjV/Y2btUW820SAV2qo6h4BAHj8kI7B1zZ7TqDY0p76CshwjfR5rVEVPa88mh3d5uhs7bNSkmJe8D1nfnRo/Xv5fHTz5u8B4kHbRF3hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rzui7tQ8EZjrZmM/kvricfLZcF1z3YhoKX7istnQCV8=;
 b=SCBOuOyHi6YddpNXX3MtWkX/l75YcUQcja3QEiZvJ0o1vnUgKtEG5FxJdG+QRG6wzrmX7lhbzSs3o2LKoQ+NEWA6HVVcR30ulZ5DM+3dbtpb2dtt6hn7dAm/liY7BC1TdjdQK6zVs0/0qUOGhIFL5JqoH082Xq9ieaQssr3P+Ho=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB4957.namprd12.prod.outlook.com (2603:10b6:5:20d::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3742.6; Fri, 8 Jan 2021 10:01:08 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bc84:defe:efbb:9ab1]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bc84:defe:efbb:9ab1%3]) with mapi id 15.20.3721.024; Fri, 8 Jan 2021
 10:01:08 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Huang, Ray" <Ray.Huang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 7/7] drm/amd/pm: implement processor fine grain feature
 for vangogh
Thread-Topic: [PATCH 7/7] drm/amd/pm: implement processor fine grain feature
 for vangogh
Thread-Index: AQHW5ZwXWSOMlAAackK9SJhxSEVLu6odfU/w
Date: Fri, 8 Jan 2021 10:01:08 +0000
Message-ID: <DM6PR12MB2619B9C5907EC6CA8A506A5AE4AE0@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20210108085507.1164588-1-ray.huang@amd.com>
 <20210108085507.1164588-8-ray.huang@amd.com>
In-Reply-To: <20210108085507.1164588-8-ray.huang@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=f7545c80-3efa-4be1-8b3c-a80194182a53;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-01-08T09:54:32Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 548df2ca-d7c1-4414-4f2c-08d8b3bc523a
x-ms-traffictypediagnostic: DM6PR12MB4957:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB495788295F399F2A9EB68474E4AE0@DM6PR12MB4957.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0hau2KvpiIrGeAopB0OwNGRF/Q8bdbHAZ31nEOEYuInBTvbDhwIpFOFDmuC3l0D2th+pKAlDNmivtbPJDIPW8HFdNz4hewX5fSP64v7FmC/ttyjkS4tpYIVmtrAFdn6ENiCXkzk2XR+uUwpzD5vKqkNUhzGptZzcTXyvdvP/T2dFxY/IBk/iZpAKHWenNJgnM9+ZMOX2WELTDMkUFrl6Jal5skelmtm619hpHoQN9n3AT13+RepWGV3Bnl7AKGIJ7wb2Va0eCFDu3Zjv5g865RNhwyu4n50gDkSQaWzfVv+PsIEa4iUaNUMp0/zx7UF4j1DxFzK8sHz1/gIoCdA0VHBbDcW+5kdptsKAkIM+3MpmweSCQpoD9sO/D1LE8+sFeq/dE92UxGeFGaLPQY0L7UpwmT5TZPgERG7gGyd6GxQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(396003)(39860400002)(366004)(136003)(66446008)(64756008)(66556008)(86362001)(66476007)(5660300002)(966005)(66946007)(45080400002)(110136005)(26005)(6506007)(186003)(53546011)(33656002)(54906003)(52536014)(316002)(2906002)(4326008)(76116006)(9686003)(83380400001)(7696005)(71200400001)(8676002)(55016002)(478600001)(8936002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?N1CPjNUlHhFgmivYBiOQh7zDXjH5HtUh4tuPDtjEOKLg1VPgRNIX3JKvgirL?=
 =?us-ascii?Q?/rTalYRwpf9xeQwuqmtkGydc+mmJ9MCSjakbWOk+t+qESpqw7ejEGbe8Fs5p?=
 =?us-ascii?Q?9yVy8IVQOxVA43EHDhCGwOtd+3WsTU/K+4G4ZveA3Euk6tpEDKz0V10n14AD?=
 =?us-ascii?Q?vkzDCTr+7VFfFJA+tVOeRH7nfBFTpqnaBNObuF4Zl9M3Ukkr/CJs41/uXUp+?=
 =?us-ascii?Q?JkOUrnoUeCh/F0TxOxVXEtciKYQxj3hBsI5w2uksTBd5NFWZGtjj77G9ickV?=
 =?us-ascii?Q?5v/0VzWrg8oKeTbEjt5b85OVuJbFlPYxBZMnqPPF/CqqNOiV3O88wdJtXQk5?=
 =?us-ascii?Q?g0jfhv86ocCSXeCO81THbuSf/MlMTI1ngZ02csX1nwNlhtqOWFO1nHwtMEg5?=
 =?us-ascii?Q?o1yam5JADX245su3bC97F01pPMMHhRyoLYudI8XNuuC2FOkE3j6fe7k+wWrc?=
 =?us-ascii?Q?F8IaTi96OGyA9gFlwSNT1Cg++2jH9Dzkl9y9A8aaoyWO1ySr42ddvgvGd53y?=
 =?us-ascii?Q?OVCK5nxcK6L3YQeiwuCxw3qMC7I6Z+zFMSUyNMzK+JYVgD+1TSIKIbGcoPdN?=
 =?us-ascii?Q?MRs+RwWV0KASfmnUjyKWQ3QkiwI2gwBDspqw1TnH32XSVQAy6iAXiw9z2HYi?=
 =?us-ascii?Q?624Xafv6/jyOgJnzmBPCyAiq/C4Sd2VkEyH8NHfX2P8frY8KjqTyVPz7rFUC?=
 =?us-ascii?Q?nIzWIPRm2EDcMhv1FpsqgHjlEa4G1UZaCd28Unw9T4SMPj4x5RHBxdn93B3e?=
 =?us-ascii?Q?kk7v/oUYBrbd7ljzIJf/DO3v5Bs5qAV7DJSCIMvyIuBygLGjTMUl1ITuYsPW?=
 =?us-ascii?Q?JSCTCVrp10sjRNoKznTubaSYea1c4n0MFtW1fD9YSvZteIJqE1vfiMM5ekXb?=
 =?us-ascii?Q?25Agmcoq8uYbofuAhddFAAvXNt0QwUn+0iXgfrlBC712Kv+0PeBskFKd5kCS?=
 =?us-ascii?Q?pfym0B5C7rDNg8DQEZp6y+7Iya/iUrnlR386FVnDe5Q=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 548df2ca-d7c1-4414-4f2c-08d8b3bc523a
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2021 10:01:08.6342 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +30h1v49n8+r1jkN650BMNfwc7yCk2puRuSvBQROWYQtRa4ZmSe8DmFOPOpqAR5g
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4957
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Hou, Xiaomeng
 \(Matthew\)" <Xiaomeng.Hou@amd.com>, "Huang, Ray" <Ray.Huang@amd.com>, "Liu,
 Aaron" <Aaron.Liu@amd.com>, "Du, Xiaojian" <Xiaojian.Du@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Huang Rui
Sent: Friday, January 8, 2021 4:55 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Hou, Xiaomeng (Matthew) <Xiaomeng.Hou@amd.com>; Huang, Ray <Ray.Huang@amd.com>; Liu, Aaron <Aaron.Liu@amd.com>; Du, Xiaojian <Xiaojian.Du@amd.com>
Subject: [PATCH 7/7] drm/amd/pm: implement processor fine grain feature for vangogh

This patch is to implement the processor fine grain feature for vangogh.
It's similar with gfx clock, the only difference is below:

echo "p core_id level value" > pp_od_clk_voltage

1. "p" - set the cclk (processor) frequency
2. "core_id" - 0/1/2/3, represents which cpu core you want to select
2. "level" - 0 or 1, "0" represents the min value,  "1" represents the
   max value
3. "value" - the target value of cclk frequency, it should be limited in
   the safe range

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 .../gpu/drm/amd/include/kgd_pp_interface.h    |  1 +
 drivers/gpu/drm/amd/pm/amdgpu_pm.c            |  3 +
 drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h       |  6 ++
 drivers/gpu/drm/amd/pm/inc/smu_types.h        |  1 +
 .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  | 78 ++++++++++++++++++-
 5 files changed, 88 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
index 57b24c4c205b..a41875ac5dfb 100644
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
@@ -156,6 +156,7 @@ enum {
 enum PP_OD_DPM_TABLE_COMMAND {
 PP_OD_EDIT_SCLK_VDDC_TABLE,
 PP_OD_EDIT_MCLK_VDDC_TABLE,
+PP_OD_EDIT_CCLK_VDDC_TABLE,
 PP_OD_EDIT_VDDC_CURVE,
 PP_OD_RESTORE_DEFAULT_TABLE,
 PP_OD_COMMIT_DPM_TABLE,
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index a5be03aa384b..298784f73705 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -800,6 +800,8 @@ static ssize_t amdgpu_set_pp_od_clk_voltage(struct device *dev,

 if (*buf == 's')
 type = PP_OD_EDIT_SCLK_VDDC_TABLE;
+if (*buf == 'p')
[Quan, Evan] better to use "else if" here.
+type = PP_OD_EDIT_CCLK_VDDC_TABLE;
 else if (*buf == 'm')
 type = PP_OD_EDIT_MCLK_VDDC_TABLE;
 else if(*buf == 'r')
@@ -916,6 +918,7 @@ static ssize_t amdgpu_get_pp_od_clk_voltage(struct device *dev,
 size += smu_print_clk_levels(&adev->smu, SMU_OD_VDDC_CURVE, buf+size);
 size += smu_print_clk_levels(&adev->smu, SMU_OD_VDDGFX_OFFSET, buf+size);
 size += smu_print_clk_levels(&adev->smu, SMU_OD_RANGE, buf+size);
+size += smu_print_clk_levels(&adev->smu, SMU_OD_CCLK, buf+size);
 } else if (adev->powerplay.pp_funcs->print_clock_levels) {
 size = amdgpu_dpm_print_clock_levels(adev, OD_SCLK, buf);
 size += amdgpu_dpm_print_clock_levels(adev, OD_MCLK, buf+size);
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
index 97d788451624..5f781a27cfb7 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
@@ -465,6 +465,12 @@ struct smu_context
 uint32_t gfx_default_soft_max_freq;
 uint32_t gfx_actual_hard_min_freq;
 uint32_t gfx_actual_soft_max_freq;
+
+uint32_t cpu_default_hard_min_freq;
+uint32_t cpu_default_soft_max_freq;
+uint32_t cpu_actual_hard_min_freq;
+uint32_t cpu_actual_soft_max_freq;
+uint32_t cpu_core_id_select;
 };

 struct i2c_adapter;
diff --git a/drivers/gpu/drm/amd/pm/inc/smu_types.h b/drivers/gpu/drm/amd/pm/inc/smu_types.h
index 8e428c728e0e..b76270e8767c 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu_types.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu_types.h
@@ -237,6 +237,7 @@ enum smu_clk_type {
 SMU_SCLK,
 SMU_MCLK,
 SMU_PCIE,
+SMU_OD_CCLK,
 SMU_OD_SCLK,
 SMU_OD_MCLK,
 SMU_OD_VDDC_CURVE,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
index 63be82386964..4d02177cf9b0 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -449,6 +449,15 @@ static int vangogh_print_fine_grain_clk(struct smu_context *smu,
 (smu->gfx_actual_soft_max_freq > 0) ? smu->gfx_actual_soft_max_freq : smu->gfx_default_soft_max_freq);
 }
 break;
+case SMU_OD_CCLK:
+if (smu->od_enabled) {
+size = sprintf(buf, "CCLK_RANGE in Core%d:\n",  smu->cpu_core_id_select);
+size += sprintf(buf + size, "0: %10uMhz\n",
+(smu->cpu_actual_hard_min_freq > 0) ? smu->cpu_actual_hard_min_freq : smu->cpu_default_hard_min_freq);
+size += sprintf(buf + size, "1: %10uMhz\n",
+(smu->cpu_actual_soft_max_freq > 0) ? smu->cpu_actual_soft_max_freq : smu->cpu_default_soft_max_freq);
+}
+break;
 case SMU_OD_RANGE:
[Quan, Evan] The allowed frequency range for cclk should prompt user here in SMU_OD_RANGE.
 if (smu->od_enabled) {
 size = sprintf(buf, "%s:\n", "OD_RANGE");
@@ -1245,7 +1254,7 @@ static ssize_t vangogh_get_gpu_metrics(struct smu_context *smu,
 }

 static int vangogh_od_edit_dpm_table(struct smu_context *smu, enum PP_OD_DPM_TABLE_COMMAND type,
-long input[], uint32_t size)
+long input[], uint32_t size)
 {
 int ret = 0;

@@ -1255,6 +1264,34 @@ static int vangogh_od_edit_dpm_table(struct smu_context *smu, enum PP_OD_DPM_TAB
 }

 switch (type) {
+case PP_OD_EDIT_CCLK_VDDC_TABLE:
+if (size != 3) {
+dev_err(smu->adev->dev, "Input parameter number not correct (should be 4 for processor)\n");
+return -EINVAL;
+}
+if (input[0] >= boot_cpu_data.x86_max_cores) {
+dev_err(smu->adev->dev, "core index is overflow, should be less than %d\n",
+boot_cpu_data.x86_max_cores);
+}
+smu->cpu_core_id_select = input[0];
+if (input[1] == 0) {
+if (input[2] < smu->cpu_default_hard_min_freq) {
+dev_warn(smu->adev->dev, "Fine grain setting minimum cclk (%ld) MHz is less than the minimum allowed (%d) MHz\n",
+input[2], smu->cpu_default_hard_min_freq);
+return -EINVAL;
+}
+smu->cpu_actual_hard_min_freq = input[2];
+} else if (input[1] == 1) {
+if (input[2] > smu->cpu_default_soft_max_freq) {
+dev_warn(smu->adev->dev, "Fine grain setting maximum cclk (%ld) MHz is greater than the maximum allowed (%d) MHz\n",
+input[2], smu->cpu_default_soft_max_freq);
+return -EINVAL;
+}
+smu->cpu_actual_soft_max_freq = input[2];
+} else {
+return -EINVAL;
+}
+break;
 case PP_OD_EDIT_SCLK_VDDC_TABLE:
 if (size != 2) {
 dev_err(smu->adev->dev, "Input parameter number not correct\n");
@@ -1286,6 +1323,8 @@ static int vangogh_od_edit_dpm_table(struct smu_context *smu, enum PP_OD_DPM_TAB
 } else {
 smu->gfx_actual_hard_min_freq = smu->gfx_default_hard_min_freq;
 smu->gfx_actual_soft_max_freq = smu->gfx_default_soft_max_freq;
+smu->cpu_actual_hard_min_freq = smu->cpu_default_hard_min_freq;
+smu->cpu_actual_soft_max_freq = smu->cpu_default_soft_max_freq;

 ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetHardMinGfxClk,
 smu->gfx_actual_hard_min_freq, NULL);
@@ -1300,6 +1339,20 @@ static int vangogh_od_edit_dpm_table(struct smu_context *smu, enum PP_OD_DPM_TAB
 dev_err(smu->adev->dev, "Restore the default soft max sclk failed!");
 return ret;
 }
+
+ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetSoftMinCclk,
+      smu->cpu_actual_hard_min_freq, NULL);
[Quan, Evan] better to name it as "soft_min_freq" instead of "hard_min_freq".
+if (ret) {
+dev_err(smu->adev->dev, "Set hard min cclk failed!");
+return ret;
+}
+
+ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetSoftMaxCclk,
+      smu->cpu_actual_soft_max_freq, NULL);
+if (ret) {
+dev_err(smu->adev->dev, "Set soft max cclk failed!");
+return ret;
+}
 }
 break;
 case PP_OD_COMMIT_DPM_TABLE:
@@ -1326,6 +1379,24 @@ static int vangogh_od_edit_dpm_table(struct smu_context *smu, enum PP_OD_DPM_TAB
 dev_err(smu->adev->dev, "Set soft max sclk failed!");
 return ret;
 }
+
+ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetSoftMinCclk,
+      ((smu->cpu_core_id_select << 20)
+       | smu->cpu_actual_hard_min_freq),
+      NULL);
+if (ret) {
+dev_err(smu->adev->dev, "Set hard min cclk failed!");
+return ret;
+}
+
+ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetSoftMaxCclk,
+      ((smu->cpu_core_id_select << 20)
+       | smu->cpu_actual_soft_max_freq),
+      NULL);
+if (ret) {
+dev_err(smu->adev->dev, "Set soft max cclk failed!");
+return ret;
+}
 }
 break;
 default:
@@ -1351,6 +1422,11 @@ static int vangogh_set_fine_grain_gfx_freq_parameters(struct smu_context *smu)
 smu->gfx_actual_hard_min_freq = 0;
 smu->gfx_actual_soft_max_freq = 0;

+smu->cpu_default_hard_min_freq = 1400;
+smu->cpu_default_soft_max_freq = 3500;
+smu->cpu_actual_hard_min_freq = 0;
+smu->cpu_actual_soft_max_freq = 0;
+
 return 0;
 }

--
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Cevan.quan%40amd.com%7Ca1f6eb71deeb42ff36b708d8b3b338dc%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637456929634329975%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=nrUPCKEMCJqKBeGMjWfr7%2FCbuVaovJqC6AovtuRMtFk%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
