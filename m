Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E0E0C55184
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Aug 2026 02:41:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0670010E0D4;
	Tue,  4 Aug 2026 02:41:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TSWkkXOy";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011037.outbound.protection.outlook.com [52.101.57.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 03B2710E0D4
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Aug 2026 02:41:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c9k5Ut1gGxb/V9hbdrjKJBg7XQvpBzygBjGLZb6FISoL8VAG4WoPKZZMWJz3t6k6bJhhwVk/dy4cexM9lxYH8FNlsIWQy2i7UMe3OydZ8CjUG5c9Lj/pj8oGqc5u95rioQCgJLhGCrRbMQeS8A9c9xg9TGknyoOwJ6xXjx52wMIS0dMYkYQIY9oByeDcSxOOawYl9AJyxmoQyve2wqgYQceLhTCXhAMOgE3Y+LoqQfvOqzBmbqtFeY90oGRXfThSlWNhwLnfXbupT91G9NeFVwSnbv5UhudyoPHhD0C8Kw4tH/s3lkFrTgUjwEXshrp42TXX/cg8U3ibL2NVcg+03g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=twZHMydFGDmesPcsCuv4HEN5/tssePP6ZIQGWjfZso8=;
 b=yNt+oRVG16fxv3fw+OItYz1ZA3VILqvsy7Z4MUwNBpQnwee7tdRHm24eVV82AuDSNt9QR7yhT+y5/uwIOxZBsVzJDxiRko7J1XwP7pFdaa3HbEJbHlEcYJWFRwYlKX4K0+xWxBl7AgjbPEZhYl5XKGmu8etynjgmEDyoXc2CVXapJ9ZFwZYVi19MmEH6y/pHAUIDs9HoFqeMgLN8wqMnfa2zA4SKe7vnszx0RW54cfmo7cGFdIl4EFZuDL/yS8OzIxz2caoDqRdOeLdfQA6e/AYGa7vkxlJneqePlrhaNmSBCiTqjltSvKX1rSz1q1Z7XzBjmc9Fij3/veVOILbMPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=twZHMydFGDmesPcsCuv4HEN5/tssePP6ZIQGWjfZso8=;
 b=TSWkkXOypmAQYr4LPS9TzO3xFalh0ZJCas/C72Lb2+S05SsE8ckwG5gWTYeqxI2S+t1b2b1fnw1Xf8LgtYvHla4uoZJS3tygnJddWyuEp6dlvfoO3awCtd4YYjIDU285jpdRltp2vJBqZiQGBd8yV4RyLTx5N/dUHuJuKXs7CnY=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 EAYPR12MB999182.namprd12.prod.outlook.com (2603:10b6:303:2c1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Tue, 4 Aug
 2026 02:41:47 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::ab84:617d:61a9:3727]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::ab84:617d:61a9:3727%3]) with mapi id 15.21.0270.017; Tue, 4 Aug 2026
 02:41:47 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Liang, Prike" <Prike.Liang@amd.com>, "Chen, Michael"
 <Michael.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
Subject: RE: [PATCH v2 2/2] drm/amdkfd: enable rs64mem for kfd queue
Thread-Topic: [PATCH v2 2/2] drm/amdkfd: enable rs64mem for kfd queue
Thread-Index: AQHdH8hzQdA6V0UvE0Ox2HMImbZFT7aMzksAgABab2CAAAxzIA==
Date: Tue, 4 Aug 2026 02:41:47 +0000
Message-ID: <DS7PR12MB6005F9C8036A771807066F98FBD42@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20260730020911.234193-1-Prike.Liang@amd.com>
 <20260730020911.234193-2-Prike.Liang@amd.com>
 <DM6PR12MB3611DD14C882B3CBAA936FE194D52@DM6PR12MB3611.namprd12.prod.outlook.com>
 <DS7PR12MB6005C28368E95CCF629D162CFBD42@DS7PR12MB6005.namprd12.prod.outlook.com>
In-Reply-To: <DS7PR12MB6005C28368E95CCF629D162CFBD42@DS7PR12MB6005.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-08-03T20:30:29.7300000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD
 General; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|EAYPR12MB999182:EE_
