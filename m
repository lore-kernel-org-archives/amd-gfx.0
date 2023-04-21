Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A93ADC7618E
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Apr 2023 02:05:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0FF7A10E240;
	Fri, 21 Apr 2023 02:05:45 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A37710E2DC
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Apr 2023 02:05:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N0CWJBffoE0hw70UbZX+C5IZCDWFaF3oeJqSw98LCoNz7KwrFzn7c33UfPGhEzSGMnA+31/W2JfJJPPPrjUh9FaKIffE9MS9KUFf46QHnm8O+6FCo3OFcyVhcLm1CeR0W+8B2Y5VbSaKtwkeMiinfcnNHTjiqpmZPXswhoA191Yr5wGZW7Sy+xLQL3BQ0RnWRYdL2z3zFl2ISham8Q5BtQY3Bj8tPTUJocFu6Tj0c0cSsfJbAdDDKp2bx3wMZl460rE1ikQtd5hEnCFsRIcwbhBXH7U8w0CZDDx3uigds14+J0xgwXSJKQyR1YTGVT5dYKV4K5aM4oG9lZYZ1bZBqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cfAhogho1sJ9eTrY20JgbU73KpMnJXuPaSK2MLkfyLA=;
 b=L5f5S22UCL1Jyuhh/pfVFZkoitLXSgY2gfiGhCpp4A0rtk15kO23MqqnBRlKNKUBz77EJaV3SgupUbNnR39jmQwGyasE6JbDSrzMI1dpNojwAYWiqTqeZnguHZTSChUGpfceiejPNRVsRh/PJjMsZGK44c2gHuaXF9DY9TU2C3wy2Ie50btf0KwBeVbHVHwKQUsszedFEjwsGBjZ2kTfOAIDzZDTEa17HDqwfQUerL6wY2SRN7TFWXcKH9o22cWwS8RagCl4r0tjn2Vif7DomCWuhMJ14bsDGgbtyLV0KJspJiR4HiHLDfcJniMoUfnj/FXcdrNZLCyMX3zKFiCLkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cfAhogho1sJ9eTrY20JgbU73KpMnJXuPaSK2MLkfyLA=;
 b=tHLygKYWxFx+mlLeRpZxT/SpDoYsUC3iI12u8JN7YsIDUjVZ36tHDQ0EwBweZVgfmNWrlPvuU6m/UVjaBlwMbPENg+6pcB/4Fw3gW9LbNJTeCCouB/wCfiQTgRjvxYFiQJU3i3mzXJ2NsIospd4xA16+SpU5ZGJTGbJQ6Ur4Y+Q=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by CH2PR12MB4134.namprd12.prod.outlook.com (2603:10b6:610:a7::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Fri, 21 Apr
 2023 02:05:38 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::95d1:b78d:686d:2ec6]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::95d1:b78d:686d:2ec6%6]) with mapi id 15.20.6319.022; Fri, 21 Apr 2023
 02:05:38 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH V2] drm/amdgpu/gfx11: update gpu_clock_counter logic
