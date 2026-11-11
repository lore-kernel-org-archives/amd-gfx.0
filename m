Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E33B606A321
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2026 11:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=JJsYEkWI
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CFBA110FB50;
	Wed, 11 Nov 2026 11:55:57 +0000 (UTC)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012034.outbound.protection.outlook.com [52.101.43.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7CDAA10FB50
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2026 11:55:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=msgBFlafpQ92zCmcwTAvBYFo5h6Yc7rea70dR7yGOSTFOgCd+zxLgHkTffHAALVtyTHgQVWSR/nn90MiTkGHr85hzVfwpd+Eyicel8M0L1+FEUGXkpfNhDqKHAs70lnhwIEuqGRbK4eF2/0RjCBmxJ1DrBoPePnLB4Ts2ZxRR+UyiqTRQiPJXUu/qQmjj8OBASGBPQl2BEpt8g4knDXrGhdFMypYhQG+MGmmiRtIjGJcuWa4V8x1bvrHSyAm/2XMvXB8OCbCIiP+uUToC2UC2Mnh+4ZvCeNe8eCeJcImlm7tGqHVh+qihx4W2MrAnZhbIQXGCsfadLacOA7jZeEYrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=imHeQqrEqjL6SGT8lSNws0S2v9y8Zqw9ZxW77gVmvxY=;
 b=wi+36FydUvCxLxyfCBBKttHN4mF0MIo8Pz/8NVElg5SBVKVSNx1Csu4FaIDajqy24gZfUZlMtRp/RekuUGqItd/lwtJNPdcTb+x/Lut5ubZzHlpE8A+z54UZkVPV28cSTgT1CfWwXN7JpYzNCtTjBaWVLWzBPhyJrCfAH9Ox/CjBmjvpcZ6xDkqzpfifdoJ/7vmAnvGuDSWriS3pi+KkAYF3dW24fk0IOKle6fyIfZwzP4h4MuQaDPZcaiEiWG6LQTcBoKiiHahDzsYpT8dPXsNy1/xTaheBrEfkw2sRRZdC61gWR2ZdePljIDJcPJ0Vub4eK9VwKXM6m3RKFYfymA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=imHeQqrEqjL6SGT8lSNws0S2v9y8Zqw9ZxW77gVmvxY=;
 b=JJsYEkWIJBVHpAFWHHkIUHkB7s79wo3RxyEXHCRkaYPuzZ06Q8dkAUHn4xHEfqsVIFk0mBe6pFr4F6ijhmgjeDeQ+rTD0gJaQGTQDmUo8BjVfB/E+z271lvQW0lnqxJEsOYC8OtZWzlK67RbY7rgtPoem3Wvv+AXtS5vmRxCaDw=
Received: from MW3PR12MB4572.namprd12.prod.outlook.com (2603:10b6:303:5e::7)
 by LV1PR12MB999279.namprd12.prod.outlook.com (2603:10b6:408:3f7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Wed, 11 Nov
 2026 11:55:47 +0000
Received: from MW3PR12MB4572.namprd12.prod.outlook.com
 ([fe80::79cb:c567:1825:51fc]) by MW3PR12MB4572.namprd12.prod.outlook.com
 ([fe80::79cb:c567:1825:51fc%6]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 11:55:47 +0000
From: "Mu, Zihao" <Zihao.Mu@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, Thadeu Lima de Souza
 Cascardo <cascardo@igalia.com>
Subject: [RFC PATCH v2 2/6] drm/amdgpu: track internal completion of SDMA VM
 updates
Thread-Topic: [RFC PATCH v2 2/6] drm/amdgpu: track internal completion of SDMA
 VM updates
Thread-Index: AQHdcdOW23Lsb4vRtE6s9n8SpgQy5w==
Date: Wed, 11 Nov 2026 11:55:47 +0000
Message-ID: <MW3PR12MB4572053D50BE077A8D682DB19E712@MW3PR12MB4572.namprd12.prod.outlook.com>
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
x-ms-office365-filtering-correlation-id: fcc617f4-bd3f-4c54-d498-08df3feab938
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|18002099003|22082099003|10067099003|3023799007|38070700021|4143699003|261102123227099003|11063799006|261009223027099003|261022105027099003|261021121427099003|261021123027099003|261026140227099003|261026121527099003|56012099006|261028144727099003;
x-microsoft-antispam-message-info: LDKExWJTOzrXViOeRPS3YOYdsH2JEiKPTOC+fZwgxoEqSbjC+B0d6iOc9vMjvforc/hYkxxlJy+RXjMX2W0kWzqzxZ6tno8/n57DG+88nN2G7mC1BksgEbSUF9rro/dZni622jXjGKO+Phe29HkthmRa7uFgAC0RPPp2DvkLPmIReebLDvnlLbuQX9m3xGENNBMRS+aC+n9sdkIuPlX4gVcj4UF2vohrM2tEDGK0SGUPLGAIB2xi59lyD7WmwhXA6HiBd1IM9fAipABeAUm83wYB6zvInHwIZ8fNlWkHgvT+UcdwbcBXzAq9r5zLhNNYFDBfqDrmn6Gd3wsoDVETKUHoASJbgzRcHXQTonU+BdE4egLTauFQp/HiFO4Z4gerpSTepqDKcCzW7shhitH279q2+j0v+wPWmEJtybW/TgBMfrMh8Q/q2gn5+p1jyAQAR6cxq9znx/u/EoWDec+Q4Zi3ALQW/QoYxLVPzO4kXOYxSVTqIfUtHMrP8KWiApaNpf7PhOoPxBzKCXYxCC+BpX6dFJLtGsNg/O0FW9K1Etk5VA2Y59ReMQKZzqmM/f32nH2Wa0CyhbEz2rj9cbU04rFHgv7/pdBYXMcGqsBO1pGEIyLBNazvzPiWDXLb+8pQodCv1rGFoM7//knxmAkhc5oQMgl1xz6EU/U3kaSOVHPRQdSUMpt57A+FIOhjzqYYSFWEWorvKK9UMnbq1/Tm5G+CehQejqbaDctKasHIa8E=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR12MB4572.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(18002099003)(22082099003)(10067099003)(3023799007)(38070700021)(4143699003)(261102123227099003)(11063799006)(261009223027099003)(261022105027099003)(261021121427099003)(261021123027099003)(261026140227099003)(261026121527099003)(56012099006)(261028144727099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vyXjvGrcYiZMP+r7o1moaJhOTsqTMPetN20gyFHp0ZzoZiDW3/ho6aYMZNkl?=
 =?us-ascii?Q?vhhgb/Kl+ut92OS5D1QZH9jZ1vaZTNTM5JN75g0djaWBbqCP8OmS59n0HKAX?=
 =?us-ascii?Q?fwScPNgSLaMKssTs2oDCCTNj2PazGTCj3porgCOfoUn8n1iGLbpItbsjuJOw?=
 =?us-ascii?Q?zyt9i7BYIvni1O7QcXr+hj4U5P5ihayhkpC/G2REtuMzabjRnIZDkbzi5BJY?=
 =?us-ascii?Q?j0diJIVntdmQRx28difG2Qv4KMfYgetiwZOXt18lzGuOLsqpTRlAwoKeDqXk?=
 =?us-ascii?Q?LsMWsWUhB0PQBl9WKQsJJvEZHIqaY83QiGjVt3qSkrrEMn/Ff23F6piU4uFq?=
 =?us-ascii?Q?bOx5rxuNieG3Nu7p6YuzJHBCRz+Qoh/u30lgP89fNbSHnlq968hMODXDm2nF?=
 =?us-ascii?Q?xN1d3WNZQudXle6OtIEf6eNtUdtCKnt3bbKcIP8WI1yZPerlWQpGgGsB7yGt?=
 =?us-ascii?Q?+jkOM4nzxUDTmLm49VocPfHvNBLheEDXyKGdoxiJPRXRmWmzF2iKEwZkvtmp?=
 =?us-ascii?Q?EuyPA+cSfqlyotlpUbJbUd8TLXIOBAwURPOmCQdhbgv8/WNFZ9M0KK+bvftT?=
 =?us-ascii?Q?XWE+QWSakjJWvpHUUgBFou/bFNdY1wmSgNUx2+fdwRZPwyyX8lbrdgUBZiaa?=
 =?us-ascii?Q?ZNHZiTro0s5sWPwvxXGSyr0yAazWdPoNMc98+XLTO/Tb1hlaadxW7tHqvzJO?=
 =?us-ascii?Q?DIZiUgi4L8gxURQ1Up0ge8+fpDPdMD1SQHAMtOqbsRhnvTxdcbgCkHMeZ6Vj?=
 =?us-ascii?Q?paCQx7rFKrAq4ng229Zk0aeulAbVOwkSuQjBxfvOaA5B93lRujHBhh/hGpOr?=
 =?us-ascii?Q?DcJeBq6EBssuNc61qUapMCgnfQ1iP2JjT0a/wCyfaNezJnLAr5KjODx82KdY?=
 =?us-ascii?Q?/9o5XAaeBAX8WVetYZLKBYPT0sJObc/ljGPVql/8s/Ih+q6LDyF25S6tEyz2?=
 =?us-ascii?Q?lEVeNUof8p5UZA6/OFPPdlIGBFb1DHDBs+YRw1HnnEAhoJ72jPSuNtOWhFBL?=
 =?us-ascii?Q?QA87Dc3CzbYlyotIDAr55rqtjYC6ktcTkxRPnH74pmB0OtjBCkzqwFUKXcXy?=
 =?us-ascii?Q?N49bxQwpE/m7qTj/s3hfa8t63ASQaw5phcJsGLQZ/YiEGq3/VGs7EUPUcq7z?=
 =?us-ascii?Q?mIevLoqIwopanHV7DCNx9fS6ZjhYjw33bmbp2vAhhOUEGu3kIgrxg/YnVn+l?=
 =?us-ascii?Q?bdkTlujxe6UWHQk6KBU6mncvct7GIvg5o/lqQ1UFfm50zoRHma1Lpvby/SoL?=
 =?us-ascii?Q?aO02JzcjJLHt9Fk9+PAYUfjDm+77vxPB7wwOgp26lsasfNJkG2UhBmRKEuQb?=
 =?us-ascii?Q?HyOv+jIz9of5T7PMGNwhlkkeja9/BpbP3nZz+VPogt2smSeG2kunivMhJ61T?=
 =?us-ascii?Q?XcGyHkDlUJ+QzmCT4t9VsRZ4c+xYVjoeHG+jjQ1ZiA66lBb/INAF9SZ9AXg0?=
 =?us-ascii?Q?K5ifJOz3LYA9otTtTUUCT9Ih8kVpF88aPry8dPlZPTkt3GeQSTwhkD418cNp?=
 =?us-ascii?Q?PxoNDdkkCf/k+RHl2bWsMJ2Zuh3WSw+v74F3EimG6uF1ihs0Tqu97cVQ+yeV?=
 =?us-ascii?Q?pkat1BqQXZCJRhu++LvBk6H0/KqLXae4q1AB1VQSRtBcB6ZLAWOgFiBqF1f+?=
 =?us-ascii?Q?p9OCTYB8raFvfveUwDR4z+goDtvHvvMZrLfzjlmmXkKUcdfDXsAc3/sytGDT?=
 =?us-ascii?Q?35SU+AP/7T4v090Nx1pYyE1DPmk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4572.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcc617f4-bd3f-4c54-d498-08df3feab938
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2026 11:55:47.1827 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4T8Jggtm1mCoXf4uaPineTDp+TVisZn1tiNTYZwk6Lq9itJ+7tTLSNyxCfUE4fGF
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

The public output fence is intentionally not updated for immediate VM
updates. It can also be omitted on intermediate IB submissions. Neither
case removes the need to order a later TLB invalidation after the SDMA
commands have completed.

Keep an owned reference to the latest submission in the update context,
including immediate and rollover submissions. Use that internal fence
for range TLB handling and release it when each context is destroyed.
Leave the public output-fence condition and DONT_PIPELINE policy alone.
Return a nested table clear completion to its outer context so an early
exit can also wait for that clear before finalizing the range.

This establishes completion tracking before adding partial-error range
finalization, so that finalization never depends on a later patch to
recover an already submitted IB's fence.

Signed-off-by: Zihao Mu <zmu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c          | 10 +++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h |  8 +++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c       | 12 +++++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c     |  2 ++
 4 files changed, 25 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/a=
mdgpu/amdgpu_vm.c
index 94b1cfe05e3..1e41f159ced 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -658,7 +658,9 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, stru=
ct amdgpu_vm *vm,
 		bo_base->moved =3D true;
=20
 		if (vm->generation !=3D new_vm_generation) {
-			r =3D amdgpu_vm_pt_clear(adev, vm, to_amdgpu_bo_vm(bo_base->bo), false)=
;
+			r =3D amdgpu_vm_pt_clear(adev, vm,
+					       to_amdgpu_bo_vm(bo_base->bo),
+					       false, NULL);
 			if (r)
 				return r;
 		}
@@ -1081,6 +1083,7 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
 		amdgpu_vm_bo_idle(entry);
=20
 error:
+	dma_fence_put(params.last_update);
 	drm_dev_exit(idx);
 	return r;
 }
@@ -1286,7 +1289,7 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev=
, struct amdgpu_vm *vm,
 		goto error_free;
=20
 	if (params.needs_flush) {
-		amdgpu_vm_tlb_flush(&params, *fence, tlb_cb);
+		amdgpu_vm_tlb_flush(&params, params.last_update, tlb_cb);
 		tlb_cb =3D NULL;
 	}
=20
@@ -1294,6 +1297,7 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev=
, struct amdgpu_vm *vm,
=20
 error_free:
 	kfree(tlb_cb);
+	dma_fence_put(params.last_update);
 	amdgpu_vm_end_critical(&params);
 	drm_dev_exit(idx);
 	return r;
@@ -2710,7 +2714,7 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct=
 amdgpu_vm *vm,
 	if (r)
 		goto error_free_root;
=20
-	r =3D amdgpu_vm_pt_clear(adev, vm, root, false);
+	r =3D amdgpu_vm_pt_clear(adev, vm, root, false, NULL);
 	if (r)
 		goto error_free_root;
=20
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_vm_internal.h
index 8ebb0b03329..71fc1fffaa6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h
@@ -77,6 +77,11 @@ struct amdgpu_vm_update_params {
 	 */
 	struct amdgpu_job *job;
=20
+	/**
+	 * @last_update: owned reference to the last SDMA completion fence
+	 */
+	struct dma_fence *last_update;
+
 	/**
 	 * @num_dw_left: number of dw left for the IB
 	 */
@@ -116,7 +121,8 @@ struct amdgpu_vm_update_funcs {
 };
=20
 int amdgpu_vm_pt_clear(struct amdgpu_device *adev, struct amdgpu_vm *vm,
-		       struct amdgpu_bo_vm *vmbo, bool immediate);
+		       struct amdgpu_bo_vm *vmbo, bool immediate,
+		       struct dma_fence **last_update);
 int amdgpu_vm_pt_create(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 			int level, bool immediate, struct amdgpu_bo_vm **vmbo,
 			int32_t xcp_id);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_vm_pt.c
index c73eb416c0e..9955be111ce 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
@@ -353,6 +353,7 @@ static void amdgpu_vm_pt_next_dfs(struct amdgpu_device =
*adev,
  * @vm: VM to clear BO from
  * @vmbo: BO to clear
  * @immediate: use an immediate update
+ * @last_update: optional output for the internal clear completion fence
  *
  * Root PD needs to be reserved when calling this.
  *
@@ -360,7 +361,8 @@ static void amdgpu_vm_pt_next_dfs(struct amdgpu_device =
*adev,
  * 0 on success, errno otherwise.
  */
 int amdgpu_vm_pt_clear(struct amdgpu_device *adev, struct amdgpu_vm *vm,
-		       struct amdgpu_bo_vm *vmbo, bool immediate)
+		       struct amdgpu_bo_vm *vmbo, bool immediate,
+		       struct dma_fence **last_update)
 {
 	unsigned int level =3D adev->vm_manager.root_level;
 	struct ttm_operation_ctx ctx =3D { true, false };
@@ -390,11 +392,11 @@ int amdgpu_vm_pt_clear(struct amdgpu_device *adev, st=
ruct amdgpu_vm *vm,
 	if (!drm_dev_enter(adev_to_drm(adev), &idx))
 		return -ENODEV;
=20
+	memset(&params, 0, sizeof(params));
 	r =3D vm->update_funcs->map_table(vmbo);
 	if (r)
 		goto exit;
=20
-	memset(&params, 0, sizeof(params));
 	params.adev =3D adev;
 	params.vm =3D vm;
 	params.immediate =3D immediate;
@@ -429,6 +431,9 @@ int amdgpu_vm_pt_clear(struct amdgpu_device *adev, stru=
ct amdgpu_vm *vm,
=20
 	r =3D vm->update_funcs->commit(&params, &vm->last_update);
 exit:
+	if (last_update && params.last_update)
+		swap(*last_update, params.last_update);
+	dma_fence_put(params.last_update);
 	drm_dev_exit(idx);
 	return r;
 }
@@ -543,7 +548,8 @@ static int amdgpu_vm_pt_alloc(struct amdgpu_vm_update_p=
arams *p,
 	 */
 	pt_bo->parent =3D amdgpu_bo_ref(cursor->parent->bo);
 	amdgpu_vm_bo_base_init(entry, p->vm, pt_bo);
-	r =3D amdgpu_vm_pt_clear(p->adev, p->vm, pt, p->immediate);
+	r =3D amdgpu_vm_pt_clear(p->adev, p->vm, pt, p->immediate,
+			       &p->last_update);
 	if (r)
 		goto error_unpin;
=20
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_vm_sdma.c
index ade6c7aa15c..02f3271d96a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
@@ -133,6 +133,8 @@ static int amdgpu_vm_sdma_commit(struct amdgpu_vm_updat=
e_params *p,
 	WARN_ON(ib->length_dw > p->num_dw_left);
 	f =3D amdgpu_job_submit(p->job);
 	p->job =3D NULL;
+	dma_fence_put(p->last_update);
+	p->last_update =3D dma_fence_get(f);
=20
 	if (p->unlocked) {
 		struct dma_fence *tmp =3D dma_fence_get(f);
--=20
2.43.0

