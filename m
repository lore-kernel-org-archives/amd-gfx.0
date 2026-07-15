Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43099C44508
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jul 2026 14:27:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D0EE110F0E1;
	Wed, 15 Jul 2026 14:27:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CsQ3CMcT";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011046.outbound.protection.outlook.com [52.101.62.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B49110F0E1
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2026 14:27:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nKTGTkPnxevDUXVy8+qrh6s7PzhEVDJINLJPm/r8lwMCmnX0FDusHE1Z7xix27WZ2ULHV1EuKl5GXlOPvsm6Qu8NKhY2lX7tU0A/76fblpve8Ld9phKuqygKMH4Unb6jzzfz81dr+S4f/JUkVEsMXweX2lS43+keUg5PMB5UUq7Q3GW9O85E2+dL1851rxqr9DFYn3uQn8JyScuzFISohBMHQFCdsWl6T/VodEnj831VYb49zq4vZZAjUdqwwcUWBBnmlv7SUmRPQkeIJiSKQzh6NAY5KfUWrMbgG/WJlYCfaETAbAemIg4No2p95pOwnw8sPSgBgwUWWA13yHC0Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kNXgeuC8H++fe/cru1JSyIYmhbRzXjngto5bPAv5xKg=;
 b=YFBdlqGQCSNHcf/h7PA69UCq16I1Xqesz6y5j0vUM27DodklcO9qF5Yp9ZUbE5Gjv2uMMngV7Imvm0lLqM25nS8j80D3ROd/GNGsW6DzjPIR44WidCjQGtTck2jUxNZ6cwEHpvB1ae0orVOukELHa5Siswju9PK/DZI20Rscm/4dZ/h0RsfAmYGGMdCX0HnG8s4NqxD4EYabPmn7p9qEs/C9xxZz9NVPtOo4iFGr7lx3pynlkarkiyKW7HV8SAa6kSmw/tv2warICMLm8S2WlsAUP+jHGvUTQfCQcJVKHpEUJtiED2G2NI4ha/9JeIbSQr5pyqvbcuZGnUIA+zxRjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kNXgeuC8H++fe/cru1JSyIYmhbRzXjngto5bPAv5xKg=;
 b=CsQ3CMcT/g5rHJ7+YP7uJavIugNVEB6tFFcP3soG5NPUXeNwaMzEwgvp+QU6NByp4gAkE7pFsLEFYulMH+JvwjSisPcyjUQ4vGDd0EHICLf2Kz+InCZcwpNfqCW3wnkthaLT+WXSWvs0SpgH/hUEH9u9da2p6vZV/EjATbvGjRs=
