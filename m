Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EA27E6F060
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Nov 2024 14:47:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E117710E2E3;
	Fri,  1 Nov 2024 14:47:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5i5CwcND";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2066.outbound.protection.outlook.com [40.107.220.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4AF4B10E2E3
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Nov 2024 14:47:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NIuyjtyQKG0yeaIybnbNVhrjB66Z/8YKfvT6ARo47+tFW/gDL54xp9zzki8eSLNroyfFldJ2gupjakqGXYZ+/TE53/ntB85JGtOdRbLXQZHSxTQ8w8EnDv2ApLOtm330ogKA+2NCZ3iRN10FKf7Q1uKDsoFrY2/xAZ/ffiWZGfwH8z3gT8ap8BK+39igVl2MdovJrF+0CVKisKgNJKUDCD6fW/IfU2X+67QTyOTzMMM0I/4tYq7QSRO2eYLwH6nAd6SJGk5aEitLMtxats5rYV+x5C0NE91uaRA5PA/FcV0WqQ8R2KsP1m0HKUq/odSQkjp4QCRG9ZAb3eHRmCnzAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oKpPOlZiageKOKY4v/0lpeNx8q9R/xAAE9FSGfy39rM=;
 b=XUY8MJ7V5JRu8NnpeFDACz3pX1d7OEZtz4xi4xNghdfDzakM6CamUez2zQcezgxDd9ez/694sQWKcKhepjB8GbdMwDWPJnCg6mtS4SWlmgEl1zAFGFh9GgNM5HX6KChl1UIhNceuu2bvFyp8XL2ZEpoTRsNnQKj2jg0gSYwzOZoZgsQDr3+DyG9cIMwQ8Sl4Az79LhG0w5cIODasXqkJ6mbKeQ3677BptvHx5EC7jusfBoKkg1j6rZPKMZ4e+2I4JFgOqz7ZgJU/H/prfTBmMv5PHwrCC/Fj0gF5YLa5G2IuE/HJW0SBDKp1HU9U+XKgShn6GsVmtM5T2MUioneUFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oKpPOlZiageKOKY4v/0lpeNx8q9R/xAAE9FSGfy39rM=;
 b=5i5CwcNDPkIsDMuuURC1D7abB90nmYDEtxCbyoYu1kvtadAzQxQh1pyeDe3DuAYEkeLFwRGMV9upl1fP6vDq49Aao7Zvm1lghpUkUJWXzBRLI3FADJ/9YcFgm43o9GpD3B4/BM84zG/Qm6uu7LN+ZPBjg/wrM/dUk5n5JQDmugI=
Received: from DS0PR12MB6534.namprd12.prod.outlook.com (2603:10b6:8:c1::19) by
 SA1PR12MB8162.namprd12.prod.outlook.com (2603:10b6:806:33a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Fri, 1 Nov
 2024 14:47:09 +0000
Received: from DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::ea87:74ba:36ec:8cf6]) by DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::ea87:74ba:36ec:8cf6%5]) with mapi id 15.20.8093.027; Fri, 1 Nov 2024
 14:47:09 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Mohamed, Zaeem" <Zaeem.Mohamed@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Wentland, Harry" <Harry.Wentland@amd.com>, "Li, Sun peng (Leo)"
 <Sunpeng.Li@amd.com>, "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
 "Mahfooz, Hamza" <Hamza.Mahfooz@amd.com>, "Pillai, Aurabindo"
 <Aurabindo.Pillai@amd.com>, "Li, Roman" <Roman.Li@amd.com>, "Lin, Wayne"
 <Wayne.Lin@amd.com>, "Chung, ChiaHsuan (Tom)" <ChiaHsuan.Chung@amd.com>,
 "Zuo, Jerry" <Jerry.Zuo@amd.com>, "Chiu, Solomon" <Solomon.Chiu@amd.com>
