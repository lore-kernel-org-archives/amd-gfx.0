Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7D8EC4828D
	for <amd-gfx@archiver.kernel.org>; Mon,  5 Feb 2024 14:09:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F30CB112532;
	Mon,  5 Feb 2024 14:09:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GQnkCu4z";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2072.outbound.protection.outlook.com [40.107.244.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 660E911254C
 for <amd-gfx@lists.freedesktop.org>; Mon,  5 Feb 2024 14:09:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gOfnM9z7aNOp59agyGtQuZtKN+p5SVEjw6jIx+YQPQIlr0CBthX6a9SzmOYe7BiRufBD1BobNrqNCJzbBFxmNNxfnT9jf8Q21VPtrIkifXBwEuKq29WrtqledpsQZJbSGRupxzKe2Lw8ZH414EIvJ8rv6B5EFTIDG26zdebO5UEb/NWrcMUtuZqCH8a3oRH5ZKbgShjiiJ9wMC+/tw7srhlP+sFw+u5f2p9JsSy4EtzvOqw3q6VVYwI1LXk1ep2ywzapf2WEeil6Le0TKqzXQteGDlsRChwuQU1wWNMZ0GGT/fWd8RMf6BfKnzexGZ+PhzO5HVGnwoFPlMkJgZOhGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LdGgLWcAoLqvHLdpiprKddlcD++p6zXih2HfjHOs1JA=;
 b=QICI3OL2vq8AYzSM8J9q2h08lnfdduRK9WkZT6+hFay4/e+h8qhfqziWo3i2BKZ647QwbyRgkZbeyHIucISgzko6T9eMq4lLL5qeiBzz4cx6a9pEg2OH6RlX8atpPRsKrBfSkAQ3Krx64LCd7mmSe/KYf5Tc/OR7WpeHSwbPwI3SYdz/Fs/lKNmryn/ecSmgYMpzZYGvnj7tImhPDaEifTstrO5wF63ximZt8jCnwrOLc8IrAQai1/MKx16J4lgFuR8A+K422TEmlgCWRf/JPS/h3Ur+nbMUTI+tcCtRnnJl1/6F57dde1onmyrOuROTTgg4qaBTHj+KD+lpNKzqQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LdGgLWcAoLqvHLdpiprKddlcD++p6zXih2HfjHOs1JA=;
 b=GQnkCu4zH12vS6LtzX86nLhg13cb7NP1E+Xyai9e1a7NE1L3uheLU03sjBXNuU6xEh3J9w5WsstGH7OzYCiSDobc4IoZR4gciSqOi8uhcQi8D/m9NWANdP5i5pRWzxp/fnqVQ3CbQcOvM6kQXEEc+t2Xk5FDZ/xOZ/m2DQexzM8=
Received: from DS0PR12MB6534.namprd12.prod.outlook.com (2603:10b6:8:c1::19) by
 LV3PR12MB9143.namprd12.prod.outlook.com (2603:10b6:408:19e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.14; Mon, 5 Feb
 2024 14:09:44 +0000
Received: from DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::b6a6:d4b4:bd6:c4f]) by DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::b6a6:d4b4:bd6:c4f%7]) with mapi id 15.20.7270.015; Mon, 5 Feb 2024
 14:09:44 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Mahfooz, Hamza" <Hamza.Mahfooz@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Chung, ChiaHsuan (Tom)" <ChiaHsuan.Chung@amd.com>, "Li, Sun peng (Leo)"
 <Sunpeng.Li@amd.com>, "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>, "Li,
 Roman" <Roman.Li@amd.com>, "Zuo, Jerry" <Jerry.Zuo@amd.com>, "Pillai,
 Aurabindo" <Aurabindo.Pillai@amd.com>, "Wu, Hersen" <hersenxs.wu@amd.com>,
 "Mahfooz, Hamza" <Hamza.Mahfooz@amd.com>, "Lin, Wayne" <Wayne.Lin@amd.com>,
 "Wentland, Harry" <Harry.Wentland@amd.com>, "Gutierrez, Agustin"
 <Agustin.Gutierrez@amd.com>
