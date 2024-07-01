Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1A23C3065A
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jul 2024 18:09:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A34F10E4CE;
	Mon,  1 Jul 2024 18:09:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SDAT9sm7";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2041.outbound.protection.outlook.com [40.107.244.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5943510E4CE
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jul 2024 18:09:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cjzB+pQ8XYGw5LYdM43rjSu5yKnCIm4DRgRuytIIqA26r10E3M4gzNVQlhwH8YY9FTGW0GL7ZClXRf2+WsNGBVz+TPtw8KjIWUe41UDiUav+OeyUxaoOXZjYVLwqrT1/YO23aUPnQK9WK8OGLLRo+NXr865xrA4pM7iXqJFfOAzhblDknN1+9OiBPsu5CMhJjHQjt08HjOQCM1Q4CuQ2eH8eTsZoDr/s+mEzHV3J8x9mjACXFaiAzBceV0x6WtziiHthrLC0Apw56qfNizjl/00GZBNF32AFnIvsruRyMpz60ohFguqM8RGBA/H6T8MkkWb7zNdaTv5FdZ2AZr/N6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qZ4IbemPyluOyZnNXsvo751SU2isK2ZofiVvfu8cmb8=;
 b=lehgEpNjmkhz9Aqw+X3ikkZBG/CYjMPBrd986qrg/qp8ysyUFTSdibIHW0eY2pf0lZX9vVUF4TcEpXZEjjY7xQXaVfNGs5XYcBkUWiP6q5pKk+5JR/AMuih0XC7j+UvJhJ9WM+Tv45MNcxe/OcYkKI2UPv2K59dEUeCo/MDIs3kzae6ggEbbQw7Y/3Sfh5BZMmnmk5Phs6+nBJaWJOaObR4QF2kpsmLWxrxgvcUZWaE3qQV6AD2TOgLd1rQIbfblYFRxmZ1B2AUEIBeRxaERmI7atD+dN+gDlsxx+4GT6fOJYBYVMvdvofuSzf9bsHuZBVi4g6bO47ruC04ksJ8M+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qZ4IbemPyluOyZnNXsvo751SU2isK2ZofiVvfu8cmb8=;
 b=SDAT9sm7X93ldrURId4LJsnV1o6x+T/sNkwPYnjRUftVnhYx6Ks7Zg2phzKl4I8Ac1/LHGdVCLmlqJ1cX4nwqy70KeYyU4FyJJCkdHfVLI6IzDsNZcgDedvOboFA6bOJUSOu7Qia2BqfY8oE+PCxoH/00essP1ArYHu8yWXac0U=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by SA0PR12MB4447.namprd12.prod.outlook.com (2603:10b6:806:9b::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29; Mon, 1 Jul
 2024 18:09:19 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42%4]) with mapi id 15.20.7719.029; Mon, 1 Jul 2024
 18:09:19 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Min, Frank" <Frank.Min@amd.com>, "Olsak, Marek" <Marek.Olsak@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>, "Gao, Likun" <Likun.Gao@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: restore dcc bo tilling configs while moving
Thread-Topic: [PATCH] drm/amdgpu: restore dcc bo tilling configs while moving
Thread-Index: AQHax3CwWWld91q+sEK3tx5mvhifELHZUvjwgAfoNlCAAPllXA==
Date: Mon, 1 Jul 2024 18:09:19 +0000
Message-ID: <BL1PR12MB51442838F3F7F1D8B5616903F7D32@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20240626022742.1956-1-Frank.Min@amd.com>
 <SA3PR12MB7902BE546DCDACE2F5DAAF33E9D62@SA3PR12MB7902.namprd12.prod.outlook.com>
 <SA3PR12MB79028EFDCBFD7191E72E2CFAE9D32@SA3PR12MB7902.namprd12.prod.outlook.com>
