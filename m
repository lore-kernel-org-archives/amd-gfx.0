Return-Path: <SRS0=DbcS=A4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02CF5C433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Jul 2020 03:31:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C111E20672
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Jul 2020 03:31:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="qEuXdQoF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C111E20672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 238A26E3E3;
	Fri, 17 Jul 2020 03:31:52 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2057.outbound.protection.outlook.com [40.107.92.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE8E96E3E3
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Jul 2020 03:31:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C9IyANKVOLFUsiHYlMemlqA41lS6me7gq8FGhmYICkI5pROvS4M6DcUI9JcP+HSBKkUtipE++mcY9UBBsLLnIAVKrs9+U8ca3nvNO8d3OF98jrwvh7vE4CmQaPafbV8gVxHnx5QWUnaK9Byq3OrtCgKezCset4M3q3igXpRx6G7xuv24eAAx5tQfhU2jES+vGM0/FPS03zGYxjW/jJLuJZ3L5vONh1fOWpWC57xIooK8oPtcOPLPiFmvy+U1BB6EDZ0oWw/+mOP7PZVybraRP5FIuWfG5ZPbje74oMBF3Pqnffezy8p1h5F4mqWAUbW8AFU58LDkYNNtD5WOuUUyyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j9btYHTAwNodayKqzHEXgE2w4EnfQUi+4G5QNUmYNok=;
 b=X8SREeaOCt8FO6uNWNsi8MZbDYgexZpglqpCuvo37xAZuhRYyS+hIlwT8NsHutMeYLqucu4ABI10bjd/8hV4gnH2laFawMG+RIG44ttH5Hl6Y14Mawou0pS+ppiSJ7WLuSxommrSxUIjKxBoxaWe3wIiFNzvhAXUkMSzNLW+4S2nhTaDL7ZesPMrjZoEmfakFX+jqGiUKdz4rEF+efOYdb6jKFhbaFpzFXVDNUIiJVmpxjee5bh84LcZDp/VuxOzJl8gOnm+Bcwcsj8a/hoVFCbd6hMntTP7e07EPcp6bJL6jA4RMkbROqf4UfYMyq0d3hHNxj1T7ytVtia33Yw4Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j9btYHTAwNodayKqzHEXgE2w4EnfQUi+4G5QNUmYNok=;
 b=qEuXdQoFujlBzlcIcnlf07StCtZpwL+MxWjWhHW1kEjOQmf1q4NqFpuAgWNyaA0fdZ3wV38gbSE6jbua4UWTXbIHWeWB5afv3qSg2BADUuv77L615Q6ALP8vZVpe3TRGW2pTmntFZtEz/ZX8e+gxNKPeLuaV3a+JchqfhyzZMSI=
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM5PR12MB1449.namprd12.prod.outlook.com (2603:10b6:4:10::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3195.17; Fri, 17 Jul 2020 03:31:48 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::84dc:a0e7:6158:ce4e]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::84dc:a0e7:6158:ce4e%7]) with mapi id 15.20.3195.022; Fri, 17 Jul 2020
 03:31:48 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Clements, John" <John.Clements@amd.com>, amd-gfx list
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: enable xgmi support for sienna cichlid
Thread-Topic: [PATCH] drm/amdgpu: enable xgmi support for sienna cichlid
Thread-Index: AdZb5voK0BBGnflxRYC2uCZxkRhgFwAA8USA
Date: Fri, 17 Jul 2020 03:31:48 +0000
Message-ID: <DM6PR12MB40756E7534CFFCFBB863C617FC7C0@DM6PR12MB4075.namprd12.prod.outlook.com>
References: <MN2PR12MB403253A79DD30D2BCF42B744FB7C0@MN2PR12MB4032.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB403253A79DD30D2BCF42B744FB7C0@MN2PR12MB4032.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-07-17T03:04:59Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=b1369a1f-c963-4ee5-961e-00001fb09a05;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-07-17T03:31:45Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: d228e302-4448-49aa-89e8-0000d0054286
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0a972720-9ba5-4fb4-0a29-08d82a01f025
x-ms-traffictypediagnostic: DM5PR12MB1449:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB144943BC2902F0C49500DB0FFC7C0@DM5PR12MB1449.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3173;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AMOjWYkC5Xe99X6SgKbfdYU3XKyjnAnMnmT8Bp6WowOP8WCYt4A950wy6mkU1Wa5TFsQJuYFuZ63yitjYFcfoJcT6HAfxc3O7yNJbL018gUSgqAKBLtHkeUVC+sMMDWyEqqtLxIjvpB2zX0LMgTz9H+QZsDd4aFw8nLeety4vaZREJOtqUZw0mGNMfnM2aq0SCH84WTASHm5b0BOBGkl/TttWQxod5zWvBvrCMyMCDPXOkK4V88knrsEXhQVWXFrDQ7SB5GtXFGna5BkdkpV0FM5kMqHEg/2aBtrHZeOx5laD5EHQDLvQiLUFusnecxs
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(136003)(366004)(346002)(396003)(39860400002)(110136005)(76116006)(478600001)(52536014)(8676002)(71200400001)(2906002)(64756008)(8936002)(66446008)(186003)(53546011)(316002)(7696005)(6506007)(66946007)(9686003)(33656002)(4744005)(86362001)(55016002)(66556008)(26005)(5660300002)(66476007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: u753IOFOpvTvwyexqJUBA/LILz/yvoAGoEBA+uEBlXf/PavfzFns94y3oO8kQtGljI2KVPey8VoQadQjz/PKZctOHex03P3l5OzKhoYrnZO6hSNmj65wd2ryZB50LT/x0Voh5ZdOziYYfBdFSC9w3g6OkpNvCB36MADorCxgUZdtOpoepaMcA5ti7RovUlpxj5KhmuoHcXmwcreBy4lLIpfN+gbyrQui3TwWa4NNu3SVu+kzXXLUYi1sTXaXeGdcnuBkkfX1OzEVhe0uGWHjk+/dq38hi+PWqxB6BBMHg0kQh5vfuIqufo7KVHniuMgglTzsMvGEE9LXy8pWmZ//iIh3RkcKPqICQYf51OXIA92sScm6zN6Y9ooBGmm1mgfbn2zZK0dEWD5R8seVkEprL20nSbx38sguUQtNO3TixKxe70mlvcjJtbxOMZTJpAd4wp6gLZQNt9wr0Sd52x9KaZSOpAlwkJMBTCqEMsrTl8IOJix8myRFXcUXGr9MQKKa
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a972720-9ba5-4fb4-0a29-08d82a01f025
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2020 03:31:48.4053 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ljJ7fxRLilAGb1pMPzgvgo3BBP3kZIIVLk+xEhhQvPZzju3RXL9xGmJZ3x99Ntw9a6EOAU/lIHx6CK2FyCEtSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1449
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
Content-Type: multipart/mixed; boundary="===============1238438826=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1238438826==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM6PR12MB40756E7534CFFCFBB863C617FC7C0DM6PR12MB4075namp_"

--_000_DM6PR12MB40756E7534CFFCFBB863C617FC7C0DM6PR12MB4075namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
From: Clements, John <John.Clements@amd.com>
Sent: Friday, July 17, 2020 11:05
To: amd-gfx list <amd-gfx@lists.freedesktop.org>; Zhang, Hawking <Hawking.Z=
hang@amd.com>
Subject: [PATCH] drm/amdgpu: enable xgmi support for sienna cichlid


[AMD Public Use]

Submitting patch to enable XGMI support for Sienna Cichlid

--_000_DM6PR12MB40756E7534CFFCFBB863C617FC7C0DM6PR12MB4075namp_
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
p.msipheader251902e5, li.msipheader251902e5, div.msipheader251902e5
	{mso-style-name:msipheader251902e5;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle19
	{mso-style-type:personal-compose;
	font-family:"Arial",sans-serif;
	color:#317100;}
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
<p class=3D"msipheader251902e5" style=3D"margin:0in;margin-bottom:.0001pt">=
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;co=
lor:#317100">[AMD Public Use]</span><o:p></o:p></p>
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
<b>Sent:</b> Friday, July 17, 2020 11:05<br>
<b>To:</b> amd-gfx list &lt;amd-gfx@lists.freedesktop.org&gt;; Zhang, Hawki=
ng &lt;Hawking.Zhang@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: enable xgmi support for sienna cichlid<=
o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"msipheader251902e5" style=3D"margin:0in;margin-bottom:.0001pt">=
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;co=
lor:#317100">[AMD Public Use]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Submitting patch to enable XGMI support for Sienna C=
ichlid<o:p></o:p></p>
</div>
</body>
</html>

--_000_DM6PR12MB40756E7534CFFCFBB863C617FC7C0DM6PR12MB4075namp_--

--===============1238438826==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1238438826==--
