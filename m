Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88414C4332F
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Nov 2023 04:50:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B089410E64E;
	Fri, 10 Nov 2023 04:50:57 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20615.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::615])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D058A10E649
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Nov 2023 04:50:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QEKpKJSr6U5wMq9osvfkyij4ete98UQySxR72KlNWWvLr5GRf/Ur8E1NI3pp/crWjQT+CyGwcG2uLOBVOv2NlQPJdUDaf6vIGVzzwfrqBSjHSv5UfR6tIk4WVn5uB+wNBJ8tJAGfRkf10HeqgkSEIJMtaXdAwvvoutM8pEYqvGSzMLPj2zXP8H3ZJGtNq1u/aEP5zmSQ33mrLjsy8PVQuUJrx6CVlm9XuHK7z36982/H3FCxoatSJMLtyZS7oweYvnV455glBqLK3KLKDgluJjDtgzvEMHMIfg8EjKP27PpryNvPJeYf3FQS/a/ruSi9u32HoA1N7EsZFse4GA3O/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cIIukCylAKsVOl2aPOoTMfIW1FHzppPeAYI2Yt5s1/I=;
 b=dWGPl3nG6flBtyUtFu1JOuBtaiof1NMmhrnFkps4s9yuRsF6i0rhbHMx2TNVz6MN+jFsyT1rdYIZ6RjYtWBOR+VMe+7WJxpu/hvUkaHLS4sMmo9YzwNULq1fg3hROn9q/bGHk/h45svSb7a/GQO3XAcXo5S2I1nTXbHDBgrLQnnO4Gt/Op5PWc9XQnTTUK2zDReovAGk3PwZtsafFbTG5f9G2MicwlIopveS4ihjhmAKC1sGcFD/No8PLU+hSuzfN6vQAQeXiT0wCiXNReEs4dX3lYW/FLsbovjsrsprNW3AAivBqCCKC2kcAFh2FEUWK9K8nt+sdKQ7FYx0OcCulw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cIIukCylAKsVOl2aPOoTMfIW1FHzppPeAYI2Yt5s1/I=;
 b=pRLtqlg9ElcOQaYXY+glYmZew94vIAsGHdFQpwc83Hn6zGPEfsayidw/wbbOq3gQGuuEANar0snAcoqzybInnXoq+AB/Cu3bS8P1jqh6lGsLtWAsmLQ0Yhw1MISNmGaYZhHvJXgoV2tCVqnUkEqfTP2UtKJQBlqnCTkwXrA7TiM=
Received: from DM4PR12MB5165.namprd12.prod.outlook.com (2603:10b6:5:394::9) by
 MN0PR12MB5762.namprd12.prod.outlook.com (2603:10b6:208:375::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29; Fri, 10 Nov
 2023 04:50:45 +0000
Received: from DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::9168:17d3:24ef:6e9f]) by DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::9168:17d3:24ef:6e9f%5]) with mapi id 15.20.6977.019; Fri, 10 Nov 2023
 04:50:45 +0000
