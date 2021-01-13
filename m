Return-Path: <SRS0=tf5m=GQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFF96C433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Jan 2021 11:49:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6ACE5233ED
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Jan 2021 11:49:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6ACE5233ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 868FE6E5C5;
	Wed, 13 Jan 2021 11:49:44 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2044.outbound.protection.outlook.com [40.107.93.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E8F06E5C5
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Jan 2021 11:49:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JOPHxS6h8ENvOD1DHDq7ltYC2J5hWXKzzwlPehUbvmxXyfpub2KLADcN/4dtwOJWzF+sZoNm0VCHE9f1vlkSB8Co02HzuIfz1MZy2CM5W+ibo0yq/VtVSy9SlUOlbzPF+SO4mtt7zhMqT6sniAwNQ9ygXcAY07wCobu0M7K2TCnRskQV88A6h+4LEqgm3aNgW+IK86ypjFDsUV7MzXCO30XMNEvrwtI3lSvG4QTfnFaasLPLeET3fLNy5pMgf+LvvktFFuOlWG4nJ7BuGSim+Y2EDMZIFRuzyyAcgi5AZAImZ6f2M+wrFvzUbG44RJHF73ccIYnjv6o00wMAPX0jjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SSRbI9SctHQj7SbxnmRNEbYGyHkhcNCLu58avsQqal0=;
 b=dSd6Zlt7GD3MJ7zR+54PKr4paLaIhEdebPjpuPLvn2EZmHW7BVbXHSCsNvs55HArUNlw4MTYYop1FTFY8w/E+cpMVOC8WKBYdMvbR6MSknhCLSdQvYAnmZ1u7XU6cfm7hm2Z40h1uf9PEwSTd6EkMWv9Ye9FfHyyajwA6kt7LfghrUtHnBNebIT7h9uI27O/0j8y0QweKCHt64hqCLlrWTwtrUbof3c6vzpo1MaGqglRgw2OxaVRRzlU7YCQDu0Fw9lIPyuXSkAMkE49hXJnCo8XJ0riLfcxC2hz/oHxz6i5WkdSf3PGKHiaabsak8I+u6BVX0HQjOXsZJEu1yqBdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SSRbI9SctHQj7SbxnmRNEbYGyHkhcNCLu58avsQqal0=;
 b=C0dZgh4Whtv6WqS+rvjcc89TQRK4Tkl8q765g2CZ1rFVVu7SDHIv9pnSKkNwwogzemsyFZGwsFoutBzg2Xm3JTvZesNDj47exX8l6h0YsZkh75N1gtWHoX+SGMn/hMKU5ElTJDmDm3eVUEjxsvnqpNmhwWUGJkXsubHOyiHYCAg=
Received: from MN2PR12MB3022.namprd12.prod.outlook.com (2603:10b6:208:ce::32)
 by MN2PR12MB3519.namprd12.prod.outlook.com (2603:10b6:208:107::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.10; Wed, 13 Jan
 2021 11:49:40 +0000
Received: from MN2PR12MB3022.namprd12.prod.outlook.com
 ([fe80::709e:b0ae:fbde:fcc6]) by MN2PR12MB3022.namprd12.prod.outlook.com
 ([fe80::709e:b0ae:fbde:fcc6%7]) with mapi id 15.20.3742.012; Wed, 13 Jan 2021
 11:49:40 +0000
From: "Wang, Kevin(Yang)" <Kevin1.Wang@amd.com>
To: "Du, Xiaojian" <Xiaojian.Du@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 2/2] drm/amd/pm: modify the fine grain tuning function for
 vangogh
Thread-Topic: [PATCH 2/2] drm/amd/pm: modify the fine grain tuning function
 for vangogh
Thread-Index: AQHW6Z5s9F0rl18k1kCDCWFDbYTVfaolcKEG
Date: Wed, 13 Jan 2021 11:49:40 +0000
Message-ID: <MN2PR12MB30220DC9BEF251ECDF56DDA9A2A90@MN2PR12MB3022.namprd12.prod.outlook.com>
References: <20210113112204.25469-1-Xiaojian.Du@amd.com>,
 <20210113112204.25469-2-Xiaojian.Du@amd.com>
In-Reply-To: <20210113112204.25469-2-Xiaojian.Du@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-01-13T11:49:39.995Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0179169d-03a5-4819-019e-08d8b7b94fad
x-ms-traffictypediagnostic: MN2PR12MB3519:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB3519E5C118E901F5018B602CA2A90@MN2PR12MB3519.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:576;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8xVQbkSZlycLk1wbvNIoAuEyuvRoQCsaWgg/eRqYyFNRJ/b95YjgEipmfEyBA8/hyv42ZIzm9TTtVyPhOnAWCEGyt3AEQeAGM+C6h41BfRbvtpldKaL6t8RDcHyL4K6wFm3IHmDxwCyGG/pXMzo35gIkGu/hhjfgU08SibyCpGsxg4YHpSHKGQqSn4/9IuWfB7XLAxBKdIeodVNfDC9X84Okd3rh7JD0xpBM2Dy3+wbOpHOZwBiIUiB1lLMrLiCpaf7IH2YqtsqPw2Zd7P5NuoJNW2U9TeQh0jA0fzjx5wqOtP/BBnbHLD4KZfPGVIKhrezSvPiKs04rU9xYVj4+mMgU5ja7+Psmiu3f8+YYGRc4ZfyuYbYCZ84gf4xxZXsDlbNOahkdAMoJMqsMlZbOkw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3022.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(396003)(376002)(136003)(346002)(6506007)(4326008)(83380400001)(53546011)(8676002)(86362001)(26005)(186003)(7696005)(316002)(2906002)(52536014)(54906003)(110136005)(5660300002)(33656002)(71200400001)(19627405001)(9686003)(91956017)(55016002)(66946007)(66446008)(64756008)(66556008)(8936002)(76116006)(66476007)(478600001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?EiG6zlDEM8W4z89OKlzeWk9ev4VVwBNFgD/1Aro6E/vOA1zBHplTJLOet6?=
 =?iso-8859-1?Q?P0zvX9iu1bXK6djvJnafk3uaRAYWA4UxR2aP518YhzrMDQJtF6yYLFE0rZ?=
 =?iso-8859-1?Q?Tl8foKS3/LV4KV6uUaF90CBM0K/5uWwf47qJOdRmYxDsxwfQOI4hQ0RYdJ?=
 =?iso-8859-1?Q?7NO2u0hS9KTjoMBMb+YXTFq/E+7WbAlwaxVaca9zznFvI2BBdiQ1gz3VkR?=
 =?iso-8859-1?Q?9SipcBcD54m4aJ4pUIpzXf/S6s6JzxtO+/xhKNr7hxYuPvFNd4VohmdDA3?=
 =?iso-8859-1?Q?FrXcc5Rq+JXb1rbzoziW1yxQPV7LdHXXN+OxFnQvak16IU8+jzbhQTzZBv?=
 =?iso-8859-1?Q?fYJcMroGSQ1to6Jw+3ldCk9ifnEHModNXdhqFKlMxqM5j/Va7nLd51LGGz?=
 =?iso-8859-1?Q?W1A5gf2AeO/foZbfbZK5Q71evVxS6YGIb99QOkUimmCAon4VFNSIv2gk+z?=
 =?iso-8859-1?Q?jILNaLVnqy3uFrh8OUnR6O5QTKsnI9r+oAce0etV+iGGaVcKNrUD03g6X+?=
 =?iso-8859-1?Q?sVsg9xfP9BGiEcA5xGF1ceBML45/N86WcZsA77fU0mCRe1+9N+MqCHYzGZ?=
 =?iso-8859-1?Q?olvpoQfZBR7I5iaHr/WaaSul9hb4DM2OA+S0Z241LEiKJ8qm0/cRqvmsmq?=
 =?iso-8859-1?Q?hBOhF9z+UiGM2CRgVVvpwMXIsmZE1vGmw5zE2rR/Vt6e/0vTk+vYhwIhOB?=
 =?iso-8859-1?Q?qTNoRcacEjiAxnD396YVu+Pbt2LivIUh7960X19vdO22G/2kUfGfg48l2m?=
 =?iso-8859-1?Q?pTP/QVirJfn8QpUXcXg6SWsERVeWdodY+3CT30Iz3Ct1DWqV/0Dz8khucd?=
 =?iso-8859-1?Q?wcAz/hgetPTBLPH0tousdT1cN9zpWlABDJ+rJ/1B9yCdQQLdDkC0+S8woK?=
 =?iso-8859-1?Q?tBOEUFKomtbP4orVZVHBNhPUd0NKkc9irK6LxW/oHDEhv4kJS+zOZVyh3v?=
 =?iso-8859-1?Q?4c4TCnI2kmT7Fm4VeO/2f71m69FPmzkQ8l5QewzIb/SRY8oH9Z6XanV3kA?=
 =?iso-8859-1?Q?3/92HB7/UjsIjZWBg=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3022.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0179169d-03a5-4819-019e-08d8b7b94fad
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2021 11:49:40.5426 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wQqSrTcqnfv6efMRMDFJonMTl2dWDNq1FjcXTHchdOhrkBIdGtHhpuC2AciTJGVQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3519
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
Cc: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Huang, Ray" <Ray.Huang@amd.com>, "Quan,
 Evan" <Evan.Quan@amd.com>
Content-Type: multipart/mixed; boundary="===============2002405770=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============2002405770==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB30220DC9BEF251ECDF56DDA9A2A90MN2PR12MB3022namp_"

--_000_MN2PR12MB30220DC9BEF251ECDF56DDA9A2A90MN2PR12MB3022namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]



________________________________
From: Du, Xiaojian <Xiaojian.Du@amd.com>
Sent: Wednesday, January 13, 2021 7:22 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Huang, Ray <Ray.Huang@amd.com>; Quan, Evan <Evan.Quan@amd.com>; Lazar, =
Lijo <Lijo.Lazar@amd.com>; Wang, Kevin(Yang) <Kevin1.Wang@amd.com>; Du, Xia=
ojian <Xiaojian.Du@amd.com>
Subject: [PATCH 2/2] drm/amd/pm: modify the fine grain tuning function for =
vangogh

This patch is to modify the fine grain tuning function for vangogh.
It is risky to add two new flags to common smu struct.
So this patch uses the existing old flag to make the two sysfs files
work separately -- "power_dpm_force_performance_level" and
"pp_od_clk_voltage".
Only the power_dpm_force_performance_level is switched to "manual"
mode, the fine grain tuning function will be started.
In other mode, including "high","low","min_sclk","min_mclk",
"standard" and "peak", the fine grain tuning function will be shut down,
and the frequency range of gfx and cpu clock will be restored the
default values.

Signed-off-by: Xiaojian Du <Xiaojian.Du@amd.com>
---
 drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h       |  3 --
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |  2 -
 .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  | 52 +++++++++++++++++--
 3 files changed, 48 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/=
pm/inc/amdgpu_smu.h
index 277559e80961..25ee9f51813b 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
@@ -466,9 +466,6 @@ struct smu_context
         uint32_t gfx_actual_hard_min_freq;
         uint32_t gfx_actual_soft_max_freq;

-       bool fine_grain_enabled;
-       bool fine_grain_started;
-

[Kevin]:
the above codes should be merge into previous patch.
with the fixed, the patch is

Reviewed-by: Kevin Wang <kevin1.wang@amd.com>

Best Regards,
Kevin

         uint32_t cpu_default_soft_min_freq;
         uint32_t cpu_default_soft_max_freq;
         uint32_t cpu_actual_soft_min_freq;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/am=
d/pm/swsmu/amdgpu_smu.c
index 976a9105aecc..7fe61ad3ed10 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -419,8 +419,6 @@ static int smu_set_funcs(struct amdgpu_device *adev)
                 break;
         case CHIP_VANGOGH:
                 vangogh_set_ppt_funcs(smu);
-               /* enable the OD by default to allow the fine grain tuning =
function */
-               smu->od_enabled =3D true;
                 break;
         default:
                 return -EINVAL;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu=
/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
index b49044825680..3e32b223d47b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -438,6 +438,7 @@ static int vangogh_print_fine_grain_clk(struct smu_cont=
ext *smu,
 {
         DpmClocks_t *clk_table =3D smu->smu_table.clocks_table;
         SmuMetrics_t metrics;
+       struct smu_dpm_context *smu_dpm_ctx =3D &(smu->smu_dpm);
         int i, size =3D 0, ret =3D 0;
         uint32_t cur_value =3D 0, value =3D 0, count =3D 0;
         bool cur_value_match_level =3D false;
@@ -450,7 +451,7 @@ static int vangogh_print_fine_grain_clk(struct smu_cont=
ext *smu,

         switch (clk_type) {
         case SMU_OD_SCLK:
-               if (smu->od_enabled) {
+               if (smu_dpm_ctx->dpm_level =3D=3D AMD_DPM_FORCED_LEVEL_MANU=
AL) {
                         size =3D sprintf(buf, "%s:\n", "OD_SCLK");
                         size +=3D sprintf(buf + size, "0: %10uMhz\n",
                         (smu->gfx_actual_hard_min_freq > 0) ? smu->gfx_act=
ual_hard_min_freq : smu->gfx_default_hard_min_freq);
@@ -459,7 +460,7 @@ static int vangogh_print_fine_grain_clk(struct smu_cont=
ext *smu,
                 }
                 break;
         case SMU_OD_CCLK:
-               if (smu->od_enabled) {
+               if (smu_dpm_ctx->dpm_level =3D=3D AMD_DPM_FORCED_LEVEL_MANU=
AL) {
                         size =3D sprintf(buf, "CCLK_RANGE in Core%d:\n",  =
smu->cpu_core_id_select);
                         size +=3D sprintf(buf + size, "0: %10uMhz\n",
                         (smu->cpu_actual_soft_min_freq > 0) ? smu->cpu_act=
ual_soft_min_freq : smu->cpu_default_soft_min_freq);
@@ -468,7 +469,7 @@ static int vangogh_print_fine_grain_clk(struct smu_cont=
ext *smu,
                 }
                 break;
         case SMU_OD_RANGE:
-               if (smu->od_enabled) {
+               if (smu_dpm_ctx->dpm_level =3D=3D AMD_DPM_FORCED_LEVEL_MANU=
AL) {
                         size =3D sprintf(buf, "%s:\n", "OD_RANGE");
                         size +=3D sprintf(buf + size, "SCLK: %7uMhz %10uMh=
z\n",
                                 smu->gfx_default_hard_min_freq, smu->gfx_d=
efault_soft_max_freq);
@@ -1127,15 +1128,39 @@ static int vangogh_set_performance_level(struct smu=
_context *smu,

         switch (level) {
         case AMD_DPM_FORCED_LEVEL_HIGH:
+               smu->gfx_actual_hard_min_freq =3D smu->gfx_default_hard_min=
_freq;
+               smu->gfx_actual_soft_max_freq =3D smu->gfx_default_soft_max=
_freq;
+
+               smu->cpu_actual_soft_min_freq =3D smu->cpu_default_soft_min=
_freq;
+               smu->cpu_actual_soft_max_freq =3D smu->cpu_default_soft_max=
_freq;
+
                 ret =3D vangogh_force_dpm_limit_value(smu, true);
                 break;
         case AMD_DPM_FORCED_LEVEL_LOW:
+               smu->gfx_actual_hard_min_freq =3D smu->gfx_default_hard_min=
_freq;
+               smu->gfx_actual_soft_max_freq =3D smu->gfx_default_soft_max=
_freq;
+
+               smu->cpu_actual_soft_min_freq =3D smu->cpu_default_soft_min=
_freq;
+               smu->cpu_actual_soft_max_freq =3D smu->cpu_default_soft_max=
_freq;
+
                 ret =3D vangogh_force_dpm_limit_value(smu, false);
                 break;
         case AMD_DPM_FORCED_LEVEL_AUTO:
+               smu->gfx_actual_hard_min_freq =3D smu->gfx_default_hard_min=
_freq;
+               smu->gfx_actual_soft_max_freq =3D smu->gfx_default_soft_max=
_freq;
+
+               smu->cpu_actual_soft_min_freq =3D smu->cpu_default_soft_min=
_freq;
+               smu->cpu_actual_soft_max_freq =3D smu->cpu_default_soft_max=
_freq;
+
                 ret =3D vangogh_unforce_dpm_levels(smu);
                 break;
         case AMD_DPM_FORCED_LEVEL_PROFILE_STANDARD:
+               smu->gfx_actual_hard_min_freq =3D smu->gfx_default_hard_min=
_freq;
+               smu->gfx_actual_soft_max_freq =3D smu->gfx_default_soft_max=
_freq;
+
+               smu->cpu_actual_soft_min_freq =3D smu->cpu_default_soft_min=
_freq;
+               smu->cpu_actual_soft_max_freq =3D smu->cpu_default_soft_max=
_freq;
+
                 ret =3D smu_cmn_send_smc_msg_with_param(smu,
                                         SMU_MSG_SetHardMinGfxClk,
                                         VANGOGH_UMD_PSTATE_STANDARD_GFXCLK=
, NULL);
@@ -1165,6 +1190,12 @@ static int vangogh_set_performance_level(struct smu_=
context *smu,

                 break;
         case AMD_DPM_FORCED_LEVEL_PROFILE_MIN_SCLK:
+               smu->gfx_actual_hard_min_freq =3D smu->gfx_default_hard_min=
_freq;
+               smu->gfx_actual_soft_max_freq =3D smu->gfx_default_soft_max=
_freq;
+
+               smu->cpu_actual_soft_min_freq =3D smu->cpu_default_soft_min=
_freq;
+               smu->cpu_actual_soft_max_freq =3D smu->cpu_default_soft_max=
_freq;
+
                 ret =3D smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetHa=
rdMinVcn,
                                                                 VANGOGH_UM=
D_PSTATE_PEAK_DCLK, NULL);
                 if (ret)
@@ -1176,6 +1207,12 @@ static int vangogh_set_performance_level(struct smu_=
context *smu,
                         return ret;
                 break;
         case AMD_DPM_FORCED_LEVEL_PROFILE_MIN_MCLK:
+               smu->gfx_actual_hard_min_freq =3D smu->gfx_default_hard_min=
_freq;
+               smu->gfx_actual_soft_max_freq =3D smu->gfx_default_soft_max=
_freq;
+
+               smu->cpu_actual_soft_min_freq =3D smu->cpu_default_soft_min=
_freq;
+               smu->cpu_actual_soft_max_freq =3D smu->cpu_default_soft_max=
_freq;
+
                 ret =3D vangogh_get_profiling_clk_mask(smu, level,
                                                         NULL,
                                                         NULL,
@@ -1189,6 +1226,12 @@ static int vangogh_set_performance_level(struct smu_=
context *smu,
                 vangogh_force_clk_levels(smu, SMU_FCLK, 1 << fclk_mask);
                 break;
         case AMD_DPM_FORCED_LEVEL_PROFILE_PEAK:
+               smu->gfx_actual_hard_min_freq =3D smu->gfx_default_hard_min=
_freq;
+               smu->gfx_actual_soft_max_freq =3D smu->gfx_default_soft_max=
_freq;
+
+               smu->cpu_actual_soft_min_freq =3D smu->cpu_default_soft_min=
_freq;
+               smu->cpu_actual_soft_max_freq =3D smu->cpu_default_soft_max=
_freq;
+
                 ret =3D smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetHa=
rdMinGfxClk,
                                 VANGOGH_UMD_PSTATE_PEAK_GFXCLK, NULL);
                 if (ret)
@@ -1401,8 +1444,9 @@ static int vangogh_od_edit_dpm_table(struct smu_conte=
xt *smu, enum PP_OD_DPM_TAB
 {
         int ret =3D 0;
         int i;
+       struct smu_dpm_context *smu_dpm_ctx =3D &(smu->smu_dpm);

-       if (!smu->od_enabled) {
+       if (!(smu_dpm_ctx->dpm_level =3D=3D AMD_DPM_FORCED_LEVEL_MANUAL)) {
                 dev_warn(smu->adev->dev, "Fine grain is not enabled!\n");
                 return -EINVAL;
         }
--
2.17.1


--_000_MN2PR12MB30220DC9BEF251ECDF56DDA9A2A90MN2PR12MB3022namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:11pt;color:#0078D7;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"appendonsend"></div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Du, Xiaojian &lt;Xiao=
jian.Du@amd.com&gt;<br>
<b>Sent:</b> Wednesday, January 13, 2021 7:22 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Huang, Ray &lt;Ray.Huang@amd.com&gt;; Quan, Evan &lt;Evan.Quan@a=
md.com&gt;; Lazar, Lijo &lt;Lijo.Lazar@amd.com&gt;; Wang, Kevin(Yang) &lt;K=
evin1.Wang@amd.com&gt;; Du, Xiaojian &lt;Xiaojian.Du@amd.com&gt;<br>
<b>Subject:</b> [PATCH 2/2] drm/amd/pm: modify the fine grain tuning functi=
on for vangogh</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText">This patch is to modify the fine grain tuning func=
tion for vangogh.<br>
It is risky to add two new flags to common smu struct.<br>
So this patch uses the existing old flag to make the two sysfs files<br>
work separately -- &quot;power_dpm_force_performance_level&quot; and<br>
&quot;pp_od_clk_voltage&quot;.<br>
Only the power_dpm_force_performance_level is switched to &quot;manual&quot=
;<br>
mode, the fine grain tuning function will be started.<br>
In other mode, including &quot;high&quot;,&quot;low&quot;,&quot;min_sclk&qu=
ot;,&quot;min_mclk&quot;,<br>
&quot;standard&quot; and &quot;peak&quot;, the fine grain tuning function w=
ill be shut down,<br>
and the frequency range of gfx and cpu clock will be restored the<br>
default values.<br>
<br>
Signed-off-by: Xiaojian Du &lt;Xiaojian.Du@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; |&nbsp; 3 --<br>
&nbsp;drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c&nbsp;&nbsp;&nbsp;&nbsp; |&n=
bsp; 2 -<br>
&nbsp;.../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c&nbsp; | 52 +++++++++++++=
++++--<br>
&nbsp;3 files changed, 48 insertions(+), 9 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/=
pm/inc/amdgpu_smu.h<br>
index 277559e80961..25ee9f51813b 100644<br>
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h<br>
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h<br>
@@ -466,9 +466,6 @@ struct smu_context<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t gfx_actual_hard_m=
in_freq;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t gfx_actual_soft_m=
ax_freq;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool fine_grain_enabled;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool fine_grain_started;<br>
-</div>
<div class=3D"PlainText"><br>
</div>
<div class=3D"PlainText">[Kevin]:</div>
<div class=3D"PlainText">the above codes should be merge into previous patc=
h.</div>
<div class=3D"PlainText">with the fixed, the patch is</div>
<div class=3D"PlainText"><br>
</div>
<div class=3D"PlainText">Reviewed-by: Kevin Wang &lt;kevin1.wang@amd.com&gt=
;</div>
<div class=3D"PlainText"><br>
</div>
<div class=3D"PlainText">Best Regards,<br>
Kevin</div>
<div class=3D"PlainText"><br>
</div>
<div class=3D"PlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u=
int32_t cpu_default_soft_min_freq;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t cpu_default_soft_=
max_freq;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t cpu_actual_soft_m=
in_freq;<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/am=
d/pm/swsmu/amdgpu_smu.c<br>
index 976a9105aecc..7fe61ad3ed10 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c<br>
@@ -419,8 +419,6 @@ static int smu_set_funcs(struct amdgpu_device *adev)<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_VANGOGH:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; vangogh_set_ppt_funcs(smu);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; /* enable the OD by default to allow the fine grain tuning funct=
ion */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; smu-&gt;od_enabled =3D true;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu=
/drm/amd/pm/swsmu/smu11/vangogh_ppt.c<br>
index b49044825680..3e32b223d47b 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c<br>
@@ -438,6 +438,7 @@ static int vangogh_print_fine_grain_clk(struct smu_cont=
ext *smu,<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DpmClocks_t *clk_table =3D=
 smu-&gt;smu_table.clocks_table;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SmuMetrics_t metrics;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_dpm_context *smu_dpm_ctx =
=3D &amp;(smu-&gt;smu_dpm);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i, size =3D 0, ret =3D=
 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t cur_value =3D 0, =
value =3D 0, count =3D 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool cur_value_match_level=
 =3D false;<br>
@@ -450,7 +451,7 @@ static int vangogh_print_fine_grain_clk(struct smu_cont=
ext *smu,<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (clk_type) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case SMU_OD_SCLK:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (smu-&gt;od_enabled) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (smu_dpm_ctx-&gt;dpm_level =3D=3D AMD_DPM_FORCED_LEVEL_MANUAL=
) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size =
=3D sprintf(buf, &quot;%s:\n&quot;, &quot;OD_SCLK&quot;);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size =
+=3D sprintf(buf + size, &quot;0: %10uMhz\n&quot;,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (smu-=
&gt;gfx_actual_hard_min_freq &gt; 0) ? smu-&gt;gfx_actual_hard_min_freq : s=
mu-&gt;gfx_default_hard_min_freq);<br>
@@ -459,7 +460,7 @@ static int vangogh_print_fine_grain_clk(struct smu_cont=
ext *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case SMU_OD_CCLK:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (smu-&gt;od_enabled) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (smu_dpm_ctx-&gt;dpm_level =3D=3D AMD_DPM_FORCED_LEVEL_MANUAL=
) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size =
=3D sprintf(buf, &quot;CCLK_RANGE in Core%d:\n&quot;,&nbsp; smu-&gt;cpu_cor=
e_id_select);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size =
+=3D sprintf(buf + size, &quot;0: %10uMhz\n&quot;,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (smu-=
&gt;cpu_actual_soft_min_freq &gt; 0) ? smu-&gt;cpu_actual_soft_min_freq : s=
mu-&gt;cpu_default_soft_min_freq);<br>
@@ -468,7 +469,7 @@ static int vangogh_print_fine_grain_clk(struct smu_cont=
ext *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case SMU_OD_RANGE:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (smu-&gt;od_enabled) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (smu_dpm_ctx-&gt;dpm_level =3D=3D AMD_DPM_FORCED_LEVEL_MANUAL=
) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size =
=3D sprintf(buf, &quot;%s:\n&quot;, &quot;OD_RANGE&quot;);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size =
+=3D sprintf(buf + size, &quot;SCLK: %7uMhz %10uMhz\n&quot;,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;gfx_default_hard_min_fre=
q, smu-&gt;gfx_default_soft_max_freq);<br>
@@ -1127,15 +1128,39 @@ static int vangogh_set_performance_level(struct smu=
_context *smu,<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (level) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMD_DPM_FORCED_LEVEL_=
HIGH:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; smu-&gt;gfx_actual_hard_min_freq =3D smu-&gt;gfx_default_hard_mi=
n_freq;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; smu-&gt;gfx_actual_soft_max_freq =3D smu-&gt;gfx_default_soft_ma=
x_freq;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; smu-&gt;cpu_actual_soft_min_freq =3D smu-&gt;cpu_default_soft_mi=
n_freq;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; smu-&gt;cpu_actual_soft_max_freq =3D smu-&gt;cpu_default_soft_ma=
x_freq;<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ret =3D vangogh_force_dpm_limit_value(smu, true);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMD_DPM_FORCED_LEVEL_=
LOW:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; smu-&gt;gfx_actual_hard_min_freq =3D smu-&gt;gfx_default_hard_mi=
n_freq;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; smu-&gt;gfx_actual_soft_max_freq =3D smu-&gt;gfx_default_soft_ma=
x_freq;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; smu-&gt;cpu_actual_soft_min_freq =3D smu-&gt;cpu_default_soft_mi=
n_freq;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; smu-&gt;cpu_actual_soft_max_freq =3D smu-&gt;cpu_default_soft_ma=
x_freq;<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ret =3D vangogh_force_dpm_limit_value(smu, false);<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMD_DPM_FORCED_LEVEL_=
AUTO:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; smu-&gt;gfx_actual_hard_min_freq =3D smu-&gt;gfx_default_hard_mi=
n_freq;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; smu-&gt;gfx_actual_soft_max_freq =3D smu-&gt;gfx_default_soft_ma=
x_freq;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; smu-&gt;cpu_actual_soft_min_freq =3D smu-&gt;cpu_default_soft_mi=
n_freq;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; smu-&gt;cpu_actual_soft_max_freq =3D smu-&gt;cpu_default_soft_ma=
x_freq;<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ret =3D vangogh_unforce_dpm_levels(smu);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMD_DPM_FORCED_LEVEL_=
PROFILE_STANDARD:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; smu-&gt;gfx_actual_hard_min_freq =3D smu-&gt;gfx_default_hard_mi=
n_freq;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; smu-&gt;gfx_actual_soft_max_freq =3D smu-&gt;gfx_default_soft_ma=
x_freq;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; smu-&gt;cpu_actual_soft_min_freq =3D smu-&gt;cpu_default_soft_mi=
n_freq;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; smu-&gt;cpu_actual_soft_max_freq =3D smu-&gt;cpu_default_soft_ma=
x_freq;<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ret =3D smu_cmn_send_smc_msg_with_param(smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; SMU_MSG_SetHardMinGfxClk,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; VANGOGH_UMD_PSTATE_STANDARD_GFXCLK, NULL);<br>
@@ -1165,6 +1190,12 @@ static int vangogh_set_performance_level(struct smu_=
context *smu,<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMD_DPM_FORCED_LEVEL_=
PROFILE_MIN_SCLK:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; smu-&gt;gfx_actual_hard_min_freq =3D smu-&gt;gfx_default_hard_mi=
n_freq;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; smu-&gt;gfx_actual_soft_max_freq =3D smu-&gt;gfx_default_soft_ma=
x_freq;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; smu-&gt;cpu_actual_soft_min_freq =3D smu-&gt;cpu_default_soft_mi=
n_freq;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; smu-&gt;cpu_actual_soft_max_freq =3D smu-&gt;cpu_default_soft_ma=
x_freq;<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ret =3D smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_=
SetHardMinVcn,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; VANGOGH_UMD_PSTATE_PEAK_DCLK, NULL);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (ret)<br>
@@ -1176,6 +1207,12 @@ static int vangogh_set_performance_level(struct smu_=
context *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n ret;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMD_DPM_FORCED_LEVEL_=
PROFILE_MIN_MCLK:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; smu-&gt;gfx_actual_hard_min_freq =3D smu-&gt;gfx_default_hard_mi=
n_freq;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; smu-&gt;gfx_actual_soft_max_freq =3D smu-&gt;gfx_default_soft_ma=
x_freq;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; smu-&gt;cpu_actual_soft_min_freq =3D smu-&gt;cpu_default_soft_mi=
n_freq;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; smu-&gt;cpu_actual_soft_max_freq =3D smu-&gt;cpu_default_soft_ma=
x_freq;<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ret =3D vangogh_get_profiling_clk_mask(smu, level,<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; NULL,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; NULL,<br>
@@ -1189,6 +1226,12 @@ static int vangogh_set_performance_level(struct smu_=
context *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; vangogh_force_clk_levels(smu, SMU_FCLK, 1 &lt;&lt; fc=
lk_mask);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMD_DPM_FORCED_LEVEL_=
PROFILE_PEAK:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; smu-&gt;gfx_actual_hard_min_freq =3D smu-&gt;gfx_default_hard_mi=
n_freq;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; smu-&gt;gfx_actual_soft_max_freq =3D smu-&gt;gfx_default_soft_ma=
x_freq;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; smu-&gt;cpu_actual_soft_min_freq =3D smu-&gt;cpu_default_soft_mi=
n_freq;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; smu-&gt;cpu_actual_soft_max_freq =3D smu-&gt;cpu_default_soft_ma=
x_freq;<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ret =3D smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_=
SetHardMinGfxClk,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; VANGOGH_UMD_PSTATE_PEAK_GFXCLK, =
NULL);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (ret)<br>
@@ -1401,8 +1444,9 @@ static int vangogh_od_edit_dpm_table(struct smu_conte=
xt *smu, enum PP_OD_DPM_TAB<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_dpm_context *smu_dpm_ctx =
=3D &amp;(smu-&gt;smu_dpm);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!smu-&gt;od_enabled) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!(smu_dpm_ctx-&gt;dpm_level =3D=
=3D AMD_DPM_FORCED_LEVEL_MANUAL)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; dev_warn(smu-&gt;adev-&gt;dev, &quot;Fine grain is no=
t enabled!\n&quot;);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-- <br>
2.17.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB30220DC9BEF251ECDF56DDA9A2A90MN2PR12MB3022namp_--

--===============2002405770==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============2002405770==--
