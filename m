Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9795C3DA6E
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Dec 2023 16:48:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1840B10E12B;
	Wed, 20 Dec 2023 16:48:52 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2063.outbound.protection.outlook.com [40.107.220.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 551F010E12B
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Dec 2023 16:48:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gCTZLp+E7YRHShcH4BPc3j3Q9/XsXYCSRd/TwrEjye1ooY8GXI2XN3nCoisoYvGdU29WAHcJQKIyn1KGbczVQXidhQKdi55G8DD+oZjfo1eIgAqG/FswAA6GiwJ3GLM0Tc6h6pcjNXqVDY65TFX6R/e2RVsZPdtxCWHYp56qBViJWuk8ugZA63NHV0EC2DVvcqydN06lijrSLkCX4tPNTXkI0v5TiRhepnCbD+mJzuxPBHMHzoXIbfVAqA589BInwSMUtApO6PmsgU7PNNk23NZ5Wj1u84u1Yhgnrtkbnn4aagCuuSmlAS2l8Z8dxbE3k8B2GYqX0e2XSsOgOI+S9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5QD7kOyqklHSmRdsd/+bDSHDvNVb8wOQsZLu5UPxhC4=;
 b=QE8IPqtxABuB2CB3zFJ5J3Z86SJyQCMQjBjdbQzbMR5g2ef16YiU9RgiShq/5873mTY04frTVbo0JNjrTlbhAAX1921Xpu/4ueL/4e6ym3zzH2J6ne4UoScIxRUVJEXmsYy0TkHtxzTmGWRoEXsRFHUINll/b5qUuI3rpoXNTlOFLfW77g9ydyCPhmowXwJ2Ef0laEe68S0uGh04/ZXCyAKDR9RRmgW7GyzIf6EUlXkUP2dvWfC6/c7p8DvmmWhGQr3m5XZG5gk5zhADuQFMEXGB8yLtSFEmg+rRoROhZmwQqGBwkijkk6DFlC9NpQWzf6a66aPBDKpWaIRKTmzrSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5QD7kOyqklHSmRdsd/+bDSHDvNVb8wOQsZLu5UPxhC4=;
 b=ruz2ajLekfHCRtNP/qKB7x3DCmTrVI286ORh2s1icCpHBjbRAjU5Rc5Yx2u35J56nmAldbgJ6Q/CPrtfS1ur911EDtPE8RVXIUZeA6cIs8sJGq3cuZ4jH1sbDv2KjywKuXJLD7iim4TdxaYgy+/koZIDWJGO8VUki5bXD9E4VVc=
Received: from DS0PR12MB6534.namprd12.prod.outlook.com (2603:10b6:8:c1::19) by
 SJ2PR12MB8944.namprd12.prod.outlook.com (2603:10b6:a03:53e::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7091.38; Wed, 20 Dec 2023 16:48:47 +0000
Received: from DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::246:b20b:f0c1:bbf7]) by DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::246:b20b:f0c1:bbf7%7]) with mapi id 15.20.7113.016; Wed, 20 Dec 2023
 16:48:47 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 00/20] DC Patches December 20, 2023
