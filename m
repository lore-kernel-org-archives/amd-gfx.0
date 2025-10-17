Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91BCACCD195
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Oct 2025 22:13:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 02E5A10E009;
	Fri, 17 Oct 2025 22:13:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="06vgqpXq";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013008.outbound.protection.outlook.com
 [40.93.201.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7431B10E009
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Oct 2025 22:13:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ow7/ZXtM8JUHRvJIeMKCbZ1RYEU90P5crnteMuLw/wqeqJTh19j6pO9870v3q8OzvG3wHiNMs0Ix2WOriOUQvIITZxqF+A+YGcA7Vi/pmlykupe8ipxMpLMjdFEel9Wkyn23DoJagUGNBUKe/Tbtcrz8OUNQ8gwHQTiR91VyCwm4jM6E25PPK6lDXT31JyaQs/QvfKsYRs+j16bvMBskdyb/LqxzsecY+pI2MueldGSN2LqfEbSb4hVszv4lAAgd0IfLpbGCUqlU1/KU5ox9CJhOCS1T9A+RYC85heh6im+CBsRD7lvygwQ7Z3b0bmgzgI1r0hzUlNU1kMhVVrKqvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cngwVo05EwFMio48dpQyfqE/SrUGnrFL7IcmO+zO8L8=;
 b=KgJ83UxyD5CV3R+LXoURAAVXFY/ogNf1PqywKXtBERZ2kWsRn9Wpi5UTwapL30X9CanUGaWqUviRCRGYyFS/TCHwEEnIYwRoxJc4ICIflTsP7Upvs1f1eFf0JZuEYUSoEG4DUD+M9JRVyxw2gGrrBpzrlRXG70gRPmv8Ah6WTQkk4jEJ6kqtj6Ub6VPcFnApWyL0BxfgHyVvR5J1DL94tpnvXi9QPWiGxW/mTGIv6UsL09RekUnPbBx50lo51W+sCq5PsnwURfFO5L6xTp6s8Y1vPFBSCciCcCEFYQv10KCBEYDH/UWRimchBdsug25RC1L1nLwH9SKMOWZB3nWgHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cngwVo05EwFMio48dpQyfqE/SrUGnrFL7IcmO+zO8L8=;
 b=06vgqpXqitlLc4ZXozj//CteRrZvtNIHn1d3Os1OH0V+tIXJ6Zvk7OM9tPeIkzzNCscwZ61KAWb4OQQl5zld/VzxHQPfHQre4h1rxek0sEyfQylV8MoCf0bdKlqiUXrbSTuERAkfQjGvh1GblJtVFVFZ43nxpFllDxSvxkL5n4k=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by PH8PR12MB7446.namprd12.prod.outlook.com (2603:10b6:510:216::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.13; Fri, 17 Oct
 2025 22:13:35 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::7547:2c7b:d652:8d04]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::7547:2c7b:d652:8d04%5]) with mapi id 15.20.9228.011; Fri, 17 Oct 2025
 22:13:35 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Feng, Kenneth" <Kenneth.Feng@amd.com>
Subject: RE: [PATCH] drm/amd/display: pause the workload setting in dm
Thread-Topic: [PATCH] drm/amd/display: pause the workload setting in dm
Thread-Index: AQHcP2aS/3ntqlKMMUSSjJESadezFrTGWMcAgACOMVA=
Date: Fri, 17 Oct 2025 22:13:35 +0000
Message-ID: <PH7PR12MB59979EC9DCF67E04DA0337FD82F6A@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20251017130401.3196276-1-kevinyang.wang@amd.com>
 <BL1PR12MB51442956BC5EA7E1562269A9F7F6A@BL1PR12MB5144.namprd12.prod.outlook.com>
