Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52525C3ABCB
	for <amd-gfx@archiver.kernel.org>; Tue, 13 May 2025 02:45:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CDEF610E2B6;
	Tue, 13 May 2025 02:45:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dZS4y+d0";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2041.outbound.protection.outlook.com [40.107.92.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 17BF110E2B6
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 May 2025 02:45:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SZwODR1/p3CGmbZpIWSqld+DK9gtQEsEe2LS5YJtMVeQPovbrsvCKh1vF54dqpV1rHmMZMTb6XhJ67juMWuKnUnfICARu7dUmjpiPZqM/bEv0CNixjZvv7/B6MLd0VB1eHZYxFAb06B0lmPi3yiZttqNsO5KebkNOz8YxVzyI8JChcWGUtuiNV0l73xrNNmkxPZk3RN/XSyTFo1xcqJR5jL4HRCsnxAiODSprIwMTGYMbMACOamZ+LOuysHZFzsfJTVT4CPYJliDCTE0EWZJa1ZN0KV/QH1zcILYJHOPTv1vC7ujmT8n0j7dlNtDA/MxlZoNKY+hnJpTFvbJejkM9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rg7IhRvVA8tzpmEbOyF5FS8qhM6QfKZ1x28cbrApUgQ=;
 b=WeqGS8SiBkAfBvafmjbd1Io68jSKbeXUlVzItaFbBo+4EOs/2oZZ34OMmiiL03EGCQvmvs/yaGTfIiE+SAwCif0Nz0yiFTiky+XeR9960acF34JgCkhjdfl1vxBEEabY7+2Loh8tIaiectO9vgZomtxLwB1+jg/PktvMGis8i5PV/6Z5mHBiOSj3fE4GaRnzwPR1bHTUfDbNRehvtVQfMYek6cgvNe5R9AkPr9CCZnUwqRDmosr8x/ufau/8U1BvJs63zC4cx6gCf986tkr7uE9PaGTL+E/SWL4HVuCkWW25hBq+J2qQmZVgj0zlPsV15P9CIjsAz9oPpej8g1fZ9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rg7IhRvVA8tzpmEbOyF5FS8qhM6QfKZ1x28cbrApUgQ=;
 b=dZS4y+d0KwIq4SAoXk2LwSsGpGJQj9ogIvtyqJ1Z+CiO3oCjIfNJSXgahenReGyJ74pdcAzqrNX4oXAMyZu+fLp2njTbdQ8XhFJCGYLGI8K8reLeoRiponiXU6YknjxCgTJRyMGcJJCFtG9hyzx6G3Oc415mmBONiGLagSTH4TE=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by SJ1PR12MB6218.namprd12.prod.outlook.com (2603:10b6:a03:457::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Tue, 13 May
 2025 02:45:06 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed%5]) with mapi id 15.20.8722.027; Tue, 13 May 2025
 02:45:06 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: "Liang, Prike" <Prike.Liang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Liang, Prike" <Prike.Liang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: fix userq resource double freed
