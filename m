Return-Path: <SRS0=tiv0=75=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 927EFC433E1
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Jun 2020 03:26:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5619720756
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Jun 2020 03:26:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="kuU0iiw9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5619720756
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D2F516E81B;
	Tue, 16 Jun 2020 03:26:10 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2070.outbound.protection.outlook.com [40.107.220.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BEA736E81B
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jun 2020 03:26:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cz8sjNWPnJdjin9REcwcaPCB6/JU1sSm0sdiDZeFpDNfTAgyzszE5YqOI6BcBvtGf/9BCpf0OzzrleuZr3WaQfSVEs29gLN0HPHVn5m3WNUVO00vChtvGWIK35NVXFGTzlcFE7ZrxvDOW+JZke/BDVEVLkL5oMKpM3DniHSK1XptGaEhdzWMA2FQxAD6g+hPUsYaUP8u6q+hY3AuwCT9VwGViym9XaRcwX0mNajrKF7bHIEKCmwDstBKSFSnQ81xrml97bCarj2OrOxw9oSKGzBFC8D+Nni2vytnibIK+Dp9Alon1m5JYP4/uLcSI20FUyjA3BWBG5SJjXOlXmDq1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wfa/CKNsgnLomZvh+C0Fq64Jk6Xo0/BT53/o+wwBtNA=;
 b=M7nnbQJMv1M+LMh6TGB6y4pLMdRWIsA9ZYZZTqzlwwCZPDz6nhLHGpZOvCXgrNar00CkTPkATg0hDcS06K1KpuLKJTwATc0KTYpoY8Q5DNfTSSETxP1Qar0Sq8wswzZQKCxqKbrpIbaFckfsRrTGQ+QTuVixbj8qf8PidOlzOCqPk8YVJT13O1FWeaJwwgWFb5sEYiXqXkw5ifIW4BHLmP6/FEoUvZWnezzLrwwxn5gyBV0t6zPu1QpUTrp/V/iaVE3uDUclV3s2FKBuBnOCmhb8JHJxPVmaAxhk+blPSMIXPG5CTwUTh8VYKljpWoe2v4a0YOiSL08Ubz77h8e9Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wfa/CKNsgnLomZvh+C0Fq64Jk6Xo0/BT53/o+wwBtNA=;
 b=kuU0iiw9lfr8qWd/t0BglNS+RM0JA+335DrGmvhfVN0bnlVWZxqqeiTSdXOUg6RKrv+qlLHESFwz5zD/qIRkULng9U5g+C/xn4P+RyGb57Bbs7nFEqMEr9sD1aI4bPoHPhcuNJaoWdgxxjmuVLNJYK7bT6aVTpiThH5lRTnlYKs=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB4435.namprd12.prod.outlook.com (2603:10b6:5:2a6::23) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3088.18; Tue, 16 Jun 2020 03:26:08 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f%3]) with mapi id 15.20.3088.029; Tue, 16 Jun 2020
 03:26:08 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: Guo Lei <raykwok1150@163.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Fix incorrect firmware size calculation
Thread-Topic: [PATCH] drm/amdgpu: Fix incorrect firmware size calculation
Thread-Index: AQHWQuayhtZQLgesdk2R1XNx60aSq6jaldwg
Date: Tue, 16 Jun 2020 03:26:07 +0000
Message-ID: <DM6PR12MB2619E7D9CA062AC4A696A363E49D0@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <611402e8.64f3.172b6d3a40c.Coremail.raykwok1150@163.com>
In-Reply-To: <611402e8.64f3.172b6d3a40c.Coremail.raykwok1150@163.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=634a53f4-f49e-4599-84ce-0000d3542e1d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-06-16T03:25:50Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: 163.com; dkim=none (message not signed)
 header.d=none;163.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ade91690-0b86-499f-842f-08d811a50272