Subject: RE: [PATCH 00/17] DC Patches October 28, 2024
Thread-Topic: [PATCH 00/17] DC Patches October 28, 2024
Thread-Index: AQHbLGT49kxF1uUyZ0qxO1/PrcLL/bKigGrg
Date: Fri, 1 Nov 2024 14:47:09 +0000
Message-ID: <DS0PR12MB6534F63FCBF02D1969C1BDE49C562@DS0PR12MB6534.namprd12.prod.outlook.com>
References: <20241101134940.1426653-1-zaeem.mohamed@amd.com>
In-Reply-To: <20241101134940.1426653-1-zaeem.mohamed@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=a8e1594a-a4fa-4134-aedb-d1b727cd6698;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-11-01T14:44:49Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6534:EE_|SA1PR12MB8162:EE_
x-ms-office365-filtering-correlation-id: 5d6a1e0b-a553-4d5b-2044-08dcfa841039
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?IM8jHptvvvi3vf5nE54Pmt5ZYMxIgUpI9wLQwd/o/MQClwYd4oi+Hm1PwC9c?=
 =?us-ascii?Q?eOmfTBVrYtH3gk1IGbm/sW1sO2ifQ26M6s7axCoJiCDNMIClICMkgWnzGKKf?=
 =?us-ascii?Q?4lufJuh/CuxrxRiMmoLzG995QP1Ax7JAyksj64FVcztKn8a/FNGwuruqGSob?=
 =?us-ascii?Q?bdfmdievwBWtruHzVN+Q7pf3AM8SRaSyzOmpjAeJwYQFXaNdrjIChtfr4llE?=
 =?us-ascii?Q?CYgipgvNvUk0pHCXG9FbfSSSDbWoV+JedUn6ts6IlQpJQ+3w6vEIobmd4v7J?=
 =?us-ascii?Q?4jQziHXWxDUuYvnBf+RtzNa9wgTnV5Ef5ERxcsH5369/OY/sCnFO+Qd4nXR5?=
 =?us-ascii?Q?5m49tGt+LUcaKSnLJjBPUEioWjsUUPMQ4W6rqNI7S18UDv17u2NTPhYvIUG7?=
 =?us-ascii?Q?UU5T7/L9NVGXj99LcSkgerR/bzn+IolnC+Z9Bd/wS4g4W41Uvhmlo/uCsazH?=
 =?us-ascii?Q?Tf8AfVGh4LL50d1cjBAVcP0tbWSMZi9ZgM6M4+7pOyPJDsgVKRdTNlY6LMDJ?=
 =?us-ascii?Q?z1XuxPD5vPFLb+YcNbkFFZW8sLe/pA/m4M8vAKIazYQq0UE7vAyOQsrHda8V?=
 =?us-ascii?Q?7lqMdsPembZrwHTE1cZSLd6WR1F1N6LHwwWV84dEYJky+OfV6lwwU6mcUpHM?=
 =?us-ascii?Q?PzMdXemH+ScVEDL0CgsW3OzaiOifCIcGFqeuMN6++HGHQDUFUu6av9bTF4nU?=
 =?us-ascii?Q?iFgkgFfn5XBCpvnBoeoL8cKwj/8pyO3oFJzQ8CZJlLF4zzIHqSUWPtDBlATe?=
 =?us-ascii?Q?ppeGi1Nf/pDCuRrk0KwpD/8m3FxnipvT4rb4uPhtb2ew/X8NXS7zS8yM1D27?=
 =?us-ascii?Q?4Q231JcHI9Kcc79/bQLvdLSGYfElV6Lrdgn7AC3/+WYALnX5rcHTHhPRe7Ij?=
 =?us-ascii?Q?hDEvBYZ02KeZV+/L9cp2sNRbt1kFLnYbRkhsQWWlhrxRqEezMH7VrTvBlyhd?=
 =?us-ascii?Q?w1fYmzNyNJnIeSFMtW/hkjYclt0eYhAn4vI03urXcrDPjOnXhIvrmQk8iCxB?=
 =?us-ascii?Q?SY/klOrRZKPkEFT4vdSuX0LwEb4sFL9J1l3gDBvvPok7pH4+jgJmgpKyyQOt?=
 =?us-ascii?Q?474av91qeLuUq2HZnkCyTNFS7U+R1jCiJSpOB4bafyhBoLol8YSPlXqju2vO?=
 =?us-ascii?Q?wIJ1Wkgub5zad/Pg4eOj9H5aCEF8SzLDppHwbLpwYm5cAYhI2uDhXioS5h+c?=
 =?us-ascii?Q?Bx2Ljesqiqxze7Vc5t0X4VMbNGTFzuzXBniqjTP3cu+rjqd3DyS3tgFyrith?=
 =?us-ascii?Q?KK12dFTkw+AmeBCPU8wdI9jKMgtit3E///bTdZMQWagmt6dXwTinQjtw4twS?=
 =?us-ascii?Q?3i12Dm1mVM4zjB63URxeWZ+vGh2U9DtueWBrkgxMu/1+6lLYkgNknZ6yCCVi?=
 =?us-ascii?Q?Qo6lakY=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6534.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?l7qTqsMgEcaBQomJmzRX8siaZSIZaSKpekwP4T225YAtb3qwxDBLL3281QRo?=
 =?us-ascii?Q?9sBBeZRhk6NBXF1xRj+2S7YeZjQ6Xb6RDE/iUCnyOSiMIwJYc57tGhS5UqRL?=
 =?us-ascii?Q?zKSu07V4dmQwJBn9OpcjeBdN8jkGMc87tdbA+Cw5pkVhKdo9JvWrvT6gH6Jl?=
 =?us-ascii?Q?pIwMk+MXzo/mBE8BLdhNu9g///dn75jp38DbNNdXSJVqbqpIjMGI66+dAp3P?=
 =?us-ascii?Q?rh+CxibR432V37eZ3XBWoC0xpKItzPm7Dj0B+DErlZyhb7L988zVHwJgRS7k?=
 =?us-ascii?Q?DOdsGabYzGDnvtyCPj3l/Tlu0LR3AHXl9KxxJu46ByIOCQClsEFM41MGVpvt?=
 =?us-ascii?Q?iMveiVeoh5X0cxp0R7oppA7gBdFzAp3Tz8JPshj3O87Mq1/Whkhae76ne2rQ?=
 =?us-ascii?Q?So7QJJ9ms36AhpgX/mRe21Q1HF76c3+ECXUAjtsQAiE2mEGyPDxIOT7mtoiL?=
 =?us-ascii?Q?CM1tFpggtc+Q2SYovmS45T/q13RWrI6g4p5Z5j4+AFtbM7jUsXljubtf9uQy?=
 =?us-ascii?Q?RvZOVfog/Iv7MMjt/U+GuAMdBQcaIeZ+HU+WVO4VsmpITTE/6FI2F7P070Ga?=
 =?us-ascii?Q?SH0p+8FeR466r3lyD16U4G4Pnwml6qonYe4lsLB4Lt5bkc2uK0oIXnMQNUUH?=
 =?us-ascii?Q?+CdmWPm3gWolI+tDZJMDRK5vT14LlolZx1loaUC8A1uZAuj9MKD/Yl3cy7uT?=
 =?us-ascii?Q?wKCGav04xeBTy1TKV2P85cGw2fGeylEXDlDh2FUvK/D4bv9dgrlMzO37qUsm?=
 =?us-ascii?Q?GGnLRhlofSfqf4ZpBl1s5pkgB2ZIajmt02pktyKy6cVkFbsXrcT9VL2vOyVL?=
 =?us-ascii?Q?CTJKmOOuV+0tu6lMAa9RmwhlXR8cM+PLYXYJp5Myuf5KP2gtwS0+ABrYFAMS?=
 =?us-ascii?Q?a5wjIaXUchuA6NmgTuEayr84Nx4J+BjbvUxRnTatsLyHcFRZpN3K2HIOEGEs?=
 =?us-ascii?Q?PbCWQLO/ggvqQZ4DLpbwfULXdMrdcjNxp2DZMriooIKLn90Oso1s0I2Pjy2/?=
 =?us-ascii?Q?S8adPM1yfttux8bofLC2l6F8IFdUj5FrGI99fAV27RtLRs0Iyu8Ul90V6KDX?=
 =?us-ascii?Q?KOZCxdCqF7Tte8INC1mFB6Q0LCNfePXUPbF/1hRQ+tPec5taZNPWZzXZfbyZ?=
 =?us-ascii?Q?wp+4eiHhgdLkMuvQ6NGQBcmrTCyxKQzljI1urPHgWq1dDute7usAt/ampY6c?=
 =?us-ascii?Q?/LheCuBaglzcQVHutxLh8fuTUYYYajXgtFJACkXrenSWY92c7NZBJM8p1oE+?=
 =?us-ascii?Q?VakV1hErdRaz23bxrTLl2lPuZMJG1FyA1a0k8OAjZi5JsxlXKHwGOmxpWm/F?=
 =?us-ascii?Q?qZG+2lIr7Qxz/TyX07XSjib1evOmc54Y2/HZPQijDSmg0/xSDanrwEMwSz4w?=
 =?us-ascii?Q?W1t9l5FGszSgfQRG+sUeCgoAhr7C0eZ+Hgcs/i/yM0ddSFj4S9FuIBgJBY6N?=
 =?us-ascii?Q?fA9LeXx0syfPaZyNQwrxVMkyjhP1dV+sHTM3CyopLqX8NMcHQ4z4mFujBVoD?=
 =?us-ascii?Q?b+Zlot+WZX+oR3owLTmz7wRqT48fPrPwuvbNSohFfYYQL7WvuGVZ35LzEZ7s?=
 =?us-ascii?Q?D7vtxEuqUAa3NMZAGII=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6534.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d6a1e0b-a553-4d5b-2044-08dcfa841039
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2024 14:47:09.4224 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jiY7/P0L8mIs1HItpN1jhnJb2AXb3UoSkRgMs0bjmni6SGSjFxI0X/U9zV+jpUXmvoYAhmJktnyHKXjwQ2a3rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8162
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

