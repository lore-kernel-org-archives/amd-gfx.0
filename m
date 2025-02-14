Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABD96C02198
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Feb 2025 16:45:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 46AC410ED1E;
	Fri, 14 Feb 2025 16:45:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xI8NyFsc";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2062.outbound.protection.outlook.com [40.107.243.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 95EB010ED19
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Feb 2025 16:45:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ybI4ga2/eRKLRM7rHs8/lpAUSFcMEBdypUFo4e2pZcVtxiNGrMnVw6zTgqzJpekG2xIy553vFRn9uPXZtYw5KLtQ0XdmL5eKBRXR19Fwf+rXBRxJiDGjIYdl3JinGprijak1LpfEzKD4iFP1jhzwYXsMv9bCXuI8kAPntEjl0t7u8KIyU2+PFY/idgJUli5dqTi2tboMP5xE9GmqLIyxnptHB6YB6RMyVdBGic2t79hHH0ptIFSTtgRFtHSUzAhgvVBl0jUBJ5nzLiaLHJjn9xIKhEzxr/AlajZUmWEt+kcUTH1Fo7NUoFx869TeQv7usOgykwz15oRvMt/BSA9zzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qg/Di9BfK2EG5bA3oAYAM2QSpR6RiZPiGpSQrhwT5sE=;
 b=DjK6eyNyogsQ9aqwuHfQK14OGX2b37Oa2g9a44e8uEi26vhXnEVr1TcDaQ6zXFRC4bGuWl2gjVCUebrfCQpzr3+rfEFtteLc0m7XnPsPIVVeXpcDjw98VFpD8iPKXK7N1RNgnWmzuYdxx4lJ5cjAAmkyQr7wTHOFzcV6qBhytwvA3Ha2gHrcq1deE6iGEEfticnWvzrYRAQcVdj4WRu4Gf7OaTMO3639228mVoc2QV6xQd/5P8tz6vci8naWY6aybNHKOEUc4GysabwghA6bRNr6BSVKvoHqm5iqU88au2RP5EPtpJjCuwRIAKEtkdTZLCoA5ie9gu9klDz5pC14Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qg/Di9BfK2EG5bA3oAYAM2QSpR6RiZPiGpSQrhwT5sE=;
 b=xI8NyFscwrS3rzw1Qggt9t00iMmgm7EKjPr220gJmLarHOZy/dUTlGBqcBvFxTft9Tl2WLR0OoFfuLfDUyYjHsd+49NqhJUbZp9+p4UUZLe9JfR+hBSS+letXaYV99ImWSAOcm3g+LmwUEcXRiUH3mIa2V25OCqaXBI8zlZSwYY=
Received: from CH0PR12MB5372.namprd12.prod.outlook.com (2603:10b6:610:d7::10)
 by BL3PR12MB6641.namprd12.prod.outlook.com (2603:10b6:208:38d::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.16; Fri, 14 Feb
 2025 16:45:23 +0000
Received: from CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::fec0:2b36:85c1:fc9b]) by CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::fec0:2b36:85c1:fc9b%4]) with mapi id 15.20.8445.017; Fri, 14 Feb 2025
 16:45:23 +0000
From: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 2/2] drm/amdgpu/mes12: allocate hw_resource_1 buffer once
Thread-Topic: [PATCH 2/2] drm/amdgpu/mes12: allocate hw_resource_1 buffer once
Thread-Index: AQHbfvPVkRimjnZ/jEuMrl0aS+yjm7NHARBA
Date: Fri, 14 Feb 2025 16:45:23 +0000
Message-ID: <CH0PR12MB5372425560C5BE3E4FED28B8F4FE2@CH0PR12MB5372.namprd12.prod.outlook.com>
References: <20250214151901.2071738-1-alexander.deucher@amd.com>
 <20250214151901.2071738-2-alexander.deucher@amd.com>
