Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40A50CD8C92
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Jun 2026 03:24:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B676E10EC74;
	Mon,  8 Jun 2026 03:24:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mB4D38Zi";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010058.outbound.protection.outlook.com
 [40.93.198.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E17F10EC77
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Jun 2026 03:24:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rmbKAcMfNn6rT/UJVAe37jBz08AUQbM6mBrCD+GTPI+3wy9AYA63c91mXkp+ExcQz8edylRAJrk/ZGqLTR3epzENYQWxZf7UODkuPFxMSYNQIITHj2emTY9UOLE4oSHXFOxNJW4I13srVvc/wbCl1EzbLqPsOV2Y1lxA7t1CNSwMCT6DNHPtyM2axnBqQ0eqFiLGHX1M+o1yvdVSoC3bY4HemKWmBq4zefuZxve6FspCkz9hLhM9sUflcglflzhXjbmJ2+bjvQCBKDwu9gTm91WDPcVsTw9b31F9KulUUsUt1wwFMWy4hrTp0IG2v0ATsCfIFWtDzGajQja/cemfYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KMtB6eZ8/fF7dU95tSCgeO8HDmSYCAyFxM2I48FYrLI=;
 b=h94bzOQt2zbddbd12BobHdWunguKM2THAnAUabalQtzEeF41GBpXy9vd0ffi23eWGwqTwjJ9FHYCChWkvvswXpya4L4KMmv3COCJFJEHD49b814iRQYbgIleDUi8sXNohDgTMVyyiTy+aZzIsdrXiDLlp24nbXq9S1zqWfEPP0q3ybw3jilCtybvPtiVZmtN6Lu5uoJxbi03JRlbZ7sPtJCAg6ERER8vGG8aKuVjyL3d4xC5m7ojJ7RqBLtWw1A3hr2Y38zHyf8HQb5oc6cvh62yEoSwU3BL2iyxmEe3u6Dyh8qoc6/BNc8k4lA4uFo002S5jrsKnC+hLq4l6J7oCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KMtB6eZ8/fF7dU95tSCgeO8HDmSYCAyFxM2I48FYrLI=;
 b=mB4D38ZiPoC0wRQwJkKyRNGWKO6XP2C4RVdivvrowBk7O1oADQcV/WKGUqH7dD8M8SWqGkYJ5sQhoJlPgq6LwbEjQ/L+obVNDblaxKz0Zdv5i6BCQVCATTmpX/DMR1aZxjM86HU+aCVyW3UY99yDHo63W0vwBgUc8WHGiKSox4s=
Received: from IA0PR12MB8208.namprd12.prod.outlook.com (2603:10b6:208:409::17)
 by SN7PR12MB8601.namprd12.prod.outlook.com (2603:10b6:806:26e::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Mon, 8 Jun 2026
 03:24:29 +0000
Received: from IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::dbd3:cc22:a850:dc1e]) by IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::dbd3:cc22:a850:dc1e%6]) with mapi id 15.21.0092.011; Mon, 8 Jun 2026
 03:24:29 +0000
From: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>
To: "Kamal, Asad" <Asad.Kamal@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>, "Ma, Le" <Le.Ma@amd.com>, "Zhang, Morris"
 <Shiwu.Zhang@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>
