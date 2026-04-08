Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0057E1073CBD
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Apr 2026 13:36:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9413E10E65D;
	Wed,  8 Apr 2026 13:36:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qXNYwfHZ";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011047.outbound.protection.outlook.com [52.101.62.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 58A6510E65D
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Apr 2026 13:36:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A6r1UmNEMFg85pD2lZmXGGiUeqCIfjdqmkpk2rklnfjN1agVfBHcv1q+u/RdJrNYCz/aqAhAYbPNE7UfFEfI7yUfQUI4AHF9fOw6Cpcly3LMXC8N8YEEohpC9gfst/vYJfplLSnl987r2MYYhGuKQEM6bdu8xHzmQD86AmIWZiOQl14DeW57XlJ7/n3MRTaR/nkAXOAZLFnmCBJvLJ+fbdmtur2AFPuswjSGLgF9HLZxLA3qkJLtR5eOiQ7aoK/hbjDJq6/M3xUI2Ali9sKwT/m4qr2c1CVeCtOIajqWovpFrSfht2CsCwG3CqfId3qd9irb5bxOUXrdgYKBJIxrcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fSocdPshE6LDCKA9HkcvVPFbcMKbE/yLsD+UumBBbH8=;
 b=SBWi4ATU/SGY1jpzP2XqCqM4e1p3VLbI1Y6xnuI0AB0m3GOjSHo6XJKH6WSxJ//mp6gbMt1lXXGN9eaN2nBtUOJabpZ9kKqKmX01bId0DfaINdOi2MQ+o7rsuwPyEmgFIjekeACQ9f+Dg3uM4JSFc3ugB32G4d81Y40NorZ4uXEHd9rMze195ivIexncWysXlpWmOc2KaOF+7uFoI5S35WodpFrSWy6mtUa26lmFUzMyWa6sUrLNuyicpa/ytKuB3HlKnQ0NL0s2/6GRdVOXpICaoO/Dkvlaw2yfty07O2D6VtjUMbfurrQq5CtkNhdxhwCZq/ok2mc6banIk1Xlyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fSocdPshE6LDCKA9HkcvVPFbcMKbE/yLsD+UumBBbH8=;
 b=qXNYwfHZ0PMHrE3cP9D72kKa32M89CYRBTID5qFeGxW2VxhKPqzqtZVFyiFh3SLSiE7SuD5VvKTkVFsm1H9s62Du6Od/o6K5a18HxHu1GRC+gjawVi0Bq2WGRgD+iHk8Ag9FkdGz5LpeDJLhCnaXvLGWwy+to8gNq+qzL492Q4k=
