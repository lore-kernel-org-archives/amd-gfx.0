Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC7DFC77B73
	for <amd-gfx@archiver.kernel.org>; Mon,  5 Jun 2023 14:02:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 67D3C10E1CF;
	Mon,  5 Jun 2023 14:02:00 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 625CF10E2B4
 for <amd-gfx@lists.freedesktop.org>; Mon,  5 Jun 2023 14:01:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fR7dh7VhctMANgNWlclrlYCIO6unx4ZYJgFzMxsKUn2BhXRfKD513gD47NUzxYF0QpVwQABIrTwuZOEC419WcRuQQFASwcaDQ+ce/TpwM8UbgjP/kPA2ocpVtQmanFVvsfBiJOpe/n0G5n3fbNhJxPbhaNsXQRXa88alqyUjTH1vTiTCtg1dtpiDjzo6bK9hSbiYXtXaDFlxh+5yAvV1dusSVUGdW2FWRfKZPn8FQd5mYgJSoeaBZLVg9T+82+Si5cpkBsA1bD3O7rk78U1BGVn7KUqcnFRpWXo/L26Xhl0RzZR0usaS+oFhf+G1liNh8uw0V8SamUiVbwIXmHBApg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L79QylnbRwJDTNIM3+ltkLUFG4D3pvaSIBHwEcy/dwc=;
 b=gjYs1s3GkSLqmyewNJeXDupeZsc210T8Z7uL4/eEs/7p2U/gZBH+GdM57VO5y1zLZUYjP4zB3RXV4+9F/ZkKSva5HhNpMsL6BCxDnc1iwSrkDOQdUs0QwH4lbK4p2TyAi1F9jpoIrYZeoHvLX6G3aU5BoUk3kgFRAlDvU0xR8/ZLFQwLwku5lUa0v7/pDgzulySPclwJyXZNadpcmjwN7qr82jq9CCL0CCrebc8yyc97K2SPmpY6iPvnm/BKwMS04Ee/FrjZTCnaXsChLqh4G+pxX/oC46RUydtooSh48eCoXxndX3qLA6+BVRD9gqv031cgnj+pbSrsJcTxLGv0pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L79QylnbRwJDTNIM3+ltkLUFG4D3pvaSIBHwEcy/dwc=;
 b=pNLJNmb6hIve2/fhHgds2sylSm0j2WKuLZStOWh/9Myxcg0Xjfrjea4o0c47Qrg1zgUT3E1ItgJHQbdV4D++gcQYMXPWvHfKYWW08IJut3r6yBEMRsyKrCqYQ0C9TjbfJ1bOn+SRmvaFnFkvb5v7EqMjsp5aUqfkjodfTfCXcHU=
Received: from DS0PR12MB6534.namprd12.prod.outlook.com (2603:10b6:8:c1::19) by
 PH8PR12MB7111.namprd12.prod.outlook.com (2603:10b6:510:22d::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.33; Mon, 5 Jun 2023 14:01:55 +0000
Received: from DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::1f59:b0a3:9eb8:e272]) by DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::1f59:b0a3:9eb8:e272%4]) with mapi id 15.20.6455.030; Mon, 5 Jun 2023
 14:01:55 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Wang, Chao-kai (Stylon)" <Stylon.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 00/14] DC Patches June 2, 2023
