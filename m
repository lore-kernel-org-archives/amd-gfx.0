Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93209606E2F1
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Nov 2026 19:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=FiHNmKx3
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F1FE10FEBA;
	Wed,  4 Nov 2026 19:58:56 +0000 (UTC)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013039.outbound.protection.outlook.com
 [40.93.196.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3AE9810FEBA
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Nov 2026 19:58:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LJBRKE9+jwZAre/HvBhan/A1B4jsDYnmMeqJvt7q6xRfBisKtGQSSTcGND80vEcwvyy9rHeSjtkYb9nXbvATmxpqMAoVPO+qxKBM+bCZc3lXSP2q2pcfPtzAK36UC/rtTuOaT50B26xOCYpi17IqKpabXLYPh2Ybd9khyYcXoRX7MYqfuzboBYo9872MzwiaoqXu6uCBB5THTfJJbMzFz/3S1z8VvxoF4iM0lOcSQGKniQ7pSGZ3PhMSEQsCbev8T3+pViQpPr/lAimK1gpt4koQ+fG8kEKF+INksMZyRueW/Z93m9RdU5XvDC2jM37nDPsgTptoePRs97XHNetqlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7pLuJK3qbKCfQ9/eNDNvNvItmuZLg9pJy0DzuBaVgsA=;
 b=jygfjRL6FKubVorKW50Nt40CzySivmeNm8XUlmljbbo+VV93O1a06vmw1BWXGz1wopMtSU5ubJPT2uGZVFKkYvlKTO4Ht9zldl8Z+TLxQsHVeRLiEDDDYNblGHrvaT8tSi2u/+HDxiPvuhNe3Lfr02Vw5mRuK+syjqURQX+Z2UXWNcOIT0bud4mP+tK6YzJ3vqNt1WjjWWRhzQBS/Q7/UmCSV7IwkCM8Gerdw8bXsCM6smqyc+IK2T3aW30gMf6Cy0+cnxcXKn4exig/3vnmzll3M8Iiq5ZmMWWp+wT7IUNQXSwmL4KJO1bQgEpEEq7Fjn7QkiyfZWNsTMRI6ZVwfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7pLuJK3qbKCfQ9/eNDNvNvItmuZLg9pJy0DzuBaVgsA=;
 b=FiHNmKx3060k3dww+rB2+mXRHa1PDSMBiiLgeBZjpE5hiJb9NwOvDJVkimeFcN/FDDS9Tq06cemQGhOc8kgZaZjNHJISM4AvB12gE68P07ADvKB9bc20nx7GlPzRqBwHSNdblh7mUAIR0LkvCCaBibO8Qziaa/yJoyv5Mf82IkI=
Received: from CHAPR12MB999247.namprd12.prod.outlook.com
 (2603:10b6:610:2ff::7) by DS0PR12MB8269.namprd12.prod.outlook.com
 (2603:10b6:8:fd::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Wed, 4 Nov 2026
 19:58:44 +0000
Received: from CHAPR12MB999247.namprd12.prod.outlook.com
 ([fe80::d727:e84d:1883:b74]) by CHAPR12MB999247.namprd12.prod.outlook.com
 ([fe80::d727:e84d:1883:b74%6]) with mapi id 15.21.0592.007; Wed, 4 Nov 2026
 19:58:44 +0000
From: "Francis, David" <David.Francis@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH v4 1/2] drm/amdkfd: Acquire buffers in CRIU queue restore
 (again)
Thread-Topic: [PATCH v4 1/2] drm/amdkfd: Acquire buffers in CRIU queue restore
 (again)
Thread-Index: AQHdbHR+yLHoFkZYykSMxDZ5JG4xtrceUsiAgAACAJE=
Date: Wed, 4 Nov 2026 19:58:43 +0000
Message-ID: <CHAPR12MB9992479657C0BC8094D14860F3EF682@CHAPR12MB999247.namprd12.prod.outlook.com>
References: <20261104155203.3826257-1-David.Francis@amd.com>
 <05d0a2b7-9469-4c05-b8da-c25ed86feff4@amd.com>
In-Reply-To: <05d0a2b7-9469-4c05-b8da-c25ed86feff4@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-11-04T19:58:43.396Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD
 General; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=1;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard; 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CHAPR12MB999247:EE_|DS0PR12MB8269:EE_
x-ms-office365-filtering-correlation-id: 15c9c1f7-abb5-450a-d0db-08df3aae07ce
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|38070700021|261022105027099003|11063799006|4143699003|56012099006|261021121427099003|261009223027099003|261021123027099003|261026121527099003|261026140227099003|261102123227099003|261028144727099003|10067099003|22082099003|18002099003;
x-microsoft-antispam-message-info: ICqodOTIDSuYsZbJbzKoAyAe6TES+3almM9gkvTKRgBdUHU6jCiUOLLt5IbMBDI6qOWMPIJkfWz68m2u5JG4xznWKEDWZYoFTUjoufO7lzljDIUgceXgKl6ZOSTWpfxyvYqS0+Q9z9qIFTREcxxVSYMmNU6/4Pc0X7vrHyIU5dSklthtKfyCsOO28e79qXTQzaRDZPT7bPCL7LsJ7JMANGtmLByodJ+JPz9tGBHcJH4tC2WG5PJ4bplPMDfC49PaPBcQphQcEOLj/Q/G7Hv1ILmqrFSTk9B9wrMrlMQOoPXgZ09CQJ1AjDQb2RXo8OHgC/gzLIgZCfytLKr6CG++wVcts6oeOVsUkoiPoeSYCZiXdFubuC6CHNPC8n7hgq9lUia1M4eFpYlLELesVc2p+Uc3uD8mRvXEI9lOPf/xyu4YlkdBx1bKt3exBWk9KaUu/APwdDCUN7qA0CPqWiz9oaXUiDehrUlhAgoc+rEZFBX8Gx1/ThiAdQAVYda+Ot8HubAKjIZWoZlaJYplQYitOo9bZ3DN0RUNBoacbvvKkkc87wxhY2nc2Id68Fx9qflEXWbk4aAj/TP2jJl9EYXwns4/VS791vjwpJFIKstICAruhPHZcDlxsvbjdM4fNuupJlczikaeAlYoYDqgI63me+uiRoaIbzfms5ssf7DsCWT0bBY/7RFydrbWwWoEnwMjm85pL6fv/HGybutnYWJfKTAAvo06uMGVpptRht1yqSo=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CHAPR12MB999247.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(38070700021)(261022105027099003)(11063799006)(4143699003)(56012099006)(261021121427099003)(261009223027099003)(261021123027099003)(261026121527099003)(261026140227099003)(261102123227099003)(261028144727099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0IMWMtacNGFl3w2gac8x6jyuTUT44D5TLxzbNS52WdFFrOPr+GbYpth9pmEE?=
 =?us-ascii?Q?ZP54pCatqITqUsa8TZDjyL/9I1QmdiO93qdNIdmC4OneXVCBei4LiuJPkX69?=
 =?us-ascii?Q?i2J00GsgGNve2uafwJV+FMsWy3P3C7JIJNXRH45KFMDyumu6CuxchZaswk0+?=
 =?us-ascii?Q?XV9nA9bBYWWT4YgIxhGWha4VSD81DObRgwx2+pJTRwY15W2I9uCM2XUfR0RW?=
 =?us-ascii?Q?V9/eQUHe6D3RdkPyiEhdHesGBI7RKVFQdKqPUTgmHBR7/1qjVz0LkQ5lmrvu?=
 =?us-ascii?Q?rpwfsWhZBOAZWiAHsDe0GxU23R++AJPJj05GJDFe8AkSGMpWxqJHPQBZ+4BK?=
 =?us-ascii?Q?oY8HcQ2QvJULJ82zvaCjq4IVN8vqqYH8mvPlYh2GG3h766ZjfrEzXQKBYvCl?=
 =?us-ascii?Q?2PBWpUioxwqngyuluHCP5aJEkCFniwKFTFJBuXrA8brAUtFr1LttyJgXOASp?=
 =?us-ascii?Q?3TbLCghCYIOhiDOdQ9q+Kgx5dKcqGZSnvi7jKoqgs+8s+OWSKn9hpch2K1yK?=
 =?us-ascii?Q?NiDxjDiRyVhDbvu92HuDfx2B2g+5rhF2jfDtTkGjeUr3nysCuC8n+f9hhfny?=
 =?us-ascii?Q?kMPB0pEBaxiXbnEItwQc4xESvgWkaVpoOYQunBZ15FwZrFbMVYn+kBsudDxQ?=
 =?us-ascii?Q?UX+jcGfbnrWoY0vprO4yOiesKtVkye7ns+5rfdWUWBaHh9vk1iCiWcgF3ea0?=
 =?us-ascii?Q?uVphlo+/KhvYWTuJx7J7TG8TY7NvQFBjJyFnnTPAbHyb4bZKnUhC9ZNZHKca?=
 =?us-ascii?Q?F2/TAmRHeQO7PvTsakEwEjho4WeshXjofq4cB1QlYa1mHSqUVbcUikUxsuAG?=
 =?us-ascii?Q?2oRRbnMGJHgA4rLm3jwY6/z6JnIMbPxlfMOrfhAKoIOsgSui+mqLe2E+hbac?=
 =?us-ascii?Q?caItwB5VPKZe7og09l382JVN5rk9lMQkWsTvbKCsVFfvv+IUAk322k5xkYUQ?=
 =?us-ascii?Q?XmK9ELdmA2e4+kLUgbXiiVUDKQGo9mn7vEYbVNWzcyCObRYWdGzKqiNHqd25?=
 =?us-ascii?Q?LQEvKWt7ZGYSWngUUQA6Iv1CG4e2rTApDr4lBcvgTnLi8HN/nV4cPcD/fHkW?=
 =?us-ascii?Q?ojSsbPqvaLvUJ4ga83U1qnvJT0idQ9WV9oIIQ93ThAlou0Zn1ehKS/E+sckc?=
 =?us-ascii?Q?Kags37pdn3s0KEYufrLKyMkCVeSE7EmAI15B0QlbBM9jh/R/cTstV/IZuLux?=
 =?us-ascii?Q?mQCMEC7PAg/NbTHZsp8AsyY2DSCiZmN+p0/tmoF0kgIsc7qE2UYEXf1h4CQZ?=
 =?us-ascii?Q?irfRovqGGJvNfa8mqdm0ouvdBePTSubZ9HQkOfJNHODyDQYK7asV7aWDc0zQ?=
 =?us-ascii?Q?wk41eIFa0LxVsL/IFrFlsrErve7X7GKfxBz9QCOctIcDfHb6wg5ZTMunEa/P?=
 =?us-ascii?Q?LHY8IaeUCV3O9phN3AA7mhpHfzm+elORYdMcr8dLN1WslVcNTcnQEh9fGZ3m?=
 =?us-ascii?Q?etOgBbCCPb+wlO8d7n2oCF2dn36zdvxUJubvk5hZfWhKNErv6qMOI+RoTRfd?=
 =?us-ascii?Q?jUH/mv1lcHZGT2XYLS7RwGFyMCQVx8YDirTARgstcNAoOQ52sguD1bfM48FV?=
 =?us-ascii?Q?F8XYLM8NTfF9rKuxlslD4/p1TTkHEC+MJmMThcAXkXWAuQPKizHm8mC/BYgt?=
 =?us-ascii?Q?zfZDADrrsN4NqIh5WWnemW1H4zSydi8xpwgUVcxQhGzRCrSsngbnbgzN/qeL?=
 =?us-ascii?Q?aBFRsxHUAvlJlOlF/9WXeq6gOdio7gr7Fui3oliQPMdWtQHG?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CHAPR12MB999247.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15c9c1f7-abb5-450a-d0db-08df3aae07ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2026 19:58:43.9047 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jmGP7oOvkKfKISNEY8ACumw44GEhUi3H28c6A16BfAC7pFBEGvMwZYnEcbAx9Sp/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8269
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

>I think kfd_queue_release_buffers also needs another parameter to tell
>it not to handle SVM. Otherwise it will call kfd_queue_buffer_svm_put
>and try to decrement queue refcounts in pranges that weren't incremented.
>
>Regards,
>   Felix

Good catch, will fix

David

________________________________________
From: Kuehling, Felix <Felix.Kuehling@amd.com>
Sent: Wednesday, November 4, 2026 2:51 PM
To: Francis, David; amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH v4 1/2] drm/amdkfd: Acquire buffers in CRIU queue resto=
re (again)


On 2026-11-04 10:52, David Francis wrote:
> CRIU queue restore doesn't acquire the bo buffers in the same way
> normal queue creation does. In normal queue creation, the driver
> gets an additional reference on the queue's underlying buffers
> that lasts until the queue is destroyed; this prevents the
> queue's buffers from being removed from underneath it.
>
> Acquire them, but don't get the svm bo. SVM isn't yet fully
> restored by this point in CRIU and so there's no svm range to get.
> This will be addressed in the next patch.
>
> v2: Don't use checkpoint ctl_stack_size
>
> Signed-off-by: David Francis <David.Francis@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c               | 2 +-
>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h                  | 2 +-
>   drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c | 8 ++++++++
>   drivers/gpu/drm/amd/amdkfd/kfd_queue.c                 | 8 +++++++-
>   4 files changed, 17 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/a=
md/amdkfd/kfd_chardev.c
> index 6c710e4a5220c..d8233337b8d5e 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -433,7 +433,7 @@ static int kfd_ioctl_create_queue(struct file *filep,=
 struct kfd_process *p,
>               goto err_bind_process;
>       }
>
> -     err =3D kfd_queue_acquire_buffers(pdd, &q_properties);
> +     err =3D kfd_queue_acquire_buffers(pdd, &q_properties, false);
>       if (err) {
>               pr_debug("failed to acquire user queue buffers\n");
>               goto err_acquire_queue_buf;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/=
amdkfd/kfd_priv.h
> index f0ce5fc4a138f..eb4d35a42e917 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -1381,7 +1381,7 @@ void print_queue(struct queue *q);
>   int kfd_queue_buffer_get(struct amdgpu_vm *vm, void __user *addr, struc=
t amdgpu_bo **pbo,
>                        u64 expected_size);
>   void kfd_queue_buffer_put(struct amdgpu_bo **bo);
> -int kfd_queue_acquire_buffers(struct kfd_process_device *pdd, struct que=
ue_properties *properties);
> +int kfd_queue_acquire_buffers(struct kfd_process_device *pdd, struct que=
ue_properties *properties, bool is_criu);
>   int kfd_queue_release_buffers(struct kfd_process_device *pdd, struct qu=
eue_properties *properties);
>   void kfd_queue_unref_bo_va(struct amdgpu_vm *vm, struct amdgpu_bo **bo)=
;
>   int kfd_queue_unref_bo_vas(struct kfd_process_device *pdd,
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/dri=
vers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> index 4c4a3a8587f46..6e19be9e89f57 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> @@ -1095,9 +1095,17 @@ int kfd_criu_restore_queue(struct kfd_process *p,
>
>       print_queue_properties(&qp);
>
> +     ret =3D kfd_queue_acquire_buffers(pdd, &qp, true);
> +     if (ret) {
> +             pr_err("Failed to acquire user queue buffers err:%d\n", ret=
);
> +             goto exit;
> +     }
> +
>       ret =3D pqm_create_queue(&p->pqm, pdd->dev, &qp, &queue_id, q_data,=
 mqd, ctl_stack, NULL);
>       if (ret) {
>               pr_err("Failed to create new queue err:%d\n", ret);
> +             kfd_queue_unref_bo_vas(pdd, &qp);
> +             kfd_queue_release_buffers(pdd, &qp);

I think kfd_queue_release_buffers also needs another parameter to tell
it not to handle SVM. Otherwise it will call kfd_queue_buffer_svm_put
and try to decrement queue refcounts in pranges that weren't incremented.

Regards,
   Felix


>               goto exit;
>       }
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c b/drivers/gpu/drm/amd=
/amdkfd/kfd_queue.c
> index 6010a5d7a7eb9..18d24ddb455eb 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
> @@ -239,7 +239,7 @@ static void kfd_queue_put_bos(struct queue_properties=
 *properties)
>       kfd_queue_buffer_put(&properties->cwsr_bo);
>   }
>
> -int kfd_queue_acquire_buffers(struct kfd_process_device *pdd, struct que=
ue_properties *properties)
> +int kfd_queue_acquire_buffers(struct kfd_process_device *pdd, struct que=
ue_properties *properties, bool is_criu)
>   {
>       struct kfd_topology_device *topo_dev;
>       u64 expected_queue_size;
> @@ -334,6 +334,12 @@ int kfd_queue_acquire_buffers(struct kfd_process_dev=
ice *pdd, struct queue_prope
>
>       amdgpu_bo_unreserve(vm->root.bo);
>
> +     /* CRIU svm buffers are restored at a later stage than queues. They=
'll be in
> +      * before the queue is actually used, so no risk here
> +      */
> +     if (is_criu)
> +             return 0;
> +
>       err =3D kfd_queue_buffer_svm_get(pdd, properties->ctx_save_restore_=
area_address,
>                                      total_cwsr_size);
>       if (err)
