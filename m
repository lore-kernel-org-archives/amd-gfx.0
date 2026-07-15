Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC295C44501
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jul 2026 10:52:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2972A10E1BB;
	Wed, 15 Jul 2026 10:52:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zkhrzqnd";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011019.outbound.protection.outlook.com [52.101.62.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8AC8610E1BB
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2026 10:52:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zGW+y/mfzdNWTQEtPX1Uo87/0/TkuXShAd57pihFp/HQSlRY9VbE38qjvbpHEEa5B6wladh5zJIXiBENaA/C+BnNU4ew34ouW4tD2vcfDABkg0IX/4gh3C9MqKnE7rWgN0gWgNsMADLtRIPYcXqqL7o2Y0LiD4SOywW83aadZKptxEyciZoh8kYGRcR5gk/MkYWekmC/4P0Q9emIyvjtOLlYrmMa51op+4T1dkUtac9t+T9mfNeeFmVsFgXAHqVvRxtEJ1RfcfKv/cUTkFDGoM+qAAecpkFcCko1BuLMv5+94R2KGowuJX9S20FSIXHfxJMYq5B6jr47FK3kAiNeNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JMDWG93z+P8k8lR+DO8jbSHWLvjWmu8qNtf5q8Dbs/k=;
 b=dHBmD+uyJg907Pz1SQPHR3OvD487ZKe3yMPkx3pMLnSppnUsvcZllRXEaFuPxTM6UuFJz/FLenpxn8Bh2ekD4KnLN0kpqIACDl1q7da+7EvSXzkUCikjiuL6y/ahsIcRaqLiSmBiE1lEjWyI3h94ayYdXAAyUQl+sTxumTJJB2aIfngi/9OExJ7ZNdTRc9CUMyC5wRc6jHgYck5OmXVkZl0e18y2KZ0ms9+bkoM9eueiTDeIuJmMbj/MWr9C4brPPN/M+uIwEqwdR/0cjK2q8iyTuPvARtxqkOV+M6ixW4Ho78pX8/oEHuh7NQ+Ju+jAfMcYOYNwmtx94Wd+L1QtSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JMDWG93z+P8k8lR+DO8jbSHWLvjWmu8qNtf5q8Dbs/k=;
 b=zkhrzqnd3YeB/sZuYsbzwHf7Rki9SvMx6W0t2axyF8OttWVYTF/8rd3pGOPTvUaqNlycCnyrCik4JG454pXj/Yl9m53o4HJ6RxpvMacv1g0Y9MO2x+NycmuhQwenBoVOB2AMvPlcCcgpRU1hYbpWtDeMeAr+n9BgwOCTnJlDAY8=
