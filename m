Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E69D8C43458
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jul 2026 13:44:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 006CC10E4CF;
	Tue,  7 Jul 2026 13:44:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1fpuhUUl";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010057.outbound.protection.outlook.com [52.101.85.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BADBA10E4CF
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jul 2026 13:44:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rc0++P0CJC9IyvNoOm3sgrbw2DhWLknwf9hXIDNfdsf74yJuqKDy5SwwOdwDsDHmLcCk+DK7UVs25tWBkxWq/votVnK+QK3qwVlMzYujKeUiF+dIH+nxLQSpM4AaoPFTX/t9WFyfev98vFFLttmzhO3TNL4Y/WdPsVohHdzBSyO8y61GD2bmLfEN8JZvfnzYrHRk4wNJyo/J8UIdvBycVD5bb+cHyM/6rT5tYi1DO0TOX3eFvEAAXQ65PWekNtJORTUT2p0gDypqXmV7KbWZdJ5irL4OioNpE/cRsV8V0EEFKXrN4mdTFjE4pRbnO32J4A/YlafQb38IxnWAGnC8aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iTEvOzyFdnh+eRhAzLzlppoDNjTcRjjVl26fuesyXqo=;
 b=ZUKdrW87EUc/f/vdMTacIBWSJorhL+hQpsrs4H8Bn12SGH40T42v+CeqeE6Wg6bx0Mo3XnCbJn5Zkj7IIAjX3UyX6yuZITvV+OxFTfONJ5FaBFfRytC783OVQF7QmG+E7SXxmcSzkgueTwmSGFlZX11Hh//OJ2L5R2UKHp4uGLLJetXMgWIAiNC79kdMoNZovcqauwtx/0OM8euo5yNbsw+FZhp8mEOH3fpzPpoFeUNHJrhgYGhvN138mWtS+Z01/LhA477FtzUembWuPxupBLzYytx24Do7g/X/EVW13B8SZfjmzKrQ4HOv1YgPesXjg9wiSArMypOkM2e+a89UpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iTEvOzyFdnh+eRhAzLzlppoDNjTcRjjVl26fuesyXqo=;
 b=1fpuhUUlDNiafaBFZF3dgBLx0MI466OugHDOm7kLEjS3Tw+0XSI+Dxw2UgwgaBNnzjSWHtkQ2hR1RELb+lmpDC0Id/ZAqBPeh2AC7C2h/tVzvElNp/rrNVSH+4oxqzkRee0iQ4BDBEp0RqvAiyA3xcnNsXq2JhCgE4dKzDBOz+c=