Thread-Topic: [PATCH] drm/amdgpu: fix userq resource double freed
Thread-Index: AQHbww+89z6hcmv89k25HGG80DoJubPP20Zw
Date: Tue, 13 May 2025 02:45:06 +0000
Message-ID: <DM4PR12MB515295A13C683928470827C3E396A@DM4PR12MB5152.namprd12.prod.outlook.com>
References: <20250512073002.401719-1-Prike.Liang@amd.com>
In-Reply-To: <20250512073002.401719-1-Prike.Liang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=ce286a54-bc10-4acd-b4ef-a1e607af6394;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-05-13T02:42:42Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5152:EE_|SJ1PR12MB6218:EE_
x-ms-office365-filtering-correlation-id: 59088cd4-ea5e-4e7e-43be-08dd91c82b44
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?ge19fHRniOOISOVu1MaNYrblPMGKcBPy9PKM0Ep8080B7OunxINxmivGvHJb?=
 =?us-ascii?Q?tS6kgRMggXO8/HpUMXBVnJaWUJ119hKut1CS/bXejuVdZuUEfbNiR/KBPpi7?=
 =?us-ascii?Q?VS7uIMu5YzyXEf03NZcPK1Cc4Ydlza4GyCLNDxx2r0rLI5215WnhiSA1WhtA?=
 =?us-ascii?Q?W6lH6SsFn0vYBw+gUb+Vag/zN0Ia+yCFyOv+4hWEG2VnEE/eyCNwp6MSr0wR?=
 =?us-ascii?Q?4XmE7u8siXK8AbrhmtOcZMIon2qdEUkgyq22hCREJZWTJBt/YJSO8Coc9lZx?=
 =?us-ascii?Q?+ryPmyj/5XtZk40oBdWW0UtyOaTHEELlR9qJjsY/BMwPeK7epJZwwsUjJ7hp?=
 =?us-ascii?Q?HPA3g+bTaYcb1wP0M9Ca69jn24Akr4+5AaRKPcYQA/JwA7eSLPKtjV2ocuoE?=
 =?us-ascii?Q?+buIUNeHBhzfH5uivPrKQKFxjhGT6ZA6398KSjd+Ktb82tC5ehNAG9+ImK70?=
 =?us-ascii?Q?K2ooU9qGav26cNLJdZDpV7ZsY5nJNS43jtSrWmT4z2W8KQUq5PxVy5Xyg4n2?=
 =?us-ascii?Q?EpB1C9RSTa8P7pYxc0Xi71Cl+lHIC4AoH/nufvpB5FyB7mvzAXtWxcj7WcWz?=
 =?us-ascii?Q?44Rx/BNt1bzDeg38wjOcW/U3Vm29jGSI4e9kQmIRQaMWp9LupUxTvGmNW6k9?=
 =?us-ascii?Q?e1fy6yvu+j7wkb1c0E9z1wWc9WUVcMWssoJAYh4NRg8b4y2rG3wyAcn1XTMK?=
 =?us-ascii?Q?sKaaYnEXMLL0goLO6pQXT68zi4UBr3tP2M44mz3zDNqmgSwYn6fteAAzXChW?=
 =?us-ascii?Q?dLr1KE/lAR5yreY0B/GHTcUnEBvSl2UhKA1ALkzLNdGSp+Un2c7oiy3ZiZ4g?=
 =?us-ascii?Q?mQMNLzaWO/t0W+ZwzgjLOSiU6DKm1Lo7eVOXzhGHhdKLJ8gnBu2a7zVz/YEB?=
 =?us-ascii?Q?8VpDzW8Jm88sg1WiXtwgEkh8kW477FVxMVnEQ/7GOWaZPjrd+PK2vHEQq20L?=
 =?us-ascii?Q?qgK+XcF8CNiJoVmQyfNRqhwv80t9BOirWivX+plVxJfrOEiNqU9F/G55Bv7l?=
 =?us-ascii?Q?NPOZimUHYzzolIcy6fspGH4uZ8exNQxAwF4zu27n8gH9D8bLDz5JiCfEBOr3?=
 =?us-ascii?Q?y/ZG0EKkxb4LX7DKmFKFIeLkPQYy6gjWIa+VIaNPaGCyD8W2E0IqGAFokjnK?=
 =?us-ascii?Q?5ErmxD28F2wuTi9mkSapDUr1gPf0oVd6Gw/dx7QCWzZQWSgljBOtMIowwOss?=
 =?us-ascii?Q?I2QoXoFYxVVruaAXbpNIFrFWYojG/DZMaeEwqFsFVUS7YrT6DDFfIryYFqOY?=
 =?us-ascii?Q?vyIod00MGSflRD7l+smM+9gSq3g9KeOXu8j7GfbyXI9xWdiz+gSnHrOO8crQ?=
 =?us-ascii?Q?x6zGoB8z5531d501Kwmi9uQxxoiozwIFvm+0wU1rjAPw5DKnxzCjiznQI1pN?=
 =?us-ascii?Q?CLf6reOhO6AMxtntdz95JbbhKHXWXPZoStPWgAuXNSfSl8US1oO0DkYErgJS?=
 =?us-ascii?Q?vRneWc586dayzD/VkMCsN2TE5emwebWe1y2zj8SuAcA75EB2cwmGnkWt8p1a?=
 =?us-ascii?Q?pFSmv+KgYfZPRkM=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3HfbZtMZqJ+u5JNlL2PV05ZHMQbMtNWa7zjOHJ+npZdSwiAW333opcy6qw9o?=
 =?us-ascii?Q?q+ZVtHYbqkIxUByf6Rst++xpJzdizIaMK8lZFpXAbHcHA4XYYtGy/0mDA/Po?=
 =?us-ascii?Q?DJsbqdsRrP6cRb9mBSw2nHLMg/LihKg1GzHmLq1yznbQWq9MPlesC6qe7ik6?=
 =?us-ascii?Q?jSrZmxQMkxu00zYwjKKQWngfMvZuyygT+NgCyZroWNCLxJ9UrTu9K34Di1qX?=
 =?us-ascii?Q?3K3aI+p/v2ibwCKoVRZkjjugln50krk5RcOa1aI5xSscBF71D3+Xbu1CxDKY?=
 =?us-ascii?Q?FDWjn3ofzZJVZFQll/4V7nkMDIhl/0F0DO35tSFHHgo0VCEwlUeGbYkIYBsf?=
 =?us-ascii?Q?6hQ5yiVYL8e0G9nQOsoFmLQiHwih/YKk8/CHolYFzauojMlo7II9R73nWnFm?=
 =?us-ascii?Q?DXpq74X3IItBkowlIiRvvz9UUi2PArLWdZkgaC0kJ7wm+N8eFKbTTmaPRDJu?=
 =?us-ascii?Q?DyxSYbLktmflgkgg9pwGshfTLIzPQrCrH/CeWI9g7qe6gRv6bIra5tVgVVf7?=
 =?us-ascii?Q?Kd0ySQNEhDVBIVUkiexrlu4JPXGIyJ+ezXy69XYinYQpve+op2ei8jGIenFX?=
 =?us-ascii?Q?T5pr985ZqYN8Agtj0PFt9mnDmjjeycjvlPGl9Mu+d+tVGetKLOPqVUekB///?=
 =?us-ascii?Q?IUUCOzb6Um+OQiw+tHGxyhLKDGE8AEvYeLbbnrceJjBhBPg69NFjigj2HGUi?=
 =?us-ascii?Q?DV0qILohviYhgHtQHuEdX++2HMHDL6Xq7ZlEbgedCskoy5WRs2xZnD8p3YWX?=
 =?us-ascii?Q?M9mMJAk2l4SN6M54+2z4VH8Gy8YEBCj6m+SULnl5knUbzS7tjgIh9hoL0kDE?=
 =?us-ascii?Q?V28uYuyfFshDv8kRbCjEsXRYcXVRkyOPtI3eDl0X3WRPXg9CRDh2EkPpJbrB?=
 =?us-ascii?Q?a9k7tdCx5nKyxKdkjCRkFayLJP/vRE+NPJ/OuLOaUUQVDfFs+tA0FM3quoC5?=
 =?us-ascii?Q?m8YkYX+0WFFUx+0Ya9oPtod6AA+SK0BvkCKQiRpIxgBQ9IuRhBXuF9uZ3+LG?=
 =?us-ascii?Q?DWXKtQ03cUVN5ReX/HAg58ltVlCGc3yO/bs21ATe4rEbcU0SodBjA1vyyls6?=
 =?us-ascii?Q?laMBmkvuTCN1y34mgu0ddUlhCO8/pb+f+gwSKiZn7zg5y81TIYWhnS2AhzHA?=
 =?us-ascii?Q?zlVZpqeKoQycRSJXo2vKwmAZVF0KNdMQcKWYk0skH+XKySTIpsIEw/g1t9+g?=
 =?us-ascii?Q?UUe5oe+7CNVHiz8wiSc/2+1Mgg2Og/yjFaDrvMxAjzdSz7mp4NcXsNRZ1hyT?=
 =?us-ascii?Q?CtZ4vM+u8L4mLfrGRJ9nVeN3mYpQWspIVE2KcNxNtI54QM6rWG/DY1f3JWxq?=
 =?us-ascii?Q?pygjPWnvtDQXwMQ440GQ74LGY3CmaLpzVMLQ5UPoG9/gZpgQ1bIdw/aFEInI?=
 =?us-ascii?Q?jfBwZlY+rBdPEZaEnN6ldZseHyTdAKbdEwqA1rlIi48Gmpiy7Q9d1cqUs6BY?=
 =?us-ascii?Q?SWk//waVOOxUk2QThdeF0vPhrbuoZQv9WF6w5KpCEanhpdwglDySaWGmb65V?=
 =?us-ascii?Q?6e42yxRggz7Pt1VxYcLoiai9CXn/tjH5ZsU7qAuyyV7mRy28frmbgky5uSmj?=
 =?us-ascii?Q?Avz76Erq8Ltv44sWCXo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59088cd4-ea5e-4e7e-43be-08dd91c82b44
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2025 02:45:06.1639 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CtdQ5dumHzGCVdCAsOqaTc9XOFVSI1kI5uok9AoR5Um5MxkJh/Je94u9VEUVhSLnUgarOr3/QpqNIq1t04KTHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6218
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

