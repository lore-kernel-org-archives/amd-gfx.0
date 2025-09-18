Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1A5CCA1013
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Sep 2025 18:41:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3324B10E8DB;
	Thu, 18 Sep 2025 18:41:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dA8zFZeA";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011050.outbound.protection.outlook.com [52.101.52.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 549CE10E8DB
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Sep 2025 18:41:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kv5ZD6xg4NO/aDOeCbixbO5HM4ksrQZf86DUsd0/O7M28DgEu5BQ9cBveYmuOhHqfUYnCmnz9sDZ/zPAZjDrpwPCeag/Z6Ihbe8gnTZo74n2mgcJ8ke5iquYWLe0ANPJOcF3PCQG5nFhVZH/SW+kSLa59rC5S/TBpNNlH3z/To2jCSxeLwqOGcafj5oveOcBHlR0fmnUqKLEEI9DhZykIOH4iuo4i8EBuN+IrQKATTk9NWAGFVtMAy1nf3Sz+rszCR0jSl6o/g2ugLBNF7z7vDITK6xXv24YDpxNbR8Wa9nfcFWdfAaY582CDSGHEMjGiJiEPn8KqJr/MkJS90jHfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C+tRW9NalHCzfAhqIJMbp9iSbDD6PuEwgmw/lH10u+c=;
 b=b10YEHlv4YzqrKGfmgfY6DkL5ZvY1aLV4Tjp/5KOm8biccLvJj3vkfHRgFx//l1+SNXop8jPAewGQ68np3syPUUKcBwITlR6V6yOCmthyX7qUqg8T7XS8sJb4BnjwpQbDB7cu+MseeYkcB6kH6DgLP7RiNssQGTwUHLAjtLwqTuSW8UswD89fsbr4a9BxWrEOvsTRkz/uthokcmSf7qFMcRAUnMiCRBzoqMf0nyxIKvykGjbhLp9ar1ODcUHyfY+UIruCeg1CrIGnxu7K3SoDXDzv/CNMGx67dNGryHY/74cssF5XD2Ho7qsgCRU6VPe8bHNJNL8lq+9cerFDfn/eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C+tRW9NalHCzfAhqIJMbp9iSbDD6PuEwgmw/lH10u+c=;
 b=dA8zFZeA9nw/BLpB5Au49/80Yx67rz/Doyujckg4xhjocisq+Seqe2OO1xRBKON4KmjIQzIJC/p8D/1thLNyegrHPjMq8YP0rS45q+csDrQNffLsSmVDFwq7cmvV4YE0uHZc+qgGR9xzWE72NN6T7nuiT9j7rwcliOl3IAwETiA=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by LV5PR12MB9826.namprd12.prod.outlook.com (2603:10b6:408:2fe::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Thu, 18 Sep
 2025 18:41:34 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%4]) with mapi id 15.20.9137.012; Thu, 18 Sep 2025
 18:41:34 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Chai, Thomas" <YiPeng.Chai@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Li, Candice" <Candice.Li@amd.com>,
 "Yang, Stanley" <Stanley.Yang@amd.com>, "Zhou1, Tao" <Tao.Zhou1@amd.com>
