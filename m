Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C160CCA476
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Oct 2025 12:52:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2652310E454;
	Mon, 13 Oct 2025 12:52:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hImXYI8N";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012040.outbound.protection.outlook.com
 [40.107.200.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7BE4110E458
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Oct 2025 12:52:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xYGxXCu5M6/ZxRjE7r2j/TlL7BbjBPdpgT3tuR3ixd8chaS4EP14aA7mctMCJ6yBxxNutqrYaHbIc/wTktqFcY6pDINT1SzfoOE90OeE96Ix4Gcv3o6zVykE1HdxUMje2Bf/qc9NIRISSriVgzgchGyzjoUsiCo9uJoivsmiMjo7sQnNkOQu65Vr+55xw+IgraVbqHXuvMlb9iRLwwsQ4HEFaPEgV2CNGee/pHR0wR/zS9cl9U6WgTATouF38IvW/4R06uy/4FR6XAncwu3dgpe99RRHGRaZpuW4OX3cpU0t2Vzaq1w2+kfHDQFwDAOCW3YmM5AXlGgk5rPXkxy0zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=afwAA+1gGVj98iOsHrR+oHKpslIHa4rdpvhh62gkMqU=;
 b=OlSI7EL3/UwxWKPGYmhELKYoz+69mqfh2+xfQhZgMeoHyK8YxvkrM5R1SDrMBBI2l4uCjQwvj75m7TRudtvqkoDC0yw7X8Wjf1KCsI2T+Eys8BPmYSG+/N7/qoCCqza/yVirUpZlCAm9DjZW4YhGCP8WvjBsTQfFp3ghrigaPyeSRb8l/LXm3Hyc/tWnfhv80gupuqyVRAaP7QO8Ych/jnbQy56KF/4dWgGOtdK9/on++WnEQvqVdpkyZxB9Ok7uv/+iJ5jdex2qmes8E3LVLkLacmy/VnZHkwsChfUcMVeqXUgzaYHxD4ahaOoDyCgZnwA1f1VvPVox/4lSulx66g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=afwAA+1gGVj98iOsHrR+oHKpslIHa4rdpvhh62gkMqU=;
 b=hImXYI8NKNgq+jFlXe0lEe8zapqD/rGwrYwcRbIdkE9ZQphS+Fc/m/xy34BTq5TeijzrfsLUNF5gvREocn80ibSiLhQ+F+bJK/HJIGkZBEakFR4pJrq3+B0Yr8ZjEhp/KBGNlTZtwMGJ3TXczQGgGYxROG67qL+v9mG+lh5gAkc=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 MW4PR12MB7213.namprd12.prod.outlook.com (2603:10b6:303:22a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Mon, 13 Oct
 2025 12:52:36 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb%4]) with mapi id 15.20.9203.009; Mon, 13 Oct 2025
 12:52:36 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 6/7] drm/amdgpu: Update AMDGPU_INFO_UQ_FW_AREAS query for
 sdma
Thread-Topic: [PATCH 6/7] drm/amdgpu: Update AMDGPU_INFO_UQ_FW_AREAS query for
 sdma
Thread-Index: AQHcOisZSviyywtdJkSVNmjTEVdwPbTADBfA
Date: Mon, 13 Oct 2025 12:52:36 +0000
Message-ID: <DS7PR12MB6005684C391AA5D752155D02FBEAA@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20251010211510.1528572-1-alexander.deucher@amd.com>
 <20251010211510.1528572-6-alexander.deucher@amd.com>