x-ms-traffictypediagnostic: DM6PR12MB4435:
x-microsoft-antispam-prvs: <DM6PR12MB4435F430B79CA85DA2EB89A1E49D0@DM6PR12MB4435.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 04362AC73B
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wFOpMvtl5bo8Cb/wyyalb352N7Bbnz22v2koIqxE8DUDBG/55Mva0fTUzjsh201BXYPr7iA6xBYIk2/JzHKDS+H9zJQKXU5wSEgqDKuotM5rPzxPCmYhj/xX+9o241CSjz37Bhoko6u1tmE+nTnwVe16nVZ5CRNxM2EpQCvpz23eqiAp0DdqoTfi2IsGvp7phjC4dP7yZu+o7st+rNzEpUwNDpgS1Jzh87C636OVss1282jECVuYdL/5BCaJxFAa6SBLK6cYHlRXmVxIFEvuE3tGAYaa2+HMwptGsGba02dzz8tqNP6X8g8YwBKKhPmw
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(366004)(396003)(376002)(346002)(136003)(8676002)(83380400001)(478600001)(110136005)(52536014)(5660300002)(71200400001)(8936002)(33656002)(186003)(26005)(6506007)(53546011)(2906002)(316002)(66476007)(66556008)(76116006)(66946007)(66446008)(64756008)(55016002)(86362001)(7696005)(9686003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: BkdXFVFK7+Wzj59WJTBAGH2uGce32dMZZWRxRVabwtmxLMjPTpmpYPiT+1I7VtXgbxBXqe8cCcnia692zEzy1GHXj+Pb20uOTUDeK7fZ84ps8L3pGVA4rD5S4x8YjWCxrwCeUeSOUlYyH/DTK2++Jmif6qh1Ij/A98r4k51rnnxb0Cw/Twvb1VrvYzTIIrLSbtX3mGWUU0kwuDqDmMtHWu+pVAhoFI+pLBs9rtYE/0FAOURtOFcYUK3cACMV56R5nAI8tOe0+XUr7MCWO1Icfvnzz1PCjfFdTvFTfXqyJ7DDE9H9XP/2lViO1Gtb7k33U3NTMk0EshWsCK4vS02zy2nFqUf56ce7AeUuLyUQbJD/w67NLe6ZInOSeMFnbHDC2B7QA1+n92AbTOu0GEVXcL7PoihFv1rcmapoxVsNTqV3nzcOQoTZoEoBCM/tOAnsSRt8geMl7MsCJV2PvyG6VjZr25puSHqLg2HvuT3wrSxBq2Ea2lXtMELElCkxB2K7
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ade91690-0b86-499f-842f-08d811a50272
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2020 03:26:07.9981 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vkQjshm7ko/8MzG4C1AveYeTeD8HPCpQPwydDNFlBBMlaT5yZ6X2URpot1nbfmQG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4435
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
Content-Type: multipart/mixed; boundary="===============1290638362=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1290638362==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM6PR12MB2619E7D9CA062AC4A696A363E49D0DM6PR12MB2619namp_"

--_000_DM6PR12MB2619E7D9CA062AC4A696A363E49D0DM6PR12MB2619namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Acked-by: Evan Quan <evan.quan@amd.com>

From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Guo Lei
Sent: Monday, June 15, 2020 3:14 PM
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: Fix incorrect firmware size calculation


From 014162f69b909a59c241e7f73c3630d1da34696c Mon Sep 17 00:00:00 2001

From: Lei Guo <raykwok1150@163.com<mailto:raykwok1150@163.com>>

Date: Mon, 15 Jun 2020 13:54:26 +0800

Subject: [PATCH] drm/amdgpu: Fix incorrect firmware size calculation



[WHY]

The memcpy() function copies n bytes from memory area src to memory area

dest. So specify the firmware size in bytes.



[How]

Correct the calculation.



Signed-off-by: Lei Guo <raykwok1150@163.com<mailto:raykwok1150@163.com>>

Reviewed-by: Junwei Zhang <zjunweihit@163.com<mailto:zjunweihit@163.com>>

---

 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 2 +-

 1 file changed, 1 insertion(+), 1 deletion(-)



diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/am=
dgpu/gfx_v9_0.c

index 6b94587df407..c3e59b765268 100644

--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c

+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c

@@ -1960,7 +1960,7 @@ static int gfx_v9_0_mec_init(struct amdgpu_device *ad=
ev)

          fw_data =3D (const __le32 *)

                      (adev->gfx.mec_fw->data +

                      le32_to_cpu(mec_hdr->header.ucode_array_offset_bytes)=
);

-         fw_size =3D le32_to_cpu(mec_hdr->header.ucode_size_bytes) / 4;

+        fw_size =3D le32_to_cpu(mec_hdr->header.ucode_size_bytes);



          r =3D amdgpu_bo_create_reserved(adev, mec_hdr->header.ucode_size_=
bytes,

                                                    PAGE_SIZE, AMDGPU_GEM_D=
OMAIN_GTT,

--

2.17.1





--_000_DM6PR12MB2619E7D9CA062AC4A696A363E49D0DM6PR12MB2619namp_
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
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
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
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:SimSun;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
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
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72">
<p style=3D"font-family:Arial;font-size:10pt;color:#0078D7;margin:15pt;" al=
ign=3D"Left">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">Acked-by: Evan Quan &lt;evan.quan@amd.com&gt;<o:p><=
/o:p></span></p>
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
<b>On Behalf Of </b>Guo Lei<br>
<b>Sent:</b> Monday, June 15, 2020 3:14 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org<br>
<b>Subject:</b> [PATCH] drm/amdgpu: Fix incorrect firmware size calculation=
<o:p></o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<p style=3D"margin:0in;margin-bottom:.0001pt"><span style=3D"font-size:10.5=
pt;font-family:&quot;Arial&quot;,sans-serif;color:black">From 014162f69b909=
a59c241e7f73c3630d1da34696c Mon Sep 17 00:00:00 2001<o:p></o:p></span></p>
<p style=3D"margin:0in;margin-bottom:.0001pt"><span style=3D"font-size:10.5=
pt;font-family:&quot;Arial&quot;,sans-serif;color:black">From: Lei Guo &lt;=
<a href=3D"mailto:raykwok1150@163.com">raykwok1150@163.com</a>&gt;<o:p></o:=
p></span></p>
<p style=3D"margin:0in;margin-bottom:.0001pt"><span style=3D"font-size:10.5=
pt;font-family:&quot;Arial&quot;,sans-serif;color:black">Date: Mon, 15 Jun =
2020 13:54:26 &#43;0800<o:p></o:p></span></p>
<p style=3D"margin:0in;margin-bottom:.0001pt"><span style=3D"font-size:10.5=
pt;font-family:&quot;Arial&quot;,sans-serif;color:black">Subject: [PATCH] d=
rm/amdgpu: Fix incorrect firmware size calculation<o:p></o:p></span></p>
<p style=3D"margin:0in;margin-bottom:.0001pt"><span style=3D"font-size:10.5=
pt;font-family:&quot;Arial&quot;,sans-serif;color:black"><o:p>&nbsp;</o:p><=
/span></p>
<p style=3D"margin:0in;margin-bottom:.0001pt"><span style=3D"font-size:10.5=
pt;font-family:&quot;Arial&quot;,sans-serif;color:black">[WHY]<o:p></o:p></=
span></p>
<p style=3D"margin:0in;margin-bottom:.0001pt"><span style=3D"font-size:10.5=
pt;font-family:&quot;Arial&quot;,sans-serif;color:black">The memcpy() funct=
ion copies n bytes from memory area src to memory area<o:p></o:p></span></p=
>
<p style=3D"margin:0in;margin-bottom:.0001pt"><span style=3D"font-size:10.5=
pt;font-family:&quot;Arial&quot;,sans-serif;color:black">dest. So specify t=
he firmware size in bytes.<o:p></o:p></span></p>
<p style=3D"margin:0in;margin-bottom:.0001pt"><span style=3D"font-size:10.5=
pt;font-family:&quot;Arial&quot;,sans-serif;color:black"><o:p>&nbsp;</o:p><=
/span></p>
<p style=3D"margin:0in;margin-bottom:.0001pt"><span style=3D"font-size:10.5=
pt;font-family:&quot;Arial&quot;,sans-serif;color:black">[How]<o:p></o:p></=
span></p>
<p style=3D"margin:0in;margin-bottom:.0001pt"><span style=3D"font-size:10.5=
pt;font-family:&quot;Arial&quot;,sans-serif;color:black">Correct the calcul=
ation.<o:p></o:p></span></p>
<p style=3D"margin:0in;margin-bottom:.0001pt"><span style=3D"font-size:10.5=
pt;font-family:&quot;Arial&quot;,sans-serif;color:black"><o:p>&nbsp;</o:p><=
/span></p>
<p style=3D"margin:0in;margin-bottom:.0001pt"><span style=3D"font-size:10.5=
pt;font-family:&quot;Arial&quot;,sans-serif;color:black">Signed-off-by: Lei=
 Guo &lt;<a href=3D"mailto:raykwok1150@163.com">raykwok1150@163.com</a>&gt;=
<o:p></o:p></span></p>
<p style=3D"margin:0in;margin-bottom:.0001pt"><span style=3D"font-size:10.5=
pt;font-family:&quot;Arial&quot;,sans-serif;color:black">Reviewed-by: Junwe=
i Zhang &lt;<a href=3D"mailto:zjunweihit@163.com">zjunweihit@163.com</a>&gt=
;<o:p></o:p></span></p>
<p style=3D"margin:0in;margin-bottom:.0001pt"><span style=3D"font-size:10.5=
pt;font-family:&quot;Arial&quot;,sans-serif;color:black">---<o:p></o:p></sp=
an></p>
<p style=3D"margin:0in;margin-bottom:.0001pt"><span style=3D"font-size:10.5=
pt;font-family:&quot;Arial&quot;,sans-serif;color:black">&nbsp;drivers/gpu/=
drm/amd/amdgpu/gfx_v9_0.c | 2 &#43;-<o:p></o:p></span></p>
<p style=3D"margin:0in;margin-bottom:.0001pt"><span style=3D"font-size:10.5=
pt;font-family:&quot;Arial&quot;,sans-serif;color:black">&nbsp;1 file chang=
ed, 1 insertion(&#43;), 1 deletion(-)<o:p></o:p></span></p>
<p style=3D"margin:0in;margin-bottom:.0001pt"><span style=3D"font-size:10.5=
pt;font-family:&quot;Arial&quot;,sans-serif;color:black"><o:p>&nbsp;</o:p><=
/span></p>
<p style=3D"margin:0in;margin-bottom:.0001pt"><span style=3D"font-size:10.5=
pt;font-family:&quot;Arial&quot;,sans-serif;color:black">diff --git a/drive=
rs/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c<o:=
p></o:p></span></p>
<p style=3D"margin:0in;margin-bottom:.0001pt"><span style=3D"font-size:10.5=
pt;font-family:&quot;Arial&quot;,sans-serif;color:black">index 6b94587df407=
..c3e59b765268 100644<o:p></o:p></span></p>
<p style=3D"margin:0in;margin-bottom:.0001pt"><span style=3D"font-size:10.5=
pt;font-family:&quot;Arial&quot;,sans-serif;color:black">--- a/drivers/gpu/=
drm/amd/amdgpu/gfx_v9_0.c<o:p></o:p></span></p>
<p style=3D"margin:0in;margin-bottom:.0001pt"><span style=3D"font-size:10.5=
pt;font-family:&quot;Arial&quot;,sans-serif;color:black">&#43;&#43;&#43; b/=
drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c<o:p></o:p></span></p>
<p style=3D"margin:0in;margin-bottom:.0001pt"><span style=3D"font-size:10.5=
pt;font-family:&quot;Arial&quot;,sans-serif;color:black">@@ -1960,7 &#43;19=
60,7 @@ static int gfx_v9_0_mec_init(struct amdgpu_device *adev)<o:p></o:p>=
</span></p>
<p style=3D"margin:0in;margin-bottom:.0001pt"><span style=3D"font-size:10.5=
pt;font-family:&quot;Arial&quot;,sans-serif;color:black">&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fw_data =3D (const __le32 *)<o:p></o:p=
></span></p>
<p style=3D"margin:0in;margin-bottom:.0001pt"><span style=3D"font-size:10.5=
pt;font-family:&quot;Arial&quot;,sans-serif;color:black">&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev-&gt;gfx.mec_fw-&gt;data &#43;<o:p><=
/o:p></span></p>
<p style=3D"margin:0in;margin-bottom:.0001pt"><span style=3D"font-size:10.5=
pt;font-family:&quot;Arial&quot;,sans-serif;color:black">&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; le32_to_cpu(mec_hdr-&gt;header.ucode_arra=
y_offset_bytes));<o:p></o:p></span></p>
<p style=3D"margin:0in;margin-bottom:.0001pt"><span style=3D"font-size:10.5=
pt;font-family:&quot;Arial&quot;,sans-serif;color:black">-&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fw_size =3D le32_to_cpu(mec_hdr-&gt;header.=
ucode_size_bytes) / 4;<o:p></o:p></span></p>
<p style=3D"margin:0in;margin-bottom:.0001pt"><span style=3D"font-size:10.5=
pt;font-family:&quot;Arial&quot;,sans-serif;color:black">&#43;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fw_size =3D le32_to_cpu(mec_hdr-&gt;header.uc=
ode_size_bytes);<o:p></o:p></span></p>
<p style=3D"margin:0in;margin-bottom:.0001pt"><span style=3D"font-size:10.5=
pt;font-family:&quot;Arial&quot;,sans-serif;color:black">&nbsp;<o:p></o:p><=
/span></p>
<p style=3D"margin:0in;margin-bottom:.0001pt"><span style=3D"font-size:10.5=
pt;font-family:&quot;Arial&quot;,sans-serif;color:black">&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_bo_create_reserved(adev, =
mec_hdr-&gt;header.ucode_size_bytes,<o:p></o:p></span></p>
<p style=3D"margin:0in;margin-bottom:.0001pt"><span style=3D"font-size:10.5=
pt;font-family:&quot;Arial&quot;,sans-serif;color:black">&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; &nbsp; &nbsp; PAGE_SIZE, AMDGPU_GEM_DOMA=
IN_GTT,<o:p></o:p></span></p>
<p style=3D"margin:0in;margin-bottom:.0001pt"><span style=3D"font-size:10.5=
pt;font-family:&quot;Arial&quot;,sans-serif;color:black">--&nbsp;<o:p></o:p=
></span></p>
<p style=3D"margin:0in;margin-bottom:.0001pt"><span style=3D"font-size:10.5=
pt;font-family:&quot;Arial&quot;,sans-serif;color:black">2.17.1<o:p></o:p><=
/span></p>
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

--_000_DM6PR12MB2619E7D9CA062AC4A696A363E49D0DM6PR12MB2619namp_--

--===============1290638362==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1290638362==--
