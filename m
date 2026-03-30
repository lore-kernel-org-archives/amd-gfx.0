Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41CC310D14AC
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Mar 2026 13:04:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB65210E417;
	Mon, 30 Mar 2026 13:04:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="P31eDXli";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012028.outbound.protection.outlook.com
 [40.107.200.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C84A810E34C
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Mar 2026 13:04:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=maSTS2yPiqWxbtV5b+bRvuQWjsVmd+Rp1JhnMb++92FN5mldTh/lTcnj3u/OJ9BG286yXvNYkUXs7w4ZVxBfxy5JnCmKoSkAQNFiktCRy5gRAy0pYhSlEjnG9R+jfj2GRofF5PxOFzwXRE0JrWmfrJIjG90krzUPizcay4qZol4l8UhANEmcB+QpIfkfEfg9nOZ/9/gPhqgLiIueh6esY8dITX5XPmLVWgERtXt19pIF9BtWUNOn0DZkbrGWRN0ALi9RBZa+l02Da7NvH3J3pfnmgWsF59g0nZPAo3goB9/55BsiLCLveMzmpJsD0ZrIqBHH6ImvBF1k35qhzrd9Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6xd4MNkTy5LJ9iUN1z5cJybRo0bBE1nNVeCi5coJEFM=;
 b=fkgUExEeXD+tVfCtPhT74dqMaVUxigOIB+tKwRXidb2tkr3mMEEXZPg8CnfLIFjxFRx9oSs0M2TjCreoNahiUisbtwexOwI9YRqKdc4er9RgH0qetIxMI+IGMTfd7aTllqFd8S1/4cNRweLUbIfmUC1ib6MbPkcnYQ1D63eT9cx6mGxnomyLBvU6URTDbMpwXnB60pI219+XwbG2SiddSwCiLe5c19+ifRCVW7ZxX6znnymUy49Ng0hsWu5DcFYrdvbNUbxciZzidmFLUewT7H6/Wstk8mUzcLSZnl13OT6aNHSp++tjDvROw+J830GPkBefbmc54Qq8xuEKmqUAGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6xd4MNkTy5LJ9iUN1z5cJybRo0bBE1nNVeCi5coJEFM=;
 b=P31eDXliezzPHb7x1oV/rb1hnxqqU2nwy7cU9ZhbzViRyk0bUYytv/sfzNOfs9ZWiwQCarn0DQ3W14jZxtd1WJS9+ix4dIOR0Kv2kXTGhZ1zOLeCr8sYoph3YaAk4EKMsI5TvACHXMV/1IXPvUo+KgmzVou11CFrC3MJYc3OTsk=
Received: from DS0PR12MB6534.namprd12.prod.outlook.com (2603:10b6:8:c1::19) by
 PH7PR12MB5878.namprd12.prod.outlook.com (2603:10b6:510:1d6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Mon, 30 Mar
 2026 13:04:28 +0000
Received: from DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::b2e1:64e5:3b9e:738a]) by DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::b2e1:64e5:3b9e:738a%4]) with mapi id 15.20.9769.014; Mon, 30 Mar 2026
 13:04:28 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Tseng, Chuan Yu (Max)" <ChuanYu.Tseng@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Wentland, Harry" <Harry.Wentland@amd.com>, "Li, Sun peng (Leo)"
 <Sunpeng.Li@amd.com>, "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>, "Li,
 Roman" <Roman.Li@amd.com>, "Lin, Wayne" <Wayne.Lin@amd.com>, "Chung,
 ChiaHsuan (Tom)" <ChiaHsuan.Chung@amd.com>, "Zuo, Jerry" <Jerry.Zuo@amd.com>, 
 "Wu, Ray" <Ray.Wu@amd.com>, "LIPSKI, IVAN" <IVAN.LIPSKI@amd.com>, "Hung,
 Alex" <Alex.Hung@amd.com>
