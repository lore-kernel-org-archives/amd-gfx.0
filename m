Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C6C3C55184
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Aug 2026 19:07:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD43E10EB7E;
	Tue,  4 Aug 2026 19:07:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Vg9q+Vy7";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010016.outbound.protection.outlook.com [52.101.85.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC12C10E1C2
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Aug 2026 19:07:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KLKU069RemFR+V5VQcmSEra05A9s7Qj8gKCrqDhSh/TVzGwlh+9TnOpP4MgwPtGfw+oI3lzG64lOHQKrGp2l0aJ4qc4JsmfGcGEXBCyCsUI9vRm+H/rX5btmX5KXN0flroXOLx1VlbBlPVfdH5Sre5XzDq2nn9jXJtbmYO27+7azjfec+VhDk4THLHJDR+Y1ONlglV01mOOGKyMMfd9+M8u0HGw6mRSQiLJyqRWy78Vebgaf55Kmy77H+tnBXJoEQcVvGjvq0CdxCAOs9PqeFPGrFd8BTh7WrGFYoIw39b9lHgQ4KC2ZmzVJ8zP9PGZsWuHLTtrnriVJSEyHJssX5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1TlTpu7VgMptObI69V8HHqxRyY8psTUY9pvWEIu1U98=;
 b=P0g3d1PTFvM3rYjN40UvV2OWI1L0AonkWexI6SqhonCp9A+rJAxqAiIhd91aL0SLaTUClLX48uV5y7mla/AO/B+Dsx7Y8fS+EUk+KiJQ6vslHvrJ7YfLiP+AM5UUHmQvMpqlBVMGipGSb3QpooC7ryp6KYRCioU3lp5pd8hgQQWxVx1rPZWfclRoHvTQNCcYZ3fEkjFuLodvuIgrxsaTlqMlyt4fXm88jrq8Dv1FJZQLNOb3rfGCQa807t2q2BxHnTp6dSpjlvENHi/wDQurfK1DK7akbW6v64iBw2Ap8ULSuR1zIzQx2nZdgIy2xIef3n0ELSRG1NhMl2jWZQOyrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1TlTpu7VgMptObI69V8HHqxRyY8psTUY9pvWEIu1U98=;
 b=Vg9q+Vy7hkOh4Kta0y+RIZyu9B0Juqb68img22ftDKy9XFWsNsYz+5SfMZbHy/P8kDBfs0jhxCCNf0pgB6nn+sBLO+sUOpYKHsWN5Vbni7jNRMD4A0t7riie0SLUkWlPYnJNxRz46NgcTUpDZd+D9Si7kt1NmWUnpCquhLCcexE=
