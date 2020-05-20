Return-Path: <SRS0=vyzA=7C=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.4 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 376ACC433DF
	for <amd-gfx@archiver.kernel.org>; Wed, 20 May 2020 02:26:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2C0D2075F
	for <amd-gfx@archiver.kernel.org>; Wed, 20 May 2020 02:26:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="osoyTPkP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2C0D2075F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 267896E10C;
	Wed, 20 May 2020 02:26:12 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2075.outbound.protection.outlook.com [40.107.236.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E1D026E10C
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 May 2020 02:26:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eEFbu1KGk0m9ct+4Y9ooeIIVONNSFfFETbNzUzPU59FVyxqzkIiJxuoS0zXsKoRVlBA/ihwCHOgO9D50owMcE2a3QsDV1tAgyPqq6FQ7fS/ZxZFRSZK9aC/PQdPjQ/EUHhSG3QgUb5ytkW/4qPEqbkT0edOZ3RHI5S/doB19ckKRUzg+dwuZYeseiQg1BSd+CR9Ay71vypQi8cXW/c/dUANazdgjagiIfzsOMZyEuwklABEmXoWpgy1IinUkO7DSLR2Ss00E8cDmgxjhqyqCnzvYgOReONS5ULvkMlCm75brH1uq14KHmWN8zaKo93F1WMdcfCMI11/He06baR67Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O3TAKHbxQN//J2DspeVVYnryZYlUsgzBAXutSEE4mHI=;
 b=AYTFQI5PkrVJVrvUiBnYy5TtlKJ2FMarYmlBisyP9yQxEMHEylxJsCcpMuIzkjk4E+gjwylhkauj9zQ5UpNXMmvHMopHJP6hWojS4jOYQCRFPIkkaIU6PYHhRa8Ky0O4IdtR9/5UQE3mDuUKmN7p14FtGukLYP9NruNKJkNo5ObS5aOEdQ+ErR8qNSOpGmA3q0tEzQ822TCff7EXk23IvAosrSsCB7yPvt/GIoXMo9JepdBnIY3TpTgD88bVuTyAjU4ydVvLo4ejOojFGP46ddTla5iVIpDXSrZTcTcU7jAQzhiF9udvvqS4tilwFbKZUk+8+EkMgL9NLmq0bKcdVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O3TAKHbxQN//J2DspeVVYnryZYlUsgzBAXutSEE4mHI=;
 b=osoyTPkPJNwbk5xmkcJieKflfX5Sgua4KTRKMu+7Why1kG9X2fqiud1S8yJxkAcDJWb7DqCQRiAhtTs2u9Z2xOrXOzogIAYNCrJyuJVyyeP3EWoMEnC6YfMIvD2NgyFIovHDfbce6eb7JlgHrKY5EEknQxH+WraEf2i/oCaXKzw=
Received: from DM6PR12MB4026.namprd12.prod.outlook.com (2603:10b6:5:1cc::33)
 by DM6PR12MB4481.namprd12.prod.outlook.com (2603:10b6:5:2af::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23; Wed, 20 May
 2020 02:26:08 +0000
Received: from DM6PR12MB4026.namprd12.prod.outlook.com
 ([fe80::a140:65c9:d28c:101a]) by DM6PR12MB4026.namprd12.prod.outlook.com
 ([fe80::a140:65c9:d28c:101a%7]) with mapi id 15.20.3000.022; Wed, 20 May 2020
 02:26:08 +0000
From: "Clements, John" <John.Clements@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: resolve ras recovery vs smi race condition
Thread-Topic: [PATCH] drm/amdgpu: resolve ras recovery vs smi race condition
Thread-Index: AdYtvciAHbipIGpZT6qk0o/TamXupgACE0ygACH3ObA=
Date: Wed, 20 May 2020 02:26:08 +0000
Message-ID: <DM6PR12MB40267E4394FB2F93F23C7094FBB60@DM6PR12MB4026.namprd12.prod.outlook.com>
References: <DM6PR12MB4026718C8DD47807F9856F3FFBB90@DM6PR12MB4026.namprd12.prod.outlook.com>
 <DM6PR12MB4075736EFBC2A476F7EE3F78FCB90@DM6PR12MB4075.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB4075736EFBC2A476F7EE3F78FCB90@DM6PR12MB4075.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-05-19T09:14:31Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=6334e757-9313-4c47-aeb1-00001eb443f7;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-05-20T02:26:04Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 7e189a7e-571b-410f-b166-0000f2d83cc4
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 94238560-5d4b-4b82-f4db-08d7fc6527db
x-ms-traffictypediagnostic: DM6PR12MB4481:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB44810E6E6384BD0AA8C1A303FBB60@DM6PR12MB4481.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3173;
x-forefront-prvs: 04097B7F7F
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Q9afhKKbNNR1eg4Tv6UsIYCOznjnuy9FBZPbUWktaSkorPCDojJmy2JDOneQ6FNB0sdGwzKSqMphQ2U4aC+OVct43sTBgOTBvLrHfXSKezp4XoYYa/es08kco9XGblSbOhXNeKkPoaicLaZGa6JrsMB5KyOYCgFgwJvxSSMOk4+mjaobfsV0kqcBh9TUx8MCIFHolEJOcLdAnVz/shdKCkk5WDTfYW/UVwxBnXcCwe/KOSIYaCjXkAqt5QZGBHt9ysj/Gc8kvcTCYklxxBJYTrMGvg+3cSb8hJTYlg4+h+PjbF6Mdur0ZqVA3pIecfQF
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4026.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(396003)(346002)(366004)(39850400004)(376002)(71200400001)(86362001)(26005)(55016002)(316002)(52536014)(7696005)(99936003)(186003)(6506007)(53546011)(33656002)(76116006)(66556008)(66616009)(66946007)(64756008)(4744005)(66446008)(9686003)(5660300002)(478600001)(110136005)(66476007)(2906002)(8676002)(8936002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: jQpqF7yo/LQC8+xekVK0lrFolLPCMXVdaHiEBWf2ePFOs3ep5ker1S5cLQS7lrnaG43npRFlgXhbobm6BTcUD4d52uip8LXmkQ5IXf4YI0yZEzBC7t33nKsQljkmwWfAo1fhUGt5EDWdAkjxcRqM2F3hh42Mol3CdfhioZFIOvUFQlLWk7BUDh+s5auCfkBxR2fvA5eHpJuvR2ly6pLVL/Y/NqkF9W9A4pk3q2IkgYgCnrov1NjE8MXD7orc8Uguk/3jTvrw7Apf0FhGi9usN7iCcQI8XyxZk2HvgsHglDYeh7UmMArs3k1IMzpQny9qfZQ/ldyLgYwO9OMDaJHXPQE0f6V0h1Ey6ioj8VmIOJ0u9kps/g9lPufvjxVXDU2PDq09QJ4wfjivTVCRInB79adtKZc7c9SWrJfr4nlGz0YAlRbif0j2th0nekzpiB7PDKG2Z7QKYr6rtOO1s1DMl3UobT21QzoD8SgiMfMkKAg7EUSSbwZD2oigW8crzvSE
Content-Type: multipart/mixed;
 boundary="_004_DM6PR12MB40267E4394FB2F93F23C7094FBB60DM6PR12MB4026namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94238560-5d4b-4b82-f4db-08d7fc6527db
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2020 02:26:08.5598 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NhVRs+E1frSHkYSL915UTp1KaYn69DNbYJUpJuuYyjJlzRVJ8XwUpCEMVVozlMBB3HIzmnyqGJF3LQPlLr+p+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4481
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

--_004_DM6PR12MB40267E4394FB2F93F23C7094FBB60DM6PR12MB4026namp_
Content-Type: multipart/alternative;
	boundary="_000_DM6PR12MB40267E4394FB2F93F23C7094FBB60DM6PR12MB4026namp_"

--_000_DM6PR12MB40267E4394FB2F93F23C7094FBB60DM6PR12MB4026namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Thank you Hawking,

I have updated/tested the patch based of your recommendation.

From: Zhang, Hawking <Hawking.Zhang@amd.com>
Sent: Tuesday, May 19, 2020 6:27 PM
To: Clements, John <John.Clements@amd.com>; amd-gfx@lists.freedesktop.org
Subject: RE: [PATCH] drm/amdgpu: resolve ras recovery vs smi race condition


[AMD Official Use Only - Internal Distribution Only]

Please only apply the check to arcturus - we don't need to check ras fatal =
error event on all the NV series.

Regards,
Hawking
From: Clements, John <John.Clements@amd.com<mailto:John.Clements@amd.com>>
Sent: Tuesday, May 19, 2020 17:15
To: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>; Zh=
ang, Hawking <Hawking.Zhang@amd.com<mailto:Hawking.Zhang@amd.com>>
Subject: [PATCH] drm/amdgpu: resolve ras recovery vs smi race condition


[AMD Official Use Only - Internal Distribution Only]

Submitting patch to block SMU access' via SMI during RAS recovery

--_000_DM6PR12MB40267E4394FB2F93F23C7094FBB60DM6PR12MB4026namp_
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
<style><!--
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
p.msipheadera92e061b, li.msipheadera92e061b, div.msipheadera92e061b
	{mso-style-name:msipheadera92e061b;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle19
	{mso-style-type:personal-compose;
	font-family:"Arial",sans-serif;
	color:#0078D7;}
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
<p class=3D"msipheadera92e061b" style=3D"margin:0in;margin-bottom:.0001pt">=
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;co=
lor:#0078D7">[AMD Official Use Only - Internal Distribution Only]</span><o:=
p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thank you Hawking,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I have updated/tested the patch based of your recomm=
endation.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Zhang, Hawking &lt;Hawking.Zhang@amd.co=
m&gt; <br>
<b>Sent:</b> Tuesday, May 19, 2020 6:27 PM<br>
<b>To:</b> Clements, John &lt;John.Clements@amd.com&gt;; amd-gfx@lists.free=
desktop.org<br>
<b>Subject:</b> RE: [PATCH] drm/amdgpu: resolve ras recovery vs smi race co=
ndition<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"msipheadera92e061b" style=3D"margin:0in;margin-bottom:.0001pt">=
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;co=
lor:#0078D7">[AMD Official Use Only - Internal Distribution Only]</span><o:=
p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Please only apply the check to arcturus &#8211; we d=
on&#8217;t need to check ras fatal error event on all the NV series.<o:p></=
o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Regards,<br>
Hawking<o:p></o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Clements, John &lt;<a href=3D"mailto:Jo=
hn.Clements@amd.com">John.Clements@amd.com</a>&gt;
<br>
<b>Sent:</b> Tuesday, May 19, 2020 17:15<br>
<b>To:</b> <a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.f=
reedesktop.org</a>; Zhang, Hawking &lt;<a href=3D"mailto:Hawking.Zhang@amd.=
com">Hawking.Zhang@amd.com</a>&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: resolve ras recovery vs smi race condit=
ion<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"msipheadera92e061b" style=3D"margin:0in;margin-bottom:.0001pt">=
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;co=
lor:#0078D7">[AMD Official Use Only - Internal Distribution Only]</span><o:=
p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Submitting patch to block SMU access&#8217; via SMI =
during RAS recovery<o:p></o:p></p>
</div>
</body>
</html>

--_000_DM6PR12MB40267E4394FB2F93F23C7094FBB60DM6PR12MB4026namp_--

--_004_DM6PR12MB40267E4394FB2F93F23C7094FBB60DM6PR12MB4026namp_
Content-Type: application/octet-stream;
	name="0001-drm-amdgpu-resolve-ras-recovery-vs-smi-race-conditio.patch"
Content-Description:  0001-drm-amdgpu-resolve-ras-recovery-vs-smi-race-conditio.patch
Content-Disposition: attachment;
	filename="0001-drm-amdgpu-resolve-ras-recovery-vs-smi-race-conditio.patch";
	size=1302; creation-date="Wed, 20 May 2020 02:13:37 GMT";
	modification-date="Wed, 20 May 2020 02:13:54 GMT"
Content-Transfer-Encoding: base64

RnJvbSBhMzllMmIwZGVhY2E1YzA4ODY5ZTIwNzNmZTZlYzAwNTU3YjFmZWU1IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBKb2huIENsZW1lbnRzIDxqb2huLmNsZW1lbnRzQGFtZC5jb20+
CkRhdGU6IFdlZCwgMjAgTWF5IDIwMjAgMTA6MTI6NTQgKzA4MDAKU3ViamVjdDogW1BBVENIXSBk
cm0vYW1kZ3B1OiByZXNvbHZlIHJhcyByZWNvdmVyeSB2cyBzbWkgcmFjZSBjb25kaXRpb24KCmR1
cmluZyByYXMgcmVjb3ZlcnkgYmxvY2sgc211IGFjY2VzcyB2aWEgc21pCgpTaWduZWQtb2ZmLWJ5
OiBKb2huIENsZW1lbnRzIDxqb2huLmNsZW1lbnRzQGFtZC5jb20+CkNoYW5nZS1JZDogSTI2OGRk
NWVhNWZmMDAyYjM0ODliNzUwMDdmMzM3ODc0YWY1NGY3ODAKLS0tCiBkcml2ZXJzL2dwdS9kcm0v
YW1kL3Bvd2VycGxheS9hcmN0dXJ1c19wcHQuYyB8IDYgKysrKysrCiAxIGZpbGUgY2hhbmdlZCwg
NiBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBs
YXkvYXJjdHVydXNfcHB0LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9hcmN0dXJ1
c19wcHQuYwppbmRleCBjYmY3MDEyMmRlOWIuLjI3YzVmYzk1NzJiMiAxMDA2NDQKLS0tIGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvYXJjdHVydXNfcHB0LmMKKysrIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9wb3dlcnBsYXkvYXJjdHVydXNfcHB0LmMKQEAgLTYyMyw2ICs2MjMsOSBAQCBz
dGF0aWMgaW50IGFyY3R1cnVzX3ByaW50X2Nsa19sZXZlbHMoc3RydWN0IHNtdV9jb250ZXh0ICpz
bXUsCiAJc3RydWN0IHNtdV9kcG1fY29udGV4dCAqc211X2RwbSA9ICZzbXUtPnNtdV9kcG07CiAJ
c3RydWN0IGFyY3R1cnVzX2RwbV90YWJsZSAqZHBtX3RhYmxlID0gTlVMTDsKIAorCWlmIChhbWRn
cHVfcmFzX2ludHJfdHJpZ2dlcmVkKCkpCisJCXJldHVybiBzbnByaW50ZihidWYsIFBBR0VfU0la
RSwgInVuYXZhaWxhYmxlXG4iKTsKKwogCWRwbV90YWJsZSA9IHNtdV9kcG0tPmRwbV9jb250ZXh0
OwogCiAJc3dpdGNoICh0eXBlKSB7CkBAIC05OTgsNiArMTAwMSw5IEBAIHN0YXRpYyBpbnQgYXJj
dHVydXNfcmVhZF9zZW5zb3Ioc3RydWN0IHNtdV9jb250ZXh0ICpzbXUsCiAJUFBUYWJsZV90ICpw
cHRhYmxlID0gdGFibGVfY29udGV4dC0+ZHJpdmVyX3BwdGFibGU7CiAJaW50IHJldCA9IDA7CiAK
KwlpZiAoYW1kZ3B1X3Jhc19pbnRyX3RyaWdnZXJlZCgpKQorCQlyZXR1cm4gMDsKKwogCWlmICgh
ZGF0YSB8fCAhc2l6ZSkKIAkJcmV0dXJuIC1FSU5WQUw7CiAKLS0gCjIuMTcuMQoK

--_004_DM6PR12MB40267E4394FB2F93F23C7094FBB60DM6PR12MB4026namp_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_004_DM6PR12MB40267E4394FB2F93F23C7094FBB60DM6PR12MB4026namp_--