Thread-Topic: [PATCH 00/14] DC Patches June 2, 2023
Thread-Index: AQHZk3sv4WkBqjfSRUKInMvcVhFAqa98RDPw
Date: Mon, 5 Jun 2023 14:01:55 +0000
Message-ID: <DS0PR12MB65340526B46BCB97D28DB9B39C4DA@DS0PR12MB6534.namprd12.prod.outlook.com>
References: <20230531044813.145361-1-stylon.wang@amd.com>
In-Reply-To: <20230531044813.145361-1-stylon.wang@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=06f8da51-b729-4356-ab36-e84d06ed6eaf;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-06-05T13:57:21Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6534:EE_|PH8PR12MB7111:EE_
x-ms-office365-filtering-correlation-id: 1752fc94-ebae-4c04-d10d-08db65cd6c03
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FUvbE3nBO4EwbZS464u9uMCsWi/45nvXhKgIQ3PJGPNSs0GULZK0r/hDuhw/9Nw3QHxrVBvX0eRmL/geqOc50qPm2DGvWgmhBgIOZbC3Yb1sGLfQfDotGZI8XUpphaAOe0mATP/iNG2WESprn8qqnU4FxhyVWTklzPNezfydYO90qS6+BQPf7J7+pek1tIhuQZGHEDlQOnO/ZSBoBApm1CmXN7ilIX4zr1WRMILvY6ruJzqi/+53T8+X2rX2FtT2T+nLdu+KWNckxB+dp5C2ZN6TedcNLLWqos7LMWJr+xeexpy/yTRuoNPGeCnBOpwO937utE7gRAwwwY25C6YwV/a2pKe2QyD6+qPzTDBU+Ea3AJVcNEyrlB/KsTTmhAxydC+aCNGqnizfiCm02eTLlfha3JTlMeItlzMpHeQyKJYG3ZmQnxTBk4K/b8Tz/O1pyEjGXDfDNUBetT9CaUpxPQ8K6EmU+Ml8KCdElI1QZ+ekVFi3cJqaDEgNv884OEQhkFaW9d27DgwAF8bqj7BXmgh6s0sv4CVOH8vMoHn0AlnHZz5kDp9N2qVlkICaVH1tcwa7xrW3pSSqhg2qKJjK3K7OFw+sz35lWo95Hum18a4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6534.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(136003)(39860400002)(366004)(346002)(376002)(451199021)(54906003)(110136005)(71200400001)(478600001)(52536014)(5660300002)(8936002)(8676002)(38070700005)(2906002)(86362001)(33656002)(4326008)(122000001)(64756008)(66446008)(66476007)(66556008)(66946007)(76116006)(316002)(55016003)(38100700002)(41300700001)(53546011)(9686003)(6506007)(26005)(186003)(83380400001)(7696005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?SBRNTKsiEyyfvLo++PHdFGPhDrJQa/0Z3/sISX1UI4uwikMlXuc0DnzDE49U?=
 =?us-ascii?Q?Br9D+NNV84D0plblGIj18DvWdcic7JS+y8i9L1zonj9VP2huO2dPch70uJDC?=
 =?us-ascii?Q?xyURF7is+CryO96Ick8zT/B52JjQp93B2+0LPhDk8Wp9VdKK1sQRn95rDEuH?=
 =?us-ascii?Q?aiOVfOTwQifANjPp51f16kg7LbOF22cRnu82OjlBp3jSQ8Lg3OQwogg2jWfq?=
 =?us-ascii?Q?o8MMunNe0dbypgBRTXeMg9gQTawK2dyu3h0PlW7CN7Eqxq5y3S0IQ6BSNiJX?=
 =?us-ascii?Q?sB9wwkMPfjAQeCoAThmFsmRuxHzsMpv86cd4A5s+cJJk//dmYA1SFhxZWnQ8?=
 =?us-ascii?Q?H7v59lgI5SDIK3BJoqL0JI+FToRLjdYwbsJv2BZBY1aHeVY3mzVT/lJp7yPY?=
 =?us-ascii?Q?JUYzVTXWSEctE0rHTc4ujZ6+w2zUYLHsxlb7Ww6KZKk9iagnMjUrx6oHYNdF?=
 =?us-ascii?Q?rxkAa2qMK3Rev5QBF4WrPEFNL3yozLdIL83twPvhSc0mJ7+y7cM6P2W8vCW5?=
 =?us-ascii?Q?rvSI0d5Nh8k0FI0Xj45SQGxL7jHzaMaosJd7P4zWtKUtIJvImbrklQAp2tGp?=
 =?us-ascii?Q?4PIFQW6PYxsqYcgBVVCJjg5AO+BwCTOo9ZYfnGIoguh9WJPRarHcTv4WFt2A?=
 =?us-ascii?Q?VEn40WHmhdsR2/M/BPdcCajZhOAPdBbsNMOBUMYGUVEBxvIaeF5SRzBw4YE1?=
 =?us-ascii?Q?3qnFtD0zOKxHdKdQ9X/cv09PQyE12OCPbgZa98KkVDU4Z3wtjJGxDMPvHkmm?=
 =?us-ascii?Q?E3YY7dRTWQkz4fRTsSwdGB3TFSxog1UDASJgnW1jTvo0L7peKU0pRZZlUm3E?=
 =?us-ascii?Q?Uwk0/FUCsP3BcqcZcvRVeQ70rBA3O3XAayx5yMJcPMJ0DQG5drutfxLNdYyl?=
 =?us-ascii?Q?FB5hu8xGuGQh90XRUMaSWGuckuh5XFS1hr4BRfyEr7bdwOr85iLlb26Po3JF?=
 =?us-ascii?Q?niIf/regSVE5pvYNH5V1dwudYQ1Mr8gbWJqAnQWiiSlAqUkTiCG07mGtIKPA?=
 =?us-ascii?Q?/nr3ICR26tZ2HjdNGWmUVjiF0r7sjmGwpx4ntot8oyvQbO0NnjepDDJfZCCc?=
 =?us-ascii?Q?TLZuzFHZKIhmW3J8C4WZDoajt4/5AlKAzvHY1/GH05UIx8iLmG5ju/VUri8p?=
 =?us-ascii?Q?v8O/EZfav5g3ZNFFT/uTl8cZOzxfzTP4RDclAwtL8AnQKdTgfE+ctXA39Bhe?=
 =?us-ascii?Q?yKNX8WvhHzukIE8AaKQQh+Ear7m+ubKsFTZj4Jtn1OxlLgnMW04SriyMAxes?=
 =?us-ascii?Q?ul2+xyT0btlL/hYSjEfL/7doiEo8tcCY3NxzooLlTJTwW/fauW2p5PPveio4?=
 =?us-ascii?Q?wO+drOd1OwJ6+fbHZ9fL2ReB+EvGfOSd8RZlOjfCXjxC6cFT+Wa5IJNAgLYU?=
 =?us-ascii?Q?F1qREXiqF+kMZZ7STxtbWQs3L6RcA29xkoxOwiAHRN4SqkYJ16Q+K6N+pdhd?=
 =?us-ascii?Q?dlBsOVgkQQv22+DFLg9Rw8Qub5NNLyWKOvLFb4pTro8YNSOxeG1okhukZKfS?=
 =?us-ascii?Q?npcS50v0i8LEzmF5BPHEdBz3lBdVZMyRYesXpPN3OmYkqugnXrKdOUhnsf/L?=
 =?us-ascii?Q?O2BJNo/pLP+yjb4YC0U=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6534.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1752fc94-ebae-4c04-d10d-08db65cd6c03
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2023 14:01:55.7625 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b7Jgo9EK7EJ7OWEz1zCVSqykRHfdQOpb4jgC507sUH2EkBSTNo7cj99JHpN7xS0MlWt9sGReM7TbemTT0pJ/NA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7111
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
Cc: "Li, Sun peng \(Leo\)" <Sunpeng.Li@amd.com>, "Wentland,
 Harry" <Harry.Wentland@amd.com>, "Zhuo,
 Qingqing \(Lillian\)" <Qingqing.Zhuo@amd.com>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>, "Li, Roman" <Roman.Li@amd.com>, "Chiu,
 Solomon" <Solomon.Chiu@amd.com>, "Pillai,
 Aurabindo" <Aurabindo.Pillai@amd.com>, "Lin, Wayne" <Wayne.Lin@amd.com>,
 "Lakha, Bhawanpreet" <Bhawanpreet.Lakha@amd.com>, "Gutierrez,
 Agustin" <Agustin.Gutierrez@amd.com>, "Kotarac, Pavle" <Pavle.Kotarac@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

Hi all,

This week this patchset was tested on the following systems:
        * Lenovo ThinkBook T13s Gen4 with AMD Ryzen 5 6600U
        * MSI Gaming X Trio RX 6800
        * Gigabyte Gaming OC RX 7900 XTX

These systems were tested on the following display/connection types:
        * eDP, (1080p 60hz [5650U]) (1920x1200 60hz [6600U]) (2560x1600 120=
hz[6600U])
        * VGA and DVI (1680x1050 60hz [DP to VGA/DVI, USB-C to VGA/DVI])
        * DP/HDMI/USB-C (1440p 170hz, 4k 60hz, 4k 144hz, 4k 240hz [Includes=
 USB-C to DP/HDMI adapters])
        * Thunderbolt (LG Ultrafine 5k)
        * MST (Startech MST14DP123DP [DP to 3x DP] and 2x 4k 60Hz displays)
        * DSC (with Cable Matters 101075 [DP to 3x DP] with 3x 4k60 display=
s, and HP Hook G2 with 1 4k60 display)
        * USB 4 (Kensington SD5700T and 1x 4k 60Hz display)
        * PCON (Club3D CAC-1085 and 1x 4k 144Hz display [at 4k 120HZ, as th=
at is the max the adapter supports])

The testing is a mix of automated and manual tests. Manual testing includes=
 (but is not limited to):
        * Changing display configurations and settings
        * Benchmark testing
        * Feature testing (Freesync, etc.)

Automated testing includes (but is not limited to):
        * Script testing (scripts to automate some of the manual checks)
        * IGT testing

The patchset consists of the amd-staging-drm-next branch (Head commit - 3e5=
4d382a51b71bd08702a10c0864a60f0108c66 -> drm/amd/amdgpu: Fix up locking etc=
 in amdgpu_debugfs_gprwave_ioctl()) with new patches added on top of it. Th=
is branch is used for both Ubuntu and Chrome OS testing (ChromeOS on a bi-w=
eekly basis).


Tested on Ubuntu 22.04.2

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
From: Wang, Chao-kai (Stylon) <Stylon.Wang@amd.com>
Sent: Wednesday, May 31, 2023 12:48 AM
To: amd-gfx@lists.freedesktop.org
Cc: Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo) <Sunpeng.L=
i@amd.com>; Lakha, Bhawanpreet <Bhawanpreet.Lakha@amd.com>; Siqueira, Rodri=
go <Rodrigo.Siqueira@amd.com>; Pillai, Aurabindo <Aurabindo.Pillai@amd.com>=
; Zhuo, Qingqing (Lillian) <Qingqing.Zhuo@amd.com>; Li, Roman <Roman.Li@amd=
.com>; Lin, Wayne <Wayne.Lin@amd.com>; Wang, Chao-kai (Stylon) <Stylon.Wang=
@amd.com>; Chiu, Solomon <Solomon.Chiu@amd.com>; Kotarac, Pavle <Pavle.Kota=
rac@amd.com>; Gutierrez, Agustin <Agustin.Gutierrez@amd.com>; Wheeler, Dani=
el <Daniel.Wheeler@amd.com>
Subject: [PATCH 00/14] DC Patches June 2, 2023

