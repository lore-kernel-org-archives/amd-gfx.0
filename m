Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC306CA0EFA
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Aug 2025 13:20:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6837710E467;
	Mon, 25 Aug 2025 13:20:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dgeuMrUC";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2066.outbound.protection.outlook.com [40.107.94.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E8BA10E46C
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Aug 2025 13:20:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j1JW5wBJHy/ikxnWE7wDJCZ8d+BVamnPyzhcqpceT9rQAGIpTwgufu+e64JE7A3YlVlnQIGAb8+4nKY7QEoXvTbBY2fbMR2ZgOwvnCgM5rOLqOUt4SIl4ExhZ8JILt++v96TRXpUIERgt8xvqhckyhACALYaKjmQ4suRVojS+59KooXBLTEW0P6XytOh2mJ6W+bU/RF0uadxuC+ut8giKfjP3cBbJeE5vGg/xlxQw+/Q2Qcyoy0SAEXRGBY2obrakEdgL6QChVPuw5cp82qBcA3l1RyEiADAaig/YBpOrTUWgf8mZ82dvkxe42Wtx5gGnSY49LyoxWV4c4xdjy9b3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TAY9LWSdn8a6KQsZpPti1lE0rtfKimntgHtiSI3rp4E=;
 b=YDtcR6JZJlUt+TSXg+aqGNuvS4vtvAW7CiIPlDXzZJgQtlZjGv1kDYSHfJXSy0pJQsta4vW7Xondd1MyVS+0quoolABfOUvIzyxyA+3OjNwLOUyDbVcme8cdvoudxWL/Sp2CFey6a0AWjlJvHrnNAYDzqOcjyTtwGOqW882WsZGhi6B8dvauKWJKKyGRKPeRvp4/KCzzytOm8snmEFVGSUdXI9Uf01Jzh85tn1x79gFEw3CE4/qUX8RakA9FtVB02mOKHhxbHe0g+U8GG/zU7Yaepy3Uq17TManZ81aCoTOvhvXKII4DizC1nSjL4HTHMlYpitm5bafM+L5cgxAESQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TAY9LWSdn8a6KQsZpPti1lE0rtfKimntgHtiSI3rp4E=;
 b=dgeuMrUCxPJEr0KKLtATVEw++WCUAeccnf4rNECmTh/RVb7fAZMFVdKbQu7A80Oa05569VHn21KZBuABz6WxXY9V0L7Q+PYAgvDdRwZrrpTrgXdEHV28IV1zqE0S6qAUcAWrdDvFshZQMIcabsex89pdxjfL2IDGxGFj3o81vPg=
Received: from DS0PR12MB6534.namprd12.prod.outlook.com (2603:10b6:8:c1::19) by
 DM4PR12MB6639.namprd12.prod.outlook.com (2603:10b6:8:be::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.20; Mon, 25 Aug 2025 13:20:23 +0000
Received: from DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::ea87:74ba:36ec:8cf6]) by DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::ea87:74ba:36ec:8cf6%4]) with mapi id 15.20.9052.019; Mon, 25 Aug 2025
 13:20:23 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Wentland, Harry" <Harry.Wentland@amd.com>, "Li, Sun peng (Leo)"
 <Sunpeng.Li@amd.com>, "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>, "Li,
 Roman" <Roman.Li@amd.com>, "Lin, Wayne" <Wayne.Lin@amd.com>, "Chung,
 ChiaHsuan (Tom)" <ChiaHsuan.Chung@amd.com>, "Zuo, Jerry" <Jerry.Zuo@amd.com>, 
 "Wu, Ray" <Ray.Wu@amd.com>, "LIPSKI, IVAN" <IVAN.LIPSKI@amd.com>, "Hung,
 Alex" <Alex.Hung@amd.com>
