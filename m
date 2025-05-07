Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02C3EC369DC
	for <amd-gfx@archiver.kernel.org>; Wed,  7 May 2025 03:53:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A3D910E059;
	Wed,  7 May 2025 03:53:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eb70IDYV";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2078.outbound.protection.outlook.com [40.107.237.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C4F010E059
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 May 2025 03:53:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BpwVuvoEa2JkhntXhZwfwJ30irZWQhrCkYCVbkxLPiMqUR7ILBqg920uio+RuckNt5PC31V6WV7AoTCgbTBQM6cS2x1hNgyw5cNJdQUo4L2ZwSnGR1Z34fBpVFDIYKWc6wDQKMIfL9DSyZiCVSYbyzRpnmUJeeNApxLf0w4XDwcMMzWs1XZQyGh10XKjBM0I9P51118mjmGebsxkZmzQgZ+8JCEbI3/pxvagbR73Rg095x3Pi5VWv6ExWfpPQ4tpqnOZ4yoZaotZaHMexM0JSqhH1/vpfOLbR417ChVBPH07NDLT8Sxm5coyUHPE83Ya/ZmwV1TLDmdI5TBCGPF8bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xtXq7vJ102FpeCvkWWCGN1Om7zT2eZWZ8dWR4QxzdBE=;
 b=yu2DHc0WkEwTwStnoIlJY7YOsZp07+/n8T1JvaqXcVf+NOGO+fJAJqu/DiD7qUc8sjcTVPwAbtpaJXsM4izCHP2M1zjEr5gIlu9yBTohYjA6ujvebfRNBq8O4ao/a1mq4+6USYXuiP3H82G76gqatY1+teY03y5ZpSOD8an826Ds0HhMmLzkD5FoiMUYew5NLHHwAk26aKWpLB9o5uU2NuS/fUtqTJ/g+Rov2EcsYRM0ejUg/gdzaDMBKxW01SNSWVq+Ykl0eti/fFXZMHjLKXA3l+gA+rYlvt+AwJCM7Unwo8oNAPxbydXpLc3sHAGi3Mz89UmChDNMLBGq/WxdCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xtXq7vJ102FpeCvkWWCGN1Om7zT2eZWZ8dWR4QxzdBE=;
 b=eb70IDYVL95BhnbDJ+OYagwAq+zOTqhtfhhGd88OIdbikHa62nv1c8MtfcNztpjihIPDhI1KBz8nrg1SYeBEDoqEvqqD3UjwNYMyVmoKN/XA8a7CTkri/zUbmOnkgVER0Z/yDUa+wwmBYOb9wP3t0Gww3JSh0lTUS3UrFoJJzA8=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by CY3PR12MB9677.namprd12.prod.outlook.com (2603:10b6:930:101::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.24; Wed, 7 May
 2025 03:53:16 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd%6]) with mapi id 15.20.8699.026; Wed, 7 May 2025
 03:53:16 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Sun, Ce(Overlord)" <Ce.Sun@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Modify the count method of defer error
