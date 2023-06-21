Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EE3EEB64D7
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Jun 2023 02:57:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 92B3C10E3A7;
	Wed, 21 Jun 2023 02:57:51 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3028310E3A7
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Jun 2023 02:57:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HLq0aINcaiIJKBbL+BarHomQ2HrDTrCAniFRk6hZ20EAFHQX8nuuTS5zZR2GFyUEw+vSyVAEVnSv87LqZ5gcte2viV4hQX5tCHLYNCkGRlt4+q2odx22FcZ+bOzQZHXY+mXuMhgN821jNx4iOF2q9UgB2R5SrZvdNG9fxmfSj2wth89Ng17FV1W1lp866ERqyhiPIMCk6Tvp2QK9MDTSbq/DRREzS4soK0gyEw8SRXgRj0eAaUD3M8zmnsZyIamfVXhx337QxZdVdJfKtrx9kYSLJxpF8GaPRbtr/Q0MCv/rgTQvH3TsGykCWbB/154vGntXXza7fDwOcfIOsuGEfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h5ZbVYEhRWQpGOnS1raot7mvknWVHYoRBn/HbMEch48=;
 b=JQM8O5CcfH7eMbMITwlxqpljB4Bx5OoJbnZ2V0imC/FOvgkZ/n24EfNdG+9yGYVeKiFIsFMl1/jFd7Vq1YsL4IxOyD7O2b/A6EpG/vPojyfiUyKPE7HOgijt5ve1r76z5IMmaWZ0CqUX0Fq+UdI0JzAxnVeF3LlZb4RyqSNucdLHWs1jHxFSxzQupJ3Hoa/hQTLo7wEfgEsiSfxdi0cfgi/Han1gZSze9P7hOdm3AamkdEiR8yGuOX2nvIxhtXCrP1Kt3Ozt4CbZy4LIII6xWvVei9cXJsBTbw984apfYKNhJBUMLknu8xkNmEUJz+DzfYMTK5H1Ysq9/I0xyxLGOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h5ZbVYEhRWQpGOnS1raot7mvknWVHYoRBn/HbMEch48=;
 b=Wz9MpIrelCyvnneqdbEHC7ND0P2j5XqU3bpvysQJERpkSAhPwuQObw0NlJuABJP7blupAAj+y5fu9qOK20248MlYllfnJV+y8jtE5AbBgRbR/ZJ9h+6TeDXsdGsxgka2pknlZzJw7I2W2bhbY2cdqQOR0pY/4gfAJVxR2kH+Kns=
