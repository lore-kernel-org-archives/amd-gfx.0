Return-Path: <SRS0=Gn/P=56=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED8E4C2BA19
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Apr 2020 08:12:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B1CC2072D
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Apr 2020 08:12:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="yz55F2su"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B1CC2072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F18188E56;
	Tue, 14 Apr 2020 08:12:44 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2089.outbound.protection.outlook.com [40.107.237.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB82D88E56
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Apr 2020 08:12:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GZAnMX6GnqWi15610GFp1TBjxJrLj6xfpb77c+MdRh4ktHMqirJBPqIqmWuw4NMhujccr1vqtx4okNRwR5tB/OQa0CEE01JRwOETxvJLqgyygFSh7y85LkcIvkeYAjbNbd4vH3GvZVhaYFOCUhKT8Sm/D5P5hyPa6RUlobK+rWIlT3hbi+JDA43zrDldmtFeBhbgMZZdPN25d4ggnffo+ZDTdQXFJsIdvwJG4q2Q/dRCRxJGv4C8TNZzjP2iP4KOtZ0v5pElMU6H1yLZqLh4DqFvUur74Sc69Y4WkUMiqR+LtUT0L4lP5CAtf9gvpSRNNkLzYqPybo9bKth4ZEuS+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yEJyeHsh7rLNuyMsge8cei9WQ1kfuaHUmKrCRf5fMro=;
 b=Cz8A8IKYJNwHzD+kSQZQmM6EwFt6PBCNDezlmCUyg/6yMGnu5gZs3qJP+fCo69lejtWosfxguhrn7tZk/KU5yeEMAHF3uudQDKwm09nAzL9uN8Ierl8WEQEKxjxxFgUXDI+mGej21Crm6fJYqLTS8zbW22lqcBHaN7XO94DxRb9JJxhs14uod3C7URm6yqoVjeW4UcHovoCe0mPx1qblcSSBEexFgOj0umNCJHRP55HsZAxZxt0xD3VzxXgDeSpVgReusD8M+R4oOpRz0iX5aH+14Enx4PVo4LcUop6BGH/hO9MyTv7buqPVc7xrbEKgVFfXB5dAUyiegBNuLIF+/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yEJyeHsh7rLNuyMsge8cei9WQ1kfuaHUmKrCRf5fMro=;
 b=yz55F2su1K5IWscZvteBr6RZUca4UeQxRV95pDs0SVY/rqM+sSCadW4UePwiN6jETxcaJeXEO8+DR4COWXqSScBsVdzewma/sjMTrkrasrfcAqnLwLJtZh0342OtTRrqgbg7JB51vIpFf2p7xMSXmzV+vN5+dM5iOb5ZQ6ldxbI=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3497.namprd12.prod.outlook.com (2603:10b6:5:3c::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2900.28; Tue, 14 Apr 2020 08:12:38 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5c27:185c:be20:1fb6]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5c27:185c:be20:1fb6%5]) with mapi id 15.20.2900.028; Tue, 14 Apr 2020
 08:12:38 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Clements, John" <John.Clements@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Subject: RE: [PATCH] series to refactor psp np fw loading
Thread-Topic: [PATCH] series to refactor psp np fw loading
Thread-Index: AdYSKyW3wSp/rB5lSkSFu9kz/7eu5AACPzww
Date: Tue, 14 Apr 2020 08:12:38 +0000
Message-ID: <DM6PR12MB2619773ED4F30336AE244DE5E4DA0@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <MN2PR12MB4032D3C0EC3E363471268799FBDA0@MN2PR12MB4032.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB4032D3C0EC3E363471268799FBDA0@MN2PR12MB4032.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-04-14T07:06:10Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=2bca3f23-3bab-4646-920e-0000b1718afc;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Evan.Quan@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: fad3fe4e-96f6-4686-5d63-08d7e04b988f
x-ms-traffictypediagnostic: DM6PR12MB3497:|DM6PR12MB3497:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB349783F18D919413DCBA29F5E4DA0@DM6PR12MB3497.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0373D94D15
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(136003)(39860400002)(346002)(396003)(376002)(366004)(9686003)(7696005)(8936002)(6636002)(2906002)(5660300002)(6506007)(53546011)(9326002)(86362001)(316002)(478600001)(8676002)(55016002)(81156014)(186003)(71200400001)(110136005)(76116006)(33656002)(66476007)(66946007)(66446008)(64756008)(52536014)(4744005)(66556008)(26005);
 DIR:OUT; SFP:1101; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Mt+e8vW6QDs0Ah0KO1oXywpnkw9BUtFsx0RzNwA/7qxgfsLyRTtgWfmfCGPdCY50NYOGSfJOXaWZXNvgTFrl1PPa6ujr4wWfcgwnV67Zr7kRGC7XDnzyqnkBv+vAsFI2ha5kBWAMxs6aQsS9d5zbgsHal7upeeLbfTKOyE6+7NNsCXqI7Wnz+28vTpQVyYTugkh4hJWkYvksFnqJ21IviqoXT+zh0iiEiS3gOgE2X8+6vkA/c4pQKQdJJ1/DSWjf/fkojX+Krm+NeF9N/UiZY5YQfk9I/FjhoA7Vkt/Tvd17YdkHE1CmrHuPKnSKmd27ShYn1Xg3XMQ+42xFF60bRxP0GoPMYinDzNEqnaA52GHMX/KxdBPqyGWcLE2gk8dbaX0phBBeToR1RtXSsyg74jY/R1/HmrbUbcyQj62CzQW7rJDwyRdD2lnOoOl0fSsT
