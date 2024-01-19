Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0923FC4725D
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Jan 2024 16:19:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 60B8010E055;
	Fri, 19 Jan 2024 16:19:14 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2044.outbound.protection.outlook.com [40.107.220.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F1C0C10E19A
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Jan 2024 16:19:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RSgd+Ff0etcDLqLMZbEOszjdnE4Wwy4irJaacCjHBYLXlXssi4ubsf1KFwB4MD0v+UOy/bj6rpMz+0G8p8afcM8rtd9EGQuB/MHkqPMEYvaANDqU4Vd9NvJRmpZfSlbSIJ1UCxJQhifW9qVwXGLgPjmNZd85YkzAY6A4ieRVi7YjCbUomPhpbhhy1D8+AWy9eEJL4J62Mcu3jrkjMD2A5x5GN+lcH7Xuyrd2rMqOpU+Pgnu5uasAfwWaPIH1rGNxbEOHyufVzBj4Wt+RthIepBk37XisoUjE2Hzei0jaAZYtUMb2Dl7PGNLXLVlq5wz3+kmVMwzuds9K44D1hjVbhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d4+zqPvUa67MsWU/dtGkKoRiSJQMpXyqMtcuc0YvVIc=;
 b=H3xXZr24LcH1kuvGtz2/O/+hXbxWDIy5447LaUXTbr6r2Gqwm6g6AtnwgEF0irdOd8E4UW4eGm3ufohhVBtafIzP2KrpFzMAEJoyKDlTp42C/ecgPDBdfDbQOt1Hisl/B5endT+aSIttsG1Kk2dHsyLOL2eO0ndIGo8yLB9NPetEJ+8KuEUq/vF3gDWiZ9fIUahlh9doCtFIrngKWAvaN6nc+d8raFhTvVDy0fIQk7DTIHCTKdgPdYOGzr36Ef7EhmpttHAu7Ai2GbTtl8G/lwAGgezoUxDeWOiVM5vKpoTZiXhyHdEzP8kFFhLjt4JtvzjtNpoQH27BDNI9FU0Eyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d4+zqPvUa67MsWU/dtGkKoRiSJQMpXyqMtcuc0YvVIc=;
 b=tWxyi4dop6RDBZxMQGI6Yw6J5VJZSc6ogf8wFWLunXEwgBYhqUpAf06K7t1zuTmTCyOUPDrq+29N1F+TLxSCQi+1INo9wR7m849EI4tEkzRmdIxBQC6aslJF4F+oSsW5uKnvL+DoM1UAA+wsVXPXPEaFQRLPdELfGC6jZhveEyc=
Received: from DS0PR12MB6534.namprd12.prod.outlook.com (2603:10b6:8:c1::19) by
 CY8PR12MB8268.namprd12.prod.outlook.com (2603:10b6:930:6c::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7202.23; Fri, 19 Jan 2024 16:19:08 +0000
Received: from DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::b6a6:d4b4:bd6:c4f]) by DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::b6a6:d4b4:bd6:c4f%7]) with mapi id 15.20.7202.024; Fri, 19 Jan 2024
 16:19:08 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Li, Roman" <Roman.Li@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 00/12] DC Patches January 18, 2024
