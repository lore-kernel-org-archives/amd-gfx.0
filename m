Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1014F606A31C
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Nov 2026 11:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=pr4KN9i5
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7FEE110F65B;
	Tue, 17 Nov 2026 11:40:40 +0000 (UTC)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010062.outbound.protection.outlook.com [52.101.61.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 86FB010F66E
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Nov 2026 11:40:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ux26NVVsMsQ+EHmfyP8O7GgDI38/Np9S646AD1/OaAQBP1Q+UOwV1KYKg9n8tYoeTrv8/20WvcTUsjPfxLGRbcKlslLokykrikHpmgW4fqE/M2VebiDHD2v2qgUnOovgAWygK6Fi57CO+hA+OVKBvw2GIT1UFqFPO6j4Q7Po1SPP6Yy9nY7BuR5o49CVm+jiuXguUtjIg7x1pmqOkAaVBV9oO8HLXdpFkmIKCZ1L2DZTJlm3/Wk/6JIRv1v2XVHKsljI9BzDmakJKmYzoCdqOZ9j8BTM83e1pj/IDMKbROlq+ezvgk4c+LpcHWdRH6VFf8LRiciQr0IuuGzKZg32Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gw/02FwWS2FnCSKn373+Ht6zWtUaiCEcEXP51tG5UuE=;
 b=qoytN9irGQ26q16c2JYSlciygpLNlLopTCVow0L0+8f6N2Szdu3i75vUSObrrIf1OJesEGQEg0hg4HrRf1DekoKpCNPSbq4oW+PFLiK8lwRu8pSa1ddbSNouCakrgVZY3bWsdWTwSYiYSKYbnQs8rBJLPOJdmGhdQlc0noO7qRoxgZ5sOqFc6dlVsOu+pebno3NPXK78tm2bLqCvqbPlspZm244x5mE18AAWhAcoBRasaVsQZIuYoM13SZwQXPzxCRr5eE9PITeCLbSl1eqSf/TgyWN1ojdSwWb+TH7AYHIDDXu7mbxPr12cxhkc9Gpy/okGHcGYaYMwHhRHW0zKnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gw/02FwWS2FnCSKn373+Ht6zWtUaiCEcEXP51tG5UuE=;
 b=pr4KN9i5zIFUxkSAJP45WQGAojrsLWQsoWw7fI2SNX5BbZw63JMWufO2aDnnkTjVeGzYukv6gJBqQpofjzFOou18pGTZGeQ4gV7q5IcaP9mCX+T6tfjeSg5E8zlQuc6ncinNVJIRX6F9Eq0/9L/MlwiFksc+DuMANETCnB7xz2E=
Received: from MW3PR12MB4572.namprd12.prod.outlook.com (2603:10b6:303:5e::7)
 by SN7PR12MB6861.namprd12.prod.outlook.com (2603:10b6:806:266::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Tue, 17 Nov
 2026 11:40:02 +0000
Received: from MW3PR12MB4572.namprd12.prod.outlook.com
 ([fe80::79cb:c567:1825:51fc]) by MW3PR12MB4572.namprd12.prod.outlook.com
 ([fe80::79cb:c567:1825:51fc%6]) with mapi id 15.21.0615.013; Tue, 17 Nov 2026
 11:40:02 +0000
From: "Mu, Zihao" <Zihao.Mu@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, Thadeu Lima de Souza
 Cascardo <cascardo@igalia.com>
Subject: [RFC PATCH v3 4/5] drm/amdgpu: restart VM updates around page-table
 allocation
Thread-Topic: [RFC PATCH v3 4/5] drm/amdgpu: restart VM updates around
 page-table allocation
Thread-Index: AQHddohhlE9t6byZVEycuSiQ7KFyqA==
Date: Tue, 17 Nov 2026 11:40:01 +0000
Message-ID: <MW3PR12MB4572986213556B63A708CA4F9E7B2@MW3PR12MB4572.namprd12.prod.outlook.com>
References: <MW3PR12MB4572FABB93F6676FDBA1D2479E722@MW3PR12MB4572.namprd12.prod.outlook.com>
 <4edd67f7-381a-4446-9509-552739c8f016@amd.com>
 <MW3PR12MB4572A08ADA8CB7BA9F83AF519E712@MW3PR12MB4572.namprd12.prod.outlook.com>
 <938026a1-3b02-40b4-98e3-a0a22f045f82@amd.com>
 <MW3PR12MB4572BEFF9134ABF824D374C79E712@MW3PR12MB4572.namprd12.prod.outlook.com>
 <bf90d631-c63e-4df0-92ad-213bd65ef0ba@amd.com>
In-Reply-To: <bf90d631-c63e-4df0-92ad-213bd65ef0ba@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW3PR12MB4572:EE_|SN7PR12MB6861:EE_
x-ms-office365-filtering-correlation-id: 831fdadf-9a1c-422c-293e-08df449f844c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|261102123227099003|38070700021|261026121527099003|261021121427099003|11063799006|4143699003|56012099006|261022075727099003|261028144727099003|261022105027099003|261026140227099003|261009223027099003|261021123027099003|18002099003|22082099003|6133799003|10067099003|3023799007;
x-microsoft-antispam-message-info: Vq+HVU+x6TZfnS376rtRO2yTQ/G/TAwms0F6UmJ+4rVIzLoczKJD8snMI/cgHgegDGqMkszTIttkZy/jv9NnnnFZLemBfiwyuINEmH1z8yrfF+CjhsHiVB6+e1rVnMIjXmXUWOarVTPPB7qj/Hcbyqc9tPble8UNLsSCfM5xij1UcMWLpVuh8N3SjmSX1KARoWfcFErJSbUbdhWRBQifLS/R1sNYyX3zmiqOmeckrPkBY0Ynff0WaEl70aP9OYZ6LZJXwy9Z6WUA90jqEhZf8BBxXS1rs13w6gd3bkCX22WId7QPjUKQ7ggbT2EPZyKCERtF1mK/XZZCgx8eV/VtOAeWkK5YRnFazMqf3yk1miHAJ54+BsiywvWYq615O7rpsIY1EbslIrSbywbxJztua5jVxoJNImjTcU+YdLd8MLwFmlF5px79reesCJ6AYEjgz8lmpFz9A83Fh6DKxZ2mkqqrtfNEQ+NTPNBerdDyvXc7tAbVq0AzmB1+2QNNIG4S7R0Yd/xKIYep9BE6YkmVGno2W+hY0Pn4l85jAMs8TY//M9mbfU4ldcL8a9gbrGArTD+hazv72PWBWouZ7zc7ZbijDza3aw0JI81UVYBKZHKbfBgAi0XTUFSHc1645j8c9JxnIjjW2u6tjzD8AnYbGY0vY4wZsgCVBwLmAD3yNsEyV0CU69d9zsVIRFPkF3nmUNgFTEomHi3kWMvioJtfvDjywHFzRAao96e4mM5+dnw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR12MB4572.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(261102123227099003)(38070700021)(261026121527099003)(261021121427099003)(11063799006)(4143699003)(56012099006)(261022075727099003)(261028144727099003)(261022105027099003)(261026140227099003)(261009223027099003)(261021123027099003)(18002099003)(22082099003)(6133799003)(10067099003)(3023799007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?OxroJBhMECR17snTtGr8lthMxtmXewUNc4gEqpdK2wOGCO3VfKTCONKA3D+J?=
 =?us-ascii?Q?r0dZeRXto/w734BIbYCSUvDOGmbqJ7k+9vNZ5qLjDI/haBb4yYtIK6/bBYpT?=
 =?us-ascii?Q?NvZeu624+0Py3kIhOPeBfrMI5pk6puq8Q7JstbqlTw5Jc9FEslhdq2v/QKE1?=
 =?us-ascii?Q?9fugVd0EplVN0q9+Jiv/2PquUzC7Qa8Ni27m9K+QEnfQmo2/eFqEVQeoIAPF?=
 =?us-ascii?Q?MqX8x8UGAuHWBKiEjlhXwB2J1PF5P3F/iIBJI1WO0ZP6Zs3TyvoBsQa6YPmi?=
 =?us-ascii?Q?SG/vPUFJ6MsYVJK95HC7de1HE9BvCeOAI5PH6EBanGUTERbSLZxBubuGm9Xf?=
 =?us-ascii?Q?tPrQZZiZ4Rj3wjz0T7OeOs+kn3h0QV5T4Hk8S1GsntQctxF0mn6mPbfeHtZQ?=
 =?us-ascii?Q?4daa3w5KKj1d7DsPY1JI3zDxV9jk3FWWRTAn/c8OfrWYCJ7sYB1/DLLo7Go/?=
 =?us-ascii?Q?JhEqILKnhlIkKJwMY0gj1cFzEk30G/pdawykkX0i9OoVLleeXL19vBkUI4Cd?=
 =?us-ascii?Q?rx/eW2all0+x7w7IPN9ZcUHbn+mGWf3qtKcHOXgjfNicJ5m0qSO8+MnQOOSl?=
 =?us-ascii?Q?UYRz0Vm7ZAtEPZ2Qgl148ehF3Px+sjsl7afbv9uaFOWjuyTqTotSHjMvF3ai?=
 =?us-ascii?Q?FjYtiULffD5Q6RkypxjzsmBiCMC0yNhqTQLlC896+oBhhm4s7/WdZkY+phMe?=
 =?us-ascii?Q?0sgm3dbvuScr4RfcoNT6kdX/yAjxVSXgYjyaKfsSshSuZJIc9K4LeK4SdZ9P?=
 =?us-ascii?Q?9bmJLot8c6EG9tqmtDouCdqbXEDPneYDEX8/vk5E9HDWjn0uKfK9RsVfJ4o5?=
 =?us-ascii?Q?E+/lQHPDvf0aT8ZlgrQCIC0W+vIeYksA4vfHbwpEE2ayfAQur/J3dfsf5rJJ?=
 =?us-ascii?Q?IRlrZrTi8K2VNOmu2c8vYDO8ZWgL2e+T7jGSWkyZUtLGwpE8Tq4bF4A+HH5x?=
 =?us-ascii?Q?rX3XDeIKNrF7kyHrBSxsQND11tAwuOWT/SGPxaHit/u+9NhJX9JcCJ0ozWRc?=
 =?us-ascii?Q?FcuP736z0aMKlrzKo+JdVIIq68QhcflYlYhGgtJQFg69ixbjFF+e6vQLKQQ2?=
 =?us-ascii?Q?lSorndzaFkRq2al/t3OFSibp4yoZE84BUvBN4TJHH0/x/tfKOptWFInmCYbJ?=
 =?us-ascii?Q?0u2wK5QQIXMO4WzMFDid0ZmqvcqdJ+MRu49msmXjR3y0sw/erT//IRWv//NO?=
 =?us-ascii?Q?g2KC7pxcAlSUGMCcpLmzPn+FxjLsUkVTn8AGKsf7Yo9qlbgshZ0LCJTUnN7q?=
 =?us-ascii?Q?ESp/MTR/TqJcjCxSSwyJenaCGdpje9YTZe25EQRAJ5OPFWWqAahKHY3GAUEp?=
 =?us-ascii?Q?OKTq5tTGiWLAKIoynNlNByoR58w6Yk8riuamdi+QhH7lWeqWt9IK1jfr6MVZ?=
 =?us-ascii?Q?omkRCXekMPa/9xCMQ/bXhQmrrk8UnARBQsHKtshmsJ7yhT+bkpdHNkypeGvt?=
 =?us-ascii?Q?0PKCUkHfkojDWu02MPL6PF/rWkyTeU40BFzmWAVK62lNNm6BpzxkWV1w95uB?=
 =?us-ascii?Q?Sa8GUz5sLUQDbw2j69qNU1/sGpSrj9NmqlQISDJCihbQXg+LI09ZHOyx3mg2?=
 =?us-ascii?Q?T3cxylXjCSiUh1BExef54lQtkbnut2o9+KssQhAKeGatA2jQe6uIqX4vIN/2?=
 =?us-ascii?Q?H0UkA6mYzAndYNy4JupNQVJbeBGXUWb+qsInhH0GcbGGXu7HZW12JqnNYkd9?=
 =?us-ascii?Q?Nby8Ty4CRNDGxMF47x1I+Km0FXA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4572.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 831fdadf-9a1c-422c-293e-08df449f844c
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2026 11:40:01.9427 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N5whBrdjSGSzULS+GyhCmf3ANlMRx7+w8+WSkEZZY1s0LJ+AsGTsHftkDugTPxyv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6861
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

Commit the current phase before dropping the eviction lock to allocate
a page table. After clearing the new table, prepare another phase with
the original sync and the context's original job ID.

The eviction lock prevents table movement during a prepared phase.
pt_alloc() drops that lock for allocation, so it must end the phase
first. pt_clear() validates the new table before its own prepare; the
outer prepare then covers move dependencies before resumed writes.
All these submissions preserve immediate and use the same entity.

Finish the nested clear's current job even if its update fails, keeping
the original error. An empty job is freed by commit; a submitted clear
completion is already transferred to the range context for finalization.

Keep an initialized table installed if the outer prepare fails. Failed
initialization uses the existing teardown prerequisite, rather than
introducing another copy of that fix here. Existing tables still return
without ending or restarting the current phase.

Signed-off-by: Zihao Mu <zmu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c          | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h | 5 +++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c       | 8 ++++----
 3 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/a=
mdgpu/amdgpu_vm.c
index 3f3c5a82fc1..df65e02bfa2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1204,6 +1204,7 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev=
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
index 9bd71f4d5b9..cdf14f69376 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h
@@ -87,6 +87,11 @@ struct amdgpu_vm_update_params {
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
index 7b7a576d95f..1a2352c8c8c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
@@ -426,9 +426,6 @@ int amdgpu_vm_pt_clear(struct amdgpu_device *adev, stru=
ct amdgpu_vm *vm,
=20
 	r =3D vm->update_funcs->update(&params, vmbo, addr, 0, entries,
 				     value, flags);
-	if (r)
-		goto exit;
-
 	vm->update_funcs->commit(&params, &vm->last_update);
 exit:
 	if (last_update && params.last_update)
@@ -532,6 +529,9 @@ static int amdgpu_vm_pt_alloc(struct amdgpu_vm_update_p=
arams *p,
 	if (entry->bo)
 		return 0;
=20
+	/* Allocation can add move dependencies while the lock is dropped. */
+	p->vm->update_funcs->commit(p, NULL);
+
 	amdgpu_vm_end_critical(p);
 	r =3D amdgpu_vm_pt_create(p->adev, p->vm, cursor->level, p->immediate,
 				&pt, p->vm->root.bo->xcp_id);
@@ -558,7 +558,7 @@ static int amdgpu_vm_pt_alloc(struct amdgpu_vm_update_p=
arams *p,
 		return r;
 	}
=20
-	return 0;
+	return p->vm->update_funcs->prepare(p, p->sync);
=20
 error_unpin:
 	if (p->vm->is_npa)
--=20
2.43.0