Received: from SA3PR12MB7782.namprd12.prod.outlook.com (2603:10b6:806:31c::18)
 by DM6PR12MB4355.namprd12.prod.outlook.com (2603:10b6:5:2a3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.11; Wed, 15 Jul
 2026 14:26:59 +0000
Received: from SA3PR12MB7782.namprd12.prod.outlook.com
 ([fe80::a9df:115c:2208:56f3]) by SA3PR12MB7782.namprd12.prod.outlook.com
 ([fe80::a9df:115c:2208:56f3%5]) with mapi id 15.21.0223.008; Wed, 15 Jul 2026
 14:26:58 +0000
From: "Khatri, Sunil" <Sunil.Khatri@amd.com>
To: "Khatri, Sunil" <Sunil.Khatri@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: dont pin wptr bo instead use eviction fence
Thread-Topic: [PATCH] drm/amdgpu: dont pin wptr bo instead use eviction fence
Thread-Index: AQHdFGW8semtrkpVx06PfuIAL6Ijo7ZuoxcA
Date: Wed, 15 Jul 2026 14:26:58 +0000
Message-ID: <SA3PR12MB77824D81AC0592D03D8D693593F82@SA3PR12MB7782.namprd12.prod.outlook.com>
References: <20260715142444.53373-1-sunil.khatri@amd.com>
In-Reply-To: <20260715142444.53373-1-sunil.khatri@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-07-15T14:26:37.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA3PR12MB7782:EE_|DM6PR12MB4355:EE_
x-ms-office365-filtering-correlation-id: d3a39e3a-d14c-4612-ba07-08dee27d20d5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|22082099003|18002099003|10067099003|38070700021|11063799006|56012099006;
x-microsoft-antispam-message-info: 4SDqmu1xsjhgtbsksaZiPdCSIA/RcHsEjpdvuUYZJnFVmMjd/CSoFD1EBGyDWC95uSrCiPU8O7B98DWPDmq0fnny8lA9Sh+GVUbWtpOM/dvtAqpsbsyWhLptkSEj4AGsIR2uwoUxg1zNguCIZsv2/a3tE5H0YsKhm895kNpeC5pSxxoGvYxFs6N2108WFbFbDFbdZTcA+AcwtlMuonAQc2X8zKEREdhZ7SQIepHl9AEfqR8wEAJutPAbXVc9xyOCQ9ZtqkdKf6kxMWOZunHCJd75MDBJqkU5eFwxdEEPDZkwtU9Pgd/UrFKkNGVC9sDIWQ5C6hKIhY2xg0rhmjhspkxT3M1tSGMi4Fd0UBMJfdGXtE0UOLdnR1AAHRdZPrhJ/QHHayM6RuqvaL73b9YvNXtcdHTDonvGFwVH56KSHSjQB5AHKACRwwNcUcLnw93qpFw0dix+aNBiHC2S5m5HxX5f/roWRBA4jp7grdy8ZjWdg3EuqSGqGvtGliHTT/Ezp0eyx15UmwjXarVQlxSSEKVTxtkmZF+nrIPdv87G7DzySEPGTVNm1zIPhdunP8766CxURGVVt1YA0WjjzST3kO2A5qe4uA85l88qQmpRGEExij0AVWlRZhODqg9gtbM18tGtarahkWnOm7AEjH9YhInNNK3tvwlvBOc2cTEUKfXslTmBgHhoaQE7kzzykLe8VkL4dW3GMu91JcwVDilODi9gtIxhef1CHxZ7U10XzRk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA3PR12MB7782.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(22082099003)(18002099003)(10067099003)(38070700021)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2IaD7utv+gwaSdNftkR9IVudrh3Bl5AJx7CgD4HsqVXfREserrsDw5pzt04B?=
 =?us-ascii?Q?0voSE74WfrtNHEttjfg/n8q/DByovhwVlO743PAaKxf2e1735nqCTGJLJ+iK?=
 =?us-ascii?Q?UkpBmrE0OrZ4fDhBjaTIn5EeQAgB431C8Dyd4l4SbIpixQMSQoYdwusAXNCf?=
 =?us-ascii?Q?vmazkMBSE076HA1mxqVHr4fiKULFnMukUcnzuinV20gGCFQHLZ8QBv2TngBT?=
 =?us-ascii?Q?+wAd8j25WjKQJ/kDcpiNGyhGeZomPZ0k6O7jYdjeMbxVsTBXL81qfi7dgz2R?=
 =?us-ascii?Q?CHMVturuut2CdQYZ2Pzg9Vic2NKBUmMWm3b0afRoSLu2vCZwp2DJH3AjIwl1?=
 =?us-ascii?Q?INATn8I11178jIIuvXk4af7Gy0lTj5+QCoVKZFrH+RwuGMBEsu15o+dTxlq5?=
 =?us-ascii?Q?YjCpsePGB5eA6i3zFmWuBaT7tpHqmjhkQozlqhQ3r29pVwXIpoPOfdQM8JtB?=
 =?us-ascii?Q?LBFtXIxXnbHwSvi1mBEqnjYMBhyF0sMZs8S4QZYpyvdnVQn8BW+b8R6fzbs0?=
 =?us-ascii?Q?+mxASxo/k+zn+LCpx7drTAy1azgpzMnmV+LfmMR4O3jFpF7o2ZkVz5RiglyR?=
 =?us-ascii?Q?KJkBkcpxSJDXcMBfULPnX60VgSaOiftTMdoWuOiKHZKgG9A+2uQihVVHTSgU?=
 =?us-ascii?Q?uw1tKeAgmTIFGOMUq+9kV+/LsC1FKqdvbI0yZYlDEDCtD0lBqHHS3cFWUXJE?=
 =?us-ascii?Q?PwB4MgWrFxRAdeaQD24riy9rGOdc0pbRtPM7zes67DdykkbBUIqG8utdPWp5?=
 =?us-ascii?Q?JS/7dDZTvxGK2V85mOriRNmqvBv4WEa98nLX2kzlE+hxiQS2D3wE6AF7oLTh?=
 =?us-ascii?Q?Z7Ow6sQBFAzalfc9p34xVHwL4OsR/NcuxBSGzT0p8ZQfBlTwG7oYf3NxMYk8?=
 =?us-ascii?Q?Al0IkbBWUe5LWWdeK4M+I/zD3+byxmuyBlLAYawT4aD1mIoBjo9Oz/CM+ltu?=
 =?us-ascii?Q?KH2rqtO7A0Uz1Uj6XYS8WdzwUPS6kc3i5qTmd5AleLq5ZfKZxHoaBvqSuoWd?=
 =?us-ascii?Q?jCL7pSme/Je3buRpgUl6kDo0JG1amziVE6yI2g4akr07mdwrHE3K1YoNJKn1?=
 =?us-ascii?Q?us3TJlfXHMzjkSd9mWRj5voFSldUDXaXGjY7XTVsnhWxsV1bEfr3xqhrW4He?=
 =?us-ascii?Q?SA+kmFB9BVbFCzFU8YzVfczt7IrBRW5tbIbNPt8HUrSMG/JdwTpbOH1tup2U?=
 =?us-ascii?Q?DPu9LXrRN2XMjFwURfTiJjwkP+wlowL1AGFF59Vvookh4T3Td/eyQz8UyjDh?=
 =?us-ascii?Q?doUNpRiflr7Rmo4KYQ/TPGpbPOd7RcafWgtT9+vidagr/Ps7khO/yqbIKyDU?=
 =?us-ascii?Q?nZKJS77utvRfaXzCFnsVwU2PpPWDZmVou4g/rh3XSMJj6rD0gcp9D+eG3Gpy?=
 =?us-ascii?Q?dTEv8+byTKzybSa0+gcrCMmkRgmU5hNJ87Mqse9fOwy7tQ0BMDO7gFzMhfEL?=
 =?us-ascii?Q?CE/Dz+MKm9i89iU24LrgcMReJ8DSWV+5Zx6wSGHmgddmUfVwXDO+CVrqipLp?=
 =?us-ascii?Q?Iqvz7bNBLc5Y1hPATo/9QdlaMQvPLSOUxnZQssjDUPqvHR5/zeK1qWE+Mtpt?=
 =?us-ascii?Q?4duaAmoA3EFLmBUAKu3sK82SPuyaZY4s0A9aN9UQMoAlTDqI6dXidL89R7ri?=
 =?us-ascii?Q?MHT8lhQJg25rDue9Mt3NWP5XGt7u0Rqw53p9PRJ7ZtmRXvTZIqDUScBucJ6J?=
 =?us-ascii?Q?LeY/+iu3hFj44DNPqg8Varf/TQk4yWjvK4wYU+c3RqSOEfSn?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7782.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3a39e3a-d14c-4612-ba07-08dee27d20d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2026 14:26:58.1317 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Cz11ZOnuZ6MtHexsSMji0FhJWE0OKwmc+ZokvBVdgNznXVltZpE0Kg8JGKrhH55LoOjEfOISBezFXh0DD4w2qA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4355
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

AMD General

Adding missing list.

-----Original Message-----
From: Sunil Khatri <sunil.khatri@amd.com>
Sent: Wednesday, July 15, 2026 7:55 PM
To: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Chri=
stian.Koenig@amd.com>
Cc: Khatri, Sunil <Sunil.Khatri@amd.com>
Subject: [PATCH] drm/amdgpu: dont pin wptr bo instead use eviction fence

Instead of pinning the wptr bo attach the eviction fence to the bo to make =
sure it remains valid all the time.

Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c  | 34 ++++++++++++++++++++++  dr=
ivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 17 ++++-------
 2 files changed, 39 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_userq.c
index 911fb325c70c..e1eb689710c8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -936,6 +936,29 @@ static int amdgpu_userq_validate_vm(void *param, struc=
t amdgpu_bo *bo)
        return ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);  }

