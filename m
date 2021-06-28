Return-Path: <SRS0=DKNW=LW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,PDS_BAD_THREAD_QP_64,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4012C2B9F4
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Jun 2021 04:38:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8679C61C2F
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Jun 2021 04:38:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8679C61C2F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D936189D8E;
	Mon, 28 Jun 2021 04:38:07 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2061.outbound.protection.outlook.com [40.107.237.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5DFFE89D8E
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Jun 2021 04:38:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AT1NNylt+3I8TPtgK/Zs3rwiF/bMkjcoFzD/1GeIBqVIHgMOOJWgsaLRC8RFif5+RXVUem6/Kq1nRyxakst6N5Q3iu9BJLe/JAr4gGUfI5kSYXmQqjibRyOoe/frIIQY1cwOGQATAOzNPSGaAoG9FX7dPzQeo6LsPgfmaHOgReLEfzvVmS82tYYsmY4Fp8r/6N8gZKeb2xm8g2erXXbwuT34/28eJDF3a6q1Eden87tddqquFaZ0pnnz9+Upm0Ri86QgbMH0V2/KuB7oUG+lvPD3KTXuDFG4MA9HNhT7QYTSi6CKOLy9DrBX4i4Sb7rCa75mSV4u/96zKD8+DaDwZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LOxNQBaVairrI9nE8eVjHG+l6Vx8Qv8rTwZ3lBfMz/Y=;
 b=X3zydjkkWIfMnjl+D4U+sbZHHphpcfWXcA3fpS6KiV0QmII3dy2tKPTL7+gNBI+U/dGqecBGZBmkWz9p9Izw5sKtqW5zHtdZzaNYjpfTQM9be8CAL/nC94CH8mTRih3BfcD/R119kAo6TeayN6W/dLpfIobKhD63y8d6iajv4bjT5T3qv/IhPUrzwgukg9Nf80eEXRkql3HaGjP9cYIglB2B9rQ+Us3Jd1uN4vvA9AgPwKl4yhARQ9X4oE/EbLIJkp/1NXYN7HtgWPPBUP5W/NQ14qf6DnI7cdVsNjkGDxY613zZVZBWrI6lduvw8GWs/YrtVlBdwqTXnNCz7WV+JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LOxNQBaVairrI9nE8eVjHG+l6Vx8Qv8rTwZ3lBfMz/Y=;
 b=gCCnitRoJ4Aucq/4bqKUd4DTkS7H83FaY/iBMduImma1vjiMxEHzbdQIQIG0+CwVv0zoyLL7r94A9GlOWIOwqNfDBxRGgqdvPBhmybmwMYqHuVo/c/WTpGRMjAZbBaTnFoSB9YEMbvjTg24OZhPp73cs9JqW1CYvjTBiiOgxoLo=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by BN9PR12MB5259.namprd12.prod.outlook.com (2603:10b6:408:100::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.20; Mon, 28 Jun
 2021 04:38:04 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::5dd:148c:8b35:b31b]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::5dd:148c:8b35:b31b%3]) with mapi id 15.20.4264.026; Mon, 28 Jun 2021
 04:38:04 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Wang, Kevin(Yang)" <Kevin1.Wang@amd.com>, "Lazar, Lijo"
 <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Min, Frank" <Frank.Min@amd.com>
Subject: RE: [PATCH] drm/amdgpu: add non-aligned address supported in
 amdgpu_device_vram_access()
Thread-Topic: [PATCH] drm/amdgpu: add non-aligned address supported in
 amdgpu_device_vram_access()
Thread-Index: AQHXaXGfFakEA2m86EW8pDen65bBRaskuTOAgAQC3oCAAB+8sA==
Date: Mon, 28 Jun 2021 04:38:03 +0000
Message-ID: <BN9PR12MB5257B09D8AE246206A1AC3CFFC039@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20210625032409.15715-1-kevin1.wang@amd.com>,
 <86c67f76-da5c-471e-16dd-03c434adac3a@amd.com>
 <CO6PR12MB5473FAC04206361D8BC1C911A2039@CO6PR12MB5473.namprd12.prod.outlook.com>