Subject: RE: [PATCH 00/29] DC Patches March 25, 2026
Thread-Topic: [PATCH 00/29] DC Patches March 25, 2026
Thread-Index: AQHcvCY4eUb9BSGlE0Wv8zZl2vBC5rXHEKCA
Date: Mon, 30 Mar 2026 13:04:28 +0000
Message-ID: <DS0PR12MB65346BB08A73B3A801EF17C19C52A@DS0PR12MB6534.namprd12.prod.outlook.com>
References: <20260325071003.4022594-1-ChuanYu.Tseng@amd.com>
In-Reply-To: <20260325071003.4022594-1-ChuanYu.Tseng@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2026-03-30T13:04:21.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6534:EE_|PH7PR12MB5878:EE_
x-ms-office365-filtering-correlation-id: 6606b2f7-1664-4594-2347-08de8e5ce02e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info: m65ZM/5o8UIs+J1MRPpP2Zm4M0zM7T9A8N+LVMNPcbVzc9WdDTh0E2Xo33SqFHRe4nC07e9wcdv3OwTtkXOxMrdaCY5t4nUrnPH3fGEMoJlOvNS5lfgzBLJ2EfmndjvtKe5WPblgJOZBlfIDRQgG/uVBbJZWBl27O9o0ak3vzvJF7ALQwxBfd/jreBgcIX92eQq2XE4BVLL2jU7QAc7vRpcl0Bv8LIAvzM+sEdVsqmG5VyimtvFK7FUVpb3XE2sCMMHaM9lfr8rHaLDyf4eagzctQ06ZpHqu4bqUIsvE2CLvHM3vpCkwsd9GcLkWT1d3E/niVc86YImjgIDOmVvMSTfMN2Jm6lGJPxjxXnIOvuAPApNvlxXQNHZiilrSdUClw1SWYwJieJLNLZayUhp6Q5trTc4IbNKJS2lgQq5J9YBPUDmB7GgiPDQeCM8j1Sz/v0aoO6jF0TK9eppn3AjaYCR8nundF9c9cxHxmxUoUxo1erhQn3ZXmVnShB81kyVZyPmDv/NoHlrB4V9JR09co1xZXo3/svSCtxqvIU6zP9gI+eiz6CqqLnq9VNRSYEawOlp82MZHnK7qb0//KwPQUoQMWCcUVj/nvSXYWuq+iH9nQj1yPMdpsd1Xc7IOMvSoDoDeSCMQuWC9NbuZh7NDfexeFjqwe+L9I2ZvpFXT2P9daN36BaltudijrJibn8kLmao9xrBLDvkrjfOmyVHf7nJxVzclrR+3OlUn3M9aP+03LWoo3dt0vbToSP/2umbfCnU/qTZ06P6GpCm7H6btMQn1zHGWW+/wWTfEawsEEO8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6534.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?UnSENp4LveDi+YvMBWap5ZJraDVYZgeYY2fJzp+9X0VWNQy9DHbp3a3mcC?=
 =?iso-8859-1?Q?+TpPy5CnY+k0LpCYoF2Iljrur7y+Nk1ev4ZcPTAbQZiTWZ1rjZpMc6cZES?=
 =?iso-8859-1?Q?iIZYrcRfbSA9wdXErQ1Z/2/PEr8lWwXfmaceOG4MRMKGJGhxFvSOQtUDa+?=
 =?iso-8859-1?Q?gHYBhIxRNCntjMxkYqG2SW8ux6RwNp5hroI6TcFwEANigU9YnV8k59xOPt?=
 =?iso-8859-1?Q?QH83OemHZYn63+bKagII0OICq8RrnJc/Vi7dvenAqMlGmg8YkLKEwD5rlv?=
 =?iso-8859-1?Q?3BzGADAdWLY85pRU/kBQCGNGqhwzcspdpaPtkci+1LyKKHaNoeIqZFyGDn?=
 =?iso-8859-1?Q?yiVQoda/xkXBoCf9DVBRtqkggCe/KcY7Y+mqQ0In9aX1kfJU6LVITjUgqY?=
 =?iso-8859-1?Q?WmCuEJgMqGXo+pkk68KmBRC95IQRE2XHk7lfUZ/s6akTnNvZukjj4ras9h?=
 =?iso-8859-1?Q?sfyodSwN1eGYLNbyjCE5MV6IOWHtMEDmoU0gjNrrM2OTyGhrjU07pQ7hCB?=
 =?iso-8859-1?Q?/h9j0IAo74gNlEBBR3XOJPNUQUbJ3nyAnHdc2ta5y3eHSOSow6FADjfzhD?=
 =?iso-8859-1?Q?jm3n48VSlUp8YpmFiM16RZrVazIqYILsviWSXUV27aXioICSvbndyddfNP?=
 =?iso-8859-1?Q?QmxmKtaf66tuCPj/4wqX7PGxu+lOMU1Tpx8lPyRgy3cwmXn+GWgVIgLBY5?=
 =?iso-8859-1?Q?8tzmojALN2l6fzEuwz851YeeC2Kcyh0rml0jlAxduenxwvjeH/MZEwFSWm?=
 =?iso-8859-1?Q?ZDQKnuzl/opoGX24tOZFMRpQFxDjbb6MRDACBgvXHsNtSpznbto4Gi0Pej?=
 =?iso-8859-1?Q?yxMs2X4p+Dy7SZUC8RDcsr2Vamotm9VJ8SogfWUs+7ihgIDRvbWJRXZjwY?=
 =?iso-8859-1?Q?87WzVeb4fLK5yyTDC2/ndI8lCEURtoSrQbjxfDhFFMDgikZjE69sYi5b1P?=
 =?iso-8859-1?Q?hnMkkn56t1TeCeXY6balWPndskLrXdGBWfaMB7Z80/iPZkjt2rjcIZkBt9?=
 =?iso-8859-1?Q?/9nUCQNniWSSHIEkLEDPSu5yZSumAeirWbXrWQvg2x78ljheLZvDNZd9UC?=
 =?iso-8859-1?Q?SKCnihb7IJ7xfhqN6gFBfbvfrzRh+dl9EQtSA9mpr9d5an2fx1Mc7wnGJG?=
 =?iso-8859-1?Q?EOlv1r5OZX807Dm1aZ00duV+YxThCmn0athO0GiZDA0lGWLI5gfedLC4Ij?=
 =?iso-8859-1?Q?+Q/d26ZqzQQ1r0SRegszg5QaeOQmap2PdSYoyEPl+5XYTblhihR9Ir0ygH?=
 =?iso-8859-1?Q?eAZYdSt+0Q0KP7StNXv/fhw6wDLVub5RB4od2IHHBkaUK4TKwL3xMmxCnk?=
 =?iso-8859-1?Q?p/Qm16VN4UJoEc8raFSoClsReaWRrAE+zwKiO4cPSCSGCuPQP/f69dAR+f?=
 =?iso-8859-1?Q?LD1vOApVajSJYfuMAazPA2E3zvDrw70G1ddLSgDoJTn1RivtysvEY38+Px?=
 =?iso-8859-1?Q?B20uoZf2sScPNA4b/KafNr+QQkUrB1Ajst9Zgb58J5k7MLpm9+tMSsMi2r?=
 =?iso-8859-1?Q?2T9Vmp/T9/f/WOuKc2F9hjl/hx+yNcZHa9M78wbxn9VWwgvTUha9+d74pb?=
 =?iso-8859-1?Q?XAxAEEcehxoSHzhAjqOM1mnXnx5Xve1GE23jXc5MoBuVVKUZwENee8tHO2?=
 =?iso-8859-1?Q?EUYTPeqiTJjaKCH+a0eOu8Kdlho4L2HqXP0fnS/DPssELf09EH0Be7O/jw?=
 =?iso-8859-1?Q?XgVero1jv3GAIP69Od7/qtFqnwamX6LbSNJYYcMyGzTDTW+dqfoAJnLt+f?=
 =?iso-8859-1?Q?myUAzXbph6khws1vj2erztXaXddG+nDGRLodXWVlXYRFE7?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6534.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6606b2f7-1664-4594-2347-08de8e5ce02e
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2026 13:04:28.1314 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XqSHaIjHgELNpI1+ael5Aw5NQ2qPTo9JT1msirK++t4QH0Ir7OTjmqTWrgZWYh+zFLlCzWtPbLL+0m6rw8FxTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5878
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


