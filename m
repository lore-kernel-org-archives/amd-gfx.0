Return-Path: <SRS0=0vKA=BN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EB72C433DF
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Aug 2020 06:15:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E672120672
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Aug 2020 06:15:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="t2dlPu2p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E672120672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E37876E20D;
	Mon,  3 Aug 2020 06:15:18 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2046.outbound.protection.outlook.com [40.107.243.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 583926E20D
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Aug 2020 06:15:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=igmNkJ4lVdT0BFoDkRDS/jrNw5qsSoD0g+3kzb8vEddWyXfkHTMzr8qATttmAzhq+6vIThJ9p4xfGJROkLqhD5BFkhil2swV/41aY3XkbZxWMkrQzWxojRjnFljHrrAVar98I7s8yygUcjqWQVoDWoFXBlstgdp7Vs9ClkJxZC5/6xs9Wq6kyt/7CIK2uYMdf+rIBtaLP6CISuuPFdbidLkFsGqymXgbj3Jcc+rwhrBv32tuRYblsdMq+FPobOS6kpMoNapvu/e5N7VAgEJmIT/xSNUULOQ5a55JWx1d5Gt4xQSBlZDhmhFGokQ9ykiO9e5vdNb1FzLVSK20doPY6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BYHRubM+QudfJL7ITI3u72rCRQgHwIsQOdR51vqusHQ=;
 b=a+8GixPQOQ9ijGohWyyv1+IljJHqeb1ZcfN/pbbf4QGZDM7P69RIMfE7ztYCVcCGT4PGL2Z4NPNu0tTFQ9Loyqqi9e2Oh6/Ndk0qmYF3qU1MAY4El999HomvtAWx3lD9VR/WCQ5jRM30t104ye7EHfBXSsm4pzyAmI1O7ON1uPkxaFU1IXaFF/6b5SB17eVe6WuXm+FS1F1s6v0B21f7sYOti3Wou9i+pVCpM9tAdYe3Krp/aLe6wNJ1zI2DwHkG6rd5Pm6Ko0pjEELSzWTtO5mkj6h+WsZDtlBrYu+VSsJHtPvOieJhbCEXqhM27E+sgYm/+hPE3MuEwuPXD6FK4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BYHRubM+QudfJL7ITI3u72rCRQgHwIsQOdR51vqusHQ=;
 b=t2dlPu2pvJqz212wLbCAFr85R376Hb5XkZLdcJwDR9AaVWX4JOgJt93w/iVOkamhoYucjNmv7kQCbt6TuiaWKBy+nmI9pakrgT4AqFvpAQ/ukFY25ldxHzQk93DDLgo2bIo9n9Itn53PjRImnexjbhypFH/ddVMEg/h/ar1v9Go=
Received: from CY4PR12MB1287.namprd12.prod.outlook.com (2603:10b6:903:40::8)
 by CY4PR12MB1158.namprd12.prod.outlook.com (2603:10b6:903:40::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.17; Mon, 3 Aug
 2020 06:15:12 +0000
Received: from CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::e181:b736:5067:12f2]) by CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::e181:b736:5067:12f2%9]) with mapi id 15.20.3239.021; Mon, 3 Aug 2020
 06:15:12 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Clements, John" <John.Clements@amd.com>, amd-gfx list
 <amd-gfx@lists.freedesktop.org>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: enable RAS support for sienna
