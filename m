Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B37BC369B2
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Apr 2025 09:42:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7167F10EA8B;
	Thu, 17 Apr 2025 09:42:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rOd6OQVv";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2068.outbound.protection.outlook.com [40.107.243.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3ED1B10E1A3
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Apr 2025 09:42:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dqLoQSphvTqph4M0JygSVBw0jAwVOT2zSi6n2hel51CofKWiD7vdepxxCvW6oMyAw5bDDT/CKE1cGO4joIQvgzamsAchUmtOYOEIGfmqadeEB7Lw48qhb0nySf12yA94E2PN0liuRkht+gpDKwZhLoNBBY3QLd8XcCP8Zsj5Wn5duPY+TK2Mwei2F60Pr/+IAdiMKh7sK4KEXmO3qhbdbjFKxzOAq4d6JuugGpDm7lIV31+ngFbAbilAMz5sw3K9YKX2uQ10M8UwEmApMPU+RmEYk+474wMkXkP5oinhxVb5KYyDEV1SiEOA8UUbPrzMiRZM92aZvrKGU0X3iqXWug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Qv0mZbLa8/aGmh4902qxieeIWHjQlfKN5SZ7ip1PpA=;
 b=B+tCFCeQPy/fZHRx6YD89wwGwisN/d+Ap90LT5C6xzjc+j5f4y5djPs4fnx46XNOkEoVPOwFBL/0ouZo0AX1j0qPb4RTx4lmbz6eDzZRhS3tYmGrfZjLy+Z66szFHIY8qECfDAbxCfW4xxL8COkrf0PKMLuI8uN8qEtTFfL6S63p7Jb4QPw111RoIR1FpSotBC6QpYB5Ikvq27Nz0BAQuokRmvUfZEknjFQQPyLMUageCXU9XChCmvTrI+oo70AsNXtJVNCchhe96JMYxOo+/2G217VkVrYNw+ceORPodUPSP5hnyNF2SNgi7cDIi7gOL3YIPqS/PBRKrgMZcHVM0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Qv0mZbLa8/aGmh4902qxieeIWHjQlfKN5SZ7ip1PpA=;
 b=rOd6OQVv19nGv9wP71gUPWKZgkZW3ESmKqGZi2IMNHq6O72zUJV3RL7iFuTJV9ZhJ0/m4AblKwCJn/j3LIknYrpQhPUpEjQdMHBpwq7R9D1Yll33259C/4vsXYsxYM6QKpunUO0PnSS5kmD2/BXEEaH3jXk8ez0rJSsfbHHzeik=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 LV2PR12MB5847.namprd12.prod.outlook.com (2603:10b6:408:174::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8632.34; Thu, 17 Apr 2025 09:42:40 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb%6]) with mapi id 15.20.8632.035; Thu, 17 Apr 2025
 09:42:39 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 2/2] drm/amdgpu/userq: move waiting for last fence before
 umap
Thread-Topic: [PATCH 2/2] drm/amdgpu/userq: move waiting for last fence before
 umap
Thread-Index: AQHbrwAO+QjYc1kv+kWoJs5mf8UqCbOnm8dw
Date: Thu, 17 Apr 2025 09:42:39 +0000
Message-ID: <DS7PR12MB6005551809D9C6B914BAD607FBBC2@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20250416184713.28964-1-alexander.deucher@amd.com>
 <20250416184713.28964-2-alexander.deucher@amd.com>
