Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BBBCFF885A
	for <amd-gfx@archiver.kernel.org>; Mon,  4 May 2026 13:00:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3665D10E3FC;
	Mon,  4 May 2026 13:00:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="u8dmvh/n";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011023.outbound.protection.outlook.com
 [40.93.194.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B7A9910E3FC
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 May 2026 13:00:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yR0Ue7wB7F5TK/it8fpbKRVGaZBa160FcuTQECw/YuuY4kkGVYZ5D07Urg51jnurX+sM48q+J+De2Vn7zpCU5/8CZh+zk2KWG1ZxgD9roHquwz/PVT5o48pNYHOlGMhU5h7OgKUlDsoEQjKaBOy4SZw4oXAJrrlflWwwCy90QfBiKaItrtQEMqS7xtbfL7efIcQu9YmrDq8V9lVzq1/kixvzpB3as2z4o9H9qm4eIhSs5od+UCORyrTSPyMttVzqKgYzpOI+7pByBrTDJrzuGCEx1U/rkX671MuiqiFZnQeCg+sS/nJjNbYYqXRlHCBL1kObLBpF2wDbU9pk+huRCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QgNB6dNZ2mTDHkabCR8zwV4GFDUjFD1hZ8G/4pApst0=;
 b=Ms5D2FVJY0ru47eMxfMc/wEvZZIyH9nTJPoLyiHQ1RJWd08W3wKbnt9Rxph2YDsKb55p150X/9u4fIFLm1K5tUTfdYiHGMkKabdgrMOEmmECzmtMnC2buUM3wmCTZlX4LM4nQrjx3/jEl2bD8/fUN4luBvKS/RWYkJaJfwi1j1EqTytWtH6IQ2z/O35PpPEqXVHBco7PoCOuLj+hna/CjnRDQQ2QDphtyh9rzhu+fZnxT1iX4mcSQf6kxoS3jtthGMWWrZX/q/nu8jaFEO8YblLuUZS8rcTtXafcgH/qLGG69wR7JiwmeeiaEmGZZyg3scNTl1y3bPe3++m0YlWanQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QgNB6dNZ2mTDHkabCR8zwV4GFDUjFD1hZ8G/4pApst0=;
 b=u8dmvh/njjdonnAK5/MJY5IKGci4MhKgDADT/MK0mt8JIWke4ISfhcaIIeQtJdYDXM2cTU20IKPbwrZBAj6Zr2htv9TVZPpfJeRYiEt1tAe5aucFBVj6I26/2IyxShw8YMYdB2SZybFTtrgSHn2LM1R+G1RdTktlWwl/wo2MUkg=
Received: from DS0PR12MB6534.namprd12.prod.outlook.com (2603:10b6:8:c1::19) by
 CY8PR12MB7290.namprd12.prod.outlook.com (2603:10b6:930:55::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9870.25; Mon, 4 May 2026 12:59:59 +0000
Received: from DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::b2e1:64e5:3b9e:738a]) by DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::b2e1:64e5:3b9e:738a%4]) with mapi id 15.20.9870.023; Mon, 4 May 2026
 12:59:59 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Lin, Ping Lei" <PingLei.Lin@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Wentland, Harry" <Harry.Wentland@amd.com>, "Li, Sun peng (Leo)"
 <Sunpeng.Li@amd.com>, "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>, "Li,
 Roman" <Roman.Li@amd.com>, "Lin, Wayne" <Wayne.Lin@amd.com>, "Chung,
 ChiaHsuan (Tom)" <ChiaHsuan.Chung@amd.com>, "Zuo, Jerry" <Jerry.Zuo@amd.com>, 
 "Wu, Ray" <Ray.Wu@amd.com>, "LIPSKI, IVAN" <IVAN.LIPSKI@amd.com>, "Hung,
 Alex" <Alex.Hung@amd.com>, "Lin, Ping Lei" <PingLei.Lin@amd.com>, "Chen,
 Chen-Yu" <Chen-Yu.Chen@amd.com>
Subject: RE: [PATCH 00/17] DC Patches May 4 2026
Thread-Topic: [PATCH 00/17] DC Patches May 4 2026
Thread-Index: AQHc13rEeFw32HVr9keU/dpaek20KLX93Gmw
Date: Mon, 4 May 2026 12:59:59 +0000
Message-ID: <DS0PR12MB653441BD17BF3A302448032A9C312@DS0PR12MB6534.namprd12.prod.outlook.com>
References: <20260429012055.2065869-1-PingLei.Lin@amd.com>
In-Reply-To: <20260429012055.2065869-1-PingLei.Lin@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Enabled=True;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SetDate=2026-05-04T12:58:46.0000000Z;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Name=AMD Public
 v26; MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_ContentBits=3;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6534:EE_|CY8PR12MB7290:EE_