Received: from DM6PR12MB3611.namprd12.prod.outlook.com (2603:10b6:5:3c::17) by
 PH7PR12MB8428.namprd12.prod.outlook.com (2603:10b6:510:243::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Tue, 4 Aug
 2026 19:07:33 +0000
Received: from DM6PR12MB3611.namprd12.prod.outlook.com
 ([fe80::7861:6815:8b7d:bd0b]) by DM6PR12MB3611.namprd12.prod.outlook.com
 ([fe80::7861:6815:8b7d:bd0b%4]) with mapi id 15.21.0270.016; Tue, 4 Aug 2026
 19:07:33 +0000
From: "Chen, Michael" <Michael.Chen@amd.com>
To: "Liang, Prike" <Prike.Liang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
Subject: Re: [PATCH v3 1/2] drm/amdgpu/mes: refactor the
 amdgpu_mes_alloc/free_proc|gang()
Thread-Topic: [PATCH v3 1/2] drm/amdgpu/mes: refactor the
 amdgpu_mes_alloc/free_proc|gang()
Thread-Index: AQHdI7+893oahxAaakWmXAYwh24VKbaOQJRq
Date: Tue, 4 Aug 2026 19:07:33 +0000
Message-ID: <DM6PR12MB3611A1B8F7AA1FE9EB361AC994D42@DM6PR12MB3611.namprd12.prod.outlook.com>
References: <20260804031646.308213-1-Prike.Liang@amd.com>
In-Reply-To: <20260804031646.308213-1-Prike.Liang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-08-04T19:07:32.021Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD
 General; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=1;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB3611:EE_|PH7PR12MB8428:EE_
x-ms-office365-filtering-correlation-id: e18e62ea-c96b-42de-fbb0-08def25ba389
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|376014|11063799006|10067099003|56012099006|22082099003|18002099003|8096899003|38070700021;
x-microsoft-antispam-message-info: kgZYlp5GShvGf0E4W63clyncuwaDd/b/3MWCKg//vNaChqmyU4Ozc06ZoCJ9j2WqhdkFevCQF9kP/kQtUeOsIQ3ivuhx/SWVodadWnSHHNUgSI1TUL/D26e07hJ9TkAUF+E37c66Qd42kH9UzmxbpIhXpZnJ0+llxN3c+cxi0RQdKeCMTGa0pLzlRV+rXvU8JWc03A4fKeKfTl8BbvI1SIrhmGT1WCSMmSysth6pnULAuhldcK5WqrQCMT0X++7eDBbUFe2oFiDkInvR+gya045e0En/dGZu64x7GxGnMKG4ZJ1s5r5v8bVnR0TlBya9/ClgszHcF8eG/BBnSGffnf7jSxZfa/etwG8TJRCGDdDFj7uJZXFADDp+IE9bIbwxX4F/4CZqqWV7KNbA6OKhN5u9Hiq3btl2oVDYQpCJpcoFjzcKHNzAFbxnNQqrexlgsdGMoxFevQRWiAqQUMT1giSDf/QPuE7EnbCgn08m66hC6rZWoJd7PC97NqKvKkvQUkoz7nGOpTh3EWj/xV/g0CM4+IKjRR9Z0aWFVFRQHG1x+6pt0Kol22wSjNDEatSUt9QJPreewcbzRc4KlYHKrNgPI/Knsmq0Y5fbCYunLrOIVZemKTF1Iv5Td16PHjQH82D2C2N1s1nDPX9JAP4FzpWK9O/+qzyoNmALBq27zifAnLfIMAdC+4pyMX8whI3QgKQ+U+laA7B+WIXl747W3XJq5ZZdeb3E7zsrEPXl8A4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3611.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(11063799006)(10067099003)(56012099006)(22082099003)(18002099003)(8096899003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?9zmirGWaE0GCYjYrQ8jCcHKdSv6nvsy5PqafatS7Kk3MdXXqT8LSzUWnQW?=
 =?iso-8859-1?Q?c8dY/ZS65MCL0FGDWdPOMbZKniiK772CBhMadzC2wiU9GgkwKJEOTbUsN0?=
 =?iso-8859-1?Q?gdbcUUN81fDPd4ZDULvn0Jbt+eMAX82YM9wGYOLZIJ4zsX+ykjnY4g0syd?=
 =?iso-8859-1?Q?emuyYoMW+q1b3GU3DjE+EJ2i8qn+9gMccGN6dMi6L39wjcV2XSaiHeVq0S?=
 =?iso-8859-1?Q?qcv2gry/DlgQIAK78HXOJdQKjinS6WfyOEGI3vTRvordELfpzPkqfTdEgT?=
 =?iso-8859-1?Q?dkUPDz6u4yPfjrrEK2rMslyP2eq5tR7OEax/iiIaNeTwNdGltSKd3BJHw7?=
 =?iso-8859-1?Q?KD7YqmRr2oeA7bDi3H2HELwcQ8dphKBqWXqwR8sED5KJqB/AJPLHRBNlFf?=
 =?iso-8859-1?Q?7xxY/QBjLBrfxzXYYIKfb+xEOnY+t1SqB10LluB13Ps5hAvVYbbo8D1awd?=
 =?iso-8859-1?Q?CEOPZSUHkGDpSdttryVgS6PozlqatNhsdgkkpjbH9BYNqY7vwtdD4ocKA6?=
 =?iso-8859-1?Q?JTB273HyosPg3pOH8sRkCmhu8ebN3mdGXaKyFHoz/Tzn61QN8iiectOQJs?=
 =?iso-8859-1?Q?wq6aZ1PHwL6MrrSaQjF1LUTBIDiNOSzzjlNGdS9uGsPEHTsZ7fTSIoxE5Z?=
 =?iso-8859-1?Q?EAhx7WYNFSSItbxIl6ivm/Eytzcft3oRy2jQxhiwaHtWnowYAW35ZfSeQ6?=
 =?iso-8859-1?Q?lKVCxgKYztTiz89tnLU0cgdnNvQAgftkrA7RNNCwPpMAAVWqGW9YFDgRM/?=
 =?iso-8859-1?Q?Rv5skJ2Zpqj6VSlEg94OfGM/s7fxU/vRG4j8HeR39etTG7//AwGOziFB9H?=
 =?iso-8859-1?Q?0dODKm63F+7NLD8m1+QJzN/Hln1D50eQPwwGQj4/UKBxzxG/y3S9KCTNap?=
 =?iso-8859-1?Q?PgOAL3gUAicyE91gsCtOWV+Rqv4KHbv2+knk7r9TvOXSIlkb7CQd3RRvyn?=
 =?iso-8859-1?Q?UpBqGAmyPmlkm293sRrGhEs+20P5HxhSnKVeyUA+c+nun5x/cKDzPiH3LC?=
 =?iso-8859-1?Q?mAQ2pYecx7S5SgvYhZaS3J1mS7V0OTKaYyvsubnRRKzaa6xr1I/MNMHYgP?=
 =?iso-8859-1?Q?7TmNuz+e0g2ZEJBkM+uzjNUsHxt9PdNHKmRm92WfVFQLme8mHEaCGP3vyg?=
 =?iso-8859-1?Q?ri8wKTrn2WeQbL/oAe+FMPKiZbpwFQOV0wW0L+z9Hk0DfDDW0WsTAhgPAC?=
 =?iso-8859-1?Q?DmPd+8OC10Af4XP+yZ1PwNLm3DJYAq0WlfwNeKRJyp9OpuVJKPd8EyGP0G?=
 =?iso-8859-1?Q?8iPtOEQA3+zNguQWua2HLUFcbKwJz5KxE1NeNwm0iwRp92Jn2WRoVdo1+H?=
 =?iso-8859-1?Q?75FQ1Pz+UQWWx7HajbP3ZqzTYi3mArZ5vQgTUbAwHuM6LETU8iaiGRyZck?=
 =?iso-8859-1?Q?zO1CVmbmpXl2SSk5qJaYApymkgCb9B+mHTHxnbKpsyUgd5l6uRs47pSOy/?=
 =?iso-8859-1?Q?V1h7GqCy7/2Zn9zPY1rJnEmmypRaEeDq62noWzVELYL0dHu3BbhsHURAe8?=
 =?iso-8859-1?Q?tXdqtOmDpE//PovOgxgEohXaExEptQm7LYBwxNU6aJV5ALo/jiXWnEUrHa?=
 =?iso-8859-1?Q?nZ288nXy9pEv0MjUl36z/s70fUBION2e7l5745oPGh3zucpe+CUr0wytVm?=
 =?iso-8859-1?Q?aqWEF+cfe6iA0xcRr2KXHk4OgbTy+BQW/i69hjoUorviCVFyNnwTGTmhJX?=
 =?iso-8859-1?Q?KlAWIeppjxQ54lUrr4qb7IWfSJHoA71OuwBMcULQhrBqnziywnS1UNDdJ1?=
 =?iso-8859-1?Q?VWvq6Ca1FiiSEJB1O2tukCgjMUw46oPIDlyy7qXP8iho3z?=
Content-Type: multipart/alternative;
 boundary="_000_DM6PR12MB3611A1B8F7AA1FE9EB361AC994D42DM6PR12MB3611namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3611.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e18e62ea-c96b-42de-fbb0-08def25ba389
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2026 19:07:33.2271 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BCgUfnXkWUIxyzCnjGimvNZPAVP9aOrz0wQIDr8jKPhtnKTigckzE6I8gNV16DRqSkBkMkeWY1ieaDyznHtk1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8428
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

--_000_DM6PR12MB3611A1B8F7AA1FE9EB361AC994D42DM6PR12MB3611namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

AMD General

One inline comment. With that fixed, the series is

Reviewed-by: Michael Chen <michael.chen@amd.com>

________________________________
From: Liang, Prike <Prike.Liang@amd.com>
Sent: Monday, August 3, 2026 11:16 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Chri=
stian.Koenig@amd.com>; Chen, Michael <Michael.Chen@amd.com>; Liu, Shaoyun <=
Shaoyun.Liu@amd.com>; Liang, Prike <Prike.Liang@amd.com>
Subject: [PATCH v3 1/2] drm/amdgpu/mes: refactor the amdgpu_mes_alloc/free_=
proc|gang()

- Unify amdgpu_mes_alloc/free_proc|gang_ctx_index to provide
  centralized RS64mem bitmap management for both KGD and KFD.
- Retrieve the bitmap bit for userq contex index based on a
  per process granularity.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c    | 28 +++++++++++-----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h    |  8 +++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c  |  6 +++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h  |  3 ++-
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 26 ++++++++++++++------
 5 files changed, 45 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_mes.c
index 9af7c97af5be..5998e05ecd79 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -1040,13 +1040,13 @@ int amdgpu_mes_rs64mem_setup_bitmaps(struct amdgpu_=
mes *mes)
  * amdgpu_mes_alloc_proc_ctx_index - allocate a process context slot
  *
  * @mes: MES instance
- * @queue: Usermode queue receiving the allocated process context index
+ * @index: the allocated process context index
  *
  * Returns 0 on success, -ENOSPC if all slots are used, or
  * -EOPNOTSUPP if RS64 local memory is unavailable.
  */
 int amdgpu_mes_alloc_proc_ctx_index(struct amdgpu_mes *mes,
-                                   struct amdgpu_usermode_queue *queue)
+                                   uint32_t *index)
 {
         unsigned long bit;

@@ -1061,7 +1061,7 @@ int amdgpu_mes_alloc_proc_ctx_index(struct amdgpu_mes=
 *mes,
                 return -ENOSPC;
         }
         set_bit(bit, mes->proc_ctx_bitmap);
-       queue->proc_ctx_array_index =3D (uint32_t)bit;
+       *index =3D (uint32_t)bit;
         amdgpu_mes_unlock(mes);

         return 0;
@@ -1071,18 +1071,18 @@ int amdgpu_mes_alloc_proc_ctx_index(struct amdgpu_m=
es *mes,
   * amdgpu_mes_free_proc_ctx_index - free a process context slot
   *
   * @mes: MES instance
-  * @queue: Usermode queue whose process context index is released
+  * @index: process context index is released
   */
 void amdgpu_mes_free_proc_ctx_index(struct amdgpu_mes *mes,
-                                   struct amdgpu_usermode_queue *queue)
+                                   uint32_t index)
 {
         if (!mes->use_rs64mem || !mes->proc_ctx_bitmap)
                 return;
-       if (queue->proc_ctx_array_index >=3D mes->proc_ctx_array_size)
+       if (index >=3D mes->proc_ctx_array_size)
                 return;

         amdgpu_mes_lock(mes);
-       clear_bit(queue->proc_ctx_array_index, mes->proc_ctx_bitmap);
+       clear_bit(index, mes->proc_ctx_bitmap);
         amdgpu_mes_unlock(mes);
 }

@@ -1090,13 +1090,13 @@ void amdgpu_mes_free_proc_ctx_index(struct amdgpu_m=
es *mes,
   * amdgpu_mes_alloc_gang_ctx_index - allocate a gang context slot
   *
   * @mes: MES instance
-  * @queue: Usermode queue receiving the allocated gang context index
+  * @index: the allocated gang context index
   *
   * Returns 0 on success, -ENOSPC if all slots are used, or
   * -EOPNOTSUPP if RS64 local memory is unavailable.
   */
 int amdgpu_mes_alloc_gang_ctx_index(struct amdgpu_mes *mes,
-                                   struct amdgpu_usermode_queue *queue)
+                                   uint32_t *index)
 {
         unsigned long bit;

@@ -1111,7 +1111,7 @@ int amdgpu_mes_alloc_gang_ctx_index(struct amdgpu_mes=
 *mes,
                 return -ENOSPC;
         }
         set_bit(bit, mes->gang_ctx_bitmap);
-       queue->gang_ctx_array_index =3D bit;
+       *index =3D bit;
         amdgpu_mes_unlock(mes);

         return 0;
@@ -1121,18 +1121,18 @@ int amdgpu_mes_alloc_gang_ctx_index(struct amdgpu_m=
es *mes,
   * amdgpu_mes_free_gang_ctx_index - free a gang context slot
   *
   * @mes: MES instance
-  * @queue: Usermode queue whose gang context index is released
+  * @index: gang context index is released
   */
 void amdgpu_mes_free_gang_ctx_index(struct amdgpu_mes *mes,
-                                   struct amdgpu_usermode_queue *queue)
+                                   uint32_t index)
 {
         if (!mes->use_rs64mem || !mes->gang_ctx_bitmap)
                 return;
-       if (queue->gang_ctx_array_index >=3D mes->gang_ctx_array_size)
+       if (index >=3D mes->gang_ctx_array_size)
                 return;

         amdgpu_mes_lock(mes);
-       clear_bit(queue->gang_ctx_array_index, mes->gang_ctx_bitmap);
+       clear_bit(index, mes->gang_ctx_bitmap);
         amdgpu_mes_unlock(mes);
 }

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_mes.h
index c67db2d6e122..977c057dcce8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -636,11 +636,11 @@ int amdgpu_mes_rs64mem_init(struct amdgpu_mes *mes);
 void amdgpu_mes_rs64mem_fini(struct amdgpu_mes *mes);
 int amdgpu_mes_rs64mem_setup_bitmaps(struct amdgpu_mes *mes);
 int amdgpu_mes_alloc_proc_ctx_index(struct amdgpu_mes *mes,
-                                   struct amdgpu_usermode_queue *queue);
+                                   uint32_t *index);
 void amdgpu_mes_free_proc_ctx_index(struct amdgpu_mes *mes,
-                                   struct amdgpu_usermode_queue *queue);
+                                   uint32_t index);
 int amdgpu_mes_alloc_gang_ctx_index(struct amdgpu_mes *mes,
-                                   struct amdgpu_usermode_queue *queue);
+                                   uint32_t *index);
 void amdgpu_mes_free_gang_ctx_index(struct amdgpu_mes *mes,
-                                   struct amdgpu_usermode_queue *queue);
+                                   uint32_t index);
 #endif /* __AMDGPU_MES_H__ */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_userq.c