Thread-Topic: [PATCH 00/20] DC Patches December 20, 2023
Thread-Index: AQHaM2K3IV0L6pBoJUmI0e+W0/sKfrCyYdpg
Date: Wed, 20 Dec 2023 16:48:47 +0000
Message-ID: <DS0PR12MB653474FD27E5419CB07BA8D59C96A@DS0PR12MB6534.namprd12.prod.outlook.com>
References: <20231220163538.1742834-1-Rodrigo.Siqueira@amd.com>
In-Reply-To: <20231220163538.1742834-1-Rodrigo.Siqueira@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=8c60078b-eb08-43e3-9118-0c65d0d7dc7d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-12-20T16:48:22Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6534:EE_|SJ2PR12MB8944:EE_
x-ms-office365-filtering-correlation-id: cd8f5c47-0def-4368-8722-08dc017b8959
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fA+yjcqebUdcOSrL58qD+o38lH12CaxneqncKojC00qFiy9sd5FxvVV76KXiTO0PTUVktomMtCMOmVD/UKH76AQ4s/6W5OBFhkptxLiaQvBQpnHTQlf5dVmkgmMHwhcsnhb5Arjc8OLpgMJU3NLwuWApG/wRaAvcd5iVRgjPcfWbhKxxqcKpCKKXZrnIRUU4bPJccgLUBKSmQlS5TPRAe5dX9gikMXRHZ7UOgBzp+OsbkdB5WfKihfiiXlnO8wJCwOibRCZgH7RsbwVbSpitU4mGSiKvhjXLuitR1jd3gPxZ4l8tjiXOaiLUsTJpqMSiQ8kGRlyPYjG7c+CyxfiVQ6y9/b6+swYJFTnYc8dxh+ktwEXapC6fp1dbJcGF9MdHPm+dC0kRxzQkGIuGPhXB8PQSoMfcYtFuUahAA8UcEFDCRoxyX6SaYdl8kXpZrx3DDkqdpHH5fqpn209zzSfbAG48vxoVXdrfTmyh4Oxt9TwfABXLCDdCF8321f8IQHpp+szsCVUJSx2Psn2KyBkTUWaqYovTjnLBo5dIZm6TpYpncDHk714Z5nF2MTfBhMvHEpi4A2Ly1J0vO/D5mDYodBgFgMJ5lBLq3d+KZEC6pzT96/iDSnZmVIvcJcZn2lC9
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6534.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(396003)(366004)(39860400002)(136003)(346002)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(55016003)(7696005)(122000001)(9686003)(53546011)(19627235002)(71200400001)(26005)(6506007)(83380400001)(38100700002)(33656002)(38070700009)(2906002)(86362001)(478600001)(4326008)(41300700001)(8936002)(110136005)(8676002)(30864003)(5660300002)(66556008)(76116006)(52536014)(66476007)(54906003)(66446008)(64756008)(66946007)(316002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3vi/6DwnWL2lWQLIKNEH5U89M4mXO1SxE5GU8RaGA7cA5rxgCP+eH9lsvdju?=
 =?us-ascii?Q?qfpW+l/wPMHXwYXiWVrXwrJoQEEcYVXqHVxU2zhHHscLQ9BhAmA8ZCFAZE8E?=
 =?us-ascii?Q?ho3Pvz51vGgCMa27eudnAFqfMhHhJXYOECe1dMKX+aH92JgYkd4nOyTsR/TK?=
 =?us-ascii?Q?IiOaYxFn90+EaoLF/AhUHezOzaXlNeeyI2E07CXszMAAgCC1y7uETqmzbjrF?=
 =?us-ascii?Q?SdeuaikoAz3GUO2NEvcU5E9UlSl7YiT5ChGYsNt3d3fYQVnT1bagjHz7pUpL?=
 =?us-ascii?Q?fQkzxZyzZcWE6Nv+hxfppT4DBmd+IIs+YgNMrVifxSseQO+n6a9TaeVl68m+?=
 =?us-ascii?Q?dElffDfqjbra+nON3PVruYK9mPf7EfWERyAfqt4nLenHKraRQGfjUQOOa7r1?=
 =?us-ascii?Q?uWsnqD7VvQNGf7tAPZO7bOTMszMuUtCWHQpNeqZg8WT9Se9uAYkAp6BO2p7R?=
 =?us-ascii?Q?71diwJrWvUY8yr6eB3t37KezK3U5TUdM+34J1w+Nmp8NhvNueoKTn1ybI9wq?=
 =?us-ascii?Q?JRBgRt9qmvDlpNlu8jLPWzmiuHlCzJPmDz5KCmjGKHH6x3akzF3TSs2VbX3u?=
 =?us-ascii?Q?1Lz677LFPWaexuFp/Q+xlDJmjmTHSHU6XZbqomkJmJe3tR/l4oTtvvtvekLW?=
 =?us-ascii?Q?E/ZURDi1NZ8QHzdLaYt5Y6eKtGUmC09nC7ijNMyjg/MpYYAnrc5o3Xi2bj4g?=
 =?us-ascii?Q?jcKS6F2tiLwrObmSdzBnt1rTGrxltQbYGfdBTmxu9mU6/uKqfyyv+db5nmDK?=
 =?us-ascii?Q?cfRkezGV+2bYSKn6JJCY4eeJM80R1hcXKB4bNiAL8WyMrcP1lDPrR9C5Md6Q?=
 =?us-ascii?Q?fu2s9zTIOSE83sezBwLMFfBmibeWVDGzV3PhMW0uULfJHEb6Bjs1t995WV5M?=
 =?us-ascii?Q?YA49KwHIY2yn5X85n1u0/kntjs+PD3MgMwP2vOUZnCtjKXj8GykixZJmiK19?=
 =?us-ascii?Q?39oCv3Sti+83F9j7VQFvkRb0VECVtt0vLOntwSfjTycQklKFhyNL9aNkToCv?=
 =?us-ascii?Q?M9L7hDaTPDTSoY5T+vDuNSe6e3E1lTLE0OIThYKgErbrqChtakDpnB4Fyy1o?=
 =?us-ascii?Q?pl490DuYENThZ9p1UtjilvYArMde1Fn5a5dV1jGst9U0qfc/EQ/QZaf4tEjM?=
 =?us-ascii?Q?+ztc5cx72F0PocgnoEnT6MuGiq0Ncqvi0fEVulskkaIg612K+ghKgB8TZu0H?=
 =?us-ascii?Q?gnF391bjlbQzp/Ag4ya6HeVQsVgq8UFDRGkNW3wylb934+whqSJnsqYQnjJT?=
 =?us-ascii?Q?ceRGxA/nFc15KbOTB2OhmTVHa2YhCSniKb+R4LgIT0R2CzjYedUJz7l++dc6?=
 =?us-ascii?Q?MmhYlcFpkrx9X6og3GtTHcUtio2X1RDb1v8iF+iUTGF0wDmYUPnFKjOgybb9?=
 =?us-ascii?Q?8ME/N6abe+1Z8QkjSasdUXzZzUJKll609Sg6IRShjkgg0VGtzFb5ITQqX1c5?=
 =?us-ascii?Q?GKXBYf9seRwbwk3C+Pb41G7tc4FgWOa3RTUU3mRv24RQvg2RETFElNYhZSw0?=
 =?us-ascii?Q?amLAQyNmH2spdxM23EjI4TkAQiyNVUa2XEfmLsXCUZCGHnUm3LoeU1PtUi8Q?=
 =?us-ascii?Q?YNu6M5jIl9XmUDzOqZI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6534.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd8f5c47-0def-4368-8722-08dc017b8959
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2023 16:48:47.6692 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 06/qDAQm0woJoXPy7d0YA6IPKZnIxYinSQANqO6M8tk2DEO56iMgqEDG+ZxSJVHMZsIAyezktQA9rAEELIHbLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8944
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
Cc: "Wang, Chao-kai \(Stylon\)" <Stylon.Wang@amd.com>, "Chung,
 ChiaHsuan \(Tom\)" <ChiaHsuan.Chung@amd.com>, "Li,
 Sun peng \(Leo\)" <Sunpeng.Li@amd.com>, "Li, 
 Roman" <Roman.Li@amd.com>, "Zuo, Jerry" <Jerry.Zuo@amd.com>, "Pillai,
 Aurabindo" <Aurabindo.Pillai@amd.com>, "Wu, Hersen" <hersenxs.wu@amd.com>,
 "Lin, Wayne" <Wayne.Lin@amd.com>, "Wentland, Harry" <Harry.Wentland@amd.com>,
 "Gutierrez, Agustin" <Agustin.Gutierrez@amd.com>
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

The patchset consists of the amd-staging-drm-next branch (Head commit - 972=
21259f157 drm/amd/display: 3.2.265) with new patches added on top of it.

Tested on Ubuntu 22.04.3, on Wayland and X11, using KDE Plasma and Gnome.


Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>


Thank you and happy holidays,

Dan Wheeler
Sr. Technologist | AMD
SW Display
---------------------------------------------------------------------------=
---------------------------------------
1 Commerce Valley Dr E, Thornhill, ON L3T 7X6
amd.com

-----Original Message-----
From: Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>
Sent: Wednesday, December 20, 2023 11:34 AM
To: amd-gfx@lists.freedesktop.org
Cc: Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo) <Sunpeng.L=
i@amd.com>; Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>; Pillai, Aurabindo=
 <Aurabindo.Pillai@amd.com>; Li, Roman <Roman.Li@amd.com>; Lin, Wayne <Wayn=
