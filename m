Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41414CCD192
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Oct 2025 13:25:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA49110E60B;
	Tue, 14 Oct 2025 13:25:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TPfD2Vk9";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012034.outbound.protection.outlook.com [52.101.53.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EBC5A10E60B
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Oct 2025 13:25:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cOEkXbPRolbqWh2gf8qa/9oFdP45MpKYHi5WUSFkXqatq93zJLDl6pop9oSxMj4f9AC1FtxqQGygX+CVURajtOBP8IJnLY0bm0vg8ljH86VNJZ6gAavd77aC7MoW6NCzzLhk+iwSKZrPw9jqmRY7+sQEZ+gagwVtn/Ggt/lLMe/T59KVI09UoZOUj7QmeHwPR/s6dsmobJC+NepTlfarl/lJI8DIQE41iZyrvNGtWxgYY9tW7kQln8gd4epBGdC1oRABh+PcpfXesoRIPxn9ejs/hfj218sWTKGjN6BUKlI5glSGAuv0rMN4q1iy1DrIaLU88DnthRcXs5U8O02iIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CZciPj3xCXiE9GdLCWRvscb6bA8niSu8w8mZqcOnbmU=;
 b=FJ/MZS+thfQsysdkayJMA7dIbUh924XbL6zx2GDh9XcGiXRZrtlph4a7RM/oYWi1Zu3tUSMwmFuxCVQakdBwYOlNhk8mADnzWtjixyUaSq2Ta8RlPESclvynFBEm/5u1ARW65+2GFdWzKR895ib2gb4SAsE5Hs1h3Ot9wPojHrXwGd4pmFd6cdsFReLYKqHTGeUqfg7Ip2/wv+ihAh3KeZgDJJrRQXywB84F0d/md97ug6P5iZ5he4mgZn4eyd7d0gDqDb1pu2+Ho+4LpVvK4Xv1JURiFfXU1Rbj8k2fIYPvpm1ZZq7V+fzkjq80YTr1aG7s4Sg0ORVGfYUHFty/zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CZciPj3xCXiE9GdLCWRvscb6bA8niSu8w8mZqcOnbmU=;
 b=TPfD2Vk9XG5UenTUtzQnVSaph2MPpkwpWC6zhdf3tu5BQZCLwtiTCmZ2pIWpvG/MgPbfXzvHZ2PhuqO7QYDgfCbtRJ+9Cqs2ZoG8nwqv/trViyV7koXbEQTHxxT4H7edUzzZJ9Y0Uq4qyXVzZeLOx8NM3JPcXLxCftvqsutBynQ=
Received: from DS0PR12MB6534.namprd12.prod.outlook.com (2603:10b6:8:c1::19) by
 CY8PR12MB8409.namprd12.prod.outlook.com (2603:10b6:930:7f::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.13; Tue, 14 Oct 2025 13:25:37 +0000
Received: from DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::ea87:74ba:36ec:8cf6]) by DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::ea87:74ba:36ec:8cf6%7]) with mapi id 15.20.9203.009; Tue, 14 Oct 2025
 13:25:37 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Wentland, Harry" <Harry.Wentland@amd.com>, "Li, Sun peng (Leo)"
 <Sunpeng.Li@amd.com>, "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>, "Li,
 Roman" <Roman.Li@amd.com>, "Lin, Wayne" <Wayne.Lin@amd.com>, "Chung,
 ChiaHsuan (Tom)" <ChiaHsuan.Chung@amd.com>, "Zuo, Jerry" <Jerry.Zuo@amd.com>, 
 "Wu, Ray" <Ray.Wu@amd.com>, "LIPSKI, IVAN" <IVAN.LIPSKI@amd.com>, "Hung,
 Alex" <Alex.Hung@amd.com>
