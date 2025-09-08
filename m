Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A54F0CAC581
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Sep 2025 13:59:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2BEC410E221;
	Mon,  8 Sep 2025 13:59:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xkTJrbKf";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2076.outbound.protection.outlook.com [40.107.237.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A88AF10E221
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Sep 2025 13:59:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HyBCpDKogRA3gVe0G9Vz6hzJfaroC5O3LUZilzwOi1DPHo/1aPEMUocvRtSrJheQL5HNK4sQYOaRlo4sjHqxuzGZENfx+okUXpLUezXglz9l9bgy7+zpfxKxTFZAyshMzlEESf2AcfdRTyArtAWH40pj3zRmwqimr3v1+IUHoCreEqN563tl1pbtkLKUc6ShDk//Q7ZpRmrXFU1p96kq/dfAeDMctyPRPVY6efC5OXqUFy+4ZlgTxxKcNhezoNxZV8t7KAJlhQSy10kOlebzA460ALUamXHM0uPGnVD051CivarY+amUTGs57OmfGywVp9BgXwa2qIinbc/pWuKLeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xukrQKQY2T+e19KQSiJ6cXhxfpSJoL7CTyetOr5LQts=;
 b=spNRDp7CTXH7jEp68evxlrLl8qik/oX0NU+ophHUfbI+L9kyvvz4gwu9STa7tmVWjFD4iBpmd83dvp5YOBGCFAbAmLpRsQ5T5NrUb9wVFvlYXCXZEupHUC86d3ZlJRayPjDWwvWtkZxT6LE2SRgGzy2j1LLcGPiJeTSwIk3rR7SM4xFrnM98VwAraiWyO5sNQSKQL2SrHmbYWKS2+ndS2Dj4Vpvz6Z3i0mmgPQhecWjJyxd3J7mrqHEhlbhzfJcMB7nO3Ly4qS8vizxJGbSlmO/LVRWOImM78294qiwvX2kAVfz8tC3dBxlyxFtvy368l1vvbsvhaKLw66ym/bKZNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xukrQKQY2T+e19KQSiJ6cXhxfpSJoL7CTyetOr5LQts=;
 b=xkTJrbKfF0E8FBmrYkHEo24zD/npvonzlmWx9WhXXmjqHy4AUF/xYMZqhGZcrrGfbVlrcOSaM7USg6PT3MxGovoDjxVX//hMpnFb24/riz5soHRsH3u1PizXvjalLew1MtahxnqGVq/GKMa35SSR/zUlLcCXDZ/+2OkrsI2SPUg=