In-Reply-To: <20250416184713.28964-2-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=0dc38494-1a04-4907-b46c-7922209509ed;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-04-17T09:41:34Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Tag=10, 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|LV2PR12MB5847:EE_
x-ms-office365-filtering-correlation-id: a7e83f56-0773-46bb-1f7f-08dd7d9431a6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?uJYuXAncnG+sKPzOnHCblguHUOXBWEnRNjiEPV1DjYcX65bnqXJ+eTCt3FFp?=
 =?us-ascii?Q?RFvKDfuzCCSyaLGtQV36yO4Tni8B0kwUoTbJcViGPAXRN+frogSygpTgg7/R?=
 =?us-ascii?Q?iz4oaqrOAoBaYMb78qqjF3D8QrVCwyXcfI6cyK7denFv3HjC0p59E/3toByk?=
 =?us-ascii?Q?e0EP4yMguw2qV9IUDuhiV813II+YNEk2sz7QlCfJxtQ42q3F255BtyfNbb+b?=
 =?us-ascii?Q?Cp6EOgkjuV5cBdYUnAj0lIN6KQXZQ6vsuSNNa0ZQXge1fnPAfk/Ir/GVQMwH?=
 =?us-ascii?Q?SIx9Y1xdxKHdgpD0zN0eII6nnmoQ0tzoEl0D6/a5hN0pcUKGPvjAc+sP81dO?=
 =?us-ascii?Q?EW3a1Qqk3k9AgJrJQGdQISHV4rHLNj1IWQ/x7FX/bPV6EWs4GYLtCT3hSIOl?=
 =?us-ascii?Q?NA1JfhW0Mj6frhvnWaYQ6DdO1bR8qXqH/xuVgIVmgC54EIguWtQqu5Fy+Xn5?=
 =?us-ascii?Q?lt858e2+koRvMw+n5lIwc8UxRgT6NCXGBtxUkewXXY4UPeKtGN/ewfOnrAUj?=
 =?us-ascii?Q?vlHPqm3zhWUeKpEOkY+a69yHmyuyQRd9TFlkYwXv4sQCyLCwLF4GEwlJSbZo?=
 =?us-ascii?Q?nJNGeR4wGF2E2P50bwGpLpAdCznyE6UnvQS8Wzf0iUrFIeIxNBnIsKkp8Fyl?=
 =?us-ascii?Q?LCG5SyMzeN7E67ZZbVtE8GYb0GfUtJZQkellZED2+QXtfvr3TOmLmUe87480?=
 =?us-ascii?Q?apzr7UbjY4e3C7fJvBull537nXvZBPIUu87ZhpFDREvB7IHzGJQCJ6Vi0Hgj?=
 =?us-ascii?Q?1NQVFiPwd3v3pCvJ3Pxv26LqKTPP4sp8wUQ1dXlS2P4/QnQLYDdaKxQLKkf1?=
 =?us-ascii?Q?9BtIykgu2wIB5sG8ViwpIoWH15zsP/SOTgEPHWlSNOJoPOVKfC34sKZTPzem?=
 =?us-ascii?Q?K4NvBqyIIPzgxx+iz43vVnPhSGKQnZhja4A2rgSSc1mDT+UyKXpC3t2eUGGK?=
 =?us-ascii?Q?h+XwNOBPx8Mks3IrUGmJy+g0JhZi2magcQPqhbjCoVfHfdkF7OeUy2UMsnn3?=
 =?us-ascii?Q?reFMHtPWDDfDmNP+mv/FA69IIpbCJ85eLIUPpv1wy9RWYcmd5fO6SC80cKG4?=
 =?us-ascii?Q?RCiJ4wRPuojEOu5YyWsF6WRGM3B7HYH5H28gbBkDS3FOCX/iqak83ypxyi1S?=
 =?us-ascii?Q?3jiVHqmGfdr9LDrCuc5ZS0tEevrB+/sKk/UJqrOjvEMD0exPoNSwC3sVdwvk?=
 =?us-ascii?Q?CsztwkDzTP/mlepIQLqUMf1+dY8ifrVbFTnLZDp3kVK1y79MGbF7rja6wRPx?=
 =?us-ascii?Q?KS4qm/p0ofeOUO7ntG0gkEjZ1NjFXz5VuXjf596dn8jRoieSrDZsO33pwOx0?=
 =?us-ascii?Q?yFE9n5uNygnDBkjdm7VY923a7TYieh3mFmK3bHwbRRwvWvBX5euQCjTOom8+?=
 =?us-ascii?Q?ZFjvs5WZV8W4sKlenJm6JvNk7WxC/DFdiW/x7//0PPXYY0kl9KzcavKqApyR?=
 =?us-ascii?Q?uycb1XRL5L6GUgyRylx+79YNfbrJlGB9aEu407GigG7sgxgY++SXBZFtgVU8?=
 =?us-ascii?Q?WcvVeUs0VeP/pbc=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7VNNsXqABdD0t4VlAApzhb+nC8hqahM1RenyjsjBi+u90FMfj9YzZqx3uRG0?=
 =?us-ascii?Q?irl1oCkeG81o+nhYLVdRm97PfMcEkFL5PADAqwwR/Q0anLZB/wOM1RRzoGgx?=
 =?us-ascii?Q?TeLw7eEbOEelqsaKPhtxvdgHciITfd1jUIP00LPaQLVPrxLS6ieZlIBm++vf?=
 =?us-ascii?Q?qSepJP1tmHJ+q0VQH6BweP46mNDfJQxhYgdErEzvYiPu2479Vq8PNTmXhYwc?=
 =?us-ascii?Q?sYFXRegomsJ5Ro3NkLt/I92pjfdSZCTDFQPtWXRDbGOhsBUp3GyjWyJ0ooyE?=
 =?us-ascii?Q?ZUQHqEPvWuxNQ1QY/ds7tJ2O+corW+IAFLI36Nf0OrhQK6XKg1/TSCHn/UZI?=
 =?us-ascii?Q?jLH2NwGyLmX87Sl4vKRa4Y0+7MPKMZ2Uom8kzDW5OTXZJldaUEO/61Ot/rh1?=
 =?us-ascii?Q?q3YtvoqWN8cJtEgD63BDtDwDcTA3yMkruSD6CqC2JIvnzrLkV7EhaScHfZ0T?=
 =?us-ascii?Q?0kKmNwTZqg6yPYls7TBzN7Bk08oYAidqdmUOq8DLRuqtpIhsu09Pwf8kz9Qi?=
 =?us-ascii?Q?j/jbikdgippSZTVXITMgYCHZ4fZxLm9KOko0/cLDWHbU9/ZKfthjv+Pj2xdP?=
 =?us-ascii?Q?2EHiWfAxgSJDElzMhtwl40EKgSs9X+CEzqIzIm18gef7byIMQY/A2ndnBNNu?=
 =?us-ascii?Q?ZxfyFjbuz88uQ8Hmp19Iom22NT3DElRYGEe58uOQQyUAPcQrpSdCZrSEfcAX?=
 =?us-ascii?Q?Fpr9f1RfTduyqLPgIwbiYQb/KIuHf6KHjBFdk2Q0GOhE1J5H5HAQ3K6BIVnd?=
 =?us-ascii?Q?3JEjRDKyukg6p/1ZYRbFL/mzgfBtKMpBemu+S4ApcejNvMvGlnfVKoY8sPU1?=
 =?us-ascii?Q?8EvQpu2aw6S0ipY4B//UU8n6mO2UjCNecblW2Ixjodx1KTRUclpcLoYNlqgD?=
 =?us-ascii?Q?o6S6wg53thLW6a/mq9za9sxRT75rAVa1k+taQ4bsJPj94QzVOV8P/89/wq1J?=
 =?us-ascii?Q?mmfBP4/XX187ws/Ml2Fvsoe+q780ZErJWU1nAGG8ehrJGzJwP8ECdnqJyJkk?=
 =?us-ascii?Q?gVnI6aTjtNP8pgv/vwJcSCVPU635Yab7xNA5qtd4wCUeHI1Fyhjde/uhrvjg?=
 =?us-ascii?Q?0EuNhjC8kBf6LhO2Y7BnGeJXogthoZa0GG5upw4QTzMGAvenX82Q/Utmal8y?=
 =?us-ascii?Q?uLgheQsoSqWF/Kvsxhn89epKjpYtfm0+m2DnovCFwGPSqvn16RpLV+m/RTHN?=
 =?us-ascii?Q?KRae5u/SBa4kjNy3qAXl1advypkfDrEQAVnjCgJmhuLlCtiDBiNtIS+xcayd?=
 =?us-ascii?Q?UYc44eZDzLr2JWOnAsKgJaPyfrmB6kXYyLKUYnW82Jcx87E+JSFlM1v/p77B?=
 =?us-ascii?Q?U0xPkVlTuv7nS98nzYrNIB3S7dyflnu8UMqEoLHgIcP6AQyRLrDShKJbULIW?=
 =?us-ascii?Q?o9me4gZZVrjxer71WkSS58uEYvXfxhHrA2PH7YwGQOWwN3MTgPhxN16M233a?=
 =?us-ascii?Q?MiJmEqAB/dSmGWfHXm4bX5jIuww2r613rmM7L1U4Y9UNPKTJMlQ1hylO34oQ?=
 =?us-ascii?Q?7sPAewkr051LXm8LhJz4wJm0rMiAFOuNXjUaosJcUAX1iVj6NapxcPEC5A2o?=
 =?us-ascii?Q?ylit6cCBUHPaVQt/M1k=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7e83f56-0773-46bb-1f7f-08dd7d9431a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2025 09:42:39.7547 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Cl00CAwZkUvKY95Td0IEjM9BpcgPH620yklXUFM4ZEi5Yy156UU316YtpK904kYz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5847
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