Subject: RE: [PATCH 00/22] DC Patches for 13 Oct 2025
Thread-Topic: [PATCH 00/22] DC Patches for 13 Oct 2025
Thread-Index: AQHcOIQszPAQYt1WF0uzqi5nTv6BeLTBqnjA
Date: Tue, 14 Oct 2025 13:25:37 +0000
Message-ID: <DS0PR12MB6534330F3CB633D74D61B9FF9CEBA@DS0PR12MB6534.namprd12.prod.outlook.com>
References: <20251008184839.78916-1-aurabindo.pillai@amd.com>
In-Reply-To: <20251008184839.78916-1-aurabindo.pillai@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-10-14T13:24:07.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6534:EE_|CY8PR12MB8409:EE_
x-ms-office365-filtering-correlation-id: 37837f47-1aff-4fa1-7524-08de0b252981
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?WeQwWyeL8D86ctg0TSRV6DvU0uw/MjvHuIDJ38fVuDKVNT9ZOeDK+fKSqkMp?=
 =?us-ascii?Q?Kom0RJWQLs0Ja0kUEqnhkWVPjatiym553jYkkor9Bb5Xg+S/jzeVeSaYS/cv?=
 =?us-ascii?Q?zIlLziGLVPEQ2fgVOdFzY8pIssoeG9BmxkxQC/HklIkdTY76uMCOkxpvi5rU?=
 =?us-ascii?Q?35keECko95EYNHHMsXhmIO03w1nYASsZVxbTDGqMU7UYN0RHECzcG+GT4kGN?=
 =?us-ascii?Q?dWx6droWcMMoELMMQ72dkBanDlqOxDedZ8fposNdQ4qegpsRP7ix2ReCzFrw?=
 =?us-ascii?Q?jxxlIt7rnC8RJ3bG7rUbbBjnGCYVHe3G/xGwNovfd21CU8qTiNs6X1FrkD1e?=
 =?us-ascii?Q?t2j76fncWgK6XxJvN0AmqlFf9RfwaDIuoa3v6gihKm6rfhRnDtLpKM75nTPS?=
 =?us-ascii?Q?0HAFK9arjaQGG5H52+knnmjpNri9f1iUsoY1cxApcV4bwwwUw6tKUdPncuIS?=
 =?us-ascii?Q?97OC+juKkp+xJYpGsb+mZvF0FBlnznGEHDyRe5IvBfd7eSmP3IZbu68wXS+j?=
 =?us-ascii?Q?vUyVJzvavVzLCn903ARKWbPP4sAnyGmV2KDTIiNf2ot1Bd5AlJHGboAYl37n?=
 =?us-ascii?Q?s0Xmht7Mo1M4wXPsczc1YMx41UDbauJ5ERK5WFuRfZwA/gybg65AGMLOMKj9?=
 =?us-ascii?Q?rWbIKVwI8oM5BLsQa93ItlcyAqbIdY98ulpGf0HxxmKeHswW3LvJaRhUiFN1?=
 =?us-ascii?Q?opgVsdOhsAubIHtaJhtOFjJUBwOPgXwSAHiAQq7jUiXt7zyqDoxXil7J6Fa1?=
 =?us-ascii?Q?PPgzGIa9oKGNIGvG9R0JFsR1ebK+xj2OmB2VknRdp7lvfB7v5e7a5QDy7FQY?=
 =?us-ascii?Q?QbEdjSk/ne3PEaZYKVmeMNawbQmGrH0ON6Cn2gsn64FedbolKSB6GXmF4cyb?=
 =?us-ascii?Q?y1EZyu9uchKtg92cabeu5GPlxIfKRgkmE+JR6Ew0pHwMurgTvfl17xsJ9XJM?=
 =?us-ascii?Q?3oyvZbEIr/lm0iSX+yPby4lBc6U/MUvy6KlPBchgitNgbub7qXEEgqI39E1t?=
 =?us-ascii?Q?nE1uz6l3el0QVuDOJQAQeKs9xFrcVt7Moavs07MKhs4zUikmXxOPdzVTj+LG?=
 =?us-ascii?Q?9prgfcJ02x8qJu0LnJWD9rtD7VA+M1GN9N33wn+PdJaom8b59ByFyPCMX6MI?=
 =?us-ascii?Q?9zNZGbDLhb2yyTjB9YrS9oLN9xXXwus9XtnuszHH4MFa8eCi7VCJjX2VcvX/?=
 =?us-ascii?Q?tZcDQDp8Q2jqjIOBKu4Ixh39lPnRxZrHUgfmQVvnjjewuNFGPtCcMls/QJaO?=
 =?us-ascii?Q?PQoavrkTZj0mCt3Y7zXjtBNASjRTP/QZG4dbw01irlp+BURr7kG4wfzOp5BT?=
 =?us-ascii?Q?TuVYX1iVjh36J1sls1l+x+j1HPf11V1qZoTuVvjXqVWTXK0dkOYhe2rOUY1z?=
 =?us-ascii?Q?Tjbwg0ecG2WKeE6A6agOP0BTw+R7lJ384W+FfbADEdBsFYChOv7c0U527xqe?=
 =?us-ascii?Q?14RHfMGT8AqfiPwuwgRnMkUCatU7PgpF6H8zOE2QTff69y2z3VibSzglS5rm?=
 =?us-ascii?Q?xLIHUlyDAabh/SVh2AigAq8gsy+HL/ayrQ54?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6534.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Vsf5CfJBSuPl1h+/SaA+loptWBtGfsQ7EOATmgnHhQu4yGXyIwVt/NbHk18O?=
 =?us-ascii?Q?jnoHmm2/xEYrFufpg8fMbI7xP8X1VvJnYdkAovhziyHPlA415ezAS5OnYETn?=
 =?us-ascii?Q?iWjtd65uk0dAhC6T/K4SdrgBoUVIRdkkrydtaGnSGHWMCFRBzy/1eur6b5nC?=
 =?us-ascii?Q?tvcnRmNjZ048k7kwNJIXjX9it9h8Ae3l9qTbuGW8iXYQFoq7uLqA61ZHtzds?=
 =?us-ascii?Q?1WmqV6gAYXe8VM+byvUGg8V6sVRJ7TOz4snjlKLGQRw78EThvRKk9N31nUfR?=
 =?us-ascii?Q?f0A1yoV7ZZEMkGI0JWxwEe7dDuKZ9SDl88WHlUE/3JVMH6rDEW5q+Yfk9cKs?=
 =?us-ascii?Q?2eVnGOBrgNAMtrngmLbudFw1tegFTKTLCDeZcDa6f3Szq+r3z5BIX5GWZT4p?=
 =?us-ascii?Q?mab3zt44AyTgI2ClncGLr3OviXDxq0xfcAb9p7UUoGT+qxsoxrN19L1SQs6/?=
 =?us-ascii?Q?C0nnOONp5CMS5231s/NWKP1/0Nm+dvRK3ySqhhaFqmkGcPhFl6/vyupxGD4O?=
 =?us-ascii?Q?teV55ErlDMxbwADZGuw6VHpxZcPuncshdelcW28Z5V/KKOZDebsx8ylrNq4Y?=
 =?us-ascii?Q?LuhAyB8VHAtz78wopmw7svVsruvp3L5GaNoNZbLZtx/CBPV33A4rBlmaZt08?=
 =?us-ascii?Q?fsfNp+EXq50GbgGOGDVP8YHEaI3LPxyTnNofQqZdHJ+s+/at13OZJ3bySaUu?=
 =?us-ascii?Q?ltok++s7zCF+XwJ52zgO+Ey2OQETWo5U7HcWG6B3Bg6/AvF+vGk5WQiGLAqA?=
 =?us-ascii?Q?soHX+NGJkwu9UKj7epxpcWqfikkOeOXH/LiuhXHGd85p3VI1GR3ARjhmOFFZ?=
 =?us-ascii?Q?3x3eZ4SUb9qF+R3eujTNeEzgGXevJ8KHqymVoX73t9X0RRoKdFui7OKOaa0m?=
 =?us-ascii?Q?XdhjoFtzhMpKopUTvPiFe8rMzD4JKvucubefx4LBPq+Xt950HYO8nO09thub?=
 =?us-ascii?Q?RvUujRwrVC8D0T0J58kO+bMgjrvuX6+hoiyOAM4UK1OSi5FL/J0hoRUQjgcL?=
 =?us-ascii?Q?XUs8NE783fm3ujT8meiqchpP/+VvLs52Kuo1rgvIOE+cYmWUvTK7kjQV0y5a?=
 =?us-ascii?Q?l7VmzidDNewPJKTtG6h15UHIxicK4hjuuKjec+riWbQTP0OID8k65V2qvqcH?=
 =?us-ascii?Q?6is0xyrsfAnwyh0WdXGgPTF+hV6WSDdxtyD0zObEjTKU5js38sZLP1gWyZTn?=
 =?us-ascii?Q?W9kcFmO00zbAeYXC5p7PcgAOY1xv27hefhbP8ZYTfipQK1S5gkt4UTuwE6qb?=
 =?us-ascii?Q?4UrHNnnskzhns47dH5k2zW6JI0xzXqndPhGFKEOLdDK47Ivx+wVddiIUeQDq?=
 =?us-ascii?Q?e/z4jUKOpx0g1WcId956pL8pV/aiMomA6lrz9xyWYm7qUDOwubf2se25V/DX?=
 =?us-ascii?Q?4T0KB1ZDKrSNd4/uiBAmWyzC9ul42xIyswp+VEN2bKAS5eTlxWgYpe4ufs8u?=
 =?us-ascii?Q?LqNqwWbC/HEadE9VLmn6hLRt3cLSg9EI9ApYAWCfpguX3Kg9unnaOiIzaSjp?=
 =?us-ascii?Q?j1wO1n1E0dBCWquSi6fUxz7D+elg0M+6IB+QMYdcavJKZCe9/lqMPU41kLhD?=
 =?us-ascii?Q?CRp702h2qYUd/GOd220=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6534.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37837f47-1aff-4fa1-7524-08de0b252981
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2025 13:25:37.1203 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7lOK/DlNWGZsCrtZIeYhKZL7+hoa1zvRJagvR16gnJADR48kwL76Xm3oZWDItlcVKYV5jjfsjUqMBtXwRxGjyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8409
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
        * Single Display eDP -> 1080p 60hz, 1920x1200 165hz, 3840x2400 60hz
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
        * Samsung ATNA60YV02-0 3840x2400 60Hz OLED eDP


