Return-Path: <SRS0=UpsA=OS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2750DC433FE
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Sep 2021 07:16:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4E82611CA
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Sep 2021 07:16:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E4E82611CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7BF4689F97;
	Tue, 28 Sep 2021 07:16:20 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2051.outbound.protection.outlook.com [40.107.244.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA55C89F97
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Sep 2021 07:16:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kG/sSoI/skiKfwNPZlfw3Z8rcpU8P33x8WUMngdg6OQyms+3y/FBQGcBgSFtQwIVXMErX15Djw0Aov4vdKLmeUtFh80IPjgVvH0Y3HJXOLmCm7vz7FJKxUS4S3ryyuvN2r975+uwpkr88H2jdM8gGNq2Ti+nVckPbEc5t01SHnX+q8kEmC4l0qA26rDXurkvCitAyn3eaQwxQgq9smGjDv6yiWpAeeZ2SC4+2rOXCMLLRl/tLqHIG9i9XygMYddiGjyvpU6p6eeP6T2DWUPVd/yoMAINGj26iskHQ6X9rWyAagcKPHxHJlvqnCJekIJ5Z/LcC1eIvclyDeSZHNv4uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=6J71xUtbQ5yrrVmWwRmfWDNkLxdG+r5hFSjyC8+M75w=;
 b=bM6zU5/ityAVCPxmbEppp1rvjBykfvDAQgBjDZ/n0Dvoxdf2Edn5ftGHV38LQxBM2kUfFAVH5NHaxcFtYjEKqCgrJAS7uu2i0Ah1asghpLmtBfEYgPLauRjru5OOo3/4yH2Lha2qJOHbvFzdI9O9ibsOrTH6HJ5JRdTRhnBAJ5D8roh+j4g0+Ah00RwUDZt7UPW8jhmmAB15pjjM/PLnGNmM9rNnjVQQxpTB4ZZo4eJCwcC9zIl0gMnur6e0E356WA65y67Cyr09PvJfJJOZVwuzfsdrzqx+LlgqbrD1LFt9Vh6JAuz9w8yM6VI0tKIHx5SJGhb2HT6ue4GlVNiUsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6J71xUtbQ5yrrVmWwRmfWDNkLxdG+r5hFSjyC8+M75w=;
 b=c+A6AnCYe23qXw3xh/48ofl03RPcveSNYMIPRxnfmT6ZjTZiA7yP5xgKVTLteD8oUOprqYCvoQpRgYaJWzi7rsy3l2bEHbAMUt47JCeAuFLh2KlRvSWuyYj2YOXFot/NAE3mG+XQVJdFMBbVB8Gr1upiwysrlPlftHcDV5frtvg=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by BN9PR12MB5209.namprd12.prod.outlook.com (2603:10b6:408:11a::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15; Tue, 28 Sep
 2021 07:16:16 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::5101:db26:96eb:2ce4]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::5101:db26:96eb:2ce4%7]) with mapi id 15.20.4544.022; Tue, 28 Sep 2021
 07:16:15 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Joshi, Mukul" <Mukul.Joshi@amd.com>,
 "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Yang, Stanley"
 <Stanley.Yang@amd.com>
Subject: RE: [PATCH] amd/amdkfd: add ras page retirement handling for sq/sdma
 (v3)
Thread-Topic: [PATCH] amd/amdkfd: add ras page retirement handling for sq/sdma
 (v3)