index 571413c9a611..5dd4fe258cdb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -1244,6 +1244,7 @@ int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *us=
erq_mgr, struct drm_file *f
         xa_init_flags(&userq_mgr->userq_xa, XA_FLAGS_ALLOC);
         userq_mgr->adev =3D adev;
         userq_mgr->file =3D file_priv;
+       userq_mgr->proc_ctx_allocated =3D false;
         mutex_init(&userq_mgr->proc_ctx_lock);

         INIT_DELAYED_WORK(&userq_mgr->resume_work, amdgpu_userq_restore_wo=
rker);
@@ -1272,6 +1273,7 @@ void amdgpu_userq_mgr_cancel_resume(struct amdgpu_use=
rq_mgr *userq_mgr)

 void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr)
 {
+       struct amdgpu_mes *mes =3D &userq_mgr->adev->mes;
         struct amdgpu_usermode_queue *queue;
         unsigned long queue_id =3D 0;

@@ -1298,6 +1300,10 @@ void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *=
userq_mgr)
          */
         cancel_work_sync(&userq_mgr->reset_work);

+       if (userq_mgr->proc_ctx_allocated) {
+               amdgpu_mes_free_proc_ctx_index(mes, userq_mgr->proc_ctx_arr=
ay_index);
+               userq_mgr->proc_ctx_allocated =3D false;
+       }
         amdgpu_bo_free_kernel(&userq_mgr->proc_ctx_obj.obj,
                               &userq_mgr->proc_ctx_obj.gpu_addr,
                               &userq_mgr->proc_ctx_obj.cpu_ptr);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_userq.h
