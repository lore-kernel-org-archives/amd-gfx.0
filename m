Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C03DCCCA476
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Oct 2025 08:54:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6234710E409;
	Mon, 13 Oct 2025 08:54:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jJRliCVn";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010002.outbound.protection.outlook.com [52.101.46.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 997F910E409
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Oct 2025 08:54:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gG6Gj9VoO0x3RqrsRBfwicm4xe15v+gjBmMLrxVPdk3r7Fs4Vq6sYrZGGFafYnKLD/siadmScAo61w07G3kE3pzluCkqAQfe9crAoVod3zuUpOMQDf9fe8waadYAw5cpwLeoFf1k24Ybjec+0npRH770aNA+Z2iMomQNb7klYvCQwq4qqZW9iN1UzW7TF02fU4mhdvQ8K8EWEYYj7M2zomBgUPt0aHF7XY94yr8bPsf5RwUWvUXXAlLGVJnUpXzrGI2fFVl0U59QovwTpBfAWzcWOCKyETyHMGI5ySbS15InJ+Bz65akKZg8bSDFhW33tZuY9uA1HEMJn/mbp+coUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xo5Y6BMfxhDEPj9lVUqwuR4S6RvuvZK6b1cEX0Ptj3s=;
 b=Iid7tKYZoPw1W5DI3oxVN8Y07+ah/LwG3xOECu6LG47/lt44XjfFknLyKgfwsjRTgeiLxjgNsrbxIbBbWiypFwIKk/0uV74QwYQOyfZUQGX+4YGxEbmzJm3flrqvYr/uqUlmoO6g6QdIWyDtzHsTZgLi0BxtsNuKIitBKirvuhen0a5TinrkC5lQQ1ORTwqM5noAshQQ15BQ88qkG09a2fHEYsxM5j+L/4zo+0mFPCCrAhYs+bEJfW+0nMOQFFSVvjqfdKTFsCtH/8z1zBg2rlPQFp1CWJDH+yD7PWWpe3bsYVTDMKBQKPVxt8dBa/m0LaoetDS83bNPHulsIjMo0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xo5Y6BMfxhDEPj9lVUqwuR4S6RvuvZK6b1cEX0Ptj3s=;
 b=jJRliCVnjhD2wI/QlFBaASBEWg7YNqD1VK/aSQXkxyR4vvNzJw4srMeUpYYa+C0B3VtWFLlIQvESwmFpqG596ioQpiOa8igjOOQcLsxmT5bB7TsFE8bkzt9qJL6L6BrMuRgJcsn+Ou6J+lkF/n9EZlGnmSTv6P/ADzryneMQuqI=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 DM4PR12MB8560.namprd12.prod.outlook.com (2603:10b6:8:189::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.13; Mon, 13 Oct 2025 08:54:49 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb%4]) with mapi id 15.20.9203.009; Mon, 13 Oct 2025
 08:54:49 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 3/7] drm/amdgpu/gfx: add eop size and alignment to shadow
 info
Thread-Topic: [PATCH 3/7] drm/amdgpu/gfx: add eop size and alignment to shadow
 info
Thread-Index: AQHcOisPMXDdFlg2wU2Chk8Ev6rOWrS/yPAw
Date: Mon, 13 Oct 2025 08:54:48 +0000
Message-ID: <DS7PR12MB6005A47FAE4B2CDE179E0A20FBEAA@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20251010211510.1528572-1-alexander.deucher@amd.com>
 <20251010211510.1528572-3-alexander.deucher@amd.com>
