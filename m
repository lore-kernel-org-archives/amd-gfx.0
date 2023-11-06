Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2497DC4332F
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Nov 2023 04:30:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D17310E0BB;
	Mon,  6 Nov 2023 04:30:07 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2069.outbound.protection.outlook.com [40.107.95.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 67A2A10E0BB
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Nov 2023 04:30:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=duesEnKPfA0alsNTkgbGgZEQ221i2UzAeHNc6J87x13pZCAMftZ46CCUb81+aAfYY7kG+664cK80WwEzaNe/5QbFPyuRiyxrjf3mPbgpTGsz1ctiw6YR3WipaJIYeIghqa0SmdgtAHF6IJhAsN8s9V7BXTHyGegpwsSJvVKEUYAD7+B4mXwu7cW3l4Bn0ec1+HCpMR8ssoJuoOilJjFzkms/YejeRTgDONimH0lEYPAKoFQ1qvxXQPtxlo2k6E6ckdInryMoIh9hOlKCkKAr2wPB1PkRoAWHsnf5zTrRd9ht92/q41r4Scf6h+X0W/yhGl3taIyTzsFDs4uUA/D6hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lNNTbgKzn0ZzBZUz5np5v3lZfUbRNobJcZC5DYFzUug=;
 b=O8d1D1qV7OzOYMchDGnR5autsyAxaOnSODqdWrls4PfjzlN2gxZ//kJ/eC6Wz/HeS8EKpPvSy3jYqBRzLbdIfV99wF3xvog5ret+DvOEdBqpuO5w9b3RKJ6uz/JAOGzKw3xyb/hAN5ZwUov4SofNBk5ub6U0mwIlgxIcKK949M5Bozlal4rdTysarozJsX0d244la/xACTh9OQfYbwsCJ0Yh5GS1s2qv8sxLbQOyPm1Srm25SiOWEFIGkWpNBuNZfqqul+tsHcCUv6rc9JR2z3IPlyjsIcRKwZHANc4VgNIx5UdAP6VXsAHaCfOnJIbGtrjknGtC2Lx9IQBqZaqJmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lNNTbgKzn0ZzBZUz5np5v3lZfUbRNobJcZC5DYFzUug=;
 b=bkfS1VNm6r5JSWJadRKIcBYSnviD5v7544JE5NmSUmqHe+ZT3QZB9Ut16wK8sR4kHeD0oTpSSgH16YlRc2FvbKjzwFU5HtZz3iLLpO3MpStjhej/D/tp3rofAPXtWXYr5bc5V+MPbOrJoso0EGYo0C9vyYLkzGcSvc16oUyGeXE=
Received: from PH0PR12MB5404.namprd12.prod.outlook.com (2603:10b6:510:d7::14)
 by SA1PR12MB6971.namprd12.prod.outlook.com (2603:10b6:806:24e::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Mon, 6 Nov
 2023 04:30:01 +0000
Received: from PH0PR12MB5404.namprd12.prod.outlook.com
 ([fe80::d7a9:f0ae:5689:230e]) by PH0PR12MB5404.namprd12.prod.outlook.com
 ([fe80::d7a9:f0ae:5689:230e%7]) with mapi id 15.20.6954.027; Mon, 6 Nov 2023
 04:30:00 +0000
From: "Ma, Le" <Le.Ma@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Fix sdma 4.4.2 doorbell rptr/wptr init
Thread-Topic: [PATCH] drm/amdgpu: Fix sdma 4.4.2 doorbell rptr/wptr init
Thread-Index: AQHaEGiyTrw/isqxP060AwZMt/HmBbBssZfw
Date: Mon, 6 Nov 2023 04:30:00 +0000
Message-ID: <PH0PR12MB5404F3D815720D403A9DE637F6AAA@PH0PR12MB5404.namprd12.prod.outlook.com>
References: <20231106042054.512499-1-lijo.lazar@amd.com>
In-Reply-To: <20231106042054.512499-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=b67cde4a-c39c-457c-9211-88b61a56fa5b;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-11-06T04:24:59Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5404:EE_|SA1PR12MB6971:EE_
x-ms-office365-filtering-correlation-id: e3d05679-ecad-4f59-4599-08dbde810a54
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vzrhDHH58fG+Nbf/f7N9A4hxVfxsrmAHHZhfA4VEugDeeOnue1wUP4ioY1NT6PShz0+lJfInH9aon3BH5N9oCiGCc6NKNANAYbOL9wfoHnoGd2wBcl6wT/lk9wW60uzg72x/xtrwlRuhWhK9NTCONPoCEllJe1lznKBg2yO7iujAWPOs2+igzu7viEVh8xxeidKTfokar/xqoRMZdjybOndWaVD8wcQ30hzMnZddys/VsPn5X1bvfoC4tx3D4zw3+KjEVR22LKmvkGEK7H98419Erd2ZZ8vPyrDR6a81ZTCs1+1bv4DHbx6kIH0wit7JVGlhMXBKQtKjZTF/fXBDIwPLVOS7+6pwOxbM2utEv3zrJLcX4dt207tTN1QHScgHRVIIFhhM9tac+rF1YtkgIvqQVSkUS/6zH7NJWnAo2AHxxnmgPFDpSNt/T2FHI22J2t3a1D0jLy8lhzUH8FT7lH/c2eNijAGo6JYtG13spEk9s2qihb0x4DIwEnHtamp5azEDuj7J1Ur2PqRy9vULYQXXD9SbZIP2L8DJnJJX//G/CMEabg6UcfrWY7xlHkFSdyt4MfZ/1mMu6ZBiZ/Ua0vUkjNYKc3oRSmRnxJlbXXEFrPEXzNiB+2wOIJ5dBQ1H
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5404.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(136003)(346002)(366004)(396003)(39860400002)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(38070700009)(122000001)(110136005)(66946007)(83380400001)(76116006)(26005)(478600001)(71200400001)(6506007)(7696005)(66556008)(53546011)(9686003)(2906002)(4326008)(8676002)(41300700001)(8936002)(55016003)(38100700002)(5660300002)(52536014)(86362001)(64756008)(66476007)(66446008)(54906003)(316002)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vy2HEtam5+CtTqBEVBonLCE/ka6zyKvA6/bfiUaleoQoj8m6HOa675s6Te9C?=
 =?us-ascii?Q?UpIchPwe6CXjsZzYIZ3Xct7jOsDw1dqOgtEB/RKYWwAXuK9CKASftemftKJU?=
 =?us-ascii?Q?c2GnOT9Dli8pDU1iYXswwfy4TlWYXs4DIQ1M8PZQCh8cAhPA7mn5WThO4IUr?=
 =?us-ascii?Q?HuOD69njzBBCC86Uko+CNRwzjMu2r66hxEmhqOK+YtrGgXQrwLkckIHrjb23?=
 =?us-ascii?Q?xy8CPDZ6oKz0GLyuc9610UAIfFt+YXwfYjLc8aiQfEaAX7s5bEVhtWtllsR4?=
 =?us-ascii?Q?P7G0DLccRdm8dmdgbY7TTXPrcpQdaNgf6lkV4hPVe+2KUOY/MZc0VRDG1Bff?=
 =?us-ascii?Q?XDEv5fZgMhIWx8OBzakSk5xh3ba+sxSAZvVpxip6P7iDVsKOzp10HmlI6kg0?=
 =?us-ascii?Q?b7IQcOc2fRW1D3rTSj46PXBAVo/9SWIKi9RTvtXf0CT0x41NaNTOri1lATyC?=
 =?us-ascii?Q?qlSO6Ox9iBVqHCFx+PHkDx+8xlT5pKrg2nkRYgclhMGfwRfry/m4WPiWRhC6?=
 =?us-ascii?Q?gVxZ3h3XP/zrZMFm6DvdP2Z+L8Qk8FYz2IEq37qMjQbg6uxkZenfld4q35S9?=
 =?us-ascii?Q?/59WIyUdRqFM6rag1EmAGMApNDlLuINlX+uV62y1Zb3BnFnQ3mkCXKThB1V7?=
 =?us-ascii?Q?2xul3m6xVkXwvEuOKENI/gEWJ9xEs46cUjyMpFPOadKvHx8XRWYHmONCZVUz?=
 =?us-ascii?Q?F5KGh+BKacZhXDxBwnRMLe8y/Zf3uqNrg3bIVNnQdjfl7qh4tBffHVkKrKZj?=
 =?us-ascii?Q?a5V7cGqMUYPCaYMNmYdkdhWdhC+TkotsN3MbpSxN+OxvlHpNfsUr5YMRG9gD?=
 =?us-ascii?Q?TngP047dKuMkFRyIYERBfBeIH8vtAyS0RC69DydcmyCOw2tlr06bs6y9ZPKg?=
 =?us-ascii?Q?Pu/pBOPfkrnd4At0NfrwUvAtYUrE03vo2Qf0RZlVl8lKab+td+q3n2BpUexc?=
 =?us-ascii?Q?jg2loAI3iVqvlQQ8dVqY/tHvAmMbv5VoWD49jIG3S/WweiaRYlPbFvwVTycz?=
 =?us-ascii?Q?+DW4lq7M/zNw7VQEn2J54Ekw4YySRczKtyPanMjjPV7r9fG+b20eY46yVj9D?=
 =?us-ascii?Q?w5WXt0BOfvEUqBD3wwiDfC/76OIzS76L8VEPOAwglMBUhCBxAUnhzFpNFHK3?=
 =?us-ascii?Q?rvZVZxEaRfFDMN07Yxk/ACqkjt+kruCSQtZRuHJ8V2PI0+dAd+dtiSlfmrqf?=
 =?us-ascii?Q?XAbnyWLhM/nlnZUi6PDVKcncxdL3GdKBkJJjATGnrFHgHmWILilie/9uTQU1?=
 =?us-ascii?Q?uvX048wV3kP5PPc6kpj8jMcdeDbs9vGaf/zOmEOj4h/+TcNDAHmry7ayNfPA?=
 =?us-ascii?Q?IWJfDL3jZu4hpvN/8TtAigKmdATOPTVdiUalxY+d5v/xdBbvyxiFlbEOmIUI?=
 =?us-ascii?Q?hQhWNaZwFnSPztpncBvtGMeqakLHK+cDzLz+n1/hyNAirW6jQo/6OqJg4MJL?=
 =?us-ascii?Q?p+2lFhNZ11/B3sf2oRI9moAHetq/ZYTqZAEd9tdkERN2PHqE5oMJuX1kIMB4?=
 =?us-ascii?Q?oegDzPLeBFKdff/VKQsyFswY4D2YtsVwK1Bj6+frYzuXQX5ehEot/7AdxRlr?=
 =?us-ascii?Q?lr+gn7XnFhJeYVsjmLM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3d05679-ecad-4f59-4599-08dbde810a54
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2023 04:30:00.7914 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +LJdczS98ZDMC93WHKe8MpqSCbdjNYpdlfTqBOHf8mbhkb3HDiVW1dvUVNYvA5tJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6971
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Kamal,
 Asad" <Asad.Kamal@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Le Ma <le.ma@amd.com>

> -----Original Message-----
> From: Lazar, Lijo <Lijo.Lazar@amd.com>
> Sent: Monday, November 6, 2023 12:21 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>; Ma,
> Le <Le.Ma@amd.com>
> Subject: [PATCH] drm/amdgpu: Fix sdma 4.4.2 doorbell rptr/wptr init
>
> Doorbell rptr/wptr can be set through multiple ways including direct regi=
ster
> initialization. Disable doorbell during hw_fini once the ring is disabled=
 so that
> during next module reload direct initialization takes effect. Also, move =
the direct
> initialization after minor update is set to 1 since rptr/wptr are reiniti=
alized back
> to 0 which could be lower than the previous doorbell value (ex: cases lik=
e
> module reload).
>
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 25 ++++++++++++++++++------
>  1 file changed, 19 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> index c46bc6aa4f48..bd65a62f8903 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> @@ -427,6 +427,7 @@ static void sdma_v4_4_2_inst_gfx_stop(struct
> amdgpu_device *adev,
>                                     uint32_t inst_mask)
>  {
>       struct amdgpu_ring *sdma[AMDGPU_MAX_SDMA_INSTANCES];
> +     u32 doorbell_offset, doorbell;
>       u32 rb_cntl, ib_cntl;
>       int i, unset =3D 0;
>
> @@ -444,6 +445,18 @@ static void sdma_v4_4_2_inst_gfx_stop(struct
> amdgpu_device *adev,
>               ib_cntl =3D RREG32_SDMA(i, regSDMA_GFX_IB_CNTL);
>               ib_cntl =3D REG_SET_FIELD(ib_cntl, SDMA_GFX_IB_CNTL,
> IB_ENABLE, 0);
>               WREG32_SDMA(i, regSDMA_GFX_IB_CNTL, ib_cntl);
> +
> +             if (sdma[i]->use_doorbell) {
> +                     doorbell =3D RREG32_SDMA(i, regSDMA_GFX_DOORBELL);
> +                     doorbell_offset =3D RREG32_SDMA(i,
> regSDMA_GFX_DOORBELL_OFFSET);
> +
> +                     doorbell =3D REG_SET_FIELD(doorbell,
> SDMA_GFX_DOORBELL, ENABLE, 0);
> +                     doorbell_offset =3D REG_SET_FIELD(doorbell_offset,
> +                                     SDMA_GFX_DOORBELL_OFFSET,
> +                                     OFFSET, 0);
> +                     WREG32_SDMA(i, regSDMA_GFX_DOORBELL, doorbell);
> +                     WREG32_SDMA(i, regSDMA_GFX_DOORBELL_OFFSET,
> doorbell_offset);
> +             }
>       }
>  }
>
> @@ -631,12 +644,6 @@ static void sdma_v4_4_2_gfx_resume(struct
> amdgpu_device *adev, unsigned int i)
>       rb_cntl =3D sdma_v4_4_2_rb_cntl(ring, rb_cntl);
>       WREG32_SDMA(i, regSDMA_GFX_RB_CNTL, rb_cntl);
>
> -     /* Initialize the ring buffer's read and write pointers */
> -     WREG32_SDMA(i, regSDMA_GFX_RB_RPTR, 0);
> -     WREG32_SDMA(i, regSDMA_GFX_RB_RPTR_HI, 0);
> -     WREG32_SDMA(i, regSDMA_GFX_RB_WPTR, 0);
> -     WREG32_SDMA(i, regSDMA_GFX_RB_WPTR_HI, 0);
> -
>       /* set the wb address whether it's enabled or not */
>       WREG32_SDMA(i, regSDMA_GFX_RB_RPTR_ADDR_HI,
>              upper_32_bits(adev->wb.gpu_addr + wb_offset) & 0xFFFFFFFF); =
@@
> -654,6 +661,12 @@ static void sdma_v4_4_2_gfx_resume(struct
> amdgpu_device *adev, unsigned int i)
>       /* before programing wptr to a less value, need set minor_ptr_updat=
e
> first */
>       WREG32_SDMA(i, regSDMA_GFX_MINOR_PTR_UPDATE, 1);
>
> +     /* Initialize the ring buffer's read and write pointers */
> +     WREG32_SDMA(i, regSDMA_GFX_RB_RPTR, 0);
> +     WREG32_SDMA(i, regSDMA_GFX_RB_RPTR_HI, 0);
> +     WREG32_SDMA(i, regSDMA_GFX_RB_WPTR, 0);
> +     WREG32_SDMA(i, regSDMA_GFX_RB_WPTR_HI, 0);
> +
>       doorbell =3D RREG32_SDMA(i, regSDMA_GFX_DOORBELL);
>       doorbell_offset =3D RREG32_SDMA(i, regSDMA_GFX_DOORBELL_OFFSET);
>
> --
> 2.25.1