The patchset consists of the amd-staging-drm-next branch (Head commit - b55=
705605ee2d980e59b278c54ce036465803067 -> drm/amdgpu: clean up amdgpu hmm ra=
nge functions) with new patches added on top of it.

Tested on Ubuntu 24.04.3, on Wayland and X11, using Gnome.

Tested-by: Dan Wheeler <daniel.wheeler@amd.com>



Thank you,

Dan Wheeler
Sr. Technologist | AMD
SW Display
---------------------------------------------------------------------------=
---------------------------------------
1 Commerce Valley Dr E, Thornhill, ON L3T 7X6
amd.com

-----Original Message-----
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
Sent: Wednesday, October 8, 2025 2:47 PM
To: amd-gfx@lists.freedesktop.org
Cc: Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo) <Sunpeng.L=
i@amd.com>; Pillai, Aurabindo <Aurabindo.Pillai@amd.com>; Li, Roman <Roman.=
Li@amd.com>; Lin, Wayne <Wayne.Lin@amd.com>; Chung, ChiaHsuan (Tom) <ChiaHs=
uan.Chung@amd.com>; Zuo, Jerry <Jerry.Zuo@amd.com>; Wheeler, Daniel <Daniel=
.Wheeler@amd.com>; Wu, Ray <Ray.Wu@amd.com>; LIPSKI, IVAN <IVAN.LIPSKI@amd.=
com>; Hung, Alex <Alex.Hung@amd.com>
Subject: [PATCH 00/22] DC Patches for 13 Oct 2025

