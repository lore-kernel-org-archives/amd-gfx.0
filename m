Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 091B1C531DC
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Aug 2024 18:47:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC71610E81C;
	Fri, 16 Aug 2024 18:47:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Yoc6z8BQ";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2066.outbound.protection.outlook.com [40.107.244.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ECE3810E81C
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Aug 2024 18:47:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sbwCwBEIhmy0u4VP/Utqw2HeP5d36YaQPOGfLVQlwc1biA+ahZCSRTVH0O/g8h3l+cf5ZOtB1gluRwuEOVSnzEwDJdhen1SsYJr4bFxL2ZgDH/X1KrsytfJyGoxowoM+Sj9VOqn4BpvZ7as8Kt5yGcuiyQRQB0S5p6e+mnvDtr2taJLaR7icPhosIcZpf4i5BP+8zomUEQ7NPbiZd46ZTedP1PH4bSTujZAEAOz/vUjYMcDiGr/sc+SFcF+hAeJ7XrimcBWv1hx3xTkPWvDF5Mok/h2pQNk98EVG+zXMMkcyv2U7J5VdHPica63rgq/kooNWrGyok3rouvqeIl8xyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GK2SYfQ0zHhzaf/sCV2n4KpRRB4YVIc6Xc5kpG8Rfdg=;
 b=w3+NmfAMShl4CfxS9xZpnPwWTUu2T/YCI8YKgufuV8pzvkYurl1IXVcIqvL3Hd/lBAEanqskoqF6Oj5dkZ+5oC3esSu/NCpbaWDbsYMx7GuAMADNn4ywJGSbWmb4miCo+vG/6bXGxW1QXdKkghzVLvgFkKYbb6UxrnMEVU9DRvpA8MDs3aXHugQCqJ5RLXS5J5da7eUURifBfdSPImxklyFoyVlv/Ou73Ycxy1+8WFGnCz7M8HxmYr3XwmTt8V7yCgSz111c08JZrFEysKZz2VIyWdgHqt3OQaLiRUzCJqtPjwmb2qVj6SyEqbUWGBqEUZaIeJJu6jcUNCgmuuLjVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GK2SYfQ0zHhzaf/sCV2n4KpRRB4YVIc6Xc5kpG8Rfdg=;
 b=Yoc6z8BQXdBH+6LNpfPVptjdLFH92P7ujGds5GHHuqTyv6VK+Ak3AMYbUUZqzmp9wzO3lXisnt8d1IRhGxKMYA+NHJzmK22VXuIfXTJDy8TERm7FVuu/ipctIpTdJFrV3t0K9Po3tbfHD8lRdXKxHCPdi3zcBh7AtiEA/p3FeL0=
Received: from DS0PR12MB6534.namprd12.prod.outlook.com (2603:10b6:8:c1::19) by
 DS0PR12MB7780.namprd12.prod.outlook.com (2603:10b6:8:152::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7875.19; Fri, 16 Aug 2024 18:47:24 +0000
Received: from DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::ea87:74ba:36ec:8cf6]) by DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::ea87:74ba:36ec:8cf6%4]) with mapi id 15.20.7875.018; Fri, 16 Aug 2024
 18:47:03 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Li, Roman" <Roman.Li@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Wentland, Harry" <Harry.Wentland@amd.com>, "Li, Sun peng (Leo)"
 <Sunpeng.Li@amd.com>, "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
 "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>, "Li, Roman"
 <Roman.Li@amd.com>, "Lin, Wayne" <Wayne.Lin@amd.com>, "Gutierrez, Agustin"
 <Agustin.Gutierrez@amd.com>, "Chung, ChiaHsuan (Tom)"
 <ChiaHsuan.Chung@amd.com>, "Zuo, Jerry" <Jerry.Zuo@amd.com>, "Mohamed, Zaeem"
 <Zaeem.Mohamed@amd.com>, "Li, Roman" <Roman.Li@amd.com>