[AMD Official Use Only - AMD Internal Distribution Only]

Hi all,

This week this patchset was tested on 4 systems, two dGPU and two APU based=
, and tested across multiple display and connection types.

APU
        * Single Display eDP -> 1080p 60hz, 2560x1600 120hz, 1920x1200 165h=
z
        * Single Display DP -> 4k144hz, 4k240hz
        * Multi display -> eDP + DP/HDMI/USB-C -> 1080p 60hz eDP + 4k 144hz=
, 4k 240hz (Includes USB-C to DP/HDMI adapters)
        * Thunderbolt -> LG Ultrafine 5k
        * DSC -> Cable Matters 101075 (DP to 3x DP) with 3x 4k60hz displays=
, HP Hook G2 with 2x 4k60hz displays
        * USB 4 -> HP Hook G4, Lenovo Thunderbolt Dock, both with 2x 4k60hz=
 DP and 1x 4k60hz HDMI displays
        * PCON -> Club3D CAC-1085 + 1x 4k 144hz

DGPU
        * Single Display DP -> 4k144hz, 4k240hz
        * Multiple Display DP -> 4k240hz + 4k144hz
        * MST (Startech MST14DP123DP [DP to 3x DP] and 2x 4k 60hz displays)
        * DSC (with Cable Matters 101075 [DP to 3x DP] with 3x 4k60hz displ=
ays)

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

