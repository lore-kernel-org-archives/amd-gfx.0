Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE7E3ECAAD3
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Sep 2022 17:58:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 26AFF10E0DE;
	Thu,  1 Sep 2022 17:58:40 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2078.outbound.protection.outlook.com [40.107.93.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 381EC10E0DE
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Sep 2022 17:58:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZDdoa7Y0pjbfvZhzWX9gACM/5g1x6CDLuB5lOCPZV3st/q7qfUe1j6oKHn8nCQWCLGaTXD3jvE7ltz29GQ6F8HsMoy24jYY7oH8MtC7iFHLSSRvkhOBjg/LZNcwXv0AAuwUBVwH5dVTR8d1xNbICUl74ygzyjyU3NmBAV2SpxF3NNJcOyGCiCqRV8enfjYHrF+pdxLNmm6SkpTMfpIZf0cjJr7y9j4M/QX2hAVdy69KQU3+99vUgDpcmnr2iXODFQPZ/DcknO/fzREuEFFoNrUFeF+omS3qSmjnlFgbLbIp8j7yHNzHQNRe2ejbyA91FJ+QpkVuUw50iakl9cScUuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W8rJSDpdr5BbYGiyXOm8LTNyChMey+GCgynOeCHvJVs=;
 b=mdxFDZshjtWYeUT7Gf0YERUi8/HNFroe5HBpkP08G2Ct6kGlXnhvaaMyzMy3UT/1oaJFhHLs+NaNmtLDUQNSr2HupWxopWcVcbyRWUFOxuuVtF53wZfTXIzttfnqalfdVWdA9aG8/PQQZNs5cLYoX4IJy31ZvqrSY/ADx7R3hx14u+dC2pw5GOASUx226ZoYGrQ4C+x6AM1RvzWiC+BCPQeM8DSVmg69MDBGdnq/S5cBzJUlM1hNACpF2tV6+pjbzPAKWyFlJgoVgCNrG7+Az9ebKUtmhQaKVSYFjn3zxzfl9K29uLibrTvdDspJro0YmIwWO+FhJ6w7K1Ut2DjsXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W8rJSDpdr5BbYGiyXOm8LTNyChMey+GCgynOeCHvJVs=;
 b=egSELr2jNCapo2olpLHXaAjyI/KRSkfTbMHmBsHbfSXUg5btaZT80r75dfCiHB/DcqisdCyg+Es34CvgvcmH+BKXUBbLuwFzk3Vqxlp3svjc5rTWHb4Ih7qOVpKFWajtJmEKY1WQf0Hmvn5OUgcnCyGcRWCIT9NbmwZkNcCpT0c=
Received: from DS7PR12MB5933.namprd12.prod.outlook.com (2603:10b6:8:7c::14) by
 IA1PR12MB6604.namprd12.prod.outlook.com (2603:10b6:208:3a0::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5588.10; Thu, 1 Sep 2022 17:58:33 +0000
Received: from DS7PR12MB5933.namprd12.prod.outlook.com
 ([fe80::3430:22a2:388:3dfa]) by DS7PR12MB5933.namprd12.prod.outlook.com
 ([fe80::3430:22a2:388:3dfa%4]) with mapi id 15.20.5588.010; Thu, 1 Sep 2022
 17:58:33 +0000
From: "Bhardwaj, Rajneesh" <Rajneesh.Bhardwaj@amd.com>
To: "Russell, Kent" <Kent.Russell@amd.com>, "Kuehling, Felix"
 <Felix.Kuehling@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdkfd: Allocate doorbells only when needed
Thread-Topic: [PATCH] drm/amdkfd: Allocate doorbells only when needed
Thread-Index: AQHYp2rA2ThMaxhSYE2P9eCVvnAL6K27EuoAgAFv44CADoacgA==
Date: Thu, 1 Sep 2022 17:58:33 +0000
Message-ID: <DS7PR12MB5933CD41FC16BC1E6776FD92FE7B9@DS7PR12MB5933.namprd12.prod.outlook.com>
References: <20220803185543.36786-1-Felix.Kuehling@amd.com>
 <DM5PR12MB13080A78CC402FE1079EDB7285719@DM5PR12MB1308.namprd12.prod.outlook.com>
 <DM5PR12MB1308D8067687E6FD42B0D37B85709@DM5PR12MB1308.namprd12.prod.outlook.com>
In-Reply-To: <DM5PR12MB1308D8067687E6FD42B0D37B85709@DM5PR12MB1308.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-09-01T17:58:31Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=ab840810-e5e5-4b4f-9762-6293c1e3ac9a;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 01e4ca96-0173-4c73-f898-08da8c4395de
x-ms-traffictypediagnostic: IA1PR12MB6604:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ln9DCnueHuK9VxKcmP0H0NHQDOPPoDTqpVSpCuav+Y4tyQb/HgT00xzto44vqFDoYq3IIoHDRkNNRLqVmPPGI2ialoIrymG2N6Ue7MeoOQo/QrsYG9HWB0SwAPDqR9bdSzhxSHJnsbXZsgzeI2TxrjEv5wc8XxKMzUWhbonol7piUqav/50hXMDIJmV5+iqUE4i0BhqXby8t7JkjwdUfkT6tS8eYs/sgsprKc75jmVpJUlCVVqEBxjWcull2lXAaK5Gk+XslZtKOYpLvyrdpASQ3H5U8KNXtSUO4f6gMd6DBRfaIsTkOt4fN9CJE8xlFbfU2U3Vz6eSWEVGOi32PF7EzhZHrqbWle/Qud2tT6GCQgkLSzVYJsxDp1wc9r4nUACQIpQOUgEWULZCI3BvCApSUfDf4845rAtkGtn5mDntt2VslKuoi6FUssGaT+ouypDetwI5InxDOtTEOwCuhlJkIPFhlMkO9xG65pBGarcrrpBsKOrnuRMRuX2Ge0JQKbE7jJmzJrV4Hc8UqaVEhu/N/YbPnOkRVMlRZlcnFeDOgvJz7DogXWtiN+sJAAobKHG06COV1KlF+QaTvxb4ppoqxRGR62PGPvNHIbETu88x2F3MSnuZLaRRvRE4/jTbR4rtr8a6dKw4U5eJqHNx6B6b749Yb00C3UQJUoZsyzxCVGQ1+XKr7PtgGmngeyPEe9xk2ex1UxFVHA9jWkLHUrbPb7Y7DbUiR6s9zgaLQ75I6OnB+iYU9Fgwhue/2dtoOJBVbbg8yDH6h/4bxKj21WQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB5933.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(39860400002)(366004)(376002)(346002)(136003)(66446008)(66946007)(66556008)(66476007)(76116006)(33656002)(64756008)(110136005)(8676002)(86362001)(41300700001)(55016003)(186003)(71200400001)(316002)(8936002)(38070700005)(478600001)(52536014)(83380400001)(5660300002)(53546011)(9686003)(38100700002)(6506007)(7696005)(26005)(122000001)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jvHG+sLR/ErmFv6MBEoeBdXMctZ1WgAACjOGShUhxdykmnhi+4xbeVP2wihl?=
 =?us-ascii?Q?sEfOs07/an8Z7+nbgv61vA7PtLlbwgn3JHFJhkT8h4dng/cX+ppBNMiTnWqX?=
 =?us-ascii?Q?OX75c4eXcg6G2bLPZ9cuN+5OmLbR6VFipugCzx7qdhWP116qe3xMsJXoIXUS?=
 =?us-ascii?Q?pSZV7B+EfduoR9Z4eKaeOz4AE3M1d94hOV2T5YSWrPCyKXjEKblhKLNRJCgV?=
 =?us-ascii?Q?1qROlEmsmrMRdQ6rxRh2//OLCSq6UazqkCd7YpdmdDvR3o93NM2uFAFUcbK0?=
 =?us-ascii?Q?RDXTGElf48Lpi+ecpU/ybF5TVamUWteQWGov8SFxvoU8PeKgWiXUhSbE6hSL?=
 =?us-ascii?Q?uwIuGtfrtKajRtKbdVD7wRY57rtrHfWXBLG1kKXyw5fS7jOij0WCnP2CTE8f?=
 =?us-ascii?Q?XCa7wxj0A1bhp0ntIvaEgUlnfj7DWA3pWgYgEMt4+wG1BNjA3u+iMnmICFwz?=
 =?us-ascii?Q?sARpw4f0DE3TYf04R3OsqD6Jafl3HFr8k9if/rSv5Zc2XA+LHxgmo0xM68tp?=
 =?us-ascii?Q?yQPHHHCgwASAJWLQQuceunUlx5yb8ZfRFQyI5ohAQFaWJXRuoBW4JHi6FhAW?=
 =?us-ascii?Q?We+TX0oesAh2x+KVaCGdyWgo5fv6oPmj+XKeykd+T5tjgCSXiyw7b3sRdh5c?=
 =?us-ascii?Q?4r2mFnzsS6Up3R1l/UHow6MbMzvILnTpv5ePEwOGckR+1Vx89wDdfIw1SKQL?=
 =?us-ascii?Q?K0IKUA6vEobLjDYkI7k2WJAiA0WaGH8F3O1h9FhxDFEoAVnQpq7rQfN5I6QR?=
 =?us-ascii?Q?B5LNCu5a4JsIuruxG9/QjH7YIr0ohwHhEfM3y8DtAyl28bvDJ4GhHthbFtEg?=
 =?us-ascii?Q?v6QXqYol3g9RlWTGoda6D4TZ8CtjfDBLhoGte4xgqGb7deuMHCux69i3MAyL?=
 =?us-ascii?Q?42AI9XlGzkK32SqWq1gl0+Od857fuK9aZLtC9Rf1h6yfc23DLip1x3c4DuMG?=
 =?us-ascii?Q?gTQ+oNrfxtaFGLW/vVvfTKYHxilX6i2qfWM7N03wa6h4FjYBtGW4oxbHryNY?=
 =?us-ascii?Q?Pgu5579t00IJu6zreXMf/QCj9z45s+zY1lIsBPIaXI7sz6aby1WACVBRoCnj?=
 =?us-ascii?Q?/rYJHWYSh9Lyv9oQ+PFXUqQFVt6UZ8c2NUpzjyLRZCxh9KsE1Jgw81kheYrv?=
 =?us-ascii?Q?2Lj4w14jJ3kwPaWZP/NkdQjFPJ1l8Cy4GXCi8icKJztl4k0KJny2NqbpHK2t?=
 =?us-ascii?Q?wu3ZUTQKf5W1/J+571MD7A7dLM4ZKamUuf48v87M40Tw9PN08rWrhe0KAiMv?=
 =?us-ascii?Q?btduAnUzBZ9b7M1AlUqyox0FuU7TE3VBcJ7yfXNj/KIgIf0ip/GFu8T0fie6?=
 =?us-ascii?Q?BZp7d5HdlpDVXd9Nii8v5dtR4f7wjgsmNbqnEdpAIwackjg9eBxLmPHQA9XW?=
 =?us-ascii?Q?B7AlKZUSPKu/e3Z5IGZXcyrWk/M5qYwx8qo56xf7EJlLZLgOITzC+mCHa1Cj?=
 =?us-ascii?Q?InYW4eOfjLS9rVW4f9Y+gxUOePu6+v527AfdKYDoR9ncWSt0J6qoscVUA8UY?=
 =?us-ascii?Q?pECeXSEiyRzIZmcU6CYcrHqEA/LH7/uBzK1niieptBY4XFGnBPS7XkUzSv7L?=
 =?us-ascii?Q?dXIwtExDt5Din+vB0Kw=3D?=
Content-Type: multipart/alternative;
 boundary="_000_DS7PR12MB5933CD41FC16BC1E6776FD92FE7B9DS7PR12MB5933namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5933.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01e4ca96-0173-4c73-f898-08da8c4395de
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2022 17:58:33.1305 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xOAib/WvAh90u1fpRPjcRa+o8bTOYgmpz7AtssFAzDPyQhVhU8kaNmadOmQlUbGE5btggS/0WzAd9BxHajg2WA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6604
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

--_000_DS7PR12MB5933CD41FC16BC1E6776FD92FE7B9DS7PR12MB5933namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

This seems to have broken CRIU restore. After I revert this, I can get CRIU=
 restore working.

From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Russell,=
 Kent
Sent: Tuesday, August 23, 2022 8:07 AM
To: Kuehling, Felix <Felix.Kuehling@amd.com>; amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH] drm/amdkfd: Allocate doorbells only when needed

No one else seems to have any thoughts on it, so Reviewed-by: Kent Russell =
<kent.Russell@amd.com<mailto:kent.Russell@amd.com>>

 Kent

________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org<mailto:amd-gfx-bounces=
@lists.freedesktop.org>> on behalf of Russell, Kent <Kent.Russell@amd.com<m=
ailto:Kent.Russell@amd.com>>
Sent: Monday, August 22, 2022 10:10 AM
To: Kuehling, Felix <Felix.Kuehling@amd.com<mailto:Felix.Kuehling@amd.com>>=
; amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org> <amd-=
gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>>
Subject: RE: [PATCH] drm/amdkfd: Allocate doorbells only when needed

[AMD Official Use Only - General]

I can throw an Acked-by: Kent Russell <kent.russell@amd.com<mailto:kent.rus=
sell@amd.com>> since we don't have an RB yet.

 Kent

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org<mailto:amd-gfx-bounc=
es@lists.freedesktop.org>> On Behalf Of Felix
> Kuehling
> Sent: Wednesday, August 3, 2022 2:56 PM
> To: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
> Subject: [PATCH] drm/amdkfd: Allocate doorbells only when needed
>
> Only allocate doorbells when the first queue is created on a GPU or the
> doorbells need to be mapped into CPU or GPU virtual address space. This
> avoids allocating doorbells unnecessarily and can allow more processes
> to use KFD on multi-GPU systems.
>
> Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com<mailto:Felix.Kuehli=
ng@amd.com>>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_chardev.c  | 13 +++++++++++++
>  drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c |  9 +++++++++
>  drivers/gpu/drm/amd/amdkfd/kfd_process.c  |  5 -----
>  3 files changed, 22 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index 2b3d8bc8f0aa..907f4711abce 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -327,6 +327,12 @@ static int kfd_ioctl_create_queue(struct file *filep=
,
> struct kfd_process *p,
>                goto err_bind_process;
>        }
>
> +     if (!pdd->doorbell_index &&
> +         kfd_alloc_process_doorbells(dev, &pdd->doorbell_index) < 0) {
> +             err =3D -ENOMEM;
> +             goto err_alloc_doorbells;
> +     }
> +
>        /* Starting with GFX11, wptr BOs must be mapped to GART for MES to
> determine work
>         * on unmapped queues for usermode queue oversubscription (no
> aggregated doorbell)
>         */
> @@ -404,6 +410,7 @@ static int kfd_ioctl_create_queue(struct file *filep,=
 struct
> kfd_process *p,
>        if (wptr_bo)
>                amdgpu_amdkfd_free_gtt_mem(dev->adev, wptr_bo);
>  err_wptr_map_gart:
> +err_alloc_doorbells:
>  err_bind_process:
>  err_pdd:
>        mutex_unlock(&p->mutex);
> @@ -1092,6 +1099,10 @@ static int kfd_ioctl_alloc_memory_of_gpu(struct fi=
le
> *filep,
>                        goto err_unlock;
>                }
>                offset =3D kfd_get_process_doorbells(pdd);
> +             if (!offset) {
> +                     err =3D -ENOMEM;
> +                     goto err_unlock;
> +             }
>        } else if (flags & KFD_IOC_ALLOC_MEM_FLAGS_MMIO_REMAP) {
>                if (args->size !=3D PAGE_SIZE) {
>                        err =3D -EINVAL;
> @@ -2173,6 +2184,8 @@ static int criu_restore_memory_of_gpu(struct
> kfd_process_device *pdd,
>                        return -EINVAL;
>
>                offset =3D kfd_get_process_doorbells(pdd);
> +             if (!offset)
> +                     return -ENOMEM;

Looks like this is causing CRIU restore failure.

>        } else if (bo_bucket->alloc_flags &
> KFD_IOC_ALLOC_MEM_FLAGS_MMIO_REMAP) {
>                /* MMIO BOs need remapped bus address */
>                if (bo_bucket->size !=3D PAGE_SIZE) {
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
> index cb3d2ccc5100..b33798f89ef0 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
> @@ -157,6 +157,8 @@ int kfd_doorbell_mmap(struct kfd_dev *dev, struct
> kfd_process *process,
>
>        /* Calculate physical address of doorbell */
>        address =3D kfd_get_process_doorbells(pdd);
> +     if (!address)
> +             return -ENOMEM;
>        vma->vm_flags |=3D VM_IO | VM_DONTCOPY | VM_DONTEXPAND |
> VM_NORESERVE |
>                                VM_DONTDUMP | VM_PFNMAP;
>
> @@ -275,6 +277,13 @@ uint64_t kfd_get_number_elems(struct kfd_dev *kfd)
>
>  phys_addr_t kfd_get_process_doorbells(struct kfd_process_device *pdd)
>  {
> +     if (!pdd->doorbell_index) {
> +             int r =3D kfd_alloc_process_doorbells(pdd->dev,
> +                                                 &pdd->doorbell_index);
> +             if (r)
> +                     return 0;
> +     }
> +
>        return pdd->dev->doorbell_base +
>                pdd->doorbell_index * kfd_doorbell_process_slice(pdd->dev)=
;
>  }
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> index 6c83a519b3a1..951b63677248 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -1499,11 +1499,6 @@ struct kfd_process_device
> *kfd_create_process_device_data(struct kfd_dev *dev,
>        if (!pdd)
>                return NULL;
>
> -     if (kfd_alloc_process_doorbells(dev, &pdd->doorbell_index) < 0) {
> -             pr_err("Failed to alloc doorbell for pdd\n");
> -             goto err_free_pdd;
> -     }
> -
>        if (init_doorbell_bitmap(&pdd->qpd, dev)) {
>                pr_err("Failed to init doorbell for process\n");
>                goto err_free_pdd;
> --
> 2.32.0

--_000_DS7PR12MB5933CD41FC16BC1E6776FD92FE7B9DS7PR12MB5933namp_
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
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
span.EmailStyle18
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
p.msipheaderdf3d92d6, li.msipheaderdf3d92d6, div.msipheaderdf3d92d6
	{mso-style-name:msipheaderdf3d92d6;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word">
<div class=3D"WordSection1">
<p class=3D"msipheaderdf3d92d6" style=3D"margin:0in"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:blue">[AMD Officia=
l Use Only - General]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">This seems to have broken CRIU restore. After I reve=
rt this, I can get CRIU restore working.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> amd-gfx &lt;amd-gfx-bounces@lists.freed=
esktop.org&gt;
<b>On Behalf Of </b>Russell, Kent<br>
<b>Sent:</b> Tuesday, August 23, 2022 8:07 AM<br>
<b>To:</b> Kuehling, Felix &lt;Felix.Kuehling@amd.com&gt;; amd-gfx@lists.fr=
eedesktop.org<br>
<b>Subject:</b> Re: [PATCH] drm/amdkfd: Allocate doorbells only when needed=
<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<p class=3D"MsoNormal">No one else seems to have any thoughts on it, so Rev=
iewed-by: Kent Russell &lt;<a href=3D"mailto:kent.Russell@amd.com">kent.Rus=
sell@amd.com</a>&gt;<o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
<div>
<p class=3D"MsoNormal">&nbsp;Kent<o:p></o:p></p>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"1" width=3D"98%" align=3D"center">
</div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"color:black">From:</span></b><span=
 style=3D"color:black"> amd-gfx &lt;<a href=3D"mailto:amd-gfx-bounces@lists=
.freedesktop.org">amd-gfx-bounces@lists.freedesktop.org</a>&gt; on behalf o=
f Russell, Kent &lt;<a href=3D"mailto:Kent.Russell@amd.com">Kent.Russell@am=
d.com</a>&gt;<br>
<b>Sent:</b> Monday, August 22, 2022 10:10 AM<br>
<b>To:</b> Kuehling, Felix &lt;<a href=3D"mailto:Felix.Kuehling@amd.com">Fe=
lix.Kuehling@amd.com</a>&gt;;
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a> &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.=
freedesktop.org</a>&gt;<br>
<b>Subject:</b> RE: [PATCH] drm/amdkfd: Allocate doorbells only when needed=
</span>
<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"MsoNormal">[AMD Official Use Only - General]<br>
<br>
I can throw an Acked-by: Kent Russell &lt;<a href=3D"mailto:kent.russell@am=
d.com">kent.russell@amd.com</a>&gt; since we don't have an RB yet.<br>
<br>
&nbsp;Kent<br>
<br>
&gt; -----Original Message-----<br>
&gt; From: amd-gfx &lt;<a href=3D"mailto:amd-gfx-bounces@lists.freedesktop.=
org">amd-gfx-bounces@lists.freedesktop.org</a>&gt; On Behalf Of Felix<br>
&gt; Kuehling<br>
&gt; Sent: Wednesday, August 3, 2022 2:56 PM<br>
&gt; To: <a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.fre=
edesktop.org</a><br>
&gt; Subject: [PATCH] drm/amdkfd: Allocate doorbells only when needed<br>
&gt; <br>
&gt; Only allocate doorbells when the first queue is created on a GPU or th=
e<br>
&gt; doorbells need to be mapped into CPU or GPU virtual address space. Thi=
s<br>
&gt; avoids allocating doorbells unnecessarily and can allow more processes=
<br>
&gt; to use KFD on multi-GPU systems.<br>
&gt; <br>
&gt; Signed-off-by: Felix Kuehling &lt;<a href=3D"mailto:Felix.Kuehling@amd=
.com">Felix.Kuehling@amd.com</a>&gt;<br>
&gt; ---<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdkfd/kfd_chardev.c&nbsp; | 13 ++++++++++++=
+<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c |&nbsp; 9 +++++++++<br=
>
&gt;&nbsp; drivers/gpu/drm/amd/amdkfd/kfd_process.c&nbsp; |&nbsp; 5 -----<b=
r>
&gt;&nbsp; 3 files changed, 22 insertions(+), 5 deletions(-)<br>
&gt; <br>
&gt; diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c<br>
&gt; b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c<br>
&gt; index 2b3d8bc8f0aa..907f4711abce 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c<br>
&gt; @@ -327,6 +327,12 @@ static int kfd_ioctl_create_queue(struct file *fi=
lep,<br>
&gt; struct kfd_process *p,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; goto err_bind_process;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; <br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (!pdd-&gt;doorbell_index &amp;&amp;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_alloc_process_do=
orbells(dev, &amp;pdd-&gt;doorbell_index) &lt; 0) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; err =3D -ENOMEM;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; goto err_alloc_doorbells;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Starting with GFX11, wptr=
 BOs must be mapped to GART for MES to<br>
&gt; determine work<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * on unmapped queues f=
or usermode queue oversubscription (no<br>
&gt; aggregated doorbell)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt; @@ -404,6 +410,7 @@ static int kfd_ioctl_create_queue(struct file *fil=
ep, struct<br>
&gt; kfd_process *p,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (wptr_bo)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; amdgpu_amdkfd_free_gtt_mem(dev-&gt;adev, wptr_bo);<br>
&gt;&nbsp; err_wptr_map_gart:<br>
&gt; +err_alloc_doorbells:<br>
&gt;&nbsp; err_bind_process:<br>
&gt;&nbsp; err_pdd:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;p-&gt;mute=
x);<br>
&gt; @@ -1092,6 +1099,10 @@ static int kfd_ioctl_alloc_memory_of_gpu(struct=
 file<br>
&gt; *filep,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto er=
r_unlock;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; offset =3D kfd_get_process_doorbells(pdd);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (!offset) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; err =3D -ENOMEM;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto err_unlock;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; }<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (flags &amp; KFD_I=
OC_ALLOC_MEM_FLAGS_MMIO_REMAP) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (args-&gt;size !=3D PAGE_SIZE) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; err =3D=
 -EINVAL;<br>
&gt; @@ -2173,6 +2184,8 @@ static int criu_restore_memory_of_gpu(struct<br>
&gt; kfd_process_device *pdd,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return =
-EINVAL;<br>
&gt; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; offset =3D kfd_get_process_doorbells(pdd);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (!offset)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -ENOMEM;<o:p></o=
:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Looks like this is causing CRIU restore failure.<o:p=
></o:p></p>
<p class=3D"MsoNormal"><br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (bo_bucket-&gt;all=
oc_flags &amp;<br>
&gt; KFD_IOC_ALLOC_MEM_FLAGS_MMIO_REMAP) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; /* MMIO BOs need remapped bus address */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (bo_bucket-&gt;size !=3D PAGE_SIZE) {<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c<br>
&gt; b/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c<br>
&gt; index cb3d2ccc5100..b33798f89ef0 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c<br>
&gt; @@ -157,6 +157,8 @@ int kfd_doorbell_mmap(struct kfd_dev *dev, struct<=
br>
&gt; kfd_process *process,<br>
&gt; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Calculate physical addres=
s of doorbell */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; address =3D kfd_get_process_=
doorbells(pdd);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (!address)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return -ENOMEM;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vma-&gt;vm_flags |=3D VM_IO =
| VM_DONTCOPY | VM_DONTEXPAND |<br>
&gt; VM_NORESERVE |<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; VM_DONTDUMP | VM_PFNMAP;<br>
&gt; <br>
&gt; @@ -275,6 +277,13 @@ uint64_t kfd_get_number_elems(struct kfd_dev *kfd=
)<br>
&gt; <br>
&gt;&nbsp; phys_addr_t kfd_get_process_doorbells(struct kfd_process_device =
*pdd)<br>
&gt;&nbsp; {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (!pdd-&gt;doorbell_index) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; int r =3D kfd_alloc_process_doorbells(pdd-&gt;dev,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;=
pdd-&gt;doorbell_index);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (r)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return pdd-&gt;dev-&gt;doorb=
ell_base +<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; pdd-&gt;doorbell_index * kfd_doorbell_process_slice(pdd=
-&gt;dev);<br>
&gt;&nbsp; }<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c<br>
&gt; b/drivers/gpu/drm/amd/amdkfd/kfd_process.c<br>
&gt; index 6c83a519b3a1..951b63677248 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c<br>
&gt; @@ -1499,11 +1499,6 @@ struct kfd_process_device<br>
&gt; *kfd_create_process_device_data(struct kfd_dev *dev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!pdd)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return NULL;<br>
&gt; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (kfd_alloc_process_doorbells(dev, &amp;pd=
d-&gt;doorbell_index) &lt; 0) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; pr_err(&quot;Failed to alloc doorbell for pdd\n&quot;);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; goto err_free_pdd;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; -<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (init_doorbell_bitmap(&am=
p;pdd-&gt;qpd, dev)) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; pr_err(&quot;Failed to init doorbell for process\n&quot=
;);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; goto err_free_pdd;<br>
&gt; --<br>
&gt; 2.32.0<o:p></o:p></p>
</div>
</div>
</div>
</body>
</html>

--_000_DS7PR12MB5933CD41FC16BC1E6776FD92FE7B9DS7PR12MB5933namp_--
