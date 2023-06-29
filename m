Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC3EDEB64D9
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Jun 2023 22:03:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C68F10E0AE;
	Thu, 29 Jun 2023 22:03:32 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2078.outbound.protection.outlook.com [40.107.93.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 491E28902A
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Jun 2023 22:03:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mTgyddJ89By+YX+s/dFkkAy73+Ittt9AvJhTnifCQElc9wqUcQ6eePPgnduWMUXgaDEVtH6yxXIb+1Qq5QgSX96fLyvCA+5pOwju3c0twf4PtEgY4fcdwerSGh7nLR/5dfuKRdZOUmyxWNPKYGDxaD/ftK2sQXSbn2vOoB8vwSXzo0l/OCPs1EOHIfsC90GJbmjyTrTd1ALR7z5ZCVuFJf5WGgJqh1f4PO9i3N4PBeIM9DB1eoRyq3lcykN0OqtNV0kdSvCo41COM3ynsSBqwLrQPOkNl4JVglvKrOLAmZ+b/h6Gn2OdMY3dCDD6E8wiHThbJUxVeIBbo5qXrdwDOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8FpwM5tt3a6jyjn0ZEiSB7QiR8labvpC07D/IGvEQss=;
 b=Ib/ke0goFvdPtu8DLC2Egx1fZ7ho3mJfm5FxijNuXH1va3Ybla7EnndbxRRp3ELTDkaBj83T/LllJnPrVWzoOAvXoWx8CoK/1y8Xica+9bXoo7NywMmPU/w7H5P/ZJeqc2WEI8iE7wUUjZXqgSPzF1H3UW5gXuzP1Y7dTJDwqrDtdBm6FiQFnF2BLqp251pRInjWL9glJT1lQlVbRgVLbinQW2h6PfrL7GNtMDt+ykKmi4YbQVK78KnGBOgqL1Ay4L017SvUZhWMFhIxLSC9JUC8N74uXO8AtkaZfJq5YHOb5UI/x3T/QAT1RRmfhJTnj5LmyW4T+vr7Am+HPKrYJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8FpwM5tt3a6jyjn0ZEiSB7QiR8labvpC07D/IGvEQss=;
 b=YWRMu0EPybgiQFxXPgOlpxieTeJDeCQX45NbsXfV7JDN59vS+pDW5o3ViD+Sf4otntNK6vDnjaBVUd/Ssy9be1dNi8Ja2GTBp7L/YKI1sasiTG1XyQEebjfr0skakrhtUTJVr9IxVxedu/1xJPi4xl0yPcFFhekrLCM+GsYtu0Y=
Received: from SN7PR12MB7107.namprd12.prod.outlook.com (2603:10b6:806:2a2::16)
 by MW3PR12MB4361.namprd12.prod.outlook.com (2603:10b6:303:5a::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Thu, 29 Jun
 2023 22:03:25 +0000
Received: from SN7PR12MB7107.namprd12.prod.outlook.com
 ([fe80::21f5:1167:3db5:1c88]) by SN7PR12MB7107.namprd12.prod.outlook.com
 ([fe80::21f5:1167:3db5:1c88%5]) with mapi id 15.20.6521.023; Thu, 29 Jun 2023
 22:03:25 +0000
From: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
To: "Joshi, Mukul" <Mukul.Joshi@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCHv2] drm/amdkfd: Use KIQ to unmap HIQ
Thread-Topic: [PATCHv2] drm/amdkfd: Use KIQ to unmap HIQ
Thread-Index: AQHZqqejy0lz9MMQn0y55uGS9S4J8q+iVaDg
Date: Thu, 29 Jun 2023 22:03:25 +0000
Message-ID: <SN7PR12MB7107B22400940E86B437913C8C25A@SN7PR12MB7107.namprd12.prod.outlook.com>
References: <20230629163430.2031529-1-mukul.joshi@amd.com>
In-Reply-To: <20230629163430.2031529-1-mukul.joshi@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=335c284d-c5fd-48bd-b982-9a8a5be305ae;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-06-29T22:03:00Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB7107:EE_|MW3PR12MB4361:EE_
x-ms-office365-filtering-correlation-id: 28579493-8325-4d08-efd7-08db78eca9a4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RJfS6lmSr0mDCtagcBmf7zI+873Y288KT16iw2ybhnSbPZdfIAF/U8O61LngvezPnCOHaAsEizM10/QLe3k2dBMj6+VZUvHG4lKMEMhzNYbRC2fxzQesN5YBglDcBN2bItDi2dg3lng68KArSLCRXyRBev5RkcmOvt5MQ+UJVZYyCyhV2yHG8Ac1oLlwLNKik8HRKaGBf/a0uf+2+2UpYKHuz0drkEG3yxnzwmM5RrpoWpS4eFPbB1Qr+7mAV5CqOCOuNwVYVaVNE30q5YGCL7hOArdWNZY6A6THbrKC7uKZ4dg/jCD9pmcy0lo3VmLHbpKbfI2tUeEdPFXSbcAL2kQNt5Aps1EG7kXdfUjEleOJVIoYIIGmaOxXZP7MF9vNV6RtAZFEK5+iH0+wADxDB6xcv1OqtqBd/IbS6lVw+nj3hbX6eokZOGC8va1StXoHD/2AQxGzPmM9JYz00+/SAiNSX+uGHmBJAkcPmDt30QKp2eiG7Uvsi1pIBVDqkT496sLKtAhhMf4t1gmnmtZBQ4vNXUoGvheb6fEU1Us5axwFQh3ewIOiMxIhH9P+xzoXHI8YRLpZEwTFfIc7uCG8PuZkIrv0CVhwXy4r6IeQxRw6gtFm9pFs4vCrHDfJMZZ2
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR12MB7107.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(346002)(39860400002)(136003)(366004)(396003)(451199021)(76116006)(38070700005)(4326008)(478600001)(110136005)(54906003)(86362001)(41300700001)(55016003)(66446008)(66556008)(66946007)(33656002)(66476007)(64756008)(2906002)(316002)(52536014)(7696005)(5660300002)(53546011)(6506007)(26005)(9686003)(186003)(83380400001)(8676002)(8936002)(71200400001)(38100700002)(122000001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?c/XksfQU4dfh5VeCozyTf3jRTB2M9eMzMUm/ht8JOxi/C18njciTZHlSX758?=
 =?us-ascii?Q?iUA0cTLYYl4EEdHT2e0vT0giFCpMv6Ca31IPZeYd6mjUWh0N1We4RmsHf897?=
 =?us-ascii?Q?oCrqiJrEJfgaQ8E0RRZg6NtR4y7cIlA4kF/1aUaX8uFRsIAVhFYLog5TyWqz?=
 =?us-ascii?Q?Abh3+D4rScCXqU1mGUZV17BSTE1AbFaHqNFN2yavSMlr4quL4iE5JAW3tFkQ?=
 =?us-ascii?Q?yWfuAprXIZRZLJNwrX76rsD/Y9V5azeis2kHn5kjsc6m4QAkCQj0nM1DqEDN?=
 =?us-ascii?Q?1TJ8E2vISgVIt0PNDDyAvAi8EHZxtIRwGFn5YTLPBjwNJI6DVMCuzOkeFh6c?=
 =?us-ascii?Q?iguu4rY/JjHYVTKQNnQprikxHfzj5QcrAfNfz+axoKzhe2uyZ+ewsjSncH+Z?=
 =?us-ascii?Q?EIoCvSw2ub7WF83IOa6tizikruXt+xBuFPtKjceu8ztycVaB+zqZKY8ic7HT?=
 =?us-ascii?Q?HSie/VkE859M0jv76vYswDLcDCgMhSsseVbqw+5IEmJDLlpHc9DLc5EJbRKj?=
 =?us-ascii?Q?gKEQhibwDUu66gZEDuYq2RJFH0urBqouMTC1lI5GJQ/+9jQYZncTHw3Re1lO?=
 =?us-ascii?Q?p9pPZFY0AyM6ZZjbGPPWZS20kaOQeQgM9jkh5x/Z3n60NdBnWCWl2SF5rMdM?=
 =?us-ascii?Q?qTLjB8UG/QZ/nL7nnBxKXNtwgVkUtD7fGvbJnjQrlj34iTY+PNcC4dgU7cqU?=
 =?us-ascii?Q?BPDwZsCdEy6yePSgF4R/87PJ1n019+pEtHqANePqiavkcAGaXRNZgQWg9byZ?=
 =?us-ascii?Q?1v/r9qFifIkA91Q+Gl/wxg93Alya953Gd+JcNN8rffWtNvD4POW0AW8CBlVW?=
 =?us-ascii?Q?u0rNfxtGo1xXrr5kFA6p74WSo3eSv8HDQ9uh4Yrlx0xmM6z+cH5KaM6AbQLg?=
 =?us-ascii?Q?L9dAvy4wJRi51i3K2tmFBmWbrp/w0l14ulDbkNDdjepWtXDY7Me3Y4TZMyj2?=
 =?us-ascii?Q?rrMDm37ZHmOJmW5hk53HybZ9jMzLeN9GF0fnRcw7Ql7HsseczMY152jryeCQ?=
 =?us-ascii?Q?87pvSopPiKKTsl/Lnm8H+KKJtPuY55UIqWXS6NF71ogyCwPa8fJ8Cd2G3e+z?=
 =?us-ascii?Q?TIydyGr58w2g7HgSmQUCsmfx6pfWx5ksqKy1Dmg9G0qqN7Pll12UjES58aLI?=
 =?us-ascii?Q?wuZj9JAtW+U+yV+vH3f5DkTxjdqwEzKVlJhW6Udjdyi9WSDw/MDAZ7iFoVVl?=
 =?us-ascii?Q?r2EBS3luR0+BkJotOcxZpoqR9jx+qKWLPB24xJQDIxkcbGYfTtXD9mlQ/jpQ?=
 =?us-ascii?Q?jQr0R7BoIaswOWZp19c956ag4BIFg5xljb+RnxUd4iPFsIzfkQvel0bRk8TE?=
 =?us-ascii?Q?VxUJ2+Y/qjyjaB2iKV7SCY4OqE4yCwAXMZJtc64x+1M1L80m9mpDgJ79+84/?=
 =?us-ascii?Q?i6Dz6ZXhDOavZnolJKS6wm5xkiNrc6AHT0rUHJGme6YRuKNyaRxhoj9bkmWg?=
 =?us-ascii?Q?kkTQUadMib5nhGYulOLffLn9aeVyAEudDu/R05P/WfnE/+WwX2bW5w6lG5b/?=
 =?us-ascii?Q?MvrC77H2Mb0/Xtfhd0O6aARsiDlr0tsAfnPV8xAbflEZ00bpxuchi9jhBAJt?=
 =?us-ascii?Q?kSY84SJ/QF2amKItzx4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB7107.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28579493-8325-4d08-efd7-08db78eca9a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2023 22:03:25.6312 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5ZAElw2rOwSkIqqrNjyghOs3sT7cpIc1p/PtBJuG/SnKKx3BFruwb6wp7xLeKqgxH4BboAbmJpH6Mhh+6wS2jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4361
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
Cc: "Lin, Amber" <Amber.Lin@amd.com>, "Joshi, Mukul" <Mukul.Joshi@amd.com>,
 "Kuehling, Felix" <Felix.Kuehling@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Mukul Jo=
shi
Sent: Thursday, June 29, 2023 12:35 PM
To: amd-gfx@lists.freedesktop.org
Cc: Lin, Amber <Amber.Lin@amd.com>; Joshi, Mukul <Mukul.Joshi@amd.com>; Kue=
hling, Felix <Felix.Kuehling@amd.com>
Subject: [PATCHv2] drm/amdkfd: Use KIQ to unmap HIQ

Currently, we unmap HIQ by directly writing to HQD
registers. This doesn't work for GFX9.4.3. Instead,
use KIQ to unmap HIQ, similar to how we use KIQ to
map HIQ. Using KIQ to unmap HIQ works for all GFX
series post GFXv9.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
---
v1->v2:
- Use kiq_unmap_queues function instead of duplicating
  code (Felix).

 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c    | 36 +++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |  2 ++
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c  | 22 +++++++++++-
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c  | 22 +++++++++++-
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c   | 36 +++++++++++++++----
 5 files changed, 109 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_amdkfd.c
index b4fcad0e62f7..0040c63e2356 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -830,3 +830,39 @@ u64 amdgpu_amdkfd_xcp_memory_size(struct amdgpu_device=
 *adev, int xcp_id)
                return adev->gmc.real_vram_size;
        }
 }
