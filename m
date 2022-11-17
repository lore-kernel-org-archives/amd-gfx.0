Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0637C433FE
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Nov 2022 22:30:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E1E5F10E140;
	Thu, 17 Nov 2022 22:30:42 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2052.outbound.protection.outlook.com [40.107.93.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6F8610E140
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Nov 2022 22:30:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MkTXyJOTQ24T/EgZ4wu9tZy7jZZhqva0UtXEO7jBEcrP+qEbR0XtwrpovgbiVyG2MMqDfwOaiE6Wpxixhu2wPXj4OojjiJoTs86EglRWU72xiAcC2BIguHHh2MEb3B+fcu6TCzC5ewyVZOLW68WMkUMkkqDVOVCAPUNr54o8OQh4zcnCTZwmcJMyq2wQXI+OCVnYew5guEcfr/m2kUkUMEfQYsP3k7PLVMuP0dKkulw7FkHa4bTuJVZszPgr9Ha2VNpTt0JZuZ+amTQMC6JfH72mWnZhhybnw3+moOTbrFqdrRAM/vsDYCsb5VVQ1nP09Ln/bqfdPf7sbAOUme+WmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=26B6ygIXijK8F7oeT2HhvA95O69WFbtGCa6Ai5bF7pc=;
 b=hf7lFMv0B2REnu4vrOxXqyINDFe01CFbALSD+icyDbylnHykkxHQDq9ctQ6WGVCJZGSnvMUXjLHk7SYp+DuY50GPx8WuP1jEZrpeNyUYOvrc6uSBf6axWjC8qzEbFIoa3ZgjExXAQTYD5qKZgXyChOqPIdKUHlE2psyPPn1V+IYWTXDyb8zb2cCfbYGjvW9h05FZKZo97NcLxQ85+FbXR5UM8Ytsj9oDEcRljR54BmcOr3JijEUpfu68kdDbWysHGQK2VKeelxgoOYZ/J9+gMMPakfzTaAi5KHTKHzaRQKre1RF2yt/rWFTWNiC57jqz5c9Ya/xD29atEGxuwNjSNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=26B6ygIXijK8F7oeT2HhvA95O69WFbtGCa6Ai5bF7pc=;
 b=sllZRfA9Pv9CIfKpndyFPPcCTFooMWTGtHUR8uvCVGHzajYzV2IbdbX7V/MXn6TwdxKQyqy5JxXA+aAfbDyV5c67t0g++B9t0WNb/IDboWF9Pre+6DrlaepSjpeo1pYjKUiH5D/ckoxxTsszy91NcvyQdSmO7wR9Ef/LukqOQQA=
Received: from DM6PR12MB2602.namprd12.prod.outlook.com (2603:10b6:5:4a::11) by
 DS0PR12MB6462.namprd12.prod.outlook.com (2603:10b6:8:c6::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5813.17; Thu, 17 Nov 2022 22:30:34 +0000
Received: from DM6PR12MB2602.namprd12.prod.outlook.com
 ([fe80::726a:8c23:ca57:2baa]) by DM6PR12MB2602.namprd12.prod.outlook.com
 ([fe80::726a:8c23:ca57:2baa%7]) with mapi id 15.20.5813.017; Thu, 17 Nov 2022
 22:30:33 +0000
From: "Chen, Xiaogang" <Xiaogang.Chen@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Add notifier lock for KFD userptrs
Thread-Topic: [PATCH] drm/amdgpu: Add notifier lock for KFD userptrs
Thread-Index: AQHY7yg25CDIaTLJT0GfTKyACxtjqK5Dx1Gg
Date: Thu, 17 Nov 2022 22:30:33 +0000
Message-ID: <DM6PR12MB26029BD9044505B23BA1D088E3069@DM6PR12MB2602.namprd12.prod.outlook.com>
References: <20221103020028.832664-1-Felix.Kuehling@amd.com>
In-Reply-To: <20221103020028.832664-1-Felix.Kuehling@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-11-17T22:30:30Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=a05dee04-d56f-4a22-877a-3e0b1789d4d2;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB2602:EE_|DS0PR12MB6462:EE_
x-ms-office365-filtering-correlation-id: a7ec3878-cb1b-4f3e-210e-08dac8eb577c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8h+4f1VTv0AifyHfJXd+i+a+kCqS4wXn1IM7Wrn4hXJ4eAE/vOcw1t1U4zaV58U19rdngQ+7LbjFXZVAYVdCcXWnvxRNzuLEgc65dkfmVKKaWLmEYXWLmtfnME1NgMSLzsM8MEAd745rJcTfuTATck1RVdFUkSlxzP3TrVCY2A/rkaR2Gcn2wZyVdwf1ZJZQ64+GttFL6q0MVR559K76u0CdGEJcNFnEn5myVbNGhKPesnLdRaQJrp69+MUDhHLIEsum239/IsFfsSR4JfW1t2TcRTc9ftuR9hUT4jRzEnlK+lNPc/h77t9m/3/vCZwnXuVr7D6ezdQyKkNoqBo7LEEwoSAg7VNOFrR+ySuHGBv3+rHZWPHJQx7oF7LZD8z8X3F450fO8nNiNS3h2uEIDYRZSgua3Z3peLSSJOj5MBU0UnIX0pCHHQAln52hM9IDQTfTLfW9U3w0PNVxmFOXOlHips72/t1T/fTgjwovI2yETBXLBAJqFPRlITB+9emvUrTN3t/A+dWrSWDGmdGOxNogEaPbSbwEoxU4UmKXX9qieevH6IWcmPhYBJ1C7VmDmUrYCVo9op1HqXkWyRUl3g9OYa8SdvH2pV2e6YQg7Y1Wim4LgSksV3aY1ZRHCf1qhgQ2E0FvDhxD22lky4XA7pPMfTUzTC/sUwSkPM1nCXGfHoINdmWQWsA/GVoJYzmSTRgSBfHYZ1EqNbFW5TEBTrHbz4nT8BMNmUuthP8dobc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2602.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(376002)(39860400002)(366004)(346002)(136003)(451199015)(9686003)(53546011)(316002)(33656002)(26005)(6506007)(55016003)(7696005)(41300700001)(478600001)(2906002)(86362001)(110136005)(8676002)(66476007)(122000001)(64756008)(66946007)(66446008)(76116006)(66556008)(83380400001)(186003)(38100700002)(71200400001)(30864003)(38070700005)(52536014)(8936002)(5660300002)(579004)(309714004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tO/dxX9UqZQquCGVVL32rcKTcsdixXaIn0k+nu74U6EGCMAUx851cJ2gKobl?=
 =?us-ascii?Q?yEiYnQVbhQs5ROjhy8cCgRx2GqSLTwEfmcYsgiiWJ7maNRvH7KayxBxx/2Ur?=
 =?us-ascii?Q?lq16rwkLAW1JnDGDtEc6KVvBYdgpLUp1Lh5L/XgM++XDJKDfL+JW5IXpFHq1?=
 =?us-ascii?Q?aticjYlsGIITkPqHYQOQkJCKaA2qVGemls6Mh7k+UBb7VyEsZcEvRWwepYe1?=
 =?us-ascii?Q?KxZyeYX0MbkspOTgRJ3pPpYB7dEcrwJ0f13eB3VkhsktyXI7kMGmQYqBF3t2?=
 =?us-ascii?Q?sHHkEHoZ70Tn+jntAFp1ezEqVBYGTXrk0jvpjTvxw/6WZN9o1VbkDouxDca5?=
 =?us-ascii?Q?lWjRtNTpepdPm/WbtIY9LC8uWZ5XbF/wAC5vGRg2ZTYQdiN+Hu5lqx9b3LOJ?=
 =?us-ascii?Q?wV4kRWX+t8FNBYOp5EACyRn9duK4Wmekde/vkMRDjkHH0sMbqfPfek8/tS3h?=
 =?us-ascii?Q?x7SMUFaQ9jVdl910qZipKfU3z2VvJxVdT5WlbfGCA2jeHLUfJ7e1x8B1QxFv?=
 =?us-ascii?Q?/6KEWE1r3XAd9vgwF2hP3q6DYupcuK+O5CaoLzjop8RoZbu2otY5gT3xdlXY?=
 =?us-ascii?Q?Rd8asvQABes8lTLEBUMbdxtCrXSx+a2E3VkAN5QO4IjxOFXmKY2lRxu6Wr27?=
 =?us-ascii?Q?leESyWTisEOsEMSRTlUDoJc6iwxiFhSO3rxnmNAix2TjIYuTnIute8p+qBmp?=
 =?us-ascii?Q?PbRY3lbpSTlNYoF27wvbW+41MU/kG+cgivOmtWjOxXnwERJdnVtIfxD5Vuvl?=
 =?us-ascii?Q?gGXDJrMpOTZUmFNWWpH3/wNW9+WfYuvr+E/lfALjNf1WfvEalIWwcDGHWg+e?=
 =?us-ascii?Q?CF9/qprWKReEikbQe9CK/rSkiGnaS0zrok76z/LofrEq2Xp4ofK2UJ7aK5kn?=
 =?us-ascii?Q?Twl09bXf5MawedaxmfGFCwPbRhGzehCTqdOUgRHmUsUculpPE2Om7THptLrF?=
 =?us-ascii?Q?MYN4Ff2jmwUHeG5E8FO3xHzoa1gbD2L/lvEyDTP6ltNHg1OFMBuKGUkIcbVP?=
 =?us-ascii?Q?SGOFWfHQ7hf4tW+dsEL9/0AaS99n4jXF+Cc5nFKDq5wTtyqfnShldvfT/S3i?=
 =?us-ascii?Q?OYLEFE97rfUivku4uxikOGz3whLsjU6qXoeRFb0o+4vwFlYwe6Q4JrvFNyjK?=
 =?us-ascii?Q?KQWjWsLUUoPgSiT1v8vg/tIkl0h18BgGNEseSltv1dy7pPi+aC0b9dhoCcOG?=
 =?us-ascii?Q?IhNglTtUnv/VE+wBykFGJUKftVVvrXfzndxj2HpovXw7otm/Q5egO3zpUEQz?=
 =?us-ascii?Q?70nYhzJooIRT6q8uT67EQY94KNQhJt9ycaIlvU07/FTFzKdXr5MGzVbiimM1?=
 =?us-ascii?Q?52le9Jt3KzZ8ByjOZJVvvPfPDva/EjASWSYMOGZFDJ8WTcPVt0+A9MJD3UqD?=
 =?us-ascii?Q?WZ6wT1TBArKQj57DUxUVQeCi1TZiCq7FXW2rkYokIpElosmHHeeG0hRJb0Hb?=
 =?us-ascii?Q?xU1Wj/ORD2Nw7z+CuwGErHE8uz1QsIK0+U8skgo8zArpebBNQc/rcITrp+eA?=
 =?us-ascii?Q?qlT1w5RWtxewm2HNSpg6p7Th1vwykAElnCqsL0ZgHgrrUTwU3JU9qyBU307S?=
 =?us-ascii?Q?mRqPbQGS3Q99lVg+inM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2602.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7ec3878-cb1b-4f3e-210e-08dac8eb577c
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2022 22:30:33.6656 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BIfS8R8LNssl0/hs0pMPM5gSbZYF7Zomn7nbtU/RyAWHMo8Mo3EXqg76CsXnCLQl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6462
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

[AMD Official Use Only - General]

This patch is:
Reviewed-by: Xiaogang Chen<Xiaogang.Chen@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Felix Ku=
ehling
Sent: Wednesday, November 2, 2022 9:00 PM
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: Add notifier lock for KFD userptrs

Caution: This message originated from an External Source. Use proper cautio=
n when opening attachments, clicking links, or responding.


Add a per-process MMU notifier lock for processing notifiers from userptrs.=
 Use that lock to properly synchronize page table updates with MMU notifier=
s.

Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |  12 +-
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 202 +++++++++++-------
 drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c        |  12 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_mn.h        |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       |  18 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h       |   4 +
 6 files changed, 158 insertions(+), 93 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_amdkfd.h
index f50e3ba4d7a5..1ca18a77818b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -29,6 +29,7 @@
 #include <linux/mm.h>
 #include <linux/kthread.h>
 #include <linux/workqueue.h>
+#include <linux/mmu_notifier.h>
 #include <kgd_kfd_interface.h>
 #include <drm/ttm/ttm_execbuf_util.h>
 #include "amdgpu_sync.h"
@@ -75,7 +76,7 @@ struct kgd_mem {

        uint32_t alloc_flags;

-       atomic_t invalid;
+       uint32_t invalid;
        struct amdkfd_process_info *process_info;

        struct amdgpu_sync sync;
@@ -131,7 +132,8 @@ struct amdkfd_process_info {
        struct amdgpu_amdkfd_fence *eviction_fence;

        /* MMU-notifier related fields */
-       atomic_t evicted_bos;
+       struct mutex notifier_lock;
+       uint32_t evicted_bos;
        struct delayed_work restore_userptr_work;
        struct pid *pid;
        bool block_mmu_notifications;
@@ -180,7 +182,8 @@ int kfd_debugfs_kfd_mem_limits(struct seq_file *m, void=
 *data);  bool amdkfd_fence_check_mm(struct dma_fence *f, struct mm_struct =
*mm);  struct amdgpu_amdkfd_fence *to_amdgpu_amdkfd_fence(struct dma_fence =
*f);  int amdgpu_amdkfd_remove_fence_on_pt_pd_bos(struct amdgpu_bo *bo); -i=
nt amdgpu_amdkfd_evict_userptr(struct kgd_mem *mem, struct mm_struct *mm);
+int amdgpu_amdkfd_evict_userptr(struct mmu_interval_notifier *mni,
+                               unsigned long cur_seq, struct kgd_mem=20
+*mem);
 #else
 static inline
 bool amdkfd_fence_check_mm(struct dma_fence *f, struct mm_struct *mm) @@ -=
201,7 +204,8 @@ int amdgpu_amdkfd_remove_fence_on_pt_pd_bos(struct amdgpu_b=
o *bo)  }

 static inline
-int amdgpu_amdkfd_evict_userptr(struct kgd_mem *mem, struct mm_struct *mm)
+int amdgpu_amdkfd_evict_userptr(struct mmu_interval_notifier *mni,
+                               unsigned long cur_seq, struct kgd_mem=20
+*mem)
 {
        return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu=
/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 955fa8c8213b..5510b7c42ac7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -964,7 +964,9 @@ static int init_user_pages(struct kgd_mem *mem, uint64_=
t user_addr,
                 * later stage when it is scheduled by another ioctl called=
 by
                 * CRIU master process for the target pid for restore.
                 */
-               atomic_inc(&mem->invalid);
+               mutex_lock(&process_info->notifier_lock);
+               mem->invalid++;
+               mutex_unlock(&process_info->notifier_lock);
                mutex_unlock(&process_info->lock);
                return 0;
        }
@@ -1301,6 +1303,7 @@ static int init_kfd_vm(struct amdgpu_vm *vm, void **p=
rocess_info,
                        return -ENOMEM;

                mutex_init(&info->lock);
+               mutex_init(&info->notifier_lock);
                INIT_LIST_HEAD(&info->vm_list_head);
                INIT_LIST_HEAD(&info->kfd_bo_list);
                INIT_LIST_HEAD(&info->userptr_valid_list);
@@ -1317,7 +1320,6 @@ static int init_kfd_vm(struct amdgpu_vm *vm, void **p=
rocess_info,
                }

                info->pid =3D get_task_pid(current->group_leader, PIDTYPE_P=
ID);
-               atomic_set(&info->evicted_bos, 0);
                INIT_DELAYED_WORK(&info->restore_userptr_work,
                                  amdgpu_amdkfd_restore_userptr_worker);

@@ -1372,6 +1374,7 @@ static int init_kfd_vm(struct amdgpu_vm *vm, void **p=
rocess_info,
                put_pid(info->pid);
 create_evict_fence_fail:
                mutex_destroy(&info->lock);
+               mutex_destroy(&info->notifier_lock);
                kfree(info);
        }
        return ret;
@@ -1496,6 +1499,7 @@ void amdgpu_amdkfd_gpuvm_destroy_cb(struct amdgpu_dev=
ice *adev,
                cancel_delayed_work_sync(&process_info->restore_userptr_wor=
k);
                put_pid(process_info->pid);
                mutex_destroy(&process_info->lock);
+               mutex_destroy(&process_info->notifier_lock);
                kfree(process_info);
        }
 }
@@ -1548,7 +1552,9 @@ int amdgpu_amdkfd_criu_resume(void *p)

        mutex_lock(&pinfo->lock);
        pr_debug("scheduling work\n");
-       atomic_inc(&pinfo->evicted_bos);
+       mutex_lock(&pinfo->notifier_lock);
+       pinfo->evicted_bos++;
+       mutex_unlock(&pinfo->notifier_lock);
        if (!READ_ONCE(pinfo->block_mmu_notifications)) {
                ret =3D -EINVAL;
                goto out_unlock;
@@ -1773,8 +1779,13 @@ int amdgpu_amdkfd_gpuvm_free_memory_of_gpu(
        list_del(&bo_list_entry->head);
        mutex_unlock(&process_info->lock);

-       /* No more MMU notifiers */
-       amdgpu_mn_unregister(mem->bo);
+       /* Cleanup user pages and MMU notifiers */
+       if (amdgpu_ttm_tt_get_usermm(mem->bo->tbo.ttm)) {
+               amdgpu_mn_unregister(mem->bo);
+               mutex_lock(&process_info->notifier_lock);
+               amdgpu_ttm_tt_discard_user_pages(mem->bo->tbo.ttm);
+               mutex_unlock(&process_info->notifier_lock);
+       }

        ret =3D reserve_bo_and_cond_vms(mem, NULL, BO_VM_ALL, &ctx);
        if (unlikely(ret))
@@ -1864,14 +1875,14 @@ int amdgpu_amdkfd_gpuvm_map_memory_to_gpu(
         */
        mutex_lock(&mem->process_info->lock);

-       /* Lock mmap-sem. If we find an invalid userptr BO, we can be
+       /* Lock notifier lock. If we find an invalid userptr BO, we can=20
+ be
         * sure that the MMU notifier is no longer running
         * concurrently and the queues are actually stopped
         */
        if (amdgpu_ttm_tt_get_usermm(bo->tbo.ttm)) {
-               mmap_write_lock(current->mm);
-               is_invalid_userptr =3D atomic_read(&mem->invalid);
-               mmap_write_unlock(current->mm);
+               mutex_lock(&mem->process_info->notifier_lock);
+               is_invalid_userptr =3D !!mem->invalid;
+               mutex_unlock(&mem->process_info->notifier_lock);
        }

        mutex_lock(&mem->lock);
@@ -2251,34 +2262,38 @@ int amdgpu_amdkfd_gpuvm_import_dmabuf(struct amdgpu=
_device *adev,
  *
  * Runs in MMU notifier, may be in RECLAIM_FS context. This means it
  * cannot do any memory allocations, and cannot take any locks that
- * are held elsewhere while allocating memory. Therefore this is as
- * simple as possible, using atomic counters.
+ * are held elsewhere while allocating memory.
  *
  * It doesn't do anything to the BO itself. The real work happens in
  * restore, where we get updated page addresses. This function only
  * ensures that GPU access to the BO is stopped.
  */
-int amdgpu_amdkfd_evict_userptr(struct kgd_mem *mem,
-                               struct mm_struct *mm)
+int amdgpu_amdkfd_evict_userptr(struct mmu_interval_notifier *mni,
+                               unsigned long cur_seq, struct kgd_mem=20
+*mem)
 {
        struct amdkfd_process_info *process_info =3D mem->process_info;
-       int evicted_bos;
        int r =3D 0;

-       /* Do not process MMU notifications until stage-4 IOCTL is received=
 */
+       /* Do not process MMU notifications during CRIU restore until
+        * KFD_CRIU_OP_RESUME IOCTL is received
+        */
        if (READ_ONCE(process_info->block_mmu_notifications))
                return 0;

-       atomic_inc(&mem->invalid);
-       evicted_bos =3D atomic_inc_return(&process_info->evicted_bos);
-       if (evicted_bos =3D=3D 1) {
+       mutex_lock(&process_info->notifier_lock);
+       mmu_interval_set_seq(mni, cur_seq);
+
+       mem->invalid++;
+       if (++process_info->evicted_bos =3D=3D 1) {
                /* First eviction, stop the queues */
-               r =3D kgd2kfd_quiesce_mm(mm, KFD_QUEUE_EVICTION_TRIGGER_USE=
RPTR);
+               r =3D kgd2kfd_quiesce_mm(mni->mm,
+                                     =20
+ KFD_QUEUE_EVICTION_TRIGGER_USERPTR);
                if (r)
                        pr_err("Failed to quiesce KFD\n");
                schedule_delayed_work(&process_info->restore_userptr_work,
                        msecs_to_jiffies(AMDGPU_USERPTR_RESTORE_DELAY_MS));
        }
+       mutex_unlock(&process_info->notifier_lock);

        return r;
 }
@@ -2295,49 +2310,54 @@ static int update_invalid_user_pages(struct amdkfd_=
process_info *process_info,
        struct kgd_mem *mem, *tmp_mem;
        struct amdgpu_bo *bo;
        struct ttm_operation_ctx ctx =3D { false, false };
-       int invalid, ret;
+       uint32_t invalid;
+       int ret =3D 0;

-       /* Move all invalidated BOs to the userptr_inval_list and
-        * release their user pages by migration to the CPU domain
-        */
+       mutex_lock(&process_info->notifier_lock);
+
+       /* Move all invalidated BOs to the userptr_inval_list */
        list_for_each_entry_safe(mem, tmp_mem,
                                 &process_info->userptr_valid_list,
-                                validate_list.head) {
-               if (!atomic_read(&mem->invalid))
-                       continue; /* BO is still valid */
-
-               bo =3D mem->bo;
-
-               if (amdgpu_bo_reserve(bo, true))
-                       return -EAGAIN;
-               amdgpu_bo_placement_from_domain(bo, AMDGPU_GEM_DOMAIN_CPU);
-               ret =3D ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
-               amdgpu_bo_unreserve(bo);
-               if (ret) {
-                       pr_err("%s: Failed to invalidate userptr BO\n",
-                              __func__);
-                       return -EAGAIN;
-               }
-
-               list_move_tail(&mem->validate_list.head,
-                              &process_info->userptr_inval_list);
-       }
-
-       if (list_empty(&process_info->userptr_inval_list))
-               return 0; /* All evicted userptr BOs were freed */
+                                validate_list.head)
+               if (mem->invalid)
+                       list_move_tail(&mem->validate_list.head,
+                                     =20
+ &process_info->userptr_inval_list);

        /* Go through userptr_inval_list and update any invalid user_pages =
*/
        list_for_each_entry(mem, &process_info->userptr_inval_list,
                            validate_list.head) {
-               invalid =3D atomic_read(&mem->invalid);
+               invalid =3D mem->invalid;
                if (!invalid)
                        /* BO hasn't been invalidated since the last
-                        * revalidation attempt. Keep its BO list.
+                        * revalidation attempt. Keep its page list.
                         */
                        continue;

                bo =3D mem->bo;

+               amdgpu_ttm_tt_discard_user_pages(bo->tbo.ttm);
+
+               /* BO reservations and getting user pages (hmm_range_fault)
+                * must happen outside the notifier lock
+                */
+               mutex_unlock(&process_info->notifier_lock);
+
+               /* Move the BO to system (CPU) domain if necessary to unmap
+                * and free the SG table
+                */
+               if (bo->tbo.resource->mem_type !=3D TTM_PL_SYSTEM) {
+                       if (amdgpu_bo_reserve(bo, true))
+                               return -EAGAIN;
+                       amdgpu_bo_placement_from_domain(bo, AMDGPU_GEM_DOMA=
IN_CPU);
+                       ret =3D ttm_bo_validate(&bo->tbo, &bo->placement, &=
ctx);
+                       amdgpu_bo_unreserve(bo);
+                       if (ret) {
+                               pr_err("%s: Failed to invalidate userptr BO=
\n",
+                                      __func__);
+                               return -EAGAIN;
+                       }
+               }
+
                /* Get updated user pages */
                ret =3D amdgpu_ttm_tt_get_user_pages(bo, bo->tbo.ttm->pages=
);
                if (ret) {
@@ -2352,30 +2372,31 @@ static int update_invalid_user_pages(struct amdkfd_=
process_info *process_info,
                         */
                        if (ret !=3D -EFAULT)
                                return ret;
-               } else {
-
-                       /*
-                        * FIXME: Cannot ignore the return code, must hold
-                        * notifier_lock
-                        */
-                       amdgpu_ttm_tt_get_user_pages_done(bo->tbo.ttm);
+                       ret =3D 0;
                }

+               mutex_lock(&process_info->notifier_lock);
+
                /* Mark the BO as valid unless it was invalidated
                 * again concurrently.
                 */
-               if (atomic_cmpxchg(&mem->invalid, invalid, 0) !=3D invalid)
-                       return -EAGAIN;
+               if (mem->invalid !=3D invalid) {
+                       ret =3D -EAGAIN;
+                       goto unlock_out;
+               }
+               mem->invalid =3D 0;
        }

-       return 0;
+unlock_out:
+       mutex_unlock(&process_info->notifier_lock);
+
+       return ret;
 }

 /* Validate invalid userptr BOs
  *
- * Validates BOs on the userptr_inval_list, and moves them back to the
- * userptr_valid_list. Also updates GPUVM page tables with new page
- * addresses and waits for the page table updates to complete.
+ * Validates BOs on the userptr_inval_list. Also updates GPUVM page=20
+ tables
+ * with new page addresses and waits for the page table updates to complet=
e.
  */
 static int validate_invalid_user_pages(struct amdkfd_process_info *process=
_info)  { @@ -2446,9 +2467,6 @@ static int validate_invalid_user_pages(stru=
ct amdkfd_process_info *process_info)
                        }
                }

-               list_move_tail(&mem->validate_list.head,
-                              &process_info->userptr_valid_list);
-
                /* Update mapping. If the BO was not validated
                 * (because we couldn't get user pages), this will
                 * clear the page table entries, which will result in @@ -2=
464,7 +2482,9 @@ static int validate_invalid_user_pages(struct amdkfd_proce=
ss_info *process_info)
                        if (ret) {
                                pr_err("%s: update PTE failed\n", __func__)=
;
                                /* make sure this gets validated again */
-                               atomic_inc(&mem->invalid);
+                               mutex_lock(&process_info->notifier_lock);
+                               mem->invalid++;
+                              =20
+ mutex_unlock(&process_info->notifier_lock);
                                goto unreserve_out;
                        }
                }
@@ -2484,6 +2504,32 @@ static int validate_invalid_user_pages(struct amdkfd=
_process_info *process_info)
        return ret;
 }

+/* Confirm that all user pages are valid while holding the notifier=20
+lock
+ *
+ * Moves valid BOs from the userptr_inval_list back to userptr_val_list.
+ */
+static int confirm_valid_user_pages_locked(struct amdkfd_process_info=20
+*process_info) {
+       struct kgd_mem *mem, *tmp_mem;
+       int ret =3D 0;
+
+       list_for_each_entry_safe(mem, tmp_mem,
+                                &process_info->userptr_inval_list,
+                                validate_list.head) {
+               if (!amdgpu_ttm_tt_get_user_pages_done(mem->bo->tbo.ttm)) {
+                       WARN(!mem->invalid, "Invalid BO not marked invalid"=
);
+                       ret =3D -EAGAIN;
+                       continue;
+               }
+               WARN(mem->invalid, "Valid BO is marked invalid");
+
+               list_move_tail(&mem->validate_list.head,
+                              &process_info->userptr_valid_list);
+       }
+
+       return ret;
+}
+
 /* Worker callback to restore evicted userptr BOs
  *
  * Tries to update and validate all userptr BOs. If successful and no @@ -=
2498,9 +2544,11 @@ static void amdgpu_amdkfd_restore_userptr_worker(struct =
work_struct *work)
                             restore_userptr_work);
        struct task_struct *usertask;
        struct mm_struct *mm;
-       int evicted_bos;
+       uint32_t evicted_bos;

-       evicted_bos =3D atomic_read(&process_info->evicted_bos);
+       mutex_lock(&process_info->notifier_lock);
+       evicted_bos =3D process_info->evicted_bos;
+       mutex_unlock(&process_info->notifier_lock);
        if (!evicted_bos)
                return;

@@ -2523,9 +2571,6 @@ static void amdgpu_amdkfd_restore_userptr_worker(stru=
ct work_struct *work)
         * and we can just restart the queues.
         */
        if (!list_empty(&process_info->userptr_inval_list)) {
-               if (atomic_read(&process_info->evicted_bos) !=3D evicted_bo=
s)
-                       goto unlock_out; /* Concurrent eviction, try again =
*/
-
                if (validate_invalid_user_pages(process_info))
                        goto unlock_out;
        }
@@ -2534,10 +2579,17 @@ static void amdgpu_amdkfd_restore_userptr_worker(st=
ruct work_struct *work)
         * be a first eviction that calls quiesce_mm. The eviction
         * reference counting inside KFD will handle this case.
         */
-       if (atomic_cmpxchg(&process_info->evicted_bos, evicted_bos, 0) !=3D
-           evicted_bos)
-               goto unlock_out;
-       evicted_bos =3D 0;
+       mutex_lock(&process_info->notifier_lock);
+       if (process_info->evicted_bos !=3D evicted_bos)
+               goto unlock_notifier_out;
+
+       if (confirm_valid_user_pages_locked(process_info)) {
+               WARN(1, "User pages unexpectedly invalid");
+               goto unlock_notifier_out;
+       }
+
+       process_info->evicted_bos =3D evicted_bos =3D 0;
+
        if (kgd2kfd_resume_mm(mm)) {
                pr_err("%s: Failed to resume KFD\n", __func__);
                /* No recovery from this failure. Probably the CP is @@ -25=
45,6 +2597,8 @@ static void amdgpu_amdkfd_restore_userptr_worker(struct wor=
k_struct *work)
                 */
        }

+unlock_notifier_out:
+       mutex_unlock(&process_info->notifier_lock);
 unlock_out:
        mutex_unlock(&process_info->lock);

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c b/drivers/gpu/drm/amd/a=
mdgpu/amdgpu_mn.c
index b86c0b8252a5..93b6a2a7d64c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c
@@ -102,17 +102,11 @@ static bool amdgpu_mn_invalidate_hsa(struct mmu_inter=
val_notifier *mni,
                                     unsigned long cur_seq)  {
        struct amdgpu_bo *bo =3D container_of(mni, struct amdgpu_bo, notifi=
er);
-       struct amdgpu_device *adev =3D amdgpu_ttm_adev(bo->tbo.bdev);

        if (!mmu_notifier_range_blockable(range))
                return false;

-       mutex_lock(&adev->notifier_lock);
-
-       mmu_interval_set_seq(mni, cur_seq);
-
-       amdgpu_amdkfd_evict_userptr(bo->kfd_bo, bo->notifier.mm);
-       mutex_unlock(&adev->notifier_lock);
+       amdgpu_amdkfd_evict_userptr(mni, cur_seq, bo->kfd_bo);

        return true;
 }
@@ -231,9 +225,9 @@ int amdgpu_hmm_range_get_pages(struct mmu_interval_noti=
fier *notifier,
        return r;
 }

-int amdgpu_hmm_range_get_pages_done(struct hmm_range *hmm_range)
+bool amdgpu_hmm_range_get_pages_done(struct hmm_range *hmm_range)
 {
-       int r;
+       bool r;

        r =3D mmu_interval_read_retry(hmm_range->notifier,
                                    hmm_range->notifier_seq); diff --git a/=
drivers/gpu/drm/amd/amdgpu/amdgpu_mn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_=
mn.h
index 14a3c1864085..b37fcf99baf1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.h
@@ -29,13 +29,14 @@
 #include <linux/rwsem.h>
 #include <linux/workqueue.h>
 #include <linux/interval_tree.h>
+#include <linux/mmu_notifier.h>

 int amdgpu_hmm_range_get_pages(struct mmu_interval_notifier *notifier,
                               struct mm_struct *mm, struct page **pages,
                               uint64_t start, uint64_t npages,
                               struct hmm_range **phmm_range, bool readonly=
,
                               bool mmap_locked, void *owner); -int amdgpu_=
hmm_range_get_pages_done(struct hmm_range *hmm_range);
+bool amdgpu_hmm_range_get_pages_done(struct hmm_range *hmm_range);

 #if defined(CONFIG_HMM_MIRROR)
 int amdgpu_mn_register(struct amdgpu_bo *bo, unsigned long addr); diff --g=
it a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/a=
mdgpu_ttm.c
index 585460ab8dfd..5f2b87dd5732 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -706,8 +706,20 @@ int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo,=
 struct page **pages)
        return r;
 }

+/* amdgpu_ttm_tt_discard_user_pages - Discard range and pfn array=20
+allocations  */ void amdgpu_ttm_tt_discard_user_pages(struct ttm_tt=20
+*ttm) {
+       struct amdgpu_ttm_tt *gtt =3D (void *)ttm;
+
+       if (gtt && gtt->userptr && gtt->range) {
+               amdgpu_hmm_range_get_pages_done(gtt->range);
+               gtt->range =3D NULL;
+       }
+}
+
 /*
- * amdgpu_ttm_tt_userptr_range_done - stop HMM track the CPU page table ch=
ange
+ * amdgpu_ttm_tt_get_user_pages_done - stop HMM track the CPU page=20
+ table change
  * Check if the pages backing this ttm range have been invalidated
  *
  * Returns: true if pages are still valid @@ -727,10 +739,6 @@ bool amdgpu=
_ttm_tt_get_user_pages_done(struct ttm_tt *ttm)
                "No user pages to check\n");

        if (gtt->range) {
-               /*
-                * FIXME: Must always hold notifier_lock for this, and must
-                * not ignore the return code.
-                */
                r =3D amdgpu_hmm_range_get_pages_done(gtt->range);
                gtt->range =3D NULL;
        }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ttm.h
index 9120ae80ef52..58b70d862437 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
@@ -158,6 +158,7 @@ uint64_t amdgpu_ttm_domain_start(struct amdgpu_device *=
adev, uint32_t type);

 #if IS_ENABLED(CONFIG_DRM_AMDGPU_USERPTR)
 int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo, struct page **pages=
);
+void amdgpu_ttm_tt_discard_user_pages(struct ttm_tt *ttm);
 bool amdgpu_ttm_tt_get_user_pages_done(struct ttm_tt *ttm);  #else  static=
 inline int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo, @@ -165,6 +1=
66,9 @@ static inline int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo=
,  {
        return -EPERM;
 }
+static void amdgpu_ttm_tt_discard_user_pages(struct ttm_tt *ttm) { }
 static inline bool amdgpu_ttm_tt_get_user_pages_done(struct ttm_tt *ttm)  =
{
        return false;
--
2.32.0