Thread-Topic: [PATCH] drm/amdgpu: Modify the count method of defer error
Thread-Index: AQHbvvczfocVIvKM0EGdtfETLxlbxbPGiA5w
Date: Wed, 7 May 2025 03:53:16 +0000
Message-ID: <PH7PR12MB8796EAD48B786E4F9EC76CFCB088A@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <20250507022432.368396-1-cesun102@amd.com>
In-Reply-To: <20250507022432.368396-1-cesun102@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=d5436eea-f086-4dfd-961c-e022e9355172;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-05-07T03:49:11Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|CY3PR12MB9677:EE_
x-ms-office365-filtering-correlation-id: 529364dd-d57e-4733-1aed-08dd8d1ab2b1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?dMGT+KIshgWrTZKLz8CC+jgQun3ptuu+mTXElBeMEvzQcu3fjzDNfEbw1tFG?=
 =?us-ascii?Q?H3XXAWrcg6EMmAsaHxlIzEujEMe3205pTqRG1rRCDdcK3zATZ7wx7htMWzO1?=
 =?us-ascii?Q?dreIcxeVkyIPSHRXePl6jjxaHdV3w2ibQiVrQiS7uYC4jpIeqSPfxA8ebTDI?=
 =?us-ascii?Q?e8Xb5NKzVD66OsoJ5QRC+cfRIAtRHvqUo9nQfUBQYCPi+0i5Bmizimg3nWlA?=
 =?us-ascii?Q?8zUm5Imm2M0wm7XzZ8pGJhRgQkI0UZOb6Y79V8GS5OAAAlKzau6ubeKLGMxO?=
 =?us-ascii?Q?1K2GOGWFGPowfQennElnCUZiaTaUZYrsolsJw8fV90jNM98aQ3gzn2EPDj/P?=
 =?us-ascii?Q?uZEYzXgZHX/5NedRU0hYegZxDPTZx3ArzTOvUvHGOfFqP+xh7bnsJ1GKY6C+?=
 =?us-ascii?Q?ndpd1egOsg+/vRlfsAso/JTGXAFRvoXLL0PReraKHpBUlK8k5XwU3W4inKgH?=
 =?us-ascii?Q?xrhfLWMRGo0XZH/rZtj2qVrOlUN5qXl4s/oIN4R5v85R70yZyIytU6rG+6Xm?=
 =?us-ascii?Q?bJKQnkeVLMWayfTwUZGyE/JbpZwULalxWwIFv4ix9gDRbq7H1SRKkMIkMcrt?=
 =?us-ascii?Q?W7ek5FGNULusksKDxcCPVXwM3yAY8kMRVTZR7sUO2QV8FNQoYSy1CyQGn65e?=
 =?us-ascii?Q?0is5sFsr8ij/s1O3m6Y38ftBdES1ZQVGa7MKO9f4dydBKR+I8hNSAXR/HYr/?=
 =?us-ascii?Q?P11R/NyJReFrdtQxdcbDb8YTDjmzgh2l3b4y7cj+guRlBA2ldTrsJR+dEpqz?=
 =?us-ascii?Q?VfilxKsFlFdRJmZoJ1euA4r4n3v/p7yH2r9vNNBJlaeR6cckzPjeZKqa1Df9?=
 =?us-ascii?Q?IFy9CEtqewXbmSCFYfLKq32foFJZorz6qcew94OCMPdGuaVotCFsqrA5MzMP?=
 =?us-ascii?Q?w9E/tMzWuqmDRZP8gsoMXDpK5eC+7g5GgzaL4sJUFLzL7DJitD84LftJ3yrO?=
 =?us-ascii?Q?FF0GvJFPLpyqt2CWp4EqaDHifF2Y4Eb7r11KLZH6xvte9G45l0qh7NvsewfG?=
 =?us-ascii?Q?TKhmMaa5rme/XG1pi46M7P4Vuj304447sE8rGrLjSemIhQU4rNHtl4DP0dn6?=
 =?us-ascii?Q?8/4aa9KWp2FmS7TSSWTJboLpUJvQfLmwoHm9dkO89+NbfyWXpDlh/8ugluwW?=
 =?us-ascii?Q?WWJOwHQ3k3qdapMezRtdkKJKgCuyoHrI2jXti+L6sK7fO1wXwhM6BvQh3SvH?=
 =?us-ascii?Q?BNQgSLsg2svgEKqoG9CDby0scIAFwLrFQc4nnSVFoNENIb2pw88VO6NE+44j?=
 =?us-ascii?Q?iq6ysFWS0937FVZ5y4ukXAL05yTmwl8P3mbEK+vIEjc28zRyEz+UPik5MScP?=
 =?us-ascii?Q?8ECmvEcI+dy8Slu2wDFOfUBy+DlcpazlzTxQsCHLQyrOLClV4VJ0aJ74fqHu?=
 =?us-ascii?Q?hPKXpkg45Zswol+WLmy8yv0UFN/g0zapTVD1Ybptqym9M6lEEd6DJgBlJs+b?=
 =?us-ascii?Q?oSvj7Cuyfbum1FxE4KaJoilO3HKAyMk08Pj3HqAKf0DtvKNbnguK5g=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?aE0ljtxHflyy4Gj1mMroL85nt4RVfHl8FpHxunsMZH17tt0V7eLLXVmhQKsx?=
 =?us-ascii?Q?Nazt466fJWz8t5Hrmrxa0frUOec53QcDqHR7rfgDzTBSu9tSXjpOglROf9w2?=
 =?us-ascii?Q?z0UFhBG8ysuRRp3S6o5MLprrg8kuJWZ3oSKSFRWLx/TD3peBtJznat/KIS6l?=
 =?us-ascii?Q?zD1UiR+PlzT5tk48jx7N6+XTSVneY+ugyHjHSsVR6UWtne0aM8NkFyHP+WYE?=
 =?us-ascii?Q?76A6l8Xc6IZxvKzY1zJTYfQPR1mx7fNHgNP5UklVxqqyX1bt9Bl8gd3CTrMY?=
 =?us-ascii?Q?Z7ydDYj0tk17O4XpPUGx51vNzRaTixJzWjPyuIIwSrXbFyyydNtsWKxtX53F?=
 =?us-ascii?Q?zfknGnadLr0y0KHpUD8flLFXt+eNVEFE31OMxn/Aag5Fyw5HtNFQkgT9siYZ?=
 =?us-ascii?Q?0qMcE8e9a5e8+TTxZB6i+Gh89Hbs+YX0o+XSoYIWoAyuhLM9GOlRsx4+p3VI?=
 =?us-ascii?Q?Bvfszh/KMkfyJaeca+ukV2ie/cgz7aylk+7D6uKPrvwZpMd9e8qUIBtDVH9N?=
 =?us-ascii?Q?m7vmsnTKrHSgiG7Fospmj8MikMs5pLw07SDMWgZHOTbiQtU1+3PS2ZuYndEm?=
 =?us-ascii?Q?fa5yklpi6DPJhClGYO+FvRBaJacP+17Sz+9xSR7Nc6RL+Zc+7stXZooe9C8M?=
 =?us-ascii?Q?E1Z7+Zf9jmvhy1svMZf95I0epCKBKLhbyw02xTf3aNmFpxWHQvRmZwMoJuG5?=
 =?us-ascii?Q?rqop8WLTmLPmm8dwoEuOSjdhrqpkbrbT3atmtboytrTxjE9+k3LkXQUhD4q+?=
 =?us-ascii?Q?dB7/PFEpHKQKkDNFkC11P4UeJKToxfRTT56JR1gOzf0eWC2nDm2k7ofdJWZI?=
 =?us-ascii?Q?/WZZ/OMrv6oAlmiaDHZecj6r7pA263SsGaYxcdq+cAQTx7a1e+g/nkQkzoCL?=
 =?us-ascii?Q?wSH6gwmhbM43lMxMlt0P5qLt2ASDlsxRwRxQY+fmQl2M/dCNtEnQGwAZTjAi?=
 =?us-ascii?Q?0PcQOroa34XSOfdA6sKz8zOvBkS2OeuoRxSseUZC1TTKqdtfGaZdBGRLCFHj?=
 =?us-ascii?Q?G4nkuyhc8CbUVzCGd/RDfiB5DisUlTN9Mo+sd/VnwYJm3RoY8jW14yCAG2Ze?=
 =?us-ascii?Q?F1BebzyR8EtnpetFORYU89/n8WlspVEqhCPi2Ue4kIV/qTq+Dv4AnCu5BGr0?=
 =?us-ascii?Q?UKGN4zFfrtoCoR49ExjBDOwgkvhT4hqMdNh0KFRapyKFUvUnLhpiRje1XPXr?=
 =?us-ascii?Q?rzCD9ozQarRiFcKwsT62H8LrCdbeUehqPmANavWIT4n3r4aR4HLhaBWL/vGN?=
 =?us-ascii?Q?h0lCCWE3Zb73QJYFiV43beQDFm9cuj+Bdoe9ZhC2zFe42G3GtmvCZupDmm97?=
 =?us-ascii?Q?e7XIqvzknEluu8fimsaNGmyVDQ/lOUU6qt00ZSzwur7sVaHh9R5aeaUxH49G?=
 =?us-ascii?Q?2snCuvhOe9SOrwQmr+2P4K1OXeVaL9KackN4SLTm4CiBbwOrD0JB/KLgw44p?=
 =?us-ascii?Q?zuLDT5gz8a/kQY8/7sXtRQr+pxbDiWWh3Y0/11TXbBbmAGLIEDx+3tP266Y4?=
 =?us-ascii?Q?RfUUVfOw9IbevHhw/SIQULXBQcxZnOwCHearXHslC/jUgVXMW3oGNuPJTrlw?=
 =?us-ascii?Q?rxQyXqtWyiTh0C0CaPg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 529364dd-d57e-4733-1aed-08dd8d1ab2b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2025 03:53:16.2833 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q3Vri0XVhphMDI+fLNIglXdC+Xj0mr/kvsyxyMYS+JCyGjpAoWfK8RkJNycAPKJ1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9677
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