In-Reply-To: <CO6PR12MB5473FAC04206361D8BC1C911A2039@CO6PR12MB5473.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: Frank.Min@amd.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-06-28T04:38:01Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.134.244]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bab6bf3a-0711-4a11-d251-08d939ee84b3
x-ms-traffictypediagnostic: BN9PR12MB5259:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN9PR12MB5259A7FCDAC38B26DD9D5619FC039@BN9PR12MB5259.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VNbE8/he2owAfrwJktfRm8qt/9gglpQ9xWej07byaNxtZ7lp+msHZ6wV9Y1dMHcxFtNfjP9xRdnp0QopAxD4Jg/9OxLeL1iTjQZ+KMAEKKz63gEQi3iyCgEFifpq/pyxGuNq2nR2dDs3tHX1y1skiC8oT3TvGERlFBpFSiCPg+s875iR1V2UlBsNZhc2TgwgScPBT6qvlWpb4AbFbSA/l2XAR7qlI4nNEkope252vylFVgoyeXYVrXax6iOP3Kbdi3CCgexv6mHV5FUNQeTmMu0SZx6w3q5F2CR9aSTCiTZNbiivccHo6AfoQoeqkF62NQD4QaLoxqYo5PMoWW3W7AYeKqtTZPEk3IuMHfUqGdyB9WosnY4+cl6Wm5N2eE9/2F3NMOwGscQIuZV826YQTd/uwKVKu6y5lG4XtuAt/5pECktyuYKJeyqxtuFOMvZ5bMVt6Hm+mqdJTO6qma7hJiaQJ9I0Zl4qBqpWjn9B64+FazqjmAZ53nfDPM7ivDApAhtq7qLjIslZbF2ZCrDiw56y/IV+bMLYmeGpX6zXp1O6qgYpRoBt746wAUGHZ+rlkeLhF/BbFsd6ozEc9h02jmjgP1Mja44EeKta/lG5Dbo=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(136003)(396003)(376002)(39860400002)(478600001)(8936002)(66946007)(76116006)(38100700002)(316002)(2906002)(4326008)(7696005)(122000001)(9686003)(5660300002)(54906003)(53546011)(66476007)(8676002)(83380400001)(186003)(86362001)(64756008)(66556008)(6506007)(66446008)(110136005)(26005)(6636002)(71200400001)(52536014)(33656002)(55016002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?PZNOd30gS3DX4SZe8zOSvVrywW4sG8ArfeLgeHo7r3TBogt2AZ6jKXMqfdKk?=
 =?us-ascii?Q?UxxswPSYp+U3ajccMz2RYLq9KvtZ+hfG5Pivpbzbgmc3eLvdUM6dKNiDN9wp?=
 =?us-ascii?Q?kgKIP9yocKAoIGYWTbQ+tXxuGHlj+7uJ2t1VJyszyIHYpW+a2ksZrABriZS2?=
 =?us-ascii?Q?zTF6GUudo45X35bNlmeVpcs82sTHrbcmq/YFbibRzqiCJrU7ZDMk5Xy1vXyl?=
 =?us-ascii?Q?RRlSnQTNnozrFgeU7Kbqyg7l6aY86DsI24AscPsg4+pHcwYQ1UO13Bc81hRV?=
 =?us-ascii?Q?rJbFs73OjswJf3w9hLmR3MIXO8VjDbeCQDl7AJEaLe0cPpEMCk7gu2xdz0ZD?=
 =?us-ascii?Q?q/fPQjCw2UyqJzmxZQCeN7XtPCOz0FAHCx8rokcOLZK9VEoAbqxkjqR9SpGb?=
 =?us-ascii?Q?Yn0utF0fxg7X1VIzITlGk61IQJJDcXxlT+Cqq7ICHnRK8Ewz0U7tJNud+uVd?=
 =?us-ascii?Q?lZnk+6fRrbZ01yQdk6gLLzmIGn4KUkWdE7zFYdwI0WUCYyZK7B/IzJwWaV44?=
 =?us-ascii?Q?S0TZJLYPS+jljBbX2fGvy4+mPb0Uzn5Aco83Hfi8097J5GVoJOoTqNmTsyQv?=
 =?us-ascii?Q?PW5y7TY7CH4Ce8u6Qv7qfel2XQY2z6YMDU7c/aQpQKHG2Y7/lVm77k0J5koG?=
 =?us-ascii?Q?Esh7RIuMjCtl6LrYMumKvAeKWflZlXdSs9epFPxyUEb3WFlbWXPPo+DF1YM6?=
 =?us-ascii?Q?xaYtJCwAC7cOwOJKzNso8HmkOxfsF92DASnogBH+i3adnHTXdatyHt+gOtUL?=
 =?us-ascii?Q?65VqHZ6kyoj3lquSs+wE5bCbfpx4Q3y3ETQ+k184ZVAV9yFPsqi01/zx6eYI?=
 =?us-ascii?Q?l/SBaLFTaqqMEANvB0M+3SMKzV4GlmTeo5Nl29iuFQWHsh3xxoYghEzzBxxS?=
 =?us-ascii?Q?UJf4pRYSAtVWB52TUaevOXMuzdbA/22fe50OrJhkNBaIOurDRUX3zpt4QoZz?=
 =?us-ascii?Q?LDHbMjUNNUb5196x0FW9rJTvvvCi3gVUrDWBV5LUbjlVFXdXKa2SZPJnXz8u?=
 =?us-ascii?Q?CYkEjVcrOsP634K4ar0ODLgDhkg6g4DJIR/7NeLO7YTeQcmRRXpNCq5BzCZk?=
 =?us-ascii?Q?cx8IHFSjnXgNcbyQcDrVol4EiW9clqGqLLxUju6U1jvwAx/kOzhAxwpfX2zZ?=
 =?us-ascii?Q?ENHPJhvEIJ7hlkNERYs4mo9GVusiEnJLWqWFrAbZA0qSYc1kw4B8+riK/iA1?=
 =?us-ascii?Q?JPuLPK0v6CA8yXtWVudFfBlgYLGVWO79pYv1bvaDOqgS0pASa6VlurGV0/1A?=
 =?us-ascii?Q?kEHOIo2WOVfVUQd9QOUw0ITmT683hFb2Tj5wIVy761xJ2ug7lr0YoymzqF1U?=
 =?us-ascii?Q?su9J1HcGpTXlLer7cMZBGnKW?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bab6bf3a-0711-4a11-d251-08d939ee84b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2021 04:38:03.9330 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EZN3cwYeNW0ZR9CqCh78Tt2PscDIvt2Oe4w3r2GWYl44PbR4cBwgI2Fm3aKlihxwA9uR+ve6wY/ePn1GFOqVGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5259
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
Content-Type: multipart/mixed; boundary="===============0438239728=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0438239728==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN9PR12MB5257B09D8AE246206A1AC3CFFC039BN9PR12MB5257namp_"

--_000_BN9PR12MB5257B09D8AE246206A1AC3CFFC039BN9PR12MB5257namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]

