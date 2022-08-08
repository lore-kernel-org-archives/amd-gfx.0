Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 597C3C25B0C
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Aug 2022 15:38:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B54B10E351;
	Mon,  8 Aug 2022 15:38:23 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2069.outbound.protection.outlook.com [40.107.95.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E938610E351
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Aug 2022 15:38:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S7hsvSn0iGrFiNBKu76Vyuq3Vwn28zHG7Ay/vfhD2Bi09rud4eHm/JdlbgICn81v5mT/VMZDWaqZlKgJ4VMEEWocLfa8DYo430ZBjJYEtzar64DuYGl3d76ubwq/qY4PqFZuLwdQCL4ySIJhrRyt9OZkjqNwCvFz29/y6rN3AWwEY4Gzu5K5jzV0mBAwMkpVlgLxWaOPqPB+ny8RglxmwBpW1RdO6a5VlE8YJkI2jrRTMIXkJnBLPWx7WIlT0gEtLCQGe/jh/FNdxsaMq4GaGL+DXbHKICrOI9lHsWx954YH3XBWMSMs/b948fcQPjrYIze/no8DbvQv9Ad3IzQ05A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5TH33UxeOpzDJqH5cEnzauO3tWI4iBurWgliSG5UcRw=;
 b=bcsAhY5v2/C2gpJ4gyRn31skipthZITpjjj1X9UBbCkskgzWJw5xoDoUgCCRO9/HxCRuHrC0jCrCgI7X1qVJCJ03nIHH+GOQ6XDqW+hNyHPfoTiWRBJbWOyMWNHT3nBvlqDUsptRkbDXlakaP2pj4MzYOHSc3XRXS26k31V8swbB68CMWvingo6yd5m5dLrWpJgd1FFn5yAqHJlxazGmta4dJdTHvyIyofvAgqPLLdYllDmuBIYhgCjQp4P5swbpPQz38x3cztAVvP1Q1AKmm5EEUcaWYQrgGIVjA8LjJluFfcjfbhm+dx80TPLk19FplAxN4wY7CqR4S4PwWA4mgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5TH33UxeOpzDJqH5cEnzauO3tWI4iBurWgliSG5UcRw=;
 b=BEUU4qSoGynFruyip5oixbFsBuRI5BlkFkO2N74cx7p2YtuaO4y/Z1AkDz+zkQw79YJwy+mdG9zqPeGFpQsGl9Jelog9xH71RdUXp8Jl6RPBl4tQHeGpGH3kngOByAvHhcgy7glqIzy9bsqN6JjNYgnHDcZhiLY7iH236ich5+U=
Received: from DS0PR12MB6534.namprd12.prod.outlook.com (2603:10b6:8:c1::19) by
 CY5PR12MB6478.namprd12.prod.outlook.com (2603:10b6:930:35::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5504.20; Mon, 8 Aug 2022 15:38:13 +0000
Received: from DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::cdf9:a98e:ade:43f7]) by DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::cdf9:a98e:ade:43f7%9]) with mapi id 15.20.5504.015; Mon, 8 Aug 2022
 15:38:13 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Chung, ChiaHsuan (Tom)" <ChiaHsuan.Chung@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 00/32] DC Patches July 29 2022
