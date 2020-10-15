Return-Path: <SRS0=r20P=DW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04750C433DF
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Oct 2020 18:23:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6256820760
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Oct 2020 18:23:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="cQF5Pgfu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6256820760
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 959D26E077;
	Thu, 15 Oct 2020 18:23:53 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2062.outbound.protection.outlook.com [40.107.220.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E6BAF6E077
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Oct 2020 18:23:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MSrE1z0yORNxAuQ7s4SRw7EeoHxpoPwNg/3pk6KC4kKqgjiSkoCxKrbzK96NQKeDNz5+eBSnPyyRe+W7I2+SjNbOho3XM9NCfXuUyeMPz+TQbpeba0Vw19gD5YoFD2awRp52bqvdOUpbDdcZ0CNBYjEkIuVDpVhaocbwlyJVla5S7daDXvhScab1IdfugR03GPP+nzhHFwdlDqf06bM+l/uqE4/Pb9A9CzjmOmipefnNxX1Mrl0AWbXBrM7rQRUZCTgOC9fcu+kY2cRcbVG90Q9EJqWRt0GAKkS9EU3+kDE9slNP18NYwzHgfwv+fxUfx5Xc1QV8UvWuK67ubq2e8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q7QDjc0o5V7o2JZWqG0CP/I+59Ib/WWqaRm3tzrTuVE=;
 b=Zo13TsXzmMyheqqPeSymL0y24CrxktJEITr+S3zKjzIYz/Lyr9Q6ZUqkDX1jMT2DVaUE9CnjyJBWUszAgdbK9tD0guec0RHywPT7Tjxw4nkEi1vkvdPmPOFmr8NBD+3aKw3YjqGB5/tiJVer8c/pT3KZqmlYpOlD8BQCQswcBGUpawmswvRdhEazqjGN3aJljs2hMDDI4y6LPjXrEWKsvw34KzoJ2b8fLxE6DzMxbv+0ruL/VO1T5H1hcvRGmAKQM/CsCYC6k/wsPCDxKHf/OxCMHqXHkVU84m+xuXbgzdSnQTnkyb1TAc8ZP8NpW0rVu3Tb/QTEm2BjO68RshGK5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q7QDjc0o5V7o2JZWqG0CP/I+59Ib/WWqaRm3tzrTuVE=;
 b=cQF5Pgfu81MbPb3zzr/6xFNXoNJZBhC+aZx1FcPihTm9D2fmvUr+dmUMed/PN870OOjUQHNd/8SjgXUotyrtvQwZ7z0Pv1RIMF/0F7DhjuQOLm7zFkalY6hJ40r0sI/e9pHbSdLR9V8YVAE5bGURwU7ienkz0CAm9UGARiSkqFc=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4014.namprd12.prod.outlook.com (2603:10b6:208:16d::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.22; Thu, 15 Oct
 2020 18:23:49 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::99dd:ff77:1ffd:d96a]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::99dd:ff77:1ffd:d96a%3]) with mapi id 15.20.3477.021; Thu, 15 Oct 2020
 18:23:49 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Lakha, Bhawanpreet" <Bhawanpreet.Lakha@amd.com>, "Kazlauskas, Nicholas"
 <Nicholas.Kazlauskas@amd.com>
Subject: Re: [PATCH 2/2] drm/amd/display: Fix DCN302 makefile
Thread-Topic: [PATCH 2/2] drm/amd/display: Fix DCN302 makefile
Thread-Index: AQHWox/4Lgm+J8H7YUi3avhjBlLxBamY+j0z
Date: Thu, 15 Oct 2020 18:23:49 +0000
Message-ID: <MN2PR12MB4488E6ED4B4D3A8C8BF09DDAF7020@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20201015182004.4079457-1-Bhawanpreet.Lakha@amd.com>,
 <20201015182004.4079457-2-Bhawanpreet.Lakha@amd.com>
In-Reply-To: <20201015182004.4079457-2-Bhawanpreet.Lakha@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=True;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-10-15T18:23:48.877Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=AMD
 Public; MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [71.219.66.138]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 01baf9ae-018a-48c5-7ae6-08d871377673
