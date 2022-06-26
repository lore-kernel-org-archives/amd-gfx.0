Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0897EC43334
	for <amd-gfx@archiver.kernel.org>; Sun, 26 Jun 2022 13:40:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B34610E269;
	Sun, 26 Jun 2022 13:40:27 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2054.outbound.protection.outlook.com [40.107.243.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF66B10E269
 for <amd-gfx@lists.freedesktop.org>; Sun, 26 Jun 2022 13:40:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TuXqR305jhAG9U6yX3nrz5jIAJgk/po9mA8LEiEzAiBe/6VaLl/5lwvvicz46czL7Iv8r/60jhxueXfJGjPhY4XfY5W+LquLQ8OE3m2rDAfneMswQe1tN7z+QF+msczxvPgWvMLWjfZNvpSdHmPjqVr4p0Ha3eWuBc720T9ZnFwidfxm5ZMGCSxnfE3/XgVk77eMo6TMawxmmIm5o34sqvDdFD9ioCO44cWaY1oJcBTrVVE77WISCPIOjLSfhWQd06rzquwcAnNT9UbTi7ev8NfhPRqePn5irGLrsgONWS0gSBqRf+qmyZyYn88LWRvVrmRJluO8B0NKU5aPOKsEIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AXit8BJ0wpZODz9XUY1sERSnDC4DUarTXe8Bby6wMG4=;
 b=m2tDD737E/dZBBU+D4I075lRsYeyBZ/JNNebMtgbrDySo1nNGNEUG96G44nuYALH9rB943wSSOOBCHiKdLurkJ9uR8vbrPWyoNRPFL0j271v3YtbHks0oFLDmf1EaM6lNuSnZiqeOBJrzgsyfvIRghFmSuBCbLBymlgM+8MJ90AxBilfWNVktAvgfpVt0DrgGgewmsgWmUq5LG8TbHW1PVMMVsvETWjd/AAye+id8s7S2vEEJOq8bjL19ZquwJbu/S5BTo/BXi2XqeA+EEU3Qacr1QfZ+5NQQMY0Qc6H5BeDzPyWKgdpil3qe0Pe2OMr3OvTQ4GXDbhWE2NSBewJ4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AXit8BJ0wpZODz9XUY1sERSnDC4DUarTXe8Bby6wMG4=;
 b=LzMtlF9xeFqet2Mr8B3kf1gkd3wWiMabmncM2nMcQFv68NMwn9TL+bLqdEb73NoCzd3fOqzP1KwKIe5aIOlxgb6wD6aLgRiG3Jnpe1iMYQgb6n9InEC0FKeN54LJSC6JYn7/u4CItt3B6SIue67C33Jx/e6uYPKBcG8BlTq34qM=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by MWHPR12MB1437.namprd12.prod.outlook.com (2603:10b6:300:7::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.18; Sun, 26 Jun
 2022 13:40:16 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c822:1616:3d10:71fe]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c822:1616:3d10:71fe%7]) with mapi id 15.20.5373.018; Sun, 26 Jun 2022
 13:40:15 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Xiao, Jack" <Jack.Xiao@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Sider, Graham" <Graham.Sider@amd.com>
