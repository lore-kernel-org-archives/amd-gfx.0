Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 461AAC282DE
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Mar 2025 13:33:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C2BF510E43A;
	Mon, 10 Mar 2025 13:33:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BQdzOYmp";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2066.outbound.protection.outlook.com [40.107.92.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A53BA10E43A
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Mar 2025 13:33:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wmvKMnkX5oAd9olKlLxdj6JcJdz4M36lg2cPs9giRsZ91dO9zVwdSNNui3+G0jg4BOhucw4AENhDOv1tgL+NK2wTx650WWt8eSuytHLgGOghMUwcNty+3dfASvbHT4qumuRqSWpclJjYrByYE7DYqWlacgE4JlTjzWERfcy/srF+UNvjvnOFnUSzvtAh/xkJjcM+KP5/ySrOvfEaeZIzDphf3iinMJa8vwtukPyu93VqjzO1XAhdX71ySIuTdzGUQqwyErv+11duRz3ummT58a41HcMmN+8skgZf8j2wF3wVTizRb9kFuKNAU1KI6hWh0Ouxup8xnbBnluHC9A4h8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LfSeWjcOpjLR0HMg+hFsJDZb2sAIXW8i0K8teiIl1gg=;
 b=eMmX+irKuy5hjpH05IfQrncMUO7yr77GA0hvxhHXPpb7iwPiwkFHzPz/WIywR83SDLLKrKf+6cPwzLV1JQvkNqBymt5jn4aqGo7lDL6ejJfue9gqj7jhxlrY1hUBJKrgq7Ki7f1cf+6xc2z1TKY7B1yQfT9OsSTYkuU9T13BgDL3ESYWJj5YaPNBDdzJV2ff3kg4G6v+C8HCK94WVlZw5BuYvB64RyBlwchphWgeNEO3S4l+hdLzfO9QNwF/LOArIjGEGQcd37yTeJL0HMVNK0ctBdUovCnzm3coptFsGIhobcX2Z7YTKjtMmmD9ryR2GkAD4gynM4cwz3IpApd4SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LfSeWjcOpjLR0HMg+hFsJDZb2sAIXW8i0K8teiIl1gg=;
 b=BQdzOYmp1nQ172X5JEpH7BF8hhVN3Zs40y99NCw7zUnVvx2wAO88/rQdUtorf1T8UPlbCjcZabuLJLoLisSm3QSzz1tO7XgZTBgb7MTz3p4pi16svmbGTCYoADQu3gf9cc+VbxRJDq7Sy+xUQSPB2zg4TSvYgLYpq6hCkDD5XaU=
Received: from DS0PR12MB6534.namprd12.prod.outlook.com (2603:10b6:8:c1::19) by
 CH0PR12MB8507.namprd12.prod.outlook.com (2603:10b6:610:189::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.27; Mon, 10 Mar 2025 13:33:33 +0000
Received: from DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::ea87:74ba:36ec:8cf6]) by DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::ea87:74ba:36ec:8cf6%2]) with mapi id 15.20.8511.026; Mon, 10 Mar 2025
 13:33:33 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Chung, ChiaHsuan (Tom)" <ChiaHsuan.Chung@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Wentland, Harry" <Harry.Wentland@amd.com>, "Li, Sun peng (Leo)"
 <Sunpeng.Li@amd.com>, "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>, "Li,
 Roman" <Roman.Li@amd.com>, "Lin, Wayne" <Wayne.Lin@amd.com>, "Chung,
 ChiaHsuan (Tom)" <ChiaHsuan.Chung@amd.com>, "Zuo, Jerry" <Jerry.Zuo@amd.com>, 
 "Mohamed, Zaeem" <Zaeem.Mohamed@amd.com>, "Chiu, Solomon"
 <Solomon.Chiu@amd.com>, "Hung, Alex" <Alex.Hung@amd.com>