Subject: RE: [PATCH 00/12] DC Patches for 25 Aug 2025
Thread-Topic: [PATCH 00/12] DC Patches for 25 Aug 2025
Thread-Index: AQHcEg/7kyQHTT/vd0iGb5wBaDzx57RzYYGw
Date: Mon, 25 Aug 2025 13:20:23 +0000
Message-ID: <DS0PR12MB65346B98212438B1EA077A9A9C3EA@DS0PR12MB6534.namprd12.prod.outlook.com>
References: <20250820202103.1122706-1-aurabindo.pillai@amd.com>
In-Reply-To: <20250820202103.1122706-1-aurabindo.pillai@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-08-25T13:19:15.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6534:EE_|DM4PR12MB6639:EE_
x-ms-office365-filtering-correlation-id: d32e6176-cfef-42a5-2876-08dde3da25eb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?ANIPJrwgawFnq+H2NIrdZZZgh85olARWQeiId8ZDX5tZR7xmE6S97Xnv9SyO?=
 =?us-ascii?Q?Te0+yilu4dYtMBxHQrzKkjV0da3WChulLYjRqDv6+dgCvv45XOIuBdqFMPrb?=
 =?us-ascii?Q?7dJqACFuMzZyVGUtDfJOCmfh+bq6nSnuwHjuB3Zpq9VXn97Iv2uob8Jx9oSn?=
 =?us-ascii?Q?5SPpRJZh9GEBEjO6Vg63i/0brREYUZWc+kXEdDxtK+JPaJZd3YYepZhInt9q?=
 =?us-ascii?Q?UG03o4ePFek/s7Ojct4LbCJvyjhriyyc4Rs7ZCYnCQqPsfrkSmQbKrKlKriH?=
 =?us-ascii?Q?EGuRFYmVJ1JpH6Pess38qUMFU978J8Bm4LNCtD9WDPgu5tbh8Q5ozATr+TLd?=
 =?us-ascii?Q?0DxRmCMD6KbAkjuM+AD/q1LBTCHs/zT3XjQ+fZCjIO08DTV7ShUS1OAcffO2?=
 =?us-ascii?Q?lL8eqp4teWSRG4/7hY4z/dHH99B4s61//rVjcRTqLZJe6n0H1iZ1CG5xFE8H?=
 =?us-ascii?Q?4T2Y2rgPkuHADqoZHZh2Q/dzVI/GUXt+3xdtdf89UYWEWx5rWNP3NB18jPPV?=
 =?us-ascii?Q?lwW4jvZlIrdjCy2L3+AbxYJCAlzwdym8zeWUAIgaBnsRO1WF3rwSFEdSgDLi?=
 =?us-ascii?Q?eQ6zqT+9PlEhpiVcD7mTdc/hEnswWJ2LzzxGqOO1mUBXbdzMVoa6TnTXMqn1?=
 =?us-ascii?Q?UyhHQIy3dD0zmhtr+PdJB5IZQcc9NnaRPmfOVQ5dd3hD84o3OEPbP36GDFff?=
 =?us-ascii?Q?AHvrG4QDIq7IsmBBjGMuwmvf2d3GPwjLXy0W+dwKnLkEfN5zfrLRQJGtRq7A?=
 =?us-ascii?Q?QgAQvx9srphdU3oTVrZ/IYxtape5/Ho1oYlw2JUY7dexzE4+Zkbc9x0526I+?=
 =?us-ascii?Q?sMTIAJHJinhBLQ7OllDwv0yBMiw6kGgqBUSjXA0VCtlt0C7aEzGCqyErEO17?=
 =?us-ascii?Q?dIvx7HTyHUnw+5yhCOwZ+hWACxLPo9JTf+zV4zx6wt/2COhchUDT/P17NMrj?=
 =?us-ascii?Q?A+LipdPIp3vQgDGaeBhKNx7dC8FEDQe/9ZGygw8zrofip9ZphtCM2bmpdg50?=
 =?us-ascii?Q?jRpnWQ4Ack6XTzqeGAMrzwWR9VzVMavwbase0HPi4C8GzH5JjIbXh6jRrpuR?=
 =?us-ascii?Q?Hlm0WiFZW+cKgh8eqrbpzJUqvAFP1cPe+AhXuuKdk8cH4qCiqOWlDvwrCz/8?=
 =?us-ascii?Q?h1keSf31WYgoEAZbyacxqYJ9YbPu+ay6H/hWy9Viib3kVLub+8XkZOQJc349?=
 =?us-ascii?Q?SrhC1mXbxtBME57mEANm9zIjZH2Cgbi6xlnNyDdNJm2AUr/xP+WHzpY2YIIg?=
 =?us-ascii?Q?Ba+hFMCMB5P1fjM/mvsRmiK0Go2ioRJ6s8DucjsiqPeU+txGhVbY93mnPBkX?=
 =?us-ascii?Q?gvHYy84BmIY5/miCugmouXWNLQ7ETQvoQwMV8D3NWzwtHj9/ol+ZnQS1gPet?=
 =?us-ascii?Q?GZCNdtaSqDn8F40vLKFwtzzqp0xpvj0fqPU1S1ApoSUq+meAwR0IMQp8FVQL?=
 =?us-ascii?Q?mac6l4Y8+xilMjaNL5cVppq5HXXJTmnKq2SKLC6sYBSVPSwnucD2dA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6534.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?JQBUrf5s9sv9ZKwB+i6hqhIlfMRP27nHryPzDiw47PmHJiM0FdYQtiBSBT6z?=
 =?us-ascii?Q?qi4usHG/aLSCOUI1guRvbwB7yiiL5MoUDs1rwmVcuA3dsIBr2gcy/4WETX9N?=
 =?us-ascii?Q?6Wu+l39VhdijiD5sbAF+0jbumCGc9/j1yTZRnGfTb0SQ5YKP+UdOoDz22x5r?=
 =?us-ascii?Q?fVS5kHINmJTYTrbASNIwHzmzRhc1gFhkQvSSWiE458eSXRxs7iay+965xDFf?=
 =?us-ascii?Q?YNGqpME+vMggO3ACULQcUSMmAYhtRhl/VmpZwuzXXPGM7f+d5X73i0gZdqtm?=
 =?us-ascii?Q?KXyexDIiH62DtBn0goK1e+5UOegwc3SmqU/cIE500NIftnnui1b6qKbzMHDh?=
 =?us-ascii?Q?5+pasERzQTqbkNiRkcNqjXwV+P7ehiINFBjfX+H0H4u4NgqO9Ge7x8oOh4Vq?=
 =?us-ascii?Q?NHzHkI6E3TK72L/oQllaIGZZUntrbTvCLgDqOI7WY3meU/3ECMUC9oPLisvF?=
 =?us-ascii?Q?2YCeXrCMkp+Egly9rBVM2J6wGwwA1XrToQmD6z+fZt2s7QV45gwx2abgoCUH?=
 =?us-ascii?Q?L0uN3CQZwcszfaSa7RXVGczu4Qxrt14J0dcDLE/5aaISo2tJJ3+ksjKd1NmQ?=
 =?us-ascii?Q?gT30X295uuA1fdezPxH+w+uFaGgiFKNxNx1YDwt4Vbrk+cHm3LgCjPjgFca8?=
 =?us-ascii?Q?xsNkeYZFNcYrw+RJoI5RRIm3pGmuMGd5fl2W7AdPpUuQSVekpzQASU9uq/GJ?=
 =?us-ascii?Q?BuXhjPkohF6eh77OTz1T7RZtlnHXdxHvc6Tt002+1mUwbIZgD130dw881r3i?=
 =?us-ascii?Q?XjUKI07+fTCedTH6u2VNI9Q1b990dz24bVE4tgEM981d5Li2DuXCa9UCydPs?=
 =?us-ascii?Q?xQI2Ec2pgC3SuwkYrouTGoXOep1cy+OfCy0RySHqGvMleXd01ksvLB1ouGS2?=
 =?us-ascii?Q?tEzi1bAoaWzbd5AJoznQtHRGLgZJmKJs/hIYX3y14r6tP6GthxpLBRvAnuQX?=
 =?us-ascii?Q?s5JWL8OotrfXuWFbdwXkc6DPfazgonJSVjJLIG3YKOoF10h1rRmSyjc7PP2l?=
 =?us-ascii?Q?dIzUHmnridILSmXnZDpG+uhcZeKYtlrQi7r491YtVr4R2S0gZ0IaQgf9UMBM?=
 =?us-ascii?Q?QUxZr0/bEn5q2x+49vem0+RmZHFjenwIb5y6P6Bnd4p6ASCfDx/NXOU9+JBd?=
 =?us-ascii?Q?ttXxsStZkAxHq6ir5q9S0zYv5WhmPNORpVhYXTbEwPIeKiF7aqVuF5j6yWiP?=
 =?us-ascii?Q?goaI6xuZhkjjJveNULC2NG06b9I9IItEWsAHZmZ6IKZdrss2c5uwMTl6HIu6?=
 =?us-ascii?Q?jpFQSjmAN3BBft93E4ObRGe+OQeHw5XANoKeXwH7QkqnkQqupZAADJbfZL1z?=
 =?us-ascii?Q?0AsOsZ8WSLFK+usdKdWyUT5UTdwFkkqlj9aUDfUUjTXh7F5FD3ZJB4uo2GGU?=
 =?us-ascii?Q?4tm85uw+40hh9OhgHYs32TlFaKRtMdrgUKdAwC7sXm/pU81kz0op1zYdBahn?=
 =?us-ascii?Q?YKB0kkiNDFAGluxzuBiQEt7C7QTIbxINFMTW3e3mNiXuvohBh7zARnhlNWmA?=
 =?us-ascii?Q?T9o6bt3j+ACOKIo7LCk56jT3Ou9i4UzB4ONvGlPGIlw2GoDZC0Z2y/GttIul?=
 =?us-ascii?Q?gt9WDbkvi2ITn5NpLE0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6534.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d32e6176-cfef-42a5-2876-08dde3da25eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2025 13:20:23.4998 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5IBxfGhim7ogEtGmZrL3DFTiNyHUFAQ0uxA+87GfUjyLNXEGFWPKaWO1wC8DddrfCRC1lwCCE/gSunjwOdIVFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6639
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


