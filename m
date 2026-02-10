Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C26C3EB2700
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Feb 2026 21:25:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6637410E5F6;
	Tue, 10 Feb 2026 21:25:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nqEbKccd";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011063.outbound.protection.outlook.com [52.101.62.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 93AFA10E5F6
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Feb 2026 21:24:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EyOv6YFeER6vuKo2ZkDZ/0p65vN4YACs+opsuKUA223pyO463XLXGjcLtEhQBgqpcKPE3gBLXL8znZgbYRh1QjtFUpPQqoO2CS9/rnH5cJEpUiVVUErvJbKUiagUQ/ESuEn8KQlPcFAreMetmEwsU4Q6NQKdU2St04dAy1ijxrfxRZ5GkFE/xywIvj9f9KqCqXHfzF21moV+Cx9bja0Nw1cjoA2J7RiuUaV04TQiB+nfa1VWnIHUpwWhGPOwAvIlFMYxS8RUIR+1CXq0UEzXitB97BhdnK7BAr7LwLAisX8fBl0CQKXotshrj8ztBqkcF8tfLxgwT63wCRWGfRUixQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QqynrDt5mBNEYfspPjwktza3QtFnHAmqPuk0GTFmNic=;
 b=cm9WUTWXImm63MM5W5hz74Vc+dNvIwYjw27UHiA7zuRq2rm7AJpSIVsvhdhAyF8+UEzUGPX9fO0Gjcdnnt0PFnO8jX7lHiZaIJEK29A34e1t3S00c5rAF4Bo1x00Bm8xqBIUuuaGC6xzhokrJSkkFXt2XFyElSomxKsR1IxQho/9CzU3qkKx8lLMeFiU8HBSjqnhGSwPPF3S5X7vP+jnfTkzEZyR3aTtDMMWbALomQYJUmfEqgNOqPZ0i6ZBKP/7L5k4wpx+/xVd7E29xAQqNJwdrgyrgHN/v4wXy7jiUlLvbFYn+KWVv3g123xC2zInXwtM9tePkE6R0TWrNUYJTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QqynrDt5mBNEYfspPjwktza3QtFnHAmqPuk0GTFmNic=;
 b=nqEbKccd3u47LwsJWS97XJ105ATB7pdr9eBHgUL1KlDk/4jG2DUXH+mZjLwaOEPa3DCOyV7HT+tSdZstF8hkKGiQx2WTevO4aZrXJE7taVVePtJeFSgwKaiOsOk2MFD45O/F3t5BzDvX3TDywwtYXeJrP4CYsMyos/YZJUkf1BI=