Subject: RE: [PATCH] drm/amdgpu/gfx: fix cleaner shader IB buffer overflow
Thread-Topic: [PATCH] drm/amdgpu/gfx: fix cleaner shader IB buffer overflow
Thread-Index: AQHc9QLqznVkxftv806NnQmqfVeqlrYz/8zg
Date: Mon, 8 Jun 2026 03:24:29 +0000
Message-ID: <IA0PR12MB8208D94B8C68E8301C9A6C71901C2@IA0PR12MB8208.namprd12.prod.outlook.com>
References: <20260605154920.1314590-1-asad.kamal@amd.com>
In-Reply-To: <20260605154920.1314590-1-asad.kamal@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-06-08T03:14:25.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR12MB8208:EE_|SN7PR12MB8601:EE_
x-ms-office365-filtering-correlation-id: 1b1f4924-9913-44f6-315f-08dec50d738d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|11063799006|56012099006|6133799003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: tkG/kGauixp+GVQZvwJ5n2844iAlfryJzOuBjoeTreLQbVYRE4Tlg84+KH8Y+q0wjc5xzk8TEBZNRKFckFJN/6Dba+VPmLHzWtQLDfozmi236n4SgimlJMkvfrw5CpggjPjGAEmx0fR3lI3WgviYrpkiRZCpUZJc7fMMz0cIPTKSXv6KG+Zu+zGS8e3WuG/aT6js0wYVkAHZpzIigPmXiCIx6vVZBzj3BIqgxhVkYwY6FPCu2b50fpens/QtbLVYKrB4/A/HOzxPwSrPLEwFjNRoTmZte8Q3sITSfAXdKaXf7G2BlbNDRLe+Oe//QCyVn3Y4/MfwAN0zIFoByRx0Q7PZeAPbZcOil5ryls/bST+97eSWEy+LqZOsQBAZMbRHgmAOeOMt6IW8ilvcTf/dNdSZK4EQQwpBUYWAnxKohZQHUYsjRam0NeUwEnNvJugcAVyThh0B4JPWaTV9By2iSqBmxj+U2L7nntBBs2xxgIxaupZ0xpQ+NqfTTmA13+w4hbkaI7mUITYM0Zfvk02l3M6kTwoJvdlY8vKdLlnQR16mVcRylkoonLq+lNvx8tsZx2CQVDQHtWXPXaOHt2RLgd65esavuae6Ezr7bAFswb+rCk9hRjY0RUWHqHnVbbKr7ot+A91ZvUbOFNV65Sb2RIHRu5Ru8g2jqgo3wRYPhZ9E79SGIUxXU3IrRI+iYVSEo8JGqFDLQxA+KZvhG23yuychllKubivxfODezRTpxk1BiQVK6v4Y0H6U9qAqQ/iW
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR12MB8208.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(11063799006)(56012099006)(6133799003)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?yG9hA3DF/FTHCPTdCegPl8tfZ+bxfbaIDHqG5Bvy41i32RrI0kRYqQf1tejn?=
 =?us-ascii?Q?HTf25Akkf0v9r9u3q/qAy0VUKV0QBjVRvXRFOUBcKfyWS0Gyap3hozZLBOXD?=
 =?us-ascii?Q?o7qTEV4YV4A10PXr3Mg4y5+F7ypI6DFSy+aNwNu9edsBD85Ogqq3U9tixMIl?=
 =?us-ascii?Q?XGtrmMCg7aosWf5oAPWdPaifftwrKfVtfMya7K+Qy1x8Vq36oA1nE/reVpOp?=
 =?us-ascii?Q?dtXa7v9weBCnwsoDKU1vphXa6OKvRe9V/st0oAilf6y/qqZ1wzZ235YtBYF1?=
 =?us-ascii?Q?9+GLi4e+uf6yzcJ2vBw5s3EzL81gKYtM2f5N1p3fOKlk69lEJkYe4kWFQthe?=
 =?us-ascii?Q?7TqQcYB/K+Xt7sG9v9PegS63dCa/cdT8n8rKi4Qo50ymfoCDsJ9cEJcVDvjO?=
 =?us-ascii?Q?mKNH/Ix/F9KWSRDkwoTJs88vFFTQJC32pHev+I31FLB59zpNc5xsyiVc+CHZ?=
 =?us-ascii?Q?lTi4KkoaBGutKgSo75/WwNwGxgb29rXLB1IDN+k36angBHNhqu3kwDexhAe1?=
 =?us-ascii?Q?CnTcJiZ9aBweo/hdPMbc31BQcfVIyGq5O1hnnwk2Hep5Ss+NQ9sZevhHnl/l?=
 =?us-ascii?Q?+Q6K5Qsh7BK6oo4oXRRqc+oLRBCMYWP+PxhmPFSAWOSPnUPD1N93z1eMfWz7?=
 =?us-ascii?Q?Uu5QtThr/4IcGXFxXVqYD9IrAZ498hr9faFgwC8z//RLzaGxYdaJr3eto2ag?=
 =?us-ascii?Q?GhU+aDlqax56WuGqovhHvIEsgPxtu2V/M5HV1LefCjyoI9hRZ7V7wM+MRIhv?=
 =?us-ascii?Q?b9hVelxf9v1uASX1CrZtjyk1lfxrfEPvj0hq01bH1aHu4Vp740sOjcIVyila?=
 =?us-ascii?Q?BYP6ez65K+RMYXoYDhXEC2n7qd3mzs3RTU6bK5I366ptkFLPFTSfuZRk8yqY?=
 =?us-ascii?Q?g2tXT6izJRN5z9D5QAIzl0uI1HCdN45lzMQZglvjI1uEku1UoxwMlx1q3Kpu?=
 =?us-ascii?Q?HwRddjcVbmg5WpO1JHbITKIRlM3imnvh0t8SSBRQ0oZeDCFwbLkgiAUyS77N?=
 =?us-ascii?Q?u8HXCPTt7Z9p6WPXl+JvVgFkZ2W9GLmKwBvAFEQXnI/jxWoltjferA2TMQyd?=
 =?us-ascii?Q?iPJa9wbhiLPLb6FZpyMXKa0fIz9oL2S9rcsTUvFsf7xokI5ASIhUxihT6hbG?=
 =?us-ascii?Q?Czj9wsXfyH1fDdHra9MI9isqapflJWCfb60CeQUKHujSw8hlO6CJFiLmDiGP?=
 =?us-ascii?Q?bo4CEy6AIr2sTEwcuadh7+iIywxWqr3UJa5BwsdKwvngKk+vdMuAh4wHV7gU?=
 =?us-ascii?Q?1EHeryln++7oM7Ca4rLkriiLOv8Q0CBETcXYZucdS0b8CR1W25YVSgzJj0K+?=
 =?us-ascii?Q?3J1F8mKAVHDFiaIwoN2tjEcbGud01IXpF/G9bcTGlm55J49buLQgEsDRURTL?=
 =?us-ascii?Q?6tBa/9ZIakNEGrQ2iKSclI5aL/RAWO/UAUw7hj7szV9bu+Rpa9jGQvv90hHY?=
 =?us-ascii?Q?F0WtVyZ4S0aZSGhBuUkz1lyd9cZWl7c0BhD8Dyf8lXRJXzHBtvuKDy64XCws?=
 =?us-ascii?Q?wd/B7IAUgvYFvawaq0KwAZ45XNnA9SSHbPowaQIM4e2qqa2jcOpF6wdgEre9?=
 =?us-ascii?Q?4+zNqgbxt+tT+slNmyctVUMaEg1XU+t1F1ob8/eyBzH7x+ghw46PikZ4wFSe?=
 =?us-ascii?Q?gAYRD9zKEiZexbPw6WiMQlwuzevI++P7scR9TVsIe4Ka3SqzyoakyUJdmEy7?=
 =?us-ascii?Q?ADgAXcPhb3RNMGS3qSDOdZDaiR0wYg76TeGhkQfv8i8nKfEa?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8208.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b1f4924-9913-44f6-315f-08dec50d738d
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2026 03:24:29.6570 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8xujCtlx4Nl92MZloDy5xJCcQtyalnzXaK7iadeCmT81X5mK4Px6AsVoFC8PWxhCXxQrBu26o7A7JiTa0Gi1AA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8601
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