From: "Pan, Xinhui" <Xinhui.Pan@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [RFC PATCH v2] drm/amdkfd: Run restore_workers on freezable WQs
Thread-Topic: [RFC PATCH v2] drm/amdkfd: Run restore_workers on freezable WQs
Thread-Index: AQHaEcaq4AaBrmWD4kuPT+8xZWcCKbBy/WWA
Date: Fri, 10 Nov 2023 04:50:45 +0000
Message-ID: <DM4PR12MB5165AF7B85556C13497C405E87AEA@DM4PR12MB5165.namprd12.prod.outlook.com>
References: <20231107220540.3711990-1-Felix.Kuehling@amd.com>
In-Reply-To: <20231107220540.3711990-1-Felix.Kuehling@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=9d9a3b04-35d9-422f-a542-9645e345ff10;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-11-10T04:43:39Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5165:EE_|MN0PR12MB5762:EE_
x-ms-office365-filtering-correlation-id: 53ba9808-bf7b-4ffb-da17-08dbe1a899c6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HNkYWj3hBcAJKO+arGtPGVBFy4mOOkDDGFOeYzWY1wdIPvi2MCyPtL+4eyFYwbXytowmsCTxxBXkSIuQXHVcRlDMLtsQ2v9S2y+qF/T/Z3+NIA5Dx8NTDYz/nd1VvluY7TrrFSoX5JYARzCrGTER2/d1sLuFjdcHER/I/pptNbpynsR4QECjUiVEGUHbInq4MKy7W3oFmJb2PIch/00/VhrkKB5ClyMM8U5fudcXgc2y36i3zv1VtNU1IAlo6Ks6tyTyJlOXXbgRJtDqEQ9to/1w4JZu5rwO7z8Det0KDZufHpcQD0BSSDtqBkJAAg2kWBVdpT+3rr0g7NhHeQaYYqhuOkBWjxV5UNaxsRWZGoIcmeGPHg/PYedMA56X7Uq7UQ5zthCy2IncegX0M/HaqJCPo91A8a9R2TpXoks17ZdgouWQCarQ6px7iFWXvmLkZzbtwBaaaE6jo7gfuJrGOSbvxogYKmHVvhRpdwjLQjCqk4RBILgloN2nJhdxbvNyOPM0/l+rU0JCf+DMtm0zpDfSoWRXDbNjIDv7xEgiU+i/tFRnvL9swPzwP41oVGnCgkM2Nv45H+dL+tcmDEEJR0yWqbqJq1hbRDwTXYUTX9gyju2K2HMJvX4c+C2HGMr/
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5165.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(366004)(346002)(396003)(136003)(39860400002)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(55016003)(478600001)(45080400002)(6506007)(66446008)(54906003)(38070700009)(122000001)(86362001)(33656002)(7696005)(83380400001)(41300700001)(38100700002)(53546011)(66556008)(52536014)(66946007)(76116006)(71200400001)(5660300002)(110136005)(26005)(9686003)(66476007)(64756008)(2906002)(316002)(8936002)(4326008)(8676002)(30864003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8fRWJKsl03tGDGu6AnwzVLkxuWiSSjSsWtxaEXuZeSrp8q08V8MSrlKOO9mf?=
 =?us-ascii?Q?8C9cY3YT6Ywru9TCCLsV2vjC75Odqsd7bvfJbAotmtVRNq8VssHYtY4RGROO?=
 =?us-ascii?Q?acfhARA0dFK6svNRurKiNmlXfLVtuhIGa/RIwiyPd0xdkq92Ft5U5VohFWvt?=
 =?us-ascii?Q?OSELQxNHhkE+g4ZgRx4jEd4PTmZxH+N9ucJSs5IAAbxEueg0h9+enwkrmQ7j?=
 =?us-ascii?Q?e0O+NPB+990Bvmzd/nS7m6wsjjyg59s7fJ5hYa1WnpzyADvihUQOuB6icFdd?=
 =?us-ascii?Q?sXlYls48sK715wptxai8VpoIun5MZ4J21P5iCG1JGtym2VjZjFpkGSYuHT+9?=
 =?us-ascii?Q?pZFvYCl/rwQSKToEeXaOxlhZ9RbyZh/YE3YarwED2K4IiE3VrLCvPKTnMvb3?=
 =?us-ascii?Q?3cei583DPIq85Gyfm+So/so9WgtA4inEb+mYgN7u1ZwniJr0TOlaSGMNzm0e?=
 =?us-ascii?Q?UyCkpBrASZvqIk2lmMCigzmxh579YqK0vENE1Hlmwx1n26/Yel5ilet6Y9lb?=
 =?us-ascii?Q?sA91QSt/btcBnHHOzOdHleZjL5Q9/xBSWn2olRbE9pxzv0wAzMTJlzR1H36k?=
 =?us-ascii?Q?/4mq2v3eRg25+/cGjz1bUlGKe8TpzKKn4E9qBM2pe1m2IJeUx7Q+z7UQ+iI6?=
 =?us-ascii?Q?Qbx0fprquUiA8XZBQ5gXYBF18gN6fnyNmgHjk9lKAHZsYx7eIzrgTsXwUt8y?=
 =?us-ascii?Q?aSCnllpowt9TgGLD7Guk4oEZT+P9CH6ZCH89A2XRiURJ0D+E1jZv4JkOla3x?=
 =?us-ascii?Q?iHAYByIiiq/HQnvsMeXqbph1AFYe1p7rXciJUK2ihaZP914EiA6cUjIfCLbm?=
 =?us-ascii?Q?ha3xTio3IkjM7YczwXIqe7ztalxHedbOsAjhbC2UHQeTSfdruKma4Okwvar/?=
 =?us-ascii?Q?zRR6GnR8+Rl/lcMvtL8PLVjC0b6g7sWYUqQ3H4vdv7db5toxNfOp8Id1bUQ+?=
 =?us-ascii?Q?G5795lrrh/Zjr9aNxwvD+Li6m4MmZRp+5+llmVxf/7P+WT3Va0Yypqe3aCNh?=
 =?us-ascii?Q?eelBul7oHn9v/vzw2gZPqk1WxIVfaWUK1f2P0TWyZojLQZSVCoRCBHHlnRS3?=
 =?us-ascii?Q?iIjVBT0x6k5XL5fspM1I9Bvxw+Nh6LXahAfQELgs2MIWgJioKInxxLRuv1LO?=
 =?us-ascii?Q?07gI+Q55dLOqi2GeqLPQCw8MNp20SWbtvlXm8oTGIoUbviu+BLeePUVz1Bge?=
 =?us-ascii?Q?+Spo5VbOWVoTPA7P/MIqwmELqOCMaIIpQ0UYA4vM/xsAEHLYYWDu3VZaA2vn?=
 =?us-ascii?Q?d3JB6e5A/yl/o7YH+5yuaVOswCcQhl/IQTISJCEiKdH2trAZfD+mk8RRbxMJ?=
 =?us-ascii?Q?doHp7Jeg29tMo70qIyMo1Cz9oDMkZ6hhXXrzl5O5b+OphEPGexAuKwCOY+df?=
 =?us-ascii?Q?B0ylqvjb5u0dMvMOwaaY04ufBc9NGrgdaX5jhvEk3ld10wnZAf3HnZ12BQf2?=
 =?us-ascii?Q?VajG8Crlzd5yPxwNb+MUM9Ww9VntJ0NAw+aGDetysdxg4CMnxa/uMLyCHBKY?=
 =?us-ascii?Q?buoYABBp4aEPJpZMeBMtroIldtoBLhUmiplbo1Bp3vvGu8QPx1XxVurZBClR?=
 =?us-ascii?Q?D/68DfWCYL3miEEfUno=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5165.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53ba9808-bf7b-4ffb-da17-08dbe1a899c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2023 04:50:45.3657 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /EPgQtyj3X/Rj6W2Uy4zZXNvWW9FddJUU+Wu1cJzCjagtuQsypXS1DMDJ7t1Rv6q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5762
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
Cc: "Deng, Emily" <Emily.Deng@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

I once replaced the queue with the freezable one, but got hang in flush.
Looks like Felix has fixed it.

Acked-and-tested-by: xinhui pan <xinhui.pan@amd.com>


-----Original Message-----
From: Kuehling, Felix <Felix.Kuehling@amd.com>
Sent: Wednesday, November 8, 2023 6:06 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deng, Emily <Emily.Deng@amd.com>; Pan, Xinhui <Xinhui.Pan@amd.com>; Koe=
nig, Christian <Christian.Koenig@amd.com>
Subject: [RFC PATCH v2] drm/amdkfd: Run restore_workers on freezable WQs

Make restore workers freezable so we don't have to explicitly flush them in=
 suspend and GPU reset code paths, and we don't accidentally try to restore=
 BOs while the GPU is suspended. Not having to flush restore_work also help=
s avoid lock/fence dependencies in the GPU reset case where we're not allow=
ed to wait for fences.

A side effect of this is, that we can now have multiple concurrent threads =
trying to signal the same eviction fence. Rework eviction fence signaling a=
nd replacement to account for that.

The GPU reset path can no longer rely on restore_process_worker to resume q=
ueues because evict/restore workers can run independently of it. Instead ca=
ll a new restore_process_helper directly.

This is an RFC and request for testing.

v2:
- Reworked eviction fence signaling
- Introduced restore_process_helper

Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 34 ++++++--
 drivers/gpu/drm/amd/amdkfd/kfd_process.c      | 87 +++++++++++--------
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c          |  4 +-
 3 files changed, 81 insertions(+), 44 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu=
/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 54f31a420229..1b33ddc0512e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -1405,7 +1405,6 @@ static int init_kfd_vm(struct amdgpu_vm *vm, void **p=
rocess_info,
                                  amdgpu_amdkfd_restore_userptr_worker);

                *process_info =3D info;
-               *ef =3D dma_fence_get(&info->eviction_fence->base);
        }

        vm->process_info =3D *process_info;
