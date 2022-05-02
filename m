Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89123C433EF
	for <amd-gfx@archiver.kernel.org>; Mon,  2 May 2022 16:15:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 10BFE88584;
	Mon,  2 May 2022 16:15:06 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2077.outbound.protection.outlook.com [40.107.220.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B6A588584
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 May 2022 16:15:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jk4JjKsPqq9Ir/4X9dI7jM3Qxt+j3WqWD9tpofOVhlTmnihMNp7+pCpbpyiL2SOby3nlRDzvgyB1QrTH9EEK1sErpfVHwcGnmgnlvNLO6E4nkJut1pXLZ+DDgArP2rK/Q0hjyfyAUT60YVYBwuNka0/DDyBUWv9ZU0EIv2JV8foFBIpf113gHf6Om8UGuTEN9dd8ohIO114vPqDohrsuwLWFf+cJJQ6xAxO5RzobueACXFxCGcjre/r4wxS5p3are9kzDnrb9YnIVZYn1Qi+VFUJHWL481ShOeZTYi45RYfDqq2s9SAIWw5M8t0zltEB+G0id5S8OoJe4tj9pAR89Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UWlJDyxwKxZAWwgbS8G5oQXlpTrUpWgCC+vuDBcht88=;
 b=eLA8LjBbM3GORTj/5LlGF2JlLWPPbYaglDLiibkFfVjxoGmoEjM/HmEhJfYMHPUQXsQCs8JKNMCUSZxFud8u4CsDM/uBLWejHHR37U9h6WTCDsfyiUxC72MfNDf6T2OBAWBR0mSVesKvVO8DYnfYHBSRNTHU1593XbKB0mSg6mIULwdu32gHQGogdrYLz0wf4vgtrLz6PRmQ/3Ve/p6kV7bmd5RomFeDVhC+niCLknK3fC8P5AthXurLmIDMtvViDbX6szu5ioV3tV40D3nmuwbdvLcCJm8srUTQP5RizWspDGxu9B470FzWKyEPDYFqA6tHaB2sBFb/Vf4+kxCTbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UWlJDyxwKxZAWwgbS8G5oQXlpTrUpWgCC+vuDBcht88=;
 b=vjRyKCcM8f9MXAlB4jLN/3hRhFU/nW/MBzriWiUteH9Bnm+IfW2pjA5rNKL8pbJXdxo6PRMhJBvb/a5u4XEs1othnhj1M1RXrPa8tlZp/t9ewrMwbDSmZYnCOKDzWrdtmOoIrAVOA5n4+M6T1C2snqpq6XZwEGnE5x7PHSiUQYo=
Received: from DM6PR12MB3529.namprd12.prod.outlook.com (2603:10b6:5:15d::18)
 by DM6PR12MB3692.namprd12.prod.outlook.com (2603:10b6:5:14a::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Mon, 2 May
 2022 16:14:56 +0000
Received: from DM6PR12MB3529.namprd12.prod.outlook.com
 ([fe80::d145:13bb:e6b8:3429]) by DM6PR12MB3529.namprd12.prod.outlook.com
 ([fe80::d145:13bb:e6b8:3429%3]) with mapi id 15.20.5186.028; Mon, 2 May 2022
 16:14:56 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Lin, Wayne" <Wayne.Lin@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 0/8] DC Patches April 27, 2022
Thread-Topic: [PATCH 0/8] DC Patches April 27, 2022
Thread-Index: AQHYWeAnBLt8yY9TX0KzTFlOiKY6ea0Ly5xg
Date: Mon, 2 May 2022 16:14:56 +0000
Message-ID: <DM6PR12MB35299525D4A359A7A30E1C7B9CC19@DM6PR12MB3529.namprd12.prod.outlook.com>
References: <20220427023959.1241450-1-Wayne.Lin@amd.com>
In-Reply-To: <20220427023959.1241450-1-Wayne.Lin@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-05-02T16:14:22Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=dc0c9cb6-b99e-41dc-948d-a71c52150b7e;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-05-02T16:14:55Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: e344819f-8112-400f-835e-a30167c9ee4b
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 32a729b7-29fe-463f-8d2a-08da2c56e61e
x-ms-traffictypediagnostic: DM6PR12MB3692:EE_
x-microsoft-antispam-prvs: <DM6PR12MB3692F06AD00C6CF95143E0499CC19@DM6PR12MB3692.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cmPCKa+1durRncL0AjmEF03OZ3s+YchIFA2sF8WZ6+vb7UmnXQmFuG5q3J7VZw6eUgWDnBMKh8cxdh3RwWvaDhuE3PenwgJwdAucpHIXVjR0F2vIEfP2S0OK/GW9R/vUlOWu18Q/09XhqMu1BMxJ4/RBtyew9DXwt5nafsonodsvHxefYkMcRgknbLRZWz7kBSnqS+JLlLD+DfbZoZmvjlTTM4p4DAzRWz8HaVLqEggko1Vs7vroqKMejqYzzXAjk/dZIwnu1/PeQG4rx2lXFPV2hzXxhrd6eg0F9m9w96yD1S3bf+y3qJxz9TaG0XvTlEyAWPkngGhxKlwOrdjEtHeJeDtSFRLUujrGfH+JA1W3GYr6A2k2FCocF3g6JV5rlGfW20aXDVAdHiS60xgoi3u5hqWrBByqCja/TzUAufumhuEjOSZFmcWZSyacMOHC6TyIgt8NKBqTnCxY+qogLnjRVLxFclINEY7nH+Uxiny3I/rvLL0tA7ke9jfghwISIAU/U375VfiCIeT7Ttbm+GqHpRI/RA3wjmqVo/7fF9htVr4otxc2ADRuSPxgYXJZFciejbauXC+y8uf1s4nEvtdZ7pNHOxkReBUgb/NZIgrAySUIv14YmqQ8tnOYHYAvDjZE7XE9nHGOVl8Th1xaK1RrCnX/qbaa3tMxvOfNfJRJFOlpaqTit73RG8EG17h6acCdCaBeV1xd3YC4270bYg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3529.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(54906003)(110136005)(508600001)(55016003)(6506007)(9686003)(7696005)(53546011)(83380400001)(186003)(66556008)(86362001)(66946007)(66476007)(66446008)(64756008)(71200400001)(52536014)(4326008)(8676002)(2906002)(26005)(5660300002)(33656002)(8936002)(76116006)(38100700002)(122000001)(38070700005)(316002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2++ebQ5r5Awa4H2OJep13Qk9OPTxqP23/kKLDDsa0fBMiQdsZZ8CpjANwukT?=
 =?us-ascii?Q?8frKJ90kzc75VVZdoEVxt7eZO1CCTNE185f9zS/p9A8EJztcqDqkmuB5W0k2?=
 =?us-ascii?Q?QjFgfxzGePeOU9pogKZsrOmSn7JraKoWTzUJi5LuFp3IsmGeXpkOaddcVdoX?=
 =?us-ascii?Q?L7F7frdoLFIBAaY+6IOACM+Ztp5JbC/St/KQl2MFSnKlehmMpkIXsvkCH+TF?=
 =?us-ascii?Q?pP6B4oLhPRKuj/V+sLTfEC/CPkppn7HzcRqs2T3MmrJrk41OsU8nTjRP8flW?=
 =?us-ascii?Q?XkN28WrMOCFBgBY1t2CdY5uD31o/gw5TmLG6dB+1MtNMCU8RT25ily9+hOYm?=
 =?us-ascii?Q?LtEQNb0dPPPJa46LEzCSOjLGAO2AWAhyF+MxzqI86p6NpHAzLMVMo3NV16Ki?=
 =?us-ascii?Q?z6GW8zQwwk9WpXClbaEmaPIDo1TFcFi3HgnHgz4+B2ZUR92hLIvUxbn9VSaw?=
 =?us-ascii?Q?3XB1+TELoPLZU6GPMQDLuq9c8WLvl+wqCyUmmt5AcQbiAefkPUNeACV6VGCf?=
 =?us-ascii?Q?6gpBi/s3C2hk+en5n/9/VThEtjrzXSzFc17FNFNdUr6pBXYv+hN8KzlUdhsS?=
 =?us-ascii?Q?QdfrbJf+y+0sEyziuk0jR6UJm8havrAWUWjp6juGtT3P2cgphfbqR3aEN+g6?=
 =?us-ascii?Q?1af1XPhOyh1Pzh/7n/Rwp/vrVbyKOG27Y9mX2d1iMf0hkUhlZM0yaR82L27U?=
 =?us-ascii?Q?nRli2xBdoXR7aS+Yh9MmBZfGpxiIYSdn4P5fMCNxPywbVUoMoDzE3UJFTcNj?=
 =?us-ascii?Q?faDLpDxGeiivVUEeiU4lG5oUwBZJgcRzbWkSemrmnDdGdndntPreFyIAbTVn?=
 =?us-ascii?Q?Cwn3+h1Ct7207jEnsFBPiRm/EFcmIAoBHvg9JCyv23Tr0xkNstyn1sZQBtTa?=
 =?us-ascii?Q?dw3kj4FtY04yqU+jmOPZm5viY5NFG3REv+W0YUlQJGcGHhG8X5jAa8W9suXi?=
 =?us-ascii?Q?IwTABhMpjsTIBrsZS34OfJN6erxQHuAMa6n28bj3RTSN9YTxD2JDhEgV2Q3+?=
 =?us-ascii?Q?T4koI9dPusF6hEzuotpqU//4J4mAfhcfVcswFrrBZQ9etWsZZII6LXF2nAfv?=
 =?us-ascii?Q?0T+530s8maEoFvokQFSa/h4u/s45UcEAyhCHD6Qjfww+hEQJhnZlT+qq+/GV?=
 =?us-ascii?Q?9k/K1nNO0MsdHS6XFuNA1u3Oc14u4bMPwk4KkvCWuUsnkytGQl+oON08GE1E?=
 =?us-ascii?Q?yUkS1Ro+8y/DdofE87NsjZ9xy7Owj4BBU/KsH3ZFlpCgnXVycegz5FtMoVQq?=
 =?us-ascii?Q?v0o4MA+/JYBzbeTJLl1QM0Vnlps7YVLw4JB6IDDiaMdHnRY15qeHx8wWlSc+?=
 =?us-ascii?Q?4AHQHADJgmf6a3XMvLrMZOW/aGdKsd1sqXHXe00JLH/LFJJy3i2Z5cPkOcfl?=
 =?us-ascii?Q?+t/ZjYD/s4ErXjaDIvDBOcewaP08T3YXHsj8uLUp5hAdfS/MedEL1WV5m8KC?=
 =?us-ascii?Q?M20XshpOKfoksUBZQA9cQHNWWPFw66Pur6hL2PAEqKzqPmu2DUFLcymFGn1e?=
 =?us-ascii?Q?P3RtJaT82mlF1LQbGFdZwYo1W5oFeaGF7BspTMQisjAtCDHl8tF2rU0QhDmH?=
 =?us-ascii?Q?HbZ9ESlDLKcOJ0qPglvjABhBhavzDZnxMII7TGodWVptniRZzahp0xbyj9Nc?=
 =?us-ascii?Q?idz+a0+TzFydU2OcCbqOtzcgn+LRrACgKGStYtZgThVbMexUWy1Je69E8noi?=
 =?us-ascii?Q?IIg7bw4+Il4rGnnOFQrtxLlID6cClH8cazjy3M2PlF/EcQ1s?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3529.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32a729b7-29fe-463f-8d2a-08da2c56e61e
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2022 16:14:56.5761 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DHKptU3AI6GQmLVAa3/m/37FLd9RQt5kv8niYfwU1Gu5hPX6OCP6Q3eiheK9uYIjE4CbiGC7XYIkUhaT+ZmYLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3692
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
 Sun peng \(Leo\)" <Sunpeng.Li@amd.com>, "Lakha,
 Bhawanpreet" <Bhawanpreet.Lakha@amd.com>, "Zhuo, 
 Qingqing \(Lillian\)" <Qingqing.Zhuo@amd.com>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>, "Li, Roman" <Roman.Li@amd.com>, "Chiu,
 Solomon" <Solomon.Chiu@amd.com>, "Pillai,
 Aurabindo" <Aurabindo.Pillai@amd.com>, "Lin, 
 Wayne" <Wayne.Lin@amd.com>, "Wentland, Harry" <Harry.Wentland@amd.com>,
 "Gutierrez, Agustin" <Agustin.Gutierrez@amd.com>, "Kotarac,
 Pavle" <Pavle.Kotarac@amd.com>
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
Included testing using a Startech DP 1.4 MST hub at 2x 4k 60hz and DSC via =
USB-C to DP DSC Hub with 3x 4k 60hz.
=20
Tested on Ubuntu 22.04 with Kernel Version 5.16
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
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Wayne Li=
n
Sent: April 26, 2022 10:40 PM
To: amd-gfx@lists.freedesktop.org
Cc: Wang, Chao-kai (Stylon) <Stylon.Wang@amd.com>; Li, Sun peng (Leo) <Sunp=
eng.Li@amd.com>; Wentland, Harry <Harry.Wentland@amd.com>; Zhuo, Qingqing (=
Lillian) <Qingqing.Zhuo@amd.com>; Siqueira, Rodrigo <Rodrigo.Siqueira@amd.c=
om>; Li, Roman <Roman.Li@amd.com>; Chiu, Solomon <Solomon.Chiu@amd.com>; Pi=
llai, Aurabindo <Aurabindo.Pillai@amd.com>; Lin, Wayne <Wayne.Lin@amd.com>;=
 Lakha, Bhawanpreet <Bhawanpreet.Lakha@amd.com>; Gutierrez, Agustin <Agusti=
n.Gutierrez@amd.com>; Kotarac, Pavle <Pavle.Kotarac@amd.com>
Subject: [PATCH 0/8] DC Patches April 27, 2022

This DC patchset brings improvements in multiple areas. In summary, we high=
light:

* Have optc3 function accessible to newer DCN
* Add CM boot option for USB4 tunneling
* Fix system hang issue when game resolution is changed
* Remove outdated register for dcn3+
* Add new DSC interface to disconnect from pipe
* Clean up pixel format types in enum surface_pixel_format

---

Anthony Koo (1):
  drm/amd/display: [FW Promotion] Release 0.0.115.0

Aric Cyr (2):
  drm/amd/display: Clean up pixel format types
  drm/amd/display: 3.2.184

Eric Bernstein (1):
  drm/amd/display: Add new DSC interface to disconnect from pipe

Evgenii Krasnikov (1):
  Revert "drm/amd/display: Reset cached PSR parameters after hibernate"

Jimmy Kizito (1):
  drm/amd/display: Add Connection Manager boot option.

Lee, Alvin (1):
  drm/amd/display: Make OPTC3 function accessible to other DCN

Tse, Kaitlyn (1):
  drm/amd/display: Remove outdated register for dcn3+

 drivers/gpu/drm/amd/display/dc/core/dc_link.c |  7 +---
 drivers/gpu/drm/amd/display/dc/dc.h           |  2 +-
 drivers/gpu/drm/amd/display/dc/dc_hw_types.h  |  3 +-  .../gpu/drm/amd/dis=
play/dc/dcn20/dcn20_dsc.c  | 11 ++++++  .../gpu/drm/amd/display/dc/dcn30/dc=
n30_mpc.h  |  5 ---  .../gpu/drm/amd/display/dc/dcn30/dcn30_optc.h |  2 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/dsc.h   |  1 +
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h   |  1 +
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 36 ++++++++++++++++++-
 .../gpu/drm/amd/display/dmub/src/dmub_dcn31.c |  1 +
 10 files changed, 54 insertions(+), 15 deletions(-)

--
2.36.0