+
+int amdgpu_amdkfd_unmap_hiq(struct amdgpu_device *adev, u32 doorbell_off,
+                           u32 inst)
+{
+       struct amdgpu_kiq *kiq =3D &adev->gfx.kiq[inst];
+       struct amdgpu_ring *kiq_ring =3D &kiq->ring;
+       struct amdgpu_ring_funcs ring_funcs;
+       struct amdgpu_ring ring;
+       int r =3D 0;
+
+       if (!kiq->pmf || !kiq->pmf->kiq_unmap_queues)
+               return -EINVAL;
+
+       memset(&ring, 0x0, sizeof(struct amdgpu_ring));
+       memset(&ring_funcs, 0x0, sizeof(struct amdgpu_ring_funcs));
+
+       ring_funcs.type =3D AMDGPU_RING_TYPE_COMPUTE;
+       ring.doorbell_index =3D doorbell_off;
+       ring.funcs =3D &ring_funcs;
+
+       spin_lock(&kiq->ring_lock);
+
+       if (amdgpu_ring_alloc(kiq_ring, kiq->pmf->unmap_queues_size)) {
+               spin_unlock(&kiq->ring_lock);
+               return -ENOMEM;
+       }
+
+       kiq->pmf->kiq_unmap_queues(kiq_ring, &ring, RESET_QUEUES, 0, 0);
+
+       if (kiq_ring->sched.ready && !adev->job_hang)
+               r =3D amdgpu_ring_test_helper(kiq_ring);
+
+       spin_unlock(&kiq->ring_lock);
+
+       return r;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_amdkfd.h
index 2d0406bff84e..b34418e3e006 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -252,6 +252,8 @@ int amdgpu_amdkfd_get_xgmi_bandwidth_mbytes(struct amdg=
pu_device *dst,
 int amdgpu_amdkfd_get_pcie_bandwidth_mbytes(struct amdgpu_device *adev, bo=
ol is_min);
 int amdgpu_amdkfd_send_close_event_drain_irq(struct amdgpu_device *adev,
                                        uint32_t *payload);
+int amdgpu_amdkfd_unmap_hiq(struct amdgpu_device *adev, u32 doorbell_off,
+                               u32 inst);

 /* Read user wptr from a specified user address space with page fault
  * disabled. The memory must be pinned and mapped to the hardware when
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c b/drivers/gpu=
/drm/amd/amdkfd/kfd_mqd_manager_v10.c
index 94c0fc2e57b7..83699392c808 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
@@ -318,6 +318,26 @@ static void init_mqd_hiq(struct mqd_manager *mm, void =
**mqd,
                        1 << CP_HQD_PQ_CONTROL__KMD_QUEUE__SHIFT;
 }

+static int destroy_hiq_mqd(struct mqd_manager *mm, void *mqd,
+                       enum kfd_preempt_type type, unsigned int timeout,
+                       uint32_t pipe_id, uint32_t queue_id)
+{
+       int err;
+       struct v10_compute_mqd *m;
+       u32 doorbell_off;
+
+       m =3D get_mqd(mqd);
+
+       doorbell_off =3D m->cp_hqd_pq_doorbell_control >>
+                       CP_HQD_PQ_DOORBELL_CONTROL__DOORBELL_OFFSET__SHIFT;
+
+       err =3D amdgpu_amdkfd_unmap_hiq(mm->dev->adev, doorbell_off, 0);
+       if (err)
+               pr_debug("Destroy HIQ MQD failed: %d\n", err);
+
+       return err;
+}
+
 static void init_mqd_sdma(struct mqd_manager *mm, void **mqd,
                struct kfd_mem_obj *mqd_mem_obj, uint64_t *gart_addr,
                struct queue_properties *q)
@@ -460,7 +480,7 @@ struct mqd_manager *mqd_manager_init_v10(enum KFD_MQD_T=
YPE type,
                mqd->free_mqd =3D free_mqd_hiq_sdma;
                mqd->load_mqd =3D kfd_hiq_load_mqd_kiq;
                mqd->update_mqd =3D update_mqd;
-               mqd->destroy_mqd =3D kfd_destroy_mqd_cp;
+               mqd->destroy_mqd =3D destroy_hiq_mqd;
                mqd->is_occupied =3D kfd_is_occupied_cp;
                mqd->mqd_size =3D sizeof(struct v10_compute_mqd);
                mqd->mqd_stride =3D kfd_mqd_stride;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c b/drivers/gpu=
/drm/amd/amdkfd/kfd_mqd_manager_v11.c
index 31fec5e70d13..2319467d2d95 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
@@ -335,6 +335,26 @@ static void init_mqd_hiq(struct mqd_manager *mm, void =
**mqd,
                        1 << CP_HQD_PQ_CONTROL__KMD_QUEUE__SHIFT;
 }

+static int destroy_hiq_mqd(struct mqd_manager *mm, void *mqd,
+                       enum kfd_preempt_type type, unsigned int timeout,
+                       uint32_t pipe_id, uint32_t queue_id)
+{
+       int err;
+       struct v11_compute_mqd *m;
+       u32 doorbell_off;
+
+       m =3D get_mqd(mqd);
+
+       doorbell_off =3D m->cp_hqd_pq_doorbell_control >>
+                       CP_HQD_PQ_DOORBELL_CONTROL__DOORBELL_OFFSET__SHIFT;
+
+       err =3D amdgpu_amdkfd_unmap_hiq(mm->dev->adev, doorbell_off, 0);
+       if (err)
+               pr_debug("Destroy HIQ MQD failed: %d\n", err);
+
+       return err;
+}
+
 static void init_mqd_sdma(struct mqd_manager *mm, void **mqd,
                struct kfd_mem_obj *mqd_mem_obj, uint64_t *gart_addr,
                struct queue_properties *q)
@@ -449,7 +469,7 @@ struct mqd_manager *mqd_manager_init_v11(enum KFD_MQD_T=
YPE type,
                mqd->free_mqd =3D free_mqd_hiq_sdma;
                mqd->load_mqd =3D kfd_hiq_load_mqd_kiq;
                mqd->update_mqd =3D update_mqd;
-               mqd->destroy_mqd =3D kfd_destroy_mqd_cp;
+               mqd->destroy_mqd =3D destroy_hiq_mqd;
                mqd->is_occupied =3D kfd_is_occupied_cp;
                mqd->mqd_size =3D sizeof(struct v11_compute_mqd);
 #if defined(CONFIG_DEBUG_FS)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c b/drivers/gpu/=
drm/amd/amdkfd/kfd_mqd_manager_v9.c
index 601bb9f68048..e23d32f35607 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
@@ -405,6 +405,25 @@ static void init_mqd_hiq(struct mqd_manager *mm, void =
**mqd,
                        1 << CP_HQD_PQ_CONTROL__KMD_QUEUE__SHIFT;
 }

+static int destroy_hiq_mqd(struct mqd_manager *mm, void *mqd,
+                       enum kfd_preempt_type type, unsigned int timeout,
+                       uint32_t pipe_id, uint32_t queue_id)
+{
+       int err;
+       struct v9_mqd *m;
+       u32 doorbell_off;
+
+       m =3D get_mqd(mqd);
+
+       doorbell_off =3D m->cp_hqd_pq_doorbell_control >>
+                       CP_HQD_PQ_DOORBELL_CONTROL__DOORBELL_OFFSET__SHIFT;
+       err =3D amdgpu_amdkfd_unmap_hiq(mm->dev->adev, doorbell_off, 0);
+       if (err)
+               pr_debug("Destroy HIQ MQD failed: %d\n", err);
+
+       return err;
+}
+
 static void init_mqd_sdma(struct mqd_manager *mm, void **mqd,
                struct kfd_mem_obj *mqd_mem_obj, uint64_t *gart_addr,
                struct queue_properties *q)
@@ -548,16 +567,19 @@ static int destroy_hiq_mqd_v9_4_3(struct mqd_manager =
*mm, void *mqd,
 {
        uint32_t xcc_mask =3D mm->dev->xcc_mask;
        int xcc_id, err, inst =3D 0;
-       void *xcc_mqd;
        uint64_t hiq_mqd_size =3D kfd_hiq_mqd_stride(mm->dev);
+       struct v9_mqd *m;
+       u32 doorbell_off;

        for_each_inst(xcc_id, xcc_mask) {
-               xcc_mqd =3D mqd + hiq_mqd_size * inst;
-               err =3D mm->dev->kfd2kgd->hqd_destroy(mm->dev->adev, xcc_mq=
d,
-                                                   type, timeout, pipe_id,
-                                                   queue_id, xcc_id);
+               m =3D get_mqd(mqd + hiq_mqd_size * inst);
+
+               doorbell_off =3D m->cp_hqd_pq_doorbell_control >>
+                               CP_HQD_PQ_DOORBELL_CONTROL__DOORBELL_OFFSET=
__SHIFT;
+
+               err =3D amdgpu_amdkfd_unmap_hiq(mm->dev->adev, doorbell_off=
, xcc_id);
                if (err) {
-                       pr_debug("Destroy MQD failed for xcc: %d\n", inst);
+                       pr_debug("Destroy HIQ MQD failed for xcc: %d\n", in=
st);
                        break;
                }
                ++inst;
@@ -846,7 +868,7 @@ struct mqd_manager *mqd_manager_init_v9(enum KFD_MQD_TY=
PE type,
                } else {
                        mqd->init_mqd =3D init_mqd_hiq;
                        mqd->load_mqd =3D kfd_hiq_load_mqd_kiq;
-                       mqd->destroy_mqd =3D kfd_destroy_mqd_cp;
+                       mqd->destroy_mqd =3D destroy_hiq_mqd;
                }
                break;
        case KFD_MQD_TYPE_DIQ:
--
2.35.1

