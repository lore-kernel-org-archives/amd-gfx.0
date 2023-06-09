Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40FA3C7EE2E
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Jun 2023 19:56:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A3B2A10E08A;
	Fri,  9 Jun 2023 19:56:12 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2085.outbound.protection.outlook.com [40.107.100.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B401C10E08A
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Jun 2023 19:56:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dzXD2v96t8lSnA9ErjUvMEd7v/Y2Fxy0NawmRYSptfTpi13JQ7zA5OmTLmU7G1PZBPQbBdV8EaYALiZGSjtg5Qd4LjQDSs6GdhGakjBLqUQT8E7o2hEfZBcU6/R/okv4NTitZ0Sah6t91uO7pPmOE6/MIndp4p9wMxjCI5s7BaF6Uf+GpbpjcpAz+1LazWY3ss+4u3YOZe49S39yrWyjOA4BFa2bpIhAgn61f0bd+KlcAIWgd+PXaLqNYKnqw7JA0G01/R28NoqFu7tJKWNhIPe0dH9RtT3eQ8yEqMYhVyC5lzKmTpD3inNkGFacdZF9lSGp8AqN6UAcY7MyBE5GVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=loYDah4ubJFsN6GLR5noWnGzP0OE8AIzelVP8hV5TN8=;
 b=kNhJixk8ig5hH/N3aNkR0RQOH8RJqLsPLTNQgidOLN1i1xUJhLLQZcMmdrrZrWMMkKRXlbK4gClhd95lbrKo4Fki7DrmTl2rJyP0+RmzfsLBQgVAAuzuhggdVa/SOzh5ca3NXViLNH6r1NIJyuthlIuyWyfLTlTOgm9AfDKkxC7vnqr5WOjzcbEDVS7dMqidoZYOpf6bY+PMeSF3LIF/yLHYccaMD2VTmGh3TjD9XE1pXgxxnaBMrOl3OvKl4FXU4euWNA1NnkKxhVYxifF60F0exd+uRzMSencx3hb5lIMjZWd+SfPASG/gfujMsjbYvxQuOLIIyKNRPVnZ3m/EpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=loYDah4ubJFsN6GLR5noWnGzP0OE8AIzelVP8hV5TN8=;
 b=wGYuudLLRo9RAKFuEg7MKJ5NHwdWYakujKwvRB5yYf0Z3wbKmga0HgpH6R5J1tfY6DCDLyRBNnvbGgA30SD4FribJtOWYy1olcVbBhD3iNqLed3ZRpvnJq5XPFY96sxUjwQ9uE8iVXfnTmou60QZO7fm94Kx6PH+0KjJ2FWFKMc=
Received: from DS0PR12MB6534.namprd12.prod.outlook.com (2603:10b6:8:c1::19) by
 PH7PR12MB6811.namprd12.prod.outlook.com (2603:10b6:510:1b5::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.33; Fri, 9 Jun 2023 19:56:06 +0000
Received: from DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::20af:1871:5c7d:548d]) by DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::20af:1871:5c7d:548d%5]) with mapi id 15.20.6455.030; Fri, 9 Jun 2023
 19:56:06 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Wang, Chao-kai (Stylon)" <Stylon.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 00/20] DC Patches June 9, 2023
