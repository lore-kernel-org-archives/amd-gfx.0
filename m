Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F393C433FE
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Sep 2022 14:01:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9FB7A10ED11;
	Fri, 30 Sep 2022 14:01:24 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2083.outbound.protection.outlook.com [40.107.101.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9EFB510ED11
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Sep 2022 14:01:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X9KMOMGkep0wEmFA8fDPlvZvyDalUtGXKpCv3iV6KTdGWvPCd1hWJmqCXOQ4udS+MiwrQImOHy8BNFbDdWu6wCf+dFyrtNcOGr5t7xUTPQjrBYA71At+xSijXZ7r5lAI4ywSzts2Sp/jQUua4QmzgegG8xnBMgdBqheEgwHRfKOjBaiDEx7S5o91OEdeM8gSZ6RiMXJBiurYH3Vxjw9uJBav5ugza2VHV04NGPGYpzWYkf4qVqhIiUUM8B4VclZvFWxrspF4SLl9SCr2HnnIQN9JDH7og4xb8FI6TYSE4ku7YqXQq0qhGNSc3YyfBLFWYE7W+GNN3nyHbt/nry772A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q/up2OIhWQaq02TyJZfyVq5CacDYKEsOdhHVW/FLR8E=;
 b=TJE1H1jzzq60dA7a+uUgKs31MzympaznqpYttcSi+PVTRdxMkrAOBdZ3ETg6C+b6tYskqE1eb8Q2XadBkTNaHf9+hMJkbPFTTmjKvZJwulOxY48My7vVxg6moCQbSm3bF0UPdE9lgl8SgZ3v0JePIJjcbzQl6Z+XR+s4mMnA0xrHrsZokdvmTs7Gyg8sFf7HQ/7iDJKETygh7lbOfnKI0zmUMbCcHyEMV+QcgXg50/AwPfg3PUd431IT3tBSCHkPJ0YQPAskcYKQwbb9dThW4FgnqBP0du+8tdBrIwjmxD9D2KgtJO2VWgebL1hQfbp/OrV1IdSFkp9P3BlYWhb6LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q/up2OIhWQaq02TyJZfyVq5CacDYKEsOdhHVW/FLR8E=;
 b=ERGQ7Nz0ezmYltiIXw4XwlCeLt431Fm7s1aIQ5zEo0peycm2Z55lJS79DOIsaH5XiCc7kMInfRHyqJJsC3PDzefPLVpeh0Yc+q0OS5/D0C1VPLp9Nib7anRokZO1sEmA/JMcSjHcoIWlVaCYYDU3eenDXeMs6HJA21SEKxs1nSg=
Received: from DS0PR12MB6534.namprd12.prod.outlook.com (2603:10b6:8:c1::19) by
 MN2PR12MB4048.namprd12.prod.outlook.com (2603:10b6:208:1d5::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5676.23; Fri, 30 Sep 2022 14:01:20 +0000
Received: from DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::b0d1:610:e802:5738]) by DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::b0d1:610:e802:5738%3]) with mapi id 15.20.5654.024; Fri, 30 Sep 2022
 14:01:20 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Mahfooz, Hamza" <Hamza.Mahfooz@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 00/36] DC Patches September 26, 2022