x-ms-traffictypediagnostic: MN2PR12MB4014:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB401418C19E120D7E6DC1FAC2F7020@MN2PR12MB4014.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:198;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oZu1cYcTVbxNZL4qVaPY7tlXBGALZEL7FogSWZxCvrfKa+SWi+G0Iz+9aJBpOfs04CaTpin2sifU6SFutHTgKQ+iOIXhbOPdLdwe307a+L/7AeoU6K2QGw7qEuwf+8HZNJIzrYKXUWEjcCqIpz6JLPoM4DOp9RYZeyQUv8rRnyMgaMAYcnlN91VwFVz030a+dZouAxoo3InLuUdi98vhxWmL2JcfZ5uxNWAv9h47J7q+w10SxFKGaIg90Iam281BXhCMNlYF+Lz/owwFUdzTb1KkoyumD2ZH7t0D1QIhY1wVeFtFJw2zdf6zHw1jXb79bKFpkKa9G76cr31EJM1R4w==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(346002)(136003)(376002)(39860400002)(66946007)(33656002)(8676002)(316002)(54906003)(110136005)(7696005)(5660300002)(52536014)(26005)(4326008)(6506007)(53546011)(55016002)(86362001)(478600001)(66556008)(66476007)(64756008)(2906002)(76116006)(71200400001)(66446008)(6636002)(9686003)(186003)(8936002)(19627405001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: MGST1xKOnYdBcxwuqMg600UlsFIrj+IQOYx3fWdi2WaePU2R5zDjUA3N1KDSObrfQEGy6wS+140N0qwqVhek0itOta5iQFZu6/Ejzr90AVfLphbMEMLb9hlo8adMjparkzExcTW8TaNEoFCqi6CwG4qBoOi950gv3GPFmaDyNhlq8B29Rx6HygpYjcqVC2qN5+90QxvWbcGbGX8o+U6/7GL2hTiFisMVdONt5Mth/FCiv/+gvErh42E7xozfAKzgDgXHa2sUOdczOyDDWyfpYaUVvBbaw8e/1Sz7iH1mk5TWB9isFf1uGxBlx4QIWcETz4IxrtTksdhDrl/lN4tIKy3kUr/jkJnhFt9+z+SKzDtHNngndusdtSTF/6D37ynKQrsse5sjvp1zcNLVlDHNWoOno9I1M3SOgyNk38irKzWhYXgwvLmThNKPGknKJ/yROY3W/jgwypHnPMg96livyLLHk2RmWNPxOfEjqhwpNsQU1DUZ0N5bbyfTfRe5bnYzioZ906p19SjH+kWw8todxE3EWJtN3yVGjEeGn25BHtCuRkyE1cOwY6vOOsLQC9gNEGk05752O447AJqLSfUpILiXrFOQDiOE903+sEqFbSnJbnAk1nfI3vHNyXVCT82p1Fw6ebHtEO9eR0PCNedxZA==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01baf9ae-018a-48c5-7ae6-08d871377673
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2020 18:23:49.5572 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 22PtKFCz64POb69vPFNUXG8pp0GrGaxhwMJ6PTVuX3tuvqI8cmIvWKe+RevYoXdQo7FUbhb+0qX7Cxi4M0UfYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4014
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
Cc: "rodrigo.siqOFueira@amd.com" <rodrigo.siqOFueira@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: multipart/mixed; boundary="===============0732028893=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0732028893==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB4488E6ED4B4D3A8C8BF09DDAF7020MN2PR12MB4488namp_"

--_000_MN2PR12MB4488E6ED4B4D3A8C8BF09DDAF7020MN2PR12MB4488namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Sent: Thursday, October 15, 2020 2:20 PM
To: Kazlauskas, Nicholas <Nicholas.Kazlauskas@amd.com>; Deucher, Alexander =
<Alexander.Deucher@amd.com>
Cc: rodrigo.siqOFueira@amd.com <rodrigo.siqOFueira@amd.com>; amd-gfx@lists.=
freedesktop.org <amd-gfx@lists.freedesktop.org>; Lakha, Bhawanpreet <Bhawan=
preet.Lakha@amd.com>
Subject: [PATCH 2/2] drm/amd/display: Fix DCN302 makefile

Some setups will fail to build. So copy dcn301 makefile setup
which is known to work

Signed-off-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
---
 .../gpu/drm/amd/display/dc/dcn302/Makefile    | 29 +++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn302/Makefile b/drivers/gpu/d=
rm/amd/display/dc/dcn302/Makefile
index 3ea9bff27912..36e44e1b07fa 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn302/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dcn302/Makefile
@@ -12,6 +12,35 @@

 DCN3_02 =3D dcn302_init.o dcn302_hwseq.o dcn302_resource.o

+ifdef CONFIG_X86
+CFLAGS_$(AMDDALPATH)/dc/dcn302/dcn302_resource.o :=3D -mhard-float -msse
+endif
+
+ifdef CONFIG_PPC64
+CFLAGS_$(AMDDALPATH)/dc/dcn302/dcn302_resource.o :=3D -mhard-float -maltiv=
ec
+endif
+
+ifdef CONFIG_ARM64
+CFLAGS_REMOVE_$(AMDDALPATH)/dc/dcn302/dcn302_resource.o :=3D -mgeneral-reg=
s-only
+endif
+
+ifdef CONFIG_CC_IS_GCC
+ifeq ($(call cc-ifversion, -lt, 0701, y), y)
+IS_OLD_GCC =3D 1
+endif
+endif
+
+ifdef CONFIG_X86
+ifdef IS_OLD_GCC
+# Stack alignment mismatch, proceed with caution.
+# GCC < 7.1 cannot compile code using `double` and -mpreferred-stack-bound=
ary=3D3
+# (8B stack alignment).
+CFLAGS_$(AMDDALPATH)/dc/dcn302/dcn302_resource.o +=3D -mpreferred-stack-bo=
undary=3D4
+else
+CFLAGS_$(AMDDALPATH)/dc/dcn302/dcn302_resource.o +=3D -msse2
+endif
+endif
+
 AMD_DAL_DCN3_02 =3D $(addprefix $(AMDDALPATH)/dc/dcn302/,$(DCN3_02))

 AMD_DISPLAY_FILES +=3D $(AMD_DAL_DCN3_02)
--
2.25.1


--_000_MN2PR12MB4488E6ED4B4D3A8C8BF09DDAF7020MN2PR12MB4488namp_
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
Series is:</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Reviewed-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Bhawanpreet Lakha &lt=
;Bhawanpreet.Lakha@amd.com&gt;<br>
<b>Sent:</b> Thursday, October 15, 2020 2:20 PM<br>
<b>To:</b> Kazlauskas, Nicholas &lt;Nicholas.Kazlauskas@amd.com&gt;; Deuche=
r, Alexander &lt;Alexander.Deucher@amd.com&gt;<br>
<b>Cc:</b> rodrigo.siqOFueira@amd.com &lt;rodrigo.siqOFueira@amd.com&gt;; a=
md-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&gt;; Lakha, =
Bhawanpreet &lt;Bhawanpreet.Lakha@amd.com&gt;<br>
<b>Subject:</b> [PATCH 2/2] drm/amd/display: Fix DCN302 makefile</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Some setups will fail to build. So copy dcn301 mak=
efile setup<br>
which is known to work<br>
<br>
Signed-off-by: Bhawanpreet Lakha &lt;Bhawanpreet.Lakha@amd.com&gt;<br>
---<br>
&nbsp;.../gpu/drm/amd/display/dc/dcn302/Makefile&nbsp;&nbsp;&nbsp; | 29 +++=
++++++++++++++++<br>
&nbsp;1 file changed, 29 insertions(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/display/dc/dcn302/Makefile b/drivers/gpu/d=
rm/amd/display/dc/dcn302/Makefile<br>
index 3ea9bff27912..36e44e1b07fa 100644<br>
--- a/drivers/gpu/drm/amd/display/dc/dcn302/Makefile<br>
+++ b/drivers/gpu/drm/amd/display/dc/dcn302/Makefile<br>
@@ -12,6 +12,35 @@<br>
&nbsp;<br>
&nbsp;DCN3_02 =3D dcn302_init.o dcn302_hwseq.o dcn302_resource.o<br>
&nbsp;<br>
+ifdef CONFIG_X86<br>
+CFLAGS_$(AMDDALPATH)/dc/dcn302/dcn302_resource.o :=3D -mhard-float -msse<b=
r>
+endif<br>
+<br>
+ifdef CONFIG_PPC64<br>
+CFLAGS_$(AMDDALPATH)/dc/dcn302/dcn302_resource.o :=3D -mhard-float -maltiv=
ec<br>
+endif<br>
+<br>
+ifdef CONFIG_ARM64<br>
+CFLAGS_REMOVE_$(AMDDALPATH)/dc/dcn302/dcn302_resource.o :=3D -mgeneral-reg=
s-only<br>
+endif<br>
+<br>
+ifdef CONFIG_CC_IS_GCC<br>
+ifeq ($(call cc-ifversion, -lt, 0701, y), y)<br>
+IS_OLD_GCC =3D 1<br>
+endif<br>
+endif<br>
+<br>
+ifdef CONFIG_X86<br>
+ifdef IS_OLD_GCC<br>
+# Stack alignment mismatch, proceed with caution.<br>
+# GCC &lt; 7.1 cannot compile code using `double` and -mpreferred-stack-bo=
undary=3D3<br>
+# (8B stack alignment).<br>
+CFLAGS_$(AMDDALPATH)/dc/dcn302/dcn302_resource.o +=3D -mpreferred-stack-bo=
undary=3D4<br>
+else<br>
+CFLAGS_$(AMDDALPATH)/dc/dcn302/dcn302_resource.o +=3D -msse2<br>
+endif<br>
+endif<br>
+<br>
&nbsp;AMD_DAL_DCN3_02 =3D $(addprefix $(AMDDALPATH)/dc/dcn302/,$(DCN3_02))<=
br>
&nbsp;<br>
&nbsp;AMD_DISPLAY_FILES +=3D $(AMD_DAL_DCN3_02)<br>
-- <br>
2.25.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB4488E6ED4B4D3A8C8BF09DDAF7020MN2PR12MB4488namp_--

--===============0732028893==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0732028893==--
