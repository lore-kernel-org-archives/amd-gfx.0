Return-Path: <SRS0=G8as=BB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72000C433E1
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Jul 2020 21:50:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D7C32086A
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Jul 2020 21:50:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="CrsLIR4S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D7C32086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E3DC66E1B8;
	Wed, 22 Jul 2020 21:50:19 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2065.outbound.protection.outlook.com [40.107.92.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E6A7A6E1B8
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Jul 2020 21:50:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IANkuHq3VEdnlAUoI6qi17vQZojZG8eoJhBotKj0Dm2q1oboDghqc44x/VNdEiENC5fHL8Y4xF1AMhWPZowlHVmtioXlvtyofEbkTJaLakwPD+jXAXB8uQpTWHJijBut3TwNZOZaNSB84odUph/CJtZYar9A+4m5/AYc9hNHRU3/QpKq1NKSYJKRbBluZCiUmSgD302uiJldQNeeNSEiNaEGsW0+r8PG+RTHTuGSs6ivCQZ4DjigOok4aZph3VWKWx9LuysNutaNhZVhY4/gqweRqmEsZMKY90/kbMcFuhJTkwsI1Gh2GTXPaaru9O7NarRfgtlMT4/qZnefqyXb8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dxfHjJoP/LnciJHlQjOJNXmNe2gOrIcfmrbClXNes4c=;
 b=CJgjNB0V7iotwQHzr+6vL1jobE0DHDNzUDAY0XTIZo7rW4gMBROp5/hasH92h/iWppl1ZWtLnPpjuEyILnGR7/r/ePNvwfa+yN0SKPR7whTAdAVV01VYgw+efMfoNdQdSb43k/kvD0Cs3A5QjHamRNGnLbk+Ieg2tm81nhlWz9TxL5VtV1/iLlu03y5SjX0fWbuQT7QI3c2SFYOw0FpEuSOS5bjNHoOazyZpMTv3rrDnkFk6k1uWcYbo3MiexPxDQw/WHlRSItdfUCmGDP/dzrZnaf1Tlfq+J2wWsd8Y3gER/kZTde6oG+z/PqNICPyxBQlox3FzoUhSXVoKwitrCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dxfHjJoP/LnciJHlQjOJNXmNe2gOrIcfmrbClXNes4c=;
 b=CrsLIR4S6rdFsFxCxnyQUa952/WfFgrvMRJSJTTPCNt6wMVrD5PcP+rDwBVI5qsfMdzb6Fw/pHYeWVIFfwubNO50X6byfK9Ln1JmcxopQfp0AkZ9CRSwFyC+1t/a1CH5SATFjZhz7uZj5CrKtfgiqDwnqQKov7qMBMzvFJHq2ZA=
Received: from DM6PR12MB3132.namprd12.prod.outlook.com (2603:10b6:5:3c::27) by
 DM6PR12MB3131.namprd12.prod.outlook.com (2603:10b6:5:11d::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3195.17; Wed, 22 Jul 2020 21:50:17 +0000
Received: from DM6PR12MB3132.namprd12.prod.outlook.com
 ([fe80::49d3:13fe:5111:2a6d]) by DM6PR12MB3132.namprd12.prod.outlook.com
 ([fe80::49d3:13fe:5111:2a6d%3]) with mapi id 15.20.3195.026; Wed, 22 Jul 2020
 21:50:17 +0000
From: "Zhang, Boyuan" <Boyuan.Zhang@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: update dec ring test for VCN 3.0
Thread-Topic: [PATCH] drm/amdgpu: update dec ring test for VCN 3.0
Thread-Index: AdZgccRHrgdohRXqSnOqXNYtdslmbA==
Date: Wed, 22 Jul 2020 21:50:17 +0000
Message-ID: <DM6PR12MB3132C542467A3C72736B1BF187790@DM6PR12MB3132.namprd12.prod.outlook.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=611c5679-5ec6-4648-b6a1-e8d963c03916;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-07-22T21:47:40Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
x-bromium-msgid: b92c5800-dcbc-4386-a551-4185ddc5cec2
authentication-results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.11.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f45483a4-a5fc-4c06-4934-08d82e8938d7
x-ms-traffictypediagnostic: DM6PR12MB3131:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB3131CAD0CEF99A7453363C1287790@DM6PR12MB3131.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1079;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kM4Wfy/pBwCSTfXDJhAPdkDPJVz+I05Tvgh3JEp5foDUK80Ym1mxLChQgvBKI2w9bkJHD3isIyO1wu3P59YGYeCjrV9FO1JvdYiLl8hNWj6wz2AxHWPfr9Yqobk79abT/edOHmDVLuboRAmbDeyAct1i4kelLF5RVXVb3K/sNrHE41+qrUp0s21sXyAoo6RQXmOLMwYsLvtN6bPdkzhj7SD5jUhOk3GY5/0Laav4gQTOSjYaenTUjTOJ5doSZXGeeWJwGOshcQOZQuE9oGEokbdi3GLb6FuT09nubf+ScnBCnOfRAxb7DALjlpGhi5nKbKUUkxYdd5VmgwgjEVgL4g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3132.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(376002)(346002)(366004)(39860400002)(136003)(26005)(86362001)(76116006)(2906002)(9686003)(71200400001)(8936002)(55016002)(478600001)(4326008)(66946007)(66556008)(66476007)(6916009)(66446008)(8676002)(64756008)(5660300002)(83380400001)(4744005)(316002)(186003)(6506007)(7696005)(52536014)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: r1ANztWkeh+B/9516pMHeYTguDSVKtI8D75QuTMeubS7pM+0M3/7JjkYDMkTZptau6eLEK/035v+liDnlaOr4bISgVm/ZiXgDUDNpiG63wme76dfGTEIDLveSbfZsNtgbZd1Qc4p9y7QOb2ojlXh1vUCkkCfggx5behGD2RWZ40cpyL+2SJKeY5kUUaaNL0JTBC3XOE1vSC/5fE8w+QPH1cffIT65ORji1SCN7ac5QgWWm8CUCTWsG8Pc3wqYbmV6+dHzQ7xvGGUv2VVjfBROs1/VGYCSnwXtOaygSb4QJsQ6uMER0RTSDyjzZ2ueEuJwuV4Y+LCPFp4VK5leVo3DgKZfPC0mkamr6I87VbTcdykp4E5A7+SoWkcKxwSk+ydG62ol6JKwwCCDvFzTcSQnHiyz/6w/Tpukus9MdXQa4yU1m5Dkr7XJc8caEHifXGrNN3aUhX0m9QoO8LR6Z/vuMMdkXkR0Kl3PjaismffDa8p2aoFjaKvM0dzfQbuXFMo
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3132.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f45483a4-a5fc-4c06-4934-08d82e8938d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2020 21:50:17.1016 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QolFG1TsldZBJ0pdmFrmwePrcxvDE9j9JpNLRjIUAbo8YODUtg7GjdkXVtNkAIbbo3DvHUtIC2SGraAKvz7t7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3131
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
Cc: "Liu, Leo" <Leo.Liu@amd.com>
Content-Type: multipart/mixed; boundary="===============1352752480=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1352752480==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM6PR12MB3132C542467A3C72736B1BF187790DM6PR12MB3132namp_"

--_000_DM6PR12MB3132C542467A3C72736B1BF187790DM6PR12MB3132namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]


To enable SW ring for VCN 3.0



Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com<mailto:boyuan.zhang@amd.c=
om>>

---

 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c | 2 +-

 1 file changed, 1 insertion(+), 1 deletion(-)



diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/am=
dgpu/vcn_v3_0.c

index ddc1c43e09a8..8adebb3b2a3f 100644

--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c

+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c

@@ -1372,7 +1372,7 @@ static const struct amdgpu_ring_funcs vcn_v3_0_dec_ri=
ng_vm_funcs =3D {

  .emit_ib =3D vcn_v2_0_dec_ring_emit_ib,

  .emit_fence =3D vcn_v2_0_dec_ring_emit_fence,

  .emit_vm_flush =3D vcn_v2_0_dec_ring_emit_vm_flush,

- .test_ring =3D amdgpu_vcn_dec_ring_test_ring,

+ .test_ring =3D vcn_v2_0_dec_ring_test_ring,

  .test_ib =3D amdgpu_vcn_dec_ring_test_ib,

  .insert_nop =3D vcn_v2_0_dec_ring_insert_nop,

  .insert_start =3D vcn_v2_0_dec_ring_insert_start,

--

2.17.1


--_000_DM6PR12MB3132C542467A3C72736B1BF187790DM6PR12MB3132namp_
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
	{margin:0cm;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
p.xmsonormal, li.xmsonormal, div.xmsonormal
	{mso-style-name:x_msonormal;
	margin:0cm;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri",sans-serif;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 72.0pt 72.0pt 72.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-CA" link=3D"#0563C1" vlink=3D"#954F72">
<p style=3D"font-family:Arial;font-size:10pt;color:#0078D7;margin:15pt;" al=
ign=3D"Left">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div class=3D"WordSection1">
<p class=3D"xmsonormal"><span style=3D"color:black">To enable SW ring for V=
CN 3.0</span><o:p></o:p></p>
<p class=3D"xmsonormal"><span style=3D"color:black">&nbsp;</span><o:p></o:p=
></p>
<p class=3D"xmsonormal"><span style=3D"color:black">Signed-off-by: Boyuan Z=
hang &lt;<a href=3D"mailto:boyuan.zhang@amd.com">boyuan.zhang@amd.com</a>&g=
t;</span><o:p></o:p></p>
<p class=3D"xmsonormal"><span style=3D"color:black">---</span><o:p></o:p></=
p>
<p class=3D"xmsonormal"><span style=3D"color:black">&nbsp;drivers/gpu/drm/a=
md/amdgpu/vcn_v3_0.c | 2 &#43;-</span><o:p></o:p></p>
<p class=3D"xmsonormal"><span style=3D"color:black">&nbsp;1 file changed, 1=
 insertion(&#43;), 1 deletion(-)</span><o:p></o:p></p>
<p class=3D"xmsonormal"><span style=3D"color:black">&nbsp;</span><o:p></o:p=
></p>
<p class=3D"xmsonormal"><span style=3D"color:black">diff --git a/drivers/gp=
u/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c</span><=
o:p></o:p></p>
<p class=3D"xmsonormal"><span style=3D"color:black">index ddc1c43e09a8..8ad=
ebb3b2a3f 100644</span><o:p></o:p></p>
<p class=3D"xmsonormal"><span style=3D"color:black">--- a/drivers/gpu/drm/a=
md/amdgpu/vcn_v3_0.c</span><o:p></o:p></p>
<p class=3D"xmsonormal"><span style=3D"color:black">&#43;&#43;&#43; b/drive=
rs/gpu/drm/amd/amdgpu/vcn_v3_0.c</span><o:p></o:p></p>
<p class=3D"xmsonormal"><span style=3D"color:black">@@ -1372,7 &#43;1372,7 =
@@ static const struct amdgpu_ring_funcs vcn_v3_0_dec_ring_vm_funcs =3D {</=
span><o:p></o:p></p>
<p class=3D"xmsonormal"><span style=3D"color:black">&nbsp; .emit_ib =3D vcn=
_v2_0_dec_ring_emit_ib,</span><o:p></o:p></p>
<p class=3D"xmsonormal"><span style=3D"color:black">&nbsp; .emit_fence =3D =
vcn_v2_0_dec_ring_emit_fence,</span><o:p></o:p></p>
<p class=3D"xmsonormal"><span style=3D"color:black">&nbsp; .emit_vm_flush =
=3D vcn_v2_0_dec_ring_emit_vm_flush,</span><o:p></o:p></p>
<p class=3D"xmsonormal"><span style=3D"color:black">- .test_ring =3D amdgpu=
_vcn_dec_ring_test_ring,</span><o:p></o:p></p>
<p class=3D"xmsonormal"><span style=3D"color:black">&#43; .test_ring =3D vc=
n_v2_0_dec_ring_test_ring,</span><o:p></o:p></p>
<p class=3D"xmsonormal"><span style=3D"color:black">&nbsp; .test_ib =3D amd=
gpu_vcn_dec_ring_test_ib,</span><o:p></o:p></p>
<p class=3D"xmsonormal"><span style=3D"color:black">&nbsp; .insert_nop =3D =
vcn_v2_0_dec_ring_insert_nop,</span><o:p></o:p></p>
<p class=3D"xmsonormal"><span style=3D"color:black">&nbsp; .insert_start =
=3D vcn_v2_0_dec_ring_insert_start,</span><o:p></o:p></p>
<p class=3D"xmsonormal"><span style=3D"color:black">-- </span><o:p></o:p></=
p>
<p class=3D"xmsonormal"><span style=3D"color:black">2.17.1</span><o:p></o:p=
></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</div>
</body>
</html>

--_000_DM6PR12MB3132C542467A3C72736B1BF187790DM6PR12MB3132namp_--

--===============1352752480==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1352752480==--