In-Reply-To: <20250214151901.2071738-2-alexander.deucher@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=2689dc34-8cde-48a8-9e9f-c27aa206df80;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-02-14T16:42:50Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR12MB5372:EE_|BL3PR12MB6641:EE_
x-ms-office365-filtering-correlation-id: 21a68183-afcc-484c-ef5d-08dd4d16f9c0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?vzPoq+eZA/ouF6I4fVpJGMzd3adIKkynr/iuM6RNYICmiRhLqz+3NpXeM/Cl?=
 =?us-ascii?Q?9QZ9IxUsNzUwqeiIUB8SqJRZI76UkWSGtQ295Tq3KvdYtSKb7FiFGryaeZ6S?=
 =?us-ascii?Q?FnyoL44KBtF9tjuZ++gjBkrP0pCoJ1Ku/nJpbk0YiFih5iHZGcFrBNVhROgw?=
 =?us-ascii?Q?U1txsR4cGIwNAwUi3wm2YfFRPAWwCO/pyS/wW6YTkmqGbGuamIroKmB560oJ?=
 =?us-ascii?Q?GX6XI9ag+uK6mpovGXrfL/xz3EXt55GnhlbgHwZERhl4ybePIR2kpdhSsadW?=
 =?us-ascii?Q?Mni2qVkLGbVjxLOnWQKTGVqwlMCjg36E5NQZh4LBfiouPOAfAbYrHA7bYbaL?=
 =?us-ascii?Q?QwavUcnUKHXHYxnQInpzDk4q2RWXHrKOxgk4JbD9L1npr/849IdP0lLCAhf3?=
 =?us-ascii?Q?TijiFHo5JRScd1PeTjElaBR07PhujY+3ExxiOecHMRu2foAAUPAcxP0H1PrA?=
 =?us-ascii?Q?7PTOZUnfMRgwI7cXCvjwHhRlu5yDPPQX2vOxiP8HWoMnIoe5mLkkOaAxjb5d?=
 =?us-ascii?Q?Sj+HfvaA+sx4We5mqpCic3mCWxyXbSDjQOuiIy5mymUbBHuOAlb9MA5antfi?=
 =?us-ascii?Q?+DLtbZFmehj9RtMkDy8Y0UHZIWUT4+jIKz/ZepiG2Bb0yDk8Kq0nXie3gZAQ?=
 =?us-ascii?Q?cgG4skv4w5jilhA0+E7+MfHkJzmaRte2AKz8l2Z5wM1USKvgZovbd12gw0UI?=
 =?us-ascii?Q?W96clw/GoJxEiSR71kJplxsS4omFBVnmuL7E3a9psZNIf6h8GYi4JoTzP1YW?=
 =?us-ascii?Q?6g/BarWjk8lR3CwSBfRJYwX6QvN1w5ZQxF4XxfQ/LK542wduB/PEd+tqPit9?=
 =?us-ascii?Q?7wpouc5+HntWQUvM8XhOPi6rVW2ZczdqMUooQinZDdlsoZ89KwKqL3Np19Hb?=
 =?us-ascii?Q?p8WrRM2D3c6MeGGRu5VO6EMsnIzoLN9Kj6IqqL/xoOTdcAMDKdihw7NeK40s?=
 =?us-ascii?Q?0mW2FOCiTp4Uvvbh2LlZuU80fQySVrKHhZdPpdFHp0tmqCpuHCFAEcAv+HOk?=
 =?us-ascii?Q?XyCuzTfGuR6zEQvDmHEJ+XVHpfHfg74d1J3S8ZwbqhPn6z2lkx/DhawmqV1b?=
 =?us-ascii?Q?OvDgWj/CZld1Gzp6NVN3pYo7UMBicDINuB+XQMYdvmxTN0x09KG8MNkQg8cs?=
 =?us-ascii?Q?EcbRIxa82P5fvPIvS7iKPFccmWkJwHsp1eo/2IdWQLwHNdShfMJYtuGJ5S/N?=
 =?us-ascii?Q?gqoqwQOkyImT40yTpDYzht76ccnkQmkJU9tFJqHRDLVgcfqtt7hyEkA32Yn2?=
 =?us-ascii?Q?+TYojsjNT1b9qOQhTkDpTKcKCxsc8rzgAboxBXOdwzA6P0QHO5PDXs7GJzAe?=
 =?us-ascii?Q?oax99yX2G5ksAVCBFG8v++QKNv2pTbbwSpqLdd1VQez1096FfOEE/bVOhajQ?=
 =?us-ascii?Q?WjcPTtpl7LeH/oVVxwOoLhZGGom4+ck2pbckYMGl2ZhNdWBfSRfOBijF0E1d?=
 =?us-ascii?Q?gt27kZLm3zUy2tAeOGwzjgi4E+bGsK2c?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5372.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?RG3kWawxcDr76Uv5Vdqkuf+QJAmSNdeC0tCMOrQ//f2wku6xryuVXHqN6LSQ?=
 =?us-ascii?Q?BmRh3WFVX6KCgMTFNiNH/o9XgQTp+GexpSkFUx9hSwGSh+jI4xpRorL7GuFr?=
 =?us-ascii?Q?vXmLHawYhIfDOPYbwwruxJAehG6rReYXd63iyU1634I7VD6bXmVlMRJdv5Og?=
 =?us-ascii?Q?VtfWf46Hx0J//vt0rpM/g93cg0MEVFoCqyTqvk+B5n1dnUkpIjYJ3D8meI0Q?=
 =?us-ascii?Q?VU11cBZ5wzOFtk2LdE6R08dnKD53VNbTjMXwlY2ln/uFewG4u+/1pqDsGpVA?=
 =?us-ascii?Q?3kSSxLUbNCGILbsRmd1qsEJzoCt8LUzgk1T1McA5Camdlsb9orODnfZDSU2s?=
 =?us-ascii?Q?of7dQEQsSMCAxJknjkGBG6tVK5ryWh86FnLSy9Jslc5jKMkj8MXT25XsHHg8?=
 =?us-ascii?Q?6XYnxr/Ud401BxJ5mb+XnqL9SujZjfCZlwyjw0QP9zgBf6DaxRa9aproG/6E?=
 =?us-ascii?Q?tJePZDA6aLMVIHkYsjgewt0pl5PR0mdOeDSHqk+glqDKFqLFyrTaD1Lv0XyW?=
 =?us-ascii?Q?MOrFbTYRQBianH1o26kPoE3oZ9zKoAPW6bZrEM34jpz4RE+TqY4aZlFEfbtI?=
 =?us-ascii?Q?eHv2gJspYvYRFayFfK5dbbPloK5T6greoCP/WeixfNx+swO5KJU7mD6Nk2bb?=
 =?us-ascii?Q?29cbdpPf1KP+AWBKaISnEolZmvTdLdNLZBFHn1GEEiLXTINwYiH6hfFdTOke?=
 =?us-ascii?Q?dok6YDz3RTRu+pAtGA2pqtf28+8/L/JdDHLTvgizXZKByDcK8X5w5IegL7Fx?=
 =?us-ascii?Q?RocUjhvyixuTyhDOCdClylfn2r8Y8eIhQmg2RHsmSbExMb95vvuig95uUND2?=
 =?us-ascii?Q?34/txD0xyn6blSwsB5Np1j0/P+QWiDry7Q0vF65DOah8ugKnE3eSj0sQHk3b?=
 =?us-ascii?Q?jCxJjRodWDuHU/Ru1+DAD0LwE2ACxo/HzGT2XNo87qg3qTsecLa2Hnaw3j+B?=
 =?us-ascii?Q?UeY0Y+Tz0rYqbAcfCKj0KcPFsIvD/y0nDUv37krbYHE53b3HAPTy0Rsbyqt+?=
 =?us-ascii?Q?lEsABZR7ohn5XagfybqsTcFbERL94ErHvgHPqU1Wsw2TqPXa0uKuqCBl2HcJ?=
 =?us-ascii?Q?kE3odKyPpVO/K/iw+K9IQfm98S5tkPaE+4hStpLWpNFEeVC/TIwJGmPwTWGp?=
 =?us-ascii?Q?eABAPPkY0qhjTgK6UGjhnH17o/J9ZPcNVkfH9qlt/qxq6Jb4r/vl8zhDkthF?=
 =?us-ascii?Q?bBIFvYW3o294WP9P5BMVMpuYk+QCQ7c+N2a3cFfAVyK7c/tP8YcxkEh151Wp?=
 =?us-ascii?Q?ShW/nvyqm5mr+PfKAihl7suzeXRiA2AM249OJlkGPLALhrWUUel+PxlC7G6s?=
 =?us-ascii?Q?yglJSvrVoWiRCxveACf6YocVvh+c3SGlh6YcmX9AXerJn5eQtrlSnbHsx0sX?=
 =?us-ascii?Q?IE0PeGi+b8iiUzQbik0C+ajGgIjL2gK/N63enuTuL6+aiVsd+wFN0gXX5Qcj?=
 =?us-ascii?Q?P+OMsIlB7Wxc/RAFet/C2odihguZcjea+Pz4mmldlgiL1c7RPEpSs45QfnLP?=
 =?us-ascii?Q?HBJMt8xnPF/n5DMiSNKixo1HoZQYuy1BrSuy5S0YXInW7vwsLO7ph4petDbS?=
 =?us-ascii?Q?1q2gpc0Twk7AdwzhAos=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5372.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21a68183-afcc-484c-ef5d-08dd4d16f9c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2025 16:45:23.0815 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TOOkpkXyrJC/QBlAGPLomp9ADY4Jtk147ft42qdtSGyohU4lhaD0u4wGtDWQ8q8MngbwvQZuFJVJy/Xy8OspQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6641
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

