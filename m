Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FDB2C48297
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Feb 2024 15:27:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A3A4810ED33;
	Mon, 12 Feb 2024 15:27:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AIbcmZRY";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2060.outbound.protection.outlook.com [40.107.94.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA10310ED64
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Feb 2024 15:27:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BJeCfqhmmJ7YzHT6fo/kHY3SH1btisPzOPoT4+EOkZXsIrT5UlilyscwK1QNF2qAQ9QrYHp0ItfbswjGbZhqx/thyAU3DF+yx5OAigXtMIk03L9rPMHv+Agj+TZa5/0/Mvx1TLwc4dBlF2eJaMXU9mS+BLFx3ztNnK9HAcHmZK7x21NU8GzJnRGIOguBKKzF5BcauieeQBWNBc7NGgjxkcIPpfT8v1mar32bOtAXWnurXGFC27T9F4Gn/U0izqVIxyly0HVX74/tsnja5D04LpCCW5Opfy3SbgZHAVQzKRkL751SgvOYo25I3zPxN2zEIYw3buXkhB/dhbE8mI3L6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VYYAVYR/xc355PZx2XGNSUNf4KmVVV3AGCeVZ/iyrUA=;
 b=OuG182hhl1Z4snavGNJ5nVtUFd3jppdqHRzzz625jkqLyCGzvSURx6ynUcJ83jeyS0x0hRh+QqkaMi80XAU1fQr4ldvCHrf1Bm2oojvd8f0cf056NVzSamTdCc8N9DkKZ6cD0CBf95hwpBBsR3bmkl/USBnBvNgGJ9QAnDXYeAQPk61A1VrzfnyQ/aR7BNWiLAMScEIM2MSYO/pFJbmowmHP1cNbvRkEufb80HHwiZdDu7FEnJEyYnhjvtM5sH8Td/tHFrujG3Uf6hXRmsAOGFbYvYrLCeHI7i8niyyZ1efM5bZPs3Y1/+e7bWz+6OhkggHysvl9P2qYBLolFL2yBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VYYAVYR/xc355PZx2XGNSUNf4KmVVV3AGCeVZ/iyrUA=;
 b=AIbcmZRYK2Bmc/gAZPe4iG8BldBhFaRVrMBUNHb0uZvXosUEOKrQXoJOn7Kb2z6pVyF6HajI4e9GDTtGbBeXLXwUTFMP6yQGQns82eH3ZvqDtKDtmtKeWnYMvpwonIRMneDe66IbF6yv4ZQBid+9QtQDkGJnp4qiEewDjGuCLBI=
