Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3847CD6E5D
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Jun 2026 02:10:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 044BF10F779;
	Wed,  3 Jun 2026 02:10:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HHKmZtMx";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011064.outbound.protection.outlook.com [52.101.52.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F048410F779
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Jun 2026 02:10:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ggB9u8v0qBPsCWcIlO8Uj8XHVboXyqRZ9jmhlhEO4d+xE0gaPcXHTCvghQETgRx3pSQsDC/Fvw/18nVLHWf/Mr5ZbyKGkb2xR3ZPZkPwy8IqKz5RxBYo+CUjUmM7C3gGgzDhV+dNysUlzqERnPAUhFf5+M1b9wjgGxagd71XUnjKUVtvplXwiPH343m5MuEO3f7xM3ErQhWmbKU/46nDQ+OVoOTyaHQ7EiOzULFgZkGf8uF8I8tLFKRALCngTL/p06/eU+wSRHDonTFKs3NIPTjAQA2dXZVzG5bbTUZxLyxEJTCU4rh8wjZfuDnpI99f8IxsxctKQtrhXn4vU4jw2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OwTvkzsefwcWEjXtqF8ozETJRqUqSpDRNgzxWZjBKAA=;
 b=wabs6WO9nGMiXjkv+8gjzMOeMhVSoXuu12NF8sSnKQf4S2XWuxulPTR4QhSPjaddlRwQGPlp2i0qCQv0Z8AOb5Rt6C7uHYJTiOqTBSdqcWPKGRyovQh6KpsxvK8WNZwLPua9D1xrHFw2waYL8iZIURvH1Hje4VnPgddTEiOdAnO0c6YhntV2Q5IZAAisv/FnZANQM9lvp0C9SstWPjBsMgKo/Hzi1jAeIZ5xDyj+lb6CxYSjXKC5XGwUNFt4P1oius5XQfohzCi1I9xej3l4yeRiEqCD3pJS+EUgmj1THj3/FaBYfslmn2JIF2/eCSIl76/4z0tyKlvkvSHrIowl0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OwTvkzsefwcWEjXtqF8ozETJRqUqSpDRNgzxWZjBKAA=;
 b=HHKmZtMxvoLKDZ213aZ932Tf+ny819+sIIhLkElPxazheNQnYPJXoHnzZR9MGE6IshF6+H5S1J0u7k1KBFyi5rZNq/ShwiZF59Dya6HpSVlpSJBSZXmJqkLX1MAKgcpb6Dw/D34oANANvkQ/EDbLOVh7IDqjBaFhNsDbqzQhWB4=
