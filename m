Return-Path: <SRS0=Zv7j=A2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10D91C433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jul 2020 07:01:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D531F205CB
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jul 2020 07:01:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="FTSY47sf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D531F205CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 91C0D6E46B;
	Wed, 15 Jul 2020 07:01:15 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2089.outbound.protection.outlook.com [40.107.243.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7BAA36E46B
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2020 07:01:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ngWre6Iky1FERVVsFqxmHnghY4BLpaj7R9IwOlGTyiXt3Cq89y+bz2L0gq0xYbfuum53PnRfUcVjLEGE4yp7fB0MDfAy65LZbqRSusdNvqHpu+Srq6jEUISTqlGeREbIzKRrSef7BSSbhLE8opntLETzzlBheGKfFPvUtjSvKCA22B1aiVPrU/7AzkuAz7OMIS+W4f8pytprYgw6jE8o6orjnv83v4APfjifNKv0L2dCx4dX2kKb618jugNoRk4DtxHOZyuObMqd6fpRdLNxG+n3OQaearaT2Y0LFeJKnNbRNmNpWgv1zNYAWcZGiisnetYyotonGliiHhayHyYMvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v6V/80BYCVSB8tvVEGXyIIKIXXFJe4tiskrFjOrqR6o=;
 b=EDBhOs/uruYQCS/Y6mRnM2IDNyPZKFrEozQbWxZH47e/hNacGGb9RRn5l47q9VhNhfGMgHvImJDENsgsJgFG4zJmizSjxLwSG8SQYGvOcQdkksZjEzvrzeJauX3XbUfus6FYykXNndzrgpv5aeMKUapDi0KerQ4ewjcu2FOt5qQYraYPy6R3+TmTySPIUNtyBKwQ2cjBiOktkuMU2Ll9yIuwIJQO2njRjRWpmx4rXKeBrh4Dej+pfDu38iTh08iGCAQZ60dcgPjKwJkVlSNng0K6AzRlTTeFWih14RyaRlOCcAfsgIPZ7YHD1NFR9XVe3NsjtEY5qbJNeruRrV4Z6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v6V/80BYCVSB8tvVEGXyIIKIXXFJe4tiskrFjOrqR6o=;
 b=FTSY47sfpa8i37mYaUnOVqVCJVeogMkhwPfokjSnL3EodyBlnSUkId30JG66p2Nwrhhp7lNcEawgvDDVh39CNzP9Tv4GWOQvJgosZzGs07qd7iYQAd5GHfvSRtyr7Y1MUYHS0UxPChs/QD+EUEOW3eyKmoyf9R9zr43lxpBS+D8=
Received: from CY4PR12MB1287.namprd12.prod.outlook.com (2603:10b6:903:40::8)
 by CY4PR12MB1160.namprd12.prod.outlook.com (2603:10b6:903:38::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21; Wed, 15 Jul
 2020 07:01:13 +0000
Received: from CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::e0b1:48e7:bcbc:351c]) by CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::e0b1:48e7:bcbc:351c%11]) with mapi id 15.20.3174.025; Wed, 15 Jul
 2020 07:01:13 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Clements, John" <John.Clements@amd.com>, amd-gfx list
 <amd-gfx@lists.freedesktop.org>, "Lakha, Bhawanpreet"
 <Bhawanpreet.Lakha@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: resolve bug in ta microcode init
