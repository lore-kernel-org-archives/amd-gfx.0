Return-Path: <SRS0=Gn/P=56=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12496C2BA19
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Apr 2020 08:16:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D807C206E9
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Apr 2020 08:16:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="rKpusi/E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D807C206E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E2F389CDD;
	Tue, 14 Apr 2020 08:16:04 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2088.outbound.protection.outlook.com [40.107.236.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 037A389CDD
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Apr 2020 08:16:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gtRoRrmO2+N3SOzaYkmJAmU2lJnXA4GtuSuOl3HiRbWUx4W79LxXJuxD/Zqltrxk6sgW/gPtljHirzerF+d3WcMMKVW/x9+hJJILcqKpAB1kayEP1uRm5aKPCNdcUYdQy7pAX+sd4NpD264pEHexbRSrfnYMGqhXGay4KYKYuR8NB0YEYA8S0rnzTWTl3gAlb8bos4XTN2gcW8dN/92SajT8t4SOnXu5BsjdWWkCMXXx+6Tlt2R8PsqUviJ0ubgiwZmIVBEatg9yZFl87IcxrgC5lxJ7UAVjKOuzbsuA4eNOYidX01rTAqzJw3Ues6jxcTTD5rqjsh9sEy+moCK4Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rJviFdp52Ucy2WKnpq7CEAM/LRT/Wdw73b/GnUDqs1k=;
 b=IA60471W2ZoMD6+y11OzNeDUs9Dkg3WPJohRbEEzUar++vjyS9bk3NI9ouLCKqIS+OvoH4ckDTr1Gbshk+JXk7F48FCAVHsI+pTvlmaEwXQWpId6L+xRroRt/y+0Kj6wppZtzD7PI96EOBtLOoRd3oD8fPYdSHIDOF9yOZhVNn6BHl3OE8nfnJuQucuokH/P7czJdgTYBnazCpUFo2uX6BD1sFf2ycNtOAuNhYIeTVd/wrox1asS1hSSGpuTtKoUoAb3a+RqxSn5MzcavOaLXwZWrMN5Y/jVEHpV8tyjYZPeZZnSP/mCiaenpR6WrCztf0OH5359CbJ6P3m120VBNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rJviFdp52Ucy2WKnpq7CEAM/LRT/Wdw73b/GnUDqs1k=;
 b=rKpusi/EmHHX9P7XtohP8namZ4XxYKl6pdjnnfFduEVlBJI+fZUrihpxQDmYkyJZBSrHd1qCgjTnSPUQ47zJGf3aBaze/pi5gz65TdCYkaXbyeQ6dZUWPLUY/GnhWTeJ0dyvAnwva9U71qEH5moG5sYMR3IvqjDT8DdZOVDrr/k=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3658.namprd12.prod.outlook.com (2603:10b6:5:1c8::24) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2900.28; Tue, 14 Apr 2020 08:15:59 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5c27:185c:be20:1fb6]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5c27:185c:be20:1fb6%5]) with mapi id 15.20.2900.028; Tue, 14 Apr 2020
 08:15:59 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Clements, John" <John.Clements@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: cache smu fw version info