Received: from CY5PR12MB6527.namprd12.prod.outlook.com (2603:10b6:930:30::13)
 by DS7PR12MB6119.namprd12.prod.outlook.com (2603:10b6:8:99::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.22; Mon, 8 Sep 2025 13:59:35 +0000
Received: from CY5PR12MB6527.namprd12.prod.outlook.com
 ([fe80::6ac9:89ee:fdef:754e]) by CY5PR12MB6527.namprd12.prod.outlook.com
 ([fe80::6ac9:89ee:fdef:754e%7]) with mapi id 15.20.9094.021; Mon, 8 Sep 2025
 13:59:35 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Lin, Wayne" <Wayne.Lin@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Wentland, Harry" <Harry.Wentland@amd.com>, "Li, Sun peng (Leo)"
 <Sunpeng.Li@amd.com>, "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>, "Li,
 Roman" <Roman.Li@amd.com>, "Lin, Wayne" <Wayne.Lin@amd.com>, "Chung,
 ChiaHsuan (Tom)" <ChiaHsuan.Chung@amd.com>, "Zuo, Jerry" <Jerry.Zuo@amd.com>, 
 "Wu, Ray" <Ray.Wu@amd.com>, "LIPSKI, IVAN" <IVAN.LIPSKI@amd.com>, "Hung,
 Alex" <Alex.Hung@amd.com>, "Lin, Wayne" <Wayne.Lin@amd.com>
Subject: RE: [PATCH 00/11] DC Patches for September 8, 2025
Thread-Topic: [PATCH 00/11] DC Patches for September 8, 2025
Thread-Index: AQHcG6L1L0iWDYjN+EmGhvnewXN4YrSJWbKA
Date: Mon, 8 Sep 2025 13:59:35 +0000
Message-ID: <CY5PR12MB6527706102E6E2EE1AC491C89C0CA@CY5PR12MB6527.namprd12.prod.outlook.com>
References: <20250902004532.1833436-1-Wayne.Lin@amd.com>
In-Reply-To: <20250902004532.1833436-1-Wayne.Lin@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-09-08T13:58:25.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR12MB6527:EE_|DS7PR12MB6119:EE_
x-ms-office365-filtering-correlation-id: 4167e8bf-3a0a-40d3-25ab-08ddeedff1a7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?UhkXhJqrQOwCLPc8wfVdFvZhAsRXfaYFJZwbHkHMttTjQLXjKo5yHOLdbFnj?=
 =?us-ascii?Q?qghCVwd+6tkp7Rh+uNMv+kOCgVsapoBZ6h9RmRB+/Bjwsp7PZFoffHDM9SYM?=
 =?us-ascii?Q?CLq0M43khIKC+uWmkNXiA79E1I3qK3rawQKnBz2lk0sENu2PyrxsSQkC6D2C?=
 =?us-ascii?Q?AvL75l6jhXFo9BHkBnD651hDu9RplzYXBru8N16ppct/PfNEqjtBeEK9hH02?=
 =?us-ascii?Q?zKahiZR2G17bwQFgPVaQ1e7pETpIM09ynaBBhNd07EC3wNx55hh3DtVIxIGs?=
 =?us-ascii?Q?LcfV7JtG5mc2h+zC6px7B21MUqujvrSQ7dDXJtUT+CBmE2KBO/9lJb3qhia3?=
 =?us-ascii?Q?leU6cavffpNuNQdpL6PZZIJklG0ChbtCFkgmxEhgWvjyMvxJWYlhu+/EwhEL?=
 =?us-ascii?Q?5nXEHl63U/uXd5d0VTYJKs67C8LguydZmimUK+ThaNI50XEvudo/opXCuKtM?=
 =?us-ascii?Q?yZ8H4zLRaTlVby6uLXY6H46MOdACo25K0F+GqywYlPv5nxrhEHI/3o01efuv?=
 =?us-ascii?Q?YY8STRMj0UYK2K0sNYd3aWmSVkbZa++5509RIFg3mJX7QSdRZ3hb2Zxw0+F8?=
 =?us-ascii?Q?dW0ukzrxpQkNILnJPPE5qCmbaywHHdBZ+Cv7usc4gOx1W0cj5qj5EaRle/nx?=
 =?us-ascii?Q?kDnUgE4wXNYodK/E8j4xHD+vhBhNcvtlYprgbSXWHmPsQy6wdfIq1nKMxWS1?=
 =?us-ascii?Q?037GglujJXb0C9FPW00nruoOG8yvvxelinhUIYf4vzoDWXlfVw2s2DGq9Rwo?=
 =?us-ascii?Q?vXcn6Fu0Qe7Xvo6VnF1v5qECKCYY8YDJ+5MhRZxIIKSTQkaKOyESvs3t//Qf?=
 =?us-ascii?Q?iIWYCe3x8ZT6Uq6PlkI/ZR4vxOylo67m+sRhQSmjBEZrh9NaX7LYJbjvy69N?=
 =?us-ascii?Q?hfn3LD3gqcvZubLe8kf/JxUx8HirDucljikLlNtE5kS2Y20OzzdBZegg/S7k?=
 =?us-ascii?Q?LCFF2hCkAQVf6BGu3Bjdww7PrKwkfyO52X44PoRSCiH6pLUKoy2/7j+bLTz7?=
 =?us-ascii?Q?/23hd8OS8znOsTppHhZfdCeWRX2hIsIV32U6fsujegTt6yZGs1m52Zg9hSq8?=
 =?us-ascii?Q?tH6H1VySJJao2oUdo4fdZ0lBcIvo1vHqOoQgkC9YyK4ZhA8X0DLZnoRhP7em?=
 =?us-ascii?Q?vKnS4rxqfWq9cl2tfm9F0oVcUhoCZ7WuDNYusvKc3KNlDsMevanTJeVS9Otd?=
 =?us-ascii?Q?a4l3JPTcFzKQG5uANwj0dBEkn6Yw+ngzOKzfZeuUfeozeDDMtd4Ag4pyTAHs?=
 =?us-ascii?Q?HEc2OJARCJdvIFoG7ofWzF/DViAZqP+BDN0h7iQ14ny1EFvLomBaKNzNIctQ?=
 =?us-ascii?Q?7Sk+g+fQqOyEqdoBexvzAI81u2im431PVpOWGOjPACIaZ2k4hLzyVVPNEwwl?=
 =?us-ascii?Q?mFrE+CRzLrtHa5Q5JzL6PhAn1rtAAfPlmcgm0GJLD8bfkjyHvAZJaQ8RsZdw?=
 =?us-ascii?Q?XFhE3YTn2/Ktljilfzc9SdX5sLnW1bSQTdq8udLOG79/cGHImKELpw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6527.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+3OWFbTgGHylBoluBnx9Adjw4Kh4t0q08ZV0VrupJdMoB9hUrCrHSwPTvOYR?=
 =?us-ascii?Q?MpBUDq0aqDRkwapSqU5ViI6JSIJKcLrFQaJQvkowrVwI1eDgUNxwFIveWgvH?=
 =?us-ascii?Q?0Fp9Wm/+UHWgSxFgR1OWvEHcT49tLKMRrFuGm5y9v2AEkWOfj8TrguoHhI2o?=
 =?us-ascii?Q?HxMyCQmjzwL7PYKj6s55ql1MBJvXzRaUZZzjeHMCPEYcTSB3u1sECLGjrIca?=
 =?us-ascii?Q?/sg9uSmlCduHiFIE+vr2coRcr6/dFWh8dMhcGM3l5kM/reZVr0X84kJWHMAP?=
 =?us-ascii?Q?ayBxdWOsGQJdosqUYaB9CZVvDiWhGgnj2fctGTpI6rsO15k4TduACSZOHAZ8?=
 =?us-ascii?Q?WTJOJl0sxKPEWao7VweZAXARGRTjrDBHwBUXPZCnIUxPEqlzSJ7gwVqlPYX1?=
 =?us-ascii?Q?zrv86TL0WgRl+Buz/gQDEyLZ5dCjqmypoQJ0969GVGOlZ6BoSC9WG6c200+C?=
 =?us-ascii?Q?Y6bPtavYw26/LH571n7WT/2QcYB/4XnU9gUseRxNTTtq6eOVfjofr7S9piZV?=
 =?us-ascii?Q?1rYw5jp2aIqHsRI28dCk7BuxZ7U9sY0NfJL3j8imp4J/9KQNoBPxDtqSg/e0?=
 =?us-ascii?Q?XsZ7bIqNUfv+utcRfSdBKVtdfaBuWCVNEivJ1MJRSgXcZWMTOLwg0PhnPzty?=
 =?us-ascii?Q?o1k5ddnBtgdoDHG9svEKIaevesOq55Wza8vpvzUoZIBJlvdGDX6HXmh82//Q?=
 =?us-ascii?Q?YiXWvOLCbrGz0UfmL8cLD6m8r3PoisHPAKLhqvuTAMoBSXuEomjqYfR28rl+?=
 =?us-ascii?Q?ff9DKT9lWTjfu0BpAuTXTRacJp2zXESNdi8jOMnt5Q3+igKFdl1WNFhnkR5V?=
 =?us-ascii?Q?bQa1V7Rt0SgT7wxshJ0luptbbPL2ADoeG9iKfiYAXAKJ985qdjuTbUOPrkOt?=
 =?us-ascii?Q?IVERNUWrSULGyk9SV/FEOTB3r1OFiNy95rRCkFBX2JsvixMhNvlGHnffdyHF?=
 =?us-ascii?Q?KcVe/harRXq2vhe7IdNb6C9XA/23NZrWLUA7LioM/bPB3TvemuQdBeOJ3Ko3?=
 =?us-ascii?Q?sCzMA1DgXDDRSWlZuWMRyAwqA34I10oGT+UGreuNo7LrKt+A1r9KFt94Yhlv?=
 =?us-ascii?Q?sqn0ppOVd7xB62G0NDDxcFW07joAT2fB11N0n0UiHlTQeoZUPxsJ3MujMe8r?=
 =?us-ascii?Q?P/xY++phZYASRZxobioAvsqOD44UWN8EZdmlA59VGkjAxDvyEaFN4ocOBYFZ?=
 =?us-ascii?Q?YU5wSjZn5imgUO3jI9DhzYChWpSi7UWsoBjTwR1/5pZAmV8GoPS9lFom3myV?=
 =?us-ascii?Q?FgM8HnbzbLi69/l4NJg9YWdTJEvtCM8/KpTixdnhYf2Ph/u/rTJm2IcTb8iO?=
 =?us-ascii?Q?AZESAmf7Oe/gR+pyuBSlPE2+UbWvfWWCIVMm22eTFVav35W5Hn1QeG5pUg3A?=
 =?us-ascii?Q?ufGu8OR9Ncl2e8VS8afs498YxgZpM5jmADjm03FlVZ5fGOd9lbn3Lp5ZwVBD?=
 =?us-ascii?Q?b2sdia72uNkEMb3i4l5+tOwBkTY7yvWmadL0/rB9nUnIPJj6B6XxLFPJlCJc?=
 =?us-ascii?Q?eEGw5luLcndU9oKzg4MmDn3yxuFSQFP5NqRfunaDsaUDYR+DgwWB/d3BTVX/?=
 =?us-ascii?Q?u5LkLFfnT3+QFz8yiD4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6527.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4167e8bf-3a0a-40d3-25ab-08ddeedff1a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2025 13:59:35.5237 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7vnpo28Oe9iWXyufdOSPKhRY839qRJ+ZYP0jXfySM0i8dNhGhNKn1i3q0DedYj/tlDO4FA+QLpjpAAyu/pWYSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6119
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


The patchset consists of the amd-staging-drm-next branch (Head commit - bb1=
2c5af081eb863715b4d11bcf6d4ec2d7af896 -> drm/amd/pm: Remove wm_low and wm_h=
igh fields from amdgpu_crtc (v2)) with new patches added on top of it.

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
From: waynelin <Wayne.Lin@amd.com>
Sent: Monday, September 1, 2025 8:43 PM
To: amd-gfx@lists.freedesktop.org
Cc: Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo) <Sunpeng.L=
i@amd.com>; Pillai, Aurabindo <Aurabindo.Pillai@amd.com>; Li, Roman <Roman.=
Li@amd.com>; Lin, Wayne <Wayne.Lin@amd.com>; Chung, ChiaHsuan (Tom) <ChiaHs=
uan.Chung@amd.com>; Zuo, Jerry <Jerry.Zuo@amd.com>; Wheeler, Daniel <Daniel=
.Wheeler@amd.com>; Wu, Ray <Ray.Wu@amd.com>; LIPSKI, IVAN <IVAN.LIPSKI@amd.=
com>; Hung, Alex <Alex.Hung@amd.com>; Lin, Wayne <Wayne.Lin@amd.com>
Subject: [PATCH 00/11] DC Patches for September 8, 2025