Thread-Topic: [PATCH 00/12] DC Patches January 18, 2024
Thread-Index: AQHaShuAp1bv80kS6EKIvhB0R8R9Q7DhUZ4A
Date: Fri, 19 Jan 2024 16:19:08 +0000
Message-ID: <DS0PR12MB6534A3AC9B4824ABD1FC6A179C702@DS0PR12MB6534.namprd12.prod.outlook.com>
References: <20240118143400.1001088-1-Roman.Li@amd.com>
In-Reply-To: <20240118143400.1001088-1-Roman.Li@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=ff12c400-8bf5-4751-bf46-b636b56db245;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2024-01-19T16:17:10Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6534:EE_|CY8PR12MB8268:EE_
x-ms-office365-filtering-correlation-id: c59b7b03-b7dd-4cf7-756f-08dc190a5d1f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: juw9P4S8QZClEraXAMrQezdboy55MJ0Be6hZQqcFqWPkAV8mf1XCBcElPOYK5aPMqAQ2CxZUCvYigO0i6sDdlI94RNzCGr4akd3T3ThWhPvx0gfpaY5XkIaNxfVyo6LfhgRuXC993if/xdHudwNjCyza7l0lNGkDo0SYgTbc2TRpnW35SUFHkPeYzxVLJ67GCC27Dbbk/ImwhuxgdpjNz5D3zqQdaS62wL+dLtWn0WiimnAgvnlh96q5UuP0zMZSpCAvSwwO1pBaPqfM3L7G17qXkBIEVjyHemDTptef3RTOb39ye/0G+kpMz5fjqNpJ6sPGgShnymgkcihbgIBsKHDeeXCO+JNo2Tl/fbbIJOTMHkly7ofi0TgHk8Qc+TJulmB4t8Tw43wgts4ZoWkhsqXay7q0HhfLtDakcv3r59+Dmx9PxxR48cWT9bHnX7KV1omCdqewQbVMbugKjPPdypI5SsKAzwM6rdefroXv4garn5Yn3MQVpRRcg7GJx9KIRSIwKVvviM5wk2NHE3nOInNmWIJGTTE5mURgC3mvUwLFXAzhYdT2/Wz6L/Dq9kEsfwpIpIGzuvaqfzgMsT0m0WIFCrxfV3HOZfEcd3BD41G/iZHx5FCsrJUvUXh82vQ6
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6534.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(136003)(396003)(39860400002)(366004)(376002)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(55016003)(38070700009)(41300700001)(33656002)(8936002)(86362001)(8676002)(38100700002)(122000001)(64756008)(66946007)(66556008)(52536014)(54906003)(66446008)(316002)(66476007)(26005)(76116006)(5660300002)(4326008)(110136005)(478600001)(6506007)(7696005)(83380400001)(2906002)(53546011)(71200400001)(9686003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0oj0J2GHPcuVjukKgCoVEmK6pudp2NdlSNrdmFaeGm6UUM6kXW12SEoZgaQP?=
 =?us-ascii?Q?pqpDsIr8nd87MmCF6lxeQkWFid4zaqBs81hyePHseziX1UCXP3af6NIxsf1/?=
 =?us-ascii?Q?gTZKRXsTMviSE3c+Jyl9pPpFnN3j1ODGHNz/qIEF1BbnPDRR1oPqMGcqvj8l?=
 =?us-ascii?Q?fjpBXmKaxXJQSGU6wsMqDZ0ej8qRTHdDOrbyzTfJHeVg6HSPMKq7PyocKTY+?=
 =?us-ascii?Q?6bAqrbnrmarmwww5xvawu3lu54V5p65pWagwq78gHLiolAH/FBafWzqoWbxg?=
 =?us-ascii?Q?usgKcTX5NPy9k0UZ0Bk/JbKJLEFfVv3p4lDE+gKlf9Omqzk+ZTamoFOGvsj5?=
 =?us-ascii?Q?lSVA70g19guvMGFMKSJm8FqJWPnlu5dpoOTo5CbeTP5N5W0ZlYilEcb0d7oX?=
 =?us-ascii?Q?A4xVSHE6r3Q4QJhsRrudO8ojD3/eQw9D1GPSb8c6+2tsWIIcbNZIm0KWGPpr?=
 =?us-ascii?Q?CDL74n/z+sVQIIzWlNiAxBhUJiM2JnTV8m8mdhpmOxPmmAznlAjY68gXrdRJ?=
 =?us-ascii?Q?I4mPCztQeIASwmjyr/R/JVS40S+4bfofYQE8GjMAKia8LHwCvbilPS7IVQJL?=
 =?us-ascii?Q?Zj8JKVTmhWMZev7PImlh3zAnNgYLyYK9v9mMZC99A2uo7mHsLbN60CXC6PLb?=
 =?us-ascii?Q?0Unsunt1QTxMWH8w/c03z1fzf+v8XtnpWgrI8bNnayW+E/f40WNJ74u90/hC?=
 =?us-ascii?Q?yazT3zgKrR2aA9tgviP4/79dkvOHsEGZ9F0oE+gXMaXuI9Wb4McE9eJTFdzC?=
 =?us-ascii?Q?Op8Gj+lYwHyObCk5BaejakXJfodGpH++AMSLxDyzE6CoC709vlGJLpx7PuID?=
 =?us-ascii?Q?AjHXhJ9HaDRGyTyQYyLZmS83jHS8z0uu9UAzL3vY3bAd/LAnLzj4ip+v+jgX?=
 =?us-ascii?Q?Q9XxcfzyC3E0NRw7F8MxZMkMnXevPTlLvgbRQh1mRuAv3JaznzQeLtvCdw+o?=
 =?us-ascii?Q?W12Nk16MjhUklW6cWzmvQi0JhZA4R+jqAZmqVVziZ+c+Qj3252UZ7EsTZqwV?=
 =?us-ascii?Q?dME0GHq2BfrAaK7SNR3mSeRSvw+sABL/0ai84K5b1k9e4rp8eOuG5Rea1kI0?=
 =?us-ascii?Q?zTVZOa7FgQS8cybGcOAj6Bezp4Ir34ErtIlTsxuFRj34WvvBFnvVdN0CB3pV?=
 =?us-ascii?Q?Nmv8Tmdf2l491IKAJcvmEC4freZE9slT5BDIRi011Q1Reb8LsXtJW2HGLKNx?=
 =?us-ascii?Q?+86XvSbqYB0pqDMTjvk/EZudjXNIUxkiY/fxRgJ8vF8LRtnlWn0IwcQyZ+jU?=
 =?us-ascii?Q?FghQZpWEH2MxGWW4utm/7jMgW4QbmEhTHFLxnrcBx+LpFLh6HtGobsJqpIeX?=
 =?us-ascii?Q?dmB9dEViiYx+lYI1Bnl3VVKZqP2mt1sCUE591YEjpp/v9iCy/Fn8A0iceHd9?=
 =?us-ascii?Q?BuAmdqR3GEW7Nl+v4/jeHguHtxQjIUsp3/PxF/8LrqJZltiMsU2MfrjKMzwy?=
 =?us-ascii?Q?8xsCR4rCO+S4/+gHfzl8o4BEBdc0r/IZ1J3Rrfw+Hdop4EExwe2hadfTbD/+?=
 =?us-ascii?Q?Vuyw+W+qfDQXf3GNJ9I6hck93khgciWGlzl5zi17H2nkuo6oDf0iOIgc0EWB?=
 =?us-ascii?Q?Yv9cM6Z87oTYv/rFv5o=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6534.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c59b7b03-b7dd-4cf7-756f-08dc190a5d1f
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2024 16:19:08.2260 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LKnerWuPVh8+x6xs4qSmbEb9tFoHi8SdYZUuKlnP7PgiPbp0DCk8EEk8dgneR9AerUp4Wn1DhRP8OvSReyAu7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8268
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
Cc: "Chung, ChiaHsuan \(Tom\)" <ChiaHsuan.Chung@amd.com>, "Li,
 Sun peng \(Leo\)" <Sunpeng.Li@amd.com>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>, "Li, 
 Roman" <Roman.Li@amd.com>, "Zuo, Jerry" <Jerry.Zuo@amd.com>, "Pillai,
 Aurabindo" <Aurabindo.Pillai@amd.com>, "Wu, Hersen" <hersenxs.wu@amd.com>, "Lin,
 Wayne" <Wayne.Lin@amd.com>, "Wentland, Harry" <Harry.Wentland@amd.com>,
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

The patchset consists of the amd-staging-drm-next branch (Head commit - 002=
63633aa58 drm/amd/display: Fix timing bandwidth calculation for HDMI) with =
new patches added on top of it.

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

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Roman.Li=
@amd.com
Sent: Thursday, January 18, 2024 9:34 AM
To: amd-gfx@lists.freedesktop.org
Cc: Chung, ChiaHsuan (Tom) <ChiaHsuan.Chung@amd.com>; Li, Sun peng (Leo) <S=
unpeng.Li@amd.com>; Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>; Li, Roman=
 <Roman.Li@amd.com>; Zuo, Jerry <Jerry.Zuo@amd.com>; Pillai, Aurabindo <Aur=
abindo.Pillai@amd.com>; Wu, Hersen <hersenxs.wu@amd.com>; Lin, Wayne <Wayne=
.Lin@amd.com>; Wentland, Harry <Harry.Wentland@amd.com>; Gutierrez, Agustin=
 <Agustin.Gutierrez@amd.com>
Subject: [PATCH 00/12] DC Patches January 18, 2024

From: Roman Li <Roman.Li@amd.com>

This DC patchset brings improvements in multiple areas. In summary, we high=
light:

* Add power_state/pme_pending flag/usb4_bw_alloc_support flags
* Add GART memory support
* Improvements for HDMI, IPS, DML2 and others

Allen Pan (1):
  drm/amd/display: Add NULL-checks in dml2 assigned pipe search

Anthony Koo (1):
  drm/amd/display: [FW Promotion] Release 0.0.201.0

Aric Cyr (2):
  drm/amd/display: Promote DAL to 3.2.268
  drm/amd/display: Promote DAL to 3.2.269

Charlene Liu (1):
  drm/amd/display: Revert "Rework DC Z10 restore"

ChunTao Tso (1):
  drm/amd/display: Replay + IPS + ABM in Full Screen VPB

Fudongwang (1):
  drm/amd/display: Add GART memory support for dmcub

Leo (Hanghong) Ma (1):
  drm/amd/display: Fix timing bandwidth calculation for HDMI

Muhammad Ahmed (1):
  drm/amd/display: add power_state and pme_pending flag

Peichen Huang (1):
  drm/amd/display: Add usb4_bw_alloc_support flag

Roman Li (1):
  drm/amd/display: Add IPS checks before dcn register access

Wenjing Liu (1):
  drm/amd/display: turn off windowed Mpo ODM feature for dcn321

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  29 +++--
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  11 +-
 .../gpu/drm/amd/display/dc/core/dc_stream.c   |   9 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |   4 +-
 drivers/gpu/drm/amd/display/dc/dc_hw_types.h  |   1 +
 drivers/gpu/drm/amd/display/dc/dc_types.h     |   5 +
 .../display/dc/dml2/dml2_dc_resource_mgmt.c   |  19 ++--
 drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c   |   5 +
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   |   2 +
 .../amd/display/dc/inc/hw/clk_mgr_internal.h  |   1 +
 .../drm/amd/display/dc/link/link_detection.c  |  18 +++
 .../gpu/drm/amd/display/dc/link/link_dpms.c   |  58 ++++++++++
 .../dc/resource/dcn321/dcn321_resource.c      |   1 +
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h   |  19 +++-
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |  59 ++++++++--
 .../gpu/drm/amd/display/dmub/src/dmub_srv.c   | 106 ++++++++----------
 .../amd/display/modules/power/power_helpers.c |   5 +
 .../amd/display/modules/power/power_helpers.h |   1 +
 18 files changed, 244 insertions(+), 109 deletions(-)

--
2.34.1

