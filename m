Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D050C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Dec 2021 22:07:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9534510E2CD;
	Wed, 22 Dec 2021 22:07:38 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2074.outbound.protection.outlook.com [40.107.94.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D0B1610E2CD
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Dec 2021 22:07:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R9dsG/z9Gnb8DDt2m/KFOmrUAyO+zwypHpmIl0g75yIP98+1qfOA9LvYW90BUIV9lNIzoMTgDnvq1sZXpgnj1FG+5VmZGOIzky1t4tIzSJTiWmnbFjlzB25C3KmzBaEEdvXPBl5vVhKBePNmG47HkFBaWrey+k9ov6R1XBfT/3UPRmuLqjz7KdxZhrKpXaX9Ur0iQS/PWhEXxe2a3aMTMgE5jvAsaT1Zw+Xo/zUpftOqv+5rseUplkXQkGDT0HmMD0dFclfEt17mJk4mkcB79nxzuew23Km8PIHjmXzRulgo975Qh1cuz+G8rtvQfmyDu5//ykE6MCOqRehAv8BmXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PJPUySlGgbxcV99WBiLwygy4Y6Fzb3fKI4cmpWqDxS4=;
 b=JWbBsBEqK6eFQ9KNpTR8G32H7Q0bSdQzBamQPwxkJdWyePmBw61vVMN/AZEuhW+mp/LDNxOI4XYzakKukmvDDq9NKMLxkzXopUJLq2sasbXlx/ZcFmIqD7fRJ4hOnV1pJKH7iZCzNAk84qjf7qyHp7rQL02GjjyP6b+9o6J3V2uN8gMyDOV8BcDodOO+OS8cJC1fMLdqXuEkmNgw0aCYSBdXchNOPqZwYpSuThMTy3qW+BVPCFzdU4AUmn+ImuhKDe/IVD3gwUGHvBz7gc/aQxcFDX/MreL1igODzL7fwSpjhmTY/aC2mOIx/DbgD2Zg1NzfBzD14+ceSVA56LfCww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PJPUySlGgbxcV99WBiLwygy4Y6Fzb3fKI4cmpWqDxS4=;
 b=4tv8UkhEKVgXVuN3FzOkz1WABHxLeh8WofoqI44iE3PE/sTtdklsQGs2b/L3oXNVsBCAeDz6RGpcBJBS9i6lFK6+1izXfq8U7ztazzlGStnMOkEb4zCCtSgBsPRSLby05hj4QR5gacC6kMz0KjiO5Nh2ieVDfPllAP5yXXkGIeg=
Received: from DM6PR12MB3529.namprd12.prod.outlook.com (2603:10b6:5:15d::18)
 by DM6PR12MB4843.namprd12.prod.outlook.com (2603:10b6:5:1d1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14; Wed, 22 Dec
 2021 22:07:34 +0000
Received: from DM6PR12MB3529.namprd12.prod.outlook.com
 ([fe80::88c5:51dc:ed5a:6f5a]) by DM6PR12MB3529.namprd12.prod.outlook.com
 ([fe80::88c5:51dc:ed5a:6f5a%6]) with mapi id 15.20.4801.020; Wed, 22 Dec 2021
 22:07:34 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 0/6] DC Patches December 22, 2021
Thread-Topic: [PATCH 0/6] DC Patches December 22, 2021
Thread-Index: AQHX94AS3euh7+j86EGyYW8bU6lNiqw/EVXA
Date: Wed, 22 Dec 2021 22:07:34 +0000
Message-ID: <DM6PR12MB3529E125A3AEE54A0F6BF31D9C7D9@DM6PR12MB3529.namprd12.prod.outlook.com>
References: <20211222220519.1682537-1-Rodrigo.Siqueira@amd.com>
In-Reply-To: <20211222220519.1682537-1-Rodrigo.Siqueira@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-12-22T22:07:32Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=51f03c66-0c26-473b-a2e9-49816ddc1841;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2021-12-22T22:07:32Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: ed5b1c0f-ee39-436e-a99a-4e752dbb49c4
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1335795b-fc6a-43fc-7552-08d9c597752b
x-ms-traffictypediagnostic: DM6PR12MB4843:EE_
x-microsoft-antispam-prvs: <DM6PR12MB484313DF281C4E02C2B1ECBE9C7D9@DM6PR12MB4843.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9IAKN9z+b/ivcbf2oUsRO7w9W1JY31p0+iPjdD/ayk4DmvIZIhdoNvo/MkTu4eYWwuakXUQVIgpFDzQtT6uwdYuyVKsnI5SuITA4XAWQNdq4wAx7UBfvhs3fFNyKXwgcGIcVVYfOVwUf0F0xV87EDz9Lpuu8Swj+HN4QydbUwdU0EACDI0iC6zHbRlSUSyy/INgthpGO57L2FUf8s6SmQu+vspxJVMmBxOW6xFJxrP0svsJ4yGqOwOgU5/h5qNA1UpqRe8LO/pa2a1T/Aj+1zrpuoTaL0hccE9JZBQ6Tk9+4q5CBJSGBn3KBC8dCRqjmChAabedc7lgRkQWxd4fRK+6/Sn6bmUhoDC9PplIRITbgioJHWO7c6l/DR6LVsCJIJl9cm8IqOA3lrKexNCSSQlyCLRZOmQbyjpnVNb6bhxaxZeyj9bezRxrYHzrdiZ8VW5jLM0ZNEomC+mdigU3Q/a/lmn6vIy89gJjoavv3KJl8fHsWQ+DMhU/LAtGp3JGmHLfLwvtu//qCb1fZFB34zDzOYNZ8MlH1u6rFWm1RV0KrNNdIref+NfANOjlxwlNlCxwQbLxcBqzrdvfFHd1vZbhY8ghAHwm4LCVZ/T4kGcH2ou9dCtpCG77JICxkA6fMaxAnfbdoWbczRN9BaXPe7MH8euf10+ZhHPP7uL7RF4uWTGP64vENIFQ9zJB3WvtKf7wVlI3cj00VgrLFYxUA3g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3529.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(186003)(83380400001)(33656002)(86362001)(38070700005)(26005)(508600001)(122000001)(2906002)(54906003)(110136005)(5660300002)(7696005)(316002)(66946007)(76116006)(8936002)(4326008)(6506007)(38100700002)(53546011)(66446008)(64756008)(66476007)(66556008)(52536014)(9686003)(8676002)(55016003)(71200400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GrYcRSQWzgLIy9ngz3ltNX+365Dl4S9XVclJAfEtlrim0bBb6X2ttJIfNGUT?=
 =?us-ascii?Q?oHE8CQdD2OTpZS1ZSs7DjPWRmgEg3OYBNo76OIc1iJbZuSQHeX7DAcgl5YbH?=
 =?us-ascii?Q?Qgxyx7fdDFUszHFDMji4g4t3sF3NMGQ35IBcxz0WNHMbdR0K3Ep0BmkdRpJO?=
 =?us-ascii?Q?htrH9ApxG7LZRvSsBbEqd61kPEC5YQ4mK/zPYITc1hi6/FaaK+f1vHXtRSoW?=
 =?us-ascii?Q?3QjZtAzVCu7TH6ms3/UVW8TCoBri/KwJLlW7tp29VxDTQz55NeDZsB49DNHF?=
 =?us-ascii?Q?wt+9ONwT2TJkexizlrokW+2IPAkBLuO7KtjDmsrritsNK/wg/M74fCqfSUKW?=
 =?us-ascii?Q?NY21HgKTFsoVAzPMJ3s1hoc0R+qpVFeMa8d+/Wc/zlYAokbwRIyN5gGHt4JB?=
 =?us-ascii?Q?PZRH1sSNsuh9OAljk8y+TBJBYZSpf3SFv2zsiABegZnwHhAWoURTtrns8dqG?=
 =?us-ascii?Q?YbHwNpRQVPu9PlYmpoetgJ7RjYrVQpO1hWZGC7tSERIn0E7SWWoynBHcPRnk?=
 =?us-ascii?Q?XjDBRFgaWQzKM9903mn3OxJ6zwnTPSJvI39znJ+BubnXbbjQasclPjstLxrs?=
 =?us-ascii?Q?uGROlTcjy/58gnnggYHHVar+yo+UnQL9nX28kBXd2Pt9FxkzonEI+09DN5ZP?=
 =?us-ascii?Q?tiSDGT1jjF8MecszdDi602GAkhR0CF5glxzuiALGfoDvTq+imjhALV/3l1zk?=
 =?us-ascii?Q?lggmlqHeu+5HBc6dREUxjSFqF5IIEaLq6/8wgxyaZYYFVLTKpjqZu5hZ7KVq?=
 =?us-ascii?Q?RDtPtEl/aSlIkRo0k/9x4OQErHofZyOjuxOX1JFviIYixe67Lm62FworDxoj?=
 =?us-ascii?Q?8AXuUtPnZ+iXC/yBiUbnekl7XRlfGgu6xUcMC5aopULn8WXY4BFYiyP/VPM5?=
 =?us-ascii?Q?mL/iEmoRONsC3RWjf8Nq95Y6cs2x1q7+YVJ86mXsBZieGGb+i/cGNdfWqgMm?=
 =?us-ascii?Q?IulCLWLN7TxHt4GeTK3f3K70FCyGeqPP4clCK7S1/NUUZX11iPiIsNOmS2c6?=
 =?us-ascii?Q?kHnwMPDf/W3Og4UHNWp8h+FC7Gs2E6hVWmj48SrqDyb02wqK6O+micKW2s/n?=
 =?us-ascii?Q?1VKs46pziUfL9N9QdEwEYDlFsIYh6PsutUvyU4MoQ8MweVK8OVu/Cuno8Aw1?=
 =?us-ascii?Q?lLnDz60Kg8jQODNy7eGU7F7UFIa/XpdMb3MrckOnfni8L3LkS9a5RXUmOeMf?=
 =?us-ascii?Q?eXZvOspq5lGjzCkEChePbd0a79F9SIJiYhu54VzfLr/9eIjQA+s8eHbhlywh?=
 =?us-ascii?Q?Sdje7MCZQzoKjGMC4lEDtMCqI7C0p5tiTC6KsrAMGzevAq6bDBAVCI8B4bHP?=
 =?us-ascii?Q?GD0cjJyPgPGqA8TYnkcxgKGYS2kvkVyjzqjQQc0vDXCijk/5PLp99fdpDXt4?=
 =?us-ascii?Q?hqw19lFUt8pCnp4fy0T6eu/LNqZH0yie5RjWP/e2GirsPv99pv72wNl4nDa2?=
 =?us-ascii?Q?jskZWIqwNEa2XODOzhpXse1KQpH/M2aLE4lSmp57ygo/y4sNjuV1HY0jEERk?=
 =?us-ascii?Q?wLklYsbSyZdlGp+o55D4P0bPxxgnIrEofwTvR/wmvHtSmnzdMbUDsJIWN+rM?=
 =?us-ascii?Q?kmjplPKWAlIv80ZZl0AuXMIZfI8Q+TRX+C43xzJU3r8CQksJiUOIJZ80ny1T?=
 =?us-ascii?Q?JI+Y7rKjdMQz1hbkS3mPJcg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3529.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1335795b-fc6a-43fc-7552-08d9c597752b
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Dec 2021 22:07:34.4272 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cgsCr9EvgEu2QoByiWYa+QMC+iA6fKiDqb1u+3A2HvBVE32/JkcfGUCBhorKyggKQNKnzfzIPC2oRnJY52eZYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4843
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
Cc: "Wang, Chao-kai
 \(Stylon\)" <Stylon.Wang@amd.com>, "Li, Sun peng \(Leo\)" <Sunpeng.Li@amd.com>,
 "Wentland, Harry" <Harry.Wentland@amd.com>, "Zhuo,
 Qingqing \(Lillian\)" <Qingqing.Zhuo@amd.com>, "Li, 
 Roman" <Roman.Li@amd.com>, "Chiu, Solomon" <Solomon.Chiu@amd.com>, "Pillai,
 Aurabindo" <Aurabindo.Pillai@amd.com>, "Lin, Wayne" <Wayne.Lin@amd.com>,
 "Lipski, Mikita" <Mikita.Lipski@amd.com>, "Lakha,
 Bhawanpreet" <Bhawanpreet.Lakha@amd.com>, "Gutierrez,
 Agustin" <Agustin.Gutierrez@amd.com>, "Kotarac, Pavle" <Pavle.Kotarac@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

Hi all,
=20
This week this patchset was tested on the following systems:
=20
Lenovo Thinkpad T14s Gen2 with AMD Ryzen 5 5650U, with the following displa=
y types: eDP 1080p 60hz, 4k 60hz  (via USB-C to DP/HDMI), 1440p 144hz (via =
USB-C to DP/HDMI), 1680*1050 60hz (via USB-C to DP and then DP to DVI/VGA)
=20
Sapphire Pulse RX5700XT with the following display types:
4k 60hz  (via DP/HDMI), 1440p 144hz (via DP/HDMI), 1680*1050 60hz (via DP t=
o DVI/VGA)
=20
Reference AMD RX6800 with the following display types:
4k 60hz  (via DP/HDMI and USB-C to DP/HDMI), 1440p 144hz (via USB-C to DP/H=
DMI and USB-C to DP/HDMI), 1680*1050 60hz (via DP to DVI/VGA)
=20
Included testing using a Startech DP 1.4 MST hub at 2x 4k 60hz, and 3x 1080=
p 60hz on all systems. Also tested DSC via USB-C to DP DSC Hub with 3x 4k 6=
0hz on Ryzen 9 5900h and Ryzen 5 4500u.
=20
Tested on Ubuntu 20.04.3 with Kernel Version 5.13
=20
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
=20
=20
Thank you,
=20
Dan Wheeler
Technologist  |  AMD
SW Display
---------------------------------------------------------------------------=
---------------------------------------
1 Commerce Valley Dr E, Thornhill, ON L3T 7X6
Facebook |  Twitter |  amd.com =20

-----Original Message-----
From: Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>=20
Sent: December 22, 2021 5:05 PM
To: amd-gfx@lists.freedesktop.org
Cc: Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo) <Sunpeng.L=
i@amd.com>; Lakha, Bhawanpreet <Bhawanpreet.Lakha@amd.com>; Siqueira, Rodri=
go <Rodrigo.Siqueira@amd.com>; Pillai, Aurabindo <Aurabindo.Pillai@amd.com>=
; Zhuo, Qingqing (Lillian) <Qingqing.Zhuo@amd.com>; Lipski, Mikita <Mikita.=
Lipski@amd.com>; Li, Roman <Roman.Li@amd.com>; Anson.Jacob@amd.com; Lin, Wa=
yne <Wayne.Lin@amd.com>; Wang, Chao-kai (Stylon) <Stylon.Wang@amd.com>; Chi=
u, Solomon <Solomon.Chiu@amd.com>; Kotarac, Pavle <Pavle.Kotarac@amd.com>; =
Gutierrez, Agustin <Agustin.Gutierrez@amd.com>; Wheeler, Daniel <Daniel.Whe=
eler@amd.com>
Subject: [PATCH 0/6] DC Patches December 22, 2021

