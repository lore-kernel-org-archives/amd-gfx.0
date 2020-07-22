Return-Path: <SRS0=G8as=BB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78018C433DF
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Jul 2020 22:02:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 445C12086A
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Jul 2020 22:02:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="k6nnmtWz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 445C12086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0EDAC6E0AD;
	Wed, 22 Jul 2020 22:02:46 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2081.outbound.protection.outlook.com [40.107.236.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F8E26E0AD
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Jul 2020 22:02:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=brQ0n3SwVzfezgI/XduNMm61xC1QCoEKbPXxTtaI8qQ5FCgRHc2aA4BrGR4wOmejZPbKxOxboQv3g+YLB4Wq1XSc5ucmk0NkXG2e9OuYDhMj90wVYgkLvIT5gyAe1lwdpX729P6iRXKSkZQpSUwdEHkvMj4tMdECbkKtd14UwAVFkpXogqLBQQRZh9lVUsTGYlUTT27zYqyN1UwnDUWcVI0fJTBCBPEOAn4XRnoH69HdVFjUl3LJzrKBodBXwJMPqpHNQmpyEKXWgZm7TsLjCSNd1DsC9hbqBIDJlHSZ4nVC4GXp/uYh88dnvWX805f89Vf5M0mtrUtARgsoMRSKBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x8kM9oDmEZ01N46D+nukLOI9n9R1X12KWUwDTY4s/IA=;
 b=L5/5S6VZsjrfuAyM4odyJVz507JhVDtT0Hg831b5Wy+ulbkVtB1PzWKqP5Q07dRyjZ3WDcRp1PpMAxMdrgqIW558N6wYE8QactYcGvC2PS8eW76R6ClrpM0Mie8RN/t8XCb8YCYHG1IF8saNBFc0MXaVv6/jqH6p8OZufvkGXJEZcNh+lx8hC4IzQ/zvM5w611CWXYlVCG6bZ7x0d5zUaWlUpOKjdH+oVlOVEOrXc1/4gVfxb+J7AO81SgklK/lVfR6+48Vj0D0RBIlQVOtK09CjqFOVaK+doOVHoHKkMzJH7/8Nyk1SBLjDyrmQLTo5wOgh81BsXsXvxsZyvH/wzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x8kM9oDmEZ01N46D+nukLOI9n9R1X12KWUwDTY4s/IA=;
 b=k6nnmtWzFaEZv8pCKDiY75vnxZF6shXAG8yuqx0twwcl/OQKBHOajZjFMc62jYftajO7jQnJA6s+Or7Jfq84CZsTmWFDDJYwC+KysoEVhiVoBQg7Y4+OOUiNTkmnnxAMUi3HFsBzCuWZUW7qDGlqwjsNMjlAjgumwiaXms3yuNU=
Received: from DM5PR12MB1787.namprd12.prod.outlook.com (2603:10b6:3:113::12)
 by DM6PR12MB4371.namprd12.prod.outlook.com (2603:10b6:5:2a3::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.23; Wed, 22 Jul
 2020 22:02:43 +0000
Received: from DM5PR12MB1787.namprd12.prod.outlook.com
 ([fe80::fcaf:8267:b3d6:32ee]) by DM5PR12MB1787.namprd12.prod.outlook.com
 ([fe80::fcaf:8267:b3d6:32ee%7]) with mapi id 15.20.3216.020; Wed, 22 Jul 2020
 22:02:43 +0000
From: "Liu, Leo" <Leo.Liu@amd.com>
To: "Zhang, Boyuan" <Boyuan.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: update dec ring test for VCN 3.0
Thread-Topic: [PATCH] drm/amdgpu: update dec ring test for VCN 3.0
Thread-Index: AdZgccRHrgdohRXqSnOqXNYtdslmbAAAe0eA
Date: Wed, 22 Jul 2020 22:02:43 +0000
Message-ID: <DM5PR12MB17873A6B38C150232AE01AF0E5790@DM5PR12MB1787.namprd12.prod.outlook.com>
References: <DM6PR12MB3132C542467A3C72736B1BF187790@DM6PR12MB3132.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB3132C542467A3C72736B1BF187790@DM6PR12MB3132.namprd12.prod.outlook.com>
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
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [2607:fea8:a3c0:203:7101:5c38:8381:4a8]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8c90226b-d010-4d53-e0bf-08d82e8af5cb
x-ms-traffictypediagnostic: DM6PR12MB4371:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB4371B3F25839E3ADC8623879E5790@DM6PR12MB4371.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1079;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: p+lCNz4I4bnU7A1YBDU/2sKg9dwX2KaH0e3z27rVoAPO/jmUdJDS9dminUGCN22cIZKPB+zwdHSCZzTW6DJ2EwEO3yA+MdVbrYggHh5l9kqCymZ96PNkLagAbGCAIh7bLj4wqI7eRAAHR1DAuXU1mHcKLCiUDGSAbUF1jdcS2dT/0EgM4NHkxSnj3iyVGUrRc9b4N8xpBoSjUUiIzP3MFsMuLXo+n00eCELmHlaGOMUxFD3NNLVjN7JZmSo1QF1LLfuv4vjJDtmIbRPi5F5cMCZa53bDmenpEE0CqcSAAf9uvFwfrFJjvnnwtjTG+VQ4
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1787.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(376002)(346002)(39860400002)(396003)(366004)(9686003)(52536014)(66476007)(66556008)(64756008)(66946007)(76116006)(55016002)(66446008)(186003)(15650500001)(5660300002)(2906002)(33656002)(110136005)(86362001)(71200400001)(478600001)(8936002)(6506007)(53546011)(83380400001)(316002)(7696005)(8676002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: /7pkJ2AuzVgLtYaJVw36H4GNdF0d7Y9bkLtHuB+UDjALSjC+RDdcoMiwkYKdPWp+tVDazkN4pJOmDLCvTdub/XddwqfzgAWI2TGOhjRKZ8FMBMm5CLY9DWLrbAZajxdEZ6fqNK7yqbbIPg2GLTh3TM9EGwMKbLLUTWpxAPWA/q7tEl6JqlqPLX/pyoc68ZzKVSO2xCuY8C8bDojznAgBCCSIqfOPlpdoI74ElPBqk41BuAgIo5Cla7UgPrj5ZGWCVFqhxwtIK6hYZDGOKUOlTKqWv2RbHp/xPJQQywiXn0HX6CX7u4iwNDsWQ0qOnxLaxepIvapepSMJ5W2vAJ4OJyiDiwVYSEBXPE/VSeffDa+OeYcyk9owLCnefTH8CL/Db/oergnb69lnzrPRa8HU3qGqymiO5x5BvBm472x2O0cHZoc1pD3n4x2cy7tykvKegNrNdG7LlkfxiyZUWJ+VKFvVrVleLLMfINo+aFeJXAERFzbM4mtZAtdUGJGPFJM1dOPb6VOz/CgqClab/E2YtUNwL5lCE8yuWuBc7PMLZcw=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1787.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c90226b-d010-4d53-e0bf-08d82e8af5cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2020 22:02:43.6149 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LK8k+QRuY8DDy8ny9ubwmeO9SdekHH2Yo7zVBOG6aJMHsO7q+F1kzN4M9bALVHGE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4371
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
Content-Type: multipart/mixed; boundary="===============0108757655=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0108757655==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM5PR12MB17873A6B38C150232AE01AF0E5790DM5PR12MB1787namp_"

--_000_DM5PR12MB17873A6B38C150232AE01AF0E5790DM5PR12MB1787namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Leo Liu <leo.liu@amd.com>


From: Zhang, Boyuan <Boyuan.Zhang@amd.com>
Sent: July 22, 2020 5:50 PM
To: amd-gfx@lists.freedesktop.org
Cc: Liu, Leo <Leo.Liu@amd.com>
Subject: [PATCH] drm/amdgpu: update dec ring test for VCN 3.0


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


--_000_DM5PR12MB17873A6B38C150232AE01AF0E5790DM5PR12MB1787namp_
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
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
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
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:#954F72;
	text-decoration:underline;}
p.msonormal0, li.msonormal0, div.msonormal0
	{mso-style-name:msonormal;
	mso-margin-top-alt:auto;
	margin-right:0cm;
	mso-margin-bottom-alt:auto;
	margin-left:0cm;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
p.xmsonormal, li.xmsonormal, div.xmsonormal
	{mso-style-name:x_msonormal;
	margin:0cm;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle19
	{mso-style-type:personal;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
span.EmailStyle21
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
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
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US">Reviewed-=
by: Leo Liu &lt;leo.liu@amd.com&gt;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US"><o:p>&nbs=
p;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US"><o:p>&nbs=
p;</o:p></span></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0cm =
0cm 0cm">
<p class=3D"MsoNormal"><b><span lang=3D"EN-US">From:</span></b><span lang=
=3D"EN-US"> Zhang, Boyuan &lt;Boyuan.Zhang@amd.com&gt;
<br>
<b>Sent:</b> July 22, 2020 5:50 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org<br>
<b>Cc:</b> Liu, Leo &lt;Leo.Liu@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: update dec ring test for VCN 3.0<o:p></=
o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p style=3D"margin:15.0pt"><span style=3D"font-size:10.0pt;font-family:&quo=
t;Arial&quot;,sans-serif;color:#0078D7">[AMD Official Use Only - Internal D=
istribution Only]<o:p></o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
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
md/amdgpu/vcn_v3_0.c | 2 +-</span><o:p></o:p></p>
<p class=3D"xmsonormal"><span style=3D"color:black">&nbsp;1 file changed, 1=
 insertion(+), 1 deletion(-)</span><o:p></o:p></p>
<p class=3D"xmsonormal"><span style=3D"color:black">&nbsp;</span><o:p></o:p=
></p>
<p class=3D"xmsonormal"><span style=3D"color:black">diff --git a/drivers/gp=
u/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c</span><=
o:p></o:p></p>
<p class=3D"xmsonormal"><span style=3D"color:black">index ddc1c43e09a8..8ad=
ebb3b2a3f 100644</span><o:p></o:p></p>
<p class=3D"xmsonormal"><span style=3D"color:black">--- a/drivers/gpu/drm/a=
md/amdgpu/vcn_v3_0.c</span><o:p></o:p></p>
<p class=3D"xmsonormal"><span style=3D"color:black">+++ b/drivers/gpu/drm/a=
md/amdgpu/vcn_v3_0.c</span><o:p></o:p></p>
<p class=3D"xmsonormal"><span style=3D"color:black">@@ -1372,7 +1372,7 @@ s=
tatic const struct amdgpu_ring_funcs vcn_v3_0_dec_ring_vm_funcs =3D {</span=
><o:p></o:p></p>
<p class=3D"xmsonormal"><span style=3D"color:black">&nbsp; .emit_ib =3D vcn=
_v2_0_dec_ring_emit_ib,</span><o:p></o:p></p>
<p class=3D"xmsonormal"><span style=3D"color:black">&nbsp; .emit_fence =3D =
vcn_v2_0_dec_ring_emit_fence,</span><o:p></o:p></p>
<p class=3D"xmsonormal"><span style=3D"color:black">&nbsp; .emit_vm_flush =
=3D vcn_v2_0_dec_ring_emit_vm_flush,</span><o:p></o:p></p>
<p class=3D"xmsonormal"><span style=3D"color:black">- .test_ring =3D amdgpu=
_vcn_dec_ring_test_ring,</span><o:p></o:p></p>
<p class=3D"xmsonormal"><span style=3D"color:black">+ .test_ring =3D vcn_v2=
_0_dec_ring_test_ring,</span><o:p></o:p></p>
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
</div>
</body>
</html>

--_000_DM5PR12MB17873A6B38C150232AE01AF0E5790DM5PR12MB1787namp_--

--===============0108757655==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0108757655==--
