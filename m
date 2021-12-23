Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83B9AC433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Dec 2021 20:44:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 624F710E406;
	Thu, 23 Dec 2021 20:44:34 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2080.outbound.protection.outlook.com [40.107.93.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 12B3A10E401
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Dec 2021 20:44:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FXwrLSo7RYpVf0MrxQlPrNSXlkrqCrNuXaaRQ9KHMRAUiC4VtPG2W9mmYMaUqfgBqF7wHZbXAOl6MhltGo33jFIftrqw4gNrN4Uv5XS2fCJJHUprWv5S8Df5l4XnIBKK8zqdjxiRGkpPEXiZ8SfcbO8AY7SJqL/u38v3BzW/oxoZ4Dhw3RKejgzjkUmHDuoXpiWGCOLrKqGUdbtrA4sNHODFkdSx4sCJrAB6lGUOzjbd8U24utq6R87u1QK3jj14hrDPRYJS4qZxkyGXjCVc5Hw54NYSFqMphTtxTwqbuzs56FH9489BjDJTjWi9Ohf/ZYH8OiBXLvpD7Y56HJcQRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o6UjMtWmIMkIZatu5xcSMPwbnDI+4kI0edQop6flZCo=;
 b=lW47PWtGhXCvoWoRlJY9DjrEt1OgIDV+jwjufxYG/f745qjmhy6FiK2fjWnr7wAYmCjox+pkpBlFgOuhryD/GAw4Z4pGqRuISbX0e94wO1MA4yItTAeRy2JAfVLgx3dLCxZEOVWanfKCpeUBDtSWhCFf1JzAzWEFlpLjjdHhVKf+NdZxnLKJ4LzjQlgsZ77eLHPiVney0B7GLR6ux73YB03wTFVHDZbf8V0hFCqxzYXi4X4SWU72cksZ04Y3Qpo04Lin0Y3Ufi7wUK+P1+vDTT18bKUQY3f1QH/+BIbrsZ05Zcs6ew8bYniVA1UfBlka0K/2068Xx4h5LfbEfdMQpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o6UjMtWmIMkIZatu5xcSMPwbnDI+4kI0edQop6flZCo=;
 b=GjEc4/7IqG6PDDu07iyzGZ45cqSWNQhuqv0m5pt0/dl6sCiqK/Q3ojDugXtXqg4UUWM/faLq2T4ecO03a1wtPXwypEG9x1zWkqpdx0ZmEuPCjukdv2Zti165HxQc6yNoG2wrhn0HVs5TeX14Bc6TzsoIV7SStOtJIIAF5rujd4Q=
Received: from BY5PR12MB4211.namprd12.prod.outlook.com (2603:10b6:a03:20f::19)
 by BY5PR12MB4051.namprd12.prod.outlook.com (2603:10b6:a03:20c::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.19; Thu, 23 Dec
 2021 20:44:30 +0000
Received: from BY5PR12MB4211.namprd12.prod.outlook.com
 ([fe80::3591:bf95:c698:4d3a]) by BY5PR12MB4211.namprd12.prod.outlook.com
 ([fe80::3591:bf95:c698:4d3a%5]) with mapi id 15.20.4801.024; Thu, 23 Dec 2021
 20:44:30 +0000
From: "Dhillon, Jasdeep" <Jasdeep.Dhillon@amd.com>
To: "isabbasso@riseup.net" <isabbasso@riseup.net>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>,
 "daniel@ffwll.ch" <daniel@ffwll.ch>, "Wentland, Harry"
 <Harry.Wentland@amd.com>, "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
 "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>, "Pan, Xinhui"
 <Xinhui.Pan@amd.com>, "Zhuo, Qingqing (Lillian)" <Qingqing.Zhuo@amd.com>,
 "mwen@igalia.com" <mwen@igalia.com>
Subject: Re: [PATCH v2] drm/amd/display: move calcs folder into DML
Thread-Topic: [PATCH v2] drm/amd/display: move calcs folder into DML
Thread-Index: AQHX9fhf/BmbZdaIJ0SkYEjASRRnLKw8BUyAgASFqXk=
Date: Thu, 23 Dec 2021 20:44:30 +0000
Message-ID: <BY5PR12MB42117515E3411EFF7F6602B6FB7E9@BY5PR12MB4211.namprd12.prod.outlook.com>
References: <20211220232047.1327228-1-isabbasso@riseup.net>
 <8cd2132a5242a15f48628dc993110fc2@riseup.net>
In-Reply-To: <8cd2132a5242a15f48628dc993110fc2@riseup.net>
Accept-Language: en-CA, en-US
Content-Language: en-CA
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=True;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-12-23T20:44:29.935Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use
 Only; MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard; 
suggested_attachment_session_id: 3354e0f6-6630-b3f7-c508-037146eea1ae
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0a0882cd-a6e9-4ec8-de05-08d9c65504cc
x-ms-traffictypediagnostic: BY5PR12MB4051:EE_
x-microsoft-antispam-prvs: <BY5PR12MB4051FC37E40D49B482BB27B5FB7E9@BY5PR12MB4051.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iD68ViHvCWICduAa3zi2dB5JZKWBEFro2cVbW7m/4ohAgneP2JCYuPrSQytd0ZQthZ0vsbuH+w+hOCyfPi/8Qh54r6ZukWQozu1BzPUswON+27mUqyTxUFGt4pHsP/lcjk6oYttfG5tragZ2XscEUSLRkuKPvYrI9mOmkv3QYMYrQ2QO4EHz6lqqTgKpfM3akcdoUKkYhuE06PvEZ1EjWqQI8kBjDZN8QpaLhlJpOHox+mnuiAPD3+dzfuu3Rtekm7tFsBeKUuOojNlqA0lemxjGrFssFrgqf9Lt9af/AYz4OtDwd08efoCyqyYGjKXNcZZunkSvEIqW9VVbnxnwXaDleeuHiETOIxjR20cdFQfGMtFGnroPrgHUUuaBWQWB46pm7QsrAzMoCtucAK1dOF5lic/aARdvAiINEFk3owSl0xomGqMJbdzO9ao/Gtl/nvSkpcHo4lUlmPni6vIy+wb6irI18WLUSbapiAGdxWIJtSBuQHmRjk5509PSHwZi52+mmK541ZKma9jLXwPX3LAdt1keGH2aoTSihK/6T4TRap53wV/CrV9Q0G4Gv0V3ruJfJnQCdjO3HWv1wkvflIviFvmq3GuMD6zg2wEwpt6ahrjQMhh+U3SMAGf+CP0dQp0Bbgv6n/kBiY40KepFH4IT9pjAChNtZr4XSoad8kDknGsHm8W4lwHGd04J3XJuoS+CO1GLL00aCYGSweCy9x0IjF/JJCwnAXpbVUc1UcM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4211.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(5660300002)(8676002)(30864003)(122000001)(38070700005)(38100700002)(8936002)(33656002)(45080400002)(86362001)(55016003)(9686003)(66476007)(53546011)(6506007)(66556008)(52536014)(64756008)(19627405001)(71200400001)(186003)(4001150100001)(921005)(7696005)(966005)(76116006)(166002)(66446008)(91956017)(83380400001)(2906002)(4326008)(508600001)(316002)(110136005)(54906003)(66946007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9DC3laEecVquZh3v9xJ5e4wdf7E/NVXm9d0H8ec1pMPIt5OyXLSMldyhWyI7?=
 =?us-ascii?Q?jBbHo4qm0vRMUq6ih0hNuqXRkspPdc1Ci4Nrj2p29ozNz4PQJoP7hP1RmsVG?=
 =?us-ascii?Q?kumgHe3Fp5K0vkCYc5X+4gyUwaJRHcPQ3Bjyzaomi8/8+Tz3NvzBvJOA2Y1o?=
 =?us-ascii?Q?8SrUcz4EC20bFOeUp6Qoys7CFRly/b+b5azZWDd9GdJxW7W62KCbyMy/Whv5?=
 =?us-ascii?Q?uUMp0BgpDk+t8ckVyVCbKuRfXIGNGxjtfL1rLDBSKSg6gTlZYHj5s2azGWFy?=
 =?us-ascii?Q?gDoqzzfSnC+4dmenrDCWTR0fEiSacQB5YtyWnJ42CX5MUSZ960LD8PiDowRF?=
 =?us-ascii?Q?TXmlZjPEfSO/XARqWsYxOtmeC7kk+f6kc82eN3lL+p5fEUbBjyn12o26xc5f?=
 =?us-ascii?Q?/2QtjIEFsGKsjTsE42L29TZ4EtiGg+m7tjiCaYcUlqE0ezqlXYGjyLu+4g8x?=
 =?us-ascii?Q?tC9HhzKf+tvcPc6GYilI6yRFL6ZnZqC0tqcyVkmmc5K1/SZcw1J9Ile2OewM?=
 =?us-ascii?Q?qlwLKsxNBMuAYvsWj6Ak3Gb41lzAwtrt0xrhRV4aS4PQMOswBBQwUQmxgfpI?=
 =?us-ascii?Q?pAGOz8fWcSiboP31IktoJgq7AaqcbhkUrjQ/NhQpsMZ6tpk4sN2figKT0v3l?=
 =?us-ascii?Q?tMJDymX9BbNv/kHtMZczWcigJBfpXYXgjv0ZL4L/JDfKFgGGqTfgiyzc2E/3?=
 =?us-ascii?Q?PyCnDLTYfz/Edvu4XPWxW9auHse/xfGvYv6LAB9LmoDXdgfyiqwAEcqiPY8S?=
 =?us-ascii?Q?Tfy6WHzUZaaNZqu1S/fYUca3fuA1+XuFdsscPomFpw3WuZuTe4OUcNcnnP96?=
 =?us-ascii?Q?KoaqMbn2xTAuOUd1SpndeHcw8FkdZBGV+1QKl19tFDvByDb60H2HXAS8TCt3?=
 =?us-ascii?Q?G2QPrPYMmgeIm94A3tdo1zPjSdb788SsgaTErsueCJH6a9BQ77W08bCNms1D?=
 =?us-ascii?Q?IbDiBE6Rbqgi4P3QmjAz+N1ZrPi6pLSifStfDlB4z2Y3+qzEgLfTulpvbdIX?=
 =?us-ascii?Q?Kt3AX7LSIjt5yZzcEagx9jrOEi1DvIR3cns2yvPycyh4m7/gwM6mQKTyl+3o?=
 =?us-ascii?Q?WsyZjptznY00qzgBNPGiMa8oxkXJ+NxmI7SEiJJxohRsyUCHsivGwVCNH/Dt?=
 =?us-ascii?Q?imuY9Y9+vGBEcEdbLIZH+NVCHz9PYdOmIuyAO9yNVtstSsJkMu3olYncP1lD?=
 =?us-ascii?Q?E5khPMeDlW7hiRQvBM7m4v12gWbzxiCHo/jhK8Q8FyeC4ELM95JRsVd+emzX?=
 =?us-ascii?Q?Cft9JIs3UWIpgol4LJ6yxL7R/FeNkoS23m69tqvWzL54G6v2o4R2gCskq29V?=
 =?us-ascii?Q?RjJJa7yZBaKkiF/aRNvX2YqBzq87N00HGQzpr2B9oe0/p59ROs+EIt602tD8?=
 =?us-ascii?Q?rxJ0nNSSjfsCqnoIz5wM+x6TrAQ4NireBTbgQT7i4QgSdqnkb2iJx9TnF5vO?=
 =?us-ascii?Q?hHFjiVgOu8O6iVqheehjdbtFzFabkcJqBYiSM/rUMpwufdsPLl6IsJZwJ6ay?=
 =?us-ascii?Q?/He214ePiWLYAGWmN9kFpZnrIjKZndbKmXPSBgdByO8h1e10216DOPErYh+g?=
 =?us-ascii?Q?BUlA6AUNlYHFDG+FrIb10kNcG6LATL/uNV9XqtMB8LY1jgymHxgqmiYHGQtN?=
 =?us-ascii?Q?HOdRM6RbFMJoeY7ksyemb5i1mkJMNDyD7C8wMx0vK0zFkW6+h1N4SgTU5cvb?=
 =?us-ascii?Q?kOQ3xA=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BY5PR12MB42117515E3411EFF7F6602B6FB7E9BY5PR12MB4211namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4211.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a0882cd-a6e9-4ec8-de05-08d9c65504cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Dec 2021 20:44:30.2971 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xbTVvPWBlbTNsmoltYCF1wgTVnF15s4GedYg6OoFc7j5dAdif6aewdl8kLwQNINYduSDGuLWp/A8WqjwocDR8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4051
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
Cc: "~lkcamp/patches@lists.sr.ht" <~lkcamp/patches@lists.sr.ht>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BY5PR12MB42117515E3411EFF7F6602B6FB7E9BY5PR12MB4211namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]

Hi Isabbasso,

The patch fails to compile when there is No DCN because the calc object fil=
es fail to generate since dml depends on the CONFIG_DRM_AMD_DC_DCN being en=
abled (Makefile inside dc folder):

ifdef CONFIG_DRM_AMD_DC_DCN
DC_LIBS +=3D dcn20
DC_LIBS +=3D dsc
DC_LIBS +=3D dcn10 dml
DC_LIBS +=3D dcn21
DC_LIBS +=3D dcn30
DC_LIBS +=3D dcn301
DC_LIBS +=3D dcn302
DC_LIBS +=3D dcn303
endif


A few changes need to be made to the patch, which are:

-The Makefile in dc needs the line: DC_LIBS+=3D dml/calcs
-the Makefile in the calcs folder that the patch deletes can be placed insi=
de of dc/dml/calcs instead of adding it to the Makefiles in dc/dml

Could you revise your patch based on these changes.

Regards,
Jasdeep
________________________________
From: isabbasso@riseup.net <isabbasso@riseup.net>
Sent: December 20, 2021 6:23 PM
To: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Chri=
stian.Koenig@amd.com>; daniel@ffwll.ch <daniel@ffwll.ch>; Wentland, Harry <=
Harry.Wentland@amd.com>; Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>; Li, =
Sun peng (Leo) <Sunpeng.Li@amd.com>; Pan, Xinhui <Xinhui.Pan@amd.com>; Zhuo=
, Qingqing (Lillian) <Qingqing.Zhuo@amd.com>; Dhillon, Jasdeep <Jasdeep.Dhi=
llon@amd.com>; mwen@igalia.com <mwen@igalia.com>
Cc: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; ~lkcamp/=
patches@lists.sr.ht <~lkcamp/patches@lists.sr.ht>
Subject: Re: [PATCH v2] drm/amd/display: move calcs folder into DML

On 2021-12-20 20:20, Isabella Basso wrote:
> The calcs folder has FPU code on it, which should be isolated inside the
> DML folder as per https://nam11.safelinks.protection.outlook.com/?url=3Dh=
ttps%3A%2F%2Fpatchwork.freedesktop.org%2Fseries%2F93042%2F&amp;data=3D04%7C=
01%7Cjasdeep.dhillon%40amd.com%7C01959e019f6e45e25a6208d9c40fc233%7C3dd8961=
fe4884e608e11a82d994e183d%7C0%7C0%7C637756394247493762%7CUnknown%7CTWFpbGZs=
b3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C30=
00&amp;sdata=3DbB4zotGMArbsTzZNDr0u2uw3VBD4jxNornJMol9YJlA%3D&amp;reserved=
=3D0.
>
> This commit aims single-handedly to correct the location of such FPU
> code and does not refactor any functions.
>
> Signed-off-by: Isabella Basso <isabbasso@riseup.net>
> ---
>  drivers/gpu/drm/amd/display/dc/Makefile       |  2 +-
>  drivers/gpu/drm/amd/display/dc/calcs/Makefile | 68 -------------------
>  drivers/gpu/drm/amd/display/dc/dml/Makefile   | 13 +++-
>  .../amd/display/dc/{ =3D> dml}/calcs/bw_fixed.c |  0
>  .../display/dc/{ =3D> dml}/calcs/calcs_logger.h |  0
>  .../display/dc/{ =3D> dml}/calcs/custom_float.c |  0
>  .../display/dc/{ =3D> dml}/calcs/dce_calcs.c    |  0
>  .../dc/{ =3D> dml}/calcs/dcn_calc_auto.c        |  0
>  .../dc/{ =3D> dml}/calcs/dcn_calc_auto.h        |  0
>  .../dc/{ =3D> dml}/calcs/dcn_calc_math.c        |  0
>  .../display/dc/{ =3D> dml}/calcs/dcn_calcs.c    |  0
>  11 files changed, 13 insertions(+), 70 deletions(-)
>  delete mode 100644 drivers/gpu/drm/amd/display/dc/calcs/Makefile
>  rename drivers/gpu/drm/amd/display/dc/{ =3D> dml}/calcs/bw_fixed.c (100%=
)
>  rename drivers/gpu/drm/amd/display/dc/{ =3D> dml}/calcs/calcs_logger.h (=
100%)
>  rename drivers/gpu/drm/amd/display/dc/{ =3D> dml}/calcs/custom_float.c (=
100%)
>  rename drivers/gpu/drm/amd/display/dc/{ =3D> dml}/calcs/dce_calcs.c (100=
%)
>  rename drivers/gpu/drm/amd/display/dc/{ =3D> dml}/calcs/dcn_calc_auto.c =
(100%)
>  rename drivers/gpu/drm/amd/display/dc/{ =3D> dml}/calcs/dcn_calc_auto.h =
(100%)
>  rename drivers/gpu/drm/amd/display/dc/{ =3D> dml}/calcs/dcn_calc_math.c =
(100%)
>  rename drivers/gpu/drm/amd/display/dc/{ =3D> dml}/calcs/dcn_calcs.c (100=
%)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/Makefile
> b/drivers/gpu/drm/amd/display/dc/Makefile
> index b1f0d6260226..1872adc96a00 100644
> --- a/drivers/gpu/drm/amd/display/dc/Makefile
> +++ b/drivers/gpu/drm/amd/display/dc/Makefile
> @@ -23,7 +23,7 @@
>  # Makefile for Display Core (dc) component.
>  #
>
> -DC_LIBS =3D basics bios calcs clk_mgr dce gpio irq virtual
> +DC_LIBS =3D basics bios clk_mgr dce gpio irq virtual
>
>  ifdef CONFIG_DRM_AMD_DC_DCN
>  DC_LIBS +=3D dcn20
> diff --git a/drivers/gpu/drm/amd/display/dc/calcs/Makefile
> b/drivers/gpu/drm/amd/display/dc/calcs/Makefile
> deleted file mode 100644
> index f3c00f479e1c..000000000000
> --- a/drivers/gpu/drm/amd/display/dc/calcs/Makefile
> +++ /dev/null
> @@ -1,68 +0,0 @@
> -#
> -# Copyright 2017 Advanced Micro Devices, Inc.
> -# Copyright 2019 Raptor Engineering, LLC
> -#
> -# Permission is hereby granted, free of charge, to any person obtaining =
a
> -# copy of this software and associated documentation files (the "Softwar=
e"),
> -# to deal in the Software without restriction, including without limitat=
ion
> -# the rights to use, copy, modify, merge, publish, distribute, sublicens=
e,
> -# and/or sell copies of the Software, and to permit persons to whom the
> -# Software is furnished to do so, subject to the following conditions:
> -#
> -# The above copyright notice and this permission notice shall be include=
d in
> -# all copies or substantial portions of the Software.
> -#
> -# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRES=
S OR
> -# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILIT=
Y,
> -# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHA=
LL
> -# THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES =
OR
> -# OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> -# ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> -# OTHER DEALINGS IN THE SOFTWARE.
> -#
> -#
> -# Makefile for the 'calcs' sub-component of DAL.
> -# It calculates Bandwidth and Watermarks values for HW programming
> -#
> -
> -ifdef CONFIG_X86
> -calcs_ccflags :=3D -mhard-float -msse
> -endif
> -
> -ifdef CONFIG_PPC64
> -calcs_ccflags :=3D -mhard-float -maltivec
> -endif
> -
> -ifdef CONFIG_CC_IS_GCC
> -ifeq ($(call cc-ifversion, -lt, 0701, y), y)
> -IS_OLD_GCC =3D 1
> -endif
> -endif
> -
> -ifdef CONFIG_X86
> -ifdef IS_OLD_GCC
> -# Stack alignment mismatch, proceed with caution.
> -# GCC < 7.1 cannot compile code using `double` and -mpreferred-stack-bou=
ndary=3D3
> -# (8B stack alignment).
> -calcs_ccflags +=3D -mpreferred-stack-boundary=3D4
> -else
> -calcs_ccflags +=3D -msse2
> -endif
> -endif
> -
> -CFLAGS_$(AMDDALPATH)/dc/calcs/dcn_calcs.o :=3D $(calcs_ccflags)
> -CFLAGS_$(AMDDALPATH)/dc/calcs/dcn_calc_auto.o :=3D $(calcs_ccflags)
> -CFLAGS_$(AMDDALPATH)/dc/calcs/dcn_calc_math.o :=3D $(calcs_ccflags)
> -Wno-tautological-compare
> -CFLAGS_REMOVE_$(AMDDALPATH)/dc/calcs/dcn_calcs.o :=3D $(calcs_rcflags)
> -CFLAGS_REMOVE_$(AMDDALPATH)/dc/calcs/dcn_calc_auto.o :=3D $(calcs_rcflag=
s)
> -CFLAGS_REMOVE_$(AMDDALPATH)/dc/calcs/dcn_calc_math.o :=3D $(calcs_rcflag=
s)
> -
> -BW_CALCS =3D dce_calcs.o bw_fixed.o custom_float.o
> -
> -ifdef CONFIG_DRM_AMD_DC_DCN
> -BW_CALCS +=3D dcn_calcs.o dcn_calc_math.o dcn_calc_auto.o
> -endif
> -
> -AMD_DAL_BW_CALCS =3D $(addprefix $(AMDDALPATH)/dc/calcs/,$(BW_CALCS))
> -
> -AMD_DISPLAY_FILES +=3D $(AMD_DAL_BW_CALCS)
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/Makefile
> b/drivers/gpu/drm/amd/display/dc/dml/Makefile
> index eee6672bd32d..82f26da6778e 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/Makefile
> +++ b/drivers/gpu/drm/amd/display/dc/dml/Makefile
> @@ -73,6 +73,11 @@
> CFLAGS_$(AMDDALPATH)/dc/dml/dcn31/display_rq_dlg_calc_31.o :=3D
> $(dml_ccflags)
>  CFLAGS_$(AMDDALPATH)/dc/dml/dcn301/dcn301_fpu.o :=3D $(dml_ccflags)
>  CFLAGS_$(AMDDALPATH)/dc/dml/dsc/rc_calc_fpu.o :=3D $(dml_ccflags)
>  CFLAGS_$(AMDDALPATH)/dc/dml/display_mode_lib.o :=3D $(dml_ccflags)
> +
> +CFLAGS_$(AMDDALPATH)/dc/dml/calcs/dcn_calcs.o :=3D $(dml_ccflags)
> +CFLAGS_$(AMDDALPATH)/dc/dml/calcs/dcn_calc_auto.o :=3D $(dml_ccflags)
> +CFLAGS_$(AMDDALPATH)/dc/dml/calcs/dcn_calc_math.o :=3D $(dml_ccflags)
> -Wno-tautological-compare
> +
>  CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/display_mode_vba.o :=3D $(dml_rcflags=
)
>  CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn2x/dcn2x.o :=3D $(dml_rcflags)
>  CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn20/display_mode_vba_20.o :=3D
> $(dml_rcflags)
> @@ -94,7 +99,11 @@
> CFLAGS_$(AMDDALPATH)/dc/dml/display_rq_dlg_helpers.o :=3D $(dml_ccflags)
>  CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dml1_display_rq_dlg_calc.o :=3D $(dml=
_rcflags)
>  CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/display_rq_dlg_helpers.o :=3D $(dml_r=
cflags)
>
> -DML =3D display_mode_lib.o display_rq_dlg_helpers.o dml1_display_rq_dlg_=
calc.o \
> +CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/calcs/dcn_calcs.o :=3D $(dml_rcflags)
> +CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/calcs/dcn_calc_auto.o :=3D $(dml_rcfl=
ags)
> +CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/calcs/dcn_calc_math.o :=3D $(dml_rcfl=
ags)
> +
> +DML =3D display_mode_lib.o display_rq_dlg_helpers.o dml1_display_rq_dlg_=
calc.o
>
>  ifdef CONFIG_DRM_AMD_DC_DCN
>  DML +=3D dcn20/dcn20_fpu.o
> @@ -105,6 +114,8 @@ DML +=3D dcn30/display_mode_vba_30.o
> dcn30/display_rq_dlg_calc_30.o
>  DML +=3D dcn31/display_mode_vba_31.o dcn31/display_rq_dlg_calc_31.o
>  DML +=3D dcn301/dcn301_fpu.o
>  DML +=3D dsc/rc_calc_fpu.o
> +DML +=3D calcs/dce_calcs.o calcs/bw_fixed.o calcs/custom_float.o
> +DML +=3D calcs/dcn_calcs.o calcs/dcn_calc_math.o calcs/dcn_calc_auto.o
>  endif
>
>  AMD_DAL_DML =3D $(addprefix $(AMDDALPATH)/dc/dml/,$(DML))
> diff --git a/drivers/gpu/drm/amd/display/dc/calcs/bw_fixed.c
> b/drivers/gpu/drm/amd/display/dc/dml/calcs/bw_fixed.c
> similarity index 100%
> rename from drivers/gpu/drm/amd/display/dc/calcs/bw_fixed.c
> rename to drivers/gpu/drm/amd/display/dc/dml/calcs/bw_fixed.c
> diff --git a/drivers/gpu/drm/amd/display/dc/calcs/calcs_logger.h
> b/drivers/gpu/drm/amd/display/dc/dml/calcs/calcs_logger.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/display/dc/calcs/calcs_logger.h
> rename to drivers/gpu/drm/amd/display/dc/dml/calcs/calcs_logger.h
> diff --git a/drivers/gpu/drm/amd/display/dc/calcs/custom_float.c
> b/drivers/gpu/drm/amd/display/dc/dml/calcs/custom_float.c
> similarity index 100%
> rename from drivers/gpu/drm/amd/display/dc/calcs/custom_float.c
> rename to drivers/gpu/drm/amd/display/dc/dml/calcs/custom_float.c
> diff --git a/drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c
> b/drivers/gpu/drm/amd/display/dc/dml/calcs/dce_calcs.c
> similarity index 100%
> rename from drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c
> rename to drivers/gpu/drm/amd/display/dc/dml/calcs/dce_calcs.c
> diff --git a/drivers/gpu/drm/amd/display/dc/calcs/dcn_calc_auto.c
> b/drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calc_auto.c
> similarity index 100%
> rename from drivers/gpu/drm/amd/display/dc/calcs/dcn_calc_auto.c
> rename to drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calc_auto.c
> diff --git a/drivers/gpu/drm/amd/display/dc/calcs/dcn_calc_auto.h
> b/drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calc_auto.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/display/dc/calcs/dcn_calc_auto.h
> rename to drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calc_auto.h
> diff --git a/drivers/gpu/drm/amd/display/dc/calcs/dcn_calc_math.c
> b/drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calc_math.c
> similarity index 100%
> rename from drivers/gpu/drm/amd/display/dc/calcs/dcn_calc_math.c
> rename to drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calc_math.c
> diff --git a/drivers/gpu/drm/amd/display/dc/calcs/dcn_calcs.c
> b/drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calcs.c
> similarity index 100%
> rename from drivers/gpu/drm/amd/display/dc/calcs/dcn_calcs.c
> rename to drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calcs.c

Hi all,

This isn't a v2, but actually a v1, I apologize for the mistake.

--
Isabella Basso

--_000_BY5PR12MB42117515E3411EFF7F6602B6FB7E9BY5PR12MB4211namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Hi Isabbasso,&nbsp;</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
The patch fails to compile when there is No DCN because the calc object fil=
es fail to generate since dml depends on the CONFIG_DRM_AMD_DC_DCN being en=
abled (Makefile inside dc folder):</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
ifdef CONFIG_DRM_AMD_DC_DCN
<div>DC_LIBS +=3D dcn20</div>
<div>DC_LIBS +=3D dsc</div>
<div>DC_LIBS +=3D dcn10 dml</div>
<div>DC_LIBS +=3D dcn21</div>
<div>DC_LIBS +=3D dcn30</div>
<div>DC_LIBS +=3D dcn301</div>
<div>DC_LIBS +=3D dcn302</div>
<div>DC_LIBS +=3D dcn303</div>
endif<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
A few changes need to be made to the patch, which are:</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
-The Makefile in dc needs the line:&nbsp;<span style=3D"color: rgb(0, 0, 0)=
; font-family: Calibri, Arial, Helvetica, sans-serif; font-size: 12pt;">DC_=
LIBS+=3D dml/calcs</span></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
-the Makefile in the calcs folder that the patch deletes can be placed insi=
de of dc/dml/calcs instead of adding it to the Makefiles in dc/dml&nbsp;</d=
iv>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Could you revise your patch based on these changes.&nbsp;</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Regards,&nbsp;</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Jasdeep</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> isabbasso@riseup.net =
&lt;isabbasso@riseup.net&gt;<br>
<b>Sent:</b> December 20, 2021 6:23 PM<br>
<b>To:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Koenig, Ch=
ristian &lt;Christian.Koenig@amd.com&gt;; daniel@ffwll.ch &lt;daniel@ffwll.=
ch&gt;; Wentland, Harry &lt;Harry.Wentland@amd.com&gt;; Siqueira, Rodrigo &=
lt;Rodrigo.Siqueira@amd.com&gt;; Li, Sun peng (Leo) &lt;Sunpeng.Li@amd.com&=
gt;;
 Pan, Xinhui &lt;Xinhui.Pan@amd.com&gt;; Zhuo, Qingqing (Lillian) &lt;Qingq=
ing.Zhuo@amd.com&gt;; Dhillon, Jasdeep &lt;Jasdeep.Dhillon@amd.com&gt;; mwe=
n@igalia.com &lt;mwen@igalia.com&gt;<br>
<b>Cc:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;; ~lkcamp/patches@lists.sr.ht &lt;~lkcamp/patches@lists.sr.ht&gt;<br>
<b>Subject:</b> Re: [PATCH v2] drm/amd/display: move calcs folder into DML<=
/font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">On 2021-12-20 20:20, Isabella Basso wrote:<br>
&gt; The calcs folder has FPU code on it, which should be isolated inside t=
he<br>
&gt; DML folder as per <a href=3D"https://nam11.safelinks.protection.outloo=
k.com/?url=3Dhttps%3A%2F%2Fpatchwork.freedesktop.org%2Fseries%2F93042%2F&am=
p;amp;data=3D04%7C01%7Cjasdeep.dhillon%40amd.com%7C01959e019f6e45e25a6208d9=
c40fc233%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637756394247493762%7C=
Unknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiL=
CJXVCI6Mn0%3D%7C3000&amp;amp;sdata=3DbB4zotGMArbsTzZNDr0u2uw3VBD4jxNornJMol=
9YJlA%3D&amp;amp;reserved=3D0">
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fpatchwo=
rk.freedesktop.org%2Fseries%2F93042%2F&amp;amp;data=3D04%7C01%7Cjasdeep.dhi=
llon%40amd.com%7C01959e019f6e45e25a6208d9c40fc233%7C3dd8961fe4884e608e11a82=
d994e183d%7C0%7C0%7C637756394247493762%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4w=
LjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;amp;sdata=
=3DbB4zotGMArbsTzZNDr0u2uw3VBD4jxNornJMol9YJlA%3D&amp;amp;reserved=3D0</a>.=
<br>
&gt; <br>
&gt; This commit aims single-handedly to correct the location of such FPU<b=
r>
&gt; code and does not refactor any functions.<br>
&gt; <br>
&gt; Signed-off-by: Isabella Basso &lt;isabbasso@riseup.net&gt;<br>
&gt; ---<br>
&gt;&nbsp; drivers/gpu/drm/amd/display/dc/Makefile&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; |&nbsp; 2 +-<br>
&gt;&nbsp; drivers/gpu/drm/amd/display/dc/calcs/Makefile | 68 -------------=
------<br>
&gt;&nbsp; drivers/gpu/drm/amd/display/dc/dml/Makefile&nbsp;&nbsp; | 13 +++=
-<br>
&gt;&nbsp; .../amd/display/dc/{ =3D&gt; dml}/calcs/bw_fixed.c |&nbsp; 0<br>
&gt;&nbsp; .../display/dc/{ =3D&gt; dml}/calcs/calcs_logger.h |&nbsp; 0<br>
&gt;&nbsp; .../display/dc/{ =3D&gt; dml}/calcs/custom_float.c |&nbsp; 0<br>
&gt;&nbsp; .../display/dc/{ =3D&gt; dml}/calcs/dce_calcs.c&nbsp;&nbsp;&nbsp=
; |&nbsp; 0<br>
&gt;&nbsp; .../dc/{ =3D&gt; dml}/calcs/dcn_calc_auto.c&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; |&nbsp; 0<br>
&gt;&nbsp; .../dc/{ =3D&gt; dml}/calcs/dcn_calc_auto.h&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; |&nbsp; 0<br>
&gt;&nbsp; .../dc/{ =3D&gt; dml}/calcs/dcn_calc_math.c&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; |&nbsp; 0<br>
&gt;&nbsp; .../display/dc/{ =3D&gt; dml}/calcs/dcn_calcs.c&nbsp;&nbsp;&nbsp=
; |&nbsp; 0<br>
&gt;&nbsp; 11 files changed, 13 insertions(+), 70 deletions(-)<br>
&gt;&nbsp; delete mode 100644 drivers/gpu/drm/amd/display/dc/calcs/Makefile=
<br>
&gt;&nbsp; rename drivers/gpu/drm/amd/display/dc/{ =3D&gt; dml}/calcs/bw_fi=
xed.c (100%)<br>
&gt;&nbsp; rename drivers/gpu/drm/amd/display/dc/{ =3D&gt; dml}/calcs/calcs=
_logger.h (100%)<br>
&gt;&nbsp; rename drivers/gpu/drm/amd/display/dc/{ =3D&gt; dml}/calcs/custo=
m_float.c (100%)<br>
&gt;&nbsp; rename drivers/gpu/drm/amd/display/dc/{ =3D&gt; dml}/calcs/dce_c=
alcs.c (100%)<br>
&gt;&nbsp; rename drivers/gpu/drm/amd/display/dc/{ =3D&gt; dml}/calcs/dcn_c=
alc_auto.c (100%)<br>
&gt;&nbsp; rename drivers/gpu/drm/amd/display/dc/{ =3D&gt; dml}/calcs/dcn_c=
alc_auto.h (100%)<br>
&gt;&nbsp; rename drivers/gpu/drm/amd/display/dc/{ =3D&gt; dml}/calcs/dcn_c=
alc_math.c (100%)<br>
&gt;&nbsp; rename drivers/gpu/drm/amd/display/dc/{ =3D&gt; dml}/calcs/dcn_c=
alcs.c (100%)<br>
&gt; <br>
&gt; diff --git a/drivers/gpu/drm/amd/display/dc/Makefile<br>
&gt; b/drivers/gpu/drm/amd/display/dc/Makefile<br>
&gt; index b1f0d6260226..1872adc96a00 100644<br>
&gt; --- a/drivers/gpu/drm/amd/display/dc/Makefile<br>
&gt; +++ b/drivers/gpu/drm/amd/display/dc/Makefile<br>
&gt; @@ -23,7 +23,7 @@<br>
&gt;&nbsp; # Makefile for Display Core (dc) component.<br>
&gt;&nbsp; #<br>
&gt;&nbsp; <br>
&gt; -DC_LIBS =3D basics bios calcs clk_mgr dce gpio irq virtual<br>
&gt; +DC_LIBS =3D basics bios clk_mgr dce gpio irq virtual<br>
&gt;&nbsp; <br>
&gt;&nbsp; ifdef CONFIG_DRM_AMD_DC_DCN<br>
&gt;&nbsp; DC_LIBS +=3D dcn20<br>
&gt; diff --git a/drivers/gpu/drm/amd/display/dc/calcs/Makefile<br>
&gt; b/drivers/gpu/drm/amd/display/dc/calcs/Makefile<br>
&gt; deleted file mode 100644<br>
&gt; index f3c00f479e1c..000000000000<br>
&gt; --- a/drivers/gpu/drm/amd/display/dc/calcs/Makefile<br>
&gt; +++ /dev/null<br>
&gt; @@ -1,68 +0,0 @@<br>
&gt; -#<br>
&gt; -# Copyright 2017 Advanced Micro Devices, Inc.<br>
&gt; -# Copyright 2019 Raptor Engineering, LLC<br>
&gt; -#<br>
&gt; -# Permission is hereby granted, free of charge, to any person obtaini=
ng a<br>
&gt; -# copy of this software and associated documentation files (the &quot=
;Software&quot;),<br>
&gt; -# to deal in the Software without restriction, including without limi=
tation<br>
&gt; -# the rights to use, copy, modify, merge, publish, distribute, sublic=
ense,<br>
&gt; -# and/or sell copies of the Software, and to permit persons to whom t=
he<br>
&gt; -# Software is furnished to do so, subject to the following conditions=
:<br>
&gt; -#<br>
&gt; -# The above copyright notice and this permission notice shall be incl=
uded in<br>
&gt; -# all copies or substantial portions of the Software.<br>
&gt; -#<br>
&gt; -# THE SOFTWARE IS PROVIDED &quot;AS IS&quot;, WITHOUT WARRANTY OF ANY=
 KIND, EXPRESS OR<br>
&gt; -# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABI=
LITY,<br>
&gt; -# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.&nbsp; IN NO E=
VENT SHALL<br>
&gt; -# THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAG=
ES OR<br>
&gt; -# OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWIS=
E,<br>
&gt; -# ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE =
OR<br>
&gt; -# OTHER DEALINGS IN THE SOFTWARE.<br>
&gt; -#<br>
&gt; -#<br>
&gt; -# Makefile for the 'calcs' sub-component of DAL.<br>
&gt; -# It calculates Bandwidth and Watermarks values for HW programming<br=
>
&gt; -#<br>
&gt; -<br>
&gt; -ifdef CONFIG_X86<br>
&gt; -calcs_ccflags :=3D -mhard-float -msse<br>
&gt; -endif<br>
&gt; -<br>
&gt; -ifdef CONFIG_PPC64<br>
&gt; -calcs_ccflags :=3D -mhard-float -maltivec<br>
&gt; -endif<br>
&gt; -<br>
&gt; -ifdef CONFIG_CC_IS_GCC<br>
&gt; -ifeq ($(call cc-ifversion, -lt, 0701, y), y)<br>
&gt; -IS_OLD_GCC =3D 1<br>
&gt; -endif<br>
&gt; -endif<br>
&gt; -<br>
&gt; -ifdef CONFIG_X86<br>
&gt; -ifdef IS_OLD_GCC<br>
&gt; -# Stack alignment mismatch, proceed with caution.<br>
&gt; -# GCC &lt; 7.1 cannot compile code using `double` and -mpreferred-sta=
ck-boundary=3D3<br>
&gt; -# (8B stack alignment).<br>
&gt; -calcs_ccflags +=3D -mpreferred-stack-boundary=3D4<br>
&gt; -else<br>
&gt; -calcs_ccflags +=3D -msse2<br>
&gt; -endif<br>
&gt; -endif<br>
&gt; -<br>
&gt; -CFLAGS_$(AMDDALPATH)/dc/calcs/dcn_calcs.o :=3D $(calcs_ccflags)<br>
&gt; -CFLAGS_$(AMDDALPATH)/dc/calcs/dcn_calc_auto.o :=3D $(calcs_ccflags)<b=
r>
&gt; -CFLAGS_$(AMDDALPATH)/dc/calcs/dcn_calc_math.o :=3D $(calcs_ccflags)<b=
r>
&gt; -Wno-tautological-compare<br>
&gt; -CFLAGS_REMOVE_$(AMDDALPATH)/dc/calcs/dcn_calcs.o :=3D $(calcs_rcflags=
)<br>
&gt; -CFLAGS_REMOVE_$(AMDDALPATH)/dc/calcs/dcn_calc_auto.o :=3D $(calcs_rcf=
lags)<br>
&gt; -CFLAGS_REMOVE_$(AMDDALPATH)/dc/calcs/dcn_calc_math.o :=3D $(calcs_rcf=
lags)<br>
&gt; -<br>
&gt; -BW_CALCS =3D dce_calcs.o bw_fixed.o custom_float.o<br>
&gt; -<br>
&gt; -ifdef CONFIG_DRM_AMD_DC_DCN<br>
&gt; -BW_CALCS +=3D dcn_calcs.o dcn_calc_math.o dcn_calc_auto.o<br>
&gt; -endif<br>
&gt; -<br>
&gt; -AMD_DAL_BW_CALCS =3D $(addprefix $(AMDDALPATH)/dc/calcs/,$(BW_CALCS))=
<br>
&gt; -<br>
&gt; -AMD_DISPLAY_FILES +=3D $(AMD_DAL_BW_CALCS)<br>
&gt; diff --git a/drivers/gpu/drm/amd/display/dc/dml/Makefile<br>
&gt; b/drivers/gpu/drm/amd/display/dc/dml/Makefile<br>
&gt; index eee6672bd32d..82f26da6778e 100644<br>
&gt; --- a/drivers/gpu/drm/amd/display/dc/dml/Makefile<br>
&gt; +++ b/drivers/gpu/drm/amd/display/dc/dml/Makefile<br>
&gt; @@ -73,6 +73,11 @@<br>
&gt; CFLAGS_$(AMDDALPATH)/dc/dml/dcn31/display_rq_dlg_calc_31.o :=3D<br>
&gt; $(dml_ccflags)<br>
&gt;&nbsp; CFLAGS_$(AMDDALPATH)/dc/dml/dcn301/dcn301_fpu.o :=3D $(dml_ccfla=
gs)<br>
&gt;&nbsp; CFLAGS_$(AMDDALPATH)/dc/dml/dsc/rc_calc_fpu.o :=3D $(dml_ccflags=
)<br>
&gt;&nbsp; CFLAGS_$(AMDDALPATH)/dc/dml/display_mode_lib.o :=3D $(dml_ccflag=
s)<br>
&gt; +<br>
&gt; +CFLAGS_$(AMDDALPATH)/dc/dml/calcs/dcn_calcs.o :=3D $(dml_ccflags)<br>
&gt; +CFLAGS_$(AMDDALPATH)/dc/dml/calcs/dcn_calc_auto.o :=3D $(dml_ccflags)=
<br>
&gt; +CFLAGS_$(AMDDALPATH)/dc/dml/calcs/dcn_calc_math.o :=3D $(dml_ccflags)=
<br>
&gt; -Wno-tautological-compare<br>
&gt; +<br>
&gt;&nbsp; CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/display_mode_vba.o :=3D $(dml=
_rcflags)<br>
&gt;&nbsp; CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn2x/dcn2x.o :=3D $(dml_rcfl=
ags)<br>
&gt;&nbsp; CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn20/display_mode_vba_20.o :=
=3D<br>
&gt; $(dml_rcflags)<br>
&gt; @@ -94,7 +99,11 @@<br>
&gt; CFLAGS_$(AMDDALPATH)/dc/dml/display_rq_dlg_helpers.o :=3D $(dml_ccflag=
s)<br>
&gt;&nbsp; CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dml1_display_rq_dlg_calc.o :=
=3D $(dml_rcflags)<br>
&gt;&nbsp; CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/display_rq_dlg_helpers.o :=3D=
 $(dml_rcflags)<br>
&gt;&nbsp; <br>
&gt; -DML =3D display_mode_lib.o display_rq_dlg_helpers.o dml1_display_rq_d=
lg_calc.o \<br>
&gt; +CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/calcs/dcn_calcs.o :=3D $(dml_rcfla=
gs)<br>
&gt; +CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/calcs/dcn_calc_auto.o :=3D $(dml_r=
cflags)<br>
&gt; +CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/calcs/dcn_calc_math.o :=3D $(dml_r=
cflags)<br>
&gt; +<br>
&gt; +DML =3D display_mode_lib.o display_rq_dlg_helpers.o dml1_display_rq_d=
lg_calc.o<br>
&gt;&nbsp; <br>
&gt;&nbsp; ifdef CONFIG_DRM_AMD_DC_DCN<br>
&gt;&nbsp; DML +=3D dcn20/dcn20_fpu.o<br>
&gt; @@ -105,6 +114,8 @@ DML +=3D dcn30/display_mode_vba_30.o<br>
&gt; dcn30/display_rq_dlg_calc_30.o<br>
&gt;&nbsp; DML +=3D dcn31/display_mode_vba_31.o dcn31/display_rq_dlg_calc_3=
1.o<br>
&gt;&nbsp; DML +=3D dcn301/dcn301_fpu.o<br>
&gt;&nbsp; DML +=3D dsc/rc_calc_fpu.o<br>
&gt; +DML +=3D calcs/dce_calcs.o calcs/bw_fixed.o calcs/custom_float.o<br>
&gt; +DML +=3D calcs/dcn_calcs.o calcs/dcn_calc_math.o calcs/dcn_calc_auto.=
o<br>
&gt;&nbsp; endif<br>
&gt;&nbsp; <br>
&gt;&nbsp; AMD_DAL_DML =3D $(addprefix $(AMDDALPATH)/dc/dml/,$(DML))<br>
&gt; diff --git a/drivers/gpu/drm/amd/display/dc/calcs/bw_fixed.c<br>
&gt; b/drivers/gpu/drm/amd/display/dc/dml/calcs/bw_fixed.c<br>
&gt; similarity index 100%<br>
&gt; rename from drivers/gpu/drm/amd/display/dc/calcs/bw_fixed.c<br>
&gt; rename to drivers/gpu/drm/amd/display/dc/dml/calcs/bw_fixed.c<br>
&gt; diff --git a/drivers/gpu/drm/amd/display/dc/calcs/calcs_logger.h<br>
&gt; b/drivers/gpu/drm/amd/display/dc/dml/calcs/calcs_logger.h<br>
&gt; similarity index 100%<br>
&gt; rename from drivers/gpu/drm/amd/display/dc/calcs/calcs_logger.h<br>
&gt; rename to drivers/gpu/drm/amd/display/dc/dml/calcs/calcs_logger.h<br>
&gt; diff --git a/drivers/gpu/drm/amd/display/dc/calcs/custom_float.c<br>
&gt; b/drivers/gpu/drm/amd/display/dc/dml/calcs/custom_float.c<br>
&gt; similarity index 100%<br>
&gt; rename from drivers/gpu/drm/amd/display/dc/calcs/custom_float.c<br>
&gt; rename to drivers/gpu/drm/amd/display/dc/dml/calcs/custom_float.c<br>
&gt; diff --git a/drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c<br>
&gt; b/drivers/gpu/drm/amd/display/dc/dml/calcs/dce_calcs.c<br>
&gt; similarity index 100%<br>
&gt; rename from drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c<br>
&gt; rename to drivers/gpu/drm/amd/display/dc/dml/calcs/dce_calcs.c<br>
&gt; diff --git a/drivers/gpu/drm/amd/display/dc/calcs/dcn_calc_auto.c<br>
&gt; b/drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calc_auto.c<br>
&gt; similarity index 100%<br>
&gt; rename from drivers/gpu/drm/amd/display/dc/calcs/dcn_calc_auto.c<br>
&gt; rename to drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calc_auto.c<br>
&gt; diff --git a/drivers/gpu/drm/amd/display/dc/calcs/dcn_calc_auto.h<br>
&gt; b/drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calc_auto.h<br>
&gt; similarity index 100%<br>
&gt; rename from drivers/gpu/drm/amd/display/dc/calcs/dcn_calc_auto.h<br>
&gt; rename to drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calc_auto.h<br>
&gt; diff --git a/drivers/gpu/drm/amd/display/dc/calcs/dcn_calc_math.c<br>
&gt; b/drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calc_math.c<br>
&gt; similarity index 100%<br>
&gt; rename from drivers/gpu/drm/amd/display/dc/calcs/dcn_calc_math.c<br>
&gt; rename to drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calc_math.c<br>
&gt; diff --git a/drivers/gpu/drm/amd/display/dc/calcs/dcn_calcs.c<br>
&gt; b/drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calcs.c<br>
&gt; similarity index 100%<br>
&gt; rename from drivers/gpu/drm/amd/display/dc/calcs/dcn_calcs.c<br>
&gt; rename to drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calcs.c<br>
<br>
Hi all,<br>
<br>
This isn't a v2, but actually a v1, I apologize for the mistake.<br>
<br>
--<br>
Isabella Basso<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BY5PR12MB42117515E3411EFF7F6602B6FB7E9BY5PR12MB4211namp_--
