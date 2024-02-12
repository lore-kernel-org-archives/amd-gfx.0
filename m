Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5D2BC4829E
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Feb 2024 15:01:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7FD4610E69E;
	Mon, 12 Feb 2024 15:01:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vLBc0Sfj";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2055.outbound.protection.outlook.com [40.107.94.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B6FB510E78E
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Feb 2024 15:01:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ghtWv3za029Yl9bXOpYUO6WNVxMVgDwtOl1ELPFhpMohAqmb5+PLcNTG7/qG0LDASy41xuCVqHnBHjn9AvNy+leCQU8q9SK6WeYNrCktMDmnz8DBI4mdXr/WS5arNZs3Yi0I419oTEGbeakZVnwy/P6y+RHHsQiiQkju/1Icyu1PHFsEFZ98f7DiTUAox2uWL51NFJ/O2lKXSbzZJIHRuqYGsUIfba5HiQu6vU41z+g7QO6bt7uo62r/tjGpWlDMAn1Gdsmu7FbS70DIR9Rpipcn7FtzUs0o4JnMPtYWk/8dWm2wHqsU7TpDs2BLsW8orsGhv4rIsVwukG6yDXyoxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+WpZb2/USBSEIGMoPDyyUgqwYR4x/TBKRoQtVRa2Dpg=;
 b=TtM4uCddKtmquflTP5MF5XPA6qBVhM3IXjHl2ubMv8b2vV7O7Pf+uXRi89yBcrfOHdWYOoCDPFiWYljQpnKLi9TcKE/9OIHY599cCYha0QQ4WYJN+uABsNeWdYv1cI5MaJ3dsigqaHQo5djX+A/9aZcOoRyNtlePJO9mJl2M9VArO62rmXu2Jl39YSKPWbp616qaqF5phl655d/hGUHZNQbZ9MnLKjMV1GLRJVaktxF+RcvPMMX26i7H7b6HOuPgrsFkU0cqRVvQ6Qrj7vwi30c9EtRvmYcgvyyqt7+4F1QLz05sOb6H2i33saPvVPZo7iU/fgqqinXXfmpcCnAOIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+WpZb2/USBSEIGMoPDyyUgqwYR4x/TBKRoQtVRa2Dpg=;
 b=vLBc0SfjXmKWGHFN2WLAOL8zYal9td4p7MMVvYFLrDdRgMPgINQHZw6riwveUey8+lP2U5i6mOzcWKiRuVMjtYMs/luSpckoUWIZqUjnbo/vjEEnPhxEBg2C6R5i29c3DhDTd8F55uqhVRaiH2g3F9vZy4n/RspDurPfXLQUZ00=
Received: from DS0PR12MB6534.namprd12.prod.outlook.com (2603:10b6:8:c1::19) by
 IA0PR12MB8278.namprd12.prod.outlook.com (2603:10b6:208:3dc::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.21; Mon, 12 Feb
 2024 15:00:54 +0000
Received: from DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::6503:7457:78d3:b2f4]) by DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::6503:7457:78d3:b2f4%4]) with mapi id 15.20.7292.021; Mon, 12 Feb 2024
 15:00:54 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Wentland, Harry" <Harry.Wentland@amd.com>, "Li, Sun peng (Leo)"
 <Sunpeng.Li@amd.com>, "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
 "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>, "Li, Roman"
 <Roman.Li@amd.com>, "Lin, Wayne" <Wayne.Lin@amd.com>, "Gutierrez, Agustin"
 <Agustin.Gutierrez@amd.com>, "Chung, ChiaHsuan (Tom)"
 <ChiaHsuan.Chung@amd.com>, "Wu, Hersen" <hersenxs.wu@amd.com>, "Zuo, Jerry"
 <Jerry.Zuo@amd.com>