Received: from BL1PR12MB5254.namprd12.prod.outlook.com (2603:10b6:208:31e::21)
 by DS0PR12MB7629.namprd12.prod.outlook.com (2603:10b6:8:13e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Wed, 21 Jun
 2023 02:57:46 +0000
Received: from BL1PR12MB5254.namprd12.prod.outlook.com
 ([fe80::6a85:14e2:2cfe:91fe]) by BL1PR12MB5254.namprd12.prod.outlook.com
 ([fe80::6a85:14e2:2cfe:91fe%4]) with mapi id 15.20.6521.020; Wed, 21 Jun 2023
 02:57:46 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Yang, Stanley" <Stanley.Yang@amd.com>, "Li, 
 Candice" <Candice.Li@amd.com>, "Chai, Thomas" <YiPeng.Chai@amd.com>
Subject: RE: [PATCH] drm/amdgpu: check RAS irq existence for VCN/JPEG
Thread-Topic: [PATCH] drm/amdgpu: check RAS irq existence for VCN/JPEG
Thread-Index: AQHZo+vXB2CijXjK9E+7vmiZCTI5nq+UkEcQ
Date: Wed, 21 Jun 2023 02:57:46 +0000
Message-ID: <BL1PR12MB525459075DD1F81CD5CCD6CFFC5DA@BL1PR12MB5254.namprd12.prod.outlook.com>
References: <20230621025516.19690-1-tao.zhou1@amd.com>
In-Reply-To: <20230621025516.19690-1-tao.zhou1@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=66d8a61e-8424-4fed-a61e-3b0fe26fdc36;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-06-21T02:57:05Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5254:EE_|DS0PR12MB7629:EE_
x-ms-office365-filtering-correlation-id: 51541504-eb82-488e-680b-08db72034a66
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: srUP8H8PUAnS97sqR0PWV0UYltXwUJ7WJRvT50Qlogd+JXQoA/N7yUGbpVZvHjYfYj6YB9aGfqrQvx4VHYUVbbclrgb5KiV41CMkrzwww/rnm5zQmQiApAuFRFzUoONt1f3sIo++pnE35AAsNrBNsrMoF+pnCgnna5FR83Cnu1RSel7Sr7ic0beo6vFJ9svKcSqdyCNvSv8Q5ar1bXkoIp8iOCrLc6JRYeUVs/jJ608ZR8R2N3JyNJFXe3SZCKA0hEY9ngHwbFsIIhmwaW8zIZkycVTf2XD08o+DsOPp6nQG4TxSgfiMEfONRBrRNfFxb1KTNIxQXRMTKzqAD7xHx10c/089S/rZyixQ3EQKLz0HXo7b5ma3KXtHCI0Jetgos71cu9yAt96QleGAnigFF6BqIugkZ9GDt0VnrXoNRX3FCc6vH7TWCsarGl0GpPKXaOU+8TdUVtpgTbicfD5HlX2W36W6OIgLIqcSRHPC7dl+th/wEdBQ6vM+PlOewvOxXlNsSihnrRswTPe9ptgAauQLIF9tHz2YOINaQRdbtPsv7sl9PTuePCEb/OU5jywQmGBSPEKZD5iJkqQ0cA72+9ndRTig8LxCs5hi049bkEWKhqLSZAlnVEETeQlq39D1
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5254.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(39860400002)(396003)(136003)(346002)(366004)(451199021)(41300700001)(5660300002)(8676002)(8936002)(38070700005)(2906002)(52536014)(33656002)(55016003)(86362001)(83380400001)(71200400001)(7696005)(478600001)(76116006)(53546011)(9686003)(6506007)(26005)(6636002)(186003)(66446008)(66946007)(66556008)(64756008)(66476007)(122000001)(110136005)(38100700002)(316002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Ym/ga5wOTHp+Qb4lGZgnJysgsYEtZ6DUVphWyXWlXUn9N+88ZV5VQu32SGew?=
 =?us-ascii?Q?8rWvrvKs/m8DfF9RQK7Xe6FJZOfeTzwP1RiSThxczFi1+AVzgqtWHNbCGbxN?=
 =?us-ascii?Q?qThtqpxNvO+X7dINBvEmdJPr1nJWNmw/ZiMfX+uOr1Ne9cszHgquF6I5pP7b?=
 =?us-ascii?Q?sy3uI7+n0ewqPUAvTpw17c8S0OZnA51ANoEKzzyVCQhJCFUEsYvbqwuftTOs?=
 =?us-ascii?Q?h/fIyOC335DfDegJzoz/ZvjW83Ldr68rkdzPTGYaXhKrDGt8FVH3kW4VvEYh?=
 =?us-ascii?Q?aXsaSTqNaZoFgEHFv2uBMY2i2mUyGFtx4Q+eY5rJS7Ol7ZfIAR4cXOcJywxs?=
 =?us-ascii?Q?BvumYX7jWo8P8Tws4giC67jkSh7xYBpnJmlvBn5A5AhAr/D1QVp3KGa/OYxh?=
 =?us-ascii?Q?aALfYoPtW2RGyKm6UiuGQhykQnCUOpaSpxMFael81/ikJp+iDyFVPtgyUavk?=
 =?us-ascii?Q?79cGf4VqYUm4gWxRVrttG9mTcWExMwfb7r/z+1E9XDiVRb4bPNLOeAu5LH+u?=
 =?us-ascii?Q?3WymeA01j+R6dsLzH5mcCQBwn7xNLmSsDJXM3BqoR7x4+WG5JMRRhFE5nnEn?=
 =?us-ascii?Q?FfOLGO9BiJs9qU/CaPlqqmXo9VAkgEBqxkCPdEl4wL86+47kaLsp8Z9QywgI?=
 =?us-ascii?Q?KmfcOtux0mKN9HgIVx1yjv1JPPph2J4lwmq3flQFzcC9cv7pqraHzzwVuOBj?=
 =?us-ascii?Q?d8l3PUbdc5pbgqla17Jm4Hjno4qeMcggWpbg9RMIZi6EgNbIXkH6g4Ez8DyI?=
 =?us-ascii?Q?EybkIVs0nmgRBmUX2dfQgI7SOhWawyGdflT0OYjuqhiIq05k6YSECW8Sxrr8?=
 =?us-ascii?Q?qqWls7nG0Uzn8ixbgHvIiBvkUxjdBbP2HlRh+Gcye5YUyJteAGR6aTl4quOF?=
 =?us-ascii?Q?WS0/goc3zkeu7dfb2rW12Bnij6t24CIKjUSbdBf0dCPtz4unUvrdN8M6tAR/?=
 =?us-ascii?Q?wCXysk+ul3hcZIXy5YbKrEonD60W3exAYOPjJG9Cfv7R+2XR8WWzMvXapBlQ?=
 =?us-ascii?Q?CrnqjQlC5k5csOmekcvhqanjaIdC0jlPkr8YAPCe7jK1kAVE5m9etVo9pnZy?=
 =?us-ascii?Q?WVK5n7KjeuuJOt/o3od9bgAp4RotRbAYlIVU+wX/pFKD0KtREldVdbkM403n?=
 =?us-ascii?Q?KRIE3SQEV9TX7SI4m/+u/BhPiezvABTe307vzMLMtnnoU0QrXUTPRn9Kydgr?=
 =?us-ascii?Q?LYvjTBqmLi4+joDIL/AFo3LxkdlaW6hHzDhtRPWtzovxMDhkLk3u1dl/X9Ha?=
 =?us-ascii?Q?4RisO6W1CrUUVt+eDCMZkaE/X4QSzAC5F+8uqjOhFtXe1k5faVnmlLpmWCSI?=
 =?us-ascii?Q?4EJfkOecty4MiK3I9/aDoaTkqpF+F7HjuoLURqMQI6gC8i2myWexD76a5TzB?=
 =?us-ascii?Q?erG+NGEvWaqZwLEE014xsrbPl/CFCArDpvSgC0FPu+FEqrpeANHPHApC4tqr?=
 =?us-ascii?Q?tJoTzjCLazfvm8l6HgJu6dMZYUgs5Y0lyU6Y/qAGsDOitI6KohQPJFn8sAu3?=
 =?us-ascii?Q?Joea3UGJwEe3J5X8a8KCrPA1GH91MuaNAfFI0kbuYpg6sKfIZ4YzQcVT0Sie?=
 =?us-ascii?Q?rIqtNgZ7O6bbxpVbXaiZcmHi1MpnoN579r8kTln0?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5254.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51541504-eb82-488e-680b-08db72034a66
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2023 02:57:46.1629 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CoToLhxPPQ+Br7xr4Fn6pCuIyfhUSOdammd4n+9f1AtcNAyo8HuGLZ+su37OS74Tz1zQfqXJyBbSC9/514uC+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7629
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

[AMD Official Use Only - General]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Zhou1, Tao <Tao.Zhou1@amd.com>
Sent: Wednesday, June 21, 2023 10:55
To: amd-gfx@lists.freedesktop.org; Yang, Stanley <Stanley.Yang@amd.com>; Zh=
ang, Hawking <Hawking.Zhang@amd.com>; Li, Candice <Candice.Li@amd.com>; Cha=
i, Thomas <YiPeng.Chai@amd.com>
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
Subject: [PATCH] drm/amdgpu: check RAS irq existence for VCN/JPEG

No RAS irq is allowed.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c | 3 ++-  drivers/gpu/drm/amd/amdg=
pu/amdgpu_vcn.c  | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_jpeg.c
index 3add4b4f0667..2ff2897fd1db 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
@@ -255,7 +255,8 @@ int amdgpu_jpeg_ras_late_init(struct amdgpu_device *ade=
v, struct ras_common_if *

        if (amdgpu_ras_is_supported(adev, ras_block->block)) {
                for (i =3D 0; i < adev->jpeg.num_jpeg_inst; ++i) {
-                       if (adev->jpeg.harvest_config & (1 << i))
+                       if (adev->jpeg.harvest_config & (1 << i) ||
+                           !adev->jpeg.inst[i].ras_poison_irq.funcs)
                                continue;

                        r =3D amdgpu_irq_get(adev, &adev->jpeg.inst[i].ras_=
poison_irq, 0); diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/driv=
ers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 19a3bb5dd29a..d37ebd4402ef 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -1216,7 +1216,8 @@ int amdgpu_vcn_ras_late_init(struct amdgpu_device *ad=
ev, struct ras_common_if *r

        if (amdgpu_ras_is_supported(adev, ras_block->block)) {
                for (i =3D 0; i < adev->vcn.num_vcn_inst; i++) {
-                       if (adev->vcn.harvest_config & (1 << i))
+                       if (adev->vcn.harvest_config & (1 << i) ||
+                           !adev->vcn.inst[i].ras_poison_irq.funcs)
                                continue;

                        r =3D amdgpu_irq_get(adev, &adev->vcn.inst[i].ras_p=
oison_irq, 0);
--
2.35.1