Thread-Topic: [PATCH] drm/amdgpu: enable RAS support for sienna
Thread-Index: AdZpW0yRASYpPXOeRrWELF9H7Dx0bQAAagtA
Date: Mon, 3 Aug 2020 06:15:12 +0000
Message-ID: <CY4PR12MB12871927038F06D4EAA0D337F14D0@CY4PR12MB1287.namprd12.prod.outlook.com>
References: <MN2PR12MB403260349869815CF543201FFB4D0@MN2PR12MB4032.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB403260349869815CF543201FFB4D0@MN2PR12MB4032.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-08-03T06:00:38Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=8643324a-d5bd-44bd-b7fc-000054a2e6d2;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-08-03T06:15:09Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 0b1e6e95-9b20-4fa1-b4a7-000000580140
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3b409c87-f964-4c42-b3f7-08d8377494a1
x-ms-traffictypediagnostic: CY4PR12MB1158:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR12MB115828B1ECEF3FAC2DCC70F9F14D0@CY4PR12MB1158.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KVpnsHBIptVBDB+gsZEQ0X7UPEnQCorKcgm4CnE2g1X8coSPpOcIPCIh9oMI2mwqVZU85wDcOk51EJYNCOIdn6YP/iWO1Qo5tz+M/nmnBLEmMAshM0W4bV5rJgToeSg7/uekTd1NiF7aV3a8iqiJAJ9F4+6KAm6M2EP1iXj7VDlpzi6PA7p3g6Obn+QbCwVv2VlhsPcxoQPrb0YQcmjb7TaUWEEp47mERiWGhPw/MA7Scnu3Z6yThxcRPN/eLtj4+pCzdABTq37II6TH0WuH09CKIL/6BG/jkVfUuJXLrJn1APgtmPMKFlUXNG6SHKx7kmIO8wweH/hvXJJbkBKLhQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1287.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(376002)(366004)(39860400002)(136003)(396003)(71200400001)(86362001)(316002)(110136005)(6506007)(53546011)(186003)(52536014)(7696005)(33656002)(5660300002)(4744005)(66946007)(6636002)(8936002)(2906002)(66446008)(64756008)(66556008)(66476007)(26005)(76116006)(9686003)(8676002)(55016002)(478600001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: wJwLrPkzOWolifj1C5vjicrCw8eYIO7IY71PzyaldHNo+Psc9jWHQzhbid3Q+IN3sKltD9Uc3TEWahz0EvYSymDdLJN9mvT0DvdrT9fzS9AFpxM2yjwilBM9iimrRqa2qII07wANvHj6T1FiSINIzMDdtr0252vg+CFB0zNTDocCbkFLZh20Shwaxoxt3J13iYb1ERt8+AiL3ot7VUmlLIcX7vaBmZzSpwVP0tbzV7teukDFCle6LKP/9Tv8wbWQmgeLm6HcDcQ6Ah+25z/wYX8HN0FGsU/kIA1pIIl9Egg8CHoI760o025qMT5slRzk4lVAABrfTcD7RwTncaXRr/Vjc/+m1K5I6qNTD5IXqB5Q+097gYOJTKLnSZ52bXYU5a2Y0E5zJFfjd8oP1lO2k/Cux8acMZajqBR4Ng2+1AhXVSNJ2guwhsyozC/WLmelACNs3Ur0ATjPKCTtQFE2fjoYYh3BFiAH6eX4sPt0sjF2aUCGcqlSxU0zRXql3TBZuVfaIL+1ZwSzVkA0WiloFtRsVJn4EmdRPfNWyQvLX6c6k0NnEm1H/8CEDgbmWVgeUWroYSQRpR/oLzDvLhAFGwQHfeODZ7F3XCDOOBQACsORY6MT5HsLtRm2l8UtKn42IoYsrftFNQm3JSSHXbG8gw==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1287.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b409c87-f964-4c42-b3f7-08d8377494a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2020 06:15:12.1005 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: weeXUZhwK/yM0q+VNHEIekN6ggifFWXwmw4hCUx0sxFf9z69cvAQLR2r+nxrg9Br/1HnCn75l/GmLiVTw2hgZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1158
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
Content-Type: multipart/mixed; boundary="===============0812222765=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0812222765==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CY4PR12MB12871927038F06D4EAA0D337F14D0CY4PR12MB1287namp_"

--_000_CY4PR12MB12871927038F06D4EAA0D337F14D0CY4PR12MB1287namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

In patch subject, chip full name SIENNA_CICHLID is preferred.

With above addressed, the patch is:
Reviewed-by: Guchun Chen <guchun.chen@amd.com>

Regards,
Guchun

From: Clements, John <John.Clements@amd.com>
Sent: Monday, August 3, 2020 2:01 PM
To: amd-gfx list <amd-gfx@lists.freedesktop.org>; Zhang, Hawking <Hawking.Z=
hang@amd.com>; Chen, Guchun <Guchun.Chen@amd.com>
Subject: [PATCH] drm/amdgpu: enable RAS support for sienna


[AMD Public Use]

Submitting patch to turn on GECC error injection /query support for sienna =
cichilid.

Thank you,
John Clements

--_000_CY4PR12MB12871927038F06D4EAA0D337F14D0CY4PR12MB1287namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:dt=3D"uuid:C2F41010-65B3-11d1-A29F-00AA00C14882" xmlns:m=3D"http://sc=
hemas.microsoft.com/office/2004/12/omml" xmlns=3D"http://www.w3.org/TR/REC-=
html40">
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
p.msipheader251902e5, li.msipheader251902e5, div.msipheader251902e5
	{mso-style-name:msipheader251902e5;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle19
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
p.msipheader87abd423, li.msipheader87abd423, div.msipheader87abd423
	{mso-style-name:msipheader87abd423;
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
<p class=3D"msipheader87abd423" style=3D"margin:0in;margin-bottom:.0001pt">=
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;co=
lor:#317100">[AMD Public Use]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">In patch subject, chip full name SIENNA_CICHLID is p=
referred.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">With above addressed, the patch is:<o:p></o:p></p>
<p class=3D"MsoNormal">Reviewed-by: Guchun Chen &lt;guchun.chen@amd.com&gt;=
<o:p></o:p></p>
<div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Regards,<o:p></o:p></p>
<p class=3D"MsoNormal">Guchun<o:p></o:p></p>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Clements, John &lt;John.Clements@amd.co=
m&gt; <br>
<b>Sent:</b> Monday, August 3, 2020 2:01 PM<br>
<b>To:</b> amd-gfx list &lt;amd-gfx@lists.freedesktop.org&gt;; Zhang, Hawki=
ng &lt;Hawking.Zhang@amd.com&gt;; Chen, Guchun &lt;Guchun.Chen@amd.com&gt;<=
br>
<b>Subject:</b> [PATCH] drm/amdgpu: enable RAS support for sienna<o:p></o:p=
></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"msipheader251902e5" style=3D"margin:0in;margin-bottom:.0001pt">=
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;co=
lor:#317100">[AMD Public Use]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Submitting patch to turn on GECC error injection /qu=
ery support for sienna cichilid.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thank you,<o:p></o:p></p>
<p class=3D"MsoNormal">John Clements<o:p></o:p></p>
</div>
</body>
</html>

--_000_CY4PR12MB12871927038F06D4EAA0D337F14D0CY4PR12MB1287namp_--

--===============0812222765==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0812222765==--