x-ms-office365-filtering-correlation-id: 95b8990e-34bf-41b9-d859-08def1d1ee08
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|38070700021|4143699003|56012099006|11063799006|10067099003|8096899003|22082099003|18002099003;
x-microsoft-antispam-message-info: mHLxxq/Am9dKw1S26dNKTjd81ztCH9kxCydlQwTZTrAjlQuDxUWFvF6fdzCIYoXBB9D58TTolwE6Z9B5t6ksEonxoowdJNPXKosY0qR18kq0I4wOwg3euh+Z/M3TbfXRw4Tx7rhPLSMPXgLlgXtjRIZXWDPjL0+3Du8+IEfQ1MMlhvqcPVpkYFrMCaa/Kgl6v/GOvzkqCKz0jcfH3wOhpCXQj3/wBeaoa6Ucln5xD0t+8G8psaEQRDN5s2fB3HNdBmGACHD4fXMYOhrRZXEFW3W9JIqSV8lwp1cTWOmgAjr7dXbL3stL5NNA7HZp8Klrviw8Zkutma2pmv7nsKgKEm+DT/Gmk1GeED+woKSBDlSKX+Sjg/LHcJXX2OYnnLCdzvyviLmWYFU5zU1laqXGTFb+3iDza9XOzDEJ4EN1Z5ttabtiswQMiswCtJzi9GM2oXW+FlqpLqaSIRX4uAYg40U5YZ2/cCTgMso8lnWuc69+dNbR/ait3gXMayvYc5a3fTy0fsyNYg9EL5NdU1vegB8220A1D7o+FYN0jJcOKdggi6jcaDBnJkGAJOX42cv/RhLQcSslcNyrJIx7y8sBgcz0XwtaQQajzBlEgv23QdYvwbAl0LGjiEBfgcXf56h6jwjygcSbbbcLFm+4aQ87z245IqL6ESzAU2v2Msf+cCyOlq4oAa+jnGNFhBCFW1ZlkJpBo85V2O1wn2PTvSoCsVf/umpoar5EB9xK2t5oTSo=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(38070700021)(4143699003)(56012099006)(11063799006)(10067099003)(8096899003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?WOEuStEj0/HcbsNFpePr4YOmrLeUXFqJS3Dq3SLidcs2YWL5k8mSwSacGy9u?=
 =?us-ascii?Q?zt+MBVjQEEbvY2HonIoCMRVVd/mr1niJtCXPMym8ptGROUA2irSakcn6S2R5?=
 =?us-ascii?Q?OIR5g6uK6BHugK7GZ9QDf7SinrGGw9v2Mt5sTKItK5jL5PzdU/nXPHmUAkfl?=
 =?us-ascii?Q?v3ud+TiNkeIgaGa5/B0RBK9iWx9KfGODgTryNpnxXnAuYDxGGj0Y7jcPvJ74?=
 =?us-ascii?Q?MQiPk77W9/PaOmma4AP6IRghwKe1VXyFJoZtANUcp/5WBteAynHQ3/NVkjdy?=
 =?us-ascii?Q?tzAM82FwSRUgdaE+kxKqdAtK0aBtceMwR41s0oPoDmEwIaQZysr609k7QjVo?=
 =?us-ascii?Q?tcpMnlZPqcCBXjZDURo4SkoDkvyrxi41tH/u+SAJAHQu0Ht3uM4nOSIdtdJf?=
 =?us-ascii?Q?DN+RoQXL0pU+XteuwBvRq1siETGIIFnv3zRY9WuQYIvPh3+owLCsMnA0R1Ys?=
 =?us-ascii?Q?OWB5qY/h8q6Uv3xo4nugVRPMgsQ8+H9uhRbRxhOCYsoMuK1se8voP0SuSSqA?=
 =?us-ascii?Q?UgA6DmjdY3AwxWxR6ADbGRzwzzfydowSEClbPZRqjzstqUfIN0beLdCDNyIQ?=
 =?us-ascii?Q?Z/6tshXNxXFBr1TH+AlKVpeRba7SRt+aupZXjIll2UQThkuG+O8RpyuEjEcd?=
 =?us-ascii?Q?zxUK/O0d25W38QVXKynUCpmnAg1vZe2AQu7vsTkXjM/CjPGChVOcnuyhNexx?=
 =?us-ascii?Q?seZLfeCs3rWeULZXi1IZIZxIPeibg240zOk+U8ekiwK1QE6uV0/OMeospFyk?=
 =?us-ascii?Q?oftuKzDIuIoM43DFm6d4yK1z5/gpj5e42HXNkwnyR0fzEsDD5UjbIKf6Q6ZM?=
 =?us-ascii?Q?kOrUq1ni8fqwEuAxv0KrWAxt6HkrqoxX4pjJr2N75xRl9izznnownW/QKHOR?=
 =?us-ascii?Q?yFncHobTO3gE7QTDHJRYumPa0gJtTTe2vJNXme6XggtIHW6qzTgP41m0dfNc?=
 =?us-ascii?Q?q4XprwrHWfNv8R3SrQsPnLYR9tD6BMTT+rxQHh45ts/Et1uL0Os2X5KqdUvw?=
 =?us-ascii?Q?EurEAGsNp5J3km6TFhpQA4TmSYuLSflOQG/lMk+8VM8dQhSHDQgsL+qpmyDc?=
 =?us-ascii?Q?8HUB+FJKz0HQEl5owxKNU185tMUrih35onYqN7AXNplUln6UMV3VWKYR6HWZ?=
 =?us-ascii?Q?hdfkXLRZMx/lKzpNWrB3ruWnDoBkATWH21jqmASVtTwdeRowA4KtXdpeRSLH?=
 =?us-ascii?Q?6/cXOCwK2MD2Dw3QZ/PfyVSZiROQigFYNfTiYsKUviQ2FnTDvZrgl48bvOGv?=
 =?us-ascii?Q?S2qIFPVVzlEAUYzC/0PfQo3LbmSKbkWtO2x4ivpiogaE+yAkuYccat1hb1x+?=
 =?us-ascii?Q?GRvYAgYsHZgjdCQsakZSMLfbz2Ft0FD2PLOnDgbnhbSntDgyzicbXLKqhmAV?=
 =?us-ascii?Q?dT44NolJn3qOTyAHJIgfEihww83sWiL3nIYxCv4hftuLk+I8UjFmHYUajm5n?=
 =?us-ascii?Q?hlgI4N2uUfD8lcUb3036BeuiwRYxgVpxKlDgK+XjLNmKMuCw79p20aN++583?=
 =?us-ascii?Q?ZKeK6BOBeFdGaq5x51lsZ5R+ZorQih1gmc5av+Vq8fbeAXOFSJQI09EfSXe8?=
 =?us-ascii?Q?lU0mcfYSG4KCCMiQnd0iVwTiXYjTj72Y+HTR20u8+QyZzwanFE/ZJmrpRvTD?=
 =?us-ascii?Q?hg7JaWg5oh9e9u+JK/LUVC55Z/fTmN30q9S34aPTHFbMBKiBUA28GNmuTtp5?=
 =?us-ascii?Q?Dsl1NGmObXARK+XqTEtXvo56hqUZk9wCVP2T74JaLgRp3ZCU?=
Content-Type: multipart/alternative;
 boundary="_000_DS7PR12MB6005F9C8036A771807066F98FBD42DS7PR12MB6005namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95b8990e-34bf-41b9-d859-08def1d1ee08
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2026 02:41:47.6935 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e0GPJUybI+lIVkdKSnROendkdvnv/vMoltOESXN65cC9d630AmMyOWTpHKdG92L0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EAYPR12MB999182
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

--_000_DS7PR12MB6005F9C8036A771807066F98FBD42DS7PR12MB6005namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

AMD General



Regards,
      Prike

From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Liang, P=
rike
Sent: Tuesday, August 4, 2026 9:57 AM
To: Chen, Michael <Michael.Chen@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Chri=
stian.Koenig@amd.com>; Liu, Shaoyun <Shaoyun.Liu@amd.com>
Subject: RE: [PATCH v2 2/2] drm/amdkfd: enable rs64mem for kfd queue


AMD General



Regards,
      Prike

From: Chen, Michael <Michael.Chen@amd.com<mailto:Michael.Chen@amd.com>>
Sent: Tuesday, August 4, 2026 4:31 AM
To: Liang, Prike <Prike.Liang@amd.com<mailto:Prike.Liang@amd.com>>; amd-gfx=
@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com<mailto:Alexander.Deucher@=
amd.com>>; Koenig, Christian <Christian.Koenig@amd.com<mailto:Christian.Koe=
nig@amd.com>>; Liu, Shaoyun <Shaoyun.Liu@amd.com<mailto:Shaoyun.Liu@amd.com=
>>
Subject: Re: [PATCH v2 2/2] drm/amdkfd: enable rs64mem for kfd queue

AMD General



________________________________
From: Liang, Prike <Prike.Liang@amd.com<mailto:Prike.Liang@amd.com>>
Sent: Wednesday, July 29, 2026 10:09 PM
To: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org> <am=
d-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com<mailto:Alexander.Deucher@=
amd.com>>; Koenig, Christian <Christian.Koenig@amd.com<mailto:Christian.Koe=
nig@amd.com>>; Chen, Michael <Michael.Chen@amd.com<mailto:Michael.Chen@amd.=
com>>; Liu, Shaoyun <Shaoyun.Liu@amd.com<mailto:Shaoyun.Liu@amd.com>>; Lian=
g, Prike <Prike.Liang@amd.com<mailto:Prike.Liang@amd.com>>
Subject: [PATCH v2 2/2] drm/amdkfd: enable rs64mem for kfd queue

Enabled RS64mem for KFD queues by integrating
process and gang context index allocation in
the per KFD device process and queue creation.

Signed-off-by: Prike Liang <Prike.Liang@amd.com<mailto:Prike.Liang@amd.com>=
>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c  |  3 +++
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h                  |  3 +++
 drivers/gpu/drm/amd/amdkfd/kfd_process.c               |  5 ++++-
 drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c | 10 ++++++++++
 4 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/driver=
s/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 51ee9c39104b..ea9d87450eae 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -226,8 +226,10 @@ static int add_queue_mes(struct device_queue_manager *=
dqm, struct queue *q,
         /* MES unit for quantum is 100ns */
         queue_input.process_quantum =3D KFD_MES_PROCESS_QUANTUM;  /* Equiv=
alent to 10ms. */
         queue_input.process_context_addr =3D pdd->proc_ctx_gpu_addr;
+       queue_input.process_context_array_index =3D pdd->proc_ctx_array_ind=
ex;
         queue_input.gang_quantum =3D KFD_MES_GANG_QUANTUM; /* Equivalent t=
o 1ms */
         queue_input.gang_context_addr =3D q->gang_ctx_gpu_addr;
+       queue_input.gang_context_array_index =3D q->gang_ctx_array_index;
         queue_input.inprocess_gang_priority =3D q->properties.priority;
         queue_input.gang_global_priority_level =3D
                                         AMDGPU_MES_PRIORITY_LEVEL_NORMAL;
@@ -303,6 +305,7 @@ static int remove_queue_mes_on_reset_option(struct devi=
ce_queue_manager *dqm, st
         queue_input.queue_type =3D convert_to_amdgpu_ring_type(q->properti=
es.type);
         queue_input.remove_queue_after_reset =3D flush_mes_queue;
         queue_input.xcc_id =3D ffs(dqm->dev->xcc_mask) - 1;
+       queue_input.gang_context_array_index =3D q->gang_ctx_array_index;

         amdgpu_mes_lock(&adev->mes);
         r =3D adev->mes.funcs->remove_hw_queue(&adev->mes, &queue_input);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/am=
dkfd/kfd_priv.h
index 88191a4c1657..3b89bcc625b3 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -635,6 +635,7 @@ struct queue {
         void *gang_ctx_bo;
         uint64_t gang_ctx_gpu_addr;
         void *gang_ctx_cpu_ptr;
+       uint32_t gang_ctx_array_index;

         struct amdgpu_bo *wptr_bo_gart;
 };
@@ -871,6 +872,8 @@ struct kfd_process_device {
         uint64_t proc_ctx_gpu_addr;
         void *proc_ctx_cpu_ptr;

+       uint32_t proc_ctx_array_index;
+
         /* Tracks queue reset status */
         bool has_reset_queue;

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd=
/amdkfd/kfd_process.c
index eb508fe3ded7..0a7c1900da95 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -1215,9 +1215,12 @@ static void kfd_process_destroy_pdds(struct kfd_proc=
ess *p)
                 kfd_free_process_doorbells(pdd->dev->kfd, pdd);

                 if (pdd->dev->kfd->shared_resources.enable_mes &&
-                       pdd->proc_ctx_cpu_ptr)
+                       pdd->proc_ctx_cpu_ptr) {
+                       amdgpu_mes_free_proc_ctx_index(&pdd->dev->adev->mes=
,
+                                                      pdd->proc_ctx_array_=
index);
                         amdgpu_amdkfd_free_kernel_mem(pdd->dev->adev,
                                                    &pdd->proc_ctx_bo);
+               }
                 /*
                  * before destroying pdd, make sure to report availability
                  * for auto suspend
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drive=
rs/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index 8054e4fe0381..72913b5c8338 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -210,6 +210,7 @@ static void pqm_clean_queue_resource(struct process_que=
ue_manager *pqm,
         }

         if (dev->kfd->shared_resources.enable_mes) {
+               amdgpu_mes_free_gang_ctx_index(&dev->adev->mes, pqn->q->gan=
g_ctx_array_index);
                 amdgpu_amdkfd_free_kernel_mem(dev->adev, &pqn->q->gang_ctx=
_bo);
                 amdgpu_amdkfd_free_kernel_mem(dev->adev, (void **)&pqn->q-=
>wptr_bo_gart);
         }
@@ -282,6 +283,9 @@ static int init_user_queue(struct process_queue_manager=
 *pqm,
                         goto cleanup;
                 }
                 memset((*q)->gang_ctx_cpu_ptr, 0, AMDGPU_MES_GANG_CTX_SIZE=
);
+               /* Bind one MES gang context slot per queue (gang). */
+               amdgpu_mes_alloc_gang_ctx_index(&dev->adev->mes,
+                                               &(*q)->gang_ctx_array_index=
);


  1.  Should check "mes->use_rs64mem" as you do in patch #1?

It doesn't have to check here, since the rs64mem support will be checked in=
 the amdgpu_mes_alloc_gang_ctx_index() as well.
>> Think more about it, we may still need to check the rs64mem flag at the =
invocation place to make the case which disables the rs64mem work properly.


  1.  Check return error code (in oversubscription case, it may run out of =
index)
Yeah, we add the error handler.

                 /* Starting with GFX11, wptr BOs must be mapped to GART fo=
r MES to determine work
                  * on unmapped queues for usermode queue oversubscription =
(no aggregated doorbell)
@@ -304,6 +308,7 @@ static int init_user_queue(struct process_queue_manager=
 *pqm,
         return 0;

 free_gang_ctx_bo:
+       amdgpu_mes_free_gang_ctx_index(&dev->adev->mes, (*q)->gang_ctx_arra=
y_index);
         amdgpu_amdkfd_free_kernel_mem(dev->adev, &(*q)->gang_ctx_bo);
 cleanup:
         uninit_queue(*q);
@@ -386,6 +391,11 @@ int pqm_create_queue(struct process_queue_manager *pqm=
,
                         goto err_allocate_pqn;
                 }
                 memset(pdd->proc_ctx_cpu_ptr, 0, AMDGPU_MES_PROC_CTX_SIZE)=
;
+               /* Bind one MES process context slot to the whole process
+                * (per device); every queue of this process reuses it.
+                */
+               amdgpu_mes_alloc_proc_ctx_index(&dev->adev->mes,
+                                               &pdd->proc_ctx_array_index)=
;

Same comment as above.

         }

         pqn =3D kzalloc_obj(*pqn);
--
2.34.1


--_000_DS7PR12MB6005F9C8036A771807066F98FBD42DS7PR12MB6005namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]--><style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Aptos;}
@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:12.0pt;
	font-family:"Aptos",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#467886;
	text-decoration:underline;}