Thread-Topic: [PATCH V2] drm/amdgpu/gfx11: update gpu_clock_counter logic
Thread-Index: AQHZbLqlEHShS7qCSkm0cFlnfyRSr681EfmQ
Date: Fri, 21 Apr 2023 02:05:38 +0000
Message-ID: <BN9PR12MB5257EB3DA2222318BBC10B6BFC609@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20230411211422.871350-1-alexander.deucher@amd.com>
In-Reply-To: <20230411211422.871350-1-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=a5cc3faa-bc20-46af-afbe-3c3d264bb75a;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-04-21T02:05:16Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|CH2PR12MB4134:EE_
x-ms-office365-filtering-correlation-id: b24671d3-2ea5-44a2-bcc5-08db420ce700
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hpzyvTBR9EfNVkjX9SnVbIgv71/fF1bCTIwL5HKUEg/PqntkJrWnY93ovClyXaRG0BGezhxebcGs8mGpEEXDG/tQnoVbtce7Q1tGAsIfrzEU98GhR0I7vLmyaPAesFa7+nu2G7XRcCtI0nwYQvRmug9FLLq3zc1wvSBN4Nx0VdNzV2DtY6WOz5exSuGrNUpTdV4jzYxqIx91Delk1BFFZJAxkaHXyOHnBAK1IYcdVVrNK5oRKjkcjNY+lqBPuCf5+MKirJM3q0JVqpcVX4UiyHzosHUrCOYucOLTdyeRZNK3PXc9lPWiVlIIyr8E0Y+sSaqaAOKq7luNYvSoI1qqGFxva2U7eGOygAZmWRdM4YznkWPg8aoU7HzjvtDEZUIeCupH85IsNpcNBgka/L9dI1aWvUYwY8k0PURMrYL95L536cyIUTJxT20zN8jZX/aIWLsaiOX5pz6+hdqDlXhdqI9PxJYdxJrTqX7CtbAZDkmUrErBPavCaj4Js7LKzcGZ5669YptB12M5cKILMZ5Lkm6g9NkHd0Yy1RG/a7XhKkaUE6lUrt9ynGKdRWaFsqaz+mqu9CuGEvx6aNIxyA9AkqUKWiGtO98YPNABJf21+MBNBqsPwQghhHOfY2DsklL6
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(396003)(39860400002)(136003)(346002)(376002)(451199021)(8676002)(41300700001)(8936002)(55016003)(15650500001)(2906002)(38070700005)(52536014)(5660300002)(83380400001)(86362001)(122000001)(110136005)(478600001)(6506007)(26005)(53546011)(9686003)(7696005)(38100700002)(186003)(33656002)(71200400001)(316002)(4326008)(66946007)(66476007)(64756008)(66556008)(66446008)(76116006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NLH9d8rG4AhGM+gkYY0TfKQqkWTLnrJMLk0IzfOk7tkGO9r2wAiJqu5ncpi1?=
 =?us-ascii?Q?ouoFARl2pT3vpWhhsaHAljAo54t/2D3fF8gak2PXTsjWrAJXlz4Y0zQGw/FY?=
 =?us-ascii?Q?QIJE2ZZ7ElwokntdtVUBtG5buGVPc3WEy2sQezRds50JTcrSBOUCnQWEiHuY?=
 =?us-ascii?Q?60ONQub9Q+bxwjyngkG/UXXgKC0VunSg+viCfRfLu2rWWNYECwaiQjloLbyk?=
 =?us-ascii?Q?kcjy7IRgJMFpqIfecV90KWmUx4pW5VzVlPS13yv2T+iT+G0PSVXToTVuz+hA?=
 =?us-ascii?Q?/KYfLuwP5bej60Ju7ZJWcNi7iqn+ZpwrOOspdIE8EUkokqTNm3L2euPzFz/I?=
 =?us-ascii?Q?/VHBe9e66KMnZxPqK4nWBBuko8t/5CiDREiYBI5oOXlC0VrUJMKNhpUkPXRm?=
 =?us-ascii?Q?xy5714ytNWivm1vZ0ZEm6QwKD5Pmx+0ZfbceJhIYqcE8gHS7qtnnZT6p0kk+?=
 =?us-ascii?Q?iY8kaKfD9lqlOcSCroiN39BQ7eF9776OMhfHmpdLrLTGQEC36W6ubBAQSVIv?=
 =?us-ascii?Q?dI6ZYcAa2cKoOPXtU6kK1zQQUOGsdbTCOcsA9FDlj7ffn/p/sw4JCdbXtE3z?=
 =?us-ascii?Q?ubitAW2FtowaZgIa8tmkvqVR9Q/yn29r1cnb3EpLPZ1aRfgc4Tc72s1P/Iwh?=
 =?us-ascii?Q?7luMnLjrBH5BvbFPZljvbdCgQvBnyAGhihMwi3EcCWQ5C1Ab3tLrxi3hAVIV?=
 =?us-ascii?Q?PD0l6z6aevatauSz79aSWzVZeLtKnNggWA5GhL0I4M32vmVwlc786YOptCrE?=
 =?us-ascii?Q?iVtxuoVKZZdGYmJlmUrd2caBBEk1grjKceuiLVK3id3sVExdkbtgusbret+W?=
 =?us-ascii?Q?g2mEEdPrCjokHBEkynJa5QGfN275cOXlcuC68Lw+hgEKtTOWNTJr2aPwR33p?=
 =?us-ascii?Q?GNvCZWjanewJmrqZanx09YtudTXfa/zX6VhZ7j9Y5Rq2gkayks79EAL6zAh9?=
 =?us-ascii?Q?awexviCBBHtTY4Dd5oCIl93Qfs7YyEl/MZrUgpCN2TqnjkXqG5yhbNE6+gDj?=
 =?us-ascii?Q?sxFIduGNiOgeIpUik6xippW3Lhil3TuLGQNTvOKbKBdFyYy/ETjoei1OPUk5?=
 =?us-ascii?Q?NInXFbsyCbbe3CFMLdp6OeGEGrHCpZrcCh1uA66cHhVfB1bCVxOqlh/AHQ1J?=
 =?us-ascii?Q?jh1wetzjRu9KJ89y9EUbk8pahzrpdZEm9hImiXsgX/vU4iUELPwnhzhZACfI?=
 =?us-ascii?Q?JT6mjaGmymsqoCncowKPxZmMZ4c7xz0nzCVJWFuWcL2ogJYtGeDRITN1sd8o?=
 =?us-ascii?Q?RgFPvft43Q8GC5iU3E4zzQ1E4FzX25a/za8LgdgoYsBZgi2VEuYsSSFFEnMv?=
 =?us-ascii?Q?nuO86W4QLSNWamW6U2ZnQVd0VzwuMT82/mFQYc2dSPv4Q4TV4L6n+/EpSMSR?=
 =?us-ascii?Q?VOXt5kBHueF4G38/VDQedZ4hcENq56aP1tULx7mP+MSgTT6MPzwrvzQyR+xs?=
 =?us-ascii?Q?tgT5sZx8uraeCxMtX7dv5MY1cmtKBASUwQ8ocgpZ6XKaiwWPsGoASPHvywTm?=
 =?us-ascii?Q?Q6oOqWeuF/LdDLOSfUSxSEH2sBefP8ofJPwzSy6ash96gypxsQ4h2OLv/DFf?=
 =?us-ascii?Q?NMhtJfI8GYq8WQR2/GFkDXfoNlcb8iwn0lNkpaL+?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b24671d3-2ea5-44a2-bcc5-08db420ce700
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2023 02:05:38.5410 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yQJpAzeoscQSldeRO4Ohe4DPLqi86OoFpyL3iKJ2EjL9nlAVlUkB0FR0Rxj5GgCezCeLGRu6uwV0wML+qQlj9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4134
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deu=
cher
Sent: Wednesday, April 12, 2023 05:14
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH V2] drm/amdgpu/gfx11: update gpu_clock_counter logic

