Return-Path: <SRS0=ouc1=Y7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC954C43331
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Nov 2019 18:02:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A26A32178F
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Nov 2019 18:02:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A26A32178F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6107F6F772;
	Thu,  7 Nov 2019 18:02:10 +0000 (UTC)
Received: from NAM05-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr720052.outbound.protection.outlook.com [40.107.72.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 224F26F771
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Nov 2019 18:02:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KoJrPFc6a4pieMFKoxYsPGE/rcip4lLw+WXn/79XHa1CG1seUGkDeh6T52VKVYVz7qkzv5ywMRsOW6Yk9b6rkE1RFYaWLwsTU/VAxTGIMVYwFxm0qcqKfy62xYRCDdgzOzSkiSbrReVRVulKNVEq4vr/OuKqpqcWip+Vd3iA55Ed3kiWPFWu/OkguMgucvUMCDQ4OO/5VNFA0c2Vz41CA3VdfWRd1eYdJ0jizqENdmZNWBhSQ+SwN6OL0RtQmVczZibhvsjLM3uwY1lqySaYK+jeLocYqflon6l/NsRLbEo68v1b7Ed/40NUzwkwh1UMjXLMvliLGvc76xzkC/5bEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9iMJR/f6qvJICOaULxrKdtGzHcCIi4SM2IYfYMz1dWo=;
 b=eRFsXaUmASh7sXcUb/KJ5555N6X+RpxHiZyG/DxgvCVO7cBLj1ICrBZZvhXNYKrt75NHMcsvfT7aIGfZyGzy/J7j3RBxm0eaPdqiq9k8RI8wWL4Mta5hxyOIZVnBvD8DcZrtS6sgKvhDUn+fXW9HLUvS5FtefmNHVkXbF/2fHYDfzVRMqtJtFYyHxu7TusSbN+FO8Ke0Nx/RLOGAdXr+03VUv2NBD2pSe2SnG8jR+o854ynsenvmGuUeaEIOX71zpioakdVO1QlosaVL5PPQzCPLhAVb9+OtmSWLgdumBzRsrQYFM12Yaqu2EfYakrQdIKBxav7vqXvaE1VKNrIUzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from BL0PR12MB2580.namprd12.prod.outlook.com (52.132.27.147) by
 BL0PR12MB2435.namprd12.prod.outlook.com (52.132.8.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.20; Thu, 7 Nov 2019 18:02:07 +0000
Received: from BL0PR12MB2580.namprd12.prod.outlook.com
 ([fe80::55f1:f8d5:e7d0:f595]) by BL0PR12MB2580.namprd12.prod.outlook.com
 ([fe80::55f1:f8d5:e7d0:f595%2]) with mapi id 15.20.2430.020; Thu, 7 Nov 2019
 18:02:07 +0000
From: "Zeng, Oak" <Oak.Zeng@amd.com>
To: "Zhao, Yong" <Yong.Zhao@amd.com>, Alex Deucher <alexdeucher@gmail.com>
Subject: RE: [PATCH] drm/amdgpu: Add comments to gmc structure
Thread-Topic: [PATCH] drm/amdgpu: Add comments to gmc structure
Thread-Index: AQHVlMdj9LKXevQ1Yk2iPklewez+uqd/vo0AgAA1ThSAAAZqEA==
Date: Thu, 7 Nov 2019 18:02:07 +0000
Message-ID:
 <BL0PR12MB25808E11A26B24C319F3121080780@BL0PR12MB2580.namprd12.prod.outlook.com>
References: <1573061209-13148-1-git-send-email-Oak.Zeng@amd.com>,
 <CADnq5_OinRnn+39TiX2SQkoBwwMPRO2vt0nTSLkwSBq-Mw2vBQ@mail.gmail.com>
 <DM6PR12MB2778E5EB97BBDE1FBFB3DA12F0780@DM6PR12MB2778.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB2778E5EB97BBDE1FBFB3DA12F0780@DM6PR12MB2778.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2607:fea8:3c80:2a5:1494:4858:7bdd:b07b]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 736e2530-0b01-4bfc-cdc8-08d763ac9aa8
x-ms-traffictypediagnostic: BL0PR12MB2435:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR12MB24356951B59E26A30A9A49E580780@BL0PR12MB2435.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 0214EB3F68
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(39860400002)(366004)(136003)(376002)(346002)(189003)(199004)(14454004)(229853002)(790700001)(71190400001)(6436002)(66556008)(486006)(46003)(476003)(4326008)(52536014)(11346002)(478600001)(446003)(6116002)(9686003)(71200400001)(54896002)(64756008)(53546011)(186003)(6506007)(86362001)(66446008)(6306002)(102836004)(316002)(5660300002)(606006)(99286004)(33656002)(55016002)(14444005)(236005)(74316002)(81166006)(81156014)(966005)(110136005)(76116006)(6246003)(54906003)(2906002)(66946007)(7736002)(66476007)(8936002)(25786009)(7696005)(76176011)(9326002)(8676002)(256004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BL0PR12MB2435;
 H:BL0PR12MB2580.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ekVfRYArlyvL4EOhoYRUs9LQNBtwsE5TyBPyWDK384kQAjm1ky05FOM7SOhaPqiHg0GIJPX6sCADulZ6Ir4M2Ej27pikZbmFDNcod1Q0UVu2SULAMaUl2S88OlTkUZ9ZiLZ4zuHplg3OIU2TPR498GcIsxp2q5mg/bTb5QSLSQTqYCTRHcarbdrlNWFeKsEeBA9wOC56RoZVvK0NMxobUO2mjh/K+Dhxvw2r+sYLHhdhf8ie01xbfFlIpS0H+1ND3mmWrMj+I5KjHVDRXp8MY4v1oXHh9932BWNqBnRwNJ+uIc00oL9WztWx8FsfPfgP4BbpfNdO3tBCzkwuHx8gXTl2Jutqq1QDmHkBsoe+HuW9Yt483hclhQ9GdWrmT0mUHcK3kdZptNyo+7GvLl77cO1VQVVld+4KdEKRCGzhx9WpEcRgIIHQtzcb0TVKLhyXexTMQlfJ6TlbL6TWhghnB7QpSryuRQjD3AC6dY1/wKs=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 736e2530-0b01-4bfc-cdc8-08d763ac9aa8
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2019 18:02:07.4194 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RsN4mGFnpvz5NbeDXo+xzqc69KgoJ0GtZzMwCjSrU0tNFuidLcGjjFL1gcExjx0r
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2435
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9iMJR/f6qvJICOaULxrKdtGzHcCIi4SM2IYfYMz1dWo=;
 b=wGsq/pEoVi+c5GmokgFNTu9vXp/NayVccudwQeLBTtVP/08EJXPjWPd1U5u8XOrj2OgA9cBRP9/lMBtXSO5qx+5zPdIfV0GburRDivcmKPjr0bufEWUxdhnE/DdbXtfd5fTrNtM5k0o66M5AOa4u5KavdAywWV+L+VVuobctILQ=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Oak.Zeng@amd.com; 
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: multipart/mixed; boundary="===============0008490919=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191107180207.3ka2VjW9P9bMKUY-AkxNneJIAygN0jgVoFcbLmcr-bw@z>

--===============0008490919==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BL0PR12MB25808E11A26B24C319F3121080780BL0PR12MB2580namp_"

--_000_BL0PR12MB25808E11A26B24C319F3121080780BL0PR12MB2580namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Yong,

That has been submitted.

MC address is the address sent to memory controller bus to address the phys=
ical memory. In many places it is also called physical address.

Logical address is the address before it is translated to physical address.=
 The translation can be either linear or through page table. Under VMID0, l=
ogical address of some apertures (AGP, FB) are linearly mapped to MC addres=
s. (I think in our driver implementation, logical address =3D=3D MC address=
). But Gart aperture is mapped through gpuvm (gart) page table - the mapped=
 address can also be called virtual address.

Under VMID1~15, it is user space virtual address (can also be called logica=
l address), mapped through gpuvm page tables.

So virtual address is one type of logical address. Virtual address is usual=
ly mapped through page table/vm.

Just my understanding.

Regards,
Oak

From: Zhao, Yong <Yong.Zhao@amd.com>
Sent: Thursday, November 7, 2019 12:16 PM
To: Alex Deucher <alexdeucher@gmail.com>; Zeng, Oak <Oak.Zeng@amd.com>
Cc: Kuehling, Felix <Felix.Kuehling@amd.com>; Koenig, Christian <Christian.=
Koenig@amd.com>; amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH] drm/amdgpu: Add comments to gmc structure

If this is not submitted, I would like to see some comments regarding the e=
xplanation of MC address and logical address, which I prefer to mention as =
GPU physical/virtual address.

Regards,
Yong


________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org<mailto:amd-gfx-bounces=
@lists.freedesktop.org>> on behalf of Alex Deucher <alexdeucher@gmail.com<m=
ailto:alexdeucher@gmail.com>>
Sent: Thursday, November 7, 2019 9:02 AM
To: Zeng, Oak <Oak.Zeng@amd.com<mailto:Oak.Zeng@amd.com>>
Cc: Kuehling, Felix <Felix.Kuehling@amd.com<mailto:Felix.Kuehling@amd.com>>=
; Koenig, Christian <Christian.Koenig@amd.com<mailto:Christian.Koenig@amd.c=
om>>; amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org> <=
amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>>
Subject: Re: [PATCH] drm/amdgpu: Add comments to gmc structure

On Wed, Nov 6, 2019 at 12:27 PM Zeng, Oak <Oak.Zeng@amd.com<mailto:Oak.Zeng=
@amd.com>> wrote:
>
> Explain fields like aper_base, agp_start etc. The definition
> of those fields are confusing as they are from different view
> (CPU or GPU). Add comments for easier understand.
>
> Change-Id: I02c2a27cd0dbc205498eb86aafa722f2e0c25fe6
> Signed-off-by: Oak Zeng <Oak.Zeng@amd.com<mailto:Oak.Zeng@amd.com>>

Same comments as the previous version.  With those addressed,
Reviewed-by: Alex Deucher <alexander.deucher@amd.com<mailto:alexander.deuch=
er@amd.com>>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gmc.h
> index 555d8e5..1356ff9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> @@ -127,18 +127,44 @@ struct amdgpu_xgmi {
>  };
>
>  struct amdgpu_gmc {
> +       /* FB's physical address in MMIO space (for CPU to
> +        * map FB). This is different compared to the apg/
> +        * gart/vram_start/end field as the later is from
> +        * GPU's view and aper_base is from CPU's view.
> +        */
>         resource_size_t         aper_size;
>         resource_size_t         aper_base;
>         /* for some chips with <=3D 32MB we need to lie
>          * about vram size near mc fb location */
>         u64                     mc_vram_size;
>         u64                     visible_vram_size;
> +       /* APG aperture start and end in MC address space
> +        * Driver find a hole in the MC address space
> +        * to place AGP by setting MC_VM_AGP_BOT/TOP registers
> +        * Under VMID0, logical address =3D=3D MC address
> +        * AGP aperture is used to simulate FB in ZFB case
> +        */
>         u64                     agp_size;
>         u64                     agp_start;
>         u64                     agp_end;
> +       /* GART aperture start and end in MC address space
> +        * Driver find a hole in the MC address space
> +        * to place GART by setting VM_CONTEXT0_PAGE_TABLE_START/END_ADDR
> +        * registers
> +        * Under VMID0, logical address inside GART aperture will
> +        * be translated through gpuvm gart page table to access
> +        * paged system memory
> +        */
>         u64                     gart_size;
>         u64                     gart_start;
>         u64                     gart_end;
> +       /* Frame buffer aperture of this GPU device. Different from
> +        * fb_start (see below), this only covers the local GPU device.
> +        * Driver get fb_start from MC_VM_FB_LOCATION_BASE (set by vbios)
> +        * and calculate vram_start of this local device by adding an
> +        * offset inside the XGMI hive.
> +        * Under VMID0, logical address =3D=3D MC address
> +        */
>         u64                     vram_start;
>         u64                     vram_end;
>         /* FB region , it's same as local vram region in single GPU, in X=
GMI
> --
> 2.7.4
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_BL0PR12MB25808E11A26B24C319F3121080780BL0PR12MB2580namp_
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
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
p.msonormal0, li.msonormal0, div.msonormal0
	{mso-style-name:msonormal;
	margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle18
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
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
<body lang=3D"EN-US" link=3D"blue" vlink=3D"purple">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Hi Yong,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">That has been submitted. <o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">MC address is the address sent to memory controller =
bus to address the physical memory. In many places it is also called physic=
al address.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Logical address is the address before it is translat=
ed to physical address. The translation can be either linear or through pag=
e table. Under VMID0, logical address of some apertures (AGP, FB) are linea=
rly mapped to MC address. (I think
 in our driver implementation, logical address =3D=3D MC address). But Gart=
 aperture is mapped through gpuvm (gart) page table &#8211; the mapped addr=
ess can also be called virtual address.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Under VMID1~15, it is user space virtual address (ca=
n also be called logical address), mapped through gpuvm page tables.
<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">So virtual address is one type of logical address. V=
irtual address is usually mapped through page table/vm.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Just my understanding.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<p class=3D"MsoNormal">Regards,<o:p></o:p></p>
<p class=3D"MsoNormal">Oak<o:p></o:p></p>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Zhao, Yong &lt;Yong.Zhao@amd.com&gt; <b=
r>
<b>Sent:</b> Thursday, November 7, 2019 12:16 PM<br>
<b>To:</b> Alex Deucher &lt;alexdeucher@gmail.com&gt;; Zeng, Oak &lt;Oak.Ze=
ng@amd.com&gt;<br>
<b>Cc:</b> Kuehling, Felix &lt;Felix.Kuehling@amd.com&gt;; Koenig, Christia=
n &lt;Christian.Koenig@amd.com&gt;; amd-gfx@lists.freedesktop.org<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: Add comments to gmc structure<o:p><=
/o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">If this=
 is not submitted, I would like to see some comments regarding the explanat=
ion of MC address and logical address, which I prefer to mention as GPU phy=
sical/virtual address.<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">Regards=
,<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">Yong<o:=
p></o:p></span></p>
</div>
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
 style=3D"color:black"> amd-gfx &lt;</span><a href=3D"mailto:amd-gfx-bounce=
s@lists.freedesktop.org">amd-gfx-bounces@lists.freedesktop.org</a><span sty=
le=3D"color:black">&gt; on behalf of Alex Deucher
 &lt;</span><a href=3D"mailto:alexdeucher@gmail.com">alexdeucher@gmail.com<=
/a><span style=3D"color:black">&gt;<br>
<b>Sent:</b> Thursday, November 7, 2019 9:02 AM<br>
<b>To:</b> Zeng, Oak &lt;</span><a href=3D"mailto:Oak.Zeng@amd.com">Oak.Zen=
g@amd.com</a><span style=3D"color:black">&gt;<br>
<b>Cc:</b> Kuehling, Felix &lt;</span><a href=3D"mailto:Felix.Kuehling@amd.=
com">Felix.Kuehling@amd.com</a><span style=3D"color:black">&gt;; Koenig, Ch=
ristian &lt;</span><a href=3D"mailto:Christian.Koenig@amd.com">Christian.Ko=
enig@amd.com</a><span style=3D"color:black">&gt;;
</span><a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freed=
esktop.org</a><span style=3D"color:black"> &lt;</span><a href=3D"mailto:amd=
-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a><span style=3D=
"color:black">&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: Add comments to gmc structure</span=
> <o:p>
</o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"MsoNormal">On Wed, Nov 6, 2019 at 12:27 PM Zeng, Oak &lt;<a hre=
f=3D"mailto:Oak.Zeng@amd.com">Oak.Zeng@amd.com</a>&gt; wrote:<br>
&gt;<br>
&gt; Explain fields like aper_base, agp_start etc. The definition<br>
&gt; of those fields are confusing as they are from different view<br>
&gt; (CPU or GPU). Add comments for easier understand.<br>
&gt;<br>
&gt; Change-Id: I02c2a27cd0dbc205498eb86aafa722f2e0c25fe6<br>
&gt; Signed-off-by: Oak Zeng &lt;<a href=3D"mailto:Oak.Zeng@amd.com">Oak.Ze=
ng@amd.com</a>&gt;<br>
<br>
Same comments as the previous version.&nbsp; With those addressed,<br>
Reviewed-by: Alex Deucher &lt;<a href=3D"mailto:alexander.deucher@amd.com">=
alexander.deucher@amd.com</a>&gt;<br>
<br>
&gt; ---<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h | 26 &#43;&#43;&#43;&#43=
;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43=
;&#43;&#43;&#43;&#43;&#43;&#43;&#43;<br>
&gt;&nbsp; 1 file changed, 26 insertions(&#43;)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_gmc.h<br>
&gt; index 555d8e5..1356ff9 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h<br>
&gt; @@ -127,18 &#43;127,44 @@ struct amdgpu_xgmi {<br>
&gt;&nbsp; };<br>
&gt;<br>
&gt;&nbsp; struct amdgpu_gmc {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* FB's physical address in =
MMIO space (for CPU to<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * map FB). This is dif=
ferent compared to the apg/<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * gart/vram_start/end =
field as the later is from<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * GPU's view and aper_=
base is from CPU's view.<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; resource_size_t&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aper_size;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; resource_size_t&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aper_base;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* for some chips with=
 &lt;=3D 32MB we need to lie<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * about vram siz=
e near mc fb location */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u64&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; mc_vram_size;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u64&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; visible_vram_size;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* APG aperture start and en=
d in MC address space<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Driver find a hole i=
n the MC address space<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * to place AGP by sett=
ing MC_VM_AGP_BOT/TOP registers<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Under VMID0, logical=
 address =3D=3D MC address<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * AGP aperture is used=
 to simulate FB in ZFB case<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u64&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; agp_size;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u64&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; agp_start;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u64&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; agp_end;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* GART aperture start and e=
nd in MC address space<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Driver find a hole i=
n the MC address space<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * to place GART by set=
ting VM_CONTEXT0_PAGE_TABLE_START/END_ADDR<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * registers<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Under VMID0, logical=
 address inside GART aperture will<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * be translated throug=
h gpuvm gart page table to access<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * paged system memory<=
br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u64&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; gart_size;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u64&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; gart_start;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u64&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; gart_end;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Frame buffer aperture of =
this GPU device. Different from<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * fb_start (see below)=
, this only covers the local GPU device.<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Driver get fb_start =
from MC_VM_FB_LOCATION_BASE (set by vbios)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * and calculate vram_s=
tart of this local device by adding an<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * offset inside the XG=
MI hive.<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Under VMID0, logical=
 address =3D=3D MC address<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u64&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; vram_start;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u64&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; vram_end;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* FB region , it's sa=
me as local vram region in single GPU, in XGMI<br>
&gt; --<br>
&gt; 2.7.4<br>
&gt;<br>
&gt; _______________________________________________<br>
&gt; amd-gfx mailing list<br>
&gt; <a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedes=
ktop.org</a><br>
&gt; <a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">htt=
ps://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
_______________________________________________<br>
amd-gfx mailing list<br>
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a><br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://=
lists.freedesktop.org/mailman/listinfo/amd-gfx</a><o:p></o:p></p>
</div>
</div>
</div>
</body>
</html>

--_000_BL0PR12MB25808E11A26B24C319F3121080780BL0PR12MB2580namp_--

--===============0008490919==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0008490919==--
