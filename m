Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C7E606A335
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2026 11:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=ZPG34Ter
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E22B710FB74;
	Wed, 11 Nov 2026 11:56:02 +0000 (UTC)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012034.outbound.protection.outlook.com [52.101.43.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA54A10FB74
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2026 11:55:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U0vTIXJ6LMY0xj0afg92Rg0Xp33jYNrW1vIh4ag1e2isbUrbrofQOZipXEBABLJXd/x1hz9O/GYPWKcJRsPdHFqBHNjMPqdlfUEVnMQ3pdTIFMPWLABi04NV68mBKXOd1vcebTVrK2RiWtdTaIbWPK15GTtI0OuLBJFTXkWWX4uo5Ldnf4aTHBpBWQU48UYCLsyBjfyoRGjJmA39qcHZOeSYfJhVmQl11fgSizvEPbl8FVp99JdzwUiMS6uHCcEVmak1rsFOWop92WyV10UMQDf0c26dAXrxeGs9bI0aUmPI1jPN2+xM5H13A8wzv3cuSz+TPE0Q5kP1ZemT2AoN0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gvT5VqRalB9AB7F+h4n+S8B447VC9Bd4aYp0cu8P5xo=;
 b=lK8RxPGUPnObVX2puDiuKqaIIaIFIZ8HyBeFlAtYlkE3VL3QqtuM1GAIuBLIrDTdA5u3Od/yhl3wZdiZQweW/6viY6sK2VFa7FmoNnTkswgWWsPQHGgIXjhOfiZPVOHmlceHPMSsRMTvFOIaMZ7BhEpLLnmdnkrxe97LLc0wc7/y1USFpwrdRMgYNNbywh71tId9Jcv+0kbihwGLD1/yyXIP6tFwrBjVYIE841BKpANjafb8jauJaVEh7i/zfkMe2OLlWq460Wx+ii+mk5d9nIZzvvA/PCp0THqdsGJlY/95eyDypXJO9qKsHU37bi//XX//Kmx+OvBG92XSdZ1JLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gvT5VqRalB9AB7F+h4n+S8B447VC9Bd4aYp0cu8P5xo=;
 b=ZPG34TernoWPbmIa8XjyD/7dvEtV1WPDhEtfJomWFNSOCPpM+dWSsLzBTd7gnhwk25/yv4w2NZ/QlimI0um0Z06CY8q8fS02bJWXzbc0za2nHVCPYCl3xisViTEiLOoj4R6zQM4jJHBMcXrqDUfx9rYZUNikO1HR8CxVbOziIoY=
Received: from MW3PR12MB4572.namprd12.prod.outlook.com (2603:10b6:303:5e::7)
 by LV1PR12MB999279.namprd12.prod.outlook.com (2603:10b6:408:3f7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Wed, 11 Nov
 2026 11:55:51 +0000
Received: from MW3PR12MB4572.namprd12.prod.outlook.com
 ([fe80::79cb:c567:1825:51fc]) by MW3PR12MB4572.namprd12.prod.outlook.com
 ([fe80::79cb:c567:1825:51fc%6]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 11:55:51 +0000
From: "Mu, Zihao" <Zihao.Mu@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, Thadeu Lima de Souza
 Cascardo <cascardo@igalia.com>
Subject: [RFC PATCH v2 3/6] drm/amdgpu: finalize partial VM range updates on
 error
Thread-Topic: [RFC PATCH v2 3/6] drm/amdgpu: finalize partial VM range updates
 on error
Thread-Index: AQHdcdOZVj/7Q8VKXkyqjaK/EZr2HA==
Date: Wed, 11 Nov 2026 11:55:51 +0000
Message-ID: <MW3PR12MB4572BB2BE619E89D33B7A03E9E712@MW3PR12MB4572.namprd12.prod.outlook.com>
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
x-ms-office365-filtering-correlation-id: e94783c8-c698-45fe-4e6e-08df3feabbc2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|18002099003|22082099003|10067099003|3023799007|38070700021|4143699003|261102123227099003|11063799006|261009223027099003|261022105027099003|261021121427099003|261021123027099003|261026140227099003|261026121527099003|56012099006|261028144727099003;
x-microsoft-antispam-message-info: R1QIuYq1rJWy2VTpCq4zLBXNvSH9BCGxpRiNFB4dRuzx4aL2ntVlJgO1ZpnTJSNlFjXtjuNrYS6U6SgbLqd/STNMEd4qIfUOvjmbjxkKukP0OGrvIQYHyiXjusB713e8GBg7gPiXp0cvKmQdkU5BjxqDTNE+Z5Z9phPF6EPwffZlTy6k/mg/0HxLdRXaE2Ee5X1VIECkBbQx3zapMRsflExeiF4246rRit1X7L7EOfST6skfyPa+hdLwGIfqQPV18TiSpf+95/mfdAqtVqgSZr0pcx14/VI2asZ+OX5Q0x56p7t47j2ZZljU6Gj+teao3T8/cVvnwafCoWQeCRAbLY4wmdFrnveUDd7gtC5alk0i9uiIcI40+xmpv5Pe/3H6BOqwRt6tYtLm6v0+nfQLMR5XWlAj08gPrplkKmLSDCPXTzCxzIOQ170PecAYMxkIj8Tq3ojYazIBGWs7rICrsF58uF4eVXeYJOuEU1Q3zxRrD23423FItdDEgbID2oFFPWkcXx/rJvUoWEI7GtDEMlF4mnWsZRAj1qko2yIbsv3sCamp6bMRVRGBu2yFfWiCJqmvglxMCS8ELFNmQKmRGKV5MQ2lc27RIo2yWGeATty90qCWT7oNEGR0DyEpHduOzG2wBhIkZQe5kOVwx9FuOCHCEaE1APeMNQazQWI3kwg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR12MB4572.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(18002099003)(22082099003)(10067099003)(3023799007)(38070700021)(4143699003)(261102123227099003)(11063799006)(261009223027099003)(261022105027099003)(261021121427099003)(261021123027099003)(261026140227099003)(261026121527099003)(56012099006)(261028144727099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?eMsoE3bgxmk2kZ3O4H5bi9hDTga2D8Pbx53l2aHIp8rWkwekzr3w6msM9ivZ?=
 =?us-ascii?Q?f89nBCCJaUi2+ITILh7cgTPq8qbXLfBkZnf9/+StRjKVb/K4FVYjhCuF0Tyb?=
 =?us-ascii?Q?tIEUlaYtqmv33AW7DybIE+GPLWyVYkJorXiu6wM6XqSFGv59pMJF7TXGsjcl?=
 =?us-ascii?Q?/nrr/QT3W+hC0uJcZwtzVUR7QjJwDMdzDJac5Lj4ANEZVdiBMKIAYyg9tHMV?=
 =?us-ascii?Q?RmNHqJLO9M+acawcDbX1ojVuf3DKSOEnXiZk82l/bdIyw2lQh9/AlRk2MDel?=
 =?us-ascii?Q?Y7QxVD4CoE3t1K33vvrxW46tZ1NZieEWgz++/MJ6yosVKeZ5anpwEW2leePf?=
 =?us-ascii?Q?rG6iDFKrhVjbHEZLCVhSR+Tq4B33smoMFIeHJybdC4ksmTDXCF2GmYrt/GSo?=
 =?us-ascii?Q?yRoXyVaSrMn7OE590ERrxVopoUuv3C2KkGhCn8B1ad4q0LfLREAtToHzVINk?=
 =?us-ascii?Q?fvQ5MeUrShFGKOGqppNiNpxH6kO5Ugu+Ng8UtgQhpzL6FsIgGQrbyTz1TqNr?=
 =?us-ascii?Q?fQPpGVbR8K+fJahuSpEKDK4pGPlGU3nOcAE/tMqHhnS7HzhEAmoFB+TEZcIY?=
 =?us-ascii?Q?O2NzYyqK9xR404MnwEHu4yMZXQupWtGaAZ1lxVLLVPWvt/ADGOtGxVY8lD97?=
 =?us-ascii?Q?nlIRiwncHDsq+wJXaxWNx3QyTi4GfflDMazrKw5sUDUU7bE1lrhqNvRtDL64?=
 =?us-ascii?Q?EjlbQecMbw73q5UF10bAg+NgjdUwWpexBK9vWzHufvWuaSq+o/BoiMevKbWy?=
 =?us-ascii?Q?Sh4RV7PcyVxCK1ySot+HEK8ksqrM9kaMBLkW8d4nu4lMfpMW9h5kBHDdOgzJ?=
 =?us-ascii?Q?A7Dugjscsb0W3o1BWn8nLM4CvVisfuvKtLRV/xkQWhgrBq7YClmLtZUJ54hd?=
 =?us-ascii?Q?xuw3fSuBXLFyMTbfjLvUTakY5mX2xFiWYrmPbPLqn8qNiQVgI5+kx1US/Oas?=
 =?us-ascii?Q?TwSSsOMtkGC54ltwa8HaOVMbqeuk0Kl2TfeL/UE7o/qdVygBAobTHoDmABEg?=
 =?us-ascii?Q?MHVyfL56Z/D2cTWJhE8e6MUu3DIh1CJihDKsCEgWEU4/fKizF35+Bi8H5dgg?=
 =?us-ascii?Q?A1klplggMS8OOg9CCNXOwUTTG8C5c9AnHkA8fskbOu301ijMBqhdfx94uZSS?=
 =?us-ascii?Q?pw2TD8kU7j0Q5XiOOAbVoLJvO5arnlTx8C6GnW5bCHNjBaJLbmJPebcCt+X1?=
 =?us-ascii?Q?8YeZM9TfesfB+OrNnylnoQED1/rng4c3pmiAgFsSmFFLiuWObhsQLO78EaHb?=
 =?us-ascii?Q?5BhwHi2t3PFQjwXcLs8lvAK0IFB98KscRPLfmJZkAI5mFypybEgfX/cE5vYs?=
 =?us-ascii?Q?+9EPgeiU3H4387e6NVzrnbU2o5gf4XwIP61OemPQHMx1DK9o5x6L0WkVnr3g?=
 =?us-ascii?Q?MyFPTRCEQQc2QOyB1Wqb6UhQCe1FTGCLyEB+Mfe38WkZWLAd73R4WPFnri+r?=
 =?us-ascii?Q?9U1lVIGfKGZXwrYFL/7o3+ro842lN8glireIPpr3S70V0UoaUBrpxh/cxwP+?=
 =?us-ascii?Q?xBOwjqQqMMK5vQeiHTg96Abzmvd40adrzzjw6TexEVw0yMhhvrgYGs/N1T81?=
 =?us-ascii?Q?YI9JBBBpD2gKfxjfeIilQ5z8RvdLl41UrQxGsv0qDnFZQKSkaRxYafPKOcZ9?=
 =?us-ascii?Q?DTD5lpwumt9YGH8xlbnwi/KhNRr7ygl+inULpml5YmrtoltjL/c2jfDyFnI/?=
 =?us-ascii?Q?06az/qbCoo4n3CGmGJmEzmiFMog=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4572.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e94783c8-c698-45fe-4e6e-08df3feabbc2
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2026 11:55:51.4511 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jWM6GQt/B/uazB/33kWp02m7/Z+OQrVrpTbmjHIoc7ijasvRJPtr23h92jRxyiYr
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

From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>

A PTE walk can fail after earlier batches changed page tables or queued
SDMA commands. Its current early exit bypasses the final commit, TLB
handling and draining of the stack-local tlb_flush_waitlist.

Stop the range walk on failure, then finish the existing commit, TLB
and page-table cleanup sequence. Preserve the first update error so
that successful finalization cannot turn an incomplete mapping into
success. Preparation failures keep their existing early exit.

The preceding internal-completion tracking keeps the latest submitted
IB available to TLB finalization, including immediate updates and failed
replacement-job allocations. Finalization does not rely on a caller
output fence being present or updated.

[zmu: Adapt to the int-returning commit API and tracked completion.]
Link: https://lore.kernel.org/amd-gfx/20260914-amdgpu_vm_fixes-v1-4-d6d8355=
91e0f@igalia.com/
Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Signed-off-by: Zihao Mu <zmu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/a=
mdgpu/amdgpu_vm.c
index 1e41f159ced..f76459f8312 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1179,7 +1179,7 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev=
, struct amdgpu_vm *vm,
 	struct amdgpu_vm_tlb_seq_struct *tlb_cb;
 	struct amdgpu_vm_update_params params;
 	struct amdgpu_res_cursor cursor;
-	int r, idx;
+	int r, commit_r, idx;
=20
 	if (!drm_dev_enter(adev_to_drm(adev), &idx))
 		return -ENODEV;
@@ -1278,14 +1278,17 @@ int amdgpu_vm_update_range(struct amdgpu_device *ad=
ev, struct amdgpu_vm *vm,
 		tmp =3D start + num_entries;
 		r =3D amdgpu_vm_ptes_update(&params, start, tmp, addr, flags);
 		if (r)
-			goto error_free;
+			break;
=20
 		amdgpu_res_next(&cursor, num_entries * AMDGPU_GPU_PAGE_SIZE);
 		start =3D tmp;
 	}
=20
-	r =3D vm->update_funcs->commit(&params, fence);
-	if (r)
+	/* Finish partial work without hiding the original update error. */
+	commit_r =3D vm->update_funcs->commit(&params, fence);
+	if (!r)
+		r =3D commit_r;
+	if (commit_r)
 		goto error_free;
=20
 	if (params.needs_flush) {
--=20
2.43.0

