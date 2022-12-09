Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5486BC4332F
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Dec 2022 22:08:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C9A8410E591;
	Fri,  9 Dec 2022 22:08:06 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2089.outbound.protection.outlook.com [40.107.101.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E83F110E591
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Dec 2022 22:08:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kxlEzc18a4hu/pc8GbvkAhB9I4kykARA6LFSfBAS3dgxstPhirgcRkYSt2Ce4OxWJ13j2qutdHLginaJXJxv0ezV1X6EM/P8ogwUAv0nVufs2nQR4LtHr6sTaFbEF9tBePTBJCBNT5R8UaGsuT5hBUUjfmPfVQNbqUTcjYb1x/V7tAiunZWx4eMbHqpRzIZraDQIGNbyHId2UF4+9jwvmAVrjriAZrjZybyBMCnchVLEr3MrXHIaVVwe4ibJz0131NYtnVhXoCQdM3XwG0BZFZfsSZxrr2uLy3/Km3KuAETKERTi3r+x4K55f3nwMm5pAH3YLr51dih0MixsH0WBkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nghf5vrGW4E2FIabDIOtLWZWpk69j7DLszizYcQqCtg=;
 b=ki91mtjj+TKPlHF14dJoHguBa5yanWhTLGjbrWQJ9i0Y5gZYz8q6MJ9TbY5XN5SrV/+fn6Q5FPeF+YC0PwDd65tEqcvlUlyu37deqem1rYbYfk7TElFDwhFrI/5DkxrbQAfOT5+seDI5+ZInNgpeKnvEuZTYCodth+1sYYWLeJTczF7PqoH09r5A9p8SVmoVJfGLGpTN9QjY33Popevza9WX59W0NB2axIoMpAW58EsG7sKSW/G8u8yH1zWN4ekpuN06rzZqAMLv2YAywLQ7yroKJyjKQIGP+OS3qLGFqBOsqnOF2rjRsegqKQpiFGT1q+7cuiRUPPu1G6aG6JGGVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nghf5vrGW4E2FIabDIOtLWZWpk69j7DLszizYcQqCtg=;
 b=Q/iS4lrdOqn4fPgGBZu7aBhI4koW7QUaUlSGh7s001GwJvucFqI+GcV8FlXqYsk6OZITnAQ3tyqnbxEnYyK1sokdbABzfqDyhNWafIMjU+BjsQJRL15p0jA+zzTcbOPgazAup+3ePlNkhL7RO/v7zAW3ItEXtY701eYXc7NAh1U=
Received: from BY5PR12MB4211.namprd12.prod.outlook.com (2603:10b6:a03:20f::19)
 by DS7PR12MB8419.namprd12.prod.outlook.com (2603:10b6:8:e9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Fri, 9 Dec
 2022 22:08:01 +0000
Received: from BY5PR12MB4211.namprd12.prod.outlook.com
 ([fe80::595a:55f2:cb35:fdf4]) by BY5PR12MB4211.namprd12.prod.outlook.com
 ([fe80::595a:55f2:cb35:fdf4%8]) with mapi id 15.20.5880.016; Fri, 9 Dec 2022
 22:08:01 +0000
From: "Dhillon, Jasdeep" <Jasdeep.Dhillon@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH 10/23] drm/amd/display: phase3 mst hdcp for multiple
 displays
Thread-Topic: [PATCH 10/23] drm/amd/display: phase3 mst hdcp for multiple
 displays
Thread-Index: AQHZC+yIwwpOSK/fQUeSRziN+idJGK5mE8KAgAAJtXM=
Date: Fri, 9 Dec 2022 22:08:01 +0000
Message-ID: <BY5PR12MB4211EC8FBF40FFFB9699F0E8FB1C9@BY5PR12MB4211.namprd12.prod.outlook.com>
References: <20221209163647.25704-1-jdhillon@amd.com>
 <20221209163647.25704-11-jdhillon@amd.com>
 <CADnq5_OFDampu1A78BPMTiXpa4=V7cbpiCpbR=1C_uKCs=Q+zw@mail.gmail.com>
In-Reply-To: <CADnq5_OFDampu1A78BPMTiXpa4=V7cbpiCpbR=1C_uKCs=Q+zw@mail.gmail.com>
Accept-Language: en-CA, en-US
Content-Language: en-CA
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR12MB4211:EE_|DS7PR12MB8419:EE_
x-ms-office365-filtering-correlation-id: df7a87fd-9a97-4f0b-1b23-08dada31d667
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QK1GRmEMbDnvWXPESs4OKNODqpSu/1i1S3rXEMJmHx7xj2FEvPWY49wlD7LYok1Zbpml6b9G79ovFsXvwDYdJlSzXU/mrPlaJFcLClH9UlixxJdqJZvatuZ5wnVtfFBio19RDRTm+Spm8RGBzZWqp4QjgYh8hVOnhDXjK2wfXwkTa6NgbJotTg2sXoWiOn/bhfCAtUcImcmR+NA6wkA42yKbyAiKHx0i5TLOnA0d5bpeM/IitrukdwnEuJPHe3JRnRIaeMjgGHbgzuCv/ccV0h+F4OW4Xszxoe1687YYfcF2WX1loW2RoYvb5XcHRh/YvbSp8ODyjqOcPE9iMQudbRSbsulHEEoxMaIXe48bQuIB/uqFkL5UmO372aUezIg0FfL2VvGnI1SNwzSvqks72X9m/XW+RASQGSPnCBd0olna1rN8WCYvot30A0H1TfYY2/3r9/Sxr/0oCkaE6BpNeKrNXoHVc1zmrbdfZxOGcJdcvw+ZG5wGBI5ghVgn0Mvwoo0a9hloEzlkhLPzNuP3Rkde6t1a4tg4MGr31jT3bute/S4vZz18wUc2DoeVOAdhsRr2y2FzNN4/780FQ2CRfxIWClDw5UZ2hkudwmAL8USMgqFXgVNQ1TW1RkOFMZCwpJwsSp/gpdXuszIjTaB56dQLM+e54GyKmzmwqjXtkSX5qIFHCmD2SDjmF0onV7K3uD9aZdlPkpbnZUdNfBXa4Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4211.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(366004)(39860400002)(346002)(376002)(396003)(136003)(451199015)(2906002)(6916009)(5660300002)(54906003)(66476007)(41300700001)(64756008)(8676002)(316002)(91956017)(52536014)(4326008)(8936002)(76116006)(66946007)(66446008)(33656002)(478600001)(7696005)(6506007)(26005)(86362001)(71200400001)(9686003)(186003)(53546011)(66556008)(55016003)(83380400001)(38100700002)(122000001)(38070700005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?FRV/azeh52+dg2U7tLWKqU8h/7vW0mrP1TdTATdiVQCt4cG7obyNM19ZmqRN?=
 =?us-ascii?Q?BuNJO44zP4oW2HJ71nhk1pFh7EAYok80KeE+g/h3GEhiOr5452TKqNlKgibl?=
 =?us-ascii?Q?4yPY/OykRuQ5sG/BxgCEfia2Rh0A9dmdwjJ6d5w5YIgzSlrONkCruZBa7QNV?=
 =?us-ascii?Q?l8fj3hI1WuYvNCCnqbk9jlUNKPDiyCy9025ZDkEC4CAUSpGR2IFo5YEvRw+z?=
 =?us-ascii?Q?GRul+TfQOQziEEMeXnBU4N4JLrY3l8ZrUW7CYLnv9OQIKO9qTugT0vQJ7Xoj?=
 =?us-ascii?Q?RNwq3lXr9QNBecepx85N0OBhne8sTIicsupJjdg3JVwoRAyseuxyXu6WFA/q?=
 =?us-ascii?Q?2d1edOs0+Pmm8ORfSj9a2j09VluxF2PtKqikgtxMWl0mcNO2FxWBqjcCOch5?=
 =?us-ascii?Q?4di+1f7g3ztvVNvOB2JHqpRieIr0EJm2ESkaJ1h0re0Cz5hC96+l9WqKDXsj?=
 =?us-ascii?Q?XNJaZ2eILDGbTPUHlORSC9y+yktfPpuxkZldhiaX8HrrWmt7/+zJXejhEuzf?=
 =?us-ascii?Q?F8AVB7dqbln3VLd3EUZWdNKyx5fgnZu1WeYkXkd/2qiaoCzt+QQ+XtgtQEMK?=
 =?us-ascii?Q?84BdGF0vfhjebicqTaJ8n6LlnOYhNUH0jy52Qg99V5XWNH5friQtHFUXuQkT?=
 =?us-ascii?Q?ci//7vabdcqOwKcjZELMGEP/Z927YfDa4WQAp1GeJT2IT8gT8aGuGPZbRqBA?=
 =?us-ascii?Q?reKkTcdYuxHWtRJQ9v8kA7+6Bjt5XjONCJMOH1IhPLFdQvAO05InGsMK6N7o?=
 =?us-ascii?Q?MNyiqaK3iV5puAGuDdZtjcspIuPvd0eFp1HOO0V+pcn7vnOD+IHCvJE942C/?=
 =?us-ascii?Q?j//niiubjZj1VBEuNqzhFMFxvS1IhBubK+6kEvDb4bJveVZSDS2Sp8XbjsUd?=
 =?us-ascii?Q?sLwosKTzgbYWWtaY6jvsDUp/3IWHMM3o4Gx5dxbWhJf5et0j8f+l5NOd9nn7?=
 =?us-ascii?Q?0YNfBs6q6y87TfUyASz+SR0VrwsJEwNu4vECJZIH+vqagcGgACCwd/rU8V2A?=
 =?us-ascii?Q?pkjUID/7x39K0aQI/NA7oSe0Uz5XP4/RL0x4lqW+3729zb9Y+OtAQpijVHLz?=
 =?us-ascii?Q?RyMNsLr/vuqaWRPaiSzwc+RzVLknL4pJkc63TH7lX1vaWr7vK1fEs6PT5sLN?=
 =?us-ascii?Q?bLvagcUmZDfcjYy6qAluj1EYQf2nrED0AZywKUg+Bw0EE4eMil2je7VBkK4s?=
 =?us-ascii?Q?LSjOruzMadJp6ZE4GyzfROgnO5LJsvNkwlxBV4Jj7L3Ub0iqs6nCdECiKsWe?=
 =?us-ascii?Q?c4J9gnOYff9ysa6RqhkOhoM8hkcxp7J9pc36VpnQ2k9zh8OKU66d+rUjsUu3?=
 =?us-ascii?Q?1n/PLq8HA69Ol92ff1ne4oLVng42av77AW4nfUBiRsQvMCo+KIYxmWgbQHOP?=
 =?us-ascii?Q?Jwgn5dr+u0eqrnJWCcNMbjlWDX7v0KajbGkzdntAFpkMXmXrbi4xXajlwsgB?=
 =?us-ascii?Q?e/ig0FGdZxxglc/tpPFG8h9BEIO9Z2VmnF6DXCQTtTlt9imBq5pdTBSauAPq?=
 =?us-ascii?Q?8NA3CaGeHYKOkUD7yaOkqfxBM8aRYriIk1LBHpRhUynApvUpr6XBlva5hgN5?=
 =?us-ascii?Q?emtCugBg0vrQzFazIE4=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BY5PR12MB4211EC8FBF40FFFB9699F0E8FB1C9BY5PR12MB4211namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4211.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df7a87fd-9a97-4f0b-1b23-08dada31d667
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2022 22:08:01.1055 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BSeQt/GmhMsBAL10X0Pj4dVCoZaDR1bKFbTnmxeKhkSG0h+50D6cORdMINN6dwnbiDPB3EhMvnr0pFcXEmOQQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8419
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
 Aurabindo" <Aurabindo.Pillai@amd.com>, "Wu, 
 Hersen" <hersenxs.wu@amd.com>, "Lin, Wayne" <Wayne.Lin@amd.com>, "Wentland,
 Harry" <Harry.Wentland@amd.com>, "Gutierrez,
 Agustin" <Agustin.Gutierrez@amd.com>, "Kotarac, Pavle" <Pavle.Kotarac@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BY5PR12MB4211EC8FBF40FFFB9699F0E8FB1C9BY5PR12MB4211namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

This patch has been dropped

Regards,
Jasdeep

________________________________
From: Alex Deucher <alexdeucher@gmail.com>
Sent: December 9, 2022 4:32 PM
To: Dhillon, Jasdeep <Jasdeep.Dhillon@amd.com>
Cc: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; Wang, Ch=
ao-kai (Stylon) <Stylon.Wang@amd.com>; Li, Sun peng (Leo) <Sunpeng.Li@amd.c=
om>; Wentland, Harry <Harry.Wentland@amd.com>; Zhuo, Qingqing (Lillian) <Qi=
ngqing.Zhuo@amd.com>; Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>; Li, Rom=
an <Roman.Li@amd.com>; Chiu, Solomon <Solomon.Chiu@amd.com>; Pillai, Aurabi=
ndo <Aurabindo.Pillai@amd.com>; Wu, Hersen <hersenxs.wu@amd.com>; Lin, Wayn=
e <Wayne.Lin@amd.com>; Lakha, Bhawanpreet <Bhawanpreet.Lakha@amd.com>; Guti=
errez, Agustin <Agustin.Gutierrez@amd.com>; Kotarac, Pavle <Pavle.Kotarac@a=
md.com>
Subject: Re: [PATCH 10/23] drm/amd/display: phase3 mst hdcp for multiple di=
splays

On Fri, Dec 9, 2022 at 11:37 AM jdhillon <jdhillon@amd.com> wrote:
>
> From: hersen wu <hersenxs.wu@amd.com>
>
> [Why]
> multiple display hdcp are enabled within event_property_validate,
> event_property_update by looping all displays on mst hub. when
> one of display on mst hub in unplugged or disabled, hdcp are
> disabled for all displays on mst hub within hdcp_reset_display
> by looping all displays of mst link. for displays still active,
> their encryption status are off. kernel driver will not run hdcp
> authentication again. therefore, hdcp are not enabled automatically.
>
> [How]
> within is_content_protection_different, check drm_crtc_state changes
> of all displays on mst hub, if need, triger hdcp_update_display to
> re-run hdcp authentication.
>
> Reviewed-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
> Acked-by: Jasdeep Dhillon <jdhillon@amd.com>
> Signed-off-by: hersen wu <hersenxs.wu@amd.com>
> ---
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 118 ++++++++++++------
>  1 file changed, 81 insertions(+), 37 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/=
gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 7affe0899418..dc23801de071 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -7374,27 +7374,55 @@ is_scaling_state_different(const struct dm_connec=
tor_state *dm_state,
>  }
>
>  #ifdef CONFIG_DRM_AMD_DC_HDCP
> -static bool is_content_protection_different(struct drm_connector_state *=
state,
> -                                           const struct drm_connector_st=
ate *old_state,
> -                                           const struct drm_connector *c=
onnector, struct hdcp_workqueue *hdcp_w)
> +static bool is_content_protection_different(struct drm_crtc_state *new_c=
rtc_state,
> +                                           struct drm_crtc_state *old_cr=
tc_state,
> +                                           struct drm_connector_state *n=
ew_conn_state,
> +                                           struct drm_connector_state *o=
ld_conn_state,
> +                                           const struct drm_connector *c=
onnector,
> +                                           struct hdcp_workqueue *hdcp_w=
)
>  {
>         struct amdgpu_dm_connector *aconnector =3D to_amdgpu_dm_connector=
(connector);
>         struct dm_connector_state *dm_con_state =3D to_dm_connector_state=
(connector->state);
>
> -       /* Handle: Type0/1 change */
> -       if (old_state->hdcp_content_type !=3D state->hdcp_content_type &&
> -           state->content_protection !=3D DRM_MODE_CONTENT_PROTECTION_UN=
DESIRED) {
> -               state->content_protection =3D DRM_MODE_CONTENT_PROTECTION=
_DESIRED;
> +       pr_debug("[HDCP_DM] connector->index: %x connect_status: %x dpms:=
 %x\n",
> +               connector->index, connector->status, connector->dpms);
> +       pr_debug("[HDCP_DM] state protection old: %x new: %x\n",
> +               old_conn_state->content_protection, new_conn_state->conte=
nt_protection);
> +
> +       if (old_crtc_state)
> +               pr_debug("[HDCP_DM] old crtc en: %x a: %x m: %x a-chg: %x=
 c-chg: %x\n",
> +               old_crtc_state->enable,
> +               old_crtc_state->active,
> +               old_crtc_state->mode_changed,
> +               old_crtc_state->active_changed,
> +               old_crtc_state->connectors_changed);
> +
> +       if (new_crtc_state)
> +               pr_debug("[HDCP_DM] NEW crtc en: %x a: %x m: %x a-chg: %x=
 c-chg: %x\n",
> +               new_crtc_state->enable,
> +               new_crtc_state->active,
> +               new_crtc_state->mode_changed,
> +               new_crtc_state->active_changed,
> +               new_crtc_state->connectors_changed);
> +
> +       /* hdcp content type change */
> +       if (old_conn_state->hdcp_content_type !=3D new_conn_state->hdcp_c=
ontent_type &&
> +           new_conn_state->content_protection !=3D DRM_MODE_CONTENT_PROT=
ECTION_UNDESIRED) {
> +               new_conn_state->content_protection =3D DRM_MODE_CONTENT_P=
ROTECTION_DESIRED;
> +               pr_debug("[HDCP_DM] Type0/1 change %s :true\n", __func__)=
;
>                 return true;
>         }
>
> -       /* CP is being re enabled, ignore this
> -        *
> -        * Handles:     ENABLED -> DESIRED
> -        */
> -       if (old_state->content_protection =3D=3D DRM_MODE_CONTENT_PROTECT=
ION_ENABLED &&
> -           state->content_protection =3D=3D DRM_MODE_CONTENT_PROTECTION_=
DESIRED) {
> -               state->content_protection =3D DRM_MODE_CONTENT_PROTECTION=
_ENABLED;
> +       /* CP is being re enabled, ignore this */
> +       if (old_conn_state->content_protection =3D=3D DRM_MODE_CONTENT_PR=
OTECTION_ENABLED &&
> +           new_conn_state->content_protection =3D=3D DRM_MODE_CONTENT_PR=
OTECTION_DESIRED) {
> +               if (new_crtc_state && new_crtc_state->mode_changed) {
> +                       new_conn_state->content_protection =3D DRM_MODE_C=
ONTENT_PROTECTION_DESIRED;
> +                       pr_debug("[HDCP_DM] ENABLED->DESIRED & mode_chang=
ed %s :true\n", __func__);
> +                       return true;
> +               };
> +               new_conn_state->content_protection =3D DRM_MODE_CONTENT_P=
ROTECTION_ENABLED;
> +               pr_debug("[HDCP_DM] ENABLED -> DESIRED %s :false\n", __fu=
nc__);
>                 return false;
>         }
>
> @@ -7402,9 +7430,9 @@ static bool is_content_protection_different(struct =
drm_connector_state *state,
>          *
>          * Handles:     UNDESIRED -> ENABLED
>          */
> -       if (old_state->content_protection =3D=3D DRM_MODE_CONTENT_PROTECT=
ION_UNDESIRED &&
> -           state->content_protection =3D=3D DRM_MODE_CONTENT_PROTECTION_=
ENABLED)
> -               state->content_protection =3D DRM_MODE_CONTENT_PROTECTION=
_DESIRED;
> +       if (old_conn_state->content_protection =3D=3D DRM_MODE_CONTENT_PR=
OTECTION_UNDESIRED &&
> +           new_conn_state->content_protection =3D=3D DRM_MODE_CONTENT_PR=
OTECTION_ENABLED)
> +               new_conn_state->content_protection =3D DRM_MODE_CONTENT_P=
ROTECTION_DESIRED;
>
>         /* Stream removed and re-enabled
>          *
> @@ -7414,10 +7442,12 @@ static bool is_content_protection_different(struc=
t drm_connector_state *state,
>          *
>          * Handles:     DESIRED -> DESIRED (Special case)
>          */
> -       if (!(old_state->crtc && old_state->crtc->enabled) &&
> -               state->crtc && state->crtc->enabled &&
> +       if (!(old_conn_state->crtc && old_conn_state->crtc->enabled) &&
> +               new_conn_state->crtc && new_conn_state->crtc->enabled &&
>                 connector->state->content_protection =3D=3D DRM_MODE_CONT=
ENT_PROTECTION_DESIRED) {
>                 dm_con_state->update_hdcp =3D false;
> +               pr_debug("[HDCP_DM] DESIRED->DESIRED (Stream removed and =
re-enabled) %s :true\n",
> +                       __func__);
>                 return true;
>         }
>
> @@ -7429,35 +7459,42 @@ static bool is_content_protection_different(struc=
t drm_connector_state *state,
>          *
>          * Handles:     DESIRED -> DESIRED (Special case)
>          */
> -       if (dm_con_state->update_hdcp && state->content_protection =3D=3D=
 DRM_MODE_CONTENT_PROTECTION_DESIRED &&
> -           connector->dpms =3D=3D DRM_MODE_DPMS_ON && aconnector->dc_sin=
k !=3D NULL) {
> +       if (dm_con_state->update_hdcp &&
> +       new_conn_state->content_protection =3D=3D DRM_MODE_CONTENT_PROTEC=
TION_DESIRED &&
> +       connector->dpms =3D=3D DRM_MODE_DPMS_ON && aconnector->dc_sink !=
=3D NULL) {
>                 dm_con_state->update_hdcp =3D false;
> +               pr_debug("[HDCP_DM] DESIRED->DESIRED (Hot-plug, headless =
s3, dpms) %s :true\n",
> +                       __func__);
>                 return true;
>         }
>
> -       /*
> -        * Handles:     UNDESIRED -> UNDESIRED
> -        *              DESIRED -> DESIRED
> -        *              ENABLED -> ENABLED
> -        */
> -       if (old_state->content_protection =3D=3D state->content_protectio=
n)
> +       if (old_conn_state->content_protection =3D=3D new_conn_state->con=
tent_protection) {
> +               if (new_conn_state->content_protection >=3D DRM_MODE_CONT=
ENT_PROTECTION_DESIRED) {
> +                       if (new_crtc_state && new_crtc_state->mode_change=
d) {
> +                               pr_debug("[HDCP_DM] DESIRED->DESIRED or E=
NABLE->ENABLE mode_change %s :true\n",
> +                                       __func__);
> +                               return true;
> +                       };
> +                       pr_debug("[HDCP_DM] DESIRED->DESIRED & ENABLE->EN=
ABLE %s :false\n",
> +                               __func__);
> +                       return false;
> +               };
> +
> +               pr_debug("[HDCP_DM] UNDESIRED->UNDESIRED %s :false\n", __=
func__);
>                 return false;
> +       }
>
> -       /*
> -        * Handles:     UNDESIRED -> DESIRED
> -        *              DESIRED -> UNDESIRED
> -        *              ENABLED -> UNDESIRED
> -        */
> -       if (state->content_protection !=3D DRM_MODE_CONTENT_PROTECTION_EN=
ABLED)
> +       if (new_conn_state->content_protection !=3D DRM_MODE_CONTENT_PROT=
ECTION_ENABLED) {
> +               pr_debug("[HDCP_DM] UNDESIRED->DESIRED or DESIRED->UNDESI=
RED or ENABLED->UNDESIRED %s :true\n",
> +                       __func__);
>                 return true;
> +       }
>
> -       /*
> -        * Handles:     DESIRED -> ENABLED
> -        */
> +       pr_debug("[HDCP_DM] DESIRED->ENABLED %s :false\n", __func__);
>         return false;
>  }
> -
>  #endif
> +
>  static void remove_stream(struct amdgpu_device *adev,
>                           struct amdgpu_crtc *acrtc,
>                           struct dc_stream_state *stream)
> @@ -8322,6 +8359,10 @@ static void amdgpu_dm_atomic_commit_tail(struct dr=
m_atomic_state *state)
>                         new_crtc_state =3D drm_atomic_get_new_crtc_state(=
state, &acrtc->base);
>                         old_crtc_state =3D drm_atomic_get_old_crtc_state(=
state, &acrtc->base);
>                 }
> +<<<<<<< HEAD
> +=3D=3D=3D=3D=3D=3D=3D
> +
> +>>>>>>> 667f52144b9a (drm/amd/display: phase3 mst hdcp for multiple disp=
lays)

rebasing leftovers.

>                 if (old_crtc_state)
>                         pr_debug("old crtc en: %x a: %x m: %x a-chg: %x c=
-chg: %x\n",
>                         old_crtc_state->enable,
> @@ -8384,7 +8425,10 @@ static void amdgpu_dm_atomic_commit_tail(struct dr=
m_atomic_state *state)
>                                 DRM_MODE_CONTENT_PROTECTION_DESIRED)
>                                 enable_encryption =3D true;
>
> +<<<<<<< HEAD
>
> +=3D=3D=3D=3D=3D=3D=3D
> +>>>>>>> 667f52144b9a (drm/amd/display: phase3 mst hdcp for multiple disp=
lays)

here too.

>                         if (aconnector->dc_link && aconnector->dc_sink &&
>                                 aconnector->dc_link->type =3D=3D dc_conne=
ction_mst_branch) {
>                                 struct hdcp_workqueue *hdcp_work =3D adev=
->dm.hdcp_workqueue;
> --
> 2.34.1
>

--_000_BY5PR12MB4211EC8FBF40FFFB9699F0E8FB1C9BY5PR12MB4211namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
</head>
<body>
<div>This patch has been dropped</div>
<div><br>
</div>
<div>Regards,</div>
<div>Jasdeep</div>
<br>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Alex Deucher &lt;alex=
deucher@gmail.com&gt;<br>
<b>Sent:</b> December 9, 2022 4:32 PM<br>
<b>To:</b> Dhillon, Jasdeep &lt;Jasdeep.Dhillon@amd.com&gt;<br>
<b>Cc:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;; Wang, Chao-kai (Stylon) &lt;Stylon.Wang@amd.com&gt;; Li, Sun peng (Leo=
) &lt;Sunpeng.Li@amd.com&gt;; Wentland, Harry &lt;Harry.Wentland@amd.com&gt=
;; Zhuo, Qingqing (Lillian) &lt;Qingqing.Zhuo@amd.com&gt;; Siqueira,
 Rodrigo &lt;Rodrigo.Siqueira@amd.com&gt;; Li, Roman &lt;Roman.Li@amd.com&g=
t;; Chiu, Solomon &lt;Solomon.Chiu@amd.com&gt;; Pillai, Aurabindo &lt;Aurab=
indo.Pillai@amd.com&gt;; Wu, Hersen &lt;hersenxs.wu@amd.com&gt;; Lin, Wayne=
 &lt;Wayne.Lin@amd.com&gt;; Lakha, Bhawanpreet &lt;Bhawanpreet.Lakha@amd.co=
m&gt;;
 Gutierrez, Agustin &lt;Agustin.Gutierrez@amd.com&gt;; Kotarac, Pavle &lt;P=
avle.Kotarac@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH 10/23] drm/amd/display: phase3 mst hdcp for mult=
iple displays</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">On Fri, Dec 9, 2022 at 11:37 AM jdhillon &lt;jdhil=
lon@amd.com&gt; wrote:<br>
&gt;<br>
&gt; From: hersen wu &lt;hersenxs.wu@amd.com&gt;<br>
&gt;<br>
&gt; [Why]<br>
&gt; multiple display hdcp are enabled within event_property_validate,<br>
&gt; event_property_update by looping all displays on mst hub. when<br>
&gt; one of display on mst hub in unplugged or disabled, hdcp are<br>
&gt; disabled for all displays on mst hub within hdcp_reset_display<br>
&gt; by looping all displays of mst link. for displays still active,<br>
&gt; their encryption status are off. kernel driver will not run hdcp<br>
&gt; authentication again. therefore, hdcp are not enabled automatically.<b=
r>
&gt;<br>
&gt; [How]<br>
&gt; within is_content_protection_different, check drm_crtc_state changes<b=
r>
&gt; of all displays on mst hub, if need, triger hdcp_update_display to<br>
&gt; re-run hdcp authentication.<br>
&gt;<br>
&gt; Reviewed-by: Bhawanpreet Lakha &lt;Bhawanpreet.Lakha@amd.com&gt;<br>
&gt; Acked-by: Jasdeep Dhillon &lt;jdhillon@amd.com&gt;<br>
&gt; Signed-off-by: hersen wu &lt;hersenxs.wu@amd.com&gt;<br>
&gt; ---<br>
&gt;&nbsp; .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 118 ++++++++++++=
------<br>
&gt;&nbsp; 1 file changed, 81 insertions(+), 37 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drive=
rs/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
&gt; index 7affe0899418..dc23801de071 100644<br>
&gt; --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
&gt; +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
&gt; @@ -7374,27 +7374,55 @@ is_scaling_state_different(const struct dm_con=
nector_state *dm_state,<br>
&gt;&nbsp; }<br>
&gt;<br>
&gt;&nbsp; #ifdef CONFIG_DRM_AMD_DC_HDCP<br>
&gt; -static bool is_content_protection_different(struct drm_connector_stat=
e *state,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct drm_connector_state *old_sta=
te,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct drm_connector *connector, st=
ruct hdcp_workqueue *hdcp_w)<br>
&gt; +static bool is_content_protection_different(struct drm_crtc_state *ne=
w_crtc_state,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_crtc_state *old_crtc_state,<br=
>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_connector_state *new_conn_stat=
e,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_connector_state *old_conn_stat=
e,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct drm_connector *connector,<br=
>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct hdcp_workqueue *hdcp_w)<br>
&gt;&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_dm_conne=
ctor *aconnector =3D to_amdgpu_dm_connector(connector);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dm_connector_st=
ate *dm_con_state =3D to_dm_connector_state(connector-&gt;state);<br>
&gt;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Handle: Type0/1 change */<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (old_state-&gt;hdcp_content_t=
ype !=3D state-&gt;hdcp_content_type &amp;&amp;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; state-&g=
t;content_protection !=3D DRM_MODE_CONTENT_PROTECTION_UNDESIRED) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; state-&gt;content_protection =3D DRM_MODE_CONTENT_PROTECTIO=
N_DESIRED;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;[HDCP_DM] connect=
or-&gt;index: %x connect_status: %x dpms: %x\n&quot;,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; connector-&gt;index, connector-&gt;status, connector-&gt;dp=
ms);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;[HDCP_DM] state p=
rotection old: %x new: %x\n&quot;,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; old_conn_state-&gt;content_protection, new_conn_state-&gt;c=
ontent_protection);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (old_crtc_state)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; pr_debug(&quot;[HDCP_DM] old crtc en: %x a: %x m: %x a-chg:=
 %x c-chg: %x\n&quot;,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; old_crtc_state-&gt;enable,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; old_crtc_state-&gt;active,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; old_crtc_state-&gt;mode_changed,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; old_crtc_state-&gt;active_changed,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; old_crtc_state-&gt;connectors_changed);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (new_crtc_state)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; pr_debug(&quot;[HDCP_DM] NEW crtc en: %x a: %x m: %x a-chg:=
 %x c-chg: %x\n&quot;,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; new_crtc_state-&gt;enable,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; new_crtc_state-&gt;active,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; new_crtc_state-&gt;mode_changed,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; new_crtc_state-&gt;active_changed,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; new_crtc_state-&gt;connectors_changed);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* hdcp content type change */<b=
r>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (old_conn_state-&gt;hdcp_cont=
ent_type !=3D new_conn_state-&gt;hdcp_content_type &amp;&amp;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; new_conn=
_state-&gt;content_protection !=3D DRM_MODE_CONTENT_PROTECTION_UNDESIRED) {=
<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; new_conn_state-&gt;content_protection =3D DRM_MODE_CONTENT_=
PROTECTION_DESIRED;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; pr_debug(&quot;[HDCP_DM] Type0/1 change %s :true\n&quot;, _=
_func__);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; return true;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* CP is being re enabled, ignor=
e this<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Handles:&nbsp;&nbsp;&nbs=
p;&nbsp; ENABLED -&gt; DESIRED<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (old_state-&gt;content_protec=
tion =3D=3D DRM_MODE_CONTENT_PROTECTION_ENABLED &amp;&amp;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; state-&g=
t;content_protection =3D=3D DRM_MODE_CONTENT_PROTECTION_DESIRED) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; state-&gt;content_protection =3D DRM_MODE_CONTENT_PROTECTIO=
N_ENABLED;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* CP is being re enabled, ignor=
e this */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (old_conn_state-&gt;content_p=
rotection =3D=3D DRM_MODE_CONTENT_PROTECTION_ENABLED &amp;&amp;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; new_conn=
_state-&gt;content_protection =3D=3D DRM_MODE_CONTENT_PROTECTION_DESIRED) {=
<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (new_crtc_state &amp;&amp; new_crtc_state-&gt;mode_chang=
ed) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; new_conn_st=
ate-&gt;content_protection =3D DRM_MODE_CONTENT_PROTECTION_DESIRED;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&q=
uot;[HDCP_DM] ENABLED-&gt;DESIRED &amp; mode_changed %s :true\n&quot;, __fu=
nc__);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return true=
;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; };<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; new_conn_state-&gt;content_protection =3D DRM_MODE_CONTENT_=
PROTECTION_ENABLED;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; pr_debug(&quot;[HDCP_DM] ENABLED -&gt; DESIRED %s :false\n&=
quot;, __func__);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; return false;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;<br>
&gt; @@ -7402,9 +7430,9 @@ static bool is_content_protection_different(stru=
ct drm_connector_state *state,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Handles:&nbsp;=
&nbsp;&nbsp;&nbsp; UNDESIRED -&gt; ENABLED<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (old_state-&gt;content_protec=
tion =3D=3D DRM_MODE_CONTENT_PROTECTION_UNDESIRED &amp;&amp;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; state-&g=
t;content_protection =3D=3D DRM_MODE_CONTENT_PROTECTION_ENABLED)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; state-&gt;content_protection =3D DRM_MODE_CONTENT_PROTECTIO=
N_DESIRED;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (old_conn_state-&gt;content_p=
rotection =3D=3D DRM_MODE_CONTENT_PROTECTION_UNDESIRED &amp;&amp;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; new_conn=
_state-&gt;content_protection =3D=3D DRM_MODE_CONTENT_PROTECTION_ENABLED)<b=
r>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; new_conn_state-&gt;content_protection =3D DRM_MODE_CONTENT_=
PROTECTION_DESIRED;<br>
&gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Stream removed and =
re-enabled<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *<br>
&gt; @@ -7414,10 +7442,12 @@ static bool is_content_protection_different(st=
ruct drm_connector_state *state,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Handles:&nbsp;=
&nbsp;&nbsp;&nbsp; DESIRED -&gt; DESIRED (Special case)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!(old_state-&gt;crtc &amp;&a=
mp; old_state-&gt;crtc-&gt;enabled) &amp;&amp;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; state-&gt;crtc &amp;&amp; state-&gt;crtc-&gt;enabled &amp;&=
amp;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!(old_conn_state-&gt;crtc &a=
mp;&amp; old_conn_state-&gt;crtc-&gt;enabled) &amp;&amp;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; new_conn_state-&gt;crtc &amp;&amp; new_conn_state-&gt;crtc-=
&gt;enabled &amp;&amp;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; connector-&gt;state-&gt;content_protection =3D=3D=
 DRM_MODE_CONTENT_PROTECTION_DESIRED) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; dm_con_state-&gt;update_hdcp =3D false;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; pr_debug(&quot;[HDCP_DM] DESIRED-&gt;DESIRED (Stream remove=
d and re-enabled) %s :true\n&quot;,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __func__);<=
br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; return true;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;<br>
&gt; @@ -7429,35 +7459,42 @@ static bool is_content_protection_different(st=
ruct drm_connector_state *state,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Handles:&nbsp;=
&nbsp;&nbsp;&nbsp; DESIRED -&gt; DESIRED (Special case)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (dm_con_state-&gt;update_hdcp=
 &amp;&amp; state-&gt;content_protection =3D=3D DRM_MODE_CONTENT_PROTECTION=
_DESIRED &amp;&amp;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; connecto=
r-&gt;dpms =3D=3D DRM_MODE_DPMS_ON &amp;&amp; aconnector-&gt;dc_sink !=3D N=
ULL) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (dm_con_state-&gt;update_hdcp=
 &amp;&amp;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; new_conn_state-&gt;content_prote=
ction =3D=3D DRM_MODE_CONTENT_PROTECTION_DESIRED &amp;&amp;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; connector-&gt;dpms =3D=3D DRM_MO=
DE_DPMS_ON &amp;&amp; aconnector-&gt;dc_sink !=3D NULL) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; dm_con_state-&gt;update_hdcp =3D false;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; pr_debug(&quot;[HDCP_DM] DESIRED-&gt;DESIRED (Hot-plug, hea=
dless s3, dpms) %s :true\n&quot;,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __func__);<=
br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; return true;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Handles:&nbsp;&nbsp;&nbs=
p;&nbsp; UNDESIRED -&gt; UNDESIRED<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DESIRED -&gt; DESIRED=
<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ENABLED -&gt; ENABLED=
<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (old_state-&gt;content_protec=
tion =3D=3D state-&gt;content_protection)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (old_conn_state-&gt;content_p=
rotection =3D=3D new_conn_state-&gt;content_protection) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (new_conn_state-&gt;content_protection &gt;=3D DRM_MODE_=
CONTENT_PROTECTION_DESIRED) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (new_crt=
c_state &amp;&amp; new_crtc_state-&gt;mode_changed) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;[HDCP_DM] DESIRED-&gt;D=
ESIRED or ENABLE-&gt;ENABLE mode_change %s :true\n&quot;,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; __func__);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return true;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; };<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&q=
uot;[HDCP_DM] DESIRED-&gt;DESIRED &amp; ENABLE-&gt;ENABLE %s :false\n&quot;=
,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __func__);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return fals=
e;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; };<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; pr_debug(&quot;[HDCP_DM] UNDESIRED-&gt;UNDESIRED %s :false\=
n&quot;, __func__);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; return false;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Handles:&nbsp;&nbsp;&nbs=
p;&nbsp; UNDESIRED -&gt; DESIRED<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DESIRED -&gt; UNDESIR=
ED<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ENABLED -&gt; UNDESIR=
ED<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (state-&gt;content_protection=
 !=3D DRM_MODE_CONTENT_PROTECTION_ENABLED)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (new_conn_state-&gt;content_p=
rotection !=3D DRM_MODE_CONTENT_PROTECTION_ENABLED) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; pr_debug(&quot;[HDCP_DM] UNDESIRED-&gt;DESIRED or DESIRED-&=
gt;UNDESIRED or ENABLED-&gt;UNDESIRED %s :true\n&quot;,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __func__);<=
br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; return true;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Handles:&nbsp;&nbsp;&nbs=
p;&nbsp; DESIRED -&gt; ENABLED<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;[HDCP_DM] DESIRED=
-&gt;ENABLED %s :false\n&quot;, __func__);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return false;<br>
&gt;&nbsp; }<br>
&gt; -<br>
&gt;&nbsp; #endif<br>
&gt; +<br>
&gt;&nbsp; static void remove_stream(struct amdgpu_device *adev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; struct amdgpu_crtc *acrtc,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; struct dc_stream_state *stream)<br>
&gt; @@ -8322,6 +8359,10 @@ static void amdgpu_dm_atomic_commit_tail(struct=
 drm_atomic_state *state)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; n=