Received: from DS7PR12MB5910.namprd12.prod.outlook.com (2603:10b6:8:7b::7) by
 DS7PR12MB6238.namprd12.prod.outlook.com (2603:10b6:8:96::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.10; Tue, 7 Jul 2026 13:43:56 +0000
Received: from DS7PR12MB5910.namprd12.prod.outlook.com
 ([fe80::bdc1:eca6:c7fb:acb4]) by DS7PR12MB5910.namprd12.prod.outlook.com
 ([fe80::bdc1:eca6:c7fb:acb4%4]) with mapi id 15.21.0181.008; Tue, 7 Jul 2026
 13:43:55 +0000
From: "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>
To: Antonio Quartulli <antonio@mandelbit.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Wentland, Harry" <Harry.Wentland@amd.com>, "Li, Sun peng (Leo)"
 <Sunpeng.Li@amd.com>, "Li, Roman" <Roman.Li@amd.com>, "Lin, Wayne"
 <Wayne.Lin@amd.com>, "Chung, ChiaHsuan (Tom)" <ChiaHsuan.Chung@amd.com>,
 "Zuo, Jerry" <Jerry.Zuo@amd.com>, "Wheeler, Daniel" <Daniel.Wheeler@amd.com>, 
 "Wu, Ray" <Ray.Wu@amd.com>, "LIPSKI, IVAN" <IVAN.LIPSKI@amd.com>, "Hung,
 Alex" <Alex.Hung@amd.com>, "Lin, Ping Lei" <PingLei.Lin@amd.com>, "Chen,
 Chen-Yu" <Chen-Yu.Chen@amd.com>
Subject: Re: [PATCH 23/24] drm/amd/display: fix compressed buffer config
 routine waiting time
Thread-Topic: [PATCH 23/24] drm/amd/display: fix compressed buffer config
 routine waiting time
Thread-Index: AQHc9DI6G2ZJNQTHDEKDbu6GTAnHJ7ZgoO4AgAGi4pw=
Date: Tue, 7 Jul 2026 13:43:54 +0000
Message-ID: <DS7PR12MB591098F429A582F50D15AF4B8BF02@DS7PR12MB5910.namprd12.prod.outlook.com>
References: <20260604145428.809959-1-aurabindo.pillai@amd.com>
 <20260604145428.809959-24-aurabindo.pillai@amd.com>
 <4e7f73d5-5407-4ed4-8b91-483b97ad70f0@mandelbit.com>
In-Reply-To: <4e7f73d5-5407-4ed4-8b91-483b97ad70f0@mandelbit.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-07-07T13:43:54.425Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD
 General; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=1;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB5910:EE_|DS7PR12MB6238:EE_
x-ms-office365-filtering-correlation-id: 11f052f9-7eaf-4b35-cddd-08dedc2dc9b8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|13003099007|22082099003|18002099003|38070700021|11063799006|56012099006|4143699003|8096899003;
x-microsoft-antispam-message-info: cm/zhGgaBrZTgPJh8caY+f7xLeCWaWVtRF0XIvxPmkjrjGGR5v5IMIrEVyBRkhbRur/mi6+Sq1O5B11G88EWRPxSA+Br+97xM+mqNLr9Tlyy790aSb3hlECePtWbTnuZZhSE3QMdpqdBTGQ8ycrsFlLvgNXBLO8dePb45cCj2PbvokiOGyJdTp2e85YPtmP5C7Mc9H1ATsTKcjLQkk75HbsMUlaNmU8LsjvFmdfHoc6E1SlzIZjUrLd0JtKLGyy7f1V1W5AKD3RTlCtXl4tshna/0Kq3F3LFuGFsLhCXo/wIPIlxIY2sD7i0i4nONjwa5Uk8WM0iJYKJEv1qT82jj9qQNnoAGJQFXvG91QMqucNsfyimoxInUGiCOqx34Jg860OcuKwLkyyyDCR2QiSV0jw3E6QU1w8byqmrBS3gDpL+edVrhChPWCjpg2VD90+JUwdSjHA+F9AzWEBhzNhTsjrWbkSG6OXC9CHr4eisOnZLXrx/cZXu4ZDnQnBFfCBQkVfpkczwtDfID2QYIIiHq6v3WbUjnDC1ES9XVAINQw/SYtQbGb+K6L8xD9eH+WdpccuMAt2R2L7dlIXyNpD2nPXPMOVVNVQ0IT2ZWPfAuMmMg0+KqykSMp8w7MxRLQfEF8Jiru2JKSATTMG5f+wCE9kZZWCkklndMsGwMs6eT98=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB5910.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(13003099007)(22082099003)(18002099003)(38070700021)(11063799006)(56012099006)(4143699003)(8096899003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?yChe6HpTCt9+01f50wuYLzPz5ifjYPAmkoKnZLUL9F6+iwHD+yTYgHsoxTyx?=
 =?us-ascii?Q?35l9JnUSXoFSLbfuPXi+e+gcsEHFgbY+egOIGLsXsXbteXs0/MKEdOWGRJnD?=
 =?us-ascii?Q?HoAkg8gFty7wcfWONOBfaCcMY8xLbIB1YDGeZZmTC6Q+I6ULNVtHZSKgRfVa?=
 =?us-ascii?Q?MppYYr7M0nB41PhX1f7jnuhxjrqxHwztTFDKrSVvmdowcKJI17HChUkFnnF1?=
 =?us-ascii?Q?lpmI3tAOIFHM1CS5xhC4rSfC+55dU3PEvctMrR4lpy+YPg7mHE3QkN+iE5m2?=
 =?us-ascii?Q?wVkPAumiJE72xAahndTJfz2Jc4zZ+k/i1sY0qsJstvimIGiDyI82hLooW6Ba?=
 =?us-ascii?Q?Lzhy/dbo0BDUcZCvSY/8VngSHb1K6DUBXEqKTqF4Y/7kmude8hy3HQu157DA?=
 =?us-ascii?Q?sCYmdnwAzAx7RzS0dNx2/POdzxZSTFlETF18CUZVcd5ZvNBJnl9vS/8iDals?=
 =?us-ascii?Q?mshjP/rQKYik/Ghp44/KFmuXnCy3gop+tlhdIAXpTB2k+flCuuYdZlBJPfkK?=
 =?us-ascii?Q?HewD6BLL126aZP1s8mWzyip9rRcPjEXw5SmCJTjowWFxPQRA+s6hVgHzzivg?=
 =?us-ascii?Q?EsQii8n6Dqcaz/yYogCMEbQiH4//XovWhBdyhj9dKQ78Ro0PUemBCQXP48hf?=
 =?us-ascii?Q?UvmnBTcVKY0e19GlYNf4kijktmf9iDGvtvLRmlVm0AOJ+oGV6H5f0wsHLX7l?=
 =?us-ascii?Q?PT8grfUCq/GXUiuiHtqlgYFbrVslX6s9+hRJiabMzeQzrkkb9x3R8U2QfXBb?=
 =?us-ascii?Q?udj6sd2epi8hsGIhm0RxT13xyzqpFjJwtDdGv6mwoBo8ji3GL5rrJNLOwORv?=
 =?us-ascii?Q?Q84dUJrkyd0bJG3DaWaXzUEC8dOleGhSD554ZH+1JdK3Q/8arTDcZtovZkNO?=
 =?us-ascii?Q?3WSq/9nn+VvyJaygabQ+lM2jU3HDpZRIRWMjTXPLRBtkZYTXSCB/lSRWCdx7?=
 =?us-ascii?Q?bmjp8sRhZBtBkgQB0po9VL5uqZn+bawEqsVaykMGXSNLjzJWr22+VL6zslSQ?=
 =?us-ascii?Q?Qvvbhp5DOxHUMSayZuPkMIbtK6+tkI3FfxPoLTTmLUS97OCV8GYjyt9+TmdO?=
 =?us-ascii?Q?xSurSivn/l5SgqPkb8UDWcRmZhdR5+BVt/BlBChtaG6njy9A4XODEbpA5kzI?=
 =?us-ascii?Q?G1OqYnGFddDC5FU+xj0NnhMdluKG9LcOwis/HGPnrSD4YAMU/n3Ko8APRuJf?=
 =?us-ascii?Q?Cx8xME/c9kziAFGsl4vMpWvmv+JdvLmwxnVQeO/eS2YiUNRV6+uvsWzPQCvi?=
 =?us-ascii?Q?CsDHjj89RcYxBjTddYR17YKCC36GhPzgUNX26Rjmu2SRriZKxK0PWnFyK3Fw?=
 =?us-ascii?Q?i0CY5y2IJcsAlm4Nh9v7aTvHEmveJjTRNK3eT8ifzfwH//hqEKH8KhmX1z/l?=
 =?us-ascii?Q?hWOK6rldd44vBr+gYcQoTgfwRViFGzevhpr44SWPJk5cIYY9UsIQez9P5DuO?=
 =?us-ascii?Q?eF/cgJrgMZgIvu9+AjYK3kIlYUVsDkhEIci6IeLUU9cZqX3GoCLhCKtiPwDf?=
 =?us-ascii?Q?HmDKLzNWBKlVX9LcU6L6Qe2JUQp7mSxydtkH+6XNKMJQEcE0f7DihmkrAlZo?=
 =?us-ascii?Q?0vMTzLOdL/MXUQ6NIxL/ujQhzODy1DD14JojABwJwwkkidB95KoN/DthmP8D?=
 =?us-ascii?Q?Uu3EfFd8ra4954JpgQQbSJJRQosjTKv/tmlYDAWHoDbutVllZ4HPfDPB6qNL?=
 =?us-ascii?Q?YhbDIN+GJ26fjbMiUV2LWFtR/0NlSdwrXXDEg0OLqjRU0y7o?=
Content-Type: multipart/alternative;
 boundary="_000_DS7PR12MB591098F429A582F50D15AF4B8BF02DS7PR12MB5910namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5910.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11f052f9-7eaf-4b35-cddd-08dedc2dc9b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2026 13:43:54.8616 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EEofrl0IlswR+e+fVQWuUuVayCeGasLJ1tKxYRtQ+OATShh+9XbTvzMnJf3612Hm925l9o1/LHNjWyP4zlfG7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6238
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

--_000_DS7PR12MB591098F429A582F50D15AF4B8BF02DS7PR12MB5910namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

AMD General

Hi,

Your patch is already on amd-staging-drm-next: https://gitlab.freedesktop.o=
rg/agd5f/linux/-/commit/b9f2c37d211967386ce5860082db54bc01ac3efa

It will land in the next mainline. Since the patch doesnt have Cc: stable, =
if you'd like this applied to other stable trees, then it'll have to be sen=
t separately.


--

Regards,
Jay
________________________________
From: Antonio Quartulli <antonio@mandelbit.com>
Sent: Monday, July 6, 2026 8:40 AM
To: Pillai, Aurabindo <Aurabindo.Pillai@amd.com>; amd-gfx@lists.freedesktop=
.org <amd-gfx@lists.freedesktop.org>
Cc: Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo) <Sunpeng.L=
i@amd.com>; Li, Roman <Roman.Li@amd.com>; Lin, Wayne <Wayne.Lin@amd.com>; C=
hung, ChiaHsuan (Tom) <ChiaHsuan.Chung@amd.com>; Zuo, Jerry <Jerry.Zuo@amd.=
com>; Wheeler, Daniel <Daniel.Wheeler@amd.com>; Wu, Ray <Ray.Wu@amd.com>; L=
IPSKI, IVAN <IVAN.LIPSKI@amd.com>; Hung, Alex <Alex.Hung@amd.com>; Lin, Pin=
g Lei <PingLei.Lin@amd.com>; Chen, Chen-Yu <Chen-Yu.Chen@amd.com>
Subject: Re: [PATCH 23/24] drm/amd/display: fix compressed buffer config ro=
utine waiting time

[Some people who received this message don't often get email from antonio@m=
andelbit.com. Learn why this is important at https://aka.ms/LearnAboutSende=
rIdentification ]

Hi all,

On 04/06/2026 16:52, Aurabindo Pillai wrote:
> From: Antonio Quartulli <antonio@mandelbit.com>
>
> Replace the four open-coded REG_WAIT calls with calls to
> dcn31_wait_for_det_apply() so the compressed buffer (compbuf) sizing
> path waits long enough for the DET size update to take effect, and the
> wait timing stays consistent across the driver.
>
> No functional change beyond the corrected timeout.
>
> Signed-off-by: Antonio Quartulli <antonio@mandelbit.com>
> Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Reviewed-by: Alex Hung <alex.hung@amd.com>

Sorry to bother, but I was just wondering if this patch/series got
dropped or if it's simply in the pipe for more review/merge?

Am I right it should pop-up in https://gitlab.freedesktop.org/drm/kernel
before going to Linus?

Thanks a lot!
Regards,

--
Antonio Quartulli

CEO and Co-Founder
Mandelbit Srl
https://www.mandelbit.com


--_000_DS7PR12MB591098F429A582F50D15AF4B8BF02DS7PR12MB5910namp_
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
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<div>
<div style=3D"font-family: Calibri; text-align: left; color: rgb(0, 0, 255)=
; margin-left: 5pt; font-size: 10pt;">
AMD General</div>
<br>
</div>
Hi,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Your patch is already on amd-staging-drm-next: <a href=3D"https://gitlab.fr=
eedesktop.org/agd5f/linux/-/commit/b9f2c37d211967386ce5860082db54bc01ac3efa=
">
https://gitlab.freedesktop.org/agd5f/linux/-/commit/b9f2c37d211967386ce5860=
082db54bc01ac3efa</a></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
It will land in the next mainline. Since the patch doesnt have Cc: stable, =
if you'd like this applied to other stable trees, then it'll have to be sen=
t separately.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"Signature" class=3D"elementToProof">
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Calibri, Arial, Helveti=
ca, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
--</div>
<div class=3D"elementToProof" style=3D"font-family: Calibri, Arial, Helveti=
ca, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Calibri, Arial, Helveti=
ca, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
Regards,</div>
<div class=3D"elementToProof" style=3D"font-family: Calibri, Arial, Helveti=
ca, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
Jay<br>
</div>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Antonio Quartulli &lt=
;antonio@mandelbit.com&gt;<br>
<b>Sent:</b> Monday, July 6, 2026 8:40 AM<br>
<b>To:</b> Pillai, Aurabindo &lt;Aurabindo.Pillai@amd.com&gt;; amd-gfx@list=
s.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Wentland, Harry &lt;Harry.Wentland@amd.com&gt;; Li, Sun peng (Le=
o) &lt;Sunpeng.Li@amd.com&gt;; Li, Roman &lt;Roman.Li@amd.com&gt;; Lin, Way=
ne &lt;Wayne.Lin@amd.com&gt;; Chung, ChiaHsuan (Tom) &lt;ChiaHsuan.Chung@am=
d.com&gt;; Zuo, Jerry &lt;Jerry.Zuo@amd.com&gt;; Wheeler, Daniel &lt;Daniel=
.Wheeler@amd.com&gt;;
 Wu, Ray &lt;Ray.Wu@amd.com&gt;; LIPSKI, IVAN &lt;IVAN.LIPSKI@amd.com&gt;; =
Hung, Alex &lt;Alex.Hung@amd.com&gt;; Lin, Ping Lei &lt;PingLei.Lin@amd.com=
&gt;; Chen, Chen-Yu &lt;Chen-Yu.Chen@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH 23/24] drm/amd/display: fix compressed buffer co=
nfig routine waiting time</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">[Some people who received this message don't often=
 get email from antonio@mandelbit.com. Learn why this is important at