The patchset consists of the amd-staging-drm-next branch (Head commit -> 64=
4de134936a06a58ae5b90d7eb7b9736dcea140 -> drm/amdgpu: Allocate psp fw priva=
te buffer in vram) with new patches added on top of it.

Tested on Ubuntu 24.04.3, on Wayland and X11, using KDE Plasma and Gnome.

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
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
Sent: Wednesday, August 20, 2025 4:20 PM
To: amd-gfx@lists.freedesktop.org
Cc: Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo) <Sunpeng.L=
i@amd.com>; Pillai, Aurabindo <Aurabindo.Pillai@amd.com>; Li, Roman <Roman.=
Li@amd.com>; Lin, Wayne <Wayne.Lin@amd.com>; Chung, ChiaHsuan (Tom) <ChiaHs=
uan.Chung@amd.com>; Zuo, Jerry <Jerry.Zuo@amd.com>; Wheeler, Daniel <Daniel=
.Wheeler@amd.com>; Wu, Ray <Ray.Wu@amd.com>; LIPSKI, IVAN <IVAN.LIPSKI@amd.=
com>; Hung, Alex <Alex.Hung@amd.com>
Subject: [PATCH 00/12] DC Patches for 25 Aug 2025

This DC patchset brings improvements in multiple areas. In summary, we have=
:

     * Firmware releases for multiple asics
     * CodeQL fixes
     * Fix for double cursor with 180 degree rotation on large resolutions
     * Misc bug fixes for DSC, PSR/Replay, DPIA etc.