I'd suggest remove the  enable_uni_mes check, set_hw_resource_1 is always r=
equired for gfx12 and  up. Especially after add the  cleaner_shader_fence_a=
ddr there.

Regards
Shaoyun.liu

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deu=
cher
Sent: Friday, February 14, 2025 10:19 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH 2/2] drm/amdgpu/mes12: allocate hw_resource_1 buffer once

Allocate the buffer at sw init time so we don't alloc and free it for every=
 suspend/resume or reset cycle.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c | 39 +++++++++++++-------------
 1 file changed, 19 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/a=
mdgpu/mes_v12_0.c
index 8dbab3834d82d..6db88584dd529 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -678,9 +678,6 @@ static int mes_v12_0_misc_op(struct amdgpu_mes *mes,

 static int mes_v12_0_set_hw_resources_1(struct amdgpu_mes *mes, int pipe) =
 {
-       unsigned int alloc_size =3D AMDGPU_GPU_PAGE_SIZE;
-       int ret =3D 0;
-       struct amdgpu_device *adev =3D mes->adev;
        union MESAPI_SET_HW_RESOURCES_1 mes_set_hw_res_1_pkt;

        memset(&mes_set_hw_res_1_pkt, 0, sizeof(mes_set_hw_res_1_pkt)); @@ =
-689,17 +686,6 @@ static int mes_v12_0_set_hw_resources_1(struct amdgpu_mes=
 *mes, int pipe)
        mes_set_hw_res_1_pkt.header.opcode =3D MES_SCH_API_SET_HW_RSRC_1;
        mes_set_hw_res_1_pkt.header.dwsize =3D API_FRAME_SIZE_IN_DWORDS;
        mes_set_hw_res_1_pkt.mes_kiq_unmap_timeout =3D 0xa;
-
-       ret =3D amdgpu_bo_create_kernel(adev, alloc_size, PAGE_SIZE,
-                               AMDGPU_GEM_DOMAIN_VRAM,
-                               &mes->resource_1,
-                               &mes->resource_1_gpu_addr,
-                               &mes->resource_1_addr);
-       if (ret) {
-               dev_err(adev->dev, "(%d) failed to create mes resource_1 bo=
\n", ret);
-               return ret;
-       }
-
        mes_set_hw_res_1_pkt.cleaner_shader_fence_mc_addr =3D
                mes->resource_1_gpu_addr;

@@ -1550,6 +1536,20 @@ static int mes_v12_0_sw_init(struct amdgpu_ip_block =
*ip_block)
                        return r;
        }

+       if (adev->enable_uni_mes) {
+               int ret;
+
+               ret =3D amdgpu_bo_create_kernel(adev, AMDGPU_GPU_PAGE_SIZE,=
 PAGE_SIZE,
+                                             AMDGPU_GEM_DOMAIN_VRAM,
+                                             &adev->mes.resource_1,
+                                             &adev->mes.resource_1_gpu_add=
r,
+                                             &adev->mes.resource_1_addr);
+               if (ret) {
+                       dev_err(adev->dev, "(%d) failed to create mes resou=
rce_1 bo\n", ret);
+                       return ret;
+               }
+       }
+
        return 0;
 }

@@ -1558,6 +1558,11 @@ static int mes_v12_0_sw_fini(struct amdgpu_ip_block =
*ip_block)
        struct amdgpu_device *adev =3D ip_block->adev;
        int pipe;

+       if (adev->enable_uni_mes)
+               amdgpu_bo_free_kernel(&adev->mes.resource_1,
+                                     &adev->mes.resource_1_gpu_addr,
+                                     &adev->mes.resource_1_addr);
+
        for (pipe =3D 0; pipe < AMDGPU_MAX_MES_PIPES; pipe++) {
                kfree(adev->mes.mqd_backup[pipe]);

@@ -1786,12 +1791,6 @@ static int mes_v12_0_hw_init(struct amdgpu_ip_block =
*ip_block)

 static int mes_v12_0_hw_fini(struct amdgpu_ip_block *ip_block)  {
-       struct amdgpu_device *adev =3D ip_block->adev;
-
-       if (adev->enable_uni_mes)
-               amdgpu_bo_free_kernel(&adev->mes.resource_1,
-                                     &adev->mes.resource_1_gpu_addr,
-                                     &adev->mes.resource_1_addr);
        return 0;
 }

--
2.48.1

