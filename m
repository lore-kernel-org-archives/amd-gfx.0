Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4129AD29C2D
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Jan 2026 14:10:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A1B410E156;
	Mon, 19 Jan 2026 14:10:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ny7Th/fO";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010053.outbound.protection.outlook.com [52.101.85.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2431B10E156
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Jan 2026 14:10:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lYVRSIWsKD6K88s2gYVwKrG8Xsp2V5IYGLGFMbdZLSCZBvhwaqo/Cf3Jfd4Bg8bD625uyCvLngPu/CrUagZyHpLE4Q2P5YxoRmoHLQ1pd6S0cHk0vkMNsYpiDYqJqHhke6rQjeZmLoGvtcujUHz4NwnrkRhMf/EBsj4a1XI0F/qjz/gQDruId+1+MkAmorTbd/1LAsTud/gS2YOWxwURCzr1GbgJE/hV5yNhRWqdDd1PU4YJW1/lCAmn0ow+PnZaEh8bwNTVX1gXuQJ3K9r4ajam711MnQMxg5wp/RkSg9qb4Nufn5Kfmf/Md5wLNmGiCQdg8JQMs8WEQPXwTXa92Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tgailIAj6v97w/Zv7PiN3GHEgL4wHOsO9GoIkkuaUq8=;
 b=TzdFFO0oXGd2CY8Nyvl+g1xam/fbhu5gn1jhzq2YCiPogrsICJ/ytNv/HAhaSZs4N+EjXaNgHkASARCswycJrLrF6xvhazF/jgclJBuCy/umNgDifzHF5PiuqFG7xD+sN9Vzu7xvXPFjUZ8NByQcloaNv1XhLcWCAWZ1ESOoq2rkbNna2GiQB6xS8eRjPprTvSNAAc+RQWYe9N1pSWqO0rwccufWbHnK1sGE9+5y32gtXj6pIKE1fgK5ty/hViOKKHR5y5qCuIafP8Dd7kEI1b3NmuMKcq43InRpu+K85nImugC1q4xWA75yjnud+07jebbUxkFMw/afYee7teESmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tgailIAj6v97w/Zv7PiN3GHEgL4wHOsO9GoIkkuaUq8=;
 b=ny7Th/fO6EoX4e8V9Nk8iSHkFtjkSvH0zQghbOrS06dVeOJ3UO16EAvnAf503P0BRFC+z5zVWzteRgsb5r+Hmsb2YdO8DpIKM+VNhUjK/w+RSZ2i/3MJ9cr4CVLOeSkbLP9YBs4Ja+OLl6ecymvhz8Ab7DvCWiLL7oCrWJR4vkQ=
Received: from DS0PR12MB6534.namprd12.prod.outlook.com (2603:10b6:8:c1::19) by
 DS5PPFDB3A23D1A.namprd12.prod.outlook.com (2603:10b6:f:fc00::663)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Mon, 19 Jan
 2026 14:10:10 +0000
Received: from DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::b2e1:64e5:3b9e:738a]) by DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::b2e1:64e5:3b9e:738a%4]) with mapi id 15.20.9520.010; Mon, 19 Jan 2026
 14:10:10 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Stewart, Matthew" <Matthew.Stewart2@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Wentland, Harry" <Harry.Wentland@amd.com>, "Li, Sun peng (Leo)"
 <Sunpeng.Li@amd.com>, "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>, "Li,
 Roman" <Roman.Li@amd.com>, "Lin, Wayne" <Wayne.Lin@amd.com>, "Chung,
 ChiaHsuan (Tom)" <ChiaHsuan.Chung@amd.com>, "Zuo, Jerry" <Jerry.Zuo@amd.com>, 
 "Wu, Ray" <Ray.Wu@amd.com>, "LIPSKI, IVAN" <IVAN.LIPSKI@amd.com>, "Hung,
 Alex" <Alex.Hung@amd.com>, "Stewart, Matthew" <Matthew.Stewart2@amd.com>