This DC patchset brings improvements in multiple areas. In summary, we have=
:

* Clock optimiation for DCN 3.1.4
* Performance improvements
* Improvements on power saving
* Fix screen flash in high resolution displays
* Enable Freesync video mode by default
* Bug fixed on hang or crashes in various cases
* Improved code robustness in corner cases

Cc: Daniel Wheeler <daniel.wheeler@amd.com>

Alvin Lee (2):
  drm/amd/display: Refactor fast update to use new HWSS build sequence
  drm/amd/display: Reduce sdp bw after urgent to 90%

Aurabindo Pillai (1):
  drm/amd/display: Enable Freesync Video Mode by default

Austin Zheng (1):
  drm/amd/display: Filter out AC mode frequencies on DC mode systems

Charlene Liu (1):
  drm/amd/display: add NULL pointer check

Daniel Miess (1):
  drm/amd/display: Enable dcn314 DPP RCO

Dmytro Laktyushkin (2):
  drm/amd/display: fix seamless odm transitions
  drm/amd/display: fix dcn315 single stream crb allocation

Leo Ma (1):
  Revert "drm/amd/display: cache trace buffer size"

Max Tseng (1):
  drm/amd/display: Add control flag to dc_stream_state to skip eDP BL
    off/link off

Nicholas Kazlauskas (1):
  drm/amd/display: Skip DPP DTO update if root clock is gated

