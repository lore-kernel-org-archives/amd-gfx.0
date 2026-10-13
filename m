Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 340ADCC6B19
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Oct 2026 20:52:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE6F210EA23;
	Tue, 13 Oct 2026 20:52:38 +0000 (UTC)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013062.outbound.protection.outlook.com
 [40.93.196.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7316610EA23
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Oct 2026 20:52:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bgbyF8IvPrG82gVvlYLQ06bp2XGS6b9gW4EaEVvP/eD6SqbA2oOtFlQDSRVWwkT0R+uhcQmxeoaLYRd7xHX4ILXVAOfGfovvOCCr4ROj1sbIOae/NCd1H7Q8qkpAvULQc68aq8Pk4VGM4tUxmcfb6a+nbDlE32Ng4GHtiV+487Ai/zmdB5084xhjeG5j9XFSWD+x+Z5KNqYoZcMKkq6CPMPXqJSsF8CHopA2nNIRUBILo0KDbZF/YgjGJPkAEMln7RdGWbG6TCLP1rEgfWWNi/1271yLnjhZ+OmgLEitgSKBZPUxyiezu01spdGoq70pMImB7dodB1pDb+c5c/iRAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XfPHTIS6+PJRFGXpszHqqX/IKwmBiXZ6dvlYugZs7aw=;
 b=JNEj8lL90OQKe7eQVJ7yyv9FbfJjdd32PALH5yrJwskCytqgWKAcyu8kqizR2PqTcyspl0LJfN9VIFOvz+jgeOnKSavCFKIETnPNBzprTmDDYgRE8zNSBKYkES+1gb6pCg6n5sKvs+IoQIwBhs5WKpUtzif0ucTOl+PeXejEi7reCuaEOKi3xvyt6CSyc8d0pkjaO5GIdmnroM+azib3UJr4Oj3q2dBKszY0YCbgoVavCY2k4hyQe3QOWjmFJf/CkkENPakyh6ei97iVlW4Xzd6ua1+6RBG6quNlk3cB/ydXPdg3z57AxJWhKPvQhV4t5pRAeNv4MdiaEw4f7RHKlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XfPHTIS6+PJRFGXpszHqqX/IKwmBiXZ6dvlYugZs7aw=;
 b=AE1cY8AAQ7SzNXzdDhuXV8axt1G+Zh9J46nrX1/FES2N7JvEJxuH2JOuyqC/xIE0fuCXlP05Y1raR+xiqlRw93eqx+22Wkn77i0j3c6SOaf9hIG0mkEEhqIVgWbWA09ua3AHe5PSah2VWzk3ZGLlrY4TW20oVYn0UHxE266pVgg=
Received: from SAWPR12MB999117.namprd12.prod.outlook.com
 (2603:10b6:806:4e3::17) by CH3PR12MB7620.namprd12.prod.outlook.com
 (2603:10b6:610:150::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Tue, 13 Oct
 2026 20:52:27 +0000
Received: from SAWPR12MB999117.namprd12.prod.outlook.com
 ([fe80::2192:69bb:87bd:350b]) by SAWPR12MB999117.namprd12.prod.outlook.com
 ([fe80::2192:69bb:87bd:350b%6]) with mapi id 15.21.0522.011; Tue, 13 Oct 2026
 20:52:27 +0000
From: "Li, Roman" <Roman.Li@amd.com>
To: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>, "Hung, Alex"
 <Alex.Hung@amd.com>, "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, Dan
 Carpenter <error27@gmail.com>, "Kazlauskas, Nicholas"
 <Nicholas.Kazlauskas@amd.com>, "Kaszewski, Dominik"
 <Dominik.Kaszewski@amd.com>, "Zhang, George" <George.Zhang@amd.com>, "LIPSKI, 
 IVAN" <IVAN.LIPSKI@amd.com>, "Wheeler, Daniel" <Daniel.Wheeler@amd.com>,
 "Chung, ChiaHsuan (Tom)" <ChiaHsuan.Chung@amd.com>
Subject: RE: [PATCH v2] drm/amd/display: Fix NULL sink dereference in USB4
 bandwidth functions
Thread-Topic: [PATCH v2] drm/amd/display: Fix NULL sink dereference in USB4
 bandwidth functions
Thread-Index: AQHdRmvcKnxc5gi/DEK6XUjCB6n1Ybb8C/aw
Date: Tue, 13 Oct 2026 20:52:27 +0000
Message-ID: <SAWPR12MB9991174A31119D633ED9D7C687899E2@SAWPR12MB999117.namprd12.prod.outlook.com>
References: <20260917061433.623709-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20260917061433.623709-1-srinivasan.shanmugam@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Enabled=True;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SetDate=2026-10-13T19:52:50.0000000Z;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Name=AMD Public
 v26; MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_ContentBits=3;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Method=Privileged
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SAWPR12MB999117:EE_|CH3PR12MB7620:EE_
x-ms-office365-filtering-correlation-id: 31bb1c87-f30d-4415-c252-08df296be416
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|11063799006|38070700021|56012099006|18002099003|22082099003|6133799003|261009223027099003|10067099003;
x-microsoft-antispam-message-info: eep1dqEdANT4Eye9SKwR0vdc0DfkMKJ3x5u73tmqA0J18GVL8W18URyAlq3J5TvUjdBzENSLQc/LbB1UGuPP28XJZkDR8IIAggxajXNMJ+gyPmhRZ8oa/tWPv4DuMkyFMYpkwVahIrNDn6BgqYTBrI4g4lFD3T+4ipkFdrKb5k2z5Lwdy/ADt5RzGOqnyeLemQNbXHXqj1f65Iru6cmGm1pLdJkzFt8kNjN7ufxvuCFLeBlOdDBJUSk80flLW02rs5NCx2oHEYkW+qsmkO/IfntDXZiEnEbpQAhgdYnhKp7B6MPlGXDtVxfoMCwrE8SRARToogAMt6ocfOv9yBjwpCncu69R/xR88nHtRhEKvzjMyeHykQ2pal2lt+JydO2ja62y/PoQKPmlNtw10uP0Sfc/a7fMEKkT2tlVrv52aSO/GmSZFM9b54+aAtngoLMe6JEwYGPWQWNDu93jYEpVQrEcr5uSBL8t/n68C2F3fueDUeKyVgsY9KhK153YwwlpFUWjOQgWM0Dw14lVE1tzZXyc+Hrlvfy9NQmhxVYCieBMfhOAD8sdAdu3usTsA8zczTc/qmSjcemLYeVduAbJErD9svUHFtaHNE8eLg6hTzdeqgoUhLFpptxTga5p70V5SngmattAX9q4eFAZcWIXbniTALnp4I/48oxRWuKa5DyDHAk4717oO+D6DQ2Q8Lgr7ObXpGNZuDpz+A7S9G0+u58hLBP4qG82c3QB1C/54wY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SAWPR12MB999117.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(11063799006)(38070700021)(56012099006)(18002099003)(22082099003)(6133799003)(261009223027099003)(10067099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0lEEzP40f5XSiDZDE0MovdHL7SKmWYfcocaxy1/qoltFYBmlu4i5SzYLh7kn?=
 =?us-ascii?Q?7A/qlSTlksiTv8Tbg9r/z9sDjV7V3CGWD2ewnt9Gd7oW100xnz18yuD75NZj?=
 =?us-ascii?Q?nor1KPHCoQcfXeswDwpzavqviGuHj1FHR2c3FvBofY6gcGL7YUWQpDF39C5w?=
 =?us-ascii?Q?mdIRK573yxiTbwMST3IlcOTyVeyYC2TxMxX8kV5Fq6OgMuBUNLAMk5g1xJnQ?=
 =?us-ascii?Q?XJukd19LZakmnupGevrq6IWiyw4heJaSL6uafuh2jk688Bu/ECIUHqzrf9KC?=
 =?us-ascii?Q?faRSBBP3p43mQ9is2TlT3D1PNAZ91kGRPSu0Qfo7UG0Yh81IoAksDyzO5FcR?=
 =?us-ascii?Q?LDDMkHh6Qzp++wPpa4Jq5cI85OLjXM8eD1Y4+QeVPAyt+SqUlvGGXQMb89aD?=
 =?us-ascii?Q?I6ixTy5CagBgCPMwznHqsc38hIQMyB8QLTzBSXx26HuVWlR7CFchg+rIc4ub?=
 =?us-ascii?Q?d7nqWbvmQnJwnbelJOO6vYMnbi63xDMUjbBGj5aZMihPgmHAa/eoO5t8RxyK?=
 =?us-ascii?Q?KOJnZ5D4UGGfJ8BKFpr0M+I0kpxNq0sMl/b7g38ezQHc8jBB4e4iCcdfE+DN?=
 =?us-ascii?Q?32ECpNGNDIjlVX2XQlxDKqv8GB4oEBK5+fvsQbHchBPEgrZOm3bF/AISd7Z+?=
 =?us-ascii?Q?+pRem1PfMd4gORaHtVmpOmW0PugC6olMI7QqWArR7PTJiWFpjoR2lVNzGcRh?=
 =?us-ascii?Q?tOaejl0KW9a7/dMyAXjkta4NzjBnsCwQ9/1+dJ5Qaqo27erSUIb+CdnWVyhV?=
 =?us-ascii?Q?U/Qrx1IARQWctSyzPz3n07qHI+Z2rKXseH6ha5+xc7Z7e+WbHKQDCO2Zhq5Z?=
 =?us-ascii?Q?gycVq6wUKFWRBCwa3mw1CkIU4GCx/MWiuGIOPEDknnkEMRyEYjpQSR6P9HaB?=
 =?us-ascii?Q?KMUicdkTulKegybRLu1puw/hs3Wn3mXinKastwU1GjlOhgpb7QJ4bfydXsrd?=
 =?us-ascii?Q?UhMzlic5Cs/YEk9tl/UNmQkuqipfkCj/kxdQUPlyhZiS0IjRmbjdrI+Vx90g?=
 =?us-ascii?Q?NAtN1KmBAl4WyrpSGJ2AzLiqoHGC/mhMvaDjRn36d6nCDjia3tSBWUGJzWkk?=
 =?us-ascii?Q?6qW2jkCjjrFLax+StseQYGeG1r3KjwhDQ0aEuk2Gr5LmHWguoh4GOWBBd5Cj?=
 =?us-ascii?Q?W4yNYYMCCqDLF6xbb36oXEsgfTMazySh1xLjME6WYw+IUEh5Jp70Q2sa92n9?=
 =?us-ascii?Q?PTlydyoDdg9HO1c5QMZS3ed2lVy9Jw7wF7JaCNky0NAJHQES4meVV3aBMvVB?=
 =?us-ascii?Q?1sEvtDRSz4iP419hF/DpURbEsl3WUELVLPTH/GQMcbNGlWO2l29ETSdt63F/?=
 =?us-ascii?Q?TJqNGSR/VoGnHbMF1HTnKGrhXjtqBTLdEDTv5Nxuci1SU5m/9n1oqwYoe0qp?=
 =?us-ascii?Q?zXSll3fo3vnwFD2wOeN5DjDKkohDBxZ/OK2ymnkMUDiGPwlJer5kSJ6y2GLx?=
 =?us-ascii?Q?UEnnDlKncGns7TMgmWaYhh9zSKZd2CdwIv+0Zbs4eScb6scyu2EBGE0/BOh+?=
 =?us-ascii?Q?yvtwy0dbjSKZ9xCvK04n6tp8rUus5oFt4t7Fm4VTEHHB7zjbxb+C2CXG8s9v?=
 =?us-ascii?Q?YPVyKfEk77yVYYw8SWpWKxcoUfuRRe2o/wF6K7qvpuSicg2qt/kA0ZB6slWs?=
 =?us-ascii?Q?6qDnHs19HI5NKimygrWWqpHWXKTtEqaCPI0xA5QxuJapv1LBBGZpv+ouNA8u?=
 =?us-ascii?Q?4qqVrHa9PrS0rifs7wJTbNn7dOAJcYIN2Ru76hBzuL96/kzh?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SAWPR12MB999117.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31bb1c87-f30d-4415-c252-08df296be416
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2026 20:52:27.4565 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gInRUd37wTS4rpxaSZ53/iWqwv8Si5NhpkmTTuPWBRVJZe34N/kTiL6dUL1Va5B/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7620
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Public

Reviewed-by: Roman Li <roman.li@amd.com>

> -----Original Message-----
> From: SHANMUGAM, SRINIVASAN <SRINIVASAN.SHANMUGAM@amd.com>
> Sent: Thursday, September 17, 2026 2:15 AM
> To: Hung, Alex <Alex.Hung@amd.com>; Pillai, Aurabindo
> <Aurabindo.Pillai@amd.com>
> Cc: amd-gfx@lists.freedesktop.org; SHANMUGAM, SRINIVASAN
> <SRINIVASAN.SHANMUGAM@amd.com>; Dan Carpenter
> <error27@gmail.com>; Kazlauskas, Nicholas <Nicholas.Kazlauskas@amd.com>;
> Kaszewski, Dominik <Dominik.Kaszewski@amd.com>; Zhang, George
> <George.Zhang@amd.com>; Li, Roman <Roman.Li@amd.com>; LIPSKI, IVAN
> <IVAN.LIPSKI@amd.com>; Wheeler, Daniel <Daniel.Wheeler@amd.com>; Chung,
> ChiaHsuan (Tom) <ChiaHsuan.Chung@amd.com>
> Subject: [PATCH v2] drm/amd/display: Fix NULL sink dereference in USB4
> bandwidth functions
>
> allocate_usb4_bandwidth_for_stream() and allocate_usb4_bandwidth() both u=
se
> ASSERT(stream->sink) before dereferencing stream->sink->link. ASSERT is
> compiled out in production builds, so a NULL stream->sink causes a NULL p=
ointer
> dereference.
>
> link_set_dpms_off() already guards two earlier accesses to stream->sink w=
ith
> explicit NULL checks, confirming that stream->sink can legitimately be NU=
LL. The
> subsequent call to deallocate_usb4_bandwidth() had no equivalent guard.
>
> Replace the ASSERT() calls with proper NULL checks that return false earl=
y, and
> add a matching stream->sink guard at the call site in
> link_set_dpms_off() consistent with the surrounding pattern.
>
> v2: Keep the existing ASSERT() calls for diagnostics (to report
>     unexpected NULL sink), and add explicit NULL checks that return false
>     before dereferencing stream->sink. Also add a matching stream->sink
>     guard at the deallocation call site in link_set_dpms_off(). (Alex)
>
> Fixes: 06ab8d420454 ("drm/amd/display: Remove sink usage from DPMS")
> Reported-by: Dan Carpenter <error27@gmail.com>
> Cc: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
> Cc: Dominik Kaszewski <dominik.kaszewski@amd.com>
> Cc: George Zhang <george.zhang@amd.com>
> Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Cc: Roman Li <Roman.Li@amd.com>
> Cc: Ivan Lipski <ivan.lipski@amd.com>
> Cc: Dan Wheeler <daniel.wheeler@amd.com>
> Cc: Alex Hung <alex.hung@amd.com>
> Cc: Tom Chung <chiahsuan.chung@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>  .../gpu/drm/amd/display/dc/link/link_dpms.c    | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
> b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
> index 48b086d15ab0..25ec3d38a14e 100644
> --- a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
> +++ b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
> @@ -2306,9 +2306,14 @@ static bool allocate_usb4_bandwidth_for_stream(str=
uct
> dc_stream_state *stream, i  {
>       ASSERT(stream->sink);
>
> -     struct dc_link *link =3D stream->sink->link;
> +     struct dc_link *link;
>       int req_bw =3D stream_bw;
>
> +     if (!stream->sink)
> +             return false;
> +
> +     link =3D stream->sink->link;
> +
>       DC_LOGGER_INIT(link->ctx->logger);
>
>       if (!link->dpia_bw_alloc_config.bw_alloc_enabled)
> @@ -2355,9 +2360,13 @@ static bool allocate_usb4_bandwidth(struct
> dc_stream_state *stream)
>       ASSERT(stream->sink);
>
>       bool ret;
> +     int bw;
>
> -     int bw =3D dc_bandwidth_in_kbps_from_timing(&stream->timing,
> -                     dc_link_get_highest_encoding_format(stream->sink->l=
ink));
> +     if (!stream->sink)
> +             return false;
> +
> +     bw =3D dc_bandwidth_in_kbps_from_timing(&stream->timing,
> +
> dc_link_get_highest_encoding_format(stream->sink->link));
>
>       ret =3D allocate_usb4_bandwidth_for_stream(stream, bw);
>
> @@ -2419,7 +2428,8 @@ enum dc_status link_set_dpms_off(struct pipe_ctx
> *pipe_ctx)
>       update_psp_stream_config(pipe_ctx, true);
>       dc->hwss.blank_stream(pipe_ctx);
>
> -     if (pipe_ctx->link_config.dp_tunnel_settings.should_use_dp_bw_alloc=
ation)
> +     if (pipe_ctx->link_config.dp_tunnel_settings.should_use_dp_bw_alloc=
ation
> &&
> +         stream->sink)
>               deallocate_usb4_bandwidth(stream);
>
>       if (stream->signal =3D=3D SIGNAL_TYPE_DISPLAY_PORT_MST)
> --
> 2.34.1