+static int amdgpu_userq_validate_wptr_bo(struct drm_exec *exec,
+                                        struct amdgpu_usermode_queue *queu=
e) {
+       struct amdgpu_bo *bo =3D queue->wptr_obj.obj;
+       int ret;
+
+       if (!bo)
+               return -EINVAL;
+
+       ret =3D drm_exec_prepare_obj(exec, &bo->tbo.base,
+                                  TTM_NUM_MOVE_FENCES + 1);
+       if (unlikely(ret))
+               return ret;
+
+       ret =3D amdgpu_ttm_alloc_gart(&bo->tbo);
+       if (ret)
+               return ret;
+
+       queue->wptr_obj.gpu_addr =3D amdgpu_bo_gpu_offset(bo);
+
+       return 0;
+}
+
 /* Handle all BOs on the invalidated list, validate them and update the PT=
s */  static int  amdgpu_userq_bo_validate(struct amdgpu_device *adev, stru=
ct drm_exec *exec, @@ -988,6 +1011,7 @@ amdgpu_userq_vm_validate_and_restor=
e_queue(struct amdgpu_userq_mgr *uq_mgr)
        struct amdgpu_vm *vm =3D &fpriv->vm;
        unsigned long key, tmp_key;
        struct amdgpu_bo_va *bo_va;
+       struct amdgpu_usermode_queue *queue;
        struct amdgpu_bo *bo;
        struct drm_exec exec;
        struct xarray xa;
@@ -1094,6 +1118,16 @@ amdgpu_userq_vm_validate_and_restore_queue(struct am=
dgpu_userq_mgr *uq_mgr)
        if (ret)
                goto unlock_all;

+       xa_for_each(&uq_mgr->userq_xa, tmp_key, queue) {
+               ret =3D amdgpu_userq_validate_wptr_bo(&exec, queue);
+               if (unlikely(ret)) {
+                       drm_file_err(uq_mgr->file,
+                                    "failed to validate wptr bo on resume,=
 qid=3D%lu ret=3D%d\n",
+                                    tmp_key, ret);
+                       goto unlock_all;
+               }
+       }
+
        /*
         * We need to wait for all VM updates to finish before restarting t=
he
         * queues. Using the idle list like that is now ok since everything=
 is diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/d=
rm/amd/amdgpu/mes_userqueue.c
index 19c3cb61929c..ab8baaa83e60 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -71,27 +71,23 @@ mes_userq_create_wptr_mapping(struct amdgpu_device *ade=
v,
                ret =3D -EINVAL;
                goto fail_map;
        }
-
-       /* TODO use eviction fence instead of pinning. */
-       ret =3D amdgpu_bo_pin(wptr_obj->obj, AMDGPU_GEM_DOMAIN_GTT);
+       /* Keep WPTR BO under eviction-fence control instead of pinning. */
+       ret =3D amdgpu_evf_mgr_attach_fence(&uq_mgr_to_fpriv(uq_mgr)->evf_m=
gr,
+wptr_obj->obj);
        if (ret) {
-               DRM_ERROR("Failed to pin wptr bo. ret %d\n", ret);
+               DRM_ERROR("Failed to attach eviction fence to wptr bo. ret =
%d\n",
+ret);
                goto fail_map;
        }

        ret =3D amdgpu_ttm_alloc_gart(&wptr_obj->obj->tbo);
        if (ret) {
-               DRM_ERROR("Failed to bind bo to GART. ret %d\n", ret);
-               goto fail_alloc_gart;
+               DRM_ERROR("Failed to bind wptr bo to GART. ret %d\n", ret);
+               goto fail_map;
        }

        queue->wptr_obj.gpu_addr =3D amdgpu_bo_gpu_offset(wptr_obj->obj);

        drm_exec_fini(&exec);
        return 0;
-
-fail_alloc_gart:
-       amdgpu_bo_unpin(wptr_obj->obj);
 fail_map:
        amdgpu_bo_unref(&wptr_obj->obj);
 fail_lock:
@@ -520,9 +516,6 @@ static void mes_userq_mqd_destroy(struct amdgpu_usermod=
e_queue *queue)
        amdgpu_bo_free_kernel(&queue->mqd.obj, &queue->mqd.gpu_addr,
                              &queue->mqd.cpu_ptr);

-       amdgpu_bo_reserve(queue->wptr_obj.obj, true);
-       amdgpu_bo_unpin(queue->wptr_obj.obj);
-       amdgpu_bo_unreserve(queue->wptr_obj.obj);
        amdgpu_bo_unref(&queue->wptr_obj.obj);
 }

--
2.34.1

