Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2096AFF8867
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Apr 2026 03:17:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BDE3110EA12;
	Tue, 28 Apr 2026 03:17:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bbKnmemh";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011004.outbound.protection.outlook.com
 [40.93.194.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6ED2C10EA12
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Apr 2026 03:17:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y2iszaiS5S1veFCnNlk1ZSdu04hGGuzXeQa/aQLkxaKb3rpZX+pYGhs249M1qEi6t57XMWqd9TCFSM74lpl+oFbJvsQ9+pThvkeXjjHEE0H9p4VJkkwX0VqnL/CK/IEjNG5W2x8gTISstpsaZZtHOpB8M8w9eonzhQfUx3rMQ/Tb5csCRO/O2mRCKeoHkUxqvI0R8Md0HiCeUUU/WILC1lw7dJuTCc6FyjPPUecaDZ76Qz9tTfzWtGxzZkrq5S72CZ0SgfB/4KLSqnvGpxW51oodFahL1BvqvTIsqirTnH8fvQpQpuSW6+WrzyFNg+855Qvj4h2LpmdL3IspnwPREw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1ySuLUAWV4CUBJ0UyW9DbNfQt9giGzj7Mk+A17AFt9U=;
 b=j9rYj60s0fFiaF1MJoDt0Hp4Nha29HH/p7D1+/OOGjeP1CayQMDrqkbb04VeE/1NhTU4PjgWVY9cY1MfKcX38XKuNQYkit+az2hCx9qyRAd4owY/nqlwtH7IzL2B2CR5JNgPOpQeF7zg+fw6t28UmqwHsQQgSDyrNcCBn191qh0VDYSvVXigNoN/wn+J0T6y4pj0B5GG2BApkvwWLrI8fXBDpY9VVhjQHtI8G2BWahL0bP6mJrW4GvLPHyVEEMDoU+yAIJ3ZiLkiLXTLvQRPig+2Zi0N/N/wuWN6596JYirX08STuScqV6thUzZ3oy2JWKdDanjHzI71G+O1o939Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ySuLUAWV4CUBJ0UyW9DbNfQt9giGzj7Mk+A17AFt9U=;
 b=bbKnmemh/5PDTKH5nVEWezadFE+a/SIWmQPVS4vSQCQ4n04rUa6c5X9T6RDW39RVuiuEJ61Gag8jj6x4aw9/b3wr/i1lysS6xFy48qAP3655pUsTFx9LWBZAuv9XSZoMLSrCLEnO/CKILj8+5w8a9QbnuMZ8lvXcFIUCdstzyp8=
Received: from BY5PR12MB4179.namprd12.prod.outlook.com (2603:10b6:a03:211::8)
 by SN7PR12MB7201.namprd12.prod.outlook.com (2603:10b6:806:2a8::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.16; Tue, 28 Apr
 2026 03:17:18 +0000
Received: from BY5PR12MB4179.namprd12.prod.outlook.com
 ([fe80::2036:e8b:9b3:f325]) by BY5PR12MB4179.namprd12.prod.outlook.com
 ([fe80::2036:e8b:9b3:f325%6]) with mapi id 15.20.9870.016; Tue, 28 Apr 2026
 03:17:18 +0000
From: "Ma, Bing" <Bing.Ma@amd.com>
To: "Zhu, James" <James.Zhu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Francis, David" <David.Francis@amd.com>
CC: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "Liu, Jenny (Jing)"
 <Jenny-Jing.Liu@amd.com>
Subject: RE: [PATCH v2 12/17] drm/amdgpu: add profiler/spm operation
 AMDGPU_SPM_OP_RELEASE
Thread-Topic: [PATCH v2 12/17] drm/amdgpu: add profiler/spm operation
 AMDGPU_SPM_OP_RELEASE
Thread-Index: AQHcu9QXlSJsKXy9/E2iKcJb7ZQeirX0A1vg
Date: Tue, 28 Apr 2026 03:17:18 +0000
Message-ID: <BY5PR12MB41790B850C5C9364975BF0A4FD372@BY5PR12MB4179.namprd12.prod.outlook.com>
References: <20260324212030.822932-1-James.Zhu@amd.com>
 <20260324212030.822932-13-James.Zhu@amd.com>
In-Reply-To: <20260324212030.822932-13-James.Zhu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-04-28T03:17:13.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR12MB4179:EE_|SN7PR12MB7201:EE_
x-ms-office365-filtering-correlation-id: fdf82dfc-213c-4b5a-08ec-08dea4d4a7c2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|18002099003|22082099003|56012099003|38070700021;
x-microsoft-antispam-message-info: 0WAFWdqY9pzZx8zz0CCIEj45UePgl4LV1+OySUSN6h9MW4+Gv6gRds5JBGm3+Wb2k5zNwzKoaKISwO2KJlwtnguCCke5rvb9BaUs+FXhgRy8SzsI1vN2TcXzwm20kke+Vh3nhLHXADIWHsS7UPP3OGYVXJqhJWKnxOZ5/gvb5bBuq4xEQwRti1eD64TaZjkvwf1yGzD+RO2MtH5xwfJYCt3jTk2BygcUFtxsLeY9i+H4xmc3Sj3sQMHYgc5oYXhs8W1+SF90fsJ0SnQ/a4JJecx5uf/YuTC28ocNTbaN/TyO5/egSGjhDq3BCZaYQSQqiRdHy86aHh3jiRN2ttckuFmkvwiJsmdv2ret9nfGx/E8GDarD7SWSn7MVPdUCYsUEPZfoRuIm3EG4WnxbMYB2c3gbZubAgM7nzG6vjkjM8r2eA0RklkThsuqvQCmI+WnEkjbZai5ENGrYHbGmJuvmCL1woK6Zo+Ur8T1p5IqK/r0/nAj0cxWqIFVAVjw4a3VZy8rLd5gfRwFCODshqZzW1RSjrzslbRSbR+jcuAhtgImPiFUtkub/ZsOBxvy1tfjRD6nWBzez2iFmoxP15UarWmnz3b71jqRCgvXJ/VuNVqJ7hkkZ/AuM1DrxlmYKBEOccq3ubh7UUDrqFsJERDK2SYLq3YbLTTUBoPTuzjL7uZVMmfY7Xmh1u47ednrCo2mDbQ5mTeePCefdLQUZcceaoVEqJGeITX8L/S309l6LSUzdERBYvRvjnhyYl7V9g6iNec7Lj7KMUVik2TgpzO0+0t5n5zQ6TE2CjkYP5550XM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4179.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(22082099003)(56012099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rrnGQjfMyrvXGc3OCAxnqXEWj/YDViWPiMDEnD7o4Rz64sewkj2rBylS6Dis?=
 =?us-ascii?Q?wnts3fzh7K6DD61eYswnVDpBWJKZWP1e+c3c4z03tfpUQ0mpBP1Q+8kJniEh?=
 =?us-ascii?Q?p/s7IUQzwS1Y5VBD5IaF8Y3PCzhFdBe2RfU2DzLEPRHysn6RPsojsdqo+LOa?=
 =?us-ascii?Q?OdRcNkBUy7vqukk+MObQZBGCIsXucc8eYrzKdEchVIz7koaqN6OHOKXXV/n/?=
 =?us-ascii?Q?c1JBuyyU/T0fMX4/5yS4quk0H3mjDukbgwfv9aD/jF1i07r5NOHtwxi07/pL?=
 =?us-ascii?Q?3t/w6Lzx+M/LaV3vY+85o5J0dkZifFtQUEqnY2H19XlF04R6AXK5e80gUOU/?=
 =?us-ascii?Q?WxWRZYl6oLihk0u4UBmHjslWocUJco57AVBagXUCzRU/zgN4MO5IVDehl4/1?=
 =?us-ascii?Q?lVhLk8rlkQZhbePxYnNV6tehhyW9+z11mlsVjmwUK3/kaKJgsswlSmA7RTsW?=
 =?us-ascii?Q?JndfmIYKCI6uu5/qzrlKUG76N4bUIOsJutJurKLe5R3GLNU8f761snZHn7kA?=
 =?us-ascii?Q?KbN/xgpgwDDNL56kV50TFz6RZEyUrIbqu/5NTtSz6CeH02g9vJ1VY4ngO4qp?=
 =?us-ascii?Q?ezolNc9loN9gRF3MTlvIwQsXcJJ2By+hV1nxpdrdV7OATW91LrklrfM9zvD2?=
 =?us-ascii?Q?dogmk8Z9mxg74JdhBhZYHcNSwhPNnz68NrQVbi9NtB8c3PpW5lJHNplbJYeq?=
 =?us-ascii?Q?6GYCBFDXWHf47RdprU/xOAnww2HSmBsCB1z2hd1H2Wo9LIM38WwU7EfrhhOM?=
 =?us-ascii?Q?0AX79h8yzBd6nRrcNBG5NJYEz0Ph7eA8hwvtAryT196r/ERA1mY1FW2kzScQ?=
 =?us-ascii?Q?U+B0r1SU8cIFFddNNpFo79HCfuvfIydsoszONwUyKXaprx+oqg74Hxf7d1v3?=
 =?us-ascii?Q?0rHdH1mPiQ8ASez0QaXdtypXPsVm2ao29JD88DLyKstZBDze0OVJT4kUCI3I?=
 =?us-ascii?Q?KV2+1UCjyDJdMkCx1LGoXKok2CJLMYe0NQam8pBwpXmDu26bj4zL0/9JzNuu?=
 =?us-ascii?Q?YOkxie/W7SESWzWCN//6IjxwinVlprqpoXhuA2o5RHfLr5owX+iupnSP9lDr?=
 =?us-ascii?Q?F8xWX4P53HnDmPFW94USJLCJyW0mV8lbXzCiWhUThofeICXFa1b0MGu23zea?=
 =?us-ascii?Q?oi8RQzMbGCvR9GqMn7MfTferhFDFMLlMb3NrYskP3wN51J7uVXiC2Dwx9wcu?=
 =?us-ascii?Q?Vba5adTvRzzvuybXdpZakIS7eGKgVTl1d6aFSUvpb8fURqxGOPnBgJdXCm4D?=
 =?us-ascii?Q?iTLrhot3MshydjlbWLDhCpw2SbcFuhUy30GnonIwj8bsZWUr0pdm17IlPwG8?=
 =?us-ascii?Q?GhLEx9NeAPR2BWJ4ez7IEqIKP/3tawoT+q7vuOLAufd4okP0M24yaIXGfJZb?=
 =?us-ascii?Q?eiwpL81IvHNipaqdwbXZ523mRB2JFMpLiuUDKgFUzYpQ+PdSpA9RVqgGfUFg?=
 =?us-ascii?Q?OfrWcfcVzFtywOFTNlZCo936yj+D1mmxSifHkHHBu1VdUnMqWmJKlF8mu/Nz?=
 =?us-ascii?Q?OkKqDUqE/1U2vNtTxnwWYewEUbfj6GGGaZB/FF6++eEGsRwXT3SZc+6bR3iZ?=
 =?us-ascii?Q?sjMtjWI/LkFrUr/OtUI0w4hThu/U2rIuzMbKktMXRqm1IYlV0enVeLqAcl9g?=
 =?us-ascii?Q?IZqQRvwSLi0Xl6fsD09X1kjsu5xDJ5NRbQOrqnfweqP+MfJFRVwLIJZ7ImBy?=
 =?us-ascii?Q?t24Ud4wy8JV0f1HCQJ6U0p9Kn18nAQCCKdGPZOA6c+MdiN+t?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdf82dfc-213c-4b5a-08ec-08dea4d4a7c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2026 03:17:18.7642 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PxYVA35k05Lgn9dk+pHqTXpaTuCpIjuutNaovNmNGrn+dOYnsgJ80wbhCbs6zffglFs+b5aL8G5VGK3oETMMdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7201
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

AMD General

Reviewed-by: Bing Ma <Bing.Ma@amd.com>

-----Original Message-----
From: Zhu, James <James.Zhu@amd.com>
Sent: Tuesday, March 24, 2026 2:20 PM
To: amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@am=
d.com>; Ma, Bing <Bing.Ma@amd.com>; Francis, David <David.Francis@amd.com>
Cc: Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>; Liu, Jenny (Jing) <Jenny-Jing.=
Liu@amd.com>; Zhu, James <James.Zhu@amd.com>
Subject: [PATCH v2 12/17] drm/amdgpu: add profiler/spm operation AMDGPU_SPM=
_OP_RELEASE

to implement AMDGPU_SPM_OP_RELEASE, which stops the SPM hardware, drains th=
e work queue, unblocks any waiting SET_DEST_BUF callers, and frees all per-=
XCC ring buffer resources acquired by AMDGPU_SPM_OP_ACQUIRE.

_amdgpu_spm_release(spm_mgr, inst, filp):
  Per-XCC teardown helper. Skips silently if the ring buffer was never
  allocated (ring_size =3D=3D 0). Otherwise:
  - Calls amdgpu_rlc_spm_release() to stop the RLC hardware, revert
    the SPM VMID to 0xf, and free the reserved VMID on the GFX hub.
  - Calls amdgpu_bo_free_gtt_mem() to unpin, unmap, and drop the 4 MiB
    GTT ring buffer BO.
  - Under spm_irq_lock, zeroes the entire amdgpu_spm_base entry to
    prevent stale pointer access from any concurrent IRQ path.
  - Decrements spm_use_cnt.

amdgpu_spm_release(spm_mgr, filp):
  1. Takes the per-XCP prof_xcp_mgr->mutex to serialize against
     concurrent ACQUIRE or SET_DEST_BUF calls.
  2. Returns -EPERM if the caller's drm_file does not match
     spm_mgr->file, preventing one process from releasing another's
     SPM session.
  3. Returns -EINVAL if SPM was never acquired (spm_cntr =3D=3D NULL).
  4. For each XCC in AMDGPU_XCC_MASK(adev): clears is_spm_started
     under spm_irq_lock, then stops the hardware via
     amdgpu_rlc_spm_cntl(stop).
  5. Calls flush_work() to wait for any in-progress ring drain to
     complete before freeing buffers.
  6. Calls wake_up_all() on spm_buf_wq to unblock any thread sleeping
     in SET_DEST_BUF with a pending timeout.
  7. Calls _amdgpu_spm_release() for each XCC to free per-XCC resources.
  8. Calls amdgpu_vmid_free_reserved() to release the GFX hub VMID
     reservation on hub 0.
  9. Destroys spm_worker_mutex, frees spm_cntr, and sets spm_cntr =3D NULL
     under spm_irq_lock to prevent the IRQ handler from scheduling new
     work after the memory is freed.

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_spm.c | 56 +++++++++++++++++++++++--
 1 file changed, 53 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_spm.c
index 896a0fef576c..d4af195bbcd2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.c
@@ -150,14 +150,61 @@ static int amdgpu_spm_acquire(struct amdgpu_spm_mgr *=
spm_mgr, struct drm_file *f

 static void _amdgpu_spm_release(struct amdgpu_spm_mgr *spm_mgr, int inst, =
struct drm_file *filp)  {
-       /* TODO: */
+       struct amdgpu_device *adev =3D mgr_to_adev(spm_mgr, spm_mgr);
+       struct amdgpu_spm_base *spm =3D &(spm_mgr->spm_cntr->spm[inst]);
+       unsigned long flags;
+
+       if (!spm->ring_size)
+               return;
+       amdgpu_rlc_spm_release(adev, inst, drm_priv_to_vm(filp));
+       amdgpu_bo_free_gtt_mem(adev, &(spm->spm_obj));
+
+       spin_lock_irqsave(&spm_mgr->spm_irq_lock, flags);
+       memset(spm, 0, sizeof(*spm));
+       spin_unlock_irqrestore(&spm_mgr->spm_irq_lock, flags);

+       --spm_mgr->spm_cntr->spm_use_cnt;
 }

 static int amdgpu_spm_release(struct amdgpu_spm_mgr *spm_mgr, struct drm_f=
ile *filp)  {
-       /* TODO */
-       return 0;
+       struct amdgpu_device *adev =3D mgr_to_adev(spm_mgr, spm_mgr);
+       unsigned long flags;
+       int inst;
+       int ret =3D 0;
+
+       mutex_lock(&(to_prof_xcp_mgr(spm_mgr, spm_mgr)->mutex));
+       if (spm_mgr->file !=3D filp) {
+               ret =3D -EPERM;
+               goto out;
+       }
+       if (!spm_mgr->spm_cntr) {
+               ret =3D -EINVAL;
+               goto out;
+       }
+
+       for_each_inst(inst, AMDGPU_XCC_MASK(adev)) {
+               spin_lock_irqsave(&spm_mgr->spm_irq_lock, flags);
+               spm_mgr->spm_cntr->spm[inst].is_spm_started =3D false;
+               spin_unlock_irqrestore(&spm_mgr->spm_irq_lock, flags);
+               amdgpu_rlc_spm_cntl(adev, inst, 0);
+       }
+       flush_work(&spm_mgr->spm_work);
+       wake_up_all(&spm_mgr->spm_cntr->spm_buf_wq);
+
+       for_each_inst(inst, AMDGPU_XCC_MASK(adev))
+               _amdgpu_spm_release(spm_mgr, inst, filp);
+       amdgpu_vmid_free_reserved(adev, drm_priv_to_vm(filp),
+AMDGPU_GFXHUB(0));
+
+       mutex_destroy(&(spm_mgr->spm_cntr->spm_worker_mutex));
+       kfree(spm_mgr->spm_cntr);
+       spin_lock_irqsave(&spm_mgr->spm_irq_lock, flags);
+       spm_mgr->spm_cntr =3D NULL;
+       spin_unlock_irqrestore(&spm_mgr->spm_irq_lock, flags);
+
+out:
+       mutex_unlock(&(to_prof_xcp_mgr(spm_mgr, spm_mgr)->mutex));
+       return ret;
 }

 static int spm_update_dest_info(struct amdgpu_spm_mgr *spm_mgr, @@ -365,6 =
+412,9 @@ int amdgpu_spm_ioctl(struct drm_device *dev, void *data,
        case AMDGPU_SPM_OP_ACQUIRE:
                return amdgpu_spm_acquire(spm_mgr, filp);

+       case AMDGPU_SPM_OP_RELEASE:
+               return amdgpu_spm_release(spm_mgr, filp);
+
        case AMDGPU_SPM_OP_SET_DEST_BUF:
                return amdgpu_set_dest_buffer(spm_mgr, data);

--
2.34.1

