Return-Path: <SRS0=5Use=ZK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1296DC432C0
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Nov 2019 09:29:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDA2F2073A
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Nov 2019 09:29:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDA2F2073A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C13089DEA;
	Mon, 18 Nov 2019 09:29:01 +0000 (UTC)
Received: from NAM03-DM3-obe.outbound.protection.outlook.com
 (mail-eopbgr800054.outbound.protection.outlook.com [40.107.80.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3544A89DEA
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Nov 2019 09:29:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CzkSSHh9axMGoQIr3YNjiaicy6zOBm0Ua/R1NVG4970bRcI2ggxPjTYX0DvnwyN/vnh/eAEYdQwFy/MCEFriEEPWR0WCB+SHr2aBBTAgrGs8taR23e+ij1lsEh/uonQnMfGONTVEukLH0pt0VYdm/po752OjQf84S4S3cPoaZDeeRN13Nb47fjo6HnYcoFJaCiZurWhJVTzknIRriXTqdtmAvv90VXVH01fEpefTtxHC9KMxgPpjZyFePRVrUfKK0RKbKU6ialUZEoTw0Cn+peKbSyTpTifA+sdj0Fl7NG3g4rFNxF4L1leLrn62V6VoBcOY/WuyLxQte+LaDFXLmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JnOorbeH4VV1gsMrsQYR/EmH7P8ryD6U6duaK3pI40w=;
 b=ZkPi6IsY9Ux4lQSZPLudcCZ1wYCoJVmFDJsIxuGmbkTZ2dZK53qHvQscpoe9enFVdom//qvMB74KyMcgsfO75EUwm2KS2v40ZeBZQqqYkXaiNCVfzm/lnYDbYrjl/ShtXpaQzhmxPBmumY48KGthDRyID+mqOuF50VlLbYz8AglrpqgWPBCDtvabKtRcuiL3fRWAVDayu2vsjvUgv5w7IKV/pZjsK0fa9e91M/WG3jiqbYujlRE3SXn3kHlOaAk8Ng7o4eQCVT+7ydn0tUrhAPbxn5/0D79LnEK7td97LItWAWZMlbSUXrYTSgipZKO1UAIRl8RJyFlhly/qHZI3UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MN2PR12MB3838.namprd12.prod.outlook.com (10.255.238.203) by
 MN2PR12MB3374.namprd12.prod.outlook.com (20.178.242.81) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.28; Mon, 18 Nov 2019 09:28:57 +0000
Received: from MN2PR12MB3838.namprd12.prod.outlook.com
 ([fe80::c98f:c517:b396:1bd4]) by MN2PR12MB3838.namprd12.prod.outlook.com
 ([fe80::c98f:c517:b396:1bd4%7]) with mapi id 15.20.2451.029; Mon, 18 Nov 2019
 09:28:57 +0000
From: "Liu, Aaron" <Aaron.Liu@amd.com>
To: "Olsak, Marek" <Marek.Olsak@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 01/12] amdgpu: add UAPI for creating encrypted buffers
Thread-Topic: [PATCH 01/12] amdgpu: add UAPI for creating encrypted buffers
Thread-Index: AQHVm2Wx7qF+ve0SU0GWUMkX3XqHwaeMMV+AgAAfr4CAAAUYgIAASmsAgAAFMACABAZCwA==
Date: Mon, 18 Nov 2019 09:28:57 +0000
Message-ID:
 <MN2PR12MB3838E0228F0AB2E58DB9109DF04D0@MN2PR12MB3838.namprd12.prod.outlook.com>
References: <1573788895-3936-1-git-send-email-aaron.liu@amd.com>,
 <06a979a0-0795-88cb-f1d9-80255165f0e4@gmail.com>,
 <DM5PR12MB182063DB1ACAD38C768ECAC3F7700@DM5PR12MB1820.namprd12.prod.outlook.com>,
 <1f6819bc-cf46-4f34-a569-9ba39a9c6559@email.android.com>,
 <DM6PR12MB32097BA0BE4D40FF431A6E11F9700@DM6PR12MB3209.namprd12.prod.outlook.com>
 <DM6PR12MB3209676F6F84150C08400C93F9700@DM6PR12MB3209.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB3209676F6F84150C08400C93F9700@DM6PR12MB3209.namprd12.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 378e4145-b785-4fd0-1e44-08d76c09bccb
x-ms-traffictypediagnostic: MN2PR12MB3374:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB3374FB10B4FCA6A5EFBC5937F04D0@MN2PR12MB3374.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0225B0D5BC
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(396003)(376002)(366004)(346002)(39860400002)(189003)(199004)(66476007)(66946007)(66066001)(66556008)(66446008)(64756008)(6506007)(53546011)(99286004)(446003)(11346002)(26005)(102836004)(7736002)(14454004)(81156014)(81166006)(52536014)(2906002)(33656002)(76116006)(6636002)(8676002)(54906003)(110136005)(316002)(3846002)(74316002)(790700001)(6116002)(76176011)(7696005)(8936002)(478600001)(486006)(6246003)(256004)(14444005)(71200400001)(4326008)(186003)(66574012)(5660300002)(71190400001)(54896002)(6306002)(236005)(6436002)(9686003)(476003)(55016002)(25786009)(86362001)(229853002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3374;
 H:MN2PR12MB3838.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mNk4113fnWMJSzSC2qwrWu8GQTZw57YXq29TlNZMgonl4N3EstuV+HIgjbTK72920TRZ1xYoL/hJHx5EoHoWiMRaHDSDbjGqgG6MyKaYn5nhFm4iszn3CBBiLmsRaOxrnzBSwHM9sDrWYlI2IqbYe472TkcDlJFPuIGpSHARKSPFTSshSlroN7GJDYGNZaWFvSPxNCi88vH78haLxOllMcy+EbVcHZgIlZzqAxMrmyqrOl6WX5r+V6itCjohnmvdTa94HoKl/3wWOUdI+xssSnndUq9yxAIrRrMN2T8BN9kwaZboU9k1cr5R32DgJcO18fUxo1mZYxRsHXORp3lemP7Jzd0yS2sRMMYt6scInQxgBQbFZEn4LIWofPA3XQqRJ9yRbM4WfeaBOQnzj0r8LDiyu0pAOE4g0pKiqgWJ3SItqpyyKgAfu2XRKnEFbqIt
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 378e4145-b785-4fd0-1e44-08d76c09bccb
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2019 09:28:57.2868 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mB0gRILGyUdxGOZz9TRsLSIaUtuxG+uyG6evP9vSwBkGcvfwq8q7ivRbUeYfavzX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3374
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JnOorbeH4VV1gsMrsQYR/EmH7P8ryD6U6duaK3pI40w=;
 b=H/bNsFEAEyUvmjmCWTJsB5So+yv7YV3+7ugNz3HlwGKAhRjLBnQC/TYM/ozpjV5GlDERkZQkC/vRVNzFfJIH+JIn4IUt/1infu1pePQyNac7XQPUlPASoauemlaAtRa3Hgmn5fjFcaBjZ+3fG3TLFXKKk3VASF76YnSVStuvd0Y=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Aaron.Liu@amd.com; 
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
Cc: =?iso-8859-1?Q?Christian_K=F6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "Huang, Ray" <Ray.Huang@amd.com>, "Liu, Leo" <Leo.Liu@amd.com>, "Tuikov,
 Luben" <Luben.Tuikov@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: multipart/mixed; boundary="===============0839607660=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191118092857.zzcUWstdlFqZqGjtFs7G51_vINJbqFX27AsdGIpcafU@z>

--===============0839607660==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB3838E0228F0AB2E58DB9109DF04D0MN2PR12MB3838namp_"

--_000_MN2PR12MB3838E0228F0AB2E58DB9109DF04D0MN2PR12MB3838namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Thanks for reviews.

As Christian's suggestion, I added drm_version checking, for the older driv=
er, security test suites are disabled.
I create a remote branch for libdrm: remotes/origin/aaliu/for-tmz-support

BR,
Aaron Liu

From: Olsak, Marek <Marek.Olsak@amd.com>
Sent: Saturday, November 16, 2019 3:53 AM
To: Koenig, Christian <Christian.Koenig@amd.com>; Deucher, Alexander <Alexa=
nder.Deucher@amd.com>
Cc: Christian K=F6nig <ckoenig.leichtzumerken@gmail.com>; Liu, Aaron <Aaron=
.Liu@amd.com>; amd-gfx@lists.freedesktop.org; Huang, Ray <Ray.Huang@amd.com=
>; Tuikov, Luben <Luben.Tuikov@amd.com>; Liu, Leo <Leo.Liu@amd.com>
Subject: Re: [PATCH 01/12] amdgpu: add UAPI for creating encrypted buffers

The way this is upstreamed is that you submit the kernel and userspace patc=
hes for review at the same time. When they see the userspace patches, the k=
ernel patches will be accepted. When the kernel patches land in the Dave's =
or Linus's tree, the userspace patches can be pushed.

Marek
________________________________
From: Olsak, Marek <Marek.Olsak@amd.com<mailto:Marek.Olsak@amd.com>>
Sent: November 15, 2019 14:34
To: Koenig, Christian <Christian.Koenig@amd.com<mailto:Christian.Koenig@amd=
.com>>; Deucher, Alexander <Alexander.Deucher@amd.com<mailto:Alexander.Deuc=
her@amd.com>>
Cc: Christian K=F6nig <ckoenig.leichtzumerken@gmail.com<mailto:ckoenig.leic=
htzumerken@gmail.com>>; Liu, Aaron <Aaron.Liu@amd.com<mailto:Aaron.Liu@amd.=
com>>; amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org> =
<amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>>; Huan=
g, Ray <Ray.Huang@amd.com<mailto:Ray.Huang@amd.com>>; Tuikov, Luben <Luben.=
Tuikov@amd.com<mailto:Luben.Tuikov@amd.com>>; Liu, Leo <Leo.Liu@amd.com<mai=
lto:Leo.Liu@amd.com>>
Subject: Re: [PATCH 01/12] amdgpu: add UAPI for creating encrypted buffers

In the kernel tree, you need to do "make headers_install". Then copy amdgpu=
_drm.h from ./usr/ to the libdrm tree and discard parts that we can't upstr=
eam (freesync).

Marek
________________________________
From: Koenig, Christian <Christian.Koenig@amd.com<mailto:Christian.Koenig@a=
md.com>>
Sent: November 15, 2019 10:08
To: Deucher, Alexander <Alexander.Deucher@amd.com<mailto:Alexander.Deucher@=
amd.com>>
Cc: Christian K=F6nig <ckoenig.leichtzumerken@gmail.com<mailto:ckoenig.leic=
htzumerken@gmail.com>>; Liu, Aaron <Aaron.Liu@amd.com<mailto:Aaron.Liu@amd.=
com>>; amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org> =
<amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>>; Olsa=
k, Marek <Marek.Olsak@amd.com<mailto:Marek.Olsak@amd.com>>; Huang, Ray <Ray=
.Huang@amd.com<mailto:Ray.Huang@amd.com>>; Tuikov, Luben <Luben.Tuikov@amd.=
com<mailto:Luben.Tuikov@amd.com>>; Liu, Leo <Leo.Liu@amd.com<mailto:Leo.Liu=
@amd.com>>
Subject: Re: [PATCH 01/12] amdgpu: add UAPI for creating encrypted buffers

I know, that's the usual chicken and egg problem with updating libdrm.

But we should update the file with the kernel version and not pick all chan=
ges line by line.

Christian.

Am 15.11.2019 15:49 schrieb "Deucher, Alexander" <Alexander.Deucher@amd.com=
<mailto:Alexander.Deucher@amd.com>>:
We can't land the kernel side until we have real userspace (e.g., Mesa) tha=
t uses the TMZ interfaces.  The unit tests are not enough.

Alex


________________________________
From: Christian K=F6nig <ckoenig.leichtzumerken@gmail.com<mailto:ckoenig.le=
ichtzumerken@gmail.com>>
Sent: Friday, November 15, 2019 7:56 AM
To: Liu, Aaron <Aaron.Liu@amd.com<mailto:Aaron.Liu@amd.com>>; amd-gfx@lists=
.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org> <amd-gfx@lists.freed=
esktop.org<mailto:amd-gfx@lists.freedesktop.org>>
Cc: Olsak, Marek <Marek.Olsak@amd.com<mailto:Marek.Olsak@amd.com>>; Huang, =
Ray <Ray.Huang@amd.com<mailto:Ray.Huang@amd.com>>; Tuikov, Luben <Luben.Tui=
kov@amd.com<mailto:Luben.Tuikov@amd.com>>; Deucher, Alexander <Alexander.De=
ucher@amd.com<mailto:Alexander.Deucher@amd.com>>; Liu, Leo <Leo.Liu@amd.com=
<mailto:Leo.Liu@amd.com>>; Koenig, Christian <Christian.Koenig@amd.com<mail=
to:Christian.Koenig@amd.com>>
Subject: Re: [PATCH 01/12] amdgpu: add UAPI for creating encrypted buffers

Am 15.11.19 um 04:34 schrieb Aaron Liu:
> From: Huang Rui <ray.huang@amd.com<mailto:ray.huang@amd.com>>
>
> To align the kernel uapi change from Alex:
>
> "Add a flag to the GEM_CREATE ioctl to create encrypted buffers. Buffers =
with
> this flag set will be created with the TMZ bit set in the PTEs or engines
> accessing them. This is required in order to properly access the data fro=
m the
> engines."
>
> We will use GEM_CREATE_ENCRYPTED flag for secure buffer allocation.
>
> Signed-off-by: Huang Rui <ray.huang@amd.com<mailto:ray.huang@amd.com>>
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com<mailto:alexander.deu=
cher@amd.com>>

Please read up on how amdpu_drm.h is updated. The change must first land
upstream and then the file is synced up somehow semi-automatic.

Christian.

> ---
>   include/drm/amdgpu_drm.h | 5 +++++
>   1 file changed, 5 insertions(+)
>
> diff --git a/include/drm/amdgpu_drm.h b/include/drm/amdgpu_drm.h
> index 5c28aa7..1a95e37 100644
> --- a/include/drm/amdgpu_drm.h
> +++ b/include/drm/amdgpu_drm.h
> @@ -141,6 +141,11 @@ extern "C" {
>    * releasing the memory
>    */
>   #define AMDGPU_GEM_CREATE_VRAM_WIPE_ON_RELEASE      (1 << 9)
> +/* Flag that BO will be encrypted and that the TMZ bit should be
> + * set in the PTEs when mapping this buffer via GPUVM or
> + * accessing it with various hw blocks
> + */
> +#define AMDGPU_GEM_CREATE_ENCRYPTED          (1 << 10)
>
>   /* Hybrid specific */
>   /* Flag that the memory allocation should be from top of domain */

--_000_MN2PR12MB3838E0228F0AB2E58DB9109DF04D0MN2PR12MB3838namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
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
	color:#0563C1;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:#954F72;
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
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Thanks for reviews.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">As Christian&#8217;s suggestion, I added drm_version=
 checking, for the older driver, security test suites are disabled.<o:p></o=
:p></p>
<p class=3D"MsoNormal">I create a remote branch for libdrm: <span style=3D"=
color:red">
remotes/origin/aaliu/for-tmz-support</span><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<p class=3D"MsoNormal">BR,<o:p></o:p></p>
<p class=3D"MsoNormal">Aaron Liu<o:p></o:p></p>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Olsak, Marek &lt;Marek.Olsak@amd.com&gt=
; <br>
<b>Sent:</b> Saturday, November 16, 2019 3:53 AM<br>
<b>To:</b> Koenig, Christian &lt;Christian.Koenig@amd.com&gt;; Deucher, Ale=
xander &lt;Alexander.Deucher@amd.com&gt;<br>
<b>Cc:</b> Christian K=F6nig &lt;ckoenig.leichtzumerken@gmail.com&gt;; Liu,=
 Aaron &lt;Aaron.Liu@amd.com&gt;; amd-gfx@lists.freedesktop.org; Huang, Ray=
 &lt;Ray.Huang@amd.com&gt;; Tuikov, Luben &lt;Luben.Tuikov@amd.com&gt;; Liu=
, Leo &lt;Leo.Liu@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH 01/12] amdgpu: add UAPI for creating encrypted b=
uffers<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">The way=
 this is upstreamed is that you submit the kernel and userspace patches for=
 review at the same time. When they see the userspace patches, the kernel p=
atches will be accepted. When the kernel
 patches land in the Dave's or Linus's tree, the userspace patches can be p=
ushed.<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">Marek<o=
:p></o:p></span></p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"color:black">From:</span></b><span=
 style=3D"color:black"> Olsak, Marek &lt;</span><a href=3D"mailto:Marek.Ols=
ak@amd.com">Marek.Olsak@amd.com</a><span style=3D"color:black">&gt;<br>
<b>Sent:</b> November 15, 2019 14:34<br>
<b>To:</b> Koenig, Christian &lt;</span><a href=3D"mailto:Christian.Koenig@=
amd.com">Christian.Koenig@amd.com</a><span style=3D"color:black">&gt;; Deuc=
her, Alexander &lt;</span><a href=3D"mailto:Alexander.Deucher@amd.com">Alex=
ander.Deucher@amd.com</a><span style=3D"color:black">&gt;<br>
<b>Cc:</b> Christian K=F6nig &lt;</span><a href=3D"mailto:ckoenig.leichtzum=
erken@gmail.com">ckoenig.leichtzumerken@gmail.com</a><span style=3D"color:b=
lack">&gt;; Liu, Aaron &lt;</span><a href=3D"mailto:Aaron.Liu@amd.com">Aaro=
n.Liu@amd.com</a><span style=3D"color:black">&gt;;
</span><a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freed=
esktop.org</a><span style=3D"color:black"> &lt;</span><a href=3D"mailto:amd=
-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a><span style=3D=
"color:black">&gt;; Huang, Ray &lt;</span><a href=3D"mailto:Ray.Huang@amd.c=
om">Ray.Huang@amd.com</a><span style=3D"color:black">&gt;;
 Tuikov, Luben &lt;</span><a href=3D"mailto:Luben.Tuikov@amd.com">Luben.Tui=
kov@amd.com</a><span style=3D"color:black">&gt;; Liu, Leo &lt;</span><a hre=
f=3D"mailto:Leo.Liu@amd.com">Leo.Liu@amd.com</a><span style=3D"color:black"=
>&gt;<br>
<b>Subject:</b> Re: [PATCH 01/12] amdgpu: add UAPI for creating encrypted b=
uffers</span>
<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">In the =
kernel tree, you need to do &quot;make headers_install&quot;. Then copy amd=
gpu_drm.h from ./usr/ to the libdrm tree and discard parts that we can't up=
stream (freesync).<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">Marek<o=
:p></o:p></span></p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"x_divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"color:black">From:</span></b><span=
 style=3D"color:black"> Koenig, Christian &lt;</span><a href=3D"mailto:Chri=
stian.Koenig@amd.com">Christian.Koenig@amd.com</a><span style=3D"color:blac=
k">&gt;<br>
<b>Sent:</b> November 15, 2019 10:08<br>
<b>To:</b> Deucher, Alexander &lt;</span><a href=3D"mailto:Alexander.Deuche=
r@amd.com">Alexander.Deucher@amd.com</a><span style=3D"color:black">&gt;<br=
>
<b>Cc:</b> Christian K=F6nig &lt;</span><a href=3D"mailto:ckoenig.leichtzum=
erken@gmail.com">ckoenig.leichtzumerken@gmail.com</a><span style=3D"color:b=
lack">&gt;; Liu, Aaron &lt;</span><a href=3D"mailto:Aaron.Liu@amd.com">Aaro=
n.Liu@amd.com</a><span style=3D"color:black">&gt;;
</span><a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freed=
esktop.org</a><span style=3D"color:black"> &lt;</span><a href=3D"mailto:amd=
-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a><span style=3D=
"color:black">&gt;; Olsak, Marek &lt;</span><a href=3D"mailto:Marek.Olsak@a=
md.com">Marek.Olsak@amd.com</a><span style=3D"color:black">&gt;;
 Huang, Ray &lt;</span><a href=3D"mailto:Ray.Huang@amd.com">Ray.Huang@amd.c=
om</a><span style=3D"color:black">&gt;; Tuikov, Luben &lt;</span><a href=3D=
"mailto:Luben.Tuikov@amd.com">Luben.Tuikov@amd.com</a><span style=3D"color:=
black">&gt;; Liu, Leo &lt;</span><a href=3D"mailto:Leo.Liu@amd.com">Leo.Liu=
@amd.com</a><span style=3D"color:black">&gt;<br>
<b>Subject:</b> Re: [PATCH 01/12] amdgpu: add UAPI for creating encrypted b=
uffers</span>
<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"MsoNormal">I know, that's the usual chicken and egg problem wit=
h updating libdrm.
<o:p></o:p></p>
<div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
<div>
<p class=3D"MsoNormal">But we should update the file with the kernel versio=
n and not pick all changes line by line.<o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
<div>
<p class=3D"MsoNormal">Christian.<o:p></o:p></p>
</div>
</div>
<div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<p class=3D"MsoNormal">Am 15.11.2019 15:49 schrieb &quot;Deucher, Alexander=
&quot; &lt;<a href=3D"mailto:Alexander.Deucher@amd.com">Alexander.Deucher@a=
md.com</a>&gt;:<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">We can'=
t land the kernel side until we have real userspace (e.g., Mesa) that uses =
the TMZ interfaces.&nbsp; The unit tests are not enough.<o:p></o:p></span><=
/p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">Alex<o:=
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
<div id=3D"x_x_divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"color:black">From:</span></b><span=
 style=3D"color:black"> Christian K=F6nig &lt;</span><a href=3D"mailto:ckoe=
nig.leichtzumerken@gmail.com">ckoenig.leichtzumerken@gmail.com</a><span sty=
le=3D"color:black">&gt;<br>
<b>Sent:</b> Friday, November 15, 2019 7:56 AM<br>
<b>To:</b> Liu, Aaron &lt;</span><a href=3D"mailto:Aaron.Liu@amd.com">Aaron=
.Liu@amd.com</a><span style=3D"color:black">&gt;;
</span><a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freed=
esktop.org</a><span style=3D"color:black"> &lt;</span><a href=3D"mailto:amd=
-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a><span style=3D=
"color:black">&gt;<br>
<b>Cc:</b> Olsak, Marek &lt;</span><a href=3D"mailto:Marek.Olsak@amd.com">M=
arek.Olsak@amd.com</a><span style=3D"color:black">&gt;; Huang, Ray &lt;</sp=
an><a href=3D"mailto:Ray.Huang@amd.com">Ray.Huang@amd.com</a><span style=3D=
"color:black">&gt;; Tuikov, Luben &lt;</span><a href=3D"mailto:Luben.Tuikov=
@amd.com">Luben.Tuikov@amd.com</a><span style=3D"color:black">&gt;;
 Deucher, Alexander &lt;</span><a href=3D"mailto:Alexander.Deucher@amd.com"=
>Alexander.Deucher@amd.com</a><span style=3D"color:black">&gt;; Liu, Leo &l=
t;</span><a href=3D"mailto:Leo.Liu@amd.com">Leo.Liu@amd.com</a><span style=
=3D"color:black">&gt;; Koenig, Christian &lt;</span><a href=3D"mailto:Chris=
tian.Koenig@amd.com">Christian.Koenig@amd.com</a><span style=3D"color:black=
">&gt;<br>
<b>Subject:</b> Re: [PATCH 01/12] amdgpu: add UAPI for creating encrypted b=
uffers</span>
<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt">Am 15.11.19 um 04:34 =
schrieb Aaron Liu:<br>
&gt; From: Huang Rui &lt;<a href=3D"mailto:ray.huang@amd.com">ray.huang@amd=
.com</a>&gt;<br>
&gt;<br>
&gt; To align the kernel uapi change from Alex:<br>
&gt;<br>
&gt; &quot;Add a flag to the GEM_CREATE ioctl to create encrypted buffers. =
Buffers with<br>
&gt; this flag set will be created with the TMZ bit set in the PTEs or engi=
nes<br>
&gt; accessing them. This is required in order to properly access the data =
from the<br>
&gt; engines.&quot;<br>
&gt;<br>
&gt; We will use GEM_CREATE_ENCRYPTED flag for secure buffer allocation.<br=
>
&gt;<br>
&gt; Signed-off-by: Huang Rui &lt;<a href=3D"mailto:ray.huang@amd.com">ray.=
huang@amd.com</a>&gt;<br>
&gt; Reviewed-by: Alex Deucher &lt;<a href=3D"mailto:alexander.deucher@amd.=
com">alexander.deucher@amd.com</a>&gt;<br>
<br>
Please read up on how amdpu_drm.h is updated. The change must first land <b=
r>
upstream and then the file is synced up somehow semi-automatic.<br>
<br>
Christian.<br>
<br>
&gt; ---<br>
&gt;&nbsp;&nbsp; include/drm/amdgpu_drm.h | 5 &#43;&#43;&#43;&#43;&#43;<br>
&gt;&nbsp;&nbsp; 1 file changed, 5 insertions(&#43;)<br>
&gt;<br>
&gt; diff --git a/include/drm/amdgpu_drm.h b/include/drm/amdgpu_drm.h<br>
&gt; index 5c28aa7..1a95e37 100644<br>
&gt; --- a/include/drm/amdgpu_drm.h<br>
&gt; &#43;&#43;&#43; b/include/drm/amdgpu_drm.h<br>
&gt; @@ -141,6 &#43;141,11 @@ extern &quot;C&quot; {<br>
&gt;&nbsp;&nbsp;&nbsp; * releasing the memory<br>
&gt;&nbsp;&nbsp;&nbsp; */<br>
&gt;&nbsp;&nbsp; #define AMDGPU_GEM_CREATE_VRAM_WIPE_ON_RELEASE&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; (1 &lt;&lt; 9)<br>
&gt; &#43;/* Flag that BO will be encrypted and that the TMZ bit should be<=
br>
&gt; &#43; * set in the PTEs when mapping this buffer via GPUVM or<br>
&gt; &#43; * accessing it with various hw blocks<br>
&gt; &#43; */<br>
&gt; &#43;#define AMDGPU_GEM_CREATE_ENCRYPTED&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; (1 &lt;&lt; 10)<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; /* Hybrid specific */<br>
&gt;&nbsp;&nbsp; /* Flag that the memory allocation should be from top of d=
omain */<o:p></o:p></p>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_MN2PR12MB3838E0228F0AB2E58DB9109DF04D0MN2PR12MB3838namp_--

--===============0839607660==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0839607660==--
