Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83C53D10F37
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Nov 2024 05:16:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2833810E315;
	Mon, 18 Nov 2024 05:16:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0u6ggvKp";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2057.outbound.protection.outlook.com [40.107.236.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF04810E24B
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Nov 2024 05:16:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oanDkA7X7Ebz54ERU6RJyK3+xEaQCBOTe+rfRHK6IumMIy0Un/pJk6f6k+QYKorKGy51L6EQ6Oh1qgfY6iKCqE41VknSllXiFFkCFNCJNciw8tMwX3U66yHO9rsh2qbC4T8VAltwBqCEC8BQQEiiH4xpPfmwmszeIZEOZH/tZAD2YW1P5+xV1+oKdvPb0x8eloybAy180PawIFmNGBnBDuiY6yv24evDB7fW98eUZ8O2s1xUnyFtqGSqQHv5F388DYFmkZmY7NAulM8/uBUGwssbkmSVy3JVB6GO2PonyQDXtolEn7Ko5OtlZzrhYz8ddmiv2Pcky18+6MSqY4uMtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4VrL00Z5th0QBMlW4fMTefKVZgbdFHM4p5IlvL+YjLM=;
 b=D8KIy5SIYzjz1nue4hNHe9f6D6iyyz72Bd+O+GLDeBj3GaOJhk1Hrx6uOtPD6r4+FD9R1Yfk8BddqN268cffvFBItqB0ziTz/i7k7WepbgNEtCV5UxfkNM9kxBeRipQJni0GlcH7wbuf2KosgwbGgkRzxRwY8EnYiUhm9/zdZ5TqyI+wfj0/e1zEdLQqRTBIijLNSEblp1n2mvVkQYon8jWo48AFGbQ1J/bPNDxCNGM5g2/3Ft1zDFHdKAPKEdpbu8C40Dxu1Y0eoS+Ty1L5+Ci2gGW73ufsZjonPatGuhe3tl0bl/fdO3GdIdjH28tRfNjCv3ENJUK9Y5sATh45og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4VrL00Z5th0QBMlW4fMTefKVZgbdFHM4p5IlvL+YjLM=;
 b=0u6ggvKp0TWQZQKTz4K4BSYRFTVwrvm3xLg2FCBYOnN8W1VuzUJ3j5BGjIFg+aGSTXKH7v+kIKM/sGAEFqnEVWPgURSrKAfsui/6F7wiffjXbg6PyGnsOpxNQ0R0qgfaGTZVOg3SrLDg2OZuTpitcngistx6PbJ0/wk4mDh0LBs=
