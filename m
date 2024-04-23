Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FE06C4345F
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Apr 2024 03:27:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D0485113005;
	Tue, 23 Apr 2024 03:27:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="g7g2T6Ri";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2054.outbound.protection.outlook.com [40.107.244.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D873113005
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Apr 2024 03:27:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gz3I8kJ4ksO8S7vAugbKeO6xYYyLG9sqdjNJy+tZ8EtUz4pWG0lZWsIfiS1DrtRX0yL9iQIV3c5+IK5PuNosjga4YZczHI5VMDD3Vf/HtZ8vVBsoYchW1TA6CUxifiFmtyi3KjKMPJMHXeWP+72Fe2+aJ2+1nqOCrJqhRFqeW6TvctGhPZWv0A1aOIwbPspju5RRU3qgmqLtJvBslfA8CUFYQaAHavSTEXwM2v/+5EjjIWiUtv0w2gq7gdYPWXJbzxBb+08P/N7OFxEkfgeA/SBPx7BoZEEuAqS6XtTi1X7hNAQZb4CBCeVVRLdYyOZgLVMzxMUGwGRFahXqEUCTDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nUuK72FoaS5zeg0j+LcrUGIw+FiG73sQKcNi3/YlMUE=;
 b=AQp17kXeDci3RaMpmKcwwAMbYkEekv+Hb3AGysfU0QS0MO5SPypR1Sd2KIq0yh5Hz4vQ+LmfaiPHJnY+bV10UKm2e2O0Ildbi5Adqf0AyqfoteaK0NFOiTiK0uca0hM8aOawqhBhvBHhRprobYohUSSo6VwfKup4LzjFAX6GYpgT44DMdE6Uljka1lsD6iaVfjZerUW0SnctOuSfm+s8eyYgvkfLNwguHDD5DVhKHBqqo4C+6A8tkTHbbErUSlbnIwENd1AK0MylmjcGMK0FXZm92Xl7fazUm0EVuFtPjmdwZqIF7BEKk33aNhlKFW9n8jX7Kfjfd3Ynl7sEUuhNZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nUuK72FoaS5zeg0j+LcrUGIw+FiG73sQKcNi3/YlMUE=;
 b=g7g2T6RiWQBfGrGrcvGab5RZIoVeymfHdyzOd2aInuQQIM2Hhix/XlEHjoWkMCk4iU3l6nWtH06r7QWRYxZzGbKs2YuDP+YzQGc+BJm3CoE4lxtg+TU0vhiKRSl7XYs734vmA0kx0q4b9GfRCsMQTOi9r+xS2hUU4G4V1jbgdD0=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by PH0PR12MB8032.namprd12.prod.outlook.com (2603:10b6:510:26f::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 23 Apr
 2024 03:27:17 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::74e4:f50f:79af:c996]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::74e4:f50f:79af:c996%7]) with mapi id 15.20.7472.044; Tue, 23 Apr 2024
 03:27:16 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Chai, Thomas" <YiPeng.Chai@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Li, Candice" <Candice.Li@amd.com>,
 "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>, "Yang, Stanley"
 <Stanley.Yang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Fix ras mode2 reset failure in ras aca mode
