Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ED94C282EC
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Mar 2025 13:30:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B576D10E070;
	Mon, 17 Mar 2025 13:30:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fYPpNKYF";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2074.outbound.protection.outlook.com [40.107.244.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5973410E070
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Mar 2025 13:30:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KznqvzlRz5xLMlzdJng+ze6YJd/x1L47cS+DDebrxbw/KUZLHXHsoYAiYFGYzH/sMjDNK6isJpt39b2rzJbPFgeKlprOJZ8ZuWVqzLjJm20zWAAbsRyYvZgg73JOBkWx8vIh3Ydos0VhXWlzu0cV1a5TmYmIHUDJ+BhKLIPAFerIC+AMVPl2BcfIkcmHXnq6wrAZQtP0+R/2PCaCj15stJQPdFDdYoIuvCQ0Lfb6w3PgLeJ9Xp/SUehkZsGSnrvFDvS+1JQUT1dwwqiOJLAIR6lv/yqzoVYSqjUiLrYpHTbjt2OM3GnAIfsJBgByh9pVD0RHFJ09TVTpKqjtJewIkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w4P43ML9wE4IXsCgxT5zm8+hhzuJAmVR5pog08iWf8I=;
 b=jt+SM2XDVHxRdarUhsj/A2g2RzSaFhExmFHAj/WHzFts4OsUJfzg8kzt7PIlUU16LsVmsHkcciOJNQRNZ8T1al3ROiNnsai3MNo3fLqQpurneks623gvE2RLnHhDVcQgvsrgk+rPYhruJ5xd5w+zWy8+MovhpAdD2o1GzjeSBTj/HMJbMueK/D+K5xmrmlU/6scI1IBQEGz39LAVSTuedlDiTF4YrGgismQz3N9ViGNGpxPd4Ez1yuzwD9g55e1TzX3rSoxPxXFu5tdkLBV4E6S88K7/YMD6m1AM1Q2FaNnGvK/tZuSe79uQb6RNDvgu9se/DnUSqgP/E0kvtFF15g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w4P43ML9wE4IXsCgxT5zm8+hhzuJAmVR5pog08iWf8I=;
 b=fYPpNKYFhTcw/e9ykF5LVmbRdOqfSbPiHCIY39663LTNQWPEJ/ShELTTx93W7XsH2UW0merJzeWl8qjXdFdXVi2JyPQP4yQfo7qwfZSpr/PT7peDNiUaEh++5cfDl2TPPfBHRUCzv/LW1Ab3xFSk63fip9J4Vufg8rX15D4NRkA=
Received: from DS0PR12MB6534.namprd12.prod.outlook.com (2603:10b6:8:c1::19) by
 PH0PR12MB8031.namprd12.prod.outlook.com (2603:10b6:510:28e::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.33; Mon, 17 Mar 2025 13:30:10 +0000
Received: from DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::ea87:74ba:36ec:8cf6]) by DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::ea87:74ba:36ec:8cf6%2]) with mapi id 15.20.8534.031; Mon, 17 Mar 2025
 13:30:10 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Hung, Alex" <Alex.Hung@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Wentland, Harry" <Harry.Wentland@amd.com>, "Li, Sun peng (Leo)"
 <Sunpeng.Li@amd.com>, "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>, "Li,
 Roman" <Roman.Li@amd.com>, "Lin, Wayne" <Wayne.Lin@amd.com>, "Chung,
 ChiaHsuan (Tom)" <ChiaHsuan.Chung@amd.com>, "Zuo, Jerry" <Jerry.Zuo@amd.com>, 
 "Mohamed, Zaeem" <Zaeem.Mohamed@amd.com>, "Chiu, Solomon"
 <Solomon.Chiu@amd.com>