This DC patchset brings improvements in multiple areas. In summary, we high=
light:

- Disable stutter when programming watermarks on dcn32
- Fix pbn_div Calculation Error
- Correct sequences and delays for DCN35 PG & RCG
- Define interfaces for hubbub perfmance monitoring support
- Extend to read eDP general capability 2
- Indicate when custom brightness curves are in use
- Dont wait for pipe update during medupdate/highirq
- Add HDCP retry_limit control parameter

Cc: Dan Wheeler <daniel.wheeler@amd.com>

---

Allen Li (1):
  drm/amd/display: Read DPCD to obtain eDP capability information.

Ausef Yousof (1):
  drm/amd/display: dont wait for pipe update during medupdate/highirq

Cruise Hung (1):
  drm/amd/display: Add link index in AUX and dpms

Dillon Varone (1):
  drm/amd/display: Disable stutter when programming watermarks on dcn32

Fangzhi Zuo (1):
  drm/amd/display: Fix pbn_div Calculation Error

Mario Limonciello (1):
  drm/amd/display: Indicate when custom brightness curves are in use

Oleh Kuzhylnyi (1):
  drm/amd/display: Add HDCP policy control

Ovidiu Bunea (1):
  drm/amd/display: Correct sequences and delays for DCN35 PG & RCG

