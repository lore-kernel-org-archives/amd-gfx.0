Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09C53C43334
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jul 2022 09:31:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C7F510F7BE;
	Fri,  8 Jul 2022 09:31:47 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2067.outbound.protection.outlook.com [40.107.94.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5CE5B10F87F
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Jul 2022 09:31:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QXK0DLFLn4gVQ4NMHtzg2D/o7m1oWxOBPU3Oi8iRSQUBibaBLaLR/d1LKFD6Mbr3P0NVu1U5SMNQKBGkmTmUuxS0NCNXAuuiEj7COt0dvG0BZLd4+h/GEc5DnZhAkpONazm7QvjFii2A7lX55m8VeVX22X78Ub9hfTwfEw6hcezm2aoyiYv6MsHudTw92f4U0fekrDpBW/hehRK5zf6O7HeVTGRQJywfM7o/cb53WPyfdE7tIu+SH84f+Na8CvaHrIHFMaqrNR/uN6lKag3fJnzbMVUrP1+dFOKUjnlEEui5M9CF8mTx3cTBGcPJtvSwBR1ZSKZ6iktSx2BKxw+GSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eBJrUQZHZAv4oPYxUfL2crPO7nnPeMmWN1GgviHlTPc=;
 b=dfWc7XatjbId33vPqpWx+Qjf3igXQyDV1vMHGJ8x5BDlLY6wnVBRZCHw1zeEKe8SMUdPUovy5pLLEynKvxK65MYkJ2xGranX1+3UzfmWwxyTTe5TVwQqC1CyU2BhEZVQDDaAL3pL5j+gA2nq4x5phaa4+VwDLZqV1vTytmLm4zp7OT4d2z0CFB8P4ZkMpysHxcCxAikt5wzQDJFH3VL17T27j4xZspjUMVYgNUrL76SwMfzPZ5dUyOxYS1cUj633pUW2CQSUtHMLiV7TRUWK9Snfnz+2Q26vu6MvlP1ScUwptWU/tEwMyjLH9cT5GGHIwi6+dvksZDoegkEi05/tOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eBJrUQZHZAv4oPYxUfL2crPO7nnPeMmWN1GgviHlTPc=;
 b=fHjD1lIr7j+H0A04t5l5uA33y3gp6V/giAJxV3rXh/ZdbyzAOCNEvao918dwRxRyaRSVozYsKWwzTNmrzAm6G7Fy1IyAompcQIJW4Ga+nowaqvUu57jz5rspPdeb6HjdA5u0yZclUMcU29ZJzqBzA4gmTaYOjExuIEaqYcl4OnA=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by MN0PR12MB5881.namprd12.prod.outlook.com (2603:10b6:208:379::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20; Fri, 8 Jul
 2022 09:31:40 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c822:1616:3d10:71fe]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c822:1616:3d10:71fe%8]) with mapi id 15.20.5417.020; Fri, 8 Jul 2022
 09:31:40 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Xiao, Jack" <Jack.Xiao@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 1/3] drm/amdgpu/mes: fix mes submission in atomic context
