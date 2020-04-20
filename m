Return-Path: <SRS0=ehRF=6E=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24CD2C3815B
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Apr 2020 15:25:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7D6F20575
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Apr 2020 15:25:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="mM3p6e9g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7D6F20575
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 92A736E5BB;
	Mon, 20 Apr 2020 15:25:08 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2060.outbound.protection.outlook.com [40.107.94.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC7BE6E5BB
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Apr 2020 15:25:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j+Yw8vk0ZNfX3omLFC6kBjfYdxzwBOUfJ8zg12HhgWuZV/5e+We1+0MafChUsk6NYr597SkjKvGMORqqU/jiyZ659OW/84/T2Ltjph3Gnl8mpNYDJIuwzRtkcOMhKvV0YWLkY8XMCkdH/7muM9Y9GAXNNTkKpUafFdeZSBkrIy88GdhujlIGY1t2wl2iX+sb19Ar0Yh1D0AJzLfP7TE5zDP7vM6cuEgQpvq2u9NoMt1xGlVjZkz1leKsbFBGZxAUz/Cw5fOHCaQBVq03zgtY9HNx93QQYoM81AkL7Zcz8851C5gqq/dafgaHnMktEYNg7/ouYZut88zTaf82Fk4TZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r7XQRbD4VvCuFfvwwWRy5p7P0QtP1BlP+Rxy98XNM7w=;
 b=ZV3E1rDCe/jYgpvW5xentt4B+NZ2b83vnkuhPClnt6D7rfGO6Tp8Omo0nwYrciBSQ26zwkS4hQvmA4BW9lbkI1whNwKEwhoNvcuL+Ix4ZgezZ7dvOMxbawbY2fgKu8FlF0C53OiYFEVhANo6ysa+owBYZCwMLyKPfZR6DfqshHILXcFBYgsjcLPYoNJ+qAr/dXv27J6kkywMTFiV6mA39g02Z8WpJF7EOuAqE0AYCEDU4o4Hx+DAJnWym8nMnGWqd1LcjUARTfXJRqy3aTj77LczlIDcQJIeW8L5jcZ/xcWPhmCvVA9D9dVetr6+qC5K6QM8nrZFvINjJNLzlwmAHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r7XQRbD4VvCuFfvwwWRy5p7P0QtP1BlP+Rxy98XNM7w=;
 b=mM3p6e9gWxYngDxpI2PoVWRKeADKrQNCzsGY68mt9Du8YhFQ3Cbo4ISCYydki6GjSUIqfJsetllOvC00BFC2ZF+w23Jr3a/hAsc+avSVhysD4v434M8WG4M6noB6TwMKDY1gupYsInnQCggLBJ4BZpGdwc4PA7hxD8T2LX+2HMs=
Received: from CH2PR12MB4024.namprd12.prod.outlook.com (2603:10b6:610:2a::26)
 by CH2PR12MB4231.namprd12.prod.outlook.com (2603:10b6:610:7d::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.27; Mon, 20 Apr
 2020 15:25:06 +0000
Received: from CH2PR12MB4024.namprd12.prod.outlook.com
 ([fe80::45a5:8587:e2ee:9d6e]) by CH2PR12MB4024.namprd12.prod.outlook.com
 ([fe80::45a5:8587:e2ee:9d6e%3]) with mapi id 15.20.2921.027; Mon, 20 Apr 2020
 15:25:06 +0000
From: "Gravenor, Joseph" <Joseph.Gravenor@amd.com>
To: "Liu, Zhan" <Zhan.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amd/display: Remove aconnector condition check for
 dpcd read
Thread-Topic: [PATCH] drm/amd/display: Remove aconnector condition check for
 dpcd read
Thread-Index: AQHWFCSL8GlDJeaieEGa/sucEz3Iiqh9j1sQgASYDxo=
Date: Mon, 20 Apr 2020 15:25:06 +0000
Message-ID: <CH2PR12MB4024D70BF028338651D55280ECD40@CH2PR12MB4024.namprd12.prod.outlook.com>
References: <20200416192330.22317-1-zhan.liu@amd.com>,
 <BN8PR12MB29626235B1D6251BE680BFF69ED90@BN8PR12MB2962.namprd12.prod.outlook.com>
In-Reply-To: <BN8PR12MB29626235B1D6251BE680BFF69ED90@BN8PR12MB2962.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-04-20T15:25:08.709Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Joseph.Gravenor@amd.com; 
x-originating-ip: [65.92.13.212]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 35117c76-a8f9-41d9-ed7c-08d7e53f018f
x-ms-traffictypediagnostic: CH2PR12MB4231:|CH2PR12MB4231:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR12MB4231819620F95E0300931869ECD40@CH2PR12MB4231.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 03793408BA
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4024.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(346002)(136003)(39860400002)(376002)(366004)(396003)(9686003)(55016002)(8936002)(52536014)(110136005)(71200400001)(316002)(81156014)(8676002)(186003)(26005)(6506007)(2906002)(66556008)(7696005)(33656002)(478600001)(53546011)(66946007)(5660300002)(64756008)(66446008)(66476007)(86362001)(19627405001)(76116006);
 DIR:OUT; SFP:1101; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NMueqOAD9SvexVBD/26E1XbTDrt81oXjXC6XjnMbok/ni3LyVZs84EEMy/m/vZ3rKsUq8G7+kj9LecZmSnb/DYmnYezjhoHJeO6JQNEFcCMM+Ex4VgfEcVPy7Lxjtup9bpDYOSJK62ajSXG6E65+dwMPzNc2FFB8M4GTuc4d2SKkQpv2I6KuyoZrN6Ots8OAlPOB9j0/G/puzblI8hiAhl+8qoIpsl6q2crRLE6HIzNR1kZ1gsBnkog4mZWqDdVwEF3hwqHTQNDmhruJOpbyaryHybV6WwkRqAwn1wJLUlcA5tCMnS2cWydYbpW9+mxPrRC0GnFzeVzO/jjN0iCxI/RnhkM8tNEgqtfaTwSAPs6AbDHBv7ZEPcP7gKcKZo/yC891JSafDMCx/mtaDYLBiZ0TKGRlSnQ95CQKElEx/oKfMAf5YCUk1fud32hCaQUL
x-ms-exchange-antispam-messagedata: 62cKV0y6kD8oheH8qpSU8paShANapXfBNO4KAaww+bPpde0vERhnptRKzGsT/4MQEzFthIQJofwSVxPR5mkIKMX+W2uGx34iYMobzLObX90GwYtsMFTpEiBUHigNm73Q6qthVX12Bel4eIAQwJSPwg==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35117c76-a8f9-41d9-ed7c-08d7e53f018f
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2020 15:25:06.6465 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n36ZdB3d21fGiD/oo3epsS57WXi59NQ9d7+ZCpWe11U7+2k/Q4Z1Uk1Qkokvbrrjz6OIgafV+xBKQ2sljXJw+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4231
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
Content-Type: multipart/mixed; boundary="===============0354468803=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0354468803==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CH2PR12MB4024D70BF028338651D55280ECD40CH2PR12MB4024namp_"

--_000_CH2PR12MB4024D70BF028338651D55280ECD40CH2PR12MB4024namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Joseph Gravenor <Joseph.Gravenor@amd.com>
________________________________
From: Liu, Zhan <Zhan.Liu@amd.com>
Sent: Friday, April 17, 2020 1:17 PM
To: Liu, Zhan <Zhan.Liu@amd.com>; amd-gfx@lists.freedesktop.org <amd-gfx@li=
sts.freedesktop.org>; Gravenor, Joseph <Joseph.Gravenor@amd.com>
Subject: RE: [PATCH] drm/amd/display: Remove aconnector condition check for=
 dpcd read

+ Joseph



Hi Joseph,

Would you like to help me review this change? This was a follow-up on the d=
iscussion we had earlier this year.

Thanks,
Zhan


> -----Original Message-----
> From: Liu, Zhan <zhan.liu@amd.com>
> Sent: 2020/April/16, Thursday 3:24 PM
> To: amd-gfx@lists.freedesktop.org; Liu, Zhan <Zhan.Liu@amd.com>
> Subject: [PATCH] drm/amd/display: Remove aconnector condition check for
> dpcd read
>
> [Why]
> Aconnector is not necessary to be NULL in order to read dpcd successfully=
.
>
> Actually if we rely on checking aconnector here, we won't be able to turn=
 off
> all displays before doing display detection. That will cause some MST hub=
s
> not able to light up.
>
> [How]
> Remove aconnector check when turning off all displays at hardware
> initialization stage.
>
> Signed-off-by: Zhan Liu <zhan.liu@amd.com>
> ---
>  .../amd/display/dc/dcn10/dcn10_hw_sequencer.c | 36 ++++++++-----------
>  1 file changed, 14 insertions(+), 22 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
> b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
> index 9f41efddc9bc..6f33f3f0d023 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
> @@ -1332,31 +1332,23 @@ void dcn10_init_hw(struct dc *dc)
>                        if (dc->links[i]->connector_signal !=3D
> SIGNAL_TYPE_DISPLAY_PORT)
>                                continue;
>
> -                     /*
> -                      * core_link_read_dpcd() will invoke
> dm_helpers_dp_read_dpcd(),
> -                      * which needs to read dpcd info with the help of
> aconnector.
> -                      * If aconnector (dc->links[i]->prev) is NULL, then
> dpcd status
> -                      * cannot be read.
> -                      */
> -                     if (dc->links[i]->priv) {
> -                             /* if any of the displays are lit up turn t=
hem
> off */
> -                             status =3D core_link_read_dpcd(dc->links[i]=
,
> DP_SET_POWER,
> -
>        &dpcd_power_state, sizeof(dpcd_power_state));
> -                             if (status =3D=3D DC_OK && dpcd_power_state=
 =3D=3D
> DP_POWER_STATE_D0) {
> -                                     /* blank dp stream before power off
> receiver*/
> -                                     if (dc->links[i]->link_enc->funcs-
> >get_dig_frontend) {
> -                                             unsigned int fe =3D dc->lin=
ks[i]-
> >link_enc->funcs->get_dig_frontend(dc->links[i]->link_enc);
> -
> -                                             for (j =3D 0; j < dc->res_p=
ool-
> >stream_enc_count; j++) {
> -                                                     if (fe =3D=3D dc-
> >res_pool->stream_enc[j]->id) {
> -                                                             dc-
> >res_pool->stream_enc[j]->funcs->dp_blank(
> -
>                dc->res_pool->stream_enc[j]);
> -                                                             break;
> -                                                     }
> +                     /* if any of the displays are lit up turn them off =
*/
> +                     status =3D core_link_read_dpcd(dc->links[i],
> DP_SET_POWER,
> +                                                     &dpcd_power_state,
> sizeof(dpcd_power_state));
> +                     if (status =3D=3D DC_OK && dpcd_power_state =3D=3D
> DP_POWER_STATE_D0) {
> +                             /* blank dp stream before power off
> receiver*/
> +                             if (dc->links[i]->link_enc->funcs-
> >get_dig_frontend) {
> +                                     unsigned int fe =3D
> +dc->links[i]->link_enc->funcs->get_dig_frontend(dc->links[i]->link_enc)
> +;
> +
> +                                     for (j =3D 0; j < dc->res_pool-
> >stream_enc_count; j++) {
> +                                             if (fe =3D=3D dc->res_pool-
> >stream_enc[j]->id) {
> +                                                     dc->res_pool-
> >stream_enc[j]->funcs->dp_blank(
> +
>        dc->res_pool->stream_enc[j]);
> +                                                     break;
>                                                }
>                                        }
> -                                     dp_receiver_power_ctrl(dc->links[i]=
,
> false);
>                                }
> +                             dp_receiver_power_ctrl(dc->links[i], false)=
;
>                        }
>                }
>        }
> --
> 2.17.1


--_000_CH2PR12MB4024D70BF028338651D55280ECD40CH2PR12MB4024namp_
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
Reviewed-by: Joseph Gravenor &lt;Joseph.Gravenor@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Liu, Zhan &lt;Zhan.Li=
u@amd.com&gt;<br>
<b>Sent:</b> Friday, April 17, 2020 1:17 PM<br>
<b>To:</b> Liu, Zhan &lt;Zhan.Liu@amd.com&gt;; amd-gfx@lists.freedesktop.or=
g &lt;amd-gfx@lists.freedesktop.org&gt;; Gravenor, Joseph &lt;Joseph.Graven=
or@amd.com&gt;<br>
<b>Subject:</b> RE: [PATCH] drm/amd/display: Remove aconnector condition ch=
eck for dpcd read</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">&#43; Joseph<br>
<br>
<br>
<br>
Hi Joseph,<br>
<br>
Would you like to help me review this change? This was a follow-up on the d=
iscussion we had earlier this year.<br>
<br>
Thanks,<br>
Zhan<br>
<br>
<br>
&gt; -----Original Message-----<br>
&gt; From: Liu, Zhan &lt;zhan.liu@amd.com&gt;<br>
&gt; Sent: 2020/April/16, Thursday 3:24 PM<br>
&gt; To: amd-gfx@lists.freedesktop.org; Liu, Zhan &lt;Zhan.Liu@amd.com&gt;<=
br>
&gt; Subject: [PATCH] drm/amd/display: Remove aconnector condition check fo=
r<br>
&gt; dpcd read<br>
&gt; <br>
&gt; [Why]<br>
&gt; Aconnector is not necessary to be NULL in order to read dpcd successfu=
lly.<br>
&gt; <br>
&gt; Actually if we rely on checking aconnector here, we won't be able to t=
urn off<br>
&gt; all displays before doing display detection. That will cause some MST =
hubs<br>
&gt; not able to light up.<br>
&gt; <br>
&gt; [How]<br>
&gt; Remove aconnector check when turning off all displays at hardware<br>
&gt; initialization stage.<br>
&gt; <br>
&gt; Signed-off-by: Zhan Liu &lt;zhan.liu@amd.com&gt;<br>
&gt; ---<br>
&gt;&nbsp; .../amd/display/dc/dcn10/dcn10_hw_sequencer.c | 36 &#43;&#43;&#4=
3;&#43;&#43;&#43;&#43;&#43;-----------<br>
&gt;&nbsp; 1 file changed, 14 insertions(&#43;), 22 deletions(-)<br>
&gt; <br>
&gt; diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c=
<br>
&gt; b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c<br>
&gt; index 9f41efddc9bc..6f33f3f0d023 100644<br>
&gt; --- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequen=
cer.c<br>
&gt; @@ -1332,31 &#43;1332,23 @@ void dcn10_init_hw(struct dc *dc)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (dc-=
&gt;links[i]-&gt;connector_signal !=3D<br>
&gt; SIGNAL_TYPE_DISPLAY_PORT)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; continue;<br>
&gt; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * core_link_read_=
dpcd() will invoke<br>
&gt; dm_helpers_dp_read_dpcd(),<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * which needs to =
read dpcd info with the help of<br>
&gt; aconnector.<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * If aconnector (=
dc-&gt;links[i]-&gt;prev) is NULL, then<br>
&gt; dpcd status<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * cannot be read.=
<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (dc-&gt;links[i]-&gt=
;priv) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; /* if any of the displays are lit up turn them<br>
&gt; off */<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; status =3D core_link_read_dpcd(dc-&gt;links[i],<br=
>
&gt; DP_SET_POWER,<br>
&gt; -<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;dpcd_power_state, sizeo=
f(dpcd_power_state));<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; if (status =3D=3D DC_OK &amp;&amp; dpcd_power_stat=
e =3D=3D<br>
&gt; DP_POWER_STATE_D0) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*=
 blank dp stream before power off<br>
&gt; receiver*/<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if=
 (dc-&gt;links[i]-&gt;link_enc-&gt;funcs-<br>
&gt; &gt;get_dig_frontend) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int fe =3D dc-&gt;li=
nks[i]-<br>
&gt; &gt;link_enc-&gt;funcs-&gt;get_dig_frontend(dc-&gt;links[i]-&gt;link_e=
nc);<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (j =3D 0; j &lt; dc-&gt;r=
es_pool-<br>
&gt; &gt;stream_enc_count; j&#43;&#43;) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; if (fe =3D=3D dc-<br>
&gt; &gt;res_pool-&gt;stream_enc[j]-&gt;id) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dc-<br>
&gt; &gt;res_pool-&gt;stream_enc[j]-&gt;funcs-&gt;dp_blank(<br>
&gt; -<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; dc-&gt;res_pool-&gt;stream_enc[j]);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<b=
r>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* if any of the di=
splays are lit up turn them off */<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; status =3D core_lin=
k_read_dpcd(dc-&gt;links[i],<br>
&gt; DP_SET_POWER,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; &amp;dpcd_power_state,<br>
&gt; sizeof(dpcd_power_state));<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (status =3D=3D D=
C_OK &amp;&amp; dpcd_power_state =3D=3D<br>
&gt; DP_POWER_STATE_D0) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; /* blank dp stream before power off<br>
&gt; receiver*/<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; if (dc-&gt;links[i]-&gt;link_enc-&gt;funcs-<br=
>
&gt; &gt;get_dig_frontend) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; unsigned int fe =3D<br>
&gt; &#43;dc-&gt;links[i]-&gt;link_enc-&gt;funcs-&gt;get_dig_frontend(dc-&g=
t;links[i]-&gt;link_enc)<br>
&gt; &#43;;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; for (j =3D 0; j &lt; dc-&gt;res_pool-<br>
&gt; &gt;stream_enc_count; j&#43;&#43;) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (fe =3D=3D dc-&gt;res_=
pool-<br>
&gt; &gt;stream_enc[j]-&gt;id) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; dc-&gt;res_pool-<br>
&gt; &gt;stream_enc[j]-&gt;funcs-&gt;dp_blank(<br>
&gt; &#43;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dc-&gt;res_pool-&gt;stream_e=
nc[j]);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; }<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dp=
_receiver_power_ctrl(dc-&gt;links[i],<br>
&gt; false);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; dp_receiver_power_ctrl(dc-&gt;links[i], false)=
;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; --<br>
&gt; 2.17.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_CH2PR12MB4024D70BF028338651D55280ECD40CH2PR12MB4024namp_--

--===============0354468803==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0354468803==--
