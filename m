Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80152C3ABBE
	for <amd-gfx@archiver.kernel.org>; Thu,  8 May 2025 18:32:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2848910E073;
	Thu,  8 May 2025 18:32:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hCTUWa0a";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2061.outbound.protection.outlook.com [40.107.101.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C1D0110E073
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 May 2025 18:32:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D9kfxR4vOkyI7ezHZU4ZZQRyM9/cJ5k05cno/Ishg7si/ArnG5auZY8S03jKxv8R0TfMB8JqqXCL/QfFX8Fw/sl1d2pY5pg02mZZggnTcSDNi7ZC+xY8jJbBMMBu8YczB1uDH5Yd5KwKiftLU6DVWHrB/7M8YRM81/3pcTE6pMFiAtXg2V4P4PX8vb+hTvRkmvGoctTsjzOwTYKHAHnHSxOQsmfC4MW6XOsxsGggJ/rPOoEImXYeirwR+VQ4IHBaWWRlvkQf++NdyJANKIOkg6tU6UXqmy37uWBhOH3xb2GdqHmXQf76rpMCW4WqD8Zm4+0Ppf+qgcHPSUlpR1v31Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FfR/s/3DA7lp5xAwbvfIHwXL54WzPEFs0xd46TIffZU=;
 b=jTsy7ns1ghjkA7SfCEGeGiquMzl5h1taKbQ/uB5qSsIvKadSmIpFt2sd0baedKBUA36d3S/kEJ1qW3pm6DXHlYSD6EH1eP0ypT/qfVZmnhCJW83sfGKc4XsbxKXCtNZMGdM92+3A1qJyoPoqpJ8N225N21APTisj4EK/EbmcslMVBG2ojZKevb4paru6fNWjTk1X9ocXInGwB8bzpr7Hqqk3dmHr/M2Tdd2bASnGyexD612SWuhQcNPvMUS86VqtEoeHtltpU+gLKGVpJ9zReZhi+Jy4X+1Oxxn2Vj0unJxw/OL6lDiwWybwUnqOyVR+bHacPIBSqiXVR9ennhwi4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FfR/s/3DA7lp5xAwbvfIHwXL54WzPEFs0xd46TIffZU=;
 b=hCTUWa0a9TWCFCiG0aThCg4dId9NMmQF7ZjsUWYWJr+4EF+xmEptD3wBvkaH/KAVA89lpNdDtCPhw9HKIEsG8B7FQO/Mh4cSIaVzPHJpDj0QJC9iFsPLnYJTla8Q0yQjtjIFnybtMGcoQ7rBLIVhH8Tol3NDEpW5XkZ5dsEE3lY=