In-Reply-To: <20251010211510.1528572-3-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-10-13T08:52:16.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|DM4PR12MB8560:EE_
x-ms-office365-filtering-correlation-id: ff20be4d-0991-4f57-5efe-08de0a362a75
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?pjLCpXXL54mr/YTIk6jbjDT9olRdP2e+Espt0G7Rq/Zz0yJ+8aXOyEZrwHNu?=
 =?us-ascii?Q?zaJhxFMM2Bmii3dW5fLEcz6d//p3Tdw3j/g4NzU3/iEvYkSPv8VJSwsObStx?=
 =?us-ascii?Q?1+c0WiJbmysXeTNAOSocQ4Tgo2VnTCQrfqHxFRg6vBIUiCJ6ELXp93CJYVeX?=
 =?us-ascii?Q?ijyh84RpSCGkmCepWc2iIag8qPi3z3UytnaHbfFZLw8nJ7lf6NGhj78IV9mK?=
 =?us-ascii?Q?pAQQBVvLu+k5N0FoUIl0dQBAF0ZhTGLtCc6W8e2CCuw6x0C8+gT8KiwLnbCn?=
 =?us-ascii?Q?7rbYktHNWS7mrYoCwsvSRsK/xaBwIsfIFRp4WlFzcE/IBz1WEP5VaK2B22S/?=
 =?us-ascii?Q?Rr9FvCvr5W7LSiLrC6TVnh8m3qqsDTcbbR0CYRnpjbw7c251CLDav7m0AtjV?=
 =?us-ascii?Q?6kqA02uhiiWdp5tsqFAArVsKpqMmHXUL7zeMAm483MoiefRY79W5iED59IbG?=
 =?us-ascii?Q?JHEgG/p4vkDhRC72/9XqT6MtDj5ksAL+EyGOIgyH4VfOZS9LqURk77u7B8kA?=
 =?us-ascii?Q?MW+2sO9nN8l7pjBAYJhs+weFNv68xWupUOybFCGXx2wPLjN1kvxL4+tyVFQf?=
 =?us-ascii?Q?qLTm7wnYPau+ZKjfW98GIBvFEIakjhElokyHoDnA3Gi/kZm2up/E5xWVpiCu?=
 =?us-ascii?Q?4gr8xfbiizRS2FSFhBh0QpP36PthIAoy0MSqG7HGBNzEMFxq+Y0GOT4tyVU9?=
 =?us-ascii?Q?QXRtI0fK7HE7o7xK+su7I4f6jUfgHjDH1he9UaBUyM0MCb3dZseslBl/hMhW?=
 =?us-ascii?Q?//2eVSGSsNGBi5se5Cccz9v68G2NsW2+dobIOj5Bax7cKL8TyQciZNR7xMBh?=
 =?us-ascii?Q?s16OaOybqNuWnRRe64xqDZ/EtqPX7P6/1QewJVaIe31lZwt/7W4Q3D3x1rpu?=
 =?us-ascii?Q?wCl0+UOlEzVTkhI3Kj5eSsowac473Y4lNL4CewLmeHqzCb0zXoNAEmty+jmt?=
 =?us-ascii?Q?6W5vxvoAlP7MmgFzm/qysgMjvxRj0KbbUhaR98NG8T/Ys64/zqf2zHN2G7DF?=
 =?us-ascii?Q?PUGDAj+iXzsHDbLMyIRx5e7S2mpD5WW4LcfsEJGLqoIX2340Mbkc+EfaGEOV?=
 =?us-ascii?Q?lTnkJYLW2Gk+7VadY3PS93cA/Zzu6aGvRIhtbnoMT5e2MTtInmjxa12ROJfh?=
 =?us-ascii?Q?UtqBNeU8M515UShidJ8H2dGd7PEOLCcxbP7HXZ9bKBTqtF/ZUY5Zj5u28JUu?=
 =?us-ascii?Q?9UL7Y4bBHhuZLPo1N0bEyX4lgu2d2iOPJsXY7AZWy9PvVvmgupHFKhevSJ49?=
 =?us-ascii?Q?Av0nzCwSNtssVsoixHflQi8Fjjzqir/9rPtn5XWLlu4Iv2YnWL77svzUeHs1?=
 =?us-ascii?Q?9UuxM02lc+RPyCbiLFJPqKawce4e/WkwJ7LL0LWSzRrVUI4jA/0oB7wZi6Sr?=
 =?us-ascii?Q?oEbi1Vd2tKcSqMhAzOGJzMx6a/pxzHpX92JLcLzww+a+3BP9EqN3pnivJeI7?=
 =?us-ascii?Q?Aod1VIIrM84NpHUfQow7LQDZeJRHz93hSZkcMqpqMP33bTGei0CH91FyZqlv?=
 =?us-ascii?Q?dMakCaP0eINucm1RpDGB80uCWx0wGIr8iRZF?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?M9o+QyZCTF+jHKhwhKHg70biRE8e5orAOs63HKFAEuAPrIk5aAY1xSkSODBP?=
 =?us-ascii?Q?Y+++t6Tj1qOkxOJD4uXvQ0gq629iQJ4x5A6OGdEezOT5jGhVourXMAUC4Qlz?=
 =?us-ascii?Q?h8yRcsMPgQLTHQCD4wpGuidsq+xqeQgMOhCBhSV3aBT2RZp2eJRsD6cPbMpm?=
 =?us-ascii?Q?gHkOo8HM6mZnz8e8sbwjbKI9Ttl+rbYSoRfrfgg63wi3kH1qWii+iMGun3MQ?=
 =?us-ascii?Q?jzN1YRZ5sLKbL+EjBRxAa+gZR4roEpmHn2e/CNGl8qrHmlZqnU0TZD3y2GBG?=
 =?us-ascii?Q?rK73LZRSGZpjxtZbwGdm3ctOn0xMJ2fYWDUsd98/PuzHKNxCWyPw4+kyKL2i?=
 =?us-ascii?Q?HY7v/KumIeK8Eax+NU8m2J78k6BBcyuFSiQmxwg0iVS/CtUCvRMxr4bCqwiQ?=
 =?us-ascii?Q?GqQfFUGKPRMEJT0imCbz9booLHAvgdMUBrYss+/tUbJnozE7+Xq7yUZ6EWU4?=
 =?us-ascii?Q?aH80tnrUwrZlPAHvXq2b9Fh63Gm6J0hZ89SyMbDIHXJnjY6gbQR84QC9xCxF?=
 =?us-ascii?Q?wEPQPIMd6FonW4ZKMOPkAAP1I2TbxiS8UmJg+x+qqq+H+9w1CkqJAut6Em1v?=
 =?us-ascii?Q?vQvglbRrxZnD618FvTgKzs/3E9Docy9UZd9kVc3BbQxFI6LZicMQS0Q6T/C5?=
 =?us-ascii?Q?vJq74+ldL/1a+1hZzMOPnS5kJpKEjtdQR8Wh4axU1R5F0t6ymB7tp+Jm6GuS?=
 =?us-ascii?Q?iSosJ0qxmNqLE77UJxEIq6sKCwLwavc6FUrSdpi7V5Eqi8FZlOGzsKZbGPp8?=
 =?us-ascii?Q?XzBqEAspE0Kp3ihC5ulwEfBPg4zYRgoUhhSttOElVeA4DxARtm+Vp8p48GIt?=
 =?us-ascii?Q?mmcje3C3+XQRkttxfQQd0p4es6oVkC9qilA/Io7n+34/ZVeY/FL+oh5efh1Q?=
 =?us-ascii?Q?PlT2XgQIZVsutDJNvfh3vqEQaqopoLepHHIAg5Fo9z1yyQ/SGLlCO7CLNXWy?=
 =?us-ascii?Q?NEZnRd9lx3yqFaeHF92sNPfsfxIofjTl288Y5mko5sr9aivR9wfBRKrgQBLY?=
 =?us-ascii?Q?iqlelcjTvgcDWifxnbbMazid9Cvl24Yy2ObjViyP2KmCrR/VTs9en/BZ3Nz1?=
 =?us-ascii?Q?1vF3AQdF/p8eR/3GdRsVep8IFsBFLqs/w9GYUEgtgG/COVDMXcvhNIFe74es?=
 =?us-ascii?Q?TCjpXUkFeyw9CsoGmGKxctLESL0cH0Q2/hJGOlGVXHiMK1uzFwn3FIIL5Yy3?=
 =?us-ascii?Q?VgT2P7NjH+e9B9u0FB9xr0HIC+flwZYtPCnCQXI8tK/iFl/ihZ4HgPMCQG+C?=
 =?us-ascii?Q?Vk717HEETTgkE+45CW+2rPbZ2B20xk57A+yqft0TZHLJXsw5Ha7ZKEH7JUtT?=
 =?us-ascii?Q?y36CRsbgZesth7zjnB6rASGWQLchfiXsfKLRidvcZHAq4clZ72bl+5IGD8mP?=
 =?us-ascii?Q?wqUlQZAdWU3B2ZjeJ1rnh4aWh1o3TxmSLbMw49wgaG7O0DU1lP1WqAA1PCxr?=
 =?us-ascii?Q?k4Caim10n2kI/Nt0Tw5PjW5syXLg+fOcNT+ve2wLA/OR+jg6Isn5sIC9rG2+?=
 =?us-ascii?Q?zZ3pjilCGcKihw7/WBYQK1A5S3dR5nQJW5xVYVJDGE9GRZOXToxEuNKn8usE?=
 =?us-ascii?Q?ZoAOgxASXSrwCibLoh0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff20be4d-0991-4f57-5efe-08de0a362a75
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2025 08:54:48.8933 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bWxUt5Lj8LW4NnwMBU+CtCUj5+WHkpqROIRIZZlck4F2WhmS5iYWeLz+Z3ciFn7T
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8560
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