> -----Original Message-----
> From: Sun, Ce(Overlord) <Ce.Sun@amd.com>
> Sent: Wednesday, May 7, 2025 10:25 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhou1, Tao <Tao.Zhou1@amd.com>; Zhang, Hawking
> <Hawking.Zhang@amd.com>; Sun, Ce(Overlord) <Ce.Sun@amd.com>
> Subject: [PATCH] drm/amdgpu: Modify the count method of defer error
>
> The number of newly added de counts and the number of newly added error
> addresses remain consistent
>
> Signed-off-by: Ce Sun <cesun102@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h |  1 +
> drivers/gpu/drm/amd/amdgpu/umc_v12_0.c  | 11 +++++++++--
>  2 files changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
> index 857693bcd8d4..52fb71c4ce9d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
> @@ -130,6 +130,7 @@ struct amdgpu_umc {
>
>       /* active mask for umc node instance */
>       unsigned long active_mask;
> +     unsigned long err_addr_cnt;
>  };
>
>  int amdgpu_umc_ras_sw_init(struct amdgpu_device *adev); diff --git
> a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
> b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
> index 0e404c074975..eb3f99dbbcd7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
> @@ -262,6 +262,9 @@ static int umc_v12_0_convert_error_address(struct
> amdgpu_device *adev,
>                               soc_pa, channel_index, umc_inst);
>       }
>
> +     if (err_data)
> +             adev->umc.err_addr_cnt =3D err_data->err_addr_cnt;