Subject: RE: [PATCH 00/15] DC Patches for 12 Feb 2024
Thread-Topic: [PATCH 00/15] DC Patches for 12 Feb 2024
Thread-Index: AQHaWgeGRjMHQV0DrE6Nr4e5vdoqOLEG1CnA
Date: Mon, 12 Feb 2024 15:00:54 +0000
Message-ID: <DS0PR12MB65342885FC6A3FC23A6564DF9C482@DS0PR12MB6534.namprd12.prod.outlook.com>
References: <20240207205200.1608684-1-aurabindo.pillai@amd.com>
In-Reply-To: <20240207205200.1608684-1-aurabindo.pillai@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=4b57c4a0-e1da-4aef-a67a-7a15c789d075;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2024-02-12T15:00:33Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6534:EE_|IA0PR12MB8278:EE_
x-ms-office365-filtering-correlation-id: 8c4dd5a2-80b3-4a16-79de-08dc2bdb696f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eASR90KRBNsS5qjGsErrbijHIuBIZO+MFDAPe5Sh0SvTcxZPPLblbWJ8Y2kVSApvsUtXQ8PLIyt+UK3BDEl4yMy8Ey8PKXOsjelFLKd1I4VTsORpc6mLBu3921zHAt7pexVeLN8hpNido3FKR2YtAYUMrZoSsa19nVuR63Jz3i6VXThNBkC+742vgyW+4aDso+kz6fpu4SOaRaIGO0qrCHrDdoTYzCZD4mgG0qS76S2DG/uKeVuP1NGxVzIR9ICSbbZhgK5lvlRtJzDgaGi1nmvYnT6q+xf731rOCsL7w7Tr5YQPzZzRnxErSVHkH/rpAbh3TW6gR6j3J5QVZ351MtXgf8Q+nHtfi9GMWwjEr4ciAR3j3k6bECJeidU1Z+CR1rIHv+QO7Cug4QaB+D3TdoYVMAWlRHIow8WQv18JezsTXde5YVeEgb7J0B/8snHiNOlUjiQturu0BtId/qefQT23OVEniYbSJtQdPhh65lNMCiyOglJDpdYMYJGM+VJcJB+/3XCUAWH7PIQA/vbpgktfzVETKO8hRsERx3re+rLqyitwUrbge64aO30fXKXZKyAyyakNICqk7TUwtGBNl4UUI1MVgfFG2FP6EjlS/eKsc0of1p53v30dE12QR3mw
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6534.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(366004)(39860400002)(136003)(346002)(396003)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(83380400001)(86362001)(38100700002)(110136005)(122000001)(71200400001)(478600001)(66476007)(66556008)(66946007)(54906003)(316002)(9686003)(76116006)(6506007)(53546011)(7696005)(26005)(38070700009)(33656002)(66446008)(5660300002)(64756008)(2906002)(41300700001)(52536014)(55016003)(4326008)(8676002)(8936002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xgiQzw87lEaYo+YDhJTTBXxIQdAw6vNdwSnuWqWUIQNxfxyofhPgcXr6R3u9?=
 =?us-ascii?Q?CBYEkzwojCoOl/cuGhYJ6+cJ68BFjgFuk2CbeOumKISPAIawa6D5uT/1j6fN?=
 =?us-ascii?Q?Ny9CqMspqpljS0UJdOZcVIVcwlGgRSEPDup1xamXtKmByJlY858c9sJY/Vfw?=
 =?us-ascii?Q?mw5ldEIBQMfmxQr5RX907HJWAp3nyOpM22fuvxUkeXoBPbQkkT3ARi0lgyOc?=
 =?us-ascii?Q?njy8C7chBbf/M0lAqiVVfIJa0XDJk26LV0WTByYU2HCl6bEIfBXcVdV/ruaU?=
 =?us-ascii?Q?crFb6AzAWkCBMjKryRq/QfHu7G3AdLxwXujlnuxeCsTZ6fJbJjo2IAtoYOmI?=
 =?us-ascii?Q?qoJTsqLfZvLp9iWELxF9EXPuuH/kmOUkHXeFbQA2IAEkWo8P0IeZGUCOJgdt?=
 =?us-ascii?Q?0mulwymno19IE//HZW87in/Lp4uLnZZFrWst2Zd51brJzwPz7U3GjAaZt2gO?=
 =?us-ascii?Q?2mECNtGJj45h6oKGORL4o3ab0q59BK2RHYH0dm10Q+slvycmLs5BvlerCJS5?=
 =?us-ascii?Q?PV94S0C30R5SmqleT2rfpGoNHhQpIslBUdTayPgz8HVhQjZG1B2b65u5osnT?=
 =?us-ascii?Q?lCXHwChLSVVe5hMqeIryRZMiteC1RIKiaujhzhInjN8CBBuWUMJGJVS1goF6?=
 =?us-ascii?Q?QkBb1qpgyn+a4jS1kEsY1U1VCMHjbbm3UfWC9VkMU1MRIiR63iJXSpN0DWSX?=
 =?us-ascii?Q?noUyAKVhdi5oq0odEScdMQKOKpNx24lm50qE1m7ciU0JyYrLSsVVi/D7f9eW?=
 =?us-ascii?Q?HCWdHpsH33b9kUYRNVQ8r8Rjv5eqYKXEGlss8YQ3uq6PH9/UUPl2yDDPLniC?=
 =?us-ascii?Q?xmbl7cEKsZrpdljd6hY3obO96WjcWU75fuawVzxufQKhBqhCl1iBBrsaeo9l?=
 =?us-ascii?Q?BK8NrCu4K+4gWjBcxHr10calo+GFQ11xs9h/lA5FawwTk7WF7nukcxAVZ7f5?=
 =?us-ascii?Q?hVXmYcQMxZnrfvTUbABMVvqp7PhaTVWMHyvIxVXmWLWCPBmd9i9tcWAgoDx/?=
 =?us-ascii?Q?6UIwMIkv/3uFBDB4SaIW9W3TSMhFEYHidKYEEouUgL+pAlkBpNxZedwgWSKC?=
 =?us-ascii?Q?/tU5Nea12fGgxrONj5zJ/QnDIs47GyOn+aaW+a5s3mYOreSaHgCW1noo2/i/?=
 =?us-ascii?Q?HQOumMHMR9t2ujbC/GEdSKao8gtP7IQJ7cppf3RM14gzt3blIjZgdZa7WmdW?=
 =?us-ascii?Q?mzCXCdE4ItA0emb6HEGd93QbSiwgQIdRq3d8czMaa1tt1P8HP5RQ9ytuTK8D?=
 =?us-ascii?Q?muxlL+NS+3mSNNhe65BGiLbm3bkZLL65+2xhudJVTSh2prIeLq+P5of61hz4?=
 =?us-ascii?Q?XJuzvFtcO5TXLVwr52tsjLCDnrRb/aBzyPiI+WgLdZbNj9bS7xU/8jDMgL0U?=
 =?us-ascii?Q?eCjuI6ePnIN0clDt0tUWZu5qBfsUsQ6Abbq8iEdNgtYpJOjZlGghwYzXJSWv?=
 =?us-ascii?Q?Kk5NvcOxoZQGMZIfz6gYzapkGxMNlmT+Lu/PEI9GeSiW4nVl+4YTPz2eT4gD?=
 =?us-ascii?Q?UN3Tlo85cH1c+THya3IL6LiJqv6e1hapD8bmGUdmH0C+FxEdGqHNqFo677dW?=
 =?us-ascii?Q?fU7qecj8dl+orfx6qeg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6534.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c4dd5a2-80b3-4a16-79de-08dc2bdb696f
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2024 15:00:54.6409 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QbM6t7UXvSvrc4/zYdYFP35FuaE2C7zMc+amgLfn6M6oH3YHJMEGGEe35TI7F782hygKGNd7Iqf8imqDyZJGLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8278
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

The patchset consists of the amd-staging-drm-next branch (Head commit - f1e=
799c39016  drm/amdgpu: Avoid fetching VRAM vendor info) with new patches ad=
ded on top of it.

Tested on Ubuntu 22.04.3, on Wayland and X11, using KDE Plasma and Gnome.


Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>


Thank you,

Dan Wheeler
Sr. Technologist | AMD
SW Display
---------------------------------------------------------------------------=
---------------------------------------
1 Commerce Valley Dr E, Thornhill, ON L3T 7X6
amd.com


public mailing list to update community on promotion details.

-----Original Message-----
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
Sent: Wednesday, February 7, 2024 3:51 PM
To: amd-gfx@lists.freedesktop.org
Cc: Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo) <Sunpeng.L=
i@amd.com>; Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>; Pillai, Aurabindo=
 <Aurabindo.Pillai@amd.com>; Li, Roman <Roman.Li@amd.com>; Lin, Wayne <Wayn=
