Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95203E77188
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jan 2025 07:47:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2453710E5A7;
	Mon,  6 Jan 2025 07:47:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uQYlaxUU";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2085.outbound.protection.outlook.com [40.107.236.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B4EDE10E161
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Jan 2025 07:47:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=itgbl5XLkndLrD+/ME3xYyj7XWzO++L7Wz8MBoI+l2g057nGULIn2bPrrxptJCrBEvDWfZhT/vNXrfE+O1EZwJU+MNd9fccKjiTllLXUbxM+hh68EMsM29qb7msPFRejR9KU5Wzj0+aNVlhW8jF5iZ+8dyHyIjWmUSyQNCs7MIZYLA9d9dEEJlOGpOprGFJCHq2u7I+P25iphRXDInbMqqwlmXHju7Cl0HTEHkvZP3aXdxlDRajiWO2MjRzLXYmQ1jF+a+XRObFww1bXPYgdQ24s4hOQBCHScKs32ZwPTiosZruuWXRNpEZ5U+aAT7yNejzeAidrfS8Vpv4jWNqLog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1HjQ9RNwXLK9Dv74dOYU9mf9L3tut4ZJjdddhlgOjSg=;
 b=JjJKtuBATJ0DKkD3KHwHmYGem4ZycsAFhcpTtjzOmf7WYLGHZjlv0XkUMiSx6ayxiVbXnNDBnZPPivUYqYO9qklVu0kcFoMWghk902UwDpF/kdnF61fKAZDLTFrAwLclPnIkbfgvaSKu4ECHB6eRdRkJT2EM7syaDlIGuWA+riVIyCxfKU/1VWoJqIAL1g0aPRTgcJwz6jqUgLzhlczqxi+ch4yHwjndIKB58SruXFB+N7NJ73OP5Qv8iJS0fqDiXfGaZuSpUlzd5Zi9A3iBK+WtSAAD8QSBeqyay2Se1lRjzrbBPlJxriA9kQDspM31WvEeHgt3iArz3GsDEGcKlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1HjQ9RNwXLK9Dv74dOYU9mf9L3tut4ZJjdddhlgOjSg=;
 b=uQYlaxUU0CnaH8Vt3rjjm4/k5crdGV/spgAXI7ig/Eybu+9enckcHN3W8yE7h3eoYhhqKwC20TsW+ielbZyLSRwDZFSPOqsFgHA7zXbNyy9BYSVLTTeZ6F+Z55BJYdIMJ4ufbCOzpfBgb/GhiCdTmDL5et70V8Xe+Pjd4649/pk=