[Tao] better not to update it here.
The error address can't be queried sometimes but error status and poison co=
nsumption are generated, adev->umc.err_addr_cnt should 0 in this case, but =
there is no chance to set it to 0 if it's configured here.

> +
>  out:
>       return ret;
>  }
> @@ -428,8 +431,12 @@ static int umc_v12_0_aca_bank_parser(struct aca_hand=
le
> *handle, struct aca_bank
>               bank->regs[ACA_REG_IDX_ADDR]);
>
>       ext_error_code =3D ACA_REG__STATUS__ERRORCODEEXT(status);
> -     count =3D ext_error_code =3D=3D 0 ?
> -             ACA_REG__MISC0__ERRCNT(bank-
> >regs[ACA_REG_IDX_MISC0]) : 1ULL;
> +     if (umc_v12_0_is_deferred_error(adev, status))
> +             count =3D ext_error_code =3D=3D 0 ?
> +                     adev->umc.err_addr_cnt / adev->umc.retire_unit : 1U=
LL;
> +     else
> +             count =3D ext_error_code =3D=3D 0 ?
> +                     ACA_REG__MISC0__ERRCNT(bank-
> >regs[ACA_REG_IDX_MISC0]) : 1ULL;
>
>       return aca_error_cache_log_bank_error(handle, &info, err_type, coun=
t);  }
> --
> 2.34.1

