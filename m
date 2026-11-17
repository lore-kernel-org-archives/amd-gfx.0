Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49969606A31C
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Nov 2026 11:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=0p47Imae
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE8AA10F646;
	Tue, 17 Nov 2026 11:40:37 +0000 (UTC)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010042.outbound.protection.outlook.com
 [52.101.193.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E311D10F647
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Nov 2026 11:40:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kOleI0Im1Sr73mujWfjCR7H3Aw+Sp/C7BEqYEuamnf51g3uBu9Uei22TmSj07yCVpc23CZp96fK0Lxk78Tlga6dwets7OOv6jLazAj2QBYuymw/z1ziisuXwlelCeu9w9yH73f3UdiuihT/GyFd0dIOqe0GXhqiVOMjCPCivYBmSiicHCFcllKa5DC+loEKKNsQOb8rL1DeHRa2p9HSzYWDydS180SBQkREctWd9pY0pUvgbjtg5fKYjJVsC1PHuYR/8GWxjPCUlWUsBpvDH8ufrRBTY0eRERw9HuntJgfWJWQVt4Bc5zd8hZ9F2UjRtSO10Z/fTlwTJH7Do9PVN2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zwWi4nP4n6kq+FUnEUbHCVxZNiqX5SXxzIcUMTucfiA=;
 b=Qhxaaiu/3tbk4aRFxHALwKTmYQL6acd9YeGAuuZnBHE/mzRY/6tyldcD6c9HT0xbL2z/4ANOenscz/RTS0LsnfebCK447N9lcwDVQOleSPBrv2OGghecXQEHDiTTrON/IiVodEhBR2fAAceoClr6F3EsOv0CQfvvrYtX23xr83NFpSY/kJDOtzyewEELqB2D+skjm1/RuZSSRExug51FOl5eR2VzQmiwzvvFy/rcW3rlcL58lRYM2k5fqko62rOWCyw5hRzcUwDcd7eS8m4NWYL2QoDp7QqB9iaiCe+xumQGgTJF8yVJld9W0Eq9exoGCnjtZekSG48uOed9hSs8ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zwWi4nP4n6kq+FUnEUbHCVxZNiqX5SXxzIcUMTucfiA=;
 b=0p47Imae/Z9dHnm1aUiKVdhUg9/o+A9fA0QrOMMQHTEyCAEqqbunNzAt2yGkfBpfVE5hnC7VRS3S8ObkC3ZZlRPu5RHyqlgPUnEh7E4EJ0YoUWTKfWs9UjUnNgXziwQF757AtoZ31vAf8KserwRliU5nYgvIxRgQvuuFsi4YVLM=
Received: from MW3PR12MB4572.namprd12.prod.outlook.com (2603:10b6:303:5e::7)
 by SN7PR12MB6861.namprd12.prod.outlook.com (2603:10b6:806:266::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Tue, 17 Nov
 2026 11:39:53 +0000
Received: from MW3PR12MB4572.namprd12.prod.outlook.com
 ([fe80::79cb:c567:1825:51fc]) by MW3PR12MB4572.namprd12.prod.outlook.com
 ([fe80::79cb:c567:1825:51fc%6]) with mapi id 15.21.0615.013; Tue, 17 Nov 2026
 11:39:53 +0000
From: "Mu, Zihao" <Zihao.Mu@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, Thadeu Lima de Souza
 Cascardo <cascardo@igalia.com>
Subject: [RFC PATCH v3 2/5] drm/amdgpu: track internal completion of SDMA VM
 updates
Thread-Topic: [RFC PATCH v3 2/5] drm/amdgpu: track internal completion of SDMA
 VM updates
Thread-Index: AQHddohcMOlM7iTS3EWImvhWZvcxNQ==
Date: Tue, 17 Nov 2026 11:39:53 +0000
Message-ID: <MW3PR12MB4572710157BE03F990183FC09E7B2@MW3PR12MB4572.namprd12.prod.outlook.com>
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
x-ms-office365-filtering-correlation-id: 307889ff-6d0a-491b-3a7a-08df449f7f4a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|261102123227099003|38070700021|5023799004|261022113327099003|261026121527099003|261021121427099003|11063799006|4143699003|56012099006|261022075727099003|261028144727099003|261022105027099003|261026140227099003|261009223027099003|261021123027099003|18002099003|22082099003|6133799003|10067099003|3023799007;
x-microsoft-antispam-message-info: whe2e38fUWeRY7mDWmrVCchkUgC9I0Ts/DDzmjUPaJwiJD483ZWAhJsx8qJDUdFOj9EC9on/qdx4Bxrmekmz9RZgYMY3NKWqAMY4aeKbKDTxZaOEhG8VjbUi1KOt7r+L+PDI91cIvzcwGJvd9IHo0SNxA952Jur4zKYigep9OMEEsTKnCBljiaUXwITWje1/fisZ36fgWTQ2+Y1FJqJa6K+5wV/21eDTJaQD3tiNHIwEFZAEtDvua4JENWstamhPMu+5hDB8CE9n9hgRijFT7anuQXim9hIxpv2k/TpxPfwK32EqPUudJqRJKmqgYS+9Swe7waIZDdcBMQ0pUK0WSj62SN4SDEL10zgPW+fBm6SY+dgbBWfhVfCNr+eN618LOrr8fPzIOELdhQn/3I5AfjIZq1/Rs+PsE+QKuR+M4K1qXcQ2nsXiyiia2KkUhyvkozplueisbmD/jGYbnlLOpAVn17kiD2H7gnTLjyCLTnJcBF/9WQTNtVEuBfKh82QBRdR1AvZPEvtECfeGK6Y1Om55KMBn1MVTACI0725Tn4NijQ+03qx/gp+nvwoM8UkE2eq90htAJzMKnaG6cx1E6UhQ3XMwvHHdlCthWDlR2v/x6SZk0AMTkmwTGSC0KLSmetaWMTb0QK7yA0QaZ+M1cgewqr41JPXWL5NALhvcbuwOovHCAsydXrdHgHYEnfrjstCAncJypFMm93Kb44KO2SMVq8B62woyxW2suAdWWH0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR12MB4572.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(261102123227099003)(38070700021)(5023799004)(261022113327099003)(261026121527099003)(261021121427099003)(11063799006)(4143699003)(56012099006)(261022075727099003)(261028144727099003)(261022105027099003)(261026140227099003)(261009223027099003)(261021123027099003)(18002099003)(22082099003)(6133799003)(10067099003)(3023799007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?u7PNxd0bT285SwlcVvVE6uy37wIuz/COClRUuU2mGUKOPSEIMFwZcV41EXZX?=
 =?us-ascii?Q?B+4SVItWmmKivm1hcFd1XWg7fTt54lxmp1SEv0VONOc1OrElCASD8vfmz3CY?=
 =?us-ascii?Q?3Ya8lIBr8c2V7bMCupxMERiT8jbVWzQzsKkrM4QvJFvJDRKyZofx4rP8IWO9?=
 =?us-ascii?Q?0eWy+OvsI9T7J1vlXHbGRVv2NkIySWawv2S/JFEliuSQouiB2AWU1N1TfPbY?=
 =?us-ascii?Q?SN7kdkqBTtjntN4Uu5MTcMB7R+VL5RosgIBhRYC8FwjhfNoPn6XovjX2GdON?=
 =?us-ascii?Q?/dQH3P/yZJBUJEvwbcAx7YYM+sRrXQsWYabzM+49TJBbEb/UipA8DZgqBYql?=
 =?us-ascii?Q?qRd8cKv2gdjKlYaDeUCkjdV4NSM8/26YbtBe06+dEphy9LLJnbUwG5S8kCmP?=
 =?us-ascii?Q?OiY5z9QWPNZdL2yEGHP3f4EjbL8611wBgBtBvNgILo1sOmH/1Iflr+kHgL9A?=
 =?us-ascii?Q?a9GiTWRloYZw91X5mpkIhfg0OA1yzepPgLkUrZgCQ2T1tMt0gmwAd0tCifvz?=
 =?us-ascii?Q?7/o6haXKvghfGKAmVYN3YigrGCHJD66l7by7E9SEokf0HYONniUSL/o+PSbT?=
 =?us-ascii?Q?3E6kAfdunXv5jg5yafgYiLxANMDjl7IblzPXRnnIClGkk+FAavOU8nI6+kZD?=
 =?us-ascii?Q?3+kH0Nun9n+Eb70dFeGMjsH6gEyLGjnNWLKjGe2EibPTHraWLKeXEmxfX3xk?=
 =?us-ascii?Q?FIT8wsPbzobzveAlpqMVLP50IQD2WvzJwG4ZHvyXzJSI5BkHzfo18Ia7YPix?=
 =?us-ascii?Q?NqpuS0BrTjQqo6BMlNQ+TtdUOQ6v+7+DCmRgf/cwDrFLnP1izIkfDXpBT1uX?=
 =?us-ascii?Q?gwnniGm9trfBDLORacuEIis+NwfAVDpvXZq4iAXzCQ/k/Ma1I7cIQNqbkgMg?=
 =?us-ascii?Q?uY5TGERegeMWXExU4+xUAQP3MLtnDJg5udASNswS4SImI2ztPF+GSSo9qG/8?=
 =?us-ascii?Q?7S/79K1lYhpR/DW3jhnHabU0i706PG92vIaOFReGHy7TUWGGKcdKZbHGd0qy?=
 =?us-ascii?Q?df0lJHG4Fclp9HLRTJgTdUkGwF4WsIpvMBIM38rK3zmdeUxyYCazcLz4B8t/?=
 =?us-ascii?Q?NuVVOVxTNehTOmsJ6TPR6OJCaNW44DVyRryVrMDgnmWy6/IY/TP7xMyMxok/?=
 =?us-ascii?Q?Vn59nAPTMeC0dcB3AcOGT/bLN1HQQSedJRVRJVS5EgJDN3ff0FzgYpYuCKPJ?=
 =?us-ascii?Q?yfWil3+MLgipvPZ3ty6lvA0Iw1BghxD3gTotHeLHzwipkaacbXSKrnG8iKWM?=
 =?us-ascii?Q?AHdcQMQXaAaj6WeGxQ0lTaC1VRpKEU5eNHHUAK9fgZ13hgd5+6/NiCqD2sXt?=
 =?us-ascii?Q?bNJEFOSe+lmgA19z1Dvby1PEye3f0GsyIJ1Gr6saE1YsMDP9JmftJzlQx1UE?=
 =?us-ascii?Q?PaaLJ5SzB15cXRXsRCfizbNn66yvP+bynvhUISoKwATK9GZG4Tiz6xKBE1k0?=
 =?us-ascii?Q?f0KSU/ylsgFfK0+61eItYzW01OTZ1tKp9jfGbWZKmLI40j08/w833Eoj3FWA?=
 =?us-ascii?Q?+lhxteHZZ0z7iR5qqYEpbOHIFulNmZJ0M4mHDLyu22cskdzaJBkRGQhK0oSU?=
 =?us-ascii?Q?lemSesN1rVh6mizGI8HluquAzbcrYRF1z5q/ZZhtJoJfjr0/2xXpPL9yAW9x?=
 =?us-ascii?Q?FGukYUCG3wp05n5XNzg4icwdV78GPoAUwIBHYCNpj2xK1Kre66njEfA7/KS4?=
 =?us-ascii?Q?CXBinSggEU5YsnmHLVqlXsjr9a0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4572.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 307889ff-6d0a-491b-3a7a-08df449f7f4a
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2026 11:39:53.5851 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NIFyw0XmkebT6Ge26NCzL14F1ZFMuqGZcUyR9wzqD1ThlXZ+1RdhPSBx0v9klxdm
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

Retain the latest SDMA finished fence independently of the optional
public output. A prefix can be submitted before PT allocation fails,
leaving no final job to replace the caller's older output fence. TLB
finalization must still wait for that submitted prefix.

Every phase of a range and its nested PT clear preserves immediate,
so sdma_alloc_job() selects the same VM scheduler entity throughout.
The entity keeps its engine while work is unfinished, and submissions
execute in order there. amdgpu_job_submit() returns the scheduler's
finished fence. Thus the last submitted finished fence covers the
prefix, clear and resumed phase; no cross-entity ordering is assumed.

The context owns last_update. On submission, put the old reference and
get the new finished fence. Missing/empty commits keep the previous
completion. A nested clear transfers its reference to the outer context
by swapping outputs, then puts the displaced reference at exit. Range,
PDE and standalone-clear owners put their private reference at teardown;
TLB finalization obtains its own reference before that put.

Keep the public !immediate output and DONT_PIPELINE policy unchanged.
Track completion before adding partial-range finalization, so the
latter can order its TLB work even after replacement allocation fails.

Signed-off-by: Zihao Mu <zmu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c          | 10 +++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h |  8 +++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c       | 12 +++++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c     |  2 ++
 4 files changed, 25 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/a=
mdgpu/amdgpu_vm.c
index 7199cec1f95..3b4df22c5ed 100644
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
@@ -1079,6 +1081,7 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
 		amdgpu_vm_bo_idle(entry);
=20
 error:
+	dma_fence_put(params.last_update);
 	drm_dev_exit(idx);
 	return r;
 }
@@ -1282,7 +1285,7 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev=
, struct amdgpu_vm *vm,
 	vm->update_funcs->commit(&params, fence);
=20
 	if (params.needs_flush) {
-		amdgpu_vm_tlb_flush(&params, *fence, tlb_cb);
+		amdgpu_vm_tlb_flush(&params, params.last_update, tlb_cb);
 		tlb_cb =3D NULL;
 	}
=20
@@ -1290,6 +1293,7 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev=
, struct amdgpu_vm *vm,
=20
 error_free:
 	kfree(tlb_cb);
+	dma_fence_put(params.last_update);
 	amdgpu_vm_end_critical(&params);
 	drm_dev_exit(idx);
 	return r;
@@ -2706,7 +2710,7 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct=
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
index ea52be053d8..9bd71f4d5b9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h
@@ -82,6 +82,11 @@ struct amdgpu_vm_update_params {
 	 */
 	u64 k_job_id;
=20
+	/**
+	 * @last_update: owned reference to the last SDMA completion fence
+	 */
+	struct dma_fence *last_update;
+
 	/**
 	 * @num_dw_left: number of dw left for the IB
 	 */
@@ -121,7 +126,8 @@ struct amdgpu_vm_update_funcs {
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
index 0ff2d06bf53..7b7a576d95f 100644
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
 	vm->update_funcs->commit(&params, &vm->last_update);
 exit:
+	if (last_update && params.last_update)
+		swap(*last_update, params.last_update);
+	dma_fence_put(params.last_update);
 	drm_dev_exit(idx);
 	return r;
 }
@@ -545,7 +550,8 @@ static int amdgpu_vm_pt_alloc(struct amdgpu_vm_update_p=
arams *p,
 	 */
 	pt_bo->parent =3D amdgpu_bo_ref(cursor->parent->bo);
 	amdgpu_vm_bo_base_init(entry, p->vm, pt_bo);
-	r =3D amdgpu_vm_pt_clear(p->adev, p->vm, pt, p->immediate);
+	r =3D amdgpu_vm_pt_clear(p->adev, p->vm, pt, p->immediate,
+			       &p->last_update);
 	if (r) {
 		/* The entry points to the PT now, take it out again */
 		amdgpu_vm_pt_free(entry);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_vm_sdma.c
index 38ca2d78b38..d2d9a16a7ef 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
@@ -130,6 +130,8 @@ static void amdgpu_vm_sdma_commit(struct amdgpu_vm_upda=
te_params *p,
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