Subject: RE: [PATCH 00/13] DC Patches August 15, 2024
Thread-Topic: [PATCH 00/13] DC Patches August 15, 2024
Thread-Index: AQHa72TaXnWvKvSYP0eCGZGqDd+TFLIqOkyw
Date: Fri, 16 Aug 2024 18:47:02 +0000
Message-ID: <DS0PR12MB653472065A244C531AF987C99C812@DS0PR12MB6534.namprd12.prod.outlook.com>
References: <20240815224525.3077505-1-Roman.Li@amd.com>
In-Reply-To: <20240815224525.3077505-1-Roman.Li@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=8323eb86-c7e0-4677-8a94-51d318bc09da;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2024-08-16T18:46:56Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6534:EE_|DS0PR12MB7780:EE_
x-ms-office365-filtering-correlation-id: 10b3b148-153e-4287-cfb5-08dcbe23d19f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?JeGBNf/i41rnZyLIa461dmokwYY756PXFbtjRr9Jclog344ENmd4gygBLAhJ?=
 =?us-ascii?Q?Xce26eG+bZoaNjDv6Ruf41hPS3UqtjAxxLGb0eMtUX6GXxSm5g7QzLWK8NbK?=
 =?us-ascii?Q?sAvxuwXJlUMBUXFl2lZTLya+esMN7NiFd/IrZy11qVcKnXbiyOk0oip8kJiD?=
 =?us-ascii?Q?+Mz3INHYHdmnCMPMT06XHEKTyswjvBd5T9GFo9kyWm89wbUVAsDfbW9hcjK/?=
 =?us-ascii?Q?P++jmunCQpBmLPUH9PeVwqmpmG92Pl0+OCtvpZl9pi9FEUwgxigT52hu71we?=
 =?us-ascii?Q?OWJDha2XUhTvJhXeL6+vw0IUzVL5TdgXctoE7CNNjJ1h9GhuDysbm++uO+8p?=
 =?us-ascii?Q?ic48Za8uw8VKt5BkDqJmz2Oqu9EiN3dRd8ZRdKUwyRmvJo0GGWA9oB6mQeG1?=
 =?us-ascii?Q?F7/HtE6IPKLB2/5kVXojnhhXN50FlHySx+1woOO375lAOzIE4x2gKg0VCf3w?=
 =?us-ascii?Q?g8/QGPyNw2XvuJgMvp4Dxf2M90J37xB4GSuYUEQjKCaQB5DrhcQoUwBL1JhU?=
 =?us-ascii?Q?B89g5yeI+sYpLJ6PH8IZeqgxFj3y9/6fR6TH1rJCeuYDm0NBi6d0BrX1m7E9?=
 =?us-ascii?Q?0Gw4mt48T9g2VJvxlORF6by0FxyY/UVmSHAVm/p1p56xONcT+/Azb+kgXXuL?=
 =?us-ascii?Q?0BlAVCqbv0OghwSGWPFZxBtXjruRa7Rxo0B21cLkVkWA+9z75nOb8Nr/e2pp?=
 =?us-ascii?Q?Doj9nlekkr588jbzQe6hCYBcIv3CbmEfgWCMR99VbOydJRcOtIiKCxXtJ5vB?=
 =?us-ascii?Q?J0iQ5M0IOhqkN6wnWuUsKHIojswFdQYaypDHz92tbUpcztkP5/MXZ5JIs1gK?=
 =?us-ascii?Q?p9hhgyo29LjdxiqIUsPQ+JJ7smwYLWzCwMXH0BvFfCIYKTQPsux501dvx8/f?=
 =?us-ascii?Q?rCaqOjt6N3T+H2A8vlCuw0wNSze3EcNqPoLBTW8NbPILoYpnMuYf2iSxk5AP?=
 =?us-ascii?Q?gfDEQRe1/I3pSGt1fpsfnRJw3Ifqa53dUHLAEwvVZTk8pZLuq0dKoeeOaJ7q?=
 =?us-ascii?Q?GByAknB7Y8DFQQ7nSm/LdFN8jhQo9JOA1jRSdfJM/Roz6ygu47Op+wddJyA6?=
 =?us-ascii?Q?JrlA8QBrHgOw3ujVJ8b6TNOiz2hxCXHnOOWZMaxcIEpda2qkt/tATGK+t+8G?=
 =?us-ascii?Q?2lYiuieA5YM7CdWKb1oFjdPjd3MTN4fAO15w9tHONqalwT9mmJRGqCUHjh+4?=
 =?us-ascii?Q?I2nevcwqbXBTyr3wAUlzoctlZMMfMc1nWL4XnRfnL1JRLkekGwhtnkxraHMg?=
 =?us-ascii?Q?ycxhcGLy4tjq/tSsRtVCwMPT1J0U1I1rQ1COKyTmwaiNkqqVJRg0A8YgEXBQ?=
 =?us-ascii?Q?llj6sgeBn0uTvNDDJArS7KJpolsWiSwebPlmiBGpgwKAxgkwJqrJ+qGlth4r?=
 =?us-ascii?Q?1U+GzGBk2Aw84fDG6W+RZm7x26nyTJsY6ywvv8Kg/p+sc4fXWw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6534.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5K14m2Kp4WUYZ/YNEa0Skdffx+PsH9tjjKBd/AfYG2Clg98i78qpivkgzuc3?=
 =?us-ascii?Q?7t3ME7PmI7UJTjk1tfo/EzUF1zMNIPWMD7nhfpQpn1M+T0qdHrWjeGyUcYc9?=
 =?us-ascii?Q?2nDLsixgVasX7998GrbALvHhEQ0Uof2v+TjlokKcooLSNc8EZDC7WHmpWRa6?=
 =?us-ascii?Q?cZLDB9UGvuLZ1FxeryMiK/4Uj3okYCi9zCl9fyg7dqmI3zVroC9rDOpyFnEH?=
 =?us-ascii?Q?CUdC+n1XZCo2exjt/DnrZTTrMMjF8U3NKLFrPDaFNjkgLnGVA2bPqqjpU6SA?=
 =?us-ascii?Q?L5ZM7FxGoC9gmwv/8xJY/iaXqTzePd42KW9/3mV3KLaMyaFeU3fCxhZg+9XQ?=
 =?us-ascii?Q?iGwYSP82mGhtTkPDBk/h1xcwWueIatmNmkWPIwYVzla5IOlDEOKiVa2c1qsW?=
 =?us-ascii?Q?/f/X+7tkcccV1f6b1nsNTiDuz1OjwN6fgUA04VYqUynRQQeIgU/tUyh4F9/b?=
 =?us-ascii?Q?cLGHWigdKgd5AWhCMi0GPslvOq1t49oHhrxYH8lJRmORI6a6cYX84ZuHFsmY?=
 =?us-ascii?Q?rqvfwEP/xf+/kpwREhpPk+Xpnas8W2wL9FAV+RXOzNLydSLEhxzgM2yXjdxE?=
 =?us-ascii?Q?Bf+X+NsBGOaCXNWZZlqo2NzrOSPyPZMuNQ14rS95n4RHMQ81kUZVhHjz3hcg?=
 =?us-ascii?Q?fb4gJ8kOgDuNyvjLnpiByTi6hvARZB9JoXxY8HCd4zzMho1X83Ygtt4vASGN?=
 =?us-ascii?Q?5CVu16hW34iJJqPG0nfm4ay0LWoGsTIhcm7Rur9D+cI14HyDQq1BHkTKXeP4?=
 =?us-ascii?Q?nmLHsAbuqk7j/xrIiWBuEr3C1kaeEnHSTuqLwnSCr2bYyo+JKFkkrKuEicXl?=
 =?us-ascii?Q?SEamFxBrQMzEA+nwCTI4iTomfQ+hkEED0f6wqXdBT3/HQs75DWASih8xPC3o?=
 =?us-ascii?Q?nfMpyf17J/T/Q+9O9uW7F9rC8YkzMz/W8WpIDv8dtNwAZNnY8aNCUFjJBP/+?=
 =?us-ascii?Q?cvkS9YIOVNW2EsDBF53K5f0H9yxesScH+/vEVMiJNx+aTqOKcWUGy+eXocoO?=
 =?us-ascii?Q?R4CF/dgxv1e7SM1G6f6XrI9TIoMkAeUYoZGegK16HC9REUgYyhyzJ+Wakoy0?=
 =?us-ascii?Q?uYGNPjZ/vZsxNrYNltsC8MfOx1oSLPHtb4i3dcnlBYDmwnidD1NDW4UjVAn1?=
 =?us-ascii?Q?Zb6/vTR64X2KKaeuqtJx8O5cVbnkr5jU4D1T96N6037AAob6FchLf204p6t9?=
 =?us-ascii?Q?UleElR8EvLEnp7A9nB50VpUtkTygn1nislOGO3oEvBbmQ7vs3vykFkGo2jHO?=
 =?us-ascii?Q?hQH+K7KKngiqGfvIbvOMlVRmKszU8B61AdM8u+q/t6TenKpiwU3/Rhn3fgv5?=
 =?us-ascii?Q?xU5bfG66dh1RnuuqRgAxGEif1Zetot66IREt44UJW5MNyq3zR8NN6h+jNpQX?=
 =?us-ascii?Q?Jjl9ZOuwYzaBxXUoCsjSxoEBSls7SEDqdD5uPh2gbJKo8tRM6IAVXh2SWCdJ?=
 =?us-ascii?Q?RfYRKkr1ap4dG2+jXhhhI+DDxK37chkDeQ7ds3rlQ2dn/FSmpj/HN6hS7Ho4?=
 =?us-ascii?Q?OhSmlLkszRyl1Hx6+1JSnoX8hey/XyVbXHE7ylQ3UlQoXRhQC2Tf3Dhp/67+?=
 =?us-ascii?Q?y3wIHA2nTQUymOYAnmU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6534.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10b3b148-153e-4287-cfb5-08dcbe23d19f
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2024 18:47:02.9665 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HA0DIsfG7dbK1mCwYjDAjhbuuuljxKnuOzaxhjhaLJWQy2kevCnyPxwpFw/XPe0vtyiS0Yx30umnx9E8dQcEmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7780
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

