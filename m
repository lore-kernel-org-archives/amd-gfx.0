Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88885C282EC
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Mar 2025 14:08:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 23DF910E0C0;
	Tue, 11 Mar 2025 14:08:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2MSYDnIr";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2046.outbound.protection.outlook.com [40.107.244.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 805DA10E0C0
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Mar 2025 14:08:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D1ljXvYrzHbB8DE1OtiuU71i0JPw6dJHR/BAB57uV42xOGe3+LsndkSrTPxK2N/9SdQ1mdwxmE5oXxu0ffiAS8VpmS68KAEU9AzQJcZgrjQtsJvI1seY4LoQen/t0josLwer3nObjNVKL4ag9+5iLIAQIhYczGTl2bmnGDPCv0hwfJNX3jFx1R/R3C5EvUWUHPFaTFsItSebiHJxIMZJLuNXKQPCTmxZg1owMmBoAWWTJtuchZ2Xt4VS1aaLxMkWmP0vwp8Cr6byRa/ph7AsI2MmmDJq1Taa4LeAkB5czg/SOJCZfYI386ykqKQZVzEnSVdCQrA474jXB4c/iSPuNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n2fotnbPphj/Ms2lvLIJurGd8Cr9AijV3DCL/qA8QkU=;
 b=LOEeiJtvJQX3mhJ3jEgys+ggQWdDd0rxh+amSNZeUoYWbKMCz4ZGWf8NZ619ayyKy6U0RWBuVFazfyGSgyBLOjGFUlNxj8ybfrmDSeCAY+YkHepVOGZm1RkkcxGHzFapzzCQS2lgqylxwkvI5ytCdidmtnjeTKtySQKw+f3kfuTjtIoWQwTvFEGeQquetVpXWM6DxQrnYAQsXBJBrPRrTFwoikBBrrYMqN7MUvZUzdoF6fb3tArXiga/OxX65qCqizqKkdYlAGfaxKjnfNviIgIguI0XMY3FvDlatRHARHbX6boA7eZD/LjxBe40bErMtgGLAk4wcLnZt9LsBdQjoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n2fotnbPphj/Ms2lvLIJurGd8Cr9AijV3DCL/qA8QkU=;
 b=2MSYDnIrKnj1yKzAUrZ/05LcFW5yfZg80xNA4cFI/P3mgK12xrwSrBhorIHrAW8WZQJgf1YpvRt5ThS0BbN4ICGh4JDAAOtZRVYqv/fyyG4oSJ3jeLeMTXeDljSInMirfqQRTNELYRay0UhycSWpMeB40O3im3QQiuWRdx9uZLg=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 IA0PR12MB8226.namprd12.prod.outlook.com (2603:10b6:208:403::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 14:08:42 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb%6]) with mapi id 15.20.8511.026; Tue, 11 Mar 2025
 14:08:42 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 03/11] drm/amdgpu/gfx: add generic handling for disable_kq
Thread-Topic: [PATCH 03/11] drm/amdgpu/gfx: add generic handling for disable_kq
Thread-Index: AQHbj3Pqqm76pPSqD0CQbodyyRCTJLNt/jsg
Date: Tue, 11 Mar 2025 14:08:42 +0000
Message-ID: <DS7PR12MB60052B3DBC10717066711791FBD12@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20250307151605.946109-1-alexander.deucher@amd.com>
 <20250307151605.946109-4-alexander.deucher@amd.com>