ew_crtc_state =3D drm_atomic_get_new_crtc_state(state, &amp;acrtc-&gt;base)=
;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; o=
ld_crtc_state =3D drm_atomic_get_old_crtc_state(state, &amp;acrtc-&gt;base)=
;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +&lt;&lt;&lt;&lt;&lt;&lt;&lt; HEAD<br>
&gt; +=3D=3D=3D=3D=3D=3D=3D<br>
&gt; +<br>
&gt; +&gt;&gt;&gt;&gt;&gt;&gt;&gt; 667f52144b9a (drm/amd/display: phase3 ms=
t hdcp for multiple displays)<br>
<br>
rebasing leftovers.<br>
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; if (old_crtc_state)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; p=
r_debug(&quot;old crtc en: %x a: %x m: %x a-chg: %x c-chg: %x\n&quot;,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; o=
ld_crtc_state-&gt;enable,<br>
&gt; @@ -8384,7 +8425,10 @@ static void amdgpu_dm_atomic_commit_tail(struct=
 drm_atomic_state *state)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_MODE_CONTENT_PROTECTION_=
DESIRED)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enable_encryption =3D true;<=
br>
&gt;<br>
&gt; +&lt;&lt;&lt;&lt;&lt;&lt;&lt; HEAD<br>
&gt;<br>
&gt; +=3D=3D=3D=3D=3D=3D=3D<br>
&gt; +&gt;&gt;&gt;&gt;&gt;&gt;&gt; 667f52144b9a (drm/amd/display: phase3 ms=
t hdcp for multiple displays)<br>
<br>
here too.<br>
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; i=
f (aconnector-&gt;dc_link &amp;&amp; aconnector-&gt;dc_sink &amp;&amp;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aconnector-&gt;dc_link-&gt;t=
ype =3D=3D dc_connection_mst_branch) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct hdcp_workqueue *hdcp_=
work =3D adev-&gt;dm.hdcp_workqueue;<br>
&gt; --<br>
&gt; 2.34.1<br>
&gt;<br>
</div>
</span></font></div>
</body>
</html>

--_000_BY5PR12MB4211EC8FBF40FFFB9699F0E8FB1C9BY5PR12MB4211namp_--
