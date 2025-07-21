Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 770F4C83F25
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jul 2025 13:41:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E47710E291;
	Mon, 21 Jul 2025 13:41:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xwXmgbXF";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2089.outbound.protection.outlook.com [40.107.94.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A93A10E284
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Jul 2025 13:41:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dlkMDBd5Bdrsv0cTgqS9rFkQzINSq+FRy2XSt3Qze9qYqFhT3d2msExRzsp2RHDF8AN6JhSKSgw7dw+DH1n+50HplgVgJBq3T6tEMf2r+mj1chmWtQyttTrkJsUD3ppXnfQ3M07m1ZfWTt7nWQm0scin8NpTKiZzD6r3SnqO8q1qBO/2HlESVoUs+Cn5ZKEK1+OVYcJQPd7AiMxNbxdw97Szj+FRv77rmyvwpXa1sj8lE2/x9RQe8vS67hcE1qFNOSa6pUNZpvH/dY6YM1YCi922DGYOmjdltQWrlSDB+B+QxdfayqJ7b8tXn82L1U5edIsEYtMWrQeoqIuys9I4jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nNK+DQP4StPQgaGmFfhp91rjYqoa0hqAbpU9EHfkcf4=;
 b=nIRKeRk+QxmNXhjbCuk3DfF6Yd2wDwsCtvfMoSuuutWMfMnx7hbnflukSesa+tURoOdnTv/u8DGc3c2TkJv49cx0R2oav5EYwOwegUXpRQQzuwjwIxhxeo4+mJC5gP/C0IMPdR+0qfIQmOaM21/WOYq9iRx9AUCij2sUwGo8a5GJ7mYs9kqqvqMctusVROqFhSYqE6uuHj91/t2vWskFfDyJvx5zK8sdA1/SRNYE5kJ8eh8ZYND3zh/uetiQ0cdRmP+J6gOi+idH7Tl1pP+lUPByRQ1Q1524IFdB4dWD+1lfnxzEpJJyl2qMhpmpRQvOz5lruXuCzIVkLgJUCV4D+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nNK+DQP4StPQgaGmFfhp91rjYqoa0hqAbpU9EHfkcf4=;
 b=xwXmgbXFO4jwxhrP5OAkxwDcgkfPyjqG0vjVmYjxsDtNn4cQ5qTVqq0FJXjGNBrpHEeq2VP+2MOf3jUSFPnjYSAdXN0/mucewjM5YMGy976De59pYje0zg3db63nrxiZVGZqrt6MdhImx7PqRJAZC7yYZSNSmldTwyYVKYqxPqs=
Received: from DS0PR12MB6534.namprd12.prod.outlook.com (2603:10b6:8:c1::19) by
 CH2PR12MB4296.namprd12.prod.outlook.com (2603:10b6:610:af::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8943.30; Mon, 21 Jul 2025 13:41:33 +0000
Received: from DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::ea87:74ba:36ec:8cf6]) by DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::ea87:74ba:36ec:8cf6%4]) with mapi id 15.20.8943.029; Mon, 21 Jul 2025
 13:41:32 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Lin, Wayne" <Wayne.Lin@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Wentland, Harry" <Harry.Wentland@amd.com>, "Li, Sun peng (Leo)"
 <Sunpeng.Li@amd.com>, "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>, "Li,
 Roman" <Roman.Li@amd.com>, "Lin, Wayne" <Wayne.Lin@amd.com>, "Chung,
 ChiaHsuan (Tom)" <ChiaHsuan.Chung@amd.com>, "Zuo, Jerry" <Jerry.Zuo@amd.com>, 
 "Wu, Ray" <Ray.Wu@amd.com>, "Hung, Alex" <Alex.Hung@amd.com>, "Lin, Wayne"
 <Wayne.Lin@amd.com>
