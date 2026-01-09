Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D104D26D7D
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Jan 2026 18:50:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B325F10E300;
	Fri,  9 Jan 2026 18:50:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mbzCHd5P";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012013.outbound.protection.outlook.com [40.107.209.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B9FA10E300
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Jan 2026 18:50:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BZyKlQKeJoso1dEFXVuoCBkkdxIIh9mNnJjz/PsO2JCSRsF6ki3nlIReMCcKNd3E5CGw8Lncd9xCKhcUDpWz+1fknWQVFmHNQYhtMoAbm5xE/NyAA6GAsBQWJkFHuGeNLqoLl7Sn3oP45lkLCca8+lJ05ADK3X/q89fFxLIc70QhJ4ws0hCgAWdbk/mR5j7oFZSJtqfiVEV3HwhQ8PlRubNG45OeXxB8f2q+ytwy+i+PKY5/X6LS3KyLbFm9F6e4r8UywKYSa3a83RhguQlIos7w+EdUwhqRjTUSY5IuSh9F74goDXSF5kcS0lwmQxPy4HWtCg32YodblPOFs0Vmew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q9TQN5Uf122KVd4sS6g/jqxmv5z+9flyv/Trx9Eui5c=;
 b=T2USfSdbCdv70FArSIMQ2nHhMnJ4sDRgTPBDvjjtAyXMdLoqqx5RrbHSona4bYeOTpYln2n6hlxhDrIVGRerZtvBGvjzq+PBgncfuo5RScUcLZyewbQ2wvMxL5T0Kc3cx6kFA8RIuEf3cYuxyfdaAiyv0+SRTqm8RY0b/cYTlru9s+bNOSw2SImVwX8A1fHwsGe+1a1Y5mhG0HDhlK2EpjlLo6Qu66fqLM4UxlHoPK+WoxZ56f1r0yAegP/V1GyWm0gA2hGgUqrCayDyB5oc66E88s5XCDFUQrH1Koh06PFmxcltRQXyk4eoSA59ICx7+uTWNHnaBEqw+FOKXDX1RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q9TQN5Uf122KVd4sS6g/jqxmv5z+9flyv/Trx9Eui5c=;
 b=mbzCHd5PCUjVlW+RnE3gZehwbDVYiH3znYTJjmYVJGc/FDU2JU9Oe2sJ9B7H64dMC/ks+fiR5bpnvaXZ7kaImbPLnM2lnp1+NgZJf7iyhX7dipYsnqcaX/gFu5xJsQHHVGJRTSsxyJT2bctqX3aPq2yNvLRqD4B81f6tx6JlZaQ=