Add @Min, Frank<mailto:Frank.Min@amd.com> for the review.

Regards,
Hawking

From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Wang, Ke=
vin(Yang)
Sent: Monday, June 28, 2021 10:44
To: Lazar, Lijo <Lijo.Lazar@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Chri=
stian.Koenig@amd.com>
Subject: Re: [PATCH] drm/amdgpu: add non-aligned address supported in amdgp=
u_device_vram_access()


[AMD Official Use Only]


[AMD Official Use Only]



________________________________
From: Lazar, Lijo <Lijo.Lazar@amd.com<mailto:Lijo.Lazar@amd.com>>
Sent: Friday, June 25, 2021 9:28 PM
To: Wang, Kevin(Yang) <Kevin1.Wang@amd.com<mailto:Kevin1.Wang@amd.com>>; am=
d-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org> <amd-gfx@=
lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com<mailto:Alexander.Deucher@=
amd.com>>; Koenig, Christian <Christian.Koenig@amd.com<mailto:Christian.Koe=
nig@amd.com>>
Subject: Re: [PATCH] drm/amdgpu: add non-aligned address supported in amdgp=
u_device_vram_access()



On 6/25/2021 8:54 AM, Kevin Wang wrote:
> 1. add non-aligned address support in amdgpu_device_vram_access()
> 2. reduce duplicate code in amdgpu_ttm_access_memory()
>
> because the MM_INDEX{HI}/DATA are protected register, it is not working
> in sriov environment when mmio protect feature is enabled (in some asics)=
,
> and the old function amdgpu_ttm_access_memory() will force using MM_INDEX=
/DATA
> to handle non-aligned address by default, it will cause the register(MM_D=
ATA)
> is always return 0.
>
> with the patch, the memory will be accessed in the aper way first.
> (in visible memory or enable pcie large-bar feature), then using
> MM_INDEX{HI}/MM_DATA to access rest vram memroy.
>
> Signed-off-by: Kevin Wang <kevin1.wang@amd.com<mailto:kevin1.wang@amd.com=
>>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 69 ++++++++++++++++------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c    | 42 ++-----------
>   3 files changed, 58 insertions(+), 55 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/am=
dgpu/amdgpu.h
> index d14b4968a026..8095d9a9c857 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1103,7 +1103,7 @@ void amdgpu_device_fini(struct amdgpu_device *adev)=
;
>   int amdgpu_gpu_wait_for_idle(struct amdgpu_device *adev);
>
>   void amdgpu_device_vram_access(struct amdgpu_device *adev, loff_t pos,
> -                            uint32_t *buf, size_t size, bool write);
> +                            void *buf, size_t size, bool write);
>   uint32_t amdgpu_device_rreg(struct amdgpu_device *adev,
>                            uint32_t reg, uint32_t acc_flags);
>   void amdgpu_device_wreg(struct amdgpu_device *adev,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index e6702d136a6d..2047e3c2b365 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -280,6 +280,54 @@ bool amdgpu_device_supports_smart_shift(struct drm_d=
evice *dev)
>                amdgpu_acpi_is_power_shift_control_supported());
>   }
>
> +static inline void amdgpu_device_vram_mmio_align_access_locked(struct am=
dgpu_device *adev, loff_t pos,
> +                                                            uint32_t *va=
lue, bool write)
> +{
> +     BUG_ON(!IS_ALIGNED(pos, 4));
> +
> +     WREG32_NO_KIQ(mmMM_INDEX, ((uint32_t)pos) | 0x80000000);
> +     WREG32_NO_KIQ(mmMM_INDEX_HI, pos >> 31);
> +     if (write)
> +             WREG32_NO_KIQ(mmMM_DATA, *value);
> +     else
> +             *value =3D RREG32_NO_KIQ(mmMM_DATA);
> +}
> +
> +static void amdgpu_device_vram_mmio_access_locked(struct amdgpu_device *=
adev, loff_t pos,
> +                                               void *buf, size_t size, b=
ool write)
> +{
> +     while (size) {
> +             uint64_t aligned_pos =3D ALIGN_DOWN(pos, 4);
> +             uint64_t bytes =3D 4 - (pos & 0x3);
> +             uint32_t shift =3D (pos & 0x3) * 8;
> +             uint32_t mask =3D 0xffffffff << shift;
> +             uint32_t value =3D 0;
> +
> +             if (size < bytes) {
> +                     mask &=3D 0xffffffff >> (bytes - size) * 8;
> +                     bytes =3D size;
> +             }
> +
> +             if (mask !=3D 0xffffffff) {
> +                     amdgpu_device_vram_mmio_align_access_locked(adev, a=
ligned_pos, &value, false);
> +                     if (write) {
> +                             value &=3D ~mask;
> +                             value |=3D (*(uint32_t *)buf << shift) & ma=
sk;
> +                             amdgpu_device_vram_mmio_align_access_locked=
(adev, aligned_pos, &value, true);
> +                     } else {
> +                             value =3D (value & mask) >> shift;
> +                             memcpy(buf, &value, bytes);
> +                     }
> +             } else {
> +                     amdgpu_device_vram_mmio_align_access_locked(adev, a=
ligned_pos, buf, write);
> +             }
> +
> +             pos +=3D bytes;
> +             buf +=3D bytes;
> +             size -=3D bytes;
> +     }
> +}
> +
>   /*
>    * VRAM access helper functions
>    */
> @@ -294,13 +342,11 @@ bool amdgpu_device_supports_smart_shift(struct drm_=
device *dev)
>    * @write: true - write to vram, otherwise - read from vram
>    */
>   void amdgpu_device_vram_access(struct amdgpu_device *adev, loff_t pos,
> -                            uint32_t *buf, size_t size, bool write)
> +                            void *buf, size_t size, bool write)
>   {
>        unsigned long flags;
> -     uint32_t hi =3D ~0;
>        uint64_t last;
>
> -
>   #ifdef CONFIG_64BIT
>        last =3D min(pos + size, adev->gmc.visible_vram_size);
>        if (last > pos) {
> @@ -321,25 +367,12 @@ void amdgpu_device_vram_access(struct amdgpu_device=
 *adev, loff_t pos,
>                        return;
>
>                pos +=3D count;
> -             buf +=3D count / 4;
> +             buf +=3D count;
>                size -=3D count;
>        }
>   #endif
> -
>        spin_lock_irqsave(&adev->mmio_idx_lock, flags);
> -     for (last =3D pos + size; pos < last; pos +=3D 4) {
> -             uint32_t tmp =3D pos >> 31;
> -
> -             WREG32_NO_KIQ(mmMM_INDEX, ((uint32_t)pos) | 0x80000000);
> -             if (tmp !=3D hi) {
> -                     WREG32_NO_KIQ(mmMM_INDEX_HI, tmp);
> -                     hi =3D tmp;
> -             }
> -             if (write)
> -                     WREG32_NO_KIQ(mmMM_DATA, *buf++);
> -             else
> -                     *buf++ =3D RREG32_NO_KIQ(mmMM_DATA);
> -     }
> +     amdgpu_device_vram_mmio_access_locked(adev, pos, buf, size, write);
>        spin_unlock_irqrestore(&adev->mmio_idx_lock, flags);
>   }
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_ttm.c
> index 6297363ab740..cf5b8bdc2dd3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -1430,8 +1430,6 @@ static int amdgpu_ttm_access_memory(struct ttm_buff=
er_object *bo,
>        struct amdgpu_bo *abo =3D ttm_to_amdgpu_bo(bo);
>        struct amdgpu_device *adev =3D amdgpu_ttm_adev(abo->tbo.bdev);
>        struct amdgpu_res_cursor cursor;
> -     unsigned long flags;
> -     uint32_t value =3D 0;
>        int ret =3D 0;
>
>        if (bo->mem.mem_type !=3D TTM_PL_VRAM)
> @@ -1439,41 +1437,13 @@ static int amdgpu_ttm_access_memory(struct ttm_bu=
ffer_object *bo,
>
>        amdgpu_res_first(&bo->mem, offset, len, &cursor);
>        while (cursor.remaining) {
> -             uint64_t aligned_pos =3D cursor.start & ~(uint64_t)3;
> -             uint64_t bytes =3D 4 - (cursor.start & 3);
> -             uint32_t shift =3D (cursor.start & 3) * 8;
> -             uint32_t mask =3D 0xffffffff << shift;
> -
> -             if (cursor.size < bytes) {
> -                     mask &=3D 0xffffffff >> (bytes - cursor.size) * 8;
> -                     bytes =3D cursor.size;
> -             }
> +             amdgpu_device_vram_access(adev, cursor.start,
> +                                       buf, cursor.size,
> +                                       write);
>
> -             if (mask !=3D 0xffffffff) {
> -                     spin_lock_irqsave(&adev->mmio_idx_lock, flags);

The new logic seems to skip this mmio_idx_lock for accessing index/data
pair ragisters. BTW, where is the visible memory aperture check?

Thanks
Lijo

[Keivn]:

Hi Lijo,
the mmio_idx_lock lock is in amdgpu_device_vram_access() function.
this patch is extending the amdgpu_device_vram_access() function to support=
 un-aligned address support.

Best Regards,
Kevin
> -                     WREG32_NO_KIQ(mmMM_INDEX, ((uint32_t)aligned_pos) |=
 0x80000000);
> -                     WREG32_NO_KIQ(mmMM_INDEX_HI, aligned_pos >> 31);
> -                     value =3D RREG32_NO_KIQ(mmMM_DATA);
> -                     if (write) {
> -                             value &=3D ~mask;
> -                             value |=3D (*(uint32_t *)buf << shift) & ma=
sk;
> -                             WREG32_NO_KIQ(mmMM_DATA, value);
> -                     }
> -                     spin_unlock_irqrestore(&adev->mmio_idx_lock, flags)=
;
> -                     if (!write) {
> -                             value =3D (value & mask) >> shift;
> -                             memcpy(buf, &value, bytes);
> -                     }
> -             } else {
> -                     bytes =3D cursor.size & ~0x3ULL;
> -                     amdgpu_device_vram_access(adev, cursor.start,
> -                                               (uint32_t *)buf, bytes,
> -                                               write);
> -             }
> -
> -             ret +=3D bytes;
> -             buf =3D (uint8_t *)buf + bytes;
> -             amdgpu_res_next(&cursor, bytes);
> +             ret +=3D cursor.size;
> +             buf +=3D cursor.size;
> +             amdgpu_res_next(&cursor, cursor.size);
>        }
>
>        return ret;
>

--_000_BN9PR12MB5257B09D8AE246206A1AC3CFFC039BN9PR12MB5257namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]--><style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"Segoe UI";
	panose-1:2 11 5 2 4 2 4 2 2 3;}
@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
span.EmailStyle18
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
p.msipheadera4477989, li.msipheadera4477989, div.msipheadera4477989
	{mso-style-name:msipheadera4477989;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word">
<div class=3D"WordSection1">
<p class=3D"msipheadera4477989" style=3D"margin:0in"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:blue">[AMD Officia=
l Use Only]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Add <a id=3D"OWAAMDA9AF45685224723937B701A2538F4CE" =
href=3D"mailto:Frank.Min@amd.com">
<span style=3D"font-family:&quot;Calibri&quot;,sans-serif;text-decoration:n=
one">@Min, Frank</span></a> for the review.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Regards,<br>
Hawking<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> amd-gfx &lt;amd-gfx-bounces@lists.freed=
esktop.org&gt;
<b>On Behalf Of </b>Wang, Kevin(Yang)<br>
<b>Sent:</b> Monday, June 28, 2021 10:44<br>
<b>To:</b> Lazar, Lijo &lt;Lijo.Lazar@amd.com&gt;; amd-gfx@lists.freedeskto=
p.org<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Koenig, Ch=
ristian &lt;Christian.Koenig@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: add non-aligned address supported i=
n amdgpu_device_vram_access()<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p style=3D"margin:15.0pt"><span style=3D"font-size:10.0pt;font-family:&quo=
t;Arial&quot;,sans-serif;color:blue">[AMD Official Use Only]<o:p></o:p></sp=
an></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<p style=3D"margin:15.0pt"><span style=3D"font-size:10.0pt;font-family:&quo=
t;Arial&quot;,sans-serif;color:blue">[AMD Official Use Only]<o:p></o:p></sp=
an></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"color:black">From:</span></b><span=
 style=3D"color:black"> Lazar, Lijo &lt;<a href=3D"mailto:Lijo.Lazar@amd.co=
m">Lijo.Lazar@amd.com</a>&gt;<br>
<b>Sent:</b> Friday, June 25, 2021 9:28 PM<br>
<b>To:</b> Wang, Kevin(Yang) &lt;<a href=3D"mailto:Kevin1.Wang@amd.com">Kev=
in1.Wang@amd.com</a>&gt;;
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a> &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.=
freedesktop.org</a>&gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;<a href=3D"mailto:Alexander.Deucher@amd.c=
om">Alexander.Deucher@amd.com</a>&gt;; Koenig, Christian &lt;<a href=3D"mai=
lto:Christian.Koenig@amd.com">Christian.Koenig@amd.com</a>&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: add non-aligned address supported i=
n amdgpu_device_vram_access()</span>
<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"MsoNormal"><br>
<br>
On 6/25/2021 8:54 AM, Kevin Wang wrote:<br>
&gt; 1. add non-aligned address support in amdgpu_device_vram_access()<br>
&gt; 2. reduce duplicate code in amdgpu_ttm_access_memory()<br>
&gt; <br>
&gt; because the MM_INDEX{HI}/DATA are protected register, it is not workin=
g<br>
&gt; in sriov environment when mmio protect feature is enabled (in some asi=
cs),<br>
&gt; and the old function amdgpu_ttm_access_memory() will force using MM_IN=
DEX/DATA<br>
&gt; to handle non-aligned address by default, it will cause the register(M=
M_DATA)<br>
&gt; is always return 0.<br>
&gt; <br>
&gt; with the patch, the memory will be accessed in the aper way first.<br>
&gt; (in visible memory or enable pcie large-bar feature), then using<br>
&gt; MM_INDEX{HI}/MM_DATA to access rest vram memroy.<br>
&gt; <br>
&gt; Signed-off-by: Kevin Wang &lt;<a href=3D"mailto:kevin1.wang@amd.com">k=
evin1.wang@amd.com</a>&gt;<br>
&gt; ---<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu.h&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; |&nbsp; 2 +-<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 69 ++++++++++=
++++++------<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c&nbsp;&nbsp;&nbsp; =
| 42 ++-----------<br>
&gt;&nbsp;&nbsp; 3 files changed, 58 insertions(+), 55 deletions(-)<br>
&gt; <br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd=
/amdgpu/amdgpu.h<br>
&gt; index d14b4968a026..8095d9a9c857 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
&gt; @@ -1103,7 +1103,7 @@ void amdgpu_device_fini(struct amdgpu_device *ad=
ev);<br>
&gt;&nbsp;&nbsp; int amdgpu_gpu_wait_for_idle(struct amdgpu_device *adev);<=
br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; void amdgpu_device_vram_access(struct amdgpu_device *adev,=
 loff_t pos,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; uint32_t *buf, size_t size, bool write);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; void *buf, size_t size, bool write);<br>