Subject: RE: [PATCH 00/22] DC Patches Mar 10 2025
Thread-Topic: [PATCH 00/22] DC Patches Mar 10 2025
Thread-Index: AQHbjY10O2KZxQv/OESnoyWYsqmbsLNsZiNA
Date: Mon, 10 Mar 2025 13:33:33 +0000
Message-ID: <DS0PR12MB65348598CC261061FE2842869CD62@DS0PR12MB6534.namprd12.prod.outlook.com>
References: <20250305051402.1550046-1-chiahsuan.chung@amd.com>
In-Reply-To: <20250305051402.1550046-1-chiahsuan.chung@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=49de0e1c-8ffe-4c43-835c-7e1b9ad70579;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-03-10T13:32:12Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Tag=10, 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6534:EE_|CH0PR12MB8507:EE_
x-ms-office365-filtering-correlation-id: c963ff41-5d5d-43d2-2045-08dd5fd8272d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?0or5npL4/WSpj3V4jWgQfYb5fQ05WLa4f1WZ4I0eO77J7h/3aS8fPQGAf5Df?=
 =?us-ascii?Q?/S1I72yatuJh1TRT04IXicgqZJWB4KpyyqZ3jFEL0t12IO6qYffan0H7PSyt?=
 =?us-ascii?Q?xXTJ44coL9P14NjXpDgKgLAhlt/ltl+8emiy5W/Zc5iuVe2IgA+Lxdxt614M?=
 =?us-ascii?Q?/x4X5y7Ak6fjxeL9tB5v284C32/84btPDlGxh9NQCcbKvmON+IBRpZCtCbFB?=
 =?us-ascii?Q?FS5O8EqWavvpXQrRuq9cwrfulDAnF/vBAztJvHYLN3R7BHr0V9deeNEJS/1S?=
 =?us-ascii?Q?eNtYDzjTkj4MFqlqd3Gu4tvY2B1mhP2ITkVd02KKitsrmj7ZWiUZcmZ59qUa?=
 =?us-ascii?Q?Z9K510FLTb/1A0ya8LPwnjClnCu24VVO08C+J+SAIcUia4EN7zTmNmFh03jJ?=
 =?us-ascii?Q?oc6T9QArTKQyH9U9jC1aqoTLE4xeoku6YuWjTEj1A03Didohdy/xdeFDiH0y?=
 =?us-ascii?Q?kQW7gigEi9R840FYQGLxJ+hDMN8UmDEEt9I32Wj7eED+gnXGNzasCbeXHDU7?=
 =?us-ascii?Q?oWoPUzfi1eMJ5ctrLI+AunGMjCzUYWyAZbDZ/+wtrwufdT1wFuRZcHXPyNTb?=
 =?us-ascii?Q?7udEWRDyLlrrnPzKThBOtoWrxFXnAO++gawhnPYRRsVkmNbc6ZlxkENH0wG8?=
 =?us-ascii?Q?x6ruYqFVlaN9SHoYA3rKcgkWqv1N2z4a5RiRYUR4wnzoLIhvAA88Gwcpo6Ya?=
 =?us-ascii?Q?gQMlvmiQd2bQrVgyabbbouQJhvYBKYzlTZ/W7bHQznZnhH43R4eLlaowV0dE?=
 =?us-ascii?Q?Kl+8nwMP5QoLupPfHXiVq8dsIo6wfNhFtkAD6z/mZwDTO6o6YyZ40lfpLFFb?=
 =?us-ascii?Q?sXelPTquTsUPH4H2n7/JLaP9yR/YOQCuBs4hEmUXoTMX/iJux+9mOJ15MzG+?=
 =?us-ascii?Q?FaYZ03AxUNw1SBZAYXRegcGATpsPrn3zNz6Gl0tJdqyhQGk75T3Gdxm1ULdi?=
 =?us-ascii?Q?oPTEasJ4l25Kj7B1KmpANKZUOB8PKEvYTYYTdB4G4I0ZFTAkpo93SBjMApHw?=
 =?us-ascii?Q?ilTe/b1TXFqhlbPCVCv7FnFmsc2lbMER2Yhkrvnvj56BzjrwkZFMPEx4ZEnO?=
 =?us-ascii?Q?nX5mEmgkq18Sh1ciuVdDFdEhdiSXg/XIvI7RYJUbEyLrQ50hLMt0/IA9bDCA?=
 =?us-ascii?Q?ofb9mTTlWtv3jSb3+c00wHiHFHD47zvNxNH2rrwzK/hD5meaowSMyNlz9IGZ?=
 =?us-ascii?Q?aptewEJ6LmVmz0x5rCNE+k5nSw+oy1NTqqx1OqR6YaEjk9HcmpH+UBbjSzYs?=
 =?us-ascii?Q?tVLdH/cU5dHXnrI/qc0ixuKIoyR867Eo1qvgyMVQ9f1ys1gqAp8889BVXrBL?=
 =?us-ascii?Q?KYB/z5guHnzqsIr6KMNGuCU1yim6C9PM1XBEamgzr1h2cy02qeiDuWtrvTbR?=
 =?us-ascii?Q?EDFOG6oFzNz6rK0zpRseJLBzgyc16q1ZOWc70hCLD2xpIXYu3gRbEayPJEgr?=
 =?us-ascii?Q?xbaIy6oCGLqb/sfSMZ/xW/4ljGmkUJ53?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6534.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GwpLEGRbLeYDX/GFIq/hjN0T4xDTZ7atv1hX5t1qhtCwbw/u2Ixf0qD2x9N1?=
 =?us-ascii?Q?9TAKD0ut+v2hXWt60gIAFxB1bb0YBUo0nkum34C7d3bc9x3nnijxcA/TsgG4?=
 =?us-ascii?Q?MABQmk3Ygf0iar1in7pfPtEFX42yTYk4veHZ22vdN1V6fU5rwxMZiex/5ju0?=
 =?us-ascii?Q?zM0C8AKVaZP0ujc+IlstXoxITrZFhTJC0Mz6qQED2DcsabSGrc8x13gUhCMb?=
 =?us-ascii?Q?jhwhoWncLQ8SH+ypWt3ODd67IM/gsKXu/5O63TIBZZi721Lo78fXBc3u2TuP?=
 =?us-ascii?Q?FToqKctjxVHSka6FMiGYJdVO2rL/jErFXdIjGP3zN+FLSzXWLolVoTQYik8x?=
 =?us-ascii?Q?XspUof2VPZzdRpGh3hdiHlSnvHP//TPFN0giFRD2sK/6yFbcIeCIfieaQiJ2?=
 =?us-ascii?Q?V+fhR9Yzvvqx5jh/4jQ9f4rfK7bZCnifmjDkrrdv22BpkzlMQ+2pck+gBlTo?=
 =?us-ascii?Q?xXgmZk822t7dtRN5G9WEu/ilF3AoTDhESBurV0ngqx0URthNnsQvQZTidsG6?=
 =?us-ascii?Q?pxx/Ju/13S/lXh+NDcJqfBhzaGmD83GL6hYUcOqqWyUVtC5+KdJMHUUkIdBg?=
 =?us-ascii?Q?JHqbVfQVMPXxpR58irhbAsDP82lJOrc+nvqTTWFynBNFE6FOCE0nQkqeNk80?=
 =?us-ascii?Q?b5Ak82v9VtG6pZs365D7D//gB10pN6iJg7PHM8hLncGyRjL1d7ICOzcJeOBR?=
 =?us-ascii?Q?VgU5Rk6/zaKY+ls2PY/J8JcoD6H9qDSZLjJqQO4IHufpIiPvyWo1hrhsWPQ7?=
 =?us-ascii?Q?ZbQhjweGjv6llPQ6Rm5ZIfpWe4DbyisoW9oJg7NT7E2HoLZ+RNZaM2qRXwkh?=
 =?us-ascii?Q?y0ZmqzvJmz86Ge0KqxJTEb6c2RFj6wjdn6yiXvX7FKghvj4Xob3lTdfhXh2H?=
 =?us-ascii?Q?Qhr0CS1o0lAcQ58tHKLemk123hkH9dV0dGdG9M5FjQqvuuEyZ57VUeh5melL?=
 =?us-ascii?Q?Fa3pdsA/KqgSbRFaqf3OGB2HGMp/j09mOsH/cqP13F24hxbQZJVUBG94tESW?=
 =?us-ascii?Q?Y/X1kK9bXfC9UFGlFjyvYlv5Iy0xrEAFjw+BaFM50fS0R3uKeWSHO/HUXN0d?=
 =?us-ascii?Q?0a9Djy+o9nBOVCeGZV9wz2imQ1IaseaxKCLaw27bmB8walnuWKU8Fe7aT6M2?=
 =?us-ascii?Q?Fb4ZzK+rmva6aiNvOrqjxUqB7I3yRuwjkKXcsyofQjmVZ8iPHC2oDdlOYKJe?=
 =?us-ascii?Q?ANDBbC6KNjRRo1mvUWtnxcde668VE0tup55eghcImhd9YdmvggRXWI3Eklbm?=
 =?us-ascii?Q?+nt66gIfjTV5OGpldTLcgUzFlpLrqtHqTwXaZAiG23uHNwckvAr/Q+hEPWyD?=
 =?us-ascii?Q?KnCfadw7TUqXEbJEBFr712j3MJpKSiZwo4CZZPlC5dfFT/x6HM/hsRgXhcdK?=
 =?us-ascii?Q?RtLrJSVAlJRKkMRaSdwa4S02TarUAsnueKHOjTo2yTEeYAN47uQ2JlOxaSjm?=
 =?us-ascii?Q?dgqnpaDhdNXJH97BXCq+lah05TNmKGMy5krN9DAxmFq6WnWnlr8fdOq1XOLe?=
 =?us-ascii?Q?MVPtEdlpQbLPZMnN0KlfivCN4K36NvnHOtWJ36ELZDnydv6OjKwbD2b0ZbT+?=
 =?us-ascii?Q?/deGi8hUp6O/ZtHhJLA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6534.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c963ff41-5d5d-43d2-2045-08dd5fd8272d
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2025 13:33:33.0775 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +mDxXprSDRgG9089HSNytl2Qwv044SgQln5feUhrpl8S0DFyYwMmUU+oWbNuqkdsGtDDPuzHnFO3Ga0iRT6SYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8507
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
        * Single Display eDP -> 1080p 60hz, 2560x1600 120hz, 1920x1200 165h=
