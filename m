Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0969606A885
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2026 11:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=rALgLCJ5
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 14F9310FB7E;
	Wed, 11 Nov 2026 11:56:14 +0000 (UTC)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012034.outbound.protection.outlook.com [52.101.43.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1353710FB7E
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2026 11:56:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WM5FuUXF5bxZ4do8AtFlFrb1nNU2AIMiMKejKYy5lvOt0iU8lsOuLn92671jInrBFiC/cqcrPOfkcXhcOTlmXnxJH35kEL4OOzjw9eselgNxvgFTLA9Uqt46mSSqLXmBqA8tKwMWvSlYC77ViZ4L1tsW03bssjpHgsUKGCpsIIkn4CTzu7DJXuqEi8SpCD9sHBXL64MS813vYypj/0Qgw2BgwSuGJGj81xYCncDGqFflnf3H2Uu992NFsKNn27Nr6gcEu8weV/0fx3OG6TY0e2Le7gLL2FsCSUc3y2v4r/g2rTD6F5PKxu+UF0H63YVt+5ZYP8BsedtjlshO/ETS/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=At9QNETtsKngK7691rPyAtpN+mOh3hGb0knsDQCIU0g=;
 b=GbfRFBs2AtgTrwnGQlw1l0n74VIOnQGuJ7yRPsb1VfPGqwJ/ipBb0hEtxNhvoUNN2LEa9NYCSkdamIDRwuv5UVm5xnHhKzN92tiD0SEi6hWFE4jSn62JEGwOv6WeadHW05UVuZkWAce7DzB8+0raHOhUg9vFWt8OOONX1G6/VH6Q3pGSdJSGnPMGQgHyO10CEjjipxbaSUyFybHI8kY6heqHVvdwfLZePNj1+9YS82eV7BAUEi80FX03i0EI1loyucuuVOq4G04nniJJfcwrZnN3/Mr2w7PptYhobUIdNrdZrUyqS2yoWzRycm5XmbwFsKOh8SqvFEg/UJRfk6tdaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=At9QNETtsKngK7691rPyAtpN+mOh3hGb0knsDQCIU0g=;
 b=rALgLCJ5AX9fwp4gKK+iIaQBIlPbdPKnRRHuECSlnNHlkx25e9ZLzJ4AP1eQFBGm68ZF1adwlhDVyiopQ+UNoXo6vj9pCzjrG6hIyrwFZhawY4fpcfPvy1Gd4LQLhR5sZ3GK6mbFKDjSz3VNweG84m3yYkwLKI7fVlwGOskyfLA=
Received: from MW3PR12MB4572.namprd12.prod.outlook.com (2603:10b6:303:5e::7)
 by LV1PR12MB999279.namprd12.prod.outlook.com (2603:10b6:408:3f7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Wed, 11 Nov
 2026 11:55:58 +0000
Received: from MW3PR12MB4572.namprd12.prod.outlook.com
 ([fe80::79cb:c567:1825:51fc]) by MW3PR12MB4572.namprd12.prod.outlook.com
 ([fe80::79cb:c567:1825:51fc%6]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 11:55:58 +0000
From: "Mu, Zihao" <Zihao.Mu@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, Thadeu Lima de Souza
 Cascardo <cascardo@igalia.com>
Subject: [RFC PATCH v2 5/6] drm/amdgpu: restart VM updates around page-table
 allocation
Thread-Topic: [RFC PATCH v2 5/6] drm/amdgpu: restart VM updates around
 page-table allocation
Thread-Index: AQHdcdOdmARgND0ymkypD6igbpJ4UA==
Date: Wed, 11 Nov 2026 11:55:58 +0000
Message-ID: <MW3PR12MB4572521248CDB7B929017A539E712@MW3PR12MB4572.namprd12.prod.outlook.com>
References: <MW3PR12MB4572FABB93F6676FDBA1D2479E722@MW3PR12MB4572.namprd12.prod.outlook.com>
 <4edd67f7-381a-4446-9509-552739c8f016@amd.com>
 <MW3PR12MB4572A08ADA8CB7BA9F83AF519E712@MW3PR12MB4572.namprd12.prod.outlook.com>
 <938026a1-3b02-40b4-98e3-a0a22f045f82@amd.com>
In-Reply-To: <938026a1-3b02-40b4-98e3-a0a22f045f82@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW3PR12MB4572:EE_|LV1PR12MB999279:EE_
x-ms-office365-filtering-correlation-id: e7dfba8b-39e8-438a-5d85-08df3feac00a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|18002099003|22082099003|6133799003|10067099003|3023799007|38070700021|4143699003|261102123227099003|11063799006|261009223027099003|261022105027099003|261022075727099003|261021121427099003|261021123027099003|261026140227099003|261026121527099003|56012099006|261028144727099003;
x-microsoft-antispam-message-info: 0jKG/DswkuT/AxKUnnF8D7zLgf/B4jpYkMQyxDdIu6Q3yXIVqr8z2SBqQnC7kRpITCVVeVapG2CGZ/rH0f/k1cLkC/3ZNj/worX7/3is4rGqAEdYlynZKeIjEYevKp4iOq+F3EHKwgY/x3O1LsrZazm2Ide8fQjn2haRHs0150UISARg6BBRSxxaxCZO6ZcA8h1P3wTvGbE5nx2IxktFRgTZJTcaDdhgL1hO72kQIZmi6PebFMOmY9gLdNpNChXcJ6RrVoUIpVX26KxXJlnRu6DYtKga4xypmIavU/u5i+yPRlVuJY6zLutCEmUJ66Zpmk7GmMteeo8+nF+/hhOXiW7MnRRjLosfe8WI5UENBENaVn68N1rE5f2pCCvNeo1MMdPb7dBvtppSdgmHZ+5THYM3Cf2D1K9c4LCCh0kLeF3u2HMHb0Wansd5RAZq9E4kWoqEXExUkelFEVRUJQMKPsxjhsGa1P4j6GcQF8UinICjRAj545Mo2mcvmAkU3VuEWDVFmsuEefVxFAz4m20XFqhp9YQlqyEKcwc7bMdi68uyud9GKiW3wrLwUGIRebs2iWofa8cuKjh3bSWTWUnxEJbsA0V8ncV9VAE0ePReu1SZ/iYQxAKPtI3b+halKfEj2fpDffbp/1GbZyCwKJwdbzRQsSuCgVTnmfdBxmSQd/ZjCNh1NNuEpVH4XbqPTi5EwBdxXJNNCm3ywu2SuoICsXs+W8L8TpDS6Ft0GHpxMxk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR12MB4572.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(18002099003)(22082099003)(6133799003)(10067099003)(3023799007)(38070700021)(4143699003)(261102123227099003)(11063799006)(261009223027099003)(261022105027099003)(261022075727099003)(261021121427099003)(261021123027099003)(261026140227099003)(261026121527099003)(56012099006)(261028144727099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hTnHP1CdfXqcS7PWz3e2kq+bDA0hYN+ChMCRmyTOqEBicjf7Gq611Jp9dlKD?=
 =?us-ascii?Q?xJ++cPHRWsJrOsoS04wkGKjOFvJQ3XCqQ0MBW6mDkS3gRfGPUBY1XXCo79nw?=
 =?us-ascii?Q?IjSPaeuj1wjUnRQKYXNPvwrax/8X83gxnqbm++7cvhzpPg0LKVaaVn44WhT3?=
 =?us-ascii?Q?XIeUKDjW6Bui7lorVLjIinqe7F65g1zg4WftzCThC12wdW5gePtBGi/3sDUr?=
 =?us-ascii?Q?H2oQg/gQnK6ikYconUMSVuobUbsx5l/aVKHSGvaDXawhhQO9gtqfBnnIYW4b?=
 =?us-ascii?Q?2GMtf6UJlxeMzMObQTkxN/Ew63aw8fEO+isHWY2ATVwV92LEQMP50y2I52d1?=
 =?us-ascii?Q?q58aOjjt2+ZGvdLJJ2pTWH1vb0W+DuoQfm1cDrLHB6HRVQNCGGu5cbnLwpII?=
 =?us-ascii?Q?O75+2upgazgcQxV+/UteOSjMcUAhi+7RlZGiyyreMwSTCC+PbveoAN6y83pp?=
 =?us-ascii?Q?+WThAg+NsSey24l1JTrg1PTFSMjhOaWbu9LnjOhqv068OwQna0vcSayjkPWY?=
 =?us-ascii?Q?suPuv4Uv5hzt08xV2uSEvqmAwFYyp3mxDvWeT5B9v7xkHrd4Afodc25m81y4?=
 =?us-ascii?Q?Q+dYW1thYTAr3es0oUZTJwwLLe5gAKT1XKN/6VyRSZgdjXRJAElniMWr4z0t?=
 =?us-ascii?Q?QdqOMdPaMIr+Hit3IolS2eqJrmDZLWo9C/OzUkOkuMAQ1TF9k5/O99NsG71A?=
 =?us-ascii?Q?IFq4/UKKiRCdzuGHgTNdroYO30xZ3BuBiL2j1iponKLe7N/SoYaV6dXyJ3FR?=
 =?us-ascii?Q?ZIiJM5llnfjut+t9/+KvM91ZXp4XMx/2TxU5V8ZilAoU8vOzoHm0f/Uh4kI4?=
 =?us-ascii?Q?D8o/ezfPlk6mkRYKnEGJ0srTIZ2qrtii2kLyMXmgLJjphjh6/a2rR3fjcC5Q?=
 =?us-ascii?Q?3fdQL7Xut+3/4o3dRZvIHNHwDqumNSI4DcmH+yxgBT4RQwy+miXcVRKppvzq?=
 =?us-ascii?Q?BZLjf1BTgdCUIBTM6O05Zq0OJcBfs0wAmThhHABmSoMbHJMotBoIvxHZY4u8?=
 =?us-ascii?Q?qxa+/FoGK+/fEMZf3WGnLYLNVKFtfQHmBpD4Zk+S1mLPEogcDxkI/eVMRICH?=
 =?us-ascii?Q?Q2gv1VbWXBIPhbC3PAXxh6/OkLAY0ZHB4RRGlb6XppPaEy8RDje51wWF9Q6Y?=
 =?us-ascii?Q?qa22+p2ZFtyUIL3wqa6P6pEHeVo0qBJStJ649ONKfyBIELZxcRK0FE2M5Vbn?=
 =?us-ascii?Q?vUGZRZGRusBE7vll/wqwpmNuMDLqEMHfRgTI8zgvEV4vTNk0nrLFGOip125a?=
 =?us-ascii?Q?5r26eXil0v130x/WaST3beAVao+nuSdWKJiW5g9Zo9kz7VkP0sAIc5jaYBNy?=
 =?us-ascii?Q?4qEWiknRItLdlhB4yhpv1NtLq4cSOncK9gLmI9A0Y1mY2KhlZYS74Gx3ZkAx?=
 =?us-ascii?Q?adlMTS8n2GGey1MzMKrOeOBYWYXVgyI+II087ZFupDlwYFdFqDEofkrZFO9W?=
 =?us-ascii?Q?S9FXS/kLnrsPdVN/SWBRO9WdGE09n2vx3ruO6a9HIdczRIQwX362egLeDla9?=
 =?us-ascii?Q?buxG9jykhGKcNZTwqsvJqcCm7WqYSBuHVZF68Pl8gmtuOR0dPZAN2oQ68e9g?=
 =?us-ascii?Q?ub3c621HMFyyfTo6c0udEv8BLAehbzFXCJZ9826RluwbwyzkjLtndpNgEaHU?=
 =?us-ascii?Q?qUM6LvBuxYnWs9+SME0UVCH+sgrt8HPeUbH9RcjQX7dx534j5Bj5TYJzeNzA?=
 =?us-ascii?Q?H0MOdHX03m+pDgwHhLprsE4HcLQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4572.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7dfba8b-39e8-438a-5d85-08df3feac00a
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2026 11:55:58.6157 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jE3B4uGENNoHEa+BkBmqeER6axIY7vcHPKOnOmmJryBqX3JPSPq06YAAAENO4DPV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV1PR12MB999279
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Zihao Mu <zmu@amd.com>

Page-table allocation drops the VM eviction lock and can introduce new
move dependencies. End the current update phase before that allocation,
then prepare a new phase after creating and clearing the table.

Preserve the original sync across each prepare. An empty SDMA phase may
be freed before allocation, so its job cannot be relied on to carry
those dependencies into the resumed phase.

Transfer the nested clear's internal completion to the outer context as
well. If a subsequent prepare fails, range finalization still orders
the TLB work after the already submitted clear, including immediate
submissions that do not expose a public output fence.

Leave a successfully cleared table installed when prepare fails, and
keep the existing fast return for already allocated tables. The earlier
cleanup patches handle failed initialization and partial range work.
No PDE iteration or output-fence policy is changed here.

Signed-off-by: Zihao Mu <zmu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c          | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h | 5 +++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c       | 8 +++++++-
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/a=
mdgpu/amdgpu_vm.c
index f76459f8312..7d85e5e74c5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1206,6 +1206,7 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev=
, struct amdgpu_vm *vm,
 	params.vm =3D vm;
 	params.immediate =3D immediate;
 	params.pages_addr =3D pages_addr;
+	params.sync =3D sync;
 	params.unlocked =3D unlocked;
 	params.needs_flush =3D flush_tlb;
 	params.override_pte =3D allow_override && adev->gmc.override_pte;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_vm_internal.h
index 71fc1fffaa6..df1aaa00603 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h
@@ -82,6 +82,11 @@ struct amdgpu_vm_update_params {
 	 */
 	struct dma_fence *last_update;
=20
+	/**
+	 * @sync: original dependencies to preserve across prepare calls
+	 */
+	struct amdgpu_sync *sync;
+
 	/**
 	 * @num_dw_left: number of dw left for the IB
 	 */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_vm_pt.c
index bdd06b7718c..e42af004dc0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
@@ -531,6 +531,11 @@ static int amdgpu_vm_pt_alloc(struct amdgpu_vm_update_=
params *p,
 	if (entry->bo)
 		return 0;
=20
+	/* Allocation may introduce new move dependencies. End this phase. */
+	r =3D p->vm->update_funcs->commit(p, NULL);
+	if (r)
+		return r;
+
 	amdgpu_vm_end_critical(p);
 	r =3D amdgpu_vm_pt_create(p->adev, p->vm, cursor->level, p->immediate,
 				&pt, p->vm->root.bo->xcp_id);
@@ -556,7 +561,8 @@ static int amdgpu_vm_pt_alloc(struct amdgpu_vm_update_p=
arams *p,
 		return r;
 	}
=20
-	return 0;
+	return p->vm->update_funcs->prepare(p, p->sync,
+					 AMDGPU_KERNEL_JOB_ID_VM_UPDATE_RANGE);
=20
 error_unpin:
 	if (p->vm->is_npa)
--=20
2.43.0