e.Lin@amd.com>; Gutierrez, Agustin <Agustin.Gutierrez@amd.com>; Chung, Chia=
Hsuan (Tom) <ChiaHsuan.Chung@amd.com>; Wu, Hersen <hersenxs.wu@amd.com>; Zu=
o, Jerry <Jerry.Zuo@amd.com>; Wheeler, Daniel <Daniel.Wheeler@amd.com>
Subject: [PATCH 00/15] DC Patches for 12 Feb 2024

Summary:

    * Revert some changes related to pixel encoding and clocks that cause
      corruption
    * IPS hang fix and FGCG enable by default for DCN35
    * PSR-SU/Replay fixes
    * Plane clip size change treated as medium update
    * Fix for checking link alignment done during link training.
    * HDMI compliance test fixes and other improvements

Cc: Daniel Wheeler <daniel.wheeler@amd.com>

----------------------------

Aric Cyr (1):
  drm/amd/display: 3.2.272

Charlene Liu (2):
  drm/amd/display: enable fgcg by default
  drm/amd/display: allow psr-su/replay for z8

Gabe Teeger (1):
  Revert "drm/amd/display: Send DTBCLK disable message on first commit"

George Shen (1):
  Revert "drm/amd/display: Add left edge pixel for YCbCr422/420 + ODM
    pipe split"