Received: from CY5PR12MB6527.namprd12.prod.outlook.com (2603:10b6:930:30::13)
 by IA1PR12MB9032.namprd12.prod.outlook.com (2603:10b6:208:3f3::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.5; Fri, 9 Jan
 2026 18:50:11 +0000
Received: from CY5PR12MB6527.namprd12.prod.outlook.com
 ([fe80::325b:6e02:14e4:9092]) by CY5PR12MB6527.namprd12.prod.outlook.com
 ([fe80::325b:6e02:14e4:9092%6]) with mapi id 15.20.9499.003; Fri, 9 Jan 2026
 18:50:11 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Stewart, Matthew" <Matthew.Stewart2@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Wentland, Harry" <Harry.Wentland@amd.com>, "Li, Sun peng (Leo)"
 <Sunpeng.Li@amd.com>, "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>, "Li,
 Roman" <Roman.Li@amd.com>, "Lin, Wayne" <Wayne.Lin@amd.com>, "Chung,
 ChiaHsuan (Tom)" <ChiaHsuan.Chung@amd.com>, "Zuo, Jerry" <Jerry.Zuo@amd.com>, 
 "Wu, Ray" <Ray.Wu@amd.com>, "LIPSKI, IVAN" <IVAN.LIPSKI@amd.com>, "Hung,
 Alex" <Alex.Hung@amd.com>, "Stewart, Matthew" <Matthew.Stewart2@amd.com>
Subject: RE: [PATCH 00/21] DC Patches Jan 12, 2026
Thread-Topic: [PATCH 00/21] DC Patches Jan 12, 2026
Thread-Index: AQHcf+5h2Y4Z/5q+D0WosOKdJW+8rbVKMR4Q
Date: Fri, 9 Jan 2026 18:50:10 +0000
Message-ID: <CY5PR12MB65271FFD41A9EE7933A2597B9C82A@CY5PR12MB6527.namprd12.prod.outlook.com>
References: <20260107155421.1999951-1-Matthew.Stewart2@amd.com>
In-Reply-To: <20260107155421.1999951-1-Matthew.Stewart2@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2026-01-09T18:48:28.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR12MB6527:EE_|IA1PR12MB9032:EE_
x-ms-office365-filtering-correlation-id: 4addebee-1644-436c-1005-08de4fafeab8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?tiMQx3Rsuay+QmkNs4Cm82uziRbPJbrSpf2F4QwFLFr+r6TheaTNTps52s+A?=
 =?us-ascii?Q?f+Uh2tnWoaPj0y6x9cYTfjouek2VRReArYvHyJXzEpW15ADjgCoQaTf3SdfR?=
 =?us-ascii?Q?sQ8fTbAaVuhUIyJw/oYa/3H5QrmzP4OWAsDLSJhBt7nbxF3V/iwCOWSJbL4u?=
 =?us-ascii?Q?pu8hGX6zgJj2ScARu2ScfcSq5jVfEaVaD75OmEbw2B2D2kxMc2yE3qKmGVO1?=
 =?us-ascii?Q?dZQXPf570AUrS0mYAVizs/RwRZ/pDMV/tjwrAyVpW+iwAjq6RLf4m2LRCxOr?=
 =?us-ascii?Q?nFpY0gW4KvQwSR1xxvevwL34lnkitGB/XeNxU5DHm0a0DVXHvdv2iN2zJzOs?=
 =?us-ascii?Q?iMhpa2LJxheel9f4YsutlQ3uvF5kifbPkkfNhgb0NubvjDlES6SZLiuGdrw+?=
 =?us-ascii?Q?uQJz1v7QjQj2t7h3pe56Y8QpoU+KwnP/F5XQEOIHgAuCd2T8/A2Rj53jdVl3?=
 =?us-ascii?Q?/In2F+mCgE34WnntRYQfjXUSqQ/0Bnn+QuCZrhzZmmmEwZFWTuxeLsLLk/iy?=
 =?us-ascii?Q?W3XxARi3G/Vigb6CGIWHi01p9fzTirPvO/e6rvfukJexE88dgKgQujwe9lST?=
 =?us-ascii?Q?2HdUDx0MZ6PZ/U91k7539SSoncCM41faLdgrH8rclM5TtTfpaze5etAWUSW7?=
 =?us-ascii?Q?5ZLPDvdpCZNaYegCXfpKhO5Pa6hwb1LYEb06ZzruKSFkQP9uLNliPbHwQouD?=
 =?us-ascii?Q?GMuTp5Vzo0KgvXWB25VhpihpK543+yx2YtCpAnSqfLDgtjR4v+5BjrtfAbo8?=
 =?us-ascii?Q?nYFI0N8fly56DXzUvnTo7BfZVTWgS7aX4H6oc3AzXsS9cH69aQBt0XHJv3Hq?=
 =?us-ascii?Q?1hqkeMeGL6o4DAT7gBmzg5qsZ0v3hGMtaeovS3dG0FuQHJ6jlI3vzb80UId+?=
 =?us-ascii?Q?2Z8vib7kqZ9nUH/xRfgbv7iSV6tEhOBuZS3I45qaYR/J6R6AMI/HplJZ0fxY?=
 =?us-ascii?Q?94efK2lqGomq+R6cmy9CpbdzNABSJ4ufg7NKaOfMEbH0vVacumAsTpIhcMAP?=
 =?us-ascii?Q?HC9w8usDAcAZtrUs6DbiMjoxBWukuTuiQhBSrLnJciRGsaEqukPeYwxxL3gh?=
 =?us-ascii?Q?WxHEtSCMQnUpohkm0I5QbgxU8IoElv/SYGip4FBA56VjHS/bJ9CRJDs19NoK?=
 =?us-ascii?Q?MUAlC4YZqjRimNLm6Ht/9ywkTeRc/gMUVXblHb6UaoSmduPGIueH7S6qLT4G?=
 =?us-ascii?Q?q/fKGP3v/USS8c9bd+ReqIVYzS9f8qNzPyHHf+0/mMUWhJqmSUrwURLt72fp?=
 =?us-ascii?Q?AvtIpghO4IKgM88DeapSxD4qb9PKz/y2ZyuNF3kHDH787J0sGjWFSUKgQ+Ut?=
 =?us-ascii?Q?8EMw3KbWdlByfeGuDOgwUG+ClawbEm0r3sbPxhBp8R2kXXmIqOFlV+OVVbWx?=
 =?us-ascii?Q?WtXo09zKz64pV2u2X1+qXwjWPPX2k+uWz4yapnhlhquRTAfHf1JmN5xvAZry?=
 =?us-ascii?Q?XgBjVD9SJUfAqnIphSgeDi0rYIin95quPqeqqA+27CY6Ol7N9UWu0LbKrDwy?=
 =?us-ascii?Q?JnRYXDyMlgb6Mr7phnk9EmEWQkZlhHnT01y6?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6527.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?uDymLgGx8C75OJuSPuWtooqloLLYkuKDr1FhYOFpCNcYse0H2qZ8YFHjSHBg?=
 =?us-ascii?Q?C+6tO5pWwpfkIx2glNWsYz0JjsqdmLePP7FZLmKslbNDti+6COGX4RlUY/by?=
 =?us-ascii?Q?hAbYwB3ww2zt1FsATD0KfVHxl1vBsG+9VzL2pts8pvr3pXRnmRI3RoJw8Ogo?=
 =?us-ascii?Q?iVnyT29bke7uUBjvTTUoKJQe1jvyx1Aw895GezkVkDzssJHQDzHssRRXe26q?=
 =?us-ascii?Q?S3AMMiUYTlP6g8Gd6UIpcXhxv0QBlbyzsUCMC3qoCnzE4+vkZsu93f2etqXH?=
 =?us-ascii?Q?i5V9aQwg6zDzXmYnfPQ16h9EyzsDi2Dwc5K/ccdzVP7Hd/vGOXC1HQKdHfky?=
 =?us-ascii?Q?v1m8ewiG0ATz42TW1iYpa+/ir/YVNWf98VeVI9ddyXJmWKMSBRcQA3FIfDYj?=
 =?us-ascii?Q?cl1fQB5LDMD1Jn8nYkZEisuMVd4OWjNy8aC/aVqV8E69e65x3Uce0o6ymguO?=
 =?us-ascii?Q?BQAzwWuIU9vZ6No2rM2nv6Rqj3Iny+509SDSE8AsU8Fd4nBaBxPLHlcgax0w?=
 =?us-ascii?Q?KWPfUM5FZAHCx/liqrYvnOpWOZTsSqnZFlWAO0ocsIttgwjtqtdnuP4UmmGR?=
 =?us-ascii?Q?jBXohlccgRWzeoc/460pybc+o9kkJQQidlRaTTTn5wF6CWDKTiNttfvFwycY?=
 =?us-ascii?Q?2ghPmEPehVY+c4DHHKW55RDzrhxIR9avH38MgvsdXsvHdUqGJn0avdwky76K?=
 =?us-ascii?Q?WYEpt8Fl+GO5W4VgJu7/EuKTcnyWtn6GPAZLSZ3CE1nwoXWIltP0DiPftfcC?=
 =?us-ascii?Q?i7Bb9h7HkRh4pNjHJ9cFe5nqHJ/Tq41aRZphaZhdxYL40CtrLIiutrMBArU7?=
 =?us-ascii?Q?mkkl84377y133nZapXB0EqZaxgwmaHjI/yl03YBC/cTFoOUs2E6mZYjiGN8m?=
 =?us-ascii?Q?ulhAOuMU8NjEyHGGs7aQGho6s7CMKy0aMq42qq5oabG7y1q2tVFwA5A/r6OQ?=
 =?us-ascii?Q?s8tWE7L90+q4mv4WiGqE7/XVdc4bBXFu4R8W2uCSuFANLikE7LFBNUZuM9a8?=
 =?us-ascii?Q?LMlVSRwQXl/FRVA1x9IA0Yow8Vl611AlRrjXLPpSTS9m+5TRbvGDOE4cPq3X?=
 =?us-ascii?Q?kuTrYP70Ty3L+lOaZ19Fyw1z5WQZ4VeNqdrUi6IsYSfp8Sk3HcxQEI36Zeqy?=
 =?us-ascii?Q?/IhlruPGhmYhGPxRzjP0OmMpk7G/WIjHHaHx+Ra4tzDNGWIALZaf2nueDhz5?=
 =?us-ascii?Q?fllT1rckxuQ9N4BZ6OptmkPsXT3+4vRJl2OH7v5QeRcQggGZyoSEoeqjsAWx?=
 =?us-ascii?Q?eoOEqguw5/b81bibZ8IdZkByQ45fgQ/ByGk721Ob66sULXS2I2zZAyhmlTg1?=
 =?us-ascii?Q?rJvX8a70vyCdKEJShOWB3QsRU/XMZGM9DM7JGxnpMk+Qn2SYISyQKdcjV1xa?=
 =?us-ascii?Q?GxxIKwxb8qfFW97avmAA0/d31EouOJALHSOxOIXg7Io2jYpDc/5WThPFROsR?=
 =?us-ascii?Q?N5X+47QJmDuiZlUKRAf/TpGXE1MbBQJoFRfvPl3y5atuHB3ssil/cUkNZzn/?=
 =?us-ascii?Q?Imls4UaGNWB+9OeFa8p0kgqHbGfGXCV4E870nU/YiusZxPLdF3GR+cZKRMgR?=
 =?us-ascii?Q?uerMMESYavOScwJIKqUxXJ+DPh83X7mVF2MU/S/7nTnk9+kWstUE1cHQqYkX?=
 =?us-ascii?Q?HZ/tKhfYe0daWNpJ/2dFvZxRelpOPUMOAC24GhI7cJgiMqnq/WNLpt7GlcWB?=
 =?us-ascii?Q?uIps+/e5jpL/ZzWnzjZQfXAQnASQp1jeo1PlZVkg3Il71BHe?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6527.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4addebee-1644-436c-1005-08de4fafeab8
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2026 18:50:10.8095 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bOvJlH9MsQ0s9RfrFjZ5fW/RTPbZLrNrIxjMvrQxDwPcFDhxi/XawqVXXrHO7FC99J/fL7tpvBR7a1CwwyX3Gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9032
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


The patchset consists of the amd-staging-drm-next branch (Head commit - 8d4=
11887114f0ea5fe205d88b6a0d8be1c827164 -> drm/amd/pm: Disable MMIO access du=
ring SMU Mode 1 reset) with new patches added on top of it.

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
From: Matthew Stewart <Matthew.Stewart2@amd.com>
Sent: Wednesday, January 7, 2026 10:48 AM
To: amd-gfx@lists.freedesktop.org
Cc: Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo) <Sunpeng.L=
i@amd.com>; Pillai, Aurabindo <Aurabindo.Pillai@amd.com>; Li, Roman <Roman.=
Li@amd.com>; Lin, Wayne <Wayne.Lin@amd.com>; Chung, ChiaHsuan (Tom) <ChiaHs=
uan.Chung@amd.com>; Zuo, Jerry <Jerry.Zuo@amd.com>; Wheeler, Daniel <Daniel=
.Wheeler@amd.com>; Wu, Ray <Ray.Wu@amd.com>; LIPSKI, IVAN <IVAN.LIPSKI@amd.=
com>; Hung, Alex <Alex.Hung@amd.com>; Stewart, Matthew <Matthew.Stewart2@am=
d.com>
Subject: [PATCH 00/21] DC Patches Jan 12, 2026