@@ -1436,6 +1435,8 @@ static int init_kfd_vm(struct amdgpu_vm *vm, void **p=
rocess_info,
        list_add_tail(&vm->vm_list_node,
                        &(vm->process_info->vm_list_head));
        vm->process_info->n_vms++;
+
+       *ef =3D dma_fence_get(&vm->process_info->eviction_fence->base);
        mutex_unlock(&vm->process_info->lock);

        return 0;
@@ -1447,10 +1448,7 @@ static int init_kfd_vm(struct amdgpu_vm *vm, void **=
process_info,
 reserve_pd_fail:
        vm->process_info =3D NULL;
        if (info) {
-               /* Two fence references: one in info and one in *ef */
                dma_fence_put(&info->eviction_fence->base);
-               dma_fence_put(*ef);
-               *ef =3D NULL;
                *process_info =3D NULL;
                put_pid(info->pid);
 create_evict_fence_fail:
@@ -1644,7 +1642,8 @@ int amdgpu_amdkfd_criu_resume(void *p)
                goto out_unlock;
        }
        WRITE_ONCE(pinfo->block_mmu_notifications, false);
-       schedule_delayed_work(&pinfo->restore_userptr_work, 0);
+       queue_delayed_work(system_freezable_wq,
+                          &pinfo->restore_userptr_work, 0);

 out_unlock:
        mutex_unlock(&pinfo->lock);
@@ -2458,7 +2457,8 @@ int amdgpu_amdkfd_evict_userptr(struct mmu_interval_n=
otifier *mni,
                                       KFD_QUEUE_EVICTION_TRIGGER_USERPTR);
                if (r)
                        pr_err("Failed to quiesce KFD\n");
-               schedule_delayed_work(&process_info->restore_userptr_work,
+               queue_delayed_work(system_freezable_wq,
+                       &process_info->restore_userptr_work,
                        msecs_to_jiffies(AMDGPU_USERPTR_RESTORE_DELAY_MS));
        }
        mutex_unlock(&process_info->notifier_lock);
@@ -2793,7 +2793,8 @@ static void amdgpu_amdkfd_restore_userptr_worker(stru=
ct work_struct *work)

        /* If validation failed, reschedule another attempt */
        if (evicted_bos) {
-               schedule_delayed_work(&process_info->restore_userptr_work,
+               queue_delayed_work(system_freezable_wq,
+                       &process_info->restore_userptr_work,
                        msecs_to_jiffies(AMDGPU_USERPTR_RESTORE_DELAY_MS));

                kfd_smi_event_queue_restore_rescheduled(mm);
@@ -2802,6 +2803,23 @@ static void amdgpu_amdkfd_restore_userptr_worker(str=
uct work_struct *work)
        put_task_struct(usertask);
 }

+static void replace_eviction_fence(struct dma_fence **ef,
+                                  struct dma_fence *new_ef)
+{
+       struct dma_fence *old_ef =3D rcu_replace_pointer(*ef, new_ef, true
+               /* protected by process_info->lock */);
+
+       /* If we're replacing an unsignaled eviction fence, that fence will
+        * never be signaled, and if anyone is still waiting on that fence,
+        * they will hang forever. This should never happen. We should only
+        * replace the fence in restore_work that only gets scheduled after
+        * eviction work signaled the fence.
+        */
+       WARN_ONCE(!dma_fence_is_signaled(old_ef),
+                 "Replacing unsignaled eviction fence");
+       dma_fence_put(old_ef);
+}
+
 /** amdgpu_amdkfd_gpuvm_restore_process_bos - Restore all BOs for the give=
n
  *   KFD process identified by process_info
  *
@@ -2956,7 +2974,7 @@ int amdgpu_amdkfd_gpuvm_restore_process_bos(void *inf=
o, struct dma_fence **ef)
        }
        dma_fence_put(&process_info->eviction_fence->base);
        process_info->eviction_fence =3D new_fence;
-       *ef =3D dma_fence_get(&new_fence->base);
+       replace_eviction_fence(ef, dma_fence_get(&new_fence->base));

        /* Attach new eviction fence to all BOs except pinned ones */
        list_for_each_entry(mem, &process_info->kfd_bo_list, diff --git a/d=
rivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_pr=
ocess.c
index fbf053001af9..568c49f2f0ab 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -664,7 +664,8 @@ int kfd_process_create_wq(void)
        if (!kfd_process_wq)
                kfd_process_wq =3D alloc_workqueue("kfd_process_wq", 0, 0);
        if (!kfd_restore_wq)
-               kfd_restore_wq =3D alloc_ordered_workqueue("kfd_restore_wq"=
, 0);
+               kfd_restore_wq =3D alloc_ordered_workqueue("kfd_restore_wq"=
,
+                                                        WQ_FREEZABLE);

        if (!kfd_process_wq || !kfd_restore_wq) {
                kfd_process_destroy_wq();
@@ -1637,6 +1638,7 @@ int kfd_process_device_init_vm(struct kfd_process_dev=
ice *pdd,
        struct amdgpu_fpriv *drv_priv;
        struct amdgpu_vm *avm;
        struct kfd_process *p;
+       struct dma_fence *ef;
        struct kfd_node *dev;
        int ret;

@@ -1656,11 +1658,12 @@ int kfd_process_device_init_vm(struct kfd_process_d=
evice *pdd,

        ret =3D amdgpu_amdkfd_gpuvm_acquire_process_vm(dev->adev, avm,
                                                     &p->kgd_process_info,
-                                                    &p->ef);
+                                                    &ef);
        if (ret) {
                pr_err("Failed to create process VM object\n");
                return ret;
        }
+       RCU_INIT_POINTER(p->ef, ef);
        pdd->drm_priv =3D drm_file->private_data;
        atomic64_set(&pdd->tlb_seq, 0);

@@ -1904,6 +1907,21 @@ kfd_process_gpuid_from_node(struct kfd_process *p, s=
truct kfd_node *node,
        return -EINVAL;
 }

+static int signal_eviction_fence(struct kfd_process *p) {
+       struct dma_fence *ef;
+       int ret;
+
+       rcu_read_lock();
+       ef =3D dma_fence_get_rcu_safe(&p->ef);
+       rcu_read_unlock();
+
+       ret =3D dma_fence_signal(ef);
+       dma_fence_put(ef);
+
+       return ret;
+}
+
 static void evict_process_worker(struct work_struct *work)  {
        int ret;
@@ -1916,31 +1934,46 @@ static void evict_process_worker(struct work_struct=
 *work)
         * lifetime of this thread, kfd_process p will be valid
         */
        p =3D container_of(dwork, struct kfd_process, eviction_work);
-       WARN_ONCE(p->last_eviction_seqno !=3D p->ef->seqno,
-                 "Eviction fence mismatch\n");
-
-       /* Narrow window of overlap between restore and evict work
-        * item is possible. Once amdgpu_amdkfd_gpuvm_restore_process_bos
-        * unreserves KFD BOs, it is possible to evicted again. But
-        * restore has few more steps of finish. So lets wait for any
-        * previous restore work to complete
-        */
-       flush_delayed_work(&p->restore_work);

        pr_debug("Started evicting pasid 0x%x\n", p->pasid);
        ret =3D kfd_process_evict_queues(p, KFD_QUEUE_EVICTION_TRIGGER_TTM)=
;
        if (!ret) {
-               dma_fence_signal(p->ef);
-               dma_fence_put(p->ef);
-               p->ef =3D NULL;
-               queue_delayed_work(kfd_restore_wq, &p->restore_work,
+               /* If another thread already signaled the eviction fence,
+                * they are responsible stopping the queues and scheduling
+                * the restore work.
+                */
+               if (!signal_eviction_fence(p))
+                       queue_delayed_work(kfd_restore_wq, &p->restore_work=
,
                                msecs_to_jiffies(PROCESS_RESTORE_TIME_MS));
+               else
+                       kfd_process_restore_queues(p);

                pr_debug("Finished evicting pasid 0x%x\n", p->pasid);
        } else
                pr_err("Failed to evict queues of pasid 0x%x\n", p->pasid);=
  }

+static int restore_process_helper(struct kfd_process *p) {
+       int ret =3D 0;
+
+       /* VMs may not have been acquired yet during debugging. */
+       if (p->kgd_process_info) {
+               ret =3D amdgpu_amdkfd_gpuvm_restore_process_bos(
+                       p->kgd_process_info, &p->ef);
+               if (ret)
+                       return ret;
+       }
+
+       ret =3D kfd_process_restore_queues(p);
+       if (!ret)
+               pr_debug("Finished restoring pasid 0x%x\n", p->pasid);
+       else
+               pr_err("Failed to restore queues of pasid 0x%x\n", p->pasid=
);
+
+       return ret;
+}
+
 static void restore_process_worker(struct work_struct *work)  {
        struct delayed_work *dwork;
@@ -1966,24 +1999,15 @@ static void restore_process_worker(struct work_stru=
ct *work)
         */

        p->last_restore_timestamp =3D get_jiffies_64();
-       /* VMs may not have been acquired yet during debugging. */
-       if (p->kgd_process_info)
-               ret =3D amdgpu_amdkfd_gpuvm_restore_process_bos(p->kgd_proc=
ess_info,
-                                                            &p->ef);
+
+       ret =3D restore_process_helper(p);
        if (ret) {
                pr_debug("Failed to restore BOs of pasid 0x%x, retry after =
%d ms\n",
                         p->pasid, PROCESS_BACK_OFF_TIME_MS);
                ret =3D queue_delayed_work(kfd_restore_wq, &p->restore_work=
,
                                msecs_to_jiffies(PROCESS_BACK_OFF_TIME_MS))=
;
                WARN(!ret, "reschedule restore work failed\n");
-               return;
        }
-
-       ret =3D kfd_process_restore_queues(p);
-       if (!ret)
-               pr_debug("Finished restoring pasid 0x%x\n", p->pasid);
-       else
-               pr_err("Failed to restore queues of pasid 0x%x\n", p->pasid=
);
 }

 void kfd_suspend_all_processes(void)
@@ -1994,14 +2018,9 @@ void kfd_suspend_all_processes(void)

        WARN(debug_evictions, "Evicting all processes");
        hash_for_each_rcu(kfd_processes_table, temp, p, kfd_processes) {
-               cancel_delayed_work_sync(&p->eviction_work);
-               flush_delayed_work(&p->restore_work);
-
                if (kfd_process_evict_queues(p, KFD_QUEUE_EVICTION_TRIGGER_=
SUSPEND))
                        pr_err("Failed to suspend process 0x%x\n", p->pasid=
);
-               dma_fence_signal(p->ef);
-               dma_fence_put(p->ef);
-               p->ef =3D NULL;
+               signal_eviction_fence(p);
        }
        srcu_read_unlock(&kfd_processes_srcu, idx);  } @@ -2013,7 +2032,7 @=
@ int kfd_resume_all_processes(void)
        int ret =3D 0, idx =3D srcu_read_lock(&kfd_processes_srcu);

        hash_for_each_rcu(kfd_processes_table, temp, p, kfd_processes) {
-               if (!queue_delayed_work(kfd_restore_wq, &p->restore_work, 0=
)) {
+               if (restore_process_helper(p)) {
                        pr_err("Restore process %d failed during resume\n",
                               p->pasid);
                        ret =3D -EFAULT;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amd=
kfd/kfd_svm.c
index fe937670c927..aa6c34127be9 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1869,7 +1869,7 @@ static void svm_range_restore_work(struct work_struct=
 *work)
        /* If validation failed, reschedule another attempt */
        if (evicted_ranges) {
                pr_debug("reschedule to restore svm range\n");
-               schedule_delayed_work(&svms->restore_work,
+               queue_delayed_work(system_freezable_wq, &svms->restore_work=
,
                        msecs_to_jiffies(AMDGPU_SVM_RANGE_RESTORE_DELAY_MS)=
);

                kfd_smi_event_queue_restore_rescheduled(mm);
@@ -1945,7 +1945,7 @@ svm_range_evict(struct svm_range *prange, struct mm_s=
truct *mm,
                        pr_debug("failed to quiesce KFD\n");

                pr_debug("schedule to restore svm %p ranges\n", svms);
-               schedule_delayed_work(&svms->restore_work,
+               queue_delayed_work(system_freezable_wq, &svms->restore_work=
,
                        msecs_to_jiffies(AMDGPU_SVM_RANGE_RESTORE_DELAY_MS)=
);
        } else {
                unsigned long s, l;
--
2.34.1

