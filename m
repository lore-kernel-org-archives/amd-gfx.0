Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35F10D46C19
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Jan 2026 03:03:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD18910E7B0;
	Thu, 29 Jan 2026 03:03:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="R1TS1qTV";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013053.outbound.protection.outlook.com
 [40.93.196.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E36010E7B0
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Jan 2026 03:03:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oiTWOVMzrPgf5RmMgDt27cgCr95eeGRsXaRP+ybv2aLowdJRnHw5prGvwGHVOQvTTRn6I14/rTkjGqXh+CLP0B1ebSrjjDcIikia6dhcGPUjWStGNLk5NxHdF9wvitf0DuHZXMVPBH44Pi+AYq4VX0pcPcrGi5ayuZH4LHOvsbho8jSf0MwPbw/LEwYnTGuXgPfTc45QpAyWsoniWqUd/x5+ZB8I26Xejmwx67rw+/ox7AngMxnxX1CF/HCnUWdlQHeDbRNz6QV0sTPr+I1TkFt688ofISMmhPzxTljg0aR+8WCnKgVlNYn/YCU849jXqbat1syIHaVBZG0RHv6Gdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zt0mkHnFhw99gUlxnVJ3A8CKUT6O5dnvYmL7/LnvCaw=;
 b=vUCZZRt775matDbmJHi7RvJqN6qiRDU1nJ/vrERWT9oOGCnvvGPq24w5rdv16vC8dbxyGbQqIrfkR1etKr8o1MOSyLSYf6foF9LThNX7FGdrF9LKn4bEar+1LC3JchJcwvfBFSUqUPUNVA/4gNB46BI0QQUxswYCLH37JYGk4RlcSqhDuXa3WOCQRHyINselJZsH93j/te3w6CH6dZ92l/GsWtNz/7R7ZIYCjsTv46uoN0jGI+UG7LvAL6FZDJXrDi7ljCPALb5Tr2yjJ5DS1h+BVX5uWGGtW6uu9xNGwzsB/h0Q5EcgQ/XlmLS/MuNIEV6NL5I0VM1KJchGFltdlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zt0mkHnFhw99gUlxnVJ3A8CKUT6O5dnvYmL7/LnvCaw=;
 b=R1TS1qTVQ2LDpQSt7HEsE/dHPFhb1j+67YWrhPP9lD46RVrTZgDTiQLMuvTBmxUuclfYN0fGYBKwYGVzM/n4p83STSE6dNthuUkQ41lwadx4AZET/jdELy2zboghS3b486sEJesiZQdGDpIv1JMOIT9tFDZW81cZCbpEGrdK0lM=
Received: from MW5PR12MB5684.namprd12.prod.outlook.com (2603:10b6:303:1a1::21)
 by CY8PR12MB7193.namprd12.prod.outlook.com (2603:10b6:930:5b::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Thu, 29 Jan
 2026 03:03:30 +0000
Received: from MW5PR12MB5684.namprd12.prod.outlook.com
 ([fe80::f0a2:a7d9:42a8:ace6]) by MW5PR12MB5684.namprd12.prod.outlook.com
 ([fe80::f0a2:a7d9:42a8:ace6%5]) with mapi id 15.20.9564.007; Thu, 29 Jan 2026
 03:03:29 +0000
From: "Xie, Patrick" <Gangliang.Xie@amd.com>
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Chai, Thomas" <YiPeng.Chai@amd.com>
Subject: RE: [PATCH 02/14] drm/amd/pm: add feature query interface for uniras
Thread-Topic: [PATCH 02/14] drm/amd/pm: add feature query interface for uniras
Thread-Index: AQHcjnepvcbGSxc3nEenDTArMga3frVocXKAgAAJDxA=
Date: Thu, 29 Jan 2026 03:03:29 +0000
Message-ID: <MW5PR12MB568472A08503CCC1409B8897E59EA@MW5PR12MB5684.namprd12.prod.outlook.com>
References: <20260126035527.1108488-1-ganglxie@amd.com>
 <20260126035527.1108488-2-ganglxie@amd.com>
 <PH7PR12MB59971AF2D0DC9FBB360C764D829EA@PH7PR12MB5997.namprd12.prod.outlook.com>
In-Reply-To: <PH7PR12MB59971AF2D0DC9FBB360C764D829EA@PH7PR12MB5997.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-01-29T02:27:52.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR12MB5684:EE_|CY8PR12MB7193:EE_
x-ms-office365-filtering-correlation-id: f247410e-971c-490c-a42c-08de5ee2fae8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?HIejzgiKfIujL17nBS4zZin8pHU5FEZ/xYe4/EFRFtWxe5Ae2HslyLF+C2l7?=
 =?us-ascii?Q?7oGPMdDc4tuxG+7ke7wZE7l5IBMjpTMiMUBTu3zOtzoWrGeyHxsTj12vLQaa?=
 =?us-ascii?Q?kyn6BN5L31BXYA3W2cF7VXAN6EB35FykltASDPV/JtAMUJm7cNLS76Ofqrj1?=
 =?us-ascii?Q?DofC4bi2H9uvCAZhyBPZQT1tCiIiI51JaKCDZOaFBsAJIa3Nh9wUq1gG4pwJ?=
 =?us-ascii?Q?CIOK2lu20Pfcb1Lpyu52FLJFy5dU7zfBI8x6xrVnYd5HtRpTS9gAAWvpqXp7?=
 =?us-ascii?Q?mGok5Yotn2bayxOPPq/NnXY+lcU38XCKXlcpmHfpA5I9fwxsyRtohfIxKyXv?=
 =?us-ascii?Q?l8vzHSE4Hsnm2iIQMbF/Iq/nUmwP4kmA0RVVBm/pDn/mXJhO/cFYSzuodwQJ?=
 =?us-ascii?Q?Lzw4AEFT6tKoNHwg1k9nE+oMF2ihXIdp5Q8zui6Vuk9QUZYGx8aCF/INrpGz?=
 =?us-ascii?Q?YyxoYzb9bLDgR6feQx2yZU3qmhLfx+O0rP6BQkQHKMxQJwTqSiRkYAo+ZIQJ?=
 =?us-ascii?Q?Hbf1S3nIrmv9pEX1bErYKU2YtVId+wXVW9fJsGs0kLA00Icdr1Ddp9TjSBDr?=
 =?us-ascii?Q?qmsDm33SwUnjOD3P/3KBMb/nat+mPihRx7F+X6G6ciz9ZJa5Q8TcUKtv1b15?=
 =?us-ascii?Q?ufnQAnLrYpkxWyjdpLf2JCriMepfPjA4pmUB7yTXhIEOqAX4QUZdb00RS7ki?=
 =?us-ascii?Q?XRB+Nfn2A5Foo9mTjOf6ULJ5S+EkcyKu2Y2ZtrlEkJxw+Mcp7FtHcccDYI37?=
 =?us-ascii?Q?V/xkblS5QgFcYdkEcxz8E8Gbq+Sw1DG1pBZ7vohPxlZrHLFTSOJCTJ46+YxH?=
 =?us-ascii?Q?zR4s3bx8yHCw7L6sdcO9eQbnoC53L2O2Tf7rVUkgpPhgt6iHabKmsYh4lORA?=
 =?us-ascii?Q?rVW+uVJZgN2/1V9UtzQRzqrYb6xulOCDNQ6Gcer7JN2Mx5mA+uRqj8E9S20X?=
 =?us-ascii?Q?1MR27CtY98sUnarjGVTfzvwZ6BknpI7WKr7faZJYCmnk/4XnvvdgbLgR///q?=
 =?us-ascii?Q?OKs3JGSpnSIlTVF4NRoG7EyqSXOaMeGOMq7YMFQWXEPYgDVasRcVT+Db4mrW?=
 =?us-ascii?Q?rRxHabp5oE9D5gbX5ZNdkuDp++kCQ7nLLOj32+UoA8XHG0r/IRwFI0lQTWbV?=
 =?us-ascii?Q?pU1rYJALHzbMcb0W+yN0a8htqncQopaYUUKFxurBG0loTUtKVPws4SzvVUeG?=
 =?us-ascii?Q?wdcBDb88rlRXiVURSqw+PBY4VqWwNLtZIsNNteID07vusLdF3HGY3006ufaX?=
 =?us-ascii?Q?ZyF/MDX1dnHDn+an1dZFZIClbK3wNXs+YK9eeJXTVDkNhmHesQWjPdKvnDDJ?=
 =?us-ascii?Q?JErsqBoMjV1nF1LxDvCV2g1qpgeIL0aPIWws0vFyJuaVTDqmLyGHKr+fnSXn?=
 =?us-ascii?Q?/xUnT2KXkG7QH4NGMgGAukCLshxOZ/qrDkyy8yPxcd6fj+7up8UWgzQjAlc1?=
 =?us-ascii?Q?n55fGWU50pJaKDIpkcaUj/N5s7yKAOZ1z+5k9mtDJPn7V07PuFhtsjyJ2biV?=
 =?us-ascii?Q?5f4M2kzfTCc4yOmLTR1tOYKjRSnLd1IuUcPcazNWGgiU8aMaP6FQUGGMRCfC?=
 =?us-ascii?Q?XypOeKSxT/PYAOa9yosiF3TiLFYbSnMdpczgPLY9henLlMzzmRy6BWaHTUg+?=
 =?us-ascii?Q?YYLpbM9srRV/wezMIMcfukw=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW5PR12MB5684.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?FSInUGh2Ngq+gg3cfe2iMQup8BYXsIJSHb9Zi/iSSgo/+wJkxFjv38Zun8Jc?=
 =?us-ascii?Q?H4Hlcz3ygl8t+DNKcLORAVITUm3AtdHipYeiT31c7CMEMeDIIXISMQkEtArB?=
 =?us-ascii?Q?j314s32BftWHCwDHvKfWevVA/8THrM8NcwxrsWl2+wa/6uF0I8P+IPYVJpKo?=
 =?us-ascii?Q?2kjR3GQlVZFx7C49PTuuVkwcVysXu3lVEegimRILK2mnZXu2Y7P5gB1twyZy?=
 =?us-ascii?Q?o3u8SAefJZgF+t0PbJvgGLdvO4x7U/RkQG93asRe0FHTs/aiPQHKUHva2rPA?=
 =?us-ascii?Q?1UuV+cauU5C8TLPwLRbCwLrj74HUVo7I6awQSebASinm5Uz/gPvVKQo10Xqt?=
 =?us-ascii?Q?Fmj4O9d//pj06r1XSApBkO+rCeHwnlXkquW38u8V90JzObv/f8zJsCqw9C8q?=
 =?us-ascii?Q?Y7eOCOy+0GCK6tY/V7Ny2buKRgfEuBtlPoGNqPdWaO7zvl0ebXLTFUFaG3OR?=
 =?us-ascii?Q?5cLgLSEAweCys5z9NeCs0ou2JIG2hwpOirbBN+2ois0jF3L65L3YlBJRtn1S?=
 =?us-ascii?Q?7Ag0jbINJAoBMGnhQNAt/S0aS2CSd4EU/adlE2VTCIihgRq2kr9+zhPxuGZ3?=
 =?us-ascii?Q?VFl2F8lhZCHdYzJoJ9iOHeo1ZBI0/v1tZo17AUAFgfKDjrrBlrZTzZsk9wNH?=
 =?us-ascii?Q?B6hDPUtKSXtGAgqlNwfqkOJcS6d1XwW0DnvOGNf+m1BAu0cGjFp51m93TS+b?=
 =?us-ascii?Q?VXyrx6rgHRJRNYqwa5O8aMWapdid38SBUSdVY+uL8X1IZiJrijLQVL0aG1yX?=
 =?us-ascii?Q?Et0RMhmE565wthM5ghA07T1fHmuiognYBciYwtcbTFnd3yoCip4I7DFdhYo1?=
 =?us-ascii?Q?p4uJ99dNAiPB5RfOXvDXyo4qcwps9Whmv36jyRRr84OLFRnJ+/TA7K+1ID/i?=
 =?us-ascii?Q?Pu94A65f1hotFuQhZTZ1Ag+CYP8/c8Gje2pE4Kiu6xqe3xTFTj/PFdEydB94?=
 =?us-ascii?Q?to+iNxWiKhzCGplPLlRqIEjZptY2Pfr4jIc5JMbJHQ1dC/glRisMs/yRLXO5?=
 =?us-ascii?Q?ng+Vb6Hsds71W7zglNv5zMV+sg2t9fiBlQBXWSa63/3TkEr69pgTCopdaBo9?=
 =?us-ascii?Q?kcAWf+NdmfPN9ANWcE4VTi5875xa2rpKwL+cs+pHihonzKgVNy/IP6GiE0eg?=
 =?us-ascii?Q?+mw7aTKqoxQRMSYarWvf+Juz2Rxkr49SUjQnmP6qn/8zy9XFExmHw303Qt+0?=
 =?us-ascii?Q?tV8HOhjEDCY9YkVb4wYl6C1InV0+AqVFrMw2oJKt6Ym5Dzh0dndMmnXwuCZP?=
 =?us-ascii?Q?kMT/EmxgPNzcv7HxkKFCVWqHcgDZnYoVJe4Q2hLtUoxgOlVBIskclbCIlZUq?=
 =?us-ascii?Q?A9XHtlvpeZu96m4Y6rzCq+y3sgWR0FD/49xnO8KUEcSUYlr5r1188KlGn50u?=
 =?us-ascii?Q?v44Zc/W8oxYfoI/CpFT0RGrGCEfUVtD9hl1QXlG/xMcCTVe+s1qS2ORTK/vJ?=
 =?us-ascii?Q?dOVzGaFVHPqDUANWUCVxbVl/438+f/MYxne4MbABwkrSrrY0y/tQ7nD/RpMF?=
 =?us-ascii?Q?GBgciH3RbJlFjry12UAKzo9iX/OHWlFgdbf0JDcCKddQx80i8HVVQWhIxzyD?=
 =?us-ascii?Q?DZfgTttYLFQpCCJfNBvTKp4KC3STqWew1/xFQFLCRojWypWh5PyVAdeetLUI?=
 =?us-ascii?Q?/p2e8G/CpOm/D42NXNlb/W/HeQ+sL3erTHQgQyWiJ+22l11OEFY1/FZ5z+cN?=
 =?us-ascii?Q?cHHN17OZF/UCUSLQ3jvIBmV+tY3zdgzO3RwVzTqXK5mr4Afw?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR12MB5684.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f247410e-971c-490c-a42c-08de5ee2fae8
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2026 03:03:29.8123 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RBpTVBm5p4QmzA8NjTMDP3o1zhCsUCKznAmnStyuK7Abu6aTpXgpTHItGPJOMubg0qWMn6AG1cK+s+0AANvc9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7193
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

Thanks, Kavin
Will change to false(0) as default.

-----Original Message-----
From: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
Sent: Thursday, January 29, 2026 10:30 AM
To: Xie, Patrick <Gangliang.Xie@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>; Xie=
, Patrick <Gangliang.Xie@amd.com>
Subject: RE: [PATCH 02/14] drm/amd/pm: add feature query interface for unir=
as

[AMD Official Use Only - AMD Internal Distribution Only]

+       int ret =3D -EOPNOTSUPP;

how about replace it with Bool false (0) ? I think it is more reasonable to=
 use false(0) as default return value for this api.

Best Regards,
Kevin

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Ganglian=
g Xie
Sent: Monday, January 26, 2026 11:55
To: amd-gfx@lists.freedesktop.org
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>; Xie=
, Patrick <Gangliang.Xie@amd.com>
Subject: [PATCH 02/14] drm/amd/pm: add feature query interface for uniras

add amdgpu_smu_ras_feature_is_enabled to query one feature is supported or =
not

Signed-off-by: Gangliang Xie <ganglxie@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 12 ++++++++++++
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  2 ++
 2 files changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/am=
d/pm/swsmu/amdgpu_smu.c
index a15670e561b5..e2bed345128b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -624,6 +624,18 @@ int amdgpu_smu_ras_send_msg(struct amdgpu_device *adev=
, enum smu_message_type ms
        return ret;
 }

+int amdgpu_smu_ras_feature_is_enabled(struct amdgpu_device *adev,
+                                               enum smu_feature_mask
+mask) {
+       struct smu_context *smu =3D adev->powerplay.pp_handle;
+       int ret =3D -EOPNOTSUPP;
+
+       if (smu->ppt_funcs && smu->ppt_funcs->feature_is_enabled)
+               ret =3D smu->ppt_funcs->feature_is_enabled(smu, mask);
+
+       return ret;
+}
+
 static int smu_sys_get_pp_table(void *handle,
                                char **table)  { diff --git a/drivers/gpu/d=
rm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_=
smu.h
index 4d5dfd936ee2..ba8c85f7c90c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -1843,6 +1843,8 @@ void amdgpu_smu_phase_det_debugfs_init(struct amdgpu_=
device *adev);

 int amdgpu_smu_ras_send_msg(struct amdgpu_device *adev, enum smu_message_t=
ype msg,
                            uint32_t param, uint32_t *readarg);
+int amdgpu_smu_ras_feature_is_enabled(struct amdgpu_device *adev,
+                                               enum smu_feature_mask
+mask);
 #endif

 void smu_feature_cap_set(struct smu_context *smu, enum smu_feature_cap_id =
fea_id);
--
2.34.1


