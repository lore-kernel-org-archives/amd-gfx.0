Return-Path: <SRS0=Rlnb=AT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59071C433DF
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jul 2020 19:05:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 319BD20672
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jul 2020 19:05:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="0pqCGHKT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 319BD20672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CFA4A6E30D;
	Wed,  8 Jul 2020 19:05:18 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2045.outbound.protection.outlook.com [40.107.237.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D732A6E30D
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Jul 2020 19:05:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HpmilbMYLt0jouqJO/q5a47+jxwF2hC3rJ6TS06wGMtFffIngtrLQgg02S+2PClxlsGcOoT2r2hoKtEjlyhpaxXsiGTGUofXXCv5JedXaRFD0I61DMwR3QLQckB81fXimyl1D0VgLsdmD9Z7BEvFFp84yFGu2QAQ7cpLhUQELQH5g7T8ePymeL0MqceMO5dE/CLpyJPHWJRikZw05witI3UKE+8Sng8lGHC/8mUzXf8HINYaosREDZji4okURTIXuZdlcU5yvw9u9A4ED7LJx9kdda2tQtTUWynatgysEgiak5FM/jjmqxTGCtZY0hNRAtOEdbyoFg0ec3ROyOfGDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V9VTXqKrcO7jB3eMOFE1XzKBnbgXZEsEU6KIl6QXl6Q=;
 b=dqVqMErcdc/xJ3aQN6/bA9qa6D22fX8AcZPqk/scZU7a7rbEN//ix5fyQqaAWMpQEjcQQtoe0eoF4NnsGtpN6RaxgWkgsygxQD2BzwZdPamzHe6vfqA1OM/hcZGSf9l49Iu6GG8Rn/61BS6wQnk96ANHK8vSNZJnRB1ComUzCtao9kXEAEnQ2oIotegmjV7jcEsU182otBs50Nrr7ZS1nkuOxyfUsIIgbLXiEaQNzhaqNq7K9poroOLgawNYFGk/AzR+DMyOP/6ArqWRVVVXtAur3ZNN5cBxnH72T2Ilr0prZ85fN1qspCVV9mUWUA84OGFylkH9dJ01+lx8mQjvOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V9VTXqKrcO7jB3eMOFE1XzKBnbgXZEsEU6KIl6QXl6Q=;
 b=0pqCGHKT9IhOEheBNhcOyUmj7BKFTUsW9QP9NsNDt/BkGyWNEH6XflNu/TxdT0CFbFciOSheRT+CLHxzV/p2xTxjqr0SNUDfpMEzGLlCMiTF0a32jSTNx9qT1SoUofL5o9voLxrbep/ykSwEgfggesbE8aKgJzNFGW1vKgUkV3s=
Received: from MW3PR12MB4554.namprd12.prod.outlook.com (2603:10b6:303:55::21)
 by MWHPR12MB1904.namprd12.prod.outlook.com (2603:10b6:300:114::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21; Wed, 8 Jul
 2020 19:05:16 +0000
Received: from MW3PR12MB4554.namprd12.prod.outlook.com
 ([fe80::f54a:55ae:1157:742]) by MW3PR12MB4554.namprd12.prod.outlook.com
 ([fe80::f54a:55ae:1157:742%3]) with mapi id 15.20.3174.022; Wed, 8 Jul 2020
 19:05:15 +0000
From: "Lakha, Bhawanpreet" <Bhawanpreet.Lakha@amd.com>
To: "Kazlauskas, Nicholas" <Nicholas.Kazlauskas@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amd/display: Use VUPDATE_NO_LOCK instead of VUPDATE
 for dcn30
Thread-Topic: [PATCH] drm/amd/display: Use VUPDATE_NO_LOCK instead of VUPDATE
 for dcn30
Thread-Index: AQHWVVnidgA9KpPWgU2GdMFijdG/nqj+Cn00
Date: Wed, 8 Jul 2020 19:05:15 +0000
Message-ID: <MW3PR12MB45545C585F17201ECDD60041F9670@MW3PR12MB4554.namprd12.prod.outlook.com>
References: <20200708185912.28731-1-nicholas.kazlauskas@amd.com>
In-Reply-To: <20200708185912.28731-1-nicholas.kazlauskas@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-CA
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-07-08T19:05:15.033Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.54.211]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3a5ba74f-d25f-45c6-0c02-08d82371d970
x-ms-traffictypediagnostic: MWHPR12MB1904:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR12MB19044CFE50CD2D3C56B5200EF9670@MWHPR12MB1904.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AxK8g3ezFofL/sR13EsKwPZxsClHUvIOq8wDu/38GJ1GDQnjR3JQi0+vSA7VyShu3buUl9CZN8uHNiukNsr0oB4xfdk9/YZ9ZUJ9l2LeDarz56L7aE2WjkH1KFgUrAhXACCCKtUa60KANbCniKQ5HOBoXv1RUvX0+NuR7b7cPqUinnPCVvNUQzXl7SBMskN9+g5rUAifD8GCSjJAAFau/xcaGPKvSPPD0Xh9gqm3cRkcP4vC7o13b6BbemwWWU/8CUxnMKn1cvDSX8dMrwjf6yA9+twXn7xg0zNMaUifL1EeimDFkIqqKvXiu66PiBb7pvrfDFAQuyLVaAAose1KhQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR12MB4554.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(39860400002)(396003)(376002)(346002)(366004)(316002)(110136005)(71200400001)(55016002)(9686003)(52536014)(186003)(5660300002)(83380400001)(33656002)(64756008)(66446008)(66556008)(66476007)(91956017)(76116006)(66946007)(19627405001)(7696005)(8676002)(8936002)(86362001)(26005)(2906002)(53546011)(6506007)(478600001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: pauu/O3ilMXrIKWwWfCLLwYSQMSputBQz2GgaPvIGK6hPrnWI1gO31tcVWJQKdNhxEfWgbBqZ5ZhwR4h4Rj4MIKjGhYFACiOmpAgfh+bypY2vDVKELkvqQuogawgOfy1pWSMWs/u/shRkuod11y63ZQgJxNm7s9XGyAf49G02kpeQpdKbmLowX32V8tNiUnBKFCp09PIAbiqVCvjK2RONj2lV1vzg1Z0VttSL5tECcVpB+fP/KTgs/cIaVO4UxfHB8zhHiprEu4oUTp0BMKO15P3L6Jki7GXqOlEswaIlSbPjkP9DmlDeZI6glOrMb7w4Oej0DH6iAjgtqa/OVczqAUgc94vmZCXL4q3B1kWzxNbJiwE78PsV1kLkUZId+2Udr9cqEx0zc+/pNr7uGv+zXEJ0nQsaj9UFD8vjq7JrOBYyNsgFQp5eBz535WOac7lVwhOPKK47lgBf5dC8eyh11o4MZjOE6C4J+/0CE19oRj7w9ist6P+WdKJQq4VinMG
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4554.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a5ba74f-d25f-45c6-0c02-08d82371d970
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2020 19:05:15.7149 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oFivVih7dDJ2fcnm5VQ0g4L8JrI8xDo5721mLBu8Y19dH91MIV6rMKnGxnvHo5Sj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1904
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
Content-Type: multipart/mixed; boundary="===============1865396856=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1865396856==
Content-Language: en-CA
Content-Type: multipart/alternative;
	boundary="_000_MW3PR12MB45545C585F17201ECDD60041F9670MW3PR12MB4554namp_"

--_000_MW3PR12MB45545C585F17201ECDD60041F9670MW3PR12MB4554namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
________________________________
From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Sent: July 8, 2020 2:59 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Kazlauskas, Nicholas <Nicholas.Kazlauskas@amd.com>; Lakha, Bhawanpreet =
<Bhawanpreet.Lakha@amd.com>
Subject: [PATCH] drm/amd/display: Use VUPDATE_NO_LOCK instead of VUPDATE fo=
r dcn30

[Why]
Soft hangs occur when FreeSync is engaged since we utilize VUPDATE
(which doesn't fire when holding the pipe lock) to send back vblank
events when FreeSync is active.

[How]
The alternative (working) interrupt source for this mechanism is
VUPDATE_NO_LOCK. We already use this all other DCN revisions so align
dcn30 with those as well.

Cc: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
---
 .../display/dc/irq/dcn30/irq_service_dcn30.c  | 28 ++++++++++++-------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/irq/dcn30/irq_service_dcn30.c b=
/drivers/gpu/drm/amd/display/dc/irq/dcn30/irq_service_dcn30.c
index dd4d7a1dc3b6..49689f71f4f1 100644
--- a/drivers/gpu/drm/amd/display/dc/irq/dcn30/irq_service_dcn30.c
+++ b/drivers/gpu/drm/amd/display/dc/irq/dcn30/irq_service_dcn30.c
@@ -169,6 +169,11 @@ static const struct irq_source_info_funcs pflip_irq_in=
fo_funcs =3D {
         .ack =3D NULL
 };

+static const struct irq_source_info_funcs vupdate_no_lock_irq_info_funcs =
=3D {
+       .set =3D NULL,
+       .ack =3D NULL
+};
+
 static const struct irq_source_info_funcs vblank_irq_info_funcs =3D {
         .set =3D NULL,
         .ack =3D NULL
@@ -228,12 +233,15 @@ static const struct irq_source_info_funcs vblank_irq_=
info_funcs =3D {
                 .funcs =3D &pflip_irq_info_funcs\
         }

-#define vupdate_int_entry(reg_num)\
+/* vupdate_no_lock_int_entry maps to DC_IRQ_SOURCE_VUPDATEx, to match sema=
ntic
+ * of DCE's DC_IRQ_SOURCE_VUPDATEx.
+ */
+#define vupdate_no_lock_int_entry(reg_num)\
         [DC_IRQ_SOURCE_VUPDATE1 + reg_num] =3D {\
                 IRQ_REG_ENTRY(OTG, reg_num,\
-                       OTG_GLOBAL_SYNC_STATUS, VUPDATE_INT_EN,\
-                       OTG_GLOBAL_SYNC_STATUS, VUPDATE_EVENT_CLEAR),\
-               .funcs =3D &vblank_irq_info_funcs\
+                       OTG_GLOBAL_SYNC_STATUS, VUPDATE_NO_LOCK_INT_EN,\
+                       OTG_GLOBAL_SYNC_STATUS, VUPDATE_NO_LOCK_EVENT_CLEAR=
),\
+               .funcs =3D &vupdate_no_lock_irq_info_funcs\
         }

 #define vblank_int_entry(reg_num)\
@@ -340,12 +348,12 @@ irq_source_info_dcn30[DAL_IRQ_SOURCES_NUMBER] =3D {
         dc_underflow_int_entry(6),
         [DC_IRQ_SOURCE_DMCU_SCP] =3D dummy_irq_entry(),
         [DC_IRQ_SOURCE_VBIOS_SW] =3D dummy_irq_entry(),
-       vupdate_int_entry(0),
-       vupdate_int_entry(1),
-       vupdate_int_entry(2),
-       vupdate_int_entry(3),
-       vupdate_int_entry(4),
-       vupdate_int_entry(5),
+       vupdate_no_lock_int_entry(0),
+       vupdate_no_lock_int_entry(1),
+       vupdate_no_lock_int_entry(2),
+       vupdate_no_lock_int_entry(3),
+       vupdate_no_lock_int_entry(4),
+       vupdate_no_lock_int_entry(5),
         vblank_int_entry(0),
         vblank_int_entry(1),
         vblank_int_entry(2),
--
2.25.1


--_000_MW3PR12MB45545C585F17201ECDD60041F9670MW3PR12MB4554namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#0078D7;margin:15pt;" al=
ign=3D"Left">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Reviewed-by: <font size=3D"2"><span style=3D"font-size:11pt">Bhawanpreet La=
kha &lt;Bhawanpreet.Lakha@amd.com&gt;</span></font><br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Nicholas Kazlauskas &=
lt;nicholas.kazlauskas@amd.com&gt;<br>
<b>Sent:</b> July 8, 2020 2:59 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Kazlauskas, Nicholas &lt;Nicholas.Kazlauskas@amd.com&gt;; Lakha,=
 Bhawanpreet &lt;Bhawanpreet.Lakha@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amd/display: Use VUPDATE_NO_LOCK instead of VUP=
DATE for dcn30</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">[Why]<br>
Soft hangs occur when FreeSync is engaged since we utilize VUPDATE<br>
(which doesn't fire when holding the pipe lock) to send back vblank<br>
events when FreeSync is active.<br>
<br>
[How]<br>
The alternative (working) interrupt source for this mechanism is<br>
VUPDATE_NO_LOCK. We already use this all other DCN revisions so align<br>
dcn30 with those as well.<br>
<br>
Cc: Bhawanpreet Lakha &lt;Bhawanpreet.Lakha@amd.com&gt;<br>
Signed-off-by: Nicholas Kazlauskas &lt;nicholas.kazlauskas@amd.com&gt;<br>
---<br>
&nbsp;.../display/dc/irq/dcn30/irq_service_dcn30.c&nbsp; | 28 &#43;&#43;&#4=
3;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;-------<br>
&nbsp;1 file changed, 18 insertions(&#43;), 10 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/display/dc/irq/dcn30/irq_service_dcn30.c b=
/drivers/gpu/drm/amd/display/dc/irq/dcn30/irq_service_dcn30.c<br>
index dd4d7a1dc3b6..49689f71f4f1 100644<br>
--- a/drivers/gpu/drm/amd/display/dc/irq/dcn30/irq_service_dcn30.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/display/dc/irq/dcn30/irq_service_dcn3=
0.c<br>
@@ -169,6 &#43;169,11 @@ static const struct irq_source_info_funcs pflip_ir=
q_info_funcs =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .ack =3D NULL<br>
&nbsp;};<br>
&nbsp;<br>
&#43;static const struct irq_source_info_funcs vupdate_no_lock_irq_info_fun=
cs =3D {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set =3D NULL,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .ack =3D NULL<br>
&#43;};<br>
&#43;<br>
&nbsp;static const struct irq_source_info_funcs vblank_irq_info_funcs =3D {=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set =3D NULL,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .ack =3D NULL<br>
@@ -228,12 &#43;233,15 @@ static const struct irq_source_info_funcs vblank_=
irq_info_funcs =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; .funcs =3D &amp;pflip_irq_info_funcs\<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-#define vupdate_int_entry(reg_num)\<br>
&#43;/* vupdate_no_lock_int_entry maps to DC_IRQ_SOURCE_VUPDATEx, to match =
semantic<br>
&#43; * of DCE's DC_IRQ_SOURCE_VUPDATEx.<br>
&#43; */<br>
&#43;#define vupdate_no_lock_int_entry(reg_num)\<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [DC_IRQ_SOURCE_VUPDATE1 &#=
43; reg_num] =3D {\<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; IRQ_REG_ENTRY(OTG, reg_num,\<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; OTG_GLOBAL_SYNC_=
STATUS, VUPDATE_INT_EN,\<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; OTG_GLOBAL_SYNC_=
STATUS, VUPDATE_EVENT_CLEAR),\<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .funcs =3D &amp;vblank_irq_info_funcs\<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; OTG_GLOBAL_S=
YNC_STATUS, VUPDATE_NO_LOCK_INT_EN,\<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; OTG_GLOBAL_S=
YNC_STATUS, VUPDATE_NO_LOCK_EVENT_CLEAR),\<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; .funcs =3D &amp;vupdate_no_lock_irq_info_funcs\<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;#define vblank_int_entry(reg_num)\<br>
@@ -340,12 &#43;348,12 @@ irq_source_info_dcn30[DAL_IRQ_SOURCES_NUMBER] =3D=
 {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dc_underflow_int_entry(6),=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [DC_IRQ_SOURCE_DMCU_SCP] =
=3D dummy_irq_entry(),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [DC_IRQ_SOURCE_VBIOS_SW] =
=3D dummy_irq_entry(),<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vupdate_int_entry(0),<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vupdate_int_entry(1),<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vupdate_int_entry(2),<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vupdate_int_entry(3),<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vupdate_int_entry(4),<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vupdate_int_entry(5),<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vupdate_no_lock_int_entry(0),<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vupdate_no_lock_int_entry(1),<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vupdate_no_lock_int_entry(2),<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vupdate_no_lock_int_entry(3),<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vupdate_no_lock_int_entry(4),<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vupdate_no_lock_int_entry(5),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vblank_int_entry(0),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vblank_int_entry(1),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vblank_int_entry(2),<br>
-- <br>
2.25.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MW3PR12MB45545C585F17201ECDD60041F9670MW3PR12MB4554namp_--

--===============1865396856==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1865396856==--
