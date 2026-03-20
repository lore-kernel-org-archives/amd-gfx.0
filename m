Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E78F41093170
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Mar 2026 03:16:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 755D210E88C;
	Fri, 20 Mar 2026 03:16:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="z/1pETSw";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013014.outbound.protection.outlook.com
 [40.93.201.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B05BE10E954
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Mar 2026 03:16:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=htxwhj+8phz7D7ZpUFu3vf2wcr8O9wAtws7kFk6DWYFsk7SaHHcOTapZd0ryqSKRGnJCIQ82Va7oaW0q7aXoKHSrQSKbLuOUup+ki7zhkVRa5TBT7S9+PiqPTpKWUBaXY814AC0CIkpZtR0jRtPExZrfVX3Oxg29FptpgZ03UBSTtMIjHqkDAG+IZmzPJBJuYTwYR97c9R1WfKPvs00Oc1kiwrrECCjw8iZprbQj5s7WnSrgnJ7GCw5wOHxVLH+VQ2d1VtkzeRHsSbc3mcpf6uUv31Q8NozglzetmfSuaBaTL50NIvMR/SsQlGz0VaRPgTTA20Ay570UFZVa2fftCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B9wUDms3ZjGuHvm2L78H/yKen22Wf7CvconJUy/pPPc=;
 b=Dmmrl/oxC1eoeslnctbKHIiWyP9/fMONG8gvx/ead673u3tw4f6FgDKGhUgbXTmWh+jb+BxnB4v/yW0P8Ev7/XZKmy0NnZhor1vHe8lME5U8h8Lb7OrvfZEGAsuhIMqRBcRsyX4gSIsoRm5J+SZg0mFAI4QsGdNB2BjmwqWrRnrIGcLUZia62Bst7VDb2YM3ahRSI+1ZqR3iEGPwmQeQTem1qeI9HnuYAsIBVvDdfQOLpjjILBdFfvvM5RqotCyZFntU6NdKADUAMn0M8/7oEPnrs3ijtO3ylqhsov+rjlES1rjCvVJD1boxiQID5t5U7nMmZX6a3ZG9LgnT+J62xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B9wUDms3ZjGuHvm2L78H/yKen22Wf7CvconJUy/pPPc=;
 b=z/1pETSwySZ66hxH9vc9FLxYaFxU1ZY0jfG//EK47D5ruZVMAliR7S5ve5QeJMDvjUfkoB3fzt7F3aOY5EkTEjZUr7iPXKK9ZPxFjlUDu2lIV3F0yeOIeStgG1Eit985Mza6zKGnr9QZmCYeAO2saC0aaA+nqlod2xSA5uFwj3k=
Received: from DM6PR12MB2972.namprd12.prod.outlook.com (2603:10b6:5:39::31) by
 MN2PR12MB4423.namprd12.prod.outlook.com (2603:10b6:208:24f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.13; Fri, 20 Mar
 2026 03:16:04 +0000
Received: from DM6PR12MB2972.namprd12.prod.outlook.com
 ([fe80::574d:7c2d:4d0a:855e]) by DM6PR12MB2972.namprd12.prod.outlook.com
 ([fe80::574d:7c2d:4d0a:855e%6]) with mapi id 15.20.9700.006; Fri, 20 Mar 2026
 03:16:04 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>, "Feng, Kenneth" <Kenneth.Feng@amd.com>
Subject: RE: [PATCH 1/2] drm/amd/pm: disable OD_FAN_CURVE if temp or pwm range
 invalid for smu v13
Thread-Topic: [PATCH 1/2] drm/amd/pm: disable OD_FAN_CURVE if temp or pwm
 range invalid for smu v13
Thread-Index: AQHcuAumnseXlchgw0WNZARhPgQHKLW2vgaw
Date: Fri, 20 Mar 2026 03:16:04 +0000
Message-ID: <DM6PR12MB2972DD522606573881D360A8824CA@DM6PR12MB2972.namprd12.prod.outlook.com>
References: <20260320014800.228582-1-kevinyang.wang@amd.com>
In-Reply-To: <20260320014800.228582-1-kevinyang.wang@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-03-20T03:10:08.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB2972:EE_|MN2PR12MB4423:EE_
x-ms-office365-filtering-correlation-id: bb1e8c00-7956-4f4c-75d0-08de862f0542
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7053199007|56012099003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: Ra1LXNtJ4lg7D38ww9fGSynaII058SVkQDeTp/4mVCv2ZBJKpiC5HTW8161lfDASNWrN0a0bZu4oNwQe4wqgQS6+q/4EJ3N1onfiNfiC9cNfMtrX4PuccbddCLN4HYHbYuDIZzYimrf3Si+fqsYhxBXQqx8Wo2ktSZzLsXTTmqU+VdRiim7fxIn109CDAKFrJWG9DLEIhcWjJp69XvuSkP1qr0n+jFvJJxn5PnVlmDr9YDNK6VYfW3Fh4FyQv6vEEgmyTPiTNPOzFBNoXWxInuM2+XoxJPwkFrdrlMkcgJ+f8f33DPt+oVZxJARY3PcFsuQsYv6ELp4JrnEN4FKArzf7RQQu7OL8IdEnb0JWJ9ztm93ML/PEKgJOajfwQREcP3yWDizakkzqUS2JudofH8s4FqdstF+pr1IG9W+s/vrZPVkpx3WzAKWnMyZPUJX087/Wy2dh28miOBfgP44vJVTguRoZXPhkGIKld92se1U9hvxD35MOQ9Z4CGsdZ5XAxQz8Nh52efl4FVxycoeCwH/WTDkT6VoZfdZbaPcwkNm7mgcKul1tl1vaM7hXgswLuD222ordL/YuWsMvAvwiy99PGSyMIVYuWuIKyp/pBZpdju8Fj1E+eAO3nM70WDFSjyAt53tcHydIdgFb7jzcp8/Ycot6imd/eYR0FCmExEDdHkZ0N2wbXw2BwwKPtc17LqBGz4UjuxzoWJ92N40zzv2uXmTVqYnmp2Xk4b3N5SBMKJ9jFV31+EGg40U+aUbZ
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2972.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007)(56012099003)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zxl7scv/yj8cVQvjz/w2VbH2YifWdXulDFUCi83XGUzIO7I9Np6kNYcEDU7n?=
 =?us-ascii?Q?NUIOzNvu3BNvd5WCBsoBgWNwdngdNXKOE8qKQxrSdAoPcwZyFC59hMQF8mR9?=
 =?us-ascii?Q?YcZP59UvGaQhOBZzRROQD4jWvUWQneLMz801PqJJaZJpyDqXVIQYf3RiBzyA?=
 =?us-ascii?Q?6pW26b5xGMeZvF4nrtAERCbsTx3XVJ+3KuYLctElVAyoj0Rj6wCwyj07Akj0?=
 =?us-ascii?Q?UitCXYBN9f4y52fJiDlzhqJJUrGkHqhxp65oZ7toNbyYPaGcHhn+5x6BYsQq?=
 =?us-ascii?Q?Q5d2tvYSklj0o+pWccz+aLZi+rrqWGxd5VjU1wNC/z91uWhAwFwOLzTzcGnw?=
 =?us-ascii?Q?fTdn1Zcivsn85bz5l8lKF9q5FpgpN6r/WFYIJZH+3sOidWpH2T5DqVSCFE2V?=
 =?us-ascii?Q?z1XGQOuEIHeUtWl2fLkDFDx256DtE5lg93bUmC7RIavPEHgNqLb+naLhBa9b?=
 =?us-ascii?Q?mHlzJ6lzE7tEZs6MsfEnbvHSEqZ/f5rt86+5ymUYX3R10ZsegejnMJYiUZCH?=
 =?us-ascii?Q?HHDP8l1/CiYdRJL+/X8b6ysRKs0Zjj8NbdZqJeAdnHsAv0Dh8U9TkuQL9Yj9?=
 =?us-ascii?Q?Vl+etslx/lIjCvqGbM4spJ3spuSlIVH5V45jHkYsmF3GiEDC9+mIrusZ+nkX?=
 =?us-ascii?Q?DBqnT4VMZhTDsi9ZgCw4Is/qzUPymhYPJiAUw6+QSLGRP/C9N/IU6bcLSWNj?=
 =?us-ascii?Q?Rzgps4RUsYlTZeegTvEzBtGZZ7N/DRgKJeMCveRxbAiDHXCSf1W4nwZmnary?=
 =?us-ascii?Q?rfaTKu0MPaN/mJa16v2ZKymtdUju0lCSYdhwMmc7qDN0Fqy7mS9ITuiOZ6y/?=
 =?us-ascii?Q?Ya2NeDIm/H0AcrJrFMDtZnM4gBmU4vNLXh3CYPgZpK7puL/5cJC22LdzyInT?=
 =?us-ascii?Q?Q9KR4ca2yt20VYdalA05QbMTa/qoqCO5dH2D+9rdj9yBVnsLef6J7VrmwT6f?=
 =?us-ascii?Q?0eiD5JFs4ADX6DQqBOHd7p6ikYbepRpCQTi7hFduWOA2TBIBRrKNbNPr+XnE?=
 =?us-ascii?Q?nckOhRjci1XDeKhFlci1OnrIk7/Ij3mqHy5X6BdKchRJUTohsvrPYEsEADUu?=
 =?us-ascii?Q?MkfG1wshtnJmqNLFvmYLNZdAuBFJr6QkiImkGqpn7lodc/6Ca7a2x6ub6cKH?=
 =?us-ascii?Q?QhctmMfO8QEXA9Xo5n1fJhHx2Kxp5y/9BEVDKyU1nsvLfSfL3dH0mGnDRqmM?=
 =?us-ascii?Q?PbXHxyTq4eqRP9NfsQrvVH2RAtPOIkx1vDf1FMuRj6S79MTppARUYgZ85L8l?=
 =?us-ascii?Q?n3UeEQcyMzqtIsP8OQrXuKc8Mg/Hmpym28qvCJ6zud/7KZENTBE4znsVWkId?=
 =?us-ascii?Q?vW98wSo8S03FMYJmcUWCcx2gSngpo2sQXqgMRWAv/MLZGAlaVAuUEMjN8LJI?=
 =?us-ascii?Q?0ebE0BLjCiZiKuzslUQatOjOhyFaE74FUwtByi5/NJLkC1KYUXLe9o4MDgpw?=
 =?us-ascii?Q?zLS+PR8PLIBzd4uVOovTNTqCoCdZCIILuG0eM7EzBQYyuLNfEhSGmoM2qNtj?=
 =?us-ascii?Q?TViSsSDo14HEskIIFMiA1wy5SdYh1Rb4WqXLF4M6V3njy6qagcFW9II/nsHd?=
 =?us-ascii?Q?qeLheKrcTumkAeCPrRXYQdEs3zAMLGEtfOEWg66H6npwAG++Dnw0JR8AcX9+?=
 =?us-ascii?Q?1bsGoBvjMkzCXONfV6iPACIHoW19KFLidlsQauTZ0jFGANJySeoPWHiGoSKG?=
 =?us-ascii?Q?vSsxdVnRUau6gNsfyK8hQMt/p6xAM4gybAtDDICDyorQfmlA?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2972.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb1e8c00-7956-4f4c-75d0-08de862f0542
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2026 03:16:04.2498 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mI00T8i1YKoIN54IBZhIpY5BcZQXVNpzDxYj6J8WFTBOdfWrFcAUZl/YPw2rTIrI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4423
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

Extra information:

[Issue]: Can not set fan speed on Radeon Pro W7900
Closes: https://github.com/ROCm/amdgpu/issues/208

Best Regards,
Kevin

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Yang Wan=
g
Sent: Friday, March 20, 2026 09:48
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking <Hawking=
.Zhang@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>
Subject: [PATCH 1/2] drm/amd/pm: disable OD_FAN_CURVE if temp or pwm range =
invalid for smu v13

Forcibly disable the OD_FAN_CURVE feature when temperature or PWM range is =
invalid, otherwise PMFW will reject this configuration on smu v13.0.x

example:
$ sudo cat /sys/bus/pci/devices/<BDF>/gpu_od/fan_ctrl/fan_curve

OD_FAN_CURVE:
0: 0C 0%
1: 0C 0%
2: 0C 0%
3: 0C 0%
4: 0C 0%
OD_RANGE:
FAN_CURVE(hotspot temp): 0C 0C
FAN_CURVE(fan speed): 0% 0%

$ echo "0 50 40" | sudo tee fan_curve

kernel log:
[  756.442527] amdgpu 0000:03:00.0: amdgpu: Fan curve temp setting(50) must=
 be within [0, 0]!
[  777.345800] amdgpu 0000:03:00.0: amdgpu: Fan curve temp setting(50) must=
 be within [0, 0]!

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  | 33 ++++++++++++++++++-  ..=
./drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  | 33 ++++++++++++++++++-
 2 files changed, 64 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index cd077151f3e4..9be7a2af560d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -59,6 +59,10 @@

 #define to_amdgpu_device(x) (container_of(x, struct amdgpu_device, pm.smu_=
i2c))