___

Ausef Yousof (1):
  drm/amd/display: track dpia support

Clay King (3):
  drm/amd/display: Multiplication result converted to larger type
  drm/amd/display: Incorrect 'not' operator usage
  drm/amd/display: Array offset used before range check

Cruise Hung (1):
  drm/amd/display: Reserve instance index notified by DMUB

Dillon Varone (1):
  drm/amd/display: Consider sink max slice width limitation for dsc

Ivan Lipski (1):
  drm/amd/display: Support HW cursor 180 rot for any number of pipe
    splits

Karthi Kandasamy (1):
  drm/amd/display: Add control flags to force PSR / replay

Nicholas Carbones (1):
  drm/amd/display: DC v3.2.347

Reza Amini (1):
  drm/amd/display: Decrease stack size in logging path

Taimur Hassan (1):
  drm/amd/display: [FW Promotion] Release 0.1.24.0

Yihan Zhu (1):
  drm/amd/display: wait for otg update pending latch before clock
    optimization

 .../gpu/drm/amd/display/dc/basics/dce_calcs.c |  2 +-
 .../drm/amd/display/dc/basics/fixpt31_32.c    |  2 +-
 .../gpu/drm/amd/display/dc/basics/vector.c    |  6 +-
 .../drm/amd/display/dc/core/dc_hw_sequencer.c |  2 +  drivers/gpu/drm/amd/=