Thread-Topic: [PATCH] drm/amdgpu: cache smu fw version info
Thread-Index: AdYSMcqAXw33BUFrS0SxAhKaAVYnawAAxMQw
Date: Tue, 14 Apr 2020 08:15:59 +0000
Message-ID: <DM6PR12MB2619E27829985E545B01AD33E4DA0@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <MN2PR12MB4032D32E4A4E55CF7DA771F7FBDA0@MN2PR12MB4032.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB4032D32E4A4E55CF7DA771F7FBDA0@MN2PR12MB4032.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-04-14T07:54:25Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=7fa29d7b-11e3-4e1c-b36a-0000e2a49d4e;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Evan.Quan@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 614a0d81-05e3-487e-c86c-08d7e04c108c
x-ms-traffictypediagnostic: DM6PR12MB3658:|DM6PR12MB3658:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB36581AADD08FE4FC0628E823E4DA0@DM6PR12MB3658.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 0373D94D15
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(136003)(396003)(376002)(346002)(39860400002)(366004)(66946007)(8676002)(76116006)(71200400001)(26005)(66476007)(8936002)(55016002)(86362001)(81156014)(33656002)(5660300002)(2906002)(186003)(66446008)(316002)(9686003)(7696005)(6636002)(110136005)(66556008)(64756008)(53546011)(6506007)(4744005)(478600001)(52536014);
 DIR:OUT; SFP:1101; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pmaNRqt8o7HFfWLHuoeyy7Nu9pZp5tT2Nqr6Vf9XEhJmkm6Onjf6R4aQ5wN7dJqhLCQdtQc8dL82eiHhQ2kbIqPtViqTuIchihzwthMgkg9DbEyeEufYLc0hpbVhnGK//H1YB9femNhSUpFny3tK2qaTyPOEF/a4Lyim3OgPMVLey/d56hH/yAHj6v3qcNTG5UrNQlBs1F1UvOP5zzFO0O1+L4i9tSMQFnr2gTm8LlRRsxIFf85W1B1+GMRPaAMre7iz+uc+z2LMJJvwuX9acaEtDiz1Dtv+4ba6BHlcTzryIBJWCbUi91mSH5LcVbYgtaMYpTj1rtE41BKUysGuLBK4K5WqwgKKAJRQ4MZPhJ/mlNLvrPdIo7bmyOkP/+SBUi7mKFgcdOabWShdO/TZ7REb2Ve7KB8qqpmS/KHw8fyD/FLoofE5nH7zfNasQmGj
x-ms-exchange-antispam-messagedata: jDKL72w8IGQ1BFCAyRp1FGjTiys4RyQFZp8zKz0ZkObgDiz4lSZJBczRjwyBDMVS4IQ4DNGdgLTGYwPywFUdr5wXSPBjRaSQUy1JF8t8VP1stOWjedPxo/1wTPV8FBcNoVmPalpSGkBVdEXYTBbiDw==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 614a0d81-05e3-487e-c86c-08d7e04c108c
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2020 08:15:59.5043 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tNBGx7WvBZEL8opWUylYBXWbQV3Tbqf6uzxKLZDNbjks8oyVHAJPqZboinIMVy2S
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3658
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
Content-Type: multipart/mixed; boundary="===============2112084207=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============2112084207==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM6PR12MB2619E27829985E545B01AD33E4DA0DM6PR12MB2619namp_"

--_000_DM6PR12MB2619E27829985E545B01AD33E4DA0DM6PR12MB2619namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Evan Quan <evan.quan@amd.com>

From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Clements=
, John
Sent: Tuesday, April 14, 2020 3:54 PM
To: amd-gfx@lists.freedesktop.org; Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: cache smu fw version info


[AMD Official Use Only - Internal Distribution Only]

Submitting patch to save smu fw version in local smu context to avoid multi=
ple erroneous submissions to smu when requesting smu version info

Thank you,
John Clements

--_000_DM6PR12MB2619E27829985E545B01AD33E4DA0DM6PR12MB2619namp_
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
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
p.msipheadera92e061b, li.msipheadera92e061b, div.msipheadera92e061b
	{mso-style-name:msipheadera92e061b;
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
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Reviewed-by: Evan Quan &lt;evan.quan@amd.com&gt;<o:p=
></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> amd-gfx &lt;amd-gfx-bounces@lists.freed=
esktop.org&gt;
<b>On Behalf Of </b>Clements, John<br>
<b>Sent:</b> Tuesday, April 14, 2020 3:54 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org; Zhang, Hawking &lt;Hawking.Zhang@=
amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: cache smu fw version info<o:p></o:p></p=
>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"msipheadera92e061b" style=3D"margin:0in;margin-bottom:.0001pt">=
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;co=
lor:#0078D7">[AMD Official Use Only - Internal Distribution Only]</span><o:=
p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Submitting patch to save smu fw version in local smu=
 context to avoid multiple erroneous submissions to smu when requesting smu=
 version info<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thank you,<o:p></o:p></p>
<p class=3D"MsoNormal">John Clements<o:p></o:p></p>
</div>
</div>
</body>
</html>

--_000_DM6PR12MB2619E27829985E545B01AD33E4DA0DM6PR12MB2619namp_--

--===============2112084207==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============2112084207==--
