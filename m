Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5313F109E55C
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Mar 2026 07:06:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 54BC310E992;
	Thu, 26 Mar 2026 07:06:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="whbfUl2A";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012001.outbound.protection.outlook.com
 [40.93.195.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F0D210E992
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2026 07:06:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JS5IpnUb9TXgNiYGq8vn6V3nrW/h2lGh9EGTh4QQEvSnvwgfkGvHoVfl8MOmI/LGVaVIttthPkurdtQol7cksaVoQLbiF5U7Q2FhAVkIOzR2CarVk4EaRsMC6bz4fMFkh66bSfP5DZUQ2GdrHeiWHhvdjh5n4kY18ate+UXnawbvHw4TRGZ9rHc+5uXlElZbmRqT4ZwYwB9YEtNQrvyBngeum9pZ37mKU4y+/cFnpH3vFfj/pBZ239354nN/Fu0TsbFfo4QDIGNgNOrStM4BjZfAbghX4aJRSsNk4sMGlZWEtZa1I060B5Tl8B0i2JWH9Pv9mSXw1jOO09VEXEXbHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uY63BQzkmKRVlf2v4V9DzaQ9/kPSx/dMHIcd1iRvXYw=;
 b=PxGqCQ/F/ixNOUnzobRjmnY6JH2NywvjQCBgfyVNO0IaNX6KaPE5DTJak8Ow2PJwDa3Kt5N6jHvYkgb5s8bhrmWFQoNykVlO/ub+n5h6cflnlq+2wiYRvWVoPoDYfmGw7vUaaznlnIH98wW99crnN5FVnSjJ3/LAHLlIIbj+RZuRoDjCR7dhMtZv6+WAGAiEQwBMftd83t9R7upBSccD1B8JJaT4hinfYcbrBbtaSxng6mdxotXa3ABFFw0VZfaUhUhjLlmA8zIJMwM8Th+gIeewwu0wtGonNqtV00u90wFtmmkKASO/4R9yK/Twg5t40i6SmjzoBT5Tm7RJrddgZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uY63BQzkmKRVlf2v4V9DzaQ9/kPSx/dMHIcd1iRvXYw=;
 b=whbfUl2AV2q9JD1rQ/mkAKy7iwqv4k7xnJXu698/MTnM0MOSbWU+FynircyHwUMV8D0zVla1gs5f+eWJQHI5kL9tdPaiObgxmsFFBSQ5ng+ZOmopvTHa9/q8fFc3DZxNBOqlV0l/xAx34Qdc+Kr8Wjm2jWtIuSW5N9BC3rzpsM8=
Received: from MW4PR12MB6803.namprd12.prod.outlook.com (2603:10b6:303:20e::10)
 by CH2PR12MB4182.namprd12.prod.outlook.com (2603:10b6:610:ae::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.7; Thu, 26 Mar
 2026 07:05:55 +0000
Received: from MW4PR12MB6803.namprd12.prod.outlook.com
 ([fe80::c193:ef2e:260f:dcfd]) by MW4PR12MB6803.namprd12.prod.outlook.com
 ([fe80::c193:ef2e:260f:dcfd%7]) with mapi id 15.20.9745.019; Thu, 26 Mar 2026
 07:05:54 +0000
From: "Feng, Kenneth" <Kenneth.Feng@amd.com>
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>
Subject: RE: [PATCH] drm/amd/pm: correct mem_busy_percent display due to
 calculation errors
Thread-Topic: [PATCH] drm/amd/pm: correct mem_busy_percent display due to
 calculation errors
Thread-Index: AQHcvMT1czWsDV+qhUiFmdpO70vbSrXAZE/w
Date: Thu, 26 Mar 2026 07:05:54 +0000
Message-ID: <MW4PR12MB6803D03DEFBA17D92CF2F8EB8E56A@MW4PR12MB6803.namprd12.prod.outlook.com>
References: <20260326020445.1187519-1-kevinyang.wang@amd.com>
In-Reply-To: <20260326020445.1187519-1-kevinyang.wang@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-03-26T07:05:27.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR12MB6803:EE_|CH2PR12MB4182:EE_
x-ms-office365-filtering-correlation-id: a7b13f39-7c4a-472e-f239-08de8b061f8b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700021|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info: ZIPYRpwGXCyVDFQIUxYygJN+act9Y0I89/nhhimPXOQA8LxzP7DqlWeazUGCaj3Ji/3PzlWzbk8Siky+UHx4efq7yQA5Yt6s/JMM2wTJg3esz4j9YToNZOGHIUDfZMPw58ETjZG59Lt0QiBR7JZfIT/75PjEhNTERDTvOhbcKfuXFqncEUZhvZUCU0gIDVlZWJhkckoTVQ+ctjXp49u7BP+6ki7fo89Y6ChRB1iCt/dctQaz7rIbcogXyaxd+jC1WiLCp2UN1VEMPIbdKpBOary6I74GrPs/mRqpg3ybUYz5GHOSglbtl7pTeKwcW5+tK5sWsfXe9jsIK9iSTIWvdLOrQ4bWbUERkYls4g1hRKpMXeLKIAcphpOLtG/Cxkbeh3tHpLIfqvfVkMuWfz/qrQUjlv0KB6bRpQ7vviCGYMbsHnJ8Aw3YsQFL0qb0FY79Uw6xdfJLOESWHfKg/xkd3I37oZN4uks0QcTVr7hPqQjqQBUTi2MEIC1cvh0eS9qT9p8XYRQ9mRj5x4gxQ51qCCjNlyp8jLpUn9WEmaujp/i4O8jz3+8gviuhu4cAb7Kd116WgJQJ33ruG++ZosdRkjefz1drmPhRfIT5Ja/PIXuSWCYcKYmrFLBs3r6rO/zR2e++81avjmJ9Zt+cdmGS10wNX6BMIdDfHz/MIyjTmq7tqXYZxTotURv1hWHRujM+Z89NdGxqI4e58R7cDtEhxiA9C4z+lVFBMjJIDujS/cnIaN4XaiD6fy9eF4Huwgk3
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6803.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Vptd7eCBVxDRBgydW0nFi/83tT29nlqOMrXschtbed/dAlOv47+/5zcie327?=
 =?us-ascii?Q?hL4DOJHTd63ezif5xgplikKKE1Eq6nmvV86jYo3yyjjPEMx9wGGFz6Cw7Bh5?=
 =?us-ascii?Q?wUiBSxIdCUIWg0QRRe7oNJt96sn98bOtBmNrs72i/7DcNvxVVs//fgH8IvDN?=
 =?us-ascii?Q?IRAvyw0IZXeqrZRcWqtRyhMWM9VCb8JxIkwcYXkoqxYS7hocEuX9J2NF15Ll?=
 =?us-ascii?Q?FDs2KuFUcDeuG9GixEUI2ArrnD3padLoJUClryoq3Nd+foV4MUO7a1PSMrvt?=
 =?us-ascii?Q?MMnU+HDE8f98YPS07TOtO7adNNi10jkwkbmMaNas05feMTQz31Je1DIwdeGN?=
 =?us-ascii?Q?6OBd2vCI/LSX3n5/Ajx8EIz7fzMkVoYTZ7IS8VjXiZr3outDBJVOJ1E3/yCx?=
 =?us-ascii?Q?7jIufn3wdma368Q45+fxH6k702u2h8xndWBlEM/6xG1pWEn96+8YN50smg33?=
 =?us-ascii?Q?dM3Wg/hf2QOldyWPcKiZyy2NquRbSMTkXsnXBPF95kURhhu3iO59R/rVFILm?=
 =?us-ascii?Q?0FIA0piHDdCPzzxpgQSAkMI6JTAccVBnLLM2x9PldnnPp78sriNfRC4mkFoM?=
 =?us-ascii?Q?DIqeMCHZEssYxPemTsCHeRDdmzN29iI2KWfPy6rpLhMCnQTDhqoiIbV8bpNz?=
 =?us-ascii?Q?1vfnw9BHrYshUrEf4AUoohgjuYLgJzc/IAZ1tTNe4WmS2YtWuwQCqtVzDCEI?=
 =?us-ascii?Q?yKEZjbZQ8k0rbcURd+qf5xnjv4hpqLmsE68/UNmD0E4++36yXUP9oicrxhql?=
 =?us-ascii?Q?JcH3itNjGGvuueVzwakkcIKi7YRloR5e+keE0B+TVpAXS/zMCv0M1y0HeJtw?=
 =?us-ascii?Q?x4m6xXo0HqWKW9etSXyZH1mtF5lyOgbEERVqPTszYReDNpEaWLLlcw3Jhewv?=
 =?us-ascii?Q?KvdoPs/o+3KNlTzECVwdYcEUJI2Jm+NNcC2BDCPvyVjtYW2/vt8mIH69gtRw?=
 =?us-ascii?Q?AHObxQywKtaDMHbCwbIGsvrWr+Q4BdrQhfNKUGb3PsS7VLwGPvL/AO+elmMC?=
 =?us-ascii?Q?ITS3DWXnBlQmJO1ox3dUjr8u3kXCK0jJjzJ+NX+YpqNwSEwZmrguBb4Svhf2?=
 =?us-ascii?Q?IiknpmeiS4EclIq698Hhs4aAmM4dLeiMVft77i/LNL/T3vpTwwBrn+8YykuB?=
 =?us-ascii?Q?YerpDpeY9uMC5y/vpehZcqVUIHJQZKV7lKcoCoB48PeHKF38ADJdwyLJ0giA?=
 =?us-ascii?Q?ZfZkJYgP+MYE31EFpMvBpkI6KkKp+A47yLYgKs1wh8P7zifaQv5ffSXxZ/mA?=
 =?us-ascii?Q?v9H21arYeEfBl/FTKd6d6ZTvI8G8YuDLPc9HqmqoobYXlNzYrcIlGR8s65e0?=
 =?us-ascii?Q?uKrqf/U1tsos7CyPYYP0Bl0cRVeXo1UTTfMRPxitLU/yhpH2oaM4fBf4tdxl?=
 =?us-ascii?Q?kkHu4HxwlBZOHVmF7chAZRarBtBmoHXO1IDvVbqPSzkxvcYzY0GoyaLybm2R?=
 =?us-ascii?Q?vaPL7kn2KBkyLCmoXI7DkxM75zfa+jrU6mB2x8JZv+kAi5ZXCffOFDsyWfwj?=
 =?us-ascii?Q?GoX79NKU+a09GtDUARfQyZZGTj73QMUd0oO80oWu820avwGijm7pRK1SWLlh?=
 =?us-ascii?Q?MRf3y7OiQ3zQH3DmuSW9w75ycaDwXANYIA/ucVpvqZZuFbbyLocEvs/jwVCS?=
 =?us-ascii?Q?BBJE5Rcjo6tWK7ddH7xH4+FZ/fb1cLUOpng73/wc5VyW8sPSykDDfMDA/ET6?=
 =?us-ascii?Q?nIakmSsC0+m45U9QXtA1SgLQCxITKsL5JOZsKxoflWqvIWFz?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6803.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7b13f39-7c4a-472e-f239-08de8b061f8b
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2026 07:05:54.8035 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j/9IcULJ8rGeHsfEMlwqZ1Q6zTxGbzjBd+wiCrkVTYXilr6c0BDKbV9Qweo0vJ0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4182
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - AMD Internal Distribution Only]

OK for the CAB case.
Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>



-----Original Message-----
From: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
Sent: Thursday, March 26, 2026 10:05 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking <Hawking=
.Zhang@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>
Subject: [PATCH] drm/amd/pm: correct mem_busy_percent display due to calcul=
ation errors

PMFW may return invalid values due to internal calculation errors.
so, the kmd driver must validate and sanitize the returned values to preven=
t issues caused by firmware calculation errors.

For example, values 0xfffe (-2) and 0xffff (-1) are treated as invalid and =
clamped to 0.

this applies to devices with CAB (Cache As Buffer) functionality.

Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/4905

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h   | 17 +++++++++++++++++
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c    | 10 +++++-----
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c    | 10 +++++-----
 .../drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c    | 10 +++++-----
 4 files changed, 32 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/dr=
m/amd/pm/swsmu/inc/amdgpu_smu.h
index 609f5ab07d8a..365946c43e11 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -2164,4 +2164,21 @@ static inline void smu_feature_init(struct smu_conte=
xt *smu, int feature_num)
        smu_feature_list_clear_all(smu, SMU_FEATURE_LIST_ALLOWED);  }

