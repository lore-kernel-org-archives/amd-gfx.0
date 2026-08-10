Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFA12C5AE49
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Aug 2026 13:56:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4230910E225;
	Mon, 10 Aug 2026 13:56:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vINc1si/";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010013.outbound.protection.outlook.com [52.101.85.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 281FE10E225
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Aug 2026 13:56:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fsLhxIXYVJnZ+hw1Fm6nZj6PeeS5AxUEXQREPkGXJLCwn85Aamdhp3Tw3uWkkVd+lTSRWyqP/DJeKSwCjJlNmE8+Rcy5M8OdNBe5wyaeBGvBUwVmKoJOs9lbfX3bbQxtbapRz4XRjIso62kYgencUQF/+fc0UHwF5b+gOexAL4Y/Mk7PA/8nZXerXQV423bgkP7pNTcD/tP1afxoTqmgwvGYn5qgI7L3vUgpHXK4kRp6tgqWI8knUamtuGRH6Q5p68DfY0l3JCZh/HUg7B+hSQx8fwvSB4Eiguw2VqJPgUgV4jHcDpu5XeB6kcyRaMmA0oS7zkp4Jthipr6H6DUWRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b0+L75hFcjXUZUW8+O8hcqMFC+ELbYv+ZdUywDIEuDA=;
 b=TDUlSbmZNzhQ38kDer1suZtJxKNSyPbpMr0RvZqP3wtUHyIZwf/UQnD0/9GkOPX5Np3CB5a8r8MclelGVlGv5KGpxITdRL1sMpysIQEsYFJlEwatSpUxFoIsIxU/qYfccB0VJ9AlwZNMC1CQY55fCKJK60ZnI3DLL60/163LTJosYPmSgZsIDhBA6ZwAjofGpl3qzJllMvzE3uesTa6J9QTL8GEJpBhCP4w4gS6SgD6f2UvkOq2QezSHVRXB37exP6gq32+t3ZX0alttT19uCwMS6yVS+Kp/r1Z8YgsKiqEW47Sz4seMxrwxBnd7X4dZ0batxTKJhO+IsRkvcuXdOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b0+L75hFcjXUZUW8+O8hcqMFC+ELbYv+ZdUywDIEuDA=;
 b=vINc1si/+h8SRk1oppGY1YJ/WJ++VzLlYqfZsgKxqb2eU1OsZzuEu4EkDJs4TioghhVXQs6ew39OeSNbJHfsORpuqDY1JRPKNR/2ELbMOGoa7f+VJUHPOifvYOMyLnZFHbsVyYrNWZP9Q/f1WXLlcbiBd9cmBJFbchrTknnaR/o=
