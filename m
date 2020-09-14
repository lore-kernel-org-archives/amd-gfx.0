Return-Path: <SRS0=HfWL=CX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48B81C43461
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Sep 2020 18:38:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2A8F208B3
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Sep 2020 18:38:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="R7lKr7wR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2A8F208B3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 78AF289E52;
	Mon, 14 Sep 2020 18:38:56 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2047.outbound.protection.outlook.com [40.107.236.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 916AD89E52
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Sep 2020 18:38:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bSG6MVTwmmE9Iimh8gKutDOTAE1YyJ/BUauo8Wa/sLnpke0xDjmoiK0kNIzy3TCQqVlbaREcWkz7cyBuPOg8UkYhvkTVVkw4q68qB3oGGYbpZ4/ikPiolmnxhiQCpKgnVHM1dcrtqTUBker5/DD/F7eKdDp4jCCRgTT9uvGQq5xct/UBXjhR+v93wZRWOEXWlT44dH/verZUibbmOBETQ0SsHvy8CztM+t6XOlBy3YjkPDonMxhMMWR938mgr7iMn7xPqRY+W4ej5c1LntWSCh9saBpzN3CdwJ/zrfKPiBH05mNipCQkyYjIgCBPGRXfVpa2I9G7JSfnEdmKhYE0Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=swvgjgohSaQcLCcUrXmryQI6+sLJTj3dlHHu1f/ftRc=;
 b=nSlQv1d3M/DDCjVWevRLWDrIkHzpuoHAXc9w4vANW5MJperCpNjsv/lAh9FgT/iA8FEUs5DBQ4UowC5rSS8Rwh2R5ljwbXmRHcpXuxDL/i2m1y5Tz475pInOwYOjSjgdXUf2PkKNgeUWjxhM6pfprhUu+ZSw4jLwaRwYQbUqtF0h4HFCApD4QONRtzT/873KPwWZSFLVD6Pu9tadFPFGQgyLkH/V+7IUd8HCLtpV42DGsJYB9NT31V9vr3F0cMF5djHzovsjqV9872dpQ90dR/q3aoHBrDi8VsUao+Gx5masOdV/8j/bPYUwsRG2zfz7SVWp1PayqrU1OPAQzPZ9VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=swvgjgohSaQcLCcUrXmryQI6+sLJTj3dlHHu1f/ftRc=;
 b=R7lKr7wRvix0JGHk1n+dgPKb3jDVibAQBunCtDBdbyjwu4EZ0DmiU/Idb4w/AdIxG8sGKJPIwxmONosdBUq2yB4I2qZ0IxBR93ul7ZJq7WM6DSXhajZ4fVakJzRf6lSVaF9waX/iqOloBH1U+jGd3qfKEsCLvagqSeCe1fEBjT8=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4422.namprd12.prod.outlook.com (2603:10b6:208:265::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Mon, 14 Sep
 2020 18:38:53 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::889d:3c2f:a794:67fb]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::889d:3c2f:a794:67fb%6]) with mapi id 15.20.3370.019; Mon, 14 Sep 2020
 18:38:53 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Clements, John"
 <John.Clements@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>, "Chen, 
 Guchun" <Guchun.Chen@amd.com>
Subject: Re: [PATCH] drm/amdgpu: Update RAS init handling
Thread-Topic: [PATCH] drm/amdgpu: Update RAS init handling
Thread-Index: AdaH8EEPyluBF0UHTRSypdzG9nCpXwADO3awALI+Zlg=
Date: Mon, 14 Sep 2020 18:38:53 +0000
Message-ID: <MN2PR12MB44881E2896EA9A8A7323E0FEF7230@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <MN2PR12MB40324FF5E5D607A6CE8D4D50FB240@MN2PR12MB4032.namprd12.prod.outlook.com>,
 <DM6PR12MB40756C546E49C8DD8BDE7924FC240@DM6PR12MB4075.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB40756C546E49C8DD8BDE7924FC240@DM6PR12MB4075.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=True;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-09-14T18:38:23.650Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=AMD
 Public; MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [71.219.66.138]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 32366dab-275b-42da-572c-08d858dd6e4e