x-ms-office365-filtering-correlation-id: 2a0560f7-bf34-4f95-4791-08dea9dd0c44
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info: 5JWkRSMEfa6ZGx6wtYowvH+94TzLPE6oKofs4Nur3nTSQ6Ce2/YPABBrPhlLhSSuN2u01vnkE+rwQy+TJ+PdwRhz/81F9C+/lca2V5GrCi0X6JPUeb96wwfyh/vIKQ9/HegDaly6Z0bGDW0TpGJC2QdTBo2iJWXLbcQL+3l+yRW26OSfWhvwr5tvY4p0MHIuW50Vh76SL4J/trJRSyKAIpRIUx9eVasSk0yia1XD+BtgC5fLjc8dAeCB4w4UQbBjcs2Ah/b1Z7QguWc/UJsroLxGfiiUjdjUpoUBC42ght7spHKCBHNUVVm6ONJ/GpLTfvFlazR81LgxLviEX8+LyydJUfkjkBVB1bHDZybHG2EktdkErWi/hoVKkOuquVjTLWbIuJBUCIodQ1LEUgDWBQE3jsU6E2cI+dorNydVG7Zp6WXWw85S+JRBNuK1OgqCO6kl7QjP6ImHuindEOIyJtERaA2+OhBwR7SG2ltewYSQ57Ri+wbtDD5OAZdHjBsyQgZmrKqWXEKoGforvnDNXcnfY6ck7VOj8e0gID7SSmpY27iE6tILZCggE48bCFkkF3KG03QsxRhVVNfsP/R1AuPsuve+bWDeFsIz6LHgn4uFvj3Xya+/sxrA91CAgDUaeIgVY7Tfltq2yZ2Nzt22obu9iizV/oHbiRQbsvR46u+GZq/AlVlVBqe9e0DLHOagmh5ByAxS+qYRKlPyMmKW3DAomDGV+C8DXIoa77bbmEc9hfcYjI987ZAc0Tt2rwE8
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6534.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?3o84qpEYEh18TS47pbyThq1XkQp4x4nysTkxyiwY/OK2R3ymtZ4VkGEVLm?=
 =?iso-8859-1?Q?/4QYcR4ET1CCYqBSbwrqdhB445dzHJgA19jw7YXt0Ay4LXQ5ociw+mRPw4?=
 =?iso-8859-1?Q?+pJS4jYFxZUoS9bv9BF1KR1RbjL2KbkkWXXJjdJ9Hkg/aPsWIxSl+2zrbI?=
 =?iso-8859-1?Q?83YMPxTcoiuI/iF2QYNDcnzp3tk+p3060cRO+Yk5jV1fUBpju1lSKmQoNF?=
 =?iso-8859-1?Q?kHRJ3dkOjGJuE0fR0lEXaXcBMLN0CYLWwWwfrlVaPCZ1uWrBVdXZ6sgGMW?=
 =?iso-8859-1?Q?q5zJH/6omoMmMG+JctEnFywFZ58Qv0Vu7WDLB279CGF2yajElJ3UjH5qXD?=
 =?iso-8859-1?Q?OUJAlPQo1A5u4zUZJRt1E5C6E1pPDR9ee7cLR3+c1etHYm4DGfZEJY5s0M?=
 =?iso-8859-1?Q?hIPI54ORHGFLadnm6Z4NYIkG3h1I5Vy4nc5nnEEpulpkjS3gN2XkSTcb4M?=
 =?iso-8859-1?Q?l7N/qAGfv1ehLGKc/PhQNAEqWfrzJLqeyAPI4N+gaNjJWWrdhcZbybGanx?=
 =?iso-8859-1?Q?8JqtQN5awuduFbmIe21DkkMVdWTdOqI2p+iomDjuPj8M/l4r4jRW1uFuKy?=
 =?iso-8859-1?Q?DVPrZAgL5PoLR82a+OV5VYxg4Owaxa4VOXr6aSliY1H5G/xO84KkgQogvG?=
 =?iso-8859-1?Q?SoQduihzKfNOjK+W+nGFg/k8t//5P/qT0fKNZdHRrDAdO25aomkvLjcvIj?=
 =?iso-8859-1?Q?nyiZPdQzirBWPxORx1wwa1STg5VRV4N/rynHXOI03orE7nWcbwDP2WMV3H?=
 =?iso-8859-1?Q?TN/XWYSHLK/caV4YUILA8nwu/z/+aOgKZLuMFAFAQT4iBzmjO4cDeaoLIj?=
 =?iso-8859-1?Q?frfahLkhd2patOuyU/ZDofZvRPjj2eURHlKEtQqVmMSZVWcvPiPWMquam1?=
 =?iso-8859-1?Q?nJFHXSBoXAMi9WLM6+VOqlrWiKpp05CFA9EJbuGXK7h57AAq4dmoyJwjhi?=
 =?iso-8859-1?Q?XaygJ81gUT2EKMzE2fb/z204X3m6cN9fz0pvGyhFwwO+orBDIob0Gasqs7?=
 =?iso-8859-1?Q?VZ6ALB0eCe/i14pu3U0Z2zVPCAWnsAH4+Td5fLTKjOIe+vkLPepRv8qyKe?=
 =?iso-8859-1?Q?7iCC7He+kovk3+oS933uOOIgAtp3TXupSPuWMMZxMU1SecXcLjLFY9bh4o?=
 =?iso-8859-1?Q?KnguoEqrQpGbzegvkt296AOZu0VklRTzkhbZXRdPNglu5XBZ8efBz0eGeg?=
 =?iso-8859-1?Q?JFv6C38sIhQb6YHnRSVjVIov17p0t8ipqmtSu4KIIlwiab0ghUeAQVsxDF?=
 =?iso-8859-1?Q?HZPqTw2EkglApTm/6luOY7GxNP08BS8hBcE1sMIHmLC6LdhNn2iZr+f43K?=
 =?iso-8859-1?Q?JGoP2BgIp221G4oiIxf2+QAl0SPwnpLQTTN0DOMiH4fa/26wNOQTYyebhS?=
 =?iso-8859-1?Q?6oMb3Y6wG0FiZBAGNUIm0UC/g7kCeTm123QOMiEvSM1KTwdg9zvMDsdx91?=
 =?iso-8859-1?Q?mzinZXUryEz3/IjNUO++kl6mMCcf7raNxRnCTORkepkw44Z8iIrts+wSDp?=
 =?iso-8859-1?Q?zv/Hq9GcXONFgRAglg4l7TmuJTuvwzyfyGmbOxW+1q0R+oevcVystTaRez?=
 =?iso-8859-1?Q?tcerRWrF6KkV9qXRybfGwIpG+8TtDCncg2KkOaPqAJt2oORGTJL93fbBP7?=
 =?iso-8859-1?Q?lboMEb+5pkrBjTmG3VZX0vkwbGv0/VNP6R0nkA8itMfrCb7hbarXLxAW4Q?=
 =?iso-8859-1?Q?PzhpEekoV7KHtjc5ri5OdgK9ieZkbq/tgmNl4pEZG0MhIchCA6kFuHf02O?=
 =?iso-8859-1?Q?SdGs7RYZaOvqKntW3xcPYUOTc7OdzkRFVMtV0Vm2m1OJVo?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6534.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a0560f7-bf34-4f95-4791-08dea9dd0c44
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2026 12:59:59.1676 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CAP6Mtpxy2/GNWCQz58l1uMOXHBMcugIrvvksSBEyB1qTbUFQsnTNfhQ16rxR7HBi3PGmHIWzGdN3GOXHfFPrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7290
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