Roman Li (1):
  drm/amd/display: Refine error message for vblank init failure

Taimur Hassan (1):
  drm/amd/display: Promote DC to 3.2.349

Wenjing Liu (1):
  drm/amd/display: Update dchubbub.h for hubbub perfmon support

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   9 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_hdcp.c    |   2 +
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   |  13 +-
 .../display/amdgpu_dm/amdgpu_dm_mst_types.h   |   2 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      |   2 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |   4 +-
 drivers/gpu/drm/amd/display/dc/dc_dp_types.h  |   1 +
 .../amd/display/dc/dccg/dcn35/dcn35_dccg.c    |  74 +++++------
 drivers/gpu/drm/amd/display/dc/dce/dce_aux.c  |  17 ++-
 .../display/dc/hubbub/dcn32/dcn32_hubbub.c    |  37 +++++-
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   | 115 +++---------------
 .../amd/display/dc/hwss/dcn35/dcn35_init.c    |   3 -
 .../amd/display/dc/hwss/dcn351/dcn351_init.c  |   3 -
 .../gpu/drm/amd/display/dc/inc/hw/dchubbub.h  |  22 ++++
 .../gpu/drm/amd/display/dc/inc/hw/pg_cntl.h   |   1 +
 .../drm/amd/display/dc/link/link_detection.c  |   2 +-
 .../gpu/drm/amd/display/dc/link/link_dpms.c   |   9 +-
 .../dc/link/protocols/link_dp_capability.c    |   6 +
 .../amd/display/dc/pg/dcn35/dcn35_pg_cntl.c   |  78 +++++++-----
 .../dc/resource/dcn32/dcn32_resource.c        |   1 +
 .../dc/resource/dcn32/dcn32_resource.h        |   3 +-
 .../gpu/drm/amd/display/modules/hdcp/hdcp.c   |   5 +-
 .../drm/amd/display/modules/inc/mod_hdcp.h    |   1 +
 23 files changed, 220 insertions(+), 190 deletions(-)

--
2.43.0

