Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 547ECCD3442
	for <amd-gfx@archiver.kernel.org>; Thu,  7 May 2026 09:57:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E6D5110F014;
	Thu,  7 May 2026 09:57:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BMb7iP47";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012013.outbound.protection.outlook.com [52.101.53.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1DDD010F0A9
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 May 2026 09:57:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qG3hLxGplFA+w/3XX0/Zo9kOMJSIKrVuq4q6kJjqz8HnyMR544TUUAPAuU6ZGKSOaol9peXXTR+RVWFjyvWYhrpf2yTGuDkPLhaLTlWsRiYChx1gJkYGMM4HNeuqCLeAsFGboVpPVhQQaKS0CIjWXB4fQCwTitWZq3n3nS7hC1LpJRcnYfrnQBqFdDBoYq84TbpV3Acj9ZaJtOgMtrq5OMe08cX/JYU169AlP++Ja3uzFABcYR7cK5vf8K7OTTr/Btcadu8bdHFquJYLHEh39Gksty1bZhvrS4dxtaS6pTROHgMfAz5zjsFmwtzf1r+F+KZbvmvEUKD8wW0XQxegAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mhV2ZxrEJEDJfj9H8lSQkKy+bKsvVFTbNvrmg5T8a0k=;
 b=VyaRnuatHbBXK08r9vVkxaKmW8YlfdFnJkFeQbJw+61OnUpqXFTWtX8lMLlEYJKCsSQiGCQciySL8/7Zf1xO7OvL8m6LpRdKIPZFoP7m/vkDdClTrbDtWjf/KtwoAVZrkbzOzz0dwIja0IFD2ZXj+mONck1GjZEsP9vOA7UaHETccLLhLY+cdhKJzG33k1MrqfoF/JR8JokLO7AnvgbHA8GL9hqg3eUjlxjQEXy1fD/dmKReOA++MtnDRSPCIrzlWke57oJpBpxPO5xeO9xfIKjKqKJpdX6m9T3xMZJ2rrZQ+Q6fK5BvQzv1RzY7LysZDXCOCKxkyGk/1X+AaYPysw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mhV2ZxrEJEDJfj9H8lSQkKy+bKsvVFTbNvrmg5T8a0k=;
 b=BMb7iP479TkZV7CrOME7Y/Gj+BcZTyJI4rTLWt4h7G8rBn+uX163OvIBkxSsIlU1O0RH7SKPUbjHXWFEPmgtiLMcNC4Xt3BoXtLtkE0GmGAyHE5jxGAZVpL89VBpW5ou/4DreTqJ5QgUZ6q0kj1FKVaKwtsOCMf0cI4ORBahR2E=
Received: from DS7PR12MB6071.namprd12.prod.outlook.com (2603:10b6:8:9d::11) by
 SA1PR12MB6680.namprd12.prod.outlook.com (2603:10b6:806:253::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Thu, 7 May
 2026 09:57:44 +0000
Received: from DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::6f14:4646:fb11:829]) by DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::6f14:4646:fb11:829%3]) with mapi id 15.20.9891.015; Thu, 7 May 2026
 09:57:44 +0000
From: "Kamal, Asad" <Asad.Kamal@amd.com>
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>, "Xiao, Jack" <Jack.Xiao@amd.com>
Subject: RE: [PATCH] drm/amdgpu: fix error return code in mes_v12_1_map_test_bo
Thread-Topic: [PATCH] drm/amdgpu: fix error return code in
 mes_v12_1_map_test_bo