In-Reply-To: <20250307151605.946109-4-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=f23d88ac-1a9f-4e57-8d71-9946e472321f;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-03-11T14:05:08Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Tag=10, 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|IA0PR12MB8226:EE_
x-ms-office365-filtering-correlation-id: 6603d4a4-1c7a-4399-08d2-08dd60a63aaf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?pgZtSkevPnKhi1EIGGSKcZsj4RdlnVPZvFK6KfF5OFBWo6kqQqoJToxRtk7I?=
 =?us-ascii?Q?TM4FgmAliJOFFp8iIxXEDiKjfoQTQG0KwjaBZmboDUDDeIp0XQ47sDZAQbpq?=
 =?us-ascii?Q?bz9yXajUVcIG6ODGinUa6F+vE7oPHT0ePyg52hyiQeB3x60jkWly31EDJtON?=
 =?us-ascii?Q?KUFjH6Hx+dg+uoIGG0naoPfs7iu7CAYA/QZsIPWK/6pAiTvYCF00jQnNkdia?=
 =?us-ascii?Q?jDbeWzIZDdrFQmSVgVU9l17IGjzjaKJzeyD//fEpip+iMy+pHYtPnsNUuOr0?=
 =?us-ascii?Q?HvdejlXcWmlCxqoHW8mh/+YLlzjfoxsNxaL1rpwMRB2VXzHjMQ4BTP20Wcjd?=
 =?us-ascii?Q?7c9hl2/hb7QRBLJZCDOMV/3aaKMl1O8qx8Lm9rwktPWtqicrRjHHPzoUMUQe?=
 =?us-ascii?Q?l0Ql2Qrg8wZEbOgu7pdV4xP09pzSjY8/oF7kcnpn3r4LZq8j2wt6rimhsxZY?=
 =?us-ascii?Q?fVxTyE2fqUDOA814b68oaTrm3u1NFusvjW7E7JQ+IG4BCNZuta3icq31bXWN?=
 =?us-ascii?Q?P2tvKgHSJtnTI4I7fe1LLPp7lt9QEgnQuSNXSr8MDM4V8lZROy8cXGw3Kca9?=
 =?us-ascii?Q?n14N1W0heosFptfYCK49LUSbBgxMy+n3v3CK78FJSgEf+dOMU6myVxJOuZGS?=
 =?us-ascii?Q?7ktnIrL3vLKGjwbSOG82lFMMXH1MhpNUSLSTXO8XfoJsi9hYwfH49CuXijcG?=
 =?us-ascii?Q?aIkZpJyhFzbcZZ69PjYn2y1aeFKq0H7yj9J2tCe/o31M/9eG4xVfFKZstkm/?=
 =?us-ascii?Q?zL4J1KdVBV8v7t0nDz4QbF+tGlImsbRJ26Mt//MWbL8lgrjc1WW6SQ8NHlBJ?=
 =?us-ascii?Q?0qqrRtAB72jJ1rIlYPUw2kEwUt3b/1pAnx43luZVmnZAmgcL9TIR/NuzimLz?=
 =?us-ascii?Q?m4eMAu6sqvM3aJCuIVNKkZdGWQrUrnXIIwhItgiPGZlfUwlyoOJuNCiNvdbX?=
 =?us-ascii?Q?YHrmpBseu3RRB6s2k7/FfN0LjmTgFP4MhjoZ9RvqpNRpddwlPT0cwZ0KiE6e?=
 =?us-ascii?Q?+yVKvp7jW1Y1jKq1Lq5DoZc+S1bklKwX1IsI1zA7o323VBI6S6oGjci7V7s7?=
 =?us-ascii?Q?xb+0H2LlNHzjCm1SOkjoO1glu67mDvl018tks6O1gASDp2MJdmjksCuaKyB5?=
 =?us-ascii?Q?QCKRuva3Gbq0L0wybYS4C6CbxfP+c+wyM+fTswqF9V3A8FYFHopY0xDB+IN5?=
 =?us-ascii?Q?ob9KCu+S3HLua9JeFwi5GG1JBpBetrpcYfRdJtCgSxbIhJGPxOVjbzxLJX0G?=
 =?us-ascii?Q?EKyxiYzJMLVSAZTbErgWRMaJChgWS3oNvltL/r4y3PS5NmCqam6mxA2M6Swt?=
 =?us-ascii?Q?uPIAOJ77JTEkMpazJV5XryF90MlXJsCYWZ7dJPK6SzunxsQj51D7QiGlm7Bz?=
 =?us-ascii?Q?3ZnO1r3nd2EwidIXbR46oy9JYuiM4AZCo6GPbBDWthQ9FgyrQ74g07V/zvtm?=
 =?us-ascii?Q?sGyEiJxsD7pi0tAQhSKk2Gzwv2b7uBrt?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?P3G6X82WP57W/0MUH1w1tyInB/xuQ8mmxi/g2wXXtVgP+p0HUr0JlBLZqxG6?=
 =?us-ascii?Q?0J/3ASQAtipty6vDJ3U7B7+lY+h2dv+be14V+V0QaEOZBfpG9SOYUcefIYNz?=
 =?us-ascii?Q?zTHv2gMhZv0601+lmDJLCkliOvEMVOCDtUFe0zXXEF0T0le6NMk9D0lJJk6s?=
 =?us-ascii?Q?RptOFINfpjE/++1p/koEDBGUN/PD9yH2CELygytsAzmul1Esh7hu+4hZgOSU?=
 =?us-ascii?Q?Zade+af5eO+ptJff6jJG3dHe2iawfBerS80xQcTPq01bSdkkYQeSIgDXrnX1?=
 =?us-ascii?Q?Ci8L2kjnIMCZhuhLyAE3HS3cmE43BQ/hRr0Jh28PNqR5zUiy3DUjwjoYwdOa?=
 =?us-ascii?Q?6M3WCGECHElBz/0cZKCZAcR9Zn6nfVVtPJ6TM7DF4GsZZhXkP47RD5vGAupQ?=
 =?us-ascii?Q?Lczr5PebzM3AQ44kND1s/5FXwTezRX4tE9N8ZpviqfV4mMxfdYiaZoaaLPCo?=
 =?us-ascii?Q?fp5D9t1Uqy4EPcngZsM1DG2fDvC9GiuHvn/AJ85x1LM18Lo7IGP56cBzCrwk?=
 =?us-ascii?Q?F6BDcaHljuFQzkif5yFcGycVGOnvAh+3zvZCGl1fYxRt02/AnxccD9zjxx+Z?=
 =?us-ascii?Q?iv6xC1d6vsiu7ypsdvXqURYsq1v8y11evXgZY/afBTY8SX5KLjQv5w7dEZ6+?=
 =?us-ascii?Q?C5Td8MchuEEIMEn7vKOidgsIyxHCFPficQDBDmUGTgJs3YgZiSghCbq6N0au?=
 =?us-ascii?Q?SPyrZTHIfWOTUSfqPXqAm5TkNHIa4nWcSbn9wzeC3SGe11agiPnVYF1lAVPH?=
 =?us-ascii?Q?eOh5qI5daLuEF2Bnqd9MDAtqiRZZdF2gip8j6qjxgjG7rLJns9OMb3S3ZkzZ?=
 =?us-ascii?Q?pCc6ZFy2hhkF5kqynLblxn3bBHTbiLCV54h4FNXwp+XpZGxmBBLtdsai4xjM?=
 =?us-ascii?Q?1kWVODPqTJFnJqurucG+TZJDUAbOL3esz8vCWwGt3cT4cdB06cLg69dYvbUP?=
 =?us-ascii?Q?Jf9zH89J7nWN/Dc2yKPrQjp/Or1M5dm3PXFPQUL//32aEW8epbMvOnfMHuy4?=
 =?us-ascii?Q?nPNWGrLf3vJCkYPr7OXtz6t/orFL9giKInpo3HU9uDzoIq5YxeoKQUnHa2qX?=
 =?us-ascii?Q?tXpxNuTTrMTgSbxgFxl7bK010EgcpAgHA3pMLoI/1lwGyTdrmBnJHmM0WOim?=
 =?us-ascii?Q?SzQ4RQQ7wNO+tk6I97KHZ1zDSqHFtzmYtEPoYuwGVWLUSkMTZN2dwfLnLaJg?=
 =?us-ascii?Q?vwyt3UMhq6pgZpT0Xvt11G4DyxxhtzyYypX2ruCTPQh9+TsiGtXzIp7PgMw+?=
 =?us-ascii?Q?7yrimxHAHn7qgasAhN9EmYzlSM/dDxJbgXxDlgXpeLQ2sN1/EHQJ7kRkayYe?=
 =?us-ascii?Q?RhBA3CgJ4SPKG1ZnFxYHuPSjcNtWZzdYTDWCc3RYPwE9aZ45oCFLzBmrQ15p?=
 =?us-ascii?Q?vZXGrZih1+Dr7+cjBrUu+LboyfCXjYZQ1pI79MeQI8Bo01jNUDojrzHCEY3C?=
 =?us-ascii?Q?atjvS+UKZr8LyoxaPw4wKBuD48J38/nJ3qrRHeOoSRiG1Qc7i5gTD7ABxGtt?=
 =?us-ascii?Q?QXJOpAuKlcnUYJyWwPqjV/yafvH0tpcntNrxVIi+wpZr659g7FxvqmcxmF58?=
 =?us-ascii?Q?5UqcJtJ6rO0T1HyZyxk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6603d4a4-1c7a-4399-08d2-08dd60a63aaf
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2025 14:08:42.1333 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2LESyDsUFtMjhuZxyZc1/xvmr7QfU3tK9hAV8Ws+2LSZEabSqaIRaK4gaHjmLGCe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8226
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

> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex
> Deucher
> Sent: Friday, March 7, 2025 11:16 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: [PATCH 03/11] drm/amdgpu/gfx: add generic handling for disable_k=
q
>
> Add proper checks for disable_kq functionality in gfx helper functions.  =
Add special
> logic for families that require the clear state setup.
>
> v2: use ring count as per Felix suggestion
> v3: fix num_gfx_rings handling in amdgpu_gfx_graphics_queue_acquire()
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 8 ++++++--
> drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h | 2 ++
>  2 files changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> index a194bf3347cbc..2c78185a33218 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -258,8 +258,9 @@ void amdgpu_gfx_graphics_queue_acquire(struct
> amdgpu_device *adev)
>       }
>
>       /* update the number of active graphics rings */
> -     adev->gfx.num_gfx_rings =3D
> -             bitmap_weight(adev->gfx.me.queue_bitmap,
> AMDGPU_MAX_GFX_QUEUES);
> +     if (adev->gfx.num_gfx_rings)
> +             adev->gfx.num_gfx_rings =3D
> +                     bitmap_weight(adev->gfx.me.queue_bitmap,
> AMDGPU_MAX_GFX_QUEUES);
>  }
>
>  static int amdgpu_gfx_kiq_acquire(struct amdgpu_device *adev, @@ -1544,6
> +1545,9 @@ static ssize_t amdgpu_gfx_set_run_cleaner_shader(struct device
> *dev,
>       if (adev->in_suspend && !adev->in_runpm)
>               return -EPERM;
>
> +     if (adev->gfx.disable_kq)
> +             return -ENOTSUPP;
> +
Maybe here need to disable the flag enable_cleaner_shader as well?

Thanks,
Prike
>       ret =3D kstrtol(buf, 0, &value);
>
>       if (ret)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> index ddf4533614bac..8fa68a4ac34f1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> @@ -483,6 +483,8 @@ struct amdgpu_gfx {
>
>       atomic_t                        total_submission_cnt;
>       struct delayed_work             idle_work;
> +
> +     bool                            disable_kq;
>  };
>
>  struct amdgpu_gfx_ras_reg_entry {
> --
> 2.48.1