Display Core v3.2.354 release highlights:

    * DCN35 dispclk, dppclk & other fixes
    * DCN401 cursor offload fix
    * Add new block seqeunce-building/executing functions
    * null ptr fixes
    * DPIA hpd fix
    * debug improvements
    * Fix performance regression from full updates
    * Firmware Release 0.1.31.0

Cc: Dan Wheeler <daniel.wheeler@amd.com>

---

Alvin Lee (3):
  drm/amd/display: Remove unused field in DML
  drm/amd/display: Update DCN401 path for cursor offload
  drm/amd/display: Update spacing in struct

Aurabindo Pillai (2):
  drm/amd/display: Add sink/link debug logs
  drm/amd/display: use GFP_NOWAIT for allocation in interrupt handler

Charlene Liu (3):
  drm/amd/display: add dispclk ramping to dcn35.
  drm/amd/display: add dccg dfs mask def
  drm/amd/display: increase max link count and fix link->enc NULL
    pointer access

Dominik Kaszewski (2):
  drm/amd/display: Remove dc state from check_update
  drm/amd/display: Fix performance regression from full updates

Harry VanZyllDeJong (1):
  drm/amd/display: fix duplicate aux command with AMD aux backlight

Ilya Bakoulin (1):
  drm/amd/display: add new block sequence-building/executing functions

