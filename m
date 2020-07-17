Return-Path: <SRS0=DbcS=A4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EAC8C433E1
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Jul 2020 03:32:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3E9720672
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Jul 2020 03:32:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="VMH4c1ne"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3E9720672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB0C56ECAC;
	Fri, 17 Jul 2020 03:32:34 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2044.outbound.protection.outlook.com [40.107.236.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B13F16ECAC
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Jul 2020 03:32:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MxWrbdvtrd8w4A3Kh1FM2WKdr80SnGZcrt2+HeJIIm3d5bLymFO7FBFOxNkvI5YhCijyuJftO+JWt4hx04DgZc3/0lusNZ4wpOTSHXqjzDsDjyut0o9h1cE/C5ySljYuN/4RnVmwE7niCvmZsPGTsCfUS8KpgSFRXYNIijAq2TrIpFyStvP6W7KdGzSBXv724iCL0aZMGxgMGh63duf03l/yWQKYg04id2UM1SYbJAuS9zJEhMBwse3I/1hfVpReTX9AuW7Mz9PxAwR4869M0ZJeTMlNYsjqfvtd5K1phz6NrVZLTvZeu/TPnFhWDG7AayiQjM3ylQ2RCPDJN5Wl1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lyG5aLJczKehDUu8WcVw8vgo8Czz8WFSft3oQnJvetw=;
 b=OpdeAyTCIBxtqzSSILpUE8aK8vOhKvGIRpZXhire2Cy7dKBDats1E9sL6Vy+Q0G3Z18oVGc8j9QFBM8Lofl8RBRLDkMsJFDZMFg5zpXhNv8f+zcf0pZcluAzs6aFqQz39Uc6HP4CFbCyLekZ/TXPaJpLiciAq1i4wO2oeImnag4Uhbj4zhLLt3kPhG8sllTZaNIoCMaOy7EbJENdPYr3al42nqNnFuvXYbN3lfFD5ZlWrmOuAILj0I15lD00fWKC4UX1LzbhE47zv+5BjIT7LrzFFYQ9o6UfnaQNB7+ICXa72zwJ1k09JwZ0es7OSgN8Ar8gNWsfqERVQu2mJsyjFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lyG5aLJczKehDUu8WcVw8vgo8Czz8WFSft3oQnJvetw=;
 b=VMH4c1ne+blfZcsyHxG4TE0q2o5HHr5vNt6Z/wDrqRv0N/OIBjViU26GOtmOHMLJ7Pi9swyxLSa+RhlgQr+bELtkArt2P5DPoSddg2g2MLgNJ1FkPLBEI3Yr6sVoO3idZ2/S/R4XI0tLhOGn03PqqQP6oMUMNwtENu6O2PJxwro=
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM5PR12MB2503.namprd12.prod.outlook.com (2603:10b6:4:b2::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3195.17; Fri, 17 Jul 2020 03:32:31 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::84dc:a0e7:6158:ce4e]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::84dc:a0e7:6158:ce4e%7]) with mapi id 15.20.3195.022; Fri, 17 Jul 2020
 03:32:31 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Clements, John" <John.Clements@amd.com>, amd-gfx list
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: load asd for sienna cichlid
Thread-Topic: [PATCH] drm/amdgpu: load asd for sienna cichlid
Thread-Index: AdZb5s7W/orfS031TdOLk1oze16WOQABAokw
Date: Fri, 17 Jul 2020 03:32:31 +0000
Message-ID: <DM6PR12MB4075D12B2340BD4A7AF28C86FC7C0@DM6PR12MB4075.namprd12.prod.outlook.com>
References: <MN2PR12MB4032A940BE0A5268028FFFFFFB7C0@MN2PR12MB4032.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB4032A940BE0A5268028FFFFFFB7C0@MN2PR12MB4032.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-07-17T03:03:45Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=0406ebc4-0dba-4c39-999d-0000cc23c581;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-07-17T03:32:29Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 4140ecea-6043-4e1b-ad3f-0000972dd218
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 72ed840d-38de-4532-2b0e-08d82a0209fb
x-ms-traffictypediagnostic: DM5PR12MB2503:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB25032D34760E01AF006AC2E2FC7C0@DM5PR12MB2503.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3173;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8rZFvf5bDWpoAEIKOlgRWrVBa3NoooW00WRjk8ZRzD3skX8i7WL/fxTVAl2kEr9c3EPu65aMQLyL7JF3EaQpNOyBbTSR1eBiD+1iTYyzzwHjRABXpA6d/EIDUvt6inuoHNGmiT4TFOxA5aG91ZVXEwR8eFw8QZN8EWj1L4BuUHkvUY4RMkF/9kzXKqQd+5dtlUSIi67jNI3dWBGQDNm4KWGnLOmCZSoafNLltBStIgRdfVGiKJ5pa4gVmO3zf0pOnyL9+mH7wigme+w2V25FeWdYQH3gHPM743mUfp0bsInDYDGYgiZVcISUCbo3hN6v
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(346002)(396003)(39860400002)(366004)(136003)(8676002)(8936002)(52536014)(7696005)(76116006)(5660300002)(71200400001)(86362001)(66476007)(26005)(2906002)(66556008)(64756008)(55016002)(316002)(186003)(66946007)(53546011)(6506007)(110136005)(4744005)(66446008)(478600001)(33656002)(9686003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: Lmd9F8gzvNxyVC80ea0CkJxFL6570KPkWxm81kFVE8Mipl7kcQ8NNJAWGmZEEAE1IKneUNNiDasqwb7uHTGDzdAwb4P0qfIDOBC7o0kFtuQJHI+JosINbgYVeBpRkHn4L0343DHne5Y7+PkBHHYSYyE/3Y78fky3Z4uhkmAmoW0yjipMRXNKYtBG/NNFcHE5Mc1yIO3LMjnl5TGi4Ccl/xTxBhk7qPAOBhjNhbHRzZc/WdQFjXKOT+2FBiV/+VR9DgOgEQIviQht2f/Zp+wCBZAefncBd1qS3Axwo8jyp0VKnjE12JmcCwkqOqytHkD3q8zgLwL6XyjoEgDjMGFhCGtOIMGkMvOfSgfnoJy+NzGvyxi93jehEd4e7JHvdKg8r8F/jHCs9C7iZfijKEmY0F2BAf84FKHkmrW25+v+G3teLOraogeOnETy8TXkYl+ciGk3BWx6zfZppjqR57dxv3tcdlFQvv+Xk4rUnYY1YaH8iqNUIDQWigaS8v82tpJw
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72ed840d-38de-4532-2b0e-08d82a0209fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2020 03:32:31.7288 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hCdV55FddHH0z3H0NRyeOppuMm3oW5Lg4pJeGOLLLvR0bYrQ/pQnNUvSRN4WoRi/6IWgDnm682J6vk4pnDYCsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2503
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
Content-Type: multipart/mixed; boundary="===============0305134314=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0305134314==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM6PR12MB4075D12B2340BD4A7AF28C86FC7C0DM6PR12MB4075namp_"

--_000_DM6PR12MB4075D12B2340BD4A7AF28C86FC7C0DM6PR12MB4075namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
From: Clements, John <John.Clements@amd.com>
Sent: Friday, July 17, 2020 11:04
To: amd-gfx list <amd-gfx@lists.freedesktop.org>; Zhang, Hawking <Hawking.Z=
hang@amd.com>
Subject: [PATCH] drm/amdgpu: load asd for sienna cichlid


[AMD Public Use]

Submitting patch to enable ASD loading for Sienna Cichlid

--_000_DM6PR12MB4075D12B2340BD4A7AF28C86FC7C0DM6PR12MB4075namp_
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
<b>Sent:</b> Friday, July 17, 2020 11:04<br>
<b>To:</b> amd-gfx list &lt;amd-gfx@lists.freedesktop.org&gt;; Zhang, Hawki=
ng &lt;Hawking.Zhang@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: load asd for sienna cichlid<o:p></o:p><=
/p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"msipheader251902e5" style=3D"margin:0in;margin-bottom:.0001pt">=
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;co=
lor:#317100">[AMD Public Use]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Submitting patch to enable ASD loading for Sienna Ci=
chlid<o:p></o:p></p>
</div>
</body>
</html>

--_000_DM6PR12MB4075D12B2340BD4A7AF28C86FC7C0DM6PR12MB4075namp_--

--===============0305134314==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0305134314==--