In-Reply-To: <BL1PR12MB51442956BC5EA7E1562269A9F7F6A@BL1PR12MB5144.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-10-17T13:39:34.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|PH8PR12MB7446:EE_
x-ms-office365-filtering-correlation-id: f219ecee-1812-45e3-6856-08de0dca6a5a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?jh7i4/Qe6YySjcASKsDLs7et4gYh88eI6piDZyWttlPMNHnbpk3lyevFPgPl?=
 =?us-ascii?Q?nf+sIaubi+mToQR+QFPO+Ys/NwgWFxyyOJgfDInqpOvL1g95JvKQg7doc4wX?=
 =?us-ascii?Q?fWKYOxqHmRlpaU7/P+k/hf2SyvHHv29v9g1ju7UzYDKuvoOI/BH400EHtz8G?=
 =?us-ascii?Q?3tVmF7/zT8k5mbLIwRV/3hYkcxVU9wLsxJpM1tss5vMLdgmIEtku8OLvDAh+?=
 =?us-ascii?Q?vVxew0wpKV3kmfbeLoJu3HseFrQwrAxXQWBTVDxK7vlFC06OYj6iDba6TSc2?=
 =?us-ascii?Q?qlG+LaMZOzn50L/I4bnEv5+y2Y/7Uq8nIgSNNPP4/DXc1WXSkZ57395CgPrW?=
 =?us-ascii?Q?8hfmZMY7jScoUqnfXkdzhTTaz6MaTFEZKMreukZCbP5LR75YvHdlwSyVtdm4?=
 =?us-ascii?Q?9Fx+5gwyqkymJVSEKXKLtGFEQ0C4lkPrk+wyiAbdIyehl4FQBMF/IwYbpG0H?=
 =?us-ascii?Q?gVQUAG8U80F1D67Zi9bbXDubJUzlw+5BQ/t32TSeGmFUhjW1rcKVaQR9Xowd?=
 =?us-ascii?Q?WU7WCwFxX3jzYv8RJRxtQcy4/eOILHnRu9EgbAGATeaJ8nDqCyVrCvKTWJlN?=
 =?us-ascii?Q?1VIqtKSWxoYQnZ/gY2uVECHG7rQbGgcLhc9RJf0UOrdLc3C34m96rvA8fCtu?=
 =?us-ascii?Q?i8edXuvRxNIQ4mg7vvYJjcwxYYuqXBpSoGQq70SI8IAeivq+w/g9xlw2rUzU?=
 =?us-ascii?Q?D0CZS3kf5C4A+Jj/F7ar8VSmBq+F9xgBagLATC1YSo0NchMXwVSVs95z51RP?=
 =?us-ascii?Q?FRQZBATsGj/y9oeK66N1gYaTLi818EOzaqcvOFvTR4ugChwWucodqIz/bi+9?=
 =?us-ascii?Q?KO+zRmjhI7DT+no2Cv0isl7SuxHBdcEloKynBZz4BFXmSY7ZIpom6doZkDXR?=
 =?us-ascii?Q?gHWjCsbD0fqqm2jPnImkK1+VuLX1J7YhJzeXq9J65dF5avJtrcQIJJIKHZIY?=
 =?us-ascii?Q?mJRrcmH/yFFFo4fHGE8D0Ht8Zbtyq0vdB0z09Sm1EyBoAFhE99lg/DL1MQak?=
 =?us-ascii?Q?I/OfeVtrhtEBaFasv5n4h0FLWiatzn/XvM7MFT6gnfdXDUxoIrZGWOlWS5tZ?=
 =?us-ascii?Q?tSFm+YnCF2DGQR6Hq7XssYNOzc+jpwVJJlHgQ5ukdz4XYBntx+YfhOPWaFNa?=
 =?us-ascii?Q?iRR7ZyKqlUiYs02Z/ZYODEr8RFTYsd/4lcNom5AXPetS89j2YEp/QaSYnMfK?=
 =?us-ascii?Q?SAcljHK9h8iMvSTXHJKQLAhkMOS98Ddk6SpAm7UgrixvFTBaVC/IZCSlr9eh?=
 =?us-ascii?Q?vGIl0BhIdIsRzbw3aYqBHGM0bM/htUXRmv5TKeJ7fCmKJNyfwfH5t2bt0rvG?=
 =?us-ascii?Q?EsZ+uEW0wyfeZU9vtHJTGhVKmzKjiguhMPIxKaLerZkbsyxcJp6L8OR+VbrG?=
 =?us-ascii?Q?wK2Z4UDA58oI9MRPxCB4yaXgMgQwr+LxbKI6NBL4gd3BxPQdOiYXmYiVmLNK?=
 =?us-ascii?Q?NgaxYiccKCvkZEbf7ozlMz5LopT5F5YEsuDx7ZW3lVXh3MkXRkgoXAQoKM+u?=
 =?us-ascii?Q?a3rpQg2pEGuS+6iSpC1xV/7p2kmMXFU7jukm?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1Ti4x2TcBSCgARVrA9HRu/qBc6iM02QlP1tnB2tAZH2k2BMnc4UhZOcXHtWt?=
 =?us-ascii?Q?i6Mxfcbz9YWNvJ76VZg7xZ97yskbLNzA0sCMaCsojPHBZnPrOPydkvTSGjdq?=
 =?us-ascii?Q?gqndcOIXVNZ2UvNGo8D2L2CUzkj/BE3St6h7YzID9mvpSXZ1cfwuJ5lpTfer?=
 =?us-ascii?Q?4Kzfx3Pu07YxfDxrA4Qo5U+r68bZOCzTidvjsMYqLp4xOxZ8D491Ck2Kg5lo?=
 =?us-ascii?Q?qXuOY2WAE0E7AkyNXJzYFO7onrnxEdK7X0UMCX2QFEaCFnGVWrsK1Zuf1gbC?=
 =?us-ascii?Q?oGfZCcHq6sjVCskgOJEFTYNtS3tLoxIFbyiaQNfJQnAbpb8gb1ECPabrf1fY?=
 =?us-ascii?Q?2ilbAaBxGBGO8FyWHXtX9XB6X/y4j1pnO32Gxq8HQfS7Pv5wBgXgiLNFGB2k?=
 =?us-ascii?Q?YP65nwi4vv+0/9rwWKoZ5yhEpODWeIkhoFsXFQXwUuqDwy2AFEfYxd7y3mgX?=
 =?us-ascii?Q?7TKMVWyrfYJDB0Knbi6ZLvQfJKiQGB9P5HTFMx9cuIYeBzV33KoSkmsNzkjA?=
 =?us-ascii?Q?lmnsqOfR9e90HamhMNJmbG7zwDkei/VTsQNpsdqrH1aDUyWwt2r/Gj+tbMky?=
 =?us-ascii?Q?Ov/QwceTNeqp0B6Vx1f85r7kvwzO8hP/+bg2wRP8w8qIo0JMLJkObSGmgkks?=
 =?us-ascii?Q?2bb0hRZzbdIipdtWV/7EaOzOXmV+/WR4R65jCBEPqP57TxcqZGZZVlNWyBYx?=
 =?us-ascii?Q?SUfIK6tSn/w0NcdSb/HgfOYXhKyFdQH2JZ5Ea1QFP0irWe0MfJUx1OBAr2IC?=
 =?us-ascii?Q?/NzYZ1lmVql3cA/piuVPPS9J2+M7mnMm+e/KGkzU3RPv3UI71M3Qe6bukcPc?=
 =?us-ascii?Q?Wfqdd/i2tUXbk+fBy+k7I3wpGrTnphSQruEIyVK3Jrspwo1QntaAC6k1AZKK?=
 =?us-ascii?Q?bBc3slzXFnkyDWk8x4wL70keV7B9aCvokSZtmxO+lsRdm6TL6GtRSWUi+Isw?=
 =?us-ascii?Q?r0Vr5gvrPYtP+Adg6vwsKwkaRUvJ2hOBnjWT6ka03xfHfA8c//gqpuS2JT9f?=
 =?us-ascii?Q?NTBWeprAWjekM2Mu4E+Od7axtXZGQfl7Z8lSbUqA1yRuE2rhdgb9jp0rfxAB?=
 =?us-ascii?Q?A+8NaaDlLHd7k3ljAN+f4l5mDQXy1OR3SquyJNWk2YHZO+/fpCOTFwN8I3y1?=
 =?us-ascii?Q?l947myXlaNVJD3nNSyGQr1UpUM/3swhUQ03LZ4LSI8Ug8hKk4TUXng30CzYm?=
 =?us-ascii?Q?6smkFPvma96io0W/kDg374PS/NnQfFJQuMDALq9dIyOWR/L+89V92iKgHpSg?=
 =?us-ascii?Q?8FwqD+Ry6+lX0Qk7Hiyy4V/x6E12aI/xfyFr1N85zGLFZ7at5Dnk1wBKNGKl?=
 =?us-ascii?Q?zm2zzE1/HT6zow4+P33twkSojQ1/UzxrlFBHh0krrpUf5EQOBa732RPYrhc9?=
 =?us-ascii?Q?JMb3Q+PEc87XxjdjE0+the2X3qZxCRiUx78evSHUf0Q9MGne4tAD6ZFurcC5?=
 =?us-ascii?Q?Cl0uda1riDo2D0/8O1gPdHfzmK7/4DeynM9lz5ES93QvxY9es55HChG3Otxs?=
 =?us-ascii?Q?GcnadKmjOfZkvWYqM92H52r+SaqTrD+qQhrYJ7DaUfcilMgyb8Stls2+gVaE?=
 =?us-ascii?Q?rkrDuUhGTAnGIHlnuww=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f219ecee-1812-45e3-6856-08de0dca6a5a
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2025 22:13:35.1845 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p+y+7FQFwTIEKpm9bo0JxGmg4BZNQgNmEraJ2s15u375R0jSbioFExLmOvZuKuVN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7446
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