Subject: RE: [PATCH 00/10] DC Patches July 21, 2025
Thread-Topic: [PATCH 00/10] DC Patches July 21, 2025
Thread-Index: AQHb9VUYlK08JMAs1Uu4WI8jX9Ug77Q8nygQ
Date: Mon, 21 Jul 2025 13:41:32 +0000
Message-ID: <DS0PR12MB65349D3FE630B658C6C1EA1D9C5DA@DS0PR12MB6534.namprd12.prod.outlook.com>
References: <20250715065233.160043-1-Wayne.Lin@amd.com>
In-Reply-To: <20250715065233.160043-1-Wayne.Lin@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-07-21T13:39:55.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6534:EE_|CH2PR12MB4296:EE_
x-ms-office365-filtering-correlation-id: 1b16d5ff-bc1f-454e-17d4-08ddc85c4e09
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?CkutXhGSCAQs3z/DTpqZmXJouaVqmVQlK/6IuTkiBFl9PDDxTt23n1HYup?=
 =?iso-8859-1?Q?i0Fxmvo0tjwsmn6WucLfY2rblLZ/JdNP62mKi6t8FMKgKZ62aKZBUrQBgE?=
 =?iso-8859-1?Q?B+dsty1vqzOsruf3BsM7vKUy/GN+Qee4SKgPrXBjF0egC/kBPlFTJcZCE5?=
 =?iso-8859-1?Q?9e1/HHVPZD9gbBrGTQ9ntgGEbUNoWg3bQgkKPWoOXlC1WyycTKZS92L4l+?=
 =?iso-8859-1?Q?ux5fKLp+Y6PxubCk5aBtz0SJ6q3JjAPF9aCwZK47IJfG1T+5R06zefgdEA?=
 =?iso-8859-1?Q?ObIDwe9uqeUzdPycTCItlC+D5UYYSoQ3Dd1L5ANNC7IH+juxiP+mXVpTOE?=
 =?iso-8859-1?Q?oWLtk3a3xexROlnOgJuEc1qFCfMnP4UYu6oxogn0ziJqSl7MqknTtT7Los?=
 =?iso-8859-1?Q?VZG+E4wOrAvEMTCrWug1ctnn8oXgygPJXPbkCPXkTmKBVKz+f0BMkKjUmn?=
 =?iso-8859-1?Q?LzjG4noCZVRuNYDPMYZatVLrCJ6adtJxlTTw3LpkWp1H9oWfm8bUp2AJm6?=
 =?iso-8859-1?Q?uAH+bW4vEHjwOH0fRACgz2d6Jh/f+yW1IIs/MfUmgwAhpHTA+MTilqaJ7w?=
 =?iso-8859-1?Q?JZ2nURDf/H7HvBLlvUmjvz04BLK8rFNLwVHqZ43IZKNMBIHMY3kiaz7OBa?=
 =?iso-8859-1?Q?cLP7+/fSHr+rc4Wki9/Z20cANsFE7zcQ0xKiBzG0IR/dQQsHgu+xEgFyEG?=
 =?iso-8859-1?Q?94a3BwvTjiiLzuLohxOf4RGEa+GJ0Ujzve1aOr3URpk/vmFCPuVJZEBG8+?=
 =?iso-8859-1?Q?dKGDasxBjXJAwdlhwGzJr5lJwXGchDru/g+ntGJ8Ua6zBp6izMZSZTPwiR?=
 =?iso-8859-1?Q?jQAY92R7bL9dvi9AGtnAeYV5T5mENTr2tSNkM/GSI35Ets7KVZMOrHLA6H?=
 =?iso-8859-1?Q?y0r3dH/ATsLHj2pd+tmjNFiGf7BHzbkA2T6xkzKlnaLi2K3DEH1IaJLJUJ?=
 =?iso-8859-1?Q?7V2/DxYN4xY39m7yJXzXJDguuV2W91wMbBU1jQGtz/uHpot6wKp3sYKKJz?=
 =?iso-8859-1?Q?4aiN9f6g7lJREU5bnMVQKuEuavy7cLsJ1v/0pmorDwLHB55Y9KIGv1j6it?=
 =?iso-8859-1?Q?rTZQnYJ/SwDtUtdEpnSB4Ae24nWvjiCElUhsDeQTr2Szfcyph1hDmM9p+v?=
 =?iso-8859-1?Q?o0maDt9rRoNrfWnW4faqgbxTjOOHAHvcPYkikExUG7dqLtNzYGzNmO74Ty?=
 =?iso-8859-1?Q?wXeM9SH0PrVskUEMD9ItqWmRKA/F+FagyG7eO75K/V1YhNmGDZ/RzLLy3U?=
 =?iso-8859-1?Q?5iSp1vmUhnxEFOwIdo6RXIxJDKuUE72FLlNePDUmsSjvQjrq0UobkDOSW+?=
 =?iso-8859-1?Q?QRGCQGlwruEt18z4Gtr9laz7zEX6Z4gLlMsvF3+A9kl1T7sgecbr2hrdrX?=
 =?iso-8859-1?Q?jzswzmXGmLW1nVkd4QcyLYGy8iReT5tYF2FnQjr1QHFrWC2ZAAZau3EXk1?=
 =?iso-8859-1?Q?V69lgma7KZUopgkEtmYXtM2Na2pzIGYx77lWzvKcaJuNpy5VytrSBwi0kS?=
 =?iso-8859-1?Q?pKGq2fD8aZrpI1i5BVjMdDsWvRlW579zW3UFhF+/ngGw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6534.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?8NC9qfkjz/mgnZChvUzRX14VTjizeEOtWc3Bb7Dtt6SlOBnQF8EEZf+V6U?=
 =?iso-8859-1?Q?qfl/8lR/N4vJ1hfjkFCEDbpeRc0bmvoBDh49fKa93vptk9zBrAl4St29JU?=
 =?iso-8859-1?Q?esH5btYmsO9UhcoRKLDSEefyBxWoOL8rlWQF0Z8IVrnw0GWiQZftxtrcGI?=
 =?iso-8859-1?Q?8i2Ant9hjJwoygfWOqWNcbYV27Z3iBE/7Yqf8uaG2G9IN5SCqrbYGu+3kZ?=
 =?iso-8859-1?Q?L413fFUKnguad/8gii20FZIUYK3QBycex5gyR8qvpPBKoZiN6pMYupxTMW?=
 =?iso-8859-1?Q?+qSuPa7PnCGCwmFiGwBs/VlHXeeSg5mllq7HNGQgljMyiqwOD7MHW7DaZN?=
 =?iso-8859-1?Q?oIuyC6YSkLPJYKr0xamZL4d2UK+CVy/ChLUWCjfBnW8K+A/0DwZigs554Q?=
 =?iso-8859-1?Q?e2ssMEwOSmUERYaTyalbuQTlLv4PDEIXdM4FEBQeD73fSH6AsN46i4nYOF?=
 =?iso-8859-1?Q?ZXKgThUZOGVR2SDJv+TyQra9jNuQj5Xjc9xNnP9yMTEebRGpH1n4++E/3x?=
 =?iso-8859-1?Q?HIhnMndZNPC5Z5p1EXChBb5g0qebz1JT+suHG7j1+11tjdl8wWwPtNG8TK?=
 =?iso-8859-1?Q?RRVZj/UWxfaiD1kPB1M6GmAQOHXzrKHTyKbd8ZB1haQHZhA9pg42D/DhT7?=
 =?iso-8859-1?Q?4SNWB0udGkG6CHGE7Q0kHGtTpTKFFkWVCt95nSNXk5NKnl748GLAYc6Eu3?=
 =?iso-8859-1?Q?Uh4Sb1j0jU3WVnCC38fusu6/xR1zkeY9OggnXmZ+pDyXU1PKgLWDbkZhyD?=
 =?iso-8859-1?Q?gKisFieLvNglkJrMrATIj2eWp8enEKZ4jy+SLg53pEcOrU/GZyAP+FPKAl?=
 =?iso-8859-1?Q?bHAXwjX10T6eKrnhXjXaKWIMxHcdufKVZHwR6Lg0ACtlGgZ/FO7wQ80ZEW?=
 =?iso-8859-1?Q?VT0/4lq81nTkOL/6fBvgEF6Zz8K8Eby37W4fiACZmHBipDVPxCxW743FU0?=
 =?iso-8859-1?Q?mUmv10/ZzATFe3yk1hoManB/mb32CU6N9rHNEM+MHOwHFMFx+M2xAxquKr?=
 =?iso-8859-1?Q?z/6qJaaoHtCs1Y8vGRmusBAeodY90tUuS/4XOaXbqpxv4eTpPftKSf5E22?=
 =?iso-8859-1?Q?VamAeY15E+t0o7hILwFviImxlP4G9zJKD24oN85RYUXWsS66WZFUg0DPm1?=
 =?iso-8859-1?Q?CKMMIuXm0xRKoiHF8a32/UhJK8QkoqPayHuNCQ0yRLt2pSXIFMu0PpGQcy?=
 =?iso-8859-1?Q?OuwQtB2w8HEAVuipmdSjS9AIrNXamUNDY9YroUdboJov6ksN05DvcW0z8P?=
 =?iso-8859-1?Q?gXN3sJ1AJ3hC5/prWQ2BDJ84vsEdpskXUzEf2EwsnqziTVQNOpnrFZlQdr?=
 =?iso-8859-1?Q?Itd50urWNFSqkmlWL6QM4xNhNoSC+mOuO+DaVQYItVs92X6n/kUWp91L/D?=
 =?iso-8859-1?Q?1pA1rgtGSifFtwl64onW8p7+0RH9P2BYOgeKGSzzxG7n3PkTYrvO2K3fO6?=
 =?iso-8859-1?Q?XeCfqn365N50p8nKrvPTvsEeL5iBAi2+/HvanA2x7n6v0XF6HCVyUxCC1l?=
 =?iso-8859-1?Q?XRJl2biqxuWiZ8koa7N6WDSldUbk3LQXIZi6r+EJGMck5j63I0hFZVAAAn?=
 =?iso-8859-1?Q?nGJqVcRiISQNMgtEA3pSJsxAVfpJuIaXCYZHLs3UpE238DBWWByHbCOgoM?=
 =?iso-8859-1?Q?WLb/+ajNsbnp4=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6534.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b16d5ff-bc1f-454e-17d4-08ddc85c4e09
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2025 13:41:32.7933 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SMs2fPROmJN4K/FHeDDcnZ7vXwtlNpNlritpPCNWXKKfTvPBDCRtTMtrs47e7XPjk+WDppbQMBM40fJWuo8faw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4296
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

