Return-Path: <SRS0=m9pB=DM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17BD0C4363A
	for <amd-gfx@archiver.kernel.org>; Mon,  5 Oct 2020 19:13:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9146B2074F
	for <amd-gfx@archiver.kernel.org>; Mon,  5 Oct 2020 19:13:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="SLjEFXxZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9146B2074F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3551B89DA9;
	Mon,  5 Oct 2020 19:13:55 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2088.outbound.protection.outlook.com [40.107.93.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B0F2F89DA9
 for <amd-gfx@lists.freedesktop.org>; Mon,  5 Oct 2020 19:13:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nMqhNZxhdN/oqXdtMAZ/bOlgDnMfINBZR7eRBBTyw6t9Hwpc+wmOugSWXeX1bpWAB9cYbq75j8DAgGwNntoSXi5+MfNwxOUts+XhpXpLMLy4Lmlu1d8X+Jp7uBJCETfB4H7CUcRfd/rFzn23WrllAOW2QGXaR+6zFCfivpE00eOq6jm8kl9mhXYZ40NDICTzTCzAUY+nvkDlxVPxtaD9hU7y5hNuQsMlbo2ydDOHe2dGvhLwzdFP0kKLDNXhj5DAY9Ekj78QzNPJyvyi93cAJfvebBUDRde9rvyuFu64wA2L3+pWjKIa5r/Ix9pekdh5KHeoGypUVowj2d2ZZC2Akw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZppC02+0hdoncJphwyM6DTHDqp7ni4r1+31fyHcRFkM=;
 b=CdAxjM9VBYOwKLrIEy8sB1EJ7Yh3mz3YeaAkRe5owefr9QULzt6UHHhWqx684MoCgwsTqIrm1hazZtbucrdp1oxRGnq31HUQJJ/lVvx4963eUaEDiZhNbROoe4Agzf+s/8zYkKpVzm++ECQizU3LyglKgTTA00q9fYSh8sYr/LcMYBNzUdSyDbPitxG4ZfIrMZ51+FC1lqvg/+Jri50cBYUd5XA2AMifrrsMrzktM5S/6sT0oe+4rw7cL7AmQYS1YUNHVH5zpwSM2n6SaiULzmsA/xMRDZDYvmcymk7/mgOtLl27AiTx4ESqbMdI2WHjhGoZoWeW1bFNGKIB68wm3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZppC02+0hdoncJphwyM6DTHDqp7ni4r1+31fyHcRFkM=;
 b=SLjEFXxZ6Os3t/P/Ek/js4mk6f2D5hpATn2cD+Sz3ieJKcjmVO633d7Oue7ifk1uAdd9/WiWXmd13UONFBSMPwvEjhiRjxXMseMOioMusxHL7YHsOs6FNzhauIZaY9eii9o2+7JUZxwHIhcSQKAXHWkrZ0Ua7bmsavN1Hf9r9qY=
Received: from MW3PR12MB4554.namprd12.prod.outlook.com (2603:10b6:303:55::21)
 by MWHPR1201MB0206.namprd12.prod.outlook.com (2603:10b6:301:55::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.35; Mon, 5 Oct
 2020 19:13:51 +0000
Received: from MW3PR12MB4554.namprd12.prod.outlook.com
 ([fe80::e4c8:2ab4:50ae:be6b]) by MW3PR12MB4554.namprd12.prod.outlook.com
 ([fe80::e4c8:2ab4:50ae:be6b%8]) with mapi id 15.20.3433.044; Mon, 5 Oct 2020
 19:13:51 +0000
From: "Lakha, Bhawanpreet" <Bhawanpreet.Lakha@amd.com>
To: "Kazlauskas, Nicholas" <Nicholas.Kazlauskas@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: Re: [PATCH] drm/amd/display: Add missing function pointers for dcn3
Thread-Topic: [PATCH] drm/amd/display: Add missing function pointers for dcn3
Thread-Index: AQHWm0LUgeVs0cbmqUKol4N9fKhGt6mJT8CAgAAQnww=
Date: Mon, 5 Oct 2020 19:13:51 +0000
Message-ID: <MW3PR12MB4554C21E1F3086D79AE91AEAF90C0@MW3PR12MB4554.namprd12.prod.outlook.com>
References: <20201005181033.1267385-1-Bhawanpreet.Lakha@amd.com>,
 <c47bbd8b-0c93-3ee9-ca3a-cb7f7fcfd2c2@amd.com>
In-Reply-To: <c47bbd8b-0c93-3ee9-ca3a-cb7f7fcfd2c2@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-CA
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-10-05T19:13:51.177Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.10.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4ffe79a7-2e03-4cc4-ae0d-08d86962cbb4
x-ms-traffictypediagnostic: MWHPR1201MB0206:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR1201MB0206AC2010CAE281E788A296F90C0@MWHPR1201MB0206.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3173;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rutGKIqwC4KOwPToh1X2e0+gnXTK7u0qU5Usl0++O+ZladkXRMQf04l2EvOLE1Fw8mSgzJ5xWXk6Lk35c70bq0DGcvkdsi6lM+PNDu3rfzmHMK+CxTDBfbFWIdHH8FURaxZWFDphVAv/EnllTc8p6icn1cOA3zDkXBEb72uU4uBAXO16Vi+S0PcqNhz4IZAd8B8t+p41tGHjqMP0kjrUFDS9ym2Qt8Cftvi1FzUYmPJ0tPgLAEsQ472FivTsN7357yyfPzp7Hd7f1IaQWfny9G2v5DvzY+VhP/4cyyc8l5rk/nVvSi/l1ASYTc2YlpoatvghZYJJkprJyXUXVxR9jw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR12MB4554.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(376002)(346002)(396003)(39860400002)(4326008)(2906002)(86362001)(55016002)(9686003)(478600001)(19627405001)(71200400001)(76116006)(186003)(83380400001)(53546011)(8936002)(6506007)(54906003)(8676002)(66946007)(66556008)(66476007)(64756008)(66446008)(5660300002)(52536014)(6636002)(33656002)(26005)(316002)(110136005)(7696005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: Nij/bGBTAAHbpgot5F7Y/voKhjftgkyhpjSC6ehPOLkWBD7gAIg7IWqOrABhyCD8HEL7EnJPuZ+fK21IcjxVOKsH3GJnlsyS82jX5VLilIidF66pC7STtdAtxQZyNC2eRy4Ymgt6PN0MOaiPfvmEUzvdkIZsLJ0urEOLnElkccxsftP2UZizbuYY6rk/+s1XT/MjEpqUmix7Baf4B1G9D90K+lKSWzw7EvEQC2ujA/jsIgW5DX1+nG/eGNpgD3scn/cJfrILf5KszGCwOz8EzAExfiq9wLEvTKp32/SES+Ychlicq5EvI9xb9oCStpWyNA0KExYcr2Z6xPjnLFYsxn7B9cQO7kAYbuSIkgXf/wh8Vth38pTXxZzVgF7ZltI+1mTJpGpIbj4PUhEFXgTmEsCLdOJGwfiw9hWSbWWgppCB3+73mcLaO05z1Ij2E+NdOZNnEPkdyGaIrLuySkhcpQcON74Gyo39TbmfCRmpL240EkzAakgZ5Mh6F9VT9QZQgLeqH+EM/OVCsXCmf47SEqpHrhk3SUgdXsgjxGrDIryyZj4lo/S206FQwveF7h/y56izc05vIJMRsFSKvmeGj1f4h08nRSFUJa7hRbO4o9tECYqy2/0E/DHtkeDOfsIRxVsA1hAbXEyaTFhFNVerHQ==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4554.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ffe79a7-2e03-4cc4-ae0d-08d86962cbb4
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2020 19:13:51.6699 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MiM5mH1MSAiW+rCOHRRm7nKue0k1pnS2E4gtJRuJJXXBB2v/7H1/WUcQVy9P2tkk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0206
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
Content-Type: multipart/mixed; boundary="===============0135731010=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0135731010==
Content-Language: en-CA
Content-Type: multipart/alternative;
	boundary="_000_MW3PR12MB4554C21E1F3086D79AE91AEAF90C0MW3PR12MB4554namp_"

--_000_MW3PR12MB4554C21E1F3086D79AE91AEAF90C0MW3PR12MB4554namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Thanks,

.calc_vupdate_position : Used to help avoid cursor stuttering
.set_pipe : Needed for setting abm


WIll add these before pushing.
________________________________
From: Kazlauskas, Nicholas <Nicholas.Kazlauskas@amd.com>
Sent: October 5, 2020 2:12 PM
To: Lakha, Bhawanpreet <Bhawanpreet.Lakha@amd.com>; Deucher, Alexander <Ale=
xander.Deucher@amd.com>
Cc: rodrigo.siqOFueira@amd.com <rodrigo.siqOFueira@amd.com>; amd-gfx@lists.=
freedesktop.org <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amd/display: Add missing function pointers for dcn=
3

On 2020-10-05 2:10 p.m., Bhawanpreet Lakha wrote:
> These function pointers are missing from dcn30_init
>
> .calc_vupdate_position
> .set_pipe
>
> So add them
>
> Signed-off-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

Would be good to mention what these are used for specifically though.

The calc_vupdate_position in particular is used to help avoid cursor
stuttering.

Regards,
Nicholas Kazlauskas

> ---
>   drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.c b/drivers/=
gpu/drm/amd/display/dc/dcn30/dcn30_init.c
> index 7c90c2222506..dc312d4172af 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.c
> @@ -90,9 +90,11 @@ static const struct hw_sequencer_funcs dcn30_funcs =3D=
 {
>        .init_vm_ctx =3D dcn20_init_vm_ctx,
>        .set_flip_control_gsl =3D dcn20_set_flip_control_gsl,
>        .get_vupdate_offset_from_vsync =3D dcn10_get_vupdate_offset_from_v=
sync,
> +     .calc_vupdate_position =3D dcn10_calc_vupdate_position,
>        .apply_idle_power_optimizations =3D dcn30_apply_idle_power_optimiz=
ations,
>        .set_backlight_level =3D dcn21_set_backlight_level,
>        .set_abm_immediate_disable =3D dcn21_set_abm_immediate_disable,
> +     .set_pipe =3D dcn21_set_pipe,
>   };
>
>   static const struct hwseq_private_funcs dcn30_private_funcs =3D {
>


--_000_MW3PR12MB4554C21E1F3086D79AE91AEAF90C0MW3PR12MB4554namp_
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
Thanks,<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
.calc_vupdate_position : Used to help avoid cursor stuttering
<div>.set_pipe : Needed for setting abm<br>
</div>
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
WIll add these before pushing.<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Kazlauskas, Nicholas =
&lt;Nicholas.Kazlauskas@amd.com&gt;<br>
<b>Sent:</b> October 5, 2020 2:12 PM<br>
<b>To:</b> Lakha, Bhawanpreet &lt;Bhawanpreet.Lakha@amd.com&gt;; Deucher, A=
lexander &lt;Alexander.Deucher@amd.com&gt;<br>
<b>Cc:</b> rodrigo.siqOFueira@amd.com &lt;rodrigo.siqOFueira@amd.com&gt;; a=
md-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amd/display: Add missing function pointers =
for dcn3</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">On 2020-10-05 2:10 p.m., Bhawanpreet Lakha wrote:<=
br>
&gt; These function pointers are missing from dcn30_init<br>
&gt; <br>
&gt; .calc_vupdate_position<br>
&gt; .set_pipe<br>
&gt; <br>
&gt; So add them<br>
&gt; <br>
&gt; Signed-off-by: Bhawanpreet Lakha &lt;Bhawanpreet.Lakha@amd.com&gt;<br>
<br>
Reviewed-by: Nicholas Kazlauskas &lt;nicholas.kazlauskas@amd.com&gt;<br>
<br>
Would be good to mention what these are used for specifically though.<br>
<br>
The calc_vupdate_position in particular is used to help avoid cursor <br>
stuttering.<br>
<br>
Regards,<br>
Nicholas Kazlauskas<br>
<br>
&gt; ---<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.c | 2 ++<b=
r>
&gt;&nbsp;&nbsp; 1 file changed, 2 insertions(+)<br>
&gt; <br>
&gt; diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.c b/drive=
rs/gpu/drm/amd/display/dc/dcn30/dcn30_init.c<br>
&gt; index 7c90c2222506..dc312d4172af 100644<br>
&gt; --- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.c<br>
&gt; +++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.c<br>
&gt; @@ -90,9 +90,11 @@ static const struct hw_sequencer_funcs dcn30_funcs =
=3D {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .init_vm_ctx =3D dcn20_init_=
vm_ctx,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_flip_control_gsl =3D dc=
n20_set_flip_control_gsl,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_vupdate_offset_from_vsy=
nc =3D dcn10_get_vupdate_offset_from_vsync,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; .calc_vupdate_position =3D dcn10_calc_vupdat=
e_position,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .apply_idle_power_optimizati=
ons =3D dcn30_apply_idle_power_optimizations,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_backlight_level =3D dcn=
21_set_backlight_level,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_abm_immediate_disable =
=3D dcn21_set_abm_immediate_disable,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; .set_pipe =3D dcn21_set_pipe,<br>
&gt;&nbsp;&nbsp; };<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; static const struct hwseq_private_funcs dcn30_private_func=
s =3D {<br>
&gt; <br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MW3PR12MB4554C21E1F3086D79AE91AEAF90C0MW3PR12MB4554namp_--

--===============0135731010==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0135731010==--