+static void smu_v13_0_0_get_od_setting_limits(struct smu_context *smu,
+                                             int od_feature_bit,
+                                             int32_t *min, int32_t *max);
+
 static const struct smu_feature_bits smu_v13_0_0_dpm_features =3D {
        .bits =3D {
                SMU_FEATURE_BIT_INIT(FEATURE_DPM_GFXCLK_BIT),
@@ -1044,8 +1048,35 @@ static bool smu_v13_0_0_is_od_feature_supported(stru=
ct smu_context *smu,
        PPTable_t *pptable =3D smu->smu_table.driver_pptable;
        const OverDriveLimits_t * const overdrive_upperlimits =3D
                                &pptable->SkuTable.OverDriveLimitsBasicMax;
+       int32_t min_value, max_value;
+       bool feature_enabled;

-       return overdrive_upperlimits->FeatureCtrlMask & (1U << od_feature_b=
it);
+       switch (od_feature_bit) {
+       case PP_OD_FEATURE_FAN_CURVE_BIT:
+               feature_enabled =3D !!(overdrive_upperlimits->FeatureCtrlMa=
sk & (1U << od_feature_bit));
+               if (feature_enabled) {
+                       smu_v13_0_0_get_od_setting_limits(smu, PP_OD_FEATUR=
E_FAN_CURVE_TEMP,
+                                                         &min_value, &max_=
value);
+                       if (!min_value && !max_value) {
+                               feature_enabled =3D false;
+                               goto out;
+                       }
+
+                       smu_v13_0_0_get_od_setting_limits(smu, PP_OD_FEATUR=
E_FAN_CURVE_PWM,
+                                                         &min_value, &max_=
value);
+                       if (!min_value && !max_value) {
+                               feature_enabled =3D false;
+                               goto out;
+                       }
+               }
+               break;
+       default:
+               feature_enabled =3D !!(overdrive_upperlimits->FeatureCtrlMa=
sk & (1U << od_feature_bit));
+               break;
+       }
+
+out:
+       return feature_enabled;
 }

 static void smu_v13_0_0_get_od_setting_limits(struct smu_context *smu, dif=
f --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gp=
u/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index a1d50654db72..5cc15545da6e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -59,6 +59,10 @@

 #define to_amdgpu_device(x) (container_of(x, struct amdgpu_device, pm.smu_=
i2c))

+static void smu_v13_0_7_get_od_setting_limits(struct smu_context *smu,
+                                             int od_feature_bit,
+                                             int32_t *min, int32_t *max);
+
 static const struct smu_feature_bits smu_v13_0_7_dpm_features =3D {
        .bits =3D {
                SMU_FEATURE_BIT_INIT(FEATURE_DPM_GFXCLK_BIT),
@@ -1054,8 +1058,35 @@ static bool smu_v13_0_7_is_od_feature_supported(stru=
ct smu_context *smu,
        PPTable_t *pptable =3D smu->smu_table.driver_pptable;
        const OverDriveLimits_t * const overdrive_upperlimits =3D
                                &pptable->SkuTable.OverDriveLimitsBasicMax;
+       int32_t min_value, max_value;
+       bool feature_enabled;

-       return overdrive_upperlimits->FeatureCtrlMask & (1U << od_feature_b=
it);
+       switch (od_feature_bit) {
+       case PP_OD_FEATURE_FAN_CURVE_BIT:
+               feature_enabled =3D !!(overdrive_upperlimits->FeatureCtrlMa=
sk & (1U << od_feature_bit));
+               if (feature_enabled) {
+                       smu_v13_0_7_get_od_setting_limits(smu, PP_OD_FEATUR=
E_FAN_CURVE_TEMP,
+                                                         &min_value, &max_=
value);
+                       if (!min_value && !max_value) {
+                               feature_enabled =3D false;
+                               goto out;
+                       }
+
+                       smu_v13_0_7_get_od_setting_limits(smu, PP_OD_FEATUR=
E_FAN_CURVE_PWM,
+                                                         &min_value, &max_=
value);
+                       if (!min_value && !max_value) {
+                               feature_enabled =3D false;
+                               goto out;
+                       }
+               }
+               break;
+       default:
+               feature_enabled =3D !!(overdrive_upperlimits->FeatureCtrlMa=
sk & (1U << od_feature_bit));
+               break;
+       }
+
+out:
+       return feature_enabled;
 }

 static void smu_v13_0_7_get_od_setting_limits(struct smu_context *smu,
--
2.47.3