Thread-Topic: [PATCH 00/20] DC Patches June 9, 2023
Thread-Index: AQHZmTnalcF66HA6+0eWfsF3xeKHT6+C3p5Q
Date: Fri, 9 Jun 2023 19:56:06 +0000
Message-ID: <DS0PR12MB6534D672F42F22649F332E3A9C51A@DS0PR12MB6534.namprd12.prod.outlook.com>
References: <20230607121548.1479290-1-stylon.wang@amd.com>
In-Reply-To: <20230607121548.1479290-1-stylon.wang@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=30bcff71-8df9-4ada-95d0-31d07ab489ce;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-06-09T19:56:03Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6534:EE_|PH7PR12MB6811:EE_
x-ms-office365-filtering-correlation-id: 490cb33f-1a96-44d9-bb68-08db69239008
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: k1IJiLxnJ9kkLwDwAJtUBbJ/aRxTgcJT52mShI+j+ZJH94+Nad1bwGRrJLYHJQoYkdqvnY97G7aOeylH5STPHQKjthLpNAsnUnH7TLqBdL8B9Rzo0EcxgiK2o/R6PTet08zDwR6p9t2CAW9grQ9/LVAhX2G+FVzFno/HLakR2WfQjy8wsJSl5F6hxNaIcL0ZRXtDC4NOp/CzFRMAEdl8yuv2Jn2TzImm9UfYqzOvVv9IKExGp9qwXNk+072M2s1H2E7cZH+/zdBR5em648uXg76XcRife4GazzBONWzrXEBilVu06PRl4Ui5opi6WR7eZfWpwlVkfniTSrZueVgyyUBAolrb02T4kTHLFgiTEpj+fSnG3LejdN8f7M6JQiqo7kj1ij3LipCCqkrEwBCJIU0iW0qyNqIs83E6dtv5t2UrpVHP4eVY2mzjkt609+up3PBPVwFfNCzGIHv0IgVZTxjCeRTD5ob6Fg1KwMkWjsUksNZewuWiMYhk+blLrvXTkLs37UpSOhm1+GfDAaZWWdSoSAgKzDD2pVKgF7eg/0dCDaZQDYt1XnxANOSFtHykmzSC4jPJOzFeRCnS2+2bu4NY02ewpDEGSOFtYT6zPO0L6RuZ7418cwvB3saWvKOs
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6534.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(346002)(366004)(39860400002)(396003)(136003)(451199021)(478600001)(2906002)(83380400001)(38070700005)(6506007)(9686003)(53546011)(186003)(26005)(86362001)(122000001)(33656002)(38100700002)(7696005)(55016003)(71200400001)(52536014)(5660300002)(8676002)(8936002)(41300700001)(66446008)(66476007)(4326008)(66556008)(64756008)(76116006)(66946007)(316002)(54906003)(110136005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rcwC5vx1jwod+DahMkg0VfTBDnctqa2yXyn1ZLrZl+DLTPlBvZ/TgM3W6ifn?=
 =?us-ascii?Q?8f7mZ1MjmVx61DOwDe24RU8ji5BXm06XwnO3qd8H3TjdtLN8CCsc9S0cQzUd?=
 =?us-ascii?Q?p4/t+NB38hwYzSACAVqFHjH2Jgld5Fm4IT0D5/oeFRMWXtBASW1X6QhWm81w?=
 =?us-ascii?Q?QC5ZHfZxz8Bz9E59IlxHb8FCB0kkruDEjqEQ3fL9DkpE6Q0lDu/CZwWxELiM?=
 =?us-ascii?Q?9GG2o8Bf057hS4fqdYCB1EIOIKwZPSX2RE0Eo2B+IoRu09/B2EgFEEHclwdX?=
 =?us-ascii?Q?62cFal6zMeVmd6mqIEe5gQttYTq8muUblBXmPiiHUXayZTJ5Gb7omcVk7GPb?=
 =?us-ascii?Q?YZrIqhnux/Actj+Nm9UK7oHcdpJ0neCXzScjTn7buj/RrpDZq3QITZGJwKol?=
 =?us-ascii?Q?uNW7pWPyAfZ4Yl1VEJYpcwSZBDszXxqPhHzDVBIecT/S7tEVbwlcvdQvaVu8?=
 =?us-ascii?Q?zIjKgOdagtWDERa8321CTabM3WjekJC6T7RaMKR9mmtsfeBghCeQ/0DkIWm6?=
 =?us-ascii?Q?llDJ4h7n2LZNkQh3/G9meUDXPa3+Bg3BDhFRWVKmlnXTBqC2VfrH+DCVD7QL?=
 =?us-ascii?Q?qlOcsEGAxhVdR7OkydM3aQl9UPinNKuJ6aHDz9VvCOCs6h979XVuGMzkNNgG?=
 =?us-ascii?Q?pCbUXVwU41jSiey/uve1JIwaT9Mp9QQRFzw3aYt35RUuZ7waBP0+7A5bio3p?=
 =?us-ascii?Q?JbvGAPMUMClrxWXgqrxX3zvgvQ6K/MkE2zhVhARDGtZN73rCMHJeXqFj3yJd?=
 =?us-ascii?Q?5a1ih1Z9UYwGDgJr8g6AvFoQI6oO2DGPYpvV28+VY9R8vZ/FB1PC1vH5L6ey?=
 =?us-ascii?Q?Rvbg4Zj1SsTbzyNWfeWYrn+xKQF4b28eehHpblJd/60BWofGotH6sfO/2TFD?=
 =?us-ascii?Q?on5uTseZDci6hIrHZUblo6jGH4HqlwOXkZ09NkR83W3qtTpAgMp5qctlwkKl?=
 =?us-ascii?Q?sX+fhso2NYV8XJN98dYrG7ACBg0Y6vu8lFQ7maXMptzX1p8704h1rmpYSwD3?=
 =?us-ascii?Q?fbp9piuAngBDe5xC/c8dBOAmWLFNLUJarykde7gPqbsuDvcD15SuuGrBx1Cl?=
 =?us-ascii?Q?UOdonJAW4O2dTYvlL6lAtvjEGO6ZltrSjAUkOmL4WLlJURdHu56QaoyRWUXk?=
 =?us-ascii?Q?PzfYWYF8wsYvTH39sQ8asmED2nyDhiJoj+asbnT0hcuowZ0QHLkdDrLtf51r?=
 =?us-ascii?Q?p0nWhk78+qc+MZUx0GfWHYUIExLIPbjGrH11RhU0rXqrlNkkJ09gVoxwD+KC?=
 =?us-ascii?Q?mkwWHhZgGuNPKB0/j0ALXL99eJ5i2dQSi2ERHg04E8eOD7ZM1fvMavgHIyyy?=
 =?us-ascii?Q?gFqXwHWfluIMC2doShAfVROidS1DkSHfjqKicdZNIthi4SyPJYFwLaocplMw?=
 =?us-ascii?Q?NTEWyv15oDDAgGo3FOUSDkTU6rcnUDhJjr9fsR5B4mqcS0D2Gq5SOZwdjtLv?=
 =?us-ascii?Q?YZL9oOw3h5JJiUfGWV2CpqtWN1E56madTVC6ELqz21HiNM8Qyd4yS9qWwGji?=
 =?us-ascii?Q?Qa0JzwwTwZNWWPQRwmLpkr04KPzy/vK/tRpkxOXJplaHBnzuNrDw/ITrstDO?=
 =?us-ascii?Q?4Fou9XhmUT0c/GicCcU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6534.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 490cb33f-1a96-44d9-bb68-08db69239008
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2023 19:56:06.4301 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Qv7J3tAmd7OGyw05ECXnm06o127qBf8qnOTKpDkVN3Sc8ZVXE80oA6AbKz7kTlwNM+nluIOA7wyet1ffZOeeAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6811
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

The patchset consists of the amd-staging-drm-next branch (Head commit - f54=
a4d03fde5487d27889495854c82624e919d19 drm/amd/display: edp do not add non-e=
did timings) with new patches added on top of it. This branch is used for b=
oth Ubuntu and Chrome OS testing (ChromeOS on a bi-weekly basis).


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
Sent: Wednesday, June 7, 2023 8:15 AM
To: amd-gfx@lists.freedesktop.org
Cc: Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo) <Sunpeng.L=
i@amd.com>; Lakha, Bhawanpreet <Bhawanpreet.Lakha@amd.com>; Siqueira, Rodri=
go <Rodrigo.Siqueira@amd.com>; Pillai, Aurabindo <Aurabindo.Pillai@amd.com>=
; Zhuo, Qingqing (Lillian) <Qingqing.Zhuo@amd.com>; Li, Roman <Roman.Li@amd=
.com>; Lin, Wayne <Wayne.Lin@amd.com>; Wang, Chao-kai (Stylon) <Stylon.Wang=
@amd.com>; Chiu, Solomon <Solomon.Chiu@amd.com>; Kotarac, Pavle <Pavle.Kota=
rac@amd.com>; Gutierrez, Agustin <Agustin.Gutierrez@amd.com>; Wheeler, Dani=
el <Daniel.Wheeler@amd.com>
Subject: [PATCH 00/20] DC Patches June 9, 2023