Thread-Topic: [PATCH 1/3] drm/amdgpu/mes: fix mes submission in atomic context
Thread-Index: AQHYkqhiaJqXVkmdn0ajqTJuoN6vfa10NZ0A
Date: Fri, 8 Jul 2022 09:31:40 +0000
Message-ID: <BN9PR12MB52570914EAFCE8EAAD32C3CBFC829@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20220708085426.1857392-1-Jack.Xiao@amd.com>
In-Reply-To: <20220708085426.1857392-1-Jack.Xiao@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-07-08T09:31:35Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=f506c6e2-d431-4391-b4f3-007ae5819a6f;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 18a1de31-3615-488d-487f-08da60c4a9cf
x-ms-traffictypediagnostic: MN0PR12MB5881:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xNGfxTuJhtIT/xP78HLsjvHamhzP8916is7iOMD6qzyjOPsgMLyFnSeugfJtceY8h3DRu6zaSDijCBiOFPkuu9xZacp+tw+4qOQOsIH+WLZ1yswCVAQ8yHeKyzacVTLRyaeX7mEQvc8aMwqZBkkA/vXA1YZcxddH3/g5Yz4GK2Ym0JZGztYO0zIKHouubHtXc0EWenbDS+kS5u9ci7PueSz7u2MylEtz2KDeejbL/zl8zZAlfccSJjh94wM1041Svq6EAHdEmaGjVbGEJs/pjBAGO5VAP51LiVhdQF5lmRGpAWDFzdvCM3p0h29bdmZNXsBYbR+LpcHupoaETcpyEtdev8/kG3tj/nYq1/rEZ9ONi3CAm+qLGaCTMJC+C110QIjl+NjTwCLWUcEb0osVL6qTgjZWSFZVbuuba3cPnwLqAsGA4+5WHulzww0zJCeXDH+NB3oh9rU8ZNqBVimKocT6zqQ54+Qh2hDcuA1lfER3pxmLQlhdle8iFmNJNFu6PxkYOY5r3H/Dcqjf/elom/dkK7cSkRJvwAqpCcLSVhDVICEuy0cUqiBcYen3pTu4Qi7q9dldYvPHI10YDxU+YSthRhZB7RPZF6ouTd/YSX0nkwPeRpz1CXVUhfeqqT2Vkdo62XYhGWMITkaHyO5paY80nGDD+8M32uLyLKkfEGk9vvxJzNuEl08dfnGq66VuALZrBi8FOvfwFtqR2hwGT8+77yGVeNJmABD/D0ymTIhIYV8/OH/3lTIow6jaFdS2TegyUMBWw2/0igUELUygE0xZBlZG+aVKPieUp+CqeFyRodggEM+5t3dHansgIbPV
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(376002)(366004)(136003)(396003)(346002)(5660300002)(52536014)(478600001)(8936002)(26005)(186003)(9686003)(7696005)(6506007)(86362001)(53546011)(33656002)(2906002)(30864003)(41300700001)(55016003)(66446008)(122000001)(38100700002)(83380400001)(76116006)(66946007)(64756008)(8676002)(66476007)(66556008)(316002)(110136005)(6636002)(38070700005)(71200400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GYxMvr2YZMWWuQZVR5GO5TtwhOYDyXB8M7dvb4ahA4Iipc0LjPzRwUn+xtVr?=
 =?us-ascii?Q?t2oscHwAGfwpbrPH3VnFsG1heCpKOMJddlw8AvXoG9G5HAL5T0+r/3r98HG8?=
 =?us-ascii?Q?ep1J4LA7Y28fu2czdnrB8ARYSGgmNAxP1YQ+RI4X+Q+E+Y4goy9VRFyXKurG?=
 =?us-ascii?Q?2hb7Qh1Ggd3d9Hb8DBHd4n1c8OKntJr2orEQoObQwR+3wACei/xqJqDRiJOY?=
 =?us-ascii?Q?5cFQtABTm1v5qVjSq6OZpHfhW5yZtfxQSUy5/UGkT9HmxGVeaZVwX3GVijx8?=
 =?us-ascii?Q?etllxXtraYqTc+M13hgXQ1jpyMQ8vnHo1ppAS+5UBddic1amX6ywcR1rx0RX?=
 =?us-ascii?Q?0puexlnpZ8PECObgQSicVKeWVFleU6NULfsx95NC1KA5hdhHWyFFeqo0CAT1?=
 =?us-ascii?Q?L6k3VBg4oDmGSz3aEFi5QAGjd4rMJkDwhHuH1cva3Nezho/FpkPQo7w6XWHj?=
 =?us-ascii?Q?q6OES+5T+wdM4ok+e19woaUkQnnqFd9vHp/fVqsAeQ/Qgcf03+EOMZ+icGu7?=
 =?us-ascii?Q?eU8x7lG9wsGUPKwv3a1xAnAbKWi4pJ8yLlVovDf4sYNvZUlEFB8SYSfCYSlQ?=
 =?us-ascii?Q?nWu+lrzmFziFNbTVdi23N9zQEZmWLowErnOqohKF8dCkl8KTyhIYSzC1AvWP?=
 =?us-ascii?Q?PySh8wQ9GQZGdgXrvec7XCKSGIjMYXwLFBOL9xmAdlgK8jSS7oyHjpJysLiM?=
 =?us-ascii?Q?i16F2p2unxN5PK4Jl7cP+cILI6IBEOlPSCbuctN2UhK5ZXpd959K+4JLg6nO?=
 =?us-ascii?Q?9skeduq1RhFYyCKRvmKLJYL5IYCWgeF1GvFXbkzgJUs5+dIooQvIFc2bO3BG?=
 =?us-ascii?Q?dVlx9bFFCTbt5e18hAvuZVSceosZi2P704QdqmsiSWvUnCI3R504tC7yCPaA?=
 =?us-ascii?Q?/R6P6FaUkwv/spm/xSnzsTCF4jhNr31VJBO4k0o6C/RdjAcgSkNoL+w4Dh9I?=
 =?us-ascii?Q?AvocRc3lid2HmToPglkn8uHHPN97ej0PFPR19FnsTNHB7ad++3wNayJHWnEV?=
 =?us-ascii?Q?DPzDWM2pj1GS3cCd5pmw2DdHUA5eCgHmMtXFwfDkNtmp7DOe5bAvS+iFLTQY?=
 =?us-ascii?Q?PDkjIT8NsKoCxJRk8Z63qgpPQe731EA1/Ow/bOqBB9ZBRvSquFSN5V/92k/w?=
 =?us-ascii?Q?ccLzx+OJJt/DargKTS+psXHP5mKjyHQyoqAwzTlb31lhw3FQ7N1Q+gRqGRQy?=
 =?us-ascii?Q?T3y16G7QIBpFCsTxxjF2PlBBhBlsD/Vn2IGEWxmcCTFMXTyNbzW1AxhiNddV?=
 =?us-ascii?Q?wa8yFsM+Sm5Dyvt2Rhk20HwYEkz1c22EH+Jm5RkDZUg7Or+BeqegsiDBxyiD?=
 =?us-ascii?Q?GjfwLVqVcrhbBqNnkP6kgiLC7Edl+kOiHWDetmFzy+VK+vVM8MeVBmlZZNe7?=
 =?us-ascii?Q?eHRozbsekAOWX+HuVo+GB2YZjPsQX5Yvxit81jOmYDPy11EfQYYrIOHf+QzC?=
 =?us-ascii?Q?ywulDxMadbNAk2jRa4/79BFgs03R4FHq9uEZ2odNfO9J7NZvVogWgK4uuJfu?=
 =?us-ascii?Q?twRqpoUeE3YKg1ZQsEH8OJQPZvO+iYjT2L5w7GJ87MpJVHdHn/8d4OijqNp5?=
 =?us-ascii?Q?H10uHjhcm519DqVdpmSjbmkeNSm5Uawe0IPTQq0Q?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18a1de31-3615-488d-487f-08da60c4a9cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2022 09:31:40.4668 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZjvlLuWkA5qLGGiLEpsCmjcStD6N8ptCeU6PRkG/q2RdUjh4AfbMZ8zhAeIfhphL0lfmgSw5CMe1z0aOatNFHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5881
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

Series is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Xiao, Jack <Jack.Xiao@amd.com>=20
Sent: Friday, July 8, 2022 16:54
To: amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@am=
d.com>; Zhang, Hawking <Hawking.Zhang@amd.com>
Cc: Xiao, Jack <Jack.Xiao@amd.com>
Subject: [PATCH 1/3] drm/amdgpu/mes: fix mes submission in atomic context

For some cases (accessing registers, unmap legacy queue), it needs access m=
es in atomic context. Use spinlock to protect agaist mes ring buffer race c=
ondition.

Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 16 +------  drivers/gpu/drm/amd/=
amdgpu/amdgpu_mes.h |  1 +  drivers/gpu/drm/amd/amdgpu/mes_v10_1.c  | 55 ++=
+++++++------------  drivers/gpu/drm/amd/amdgpu/mes_v11_0.c  | 63 +++++++++=
+---------------
 4 files changed, 50 insertions(+), 85 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_mes.c
index ca44aa123a1e..db2138b7a858 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -150,6 +150,7 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
 	idr_init(&adev->mes.queue_id_idr);
 	ida_init(&adev->mes.doorbell_ida);
 	spin_lock_init(&adev->mes.queue_id_lock);
+	spin_lock_init(&adev->mes.ring_lock);
 	mutex_init(&adev->mes.mutex_hidden);
=20
 	adev->mes.total_max_queue =3D AMDGPU_FENCE_MES_QUEUE_ID_MASK; @@ -794,8 +=
795,6 @@ int amdgpu_mes_unmap_legacy_queue(struct amdgpu_device *adev,
 	struct mes_unmap_legacy_queue_input queue_input;
 	int r;
=20
-	amdgpu_mes_lock(&adev->mes);
-
 	queue_input.action =3D action;
 	queue_input.queue_type =3D ring->funcs->type;
 	queue_input.doorbell_offset =3D ring->doorbell_index; @@ -808,7 +807,6 @@=
 int amdgpu_mes_unmap_legacy_queue(struct amdgpu_device *adev,
 	if (r)
 		DRM_ERROR("failed to unmap legacy queue\n");
=20
-	amdgpu_mes_unlock(&adev->mes);
 	return r;
 }
=20
@@ -817,8 +815,6 @@ uint32_t amdgpu_mes_rreg(struct amdgpu_device *adev, ui=
nt32_t reg)
 	struct mes_misc_op_input op_input;
 	int r, val =3D 0;
=20
-	amdgpu_mes_lock(&adev->mes);
-
 	op_input.op =3D MES_MISC_OP_READ_REG;
 	op_input.read_reg.reg_offset =3D reg;
 	op_input.read_reg.buffer_addr =3D adev->mes.read_val_gpu_addr; @@ -835,7 =
+831,6 @@ uint32_t amdgpu_mes_rreg(struct amdgpu_device *adev, uint32_t reg=
)
 		val =3D *(adev->mes.read_val_ptr);
=20
 error:
-	amdgpu_mes_unlock(&adev->mes);
 	return val;
 }
=20
@@ -845,8 +840,6 @@ int amdgpu_mes_wreg(struct amdgpu_device *adev,
 	struct mes_misc_op_input op_input;
 	int r;
=20
-	amdgpu_mes_lock(&adev->mes);
-
 	op_input.op =3D MES_MISC_OP_WRITE_REG;
 	op_input.write_reg.reg_offset =3D reg;
 	op_input.write_reg.reg_value =3D val;
@@ -862,7 +855,6 @@ int amdgpu_mes_wreg(struct amdgpu_device *adev,
 		DRM_ERROR("failed to write reg (0x%x)\n", reg);
=20
 error:
-	amdgpu_mes_unlock(&adev->mes);
 	return r;
 }
=20
@@ -873,8 +865,6 @@ int amdgpu_mes_reg_write_reg_wait(struct amdgpu_device =
*adev,
 	struct mes_misc_op_input op_input;
 	int r;
=20
-	amdgpu_mes_lock(&adev->mes);
-
 	op_input.op =3D MES_MISC_OP_WRM_REG_WR_WAIT;
 	op_input.wrm_reg.reg0 =3D reg0;
 	op_input.wrm_reg.reg1 =3D reg1;
@@ -892,7 +882,6 @@ int amdgpu_mes_reg_write_reg_wait(struct amdgpu_device =
*adev,
 		DRM_ERROR("failed to reg_write_reg_wait\n");
=20
 error:
-	amdgpu_mes_unlock(&adev->mes);
 	return r;
 }
=20
@@ -902,8 +891,6 @@ int amdgpu_mes_reg_wait(struct amdgpu_device *adev, uin=
t32_t reg,
 	struct mes_misc_op_input op_input;
 	int r;
=20
-	amdgpu_mes_lock(&adev->mes);
-
 	op_input.op =3D MES_MISC_OP_WRM_REG_WAIT;
 	op_input.wrm_reg.reg0 =3D reg;
 	op_input.wrm_reg.ref =3D val;
@@ -920,7 +907,6 @@ int amdgpu_mes_reg_wait(struct amdgpu_device *adev, uin=
t32_t reg,
 		DRM_ERROR("failed to reg_write_reg_wait\n");
=20
 error:
-	amdgpu_mes_unlock(&adev->mes);
 	return r;
 }
=20
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_mes.h
index 17d58a08bbb7..02daffbda02d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -82,6 +82,7 @@ struct amdgpu_mes {
 	uint64_t                        default_gang_quantum;
=20
 	struct amdgpu_ring              ring;
+	spinlock_t                      ring_lock;
=20
 	const struct firmware           *fw[AMDGPU_MAX_MES_PIPES];
=20
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c b/drivers/gpu/drm/amd/a=
mdgpu/mes_v10_1.c
index 18a129f36215..75cf92d38d41 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
@@ -87,21 +87,32 @@ static const struct amdgpu_ring_funcs mes_v10_1_ring_fu=
ncs =3D {  };
=20
 static int mes_v10_1_submit_pkt_and_poll_completion(struct amdgpu_mes *mes=
,
-						    void *pkt, int size)
+						    void *pkt, int size,
+						    int api_status_off)
 {
 	int ndw =3D size / 4;
 	signed long r;
 	union MESAPI__ADD_QUEUE *x_pkt =3D pkt;
+	struct MES_API_STATUS *api_status;
 	struct amdgpu_device *adev =3D mes->adev;
 	struct amdgpu_ring *ring =3D &mes->ring;
+	unsigned long flags;
=20
 	BUG_ON(size % 4 !=3D 0);
=20
-	if (amdgpu_ring_alloc(ring, ndw))
+	spin_lock_irqsave(&mes->ring_lock, flags);
+	if (amdgpu_ring_alloc(ring, ndw)) {
+		spin_unlock_irqrestore(&mes->ring_lock, flags);
 		return -ENOMEM;
+	}
+
+	api_status =3D (struct MES_API_STATUS *)((char *)pkt + api_status_off);
+	api_status->api_completion_fence_addr =3D mes->ring.fence_drv.gpu_addr;
+	api_status->api_completion_fence_value =3D=20
+++mes->ring.fence_drv.sync_seq;
=20
 	amdgpu_ring_write_multiple(ring, pkt, ndw);
 	amdgpu_ring_commit(ring);
+	spin_unlock_irqrestore(&mes->ring_lock, flags);
=20
 	DRM_DEBUG("MES msg=3D%d was emitted\n", x_pkt->header.opcode);
=20
@@ -166,13 +177,9 @@ static int mes_v10_1_add_hw_queue(struct amdgpu_mes *m=
es,
 	mes_add_queue_pkt.gws_size =3D input->gws_size;
 	mes_add_queue_pkt.trap_handler_addr =3D input->tba_addr;
=20
-	mes_add_queue_pkt.api_status.api_completion_fence_addr =3D
-		mes->ring.fence_drv.gpu_addr;
-	mes_add_queue_pkt.api_status.api_completion_fence_value =3D
-		++mes->ring.fence_drv.sync_seq;
-
 	return mes_v10_1_submit_pkt_and_poll_completion(mes,
-			&mes_add_queue_pkt, sizeof(mes_add_queue_pkt));
+			&mes_add_queue_pkt, sizeof(mes_add_queue_pkt),
+			offsetof(union MESAPI__ADD_QUEUE, api_status));
 }
=20
 static int mes_v10_1_remove_hw_queue(struct amdgpu_mes *mes, @@ -189,13 +1=
96,9 @@ static int mes_v10_1_remove_hw_queue(struct amdgpu_mes *mes,
 	mes_remove_queue_pkt.doorbell_offset =3D input->doorbell_offset;
 	mes_remove_queue_pkt.gang_context_addr =3D input->gang_context_addr;
=20
-	mes_remove_queue_pkt.api_status.api_completion_fence_addr =3D
-		mes->ring.fence_drv.gpu_addr;
-	mes_remove_queue_pkt.api_status.api_completion_fence_value =3D
-		++mes->ring.fence_drv.sync_seq;
-
 	return mes_v10_1_submit_pkt_and_poll_completion(mes,
-			&mes_remove_queue_pkt, sizeof(mes_remove_queue_pkt));
+			&mes_remove_queue_pkt, sizeof(mes_remove_queue_pkt),
+			offsetof(union MESAPI__REMOVE_QUEUE, api_status));
 }
=20
 static int mes_v10_1_unmap_legacy_queue(struct amdgpu_mes *mes, @@ -227,13=
 +230,9 @@ static int mes_v10_1_unmap_legacy_queue(struct amdgpu_mes *mes,
 			mes_remove_queue_pkt.unmap_kiq_utility_queue =3D 1;
 	}
=20
-	mes_remove_queue_pkt.api_status.api_completion_fence_addr =3D
-		mes->ring.fence_drv.gpu_addr;
-	mes_remove_queue_pkt.api_status.api_completion_fence_value =3D
-		++mes->ring.fence_drv.sync_seq;
-
 	return mes_v10_1_submit_pkt_and_poll_completion(mes,
-			&mes_remove_queue_pkt, sizeof(mes_remove_queue_pkt));
+			&mes_remove_queue_pkt, sizeof(mes_remove_queue_pkt),
+			offsetof(union MESAPI__REMOVE_QUEUE, api_status));
 }
=20
 static int mes_v10_1_suspend_gang(struct amdgpu_mes *mes, @@ -258,13 +257,=
9 @@ static int mes_v10_1_query_sched_status(struct amdgpu_mes *mes)
 	mes_status_pkt.header.opcode =3D MES_SCH_API_QUERY_SCHEDULER_STATUS;
 	mes_status_pkt.header.dwsize =3D API_FRAME_SIZE_IN_DWORDS;
=20
-	mes_status_pkt.api_status.api_completion_fence_addr =3D
-		mes->ring.fence_drv.gpu_addr;
-	mes_status_pkt.api_status.api_completion_fence_value =3D
-		++mes->ring.fence_drv.sync_seq;
-
 	return mes_v10_1_submit_pkt_and_poll_completion(mes,
-			&mes_status_pkt, sizeof(mes_status_pkt));
+			&mes_status_pkt, sizeof(mes_status_pkt),
+			offsetof(union MESAPI__QUERY_MES_STATUS, api_status));
 }
=20
 static int mes_v10_1_set_hw_resources(struct amdgpu_mes *mes) @@ -313,13 +=
308,9 @@ static int mes_v10_1_set_hw_resources(struct amdgpu_mes *mes)
 	mes_set_hw_res_pkt.disable_mes_log =3D 1;
 	mes_set_hw_res_pkt.use_different_vmid_compute =3D 1;
=20
-	mes_set_hw_res_pkt.api_status.api_completion_fence_addr =3D
-		mes->ring.fence_drv.gpu_addr;
-	mes_set_hw_res_pkt.api_status.api_completion_fence_value =3D
-		++mes->ring.fence_drv.sync_seq;
-
 	return mes_v10_1_submit_pkt_and_poll_completion(mes,
-			&mes_set_hw_res_pkt, sizeof(mes_set_hw_res_pkt));
+			&mes_set_hw_res_pkt, sizeof(mes_set_hw_res_pkt),
+			offsetof(union MESAPI_SET_HW_RESOURCES, api_status));
 }