Received: from CY8PR12MB8193.namprd12.prod.outlook.com (2603:10b6:930:71::22)
 by SJ1PR12MB6099.namprd12.prod.outlook.com (2603:10b6:a03:45e::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Tue, 10 Feb
 2026 21:24:54 +0000
Received: from CY8PR12MB8193.namprd12.prod.outlook.com
 ([fe80::43e3:7eec:f4e2:b0e7]) by CY8PR12MB8193.namprd12.prod.outlook.com
 ([fe80::43e3:7eec:f4e2:b0e7%6]) with mapi id 15.20.9587.017; Tue, 10 Feb 2026
 21:24:54 +0000
From: "Li, Roman" <Roman.Li@amd.com>
To: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>, "Hung, Alex"
 <Alex.Hung@amd.com>, "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>, Dan Carpenter
 <dan.carpenter@linaro.org>, "Wentland, Harry" <Harry.Wentland@amd.com>, Mario
 Limonciello <superm1@kernel.org>, "Chung, ChiaHsuan (Tom)"
 <ChiaHsuan.Chung@amd.com>
Subject: RE: [PATCH v2] drm/amd/display: Fix out-of-bounds stream encoder
 index v2
Thread-Topic: [PATCH v2] drm/amd/display: Fix out-of-bounds stream encoder
 index v2
Thread-Index: AQHcmqDOy3rkfeZxsEyoIlMPuuTD8bV8btAQ
Date: Tue, 10 Feb 2026 21:24:54 +0000
Message-ID: <CY8PR12MB81936BB2F89B3893E9BFA2898962A@CY8PR12MB8193.namprd12.prod.outlook.com>
References: <20260210151947.1541045-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20260210151947.1541045-1-srinivasan.shanmugam@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2026-02-10T21:22:57.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB8193:EE_|SJ1PR12MB6099:EE_
x-ms-office365-filtering-correlation-id: 88eff2d4-c42f-4d19-e6c7-08de68ead55a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?gDnhYUbppp701wY4DXVCDHKIA3V0/tvAH/Ud0pZV1vT9mutNnMhl1LPuriCm?=
 =?us-ascii?Q?+iPU3Yj54rLiZJWdDVsH33gGCVb+y+C+IgonLdy7gNLFSgaqgBWKI6yc1YbV?=
 =?us-ascii?Q?M/RoQ7n5vWKYyfB4/9jPLAQPFjZCxOOGjGeDz3luN0TmI7h3fkAQAZWbHpZA?=
 =?us-ascii?Q?sRre4w6xGSDG1Bh9QJyEf+7y2byRMxvzUQ5b0UfRTHEIwsp4Vl2Cg607suVV?=
 =?us-ascii?Q?YTQRsrsfKl4Pcm8PXnU18hoayHavD5cAPw98iOoKdqLjohhUyw9pEmOT3dAy?=
 =?us-ascii?Q?Cy3BoQuu6rhWMAmNzOb9DPhqfAC0Ob6SMPqXs5UH8K7AVwXPKXHPUC4PMIYw?=
 =?us-ascii?Q?Qtjpry7Ukbt7V2I3qa8s2mcJyK+hba9QYgxhHk0NexLKLX3B4vKF8SHtFlQ4?=
 =?us-ascii?Q?AyKhyR1/ItZPY66kg73zoDD4Cs8mDPrjzkeTBGWedn3khzp+JTGiLfI2dAho?=
 =?us-ascii?Q?2TbMr/Or7ed47J+ksVPtwIUlxDJAftc2Ft3E2X9SLijHtW8hS4hNk3vrxGke?=
 =?us-ascii?Q?XrWtTbgTSqgu2AsZBZNShrOKUxY+D/x5xqD3OrMnoEHTbiz73oVa+SPvDYZy?=
 =?us-ascii?Q?yyb10dccyzEc4wRgyf0qg3wCxCDPY6bialG5G/Cj3N3dobQceExGzK+2ll7x?=
 =?us-ascii?Q?OxiXk2D32+PIS6GyqX9l3W2d0MTcCV6J7qONBNiSf4ONAeirrHBsUfJdXSjn?=
 =?us-ascii?Q?4SKDAPCndbbSm2WcDe1FCFTGU6Gh94gYwj9+2fCXChncHBCPP3/e07sXRzcU?=
 =?us-ascii?Q?KK03WNdxcjJOwer4RX0XqyGknlVbJNKN8JHJjQ5Wq3LGNy49IZBW93w0nglS?=
 =?us-ascii?Q?Q6m5zAulcm20cvRWKQRJmmRsHiwDp6RGgYzpYhT2i3JDYSQOBeRbyiT+/3Xc?=
 =?us-ascii?Q?T2mDm0IH5cojvPSWs4Lnkq578ooS5TimKuSNIr/GetoJT2HUnep39pQIis3h?=
 =?us-ascii?Q?1oSrGGeJp1yVI1uZKW9ILPci5hvjfn3KTd387GHeI0AyVlzOQqDP1DOSIiZX?=
 =?us-ascii?Q?WF91XUhrhJoiCyJ3ExpUeIhaKdsOn56MdhUVlXeFsdKmso7c4fJerAWcScm3?=
 =?us-ascii?Q?ZMVLUx708uMYEjAbUVHH/ZM8VUoHAs1SxDiIo5yqQ/uW8/bxuOb7u8WR2vpD?=
 =?us-ascii?Q?LEe2+fQzRyHjKw33EUcMuET3Bv1HCaLejCMWFzARQ5XPqtxFh6zPhTefEcqg?=
 =?us-ascii?Q?q7oHwkzh98tPMkIE4H63xZi/XV33vZEmmTGUiBLru3+oWc7jagfkc3Nh868a?=
 =?us-ascii?Q?sncPd2TMnwnWPVvhm8kJTJWKagc7R4bM+nB9zujEbrX6//C8CTxlkN1xEKbJ?=
 =?us-ascii?Q?XO4ZvwYeFvGGx/peo2p96gZslDMEuZy0oYkBqr37gVjjXPR1sE4VMCLrXkW4?=
 =?us-ascii?Q?IecBtVGjjTrOvYqFBOPjbYPJ9NQheL1+HudEvk19npwVYR46SL9AkvlA3SEA?=
 =?us-ascii?Q?y4XrQKcRVlJfjToZVube4flp1MOm+48eJxUG7CmYSYyc5+dCfRrzVYuGvPBF?=
 =?us-ascii?Q?RJ/oSbJTCqCI6kqb1WzjrjoW7ueDSPI5IkBHPkvZplhvDG0bJtxE1VOh3PHN?=
 =?us-ascii?Q?F9jEisIwvJ9NX28xUxyshmu3K/O6YQGDKQBlCeKpVnXo1+2sVg82KlaAFMy+?=
 =?us-ascii?Q?enoCStlekNKUPbj51rjD4uQ=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB8193.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1EVOjMkBN/Zfhh3Jp+aoOlY/ckmKD2YS0jXyun+CjkzwgJ5yDTxzUm2o8opM?=
 =?us-ascii?Q?GyRFQS2IyFqJoIyXyNfJ7Eoy5jqcPOJADqGUrd7Vd2Tw2KUnepxNK/SKnLPM?=
 =?us-ascii?Q?0tPYWjdaCPgA42zHOHCgsAlAeRN2NFL1bto7X1BDFc5UeGX1VVkFLqTnW7Bn?=
 =?us-ascii?Q?OSoHIN1+92GcxRNIf8lvp7XKApE9fwtiOoWusg9ZkY694c/pK8WPIQRzJXm5?=
 =?us-ascii?Q?Fhx0TIaQ6DH0/eu0MWNAo9jxImU93gJzzBRn5satBQjLaFrr1L1tmN4/mjUR?=
 =?us-ascii?Q?AOlUw2GZgqbmDdGGIiUZhavdDO4VydFTlfEf3YOFa7QvUcbvqSQb1ngRYjwh?=
 =?us-ascii?Q?JU1nL5UftJK+qZEP+QJRBxr+Te/XTxaEZ9hUgfP9l8DeC8NbXpGWWhHzo2Ts?=
 =?us-ascii?Q?lAlo2YLHv7NgwRcQi8a99IoIAy6iV7ajS34SJpoUdX8gwDiKm3P2Q7Z2fyqH?=
 =?us-ascii?Q?/K7cN+b+5funvuJzlLk45ZgKRScNNUS52bZRvjwyxgdsPYieP8fZ6k51tN2k?=
 =?us-ascii?Q?5l6vn6aXllwzwtgL4uyjZZebwb2O654R6dLH8yFN17+Dt1DiD7CWTMemALg/?=
 =?us-ascii?Q?xDy09dDoudCQIfKrWTsnGSNqHlgGz9fOSYKIEtfETF5McNEy035F1nSc6ECe?=
 =?us-ascii?Q?YoJCeGTjBiAQZ5rjM9k1EeCVwj7mZmicwO/vqcB5U5DyatfC4TWLjH5lkH95?=
 =?us-ascii?Q?t3qO1AWHYBv1RYA+khUfu8Vq9w/SXaI59djZtXPAKjR9uIwhQZ7Ri9RM4owM?=
 =?us-ascii?Q?FZyiePEWAhAkoIYo5KGldO2H9wN0Ge45IsGPQuHqEGbFOxVn0CXCUI10UHbm?=
 =?us-ascii?Q?OZa9RZBY9DieQ22mItoa7jkaaUxqqvwKTQJ6LHzGjKu4gYqMILeqeWjbmHBr?=
 =?us-ascii?Q?mTiQvpr1/trgsKKtjlRyatzcsKz/nSxkqImQtaWu5CC7BgPVczhPczSP0laD?=
 =?us-ascii?Q?DCTtbKqx+lH2cLzQB4w2M17f4f03iBGfgDiiFHwpR2YKAKRD1f2tYPhN6kvU?=
 =?us-ascii?Q?1e3VnQ4t/PJC2LVIJdAJrxlYTXNjU96+7nqSGvmga2W+wflkGumh3g8TG56C?=
 =?us-ascii?Q?uG3/6o6Pl5Dl9hqcc1MKWK7rcIFniygGY4xCJLvKmAbsuYFn71CzlzTpKonp?=
 =?us-ascii?Q?KL86yYBTiAE2rU6WSxf2EfwsaiaeqO7bKXb2bI+DWezCu173UeyWVPX//G1+?=
 =?us-ascii?Q?90xIm7+30RBfta/oq4JzoAa16B2SVXbZU/JtdPhB945Nr8iKw59/72yuyh6T?=
 =?us-ascii?Q?6APyGOpAyFBtcZ7np3ShHbTWi7coau+YBa+cHohxcajNgYn8dhA0n/O//uWo?=
 =?us-ascii?Q?mpPBTx4IN0lUsvCpslqFGY4y+5sBUFK9LnAIq/B8BlEPe7IwBvfa8pKzXnfK?=
 =?us-ascii?Q?F+bQRYbBiEDdSvnlIg5EmuNN7PFfKzmAwwRJ64oxv6iCIBb0+TOKfwOOH5vt?=
 =?us-ascii?Q?wE7uDfS1LkpDnL/vYkr1xKCY4q7fU0/QlR8ELLKIEJhxjQnUJ+7Hhw4wg0T7?=
 =?us-ascii?Q?jmNJqjqh3MpuvK+51DTse9HCL1wWvOxQ/Kc12bY/vtnwrBEUYMOsiNYhDumv?=
 =?us-ascii?Q?aVJCBZFtbyYhmTU2+GNBkq7KDU7mRwOmmC9AzejURxqIitSE9c2Q8zCDs4Co?=
 =?us-ascii?Q?65pcnXPbUSFKMwH9WkHggOFr4Yk62IwLH72LAPs864N4/P9Lr2HcHcaKp7Xx?=
 =?us-ascii?Q?F8VjrbW5eOMu69T1fmSoEbvpIidvoJ3TGgiwYEAMkz3LxZha?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB8193.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88eff2d4-c42f-4d19-e6c7-08de68ead55a
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2026 21:24:54.3887 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gjb5mQdc6DlIx8cJHFnAnFolkSLTVh89OQ7EHylYkoH/LvDUXo2C12MPeN5H9ZwI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6099
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

[Public]

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Sriniv=
asan
> Shanmugam
> Sent: Tuesday, February 10, 2026 10:20 AM
> To: Hung, Alex <Alex.Hung@amd.com>; Pillai, Aurabindo
> <Aurabindo.Pillai@amd.com>
> Cc: amd-gfx@lists.freedesktop.org; SHANMUGAM, SRINIVASAN
> <SRINIVASAN.SHANMUGAM@amd.com>; Dan Carpenter
> <dan.carpenter@linaro.org>; Wentland, Harry <Harry.Wentland@amd.com>; Mar=
io
> Limonciello <superm1@kernel.org>; Chung, ChiaHsuan (Tom)
> <ChiaHsuan.Chung@amd.com>; Li, Roman <Roman.Li@amd.com>
> Subject: [PATCH v2] drm/amd/display: Fix out-of-bounds stream encoder ind=
ex v2
>
> eng_id can be negative and that stream_enc_regs[] can be indexed out of b=
ounds.
>
> eng_id is used directly as an index into stream_enc_regs[], which has onl=
y 5
> entries. When eng_id is 5 (ENGINE_ID_DIGF) or negative, this can access
> memory past the end of the array.
>
> Add a bounds check using ARRAY_SIZE() before using eng_id as an index.
> The unsigned cast also rejects negative values.
>
> This avoids out-of-bounds access.
>
> Fixes the below smatch error:
> dcn*_resource.c: stream_encoder_create() may index stream_enc_regs[eng_id=
]
> out of bounds (size 5).
>
> drivers/gpu/drm/amd/amdgpu/../display/dc/resource/dcn351/dcn351_resource.=
c
>     1246 static struct stream_encoder *dcn35_stream_encoder_create(
>     1247         enum engine_id eng_id,
>     1248         struct dc_context *ctx)
>     1249 {
>
>     ...
>
>     1255
>     1256         /* Mapping of VPG, AFMT, DME register blocks to DIO bloc=
k instance
> */
>     1257         if (eng_id <=3D ENGINE_ID_DIGF) {
>
> ENGINE_ID_DIGF is 5.  should <=3D be <?
>
> Unrelated but, ugh, why is Smatch saying that "eng_id" can be negative?
> end_id is type signed long, but there are checks in the caller which prev=
ent it from
> being negative.
>
>     1258                 vpg_inst =3D eng_id;
>     1259                 afmt_inst =3D eng_id;
>     1260         } else
>     1261                 return NULL;
>     1262
>
>     ...
>
>     1281
>     1282         dcn35_dio_stream_encoder_construct(enc1, ctx, ctx->dc_bi=
os,
>     1283                                         eng_id, vpg, afmt,
> --> 1284                                         &stream_enc_regs[eng_id]=
,
>                                                   ^^^^^^^^^^^^^^^^^^^^^^^=
 This stream_enc_regs[]
> array has 5 elements so we are one element beyond the end of the array.
>
>     ...
>
>     1287         return &enc1->base;
>     1288 }
>
> v2: use explicit bounds check as suggested by Roman/Dan; avoid unsigned i=
nt
> cast

>
> Fixes: 2728e9c7c842 ("drm/amd/display: add DC changes for DCN351")
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Mario Limonciello <superm1@kernel.org>
> Cc: Alex Hung <alex.hung@amd.com>
> Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Cc: ChiaHsuan Chung <chiahsuan.chung@amd.com>
> Cc: Roman Li <roman.li@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>  .../drm/amd/display/dc/resource/dcn315/dcn315_resource.c  | 8 ++++----
> .../drm/amd/display/dc/resource/dcn316/dcn316_resource.c  | 8 ++++----
>  .../drm/amd/display/dc/resource/dcn32/dcn32_resource.c    | 8 ++++----
>  .../drm/amd/display/dc/resource/dcn321/dcn321_resource.c  | 8 ++++----
>  .../drm/amd/display/dc/resource/dcn35/dcn35_resource.c    | 8 ++++----
>  .../drm/amd/display/dc/resource/dcn351/dcn351_resource.c  | 8 ++++----
>  6 files changed, 24 insertions(+), 24 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resour=
ce.c
> b/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c
> index a8283f21008e..5101bc24342c 100644
> --- a/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c
> @@ -1230,12 +1230,12 @@ static struct stream_encoder
> *dcn315_stream_encoder_create(
>       /*PHYB is wired off in HW, allow front end to remapping, otherwise =
needs
> more changes*/
>
>       /* Mapping of VPG, AFMT, DME register blocks to DIO block instance =
*/
> -     if (eng_id <=3D ENGINE_ID_DIGF) {
> -             vpg_inst =3D eng_id;
> -             afmt_inst =3D eng_id;
> -     } else
> +     if (eng_id < 0 || eng_id >=3D (int)ARRAY_SIZE(stream_enc_regs))

Let's drop the (int) cast as well.
The compiler should handle the type promotion correctly without explicit ca=
sting.

>               return NULL;
>
> +     vpg_inst =3D eng_id;
> +     afmt_inst =3D eng_id;
> +
>       enc1 =3D kzalloc(sizeof(struct dcn10_stream_encoder), GFP_KERNEL);
>       vpg =3D dcn31_vpg_create(ctx, vpg_inst);
>       afmt =3D dcn31_afmt_create(ctx, afmt_inst); diff --git
> a/drivers/gpu/drm/amd/display/dc/resource/dcn316/dcn316_resource.c
> b/drivers/gpu/drm/amd/display/dc/resource/dcn316/dcn316_resource.c
> index 4da0e9320159..09cfc0b74e91 100644
> --- a/drivers/gpu/drm/amd/display/dc/resource/dcn316/dcn316_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/resource/dcn316/dcn316_resource.c
> @@ -1223,12 +1223,12 @@ static struct stream_encoder
> *dcn316_stream_encoder_create(
>       int afmt_inst;
>
>       /* Mapping of VPG, AFMT, DME register blocks to DIO block instance =
*/
> -     if (eng_id <=3D ENGINE_ID_DIGF) {
> -             vpg_inst =3D eng_id;
> -             afmt_inst =3D eng_id;
> -     } else
> +     if (eng_id < 0 || eng_id >=3D (int)ARRAY_SIZE(stream_enc_regs))
>               return NULL;
>
> +     vpg_inst =3D eng_id;
> +     afmt_inst =3D eng_id;
> +
>       enc1 =3D kzalloc(sizeof(struct dcn10_stream_encoder), GFP_KERNEL);
>       vpg =3D dcn31_vpg_create(ctx, vpg_inst);
>       afmt =3D dcn31_afmt_create(ctx, afmt_inst); diff --git
> a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
> b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
> index d3b92c61b7ad..8538cd574eb2 100644
> --- a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
> @@ -1211,12 +1211,12 @@ static struct stream_encoder
> *dcn32_stream_encoder_create(
>       int afmt_inst;
>
>       /* Mapping of VPG, AFMT, DME register blocks to DIO block instance =
*/
> -     if (eng_id <=3D ENGINE_ID_DIGF) {
> -             vpg_inst =3D eng_id;
> -             afmt_inst =3D eng_id;
> -     } else
> +     if (eng_id < 0 || eng_id >=3D (int)ARRAY_SIZE(stream_enc_regs))
>               return NULL;
>
> +     vpg_inst =3D eng_id;
> +     afmt_inst =3D eng_id;
> +
>       enc1 =3D kzalloc(sizeof(struct dcn10_stream_encoder), GFP_KERNEL);
>       vpg =3D dcn32_vpg_create(ctx, vpg_inst);
>       afmt =3D dcn32_afmt_create(ctx, afmt_inst); diff --git
> a/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
> b/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
> index d08691ea27ea..1b9f1770e7f8 100644
> --- a/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
> @@ -1192,12 +1192,12 @@ static struct stream_encoder
> *dcn321_stream_encoder_create(
>       int afmt_inst;
>
>       /* Mapping of VPG, AFMT, DME register blocks to DIO block instance =
*/
> -     if (eng_id <=3D ENGINE_ID_DIGF) {
> -             vpg_inst =3D eng_id;
> -             afmt_inst =3D eng_id;
> -     } else
> +     if (eng_id < 0 || eng_id >=3D (int)ARRAY_SIZE(stream_enc_regs))
>               return NULL;
>
> +     vpg_inst =3D eng_id;
> +     afmt_inst =3D eng_id;
> +
>       enc1 =3D kzalloc(sizeof(struct dcn10_stream_encoder), GFP_KERNEL);
>       vpg =3D dcn321_vpg_create(ctx, vpg_inst);
>       afmt =3D dcn321_afmt_create(ctx, afmt_inst); diff --git
> a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
> b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
> index 945da8cffada..00999c3e0a08 100644
> --- a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
> @@ -1274,12 +1274,12 @@ static struct stream_encoder
> *dcn35_stream_encoder_create(
>       int afmt_inst;
>
>       /* Mapping of VPG, AFMT, DME register blocks to DIO block instance =
*/
> -     if (eng_id <=3D ENGINE_ID_DIGF) {
> -             vpg_inst =3D eng_id;
> -             afmt_inst =3D eng_id;
> -     } else
> +     if (eng_id < 0 || eng_id >=3D (int)ARRAY_SIZE(stream_enc_regs))
>               return NULL;
>
> +     vpg_inst =3D eng_id;
> +     afmt_inst =3D eng_id;
> +
>       enc1 =3D kzalloc(sizeof(struct dcn10_stream_encoder), GFP_KERNEL);
>       vpg =3D dcn31_vpg_create(ctx, vpg_inst);
>       afmt =3D dcn31_afmt_create(ctx, afmt_inst); diff --git
> a/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
> b/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
> index e660889904a9..328cc6c091c5 100644
> --- a/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
> @@ -1254,12 +1254,12 @@ static struct stream_encoder
> *dcn35_stream_encoder_create(
>       int afmt_inst;
>
>       /* Mapping of VPG, AFMT, DME register blocks to DIO block instance =
*/
> -     if (eng_id <=3D ENGINE_ID_DIGF) {
> -             vpg_inst =3D eng_id;
> -             afmt_inst =3D eng_id;
> -     } else
> +     if (eng_id < 0 || eng_id >=3D (int)ARRAY_SIZE(stream_enc_regs))
>               return NULL;
>
> +     vpg_inst =3D eng_id;
> +     afmt_inst =3D eng_id;
> +
>       enc1 =3D kzalloc(sizeof(struct dcn10_stream_encoder), GFP_KERNEL);
>       vpg =3D dcn31_vpg_create(ctx, vpg_inst);
>       afmt =3D dcn31_afmt_create(ctx, afmt_inst);
> --
> 2.34.1

