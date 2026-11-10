Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6FB7606A325
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Nov 2026 10:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=u8GWEAtX
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7638910EFA4;
	Tue, 10 Nov 2026 10:40:58 +0000 (UTC)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010056.outbound.protection.outlook.com [52.101.61.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E23F10EFA4
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Nov 2026 10:40:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I5vCjfEIrwdS8EprpybRX/aH/zY4FHLZj/nvdR8tkZA4iGa99pwly5EBB0ZNA3a2qINZBe6CFx8195feVB1NTY/8kxDy2aHddg/gu0oDgL77l2yCupJFsi0Vtu2FWecbB0CfoYtKBGhZE30MC44ZG/Ocqy9seRBukUo+asAokKs1q96NDK5vaqEnHF9syfqfAxpePSuha2x+WPoLGGz3+XZ6HFfhrr1ftHelFUsop+GvG86yvG/adfyr1p3A3t7aEVvSfAG+xJqVFU0BQXjaYrDvFUmFHZXhnMtGNEPIIfrH7KyaPtl8dYAHcsF1KM8foHvxCTtQihYUXNOrxTlVpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wz79o9wWhXdiNVlOc0HE69heYuiAiZtZVnpFecZf7qc=;
 b=j+iZKPkdDUjeQqCBzskm+92kz9VDCB5r0pHzlkvi9b8Cq61GXNgMH5eWKkgZXpafdc0TOCw98LSplOFg1buoQ+3zAJVHk9vFm5OmUfrEdaACyWOYjDSbMMdeOVyneGXHO0k7oTvbfwnPZoXFwHu8Vfk375Jg1QIdKTryyq/DXhPjE+amNbBH49hJ+PKYWp6G6yXCFJV0vlMWGGkFGSFa0nQCo+AqVXwwbBWEG/omYgYIFqHUL3f8H3hiy0cK8DyrelVFQumC7IFM5LmUdWxQLdIoWieSy98xZyJa1+6IqwFiHYzpJXaMThbgxICdW+4QzQhNgLVuNI1VQBYkVg0Dfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wz79o9wWhXdiNVlOc0HE69heYuiAiZtZVnpFecZf7qc=;
 b=u8GWEAtXYXaoBN/BeenVZEZ0ogPIhc5cebSgDg42Un9FPO0NSk1DmtXe05BapAUGwqi9D1XojWT+uiay7LdGVB1gxk2VrgejFmu+ODPUM6O0A3iGB21bijiCE87dvtLSxYod4GZkHj6XTtuLB1fJQnLAOi7WSJX1upaJXloq1Oc=
Received: from MW3PR12MB4572.namprd12.prod.outlook.com (2603:10b6:303:5e::7)
 by BN7PPF48E601ED5.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6ce) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Tue, 10 Nov
 2026 10:40:15 +0000
Received: from MW3PR12MB4572.namprd12.prod.outlook.com
 ([fe80::79cb:c567:1825:51fc]) by MW3PR12MB4572.namprd12.prod.outlook.com
 ([fe80::79cb:c567:1825:51fc%6]) with mapi id 15.21.0615.007; Tue, 10 Nov 2026
 10:40:15 +0000
From: "Mu, Zihao" <Zihao.Mu@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Zhang, Ning(Jason)" <Ning.Zhang2@amd.com>
Subject: [RFC PATCH] drm/amdgpu: avoid generic CPU VM waits without KERNEL
 fences
Thread-Topic: [RFC PATCH] drm/amdgpu: avoid generic CPU VM waits without
 KERNEL fences