index 402dc2816f04..4dcf6151de6a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -101,7 +101,6 @@ struct amdgpu_usermode_queue {
                 u64 va_array[6];
         } userq_vas;

-       uint32_t        proc_ctx_array_index;
         uint32_t        gang_ctx_array_index;
 };

@@ -133,6 +132,8 @@ struct amdgpu_userq_mgr {
         struct mutex                    proc_ctx_lock;
         struct amdgpu_userq_obj         proc_ctx_obj;

+       bool                            proc_ctx_allocated;
+       uint32_t                        proc_ctx_array_index;
         /**
          * @reset_work:
          *
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/a=
md/amdgpu/mes_userqueue.c
index a914198a4d62..ae403bb89441 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -143,10 +143,24 @@ static int mes_userq_map(struct amdgpu_usermode_queue=
 *queue)
         queue_input.doorbell_offset =3D userq_props->doorbell_index;
         queue_input.page_table_base_addr =3D amdgpu_gmc_pd_addr(queue->vm-=
>root.bo);
         queue_input.wptr_mc_addr =3D queue->wptr_obj.gpu_addr;
+
         if (mes->use_rs64mem) {
-               amdgpu_mes_alloc_proc_ctx_index(mes, queue);
-               queue_input.process_context_array_index =3D queue->proc_ctx=
_array_index;
-               amdgpu_mes_alloc_gang_ctx_index(mes, queue);
+                if (!uq_mgr->proc_ctx_allocated) {
+                       r =3D amdgpu_mes_alloc_proc_ctx_index(mes, &uq_mgr-=
>proc_ctx_array_index);
+                       if (r) {
+                               DRM_ERROR("Failed to allocate userq process=
 index err:%d\n", r);
+                               return r;
+                       }
+                       uq_mgr->proc_ctx_allocated =3D true;
+               }
+
+               r =3D amdgpu_mes_alloc_gang_ctx_index(mes, &queue->gang_ctx=
_array_index);
+               if (r) {
+                       DRM_ERROR("Failed to allocate userq gang index err:=
%d\n", r);
+                       amdgpu_mes_free_gang_ctx_index(mes, queue->gang_ctx=
_array_index);

No need to call free on failure, otherwise it will free index '0' accidenta=
lly.

+                       return r;
+               }
+               queue_input.process_context_array_index =3D uq_mgr->proc_ct=
x_array_index;
                 queue_input.gang_context_array_index =3D queue->gang_ctx_a=
rray_index;
         }
         amdgpu_mes_lock(&adev->mes);
@@ -179,10 +193,8 @@ static int mes_userq_unmap(struct amdgpu_usermode_queu=
e *queue)
         amdgpu_mes_lock(&adev->mes);
         r =3D adev->mes.funcs->remove_hw_queue(&adev->mes, &queue_input);
         amdgpu_mes_unlock(&adev->mes);
-       if (mes->use_rs64mem) {
-               amdgpu_mes_free_proc_ctx_index(mes, queue);
-               amdgpu_mes_free_gang_ctx_index(mes, queue);
-       }
+       if (mes->use_rs64mem)
+               amdgpu_mes_free_gang_ctx_index(mes, queue->gang_ctx_array_i=
ndex);
         if (r)
                 DRM_ERROR("Failed to unmap queue in HW, err (%d)\n", r);
         return r;
--
2.34.1


--_000_DM6PR12MB3611A1B8F7AA1FE9EB361AC994D42DM6PR12MB3611namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<div>
<div style=3D"font-family: Calibri; text-align: left; color: rgb(0, 0, 255)=
; margin-left: 5pt; font-size: 10pt;">
AMD General</div>
<br>
</div>
One inline comment. With that fixed, the series is</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Reviewed-by: Michael Chen &lt;michael.chen@amd.com&gt;</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<hr style=3D"display: inline-block; width: 98%;">
<div id=3D"divRplyFwdMsg">
<div style=3D"direction: ltr; font-family: Calibri, sans-serif; font-size: =
11pt; color: rgb(0, 0, 0);">
<b>From:</b> Liang, Prike &lt;Prike.Liang@amd.com&gt;<br>
<b>Sent:</b> Monday, August 3, 2026 11:16 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Koenig, Ch=
ristian &lt;Christian.Koenig@amd.com&gt;; Chen, Michael &lt;Michael.Chen@am=
d.com&gt;; Liu, Shaoyun &lt;Shaoyun.Liu@amd.com&gt;; Liang, Prike &lt;Prike=
.Liang@amd.com&gt;<br>
<b>Subject:</b> [PATCH v3 1/2] drm/amdgpu/mes: refactor the amdgpu_mes_allo=
c/free_proc|gang()</div>
<div style=3D"direction: ltr;">&nbsp;</div>
</div>
<div style=3D"font-size: 11pt;">- Unify amdgpu_mes_alloc/free_proc|gang_ctx=
_index to provide<br>
&nbsp; centralized RS64mem bitmap management for both KGD and KFD.<br>
- Retrieve the bitmap bit for userq contex index based on a<br>
&nbsp; per process granularity.<br>
<br>
Signed-off-by: Prike Liang &lt;Prike.Liang@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c&nbsp;&nbsp;&nbsp; | 28 ++++++=
+++++-----------<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h&nbsp;&nbsp;&nbsp; |&nbsp; 8 +=
++----<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c&nbsp; |&nbsp; 6 +++++<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h&nbsp; |&nbsp; 3 ++-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 26 ++++++++++++++------<=
br>
&nbsp;5 files changed, 45 insertions(+), 26 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_mes.c<br>
index 9af7c97af5be..5998e05ecd79 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c<br>
@@ -1040,13 +1040,13 @@ int amdgpu_mes_rs64mem_setup_bitmaps(struct amdgpu_=
mes *mes)<br>
&nbsp; * amdgpu_mes_alloc_proc_ctx_index - allocate a process context slot<=
br>
&nbsp; *<br>
&nbsp; * @mes: MES instance<br>
- * @queue: Usermode queue receiving the allocated process context index<br=
>
+ * @index: the allocated process context index<br>
&nbsp; *<br>
&nbsp; * Returns 0 on success, -ENOSPC if all slots are used, or<br>
&nbsp; * -EOPNOTSUPP if RS64 local memory is unavailable.<br>
&nbsp; */<br>
&nbsp;int amdgpu_mes_alloc_proc_ctx_index(struct amdgpu_mes *mes,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_userm=
ode_queue *queue)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t *index)<br=
>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long bit;<br>
&nbsp;<br>
@@ -1061,7 +1061,7 @@ int amdgpu_mes_alloc_proc_ctx_index(struct amdgpu_mes=
 *mes,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -ENOSPC;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; set_bit(bit, mes-&gt;proc_=
ctx_bitmap);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; queue-&gt;proc_ctx_array_index =3D (u=
int32_t)bit;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *index =3D (uint32_t)bit;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_mes_unlock(mes);<br=
>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
@@ -1071,18 +1071,18 @@ int amdgpu_mes_alloc_proc_ctx_index(struct amdgpu_m=
es *mes,<br>
&nbsp;&nbsp; * amdgpu_mes_free_proc_ctx_index - free a process context slot=
<br>
&nbsp;&nbsp; *<br>
&nbsp;&nbsp; * @mes: MES instance<br>
-&nbsp; * @queue: Usermode queue whose process context index is released<br=
>
+&nbsp; * @index: process context index is released<br>
&nbsp;&nbsp; */<br>
&nbsp;void amdgpu_mes_free_proc_ctx_index(struct amdgpu_mes *mes,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_userm=
ode_queue *queue)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t index)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!mes-&gt;use_rs64mem |=
| !mes-&gt;proc_ctx_bitmap)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (queue-&gt;proc_ctx_array_index &g=
t;=3D mes-&gt;proc_ctx_array_size)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (index &gt;=3D mes-&gt;proc_ctx_ar=
ray_size)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_mes_lock(mes);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; clear_bit(queue-&gt;proc_ctx_array_in=
dex, mes-&gt;proc_ctx_bitmap);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; clear_bit(index, mes-&gt;proc_ctx_bit=
map);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_mes_unlock(mes);<br=
>
&nbsp;}<br>
&nbsp;<br>
@@ -1090,13 +1090,13 @@ void amdgpu_mes_free_proc_ctx_index(struct amdgpu_m=
es *mes,<br>
&nbsp;&nbsp; * amdgpu_mes_alloc_gang_ctx_index - allocate a gang context sl=
ot<br>
&nbsp;&nbsp; *<br>
&nbsp;&nbsp; * @mes: MES instance<br>
-&nbsp; * @queue: Usermode queue receiving the allocated gang context index=
<br>
+&nbsp; * @index: the allocated gang context index<br>
&nbsp;&nbsp; *<br>
&nbsp;&nbsp; * Returns 0 on success, -ENOSPC if all slots are used, or<br>
&nbsp;&nbsp; * -EOPNOTSUPP if RS64 local memory is unavailable.<br>
&nbsp;&nbsp; */<br>
&nbsp;int amdgpu_mes_alloc_gang_ctx_index(struct amdgpu_mes *mes,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_userm=
ode_queue *queue)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t *index)<br=
>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long bit;<br>
&nbsp;<br>
@@ -1111,7 +1111,7 @@ int amdgpu_mes_alloc_gang_ctx_index(struct amdgpu_mes=
 *mes,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -ENOSPC;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; set_bit(bit, mes-&gt;gang_=
ctx_bitmap);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; queue-&gt;gang_ctx_array_index =3D bi=
t;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *index =3D bit;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_mes_unlock(mes);<br=
>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
@@ -1121,18 +1121,18 @@ int amdgpu_mes_alloc_gang_ctx_index(struct amdgpu_m=
es *mes,<br>
&nbsp;&nbsp; * amdgpu_mes_free_gang_ctx_index - free a gang context slot<br=
>
&nbsp;&nbsp; *<br>
&nbsp;&nbsp; * @mes: MES instance<br>
-&nbsp; * @queue: Usermode queue whose gang context index is released<br>
+&nbsp; * @index: gang context index is released<br>
&nbsp;&nbsp; */<br>
&nbsp;void amdgpu_mes_free_gang_ctx_index(struct amdgpu_mes *mes,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_userm=
ode_queue *queue)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t index)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!mes-&gt;use_rs64mem |=
| !mes-&gt;gang_ctx_bitmap)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (queue-&gt;gang_ctx_array_index &g=
t;=3D mes-&gt;gang_ctx_array_size)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (index &gt;=3D mes-&gt;gang_ctx_ar=
ray_size)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_mes_lock(mes);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; clear_bit(queue-&gt;gang_ctx_array_in=
dex, mes-&gt;gang_ctx_bitmap);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; clear_bit(index, mes-&gt;gang_ctx_bit=
map);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_mes_unlock(mes);<br=
>
&nbsp;}<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_mes.h<br>
index c67db2d6e122..977c057dcce8 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h<br>
@@ -636,11 +636,11 @@ int amdgpu_mes_rs64mem_init(struct amdgpu_mes *mes);<=
br>
&nbsp;void amdgpu_mes_rs64mem_fini(struct amdgpu_mes *mes);<br>
&nbsp;int amdgpu_mes_rs64mem_setup_bitmaps(struct amdgpu_mes *mes);<br>
&nbsp;int amdgpu_mes_alloc_proc_ctx_index(struct amdgpu_mes *mes,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_userm=
ode_queue *queue);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t *index);<b=
r>
&nbsp;void amdgpu_mes_free_proc_ctx_index(struct amdgpu_mes *mes,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_userm=
ode_queue *queue);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t index);<br=
>
&nbsp;int amdgpu_mes_alloc_gang_ctx_index(struct amdgpu_mes *mes,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_userm=
ode_queue *queue);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t *index);<b=
r>
&nbsp;void amdgpu_mes_free_gang_ctx_index(struct amdgpu_mes *mes,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_userm=
ode_queue *queue);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t index);<br=
>
&nbsp;#endif /* __AMDGPU_MES_H__ */<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_userq.c<br>
index 571413c9a611..5dd4fe258cdb 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c<br>
@@ -1244,6 +1244,7 @@ int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *us=
erq_mgr, struct drm_file *f<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; xa_init_flags(&amp;userq_m=
gr-&gt;userq_xa, XA_FLAGS_ALLOC);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; userq_mgr-&gt;adev =3D ade=
v;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; userq_mgr-&gt;file =3D fil=
e_priv;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; userq_mgr-&gt;proc_ctx_allocated =3D =
false;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_init(&amp;userq_mgr-=
&gt;proc_ctx_lock);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; INIT_DELAYED_WORK(&amp;use=
rq_mgr-&gt;resume_work, amdgpu_userq_restore_worker);<br>
@@ -1272,6 +1273,7 @@ void amdgpu_userq_mgr_cancel_resume(struct amdgpu_use=
rq_mgr *userq_mgr)<br>
&nbsp;<br>
&nbsp;void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr)<br>
&nbsp;{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_mes *mes =3D &amp;userq=
_mgr-&gt;adev-&gt;mes;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_usermode_que=
ue *queue;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long queue_id =3D=
 0;<br>
&nbsp;<br>
@@ -1298,6 +1300,10 @@ void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *=
userq_mgr)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cancel_work_sync(&amp;user=
q_mgr-&gt;reset_work);<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (userq_mgr-&gt;proc_ctx_allocated)=
 {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_mes_free_proc_ctx_index(mes, userq_mgr-&gt;proc_ctx_array=
_index);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; userq_mgr-&gt;proc_ctx_allocated =3D false;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_bo_free_kernel(&amp=
;userq_mgr-&gt;proc_ctx_obj.obj,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;userq_mgr-&gt;proc_ctx_obj.gpu_addr,<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;userq_mgr-&gt;proc_ctx_obj.cpu_ptr);<br=
>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_userq.h<br>
index 402dc2816f04..4dcf6151de6a 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h<br>
@@ -101,7 +101,6 @@ struct amdgpu_usermode_queue {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; u64 va_array[6];<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } userq_vas;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; proc_ctx_array_index;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; gang_ctx_array_index;<br>
&nbsp;};<br>
&nbsp;<br>
@@ -133,6 +132,8 @@ struct amdgpu_userq_mgr {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct mutex&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; proc_ctx_lock;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_userq_obj&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; proc_ctx_obj;<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; proc_ctx_allocated;<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; proc_ctx_array_index;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /**<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * @reset_work:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/a=
md/amdgpu/mes_userqueue.c<br>
index a914198a4d62..ae403bb89441 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c<br>
@@ -143,10 +143,24 @@ static int mes_userq_map(struct amdgpu_usermode_queue=
 *queue)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; queue_input.doorbell_offse=
t =3D userq_props-&gt;doorbell_index;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; queue_input.page_table_bas=
e_addr =3D amdgpu_gmc_pd_addr(queue-&gt;vm-&gt;root.bo);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; queue_input.wptr_mc_addr =
=3D queue-&gt;wptr_obj.gpu_addr;<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (mes-&gt;use_rs64mem) {=
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_mes_alloc_proc_ctx_index(mes, queue);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; queue_input.process_context_array_index =3D queue-&gt;proc_ctx_a=
rray_index;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_mes_alloc_gang_ctx_index(mes, queue);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; if (!uq_mgr-&gt;proc_ctx_allocated) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_mes=
_alloc_proc_ctx_index(mes, &amp;uq_mgr-&gt;proc_ctx_array_index);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;Failed to allocate userq pr=
ocess index err:%d\n&quot;, r);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uq_mgr-&gt;proc_=
ctx_allocated =3D true;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; r =3D amdgpu_mes_alloc_gang_ctx_index(mes, &amp;queue-&gt;gang_c=
tx_array_index);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (r) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;=
Failed to allocate userq gang index err:%d\n&quot;, r);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_mes_free_=
gang_ctx_index(mes, queue-&gt;gang_ctx_array_index);</div>
<div style=3D"font-size: 11pt;"><br>
</div>
<div class=3D"elementToProof" style=3D"font-size: 11pt;">No need to call fr=
ee on failure, otherwise it will free index '0' accidentally.</div>
<div class=3D"elementToProof" style=3D"font-size: 11pt;"><br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; queue_input.process_context_array_index =3D uq_mgr-&gt;proc_ctx_=
array_index;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; queue_input.gang_context_array_index =3D queue-&gt;ga=
ng_ctx_array_index;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_mes_lock(&amp;adev-=
&gt;mes);<br>
@@ -179,10 +193,8 @@ static int mes_userq_unmap(struct amdgpu_usermode_queu=
e *queue)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_mes_lock(&amp;adev-=
&gt;mes);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D adev-&gt;mes.funcs-&=
gt;remove_hw_queue(&amp;adev-&gt;mes, &amp;queue_input);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_mes_unlock(&amp;ade=
v-&gt;mes);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (mes-&gt;use_rs64mem) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_mes_free_proc_ctx_index(mes, queue);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_mes_free_gang_ctx_index(mes, queue);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (mes-&gt;use_rs64mem)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_mes_free_gang_ctx_index(mes, queue-&gt;gang_ctx_array_ind=
ex);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;Failed to unmap queue in HW, err (%d)=
\n&quot;, r);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
--<br>
2.34.1<br>
<br>
</div>
</body>
</html>

--_000_DM6PR12MB3611A1B8F7AA1FE9EB361AC994D42DM6PR12MB3611namp_--