z
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
        * AU Optronics B160QAN02.L 2560x1600 120hz eDP

The patchset consists of the amd-staging-drm-next branch (Head commit - 51c=
f6a0ec03e66081e2889644f248acab0965430 -> drm/amd/display: Promote DAL to 3.=
2.323) with new patches added on top of it.

Tested on Ubuntu 24.04.1, on Wayland and X11, using KDE Plasma and Gnome.

Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>



Thank you,

Dan Wheeler
Sr. Technologist | AMD
SW Display
---------------------------------------------------------------------------=
---------------------------------------
1 Commerce Valley Dr E, Thornhill, ON L3T 7X6
amd.com



-----Original Message-----
From: Tom Chung <chiahsuan.chung@amd.com>
Sent: Wednesday, March 5, 2025 12:14 AM
To: amd-gfx@lists.freedesktop.org
Cc: Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo) <Sunpeng.L=
i@amd.com>; Pillai, Aurabindo <Aurabindo.Pillai@amd.com>; Li, Roman <Roman.=
Li@amd.com>; Lin, Wayne <Wayne.Lin@amd.com>; Chung, ChiaHsuan (Tom) <ChiaHs=
uan.Chung@amd.com>; Zuo, Jerry <Jerry.Zuo@amd.com>; Mohamed, Zaeem <Zaeem.M=
ohamed@amd.com>; Chiu, Solomon <Solomon.Chiu@amd.com>; Wheeler, Daniel <Dan=
iel.Wheeler@amd.com>; Hung, Alex <Alex.Hung@amd.com>
Subject: [PATCH 00/22] DC Patches Mar 10 2025

