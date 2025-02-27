Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29827C021BE
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Feb 2025 12:36:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D8BD10E386;
	Thu, 27 Feb 2025 12:36:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZufGdeqB";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2071.outbound.protection.outlook.com [40.107.223.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A10510E386
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Feb 2025 12:36:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=acuRC1ltAaR8NjlqnH2eNQuSKjicS/HBwkJMweMwy1MenJYGC4I/zHc8SaUwfvElj2iUmlxm1AusMr8y/JUB/wdn215g4XN0SQuoVIjQXUMJ+7iJLXbHcsOPAI7PiuiIOyQGe+ss5fpwht0zsEeYR6zfwkGELYzoKomdXjUPq41H0KFYO9rwQfUmpZZ0nbV6gNkf4geMtuBnB8tsGNJoUV15E4ZZS+8XELpgPGR+Stq3Qj2pfJgUvWVy1BYGzmm9GSWB0n2LI7vTSggtzAegxTIvn1deGSbbA6Nlm8L5tW2JTofIYFmByYfT7HZQUvche+W4Z1n5OfcrZCg6v/1nbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/5iJ3qpVyvn1uZV4cWNNX9C+d1A6dMOH+xMBwsi8f5g=;
 b=GxO6ZB4wBpkRt48DmsV/lmPXAk1iEYi7hEerH7soPTDokp7aSzHql/2vv7mJK50DoeL9znvu2/SyownpeJcm8jOrUOdnlmaUAGpO46STkN5pyAjooJVEyS3q+ueAFrUqzroKeO5KFA1mpe3TH5ULs1zysst5zIomvx5fOtJFjY9vUDY3fRWJag9Fj18WQE1vyspR4bpu8+BAOtsUDisIWj8ICCXqu6UGSkjyiuUQrjyCo9QHuqxjgu37JiqOOSEgJf/QAHOv+xG5TSPYFN/XBvEnLTLOlitpoTogqr6HSDHDX/GxyolHBXIyNVD6BRSx/bvICqzpnVHHKSpGy9szKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/5iJ3qpVyvn1uZV4cWNNX9C+d1A6dMOH+xMBwsi8f5g=;
 b=ZufGdeqB5WnkK3my28IHTRQCvQNPaD00WaPHYrOFLXJ6Eqva7WpXc+r8oDXYDxScoFTveRxhzTBWLyyHmJV0kJmjsckoG5+zmLP97bdEYsDARDwv8d0B3CloEw04rNDzLEb6Zs3LOwCKxMtpL2BEg0/J1CL+gK4dSUKze41uJkE=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 BY5PR12MB4228.namprd12.prod.outlook.com (2603:10b6:a03:20b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.21; Thu, 27 Feb
 2025 12:36:10 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb%5]) with mapi id 15.20.8489.019; Thu, 27 Feb 2025
 12:36:10 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH v2 4/4] drm/amdgpu/gfx12: Implement the GFX12 KCQ pipe
 reset
Thread-Topic: [PATCH v2 4/4] drm/amdgpu/gfx12: Implement the GFX12 KCQ pipe
 reset
Thread-Index: AQHbhGCioK/af2OWmkSNJcpFOLDJNbNbHdug
Date: Thu, 27 Feb 2025 12:36:10 +0000
Message-ID: <DS7PR12MB6005EFC45E880B99D77781BCFBCD2@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20250221130030.3703750-1-Prike.Liang@amd.com>
 <20250221130030.3703750-4-Prike.Liang@amd.com>
