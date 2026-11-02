Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931B4606A583
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Nov 2026 14:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=pDhIa4Cu
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1768510EF41;
	Mon,  2 Nov 2026 14:39:36 +0000 (UTC)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012006.outbound.protection.outlook.com [52.101.48.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 47CDB10EF42
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Nov 2026 14:39:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XdXqH8DQ5niSywXOvJChfA2gAinHJYbQWlYnjpS0iH4vw6KoKneVgz3JDpuOazzlq5wZJ9cqYJp0mSkAxeDE9/dAuVfcG2Gvkdq3mpYiYuKRVMUEKi+tjtRUmzhJ7kh6RQEJRY4KuI3oaVPC3FgOdDbA/hUctQav7ZQpmCsL0T2u/F0adszABc0meQg/+9W0QbuezAkLcZbijg19gp0B0Va4ElTgHZRKUkJtbzccIWVN2tRcPstVMi1urRZdUOJzeY3lmp4LXzDfI1qvtHn0KsZTNQgVVus/DpxVDVLhAI5QUh+xAN9f7wVQJFMpGwlAUXdm2HhCeVVcj9qtL34lwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ISyS6Ga3LUrSqYAxz6PG5jep/rnmszYigrIK7mJn7Ug=;
 b=yCzh4YGkHDe6ttUzSDkDHCityuDl9dOPtIG3JXa0FQL7dYE7xC6jAXOWO0ipI53RCN4zz0JHRhfxcfwHqzKWpm5Jj7VYyne/S3VqFvWngBkJ7mC2ME+adMhfSS+tO1GY7zQfSEgwRacr1yysaQLFSXJ0HNFH18Wa1e1AJ6/HoHuRgK7yA7ZiuYCn5JYWnqu4dcl5jrvNex4it87h/2BX3e2eAHbu/qNsHtPUPqIvu4w4ZJSmUwp2J8K6mxTzwVgBSsoTddlQSwkeJ/PJb+oA6UxuCuz5A7s2M5f0FPdi0q0XolEtStq/1g6KzMz9kPXGqfCRY/aryL/a523bi5mDZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ISyS6Ga3LUrSqYAxz6PG5jep/rnmszYigrIK7mJn7Ug=;
 b=pDhIa4CumFF8ZCf92OyHyz1lPwj6S/dOwpgyyFyZCjcHc5JyCT/FYyREMA/kcQl0jii3BYzlnSJYxWBlm9aX/tIaT9aCqLg6Zbw3BRzfV6zzfZMhX+9ZUsOuVfB/welo/QMHeXk9qMbeexhNgCeX6T2y9hEMp0htgDcaByl7P9s=
Received: from CHAPR12MB999247.namprd12.prod.outlook.com
 (2603:10b6:610:2ff::7) by SA5PPFCAFD069B8.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8e1) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 14:39:26 +0000