Thread-Index: Ad1w+33C1/bTUuZbRTOohYPYUNXvbw==
Date: Tue, 10 Nov 2026 10:40:15 +0000
Message-ID: <MW3PR12MB45725A7F0AC045DB29F7CD649E722@MW3PR12MB4572.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW3PR12MB4572:EE_|BN7PPF48E601ED5:EE_
x-ms-office365-filtering-correlation-id: 5414448e-fb21-49db-6c5a-08df3f170183
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|38070700021|261026140227099003|261028144727099003|11063799006|56012099006|261022075727099003|261021121427099003|261022105027099003|261021123027099003|261009221227099003|261009220027099003|261009223327099003|261102123227099003|261009221727099003|261009223027099003|261026121527099003|10067099003|18002099003|6133799003;
x-microsoft-antispam-message-info: LH40KQw+a90d6LGVZ5A+XM/5ti6D8n2Y2TPZ7Xer9TAv4J+zVc9s0E0bfKwimGaLvbYG0b0HHQP25NRHfzWo371hklIce0EtEaHFkphBpsMvWhPfZ6wb/KfvfX5Bo53tIZo2VgMxufhiWyL+bofoM80UEvfgHiUCrn2clz3utQTYUtMv4A1Nwqt16agnEA9pnHKyX4TibXQT6hm3NW90GRESryEDiy/9cCvTiMqzVTHX4Dx2oUbn/aOYgXNQRc2GNeF3bbkuzJnpZ8SowemipkKa0Bh1Q0dduY0QTOSfMi5+tSkZnm0DZhEi0RY9EJpXwJkqA1vzNLGpO04FIsP3FoH+XcDgYVIAk+hI6iFPwQs8xUx2U75lnzaZK41c0DGiv/lkUmRzP9qyWmYLB9tSodQ7oNNlqNSJURKVNRgE50C3DuB2Wk6y6FTns9EILGf1CqO6rwetYSagnw/e9jFFbcl5NSRiutn9PBW0XhP5RwRcf7pcADqEYMdcfC3/yGab6axCWWkxUWTVG/IQ5T/YqbrPGOJHz9fnkYQRsHcO57ytc0qm8cUdpd/FQxCIPiday3PkJqeY7yXqe8ljoK+U0yOfJQOrRQecP6o7058sA/RNJHPlQfxdJaNDHBWZ2/ZSLb2tRy2jxLByM0pFO1odiBgVcdy9dUzm7fDlhKD4YwfUmvVraDZ1R/pH70VQALl3Jv6n1NJ3RZuvg+kFeLPqVTNtmG9MBlTfSo2bspeZZ4s=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR12MB4572.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(38070700021)(261026140227099003)(261028144727099003)(11063799006)(56012099006)(261022075727099003)(261021121427099003)(261022105027099003)(261021123027099003)(261009221227099003)(261009220027099003)(261009223327099003)(261102123227099003)(261009221727099003)(261009223027099003)(261026121527099003)(10067099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?h7+XoBjm1L5vMf9kIveAd2GJteqpqv5AQAUabVynH+jOhLNBMc6AL4VjRNk7?=
 =?us-ascii?Q?uJ2H3fwsRv+A9s2kWAJ/A/oeZ3VvuOeMG3Rfm9LuL+kh7/VFDdlFBLUk3W74?=
 =?us-ascii?Q?su+YtVgzJ2mJZjOLlKjv9ZAX4NhKl7ZX5zkRyUsdsgsRTPZn5e6DSQe+49v+?=
 =?us-ascii?Q?Xv5uRBpbq+rZeb793vMH8sI7bOgo/3yXDBxweKfy2imCe0hlmQsv348B4497?=
 =?us-ascii?Q?txuRBF5xcQ12/vtd71LFRBvFyONI8TY3GAyGZr0QwKu2SQXDUjBHjrKcE1Gc?=
 =?us-ascii?Q?Rm7KQE0XyhIxrrAyq65uM11t0JZyLQimAti5BHDha1cACOAD7me9R4uMR8l8?=
 =?us-ascii?Q?xyRR0c5+jRrqcH/yBdpbQ3TNSUgJjgDkmEVea9llVIoJlqpkUShzgXqkdgiU?=
 =?us-ascii?Q?sBNtDtJABZY1ECCwpXX03Et7dZx+mIsjzWukTib5xdyUFvu1v0nBiZ1OCRsC?=
 =?us-ascii?Q?ZroBGdJXMAtoL1FI9z0UA56vf7W0LysbCiUTiDUJKusR7uRY8bYB5oiHjGWZ?=
 =?us-ascii?Q?8T4kiOYmBbC/h05YMRwrWs1bvelcDECc38DKLZK5gJDcEtyGOALv3yD+ptVt?=
 =?us-ascii?Q?XmqHIzSuvLgyfsXKy90RKw+qFxiU0FYt5ZkVdTzxyShqh3TC83hO4xpLjPtd?=
 =?us-ascii?Q?ST/ExIVrtjw6B17FfusrTOjGeqtkpNpJNPdJ2V3qzWfO8UtqL+E9nO31oORw?=
 =?us-ascii?Q?DE0h2/VLlleZfD10/W8kR0iFKUSnozcBwmACh4PVuEBm3anfg+caBV1ojrH9?=
 =?us-ascii?Q?4DXedii1DhIG8iO8r8f6NX2dh4pU5qPx3FVMTlyu64vmJVxix2RVHeKy+H5Q?=
 =?us-ascii?Q?1I5REBLWj5cVjmR4NhTrw+Eo3h/8Gv1QtlLX4B0YySvdZ+BkAkG2HAswTWuC?=
 =?us-ascii?Q?s0RLmnZKnIUHq88VIxYaCCG5FoDypK/Ky6uYx+IOvAiIQ/I21kqk1XgESc5z?=
 =?us-ascii?Q?dbw/SqkUqx3sYPwdY8Xkt9IuXxIWEKH9wPADi5xHZ2U6uQIfcqBuPRakdVUQ?=
 =?us-ascii?Q?KgQWC8X+8wK/SjX6jKaumQeAibvK9896oiDgIZE3pQKYnCZb5mxeNXRklwnW?=
 =?us-ascii?Q?TXVyKxLbvG5Qib6XciMv0K05bemePZ4G4nyrQxx5f0cnFo1B1a3KGYxhdS2V?=
 =?us-ascii?Q?2OdNbw2Gv21o6XBBjiZoqWrjY/a2FRmH7MEYmOOaTxbcBe/sgZaX1C3PtEkU?=
 =?us-ascii?Q?sumQLuDwETqeX7UNVwTjQJtktlGhv6Q0uaFQ9DJ22S/6jZffNjTZozD06Q2j?=
 =?us-ascii?Q?tocaaKONjzWcwkFWVAcli/hGWyb3c3gOGtwgpV5dOpdC4NYJhZRr99/JhEvC?=
 =?us-ascii?Q?AWNM2WM9ONRFEBhkN+x4qDMHlSZ0IcfNk+hY+QrjPTaovZhMpp5ly66w1Vyj?=
 =?us-ascii?Q?SfW5LoJWsdyDdYHEoR+zsEgThUb5YLkvaMypCAgAPLevWC7VosGYGcqq6/FO?=
 =?us-ascii?Q?bGJ8yOG4wIG/tQpf9HsZ+m7PKpGikMLNLhbmkJsmFMYw6LYWnHLXZiOJukma?=
 =?us-ascii?Q?3hrcVAXQJWIGeeQQ1aSOHPjeAm2gVzS+jqpFRLHIk3NXWFC8nYETP2+bnE/2?=
 =?us-ascii?Q?jJbsj1mQ7Yz7o3xHkI3391sCBqxjuT9/AdlF4gmmV3R+9ugNIiam7sItJ+sf?=
 =?us-ascii?Q?swlSJNbX+4PEhu2YgVJ9O4aEC8eoV1ppDaLbg//h6Q/vjCy19erC2p76bdi+?=
 =?us-ascii?Q?7lkC20PMYeZPbaPSUcN+fETlH8g=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4572.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5414448e-fb21-49db-6c5a-08df3f170183
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2026 10:40:15.1120 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0EF8QkNjsj/1HLWZLHNMUk3xKzgPn81iucfNn6LSfreuOiJmJG8V7zt8X6CKdv01
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF48E601ED5
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

The CPU backend checks KERNEL dependencies before every PTE batch. The
generic reservation waiter uses an unlocked iterator, which takes and
drops fence references and polls their state before filtering by usage.
A reserved VM with only BOOKKEEP entries repeats this work for every
batch even though those entries are not dependencies of this query.

Page tables share the root reservation, which is held for updates with
unlocked=3Dfalse. Use the locked iterator to check whether any KERNEL
entry exists. If none exists, return the original waiter's positive
success value without acquiring temporary references or polling
unrelated fences.

Keep the full generic wait when any KERNEL entry exists, including an
already signaled one, and for unlocked updates. Check each batch afresh
so dependencies added between calls remain visible. The PTE write,
flags and commit code is unchanged.

This adds a locked lookup before the generic wait when KERNEL entries
are present. It targets the no-KERNEL case rather than reducing the
number of batches or caching dependency checks.

Signed-off-by: zihaomu <zmu@amd.com>
---
RFC: this is an independent performance proposal, based on
drm-amdgpu-next 5349075eac146ae0511d8929fc24451e4d9a4b7e.

I would appreciate feedback on whether the no-KERNEL case justifies
the extra locked lookup on calls that do contain KERNEL entries, and
whether this optimization belongs here or in the reservation helper.

The locked iterator is used only when unlocked=3Dfalse and the shared
root reservation is held. The full waiter is retained for every other
case, including a signaled KERNEL entry. Each batch checks the current
list again, so no result is cached across PTE batches.

Offline operation counts illustrate both sides of the tradeoff:
- 64 batches, one BOOKKEEP entry: list reads remain 64; fence get,
  put and poll operations each fall from 64 to 0.
- 64 batches, four mixed entries including a signaled KERNEL entry:
  list reads rise from 256 to 512; the original 256 get/put/poll
  operations are retained.
These are model operation counts, not a measured speedup. The fast
path still scans entries and does not reduce the number of batches.

Local validation using functions extracted from this native tree:
- 28 deterministic scenarios.
- 128000 bounded modeled schedules / 256000 actual-function runs,
  40 checks adding dependencies between batches, and two deliberately
  broken controls that were detected. ASan/UBSan reported no errors.
- amdgpu_vm_cpu.o compiled with GCC 13 and CONFIG_DRM_AMDGPU=3Dm in an
  isolated build directory. Strict checkpatch: 0 errors/warnings/checks.

This has not been linked into a full module, loaded, or tested in a
live candidate-driver A/B. The models do not establish real kernel
concurrency correctness or wall-clock benefit. There is no claim that
this eliminates the original multi-second GPU queue stalls.

The implementation is available on my fork (no GitHub PR opened):
https://github.com/zihaomu/amdgpu/tree/perf/vm-cpu-no-kernel-fastpath
It is separate from the PTE backend error-propagation RFC.

 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_vm_cpu.c
index d03b9bbe2..5712ec48a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
@@ -58,6 +58,28 @@ static int amdgpu_vm_cpu_prepare(struct amdgpu_vm_update=
_params *p,
 	return amdgpu_sync_wait(sync, true);
 }
=20
+static long amdgpu_vm_cpu_wait(struct amdgpu_vm_update_params *p,
+			       struct amdgpu_bo_vm *vmbo)
+{
+	struct dma_resv *resv =3D vmbo->bo.tbo.base.resv;
+	struct dma_resv_iter cursor;
+
+	if (!p->unlocked) {
+		/*
+		 * Page tables share the locked root reservation. The locked
+		 * iterator borrows its references and filters by usage without
+		 * polling unrelated fences. Check each batch afresh, since the
+		 * owner may add new dependencies between calls.
+		 */
+		dma_resv_iter_begin(&cursor, resv, DMA_RESV_USAGE_KERNEL);
+		if (!dma_resv_iter_first(&cursor))
+			return MAX_SCHEDULE_TIMEOUT;
+	}
+
+	return dma_resv_wait_timeout(resv, DMA_RESV_USAGE_KERNEL,
+				     true, MAX_SCHEDULE_TIMEOUT);
+}
+
 /**
  * amdgpu_vm_cpu_update - helper to update page tables via CPU
  *
@@ -80,8 +102,7 @@ static int amdgpu_vm_cpu_update(struct amdgpu_vm_update_=
params *p,
 	uint64_t value;
 	long r;
=20
-	r =3D dma_resv_wait_timeout(vmbo->bo.tbo.base.resv, DMA_RESV_USAGE_KERNEL=
,
-				  true, MAX_SCHEDULE_TIMEOUT);
+	r =3D amdgpu_vm_cpu_wait(p, vmbo);
 	if (r < 0)
 		return r;
=20
--=20
2.43.0
