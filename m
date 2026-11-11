Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3B7606A31C
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2026 11:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=XdQYUPoI
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9BE8F10FB67;
	Wed, 11 Nov 2026 11:55:46 +0000 (UTC)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012034.outbound.protection.outlook.com [52.101.43.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4589D10FB67
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2026 11:55:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HuoFFgzqWEdhE2NPtd28jqk15JXBMUo/X29yr9CM3ZhdXN+jWQs5z5ChN74/CfWbcVYdUV5Z+KWc8COShkpNFR8b/Od0CkCgVEOLEEtjHYb86HnDYxXwrGqpfFflVcGkdOpdIJE9trXidkDRYeeS1TEj1uoHgpvNU57uMrDJKHat27DpJ+FkqqN7uCWOYsAtQvMtC+a0w9LWwLiEE3FodKDciEvE3RIoR2nPNaICZlr5O4mmzk/Aq5ZWgkYijrN3KuzQFtgBVXiLzK9HRmzcJ7u7+k8fOxTGiQa1mISKNKku//JQEddJJKphan/ehAa4ssfDXUa4AceVsoCglwrcRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x6KCSdRjL4XcJ47NJc/XgMqxqJ0DfiCUrguU7pCDSpQ=;
 b=KmBLwFxWLYKACtiZ/56v03TsgcJuW6nO4C8OrYl9ovvsEHERw5gfpaSxZ3/w9SMM5bQhbWESBatDtn4PKUndVkuhEf//vq7GqvgGjC8gfD1Vq7g/vP0WyOIO95rcCIFgVsqy4yucjPmLPgpN2rbCC4cIe0/r1XdMJSUCFRj6aQYFaAn8p4pr0O5tJxKzaTU6TVuSQR4WLoVOJRIScMmrlgdYr5szSkmDwylclszIZFXMkI1jp5dnYy59n7dJtMqlVCgK+HMygG4yQ/+QBIr7CuOwNm2LybfwqshmL9dVHYWG4FegS/kYtRwNRQopnijCTz5X06bglBl6B4cEPdo5IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x6KCSdRjL4XcJ47NJc/XgMqxqJ0DfiCUrguU7pCDSpQ=;
 b=XdQYUPoIl39ah7VIvL8HGWtCNK6K+Fr8nCG3hbR+wL/xKvzA7SnNL2IFXyo5m18Yd/pUaHxaH/oyU68J5fHc3igDOgHGB77asOFJG4clW2GyE2b02gO9mKPOghlhmJMdazjNHgFqoSM67DMD3jrTJJPa1hsOzBuQhYNiuMl4OfA=
Received: from MW3PR12MB4572.namprd12.prod.outlook.com (2603:10b6:303:5e::7)
 by LV1PR12MB999279.namprd12.prod.outlook.com (2603:10b6:408:3f7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Wed, 11 Nov
 2026 11:55:36 +0000
Received: from MW3PR12MB4572.namprd12.prod.outlook.com
 ([fe80::79cb:c567:1825:51fc]) by MW3PR12MB4572.namprd12.prod.outlook.com
 ([fe80::79cb:c567:1825:51fc%6]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 11:55:36 +0000
From: "Mu, Zihao" <Zihao.Mu@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, Thadeu Lima de Souza
 Cascardo <cascardo@igalia.com>
Subject: [RFC PATCH v2 0/6] drm/amdgpu: prepare updates across page-table
 allocation
Thread-Topic: [RFC PATCH v2 0/6] drm/amdgpu: prepare updates across page-table
 allocation
Thread-Index: AQHdcdOQy0slTmsHNUq2B6pm8TN2vw==
Date: Wed, 11 Nov 2026 11:55:36 +0000
Message-ID: <MW3PR12MB4572FFD141B046B9CE8F5FE49E712@MW3PR12MB4572.namprd12.prod.outlook.com>
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
x-ms-office365-filtering-correlation-id: cfbebbe9-90e0-40ca-b093-08df3feab2e0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|18002099003|22082099003|6133799003|10067099003|3023799007|38070700021|4143699003|261102123227099003|11063799006|261009223027099003|261022105027099003|261022075727099003|261021121427099003|261021123027099003|261026140227099003|261026121527099003|56012099006|261028144727099003;
x-microsoft-antispam-message-info: 9eojjjm84Zk57dQ1tm7lfGhYm0y0GkDSG8VTCw+8Vocn0pODgz1VI8U2AqrAdvWUTDH2wf/rHnthpYGJiJpYsTeWR2q54DIzji2Qw6SMDKujeKkPYgKiACD6/FMd6UvtrEtY3d+Kk69UmdHLYtrdlHbypR7BNjGkqaZ6ZEY4mvfB94Hr3y+N8F9xoqp+XGxdux1gHpm2DSQS8IQs4rJSo5THcjkMTcqFuATxdTj/so0AQCmn33E1Tj4Gi5oantGZBuwULxilzF0elZcxEcAUrzK0LCYj3hf1TNp+by3fQg9OOysjF/FqiproLBLE7Ap9Jw3wFJvNCw4oRJ6bEGxHMbswA8oyAnP9A207BwmFjJ8+5k7i/I5vcWoFEZB6UhhEyF9J2ukv4C3CUW43Tzn80lpZvb/VcLN8cxfkmO4uaD66Fx9Ob1cUPD/soH1QYro/WvpNpyV56lDn+wof86U4zWSDsBM1xNgrFz4TXwHYhjWTs1gdcBNVa9wjHJApNHOw2xkkxxKULL4Ghr9qwS1yato8m+TgXLngw3hkLb59++QIeoytCPcmPL3aIw4x+yzdPMBL560F4JoQJ4gc5vxUiEHaBG15Vzq5m7pey/HES+pzNp/fQu59wyNFmSp3vo7NVtOMEAKldArfeZj2heEAIkLwujRtaqI+4Ga8S1O2WnM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR12MB4572.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(18002099003)(22082099003)(6133799003)(10067099003)(3023799007)(38070700021)(4143699003)(261102123227099003)(11063799006)(261009223027099003)(261022105027099003)(261022075727099003)(261021121427099003)(261021123027099003)(261026140227099003)(261026121527099003)(56012099006)(261028144727099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?U4DTFLRZKXAAu76BBQVK5W1kJE/Poh6My6CnH4TOfedrhhnAmPEX/muLcoLC?=
 =?us-ascii?Q?+DXBiNzZGOxsGLQ+25+YD+g3Eb4uz2ingjftRjgrxkK8ED2efm/gWhcVJ18F?=
 =?us-ascii?Q?XF6maqd9GQW9g+zcb7MR749OSwJDUqkBtbXUe6ia9+UmNOHwVNTkHJnoOU+A?=
 =?us-ascii?Q?1zn4bYmUtnhqWz3o4xnpYZn/Ko3fvgEUxcFtf85C11bAY9csi8/BHjRH+kCc?=
 =?us-ascii?Q?HMC3vNjVT/Kbz/jP4Dr66S+FuzkbxQhg7NteeP+Odr7n+cZa6bRWamCGCYZz?=
 =?us-ascii?Q?kiK1wxS5jhmUcKMMTv+MqBQWNn2b38wx2vqy55VdAg4PO6FPtkTnsNNWETmK?=
 =?us-ascii?Q?ZllGHqvvqlamCQWYRqQAT675ztVl8x9aNW9F1OtgXuQS2tTSd+hrWGdMPNRV?=
 =?us-ascii?Q?45xyv0/jxHlVK3brkPyP18f9g8UTVYv1mYQeSs/qye9kRSnQVAYpTvGNRY0S?=
 =?us-ascii?Q?g0khcJ+peNFvonPawfwRENbSUuno/jMu0xCG8R07QolLDNL5sENE/MYvf/gB?=
 =?us-ascii?Q?LQfWYAjmlwIEr+dKCv8T1wy5zsMpYPASync2ZBZHupkcS3U2lep9VsW+hxQZ?=
 =?us-ascii?Q?OPfm4YZAHkia++yFbsqM/ZIvMKi47kFEZjQq/jt9s9v8KEQGwMiaR04A/0ZE?=
 =?us-ascii?Q?fL4kkEC16A+96oG4RAYSnPC1m9UVL6pK3wwmEL0Cmhi2lfRrW0AvWL3uSOlT?=
 =?us-ascii?Q?z83twTiT3lyZOYzwRj5dyyOtEIHze0MOJ2EF6dpkCZzz9Kdj8y0Kk8FNhj3h?=
 =?us-ascii?Q?dVmgsPGmrLwCrhkh6SaYdYvxibpZhlOF5lmxc9UYbLTZof9Dc2QDJuYMwoNY?=
 =?us-ascii?Q?lTiNL+H51xkMuCvf1bU6iuuIgCZDWaLAXq49gnQR7epiVLRZzWE5A7VgyZt0?=
 =?us-ascii?Q?lwp/eCxsLprDtvZnBsPKMmIanob1xbAhBSy5M2TYyPUbZxJfCES0mFo5y/e2?=
 =?us-ascii?Q?dyxsxqDk/N5MZCLVytUIEzUBfPIJZw0y4wodMTyRhogFsmO/aP5tkYhcKQmH?=
 =?us-ascii?Q?7uWf55Q345Go2ikUlQer+ncgfVJonL25ZfmSRx5BRPLR2XnCtPlWvw8d0oL0?=
 =?us-ascii?Q?0l+9lIjxeqMI3H3Nm/TxrXvZg5TjHe3Uy9SuFJ7bLjffG/SIX6pGPbrNWypf?=
 =?us-ascii?Q?Yty3UfaZHPGg+IlU+01kzfx1l7tPpshlo25nb+9IdTkHAHf9lVSYxTgjloJo?=
 =?us-ascii?Q?wSpSjg4gFIb1kuYTvTobVtsfOgv+Ir+5e76MV428XnKD9qO2zD0P+tifxOGd?=
 =?us-ascii?Q?O2CCBCtGjswAKRTNSvMoD7e32BixZsL8t69QX27wbKUPYXL31yfBLdNIkHIX?=
 =?us-ascii?Q?MFQA4d+SgqPv4uDKiFJnDq+/RNTgCdiPTHhi6ITcmTeRsLq5pSfwI5F77HUI?=
 =?us-ascii?Q?MOFzkimrF+ILRcjTgDyWn4T07Ft2zOY9vuDKJ0W549R+AFCisMxppYHj+3RU?=
 =?us-ascii?Q?QLZItKOLY/si7OOG3QxkQzFzt+VRq0/f78Uatzpujjue99u0ONRLI3ZT84G9?=
 =?us-ascii?Q?QnpSzY3ZmzJUtkTE6ovTjMKyRfRyxRwCNiB5qaKzgAZh92ktHyF3gmZLFUzG?=
 =?us-ascii?Q?ohm04xaPpIrOzGPyC7Omh0jUJEUBw/H4/MULJNkRV2imREsm0yoyeMO5YYs5?=
 =?us-ascii?Q?8XyBVKxIkyLZIFmHKZxhebxpTShyd3Ypecpk+fS7KgIToF2yqpSnXS3Y89AM?=
 =?us-ascii?Q?IMOjXmn/LD41P5g3Q11laukZe0gq0qvE62dEGdqLcVzW4N7P?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4572.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfbebbe9-90e0-40ca-b093-08df3feab2e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2026 11:55:36.5765 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HzqulGB6OPrdGBVMHwSCiPujQIs1YxAVnRPanW7AzQvWPNZ2vZKGyWIvoaRLK5fp
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Christian, Alex and Cascardo,

This v2 replaces my posted interrupt-flag-only RFC. I first bracket
page-table allocation with commit/prepare, then move the CPU KERNEL
dependency wait into prepare, as requested. My author and sign-off name
is corrected to Zihao Mu.

The six patches are based on drm-amdgpu-next a6836fcbb5b2:

1. Handle missing/empty SDMA jobs and consume each job once.
2. Track internal SDMA completion independently of the public output
   fence, including immediate submissions, IB rollover and nested clears.
3. Finalize partial range updates on error, preserving the first error
   and using the preceding internal completion for TLB ordering.
4. Unwind failed page-table initialization through the VM entry teardown;
   finish the clear's current work before returning its original error.
5. Commit before allocation and re-prepare after clearing the new table,
   preserving the original sync even when the old phase had an empty job.
6. Wait for shared root KERNEL dependencies in CPU prepare, including
   NULL-sync calls; remove the reservation wait from CPU update.

Patches 1 and 3 adapt Cascardo's earlier cleanup proposals, retaining his
authorship and original sign-off. I am not claiming that work as new.
The internal completion prerequisite comes before partial-error range
finalization, so an earlier submitted IB is already tracked if allocating
its replacement fails. A clear completion is also retained if the outer
prepare fails. The public !immediate output condition and DONT_PIPELINE
policy are unchanged. PDE error handling is outside this series.

The KERNEL wait keeps its original interruptible policy. Interruption now
fails prepare before that phase starts writing; previous phases have
been committed and receive partial-range finalization. Allocation drops
the eviction lock and can introduce new move dependencies, which is why
the next phase must prepare again. The CPU write/flags/commit tail is
unchanged.

This does not reintroduce the old PTE-walker error-propagation proposal,
mapping retention or the independent no-KERNEL scan fastpath. SDMA
allocations can still fail. This is not a complete conversion of all
mapping/unmapping operations to a no-fail interface.

Local validation:
- All six intermediate source states compiled amdgpu_vm.o,
  amdgpu_vm_pt.o, amdgpu_vm_sdma.o and amdgpu_vm_cpu.o with GCC 13.3.0
  and CONFIG_DRM_AMDGPU=3Dm.
- Each intermediate state passed its applicable extracted-function
  checks. The final state passed 106 successful range/backend cases,
  149 failure cases and 2 successful PDE cases. SDMA fences remain
  pending at submit; the native TLB callback and worker bodies run with
  both worker-first and GPU-first simulated completion schedules.
- Two older source states reproduce the missing completion dependency;
  four deliberate mutations detect missing nested completion, prepare,
  sync and allocation boundaries.
- 960 CPU phase/parameter cases preserve PTE values/flags, with two
  KERNEL-wait interruption cases, one explicit-sync interruption case
  and two detected missing-wait controls. A 64-batch single-phase model
  calls the reservation wait once instead of 64 times; this is a call
  count, not a timing result. ASan/UBSan reported no errors.

The GPU, scheduler, fence primitives, BO/TTM lifetime and PTE/PDE walker
orchestration in those checks are simulated. They do not prove kernel
concurrency or hardware ordering. No full module link, driver load, live
fault injection or hardware A/B has been done. This does not establish
a fix for the original multi-second GPU queue stalls.

Please review the phase boundaries and internal completion ownership,
especially immediate SDMA submissions and errors after a nested clear.

Changes from the posted RFC:
- Establish allocation boundaries before moving the CPU wait.
- Remove the wait from update instead of making that wait uninterruptible.
- Add narrowly scoped job, completion and initialization prerequisites.
- Correct my full author/sign-off name and retain prior-work attribution.

Earlier cleanup proposals:
https://lore.kernel.org/amd-gfx/20260914-amdgpu_vm_fixes-v1-1-d6d835591e0f@=
igalia.com/
https://lore.kernel.org/amd-gfx/20260914-amdgpu_vm_fixes-v1-4-d6d835591e0f@=
igalia.com/
Latest review:
https://lore.kernel.org/r/938026a1-3b02-40b4-98e3-a0a22f045f82@amd.com

Regards,
Zihao

base-commit: a6836fcbb5b22968019256025321d655b78bc49c
--=20
2.43.0