Thread-Topic: [PATCH 00/36] DC Patches September 26, 2022
Thread-Index: AQHY03IyCu9TqmNe5UW/8NoK2ohL3K34A0UA
Date: Fri, 30 Sep 2022 14:01:20 +0000
Message-ID: <DS0PR12MB65341AA62DDE31ECFC4FDAC59C569@DS0PR12MB6534.namprd12.prod.outlook.com>
References: <20220928194028.144879-1-hamza.mahfooz@amd.com>
In-Reply-To: <20220928194028.144879-1-hamza.mahfooz@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=89984091-61bd-4c00-a0de-3fe945e4552a;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-09-30T14:01:05Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6534:EE_|MN2PR12MB4048:EE_
x-ms-office365-filtering-correlation-id: e79dc85a-4311-4a9a-f3fa-08daa2ec409e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: W3lSWsyEOCOwGHDS/ezSj1hnSSFqtNVeeHZ1zyw/E5Zbc7HBt4P5e/87WkwFKadoLpCiOe+OSyxvbyqtaGwynZBLFoeNYdcQySAv975qj0rj4lCHEk/hHxckkDmRA5lN/oEFd2Ysh9XiranakgT3zzt5Vimn0+o8XI1pkUBesLu98dj4Yw4wkWjWS30su4FiSX4nkUOnX8+ZgICnFffifUrUw2q+V02ow/6WW+h2KjzxT4qiG09D1EkHwYxmlkWGiby4DYghzqyRfe5dpPlSuiC9kHyJ5WFNXLSimKKrZuOBVFIaevlOySMxTau2oKYVAjR4nPGGEbQu5EvI/7yaUkO8hAJqbdHBqqoLj2ObxqFWsdm1PdE3kUgQcNXwLwgtPnTydHYSSsGJujZa8/5cikKiRLDaGP9EYLbrMXQ2PcVu2pItHIcrNU6Kqdj8obdTjDqm3/+pWWwiBeTUSHaOW3hPpUrKvuaJc/BwTvtbbV+XAYZ+CJZTVivUK3qnIyPF2emjXEaz3eT6mxs/6jEinxcsUqlK9SwTV2kBNQm7LbOWuxEyEuy17OwUFdCpBGoGkk3fO7kZcBtrEftQV3KwtOiUP+o+we5hKEBW0/PAB/ExniFVZ6pCbInnuSFZG86iUAljfH5mISNlJmUonCL8d0zMRnN7c4dJEDncBscVjaG3XeODRUQl7oK4q7v03LRoGHmJPdM0a2sy7K7mFK0ZMPZ4x1IpgLkxbSiPIB6m1o7YV9LliibHRJep6Bu8jQjWc4WRJkW/qSFM4+jfuzVtNQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6534.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(396003)(136003)(39860400002)(366004)(376002)(451199015)(53546011)(7696005)(316002)(38070700005)(6506007)(8676002)(4326008)(76116006)(66946007)(9686003)(55016003)(66556008)(66476007)(66446008)(64756008)(186003)(26005)(71200400001)(86362001)(478600001)(83380400001)(122000001)(110136005)(54906003)(8936002)(33656002)(38100700002)(52536014)(66899015)(5660300002)(41300700001)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1S6+1qSPKLOryUgcSZK9mUEOCpzEAfWR0YXOyevM1tKgphfzA00SvFFxr5sy?=
 =?us-ascii?Q?7d7uT3WyKrNdM3MfVjy3uw9bwdS44H1QBGP6/dRF/skUGnnWVBagMbI2y965?=
 =?us-ascii?Q?9OHxzVnm7e0472VnBqXTwVbrOeLLX8EENMYsIcElKdgBcK0obVIcgEKdoHOF?=
 =?us-ascii?Q?ZX+6aJie9+9NFxwDeSuF/BT6wiVxzai1Q7bbiv/D5J02Ggg8lvKc04S4t0Rs?=
 =?us-ascii?Q?7yl6MOENkKuPSDWFFybUPQK3qLbbIWouDwVGuIaxm1nBvXwZAeMC3I6h6kpU?=
 =?us-ascii?Q?S94b3ZM7MML9HS5wNQC+Xxrk8KVdpaP9dH3uualeO12hj1s05p+GRCfzzGaI?=
 =?us-ascii?Q?DUbXYJhLTrPaJaPRsYqViz0h4ZZzM7hapOTkr3IY6SRpieVxDYT9INlxIa3Q?=
 =?us-ascii?Q?r+gPJHz3OdvDH422gTpBOvVWJR5LgJ39lDLOUF3Iki0eEHmVaAA9uX9QQxsp?=
 =?us-ascii?Q?4EQUQB5qBGDVG4ilRastMT/gEpg+2c5cj94KQqWL5+ujRrsBXTCDSWlhp6wJ?=
 =?us-ascii?Q?sXtrg5u+RUgFia2QD9OpH2fdjQRfZsMKBk4FPuBNUA3cB+k49sEIlIyMvESv?=
 =?us-ascii?Q?uhr1RqbzFJz8KuvkC2ZyELVX6i1exnBSrVCHPGgldoYxUH3UEIv9IijwRKiC?=
 =?us-ascii?Q?AavD90BqLYh3o+/lcgMmdBZTiCW7cZteRf3ege+qaOurBs/RPxV10zcWtNhD?=
 =?us-ascii?Q?zr0oyYogIWqiDrJVpMxi3POAb/KimwLWf0BJnWG6DcgzFmVR9Dp9GULURRLb?=
 =?us-ascii?Q?Ea4Z+aGtuC8W98o8hdgXFl7uZ0/hqPSbsO8y02elfge2DB6R5XcrIZXMB9i2?=
 =?us-ascii?Q?Ixtj7qUfw8OuURnqecI/PvHkNHiSXN7Abp3R2IcFOwI1bEB5yLbaxvTIr4Mj?=
 =?us-ascii?Q?Px+aOkLqENSo8BtK2An1F84cUOT8uUYdrOTywobfMQ/rVG4oWVaME/pvJECz?=
 =?us-ascii?Q?H8NuFDnY6LQur4l21gwEiiXm8VzxrBP51llzjRwSTF4qYH7L/SrL5EhrPOkN?=
 =?us-ascii?Q?Ucz39o4qK39S/amkjGvC9xgg8HPYlwfCqBEy7rqlbibYHA9pOGLHTiF3dGFt?=
 =?us-ascii?Q?IBIWxzcuocw4Q0qbu4EEX1vus3tv/BFx8kihx1gexUdCXpD9VdBXl0jLsEKR?=
 =?us-ascii?Q?69uFnWtYfJEbt4Du5QlqsjuGVZ6+QuE2tY4yjWUThDgFsCvE+k+y9afOylz4?=
 =?us-ascii?Q?ZIZguT7F9ZJfutMrbdpb9EGjoTHMusmYLIoqqc46Dk8TRgUi+qlK+VjktbVY?=
 =?us-ascii?Q?s3WYWw86kqB7jH+sM6wKM390DGeIqhiaIY/3BB4vBdiOeJr/t9wPFw22TNjf?=
 =?us-ascii?Q?ATBoVt/mPiu1yvro4+UIwuMDH7lYWQGVmH+bfjJmnyShNmHWpRKfasxP4HLu?=
 =?us-ascii?Q?A9mYTRhABRQHLBaUtRBHEfvzfGxVmFOYn42VmT/1TbgJYF7i7D/BtW8udOxA?=
 =?us-ascii?Q?JyHgNh4cBF54zqxOMTRNo2I9csVsGDCP6nq4hgLsMVKN8EZFyj12igo3UZik?=
 =?us-ascii?Q?QJr5E7tuzNPdJetA0Zz0g++l0LPykY8eKtHYq/gw/kkXCNzu6+D9gNP4uzfP?=
 =?us-ascii?Q?RoYhGMBfWxnWHO9D1V8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6534.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e79dc85a-4311-4a9a-f3fa-08daa2ec409e
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2022 14:01:20.6174 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2PThn2CMMBkvneCQvWwVqR9ILNu0LzrNCKTHnodkg8i6BXKi/TCy2Lm9XfyIlqFYUa4zr61H36s56RyTDaJDGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4048
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
Cc: "Wang, Chao-kai \(Stylon\)" <Stylon.Wang@amd.com>, "Li,
 Sun peng \(Leo\)" <Sunpeng.Li@amd.com>, "Wentland,
 Harry" <Harry.Wentland@amd.com>, "Zhuo,
 Qingqing \(Lillian\)" <Qingqing.Zhuo@amd.com>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>, "Li, Roman" <Roman.Li@amd.com>, "Chiu, 
 Solomon" <Solomon.Chiu@amd.com>, "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>,
 "Lin, Wayne" <Wayne.Lin@amd.com>, "Lakha,
 Bhawanpreet" <Bhawanpreet.Lakha@amd.com>, "Gutierrez,
 Agustin" <Agustin.Gutierrez@amd.com>, "Kotarac, Pavle" <Pavle.Kotarac@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Hi all,