Saaem Rizvi (1):
  drm/amd/display: Wrong index type for pipe iterator

Samson Tam (1):
  drm/amd/display: add ODM case when looking for first split pipe

Sridevi (1):
  drm/amd/display: DSC Programming Deltas

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  12 +-  .../display/dc/clk=
_mgr/dcn32/dcn32_clk_mgr.c  |  13 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 307 ++++++++++++++++--
 .../drm/amd/display/dc/core/dc_hw_sequencer.c | 255 +++++++++++++++  .../g=
pu/drm/amd/display/dc/core/dc_resource.c |  20 ++
 .../gpu/drm/amd/display/dc/core/dc_stream.c   |   4 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |   2 +
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |   1 +
 .../amd/display/dc/dce100/dce100_resource.c   |   5 +
 .../display/dc/dce110/dce110_hw_sequencer.c   |   3 +-
 .../amd/display/dc/dce110/dce110_resource.c   |   5 +
 .../amd/display/dc/dce112/dce112_resource.c   |   5 +
 .../amd/display/dc/dce120/dce120_resource.c   |   1 +
 .../drm/amd/display/dc/dce80/dce80_resource.c |   6 +
 .../drm/amd/display/dc/dcn10/dcn10_resource.c |   1 +
 .../gpu/drm/amd/display/dc/dcn20/dcn20_dsc.c  |  29 +-  .../gpu/drm/amd/di=