Received: from CHAPR12MB999247.namprd12.prod.outlook.com
 ([fe80::d727:e84d:1883:b74]) by CHAPR12MB999247.namprd12.prod.outlook.com
 ([fe80::d727:e84d:1883:b74%6]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 14:39:25 +0000
From: "Francis, David" <David.Francis@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Koenig, Christian" <Christian.Koenig@amd.com>
Subject: Re: [PATCH v2 1/3] drm/amdkfd: Acquire buffers in CRIU queue restore
 (again)
Thread-Topic: [PATCH v2 1/3] drm/amdkfd: Acquire buffers in CRIU queue restore
 (again)
Thread-Index: AQHdaHfUSRAEsvFx50uWjyFlJSUj9rcWlrWAgARHa4M=
Date: Mon, 2 Nov 2026 14:39:25 +0000
Message-ID: <CHAPR12MB99924757FCFC078459155A971AEF6A2@CHAPR12MB999247.namprd12.prod.outlook.com>
References: <20261030140550.2524662-1-David.Francis@amd.com>
 <20261030140550.2524662-2-David.Francis@amd.com>
 <bdbac10b-f1c5-4e3c-9e1d-7694b649c448@amd.com>
In-Reply-To: <bdbac10b-f1c5-4e3c-9e1d-7694b649c448@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-11-02T14:39:25.443Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD
 General; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=1;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard; 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CHAPR12MB999247:EE_|SA5PPFCAFD069B8:EE_
x-ms-office365-filtering-correlation-id: dbdce71b-7268-4d97-bb3f-08df38ef17df
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|10067099003|18002099003|22082099003|38070700021|56012099006|4143699003|11063799006|261026121527099003|261022105027099003|261026140227099003|261009223027099003|261028144727099003|261021121427099003|261021123027099003;
x-microsoft-antispam-message-info: GShIKJn2Ln/neyrvHXhULlRxZUTM3OKq8Bcem0UPcZSs4i0Bs6d+xzsgswGaNgdN8hk3v3zSUXEqctj2MhuKN3aK4g4hVNsKFuJi5IeJueNkQRglTqGDSqZ51Ev3i0IaWKr/EnSuP9U+iV9LTXf92C0X+HZkwTA3fkJiNaMzNdtQBgd5unQcIm6n0sbRIKCVplYublwwF5JT1s1sM1g6JtspfXce15usvj7S3tvl97E+t1aet033bejS5eoDz+yGc0yWPSkV3jDviPDvQh0owVmnl9nRN5tqByf8RxWECRq5/6IARaIuIzourHZugY4QE1B84FbCqR8Fm6m4QAFqmvEOMTwK0ma9i+leZu/kfCon3pulKGWYTla6sNK3sHDc+ukL3ogu8Ue5YKwsnNLHTS3q9ICAnEg8dQ6rnDrYfG2sdv5VZCLnZ2TsAvL0oQPN2N5ovjl/yIlu3zaLgVQAl5eggm1esRP5TuMkPCNl3POW9XDz2EBAH4pBTrpc61EtukcrYR1kDFUbCKxfBahiSBGVbIEOxlqDciAou/pKO2dhYhEzxhzmheYPLUlFXWrOrIxR+SMG4LjcJz5+q0JQ6qgZaRqRwREiEy15zTAI/BbDtNmcLBtwrdyiOtfpWQar7mUHpfchmGtd9Q5UTdaUNz55SKiXH+dj8oah5T2ZlPGP+ZExafKJr3OPS4IgBnSDU9eRgSovLaHX4rfW5oWzoPU7QA1loHmo8el7P3UoV7E=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CHAPR12MB999247.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(10067099003)(18002099003)(22082099003)(38070700021)(56012099006)(4143699003)(11063799006)(261026121527099003)(261022105027099003)(261026140227099003)(261009223027099003)(261028144727099003)(261021121427099003)(261021123027099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?iMun2OyvgCmieLln6Rl+1hyQ3nA6a05Oe1RSC3uAgKut/lPV3hPAljc0UjFz?=
 =?us-ascii?Q?KTNuc2B46MheGX6hIn9y6SfkyqjFYdGpxcgETR/6/Bkd7qzqS9WzxY9kwQ+j?=
 =?us-ascii?Q?TfQEb+BEw8EtGo8WLZMpLVUEB1RgoRo36Km4nyub1Zi325+5Dy5FrbIyPsOB?=
 =?us-ascii?Q?qYS4yQa7IxVGLdvCo0ftekd0IxOBVRwpTYEeVVc35xINgRfBdVQYXWxJdwjQ?=
 =?us-ascii?Q?3vc55bfztlYHLz6sMT81t6iLMzVdlsHLv63+UHZZdX/OHY7ztnw5AF4PZWkp?=
 =?us-ascii?Q?ydHJNwzSZnNozAim4IcFFCW1ws7QO7pnVNNSiouatbHmtUlOC9qbLIuqV2d9?=
 =?us-ascii?Q?2AopeWE/ygzshmF8Pqz15PCeKwF0F3fGOov1nrjIFMvmivRtp7bRSPrUI/jb?=
 =?us-ascii?Q?N5xxPsM3fi16Bxr/vT1n2Jqoufir1CqyDRhdNCHW8EOWt0nRS/w3AyhNVQTC?=
 =?us-ascii?Q?VlvxuS2eXla0cDxxdmWfm5tP5pdQWnp64pBuWYc0mM3NBG6ai3akaVf1Wibc?=
 =?us-ascii?Q?LmjqEqOGENoaWOYotWOjUSuwLHO4uzMZ5dESfdp0OH95jc/Sntvdc/2MMie3?=
 =?us-ascii?Q?9ZPbj0HSv7Frj8kaDSaa9AW7o2/RsbXIzAOYn6nQ9wykfO0NS3QCQXWNOsct?=
 =?us-ascii?Q?ubrDt6+5CXpRSZB2Fdl7YMBrK1z42WzCTEozwqN6qxCf69Ph/wrLqNFh6Xbb?=
 =?us-ascii?Q?g6tUaHmeD2x4Msb0kMJH8TwQuxKWQKtAh9IiPSSCwI1aveD5TRSH8WGfHw1Y?=
 =?us-ascii?Q?VVjQ/m1wOzT2Kov4YYEkp9m73i1uZHkEbxdRChXSd4U6E4OvDRU1DeuSVjrR?=
 =?us-ascii?Q?WNDloP35vzDSA3tPds8GrrL0Ej6rsfd7RqlTLMAXYVyMNPCdR5fSeJVp077Y?=
 =?us-ascii?Q?96HGmshg/K/TMgHR4WK5JMU52K8pifN7aa7PqbGWs0KzwzZHsKeBAuwYgmCR?=
 =?us-ascii?Q?5EDOeI1L+kfvA+P2clb2z6TiGRnUJBxa/QgrHpKTOcliXLHjh1MAuK35W+te?=
 =?us-ascii?Q?AZyj2PGLIh1iTbYTiW9JjD9LSjs/CHKVUyzf1+eZJuB6zLfYjCFYU2mb/tKJ?=
 =?us-ascii?Q?UlfsW7UKVc5eX0rwHfospgQa6wXqMQSJFWaqoNmC7mxRpVqZT6rWc4PJc57R?=
 =?us-ascii?Q?bpqsJ+UYvRI5na/u6usFHD/wnwAcbuZtejJITIAtaF5K1VqyJ8Ma/PLWqP9y?=
 =?us-ascii?Q?Yhvs/wAPYWEsnEH1MSpfY5ju91dodVLV2W18cokRObbucoSyfumZ8+CZLVbG?=
 =?us-ascii?Q?4oCZ1W26/zf19hf6HlaWUXTYFZ5R9UzrQKX0go3WaXHqwXlwSw1XZ54EFpNy?=
 =?us-ascii?Q?pjQC/WiuI9OW5PU8ndc/EvnMaTN+WPbn4O+saiG4WFfMJnonE6Cdu9X+Fm+p?=
 =?us-ascii?Q?rnepGMnWCoWGOsdoQhp8dDbiBHJn7HHQ3d0F32S9nQbS0X8txTge18wp0tQN?=
 =?us-ascii?Q?0jVYBK7ZGROKE8bdWY+zIDSQQQaFDD8mkdTtayvXt5fO46aA6TW4ISkpqMI+?=
 =?us-ascii?Q?igvn1MsFs9e6QYo7aDNQCgA0CLPlyT0yLkFBEHbWu48Ye/w5lbjIR1UcyZzV?=
 =?us-ascii?Q?IkKzZhTlHsbqYpJVoRSPZAQ3Q8tsejlT/vD33umjwr9WmCyCyueOciUqcHXW?=
 =?us-ascii?Q?30oLzzTL7EWvVRXxj+R8W9uI3h/tLIYlPmAi3KN16a/KfLg7UqYpqAyRlvQ2?=
 =?us-ascii?Q?WHpG8lHz7vXm37+5neLEEgpzGFT6EfNESyUP93nR0vxhSwam?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CHAPR12MB999247.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbdce71b-7268-4d97-bb3f-08df38ef17df
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2026 14:39:25.8539 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AtPIci5yloOVQILKQmMcuCucswSNjjJ2xU6pR7X0FBhmabkpF22CCK1r5+jNJd8H
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFCAFD069B8
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

>> +
>> +     if (q_data->type =3D=3D KFD_QUEUE_TYPE_COMPUTE) {
>> +             if (q_data->ctl_stack_size)
>> +                     qp->ctl_stack_size =3D q_data->ctl_stack_size / nu=
m_xcc;
>> +             else if (topo_dev)
>> +                     qp->ctl_stack_size =3D topo_dev->node_props.ctl_st=
ack_size;
>
>I'm curious what this case is needed for. In what circumstances would a
>CRIU checkpoint contain 0 ctl_stack_size? And is that's the case,
>wouldn't that break restore anyway?
>

A lot of mqd managers don't set mqd->get_checkpoint_info,
so the ctl_stack_size ends up as 0.

kfd_queue_acquire_buffers requires the ctl_stack_size to be equal to
topo_dev->node_props.ctl_stack_size anyways, so I think it
makes sense to default to that value if the input is 0.

David Francis

________________________________________
From: Kuehling, Felix <Felix.Kuehling@amd.com>
Sent: Friday, October 30, 2026 5:15 PM
To: Francis, David; amd-gfx@lists.freedesktop.org
Cc: Koenig, Christian
Subject: Re: [PATCH v2 1/3] drm/amdkfd: Acquire buffers in CRIU queue resto=
re (again)

On 2026-10-30 10:05, David Francis wrote:
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
> Signed-off-by: David Francis <David.Francis@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      |  2 +-
>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  2 +-
>   .../amd/amdkfd/kfd_process_queue_manager.c    | 34 +++++++++++++++++--
>   drivers/gpu/drm/amd/amdkfd/kfd_queue.c        |  8 ++++-
>   4 files changed, 41 insertions(+), 5 deletions(-)
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
> index 4c4a3a8587f46..509529af2dc3c 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> @@ -985,8 +985,14 @@ int kfd_criu_checkpoint_queues(struct kfd_process *p=
,
>   }
>
>   static void set_queue_properties_from_criu(struct queue_properties *qp,
> -                                       struct kfd_criu_queue_priv_data *=
q_data)
> +                                        struct kfd_criu_queue_priv_data =
*q_data,
> +                                        struct kfd_process_device *pdd)
>   {
> +     struct kfd_topology_device *topo_dev;
> +     uint32_t num_xcc =3D NUM_XCC(pdd->dev->xcc_mask);
> +
> +     topo_dev =3D kfd_topology_device_by_id(pdd->dev->id);
> +
>       qp->is_interop =3D false;
>       qp->queue_percent =3D q_data->q_percent;
>       qp->priority =3D q_data->priority;
> @@ -998,6 +1004,16 @@ static void set_queue_properties_from_criu(struct q=
ueue_properties *qp,
>       qp->eop_ring_buffer_size =3D q_data->eop_ring_buffer_size;
>       qp->ctx_save_restore_area_address =3D q_data->ctx_save_restore_area=
_address;
>       qp->ctx_save_restore_area_size =3D q_data->ctx_save_restore_area_si=
ze;
> +
> +     if (q_data->type =3D=3D KFD_QUEUE_TYPE_COMPUTE) {
> +             if (q_data->ctl_stack_size)
> +                     qp->ctl_stack_size =3D q_data->ctl_stack_size / num=
_xcc;
> +             else if (topo_dev)
> +                     qp->ctl_stack_size =3D topo_dev->node_props.ctl_sta=
ck_size;

I'm curious what this case is needed for. In what circumstances would a
CRIU checkpoint contain 0 ctl_stack_size? And is that's the case,
wouldn't that break restore anyway?

Other than that, this patch looks good to me.

Regards,
   Felix


> +     } else {
> +             qp->ctl_stack_size =3D q_data->ctl_stack_size;
> +     }
> +
>       qp->type =3D q_data->type;
>       qp->format =3D q_data->format;
>   }
> @@ -1047,7 +1063,13 @@ int kfd_criu_restore_queue(struct kfd_process *p,
>       }
>
>       memset(&qp, 0, sizeof(qp));
> -     set_queue_properties_from_criu(&qp, q_data);
> +     set_queue_properties_from_criu(&qp, q_data, pdd);
> +
> +     if (q_data->type =3D=3D KFD_QUEUE_TYPE_COMPUTE && !qp.ctl_stack_siz=
e) {
> +             pr_err("Failed to determine ctl_stack_size for compute queu=
e\n");
> +             ret =3D -EINVAL;
> +             goto exit;
> +     }
>
>       /* Per-XCC control stack size from topology, as create-queue requir=
es */
>       if (qp.type =3D=3D KFD_QUEUE_TYPE_COMPUTE && pdd->dev->kfd->cwsr_en=
abled) {
> @@ -1095,9 +1117,17 @@ int kfd_criu_restore_queue(struct kfd_process *p,
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