Meenakshikumar Somasundaram (1):
  drm/amd/display: Fix NULL pointer dereference

Ovidiu Bunea (1):
  drm/amd/display: Move all DCCG RCG into HWSS root_clock_control

Peichen Huang (1):
  drm/amd/display: not skip hpd irq for bw alloc mode

Relja Vojvodic (1):
  drm/amd/display: Rework HDMI data channel reads

Samson Tam (1):
  drm/amd/display: Add debug option to override EASF scaler taps

Taimur Hassan (2):
  drm/amd/display: [FW Promotion] Release 0.1.31.0
  drm/amd/display: Promote DC to 3.2.354

Wenjing Liu (2):
  drm/amd/display: update perfmon measurement interfaces
  drm/amd/display: add additional hdcp traces

Yihan Zhu (1):
  drm/amd/display: fix dppclk rcg poweron check

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   77 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  131 +-
 .../drm/amd/display/dc/core/dc_hw_sequencer.c | 3161 ++++++++++++++++-
 .../gpu/drm/amd/display/dc/core/dc_stream.c   |    6 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |    3 +-
 .../gpu/drm/amd/display/dc/dc_spl_translate.c |    2 +
 drivers/gpu/drm/amd/display/dc/dc_types.h     |    1 +
 .../amd/display/dc/dccg/dcn35/dcn35_dccg.c    |   23 +-
 .../amd/display/dc/dccg/dcn35/dcn35_dccg.h    |    8 +
 .../dml2/dml21/inc/dml_top_dchub_registers.h  |    1 -
 .../amd/display/dc/hubp/dcn32/dcn32_hubp.c    |   70 +-
 .../amd/display/dc/hwss/dcn31/dcn31_hwseq.c   |    3 +-
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   |    5 -
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c | 1356 ++++++-
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.h |   98 +
 .../amd/display/dc/hwss/dcn401/dcn401_init.c  |   17 +
 .../drm/amd/display/dc/hwss/hw_sequencer.h    | 1409 +++++++-
 .../display/dc/hwss/hw_sequencer_private.h    |   36 +
 .../amd/display/dc/inc/hw/cursor_reg_cache.h  |    6 +-
 .../gpu/drm/amd/display/dc/inc/hw/dchubbub.h  |   36 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h  |    1 +
 .../gpu/drm/amd/display/dc/inc/hw/hw_shared.h |    8 +-
 .../display/dc/link/accessories/link_dp_cts.c |    3 +-
 .../drm/amd/display/dc/link/link_detection.c  |    4 +
 .../amd/display/dc/link/protocols/link_ddc.c  |    3 +-
 .../dc/link/protocols/link_dp_dpia_bw.c       |   19 +-
 .../dc/link/protocols/link_dp_irq_handler.c   |    4 +-
 drivers/gpu/drm/amd/display/dc/sspl/dc_spl.c  |   15 +
 .../drm/amd/display/dc/sspl/dc_spl_types.h    |    1 +
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |    3 +-
 .../gpu/drm/amd/display/modules/hdcp/hdcp.c   |    6 +-
 .../gpu/drm/amd/display/modules/hdcp/hdcp.h   |    2 +-
 .../display/modules/hdcp/hdcp1_execution.c    |   13 +-
 .../display/modules/hdcp/hdcp2_execution.c    |   19 +-
 .../drm/amd/display/modules/hdcp/hdcp_log.h   |    6 +
 .../drm/amd/display/modules/inc/mod_hdcp.h    |   14 +
 36 files changed, 6245 insertions(+), 325 deletions(-)

--
2.51.0

