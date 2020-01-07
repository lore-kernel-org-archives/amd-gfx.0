Return-Path: <SRS0=EvZE=24=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_FONT_LOW_CONTRAST,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C453C33C99
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jan 2020 08:21:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1D2E2077B
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jan 2020 08:21:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="qii8zYq5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1D2E2077B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F2986E7E6;
	Tue,  7 Jan 2020 08:21:40 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2048.outbound.protection.outlook.com [40.107.220.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB0C96E7E6
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jan 2020 08:21:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W7eOylluLo40zc1vouoHr26eNxZL+PAEKhaGQESwuoFhlcEDvNAuoRr1Qc/oL40RDlSbgcWsQTJhc17ACZm8xKlxPgHIAfk0c05nqVAuhetn6/frTJz+fWJ78MwyFKaZnX1dfDGg377s1xz7TD1nrm8bop11PVTUNDAxiJQ5zFkjGx/jBBJoXYSUjm4a2/ah32y8CjC4FWTv9rD2kA7UU/EiTrLkrqWLnci4cBEIVo0qpU4Mrbeob//b64W7b9yiI+AMPPy9BZqQX17iapGiQ4zm3Sd0wH8ze7VNxsxSfUvUhfJL2Nwtz4CIk0FwQRNB121yDGpslfBxe1LucdCzrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XO2c/0JyS/wHWNxNYoflUywxsYpx5S6xMPDT/heDG4U=;
 b=nHbKTAeVkGslelh78husGy7PF/2hFkHN1EPJxfzkQN4EnJBybnFQnTBxmLowk+3OzlwF6wnpBr2GaVHhENp8jD89EQE9gEMRuYV8S2oV3PaBDo0r9AORS8JrUH2K8CYNPIJcsSXAax0sPaSaPK7+/ePfsSCgvEhUoKv44s6Xz8T9CT5NbCzT4tAeSr/oM6wmVWsfkhyyStnAcV7NphXq7+5R2clh73y1pUmXp0C0oQ9EM4GztznnYT4FJ+CyvobCyUVddtAt6mytFdDfrgf0gCBu6GQjeBI7Jz/K6LqII0d0ra9dXu+eLLTxu86jEMMh8Rb+08N3UJxHAX2Tcd1ZYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XO2c/0JyS/wHWNxNYoflUywxsYpx5S6xMPDT/heDG4U=;
 b=qii8zYq5l5XtdtgmjjeAXVp/yJ6bZeVzaUGVPN6EiYfiQHIe7ujSFPqdbylle+gi6MTIo1ETQXDcbwHvqu8B1FEoV4RxOSr1CzVNYi65EKT15ZBAm3s/JPXeMRG39EvGoH+ra/ylznlGYrb21E+jFCs/pLNPN8w5Z0Ju+jkl2/I=
Received: from MN2PR12MB3054.namprd12.prod.outlook.com (20.178.244.79) by
 MN2PR12MB3694.namprd12.prod.outlook.com (10.255.237.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.12; Tue, 7 Jan 2020 08:21:37 +0000
Received: from MN2PR12MB3054.namprd12.prod.outlook.com
 ([fe80::fd1e:ce54:2a7d:b849]) by MN2PR12MB3054.namprd12.prod.outlook.com
 ([fe80::fd1e:ce54:2a7d:b849%5]) with mapi id 15.20.2602.015; Tue, 7 Jan 2020
 08:21:37 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Clements, John" <John.Clements@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, dl.srdc_lnx_ras <dl.srdc_lnx_ras@amd.com>
Subject: Re: [PATCH] drm/amdgpu: updated UMC error address record with correct
 channel index
Thread-Topic: [PATCH] drm/amdgpu: updated UMC error address record with
 correct channel index
Thread-Index: AdXFK7YtNH2ongd8QiOefN8IMtm+SgABqqA3
Date: Tue, 7 Jan 2020 08:21:37 +0000
Message-ID: <MN2PR12MB30543BD6C60A1D3667627DB9B03F0@MN2PR12MB3054.namprd12.prod.outlook.com>
References: <MN2PR12MB36634DB3BB902D08EE331367FB3F0@MN2PR12MB3663.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB36634DB3BB902D08EE331367FB3F0@MN2PR12MB3663.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-01-07T08:21:37.097Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tao.Zhou1@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 935a56ec-f66e-451c-15fc-08d7934a9daa
x-ms-traffictypediagnostic: MN2PR12MB3694:|MN2PR12MB3694:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB369467E8A415655F689AB297B03F0@MN2PR12MB3694.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 027578BB13
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(366004)(346002)(39860400002)(136003)(376002)(199004)(189003)(91956017)(76116006)(19627405001)(6636002)(316002)(64756008)(66446008)(5660300002)(52536014)(86362001)(66556008)(55016002)(71200400001)(7696005)(9686003)(8936002)(15650500001)(110136005)(81166006)(81156014)(8676002)(66476007)(26005)(478600001)(186003)(6506007)(19627235002)(4744005)(53546011)(33656002)(2906002)(66946007)(21314003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3694;
 H:MN2PR12MB3054.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gIXag9iA05ucqcp96qOeo5QgxNzY+yQFfLaydRVlrCC61HrMIxOwmAgWcyRekI0S/9HdmXhbav3ZHekzyVIzYrV+lviS4eIpPRxcHUPoRB51zGo49mPytgPaie1GnxJC9cuXNsP93xuF1d+24Brkh7fchdgO97lVxzPdA+1s3Hl50kn7/cNbFbmlNx0P9EaykQjRmgHCV3m7DHh9MHO+s3MJeTjHSfemB5UArUe/ka0cG1Mt65EjfU8cz0+058BYd6l/A2B3HWUhQjmr3Y1sSMResn3OWNc5FOmOX3JvjNCQ766I0PqWsf3TJUaAYTEleetg+zpauY9M42/b/3E7TFHJ5eb8Ymi0VyqGDxPCXlbjmcJf5qxMA9OT12bGAQcL8exHzRuysot1ccXXegAecJxbgYWa2TXhw8N2HRy74yAug3JEKQF1sNdFH8irqL6ECDoLrOY089SHBbI8cvEfFDDuZYZosmtwOTPvKwLwjng=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 935a56ec-f66e-451c-15fc-08d7934a9daa
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2020 08:21:37.6638 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 90IRCfIgWTk0Xi7HTlFtxOFlGdzvOvzjSRsVxMF+EdpSdV9JtT5aSBiNg9cWWRIq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3694
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
Content-Type: multipart/mixed; boundary="===============1026842270=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1026842270==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB30543BD6C60A1D3667627DB9B03F0MN2PR12MB3054namp_"

--_000_MN2PR12MB30543BD6C60A1D3667627DB9B03F0MN2PR12MB3054namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

I prefer to calc channel_index like this:

channel_index =3D
    adev->umc.channel_idx_tbl[umc_inst * adapt->umc.channel_inst_num + ch_i=
nst];

idx_tbl is ASIC specific, using adev->umc.channel_idx_tbl instead can avoid=
 adding "if (adev->asic_type =3D=3D xxx)" in the future.

Regards,
Tao
________________________________
From: Clements, John <John.Clements@amd.com>
Sent: Tuesday, January 7, 2020 3:28 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; dl.srdc_=
lnx_ras <dl.srdc_lnx_ras@amd.com>
Subject: [PATCH] drm/amdgpu: updated UMC error address record with correct =
channel index


[AMD Official Use Only - Internal Distribution Only]


Resolved issue with inputting an incorrect UMC channel index into the UMC e=
rror address record.



Defined macros for repetitive for loops



Thank you,

John Clements

--_000_MN2PR12MB30543BD6C60A1D3667627DB9B03F0MN2PR12MB3054namp_
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
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
I prefer to calc channel_index like this:</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<i><span>channel_index =3D</span></i></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<i><span>&nbsp;&nbsp;&nbsp; adev-&gt;umc.channel_idx_tbl[</span><span>umc_i=
nst * adapt-&gt;umc.channel_inst_num &#43; ch_inst];</span></i></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<span><br>
</span></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<span>idx_tbl is ASIC specific, <span style=3D"font-family: calibri, arial,=
 helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0); background-co=
lor: rgba(0, 0, 0, 0);">
using adev-&gt;umc.channel_idx_tbl instead can avoid adding &quot;if (adev-=
&gt;asic_type =3D=3D xxx)&quot; in the future.</span></span></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Regards,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Tao<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Clements, John &lt;Jo=
hn.Clements@amd.com&gt;<br>
<b>Sent:</b> Tuesday, January 7, 2020 3:28 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;; dl.srdc_lnx_ras &lt;dl.srdc_lnx_ras@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: updated UMC error address record with c=
orrect channel index</font>
<div>&nbsp;</div>
</div>
<style>
<!--
@font-face
	{font-family:"Cambria Math"}
@font-face
	{font-family:DengXian}
@font-face
	{font-family:Calibri}
@font-face
	{}
p.x_MsoNormal, li.x_MsoNormal, div.x_MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif}
a:link, span.x_MsoHyperlink
	{color:#0563C1;
	text-decoration:underline}
a:visited, span.x_MsoHyperlinkFollowed
	{color:#954F72;
	text-decoration:underline}
span.x_EmailStyle17
	{font-family:"Calibri",sans-serif;
	color:windowtext}
.x_MsoChpDefault
	{font-family:"Calibri",sans-serif}
@page WordSection1
	{margin:1.0in 1.0in 1.0in 1.0in}
div.x_WordSection1
	{}
-->
</style>
<div lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72">
<p class=3D"x_msipheader4d0fcdd7" align=3D"Left" style=3D"margin:0"><span s=
tyle=3D"font-size:10.0pt; font-family:Arial; color:#0078D7">[AMD Official U=
se Only - Internal Distribution Only]</span></p>
<br>
<div class=3D"x_WordSection1">
<p class=3D"x_MsoNormal">Resolved issue with inputting an incorrect UMC cha=
nnel index into the UMC error address record.</p>
<p class=3D"x_MsoNormal">&nbsp;</p>
<p class=3D"x_MsoNormal">Defined macros for repetitive for loops</p>
<p class=3D"x_MsoNormal">&nbsp;</p>
<p class=3D"x_MsoNormal">Thank you,</p>
<p class=3D"x_MsoNormal">John Clements</p>
</div>
</div>
</body>
</html>

--_000_MN2PR12MB30543BD6C60A1D3667627DB9B03F0MN2PR12MB3054namp_--

--===============1026842270==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1026842270==--