This DC patchset brings improvements in multiple areas. In summary, we have=
:

- Cleanup, refactoring of panel replay code to prepare for non-eDP replay
- Switch to drm_dbg_macros instead of DRM_DEBUG variants
- Add pwait status to DMCUB debug logging
- Adjust PHY FSM transition to TX_EN-to-PLL_ON for TMDS on DCN35
- Always update divider settings for DP tunnel
- correct clip x assignment in cursor programming
- Bump the HDMI clock to 340MHz

Cc: Dan Wheeler <daniel.wheeler@amd.com>

Aurabindo Pillai (2):
  drm/amd/display: switch to drm_dbg_kms() from DRM_DEBUG_KMS
  drm/amd/display: switch to drm_dbg_ macros instead of DRM_DEBUG_
    variants

Ausef Yousof (1):
  drm/amd/display: correct clip x assignment in cursor programming

Cruise Hung (1):
  drm/amd/display: Always update divider settings for DP tunnel

Derek Lai (1):
  drm/amd/display: revert "write default Vesa Aux backlight control in
    dmub"

Dmytro Laktyushkin (1):
  drm/amd/display: only power down dig on phy endpoints

Jack Chang (2):
  drm/amd/display: DPCD for Selective Update
  drm/amd/display: PR error HPD_IRQ handling