Received: from SA1PR12MB7343.namprd12.prod.outlook.com (2603:10b6:806:2b5::22)
 by SN7PR12MB6912.namprd12.prod.outlook.com (2603:10b6:806:26d::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Wed, 15 Jul
 2026 10:52:45 +0000
Received: from SA1PR12MB7343.namprd12.prod.outlook.com
 ([fe80::f66a:f590:f149:2fee]) by SA1PR12MB7343.namprd12.prod.outlook.com
 ([fe80::f66a:f590:f149:2fee%6]) with mapi id 15.21.0223.008; Wed, 15 Jul 2026
 10:52:44 +0000
From: "Fan, Shikang" <Shikang.Fan@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: Re: [PATCH] drm/amdkfd: save/restore MQD across hibernation when MQD
 is in VRAM
Thread-Topic: [PATCH] drm/amdkfd: save/restore MQD across hibernation when MQD
 is in VRAM
Thread-Index: AQHdFEUdx76L6j2Dt0e91CKOFTnlqLZuZzTn
Date: Wed, 15 Jul 2026 10:52:44 +0000
Message-ID: <SA1PR12MB7343131FD27AC222B0545912EBF82@SA1PR12MB7343.namprd12.prod.outlook.com>
References: <20260715103056.3529178-1-shikang.fan@amd.com>
In-Reply-To: <20260715103056.3529178-1-shikang.fan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-07-15T10:52:44.400Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD
 General; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=1;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB7343:EE_|SN7PR12MB6912:EE_
x-ms-office365-filtering-correlation-id: 451cea2d-8c59-4431-f37c-08dee25f339f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|18002099003|22082099003|8096899003|38070700021|10067099003|56012099006|11063799006;
x-microsoft-antispam-message-info: kc2QRiaWG0sKjnuYiyQTsx+Z7Lh4WKiYiMVTI+P7HL2iSSLjGRwCk5li6+YyZ2gFgpr1rZkcjF2GYp9VvDWuZ3L3N44THt7oC3ukpe1tzbdrNgP5yQdHEMA3KAq5rb7PmEgVXT1e3DaXVCd797OnpHEkNoW5btnp8K9fUaxZPfzuI+bonRTuHew/RcEZwRcPlBhXArG2NDi82TDo6ilaPIRKCt3s4F44JoEBvXpumPHKYaiQsu7mBj04iyb+KFz5epzfxrKvTbD5eNYJOjtOGaymwpLHfrWnmirJgu+juL0/F6bb2jpcApT+hvX/xK2GEx9bbGUwbw5ccWR/0NU0fHW1SE+oBVE6AHS/eXKARerX/jo8bQBT3RRzUWhvXA93Wb3Mn97BeVsGWjhF4eOZDBWd0blRH7JpVkFW3NwpT7Pfp2ntgVet+HtDvG88wFr+bSJEmL7c2MYKwtUFah6phbJq8fnrg5j5fdbwwlgn0WG/Ti7gvhSivbe5yH5wb24HLZCDbRRSGBr+AOAfjo3p7UcOBUCpHsVXV+b01y4tRGyVd2Q21GmJgRlBET7RtGrE9mm93YYB66JAMdhbLAtGJFTdZntHB0bC62cytPptgcEjR+qUWnKLn4EZsQderTeskl62OmManpfXsvN4sn+9yb/gS/TWQaM23dTvj6nuhwWonG50/nIXgG1iK9qkZj0LhQql0AEqvBVxGxSicOIVqVGLT64unZ7ye0RUWWpefhc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB7343.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(18002099003)(22082099003)(8096899003)(38070700021)(10067099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?vS3SP64oVJYout5q1CzuJ7J3NsDpVd0x3ukaZYCir4So7u5kpYf6NVA1E3?=
 =?iso-8859-1?Q?cbdqBc3StL9w7mm+aCCougbNq1+qWJKVezTxCZUJH9E1t8ye3oUiOgAAp2?=
 =?iso-8859-1?Q?tc6dZzYfL1WNGBz1mPQByjyH4T5L4gj452B9vpl7o6CXwuDZ2UGZeLpJLa?=
 =?iso-8859-1?Q?ydjx8ab9MFzs2TtJpIN2kgJEfzIkdAaI34cpV3mdgpZbWtZZJbMCcRWX7B?=
 =?iso-8859-1?Q?DdEmsOS/VW0NtoEKqMfr83rtMJlkVn1XmmSBVHDve3+TlPpFha56B+ib+H?=
 =?iso-8859-1?Q?uMD9Blk6xbo1DiTRWMUfZmx2Oyo7EbpzR6A0BYRdTgdd1uIeMT3wM4wbNm?=
 =?iso-8859-1?Q?fvs/TEiJXTu6nxguDGJneH0CNwb6FBPTk/fPNbwNtUiCUU5iH4hoU4wHCM?=
 =?iso-8859-1?Q?cZmZvzc6mXMOFGDuWbrhaMKPHzWz7QTGO9PZjNTOBRHpA5sYgKWEv1kV0j?=
 =?iso-8859-1?Q?ODUJSb5X9f8Tmb/eEvTLtmWjlfh2X+zUEyU5p8i+jklslBLwxC5i0pUlmi?=
 =?iso-8859-1?Q?T7XrKL42SuMcy9tJwEr64JkHoWAS1f7WBnoPNkMDfy3FnjYF3DWy8lbUMF?=
 =?iso-8859-1?Q?H77gT+mdNaGgN4q5J9coIgs8CpPmmpjQGUCH9L7tQ/ojA9/Jt9oF4PUnwN?=
 =?iso-8859-1?Q?llykySFcwc7htzG45JaERMFzFxK5ShFLBhdo1DIWFWqTIbsSksar4O7wMp?=
 =?iso-8859-1?Q?8w7+g6jJSw2OUNiPssFOoohyyA7oV1vsK7qyOuzxFK1MnfkTgSj1AxZJNR?=
 =?iso-8859-1?Q?nSg0mHcXmhuM9Qt7SWnH8MO2+OmKVNgeLm803+T/njEfUlRwlY9vsBqn2r?=
 =?iso-8859-1?Q?b1JBZ2fYcR/8Paz3Q6gZEPkh75EZ4jHjiEL4vEnoRT2YCaygjK+w6Zue97?=
 =?iso-8859-1?Q?LzC4Gbgm3EeIh3+24VyGnU1ItF4Vegrl3vQO2EuZ30Z26L1LW39amzImWM?=
 =?iso-8859-1?Q?wyF9CJdB82QpggO4qmohNZ4V90Q4Lw521DU/EhnhOxu6VBhqvnkZ2pWxiL?=
 =?iso-8859-1?Q?54nINXWls4huTyFyQ/MYmbuslB0wZ5TbIoaoCQmcO82uRRvU8BpsyuFy18?=
 =?iso-8859-1?Q?6F3fLHArkHhdxa2aeAr8HegIh1GOVpYjYCpqG/d3ZjnuvnTPtfSyMkQkdn?=
 =?iso-8859-1?Q?JZ2zZsSaiR3iHfqrpSi2JnTDctXjKxz78EAX8EME0NTqF4wrq8Up4I9Mn1?=
 =?iso-8859-1?Q?Gm1kKLXvN2HmdzTitNeRsgIoClKMKGZi+VH78LvWaqcje+QOrL22+zl8Je?=
 =?iso-8859-1?Q?UGkFicFou+aJrcoMKcvjvTOJRRZi2bRvDA17WacOC7dQtuAvmv4+g9jsYG?=
 =?iso-8859-1?Q?GedK9Nuw7C/fAvhWFJ0iXqibxrLnmFSFzvojmdQ8LfafYXxyrIeat6Vkk+?=
 =?iso-8859-1?Q?Q5GoarGMeWYcDIX0No9tCBBQJjgS1WZ0L9ksuS4rzRqrMsQRjklIuu4LJk?=
 =?iso-8859-1?Q?rfzPcVdV9lkWPCnMq5PUvPsOjYxeylmyilvjbLORqlJP+TGlDQUGPE41M0?=
 =?iso-8859-1?Q?j3oBE94Tjft28R19XKuiikadaSYg1H1tbUUR9Svpa9ODVBysyziiJrig3V?=
 =?iso-8859-1?Q?JsMv2N23zJbtyZFuOUrQiyB87sYlCF/NaflIYOvCU92VFXLkVgZTGn0O17?=
 =?iso-8859-1?Q?BO/3n60lPWYJ/dZN26nDTM2KRMnIeJcxAhzEQVh5sazaHIu1ypYnvHcuQO?=
 =?iso-8859-1?Q?R6Sy2x7he0E9C1B9gVhtRSykbliAwtSk003ovvR4YasELEUmjSeU3T010j?=
 =?iso-8859-1?Q?oOSs6NjZUz3eLe8HXFDMEy5YaUADM64qn0eyb4yOEEwH77?=
Content-Type: multipart/alternative;
 boundary="_000_SA1PR12MB7343131FD27AC222B0545912EBF82SA1PR12MB7343namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB7343.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 451cea2d-8c59-4431-f37c-08dee25f339f
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2026 10:52:44.8546 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JhcKnR8GP6+O1OBYor/xatrE7suySy+Nscnq6rCjiZ4Dvza6GKkysoAUolHTcbToQBXf+FtVR7tKYcOMXIAHUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6912
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

--_000_SA1PR12MB7343131FD27AC222B0545912EBF82SA1PR12MB7343namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

AMD General

Hi Alexander,

Could you please help review the patch?

Regards,
Shikang

________________________________
From: Shikang Fan <shikang.fan@amd.com>
Sent: Wednesday, July 15, 2026 6:30 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Fan, Shikang <Shikang.Fan@amd.com>
Subject: [PATCH] drm/amdkfd: save/restore MQD across hibernation when MQD i=
s in VRAM

On gfx942/944 and gfx9.5.0, KFD compute-queue MQDs live in a pinned VRAM
BO (mqd_on_vram()). Pinned VRAM is skipped by TTM eviction and not saved
across S4 hibernation, so the MQD is garbage on resume and the first
submission faults. Save it to a system-RAM shadow at suspend and restore
it on resume, reusing the CRIU checkpoint_mqd/restore_mqd primitives.

Signed-off-by: Shikang Fan <shikang.fan@amd.com>
---
 .../drm/amd/amdkfd/kfd_device_queue_manager.c | 100 ++++++++++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |   9 ++
 drivers/gpu/drm/amd/amdkfd/kfd_queue.c        |   2 +
 3 files changed, 111 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/driver=
s/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 5446d89a84b3..ba5ddd98891e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -65,6 +65,9 @@ static int map_queues_cpsch(struct device_queue_manager *=
dqm);
 static void deallocate_sdma_queue(struct device_queue_manager *dqm,
                                 struct queue *q);

+static int dqm_alloc_mqd_backup(struct device_queue_manager *dqm, struct q=
ueue *q);
+static void dqm_save_mqd_backup(struct device_queue_manager *dqm, struct q=
ueue *q);
+
 static inline void deallocate_hqd(struct device_queue_manager *dqm,
                                 struct queue *q);
 static int allocate_hqd(struct device_queue_manager *dqm, struct queue *q)=
;
@@ -785,6 +788,10 @@ static int create_queue_nocpsch(struct device_queue_ma=
nager *dqm,
                 mqd_mgr->init_mqd(mqd_mgr, &q->mqd, q->mqd_mem_obj,
                                         &q->gart_mqd_addr, &q->properties)=
;

+       retval =3D dqm_alloc_mqd_backup(dqm, q);
+       if (retval)
+               goto out_free_mqd;
+
         if (q->properties.is_active) {
                 if (!dqm->sched_running) {
                         WARN_ONCE(1, "Load non-HWS mqd while stopped\n");
@@ -1280,6 +1287,8 @@ static int evict_process_queues_nocpsch(struct device=
_queue_manager *dqm,
                          * maintain a consistent eviction state
                          */
                         ret =3D retval;
+
+               dqm_save_mqd_backup(dqm, q);
         }

 out:
@@ -1287,6 +1296,88 @@ static int evict_process_queues_nocpsch(struct devic=
e_queue_manager *dqm,
         return ret;
 }

+/* MQD software-shadow save/restore across S4 hibernation, reusing the CRI=
U
+ * checkpoint_mqd/restore_mqd primitives.
+ */
+static int dqm_alloc_mqd_backup(struct device_queue_manager *dqm, struct q=
ueue *q)
+{
+       struct mqd_manager *mqd_mgr;
+       uint32_t mqd_size, ctl_stack_size =3D 0;
+
+       if (!mqd_on_vram(dqm->dev->adev))
+               return 0;
+       if (q->properties.type !=3D KFD_QUEUE_TYPE_COMPUTE)
+               return 0;
+       if (!q->mqd)
+               return 0;
+
+       mqd_mgr =3D dqm->mqd_mgrs[get_mqd_type_from_queue_type(q->propertie=
s.type)];
+       if (!mqd_mgr->checkpoint_mqd || !mqd_mgr->restore_mqd)
+               return 0;
+
+       mqd_size =3D AMDGPU_MQD_SIZE_ALIGN(mqd_mgr->mqd_size) *
+                  NUM_XCC(dqm->dev->xcc_mask);
+       if (mqd_mgr->get_checkpoint_info)
+               mqd_mgr->get_checkpoint_info(mqd_mgr, q->mqd, &ctl_stack_si=
ze);
+
+       if (!q->mqd_backup) {
+               q->mqd_backup =3D kzalloc(mqd_size, GFP_KERNEL);
+               if (!q->mqd_backup)
+                       return -ENOMEM;
+               q->mqd_backup_size =3D mqd_size;
+       }
+       if (ctl_stack_size && !q->ctl_stack_backup) {
+               q->ctl_stack_backup =3D kzalloc(ctl_stack_size, GFP_KERNEL)=
;
+               if (!q->ctl_stack_backup) {
+                       kfree(q->mqd_backup);
+                       q->mqd_backup =3D NULL;
+                       q->mqd_backup_size =3D 0;
+                       return -ENOMEM;
+               }
+               q->ctl_stack_backup_size =3D ctl_stack_size;
+       }
+
+       return 0;
+}
+
+static void dqm_save_mqd_backup(struct device_queue_manager *dqm, struct q=
ueue *q)
+{
+       struct mqd_manager *mqd_mgr;
+
+       /* in_s4 is reliably set at evict/suspend time; skip normal runtime=
 eviction
+        * (pinned VRAM MQD stays intact then).
+        */
+       if (!dqm->dev->adev->in_s4)
+               return;
+       if (!q->mqd_backup)
+               return;
+       if (!q->mqd || !q->mqd_mem_obj || !q->mqd_mem_obj->cpu_ptr)
+               return;
+
+       mqd_mgr =3D dqm->mqd_mgrs[get_mqd_type_from_queue_type(q->propertie=
s.type)];
+       mqd_mgr->checkpoint_mqd(mqd_mgr, q->mqd, q->mqd_backup, q->ctl_stac=
k_backup);
+       q->mqd_backup_valid =3D true;
+}
+
+static void dqm_restore_mqd_backup(struct device_queue_manager *dqm, struc=
t queue *q)
+{
+       struct mqd_manager *mqd_mgr;
+
+       if (!q->mqd_backup_valid || !q->mqd_backup)
+               return;
+       if (!q->mqd_mem_obj)
+               return;
+
+       mqd_mgr =3D dqm->mqd_mgrs[get_mqd_type_from_queue_type(q->propertie=
s.type)];
+       if (!mqd_mgr->restore_mqd)
+               return;
+
+       mqd_mgr->restore_mqd(mqd_mgr, &q->mqd, q->mqd_mem_obj, &q->gart_mqd=
_addr,
+                            &q->properties, q->mqd_backup, q->ctl_stack_ba=
ckup,
+                            q->ctl_stack_backup_size);
+       q->mqd_backup_valid =3D false;
+}
+
 static int evict_process_queues_cpsch(struct device_queue_manager *dqm,
                                       struct qcm_process_device *qpd)
 {
@@ -1333,6 +1424,8 @@ static int evict_process_queues_cpsch(struct device_q=
ueue_manager *dqm,
                                 goto out;
                         }
                 }
+
+               dqm_save_mqd_backup(dqm, q);
         }

         if (!dqm->dev->kfd->shared_resources.enable_mes) {
@@ -1406,6 +1499,7 @@ static int restore_process_queues_nocpsch(struct devi=
ce_queue_manager *dqm,

                 mqd_mgr =3D dqm->mqd_mgrs[get_mqd_type_from_queue_type(
                                 q->properties.type)];
+               dqm_restore_mqd_backup(dqm, q);
                 q->properties.is_active =3D true;
                 increment_queue_count(dqm, qpd, q);

@@ -1469,6 +1563,7 @@ static int restore_process_queues_cpsch(struct device=
_queue_manager *dqm,
                 if (!QUEUE_IS_ACTIVE(q->properties))
                         continue;

+               dqm_restore_mqd_backup(dqm, q);
                 q->properties.is_active =3D true;
                 increment_queue_count(dqm, &pdd->qpd, q);

@@ -2144,6 +2239,10 @@ static int create_queue_cpsch(struct device_queue_ma=
nager *dqm, struct queue *q,
                 mqd_mgr->init_mqd(mqd_mgr, &q->mqd, q->mqd_mem_obj,
                                         &q->gart_mqd_addr, &q->properties)=
;

+       retval =3D dqm_alloc_mqd_backup(dqm, q);
+       if (retval)
+               goto out_free_mqd;
+
         list_add(&q->list, &qpd->queues_list);
         qpd->queue_count++;

@@ -2176,6 +2275,7 @@ static int create_queue_cpsch(struct device_queue_man=
ager *dqm, struct queue *q,
         list_del(&q->list);
         if (q->properties.is_active)
                 decrement_queue_count(dqm, qpd, q);
+out_free_mqd:
         mqd_mgr->free_mqd(mqd_mgr, q->mqd, q->mqd_mem_obj);
         dqm_unlock(dqm);
 out_deallocate_doorbell:
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/am=
dkfd/kfd_priv.h
index 88191a4c1657..1f728f13813e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -637,6 +637,15 @@ struct queue {
         void *gang_ctx_cpu_ptr;

         struct amdgpu_bo *wptr_bo_gart;
+
+       /* system-RAM shadow of a VRAM-resident MQD (+ control stack)
+        * for hibernation snapshot/restore
+        */
+       void *mqd_backup;
+       void *ctl_stack_backup;
+       uint32_t mqd_backup_size;
+       uint32_t ctl_stack_backup_size;
+       bool mqd_backup_valid;
 };

 enum KFD_MQD_TYPE {
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c b/drivers/gpu/drm/amd/a=
mdkfd/kfd_queue.c
index 98a5512b701b..cbc90bf87792 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
@@ -83,6 +83,8 @@ int init_queue(struct queue **q, const struct queue_prope=
rties *properties)

 void uninit_queue(struct queue *q)
 {
+       kfree(q->mqd_backup);
+       kfree(q->ctl_stack_backup);
         kfree(q);
 }

--
2.34.1


--_000_SA1PR12MB7343131FD27AC222B0545912EBF82SA1PR12MB7343namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div>
<div style=3D"font-family: Calibri; text-align: left; color: rgb(0, 0, 255)=
; margin-left: 5pt; font-size: 10pt;">
AMD General</div>
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Hi Alexander,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Could you please help review the patch?&nbsp;</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Regards,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Shikang</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<hr style=3D"display: inline-block; width: 98%;">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<b>From:</b> Shikang Fan &lt;shikang.fan@amd.com&gt;<br>
<b>Sent:</b> Wednesday, July 15, 2026 6:30 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Fan, Shikang &lt;Shikang.Fan@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdkfd: save/restore MQD across hibernation whe=
n MQD is in VRAM
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-size: 11pt;">On gfx942/944 and gfx9.5.0, KFD compute-que=
ue MQDs live in a pinned VRAM<br>
BO (mqd_on_vram()). Pinned VRAM is skipped by TTM eviction and not saved<br=
>
across S4 hibernation, so the MQD is garbage on resume and the first<br>
submission faults. Save it to a system-RAM shadow at suspend and restore<br=
>
it on resume, reusing the CRIU checkpoint_mqd/restore_mqd primitives.<br>
<br>
Signed-off-by: Shikang Fan &lt;shikang.fan@amd.com&gt;<br>
---<br>
&nbsp;.../drm/amd/amdkfd/kfd_device_queue_manager.c | 100 +++++++++++++++++=
+<br>
&nbsp;drivers/gpu/drm/amd/amdkfd/kfd_priv.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; |&nbsp;&nbsp; 9 ++<br>
&nbsp;drivers/gpu/drm/amd/amdkfd/kfd_queue.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; |&nbsp;&nbsp; 2 +<br>
&nbsp;3 files changed, 111 insertions(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/driver=
s/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c<br>
index 5446d89a84b3..ba5ddd98891e 100644<br>
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c<br>
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c<br>
@@ -65,6 +65,9 @@ static int map_queues_cpsch(struct device_queue_manager *=
dqm);<br>
&nbsp;static void deallocate_sdma_queue(struct device_queue_manager *dqm,<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct queue *q);<br>
&nbsp;<br>
+static int dqm_alloc_mqd_backup(struct device_queue_manager *dqm, struct q=
ueue *q);<br>
+static void dqm_save_mqd_backup(struct device_queue_manager *dqm, struct q=
ueue *q);<br>
+<br>
&nbsp;static inline void deallocate_hqd(struct device_queue_manager *dqm,<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct queue *q);<br>
&nbsp;static int allocate_hqd(struct device_queue_manager *dqm, struct queu=
e *q);<br>
@@ -785,6 +788,10 @@ static int create_queue_nocpsch(struct device_queue_ma=
nager *dqm,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; mqd_mgr-&gt;init_mqd(mqd_mgr, &amp;q-&gt;mqd, q-&gt;m=
qd_mem_obj,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; &amp;q-&gt;gart_mqd_addr, &amp;q-&gt;properties);<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retval =3D dqm_alloc_mqd_backup(dqm, =
q);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (retval)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; goto out_free_mqd;<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (q-&gt;properties.is_ac=
tive) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (!dqm-&gt;sched_running) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WARN_=
ONCE(1, &quot;Load non-HWS mqd while stopped\n&quot;);<br>
@@ -1280,6 +1287,8 @@ static int evict_process_queues_nocpsch(struct device=
_queue_manager *dqm,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 * maintain a consistent eviction state<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =
=3D retval;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dqm_save_mqd_backup(dqm, q);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;out:<br>
@@ -1287,6 +1296,88 @@ static int evict_process_queues_nocpsch(struct devic=
e_queue_manager *dqm,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;}<br>
&nbsp;<br>
+/* MQD software-shadow save/restore across S4 hibernation, reusing the CRI=
U<br>
+ * checkpoint_mqd/restore_mqd primitives.<br>
+ */<br>
+static int dqm_alloc_mqd_backup(struct device_queue_manager *dqm, struct q=
ueue *q)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct mqd_manager *mqd_mgr;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t mqd_size, ctl_stack_size =3D=
 0;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!mqd_on_vram(dqm-&gt;dev-&gt;adev=
))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return 0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (q-&gt;properties.type !=3D KFD_QU=
EUE_TYPE_COMPUTE)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return 0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!q-&gt;mqd)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return 0;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mqd_mgr =3D dqm-&gt;mqd_mgrs[get_mqd_=
type_from_queue_type(q-&gt;properties.type)];<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!mqd_mgr-&gt;checkpoint_mqd || !m=
qd_mgr-&gt;restore_mqd)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return 0;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mqd_size =3D AMDGPU_MQD_SIZE_ALIGN(mq=
d_mgr-&gt;mqd_size) *<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; NUM_XCC(dqm-&gt;dev-&gt;xcc_mask);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (mqd_mgr-&gt;get_checkpoint_info)<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; mqd_mgr-&gt;get_checkpoint_info(mqd_mgr, q-&gt;mqd, &amp;ctl_sta=
ck_size);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!q-&gt;mqd_backup) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; q-&gt;mqd_backup =3D kzalloc(mqd_size, GFP_KERNEL);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (!q-&gt;mqd_backup)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -ENOMEM;<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; q-&gt;mqd_backup_size =3D mqd_size;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ctl_stack_size &amp;&amp; !q-&gt;=
ctl_stack_backup) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; q-&gt;ctl_stack_backup =3D kzalloc(ctl_stack_size, GFP_KERNEL);<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (!q-&gt;ctl_stack_backup) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(q-&gt;mqd_=
backup);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; q-&gt;mqd_backup=
 =3D NULL;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; q-&gt;mqd_backup=
_size =3D 0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -ENOMEM;<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; q-&gt;ctl_stack_backup_size =3D ctl_stack_size;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
+}<br>
+<br>
+static void dqm_save_mqd_backup(struct device_queue_manager *dqm, struct q=
ueue *q)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct mqd_manager *mqd_mgr;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* in_s4 is reliably set at evict/sus=
pend time; skip normal runtime eviction<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * (pinned VRAM MQD stays intact=
 then).<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!dqm-&gt;dev-&gt;adev-&gt;in_s4)<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!q-&gt;mqd_backup)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!q-&gt;mqd || !q-&gt;mqd_mem_obj =
|| !q-&gt;mqd_mem_obj-&gt;cpu_ptr)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mqd_mgr =3D dqm-&gt;mqd_mgrs[get_mqd_=
type_from_queue_type(q-&gt;properties.type)];<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mqd_mgr-&gt;checkpoint_mqd(mqd_mgr, q=
-&gt;mqd, q-&gt;mqd_backup, q-&gt;ctl_stack_backup);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; q-&gt;mqd_backup_valid =3D true;<br>
+}<br>
+<br>
+static void dqm_restore_mqd_backup(struct device_queue_manager *dqm, struc=
t queue *q)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct mqd_manager *mqd_mgr;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!q-&gt;mqd_backup_valid || !q-&gt=
;mqd_backup)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!q-&gt;mqd_mem_obj)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mqd_mgr =3D dqm-&gt;mqd_mgrs[get_mqd_=
type_from_queue_type(q-&gt;properties.type)];<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!mqd_mgr-&gt;restore_mqd)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mqd_mgr-&gt;restore_mqd(mqd_mgr, &amp=
;q-&gt;mqd, q-&gt;mqd_mem_obj, &amp;q-&gt;gart_mqd_addr,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; &amp;q-&gt;properties, q-&gt;mqd_backup, q-&gt;ctl_stack_back=
up,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; q-&gt;ctl_stack_backup_size);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; q-&gt;mqd_backup_valid =3D false;<br>
+}<br>
+<br>
&nbsp;static int evict_process_queues_cpsch(struct device_queue_manager *dq=
m,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; struct qcm_process_device *qpd)<br>
&nbsp;{<br>
@@ -1333,6 +1424,8 @@ static int evict_process_queues_cpsch(struct device_q=
ueue_manager *dqm,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto out;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dqm_save_mqd_backup(dqm, q);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!dqm-&gt;dev-&gt;kfd-&=
gt;shared_resources.enable_mes) {<br>
@@ -1406,6 +1499,7 @@ static int restore_process_queues_nocpsch(struct devi=
ce_queue_manager *dqm,<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; mqd_mgr =3D dqm-&gt;mqd_mgrs[get_mqd_type_from_queue_=
type(<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; q-&gt;properties.type)];<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dqm_restore_mqd_backup(dqm, q);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; q-&gt;properties.is_active =3D true;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; increment_queue_count(dqm, qpd, q);<br>
&nbsp;<br>
@@ -1469,6 +1563,7 @@ static int restore_process_queues_cpsch(struct device=
_queue_manager *dqm,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (!QUEUE_IS_ACTIVE(q-&gt;properties))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; conti=
nue;<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dqm_restore_mqd_backup(dqm, q);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; q-&gt;properties.is_active =3D true;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; increment_queue_count(dqm, &amp;pdd-&gt;qpd, q);<br>
&nbsp;<br>
@@ -2144,6 +2239,10 @@ static int create_queue_cpsch(struct device_queue_ma=
nager *dqm, struct queue *q,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; mqd_mgr-&gt;init_mqd(mqd_mgr, &amp;q-&gt;mqd, q-&gt;m=
qd_mem_obj,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; &amp;q-&gt;gart_mqd_addr, &amp;q-&gt;properties);<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retval =3D dqm_alloc_mqd_backup(dqm, =
q);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (retval)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; goto out_free_mqd;<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_add(&amp;q-&gt;list, =
&amp;qpd-&gt;queues_list);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qpd-&gt;queue_count++;<br>
&nbsp;<br>
@@ -2176,6 +2275,7 @@ static int create_queue_cpsch(struct device_queue_man=
ager *dqm, struct queue *q,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_del(&amp;q-&gt;list);=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (q-&gt;properties.is_ac=
tive)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; decrement_queue_count(dqm, qpd, q);<br>
+out_free_mqd:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mqd_mgr-&gt;free_mqd(mqd_m=
gr, q-&gt;mqd, q-&gt;mqd_mem_obj);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dqm_unlock(dqm);<br>
&nbsp;out_deallocate_doorbell:<br>
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/am=
dkfd/kfd_priv.h<br>
index 88191a4c1657..1f728f13813e 100644<br>
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h<br>
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h<br>
@@ -637,6 +637,15 @@ struct queue {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void *gang_ctx_cpu_ptr;<br=
>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_bo *wptr_bo_=
gart;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* system-RAM shadow of a VRAM-reside=
nt MQD (+ control stack)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * for hibernation snapshot/rest=
ore<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void *mqd_backup;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void *ctl_stack_backup;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t mqd_backup_size;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t ctl_stack_backup_size;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool mqd_backup_valid;<br>
&nbsp;};<br>
&nbsp;<br>
&nbsp;enum KFD_MQD_TYPE {<br>
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c b/drivers/gpu/drm/amd/a=
mdkfd/kfd_queue.c<br>
index 98a5512b701b..cbc90bf87792 100644<br>
--- a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c<br>
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c<br>
@@ -83,6 +83,8 @@ int init_queue(struct queue **q, const struct queue_prope=
rties *properties)<br>
&nbsp;<br>
&nbsp;void uninit_queue(struct queue *q)<br>
&nbsp;{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(q-&gt;mqd_backup);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(q-&gt;ctl_stack_backup);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(q);<br>
&nbsp;}<br>
&nbsp;<br>
--<br>
2.34.1<br>
<br>
</div>
</body>
</html>

--_000_SA1PR12MB7343131FD27AC222B0545912EBF82SA1PR12MB7343namp_--
