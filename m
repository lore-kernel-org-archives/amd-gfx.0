Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC615CD4F3C
	for <amd-gfx@archiver.kernel.org>; Wed, 20 May 2026 14:15:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A06D10E12E;
	Wed, 20 May 2026 14:15:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RLXLhFeP";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012006.outbound.protection.outlook.com
 [40.93.195.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6005810E12E
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 May 2026 14:15:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hIyNydFsW8w4fBxa1Nxug9MEhWldkEvJ51Iwo/Zki07zsw4juNJuUuZnWLsISoXcOxxY2pBrsIGUT9fBXsX9SMXg21B6fwbz9JrDp18+lpXqzEOVbtmN5EvW5NxeterEY6xfKd1km7DwPN5q6ZvBJEtAAhIvw0kQfIITSPHXzwoZxHUmnyGFAxts95yapRI0pfxLMlxE4jiMEf7PZGkZFU/A6LQRTrHyHWfaQJiuzMaCvc1iPfYRO/7G0CVpE2oZ9xX8eYtejoQHW9uCbF4EMyaa1cG6Xjk1esN9787TO0t5R6avXoi5yFzenUI5fTPVSJ7152ekknVgbRs/Ore9+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AqAcdbWJpUeBsztl1Thfm/6++80+KM7FP+0ph7irTNc=;
 b=cwUtiWYmmd/qfqvpvIZeK0MU4+01MHu0oYDpxqefsvGkcbl5nwq8ofvxhjfRsbtdvLMdyt2/B1Ajv2do6EsMzVtaG/dEbGLlwBMHdxvEKDJJd/5KaflArukeYrzlBMWbHEIeKSHG2EgOndrmTI4l1SQxDfQ549YUp44yAhfxiHebIx/nKTC7GuwjCUVLkksz7E452nX4GWcUZ3U4PVktpwHvF2sl1v5OfnFToKDie3FndY3ID6GYglZvgOyTlLFH93Bf57zzkPJAbeZTMUge45vY8nqh85KNUKj6djBh0D0UVw89PhfdZrJAiaNZnFBw9CTbm9qk7C0km2ppLpIvKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AqAcdbWJpUeBsztl1Thfm/6++80+KM7FP+0ph7irTNc=;
 b=RLXLhFePoS3nM4dUtOVzCylhdjr6H1OkyUALrtEnnYjZCFazIFVsy2+E/C0UVxp/+cy2soHmA3O/n5UsP24K5hxYiJ8C0iUE4otKwuqkdcZd6enSbbvQSeLBcEHXseWUi4qdt3DZsoPtc2d7ZQwunC7O3Pq9OZ+IgsMW7zTkgo8=
Received: from LVUPR12MB999159.namprd12.prod.outlook.com
 (2603:10b6:408:3a4::15) by DM6PR12MB4316.namprd12.prod.outlook.com
 (2603:10b6:5:21a::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.16; Wed, 20 May
 2026 14:14:59 +0000
Received: from LVUPR12MB999159.namprd12.prod.outlook.com
 ([fe80::a94c:715f:d15:e7bc]) by LVUPR12MB999159.namprd12.prod.outlook.com
 ([fe80::a94c:715f:d15:e7bc%6]) with mapi id 15.20.9891.008; Wed, 20 May 2026
 14:14:59 +0000
From: "Liu, Leo" <Leo.Liu@amd.com>
To: "Zhang, Boyuan" <Boyuan.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu/vcn4: Fix TOCTOU and overflow in ib parsing
Thread-Topic: [PATCH] drm/amdgpu/vcn4: Fix TOCTOU and overflow in ib parsing
Thread-Index: AQHc57P9I6xOPScZN0Kfbrs0F2RkgrYW9UmQ
Date: Wed, 20 May 2026 14:14:59 +0000
Message-ID: <LVUPR12MB999159FBC9F2725DC4FA03AFACE5012@LVUPR12MB999159.namprd12.prod.outlook.com>
References: <20260519172135.635237-1-boyuan.zhang@amd.com>
In-Reply-To: <20260519172135.635237-1-boyuan.zhang@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-05-20T14:10:00.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LVUPR12MB999159:EE_|DM6PR12MB4316:EE_
x-ms-office365-filtering-correlation-id: 1a81cbf1-b90a-4506-0748-08deb67a2d0e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|42112799006|1800799024|376014|366016|22082099003|56012099003|18002099003|11063799006|38070700021;
x-microsoft-antispam-message-info: g4y2FRBOQE55OAfrHplSNw6Q/oQM/BFPrg4nuk28XODmG8aD8NfJwJOvyqwQLky02a+A/MnvjgD3bvDuY8blpMfQiIsjulfeOGRTfnH/LMNBE6dUCVUn5EMhZTFASQ9ZzfhxFquo3hNWXNVsM0C4Ht41takIacsWDJ0MJ2rUr+DzWexcjG7yXyJG2/chkc2o2ec3JPepSDVRllrOHT36jS40OEymKh/QiEVQ6hF6vZhtKp6d8VR/zmBiOeQ/x3xC6vLH9q8ZIFi3YOh3ro3ti0aEe9KRh6QTTAdYKsSbk0Bv36tU1P7a9j8rUunZEGq8nX4DSTQJ9WscbyllJNfYd7EyK5oKFZ2ZTsRO2dvju8aUeNzZ5OayquQHKq/BhHNHSp1stXZ9rKoOJeqWSL/qq6jDpHgYQrzD6A389G77ztvJSifARhjvvOkPfjkeLq/RhvCJiwCYM+YurhEpW7FIUicjN3WS37ZJ5DhwADAeE5HOZrofBLvxeKSJEmG7YrZ9ZvIMhKx+nR6nHWfzRKv2C4RbdrEF0xhdNrqzdta+y15HKdXneiJ59mZLsTSUAt2NKLM40or4mRPl7pRlqBDiJBVZSlOPfV7jKmVruuY2AfShA8zN2pzuXK/grAjUo0Crxbg2IArybxPIOeDPxxAcRqdkoCaYtu7V/gAY+9SrWklPS69RsFCn+ibwyKASmHFfncJye0Czw6S0d6vQgYTXo7HkgzNVjjsYwwXr3Cl5Nx7LxrCeuburqelk3/CBsuzY
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LVUPR12MB999159.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(42112799006)(1800799024)(376014)(366016)(22082099003)(56012099003)(18002099003)(11063799006)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?JFn8Oao89kjgncdU4mdrh/duZ4FfBNo5nljJhfL4BH3hrPyv8e9bGUTdaGUl?=
 =?us-ascii?Q?+N9dUob0OZhJFNZQ6UUmT9i/jZmUvUs48uSiMPskmnQ48/8omLVe5XPuGwDg?=
 =?us-ascii?Q?rbq/o5eHGkvSCVxwfF3c6zWvNXUayH2X+cGSUXyQNbhG0Ej5eps0fsxdEBtR?=
 =?us-ascii?Q?+Rq4nmjTL8NM1dBcURajMw1+hOOR/LPiU7pvayWZfhU0hBU8oEHcXSwTDVLy?=
 =?us-ascii?Q?R3TcwnD70NgDbf6m9A6XJWy4cx0oC521cGSDOz7Ra24A33Y+cBNSdwLz/dCy?=
 =?us-ascii?Q?fV+DOkvOtexrOeBgW73agSp//jUmfm/5mP84Jx/38XDEWh9laVFIyyLa9N0G?=
 =?us-ascii?Q?Sq2cLBbCFidW/ktAO8lSbkBp8pTZquOy8omvFt8c65ljJRN/wYcvZT9S7zSi?=
 =?us-ascii?Q?L/JsQmcZKG6Ragd34DSGN56wjZijAHG1kwWAhkIf3oknvlwgUu7pmqhFnmkC?=
 =?us-ascii?Q?mzmZnsuQf7FUaOeWaPM5PNENfFe8jbqA0sXMYhzXhpvEG5DltuYqs1R9uSsf?=
 =?us-ascii?Q?xTFvG+8HUtrauodcTwZm1hgiJ6y4jbZkXbHvUPDIii6lHL+j4wD8ucQ09tTE?=
 =?us-ascii?Q?AloDAgE9BOUvIpGysFa8yuQ5OW98TxGW6RQfJy7CiRw8GGY8FPkkaNflNRDE?=
 =?us-ascii?Q?dOED7orfxS/PtPydoHuaXECxh8Jhhs/5k23yqt7HEtc/QKTKqBk2B+2A5whr?=
 =?us-ascii?Q?bFCE2sNVdWRfiCYznaihFeXD8fvgStWwx0UWoOuDu1LhSCpz2nPnT8BcZMN7?=
 =?us-ascii?Q?y83w9Ot2QLVRLCMeymfiIkk2huNknPMmoPaI1fwTyxDw3yqe2seL0BqNOqv8?=
 =?us-ascii?Q?c1SjfSEPRtCg6bMt5r3osTFluvIV9cLexhwJwGxzs2slMr/ehRv6JqAEifN+?=
 =?us-ascii?Q?zgGsuqsNGiarSpOQkB+/F1m0SHFfE2U0g5SMEmqOW5vZHNgKwnKs4ulUse50?=
 =?us-ascii?Q?9Ev/z6slphddOaJPhlrgYkkZrG475PC0n2QMi4ogePQQO3vCHh2ksma9vXuY?=
 =?us-ascii?Q?uZLzrfp2rGsqsHgBieVHzM1AjghkhtN733LQKrv52siPWbP5dz++PLAPjJBA?=
 =?us-ascii?Q?KwF7stwG32gxRbTjU0g/cqngmhRxL0gpEnZZKmd/pPDHVR99EWieSXKyw3+i?=
 =?us-ascii?Q?jpueJwrRRBjjRjOb2F+qpUIM92kAKjBiIsroCp3YKoNqIQr2AAawFe6aFGQL?=
 =?us-ascii?Q?sg1LBLoSwRx1zBpdb9UWGxDyyV8x66t6JpH7ZcqcX40ccguxfySlkbFrDSkU?=
 =?us-ascii?Q?TviCCOHaq1U0RngWiKSKa+hjbe/lDgLjwYvzcGmbt+MxZujW7B5RpUpOtyTW?=
 =?us-ascii?Q?fSSm8peY3nGk5h63Xd7b9DgoSt1Gol6+ez3rN7JCekZrvJ2Em8fplglkzeUa?=
 =?us-ascii?Q?gqZCc4lNvzesM2Vapc2D5Cwsiyv5zmbu7qRerGMOA9aT+T4r+1+PE+URHBmp?=
 =?us-ascii?Q?CGCUvsRl6pYJuRuKLShEzPeXWXPM7FQ+ZhnZB/OTBN10oezvTve+o4z1GUoj?=
 =?us-ascii?Q?jZpGcDyq+wglmxFvDxMCWJ46/2VFdLvg50MbFvfO4SpBvp6wGLZxFVx6YVHS?=
 =?us-ascii?Q?e3LcZkyONj7xvZauaQZ3ljoTlSqbww5QmLBENHq2/zG2YlTG3bhMxmuyDbE2?=
 =?us-ascii?Q?lSrkJtscWCMHnf8kTvU7a2HDlc4RkB6l9oRVHwl3KLrKADqWfH8xUtmseyNK?=
 =?us-ascii?Q?atp3+S9iR9/+WjlMlAKCQ4JILMWUuZ21LXS3RkRIS1v8KQYe?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LVUPR12MB999159.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a81cbf1-b90a-4506-0748-08deb67a2d0e
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2026 14:14:59.1046 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LRSXyoujUzt5Q2FkJ0UmKbL1CzAwHc3Re+njBebHQmb2pyW58F2WJ+Q/q4fAco6f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4316
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

AMD General

Looks good to me:
Reviewed-by: Leo Liu <leo.liu@amd.com>


> -----Original Message-----
> From: Zhang, Boyuan <Boyuan.Zhang@amd.com>
> Sent: May 19, 2026 1:22 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Liu, Leo
> <Leo.Liu@amd.com>; Zhang, Boyuan <Boyuan.Zhang@amd.com>
> Subject: [PATCH] drm/amdgpu/vcn4: Fix TOCTOU and overflow in ib parsing
>
> From: Boyuan Zhang <boyuan.zhang@amd.com>
>
> Fix security vulnerabilities in VCN 4 encoder IB parameter parsing.
>
> With userptr-backed IBs, userspace can race and modify the length field
> between validation and use, causing an infinite loop (i +=3D 0) that hang=
s
> the kernel with VCN lock held, resulting in GPU-wide DoS.
>
> Additional issues: out-of-bounds access when i reaches length_dw-1 but
> code reads ib[i+1], and missing validation of the start parameter.
>
> Fix by validating start, using i+2 <=3D length_dw loop condition, reading
> length once to prevent TOCTOU, and adding comprehensive bounds
> checking.
>
> Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> index ff7269bafae8..f27f6cf5749a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> @@ -1932,9 +1932,19 @@ static int vcn_v4_0_enc_find_ib_param(struct
> amdgpu_ib *ib, uint32_t id, int sta
>       int i;
>       uint32_t len;
>
> -     for (i =3D start; (len =3D amdgpu_ib_get_value(ib, i)) >=3D 8; i +=
=3D len / 4) {
> +     if (start < 0 || start >=3D ib->length_dw)
> +             return -1;
> +
> +     for (i =3D start; i + 2 <=3D ib->length_dw; ) {
> +             len =3D amdgpu_ib_get_value(ib, i);
> +
> +             if (len < 8 || (len & 3) || i + len / 4 > ib->length_dw)
> +                     break;
> +
>               if (amdgpu_ib_get_value(ib, i + 1) =3D=3D id)
>                       return i;
> +
> +             i +=3D len / 4;
>       }
>       return -1;
>  }
> --
> 2.43.0