Subject: RE: [PATCH 00/14] DC Patches Jan 14, 2026
Thread-Topic: [PATCH 00/14] DC Patches Jan 14, 2026
Thread-Index: AQHchZO7RhJYCdbd5UuA7Dk/5ZHA8LVZjtIA
Date: Mon, 19 Jan 2026 14:10:09 +0000
Message-ID: <DS0PR12MB6534CDF0DA3E92E3B1FE9DB39C88A@DS0PR12MB6534.namprd12.prod.outlook.com>
References: <20260114202421.3654137-1-Matthew.Stewart2@amd.com>
In-Reply-To: <20260114202421.3654137-1-Matthew.Stewart2@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2026-01-19T14:08:20.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6534:EE_|DS5PPFDB3A23D1A:EE_
x-ms-office365-filtering-correlation-id: e864fae3-46dd-4fbc-2369-08de576474d1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?WAu/VMwRZ2XldOasXT1Yk8zZJV5frh5yqugXClwxV9h11KMMKQk9dGm6lVVR?=
 =?us-ascii?Q?M6/GxiUwCbnwcszLl/Yihw1PH4KTlrJTM5G4Q+njPqQB4zW/kMb7Fit6d5dY?=
 =?us-ascii?Q?kAxL8zgvhPtaPlcFUzDeEaAxmhW5G2RDsx75md0eTe4cy8ZmR+O5Jnf54Sre?=
 =?us-ascii?Q?C5jk7NsRxfkE/Gfv1ljrfeZhqjy9Ijy3b101c3DX6DEWG9TTVebc2vdolsS/?=
 =?us-ascii?Q?6eRX6TxMYvAo0l5zT4udg+OBn/KEV5Mqk3zcL50Vx/OVVTcpr1IKpvQpExum?=
 =?us-ascii?Q?M+nGhBJCLA7xDCq+4ia05CKu0px/VUqW5b7JR0WOEhsNFoomjhaZfaAxMXy8?=
 =?us-ascii?Q?j2iBhdwAJ/PIHmtmp32t0r+/dR1kID9iHr8BWOWaEcFchOecSkVVcjV55g7e?=
 =?us-ascii?Q?N0YRv8+Khdr4xzMWqeAmMRjHte9+tFjn7ci35zC1K6W+9+eBk0Eja7rYf4vr?=
 =?us-ascii?Q?3+k9IFCeWKu2758SYR67vwPnlzyG25qOKamVLPhU/o+0aZpQ4yflmVNTT8jp?=
 =?us-ascii?Q?Gn8jygLE+GpPdZsxAGLRUsPOg45Fd6WsujW7IbYly3Dl69eQKYHZhbd/cxUK?=
 =?us-ascii?Q?0iLGJWeObvwEZv43VViSKmEdlyNFmRDoWIBc3c5+IfLMW3K37wbG6wz+nWgZ?=
 =?us-ascii?Q?/rdtj8n6RKuakUnKlTb/BcWhQlNOpJIytyBoBgRosHJATyWGdI8etaCTpLut?=
 =?us-ascii?Q?ch0vvRMkpz3kR52dt2V6A/RmOlafPgkjh6DxiwPk20GPFLfcO7VnGT3ZU3dV?=
 =?us-ascii?Q?WJ4H+IETp+HWcikLtK2/m8dwltb8gxkZ4TaR+z9kdcJB2O4sB9Uk2rmztcny?=
 =?us-ascii?Q?1u4CmGOigU3OwIi35qQ+IDenknI4KjmEH6UcS/LOFyoGfO+fKwVEyLQ7aSZw?=
 =?us-ascii?Q?dn/gXDgc9J/ZLQ46maAYVa3TtBvPuvDN+JiX7wdqlfXioWvwWp8boRwP1MtW?=
 =?us-ascii?Q?gHzuTZghe3nOUCyTN7ybOZCOC4sV7IBq5do46TXjTcIrK56t7xhb3IFQPMBr?=
 =?us-ascii?Q?m7J3WL3dK5+Ne2LuB8+pH7IL6pU9GGYQH+/3mHVr6tmzJm47bBuGSC5UWVUS?=
 =?us-ascii?Q?uCMVE1rGKXWZKX2b1unYpsn6EW20VMPzpHZrRaN77cznxY4l0XhkT9gsuWPb?=
 =?us-ascii?Q?C32zEdM0SLXo3cXI51q3OZZKdfWM9CRIdL38IKaM1eBOCIb9Wfeg6+C5oYz4?=
 =?us-ascii?Q?WlrCfLvxr21I41KvMuw/5GyW912nFIvYBt3kXbjcDPXo/oQ70pqa/r3dbYXO?=
 =?us-ascii?Q?ymrx+7RSF+ivOWexYCJJ8M7Cssr0CwrsmE1OMk5peaa/RlHo2NlcSvhfXO40?=
 =?us-ascii?Q?A2jLByaP1ex+Hip1vuHfCJhy97/zYYLWW9Dx4AgM6bULjX4XlXVezUJxho+x?=
 =?us-ascii?Q?QZuJDRwOoGP9w/7w2ksQI9lC8GjIbQZRDqXqYLoMsSpoPjxA5BzBbG6EfVp4?=
 =?us-ascii?Q?GDbe1OMhRyG1L9CYgjzP/m/20JOjMduYsc5vExcVN56OC+vsmJwYRq0CilVh?=
 =?us-ascii?Q?naEv8qvaQkaL85S5OjJ9IJ/kwL9KdUmU68xqiUZd5h7G5OG91y6AuHRkNB6s?=
 =?us-ascii?Q?7HrZkTEo7H55zJgbnYPj/YGQTChxaap4W+8nvoyCut+1EefIATWRYqF79hMb?=
 =?us-ascii?Q?+fMpbyskrosOzaGPu8g62+I=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6534.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?RTLbzz2MfXxIw+VP7qjlztX/giW52yEzr8COYwLJMXseimdE+7+rQyg97+Dd?=
 =?us-ascii?Q?2KXxyZgLLHHD7AT2vHmogELQUUpByC6TP12XzwZNcKvEmN8lKhsVFXuQ5P9o?=
 =?us-ascii?Q?iUq2gqvH7JvgLcAPiYkXDiDnY1jpO5ON+a7qt1an1lC+ZVqwCZgFPHTnRz/a?=
 =?us-ascii?Q?moKoiRmGairSfsTJKbw1DfyW7Zft4q1Y1dsTabe1LTjjQ7kp/akZGxAN0rPC?=
 =?us-ascii?Q?RCi8kBKvlskFeGtzI8pX4VAhzKTy2omQz+S39YgF3z9ohO+KWbhEe7DbK10r?=
 =?us-ascii?Q?opr/Mh7RVMGua165oOA0CbauSFJDsqT5rrjh0thj3IPuLklMNncLDXP395Cw?=
 =?us-ascii?Q?VEPH56kPM/lKcPlgMk2kMdQEWfjXiOrzkB+NPeV8J8YgQ/my8eAVOSQ4trw0?=
 =?us-ascii?Q?oE+RurBpN1CURKgfkmDAIHgIA93Jl44SkaQmJ4RLakjmEEzjDIACns6ZJA3z?=
 =?us-ascii?Q?pfNEKJA8+TZE/Nm0UqzfOVzK5a3eOimUixuJgLSJO5bI/CLSAm2F0h28Gm0f?=
 =?us-ascii?Q?9144pLaMGaY38MUdE9OLt5nPVjUsMJokmRGql0mxVccsyqLjT06/frxEeiwc?=
 =?us-ascii?Q?VzabIyzdNCIY6cN2Hvp5ftP3twvDg4PuKye+YPMbT/7C59esPL++8336PqOG?=
 =?us-ascii?Q?QVB5F2JB0kXrWTtf9CfT9wNKpqeZSOh2bhJyhwGSPZ7R5qsfWbHymwKqSbwr?=
 =?us-ascii?Q?fdp901NUOgGiY+EqQwcmsaCGVYKC6pwBOtdmZ7RslrLHmJtWV4/mSaYz4krI?=
 =?us-ascii?Q?c9Ft9nYfW+4XEAc7jg0mz+/PEG1zg581q5VKDGC4RfevPV7G7w66DUHKa1OQ?=
 =?us-ascii?Q?Y3PGRukdCpeFlnR9D/asMY18eqYfcpA2cMSwnw6uhTuH/53ESRhoxFLWLs8X?=
 =?us-ascii?Q?beAKEwgzDsGXi/cN9cw9AgrwxBCiMMWL6uoZtrwakVI3/nw7pPf5mHIi8RXn?=
 =?us-ascii?Q?mhH+MYpnoKEDZ4WZ2TFMemWbXJvoVIjVH+j3nuzPiQskHSG3f774Y7ZXPwDH?=
 =?us-ascii?Q?0tfvTro7TgQx3dt1j4QpKJ/Bl56VSrpq3z7v0oBqBlrL7S+ScCVBVW0be+bh?=
 =?us-ascii?Q?jEeTfBUu8R+UXRbu0414ttGm+Os5u5HjTJXJzULb/DRsd5IGGaDIzTrLGGXH?=
 =?us-ascii?Q?7khOq8sc2zaOVaObsCpOVOwrJt+l06Q2Ry/wo66Qtrb0RS6UgXjNudAU0hNh?=
 =?us-ascii?Q?0uJGZRdGABz/5sl2LvekvTjgUnKcFgbj+ChVhHA74Cs2bPfiwjRkF8Jp8B+W?=
 =?us-ascii?Q?6pGiuRSUF3QCD6bzBDSyemkfQU2jvEhA+ze7U7ODaj1pXbCJ8W9rWbNmLkfy?=
 =?us-ascii?Q?BHk2ZK3ftFaUN4leiWWOmqa5MeIOdn+GoBOjq+DV/UHAPUl8nbhgKelrlmRk?=
 =?us-ascii?Q?qQ75l93ljZhuzDwMDUmejtu9p8uYXZsDMZJUGnrXG+ryLpf1LjxL+ydsqeSB?=
 =?us-ascii?Q?Kcc+jI1OJpWIieJxh2YZxMTPY8R6Ke91KiVS6z/gcG5uRJbYIDfesQkyC6FZ?=
 =?us-ascii?Q?KByQt6Lfp+vG2HCBj6U45TlXkT0k4zRuDjUbzWux1hm7dAD2UExsKNQeDU48?=
 =?us-ascii?Q?CMgbP1HtgKGkULN50Y4te8+d2IfjGmjPJuQIRmY3/C3kSiWBje8p7mzjmke9?=
 =?us-ascii?Q?h3TBBKcYY4H7QmK+NIGhrPj8s6+2oiDc8QiS55/pnbxW7DYbQF3WAzqNIOXA?=
 =?us-ascii?Q?U1h+VXD1wgXiiL+1NKlV2RObM+URfBQX8etZNR5P0nD5p73J?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6534.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e864fae3-46dd-4fbc-2369-08de576474d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2026 14:10:10.0749 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +d636Nzeosb4C9auBxOQsOZI8MXmohDxZHvPyQLmqT4A40DRyWtrQ7r8Zhi5equZj9H8KfYiUBq34Wv+uUpZCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPFDB3A23D1A
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