Subject: RE: [PATCH 00/21] DC Patches January 31, 2024
Thread-Topic: [PATCH 00/21] DC Patches January 31, 2024
Thread-Index: AQHaVIHeaE75Qlho+k2w/3WdyWI817D70E7g
Date: Mon, 5 Feb 2024 14:09:44 +0000
Message-ID: <DS0PR12MB6534FDDD9AE4A94BF7B3C4C49C472@DS0PR12MB6534.namprd12.prod.outlook.com>
References: <20240131201220.19106-1-hamza.mahfooz@amd.com>
In-Reply-To: <20240131201220.19106-1-hamza.mahfooz@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=bcc930e1-6f18-40ac-8c49-d10ef2e36d60;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2024-02-05T14:07:52Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6534:EE_|LV3PR12MB9143:EE_
x-ms-office365-filtering-correlation-id: 8c8a5063-ab9a-423b-fc21-08dc26541a80
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: c2ko3ZMkoQhb+xqL2meCGv0Y1iUhYWkH2LIMiM6taVZEXgnogIIwXFCu4muxxndXATNu+aUPaD1/8WRUAC7MV0uwe8swkSDZzcgrcjHzz8zYpE8/NzVDGbvNC90K/8d2pMBX/Gn5428YaqM9FYkMCPVL4nNoHJjLIMu6DFvot4pQ+QWym4vrSVWeanpWOi3LKeJt0AEnrj5ueuFDozAu5+/L8Ao6WVdzEPPr/kvtUDZFGZAOGHythOnLJDO3Okx5ssZusP13wv1lBG5O8obEfGWHKRb6zCHfYnVde+p8IknzFWDnaDMOyltDITwfLj7Icnail+bA4OMLzn0h7MuPwoyfdIgWllX4/ciowQY+tV+SGSsU5/jPLGUIXBlPJ1JtG5quJL3XuCKK4aEAucHVqTTSssqu2HHJZDrP/RIsqHwEFxaT4joEATPnjEJZ4Rn64Qx0HdFrGtauea6bdvRRyUGluhkMAQKgfzWjwKQX1yBanfUqvYylSwKilO8VqC9+MFhfRGDwYUFj0LRmS0PYV22pBmtWILXN0ZfdYfmqIpubE5mH8lMz/4HC2zA4fJ5LN9ayjEj5N7CoC2HfqKPG6ozzF1G8PUUKHKE5ygr5YEzUgwuSZJOVHKQETO5Iy6ob
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6534.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(376002)(346002)(136003)(39860400002)(366004)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(83380400001)(26005)(2906002)(38100700002)(76116006)(7696005)(110136005)(66476007)(8936002)(4326008)(71200400001)(122000001)(8676002)(478600001)(66556008)(5660300002)(66446008)(66946007)(54906003)(6506007)(64756008)(316002)(52536014)(9686003)(86362001)(53546011)(38070700009)(33656002)(41300700001)(55016003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?FEqxQZOpmfErHSZHOKCSBoCJhx+WlNwFlrBWrGmdZTwg/ao3P0YMknGeTo?=
 =?iso-8859-1?Q?UcPnxACTF4fXRwT71J28ii/RzeH2AwtEv6BNPeZ3WIdhgXs6qrQR+rMkR0?=
 =?iso-8859-1?Q?biEyHbxtVig1oMcp/wCZsSVt8LwlZWR8RKyMctoh3eWYOxIlNUZguQC29N?=
 =?iso-8859-1?Q?lU9HV0oORDH2xe6S5EWPq1TsOKzs/opPELU8M4mX2ZgGtM6fC5aFAB1r5G?=
 =?iso-8859-1?Q?vIa2Xu1bhOtFCgeyrxBSNCikdoHAI84nB6IGn/ocedAcQ63ZTisT4uyxqR?=
 =?iso-8859-1?Q?MGXgzONSD5+2HnmHZu2QpMqFCcylY4eXMV9inOkbHef2BZvC0CP76gKeJv?=
 =?iso-8859-1?Q?XYe/C9011v+hD8dWqmsKK8F+z1Uadu/A58KGTI0k3yJUB9hOXbpMswu4J1?=
 =?iso-8859-1?Q?LLMSRuNaaxGbaP1LH4LhaspSo7QepZeJLTrbkyC+iHuZF7NXPIX8JNjHNr?=
 =?iso-8859-1?Q?+XTO7nc95H6gyljABg28wutlDA3IHDChod/OsClXUENHktOAYAVbB4yT6a?=
 =?iso-8859-1?Q?MRdYGj5aLyNekOrj+jWD95XIFtlV/32DNAh1DWcFetb3dVFnSjvRv2tdMu?=
 =?iso-8859-1?Q?cNSjc5OSTh6542+gdYyJ3zjhWiX/stnZ3yLNcDFAYFte1e+sG6geJ1zUue?=
 =?iso-8859-1?Q?mRCa/ixY6hisWG7W3amiUeC0JhDP21tRrZ4VbB2Gl/lGyRons4kINXbr9b?=
 =?iso-8859-1?Q?zhg34U2fzQZrHVW4qBlNF/Eu5+HDMVXWDsPB+qGHXpZHnS+ppB67LyLwSb?=
 =?iso-8859-1?Q?kzUoFWwR9qO5L2w62exsOSs+7xKlRBpO9L7J9z90BBVk4SUmh2ne/ox2D3?=
 =?iso-8859-1?Q?8fA1BG+QH9REGOubSPp356aGT23SjvIdJcJwEtkiPMbA+txjBS7Wpjt1Rh?=
 =?iso-8859-1?Q?kLaoXxKHmJPPw8TOVa9Rh2sqCjw4CezdFX1qKMshZBHZc1R1ejViLrdPGl?=
 =?iso-8859-1?Q?lTKBDhS9wdoM5eygxOEkG8Ppj3bUojxAsUGCKlaOLjLtGGlWr8DQ/El6jT?=
 =?iso-8859-1?Q?p+yugXq87U4n9Ior0IVXyyk4JFaBHZPX83q95FaeZu+niLMj6aCrMXDsdh?=
 =?iso-8859-1?Q?amwI4lDmZgYiF3GzcEkaofKIAGBqLmgPg3BHxSA9MRUyPnU3sW7kFvDLGr?=
 =?iso-8859-1?Q?xlETM2lnw5P0k6NI4QZtnH7mzMy5rW537IPpNP3bikQmnxOjSS98iLVrp0?=
 =?iso-8859-1?Q?UG/bJmR7nde7mYXWdMXfCYHHPd4/b6zUC+FWiqEIFoo6jO46JU3EVJmFwh?=
 =?iso-8859-1?Q?NZL8YTMto8thLIh9wvvjAjxi2s2pXuF1FVgXOxOCZxz4i7AVKBXxhuFIb9?=
 =?iso-8859-1?Q?5A949Lz07KM7PVYEaBo+Fq74IZG0sgmPxlTW4CixoQZLb5g6ThxENo/K6D?=
 =?iso-8859-1?Q?ycn4e+KsGc/nR2fsUcDltp4zBThtanZT2H1+UStcjY8j0bm60cI8YD40wh?=
 =?iso-8859-1?Q?doHSP8wDxtNlfw8+x4zQO5eoUZO9VvJLHm9Jon6EW/ypktdxW9CYGZVYNd?=
 =?iso-8859-1?Q?Hrqi/t+MgS+wm+EfWAOFIOwTLWqgnXF+6lqH/LCJwjX4TON8yLar1qY99C?=
 =?iso-8859-1?Q?kdWyhQ/tZaO+H+2PKekquHa6Cm9K6yNZp6URiAyNy2EU8ZzK9nCNJ5SHCR?=
 =?iso-8859-1?Q?Kl20RROM55aqA=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6534.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c8a5063-ab9a-423b-fc21-08dc26541a80
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2024 14:09:44.2942 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bGhOsEDAOx+cIFIlRO1yRLnWpoYSzJRoHky2ztMwopAPAYxwsq1Jzb1Etiesa9i7evS79mu1BcWysuNjAPVAbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9143
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

The patchset consists of the amd-staging-drm-next branch (Head commit - 0b4=
8b36f80b0 -> drm/amdgpu: Need to resume ras during gpu reset for gfx v9_4_3=
 sriov) with new patches added on top of it.

Tested on Ubuntu 22.04.3, on Wayland and X11, using KDE Plasma and Gnome.


Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>


Thank you,

Dan Wheeler
Sr. Technologist  |  AMD
SW Display
---------------------------------------------------------------------------=
---------------------------------------
1 Commerce Valley Dr E, Thornhill, ON L3T 7X6
Facebook |  Twitter |  amd.com


-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Hamza Ma=
hfooz
Sent: Wednesday, January 31, 2024 3:11 PM
To: amd-gfx@lists.freedesktop.org
Cc: Chung, ChiaHsuan (Tom) <ChiaHsuan.Chung@amd.com>; Li, Sun peng (Leo) <S=
unpeng.Li@amd.com>; Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>; Li, Roman=
 <Roman.Li@amd.com>; Zuo, Jerry <Jerry.Zuo@amd.com>; Pillai, Aurabindo <Aur=
abindo.Pillai@amd.com>; Wu, Hersen <hersenxs.wu@amd.com>; Mahfooz, Hamza <H=
amza.Mahfooz@amd.com>; Lin, Wayne <Wayne.Lin@amd.com>; Wentland, Harry <Har=
ry.Wentland@amd.com>; Gutierrez, Agustin <Agustin.Gutierrez@amd.com>
Subject: [PATCH 00/21] DC Patches January 31, 2024

This version brings along the following:
* DCN35 fixes
* DMUB fixes
* Link training fixes
* Misc code style fixes
* MST fixes
* ODM fixes
* SubVP fixes

Allen Pan (1):
  drm/amd/display: correct static screen event mask

Alvin Lee (2):
  Revert "drm/amd/display: For FPO and SubVP/DRR configs program
    vmin/max sel"
  drm/amd/display: Update phantom pipe enable / disable sequence

Aric Cyr (1):
  drm/amd/display: 3.2.271

Camille Cho (1):
  drm/amd/display: correct comment in set_default_brightness_aux()

Ethan Bitnun (2):
  drm/amd/display: Add delay before logging clks from hw
  drm/amd/display: Adjust set_p_state calls to fix logging

Fangzhi Zuo (1):
  drm/amd/display: Fix MST Null Ptr for RV

George Shen (2):
  drm/amd/display: Add debug option to force 1-tap chroma subsampling
  drm/amd/display: Add left edge pixel for YCbCr422/420 + ODM pipe split

Michael Strauss (2):
  drm/amd/display: Remove Legacy FIXED_VS Transparent LT Sequence
  drm/amd/display: Don't perform rate toggle on DP2-capable FIXED_VS
    retimers

Nicholas Kazlauskas (4):
  drm/amd/display: Add more checks for exiting idle in DC
  drm/amd/display: Disable timeout in more places for dc_dmub_srv
  drm/amd/display: Increase eval/entry delay for DCN35
  drm/amd/display: Disable idle reallow as part of command/gpint
    execution

Rodrigo Siqueira (4):
  drm/amd/display: Drop legacy code
  drm/amd/display: Disable ODM by default for DCN35
  drm/amd/display: Trivial code style adjustment
  drm/amd/display: Drop some unnecessary guards

Wenjing Liu (1):
  drm/amd/display: set odm_combine_policy based on context in dcn32
    resource

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  12 +-
 .../amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c |   2 -
 .../dc/clk_mgr/dcn21/rn_clk_mgr_vbios_smu.c   |   4 -
 .../display/dc/clk_mgr/dcn301/dcn301_smu.c    |   4 -
 .../amd/display/dc/clk_mgr/dcn31/dcn31_smu.c  |   4 -
 .../display/dc/clk_mgr/dcn314/dcn314_smu.c    |   6 -
 .../display/dc/clk_mgr/dcn315/dcn315_smu.c    |   4 -
 .../display/dc/clk_mgr/dcn316/dcn316_smu.c    |   4 -
 .../display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c  |   2 +
 .../dc/clk_mgr/dcn32/dcn32_clk_mgr_smu_msg.h  |   3 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 115 +++---
 .../gpu/drm/amd/display/dc/core/dc_resource.c |  68 ++--
 .../gpu/drm/amd/display/dc/core/dc_stream.c   |  18 +
 .../gpu/drm/amd/display/dc/core/dc_surface.c  |   2 +
 drivers/gpu/drm/amd/display/dc/dc.h           |   9 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  |  17 +-
 drivers/gpu/drm/amd/display/dc/dc_hw_types.h  |   2 -
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |   2 +
 .../gpu/drm/amd/display/dc/dcn10/dcn10_opp.c  |   7 +
 .../display/dc/dcn32/dcn32_resource_helpers.c |  14 +
 drivers/gpu/drm/amd/display/dc/dm_cp_psp.h    |   3 +
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  |  26 +-
 .../amd/display/dc/hwss/dce110/dce110_hwseq.c |   4 +-
 .../amd/display/dc/hwss/dce110/dce110_hwseq.h |   4 +
 .../amd/display/dc/hwss/dcn10/dcn10_hwseq.c   |   2 +-
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   |  17 +-
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.h   |   4 +
 .../amd/display/dc/hwss/dcn31/dcn31_hwseq.c   |   2 -
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.c   |  76 +++-
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.h   |   2 +
 .../amd/display/dc/hwss/dcn32/dcn32_init.c    |   3 +
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   |  21 +-
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.h   |   3 +
 .../amd/display/dc/hwss/dcn35/dcn35_init.c    |   2 +-
 .../amd/display/dc/hwss/dcn351/dcn351_init.c  |   2 +-
 .../drm/amd/display/dc/hwss/hw_sequencer.h    |   1 +
 .../display/dc/hwss/hw_sequencer_private.h    |   9 +-
 .../gpu/drm/amd/display/dc/inc/core_types.h   |   2 +
 drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h  |   2 -
 .../amd/display/dc/inc/hw/timing_generator.h  |   2 -
 drivers/gpu/drm/amd/display/dc/inc/resource.h |  27 +-
 .../drm/amd/display/dc/link/link_validation.c |   2 -
 .../dc/link/protocols/link_dp_training.c      |   5 +-
 .../link_dp_training_fixed_vs_pe_retimer.c    | 372 +-----------------
 .../link_dp_training_fixed_vs_pe_retimer.h    |   5 -
 .../link/protocols/link_edp_panel_control.c   |   2 +-
 .../dc/resource/dcn31/dcn31_resource.c        |   2 -
 .../dc/resource/dcn32/dcn32_resource.c        |  18 +-
 .../dc/resource/dcn32/dcn32_resource.h        |   3 +
 .../dc/resource/dcn321/dcn321_resource.c      |   2 +-
 .../dc/resource/dcn35/dcn35_resource.c        |   6 +-
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h   |   1 -
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |  11 -
 .../gpu/drm/amd/display/dmub/src/dmub_dcn32.c |   2 -
 54 files changed, 372 insertions(+), 572 deletions(-)

--
2.43.0