This DC patchset brings improvements in multiple areas. In summary, we high=
light:

- Fix some Replay/PSR issue
- Fix backlight brightness
- Fix suspend issue
- Fix visual confirm color
- Add scoped mutexes for amdgpu_dm_dhcp

Cc: Daniel Wheeler <daniel.wheeler@amd.com>

Alex Hung (1):
  drm/amd/display: Assign normalized_pix_clk when color depth =3D 14

Charlene Liu (3):
  drm/amd/display: assume VBIOS supports DSC as default
  drm/amd/display: dml2 soc dscclk use DPM table clk setting.
  drm/amd/display: remove minimum Dispclk and apply oem panel timing.

Danny Wang (1):
  drm/amd/display: Do not enable replay when vtotal update is pending.

Dillon Varone (1):
  drm/amd/display: Add Support for reg inbox0 for host->DMUB CMDs

George Shen (1):
  drm/amd/display: Implement PCON regulated autonomous mode handling

Joshua Aberback (1):
  drm/amd/display: Add more debug data to dmub_srv

Leo Li (1):
  drm/amd/display: Disable unneeded hpd interrupts during dm_init

Leo Zeng (1):
  drm/amd/display: Fix visual confirm color not updating

Leon Huang (1):
  drm/amd/display: Fix incorrect DPCD configs while Replay/PSR switch

