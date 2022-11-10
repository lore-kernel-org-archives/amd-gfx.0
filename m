Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CC58C4332F
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Nov 2022 17:35:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8330C10E71D;
	Thu, 10 Nov 2022 17:35:14 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2089.outbound.protection.outlook.com [40.107.92.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3515110E748
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Nov 2022 17:35:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WHcQejpZGQq2hZU2l9HV3JHY9Nwtow+jZZE5wL++E9j8SJpl/b+0wkx/Ug8xI21URsE6j5IuhrioxCUwpJ6U7wgxAHifGo3sTomkK67W8Lk/19uLfENv1vahVtO9PLj2aUSNuV2Zi8zWWby37v5zZXxW94vWjfTMvyKDYRjYc92o9YnlVVqisfKhIUkfAtLP0FXAxIlMUmnczS/21oOBvQqEPI/HSjs3IlsZOZDPS2gLIXyYO50QRIars8LungFml/TBbCFQukNfACuHsJmDhjOMjnsGWRNZrtj80EnECdmW01jwyG6TzaeSbCmNvGA7yp+5ftyp1NoKUAfKkyW9GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=swL7eIGsoblZHoOxNxL/1mCNiZVaTqKlMIl5b4mxRVY=;
 b=JSrrVRJsfdgmilIXaEgZtR2Dcg8ll0N+zhwmyRLpqH/5Avcx9BkF2maSBAzRWt9vkIX3O4U9AYEj+gYgk7LB7Qoi3XDhVa5gxm6rgAh92CwbxeMquyMNRolcvAW6JEd+4dClMXeHMqG/rWbJrKnCbbWueDdhOG4BgBo2B6i9K+rgiLNUduN9BmlLa6owSsHBbL1CHYmn6VSR5Kcf3R/f+nLvkvgHdzkURiXGJXWwx9pcuWjjhVPBdVZv7RWFwVIBnO3SJsK/AV8KFpsWh8A5BOBI9GHjAm/7AltH58r4ej2Qsgl2BGBPwjtNlz7fXRR4jaC4E3+Jb+O4pRqKUTKHgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=swL7eIGsoblZHoOxNxL/1mCNiZVaTqKlMIl5b4mxRVY=;
 b=JolqbJQlPkXwGdii8kxpFKLRlEsOkH2vKqBnCD0FL/sVVvNzx3dR321j4KB2KSIyqyBubz02ULsfZk4Dl3zLP3nBo1Ui39SV9QY5al2KZcrn+8aH9JfBRSsNmhbVPoB/XHwggoGXZPqsEpfKbNR2c3T5B1QGyNXih18hZlt3jEg=
Received: from SN1PR12MB2445.namprd12.prod.outlook.com (2603:10b6:802:31::24)
 by DM4PR12MB7766.namprd12.prod.outlook.com (2603:10b6:8:101::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.25; Thu, 10 Nov
 2022 17:35:05 +0000
Received: from SN1PR12MB2445.namprd12.prod.outlook.com
 ([fe80::8d6a:8485:8508:aec7]) by SN1PR12MB2445.namprd12.prod.outlook.com
 ([fe80::8d6a:8485:8508:aec7%7]) with mapi id 15.20.5769.021; Thu, 10 Nov 2022
 17:35:05 +0000
From: "Liu, HaoPing (Alan)" <HaoPing.Liu@amd.com>
To: "Lee, Alvin" <Alvin.Lee2@amd.com>, Nathan Chancellor <nathan@kernel.org>
Subject: RE: [PATCH 11/22] drm/amd/display: Disable phantom OTG after enable
 for plane disable
Thread-Topic: [PATCH 11/22] drm/amd/display: Disable phantom OTG after enable
 for plane disable
Thread-Index: AQHY7tSyKmuqWvLw/kmbLutwOZWYBa44V3QAgAAePZA=
Date: Thu, 10 Nov 2022 17:35:05 +0000
Message-ID: <SN1PR12MB2445A00DE4368A98F724FC29F5019@SN1PR12MB2445.namprd12.prod.outlook.com>
References: <20221102160117.506511-1-HaoPing.Liu@amd.com>
 <20221102160117.506511-12-HaoPing.Liu@amd.com>
 <Y20bFlEcKX3gbge8@dev-arch.thelio-3990X>
In-Reply-To: <Y20bFlEcKX3gbge8@dev-arch.thelio-3990X>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: Alvin.Lee2@amd.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-11-10T17:35:00Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=acab5641-c21b-4bcf-9c58-055563ecc6af;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-11-10T17:35:00Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 5a75a354-f16d-4647-974f-54f4cb44fc53
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN1PR12MB2445:EE_|DM4PR12MB7766:EE_
x-ms-office365-filtering-correlation-id: dfe22882-783d-47d3-07e7-08dac341e7ba
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LkRmtmosJZzegoi0HbknvDfZMkJlwV36SmlJGuA9iPxGY8t/a81pQMWWBtjRKkV3EkjkYX6KR3w5lzxVYOnoc2pwxxMLDIEjahULak3Xpqcl+MKbiZgjQ9cIUoNHSFLv6pEi8Nugf0YYGRqrTHwGdBCgJpiJypsko2rznvyZoAWekMALcHU9nOZ28cRCLq54Z8av4pe/qiGjtEhxOtyplcz0p0WQe0euDAqBw3qCIsF08xQZIwMKPDz+Txl8R9JT9g+SdQejqnjZAtCnZYOCWMtLMlIdXeIhztOF2I9D10Np+fYCWgoDvFol0P4IuUhirtThYLwxnZj9oQ6effrdhYYKBDQwlbiI6puqtQDWGPWFixtBPnYcYxbKYujAT8MZaohUV5nUjAHwsxKBx8g79ZwKgsD8n9DRvV7knr/x3WgeBagBggetleOWnsACat5gKelku2212oVwHZ28+hj6kZ2HDt2nMe1kO9nGb6fiearbMIq4pLRtftdOSRr4g+w9K39fHDADARS3HQYTWdFaQ2Rr7mksk8jwGJPrDebcIXqeArwDHhpfsEvXji3NBG5z2/LWUXpQ3sIkgpmU/areo6Uc82cFt+96yGxD0qlUTyM3DMpeGEmaY4uSisXP7l8XsQekjB5lguGIEzWxJdYAUf1wn96ifl6aHAmssCtHCq5v+7guHMtXFE35Gl/pNxmc514g8NUcJOVTzVpNA3WCcprCgYyLi8cMDoTS0y7MHhJwjbLqnJyvBbUY6QE1h8WM4H0gnw1TFdYy46pVz3viTw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2445.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(366004)(396003)(136003)(39860400002)(376002)(451199015)(33656002)(55016003)(38070700005)(478600001)(26005)(66446008)(38100700002)(8936002)(122000001)(86362001)(52536014)(53546011)(4326008)(7696005)(64756008)(8676002)(186003)(76116006)(66556008)(41300700001)(66946007)(71200400001)(66476007)(5660300002)(83380400001)(54906003)(6506007)(110136005)(2906002)(316002)(9686003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?iK4zVLhdjaTQ+CY+utpaomXnipTHXSSunHVNbWWHGXJlUBcjCH8/49wp2Rmv?=
 =?us-ascii?Q?rwUbbPx+EiDOqEPkTOoSycBM2SwrnwuppQisHD/zw+K0fZf+QstOgzLTWDEC?=
 =?us-ascii?Q?7jgC2UK6PDs8Js50WLTrltl63rZ3FXjk00wmGk3QUR02W9n5UEuAEmzYrFkI?=
 =?us-ascii?Q?bW2WaIMk7pyp4CJ+Mwsc66QGOo76DniF1LlplmPKZNLRIoP/ZSvFEp2kowx7?=
 =?us-ascii?Q?BsJmMRekELPh2+UqaL+Ig2IJrEnx8t3pTbVRNfN9rQIZFgLoM8EpqwKFuHwl?=
 =?us-ascii?Q?7+r7ypqLQ+HZdVnYg/mPcATWYA6hw+Fy8ZfVCvUPRQ1lQuULohyGyiAZEW+g?=
 =?us-ascii?Q?TDhGrUa8hbF1M+1oZz7FfV8A/tJ1C+64tZE39jS2TK9ygjeYXZ8kLpAJeIqL?=
 =?us-ascii?Q?/JkPmV3HrOpKNHkOae5dFw/YOUnpFDAdg1TbOYchb42FYhvQPjBRz09ov7QT?=
 =?us-ascii?Q?YygnAxaCGPScKO0mXBW7/+BKAB55bD52JLtuLWPRfsgn/X/sFmtLt8gpcZJz?=
 =?us-ascii?Q?5/MrLOhmOCYM3qUzoi4b2WKRR5v0TTXTOPSQ0FAkQiB3+HBbsREQ097A7ZxF?=
 =?us-ascii?Q?jP6SLktZgEb5lMYY5KhuttRQdu/bqj2EepmuCgfY+2PWwYjaEb2cmJC6gv6U?=
 =?us-ascii?Q?i6wGM544h5Oc6Ws2wkMlZa87K+oExvqUljYJzVFhXBYQ+v5f6Hys2Qnwm6NN?=
 =?us-ascii?Q?OfLjySEXdOlN4TVZHm6gOt0tRjW6E653vsYfJw22hQtz3dhW6X9QwNVMCqTx?=
 =?us-ascii?Q?AaHCaZpFZGknNrjiaMrtqhgcCKdSdbJ4mN5cxDiSMmbV/9uboU83CNr5slCn?=
 =?us-ascii?Q?EfyDWBkNT2MhnE8sPSHJ86IWnL5w1ugXuT83JT+flUDk3XHmN+DlnefojGGK?=
 =?us-ascii?Q?4AEOVKM+Iwpsip/u+/AX3IC1PTr/S12jhsIyV9Hx7Y5s9cJjrzhkQdGgStKz?=
 =?us-ascii?Q?quTusZUrvavSzk7k5RGTJH6B9n0O9tvVBJolWz22gxFUauymoJ51uxFyc11K?=
 =?us-ascii?Q?YVXg9qnNXImr75oPuoMnXsW2gyFkqYjEpEwNlPUMlJUCDOozc6rLudkmCjaY?=
 =?us-ascii?Q?oOHrGlNPX5vv4gJSy0J4yT7tSwZlY0Sb3pp8TGPmNfBdWuZvuwp/5U+w5Sfh?=
 =?us-ascii?Q?7RP+SCsrL5g+Z2ANYuN4yUDYNV5O1Y9vzqPjtqP71e8g1DG4t2WJjyKB7tkN?=
 =?us-ascii?Q?GB5OGoBt4l4bH4ckMbUbLzdFh/pG4ukA8eC6nUXj5rK85zhhE/Nev1tDYJrA?=
 =?us-ascii?Q?Cls0MLlUpAZqTSEx2zSlcxMXi4ufKMs3iXosHqfcu/9NuxAevfrODrtp0Mp1?=
 =?us-ascii?Q?M5ROx29WE5b9tVkfDClZ2Eaxmsjlk9XaDQApWaCQosQy9s5OejLchQd9e2uO?=
 =?us-ascii?Q?EmKpHAbY+lH6FplV7T8a3PzeVmqw18UJa9alack8cesyW+0eJZltGNUAL8fS?=
 =?us-ascii?Q?NiVtJMHUHk62ktZi4tHCV6yU66v36lvbWvNagBZ1r3idXRXQ0TM86h/zqozS?=
 =?us-ascii?Q?k7qjVClJbpCz5Jeej42n9VZtpKRwnqcpFMs4o24796RHiPGgFPeI6+4bnOGh?=
 =?us-ascii?Q?J0uoOneRZcvA+30/6P1qe9L8BsrDB/Jq2F/0+41P?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2445.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfe22882-783d-47d3-07e7-08dac341e7ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2022 17:35:05.3896 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mCtXlojl0d7Wn9M6IbUtogJoRQVLGNw1eU0xLE2j01WvrFnTQFGgtDkS1FXJ3PRh8cXl5ONHKw48EkZ7Woqntg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7766
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
Cc: "Wang, Chao-kai \(Stylon\)" <Stylon.Wang@amd.com>, "Li,
 Sun peng \(Leo\)" <Sunpeng.Li@amd.com>, "Lakha, 
 Bhawanpreet" <Bhawanpreet.Lakha@amd.com>, "Zhuo,
 Qingqing \(Lillian\)" <Qingqing.Zhuo@amd.com>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>, "Li, Roman" <Roman.Li@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Chiu,
 Solomon" <Solomon.Chiu@amd.com>, "Pillai,
 Aurabindo" <Aurabindo.Pillai@amd.com>, "Lin, 
 Wayne" <Wayne.Lin@amd.com>, "Lei, Jun" <Jun.Lei@amd.com>, "Wentland,
 Harry" <Harry.Wentland@amd.com>, "Gutierrez,
 Agustin" <Agustin.Gutierrez@amd.com>, "Kotarac, Pavle" <Pavle.Kotarac@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Hi Nathan,
Thanks for reporting this issue.

Hi Alvin,
Please see inline.

-----Original Message-----
From: Nathan Chancellor <nathan@kernel.org>=20
Sent: Thursday, November 10, 2022 11:39 PM
To: Liu, HaoPing (Alan) <HaoPing.Liu@amd.com>
Cc: amd-gfx@lists.freedesktop.org; Wang, Chao-kai (Stylon) <Stylon.Wang@amd=
.com>; Li, Sun peng (Leo) <Sunpeng.Li@amd.com>; Wentland, Harry <Harry.Went=
land@amd.com>; Zhuo, Qingqing (Lillian) <Qingqing.Zhuo@amd.com>; Siqueira, =
Rodrigo <Rodrigo.Siqueira@amd.com>; Li, Roman <Roman.Li@amd.com>; Chiu, Sol=
omon <Solomon.Chiu@amd.com>; Pillai, Aurabindo <Aurabindo.Pillai@amd.com>; =
Lee, Alvin <Alvin.Lee2@amd.com>; Lin, Wayne <Wayne.Lin@amd.com>; Lei, Jun <=
Jun.Lei@amd.com>; Lakha, Bhawanpreet <Bhawanpreet.Lakha@amd.com>; Gutierrez=
, Agustin <Agustin.Gutierrez@amd.com>; Kotarac, Pavle <Pavle.Kotarac@amd.co=
m>
Subject: Re: [PATCH 11/22] drm/amd/display: Disable phantom OTG after enabl=
e for plane disable

Hi Alan,

On Thu, Nov 03, 2022 at 12:01:06AM +0800, Alan Liu wrote:
> From: Alvin Lee <Alvin.Lee2@amd.com>
>=20
> [Description]
> - Need to disable phantom OTG after it's enabled
>   in order to restore it to it's original state.
> - If it's enabled and then an MCLK switch comes in
>   we may not prefetch the correct data since the phantom
>   OTG could already be in the middle of the frame.
>=20
> Reviewed-by: Jun Lei <Jun.Lei@amd.com>
> Acked-by: Alan Liu <HaoPing.Liu@amd.com>
> Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
> ---
>  drivers/gpu/drm/amd/display/dc/core/dc.c           | 14 +++++++++++++-
>  drivers/gpu/drm/amd/display/dc/dcn32/dcn32_optc.c  |  8 ++++++++
>  .../drm/amd/display/dc/inc/hw/timing_generator.h   |  1 +
>  3 files changed, 22 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c=20
> b/drivers/gpu/drm/amd/display/dc/core/dc.c
> index da808996e21d..9c3704c4d7e4 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
> @@ -1055,6 +1055,7 @@ static void disable_dangling_plane(struct dc *dc, s=
truct dc_state *context)
>  	struct dc_state *dangling_context =3D dc_create_state(dc);
>  	struct dc_state *current_ctx;
>  	struct pipe_ctx *pipe;
> +	struct timing_generator *tg;
> =20
>  	if (dangling_context =3D=3D NULL)
>  		return;
> @@ -1098,6 +1099,7 @@ static void disable_dangling_plane(struct dc=20
> *dc, struct dc_state *context)
> =20
>  		if (should_disable && old_stream) {
>  			pipe =3D &dc->current_state->res_ctx.pipe_ctx[i];
> +			tg =3D pipe->stream_res.tg;
>  			/* When disabling plane for a phantom pipe, we must turn on the
>  			 * phantom OTG so the disable programming gets the double buffer
>  			 * update. Otherwise the pipe will be left in a partially disabled=20
> @@ -1105,7 +1107,8 @@ static void disable_dangling_plane(struct dc *dc, s=
truct dc_state *context)
>  			 * again for different use.
>  			 */
>  			if (old_stream->mall_stream_config.type =3D=3D SUBVP_PHANTOM) {
> -				pipe->stream_res.tg->funcs->enable_crtc(pipe->stream_res.tg);
> +				if (tg->funcs->enable_crtc)
> +					tg->funcs->enable_crtc(tg);
>  			}
>  			dc_rem_all_planes_for_stream(dc, old_stream, dangling_context);
>  			disable_all_writeback_pipes_for_stream(dc, old_stream,=20
> dangling_context); @@ -1122,6 +1125,15 @@ static void disable_dangling_pl=
ane(struct dc *dc, struct dc_state *context)
>  				dc->hwss.interdependent_update_lock(dc, dc->current_state, false);
>  				dc->hwss.post_unlock_program_front_end(dc, dangling_context);
>  			}
> +			/* We need to put the phantom OTG back into it's default (disabled) s=
tate or we
> +			 * can get corruption when transition from one SubVP config to a diff=
erent one.
> +			 * The OTG is set to disable on falling edge of VUPDATE so the plane =
disable
> +			 * will still get it's double buffer update.
> +			 */
> +			if (old_stream->mall_stream_config.type =3D=3D SUBVP_PHANTOM) {
> +				if (tg->funcs->disable_phantom_crtc)
> +					tg->funcs->disable_phantom_crtc(tg);
> +			}
>  		}
>  	}
> =20
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_optc.c=20
> b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_optc.c
> index 2b33eeb213e2..2ee798965bc2 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_optc.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_optc.c
> @@ -167,6 +167,13 @@ static void optc32_phantom_crtc_post_enable(struct t=
iming_generator *optc)
>  	REG_WAIT(OTG_CLOCK_CONTROL, OTG_BUSY, 0, 1, 100000);  }
> =20
> +static void optc32_disable_phantom_otg(struct timing_generator *optc)=20
> +{
> +	struct optc *optc1 =3D DCN10TG_FROM_TG(optc);
> +
> +	REG_UPDATE(OTG_CONTROL, OTG_MASTER_EN, 0); }
> +
>  static void optc32_set_odm_bypass(struct timing_generator *optc,
>  		const struct dc_crtc_timing *dc_crtc_timing)  { @@ -260,6 +267,7 @@=20
> static struct timing_generator_funcs dcn32_tg_funcs =3D {
>  		.enable_crtc =3D optc32_enable_crtc,
>  		.disable_crtc =3D optc32_disable_crtc,
>  		.phantom_crtc_post_enable =3D optc32_phantom_crtc_post_enable,
> +		.disable_phantom_crtc =3D optc32_disable_phantom_otg,
>  		/* used by enable_timing_synchronization. Not need for FPGA */
>  		.is_counter_moving =3D optc1_is_counter_moving,
>  		.get_position =3D optc1_get_position, diff --git=20
> a/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h=20
> b/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h
> index 65f18f9dad34..43eb61961e0f 100644
> --- a/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h
> +++ b/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h
> @@ -184,6 +184,7 @@ struct timing_generator_funcs {
>  	bool (*disable_crtc)(struct timing_generator *tg);  #ifdef=20
> CONFIG_DRM_AMD_DC_DCN
>  	void (*phantom_crtc_post_enable)(struct timing_generator *tg);
> +	void (*disable_phantom_crtc)(struct timing_generator *tg);

Hi @Lee, Alvin
I think we should move the above line out of #define CONFIG_DRM_AMD_DC_DCN,=
 right?
Thanks.

>  #endif
>  	bool (*immediate_disable_crtc)(struct timing_generator *tg);
>  	bool (*is_counter_moving)(struct timing_generator *tg);
> --
> 2.25.1
>=20
>=20

This breaks the build without CONFIG_DRM_AMD_DC_DCN:

  drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c:1134:20: error: no mem=
ber named 'disable_phantom_crtc' in 'struct timing_generator_funcs'
                                  if (tg->funcs->disable_phantom_crtc)
                                      ~~~~~~~~~  ^
  drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c:1135:17: error: no mem=
ber named 'disable_phantom_crtc' in 'struct timing_generator_funcs'
                                          tg->funcs->disable_phantom_crtc(t=
g);
                                          ~~~~~~~~~  ^
  2 errors generated.

Cheers,
Nathan
