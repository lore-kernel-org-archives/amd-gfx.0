Return-Path: <SRS0=SqeI=EC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A1DEC64E8A
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2020 15:27:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8497206F4
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2020 15:27:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="CpTHJXxh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8497206F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 038346EB94;
	Tue, 27 Oct 2020 15:27:53 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2056.outbound.protection.outlook.com [40.107.236.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 468A86EB94
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Oct 2020 15:27:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oaw9H1EGAp6zBR6Cc0uZ34pPbXL5rWtwI7ZyrTZQ6YQXI71DwgP0NvnEJoHqKZEGKpo8te6tMx4BJxnzqZ+BgG5wh/apdbtY6R9eZNFS2xGXo2Ed7nLPo1E77V4bDFehJ2EJk4DRjIL77Wo+WbHVmOPA2iBD1OtqH7NsQ92iOxJP7GR76sjhlF6sNJpETbG0i3u4expbakjb48VxeRW869SPskDQydMOUy48k1XXqf9aPIw7pWxBRzw+niN79ru1fnI062izB9f66MXj4Wvkwgj2QZtfDyebFoJDcK9RgW/mfqAZT/RglcW0tGxZwo1B3fiY1ojtnLfy/Q2jkS9jmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5nEiskY1pEPo8JAJxtupFMH/fkPkwhoSqXq25/udynI=;
 b=ELoDIOH4dRW2eK2aLmqBauE+LzLN0Zgouybaae1pA5a1muVwgwVifY+cMO2fme+X6ztD3LxblyUmtQpgcMuJWjEgFVfvk3/oJLlptvYE1HwCK2SHim5EM8s06narYrDtqunEGOYoAD11/HBnrr+7x+MhrBGEeQqmLysoJs+gHWIYmDBODrzf4J7idhW4JT/yfi0mYfK+DXOI5fPeASrzxSxIpOueglXYSnUQVtET+JjDVK2Dfk/Jh6EzICqIN+Ez+TbpL46jaXRhBPzoAm3ZpQkcH5LuUD6ENsCmq/e5S9cxofHhC/+5MaOO95w8EC4Wv5hOGEwyx4zre5ERrBr6Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5nEiskY1pEPo8JAJxtupFMH/fkPkwhoSqXq25/udynI=;
 b=CpTHJXxhz0cTzpO73EKZhegULYLBVuGQieZMyczJNeGMo0SukNfEaxpluxjCZqDkGT5KUW3CGWGo23V9my6nN4Y+nb9NgG1ZtPdjR+bIXkE+kFc4sMHC7QcfkIrVn5tfoNNA/GrV4UsXgXDrPPlHPmGtAWaKcj/WOJ9tW86TlqI=
Received: from MWHPR12MB1629.namprd12.prod.outlook.com (2603:10b6:301:3::23)
 by MW2PR12MB2475.namprd12.prod.outlook.com (2603:10b6:907:3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.22; Tue, 27 Oct
 2020 15:27:49 +0000
Received: from MWHPR12MB1629.namprd12.prod.outlook.com
 ([fe80::6160:11b1:2c80:b56e]) by MWHPR12MB1629.namprd12.prod.outlook.com
 ([fe80::6160:11b1:2c80:b56e%11]) with mapi id 15.20.3499.018; Tue, 27 Oct
 2020 15:27:49 +0000
From: "Abramov, Slava" <Slava.Abramov@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, amd-gfx list
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu/display: re-add surface size calculation in
 dcn30_hwseq.c
Thread-Topic: [PATCH] drm/amdgpu/display: re-add surface size calculation in
 dcn30_hwseq.c
Thread-Index: AQHWq7MmSLG8n5A4PU6AOVnPkNVbuamrkeWAgAACBMM=
Date: Tue, 27 Oct 2020 15:27:49 +0000
Message-ID: <MWHPR12MB1629F72ECDD71E0C9B443CB2FE160@MWHPR12MB1629.namprd12.prod.outlook.com>
References: <20201026161436.978310-1-alexander.deucher@amd.com>,
 <CADnq5_Me2LV2Rp-gLhzqqc76y8ddXnmfuVu66BYZbo48L0ZREQ@mail.gmail.com>
In-Reply-To: <CADnq5_Me2LV2Rp-gLhzqqc76y8ddXnmfuVu66BYZbo48L0ZREQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-10-27T15:27:48.672Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [2607:9880:2f27:ffe4:adcc:36fc:ad8c:747f]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a70de9af-dad0-4b1e-2c3d-08d87a8cdce0
x-ms-traffictypediagnostic: MW2PR12MB2475:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW2PR12MB24758A002CB5856B805680EDFE160@MW2PR12MB2475.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1201;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lLdE1CqgpTGnCq20STCRfTDFOZlozVZApLakfHFc3DStpJzKOmkiOKBFsfTBCCZ3a0jB2brqa4Df64Qm6yp6GCG+KyxHbOrPsXHikhK7v6WUrW4jniX+Gd82hDl7UzD6zwZfxbJklaumdoEheeUNGrXEYDDzUkPM865WT2B897jLbrLhEZ3PlkpJHCvevI2PnT3oC4jC4/uA5Rvthmw4+wp5PpGZRKxecWpy1NcItWHdWAiuNaPmTy75SLDF28lfbkVRC+6kAYsG1LR5jxg42eaTzQKJOxjPHaRqoWgXv6S4/kS6Vzt1cRweB1dg2XPedKJClSANeDNeexw4nJduOoAFDujl6UwaIwom1GFWIR8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR12MB1629.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(376002)(366004)(346002)(136003)(52536014)(5660300002)(66476007)(71200400001)(186003)(19627405001)(110136005)(8936002)(66946007)(76116006)(86362001)(33656002)(4326008)(316002)(9686003)(91956017)(83380400001)(7696005)(53546011)(66556008)(478600001)(6506007)(8676002)(2906002)(66446008)(64756008)(166002)(45080400002)(55016002)(966005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: RjWygMywTj/qbSqD3pIsi6NGrAapZ5OtMI8pgbrDNCTS+nUiyHD6nZEYk3dRwmdz7mgd/GYZuy6gkRkeGm4V8dat9G46riP/VUs7ttXqey4zAzlS0X+K9EEyYShOV7RyQS/Hf+7F+NTCQP8Xr+RUwJUf7gnw/yvQgU4zn5WQBqFPn8ziSd0i9dNavq2ehfuWg4w83LSzLsSO3P0LQ9HazUkYvB72/aPpJmBkMLNlp2xC/HFzK116mWdqCQtOh5tHGGP0Vx8wnEYt0Y6qrjE+sViPUv2wb86LnXxpYvq0k15gKZe/pYq04cYB9EuGQXT6b2WDcnyfyDlH/HXnDSB2QPQmi2jI6lXCihaXLwEFIcH9PKHfwT+ccM+Go6hJnqL6Kitgi7gAOi/GNNMhO169Upm8i9+UyXXv1Z4qS507RmGhPrrZXlzIC/8ZCcq3sZkzxs/W3wNcb9xjbMO4+nMupZxGPc4UyjBfaq8FJu/B0rC/Xyk0GWb+lajIr4pEagPZ1Bfm69k+nnEfF67gRIBp49m1TTq/HBSgbJXiOeb3R6g+b8aloJB80dnoVvMbiJ55wrfXBJbyhxdmpBwSOWya4Kv+dHj16s+Jt0PjYdn/oSAGmF6VTxEX2fY2F6OqRXtbAPIJMICe370AZ6FDIRW5bt50rBcWMPn5oTWuYfrhCib0m3j5IraYIOOwyIcBLmulPgwbHB7sSuIsq+wcmle3XA==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1629.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a70de9af-dad0-4b1e-2c3d-08d87a8cdce0
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2020 15:27:49.2049 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bak7BymyH6qIaE7zWfxbP9cniYGxUy4FXMqRRAKYDrpM+mMnQvqCpWwA8+2SqpCr3N6gMZFkc4B/HmLj3ABERQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2475
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
Content-Type: multipart/mixed; boundary="===============1886840252=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1886840252==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MWHPR12MB1629F72ECDD71E0C9B443CB2FE160MWHPR12MB1629namp_"

--_000_MWHPR12MB1629F72ECDD71E0C9B443CB2FE160MWHPR12MB1629namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Looks sane to me.

Acked-by: Slava Abramov <slava.abramov@amd.com>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Alex Deu=
cher <alexdeucher@gmail.com>
Sent: Tuesday, October 27, 2020 11:20 AM
To: amd-gfx list <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: Re: [PATCH] drm/amdgpu/display: re-add surface size calculation in=
 dcn30_hwseq.c

Ping?

On Mon, Oct 26, 2020 at 12:14 PM Alex Deucher <alexdeucher@gmail.com> wrote=
:
>
> This is required for MALL.  Was accidently removed in PRS update.
>
> Fixes: 48e48e598478 ("drm/amd/display: Disable idle optimization when PSR=
 is enabled")
> Fixes: 52f2e83e2fe5 ("drm/amdgpu/display: add MALL support (v2)")
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  .../gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c    | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c b/drivers=
/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
> index f3ae208850b0..cc2eca8c9a62 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
> @@ -715,6 +715,21 @@ bool dcn30_apply_idle_power_optimizations(struct dc =
*dc, bool enable)
>                                         break;
>                         }
>
> +                       if (dc->current_state->stream_count =3D=3D 1 // s=
ingle display only
> +                           && dc->current_state->stream_status[0].plane_=
count =3D=3D 1 // single surface only
> +                           && dc->current_state->stream_status[0].plane_=
states[0]->address.page_table_base.quad_part =3D=3D 0 // no VM
> +                           // Only 8 and 16 bit formats
> +                           && dc->current_state->stream_status[0].plane_=
states[0]->format <=3D SURFACE_PIXEL_FORMAT_GRPH_ABGR16161616F
> +                           && dc->current_state->stream_status[0].plane_=
states[0]->format >=3D SURFACE_PIXEL_FORMAT_GRPH_ARGB8888) {
> +                               surface_size =3D dc->current_state->strea=
m_status[0].plane_states[0]->plane_size.surface_pitch *
> +                                       dc->current_state->stream_status[=
0].plane_states[0]->plane_size.surface_size.height *
> +                                       (dc->current_state->stream_status=
[0].plane_states[0]->format >=3D SURFACE_PIXEL_FORMAT_GRPH_ARGB16161616 ?
> +                                        8 : 4);
> +                       } else {
> +                               // TODO: remove hard code size
> +                               surface_size =3D 128 * 1024 * 1024;
> +                       }
> +
>                         // TODO: remove hard code size
>                         if (surface_size < 128 * 1024 * 1024) {
>                                 refresh_hz =3D div_u64((unsigned long lon=
g) dc->current_state->streams[0]->timing.pix_clk_100hz *
> --
> 2.25.4
>
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7Cslava.ab=
ramov%40amd.com%7Ce1c9b8c00a2e4a54ca2608d87a8bd178%7C3dd8961fe4884e608e11a8=
2d994e183d%7C0%7C0%7C637394088245930973%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4=
wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3D=
kRMXUEm5Y%2BkYhwBNWUrH6mm8dRYARwXjgXy%2BET4%2BaPk%3D&amp;reserved=3D0

--_000_MWHPR12MB1629F72ECDD71E0C9B443CB2FE160MWHPR12MB1629namp_
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
Looks sane to me.</div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt;=
 color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt;=
 color: rgb(0, 0, 0);">
Acked-by: Slava Abramov &lt;slava.abramov@amd.com&gt;</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Alex Deucher &lt;alexdeucher@=
gmail.com&gt;<br>
<b>Sent:</b> Tuesday, October 27, 2020 11:20 AM<br>
<b>To:</b> amd-gfx list &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu/display: re-add surface size calcula=
tion in dcn30_hwseq.c</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Ping?<br>
<br>
On Mon, Oct 26, 2020 at 12:14 PM Alex Deucher &lt;alexdeucher@gmail.com&gt;=
 wrote:<br>
&gt;<br>
&gt; This is required for MALL.&nbsp; Was accidently removed in PRS update.=
<br>
&gt;<br>
&gt; Fixes: 48e48e598478 (&quot;drm/amd/display: Disable idle optimization =
when PSR is enabled&quot;)<br>
&gt; Fixes: 52f2e83e2fe5 (&quot;drm/amdgpu/display: add MALL support (v2)&q=
uot;)<br>
&gt; Signed-off-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
&gt; ---<br>
&gt;&nbsp; .../gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c&nbsp;&nbsp;&nbsp;=
 | 15 +++++++++++++++<br>
&gt;&nbsp; 1 file changed, 15 insertions(+)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c b/driv=
ers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c<br>
&gt; index f3ae208850b0..cc2eca8c9a62 100644<br>
&gt; --- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c<br>
&gt; +++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c<br>
&gt; @@ -715,6 +715,21 @@ bool dcn30_apply_idle_power_optimizations(struct =
dc *dc, bool enable)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; break;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }=
<br>
&gt;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (dc-&gt;=
current_state-&gt;stream_count =3D=3D 1 // single display only<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; &amp;&amp; dc-&gt;current_state-&gt;stream_status[0].plane_cou=
nt =3D=3D 1 // single surface only<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; &amp;&amp; dc-&gt;current_state-&gt;stream_status[0].plane_sta=
tes[0]-&gt;address.page_table_base.quad_part =3D=3D 0 // no VM<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; // Only 8 and 16 bit formats<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; &amp;&amp; dc-&gt;current_state-&gt;stream_status[0].plane_sta=
tes[0]-&gt;format &lt;=3D SURFACE_PIXEL_FORMAT_GRPH_ABGR16161616F<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; &amp;&amp; dc-&gt;current_state-&gt;stream_status[0].plane_sta=
tes[0]-&gt;format &gt;=3D SURFACE_PIXEL_FORMAT_GRPH_ARGB8888) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; surface_size =3D dc-&gt;current_state-=
&gt;stream_status[0].plane_states[0]-&gt;plane_size.surface_pitch *<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; dc-&gt;current_state-&gt;stream_status[0].plane_states[0]-&gt;pla=
ne_size.surface_size.height *<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; (dc-&gt;current_state-&gt;stream_status[0].plane_states[0]-&gt;fo=
rmat &gt;=3D SURFACE_PIXEL_FORMAT_GRPH_ARGB16161616 ?<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; 8 : 4);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br=
>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // TODO: remove hard code size<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; surface_size =3D 128 * 1024 * 1024;<br=
>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /=
/ TODO: remove hard code size<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; i=
f (surface_size &lt; 128 * 1024 * 1024) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; refresh_hz =3D div_u64((unsi=
gned long long) dc-&gt;current_state-&gt;streams[0]-&gt;timing.pix_clk_100h=
z *<br>
&gt; --<br>
&gt; 2.25.4<br>
&gt;<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D04%=
7C01%7Cslava.abramov%40amd.com%7Ce1c9b8c00a2e4a54ca2608d87a8bd178%7C3dd8961=
fe4884e608e11a82d994e183d%7C0%7C0%7C637394088245930973%7CUnknown%7CTWFpbGZs=
b3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C10=
00&amp;amp;sdata=3DkRMXUEm5Y%2BkYhwBNWUrH6mm8dRYARwXjgXy%2BET4%2BaPk%3D&amp=
;amp;reserved=3D0">https://nam11.safelinks.protection.outlook.com/?url=3Dht=
tps%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;da=
ta=3D04%7C01%7Cslava.abramov%40amd.com%7Ce1c9b8c00a2e4a54ca2608d87a8bd178%7=
C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637394088245930973%7CUnknown%7C=
TWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0=
%3D%7C1000&amp;amp;sdata=3DkRMXUEm5Y%2BkYhwBNWUrH6mm8dRYARwXjgXy%2BET4%2BaP=
k%3D&amp;amp;reserved=3D0</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MWHPR12MB1629F72ECDD71E0C9B443CB2FE160MWHPR12MB1629namp_--

--===============1886840252==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1886840252==--