In-Reply-To: <SA3PR12MB79028EFDCBFD7191E72E2CFAE9D32@SA3PR12MB7902.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2024-07-01T18:09:18.949Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|SA0PR12MB4447:EE_
x-ms-office365-filtering-correlation-id: 55b9eb0a-f7be-47c8-b48c-08dc99f8ed68
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|921020|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?lbCTP3R2Dc15yZyVWmFBmg3FUYvXy9dTjAguZpafqkH5XTay6xPItAnLgDN4?=
 =?us-ascii?Q?cgFBkmE+5/bhhaD+IKqrPkNWIC8H5T4RT+G6AsS7pFdLV6zOwk0EvA1j0VSb?=
 =?us-ascii?Q?cSepvUZW4ofZDhCi5DYLxvzIl2WYlxapHWiorGiQ3y9PWbeSqvWhV+H6Mv0F?=
 =?us-ascii?Q?3eByrOX5ohuBneXCrC/2xCwv76ulS330WWeOYWm2pz3cKHJVxsgA3wdpL6Mg?=
 =?us-ascii?Q?aOJyqwpH7en7BGhvfa4cQZ5w3v9bsPP9lQEfCpJxuT5fHYN+YCp6KzFQ6RUi?=
 =?us-ascii?Q?nxRp32Ja5GBv1/v9iBvrr0GH8ZsVHwY1oKVmf7Fd9xK9n+7aPw0UccLb6hFW?=
 =?us-ascii?Q?yF37lqWwFSUL07iaz+aJMKG6GwxBGqCzouU/2Cd+VGgVRpoKJMeiar1mdimz?=
 =?us-ascii?Q?IP18WUUTFRWD5oexHrtBmr1Xd1qYDpmH5KGFM6xQRQGdR43GTHo3ET+lIn1h?=
 =?us-ascii?Q?YEwwhm3jn5NF+3IYuie2pBSVfGQB8k1Vz0ZN/meAjasMW376rBJv5hYFEcLd?=
 =?us-ascii?Q?AoMrTDsJbG/N8aCmLCJdZ2jPic1PBl/ycck8N5D/NY94QyDNunw2jVSv3SZb?=
 =?us-ascii?Q?2RuOjsK85YOtxPIvUhM7itqRMvASKdPYpqgocyxAcpJJI4iDwse2f8fd0aAl?=
 =?us-ascii?Q?o+ubINTvX1JxCUtmzUQoh4N1XGI6aDQKZ3q56/OKr8jH5DjHi41a9O6O2dT2?=
 =?us-ascii?Q?humhsA7RxRm27Q1ocmuTMg+oq/zAIHj9VZ2Dp0terufnrjhgbDX5iPY1c7oU?=
 =?us-ascii?Q?OnIa629dy6CgFkliG9xkBJfYQ2CxHul9bdCFRSMA0RouotpQjC1nVqmrz5bb?=
 =?us-ascii?Q?QVnXuDWacZHYeewKen+Gp4lgbwlweOYHdkCPzY1b3Tx8/ENXwMnBX5MpMAV2?=
 =?us-ascii?Q?UfoxwlzBh3Sq3t4a/h/zavmPsiQD2PI5c1zLHWb3R1UrJMlZikC2nARkKA2N?=
 =?us-ascii?Q?1MmS3qO1HXuXx4nQjyfbKqGy4skKl7p1B5rgsnKnZ0GoE4pIF1MIU9eIOm5F?=
 =?us-ascii?Q?g9f0Q1sqgLX26DrglRTb2BklgcZVVovou8/5vo9Z0x1XNppTn5uCTOyFapv/?=
 =?us-ascii?Q?q4uGBpEWdv+b4AQ4/EyiPJNGfeP9OcSm065XAiX7JlkUCoIdWu2wA1D4ZJFU?=
 =?us-ascii?Q?2m8uHGbdUjlLsem6DfPc9StYAkwDV62ZMCSjQT8gBfH2uy70EnsaJI5aP+qA?=
 =?us-ascii?Q?kwSqi1gR9vvo1QzSO/dPi1bDqjwUMeqG77nzf8E015o8zYeJkztNffEjV+/t?=
 =?us-ascii?Q?amyxgl8M2tvu5/sRFWiRZUV0IjDMMG5JDk+9kldc4lqD2jqIZiRg6gCMxnQU?=
 =?us-ascii?Q?F82qjLwGiJVxJIDK4gr+lwVA4tLGaSzmZr9VPtBo0uLjfvBg4WKp9o3Z6l/Z?=
 =?us-ascii?Q?ZOnhmPupxW4xkZgzmutQkobDeBmmpFR55M94mFTX+kTroZZi+rGNK/faC2R6?=
 =?us-ascii?Q?IqZbq83aRyI=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(921020)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?uEkNyoeeSvQU30+bugCZFL9DeD3RzDejBpLJQOe1ZJfU79IRhelo8GCQHSnL?=
 =?us-ascii?Q?YHlV5pMVbUo4Ev3dYf7sp8rz4God4uKXVABJFXY/RipKw12cBCIc1nLYRky1?=
 =?us-ascii?Q?iHslOguq5eqOwSUXHAy/kMnEAjRD0FbhaQ1tYMRkPhMzFE+5xUojm9UyZK83?=
 =?us-ascii?Q?4yaJzJOD76f47TMupAeCHwHjts3DvkuAKXBac2PVlJOv9o2pTXPUojbLnAQN?=
 =?us-ascii?Q?PikkiBK+Ep1jeIzmeLha9hIhsvewpfE9E7oTmNfaG/R25MjcSPhHQux+7Dw2?=
 =?us-ascii?Q?zZXOAJkbxNJpLDoP2YzLNPXlmVfTZmhEjyuc/zihI2yXKuwUkcnsZ/2Oe4R5?=
 =?us-ascii?Q?wty6MBRU7/xZzBcgj98igbQhqF1d5jdYPq9NStsj2S5EBsZpTXVdWYNbbHZY?=
 =?us-ascii?Q?qltuuyfLsUVOrAQD1+UutwpE0oOU/B886+0/RRKDhhGPMzDtTZCzy07Ga1e5?=
 =?us-ascii?Q?zkL05y3d/fBq0uabBFWGq2mLLOg+h0BN+5mGkc8PGtHN6+mJBxCCs1HGAi9R?=
 =?us-ascii?Q?JBHCWlwHafVkzI0uPUWylH8p52UxZgoQFw7WGntknJJpkThUbhVQvar+Q3w4?=
 =?us-ascii?Q?9s3JXgpy74WSMO+UOsK0fhW10TLOofdAXtoiMzU7dLkP7ZB3YVT5kkti26Mi?=
 =?us-ascii?Q?hqS8+pXnzsPce91r+5HC43jL6qGc9bzEIPf+lU68NEtQANskjjFzxytj0oHp?=
 =?us-ascii?Q?P93Ia9UTpvCtK0vwFKCbBJS9rBxo5AtDp4FhVpRl8RpCltf4R9x0Xh8lGv6f?=
 =?us-ascii?Q?n9MNtp8De/MmQdZNgC9WohiPLbDbNGtWBN1qt0zjIKJAX3wc7zLeqK7O8EOT?=
 =?us-ascii?Q?BsoaXLwCeNlu/4A8N60XOhjrzlmOtKQhlC8xxUD2GIhbCDfQivignJJ7raL4?=
 =?us-ascii?Q?WrLeXvTNHYJrx7ftzdRwZdapqWEskIj1eiU6e6eEvgnwvXH9JJ7+4Zi9h91K?=
 =?us-ascii?Q?InEohYql4Pdl99tfrRt1krHNrQolsCduOD8A2wXXBmaQmpoRL4EYiOXu7EV6?=
 =?us-ascii?Q?9MkLx7LzL2xiDm7vNtpyYaCKczGh1PiqUTc7l/eQ+S7Lr874jExYwP0uoL13?=
 =?us-ascii?Q?DdIIEqMwMpsBqsjuduk+bqAdI7cO3SjsW5zU6Y8bJ3iPbT3fpBZsFB8s41/S?=
 =?us-ascii?Q?fUAcvPYv0C6ut0ttD02vMmNHsmhdykLzAz8VraJOAD53IBaWYsAYMM7w0H0F?=
 =?us-ascii?Q?Sj+pekP662lFLnISNPoDSUAJEhDNRcLkflB/xNkkepvfr39q7bj6W1LUCQ1O?=
 =?us-ascii?Q?TTRlfka6jvEIE4pVEdWYNsb2cb/4qR5FqnDTmCu0L5aa7zTmt+E37fzzSYT8?=
 =?us-ascii?Q?UE28X3DhIrlilxHWhnKZZKzofugH8AQG8mwq9E9Xc1g8XoSU1MaqOj/n+lIE?=
 =?us-ascii?Q?2MTOsBryyhvly7oz9l3hxWOE/HD77iCApJocta+WE2nA8lQ5e+vUc9NiMABc?=
 =?us-ascii?Q?oy7vBBUwIqBn5fs4gde9rGBjG5TUxb/tiU/K/uIhKYXJorfrYzkvLxTX7iKd?=
 =?us-ascii?Q?Ln2JxePHRzJWt3Nw75rjzyL/mu5CVJC9ieEFMzOVCc8zW2+4VDGSLosRhWRk?=
 =?us-ascii?Q?/N+vAqJQUq/dbZOOWtE=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB51442838F3F7F1D8B5616903F7D32BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55b9eb0a-f7be-47c8-b48c-08dc99f8ed68
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2024 18:09:19.3234 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yarLKIiDSb7WIYDOMfZCoay57xQYIa/IQgxeJJ5DIiVpmBiHE5v8C0HiTpI745vL1VsE2NNddfyuEkh6yXaz+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4447
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

