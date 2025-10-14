Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 426CECCD18E
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Oct 2025 09:05:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D03B910E583;
	Tue, 14 Oct 2025 09:05:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qpLat6Lr";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010024.outbound.protection.outlook.com [52.101.61.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A768C10E583
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Oct 2025 09:05:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pXSdusIVbapcnAcZCtB+63+mo6O/gZu/8cP+rOxfHvLAL1vHt2o/EeGiFJoEgzgI/xuSQnQbZY753QPC/fix6o6YIBaxeUjTgSWrM14ePghQ62GG/D5bX98MO++YpmTRm4843KEFbk2wCqk2EmYTlhSmX33Un3olJqK2FkXCAAsMr5vet31Jz5mJorp0jcd7eYgCustf42cUnS5R4PONXoK7+DUuzsTmqEOHWdBMVxY3urPKT4Lqx2kncqyLiQQ0dnvbUP1YPNU+JvPZ391MIjX2VsAZuBa6PTBVU/0n5fs7hCJ/NLQIYbzw85vwmLM7y2dztyLEbeMMQuYjM4ZnuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F3v+GcZMY35NW8sveiIxg+33jaUDhSPOeyerRbJz52M=;
 b=jl3/u2QnPDDuTO80zovr6idOHpTNssDxo3TDLIdmGLoqFrn1ttz8ZaeVspTLtyu4PzgJ9NTQgRVd8oTJpUX97Cjc54G0uA9MMBupI/b7rPa70s9bHjOELGjudulFvUNna2aJ4PqXWG2EASH2v/lTsUGj/a5WsGRctSwIaxYWQQgpwI+O95OCS7ux26aUquprDYGu/6RrhU7v1sB7FwnGHM8iuXMXbq3zvYmWrdRYFsimjmzTF5/T5b155Z1CmbfE5MurmgXMGn0pfGzw6prY6c6fyB5+MwFEQsWsdxHcR3vkqaKUkxOHB2/KoMsl4+uBLfh/XGsw+6JjFkgDRFeosQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F3v+GcZMY35NW8sveiIxg+33jaUDhSPOeyerRbJz52M=;
 b=qpLat6LrhvGYN+dsfGwwYcZYa3QQ5Wkbp8PKyEBB2o5rOpkpvytJClwLfyYQk2FoDFaIGt3Mipp4dXGubIUdjPOWyG2GzIOL704vjcOylOzg3N2l857tc2WjyTXe5tKrGka/DRHvA4ewC2qiX7XUlqjERjHsZ0sn+QXGVk+sfjA=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 PH0PR12MB5680.namprd12.prod.outlook.com (2603:10b6:510:146::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.10; Tue, 14 Oct 2025 09:05:37 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb%4]) with mapi id 15.20.9203.009; Tue, 14 Oct 2025
 09:05:37 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 1/6] drm/amdgpu/userq: fix SDMA and compute validation