This week this patchset was tested on the following systems:

HP Envy 360, with Ryzen 5 4500U
Lenovo Thinkpad T14s Gen2, with AMD Ryzen 5 5650U
Sapphire Pulse RX5700XT
Reference AMD RX6800
Engineering board with Ryzen 9 5900H

These systems were tested on the following display types:
eDP, (1080p 60hz [4500U, 5650U, 5900H])
VGA and DVI (1680x1050 60HZ [DP to VGA/DVI, USB-C to DVI/VGA])
DP/HDMI/USB-C (1440p 170hz, 4k 60hz, 4k 144hz [Includes USB-C to DP/HDMI ad=
apters])

MST tested with Startech MST14DP123DP and 2x 4k 60Hz displays
DSC tested with Cable Matters 101075 (DP to 3x DP), and 201375 (USB-C to 3x=
 DP) with 3x 4k60 displays

The testing is a mix of automated and manual tests. Manual testing includes=
 (but is not limited to):
Changing display configurations and settings
Benchmark testing
Feature testing (Freesync, etc.)

Automated testing includes (but is not limited to):
Script testing (scripts to automate some of the manual checks)
IGT testing

The patchset consists of the amd-staging-drm-next branch (Head commit - 9ab=
6a2850b486e5883418544eb5dc4012343744b -> drm/amd/display: Refactor LTTPR mo=
de selection) with new patches added on top of it. This branch is used for =
both Ubuntu and Chrome OS testing (ChromeOS on a bi-weekly basis).