Subject: RE: [PATCH] drm/amdgpu: add mc wptr addr support for mes
Thread-Topic: [PATCH] drm/amdgpu: add mc wptr addr support for mes
Thread-Index: AQHYh8GVO7cHnDVI+UyLPHwE0so2Ha1htOMg
Date: Sun, 26 Jun 2022 13:40:15 +0000
Message-ID: <BN9PR12MB52578630ACCBC15DEEBEC44BFCB69@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20220624115712.2757646-1-Jack.Xiao@amd.com>
In-Reply-To: <20220624115712.2757646-1-Jack.Xiao@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=96f87fed-e741-4d8b-a780-e07bcee3f96d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-06-26T13:39:46Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f0a044cd-0843-4ad7-6cee-08da577966e1
x-ms-traffictypediagnostic: MWHPR12MB1437:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zGVgjkxdaoPsJvjN98pggTR58H7Q68nQaAIjNsN+YsT+8Mr7MOGLmun/uYY8iRCpo+Bu+ppp0vNcXaSrwtzUGMKvf25Pxrt1xi6Xi2XlK1d8NTx1hMyqt1mQxcwy9500MHCDcWf1jBQ4h9AKCaTU+QmJDbrcTaZA810DjQhp6Y5ZPo3g91SrQHpuwQqbzIR4ZHS/53VSc7YfrheKvO4Cq7ONDbxitAqv/mk5bLN16wGrcmZsJFeqrZiLIxN6yigzXioBZzV0cA7T2kxt4BQEzb7+5cKKmrCkNTxCY+pDxrl00t1O0xHwdhfwDzQ6vPeMCS1RbsBHetS7vYPlROvDWmRoRRtwq5Uka2FD3PGJhKxrokI9Ors6T7NMcxvMs7pVn5mS6VCy6Xwu4Mj0zOtt+8gNxt/3rmIZrtdyZBscwkcpceoTXF8UXuSrZnlzDkYg3ustfVYvuGdKMvQQmUoCgagWnF9OyYa1L4/LFlnz7V65CeNB6NtMnvKoNUZB2TA+R65oMHYT7CYhGUbLQXAec+nchnMk8ZgkP7IImMifJzQK6XoqiMoaHUVemxp/Wq9AevvSPyv1KSBAw5SxKaeKIZlRHSDsID3Ct0xxPb8I31kN2/V8RLFtvw/vc8IZn88tV1s1mDfnkHfDZ84QPAhGXSdo8mz/gn+tacfeBp6+Y7wAEeQnia1BVLkqGtQjc9XxmFf8C8ll2pHrTyxSkgev0OZN67Uj8Y9Yu0I4l8lAGU9jMDMFADGDj3JbikDsPEQ1FkolAnBDys/8chtTRFMz7cJvleWmqde5w+1ItJP5McA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(396003)(366004)(376002)(346002)(136003)(66446008)(66476007)(110136005)(478600001)(316002)(76116006)(66556008)(52536014)(8936002)(64756008)(66946007)(2906002)(55016003)(6636002)(5660300002)(26005)(122000001)(186003)(38070700005)(9686003)(53546011)(6506007)(71200400001)(41300700001)(38100700002)(7696005)(83380400001)(33656002)(8676002)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pnZe9NYyRZX0rxP3DU9tSM5luXyUTtCoCWLOsAP29VRRBrr3KckudxNhMM/H?=
 =?us-ascii?Q?H1Z60jlEtiwGpfLVG+qESQSBb0jH744/bfb4H6EIc3QgaMfjCq9LP7biM4IN?=
 =?us-ascii?Q?P8NnRXu34LRgiHymDGw/3eup2T/3o1EZnZMG3oSl3dqwlinYijkYXLzS5LiL?=
 =?us-ascii?Q?YTHXxmyqLgRejOlSxGL8yla/ftyJcdVEEVJ7zmF6xCGhbtKlWR9qh2X137p2?=
 =?us-ascii?Q?GqLC3F/nYxPk+j0sQRkrZ83NIsZH0/Cwzk7HRPFIovk2tLKlZmuN+6jVvRxx?=
 =?us-ascii?Q?gMQNmwYyVDe8KPLN187aW3XIJe2Mi+lfg8wW9Z1PxyJObscCIvWpGrYJ94dy?=
 =?us-ascii?Q?R8Up71ZPaVDA5kg7BmY5QNqFiDzg1jnff3j8gXuuOgf3C1ARPLEiXqJJ/njq?=
 =?us-ascii?Q?VEDVLRam7OIQfwtk9cKiOdxieWDOi6IVSmSFvxdpObU3xiwAxmeKUmLO3OXB?=
 =?us-ascii?Q?sK3k5+FEH+KOyHO8YY9vvbbeuutbRsuww7f406FWMBjXagkG3DQPHzplVyfm?=
 =?us-ascii?Q?vs9/QDVk2Cl0wrzJb8Ho5ElF4yDFHdV23mhOckkB7HLURMIDDPUYY2Q5nHFr?=
 =?us-ascii?Q?XBWZ4Cm5DPQ4vk4HbFKSik9RDExwAYP/AyEpQQtRDIFsbIbeG8BHc9KyFKQj?=
 =?us-ascii?Q?x+60S6aF5iySWZy/Q6GF5HRH5nxctMUKKbRQzxyJv/A5NGHkyZPTE56o3Nho?=
 =?us-ascii?Q?5Re4W6AfEHO7K/2FesVCbGv6d4sjSgnKvqOEs+4QelU2oict2bTp3egir+ts?=
 =?us-ascii?Q?Sm4LNbkN+Fg7n+h7ah4cnR2bO0mNjotvAfEjrlyhZkAnT9kxBiAplmpB+5Ld?=
 =?us-ascii?Q?UqTIqA11+8nepKdyedRmI66wbqrOvYn4tKcLWi+B2nmauTTd90b7agFJ4X+a?=
 =?us-ascii?Q?HGBYR0KX3+tLKj08vCg6aHLQJUzlGK3SIDZ6ZiyV1Imj4Sw+jUeohYWzoPsF?=
 =?us-ascii?Q?sKtzicftAUagzJMPkvzEZeH0Qwrag1KINJv9jeQeOyjkjKlta6pl8iUwiTRc?=
 =?us-ascii?Q?r3HjZqzVdQT/DPDUywwewYcwxNE3me1iiabHA+R9VvRINNP5uYZVHNNDKQy8?=
 =?us-ascii?Q?5Zs8aks2AOcE1rvuGlO5hFLm+lpHOBuSncOcg/U87F6TZ3tt9KnB8glF9ZXg?=
 =?us-ascii?Q?7wmLhxqphU0rL1VhVl8U2x6VBG4aExdLthsEUnmAKxYFmkA1+pokhG7DpQG/?=
 =?us-ascii?Q?UkrMTpbtvN53E0eYSNeYLKlXCRGUqwp1qgDmSjHkFl8wG7UYhpLq4jbrqbNC?=
 =?us-ascii?Q?u/fA9MBkP5TCnbOwTVWsFCegfvQ6J84RIcEIXXNK2m1YFYsR+Kb9h0RiGzq3?=
 =?us-ascii?Q?j/c0rTMu0851/nU4zAm23DpGcaqcdkzuJkA9/dEYgxYpy8OOsOVnNGyBDVRk?=
 =?us-ascii?Q?wA+zEQWX9Oy74vBAzUwrrFmHZ8c54tTicOK2tpqldOj2OBgGUwvnrVX1QJDA?=
 =?us-ascii?Q?PO5V4zIC3X7WzGP/IKSIY8LkNT79i7Ei04vPyh4fXD6dWadW+klLvTIoHvRy?=
 =?us-ascii?Q?G17nqewvmyVCTbSK+EjULloYC9QnOjkwowpFjuv0K1hlzHkmSiWWzRMM4rOL?=
 =?us-ascii?Q?8L6quDf6A+RGjKOwFaPBEnJKq7UPBnh1zkPCtUU3?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0a044cd-0843-4ad7-6cee-08da577966e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2022 13:40:15.4742 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MwqaepFeDqVbFt/4er/LdqmkF/BwPXEmT/NP34aDPcaJ8unhmDCVCXPv/D/Qbs5g5p0W8MVVv9XbdOvkp6BlYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1437
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

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Xiao, Jack <Jack.Xiao@amd.com>
Sent: Friday, June 24, 2022 19:57
To: amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@am=
d.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Sider, Graham <Graham.Sider=
@amd.com>
Cc: Xiao, Jack <Jack.Xiao@amd.com>
Subject: [PATCH] drm/amdgpu: add mc wptr addr support for mes