> -----Original Message-----
> From: Kamal, Asad <Asad.Kamal@amd.com>
> Sent: Friday, June 5, 2026 9:19 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Lazar, Lijo <Lijo.Lazar@amd.com>; Zhang, Hawking
> <Hawking.Zhang@amd.com>; Ma, Le <Le.Ma@amd.com>; Zhang, Morris
> <Shiwu.Zhang@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>;
> Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; Kamal, Asad
> <Asad.Kamal@amd.com>; SHANMUGAM, SRINIVASAN
> <SRINIVASAN.SHANMUGAM@amd.com>
> Subject: [PATCH] drm/amdgpu/gfx: fix cleaner shader IB buffer overflow
>
> The cleaner shader sysfs path allocates a 16-dword (64 byte) IB but incor=
rectly fills
> (align_mask + 1) dwords. On GFX rings align_mask is 0xff, so the loop wro=
te 256
> dwords into a 64-byte buffer, causing a kernel page fault.
>
> The IB only needs to be a minimal NOP shell to schedule the job; the clea=
ner
> shader itself is emitted on the ring via emit_cleaner_shader().
> Fill 16 dwords to match the allocation.
>
> Fixes: d361ad5d2fc0 ("drm/amdgpu: Add sysfs interface for running cleaner
> shader")
>
> Suggested-by: Lijo Lazar <lijo.lazar@amd.com>
> Signed-off-by: Asad Kamal <asad.kamal@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> index ff5a55f5f3c9..f2c536929446 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -1694,7 +1694,7 @@ static int amdgpu_gfx_run_cleaner_shader_job(struct
> amdgpu_ring *ring)
>       struct amdgpu_job *job;
>       struct amdgpu_ib *ib;
>       void *owner;
> -     int i, r;
> +     int r;
>
>       /* Initialize the scheduler entity */
>       r =3D drm_sched_entity_init(&entity, DRM_SCHED_PRIORITY_NORMAL,
> @@ -1722,9 +1722,8 @@ static int amdgpu_gfx_run_cleaner_shader_job(struct
> amdgpu_ring *ring)
>       job->run_cleaner_shader =3D true;
>
>       ib =3D &job->ibs[0];
> -     for (i =3D 0; i <=3D ring->funcs->align_mask; ++i)
> -             ib->ptr[i] =3D ring->funcs->nop;
> -     ib->length_dw =3D ring->funcs->align_mask + 1;
> +     memset32(ib->ptr, ring->funcs->nop, 16);
> +     ib->length_dw =3D 16;


The fix correctly limits the NOP IB to the allocated 64-byte (16-dword) siz=
e and avoids the overflow. As a minor cleanup, it may be worth defining a c=
onstant for the 16-dwords to avoid magic numbers and keep allocation/fill s=
ize tied together.

+#define AMDGPU_CLEANER_SHADER_IB_SIZE 64
+#define AMDGPU_CLEANER_SHADER_IB_DW \
+       (AMDGPU_CLEANER_SHADER_IB_SIZE / sizeof(u32))
+
 static int amdgpu_gfx_run_cleaner_shader_job(struct amdgpu_ring *ring)
 {
@@
-       r =3D amdgpu_job_alloc_with_ib(ring->adev, &entity, owner,
-                                    64, 0, &job,
+       r =3D amdgpu_job_alloc_with_ib(ring->adev, &entity, owner,
+                                    AMDGPU_CLEANER_SHADER_IB_SIZE, 0, &job=
,
                                     AMDGPU_KERNEL_JOB_ID_CLEANER_SHADER);
@@
-       memset32(ib->ptr, ring->funcs->nop, 16);
-       ib->length_dw =3D 16;
+       memset32(ib->ptr, ring->funcs->nop,
+                AMDGPU_CLEANER_SHADER_IB_DW);
+       ib->length_dw =3D AMDGPU_CLEANER_SHADER_IB_DW;

Thanks,
Srini