The patchset consists of the amd-staging-drm-next branch (Head commit - bf9=
1d3780a6f66378f20062e407f1dbeda761f91 -> drm/amd/display: Rename enum 'pixe=
l_format' to 'dc_pixel_format') with new patches added on top of it.

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
From: Tseng, Chuan Yu (Max) <ChuanYu.Tseng@amd.com>
Sent: Wednesday, March 25, 2026 3:06 AM
To: amd-gfx@lists.freedesktop.org
Cc: Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo) <Sunpeng.L=
i@amd.com>; Pillai, Aurabindo <Aurabindo.Pillai@amd.com>; Li, Roman <Roman.=
Li@amd.com>; Lin, Wayne <Wayne.Lin@amd.com>; Chung, ChiaHsuan (Tom) <ChiaHs=
uan.Chung@amd.com>; Zuo, Jerry <Jerry.Zuo@amd.com>; Wheeler, Daniel <Daniel=
.Wheeler@amd.com>; Wu, Ray <Ray.Wu@amd.com>; LIPSKI, IVAN <IVAN.LIPSKI@amd.=
com>; Hung, Alex <Alex.Hung@amd.com>; Tseng, Chuan Yu (Max) <ChuanYu.Tseng@=
amd.com>
Subject: [PATCH 00/29] DC Patches March 25, 2026

