Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E475C83F12
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Aug 2023 14:55:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0444C10E2F4;
	Mon, 28 Aug 2023 14:55:17 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2089.outbound.protection.outlook.com [40.107.223.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 653D810E2F4
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Aug 2023 14:55:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FeT3J71pUbttROj3YWsG+A8sazhVQUqODtQnQtDfQTqGVuGIKGhydni7rxUzNuPPf7pQtQWBlJNP4f9RFA6MY1QIOuLTPKa8ooy+l0ywJy2nhANB4Lke5qlDiWqxNHRNS5f0/4VBEozWzXDKmw3pXSFfWemqO5LDHg/nbZpnPAFPQZcnv33mtICMbmqOLSpRVVbqZti5F5vX/nG3VAc3K2EgFo9d7qR68IVDeRikR6z5A0z34DMxSmjVL+vABfJXmEciMkTPWrawKOz0Qt5JPH3M00XpPlJh4FV32Dzwic+clJZTTm9zIS4iMF39ghvgMI9o2GxBp/i9Y19MGKi5NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pAb5uB6xf+mb68cwP+6xC7mXpwL68JWvXPosjXyG3lY=;
 b=aNDxXwld6tWWNftJB2W1WVldAfTa4Y7wo89S/hYteeighdhMdOlyoc4cp7viu92/3KFfE3AyVP1fgKeqnF+npc0FWLYSwBus15sd1hMIIFfMm2LHTiRdtZV5hjcN7x16nPrgA6CJ4Fy4UVnmwjMSKl/mUf/AO8KYj7ETyQlGouHJt3i0PIUMEE0XAGtX4sHT4WWb7v36yIQuirWi/qZhj7tTJhS9LS5Nq6eQhlu7Aunq/K6TcOX3MfFUEb54y7+/Szl4nBUEgyQFSW9VDf5uRWDQNWLbqAwAL7afdH1UFBMRiJR62wkR+julPb46yhc1ejaw9Elm13YS+/meNoolQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pAb5uB6xf+mb68cwP+6xC7mXpwL68JWvXPosjXyG3lY=;
 b=Xp1dNdUqAZrQ8wHuFaFXuke1zSppbFNqwlPLhlmPZ8XDI2jMZ5WFzqZ0/oSyT+Z5DLKJzRvhaOUXODjF3/xyunZM8ZHnawV9Y9904a0TWEi/JC1NKh8ezNpHZ/ziMmRxQVu50Xtk1zhuLWy0yzLeSBH+Zy4QtVSgwZ3FA0oerro=
Received: from CY8PR12MB7099.namprd12.prod.outlook.com (2603:10b6:930:61::17)
 by MW4PR12MB7288.namprd12.prod.outlook.com (2603:10b6:303:223::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Mon, 28 Aug
 2023 14:55:13 +0000
Received: from CY8PR12MB7099.namprd12.prod.outlook.com
 ([fe80::a5f3:e7b0:83dd:c832]) by CY8PR12MB7099.namprd12.prod.outlook.com
 ([fe80::a5f3:e7b0:83dd:c832%6]) with mapi id 15.20.6699.028; Mon, 28 Aug 2023
 14:55:12 +0000
From: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
To: "Francis, David" <David.Francis@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdkfd: Checkpoint and restore queues on GFX11
Thread-Topic: [PATCH] drm/amdkfd: Checkpoint and restore queues on GFX11
Thread-Index: AQHZ14hoCDMjaG8gokefN/hHmAbUJq//0Bgw
Date: Mon, 28 Aug 2023 14:55:12 +0000
Message-ID: <CY8PR12MB7099D45BC02B813A7FD09F0B8CE0A@CY8PR12MB7099.namprd12.prod.outlook.com>
References: <20230825191411.3276216-1-David.Francis@amd.com>
In-Reply-To: <20230825191411.3276216-1-David.Francis@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=7d1091fb-8b9f-4479-8bc1-2042b82c1dff;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-08-28T14:54:44Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7099:EE_|MW4PR12MB7288:EE_
x-ms-office365-filtering-correlation-id: 54f2c33f-711c-462d-72dd-08dba7d6c82b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mRishTvdjayru2GZpftmAI4RM7zhR0s9ZHbeYPNRfDoTnjypIVXr8CL64T942k3XIFCBuVdmXqZ4/DWcnJgHTvDAng1L1LmQvGq8vicxPoFtCHHlFz90RnWTt8FVREnirzBrlZtIWu5PNakNe04g2O7/9YhCW8ejHn441kDflp/TaQcA8TjTQJX3yyKmLqoSclefbQ6fGC8yVMlH9MoQmqlUtewcdqC0GJpm9HIEShRLQRkUu8FILlSov4fwMwZNKZbYIxEcJ7YT9EyfPsrCSrW+DDfvpmcqRAFvPczzIduwsxq6guP1YXD0YfgzfwBtsev5sRTMXLeyqCc4GX4hV0FG2cEjjIUmVnPVIlahI9s+DE9CIYesi5m9iuUTwbtolC+6xUxLTofIqBcmQhrdS5NYQk+b44WLoQreyE4xZAyxPv5IdP2UbueE7QVLpCUh07pCtvE+wRnu3UkD4wL21k4huGM3yeZHjbVA1SGq8Whgr0dMYlvkU8r97pIGB7kHh+Ar1Bi91p1B+McwjfUrwonWvV0rT+vhFJQXALn9RlwKokiSGFK2CB6zD+ZqtQwL3FI+o+OrqSHJaRqv/SYDq18PZfTO7/By4Us7p2TdA66/YkG995mr7ghF10w+ecuN
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7099.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(396003)(136003)(39860400002)(376002)(346002)(451199024)(1800799009)(186009)(6506007)(7696005)(71200400001)(9686003)(33656002)(86362001)(38100700002)(38070700005)(122000001)(55016003)(2906002)(26005)(83380400001)(53546011)(478600001)(76116006)(110136005)(52536014)(66946007)(66556008)(66476007)(4326008)(8676002)(8936002)(5660300002)(41300700001)(66446008)(54906003)(316002)(64756008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BA46poZlqEvL2H3J6A57Lm+p+n3Av290Z+gswH9+P+WqDySty2ePBnX5HmSh?=
 =?us-ascii?Q?WC0ptQIAp9STHDtGCEsVWna1y5qpKwApgXwTlN8GW09IvjlfBAyUDhJJXqfj?=
 =?us-ascii?Q?ZRZIS/orSyQnH+QkGScRQ+Lqc+qlfmnpvQMPAV6jVEuqfXEzJ/od2P1kejUf?=
 =?us-ascii?Q?4euB8k9QyX492pY9MMna7+neGI8uev0YvNE2uv/V1dOUH0JOdg/3iXvpWFuo?=
 =?us-ascii?Q?AzcU8XPmExiOlEQWjsiBtgX/BSpFXCQGLduyvK0arscclN9ke7FqKYUaxtSY?=
 =?us-ascii?Q?h4AmD77UfPQ+AgJuEN8Cg4e4dvnuEt1lys695/rKrjIREvkRMWwVIY5+TY3Z?=
 =?us-ascii?Q?oVeecFu14Q2E+v//zNKiIZBgZilmLEPFxd+g4VKdfa3/dygm3cJp6lpRX8hz?=
 =?us-ascii?Q?z7dnihud0Tyt8QeJ4L6BII7cV+nyaajj6Nq8xzOQCliEFGNvZqhnttB8mkRc?=
 =?us-ascii?Q?aCBp2u36W36ficDKKiBqf4xJnbo2yBr5NT29DAhkPifATxZtQDr/dH4WnNqr?=
 =?us-ascii?Q?JtUcF9b7jcSPqFdHo/lMA1x9wrjARBZphkReRHn8xMb1v7TKS7gI60YYpA3j?=
 =?us-ascii?Q?cepwnDFin0UK6DAe4Saocg+dRZL5+cyDp+Iz9/Y8y1CN4U4xwIoGtoROUqK4?=
 =?us-ascii?Q?uBSCBw/Hi98Ww/CiA+S6VbECqD9lbaptto7CFYCztq+jLRak1dAJcLd0tPk9?=
 =?us-ascii?Q?traq7Bfz5moYgR8dpi6Vk2tRxTOOk3KF2MACyu7Q7QRXQCtgtQw5sUwQm0eb?=
 =?us-ascii?Q?mk+SO22sBjq3zTQ6aERQ2QkXr7K3DtjbJOE8dswNQPoCrADWUZfiBeXveBdk?=
 =?us-ascii?Q?fnQ8BwvgYc1hET1qlH8wm0hkDAsCqm56MfOHiRvxlECSIvpA/E7XZMCOlOuU?=
 =?us-ascii?Q?cS347yvui78lEmpAIiEXaAjy7zv+orG7TAKC9gRd8e82AYZz4c7ds5yfpMiK?=
 =?us-ascii?Q?l1yARAHWzlJQkVdFDAJIrdTHYlxtnr+AYO0E+AK8yxAnZywCdXLjzv6fDo+4?=
 =?us-ascii?Q?N5fH1Hnu90iITr179gAynioqLUTtaIxQ6by2WVXeat9oOUo9HtRBMWJeyvTu?=
 =?us-ascii?Q?W0tjVV0l3BCWGOPT8xDnYEMkKtuRp1PcR3HSZcXK8Uz5hbRBM+Enf8lKqWt+?=
 =?us-ascii?Q?rIio0ZsKAKS3A/W4nMMHtqiPrmEqiwIKU6+DYLRAQ307YLjHzHMZ6GkXa3FE?=
 =?us-ascii?Q?FMjSfG19sqYXU71q2pXFqHmXXxe3a6EbCrnyWoiDHBWBJOlkPbyY7+atOGZf?=
 =?us-ascii?Q?pstDEeb6J3I18GL1Xn8Vw2o7wOMlFPUjkfRr5Pb6Qk5U9IAiuQK0ZFx6GsCZ?=
 =?us-ascii?Q?EGyRabiADJtIzmAprPhT61glJ6r7GujkdkwKZoIHw346MNpMfIhlL/GfJgGJ?=
 =?us-ascii?Q?OVEP2yvQOMnwui/C9dbMRYYrsRKYZ+2tYuAHih4plq0T4hcpQkSrytMrf7L8?=
 =?us-ascii?Q?Ca6HbxOAcwGcNYvaZKkRgqUnsHVWMRfGbuuyl460mHIYyHth1B+t2ow9bE0q?=
 =?us-ascii?Q?tOQSKZOi3HnrMOjnsG7/CxOl0IWUdQclQq41wc+21d3juMExipbWfYIeAjgY?=
 =?us-ascii?Q?g+tQuSKLbs/2uViw9VI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7099.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54f2c33f-711c-462d-72dd-08dba7d6c82b
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2023 14:55:12.6086 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0V0UWB4mKKyTuUkYgrSCYoA97DoVcJd98+HZ/0I9wkcgnXkRdE+KMWgtn9ywJO3dkkM/C/okcMWy53aWnHPEOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7288
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
Cc: "Francis, David" <David.Francis@amd.com>, "Kuehling,
 Felix" <Felix.Kuehling@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of David Fr=
ancis
Sent: Friday, August 25, 2023 3:14 PM
To: amd-gfx@lists.freedesktop.org
Cc: Francis, David <David.Francis@amd.com>; Kuehling, Felix <Felix.Kuehling=
@amd.com>
Subject: [PATCH] drm/amdkfd: Checkpoint and restore queues on GFX11

The code in kfd_mqd_manager_v11.c to support criu dump and
restore of queue state was missing.

Added it; should be equivalent to kfd_mqd_manager_v10.c.

CC: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: David Francis <David.Francis@amd.com>
---
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c  | 41 +++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c b/drivers/gpu=
/drm/amd/amdkfd/kfd_mqd_manager_v11.c
index 2319467d2d95..2a79d37da95d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
@@ -321,6 +321,43 @@ static int get_wave_state(struct mqd_manager *mm, void=
 *mqd,
        return 0;
 }

+static void checkpoint_mqd(struct mqd_manager *mm, void *mqd, void *mqd_ds=
t, void *ctl_stack_dst)
+{
+       struct v11_compute_mqd *m;
+
+       m =3D get_mqd(mqd);
+
+       memcpy(mqd_dst, m, sizeof(struct v11_compute_mqd));
+}
+
+static void restore_mqd(struct mqd_manager *mm, void **mqd,
+                       struct kfd_mem_obj *mqd_mem_obj, uint64_t *gart_add=
r,
+                       struct queue_properties *qp,
+                       const void *mqd_src,
+                       const void *ctl_stack_src, const u32 ctl_stack_size=
)
+{
+       uint64_t addr;
+       struct v11_compute_mqd *m;
+
+       m =3D (struct v11_compute_mqd *) mqd_mem_obj->cpu_ptr;
+       addr =3D mqd_mem_obj->gpu_addr;
+
+       memcpy(m, mqd_src, sizeof(*m));
+
+       *mqd =3D m;
+       if (gart_addr)
+               *gart_addr =3D addr;
+
+       m->cp_hqd_pq_doorbell_control =3D
+               qp->doorbell_off <<
+                       CP_HQD_PQ_DOORBELL_CONTROL__DOORBELL_OFFSET__SHIFT;
+       pr_debug("cp_hqd_pq_doorbell_control 0x%x\n",
+                       m->cp_hqd_pq_doorbell_control);
+
+       qp->is_active =3D 0;
+}
+
+
 static void init_mqd_hiq(struct mqd_manager *mm, void **mqd,
                        struct kfd_mem_obj *mqd_mem_obj, uint64_t *gart_add=
r,
                        struct queue_properties *q)
@@ -457,6 +494,8 @@ struct mqd_manager *mqd_manager_init_v11(enum KFD_MQD_T=
YPE type,
                mqd->is_occupied =3D kfd_is_occupied_cp;
                mqd->mqd_size =3D sizeof(struct v11_compute_mqd);
                mqd->get_wave_state =3D get_wave_state;
+               mqd->checkpoint_mqd =3D checkpoint_mqd;
+               mqd->restore_mqd =3D restore_mqd;
 #if defined(CONFIG_DEBUG_FS)
                mqd->debugfs_show_mqd =3D debugfs_show_mqd;
 #endif
@@ -500,6 +539,8 @@ struct mqd_manager *mqd_manager_init_v11(enum KFD_MQD_T=
YPE type,
                mqd->update_mqd =3D update_mqd_sdma;
                mqd->destroy_mqd =3D kfd_destroy_mqd_sdma;
                mqd->is_occupied =3D kfd_is_occupied_sdma;
+               mqd->checkpoint_mqd =3D checkpoint_mqd;
+               mqd->restore_mqd =3D restore_mqd;
                mqd->mqd_size =3D sizeof(struct v11_sdma_mqd);
 #if defined(CONFIG_DEBUG_FS)
                mqd->debugfs_show_mqd =3D debugfs_show_mqd_sdma;
--
2.34.1