We may need to update the userspace EOP buffer request; otherwise, the EOP =
buffer validation may fail.
Per this kernel change: Reviewed-by: Prike Liang <Prike.Liang@amd.com>

Regards,
      Prike

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex
> Deucher
> Sent: Saturday, October 11, 2025 5:15 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: [PATCH 3/7] drm/amdgpu/gfx: add eop size and alignment to shadow=
 info
>
> This is used by firmware for compute user queues.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h | 2 ++
> drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c  | 4 ++++
> drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c  | 4 ++++
>  3 files changed, 10 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> index fb5f7a0ee029f..7109a2ad9ec36 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> @@ -328,6 +328,8 @@ struct amdgpu_gfx_shadow_info {
>       u32 shadow_alignment;
>       u32 csa_size;
>       u32 csa_alignment;
> +     u32 eop_size;
> +     u32 eop_alignment;
>  };
>
>  struct amdgpu_gfx_funcs {
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> index 6f4c2e746165e..9c79bfa4f1ef6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -1052,10 +1052,14 @@ static void gfx_v11_0_select_me_pipe_q(struct
> amdgpu_device *adev,  static void gfx_v11_0_get_gfx_shadow_info_nocheck(s=
truct
> amdgpu_device *adev,
>                                        struct amdgpu_gfx_shadow_info
> *shadow_info)  {
> +     /* for gfx */
>       shadow_info->shadow_size =3D MQD_SHADOW_BASE_SIZE;
>       shadow_info->shadow_alignment =3D MQD_SHADOW_BASE_ALIGNMENT;
>       shadow_info->csa_size =3D MQD_FWWORKAREA_SIZE;
>       shadow_info->csa_alignment =3D MQD_FWWORKAREA_ALIGNMENT;
> +     /* for compute */
> +     shadow_info->eop_size =3D GFX11_MEC_HPD_SIZE;
> +     shadow_info->eop_alignment =3D 256;
>  }
>
>  static int gfx_v11_0_get_gfx_shadow_info(struct amdgpu_device *adev, dif=
f --git
> a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> index 453e4034389f2..fd37f2355f86e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> @@ -909,10 +909,14 @@ static void gfx_v12_0_select_me_pipe_q(struct
> amdgpu_device *adev,  static void gfx_v12_0_get_gfx_shadow_info_nocheck(s=
truct
> amdgpu_device *adev,
>                                                 struct amdgpu_gfx_shadow_=
info
> *shadow_info)  {
> +     /* for gfx */
>       shadow_info->shadow_size =3D MQD_SHADOW_BASE_SIZE;
>       shadow_info->shadow_alignment =3D MQD_SHADOW_BASE_ALIGNMENT;
>       shadow_info->csa_size =3D MQD_FWWORKAREA_SIZE;
>       shadow_info->csa_alignment =3D MQD_FWWORKAREA_ALIGNMENT;
> +     /* for compute */
> +     shadow_info->eop_size =3D GFX12_MEC_HPD_SIZE;
> +     shadow_info->eop_alignment =3D 256;
>  }
>
>  static int gfx_v12_0_get_gfx_shadow_info(struct amdgpu_device *adev,
> --
> 2.51.0