This DC patchset brings improvements in multiple areas. In summary, we have=
:

- correct unknown plane state patch
- Revert "Refactor DC update checks"
- Revert "Add 3DLUT DMA broadcast support"
- Remove invalid DPSTREAMCLK mask usage
- enable eDP DSC seamless boot support
- Revert "Rework HDMI link training and YCbCr422 with DSC policy"
- Disable PSR & Replay CRTC disable by default
- Fix Silence Compiler Warnings
- Add link output control for DPIA
- eliminate clock manager code duplication
- Don't set 4to1MPC config dynamically
- Merge pipes for validate
- Fix bounds checking in dml2_0 clock table array
- Avoid turning off the PHY when OTG is running for DVI
- Should support p-state under dcn21
- Enable Replay support for dcn42
- Remove check for DC_DMCUB_ENABLE on DCN42

Cc: Daniel Wheeler <daniel.wheeler@amd.com>

Charlene Liu (1):
  drm/amd/display: correct unknown plane state patch

Clay King (2):
  drm/amd/display: Fix silence signed/unsigned mismatch warnings in dml
  drm/amd/display: Fixed silence signed/unsigned mismatch warnings

Dillon Varone (3):
  drm/amd/display: using cm structure for lut3d related info
  Revert "drm/amd/display: Add 3DLUT DMA broadcast support"
  Revert "drm/amd/display: Refactor DC update checks"

Gabe Teeger (2):
  drm/amd/display: Fix bounds checking in dml2_0 clock table array
  drm/amd/display: eliminate clock manager code duplication

Gaghik Khachatrian (6):
  drm/amd/display: Fix Compiler Warning - unused func parameters
  drm/amd/display: Fix Silence Conversion Warnings in Dmub
  drm/amd/display: Fix Silence signed/unsighed mismatch warning in dc
  drm/amd/display: Fixed Silence complier warnings in dc
  drm/amd/display: Fix Compiler warnings in dmub
  drm/amd/display: Silence type conversion warnings in dml2

Harry Wentland (2):
  drm/amd/display: Merge pipes for validate
  drm/amd/display: Don't set 4to1MPC config dynamically

Lincheng Ku (1):
  drm/amd/dc: Add link output control for DPIA

Mohit Bawa (1):
  drm/amd/display: enable eDP DSC seamless boot support

Nicholas Kazlauskas (1):
  drm/amd/display: Avoid turning off the PHY when OTG is running for DVI

Ovidiu Bunea (1):
  drm/amd/dc: Disable PSR & Replay CRTC disable by default

Rafal Ostrowski (3):
  drm/amd/display: Move FPU Guards From DML To DC - Part 1
  drm/amd/display: Move FPU Guards From DML To DC - Part 2
  drm/amd/display: Move FPU Guards From DML To DC - Part 3

Relja Vojvodic (1):
  Revert "drm/amd/display: Rework YCbCr422 DSC policy"

Roman Li (2):
  drm/amd/display: Enable Replay support for dcn42
  drm/amd/display: Remove invalid DPSTREAMCLK mask usage

Taimur Hassan (2):
  drm/amd/display: [FW Promotion] Release 0.1.53.0
  drm/amd/display: Promote DC to 3.2.376