In-Reply-To: <20251010211510.1528572-6-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-10-13T12:52:30.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|MW4PR12MB7213:EE_
x-ms-office365-filtering-correlation-id: 092c4ee0-eea6-4344-42ee-08de0a576255
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?wup61eFgnRwczokkYZkp297Uc5tZRD2eQe3Ucq3ppEVvgM9Vlv+oH7TeuOts?=
 =?us-ascii?Q?zU+3hyZz8WSjvL8tZn8KpRKFPaVJAjAW6xFCh6joHrv8U2FfgHrAJnkBqHJq?=
 =?us-ascii?Q?OK6BISG41h6EVsBdb8JENGXkEKNneM+kauUPxD0I4tXUyhuGmNQOVXgKcIi/?=
 =?us-ascii?Q?6cjqfr4oycZ4sTP7WGyJ8s03nNv6BOFmvmdUp59dF3ZHMCNLMTpIfIqF8+Pj?=
 =?us-ascii?Q?f9TWqh496ebfaT58+9eD+MAdRlLtYkeb5RpC7ZZYuePi3wFKiVYtkZfeDwMV?=
 =?us-ascii?Q?Nf/supP8bWhLzrndngPPmNFBP+xfrOpi4IoZjOs3tXmNQYHLCeM2GJvH1aAW?=
 =?us-ascii?Q?AfjPkNYa5f6PCuN4BBq8824Hm2T5+x2a8hryb08e1NJtJWVPgKMq4K4uqW2a?=
 =?us-ascii?Q?t9uocTPaOAXA3afw2OK5FPWYqqPbURfEr+FzQjJBLaiitVSB4ebNdLPkYOnJ?=
 =?us-ascii?Q?hviYbUGL35v+Om2uss2m0Ky1YSbtjJNtDtBdL+9vRQ54eIy6AJCNtzR7ZBDN?=
 =?us-ascii?Q?2sGe2dCtLIYd9CDKuKLxlOlpBuBndbGbYK3xy4S64B5yLoaNCH3n/8e3m+Xa?=
 =?us-ascii?Q?UDz2siFP0pNKlAAy5gvlZ61XbTvXVnFf2lQv+4P8Q99+3IZokakCdsnTD2da?=
 =?us-ascii?Q?at0dM6xtNHnPYxs8Gd1lxyTGBQhYqPcp9EG+QaCKiiOKZVzdsfwxTzgaqrcm?=
 =?us-ascii?Q?mCTmxqXnODFhMbvK+qVBgXk5dxYi1JWIVSnZJOjuGXEbHQQtr8uyMZrLTw+D?=
 =?us-ascii?Q?1I0U3Cy6XulKOzlKBisga047j0atb8/Z4ZbhTJa/E4ch3dX0NzIaKIdggZSm?=
 =?us-ascii?Q?JHypJi9j5xgh7shjZLckjWglBVOecmLIpMmfRHHwL5TDYC4+eOf1m1SyUpv9?=
 =?us-ascii?Q?RWItfBs+4JBhdPjGK9hgiceac91OqgcV2o/6lWw1Mip4u5STevT4NzXlfLAq?=
 =?us-ascii?Q?r3yel4mXZ7e5wMsHmtrd0LrPfMxLWwH1QFLUAOPNm9sQ7L4bWouSntXpzWgW?=
 =?us-ascii?Q?YYHL0DwvTcWrbK+coF2WG6KLaKZ1ii9JPJyZGMitpZiUJWB5F1hOPwuGJ0oQ?=
 =?us-ascii?Q?wbJ1BBKQFwm8VEhSR6y7vzGvTzZrJH5P01ZHrfr+FrFOdZWI6ohvttTo49B3?=
 =?us-ascii?Q?hPj5yk7In2E5mvD/96YlSKPIQ+sy+KgNnKmHxfJifi4qoJjkwlDeeUonpL4J?=
 =?us-ascii?Q?OSmzVQSQuL0UUldPEaPjbpgdd2VJKTfMNEJnDQRo1Z8jCMZ10GQ9Qw6sLD/R?=
 =?us-ascii?Q?k8SqJkc7Tr36fSs/w7FOpoUUf0TI45s3RB1NyzPQs7w7ZLO7GfaSmxIwp1vl?=
 =?us-ascii?Q?KAlbo0TiG+qvFVtWsHXr541ky8o6ZOd2GWsPcZ1G/eqjb+hWjaxHjjeaWnnA?=
 =?us-ascii?Q?a5btv1ueFHLyHPfMjVjVjuvltXP0Hw2Ocnw1poy9EUDSvNhbrEhNQa02sUf5?=
 =?us-ascii?Q?rKxaBAFaLABIQ88F394Fm4BrT8iwP9UQWX2dCVehgroxFNl13H2XjU52H0AB?=
 =?us-ascii?Q?w+RJvr+YoFNx4lwQI3Urie/RuCXvXKUCieP2?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kohLv9Ww2HjhD5qh85MlwMXRQ+MJt6HzIXZbe7v5po1lLj6qIJk39Sp+00d6?=
 =?us-ascii?Q?1aSSWY00eKqvV+OioqbfUYBAHT9ICBqa5/YwT7rhwDSNADQ1izsEuz+HVrts?=
 =?us-ascii?Q?Y27MVLnkZwodUPpWNM2KQzV6XCst/MmzMMj9ARTyuFCc5C0mAa2lXx6jPNdI?=
 =?us-ascii?Q?VtvDXxsOcvcIGWmSBcl1er2OtF4p5NWWBmadBXplGANB15076Otrs26mxbp/?=
 =?us-ascii?Q?NolfCxpBfF9uEZ9YTuJS9SDK32N0GsKrMqbkA6L8yaYAfel80maTr4SMb/jQ?=
 =?us-ascii?Q?9vd2verL35cBpitA532yIr5F5Pk4iCk0CSOd8LsqfT7C3y3BJQglIh7r7041?=
 =?us-ascii?Q?I9XtXY3Yv/vT1F4qxivbKK14aqQJU97XBXN5y4fn8Y1DL9wdo1C/qgl6h1Mo?=
 =?us-ascii?Q?ri++hN8pkOmvOQYvcCjj3lhiyToF0SIMoEotw9/8lRkH5k310Ywm6rsLNJKc?=
 =?us-ascii?Q?qGo7usbDJCXWYWrMgsbD5cT2Qu7i8Nc8rCpIj5jn6nqd5pEfsHHRSJ0kWVdL?=
 =?us-ascii?Q?y6JaHNVsK/EwLpIvA2T4gD3JWYaL89q2yYbLeUutr+QqIC/SKQl5+fgZUyLT?=
 =?us-ascii?Q?OvSa0/DRVJ7nlRlMI9yySNBUQjlTboz7b7AYbUJEddVSRWu5YQJK4gMW3aAv?=
 =?us-ascii?Q?7CrytqySb3hxKz+DannOFL61AGjorTpR1CObR/esC6UiKJ2AkMdtk0hjxjyc?=
 =?us-ascii?Q?mC+SL3eNPUwR6ipzxhygXjel0wQy7loXMNNGQK5kGrcuPiqHf4C6JpDSnhAG?=
 =?us-ascii?Q?9KdqTcFuYxVuuEjp4+9BFP8FkhpLbFlIQ86M9MKcESptjVDZCdU88/1tbkiw?=
 =?us-ascii?Q?JxNjj6fZ0L+5odv8RrXq4TA26rytTvASFJi03Z7029TUM/L55bF+72l423Eo?=
 =?us-ascii?Q?1vmzRlJ+C6SWMhhT/M0q8h5KdQbfgudmE23H4FDs/bwKHTsFyMwcz/XvK6B1?=
 =?us-ascii?Q?0xXXA2T25UT4gB+wB6gHY0AEYWpOQ7GzHH6ErErxZib8oOTqUtXARR7He/fN?=
 =?us-ascii?Q?T39dCh5RsDWaabLunKlqct0pbGrrh0lfaDDsIuh8jtiuLd8h3gYV8PY+YUAQ?=
 =?us-ascii?Q?MOo5CAF8QGB9qLNC8ZNW9Q0wxPjvIVqCrEtNCHsdnWCci+IMmXLf8hhN8Etr?=
 =?us-ascii?Q?IY5vWvsWJ6QWQoXxzuzTTtgAWAo9XCnbyQYwnz67sIbzwgHoq4Zj9UtsQJHu?=
 =?us-ascii?Q?O7I1Re2C8n5dRgs1h3ILaxyS1uoZR0T7wEkcz61CTxkYFB4Nl4DcNgoPObWg?=
 =?us-ascii?Q?X0qw2blkJSmsve2QZDbaA+F0bh6Dd1djiBg+tVedptAod7CUom6yWL/9nxhv?=
 =?us-ascii?Q?B7tiQRlDGsnFgYcuwbj0bE+XsSTzGH5AAGo4KKToesP8cXejfU9J6Tt4pJWe?=
 =?us-ascii?Q?GxScF3a6lj1U1lo6AcDNEO+uCK+HH7YsTHuVtjO9eg/e+AI3ovAtdto4TBNh?=
 =?us-ascii?Q?5VvFW+5lpp5CoRj2nvTySM2x7a4Mq5nDCLe2FsUMTbO3Vipj5PrqNNLT/Iyx?=
 =?us-ascii?Q?MokmhlZboHNvZEMLpMyfi8RPpfdzZaxXnlH5R0ak8AiZbc9mlbnUiaEs3AG3?=
 =?us-ascii?Q?4Pi2t1r19yJcjGFbxTs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 092c4ee0-eea6-4344-42ee-08de0a576255
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2025 12:52:36.0908 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4HhiANwfyKq/XYSndGgIjGXSqj9FwR4svmB/Yar9yoHIGbtfCTIxbB7xx56hRtPR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7213
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