Received: from CY8PR12MB7563.namprd12.prod.outlook.com (2603:10b6:930:96::19)
 by PH0PR12MB7864.namprd12.prod.outlook.com (2603:10b6:510:26c::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 13:56:53 +0000
Received: from CY8PR12MB7563.namprd12.prod.outlook.com
 ([fe80::5507:4e0c:e2d0:e6cd]) by CY8PR12MB7563.namprd12.prod.outlook.com
 ([fe80::5507:4e0c:e2d0:e6cd%4]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 13:56:53 +0000
From: "Clement, Sunday" <Sunday.Clement@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Yang, Philip" <Philip.Yang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdkfd: Reject zero-sized AQL queue allocations after
 size halving
Thread-Topic: [PATCH] drm/amdkfd: Reject zero-sized AQL queue allocations
 after size halving
Thread-Index: AQHdJbXcMgZUsEwrW0mx6ja6TZiM9LaXVLiw
Date: Mon, 10 Aug 2026 13:56:52 +0000
Message-ID: <CY8PR12MB756360FD174A0E462E2CA9589FDE2@CY8PR12MB7563.namprd12.prod.outlook.com>
References: <20260806151103.122321-1-Sunday.Clement@amd.com>
In-Reply-To: <20260806151103.122321-1-Sunday.Clement@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-08-10T13:56:41.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7563:EE_|PH0PR12MB7864:EE_
x-ms-office365-filtering-correlation-id: 9278a62e-cad8-4f1f-c773-08def6e73b98
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|11063799006|56012099006|10067099003|6133799003|38070700021|18002099003|22082099003;
x-microsoft-antispam-message-info: HELN53qULuu3F6fM+S5NdlEDbksazbF56GDOXRdb69RWZolN15wtIdkO7NgoF92ZKp6w7WelF3zEWVtpNVozL7xaF3y2MsbicR0nGYhQls+vkTEsVuLRA7Boy/k+T6Eh/b1QwJaXBKAI8J13ovFlO7VwuD0Zowak9x4AKcz9rMIqPHL/aKqfl7KVEGHfpv95c03DHYu+L2NvATUXGYgmVhJHopfhxiWNzmCV5p6L7neXzKrlkWCh3Cu0ZYZc5DEXeZdHuVLXtsmbR5c60g5+PM7eSGaSI003a+D6ZpWeFYXHlKA17gXcB5bVR87maZN0rKocqhKHdGA09t7FnTskDoL7wO7jeASUxgEvY3dxloarDMx4wX9+Bf94FEfaPcsyX1pFz6NhKy82DVW3fzT5K+M/latOgWBeVT0nj/EBBLyNTlcDWBA4zQrQTMCQSgCqLwHkvg8bo7MkloYwcMQCoMlRegXCPDYNKL8cKLdlGPLsM6gPAeUdjc/EC0RQVO7r6nJImtOt00DiQ6pC5rU9S2S0RDA2bCMzgyOBWZ1iFddvWcNShF+r+/lu5FvyGYPSC3vQ6MvbDMK4CtwIBxiYm+KZVP/Wug+9UpP4u77y4b+ruUUg0qLzc3OUEPOlvQ1Wqrlbt8cRncPyBALlpcKpN26gq0u+qwQ4S8qqrXelPo7YKBu43RQ1yKUmWZt+8WAfRz32PYCRr7g321F2WcqMo9a5AB3+i7mCTPjYXB2Zn4Q=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7563.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(11063799006)(56012099006)(10067099003)(6133799003)(38070700021)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?L9dvAaYkhKINsS/ZmLtPBIzCxmx54KFnRZi8MvrdA5QemwD4aB218SCc65s2?=
 =?us-ascii?Q?N7pSso1a8g0xqCMGUO4V8uNTTz5LAUnzDOlVcfs2A0dHt8Hrb+1iZXN8Wd0C?=
 =?us-ascii?Q?pHBA69/izs+6C99yoIeGQ+mUlYec2U+DkpQB7+Ba2MZt4fLX2oeIYSeEJr2u?=
 =?us-ascii?Q?+Lm9fnYhT1KX4js9b1lHOQcMsY/J5pjcNtG5aF04QaQoa49iwSlP8humCPnG?=
 =?us-ascii?Q?DMsdpahgbMw9GxNrw6n3h1ugK7CcoSy6EE9Cq0tP5kr3VlDlC5zSgb6RBFDy?=
 =?us-ascii?Q?JnrNwVaV15VaZrIqCzizpYI9PPlxj/XCgTPi1tvNs4g5N1isIhk1TXo8IfSa?=
 =?us-ascii?Q?sqwTvubxytDwIohyz8R/TYZebBxEC7EV0Zpa0P5ezGFWlRLyCSNfK4Ona8Yk?=
 =?us-ascii?Q?4Y78mHaK915Gs96OeX1xKW+8KPtv9z2Pt/S+PHeu1AoCS/0LCltMhF+EwRMJ?=
 =?us-ascii?Q?tZ7/2nM/qMD6i3Rh9J5aXPBiSXDDHMLnaYLnyp3JiYGrj2R4bEJPQhiyR1vB?=
 =?us-ascii?Q?5xXUsTV9iKFQgatyr3wIrEQgFxp1cfMl5Ge/3ZgJWYFgy0zOGB4Wu4kmL1wK?=
 =?us-ascii?Q?OUuytA859+/bXVQRBOGo6iaYHBUTC2dHYl2twIKycIssIUazJVkflYPVhht+?=
 =?us-ascii?Q?WOr+zb6WE6X81el88hxNN0uWWFi4aP2vYt7qjJONT0jlDLhXrdKgpwh/c1Jj?=
 =?us-ascii?Q?GLd1d+cAMCn0VmOxfb76pNfo2pSEkXboQoXca5q3NX11xiVtDvT7cL1prjLS?=
 =?us-ascii?Q?FezY8ldnF1SDttUMPVWpsK1GfEE2ghUEinVLnYXMGncGsKJrZ1aUbm6V1vXt?=
 =?us-ascii?Q?jCT7qWXGytNmDcRIffvW65f2npMlNo3BQbTS9lQQeUcF6ASfac6uJhYbVFlJ?=
 =?us-ascii?Q?a+7ULuL22ORFdVu9vImGTrwSo0ER9CN9ooKg525P6fNICMYELA80kekY9ULf?=
 =?us-ascii?Q?McucnwDorMd9IgPeBQFwHHaP5B9rOt4XFxuzYx/4ZhQgN3v52aQY0ltEvjZi?=
 =?us-ascii?Q?JcsIQEc6iS1uXUAfZIuYqbz7regEmUldrew8xsnMwfkqHLkPQb6+e99/qzrT?=
 =?us-ascii?Q?0+2ZaBTwat6XR2f0BWhQQQc0stOyZPv1qxofjsFF1wM0C8ZUcF/RtHTxJL+H?=
 =?us-ascii?Q?TDAT672tyeSViJGNzYf3T8cGFMTws4MP8fxYwsFNcuoLA2XhT3GYq33LCyVt?=
 =?us-ascii?Q?0h1BOxgMMov3YhnJUOQcpCElFJrcJPR4y4mY3PbgitK/8Ui1BMqFRKQ1eaqd?=
 =?us-ascii?Q?X8I7PgFfaqCFBX9dmzmNhhCg2doKgWZvMTwMt8IK9Hob33XZYO3FUdNCy+C/?=
 =?us-ascii?Q?+qQG57R5ApRaULAVlJ1WOrqFjHaBNuenxhJoqq5vSZO/hacwjNvcQxjjW7u0?=
 =?us-ascii?Q?1HTJrlqFVNXaxLTRkO/om7ZtiLuKIp/pdz1MmTaoDLroPcapmehWfouwZHE3?=
 =?us-ascii?Q?1QUxYEim2gFp385kQNJVppZSgzeRwMuKRdtX3izQWfFkeZWRif7dwcvHPVAI?=
 =?us-ascii?Q?lc9wd+URgJoW4t4277B6Sir7yN6Zb3fMDPfIS5zJh3YyJ8vaWafhbKvCQ4jl?=
 =?us-ascii?Q?uESh+svC377Zh5zExYo/kE2/F6jhLpf3kApCoA5ik2T8MprUZ1wdzbjXhL3w?=
 =?us-ascii?Q?wxPeD921+phCUs1KaJZjdNEzwITxS625PskINHmmh8a/oQwrZGxsrOzLv2Zo?=
 =?us-ascii?Q?pTR3xrBlEKuSH0r2/FnsVuf0eORnrryo8GrrTxqsooXd6HSl?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7563.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9278a62e-cad8-4f1f-c773-08def6e73b98
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2026 13:56:52.9270 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7fYLpPB5ascnV20Cdeua8Ujf0oIDz+rj+bYppK3iGNKOEoBTIwRe8zyQGNvEtYW5u4lBOlCjbNaqklkmj4wf6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7864
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

AMD General

ping

> -----Original Message-----
> From: Clement, Sunday <Sunday.Clement@amd.com>
> Sent: Thursday, August 6, 2026 11:11 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Clement, Sunday <Sunday.Clement@amd.com>; Yang, Philip
> <Philip.Yang@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: [PATCH] drm/amdkfd: Reject zero-sized AQL queue allocations afte=
r size
> halving
>
> KFD_IOC_ALLOC_MEMORY_OF_GPU with flag
> KFD_IOC_ALLOC_MEM_FLAGS_AQL_QUEUE_MEM and size=3D1 triggers the AQL
> wraparound workaround (size >>=3D 1), reducing size to 0. The resulting z=
ero passes
> through PAGE_ALIGN(0) =3D 0 without validation, bypassing the per-process=
 VRAM
> quota check in reserve_mem_limit() (vram_used + 0 > vram_available is alw=
ays
> false).
>
> The fix adds post-halving zero-size validation in the primary allocation =
path
> (amdgpu_amdkfd_gpuvm.c). The check happens after size halving but before
> reserve_mem_limit(), and uses err_alignment_size error path to properly c=
lean up
> the allocated kgd_mem structure and mutex.
>
> Signed-off-by: Sunday Clement <Sunday.Clement@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 6 ++++++
>  drivers/gpu/drm/amd/amdkfd/kfd_chardev.c         | 3 ++-
>  2 files changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index 1e71829e0fc6..90a4a68478f8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -1795,6 +1795,11 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
>               size >>=3D 1;
>       aligned_size =3D PAGE_ALIGN(size);
>
> +     if(!aligned_size) { // reject AQL queue with size < 2
> +             ret =3D -EINVAL;
> +             goto err_alignment_size;
> +     }
> +
>       (*mem)->alloc_flags =3D flags;
>
>       amdgpu_sync_create(&(*mem)->sync);
> @@ -1886,6 +1891,7 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
>       amdgpu_amdkfd_unreserve_mem_limit(adev, aligned_size, flags,
> xcp_id);
>  err_reserve_limit:
>       amdgpu_sync_free(&(*mem)->sync);
> +err_alignment_size:
>       mutex_destroy(&(*mem)->lock);
>       if (gobj)
>               drm_gem_object_put(gobj);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index 309510e23315..bb0a2c615326 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -1200,7 +1200,8 @@ static int kfd_ioctl_alloc_memory_of_gpu(struct fil=
e
> *filep,
>
>               if (flags & KFD_IOC_ALLOC_MEM_FLAGS_AQL_QUEUE_MEM)
>                       size >>=3D 1;
> -             atomic64_add(PAGE_ALIGN(size), &pdd->vram_usage);
> +             size =3D PAGE_ALIGN(size);
> +             atomic64_add(size, &pdd->vram_usage);
>       }
>
>       mutex_unlock(&p->mutex);
> --
> 2.43.0