Wayne Lin (1):
  drm/amd/display: Should support p-state under dcn21

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   7 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_crtc.c    |   2 +-
 .../gpu/drm/amd/display/amdgpu_dm/dc_fpu.c    |  25 +-
 .../gpu/drm/amd/display/amdgpu_dm/dc_fpu.h    |  17 +-
 .../gpu/drm/amd/display/dc/basics/dce_calcs.c |   8 +-
 .../drm/amd/display/dc/basics/fixpt31_32.c    |   1 +
 .../gpu/drm/amd/display/dc/basics/vector.c    |   1 +
 .../gpu/drm/amd/display/dc/bios/bios_parser.c |   1 +
 .../drm/amd/display/dc/bios/bios_parser2.c    |   9 +
 .../drm/amd/display/dc/bios/command_table2.c  |   2 +
 .../bios/dce110/command_table_helper_dce110.c |   1 +
 .../dce112/command_table_helper2_dce112.c     |   1 +
 .../bios/dce112/command_table_helper_dce112.c |   1 +
 .../gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c  |   5 +-
 .../dc/clk_mgr/dce110/dce110_clk_mgr.c        |   2 +-
 .../display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c  |   3 +-
 .../display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c  |   3 +
 .../dc/clk_mgr/dcn314/dcn314_clk_mgr.c        |   3 +
 .../dc/clk_mgr/dcn315/dcn315_clk_mgr.c        |   3 +
 .../dc/clk_mgr/dcn316/dcn316_clk_mgr.c        |   3 +
 .../display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c  |   4 +-
 .../dc/clk_mgr/dcn401/dcn401_clk_mgr.c        |   3 +
 .../display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c  |  31 +-
 .../display/dc/clk_mgr/dcn42/dcn42_clk_mgr.h  |   9 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 580 +++++++++++-------
 .../drm/amd/display/dc/core/dc_hw_sequencer.c |   1 +
 .../drm/amd/display/dc/core/dc_link_exports.c |   4 +-
 .../gpu/drm/amd/display/dc/core/dc_resource.c |   9 +-
 .../gpu/drm/amd/display/dc/core/dc_state.c    |  77 ++-
 .../gpu/drm/amd/display/dc/core/dc_stream.c   |  13 +-
 .../gpu/drm/amd/display/dc/core/dc_surface.c  |   1 +
 drivers/gpu/drm/amd/display/dc/dc.h           |  30 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  |   1 +
 drivers/gpu/drm/amd/display/dc/dc_dsc.h       |   1 -
 drivers/gpu/drm/amd/display/dc/dc_helper.c    |   1 +
 .../amd/display/dc/dccg/dcn31/dcn31_dccg.c    |   2 +
 .../amd/display/dc/dccg/dcn32/dcn32_dccg.c    |   1 +
 .../amd/display/dc/dccg/dcn35/dcn35_dccg.c    |   2 +
 .../amd/display/dc/dccg/dcn401/dcn401_dccg.c  |   8 +-
 .../amd/display/dc/dccg/dcn42/dcn42_dccg.c    |   1 +
 drivers/gpu/drm/amd/display/dc/dce/dce_abm.c  |   1 +
 .../gpu/drm/amd/display/dc/dce/dce_audio.c    |   3 +
 .../drm/amd/display/dc/dce/dce_clock_source.c |  10 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.c |   1 +
 drivers/gpu/drm/amd/display/dc/dce/dce_i2c.c  |   1 +
 .../gpu/drm/amd/display/dc/dce/dce_i2c_hw.c   |   2 +
 .../gpu/drm/amd/display/dc/dce/dce_i2c_sw.c   |   3 +
 drivers/gpu/drm/amd/display/dc/dce/dce_ipp.c  |   1 +
 .../drm/amd/display/dc/dce/dce_link_encoder.c |   1 +
 .../drm/amd/display/dc/dce/dce_mem_input.c    |   4 +
 drivers/gpu/drm/amd/display/dc/dce/dce_opp.c  |   1 +
 .../amd/display/dc/dce/dce_stream_encoder.c   |   4 +
 .../drm/amd/display/dc/dce/dce_transform.c    |   2 +
 drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c |   4 +-
 .../gpu/drm/amd/display/dc/dce/dmub_abm_lcd.c |   1 +
 .../drm/amd/display/dc/dce/dmub_hw_lock_mgr.c |   2 +-
 .../gpu/drm/amd/display/dc/dce/dmub_replay.c  |   1 +
 .../display/dc/dce110/dce110_mem_input_v.c    |  10 +
 .../amd/display/dc/dce110/dce110_opp_csc_v.c  |   1 +
 .../display/dc/dce110/dce110_opp_regamma_v.c  |   2 +
 .../dc/dce110/dce110_timing_generator.c       |   9 +
 .../dc/dce110/dce110_timing_generator_v.c     |   9 +
 .../display/dc/dce110/dce110_transform_v.c    |   6 +
 .../amd/display/dc/dce112/dce112_compressor.c |   1 +
 .../dc/dce120/dce120_timing_generator.c       |   7 +
 .../display/dc/dce80/dce80_timing_generator.c |   6 +
 .../amd/display/dc/dcn10/dcn10_cm_common.c    |   8 +-
 .../gpu/drm/amd/display/dc/dcn10/dcn10_dwb.c  |   2 +
 .../drm/amd/display/dc/dcn20/dcn20_dwb_scl.c  |   4 +-
 .../amd/display/dc/dcn30/dcn30_cm_common.c    |   4 +-
 .../gpu/drm/amd/display/dc/dcn31/dcn31_apg.c  |   1 +
 .../dc/dio/dcn10/dcn10_stream_encoder.c       |   2 +
 .../dc/dio/dcn314/dcn314_dio_stream_encoder.c |   2 +
 .../dc/dio/dcn32/dcn32_dio_stream_encoder.c   |   2 +
 .../dc/dio/dcn35/dcn35_dio_stream_encoder.c   |   1 +
 .../dc/dio/dcn401/dcn401_dio_stream_encoder.c |   3 +
 .../dc/dio/virtual/virtual_link_encoder.c     |  65 +-
 .../dc/dio/virtual/virtual_stream_encoder.c   | 111 +++-
 .../drm/amd/display/dc/dml/calcs/dcn_calcs.c  |   1 +
 .../drm/amd/display/dc/dml/dcn10/dcn10_fpu.c  |   2 +-
 .../drm/amd/display/dc/dml/dcn20/dcn20_fpu.c  |   3 +-
 .../dc/dml/dcn20/display_mode_vba_20.c        |   4 +
 .../dc/dml/dcn20/display_mode_vba_20v2.c      |   5 +
 .../dc/dml/dcn20/display_rq_dlg_calc_20.c     |   5 +
 .../dc/dml/dcn20/display_rq_dlg_calc_20v2.c   |   5 +
 .../dc/dml/dcn21/display_mode_vba_21.c        |  19 +
 .../dc/dml/dcn21/display_rq_dlg_calc_21.c     |   5 +
 .../drm/amd/display/dc/dml/dcn30/dcn30_fpu.c  |   2 +
 .../dc/dml/dcn30/display_mode_vba_30.c        |  23 +
 .../dc/dml/dcn30/display_rq_dlg_calc_30.c     |   5 +
 .../dc/dml/dcn31/display_mode_vba_31.c        |  24 +
 .../dc/dml/dcn31/display_rq_dlg_calc_31.c     |   8 +
 .../amd/display/dc/dml/dcn314/dcn314_fpu.c    |   6 +-
 .../dc/dml/dcn314/display_mode_vba_314.c      |  24 +
 .../dc/dml/dcn314/display_rq_dlg_calc_314.c   |   8 +
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  |   2 +
 .../dc/dml/dcn32/display_mode_vba_util_32.c   |  23 +
 .../drm/amd/display/dc/dml/dcn35/dcn35_fpu.c  |   8 +-
 .../amd/display/dc/dml/dcn351/dcn351_fpu.c    |   7 +-
 .../drm/amd/display/dc/dml/display_mode_lib.c |   1 +
 .../display/dc/dml/display_rq_dlg_helpers.c   |  14 +
 .../display/dc/dml/dml1_display_rq_dlg_calc.c |   3 +
 .../gpu/drm/amd/display/dc/dml2_0/Makefile    |  74 +--
 .../dml2_0/dml21/dml21_translation_helper.c   |  39 +-
 .../amd/display/dc/dml2_0/dml21/dml21_utils.c |  15 +-
 .../display/dc/dml2_0/dml21/dml21_wrapper.c   | 380 +-----------
 .../display/dc/dml2_0/dml21/dml21_wrapper.h   |  30 -
 .../dc/dml2_0/dml21/dml21_wrapper_fpu.c       | 381 ++++++++++++
 .../dc/dml2_0/dml21/dml21_wrapper_fpu.h       |  60 ++
 .../dml21/src/dml2_dpmm/dml2_dpmm_dcn4.c      |  20 +
 .../dml2_0/dml21/src/dml2_mcg/dml2_mcg_dcn4.c |   9 +-
 .../dml21/src/dml2_mcg/dml2_mcg_dcn42.c       |   9 +-
 .../display/dc/dml2_0/dml2_dc_resource_mgmt.c |  28 +-
 .../amd/display/dc/dml2_0/dml2_mall_phantom.c |   3 +-
 .../dc/dml2_0/dml2_translation_helper.c       |   6 +-
 .../drm/amd/display/dc/dml2_0/dml2_utils.c    |   3 +-
 .../drm/amd/display/dc/dml2_0/dml2_wrapper.c  |  23 +-
 .../amd/display/dc/dml2_0/dml2_wrapper_fpu.c  |   9 +-
 .../drm/amd/display/dc/dpp/dcn10/dcn10_dpp.c  |   1 +
 .../drm/amd/display/dc/dpp/dcn20/dcn20_dpp.c  |  11 +-
 .../amd/display/dc/dpp/dcn20/dcn20_dpp_cm.c   |   1 +
 .../drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c  |   1 +
 .../amd/display/dc/dpp/dcn30/dcn30_dpp_cm.c   |   1 +
 .../amd/display/dc/dpp/dcn401/dcn401_dpp_cm.c |   5 +
 drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c   |  13 +-
 .../drm/amd/display/dc/dsc/dcn20/dcn20_dsc.c  |   2 +-
 .../drm/amd/display/dc/dsc/dcn35/dcn35_dsc.c  |   2 +-
 .../amd/display/dc/dsc/dcn401/dcn401_dsc.c    |   7 +-
 drivers/gpu/drm/amd/display/dc/dsc/dsc.h      |   5 +
 .../drm/amd/display/dc/dwb/dcn30/dcn30_dwb.c  |   1 +
 .../dc/gpio/dcn42/hw_translate_dcn42.c        |   1 +
 .../gpu/drm/amd/display/dc/gpio/hw_factory.c  |   1 +
 drivers/gpu/drm/amd/display/dc/gpio/hw_gpio.c |   1 +
 .../drm/amd/display/dc/gpio/hw_translate.c    |   1 +
 .../display/dc/hubbub/dcn31/dcn31_hubbub.c    |   1 +
 .../display/dc/hubbub/dcn35/dcn35_hubbub.c    |   1 +
 .../display/dc/hubbub/dcn401/dcn401_hubbub.c  |   4 +
 .../display/dc/hubbub/dcn42/dcn42_hubbub.c    |   2 +
 .../amd/display/dc/hubp/dcn10/dcn10_hubp.c    |   2 +
 .../amd/display/dc/hubp/dcn20/dcn20_hubp.c    |   2 +
 .../amd/display/dc/hubp/dcn30/dcn30_hubp.c    |   2 +
 .../amd/display/dc/hubp/dcn35/dcn35_hubp.c    |   1 +
 .../amd/display/dc/hubp/dcn401/dcn401_hubp.c  |   3 +
 .../amd/display/dc/hubp/dcn42/dcn42_hubp.c    |   1 +
 .../amd/display/dc/hwss/dce110/dce110_hwseq.c |  40 +-
 .../amd/display/dc/hwss/dce120/dce120_hwseq.c |   4 +
 .../amd/display/dc/hwss/dcn10/dcn10_hwseq.c   |  23 +-
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   |  13 +-
 .../amd/display/dc/hwss/dcn30/dcn30_hwseq.c   |   5 +-
 .../amd/display/dc/hwss/dcn303/dcn303_hwseq.c |  11 +
 .../amd/display/dc/hwss/dcn31/dcn31_hwseq.c   |   4 +-
 .../amd/display/dc/hwss/dcn314/dcn314_hwseq.c |   1 +
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.c   |   4 +-
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   |   6 +-
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c | 122 ++--
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.h |   3 +-
 .../amd/display/dc/hwss/dcn42/dcn42_hwseq.c   |   6 +-
 .../drm/amd/display/dc/hwss/hw_sequencer.h    |   2 +-
 .../dc/irq/dce110/irq_service_dce110.c        |  12 +-
 .../dc/irq/dce120/irq_service_dce120.c        |   2 +-
 .../display/dc/irq/dce80/irq_service_dce80.c  |  10 +-
 .../display/dc/irq/dcn10/irq_service_dcn10.c  |   5 +-
 .../display/dc/irq/dcn20/irq_service_dcn20.c  |   5 +-
 .../display/dc/irq/dcn21/irq_service_dcn21.c  |   5 +-
 .../display/dc/irq/dcn30/irq_service_dcn30.c  |   5 +-
 .../dc/irq/dcn302/irq_service_dcn302.c        |   7 +-
 .../dc/irq/dcn303/irq_service_dcn303.c        |   5 +-
 .../display/dc/irq/dcn31/irq_service_dcn31.c  |   7 +-
 .../dc/irq/dcn314/irq_service_dcn314.c        |   7 +-
 .../dc/irq/dcn315/irq_service_dcn315.c        |   7 +-
 .../display/dc/irq/dcn32/irq_service_dcn32.c  |   7 +-
 .../display/dc/irq/dcn35/irq_service_dcn35.c  |   7 +-
 .../dc/irq/dcn351/irq_service_dcn351.c        |   7 +-
 .../display/dc/irq/dcn36/irq_service_dcn36.c  |   7 +-
 .../dc/irq/dcn401/irq_service_dcn401.c        |   7 +-
 .../display/dc/irq/dcn42/irq_service_dcn42.c  |   7 +-
 .../display/dc/link/accessories/link_dp_cts.c |   2 +
 .../amd/display/dc/link/hwss/link_hwss_dpia.c |  22 +-
 .../display/dc/link/hwss/link_hwss_hpo_dp.c   |   6 +
 .../link_hwss_hpo_fixed_vs_pe_retimer_dp.c    |   1 +
 .../display/dc/link/hwss/link_hwss_virtual.c  |   6 +
 .../drm/amd/display/dc/link/link_detection.c  |  12 +-
 .../gpu/drm/amd/display/dc/link/link_dpms.c   |   3 +-
 .../drm/amd/display/dc/link/link_validation.c |   1 +
 .../dc/link/protocols/link_dp_training.c      |   2 +
 .../protocols/link_dp_training_128b_132b.c    |   1 +
 .../dc/link/protocols/link_dp_training_dpia.c |   6 +
 .../amd/display/dc/link/protocols/link_dpcd.c |   1 +
 .../drm/amd/display/dc/mpc/dcn30/dcn30_mpc.c  |   6 +-
 .../drm/amd/display/dc/mpc/dcn32/dcn32_mpc.c  |   1 +
 .../drm/amd/display/dc/opp/dcn10/dcn10_opp.c  |   1 +
 .../amd/display/dc/optc/dcn10/dcn10_optc.c    |   4 +
 .../amd/display/dc/optc/dcn20/dcn20_optc.c    |   2 +
 .../amd/display/dc/optc/dcn30/dcn30_optc.c    |   1 +
 .../amd/display/dc/optc/dcn31/dcn31_optc.c    |   1 +
 .../amd/display/dc/optc/dcn314/dcn314_optc.c  |   1 +
 .../amd/display/dc/optc/dcn32/dcn32_optc.c    |   1 +
 .../amd/display/dc/optc/dcn35/dcn35_optc.c    |   1 +
 .../dc/resource/dce100/dce100_resource.c      |   9 +-
 .../dc/resource/dce110/dce110_resource.c      |   6 +
 .../dc/resource/dce112/dce112_resource.c      |   7 +-
 .../dc/resource/dce120/dce120_resource.c      |   3 +-
 .../dc/resource/dce80/dce80_resource.c        |   7 +-
 .../dc/resource/dcn10/dcn10_resource.c        |   5 +-
 .../dc/resource/dcn20/dcn20_resource.c        |  24 +-
 .../dc/resource/dcn21/dcn21_resource.c        |  33 +-
 .../dc/resource/dcn21/dcn21_resource.h        |   3 +-
 .../dc/resource/dcn30/dcn30_resource.c        |   5 +-
 .../dc/resource/dcn301/dcn301_resource.c      |   3 +-
 .../dc/resource/dcn302/dcn302_resource.c      |   3 +-
 .../dc/resource/dcn303/dcn303_resource.c      |   3 +-
 .../dc/resource/dcn31/dcn31_resource.c        |  16 +-
 .../dc/resource/dcn314/dcn314_resource.c      |   6 +-
 .../dc/resource/dcn315/dcn315_resource.c      |  10 +-
 .../dc/resource/dcn316/dcn316_resource.c      |   9 +-
 .../dc/resource/dcn32/dcn32_resource.c        |   2 +-
 .../resource/dcn32/dcn32_resource_helpers.c   |   1 +
 .../dc/resource/dcn321/dcn321_resource.c      |   2 +-
 .../dc/resource/dcn35/dcn35_resource.c        |  15 +-
 .../dc/resource/dcn35/dcn35_resource.h        |   1 +
 .../dc/resource/dcn351/dcn351_resource.c      |  15 +-
 .../dc/resource/dcn36/dcn36_resource.c        |   6 +-
 .../dc/resource/dcn401/dcn401_resource.c      |  32 +-
 .../dc/resource/dcn42/dcn42_resource.c        |  34 +-
 .../dcn42/dcn42_soc_and_ip_translator.c       |   1 +
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |   1 +
 .../gpu/drm/amd/display/dmub/src/dmub_dcn20.c |  20 +-
 .../gpu/drm/amd/display/dmub/src/dmub_dcn30.c |   1 +
 .../gpu/drm/amd/display/dmub/src/dmub_dcn31.c |  23 +-  .../gpu/drm/amd/di=
splay/dmub/src/dmub_dcn32.c |  17 +-  .../gpu/drm/amd/display/dmub/src/dmub=
_dcn35.c |  18 +-
 .../drm/amd/display/dmub/src/dmub_dcn401.c    |  22 +-
 .../gpu/drm/amd/display/dmub/src/dmub_dcn42.c |  24 +-
 .../gpu/drm/amd/display/dmub/src/dmub_reg.c   |   4 +-
 .../gpu/drm/amd/display/dmub/src/dmub_srv.c   |   8 +-
 235 files changed, 2259 insertions(+), 1129 deletions(-)  create mode 1006=
44 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_wrapper_fpu.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_wrapp=
er_fpu.h

--
2.43.0