This week this patchset was tested on the following systems:
        * Lenovo ThinkBook T13s Gen4 with AMD Ryzen 5 6600U
        * MSI Gaming X Trio RX 6800
        * Gigabyte Gaming OC RX 7900 XTX

These systems were tested on the following display/connection types:
        * eDP, (1080p 60hz [5650U]) (1920x1200 60hz [6600U]) (2560x1600 120=
hz[6600U])
        * DP/HDMI/USB-C (1440p 170hz, 4k 60hz, 4k 144hz, 4k 240hz [Includes=
 USB-C to DP/HDMI adapters])
        * Thunderbolt (LG Ultrafine 5k)
        * MST (Startech MST14DP123DP [DP to 3x DP] and 2x 4k 60Hz displays)
        * DSC (with Cable Matters 101075 [DP to 3x DP] with 3x 4k60 display=
s, and HP Hook G2 with 1 4k60 display)
        * USB 4 (Kensington SD5700T and 1x 4k 60Hz display)
        * PCON (Club3D CAC-1085 and 1x 4k 144Hz display [at 4k 120HZ, as th=
at is the max the adapter supports])

The testing is a mix of automated and manual tests. Manual testing includes=
 (but is not limited to):
        * Changing display configurations and settings
        * Benchmark testing
        * Feature testing (Freesync, etc.)