[Public]

-----Original Message-----
From: Deucher, Alexander <Alexander.Deucher@amd.com>
Sent: Friday, October 17, 2025 9:42 PM
To: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; amd-gfx@lists.freedesktop.o=
rg
Cc: Feng, Kenneth <Kenneth.Feng@amd.com>
Subject: RE: [PATCH] drm/amd/display: pause the workload setting in dm

[Public]

> -----Original Message-----
> From: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
> Sent: Friday, October 17, 2025 9:04 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Feng, Kenneth <Kenneth.Feng@amd.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>
> Subject: [PATCH] drm/amd/display: pause the workload setting in dm
>
> From: Kenneth Feng <kenneth.feng@amd.com>
>
> v1:
> Pause the workload setting in dm when doinn idle optimization
>
> v2:
> Rebase patch to latest kernel code base (kernel 6.16)
>
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Yang Wang <kevinyang.wang@amd.com>

Is the issue with that particular monitor resolved?  Do we know what caused=
 it?

Alex

[kevin]:
The issue has not been resolved. The DAL team believes this may be a specif=
ic issue on the 6k month and hopes to continue trying to resolve it based o=
n this patch.

Best Regards,
Kevin
> ---
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c    | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
> index 1ec9d03ad747..f08121a2b838 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
> @@ -248,6 +248,8 @@ static void
> amdgpu_dm_crtc_vblank_control_worker(struct
> work_struct *work)
>       struct vblank_control_work *vblank_work =3D
>               container_of(work, struct vblank_control_work, work);
>       struct amdgpu_display_manager *dm =3D vblank_work->dm;
> +     struct amdgpu_device *adev =3D drm_to_adev(dm->ddev);
> +     int r;
>
>       mutex_lock(&dm->dc_lock);
>
> @@ -277,7 +279,16 @@ static void
> amdgpu_dm_crtc_vblank_control_worker(struct work_struct *work)
>
>       if (dm->active_vblank_irq_count =3D=3D 0) {
>               dc_post_update_surfaces_to_stream(dm->dc);
> +
> +             r =3D amdgpu_dpm_pause_power_profile(adev, true);
> +             if (r)
> +                     dev_warn(adev->dev, "failed to set default power
> + profile
> mode\n");
> +
>               dc_allow_idle_optimizations(dm->dc, true);
> +
> +             r =3D amdgpu_dpm_pause_power_profile(adev, false);
> +             if (r)
> +                     dev_warn(adev->dev, "failed to restore the power
> + profile
> mode\n");
>       }
>
>       mutex_unlock(&dm->dc_lock);
> --
> 2.34.1


