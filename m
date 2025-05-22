Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEC25C54ED0
	for <amd-gfx@archiver.kernel.org>; Thu, 22 May 2025 04:46:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC9C18DCC7;
	Thu, 22 May 2025 03:03:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="o4pt+oEW";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2047.outbound.protection.outlook.com [40.107.236.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 372108A9FD
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 May 2025 02:43:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nNJ6fWsgwy5x6r8n/SFETAOXXn9BnNfR1PTf2/buIPGbZD59wowfI7LZpqynLjS3RGXOGdRPki7t2lr93eWJbX5bsS5qW4U5r+WgVApb7WNbzu7HuG6F2M390xz9fQ+lzq86CDSwXo3iqzuuMYG2rDMSalSy7UEnRg7ly1gdORvDEndvmZin5WwfBVYbUPp/GEr1bJuMHuKNdzb3h7luO11mrte1ElW+jQoZ0E9LF/aJv+1jDb9y4LHT8A1NufNPYntC2pTcy2lAlzuA/nlTfQyT0Ok0roFM09eSJ+ZIOrDaWjTtQaWbWxyPpXf4n4/xbVb8BdAEMeDahmIrbH1R8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ws+FSvVWuimrdiDcmTwGofEDZTNHxzwjF9VUrr7f4UI=;
 b=EmpEwkmKI7zrFZYWbasu0yLqQvWmB5ulOXYrIcVfXaVwQlSQAGgGMh/cSLzJzCzNDKg6I0vlm7QoqYhgG3LBvZ/ShQKxekrqUUmQxO8GAs4eUEnSZzcqQJKheCGtcG89lwemTmxIvplHNMzrqJbIHpXetic6ubNb2Q6ZIVfpr0ZuMTHzLuXJFts7/nnfNCLWoS0Tr4jXeR+zlRds6qZRn3KPsOPQ1ZN03xnwBwGNIOoT+3hMGLXQbrrWQi6gfYZybBPYpCQeso4c12P9cUqiyx3o27ty9e4+PnDad/FKwvqQ0PAs5AlaNCHSVeJ4My4oZIEnD7kdrZjmbQe8dp5h4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ws+FSvVWuimrdiDcmTwGofEDZTNHxzwjF9VUrr7f4UI=;
 b=o4pt+oEWmhP+OZdjItU6sep0mR0SeX8r/IhXlA0/6oUPhpjJi0vsl3Hn1geCuCJNsGcukBKV0fcOIhu9yhI5hjTMi1hGID3sYl7hxGyqJWj1nCBXl3gaQ+utosAEDkpycpF+wEKu9mIHdLMufJDJWuvMPQCZBfOJsV3TTn/icdI=
Received: from PH0PR12MB5417.namprd12.prod.outlook.com (2603:10b6:510:e1::10)
 by SJ0PR12MB7459.namprd12.prod.outlook.com (2603:10b6:a03:48d::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.32; Thu, 22 May
 2025 02:42:57 +0000
Received: from PH0PR12MB5417.namprd12.prod.outlook.com
 ([fe80::de07:ec43:e847:2f50]) by PH0PR12MB5417.namprd12.prod.outlook.com
 ([fe80::de07:ec43:e847:2f50%5]) with mapi id 15.20.8769.019; Thu, 22 May 2025
 02:42:57 +0000
From: "Deng, Emily" <Emily.Deng@amd.com>
To: "Deng, Emily" <Emily.Deng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v2] drm/ttm: Should to return the evict error
Thread-Topic: [PATCH v2] drm/ttm: Should to return the evict error
Thread-Index: AQHbygRnx59CYJ7jJUe9zr7ZahIWpLPd8l8A
Date: Thu, 22 May 2025 02:42:57 +0000
Message-ID: <PH0PR12MB5417991052F0D5ABED1D99528F99A@PH0PR12MB5417.namprd12.prod.outlook.com>
References: <20250521035654.17581-1-Emily.Deng@amd.com>
In-Reply-To: <20250521035654.17581-1-Emily.Deng@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=2f823cfd-65a2-4883-ba13-0143ee487adc;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-05-22T02:42:48Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5417:EE_|SJ0PR12MB7459:EE_
x-ms-office365-filtering-correlation-id: ea8923ac-52ea-482a-6d2e-08dd98da5c7d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?5PnaFMGvwIxV4i1UQMCREaK1+Tsb3E7LAKZbOCx8SJMvTd+yxl/0ilmba734?=
 =?us-ascii?Q?8KTbSfIHiN1+cNxt79n3fZiDXcOeoBlb44olWwEfZHLXihZcPxF6gznqs2B1?=
 =?us-ascii?Q?bEmh13j8o4oaiJjxOdEa+azIBBB6Y2QDocHJfSf0BLcLUTNZJ00GZ7DSSCFo?=
 =?us-ascii?Q?gN/N9wqCmelgauIe3VScGGEe79SPcFaUOjh22VSFoMziZYPEE+p7gc+t7PiK?=
 =?us-ascii?Q?EeUE/K4ZMzt4LwzMkdFzk0UPjQw/Jrs0Njv3BpRwzE/Dqv7ot1i3vE89C7Cz?=
 =?us-ascii?Q?jwLx30AjcxvaKmnqz4sWpZLPElevoX8ujEtfpsavU4hu5vtTlMJ/9AprhToX?=
 =?us-ascii?Q?Q3dz6oiH2tFaaBOkd96+Te40ULV00Wc/2JAteXoq3CHpVZ9IXali1wBdYXc6?=
 =?us-ascii?Q?5cWO4JOAs8ut+e4THGdj53wj258VDmz9e8khDrMZ/vKjbjBOzGzbITAbxrzp?=
 =?us-ascii?Q?z0GLJTn7QtHPbjUoRGdJHvkBghpDEFT0fwygwJA16IHn1BvDjmlUB4CLEkQD?=
 =?us-ascii?Q?oXCuDkgn3cUcvOYPMundgdpKl/GmCWX3cK+nYnbbSpVRBiIzJQGqWILNe2Ig?=
 =?us-ascii?Q?Ff1akdPMBoBQyLMLlolFzeJ/tJ8ejpth6vHlsaHL/QfyZI7U1PU6PGqXQkDo?=
 =?us-ascii?Q?nPWmu9B5DKPwIk+KVJYrfBiZeznzgbL35FTsLHyAQSWc43YRW/aCGeoiZX9U?=
 =?us-ascii?Q?nOeqIbk7VRy+BxUVvgdNRDynGVzVI+eM9xOZVIQHpqHKMyXDfe2Thi+Hzzeq?=
 =?us-ascii?Q?uoGSyCSPQX/ep/uF2hnTW4/YZiEuM/z+gT7Y16OinjuEGa6zi2FmKWZ7BcK+?=
 =?us-ascii?Q?n09SJobkijFgFOnW1CgpvPC4HhzsEdUh1yi0Qjxbts9PdpKb9N/GpJQmtWW7?=
 =?us-ascii?Q?KKTY1arO0T81+R+PW4rritQAKnnblW8niKiesUzvNI++2sElG+1FEPCuvg4d?=
 =?us-ascii?Q?9E+Btk4Bo4W7bzZYHtp1zEzITjgQT/Aq5dnY+M0gRKlzaOxTPNmXcf1gOzin?=
 =?us-ascii?Q?20QfP4L5jv6Gqj1W8wbi+S7zsI6a85vjDsv13+/m7COZxNHIeedcdAAXO5xt?=
 =?us-ascii?Q?AZ+97knvpCs2qvwPXmG22q3/FB2BkQ4IqgKr4UzKFsbQ0R+/8XLpq2uJ7PoZ?=
 =?us-ascii?Q?lX8u63RfMzWzTZmX77ynbxUwCjjfC0Srg+5scNW1jZOzNaYtyqtsxKMoefiC?=
 =?us-ascii?Q?IzMarRiMuJGVhX4x4/9F8aStU4Yh/a3Aw8RHCJZl33ZBSI0kQq1neMCjHv9i?=
 =?us-ascii?Q?SQBekFLHbLnofl7M/XQXtDqm6gjw1v89O8evwSiuLN/SrEokkV2iJVxuahDf?=
 =?us-ascii?Q?rMdEYyepYFIsiz9b7TNADjMFW+U3gabKK9KruyMzjz4biyDLM5U4gVDyALHK?=
 =?us-ascii?Q?RXkWwUh/G5F1/RqXqaMreg2CXdjiOgkxSMVEyOSn0MNUcmcukWJBk+On3us1?=
 =?us-ascii?Q?quuWBL2aISg84yCK6vBkvN8uPVEagAVLwIHqpj6nz8omhU6HF43sEA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5417.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kEQTs4veoeHN+dWlACHoHlCZmLLuzQAGUymaY+uRcsj04/UBtX1O3TgzMCOq?=
 =?us-ascii?Q?iDpGgx3K+HDH5PQTUoYYxZ0Otwr2ahuCnBIp50LfWiQ/QCDxMleC82cIPh5m?=
 =?us-ascii?Q?EoX9lh41SoXjPhhjTFzxE3aiFYzxnAxtfTimWbpmiurOfKXKOCvq+RjdPUBs?=
 =?us-ascii?Q?SZaZpfUN6AjjIBj4QA/HDYRaYiTCcSWORkms2vAQEsiJyMRS7QDi51qLWNxL?=
 =?us-ascii?Q?TvyUBbW0vY94q+/on3MOsa42hRlh5jitkf/SDZ82VMppLfFldlsKCMa6q+Qw?=
 =?us-ascii?Q?2/Mp54kesmpjP0aQHiWxmzwlRbThMZx+lNcz9IYB/Ha257Zg1owcwvUrN+Rz?=
 =?us-ascii?Q?6nKZygdDHsC4Uy4WnugaeJdZ+ZgBqpamvt8MjAufzVATBI1tr2VKV4Qd4Hc+?=
 =?us-ascii?Q?ubUY9eH1et0aNuliMvdqV38APUjZ5a7/Pjhy+DY+UjnuACQVApFIve0NgZSN?=
 =?us-ascii?Q?EAVBEaI5bEvD4UgOzyW1oXL2CEN1ouSQ+2CKcXGXcau3QmDOXrtjkzrB3Mu7?=
 =?us-ascii?Q?7spGAGzxJxw3n82I//Sdc2J4qvmRIc9uwEZdkgtzNyAxylL3AnbRIve32kDQ?=
 =?us-ascii?Q?J+pBiC4v5tOyNtPn6K0tH7kL/M04upvgikXe9EPvnsPABcigKC+RD6VsPHrg?=
 =?us-ascii?Q?NcK/dyYzXOIihHE49swL/vVJFHIYHFeFNAf1a3cSvdei0i7RovaaSoIXc0uC?=
 =?us-ascii?Q?rc+ll2AwhhFU5RFYS1NrIA8QwGNkloUg4OwOQfk6wEFyV2NOUdO1a01xgsac?=
 =?us-ascii?Q?SUmIj4Xp4C4qTNfDfyTH8Rpd8TB6XZA/SahRe/kQ9qvRf53imr4xq4iGdEWu?=
 =?us-ascii?Q?8mGz09dsdZCGY8qzpRPVyOtuG8XmRtd3/kqJHzpBwKt2xkup/LhRQLPwYV2y?=
 =?us-ascii?Q?RMbY+rjiA9WvqcwbHIIt+Xgu6sIO1CwtOKUfTa77BLW/pBwNevxvLLD520gG?=
 =?us-ascii?Q?o7k3g4hs67JAiwHS5djeCp89e+UjLvff5yA0CmxjTokT4RB34j8kIVHq6xag?=
 =?us-ascii?Q?Z6JPzD8KxsZEpwIytKmrurAwpoC19oZB2HFY0Aw+sPuc3eN9wYUjRGlwHMKA?=
 =?us-ascii?Q?bXvLLBKee+nW5Czof19nhyK4mS+lJEl90e1/rngdYaaSidHY2q4fbwjDyRzT?=
 =?us-ascii?Q?9UjL5CwWu/FSV8ZIkllYdfhOA6FZyULcsIjJpx2RsIfb2TC6Q3UuyrGboFDS?=
 =?us-ascii?Q?ZDlzdebo44AROhXW97D8uAFhDDT9Q9LCyRJrtQ99U1zUEwMO9uOTF7k6OUGq?=
 =?us-ascii?Q?evA+4KTm50IPYddPIQ9IDwJNpOs1LBAe6E1TlvSrHlGMWqZlTCPlZczjCXsU?=
 =?us-ascii?Q?1ewBeatMPx6lFlQZFR19/bcxRssG1vs2sjPpF0fWGa2MFAJ+EKK3D9ekulso?=
 =?us-ascii?Q?942Huk+WiC1vGWnOqmtKguewXt6mBP86yt46m3GJAwL9hEcUjH2Vexr47B/R?=
 =?us-ascii?Q?yEsbPFkcPHhn0T0itu5eDwEPU1IMIB4c9ybIDVg0mfcBpxcwTtr14EpVynWm?=
 =?us-ascii?Q?X4gG82r7Eu/qfqDjcOUvfep1StA/iH3fzyPTU75NA7JpK8uolNm7/NYajicJ?=
 =?us-ascii?Q?WEb1/dm60lZ1ZihW2tY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5417.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea8923ac-52ea-482a-6d2e-08dd98da5c7d
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2025 02:42:57.8472 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 156qaX/xPyf/x5rvLy7cZJ1nUECXvbfWGdcqM4PrKsypCfPjcnoAlQKEBt86o+BS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7459
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

Ping......

Emily Deng
Best Wishes



>-----Original Message-----
>From: Emily Deng <Emily.Deng@amd.com>
>Sent: Wednesday, May 21, 2025 11:57 AM
>To: amd-gfx@lists.freedesktop.org
>Cc: Deng, Emily <Emily.Deng@amd.com>
>Subject: [PATCH v2] drm/ttm: Should to return the evict error
>
>For the evict fail case, the evict error should be returned.
>
>v2: Consider ENOENT case.
>
>Signed-off-by: Emily Deng <Emily.Deng@amd.com>
>---
> drivers/gpu/drm/ttm/ttm_resource.c | 8 ++++----
> 1 file changed, 4 insertions(+), 4 deletions(-)
>
>diff --git a/drivers/gpu/drm/ttm/ttm_resource.c b/drivers/gpu/drm/ttm/ttm_=
resource.c
>index 097716bd248a..abf104ae9d35 100644
>--- a/drivers/gpu/drm/ttm/ttm_resource.c
>+++ b/drivers/gpu/drm/ttm/ttm_resource.c
>@@ -511,12 +511,12 @@ int ttm_resource_manager_evict_all(struct ttm_device
>*bdev,
>               .force_alloc =3D true
>       };
>       struct dma_fence *fence;
>-      int ret;
>+      int ret, evict_ret =3D 0;
>
>       do {
>-              ret =3D ttm_bo_evict_first(bdev, man, &ctx);
>+              evict_ret =3D ttm_bo_evict_first(bdev, man, &ctx);
>               cond_resched();
>-      } while (!ret);
>+      } while (!evict_ret);
>
>       spin_lock(&man->move_lock);
>       fence =3D dma_fence_get(man->move);
>@@ -529,7 +529,7 @@ int ttm_resource_manager_evict_all(struct ttm_device *=
bdev,
>                       return ret;
>       }
>
>-      return 0;
>+      return (evict_ret =3D=3D -ENOENT) ? 0 : evict_ret;
> }
> EXPORT_SYMBOL(ttm_resource_manager_evict_all);
>
>--
>2.34.1