This code was written prior to previous updates to this logic for other chi=
ps.  The RSC registers are part of SMUIO which is an always on block so the=
re is no need to disable gfxoff.  Additionally add the carryover and preemp=
tion checks.

v2: rebase

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v11_0.c
index 107c487c0c37..00a06d353abd 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -4673,24 +4673,27 @@ static uint64_t gfx_v11_0_get_gpu_clock_counter(str=
uct amdgpu_device *adev)
        uint64_t clock;
        uint64_t clock_counter_lo, clock_counter_hi_pre, clock_counter_hi_a=
fter;

-       amdgpu_gfx_off_ctrl(adev, false);
-       mutex_lock(&adev->gfx.gpu_clock_mutex);
        if (amdgpu_sriov_vf(adev)) {
+               amdgpu_gfx_off_ctrl(adev, false);
+               mutex_lock(&adev->gfx.gpu_clock_mutex);
                clock_counter_hi_pre =3D (uint64_t)RREG32_SOC15(GC, 0, regC=
P_MES_MTIME_HI);
                clock_counter_lo =3D (uint64_t)RREG32_SOC15(GC, 0, regCP_ME=
S_MTIME_LO);
                clock_counter_hi_after =3D (uint64_t)RREG32_SOC15(GC, 0, re=
gCP_MES_MTIME_HI);
                if (clock_counter_hi_pre !=3D clock_counter_hi_after)
                        clock_counter_lo =3D (uint64_t)RREG32_SOC15(GC, 0, =
regCP_MES_MTIME_LO);
+               mutex_unlock(&adev->gfx.gpu_clock_mutex);
+               amdgpu_gfx_off_ctrl(adev, true);
        } else {
+               preempt_disable();
                clock_counter_hi_pre =3D (uint64_t)RREG32_SOC15(SMUIO, 0, r=
egGOLDEN_TSC_COUNT_UPPER);
                clock_counter_lo =3D (uint64_t)RREG32_SOC15(SMUIO, 0, regGO=
LDEN_TSC_COUNT_LOWER);
                clock_counter_hi_after =3D (uint64_t)RREG32_SOC15(SMUIO, 0,=
 regGOLDEN_TSC_COUNT_UPPER);
                if (clock_counter_hi_pre !=3D clock_counter_hi_after)
                        clock_counter_lo =3D (uint64_t)RREG32_SOC15(SMUIO, =
0, regGOLDEN_TSC_COUNT_LOWER);
+               preempt_enable();
        }
        clock =3D clock_counter_lo | (clock_counter_hi_after << 32ULL);
-       mutex_unlock(&adev->gfx.gpu_clock_mutex);
-       amdgpu_gfx_off_ctrl(adev, true);
+
        return clock;
 }

--
2.39.2