Thread-Topic: [PATCH 1/6] drm/amdgpu/userq: fix SDMA and compute validation
Thread-Index: AQHcPFxtr0aUmkyDgk2TXsUsEhzhC7TBWouw
Date: Tue, 14 Oct 2025 09:05:37 +0000
Message-ID: <DS7PR12MB600554A224E320CD562A8ACCFBEBA@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20251013161352.1628044-1-alexander.deucher@amd.com>
In-Reply-To: <20251013161352.1628044-1-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-10-14T09:05:13.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|PH0PR12MB5680:EE_
x-ms-office365-filtering-correlation-id: 82a853e2-ea41-41dc-2841-08de0b00d73e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?x/DBcRy2bHx67Xh+dr+sSBzUdkhpT0+Hfz3nKi5dQzeuI53GlWKYFVtBskTA?=
 =?us-ascii?Q?TyU4VxMiS+HvBz/TgqMW+/S7Bxk1HTxvaV2HZniXgr7lf+3mdXApcMM0996+?=
 =?us-ascii?Q?l3Ji/i6FcphlzLSD5Dx5j7gYa5m5qy/uG/vnBoNjCl0rWkHYTw2rH5XfNpxt?=
 =?us-ascii?Q?4a1OHNXOxV5hPIAhcQmKadLlAZXBVnb24bKU7H9iqo1eKwd+XEGW7IyNkqjp?=
 =?us-ascii?Q?iNaVkQSBw4xzjrXe8Z890asihtauxGN2VjvYCyTfpuIkisItaxL8VVDVylMd?=
 =?us-ascii?Q?kocOGTJYxR1cI1pH0O/lUwcc1wEsFWiO1BS0MHa98mmDMqUH6x3pD+WmuEa4?=
 =?us-ascii?Q?QhPsF8kStSlPbr8BG94F6M+pGlM+nFVExPBnXrYD6GcErvIVvLNnEUGzZbdW?=
 =?us-ascii?Q?fM1htxd+OSIrtUYyE7rPREsXf1gf7lJHyXODDl/Y1FBqE7KQ2DFxhqn3QK8o?=
 =?us-ascii?Q?xHAguLN9E5Ftqrnv/axASXvZZCwJV1kHYRqZmzuPNcMQHNFJv5VmMaG2DVEf?=
 =?us-ascii?Q?UsUMXGjWRRHVAdHPQlysj+k3kVlXfAAFXjCfb3LL/WnQN5UbcKvcQ5aoW6r9?=
 =?us-ascii?Q?a8ybq9zmZgN5yieIHY+Y8wSfvBa/93P6SOsGA32XLyGwte3UEKXr7RJCvikP?=
 =?us-ascii?Q?HGAElqYHDsp0k8kTa7IZcs/IYrcMj6kntBNYl1StuvgrE2LqItlnQjI6lmed?=
 =?us-ascii?Q?pRYxQVyq9YS/vE4/xKU/g8EIfY27hoB4kPOqsrFIUVRiVaICyNEer9ju4pCf?=
 =?us-ascii?Q?M6bYs+u8eP0b4FzND92EHvjaXYmdhxLVjg4CJVJngTCAwIR6niRGgMjYHD/g?=
 =?us-ascii?Q?UvpxrZLI+NyvGLjLMDPGptecZqDsx6pP117yYGd44CX2i5JpXXYT3gtMtI1Q?=
 =?us-ascii?Q?0eINclu/mWEHBuFxhI+RVUPisiLKcSwRmgVTKLVaHuLIkKEjKR5M7h4jBvbD?=
 =?us-ascii?Q?AGCwPuHgygGD1mmDi6zELg2t9tmUN4HQaFvl/tNUoidH7DUFF6wk9bP0hRuF?=
 =?us-ascii?Q?1lzGW4OplH4uarhRt6jT63OW0gDj1uefFixk+7hECIKISzbkuiEwY6SiHYlj?=
 =?us-ascii?Q?au7ucTU3e49SfFywly9AaYSaPOKR7fJ7UWiQo81NG/QY+hiKddpPvUtwEKtF?=
 =?us-ascii?Q?SctwZ6gW69EXVVcYhWO+OIsUPl7CHYuj16qi8p4KrX8nAi7W0LEVcaukhmMe?=
 =?us-ascii?Q?I6TszDCxEhif7ZfcpeccezilJ6Ptc2Di031Idy8ehL0WVFb7t0DUNttrcN1U?=
 =?us-ascii?Q?meDMdxT3oqhlP8CzDowenMgBZuO9wbBy8ac4lgfItvWrR5/CMdVuywwgyXOU?=
 =?us-ascii?Q?akOdxt5hph9SPMiGpSzvr8+HcTi/ptvzPeVK9ad0pChUx7vVEh+VwMhn0k/+?=
 =?us-ascii?Q?QPB4hUDPqTAsB4rrkO/iElsvXY1cRuuUD+GPeCy+lJsqU00gjgbqZKNez89d?=
 =?us-ascii?Q?UrmRzbtYw2mHBkn3RoCmWc2JNrmxTZlY6jm4e2vug6/gT9Na/t+uE1UgvO8s?=
 =?us-ascii?Q?bil5AykdW6NDL7xMqX1e7amgYpSMxRcmCXAo?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bxP4GyQ7IK3BYYrxdZxZxJYDLC/EP+hRxdkzSKrD2/6ZzIyDJ50btB3YiZwT?=
 =?us-ascii?Q?zG0ZmnTaSI+4tf91R1qAey2z4Vw0r9bklVN8KRQaWcJjwLF3gQKZ493zQwjt?=
 =?us-ascii?Q?iciv64dJL3xVsym4qNsfJxnMVcSUIPTY1XsTdRkpqjrH5kQ4YMawslqtKV0c?=
 =?us-ascii?Q?TCvlTyfUOovofOwZLKFbWNW+Mye9eEU1fsRrAWqYA3urTAga5mGro2o4P2vy?=
 =?us-ascii?Q?X4Mi5GA3klhG8JGYHmLmOQs/BfamK7mInXrf1WiGPd0f0B7i8DXmhbD55iTr?=
 =?us-ascii?Q?hybUY3fig277JMKM/Y+Lc5od7ARJyi2y0H2mzDcYNZMdr4WXrsHRMJ7LgUSw?=
 =?us-ascii?Q?J2C2Jixz2AbzzeDG2DVqdQb1miD1S/21SYzbE3CgRfXLYWpzjrW/07Iwp8P4?=
 =?us-ascii?Q?aGj63rhNWmt67tYnsKcH4RzRpFPxL/3TKEvbEZMKpyFYKJjGNiBp30+mkQh+?=
 =?us-ascii?Q?nkav5FHt8gVEmvIRPrduu3IOCI1DwSQ3vYXRzqorBnmBHjQWXFX3NQs7aGAL?=
 =?us-ascii?Q?AEw9YNsL/DLPTqVYiaIPNnWMUVdBUHvAbS1BXA/NL49Lw/V+/r0gW+cZaGDo?=
 =?us-ascii?Q?kVycwze8b8VeW1BawR6iyKxl30kIsF7BZ74kq8c101CxWeZPhqENKzq0L+Fd?=
 =?us-ascii?Q?biKfSJ/3rlf4Bt05GIcVuPxRqiHCU8uRGjnqaxCxiiraYkfeezWrByczbcEo?=
 =?us-ascii?Q?rkH5kErrDzU71REkV7R7JoKSH7/XxXmB6XCs0f723FqdAvB318OisP8BADCK?=
 =?us-ascii?Q?AbRCAXOXU3Oz1QMZCpoyYxmVjUGAbKWF69ezs1IhhiS5If/bZnESwF5kIj/X?=
 =?us-ascii?Q?G0zpjtGUsKHemPeAYtAJuOnrspU8ys0Dz/ca9p2o0Jz+1NEVMG2GJyr4H7kf?=
 =?us-ascii?Q?ky+9W5D3gqUz4QrrNoA4AtqdtzSCHtoSm8ifEkVq7fMg+G336sSZNXmRVNHP?=
 =?us-ascii?Q?y53vH1rspVkX3DAzZyl+5QOg+9PFns5QaZWyFbt/hnGC2aUMYO/bW3JPJuHs?=
 =?us-ascii?Q?S0oj4oVWAt6SZUBy5ZacMIIt/RclL1FL0E/vs0XEnwHt0oeqKA5vShFO+RYT?=
 =?us-ascii?Q?Mi2+Cj+WhoSmVqBAqp3pkGRJWw6MMl2heWH/pnw2d+JbpoAL9t0OBDlq+5Ai?=
 =?us-ascii?Q?eMWK6XKT0R52CF/1FE7Orb+FdYhtaT7t14JiD68nWQLq11nfzPY4FnNtJ69W?=
 =?us-ascii?Q?TU4il+4QRGMHgh/H4bvXkPl1zZnZb+d1wd6LL1hww5wHFkOkMJHJa1jveLs3?=
 =?us-ascii?Q?tWGgpjggNw0L/z28BuiYgwk6Za1GQeBSznLIz2iYEmqB39AqHamganu3z9i8?=
 =?us-ascii?Q?kkN6SBtu5JgeySfNis2YQTkB+u1UoUcMSwg4hO/Kts6SVLWzFWtJ08iZ4tZX?=
 =?us-ascii?Q?PMVPQOHkxsy1hrOUZCCe17TAucFI0P2RamXOQ78e07/av0HF8BhxQbbsEJtq?=
 =?us-ascii?Q?MB5IKQeivFRVb+Z0DlCRr7N3kp886Ytx63GuavNQBIcsKDhZ+isQ/Q/R1wKy?=
 =?us-ascii?Q?2hehzF3lNlrEfeS9WIQooQhppKPXTN41IIUQiRzybJdlOr5KPkWggQec1trS?=
 =?us-ascii?Q?Tw8SQqOSYiULrjj9GOE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82a853e2-ea41-41dc-2841-08de0b00d73e
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2025 09:05:37.2036 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0voo60xq/qo2/pQbreBdYd++MN9YpsA7T4Ej03JYnXVvG2b0nKtkv8F8rUQjsJI1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5680
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

