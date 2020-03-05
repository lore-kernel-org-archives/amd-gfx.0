Return-Path: <SRS0=Sanp=4W=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.4 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 203A0C3F2D1
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Mar 2020 12:30:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1F892072D
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Mar 2020 12:30:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="wdMuEJlu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1F892072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 73E1C6E0AA;
	Thu,  5 Mar 2020 12:30:13 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2089.outbound.protection.outlook.com [40.107.244.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2CD126E0AA
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Mar 2020 12:30:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B3rdnTSbwYH8UfrfzXTUjY9tm2iLIbElJW5aBF+kV0G7hguLlLd5GmOpl4e3NrXhyGIfAJ73rLmDFzBETQ8eA8Mu4qLdLI1CT+0D4qop7loKvh1k3MxVuLLGbiQdZWBHmtNQSqXT7UvzttHW6e27Qhc/rSMuXUZdpxgSTOcZaWNzzvSbjR8f3aO86A7pchYOM+9OBuTCcQNgufKp6/H1dWeNAjTs2jKhSdCLcVZZPcFYIpmK/5iaOE7bvtYcgkFOdzbqCizWiS7GI0PZ6bFvZn+joGZkqQrk6tj4Jc0wOkZkfmUyzuavAAH5jhc8m7wcxWDW+QKksccpvf1pli8S5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WWtImIcQXiyV5PaXis9L5VlJGvnhMj7T7mtBUkxpPvc=;
 b=WplJnFaIfV8bavzOk8ty6pxOAbpmuc7AuBHhHPU4iiWsCmv1oUXTcsqoKZmZPupiuP8ZZEds6nGCucrzhF9HE3WpbdWr2hKgXfVGYOis4rh8ZIzwYm9yKix14xyInR+uvPX5kl9GMclj4rvs3lI4KE0Bm/+tp7OWgM8rTdCjdP0JsPfHFSIoB7o9GusAwa+szB2zmv/PRg/6r3rqX+6YBiazOuTEGkN2/8hsCJ6KbJ5j6rJMkEoPW4hvVMRLCjhi9U9j2n+Ys9pqnNO3Wqlx3gOMFPpoEcDulJkzQwNYNqY1wpL/ixRiFr+T9MR3UV0Rcn5J3rAOBf42r5QgS6Iqjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WWtImIcQXiyV5PaXis9L5VlJGvnhMj7T7mtBUkxpPvc=;
 b=wdMuEJluEsOnkWkyU+1SCgtEyKf5iAFUtLdsWV2fIELJbwr8f2Q8M0TXGofZErm04L+Uc+Llr3ZHCOQ9Sfhe+HE5HmBOzdqti8Tl+Vt4d+eL0EsnWgTLRjkBryKcAUPA45VC42r2XQVaJ17MlfpkiX4ZYM77ji1YrSe8CwPm+Jk=
Received: from BYAPR12MB2806.namprd12.prod.outlook.com (2603:10b6:a03:70::20)
 by BYAPR12MB3430.namprd12.prod.outlook.com (2603:10b6:a03:ad::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.18; Thu, 5 Mar
 2020 12:30:11 +0000
Received: from BYAPR12MB2806.namprd12.prod.outlook.com
 ([fe80::5034:d0dc:246d:399f]) by BYAPR12MB2806.namprd12.prod.outlook.com
 ([fe80::5034:d0dc:246d:399f%7]) with mapi id 15.20.2772.019; Thu, 5 Mar 2020
 12:30:11 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Clements, John"
 <John.Clements@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Li, Dennis" <Dennis.Li@amd.com>, "Zhou1,
 Tao" <Tao.Zhou1@amd.com>
Subject: RE: [PATCH] drm/amdgpu: update page retirement sequence
Thread-Topic: [PATCH] drm/amdgpu: update page retirement sequence
Thread-Index: AdXy0f9EIn2WkBwySKekkStORNst4QAAeMzgAABOtbAAAn8mkAACoKuQ
Date: Thu, 5 Mar 2020 12:30:11 +0000
Message-ID: <BYAPR12MB28068D2CC8E8613406DB339DF1E20@BYAPR12MB2806.namprd12.prod.outlook.com>
References: <MN2PR12MB366376914E9DE0A1D1D39440FBE20@MN2PR12MB3663.namprd12.prod.outlook.com>
 <DM5PR12MB14180E64D6C5E62E05DA8D0AFCE20@DM5PR12MB1418.namprd12.prod.outlook.com>
 <MN2PR12MB366325AEAAEC19067ED553ACFBE20@MN2PR12MB3663.namprd12.prod.outlook.com>
 <DM5PR12MB14182ED48CB98E4BE2D695C5FCE20@DM5PR12MB1418.namprd12.prod.outlook.com>
In-Reply-To: <DM5PR12MB14182ED48CB98E4BE2D695C5FCE20@DM5PR12MB1418.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-03-05T12:28:48Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=9f03ccab-021a-466c-af69-0000e5501631;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-03-05T12:30:08Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 2f364681-45d1-4a57-b081-00009f5d86ed
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Guchun.Chen@amd.com; 
x-originating-ip: [101.224.57.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 94a0c1e8-8e5d-4b20-66ba-08d7c100f316
x-ms-traffictypediagnostic: BYAPR12MB3430:|BYAPR12MB3430:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB34301A6ACAE3B726100AB96BF1E20@BYAPR12MB3430.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 03333C607F
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(136003)(396003)(376002)(346002)(366004)(189003)(199004)(6506007)(26005)(7696005)(71200400001)(52536014)(53546011)(186003)(5660300002)(15650500001)(316002)(8936002)(66946007)(66446008)(66476007)(76116006)(64756008)(66556008)(55016002)(8676002)(110136005)(81156014)(86362001)(478600001)(6636002)(33656002)(81166006)(2906002)(9686003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BYAPR12MB3430;
 H:BYAPR12MB2806.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: W0nLFXlaK0C8IGkuxcXBS+KiQd1kJMVnHNOsgF/AtjRqxHPzWyOoofsJ90b2L4Ncy3semCWq/CTYeV2lqShTQ1iEtXdHFlVpmkdOOAP3lCqscunVh9l03ejtV7RRvQ7tmzBsRSVglTQqmtoScFiXgeLSIxQaPujttZoVakjDX+v5praSqERLt4+wRtzzLSC03gr0eKH8YghhE8FQ7Z48GJ6W0/Yatx4bMEmk/KyD1PcMimysaSTLtZeAXIJnF97GQYvq2w9/N5+EWSeDRihPWCrmWABAIHM9j5LG3UNF96j7rc8GwyY9TjITmc6rZwHRa0/NBt5+TsHqnEfns7iDj+6ba3Dzc3QQ30sHnGDajA3u5r9YTNGEokESyxpkogXMmKc2pkgY4T6VcOcd0HnHv9/Z974nWMkXb4gIuGUQIJ1pwnMQLX4+zWpQ7wl1QARb
x-ms-exchange-antispam-messagedata: CC+R9KSRyWWP7LW8ZEY8wxIbcFoiL5FVdH9BDMldefVszVl/r6zHIJ/2VoEyuw8FjigGrVCBVHgFtEd8IdvkDDNnG3JXy8znxCe6uTIRxyGNxTXTBT/yR8us9321p0i4iQiYir+Phg9z8ENPHkI4Qw==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94a0c1e8-8e5d-4b20-66ba-08d7c100f316
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2020 12:30:11.7237 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EJ5PUC9QH8b0VlP3lbewrwdfM/GraKvJ1SL/wh+9WYd+n2imyyNNz8eo1Do9E8DcowbckIrWUCAOTxFFA9K/2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3430
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
Content-Type: multipart/mixed; boundary="===============1174550405=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1174550405==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BYAPR12MB28068D2CC8E8613406DB339DF1E20BYAPR12MB2806namp_"

--_000_BYAPR12MB28068D2CC8E8613406DB339DF1E20BYAPR12MB2806namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

We'd better keep original comment "/* skip error address process if -ENOMEM=
 */", if err_addr is not allocated successfully.

Regards,
Guchun

From: Zhang, Hawking <Hawking.Zhang@amd.com>
Sent: Thursday, March 5, 2020 7:23 PM
To: Clements, John <John.Clements@amd.com>; amd-gfx@lists.freedesktop.org; =
Li, Dennis <Dennis.Li@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Chen, Guchu=
n <Guchun.Chen@amd.com>
Subject: RE: [PATCH] drm/amdgpu: update page retirement sequence


[AMD Official Use Only - Internal Distribution Only]

I see. So it's the following programming that is in risk to corrupt data fo=
r other instances.

                /* clear umc status */
                WREG64_PCIE((mc_umc_status_addr + umc_reg_offset) * 4, 0x0U=
LL);

For error injection, everytime it should just have one instance had the err=
or status record. Therefore, it make sense to me that we only clear the sta=
tus register once. As discussed, we shall also follow up with umc team on t=
he potential issue with index mode programming.

Please also add some comments in code for this unexpected behavior that we =
shall follow up. Other than that, the patch is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com<mailto:Hawking.Zhang@amd.=
com>>

Regards,
Hawking
From: Clements, John <John.Clements@amd.com<mailto:John.Clements@amd.com>>
Sent: Thursday, March 5, 2020 18:19
To: Zhang, Hawking <Hawking.Zhang@amd.com<mailto:Hawking.Zhang@amd.com>>; a=
md-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>; Li, Den=
nis <Dennis.Li@amd.com<mailto:Dennis.Li@amd.com>>; Zhou1, Tao <Tao.Zhou1@am=
d.com<mailto:Tao.Zhou1@amd.com>>; Chen, Guchun <Guchun.Chen@amd.com<mailto:=
Guchun.Chen@amd.com>>
Subject: RE: [PATCH] drm/amdgpu: update page retirement sequence


[AMD Official Use Only - Internal Distribution Only]

In the original sequence, if the key bits are not set in the mca_status, th=
e page retirement will not happen and the status register will be cleared.
If there is a UMC UE, that register will be cleared erroneously 31 times.

If MCA Status =3D=3D 0 already from the beginning there is no reason to pre=
ss forward with the rest of the checks and clear the register.

From: Zhang, Hawking <Hawking.Zhang@amd.com<mailto:Hawking.Zhang@amd.com>>
Sent: Thursday, March 5, 2020 5:56 PM
To: Clements, John <John.Clements@amd.com<mailto:John.Clements@amd.com>>; a=
md-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>; Li, Den=
nis <Dennis.Li@amd.com<mailto:Dennis.Li@amd.com>>; Zhou1, Tao <Tao.Zhou1@am=
d.com<mailto:Tao.Zhou1@amd.com>>; Chen, Guchun <Guchun.Chen@amd.com<mailto:=
Guchun.Chen@amd.com>>
Subject: RE: [PATCH] drm/amdgpu: update page retirement sequence


[AMD Official Use Only - Internal Distribution Only]

Hi John,

Can you please explain more on the differences between (a). exit immediatel=
y when mca_status is 0 and (b). exit when some of critical field in mca_sta=
tus is 0?

Regards,
Hawking
From: Clements, John <John.Clements@amd.com<mailto:John.Clements@amd.com>>
Sent: Thursday, March 5, 2020 17:40
To: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>; Zh=
ang, Hawking <Hawking.Zhang@amd.com<mailto:Hawking.Zhang@amd.com>>; Li, Den=
nis <Dennis.Li@amd.com<mailto:Dennis.Li@amd.com>>; Zhou1, Tao <Tao.Zhou1@am=
d.com<mailto:Tao.Zhou1@amd.com>>; Chen, Guchun <Guchun.Chen@amd.com<mailto:=
Guchun.Chen@amd.com>>
Subject: [PATCH] drm/amdgpu: update page retirement sequence


[AMD Official Use Only - Internal Distribution Only]

check UMC status and exit prior to making and erroneus register access

--_000_BYAPR12MB28068D2CC8E8613406DB339DF1E20BYAPR12MB2806namp_
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
<p class=3D"MsoNormal">We&#8217;d better keep original comment &#8220;/* sk=
ip error address process if -ENOMEM */&#8221;, if err_addr is not allocated=
 successfully.<o:p></o:p></p>
<div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Regards,<o:p></o:p></p>
<p class=3D"MsoNormal">Guchun<o:p></o:p></p>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Zhang, Hawking &lt;Hawking.Zhang@amd.co=
m&gt; <br>
<b>Sent:</b> Thursday, March 5, 2020 7:23 PM<br>
<b>To:</b> Clements, John &lt;John.Clements@amd.com&gt;; amd-gfx@lists.free=
desktop.org; Li, Dennis &lt;Dennis.Li@amd.com&gt;; Zhou1, Tao &lt;Tao.Zhou1=
@amd.com&gt;; Chen, Guchun &lt;Guchun.Chen@amd.com&gt;<br>
<b>Subject:</b> RE: [PATCH] drm/amdgpu: update page retirement sequence<o:p=
></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"msipheadera92e061b" style=3D"margin:0in;margin-bottom:.0001pt">=
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;co=
lor:#0078D7">[AMD Official Use Only - Internal Distribution Only]</span><o:=
p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I see. So it&#8217;s the following programming that =
is in risk to corrupt data for other instances.
<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* clear umc status */<o:p></o:p></p=
>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG64_PCIE((mc_umc_status_addr &#43=
; umc_reg_offset) * 4, 0x0ULL);<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">For error injection, everytime it should just have o=
ne instance had the error status record. Therefore, it make sense to me tha=
t we only clear the status register once. As discussed, we shall also follo=
w up with umc team on the potential
 issue with index mode programming.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Please also add some comments in code for this unexp=
ected behavior that we shall follow up. Other than that, the patch is
<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Reviewed-by: Hawking Zhang &lt;<a href=3D"mailto:Haw=
king.Zhang@amd.com">Hawking.Zhang@amd.com</a>&gt;<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Regards,<br>
Hawking<o:p></o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Clements, John &lt;<a href=3D"mailto:Jo=
hn.Clements@amd.com">John.Clements@amd.com</a>&gt;
<br>
<b>Sent:</b> Thursday, March 5, 2020 18:19<br>
<b>To:</b> Zhang, Hawking &lt;<a href=3D"mailto:Hawking.Zhang@amd.com">Hawk=
ing.Zhang@amd.com</a>&gt;;
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a>; Li, Dennis &lt;<a href=3D"mailto:Dennis.Li@amd.com">Dennis.Li@amd.=
com</a>&gt;; Zhou1, Tao &lt;<a href=3D"mailto:Tao.Zhou1@amd.com">Tao.Zhou1@=
amd.com</a>&gt;; Chen, Guchun &lt;<a href=3D"mailto:Guchun.Chen@amd.com">Gu=
chun.Chen@amd.com</a>&gt;<br>
<b>Subject:</b> RE: [PATCH] drm/amdgpu: update page retirement sequence<o:p=
></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"msipheadera92e061b" style=3D"margin:0in;margin-bottom:.0001pt">=
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;co=
lor:#0078D7">[AMD Official Use Only - Internal Distribution Only]</span><o:=
p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">In the original sequence, if the key bits are not se=
t in the mca_status, the page retirement will not happen and the status reg=
ister will be cleared.<o:p></o:p></p>
<p class=3D"MsoNormal">If there is a UMC UE, that register will be cleared =
erroneously 31 times.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">If MCA Status =3D=3D 0 already from the beginning th=
ere is no reason to press forward with the rest of the checks and clear the=
 register.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Zhang, Hawking &lt;<a href=3D"mailto:Ha=
wking.Zhang@amd.com">Hawking.Zhang@amd.com</a>&gt;
<br>
<b>Sent:</b> Thursday, March 5, 2020 5:56 PM<br>
<b>To:</b> Clements, John &lt;<a href=3D"mailto:John.Clements@amd.com">John=
.Clements@amd.com</a>&gt;;
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a>; Li, Dennis &lt;<a href=3D"mailto:Dennis.Li@amd.com">Dennis.Li@amd.=
com</a>&gt;; Zhou1, Tao &lt;<a href=3D"mailto:Tao.Zhou1@amd.com">Tao.Zhou1@=
amd.com</a>&gt;; Chen, Guchun &lt;<a href=3D"mailto:Guchun.Chen@amd.com">Gu=
chun.Chen@amd.com</a>&gt;<br>
<b>Subject:</b> RE: [PATCH] drm/amdgpu: update page retirement sequence<o:p=
></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"msipheadera92e061b" style=3D"margin:0in;margin-bottom:.0001pt">=
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;co=
lor:#0078D7">[AMD Official Use Only - Internal Distribution Only]</span><o:=
p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Hi John,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Can you please explain more on the differences betwe=
en (a). exit immediately when mca_status is 0 and (b). exit when some of cr=
itical field in mca_status is 0?<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Regards,<br>
Hawking<o:p></o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Clements, John &lt;<a href=3D"mailto:Jo=
hn.Clements@amd.com">John.Clements@amd.com</a>&gt;
<br>
<b>Sent:</b> Thursday, March 5, 2020 17:40<br>
<b>To:</b> <a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.f=
reedesktop.org</a>; Zhang, Hawking &lt;<a href=3D"mailto:Hawking.Zhang@amd.=
com">Hawking.Zhang@amd.com</a>&gt;; Li, Dennis &lt;<a href=3D"mailto:Dennis=
.Li@amd.com">Dennis.Li@amd.com</a>&gt;; Zhou1, Tao
 &lt;<a href=3D"mailto:Tao.Zhou1@amd.com">Tao.Zhou1@amd.com</a>&gt;; Chen, =
Guchun &lt;<a href=3D"mailto:Guchun.Chen@amd.com">Guchun.Chen@amd.com</a>&g=
t;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: update page retirement sequence<o:p></o=
:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"msipheadera92e061b" style=3D"margin:0in;margin-bottom:.0001pt">=
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;co=
lor:#0078D7">[AMD Official Use Only - Internal Distribution Only]</span><o:=
p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">check UMC status and exit prior to making and errone=
us register access<o:p></o:p></p>
</div>
</body>
</html>

--_000_BYAPR12MB28068D2CC8E8613406DB339DF1E20BYAPR12MB2806namp_--

--===============1174550405==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1174550405==--