display/dc/core/dc_stat.c |  2 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |  2 +-
 drivers/gpu/drm/amd/display/dc/dc_types.h     |  4 +
 .../gpu/drm/amd/display/dc/dce/dce_i2c_hw.c   |  2 +-
 .../gpu/drm/amd/display/dc/dce/dce_i2c_sw.c   |  2 +-
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c |  2 +-
 .../dc/dml/dcn20/display_rq_dlg_calc_20.c     |  2 +-
 .../dc/dml/dcn20/display_rq_dlg_calc_20v2.c   |  2 +-
 .../dc/dml/dcn21/display_rq_dlg_calc_21.c     |  2 +-
 .../dc/dml/dcn30/display_rq_dlg_calc_30.c     |  2 +-
 .../amd/display/dc/dml/dcn302/dcn302_fpu.c    |  2 +-
 .../amd/display/dc/dml/dcn303/dcn303_fpu.c    |  2 +-
 .../dc/dml/dcn31/display_rq_dlg_calc_31.c     |  2 +-
 .../dc/dml/dcn314/display_rq_dlg_calc_314.c   |  2 +-
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  |  4 +-
 .../amd/display/dc/dml/dcn321/dcn321_fpu.c    |  2 +-
 drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c   |  5 ++
 .../amd/display/dc/hwss/dcn10/dcn10_hwseq.c   | 77 +++++++------------
 .../gpu/drm/amd/display/dc/inc/core_types.h   |  1 +
 .../amd/display/dc/inc/hw/timing_generator.h  |  1 +
 .../link/protocols/link_edp_panel_control.c   |  4 +
 .../dc/mmhubbub/dcn20/dcn20_mmhubbub.c        |  2 +-
 .../amd/display/dc/optc/dcn32/dcn32_optc.h    |  1 +
 .../amd/display/dc/optc/dcn35/dcn35_optc.c    | 18 +++++
 .../dc/resource/dce112/dce112_resource.c      | 12 +--
 .../dc/resource/dce120/dce120_resource.c      |  6 +-
 .../dc/resource/dcn30/dcn30_resource.c        |  2 +-
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h   |  3 +
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |  4 +
 .../gpu/drm/amd/display/dmub/src/dmub_dcn35.c |  7 +-  .../drm/amd/display=
/dmub/src/dmub_srv_stat.c  |  8 +-
 35 files changed, 112 insertions(+), 87 deletions(-)

--
2.50.1