Received: from SJ1PR12MB6194.namprd12.prod.outlook.com (2603:10b6:a03:458::12)
 by DM6PR12MB4234.namprd12.prod.outlook.com (2603:10b6:5:213::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.19; Wed, 8 Apr
 2026 13:36:11 +0000
Received: from SJ1PR12MB6194.namprd12.prod.outlook.com
 ([fe80::2201:99d6:c63e:3d2a]) by SJ1PR12MB6194.namprd12.prod.outlook.com
 ([fe80::2201:99d6:c63e:3d2a%4]) with mapi id 15.20.9769.018; Wed, 8 Apr 2026
 13:36:10 +0000
From: "Dong, Ruijing" <Ruijing.Dong@amd.com>
To: "Cheng, Benjamin" <Benjamin.Cheng@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Liu, Leo" <Leo.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Wu, David" <David.Wu3@amd.com>, "Cheng, Benjamin" <Benjamin.Cheng@amd.com>
Subject: RE: [PATCH v3 3/3] drm/amdgpu/vcn: Factor out vcn_v{3,4}_0_dec_msg
Thread-Topic: [PATCH v3 3/3] drm/amdgpu/vcn: Factor out vcn_v{3,4}_0_dec_msg
Thread-Index: AQHcx1bh40z44VqxTUSW/XVTrV5awLXVKo3Q
Date: Wed, 8 Apr 2026 13:36:10 +0000
Message-ID: <SJ1PR12MB619423DD6FE236C6357C3040955BA@SJ1PR12MB6194.namprd12.prod.outlook.com>
References: <20260408125426.2118644-1-benjamin.cheng@amd.com>
 <20260408125426.2118644-3-benjamin.cheng@amd.com>
In-Reply-To: <20260408125426.2118644-3-benjamin.cheng@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-04-08T13:35:51.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR12MB6194:EE_|DM6PR12MB4234:EE_
x-ms-office365-filtering-correlation-id: 7e36ebbb-42e8-4b8d-2df4-08de9573cbe4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info: UjW/O+VjIekr7t0u0Sr6dejx6xXci6lJQaTcMdhUM7mcgjFJICKDcKWoJfUG2onogKa0GG252EhBoB59B3CfBj1GpbYhBefRVoBZXEjuad/QwTDnAyPJnz1MeoMnfwLUI+P30vnXF3GbHny1eht+8cPcYITCS5sR9UkRBqTxWwOHDyPxliSO45qWLazr8qQBu+QqQMEJ+RwnLtJNMRIf9Qtk/rh/YzT6sLvBDLrjl4ORQ086aq3fXHrIRO1ANlRNiEkl7p9PIv/J5w1geJnZdZfV20MpR+hlji2oiwTm+iFnxQL0ML5ORU6oRKNG8cwrGreTV+ilJK9+nk511XrOwqZia9+aFqM9iZz9ngoACxA59eXI4UhMMZmmn1kBhurL3YIoFBsFqw1t0HcKZuWXwxw4vc+FSuc986/SC6UvVmO+wVsySAngZcHcGMd8ioM/yQHlGj2aRCqpgkTj0NPkv1B+86YaBsZJbUvZALGxmeDpdMAbhk7XkSMKca54wZoFdw7dAiLQRgQHnES3nIdd6H4qMg8u+NGmGQ+qpyLPINe56eNNuG6zVsf571r3/ZuZnN6xx/INVKXRATHVBqSr3E09zPv6vAHkijrtFgF4n0iiJhitJXfXxRBo2WMaRmklhQgBd1sp0pecmxysspbD2TzCd/k2LC4CoQPmWDBg7Ajk+woHpnIFrdyTvdm4G4bFy1l0BydnJGxtuGZC/YjWULwaprIVVk/hJHtIARzpAxkRB8iGa5An0C8+z0GS4DDTVdGOLTlyEdbJyNANnfpFzWvt2xkeeMWSCSS9q12jxgE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ1PR12MB6194.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3eQfOM4rEKNDjuNf2duh51ZnNkITmvaeYghKMH5F95nB5600ndIEnIKyWqL5?=
 =?us-ascii?Q?IQYbXTUdpDBK21D2ZIZGidUJjzBIJgQfjZSoWGYMu/pqUDx0J3LVppIOTmmr?=
 =?us-ascii?Q?rzNqIznAIK6rsEpNsYHQKSsSZn9i7BXeG8PXYQ5ZuGG6qb97fVE14qoLS8aB?=
 =?us-ascii?Q?8IY7HEZqACgd6UiQOCOFVLrUdN8TZiX+FxSaqLIJhjdv3h9q6WK6jo4B/O7m?=
 =?us-ascii?Q?yq9GvQfUSw2I10NiLbAY+xI0UNNs0qoEtvXV7bGylbJvX2hcmEjztLX7bR6D?=
 =?us-ascii?Q?ns/++TeGMFbfj/EUtRetnLkbxwQT+MGC062DcoUKLtW76s9YM+WovwmBB1HN?=
 =?us-ascii?Q?i6bxeMyXfEknrePULoEKotiXnBCLErgU6vOyoNalXssSRydMB3eEO+t0LwoN?=
 =?us-ascii?Q?vtV+baaqMXHEG93jsIgR81/J+dhays3Xiw9hJhrx8s1TwJ5Gq9uomPLbIoFC?=
 =?us-ascii?Q?YpYeEiIa9eeB5jOdn0D/p0c2U3PFLb5Q2f34OrEtMAoiA/gbi6iqiF2PnW6G?=
 =?us-ascii?Q?Pv7N44wF+qtxCl0NUMIHjMULDZPebc5/Goou9SvVg4yBB+O3wZunjqhLNY0o?=
 =?us-ascii?Q?yUNdwYnoasUyCujCs5+TmUz+TfXpiDHRr50hmlgbIq8U/BV1qdf32ERZsPM9?=
 =?us-ascii?Q?Qt5fCQdEOiOpL08sRQqVc9zsitXrJIbI4148fVn76Tm4k4AkdLtwAaYuAWTB?=
 =?us-ascii?Q?Ay65st40FpISuIy+F+a7RlbhDIkSmxwrN0tuBsr0necsXmtqp8eI8oZ38q70?=
 =?us-ascii?Q?gSyuHsDFUcWiH0yh69E5mgBSxhfar+Dnp8+7CkbjDCmu7FJyVHBg/P/36oCI?=
 =?us-ascii?Q?3RMwKjhDus8yYlt1LcqV4d/ekDL7XmVgXfjhs7atBX7kgI+7QHEPhIwUzfCX?=
 =?us-ascii?Q?XlfI3k6fJNbt4V/OXhkepLkxTEgcZQnFPZxAWhKVnJ0kJH1riMmnKKJizNsm?=
 =?us-ascii?Q?vB/FW2upv7qsMwHGjykybtvWeDMzh9ueNC2wLyUP8+DbID+GIgOZ6G6IB2Uu?=
 =?us-ascii?Q?azB56Lnj4beZtBV0Uc/SRpTMkc9Jp7BBh+8uuFKsHuHKQ47o+EThanFQu2T/?=
 =?us-ascii?Q?DRhpb9nrox+g/dIFzl6sTODWfqrL+J8YLAG0qoktpEc9FpUc3U0DV+tjm135?=
 =?us-ascii?Q?Bmokrr2hHPFVPaMGRAeYbhGb4ztiMc+GJVqesUvRL2OaiBicRD21lgtfZ/Xa?=
 =?us-ascii?Q?Lm+6r2QbxLKkq+w08o9SucVD4glZNnMm7HcE9EDQe0pKDR1E/Dp+yNWSY1t7?=
 =?us-ascii?Q?m8HRx63pf7ih8HCQcPG+Hp1QY9BB8e4YvBM8cKl3CfvA9bc2lkhme8kDfdID?=
 =?us-ascii?Q?BduwL7QpdMUThxJxuWHa8hIQaiZLbhiHZSr1ZSMwvbj1HQ4I6r7N1pwAUwE5?=
 =?us-ascii?Q?CK5dKBDwP8CHFg/n4ya50+UPgaHidW9RF1WUo+RUJ7HEFbxaqfw+PksgtT1s?=
 =?us-ascii?Q?wEG02UkZEkS+IblUwjGdRxk1AiuR9eB9NkSMxNeZxU1v1/bF8HPhfbKccqjO?=
 =?us-ascii?Q?oJVS2VOt5S80/gsjIX1lmJqO4yxe7yw/Na/A0bpGUywIHeryTVQIkzdNoiLz?=
 =?us-ascii?Q?/Ax7Nf1xYql4KVFH8tiruRili9hB/Z8SmmNqY/zM36xjqD9EOBlyprU3Yo+a?=
 =?us-ascii?Q?qSyAvV0O4I+iNztGdo5vGTsdFRc1sV1OTKEOT9zkL+b8PByhQPNjdswygwan?=
 =?us-ascii?Q?Ff7jOtVAjFLKNYCtTOVD8+8TIasezkFW9WVgaT0rpBhJ9XZ0?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e36ebbb-42e8-4b8d-2df4-08de9573cbe4
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2026 13:36:10.7228 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Pa/SOQbf0r06ix2x4tnvXZj3VbO0NRg3mAYALkEoykVB0/egh4G2t5gRkgPtSf1z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4234
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

Reviewed-by: Ruijing Dong <ruijing.dong@amd.com>

Thanks,
Ruijing

-----Original Message-----
From: Benjamin Cheng <benjamin.cheng@amd.com>
Sent: Wednesday, April 8, 2026 8:54 AM
To: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Chri=
stian.Koenig@amd.com>; Liu, Leo <Leo.Liu@amd.com>; amd-gfx@lists.freedeskto=
p.org
Cc: Wu, David <David.Wu3@amd.com>; Dong, Ruijing <Ruijing.Dong@amd.com>; Ch=
eng, Benjamin <Benjamin.Cheng@amd.com>
Subject: [PATCH v3 3/3] drm/amdgpu/vcn: Factor out vcn_v{3,4}_0_dec_msg

Both vcn_v3_0 and vcn_v4_0 use the same interface, so unify the code.

Signed-off-by: Benjamin Cheng <benjamin.cheng@amd.com>
---
v2: Moved RDECODE_* defines to header in patch #1.

 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 100 +++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |   5 ++
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c   | 102 +-----------------------
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c   | 101 +----------------------
 4 files changed, 109 insertions(+), 199 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_vcn.c
index 03d95dca93d7..10aff7da52b6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -1641,3 +1641,103 @@ void amdgpu_vcn_print_ip_state(struct amdgpu_ip_blo=
ck *ip_block, struct drm_prin
                }
        }
 }