Subject: RE: [PATCH 00/11] DC Patches March 11, 2025
Thread-Topic: [PATCH 00/11] DC Patches March 11, 2025
Thread-Index: AQHbks9ix6/wOVnTPE6mdvpvSPFpULN3W3Iw
Date: Mon, 17 Mar 2025 13:30:09 +0000
Message-ID: <DS0PR12MB6534AEAB503B9371C7200DF49CDF2@DS0PR12MB6534.namprd12.prod.outlook.com>
References: <20250311214618.3106637-1-alex.hung@amd.com>
In-Reply-To: <20250311214618.3106637-1-alex.hung@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=a4209da5-5c7a-4c17-bcf2-91cd91330a67;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-03-17T13:29:40Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Tag=10, 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6534:EE_|PH0PR12MB8031:EE_
x-ms-office365-filtering-correlation-id: c0edc74e-ec91-4936-7eb9-08dd6557d6fc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?55HLn6DfpYJ3PJce4URKzyhOKcSS0kL//+t3aA/GGA1v5LoMyL7kiA5bP+?=
 =?iso-8859-1?Q?iqIkbZgG5FhW1djlryaIxL+z/MoGLF1Q8Tz2pBqNp8+86v/HLMXw+jQe4u?=
 =?iso-8859-1?Q?QFJULJ2n8Bshl89OHzA6RunLUWq5BC3VTVSeKFNhbl9pZsGO4RwH6hHV+C?=
 =?iso-8859-1?Q?IH3KgROQ5s8ClFd6cMzZFLnaUTd+NgdaIqiwsjj8wymndp/lFihFl/KwH2?=
 =?iso-8859-1?Q?AlZM8lgfptfT7uzWqknV8qGiwjHb2JPRd3zGoAxu+T0CTVlUQUEzdEmHiR?=
 =?iso-8859-1?Q?4ioK6sv3C6m3eGm8z7epbvY+sYOLMi8o3Ac0fkuIAZguYsVNI1cdoIfIM9?=
 =?iso-8859-1?Q?3YULTz72luL4CPpIJIqalcWXzcDgkNDXGFjPUO49W5MpnrqMgHJGntUn78?=
 =?iso-8859-1?Q?OXfR4lvGBtFbbNbAZ/tMWCuZyBDVPX9NqjVy8XnKtfrt7ujgzu+P1RYLga?=
 =?iso-8859-1?Q?ig9SQ6o5DJDXn9JY93QbcfvERerrLnOQpa5u+rlLs5n/Jf21FeFc43Tu08?=
 =?iso-8859-1?Q?aGenApoCt2P6LWnzp17V8StdJE3m92qkirwUWXKP+Ol10su9bcFdebGleP?=
 =?iso-8859-1?Q?p2ovLhj1epThiKV+Hy2bVnsEhJ8LZC41Lu+0WSFoOomP/uF34cizCrBOYM?=
 =?iso-8859-1?Q?akq9+vdgMTVXWu+q5XadlVAfqEupGfHKDbC/0hbRxf0QwE9Va1sOhB4vUT?=
 =?iso-8859-1?Q?HBD44xA8qoUOf71HUx2XnzQ98KzFry6yxONA3EF7mJ8s1KLDdQ+UShVhZW?=
 =?iso-8859-1?Q?4FZ0CMIVlBXtg+qq4+IKb9a/vZtxmArshyXt3CxEJADqo4A3czPmScjRtt?=
 =?iso-8859-1?Q?wAVcwmRwH15e7Ffy3bKfLEg6DFy0hZ4Gm01D0iWCLIlgJ8r4W2u8s98qMw?=
 =?iso-8859-1?Q?CkEYbCiD5k2VOmD0fvjZYy4VCDQnGuTaxphZ8I0BuzaZjJwHxMDsIjFeH5?=
 =?iso-8859-1?Q?ebqA0oeL/fUVSc6VoIpsazFETSb0V5hev0JAmGyTC21PceVCHfjWx+aDl2?=
 =?iso-8859-1?Q?rl9gjhn/fiM24jXCQIX34VmfnwQGr2G0bYnlZBXLQyv7lguRyO4bpkBZhz?=
 =?iso-8859-1?Q?NIAuc9VumPrhs2yGKeERgIIeu2D+7lnjmWJSa/ntt8CHN36ayHxIRQvg0z?=
 =?iso-8859-1?Q?oZ6QTpF9BjfhqtCjXAWQ+JFlDebYB4/FGhrUKmip/MWBxZmBkIPKup6Q3s?=
 =?iso-8859-1?Q?cmXcjliBXDqS5xstJaoTJsGmPpCUagvZxTyQccJbvjTYCHBHKcwlzEsyBU?=
 =?iso-8859-1?Q?JPmZ1JjrCna4jUEsqDSACdVvQ4DODmpRN3R33n85Ay3obkO+zzxW0E5sIR?=
 =?iso-8859-1?Q?xp6u5nHq9zfD1ma+fVP6l7jyxYAAl3vn1mtJam5GurRMC3rM+0q2zIjZ7R?=
 =?iso-8859-1?Q?e91eAaCovosksJn/GgTYaL3qB2IQfdV4YFyJrMoq+HBP5kQDVIX96kGGDx?=
 =?iso-8859-1?Q?NL2OjHkteUKh06t1pt64c7iOSebVBXfqDFakNoQIOs32hG0QtP8xnIMfJp?=
 =?iso-8859-1?Q?pppHCFVkJLK/6VtOAu3XkB?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6534.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Ikxv3bWEHfxKB241N5C/Wt7AU9UP0uIA+fL9spaN2+dLqnLnGUsL11M7ig?=
 =?iso-8859-1?Q?9xkxolI9Djn9hvVAxySjmryrfSfYxUw/Tt3flBVyyM77Bj+VZApSnJkiK2?=
 =?iso-8859-1?Q?pSUsf2O3mGDutY43OEXgyhX5RrO42qHyzzFIgyTNn8YF/apAHxpOQJcTqj?=
 =?iso-8859-1?Q?BcnCZwPDXlv6NmBUdb3Uiyw/uIUALimeB5x+X0N6jg4a6GNma+4ALW3xXn?=
 =?iso-8859-1?Q?eIyKD27ubFHm5OlU7lAdf39pAu34LH5YkPuqZiBAi1Y2Ej4Zv/1Od8hdAJ?=
 =?iso-8859-1?Q?0V5PHc34tNgimWBJ+0BkhL6Eo0VQWvD4dAZSBPNnx4ONLT5twDQ2I2O9yH?=
 =?iso-8859-1?Q?4EOpQwFGeK9ou+Z7dNTwZzzkvJyQ0Ng4+RuovzNeeA0mdxa0Io9SzqkkJD?=
 =?iso-8859-1?Q?wD/BXtYXxH/pbRzHV1kLJeS8W4MU8D1aaJKiVNBDGXdnuW1hXCKBtyWG2f?=
 =?iso-8859-1?Q?vSE0g5qiJSi+F19n7qdgriCCJ7/Gy+BzeNwmnJ2QroZD3ILUpCDt5GteOG?=
 =?iso-8859-1?Q?dsozEwqAhb+ZddGbnG+8tl/SH13hJj2Dk+MH8ewNFaVTae4m4Jcajz6tgd?=
 =?iso-8859-1?Q?Y0soCn4lrikzqHuDWXENcIBjn9+27+TDNH7aBsuaTUxO/Tb8hTQYVSZGfA?=
 =?iso-8859-1?Q?cDLISDnXtcOfhAk67o9HaVVk+kBtDV51HRBbq7oksbf3Xp1fDyQp29ON1X?=
 =?iso-8859-1?Q?314h/tNYwefYM/2EYoOORnKBQkV0erVf8VOhHcsrZC73x+gz+FTfNh5sAW?=
 =?iso-8859-1?Q?81QE0V5ZeteHYvYn9ylaXP1fKx8UZQE50FANUsfncGWFCRbxpfPo7VB/H1?=
 =?iso-8859-1?Q?mOPi1TFl4USLVWrThP/ePmJBjW8NtRoT4YLARkXjEdL1D0fe2592/y2OSK?=
 =?iso-8859-1?Q?+IOL3N9WR4hZjU6EN2W9gYwCt1BVSSpse6YXV/pzcTmFLItEPQw59YQBnC?=
 =?iso-8859-1?Q?//gnkpSo3lAlT1slIJIlvb7eVgWHPrz3h6yzISZrcj5NbpO7JfijSf8ozb?=
 =?iso-8859-1?Q?eLSWLymSK9aq+V3kqmWfzyi7/JUVz32BvMzUqglvjNLj2dRnRNgRSN+wbL?=
 =?iso-8859-1?Q?ZRfaFPLg2gyQ1fjSx2uASJaHQWlVuO5NSaZgm3zI7hTkc6XMOrf28tELZb?=
 =?iso-8859-1?Q?CN8l13roF/oH0fmuKXV48cr9Kx7Ac89XfWmcOgYh0STEjDxeglu1GxuwWf?=
 =?iso-8859-1?Q?RhFttfpsiBy5o3AdWQNfbNivWgu/sbcCpRW8tty3X1au6g7o0VD+0MV1/K?=
 =?iso-8859-1?Q?7WpJbDDseS01w5YBjWPEx2VpLcbai8i0lLx7DwjP2uXSAY+MYSGgPFlA3j?=
 =?iso-8859-1?Q?9ovs1JhDcShaqOTYUOnb2d6JSHKNpbLPfG8XTi0P9GpCSmGN3A0yqiz9l2?=
 =?iso-8859-1?Q?lUVky+lfs/+zE7sz3qSb3G3M7pAzZa0v7kKofcpEVopqtzoUBLA838DnY5?=
 =?iso-8859-1?Q?OICbyKBlTBXnkwNn29QYB4F/5enKL7dj90Rw0MgoKW2PrFytGaZzcvbflH?=
 =?iso-8859-1?Q?6gHZCWdo5/Nn6ctFGbodthEkCALwAocl2gGKYwNfQNJYfrhe97paaT2/JJ?=
 =?iso-8859-1?Q?aujVKOohyj0zAJIzp9/Du+Ws9fKU7SwLu9rt8ENI8eqD5cNML97zV/QskH?=
 =?iso-8859-1?Q?ZE2PNeLYALxtM=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6534.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0edc74e-ec91-4936-7eb9-08dd6557d6fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2025 13:30:09.9302 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: on9SwyxyshWErOtcyvaaiqpicBoEq5UHY446zRqvKHXPRl1kw8zOekPVD4QwjXswD3RhhGap6b0rBjtROWaHDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8031
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
        * Single Display eDP -> 1080p 60hz, 2560x1600 120hz, 1920x1200 165h=