Thread-Topic: [PATCH] drm/amdgpu: resolve bug in ta microcode init
Thread-Index: AdZacxLt6n7WOYuDTHSPsvqdIgusVQAAhG2g
Date: Wed, 15 Jul 2020 07:01:12 +0000
Message-ID: <CY4PR12MB1287FC36743FCB66A8818989F17E0@CY4PR12MB1287.namprd12.prod.outlook.com>
References: <MN2PR12MB4032BE9B97E446082D680CB0FB7E0@MN2PR12MB4032.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB4032BE9B97E446082D680CB0FB7E0@MN2PR12MB4032.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-07-15T06:43:57Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=612aa6c4-0541-482a-be8b-000085f37a68;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-07-15T07:01:10Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 60c033ff-8034-47db-8ac2-00004fe9b6e3
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 022d474c-92ca-467f-9d7f-08d8288cdc6e
x-ms-traffictypediagnostic: CY4PR12MB1160:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR12MB11604492A2904F2C555C59F9F17E0@CY4PR12MB1160.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CAHRYQVkblGVfrltyKSUULje2aR8nyPFNDiBgjc482qc1Y1ed8d8ilho1jsBc1z9m83aXbUcIIB5wnoJCEv0Jy5GIAd33WkTHpC7F6rgWGFM04wlSdLtzysDKKuUHbBlG7oczPxF0oebJdY8aFWTsXS8o+rYwbAGymVBGUbX4pAEE+cdwZJ4M+ZBK6JtE91ygt+cRdcSDfmwLq/kOVvY9OPRT7eeyaue6fTz17MAs2WQgz/tVNwG+hNChSRgVF1nLKN3tcqjpJ1xN0bFuJoOO0lHFOis1tNZ3/wN2wEpulKvB7W5v8Zd39En32Au9L2F
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1287.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(366004)(136003)(396003)(376002)(346002)(76116006)(8676002)(53546011)(6506007)(186003)(86362001)(2906002)(478600001)(26005)(6636002)(7696005)(8936002)(110136005)(4744005)(64756008)(33656002)(66476007)(66556008)(66446008)(316002)(55016002)(52536014)(9686003)(83380400001)(71200400001)(66946007)(5660300002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: ro5USGvwDq3L+OqF3ihH9Bm2jz2NX/DajgtWHtikOA2eZk5BWmiysmBHQt8+E6B4PiiTzJ8KRjtUnC3jv9+p5II5XFzKjxyXyIrhaj3kSmB/qEQiWIAVmusaJd4L5gcNpMtLfXyR5jPaxLQzNIY9vPF8H7mjS6eOGsjnNUikmYjh6QhC7zu6CCSFaINtwJrrJ2AG7JQPTzEB8LISNAIUCL9Vow/awmZZ7CEmiMQaIf9zRVzGCBzEqm9c4oM2hy5dgunkAEP/8ylixtWI7FWDRvg7YtGJemC5m6XunRGfLolxaCY6eQPU1ZpeK6JRY6raidAoo6SXk+2l13ruQhgjXmu5oQXm1m7trVLhNP5D945BAinMkl5031EXFY5GXr/R6S/HBOICO2KbgWTQUj8ArOPq9c86I2N8kwSxZBRliKL9VDa5P1fIAcEEJKSvV1uCX3jhdQCgnbZUbcGjtHVMmitUMW5lzGZ40aYRrPnHu/9gV2Dcm586bpI+PyWYZwd2
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1287.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 022d474c-92ca-467f-9d7f-08d8288cdc6e
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2020 07:01:13.0125 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UHEYEvgSFXIVd5TPf6qkUUEKeeXCIOZzCqhFCI6qrn8JVgRxPXlaasixfXPOdjYiE7iLlONcqa7AwfzGGxYFGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1160
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
Content-Type: multipart/mixed; boundary="===============0016062706=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0016062706==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CY4PR12MB1287FC36743FCB66A8818989F17E0CY4PR12MB1287namp_"

--_000_CY4PR12MB1287FC36743FCB66A8818989F17E0CY4PR12MB1287namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

Hi John,

The patch is good. However, maybe it's better we can improve the patch comm=
it message title/body together a bit.

Generally, original title 'resolve bug...' is not pretty clear to audience.=
 If possible, we can modify the title to 'correct fw start address', and in=
 message body, illustrate why the patch is needed.

With the comment addressed, the patch is:
Reviewed-by: Guchun Chen <guchun.chen@amd.com>

Regards,
Guchun

From: Clements, John <John.Clements@amd.com>
Sent: Wednesday, July 15, 2020 2:44 PM
To: amd-gfx list <amd-gfx@lists.freedesktop.org>; Lakha, Bhawanpreet <Bhawa=
npreet.Lakha@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Chen, Guchun=
 <Guchun.Chen@amd.com>
Subject: [PATCH] drm/amdgpu: resolve bug in ta microcode init


[AMD Public Use]

Submitting patch for review to resolve bug when calculating FW offset withi=
n binaries with PSP TA v2 header.

Thank you,
John Clements

--_000_CY4PR12MB1287FC36743FCB66A8818989F17E0CY4PR12MB1287namp_
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
<p class=3D"MsoNormal">Hi John,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">The patch is good. However, maybe it&#8217;s better =
we can improve the patch commit message title/body together a bit.<o:p></o:=
p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Generally, original title &#8216;resolve bug...&#821=
7; is not pretty clear to audience. If possible, we can modify the title to=
 &#8216;correct fw start address&#8217;, and in message body, illustrate wh=
y the patch is needed.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">With the comment addressed, the patch is:<o:p></o:p>=
</p>
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
<b>Sent:</b> Wednesday, July 15, 2020 2:44 PM<br>
<b>To:</b> amd-gfx list &lt;amd-gfx@lists.freedesktop.org&gt;; Lakha, Bhawa=
npreet &lt;Bhawanpreet.Lakha@amd.com&gt;; Zhang, Hawking &lt;Hawking.Zhang@=
amd.com&gt;; Chen, Guchun &lt;Guchun.Chen@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: resolve bug in ta microcode init<o:p></=
o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"msipheader251902e5" style=3D"margin:0in;margin-bottom:.0001pt">=
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;co=
lor:#317100">[AMD Public Use]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Submitting patch for review to resolve bug when calc=
ulating FW offset within binaries with PSP TA v2 header.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thank you,<o:p></o:p></p>
<p class=3D"MsoNormal">John Clements<o:p></o:p></p>
</div>
</body>
</html>

--_000_CY4PR12MB1287FC36743FCB66A8818989F17E0CY4PR12MB1287namp_--

--===============0016062706==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0016062706==--
