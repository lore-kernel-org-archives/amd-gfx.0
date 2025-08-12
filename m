Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55F9BCA0EC4
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Aug 2025 08:34:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE36910E5BC;
	Tue, 12 Aug 2025 08:34:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cyztw8dS";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2047.outbound.protection.outlook.com [40.107.93.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2059610E5C2
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Aug 2025 08:34:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DG4OmKF3pPYVfbjUhkorSvxS1GEfn1J7yubSqnwQKiOhSXU4+yD/pdeTCP6AfA3nGmN3m9xQPdozvgC3HTx79JGJGwPlfc74eO9whhw96XShQp+KFyc1YtwCl1DownDX27EP3EhpOdm8wdzr5+GLSnJGW00MOMxaucGiL/aKEq+zdB98KXG1IT92Xhby10shqvFI2HO7+jqSArPCv7ew1vNMgso4U9kAJE3KpB0ytuFnHAspqmRfYLajJBFT9iPQVn4ncilztiZp9YZxhj1p3a/Az083CKsE8aBJOxlxGuvaGyYnm9si5HpJ9ojTmvQQRgWFGZvX+4UW/Mit69746A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6RNH6RF7SZv7y2O1s4qC6SbnAuSloDSKxViSLk+mfno=;
 b=yJewKTZZiIxfmeQxv0ikehl2MSNKMY8D3GoHjJkIzS3n7ka5zdjhzumeqw3RC9eolDNzNmNg2vkWK35uIDtZg771AL+kFC4C87obVVLL54YcmXY+e4ojhtJrzU12iJbnPe06/RhhTlP0IqUPk9Fayz//RgNb93nYa4KL9hfgUJRJSItIsEdnDTa+jS2CYZDQfNKYeehLntFUKyGpJWEET1gwSXRvW9bSEzp2zrk0JV3EwnY4M+IYm+72gel/2ImG5Ne/rC3qD0n4Z8AcpWSBahtyNNrsW2zzr3UHDcUb7jrjANUpEfD/lRllzzSUTT/g1Z/ee+UTVvLYkC0gAxxLCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6RNH6RF7SZv7y2O1s4qC6SbnAuSloDSKxViSLk+mfno=;
 b=cyztw8dScy6QK0cbx0jXSfayVq0W39RNfCeKbwjIt26ndQNhti1lCxOnDlb9t6BkiZiGnOY/kJTYLNbxQR32Glj0CnfDp6/yd2hvBQRJOekV7iv2kA12qivlSwKQDvzosrQGdoUW0Moo7h1Fb8ouH0Eh6ME7lNT3KzQpw27b7js=
