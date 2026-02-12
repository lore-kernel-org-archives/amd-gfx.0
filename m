Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFD11EEA846
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Feb 2026 18:31:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 40DD210E0CC;
	Thu, 12 Feb 2026 18:31:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wKzFiCv2";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013003.outbound.protection.outlook.com
 [40.93.201.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D57910E200
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Feb 2026 18:31:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D6i4rMV0KD2bFa4hbArWHNeed7Qhlvo6NrH4TZ1Zwq6e7HicNMiSW+YeRMo6M0fKkKdzFGE/FZZReVG8no3GCi/Zvsve+yDXP/fpebjgC5venKe25EWOyV4yBZWhPH3vgfjLzL/LZT/sCjDEyRKI5sdpbldcA3sLe4pE9lizv5kOU+sw4NmDop7I2QUdxUTijZ9C0zJyX2px/UP+wpq0gihAtDbE91zsg+pEGkOgz6YPGeMynYUmk4UZ85lFn4Z2QqR0I/SqqiODUw+1YAGr+CN1QfkMInNEN1PXUG9D49obuQpZ9jRKJF/FjScfJoqqHNJ9RTl8q290HzVBGC2Dow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3oUyFzsdn/tqbutVmsxH6Lk1xa+P7kg6XaG4CEIKdJ4=;
 b=LADjpIerDE2y2RPfRNis46NOYfJ8V6WXq28LVWpbcXAH6ZwetLDCvdxL6T5VtMfqaElTjHdss3s+JymhQMRCrL+jNLSSnU0de+0S5mwlVzhtmr95kbZS+xry5/pX2H4SAmiI8Ts4joBgNfQISC9GwL6Ln4s+/crWO9jIryrwWAMaJ4iGpk4LMIgFcv3OaO6GSlDqehf4WwuTT+NN8WSj2LV+QReEUzIcYj3I0SvSaxQMPhv8GTvro/gEdgLdMguGRDenqVNNpW+9oFIW7fq3D7DnH1owu4tTQBxL/FMtQaASpRjGaEwqXpneygDmZ3asGycF3Cu9RB63ms6Ay+0ADA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3oUyFzsdn/tqbutVmsxH6Lk1xa+P7kg6XaG4CEIKdJ4=;
 b=wKzFiCv27IwzefPrQe++mRHOeYtP5JcFt7aYgknODBsTZjp7ZSuVxI9B8Fve24D2FuVTfGGTFK9W/O/ASdAEWpgx5AL555t28gdnBqh+SRKqGRrocnpAL1j+46ubAnUc8FcDhJz3uQvPbvLU/BRFXBq0hNOeiQA0B8SGKz2qLKY=
Received: from SJ2PR12MB8650.namprd12.prod.outlook.com (2603:10b6:a03:544::13)
 by BY5PR12MB4242.namprd12.prod.outlook.com (2603:10b6:a03:203::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.13; Thu, 12 Feb
 2026 18:31:16 +0000
Received: from SJ2PR12MB8650.namprd12.prod.outlook.com
 ([fe80::574c:e97b:b0d8:3957]) by SJ2PR12MB8650.namprd12.prod.outlook.com
 ([fe80::574c:e97b:b0d8:3957%6]) with mapi id 15.20.9587.017; Thu, 12 Feb 2026
 18:31:16 +0000
From: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
To: "Liu, Alysa" <Alysa.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: Re: [PATCH] drm/amdgpu: Fix use-after-free race in VM acquire
Thread-Topic: [PATCH] drm/amdgpu: Fix use-after-free race in VM acquire
Thread-Index: AQHclryfYl6JnJZSnE67cDukdogV+bV/bfrI
Date: Thu, 12 Feb 2026 18:31:15 +0000
Message-ID: <SJ2PR12MB8650F18EDC866027298677818C60A@SJ2PR12MB8650.namprd12.prod.outlook.com>
References: <20260205162846.106865-1-Alysa.Liu@amd.com>
In-Reply-To: <20260205162846.106865-1-Alysa.Liu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-02-12T18:31:15.792Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=1;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR12MB8650:EE_|BY5PR12MB4242:EE_
x-ms-office365-filtering-correlation-id: 0bc40f01-dd1e-4498-04c4-08de6a64e84a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|7053199007|38070700021|8096899003; 
x-microsoft-antispam-message-info: =?us-ascii?Q?he19I9V/xyQ9zMbcgoWBi1/i6P1f0ix/vawmWOOPCX10uh/IkDBcheFwDLSI?=
 =?us-ascii?Q?dgp+fsYEP2kiCw+NdxscD9frz9s4TlFpwg/sIZcdVZvD6ha4Z/vBfz9GrOKA?=
 =?us-ascii?Q?W3TVSWXemyshTbFoBOaXK6C5Y5bYQpfq67z4mUKgHIKi5B9lZZjfPMDhoF85?=
 =?us-ascii?Q?5qYjM4g33QSPUX+kgxiWfCwjyNx7scyYaMeNJHii7ja47g4YROB1lG4YRHHC?=
 =?us-ascii?Q?bHBCUbpQWUaDN92n6dksdRJqlQ27jnjpYkr0l6iQtxcN1lDbuGkyvKppAsu3?=
 =?us-ascii?Q?3ewInCYDhjvSI0a84pqIXGllR1wK6vSy1SvKVz1hZClBhISk1LCC+fUqpiBx?=
 =?us-ascii?Q?e5iZCLGEnEfoGmQJw4pEggyORPraej3BVmRVBVgvf5KvxlZXxd7ucIYJQ2ax?=
 =?us-ascii?Q?Rc8Bf2veTZ5Lz9mdYDzv1EY9tCdAG9tU45hbMn/JFyisLxJ1DZ80q5ZnuJYY?=
 =?us-ascii?Q?b9c2k9x9i1zDsWCFpOs8+htkVeaCQng53t1TiIMRpTpWMml/XPUgcCxCLj/w?=
 =?us-ascii?Q?EdWZjfAkseohviMF+pq1RVOPUAeQb4sGLssO6yg1haYS+s3OMljOj8EsYe5v?=
 =?us-ascii?Q?c2QuYRJb0C5r77YoYMwkUgHFBt/koeMgbt50Ahc9To3BBaUaS23pEg5mk4Et?=
 =?us-ascii?Q?yE5gn2+GZeKEyxasumrdJ/hCpbNP/KsjrQa4FXhdkLVtI3CDSzpFzl8+3sau?=
 =?us-ascii?Q?JjiG8OvaQaRJygPIJ/l+Mn8aSA4NfhV/pw1n3vSF/DkqPfV98Z+MPi0qNkeU?=
 =?us-ascii?Q?9v7p9mYwitXkUrW2kAFnn5KXO8Hgkomd5tqDI6PLi2elawwuLTzoobomqYrN?=
 =?us-ascii?Q?nNdpMszlp+aL3e2otJCsBCyhiYKvqxO5gHGUza7AHvoyIiqZ/Iun40U1lLQB?=
 =?us-ascii?Q?btNj0Ta7WVVu6xuTJcMkl0+bVpmv+7oE/EdjF31BVIqKi14VdYrBpkMWywtt?=
 =?us-ascii?Q?OsvbcKQViyXNlHzoXSIZXBFz8Y6vfM1Q2TV3ChZfc3TsOWd5DyafSBfx8zov?=
 =?us-ascii?Q?AhzJGBtmJQa2BwZ0T0SGeCPgfrTF73txjrdYTX+K9OconXyBjwHJktN+fLs1?=
 =?us-ascii?Q?1e67PATF8TQlsShI/525sG6DVW9kMegJBsKmO4KLVzkjf/HOr7BWUvxoZ4y/?=
 =?us-ascii?Q?u+Y6XtNwJI9qADyG4016FfXXIV5NLwfwqN18oRNg4YebIvO1mWsP/zCeFWwR?=
 =?us-ascii?Q?p+UGFCn6NfYl8OeM2L6AGKwP3Yak5nD+gZ4Rm1K8jUywyJakMkCBF/ZcNOkl?=
 =?us-ascii?Q?hMdPPhcPNRbpKFqlejw6fX6Rcoh+IMeEaLV5t50FeyQ5eDSAra5XTGz9zCVl?=
 =?us-ascii?Q?bTGEayD+ppAyDu6ueqSYYRI/ozS1VqV1QSQdPHGwj4lMyJJoKVsZVdOV/sq+?=
 =?us-ascii?Q?gDK+G8xV78/dOtYbEd7aOY6ROYGdLorUdBTWjYfXKhgKmqGvHb6C/nCJu1oR?=
 =?us-ascii?Q?ff/LAiBpE+HV/19w5yu+l9Ri2G8SwPnsooGS0jGUcN1H8q11PWlLKqFJHVFZ?=
 =?us-ascii?Q?V6XzVscm2qNaTNMvoA6iS9AXL1QWktGfVKnoeVEF2jRaaqCL4tbleF8DNl2S?=
 =?us-ascii?Q?tlEFPMj8xj8lK7ZOXjIfs+/g+KFF7SXmLK5x6FURr+nPZY+yd4uaBn2bCrUU?=
 =?us-ascii?Q?YVnluMYDP7Oij/EylJtKqmE=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8650.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007)(38070700021)(8096899003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Zvq/nwHPJZNZgFfT8TBt0Jr0eyaFCongl/7LrcIGO0ddu44Z7Y7X8TT9jsyg?=
 =?us-ascii?Q?ZWwzY/Px4C8pDQmIYENxsE1oiPpVUt3r5LcFPpjExeLhGZxg+t0niosGQvf5?=
 =?us-ascii?Q?sY9fIoeT+azVpYxvpi+t0gqBZ/SIzLvG4sO6InPNPsDenrFdwNBJsd54IyP9?=
 =?us-ascii?Q?Vwfe+QYfbbEjFdgbsF7dw9LjBEtaG635ac/njqdOdS9bYjqC2iTuiz9coclw?=
 =?us-ascii?Q?jH+8SpZkzViKdms3X9WvsHI3j1iNHZ/S/I6aGhVilB8HvD589b6Ib/XgUczV?=
 =?us-ascii?Q?/87KEQsOrlejercJwMXrs4ZLK8XqS/jiUtUXwr/WC5mj9+XfVLW96NBCCzX8?=
 =?us-ascii?Q?mKjEA4jdCLQU4uAeNzyge/psKKolSUCb+7CQFjbW+bqcqSVMjm7RKC1QrWAF?=
 =?us-ascii?Q?sVA9gnnOWfWcVHCqHHMVLSDEMCYj11iPYwWSCxGmKk+qNSqPT9gGJEvtMz+V?=
 =?us-ascii?Q?Gh68fZjimSxFWivaebXNGLBSWFbuJRA4V5Jx7xoaSvrJb8xMkVBzPG7Ficbj?=
 =?us-ascii?Q?EFZ0FMmvt7gUAwXgkPS8Jn5kOv2QNq6/p/LJ8/0c7SQr3MTC1cGIs/EmWM10?=
 =?us-ascii?Q?7die96xHzILuA/GQKs6cd+En9l+RKtoEK9HbrRLB8m/i/b56KPCznVxZTTrI?=
 =?us-ascii?Q?Q+9q5nFKKjVjm2ELN69yZ6Y230wt828JUS7E0YScnfbDSyDxL0BDBJvX0PmG?=
 =?us-ascii?Q?IiBeBgXBBSqDJuy8nOXzAY/Ls1/mY6+2drAO2nQfsjIpw6nUaTRoKbRpqXJk?=
 =?us-ascii?Q?d3z7j87CSUoJqRoBIz84WtuU5kWsBspSRZubpHoVmvonlTKa9cWeXG7LOtuj?=
 =?us-ascii?Q?KSGeNOJ2SqaIPgnrzr8XkNb4FvWN3G0FxDuUYG/nS/EoWbTttH2sStxx0jxf?=
 =?us-ascii?Q?PyiVmss0FrfH15BH6NjWKKFXEwWMhBsbqDHNF/oK1AVBGMl/96Bir4frUGC9?=
 =?us-ascii?Q?RjEoU1qwyH/tQgP7PGYlgpm5Pqinfai3bLDLtPSADjvWGnnIkSTF0zgd2t8x?=
 =?us-ascii?Q?GUSSPNAYhrtoNtm1BkxOMIMf0rXwK2fyS6GIa2VRbnM2zMhucQMv1Z15aQv+?=
 =?us-ascii?Q?ZGCUfwlSkx1yqaqLZeM3AjDTKGjSx7ABMqS2mpc9dIRvkhaU0nnoeEt8Gsha?=
 =?us-ascii?Q?5u4fvXVswdyZ7utDZ3/BbolCiRGWR2fDH3KI+8qrLn1hpM8l6d1H4roM3x5l?=
 =?us-ascii?Q?v5AF4W+j36kw6bLWe59P/AqsFb1JKF/GLjwUkAkrxk8iNUNsHk4vtTV/jF04?=
 =?us-ascii?Q?pQ33hq3dBhbZfzCJcbhtFqYS00z/fypF062GJ0lSqmGa7EfvWWELld6Z1oQT?=
 =?us-ascii?Q?USMEhuwbolXSKCcnhdZZ/Ri4lYA/w38C1ClOZNbedd+LjwzXZgSShKzRKzlC?=
 =?us-ascii?Q?XQe5qXMpCrTv9FTAbdU5KZ0hviqVCtSxn/LKX75R8tzI0DQ0vhXeL0L2ylHB?=
 =?us-ascii?Q?bNqI0hcdMJEDNer1FCtiGHes1AsJjSrNquta46zGOVv9IZfLcBLQn2SWuqDh?=
 =?us-ascii?Q?KUQDw0Y6uQe69onwlOifFAyeG3Jvi88MQIxgHBTJ6V5sWNQj6BLZ2Lo3mw/2?=
 =?us-ascii?Q?L2ZVYIWcJ/zc6VTMVfe55DmtmyheFSLSZUUfjUzvnKrvXQV2dRRFmphiAxSM?=
 =?us-ascii?Q?1HkltMXjlPgwue4E9jBauUrMsbBZWbsF8Gu9LWdHD8iyVa5M0Wxk1A8v2d8m?=
 =?us-ascii?Q?VY0yJidZJ5gkJUXIMVjRo1Qej4DF9A3y9uOwjh0E9tmfHBHf?=
Content-Type: multipart/alternative;
 boundary="_000_SJ2PR12MB8650F18EDC866027298677818C60ASJ2PR12MB8650namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8650.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bc40f01-dd1e-4498-04c4-08de6a64e84a
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2026 18:31:15.9253 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z0JNbGro0vsGyXPqKhwaT6+kW13cUuWtb+f7DH8rgnk+QYOZVZGCXoJEmE56VU93kyDIhKOzi/JxOOar5bfTzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4242
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

--_000_SJ2PR12MB8650F18EDC866027298677818C60ASJ2PR12MB8650namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - AMD Internal Distribution Only]

Reviewed-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
________________________________
From: Liu, Alysa <Alysa.Liu@amd.com>
Sent: Thursday, February 5, 2026 11:28 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Kasiviswanathan, Harish=
 <Harish.Kasiviswanathan@amd.com>; Liu, Alysa <Alysa.Liu@amd.com>
Subject: [PATCH] drm/amdgpu: Fix use-after-free race in VM acquire

Replace non-atomic vm->process_info assignment with cmpxchg()
to prevent race when parent/child processes sharing a drm_file
both try to acquire the same VM after fork().

Signed-off-by: Alysa.Liu@amd.com <Alysa.Liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu=
/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 00ea69baa126..f7b2358a0303 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -1432,7 +1432,10 @@ static int init_kfd_vm(struct amdgpu_vm *vm, void **=
process_info,
                 *process_info =3D info;
         }

-       vm->process_info =3D *process_info;
+       if (cmpxchg(&vm->process_info, NULL, *process_info) !=3D NULL) {
+               ret =3D -EINVAL;
+               goto already_acquired;
+       }

         /* Validate page directory and attach eviction fence */
         ret =3D amdgpu_bo_reserve(vm->root.bo, true);
@@ -1472,6 +1475,7 @@ static int init_kfd_vm(struct amdgpu_vm *vm, void **p=
rocess_info,
         amdgpu_bo_unreserve(vm->root.bo);
 reserve_pd_fail:
         vm->process_info =3D NULL;
+already_acquired:
         if (info) {
                 dma_fence_put(&info->eviction_fence->base);
                 *process_info =3D NULL;
--
2.34.1


--_000_SJ2PR12MB8650F18EDC866027298677818C60ASJ2PR12MB8650namp_
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
<div>
<div style=3D"font-family: Calibri; text-align: left; color: rgb(0, 0, 255)=
; margin-left: 5pt; font-size: 10pt;">
[AMD Official Use Only - AMD Internal Distribution Only]</div>
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Reviewed-by: Harish Kasiviswanathan &lt;Harish.Kasiviswanathan@amd.com&gt;<=
/div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Liu, Alysa &lt;Alysa.=
Liu@amd.com&gt;<br>
<b>Sent:</b> Thursday, February 5, 2026 11:28 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Kasiviswan=
athan, Harish &lt;Harish.Kasiviswanathan@amd.com&gt;; Liu, Alysa &lt;Alysa.=
Liu@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: Fix use-after-free race in VM acquire</=
font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Replace non-atomic vm-&gt;process_info assignment =
with cmpxchg()<br>
to prevent race when parent/child processes sharing a drm_file<br>
both try to acquire the same VM after fork().<br>
<br>
Signed-off-by: Alysa.Liu@amd.com &lt;Alysa.Liu@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 6 +++++-<br>
&nbsp;1 file changed, 5 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu=
/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c<br>
index 00ea69baa126..f7b2358a0303 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c<br>
@@ -1432,7 +1432,10 @@ static int init_kfd_vm(struct amdgpu_vm *vm, void **=
process_info,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; *process_info =3D info;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vm-&gt;process_info =3D *process_info=
;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (cmpxchg(&amp;vm-&gt;process_info,=
 NULL, *process_info) !=3D NULL) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D -EINVAL;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; goto already_acquired;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Validate page directory=
 and attach eviction fence */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D amdgpu_bo_reserve(=
vm-&gt;root.bo, true);<br>
@@ -1472,6 +1475,7 @@ static int init_kfd_vm(struct amdgpu_vm *vm, void **p=
rocess_info,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_bo_unreserve(vm-&gt=
;root.bo);<br>
&nbsp;reserve_pd_fail:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vm-&gt;process_info =3D NU=
LL;<br>
+already_acquired:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (info) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; dma_fence_put(&amp;info-&gt;eviction_fence-&gt;base);=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; *process_info =3D NULL;<br>
-- <br>
2.34.1<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_SJ2PR12MB8650F18EDC866027298677818C60ASJ2PR12MB8650namp_--