=20
 static const struct amdgpu_mes_funcs mes_v10_1_funcs =3D { diff --git a/dr=
ivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0=
.c
index 6b07a8b23d67..b78e09910c7c 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -86,21 +86,32 @@ static const struct amdgpu_ring_funcs mes_v11_0_ring_fu=
ncs =3D {  };
=20
 static int mes_v11_0_submit_pkt_and_poll_completion(struct amdgpu_mes *mes=
,
-						    void *pkt, int size)
+						    void *pkt, int size,
+						    int api_status_off)
 {
 	int ndw =3D size / 4;
 	signed long r;
 	union MESAPI__ADD_QUEUE *x_pkt =3D pkt;
+	struct MES_API_STATUS *api_status;
 	struct amdgpu_device *adev =3D mes->adev;
 	struct amdgpu_ring *ring =3D &mes->ring;
+	unsigned long flags;
=20
 	BUG_ON(size % 4 !=3D 0);
=20
-	if (amdgpu_ring_alloc(ring, ndw))
+	spin_lock_irqsave(&mes->ring_lock, flags);
+	if (amdgpu_ring_alloc(ring, ndw)) {
+		spin_unlock_irqrestore(&mes->ring_lock, flags);
 		return -ENOMEM;
+	}
+
+	api_status =3D (struct MES_API_STATUS *)((char *)pkt + api_status_off);
+	api_status->api_completion_fence_addr =3D mes->ring.fence_drv.gpu_addr;
+	api_status->api_completion_fence_value =3D=20
+++mes->ring.fence_drv.sync_seq;
=20
 	amdgpu_ring_write_multiple(ring, pkt, ndw);
 	amdgpu_ring_commit(ring);
+	spin_unlock_irqrestore(&mes->ring_lock, flags);
=20
 	DRM_DEBUG("MES msg=3D%d was emitted\n", x_pkt->header.opcode);
=20
@@ -173,13 +184,9 @@ static int mes_v11_0_add_hw_queue(struct amdgpu_mes *m=
es,
 	mes_add_queue_pkt.tma_addr =3D input->tma_addr;
 	mes_add_queue_pkt.is_kfd_process =3D input->is_kfd_process;
=20
-	mes_add_queue_pkt.api_status.api_completion_fence_addr =3D
-		mes->ring.fence_drv.gpu_addr;
-	mes_add_queue_pkt.api_status.api_completion_fence_value =3D
-		++mes->ring.fence_drv.sync_seq;
-
 	return mes_v11_0_submit_pkt_and_poll_completion(mes,
-			&mes_add_queue_pkt, sizeof(mes_add_queue_pkt));
+			&mes_add_queue_pkt, sizeof(mes_add_queue_pkt),
+			offsetof(union MESAPI__ADD_QUEUE, api_status));
 }
