Return-Path: <SRS0=SqeI=EC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA4CCC4363A
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2020 03:29:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B71E20728
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2020 03:29:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="JF/mT7vz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B71E20728
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8714E6EABF;
	Tue, 27 Oct 2020 03:29:07 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2045.outbound.protection.outlook.com [40.107.243.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC07B6EABF
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Oct 2020 03:29:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e2Bz1nNwV67dxaa2b9ax8cMgYTcraM0zuWA1Ym5sQRtlULnBVjiAxMs+fziNZ+5SgjUgQ3vOC5uLktjHb9pPyCVY78Ub2bdjsFUpfpt9HFsi92sxkXR61TCyvkHqw30kWZqA9cMYN1sClkvh1govRUxCF0e9rja/FGz0YYkapdwU3+5cZdYeBM2WN4QnTRtixIpdQbO1EKOPHEhzKzPui6+qnduol+xpPNMCX7zt0r2dGHL75tgsiqGkwtwOAOjAmc2KeoqDqa8UyYT40w9yfsHGAPu8TmxSnem935D3uCdilhENgBaOKzKOHCi4SKju0YYsQ0ec3Ap2ZP1A1Qw7kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PitsneimGt1eNyPjAD1HVIiLntmzgbkWmPHYNavlF7Q=;
 b=S5h8jWEHpgUjPyAzHMpqyusaLBK+VTNSEjuaf1O9WtL3pu6rwjTIkZTopzP5vsr19FAMAL/MfxJVZK+V7tzBzcv6n/B7XFCJWA3/vTqaGp7C3Su9OcQq9Rum+YXHrRNb6Ug6uqYtZXe1SomUnDSIQb81qXWRiqiqsKEe7HxRmW7Lc8PO/IRIJl5IVOTmGBfxxiTddOtwK1VJw8NSH+fsOPOb5yRfQJg1FJdQOo2VnLFC1tLW4Rt659vi47QDsueeKW7FMUMwQdHmYZAto3U4wCFo8mmno5bTazCc9K1Tarn26+qhVI2rXzs6psMsE3l+LiFXZjicIUZ6BlM1nb6s+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PitsneimGt1eNyPjAD1HVIiLntmzgbkWmPHYNavlF7Q=;
 b=JF/mT7vzfCqCuSsFdg7/wHboPAEngqBGgm50AkApaW+ofuDAyBgxnvBVWqLLYoivY7B+ZZDqEfWbcgqvPUzzSuFdmbHJluyzdyfVEL5MPgYQ21lOjxdiperKBg8ONTqREib/wV64qy9V7PVxSqIDlAomyAkSDvjnKJrohNrgrC0=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB4124.namprd12.prod.outlook.com (2603:10b6:5:221::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.18; Tue, 27 Oct 2020 03:29:04 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118%5]) with mapi id 15.20.3477.028; Tue, 27 Oct 2020
 03:29:04 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: Lei Guo <raykwok1150@163.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] Fix bug to get average GPU power
Thread-Topic: [PATCH] Fix bug to get average GPU power
Thread-Index: AQHWqOs+QIO6ZC/KBUiNmAaM8y/IIamq0K+Q
Date: Tue, 27 Oct 2020 03:29:04 +0000
Message-ID: <DM6PR12MB2619D9C7A99E30FA46363C5AE4160@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <f843846.2b92.1755368c82e.Coremail.raykwok1150@163.com>
In-Reply-To: <f843846.2b92.1755368c82e.Coremail.raykwok1150@163.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=0d3eff08-0f57-488d-8041-fac831879f58;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-10-27T03:28:41Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: 163.com; dkim=none (message not signed)
 header.d=none;163.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6c78cd15-5fb3-4079-9bfb-08d87a2874a8