Subject: RE: [PATCH 01/10] drm/amd/ras: Add amdgpu ras manager folder
Thread-Topic: [PATCH 01/10] drm/amd/ras: Add amdgpu ras manager folder
Thread-Index: AQHcKDy0PlTK5532ZEKp121a8brAxLSZRyNg
Date: Thu, 18 Sep 2025 18:41:34 +0000
Message-ID: <BN9PR12MB5257522BB4230E752C28C988FC16A@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20250918013507.2629620-1-YiPeng.Chai@amd.com>
In-Reply-To: <20250918013507.2629620-1-YiPeng.Chai@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-09-18T18:41:12.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|LV5PR12MB9826:EE_
x-ms-office365-filtering-correlation-id: b2f74c9b-81e1-48c4-a5f3-08ddf6e2fe6e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?c6CyA85ovzh+yfktl9LnHEOf48qdh65PatxIdR+3MSVJtHIR14KUiLXyybqC?=
 =?us-ascii?Q?kjSqxKFXuKIY6JcB3PBRBsfGZEsac2szFpvz0BGbohnGQMCVh+7l5uW2atMW?=
 =?us-ascii?Q?0tb1eZE/uZie6z6/LOYzD/h07S2L5/GqcI4izNbrwRdUTmQcPiUxsC/s8Nc1?=
 =?us-ascii?Q?EsnZv0TJ2oAZjcl+4i4UKZ5IZYZ/qlO9TmoLydoOeD89tkB97s9Wt8U6XZc1?=
 =?us-ascii?Q?NO4zz3SFlQGqURCxKoJKFRz2yckagiI2Xz+ZUDatN8hpS2Nkp0kV756YCW9z?=
 =?us-ascii?Q?+P5bwF4OtqaWp48G0ou2PZF8nzMD1i4ElMgE92pW7JXnYQVgqitDw7y0Q+8l?=
 =?us-ascii?Q?iK5iV+lniAAoWVU3r8kHWMruvy/hwlaHZyEZQlbYOhuNP6HwoHd0j+d8nh+N?=
 =?us-ascii?Q?aMmZXu8mU8pPUur4FHhg4mvriw7z/ylNvheeIKULQWDYdwY3IF44BmMhZh+O?=
 =?us-ascii?Q?9iuSiAALCtDbUs7XnYGCDBmxKPlZrXM9stmeMS1KSgAAiCWulqRECD00zJsp?=
 =?us-ascii?Q?+a5Aed35/ogu6qXfAfjtcD7e9+jxAA4GVKA4O+DPgC6ToA+Fdui5BIiEULDS?=
 =?us-ascii?Q?xPVhZcCfUhONC/8ZF6sqFqt5+VftJEQg2dGlNCK+kCd1tte0C2EUDYjsdWIn?=
 =?us-ascii?Q?oFB0LnhzWzMrxubT5WZ+yLT6rdSKCIAqQjtCGbyJoNsYWWu33ls9UWZMpmfY?=
 =?us-ascii?Q?Vd6RxC+oRh/jD7GlDeLPiJA2hDK0LYRquAJjqo9tzzHdrKkd/EPhL+qmf1vB?=
 =?us-ascii?Q?1Togp1NIy4Xp/aHUNPKP30HJ/7fwFS4klUSQoVkqnYKTbkGal9nGIHvfa4k2?=
 =?us-ascii?Q?vDX3UUcwF4wpZSk88LC92pJo12vO4y6C908bmPmMZQudtPtVDXypJfxnEAyG?=
 =?us-ascii?Q?wgC7BVy0ouoJiH9o7ISuYEYKBPdBKHL7iMQWrK9d+U1hR1yI/6116NzinU00?=
 =?us-ascii?Q?TmU1ToiAtsTUxfV+Ci/eJOIPQ7GMSXI5kELMyCM6dllLsJTlaLnfXJ1slXVs?=
 =?us-ascii?Q?TozrERaFu6EdJgyAbs95odCNpwB9Np/tdHslYyLJXvsadaEz6QYXMtomX12B?=
 =?us-ascii?Q?TYyJ7+HVKPAxdH7HhLi4EyFcoD76wlqYXAxuCV2b+Dp2Efx9xfCM7bJ0vRrs?=
 =?us-ascii?Q?x1ppVO2btKnnBAlc/tHhOlhN4859Vtv7X/mB+mrOuGa/tw+wxFmSypDWmf66?=
 =?us-ascii?Q?oMG/eT/JF/NJwwuRpx/rwsYBf3aO4P6l2Ggb2ctwIkhYm/2k1vGsolf8kB/x?=
 =?us-ascii?Q?HkULcusO4YqBjEWqCzKepwob6/7SidwyMo1KDqLUKrUYzJQu4NNT8zYr0cvs?=
 =?us-ascii?Q?/j59F3MSfGZ9TcGwaNXN55Uwk/yO6mjaMDqNo/jFs79OuxOxocpIMQyTSScq?=
 =?us-ascii?Q?Kmm0JVkxAV2saLDq4aSsiAly8qEfYF16gLvp7cL9Jj5CkCACrr0L+j+vJZR5?=
 =?us-ascii?Q?/BmCPNUTLuGk50SgbNazlj1Bkvyb+++22i2wYu6pxvc/X3bAis9drDnBTPLr?=
 =?us-ascii?Q?D20I+2ursus3B7U=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?MkEroLJciChrBP5UFqm2+zsgJejZjsrhA9A0/qoB84uWWwtfXhTW90JHxqSR?=
 =?us-ascii?Q?VdGLRYOuwFT5nMJrxOw9kUK7fdGN37gy35SlsRyzSiM1dm7JpkN0Ehom2Fh8?=
 =?us-ascii?Q?kCVtB0EoT2ZJovtov3Z62XJowmwffmnp7F9iNBqNKYRq1n182/FlGvC+7iZJ?=
 =?us-ascii?Q?taWJ5LENnqUWYhXO+SMNk4h7fLelXcmG4OkNyLJMTh1mcUU4LB9hoP3y9uPj?=
 =?us-ascii?Q?wTESItKUEVFyuVvdY/zpAjtASE9cfpry5SIz1U9zo7SWLblWkfnL8LmXjlxT?=
 =?us-ascii?Q?/ViFa2ni41NzhKLqVui2C/RmXIsCPSmEao6DWsOvDnu42qxzDmbt9WEciwZs?=
 =?us-ascii?Q?BzWylKzadD6JzHYHMT1Sqx5S0vI/kMwAYvc9wkvP1Jt/K0/lDeIJmdclhgqc?=
 =?us-ascii?Q?JYG+0qTeIYDMVj42cecLhrz/mbDTsig3eJFTmoVatO+W1t6sG8KWb1gP3smb?=
 =?us-ascii?Q?/E6VQH5PrSwI6reYLbzp16NgSbfSdTfFI7Sbp5755UVl84f3k928/7Icisgl?=
 =?us-ascii?Q?DlJkpr5dn/dpCCihwJwc8CC4aBiaWKEl4K9le8kv+H2cKe0uADBNs8XDLXPu?=
 =?us-ascii?Q?wla4prXLYZ+l+6HWNNqi0drtmppEDcuVXIbMcUrgSUawBTagtPmHNKDiw6IV?=
 =?us-ascii?Q?G6FrX7R83S19Q+ghD+5G20yMbnCNmpXspBZbCWekiU+iBbW3yfEFrhwBZO4+?=
 =?us-ascii?Q?4MiD2Wg1osYcedIidVnYT60UDXkCmuYSrEp4CZR93w/M7vWrFPPikuEjOHG5?=
 =?us-ascii?Q?2Rc0kIbpEJGl1deWm9XegkCwJytVTCKpj3J5ERZQT4JSAjIKu0LZQXrSMF39?=
 =?us-ascii?Q?Ovqc90WOaxVqoO/yPrcUaM0v6HvgEiGNoT8Knw2OtFSH+iwaqkgNy/Ov9W+X?=
 =?us-ascii?Q?OeikIgWs1ViDasRf5pF5VgZyC77H6afNYBuBzgzeY2vTRBO10cvHpS/4bpmy?=
 =?us-ascii?Q?Rdu8n0x180WPkis4YJQJhrvw9lIXa3vIppv/o1aTDpT9lxQNUuPhwsHgd/RF?=
 =?us-ascii?Q?UqzIo3OqzOadW+ngxf/rbpWmjhRj0zfpb44aGsSkLLw4esUijJ7up4Kok8Gq?=
 =?us-ascii?Q?UTCl8fd0/h8Xq3KICrT3PmHmJM+t3v/ZkYZtr2LzFsW2bztiE8SafsYLvEQU?=
 =?us-ascii?Q?vySC2ltICk+03Fc5WOAc740lCASrs12exPScNV8bl0mCUl8O9KCUxu7lo4Ym?=
 =?us-ascii?Q?xnMI31fdrNZWW0sCLEejYcDkdNq1yn4JYICaf5+aWP/G4SiWwRoT5Krgs9MU?=
 =?us-ascii?Q?j4k7pt2rJh7flwsPMa4Xjf/FR1r7VxC0oxHSjEJ8mCukPvVIJAHZ52HNJzQ7?=
 =?us-ascii?Q?7RLKfYBAsM+ashigLgwWWJ4hZYeIF506+SNZZe5wZdSnCgYUF2iiAzehKt8w?=
 =?us-ascii?Q?1JiEvsM/8WjCd9ug7plMaY3XGhwu4xML7de4LerFxW0bXjSwtwpb34NeOPsq?=
 =?us-ascii?Q?cTDkQTMKmyAPEGTW2w/XD6VgWoMM1JgJt+/AF5gbSz0SXL/AscDojWMS5hR3?=
 =?us-ascii?Q?k9t38EiwRkknzrSUyI8uiwHsoWPHtpuA39y5X5qUZuppr9xXG3xoxObbgfPm?=
 =?us-ascii?Q?C669/GMb5Vj1KYdPkoc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2f74c9b-81e1-48c4-a5f3-08ddf6e2fe6e
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2025 18:41:34.8165 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kNV7HgaUOeT02ClOT45UsOdLZejLHrCci4Za1ToxLZfp6Rhol8yZfEraVQ9XFK5jkNQTqXTOMwwVgDfp48iGCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR12MB9826
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

[AMD Official Use Only - AMD Internal Distribution Only]

Series is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Chai, Thomas <YiPeng.Chai@amd.com>
Sent: Wednesday, September 17, 2025 21:35
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>;=
 Li, Candice <Candice.Li@amd.com>; Yang, Stanley <Stanley.Yang@amd.com>; Ch=
ai, Thomas <YiPeng.Chai@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>
Subject: [PATCH 01/10] drm/amd/ras: Add amdgpu ras manager folder

Add amdgpu ras manager folder.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/ras/ras_mgr/Makefile | 0
 1 file changed, 0 insertions(+), 0 deletions(-)  create mode 100644 driver=
s/gpu/drm/amd/ras/ras_mgr/Makefile

diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/Makefile b/drivers/gpu/drm/amd=
/ras/ras_mgr/Makefile
new file mode 100644
index 000000000000..e69de29bb2d1
--
2.34.1