e.Lin@amd.com>; Wang, Chao-kai (Stylon) <Stylon.Wang@amd.com>; Gutierrez, A=
gustin <Agustin.Gutierrez@amd.com>; Chung, ChiaHsuan (Tom) <ChiaHsuan.Chung=
@amd.com>; Wu, Hersen <hersenxs.wu@amd.com>; Zuo, Jerry <Jerry.Zuo@amd.com>=
; Wheeler, Daniel <Daniel.Wheeler@amd.com>
Subject: [PATCH 00/20] DC Patches December 20, 2023

Here we are at the end of the year, the last set of patches for DC. This DC=
 patch set brings improvements in multiple areas. In summary, we
highlight:

* Address SubVP issues
* Update DMUB
* Improve mechanisms for test

Thanks
Siqueira

Cc: Daniel Wheeler <daniel.wheeler@amd.com>

Alvin Lee (4):
  drm/amd/display: Fix subvp+drr logic errors
  drm/amd/display: Don't allow FPO if no planes
  drm/amd/display: Assign stream status for FPO + Vactive cases
  drm/amd/display: For FPO and SubVP/DRR configs program vmin/max sel

Camille Cho (1):
  drm/amd/display: Correctly restore user_level

Gabe Teeger (1):
  drm/amd/display: Fix Mismatch between pipe and stream