=20
 static int mes_v11_0_remove_hw_queue(struct amdgpu_mes *mes, @@ -196,13 +2=
03,9 @@ static int mes_v11_0_remove_hw_queue(struct amdgpu_mes *mes,
 	mes_remove_queue_pkt.doorbell_offset =3D input->doorbell_offset;
 	mes_remove_queue_pkt.gang_context_addr =3D input->gang_context_addr;
=20
-	mes_remove_queue_pkt.api_status.api_completion_fence_addr =3D
-		mes->ring.fence_drv.gpu_addr;
-	mes_remove_queue_pkt.api_status.api_completion_fence_value =3D
-		++mes->ring.fence_drv.sync_seq;
-
 	return mes_v11_0_submit_pkt_and_poll_completion(mes,
-			&mes_remove_queue_pkt, sizeof(mes_remove_queue_pkt));
+			&mes_remove_queue_pkt, sizeof(mes_remove_queue_pkt),
+			offsetof(union MESAPI__REMOVE_QUEUE, api_status));
 }
=20
 static int mes_v11_0_unmap_legacy_queue(struct amdgpu_mes *mes, @@ -233,13=
 +236,9 @@ static int mes_v11_0_unmap_legacy_queue(struct amdgpu_mes *mes,
 			convert_to_mes_queue_type(input->queue_type);
 	}
=20
-	mes_remove_queue_pkt.api_status.api_completion_fence_addr =3D
-		mes->ring.fence_drv.gpu_addr;
-	mes_remove_queue_pkt.api_status.api_completion_fence_value =3D
-		++mes->ring.fence_drv.sync_seq;
-
 	return mes_v11_0_submit_pkt_and_poll_completion(mes,
-			&mes_remove_queue_pkt, sizeof(mes_remove_queue_pkt));
+			&mes_remove_queue_pkt, sizeof(mes_remove_queue_pkt),
+			offsetof(union MESAPI__REMOVE_QUEUE, api_status));
 }