x-ms-traffictypediagnostic: DM6PR12MB4124:
x-microsoft-antispam-prvs: <DM6PR12MB4124F407C575B525D4E6FC18E4160@DM6PR12MB4124.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:190;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PJ3qC0BTnasQ3VBa4ZUmLinxroABZI6w3+CZoI4WZFVZM1f+Ubil2Or8WBhY3oGtxmcHSwDo27Dci9hlYRYsj42EdAk7+y+Wbzdcsretaifc13yt2rgYJ6kqnbvg8h5hZhyHFrGojt3pNMM48slig2JZFXEnn7wETp69+LVe9aU9V5Wn/hlP3UjTDU3paC1GtDfEhVBY1Sot2XJN9lc1sFHkDC1BKXDZl8jN6+A7dsK1cUY7s3SXxEG/zJhUYgYj0eCAuSVkw3voRNaam1fSZ5lb5glyOPRNDWn5mRGcnRnUr64aS0hQJwfg+xe10dFfUATkCmm/Cai+h4sR8vxw4Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(376002)(346002)(136003)(39860400002)(7696005)(55016002)(26005)(110136005)(186003)(6506007)(478600001)(86362001)(33656002)(316002)(8936002)(53546011)(2906002)(76116006)(9686003)(52536014)(66476007)(8676002)(5660300002)(64756008)(66556008)(71200400001)(66446008)(66946007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: z/Frk8vR3ophKbQSLmluCEODJSu92C2BIb7QImSMwn7x3vdk+Mdn8Wc/x9ubgPu1o2UJBYRxWMC2UYgsoHeDVHGFxSErAYg50ZVRu4Kc3tDtiDi2wjpKEcU/FAv2+KX9TCCjnJ3jY6O/AnK9fOIxdjxh40cxXMPlQ2Z22KUoleSvOTPYmmxGNPDgTgHEyogpT7LN5uwtL3PMk62AyypdmSHlpRQt89zC5R5feoDyCe0bSmY5NL3mU1iWsrnnD4veE4fZnJBbUbcnrBLnxBtGeerpVnQ7jCc4M0zE8oTY6pf/MkvtmNvbZmCPFmc8nPW39LbtMT/OgWYm8pUeUfyfWuaxLA8viURSbXN71Is53v3GsU4Uo/ZAIlZKVQncq/Bpj8E9uCtUon5MI/K2rL5L4QQBfHlQqfPmDJ6CH4LFFbgRqWM9Htr1ykZeiTQOc9aqZH34n7k53h0txiVA3/MLwbz3y0EsRBisFNDCK7aCmHGp2SAHUbcSv/Bqjbfyb9hqmG/PB//6rXFlDiaUM6fkw/pVErHFlb9rNg4X75peLN+79HsjFXA6oCi6Js1//kkq8N2xCQ658qYNgxgDp0rM3VPj3dqRVS7LCm6O51sATSPaxOTbPYmKminRAjyilH11/NGKysMhA/tpT9jtJ/h3BA==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c78cd15-5fb3-4079-9bfb-08d87a2874a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2020 03:29:04.6513 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H6gd7t3LpMmNI4pwzY9gaBOLZkM0HRWn12p0mlXwZd1Pf+58RAbYXCyNR3SWBeNt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4124
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
Content-Type: multipart/mixed; boundary="===============0006046775=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0006046775==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM6PR12MB2619D9C7A99E30FA46363C5AE4160DM6PR12MB2619namp_"

--_000_DM6PR12MB2619D9C7A99E30FA46363C5AE4160DM6PR12MB2619namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Evan Quan <evan.quan@amd.com<mailto:evan.quan@amd.com>>

From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Lei Guo
Sent: Friday, October 23, 2020 11:03 AM
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] Fix bug to get average GPU power


From 0277318fc1799d17878d9f407254773fc2bb964c Mon Sep 17 00:00:00 2001

From: Guo Lei <raykwok1150@163.com<mailto:raykwok1150@163.com>>

Date: Fri, 16 Oct 2020 17:03:44 +0800

Subject: [PATCH] Fix bug to get average GPU power



Synchronize emu amd_pp_sensors with kgd_pp_interface.h



Signed-off-by: Guo Lei <raykwok1150@163.com<mailto:raykwok1150@163.com>>

Change-Id: I531fa006ecdd1d42e589bbfe79a7d6699ae5b2b6

---

 src/umr.h | 3 +++

 1 file changed, 3 insertions(+)



diff --git a/src/umr.h b/src/umr.h

index c928fad..8c45f12 100644

--- a/src/umr.h

+++ b/src/umr.h

