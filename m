Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA83BC5AE59
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Jun 2025 03:18:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 512ED10E255;
	Wed,  4 Jun 2025 03:18:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wvAz6icS";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2055.outbound.protection.outlook.com [40.107.244.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2380610E255
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Jun 2025 03:18:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I6YcKevmBi0MpL+AWV5ngid8yLV65K830DbdPYRwLsUs9A6VMbTrHtBlD26ytleTICms30NonIXw8nwG0osjXPyfyHZDcqC8QuBFX/hWAUwDx3Fg0et1LaX4agtmPLO2sibyZxtVBoXw2rZxP1c2p98fTyLOe4KQkg1QUIeWcQ7/a3q01FW1RigQWt0lxBdQIlnKRebFlwcgzDQ84q92mvu8g5CB66fqFztfwhHGLoCzCbUtU5762P12at7p/4krY/ylH1AKwjIrET3gT68DvYIbWAPXEyfC7tD+XbwK6ySKzWIUdfBvyE7C6pzWno28ndwsRYGhSlfm2CpL2QEHqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h8mAm3633gew4zxj6C6Sm6PXoeG+T99wXXj6wiW9paM=;
 b=h+eJ7G9MYRWyHRaVXYtonNcSIDGDk5CKXT2JbjpRJOVo7s1y59KEUUtgFg+BA/YC8xjhsCjxfOC0pW17Tu6JHWR2jD3a2+Uu3UTbmYnHnsO/EN6V9r4Lo0L0bhtuPk1aTywaVtTIpkwl3l2pSrae/idlZVwA6mKnwlxxbgHydM2C5CzS+RjeXLMFY+cl8EI7Q0QRMOAd52W7xO0XTKblhVg+9A2AwQEn65NzLcT1Ry0qkYhCIGz4IAjXA/OkCWXLOtEXl8y69QdgHw9KY13K1tNY+QsVF7pbBpo6W//pLKcEshFQujxPrc195FejXydatWcg8D/PZqIWvmQdVPwjxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h8mAm3633gew4zxj6C6Sm6PXoeG+T99wXXj6wiW9paM=;
 b=wvAz6icSNBJ1EiTbLN2q95UhX8BM20e42U6j1fX+0bZKDKVjB60BgQUL3RdlvWnfqC/3XqqpbmdR5l8HNiqkKeF+HhrMvwm0SKjn5CqvTEFvLT6yeWgmJEXGVi002fNxUIikIzJHiOud65STJAUEOflCYcwKLYJ1W7UxE1YyR8U=