This DC patchset brings improvements in multiple areas. In summary, we high=
light:

- Improvement on eDP
- PSR bug fixes
- SubVP bug fixes
- Improvements on pipe handling to address potential issues
- Freesync bug fix
- DPIA bug fix
- Fix multi-display issues

Cc: Daniel Wheeler <daniel.wheeler@amd.com>

Alvin Lee (4):
  drm/amd/display: SubVP high refresh only if all displays >=3D 120hz
  drm/amd/display: Re-enable SubVP high refresh
  drm/amd/display: Block SubVP + DRR if the DRR is PSR capable
  drm/amd/display: Include CSC updates in new fast update path

Aric Cyr (2):
  drm/amd/display: Promote DAL to 3.2.238
  drm/amd/display: 3.2.239

Artem Grishin (1):
  drm/amd/display: Bug fix in dcn315_populate_dml_pipes_from_context

Austin Zheng (2):
  drm/amd/display: Add DP2 Metrics
  drm/amd/display: Limit Minimum FreeSync Refresh Rate

Daniel Miess (2):
  drm/amd/display: Re-enable DPP/HUBP Power Gating
  Revert "drm/amd/display: Move DCN314 DOMAIN power control to DMCUB"

Dmytro Laktyushkin (1):
  drm/amd/display: fix pixel rate update sequence