[Public]

Series is Reviewed-by: Prike Liang <Prike.Liang@amd.com>

Regards,
      Prike

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex
> Deucher
> Sent: Thursday, April 17, 2025 2:47 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: [PATCH 2/2] drm/amdgpu/userq: move waiting for last fence before=
 umap
>
> Need to wait for the last fence before unmapping.  This also fixes a memo=
ry leak
> in amdgpu_userqueue_cleanup() when the fence isn't signalled.
>
> Fixes: 5b1163621548 ("drm/amdgpu/userq: rework front end call sequence")
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 23 ++++++++++++-------
>  1 file changed, 15 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> index b449c685302e1..06e41023a04ba 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> @@ -109,22 +109,27 @@ amdgpu_userqueue_map_helper(struct
> amdgpu_userq_mgr *uq_mgr,  }
>
>  static void
> -amdgpu_userqueue_cleanup(struct amdgpu_userq_mgr *uq_mgr,
> -                      struct amdgpu_usermode_queue *queue,
> -                      int queue_id)
> +amdgpu_userqueue_wait_for_last_fence(struct amdgpu_userq_mgr *uq_mgr,
> +                                  struct amdgpu_usermode_queue *queue)
>  {
>       struct amdgpu_device *adev =3D uq_mgr->adev;
> -     const struct amdgpu_userq_funcs *uq_funcs =3D adev->userq_funcs[que=
ue-
> >queue_type];
>       struct dma_fence *f =3D queue->last_fence;
>       int ret;
>
>       if (f && !dma_fence_is_signaled(f)) {
>               ret =3D dma_fence_wait_timeout(f, true, msecs_to_jiffies(10=
0));
> -             if (ret <=3D 0) {
> -                     DRM_ERROR("Timed out waiting for fence f=3D%p\n", f=
);
> -                     return;
> -             }
> +             if (ret <=3D 0)
> +                     dev_err(adev->dev, "Timed out waiting for fence f=
=3D%p\n", f);
>       }
> +}
> +
> +static void
> +amdgpu_userqueue_cleanup(struct amdgpu_userq_mgr *uq_mgr,
> +                      struct amdgpu_usermode_queue *queue,
> +                      int queue_id)
> +{
> +     struct amdgpu_device *adev =3D uq_mgr->adev;
> +     const struct amdgpu_userq_funcs *uq_funcs =3D
> +adev->userq_funcs[queue->queue_type];
>
>       uq_funcs->mqd_destroy(uq_mgr, queue);
>       queue->fence_drv->fence_drv_xa_ptr =3D NULL; @@ -330,6 +335,7 @@
> amdgpu_userqueue_destroy(struct drm_file *filp, int queue_id)
>               mutex_unlock(&uq_mgr->userq_mutex);
>               return -EINVAL;
>       }
> +     amdgpu_userqueue_wait_for_last_fence(uq_mgr, queue);
>       r =3D amdgpu_userqueue_unmap_helper(uq_mgr, queue);
>       amdgpu_bo_unpin(queue->db_obj.obj);
>       amdgpu_bo_unref(&queue->db_obj.obj);
> @@ -818,6 +824,7 @@ void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr
> *userq_mgr)
>
>       mutex_lock(&userq_mgr->userq_mutex);
>       idr_for_each_entry(&userq_mgr->userq_idr, queue, queue_id) {
> +             amdgpu_userqueue_wait_for_last_fence(userq_mgr, queue);
>               amdgpu_userqueue_unmap_helper(userq_mgr, queue);
>               amdgpu_userqueue_cleanup(userq_mgr, queue, queue_id);
>       }
> --
> 2.49.0