Hi all,

This week this patchset was tested on 4 systems, two dGPU and two APU based=
, and tested across multiple display and connection types.

APU
        * Single Display eDP -> 1080p 60hz, 1920x1200 165hz
        * Single Display DP (SST DSC) -> 4k144hz, 4k240hz
        * Multi display -> eDP + DP/HDMI/USB-C -> 1080p 60hz eDP + 4k 144hz=
, 4k 240hz (Includes USB-C to DP/HDMI adapters)
        * Thunderbolt -> LG Ultrafine 5k
        * MST DSC -> Cable Matters 101075 (DP to 3x DP) with 3x 4k60hz disp=
lays, HP Hook G2 with 2x 4k60hz displays
        * USB 4 -> HP Hook G4, Lenovo Thunderbolt Dock, both with 2x 4k60hz=
 DP and 1x 4k60hz HDMI displays
        * SST PCON -> Club3D CAC-1085 + 1x 4k 144hz, FRL3, at a max resolut=
ion supported by the dongle of 4k 120hz YUV420 12bpc.
        * MST PCON -> 1x 4k 144hz, FRL3, at a max resolution supported by t=
he adapter of 4k 120hz RGB 8bpc.

DGPU
        * Single Display DP (SST DSC) -> 4k144hz, 4k240hz
        * Multiple Display DP -> 4k240hz + 4k144hz
        * MST (Startech MST14DP123DP [DP to 3x DP] and 2x 4k 60hz displays)
        * MST DSC (with Cable Matters 101075 [DP to 3x DP] with 3x 4k60hz d=
isplays)