Received: from DM6PR12MB2972.namprd12.prod.outlook.com (2603:10b6:5:39::31) by
 SN7PR12MB7204.namprd12.prod.outlook.com (2603:10b6:806:2ab::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.7; Wed, 3 Jun 2026 02:10:12 +0000
Received: from DM6PR12MB2972.namprd12.prod.outlook.com
 ([fe80::574d:7c2d:4d0a:855e]) by DM6PR12MB2972.namprd12.prod.outlook.com
 ([fe80::574d:7c2d:4d0a:855e%6]) with mapi id 15.21.0071.011; Wed, 3 Jun 2026
 02:10:12 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Li, Candice" <Candice.Li@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Zhou1, Tao"
 <Tao.Zhou1@amd.com>, "Xie, Patrick" <Gangliang.Xie@amd.com>, "Li, Candice"
 <Candice.Li@amd.com>
Subject: RE: [PATCH 2/2] drm/amd/pm: sleep on PMFW EEPROM busy in bad page
 count query
Thread-Topic: [PATCH 2/2] drm/amd/pm: sleep on PMFW EEPROM busy in bad page
 count query
Thread-Index: AQHc8v2gPsAf4VtUDESQbilH3MzGLbYsFiPQ
Date: Wed, 3 Jun 2026 02:10:11 +0000
Message-ID: <DM6PR12MB2972742C9A2CA0C16F38026782132@DM6PR12MB2972.namprd12.prod.outlook.com>
References: <20260603020559.1273844-1-candice.li@amd.com>
 <20260603020559.1273844-2-candice.li@amd.com>
In-Reply-To: <20260603020559.1273844-2-candice.li@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-06-03T02:09:50.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB2972:EE_|SN7PR12MB7204:EE_
x-ms-office365-filtering-correlation-id: f6f69e3e-8c8c-484d-69d7-08dec1153e94
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|56012099006|11063799006|4143699003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: C/yykpOdRUtmZg95s3A4tstIx1XUW7QTtQvi0Au52jW0OwIE77ST1SdfRIKJFpNrq7y1FQTV0yuvy5ERt+P2TSBjq25igPHdPriLjTrCu+kJBrnS1D6cJQEOKeDePpQdTXNyJ/w1vrJOhzELiN6UZrx+m1TtYh7Cj2IFm3R/QGAnQoDZdRanLNrIygyv3erMkFPuWskKKy8h+qyJD5QkSD4naiI8s8+QiA4+FE9JFt0fsgPiZYhw8U3U0YYmQNiihf5+JH3OhR47a0it47zs/JXfRiybqrmnbMrHvyrPnXosPuYPKyUZYSqU2YI3nLGjiO83LEGF3qIlRVAcAjI6oqGdUSTgU8wbV1dUshar85s/1oqGFJbyLG5BQi+US2EeniGjPu+tgtcie4S9pP99P2MqqfKaJLRXwEvPuVWxfjU7yo3t/XBxZn/sIVuyo3Q2nekZtCJSggA4+8nAaStQ75XvLJ47LiNrW/ISIew5X4rhVnzbcJdPgQ/Fhqcg5t3g4zeLezPN+Z/4Y7JVOoAj4Lrt1VJFRJRlItv7IPJV8oU0cWYk6hGs0xzf7zl3mz0y1WZowWQVZzsbWRuyKvllkw5Fl5fUbWJte4JVU64QNdjg/1LGmyWQHI04+/cvl85UMX0xZHJXG7g7heHfEwNwB9zEHJ/MizJMnG987jwNj8LikD2h6hFL1WiX/9YDG21fvYVkOrEvh1plW9otYVTndVXPNXrTVZ1BMSo6xaBE4jVFfXbUa5Emc+F7E34zOsT9
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2972.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nQ6/L1IfEJji2IAnKZFVAWylEs8Z0Q5+712mmLuM6zQbNU0/2h2FRruNN16a?=
 =?us-ascii?Q?f4eQezOnWntbf+G28IceT2fpViH4Oq8KMamcaGgkM6iucn5m11A4Bi3+sF8M?=
 =?us-ascii?Q?iIhxNgbcHN5UF/F7OauzgeLb9icXohjiY3IYDuGbtqoViNnW1K9HHJ+k+t1W?=
 =?us-ascii?Q?dc/EqiUKvgNQ8G7erarT6Hbot39dbcZ/R+7s7SUKjK8FEbVROlhQTJKXcOMk?=
 =?us-ascii?Q?La4Cu0TJvIgxeNikZ+I4wX/TD7B74FIYz3Gd+XGyf+niFDGIIPgk9PtWtZwW?=
 =?us-ascii?Q?loa7mQfhZeA5a8nc7CQiFZcYNijbm4KDL/eTDknaGhZQgC8/6eere6bO9SXN?=
 =?us-ascii?Q?raM+7owOQ2nShZhLr5G4ahIziTB7BRZRmkUyHRKU42boHUmbQlsL67HpVvoC?=
 =?us-ascii?Q?RP70sG52cBqbJoaqL1CwYx6c0hEVKCQCYalLtiGbT+f3XwVaLTauVo6q/Zsq?=
 =?us-ascii?Q?JSmMvvx4BEM/K/kqns3vkFcNg/Sg0vAIVHfjPCAo7PgISCwrHbYMTlen2Dtt?=
 =?us-ascii?Q?plZJkL6lF7oI3n2Gr2WXxCaeUrUkgDvjYRbcdNUbzhkJhxCi3cmIkxVdOpTG?=
 =?us-ascii?Q?2y6BLbsKL7UzDCvRD/EKOuBoWFCW5Zy5ua4E5yvAafsN8/BS5FDHBUW0g+zo?=
 =?us-ascii?Q?gyX+2ZvRUDwbELkA1g0InMtnB4UbTYsQirjcrJ0/rH08HKHG2QaFzVKNCsvj?=
 =?us-ascii?Q?zrqBEQcYlZka/hIMTttDqvfg6qhVEWFDwqSHoMsOXj9Bru09lMVGs+IOs8Sm?=
 =?us-ascii?Q?9ReRGap58dQw0prIiTVmWRvZSSsADR2Pn65jVq5yUA0TZZn4rLW+/y+ISECU?=
 =?us-ascii?Q?xkyCtbaPUNY9BNGkmzmJOjQUVPtRwy/4ht22fK+U3kUxS9WKdSzwqdo73pBp?=
 =?us-ascii?Q?4e5cs0mBfZ/S54HbmmUuxj7g7gsr1uv79LW2lPcaeWPjKIZR6vfbbgHOGOTd?=
 =?us-ascii?Q?JMTPYHEy37tF434HhTmykFjTTfhmhSetVgcD3sZmfsMw3TiAejEfC0a9655E?=
 =?us-ascii?Q?Xsh8tY2gPI5ZcH+9w2cy7LdO5DPVAfjNHuE0E2dm7awavK54KyGJwEmTJHnX?=
 =?us-ascii?Q?xs9Clb3aGKdtO7vBBI438AcVWPxBiVw9cWGycflxJCjOZ3hM1x/swRqnInx1?=
 =?us-ascii?Q?wwi62am6eOBHgBfpfvR3C6FGI7fB7eTg23rAU5yGk7neH5NMr+hHUbHjxdc3?=
 =?us-ascii?Q?+V+yG3t+AD2kPFvqzaSpku+NyhcrgLUA62z6SMnINVOTFcYKZ7HBBpnaQVw/?=
 =?us-ascii?Q?k/m1yzrfiSOb2ajy8XbDmlgLAX0lHvAiMAChXa0uVNsx360uXISlSxMuk2Tz?=
 =?us-ascii?Q?PjxTG5flzTWEgLSq7hGACXQisWbqL8OOgeDEfAoT8L2O7lZahMbof27XZoF4?=
 =?us-ascii?Q?WDT7z85oSQVO/pJsKyPiCWeW4swBaAetSb9OXJXsfP5wbM8ZhlMPzOTrIanS?=
 =?us-ascii?Q?PmyR2wQFeuJdgTbn5wAeJWHLzhqB9KWTWarxRbozwXA5fHidWuQtZK6bPwW4?=
 =?us-ascii?Q?T3FdZoSTlPRG36kmJr77y15Gp7o13c9/ErxNCAf4Wkh9kYpNqx3Nh6bs3Scq?=
 =?us-ascii?Q?mLSWS4y7KJrML+o9+hHhe7ifoJhC2GIZFhXtnzb4yEA1keNkSzgGu1spAHnc?=
 =?us-ascii?Q?G5DgjSFILJIxAbetDBfdXQhtgKL0HyKhY0MNcpi5VxuWJzrlZv4vdDNxrPGf?=
 =?us-ascii?Q?o2u8mC3hjQRp5xkPSFKpgvJqB77ufCVu2clwu71q1/5fFUAC?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2972.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6f69e3e-8c8c-484d-69d7-08dec1153e94
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2026 02:10:12.1366 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mCJ89GCHvP7PRtYvPqe4WA6ZbLPAGUDTl339oYIJMs53wPRdGbvJdjWXtewjdLWl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7204
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

AMD General

Series is
Reviewed-by: Yang Wang <kevinyang.wang@amd.com>

Best Regards,
Kevin

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> Candice Li
> Sent: Wednesday, June 3, 2026 10:06 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao
> <Tao.Zhou1@amd.com>; Xie, Patrick <Gangliang.Xie@amd.com>; Li, Candice
> <Candice.Li@amd.com>
> Subject: [PATCH 2/2] drm/amd/pm: sleep on PMFW EEPROM busy in bad
> page count query
>
> Use usleep_range() instead of mdelay() to matche the behavior of
> ras_fw_get_badpage_count() in rascore path.
>
> Signed-off-by: Candice Li <candice.li@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
> index 7193e3e4946ac6..12b57a0f4fc48f 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
> @@ -1042,7 +1042,7 @@ static int smu_v13_0_12_get_badpage_count(struct
> amdgpu_device *adev, uint32_t *
>               /* eeprom is not ready */
>               if (ret !=3D -EBUSY)
>                       return ret;
> -             mdelay(10);
> +             usleep_range(10000, 15000);
>               now =3D (uint64_t)ktime_to_ms(ktime_get());
>       } while (now < end);
>
> --
> 2.25.1