Hi,

This is the last DC upstream of this year. As a result, it is a very tiny o=
ne with a few bug fixes.

Just for curiosity, I decided to calculate how many patches we upstream via=
 this weekly process in 2021, and it was approximately 740 patches where Da=
niel Wheeler tested each patchset. Thanks to everybody for helping with thi=
s process, and special thanks to Daniel that validate each patchset :)

Cc: Daniel Wheeler <daniel.wheeler@amd.com>

Best Regards
Siqueira

Charlene Liu (1):
  drm/amd/display: Add check for forced_clocks debug option

Mikita Lipski (1):
  drm/amd/display: introduce mpo detection flags

Nicholas Kazlauskas (2):
  drm/amd/display: Don't reinitialize DMCUB on s0ix resume
  drm/amd/display: Add version check before using DP alt query interface

Wenjing Liu (1):
  drm/amd/display: unhard code link to phy idx mapping in dc link and
    clean up

Yi-Ling Chen (1):
  drm/amd/display: Fix underflow for fused display pipes case

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  40 ++++-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |   2 +
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 145 +++++++-----------  ..=
./gpu/drm/amd/display/dc/core/dc_resource.c |  33 ++++
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c |   7 +-
 .../display/dc/dcn31/dcn31_dio_link_encoder.c | 114 +++++++++++---
 .../drm/amd/display/dc/dcn31/dcn31_resource.c |   2 +-
 drivers/gpu/drm/amd/display/dc/dm_cp_psp.h    |   4 +-
 drivers/gpu/drm/amd/display/dc/inc/resource.h |   1 +
 .../drm/amd/display/modules/inc/mod_hdcp.h    |   2 +-
 10 files changed, 234 insertions(+), 116 deletions(-)

--
2.25.1
