Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC643C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Dec 2021 14:21:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3CB8110E73D;
	Mon, 13 Dec 2021 14:21:48 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2065.outbound.protection.outlook.com [40.107.237.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3006210E741
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Dec 2021 14:21:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J39Ox0wa6mEkzHtCbeD9750yUVKZb3EC44k7rR/zvcVuXGFyiIHbI737NyQVGHGOTLJYEV5Se6h3WJm+I1zc3mGrVLW0NCdXocF1fbj7icfdLMphetOOWZLU1QkARiFmjoFyQkZhw0jrdm82Mt/pK8bR+54u2lLRul8DUQpnvDmpbUvUhJyU3Sjnnahy4uMhFV0R99KQm7pNMHDjnsyns1SqfsvyGzNP7Nqq/u5eUvlAfhnVlLU37m3zQjpvlmDfKOTjZphYPgiiHAE4m8mwKIQH6yH1rx1//h69lAE+FL4YsouTRqUwbKUbO6062Jb9IC1gaG/DbafROkBQckqTOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I2lo8eKPyiH1uQTmyIX6R4CkEFX0qeACEx+97tObZQI=;
 b=fwFoDqnW24IP5Ge1ry6BIq8HtsYDQRIKUx98mjLirpFDO6/zPMWUygUXqchVRp+wxrIKRCqUzRIJ0lfhfhE3ygAEiVln2pUqmEyppiXohN474Xb8P8MHP0ShGJWtyZbbSeQ0QUumAKRUGXA7hvNLaF0/QSxVJD6vLLlYD+CyzlIeOjkxBDrDp3yCIq4o/+acGX544/nD1w2AMC8fNCMVmEzk7GV4tq9MoV5+RItSvMTuTy7w/IxmN8XBhLENfmPMNGfv10zcT6I/n6Yk7p10+odaG+OBtE7R/+uix+a96LOsQzYxwwYxjW04iW6VtlGjyvUBbL7qQYJeHKFWQni4sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I2lo8eKPyiH1uQTmyIX6R4CkEFX0qeACEx+97tObZQI=;
 b=HiDV415aRbCzpkn2VA5SShK6uU1A5QG0GBj48TuIuXTDIJYB6GBaMcuOqRPwibiBWgS0bav4aIhOX5ySMl/4FXRlz3QhfkBZAQD+Khag9FCZC7GvToI/70wjYsMB4oKzNyBneZ5d/B8uu2U3TpH8nDZPBZnO3IacZsUiGegUrLc=
Received: from DM6PR12MB3529.namprd12.prod.outlook.com (2603:10b6:5:15d::18)
 by DM6PR12MB3708.namprd12.prod.outlook.com (2603:10b6:5:1c5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.16; Mon, 13 Dec
 2021 14:21:43 +0000
Received: from DM6PR12MB3529.namprd12.prod.outlook.com
 ([fe80::88c5:51dc:ed5a:6f5a]) by DM6PR12MB3529.namprd12.prod.outlook.com
 ([fe80::88c5:51dc:ed5a:6f5a%6]) with mapi id 15.20.4778.018; Mon, 13 Dec 2021
 14:21:43 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Kotarac, Pavle" <Pavle.Kotarac@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: DC Patches January 10, 2020
Thread-Topic: DC Patches January 10, 2020
Thread-Index: AQHX7hpcZeklmeWc90ir2H4CMAAMeKwwfTDA
Date: Mon, 13 Dec 2021 14:21:42 +0000
Message-ID: <DM6PR12MB3529F8868630C2EDF68D94AE9C749@DM6PR12MB3529.namprd12.prod.outlook.com>
References: <20211210230408.619373-1-Pavle.Kotarac@amd.com>
In-Reply-To: <20211210230408.619373-1-Pavle.Kotarac@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-12-13T14:21:39Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=1a60f4ce-e053-4173-8a37-71a9d54e3b5a;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2021-12-13T14:21:40Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 7f6a7459-5833-4ef1-9609-3991c1744b0a
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9891a450-05d8-469c-f9c2-08d9be43e31b
x-ms-traffictypediagnostic: DM6PR12MB3708:EE_
x-microsoft-antispam-prvs: <DM6PR12MB370817C63F1360D86DC55BDB9C749@DM6PR12MB3708.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iCqGzJ47lI3kSpQDllL4vhxzfXmsCy0Ro2x7XULrLU789Z7pSuibGJ/6heX1lD5TfFYPFuuF4t7tcBjZ0ws+uRRi8YS6LOGKzeoWHZiDuA+Y6N9umZoSm/2BEoJ68bMJMPYTHXII875R0+z6lZLLcR6lRixN4IWZqqp99d2H0BObyN5wFtWgNHRwbg8ieSyqqfgu5LUfAy1RdLlLW1+qYq73GVZDzRRtq/YgOVfsNhgWqS+D/c5eVt40fwwV8HZlvBUrv0pMwtEt9TXgZWYg4LYWYmqfuqK+myaJYEshMjBCRcuuaiuz4NZd9dvBDdFlsCFyeWwO8ouKPW8Ooscs7IG6JFuPwIUDJl8pASfhk4QaYq079z15eLwlipv/uqDH3LPvvyRrmdgSgisRzD+/7vxTvczqU4GWDVEyqWYqPMSqVQt4UWelt5SvBxsEDbuwANYn87q464o8WzUdLZ3lJoRgW5Q/Vf43VvUWr9+qrh4SuXKTDJ4AqgCEjfEkXMS5rDuPvZE3HqSQnzTu0CenVNH7/13Ses4gRKl/XX5xiy/nz+Z0SexUE92X+VrDRQCqWk+ISXSmCrkns59JgA2c33rWGGetLvsaGG8xSKl4JdyJ2jRD1An8Xqsyj2ubuuxiHHqgMo3EFnbrNC55hDvHCZUbBvxAfw2/5qg5J2Z3oep//Zs01ul7u+gOgDYwiP2H/XDPH6xLVDwXkiR+eHjh/w==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3529.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(316002)(3480700007)(8936002)(5660300002)(8676002)(71200400001)(33656002)(508600001)(110136005)(26005)(54906003)(86362001)(122000001)(2906002)(38100700002)(6506007)(53546011)(186003)(7696005)(66946007)(66476007)(64756008)(76116006)(9686003)(55016003)(52536014)(4326008)(38070700005)(66556008)(83380400001)(66446008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+Gcx02CG6nBy6kBX4cZEEmIE++wE0qgp/ZOicfAOM3DgY1GiixQaJH1HA/9N?=
 =?us-ascii?Q?b+tUa3npVMgnvbEbc6bRiLtNn/pwt0M/bb+MIDteCeX9eXT9OaloSB/equ89?=
 =?us-ascii?Q?m6fk1vlJosemRhSzYyiLeaAsVp344WyFtfbh6rpPxf+Dja9cFe5u/a6FA3Md?=
 =?us-ascii?Q?kRqhLhP/X1bHwP4X6lGj+vhKbMbbZFHZ9yZPELp6eYKT4NrwlxIuYqIUe7T/?=
 =?us-ascii?Q?2ubhdgtd6PqnxUm2c8Hlkx07ThNAiUOsZxOM58T5QTnW0TdVojI5IQTmGrvd?=
 =?us-ascii?Q?c24qzSPZPHBhm7GcVN1kvsFoH50A5xsIxPIUQBas5vLW+HEXtMXXoVDoFwK8?=
 =?us-ascii?Q?9n2E3ittBMrIHi+pl3fNxZ6W2/Nc+lwBjAgyT6+Hh8wmCDA4Deu46F4+kKNp?=
 =?us-ascii?Q?2FnAcraxImBxnIvgAOPGw1HuV2GGjOGbwLCHbatMyceZd+SB+oP42s9GQVpI?=
 =?us-ascii?Q?veDrVaLsFWqfCF89HvEgjzWWhw47oyiZ4AmDaVWXIYqF6PVl817J8P6zUbL3?=
 =?us-ascii?Q?Ww9Mxd8WGc7AfZNR/kW5PW4x6yxP88IbhtMWnF9SFezTjJjaslraVA7Jf20G?=
 =?us-ascii?Q?U+77Zab6LhtkJfZMm5zkM5hFzskEqZzN6jJFm3lj2hyTHMVIy3qiObmGZp66?=
 =?us-ascii?Q?KurbZKSqiDLQWpx++18Hy2e3gNE66wNeiHgj6aD3or8tUBHBtmU/lE09SJpT?=
 =?us-ascii?Q?QXexWaaCcoSNYqy9kT3i9JjD+DEjwgybfnItB3f1BIgHEam1H8ttBlr4zGt9?=
 =?us-ascii?Q?6ox8LYVL+0PJGGFuzB7vDo1Dz3fpkgAbJCSRqjik7i9UiKj7uX1+UVeWH0D3?=
 =?us-ascii?Q?nGRlpgjKPLYHR4YQ8uUW/87+7m3T/tGz7E3pYn+8jtm3WRdNS/QuAPub5p1X?=
 =?us-ascii?Q?gyx33isS3ddgK5d1LyuGOTKBDKk0T2M5bx77WgyEigfy2wAw7pk1n/FkpJvh?=
 =?us-ascii?Q?0r/8ocxg3AbmI1W6OwQcQAhsVWt94bKVD+gIGr1PhjFH6UDD4F6+TM0QFLVT?=
 =?us-ascii?Q?B9y9d8ZJQo+UW5TE/Y5C6fRsVfqGKNGMSmqFqdr1gPO6dNgtwHvycuXUG9BH?=
 =?us-ascii?Q?CsNRuWxnXlyRtWDNII3QJeh6PJuUf720vsT/x5ll9fEmYC8jjOnHf0rl8jPx?=
 =?us-ascii?Q?ej7dGCbdlevsdwfztD/G8AhJTiIukwR5v6+6v0yTA9M1NwCti3ZcFtO/zKdi?=
 =?us-ascii?Q?zfwBCq9YpYtCpZgqCkv3pIzk3DNU9HQz5nG4rSzCG2qd8UijF7cHaUwUo97E?=
 =?us-ascii?Q?Qks6lm5YNzXzYDZP5m+tXZj+c96upKBEm10HhKL4rhgdx71LfkMuHg6Y5GVE?=
 =?us-ascii?Q?YGNIKnsC+LljE2JVQCigLVYx4gVwVzCoqs09KEbky1ClAfMnUE9PUGC0neIK?=
 =?us-ascii?Q?Or30JEWLzgHtL8tUiMcIhdCGoQ5OBW2gK8zLiT75qRCW00Q22o5GAiKmBEhf?=
 =?us-ascii?Q?SAcvMJsZb7CseM6wOI49XVU45SMuZqn74Y0IC5VDUfHxugz+rYRqAsMCFBNp?=
 =?us-ascii?Q?12ke8i/yEhu8CNIA3O1DJ9BPrV7uE1/d+4v69TxgKs/Cso3QnSuVh65dRMzU?=
 =?us-ascii?Q?AgVjZr3fXHcy/Vp8l5W9Djo+q9Wi0eZcgdsuwcOM96GM36hzrpr+9PN5DMoj?=
 =?us-ascii?Q?IuY3Qb+zkvVm3f8mm7QGPW4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3529.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9891a450-05d8-469c-f9c2-08d9be43e31b
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2021 14:21:42.9795 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cNHe/ZXp/DQzfs370LBQsXmjhuiLpIhrNHa68jZeRzqvYrWV8zi/drfp/TvdQCsq2NAArjY+z37Xz71zZzghrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3708
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
Cc: "Wang, Chao-kai \(Stylon\)" <Stylon.Wang@amd.com>, "Chiu,
 Solomon" <Solomon.Chiu@amd.com>, "Li, Sun peng \(Leo\)" <Sunpeng.Li@amd.com>,
 "Wentland, Harry" <Harry.Wentland@amd.com>, "Zhuo,
 Qingqing \(Lillian\)" <Qingqing.Zhuo@amd.com>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>, "Li, 
 Roman" <Roman.Li@amd.com>, "Anson.Jacob@amd.com" <Anson.Jacob@amd.com>, "Pillai,
 Aurabindo" <Aurabindo.Pillai@amd.com>, "Lin, 
 Wayne" <Wayne.Lin@amd.com>, "Lipski, Mikita" <Mikita.Lipski@amd.com>, "Lakha,
 Bhawanpreet" <Bhawanpreet.Lakha@amd.com>, "Gutierrez,
 Agustin" <Agustin.Gutierrez@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

Hi all,
=20
This week this patchset was tested on the following systems:
=20
HP Envy 360, with Ryzen 5 4500U, with the following display types: eDP 1080=
p 60hz, 4k 60hz  (via USB-C to DP/HDMI), 1440p 144hz (via USB-C to DP/HDMI)=
, 1680*1050 60hz (via USB-C to DP and then DP to DVI/VGA)
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
Tested on Ubuntu 20.04.3 with Kernel Version 5.13 and ChromeOS
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
From: Kotarac, Pavle <Pavle.Kotarac@amd.com>=20
Sent: December 10, 2021 6:04 PM
To: amd-gfx@lists.freedesktop.org
Cc: Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo) <Sunpeng.L=
i@amd.com>; Lakha, Bhawanpreet <Bhawanpreet.Lakha@amd.com>; Siqueira, Rodri=
go <Rodrigo.Siqueira@amd.com>; Pillai, Aurabindo <Aurabindo.Pillai@amd.com>=
; Zhuo, Qingqing (Lillian) <Qingqing.Zhuo@amd.com>; Lipski, Mikita <Mikita.=
Lipski@amd.com>; Li, Roman <Roman.Li@amd.com>; Anson.Jacob@amd.com; Lin, Wa=
yne <Wayne.Lin@amd.com>; Wang, Chao-kai (Stylon) <Stylon.Wang@amd.com>; Chi=
u, Solomon <Solomon.Chiu@amd.com>; Kotarac, Pavle <Pavle.Kotarac@amd.com>; =
Gutierrez, Agustin <Agustin.Gutierrez@amd.com>; Kotarac, Pavle <Pavle.Kotar=
ac@amd.com>; Wheeler, Daniel <Daniel.Wheeler@amd.com>
Subject: DC Patches January 10, 2020

This new DC version brings improvements in the following areas:
 - FW promotion to 0.0.97
 - DSC fixes for supported Docks
 - Fixes eDP display issue
 - Vendor LTTR workarounds
 - Fixes Tiled display audio issue

Anthony Koo (1):
  drm/amd/display: [FW Promotion] Release 0.0.97

Aric Cyr (1):
  drm/amd/display: 3.2.166

Eric Bernstein (1):
  drm/amd/display: ODM + MPO window on only one half of ODM

Martin Leung (1):
  drm/amd/display: implement dc_mode_memclk

Michael Strauss (1):
  drm/amd/display: Force det buf size to 192KB with 3+ streams and
    upscaling

Mikita Lipski (1):
  drm/amd/display: parse and check PSR SU caps

Nicholas Kazlauskas (2):
  drm/amd/display: Set exit_optimized_pwr_state for DCN31
  drm/amd/display: Reset DMCUB before HW init

Solomon Chiu (1):
  drm/amd/display: Add src/ext ID info for dummy service

Wayne Lin (1):
  drm/amd/display: Add debugfs entry for ILR

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   5 +
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 134 ++++++++++++++++++  ..=
./drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c | 101 +++++++++++--  .../displa=
y/dc/clk_mgr/dcn30/dcn30_clk_mgr.c  |  44 +++++-
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  92 ++++++++++++
 .../gpu/drm/amd/display/dc/core/dc_resource.c |  81 ++++++++---
 drivers/gpu/drm/amd/display/dc/dc.h           |   5 +-
 drivers/gpu/drm/amd/display/dc/dc_dp_types.h  |   9 ++
 drivers/gpu/drm/amd/display/dc/dc_types.h     |   1 +
 .../gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c |  14 +-
 .../gpu/drm/amd/display/dc/dcn20/dcn20_hubp.h |   1 +
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    |  10 ++
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.h    |   4 +
 .../gpu/drm/amd/display/dc/dcn30/dcn30_hubp.c |   1 +
 .../drm/amd/display/dc/dcn30/dcn30_hwseq.c    |  11 ++
 .../drm/amd/display/dc/dcn30/dcn30_hwseq.h    |   5 +-
 .../gpu/drm/amd/display/dc/dcn30/dcn30_init.c |   1 +
 .../drm/amd/display/dc/dcn30/dcn30_resource.c |  11 ++
 .../gpu/drm/amd/display/dc/dcn31/dcn31_init.c |   1 +
 .../drm/amd/display/dc/dcn31/dcn31_resource.c |   8 ++
 .../gpu/drm/amd/display/dc/inc/hw/clk_mgr.h   |   7 +
 drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h  |   1 +
 .../gpu/drm/amd/display/dc/inc/hw_sequencer.h |   1 +
 .../dc/irq/dce110/irq_service_dce110.c        |  10 +-
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |   4 +-
 25 files changed, 514 insertions(+), 48 deletions(-)

--
2.32.0

Cc: Daniel Wheeler <Daniel.Wheeler@amd.com>