Thread-Topic: [PATCH 00/32] DC Patches July 29 2022
Thread-Index: AQHYqPUHcWKqlK8ReUi9XMOAVcKFRa2lJptQ
Date: Mon, 8 Aug 2022 15:38:13 +0000
Message-ID: <DS0PR12MB6534C5D24DC874F92C84C9899C639@DS0PR12MB6534.namprd12.prod.outlook.com>
References: <20220805175826.2992171-1-chiahsuan.chung@amd.com>
In-Reply-To: <20220805175826.2992171-1-chiahsuan.chung@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-08-08T15:38:12Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=e27eec3a-35b3-4c82-8065-7756e1fa1f66;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-08-08T15:38:12Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: ac069b2d-60d6-418b-af6c-fe220e0b4054
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4e62fbd5-6f29-4dba-cb74-08da79540196
x-ms-traffictypediagnostic: CY5PR12MB6478:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OT3YeP92qwNX5hsH6ktigpigIofbocA6fyuwuMkWZDjrYqAtT1E4TGaFl3NvK+hgiJhHZKiuX/m5acXJzbTNz7Nb1qURSctOLQN0OB/W5oTeG8L3yW2MToNAigEFxkgA3USW8kZx2uROZgjKFw7ANHY5yiPVUL7NsRH71LsgXnNFeimiXKa41EdvNGxbBUVPvGqnSCeRRiDsOFKb93T9Ne57ch5U/C3g9kKrQXQL06yCqAUFozCUXhjGcT5RJxUOHLtD8jIpsi7k/woo4WlBbPgNBbRRgIPugt2k8EfT5C9srVXZdoQ9wM1ArAiysBe0EzEhLi0gMLvw1KCDQxf3ypiIdfmIn34vgWGAMcbFvwTf2lPQgn/z6eLmeWwFysNJpurYKydkcE6CNUvC9V7ENsPGnejpygM6CAQAgbkeCz2JqQlwG9f41di2w7W9WPJ9ZjHiScFu4RCpVSXQpczlrjuz3pmx/A4WoZRLqVZ3CVhuzJ4Zs3u5si8ae5oE7tEEaPvnfTD+NdU4Aji6d4P9eXzrkaAIfpttLy1CK7qLKw9FVAKaa2n+QONvAbUMnJ2wsF7RIi5HsgEGu8mIBFjkWhbb6hWIZ20aL56T5bMCfojQ3gh+FL3x9IqSfNV2iFiwLOPzF7usy341s0CJZgRJIu0z7p2RR5eoLhIJ9I6E6Ohuy4tVw92D7W1Dj8DZJjNCK57hlbxCk8iNcY0LNKUXrIw2zv8bUKnfha9x8UcLvgmTRu8Y9oTyZnWQh4uXLwmACzBD/ABUYQ+76C0jUeOOnM/mhenFGtQTlvbWJofhYP/9pAVF6z6Omb60e89kErKf
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6534.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(136003)(346002)(376002)(366004)(396003)(186003)(122000001)(41300700001)(71200400001)(5660300002)(8936002)(33656002)(52536014)(83380400001)(38100700002)(2906002)(86362001)(64756008)(38070700005)(66476007)(66556008)(66446008)(66946007)(55016003)(54906003)(478600001)(316002)(76116006)(53546011)(9686003)(110136005)(8676002)(4326008)(6506007)(26005)(7696005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?faA83wrp6IYog1BEamiTQSEk13BKxygS/JwHqrLRzFBXmMKWq7WYJz2lq6+L?=
 =?us-ascii?Q?ztJ7GCnv8zXqrEcqt3lbaj2WZETKmxMcNd/niMZrvvs6cu5rEYr9Ljo0qbxe?=
 =?us-ascii?Q?e6B9O/aYQrsbWVywnG3OZmLCQH8vM9hOtcwxSZKSi5mtNKGUyhCBMSUITlOK?=
 =?us-ascii?Q?ep+3+ncNTpxkNn1UChn3beXOln963QIYB/UYoqCbmT2kxec13wYmbQYRk8oC?=
 =?us-ascii?Q?6v4NpjexBXf5xB/bQ5Yt3n+3gtP7QG2stp/eTEmXe/fhMq4AzIyJdewwsUg0?=
 =?us-ascii?Q?2nupBbPDCqd+xgMp2C3B45CfAt7CHN20m1Vf2wCADWJInwbmvD4BtuxcEwpz?=
 =?us-ascii?Q?ElfXS/EpVCl9Hnbss+wYsc19csDervEMr+mm7oPfscY8XsgcVbuEYhOPCGhx?=
 =?us-ascii?Q?r/CP7or+iY9DTMWYEuIbUvfq7S5n81R3/volcg+BptsrnDg+27Kkytu8fhDv?=
 =?us-ascii?Q?cJHFyukA2P1oGhJbwGM4xHZeahv592RkaTb4YGrRSF8MaKYz46gvAOAHC3Ix?=
 =?us-ascii?Q?xYndeSZ7N5ths+vP8jvgjUKYfP6t/K99uEV4tuBJPH1pS9ZyFaQJE0ucPnh2?=
 =?us-ascii?Q?NdiXvWqUSyZlGftj8QSUFoQV9P/vGCPM2q+8ms+YBU2gWesqeBMaYk5i0DhP?=
 =?us-ascii?Q?2Tp+yHeEnEibOPI+/WtmUvfV/KVR39JIyxEGZ+N+al0jlXlQdYVm2k0UEcrq?=
 =?us-ascii?Q?CZTSietliVjmzCi23TYLLOvSqxq1ijGvU6Pz98tu2hVXWfSi30G1zg/JxNxz?=
 =?us-ascii?Q?oc6CyIfwkmDBy0iA4sbYXhsaGSz3AzD0JMij6/csWVOQ6BOzflCpqLmk/+f9?=
 =?us-ascii?Q?5d+GAIWtASeG2RxSBv8h0wbaZnX8OqiDeKiIGY+5vlKuj4ii7b7MJ+UF7MSq?=
 =?us-ascii?Q?hWr+bPRb3VFGU5J3HTypsT0tBR9+f++mzMyS1LdDLPtw3ozeHqM77Wdr5LPk?=
 =?us-ascii?Q?TxaYWn4qFnZBvu+im00+LS5kjNbturO5pcdj26koHpY8kZnJMb8d+ENJ7lkN?=
 =?us-ascii?Q?NyMsUwfFYdhjnykwBmdf3kyUq1tYqH/80n9DRHabTfoE3jxzqpjW4LK1Qobj?=
 =?us-ascii?Q?EdQjs9/+hEqF2vI1p41fp0fCx2cwdN5AB36k3JS9LiugP3OOvzNG+eDic00U?=
 =?us-ascii?Q?qkg5UeE12BGKGLMHGxpOR2wGB2Vatv5JkHJn1iotMgjhtEUzsWFkMuZ5/j2M?=
 =?us-ascii?Q?NWhRrb1bjDDbrfh0iDJPB2Jv2DmgRGLpIIsAkQNSJTO/46Rk97qtgnAPjODp?=
 =?us-ascii?Q?vlo3O7of3OUBJKepbRHN4CrI1pa+kZ8IpU+hrYDJ8Bdw7ysYsRfFabj+Dfcm?=
 =?us-ascii?Q?WnaNL8mf4b6+UYwAhW+1RV1sSAH+voB34idJ1V16g4znfcpdq3hR6Mx9BTxX?=
 =?us-ascii?Q?NnlwmGnvbafaNr8Op3ew1qkVihuDNvgWv4CVPRkd94I678fYJiV/BU4JtnJN?=
 =?us-ascii?Q?MAQ/9u7vQuMAOr+mBJSTYwHxfrTM8JBTYpFqtZh0x87P5gbLS5H6IfCxbDnc?=
 =?us-ascii?Q?fCSJyz/k+5pNytTiOEWb5C7QNr+Mq1Xrsr7pfCH92WJAp+HnCeZxC3OphcAS?=
 =?us-ascii?Q?aEnROqE0ojxb/1EpMjw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6534.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e62fbd5-6f29-4dba-cb74-08da79540196
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2022 15:38:13.6582 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nhXZ0pNadADnhM7PwQUH2ZEeLDPVtEurA4UEFKEWebPXDYz+jhgfs76L8Xv8LStFy/ECE9wBm/SdRnjVIJq3nQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6478
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
 Sun peng \(Leo\)" <Sunpeng.Li@amd.com>, "Lakha,
 Bhawanpreet" <Bhawanpreet.Lakha@amd.com>, "Zhuo,
 Qingqing \(Lillian\)" <Qingqing.Zhuo@amd.com>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>, "Li, 
 Roman" <Roman.Li@amd.com>, "Chiu, Solomon" <Solomon.Chiu@amd.com>, "Pillai,
 Aurabindo" <Aurabindo.Pillai@amd.com>, "Lin, Wayne" <Wayne.Lin@amd.com>,
 "Wentland, Harry" <Harry.Wentland@amd.com>, "Gutierrez,
 Agustin" <Agustin.Gutierrez@amd.com>, "Kotarac, Pavle" <Pavle.Kotarac@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Hi all,
=20
This week this patchset was tested on the following systems:
=20
HP Envy 360, with Ryzen 5 4500U
Lenovo Thinkpad T14s Gen2, with AMD Ryzen 5 5650U=20
Sapphire Pulse RX5700XT=20
Reference AMD RX6800
Engineering board with Ryzen 9 5900H
=20
These systems were tested on the following display types:=20
eDP, (1080p 60hz [4500U, 5650U, 5900H])
VGA and DVI (1680x1050 60HZ [DP to VGA/DVI, USB-C to DVI/VGA])
DP/HDMI/USB-C (1440p 170hz, 4k 60hz, 4k 144hz [Includes USB-C to DP/HDMI ad=
apters])
=20
MST tested with Startech MST14DP123DP and 2x 4k 60Hz displays
DSC tested with Cable Matters 101075 (DP to 3x DP), and 201375 (USB-C to 3x=
 DP) with 3x 4k60 displays
=20
The testing is a mix of automated and manual tests. Manual testing includes=
 (but is not limited to):
Changing display configurations and settings
Benchmark testing
Feature testing (Freesync, etc.)
=20
Automated testing includes (but is not limited to):
Script testing (scripts to automate some of the manual checks)
IGT testing
=20
The patchset consists of the amd-staging-drm-next branch (Head commit - 83a=
ce616212127dcf707897e39196f45f5bede29 -> drm/amd/display: 3.2.196) with new=
 patches added on top of it. This branch is used for both Ubuntu and Chrome=
 OS testing (ChromeOS on a bi-weekly basis).

=20
Tested on Ubuntu 22.04 and Chrome OS
=20
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
=20
=20
Thank you,
=20
Dan Wheeler
Sr. Technologist | AMD
SW Display
---------------------------------------------------------------------------=
---------------------------------------
1 Commerce Valley Dr E, Thornhill, ON L3T 7X6
amd.com

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Tom Chun=
g
Sent: August 5, 2022 1:58 PM
To: amd-gfx@lists.freedesktop.org
Cc: Wang, Chao-kai (Stylon) <Stylon.Wang@amd.com>; Chung, ChiaHsuan (Tom) <=
ChiaHsuan.Chung@amd.com>; Li, Sun peng (Leo) <Sunpeng.Li@amd.com>; Wentland=
, Harry <Harry.Wentland@amd.com>; Zhuo, Qingqing (Lillian) <Qingqing.Zhuo@a=
md.com>; Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>; Li, Roman <Roman.Li@=
amd.com>; Chiu, Solomon <Solomon.Chiu@amd.com>; Pillai, Aurabindo <Aurabind=
o.Pillai@amd.com>; Lin, Wayne <Wayne.Lin@amd.com>; Lakha, Bhawanpreet <Bhaw=
anpreet.Lakha@amd.com>; Gutierrez, Agustin <Agustin.Gutierrez@amd.com>; Kot=
arac, Pavle <Pavle.Kotarac@amd.com>
Subject: [PATCH 00/32] DC Patches July 29 2022

This DC patchset brings along following fixes:

- Move fpu file to dml folder
- Fix CAB allocation for multiple displays
- Add a variable to update FCLK
- Fix TMDS 4K@60Hz YCbCr420 corruption issue
- Fix MPC tree infinite loop in some case
- Fix SubVP calculations
- Fix HDMI VSIF V3 blank screen issue
- Add some documentation to the code
- Allow alternate prefetch modes in DML for DCN32
- Fix VPG instancing for dcn314 HPO
- Check correct bounds for stream encoder instances for DCN303
- Enable SubVP by default on DCN32 & DCN321
- Fix DTBCLK not correct for dcn314
- Fix Compile-time warning
- Fix the stereo mode hang issue
- Fix display light up issue

Alvin Lee (8):
  drm/amd/display: Revert "fix 32 bit compilation errors in
    dc_dmub_srv.c"
  drm/amd/display: Add a variable to update FCLK latency
  drm/amd/display: Refactor SubVP calculation to remove FPU
  drm/amd/display: Add 16 lines margin for SubVP
  drm/amd/display: Fix subvp calculations
  drm/amd/display: Revert "attempt to fix the logic in
    commit_planes_for_stream()"
  drm/amd/display: For stereo keep "FLIP_ANY_FRAME"
  drm/amd/display: Don't try to enter MALL SS if stereo3d

Aric Cyr (1):
  drm/amd/display: 3.2.197

Aurabindo Pillai (3):
  drm/amd/display: fix CAB allocation for multiple displays
  drm/amd/display: Check correct bounds for stream encoder instances for
    DCN303
  drm/amd/display: Enable SubVP by default on DCN32 & DCN321

Chiawen Huang (1):
  drm/amd/display: Device flash garbage before get in OS

Daniel Miess (2):
  drm/amd/display: Use pixels per container logic for DCN314 DCCG
    dividers
  drm/amd/display: Fix TMDS 4K@60Hz YCbCr420 corruption issue

David Galiffi (2):
  drm/amd/display: Allow alternate prefetch modes in DML for DCN32
  drm/amd/display: Fix Compile-time Warning

Duncan Ma (2):
  drm/amd/display: Fix VPG instancing for dcn314 HPO
  drm/amd/display: Correct DTBCLK for dcn314

Fudong Wang (1):
  drm/amd/display: clear optc underflow before turn off odm clock

Josip Pavic (1):
  drm/amd/display: Avoid MPC infinite loop

Leo Ma (1):
  drm/amd/display: Fix HDMI VSIF V3 incorrect issue

Meenakshikumar Somasundaram (1):
  drm/amd/display: Fix TDR eDP and USB4 display light up issue

Rodrigo Siqueira (9):
  drm/amd/display: Create FPU files for DCN314
  drm/amd/display: Move populate dml pipes from DCN314 to dml
  drm/amd/display: Drop FPU flags from Makefile
  drm/amd/display: Add documentation to some of the cursor struct
  drm/amd/display: Add basic kernel doc to CRC code under DC
  drm/amd/display: Add some extra kernel doc to amdgpu_dm
  drm/amd/display: Document pipe split policy
  drm/amd/display: Expand documentation for timing
  drm/amd/display: Document some of the DML structs

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  16 +-  .../gpu/drm/amd/di=
splay/amdgpu_dm/amdgpu_dm.h |  46 ++-
 .../dc/clk_mgr/dcn314/dcn314_clk_mgr.c        |  12 +-
 .../dc/clk_mgr/dcn314/dcn314_clk_mgr.h        |   2 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  45 ++-
 drivers/gpu/drm/amd/display/dc/dc.h           |  40 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  |  93 +++--  drivers/gpu/drm=
/amd/display/dc/dc_hw_types.h  | 148 ++++++-
 drivers/gpu/drm/amd/display/dc/dc_link.h      |   1 +
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c |   1 +
 .../gpu/drm/amd/display/dc/dcn10/dcn10_mpc.c  |   6 +
 .../gpu/drm/amd/display/dc/dcn10/dcn10_optc.c |  44 +-
 .../gpu/drm/amd/display/dc/dcn20/dcn20_mpc.c  |   6 +
 .../gpu/drm/amd/display/dc/dcn30/dcn30_hubp.c |   2 +-
 .../amd/display/dc/dcn303/dcn303_resource.c   |   2 +-
 .../gpu/drm/amd/display/dc/dcn314/Makefile    |  25 --
 .../drm/amd/display/dc/dcn314/dcn314_hwseq.c  |  42 +-
 .../drm/amd/display/dc/dcn314/dcn314_hwseq.h  |   4 +
 .../drm/amd/display/dc/dcn314/dcn314_init.c   |   2 +
 .../amd/display/dc/dcn314/dcn314_resource.c   | 341 +---------------
 .../amd/display/dc/dcn314/dcn314_resource.h   |   3 +
 .../drm/amd/display/dc/dcn32/dcn32_hwseq.c    |  39 +-
 .../gpu/drm/amd/display/dc/dcn32/dcn32_optc.c |   2 +-
 .../drm/amd/display/dc/dcn32/dcn32_resource.c |   3 +-
 .../amd/display/dc/dcn321/dcn321_resource.c   |   3 +-
 drivers/gpu/drm/amd/display/dc/dml/Makefile   |   2 +
 .../amd/display/dc/dml/dcn314/dcn314_fpu.c    | 376 ++++++++++++++++++
 .../amd/display/dc/dml/dcn314/dcn314_fpu.h    |  40 ++
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  |  46 ++-
 .../amd/display/dc/dml/dcn321/dcn321_fpu.c    |   7 +
 .../amd/display/dc/dml/display_mode_structs.h |  34 ++
 .../gpu/drm/amd/display/dc/inc/core_types.h   |   4 +
 .../amd/display/dc/inc/hw/timing_generator.h  |  14 +-
 .../amd/display/modules/freesync/freesync.c   |  15 +-
 34 files changed, 968 insertions(+), 498 deletions(-)  create mode 100644 =
drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.h

--
2.25.1