+/*
+ * smu_safe_u16_nn - Make u16 safe by filtering negative overflow
+errors
+ * @val: Input u16 value, may contain invalid negative overflows
+ *
+ * Convert u16 to non-negative value. Cast to s16 to detect negative
+values
+ * caused by calculation errors. Return 0 for negative errors, return
+ * original value if valid.
+ *
+ * Return: Valid u16 value or 0
+ */
+static inline u16 smu_safe_u16_nn(u16 val) {
+    s16 tmp =3D (s16)val;
+
+    return tmp < 0 ? 0 : val;
+}
+
 #endif
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index 9be7a2af560d..16f69b548ca4 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -774,13 +774,13 @@ static int smu_v13_0_0_get_smu_metrics_data(struct sm=
u_context *smu,
                        *value =3D metrics->AverageGfxclkFrequencyPreDs;
                break;
        case METRICS_AVERAGE_FCLK:
-               if (metrics->AverageUclkActivity <=3D SMU_13_0_0_BUSY_THRES=
HOLD)
+               if (smu_safe_u16_nn(metrics->AverageUclkActivity) <=3D
+SMU_13_0_0_BUSY_THRESHOLD)
                        *value =3D metrics->AverageFclkFrequencyPostDs;
                else
                        *value =3D metrics->AverageFclkFrequencyPreDs;
                break;
        case METRICS_AVERAGE_UCLK:
-               if (metrics->AverageUclkActivity <=3D SMU_13_0_0_BUSY_THRES=
HOLD)
+               if (smu_safe_u16_nn(metrics->AverageUclkActivity) <=3D
+SMU_13_0_0_BUSY_THRESHOLD)
                        *value =3D metrics->AverageMemclkFrequencyPostDs;
                else
                        *value =3D metrics->AverageMemclkFrequencyPreDs;
@@ -801,7 +801,7 @@ static int smu_v13_0_0_get_smu_metrics_data(struct smu_=
context *smu,
                *value =3D metrics->AverageGfxActivity;
                break;
        case METRICS_AVERAGE_MEMACTIVITY:
-               *value =3D metrics->AverageUclkActivity;
+               *value =3D smu_safe_u16_nn(metrics->AverageUclkActivity);
                break;
        case METRICS_AVERAGE_VCNACTIVITY:
                *value =3D max(metrics->Vcn0ActivityPercentage,
@@ -2086,7 +2086,7 @@ static ssize_t smu_v13_0_0_get_gpu_metrics(struct smu=
_context *smu,
                                             metrics->AvgTemperature[TEMP_V=
R_MEM1]);

        gpu_metrics->average_gfx_activity =3D metrics->AverageGfxActivity;
-       gpu_metrics->average_umc_activity =3D metrics->AverageUclkActivity;
+       gpu_metrics->average_umc_activity =3D
+smu_safe_u16_nn(metrics->AverageUclkActivity);
        gpu_metrics->average_mm_activity =3D max(metrics->Vcn0ActivityPerce=
ntage,
                                               metrics->Vcn1ActivityPercent=
age);

@@ -2103,7 +2103,7 @@ static ssize_t smu_v13_0_0_get_gpu_metrics(struct smu=
_context *smu,
        else
                gpu_metrics->average_gfxclk_frequency =3D metrics->AverageG=
fxclkFrequencyPreDs;

-       if (metrics->AverageUclkActivity <=3D SMU_13_0_0_BUSY_THRESHOLD)
+       if (smu_safe_u16_nn(metrics->AverageUclkActivity) <=3D
+SMU_13_0_0_BUSY_THRESHOLD)
                gpu_metrics->average_uclk_frequency =3D metrics->AverageMem=
clkFrequencyPostDs;
        else
                gpu_metrics->average_uclk_frequency =3D metrics->AverageMem=
clkFrequencyPreDs;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index 5cc15545da6e..34a5973b9a06 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -784,13 +784,13 @@ static int smu_v13_0_7_get_smu_metrics_data(struct sm=
u_context *smu,
                *value =3D metrics->AverageGfxclkFrequencyPreDs;
                break;
        case METRICS_AVERAGE_FCLK:
-               if (metrics->AverageUclkActivity <=3D SMU_13_0_7_BUSY_THRES=
HOLD)
+               if (smu_safe_u16_nn(metrics->AverageUclkActivity) <=3D
+SMU_13_0_7_BUSY_THRESHOLD)
                        *value =3D metrics->AverageFclkFrequencyPostDs;
                else
                        *value =3D metrics->AverageFclkFrequencyPreDs;
                break;
        case METRICS_AVERAGE_UCLK:
-               if (metrics->AverageUclkActivity <=3D SMU_13_0_7_BUSY_THRES=
HOLD)
+               if (smu_safe_u16_nn(metrics->AverageUclkActivity) <=3D
+SMU_13_0_7_BUSY_THRESHOLD)
                        *value =3D metrics->AverageMemclkFrequencyPostDs;
                else
                        *value =3D metrics->AverageMemclkFrequencyPreDs;
@@ -815,7 +815,7 @@ static int smu_v13_0_7_get_smu_metrics_data(struct smu_=
context *smu,
                *value =3D metrics->AverageGfxActivity;
                break;
        case METRICS_AVERAGE_MEMACTIVITY:
-               *value =3D metrics->AverageUclkActivity;
+               *value =3D smu_safe_u16_nn(metrics->AverageUclkActivity);
                break;
        case METRICS_AVERAGE_SOCKETPOWER:
                *value =3D metrics->AverageSocketPower << 8; @@ -2092,7 +20=
92,7 @@ static ssize_t smu_v13_0_7_get_gpu_metrics(struct smu_context *smu,
                                             metrics->AvgTemperature[TEMP_V=
R_MEM1]);

        gpu_metrics->average_gfx_activity =3D metrics->AverageGfxActivity;
-       gpu_metrics->average_umc_activity =3D metrics->AverageUclkActivity;
+       gpu_metrics->average_umc_activity =3D
+smu_safe_u16_nn(metrics->AverageUclkActivity);
        gpu_metrics->average_mm_activity =3D max(metrics->Vcn0ActivityPerce=
ntage,
                                               metrics->Vcn1ActivityPercent=
age);

@@ -2105,7 +2105,7 @@ static ssize_t smu_v13_0_7_get_gpu_metrics(struct smu=
_context *smu,
        else
                gpu_metrics->average_gfxclk_frequency =3D metrics->AverageG=
fxclkFrequencyPreDs;

-       if (metrics->AverageUclkActivity <=3D SMU_13_0_7_BUSY_THRESHOLD)
+       if (smu_safe_u16_nn(metrics->AverageUclkActivity) <=3D
+SMU_13_0_7_BUSY_THRESHOLD)
                gpu_metrics->average_uclk_frequency =3D metrics->AverageMem=
clkFrequencyPostDs;
        else
                gpu_metrics->average_uclk_frequency =3D metrics->AverageMem=
clkFrequencyPreDs;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
index 28c1b084fe62..aaec3a251e0f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
@@ -660,13 +660,13 @@ static int smu_v14_0_2_get_smu_metrics_data(struct sm=
u_context *smu,
                        *value =3D metrics->AverageGfxclkFrequencyPreDs;
                break;
        case METRICS_AVERAGE_FCLK:
-               if (metrics->AverageUclkActivity <=3D SMU_14_0_2_BUSY_THRES=
HOLD)
+               if (smu_safe_u16_nn(metrics->AverageUclkActivity) <=3D
+SMU_14_0_2_BUSY_THRESHOLD)
                        *value =3D metrics->AverageFclkFrequencyPostDs;
                else
                        *value =3D metrics->AverageFclkFrequencyPreDs;
                break;
        case METRICS_AVERAGE_UCLK:
-               if (metrics->AverageUclkActivity <=3D SMU_14_0_2_BUSY_THRES=
HOLD)
+               if (smu_safe_u16_nn(metrics->AverageUclkActivity) <=3D
+SMU_14_0_2_BUSY_THRESHOLD)
                        *value =3D metrics->AverageMemclkFrequencyPostDs;
                else
                        *value =3D metrics->AverageMemclkFrequencyPreDs;
@@ -687,7 +687,7 @@ static int smu_v14_0_2_get_smu_metrics_data(struct smu_=
context *smu,
                *value =3D metrics->AverageGfxActivity;
                break;
        case METRICS_AVERAGE_MEMACTIVITY:
-               *value =3D metrics->AverageUclkActivity;
+               *value =3D smu_safe_u16_nn(metrics->AverageUclkActivity);
                break;
        case METRICS_AVERAGE_VCNACTIVITY:
                *value =3D max(metrics->AverageVcn0ActivityPercentage,
@@ -2146,7 +2146,7 @@ static ssize_t smu_v14_0_2_get_gpu_metrics(struct smu=
_context *smu,
                                             metrics->AvgTemperature[TEMP_V=
R_MEM1]);

        gpu_metrics->average_gfx_activity =3D metrics->AverageGfxActivity;
-       gpu_metrics->average_umc_activity =3D metrics->AverageUclkActivity;
+       gpu_metrics->average_umc_activity =3D
+smu_safe_u16_nn(metrics->AverageUclkActivity);
        gpu_metrics->average_mm_activity =3D max(metrics->AverageVcn0Activi=
tyPercentage,
                                               metrics->Vcn1ActivityPercent=
age);

@@ -2158,7 +2158,7 @@ static ssize_t smu_v14_0_2_get_gpu_metrics(struct smu=
_context *smu,
        else
                gpu_metrics->average_gfxclk_frequency =3D metrics->AverageG=
fxclkFrequencyPreDs;

-       if (metrics->AverageUclkActivity <=3D SMU_14_0_2_BUSY_THRESHOLD)
+       if (smu_safe_u16_nn(metrics->AverageUclkActivity) <=3D
+SMU_14_0_2_BUSY_THRESHOLD)
                gpu_metrics->average_uclk_frequency =3D metrics->AverageMem=
clkFrequencyPostDs;
        else
                gpu_metrics->average_uclk_frequency =3D metrics->AverageMem=
clkFrequencyPreDs;
--
2.47.3

