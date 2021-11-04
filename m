Return-Path: <SRS0=uIzi=PX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6098C433F5
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Nov 2021 23:36:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AC8B61220
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Nov 2021 23:36:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5AC8B61220
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DEB4873687;
	Thu,  4 Nov 2021 23:36:40 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2064.outbound.protection.outlook.com [40.107.93.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E8B3F73687
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Nov 2021 23:36:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aETZjqJvjT2Mv+Zs8rAS4Fojm94G0f3QmGAkTtKA/D4xmPW2j1SvVcRXiMPLvl6mRKZSe7g6jy+8rMkIzVmJhqqDksBoxlzimm/VKawO1mhOz2ZqWWhG+0C8+oE02amTxS5Zw7lusZfaib1pDBEnfBBKW8V5Y92dqHGFxf99frxKWTueiLJWtC6xgPzwPQCS4FXR4kKiBP5c6OpT2SdNEX8gFR9HXivtKNA4Neo5clfxJcK6raRUqiea+RnAnfhO5uE/IsV71YK5LnmZkZ3T7O7rnCuvY6uiyda6oG9OFd5IACPl1paokOrdAfh3PKuCl8P4ZS/RjnuPXZ2TLNCv5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yBJns5xcyPM45E/Rom+plVOjHQygWkyo/wotddPCfR8=;
 b=M0tJ+dYrfrXEak+CR24P8xjrT/Z9+Cjk2Det8aoYlDGbVRE1nTnLsqqwfhLtpAyFJq9V/tphmeRLUhKMLuKyYzIUSDcQ3ywp69oXukdlPksWgdgGht6xccmVHLMIhttmjPWEArM4riqH6m6B1LYWiQg9e9na5UBCkDnMABJdbYnVuNh/Qwd/CXn7kf4dK4gIJH8d0f9Y1Qn0IyMkKtYkXufCu8919SXUF4GjeAV4zjXoFbvYQkQ6PkmjOn+JkqUdK0VsmZtd1A642xgG1Aw/fCcSdaEg6L8QptoaumlA8pl5h1Poikat4M4W8JaXZGiGiIIeOHjtEMxaWSMgbiTbcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yBJns5xcyPM45E/Rom+plVOjHQygWkyo/wotddPCfR8=;
 b=p7ouiXnu+PqecB7ily9HSvcuMxsmmyk/WKMjDg1QJw3pwOLjZnLzhOMSvE8B+7tdAUPkqvAcQzRv95JyB7qVhz81EB7xDxRBJKuptZMUFnXOsmu/mPifYai6oEJ1yrjZVcKcQ3KLmMF7o3icRh1HI7j1H1VY4a9btL9xkjBn0qo=
Received: from SA0PR12MB4399.namprd12.prod.outlook.com (2603:10b6:806:98::17)
 by SN6PR12MB4717.namprd12.prod.outlook.com (2603:10b6:805:e2::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.18; Thu, 4 Nov
 2021 23:36:35 +0000
Received: from SA0PR12MB4399.namprd12.prod.outlook.com
 ([fe80::91ba:8d66:bd75:2ac2]) by SA0PR12MB4399.namprd12.prod.outlook.com
 ([fe80::91ba:8d66:bd75:2ac2%6]) with mapi id 15.20.4669.013; Thu, 4 Nov 2021
 23:36:35 +0000
From: "Errabolu, Ramesh" <Ramesh.Errabolu@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/1] drm/amdgpu: Fix dangling kfd_bo pointer for shared BOs
Thread-Topic: [PATCH 1/1] drm/amdgpu: Fix dangling kfd_bo pointer for shared
 BOs
Thread-Index: AQHX0dB9H0ASNDf9IkS2jhZekQjKJqv0BY4w
Date: Thu, 4 Nov 2021 23:36:35 +0000
Message-ID: <SA0PR12MB43999A75CCC42BC4A67BF201E38D9@SA0PR12MB4399.namprd12.prod.outlook.com>
References: <20211104230513.1531770-1-Felix.Kuehling@amd.com>
In-Reply-To: <20211104230513.1531770-1-Felix.Kuehling@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 806c8f30-f205-4717-7ccf-08d99febf0c4
x-ms-traffictypediagnostic: SN6PR12MB4717:
x-microsoft-antispam-prvs: <SN6PR12MB4717D0CBC664CE9F3FD68409E38D9@SN6PR12MB4717.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2657;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Am2p/t31HFlcgKAD62cWIQ2fUXvfJWnE1ri2kuHqmG6pwWjsP33wLFCZkPhFq1U7xzjPf7LAxL2fO+Ib7CECKTT0+IAnlbWDGjKXWvrRfCTLiDzl98Rm5CTBFmWvAuD9tMrUH5rd61br209De9vwh6mf2dnE/ws/fwNbhvwIe6BK2KjqnV1lvvrOtHPlZ/2nbq2RjB92rxPiGIr8BBVSITr29lSrMV9uMfeJ8UNsTC+b8bctfKux1gvFrH/7KoNqqNotCaotqOsFo1IZcpERUZKa/QZPK2OQWN6AXKWYdYvlL25i0O7AX4imLtTfgz2fr1VgGCxUoYzcu1aol+hH7x7XDzpvM0XBoz8aiYrEl+9RdzOO0t1rwX+YruOgPIc8SDMsGTQlvfntBJOMp2oS/cOfGZIRI02CX0HMbUtFEAzjeQK8+RLlapsLDGqKegt8HLbbv5QLm/c8ZzzlVro5HXeCYudRmtrYcu4WyJZ+wQcBl0BW2WcvEEQb6h7dzWbVv9XY76H0gaXKXZZ12ECTthnXHwLTFuLjnN4GKGZ1VR0bMhihUgCwG8QbL8r5YCwA7w+x/DY8Ziqt3IGsGc1Y+xSSkTLS8v3elVTF1Q2YfstiQZe8BczMCOWIKJIJisxl5BIwsFx/PHpt/x5PfQK2tr4wqRm5SADWYhuECAWpGFdSxLHrXUAo/K348Cc/+ts2brGzZHZw+zetnASlwoRIYQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB4399.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(38070700005)(186003)(52536014)(8676002)(122000001)(83380400001)(38100700002)(26005)(2906002)(55016002)(6506007)(5660300002)(110136005)(8936002)(71200400001)(508600001)(316002)(86362001)(66556008)(9686003)(64756008)(66476007)(76116006)(7696005)(66446008)(33656002)(66946007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?A8tFt9s13cldjxlHRrQ2ym3tywM+Ihv/7XCCBnBfs+sHWfuq/Pdo2aPyPu8d?=
 =?us-ascii?Q?ziuH3xp2mEWuezk1fXpXlUniEYXahve2nfO071tKUmQyfZteUBf0CL1jaw+v?=
 =?us-ascii?Q?seNbSlTbXe2oyOCV97sjJLjO3FQn76rXuIMRvIH3L4iXOANJ50kPRvv0udUi?=
 =?us-ascii?Q?CGVMqr8Iud31MNDpeM8C556NDZzYBL0m7v4DhNtb3/zh4uAZgg9KBsPODU2o?=
 =?us-ascii?Q?J7GIzA0Y+/GHqnL2Yw3CvdwjglBbxvnkMJlJ0gT+6p0qXC8SwDNi7C2ytZDA?=
 =?us-ascii?Q?1uCKbA8QYRwgLEA63Z51OWkAKSOyyXK5zfgr9mLR0e2PVUWKtge1ii1NnVuQ?=
 =?us-ascii?Q?YFbOvEjZIc3qRHvwKcV312uYIKDzkwUqDcUCi7qiVXf96GjxAaNrVyfq96Aj?=
 =?us-ascii?Q?Db8JRo7pUEDDfGlnYAzIiNEAeCM4pPQBw0EjkN1kFbTf/lD8NM0buWkYfQTW?=
 =?us-ascii?Q?0K30jOr0kqp0M1L6HSy6YzEkpbgi4r5IO46ZFAciF15WLmiwXewx4FH9WfiV?=
 =?us-ascii?Q?T8S7wpxyjLEtpsgK7sK3DimArpH2MYs/WuYz+Td7AVHUS4UcdR9NNDcYoQEf?=
 =?us-ascii?Q?yABqAq7jFqvoJpX5S6WMIgrobWeU9ff0Om6yBTBbG1rXxnLTkzH1awC45s/W?=
 =?us-ascii?Q?xaAcAZwA5n8XV3ci2YCYhTVJUgNIkaPdZm5yk6Ni+OMQDXaiqZV3SMF4oHGO?=
 =?us-ascii?Q?uJH5CGOUUfWg7beLCtaGjOUH8Mmwp0xBb3sZzP4TYCxppUtUic0k4Ad0kkox?=
 =?us-ascii?Q?s3HQy0lIq4uvwLFu+x5RGppGBsQ21ZXmcE+u7KnCHAkfwHKYzY2qnwtA0Nvj?=
 =?us-ascii?Q?Lij0EBUNmIBORO6yZz/MfAQ//R6Oy5xD/17j23a7A1/rsANqykHNSg/Pehxi?=
 =?us-ascii?Q?aWu1AMgem/8qNYUxOU5OIgGHNGv30TSb+MT2J5a9fcEbf4Lp3i3bBP9Co9bQ?=
 =?us-ascii?Q?uXR33BukNY9ewsCLk7Co+Tqyz/jY/se4o3hiDg8vwr+97ti//kxHdTQFgo8Z?=
 =?us-ascii?Q?l8iC22vN1q/Ff83JyplS93LJrmoRK4O7kieMD4WeaVqfGzIABsllMYDG1dDE?=
 =?us-ascii?Q?zUJNWlPTiYcHbjqePUGviOY6ehGgQ2kDt3qxO17KUQDcR/7InPvC4jWhmmlD?=
 =?us-ascii?Q?7jSyVZ22G2+2Ds6Y8lhPFXSs3v66nSqNyEWQxQb9J5nEbDYxJ+Py66YooCg3?=
 =?us-ascii?Q?5EvGoo/D2emMVaTqLzKZAHgZwi0FX5rMcXj1Of/g9EDTWPBDRVlqdgOis4mo?=
 =?us-ascii?Q?k1UW8Ev0Su5vIxyIlw+ysT0Xa+vLizUOd65hxzA0zD6EXo5MR8RSIiwjhbxU?=
 =?us-ascii?Q?eK1I/52hjDwlXt1uO6M9t6a6sU4VDRFnjjtuOd5BVBZRk78wsFINYZLcXcah?=
 =?us-ascii?Q?ZfIlACwiU/Nl3Tsl93c16ichLu7naW/6z6AaTVXEfpuM5t3OF/nN0xFAug5M?=
 =?us-ascii?Q?ndF2OQc2AudT0+SWrg/Entord5+ymFfcAYLeO1nmXAUyStwLG1r2k59yWaIZ?=
 =?us-ascii?Q?xJWhFdgonCoyugyOlb5C6PjrOQkG4tWPaNHr80Inav5HDSf6dGkk0Xt9Ouon?=
 =?us-ascii?Q?W43m2XAg8rjj2XXh1qZLlgHDpJJ1Xcd4jnVvQxu4QxdDrCjtJtqcvu7dB39Q?=
 =?us-ascii?Q?w8c5cfk/KQLhKfYjqRZEmTs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4399.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 806c8f30-f205-4717-7ccf-08d99febf0c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2021 23:36:35.3702 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1juNfZaLrNDsuseA8ahotPuh0uQY4YIcJhLDYyoyoVp7L6uYHO555IOlYJJsaHvI/ppzYY+5XXb9qFF/L+azbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB4717
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

Reviewed-By: Ramesh Errabolu <Ramesh.Errabolu@amd.com

-----Original Message-----
From: Kuehling, Felix <Felix.Kuehling@amd.com>=20
Sent: Thursday, November 4, 2021 6:05 PM
To: amd-gfx@lists.freedesktop.org
Cc: Errabolu, Ramesh <Ramesh.Errabolu@amd.com>
Subject: [PATCH 1/1] drm/amdgpu: Fix dangling kfd_bo pointer for shared BOs

If a kfd_bo was shared (e.g. a dmabuf export), the original kfd_bo may be f=
reed when the amdgpu_bo still lives on. Free the kfd_bo struct in the relea=
se_notify callback then the amdgpu_bo is freed.

Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h       |  4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 12 +++++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c       |  2 +-
 3 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_amdkfd.h
index 4accd584886b..5f658823a637 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -307,7 +307,7 @@ void amdgpu_amdkfd_ras_poison_consumption_handler(struc=
t amdgpu_device *adev);  void amdgpu_amdkfd_gpuvm_init_mem_limits(void);
 void amdgpu_amdkfd_gpuvm_destroy_cb(struct amdgpu_device *adev,
 				struct amdgpu_vm *vm);
-void amdgpu_amdkfd_unreserve_memory_limit(struct amdgpu_bo *bo);
+void amdgpu_amdkfd_release_notify(struct amdgpu_bo *bo);
 void amdgpu_amdkfd_reserve_system_mem(uint64_t size);  #else  static inlin=
e @@ -322,7 +322,7 @@ void amdgpu_amdkfd_gpuvm_destroy_cb(struct amdgpu_dev=
ice *adev,  }
=20
 static inline
-void amdgpu_amdkfd_unreserve_memory_limit(struct amdgpu_bo *bo)
+void amdgpu_amdkfd_release_notify(struct amdgpu_bo *bo)
 {
 }
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu=
/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 5174762f0b46..94fccf0b47ad 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -201,7 +201,7 @@ static void unreserve_mem_limit(struct amdgpu_device *a=
dev,
 	spin_unlock(&kfd_mem_limit.mem_limit_lock);
 }
=20
-void amdgpu_amdkfd_unreserve_memory_limit(struct amdgpu_bo *bo)
+void amdgpu_amdkfd_release_notify(struct amdgpu_bo *bo)
 {
 	struct amdgpu_device *adev =3D amdgpu_ttm_adev(bo->tbo.bdev);
 	u32 domain =3D bo->preferred_domains;
@@ -213,6 +213,8 @@ void amdgpu_amdkfd_unreserve_memory_limit(struct amdgpu=
_bo *bo)
 	}
=20
 	unreserve_mem_limit(adev, amdgpu_bo_size(bo), domain, sg);
+
+	kfree(bo->kfd_bo);
 }
=20
=20
@@ -1599,9 +1601,13 @@ int amdgpu_amdkfd_gpuvm_free_memory_of_gpu(
 	drm_vma_node_revoke(&mem->bo->tbo.base.vma_node, drm_priv);
 	if (mem->dmabuf)
 		dma_buf_put(mem->dmabuf);
-	drm_gem_object_put(&mem->bo->tbo.base);
 	mutex_destroy(&mem->lock);
-	kfree(mem);
+
+	/* If this releases the last reference, it will end up calling
+	 * amdgpu_amdkfd_release_notify and kfree the mem struct. That's why
+	 * this needs to be the last call here.
+	 */
+	drm_gem_object_put(&mem->bo->tbo.base);
=20
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_object.c
index 6b25982a9077..156002db24e1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -1279,7 +1279,7 @@ void amdgpu_bo_release_notify(struct ttm_buffer_objec=
t *bo)
 	abo =3D ttm_to_amdgpu_bo(bo);
=20
 	if (abo->kfd_bo)
-		amdgpu_amdkfd_unreserve_memory_limit(abo);
+		amdgpu_amdkfd_release_notify(abo);
=20
 	/* We only remove the fence if the resv has individualized. */
 	WARN_ON_ONCE(bo->type =3D=3D ttm_bo_type_kernel
--
2.32.0