Josip Pavic (1):
  drm/amd/display: Add null pointer guards where needed

Leo (Hanghong) Ma (1):
  drm/amd/display: Add HDMI capacity computations using fixed31_32

Meenakshikumar Somasundaram (2):
  drm/amd/display: Fix minor issues in BW Allocation Phase2
  drm/amd/display: Add dpia display mode validation logic

Nicholas Kazlauskas (4):
  drm/amd/display: Always exit DMCUB idle when called
  drm/amd/display: Wait forever for DMCUB to wake up
  drm/amd/display: Switch DMCUB notify idle command to NO_WAIT
  drm/amd/display: Verify disallow bits were cleared for idle

Relja Vojvodic (3):
  drm/amd/display: Add more mechanisms for tests
  drm/amd/display: Add log end specifier
  drm/amd/display: Fixing stream allocation regression

Revalla (1):
  drm/amd/display: Refactor INIT into component folder

Tom Chung (1):
  drm/amd/display: Add some functions for Panel Replay

Wayne Lin (1):
  drm/amd/display: pbn_div need be updated for hotplug event

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   3 +-
 drivers/gpu/drm/amd/display/dc/Makefile       |   2 -
 .../display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c  |  90 ++++-
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  76 +++-
 .../drm/amd/display/dc/core/dc_hw_sequencer.c | 172 +++++----
 .../drm/amd/display/dc/core/dc_link_exports.c |   9 +-
 .../gpu/drm/amd/display/dc/core/dc_resource.c |  17 +
 .../gpu/drm/amd/display/dc/core/dc_stream.c   |   3 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |  29 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  |  32 +-
 drivers/gpu/drm/amd/display/dc/dc_dp_types.h  |   6 +
 drivers/gpu/drm/amd/display/dc/dc_types.h     |   2 +
 drivers/gpu/drm/amd/display/dc/dce/dce_abm.c  |   4 +-
 drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c |   4 +-
 .../gpu/drm/amd/display/dc/dce/dmub_abm_lcd.c |   4 +-
 .../gpu/drm/amd/display/dc/dce/dmub_abm_lcd.h |   2 +-
 .../gpu/drm/amd/display/dc/dce/dmub_replay.c  |  96 ++++-
 .../gpu/drm/amd/display/dc/dce/dmub_replay.h  |   2 +
 drivers/gpu/drm/amd/display/dc/dcn10/Makefile |   2 +-
 drivers/gpu/drm/amd/display/dc/dcn20/Makefile |   2 +-
 .../gpu/drm/amd/display/dc/dcn201/Makefile    |   3 +-
 drivers/gpu/drm/amd/display/dc/dcn21/Makefile |   2 +-
 drivers/gpu/drm/amd/display/dc/dcn30/Makefile |   4 +-
 .../gpu/drm/amd/display/dc/dcn301/Makefile    |   2 +-
 .../gpu/drm/amd/display/dc/dcn302/Makefile    |  12 -
 drivers/gpu/drm/amd/display/dc/dcn31/Makefile |   2 +-
 .../gpu/drm/amd/display/dc/dcn314/Makefile    |   3 +-
 drivers/gpu/drm/amd/display/dc/dcn32/Makefile |   2 +-
 .../display/dc/dcn32/dcn32_resource_helpers.c |  37 +-
 drivers/gpu/drm/amd/display/dc/dcn35/Makefile |   2 +-
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  |  73 ++--  .../display/dc/d=
ml2/dml2_translation_helper.c |  16 +-
 .../gpu/drm/amd/display/dc/dml2/dml2_utils.c  |   6 +-
 drivers/gpu/drm/amd/display/dc/hwss/Makefile  |  28 +-
 .../amd/display/dc/hwss/dce110/dce110_hwseq.c |   7 +-
 .../amd/display/dc/hwss/dcn10/dcn10_hwseq.c   |   7 +-
 .../display/dc/{ =3D> hwss}/dcn10/dcn10_init.c  |   0
 .../display/dc/{ =3D> hwss}/dcn10/dcn10_init.h  |   0
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   |  37 ++
 .../display/dc/{ =3D> hwss}/dcn20/dcn20_init.c  |   0
 .../display/dc/{ =3D> hwss}/dcn20/dcn20_init.h  |   0
 .../dc/{ =3D> hwss}/dcn201/dcn201_init.c        |   0
 .../dc/{ =3D> hwss}/dcn201/dcn201_init.h        |   0
 .../display/dc/{ =3D> hwss}/dcn21/dcn21_init.c  |   0
 .../display/dc/{ =3D> hwss}/dcn21/dcn21_init.h  |   0
 .../amd/display/dc/hwss/dcn30/dcn30_hwseq.c   |   7 +-
 .../display/dc/{ =3D> hwss}/dcn30/dcn30_init.c  |   0
 .../display/dc/{ =3D> hwss}/dcn30/dcn30_init.h  |   0
 .../dc/{ =3D> hwss}/dcn301/dcn301_init.c        |   0
 .../dc/{ =3D> hwss}/dcn301/dcn301_init.h        |   0
 .../dc/{ =3D> hwss}/dcn302/dcn302_init.c        |   0
 .../dc/{ =3D> hwss}/dcn302/dcn302_init.h        |   0
 .../dc/{ =3D> hwss}/dcn303/dcn303_init.c        |   0
 .../dc/{ =3D> hwss}/dcn303/dcn303_init.h        |   0
 .../amd/display/dc/hwss/dcn31/dcn31_hwseq.c   |   7 +-
 .../display/dc/{ =3D> hwss}/dcn31/dcn31_init.c  |   0
 .../display/dc/{ =3D> hwss}/dcn31/dcn31_init.h  |   0
 .../dc/{ =3D> hwss}/dcn314/dcn314_init.c        |   0
 .../dc/{ =3D> hwss}/dcn314/dcn314_init.h        |   0
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.c   |   7 +-
 .../display/dc/{ =3D> hwss}/dcn32/dcn32_init.c  |   0
 .../display/dc/{ =3D> hwss}/dcn32/dcn32_init.h  |   0
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   |   7 +-
 .../display/dc/{ =3D> hwss}/dcn35/dcn35_init.c  |   0
 .../display/dc/{ =3D> hwss}/dcn35/dcn35_init.h  |   0
 .../amd/display/dc/hwss/dcn351/CMakeLists.txt |   4 +
 .../drm/amd/display/dc/hwss/dcn351/Makefile   |  17 +
 .../amd/display/dc/hwss/dcn351/dcn351_init.c  | 171 +++++++++  .../amd/dis=
