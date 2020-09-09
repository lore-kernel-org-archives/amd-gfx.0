Return-Path: <SRS0=5+Vp=CS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32D98C43461
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Sep 2020 11:48:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5CFB215A4
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Sep 2020 11:48:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="lhM2Tlpc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5CFB215A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 17B276EE5A;
	Wed,  9 Sep 2020 11:48:26 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2088.outbound.protection.outlook.com [40.107.220.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 33DBF6EE59
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Sep 2020 11:48:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G5nsioGO7y0xuo8F63sq0OBgZCGVUjzsh8DlsKBmp+HOGuxhpLe17A/96iEv0unYwa1p4lMfycgUfYGsO1nHcIv34hbM3YzRY0BznNwzSsEs9jLabzeSOTFlzNz2Ti8d7XhDeQt9/sewzJjASl1o1FL7TySpZRR7wvdHGwTt08++qyY744RU9LI2EiWgezr6F/w/K+tPpLmjXAI3qC2EcMFuAzQs0Hew1yV2JMuShJmlf9Bm8JUsoWx4PkzSVA3uwVgm8Uc2fChQ6q+4bkKstp7leYerwy1y/8aWuncEiYT6qGqyFAz/kjtDnp2tAR1+N0cZnEyYYoPuyHOiZfBHoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PYSPfkjR26o2DLi0GmM5spA31AWGw9iUqiCjJziCCmA=;
 b=MgbFU7aiCF2qdwEpmAvPbBDFRcmOcSQS492JFBk2gpDufs0ZfEgznWz0RbqZaRI7RZ5ba3ucpFvSZGO35XFMEUTdGCP2LY8cY+xRj/gGhBVFMSwJdB10fFKgE6wTLKZ4E2xtspoCa0Jggilnpvskj1eqf9/N1vma9jp97t3UjO5fM97E1eiSIr5oxaCv2wIYqhg7WeiFFIedi3viQcMHsNyst7Oisl3yVe3JBqYA2wgTzYxUjFgm7bYQ2p5tf4m4j/kLGs1Q1iNOlYwz9hS6iLgMxbbVYdv04vJzzpRDkd42Glf1Kk6/ozBX+R5FKTi4qS8IbfePHCdiFWNX/KCI3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PYSPfkjR26o2DLi0GmM5spA31AWGw9iUqiCjJziCCmA=;
 b=lhM2TlpcrtFhHjgLXcG+yi49ckjWLUWJ1+Fns3YiYkQzr8bOBjkO4DyTDUWM9Q1zBSclnmhz8igFAJRfxCUO60vYycD5XZejiUi2GvWqyEJR2C5C4PidgJ4z4yn8FCIJmtgv1d3cG+2chnLg5cWCvBd7tQGjU//WHhy2NioJFoc=
Received: from CY4PR12MB1287.namprd12.prod.outlook.com (2603:10b6:903:40::8)
 by CY4PR12MB1157.namprd12.prod.outlook.com (2603:10b6:903:3b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.19; Wed, 9 Sep
 2020 11:48:22 +0000
Received: from CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::e9ab:dad0:9d7a:a0e3]) by CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::e9ab:dad0:9d7a:a0e3%3]) with mapi id 15.20.3370.016; Wed, 9 Sep 2020
 11:48:22 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Clements, John" <John.Clements@amd.com>, amd-gfx list
 <amd-gfx@lists.freedesktop.org>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Update RAS init handling