&gt;&nbsp;&nbsp; uint32_t amdgpu_device_rreg(struct amdgpu_device *adev,<br=
>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; uint32_t reg, uint32_t acc_flags);<br>
&gt;&nbsp;&nbsp; void amdgpu_device_wreg(struct amdgpu_device *adev,<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_device.c<br>
&gt; index e6702d136a6d..2047e3c2b365 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt; @@ -280,6 +280,54 @@ bool amdgpu_device_supports_smart_shift(struct dr=
m_device *dev)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; amdgpu_acpi_is_power_shift_control_supported());<br>
&gt;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt; +static inline void amdgpu_device_vram_mmio_align_access_locked(struct=
 amdgpu_device *adev, loff_t pos,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t *valu=
e, bool write)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; BUG_ON(!IS_ALIGNED(pos, 4));<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; WREG32_NO_KIQ(mmMM_INDEX, ((uint32_t)pos) | =
0x80000000);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; WREG32_NO_KIQ(mmMM_INDEX_HI, pos &gt;&gt; 31=
);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (write)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; WREG32_NO_KIQ(mmMM_DATA, *value);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; *value =3D RREG32_NO_KIQ(mmMM_DATA);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void amdgpu_device_vram_mmio_access_locked(struct amdgpu_devic=
e *adev, loff_t pos,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void *buf, size_t=
 size, bool write)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; while (size) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; uint64_t aligned_pos =3D ALIGN_DOWN(pos, 4);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; uint64_t bytes =3D 4 - (pos &amp; 0x3);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; uint32_t shift =3D (pos &amp; 0x3) * 8;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; uint32_t mask =3D 0xffffffff &lt;&lt; shift;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; uint32_t value =3D 0;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (size &lt; bytes) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mask &amp;=3D 0xfffffff=
