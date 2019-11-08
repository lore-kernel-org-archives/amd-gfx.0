Return-Path: <SRS0=5//3=ZA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74CFAFC6196
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Nov 2019 22:01:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D1F820679
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Nov 2019 22:01:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D1F820679
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 12D566FA97;
	Fri,  8 Nov 2019 22:01:47 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770078.outbound.protection.outlook.com [40.107.77.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 644CC6FA97
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Nov 2019 22:01:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l9J+wp9d8EX0rDdGztMy647P8eKICedVQniek4rr9N9nK/ahlIc1vhbprL9TXd6Wp6NK5LrMfn7CCwTxY3tRaPlcfyMCm2B0IaA3n/PwRj6kT1ab/vMSTMaQadGpOIbtDmcMIJ5LP3pLsEUdzEezPkpfSwXlVlQIDX3bBLT/lylnj2XMmpQw2EblvEVbuowshfNpz7pFFrcghexjk+4iEUUQOkWFAZG0vXOqZffwIaa8Psi79qzNmhdP5GGywF4k4Ij0WdW8PumLp3fGUx3GsCHh36Ij7Ob+bxFg4gFmAxua34dwSH34IJpa7IhGdqAhIJ73ZXFxoAfUem4bPxk52w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mtyDP9hKXzOHnKPEsfhCpqDIEWJ8eVmqtLMvpmMM+f8=;
 b=mEv/Vb9hybsCtgURF758YQ3q1yTBZi++t4Hbw0hvcXnmd81dHhuXnqoNAi0iZu2TZONqyPAgwRCD9vnWvQlGOcAUaOrxpqSGwrF5WSDPLGHVTF972ZEgnZFh9ZYoaf8L9j1bA/sbSZBGZsYMtWDb7BizO7tkGbbw/cGzwjvEMDmMSJnZGOvd8r254L5bal6vBOqNTpYHPN2whE18DRgHYbDWQ86AHbhTWgjYb9bZY/qSmvgiR78xeyp8I2uFR65Ig1IG66BvDiQAO4c9krgpiAGUc0BfXW1Krv6CsHW3/u38BvRa8jkcolHzuM2BG82Afad5CU9hid/Qzkd6yzFG4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM5PR12MB1820.namprd12.prod.outlook.com (10.175.88.143) by
 DM5PR12MB2374.namprd12.prod.outlook.com (52.132.141.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.20; Fri, 8 Nov 2019 22:01:37 +0000
Received: from DM5PR12MB1820.namprd12.prod.outlook.com
 ([fe80::a0bb:dcbd:9ae:7807]) by DM5PR12MB1820.namprd12.prod.outlook.com
 ([fe80::a0bb:dcbd:9ae:7807%5]) with mapi id 15.20.2430.020; Fri, 8 Nov 2019
 22:01:27 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Lakha, Bhawanpreet" <Bhawanpreet.Lakha@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amd/display: Load TA firmware for navi10/12/14
Thread-Topic: [PATCH] drm/amd/display: Load TA firmware for navi10/12/14
Thread-Index: AQHVln+GUIdZboeXIEOcfDvJhQhcqqeB0wfR
Date: Fri, 8 Nov 2019 22:01:26 +0000
Message-ID:
 <DM5PR12MB1820C10A42B4FFC83A093710F77B0@DM5PR12MB1820.namprd12.prod.outlook.com>
References: <20191108215721.13316-1-Bhawanpreet.Lakha@amd.com>
In-Reply-To: <20191108215721.13316-1-Bhawanpreet.Lakha@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [71.219.59.120]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 15c8829b-0bd8-4f6b-8523-08d764973406
x-ms-traffictypediagnostic: DM5PR12MB2374:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB2374935BAD6583889A662FD4F77B0@DM5PR12MB2374.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:517;
x-forefront-prvs: 0215D7173F
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(376002)(136003)(39860400002)(346002)(396003)(199004)(189003)(33656002)(55016002)(8936002)(316002)(2906002)(105004)(53546011)(66066001)(74316002)(7696005)(486006)(476003)(71200400001)(19627405001)(52536014)(6506007)(2501003)(236005)(54896002)(186003)(71190400001)(76176011)(6306002)(5660300002)(6246003)(229853002)(966005)(6436002)(3846002)(14444005)(7736002)(606006)(86362001)(64756008)(11346002)(66476007)(66556008)(9686003)(66946007)(76116006)(14454004)(25786009)(66446008)(81166006)(26005)(446003)(110136005)(256004)(6116002)(102836004)(81156014)(478600001)(99286004)(8676002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB2374;
 H:DM5PR12MB1820.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Lu1c8naInvY7BLqt3aRg6Owul9ZezN8VLyFAqYG/ARYkehIAQSJqwnUg4iPizP67fKwSuofKp1GL4QRdgBkZQCapjiQf2r0U8UVVtwfGPpQDXBKLkTry85QsbsjzkJFeyUdKNKi/pr0lXuqJlXKdvUzgOFMETmSnw3xb2xE+u/mZZIj7k0H6p2R+ZHQsmHMkph/2+6jmTQ+5xXukwnIMfvUJdZtzOIKlPMpvAjOCcVGMUVyjdEL47TTxr4yOXp1Oy9I+f6e21F314PSyEc/YlQAu0Spo0CX/Twlxqubv7kTdD2au8e1oahhdCBXkts3Ek3bNrRUk41Qw2fPk3op0fea6eZ4o+4SkS74hsBHpOZEpRxCmvCUliCS5sp4F641LN40dWBCzA2cE4vIne0M6Y43yTtpPKECUkFBYj18e3Ti5sM+Uj7UEOobin9o2TxOgp3MY1CFpu7GMLGtuX7HXfY/EcKELXusYmmsdpuF9j5Q=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15c8829b-0bd8-4f6b-8523-08d764973406
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2019 22:01:27.0207 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YePZVJo6Wboa20E/6/YJuK5fJypDVG5hqy+2DhfV6NIzYsidCCRql86gmzvOw0dTKJO5lNxfPS4wLpET8B0EsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2374
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mtyDP9hKXzOHnKPEsfhCpqDIEWJ8eVmqtLMvpmMM+f8=;
 b=JZur/BmcgI0eY6+oG/lqt+31dMkf69ReyVEqS69nMuN47AdFwLLwMJ2AId6pPhIghMcaNZ6yweWD/82pHN7Ld/8vW+y/OvhOPEBcFsZCc/EK10zjmQFoGMQKDwafPrFMlm2ZfKC9mfzqPQ160rWuuWw8hf2UWrj6fWH/K0d83Gs=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Deucher@amd.com; 
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============2022114789=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191108220126.4fSCEHaxhcNmeq7HltRte421_ro4Ua7eG9mQVkOwOVU@z>

--===============2022114789==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM5PR12MB1820C10A42B4FFC83A093710F77B0DM5PR12MB1820namp_"

--_000_DM5PR12MB1820C10A42B4FFC83A093710F77B0DM5PR12MB1820namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Acked-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Bhawanpr=
eet Lakha <Bhawanpreet.Lakha@amd.com>
Sent: Friday, November 8, 2019 4:57 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Lakha, Bhawanpreet <Bhawanpreet.Lakha@amd.com>
Subject: [PATCH] drm/amd/display: Load TA firmware for navi10/12/14

load the ta firmware for navi10/12/14.
This is already being done for raven/picasso and
is needed for supporting hdcp on navi

Signed-off-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/psp_v11_0.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/psp_v11_0.c
index ffeaa2f5588d..daf11be5416f 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
@@ -186,6 +186,31 @@ static int psp_v11_0_init_microcode(struct psp_context=
 *psp)
         case CHIP_NAVI10:
         case CHIP_NAVI14:
         case CHIP_NAVI12:
+               snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_ta.bin", chip=
_name);
+               err =3D request_firmware(&adev->psp.ta_fw, fw_name, adev->d=
ev);
+               if (err) {
+                       release_firmware(adev->psp.ta_fw);
+                       adev->psp.ta_fw =3D NULL;
+                       dev_info(adev->dev,
+                                "psp v11.0: Failed to load firmware \"%s\"=
\n", fw_name);
+               } else {
+                       err =3D amdgpu_ucode_validate(adev->psp.ta_fw);
+                       if (err)
+                               goto out2;
+
+                       ta_hdr =3D (const struct ta_firmware_header_v1_0 *)=
adev->psp.ta_fw->data;
+                       adev->psp.ta_hdcp_ucode_version =3D le32_to_cpu(ta_=
hdr->ta_hdcp_ucode_version);
+                       adev->psp.ta_hdcp_ucode_size =3D le32_to_cpu(ta_hdr=
->ta_hdcp_size_bytes);
+                       adev->psp.ta_hdcp_start_addr =3D (uint8_t *)ta_hdr =
+
+                               le32_to_cpu(ta_hdr->header.ucode_array_offs=
et_bytes);
+
+                       adev->psp.ta_fw_version =3D le32_to_cpu(ta_hdr->hea=
der.ucode_version);
+
+                       adev->psp.ta_dtm_ucode_version =3D le32_to_cpu(ta_h=
dr->ta_dtm_ucode_version);
+                       adev->psp.ta_dtm_ucode_size =3D le32_to_cpu(ta_hdr-=
>ta_dtm_size_bytes);
+                       adev->psp.ta_dtm_start_addr =3D (uint8_t *)adev->ps=
p.ta_hdcp_start_addr +
+                               le32_to_cpu(ta_hdr->ta_dtm_offset_bytes);
+               }
                 break;
         default:
                 BUG();
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_DM5PR12MB1820C10A42B4FFC83A093710F77B0DM5PR12MB1820namp_
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
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Acked-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Bhawanpreet Lakha &lt;Bhawanp=
reet.Lakha@amd.com&gt;<br>
<b>Sent:</b> Friday, November 8, 2019 4:57 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Lakha, Bhawanpreet &lt;Bhawanpreet.Lakha@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amd/display: Load TA firmware for navi10/12/14<=
/font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">load the ta firmware for navi10/12/14.<br>
This is already being done for raven/picasso and<br>
is needed for supporting hdcp on navi<br>
<br>
Signed-off-by: Bhawanpreet Lakha &lt;Bhawanpreet.Lakha@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/psp_v11_0.c | 25 &#43;&#43;&#43;&#43;&#43;=
&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;=
&#43;&#43;&#43;&#43;&#43;<br>
&nbsp;1 file changed, 25 insertions(&#43;)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/psp_v11_0.c<br>
index ffeaa2f5588d..daf11be5416f 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c<br>
@@ -186,6 &#43;186,31 @@ static int psp_v11_0_init_microcode(struct psp_con=
text *psp)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_NAVI10:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_NAVI14:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_NAVI12:<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; snprintf(fw_name, sizeof(fw_name), &quot;amdgpu/%s_ta.bin&qu=
ot;, chip_name);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; err =3D request_firmware(&amp;adev-&gt;psp.ta_fw, fw_name, a=
dev-&gt;dev);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if (err) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; release_firm=
ware(adev-&gt;psp.ta_fw);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;psp=
.ta_fw =3D NULL;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_info(ade=
v-&gt;dev,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;psp v11.0: Failed to load f=
irmware \&quot;%s\&quot;\n&quot;, fw_name);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; } else {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; err =3D amdg=
pu_ucode_validate(adev-&gt;psp.ta_fw);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (err)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto out2;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ta_hdr =3D (=
const struct ta_firmware_header_v1_0 *)adev-&gt;psp.ta_fw-&gt;data;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;psp=
.ta_hdcp_ucode_version =3D le32_to_cpu(ta_hdr-&gt;ta_hdcp_ucode_version);<b=
r>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;psp=
.ta_hdcp_ucode_size =3D le32_to_cpu(ta_hdr-&gt;ta_hdcp_size_bytes);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;psp=
.ta_hdcp_start_addr =3D (uint8_t *)ta_hdr &#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; le32_to_cpu(ta_hdr-&gt;header.ucode_arr=
ay_offset_bytes);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;psp=
.ta_fw_version =3D le32_to_cpu(ta_hdr-&gt;header.ucode_version);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;psp=
.ta_dtm_ucode_version =3D le32_to_cpu(ta_hdr-&gt;ta_dtm_ucode_version);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;psp=
.ta_dtm_ucode_size =3D le32_to_cpu(ta_hdr-&gt;ta_dtm_size_bytes);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;psp=
.ta_dtm_start_addr =3D (uint8_t *)adev-&gt;psp.ta_hdcp_start_addr &#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; le32_to_cpu(ta_hdr-&gt;ta_dtm_offset_by=
tes);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; BUG();<br>
-- <br>
2.17.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://=
lists.freedesktop.org/mailman/listinfo/amd-gfx</a></div>
</span></font></div>
</body>
</html>

--_000_DM5PR12MB1820C10A42B4FFC83A093710F77B0DM5PR12MB1820namp_--

--===============2022114789==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============2022114789==--