span.EmailStyle21
	{mso-style-type:personal-reply;
	font-family:"Arial",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
	mso-ligatures:none;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
/* List Definitions */
@list l0
	{mso-list-id:340591622;
	mso-list-template-ids:697357542;}
@list l1
	{mso-list-id:1790928994;
	mso-list-template-ids:1693111158;}
@list l1:level1
	{mso-level-start-at:2;
	mso-level-tab-stop:.5in;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l2
	{mso-list-id:1989943214;
	mso-list-template-ids:227286362;}
@list l2:level1
	{mso-level-tab-stop:.5in;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l2:level2
	{mso-level-tab-stop:1.0in;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l2:level3
	{mso-level-tab-stop:1.5in;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l2:level4
	{mso-level-tab-stop:2.0in;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l2:level5
	{mso-level-tab-stop:2.5in;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l2:level6
	{mso-level-tab-stop:3.0in;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l2:level7
	{mso-level-tab-stop:3.5in;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l2:level8
	{mso-level-tab-stop:4.0in;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l2:level9
	{mso-level-tab-stop:4.5in;
	mso-level-number-position:left;
	text-indent:-.25in;}
ol
	{margin-bottom:0in;}
ul
	{margin-bottom:0in;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#467886" vlink=3D"#96607D" style=3D"word-wrap:=
break-word">
<p style=3D"font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
AMD General<br>
</p>
<br>
<div>
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;mso-ligatures:standa=
rdcontextual">Regards,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;mso-ligatures:standa=
rdcontextual">&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;Prike<o:p></o:p></span></p>
</div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b><span style=3D"font-size:11.0pt;font-family:&quot=
;Calibri&quot;,sans-serif">From:</span></b><span style=3D"font-size:11.0pt;=
font-family:&quot;Calibri&quot;,sans-serif"> amd-gfx &lt;amd-gfx-bounces@li=
sts.freedesktop.org&gt;
<b>On Behalf Of </b>Liang, Prike<br>
<b>Sent:</b> Tuesday, August 4, 2026 9:57 AM<br>
<b>To:</b> Chen, Michael &lt;Michael.Chen@amd.com&gt;; amd-gfx@lists.freede=
sktop.org<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Koenig, Ch=
ristian &lt;Christian.Koenig@amd.com&gt;; Liu, Shaoyun &lt;Shaoyun.Liu@amd.=
com&gt;<br>
<b>Subject:</b> RE: [PATCH v2 2/2] drm/amdkfd: enable rs64mem for kfd queue=
<o:p></o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p style=3D"margin:5.0pt"><span style=3D"font-size:10.0pt;font-family:&quot=
;Calibri&quot;,sans-serif;color:blue">AMD General<o:p></o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;mso-ligatures:standa=
rdcontextual">Regards,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;mso-ligatures:standa=
rdcontextual">&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;Prike<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in =
4.0pt">
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b><span style=3D"font-size:11.0pt;font-family:&quot=
;Calibri&quot;,sans-serif">From:</span></b><span style=3D"font-size:11.0pt;=
font-family:&quot;Calibri&quot;,sans-serif"> Chen, Michael &lt;<a href=3D"m=
ailto:Michael.Chen@amd.com">Michael.Chen@amd.com</a>&gt;
<br>
<b>Sent:</b> Tuesday, August 4, 2026 4:31 AM<br>
<b>To:</b> Liang, Prike &lt;<a href=3D"mailto:Prike.Liang@amd.com">Prike.Li=
ang@amd.com</a>&gt;;
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a><br>
<b>Cc:</b> Deucher, Alexander &lt;<a href=3D"mailto:Alexander.Deucher@amd.c=
om">Alexander.Deucher@amd.com</a>&gt;; Koenig, Christian &lt;<a href=3D"mai=
lto:Christian.Koenig@amd.com">Christian.Koenig@amd.com</a>&gt;; Liu, Shaoyu=
n &lt;<a href=3D"mailto:Shaoyun.Liu@amd.com">Shaoyun.Liu@amd.com</a>&gt;<br=
>
<b>Subject:</b> Re: [PATCH v2 2/2] drm/amdkfd: enable rs64mem for kfd queue=
<o:p></o:p></span></p>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div style=3D"margin-left:5.0pt">
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:blue">AMD General<o:p></o:p></span></p>
</div>
<p class=3D"MsoNormal"><span style=3D"color:black"><o:p>&nbsp;</o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"color:black"><o:p>&nbsp;</o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"color:black"><o:p>&nbsp;</o:p></span>=
</p>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"1" width=3D"98%" align=3D"center">
</div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"font-size:11.0pt;font-family:&quot=
;Calibri&quot;,sans-serif;color:black">From:</span></b><span style=3D"font-=
size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:black"> Liang,=
 Prike &lt;<a href=3D"mailto:Prike.Liang@amd.com">Prike.Liang@amd.com</a>&g=
t;<br>
<b>Sent:</b> Wednesday, July 29, 2026 10:09 PM<br>
<b>To:</b> <a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.f=
reedesktop.org</a> &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd=
-gfx@lists.freedesktop.org</a>&gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;<a href=3D"mailto:Alexander.Deucher@amd.c=
om">Alexander.Deucher@amd.com</a>&gt;; Koenig, Christian &lt;<a href=3D"mai=
lto:Christian.Koenig@amd.com">Christian.Koenig@amd.com</a>&gt;; Chen, Micha=
el &lt;<a href=3D"mailto:Michael.Chen@amd.com">Michael.Chen@amd.com</a>&gt;=
;
 Liu, Shaoyun &lt;<a href=3D"mailto:Shaoyun.Liu@amd.com">Shaoyun.Liu@amd.co=
m</a>&gt;; Liang, Prike &lt;<a href=3D"mailto:Prike.Liang@amd.com">Prike.Li=
ang@amd.com</a>&gt;<br>
<b>Subject:</b> [PATCH v2 2/2] drm/amdkfd: enable rs64mem for kfd queue<o:p=
></o:p></span></p>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">Enabled RS64mem for=
 KFD queues by integrating<br>
process and gang context index allocation in<br>
the per KFD device process and queue creation.<br>
<br>
Signed-off-by: Prike Liang &lt;<a href=3D"mailto:Prike.Liang@amd.com">Prike=
.Liang@amd.com</a>&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c&nbsp; |&nbsp; 3=
 +++<br>
&nbsp;drivers/gpu/drm/amd/amdkfd/kfd_priv.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nb=
sp; 3 +++<br>
&nbsp;drivers/gpu/drm/amd/amdkfd/kfd_process.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 5 ++++-<br>
&nbsp;drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c | 10 +++++++++=
+<br>
&nbsp;4 files changed, 20 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/driver=
s/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c<br>
index 51ee9c39104b..ea9d87450eae 100644<br>
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c<br>
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c<br>
@@ -226,8 +226,10 @@ static int add_queue_mes(struct device_queue_manager *=
dqm, struct queue *q,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* MES unit for quantum is=
 100ns */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; queue_input.process_quantu=
m =3D KFD_MES_PROCESS_QUANTUM;&nbsp; /* Equivalent to 10ms. */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; queue_input.process_contex=
t_addr =3D pdd-&gt;proc_ctx_gpu_addr;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; queue_input.process_context_array_ind=
ex =3D pdd-&gt;proc_ctx_array_index;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; queue_input.gang_quantum =
=3D KFD_MES_GANG_QUANTUM; /* Equivalent to 1ms */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; queue_input.gang_context_a=
ddr =3D q-&gt;gang_ctx_gpu_addr;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; queue_input.gang_context_array_index =
=3D q-&gt;gang_ctx_array_index;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; queue_input.inprocess_gang=
_priority =3D q-&gt;properties.priority;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; queue_input.gang_global_pr=
iority_level =3D<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; AMDGPU_MES_PRIORITY_LEVEL_NORMAL;<br>
@@ -303,6 +305,7 @@ static int remove_queue_mes_on_reset_option(struct devi=
ce_queue_manager *dqm, st<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; queue_input.queue_type =3D=
 convert_to_amdgpu_ring_type(q-&gt;properties.type);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; queue_input.remove_queue_a=
fter_reset =3D flush_mes_queue;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; queue_input.xcc_id =3D ffs=
(dqm-&gt;dev-&gt;xcc_mask) - 1;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; queue_input.gang_context_array_index =
=3D q-&gt;gang_ctx_array_index;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_mes_lock(&amp;adev-=
&gt;mes);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D adev-&gt;mes.funcs-&=
gt;remove_hw_queue(&amp;adev-&gt;mes, &amp;queue_input);<br>
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/am=
dkfd/kfd_priv.h<br>
index 88191a4c1657..3b89bcc625b3 100644<br>
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h<br>
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h<br>
@@ -635,6 +635,7 @@ struct queue {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void *gang_ctx_bo;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t gang_ctx_gpu_addr=
;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void *gang_ctx_cpu_ptr;<br=
>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t gang_ctx_array_index;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_bo *wptr_bo_=
gart;<br>
&nbsp;};<br>
@@ -871,6 +872,8 @@ struct kfd_process_device {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t proc_ctx_gpu_addr=
;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void *proc_ctx_cpu_ptr;<br=
>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t proc_ctx_array_index;<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Tracks queue reset stat=
us */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool has_reset_queue;<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd=
/amdkfd/kfd_process.c<br>
index eb508fe3ded7..0a7c1900da95 100644<br>
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c<br>
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c<br>
@@ -1215,9 +1215,12 @@ static void kfd_process_destroy_pdds(struct kfd_proc=
ess *p)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; kfd_free_process_doorbells(pdd-&gt;dev-&gt;kfd, pdd);=
<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (pdd-&gt;dev-&gt;kfd-&gt;shared_resources.enable_m=
es &amp;&amp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pdd-&gt;proc_ctx=
_cpu_ptr)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pdd-&gt;proc_ctx=
_cpu_ptr) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_mes_free_=
proc_ctx_index(&amp;pdd-&gt;dev-&gt;adev-&gt;mes,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; pdd-&gt;proc_ctx_array_index);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgp=
u_amdkfd_free_kernel_mem(pdd-&gt;dev-&gt;adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; &amp;pdd-&gt;proc_ctx_bo);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /*<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; * before destroying pdd, make sure to report av=
ailability<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; * for auto suspend<br>
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drive=
rs/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c<br>
index 8054e4fe0381..72913b5c8338 100644<br>
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c<br>
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c<br>
@@ -210,6 +210,7 @@ static void pqm_clean_queue_resource(struct process_que=
ue_manager *pqm,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (dev-&gt;kfd-&gt;shared=
_resources.enable_mes) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_mes_free_gang_ctx_index(&amp;dev-&gt;adev-&gt;mes, pqn-&g=
t;q-&gt;gang_ctx_array_index);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; amdgpu_amdkfd_free_kernel_mem(dev-&gt;adev, &amp;pqn-=
&gt;q-&gt;gang_ctx_bo);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; amdgpu_amdkfd_free_kernel_mem(dev-&gt;adev, (void **)=
&amp;pqn-&gt;q-&gt;wptr_bo_gart);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
@@ -282,6 +283,9 @@ static int init_user_queue(struct process_queue_manager=
 *pqm,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto =
cleanup;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; memset((*q)-&gt;gang_ctx_cpu_ptr, 0, AMDGPU_MES_GANG_=
CTX_SIZE);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; /* Bind one MES gang context slot per queue (gang). */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_mes_alloc_gang_ctx_index(&amp;dev-&gt;adev-&gt;mes,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;(*q)-&gt;gang_ctx=
_array_index);<br>
&nbsp;<o:p></o:p></span></p>
<ol style=3D"margin-top:0in" start=3D"1" type=3D"1">
<li class=3D"MsoNormal" style=3D"color:black;mso-list:l2 level1 lfo3"><span=
 style=3D"font-size:11.0pt">Should check &quot;mes-&gt;use_rs64mem&quot; as=
 you do in patch #1?<o:p></o:p></span></li></ol>
<p class=3D"MsoNormal"><b><i><span style=3D"font-size:11.0pt;font-family:&q=
uot;Arial&quot;,sans-serif"><o:p>&nbsp;</o:p></span></i></b></p>
<p class=3D"MsoNormal"><b><i><span style=3D"font-size:11.0pt;font-family:&q=
uot;Arial&quot;,sans-serif">It doesn&#8217;t have to check here, since the =
rs64mem support will be checked in the amdgpu_mes_alloc_gang_ctx_index() as=
 well.<o:p></o:p></span></i></b></p>
<p class=3D"MsoNormal"><b><i><span style=3D"font-size:11.0pt;font-family:&q=
uot;Arial&quot;,sans-serif">&gt;&gt; Think more about it, we may still need=
 to check the
</span></i></b><b><i><span style=3D"font-size:11.0pt;font-family:&quot;Aria=
l&quot;,sans-serif">rs64mem flag at the invocation place to make the case w=
hich disables the rs64mem work properly.</span></i></b><b><i><span style=3D=
"font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></sp=
an></i></b></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
<ol style=3D"margin-top:0in" start=3D"2" type=3D"1">
<li class=3D"MsoNormal" style=3D"color:black;mso-list:l2 level1 lfo3"><span=
 style=3D"font-size:11.0pt">Check return error code (in oversubscription ca=
se, it may run out of index)<o:p></o:p></span></li></ol>
<p class=3D"MsoNormal"><b><i><span style=3D"font-size:11.0pt">Yeah, we add =
the error handler.
</span></i></b><span style=3D"font-size:11.0pt;color:black"><o:p></o:p></sp=
an></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; /* Starting with GFX11, wptr BOs must be mapped to GART for MES to deter=
mine work<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; * on unmapped queues for usermode queue oversubscription (no aggre=
gated doorbell)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">@@ -304,6 +308,7 @@=
 static int init_user_queue(struct process_queue_manager *pqm,<o:p></o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&nbsp;<o:p></o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&nbsp;free_gang_ctx=
_bo:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; amdgpu_mes_free_gang_ctx_index(&amp;dev-&gt;adev-&gt;mes=
, (*q)-&gt;gang_ctx_array_index);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_amdkfd_free_kernel_mem(dev-&gt;adev, &=
amp;(*q)-&gt;gang_ctx_bo);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&nbsp;cleanup:<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uninit_queue(*q);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">@@ -386,6 +391,11 @=
@ int pqm_create_queue(struct process_queue_manager *pqm,<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto err_allocate_pqn;<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; }<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; memset(pdd-&gt;proc_ctx_cpu_ptr, 0, AMDGPU_MES_PROC_CTX_SIZE);<o:p></o:p=
></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Bind =
one MES process context slot to the whole process<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * =
(per device); every queue of this process reuses it.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_m=
es_alloc_proc_ctx_index(&amp;dev-&gt;adev-&gt;mes,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;pdd-&gt;proc_ctx_array_index);<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;color:black">Same co=
mment as above.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&nbsp;<o:p></o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pqn =3D kzalloc_obj(*pqn);<o:p></o:p></span><=
/p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">--<o:p></o:p></span=
></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">2.34.1<o:p></o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_DS7PR12MB6005F9C8036A771807066F98FBD42DS7PR12MB6005namp_--