Automated testing includes (but is not limited to):
        * Script testing (scripts to automate some of the manual checks)
        * IGT testing

The patchset consists of the amd-staging-drm-next branch (Head commit - 982=
c225d4768ee1cbfb50c56b5560edca758dbfc -> drm/amdkfd: Add node_id to locatio=
n_id generically) with new patches added on top of it.

Tested on Ubuntu 24.04.1, on Wayland and X11, using KDE Plasma and Gnome.


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
From: Roman.Li@amd.com <Roman.Li@amd.com>
Sent: Thursday, August 15, 2024 6:45 PM
To: amd-gfx@lists.freedesktop.org
Cc: Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo) <Sunpeng.L=
i@amd.com>; Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>; Pillai, Aurabindo=
 <Aurabindo.Pillai@amd.com>; Li, Roman <Roman.Li@amd.com>; Lin, Wayne <Wayn=
e.Lin@amd.com>; Gutierrez, Agustin <Agustin.Gutierrez@amd.com>; Chung, Chia=
Hsuan (Tom) <ChiaHsuan.Chung@amd.com>; Zuo, Jerry <Jerry.Zuo@amd.com>; Moha=
med, Zaeem <Zaeem.Mohamed@amd.com>; Li, Roman <Roman.Li@amd.com>; Wheeler, =
Daniel <Daniel.Wheeler@amd.com>
Subject: [PATCH 00/13] DC Patches August 15, 2024

