Return-Path: <SRS0=x6gI=KI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,PDS_BAD_THREAD_QP_64,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D440C433ED
	for <amd-gfx@archiver.kernel.org>; Thu, 13 May 2021 12:08:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AC18611CC
	for <amd-gfx@archiver.kernel.org>; Thu, 13 May 2021 12:08:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AC18611CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 692056ED02;
	Thu, 13 May 2021 12:08:03 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2050.outbound.protection.outlook.com [40.107.220.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 007176ED02
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 May 2021 12:08:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GDJ+/dN7pFmPWROU+GzOAJlIvINzKXie7YJSLiQhlREt4rkWu9qzM4QYyviiMhQlA4FGIBwpdlpzCj14zjTbAPZ+qCp/4bDj3GmAX6IhPv5mXNU4KPn4uSraxoD18eAdtlKbnZpHmVQJvDuuEyomN/fknJb/LzNP+7LQz7rGUL2jDQBRTTRwXWzN/eHVG6OwTq7V8j340fQz4U+wqDi/QkZhJgZ/7OwMlYXYVQnE2bcj19C+XLhQZoFHDGbR6+jJeddzeTyO07eAnJCtgoxauV0zUvZJ68I6ufAi/qfW7uerYpcCcvb0mSKt4OSXu0cwcTFMpZKQu5blgirMYRtVEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pz/uSBrNpmGyosWo4oOJbp9nkF9iDrBCFSnDNXtEVyE=;
 b=Ylh/2FdDNVhddOEXbElKcijQh+xgkD4PjqYs/KVIe2oh9KetE8FN0mjL1HoXjJX+ZhzxQFKj202DhtWQoTJQePRwAD1rtjY/5H5TmO5Mv7Z0WsXnerhRgd81bSjk9OVfb3T5kD3THECIomDVIKdKEMzdnYyKI+ICOdwtKYv1MSJUv9xjdLbB3DvSypOxFyhF8nDiALNax2QFfBNmzJv9reIHZGu1dIDDjpgmWptQD5J44U/DQddaIPzeC1gV3eactiHInVNIRY76mPWKIdiftx5RhaayN4xO/02KyLBL/4VP8cJ9qRjSjGfgwYL1VGR/WKJqi6NCinyyWpzN74hHXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pz/uSBrNpmGyosWo4oOJbp9nkF9iDrBCFSnDNXtEVyE=;
 b=QgcI7C76i9DjnMCgcflkkbOLrwlcD4FHJsX6t3rVKLB1Az45ZR9abfeL9orCd7uZBRmr8eau6Y4Ib02GwKHmTvhzHXyTrehSF2cl5hn3oBQybWbMZl5YGDMK7LpYAyZmAk80zAKHjmUVrd9ViZBBvx6hB6a/aCPZkgSu2AD1do8=
Received: from CO6PR12MB5473.namprd12.prod.outlook.com (2603:10b6:303:13e::8)
 by CO6PR12MB5476.namprd12.prod.outlook.com (2603:10b6:303:138::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Thu, 13 May
 2021 12:08:00 +0000
Received: from CO6PR12MB5473.namprd12.prod.outlook.com
 ([fe80::6d0f:e659:2a89:c67b]) by CO6PR12MB5473.namprd12.prod.outlook.com
 ([fe80::6d0f:e659:2a89:c67b%6]) with mapi id 15.20.4129.026; Thu, 13 May 2021
 12:08:00 +0000
From: "Wang, Kevin(Yang)" <Kevin1.Wang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 2/3] drm/amd/pm: Fix showing incorrect frequencies on
 aldebaran
Thread-Topic: [PATCH 2/3] drm/amd/pm: Fix showing incorrect frequencies on
 aldebaran
Thread-Index: AQHXR90HFHI2wRchNkOhkbu3B9ikV6rhR/OrgAAFdQCAAANS/Q==
Date: Thu, 13 May 2021 12:08:00 +0000
Message-ID: <CO6PR12MB5473FB7B1B8051E2FF8A9F85A2519@CO6PR12MB5473.namprd12.prod.outlook.com>
References: <cb35e9cc-26cf-c9e7-b747-c24920d788d6@amd.com>
 <CO6PR12MB547345F347D296F9D5715B8FA2519@CO6PR12MB5473.namprd12.prod.outlook.com>,
 <7c9e7ecb-1412-e4f3-9e99-0405327e2713@amd.com>
In-Reply-To: <7c9e7ecb-1412-e4f3-9e99-0405327e2713@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-05-13T12:08:02.991Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [112.65.12.92]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 46767719-0731-4559-c307-08d91607c0de
x-ms-traffictypediagnostic: CO6PR12MB5476:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO6PR12MB54768EFB3132EDE519D264E9A2519@CO6PR12MB5476.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fvEUQMvO/DmjSv+qVSfkRLInoHSipmMn+1TfiLq/b3OQATQdIQjhF5u/54tOdu4GIkfJ5gC7IZ75JliT6OlVDIqWWS4F0XkuzEayv2XJCUU7hPGOuLv/p9JvEz1inicRKevLyQqKotjhlaPXIejzs8f+kvJwN5bu9zy/BVLOqS2M9nec7Nka5B1Cv8jHS/5T63fRKHRO0jplwTUIEIovoPelogxRzSczNHc+pDDcnGhiqAI73GEQxg9HhNT+k1kX28oemsjkjzxxj8wV3jlmbQa8jHoW9InWboHkNy04RxQFrIMjf2pCi2rspRp9y72dzYOUyhp7rjoZ8LI7Rk3Xn3f6OVfRLkEyD8V2Wis02Imj5QtPFAjc5R4Z+D/X7okWBy0P8gBO4pZ8Ufb1h/7kEj5fqayj6ChYDUPtfSNNYB0j7x35XDcLgfoi0FFZWawnPzOzv79bkkB7h2M3Aae5IVR5OmSjz1ln6sC8XoeGAEwL8rXl19kiebiStmapf56gRobO4cos7/EpNxQJCxWPS5ryzeDV/xFGgzaaZa9AttkJ+sSTaMMIc37SxPUrU++cdBQeaY49WwtdL7kdPtDxdgfQq8cLRlEJirTDnDwsHCI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5473.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(396003)(346002)(366004)(39860400002)(136003)(2906002)(26005)(5660300002)(76116006)(33656002)(53546011)(66946007)(91956017)(122000001)(7696005)(186003)(110136005)(8936002)(316002)(52536014)(66446008)(83380400001)(9686003)(71200400001)(478600001)(66476007)(6506007)(8676002)(30864003)(64756008)(38100700002)(4326008)(86362001)(54906003)(55016002)(66556008)(19627405001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?7LQP1JrRWaxFPiyRRD4pEAZInRS9DN45omP/i0ZJWWvoY+h215B8+h3W9R?=
 =?iso-8859-1?Q?pquA40nDLDwjlKruF5w11oU8+nN08Asu0JIkROfGufxaCL/+dKCrk8/rO0?=
 =?iso-8859-1?Q?oJ+J3IKzC+j0Jv8NdS7dHYN6NZif7Qip/jjitzReIRx807Q+VP4EsNSyFW?=
 =?iso-8859-1?Q?9RMU1TQSIL4lWqmG5MeLFOOxTwrRYJTNqOMu3ZgOjKadjZ2mPd/8eUK46A?=
 =?iso-8859-1?Q?Px5IHdW6CtxRNCHrADpvCkyj9iRI323Id+f35Fty5AJ7vM7FQTDAcE94I3?=
 =?iso-8859-1?Q?gKC+421JrqA65/Ko9Ra1GJSfKHWq32eqP2/XFNWdEQUnh2ef7dyHk0u6wt?=
 =?iso-8859-1?Q?WoA1JQY/oyhEEOVyWwaE8SibJvIXPJhpFEZOmIJmeGFPFEpD7htYvSoCaW?=
 =?iso-8859-1?Q?Ds5iwE3HOeRA9mmjdVGgotJZsZ2kamioKwLA1i6jEMRgaJcGifIDy6M0zc?=
 =?iso-8859-1?Q?AEdg8Rq4mMz8PGmo4AA+rv1i70Kf32hYrQ0FEDDaYwiwVMDDLHfb5YPEgy?=
 =?iso-8859-1?Q?Z/zMPSQ2q3nBcBuLiK5b2oQhZf4wE0bWaXcC7O7Tsh/NzLqEZVSObdaaHU?=
 =?iso-8859-1?Q?KoPqRJA7p1x0Ok2fIcsgwh/mW4Ap0cxVLs4GlwSN/jcPBbG7qRlA9aNXg3?=
 =?iso-8859-1?Q?gYlMjB+Tc+leVsZhRZSspshbYjWWiyRwUMUNSTMFyfs1aJQ+7+/WFPhnPQ?=
 =?iso-8859-1?Q?lJziCSGcTb0y1fXyxWMMzUuOidZhImxOAOkP4v+pseZWfkK/rBXQOZ6V5A?=
 =?iso-8859-1?Q?SeM/l8HdmrT54SW65YeGFlzxCy4TP5gr+nDqYKeCSVQEr3+4wi+8Iz+e9G?=
 =?iso-8859-1?Q?rz5ha2q7xhlwOP/v+7p7MOfEK135CIjeILbgrKJGfP+Zb+78MWx3uMNUg6?=
 =?iso-8859-1?Q?PLY/BYiRloGCSDFHO/1dehrOHwLQ4/uAa8JvFbphqpy6CUqlKdt22KRNPw?=
 =?iso-8859-1?Q?mPwmJl16eRAZvPS3O52/u6P+TrodbS3FIy4n4stKzPUVeS7mdvaVujVB98?=
 =?iso-8859-1?Q?aJKjza3ZJZqapTSRCvrgTQlVyGBbLqrOu/pi4Z7EhUPdgXa9cODkuIheXb?=
 =?iso-8859-1?Q?g3bT127i2tR76rCn0muavi3ctjHGLCk/04mYbevB+h2h63Yn8MxVbkplQP?=
 =?iso-8859-1?Q?/NQLNdwRl5UOVD5YpHXubSox+OUrLJI6FAt4AuZzZMy0LQ3hoB4+iPiY+m?=
 =?iso-8859-1?Q?xQ/W7whKxrduGeIhRucMfgszmlPziExZCPka0ynaviFeSMSJJ7xBm4z5mc?=
 =?iso-8859-1?Q?Nzp1XKp7Sdtg7V+uRPRmAkTBjw/n9xGQAOBxK9P51NaSUC11pF9bCNXYOh?=
 =?iso-8859-1?Q?7MsG5UOxnURH89Jej5wKbpb+UzVJ65wx0EQyDfHdB2EV1qc=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46767719-0731-4559-c307-08d91607c0de
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2021 12:08:00.4051 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Eol0PxHFIuDktuAPlM5l+nK6xI9YeD1PXdxFK5yZJi5lCIHq3ToEGeGQoheoK8Ht
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5476
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
Cc: "Feng, Kenneth" <Kenneth.Feng@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Content-Type: multipart/mixed; boundary="===============1115603120=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1115603120==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CO6PR12MB5473FB7B1B8051E2FF8A9F85A2519CO6PR12MB5473namp_"

--_000_CO6PR12MB5473FB7B1B8051E2FF8A9F85A2519CO6PR12MB5473namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]



________________________________
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Thursday, May 13, 2021 7:53 PM
To: Wang, Kevin(Yang) <Kevin1.Wang@amd.com>; amd-gfx@lists.freedesktop.org =
<amd-gfx@lists.freedesktop.org>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Feng, Kenneth <Kenneth.Feng@amd=
.com>
Subject: Re: [PATCH 2/3] drm/amd/pm: Fix showing incorrect frequencies on a=
ldebaran



On 5/13/2021 5:06 PM, Wang, Kevin(Yang) wrote:
> [AMD Official Use Only - Internal Distribution Only]
>
>
>
>
> ------------------------------------------------------------------------
> *From:* Lazar, Lijo <Lijo.Lazar@amd.com>
> *Sent:* Thursday, May 13, 2021 5:47 PM
> *To:* amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
> *Cc:* Zhang, Hawking <Hawking.Zhang@amd.com>; Feng, Kenneth
> <Kenneth.Feng@amd.com>; Wang, Kevin(Yang) <Kevin1.Wang@amd.com>
> *Subject:* [PATCH 2/3] drm/amd/pm: Fix showing incorrect frequencies on
> aldebaran
>
> Use the current and custom pstate frequencies to track the current and
> user-set min/max values in manual and determinism mode. Previously, only
> actual_* value was used to track the currrent and user requested value.
> The value will get reassigned whenever user requests a new value with
> pp_od_clk_voltage node. Hence it will show incorrect values when user
> requests an invalid value or tries a partial request without committing
> the values. Separating out to custom and current variable fixes such
> issues.
>
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
> ---
>    .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    | 65 ++++++++++++-------
>    .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    | 18 ++++-
>    2 files changed, 55 insertions(+), 28 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> index 5d04a1dfdfd8..d27ed2954705 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> @@ -78,8 +78,6 @@
>
>    #define smnPCIE_ESM_CTRL                      0x111003D0
>
> -#define CLOCK_VALID (1 << 31)
> -
>    static const struct cmn2asic_msg_mapping
> aldebaran_message_map[SMU_MSG_MAX_COUNT] =3D {
>           MSG_MAP(TestMessage,
> PPSMC_MSG_TestMessage,                      0),
>           MSG_MAP(GetSmuVersion,
> PPSMC_MSG_GetSmuVersion,                    1),
> @@ -455,12 +453,18 @@ static int aldebaran_populate_umd_state_clk(struct
> smu_context *smu)
>
>           pstate_table->gfxclk_pstate.min =3D gfx_table->min;
>           pstate_table->gfxclk_pstate.peak =3D gfx_table->max;
> +       pstate_table->gfxclk_pstate.curr.min =3D gfx_table->min;
> +       pstate_table->gfxclk_pstate.curr.max =3D gfx_table->max;
>
>           pstate_table->uclk_pstate.min =3D mem_table->min;
>           pstate_table->uclk_pstate.peak =3D mem_table->max;
> +       pstate_table->uclk_pstate.curr.min =3D mem_table->min;
> +       pstate_table->uclk_pstate.curr.max =3D mem_table->max;
>
>           pstate_table->socclk_pstate.min =3D soc_table->min;
>           pstate_table->socclk_pstate.peak =3D soc_table->max;
> +       pstate_table->socclk_pstate.curr.min =3D soc_table->min;
> +       pstate_table->socclk_pstate.curr.max =3D soc_table->max;
>
>           if (gfx_table->count > ALDEBARAN_UMD_PSTATE_GFXCLK_LEVEL &&
>               mem_table->count > ALDEBARAN_UMD_PSTATE_MCLK_LEVEL &&
> @@ -669,6 +673,7 @@ static int aldebaran_print_clk_levels(struct
> smu_context *smu,
>    {
>           int i, now, size =3D 0;
>           int ret =3D 0;
> +       struct smu_umd_pstate_table *pstate_table =3D &smu->pstate_table;
>           struct pp_clock_levels_with_latency clocks;
>           struct smu_13_0_dpm_table *single_dpm_table;
>           struct smu_dpm_context *smu_dpm =3D &smu->smu_dpm;
> @@ -703,12 +708,8 @@ static int aldebaran_print_clk_levels(struct
> smu_context *smu,
>
>                   display_levels =3D clocks.num_levels;
>
> -               min_clk =3D smu->gfx_actual_hard_min_freq & CLOCK_VALID ?
> -                                 smu->gfx_actual_hard_min_freq &
> ~CLOCK_VALID :
> -                                 single_dpm_table->dpm_levels[0].value;
> -               max_clk =3D smu->gfx_actual_soft_max_freq & CLOCK_VALID ?
> -                                 smu->gfx_actual_soft_max_freq &
> ~CLOCK_VALID :
> -                                 single_dpm_table->dpm_levels[1].value;
> +               min_clk =3D pstate_table->gfxclk_pstate.curr.min;
> +               max_clk =3D pstate_table->gfxclk_pstate.curr.max;
>
>                   freq_values[0] =3D min_clk;
>                   freq_values[1] =3D max_clk;
> @@ -1134,9 +1135,6 @@ static int aldebaran_set_performance_level(struct
> smu_context *smu,
>                           && (level !=3D
> AMD_DPM_FORCED_LEVEL_PERF_DETERMINISM))
>                   smu_cmn_send_smc_msg(smu, SMU_MSG_DisableDeterminism,
> NULL);
>
> -       /* Reset user min/max gfx clock */
> -       smu->gfx_actual_hard_min_freq =3D 0;
> -       smu->gfx_actual_soft_max_freq =3D 0;
>
>           switch (level) {
>
> @@ -1163,6 +1161,7 @@ static int
> aldebaran_set_soft_freq_limited_range(struct smu_context *smu,
>    {
>           struct smu_dpm_context *smu_dpm =3D &(smu->smu_dpm);
>           struct smu_13_0_dpm_context *dpm_context =3D smu_dpm->dpm_conte=
xt;
> +       struct smu_umd_pstate_table *pstate_table =3D &smu->pstate_table;
>           struct amdgpu_device *adev =3D smu->adev;
>           uint32_t min_clk;
>           uint32_t max_clk;
> @@ -1176,14 +1175,20 @@ static int
> aldebaran_set_soft_freq_limited_range(struct smu_context *smu,
>                   return -EINVAL;
>
>           if (smu_dpm->dpm_level =3D=3D AMD_DPM_FORCED_LEVEL_MANUAL) {
> -               min_clk =3D max(min, dpm_context->dpm_tables.gfx_table.mi=
n);
> -               max_clk =3D min(max, dpm_context->dpm_tables.gfx_table.ma=
x);
> -               ret =3D smu_v13_0_set_soft_freq_limited_range(smu, SMU_GF=
XCLK,
> -                                                           min_clk,
> max_clk);
> +               if (min >=3D max) {
> +                       dev_err(smu->adev->dev,
> +                               "Minimum GFX clk should be less than the
> maximum allowed clock\n");
> +                       return -EINVAL;
> +               }
>
> [kevin]:
> why can these value not be equal in manual mode?

We are intentionally avoiding user expectation to run at fixed clocks.
The message is to make it clear that it is not a reasonable expectation
on aldebaran.

Thanks,
Lijo

[kevin]:
In fact, the SMU firmware allows driver to set the same clock,
in other asic, we have the same code logic.

Regards,
Kevin
> +               if ((min =3D=3D pstate_table->gfxclk_pstate.curr.min) &&
> +                   (max =3D=3D pstate_table->gfxclk_pstate.curr.max))
> +                       return 0;
> +               ret =3D smu_v13_0_set_soft_freq_limited_range(smu, SMU_GF=
XCLK,
> +                                                           min, max);
>                   if (!ret) {
> -                       smu->gfx_actual_hard_min_freq =3D min_clk |
> CLOCK_VALID;
> -                       smu->gfx_actual_soft_max_freq =3D max_clk |
> CLOCK_VALID;
> +                       pstate_table->gfxclk_pstate.curr.min =3D min;
> +                       pstate_table->gfxclk_pstate.curr.max =3D max;
>                   }
>                   return ret;
>           }
> @@ -1209,10 +1214,8 @@ static int
> aldebaran_set_soft_freq_limited_range(struct smu_context *smu,
>                                   dev_err(adev->dev,
>                                                   "Failed to enable
> determinism at GFX clock %d MHz\n", max);
>                           } else {
> -                               smu->gfx_actual_hard_min_freq =3D
> -                                       min_clk | CLOCK_VALID;
> -                               smu->gfx_actual_soft_max_freq =3D
> -                                       max | CLOCK_VALID;
> +                               pstate_table->gfxclk_pstate.curr.min =3D
> min_clk;
> +                               pstate_table->gfxclk_pstate.curr.max =3D =
max;
>                           }
>                   }
>           }
> @@ -1225,6 +1228,7 @@ static int aldebaran_usr_edit_dpm_table(struct
> smu_context *smu, enum PP_OD_DPM_
>    {
>           struct smu_dpm_context *smu_dpm =3D &(smu->smu_dpm);
>           struct smu_13_0_dpm_context *dpm_context =3D smu_dpm->dpm_conte=
xt;
> +       struct smu_umd_pstate_table *pstate_table =3D &smu->pstate_table;
>           uint32_t min_clk;
>           uint32_t max_clk;
>           int ret =3D 0;
> @@ -1245,16 +1249,20 @@ static int aldebaran_usr_edit_dpm_table(struct
> smu_context *smu, enum PP_OD_DPM_
>                           if (input[1] <
> dpm_context->dpm_tables.gfx_table.min) {
>                                   dev_warn(smu->adev->dev, "Minimum GFX
> clk (%ld) MHz specified is
> less than the minimum allowed (%d) MHz\n",
>                                           input[1],
> dpm_context->dpm_tables.gfx_table.min);
> +                               pstate_table->gfxclk_pstate.custom.min =
=3D
> +
> pstate_table->gfxclk_pstate.curr.min;
>                                   return -EINVAL;
>                           }
> -                       smu->gfx_actual_hard_min_freq =3D input[1];
> +                       pstate_table->gfxclk_pstate.custom.min =3D input[=
1];
>                   } else if (input[0] =3D=3D 1) {
>                           if (input[1] >
> dpm_context->dpm_tables.gfx_table.max) {
>                                   dev_warn(smu->adev->dev, "Maximum GFX
> clk (%ld) MHz specified is
> greater than the maximum allowed (%d) MHz\n",
>                                           input[1],
> dpm_context->dpm_tables.gfx_table.max);
> +                               pstate_table->gfxclk_pstate.custom.max =
=3D
> +
> pstate_table->gfxclk_pstate.curr.max;
>                                   return -EINVAL;
>                           }
> -                       smu->gfx_actual_soft_max_freq =3D input[1];
> +                       pstate_table->gfxclk_pstate.custom.max =3D input[=
1];
>                   } else {
>                           return -EINVAL;
>                   }
> @@ -1276,8 +1284,15 @@ static int aldebaran_usr_edit_dpm_table(struct
> smu_context *smu, enum PP_OD_DPM_
>                           dev_err(smu->adev->dev, "Input parameter
> number not correct\n");
>                           return -EINVAL;
>                   } else {
> -                       min_clk =3D smu->gfx_actual_hard_min_freq;
> -                       max_clk =3D smu->gfx_actual_soft_max_freq;
> +                       if (!pstate_table->gfxclk_pstate.custom.min)
> +                               pstate_table->gfxclk_pstate.custom.min =
=3D
> +
> pstate_table->gfxclk_pstate.curr.min;
> +                       if (!pstate_table->gfxclk_pstate.custom.max)
> +                               pstate_table->gfxclk_pstate.custom.max =
=3D
> +
> pstate_table->gfxclk_pstate.curr.max;
> +                       min_clk =3D pstate_table->gfxclk_pstate.custom.mi=
n;
> +                       max_clk =3D pstate_table->gfxclk_pstate.custom.ma=
x;
> +
>                           return
> aldebaran_set_soft_freq_limited_range(smu, SMU_GFXCLK,
> min_clk, max_clk);
>                   }
>                   break;
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> index 0864083e7435..755bddaf6c4b 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> @@ -1624,8 +1624,12 @@ int smu_v13_0_set_performance_level(struct
> smu_context *smu,
>                                                               SMU_GFXCLK,
>                                                               sclk_min,
>                                                               sclk_max);
> -               if (ret)
> +               if (ret) {
>                           return ret;
> +               } else {
> +                       pstate_table->gfxclk_pstate.curr.min =3D sclk_min=
;
> +                       pstate_table->gfxclk_pstate.curr.max =3D sclk_max=
;
> +               }
>           }
>
>           if (mclk_min && mclk_max) {
> @@ -1633,8 +1637,12 @@ int smu_v13_0_set_performance_level(struct
> smu_context *smu,
>                                                               SMU_MCLK,
>                                                               mclk_min,
>                                                               mclk_max);
> -               if (ret)
> +               if (ret) {
>                           return ret;
> +               } else {
> +                       pstate_table->uclk_pstate.curr.min =3D mclk_min;
> +                       pstate_table->uclk_pstate.curr.max =3D mclk_max;
> +               }
>           }
>
>           if (socclk_min && socclk_max) {
> @@ -1642,8 +1650,12 @@ int smu_v13_0_set_performance_level(struct
> smu_context *smu,
>                                                               SMU_SOCCLK,
>                                                               socclk_min,
>                                                               socclk_max)=
;
> -               if (ret)
> +               if (ret) {
>                           return ret;
> +               } else {
> +                       pstate_table->socclk_pstate.curr.min =3D socclk_m=
in;
> +                       pstate_table->socclk_pstate.curr.max =3D socclk_m=
ax;
> +               }
>           }
>
>           return ret;
> --
> 2.17.1
>


--_000_CO6PR12MB5473FB7B1B8051E2FF8A9F85A2519CO6PR12MB5473namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
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
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"appendonsend"></div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Lazar, Lijo &lt;Lijo.=
Lazar@amd.com&gt;<br>
<b>Sent:</b> Thursday, May 13, 2021 7:53 PM<br>
<b>To:</b> Wang, Kevin(Yang) &lt;Kevin1.Wang@amd.com&gt;; amd-gfx@lists.fre=
edesktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; Feng, Kenneth &lt;=
Kenneth.Feng@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH 2/3] drm/amd/pm: Fix showing incorrect frequenci=
es on aldebaran</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText"><br>
<br>
On 5/13/2021 5:06 PM, Wang, Kevin(Yang) wrote:<br>
&gt; [AMD Official Use Only - Internal Distribution Only]<br>
&gt; <br>
&gt; <br>
&gt; <br>
&gt; <br>
&gt; ----------------------------------------------------------------------=
--<br>
&gt; *From:* Lazar, Lijo &lt;Lijo.Lazar@amd.com&gt;<br>
&gt; *Sent:* Thursday, May 13, 2021 5:47 PM<br>
&gt; *To:* amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
&gt; *Cc:* Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; Feng, Kenneth <br>
&gt; &lt;Kenneth.Feng@amd.com&gt;; Wang, Kevin(Yang) &lt;Kevin1.Wang@amd.co=
m&gt;<br>
&gt; *Subject:* [PATCH 2/3] drm/amd/pm: Fix showing incorrect frequencies o=
n <br>
&gt; aldebaran<br>
&gt; <br>
&gt; Use the current and custom pstate frequencies to track the current and=
<br>
&gt; user-set min/max values in manual and determinism mode. Previously, on=
ly<br>
&gt; actual_* value was used to track the currrent and user requested value=
.<br>
&gt; The value will get reassigned whenever user requests a new value with<=
br>
&gt; pp_od_clk_voltage node. Hence it will show incorrect values when user<=
br>
&gt; requests an invalid value or tries a partial request without committin=
g<br>
&gt; the values. Separating out to custom and current variable fixes such<b=
r>
&gt; issues.<br>
&gt; <br>
&gt; Signed-off-by: Lijo Lazar &lt;lijo.lazar@amd.com&gt;<br>
&gt; ---<br>
&gt;&nbsp; &nbsp; .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c&nbsp;&nbsp;&nb=
sp; | 65 ++++++++++++-------<br>
&gt;&nbsp; &nbsp; .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c&nbsp;&nbsp;&nb=
sp; | 18 ++++-<br>
&gt;&nbsp; &nbsp; 2 files changed, 55 insertions(+), 28 deletions(-)<br>
&gt; <br>
&gt; diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c<br>
&gt; b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c<br>
&gt; index 5d04a1dfdfd8..d27ed2954705 100644<br>
&gt; --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c<br>
&gt; +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c<br>
&gt; @@ -78,8 +78,6 @@<br>
&gt; <br>
&gt;&nbsp; &nbsp; #define smnPCIE_ESM_CTRL&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; 0x111003D0<br>
&gt; <br>
&gt; -#define CLOCK_VALID (1 &lt;&lt; 31)<br>
&gt; -<br>
&gt;&nbsp; &nbsp; static const struct cmn2asic_msg_mapping<br>
&gt; aldebaran_message_map[SMU_MSG_MAX_COUNT] =3D {<br>
&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(TestMes=
sage,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
<br>
&gt; PPSMC_MSG_TestMessage,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; 0),<br>
&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(GetSmuV=
ersion,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>
&gt; PPSMC_MSG_GetSmuVersion,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1),<br=
>
&gt; @@ -455,12 +453,18 @@ static int aldebaran_populate_umd_state_clk(stru=
ct<br>
&gt; smu_context *smu)<br>
&gt; <br>
&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pstate_table-&g=
t;gfxclk_pstate.min =3D gfx_table-&gt;min;<br>
&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pstate_table-&g=
t;gfxclk_pstate.peak =3D gfx_table-&gt;max;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pstate_table-&gt;gfxclk_pstate.c=
urr.min =3D gfx_table-&gt;min;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pstate_table-&gt;gfxclk_pstate.c=
urr.max =3D gfx_table-&gt;max;<br>
&gt; <br>
&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pstate_table-&g=
t;uclk_pstate.min =3D mem_table-&gt;min;<br>
&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pstate_table-&g=
t;uclk_pstate.peak =3D mem_table-&gt;max;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pstate_table-&gt;uclk_pstate.cur=
r.min =3D mem_table-&gt;min;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pstate_table-&gt;uclk_pstate.cur=
r.max =3D mem_table-&gt;max;<br>
&gt; <br>
&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pstate_table-&g=
t;socclk_pstate.min =3D soc_table-&gt;min;<br>
&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pstate_table-&g=
t;socclk_pstate.peak =3D soc_table-&gt;max;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pstate_table-&gt;socclk_pstate.c=
urr.min =3D soc_table-&gt;min;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pstate_table-&gt;socclk_pstate.c=
urr.max =3D soc_table-&gt;max;<br>
&gt; <br>
&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (gfx_table-&=
gt;count &gt; ALDEBARAN_UMD_PSTATE_GFXCLK_LEVEL &amp;&amp;<br>
&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; mem_table-&gt;count &gt; ALDEBARAN_UMD_PSTATE_MCLK_LEVEL &amp;&amp=
;<br>
&gt; @@ -669,6 +673,7 @@ static int aldebaran_print_clk_levels(struct<br>
&gt; smu_context *smu,<br>
&gt;&nbsp; &nbsp; {<br>
&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i, now, siz=
e =3D 0;<br>
&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<=
br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_umd_pstate_table *pst=
ate_table =3D &amp;smu-&gt;pstate_table;<br>
&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pp_clock=
_levels_with_latency clocks;<br>
&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_13_0=
_dpm_table *single_dpm_table;<br>
&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_dpm_=
context *smu_dpm =3D &amp;smu-&gt;smu_dpm;<br>
&gt; @@ -703,12 +708,8 @@ static int aldebaran_print_clk_levels(struct<br>
&gt; smu_context *smu,<br>
&gt; <br>
&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; display_levels =3D clocks.num_levels;<br>
&gt; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; min_clk =3D smu-&gt;gfx_actual_hard_min_freq &amp; CLOCK_VA=
LID ?<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;gfx_actual_hard_mi=
n_freq &amp; <br>
&gt; ~CLOCK_VALID :<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; single_dpm_table-&gt;dpm_l=
evels[0].value;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; max_clk =3D smu-&gt;gfx_actual_soft_max_freq &amp; CLOCK_VA=
LID ?<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;gfx_actual_soft_ma=
x_freq &amp; <br>
&gt; ~CLOCK_VALID :<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; single_dpm_table-&gt;dpm_l=
evels[1].value;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; min_clk =3D pstate_table-&gt;gfxclk_pstate.curr.min;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; max_clk =3D pstate_table-&gt;gfxclk_pstate.curr.max;<br>
&gt; <br>
&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; freq_values[0] =3D min_clk;<br>
&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; freq_values[1] =3D max_clk;<br>
&gt; @@ -1134,9 +1135,6 @@ static int aldebaran_set_performance_level(struc=
t<br>
&gt; smu_context *smu,<br>
&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; &amp;&amp; (level !=3D <br>
&gt; AMD_DPM_FORCED_LEVEL_PERF_DETERMINISM))<br>
&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_cmn_send_smc_msg(smu, SMU_MSG_DisableD=
eterminism, <br>
&gt; NULL);<br>
&gt; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Reset user min/max gfx clock =
*/<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;gfx_actual_hard_min_freq=
 =3D 0;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;gfx_actual_soft_max_freq=
 =3D 0;<br>
&gt; <br>
&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (level) =
{<br>
&gt; <br>
&gt; @@ -1163,6 +1161,7 @@ static int<br>
&gt; aldebaran_set_soft_freq_limited_range(struct smu_context *smu,<br>
&gt;&nbsp; &nbsp; {<br>
&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_dpm_=
context *smu_dpm =3D &amp;(smu-&gt;smu_dpm);<br>
&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_13_0=
_dpm_context *dpm_context =3D smu_dpm-&gt;dpm_context;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_umd_pstate_table *pst=
ate_table =3D &amp;smu-&gt;pstate_table;<br>
&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_d=
evice *adev =3D smu-&gt;adev;<br>
&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t min_cl=
k;<br>
&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t max_cl=
k;<br>
&gt; @@ -1176,14 +1175,20 @@ static int<br>
&gt; aldebaran_set_soft_freq_limited_range(struct smu_context *smu,<br>
&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt; <br>
&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (smu_dpm-&gt=
;dpm_level =3D=3D AMD_DPM_FORCED_LEVEL_MANUAL) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; min_clk =3D max(min, dpm_context-&gt;dpm_tables.gfx_table.m=
in);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; max_clk =3D min(max, dpm_context-&gt;dpm_tables.gfx_table.m=
ax);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; ret =3D smu_v13_0_set_soft_freq_limited_range(smu, SMU_GFXC=
LK,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; min_clk, <br>
&gt; max_clk);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (min &gt;=3D max) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(smu=
-&gt;adev-&gt;dev,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;Minimum GFX clk should be less t=
han the <br>
&gt; maximum allowed clock\n&quot;);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EIN=
VAL;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; }<br>
&gt; <br>
&gt; [kevin]:<br>
&gt; why can these value not be equal in manual mode?<br>
<br>
We are intentionally avoiding user expectation to run at fixed clocks. <br>
The message is to make it clear that it is not a reasonable expectation <br=
>
on aldebaran.<br>
<br>
Thanks,<br>
Lijo</div>
<div class=3D"PlainText"><br>
</div>
<div class=3D"PlainText">[kevin]:</div>
<div class=3D"PlainText">In fact, the SMU firmware allows driver to set the=
 same clock,</div>
<div class=3D"PlainText">in other asic, we have the same code logic.</div>
<div class=3D"PlainText"><br>
</div>
<div class=3D"PlainText">Regards,</div>
<div class=3D"PlainText">Kevin<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if ((min =3D=3D pstate_table-&gt;gfxclk_pstate.curr.min) &a=
mp;&amp;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (max =3D=3D pstate_table-&gt;gfxclk=
_pstate.curr.max))<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<b=
r>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; ret =3D smu_v13_0_set_soft_freq_limited_range(smu, SMU_GFXC=
LK,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; min, max);<br>
&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!ret) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;gfx=
_actual_hard_min_freq =3D min_clk | <br>
&gt; CLOCK_VALID;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;gfx=
_actual_soft_max_freq =3D max_clk | <br>
&gt; CLOCK_VALID;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pstate_tabl=
e-&gt;gfxclk_pstate.curr.min =3D min;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pstate_tabl=
e-&gt;gfxclk_pstate.curr.max =3D max;<br>
&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; @@ -1209,10 +1214,8 @@ static int<br>
&gt; aldebaran_set_soft_freq_limited_range(struct smu_context *smu,<br>
&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(adev-&gt;dev,=
<br>
&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&quot;Failed to enable <br>
&gt; determinism at GFX clock %d MHz\n&quot;, max);<br>
&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; } else {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;gfx_actual_hard_min_freq =3D<b=
r>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; min_clk | CLOCK_VALID;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;gfx_actual_soft_max_freq =3D<b=
r>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; max | CLOCK_VALID;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pstate_table-&gt;gfxclk_pstate.curr.mi=
n =3D <br>
&gt; min_clk;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pstate_table-&gt;gfxclk_pstate.curr.ma=
x =3D max;<br>
&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; }<br>
&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; @@ -1225,6 +1228,7 @@ static int aldebaran_usr_edit_dpm_table(struct<b=
r>
&gt; smu_context *smu, enum PP_OD_DPM_<br>
&gt;&nbsp; &nbsp; {<br>
&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_dpm_=
context *smu_dpm =3D &amp;(smu-&gt;smu_dpm);<br>
&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_13_0=
_dpm_context *dpm_context =3D smu_dpm-&gt;dpm_context;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_umd_pstate_table *pst=
ate_table =3D &amp;smu-&gt;pstate_table;<br>
&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t min_cl=
k;<br>
&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t max_cl=
k;<br>
&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<=
br>
&gt; @@ -1245,16 +1249,20 @@ static int aldebaran_usr_edit_dpm_table(struct=
<br>
&gt; smu_context *smu, enum PP_OD_DPM_<br>
&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; if (input[1] &lt; <br>
&gt; dpm_context-&gt;dpm_tables.gfx_table.min) {<br>
&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_warn(smu-&gt;adev=
-&gt;dev, &quot;Minimum GFX <br>
&gt; clk (%ld) MHz specified is<br>
&gt; less than the minimum allowed (%d) MHz\n&quot;,<br>
&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; input[1], <br>
&gt; dpm_context-&gt;dpm_tables.gfx_table.min);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pstate_table-&gt;gfxclk_pstate.custom.=
min =3D<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; <br>
&gt; pstate_table-&gt;gfxclk_pstate.curr.min;<br>
&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; }<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;gfx=
_actual_hard_min_freq =3D input[1];<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pstate_tabl=
e-&gt;gfxclk_pstate.custom.min =3D input[1];<br>
&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (input[0] =3D=3D 1) {<br>
&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; if (input[1] &gt; <br>
&gt; dpm_context-&gt;dpm_tables.gfx_table.max) {<br>
&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_warn(smu-&gt;adev=
-&gt;dev, &quot;Maximum GFX <br>
&gt; clk (%ld) MHz specified is<br>
&gt; greater than the maximum allowed (%d) MHz\n&quot;,<br>
&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; input[1], <br>
&gt; dpm_context-&gt;dpm_tables.gfx_table.max);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pstate_table-&gt;gfxclk_pstate.custom.=
max =3D<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; <br>
&gt; pstate_table-&gt;gfxclk_pstate.curr.max;<br>
&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; }<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;gfx=
_actual_soft_max_freq =3D input[1];<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pstate_tabl=
e-&gt;gfxclk_pstate.custom.max =3D input[1];<br>
&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; return -EINVAL;<br>
&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; @@ -1276,8 +1284,15 @@ static int aldebaran_usr_edit_dpm_table(struct<=
br>
&gt; smu_context *smu, enum PP_OD_DPM_<br>
&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; dev_err(smu-&gt;adev-&gt;dev, &quot;Input parameter <br>
&gt; number not correct\n&quot;);<br>
&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; return -EINVAL;<br>
&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; min_clk =3D=
 smu-&gt;gfx_actual_hard_min_freq;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; max_clk =3D=
 smu-&gt;gfx_actual_soft_max_freq;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!pstate=
_table-&gt;gfxclk_pstate.custom.min)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pstate_table-&gt;gfxclk_pstate.custom.=
min =3D<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; <br>
&gt; pstate_table-&gt;gfxclk_pstate.curr.min;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!pstate=
_table-&gt;gfxclk_pstate.custom.max)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pstate_table-&gt;gfxclk_pstate.custom.=
max =3D<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; <br>
&gt; pstate_table-&gt;gfxclk_pstate.curr.max;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; min_clk =3D=
 pstate_table-&gt;gfxclk_pstate.custom.min;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; max_clk =3D=
 pstate_table-&gt;gfxclk_pstate.custom.max;<br>
&gt; +<br>
&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; return <br>
&gt; aldebaran_set_soft_freq_limited_range(smu, SMU_GFXCLK,<br>
&gt; min_clk, max_clk);<br>
&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt; diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c<br>
&gt; b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c<br>
&gt; index 0864083e7435..755bddaf6c4b 100644<br>
&gt; --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c<br>
&gt; +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c<br>
&gt; @@ -1624,8 +1624,12 @@ int smu_v13_0_set_performance_level(struct<br>
&gt; smu_context *smu,<br>
&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SMU=
_GFXCLK,<br>
&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; scl=
k_min,<br>
&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; scl=
k_max);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (ret)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (ret) {<br>
&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; return ret;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; } else {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pstate_tabl=
e-&gt;gfxclk_pstate.curr.min =3D sclk_min;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pstate_tabl=
e-&gt;gfxclk_pstate.curr.max =3D sclk_max;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; }<br>
&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; <br>
&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (mclk_min &a=
mp;&amp; mclk_max) {<br>
&gt; @@ -1633,8 +1637,12 @@ int smu_v13_0_set_performance_level(struct<br>
&gt; smu_context *smu,<br>
&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SMU=
_MCLK,<br>
&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mcl=
k_min,<br>
&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mcl=
k_max);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (ret)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (ret) {<br>
&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; return ret;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; } else {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pstate_tabl=
e-&gt;uclk_pstate.curr.min =3D mclk_min;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pstate_tabl=
e-&gt;uclk_pstate.curr.max =3D mclk_max;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; }<br>
&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; <br>
&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (socclk_min =
&amp;&amp; socclk_max) {<br>
&gt; @@ -1642,8 +1650,12 @@ int smu_v13_0_set_performance_level(struct<br>
&gt; smu_context *smu,<br>
&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SMU=
_SOCCLK,<br>
&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; soc=
clk_min,<br>
&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; soc=
clk_max);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (ret)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (ret) {<br>
&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; return ret;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; } else {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pstate_tabl=
e-&gt;socclk_pstate.curr.min =3D socclk_min;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pstate_tabl=
e-&gt;socclk_pstate.curr.max =3D socclk_max;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; }<br>
&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; <br>
&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt; -- <br>
&gt; 2.17.1<br>
&gt; <br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_CO6PR12MB5473FB7B1B8051E2FF8A9F85A2519CO6PR12MB5473namp_--

--===============1115603120==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1115603120==--