z
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
        * AU Optronics B160QAN02.L 2560x1600 120hz eDP

The patchset consists of the amd-staging-drm-next branch (Head commit - 435=
5581ede9ad340f726eaaf7eba13d953cdcb09 -> drm/amd/display: Check pipe->strea=
m before passing it to a function) with new patches added on top of it.

Tested on Ubuntu 24.04.1, on Wayland and X11, using KDE Plasma and Gnome.

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
From: Hung, Alex <Alex.Hung@amd.com>
Sent: Tuesday, March 11, 2025 5:42 PM
To: amd-gfx@lists.freedesktop.org
Cc: Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo) <Sunpeng.L=
i@amd.com>; Pillai, Aurabindo <Aurabindo.Pillai@amd.com>; Li, Roman <Roman.=
Li@amd.com>; Lin, Wayne <Wayne.Lin@amd.com>; Chung, ChiaHsuan (Tom) <ChiaHs=
uan.Chung@amd.com>; Zuo, Jerry <Jerry.Zuo@amd.com>; Mohamed, Zaeem <Zaeem.M=
ohamed@amd.com>; Chiu, Solomon <Solomon.Chiu@amd.com>; Wheeler, Daniel <Dan=
iel.Wheeler@amd.com>; Hung, Alex <Alex.Hung@amd.com>
Subject: [PATCH 00/11] DC Patches March 11, 2025

