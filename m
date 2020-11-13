Return-Path: <SRS0=j5hG=ET=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11EEEC4742C
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2020 22:33:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A73C321D7F
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2020 22:33:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="2lccmZie"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A73C321D7F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2898E6E877;
	Fri, 13 Nov 2020 22:33:22 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2057.outbound.protection.outlook.com [40.107.94.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E6C076E877
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Nov 2020 22:33:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DoljGlV2+HeZQkkdQKLIuoT8VOBKtGVBj+6W0+EOv5erPES/6hDEFHTXkW5XAbPWeGB6942s6S1C9V4B2+KEYTltTt9D+w+uyM9P+Bx+HxIJWuhVKpS6M6TQHvv+P0+Z8oPtRBoWHZFQWFg3mgacAYn4C4IAKSVFY0Bg2ujpkBiaQnDmuG+E2cxMf64pKzeAP6sZwREWKq6jOfVk9HAUFc6CwANXwjv2FN7DDqJxfvrhvySx1YIE9OH6C7WRCmbl3G/Ws7ARII/q1b3PIbPRIyXb46tRJUN2JQYoQGynin/8Kvd8Xrqwoi9/ARF8TPd7p55q1PkVdXev1I+INQ2w+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Wldw6ku01XLKNiWa1LeRp9DWAAdEWDxLRfK2ssyi6w=;
 b=AsnjFQ9JI36t95EVic91HSK/dAPeneyU3J6v/SOxuaoemAR0oW/qnQuKFpssEOJjMZxa+eFgYruV7ncqppAU14at9tD/t+YbeRRfwH+6B0sQ4cGKWncD5mN+7OyvlE6RlAQ66EG+zp9t69ostoOGAqwKnGtq+JUga4cO5KfOlaC5CSgDgXciKJigL32u5xnKUszVxwWUw6KKpWMivqyMTkfhl2ajFyv1/MP6nVUaZSujqKM5bSA4Q2ELxXS2dcSoGYKtPiNm4FyyB1FZdWXiW6kAtNwQqsAMo2/pKXnD54+mC/mg0GsFTAVEh+qGuzIoJ2SuRAnSPDg2VLqRfcVSvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Wldw6ku01XLKNiWa1LeRp9DWAAdEWDxLRfK2ssyi6w=;
 b=2lccmZiei9jFCQnGUt0Acn49vYpntS3vAfwVYvgNk2i0lz0vRElXgW7E0kTN7Jg1ff6y3jcufcr650Hyu53NfZqQDMyrKvKtckT8NgkJYzZFTwttweCdrEcBJ8k1sxzBeRfBI87/5+bqMvGPiYNyDZYK1yeXOEOqJbLUfdE29/w=
Received: from DM6PR12MB3433.namprd12.prod.outlook.com (2603:10b6:5:38::14) by
 DM6PR12MB3068.namprd12.prod.outlook.com (2603:10b6:5:3e::25) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3541.23; Fri, 13 Nov 2020 22:33:18 +0000
Received: from DM6PR12MB3433.namprd12.prod.outlook.com
 ([fe80::6009:8864:b920:1dcc]) by DM6PR12MB3433.namprd12.prod.outlook.com
 ([fe80::6009:8864:b920:1dcc%7]) with mapi id 15.20.3541.025; Fri, 13 Nov 2020
 22:33:18 +0000
From: "Jiang, Sonny" <Sonny.Jiang@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH v2] drm/amdgpu: fix SI UVD firmware validate resume fail
Thread-Topic: [PATCH v2] drm/amdgpu: fix SI UVD firmware validate resume fail
Thread-Index: AQHWttBLlQafBCfcOUGgIqe6o/uP6KnGrEuQ
Date: Fri, 13 Nov 2020 22:33:18 +0000
Message-ID: <DM6PR12MB343394680382B27D3128528AFDE60@DM6PR12MB3433.namprd12.prod.outlook.com>
References: <20201109194101.7082-1-sonny.jiang@amd.com>
In-Reply-To: <20201109194101.7082-1-sonny.jiang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-11-13T22:33:17.516Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
x-originating-ip: [67.71.194.199]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6b64b627-a258-4e31-688e-08d888241e45
x-ms-traffictypediagnostic: DM6PR12MB3068:
x-microsoft-antispam-prvs: <DM6PR12MB3068C98397AE12D3BAF9D5F3FDE60@DM6PR12MB3068.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8A59NMGYsngFi4JdrGRgTRWzMcfL5a5ZE1bswA4Pg1RPo8z/in/lKwREa308aFcAL7xs29egtznzCnJzRVTb5VkQotBuFdfGdY+tS5tMwS4CS9OmKTG660/SsNS0VcdxSs2cn0159rtQebr+jhsNW9rfc0n+OFM3VZoWytTK3WJaw5GpPexQfAdrhT5APfUBiHl6avp/lY2j5elMZ9E1N3wr6iFmqSG5bWrgWIy/SR2kfKg6uOu0T0YPq1LTUP+Xch2CWmZU8LwVm7X2hikERtxejWQ4lSMtdEKsfL6tbMAUoyjyIm0DK5L+BCCFlRlsR6l93t0C2V1BU+4lu9pirg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3433.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(136003)(39860400002)(396003)(366004)(26005)(15650500001)(66556008)(6506007)(52536014)(86362001)(53546011)(2906002)(71200400001)(7696005)(91956017)(33656002)(83380400001)(66476007)(66946007)(64756008)(76116006)(8936002)(55016002)(6916009)(66446008)(19627405001)(316002)(186003)(8676002)(478600001)(5660300002)(9686003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: y85z0GQ8qF+rQ0P7wk9x1NTxsuoUGbWTK2WEsJp4A8X9AQrrhkJq5M3sXyB5EM8+8cWa3vVF7uJNk/MaBxbGhXFcqYetD5qpkIhjyRLJpTwrBcUfb1Q+kjLtTal5MjkgrWUfl/E3wvqDNQze1lZSvEXuQgOJEZtOZ5fnKLFSAO1JNaIZsYuLHhulMg1sc7tknoDaCN7vSmFowCFtgQw10UQj8+YSLezopyfTpuwGsiYuNpauJoIIXm24dOM7IqNnSahCYVyChI7k787s+mkzj7P5vRDA7CAbllHeHPTEe20z3JUIsM8+dvd/XmhaB9hQvBH4kz3br3+zCQbo48hUx8NFOZUWVtn/+mKN7hWcKmiln14T0Ei5yh4EoEqNmzY8lMjHoYg3VJc4QcLhOCxlfXLH8K3VWP/H5+vlLzbK+0/Fu2R5Fk9jEC3VORXmSqyFeg2bQZNl1njxLQs1cirspIzrWiSJCKP0eWSwlL7k3X9oWj+0kE4OnPBM5Su/VWJUWe8rVjkeION2EefZmQaqPYPdgiM9VEG/Wo1uG43IPoZS93wBZwCR8YCLgWV2gpdiZZrrmQmrjN4vuYfiDzvRqUv0kHJ9/YZO+eQhivwUA6F5SAzcA1Dh7CMohHgjldBbUhS174/kZ2zasSl0b0hKmA==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3433.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b64b627-a258-4e31-688e-08d888241e45
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2020 22:33:18.0320 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rxoR23IQ8o42Xn5JAinE2qKpysyplft8HsHd4duiOzfuDoFOcRKvL8V/cW3UT6d29bixdyyoseunQXTZ5RIGwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3068
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
Content-Type: multipart/mixed; boundary="===============0018159072=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0018159072==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM6PR12MB343394680382B27D3128528AFDE60DM6PR12MB3433namp_"

--_000_DM6PR12MB343394680382B27D3128528AFDE60DM6PR12MB3433namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Ping.
________________________________
From: Jiang, Sonny <Sonny.Jiang@amd.com>
Sent: Monday, November 9, 2020 2:41 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Jiang, Sonny <Sonny.Jiang@amd.com>
Subject: [PATCH v2] drm/amdgpu: fix SI UVD firmware validate resume fail

The SI UVD firmware validate key is stored at the end of firmware,
which is changed during resume while playing video. So get the key
at sw_init and store it for fw validate using.

Signed-off-by: Sonny Jiang <sonny.jiang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.h |  1 +
 drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c   | 20 +++++++++++---------
 2 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_uvd.h
index 5eb63288d157..edbb8194ee81 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.h
@@ -67,6 +67,7 @@ struct amdgpu_uvd {
         unsigned                harvest_config;
         /* store image width to adjust nb memory state */
         unsigned                decode_image_width;
+       uint32_t                keyselect;
 };

 int amdgpu_uvd_sw_init(struct amdgpu_device *adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c b/drivers/gpu/drm/amd/am=
dgpu/uvd_v3_1.c
index 7cf4b11a65c5..3a5dce634cda 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
@@ -277,15 +277,8 @@ static void uvd_v3_1_mc_resume(struct amdgpu_device *a=
dev)
  */
 static int uvd_v3_1_fw_validate(struct amdgpu_device *adev)
 {
-       void *ptr;
-       uint32_t ucode_len, i;
-       uint32_t keysel;
-
-       ptr =3D adev->uvd.inst[0].cpu_addr;
-       ptr +=3D 192 + 16;
-       memcpy(&ucode_len, ptr, 4);
-       ptr +=3D ucode_len;
-       memcpy(&keysel, ptr, 4);
+       int i;
+       uint32_t keysel =3D adev->uvd.keyselect;

         WREG32(mmUVD_FW_START, keysel);

@@ -550,6 +543,8 @@ static int uvd_v3_1_sw_init(void *handle)
         struct amdgpu_ring *ring;
         struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
         int r;
+       void *ptr;
+       uint32_t ucode_len;

         /* UVD TRAP */
         r =3D amdgpu_irq_add_id(adev, AMDGPU_IRQ_CLIENTID_LEGACY, 124, &ad=
ev->uvd.inst->irq);
@@ -560,6 +555,13 @@ static int uvd_v3_1_sw_init(void *handle)
         if (r)
                 return r;

+       /* Retrieval firmware validate key */
+       ptr =3D adev->uvd.inst[0].cpu_addr;
+       ptr +=3D 192 + 16;
+       memcpy(&ucode_len, ptr, 4);
+       ptr +=3D ucode_len;
+       memcpy(&adev->uvd.keyselect, ptr, 4);
+
         ring =3D &adev->uvd.inst->ring;
         sprintf(ring->name, "uvd");
         r =3D amdgpu_ring_init(adev, ring, 512, &adev->uvd.inst->irq, 0,
--
2.25.1


--_000_DM6PR12MB343394680382B27D3128528AFDE60DM6PR12MB3433namp_
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
<p style=3D"font-family:Arial;font-size:11pt;color:#0078D7;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Ping.<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Jiang, Sonny &lt;Sonn=
y.Jiang@amd.com&gt;<br>
<b>Sent:</b> Monday, November 9, 2020 2:41 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Jiang, Sonny &lt;Sonny.Jiang@amd.com&gt;<br>
<b>Subject:</b> [PATCH v2] drm/amdgpu: fix SI UVD firmware validate resume =
fail</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">The SI UVD firmware validate key is stored at the =
end of firmware,<br>
which is changed during resume while playing video. So get the key<br>
at sw_init and store it for fw validate using.<br>
<br>
Signed-off-by: Sonny Jiang &lt;sonny.jiang@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.h |&nbsp; 1 +<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c&nbsp;&nbsp; | 20 +++++++++++---=
------<br>
&nbsp;2 files changed, 12 insertions(+), 9 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_uvd.h<br>
index 5eb63288d157..edbb8194ee81 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.h<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.h<br>
@@ -67,6 +67,7 @@ struct amdgpu_uvd {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ha=
rvest_config;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* store image width to ad=
just nb memory state */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; de=
code_image_width;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; keyselect;<br=
>
&nbsp;};<br>
&nbsp;<br>
&nbsp;int amdgpu_uvd_sw_init(struct amdgpu_device *adev);<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c b/drivers/gpu/drm/amd/am=
dgpu/uvd_v3_1.c<br>
index 7cf4b11a65c5..3a5dce634cda 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c<br>
@@ -277,15 +277,8 @@ static void uvd_v3_1_mc_resume(struct amdgpu_device *a=
dev)<br>
&nbsp; */<br>
&nbsp;static int uvd_v3_1_fw_validate(struct amdgpu_device *adev)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void *ptr;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t ucode_len, i;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t keysel;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ptr =3D adev-&gt;uvd.inst[0].cpu_addr=
;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ptr +=3D 192 + 16;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy(&amp;ucode_len, ptr, 4);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ptr +=3D ucode_len;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy(&amp;keysel, ptr, 4);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t keysel =3D adev-&gt;uvd.keys=
elect;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(mmUVD_FW_START, key=
sel);<br>
&nbsp;<br>
@@ -550,6 +543,8 @@ static int uvd_v3_1_sw_init(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ring *ring;<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D (struct amdgpu_device *)handle;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void *ptr;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t ucode_len;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* UVD TRAP */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_irq_add_id(ad=
ev, AMDGPU_IRQ_CLIENTID_LEGACY, 124, &amp;adev-&gt;uvd.inst-&gt;irq);<br>
@@ -560,6 +555,13 @@ static int uvd_v3_1_sw_init(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return r;<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Retrieval firmware validate key */=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ptr =3D adev-&gt;uvd.inst[0].cpu_addr=
;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ptr +=3D 192 + 16;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy(&amp;ucode_len, ptr, 4);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ptr +=3D ucode_len;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy(&amp;adev-&gt;uvd.keyselect, p=
tr, 4);<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ring =3D &amp;adev-&gt;uvd=
.inst-&gt;ring;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sprintf(ring-&gt;name, &qu=
ot;uvd&quot;);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_ring_init(ade=
v, ring, 512, &amp;adev-&gt;uvd.inst-&gt;irq, 0,<br>
-- <br>
2.25.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_DM6PR12MB343394680382B27D3128528AFDE60DM6PR12MB3433namp_--

--===============0018159072==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0018159072==--