Reviewed-by: Prike Liang <Prike.Liang@amd.com>

Regards,
      Prike

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex
> Deucher
> Sent: Saturday, October 11, 2025 5:15 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: [PATCH 6/7] drm/amdgpu: Update AMDGPU_INFO_UQ_FW_AREAS
> query for sdma
>
> Add a query for sdma queues.  Userspace can use this to query the size of=
 the CSA
> buffers for sdma user queues.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 26 +++++++++++++++++++++++++
>  include/uapi/drm/amdgpu_drm.h           |  8 ++++++++
>  2 files changed, 34 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index f368bda40be41..51af7b893f482 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -409,6 +409,24 @@ static int amdgpu_userq_metadata_info_compute(struct
> amdgpu_device *adev,
>       return ret;
>  }
>
> +static int amdgpu_userq_metadata_info_sdma(struct amdgpu_device *adev,
> +                                        struct drm_amdgpu_info *info,
> +                                        struct drm_amdgpu_info_uq_metada=
ta_sdma
> *meta) {
> +     int ret =3D -EOPNOTSUPP;
> +
> +     if (adev->sdma.get_csa_info) {
> +             struct amdgpu_sdma_csa_info csa =3D {};
> +
> +             adev->sdma.get_csa_info(adev, &csa);
> +             meta->csa_size =3D csa.size;
> +             meta->csa_alignment =3D csa.alignment;
> +             ret =3D 0;
> +     }
> +
> +     return ret;
> +}
> +
>  static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
>                            struct drm_amdgpu_info *info,
>                            struct drm_amdgpu_info_hw_ip *result) @@ -1385=
,6
> +1403,14 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, str=
uct
> drm_file *filp)
>                       if (ret)
>                               return ret;
>
> +                     ret =3D copy_to_user(out, &meta_info,
> +                                             min((size_t)size, sizeof(me=
ta_info))) ? -
> EFAULT : 0;
> +                     return 0;
> +             case AMDGPU_HW_IP_DMA:
> +                     ret =3D amdgpu_userq_metadata_info_sdma(adev, info,
> &meta_info.sdma);
> +                     if (ret)
> +                             return ret;
> +
>                       ret =3D copy_to_user(out, &meta_info,
>                                               min((size_t)size, sizeof(me=
ta_info))) ? -
> EFAULT : 0;
>                       return 0;
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.=
h index
> 881e8cc986e2b..021ed8a49600e 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -1645,10 +1645,18 @@ struct drm_amdgpu_info_uq_metadata_compute {
>       __u32 eop_alignment;
>  };
>
> +struct drm_amdgpu_info_uq_metadata_sdma {
> +     /* context save area size for sdma6 */
> +     __u32 csa_size;
> +     /* context save area base virtual alignment for sdma6 */
> +     __u32 csa_alignment;
> +};
> +
>  struct drm_amdgpu_info_uq_metadata {
>       union {
>               struct drm_amdgpu_info_uq_metadata_gfx gfx;
>               struct drm_amdgpu_info_uq_metadata_compute compute;
> +             struct drm_amdgpu_info_uq_metadata_sdma sdma;
>       };
>  };
>
> --
> 2.51.0