This DC patchset brings improvements in multiple areas. In summary, we high=
light:

* Fixes on DCN31 and DML2;
* Enhancements in DMUB;
* Improvements on DP, eDP and others.

Cc: Daniel Wheeler <daniel.wheeler@amd.com>

Alex Hung (1):
  drm/amd/display: Check pipe->stream before passing it to a function

Charlene Liu (2):
  drm/amd/display: Update static soc table
  drm/amd/display: Use DPM table clk setting for dml2 soc dscclk

Cruise Hung (1):
  drm/amd/display: Change notification of link BW allocation

Dillon Varone (1):
  drm/amd/display: Revert "Support for reg inbox0 for host->DMUB CMDs"

Jing Zhou (1):
  drm/amd/display: Guard against setting dispclk low for dcn31x

Lo-an Chen (1):
  drm/amd/display: Fix incorrect fw_state address in dmub_srv

Mario Limonciello (1):
  drm/amd/display: Use HW lock mgr for PSR1 when only one eDP

Ryan Seto (1):
  drm/amd/display: Prevent VStartup Overflow

Taimur Hassan (1):
  drm/amd/display: 3.2.325

Yilin Chen (1):
  drm/amd/display: Fix message for support_edp0_on_dp1

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   2 +-
 .../dc/clk_mgr/dcn315/dcn315_clk_mgr.c        |  20 +-
 .../dc/clk_mgr/dcn316/dcn316_clk_mgr.c        |  13 +-
 .../display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c  |  15 +-
 .../drm/amd/display/dc/core/dc_link_exports.c |   9 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |  18 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  | 185 +++++------
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h  |   2 +-
 drivers/gpu/drm/amd/display/dc/dc_helper.c    |   2 +-
 drivers/gpu/drm/amd/display/dc/dc_types.h     |   1 -
 .../gpu/drm/amd/display/dc/dce/dmub_abm_lcd.c |   3 +-
 .../drm/amd/display/dc/dce/dmub_hw_lock_mgr.c |  11 +  .../gpu/drm/amd/dis=
play/dc/dce/dmub_replay.c  |  19 +-
 .../drm/amd/display/dc/dml/dcn35/dcn35_fpu.c  |   2 +-
 .../amd/display/dc/dml2/display_mode_core.c   |   2 +
 .../display/dc/dml2/dml2_translation_helper.c |   2 +-
 drivers/gpu/drm/amd/display/dc/inc/link.h     |   4 +-
 .../gpu/drm/amd/display/dc/link/link_dpms.c   |  17 +-
 .../drm/amd/display/dc/link/link_factory.c    |   1 -
 .../display/dc/link/protocols/link_dp_dpia.c  |   1 -
 .../dc/link/protocols/link_dp_dpia_bw.c       | 193 +++--------
 .../dc/link/protocols/link_dp_dpia_bw.h       |  18 +-
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h   | 132 +++-----
 .../drm/amd/display/dmub/src/dmub_dcn401.c    | 121 +++----
 .../drm/amd/display/dmub/src/dmub_dcn401.h    |   4 +-
 .../gpu/drm/amd/display/dmub/src/dmub_srv.c   | 299 ++++++------------
 26 files changed, 362 insertions(+), 734 deletions(-)

--
2.43.0

