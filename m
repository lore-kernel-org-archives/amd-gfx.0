Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC189C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Mar 2022 14:11:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5429C10E4C9;
	Tue, 15 Mar 2022 14:11:53 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2068.outbound.protection.outlook.com [40.107.94.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0617810E50A
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Mar 2022 14:11:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mHPIiv9c/vEHpPlDPOi1KZUKBNi0n1Ze1/dlRbwBd8us9s3hqKLKoZfAZXfADF+RnpcFX24/XuBC/gVx53vowilz9mvbTxaQSlFoUtKLM6o03qwhgqDJnnaiZUmu5ggtPABWLusT3orC5ANwb7vYKzB33dt/t3fEXkNZy7gNSLC9Eepqkf6z2OpDcsGlhDqIgXqXbiLV1jiRYeU7I+xOZ5eF2t1kgNDrNqtHvkhMfj5mhvpj58PPHr/waFGqeJd5EkoDnPrXhbLJPD54aBHX5pQLkM9hY/aCDDQu5NjXToy6I7JZGK4ZGyVmP0J8NLUOQoruKqHRlRX3CnoSc+BfSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EYg83kFl7pFzOltcAK+I1bh9dMHuRUGyMPH7HKA54Js=;
 b=PMHrBw2QWzGDE51eq5G5r47yoRZCstda6RS/o4t704iYaLJT4ED+q9MVYnvFjzxJ9G7vpUGzu02Pq+LHPOyC0En/vCCRCFuw89v9agnb0FN9/QyQ9uuDExE3nBakXDEGOTc9LnPA/nOxexCNIdfwgt9oq6Pi66rDNjfJiJZy0Muwv8h57omYdCBscYojRHQBAQhDmAHvspBtq1Lnr+E4xTrR7ZMg/ieV/fHnrq/kc5V89BFhBFziBYJyzT6Y24iEqBU6/1y1mCXMK7WoN8VIHDfS55gVW+gcxaHkXKcMgG4EmdpJ7tfGVG0kPld9wGfnbZMbz7gjqL5n4DFXpZtT6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EYg83kFl7pFzOltcAK+I1bh9dMHuRUGyMPH7HKA54Js=;
 b=OE+/PqEaJeBiIJxemLVKexiFrFp4Rry7q8v/KaySB1s+sJnN2Ol4/LdjY/XFrwVWR+iBsHjYT7b7sxT7I2dD96t2l/cLG0/C/q4F7UmTjuJx+prRs6okVdDYdQkacJf7wsL0UFzYM6+yaU66QlAGZgs62fG93RzPDFuxv26Bt98=
Received: from DM4PR12MB5294.namprd12.prod.outlook.com (2603:10b6:5:39e::15)
 by MN2PR12MB4471.namprd12.prod.outlook.com (2603:10b6:208:26f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Tue, 15 Mar
 2022 14:11:49 +0000
Received: from DM4PR12MB5294.namprd12.prod.outlook.com
 ([fe80::b8ec:5650:98f1:bffe]) by DM4PR12MB5294.namprd12.prod.outlook.com
 ([fe80::b8ec:5650:98f1:bffe%5]) with mapi id 15.20.5061.028; Tue, 15 Mar 2022
 14:11:49 +0000
From: "Yin, Tianci (Rico)" <Tianci.Yin@amd.com>
To: "Zhu, James" <James.Zhu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu/vcn: fix vcn ring test failure in igt reload
 test
Thread-Topic: [PATCH] drm/amdgpu/vcn: fix vcn ring test failure in igt reload
 test
Thread-Index: AQHYOBULpQlgUV2PfU+8EQEFup81NazAWKgAgAAkMH0=
Date: Tue, 15 Mar 2022 14:11:49 +0000
Message-ID: <DM4PR12MB529442776F3B3A0ADE91777495109@DM4PR12MB5294.namprd12.prod.outlook.com>
References: <20220315023315.436797-1-tianci.yin@amd.com>
 <bbbbd2d0-24ae-0cf6-e5b7-8951a79fecb0@amd.com>
In-Reply-To: <bbbbd2d0-24ae-0cf6-e5b7-8951a79fecb0@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=True;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-03-15T14:11:48.474Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use
 Only; MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 00cae389-3ccf-4ae9-c40f-08da068dbf46
x-ms-traffictypediagnostic: MN2PR12MB4471:EE_
x-microsoft-antispam-prvs: <MN2PR12MB4471B6F58BD50AD1238CDF1F95109@MN2PR12MB4471.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BY+ijUsGa8mUDjcVcITPTQTXFNSM9W4kNtONXiwAyeho7w0pF0ninrXiEnW+vNXMb4wR8D38WHDuP0P03iX3ikrCHN1p4Gsp5uIgbwMDWwFIgXLmE+SeU3fD94FLDZBoWeX9mtXIdWPqodnfZxOuJWO29XoXt4Xq5o3KPqgx/z+rzyG9KcfTyBIz9GJUd5AvRvISDMfYUAfNHQJAgQTRHOVp2GNxUNSaFwj4/wGYauMOneLPBkZbzAfr1hqbzqpWf+r7/GFNxV9/Pwfa+EXo6TuA6gyPhlnuPaTdrasEtB1kKCST3O6q50k2qcrX9w0J7uGALpXwYJKV9NFPcvu4kn4byAaPXicDAzUhvsNkfsWMmgTWsoIUPsxDnzeikicoV7/pLqWesLUJY54yg38IctCaphbLMhhKm+m8YrpSek91Y2nhK0uvkcMp2oBJ/gH0yUC3p28hZw0M/F5SYm4YeCwwD/ONqhu5Fwomfve0r2oNa715kSzxSbHqMRXcmj3lF6OaHuL7qkuXjX4TLVfNbJ9dBh+MATqVCae10A9WdWGCSpNNwzemez0gypzd3tM+HYP47XRYVGf48CTYtCs/rDiEUwHrK98wm5dn8tydffcCkhxPEaImLa+LBq02wNqe4XRTVx/kq7w1X4sKjDcASV7JCU3TIYf4jGkEoTpedemxUvDtyNItGu0yub9+5et40h5oE1ONs1rboUqyyfxA9w==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5294.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(33656002)(508600001)(2906002)(316002)(76116006)(66946007)(55016003)(66556008)(91956017)(64756008)(8676002)(4326008)(66476007)(66446008)(9686003)(38100700002)(52536014)(53546011)(122000001)(7696005)(5660300002)(86362001)(8936002)(38070700005)(26005)(186003)(54906003)(110136005)(71200400001)(83380400001)(6506007)(19627405001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?H5tvXb7V3h2n+HGT0qBTqkcgsfSt6W/NizN0WFdyFbhNhu5tGQUAr9C+ysoC?=
 =?us-ascii?Q?LprVTw7UQ3LW8oSSKnvvJhC/Jos+r7hBMnEvrVkS286aTOVnR2e+IVCXXsyd?=
 =?us-ascii?Q?mQvAyEcq676ByloQ2KBcfLRwepXCB38Wc7UOel5amfEFH7ypcqjTAZpTLkH8?=
 =?us-ascii?Q?pVswcDI0oq53X1pge911K1JRxbvz/HFgfHZX3FjoO0Ymu/ici0VHV8fSCnXm?=
 =?us-ascii?Q?JzT/cvGAOTChbKZagBWPExSm7sWo6o88fhaBwVA5gOva1z4OljsxXYIp7Xgy?=
 =?us-ascii?Q?Kw1j3MJkGxwftoAqp1mNwjVReCVe9rNUI/tp1R5QiTKjzdy2zRfGJTHo9gxw?=
 =?us-ascii?Q?n0y0M6Qa3S+HBDr8mw/vCgjjOuwgfN7+zm3nPA+G48Mr8jhEMDc81j6z65Ei?=
 =?us-ascii?Q?6d7lzAnZEPKgcvbcNF7u6SOdDhBzFMETi88liF7vGqh/HB+mfwcOwPHauKWM?=
 =?us-ascii?Q?G2RdfzvaBzYgq+47C6VRn92fwoY8XUlSBwv/ZqZAnQ29/P/fdWxBJANAfb3O?=
 =?us-ascii?Q?ZI935JH05OM7eQyFxUc4MMjJz6wG/B32yGcPbQbFGHeTE5umW2kq15CTQPw4?=
 =?us-ascii?Q?wSPrNUzVC+6lIYt5bPIRq6dp8ZowOL1cFOAUxTVkYL/m4y363X6MUkhB1mpd?=
 =?us-ascii?Q?cRxX694UvDOX8hJULI1217brlLYu7h0Zta+k/TwsVhCnnMWNCHJOwUIszi4P?=
 =?us-ascii?Q?jY4ZuRverlLnnOVYDPhqGjKJrm13RH3Ow1NIstVBlaCIxSfUFyHK+UQykU/g?=
 =?us-ascii?Q?T0xkWIAgH4sd319kLVFjdKp2iarUQWQZrv/HyScsRIPF6a+etBhVTU+uBDNR?=
 =?us-ascii?Q?vSPyGMUsTbC2niOJuotoTpICstz8rDpLYrhI13EIlVj9yiWsAHR63C+IAn4c?=
 =?us-ascii?Q?K8ERiUrnYHnd43nVMjgZLD8h1ghrZsj4Afwyl/MgdmflEr5Mh0mOfYI6M+JN?=
 =?us-ascii?Q?gJ/ziW/4ZsfFKk25fmRhSI/R/DMoHG6ale3V/pBa0dfQeAkJ8iZGjVyb9nvc?=
 =?us-ascii?Q?/aJVRIEmGLiFytQY1/8Ss+A5guebJGIq+MlttzDAZTkJRRiPldb0vH3dgdG5?=
 =?us-ascii?Q?u7g8owzrnKmbxLNJisp+kjomWRxghyYgocpWmqW4Sy+mX64+pSFsBZQb5zKl?=
 =?us-ascii?Q?4ozWBDY7c7d+zOTHxxccGizLZTxm5nON/GZrlqjss/UeGddxqRkebL+9+0vf?=
 =?us-ascii?Q?VDVfaqLqA8P7NG8ttJs23mMg5a8g+VbIPYy/0rVIELni9Dv4+bLJhn5M6/Y/?=
 =?us-ascii?Q?RVJ2ycwBOWrzwXaf8KgyFfChMTEowEdiXxelWgUUtDlr7OvtOW1oL9bVIzbg?=
 =?us-ascii?Q?vBMGVPAxuEQcjG8k4QOgzjYN0JRCuCERqiwDyFgucTcjNOERUNpaqbsMe/mv?=
 =?us-ascii?Q?GqbGr4HFYP8b2EeFrRnjfOZQMsWUc9s7orA6q7Zr4/pw/FXK8+TgMZtOLgYM?=
 =?us-ascii?Q?KSXNI5zD6pLFhP6IUukoWgxZQo8wGj4y?=
Content-Type: multipart/alternative;
 boundary="_000_DM4PR12MB529442776F3B3A0ADE91777495109DM4PR12MB5294namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5294.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00cae389-3ccf-4ae9-c40f-08da068dbf46
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2022 14:11:49.4181 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iROVkW3augHZatlPM2/jQCktsOGCRJ3tCWPE1+OfXlDsriwPxaneMI0LpW1yYDYR8YgWH9ajth7feeDzMP3srg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4471
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
Cc: "Wang, Yu \(Charlie\)" <Yu.Wang4@amd.com>, "Chen,
 Guchun" <Guchun.Chen@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_DM4PR12MB529442776F3B3A0ADE91777495109DM4PR12MB5294namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]

Thank you for reviewing James!

Regards,
Rico
________________________________
From: Zhu, James <James.Zhu@amd.com>
Sent: Tuesday, March 15, 2022 20:01
To: Yin, Tianci (Rico) <Tianci.Yin@amd.com>; amd-gfx@lists.freedesktop.org =
<amd-gfx@lists.freedesktop.org>
Cc: Chen, Guchun <Guchun.Chen@amd.com>; Zhu, James <James.Zhu@amd.com>; Wan=
g, Yu (Charlie) <Yu.Wang4@amd.com>
Subject: Re: [PATCH] drm/amdgpu/vcn: fix vcn ring test failure in igt reloa=
d test

This patch is Reviewed-by: James Zhu <James.Zhu@amd.com>

On 2022-03-14 10:33 p.m., Tianci Yin wrote:
> From: "Tianci.Yin" <tianci.yin@amd.com>
>
> [why]
> On Renoir, vcn ring test failed on the second time insmod in the reload
> test. After invetigation, it proves that vcn only can disable dpg under
> dpg unpause mode (dpg unpause mode is default for dec only, dpg pause
> mode is for dec/enc).
>
> [how]
> unpause dpg in dpg stopping procedure.
>
> Change-Id: If6ec3af694e1d6b63ebce386a563f03ca6d291c1
> Signed-off-by: Tianci.Yin <tianci.yin@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/=
amdgpu/vcn_v2_0.c
> index 319ac8ea434b..6e0972cd1f2f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> @@ -1098,8 +1098,10 @@ static int vcn_v2_0_start(struct amdgpu_device *ad=
ev)
>
>   static int vcn_v2_0_stop_dpg_mode(struct amdgpu_device *adev)
>   {
> +     struct dpg_pause_state state =3D {.fw_based =3D VCN_DPG_STATE__UNPA=
USE};
>        uint32_t tmp;
>
> +     vcn_v2_0_pause_dpg_mode(adev, 0, &state);
>        /* Wait for power status to be 1 */
>        SOC15_WAIT_ON_RREG(UVD, 0, mmUVD_POWER_STATUS, 1,
>                UVD_POWER_STATUS__UVD_POWER_STATUS_MASK);

--_000_DM4PR12MB529442776F3B3A0ADE91777495109DM4PR12MB5294namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Thank you for reviewing James!</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Regards,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Rico</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Zhu, James &lt;James.=
Zhu@amd.com&gt;<br>
<b>Sent:</b> Tuesday, March 15, 2022 20:01<br>
<b>To:</b> Yin, Tianci (Rico) &lt;Tianci.Yin@amd.com&gt;; amd-gfx@lists.fre=
edesktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Chen, Guchun &lt;Guchun.Chen@amd.com&gt;; Zhu, James &lt;James.Z=
hu@amd.com&gt;; Wang, Yu (Charlie) &lt;Yu.Wang4@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu/vcn: fix vcn ring test failure in ig=
t reload test</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">This patch is Reviewed-by: James Zhu &lt;James.Zhu=
@amd.com&gt;<br>
<br>
On 2022-03-14 10:33 p.m., Tianci Yin wrote:<br>
&gt; From: &quot;Tianci.Yin&quot; &lt;tianci.yin@amd.com&gt;<br>
&gt;<br>
&gt; [why]<br>
&gt; On Renoir, vcn ring test failed on the second time insmod in the reloa=
d<br>
&gt; test. After invetigation, it proves that vcn only can disable dpg unde=
r<br>
&gt; dpg unpause mode (dpg unpause mode is default for dec only, dpg pause<=
br>
&gt; mode is for dec/enc).<br>
&gt;<br>
&gt; [how]<br>
&gt; unpause dpg in dpg stopping procedure.<br>
&gt;<br>
&gt; Change-Id: If6ec3af694e1d6b63ebce386a563f03ca6d291c1<br>
&gt; Signed-off-by: Tianci.Yin &lt;tianci.yin@amd.com&gt;<br>
&gt; ---<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c | 2 ++<br>
&gt;&nbsp;&nbsp; 1 file changed, 2 insertions(+)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/a=
md/amdgpu/vcn_v2_0.c<br>
&gt; index 319ac8ea434b..6e0972cd1f2f 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c<br>
&gt; @@ -1098,8 +1098,10 @@ static int vcn_v2_0_start(struct amdgpu_device =
*adev)<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; static int vcn_v2_0_stop_dpg_mode(struct amdgpu_device *ad=
ev)<br>
&gt;&nbsp;&nbsp; {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; struct dpg_pause_state state =3D {.fw_based =
=3D VCN_DPG_STATE__UNPAUSE};<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t tmp;<br>
&gt;&nbsp;&nbsp; <br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; vcn_v2_0_pause_dpg_mode(adev, 0, &amp;state)=
;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Wait for power status to =
be 1 */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SOC15_WAIT_ON_RREG(UVD, 0, m=
mUVD_POWER_STATUS, 1,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; UVD_POWER_STATUS__UVD_POWER_STATUS_MASK);<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_DM4PR12MB529442776F3B3A0ADE91777495109DM4PR12MB5294namp_--