Received: from CH2PR12MB4215.namprd12.prod.outlook.com (2603:10b6:610:ab::24)
 by DS0PR12MB7704.namprd12.prod.outlook.com (2603:10b6:8:138::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.14; Tue, 12 Aug
 2025 08:33:57 +0000
Received: from CH2PR12MB4215.namprd12.prod.outlook.com
 ([fe80::b053:488f:853d:892a]) by CH2PR12MB4215.namprd12.prod.outlook.com
 ([fe80::b053:488f:853d:892a%5]) with mapi id 15.20.9009.013; Tue, 12 Aug 2025
 08:33:57 +0000
From: "Chai, Thomas" <YiPeng.Chai@amd.com>
To: "Sun, Ce(Overlord)" <Ce.Sun@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Yang, Stanley" <Stanley.Yang@amd.com>, 
 "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Wang, Yang(Kevin)"
 <KevinYang.Wang@amd.com>
Subject: RE: [PATCH 3/3] drm/amdgpu: Correct the loss of aca bank reg info
Thread-Topic: [PATCH 3/3] drm/amdgpu: Correct the loss of aca bank reg info
Thread-Index: AQHcC1upErTJrNBa/UeNG9UE0Bcwt7RerrlA
Date: Tue, 12 Aug 2025 08:33:57 +0000
Message-ID: <CH2PR12MB42157554010D0EF4E81D4FA7FC2BA@CH2PR12MB4215.namprd12.prod.outlook.com>
References: <20250812073453.257913-1-cesun102@amd.com>
In-Reply-To: <20250812073453.257913-1-cesun102@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-08-12T08:25:54.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR12MB4215:EE_|DS0PR12MB7704:EE_
x-ms-office365-filtering-correlation-id: 3e76efe6-9518-497b-e0fd-08ddd97afada
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?Wmt5auR6/w9ju65Le6Zg9ZMT31hOf12dJu8tKABUOjgPMYNMcG/RDnzWjNa6?=
 =?us-ascii?Q?GTIPKLDcsE/0dQkTL1L6hxmsPg3nTuUVocwaXFOBRo9Ngn4Rciuaw80Khuk/?=
 =?us-ascii?Q?p2Tr1B5YfzOmWtB362toCLtC+LUI3EZj7vtQPMd8N6I1BTZD4OGNmCwfmtV1?=
 =?us-ascii?Q?d5ByS3w7vdNRksI+Nkfztt+Nrz4Ax0yqAGutDDL8QQcmTIBnTbuKDR915DLc?=
 =?us-ascii?Q?VVdyiHYHTrnsOxYxG3a96XfQWafuNqV+DPm7fFDaBMcNQ49DJpncyZe5C2ra?=
 =?us-ascii?Q?2aZR+b+qTZgenSRBITEbhfNSM8F2LuFFMVOZBrnd34oUVGAhvfzYCxJq2tYo?=
 =?us-ascii?Q?q2Rvr0GIQ/9KwZgFTPulw5Mtytrmw3fTqKN1BkBkha57C/UOAFPlgACh3S5M?=
 =?us-ascii?Q?PNWr93vepSiEE87wZIBM1TfE9DXAqU/dTBeAsOaoFh9PX6z/JjBGkEgNlzXs?=
 =?us-ascii?Q?3N1nYb9SXR/vL1K6Erxd19i6E2NGprNY+md303ZpuST8mNy2UvqJ7bRsMmEK?=
 =?us-ascii?Q?+Lj4ERBaYksRGiahJ5PKCYl1EN82ZQ7oH5231TnS7j46a49KHjrAOEO1XIm5?=
 =?us-ascii?Q?baST11BjjoI62zbOzTOxfiGZDpAuw/r5IgH2QnXUzwtSO0kFC1A0B9/UnDu6?=
 =?us-ascii?Q?y/8C8o+gmuHZzt/nGO4ue7cYb5kjLLQofBqvjMOWdojEA7/vpDyojOWDkB7r?=
 =?us-ascii?Q?wC5lU8SA7hSujqZQksLY4BCHqC9TZZoPsJXuLXFemOxIcWH7tFg42k7MQyb4?=
 =?us-ascii?Q?bDYbRFwbWZhbGs1FWwlTytzUUtpuO4k46HlM6c4EOXz8UPY0gj9fRJ4Ud5dK?=
 =?us-ascii?Q?sWMcqLgG74Jdzio+tdrUtRe76NTDtC2D4CK97OFCr4X4iXHehmRUhB6JWbSY?=
 =?us-ascii?Q?iHmtzt7xMsTUaWMdSOHUN9BWDOreG2B1sJl5lncLm0oU9wTRgIvhCJfBRwvY?=
 =?us-ascii?Q?PPZCnZyyBxqf710vypU3M7meqk5uR0gPfBdh8cdj2ll7fzP8zqntE96J/4wX?=
 =?us-ascii?Q?uoDGyLAMsnWwTncjCa3ugIm2n2ZvhWjuYEd1QtOb1/lS9whQjYu4qrc9gxzT?=
 =?us-ascii?Q?hoRO1GLn+c3nKGALtyXa9k+FDlSjb7S2ts/qIw3rXLghlGy+CkeoRTvPllzD?=
 =?us-ascii?Q?ZfypJvSTriWz4DsaFldRkXhgzGlOGXQNZGaTjlVYWBmKsyZW9/okYUtBEeDN?=
 =?us-ascii?Q?xRH6Y6hONww3Rgmek0RMCvKLL2SFuws54aQxZM+9b9mwL3DQPit6ni2Z7+s9?=
 =?us-ascii?Q?/uTtauvf3vdW/jp2tU1dDKnZDnJY1uqNJ08fmIP/crZ3mMKVsicXKAcS+Pi2?=
 =?us-ascii?Q?x8rKhQUDveSue8+9nS5TdPp9y1LomRMirw/zy3US7zZIXfKObsvz+LiYFZos?=
 =?us-ascii?Q?/wHiwKSycvur+zQm9wpZBNbG0/DWQAKr657zkeYaVGGpfdVFxUsI0c1aGor7?=
 =?us-ascii?Q?Xlw5it2heHxe+95ei2D0pjhgwrax38FJ7vUur47ao9fSt/OtFK+4uU6oNH91?=
 =?us-ascii?Q?2F5r05i85Ogq7BM=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4215.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5LcT24Xbs2VKVnzxF6kEpz3kOMlXOmao4DJ1B02CXYW0BQ2Gn2uQMNwqDBJ6?=
 =?us-ascii?Q?mAAFciEyVyPPKky/JcqXkMoLpDjiKPVp8N3S5GY6y4YqNIAlaKKbtEXo/h1F?=
 =?us-ascii?Q?NW0nSJUJ9Ov7TmTrrMWpR/WMQvfJeoT4KsNFu+wxYPTYCDB+rhA/jVWfZG7j?=
 =?us-ascii?Q?UI0BbmSyi4f96Ec0ZttjYyngoOlaDXcs9s2XitrxjBVIvSthf3bPAY0wfnwm?=
 =?us-ascii?Q?Qq6L1/R72gCRv8TdFAKjifD2E8APWvZcnGOT1SklxhuBEXIpGGpQtRpSq/Ix?=
 =?us-ascii?Q?3f9QyPTpgdJk4WnlnH97n0l2+I0xAUImEW0tnBvsMNRJFKXpnbG5vXT6uZSs?=
 =?us-ascii?Q?BKMLWyiJhcVWMI1wDePXuV2Ae/NGSFvvUG+SkInMwZ4e12PhfXk89I5YMDRu?=
 =?us-ascii?Q?vnvPRajEnpYa+tKeDaQEnp38EXdSWP6zMVBhlm57Ri7UO9HUAHgG4h9WKGCb?=
 =?us-ascii?Q?C0OhMZlN3yh5GXQSzDQFVR/8oQQRZLB1mMpFGcw8islegkgnjV4xdN1cGdSL?=
 =?us-ascii?Q?Mm14QjU70/mDYdIQr94yyymxRMxc4Tt/AWhLY2RnHzQjkr7uuls8pngOfsrk?=
 =?us-ascii?Q?IOKp/cynOLV4/PobpBrd/FWbLMz5rqY1KdrBGyzRAGC3+aRpVKo0XE2m1DQv?=
 =?us-ascii?Q?66G7A/UrqbD7/jCOQFy9889WS2q2xOzmqO5fSsSw1kHfwrdCy9MlYMREbGuD?=
 =?us-ascii?Q?j3Wd4yzs1fiUxq7bQ5tqB3OWXimn1RLxPxZfTkp5qPHW456tEByvn83lImTd?=
 =?us-ascii?Q?oMvF7bv0ujkaT3vCuRPlfwEV6ofajSK8wkUqHJD5ebc/K9emCFLzsVGw48/8?=
 =?us-ascii?Q?qhPWyjDGWbre9wducB0OkWZKN2q465TCwsjfMBmXV19hBFl/kF2fuZtu9FEZ?=
 =?us-ascii?Q?qoqNx8bKfemopy/LGRKUSX6hseENlV0f/SQtIEsboQ4yM3Fe+Rs7kzoCsx1y?=
 =?us-ascii?Q?d2et+xVUpvue8MevtyKe1RSX/0J+NAfKrTdhtnGa1wA5G5BklBOSfeuUvcz0?=
 =?us-ascii?Q?wyzOHTJJ+f5pQxQsSPAJerzW4VDNs9sQrTWkoVtN08GVjL6di4P4C2a5sjIb?=
 =?us-ascii?Q?qAfylZ3jCc0p3wP8NZbAnn605ngEkAZ7Mzqn7UlZ0qz/UWGNmaoJCbfN4O0y?=
 =?us-ascii?Q?dmnHucyJPWr2oZchOKSfIplXnzTJvBVEGqdKc+aMv6I4c4FFCQTOmPEpWXIP?=
 =?us-ascii?Q?5TonwiPUJggbCmfTtpo56IPTLnLBTlv/2rOfLDphmSOuFLY3xYnYxT8ez4jW?=
 =?us-ascii?Q?zWCaM9yv0RSSwxJVn4S4Z0adUskzlMewuxzTgTPDOBm14Fznt15BC88EmNSG?=
 =?us-ascii?Q?fXcAhV3W5pO34uAo9tHeL3CgWqRhwUj7+qmtMfqOAJbd9W9SPromeicaKsrN?=
 =?us-ascii?Q?m8GsqB4CRg3ukn+r8R41NNJcWGYWTFs7GBdN3vPzwb5U0SPV+aOksGGEDhhR?=
 =?us-ascii?Q?yhFQ/btc/zkg679FZiqfmHzoaP4W0zJRHPAk6XyiZwPgyssOSqwt0LfkozkL?=
 =?us-ascii?Q?+w9njLT0dnIIUbxP4wpwkit1kR0EZN5Ovo1iPWsN5p31cN9XCViCXB85WgAg?=
 =?us-ascii?Q?/vGD58s48hGen8hD01Q=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4215.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e76efe6-9518-497b-e0fd-08ddd97afada
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2025 08:33:57.3830 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wR4NFwzaB/rFWbTTgaa7kohbViN2MIJxVpVjx4UW9ky8ht85UOa4pRLz9N8WewbqE10EWnT+l98H+G89j/qQ+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7704
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

-----Original Message-----
From: Sun, Ce(Overlord) <Ce.Sun@amd.com>
Sent: Tuesday, August 12, 2025 3:35 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>; Yang, Stanley <Stanley.Yang@amd.com>; Z=
hang, Hawking <Hawking.Zhang@amd.com>; Wang, Yang(Kevin) <KevinYang.Wang@am=
d.com>; Chai, Thomas <YiPeng.Chai@amd.com>; Sun, Ce(Overlord) <Ce.Sun@amd.c=
om>
Subject: [PATCH 3/3] drm/amdgpu: Correct the loss of aca bank reg info

By polling, poll ACA bank count to ensure that valid ACA bank reg info can =
be obtained

Signed-off-by: Ce Sun <cesun102@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 46 +++++++------------------  dr=
ivers/gpu/drm/amd/amdgpu/amdgpu_ras.h |  2 --  drivers/gpu/drm/amd/amdgpu/u=
mc_v12_0.c  |  7 ----
 3 files changed, 13 insertions(+), 42 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index f00a9e0c9c47..ad8ad08f0f33 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -122,7 +122,7 @@ const char *get_ras_block_str(struct ras_common_if *ras=
_block)
 /* typical ECC bad page rate is 1 bad page per 100MB VRAM */
 #define RAS_BAD_PAGE_COVER              (100 * 1024 * 1024ULL)

-#define MAX_UMC_POISON_POLLING_TIME_ASYNC  300  //ms
+#define MAX_UMC_POISON_POLLING_TIME_ASYNC  50  //ms

 #define AMDGPU_RAS_RETIRE_PAGE_INTERVAL 100  //ms

@@ -3317,8 +3317,6 @@ static void amdgpu_ras_ecc_log_init(struct ras_ecc_lo=
g_info *ecc_log)
        mutex_init(&ecc_log->lock);

        INIT_RADIX_TREE(&ecc_log->de_page_tree, GFP_KERNEL);
-       ecc_log->de_queried_count =3D 0;
-       ecc_log->prev_de_queried_count =3D 0;
 }

 static void amdgpu_ras_ecc_log_fini(struct ras_ecc_log_info *ecc_log) @@ -=
