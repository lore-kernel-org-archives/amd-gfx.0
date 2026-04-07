Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29523FF5138
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Apr 2026 20:46:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B736610E4BA;
	Tue,  7 Apr 2026 20:46:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XpuzUPtb";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011006.outbound.protection.outlook.com [52.101.52.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7CED010E4BA
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Apr 2026 20:46:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UAXAn7+4Hiu2NVJdytq/sG6CQz9bziZlFl9Woeou8oI82WYqeGl/3Vus80Hiou+TFvMt2Tp716Lov56cihBDlzZJ9K41xP6T6xevYuPaj+yXKnOH3aeuH54OxEh+AyXZvP4Zqm1YimKDfuOt1w+q/Rtbri0vdBDrEcvSEMgggZvgJqugiekAAfedcHGcTkhfOmdr9e5L4o+xX8NHrd9qVrEooPd617FwFWwqhXviZmgxgRApT8Ws6LD7ytpiMPWXAHGDas/qC6Gru6+no3ga3XQaJejtzO3hyxeyXa6e0v+50fpg6kx6s4LPZ06rVs1tyDfqJcr4t8R+g1K26HP7Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sQI4dbMhMZSJnUL2/n52cjx3o/N0Owhb2hOelLdKC5w=;
 b=aMtevYpmzT8akrzeBRDse2V33cDSGsM4Za21XBNqZlhp0Jws6RctFFuxhG6y2bDsPlvm/t6A5on30mN9HOnFwGiBj3GDal60uKrkbuA5MZEIz82klpIRU6GNgNbKwiMu7TtfhDux8GTD7gn6YjXCt2lnnQ0CuRQLEws86jjsXG895y9ngJb3wPh9Q530CVjKGTahoTBLxoaxR7byb6wuhBwbdotCQuWkKe6DZvpgEZ1/d6DC6xGixY0SRPdC2xRaZIqCf8Msqva3Kp+O/nhlCkxe13uroorkxF6dQsvnxXbrO6EOF9o93eGTIWmy+7KUX0p2AuDXIgyRpJCx5S5nag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sQI4dbMhMZSJnUL2/n52cjx3o/N0Owhb2hOelLdKC5w=;
 b=XpuzUPtbHQpbLmAXKRq4j/3fTUhIO3n+RET3xNZ4Ypl7ar02myKh+1/gI6AdS2PllAchrT0IUZSPeRtGY9DCZnPbfWQr6mI181d6iEcBlQe1S87f+qBknkHfYNJakrElVuUp/JTFNOH8Zi+mxk94rzhdKwCjE7bFtSuit9KBPHo=