Reviewed-by: Prike Liang <Prike.Liang@amd.com>

Regards,
      Prike

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex
> Deucher
> Sent: Tuesday, October 14, 2025 12:14 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: [PATCH 1/6] drm/amdgpu/userq: fix SDMA and compute validation
>
> The CSA and EOP buffers have different alignement requirements.
> Hardcode them for now as a bug fix.  A proper query will be added in a su=
bsequent
> patch.
>
> v2: verify gfx shadow helper callback (Prike)
>
> Fixes: 9e46b8bb0539 ("drm/amdgpu: validate userq buffer virtual address a=
nd size")
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 19 ++++++++++++++-----
>  1 file changed, 14 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> index 5c63480dda9c4..f5aa83ff57f35 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> @@ -254,7 +254,6 @@ static int mes_userq_mqd_create(struct
> amdgpu_userq_mgr *uq_mgr,
>       struct amdgpu_mqd *mqd_hw_default =3D &adev->mqds[queue->queue_type=
];
>       struct drm_amdgpu_userq_in *mqd_user =3D args_in;
>       struct amdgpu_mqd_prop *userq_props;
> -     struct amdgpu_gfx_shadow_info shadow_info;
>       int r;
>
>       /* Structure to initialize MQD for userqueue using generic MQD init=
 function */
> @@ -280,8 +279,6 @@ static int mes_userq_mqd_create(struct
> amdgpu_userq_mgr *uq_mgr,
>       userq_props->doorbell_index =3D queue->doorbell_index;
>       userq_props->fence_address =3D queue->fence_drv->gpu_addr;
>
> -     if (adev->gfx.funcs->get_gfx_shadow_info)
> -             adev->gfx.funcs->get_gfx_shadow_info(adev, &shadow_info, tr=
ue);
>       if (queue->queue_type =3D=3D AMDGPU_HW_IP_COMPUTE) {
>               struct drm_amdgpu_userq_mqd_compute_gfx11 *compute_mqd;
>
> @@ -299,7 +296,7 @@ static int mes_userq_mqd_create(struct
> amdgpu_userq_mgr *uq_mgr,
>               }
>
>               r =3D amdgpu_userq_input_va_validate(queue, compute_mqd->eo=
p_va,
> -                                                max_t(u32, PAGE_SIZE,
> AMDGPU_GPU_PAGE_SIZE));
> +                                                2048);
>               if (r)
>                       goto free_mqd;
>
> @@ -312,6 +309,14 @@ static int mes_userq_mqd_create(struct
> amdgpu_userq_mgr *uq_mgr,
>               kfree(compute_mqd);
>       } else if (queue->queue_type =3D=3D AMDGPU_HW_IP_GFX) {
>               struct drm_amdgpu_userq_mqd_gfx11 *mqd_gfx_v11;
> +             struct amdgpu_gfx_shadow_info shadow_info;
> +
> +             if (adev->gfx.funcs->get_gfx_shadow_info) {
> +                     adev->gfx.funcs->get_gfx_shadow_info(adev, &shadow_=
info,
> true);
> +             } else {
> +                     r =3D -EINVAL;
> +                     goto free_mqd;
> +             }
>
>               if (mqd_user->mqd_size !=3D sizeof(*mqd_gfx_v11) || !mqd_us=
er->mqd)
> {
>                       DRM_ERROR("Invalid GFX MQD\n");
> @@ -335,6 +340,10 @@ static int mes_userq_mqd_create(struct
> amdgpu_userq_mgr *uq_mgr,
>                                                  shadow_info.shadow_size)=
;
>               if (r)
>                       goto free_mqd;
> +             r =3D amdgpu_userq_input_va_validate(queue, mqd_gfx_v11->cs=
a_va,
> +                                                shadow_info.csa_size);
> +             if (r)
> +                     goto free_mqd;
>
>               kfree(mqd_gfx_v11);
>       } else if (queue->queue_type =3D=3D AMDGPU_HW_IP_DMA) { @@ -353,7
> +362,7 @@ static int mes_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr=
,
>                       goto free_mqd;
>               }
>               r =3D amdgpu_userq_input_va_validate(queue, mqd_sdma_v11-
> >csa_va,
> -                                                shadow_info.csa_size);
> +                                                32);
>               if (r)
>                       goto free_mqd;
>
> --
> 2.51.0