3337,8 +3335,6 @@ static void amdgpu_ras_ecc_log_fini(struct ras_ecc_log_in=
fo *ecc_log)
        mutex_unlock(&ecc_log->lock);

        mutex_destroy(&ecc_log->lock);
-       ecc_log->de_queried_count =3D 0;
-       ecc_log->prev_de_queried_count =3D 0;
 }

 static bool amdgpu_ras_schedule_retirement_dwork(struct amdgpu_ras *con, @=
@ -3386,49 +3382,33 @@ static int amdgpu_ras_poison_creation_handler(struct=
 amdgpu_device *adev,
                                uint32_t poison_creation_count)
 {
        int ret =3D 0;
-       struct ras_ecc_log_info *ecc_log;
        struct ras_query_if info;
-       uint32_t timeout =3D 0;
+       uint32_t timeout =3D MAX_UMC_POISON_POLLING_TIME_ASYNC;
        struct amdgpu_ras *ras =3D amdgpu_ras_get_context(adev);
-       uint64_t de_queried_count;
-       uint32_t new_detect_count, total_detect_count;
-       uint32_t need_query_count =3D poison_creation_count;
        enum ras_event_type type =3D RAS_EVENT_TYPE_POISON_CREATION;
+       uint64_t prev_de_queried_count =3D 0;
+       uint64_t bank_count =3D 0;

        memset(&info, 0, sizeof(info));
        info.head.block =3D AMDGPU_RAS_BLOCK__UMC;

-       ecc_log =3D &ras->umc_ecc_log;
-       total_detect_count =3D 0;
        do {
                ret =3D amdgpu_ras_query_error_status_with_event(adev, &inf=
o, type);
                if (ret)
                        return ret;

-               de_queried_count =3D ecc_log->de_queried_count;
-               if (de_queried_count > ecc_log->prev_de_queried_count) {
-                       new_detect_count =3D de_queried_count - ecc_log->pr=
ev_de_queried_count;
-                       ecc_log->prev_de_queried_count =3D de_queried_count=
;
-                       timeout =3D 0;
+               bank_count =3D amdgpu_aca_get_bank_count(adev);

[Thomas] Does bank_count  only use for umc deferred error or include umc ce=
 de and other ras block bank error?
                  The amdgpu_ras_poison_creation_handler function is used t=
o handle UMC deferred error. not include umc ce and other ras block bank er=
ror.

+               if (bank_count) {
+                       prev_de_queried_count =3D bank_count;
+                       amdgpu_aca_clear_bank_count(adev);
+                       timeout =3D MAX_UMC_POISON_POLLING_TIME_ASYNC;
                } else {
-                       new_detect_count =3D 0;
-               }
-
-               if (new_detect_count) {
-                       total_detect_count +=3D new_detect_count;
-               } else {
-                       if (!timeout && need_query_count)
-                               timeout =3D MAX_UMC_POISON_POLLING_TIME_ASY=
NC;
-
-                       if (timeout) {
-                               if (!--timeout)
-                                       break;
-                               msleep(1);
-                       }
+                       --timeout;
+                       msleep(1);
                }
-       } while (total_detect_count < need_query_count);
+       } while (timeout);

-       if (total_detect_count)
+       if (prev_de_queried_count)
                schedule_delayed_work(&ras->page_retirement_dwork, 0);

        if (amdgpu_ras_is_rma(adev) && atomic_cmpxchg(&ras->rma_in_recovery=
, 0, 1) =3D=3D 0) diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/dr=
ivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index ff63020f9c6c..132b45a362c2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -492,8 +492,6 @@ struct ras_ecc_err {  struct ras_ecc_log_info {
        struct mutex lock;
        struct radix_tree_root de_page_tree;
-       uint64_t        de_queried_count;
-       uint64_t        prev_de_queried_count;
 };

 struct ras_critical_region {
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c b/drivers/gpu/drm/amd/a=
mdgpu/umc_v12_0.c
index e590cbdd8de9..8dbffe4d22d1 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
@@ -581,17 +581,10 @@ static int umc_v12_0_update_ecc_status(struct amdgpu_=
device *adev,

        ret =3D amdgpu_umc_logs_ecc_err(adev, &con->umc_ecc_log.de_page_tre=
e, ecc_err);
        if (ret) {
-               if (ret =3D=3D -EEXIST)
-                       con->umc_ecc_log.de_queried_count++;
-               else
-                       dev_err(adev->dev, "Fail to log ecc error! ret:%d\n=
", ret);
-
                kfree(ecc_err);
                return ret;
        }

-       con->umc_ecc_log.de_queried_count++;
-
        memset(page_pfn, 0, sizeof(page_pfn));
        count =3D amdgpu_umc_lookup_bad_pages_in_a_row(adev,
                                pa_addr,
--
2.34.1

