Return-Path: <SRS0=jB5Z=EB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CE57C4363A
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Oct 2020 16:05:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC66322409
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Oct 2020 16:05:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="eoQjjQda"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC66322409
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 96A426E444;
	Mon, 26 Oct 2020 16:05:29 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2060.outbound.protection.outlook.com [40.107.243.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5BAAC6E444
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Oct 2020 16:05:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DXCDXE1GAQjQ+zozwCoIhak2bVVHYjNLTLMsxtAm1z2OEb0ovvpPLHnNjGbGBjX0cYK4Dpkj5idMXEesxRAp3H4B4d2m2SL0tWL2dW49zMrIRfjEAsYQq4V6T5fQK9EX/d4+92qxuXbiNdkkbjLN2KYwyyxXvtm6UeftOz2XszGE/MzBJZ/UnTD4hUcKkISj/Rts2FD/aYYx3QKNqiFDUFdQSJakjzVbC3WHfrNb/9958mfkm9N6I6E3+5kAQPhh46PC/OVl0Pe+/LmEJmPIyvmjQeJ0kF6xfaqRP8OIk/cPoRtk0rkU18hZX5543wiqaAWf4HkiOrmNbyHDKQNPSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eLGeGjqT3kY3NLOvbbBLkGcLcrSdL3VBsOAUwxyvosM=;
 b=Ebxt29u8mXD3TaWPbmu4taErABHOiUxAWJV5brL6Wd/hr3nPBc5TO9CObX65l+WIMbhTx9ljfsZ5aQS7xlfvqcTuyiY1qbDtHiTl8wU0Zk0YWxYLX3TLptZ6GNb0YIqm3rqyjtHgezkj9qrk0maffBdk9ZtG4kCgLVhnWpz78Rq5kWJdN1wg21nPIxOoHO/hdpU33TccaL17W4d/DGwEVks5LdsQLBc1PxOlo7n/A/N5h7yVhMRjYgtW4EmHIjiQaM/lOjsXnqp89o1GOE9U0ZS5VZWqVzr+Bi1ORxUduW/PMXtDdom8DW4iJCfywq2qvoJ+WJfeGkogWWZcxwor0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eLGeGjqT3kY3NLOvbbBLkGcLcrSdL3VBsOAUwxyvosM=;
 b=eoQjjQdaur9WIzPK1nc6ORkoKIvhiK3NUxdUS9eSJapsBfot18kVJ+l90howQeMaoMbl52wvVRVFl0mg/5Gt0k5NyJQr33m0kzwQ8IaTQ5UcVCe0fcRBWwvo5osmkgX7oiVdK+cv9jF6ZuJS9X4BeXPyuhOfznOUbu2G2ugJAkA=
Received: from MWHPR12MB1629.namprd12.prod.outlook.com (2603:10b6:301:3::23)
 by MWHPR12MB1805.namprd12.prod.outlook.com (2603:10b6:300:106::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.28; Mon, 26 Oct
 2020 16:05:26 +0000
Received: from MWHPR12MB1629.namprd12.prod.outlook.com
 ([fe80::6160:11b1:2c80:b56e]) by MWHPR12MB1629.namprd12.prod.outlook.com
 ([fe80::6160:11b1:2c80:b56e%11]) with mapi id 15.20.3499.018; Mon, 26 Oct
 2020 16:05:26 +0000
From: "Abramov, Slava" <Slava.Abramov@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 2/2] drm/amdgpu/display: drop disconnect_pipes callback
 for DCN3.01
Thread-Topic: [PATCH 2/2] drm/amdgpu/display: drop disconnect_pipes callback
 for DCN3.01
Thread-Index: AQHWq7DIrgwDnYTDBE6T6PsEQRc/s6mqDD2n
Date: Mon, 26 Oct 2020 16:05:26 +0000
Message-ID: <MWHPR12MB16293E57B344FF27B18B6EF2FE190@MWHPR12MB1629.namprd12.prod.outlook.com>
References: <20201026155738.964136-1-alexander.deucher@amd.com>,
 <20201026155738.964136-2-alexander.deucher@amd.com>
In-Reply-To: <20201026155738.964136-2-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-10-26T16:05:26.256Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [2607:9880:2f27:ffe4:adcc:36fc:ad8c:747f]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ac956dec-7f07-4da8-8834-08d879c8f41e
x-ms-traffictypediagnostic: MWHPR12MB1805:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR12MB1805C94111C63C052CA43C73FE190@MWHPR12MB1805.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:883;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eLuE+SqkRyP5xpNT1zDmiODb6v63n/XrKzDxgu9uyEJkH7CQiwUkJf3ZjZASzBIm+uKIHza2gazFXvQWzli4fgaBmc0bqH/VkBaIc1iMvVno5Z1zDLO67yEUm7H9tlXqM71Lh6SeW8WKygTU2+hs4FUp0A1u24D2qzYEY1Pyp0YoVlQIt/4L1i7lWgmBK5fahzhwvTGPPyU3PMKH+AXBZ5V5N8mbw1IlNbNFV6bY7FmkMVp6W5tSEjDVY67Cnfq1aukmuXcgF+sf4nCqQspmr1wOu+42tA0IvoKGS39ur5R0uuvTm0Ok6MOEGAmzZBROjNGmpd/w9EotmRDSMSuCBBDmas7N5LT1IvDiMLDDa8c=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR12MB1629.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(346002)(376002)(366004)(136003)(66556008)(4326008)(478600001)(52536014)(19627405001)(186003)(64756008)(8936002)(76116006)(5660300002)(66946007)(66446008)(83380400001)(33656002)(91956017)(45080400002)(66476007)(966005)(71200400001)(55016002)(166002)(2906002)(316002)(86362001)(9686003)(6506007)(8676002)(53546011)(110136005)(7696005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: +GhZ+2G2vER9Q6YPB8CCDeQTf4LdGx5wmhyAoWI35yJOk42JqRxwcCvj4dwHJRrXrzzWr/TZMpee8mEBFh+um3U4iv2L8REMOgrPKeONvYAGt+NLlVgM88NTWiwfUezR4Y/u4gStGFDI+J7fKWVSBPBMK1ZBlnS1NANywEljTFt0WDMzWEzZ/T+wqF4TOliZT49Jlh3ZAI7IVlGgzSx8gbu6hDvHE7BSYxRfRdeMND9taleRxhvtHmjKY5028r3PDSCf23CdI+C8JQV2X3Soaa6b03Wva/rzgdfxJTfCvb2LkDEFIz7GEKMjAx0yHc0iIs12c8Q+W9+7Qrbh2gPhOhWhxpJoTzFbbu3btagWjEf2wxnoTIeedX6OjmTHm9XX5qyEoo0hminHE6Nz40m0bmaaF3Rmeqy0TJOoEzKoFYl/Vf78koPU1BSDxeoiKVfs1mjiqjXJqFHePN4h9WE0PhHebH+Wk7xOLO7D+cWXHlx1XNFFrVdkD49qBkPDREl3bSENfzrCKDA7wVmGMbGbNeQL49uwz/SDJR7t4rjeI6K2A7NOpx00DjGy/RvyYSYb5aRjJPsYMDJ+7iod8+ggJAYXSxALGjlmj2H7NoeKqYf3QwsXz4u2GZG/0KBsBte5a6m/UYx8JjobHBlXw/0uwTnbToSXAesEavPsIjbY6pAjHluFsNiMtZoD5ar305auFDMTK+2xg6Kjp5Gm4h75fA==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1629.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac956dec-7f07-4da8-8834-08d879c8f41e
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2020 16:05:26.7422 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HCpKl3z5AeOpoCZuDKoBU0xEwSvYdu1de0+W9Hj5mwzgTPxLiwRLKWUbB1g1ke9uJVlJudlSMN6WoaD/N3xZRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1805
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Content-Type: multipart/mixed; boundary="===============0543102899=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0543102899==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MWHPR12MB16293E57B344FF27B18B6EF2FE190MWHPR12MB1629namp_"

--_000_MWHPR12MB16293E57B344FF27B18B6EF2FE190MWHPR12MB1629namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Slava Abramov <slava.abramov@amd.com>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Alex Deu=
cher <alexdeucher@gmail.com>
Sent: Monday, October 26, 2020 11:57 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH 2/2] drm/amdgpu/display: drop disconnect_pipes callback for=
 DCN3.01

Was missed in a later update.

Fixes: 4d269c40066e ("drm/amd/display: Update GSL state if leaving immediat=
e flip")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn301/dcn301_init.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_init.c b/drivers/=
gpu/drm/amd/display/dc/dcn301/dcn301_init.c
index d4bebb3a52e4..6d9587c39efd 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_init.c
@@ -37,7 +37,6 @@ static const struct hw_sequencer_funcs dcn301_funcs =3D {
         .apply_ctx_to_hw =3D dce110_apply_ctx_to_hw,
         .apply_ctx_for_surface =3D NULL,
         .program_front_end_for_ctx =3D dcn20_program_front_end_for_ctx,
-       .disconnect_pipes =3D dcn10_disconnect_pipes,
         .wait_for_pending_cleared =3D dcn10_wait_for_pending_cleared,
         .post_unlock_program_front_end =3D dcn20_post_unlock_program_front=
_end,
         .update_plane_addr =3D dcn20_update_plane_addr,
--
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7Cslava.ab=
ramov%40amd.com%7Cf9bafa91bf3b43effdb408d879c7e771%7C3dd8961fe4884e608e11a8=
2d994e183d%7C0%7C0%7C637393246812184058%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4=
wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3D=
4pqb3l%2F%2FMgjrAUGB9Y0dAU0SV82mHvZIUlQQZe0bEvY%3D&amp;reserved=3D0

--_000_MWHPR12MB16293E57B344FF27B18B6EF2FE190MWHPR12MB1629namp_
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
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt;=
 color: rgb(0, 0, 0);">
<span style=3D"background-color:rgb(255, 255, 255);display:inline !importan=
t">Reviewed-by: Slava Abramov &lt;slava.abramov@amd.com&gt;</span><br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Alex Deucher &lt;alexdeucher@=
gmail.com&gt;<br>
<b>Sent:</b> Monday, October 26, 2020 11:57 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;<br>
<b>Subject:</b> [PATCH 2/2] drm/amdgpu/display: drop disconnect_pipes callb=
ack for DCN3.01</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Was missed in a later update.<br>
<br>
Fixes: 4d269c40066e (&quot;drm/amd/display: Update GSL state if leaving imm=
ediate flip&quot;)<br>
Signed-off-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/display/dc/dcn301/dcn301_init.c | 1 -<br>
&nbsp;1 file changed, 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_init.c b/drivers/=
gpu/drm/amd/display/dc/dcn301/dcn301_init.c<br>
index d4bebb3a52e4..6d9587c39efd 100644<br>
--- a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_init.c<br>
+++ b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_init.c<br>
@@ -37,7 +37,6 @@ static const struct hw_sequencer_funcs dcn301_funcs =3D {=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .apply_ctx_to_hw =3D dce11=
0_apply_ctx_to_hw,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .apply_ctx_for_surface =3D=
 NULL,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .program_front_end_for_ctx=
 =3D dcn20_program_front_end_for_ctx,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .disconnect_pipes =3D dcn10_disconnec=
t_pipes,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .wait_for_pending_cleared =
=3D dcn10_wait_for_pending_cleared,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .post_unlock_program_front=
_end =3D dcn20_post_unlock_program_front_end,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .update_plane_addr =3D dcn=
20_update_plane_addr,<br>
-- <br>
2.25.4<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D04%=
7C01%7Cslava.abramov%40amd.com%7Cf9bafa91bf3b43effdb408d879c7e771%7C3dd8961=
fe4884e608e11a82d994e183d%7C0%7C0%7C637393246812184058%7CUnknown%7CTWFpbGZs=
b3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C10=
00&amp;amp;sdata=3D4pqb3l%2F%2FMgjrAUGB9Y0dAU0SV82mHvZIUlQQZe0bEvY%3D&amp;a=
mp;reserved=3D0">https://nam11.safelinks.protection.outlook.com/?url=3Dhttp=
s%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=
=3D04%7C01%7Cslava.abramov%40amd.com%7Cf9bafa91bf3b43effdb408d879c7e771%7C3=
dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637393246812184058%7CUnknown%7CTW=
FpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3=
D%7C1000&amp;amp;sdata=3D4pqb3l%2F%2FMgjrAUGB9Y0dAU0SV82mHvZIUlQQZe0bEvY%3D=
&amp;amp;reserved=3D0</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MWHPR12MB16293E57B344FF27B18B6EF2FE190MWHPR12MB1629namp_--

--===============0543102899==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0543102899==--