Fangzhi Zuo (1):
  drm/amd/display: Add Error Code for Dml Validation Failure

Hersen Wu (2):
  drm/amd/display: edp do not add non-edid timings
  drm/amd/display: add debugfs for allow_edp_hotplug_detection

Peichen Huang (1):
  drm/amd/display: limit DPIA link rate to HBR3

Saaem Rizvi (1):
  drm/amd/display: Do not disable phantom pipes in driver

Samson Tam (1):
  Revert "drm/amd/display: reallocate DET for dual displays with high
    pixel rate ratio"

Tom Chung (2):
  drm/amd/display: fix the system hang while disable PSR
  drm/amd/display: Fix disbling PSR slow response issue

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  18 +-  .../amd/display/am=
dgpu_dm/amdgpu_dm_debugfs.c |  32 ++++  .../drm/amd/display/dc/core/dc_hw_s=
equencer.c |  70 +++++++
 drivers/gpu/drm/amd/display/dc/dc.h           |   9 +-
 drivers/gpu/drm/amd/display/dc/dc_dp_types.h  |   2 +-
 drivers/gpu/drm/amd/display/dc/dc_types.h     |   1 +
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c |   2 +
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    |  11 --
 .../drm/amd/display/dc/dcn30/dcn30_resource.c |   1 +
 .../amd/display/dc/dcn302/dcn302_resource.c   |   1 +
 .../amd/display/dc/dcn303/dcn303_resource.c   |   1 +
 .../drm/amd/display/dc/dcn314/dcn314_hwseq.c  |  30 +--
 .../drm/amd/display/dc/dcn314/dcn314_hwseq.h  |   4 +-
 .../drm/amd/display/dc/dcn314/dcn314_init.c   |   2 +-
 .../amd/display/dc/dcn314/dcn314_resource.c   |  11 +-
 .../amd/display/dc/dcn315/dcn315_resource.c   |   1 +
 .../drm/amd/display/dc/dcn32/dcn32_hwseq.c    |  11 +-
 .../drm/amd/display/dc/dcn32/dcn32_hwseq.h    |   2 +-
 .../drm/amd/display/dc/dcn32/dcn32_resource.c |   3 +-
 .../drm/amd/display/dc/dcn32/dcn32_resource.h |   4 +
 .../display/dc/dcn32/dcn32_resource_helpers.c | 158 +++++++++++-----
 .../amd/display/dc/dcn321/dcn321_resource.c   |   3 +-
 .../dc/dml/dcn314/display_mode_vba_314.c      |  59 ++++++
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  | 178 +++++++++++-------
 .../amd/display/dc/dml/display_mode_enums.h   |   8 +
 .../gpu/drm/amd/display/dc/inc/hw_sequencer.h |  32 ++++
 .../amd/display/dc/inc/hw_sequencer_private.h |   2 +-
 .../drm/amd/display/dc/link/link_detection.c  |   5 +
 .../amd/display/modules/freesync/freesync.c   |  11 +-
 29 files changed, 493 insertions(+), 179 deletions(-)

--
2.40.1