Thread-Index: AQHXtDeQ7xr0ToynbUu5J+WZmnvYv6u5COsQ
Date: Tue, 28 Sep 2021 07:16:15 +0000
Message-ID: <BN9PR12MB5257B27B66317BAEF70C79DDFCA89@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20210928070741.30861-1-tao.zhou1@amd.com>
In-Reply-To: <20210928070741.30861-1-tao.zhou1@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=64b8fa4d-43fc-4c06-819e-c64db5c5de7e;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-09-28T07:15:54Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d6d9aed8-bfc7-4c6a-1080-08d9824fdbf7
x-ms-traffictypediagnostic: BN9PR12MB5209:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN9PR12MB5209455B8F17ABDA349CE321FCA89@BN9PR12MB5209.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1051;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ch6joPHWtKtShFmKRmacr/grNm/hQoBxEbQ2BsCtU1n6+fcE9Uv/KL5A0ldsmURT1JyNshdlVsuKByrVNTtwx89T15HkwCrrsOgjQHGjqyVTz0xh5sdIxAP1z2LzNYSik2uJjZZ/kTrwOiycmYcL8+X/GE15TjT+n1wgXlAvH2Qv9lb+u0ZFQeMoK62yLEBlNEnng5L4vcoNmg6Tfz2FI1Ovgfkx5OAXJyEj5zJUA5prQZlbl76dYSWZcIrErWNd47mYnIBobW0z+1fiumHikU4AVkSuCXAKvJOAmGjvsExqvNxLbH39qWy4kZfAprW9DvO0O7S7foz02jG+rhrE9hrHncjoc6pYQ6pF3FtKnrMFkOhPG49TR93KY4mehVpYB091IPiFgah6Fn4R9ne0HH9IaD2XT0E4vqsiLZjlHbzKKqhEk4YxgaxVgnMExW3YZwD068qDpVYb7zj+dJzQwHojC0eT6EWqXsDl1ihW4l7DWZZpbm8DTvllTyUtislfnMogbvP/q9VSqMetVvOPtnGcfGiaI2XToNB0ujYhCUOiWO2rooimFtMBwoOxVTs1hg3nT769yZ58ChB6ryTsO7SQTHEoQ5FyZY3JnPsgSDa5lFHyUcFTZ5uwoMRZti4hJ9CtHsNxO65cxs569HQ2v+T6hqNF6uERwcceCgwhlsnGA18RAhFpLjmUUtLz+uOeC+xCKKsQ2rC0/FbsFAHEQQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(66446008)(66476007)(66556008)(64756008)(38100700002)(2906002)(5660300002)(6636002)(7696005)(66946007)(122000001)(52536014)(508600001)(38070700005)(55016002)(26005)(33656002)(9686003)(110136005)(86362001)(8676002)(8936002)(6506007)(71200400001)(83380400001)(76116006)(53546011)(316002)(186003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gmzvMGTlun2KdyY3YDzcd+hSAVyjJi1dUT76qSJWcjeExTm+8vGuPRAHA8T+?=
 =?us-ascii?Q?5II+WdOs8eJuT6ZPZRQfZisAv/nEQOZ7lfys42P4oi2En27VKeKIgHVifD7i?=
 =?us-ascii?Q?4qm+D+Ej9ueOVQ/Pkj2mvEUVXmROxwkhyFJ5QR5tonKMxibcX/pxOXD8zZRS?=
 =?us-ascii?Q?tqjW14sE+YMhjRyAdCmXBq6f2SnRZfkofxpvbP07XRI/5ZgXjEsC6bvIpfhp?=
 =?us-ascii?Q?5qf4RNQh0idI5ljOQphTN84Q9tD6wOODLPgRdK6RMqr7CChbuaQosIn72AFD?=
 =?us-ascii?Q?LgNq30ujc8Eogbo5ywnsrCqicfrNJOxYpFwN96mO0UR+6EfggXONybsYP4dI?=
 =?us-ascii?Q?WUyR9slJF7Xn5fze5366/FGnEO5G3JDT6JKeApUMV12hgJ2waee7Eytn5Dq2?=
 =?us-ascii?Q?R1P9FoRmjjh9YFaH6EypmhsNskWevn1+JmOz3B04M0yp0wdYnYN3AeWB/jZX?=
 =?us-ascii?Q?USXI1PWPcWL+/pduyua3ybh+7tQ1ljaIIF29DKoKr/oC49HqYR47VPljjDdj?=
 =?us-ascii?Q?AshvLeYumXxfxCJG4Hb/vPqfFtD1UUDqgpLF3fL09acOjbkHPClQvvsol0Iu?=
 =?us-ascii?Q?+G0lTHkdS4AQuLq99pch3eok9kaJwE3XGVhgzRhCKcKuetFweRGUVHOMLUQd?=
 =?us-ascii?Q?zhqJN5XtMVSO5FReF2u2SO/j/licgMZ/f2+9y0CD/OJ0cM2m2unugxV08W0U?=
 =?us-ascii?Q?2LjmiMSc66evCHgM6WX+3GVuF3F9XuKAr6k1dD13ux9MKWb+woILEQ7jK7Gc?=
 =?us-ascii?Q?dzWLCg0vThbJs64ZiKpuhF6PqIJNTUoSV1SSEryrwcXd5ieat/I/NCLApIoC?=
 =?us-ascii?Q?XBvHr8QtasM2ssVSYnzuEnyWwKSPSyIaIMCMTCDrXvFSa7omieiPTIE3JEzE?=
 =?us-ascii?Q?kh5TxkZfdgewdy+pWimqvn07cBfmGiyMnze+zFtXbwzXE2dKOH8/ZAa4Zhcl?=
 =?us-ascii?Q?tJ5/ZXn6nv6cD3hZAQzYMOv1GIRyj/oXDd8sBwxPuHKRjw6CGJmtWVMi9URK?=
 =?us-ascii?Q?7z0B6iNIjypmXPFlNSXPLMWOIGtq1xYudDfieQCBCtkP/kYWLBOuyT3r8VVc?=
 =?us-ascii?Q?4UHHsunWJl5xRi8h7Yuntkspp5gQfeVNehgGQ+lzja7usUZsqZ8DdzNcz9qw?=
 =?us-ascii?Q?iVSqDQAnFqwaIwo40rtRKPsyMzTi9aEBYHiq7j9WzYtrrKubZ6pWjn2kYg2v?=
 =?us-ascii?Q?nIS2qcSlUI5FymNneFtrw8FmA4+EKDyl+QSmbs6Ndy1IifQ+yzKhHbhlbKfJ?=
 =?us-ascii?Q?STUcDtgh3DzI7oIG+ipcFwz/uIGRz8w+D4N/RjCEUAXuFCJm296pmx0PxtGZ?=
 =?us-ascii?Q?D5QqXzva+zo7APyY9nhgiPAM?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6d9aed8-bfc7-4c6a-1080-08d9824fdbf7
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2021 07:16:15.2133 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CTzaDhVcz/jF6rP11xcoz1DjUQdT8fUPc7wyZYZxddVuH2cRkMEh+lFgCsbXHcVhgnhECR3u6BDuBf0MnkKH+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5209
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

[AMD Official Use Only]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Zhou1, Tao <Tao.Zhou1@amd.com>
Sent: Tuesday, September 28, 2021 15:08
To: amd-gfx@lists.freedesktop.org; Zhang, Hawking <Hawking.Zhang@amd.com>; =
Joshi, Mukul <Mukul.Joshi@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com=
>; Yang, Stanley <Stanley.Yang@amd.com>
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
Subject: [PATCH] amd/amdkfd: add ras page retirement handling for sq/sdma (=
v3)

In ras poison mode, page retirement will be handled by the irq handler of t=
he module which consumes corrupted data.

v2: rename ras_process_cb to ras_poison_consumption_handler.
    move the handler's implementation from ASIC specific file to common fil=
e.

v3: call gpu reset for xGMI connected mode.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c      | 14 ++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h      |  1 +
 drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c |  4 ++--
 3 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_amdkfd.c
index 1d41c2c00623..7505f1b9d3f1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -31,6 +31,8 @@
 #include <linux/dma-buf.h>
 #include "amdgpu_xgmi.h"
 #include <uapi/linux/kfd_ioctl.h>
+#include "amdgpu_ras.h"
+#include "amdgpu_umc.h"

 /* Total memory size in system memory and all GPU VRAM. Used to
  * estimate worst case amount of memory to reserve for page tables @@ -780=
,3 +782,15 @@ bool amdgpu_amdkfd_have_atomics_support(struct kgd_dev *kgd)

        return adev->have_atomics_support;
 }
+
+void amdgpu_amdkfd_ras_poison_consumption_handler(struct kgd_dev *kgd)
+{
+       struct amdgpu_device *adev =3D (struct amdgpu_device *)kgd;
+       struct ras_err_data err_data =3D {0, 0, 0, NULL};
+
+       /* CPU MCA will handle page retirement if connected_to_cpu is 1 */
+       if (!adev->gmc.xgmi.connected_to_cpu)
+               amdgpu_umc_process_ras_data_cb(adev, &err_data, NULL);
+       else
+               amdgpu_amdkfd_gpu_reset(kgd);
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_amdkfd.h
index 3bc52b2c604f..7db37e2016df 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -290,6 +290,7 @@ int amdgpu_amdkfd_gpuvm_import_dmabuf(struct kgd_dev *k=
gd,
                                      uint64_t *mmap_offset);
 int amdgpu_amdkfd_get_tile_config(struct kgd_dev *kgd,
                                struct tile_config *config);
+void amdgpu_amdkfd_ras_poison_consumption_handler(struct kgd_dev *kgd);
 #if IS_ENABLED(CONFIG_HSA_AMD)
 void amdgpu_amdkfd_gpuvm_init_mem_limits(void);
 void amdgpu_amdkfd_gpuvm_destroy_cb(struct amdgpu_device *adev, diff --git=
 a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c b/drivers/gpu/drm/amd/am=
dkfd/kfd_int_process_v9.c
index 12d91e53556c..543e7ea75593 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
@@ -231,7 +231,7 @@ static void event_interrupt_wq_v9(struct kfd_dev *dev,
                                if (sq_intr_err !=3D SQ_INTERRUPT_ERROR_TYP=
E_ILLEGAL_INST &&
                                        sq_intr_err !=3D SQ_INTERRUPT_ERROR=
_TYPE_MEMVIOL) {
                                        kfd_signal_poison_consumed_event(de=
v, pasid);
-                                       amdgpu_amdkfd_gpu_reset(dev->kgd);
+                                       amdgpu_amdkfd_ras_poison_consumptio=
n_handler(dev->kgd);
                                        return;
                                }
                                break;
@@ -253,7 +253,7 @@ static void event_interrupt_wq_v9(struct kfd_dev *dev,
                        kfd_signal_event_interrupt(pasid, context_id0 & 0xf=
ffffff, 28);
                } else if (source_id =3D=3D SOC15_INTSRC_SDMA_ECC) {
                        kfd_signal_poison_consumed_event(dev, pasid);
-                       amdgpu_amdkfd_gpu_reset(dev->kgd);
+                       amdgpu_amdkfd_ras_poison_consumption_handler(dev->k=
gd);
                        return;
                }
        } else if (client_id =3D=3D SOC15_IH_CLIENTID_VMC ||
--
2.17.1

