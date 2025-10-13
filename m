Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CE34CCD183
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Oct 2025 08:26:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0750510E402;
	Mon, 13 Oct 2025 08:26:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XtywrdHW";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012069.outbound.protection.outlook.com [52.101.43.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B58F510E3FE
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Oct 2025 08:26:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vBZuKGGAODBG/Qx3RpG/Rs+P29jaCe2azFQqXkEsucG6JP57QVanGZIyzwQsryBklHkFhgX0F1RXHCtK0VApZyaO9jcZy0jT6V5ysCr8sjI9fSG1JidftmssaY8j0qk2Or+YjndjF0wjikeJegjfUPgIiEM/s5A08mzKa0+EWUHUxlNYtsYz+kU696ADhHbgLnqNbTbtrerKzZuduJH+BKGLs3zCiLNRsMztuYB+AESqA+kOre4O9fvU8ZhlfRtky0Ke9R4itChZ8UZdchL/qXOutkIO6ErJvMKr//wmAnaIpHltcfe3zlbQg08/9EPxwS+MlV6grOO/AV4QwEKjwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NM8Af+p6WiMYpnZp0RMg1hmwfXvUOsbKVlm889yimtg=;
 b=CrqwRDpp8NWdLaNQb2Vb2UVk9jGfnW42fGmhSiop3QAszclC1Oxb1AXMZbEQM+p1L4kTVVtV//XajeBdaGaG9nFGdFZ2ecCsxMWdoxBgrQVyoCZ44dnTusv6RacPMYpqNE9sXznaLxN6OdNJ1NCOn6ns9ud61t9TUAuCocdHndJvOZxwK9y/96iqVDttVSK+HWjAN05vxmAmtdLDFj9ciC3bdfiMsJ1FhDIhXUTS7iONKmzlWxd8S6aiCWc9pbViOY7zJkoTKJ4KfxhLn7Dq2/i0TbP2gaTwRAJvdfUniaBBQnlfO46+ZvQfz1rW3iLJsnXL928h+N84TBxc+Hx5vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NM8Af+p6WiMYpnZp0RMg1hmwfXvUOsbKVlm889yimtg=;
 b=XtywrdHWvo3KT7LHfNto34tFzCZ049sIVWrnMB4kFtqjhfA/BqC2g0gAQYWFtEwqW/TnTS1Nsijhq6p+D7p7DcMjnaRYQcx+J/Eq9DJjL5pZkXbLqbp0DdSoKVHVlwR8nX7opivESr/fw2RWoQK8TFkY5/K1Ir85k6vHMRsduTE=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 BL3PR12MB9051.namprd12.prod.outlook.com (2603:10b6:208:3ba::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.10; Mon, 13 Oct 2025 08:26:19 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb%4]) with mapi id 15.20.9203.009; Mon, 13 Oct 2025
 08:26:19 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 2/7] drm/amdgpu/userq: fix SDMA and compute validation
Thread-Topic: [PATCH 2/7] drm/amdgpu/userq: fix SDMA and compute validation
Thread-Index: AQHcOisW0h9hxPSqy0iafKTpVKEuRrS/vLWg
Date: Mon, 13 Oct 2025 08:26:19 +0000
Message-ID: <DS7PR12MB6005B24D4FB1959CA75A6B3DFBEAA@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20251010211510.1528572-1-alexander.deucher@amd.com>
 <20251010211510.1528572-2-alexander.deucher@amd.com>