This patch fixed a similar problem for me.

Reviewed-by: Jesse Zhang <Jesse.Zhang@amd.com>
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Prike Li=
ang
Sent: Monday, May 12, 2025 3:30 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Chri=
stian.Koenig@amd.com>; Liang, Prike <Prike.Liang@amd.com>
Subject: [PATCH] drm/amdgpu: fix userq resource double freed

As the userq resource was already freed at the drm_release early phase, it =
should avoid freeing userq resource again at the later kms postclose callba=
ck.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_kms.c
index 8d4a2aed7231..cf0f35a7daee 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -1502,10 +1502,11 @@ void amdgpu_driver_postclose_kms(struct drm_device =
*dev,
                amdgpu_bo_unreserve(pd);
        }

-       fpriv->evf_mgr.fd_closing =3D true;
-       amdgpu_userq_mgr_fini(&fpriv->userq_mgr);
-       amdgpu_eviction_fence_destroy(&fpriv->evf_mgr);
-
+       if (!fpriv->evf_mgr.fd_closing) {
+               fpriv->evf_mgr.fd_closing =3D true;
+               amdgpu_userq_mgr_fini(&fpriv->userq_mgr);
+               amdgpu_eviction_fence_destroy(&fpriv->evf_mgr);
+       }
        amdgpu_ctx_mgr_fini(&fpriv->ctx_mgr);
        amdgpu_vm_fini(adev, &fpriv->vm);

--
2.34.1