Tested on Ubuntu 22.04

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
From: Mahfooz, Hamza <Hamza.Mahfooz@amd.com>
Sent: September 28, 2022 3:40 PM
To: amd-gfx@lists.freedesktop.org
Cc: Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo) <Sunpeng.L=
i@amd.com>; Lakha, Bhawanpreet <Bhawanpreet.Lakha@amd.com>; Siqueira, Rodri=
go <Rodrigo.Siqueira@amd.com>; Pillai, Aurabindo <Aurabindo.Pillai@amd.com>=
; Zhuo, Qingqing (Lillian) <Qingqing.Zhuo@amd.com>; Li, Roman <Roman.Li@amd=
.com>; Lin, Wayne <Wayne.Lin@amd.com>; Wang, Chao-kai (Stylon) <Stylon.Wang=
@amd.com>; Chiu, Solomon <Solomon.Chiu@amd.com>; Kotarac, Pavle <Pavle.Kota=
rac@amd.com>; Gutierrez, Agustin <Agustin.Gutierrez@amd.com>; Mahfooz, Hamz=
a <Hamza.Mahfooz@amd.com>; Wheeler, Daniel <Daniel.Wheeler@amd.com>
Subject: [PATCH 00/36] DC Patches September 26, 2022

This DC patch-set brings improvements in multiple areas. In summary, we
highlight:

* ILR improvements;
* PSR fixes;
* DCN315 fixes;
* DCN32 fixes;
* ODM fixes;
* DSC fixes;
* SubVP fixes.

Cc: Daniel Wheeler <daniel.wheeler@amd.com>

Alvin Lee (3):
  drm/amd/display: Block SubVP if rotation being used
  drm/amd/display: Disable GSL when enabling phantom pipe
  drm/amd/display: For SubVP pipe split case use min transition into MPO

Aric Cyr (3):
  Revert "drm/amd/display: correct hostvm flag"
  drm/amd/display: Fix vupdate and vline position calculation
  drm/amd/display: 3.2.206

Charlene Liu (1):
  drm/amd/display: prevent S4 test from failing

Dillon Varone (4):
  drm/amd/display: Program SubVP in dc_commit_state_no_check
  drm/amd/display: Reorder FCLK P-state switch sequence for DCN32
  drm/amd/display: Increase compbuf size prior to updating clocks
  drm/amd/display: Fix merging dynamic ODM+MPO configs on DCN32

Dmytro Laktyushkin (2):
  drm/amd/display: add dummy pstate workaround to dcn315
  drm/amd/display: fix dcn315 dml detile overestimation

Eric Bernstein (1):
  drm/amd/display: Fix disable DSC logic in ghe DIO code

George Shen (1):
  drm/amd/display: Add missing SDP registers to DCN32 reglist

Ian Chen (1):
  drm/amd/display: Refactor edp ILR caps codes

Iswara Nagulendran (1):
  drm/amd/display: Allow PSR exit when panel is disconnected

Leo (Hanghong) Ma (1):
  drm/amd/display: AUX tracing cleanup

Leo Chen (1):
  drm/amd/display: Add log for LTTPR

Leung, Martin (1):
  drm/amd/display: unblock mcm_luts

Lewis Huang (1):
  drm/amd/display: Keep OTG on when Z10 is disable

Martin Leung (1):
  drm/amd/display: block odd h_total timings from halving pixel rate

Rodrigo Siqueira (10):
  drm/amd/display: Drop unused code for DCN32/321
  drm/amd/display: Update DCN321 hook that deals with pipe aquire
  drm/amd/display: Fix SubVP control flow in the MPO context
  drm/amd/display: Remove OPTC lock check
  drm/amd/display: Adding missing HDMI ACP SEND register
  drm/amd/display: Add PState change high hook for DCN32
  drm/amd/display: Enable 2 to 1 ODM policy if supported
  drm/amd/display: Disconnect DSC for unused pipes during ODM transition
  drm/amd/display: update DSC for DCN32
  drm/amd/display: Minor code style change