play/dc/hwss/dcn351/dcn351_init.h  |  33 ++
 .../drm/amd/display/dc/hwss/hw_sequencer.h    |   9 +-
 .../gpu/drm/amd/display/dc/inc/core_types.h   |  11 +
 drivers/gpu/drm/amd/display/dc/inc/hw/abm.h   |   2 +-
 .../drm/amd/display/dc/inc/hw/panel_cntl.h    |   1 +
 drivers/gpu/drm/amd/display/dc/inc/link.h     |   2 +
 drivers/gpu/drm/amd/display/dc/inc/resource.h |   6 +-
 .../drm/amd/display/dc/link/link_factory.c    |   1 +
 .../drm/amd/display/dc/link/link_validation.h |   1 +
 .../dc/link/protocols/link_dp_dpia_bw.c       | 337 ++++++++++--------
 .../dc/link/protocols/link_dp_dpia_bw.h       |   4 +-
 .../link/protocols/link_edp_panel_control.c   |  30 ++
 .../link/protocols/link_edp_panel_control.h   |   2 +
 .../dc/resource/dcn32/dcn32_resource.c        |   2 +-
 .../dc/resource/dcn32/dcn32_resource.h        |   5 +-
 .../dc/resource/dcn321/dcn321_resource.c      |   2 +-
 .../dc/resource/dcn35/dcn35_resource.c        |  13 +
 .../amd/display/modules/power/power_helpers.c |  28 ++
 .../amd/display/modules/power/power_helpers.h |   5 +
 drivers/gpu/drm/amd/include/amd_shared.h      |   2 +
 88 files changed, 1119 insertions(+), 397 deletions(-)  delete mode 100644=
 drivers/gpu/drm/amd/display/dc/dcn302/Makefile
 rename drivers/gpu/drm/amd/display/dc/{ =3D> hwss}/dcn10/dcn10_init.c (100=
%)  rename drivers/gpu/drm/amd/display/dc/{ =3D> hwss}/dcn10/dcn10_init.h (=
100%)  rename drivers/gpu/drm/amd/display/dc/{ =3D> hwss}/dcn20/dcn20_init.=
c (100%)  rename drivers/gpu/drm/amd/display/dc/{ =3D> hwss}/dcn20/dcn20_in=
it.h (100%)  rename drivers/gpu/drm/amd/display/dc/{ =3D> hwss}/dcn201/dcn2=
01_init.c (100%)  rename drivers/gpu/drm/amd/display/dc/{ =3D> hwss}/dcn201=
/dcn201_init.h (100%)  rename drivers/gpu/drm/amd/display/dc/{ =3D> hwss}/d=
cn21/dcn21_init.c (100%)  rename drivers/gpu/drm/amd/display/dc/{ =3D> hwss=
}/dcn21/dcn21_init.h (100%)  rename drivers/gpu/drm/amd/display/dc/{ =3D> h=
wss}/dcn30/dcn30_init.c (100%)  rename drivers/gpu/drm/amd/display/dc/{ =3D=
> hwss}/dcn30/dcn30_init.h (100%)  rename drivers/gpu/drm/amd/display/dc/{ =
=3D> hwss}/dcn301/dcn301_init.c (100%)  rename drivers/gpu/drm/amd/display/=
dc/{ =3D> hwss}/dcn301/dcn301_init.h (100%)  rename drivers/gpu/drm/amd/dis=
play/dc/{ =3D> hwss}/dcn302/dcn302_init.c (100%)  rename drivers/gpu/drm/am=
d/display/dc/{ =3D> hwss}/dcn302/dcn302_init.h (100%)  rename drivers/gpu/d=
rm/amd/display/dc/{ =3D> hwss}/dcn303/dcn303_init.c (100%)  rename drivers/=
gpu/drm/amd/display/dc/{ =3D> hwss}/dcn303/dcn303_init.h (100%)  rename dri=
vers/gpu/drm/amd/display/dc/{ =3D> hwss}/dcn31/dcn31_init.c (100%)  rename =
drivers/gpu/drm/amd/display/dc/{ =3D> hwss}/dcn31/dcn31_init.h (100%)  rena=
me drivers/gpu/drm/amd/display/dc/{ =3D> hwss}/dcn314/dcn314_init.c (100%) =
 rename drivers/gpu/drm/amd/display/dc/{ =3D> hwss}/dcn314/dcn314_init.h (1=
00%)  rename drivers/gpu/drm/amd/display/dc/{ =3D> hwss}/dcn32/dcn32_init.c=
 (100%)  rename drivers/gpu/drm/amd/display/dc/{ =3D> hwss}/dcn32/dcn32_ini=
t.h (100%)  rename drivers/gpu/drm/amd/display/dc/{ =3D> hwss}/dcn35/dcn35_=
init.c (100%)  rename drivers/gpu/drm/amd/display/dc/{ =3D> hwss}/dcn35/dcn=
35_init.h (100%)  create mode 100644 drivers/gpu/drm/amd/display/dc/hwss/dc=
n351/CMakeLists.txt
 create mode 100644 drivers/gpu/drm/amd/display/dc/hwss/dcn351/Makefile
 create mode 100644 drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_init.=
c
 create mode 100644 drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_init.=
h

--
2.42.0