<a href=3D"https://aka.ms/LearnAboutSenderIdentification">https://aka.ms/Le=
arnAboutSenderIdentification</a> ]<br>
<br>
Hi all,<br>
<br>
On 04/06/2026 16:52, Aurabindo Pillai wrote:<br>
&gt; From: Antonio Quartulli &lt;antonio@mandelbit.com&gt;<br>
&gt;<br>
&gt; Replace the four open-coded REG_WAIT calls with calls to<br>
&gt; dcn31_wait_for_det_apply() so the compressed buffer (compbuf) sizing<b=
r>
&gt; path waits long enough for the DET size update to take effect, and the=
<br>
&gt; wait timing stays consistent across the driver.<br>
&gt;<br>
&gt; No functional change beyond the corrected timeout.<br>
&gt;<br>
&gt; Signed-off-by: Antonio Quartulli &lt;antonio@mandelbit.com&gt;<br>
&gt; Signed-off-by: Aurabindo Pillai &lt;aurabindo.pillai@amd.com&gt;<br>
&gt; Reviewed-by: Alex Hung &lt;alex.hung@amd.com&gt;<br>
<br>
Sorry to bother, but I was just wondering if this patch/series got<br>
dropped or if it's simply in the pipe for more review/merge?<br>
<br>
Am I right it should pop-up in <a href=3D"https://gitlab.freedesktop.org/dr=
m/kernel">
https://gitlab.freedesktop.org/drm/kernel</a><br>
before going to Linus?<br>
<br>
Thanks a lot!<br>
Regards,<br>
<br>
--<br>
Antonio Quartulli<br>
<br>
CEO and Co-Founder<br>
Mandelbit Srl<br>
<a href=3D"https://www.mandelbit.com">https://www.mandelbit.com</a><br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_DS7PR12MB591098F429A582F50D15AF4B8BF02DS7PR12MB5910namp_--