Thread-Topic: [PATCH] drm/amdgpu: Fix ras mode2 reset failure in ras aca mode
Thread-Index: AQHalSxkrUqxQy26aEa5LJj9U4Axg7F1Mckg
Date: Tue, 23 Apr 2024 03:27:16 +0000
Message-ID: <BN9PR12MB5257AB4F001E4DD0ABF03044FC112@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20240423031338.863302-1-YiPeng.Chai@amd.com>
In-Reply-To: <20240423031338.863302-1-YiPeng.Chai@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=75908d74-f3ae-4462-b50a-440cadcd8adf;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-04-23T03:26:44Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|PH0PR12MB8032:EE_
x-ms-office365-filtering-correlation-id: a6b68f14-c024-41f2-63bd-08dc6345468c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: =?us-ascii?Q?GbCiCNgLQ0PR2TSEcRa30Nggdn+qeIVCc2pLFNEQXtMS7TRxeVI802Q+hGxd?=
 =?us-ascii?Q?SnMGNFoiaFS7623F3dMTW59hiW7g9KsIxHOqJNAAXkSsKGCLIOkPkc1G/1in?=
 =?us-ascii?Q?vkbnC4gilnH8VPMg+69bqjzQC4kWsPrLM7HYRw7rPE4YWoCm979q9PZYx2dy?=
 =?us-ascii?Q?iKq03eRnXZXO2f5LK9NZTVYF2GMoxwuFC/7FoWYwr1WYM/9PlWEZUVmZlxDs?=
 =?us-ascii?Q?Y372XYqTqqSRAP7lVKukaAg3xooTtZBvVvD766mrQVsbRiuCvwCHOIXwtv1c?=
 =?us-ascii?Q?b+zcCunoBUj7Xg2XNigCMAR74kKYlRhGHz1PW+Q13rHigM9WDIoeb/7o1eDG?=
 =?us-ascii?Q?7Yp+816WtfZ0BcVsR9MJR/71mhNBux12s3X5DZB7yAodpnCBMjdrR172tQDI?=
 =?us-ascii?Q?5DLi0+QtkDYVv8aoy2zTwemYpa1T8a2HX+wZ5QMrUq0bOMaPEb0SNYkNKv7I?=
 =?us-ascii?Q?oRLEDikVkv9k/9GQlYMYq2FNTo8wGEE8OJRU8uQLTzrtZgDnIDjkcQx54v8l?=
 =?us-ascii?Q?JA9XVTdV21YkPuq46Vi34+y2tXp8JQ915i27mdZd5DZ61w3Vl/6Shvc4wPGH?=
 =?us-ascii?Q?LVowlgTZt68WvbX7EtOc7kU6H/j/yuEGxhLDehaqAsFlaT+n2RuHay2SJJyY?=
 =?us-ascii?Q?9LgTvmcnYFAX61iA8qoVHY5CVzksu1YLF9rWgHewLeH1LEYhR+9pqJGxQgSf?=
 =?us-ascii?Q?x3hHt7vPp3QrZ1drMdOn/zW+LyhbKnjOuB3v/WSAd9YJ4JSOsr4g+QevY7a3?=
 =?us-ascii?Q?PECjI7zvTwxzbD+bkmSYm9bd4IZW7EMJUI8EYiZ5oZd2MKoimUaOermOnlzp?=
 =?us-ascii?Q?ymssdNQptNSe2665pnU6ZgY7g/y2I5PkdfLmDqcQo0Ll1NaTLrKWd39CSj2S?=
 =?us-ascii?Q?PVwyKrUoWntRDjuChpI1yl6Ih//IVlRX+/Xg2c4d5QEdxfoA+Gdx8IjBfO1q?=
 =?us-ascii?Q?pi6h7UUBQrFNzDMLJcFM5uArThXlvHBE+kM1w0HPCA/pXQXa3WgrPn4PZ/XW?=
 =?us-ascii?Q?unJb6uI6l5YTOwCMHQ8KfZiiWGYDbBTKuZnnQFupK3L2jijhIrw8bt8Is3+F?=
 =?us-ascii?Q?JYUGKz7Xbl5vOTdMHeng79FVB0sDDrzF9aL8Wo4uzLlwomjZzyaHs0Eot9ZC?=
 =?us-ascii?Q?8AHqAnLd0p6PbKGx8y9cj1Yet5M2eOQBqFS/+P8HGCplM+2cYfQQf7F3aJLD?=
 =?us-ascii?Q?Wi2LP817NW9PFMmUbO8wS03m15yP2450RR3bKJ31WJKPe/vYFE7A5g7AS8I8?=
 =?us-ascii?Q?+E19oOJOl2hTnBsOYxRbUuwg2geCQLshlmVNG5RntWik6OfK5xM6nC/1/3Wv?=
 =?us-ascii?Q?TFil6/+4J8l2U8AK1ZYIU2vwGWAJ6xNgJ0blHHYno4vaAA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QMg15ebZ3qF9Ach3pThaMiqshqZJsJ9gbn4NvmwxWwRXnGRpY/IAvqAzIiAR?=
 =?us-ascii?Q?RygcDMY/0DalfBB+3wbDqYF1KnN8qdNrHJXEQofDQ11PIosQ7QCjZ2NQPgWy?=
 =?us-ascii?Q?oO4sRW46O4vBeEwOWr23B7NkwZZrmUL6XHv7sasD5mzlNqEm+Y/WHjWZN9nV?=
 =?us-ascii?Q?P6a19kQhRb8EYr5XcWyqxEfxzU4LYSbhm6wPis9hS1ae1hIQWGrK5TjRhbEs?=
 =?us-ascii?Q?zKJsCrH4QIR9kR5kMZYhqznAMBJmHI8pXGfOLcE+GDwcF6ewwIC20SAgLIiE?=
 =?us-ascii?Q?VCm0kC+RES1TOincLSrGtD6FXCtM4YIDqsmHC/ILU8OZ/KIiBm0xEAI+5HvY?=
 =?us-ascii?Q?xWNFp6gS8nItFnz+aRxFXZHZrJ2ZT8JD4L4YgOstBv6e4aWhWh0EXZDl6Ing?=
 =?us-ascii?Q?lEa3mYqKJsL2l+Tm/rt1I4Koj4zXQUgKgvrmV2n2FKu6uXjTsAd2ttZyRpGf?=
 =?us-ascii?Q?eMcIZi1mq7aoTU2IbGguAx2KRsfnkHEdJokeuo5dL9r8q5ajn6Iklf8Z+wji?=
 =?us-ascii?Q?UNPBCrd6ipxI6jp/Mf2eHEw4d2ilXMaJBjIqn1XJHPiM5aiYhZgVHJTIeiuy?=
 =?us-ascii?Q?ODS076RThFhyMrKCvZ2ceL8e7pz0AxU2fKCD/jnkOIbnPxA/PhFRbSi+/41b?=
 =?us-ascii?Q?wDgQZfiOJggJGYuuV5asa/g/BDgUifBqKsZfI/RQcH8G5+OD6kuaBO+PoW7S?=
 =?us-ascii?Q?60TQTFLL2d5NlZmPJ8R8A3DdhvvGEtXP+J5L24nLyTKN1nD5+cqtX8S4vICY?=
 =?us-ascii?Q?ZO+Uy3jWE5/il7lrz/s+RLu1jNukNFpKvdWD1ZRC0CXVWoa6BBIcOz3Ku40+?=
 =?us-ascii?Q?MjT2ySaFpbQ8CrxLwwTl3jxaiQYZJTRhwYU4zadGto/3osXsh2oZf9/dF7fK?=
 =?us-ascii?Q?UE63SbpeZl2+pNjtUrPndR70vfhoba5sDPlVovyQpNatjEcdP9y68U5xyG9p?=
 =?us-ascii?Q?lMbih+PPmx2hLA8xy1xDt6X8BpN1SJ2vvjTmIUdeI2KzXYjpO4CqSRjIUroc?=
 =?us-ascii?Q?KePc1rLtXl/3667Fi8e0iyb6od1cMv3toWSybMsR0u+Nd/OtikMHsZLdicNx?=
 =?us-ascii?Q?FGOqRgI/MS5Gsr2IcXszu7oLO+TUfSyXpEoungEuWjHf0CIDLKHjrqjKqlwN?=
 =?us-ascii?Q?WNQ/fSSMBL0E9as8mQnOApf+ESD7C/6i7wler/mSo06EyocN2TSruPl43AYB?=
 =?us-ascii?Q?36KpCMXGWpQAuTi1TGiWOs95XqkDuSDN56ZsKRlKHzJqo+SAZ70ntqnLinA+?=
 =?us-ascii?Q?B7O7Yz6iYqvaU47H873wjmb2pKha+HYm2n+K4UDdeY8pDcQ86FM+awBZZowg?=
 =?us-ascii?Q?Gv/50APW0nWJZjNep2KrvO9JhcENfn85bZY9uj9uOunzU5tufUpN9UxeOIAh?=
 =?us-ascii?Q?9h3PiENL5uZj9nkjUI1LTPO7tL4Kw/NbW0tYxZA+IdYOduG7XDteDXkd2LkQ?=
 =?us-ascii?Q?64nvGG27xWjN2vCqeGTrW3FsbTI3whbqBmZ2KtTy5pXL1qTdyN8xOuip6InD?=
 =?us-ascii?Q?0tuoDHZXpHE75hfwHCPWUQaxA8CBKp1UXUssamGlDIN3dRMVtgt+x6fDJGrK?=
 =?us-ascii?Q?HSYu3cIcTyKiFfRF2o/Q1wgIbKJpmViXyonUPz02?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6b68f14-c024-41f2-63bd-08dc6345468c
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2024 03:27:16.6929 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q7Jjt4Q45w04V2bx67wUaBPK+bGI4O1VLkspcAly3XwMfXIcP1JpKs5geTTbkCgwT/ZhGfduAjaawT2rd5Gf0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8032
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