@@ -79,6 +79,9 @@ enum amd_pp_sensors {

          AMDGPU_PP_SENSOR_MEM_LOAD,

          AMDGPU_PP_SENSOR_GFX_MCLK,

          AMDGPU_PP_SENSOR_GPU_TEMP,

+        AMDGPU_PP_SENSOR_EDGE_TEMP =3D AMDGPU_PP_SENSOR_GPU_TEMP,

+        AMDGPU_PP_SENSOR_HOTSPOT_TEMP,

+        AMDGPU_PP_SENSOR_MEM_TEMP,

          AMDGPU_PP_SENSOR_VCE_POWER,

          AMDGPU_PP_SENSOR_UVD_POWER,

          AMDGPU_PP_SENSOR_GPU_POWER,

--

2.17.1





--_000_DM6PR12MB2619D9C7A99E30FA46363C5AE4160DM6PR12MB2619namp_
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
	{font-family:\5B8B\4F53;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:\7B49\7EBF;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@\7B49\7EBF";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"\@\5B8B\4F53";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:12.0pt;
	font-family:\5B8B\4F53;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
span.EmailStyle20
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri",sans-serif;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.25in 1.0in 1.25in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word">
<p style=3D"font-family:Arial;font-size:11pt;color:#0078D7;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">Reviewed-by: Evan Quan &lt;<a href=3D"mailto:evan.q=
uan@amd.com">evan.quan@amd.com</a>&gt;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b><span style=3D"font-size:11.0pt;font-family:&quot=
;Calibri&quot;,sans-serif">From:</span></b><span style=3D"font-size:11.0pt;=
font-family:&quot;Calibri&quot;,sans-serif"> amd-gfx &lt;amd-gfx-bounces@li=
sts.freedesktop.org&gt;
<b>On Behalf Of </b>Lei Guo<br>
<b>Sent:</b> Friday, October 23, 2020 11:03 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org<br>
<b>Subject:</b> [PATCH] Fix bug to get average GPU power<o:p></o:p></span><=
/p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<p style=3D"margin:0in"><span style=3D"font-size:10.5pt;font-family:&quot;A=
rial&quot;,sans-serif;color:black">From 0277318fc1799d17878d9f407254773fc2b=
b964c Mon Sep 17 00:00:00 2001<o:p></o:p></span></p>
<p style=3D"margin:0in"><span style=3D"font-size:10.5pt;font-family:&quot;A=
rial&quot;,sans-serif;color:black">From: Guo Lei &lt;<a href=3D"mailto:rayk=
wok1150@163.com">raykwok1150@163.com</a>&gt;<o:p></o:p></span></p>
<p style=3D"margin:0in"><span style=3D"font-size:10.5pt;font-family:&quot;A=
rial&quot;,sans-serif;color:black">Date: Fri, 16 Oct 2020 17:03:44 +0800<o:=
p></o:p></span></p>
<p style=3D"margin:0in"><span style=3D"font-size:10.5pt;font-family:&quot;A=
rial&quot;,sans-serif;color:black">Subject: [PATCH] Fix bug to get average =
GPU power<o:p></o:p></span></p>
<p style=3D"margin:0in"><span style=3D"font-size:10.5pt;font-family:&quot;A=
rial&quot;,sans-serif;color:black"><o:p>&nbsp;</o:p></span></p>
<p style=3D"margin:0in"><span style=3D"font-size:10.5pt;font-family:&quot;A=
rial&quot;,sans-serif;color:black">Synchronize emu amd_pp_sensors with kgd_=
pp_interface.h<o:p></o:p></span></p>
<p style=3D"margin:0in"><span style=3D"font-size:10.5pt;font-family:&quot;A=
rial&quot;,sans-serif;color:black"><o:p>&nbsp;</o:p></span></p>
<p style=3D"margin:0in"><span style=3D"font-size:10.5pt;font-family:&quot;A=
rial&quot;,sans-serif;color:black">Signed-off-by: Guo Lei &lt;<a href=3D"ma=
ilto:raykwok1150@163.com">raykwok1150@163.com</a>&gt;<o:p></o:p></span></p>
<p style=3D"margin:0in"><span style=3D"font-size:10.5pt;font-family:&quot;A=
rial&quot;,sans-serif;color:black">Change-Id: I531fa006ecdd1d42e589bbfe79a7=
d6699ae5b2b6<o:p></o:p></span></p>
<p style=3D"margin:0in"><span style=3D"font-size:10.5pt;font-family:&quot;A=
rial&quot;,sans-serif;color:black">---<o:p></o:p></span></p>
<p style=3D"margin:0in"><span style=3D"font-size:10.5pt;font-family:&quot;A=
rial&quot;,sans-serif;color:black">&nbsp;src/umr.h | 3 +++<o:p></o:p></span=
></p>
<p style=3D"margin:0in"><span style=3D"font-size:10.5pt;font-family:&quot;A=
rial&quot;,sans-serif;color:black">&nbsp;1 file changed, 3 insertions(+)<o:=
p></o:p></span></p>
<p style=3D"margin:0in"><span style=3D"font-size:10.5pt;font-family:&quot;A=
rial&quot;,sans-serif;color:black"><o:p>&nbsp;</o:p></span></p>
<p style=3D"margin:0in"><span style=3D"font-size:10.5pt;font-family:&quot;A=
rial&quot;,sans-serif;color:black">diff --git a/src/umr.h b/src/umr.h<o:p><=
/o:p></span></p>
<p style=3D"margin:0in"><span style=3D"font-size:10.5pt;font-family:&quot;A=
rial&quot;,sans-serif;color:black">index c928fad..8c45f12 100644<o:p></o:p>=
</span></p>
<p style=3D"margin:0in"><span style=3D"font-size:10.5pt;font-family:&quot;A=
rial&quot;,sans-serif;color:black">--- a/src/umr.h<o:p></o:p></span></p>
<p style=3D"margin:0in"><span style=3D"font-size:10.5pt;font-family:&quot;A=
rial&quot;,sans-serif;color:black">+++ b/src/umr.h<o:p></o:p></span></p>
<p style=3D"margin:0in"><span style=3D"font-size:10.5pt;font-family:&quot;A=
rial&quot;,sans-serif;color:black">@@ -79,6 +79,9 @@ enum amd_pp_sensors {<=
o:p></o:p></span></p>
<p style=3D"margin:0in"><span style=3D"font-size:10.5pt;font-family:&quot;A=
rial&quot;,sans-serif;color:black">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; AMDGPU_PP_SENSOR_MEM_LOAD,<o:p></o:p></span></p>
<p style=3D"margin:0in"><span style=3D"font-size:10.5pt;font-family:&quot;A=
rial&quot;,sans-serif;color:black">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; AMDGPU_PP_SENSOR_GFX_MCLK,<o:p></o:p></span></p>
<p style=3D"margin:0in"><span style=3D"font-size:10.5pt;font-family:&quot;A=
rial&quot;,sans-serif;color:black">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; AMDGPU_PP_SENSOR_GPU_TEMP,<o:p></o:p></span></p>
<p style=3D"margin:0in"><span style=3D"font-size:10.5pt;font-family:&quot;A=
rial&quot;,sans-serif;color:black">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; AMDGPU_PP_SENSOR_EDGE_TEMP =3D AMDGPU_PP_SENSOR_GPU_TEMP,<o:p></o:p></s=
pan></p>
<p style=3D"margin:0in"><span style=3D"font-size:10.5pt;font-family:&quot;A=
rial&quot;,sans-serif;color:black">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; AMDGPU_PP_SENSOR_HOTSPOT_TEMP,<o:p></o:p></span></p>
<p style=3D"margin:0in"><span style=3D"font-size:10.5pt;font-family:&quot;A=
rial&quot;,sans-serif;color:black">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; AMDGPU_PP_SENSOR_MEM_TEMP,<o:p></o:p></span></p>
<p style=3D"margin:0in"><span style=3D"font-size:10.5pt;font-family:&quot;A=
rial&quot;,sans-serif;color:black">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; AMDGPU_PP_SENSOR_VCE_POWER,<o:p></o:p></span></p>
<p style=3D"margin:0in"><span style=3D"font-size:10.5pt;font-family:&quot;A=
rial&quot;,sans-serif;color:black">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; AMDGPU_PP_SENSOR_UVD_POWER,<o:p></o:p></span></p>
<p style=3D"margin:0in"><span style=3D"font-size:10.5pt;font-family:&quot;A=
rial&quot;,sans-serif;color:black">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; AMDGPU_PP_SENSOR_GPU_POWER,<o:p></o:p></span></p>
<p style=3D"margin:0in"><span style=3D"font-size:10.5pt;font-family:&quot;A=
rial&quot;,sans-serif;color:black">--&nbsp;<o:p></o:p></span></p>
<p style=3D"margin:0in"><span style=3D"font-size:10.5pt;font-family:&quot;A=
rial&quot;,sans-serif;color:black">2.17.1<o:p></o:p></span></p>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:10.5pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:black"><o:p>&nbsp;</o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><o:p>&nbsp;</o:p></p>
<p>&nbsp;<o:p></o:p></p>
</div>
</div>
</div>
</body>
</html>

--_000_DM6PR12MB2619D9C7A99E30FA46363C5AE4160DM6PR12MB2619namp_--

--===============0006046775==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0006046775==--