Received: from SJ1PR12MB6194.namprd12.prod.outlook.com (2603:10b6:a03:458::12)
 by SJ0PR12MB6712.namprd12.prod.outlook.com (2603:10b6:a03:44e::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Tue, 7 Apr
 2026 20:46:48 +0000
Received: from SJ1PR12MB6194.namprd12.prod.outlook.com
 ([fe80::2201:99d6:c63e:3d2a]) by SJ1PR12MB6194.namprd12.prod.outlook.com
 ([fe80::2201:99d6:c63e:3d2a%4]) with mapi id 15.20.9769.018; Tue, 7 Apr 2026
 20:46:48 +0000
From: "Dong, Ruijing" <Ruijing.Dong@amd.com>
To: "Cheng, Benjamin" <Benjamin.Cheng@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Liu, Leo" <Leo.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Wu, David" <David.Wu3@amd.com>, "Cheng, Benjamin" <Benjamin.Cheng@amd.com>
Subject: RE: [PATCH] drm/amdgpu/vcn: Factor out vcn_v{3,4}_0_dec_msg
Thread-Topic: [PATCH] drm/amdgpu/vcn: Factor out vcn_v{3,4}_0_dec_msg
Thread-Index: AQHcxsnpVtYqRfaFYkic2LYYeBTF9rXUEVww
Date: Tue, 7 Apr 2026 20:46:48 +0000
Message-ID: <SJ1PR12MB6194B29F68F5AE9457ED3CBB955AA@SJ1PR12MB6194.namprd12.prod.outlook.com>
References: <20260407200518.911117-1-benjamin.cheng@amd.com>
In-Reply-To: <20260407200518.911117-1-benjamin.cheng@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-04-07T20:45:29.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR12MB6194:EE_|SJ0PR12MB6712:EE_
x-ms-office365-filtering-correlation-id: 450bc416-21eb-415d-d549-08de94e6c9f1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700021|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info: JSQRJTx32qiuLY/PVFWqyUmxmzSO0eintBJgxroK5S8FKm7i1KJZgrqHjA/DrEB4RVPnJEbqxqL7AvlWnwGYfHrSzC3v2Ab04oi0QulNYIfEGWW4hmxONIhu3yzaNh6s4hT7mBB64DdDVJihS41znoLO1GxM6xNZDq/sS50j96m92olGfBBKm611SXZNOcF038+NTowt/+vg3a0kuUEip/DGkKBEHnTbM9flImiR2F4MroyCFZ8KIBItsH0iA8IjBOp3MKDMTgkYqWOdE6NZeyjfwx8hidgNlomesWwE9XdpuVHQFSjP6KhygpyX4CXVRidwfDnJX30eGi2dwClRc8md2QWJxVA4z735+kbbGRKUp3l/1S0upyjSnEjdZ2CxTC/LfilUu90X3tH1hB2SGQi93wwE8r/pzQI6hSQMyq8S5anOxvnAdFbeDE5Qp1DwvpKQiZlXXzHT4hGvxVST3IEyz2Y4ib+hAkYQ5sSpqEALbtiVv+Z8t4p8lxj4eMNAy6uwtboYm3CAXc/4TjRcZ3KVLnq3g//1xvo6KRWp2n+Hy1K3I/d40Gngje/dt9QD+7yvs97SQ2L1KZk6YSSkpN7Twooc0RStNqMT0EDyplSLN2cLJsSYn283DcAmkUiJUl6mnnqSUFs5m2em6TdMLyzIomwSOrqSq9ROhCja08MDVHoBwcdnq/KTa+wGJlN5evs0Utetw+x1izx9SBiCp54OtKDe5RnsrOY0uOKZhe4y906kpsFfWiqnnTDu5swhAct4Sy8uqryA6NH8eqIfc5kWamjwJylXPNfpfG2Ly60=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ1PR12MB6194.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BbStgDFXl71Z40DzLfN7avG92p6oGwckOjCT7CQa0goAHJgVKWrjA0dfbdXW?=
 =?us-ascii?Q?jwMBLe9EAqL+A0HFf2nwzr3rkK9xRcbwQ/ah/KE8HhCjppBsxLN1hTIwVn/H?=
 =?us-ascii?Q?UWHjp6JUz4eA3aQ/jAZJwjA52UqE5RnzB3WwgPV8bPg8S5t5PCuB6W2psIxp?=
 =?us-ascii?Q?tJ+9jx2BT/hPMK9UirrwVOE10yyiSDPShbXJUHP/3MdNrr81kaCA1l8MyybE?=
 =?us-ascii?Q?kXRZwMUEAAXG+ULiKWH8Y4fBqJlv2G+xM5zCnYFZcAR/EKahvL5tfl31biZu?=
 =?us-ascii?Q?WU2s3ifkGOBPZlFNuc4/+F1C8NjajCyO3JPtIaeWAS6C8CgTwoRDLaOrGQ1o?=
 =?us-ascii?Q?SVJ6tPnMQoEOu3ERUS8++6YutkeF2PUF7WRwHMRpdwzU76L2Sws64U3Ir0yv?=
 =?us-ascii?Q?wgAcSgnm3Jixmx4z4Uzbb2XZGf9NV3L2VLcT9fUmpv0xQM0zzs8FgxaxaUwC?=
 =?us-ascii?Q?R6MIpsmg5Y88Q3+u/Ed/cHebxusAfBq66+SQxD4r0h5BN4+NNxU5+UM70P/E?=
 =?us-ascii?Q?41Dk4Sj0b/nwhQmaXA7NatWjbWPuCR2YdBpgua33LlmBNs02RJB9iRk54Bx5?=
 =?us-ascii?Q?nvMdlbPMDSSDMXPZaU6uBWtAs2vNKfNz6WZMMLuOMgaR8v73+5/uz0Wt84RX?=
 =?us-ascii?Q?XRCejQ5xIzht4rL/YM0J7g43wwdhBJ98jY2ezxYCK+2nOp5Yjna5EuW476yQ?=
 =?us-ascii?Q?/XRTuUL2fXY5bYTpsDnLIZnrHY8RT5H4DmH4aQmxjZHwklwvpmVE71l0UhW4?=
 =?us-ascii?Q?r3lDvgXTAL5QLLA69Z6lr3skeNc5M9RRLFbO/gjYhHmdQDO71abivOHLvtL5?=
 =?us-ascii?Q?0KDTXK1nFaOfclWGUJMVMR+m5AyM6Un36GDn4/TxAO8Bzf5LK48a1nG4gbaX?=
 =?us-ascii?Q?xqTKw2mcuQdc/+YtFzEfef6QbqbcoG8RPHNJHFQFK242Bh/BmPMlFNi4eB90?=
 =?us-ascii?Q?hRc2f2wcC2tdU/urnDD5TtRimZORYAeK1eGmecwZAYRJ8rZO6aaKOJB20iW3?=
 =?us-ascii?Q?uTpPSHJ0mKiokM91cgeMVzCCQvw3QeXSFaBH86OXZYfJagPsQpaetWDeIyFx?=
 =?us-ascii?Q?g4qHTEVxSPmfyCcBU2KOREmfSm5S2mQZHVUmRTdjcEVa3ELomGSAttLITbrE?=
 =?us-ascii?Q?qYD7CIELEAG6ghfF63+T2coDCHyJsSdxF6fPXKaNoI1CyzicdmxP1AVOhCnV?=
 =?us-ascii?Q?w6LeMmEW0xKpB29uK9T8Ux1dsJgaIC1+JMeKwBqhXuFeY25aoLaycFkXTI98?=
 =?us-ascii?Q?7uL6PAVtCAmchjkWtejwhtwVfzqqIyKxrYiSIWKjt4UT2h4jXt1N3LFI1uJ5?=
 =?us-ascii?Q?VDIdgDH+ZNyhMuBAa8BH2XUwgKTJBmnAiFXeNrp9QjdZVMi2VXSwusXL5KkQ?=
 =?us-ascii?Q?D2wg7ZyRjy+wrRwEx1eRBwvCtxx7YDx8o/d1ObPnZLWbuh/U8Qc4j7YbT/uw?=
 =?us-ascii?Q?sGlpbiO9DRsqyjL7AWXZJVWIpUOQF1V4xJ49mqNUdK/lukVmyQHqQI02Zoap?=
 =?us-ascii?Q?KcY1O6ZJwBhgK2W5pXGcXdHjOrzGUBilhtxeuStpjedN3t4EDxsgWaVUp3gt?=
 =?us-ascii?Q?L9AmYnS847hSMYvW26ItZanF0KTchAygESePIGOu58P0J9qdynUI1XE+hW9y?=
 =?us-ascii?Q?GVFTdb6Ce4H50zsuVWbqIsIz/yrSXbZ691OWBYi9W697l+Wh4+GvtAHP/Z3+?=
 =?us-ascii?Q?jZKv2WDiYfFaEOoIByXy83yh4C3XNAaYly2NmlbAMLzHOQDG?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 450bc416-21eb-415d-d549-08de94e6c9f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2026 20:46:48.4165 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SQoTPsdBo9oamK1rSvGnX7CsG0y2ksXdbRyi3ZO6e8W17PegewMcROnNBtbUTZH4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6712
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

-----Original Message-----
From: Benjamin Cheng <benjamin.cheng@amd.com>
Sent: Tuesday, April 7, 2026 4:05 PM
To: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Chri=
stian.Koenig@amd.com>; Liu, Leo <Leo.Liu@amd.com>; amd-gfx@lists.freedeskto=
p.org
Cc: Wu, David <David.Wu3@amd.com>; Dong, Ruijing <Ruijing.Dong@amd.com>; Ch=
eng, Benjamin <Benjamin.Cheng@amd.com>
Subject: [PATCH] drm/amdgpu/vcn: Factor out vcn_v{3,4}_0_dec_msg

Both vcn_v3_0 and vcn_v4_0 use the same interface, so unify the code.

Signed-off-by: Benjamin Cheng <benjamin.cheng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 103 +++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |   5 ++
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c   | 105 +-----------------------
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c   | 104 +----------------------
 4 files changed, 112 insertions(+), 205 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_vcn.c
index 03d95dca93d7..910dd5bd1ab6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -36,6 +36,9 @@
 #include "amdgpu_vcn.h"
 #include "soc15d.h"

+#define RDECODE_MSG_CREATE             0x00000000
+#define RDECODE_MESSAGE_CREATE         0x00000001

These two macros could be in amdgpu_vcn.h, as other VCNs can share the same=
 definitions.

Thanks,
Ruijing

 /* Firmware Names */
 #define FIRMWARE_RAVEN                 "amdgpu/raven_vcn.bin"
 #define FIRMWARE_PICASSO               "amdgpu/picasso_vcn.bin"
@@ -1641,3 +1644,103 @@ void amdgpu_vcn_print_ip_state(struct amdgpu_ip_blo=
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
+       if (msg[3] !=3D RDECODE_MSG_CREATE)
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
+               if (msg[0] !=3D RDECODE_MESSAGE_CREATE)
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
index 82624b44e661..64f27de1a6f0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -570,4 +570,9 @@ void amdgpu_vcn_print_ip_state(struct amdgpu_ip_block *=
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
index 6fb4fcdbba4f..38a4fcf5872e 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -58,9 +58,6 @@
 #define VCN_INSTANCES_SIENNA_CICHLID                           2
 #define DEC_SW_RING_ENABLED                                    FALSE

-#define RDECODE_MSG_CREATE                                     0x00000000
-#define RDECODE_MESSAGE_CREATE                                 0x00000001
-
 static const struct amdgpu_hwip_reg_entry vcn_reg_list_3_0[] =3D {
        SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_POWER_STATUS),
        SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_STATUS), @@ -1903,104 +1900,6 @@ =
static int vcn_v3_0_limit_sched(struct amdgpu_cs_parser *p,
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
-       if (msg[3] !=3D RDECODE_MSG_CREATE)
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
-               if (msg[0] !=3D RDECODE_MESSAGE_CREATE)
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
@@ -2024,8 +1923,8 @@ static int vcn_v3_0_ring_patch_cs_in_place(struct amd=
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
index 5dec92691f73..41215ad7dfac 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -50,9 +50,6 @@

 #define VCN_HARVEST_MMSCH                                                 =
             0

-#define RDECODE_MSG_CREATE                                                =
     0x00000000
-#define RDECODE_MESSAGE_CREATE                                            =
     0x00000001
-
 static const struct amdgpu_hwip_reg_entry vcn_reg_list_4_0[] =3D {
        SOC15_REG_ENTRY_STR(VCN, 0, regUVD_POWER_STATUS),
        SOC15_REG_ENTRY_STR(VCN, 0, regUVD_STATUS), @@ -1820,104 +1817,6 @@=
 static int vcn_v4_0_limit_sched(struct amdgpu_cs_parser *p,
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
-       if (msg[3] !=3D RDECODE_MSG_CREATE)
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
-               if (msg[0] !=3D RDECODE_MESSAGE_CREATE)
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
@@ -1960,7 +1859,8 @@ static int vcn_v4_0_ring_patch_cs_in_place(struct amd=
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