x-ms-exchange-antispam-messagedata: a3ZAXthGqxV6iRSgJg2KP8fexNTL244LLSO8Usx0qsD51o4bAeiBLvDSp3/sa7e+tcWc6Bn3A3ZWb7GbSHOQtuYCoaW521h5bwPZPQOA1MUMWVOew2fQcOnmFSfA1BxE2bBOWqie4sm3UMFCbPVmTA==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fad3fe4e-96f6-4686-5d63-08d7e04b988f
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2020 08:12:38.1466 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aHs03qWMgZAwAWVKX6qTIUaYGtB1OmpXR2VBkL/6UhTmuHx1qtTBlj55hZwX5hrd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3497
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
Content-Type: multipart/mixed; boundary="===============0345370266=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0345370266==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM6PR12MB2619773ED4F30336AE244DE5E4DA0DM6PR12MB2619namp_"

--_000_DM6PR12MB2619773ED4F30336AE244DE5E4DA0DM6PR12MB2619namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi John,

Please limit this to RAS triggered gpu reset only.
if (adev->in_gpu_reset) {
As for non-RAS triggered gpu reset, smu fw reloading is not needed.

Regards,
Evan
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Clements=
, John
Sent: Tuesday, April 14, 2020 3:06 PM
To: amd-gfx@lists.freedesktop.org; Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH] series to refactor psp np fw loading


[AMD Official Use Only - Internal Distribution Only]

Submitting patch series to refactor psp np fw loading sequence and set MP1 =
state to unload in preparation for SMU FW loading during a GPU reset

Thank you,
John Clements

--_000_DM6PR12MB2619773ED4F30336AE244DE5E4DA0DM6PR12MB2619namp_
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
<p class=3D"MsoNormal">Hi John,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Please limit this to RAS triggered gpu reset only.<o=
:p></o:p></p>
<p class=3D"MsoNormal">if (adev-&gt;in_gpu_reset) {<o:p></o:p></p>
<p class=3D"MsoNormal">As for non-RAS triggered gpu reset, smu fw reloading=
 is not needed.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Regards,<o:p></o:p></p>
<p class=3D"MsoNormal">Evan<o:p></o:p></p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> amd-gfx &lt;amd-gfx-bounces@lists.freed=
esktop.org&gt;
<b>On Behalf Of </b>Clements, John<br>
<b>Sent:</b> Tuesday, April 14, 2020 3:06 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org; Zhang, Hawking &lt;Hawking.Zhang@=
amd.com&gt;<br>
<b>Subject:</b> [PATCH] series to refactor psp np fw loading<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"msipheadera92e061b" style=3D"margin:0in;margin-bottom:.0001pt">=
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;co=
lor:#0078D7">[AMD Official Use Only - Internal Distribution Only]</span><o:=
p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Submitting patch series to refactor psp np fw loadin=
g sequence and set MP1 state to unload in preparation for SMU FW loading du=
ring a GPU reset<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thank you,<o:p></o:p></p>
<p class=3D"MsoNormal">John Clements<o:p></o:p></p>
</div>
</div>
</body>
</html>

--_000_DM6PR12MB2619773ED4F30336AE244DE5E4DA0DM6PR12MB2619namp_--

--===============0345370266==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0345370266==--