In-Reply-To: <20250221130030.3703750-4-Prike.Liang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=6c739780-0f03-4f69-b72a-684fa27ba99c;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-02-27T12:29:54Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|BY5PR12MB4228:EE_
x-ms-office365-filtering-correlation-id: e8a33059-0ef3-4387-55b2-08dd572b50c4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?nmlOmqwU9zCj5miLIE2kDGfJrIUacBzSanOptsHtjdFjR73Thi1BPUEoFJ93?=
 =?us-ascii?Q?ubnRDrRB+LrBytM6Br9S5FbPlqcF/e8clNEXmFrxGdWzVwyeZTKLfU0mGooJ?=
 =?us-ascii?Q?DO6n4g8m1jWm/L8Mg3+qpToJuRNaDKId2uxNeSRJBEyG3GmsU06TmcIc7Beb?=
 =?us-ascii?Q?EesLGqq/GL/wup9PVQOINcD1lqGmMCVyE/hHwSklGDXgghDAXfgRT3Kvk1OH?=
 =?us-ascii?Q?U5fDThjJa5ZpDSvYiLjjz8UnDrHHsgkvZB58nssY30Fy6b1px1kbrJeag4iU?=
 =?us-ascii?Q?uHb+cVByZR80pxUBCDmFRXt4iulsVO+m12xY38OU3B48MRJzQE3/9BsP6pVT?=
 =?us-ascii?Q?W1D4F2TMV6ZcOm8R2jbo8QmldUqav2Hns/l8zbrTj8qhGUnIQSi+1OdlKCtO?=
 =?us-ascii?Q?QSbb+CBSpWRHKuDuQ0qtKvBYONzHZD7vzjciTXS9EfIznTz/V4CoGTPh3QzP?=
 =?us-ascii?Q?RHRVIkGJscFBik+OZB0fxERq9MoqsY9nTMautKy/eRHTcf3FYJLB4CnPwa8V?=
 =?us-ascii?Q?hDq/H7RPDguuzx57qgZUjA5xzGGel97eRt1WGzKnUEF1PGhpme8ltX428tfB?=
 =?us-ascii?Q?jAX49k6cUaZw5ejJ13dIPCinxKqdJ5iVts90sAstxQJdqq9l42cwfMByGhEn?=
 =?us-ascii?Q?sQyC0V/AvprsJwFRYOoc6Bg1dyTgu0HPtkWz/Mcsk3RrGDR9O8nuaVnFBb1K?=
 =?us-ascii?Q?1QKDugkNbHsuZ4NzxGIB3Wl2+hSTicev2CWT/6PI6B3ELtiUWHiMVPjQSIEp?=
 =?us-ascii?Q?oe7/qBNW7qkn/Ietbs4VNv3KzmfvNo+jLNAlMitT3HkzQ26CRTx71Xu/twzk?=
 =?us-ascii?Q?qvMaqXWZLYNRMDDFbUc7oT11WAfRrh9gm8zUy4UN5hynYCXznBXY9Kcf6cU1?=
 =?us-ascii?Q?UA5oBZv5+4L1XqL6drnFou14fmeIKzO6xMjPbMPPKjlKV0CXT/84yGK+Eb3X?=
 =?us-ascii?Q?uQSu48KEXTt/HDKQp1MGBlBTT/oDimHD7heUDPgloY7I7RzplLJrjO98pqxq?=
 =?us-ascii?Q?ByjLCcVlKMDiV2HHr2+H7/83yZRf4/OOAo/rX3j2MHvtHTlVtTPo4MtrhwKo?=
 =?us-ascii?Q?pYR3SVyzE0dIojanOR1CYA7f4cgcY4Daa00PhqfTnBY6GZ6OhzcX5LfNOI9i?=
 =?us-ascii?Q?17C4TqQr01Nh5zzHqR2w/GgQBHX30uavKXABYMnrHEj//8QGPdPKRxX1ADTo?=
 =?us-ascii?Q?Y89Vx6ShC7nSfzHP8Q/wW6hunB3b7t7LbER9z3jQhXOOS9s21HUb2j1nWbOA?=
 =?us-ascii?Q?17Mtbhl73HCSpRHVAnd1glBvBNqBVc3scjQDmU5qpG5RK3Ci7OVcjvgpHQwE?=
 =?us-ascii?Q?/VCk9OAhdZXgsTxjCIrAutWN2SxoyuXgFuXiiz6Lz0JP6l4ouq4k3+WUAydj?=
 =?us-ascii?Q?mAYdeMU8NNi+kTVrKx3+xcD48pjsDcRAPrWu0X2l0sy+oFy4ym4Ho7awqT09?=
 =?us-ascii?Q?abgXjZNhZb8ruCGbsyFNhAcGZvTSNtaz?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0aXK3yRi0dD472xDz7ptog97WKlPaUWG+iy+kRVJ2BohEJ5QDMQECGh9sk4B?=
 =?us-ascii?Q?t8zZ1+Dfw1T3x8TSyV2e9zuh/BLEjXQ9nFxCg3VTOiKvfFQzrVc5KEtte9z3?=
 =?us-ascii?Q?nlpV0xYLM52Z7nGUgCkcOl8jjvizcPuuO5TvI+QeMfuRpif+FME4jEpHn6zW?=
 =?us-ascii?Q?la6rTPayYxV+LremWEuIF51148oyj82aYo9JZLKWXkum3//QPy8N9UR0PJ0s?=
 =?us-ascii?Q?JKD6iO/zFbQRq92/yyjNLJ8kFhyyrmtL0El9aXqF77GjW66zVCsr4qcH37u0?=
 =?us-ascii?Q?CGuNJLI1mTae07KMBnWmCSX4zovmHkzyAdlHWqsn7uSFx9yg1rWvk2ywOR/l?=
 =?us-ascii?Q?4RLOnMItzmtXQVuxtYKB5L+SlNpDiobadKOygGQhCdHSQDhVt+gB6/diCAuK?=
 =?us-ascii?Q?LP5TiXN89P/IMEoBoqpPl9SNm01fW6ODOq4PD6/HDxm2eFEpZQgXWUJoJKh3?=
 =?us-ascii?Q?IHMMH+i+z1roD2AGpbug8UxslMYws8UYjlHN8xD1upgce1miMYctcExAWlur?=
 =?us-ascii?Q?MkTdu7MLD7gtTgDMO4MK4Kc8O1a/cOSY76NhSu43/uH8WHYlnd69FBJBdc32?=
 =?us-ascii?Q?Y33o1Ovofkwc/QNUZcCdAarwFkg1u6GVfx4MmOtQXaBIeZNrvxHb9WHpmRzD?=
 =?us-ascii?Q?sB1Z+jLRN6YQlgFcUW+4VvlZSZyPcas1jwvSHAwqV+M2zVgPOjF2uh9vueKj?=
 =?us-ascii?Q?cVKO1UbvMUQJjc9+OPrV7s7sggUNhKhGgBVeNTPP0odboeLDgHepRPtqRRXy?=
 =?us-ascii?Q?zdiG82j0K3eq+G6zGmVoROmUHZmmzEiznLEgTspA0pBVsha734dv+te+IKDy?=
 =?us-ascii?Q?mo1sPMn69uB7gCR5jvfyUp1+eI6Z36Lca/ck3CH+LYoXJw4tpo0xMZy9dgYn?=
 =?us-ascii?Q?8s8UPU11WQOtgR8C6QNePrIp78AIg0ovR2S5hHFFIrHJX1FlnDbyHwHh5lwO?=
 =?us-ascii?Q?SpR6CUVAQ3ADetqjLkaH6uTrjhoWuH+Jl4hBANyO3nlk9nDnY3xCbSa6mjjA?=
 =?us-ascii?Q?IEBli7n1w4GKcjb08zUvXhFOHxmfIIgCoAUeirLRXjlVlye6a2bN2/Y+LJ38?=
 =?us-ascii?Q?fg8S0mv80sY7eg0/uipy6gDgGJgcvW7DXJ8WqMrJwuJ51eDV+G+1iNsS+2r2?=
 =?us-ascii?Q?PYoAl2U1pBkoBxWlJowYAkuMHVLIXppEHb5AdBROMYg4R90IzD8ZPw8qFSxY?=
 =?us-ascii?Q?wnpv8GuhwBEj8fKIbeetv3rAD0CDzxuZvr7pitwxqfk2FA4iX1ekbjKbgT1O?=
 =?us-ascii?Q?/0V4KN6dh4osKLu9plMT1jVesqzlOfsW7aBOPtN2d7EI1zNwCM0xPjwn/BN1?=
 =?us-ascii?Q?8OUtW9XNAS7l/BpyuQiWLr2IpMmzrEgaBEHqo2DQh504u2XfGoBOSrdzpURT?=
 =?us-ascii?Q?L2zGSBT2woupXXoXC9QEXajzoKruRvzw/JNzsnArNNJGC0WMIN/0KKQrO++L?=
 =?us-ascii?Q?sm0R5RgJeu03iUhm29wLbcxiuh6mnMu2HnJ9fVWFFqz2EDlb3O4RTVHpiFpz?=
 =?us-ascii?Q?J0YcothedGPigfFNzUoWNNWAHlNjA5RpluTFdjDKOol1lwzh9jDABlT1kZE6?=
 =?us-ascii?Q?8Gks9NRHyaElLmClXZI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8a33059-0ef3-4387-55b2-08dd572b50c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2025 12:36:10.6620 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2Icqxi5KeoAuw7yfVktFYUq5L/FZ8zg+HNmwHYepsWpMg1w9XMRk/ol0IwnZoh1T
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4228
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