=20
 static int mes_v11_0_suspend_gang(struct amdgpu_mes *mes, @@ -264,13 +263,=
9 @@ static int mes_v11_0_query_sched_status(struct amdgpu_mes *mes)
 	mes_status_pkt.header.opcode =3D MES_SCH_API_QUERY_SCHEDULER_STATUS;
 	mes_status_pkt.header.dwsize =3D API_FRAME_SIZE_IN_DWORDS;
=20
-	mes_status_pkt.api_status.api_completion_fence_addr =3D
-		mes->ring.fence_drv.gpu_addr;
-	mes_status_pkt.api_status.api_completion_fence_value =3D
-		++mes->ring.fence_drv.sync_seq;
-
 	return mes_v11_0_submit_pkt_and_poll_completion(mes,
-			&mes_status_pkt, sizeof(mes_status_pkt));
+			&mes_status_pkt, sizeof(mes_status_pkt),
+			offsetof(union MESAPI__QUERY_MES_STATUS, api_status));
 }
=20
 static int mes_v11_0_misc_op(struct amdgpu_mes *mes, @@ -316,13 +311,9 @@ =
static int mes_v11_0_misc_op(struct amdgpu_mes *mes,
 		return -EINVAL;
 	}
=20
-	misc_pkt.api_status.api_completion_fence_addr =3D
-		mes->ring.fence_drv.gpu_addr;
-	misc_pkt.api_status.api_completion_fence_value =3D
-		++mes->ring.fence_drv.sync_seq;
-
 	return mes_v11_0_submit_pkt_and_poll_completion(mes,
-			&misc_pkt, sizeof(misc_pkt));
+			&misc_pkt, sizeof(misc_pkt),
+			offsetof(union MESAPI__MISC, api_status));
 }
=20
 static int mes_v11_0_set_hw_resources(struct amdgpu_mes *mes) @@ -372,13 +=
363,9 @@ static int mes_v11_0_set_hw_resources(struct amdgpu_mes *mes)
 	mes_set_hw_res_pkt.use_different_vmid_compute =3D 1;
 	mes_set_hw_res_pkt.oversubscription_timer =3D 50;
=20
-	mes_set_hw_res_pkt.api_status.api_completion_fence_addr =3D
-		mes->ring.fence_drv.gpu_addr;
-	mes_set_hw_res_pkt.api_status.api_completion_fence_value =3D
-		++mes->ring.fence_drv.sync_seq;
-
 	return mes_v11_0_submit_pkt_and_poll_completion(mes,
-			&mes_set_hw_res_pkt, sizeof(mes_set_hw_res_pkt));
+			&mes_set_hw_res_pkt, sizeof(mes_set_hw_res_pkt),
+			offsetof(union MESAPI_SET_HW_RESOURCES, api_status));
 }
=20
 static const struct amdgpu_mes_funcs mes_v11_0_funcs =3D {
--
2.35.1