Thread-Topic: [PATCH] drm/amdgpu: Update RAS init handling
Thread-Index: AdaGiu0LetZWdMcuTBOCRWM5fSEKUgADkB8g
Date: Wed, 9 Sep 2020 11:48:22 +0000
Message-ID: <CY4PR12MB12877858600D5E8EDFDB76F9F1260@CY4PR12MB1287.namprd12.prod.outlook.com>
References: <MN2PR12MB4032CB22E8EBE0E9FA3FE7EDFB260@MN2PR12MB4032.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB4032CB22E8EBE0E9FA3FE7EDFB260@MN2PR12MB4032.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-09-09T11:07:28Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=84a5dfad-cb04-4ddf-b67c-00005546c765;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-09-09T11:46:40Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 5a7e29d4-4891-4574-a509-0000316ec668
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [2409:891e:9747:14ba:2c3f:cd5c:d2d9:574d]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9a5b8735-904e-4bf8-2c5e-08d854b640ff
x-ms-traffictypediagnostic: CY4PR12MB1157:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR12MB115704F79A975CD3D647D75BF1260@CY4PR12MB1157.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YdTiiO0IBb4aVGwepYRxCtS0i9jXqSaXcMehG3xlqvVbWTjaIA7qUX8Z2xlkuV9fw4uCctO72GqNfA445jni+nee0xWC0POxpZGw3MozBbFOTDxqAitd4o2m7dvhpt98FtVrq5zWMKCwQ2QYyqQnwp+lS+UnfoQa7jv09UhsG/KX5LjNorfFys+WgjRmdhxt6GVQvysWTKbcPIPJcwxUnWGYTBpLC5X9E8/BbHW+u0yypJRVS1lKZlClMgJVXbZHSdmoHo/1KlYkamuOF0ERwarT0yNfD7mKblMC+aQaraSlapMdl/k6FeEkaky08EpR
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1287.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(376002)(39860400002)(346002)(396003)(6506007)(55016002)(15650500001)(2906002)(7696005)(8936002)(186003)(53546011)(8676002)(76116006)(66946007)(52536014)(86362001)(64756008)(66556008)(66476007)(6636002)(478600001)(83380400001)(110136005)(316002)(4744005)(5660300002)(33656002)(9686003)(66446008)(71200400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: uVQzoUu56R/ueAV74UGaXmzpwxbpDPXOF84/r5dByn3k3wLyfGzUutz7PbWaERk8412578Zfgj5tnht1fFvDDpu2vxeoCxct+kxIRQO/UMOyd/1bztpFlHBoLFmLSRtUyD8u07l8lmEbPCInLTFzK++TPDjTLqsqw6WGdvjmEejVS0mpzWnhzCiHoHOXjYi50A8kjOaZfnHqQhCra9MhEPhi/cIyqXBDqgs5dOQBoWhanQhzNLcxsMlFg7UHHeaxL+5nTtpu2N1jXvf2WixfJe5uT6mbJOQuVSkQ/0dagDJIZ0qm6ciz/938SGLRYnBlMpqDbOjzV8unwzfj3Bgf296nXqdCspVPZ346FAg14cb0wtUbBK2kXzFNgKhRr7k0UBIE/NKTjFPiE/twqD300rbIIQkdCExgW07aWUsSzFIqqg7DNjmc1V3mouUxPsHeZhayyhwpxBwNTdQFyI3qBAuEl/vCGAG90BX82mWmrb0xf223fSlRG7SDNpBIzvlUpkdLDzV1ihEqbN6PAR/GM9LcQ6HDG996D1Q23Js+MtomXinvv6o0nIO2+E4eIDkdTQ+ao5Lbz3SgIhgVL+W64ndBhVNIHl24NDPcxPPXidNhmg1LMkb4one9sBEGcFmy+szA/UesRDjn6XKsWLmUyFqVo9tOS5jBe980E7qDnzgOGllzlDpuo5O7C6+63RAao7ZcL5CWQzlKUNNtlGpYOQ==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1287.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a5b8735-904e-4bf8-2c5e-08d854b640ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2020 11:48:22.2171 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lOq+4hK58BOI1uGrvRkZKF3mFCLdgJt1jwUC/QuEy6yVbTkhff8nqyfdlEXGajerHBOqx+fvmHIpTmntXgjAaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1157
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
Content-Type: multipart/mixed; boundary="===============0846907919=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0846907919==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CY4PR12MB12877858600D5E8EDFDB76F9F1260CY4PR12MB1287namp_"

--_000_CY4PR12MB12877858600D5E8EDFDB76F9F1260CY4PR12MB1287namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

+            if (!adev->psp.ras.ras_initialized)
+                           return -EINVAL;
+
             if (!con)
                            return -EINVAL;

I suggest squashing the new check into below one.

Regards,
Guchun

From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Clements=
, John
Sent: Wednesday, September 9, 2020 5:24 PM
To: amd-gfx list <amd-gfx@lists.freedesktop.org>; Zhang, Hawking <Hawking.Z=
hang@amd.com>
Subject: [PATCH] drm/amdgpu: Update RAS init handling


[AMD Official Use Only - Internal Distribution Only]



--_000_CY4PR12MB12877858600D5E8EDFDB76F9F1260CY4PR12MB1287namp_
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
p.msipheader87abd423, li.msipheader87abd423, div.msipheader87abd423
	{mso-style-name:msipheader87abd423;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle20
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
<p class=3D"msipheader87abd423" style=3D"margin:0in"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:#317100">[AMD Publ=
ic Use]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (!adev-&gt;psp.ras.ras_initialized)<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; if (!con)<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I suggest squashing the new check into below one.<o:=
p></o:p></p>
<div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Regards,<o:p></o:p></p>
<p class=3D"MsoNormal">Guchun<o:p></o:p></p>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> amd-gfx &lt;amd-gfx-bounces@lists.freed=
esktop.org&gt;
<b>On Behalf Of </b>Clements, John<br>
<b>Sent:</b> Wednesday, September 9, 2020 5:24 PM<br>
<b>To:</b> amd-gfx list &lt;amd-gfx@lists.freedesktop.org&gt;; Zhang, Hawki=
ng &lt;Hawking.Zhang@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: Update RAS init handling<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"msipheadera92e061b" style=3D"margin:0in"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:#0078D7">[AMD Offi=
cial Use Only - Internal Distribution Only]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</body>
</html>

--_000_CY4PR12MB12877858600D5E8EDFDB76F9F1260CY4PR12MB1287namp_--

--===============0846907919==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0846907919==--