From: Roman Li <Roman.Li@amd.com>

Cc: Daniel Wheeler <daniel.wheeler@amd.com>

Aurabindo Pillai (1):
  drm/amd/display: remove an extraneous call for checking dchub clock

Austin Zheng (1):
  drm/amd/display: DML2.1 Reintegration for Various Fixes

Fangzhi Zuo (1):
  drm/amd/display: Fix a typo in revert commit

Hansen Dsouza (1):
  Revert "drm/amd/display: Update to using new dccg callbacks"

Ilya Bakoulin (1):
  drm/amd/display: Fix construct_phy with MXM connector

Martin Leung (1):
  drm/amd/display: Promote DC to 3.2.297

Michael Strauss (2):
  drm/amd/display: Update HPO I/O When Handling Link Retrain Automation
    Request
  drm/amd/display: Allow UHBR Interop With eDP Supported Link Rates
    Table

Nevenko Stupar (1):
  drm/amd/display: Hardware cursor changes color when switched to
    software cursor

Nicholas Susanto (2):
  drm/amd/display: Remove redundant check in DCN35 hwseq
  drm/amd/display: DCN35 set min dispclk to 50Mhz

Sung Joon Kim (1):
  drm/amd/display: Support UHBR10 link rate on eDP

Tim Huang (1):
  drm/amd/display: fix double free issue during amdgpu module unload

 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   |   2 +-
 .../display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c  |   3 +
 .../gpu/drm/amd/display/dc/core/dc_resource.c |  18 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |   3 +-
 .../amd/display/dc/dccg/dcn35/dcn35_dccg.c    |   4 +-
 drivers/gpu/drm/amd/display/dc/dml2/Makefile  |   3 -
 .../dml21/inc/bounding_boxes/dcn4_soc_bb.h    |   2 +-
 .../dml21/inc/dml_top_soc_parameter_types.h   |   1 +
 .../dml2/dml21/src/dml2_core/dml2_core_dcn4.c |   1 -
 .../src/dml2_core/dml2_core_dcn4_calcs.c      | 478 +++++++------
 .../dml21/src/dml2_core/dml2_core_factory.c   |   2 +-
 .../dml21/src/dml2_core/dml2_core_shared.h    |  37 -
 .../src/dml2_core/dml2_core_shared_types.h    |  22 +-
 .../dml21/src/dml2_core/dml2_core_utils.c     | 631 ++++++++++++++++++
 .../dml21/src/dml2_core/dml2_core_utils.h     |  39 ++
 .../dml2/dml21/src/dml2_dpmm/dml2_dpmm_dcn4.c |  54 +-
 .../dml21/src/dml2_dpmm/dml2_dpmm_factory.c   |   2 +-
 .../dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c  |  20 +-
 .../dml21/src/dml2_pmo/dml2_pmo_factory.c     |   2 +-
 .../amd/display/dc/dpp/dcn401/dcn401_dpp_cm.c |   5 +-
 .../amd/display/dc/hwss/dce110/dce110_hwseq.c |  44 +-
 .../amd/display/dc/hwss/dcn31/dcn31_init.c    |   1 +
 .../amd/display/dc/hwss/dcn314/dcn314_init.c  |   1 +
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   |   3 -
 .../amd/display/dc/hwss/dcn351/dcn351_init.c  |   1 +
 .../drm/amd/display/dc/hwss/hw_sequencer.h    |   1 +
 drivers/gpu/drm/amd/display/dc/inc/resource.h |   2 +
 .../display/dc/link/accessories/link_dp_cts.c |   8 +
 .../drm/amd/display/dc/link/link_detection.c  |   3 +-
 .../gpu/drm/amd/display/dc/link/link_dpms.c   |   4 +-
 .../drm/amd/display/dc/link/link_factory.c    |   3 +-
 .../dc/link/protocols/link_dp_capability.c    |  59 +-
 .../link/protocols/link_edp_panel_control.c   |  14 +-
 .../link/protocols/link_edp_panel_control.h   |   2 +-
 .../dc/resource/dcn35/dcn35_resource.c        |   1 +
 35 files changed, 1110 insertions(+), 366 deletions(-)  delete mode 100644=
 drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_shared.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core=
/dml2_core_utils.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core=
/dml2_core_utils.h

--
2.34.1