Joshua Aberback (1):
  drm/amd/display: Re-implement minimal transition deferral

Leo Chen (1):
  drm/amd/display: Add global fgcg function prototype to DCCG

Mario Limonciello (1):
  drm/amd/display: Bump the HDMI clock to 340MHz

Mario Limonciello (AMD) (1):
  drm/amd/display: Show link name in PSR status message

Nicholas Kazlauskas (2):
  drm/amd/display: Adjust PHY FSM transition to TX_EN-to-PLL_ON for TMDS
    on DCN35
  drm/amd/display: Add pwait status to DMCUB debug logging

Peichen Huang (3):
  drm/amd/display: move panel replay out from edp
  drm/amd/display: init code for external panel replay
  drm/amd/display: Add replay_events in replay settings

Ray Wu (1):
  drm/amd/display: disable replay when crc source is enabled

Robin Chen (1):
  drm/amd/display: Remove unused DMUB replay commands

Taimur Hassan (2):
  drm/amd/display: [FW Promotion] Release 0.1.42.0
  drm/amd/display: Promote DC to 3.2.365

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  58 +--
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |   1 +
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c |  25 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_replay.c  |   9 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  49 ++-
 .../drm/amd/display/dc/core/dc_link_exports.c |   9 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |   2 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  |   1 +
 drivers/gpu/drm/amd/display/dc/dc_dp_types.h  |  34 +-
 .../gpu/drm/amd/display/dc/dc_hdmi_types.h    |   2 +-
 drivers/gpu/drm/amd/display/dc/dc_hw_types.h  |   6 +
 drivers/gpu/drm/amd/display/dc/dc_types.h     |   3 +-
 .../drm/amd/display/dc/dce/dmub_hw_lock_mgr.c |   2 +-
 .../gpu/drm/amd/display/dc/dce/dmub_replay.c  |  13 -
 .../amd/display/dc/hwss/dcn10/dcn10_hwseq.c   |   6 +-
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   |  52 +++
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.h   |   3 +
 .../amd/display/dc/hwss/dcn35/dcn35_init.c    |   2 +-
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c |   2 +
 drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h  |   1 +
 .../gpu/drm/amd/display/dc/inc/link_service.h |  12 +-
 drivers/gpu/drm/amd/display/dc/link/Makefile  |   2 +-
 .../display/dc/link/accessories/link_dp_cts.c |   7 +-
 .../drm/amd/display/dc/link/link_detection.c  |   6 +-
 .../gpu/drm/amd/display/dc/link/link_dpms.c   |   8 +-
 .../drm/amd/display/dc/link/link_factory.c    |  19 +-
 .../dc/link/protocols/link_dp_capability.c    |  49 ++-
 .../dc/link/protocols/link_dp_irq_handler.c   |  43 +++
 .../dc/link/protocols/link_dp_panel_replay.c  | 343 ++++++++++++++++++  ..=
./dc/link/protocols/link_dp_panel_replay.h  |  38 ++
 .../link/protocols/link_edp_panel_control.c   | 297 +--------------
 .../link/protocols/link_edp_panel_control.h   |  10 +-
 .../dc/resource/dcn31/dcn31_resource.c        |  11 +-
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |  54 +--
 .../gpu/drm/amd/display/include/dpcd_defs.h   |  30 ++
 35 files changed, 763 insertions(+), 446 deletions(-)  create mode 100644 =
drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_panel_replay.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_p=
anel_replay.h

--
2.52.0

