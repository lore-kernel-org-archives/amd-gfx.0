Return-Path: <SRS0=u08i=64=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE27AC433DF
	for <amd-gfx@archiver.kernel.org>; Thu, 14 May 2020 03:29:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9794720659
	for <amd-gfx@archiver.kernel.org>; Thu, 14 May 2020 03:29:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="UJPDfAb5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9794720659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3014F6E05A;
	Thu, 14 May 2020 03:29:09 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700045.outbound.protection.outlook.com [40.107.70.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F33896E05A
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 May 2020 03:29:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GpDxacutfAEYNOFxFbRnZuJ1JDD+5mbOMZJuToHq+q3lrYsXo1pXm3JEuhcIJ/CKlMyqyhVLJTrhie9Ddl/r4jEv5oDoXPpUdQBm7IqbNVRp0R3ZaFsHdASLo1ziyyu5gnhV7y0Xzuwo2ovtGVDEaCUxZfjF+rqsM/dS2at31wCRouUrfRDDcl4M+0f3Jxdrl3TwI3Rl+g/p2Wx5U5QDp5Axxmhmvr6JazseUBu5ONxE8c+bdLFpL0zhdu5zhf6hMUHrCm5ixYlqGErG7zxAVtzX/tAhceUV/+qm2ZecVN6agQKzUnsFUZUzUYxvp2FB4ZMxQJp+auspxip6RFrUtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3+26KTTkHTGHKL5pGflQ1g6FEUNFS8GEdQtMKmytCcc=;
 b=JsIPxQ9gCE8LclbRzqs/ruLeqmaJJmDZRQE+Cqku0Wjph4PBoi52hasd80RLCIBhdsm9HxuSM5NfkpnSZTqUYpgdBASh2ddsRnWfiTLujLNDk+CjANMdfxQ6bLt+E8wGk2e8a7nbTkdOcweN9zTMiYtUMxDeGeWfPsvDfPVyTLIKZSZgfuR7NxYyRCYduKUCSMywtjYP4Eo0ulSlUNP5f+5nJkvSnswXGv2s1FTL2mF85g2pk8K9yT6O/rX6Gth8bVd9Z5txk0m9XXpnK3UfRBRiuAjsvw6X3FMa2SFrVKJhkMBfR3WSYge+RYfbe/8cNTFUiFlwgVLil1gQ7GbxLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3+26KTTkHTGHKL5pGflQ1g6FEUNFS8GEdQtMKmytCcc=;
 b=UJPDfAb5qPTn854/cUq68CMqYT9j13wdWu3iHusmsUvEhF4BGELr8OCU4TbLRTTWmPAr2EmKIV9dc7m1RqY4CNri8pHy5KtjvlNRQqxvb4Qn+7VceqSh3UBXzBdafeywT9l6hN8YvZLs6NJhGPOqVEFxGC97X4XM6E7jf9Mtvkw=
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM6PR12MB4059.namprd12.prod.outlook.com (2603:10b6:5:215::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2979.29; Thu, 14 May 2020 03:29:05 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::50d1:ecd6:255c:fbcd]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::50d1:ecd6:255c:fbcd%3]) with mapi id 15.20.3000.022; Thu, 14 May 2020
 03:29:05 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Clements, John" <John.Clements@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Updated XGMI power down control support check
