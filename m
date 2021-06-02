Return-Path: <SRS0=QW4G=K4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 701F1C47083
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 10:02:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 347FB61263
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 10:02:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 347FB61263
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BBCD06E29D;
	Wed,  2 Jun 2021 10:02:35 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2063.outbound.protection.outlook.com [40.107.94.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 98E866E29D
 for <amd-gfx@freedesktop.org>; Wed,  2 Jun 2021 10:02:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YKr+9POkVn6wX52b2m6Bb8ivV+WT00P+tM6MXX1KAS4JLgJpsXUUkz5qdc+HWpGcntyEdPYB8kzRp3y6pnJlv9jwSynwrgj2CZyZnXtfgV7WUSUd2hFpm30bgLtnctm4qqhH6c0/lmM7Ngt39LGkirIFTlcr2xS+ry/6wSCjToXePGbgXE3wB5V0JDob3Q1zIhrqyY5XYPeTu9QxC/UJa8iy42NSDJXjwbUVUEvh82TY//oel8xKqw1518XkQl9myH2bknpTFOruYVfjUsOXYlH8rTF+5n90qOTDKGp29VgiSrg9yMEikzasiAhAHY8o2y+84dNW8s0NNzGRnCmGzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ss03Wk4G6WaDY7nsbdvW/Ae0cejXjkp1C4Ey7XkE0ao=;
 b=WcmbD+k3/h8Bo54hJnLJfVg2oJNo8VuOCPRZa/CxtU0xz7agdqOUvnIwqeYNhwJTxLPo36ploqA9nla7CYvBWVdHj1ZVst8mbrOgMPxTwOEY9c2SZurmRIS/IVCsXNdHUvyUm2501o/Y3aavVYpzFgO3dSKHbA1y5WEs8dikn0cRnwLopW2fHWW2yJhtYVhEuWQchsNt+pDhhPg6bPVo3kzbBfbqNvNPMcMyBctSqnSp3l517nqfrR7XNoRZENTH+at4WmAllkdTjySqUNti2o0wIQpT2wRt83dUDfEe36NU40EgYAteDPXgHcxvCLhCdlUX8SkUx0QaN99aCLBeWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ss03Wk4G6WaDY7nsbdvW/Ae0cejXjkp1C4Ey7XkE0ao=;
 b=wbjtg2B7VgvFEpHQkcM/BPAWajlm73XiTNIfuQ5BbvZS86Xb97Gtl1SIoCC3SsphjIvmXRN0htjnAggsZPtSF1Fz494aekX7TBx5cZd1B7InXreZ4cc9c7ePwDK5fzZvOAym9Xeq7rny6NmTxSdVzeSH5yyvzTb+VZjbIBKQ4OY=
Received: from MW2PR12MB4684.namprd12.prod.outlook.com (2603:10b6:302:13::29)
 by MWHPR12MB1295.namprd12.prod.outlook.com (2603:10b6:300:11::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20; Wed, 2 Jun
 2021 10:02:31 +0000
Received: from MW2PR12MB4684.namprd12.prod.outlook.com
 ([fe80::14db:e180:2a16:1b2a]) by MW2PR12MB4684.namprd12.prod.outlook.com
 ([fe80::14db:e180:2a16:1b2a%3]) with mapi id 15.20.4173.030; Wed, 2 Jun 2021
 10:02:31 +0000
From: "Zhu, Changfeng" <Changfeng.Zhu@amd.com>
To: =?iso-8859-1?Q?Christian_K=F6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>, "Das, Nirmoy"
 <Nirmoy.Das@amd.com>, "Huang, Ray" <Ray.Huang@amd.com>,
 "amd-gfx@freedesktop.org" <amd-gfx@freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: take back kvmalloc_array for entries alloc
 because of kzalloc memory limit
Thread-Topic: [PATCH] drm/amdgpu: take back kvmalloc_array for entries alloc
 because of kzalloc memory limit
Thread-Index: AQHXV4mPuxNBQdFAekWk59CNPpxBL6sAaqYAgAAA2QCAAAGFoIAACpyAgAAFyQA=
Date: Wed, 2 Jun 2021 10:02:31 +0000
Message-ID: <MW2PR12MB4684C723D0DFA3213EAC2C69FD3D9@MW2PR12MB4684.namprd12.prod.outlook.com>
References: <20210602083017.2335-1-Changfeng.Zhu@amd.com>
 <c9c3817a-ddd5-d73e-5a5b-fb3ad25d8ddc@amd.com>
 <9a3adb34-031e-9742-d165-cb6f36c91063@amd.com>
 <MW2PR12MB4684CB6391DA014F76CC9C46FD3D9@MW2PR12MB4684.namprd12.prod.outlook.com>
 <59cb9004-e1e6-dd51-0c32-7c03d715009c@gmail.com>
In-Reply-To: <59cb9004-e1e6-dd51-0c32-7c03d715009c@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-06-02T10:02:26Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=20136f12-ab59-440d-bf03-8592b86e4de5;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.134.244]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c19b250d-ce46-4f2e-326c-08d925ad8990
x-ms-traffictypediagnostic: MWHPR12MB1295:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR12MB129568E88069BA20F71342FCFD3D9@MWHPR12MB1295.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: p09flZlGa4V456PkrA4Z+vu9CExlob+HzI4wMZ0fYiGYacVvBb+etgwfAz7hzaFgjpGkITJQYQ77tQOFTJY4XmBJykjjylQHPGFpt6PJRryAaLgWKMcvuVDpn+Ajeyn9Yecci70lAyateX1JLy+ZgU3ymg3niiAw3iP0aF2s2JSHGvRKxtAr+HyWeKKj6GDIdXPZ6FmNCHgxvnrownz77A4A1YrvpzogP9lA4jS6kSYBLoAbgn2CxXpTwJUPXnQ3pVtE02zvUR9N+l6yNcJdDTCnPd8Kf3lZtTHweySDt/hO8cd9khgKWgH+jy0jzKjYv3Z8j+BGESwqpu46Rqk3u+grG49l/OuX59gmqG/v/41QjwME8UCoITIsNFdS/YF6wkiPjavgLgKrDqDvUaS/N2z/m98zfZBAA/9fW4gRSJQzLQjeCuIezO1PFpTGX8l0FFAbfcg8jTT/uv0PhB0e5+c8FnBmwbr+blKYVMTIsnG6qsHPOdlsgce82aA+ytPZybWGa3f4e+hi0a5RPzSc6muDTOwLhEFhI73LkrzmE9CcMssYcQHeJ3GwIe26Ah2tfhNwkquUt7Q2brLurzieJ4RHyikf8To0oQlBbnIxWazBUrSHvwNT0m1Lx3c9GAbzXL4bHV/JmxMIUKauLpXB/R8jAEZj85K4q+Qt06+eXIHWZzrynHBGR7r32jz8SOXVA9xMNlA9RxVKe86g5OmTum9r5bODWLQB04vlTUr95jc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4684.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(346002)(396003)(376002)(39860400002)(45080400002)(83380400001)(52536014)(966005)(478600001)(2906002)(316002)(64756008)(71200400001)(8936002)(66556008)(26005)(7696005)(38100700002)(76116006)(55016002)(66476007)(8676002)(110136005)(66574015)(86362001)(186003)(9686003)(66446008)(66946007)(5660300002)(122000001)(53546011)(33656002)(6506007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?qK961LwLkZbPe31moHJQoPxs5vEjk2xIkrNExqCbzceYAAWwQ7w0C/ry12?=
 =?iso-8859-1?Q?Iv08Z1kg//MWN9of+tfP7vgiHC1+YkwDFSfEb2EUeDgPDzTMkaT7yynYO2?=
 =?iso-8859-1?Q?9PvgpTsJCMRov6sSHobRsWUKxYSh/2l8c8RINaZTvCWWSrlyV0JODCgF//?=
 =?iso-8859-1?Q?GfuGFavLl9np6GY+Qhxm1FbGAjGdh4PDqyMcQBDHFnuIvEvI5o8HsuP79W?=
 =?iso-8859-1?Q?Kqzt94HGF72nMI6GJHvTTpQFiUY5oUGQWsd+KYCCK1CjTcJT8lb/6I0+VN?=
 =?iso-8859-1?Q?SGlEXBOBsgEkZ9eCnp1urG4JiZU1yQTCKXR1ggdhxw2wxDJxqnaKIyKjz4?=
 =?iso-8859-1?Q?jERKkfwHBxiO58w8/wuSo8FULUU9XgnXCGKjd1v5zSw5BUHvvLbMfCVqa2?=
 =?iso-8859-1?Q?kpuOoJV2gWJ+0w4wOSiiBBa9kcDmqkzsW1HJ8TFhDXuL3EVhFtvpjohYHt?=
 =?iso-8859-1?Q?6zgbGj54+1reszAKSzF63Npb5cxRR24jZhokPp8Ast1wKfNdkbNkXUQ+Ki?=
 =?iso-8859-1?Q?/ocfnm0BV8mvce9XVbfg+KOsXy8cP7rVI31lE2kmifefzJSeVoPPdr/w3k?=
 =?iso-8859-1?Q?Qv/tb/peh3//oCmuVv4uHBUHpZkjQFXPC9LWKN25iGw3vMbhWznnR2vc6p?=
 =?iso-8859-1?Q?G1UchM41Bikr0aAdfqLw3RXVtSeURJnv3ZhD3sRoq2+iTZwwSiOmJB0NR0?=
 =?iso-8859-1?Q?RtwIjoLgTTQqbhRMAaDTliPhITMAuB44kLIzBpyY5CNjMYxsbKHpNJYdWI?=
 =?iso-8859-1?Q?zJngXDSmWUPHgWnT8fdpjL2Rz34imf9U6JPlQpsTMKcCNE9tG2qrNuUTqx?=
 =?iso-8859-1?Q?fmNUucPAI5m1wG4cuXpZCa6bUhy4UYvh1Xx/msFP3S91Tq30ZuRpdAVwax?=
 =?iso-8859-1?Q?MXmUT1USD3IQfxsYs62ylNUOsTtMwRxZKqXhe/h5aWNqNffwT0e1TiOR8B?=
 =?iso-8859-1?Q?u5+XP1w/4i0uZZJ2h/ZfnsuzUbr4RewqJ01T3P5m/kkuWDwD/iFdsvc9TA?=
 =?iso-8859-1?Q?6F4j3dJIiusegtRcqpA7py5CtSjc+3x1Wm8y+2z+pc4eOSWD06CQ0nJy/7?=
 =?iso-8859-1?Q?C2GNKTyTO++d3ct7JlhS12tNBk0FimRmLIk687GBHfwOvSXIh5x3IoB/aP?=
 =?iso-8859-1?Q?iHSBvlbu5lqqZit7yKHx2+AWyJ8GcNZpmkmSbhlIPxfVprydy4n9aT1K2m?=
 =?iso-8859-1?Q?Cvcr3haeWfpR4yVnXDXBd1ZqO/ifgpNDMx1T3ZjGswuxeDqUlTDo4GTLzB?=
 =?iso-8859-1?Q?Mb0tdFL2+8Sw4NGrTzhGYV6ta4Qhrk6xp8k2mWUxweIAvJsxjbOiZQbGmd?=
 =?iso-8859-1?Q?oQRzopkVH0ttrQilOMSsA6m/tv+gHsVqXpFItoNwnJ0938DSWI5TgTt4LF?=
 =?iso-8859-1?Q?X58cO3HjWM?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4684.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c19b250d-ce46-4f2e-326c-08d925ad8990
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2021 10:02:31.2946 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3UEOLrNydwQthhJPW14+xtn05NIYwJ5IHCJbg+FCcBNJuZLETZZg6kqwhbHKr6mddsk50OnShOJ+OpslGMaQ9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1295
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

OK.

Thx, Chris and Das.

I'll try it and verify whether there are issues.

BR,
Changfeng.

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Christia=
n K=F6nig
Sent: Wednesday, June 2, 2021 5:41 PM
To: Zhu, Changfeng <Changfeng.Zhu@amd.com>; Koenig, Christian <Christian.Ko=
enig@amd.com>; Das, Nirmoy <Nirmoy.Das@amd.com>; Huang, Ray <Ray.Huang@amd.=
com>; amd-gfx@freedesktop.org
Subject: Re: [PATCH] drm/amdgpu: take back kvmalloc_array for entries alloc=
 because of kzalloc memory limit

Hi Changfeng,

well that's a funny mix-up :)

The flags describe the backing store requirements, e.g. caching, contiguous=
 etc etc...

But the allocation if for the housekeeping structure inside the kernel and =
is not related to the backing store of this BO.

Just switching the BO structure to be allocated using kvzalloc/kvfree shoul=
d be enough.

Thanks,
Christian.

Am 02.06.21 um 11:10 schrieb Zhu, Changfeng:
> [AMD Official Use Only]
>
> Hi Chris,
>
> Actually, I think about switching kzalloc to kvmalloc in amdgpu_bo_create.
> However, I observe bp.flags =3D AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS in amdg=
pu_vm_pt_create.
>
> Does it matter we switch kzalloc to kvmalloc if there is a physical conti=
nuous memory request when creating bo? Such as AMDGPU_GEM_CREATE_VRAM_CONTI=
GUOUS?
>
> BR,
> Changfeng.
>
>
>
> -----Original Message---
> From: Koenig, Christian <Christian.Koenig@amd.com>
> Sent: Wednesday, June 2, 2021 4:57 PM
> To: Das, Nirmoy <Nirmoy.Das@amd.com>; Zhu, Changfeng =

> <Changfeng.Zhu@amd.com>; Huang, Ray <Ray.Huang@amd.com>; =

> amd-gfx@freedesktop.org
> Subject: Re: [PATCH] drm/amdgpu: take back kvmalloc_array for entries =

> alloc because of kzalloc memory limit
>
>
>
> Am 02.06.21 um 10:54 schrieb Das, Nirmoy:
>> On 6/2/2021 10:30 AM, Changfeng wrote:
>>> From: changzhu <Changfeng.Zhu@amd.com>
>>>
>>> From: Changfeng <Changfeng.Zhu@amd.com>
>>>
>>> It will cause error when alloc memory larger than 128KB in =

>>> amdgpu_bo_create->kzalloc.
>>
>> I wonder why I didn't see the error on my machine. Is there any =

>> config I might be missing ?
> VM page table layout depends on hardware generation, APU vs dGPU and kern=
el command line settings.
>
> I think we just need to switch amdgpu_bo_create() from kzalloc to kvmallo=
c (and kfree to kvfree in amdgpu_bo_destroy of course).
>
> Shouldn't be more than a two line patch.
>
> Regards,
> Christian.
>
>>
>> Thanks,
>>
>> Nirmoy
>>
>>> Call Trace:
>>>  =A0=A0=A0 alloc_pages_current+0x6a/0xe0
>>>  =A0=A0=A0 kmalloc_order+0x32/0xb0
>>>  =A0=A0=A0 kmalloc_order_trace+0x1e/0x80
>>>  =A0=A0=A0 __kmalloc+0x249/0x2d0
>>>  =A0=A0=A0 amdgpu_bo_create+0x102/0x500 [amdgpu]
>>>  =A0=A0=A0 ? xas_create+0x264/0x3e0
>>>  =A0=A0=A0 amdgpu_bo_create_vm+0x32/0x60 [amdgpu]
>>>  =A0=A0=A0 amdgpu_vm_pt_create+0xf5/0x260 [amdgpu]
>>>  =A0=A0=A0 amdgpu_vm_init+0x1fd/0x4d0 [amdgpu]
>>>
>>> Change-Id: I29e479db45ead37c39449e856599fd4f6a0e34ce
>>> Signed-off-by: Changfeng <Changfeng.Zhu@amd.com>
>>> ---
>>>  =A0 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 27
>>> +++++++++++++++-----------
>>>  =A0 1 file changed, 16 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> index 1923f035713a..714d613d020b 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> @@ -894,6 +894,10 @@ static int amdgpu_vm_pt_create(struct =

>>> amdgpu_device *adev,
>>>  =A0=A0=A0=A0=A0=A0=A0=A0=A0 num_entries =3D 0;
>>>  =A0 =A0=A0=A0=A0=A0 bp.bo_ptr_size =3D struct_size((*vmbo), entries, =

>>> num_entries);
>>> +=A0=A0=A0 if (bp.bo_ptr_size > 32*AMDGPU_GPU_PAGE_SIZE) {
>>> +=A0=A0=A0=A0=A0=A0=A0 DRM_INFO("Can't alloc memory larger than 128KB b=
y using
>>> kzalloc in amdgpu_bo_create\n");
>>> +=A0=A0=A0=A0=A0=A0=A0 bp.bo_ptr_size =3D sizeof(struct amdgpu_bo_vm);
>>> +=A0=A0=A0 }
>>>  =A0 =A0=A0=A0=A0=A0 if (vm->use_cpu_for_update)
>>>  =A0=A0=A0=A0=A0=A0=A0=A0=A0 bp.flags |=3D AMDGPU_GEM_CREATE_CPU_ACCESS=
_REQUIRED;
>>> @@ -965,15 +969,19 @@ static int amdgpu_vm_alloc_pts(struct =

>>> amdgpu_device *adev,
>>>  =A0=A0=A0=A0=A0 struct amdgpu_bo_vm *pt;
>>>  =A0=A0=A0=A0=A0 int r;
>>>  =A0 -=A0=A0=A0 if (entry->base.bo) {
>>> -=A0=A0=A0=A0=A0=A0=A0 if (cursor->level < AMDGPU_VM_PTB)
>>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 entry->entries =3D
>>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 to_amdgpu_bo_vm(entry->b=
ase.bo)->entries;
>>> -=A0=A0=A0=A0=A0=A0=A0 else
>>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 entry->entries =3D NULL;
>>> -=A0=A0=A0=A0=A0=A0=A0 return 0;
>>> +=A0=A0=A0 if (cursor->level < AMDGPU_VM_PTB && !entry->entries) {
>>> +=A0=A0=A0=A0=A0=A0=A0 unsigned num_entries;
>>> +=A0=A0=A0=A0=A0=A0=A0 num_entries =3D amdgpu_vm_num_entries(adev, curs=
or->level);
>>> +=A0=A0=A0=A0=A0=A0=A0 entry->entries =3D kvmalloc_array(num_entries,
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
sizeof(*entry->entries),
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
GFP_KERNEL | __GFP_ZERO);
>>> +=A0=A0=A0=A0=A0=A0=A0 if (!entry->entries)
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -ENOMEM;
>>>  =A0=A0=A0=A0=A0 }
>>>  =A0 +=A0=A0=A0 if (entry->base.bo)
>>> +=A0=A0=A0=A0=A0=A0=A0 return 0;
>>> +
>>>  =A0=A0=A0=A0=A0 r =3D amdgpu_vm_pt_create(adev, vm, cursor->level, imm=
ediate, =

>>> &pt);
>>>  =A0=A0=A0=A0=A0 if (r)
>>>  =A0=A0=A0=A0=A0=A0=A0=A0=A0 return r;
>>> @@ -984,10 +992,6 @@ static int amdgpu_vm_alloc_pts(struct =

>>> amdgpu_device *adev,
>>>  =A0=A0=A0=A0=A0 pt_bo =3D &pt->bo;
>>>  =A0=A0=A0=A0=A0 pt_bo->parent =3D amdgpu_bo_ref(cursor->parent->base.b=
o);
>>>  =A0=A0=A0=A0=A0 amdgpu_vm_bo_base_init(&entry->base, vm, pt_bo);
>>> -=A0=A0=A0 if (cursor->level < AMDGPU_VM_PTB)
>>> -=A0=A0=A0=A0=A0=A0=A0 entry->entries =3D pt->entries;
>>> -=A0=A0=A0 else
>>> -=A0=A0=A0=A0=A0=A0=A0 entry->entries =3D NULL;
>>>  =A0 =A0=A0=A0=A0=A0 r =3D amdgpu_vm_clear_bo(adev, vm, pt, immediate);
>>>  =A0=A0=A0=A0=A0 if (r)
>>> @@ -1017,6 +1021,7 @@ static void amdgpu_vm_free_table(struct =

>>> amdgpu_vm_pt *entry)
>>>  =A0=A0=A0=A0=A0=A0=A0=A0=A0 amdgpu_bo_unref(&shadow);
>>>  =A0=A0=A0=A0=A0=A0=A0=A0=A0 amdgpu_bo_unref(&entry->base.bo);
>>>  =A0=A0=A0=A0=A0 }
>>> +=A0=A0=A0 kvfree(entry->entries);
>>>  =A0=A0=A0=A0=A0 entry->entries =3D NULL;
>>>  =A0 }
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flist
> s.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7CCh
> angfeng.Zhu%40amd.com%7Cd36c08795213458131a008d925aa7ed1%7C3dd8961fe48
> 84e608e11a82d994e183d%7C0%7C0%7C637582236475879048%7CUnknown%7CTWFpbGZ
> sb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3
> D%7C1000&amp;sdata=3D0TrtpWThdlCk8Pt5AvlFELrZhkXMqkY85KsPMSwEQf4%3D&amp;
> reserved=3D0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7CChangfen=
g.Zhu%40amd.com%7Cd36c08795213458131a008d925aa7ed1%7C3dd8961fe4884e608e11a8=
2d994e183d%7C0%7C0%7C637582236475879048%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4=
wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3D=
0TrtpWThdlCk8Pt5AvlFELrZhkXMqkY85KsPMSwEQf4%3D&amp;reserved=3D0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