+
+int amdgpu_vcn_dec_msg_limit_sched(struct amdgpu_cs_parser *p,
+                                  struct amdgpu_job *job, uint64_t addr,
+                                  int (*limit_sched)(struct amdgpu_cs_pars=
er *,
+                                                     struct amdgpu_job *))
+{
+       struct ttm_operation_ctx ctx =3D { false, false };
+       struct amdgpu_device *adev =3D p->adev;
+       struct amdgpu_bo_va_mapping *map;
+       uint32_t *msg, num_buffers, len_dw;
+       struct amdgpu_bo *bo;
+       uint64_t start, end;
+       unsigned int i;
+       void *ptr;
+       int r;
+
+       addr &=3D AMDGPU_GMC_HOLE_MASK;
+       r =3D amdgpu_cs_find_mapping(p, addr, &bo, &map);
+       if (r) {
+               DRM_ERROR("Can't find BO for addr 0x%08llx\n", addr);
+               return r;
+       }
+
+       start =3D map->start * AMDGPU_GPU_PAGE_SIZE;
+       end =3D (map->last + 1) * AMDGPU_GPU_PAGE_SIZE;
+       if (addr & 0x7) {
+               DRM_ERROR("VCN messages must be 8 byte aligned!\n");
+               return -EINVAL;
+       }
+
+       if (end - addr < 16) {
+               DRM_ERROR("VCN messages must be at least 4 DWORDs!\n");
+               return -EINVAL;
+       }
+
+       bo->flags |=3D AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED;
+       amdgpu_bo_placement_from_domain(bo, bo->allowed_domains);
+       r =3D ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
+       if (r) {
+               DRM_ERROR("Failed validating the VCN message BO (%d)!\n", r=
);
+               return r;
+       }
+
+       r =3D amdgpu_bo_kmap(bo, &ptr);
+       if (r) {
+               DRM_ERROR("Failed mapping the VCN message (%d)!\n", r);
+               return r;
+       }
+
+       msg =3D ptr + addr - start;
+
+       if (msg[1] > end - addr) {
+               DRM_ERROR("VCN message header does not fit in BO!\n");
+               r =3D -EINVAL;
+               goto out;
+       }
+
+       if (msg[3] !=3D VCN_DEC_MSG_CREATE)
+               goto out;
+
+       len_dw =3D msg[1] / 4;
+       num_buffers =3D msg[2];
+
+       /* Verify that all indices fit within the claimed length. Each inde=
x is 4 DWORDs */
+       if (num_buffers > len_dw || 6 + num_buffers * 4 > len_dw) {
+               DRM_ERROR("VCN message has too many buffers!\n");
+               r =3D -EINVAL;
+               goto out;
+       }
+
+       for (i =3D 0, msg =3D &msg[6]; i < num_buffers; ++i, msg +=3D 4) {
+               uint32_t offset, size, *create;
+
+               if (msg[0] !=3D VCN_DEC_MESSAGE_CREATE)
+                       continue;
+
+               offset =3D msg[1];
+               size =3D msg[2];
+
+               if (size < 4 || offset + size > end - addr) {
+                       DRM_ERROR("VCN message buffer exceeds BO bounds!\n"=
);
+                       r =3D -EINVAL;
+                       goto out;
+               }
+
+               create =3D ptr + addr + offset - start;
+
+               /* H264, HEVC and VP9 can run on any instance */
+               if (create[0] =3D=3D 0x7 || create[0] =3D=3D 0x10 || create=
[0] =3D=3D 0x11)
+                       continue;
+
+               r =3D limit_sched(p, job);
+               if (r)
+                       goto out;
+       }
+
+out:
+       amdgpu_bo_kunmap(bo);
+       return r;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_vcn.h
index e72687246235..ad6ca7aa74bd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -573,4 +573,9 @@ void amdgpu_vcn_print_ip_state(struct amdgpu_ip_block *=
ip_block, struct drm_prin  void amdgpu_vcn_get_profile(struct amdgpu_device=
 *adev);  void amdgpu_vcn_put_profile(struct amdgpu_device *adev);

+int amdgpu_vcn_dec_msg_limit_sched(struct amdgpu_cs_parser *p, struct amdg=
pu_job *job,
+                                  uint64_t addr,
+                                  int (*limit_sched)(struct amdgpu_cs_pars=
er *,
+                                                     struct amdgpu_job *))=
;
+
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/am=
dgpu/vcn_v3_0.c
index 64531ad56c48..38a4fcf5872e 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -1900,104 +1900,6 @@ static int vcn_v3_0_limit_sched(struct amdgpu_cs_pa=
rser *p,
        return 0;
 }

-static int vcn_v3_0_dec_msg(struct amdgpu_cs_parser *p, struct amdgpu_job =
*job,
-                           uint64_t addr)
-{
-       struct ttm_operation_ctx ctx =3D { false, false };
-       struct amdgpu_device *adev =3D p->adev;
-       struct amdgpu_bo_va_mapping *map;
-       uint32_t *msg, num_buffers, len_dw;
-       struct amdgpu_bo *bo;
-       uint64_t start, end;
-       unsigned int i;
-       void *ptr;
-       int r;
-
-       addr &=3D AMDGPU_GMC_HOLE_MASK;
-       r =3D amdgpu_cs_find_mapping(p, addr, &bo, &map);
-       if (r) {
-               DRM_ERROR("Can't find BO for addr 0x%08Lx\n", addr);
-               return r;
-       }
-
-       start =3D map->start * AMDGPU_GPU_PAGE_SIZE;
-       end =3D (map->last + 1) * AMDGPU_GPU_PAGE_SIZE;
-       if (addr & 0x7) {
-               DRM_ERROR("VCN messages must be 8 byte aligned!\n");
-               return -EINVAL;
-       }
-
-       if (end - addr < 16) {
-               DRM_ERROR("VCN messages must be at least 4 DWORDs!\n");
-               return -EINVAL;
-       }
-
-       bo->flags |=3D AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED;
-       amdgpu_bo_placement_from_domain(bo, bo->allowed_domains);
-       r =3D ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
-       if (r) {
-               DRM_ERROR("Failed validating the VCN message BO (%d)!\n", r=
);
-               return r;
-       }
-
-       r =3D amdgpu_bo_kmap(bo, &ptr);
-       if (r) {
-               DRM_ERROR("Failed mapping the VCN message (%d)!\n", r);
-               return r;
-       }
-
-       msg =3D ptr + addr - start;
-
-       if (msg[1] > end - addr) {
-               DRM_ERROR("VCN message header does not fit in BO!\n");
-               r =3D -EINVAL;
-               goto out;
-       }
-
-       if (msg[3] !=3D VCN_DEC_MSG_CREATE)
-               goto out;
-
-       len_dw =3D msg[1] / 4;
-       num_buffers =3D msg[2];
-
-       /* Verify that all indices fit within the claimed length. Each inde=
x is 4 DWORDs */
-       if (num_buffers > len_dw || 6 + num_buffers * 4 > len_dw) {
-               DRM_ERROR("VCN message has too many buffers!\n");
-               r =3D -EINVAL;
-               goto out;
-       }
-
-       for (i =3D 0, msg =3D &msg[6]; i < num_buffers; ++i, msg +=3D 4) {
-               uint32_t offset, size, *create;
-
-               if (msg[0] !=3D VCN_DEC_MESSAGE_CREATE)
-                       continue;
-
-               offset =3D msg[1];
-               size =3D msg[2];
-
-               if (size < 4 || offset + size > end - addr) {
-                       DRM_ERROR("VCN message buffer exceeds BO bounds!\n"=
);
-                       r =3D -EINVAL;
-                       goto out;
-               }
-
-               create =3D ptr + addr + offset - start;
-
-               /* H264, HEVC and VP9 can run on any instance */
-               if (create[0] =3D=3D 0x7 || create[0] =3D=3D 0x10 || create=
[0] =3D=3D 0x11)
-                       continue;
-
-               r =3D vcn_v3_0_limit_sched(p, job);
-               if (r)
-                       goto out;
-       }
-
-out:
-       amdgpu_bo_kunmap(bo);
-       return r;
-}
-
 static int vcn_v3_0_ring_patch_cs_in_place(struct amdgpu_cs_parser *p,
                                           struct amdgpu_job *job,
                                           struct amdgpu_ib *ib)
@@ -2021,8 +1923,8 @@ static int vcn_v3_0_ring_patch_cs_in_place(struct amd=
gpu_cs_parser *p,
                        msg_hi =3D val;
                } else if (reg =3D=3D PACKET0(p->adev->vcn.inst[ring->me].i=
nternal.cmd, 0) &&
                           val =3D=3D 0) {
-                       r =3D vcn_v3_0_dec_msg(p, job,
-                                            ((u64)msg_hi) << 32 | msg_lo);
+                       r =3D amdgpu_vcn_dec_msg_limit_sched(p, job, ((u64)=
msg_hi) << 32 | msg_lo,
+                                                          vcn_v3_0_limit_s=
ched);
                        if (r)
                                return r;
                }
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/am=
dgpu/vcn_v4_0.c
index a89e316a4add..41215ad7dfac 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -1817,104 +1817,6 @@ static int vcn_v4_0_limit_sched(struct amdgpu_cs_pa=
rser *p,
        return 0;
 }

-static int vcn_v4_0_dec_msg(struct amdgpu_cs_parser *p, struct amdgpu_job =
*job,
-                           uint64_t addr)
-{
-       struct ttm_operation_ctx ctx =3D { false, false };
-       struct amdgpu_device *adev =3D p->adev;
-       struct amdgpu_bo_va_mapping *map;
-       uint32_t *msg, num_buffers, len_dw;
-       struct amdgpu_bo *bo;
-       uint64_t start, end;
-       unsigned int i;
-       void *ptr;
-       int r;
-
-       addr &=3D AMDGPU_GMC_HOLE_MASK;
-       r =3D amdgpu_cs_find_mapping(p, addr, &bo, &map);
-       if (r) {
-               DRM_ERROR("Can't find BO for addr 0x%08llx\n", addr);
-               return r;
-       }
-
-       start =3D map->start * AMDGPU_GPU_PAGE_SIZE;
-       end =3D (map->last + 1) * AMDGPU_GPU_PAGE_SIZE;
-       if (addr & 0x7) {
-               DRM_ERROR("VCN messages must be 8 byte aligned!\n");
-               return -EINVAL;
-       }
-
-       if (end - addr < 16) {
-               DRM_ERROR("VCN messages must be at least 4 DWORDs!\n");
-               return -EINVAL;
-       }
-
-       bo->flags |=3D AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED;
-       amdgpu_bo_placement_from_domain(bo, bo->allowed_domains);
-       r =3D ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
-       if (r) {
-               DRM_ERROR("Failed validating the VCN message BO (%d)!\n", r=
);
-               return r;
-       }
-
-       r =3D amdgpu_bo_kmap(bo, &ptr);
-       if (r) {
-               DRM_ERROR("Failed mapping the VCN message (%d)!\n", r);
-               return r;
-       }
-
-       msg =3D ptr + addr - start;
-
-       if (msg[1] > end - addr) {
-               DRM_ERROR("VCN message header does not fit in BO!\n");
-               r =3D -EINVAL;
-               goto out;
-       }
-
-       if (msg[3] !=3D VCN_DEC_MSG_CREATE)
-               goto out;
-
-       len_dw =3D msg[1] / 4;
-       num_buffers =3D msg[2];
-
-       /* Verify that all indices fit within the claimed length. Each inde=
x is 4 DWORDs */
-       if (num_buffers > len_dw || 6 + num_buffers * 4 > len_dw) {
-               DRM_ERROR("VCN message has too many buffers!\n");
-               r =3D -EINVAL;
-               goto out;
-       }
-
-       for (i =3D 0, msg =3D &msg[6]; i < num_buffers; ++i, msg +=3D 4) {
-               uint32_t offset, size, *create;
-
-               if (msg[0] !=3D VCN_DEC_MESSAGE_CREATE)
-                       continue;
-
-               offset =3D msg[1];
-               size =3D msg[2];
-
-               if (size < 4 || offset + size > end - addr) {
-                       DRM_ERROR("VCN message buffer exceeds BO bounds!\n"=
);
-                       r =3D -EINVAL;
-                       goto out;
-               }
-
-               create =3D ptr + addr + offset - start;
-
-               /* H264, HEVC and VP9 can run on any instance */
-               if (create[0] =3D=3D 0x7 || create[0] =3D=3D 0x10 || create=
[0] =3D=3D 0x11)
-                       continue;
-
-               r =3D vcn_v4_0_limit_sched(p, job);
-               if (r)
-                       goto out;
-       }
-
-out:
-       amdgpu_bo_kunmap(bo);
-       return r;
-}
-
 #define RADEON_VCN_ENGINE_TYPE_ENCODE                  (0x00000002)
 #define RADEON_VCN_ENGINE_TYPE_DECODE                  (0x00000003)
 #define RADEON_VCN_ENGINE_INFO                         (0x30000001)
@@ -1957,7 +1859,8 @@ static int vcn_v4_0_ring_patch_cs_in_place(struct amd=
gpu_cs_parser *p,

                        msg_buffer_addr =3D ((u64)amdgpu_ib_get_value(ib, i=
dx + 7)) << 32 |
                                amdgpu_ib_get_value(ib, idx + 8);
-                       return vcn_v4_0_dec_msg(p, job, msg_buffer_addr);
+                       return amdgpu_vcn_dec_msg_limit_sched(p, job, msg_b=
uffer_addr,
+                                                             vcn_v4_0_limi=
t_sched);
                } else if (val =3D=3D RADEON_VCN_ENGINE_TYPE_ENCODE) {
                        sidx =3D vcn_v4_0_enc_find_ib_param(ib, RENCODE_IB_=
PARAM_SESSION_INIT, idx);
                        if (sidx >=3D 0 &&
--
2.53.0