Public

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


The patchset consists of the amd-staging-drm-next branch (Head commit - 539=
967e4c9779aa65da1122fb24e7a777f4bc1c9 -> drm/amd/display: Promote DC to 3.2=
.380) with new patches added on top of it.

Tested on Ubuntu 24.04.4, on Wayland and X11, using Gnome.

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
From: James Lin <PingLei.Lin@amd.com>
Sent: Tuesday, April 28, 2026 9:19 PM
To: amd-gfx@lists.freedesktop.org
Cc: Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo) <Sunpeng.L=
i@amd.com>; Pillai, Aurabindo <Aurabindo.Pillai@amd.com>; Li, Roman <Roman.=
Li@amd.com>; Lin, Wayne <Wayne.Lin@amd.com>; Chung, ChiaHsuan (Tom) <ChiaHs=
uan.Chung@amd.com>; Zuo, Jerry <Jerry.Zuo@amd.com>; Wheeler, Daniel <Daniel=
.Wheeler@amd.com>; Wu, Ray <Ray.Wu@amd.com>; LIPSKI, IVAN <IVAN.LIPSKI@amd.=
com>; Hung, Alex <Alex.Hung@amd.com>; Lin, Ping Lei <PingLei.Lin@amd.com>; =
Chen, Chen-Yu <Chen-Yu.Chen@amd.com>
Subject: [PATCH 00/17] DC Patches May 4 2026