The patchset consists of the amd-staging-drm-next branch (Head commit - 685=
da0b7315c36fc61f356ed1592608f42aae5ff -> drm/amdgpu: optimize ACA log print=
) with new patches added on top of it.

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
From: Mohamed, Zaeem <Zaeem.Mohamed@amd.com>
Sent: Friday, November 1, 2024 9:49 AM
To: amd-gfx@lists.freedesktop.org
Cc: Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo) <Sunpeng.L=
i@amd.com>; Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>; Mahfooz, Hamza <H=
amza.Mahfooz@amd.com>; Pillai, Aurabindo <Aurabindo.Pillai@amd.com>; Li, Ro=
man <Roman.Li@amd.com>; Lin, Wayne <Wayne.Lin@amd.com>; Chung, ChiaHsuan (T=
om) <ChiaHsuan.Chung@amd.com>; Zuo, Jerry <Jerry.Zuo@amd.com>; Mohamed, Zae=
em <Zaeem.Mohamed@amd.com>; Chiu, Solomon <Solomon.Chiu@amd.com>; Wheeler, =
Daniel <Daniel.Wheeler@amd.com>
Subject: [PATCH 00/17] DC Patches October 28, 2024

This DC patchset brings improvements in multiple areas. In summary, we have=
:

- Prune Invalid Modes for HDMI Output
- SPL Cleanup
- Fix brightness level not retained over reboot
- Remove inaccessible registers from DMU diagnostics

Cc: Daniel Wheeler <daniel.wheeler@amd.com>

Aric Cyr (1):
  drm/amd/display: 3.2.308

Aurabindo Pillai (1):
  drm/amd/display: parse umc_info or vram_info based on ASIC

