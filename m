Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C550E606A321
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Nov 2026 10:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=AKQ8nHHE
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2852D10EF81;
	Tue, 10 Nov 2026 10:30:03 +0000 (UTC)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013046.outbound.protection.outlook.com
 [40.93.201.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2278C10EF83
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Nov 2026 10:29:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bfx3Hy2x5LFj11VcU4+J6B3ztYYmEmyGsr6OthjLZuRjNu3kuYA2i1gZHLZUwJ843ZVx7kGo9+x6NtdXxfrdP4RR+Cwv9190WTbwkZHZgoxKaErijZD2hRVWYR3BKCtvanPPVavMd2Equ7C3OCnrruBu36KA+/6ygfUiLNtXL0uF0BCWWgsfir8dY9Yo2WFipkHkEJzXOb3yWwlhItquPTL2DL3vOZYR1Bd00inJk8MMOfKXX5U2KLe6T7Mcn5nhEfA/TFvxRe9iSJ0AJ04aQglYLArCjgXQuUnAjRrTucD+T5ceVQVMpL3QbJr1sCoUWWti9DlzHqqtu9a/YMLYnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p2RiMO8kZyC2DNH4yTUB3RenB5Aj36kL9X/zXvzMzmc=;
 b=q49xX0gE97nFYHOM4MWyBkWO3fBrVr9Wfky4+XTCN4CendBcKJhwSUdpYUO4H/NypndyG+Eu14WLOAtRooD87KIac9vdVziP27ZkMTmE542StGccpxRV9n1D3bw9GTzkVQ0DZlcFq7PkRHftV7/HDg1KMWHnpsMSrzwHCfaFToFyhzjmSX8R01xICAqzznzDKdEGkj/9TGxcnWy89JRQl9Th+vlyYaHeKQW75p62f7TgCkWh81fUVV/4nIoaclhk7JTb+h5CHX9ktggrcsNqfgKkMH5iaf1HDVpUxO5mmBCyLoLlwBIuGpm9Zl74KXyoC2AWUr2ilTinIC9Q84wuRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p2RiMO8kZyC2DNH4yTUB3RenB5Aj36kL9X/zXvzMzmc=;
 b=AKQ8nHHEFcBdDMbW8eVB48FezdpNrwv3QoPPw/aWJ3RPqWBRnXVMCSAp9Hv8+qtk95bDPvULyIgBwPoTBqTanX6DvGS1mBbB98MkQiIE6/oNxDAiZ74KbyS5G2sIIbSCRqu8QcidYl01TFNhqIIP3mn8w3n+z9CigYx4HUescvM=
Received: from MW3PR12MB4572.namprd12.prod.outlook.com (2603:10b6:303:5e::7)
 by CH3PR12MB9219.namprd12.prod.outlook.com (2603:10b6:610:197::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 10 Nov
 2026 10:29:53 +0000
Received: from MW3PR12MB4572.namprd12.prod.outlook.com
 ([fe80::79cb:c567:1825:51fc]) by MW3PR12MB4572.namprd12.prod.outlook.com
 ([fe80::79cb:c567:1825:51fc%6]) with mapi id 15.21.0615.007; Tue, 10 Nov 2026
 10:29:53 +0000
From: "Mu, Zihao" <Zihao.Mu@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, Thadeu Lima de Souza Cascardo
 <cascardo@igalia.com>
Subject: [RFC] drm/amdgpu: handling PTE backend update errors
Thread-Topic: [RFC] drm/amdgpu: handling PTE backend update errors
Thread-Index: Ad1w+33CPBXpwtqiSCW+OBsyK5Biog==
Date: Tue, 10 Nov 2026 10:29:53 +0000
Message-ID: <MW3PR12MB4572FABB93F6676FDBA1D2479E722@MW3PR12MB4572.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW3PR12MB4572:EE_|CH3PR12MB9219:EE_
x-ms-office365-filtering-correlation-id: 021b4750-9752-40b3-567a-08df3f158f0a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|38070700021|5023799004|11063799006|56012099006|261022105027099003|261022075727099003|261021121427099003|261021123027099003|261026121527099003|261028144727099003|261102123227099003|261009223027099003|261026140227099003|10067099003|18002099003|6133799003;
x-microsoft-antispam-message-info: NEyZURYJWAi1vAO1CXeb0SMGt4Xcsr7ZVbctOtdfjrINRtUh4SG3XwRwAI8OBBzZmG/fFcNHbQ0u1Jvzza5Hy/cvR3RxBfF/EnQG1J7PrXJNVRmcTtOLQxDPbzLwU5FeQGCySXGicIzdgSqAJMpwjqQI27H+X8Q50nVnuRXc1W04KhziRSOFYVWugx4UK+Q/Poxmee0XR/7Qr0B98tjhOxJ44ky+NhZK19naHu6j11Zj9PxaK1O9QUpxF7ZugpPqIn7JdNO0Vn3ed4vMZ4lWSZ0GXZAr96ls+wa8a8QsmmmAb5AjNVrpzk6Zn6zxKfcMPrsMezhkLwLD5iryIzhP4uQ76Ikz/SJf9pz3SEz7P8Us0XewPyfAUqKDd8YaExmSJGLKXrZK464q3LvWXG85zasLaXbqwcHjQQQTjI7bh21nEF2r8sziQaFCzswBPQo3J8uXfepwlxqtNt1XEohvF20g4Q7KVWTHVuzbt7p8Zf/IC/hfp1sE91ipC8vBlfnz7UgCkP7XkrC3WU4ez0iIjgcSrDjCWIHyS+DO9ORmnTDKbWqUmTasEENTCQTCC5RWxFiTzl6ymoWSab8b7qw4NB++iLmZ/fUBBDlWvycQzML/MAZGWzEDapAlx9ftlo5mlZGay5cX0uqRPn1aYvvmbPim2FWVN8+HiHcHTE8p5Ls=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR12MB4572.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(38070700021)(5023799004)(11063799006)(56012099006)(261022105027099003)(261022075727099003)(261021121427099003)(261021123027099003)(261026121527099003)(261028144727099003)(261102123227099003)(261009223027099003)(261026140227099003)(10067099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?uMsA+PnUrIG3nBf5F3MBHXTQwhYKNwEFu3MFcRLa9JHJcSxjqViF+pnqDFBh?=
 =?us-ascii?Q?sTZBWFgaiJo3C0zUDeVz6Sl58dSP/OISWPhRcGp1hIOasPaIzCcwncU4pCMz?=
 =?us-ascii?Q?sPgGAoFU7cfqWKh3bX/OFBJagEws48xLKzguBZsh3JosrFCbmLEGHH7vvJQl?=
 =?us-ascii?Q?CXoP4dFqAPE45dDJ3bgrfcVeKzO3MMlUnA2pIov2brpUZaKsJ+IFbamBq/Hz?=
 =?us-ascii?Q?qXS77TUkMQk/ADc3AFibjdfRJpMF2FW+Ya+2+HbhJ4eVwyTyQi5PT+V9s5H6?=
 =?us-ascii?Q?woaxKWbN8rGCSzL4Q1V2QLSWOgQAfvWzatTB2OUt6K9SSza42h+nuX5/s7/K?=
 =?us-ascii?Q?yaJYYgMxtDIY5CEn8lISvb44H5mQyuPj3KUWmnscP4QoH63jBwmpi4AURdP0?=
 =?us-ascii?Q?KJSLV8kyk5THdlV8uYT2EeiB9jXvt0NmViN0AGmy59AnYXJ3rEF5KUxtu5Vs?=
 =?us-ascii?Q?VjtoKStBC90y7nd+s5QykOaLkRbIYHh/gK/KVOmDLsTFPv00eZBURxMwnEHV?=
 =?us-ascii?Q?9hOufiS5Lt0OpSSAzLCd+9nQUg4TVfjN9ONNUjcnMXHUtThm39wc3gUi8ebe?=
 =?us-ascii?Q?vYx7XQdKvC6jiSkSHq4WOiZx9aJkpWaw/vbrEkBZLRXdCH+yQvFnN3ocd2zI?=
 =?us-ascii?Q?L8p881eN0efNX9eeAfo5R0sxG3d060xRLLYPCR22zKoGUl91YSE+BgypbUKC?=
 =?us-ascii?Q?fHw3DdbkdueHRRPAgKL86PrEaBKJb8rz57Xz9TKNeDPoyidR6F9T7Y7rVpbU?=
 =?us-ascii?Q?Kwc9z71m6o6zOsAyppyViU5P9cZvbXRo1KUP+Te09RpDcenNbSBMZ8O305sX?=
 =?us-ascii?Q?DCSCDMxhExxPDUxHDUG90XxE+26PJ6YjwsBC1GT1qFcC1mERNEVvDc0QMj9r?=
 =?us-ascii?Q?apeI2YGIWAC20TZvR65+6RnH520plqQWWAh4C40C9SxKWSWTw/PWSOZbXBGp?=
 =?us-ascii?Q?c5vgCILGg+6OkFXQ+WbuGVuu4KJbWuPaq7N9vIm0GWJVzShdL4CWERsbiy7E?=
 =?us-ascii?Q?ofd9uUKvf8lXyb5/Yde2og5BjcYPu9FWYHVhiWVl6XR3SSPf4dcbsQYinbWL?=
 =?us-ascii?Q?JboHB0pF28zP7XnfrxF33Pot1LcLFmaP8IxpFfFsSbngIo5jjkjUi00VOHak?=
 =?us-ascii?Q?ZDz5faKyFN0vuHN+6YYt0bjFU5fHlOwK2LZ/Lsgt0YQrFWaZ2ddHr1mEQoJQ?=
 =?us-ascii?Q?Z1CZD2Mk5zUL0YljNma+TQeMm8xv4Eu4EMle+neCPrapD1ChZndRPochcods?=
 =?us-ascii?Q?4cITcQPbAcg9OYiheoSkE06HeVWzrzXpmIJ9rHZ+6wYQURmd67PO2kgWSwJF?=
 =?us-ascii?Q?ryip4KZqX1jdrN6M0pF/cUOPcLpBbsP6+ooHmx5hKdAYLh+DTznj5b9+xbte?=
 =?us-ascii?Q?Q+KQoKYZBKX/uciyfvMo3NxCtpS8cbQtuBVNBLTcwkfZ7OXjCML/suqDZLFR?=
 =?us-ascii?Q?TYUrWHls5QSiM7BjANdbxGnDIi7SfP8QE/1mHqdCia2k1KHxpmW2U1LVnLKS?=
 =?us-ascii?Q?OIzJv5faV3l3xrC/+tcjfwRE30QsLRwhSx61QVonsX/I0EmQgBOGHjiTTWrP?=
 =?us-ascii?Q?jxdZBpe6X5jlYb6hV8LndmlKrHJ/tL6KSrq/PTLtcCWV/NsFPx5gTXswPEF2?=
 =?us-ascii?Q?Un6XyztDt5hjVTMp90upVhzwBs5capYoHTXMJvy0zpPfFYve4BGbdhJ8gA+8?=
 =?us-ascii?Q?zNZ9tKFsPVpJ8zYmqsUzewIvCww=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4572.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 021b4750-9752-40b3-567a-08df3f158f0a
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2026 10:29:53.6167 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YgzMD0fRyZdNl+Ga7oocBnsEPYHjcqDZA2hj5pITGHTvI8gBsgSjoLd5qkpfhReX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9219
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
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: zihaomu <zmu@amd.com>

Hello Alex, Christian and Cascardo,

I would like guidance on propagating PTE backend update errors and how
that should interact with the no-fail unmap contract.

At drm-amdgpu-next commit 5349075eac14, the void helper
amdgpu_vm_pte_update_flags() calls update_funcs->update() but drops its
int return value. The CPU backend can report an interrupted fence wait;
the SDMA backend can report a dependency or replacement-job allocation
failure. The PTE walker can then advance past unwritten entries, invoke
the backend again, and return success for an incomplete mapping.

The illustrative diff below returns that error and stops the walker.
It is not a complete fix for merging: propagating failures also needs
correct finalization of partially written PTEs, pending SDMA work, TLB
handling and the stack-local tlb_flush_waitlist.

The local RFC has two cleanup prerequisites adapted from Cascardo's
September series [1]: handle missing/empty SDMA jobs, and finish partial
range updates while preserving the original error. The ignored backend
return was also raised by Sashiko in that discussion [2]. I am not
claiming the earlier cleanup work or the observation as new.

I have excluded the earlier mapping-retention proposal, which Christian
explicitly NAKed [3]. amdgpu_vm_clear_freed() remains unchanged, and a
KFD caller still discards its result. The remaining contract questions
are therefore important before proposing this for merging:

1. Should errors during clear/unmap be prevented or completed inside
   the backend before the PTE walker can propagate failures?
2. Is there a current map/unmap split or successor series that this
   work should be based on?

On the native base above, isolated models using extracted functions
passed 5 PTE, 17 range/finalization and 2 SDMA ownership scenarios,
including baseline failure and deliberately broken controls, with no
ASan/UBSan reports. GCC 13.3.0 compiled amdgpu_vm.o, amdgpu_vm_pt.o and
amdgpu_vm_sdma.o with CONFIG_DRM_AMDGPU=3Dm. These are modeled errors and
object builds, not live kernel fault injection or hardware validation.
There is no claim that this resolves the original GPU queue stalls.

For background, the earlier vendor-tree PR is [4]. Its four commits
are not the proposed native submission, and the independent CPU fence
scan optimization is outside this discussion.

[1] https://www.mail-archive.com/dri-devel@lists.freedesktop.org/msg635900.=
html
[2] https://www.mail-archive.com/dri-devel@lists.freedesktop.org/msg635904.=
html
[3] https://www.mail-archive.com/dri-devel@lists.freedesktop.org/msg638593.=
html
[4] https://github.com/ROCm/amdgpu/pull/243

Signed-off-by: zihaomu <zmu@amd.com>
---
Illustrative error-propagation diff only; cleanup prerequisites and
agreement on the unmap failure contract are still required.

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_vm_pt.c
index c73eb416c0e2..d9cfced93081 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
@@ -701,12 +701,12 @@ static void amdgpu_vm_pte_update_noretry_flags(struct=
 amdgpu_device *adev,
  *
  * Make sure to set the right flags for the PTEs at the desired level.
  */
-static void amdgpu_vm_pte_update_flags(struct amdgpu_vm_update_params *par=
ams,
-				       struct amdgpu_bo_vm *pt,
-				       unsigned int level,
-				       uint64_t pe, uint64_t addr,
-				       unsigned int count, uint32_t incr,
-				       uint64_t flags)
+static int amdgpu_vm_pte_update_flags(struct amdgpu_vm_update_params *para=
ms,
+				      struct amdgpu_bo_vm *pt,
+				      unsigned int level,
+				      u64 pe, u64 addr,
+				      unsigned int count, u32 incr,
+				      u64 flags)
 {
 	struct amdgpu_device *adev =3D params->adev;
=20
@@ -735,8 +735,8 @@ static void amdgpu_vm_pte_update_flags(struct amdgpu_vm=
_update_params *params,
 	if (level =3D=3D AMDGPU_VM_PTB)
 		amdgpu_vm_pte_update_noretry_flags(adev, &flags);
=20
-	params->vm->update_funcs->update(params, pt, pe, addr, count, incr,
-					 flags);
+	return params->vm->update_funcs->update(params, pt, pe, addr, count, incr=
,
+					      flags);
 }
=20
 /**
@@ -812,7 +812,7 @@ static void amdgpu_vm_pte_fragment(struct amdgpu_vm_upd=
ate_params *params,
  * Update the page tables in the range @start - @end.
  *
  * Returns:
- * 0 for success, -EINVAL for failure.
+ * 0 for success, negative errno for failure.
  */
 int amdgpu_vm_ptes_update(struct amdgpu_vm_update_params *params,
 			  uint64_t start, uint64_t end,
@@ -921,9 +921,11 @@ int amdgpu_vm_ptes_update(struct amdgpu_vm_update_para=
ms *params,
 			trace_amdgpu_vm_update_ptes(params, frag_start, upd_end,
 						    min(nptes, 32u), dst, incr,
 						    upd_flags);
-			amdgpu_vm_pte_update_flags(params, to_amdgpu_bo_vm(pt),
-						   cursor.level, pe_start, dst,
-						   nptes, incr, upd_flags);
+			r =3D amdgpu_vm_pte_update_flags(params, to_amdgpu_bo_vm(pt),
+						       cursor.level, pe_start, dst,
+						       nptes, incr, upd_flags);
+			if (r)
+				return r;
=20
 			pe_start +=3D nptes * 8;
 			dst +=3D nptes * incr;
--=20
2.43.0