Received: from PH0PR12MB5417.namprd12.prod.outlook.com (2603:10b6:510:e1::10)
 by IA1PR12MB8239.namprd12.prod.outlook.com (2603:10b6:208:3f7::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.26; Wed, 4 Jun
 2025 03:17:58 +0000
Received: from PH0PR12MB5417.namprd12.prod.outlook.com
 ([fe80::de07:ec43:e847:2f50]) by PH0PR12MB5417.namprd12.prod.outlook.com
 ([fe80::de07:ec43:e847:2f50%5]) with mapi id 15.20.8792.034; Wed, 4 Jun 2025
 03:17:58 +0000
From: "Deng, Emily" <Emily.Deng@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>
CC: "Deng, Emily" <Emily.Deng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhang, Owen(SRDC)" <Owen.Zhang2@amd.com>
Subject: RE: [PATCH v3] drm/ttm: Should to return the evict error
Thread-Topic: [PATCH v3] drm/ttm: Should to return the evict error
Thread-Index: AQHb1GeUw+TQzqRSkEGmkhjXDJoXqrPyVZPw
Date: Wed, 4 Jun 2025 03:17:58 +0000
Message-ID: <PH0PR12MB5417A5CB2A9BA2B284D7CF498F6CA@PH0PR12MB5417.namprd12.prod.outlook.com>
References: <20250603091154.3472646-1-Emily.Deng@amd.com>
In-Reply-To: <20250603091154.3472646-1-Emily.Deng@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=b418d4bc-e8a0-4565-8352-e6cb38cf8990;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-06-04T03:17:24Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5417:EE_|IA1PR12MB8239:EE_
x-ms-office365-filtering-correlation-id: 3ed2c001-4068-4e20-7773-08dda31667e7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?lnm6VOHW1cB84I1u6AgUuFEiKjt5jVLP1UeeyKyBoJ0WMkofcy6yKC1OoSho?=
 =?us-ascii?Q?nX+7//QvlhcgsLufIkFktp8n7fGI54AMy8ZvsiUhgsDmp+w6Ve3OwLwyaZN2?=
 =?us-ascii?Q?ZmRoDkxaAV7fPeiWrTqDzdqu/TbUVV3KVenFRlU/NAYflm1cYpqqPvNGSv1i?=
 =?us-ascii?Q?rp3Sfb4/Ex06ze1CWmEGZwxKkEdweoCgcjQ4kLnTohVdAecN7MjMjENxEwMg?=
 =?us-ascii?Q?4Q1w36USCPFgyGAt2aBMLNElk4sv8wFjhfjOUiNS8QhvCw3F1ZQW/8RtL/6y?=
 =?us-ascii?Q?0gwZM1WwdBjLstnl9zcZAhkaAkbnMeTXuKsMMMzZJ3FGwWOppuwIKwOz6baC?=
 =?us-ascii?Q?3q8tsZL6vd+MOoLBD3lTeKFzKv8bEKB+icAu3R7gO7Uazjfg/Yxa4XAVnxJB?=
 =?us-ascii?Q?hNJBVD8rDQ8vfWW4Tl5+WXDI07amgdWlpoEz6XMeKbIlJQA/4TD4CW21rHRh?=
 =?us-ascii?Q?qC2Je2oRVxfns+CdXmtU64S0nxpE33QhkiqSfctImbOOfvKz/wMgjSyIK89C?=
 =?us-ascii?Q?QQDNp+mXG7lkw2lzm83ZUH457DdGmgFdddhSwiwNY5kJ0h7qH9kOGzP7SV80?=
 =?us-ascii?Q?tkNPnqHnbJq8QArb7jSmhlPCvpgy5hdti9FPniR3a5J62MxQTa8C27A+6yP2?=
 =?us-ascii?Q?oPxuQCS2NQqBoPBT7+3Qmh5Homb5p5eQ8yF/8R4RSuuk9dIC64eyHcm7vYym?=
 =?us-ascii?Q?k1i51RRzNDBbWfPz/3JwmTPgO827SEsGdX6EfUJoy4NtO4UkkCTB5BOOrrBF?=
 =?us-ascii?Q?99yOxBQNstae+cdzQR6vTjmsU2biSY1hYq0+y4JS0l0jBnepgByaVfJTg1VH?=
 =?us-ascii?Q?o1EvVJEh3uYmiK8WsMJ9FtzHfJ2vx/c8DNSW0NIgIgqegpZVNV4zzdErjf6l?=
 =?us-ascii?Q?NIpqVVnzT3+zIORPRZ3AxLaX4TpSwyVGXjPA/doD6OWNkZeH2dmSoqCW1FTb?=
 =?us-ascii?Q?qzyWbJ+b8hOhAp0fyq2jKllaY04S9PUGFK0IlIoVBFTyw8whHcYSrjM8wdqs?=
 =?us-ascii?Q?2UGgvxaj4ZaU0otcMbA3hhgO6fkcBemnlZdJhptKX4p9xc+O4s/QRAjALphT?=
 =?us-ascii?Q?m9LFrv+B3ZVVh1rVbPFd+cUKrsEBQ8PFT1Kd2kDYuI5p+ykf264lVP8JfCy4?=
 =?us-ascii?Q?DXqz7MJqOKp1VVEAiSWIZrXPy79IUXHZzPJwfb+xO0PEv0/7H2cGPN/qIT0S?=
 =?us-ascii?Q?FuPNlt2R1MF0yDucDDDD2RKALXv6GB2VJrrzp0Lmq33PvKATxq4+Qzcd63QL?=
 =?us-ascii?Q?KhBPTMLdZpDTtMYNjOBEoLoyWC1KSWC9upizkBdnyREMAVz7Yq0YWG6Vn6Cj?=
 =?us-ascii?Q?Qfb5TJDLFjKQWJHg9MlzD5NdW+N6yDz4ElQAWeh7xIaoQTSB/Z1DSQHLPn3b?=
 =?us-ascii?Q?R8P+nsxHUwXtpGbRsrvnzwf+r8CV3FuxyH6bll9p/1cImvkKeyYMQGRJDOPp?=
 =?us-ascii?Q?1xe2znft+EBdLqHOiHBPyrCy7/Oy4G3Ye6Pu3JDOzaRXtWHMQQFd3FXmp9CC?=
 =?us-ascii?Q?IGew4VFy1FtClEA=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5417.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KXg67ssprO73X5pgYm9XB2zXoLb11BW5vr6swSGVJIsc1P2HGFt3vJ3rwlqk?=
 =?us-ascii?Q?MlE6PN+h9d5sCXSTOvaGrY27GtrtKOg3ZIoqi1VwpG/aO7twiO7d9OEC8nlK?=
 =?us-ascii?Q?XzbeG51Jp1fEaIOzGXrZyOGzTi0HduYVn2SJW+cFZomYxOLPTWqbnznIuvjp?=
 =?us-ascii?Q?nQx72e+TB7PloXuu/hp3ZcTp/RxBt88FC+cBstfulPugiU65Hjn9d3+28Jw2?=
 =?us-ascii?Q?RPUbLUNXIC3UtnSjGmI1alTJUYnxgU9xZwG5rW5YuoTWLLiCF09JhnxFhV3U?=
 =?us-ascii?Q?V/oAxce4P+llSqCKv3WWAV+drFx0Mmy3l/qmslYnLVCQqpjNgzGw0wE4WmsT?=
 =?us-ascii?Q?j2CwaxiqnkVhUZ7kLM2cEUlks/akOCzwViQP1Kq73+i/9uyPnCENnUtrNdAX?=
 =?us-ascii?Q?jub0DfGXj8IdXm68kAU28HZRvNJ63eDkNfU54oNRlLFMJgCktxXwUNsDmYpC?=
 =?us-ascii?Q?Umv5KuCF9I4+TMOnxPKYysspLMedBXJrZmvtj/qJ0aEwmn4v7Gq61Zlis2/q?=
 =?us-ascii?Q?Wqa+IKPsXRFKoq1XTvHCfpq8Mfs3QJP5MzjEi7V8Cg6Mlb3D3BiPYszMu79b?=
 =?us-ascii?Q?xzA2RaHFiSNsp1nBKvQOvxh+aA+gtk7Day2rkPRrJjy5obivOQdrkMim81uk?=
 =?us-ascii?Q?aqBf2320Zxm2h43lJR/KKHdo3M1vkh/S6IaEYdiWDurWhdlVe43UsDRNzoMb?=
 =?us-ascii?Q?9gZLTh/E/jAi7/m/uw8GcsH1funTQDkuJkNMEo9xzWPe7J3MHIYVLJgkB1Db?=
 =?us-ascii?Q?EAwe35VLHeNdzZG6sr/1IkvP7/vo/+9vtklpCVdiWMADdx5n4G4iLLas5slw?=
 =?us-ascii?Q?qJzaqS3WpsEVO0soQpBvZrAd0YjsKdUVKCxGRBtmizzWH5Wx8TWIMFYgw7GI?=
 =?us-ascii?Q?1FkM4JSoq4MxdviIPkm5XG4JD6jwhZiMUG3bYHeEqaeOPbbXEaNRTbJCw4EF?=
 =?us-ascii?Q?RiYuAFQdO6U4vI+EFAg1Zoca18d0Q4ul6xdOgvmJdEniPR1/u6bvvoDQ7bAY?=
 =?us-ascii?Q?nAmRiVtnUJO9T23sBGaZylnbv1GNRVb21dKsY4SD1mv8VJLOo1Ndm16pO3sG?=
 =?us-ascii?Q?fiODiydQcyt+lJYdL57ytRTcQ1yR0NVy+ysT+zIo4oOwC1ajwF1zPKcAQ7PN?=
 =?us-ascii?Q?Pw/wkPxw2i2Csp04oBlsnX7hMNixONCXwCzzu+L6MiwqUdA1Dpmx7dh13sjR?=
 =?us-ascii?Q?CgqnEWFpSNOyrwRUfjn+CfH6N4142vgzJZFvVYPdl7elmsUrUhJu5IQ1AwaL?=
 =?us-ascii?Q?4vWF6V2hY7D8NyPw5qhe0nf1NreVdCY/XaUfcUNoGbDnG4p1y+ys0QU7E1DA?=
 =?us-ascii?Q?lDNzAhQNue3lm/txk7Z25AtZV/UBkaFJ3awwBvOupImMp03bjCudo7ypV7Ed?=
 =?us-ascii?Q?0rYsx55hNvQdYk/nyIFWZCotGjQNYhkWJy8Euwcp434y0Ce6oynVxtckKau8?=
 =?us-ascii?Q?aPUU9/koGmCGTOC1e7rKFsp4MjKp0xU8jI2sHMSUGy2J9qEi0HiO+cAjkRwD?=
 =?us-ascii?Q?wYMwUeN1uaJlupX5PlRG8aq+0JRM3iAAlp9ygqD0o+biDNhWAlDje20qoolw?=
 =?us-ascii?Q?FupMOzH+W52WgmjVzpU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5417.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ed2c001-4068-4e20-7773-08dda31667e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2025 03:17:58.3767 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zjwNK3T2aNBrfK6caQhZ3/P4IbnjlIKKrb0f0nqmNs5YINAuAiC1/wKkcGOL6zlA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8239
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

Hi Christian,
     Could you help to review again?

Emily Deng
Best Wishes



>-----Original Message-----
>From: Emily Deng <Emily.Deng@amd.com>
>Sent: Tuesday, June 3, 2025 5:12 PM
>To: amd-gfx@lists.freedesktop.org
>Cc: Deng, Emily <Emily.Deng@amd.com>
>Subject: [PATCH v3] drm/ttm: Should to return the evict error
>
>For the evict fail case, the evict error should be returned.
>
>v2: Consider ENOENT case.
>
>v3: Abort directly when the eviction failed for some reason (except for -E=
NOENT)  and
>not wait for the move to finish
>
>Signed-off-by: Emily Deng <Emily.Deng@amd.com>
>---
> drivers/gpu/drm/ttm/ttm_resource.c | 3 +++
> 1 file changed, 3 insertions(+)
>
>diff --git a/drivers/gpu/drm/ttm/ttm_resource.c b/drivers/gpu/drm/ttm/ttm_=
resource.c
>index 7e5a60c55813..bb84528276cd 100644
>--- a/drivers/gpu/drm/ttm/ttm_resource.c
>+++ b/drivers/gpu/drm/ttm/ttm_resource.c
>@@ -558,6 +558,9 @@ int ttm_resource_manager_evict_all(struct ttm_device *=
bdev,
>               cond_resched();
>       } while (!ret);
>
>+      if (ret && ret !=3D -ENOENT)
>+              return ret;
>+
>       spin_lock(&man->move_lock);
>       fence =3D dma_fence_get(man->move);
>       spin_unlock(&man->move_lock);
>--
>2.34.1