MES requires mc wptr address for usermode queues.
Export bo gart address for mc wptr address.

Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c               | 10 ++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h               |  2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes_ctx.h           |  1 +
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c                |  8 +++++++-
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c |  6 +++---
 5 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_mes.c
index 521e35d93d67..0c9cb493a85c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -675,6 +675,7 @@ int amdgpu_mes_add_hw_queue(struct amdgpu_device *adev,=
 int gang_id,
        queue_input.doorbell_offset =3D qprops->doorbell_off;
        queue_input.mqd_addr =3D queue->mqd_gpu_addr;
        queue_input.wptr_addr =3D qprops->wptr_gpu_addr;
+       queue_input.wptr_mc_addr =3D qprops->wptr_mc_addr;
        queue_input.queue_type =3D qprops->queue_type;
        queue_input.paging =3D qprops->paging;
        queue_input.is_kfd_process =3D 0;
@@ -802,6 +803,8 @@ amdgpu_mes_ring_to_queue_props(struct amdgpu_device *ad=
ev,
        props->hqd_base_gpu_addr =3D ring->gpu_addr;
        props->rptr_gpu_addr =3D ring->rptr_gpu_addr;
        props->wptr_gpu_addr =3D ring->wptr_gpu_addr;
+       props->wptr_mc_addr =3D
+               ring->mes_ctx->meta_data_mc_addr + ring->wptr_offs;
        props->queue_size =3D ring->ring_size;
        props->eop_gpu_addr =3D ring->eop_gpu_addr;
        props->hqd_pipe_priority =3D AMDGPU_GFX_PIPE_PRIO_NORMAL; @@ -962,7=
 +965,8 @@ int amdgpu_mes_ctx_alloc_meta_data(struct amdgpu_device *adev,
        r =3D amdgpu_bo_create_kernel(adev,
                            sizeof(struct amdgpu_mes_ctx_meta_data),
                            PAGE_SIZE, AMDGPU_GEM_DOMAIN_GTT,
-                           &ctx_data->meta_data_obj, NULL,
+                           &ctx_data->meta_data_obj,
+                           &ctx_data->meta_data_mc_addr,
                            &ctx_data->meta_data_ptr);
        if (!ctx_data->meta_data_obj)
                return -ENOMEM;
@@ -976,7 +980,9 @@ int amdgpu_mes_ctx_alloc_meta_data(struct amdgpu_device=
 *adev,  void amdgpu_mes_ctx_free_meta_data(struct amdgpu_mes_ctx_data *ctx=
_data)  {
        if (ctx_data->meta_data_obj)
-               amdgpu_bo_free_kernel(&ctx_data->meta_data_obj, NULL, NULL)=
;
+               amdgpu_bo_free_kernel(&ctx_data->meta_data_obj,
+                                     &ctx_data->meta_data_mc_addr,
+                                     &ctx_data->meta_data_ptr);
 }

 int amdgpu_mes_ctx_map_meta_data(struct amdgpu_device *adev, diff --git a/=
drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu=
_mes.h
index 5fdc4fbde3bc..3334316c2995 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -175,6 +175,7 @@ struct amdgpu_mes_queue_properties {
        uint64_t                hqd_base_gpu_addr;
        uint64_t                rptr_gpu_addr;
        uint64_t                wptr_gpu_addr;
+       uint64_t                wptr_mc_addr;
        uint32_t                queue_size;
        uint64_t                eop_gpu_addr;
        uint32_t                hqd_pipe_priority;
@@ -207,6 +208,7 @@ struct mes_add_queue_input {
        uint32_t        doorbell_offset;
        uint64_t        mqd_addr;
        uint64_t        wptr_addr;
+       uint64_t        wptr_mc_addr;
        uint32_t        queue_type;
        uint32_t        paging;
        uint32_t        gws_base;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes_ctx.h b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_mes_ctx.h
index c000f656aae5..912a5be2ece6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes_ctx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes_ctx.h
@@ -107,6 +107,7 @@ struct amdgpu_mes_ctx_meta_data {  struct amdgpu_mes_ct=
x_data {
        struct amdgpu_bo        *meta_data_obj;
        uint64_t                meta_data_gpu_addr;
+       uint64_t                meta_data_mc_addr;
        struct amdgpu_bo_va     *meta_data_va;
        void                    *meta_data_ptr;
        uint32_t                gang_ids[AMDGPU_HW_IP_DMA+1];
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/mes_v11_0.c
index 7dfc6ea21397..89b99dc827a6 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -156,7 +156,13 @@ static int mes_v11_0_add_hw_queue(struct amdgpu_mes *m=
es,
                input->gang_global_priority_level;
        mes_add_queue_pkt.doorbell_offset =3D input->doorbell_offset;
        mes_add_queue_pkt.mqd_addr =3D input->mqd_addr;
-       mes_add_queue_pkt.wptr_addr =3D input->wptr_addr;
+
+       if (((adev->mes.sched_version & AMDGPU_MES_API_VERSION_MASK) >>
+                       AMDGPU_MES_API_VERSION_SHIFT) >=3D 2)
+               mes_add_queue_pkt.wptr_addr =3D input->wptr_mc_addr;
+       else
+               mes_add_queue_pkt.wptr_addr =3D input->wptr_addr;
+
        mes_add_queue_pkt.queue_type =3D
                convert_to_mes_queue_type(input->queue_type);
        mes_add_queue_pkt.paging =3D input->paging; diff --git a/drivers/gp=
u/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kf=
d_device_queue_manager.c
index 74a1f8a6f53f..21e451acfa59 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -197,12 +197,12 @@ static int add_queue_mes(struct device_queue_manager =
*dqm, struct queue *q,
                                        AMDGPU_MES_PRIORITY_LEVEL_NORMAL;
        queue_input.doorbell_offset =3D q->properties.doorbell_off;
        queue_input.mqd_addr =3D q->gart_mqd_addr;
+       queue_input.wptr_addr =3D (uint64_t)q->properties.write_ptr;

        if (q->wptr_bo) {
                wptr_addr_off =3D (uint64_t)q->properties.write_ptr - (uint=
64_t)q->wptr_bo->kfd_bo->va;
-               queue_input.wptr_addr =3D ((uint64_t)q->wptr_bo->tbo.resour=
ce->start << PAGE_SHIFT) + wptr_addr_off;
-       } else
-               queue_input.wptr_addr =3D (uint64_t)q->properties.write_ptr=
;
+               queue_input.wptr_mc_addr =3D ((uint64_t)q->wptr_bo->tbo.res=
ource->start << PAGE_SHIFT) + wptr_addr_off;
+       }

        queue_input.is_kfd_process =3D 1;

--
2.35.1