[AMD Official Use Only - AMD Internal Distribution Only]

Please review the series patch to catch up the gfx latest base and to avoid=
 the commit merged problem.

Regards,
      Prike

> -----Original Message-----
> From: Liang, Prike <Prike.Liang@amd.com>
> Sent: Friday, February 21, 2025 9:01 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Liang, Prike
> <Prike.Liang@amd.com>
> Subject: [PATCH v2 4/4] drm/amdgpu/gfx12: Implement the GFX12 KCQ pipe
> reset
>
> Implement the GFX12 KCQ pipe reset, and disable the GFX12 kernel compute
> queue until the CPFW fully supports it.
>
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 90 +++++++++++++++++++++++++-
>  1 file changed, 88 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> index 79ae7d538844..103298938d22 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> @@ -5352,6 +5352,90 @@ static int gfx_v12_0_reset_kgq(struct amdgpu_ring
> *ring, unsigned int vmid)
>       return amdgpu_ring_test_ring(ring);
>  }
>
> +static int gfx_v12_0_reset_compute_pipe(struct amdgpu_ring *ring) {
> +
> +     struct amdgpu_device *adev =3D ring->adev;
> +     uint32_t reset_pipe =3D 0, clean_pipe =3D 0;
> +     int r;
> +
> +     if (!gfx_v12_pipe_reset_support(adev))
> +             return -EOPNOTSUPP;
> +
> +     gfx_v12_0_set_safe_mode(adev, 0);
> +     mutex_lock(&adev->srbm_mutex);
> +     soc24_grbm_select(adev, ring->me, ring->pipe, ring->queue, 0);
> +
> +     reset_pipe =3D RREG32_SOC15(GC, 0, regCP_MEC_RS64_CNTL);
> +     clean_pipe =3D reset_pipe;
> +
> +     if (adev->gfx.rs64_enable) {
> +
> +             switch (ring->pipe) {
> +             case 0:
> +                     reset_pipe =3D REG_SET_FIELD(reset_pipe,
> CP_MEC_RS64_CNTL,
> +                                                MEC_PIPE0_RESET, 1);
> +                     clean_pipe =3D REG_SET_FIELD(clean_pipe,
> CP_MEC_RS64_CNTL,
> +                                                MEC_PIPE0_RESET, 0);
> +                     break;
> +             case 1:
> +                     reset_pipe =3D REG_SET_FIELD(reset_pipe,
> CP_MEC_RS64_CNTL,
> +                                                MEC_PIPE1_RESET, 1);
> +                     clean_pipe =3D REG_SET_FIELD(clean_pipe,
> CP_MEC_RS64_CNTL,
> +                                                MEC_PIPE1_RESET, 0);
> +                     break;
> +             case 2:
> +                     reset_pipe =3D REG_SET_FIELD(reset_pipe,
> CP_MEC_RS64_CNTL,
> +                                                MEC_PIPE2_RESET, 1);
> +                     clean_pipe =3D REG_SET_FIELD(clean_pipe,
> CP_MEC_RS64_CNTL,
> +                                                MEC_PIPE2_RESET, 0);
> +                     break;
> +             case 3:
> +                     reset_pipe =3D REG_SET_FIELD(reset_pipe,
> CP_MEC_RS64_CNTL,
> +                                                MEC_PIPE3_RESET, 1);
> +                     clean_pipe =3D REG_SET_FIELD(clean_pipe,
> CP_MEC_RS64_CNTL,
> +                                                MEC_PIPE3_RESET, 0);
> +                     break;
> +             default:
> +                     break;
> +             }
> +             WREG32_SOC15(GC, 0, regCP_MEC_RS64_CNTL, reset_pipe);
> +             WREG32_SOC15(GC, 0, regCP_MEC_RS64_CNTL, clean_pipe);
> +             r =3D (RREG32_SOC15(GC, 0, regCP_MEC_RS64_INSTR_PNTR)
> << 2) - RS64_FW_UC_START_ADDR_LO;
> +     } else {
> +             switch (ring->pipe) {
> +             case 0:
> +                     reset_pipe =3D REG_SET_FIELD(reset_pipe, CP_MEC_CNT=
L,
> +                                                        MEC_ME1_PIPE0_RE=
SET,
> 1);
> +                     clean_pipe =3D REG_SET_FIELD(clean_pipe,
> CP_MEC_CNTL,
> +                                                        MEC_ME1_PIPE0_RE=
SET,
> 0);
> +                     break;
> +             case 1:
> +                     reset_pipe =3D REG_SET_FIELD(reset_pipe, CP_MEC_CNT=
L,
> +                                                        MEC_ME1_PIPE1_RE=
SET,
> 1);
> +                     clean_pipe =3D REG_SET_FIELD(clean_pipe,
> CP_MEC_CNTL,
> +                                                        MEC_ME1_PIPE1_RE=
SET,
> 0);
> +                     break;
> +             default:
> +             break;
> +             }
> +             WREG32_SOC15(GC, 0, regCP_MEC_CNTL, reset_pipe);
> +             WREG32_SOC15(GC, 0, regCP_MEC_CNTL, clean_pipe);
> +             /* Doesn't find the F32 MEC instruction pointer register, a=
nd
> suppose
> +              * the driver won't run into the F32 mode.
> +              */
> +     }
> +
> +     soc24_grbm_select(adev, 0, 0, 0, 0);
> +     mutex_unlock(&adev->srbm_mutex);
> +     gfx_v12_0_unset_safe_mode(adev, 0);
> +
> +     dev_info(adev->dev,"The ring %s pipe resets: %s\n", ring->name,
> +                     r =3D=3D 0 ? "successfully" : "failed");
> +     /* Need the ring test to verify the pipe reset result.*/
> +     return 0;
> +
> +}
>  static int gfx_v12_0_reset_kcq(struct amdgpu_ring *ring, unsigned int vm=
id)  {
>       struct amdgpu_device *adev =3D ring->adev; @@ -5362,8 +5446,10 @@
> static int gfx_v12_0_reset_kcq(struct amdgpu_ring *ring, unsigned int vmi=
d)
>
>       r =3D amdgpu_mes_reset_legacy_queue(ring->adev, ring, vmid, true);
>       if (r) {
> -             dev_err(adev->dev, "reset via MMIO failed %d\n", r);
> -             return r;
> +             dev_warn(adev->dev,"fail(%d) to reset kcq  and try pipe res=
et\n", r);
> +             r =3D gfx_v12_0_reset_compute_pipe(ring);
> +             if (r)
> +                     return r;
>       }
>
>       r =3D amdgpu_bo_reserve(ring->mqd_obj, false);
> --
> 2.34.1

