Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 594E2606A881
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2026 11:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Qn98YMx6
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA9BF10FB70;
	Wed, 11 Nov 2026 11:55:51 +0000 (UTC)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012034.outbound.protection.outlook.com [52.101.43.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7334D10FB70
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2026 11:55:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Chdbt7F7JapYBXp51EUldSwZjwK8vTkByoXEBGeRaic2a9LmyxEaIrgYQh2S/T1lB8Zb4UDLBl8jdNj8d1ugzQfVzcnGa+4DuF2hdEgmctdiM/wHMNDn5E0d0DnaLWaaeNWPO75cX6bZWXhOJdLeS6vD4CsZbla1l5lkjMnTEb6kuitFE+5tS80/xvnpSilnxDZ6TnWAhWSISqzEJHblnkoU6nSPqTOST8/z1R3xlVFGoXgZleD7g+nTXFwLfWcEDWD6oEcTWPjmkogcaaNyNhoYAibTw/qrBP3jQ1InsF+PpCSIGF6YVKltrB42JupETyg0wXlCFmdm+6zuyBcp5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bxmmJpx6R46yiPHx59LbQN67ERXjHfGzuVXZJdfJFUE=;
 b=UQDv5JeCkf8jwDpFg1oCTZ+1Fu/whP5rPCEDQz3Mdm+Yod8uaS3pdUg8z0kVZFa/hDXVysnJLV34S0UoK7QYHiPOIG1FiBQH7E0U2wIp1uf8tj8JhrcW+Gf38bMknVXPVopRRVcRmO4qFYGcj0fl00nXMhJBIyVEWL38IN1v+gls4Q23RVapQnJCT0eolUaE6U16aW4Tr0zxwESETbCULOBwsb+rvFEemJLYbXlahzWyfau4rQ1D4JrZYPRHflWK/OAWdwZX97CfsuecsEqCY6bnhi5H4O/v++WeVps3T7TLZIA0ci5qTOA2yxCZW2FhWuEE9FEDIvkkGTaNWGhfyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bxmmJpx6R46yiPHx59LbQN67ERXjHfGzuVXZJdfJFUE=;
 b=Qn98YMx6pHOmPkhAd+q/uRIwJCeqKCGknzW58oGCs78s+NxoiJPGdByZhBMaJDHETnF5Of96AU9NGCVhIJXiyzGQXQbhSHnLdpheIB44kHFUMDEP0J/UI/SVp1+aUaFvJ+8q4xf2FkOZ0d+UKnq3ODzYfBfps4ds4Y7X3zL8044=
Received: from MW3PR12MB4572.namprd12.prod.outlook.com (2603:10b6:303:5e::7)
 by LV1PR12MB999279.namprd12.prod.outlook.com (2603:10b6:408:3f7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Wed, 11 Nov
 2026 11:55:43 +0000
Received: from MW3PR12MB4572.namprd12.prod.outlook.com
 ([fe80::79cb:c567:1825:51fc]) by MW3PR12MB4572.namprd12.prod.outlook.com
 ([fe80::79cb:c567:1825:51fc%6]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 11:55:43 +0000
From: "Mu, Zihao" <Zihao.Mu@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, Thadeu Lima de Souza
 Cascardo <cascardo@igalia.com>
Subject: [RFC PATCH v2 1/6] drm/amdgpu: handle missing or empty SDMA VM update
 jobs
Thread-Topic: [RFC PATCH v2 1/6] drm/amdgpu: handle missing or empty SDMA VM
 update jobs
Thread-Index: AQHdcdOUVb/T9QOe9ESQcBzNZgoZ8w==
Date: Wed, 11 Nov 2026 11:55:43 +0000
Message-ID: <MW3PR12MB4572DD8FCA6028A2156F0B639E712@MW3PR12MB4572.namprd12.prod.outlook.com>
References: <MW3PR12MB4572FABB93F6676FDBA1D2479E722@MW3PR12MB4572.namprd12.prod.outlook.com>
 <4edd67f7-381a-4446-9509-552739c8f016@amd.com>
 <MW3PR12MB4572A08ADA8CB7BA9F83AF519E712@MW3PR12MB4572.namprd12.prod.outlook.com>
 <938026a1-3b02-40b4-98e3-a0a22f045f82@amd.com>
In-Reply-To: <938026a1-3b02-40b4-98e3-a0a22f045f82@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW3PR12MB4572:EE_|LV1PR12MB999279:EE_
x-ms-office365-filtering-correlation-id: 582d893e-ac0b-4633-df40-08df3feab6cf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|18002099003|22082099003|6133799003|10067099003|3023799007|38070700021|4143699003|261102123227099003|11063799006|261009223027099003|261022105027099003|261022075727099003|261021121427099003|261021123027099003|261026140227099003|261026121527099003|56012099006|261028144727099003;
x-microsoft-antispam-message-info: vDoucMRIyFN9A2/t7cpIKeHcns10U0JS/V/sPmIx8ShYXIW7wzEhT2IW11GssXAgFA3ZRuvqwgCPV2NlaWY3vMiOyFswkXWeeTuQkv3VG0uOhO5GBLUb8liAgG1kyfuT+gDWdrLN+Pp1WN3AXyyleebkbTVrt+86bj/JS0Pbij/sqkgMXD5DdaNRTLcrKNMHmLm/xeK2B9VWhZLYDPZVa2n5L7IyhfLJXC1zIZokqewrYGIVNJUtkAikwNfmvDosO6FRcYXK3wTMbcvil348L6/7z14QwvB6NJ15M9xl2GEo9xQVzALgSL3eNb/y3TLLrK+gIsjvRKzVU4xqaF7229hn7DHzUWao4KW6hlN5RTjF3LDT7/NdSpppWDO7WWBUP/vgnpzWDmaAHfnyE4ORHGsOH9i15EX90raaa6qcF8Kykk9QHl/X0HnyR7dXK5ad39Ea83xP6D+NKVhE6zPxr/MmPULxIPkgxVvo7d7AAQgrqHBQdI3ye1X681tHC6OHRqgVRhOazD2Nit0hERXcDsmQ9lZnQP7UdVhyG/599EisDYcjLzbo11hwdt69TrY4ZCLSMPlI40Sk2RJ4JpWe6VrD1ncVLJd45rCpg2PVdZw8A3LvWbeu8Xvu0dgJ0t2oBohxAw6wPloiGbinWfyVo0ilyfr9nlvTd4+qs/jAY78=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR12MB4572.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(18002099003)(22082099003)(6133799003)(10067099003)(3023799007)(38070700021)(4143699003)(261102123227099003)(11063799006)(261009223027099003)(261022105027099003)(261022075727099003)(261021121427099003)(261021123027099003)(261026140227099003)(261026121527099003)(56012099006)(261028144727099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?eS+Cy+ZyVRRaXJEEVSYXXv4229K/E2r4rFWxLdxwJ1DHBFoH8qEBM7+jhCqo?=
 =?us-ascii?Q?3J6pM/xV4hMy6N8jEgiABA0NmkICGWFZhO6QIXvAdWmzFIMTmc9nz5lYBNHg?=
 =?us-ascii?Q?trll/0pdPq9x8QSsvsBRTjLo8/ONcOZamzAlP/Zj7m8v3L5qbE5BrHPv3Zvx?=
 =?us-ascii?Q?pIpapPInuyB5XEIkmyQPwpgdYf/eMU7CdD2SPoX7HDVJeMFYmQqAJDDg2yp/?=
 =?us-ascii?Q?wjX9odc0ZlbagIdovUPfAY2tBoiEpH99WTw+wCp5KC5vzcrehzbPZjnXkBCt?=
 =?us-ascii?Q?fsfW4IeFIY/6S53tNH/KRUPLqUJSuqv/LaiCc7UNVdqtAGtGjLkjm9MCbXXG?=
 =?us-ascii?Q?3Rc3xQJ2X2p4R2wGZ/2vbPLFbUe90ZSZSrN78ffe1H/gXBNviEvFRm1KMS+y?=
 =?us-ascii?Q?zxzuV6VjhXfvVnwHZdMN5W9Ic7xztcPCJvTi6B4fH0oDdyj+9Pe+Fl4SBPMJ?=
 =?us-ascii?Q?stqEA8Dvi1NGXeXKJuf6dPCJJFYN3gwUmcra066XgrbChLlBkAmRt30uJixP?=
 =?us-ascii?Q?YPDXtrlnYVihrHbM0FVi3BRbDKjf4HqFQAWh7yCBos8SYvbhXIp6NBd3x3Rf?=
 =?us-ascii?Q?gMIUDWjgs4oEU3D3pb86L8TeDCalI3+Vjk7svxzAZESdXYiX6w1YkSNa74+O?=
 =?us-ascii?Q?d56I2VXc4qZs26nfeziPmm7DuMxIH9BInrQ0MZ33HGUx4x8+laS/aBL1UtHf?=
 =?us-ascii?Q?iquFh23ngiT72VcsUgGCRNY22sPnCwyzwAk3J1YQwFbDFoVv7q8wGgtyaebJ?=
 =?us-ascii?Q?VrQcbYRdoZNTjQzi3q/g/XOLPbY19+nCkwKlcHX0uoGeufYNNYVSIAqQV7kM?=
 =?us-ascii?Q?j1asDbcD5W/YStvseZAlVYeEuHgVvXWCT9INdyHS8xp5D67Kq92n7MbDP99f?=
 =?us-ascii?Q?TgbXHyRaZgsZKAYm6WidDABXfgHO6vEfdsiL9bP0mfN2dLeIDK9SOmhPgkvK?=
 =?us-ascii?Q?g/2Z1P+UIjjlEiMWESCKFQUQ5wMzr6vuS5ZvP4+dLXp6gUPN8cLFRDo/uHQJ?=
 =?us-ascii?Q?rWAuB2DyVeKHPF7SzbuqBGa1VCw4Y3L7CkXfCBI0BiymkB3rYaop92hIgkwr?=
 =?us-ascii?Q?oZJqrsK7ESp1AS+oFPI9ZOYdPIHn9BaUI+Iarv82Z/+v5f4skD7mw/20aOcY?=
 =?us-ascii?Q?Glys3xBu486lKa5bAdqlJrAzj+TOUZjDyJDSsNkmns1r/e0/Eq5Zlxsg+GLU?=
 =?us-ascii?Q?mcV3muAMhDKFVLBBaMfOsEdV0JevrLwM3Ydr9IZnCwp9brdS8Kr7qWLaGVtD?=
 =?us-ascii?Q?mNja3is8Fev+k1/7vmrhtRQaJUCrbQe9E1mhxOrtHwk7GKhxX+70p0Ft9l8H?=
 =?us-ascii?Q?+x4H05kHr4HL3UbLo1OeQutcs3g2Z7yFDTVqI35LpZSCWzKPzOoTUTn7Fi06?=
 =?us-ascii?Q?T+Py+gu0+6N/0tFMAMvic48YRFpKxm64K2S3InItGUwHGoc1HahTjxCD3Smz?=
 =?us-ascii?Q?N7nNMwEAeOK4xssYt+toEQud46QGlaWchA5Xqv36I8sQZlIG2TkOR/s0cwMG?=
 =?us-ascii?Q?aKyUHdFTfR3dijPfZVijCb4aAohWPtisAp6zx8eU/5+pDuaVcZCOfv/Atqr4?=
 =?us-ascii?Q?Et12q8fYQFmh8smnBEHLCxbKZB45KuRKqM/C0ydAfzcP//Y5co25+lbRpRJa?=
 =?us-ascii?Q?D+VizHBWTqSIRd7dV0smUfcXZ10fVer5timlldw8gkd9wWtwt20HR3hBxJZw?=
 =?us-ascii?Q?CIZrpqwf1KiO/4OC1h5jJM6Cxuo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4572.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 582d893e-ac0b-4633-df40-08df3feab6cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2026 11:55:43.1228 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R42cZYR5aTJCPRI0C+g/WEB9ZOiO93/L2t8r9MIAnJDEGgeEyJ2Gg7bW3UVFAfHO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV1PR12MB999279
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>

A failed PTE walk can leave an allocated SDMA job with no commands, or
no current job after submitting a full IB and failing to allocate its
replacement. A final commit of partial work must handle both states.

Return without submitting when there is no job, and free an empty job
instead of emitting an empty IB. Clear the job pointer after freeing
or submitting it so that a later final commit cannot consume it twice.

Based on Cascardo's earlier NULL/empty-job patch. Retain the current
int-returning commit callback and scheduler layout.

[zmu: Clear the job pointer after submission and retain the current API.]
Link: https://lore.kernel.org/amd-gfx/20260914-amdgpu_vm_fixes-v1-1-d6d8355=
91e0f@igalia.com/
Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Signed-off-by: Zihao Mu <zmu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_vm_sdma.c
index d3a5e848741..ade6c7aa15c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
@@ -91,6 +91,7 @@ static int amdgpu_vm_sdma_prepare(struct amdgpu_vm_update=
_params *p,
 	if (r) {
 		p->num_dw_left =3D 0;
 		amdgpu_job_free(p->job);
+		p->job =3D NULL;
 	}
 	return r;
 }
@@ -107,14 +108,23 @@ static int amdgpu_vm_sdma_prepare(struct amdgpu_vm_up=
date_params *p,
 static int amdgpu_vm_sdma_commit(struct amdgpu_vm_update_params *p,
 				 struct dma_fence **fence)
 {
-	struct amdgpu_ib *ib =3D p->job->ibs;
+	struct amdgpu_ib *ib;
 	struct amdgpu_ring *ring;
 	struct dma_fence *f;
=20
+	if (!p->job)
+		return 0;
+
+	ib =3D p->job->ibs;
+	if (!ib->length_dw) {
+		amdgpu_job_free(p->job);
+		p->job =3D NULL;
+		return 0;
+	}
+
 	ring =3D container_of(p->vm->delayed.rq->sched, struct amdgpu_ring,
 			    sched);
=20
-	WARN_ON(ib->length_dw =3D=3D 0);
 	amdgpu_ring_pad_ib(ring, ib);
=20
 	if (p->needs_flush)
@@ -122,6 +132,7 @@ static int amdgpu_vm_sdma_commit(struct amdgpu_vm_updat=
e_params *p,
=20
 	WARN_ON(ib->length_dw > p->num_dw_left);
 	f =3D amdgpu_job_submit(p->job);
+	p->job =3D NULL;
=20
 	if (p->unlocked) {
 		struct dma_fence *tmp =3D dma_fence_get(f);
--=20
2.43.0

