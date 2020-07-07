Return-Path: <SRS0=Rnur=AS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32A69C433DF
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jul 2020 16:02:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05EDB20708
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jul 2020 16:02:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="hxKLsShd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05EDB20708
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C759A6E22B;
	Tue,  7 Jul 2020 16:02:27 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770072.outbound.protection.outlook.com [40.107.77.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A9FDC6E227
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jul 2020 16:02:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D3Z2Zry8E2IhGGoXpbbo0EDHtXl63HJVCQnRUnbG76g/I8zzX+egn3Ynt5YQhUeDVQYcuXJt/iKqNXSlZwdLXho9sx39Aufkf+wY1GHjSPwXp/2Nxc6/lhl9niON7Fwlf87JxL5B3YTw09iG9Dbw+I6qxhV09WCgwTXMhz+jFDB7ggG/g1JPHvMMDDesjV5BInLt6MUcrz5yJeAhk+yHB+STrK9+iZ8Tx8q727ci9bTAVjDTZkakvZkNW4izz7SanL6go3WB8ckWMQn60V3jckBCGgcZAdZ1sR3qMeXHh3ppsNJ6KvvQ94sZN1N73qIZooUUqqyqKxH/mWrVuY/sng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cDelzjoGQtgM/i6SGCJvKXHuNYJEhZpdrszqUvleHN8=;
 b=Xy2nylgp4jclvQ2btIf1boDgERij9bmUB2uFSSwzWxu1ypq7HSs2jyL2vFjNXoD0PP/aLeBziKBepzaac5jupXws+Z8gLo1n5ZknaXUYA4nyyLdej0I1UtHxy3MDLQ2mbcyevntVioVkByRHb8XYKEF1cgC0NcfrI7DzzjvAZuIMvIg6ZxCc0I2nVGm8JrGRuLNtbJUDEPKfMISV5euj2ClQWrCBMe38Fb96olxuWXnW+auk2ymGkCXfmaZenJd272GMrNDhJ4sRaDB5SZlXVjR3xvVnZpbbr+ehiH6UHg9f+YGFggw72J6/oivz1cPbx/zJDlc85ZFYbPSh2fI1KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cDelzjoGQtgM/i6SGCJvKXHuNYJEhZpdrszqUvleHN8=;
 b=hxKLsShdr/WU4SmqzUQeUuU+eexSaRNhUxgtQuHK5uBMYj0jBsneN+I75J63rBYXYlW74gnIMFqJXmO2M6uYGbC47VO5rU2uUQaV/okRiFxPQ513IIiJLd5bS/mqfpRtWEGhopX7YWqNWaE6koH7ucD0AS9KuqoaN2BCo7e+Bog=
Received: from MW3PR12MB4554.namprd12.prod.outlook.com (2603:10b6:303:55::21)
 by MWHPR12MB1807.namprd12.prod.outlook.com (2603:10b6:300:113::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.24; Tue, 7 Jul
 2020 16:02:25 +0000
Received: from MW3PR12MB4554.namprd12.prod.outlook.com
 ([fe80::f54a:55ae:1157:742]) by MW3PR12MB4554.namprd12.prod.outlook.com
 ([fe80::f54a:55ae:1157:742%3]) with mapi id 15.20.3174.021; Tue, 7 Jul 2020
 16:02:25 +0000
From: "Lakha, Bhawanpreet" <Bhawanpreet.Lakha@amd.com>
To: "Kazlauskas, Nicholas" <Nicholas.Kazlauskas@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amd/display: Add missing CW4 programming for DCN30
Thread-Topic: [PATCH] drm/amd/display: Add missing CW4 programming for DCN30
Thread-Index: AQHWVHUct7C23QSfpUmQ95GtnoUhyqj8Ru7v
Date: Tue, 7 Jul 2020 16:02:24 +0000
Message-ID: <MW3PR12MB4554A7AD6FB6C5CD62944104F9660@MW3PR12MB4554.namprd12.prod.outlook.com>
References: <20200707154101.5715-1-nicholas.kazlauskas@amd.com>
In-Reply-To: <20200707154101.5715-1-nicholas.kazlauskas@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-CA
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-07-07T16:02:25.673Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.10.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 816c00ce-9b8a-441e-93f4-08d8228f23e8
x-ms-traffictypediagnostic: MWHPR12MB1807:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR12MB1807101C65608F68C529C400F9660@MWHPR12MB1807.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2582;
x-forefront-prvs: 0457F11EAF
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: igt1zBBq9NR/iCHJJ/3mZr/2+OYgsIKWj0Fq2tFQv3jgf6Cos0tlTBqhdZZG5ioZn01nh7qkpkDEIYHjkuBvNq1HC/YTm94HlvZwD/LDw6R3oPLHN32bfJjlkgAnISKvhQYw5yTT57ql4qmyT5GpY3Zl9DlapL6tIsQhU8YlsotoTjmxTqoLxsqdusB09ZJy0LzAnyM2YT3r0bf1KVwiPaKpzbl+9jlwrb/56DnwNOSwJxXPhI1lVU1xj3QEC9HTX3F/oxr5NE/K/By4amLhQw2RQP1othr0TY/JWbF5mEuRgnN2P9YGMbdIHxTRPO4dneYXu5IPMx2tRX20DyS1bQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR12MB4554.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(346002)(366004)(39860400002)(396003)(136003)(19627405001)(55016002)(33656002)(76116006)(66446008)(66476007)(66946007)(66556008)(64756008)(52536014)(86362001)(83380400001)(8936002)(26005)(5660300002)(8676002)(9686003)(110136005)(6506007)(53546011)(478600001)(71200400001)(2906002)(186003)(7696005)(316002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: 93sgCfWiXik2jz/NSk3KewNu+6oIRQdDY3rrG2O9YkcI4z7sIoNTc07CVQczhmeZ0lXOfrHNEzQgNmGjt4u+mXtcJP6OnfCRbKKVZ4ZoD8vLSMIsuS8FO1O7bm5zsfROqpYDrf2Y1uvVAYR9o7h55BlWxSC6zFwnYcWtSuNRwhDDxdcuVVlKFu6CDbwx0Rom9OyJ6i60DIH/fXWW+RFV5r2y604PEtxSel3unG1BzNOHg+ZhwjJWCh3YH8Y4D1twIZa4PgNNdxaqeI3l4PjoDpHiofejSnUp6py83pp3aLs0D/AdS25YoNKLieKITEXkMWkcPzvV67+kwnNTy35q0vukICiyBEr4Nem2+QeQf3BSeP1Do22kalNXNWoZcC2DSL1UYQAKIsfbGBqGXJyMFBuzPk3c3nZcCUFAWQVp4JCGNCPsweaBiaz23lPdVow2HefYw81N0Bsq58NulR8E4rczEekEKDbl3QLr5QUALodKwB6ZMzAMBwoRzG7dlHTU
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4554.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 816c00ce-9b8a-441e-93f4-08d8228f23e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2020 16:02:24.9365 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D4n/fX1v/hlwZSnU5fb+s+woe0u3Pz1PH22KIJnGUdixw9zyYvifI1gbsAocQyJV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1807
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
Content-Type: multipart/mixed; boundary="===============0689059479=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0689059479==
Content-Language: en-CA
Content-Type: multipart/alternative;
	boundary="_000_MW3PR12MB4554A7AD6FB6C5CD62944104F9660MW3PR12MB4554namp_"

--_000_MW3PR12MB4554A7AD6FB6C5CD62944104F9660MW3PR12MB4554namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
________________________________
From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Sent: July 7, 2020 11:41 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Kazlauskas, Nicholas <Nicholas.Kazlauskas@amd.com>; Lakha, Bhawanpreet =
<Bhawanpreet.Lakha@amd.com>
Subject: [PATCH] drm/amd/display: Add missing CW4 programming for DCN30

[Why]
To support inbox1 in CW4 we need to actually program CW4 instead of
region 4 for newer firmware.

This is done correctly on DCN20/DCN21 but this code wasn't added to
DCN30.

[How]
Copy over the missing code. It doesn't need address translation since
DCN30 uses virtual addressing.

Cc: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
---
 .../gpu/drm/amd/display/dmub/src/dmub_dcn30.c | 21 ++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn30.c b/drivers/gp=
u/drm/amd/display/dmub/src/dmub_dcn30.c
index ba8d0bfb5522..215178b8d415 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn30.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn30.c
@@ -153,11 +153,22 @@ void dmub_dcn30_setup_windows(struct dmub_srv *dmub,

         offset =3D cw4->offset;

-       REG_WRITE(DMCUB_REGION4_OFFSET, offset.u.low_part);
-       REG_WRITE(DMCUB_REGION4_OFFSET_HIGH, offset.u.high_part);
-       REG_SET_2(DMCUB_REGION4_TOP_ADDRESS, 0, DMCUB_REGION4_TOP_ADDRESS,
-                 cw4->region.top - cw4->region.base - 1, DMCUB_REGION4_ENA=
BLE,
-                 1);
+       /* New firmware can support CW4. */
+       if (dmub->fw_version > DMUB_FW_VERSION(1, 0, 10)) {
+               REG_WRITE(DMCUB_REGION3_CW4_OFFSET, offset.u.low_part);
+               REG_WRITE(DMCUB_REGION3_CW4_OFFSET_HIGH, offset.u.high_part=
);
+               REG_WRITE(DMCUB_REGION3_CW4_BASE_ADDRESS, cw4->region.base)=
;
+               REG_SET_2(DMCUB_REGION3_CW4_TOP_ADDRESS, 0,
+                         DMCUB_REGION3_CW4_TOP_ADDRESS, cw4->region.top,
+                         DMCUB_REGION3_CW4_ENABLE, 1);
+       } else {
+               REG_WRITE(DMCUB_REGION4_OFFSET, offset.u.low_part);
+               REG_WRITE(DMCUB_REGION4_OFFSET_HIGH, offset.u.high_part);
+               REG_SET_2(DMCUB_REGION4_TOP_ADDRESS, 0,
+                         DMCUB_REGION4_TOP_ADDRESS,
+                         cw4->region.top - cw4->region.base - 1,
+                         DMCUB_REGION4_ENABLE, 1);
+       }

         offset =3D cw5->offset;

--
2.25.1


--_000_MW3PR12MB4554A7AD6FB6C5CD62944104F9660MW3PR12MB4554namp_
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
<b>Sent:</b> July 7, 2020 11:41 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Kazlauskas, Nicholas &lt;Nicholas.Kazlauskas@amd.com&gt;; Lakha,=
 Bhawanpreet &lt;Bhawanpreet.Lakha@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amd/display: Add missing CW4 programming for DC=
N30</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">[Why]<br>
To support inbox1 in CW4 we need to actually program CW4 instead of<br>
region 4 for newer firmware.<br>
<br>
This is done correctly on DCN20/DCN21 but this code wasn't added to<br>
DCN30.<br>
<br>
[How]<br>
Copy over the missing code. It doesn't need address translation since<br>
DCN30 uses virtual addressing.<br>
<br>
Cc: Bhawanpreet Lakha &lt;Bhawanpreet.Lakha@amd.com&gt;<br>
Signed-off-by: Nicholas Kazlauskas &lt;nicholas.kazlauskas@amd.com&gt;<br>
---<br>
&nbsp;.../gpu/drm/amd/display/dmub/src/dmub_dcn30.c | 21 &#43;&#43;&#43;&#4=
3;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;-----<br>
&nbsp;1 file changed, 16 insertions(&#43;), 5 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn30.c b/drivers/gp=
u/drm/amd/display/dmub/src/dmub_dcn30.c<br>
index ba8d0bfb5522..215178b8d415 100644<br>
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn30.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn30.c<br>
@@ -153,11 &#43;153,22 @@ void dmub_dcn30_setup_windows(struct dmub_srv *dm=
ub,<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; offset =3D cw4-&gt;offset;=
<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; REG_WRITE(DMCUB_REGION4_OFFSET, offse=
t.u.low_part);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; REG_WRITE(DMCUB_REGION4_OFFSET_HIGH, =
offset.u.high_part);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; REG_SET_2(DMCUB_REGION4_TOP_ADDRESS, =
0, DMCUB_REGION4_TOP_ADDRESS,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; cw4-&gt;region.top - cw4-&gt;region.base - 1, DMCUB_=
REGION4_ENABLE,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; 1);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* New firmware can support CW4. =
*/<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (dmub-&gt;fw_version &gt; DMUB=
_FW_VERSION(1, 0, 10)) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; REG_WRITE(DMCUB_REGION3_CW4_OFFSET, offset.u.low_part);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; REG_WRITE(DMCUB_REGION3_CW4_OFFSET_HIGH, offset.u.high_part)=
;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; REG_WRITE(DMCUB_REGION3_CW4_BASE_ADDRESS, cw4-&gt;region.bas=
e);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; REG_SET_2(DMCUB_REGION3_CW4_TOP_ADDRESS, 0,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
DMCUB_REGION3_CW4_TOP_ADDRESS, cw4-&gt;region.top,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
DMCUB_REGION3_CW4_ENABLE, 1);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; REG_WRITE(DMCUB_REGION4_OFFSET, offset.u.low_part);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; REG_WRITE(DMCUB_REGION4_OFFSET_HIGH, offset.u.high_part);<br=
>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; REG_SET_2(DMCUB_REGION4_TOP_ADDRESS, 0,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
DMCUB_REGION4_TOP_ADDRESS,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
cw4-&gt;region.top - cw4-&gt;region.base - 1,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
DMCUB_REGION4_ENABLE, 1);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; offset =3D cw5-&gt;offset;=
<br>
&nbsp;<br>
-- <br>
2.25.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MW3PR12MB4554A7AD6FB6C5CD62944104F9660MW3PR12MB4554namp_--

--===============0689059479==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0689059479==--