The testing is a mix of automated and manual tests. Manual testing includes=
 (but is not limited to)
        * Changing display configurations and settings
        * Video/Audio playback
        * Benchmark testing
        * Suspend/Resume testing
        * Feature testing (Freesync, HDCP, etc.)

Automated testing includes (but is not limited to)
        * Script testing (scripts to automate some of the manual checks)
        * IGT testing

The testing is mainly tested on the following displays, but occasionally th=
ere are tests with other displays
        * Samsung G8 Neo 4k240hz
        * Samsung QN55QN95B 4k 120hz
        * Acer XV322QKKV 4k144hz
        * HP U27 4k Wireless 4k60hz
        * LG 27UD58B 4k60hz
        * LG 32UN650WA 4k60hz
        * LG Ultrafine 5k 5k60hz
        * AU Optronics B140HAN01.1 1080p 60hz eDP
        * AU Optronics B160UAN01.J 1920x1200 165hz eDP

The patchset consists of the amd-staging-drm-next branch (Head commit - bf6=
96978aa0c9c601b38dd48e37b34dc1c2edcfa -> drm/amd/display: Disable CRTC dega=
mma LUT for DCN401) with new patches added on top of it.

Tested on Ubuntu 24.04.3, on Wayland and X11, using KDE Plasma and Gnome.

Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>