Thread-Index: AQHc3flSE/1CWuv/VUGlmR8kXdR77LYCU+lQ
Date: Thu, 7 May 2026 09:57:44 +0000
Message-ID: <DS7PR12MB6071C70326EA8B7C2EA2790D8E3C2@DS7PR12MB6071.namprd12.prod.outlook.com>
References: <20260507081232.1133522-1-kevinyang.wang@amd.com>
In-Reply-To: <20260507081232.1133522-1-kevinyang.wang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-05-07T09:57:35.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6071:EE_|SA1PR12MB6680:EE_
x-ms-office365-filtering-correlation-id: 9f54a307-ddb3-4964-bf13-08deac1f15c2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info: iSN9+4wgye+8G5ZP5LSLBf14vKOWGYTAZFsQyn7/ESgLXZPT08iaQQAnsYW7PduxK3vPmYatwoOgsRq9AOrM/SlmIlLszUOKkcGwfNmk/JL+Z35fWHEwFhn884UPm+Kj0IQnigcTWDNuW7a96iDop0nyUuNqPg62eioeCUdRgJGwM5W4tLffxeS1iVsp5bc5kM5RIsIJFYJPalinKAB3+viA/GSDHFZhcLxEYDcMUIbroYdz9oYXLBVyyt5as/NaPpAAEEYH7IVWCdshgoZ9p+RX8b7AdFOXNXRYNEJefs7pjpF1LVtDFk9ZBnN7qit3UwRqJDHn/osYd91FyvbO6DByp4EKDfekhf/7dy4+Qkwr+OuZS744/Ycb0Fzcnbka26QTWDvwNeAa4XgI9gBPrn8HFxVX4wq6OiJOx7CEE1WXjXqXOV5q8PoHxcGMO/kUTPcAEeLyoliuTtC//jDLc8BMEX/KSDvDr1DyN38vgsMP+V0hhxJFm1alrMy+vcC0js2ZzMWmJt6J18JEaUYNiGjRem3EvQbkUxOfIvIJa7oIkOAKJnEKnAtBGC1GOGcnZn0bf4e5D+zYvirbPQgbIsC3DrBSNhwgqBuOmLIhWebDF4wq8v7a1N3Uqr/l7OAjZTIgwrczgc31zwGXCQYecJpYFWGt9923eRlfVgsrhtitMMCQa1KFG0j1HjBfG1zvJINw2bRdQ9ynsX6XlT5O/DGhYn+v5fXpP7Rcp7Cdd0fm/BVC3H6wM5AtlmTIQ3yj
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6071.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gz8He9d3pGVqDWKJLk1c1Tw3j8cg/A4SAgFIRySDfyzng+slCdCWYvUVDqD5?=
 =?us-ascii?Q?DDgPH1DnsFr0uwmWkmTYd5R1rHa4GTz89fvZH5Mq5T1DM1WsIHYpRohYwnEr?=
 =?us-ascii?Q?nV77thOU/Ln7isTDlSWsnEoKQtEXBYQ6HlUHe2XrxG+E4jwwmA3bR04xL7er?=
 =?us-ascii?Q?3T1N1Z8bQYpDT8Ykjv9KTG59FlcVVUMFRgzJVJ3V9otdi7W2R4Hb1t2B9kgi?=
 =?us-ascii?Q?faoKA8gSITxHIJVxsf7PnPu8q3NWn0YGNOqMSnLvhYgMvW2frQu6o1y1XgHD?=
 =?us-ascii?Q?CPpman3uW4PhyoVl035FKXMSKCL782Mc+TrNG1J4dawQNNz+HGt2ozpKRmCs?=
 =?us-ascii?Q?i18JR1ziWM+mXr0CBfeJZssuQQuA7N0pFhC8wQFWsK+eFfxMRMOLgogklyyW?=
 =?us-ascii?Q?c258uEElB/AWURXt5Yco9Raipi5VeEtK5bdS7QU0r1Zri88weHtPu7+Qub83?=
 =?us-ascii?Q?pIalMgBVYvFtmfQIuVECC3e/M21IDVOpHhK7CGirUiK/FZaVwdUF9PDLZx5o?=
 =?us-ascii?Q?KQGiYjQcE4V3LenibNY9jdk+MsCyzJgRFK/3EurE8xfRzz3/ZQ7T1fNcBnce?=
 =?us-ascii?Q?FZJu6fxC9IZpICSIbO/s3ynNJAnISFCYz9oOOkMrIa5uBTmtvgtKNhL6UjKz?=
 =?us-ascii?Q?kY0j0VSLH3E74k54ludQuGsWklVDdmHxIJFmo+NmopHAdgnCNmvnV6R9s035?=
 =?us-ascii?Q?B0kw1TekkBpMViHJFyaZk0DkRoaQa5KxrD4hjZy1HDJNx0PJXTkmGCvPbNNl?=
 =?us-ascii?Q?MJQR6AhxJnMPs6ix7QZZ3fAIMDFP5bqgyfrD3qwX5LQW/jMcIvpCs2sEcXB9?=
 =?us-ascii?Q?Wr48DN3mHoOp4Nn3GsCmg/vG4yk20CyXnk123iIabJuHWSKlzGYAZBBwYT57?=
 =?us-ascii?Q?oo+yi41qOhZf40EGbv8e/7nVUf9/yNYorX89UXufFq4A3po4a8Da1uFX12uL?=
 =?us-ascii?Q?t/CFJbibFghVvxy8D3H+2Ise7kt3FTm+zkp4JDiBTWOihuQi4VPlUC+tp/u6?=
 =?us-ascii?Q?3b/tgbFs9JsJ2G6y5+Jps3zEnXug2JiONvWrb42rKSXwpnBBilfzGbubcJil?=
 =?us-ascii?Q?gAbDQJStTPYioP8makad3Pw2H29MWRsowW4tJpUkSKI6SD8WdKTDGeQ1c8X3?=
 =?us-ascii?Q?JpTgm/sNz5iiqVsiZuRTlYAvLOdxQNdZaq0bADx6s5B3DeCxJ6hg1NJ72y+F?=
 =?us-ascii?Q?KfmqNhvGMaI09BQ6+AiKjiN40+f8U+QxjpbzOZMmKhcxoCywiCr2p2bZPjdR?=
 =?us-ascii?Q?a2LMdqx23aOwdpDRGQaO2ZDjmQ6H12jilm0L+urPnrQx5OCGXxN1ZxeYyzn0?=
 =?us-ascii?Q?qUiiJ3119vgLOQfdQo8bSqhTUAoWAb31hnt6CJmzLV+SySdOBxrvoP+Lb28c?=
 =?us-ascii?Q?eIWVD9zpwqGBClKmwPqfqxv/Gv2DnjeE93Fx7hKiXAA9RxMvkHtYuIZ9sS/e?=
 =?us-ascii?Q?9VILeOmq9MIj1eQ4djm0o5mUqe4GeSXMzDIqsa1NsV6ugA0f1tUzuSpvfapr?=
 =?us-ascii?Q?aD9WP97VnWWfcGqj1opMZcNBgsndMVfc9WtmYhz0VBLXRSW4f/EovrPInSyF?=
 =?us-ascii?Q?fdRsdr6jDKPMrJhfGj6Jb6aJObLBJiFw4NnPDFmti3IIsdW1f4M85dMpeydu?=
 =?us-ascii?Q?HL4q9WjhWl9tApF8+c5n20bccIsDKf4k1ql9EGp0OjQqZCvIO1/gp4QzQLQZ?=
 =?us-ascii?Q?f95W/j3vjZdw6qWwFx2As+g33fOiGNYeEnYKWs0FNqrQ0XXN?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6071.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f54a307-ddb3-4964-bf13-08deac1f15c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2026 09:57:44.2010 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Nl6YTrfbYeuzPFitBzaGNvpYGCRBOZQmU8Tzz9KpuzaqJ+aSJ3a9QrB/W+1COxt2k68jAfVldRGKLLpCv0mSlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6680
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

Reviewed-by: Asad Kamal <asad.kamal@amd.com>

Thanks & Regards
Asad

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Yang Wan=
g
Sent: Thursday, May 7, 2026 1:43 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking <Hawking=
.Zhang@amd.com>; Xiao, Jack <Jack.Xiao@amd.com>
Subject: [PATCH] drm/amdgpu: fix error return code in mes_v12_1_map_test_bo

The function mes_v12_1_map_test_bo incorrectly returned 0 unconditionallyon=
 error path, which would hide the real error code and mislead upperlayers a=
bout the failure status.
Fix it by returning the correct error code 'r' instead of 0.

Fixes: 5ba87c3e9e4b ("drm/amdgpu/mes_v12_1: add mes self test");

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v12_1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c b/drivers/gpu/drm/amd/a=
mdgpu/mes_v12_1.c
index 1931562ea6b3..4217b3fea0f3 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
@@ -2063,7 +2063,7 @@ static int mes_v12_1_map_test_bo(struct amdgpu_device=
 *adev,

 error:
        amdgpu_sync_free(&sync);
-       return 0;
+       return r;
 }

 static int mes_v12_1_test_ring(struct amdgpu_device *adev, int xcc_id,
--
2.47.3