Wenjing Liu (3):
  drm/amd/display: fix integer overflow during MSA V_Freq calculation
  drm/amd/display: write all 4 bytes of FFE_PRESET dpcd value
  drm/amd/display: Add missing mask sh for SYM32_TP_SQ_PULSE register

Zhikai Zhai (1):
  drm/amd/display: skip commit minimal transition state

 .../display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c  | 44 ++++-----
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 91 ++++++++++++++++++-
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 11 ++-  .../gpu/drm/amd/di=
splay/dc/core/dc_link_dp.c  | 70 ++++++++------
 drivers/gpu/drm/amd/display/dc/dc.h           |  3 +-
 drivers/gpu/drm/amd/display/dc/dc_link.h      |  4 +
 drivers/gpu/drm/amd/display/dc/dce/dce_aux.c  | 13 +--  .../amd/display/dc=
/dcn10/dcn10_hw_sequencer.c | 60 +++++-------  .../gpu/drm/amd/display/dc/d=
cn10/dcn10_optc.c | 11 ---  .../gpu/drm/amd/display/dc/dcn10/dcn10_optc.h |=
  1 -
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    | 25 +----
 .../drm/amd/display/dc/dcn21/dcn21_hubbub.c   |  8 +-
 .../drm/amd/display/dc/dcn21/dcn21_resource.c | 13 ++-  .../gpu/drm/amd/di=
splay/dc/dcn30/dcn30_optc.c |  1 -  .../drm/amd/display/dc/dcn30/dcn30_reso=
urce.c |  4 +
 .../dc/dcn31/dcn31_hpo_dp_stream_encoder.c    |  4 +-
 .../gpu/drm/amd/display/dc/dcn31/dcn31_optc.c |  1 -  .../drm/amd/display/=
dc/dcn31/dcn31_resource.c | 15 ++-
 .../amd/display/dc/dcn314/dcn314_resource.c   | 13 ++-
 .../amd/display/dc/dcn315/dcn315_resource.c   | 15 ++-
 .../amd/display/dc/dcn316/dcn316_resource.c   | 13 ++-
 .../display/dc/dcn32/dcn32_dio_link_encoder.c |  7 --  .../display/dc/dcn3=
2/dcn32_dio_link_encoder.h |  4 -
 .../dc/dcn32/dcn32_dio_stream_encoder.c       | 57 +++++++-----
 .../dc/dcn32/dcn32_dio_stream_encoder.h       |  3 +
 .../dc/dcn32/dcn32_hpo_dp_link_encoder.h      |  1 +
 .../drm/amd/display/dc/dcn32/dcn32_hubbub.c   |  1 +
 .../gpu/drm/amd/display/dc/dcn32/dcn32_hubp.c |  5 +-
 .../drm/amd/display/dc/dcn32/dcn32_hwseq.c    | 37 +++++---
 .../drm/amd/display/dc/dcn32/dcn32_resource.c | 24 +++++  .../drm/amd/disp=
lay/dc/dcn32/dcn32_resource.h | 22 +++++  .../display/dc/dcn32/dcn32_resour=
ce_helpers.c | 88 ++++++++++++++++++
 .../dc/dcn321/dcn321_dio_link_encoder.c       |  1 -
 .../amd/display/dc/dcn321/dcn321_resource.c   |  4 +-
 .../drm/amd/display/dc/dml/dcn31/dcn31_fpu.c  | 91 +++++--------------  ..=
./drm/amd/display/dc/dml/dcn31/dcn31_fpu.h  |  1 +
 .../dc/dml/dcn31/display_mode_vba_31.c        | 15 +++
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  |  8 +-
 .../dc/dml/dcn32/display_mode_vba_32.c        | 19 ++--
 .../drm/amd/display/dc/dml/display_mode_lib.c |  1 +  .../drm/amd/display/=
dc/dml/display_mode_lib.h |  1 +
 .../gpu/drm/amd/display/dc/inc/core_types.h   |  2 +-
 .../amd/display/dc/inc/hw/timing_generator.h  |  1 -
 43 files changed, 522 insertions(+), 291 deletions(-)

--
2.37.2