Received: from DS7PR12MB8084.namprd12.prod.outlook.com (2603:10b6:8:ef::5) by
 PH7PR12MB9222.namprd12.prod.outlook.com (2603:10b6:510:2ef::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8314.17; Mon, 6 Jan 2025 07:47:33 +0000
Received: from DS7PR12MB8084.namprd12.prod.outlook.com
 ([fe80::36b0:212a:1d6f:6559]) by DS7PR12MB8084.namprd12.prod.outlook.com
 ([fe80::36b0:212a:1d6f:6559%4]) with mapi id 15.20.8314.015; Mon, 6 Jan 2025
 07:47:32 +0000
From: "Huang, Tim" <Tim.Huang@amd.com>
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Zhu, Jiadong" <Jiadong.Zhu@amd.com>, "Zhang,
 Jesse(Jie)" <Jesse.Zhang@amd.com>
Subject: RE: [PATCH 1/2] drm/amdgpu: enable gfx12 queue reset flag
Thread-Topic: [PATCH 1/2] drm/amdgpu: enable gfx12 queue reset flag
Thread-Index: AQHbYAsBfrlaxV+GXkOOOPxo7TNB+7MJXKuA
Date: Mon, 6 Jan 2025 07:47:32 +0000
Message-ID: <DS7PR12MB8084CA45172E8D478F1AB0EDF6102@DS7PR12MB8084.namprd12.prod.outlook.com>
References: <20250106071707.2561665-1-jesse.zhang@amd.com>
In-Reply-To: <20250106071707.2561665-1-jesse.zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=c4cda359-e73d-4add-96a6-a22e5428fce0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-01-06T07:45:02Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB8084:EE_|PH7PR12MB9222:EE_
x-ms-office365-filtering-correlation-id: 305c7575-6cf9-40ab-ed58-08dd2e2660f4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?2aWkMA7NJGT4g0/waP1ZmyFhsq3aCyO9fbzzAGYOLhA5t5ckLYiPORFG8U?=
 =?iso-8859-1?Q?PV149+4EfKkl59i+z/dUHpTWaapkhmwqjRowCm60zYhY8k6XxU6L8XP8/d?=
 =?iso-8859-1?Q?/82jaFfS3NgrfhQmCBMyccNnTIVTCOt6WN3N1P3t9jZU5sblpmvnpzRi/5?=
 =?iso-8859-1?Q?hb5YIrT80MYSnB8I+QKWUTIMKWFASMUC3EQdISdSTLT6lydODx+/lGgf87?=
 =?iso-8859-1?Q?BGpQr1mHYw7VB+p4B/PW/dv76Lavfu8K6C6E6I4CQrmVhDsdd1tmJaAmyX?=
 =?iso-8859-1?Q?ZEbvwqiK06H13BoJqR5an6rYCy76+/sD3jOXFO5hXbUtvFEIvbIKCVCQCt?=
 =?iso-8859-1?Q?Ue4owENZ8rdoD9p6/FbbnXY/B+L9pkgTozq5LKhKAAo5bFYpAyRbNYoOKb?=
 =?iso-8859-1?Q?nC5giScJ3MbT4R9lo+5IhtpmoxY05PeYZ9yc7dQxtHyTKSXxWydFpui2aE?=
 =?iso-8859-1?Q?9lputbscnFFNHMvZJtUScHA4sMqnehJHQDYWuQziSO3X0oE6ct9aqzV3jK?=
 =?iso-8859-1?Q?A5tx6cUVvLk5+CFuR2WyKpUbMlTmjYp6YlcEUXZyDmF+iEelIyWwNz4sMX?=
 =?iso-8859-1?Q?aKNjnlnJvhPh+CjW7BUL+9uA7vp3qH6Djfp8ETvFrYusIIkjDj8OG/0SxF?=
 =?iso-8859-1?Q?G67OqGmBSCMRdtLDChbt8/e5oRcCt6CcrJt2j26jDE69h3tZ8QfcqklJao?=
 =?iso-8859-1?Q?ba38X/eQRiPewn9sgy5FhN7EzCURKYJz7P7A/A1dMc4ZFl1xkCFNfJVEXA?=
 =?iso-8859-1?Q?LxCbPYJMPZBshw/8/evR9oUtfHnk4krAQRcV9d5XC++aotGhEiLnKDH7Z7?=
 =?iso-8859-1?Q?z8iXDPS7UkkmepyyzTzUAlozxixEiR3vmYw1W7cQQByIG0utugHXeDsAKi?=
 =?iso-8859-1?Q?YIIXyl5yENbge/UsUIujQm8o1NNfMjGtCojCWzEn1ulhVwR9dwNrGFUkgK?=
 =?iso-8859-1?Q?l+q1K9lSIzfNYEG4Iaq071FdqzYkTT5Ke5Kxtah99SuaveyXGKhoHVRTCp?=
 =?iso-8859-1?Q?FxeJQ0E66+XFXpru5UlnJTuVjCT3sRJNseVNWDdfzLegp/PG+l4YWGv/2t?=
 =?iso-8859-1?Q?RM4clGxIuJMjhyO2hldOdJkejFMTiQlK63XS9bvk8tYfKxRITsdsfgeb5g?=
 =?iso-8859-1?Q?ZNY5qbp2ULEj71YEZDsv52Nwn4+3E74PMW9Raduz4w0Ymt+3NpuCOowvwd?=
 =?iso-8859-1?Q?SP7xXBItJrLIh/dLcGq7fODUmrGOndg69v4YMpoOrl1Qi6KPEY5CaKO1/u?=
 =?iso-8859-1?Q?ekE9cnMnf2mjVW2oTpucPQjUoeieffn7TIIbcea669pVxqWPiAE8Pb/gaS?=
 =?iso-8859-1?Q?4lJ5VzLz+j7w6Kt+6KjMxbkZLsA4wgAKJ9RVGaLyZBCKWDyKTD1PmUjwgv?=
 =?iso-8859-1?Q?lK6v12p4Be6iYHSuql7Je2w88Htm8S0WK2GOR4k6Aua3UiSjcnU5PuUZ/s?=
 =?iso-8859-1?Q?RhJ23A94v7xmxNI+A3LpLvvPIAisaI18Hb7CSyq3EELRViIyRtUzY6mf6a?=
 =?iso-8859-1?Q?uMdn6hfU+Ggp3NBFRvveGu?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB8084.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?pN8C0nPH5ta3qYur7d/oD/CbuoVZTjKoBPtmMhEdiWbk6+sUnuQRbKUv2f?=
 =?iso-8859-1?Q?LdndChr2YrnOhKuQR6Dhl2zAI3+pvUjXsLr20IOwqOs4x56VoW3xBAsSTw?=
 =?iso-8859-1?Q?V34Fmm+Me7JWPT0nX+lCCWd5fEPbbYTJpwI0CKdDO2yWNPFZpUJXe0atHP?=
 =?iso-8859-1?Q?cXHfSiTgLyRHtRDdm7p15XID+zBbWC4MJ2QW1gZlx7RwInJ2On3WzGLa3O?=
 =?iso-8859-1?Q?eV6qYgnsvf68KXEcDghgYAv1pZAqgQlIO9tmBK0GqdSQl6jbwuuFUg9oJs?=
 =?iso-8859-1?Q?Gwo4VFju1x1/GwKlzFwCmcNOm3Vj1svAXXUbFWidBgcIJeILqb9DC3N4S8?=
 =?iso-8859-1?Q?oUvRwda1s0oIt2LvncqcSxzBWsYubVk91KV0FyI32nK2+k6PVmQdwgwuhO?=
 =?iso-8859-1?Q?9Nnyfe6nOw9G3fh7Gny2g6bQUwVXybKrGxBZ4JIROFuL1/myM2r5MxEHfg?=
 =?iso-8859-1?Q?aT+B00LWn1vmvGZhFK0mB4jQlUX/d+hUUvfYjAVh15XRMRT6BbAquCgyNo?=
 =?iso-8859-1?Q?7IP7R5kPPvei9SscEASxGA3A2Y1uoQSRvD3wG2jmfpFEYRMqhhp12yApyW?=
 =?iso-8859-1?Q?MplQgNN5U3eXRUfv5X3stM2HEa6Bqjy/nLfrvnClpzf6mfxlU6JIXs2WPE?=
 =?iso-8859-1?Q?uWai2rn+iSP09mRXg1zXfkgGZg4f1XczxIotwaL81dcyBJOkNmxfrIE2qR?=
 =?iso-8859-1?Q?cVsRIGnxq8S9xrEVAylrTuT0wZzX7IwH6qvLLfHAGVSHar4LEu35Wg46Tf?=
 =?iso-8859-1?Q?hVLvszBHkBX709Xz7IoRYzVPLqew5igSnMm58A1bMkv7cPg6xqmM1tVomi?=
 =?iso-8859-1?Q?2vbP2OhJkRBHBvN8hyyI5hcinxlxsy3RT5e47jSmMW79HssgAQ4i6zRwMy?=
 =?iso-8859-1?Q?UDTXvfBmN1SykHK5hidTgOZjBSOLxq6QAxu166nSJB69LZHHU98Mp3CO6G?=
 =?iso-8859-1?Q?CfjjXlEwWLFiMTH9NHtJM+FdhBHTPqjW0ofXAV/c99uGEfd/yar7v3ZGAr?=
 =?iso-8859-1?Q?wEIov7GjMoOQYfOTYP0/oXiS6SFQxaO/hrxTIn8RlNExUbOspt18J+zG45?=
 =?iso-8859-1?Q?yEg8jjWMHXNDDMxbE5tXl9tTxkBJ86++XXJFk7JAt08NhIuEY6lkTv64bu?=
 =?iso-8859-1?Q?SlXiGU0UfO4R0sQymfDfgOS005CrdKwZKOBi+mI9X7ATxMckhMCCSD7rq2?=
 =?iso-8859-1?Q?8QbksOW/gn6/+/KXjLD6DwJ0FgAPWY8rctBkwveCL9JP/5cOFwCHtNt33t?=
 =?iso-8859-1?Q?NGYvD9fE5Fvdw+F9tHS0ngQK9tc2BjjGWbk9baSXVmeJCgcvMDds6by1/V?=
 =?iso-8859-1?Q?6y6vy6+735zB/YosxEMBc23+gUgXZFgBonhe5iRzwy7Kfss+52V5eXxhUC?=
 =?iso-8859-1?Q?kcUxzSIqrfy2r1Xzzl4Ovk8GlHvUCsGHINNXnPjWmILmYT/XZITomwptfA?=
 =?iso-8859-1?Q?bQFCRNbp2TpyPXkrKMRQ5hdD2vA7pXaEWhi8FssUpMqjMlBbVq0dHCvf3l?=
 =?iso-8859-1?Q?zn/OLd4aroQzd9htTld/333EXRZl4mB1ELNOnCLLj1UKICRuhzzcEd6TkR?=
 =?iso-8859-1?Q?hmAQqjySgHLxA9Wslxu/CryaWKvCq8c3fBYMamU3o26aet0ussCmUQmKeV?=
 =?iso-8859-1?Q?qP1iC7CCPJbjs=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8084.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 305c7575-6cf9-40ab-ed58-08dd2e2660f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2025 07:47:32.6202 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xe2dONpRj1Sxu0hcaBJhfZp+qxofHS74c7cQ7ILaymGNdenravm/CNRX0wiyZN7RcYfz0J1ttc+wBZR9Trq9Kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9222
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

Hi Jesse,

> -----Original Message-----
> From: Jesse.zhang@amd.com <jesse.zhang@amd.com>
> Sent: Monday, January 6, 2025 3:17 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Huang, Tim <Tim.Huang@amd.com>; Zhu,
> Jiadong <Jiadong.Zhu@amd.com>; Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>
> Subject: [PATCH 1/2] drm/amdgpu: enable gfx12 queue reset flag
>
> Enable the kcg and kcq queue reset flag

A typo here, it should be "kgq" ?

With this addressed, this series is
Reviewed-by: Tim Huang <tim.huang@amd.com>


Tim
>
> Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> index 3aa34c55554d..69941442f00b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> @@ -1477,11 +1477,19 @@ static int gfx_v12_0_sw_init(struct
> amdgpu_ip_block *ip_block)
>               }
>       }
>
> -     /* TODO: Add queue reset mask when FW fully supports it */
>       adev->gfx.gfx_supported_reset =3D
>               amdgpu_get_soft_full_reset_mask(&adev->gfx.gfx_ring[0]);
>       adev->gfx.compute_supported_reset =3D
>               amdgpu_get_soft_full_reset_mask(&adev->gfx.compute_ring[0])=
;
> +     switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
> +     case IP_VERSION(12, 0, 0):
> +     case IP_VERSION(12, 0, 1):
> +             if ((adev->gfx.me_fw_version >=3D 2660) &&
> +                         (adev->gfx.mec_fw_version >=3D 2920)) {
> +                             adev->gfx.compute_supported_reset |=3D
> AMDGPU_RESET_TYPE_PER_QUEUE;
> +                             adev->gfx.gfx_supported_reset |=3D
> AMDGPU_RESET_TYPE_PER_QUEUE;
> +             }
> +     }
>
>       if (!adev->enable_mes_kiq) {
>               r =3D amdgpu_gfx_kiq_init(adev, GFX12_MEC_HPD_SIZE, 0);
> --
> 2.25.1