In-Reply-To: <20251010211510.1528572-2-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-10-13T08:08:20.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|BL3PR12MB9051:EE_
x-ms-office365-filtering-correlation-id: c6637a31-c3bf-4e9e-876d-08de0a322f7c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?jie0SWi1kDGbpES+TcsZvGiUnmUhCgbE9jZ4EGTrcy+ljmvR3emdBt5qQXYp?=
 =?us-ascii?Q?jIljVXLdOTgp48nK1zDf+18WjoDSQpyaWHKohGbGCajiqzV3FNGpPRPRM5Yj?=
 =?us-ascii?Q?7GJPybyCcf4sycHuLe2TpVBSZgUY/SrCB+idjkGOG//n/Ou4Z9EJta61pzp6?=
 =?us-ascii?Q?VMJvH1hl+zq6d6bpjcJAJzpCLj1dAEGww+QgUcL+RbF6d8+D5CLqeCD6mxil?=
 =?us-ascii?Q?Kgv3isUIl5ZXCVu4Ur9xSGr6Z50EbXD/QjPuXhCOxpQRewY3hUV43oBMKOIP?=
 =?us-ascii?Q?VwWzlv2Zhl0gd6ZvOdQTvkOjSgGbe+M2OArmHqPGsY10oQmw5R2s4c/XKFLu?=
 =?us-ascii?Q?1yw/sLgOryv3VN55+iDBjng1I5hWHmW22tcpsiwK0VhCxr/fxXfBky3dK74A?=
 =?us-ascii?Q?bGn5R3G57dXv9Tkl+3T3plUTPcHcopR24erVi5dHOmTJmaGZ8coRdpBoeBp1?=
 =?us-ascii?Q?Cxy8/DaUH0AtJsgPS9L74kRnHInEAoI6hWOV5gMpyyyMEj/7js59HZM2oUK3?=
 =?us-ascii?Q?GdVtsqbsmFqnM46RxCTlq43YC04BDyDXQiefxNDOrb6NArpr0el+PHMwZ2On?=
 =?us-ascii?Q?qufilWFyFe5FxW1eX/Lya8xAjQ6qxZu1Qf/i3IDUyIOQb3lXVbXnGYkb/rCr?=
 =?us-ascii?Q?vc9nRTV8yg0XY7JjSUq0VuPpxkPQ8bm8dKe6NvsQL9ZUzVfv1Rlw2+kcHtyk?=
 =?us-ascii?Q?srDq/WOBg1NmhvNGN9suhGoz88izsLVNER7tV3SNcvYiNI9JvHfRkiQVtU6G?=
 =?us-ascii?Q?lDjlHs/hp2zslZLChSbsVnI3IuIUF4rpm4qC08afzechz6gvKdXod8QSPw6o?=
 =?us-ascii?Q?9A1f5cEoVG9kcOKeaTW6kZNsDjNUWtpKf65PJQok3U7BM3gLKAl1cHoTPtXC?=
 =?us-ascii?Q?omeQN60xsxJlOORHTlCKCrHJtQGj/jDJYv/xc6d3AsVfvglqRVc3gBF2xJqT?=
 =?us-ascii?Q?lP3nuXYYGgLhvUXy84tVX/ivfBak66iOiMUNSubLwR6w2HWHV7XBgr1niQsl?=
 =?us-ascii?Q?WvapZ94RSefi0oz/X/Nr9tKISM+bVvWnJ22I1rfGoeFmfBPyHSSjGu060TUU?=
 =?us-ascii?Q?TZIIVywLLShSZH9liJ9vg+TkmwMJDVKBGBnxAJfHMj50gb95Qz7UAAfpaLcn?=
 =?us-ascii?Q?EHSkzMs4bGq9YBIHDGRbkCrGx4yt2oLp4jfijZrPNooWXXGBi7dIOMseo5AR?=
 =?us-ascii?Q?WbWLkZcM7AYMXawomU+burVizugYExDPtSImBTDh+GoSbVqKRMugsnd07rpn?=
 =?us-ascii?Q?6t4LPQdbo5RX/O+aOkJlpn7gSZ5ojslzsKf+oacJGuKDX++Rk84juX1x7T6Z?=
 =?us-ascii?Q?KSmtthjIijQk+dPyxBlysiKAFtO8hdVX1Ii/uHQH+ivx6FweJdwe9nsyKBpg?=
 =?us-ascii?Q?gRrF+siMaaeoAhxY2q9NcmiGRnB+J4/lxvAMWUfz5XfleFiw5ArzQF6AOS64?=
 =?us-ascii?Q?eyWows/AVXQOTnD5UYbLvFjlyQ1qvbFt4hsaYePhN3xKgFhGa7SSJeM2f2tC?=
 =?us-ascii?Q?lV3mtarBnlQPEwLH5f5zCfsmhJVYs9rLALZq?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?37XjDp2H3H6yD1odmbudx0KlKMgVJZGX1Pidc0s7mN1WUYsGQhV8bfU9cSix?=
 =?us-ascii?Q?R7F1yEvIqQJVCHPV6Y8w0ASroXlAWlmnaxtv09jBSo9Som5QJrizzGbMoVZX?=
 =?us-ascii?Q?U2Wl8Omp3iUy3zpF7Myow6if6rdmWS/oZAV80T63i/AD0hdJMOv83Xcwz7Ue?=
 =?us-ascii?Q?YxnMu0mtM+IsknvaX1UhXdAOGF+M3cXImQQWlqC1DG0FZ2ieGvlh5D44lpzY?=
 =?us-ascii?Q?N+EDS1zkCC/cXVIgiKtBEG0oSIOYr8vi/vBAppOK1i5OoL9YFPJpEU8ZdbeF?=
 =?us-ascii?Q?qJyVyz/09Xc7CR0Gq6XXnQjVnZF8ncD3rR+hh+jTQFlYNxVxwL7Q7SuFxmVe?=
 =?us-ascii?Q?VrBDz8HXsDD6B7reQFlUXhIiZT5/PPaxBg6vzVy0TWfy5vA9KHOJOXLje/Vn?=
 =?us-ascii?Q?Tjst0EWfQhDWxQiNivIWKf8GDZvde5jtnBg7Tj4r6nMxqOIPmnPa/DpKxQBA?=
 =?us-ascii?Q?eGgP0YZjkwHzC0xwKGxJEDHTFWeFN41PplkDWU4I/d/agD1l68OQ7QNIBCIQ?=
 =?us-ascii?Q?fCSDntRLHe9qr+fyHEG6tLL4Jy/31P6r05cV4btuqOw7R8XZxmZKsQn6z3ln?=
 =?us-ascii?Q?uNPipC08Gye+HJ6xog5+Nf66vUqPCKb9bI+GusGmHNaF13+GJyWg4aRHk9Kf?=
 =?us-ascii?Q?VMud3o1JSUCM3tAVTyXp0VmlPCnpLhzxZmsA7/9Pmhzv7jXRCqO2ioZbA7Pr?=
 =?us-ascii?Q?cGlLSQdfF5PDCq8hJOLjg1ngg57PiPXgucgF7fomJbMVEtG8pCPxV+903hF8?=
 =?us-ascii?Q?quAJ5ib38ps5iV7C1Xqvd/bV2UpmY0FR6MBRzoQM6eLNftP2UWU+iR8T0NEm?=
 =?us-ascii?Q?V/KDCApTrI3AgIaT8Lc8JlkhgqCGErfpXnCrD+dIwCGPgAsVodrkkarq2H3w?=
 =?us-ascii?Q?O2Sa6RaPRatvuq4ENiHsYvD4FGVetoPfxSW3gBJXsu/w69WBeIBUgy3KJWSn?=
 =?us-ascii?Q?RQCrJXYKRp/pRKhdPO0JnKUQQgveLGA/2X5CGHRI1mF1V6hUwBEf9l06L6+2?=
 =?us-ascii?Q?PDvCaxqkcWSzQZrYt4TN1u8gk9M3fgAqCGIqFkLjeWowqHhjbbxSDWHEb4iy?=
 =?us-ascii?Q?mJO2hgQClFc/qDQoSfNsuXu9Yphu58aQOv1DiCO+WV7bWDGyncVWmN9tuprf?=
 =?us-ascii?Q?13OBHJIuGVG2toZjtu/dDRd0pg5SNgYEtRIit9Em+smAtH9fc1Rha/w7QA5r?=
 =?us-ascii?Q?6g6NLVlb7hgE1wchEaUM8M3mVz+uHv5YWwvpd7nhzRoLBDWO6mpyT/8S7WnK?=
 =?us-ascii?Q?6k34ptDxsYFMPddE2FbrwyoOnTUq6yljmvVyS6OWtMZ3TwUD9bD84irHppG7?=
 =?us-ascii?Q?VkFbDm0Wx2r7oCcdGDKnq6d2b114hDVGR1asxxwiURG3A7G+qdU/hnJvZrN+?=
 =?us-ascii?Q?+X2YcRTX2WYiEGwoIUfMenBHwAe0KdOGihQQ8AyeYxQJkkct3pRUuTm2vEdZ?=
 =?us-ascii?Q?4xL5H6I0fTLsvK2ojPc/cSiBJFhOoqGrEnvNrh32q+nPG5uGTOtpru/I33TU?=
 =?us-ascii?Q?rXHVZ4lWhz/ixO5s2+h7VquNJjQQsW3fLs1JBOFcJkbWJaZyCsgcrXiH/JD6?=
 =?us-ascii?Q?tiYj0/SUwG6G3MpuQXg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6637a31-c3bf-4e9e-876d-08de0a322f7c
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2025 08:26:19.3959 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Oknn99zwhutRo8qXC44bLBvyqunlOl0HUsNc0Rt3zf1NGnXUnK7Q6dhiradm4Y+N
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB9051
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

