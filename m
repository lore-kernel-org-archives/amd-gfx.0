Return-Path: <SRS0=2jl+=GO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D67DFC433DB
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Jan 2021 04:31:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9439E22527
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Jan 2021 04:31:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9439E22527
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4205789BB3;
	Mon, 11 Jan 2021 04:31:02 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2059.outbound.protection.outlook.com [40.107.243.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3ED4289B96
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Jan 2021 04:31:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ih3bnJNlwV3kQCQQbjRwOFoew4ym6KtAkff3YkIwHax/MoHu7n8eWpA0cWvNsELcnF4dMtuYrY0tk4mA7NHbYE19pr7MuDUPUBUIXboAWtdjunTm+Fo1v5rP9pDNrXSBt53hQ0O+hiKaNx/2SpjVplZxX+OC0Ttl1TnIMiooXW2yOpgBWn1Lx/XzwgcI/KfFtL5up4y9gSAXBMYAHDMLrqerCiTK2hZvqpkh12TJ1G2qzM7Jhtg0OYpQXRvRqp8X5xjS/WT0RZBPrrQ/vFdu8W31I2Sep7WgBVz/N0LS2zDICPjTBK767csaKVx1RHyK8QqTprBd6dQkkMpahbc3ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y/jX+sMMvmaSE0Goiw0E1mCs/XfKvDKyDSVOQBHLHAM=;
 b=HBz25oPfFtdaIEfmSIaC2lVM81bbgESCVfXTWJhliIGgxja2iyn2UHFmQCxGvxLbgFPsKGPEwlDJDDQlDZPM6aa66xIoGizfMbtYr1G1Z8KKCRkvt6rE6jGDi/fqIK6BjI1XyQiulWpLNthb73WFBAd5j+YPvSNQRVgxBbA0pTnbIlzMbRDNm+23yeoNMyOvTzaAyF9GObjna2OR+NDsQ129o/KNhyP79btc4tlHkysfL/VOw1Sak4blHeyNQPqck3Fj52LClQzIVTvAEhkjuXl+iQjzk0DfnCnNbo6jMKZsgIP3EEltCWmRCaM7l1UsFz96LhBD/IZpdQDhIvhLGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y/jX+sMMvmaSE0Goiw0E1mCs/XfKvDKyDSVOQBHLHAM=;
 b=xPaEV56Bh34OuipSJobg0blp6bVCZU3a5cMZf3mDSWJiTDpOKHpSWaCumpg/jQd9n4bc/ExKFmK/YId++mjTzwgYjt+q+byYGHVEvMMnRWFbq4Ejddq8bUt581oMOPFFG6di7IDQcKiPDWJxLzcoD4LNu4E6lQANosD/aNBaLtY=
Received: from BYAPR12MB2615.namprd12.prod.outlook.com (2603:10b6:a03:61::29)
 by BYAPR12MB2888.namprd12.prod.outlook.com (2603:10b6:a03:137::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.9; Mon, 11 Jan
 2021 04:30:59 +0000
Received: from BYAPR12MB2615.namprd12.prod.outlook.com
 ([fe80::886a:6185:379a:c41c]) by BYAPR12MB2615.namprd12.prod.outlook.com
 ([fe80::886a:6185:379a:c41c%6]) with mapi id 15.20.3742.012; Mon, 11 Jan 2021
 04:30:59 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Huang, Ray" <Ray.Huang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v2 7/7] drm/amd/pm: implement processor fine grain feature
 for vangogh (v2)
Thread-Topic: [PATCH v2 7/7] drm/amd/pm: implement processor fine grain
 feature for vangogh (v2)
Thread-Index: AQHW59IEij41i9HaWEyH5gWpAmargaoh1XOQ
Date: Mon, 11 Jan 2021 04:30:59 +0000
Message-ID: <BYAPR12MB261506E2AF60836DB710D9F1E4AB0@BYAPR12MB2615.namprd12.prod.outlook.com>
References: <20210111042610.2234748-1-ray.huang@amd.com>
 <20210111042610.2234748-2-ray.huang@amd.com>
In-Reply-To: <20210111042610.2234748-2-ray.huang@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=050aaa90-ff4d-4af2-a79f-9475807dfe38;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-01-11T04:30:52Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a4957486-313c-4077-44fb-08d8b5e9b22f
x-ms-traffictypediagnostic: BYAPR12MB2888:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB28885E2E59E620C91F5D5472E4AB0@BYAPR12MB2888.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WvQb+pVBunYQgbxTn1veR/yFE/KoT3N1URw/GB+1vKIOY5h3KMVBg+VI91+wbSnIIYByI5QjoSc0L0s0OcUCTUr5hTcqLhFn7nZUl1ChKx2yEqoplVCNQLSX1oRUGzLl50pqJ5sHO4DOBuOPLCcUiFUsU8GL+DB9JaQcl+eHY/3tjNKl4V1QH6y9RHHxLWWQozO0i5BgWt27t4Lqyp9qqCSkH8CEtkuHNnnGa2V8oEkaeLv0FL7Dtu6QWa9VLCMMMKtDUdw9SUtYIdyQZzYYRHxgreuWhYsy19ABg6lSewj2Q4Wtr07YWxBbBrfmADS7EDMhyOTCr/0xKarx9uJt/UqW2hO4CLdqcHYgxH6jzknH43A/6DksgUJ+ZuqrLfQLNVdZn3Q7/xcLCcf+Xweziw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB2615.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(39860400002)(136003)(396003)(346002)(66946007)(53546011)(478600001)(64756008)(66556008)(66476007)(186003)(4326008)(8676002)(6506007)(5660300002)(52536014)(2906002)(76116006)(66446008)(71200400001)(83380400001)(7696005)(55016002)(110136005)(33656002)(26005)(54906003)(8936002)(9686003)(86362001)(316002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?M96VdOBtSidv/8LaVdmLbGE/OBaRItrYDV9rrFBsgtsJA2EVdUokXVuqm0C4?=
 =?us-ascii?Q?0bQ3MXsSEVMq8dN8e7X2U11x66p10bR6xBbW03VsFFMfROw8YmbEKjajNaVP?=
 =?us-ascii?Q?6QLUvKirpEuyIQ7ru1hboYfhYU1KJplKyekwlKRhU3aVC3pO1UZHlDefj9jz?=
 =?us-ascii?Q?8jWPuJuZ1aSP6pWvTvea4+/fX8qHHa46iSUU2tbzT/LpJKEcxrnynWD5M9CL?=
 =?us-ascii?Q?J404nPYclxZ++b4V8yQ1RoLf2ac2WtGA55BF8XEWpRXdpgzrOiWKfPuP1lNI?=
 =?us-ascii?Q?thTpu6bVs6+jSetGOseWiCxUoJ8+hy59vWXZwg6oSDS+RrPD23VcP4m0Se2T?=
 =?us-ascii?Q?HX3NHuJp6ZsVQ2dxD/A1klsLRNElKodu++4rEsOme53B9BR8cuPCmRcRFhJ7?=
 =?us-ascii?Q?PwNhgqc9FPMkyPDclY/BkflsBvstu9N+7IDOS63PE5zGgmPxiMQtlxHbATqK?=
 =?us-ascii?Q?akVfdiIDn2HAL/Hsf9bazv5LdLSXV4SDdQClQYs9xVlI2OTrJTYoyM3krHw2?=
 =?us-ascii?Q?UKuPGHOwgJ3xD2prpPUKZ7FU/jZ8xZW9rRKwOIJ3hEoQrfMbbWts44L3ocmX?=
 =?us-ascii?Q?oKP1MjL7oSXJwyFWBTz3Y5Vhgsfg1VTZAjOysmJo0sGVE8sOGi5+wiwkbNHt?=
 =?us-ascii?Q?E8kyK/M1wSmUizay6rjpqutmAPfKq0RyilVUx6WV4YbMODSPJYsJ9W4qwUBi?=
 =?us-ascii?Q?I1pq75ggtEKTmu+q74wqGhe/v2L0dmyMHSzaqidLPgvzAivnScQ8FX73d5SH?=
 =?us-ascii?Q?A/9Nu8Na4og8t+AvOerhi75B0cS1BoOd4OBkdFaRKnjj9RALMm7zVn/Xxfhg?=
 =?us-ascii?Q?mtwFDsHm9N2wtbyTcyPYicO2/tWwxDEiQPd2D4AGkxrt68XFsAUaaIxknyWS?=
 =?us-ascii?Q?KyhDiIAkbiSxLKcs/NXdJpk+hV7C/zWL3aczNMMp5dDG+ZorVyiN6ud4LkI+?=
 =?us-ascii?Q?FR0z9pX3LzzA/Z7g8TEjRYBhpC4VCe9V32EnYZiEGKU=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2615.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4957486-313c-4077-44fb-08d8b5e9b22f
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2021 04:30:59.3465 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yAHsSIL/lGiA9qKWCZc4YT90gkpa5dBRPqR2tHfmmwL7e1ffdjU0cV6tVzM2Nra9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2888
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
 \(Matthew\)" <Xiaomeng.Hou@amd.com>, "Liu, Aaron" <Aaron.Liu@amd.com>, "Du,
 Xiaojian" <Xiaojian.Du@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Evan Quan <evan.quan@amd.com>

-----Original Message-----
From: Huang, Ray <Ray.Huang@amd.com>
Sent: Monday, January 11, 2021 12:26 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Liu, Aaron <Aaron.Liu@amd.com>; Du, Xiaojian <Xiaojian.Du@amd.com>; Hou, Xiaomeng (Matthew) <Xiaomeng.Hou@amd.com>; Quan, Evan <Evan.Quan@amd.com>; Huang, Ray <Ray.Huang@amd.com>
Subject: [PATCH v2 7/7] drm/amd/pm: implement processor fine grain feature for vangogh (v2)

This patch is to implement the processor fine grain feature for vangogh.
It's similar with gfx clock, the only difference is below:

echo "p core_id level value" > pp_od_clk_voltage

1. "p" - set the cclk (processor) frequency 2. "core_id" - 0/1/2/3, represents which cpu core you want to select 2. "level" - 0 or 1, "0" represents the min value,  "1" represents the
   max value
3. "value" - the target value of cclk frequency, it should be limited in
   the safe range

v2: fix some missing changes as Evan's suggestion.

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 .../gpu/drm/amd/include/kgd_pp_interface.h    |  1 +
 drivers/gpu/drm/amd/pm/amdgpu_pm.c            |  3 +
 drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h       |  6 ++
 drivers/gpu/drm/amd/pm/inc/smu_types.h        |  1 +
 .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  | 80 ++++++++++++++++++-
 5 files changed, 90 insertions(+), 1 deletion(-)

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
index a5be03aa384b..75cefcb25a44 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -800,6 +800,8 @@ static ssize_t amdgpu_set_pp_od_clk_voltage(struct device *dev,

 if (*buf == 's')
 type = PP_OD_EDIT_SCLK_VDDC_TABLE;
+else if (*buf == 'p')
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
 size += amdgpu_dpm_print_clock_levels(adev, OD_MCLK, buf+size); diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
index 97d788451624..25ee9f51813b 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
@@ -465,6 +465,12 @@ struct smu_context
 uint32_t gfx_default_soft_max_freq;
 uint32_t gfx_actual_hard_min_freq;
 uint32_t gfx_actual_soft_max_freq;
+
+uint32_t cpu_default_soft_min_freq;
+uint32_t cpu_default_soft_max_freq;
+uint32_t cpu_actual_soft_min_freq;
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
index 63be82386964..b2b2955c1024 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -449,11 +449,22 @@ static int vangogh_print_fine_grain_clk(struct smu_context *smu,
 (smu->gfx_actual_soft_max_freq > 0) ? smu->gfx_actual_soft_max_freq : smu->gfx_default_soft_max_freq);
 }
 break;
+case SMU_OD_CCLK:
+if (smu->od_enabled) {
+size = sprintf(buf, "CCLK_RANGE in Core%d:\n",  smu->cpu_core_id_select);
+size += sprintf(buf + size, "0: %10uMhz\n",
+(smu->cpu_actual_soft_min_freq > 0) ? smu->cpu_actual_soft_min_freq : smu->cpu_default_soft_min_freq);
+size += sprintf(buf + size, "1: %10uMhz\n",
+(smu->cpu_actual_soft_max_freq > 0) ? smu->cpu_actual_soft_max_freq : smu->cpu_default_soft_max_freq);
+}
+break;
 case SMU_OD_RANGE:
 if (smu->od_enabled) {
 size = sprintf(buf, "%s:\n", "OD_RANGE");
 size += sprintf(buf + size, "SCLK: %7uMhz %10uMhz\n",
 smu->gfx_default_hard_min_freq, smu->gfx_default_soft_max_freq);
+size += sprintf(buf + size, "CCLK: %7uMhz %10uMhz\n",
+smu->cpu_default_soft_min_freq, smu->cpu_default_soft_max_freq);
 }
 break;
 case SMU_SOCCLK:
@@ -1245,7 +1256,7 @@ static ssize_t vangogh_get_gpu_metrics(struct smu_context *smu,  }

 static int vangogh_od_edit_dpm_table(struct smu_context *smu, enum PP_OD_DPM_TABLE_COMMAND type,
-long input[], uint32_t size)
+long input[], uint32_t size)
 {
 int ret = 0;

@@ -1255,6 +1266,34 @@ static int vangogh_od_edit_dpm_table(struct smu_context *smu, enum PP_OD_DPM_TAB
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
+if (input[2] < smu->cpu_default_soft_min_freq) {
+dev_warn(smu->adev->dev, "Fine grain setting minimum cclk (%ld) MHz is less than the minimum allowed (%d) MHz\n",
+input[2], smu->cpu_default_soft_min_freq);
+return -EINVAL;
+}
+smu->cpu_actual_soft_min_freq = input[2];
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
 dev_err(smu->adev->dev, "Input parameter number not correct\n"); @@ -1286,6 +1325,8 @@ static int vangogh_od_edit_dpm_table(struct smu_context *smu, enum PP_OD_DPM_TAB
 } else {
 smu->gfx_actual_hard_min_freq = smu->gfx_default_hard_min_freq;
 smu->gfx_actual_soft_max_freq = smu->gfx_default_soft_max_freq;
+smu->cpu_actual_soft_min_freq = smu->cpu_default_soft_min_freq;
+smu->cpu_actual_soft_max_freq = smu->cpu_default_soft_max_freq;

 ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetHardMinGfxClk,
 smu->gfx_actual_hard_min_freq, NULL); @@ -1300,6 +1341,20 @@ static int vangogh_od_edit_dpm_table(struct smu_context *smu, enum PP_OD_DPM_TAB
 dev_err(smu->adev->dev, "Restore the default soft max sclk failed!");
 return ret;
 }
+
+ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetSoftMinCclk,
+      smu->cpu_actual_soft_min_freq, NULL);
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
@@ -1326,6 +1381,24 @@ static int vangogh_od_edit_dpm_table(struct smu_context *smu, enum PP_OD_DPM_TAB
 dev_err(smu->adev->dev, "Set soft max sclk failed!");
 return ret;
 }
+
+ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetSoftMinCclk,
+      ((smu->cpu_core_id_select << 20)
+       | smu->cpu_actual_soft_min_freq),
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
@@ -1351,6 +1424,11 @@ static int vangogh_set_fine_grain_gfx_freq_parameters(struct smu_context *smu)
 smu->gfx_actual_hard_min_freq = 0;
 smu->gfx_actual_soft_max_freq = 0;

+smu->cpu_default_soft_min_freq = 1400;
+smu->cpu_default_soft_max_freq = 3500;
+smu->cpu_actual_soft_min_freq = 0;
+smu->cpu_actual_soft_max_freq = 0;
+
 return 0;
 }

--
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