The patchset consists of the amd-staging-drm-next branch (Head commit - d51=
928df9271aa6c6c201448e358c25d5cfc5706 -> drm/amd/display: Promote DC to 3.2=
.365) with new patches added on top of it.

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
Sent: Wednesday, January 14, 2026 3:22 PM
To: amd-gfx@lists.freedesktop.org
Cc: Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo) <Sunpeng.L=
i@amd.com>; Pillai, Aurabindo <Aurabindo.Pillai@amd.com>; Li, Roman <Roman.=
Li@amd.com>; Lin, Wayne <Wayne.Lin@amd.com>; Chung, ChiaHsuan (Tom) <ChiaHs=
uan.Chung@amd.com>; Zuo, Jerry <Jerry.Zuo@amd.com>; Wheeler, Daniel <Daniel=
.Wheeler@amd.com>; Wu, Ray <Ray.Wu@amd.com>; LIPSKI, IVAN <IVAN.LIPSKI@amd.=
com>; Hung, Alex <Alex.Hung@amd.com>; Stewart, Matthew <Matthew.Stewart2@am=
d.com>
Subject: [PATCH 00/14] DC Patches Jan 14, 2026

This DC patchset brings improvements in multiple areas. In summary, we have=
:

- Update memory QoS measurement interface.
- Panel inst for monitors.
- Disable FEC when powering down encoders.
- Detect panel type from VSDB.
- Check NULL before accessing a variable.
- Initialize a default to phyd32clk.
- Revert "init dispclk from bootup clock".
- Add IPS residency info to debugfs.
- Ensure link output is disabled in backend reset for PLL_ON.
- Remove unused code.
- Add DMU crash recovery callback to DM.
- Remove coverity comments.