Thread-Topic: [PATCH] drm/amdgpu: Updated XGMI power down control support check
Thread-Index: AdYpnuomCOWNN6xTQ3qSrEzRWEr9bQAADU2w
Date: Thu, 14 May 2020 03:29:05 +0000
Message-ID: <DM6PR12MB4075358BB00418B855FF2576FCBC0@DM6PR12MB4075.namprd12.prod.outlook.com>
References: <MN2PR12MB403246890DD1D28759B02AE4FBBC0@MN2PR12MB4032.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB403246890DD1D28759B02AE4FBBC0@MN2PR12MB4032.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-05-14T03:23:06Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=872cd518-927d-4e3b-9445-0000cec78b44;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-05-14T03:29:02Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: e6668865-ba7c-4f03-b627-0000b87e16f9
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6498f485-45fd-4c0f-d2d2-08d7f7b6f4c1
x-ms-traffictypediagnostic: DM6PR12MB4059:|DM6PR12MB4059:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB4059864D6A9CCA495744F4DFFCBC0@DM6PR12MB4059.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2733;
x-forefront-prvs: 040359335D
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JMKeO6M4Wwc0UXeqk5WexuKUrBf6jq5vq03vBkxxwnIssr4gmjblAqPFhwaYUuyLtZdwErZqPhmhG9XdhgJ/Yoilu7tr08/biIAf6w+111zDmiIbUe6LwS40iZ4DLlsjxpLwYdxJVz5VnOK/SPF0E3Rx59FN0JOSsVXytnn8B7d/UZb0EbtsN8gMxf4xX+y1FS7pKbs9ZgN0RsjDq1s+58MxcneMnjf6imcQCi38rKcppnuOgF9weY+lY4olFyvsMK+tOSZP3H/46XHsQSHQ9dttSYPROkQQ+kKj+1h2PI5F6EIVrTIXSXO9q98TnxLX6Cg7QM9QUtlH2hXMGVEULzfOkQyVwpOGtldO5wZhN+VWbg7shJvmbp2yK4QG4AA4Fe3ObjChYH7PQSbj7M2n12+8I5D8DRdxyLCYVsVtYnpwy9S+QNENEXlVM5/NH1Tl
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(136003)(366004)(376002)(396003)(346002)(64756008)(6506007)(5660300002)(53546011)(66476007)(8936002)(15650500001)(55016002)(478600001)(4744005)(66946007)(71200400001)(86362001)(76116006)(26005)(2906002)(66446008)(7696005)(8676002)(186003)(316002)(33656002)(110136005)(52536014)(9686003)(66556008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: 0T0FJLqk8S6bProU7icy0NrTvkaGdAJ5HA/SCqybe+t4jZfMYG1YDquJehzGdG8iI0LXHvdP508MtM5NByNyLuTHLq1EK60KN0T2Ms5Nc4Ev/tbpmbAEOXSgaERn2erGj6TA/2O4QU2uNXTO6WA99ABYJCrfPvNtm+VzujkMC2r3VGoUAGF0hLPEhzoOMi+QW1lVdcARtGNV/mWmQu65mZeuM4eqKewaqjj+hFciwVZr7Qs/nJjuT71Lesl9US0RGe4TxeS+onxNY/1BQ65C97rrIzmvVGSxA0KE/Duj1wudgUk6YQdMcy84td0AVh91Lo5roKWA5VyiGlrBL5ffcGcvPjt6jADTS90JIRqA1tGowtONfY8AkL2Lo/xBCOIXsQ1Z9nv+flYB5/8ZHXEIpPZM+IjBV91B+8UNROarDViartXD4VVfFpsbCk2aEZ/AWdFW9zQ9Mfl62hF2OVCUe8WCnuJms0kq9jExukWpQaG79muDIkfCneilBUPIyiIX
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6498f485-45fd-4c0f-d2d2-08d7f7b6f4c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2020 03:29:05.7332 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DcjhBieNxYumtko1hY9GD4VxhpoPWIDogMzHdNZ8U+w475giloGmG0WyIYZBQPpipJmI7Q3AHZhn6X9HnzWBOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4059
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
Content-Type: multipart/mixed; boundary="===============1364169363=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1364169363==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM6PR12MB4075358BB00418B855FF2576FCBC0DM6PR12MB4075namp_"

--_000_DM6PR12MB4075358BB00418B855FF2576FCBC0DM6PR12MB4075namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
From: Clements, John <John.Clements@amd.com>
Sent: Thursday, May 14, 2020 11:23
To: amd-gfx@lists.freedesktop.org; Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: Updated XGMI power down control support check


[AMD Official Use Only - Internal Distribution Only]

Updated SMC FW version check to determine if XGMI power down control is sup=
ported

--_000_DM6PR12MB4075358BB00418B855FF2576FCBC0DM6PR12MB4075namp_
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
<p class=3D"MsoNormal">Reviewed-by: Hawking Zhang &lt;Hawking.Zhang@amd.com=
&gt;<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Regards,<br>
Hawking<o:p></o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Clements, John &lt;John.Clements@amd.co=
m&gt; <br>
<b>Sent:</b> Thursday, May 14, 2020 11:23<br>
<b>To:</b> amd-gfx@lists.freedesktop.org; Zhang, Hawking &lt;Hawking.Zhang@=
amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: Updated XGMI power down control support=
 check<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"msipheadera92e061b" style=3D"margin:0in;margin-bottom:.0001pt">=
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;co=
lor:#0078D7">[AMD Official Use Only - Internal Distribution Only]</span><o:=
p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Updated SMC FW version check to determine if XGMI po=
wer down control is supported<o:p></o:p></p>
</div>
</body>
</html>

--_000_DM6PR12MB4075358BB00418B855FF2576FCBC0DM6PR12MB4075namp_--

--===============1364169363==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1364169363==--