splay/dc/dcn20/dcn20_dsc.h  |  28 ++
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    |  11 +
 .../drm/amd/display/dc/dcn20/dcn20_resource.c |   1 +
 .../amd/display/dc/dcn201/dcn201_resource.c   |   1 +
 .../drm/amd/display/dc/dcn21/dcn21_resource.c |   1 +
 .../gpu/drm/amd/display/dc/dcn31/dcn31_dccg.c |   8 +
 .../drm/amd/display/dc/dcn31/dcn31_resource.c |   1 +
 .../drm/amd/display/dc/dcn314/dcn314_dccg.c   |   5 +
 .../drm/amd/display/dc/dcn314/dcn314_hwseq.c  |   2 +-
 .../amd/display/dc/dcn314/dcn314_resource.c   |  16 +
 .../amd/display/dc/dcn315/dcn315_resource.c   |  16 +-
 .../amd/display/dc/dcn316/dcn316_resource.c   |   1 +
 .../drm/amd/display/dc/dcn32/dcn32_hwseq.c    |  26 +-
 .../drm/amd/display/dc/dcn32/dcn32_hwseq.h    |   2 +
 .../gpu/drm/amd/display/dc/dcn32/dcn32_init.c |   1 +
 .../gpu/drm/amd/display/dc/dcn32/dcn32_optc.c |   2 +-
 .../gpu/drm/amd/display/dc/dcn32/dcn32_optc.h |   1 +
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  | 142 +++++---
 .../amd/display/dc/dml/dcn321/dcn321_fpu.c    | 144 +++++---
 .../gpu/drm/amd/display/dc/inc/core_types.h   |  11 +
 .../gpu/drm/amd/display/dc/inc/hw/clk_mgr.h   |   1 +
 drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h  |   1 +
 .../gpu/drm/amd/display/dc/inc/hw_sequencer.h | 126 +++++++
 .../gpu/drm/amd/display/dc/link/link_dpms.c   |   7 +-
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h   |   1 -
 .../gpu/drm/amd/display/dmub/src/dmub_srv.c   |   2 -
 42 files changed, 1071 insertions(+), 156 deletions(-)

--
2.40.1

