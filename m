Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2092606A320
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2026 05:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=LCmqCK5r
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1448010E0C4;
	Wed, 11 Nov 2026 05:39:12 +0000 (UTC)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013016.outbound.protection.outlook.com
 [40.93.201.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA24D10E0C4
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2026 05:39:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vUzebS5ELHxy/DXCaNoDCM4VeViKyVPfwSFwN0v2SHLyPK5qn4nHGtdQAryD+kRxqj/gZWsz3X/3PueODOla3qgmHXiFBmNankdYWssMllRlyPPYWf2hWwp0Dfewkeu3v9VI9qpFV+kEaDNyG3DOGAzMza2j1eqcCYWcH2zJO0EyY+Q61WtpX7ZkeI+JtEehJrpsurrUjzu4ajHNQIyHdJgaI2v0RWqePSav3TMlQ0K1fI/PGQfYftGZc/KfiDlnd1lVVsh0cSy3CI9WqzL3FNO7hPIzBD94KM/wybkCggHfHUKJR4l4DDMQdQ3Xc9j+QIYWcXC0EsNjUvkvVchIHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RvQQENgGfHgtUYDwfvmUVAzYd9sy8/7vbbwXwnUeSz0=;
 b=WUxIIV0aCzN7AqvlTyZoBuKdK4tpua2X0RmcKExBaFk1vW32JyiCZABMNTliunmv04ZDMuIDrG5jRJC0laltyXk26gJrmBahIpMkQ1VFIMuGWrHYcCQ38xoz0/S+/xgU5GioX44RQvtl53Tkh+YhU5a2pEjAEsQGIXp20GH/yKQ7kv3GXAbNOc8ORgG1K6XJObFqrHPeHkP27+ym5YwMoZXNW0KAZv3hgUqvZD70lzWyb/lPDY1usYFap29Ogadxl2arNnQW/h4i0qyJO9LVA/9Y9SXyc7G6VhxBkphPk4TEqIVX4Sl03NroySuzdTrL9r/4d2RJqIDYrsk8lbsmEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RvQQENgGfHgtUYDwfvmUVAzYd9sy8/7vbbwXwnUeSz0=;
 b=LCmqCK5rpJEhQkkSuImbQ1Pg1ddxt4HRke6yLfck4m65B8NF1gacq1kXcWxlctx470WlYplAuacWD3bVcDFrX4Dv7Rhmd0TYIeqT3y5iqk/CRBeMV+YzFNQKPoK0fWjUiurX/AizSgv5/h+nDwuuFJZGOm6RTy4ysTrytnkVGII=
Received: from MW3PR12MB4572.namprd12.prod.outlook.com (2603:10b6:303:5e::7)
 by LVUPR12MB999183.namprd12.prod.outlook.com (2603:10b6:408:3a3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 05:39:01 +0000
Received: from MW3PR12MB4572.namprd12.prod.outlook.com
 ([fe80::79cb:c567:1825:51fc]) by MW3PR12MB4572.namprd12.prod.outlook.com
 ([fe80::79cb:c567:1825:51fc%6]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 05:39:01 +0000
From: "Mu, Zihao" <Zihao.Mu@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, Thadeu Lima de Souza
 Cascardo <cascardo@igalia.com>
Subject: [RFC PATCH] drm/amdgpu: make CPU page-table update waits
 uninterruptible
Thread-Topic: [RFC PATCH] drm/amdgpu: make CPU page-table update waits
 uninterruptible
Thread-Index: AQHdcZ70VkrB7G76NkyuRWTd2Dh6fA==
Date: Wed, 11 Nov 2026 05:39:01 +0000
Message-ID: <MW3PR12MB4572A08ADA8CB7BA9F83AF519E712@MW3PR12MB4572.namprd12.prod.outlook.com>
References: <MW3PR12MB4572FABB93F6676FDBA1D2479E722@MW3PR12MB4572.namprd12.prod.outlook.com>
 <4edd67f7-381a-4446-9509-552739c8f016@amd.com>
In-Reply-To: <4edd67f7-381a-4446-9509-552739c8f016@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW3PR12MB4572:EE_|LVUPR12MB999183:EE_
x-ms-office365-filtering-correlation-id: 95f31a5c-04b0-4d10-020d-08df3fb616f5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|38070700021|10067099003|5023799004|11063799006|4143699003|56012099006|261022105027099003|261022075727099003|261021121427099003|261026121527099003|261021123027099003|261026140227099003|261028144727099003|261102123227099003|261009223027099003|22082099003|18002099003;
x-microsoft-antispam-message-info: WxYm3shAOVhFOjPSM73botHW9xCX8RZUntYa6P0Fq0OuaSprjnKKOMDcpZ0t3UMx+U8xi4iqjctxpEgXf7PUHlDc9Y9oQEAwFZqM4WGlCtZKJ7UVJzB8CQDycw1+dnPiY1UYN5qpWPNZu6sxUf+sU/0u3dzwRy+2PTgRFLuOps4cdvg7JGrE2Jxh/RM6rP6ZLDUytc2Qq2Fs6mvU3FpWYwILQTql3Hfo/+HDGWZsa/q995/xBCVCosshvf/gbbxqKxbABo9QKDfPz4AZ4txUAXvbgWcEl8sydQW0NsUJQg0Bty8aR8KLN4ONx3S/NLL8z42vJI9RUqL0jok9PsyDn2vhPa+32+8ZyH68w0+3hteCFLFQ2AOgbSrvgs5nME0iIALy639/baJX/HOwJMNen6Lx2LbqzNCoVq7gpRlqFy7f5wyjUiUWK1BPtibR1KHxjG8/pvn1yHOHAFEDsGJbl1IIZeke/NCkcfsyZFjv3HBpRdlldJaE3vpSNCfGgD817M/qmI1ydM9VRq7vMICr/hkZxcdPmA6x1WN4g+ILjSlEoDv9uNf89S9IHUgtnMfNMxJDh1MmwWGQGB0teBzEdKbctAS3xpm9cYd2SzxxigyGGv41LiDzS2AHnFttR0uz9lKiGwpSzcoMIospnoov11hxiUNQY+N/RTS/9cGV5UAusGESzVP0RoWjzISfA0YB
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR12MB4572.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(38070700021)(10067099003)(5023799004)(11063799006)(4143699003)(56012099006)(261022105027099003)(261022075727099003)(261021121427099003)(261026121527099003)(261021123027099003)(261026140227099003)(261028144727099003)(261102123227099003)(261009223027099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Ec2Aw8+gQJNOnZMciaUtmlWR7TYtmmf/lbaJcmwIm2S3kFJOgUxBxCIijOYI?=
 =?us-ascii?Q?/1tCIqcvbLUr96wdqFFulCVfwRp2mSRdlT6an+qnQI91j102E6S1Gg3O1Qnt?=
 =?us-ascii?Q?FHh4tp21PFUMGGja/meEe3B0B1WJkFeG/l2qAnGzvD8V99YwXq/Gt0o5hcrF?=
 =?us-ascii?Q?UfxXbkvZnHIm1vwVLfkQvZQoKp2v65cxmfokDYdPALKHkLfpVxDh9cC25GNS?=
 =?us-ascii?Q?/I8gLfU3FcB6DTbVh3QoqEutvbiTTroAdrYsC8jOhHptEFcA3AvLxRREgRbt?=
 =?us-ascii?Q?eZ2FEfNNyMqXWbxylZfCs+lKSfZYwk8nTzVIMWFevYECov7ZZvvWovqFp1ml?=
 =?us-ascii?Q?etzrBbUoZrIX7cYfZ1sTM4M42ABk7pr2KO0A4EGmDYcTX6mc0PnmyQ/uIpBH?=
 =?us-ascii?Q?d8dDmqVHcvUhHWR+ILbBQP1OgkxrMEXfpOx936uWHpVhu60mbqGgqQqBc620?=
 =?us-ascii?Q?+zRkM1KsdSXOssyjosXOlQW92eLz9Ej6R5CzVcfeYsOhg5eS6tTi5TmXGpO5?=
 =?us-ascii?Q?+oOBo7Sj+TvQyvNup/jSxpWLbLd9y9x27ErT3oMBPxn92c//SB4TrDkQNSlj?=
 =?us-ascii?Q?s420bCAm8mDwXWbVEv6yhSlgHcT5cmuWwSauZuYWQkX7ZoHtAbjsMNi7RRzm?=
 =?us-ascii?Q?5wyfcx4i/+dJ18dO8kNrQqfJU1s2NhkD6yK9hE56TNAm/kE6kpVe5B6DJBqK?=
 =?us-ascii?Q?uHCP07eQh28UosR3ylVxC0cUiGZCNu5mYBFSMucL2X9+azTKLlKGm2EeoiI9?=
 =?us-ascii?Q?j+mpKcAj1jcSEpBHhb5hMOfx0XDAw9WEGzBZyGHFIjR4YBXACAgpTkMhvjd3?=
 =?us-ascii?Q?QBv10ZrBTmLS0bBmSJzeg8GDdauAX2IITHbNTmh8fGNg4hkNcSJnVGYM5u0y?=
 =?us-ascii?Q?J41nlLrWjSB+BvuAWz+QeWIvItQJ6N7IXQPI70RAPJWc1BWTrbwa5bzZPMbd?=
 =?us-ascii?Q?uMMjn4chnPn9b/icEWNWDJRHPuUsINeF6jlGMqTXcH6PVihS4paqAN/64LOv?=
 =?us-ascii?Q?nGkccVS9FFbjHW/Wpa3yDKxUpbkv3LhQ+J+ZsIj6y4J5ab9dhVEG4G1KxB/s?=
 =?us-ascii?Q?AJmgNXhTMg9nkRISFOXnWJsfhdwB8ieHWBAyJhUxuz1Au+OLzdzEyFq93/NQ?=
 =?us-ascii?Q?x1f8K4RS0RbhAvZOA58eOG9Hs3VQmQXYgQ3lwbF+RWgX139iQBKYvIEsWTMg?=
 =?us-ascii?Q?9OJmAh/VWSyX3euuZVo4YYt1lcW/OqYhSAU1Fmu3MFwSz6YL9KsFXueQXMNb?=
 =?us-ascii?Q?bNb8MGwiySXh5MFo6VzmxYoP/NNxiFpsgdm/xYsuw4WfQme53OPKh4RD6WWG?=
 =?us-ascii?Q?PAnOBvkGoPbVtakobmBDeMNVAG7DpdXuWKttQtbJ6kJBJpHFEbx1WN89SDQn?=
 =?us-ascii?Q?J9Z67U682hOXLYwn3ZrkzskYRoKXGL+Ffo+PfbsP3VG6C1T1s38NCTaxkdPI?=
 =?us-ascii?Q?9BenbA/m+Je3ut8UiCfJMdh/m1Byv/IjHXLo4kWokMLHj0Gl4JKdiMhUADVP?=
 =?us-ascii?Q?8OWeORGpsSVKyo4t/b9v1EHVZ7hkR3nh/um+n7kiajOE+PKgEMUj0MssaSnZ?=
 =?us-ascii?Q?SnEfSUhB2tTACWaFpdgFIC4M4hN6/oRZXpvCwphOxDkJKyJTd14sJX9KQjwV?=
 =?us-ascii?Q?RREqA0DQzCmIgHdds5R15pO2sN0krubitSNMYDnmIiS4KHqJn4RCRLMGYS+1?=
 =?us-ascii?Q?eW+CZoOW2+mDRKV5Kl1COVp2HGInP03WZjCfoekVo+5Kuou4?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4572.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95f31a5c-04b0-4d10-020d-08df3fb616f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2026 05:39:01.0838 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dwcXfWAyNAlNn9Vj3ML/kIB3sIDXIoiqXmmQtqI5OeFpfvVRe3v+di7d80dV00sZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVUPR12MB999183
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

From: zihaomu <zmu@amd.com>

The CPU update callback waits for KERNEL fences before writing a batch
of page-table entries. A pending signal can interrupt that wait and
return -ERESTARTSYS without writing the entries. The PTE walker ignores
the callback's result and advances past that batch.

Page-table updates must complete instead of abandoning writes because
of a signal. Make the dependency wait uninterruptible and remove the
interruption error path from the CPU update callback. The dependencies
are still waited on before any entry is written.

Keep the shared update callback type, the preparation phase, and the
SDMA backend unchanged. The CPU callback still returns zero through the
existing interface.

Link: https://lore.kernel.org/r/4edd67f7-381a-4446-9509-552739c8f016@amd.co=
m
Signed-off-by: zihaomu <zmu@amd.com>
---
Hi Christian,

> Yeah we need to remove those error codes. PTE updates generally can't fai=
l.

Thanks for clarifying. I have replaced the propagation proposal with
this focused first step for the CPU update callback. It waits for the
KERNEL dependencies without allowing a signal to abandon the PTE writes.

This is based on drm-amdgpu-next at a6836fcbb5b2. The previous walker
error-propagation diff and its cleanup prerequisites are not included.

This is not a complete conversion of all VM operations to a no-fail
interface. The CPU preparation wait remains interruptible before the
update phase. The shared callback type and SDMA backend are unchanged;
SDMA dependency registration and replacement-job allocations can still
fail. I have not hidden those failures behind a void callback or added
an unbounded allocation retry loop.

For the remaining SDMA work, is there a reserved-resource or map/unmap
split series I should build on? Job, scheduler-fence and IB allocations
need a forward-progress design before the remaining errors can be
removed safely.

Validation of this patch:
- 28 modeled dependency scenarios and 384 parameter combinations, using
  the native CPU update and reservation traversal function bodies with
  simulated fence/storage primitives. Both the original omitted-write
  behavior and a deliberately broken swallow-the-error control were
  detected. ASan/UBSan reported no errors.
- amdgpu_vm_cpu.o compiled with GCC 13.3.0 and CONFIG_DRM_AMDGPU=3Dm in a
  fresh private build directory. Strict checkpatch: 0 errors/warnings/check=
s.

The PTE write/flags/commit code is unchanged. This has not been linked
into a full module or loaded on hardware, and it does not establish a
fix for the original multi-second queue stalls. The independent CPU
fence-scan performance proposal is not included here.

Regards,
Zihao

 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_vm_cpu.c
index d03b9bbe20c..dc1cebbc0d9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
@@ -78,12 +78,10 @@ static int amdgpu_vm_cpu_update(struct amdgpu_vm_update=
_params *p,
 {
 	unsigned int i;
 	uint64_t value;
-	long r;
=20
-	r =3D dma_resv_wait_timeout(vmbo->bo.tbo.base.resv, DMA_RESV_USAGE_KERNEL=
,
-				  true, MAX_SCHEDULE_TIMEOUT);
-	if (r < 0)
-		return r;
+	/* Page-table updates must not skip writes because of a signal. */
+	dma_resv_wait_timeout(vmbo->bo.tbo.base.resv, DMA_RESV_USAGE_KERNEL,
+			      false, MAX_SCHEDULE_TIMEOUT);
=20
 	pe +=3D (unsigned long)amdgpu_bo_kptr(&vmbo->bo);
=20

base-commit: a6836fcbb5b22968019256025321d655b78bc49c
--=20
2.43.0