Regards,
      Prike

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex
> Deucher
> Sent: Saturday, October 11, 2025 5:15 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: [PATCH 2/7] drm/amdgpu/userq: fix SDMA and compute validation
>
> The CSA and EOP buffers have different alignement requirements.
> Hardcode them for now as a bug fix.  A proper query will be added in a su=
bsequent
> patch.
>
> Fixes: 9e46b8bb0539 ("drm/amdgpu: validate userq buffer virtual address a=
nd size")
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> index 0370ef719a6aa..ab392de2a2388 100644
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
[Prike] How did this issue occur? If we hardcode the value here, will users=
pace driver EOP buffer requests still be compatible?
We may need to add a TODO comment to replace this with proper EOP-size quer=
ies in a future change.

>               if (r)
>                       goto free_mqd;
>
> @@ -312,6 +309,9 @@ static int mes_userq_mqd_create(struct
> amdgpu_userq_mgr *uq_mgr,
>               kfree(compute_mqd);
>       } else if (queue->queue_type =3D=3D AMDGPU_HW_IP_GFX) {
>               struct drm_amdgpu_userq_mqd_gfx11 *mqd_gfx_v11;
> +             struct amdgpu_gfx_shadow_info shadow_info;
> +
> +             adev->gfx.funcs->get_gfx_shadow_info(adev, &shadow_info, tr=
ue);
[Prike]  We may need to validate the get_gfx_shadow_info() callback before =
using it.

>               if (mqd_user->mqd_size !=3D sizeof(*mqd_gfx_v11) || !mqd_us=
er->mqd)
> {
>                       DRM_ERROR("Invalid GFX MQD\n");
> @@ -335,6 +335,10 @@ static int mes_userq_mqd_create(struct
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
> +357,7 @@ static int mes_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr=
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