--_000_BL1PR12MB51442838F3F7F1D8B5616903F7D32BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: Min, Frank <Frank.Min@amd.com>
Sent: Sunday, June 30, 2024 11:17 PM
To: Deucher, Alexander <Alexander.Deucher@amd.com>; Olsak, Marek <Marek.Ols=
ak@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>; Zhang, Hawking <=
Hawking.Zhang@amd.com>; Gao, Likun <Likun.Gao@amd.com>; amd-gfx@lists.freed=
esktop.org <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: restore dcc bo tilling configs while moving

[AMD Official Use Only - AMD Internal Distribution Only]

From: Frank Min <Frank.Min@amd.com>

While moving buffer which as dcc tiling config, it is needed to restore its=
 original dcc tiling.

1. extend copy flag to cover tiling bits

2. add logic to restore original dcc tiling config

Signed-off-by: Frank Min <Frank.Min@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 17 ++++++++++++++---  drivers/gp=
u/drm/amd/amdgpu/amdgpu_ttm.h | 11 +++++++++++  drivers/gpu/drm/amd/amdgpu/=
sdma_v7_0.c  | 10 ++++++++--
 3 files changed, 33 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ttm.c
index 9a92dd3c9fb8..dd4aed47af1e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -308,7 +308,8 @@ int amdgpu_ttm_copy_mem_to_mem(struct amdgpu_device *ad=
ev,

        mutex_lock(&adev->mman.gtt_window_lock);
        while (src_mm.remaining) {
-               uint64_t from, to, cur_size;
+               uint64_t from, to, cur_size, tiling_flags;
+               uint32_t num_type, data_format, max_com;
                struct dma_fence *next;

                /* Never copy more than 256MiB at once to avoid a timeout *=
/ @@ -329,10 +330,20 @@ int amdgpu_ttm_copy_mem_to_mem(struct amdgpu_device=
 *adev,
                abo_dst =3D ttm_to_amdgpu_bo(dst->bo);
                if (tmz)
                        copy_flags |=3D AMDGPU_COPY_FLAGS_TMZ;
-               if (abo_src->flags & AMDGPU_GEM_CREATE_GFX12_DCC)
+               if ((abo_src->flags & AMDGPU_GEM_CREATE_GFX12_DCC) &&
+                   (abo_src->tbo.resource->mem_type =3D=3D TTM_PL_VRAM))
                        copy_flags |=3D AMDGPU_COPY_FLAGS_READ_DECOMPRESSED=
;
-               if (abo_dst->flags & AMDGPU_GEM_CREATE_GFX12_DCC)
+               if ((abo_dst->flags & AMDGPU_GEM_CREATE_GFX12_DCC) &&
+                   (dst->mem->mem_type =3D=3D TTM_PL_VRAM)) {
                        copy_flags |=3D AMDGPU_COPY_FLAGS_WRITE_COMPRESSED;
+                       amdgpu_bo_get_tiling_flags(abo_dst, &tiling_flags);
+                       max_com =3D AMDGPU_TILING_GET(tiling_flags, GFX12_D=
CC_MAX_COMPRESSED_BLOCK);
+                       num_type =3D AMDGPU_TILING_GET(tiling_flags, GFX12_=
DCC_NUMBER_TYPE);
+                       data_format =3D AMDGPU_TILING_GET(tiling_flags, GFX=
12_DCC_DATA_FORMAT);
+                       copy_flags |=3D (AMDGPU_COPY_FLAGS_SET(MAX_COMPRESS=
ED, max_com) |
+                                      AMDGPU_COPY_FLAGS_SET(NUMBER_TYPE, n=
um_type) |
+                                      AMDGPU_COPY_FLAGS_SET(DATA_FORMAT, d=
ata_format));
+               }

                r =3D amdgpu_copy_buffer(ring, from, to, cur_size, resv,
                                       &next, false, true, copy_flags); dif=
f --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amd=
gpu/amdgpu_ttm.h
index 7c903a6c9ddb..8d34e8588dc2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
@@ -114,6 +114,17 @@ struct amdgpu_copy_mem {
 #define AMDGPU_COPY_FLAGS_TMZ          (1 << 0)
 #define AMDGPU_COPY_FLAGS_READ_DECOMPRESSED    (1 << 1)
 #define AMDGPU_COPY_FLAGS_WRITE_COMPRESSED     (1 << 2)
+#define AMDGPU_COPY_FLAGS_MAX_COMPRESSED_SHIFT         3
+#define AMDGPU_COPY_FLAGS_MAX_COMPRESSED_MASK          0x03
+#define AMDGPU_COPY_FLAGS_NUMBER_TYPE_SHIFT            5
+#define AMDGPU_COPY_FLAGS_NUMBER_TYPE_MASK             0x07
+#define AMDGPU_COPY_FLAGS_DATA_FORMAT_SHIFT            8
+#define AMDGPU_COPY_FLAGS_DATA_FORMAT_MASK             0x3f
+
+#define AMDGPU_COPY_FLAGS_SET(field, value) \
+       (((__u32)(value) & AMDGPU_COPY_FLAGS_##field##_MASK) <<
+AMDGPU_COPY_FLAGS_##field##_SHIFT)
+#define AMDGPU_COPY_FLAGS_GET(value, field) \
+       (((__u32)(value) >> AMDGPU_COPY_FLAGS_##field##_SHIFT) &
+AMDGPU_COPY_FLAGS_##field##_MASK)

 int amdgpu_gtt_mgr_init(struct amdgpu_device *adev, uint64_t gtt_size);  v=
oid amdgpu_gtt_mgr_fini(struct amdgpu_device *adev); diff --git a/drivers/g=
pu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
index 96514fd77e35..41b5e45697dc 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
@@ -1566,6 +1566,12 @@ static void sdma_v7_0_emit_copy_buffer(struct amdgpu=
_ib *ib,
                                       uint32_t byte_count,
                                       uint32_t copy_flags)
 {
+       uint32_t num_type, data_format, max_com;
+
+       max_com =3D AMDGPU_COPY_FLAGS_GET(copy_flags, MAX_COMPRESSED);
+       data_format =3D AMDGPU_COPY_FLAGS_GET(copy_flags, DATA_FORMAT);
+       num_type =3D AMDGPU_COPY_FLAGS_GET(copy_flags, NUMBER_TYPE);
+
        ib->ptr[ib->length_dw++] =3D SDMA_PKT_COPY_LINEAR_HEADER_OP(SDMA_OP=
_COPY) |
                SDMA_PKT_COPY_LINEAR_HEADER_SUB_OP(SDMA_SUBOP_COPY_LINEAR) =
|
                SDMA_PKT_COPY_LINEAR_HEADER_TMZ((copy_flags & AMDGPU_COPY_F=
LAGS_TMZ) ? 1 : 0) | @@ -1580,10 +1586,10 @@ static void sdma_v7_0_emit_cop=
y_buffer(struct amdgpu_ib *ib,
        ib->ptr[ib->length_dw++] =3D upper_32_bits(dst_offset);

        if ((copy_flags & (AMDGPU_COPY_FLAGS_READ_DECOMPRESSED | AMDGPU_COP=
Y_FLAGS_WRITE_COMPRESSED)))
-               ib->ptr[ib->length_dw++] =3D SDMA_DCC_DATA_FORMAT(4) | SDMA=
_DCC_NUM_TYPE(4) |
+               ib->ptr[ib->length_dw++] =3D SDMA_DCC_DATA_FORMAT(data_form=
at) |
+SDMA_DCC_NUM_TYPE(num_type) |
                        ((copy_flags & AMDGPU_COPY_FLAGS_READ_DECOMPRESSED)=
 ? SDMA_DCC_READ_CM(2) : 0) |
                        ((copy_flags & AMDGPU_COPY_FLAGS_WRITE_COMPRESSED) =
? SDMA_DCC_WRITE_CM(1) : 0) |
-                       SDMA_DCC_MAX_COM(1) | SDMA_DCC_MAX_UCOM(1);
+                       SDMA_DCC_MAX_COM(max_com) | SDMA_DCC_MAX_UCOM(1);
 }

 /**
--
2.34.1


--_000_BL1PR12MB51442838F3F7F1D8B5616903F7D32BL1PR12MB5144namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
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
Reviewed-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Min, Frank &lt;Frank.=
Min@amd.com&gt;<br>
<b>Sent:</b> Sunday, June 30, 2024 11:17 PM<br>
<b>To:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Olsak, Mar=
ek &lt;Marek.Olsak@amd.com&gt;; Koenig, Christian &lt;Christian.Koenig@amd.=
com&gt;; Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; Gao, Likun &lt;Likun=
.Gao@amd.com&gt;; amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedeskt=
op.org&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: restore dcc bo tilling configs while mo=
ving</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font face=3D"Times New Roman" size=3D"3"><span=
 style=3D"font-size:12pt;"><a name=3D"BM_BEGIN"></a>
<div><font size=3D"2"><span style=3D"font-size:11pt;">[AMD Official Use Onl=
y - AMD Internal Distribution Only]<br>
<br>
From: Frank Min &lt;Frank.Min@amd.com&gt;<br>
<br>
While moving buffer which as dcc tiling config, it is needed to restore its=
 original dcc tiling.<br>
<br>
1. extend copy flag to cover tiling bits<br>
<br>
2. add logic to restore original dcc tiling config<br>
<br>
Signed-off-by: Frank Min &lt;Frank.Min@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 17 ++++++++++++++---&nbsp; =
drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h | 11 +++++++++++&nbsp; drivers/gpu/=
drm/amd/amdgpu/sdma_v7_0.c&nbsp; | 10 ++++++++--<br>
&nbsp;3 files changed, 33 insertions(+), 5 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ttm.c<br>
index 9a92dd3c9fb8..dd4aed47af1e 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c<br>
@@ -308,7 +308,8 @@ int amdgpu_ttm_copy_mem_to_mem(struct amdgpu_device *ad=
ev,<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;adev-&gt;mman.gt=
t_window_lock);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; while (src_mm.remaining) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; uint64_t from, to, cur_size;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; uint64_t from, to, cur_size, tiling_flags;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; uint32_t num_type, data_format, max_com;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; struct dma_fence *next;<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; /* Never copy more than 256MiB at once to avoid a timeout *=
/ @@ -329,10 +330,20 @@ int amdgpu_ttm_copy_mem_to_mem(struct amdgpu_device=
 *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; abo_dst =3D ttm_to_amdgpu_bo(dst-&gt;bo);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (tmz)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; copy_flags =
|=3D AMDGPU_COPY_FLAGS_TMZ;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (abo_src-&gt;flags &amp; AMDGPU_GEM_CREATE_GFX12_DCC)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if ((abo_src-&gt;flags &amp; AMDGPU_GEM_CREATE_GFX12_DCC) &amp;&=
amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (abo_src-&gt;tbo.resource-&gt;mem_type =
=3D=3D TTM_PL_VRAM))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; copy_flags =
|=3D AMDGPU_COPY_FLAGS_READ_DECOMPRESSED;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (abo_dst-&gt;flags &amp; AMDGPU_GEM_CREATE_GFX12_DCC)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if ((abo_dst-&gt;flags &amp; AMDGPU_GEM_CREATE_GFX12_DCC) &amp;&=
amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (dst-&gt;mem-&gt;mem_type =3D=3D TTM_PL_=
VRAM)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; copy_flags =
|=3D AMDGPU_COPY_FLAGS_WRITE_COMPRESSED;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_bo_get_ti=
ling_flags(abo_dst, &amp;tiling_flags);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; max_com =3D AMDG=
PU_TILING_GET(tiling_flags, GFX12_DCC_MAX_COMPRESSED_BLOCK);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; num_type =3D AMD=
GPU_TILING_GET(tiling_flags, GFX12_DCC_NUMBER_TYPE);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data_format =3D =
AMDGPU_TILING_GET(tiling_flags, GFX12_DCC_DATA_FORMAT);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; copy_flags |=3D =
(AMDGPU_COPY_FLAGS_SET(MAX_COMPRESSED, max_com) |<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; A=
MDGPU_COPY_FLAGS_SET(NUMBER_TYPE, num_type) |<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; A=
MDGPU_COPY_FLAGS_SET(DATA_FORMAT, data_format));<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; r =3D amdgpu_copy_buffer(ring, from, to, cur_size, resv,<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; &amp;next, false, true, copy_flags); diff --git a/drivers/gpu/drm/amd/a=
mdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h<br>
index 7c903a6c9ddb..8d34e8588dc2 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h<br>
@@ -114,6 +114,17 @@ struct amdgpu_copy_mem {<br>
&nbsp;#define AMDGPU_COPY_FLAGS_TMZ&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; (1 &lt;&lt; 0)<br>
&nbsp;#define AMDGPU_COPY_FLAGS_READ_DECOMPRESSED&nbsp;&nbsp;&nbsp; (1 &lt;=
&lt; 1)<br>
&nbsp;#define AMDGPU_COPY_FLAGS_WRITE_COMPRESSED&nbsp;&nbsp;&nbsp;&nbsp; (1=
 &lt;&lt; 2)<br>
+#define AMDGPU_COPY_FLAGS_MAX_COMPRESSED_SHIFT&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; 3<br>
+#define AMDGPU_COPY_FLAGS_MAX_COMPRESSED_MASK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; 0x03<br>
+#define AMDGPU_COPY_FLAGS_NUMBER_TYPE_SHIFT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 5<br>
+#define AMDGPU_COPY_FLAGS_NUMBER_TYPE_MASK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x07<br>
+#define AMDGPU_COPY_FLAGS_DATA_FORMAT_SHIFT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 8<br>
+#define AMDGPU_COPY_FLAGS_DATA_FORMAT_MASK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x3f<br>
+<br>
+#define AMDGPU_COPY_FLAGS_SET(field, value) \<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (((__u32)(value) &amp; AMDGPU_COPY_FL=
AGS_##field##_MASK) &lt;&lt;<br>
+AMDGPU_COPY_FLAGS_##field##_SHIFT)<br>
+#define AMDGPU_COPY_FLAGS_GET(value, field) \<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (((__u32)(value) &gt;&gt; AMDGPU_COPY=
_FLAGS_##field##_SHIFT) &amp;<br>
+AMDGPU_COPY_FLAGS_##field##_MASK)<br>
<br>
&nbsp;int amdgpu_gtt_mgr_init(struct amdgpu_device *adev, uint64_t gtt_size=
);&nbsp; void amdgpu_gtt_mgr_fini(struct amdgpu_device *adev); diff --git a=
/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v=
7_0.c<br>
index 96514fd77e35..41b5e45697dc 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c<br>
@@ -1566,6 +1566,12 @@ static void sdma_v7_0_emit_copy_buffer(struct amdgpu=
_ib *ib,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; uint32_t byte_count,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; uint32_t copy_flags)<br>
&nbsp;{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t num_type, data_format, max_c=
om;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; max_com =3D AMDGPU_COPY_FLAGS_GET(cop=
y_flags, MAX_COMPRESSED);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data_format =3D AMDGPU_COPY_FLAGS_GET=
(copy_flags, DATA_FORMAT);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; num_type =3D AMDGPU_COPY_FLAGS_GET(co=
py_flags, NUMBER_TYPE);<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ib-&gt;ptr[ib-&gt;length_dw++] =
=3D SDMA_PKT_COPY_LINEAR_HEADER_OP(SDMA_OP_COPY) |<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; SDMA_PKT_COPY_LINEAR_HEADER_SUB_OP(SDMA_SUBOP_COPY_LINEAR) =
|<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; SDMA_PKT_COPY_LINEAR_HEADER_TMZ((copy_flags &amp; AMDGPU_CO=
PY_FLAGS_TMZ) ? 1 : 0) | @@ -1580,10 +1586,10 @@ static void sdma_v7_0_emit=
_copy_buffer(struct amdgpu_ib *ib,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ib-&gt;ptr[ib-&gt;length_dw++] =
=3D upper_32_bits(dst_offset);<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((copy_flags &amp; (AMDGPU_CO=
PY_FLAGS_READ_DECOMPRESSED | AMDGPU_COPY_FLAGS_WRITE_COMPRESSED)))<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ib-&gt;ptr[ib-&gt;length_dw++] =3D SDMA_DCC_DATA_FORMAT(4) | SDM=
A_DCC_NUM_TYPE(4) |<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ib-&gt;ptr[ib-&gt;length_dw++] =3D SDMA_DCC_DATA_FORMAT(data_for=
mat) |<br>
+SDMA_DCC_NUM_TYPE(num_type) |<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((copy_flag=
s &amp; AMDGPU_COPY_FLAGS_READ_DECOMPRESSED) ? SDMA_DCC_READ_CM(2) : 0) |<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((copy_flag=
s &amp; AMDGPU_COPY_FLAGS_WRITE_COMPRESSED) ? SDMA_DCC_WRITE_CM(1) : 0) |<b=
r>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SDMA_DCC_MAX_COM=
(1) | SDMA_DCC_MAX_UCOM(1);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SDMA_DCC_MAX_COM=
(max_com) | SDMA_DCC_MAX_UCOM(1);<br>
&nbsp;}<br>
<br>
&nbsp;/**<br>
--<br>
2.34.1<br>
<br>
</span></font></div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB51442838F3F7F1D8B5616903F7D32BL1PR12MB5144namp_--