f &gt;&gt; (bytes - size) * 8;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bytes =3D size;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; }<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (mask !=3D 0xffffffff) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_vram_mmio=
_align_access_locked(adev, aligned_pos, &amp;value, false);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (write) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; value &amp;=3D ~mask;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; value |=3D (*(uint32_t *)buf &lt;&lt; shift) &amp;=
 mask;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_vram_mmio_align_access_locked(adev, =
aligned_pos, &amp;value, true);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; value =3D (value &amp; mask) &gt;&gt; shift;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; memcpy(buf, &amp;value, bytes);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; } else {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_vram_mmio=
_align_access_locked(adev, aligned_pos, buf, write);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; }<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; pos +=3D bytes;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; buf +=3D bytes;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; size -=3D bytes;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +}<br>
&gt; +<br>
&gt;&nbsp;&nbsp; /*<br>
&gt;&nbsp;&nbsp;&nbsp; * VRAM access helper functions<br>
&gt;&nbsp;&nbsp;&nbsp; */<br>
&gt; @@ -294,13 +342,11 @@ bool amdgpu_device_supports_smart_shift(struct d=
rm_device *dev)<br>
&gt;&nbsp;&nbsp;&nbsp; * @write: true - write to vram, otherwise - read fro=
m vram<br>
&gt;&nbsp;&nbsp;&nbsp; */<br>
&gt;&nbsp;&nbsp; void amdgpu_device_vram_access(struct amdgpu_device *adev,=
 loff_t pos,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; uint32_t *buf, size_t size, bool write)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; void *buf, size_t size, bool write)<br>