[AMD Official Use Only - General]

Shall we move the check to the aca helper function?

Regards,
Hawking

-----Original Message-----
From: Chai, Thomas <YiPeng.Chai@amd.com>
Sent: Tuesday, April 23, 2024 11:14
To: amd-gfx@lists.freedesktop.org
Cc: Chai, Thomas <YiPeng.Chai@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.c=
om>; Zhou1, Tao <Tao.Zhou1@amd.com>; Li, Candice <Candice.Li@amd.com>; Wang=
, Yang(Kevin) <KevinYang.Wang@amd.com>; Yang, Stanley <Stanley.Yang@amd.com=
>; Chai, Thomas <YiPeng.Chai@amd.com>
Subject: [PATCH] drm/amdgpu: Fix ras mode2 reset failure in ras aca mode

Fix ras mode2 reset failure in ras aca mode for sdma v4_4_2 and gfx v9_4_3.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c  | 4 ++++  drivers/gpu/drm/amd/amd=
gpu/sdma_v4_4_2.c | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v9_4_3.c
index 0e429b7ed036..c8bc34aafdd7 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -4324,6 +4324,10 @@ static int gfx_v9_4_3_ras_late_init(struct amdgpu_de=
vice *adev, struct ras_commo
        if (r)
                return r;

+       /* in resume phase, no need to create aca fs node */
+       if (adev->in_suspend || amdgpu_in_reset(adev))
+               return 0;
+
        r =3D amdgpu_ras_bind_aca(adev, AMDGPU_RAS_BLOCK__GFX,
                                &gfx_v9_4_3_aca_info,
                                NULL);
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd=
/amdgpu/sdma_v4_4_2.c
index 7ea209b68154..77ae943745fb 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -2249,6 +2249,10 @@ static int sdma_v4_4_2_ras_late_init(struct amdgpu_d=
evice *adev, struct ras_comm
        if (r)
                return r;

+       /* in resume phase, no need to create aca fs node */
+       if (adev->in_suspend || amdgpu_in_reset(adev))
+               return 0;
+
        return amdgpu_ras_bind_aca(adev, AMDGPU_RAS_BLOCK__SDMA,
                                   &sdma_v4_4_2_aca_info, NULL);
 }
--
2.34.1