x-ms-traffictypediagnostic: MN2PR12MB4422:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB442294A042A6ED2B7A1CFB65F7230@MN2PR12MB4422.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZmALy6GuA2fu3W+G+ek3F/teBX7qgVPOG+ypgx3Oi53X7L1958p65OwhXgK9kjZ+fgea0S6YJjMDK4En8KZKOUfbUyGeSZ45Mor4ygrbkX7YLWiX6LEudNgvmTSgkdlSSbEevmV5fJgXKd2krGR5yRjiAH5uieVPo+rV7aLDYcP/STQ5amUrFG1h6dYMTT0Hhc1SYxtjIWv/7GE5b8A3YP7LHgyeKBbwbgd3skZ2Go4gbgWiA5J1YPE1M+xEPTPnvIene0gq1UTUG6jPa9Y+GJW08q6U5TP3/oCSqXcN9Z3+l/a2rT5QVu1yokXoB5Rm
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(376002)(396003)(346002)(366004)(2906002)(26005)(83380400001)(9686003)(33656002)(52536014)(53546011)(5660300002)(6636002)(71200400001)(186003)(86362001)(478600001)(66476007)(66556008)(64756008)(66446008)(8936002)(110136005)(6506007)(19627235002)(316002)(8676002)(19627405001)(76116006)(55016002)(15650500001)(66946007)(7696005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: TPlmbgCr/stqoR+MnmGK4DrSymBc2xmYHHUsmFRUOM50fqaaCJTeFj+SrR5Dw0JXwVJGuTbmAgtU+u+CS5w1nwSv7tGXP79arB9/511dCeNWzbMsafsBo0Fl07GgtKfxRG+Ynuh488a+08eHgTxTpBQIVIcXCGFfYpWkYukcydPY7pxQxDBzgA0o6oTvgksFu058DazHk5wgLW2/tWnyz7hOIrqkDf0GYqNQnuZM8txWaYwNUFsf6PtaOcuTMMvBb1PEy5M92y7oAO7gL+8Q9SlUBCbSGEl35w26PBTu/ayJ6/XUrLtprs12TrrToBi5zHoj4tKE1FFBCR4mzzdW30NAFNAmu0BlfDxmfWw+o2yYSRN3tojdPYCr+9fhF3ooN9znAz1FsBP7D3BgSO/md8nbIQ3B2MiGIM+8JNgfcRv74AhOrbirJddhlFCgotj8HNvVPohDdmlaI3cJSFr65eSxCg3cr0H6zYLFUIqlJSFEvffBLEnlm9PAhVZDbyhN18rZ1cLEdIXu3ZYD9iP984vxIYDllTX3GzeMQ/kHyMZv6iNJlmw7JND0GHU7vqArSxowiWHuZt4ftrpIzQro0npIt48+MqR+Xt9fD9XvT3ridJ7Ahyg0X06HGsv9Naz73BogeZx07TVwBgCAS/Johw==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32366dab-275b-42da-572c-08d858dd6e4e
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2020 18:38:53.3793 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NE2+Q1Sp767CBW9oMmI29i9BkTCbL4A6E+6LkhKzB7Ewu/a2Fx27mhEpWrrqf4Ia7bWO2xrxcXlWD7BFO4zXjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4422
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
Content-Type: multipart/mixed; boundary="===============1900331451=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1900331451==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB44881E2896EA9A8A7323E0FEF7230MN2PR12MB4488namp_"

--_000_MN2PR12MB44881E2896EA9A8A7323E0FEF7230MN2PR12MB4488namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

Also, general nit, per kernel coding style, braces should be on the same li=
ne as the if or else,  E.g.,
} else {


Alex
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Zhang, H=
awking <Hawking.Zhang@amd.com>
Sent: Friday, September 11, 2020 2:02 AM
To: Clements, John <John.Clements@amd.com>; amd-gfx list <amd-gfx@lists.fre=
edesktop.org>; Chen, Guchun <Guchun.Chen@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Update RAS init handling


[AMD Public Use]



+                             {

+                                             dev_warn(psp->adev->dev, "RAS=
 Init Status: 0x%X\n", ras_cmd->ras_status);

+                             }

Please remove the redundant bracket.



Other than that, the patch is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>



In addition, please create another patch to move the nbio ras controller ir=
q source registry to sw_init, which is the consistent as what we did for ot=
her ip blocks, register the irq source in IP sw_init funcs.



Regards,

Hawking

From: Clements, John <John.Clements@amd.com>
Sent: Friday, September 11, 2020 12:03
To: amd-gfx list <amd-gfx@lists.freedesktop.org>; Chen, Guchun <Guchun.Chen=
@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: Update RAS init handling



[AMD Official Use Only - Internal Distribution Only]



Added RAS status check and tear down RAS context if RAS init fails

--_000_MN2PR12MB44881E2896EA9A8A7323E0FEF7230MN2PR12MB4488namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#317100;margin:15pt;" al=
ign=3D"Left">
[AMD Public Use]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Also, general nit, per kernel coding style, braces should be on the same li=
ne as the if or else,&nbsp; E.g.,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
} else {</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Alex<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Zhang, Hawking &lt;Hawking.Zh=
ang@amd.com&gt;<br>
<b>Sent:</b> Friday, September 11, 2020 2:02 AM<br>
<b>To:</b> Clements, John &lt;John.Clements@amd.com&gt;; amd-gfx list &lt;a=
md-gfx@lists.freedesktop.org&gt;; Chen, Guchun &lt;Guchun.Chen@amd.com&gt;<=
br>
<b>Subject:</b> RE: [PATCH] drm/amdgpu: Update RAS init handling</font>
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
	font-size:11.0pt;
	font-family:"Calibri",sans-serif}
p.x_msipheadera92e061b, li.x_msipheadera92e061b, div.x_msipheadera92e061b
	{margin-right:0in;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif}
p.x_msipheader251902e5, li.x_msipheader251902e5, div.x_msipheader251902e5
	{margin-right:0in;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif}
span.x_EmailStyle20
	{font-family:"Arial",sans-serif;
	color:#317100}
.x_MsoChpDefault
	{font-size:10.0pt}
@page WordSection1
	{margin:1.0in 1.0in 1.0in 1.0in}
div.x_WordSection1
	{}
-->
</style>
<div lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72">
<div class=3D"x_WordSection1">
<p class=3D"x_msipheader251902e5" style=3D"margin:0in"><span style=3D"font-=
size:10.0pt; font-family:&quot;Arial&quot;,sans-serif; color:#317100">[AMD =
Public Use]</span></p>
<p class=3D"x_MsoNormal">&nbsp;</p>
<p class=3D"x_MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {</p>
<p class=3D"x_MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_warn(=
psp-&gt;adev-&gt;dev, &quot;RAS Init Status: 0x%X\n&quot;, ras_cmd-&gt;ras_=
status);</p>
<p class=3D"x_MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }</p>
<p class=3D"x_MsoNormal">Please remove the redundant bracket. </p>
<p class=3D"x_MsoNormal">&nbsp;</p>
<p class=3D"x_MsoNormal">Other than that, the patch is</p>
<p class=3D"x_MsoNormal">Reviewed-by: Hawking Zhang &lt;Hawking.Zhang@amd.c=
om&gt;</p>
<p class=3D"x_MsoNormal">&nbsp;</p>
<p class=3D"x_MsoNormal">In addition, please create another patch to move t=
he nbio ras controller irq source registry to sw_init, which is the consist=
ent as what we did for other ip blocks, register the irq source in IP sw_in=
it funcs.</p>
<p class=3D"x_MsoNormal">&nbsp;</p>
<p class=3D"x_MsoNormal">Regards,</p>
<p class=3D"x_MsoNormal">Hawking</p>
<div>
<div style=3D"border:none; border-top:solid #E1E1E1 1.0pt; padding:3.0pt 0i=
n 0in 0in">
<p class=3D"x_MsoNormal"><b>From:</b> Clements, John &lt;John.Clements@amd.=
com&gt; <br>
<b>Sent:</b> Friday, September 11, 2020 12:03<br>
<b>To:</b> amd-gfx list &lt;amd-gfx@lists.freedesktop.org&gt;; Chen, Guchun=
 &lt;Guchun.Chen@amd.com&gt;; Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;<=
br>
<b>Subject:</b> [PATCH] drm/amdgpu: Update RAS init handling</p>
</div>
</div>
<p class=3D"x_MsoNormal">&nbsp;</p>
<p class=3D"x_msipheadera92e061b" style=3D"margin:0in"><span style=3D"font-=
size:10.0pt; font-family:&quot;Arial&quot;,sans-serif; color:#0078D7">[AMD =
Official Use Only - Internal Distribution Only]</span></p>
<p class=3D"x_MsoNormal">&nbsp;</p>
<p class=3D"x_MsoNormal">Added RAS status check and tear down RAS context i=
f RAS init fails</p>
</div>
</div>
</div>
</body>
</html>

--_000_MN2PR12MB44881E2896EA9A8A7323E0FEF7230MN2PR12MB4488namp_--

--===============1900331451==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1900331451==--