Martin Tsai (1):
  drm/amd/display: should support dmub hw lock on Replay

Michael Strauss (1):
  drm/amd/display: Update FIXED_VS Retimer HWSS Test Pattern Sequences

Nicholas Kazlauskas (2):
  drm/amd/display: Add shared firmware state for DMUB IPS handshake
  drm/amd/display: Increase ips2_eval delay for DCN35

Roman Li (1):
  drm/amd/display: Fix array-index-out-of-bounds in dcn35_clkmgr

Sohaib Nadeem (2):
  Revert "drm/amd/display: increased min_dcfclk_mhz and min_fclk_mhz"
  drm/amd/display: fixed integer types and null check locations

Tom Chung (1):
  drm/amd/display: Preserve original aspect ratio in create stream

Wenjing Liu (1):
  drm/amd/display: treat plane clip size change as MED update type

Zhikai Zhai (1):
  drm/amd/display: Add align done check

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   5 +-
 .../drm/amd/display/dc/bios/bios_parser2.c    |  16 ++-
 .../display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c  |  16 ++-  .../amd/display/d=
c/clk_mgr/dcn35/dcn35_smu.c  |  12 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  11 +-
 .../gpu/drm/amd/display/dc/core/dc_resource.c |  37 ------
 drivers/gpu/drm/amd/display/dc/dc.h           |  15 ++-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  |  83 +++++++------
 .../drm/amd/display/dc/dce/dmub_hw_lock_mgr.c |   4 +
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  |   2 +-
 .../drm/amd/display/dc/dml/dcn35/dcn35_fpu.c  |   8 +-
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   |   9 +-
 .../gpu/drm/amd/display/dc/inc/core_types.h   |   2 -
 drivers/gpu/drm/amd/display/dc/inc/resource.h |   4 -
 .../display/dc/link/accessories/link_dp_cts.c |  27 ++--  .../hwss/link_hw=
ss_dio_fixed_vs_pe_retimer.c  |  16 +--
 .../link_hwss_hpo_fixed_vs_pe_retimer_dp.c    |  51 ++++----
 .../drm/amd/display/dc/link/link_validation.c |   2 +-
 .../display/dc/link/protocols/link_dp_phy.c   |   6 +-
 .../dc/link/protocols/link_dp_training.c      |   5 +-
 .../dc/resource/dcn35/dcn35_resource.c        |   5 +-
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h   |   6 +-
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 115 ++++++++++++++++++
 .../gpu/drm/amd/display/dmub/src/dmub_dcn20.c |   3 +-
 .../gpu/drm/amd/display/dmub/src/dmub_dcn20.h |   3 +-
 .../gpu/drm/amd/display/dmub/src/dmub_dcn30.c |   3 +-
 .../gpu/drm/amd/display/dmub/src/dmub_dcn30.h |   3 +-
 .../gpu/drm/amd/display/dmub/src/dmub_dcn31.c |   3 +-
 .../gpu/drm/amd/display/dmub/src/dmub_dcn31.h |   3 +-
 .../gpu/drm/amd/display/dmub/src/dmub_dcn32.c |   3 +-
 .../gpu/drm/amd/display/dmub/src/dmub_dcn32.h |   3 +-
 .../gpu/drm/amd/display/dmub/src/dmub_dcn35.c |  12 +-
 .../gpu/drm/amd/display/dmub/src/dmub_dcn35.h |   8 +-
 .../gpu/drm/amd/display/dmub/src/dmub_srv.c   |  13 +-
 .../amd/display/include/link_service_types.h  |   9 ++
 35 files changed, 336 insertions(+), 187 deletions(-)

--
2.43.0