Received: from CY8PR12MB8193.namprd12.prod.outlook.com (2603:10b6:930:71::22)
 by DM4PR12MB8499.namprd12.prod.outlook.com (2603:10b6:8:181::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.11; Mon, 12 Feb
 2024 15:27:37 +0000
Received: from CY8PR12MB8193.namprd12.prod.outlook.com
 ([fe80::92fa:88b3:a796:2c8c]) by CY8PR12MB8193.namprd12.prod.outlook.com
 ([fe80::92fa:88b3:a796:2c8c%5]) with mapi id 15.20.7292.022; Mon, 12 Feb 2024
 15:27:37 +0000
From: "Li, Roman" <Roman.Li@amd.com>
To: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>, "Pillai, Aurabindo"
 <Aurabindo.Pillai@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>, "Lakha, Bhawanpreet"
 <Bhawanpreet.Lakha@amd.com>, "Wentland, Harry" <Harry.Wentland@amd.com>
Subject: RE: [PATCH] drm/amd/display: Fix && vs || in
 'edp_set_replay_allow_active()'
Thread-Topic: [PATCH] drm/amd/display: Fix && vs || in
 'edp_set_replay_allow_active()'
Thread-Index: AQHaW2fBfa4bznJlBkGJo0ukFKFSlbEG2B/w
Date: Mon, 12 Feb 2024 15:27:36 +0000
Message-ID: <CY8PR12MB81939BC06D6CBE378598BA9D89482@CY8PR12MB8193.namprd12.prod.outlook.com>
References: <20240209145258.51727-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20240209145258.51727-1-srinivasan.shanmugam@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=8dc94589-ada7-4bf3-b678-11cbc671f95b;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-02-12T15:23:44Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB8193:EE_|DM4PR12MB8499:EE_
x-ms-office365-filtering-correlation-id: b437e50d-cb2f-4c91-23bc-08dc2bdf2487
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fHqV04fueEzs1vzLjbtofSlAGQ2ielYCpC30S9G+w4uABqHSBGTGZnd/FM6VGucHJc+knf5KTyYP7E2yxhrlesqekztxNxJ0v1WF2BzpESD1uSTT4EmGokjhLBX5le1L4y2YoVGX1QzfNHXlbWxMNlpiA2U43RkaLocGTZ2ub30NIAvCLy/5bYbOWDIDxVbL4riFoe55w1EA1Yi7VyM80WM1l6F4aTvHAtSjHTaReQsCzdN4UA1FhFAHYszs/4FKZnO4k+fsq/OxVWtvAkYFpyKQYBZHUiRi3WfeQzJH5DYFHZcCFBkMHUto++g4ZyljCFRrLEolVnfvfvMse/v666jVgLRfiYBk7fLLCMPFoe8d9gvjWpYh7NKJGkzi8xCf3NdI4Py3JSuvoQc+vF/QVzXkXMxcWmk90aNxbtNaH1gUO+eUC2RkSPaEzL/6Sw2sgEyeeiUsFMGLYW/+A/AjsTKUCXf0F2dqu65e8KHsPTW01FpMRcQR0iNQH6CqtnKe+r1U2btFtkOneFAAYuYaPJ7YU4ShHF0AWKUA0mpKcspNmOaRpIG4N5OVBoYCAnV1G/ffHGRXQBL/hbEufBYE6nNou/gTytdCmAjjLw0VRVI1foaGb/UkzE3DF59eNBnI
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB8193.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(396003)(366004)(376002)(346002)(136003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(7696005)(9686003)(26005)(478600001)(41300700001)(5660300002)(6506007)(54906003)(71200400001)(110136005)(53546011)(8936002)(38070700009)(83380400001)(122000001)(66476007)(38100700002)(64756008)(6636002)(86362001)(8676002)(66446008)(76116006)(4326008)(316002)(66946007)(66556008)(52536014)(33656002)(2906002)(55016003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?q/0vRWqftIGqdSFOZTWZAolIb25NZsrfMtFms7HU2W5hNABlv0OJcP7jeypG?=
 =?us-ascii?Q?lstuayxily6vBxf+sZFyQl4tfXU/2KSu0oVwCbTaMrF0+i5OJxprfNLza5C0?=
 =?us-ascii?Q?V5ETY2e2q1BfGnteLHrZx8kscgKid3zmzJBhYC73Sz3H81oI5HiNIX8AdbbX?=
 =?us-ascii?Q?YAE/E3bBh7IoFxrqvF3havg+7enFseRLGJ8S6CS9wzeu1FbDtKmvIutQv7z4?=
 =?us-ascii?Q?Qzyo7AzVST4v1g262C3krG1pv4gVC81+S9HnKNcnveL0TU8+lxY7AtolWbV3?=
 =?us-ascii?Q?jC72Ty/dxz9kY6vqJ1akv+WpPDeyOIhztBlWmEoNRW6k8+b/e2AJ6jr7oaGG?=
 =?us-ascii?Q?1IUSk6/nVAPFYBXDmRLNMTQzNV8qKrB38p8sUtsnlivFovhsU9zg7g7FkMM0?=
 =?us-ascii?Q?yT6V3CEMu/BFRLHiV6RIhn/XdcNktXf2Zcml96IWymfBfzsr94ShWmUHvgvk?=
 =?us-ascii?Q?I4gOor1fFb5Z4GqXrBO5W0rsD4YJBijqM2567JIqEdo+UW7QEw9utW3tr2eZ?=
 =?us-ascii?Q?4iOZ6uKaVOJcsu/X6eSEeVIg08B9QYNGrLPVwYEn6msY/429MbmWQiNVs2PW?=
 =?us-ascii?Q?KEfW+AjjfpTGy4wr12Mnzg8nxSWdhCzdGufmxwyLoHVWwNwYkFXYMps7w9X1?=
 =?us-ascii?Q?/tzWekxdUgnvyDGe9ZlpchPlEl+cOiJy0OB/x9oGXLdwa3qxHD13fcr07zMO?=
 =?us-ascii?Q?Pg6xaLW3xXZ794TWVTJqQQk5a64+Uca8ipl1NSPNE1kpyItdjRIjYCcuUkJz?=
 =?us-ascii?Q?j1RwkfwXiaAiJQseSsoGX2eypdz8GSF5S2MC0Vg1t2mAl9hQzvRBqPH8vd5x?=
 =?us-ascii?Q?Imz4XMrGoSECig3HM2QM72dCVVy/atki5jBr/YjNJHNbIbydwlvDooGMeNUc?=
 =?us-ascii?Q?E6Ae2fdxNiBRgp0k6JhKmkClQ8ANeC9o606wLIP3qJou11ahOXHclXpXhDZC?=
 =?us-ascii?Q?Av07ijDlyBJIJxsLXGuGIu6hBqs2e1x8pTOwJZL15+UoU/YdWUCFX8xmGe/M?=
 =?us-ascii?Q?TfwbfOqxHo6GvWe4tdwdnlGIF0icA/kJWap1W/lRMmJc7r2o/KYWEuNFt4RC?=
 =?us-ascii?Q?mjLYI8bRySQRRZVDL657p9ykOqsv0pV87DCl9h/GslD65i5WzaA93tAnZton?=
 =?us-ascii?Q?1lK7O/OWtyKz9qbUijJHhPqhbsFrK1t3+GVYVosNDMK5zmT/2gqAyREiNkTP?=
 =?us-ascii?Q?YM5aWMwptg9WUrQMyYNh1odQMCoy0y7loJN3WOwwm+4ZSa52Z2qQ/6JWk9eo?=
 =?us-ascii?Q?gAilpRF6LZMSRDYjHyE4X7A4x4bNHSJUlT2KjfQ+GPngPyYlFcyOiOB8zLU+?=
 =?us-ascii?Q?Gon7pSpP4IML2Ta9/E4UozgnHcu/ecEgSxNo2ybWtUZ8SZ8uaXBtLli+qgx+?=
 =?us-ascii?Q?DcAjIYlEt4Fej/FQX9hupxJpnfMxOi7dF8bGk4WrebVgr25I9iwWU4GH8tcc?=
 =?us-ascii?Q?cspnsVA40iT7XCtvezU/mLM6Iou4F3cYXorx3hk0jrFCEEWgca/nlqcuTUX2?=
 =?us-ascii?Q?/Bm7UA3FAuYtUt8UJeW7gfcPaQM7W/n9Ta+eP9MPDqeol9EehqkKkC/ZqKOe?=
 =?us-ascii?Q?IT48XiQhmP9W3pjxyNw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB8193.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b437e50d-cb2f-4c91-23bc-08dc2bdf2487
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2024 15:27:37.0214 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0+PGP3eLJ+UeaZjh4KHjQze7rC7/Tij2ZrSzat29yOR2pxcEmeKlGqsMLL9yv4bO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8499
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

[AMD Official Use Only - General]

Reviewed-by: Roman Li <roman.li@amd.com>

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> Srinivasan Shanmugam
> Sent: Friday, February 9, 2024 9:53 AM
> To: Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>; Pillai, Aurabindo
> <Aurabindo.Pillai@amd.com>
> Cc: amd-gfx@lists.freedesktop.org; SHANMUGAM, SRINIVASAN
> <SRINIVASAN.SHANMUGAM@amd.com>; Lakha, Bhawanpreet
> <Bhawanpreet.Lakha@amd.com>; Wentland, Harry
> <Harry.Wentland@amd.com>
> Subject: [PATCH] drm/amd/display: Fix && vs || in
> 'edp_set_replay_allow_active()'
>
> AND should be OR or it will lead to a NULL dereference.
>
> Fixes the below:
> drivers/gpu/drm/amd/amdgpu/../display/dc/link/protocols/link_edp_panel_
> control.c:895 edp_set_replay_allow_active() error: we previously assumed
> 'replay' could be null (see line 887)
>
> Fixes: c7ddc0a800bc ("drm/amd/display: Add Functions to enable Freesync
> Panel Replay")
> Cc: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>  .../drm/amd/display/dc/link/protocols/link_edp_panel_control.c  | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git
> a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
> b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
> index 443215b96308..77648228ec60 100644
> ---
> a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
> +++
> b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
> @@ -884,7 +884,7 @@ bool edp_set_replay_allow_active(struct dc_link
> *link, const bool *allow_active,
>       struct dmub_replay *replay =3D dc->res_pool->replay;
>       unsigned int panel_inst;
>
> -     if (replay =3D=3D NULL && force_static)
> +     if (!replay || force_static)
>               return false;
>
>       if (!dc_get_edp_link_panel_inst(dc, link, &panel_inst))
> --
> 2.34.1