Cc: Dan Wheeler <daniel.wheeler@amd.com>

Alex Hung (3):
  drm/amd/display: Check NULL before accessing a variable
  drm/amd/display: Initialize a default to phyd32clk
  drm/amd/display: Remove coverity comments and fix spaces

Charlene Liu (1):
  drm/amd/display: Remove unused code

Mario Limonciello (AMD) (1):
  drm/amd/display: Detect panel type from VSDB

Nicholas Kazlauskas (2):
  drm/amd/display: Ensure link output is disabled in backend reset for
    PLL_ON
  drm/amd/display: Add DMU crash recovery callback to DM

Ovidiu Bunea (1):
  drm/amd/display: Disable FEC when powering down encoders

Peichen Huang (1):
  drm/amd/display: panel inst for monitors

Ray Wu (1):
  drm/amd/display: Add IPS residency info to debugfs

Taimur Hassan (1):
  drm/amd/display: Promote DC to 3.2.366

Wang, Sung-huai (2):
  drm/amd/display: Revert "init dispclk from bootup clock for DCN314"
  drm/amd/display: Revert "init dispclk from bootup clock for DCN315"

Wenjing Liu (1):
  drm/amd/display: update memory QoS measurement interface

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  15 ++  .../gpu/drm/amd/di=
splay/amdgpu_dm/amdgpu_dm.h |  11 ++  .../amd/display/amdgpu_dm/amdgpu_dm_d=
ebugfs.c |  71 +++++++++-
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c |   6 +
 .../dc/clk_mgr/dcn314/dcn314_clk_mgr.c        | 133 +-----------------
 .../dc/clk_mgr/dcn314/dcn314_clk_mgr.h        |   5 -
 .../dc/clk_mgr/dcn315/dcn315_clk_mgr.c        |  90 +-----------
 .../dc/clk_mgr/dcn315/dcn315_clk_mgr.h        |   1 -
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  22 +--
 drivers/gpu/drm/amd/display/dc/dc.h           |   5 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  |  35 +++--
 drivers/gpu/drm/amd/display/dc/dc_types.h     |   7 +
 drivers/gpu/drm/amd/display/dc/dm_helpers.h   |   1 +
 .../amd/display/dc/hwss/dce110/dce110_hwseq.c |  24 ++--
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   |   2 -
 .../amd/display/dc/hwss/dcn30/dcn30_init.c    |   1 -
 .../amd/display/dc/hwss/dcn301/dcn301_init.c  |   1 -
 .../amd/display/dc/hwss/dcn31/dcn31_hwseq.c   |  16 ++-
 .../amd/display/dc/hwss/dcn31/dcn31_init.c    |   1 -
 .../amd/display/dc/hwss/dcn314/dcn314_init.c  |   1 -
 .../amd/display/dc/hwss/dcn32/dcn32_init.c    |   1 -
 .../amd/display/dc/hwss/dcn35/dcn35_init.c    |   1 -
 .../amd/display/dc/hwss/dcn351/dcn351_init.c  |   1 -
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c |   2 +-
 .../amd/display/dc/hwss/dcn401/dcn401_init.c  |   1 -
 .../drm/amd/display/dc/hwss/hw_sequencer.h    |  38 +----
 .../gpu/drm/amd/display/dc/inc/core_types.h   |   8 ++
 .../gpu/drm/amd/display/dc/inc/hw/dchubbub.h  |  28 ++--  .../dc/link/prot=
ocols/link_dp_panel_replay.c  |  32 +++--
 .../link/protocols/link_edp_panel_control.c   |  15 +-
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |  11 +-
 .../amd/display/modules/power/power_helpers.c |   5 +-
 32 files changed, 256 insertions(+), 335 deletions(-)

--
2.52.0