Start from:
3bba7c80f8576f0cf68753abe25c1ca2a0f17018
SWDEV-553782 - test/diags: tcd-tts mapping - keyword search (#28664)

Stopped at:
6ee9f5160ad6e0bf672329f7680398e718fc56f5
SWDEV-114487 - modules: [BACKPORT] drm/amd/display: Fix divide by zero in c=
alc_psr_num_static_frames

This version brings along following update:
-add max bandwidth budget to QoS interface -Update tmz field for LSDMA -fix=
 buffer overruns warnings -add memory bandwidth override debug interface -F=
ind link encoder for flexible DIG mapping cases -Fix type mismatches using =
guards and explicit casts -Fix type mismatches in DC and DMUB modules -Skip=
 HDR metadata update when Smart Power OLED enabled -Rename backlight_proper=
ties to pwr_backlight_properties -remove watermark range notify -Clean Up L=
egacy DML Content -Implement block sequencing infrastructure for modular ha=
rdware operations. -Do DML float narrowing explicit -Fix type mismatches in=
 DML and normalize loop bounds -Remove unused state param from enable_link_=
analog -Fix Color Manager (3DLUT, Shaper, Blend)

Alex Hung (1):
  drm/amd/display: Remove unused state param from enable_link_analog

Alvin Lee (1):
  drm/amd/display: Update tmz field for LSDMA

Bhuvanachandra Pinninti (1):
  drm/amd/display: Implement block sequencing infrastructure for modular
    hardware operations.

Charlene Liu (1):
  drm/amd/display: remove watermark range notify

Dillon Varone (1):
  drm/amd/display: Fix Color Manager (3DLUT, Shaper, Blend)

Gaghik Khachatrian (5):
  drm/amd/display: Fix type mismatches in DML and normalize loop bounds
  drm/amd/display: Do DML float narrowing explicit
  drm/amd/display: Fix type mismatches in DC and DMUB modules
  drm/amd/display: Fix type mismatches using guards and explicit casts
  drm/amd/display: fix buffer overruns warnings

Ian Chen (1):
  drm/amd/display: Skip HDR metadata update when Smart Power OLED
    enabled

Ovidiu Bunea (1):
  drm/amd/display: Find link encoder for flexible DIG mapping cases

Ray Wu (1):
  drm/amd/display: Rename backlight_properties to
    pwr_backlight_properties

Taimur Hassan (1):
  drm/amd/display: Promote DC to 3.2.381

Wenjing Liu (2):
  drm/amd/display: add memory bandwidth override debug interface
  drm/amd/display: add max bandwidth budget to QoS interface

Zheng, Austin (1):
  drm/amd/display: Clean Up Legacy DML Content

 .../drm/amd/display/dc/basics/conversion.c    |   2 +-
 .../gpu/drm/amd/display/dc/basics/dce_calcs.c |   4 +-
 .../dc/clk_mgr/dce110/dce110_clk_mgr.c        |   6 +-
 .../display/dc/clk_mgr/dcn10/rv1_clk_mgr.c    |   2 +-
 .../display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c  |  11 +-  .../amd/display/dc=
/clk_mgr/dcn21/rn_clk_mgr.c |  30 +-  .../display/dc/clk_mgr/dcn30/dcn30_cl=
k_mgr.c  |  17 +-
 .../display/dc/clk_mgr/dcn301/vg_clk_mgr.c    |  30 +-
 .../display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c  |  41 +-
 .../dc/clk_mgr/dcn314/dcn314_clk_mgr.c        |  55 +-
 .../dc/clk_mgr/dcn315/dcn315_clk_mgr.c        |  53 +-
 .../dc/clk_mgr/dcn316/dcn316_clk_mgr.c        |  43 +-
 .../display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c  |  21 +-  .../display/dc/clk=
_mgr/dcn35/dcn35_clk_mgr.c  | 111 +--
 .../dc/clk_mgr/dcn401/dcn401_clk_mgr.c        |  19 +-
 .../display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c  |  26 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 643 +++++++++++++++---
 .../drm/amd/display/dc/core/dc_hw_sequencer.c | 597 ++++++++++++++--  .../=
drm/amd/display/dc/core/dc_link_enc_cfg.c |  11 +-  .../gpu/drm/amd/display=
/dc/core/dc_resource.c |  67 +-
 .../gpu/drm/amd/display/dc/core/dc_state.c    |   4 +-
 .../gpu/drm/amd/display/dc/core/dc_stream.c   |  14 +-
 .../gpu/drm/amd/display/dc/core/dc_surface.c  |   6 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |  74 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  |  11 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h  |   9 +-
 drivers/gpu/drm/amd/display/dc/dc_helper.c    |   4 +-
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |   1 +
 drivers/gpu/drm/amd/display/dc/dc_types.h     |  24 -
 drivers/gpu/drm/amd/display/dc/dce/dce_ipp.c  |   2 +-
 .../drm/amd/display/dc/dce/dce_link_encoder.c |   3 +-
 .../drm/amd/display/dc/dce/dce_transform.c    |   4 +-
 .../gpu/drm/amd/display/dc/dce/dmub_abm_lcd.c |   2 +-
 .../amd/display/dc/dcn10/dcn10_cm_common.c    |  12 +-
 .../dc/dcn10/dcn10_hw_sequencer_debug.c       |  22 +-
 .../drm/amd/display/dc/dcn20/dcn20_dwb_scl.c  |   2 +-
 .../amd/display/dc/dcn30/dcn30_cm_common.c    |   8 +-
 .../display/dc/dio/dcn10/dcn10_link_encoder.c |  11 +-
 .../dc/dio/dcn30/dcn30_dio_stream_encoder.c   |   6 +-
 .../drm/amd/display/dc/dml/calcs/dcn_calcs.c  |   9 +-
 .../drm/amd/display/dc/dml/dcn20/dcn20_fpu.c  |  34 +-
 .../dc/dml/dcn20/display_mode_vba_20.c        |  36 +-
 .../dc/dml/dcn20/display_mode_vba_20v2.c      |  36 +-
 .../dc/dml/dcn21/display_mode_vba_21.c        |  36 +-
 .../drm/amd/display/dc/dml/dcn30/dcn30_fpu.c  |  14 +-
 .../dc/dml/dcn30/display_mode_vba_30.c        |  83 +--
 .../amd/display/dc/dml/dcn301/dcn301_fpu.c    |   5 +-
 .../amd/display/dc/dml/dcn302/dcn302_fpu.c    |   2 +-
 .../amd/display/dc/dml/dcn303/dcn303_fpu.c    |   2 +-
 .../drm/amd/display/dc/dml/dcn31/dcn31_fpu.c  |  15 +-
 .../dc/dml/dcn31/display_mode_vba_31.c        | 121 ++--
 .../amd/display/dc/dml/dcn314/dcn314_fpu.c    |   5 +-
 .../dc/dml/dcn314/display_mode_vba_314.c      | 129 ++--
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  |  75 +-
 .../dc/dml/dcn32/display_mode_vba_32.c        |  21 +-
 .../dc/dml/dcn32/display_mode_vba_util_32.c   |   2 +-
 .../amd/display/dc/dml/dcn321/dcn321_fpu.c    |  46 +-
 .../drm/amd/display/dc/dml/dcn35/dcn35_fpu.c  |   5 +-
 .../amd/display/dc/dml/dcn351/dcn351_fpu.c    |   5 +-
 .../drm/amd/display/dc/dml/display_mode_vba.c |   4 +-
 .../drm/amd/display/dc/dml/dml_inline_defs.h  |  18 +-
 .../dml21/src/dml2_mcg/dml2_mcg_dcn42.c       |   2 +-
 .../dml21/src/dml2_top/dml2_top_legacy.h      |   9 -
 .../amd/display/dc/dpp/dcn10/dcn10_dpp_cm.c   |   2 +-
 .../amd/display/dc/dpp/dcn10/dcn10_dpp_dscl.c |   2 +-
 .../drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c  |  13 +-
 .../amd/display/dc/dpp/dcn401/dcn401_dpp_cm.c |   2 +-
 .../display/dc/dpp/dcn401/dcn401_dpp_dscl.c   |   2 +-
 drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c   |  13 +-
 .../drm/amd/display/dc/dsc/dcn20/dcn20_dsc.c  |   3 +-
 .../amd/display/dc/dsc/dcn401/dcn401_dsc.c    |   3 +-
 .../hpo/dcn31/dcn31_hpo_dp_stream_encoder.c   |   2 +-
 .../display/dc/hubbub/dcn401/dcn401_hubbub.c  |   7 +-
 .../display/dc/hubbub/dcn42/dcn42_hubbub.c    |   5 +-
 .../amd/display/dc/hubp/dcn20/dcn20_hubp.c    |   2 +-
 .../amd/display/dc/hubp/dcn401/dcn401_hubp.c  | 201 ++----  .../amd/displa=
y/dc/hubp/dcn401/dcn401_hubp.h  |  23 +-
 .../amd/display/dc/hubp/dcn42/dcn42_hubp.c    |  78 +--
 .../amd/display/dc/hubp/dcn42/dcn42_hubp.h    |  10 +-
 .../amd/display/dc/hwss/dce110/dce110_hwseq.c |  38 +-
 .../amd/display/dc/hwss/dcn10/dcn10_hwseq.c   |  55 +-
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   |  34 +-
 .../amd/display/dc/hwss/dcn21/dcn21_hwseq.c   |   2 +-
 .../amd/display/dc/hwss/dcn30/dcn30_hwseq.c   |  15 +-
 .../amd/display/dc/hwss/dcn31/dcn31_hwseq.c   |  12 +-
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.c   |  32 +-
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   |  68 +-
 .../amd/display/dc/hwss/dcn351/dcn351_hwseq.c |   2 +-
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c | 432 ++++++++----
 .../amd/display/dc/hwss/dcn42/dcn42_hwseq.c   | 520 ++++++++++++--
 .../amd/display/dc/hwss/dcn42/dcn42_hwseq.h   |   9 +-
 .../drm/amd/display/dc/hwss/hw_sequencer.h    | 353 ++++++++--
 .../gpu/drm/amd/display/dc/inc/core_types.h   |  10 +-
 .../gpu/drm/amd/display/dc/inc/hw/clk_mgr.h   |  22 +
 drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h  |  35 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h   |  79 +--
 .../amd/display/dc/inc/hw/stream_encoder.h    |   1 +
 .../display/dc/inc/soc_and_ip_translator.h    |  19 +-
 .../drm/amd/display/dc/link/link_detection.c  |   6 +-
 .../gpu/drm/amd/display/dc/link/link_dpms.c   |  10 +-
 .../drm/amd/display/dc/link/link_factory.c    |   2 +-
 .../drm/amd/display/dc/link/link_validation.c |   4 +-
 .../dc/link/protocols/link_dp_capability.c    |   4 +-
 .../dc/link/protocols/link_dp_dpia_bw.c       |   2 +-
 .../dc/link/protocols/link_dp_irq_handler.c   |   2 +-
 .../dc/link/protocols/link_dp_training.c      |   4 +-
 .../drm/amd/display/dc/mpc/dcn10/dcn10_mpc.c  |   2 +-
 .../amd/display/dc/mpc/dcn401/dcn401_mpc.c    | 177 +++--
 .../amd/display/dc/mpc/dcn401/dcn401_mpc.h    |  25 +-
 .../drm/amd/display/dc/mpc/dcn42/dcn42_mpc.c  | 388 ++++++++++-  .../drm/a=
md/display/dc/mpc/dcn42/dcn42_mpc.h  |  49 +-
 .../amd/display/dc/optc/dcn10/dcn10_optc.c    |   2 +-
 .../amd/display/dc/pg/dcn35/dcn35_pg_cntl.c   |   6 +-
 .../amd/display/dc/pg/dcn42/dcn42_pg_cntl.c   |   4 +-
 .../dc/resource/dcn42/dcn42_resource.c        |   1 -
 .../dcn42/dcn42_soc_and_ip_translator.c       |   6 +-
 .../drm/amd/display/dmub/src/dmub_dcn401.c    |   2 +-
 .../gpu/drm/amd/display/dmub/src/dmub_dcn42.c |   2 +-
 .../amd/display/modules/color/color_gamma.c   |  12 +-
 .../gpu/drm/amd/display/modules/power/power.c |  28 +-
 .../gpu/drm/amd/display/modules/vmid/vmid.c   |   6 +-
 121 files changed, 3870 insertions(+), 1702 deletions(-)  delete mode 1006=
44 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_top/dml2_top_legacy=
.h

--
2.43.0