Thank you,

Dan Wheeler
Sr. Technologist | AMD
SW Display
---------------------------------------------------------------------------=
---------------------------------------
1 Commerce Valley Dr E, Thornhill, ON L3T 7X6
amd.com

Thank you,

Dan Wheeler
Sr. Technologist  |  AMD
SW Display
---------------------------------------------------------------------------=
---------------------------------------
1 Commerce Valley Dr E, Thornhill, ON L3T 7X6
Facebook |  Twitter |  amd.com


-----Original Message-----
From: waynelin <Wayne.Lin@amd.com>
Sent: Tuesday, July 15, 2025 2:49 AM
To: amd-gfx@lists.freedesktop.org
Cc: Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo) <Sunpeng.L=
i@amd.com>; Pillai, Aurabindo <Aurabindo.Pillai@amd.com>; Li, Roman <Roman.=
Li@amd.com>; Lin, Wayne <Wayne.Lin@amd.com>; Chung, ChiaHsuan (Tom) <ChiaHs=
uan.Chung@amd.com>; Zuo, Jerry <Jerry.Zuo@amd.com>; Wheeler, Daniel <Daniel=
.Wheeler@amd.com>; Wu, Ray <Ray.Wu@amd.com>; Hung, Alex <Alex.Hung@amd.com>=
; Lin, Wayne <Wayne.Lin@amd.com>
Subject: [PATCH 00/10] DC Patches July 21, 2025

This DC patchset brings improvements in multiple areas. In summary, we high=
light:
- Fix divide by zero when calculating min ODM factor
- Ensure committing streams is seamless when transitioning between topologi=
es
- Fix condition for setting timing_adjust_pending
- Update DMUB tiled to tiled copy command

---
Aurabindo Pillai (1):
  drm/amd/display: fix condition for setting timing_adjust_pending

Clay King (1):
  drm/amd/display: ensure committing streams is seamless

Dillon Varone (1):
  drm/amd/display: Fix divide by zero when calculating min ODM factor

Gabe Teeger (1):
  drm/amd/display: Revert Add HPO encoder support to Replay

Mario Limonciello (1):
  drm/amd/display: Drop unnecessary 'rc' variable in
    amdgpu_dm_backlight_get_level()

Ostrowski Rafal (1):
  drm/amd/display: Update tiled to tiled copy command

Taimur Hassan (4):
  drm/amd/display: [FW Promotion] Release 0.1.18.0
  drm/amd/display: Promote DAL to 3.2.341
  drm/amd/display: [FW Promotion] Release 0.1.19.0
  drm/amd/display: Promote DAL to 3.2.342

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  4 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 16 +++-
 drivers/gpu/drm/amd/display/dc/dc.h           |  2 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  |  4 +-  .../gpu/drm/amd/dis=
play/dc/dce/dmub_replay.c  | 43 +----------  .../gpu/drm/amd/display/dc/dce=
/dmub_replay.h  |  2 +-
 drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c   | 29 +++----
 .../link/protocols/link_edp_panel_control.c   |  2 +-
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 75 ++++++++++++++-----
 9 files changed, 95 insertions(+), 82 deletions(-)

--
2.43.0

