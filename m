Return-Path: <SRS0=Guv+=FB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E601C2D0E4
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Nov 2020 16:00:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9206C208D5
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Nov 2020 16:00:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="SqG1gbOa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9206C208D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A9236EE48;
	Fri, 27 Nov 2020 16:00:11 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2075.outbound.protection.outlook.com [40.107.220.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 88D436EE48
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Nov 2020 16:00:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tw0XxFS/GczeDPttCqOSJczYj/TiL1nCSp56y6g58fqp/3K6x8lzvjwtZrhZwAuvAnZWmKqNwqb+A54PIExjntBTmfS1jOQY0ndOU0BtZI6gGFVxCt9CIN33frsqNDggK2PyQY027pVznO3puwuz9f6OIddpNvm699darlT3aocYB/1MF+lV0IeXi4pRASkCoLd5STKFTHC1Uim0yX5IKmCfqE9+wEBTa0D2vLIwMsxXq40Xf+rIvj4CZ0j1Eri9VSGGmz+Jxx5JFY1zH8MIqb2o+4G9absXkLdetOLsnrB6qSzbmjHmHwurNm0/+MvCdBQeuWdcyfweQrBqz5/V2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FVXN8ay4ybtm6UasWf8VoW/VsZsrKmWNYpGcRk/Ze4Y=;
 b=a0ARcHgqbajqa3Wk/Q5447RksgaGQH0lj88hu8+rdr3lZX1pLcJ/L8Y1c9yEIS7UUVsbwXdRl5eR5NOuhJrXPgyRg63g1YSBlfUQow3V7XqkGONbtMoQB23ryi3peMDdB0xyhXVqJiVvqs02rzkJfKDj5moVNGlzCv3Yd8RLbqRbGHsgBOE8K9OeScpDFMp/945O3Ai1ONz1ZPewYxa2xarBoTKpL/sOmJJd8766od/ZjWItP1YFpklC1mzKmpSq/DkUKkwJP8NaFstMB3mOSMpxI+1nNXrR/aVuAKFhS9BkqqJ8vmWKNoQIZA7PgGZXmG0dCnPlZ23v8/g1LoRpbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FVXN8ay4ybtm6UasWf8VoW/VsZsrKmWNYpGcRk/Ze4Y=;
 b=SqG1gbOahG1LuuzaDDaGKH0/EcidvQWKyzGWAoRqlirbEyW3Mk9myvOjV8vQ1thpl0E8iPufilluX7crTPuTVnhfv1W50zKxnusgSZ6ndQB7MdL7l9pJa89RkZus0Xk0xDnG2rK989Sapemkx9WdlL+IEdHM9zZRs4GNK9yyrh0=
Received: from BN6PR12MB1939.namprd12.prod.outlook.com (2603:10b6:404:107::12)
 by BN8PR12MB3363.namprd12.prod.outlook.com (2603:10b6:408:48::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.21; Fri, 27 Nov
 2020 16:00:05 +0000
Received: from BN6PR12MB1939.namprd12.prod.outlook.com
 ([fe80::f8f7:573f:9fae:e40c]) by BN6PR12MB1939.namprd12.prod.outlook.com
 ([fe80::f8f7:573f:9fae:e40c%11]) with mapi id 15.20.3611.023; Fri, 27 Nov
 2020 16:00:04 +0000
From: "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>
To: "Kazlauskas, Nicholas" <Nicholas.Kazlauskas@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH v3] drm/amd/display: turn DPMS off on mst connector unplug
Thread-Topic: [PATCH v3] drm/amd/display: turn DPMS off on mst connector unplug
Thread-Index: AQHWxFLjFuacaw6PiUSHtjevYKspsqncH9AAgAAEMOo=
Date: Fri, 27 Nov 2020 16:00:04 +0000
Message-ID: <BN6PR12MB19394C6ACEA74A16EE567CE78BF80@BN6PR12MB1939.namprd12.prod.outlook.com>
References: <20201127001844.367041-1-aurabindo.pillai@amd.com>,
 <a4c1f5b2-5e1e-fcd6-ca1d-a906c38b51e7@amd.com>
In-Reply-To: <a4c1f5b2-5e1e-fcd6-ca1d-a906c38b51e7@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-11-27T16:00:04.191Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.55.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c72cd7ab-91dc-4e7b-6dfc-08d892ed8162
x-ms-traffictypediagnostic: BN8PR12MB3363:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN8PR12MB3363D367AE8303090513B00F8BF80@BN8PR12MB3363.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aeMI0MPBVB4h5nBnguyw5dM7OaaovoAsVrA1eRm78lQLGMz1QZdxz50pd73156ebB0pQb3FWulwgdyNIFUecN1YXdyk9+fWVkAChrmfsnb6S7d8I5oDGUHETNAaRUi26KgURsMSObHQRZMFSH7axzV0cO5cHXpA9x2ShG61xrC6nKVufZszRv3xaGo7rTztmhpPlNNk4eVemkAh/jhBlct1j4mhVEbjZVdVSy8BDgqCPHhA73lqazSQtgz7Wzqc+nhA8NT3Xhxe16hyuNBkn8YyEr01Dw4AKTt3thukyTnxiSrIcjakGEs21YpJlyGRSNDqjh7GGltjmheqAc6ssSg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN6PR12MB1939.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(376002)(396003)(136003)(366004)(64756008)(66446008)(66946007)(66556008)(86362001)(8676002)(5660300002)(33656002)(6506007)(52536014)(2906002)(66476007)(4001150100001)(53546011)(7696005)(71200400001)(9686003)(4326008)(8936002)(19627405001)(83380400001)(186003)(55016002)(91956017)(54906003)(478600001)(26005)(76116006)(110136005)(316002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?lMSWK+f3vrVAKfPESRXteyxIs2GridZz3vCoDreFQUiRvanDN574tSwBEbJE?=
 =?us-ascii?Q?xloXvXbJC6xTzv6PxLnfl/a19I750ADkuf9yKYChUxutOaI5RtS+LWUR7Ggr?=
 =?us-ascii?Q?YL9lqpW1L8fbOpX38QrLAsmkm2KZbKj9Ut5WgGc9lEU8Z8XkwO5MGDC0PcpA?=
 =?us-ascii?Q?pWUCqvmuoMaIis6Kq1Bz6LKrHLDgOlLh7aZbu8nW9kT0TJS3eYRBYPwwTlfb?=
 =?us-ascii?Q?k1ojWujR17ynCZ8b6QFq8ivaR8IsG1CsvfuDb+SG4PRyJgdSmst843UyikYY?=
 =?us-ascii?Q?ntfC/VAoL1TIOmeO0vFSRqSD7D5oVTM0FzhgLn1fUZd+SyWkdVZqc9pJcKi7?=
 =?us-ascii?Q?osI/M30DDanl7+St5d5PbDQoK/qupz+ub4Bkdueu9diG5qsyCm7uEQRRlzh1?=
 =?us-ascii?Q?mEXiuUxPwcmOgz3LZG4lZmmBE6bss7g64hf9qUU2BZCrSAmh5kx8l1YvA3Si?=
 =?us-ascii?Q?cs3sLt6KHMjruD20gf5BGg1RQxOavdgu525zTUsv3kjVolEPau1hHW1/xpLP?=
 =?us-ascii?Q?Kr72FLfLINMgm+eSFKuesyubnocApFfUmF29PSstd+wZ+bydmM04uo96jMN7?=
 =?us-ascii?Q?YGWeaQb+lYx1L+7D5LgwsyUeh3a/TuNtXJdrfq5qyMDJlOXYYp2+Eu/2FAxz?=
 =?us-ascii?Q?u0EBn8dCH4MO88n7RlqkI8hyjPxvd+2Jrl1SAUb21E4jOxZAdr5CindmrVqi?=
 =?us-ascii?Q?4f4zns4h4HEvgKVotDXlxwFY7RP8R+Yy17fxBDsvERZxR2yQNn/9O+E9xV3c?=
 =?us-ascii?Q?BkI7IyBbN1jctsVKIRPgD45RjHaQGEU2yeW2VyBrGje+MIx+R+14SMz9u2Ar?=
 =?us-ascii?Q?GD75pPXdPEZKor4QYCJEyXVuH18Huxe93nLwtPHH4nsQcyLh3rSgasArl5Ti?=
 =?us-ascii?Q?SNAGm+L5NA6YoPynOESllLAz9iBfp5rqgM+yMlaRKktxpZNyCia6jqjDuavV?=
 =?us-ascii?Q?/bUNM4N1AwU6N3Nrgl6J0sttF0rt4/1wkRThQsEa8k0=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR12MB1939.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c72cd7ab-91dc-4e7b-6dfc-08d892ed8162
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2020 16:00:04.6402 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YrfNHgfiL4nR4tHD2AzzcyOxMrwxMGMST/48KZpP6MfORG9ccppMjRfj9qhoLWmEn8EPZq6XaT9hPBnsjGv/tQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3363
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
Cc: "Lakha, Bhawanpreet" <Bhawanpreet.Lakha@amd.com>, "Wentland,
 Harry" <Harry.Wentland@amd.com>, "Brol, Eryk" <Eryk.Brol@amd.com>
Content-Type: multipart/mixed; boundary="===============0674875532=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0674875532==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB19394C6ACEA74A16EE567CE78BF80BN6PR12MB1939namp_"

--_000_BN6PR12MB19394C6ACEA74A16EE567CE78BF80BN6PR12MB1939namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Thank you very much for the review!

--

Thanks & Regards,
Aurabindo Pillai
________________________________
From: Kazlauskas, Nicholas <Nicholas.Kazlauskas@amd.com>
Sent: Friday, November 27, 2020 10:44 AM
To: Pillai, Aurabindo <Aurabindo.Pillai@amd.com>; amd-gfx@lists.freedesktop=
.org <amd-gfx@lists.freedesktop.org>
Cc: Wentland, Harry <Harry.Wentland@amd.com>; Lakha, Bhawanpreet <Bhawanpre=
et.Lakha@amd.com>; Brol, Eryk <Eryk.Brol@amd.com>
Subject: Re: [PATCH v3] drm/amd/display: turn DPMS off on mst connector unp=
lug

On 2020-11-26 7:18 p.m., Aurabindo Pillai wrote:
> [Why&How]
>
> Set dpms off on the MST connector that was unplugged, for the side effect=
 of
> releasing some references held through deallocation of mst payload.

Applies to non-MST now too, so the description and title should be updated.

>
> Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Signed-off-by: Eryk Brol <eryk.brol@amd.com>
> ---
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 31 ++++++++++++++++++-
>   drivers/gpu/drm/amd/display/dc/core/dc.c      | 13 ++++++++
>   drivers/gpu/drm/amd/display/dc/dc_stream.h    |  1 +
>   3 files changed, 44 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/=
gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index e213246e3f04..9966679d29e7 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -1984,6 +1984,32 @@ static void dm_gpureset_commit_state(struct dc_sta=
te *dc_state,
>        return;
>   }
>
> +static void dm_set_dpms_off(struct dc_link *link)
> +{
> +     struct dc_stream_state *stream_state;
> +     struct amdgpu_dm_connector *aconnector =3D link->priv;
> +     struct amdgpu_device *adev =3D drm_to_adev(aconnector->base.dev);
> +     struct dc_stream_update stream_update =3D {0};

Please use a memset instead of a zero initializer here. Some compilers
complain about that.

> +     bool dpms_off =3D true;
> +
> +     stream_update.dpms_off =3D &dpms_off;
> +
> +     mutex_lock(&adev->dm.dc_lock);
> +     stream_state =3D dc_stream_find_from_link(link);
> +
> +     if (stream_state =3D=3D NULL) {
> +             dm_error("Error finding stream state associated with link!\=
n");

This shouldn't be using a dm_error print here. a DRM_DEBUG_DRIVER would
be better suited.

With these three items fixed the v4 of this patch will be:

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

Regards,
Nicholas Kazlauskas

> +             mutex_unlock(&adev->dm.dc_lock);
> +             return;
> +     }
> +
> +     stream_update.stream =3D stream_state;
> +     dc_commit_updates_for_stream(stream_state->ctx->dc, NULL, 0,
> +                                  stream_state, &stream_update,
> +                                  stream_state->ctx->dc->current_state);
> +     mutex_unlock(&adev->dm.dc_lock);
> +}
> +
>   static int dm_resume(void *handle)
>   {
>        struct amdgpu_device *adev =3D handle;
> @@ -2434,8 +2460,11 @@ static void handle_hpd_irq(void *param)
>                        drm_kms_helper_hotplug_event(dev);
>
>        } else if (dc_link_detect(aconnector->dc_link, DETECT_REASON_HPD))=
 {
> -             amdgpu_dm_update_connector_after_detect(aconnector);
> +             if (new_connection_type =3D=3D dc_connection_none &&
> +                 aconnector->dc_link->type =3D=3D dc_connection_none)
> +                     dm_set_dpms_off(aconnector->dc_link);
>
> +             amdgpu_dm_update_connector_after_detect(aconnector);
>
>                drm_modeset_lock_all(dev);
>                dm_restore_drm_connector_state(dev, connector);
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/a=
md/display/dc/core/dc.c
> index 903353389edb..58eb0d69873a 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
> @@ -2798,6 +2798,19 @@ struct dc_stream_state *dc_get_stream_at_index(str=
uct dc *dc, uint8_t i)
>        return NULL;
>   }
>
> +struct dc_stream_state *dc_stream_find_from_link(const struct dc_link *l=
ink)
> +{
> +     uint8_t i;
> +     struct dc_context *ctx =3D link->ctx;
> +
> +     for (i =3D 0; i < ctx->dc->current_state->stream_count; i++) {
> +             if (ctx->dc->current_state->streams[i]->link =3D=3D link)
> +                     return ctx->dc->current_state->streams[i];
> +     }
> +
> +     return NULL;
> +}
> +
>   enum dc_irq_source dc_interrupt_to_irq_source(
>                struct dc *dc,
>                uint32_t src_id,
> diff --git a/drivers/gpu/drm/amd/display/dc/dc_stream.h b/drivers/gpu/drm=
/amd/display/dc/dc_stream.h
> index bf090afc2f70..b7910976b81a 100644
> --- a/drivers/gpu/drm/amd/display/dc/dc_stream.h
> +++ b/drivers/gpu/drm/amd/display/dc/dc_stream.h
> @@ -292,6 +292,7 @@ void dc_stream_log(const struct dc *dc, const struct =
dc_stream_state *stream);
>
>   uint8_t dc_get_current_stream_count(struct dc *dc);
>   struct dc_stream_state *dc_get_stream_at_index(struct dc *dc, uint8_t i=
);
> +struct dc_stream_state *dc_stream_find_from_link(const struct dc_link *l=
ink);
>
>   /*
>    * Return the current frame counter.
>


--_000_BN6PR12MB19394C6ACEA74A16EE567CE78BF80BN6PR12MB1939namp_
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
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
Thank you very much for the review!<br>
</div>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"Signature">
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
--</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Thanks &amp; Regards,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Aurabindo Pillai<br>
</div>
</div>
</div>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Kazlauskas, Nicholas =
&lt;Nicholas.Kazlauskas@amd.com&gt;<br>
<b>Sent:</b> Friday, November 27, 2020 10:44 AM<br>
<b>To:</b> Pillai, Aurabindo &lt;Aurabindo.Pillai@amd.com&gt;; amd-gfx@list=
s.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Wentland, Harry &lt;Harry.Wentland@amd.com&gt;; Lakha, Bhawanpre=
et &lt;Bhawanpreet.Lakha@amd.com&gt;; Brol, Eryk &lt;Eryk.Brol@amd.com&gt;<=
br>
<b>Subject:</b> Re: [PATCH v3] drm/amd/display: turn DPMS off on mst connec=
tor unplug</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">On 2020-11-26 7:18 p.m., Aurabindo Pillai wrote:<b=
r>
&gt; [Why&amp;How]<br>
&gt; <br>
&gt; Set dpms off on the MST connector that was unplugged, for the side eff=
ect of<br>
&gt; releasing some references held through deallocation of mst payload.<br=
>
<br>
Applies to non-MST now too, so the description and title should be updated.=
<br>
<br>
&gt; <br>
&gt; Signed-off-by: Aurabindo Pillai &lt;aurabindo.pillai@amd.com&gt;<br>
&gt; Signed-off-by: Eryk Brol &lt;eryk.brol@amd.com&gt;<br>
&gt; ---<br>
&gt;&nbsp;&nbsp; .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 31 +++++++=
+++++++++++-<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/display/dc/core/dc.c&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; | 13 ++++++++<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/display/dc/dc_stream.h&nbsp;&nbsp;&nbs=
p; |&nbsp; 1 +<br>
&gt;&nbsp;&nbsp; 3 files changed, 44 insertions(+), 1 deletion(-)<br>
&gt; <br>
&gt; diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drive=
rs/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
&gt; index e213246e3f04..9966679d29e7 100644<br>
&gt; --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
&gt; +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
&gt; @@ -1984,6 +1984,32 @@ static void dm_gpureset_commit_state(struct dc_=
state *dc_state,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;<br>
&gt;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt; +static void dm_set_dpms_off(struct dc_link *link)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; struct dc_stream_state *stream_state;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_dm_connector *aconnector =3D l=
ink-&gt;priv;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D drm_to_adev(a=
connector-&gt;base.dev);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; struct dc_stream_update stream_update =3D {0=
};<br>
<br>
Please use a memset instead of a zero initializer here. Some compilers <br>
complain about that.<br>
<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; bool dpms_off =3D true;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; stream_update.dpms_off =3D &amp;dpms_off;<br=
>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;adev-&gt;dm.dc_lock);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; stream_state =3D dc_stream_find_from_link(li=
nk);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (stream_state =3D=3D NULL) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; dm_error(&quot;Error finding stream state associated with link!\n&quot;=
);<br>
<br>
This shouldn't be using a dm_error print here. a DRM_DEBUG_DRIVER would <br=
>
be better suited.<br>
<br>
With these three items fixed the v4 of this patch will be:<br>
<br>
Reviewed-by: Nicholas Kazlauskas &lt;nicholas.kazlauskas@amd.com&gt;<br>
<br>
Regards,<br>
Nicholas Kazlauskas<br>
<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; mutex_unlock(&amp;adev-&gt;dm.dc_lock);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; stream_update.stream =3D stream_state;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; dc_commit_updates_for_stream(stream_state-&g=
t;ctx-&gt;dc, NULL, 0,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stream_state, &amp;s=
tream_update,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stream_state-&gt;ctx=
-&gt;dc-&gt;current_state);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;adev-&gt;dm.dc_lock);<br>
&gt; +}<br>
&gt; +<br>
&gt;&nbsp;&nbsp; static int dm_resume(void *handle)<br>
&gt;&nbsp;&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =
=3D handle;<br>
&gt; @@ -2434,8 +2460,11 @@ static void handle_hpd_irq(void *param)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drm_kms=
_helper_hotplug_event(dev);<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (dc_link_detect(ac=
onnector-&gt;dc_link, DETECT_REASON_HPD)) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; amdgpu_dm_update_connector_after_detect(aconnector);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (new_connection_type =3D=3D dc_connection_none &amp;&amp;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; aconnector-&gt;dc_link-&gt;type =3D=3D dc_conne=
ction_none)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dm_set_dpms_off(aconnec=
tor-&gt;dc_link);<br>
&gt;&nbsp;&nbsp; <br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; amdgpu_dm_update_connector_after_detect(aconnector);<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; drm_modeset_lock_all(dev);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; dm_restore_drm_connector_state(dev, connector);<br>
&gt; diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/dr=
m/amd/display/dc/core/dc.c<br>
&gt; index 903353389edb..58eb0d69873a 100644<br>
&gt; --- a/drivers/gpu/drm/amd/display/dc/core/dc.c<br>
&gt; +++ b/drivers/gpu/drm/amd/display/dc/core/dc.c<br>
&gt; @@ -2798,6 +2798,19 @@ struct dc_stream_state *dc_get_stream_at_index(=
struct dc *dc, uint8_t i)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return NULL;<br>
&gt;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt; +struct dc_stream_state *dc_stream_find_from_link(const struct dc_link=
 *link)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; uint8_t i;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; struct dc_context *ctx =3D link-&gt;ctx;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; ctx-&gt;dc-&gt;current_=
state-&gt;stream_count; i++) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (ctx-&gt;dc-&gt;current_state-&gt;streams[i]-&gt;link =3D=3D link)<b=
r>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ctx-&gt;dc-&gt;c=
urrent_state-&gt;streams[i];<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; return NULL;<br>
&gt; +}<br>
&gt; +<br>
&gt;&nbsp;&nbsp; enum dc_irq_source dc_interrupt_to_irq_source(<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; struct dc *dc,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; uint32_t src_id,<br>
&gt; diff --git a/drivers/gpu/drm/amd/display/dc/dc_stream.h b/drivers/gpu/=
drm/amd/display/dc/dc_stream.h<br>
&gt; index bf090afc2f70..b7910976b81a 100644<br>
&gt; --- a/drivers/gpu/drm/amd/display/dc/dc_stream.h<br>
&gt; +++ b/drivers/gpu/drm/amd/display/dc/dc_stream.h<br>
&gt; @@ -292,6 +292,7 @@ void dc_stream_log(const struct dc *dc, const stru=
ct dc_stream_state *stream);<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; uint8_t dc_get_current_stream_count(struct dc *dc);<br>
&gt;&nbsp;&nbsp; struct dc_stream_state *dc_get_stream_at_index(struct dc *=
dc, uint8_t i);<br>
&gt; +struct dc_stream_state *dc_stream_find_from_link(const struct dc_link=
 *link);<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; /*<br>
&gt;&nbsp;&nbsp;&nbsp; * Return the current frame counter.<br>
&gt; <br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BN6PR12MB19394C6ACEA74A16EE567CE78BF80BN6PR12MB1939namp_--

--===============0674875532==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0674875532==--