Mario Limonciello (6):
  drm/amd/display: fix default brightness
  drm/amd/display: Restore correct backlight brightness after a GPU
    reset
  drm/amd/display: Add and use new dm_prepare_suspend() callback
  drm/amd/display: Fix slab-use-after-free on hdcp_work
  drm/amd/display: Add scoped mutexes for amdgpu_dm_dhcp
  drm/amd/display: Drop unnecessary ret variable for enable_assr()

Peichen Huang (1):
  drm/amd/display: not abort link train when bw is low

Ryan Seto (1):
  drm/amd/display: Prevent VStartup Overflow

Taimur Hassan (1):
  drm/amd/display: Promote DAL to 3.2.324

Zhikai Zhai (1):
  drm/amd/display: calculate the remain segments for all pipes

Zhongwei Zhang (1):
  drm/amd/display: Correct timing_adjust_pending flag setting.

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  37 ++-
 .../amd/display/amdgpu_dm/amdgpu_dm_hdcp.c    |  43 +--
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c |  64 ++--
 .../dc/clk_mgr/dcn315/dcn315_clk_mgr.c        |   2 -
 .../dc/clk_mgr/dcn316/dcn316_clk_mgr.c        |   2 -
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  10 +-
 .../drm/amd/display/dc/core/dc_hw_sequencer.c |  24 +-
 .../gpu/drm/amd/display/dc/core/dc_resource.c |   7 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |   2 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  | 272 ++++++++--------
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h  |   4 +-
 drivers/gpu/drm/amd/display/dc/dc_dp_types.h  |  27 +-
 drivers/gpu/drm/amd/display/dc/dc_helper.c    |   2 +-
 drivers/gpu/drm/amd/display/dc/dc_hw_types.h  |   1 +
 .../gpu/drm/amd/display/dc/dce/dmub_abm_lcd.c |   3 +-
 .../gpu/drm/amd/display/dc/dce/dmub_replay.c  |  19 +-
 .../src/dml2_core/dml2_core_dcn4_calcs.c      |   2 +
 .../display/dc/dml2/dml2_translation_helper.c |   2 +-
 .../amd/display/dc/hwss/dce110/dce110_hwseq.c |  17 +-
 .../amd/display/dc/hwss/dcn10/dcn10_hwseq.c   |   7 +-
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   |   8 +-
 .../amd/display/dc/hwss/dcn31/dcn31_hwseq.c   |   4 +-
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   |   3 +-
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c |  10 +-
 .../drm/amd/display/dc/hwss/hw_sequencer.h    |   6 +
 .../dc/link/protocols/link_dp_capability.c    |  55 +++-
 .../display/dc/link/protocols/link_dp_dpia.c  |   1 +
 .../dc/link/protocols/link_dp_training.c      |   5 +-
 .../link/protocols/link_edp_panel_control.c   |  25 +-
 .../dc/resource/dcn315/dcn315_resource.c      |  42 ++-
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h   | 143 +++++---
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |  49 ++-
 .../gpu/drm/amd/display/dmub/src/dmub_dcn20.c |  85 ++---
 .../gpu/drm/amd/display/dmub/src/dmub_dcn20.h |   2 +-
 .../gpu/drm/amd/display/dmub/src/dmub_dcn31.c |  93 +++---
 .../gpu/drm/amd/display/dmub/src/dmub_dcn31.h |   2 +-
 .../gpu/drm/amd/display/dmub/src/dmub_dcn32.c |  98 +++---
 .../gpu/drm/amd/display/dmub/src/dmub_dcn32.h |   2 +-
 .../gpu/drm/amd/display/dmub/src/dmub_dcn35.c |  93 +++---
 .../gpu/drm/amd/display/dmub/src/dmub_dcn35.h |   2 +-
 .../drm/amd/display/dmub/src/dmub_dcn401.c    | 218 ++++++++-----
 .../drm/amd/display/dmub/src/dmub_dcn401.h    |   6 +-
 .../gpu/drm/amd/display/dmub/src/dmub_srv.c   | 308 ++++++++++++------
 43 files changed, 1111 insertions(+), 696 deletions(-)

--
2.34.1