Received: from CH3PR12MB8074.namprd12.prod.outlook.com (2603:10b6:610:12b::9)
 by IA0PR12MB7555.namprd12.prod.outlook.com (2603:10b6:208:43d::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.21; Mon, 18 Nov
 2024 05:16:16 +0000
Received: from CH3PR12MB8074.namprd12.prod.outlook.com
 ([fe80::7f58:8648:262d:89e9]) by CH3PR12MB8074.namprd12.prod.outlook.com
 ([fe80::7f58:8648:262d:89e9%3]) with mapi id 15.20.8158.023; Mon, 18 Nov 2024
 05:16:16 +0000
From: "Huang, Tim" <Tim.Huang@amd.com>
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Prosyak, Vitaly" <Vitaly.Prosyak@amd.com>,
 "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "Dong, Andy" <Andy.Dong@amd.com>
Subject: RE: [PATCH 3/3] drm/amdgpu: Fix sysfs warning when hotplugging
Thread-Topic: [PATCH 3/3] drm/amdgpu: Fix sysfs warning when hotplugging
Thread-Index: AQHbOXLbH8soPP2mZ0WXvSIx+qLUUbK8fAoA
Date: Mon, 18 Nov 2024 05:16:16 +0000
Message-ID: <CH3PR12MB8074588C3A119D992DDE5FEAF6272@CH3PR12MB8074.namprd12.prod.outlook.com>
References: <20241118043128.3834919-1-jesse.zhang@amd.com>
 <20241118043128.3834919-3-jesse.zhang@amd.com>
In-Reply-To: <20241118043128.3834919-3-jesse.zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=f58d8594-f07b-40ad-9f77-ba380c1e246f;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2024-11-18T05:05:29Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB8074:EE_|IA0PR12MB7555:EE_
x-ms-office365-filtering-correlation-id: 84f2dff5-ab10-46ae-e9a1-08dd079020ec
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?W6TIzgGRhYUMOvpDWi8qeon3A3I0fj411janMqtwp1Qux3zqCPIH0dMfH80b?=
 =?us-ascii?Q?xIcNtNvmjRIT4P/Pu7tpk72B0H8Tb/5+jXzMWaRQMQwUJcVg6NSBgqrsYPiz?=
 =?us-ascii?Q?tN49mtwsKCmtaXMsMyXDFVnSQhhAdE6CpgSoa66PBuqFeggVOMn57ciH3rbi?=
 =?us-ascii?Q?bTYGIhRH/1OM8hASLy82y55gBGC2m8hG2TGj2NjdFxl0zaJ7FCx6V36Suzd0?=
 =?us-ascii?Q?X4q/PqbtvHMIzWCDm+7j76TIDMQvl1p+Ug2v3pCRqK95DW+5B2Qx2h32wbwK?=
 =?us-ascii?Q?JpzqR8VYROcpWYRsEiOLDJ+w6KavTml5IKglTNtrv/64NgQC9Kpg2Ej6xg2D?=
 =?us-ascii?Q?g8e0WuUd7QbUVNXYoWWUnTHvmALaLM/ND4xE+/LDrHAyGOJdx9mUM6Nn3035?=
 =?us-ascii?Q?jcckbzRQFc43zI0k2LKlVwIPzrIagFE1b2aRfy4NmCeXsG72LK/Z0eM+HJJQ?=
 =?us-ascii?Q?5jPaLto6ZAzLjF2kiamnzAACcOWLhzoD6P4seHYOAXfoik5oQgMTP0Sxu5E4?=
 =?us-ascii?Q?AejH4YC5dtYg11pzenUrIEYJIRNlmpKPdW77ITjhUKAflZ6YeflCWm/F962Y?=
 =?us-ascii?Q?GWWCGYcgKorhwu+g58KemNaEMOiYwei1hEWZ7LFDNIdoWrqrVebSaH7JsRaZ?=
 =?us-ascii?Q?Sa7tB8F8vGxvOza7TcUoAShY1mAzSsKc3nzF+UB2gH4cs3TVNPiog0FZXHAv?=
 =?us-ascii?Q?HeCGEgLrXT7cWgApr/NfzWJfIIwJ90kUp9HpYC+3wiSAEdyxAJg1tX+Eju22?=
 =?us-ascii?Q?URKY9OT0eRMSRTP5YZVFbgf9ljYUk/uib3T9gjqiBWn6VKAJbhNuSySiRo1Z?=
 =?us-ascii?Q?jOMRdymVjhByudfTGJbpCEXgGylGU4L7ixrsgP44l26JubNCkMChDFBerzTy?=
 =?us-ascii?Q?PJwlTYOA/lXeTIwkoxi06tJvHUwBluo6Tyh13LLmrRmTmIFdu7GDgPqzrmlh?=
 =?us-ascii?Q?aqUstUAnigHpFlPTf86kBT011G+Vqs9lPu6qHW/g1C0fXKu5Ndbj8qDLK+KM?=
 =?us-ascii?Q?9clie+vuiaNv1QJHXuFsaPJyv1S8dmanNgSt5eNfJPHhM9PmSvfB+1TeIf1B?=
 =?us-ascii?Q?iAYJj2zgYLZAlE9RqtNCAUnRQk5pDDXVfVagW9wAhbQ1rq+RDUpyahLTAHGB?=
 =?us-ascii?Q?i3AZKyMoVWpUEa4/TshbJAgzLres+Y+re/VBNx+gLGY4XPFCVuJHGC/BuHBU?=
 =?us-ascii?Q?rp9zOn6pcKVnx1GS6GJWAPgb2qhB4VwG71Wa4ZXPcVnPh+Xkw3oSKW7P3VMH?=
 =?us-ascii?Q?Hx+b9u1SJOa6STdUbeDhc5xCOX+BEcSdw2eDJzxoz7KhuUdGeQ/R+ZpOp3HQ?=
 =?us-ascii?Q?fT7AekabxED1qdg0J7cGpul+mFUak749mwJmP7cnNM+AR1a9et6oAFYCDezW?=
 =?us-ascii?Q?f2aG/UU=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8074.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4cKMi43NIO0xNZNY1xY5ZnmpPRz5SLgWsaCQfMoJ5Pep4Cs0y/fgDZUHVCkC?=
 =?us-ascii?Q?pdphRVYFbUY983Up2f/FSfiVQVPUpPh0EmiXwyro1MYm9DinLwlXf553xXbE?=
 =?us-ascii?Q?ZRvh2+F39paqSQYEA2Dc9xJBtOhuTEaOwNHjlLJCtu4ytUfokJ4h75pGDUhM?=
 =?us-ascii?Q?kqpOggne7PJDQzSdO0bjvzArh2w+NIXIn2ECDZo2eTTtx3KajdVucAB6FwD3?=
 =?us-ascii?Q?tH4Er6JpYPzIRx/bVbnIlQ1U+52KKPac6rmt0eUgEvSzPgctNF0hoNbSszlD?=
 =?us-ascii?Q?TNKh8lMd3tIOEds0XWB7BE9dSA3Lcafg6FA8paxYZHsA+A+4e2NpBNyFhc17?=
 =?us-ascii?Q?KLDk07+3WaEHg1PV/pRKUZyr9vBuC5g8BSN8CF5elWb9u/pwJSYmowDlk35Q?=
 =?us-ascii?Q?0ZAyblbLOx/nrpeI7Rd/A/zcuZvfWCdqtN2pkpRtlf2zLe6EkcNahZiaAH23?=
 =?us-ascii?Q?7D9sOoN87JMaPl3wYTy4M8mh8CBkDBqLWDsV5YX/D6BBUnvA9rIMZtkLLg6V?=
 =?us-ascii?Q?IWe8wVLeA8yVypk9ezeDBeaVtQ+nXvjgVpxeQuXxYn9lV7DB9gV8vF5P9ug4?=
 =?us-ascii?Q?ZYMHCA1UQWwY8Xa37FQUqcGTTyypJlY67lUupqdXtaBJgqFzTyOIBODYnktW?=
 =?us-ascii?Q?7pK4lqj4Td34xeKTCBSEj0I14OCBj6djoEVbHl7dQFvwjfqgZ5DdjFpv856Z?=
 =?us-ascii?Q?f9pFoq93MhLsKfCgs5UVZFxVnnXRCX1HuXzdVUvu6XbNpFy6syIyUmJlkaGP?=
 =?us-ascii?Q?GqteklwSKRzbNEtal8qx77cjZy03kP90VD3id9kDa+ONbNIHaJAcMQnhSwtI?=
 =?us-ascii?Q?RdeaqspNU2MNobJRlABdGmKkP9ZjZf6qUykfg2Pfo9Opoy7ARJaR1w0xb/Ni?=
 =?us-ascii?Q?ARAsDxoYefRx+pyKW1hj9tDi1MLEsYfQVJTy36o4t8tEnqmJz4D0j8DvYWOn?=
 =?us-ascii?Q?V8WtEkcCAs6T6+/YTBhExwyOx0wL2d3WeAK388Ml2jKSm8wE/uNMjM++X5EK?=
 =?us-ascii?Q?3n7Xehpu7yTwGUzbpYHpRVb1+dlSPcBaiuxIJWwQcLtOAt5EpEGe4B/mWLve?=
 =?us-ascii?Q?0JlgrXolRCp3i6nHdGFdfaInq5MTJJAMdRY5yNU0h8x9VsMbxuQi/AUvk2RZ?=
 =?us-ascii?Q?SEsd2ubUmwfeTx5MsZoFA23eIuV5lxg2RNhGHBpMjxWYgzPUAv01B6LyztmH?=
 =?us-ascii?Q?44rmCT1qJX1sPwg/mt1PigWb50KQT/3mU9dlTP738zlMHnjF497lq7DkebYr?=
 =?us-ascii?Q?ygcEEOZiSK6X+rI5Ow25YYuffO81DA+JhkbeJ6A9NnjICeGeowQKl9aH79tS?=
 =?us-ascii?Q?biQWGVs1C/emTi5qMGWa/vGDjvljtBC+24bN6trRt3SSbq8v3K0N6UlxTJo+?=
 =?us-ascii?Q?TpoVdo4Jc1lDS8tv8zqdOMrWY7Gt+/qwkj+9hFCREdUai2mkiTH4B6JjImft?=
 =?us-ascii?Q?ZgLzQpda1DPNWqx7UxkCx73ea/kC4is6/HvKRazI/SqlpNJzwC2xeSF15R7U?=
 =?us-ascii?Q?cQzps+dBT6g2xMHGtPAqI8rsZBimx95/2H05D+H8RWZbsRi3X+ht9vamDbf/?=
 =?us-ascii?Q?zQaCHe1b40dA8ZyoQk0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8074.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84f2dff5-ab10-46ae-e9a1-08dd079020ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2024 05:16:16.5505 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FMaPA2Mw3fIO1KrzciNkZVstVl6TvZEM4nnDrjyUHG2DpwE1b/M85oragfnY0ln1OBd7u3IwMhgveijbsV87bg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7555
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
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> Jesse.zhang@amd.com
> Sent: Monday, November 18, 2024 12:31 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Prosyak, Vitaly <Vitaly.Prosyak@amd.com>;
> Huang, Tim <Tim.Huang@amd.com>; Zhang, Jesse(Jie)
> <Jesse.Zhang@amd.com>; Dong, Andy <Andy.Dong@amd.com>
> Subject: [PATCH 3/3] drm/amdgpu: Fix sysfs warning when hotplugging
>
> Replace the check drm_dev_enter with sysfs directory entry.
> Because the dev->unplugged flag will also be set to true, Only uninstall =
the
> driver by amdgpu_exit, not actually unplug the device.

I am okay with this patch. If I recall correctly, this fixes a warning when=
 running IGT tests? It would be helpful to add the comment specifying the t=
ypes of warnings and the test cases that trigger them.

Best Regards,
Tim Huang

>
> Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
> Reported-by: Andy Dong <andy.dong@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c         | 8 +++++---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c        | 6 ++++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_preempt_mgr.c | 3 ++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c        | 6 ++++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c         | 6 ++++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c         | 6 ++++--
>  drivers/gpu/drm/amd/amdgpu/df_v3_6.c            | 4 ++--
>  7 files changed, 25 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> index 3c89c74d67e0..e54f42e3797e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -1778,9 +1778,11 @@ int amdgpu_gfx_sysfs_init(struct amdgpu_device
> *adev)
>
>  void amdgpu_gfx_sysfs_fini(struct amdgpu_device *adev)  {
> -     amdgpu_gfx_sysfs_xcp_fini(adev);
> -     amdgpu_gfx_sysfs_isolation_shader_fini(adev);
> -     amdgpu_gfx_sysfs_reset_mask_fini(adev);
> +     if (adev->dev->kobj.sd) {
> +             amdgpu_gfx_sysfs_xcp_fini(adev);
> +             amdgpu_gfx_sysfs_isolation_shader_fini(adev);
> +             amdgpu_gfx_sysfs_reset_mask_fini(adev);
> +     }
>  }
>
>  int amdgpu_gfx_cleaner_shader_sw_init(struct amdgpu_device *adev, diff
> --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
> index 43ea76ebbad8..9a1a317d4fd9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
> @@ -447,6 +447,8 @@ int amdgpu_jpeg_sysfs_reset_mask_init(struct
> amdgpu_device *adev)
>
>  void amdgpu_jpeg_sysfs_reset_mask_fini(struct amdgpu_device *adev)  {
> -     if (adev->jpeg.num_jpeg_inst)
> -             device_remove_file(adev->dev, &dev_attr_jpeg_reset_mask);
> +     if (adev->dev->kobj.sd) {
> +             if (adev->jpeg.num_jpeg_inst)
> +                     device_remove_file(adev->dev, &dev_attr_jpeg_reset_=
mask);
> +     }
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_preempt_mgr.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_preempt_mgr.c
> index e8adfd0a570a..34b5e22b44e5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_preempt_mgr.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_preempt_mgr.c
> @@ -137,7 +137,8 @@ void amdgpu_preempt_mgr_fini(struct
> amdgpu_device *adev)
>       if (ret)
>               return;
>
> -     device_remove_file(adev->dev, &dev_attr_mem_info_preempt_used);
> +     if (adev->dev->kobj.sd)
> +             device_remove_file(adev->dev,
> &dev_attr_mem_info_preempt_used);
>
>       ttm_resource_manager_cleanup(man);
>       ttm_set_driver_manager(&adev->mman.bdev, AMDGPU_PL_PREEMPT,
> NULL); diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> index 8c89b69edc20..113f0d242618 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> @@ -451,6 +451,8 @@ void amdgpu_sdma_sysfs_reset_mask_fini(struct
> amdgpu_device *adev)
>       if (!amdgpu_gpu_recovery)
>               return;
>
> -     if (adev->sdma.num_instances)
> -             device_remove_file(adev->dev, &dev_attr_sdma_reset_mask);
> +     if (adev->dev->kobj.sd) {
> +             if (adev->sdma.num_instances)
> +                     device_remove_file(adev->dev, &dev_attr_sdma_reset_=
mask);
> +     }
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> index 60e19052a1e2..ed9c795e7b35 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> @@ -1310,6 +1310,8 @@ int amdgpu_vcn_sysfs_reset_mask_init(struct
> amdgpu_device *adev)
>
>  void amdgpu_vcn_sysfs_reset_mask_fini(struct amdgpu_device *adev)  {
> -     if (adev->vcn.num_vcn_inst)
> -             device_remove_file(adev->dev, &dev_attr_vcn_reset_mask);
> +     if (adev->dev->kobj.sd) {
> +             if (adev->vcn.num_vcn_inst)
> +                     device_remove_file(adev->dev, &dev_attr_vcn_reset_m=
ask);
> +     }
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
> index 02bda187f982..dc96e81235df 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
> @@ -904,8 +904,10 @@ int amdgpu_vpe_sysfs_reset_mask_init(struct
> amdgpu_device *adev)
>
>  void amdgpu_vpe_sysfs_reset_mask_fini(struct amdgpu_device *adev)  {
> -     if (adev->vpe.num_instances)
> -             device_remove_file(adev->dev, &dev_attr_vpe_reset_mask);
> +     if (adev->dev->kobj.sd) {
> +             if (adev->vpe.num_instances)
> +                     device_remove_file(adev->dev, &dev_attr_vpe_reset_m=
ask);
> +     }
>  }
>
>  static const struct amdgpu_ring_funcs vpe_ring_funcs =3D { diff --git
> a/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
> b/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
> index 483a441b46aa..621aeca53880 100644
> --- a/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
> +++ b/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
> @@ -254,8 +254,8 @@ static void df_v3_6_sw_init(struct amdgpu_device
> *adev)
>
>  static void df_v3_6_sw_fini(struct amdgpu_device *adev)  {
> -
> -     device_remove_file(adev->dev, &dev_attr_df_cntr_avail);
> +     if (adev->dev->kobj.sd)
> +             device_remove_file(adev->dev, &dev_attr_df_cntr_avail);
>
>  }
>
> --
> 2.25.1