Ausef Yousof (3):
  Revert "drm/amd/display: Block UHBR Based On USB-C PD Cable ID"
  drm/amd/display: Remove hw w/a toggle if on DP2/HPO
  drm/amd/display: Remove otg w/a toggling on HPO interfaces

Austin Zheng (1):
  drm/amd/display: Do Not Fallback To SW Cursor If HW Cursor Required

Charlene Liu (1):
  drm/amd/display: avoid divided by zero

Dominik Kaszewski (1):
  drm/amd/display: fix rxstatus_msg_sz type narrowing

Fangzhi Zuo (1):
  drm/amd/display: Prune Invalid Modes For HDMI Output

Ilya Bakoulin (1):
  drm/amd/display: Minimize wait for pending updates

Kaitlyn Tse (1):
  drm/amd/display: Implement new backlight_level_params structure

Nicholas Kazlauskas (1):
  drm/amd/display: Remove inaccessible registers from DMU diagnostics

Samson Tam (2):
  drm/amd/display: fix asserts in SPL during bootup
  drm/amd/display: SPL cleanup

Taimur Hassan (1):
  drm/amd/display: [FW Promotion] Release 0.0.241.0

Tom Chung (1):
  drm/amd/display: Fix brightness level not retained over reboot

Wayne Lin (1):
  drm/amd/display: Don't write DP_MSTM_CTRL after LT

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 57 ++++++++----
 .../drm/amd/display/dc/bios/bios_parser2.c    |  4 +-
 .../display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c  | 19 +++-
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  5 +-
 .../gpu/drm/amd/display/dc/core/dc_debug.c    | 40 +++++++++
 .../drm/amd/display/dc/core/dc_link_exports.c |  5 +-
 .../gpu/drm/amd/display/dc/core/dc_stream.c   | 10 ++-
 drivers/gpu/drm/amd/display/dc/dc.h           |  6 +-
 .../gpu/drm/amd/display/dc/dc_spl_translate.c | 14 +--
 drivers/gpu/drm/amd/display/dc/dc_types.h     | 27 ++++++
 .../amd/display/dc/hwss/dce110/dce110_hwseq.c |  6 +-
 .../amd/display/dc/hwss/dcn21/dcn21_hwseq.c   | 16 ++--
 .../amd/display/dc/hwss/dcn21/dcn21_hwseq.h   |  2 +
 .../amd/display/dc/hwss/dcn31/dcn31_hwseq.c   | 49 +++++++++++
 .../amd/display/dc/hwss/dcn31/dcn31_hwseq.h   |  3 +-
 .../amd/display/dc/hwss/dcn31/dcn31_init.c    |  2 +-
 .../amd/display/dc/hwss/dcn314/dcn314_init.c  |  2 +-
 .../amd/display/dc/hwss/dcn32/dcn32_init.c    |  2 +-
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   |  1 +
 .../amd/display/dc/hwss/dcn35/dcn35_init.c    |  2 +-
 .../amd/display/dc/hwss/dcn351/dcn351_init.c  |  2 +-  .../amd/display/dc/=
hwss/dcn401/dcn401_init.c  |  2 +-
 .../drm/amd/display/dc/hwss/hw_sequencer.h    |  5 --
 .../gpu/drm/amd/display/dc/inc/core_status.h  |  2 +
 drivers/gpu/drm/amd/display/dc/inc/link.h     |  3 +-
 .../dc/link/protocols/link_dp_capability.c    | 22 ++---
 .../link/protocols/link_edp_panel_control.c   | 17 ++--
 .../link/protocols/link_edp_panel_control.h   |  3 +-
 drivers/gpu/drm/amd/display/dc/spl/dc_spl.c   | 88 +++++++++++--------
 .../gpu/drm/amd/display/dc/spl/dc_spl_types.h |  4 +-
 .../drm/amd/display/dc/spl/spl_fixpt31_32.c   | 34 +++----
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |  7 +-
 .../gpu/drm/amd/display/dmub/src/dmub_dcn35.c |  5 +-
 .../amd/display/modules/freesync/freesync.c   |  3 +
 .../display/modules/hdcp/hdcp2_execution.c    | 31 +++----
 35 files changed, 326 insertions(+), 174 deletions(-)

--
2.34.1