&gt;&nbsp;&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long flags;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; uint32_t hi =3D ~0;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t last;<br>
&gt;&nbsp;&nbsp; <br>
&gt; -<br>
&gt;&nbsp;&nbsp; #ifdef CONFIG_64BIT<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; last =3D min(pos + size, ade=
v-&gt;gmc.visible_vram_size);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (last &gt; pos) {<br>
&gt; @@ -321,25 +367,12 @@ void amdgpu_device_vram_access(struct amdgpu_dev=
ice *adev, loff_t pos,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;=
<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; pos +=3D count;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; buf +=3D count / 4;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; buf +=3D count;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; size -=3D count;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; #endif<br>
&gt; -<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spin_lock_irqsave(&amp;adev-=
&gt;mmio_idx_lock, flags);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; for (last =3D pos + size; pos &lt; last; pos=
 +=3D 4) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; uint32_t tmp =3D pos &gt;&gt; 31;<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; WREG32_NO_KIQ(mmMM_INDEX, ((uint32_t)pos) | 0x80000000);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (tmp !=3D hi) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_NO_KIQ(mmMM_INDE=
X_HI, tmp);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hi =3D tmp;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; }<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (write)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_NO_KIQ(mmMM_DATA=
, *buf++);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; else<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *buf++ =3D RREG32_NO_KI=
Q(mmMM_DATA);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_vram_mmio_access_locked(adev, =
pos, buf, size, write);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spin_unlock_irqrestore(&amp;=
adev-&gt;mmio_idx_lock, flags);<br>
&gt;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_ttm.c<br>
&gt; index 6297363ab740..cf5b8bdc2dd3 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c<br>
&gt; @@ -1430,8 +1430,6 @@ static int amdgpu_ttm_access_memory(struct ttm_b=
uffer_object *bo,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_bo *abo =3D tt=
m_to_amdgpu_bo(bo);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =
=3D amdgpu_ttm_adev(abo-&gt;tbo.bdev);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_res_cursor cur=
sor;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; unsigned long flags;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; uint32_t value =3D 0;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (bo-&gt;mem.mem_type !=3D=
 TTM_PL_VRAM)<br>
&gt; @@ -1439,41 +1437,13 @@ static int amdgpu_ttm_access_memory(struct ttm=
_buffer_object *bo,<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_res_first(&amp;bo-&gt=
;mem, offset, len, &amp;cursor);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; while (cursor.remaining) {<b=
r>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; uint64_t aligned_pos =3D cursor.start &amp; ~(uint64_t)3;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; uint64_t bytes =3D 4 - (cursor.start &amp; 3);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; uint32_t shift =3D (cursor.start &amp; 3) * 8;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; uint32_t mask =3D 0xffffffff &lt;&lt; shift;<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (cursor.size &lt; bytes) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mask &amp;=3D 0xfffffff=
f &gt;&gt; (bytes - cursor.size) * 8;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bytes =3D cursor.size;<=
br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; }<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; amdgpu_device_vram_access(adev, cursor.start,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; buf, cursor.size,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; write);<br>
&gt;&nbsp;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (mask !=3D 0xffffffff) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spin_lock_irqsave(&amp;=
adev-&gt;mmio_idx_lock, flags);<br>
<br>
The new logic seems to skip this mmio_idx_lock for accessing index/data <br=
>
pair ragisters. BTW, where is the visible memory aperture check?<br>
<br>
Thanks<br>
Lijo<o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Segoe UI&quot;,sans=
-serif;color:black">[Keivn]:</span><o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><o:p>&nbsp;</o:p></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Segoe UI&quot;,sans=
-serif;color:black">Hi Lijo,</span><o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Segoe UI&quot;,sans=
-serif;color:black">the mmio_idx_lock lock is in&nbsp;amdgpu_device_vram_ac=
cess() function.</span><o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Segoe UI&quot;,sans=
-serif;color:black">this patch is extending the&nbsp;amdgpu_device_vram_acc=
ess() function to support un-aligned address support.</span><o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
<div>
<p class=3D"MsoNormal">Best Regards,<o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal">Kevin<o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal">&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
WREG32_NO_KIQ(mmMM_INDEX, ((uint32_t)aligned_pos) | 0x80000000);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_NO_KIQ(mmMM_INDE=
X_HI, aligned_pos &gt;&gt; 31);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; value =3D RREG32_NO_KIQ=
(mmMM_DATA);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (write) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; value &amp;=3D ~mask;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; value |=3D (*(uint32_t *)buf &lt;&lt; shift) &amp;=
 mask;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; WREG32_NO_KIQ(mmMM_DATA, value);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spin_unlock_irqrestore(=
&amp;adev-&gt;mmio_idx_lock, flags);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!write) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; value =3D (value &amp; mask) &gt;&gt; shift;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; memcpy(buf, &amp;value, bytes);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; } else {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bytes =3D cursor.size &=
amp; ~0x3ULL;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_vram_acce=
ss(adev, cursor.start,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (uint32_t *)buf, =
bytes,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; write);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; }<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; ret +=3D bytes;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; buf =3D (uint8_t *)buf + bytes;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; amdgpu_res_next(&amp;cursor, bytes);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; ret +=3D cursor.size;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; buf +=3D cursor.size;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; amdgpu_res_next(&amp;cursor, cursor.size);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt; <o:p></o:p></p>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_BN9PR12MB5257B09D8AE246206A1AC3CFFC039BN9PR12MB5257namp_--

--===============0438239728==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0438239728==--