Received: from DM4PR12MB6279.namprd12.prod.outlook.com (2603:10b6:8:a3::11) by
 SA0PR12MB4480.namprd12.prod.outlook.com (2603:10b6:806:99::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8699.32; Thu, 8 May 2025 18:31:57 +0000
Received: from DM4PR12MB6279.namprd12.prod.outlook.com
 ([fe80::9456:1ddf:948:5d1d]) by DM4PR12MB6279.namprd12.prod.outlook.com
 ([fe80::9456:1ddf:948:5d1d%6]) with mapi id 15.20.8699.026; Thu, 8 May 2025
 18:31:57 +0000
From: "Chen, Michael" <Michael.Chen@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
Subject: Re: [PATCH] drm/amdgpu/mes12: rework pipe selection for legacy queues
Thread-Topic: [PATCH] drm/amdgpu/mes12: rework pipe selection for legacy queues
Thread-Index: AQHbwD4O9dRG1jIpNEiCN+RJZSQyqbPJDLr/
Date: Thu, 8 May 2025 18:31:57 +0000
Message-ID: <DM4PR12MB6279EDCEC972305A5809AD87948BA@DM4PR12MB6279.namprd12.prod.outlook.com>
References: <20250508172409.3183469-1-alexander.deucher@amd.com>
In-Reply-To: <20250508172409.3183469-1-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-05-08T18:31:56.891Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB6279:EE_|SA0PR12MB4480:EE_
x-ms-office365-filtering-correlation-id: c9c60457-fe2b-4fe9-3ff9-08dd8e5e9d4a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|8096899003|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?MML306xLYzGGVApcYFtpNa98PqBbaEtZ39Fl4CH8l0/7qmPnEXN+EkZMQ7?=
 =?iso-8859-1?Q?FL3KbkOh1Upr5XSSq0LmbHraY8etVMxtnKaPuteuwd5noR0EFH3MytJOiF?=
 =?iso-8859-1?Q?PqDw64PfJfG9881El64Bjtff+ub/6T64zTrDd5Mi/h8BB/wDTBwKgFM57m?=
 =?iso-8859-1?Q?rYSPLBISu348J+xT1eftvr/Qi5p26SKCKAwnNi8DD3F8RLkD8xIulq7mDa?=
 =?iso-8859-1?Q?dULTgX89X7hwmn3ShlEI6oHkld+DkNOxeMUjytDZcEjlyjIEXr6Wr5f6h+?=
 =?iso-8859-1?Q?G6b1Ag3FPsu3OjJCCjk6ADG05lfGpWMZOtF6OMdiPWN1sLexjcoeHCI6Rz?=
 =?iso-8859-1?Q?jFkJavBpeqDQ7G5JeH1CBogap5EmhfNaZD2JYncPXgwaM0kgGjX9bNo3gn?=
 =?iso-8859-1?Q?fqaeSdjWc98+2VToups148/JQ+dZ4JqcxWeSMh/c8OxP3EJp63QNtM6qpR?=
 =?iso-8859-1?Q?QZoEbHEr6+1FdVGbTgAvuV/+ha0GDIVelIc7kvLKIMYFLORLAJ6vgDQorG?=
 =?iso-8859-1?Q?6vkmPingq6aKb0/2SNn5p7FTlwYThMLfumV6p+sl5Qkr3fW9qZG5MAzY4l?=
 =?iso-8859-1?Q?14UvLLpqPdoI6u+b/spOaY+hOl8KCKWWr6xYZewRYKA64mCZXIJkfTD+yU?=
 =?iso-8859-1?Q?WutFFYOmNsB2qiSYPQL879bGt77lj7j978OV4nSaqa7J1+WxAl3lKpeROf?=
 =?iso-8859-1?Q?llsnN0j9AOI9Q6tdqjZanf9ggIzAdlTevQZzJP/pcPyGHCiWFPGLuacQRA?=
 =?iso-8859-1?Q?0rLMlnCmyjJZZ/icgtN/imqwe3uq4wWjr/cf1JSUaS+LJ7fHNufLoRkLKc?=
 =?iso-8859-1?Q?//ylSakpF0jfKsBbX7tknMBpwmUxHt9gXQwPuKMPFzbF6X6g4UVAESrvQQ?=
 =?iso-8859-1?Q?U/jBqhemW0jp8fUwCH10FB6pTq2Q+Xkhc3HMlZ6mUn68h0YVt0g5w8NITQ?=
 =?iso-8859-1?Q?9/NJgVi1CT7Qajm1BrPE6vwpkpPbrOZbJ+fE2tlJjZ6N4kYXE7AeNlHC9s?=
 =?iso-8859-1?Q?hzjzXGcsLeJnfhUy1ATbFh0lm/a42zsAuhWLCKJ2HgGadYlsrkLa2/Pz79?=
 =?iso-8859-1?Q?dPQW1G3wDkgAAysXU1TUPONz0kMMg5XsYVxOtKZzdAEOtX+OpwLhTFxlG5?=
 =?iso-8859-1?Q?EE8Pecp5Ad4h5NTU0BbbU9vRruoMX+cFdJiQqA1cmTGQ3EcJoEpswCgyL5?=
 =?iso-8859-1?Q?MbiWMGdAN/MbD6v9yk+157ioL5UEB0iwgnp/V83/w7yqt33lDeUeU5fWVe?=
 =?iso-8859-1?Q?SYolyYXRhxuDvpOT8qnNkIlTt0CJEcubwPaRtl8yqp3i7uzA2k88Uw+Q8l?=
 =?iso-8859-1?Q?ieONsXaGN2t1MR9OY9MFTPAs3MP25ulxHOpoKydH6uVCXP12dSXGOMu4WS?=
 =?iso-8859-1?Q?JiIC+ZaFiFUjXUmepPSmfKYfSOnTsd55b0vVIVAdLXVKwwZCYvMRa7r5X5?=
 =?iso-8859-1?Q?1I4vWtAnAmguN0tfpvW2CqG02d5jBdpL1jDJLYeD6y0BFc6zLlbUYLyQQd?=
 =?iso-8859-1?Q?wrdhNc0j/skCQ7XyQgLznDLCiE+xC6wlEB4PhM9j+GVbmJhAgAD030dxnA?=
 =?iso-8859-1?Q?CqDn3yA=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6279.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(8096899003)(7053199007)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?JDhy4sXRgKEjTtr1PkKhbpRNRkOZ2bfvGDM6n/5r/dSbraGavMY+ZBdHCz?=
 =?iso-8859-1?Q?CDxMw0uLMhUWBt733wDX4lGo1U5UA8dyqL20dnPJQlAtaz+kogSsG0tDSV?=
 =?iso-8859-1?Q?rgZuBrdK7P8zchK2Jv85IKPtSVRpmrIZajrTQnieW4Su0jmBNiuK445BSK?=
 =?iso-8859-1?Q?ZA6wrWMC8MrINqYZX5jziKLBVHp8OxpR0xht4I9DKNytyz+NovUOR6oeo/?=
 =?iso-8859-1?Q?BBCsUlpGS3MkeipvVV6QELgTXG/RvPl+cbR4h2SmiJ8YMmkOywvfJabmGu?=
 =?iso-8859-1?Q?Y2PYR3ulPuIibb6VIRRC7bejRsl5Lg3QmowvalC+8NNHsMXzWHCmqdGHVA?=
 =?iso-8859-1?Q?B5fzpySzV38p8Cy5c8GFAQoljB2KG79gVqdkPuUcVSQyY78xDzJNWpzgk3?=
 =?iso-8859-1?Q?jIEABBRmDOQA0QhDKSxNGSw8S+4PJVvOw2yK5fVNqXTiymEpePYeGLhk3q?=
 =?iso-8859-1?Q?5i0wc8Xmfj8yAQaoh9w4ug0tVzN6j9o94vzdJiluNw5m8Qkm15PmZIT6ge?=
 =?iso-8859-1?Q?0ANhCZiFbJT1Fx9wO+gaopaXWx6I0gJo6vxtsczcXZ0MOd267kYLAvD3V6?=
 =?iso-8859-1?Q?YgfVuF8mMHUszpZDxkwq+98pZL6dNit/Qir5FVNCAz1aWaPXttWIMACC1b?=
 =?iso-8859-1?Q?gaDgLeTGfKfk6pprQ8wN4tsr+penCb9NaMeu7ZteqZvWZTPvOXqVQd7rwS?=
 =?iso-8859-1?Q?3m37rVjLqMs65hJqIoVL6XdNzS9PZNDRg+Pwou7ifol2MNd/YPs9MOFbV9?=
 =?iso-8859-1?Q?DuPZrR2u3MrvVbLvyCiqlEri0bJWubQ1H+Ll/WNOD3YzUnhvT5NCFgWLw+?=
 =?iso-8859-1?Q?UJ4De8ZkPBDRwOk/K7GaDuNDALb6qcnLIafkEZbc6jkLDCaneS/8KED5VF?=
 =?iso-8859-1?Q?85IVw3qSV1GcNrn8nSDIwX+D1g4ifVpln0enJv85iHOMwkDl926+ay8ToT?=
 =?iso-8859-1?Q?0Wq7+3C+xMdXjyy3M4ogSZNcJOfvLLmY8dhhHeJJqoVhgBvLEi1GNuEyte?=
 =?iso-8859-1?Q?fFS6XCgD6ILvLXMrdeDgQCMke/YLEYAtG/xZgnG+QeNjoTrk7pWpjFISHx?=
 =?iso-8859-1?Q?Upqu0warhnSE/kWi2gZUnrqkIT5C3QJrGBwbNxBkBVGMYQgyFtKqzaFS04?=
 =?iso-8859-1?Q?5QQhRcNMlw2ftNu/iXuBGnrDyOQ7dsFhlbBuWsSMK3QKcn8q/WuAx/PGqI?=
 =?iso-8859-1?Q?GZqWAab3w4k6DkfrfM1sm9rErHWkYXX1CaZ5KpjDY5hIiwN+hLW7xXucb+?=
 =?iso-8859-1?Q?hgf3tNOD7h8jn8YJ1ZkXNj4iVvA7/A98mJED5InY1X3Lo9FUpQoqgLj5zr?=
 =?iso-8859-1?Q?AyOJ3iU7Fu72q5N/fVqMF0esnK5rvUmkigeDTqesZDZ4/5f8M42cS/CuCd?=
 =?iso-8859-1?Q?JmnYKUpyx2t4ZyapDIu1TOOVhMraJKDf7tXjfYu9/IwsbpCSiq//NzgOmv?=
 =?iso-8859-1?Q?csq3uC817komVc6OMaffvobAh0xLb81W5hJ0eQ4MMZnjR/MllClWlNpcLT?=
 =?iso-8859-1?Q?5JextW4vHWGdqE6WNRkqjldL/FKN+35y9TvbUoZCMyqtZ9SpaxpqKdQu81?=
 =?iso-8859-1?Q?0kPwrTwjXtPLq3k80IdKiWa6W1ROcMmrpcGiKVc4oGV9RpLWQbmvN77jhn?=
 =?iso-8859-1?Q?s3UmacMism2Ms=3D?=
Content-Type: multipart/alternative;
 boundary="_000_DM4PR12MB6279EDCEC972305A5809AD87948BADM4PR12MB6279namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6279.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9c60457-fe2b-4fe9-3ff9-08dd8e5e9d4a
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2025 18:31:57.3020 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 09B66wHnXCr7LyKNP6anb/z4dOspC48125i/7mv0hOvCSkvs2+0hvjeNCrQV1cZr5aE27HNI/6N0r4ElS2QjnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4480
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

--_000_DM4PR12MB6279EDCEC972305A5809AD87948BADM4PR12MB6279namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[Public]



________________________________
From: Deucher, Alexander <Alexander.Deucher@amd.com>
Sent: Thursday, May 8, 2025 1:24 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Chen, Michael <Michael.=
Chen@amd.com>; Liu, Shaoyun <Shaoyun.Liu@amd.com>
Subject: [PATCH] drm/amdgpu/mes12: rework pipe selection for legacy queues

Only use the KIQ pipe for the scheduler queue.  For legacy
kernel queues, use the scheduler pipe.  This aligns with
mes11.

Cc: Michael Chen <Michael.Chen@amd.com>
Cc: Shaoyun Liu <Shaoyun.Liu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 11 ++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h |  4 +++-
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c  | 18 +++++++++---------
 3 files changed, 22 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_mes.c
index 2febb63ab2322..f665daf71780d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -299,6 +299,9 @@ int amdgpu_mes_map_legacy_queue(struct amdgpu_device *a=
dev,
         queue_input.queue_id =3D ring->queue;
         queue_input.mqd_addr =3D amdgpu_bo_gpu_offset(ring->mqd_obj);
         queue_input.wptr_addr =3D ring->wptr_gpu_addr;
+       /* need to use KIQ pipe to map the scheduler queue */
+       if (ring =3D=3D &adev->mes.ring[AMDGPU_MES_SCHED_PIPE])
+               queue_input.use_kiq =3D true;

         r =3D adev->mes.funcs->map_legacy_queue(&adev->mes, &queue_input);
         if (r)
@@ -323,6 +326,10 @@ int amdgpu_mes_unmap_legacy_queue(struct amdgpu_device=
 *adev,
         queue_input.trail_fence_addr =3D gpu_addr;
         queue_input.trail_fence_data =3D seq;

+       /* need to use KIQ pipe to unmap the scheduler queue */
+       if (ring =3D=3D &adev->mes.ring[AMDGPU_MES_SCHED_PIPE])
+               queue_input.use_kiq =3D true;
+
         r =3D adev->mes.funcs->unmap_legacy_queue(&adev->mes, &queue_input=
);
         if (r)
                 DRM_ERROR("failed to unmap legacy queue\n");
@@ -349,7 +356,9 @@ int amdgpu_mes_reset_legacy_queue(struct amdgpu_device =
*adev,
         queue_input.wptr_addr =3D ring->wptr_gpu_addr;
         queue_input.vmid =3D vmid;
         queue_input.use_mmio =3D use_mmio;
-       queue_input.is_kq =3D true;
+       /* need to use KIQ pipe to reset the scheduler queue */
+       if (ring =3D=3D &adev->mes.ring[AMDGPU_MES_SCHED_PIPE])
+               queue_input.use_kiq =3D true;
         if (ring->funcs->type =3D=3D AMDGPU_RING_TYPE_GFX)
                 queue_input.legacy_gfx =3D true;

We are not supposed to reset scheduler queue, so this change is not necessa=
ry.

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_mes.h
index a41f65b4f733a..d1836ad93ccfe 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -242,6 +242,7 @@ struct mes_map_legacy_queue_input {
         uint32_t                           queue_id;
         uint64_t                           mqd_addr;
         uint64_t                           wptr_addr;
+       bool                               use_kiq;
 };

 struct mes_unmap_legacy_queue_input {
@@ -252,6 +253,7 @@ struct mes_unmap_legacy_queue_input {
         uint32_t                           queue_id;
         uint64_t                           trail_fence_addr;
         uint64_t                           trail_fence_data;
+       bool                               use_kiq;
 };

 struct mes_suspend_gang_input {
@@ -277,7 +279,7 @@ struct mes_reset_queue_input {
         uint64_t                           wptr_addr;
         uint32_t                           vmid;
         bool                               legacy_gfx;
-       bool                               is_kq;
+       bool                               use_kiq;
 };

 enum mes_misc_opcode {
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/a=
mdgpu/mes_v12_0.c
index b4f17332d4664..8f2e24ecf747f 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -515,7 +515,7 @@ static int mes_v12_0_map_legacy_queue(struct amdgpu_mes=
 *mes,
                 convert_to_mes_queue_type(input->queue_type);
         mes_add_queue_pkt.map_legacy_kq =3D 1;

-       if (mes->adev->enable_uni_mes)
+       if (input->use_kiq)
                 pipe =3D AMDGPU_MES_KIQ_PIPE;
         else
                 pipe =3D AMDGPU_MES_SCHED_PIPE;
@@ -554,7 +554,7 @@ static int mes_v12_0_unmap_legacy_queue(struct amdgpu_m=
es *mes,
                         convert_to_mes_queue_type(input->queue_type);
         }

-       if (mes->adev->enable_uni_mes)
+       if (input->use_kiq)
                 pipe =3D AMDGPU_MES_KIQ_PIPE;
         else
                 pipe =3D AMDGPU_MES_SCHED_PIPE;
@@ -869,7 +869,7 @@ static int mes_v12_0_reset_hw_queue(struct amdgpu_mes *=
mes,
                 mes_reset_queue_pkt.doorbell_offset =3D input->doorbell_of=
fset;
         }

-       if (input->is_kq)
+       if (input->use_kiq)
                 pipe =3D AMDGPU_MES_KIQ_PIPE;
         else
                 pipe =3D AMDGPU_MES_SCHED_PIPE;
@@ -1339,7 +1339,7 @@ static int mes_v12_0_kiq_enable_queue(struct amdgpu_d=
evice *adev)
                 return r;
         }

-       kiq->pmf->kiq_map_queues(kiq_ring, &adev->mes.ring[0]);
+       kiq->pmf->kiq_map_queues(kiq_ring, &adev->mes.ring[AMDGPU_MES_SCHED=
_PIPE]);

         r =3D amdgpu_ring_test_ring(kiq_ring);
         if (r) {
@@ -1608,7 +1608,7 @@ static void mes_v12_0_kiq_dequeue_sched(struct amdgpu=
_device *adev)
         soc21_grbm_select(adev, 0, 0, 0, 0);
         mutex_unlock(&adev->srbm_mutex);

-       adev->mes.ring[0].sched.ready =3D false;
+       adev->mes.ring[AMDGPU_MES_SCHED_PIPE].sched.ready =3D false;
 }

 static void mes_v12_0_kiq_setting(struct amdgpu_ring *ring)
@@ -1687,7 +1687,7 @@ static int mes_v12_0_kiq_hw_init(struct amdgpu_device=
 *adev)

 static int mes_v12_0_kiq_hw_fini(struct amdgpu_device *adev)
 {
-       if (adev->mes.ring[0].sched.ready) {
+       if (adev->mes.ring[AMDGPU_MES_SCHED_PIPE].sched.ready) {
                 if (adev->enable_uni_mes)
                         amdgpu_mes_unmap_legacy_queue(adev,
                                       &adev->mes.ring[AMDGPU_MES_SCHED_PIP=
E],
@@ -1695,7 +1695,7 @@ static int mes_v12_0_kiq_hw_fini(struct amdgpu_device=
 *adev)
                 else
                         mes_v12_0_kiq_dequeue_sched(adev);

-               adev->mes.ring[0].sched.ready =3D false;
+               adev->mes.ring[AMDGPU_MES_SCHED_PIPE].sched.ready =3D false=
;
         }

         mes_v12_0_enable(adev, false);
@@ -1708,7 +1708,7 @@ static int mes_v12_0_hw_init(struct amdgpu_ip_block *=
ip_block)
         int r;
         struct amdgpu_device *adev =3D ip_block->adev;

-       if (adev->mes.ring[0].sched.ready)
+       if (adev->mes.ring[AMDGPU_MES_SCHED_PIPE].sched.ready)
                 goto out;

         if (!adev->enable_mes_kiq) {
@@ -1763,7 +1763,7 @@ static int mes_v12_0_hw_init(struct amdgpu_ip_block *=
ip_block)
          * with MES enabled.
          */
         adev->gfx.kiq[0].ring.sched.ready =3D false;
-       adev->mes.ring[0].sched.ready =3D true;
+       adev->mes.ring[AMDGPU_MES_SCHED_PIPE].sched.ready =3D true;

         return 0;

--
2.49.0


--_000_DM4PR12MB6279EDCEC972305A5809AD87948BADM4PR12MB6279namp_
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
<p style=3D"font-family:Calibri;font-size:10pt;color:#008000;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[Public]<br>
</p>
<br>
<div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"appendonsend"></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<hr style=3D"display: inline-block; width: 98%;">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><span style=3D"font-family: Calibri, =
sans-serif; font-size: 11pt; color: rgb(0, 0, 0);"><b>From:</b>&nbsp;Deuche=
r, Alexander &lt;Alexander.Deucher@amd.com&gt;<br>
<b>Sent:</b>&nbsp;Thursday, May 8, 2025 1:24 PM<br>
<b>To:</b>&nbsp;amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop=
.org&gt;<br>
<b>Cc:</b>&nbsp;Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Chen,=
 Michael &lt;Michael.Chen@amd.com&gt;; Liu, Shaoyun &lt;Shaoyun.Liu@amd.com=
&gt;<br>
<b>Subject:</b>&nbsp;[PATCH] drm/amdgpu/mes12: rework pipe selection for le=
gacy queues</span>
<div>&nbsp;</div>
</div>
<div class=3D"elementToProof" style=3D"font-size: 11pt;">Only use the KIQ p=
ipe for the scheduler queue.&nbsp; For legacy<br>
kernel queues, use the scheduler pipe.&nbsp; This aligns with<br>
mes11.<br>
<br>
Cc: Michael Chen &lt;Michael.Chen@amd.com&gt;<br>
Cc: Shaoyun Liu &lt;Shaoyun.Liu@amd.com&gt;<br>
Signed-off-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 11 ++++++++++-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h |&nbsp; 4 +++-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/mes_v12_0.c&nbsp; | 18 +++++++++---------<=
br>
&nbsp;3 files changed, 22 insertions(+), 11 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_mes.c<br>
index 2febb63ab2322..f665daf71780d 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c<br>
@@ -299,6 +299,9 @@ int amdgpu_mes_map_legacy_queue(struct amdgpu_device *a=
dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; queue_input.queue_id =3D r=
ing-&gt;queue;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; queue_input.mqd_addr =3D a=
mdgpu_bo_gpu_offset(ring-&gt;mqd_obj);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; queue_input.wptr_addr =3D =
ring-&gt;wptr_gpu_addr;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* need to use KIQ pipe to map the sc=
heduler queue */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ring =3D=3D &amp;adev-&gt;mes.rin=
g[AMDGPU_MES_SCHED_PIPE])<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; queue_input.use_kiq =3D true;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D adev-&gt;mes.funcs-&=
gt;map_legacy_queue(&amp;adev-&gt;mes, &amp;queue_input);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
@@ -323,6 +326,10 @@ int amdgpu_mes_unmap_legacy_queue(struct amdgpu_device=
 *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; queue_input.trail_fence_ad=
dr =3D gpu_addr;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; queue_input.trail_fence_da=
ta =3D seq;<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* need to use KIQ pipe to unmap the =
scheduler queue */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ring =3D=3D &amp;adev-&gt;mes.rin=
g[AMDGPU_MES_SCHED_PIPE])<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; queue_input.use_kiq =3D true;<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D adev-&gt;mes.funcs-&=
gt;unmap_legacy_queue(&amp;adev-&gt;mes, &amp;queue_input);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;failed to unmap legacy queue\n&quot;)=
;<br>
@@ -349,7 +356,9 @@ int amdgpu_mes_reset_legacy_queue(struct amdgpu_device =
*adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; queue_input.wptr_addr =3D =
ring-&gt;wptr_gpu_addr;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; queue_input.vmid =3D vmid;=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; queue_input.use_mmio =3D u=
se_mmio;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; queue_input.is_kq =3D true;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* need to use KIQ pipe to reset the =
scheduler queue */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ring =3D=3D &amp;adev-&gt;mes.rin=
g[AMDGPU_MES_SCHED_PIPE])<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; queue_input.use_kiq =3D true;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ring-&gt;funcs-&gt;typ=
e =3D=3D AMDGPU_RING_TYPE_GFX)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; queue_input.legacy_gfx =3D true;<br>
<br>
</div>
<div class=3D"elementToProof" style=3D"font-size: 11pt;">We are not suppose=
d to reset scheduler queue, so this change is not necessary.&nbsp;</div>
<div class=3D"elementToProof" style=3D"font-size: 11pt;"><br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_mes.h<br>
index a41f65b4f733a..d1836ad93ccfe 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h<br>
@@ -242,6 +242,7 @@ struct mes_map_legacy_queue_input {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; queue_id;<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mqd_addr;<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; wptr_addr;<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; us=
e_kiq;<br>
&nbsp;};<br>
&nbsp;<br>
&nbsp;struct mes_unmap_legacy_queue_input {<br>
@@ -252,6 +253,7 @@ struct mes_unmap_legacy_queue_input {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; queue_id;<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; trail_fence=
_addr;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; trail_fence=
_data;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; us=
e_kiq;<br>
&nbsp;};<br>
&nbsp;<br>
&nbsp;struct mes_suspend_gang_input {<br>
@@ -277,7 +279,7 @@ struct mes_reset_queue_input {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; wptr_addr;<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vmid;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; legacy_gfx;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; is=
_kq;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; us=
e_kiq;<br>
&nbsp;};<br>
&nbsp;<br>
&nbsp;enum mes_misc_opcode {<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/a=
mdgpu/mes_v12_0.c<br>
index b4f17332d4664..8f2e24ecf747f 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c<br>
@@ -515,7 +515,7 @@ static int mes_v12_0_map_legacy_queue(struct amdgpu_mes=
 *mes,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; convert_to_mes_queue_type(input-&gt;queue_type);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mes_add_queue_pkt.map_lega=
cy_kq =3D 1;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (mes-&gt;adev-&gt;enable_uni_mes)<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (input-&gt;use_kiq)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; pipe =3D AMDGPU_MES_KIQ_PIPE;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; pipe =3D AMDGPU_MES_SCHED_PIPE;<br>
@@ -554,7 +554,7 @@ static int mes_v12_0_unmap_legacy_queue(struct amdgpu_m=
es *mes,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; conve=
rt_to_mes_queue_type(input-&gt;queue_type);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (mes-&gt;adev-&gt;enable_uni_mes)<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (input-&gt;use_kiq)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; pipe =3D AMDGPU_MES_KIQ_PIPE;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; pipe =3D AMDGPU_MES_SCHED_PIPE;<br>
@@ -869,7 +869,7 @@ static int mes_v12_0_reset_hw_queue(struct amdgpu_mes *=
mes,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; mes_reset_queue_pkt.doorbell_offset =3D input-&gt;doo=
rbell_offset;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (input-&gt;is_kq)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (input-&gt;use_kiq)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; pipe =3D AMDGPU_MES_KIQ_PIPE;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; pipe =3D AMDGPU_MES_SCHED_PIPE;<br>
@@ -1339,7 +1339,7 @@ static int mes_v12_0_kiq_enable_queue(struct amdgpu_d=
evice *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return r;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kiq-&gt;pmf-&gt;kiq_map_queues(kiq_ri=
ng, &amp;adev-&gt;mes.ring[0]);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kiq-&gt;pmf-&gt;kiq_map_queues(kiq_ri=
ng, &amp;adev-&gt;mes.ring[AMDGPU_MES_SCHED_PIPE]);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_ring_test_rin=
g(kiq_ring);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r) {<br>
@@ -1608,7 +1608,7 @@ static void mes_v12_0_kiq_dequeue_sched(struct amdgpu=
_device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; soc21_grbm_select(adev, 0,=
 0, 0, 0);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;adev-&gt=
;srbm_mutex);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;mes.ring[0].sched.ready =3D =
false;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;mes.ring[AMDGPU_MES_SCHED_PI=
PE].sched.ready =3D false;<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static void mes_v12_0_kiq_setting(struct amdgpu_ring *ring)<br>
@@ -1687,7 +1687,7 @@ static int mes_v12_0_kiq_hw_init(struct amdgpu_device=
 *adev)<br>
&nbsp;<br>
&nbsp;static int mes_v12_0_kiq_hw_fini(struct amdgpu_device *adev)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;mes.ring[0].sched.ready)=
 {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;mes.ring[AMDGPU_MES_SCHE=
D_PIPE].sched.ready) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (adev-&gt;enable_uni_mes)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgp=
u_mes_unmap_legacy_queue(adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; &amp;adev-&gt;mes.ring[AMDGPU_MES_SCHED_PIPE],<br>
@@ -1695,7 +1695,7 @@ static int mes_v12_0_kiq_hw_fini(struct amdgpu_device=
 *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; else<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mes_v=
12_0_kiq_dequeue_sched(adev);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; adev-&gt;mes.ring[0].sched.ready =3D false;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; adev-&gt;mes.ring[AMDGPU_MES_SCHED_PIPE].sched.ready =3D false;<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mes_v12_0_enable(adev, fal=
se);<br>
@@ -1708,7 +1708,7 @@ static int mes_v12_0_hw_init(struct amdgpu_ip_block *=
ip_block)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D ip_block-&gt;adev;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;mes.ring[0].sched.ready)=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;mes.ring[AMDGPU_MES_SCHE=
D_PIPE].sched.ready)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; goto out;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!adev-&gt;enable_mes_k=
iq) {<br>
@@ -1763,7 +1763,7 @@ static int mes_v12_0_hw_init(struct amdgpu_ip_block *=
ip_block)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * with MES enabled.<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.kiq[0].ring.s=
ched.ready =3D false;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;mes.ring[0].sched.ready =3D =
true;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;mes.ring[AMDGPU_MES_SCHED_PI=
PE].sched.ready =3D true;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;<br>
--<br>
2.49.0<br>
<br>
</div>
</div>
</body>
</html>

--_000_DM4PR12MB6279EDCEC972305A5809AD87948BADM4PR12MB6279namp_--
