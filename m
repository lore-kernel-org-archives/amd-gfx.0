Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10618606A31C
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Nov 2026 11:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=2+60bb1T
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 93FF210E5C8;
	Tue, 17 Nov 2026 11:39:53 +0000 (UTC)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010005.outbound.protection.outlook.com
 [40.93.198.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 173E610E5C8
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Nov 2026 11:39:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OyK4Hk+3EZWJ7j9Jc9dUY7cQdwcuzVRdRPxZfz+GJcB+C4wRtCyZVsmEJk32TUmbDv765xfDLVx1qBl/28LQ820dmiibnKSbDN9V30nxOAGW0rkNBMFwEHPnD/FsOAfa9UK/nO5RzV3ts9psmfRG7H/QKU+dRKduBzUX8xRCCycnTMaep4fSEZHe4m1Cux7pIw99I2AvnO11mznFgJSx082fNRmOi5T5RssSpygR3S+rJJxN2ejjveVy9eCAUU323R8gD2NjduduZmerXvswPVAwNbVZv8P7eLr8iluKEUK0AIlzsW2DNdV8sZ2twEqeHqqI+eOVT/Hzzi/4iwom7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uGbvoSFTiINayla7OtJjwPBwQjDXl6YsHnSjaVsR49w=;
 b=Rq8Z5B1JLvx1dwzCJWq3jp1MGv0+VEFi4+dkw62EY/25ldraVus8emGzxWPfEQcnGV1BFz3HK7x4T0saRWbJrbrr9WvytoYWafmVOk/ZCb1tJGnKnZhgg+WOjMmtF10KWuahYlCBTaTu2Nfkm4CtigxaOA/LDbt0bjxNedkbzb557/hKCFp/bRLd2EaurRwYuJxUbBHSyHgbZR/dDrCn9xCfsLBqJRiu09ZPFZ21MGFHBwYibYMxALZIAjilXrDKniuWYaTZ8MIYfJ5xg4OoCgM7XRih8w8cTDbhuBQ8n2aiyVc5ibQx1tt0YZb/bPwMF45TxvsEFpLmwOJCq5s71A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uGbvoSFTiINayla7OtJjwPBwQjDXl6YsHnSjaVsR49w=;
 b=2+60bb1TYovgqxmVg5uwV3E+9wNBfsBgfgwStcUP1+zQTbb1jsxpTEFkkUpQ7jtLgj2o9voQNHcrIb3FJG/1ilpihh4zI2CqYf5ocKXBhK5FZCGMdrIdh+m31elJkTE1rmOU30qccZ1Sw8Vn4T0Ddy3PLUAqidScewLnLdPpAUs=
Received: from MW3PR12MB4572.namprd12.prod.outlook.com (2603:10b6:303:5e::7)
 by SA1PR12MB999086.namprd12.prod.outlook.com (2603:10b6:806:49f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 11:39:44 +0000
Received: from MW3PR12MB4572.namprd12.prod.outlook.com
 ([fe80::79cb:c567:1825:51fc]) by MW3PR12MB4572.namprd12.prod.outlook.com
 ([fe80::79cb:c567:1825:51fc%6]) with mapi id 15.21.0615.013; Tue, 17 Nov 2026
 11:39:43 +0000
From: "Mu, Zihao" <Zihao.Mu@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, Thadeu Lima de Souza
 Cascardo <cascardo@igalia.com>
Subject: [RFC PATCH v3 0/5] drm/amdgpu: prepare updates across page-table
 allocation
Thread-Topic: [RFC PATCH v3 0/5] drm/amdgpu: prepare updates across page-table
 allocation
Thread-Index: AQHddohWP/nteJU8CE2R+q4Copw+FQ==
Date: Tue, 17 Nov 2026 11:39:43 +0000
Message-ID: <MW3PR12MB4572DA4F9D571938FB7C4A999E7B2@MW3PR12MB4572.namprd12.prod.outlook.com>
References: <MW3PR12MB4572FABB93F6676FDBA1D2479E722@MW3PR12MB4572.namprd12.prod.outlook.com>
 <4edd67f7-381a-4446-9509-552739c8f016@amd.com>
 <MW3PR12MB4572A08ADA8CB7BA9F83AF519E712@MW3PR12MB4572.namprd12.prod.outlook.com>
 <938026a1-3b02-40b4-98e3-a0a22f045f82@amd.com>
 <MW3PR12MB4572BEFF9134ABF824D374C79E712@MW3PR12MB4572.namprd12.prod.outlook.com>
 <bf90d631-c63e-4df0-92ad-213bd65ef0ba@amd.com>
In-Reply-To: <bf90d631-c63e-4df0-92ad-213bd65ef0ba@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW3PR12MB4572:EE_|SA1PR12MB999086:EE_
x-ms-office365-filtering-correlation-id: c1fd103e-1c6d-4e07-6793-08df449f7971
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|22082099003|18002099003|6133799003|261009223027099003|3023799007|4143699003|5023799004|11063799006|56012099006|261028144727099003|261102123227099003|261021123027099003|261022105027099003|261026140227099003|261022075727099003|261026121527099003|261021121427099003|38070700021|10067099003;
x-microsoft-antispam-message-info: 4IwEKnqNOIKhlGg0keV7WWCoCeplCZcPrWcVuK24yGNd5ri+90XwVZ0V87YIMgr4xYLWdE6YR9nKe59JzS3fZpelLBEdN2wcxTjL97TZ8cUQVcS7FWMim2kEpRKImiCDECUfwQAysSjn1zT5JnKQTShUiMx7gOz5Vu5xOFA9XEZF4sn8/2e+XHliVwvivyVRasxBdPAhva2VFzmi2iEAetygy+EyFt01a4JPjXoPSZXVgq6dyQuTjfllApHAXmdawJlWl5TRbfAjxfr3+yY5w9d1NILkKrIqh1PiNx63SkVadWS6hNfo5Nzdfnx8n1gLLRiWQbZRStt8HfVv5Nzw9xfc/qRjJMO1pjh+qAXaxCsgAIRUAfBorrD4fRcitZx484QwG6+h//h1cxoOXlt9MsCQiaD7U0pfeiCpwE1dLKnuqBJ7cDDLoJVqGTmGoDYbaCFnmaltaoxz6nLe7s3XktVq3HOEuL63WYNAGYjk4XSuDLyERQR4YniWCERqEs3X4wmE8PBdwWTLXAFIH0564VZPRcTs0VCaxAN39uHftNAzmzDOtdtOmOt2gMNsVKAtN0Pmi8G4/zO9jbQMXTT8+sb0Sljb6+zZ3BXMHMo3ELLNq1imO2uHFteRYogGJyWs6r2DD9WA28+zxDzFJNiBfZWYmrv7ogB9uVfJnTqRxDc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR12MB4572.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(22082099003)(18002099003)(6133799003)(261009223027099003)(3023799007)(4143699003)(5023799004)(11063799006)(56012099006)(261028144727099003)(261102123227099003)(261021123027099003)(261022105027099003)(261026140227099003)(261022075727099003)(261026121527099003)(261021121427099003)(38070700021)(10067099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xPzULCNBAT94zL5MgmzBEU6PvZe0/0r08j7yaBAP3yvndxt6T5fSgb+chI7q?=
 =?us-ascii?Q?XP2C+sicaiyK/mGnIJ7X3Jjh7uFtntTCD76X1lw4Gjb6/7E99BmOYniwU5mo?=
 =?us-ascii?Q?jDFjlKumOUQM0ZGLC+JH1RyV0WOvVpU12V+8Iewu4Xhcl2QB0s6vL9735wsQ?=
 =?us-ascii?Q?vHrXQpncbmAXs6G4Wo7piyp2Ycuj9M+eI/TCUIGqVVBiGeOLef6WBVBnSdWc?=
 =?us-ascii?Q?c2tCgb2NnSf4KNHX8+J7nK23jZX6iHKt9B5CwnCQQxaD4/G53/JnzZSbT5Va?=
 =?us-ascii?Q?3JB792CMM0fK7TvZp0aks/ZElDKba5JPenAtwnWfX5I1DNRejmyMvoBiY2J7?=
 =?us-ascii?Q?6T3K4LAt5vnMMgBKGKFJE8WBsp3TkFtrQFy+Goqm/7YY99vPXQkTENbsGIKA?=
 =?us-ascii?Q?SZIBGgJLQ7DfXWlFl2oV+7WFNEzj0M87VYLmuGo1416pRKgqy5Y4Bn8OM3cF?=
 =?us-ascii?Q?LvN7GfFXAGwIah9m8dcKUfF9fYWvQ/aFSFxqKZH5Picm4D55K4Em00gmh3EV?=
 =?us-ascii?Q?ax/2nuGSYgwUTCyCIgGj7YtJD6sq/bqxOilTo2QfEKy9WTCtz1EQq06qlQOx?=
 =?us-ascii?Q?6EVQmN3AhPpuuaHKfcBS7Qeiq5lFuS38cDsnZZBZrhkuuGkviSKMG4mdL5hZ?=
 =?us-ascii?Q?VdbzliFFBcvolchgdfX5umnwaHRGqWxy/jXVNDOeAQBFQSeJUukVgWdUu2yf?=
 =?us-ascii?Q?zI29T73r0/U+b2Is7NydHt/A3/voAKsE6x3yu8R8r4dESIdFaNUuYOrB1QMz?=
 =?us-ascii?Q?grNPUCzpiC27w/PTNwYDI3zTcktOImQRaggaPEXhCA5a+i/49ZJPXPWDxEVT?=
 =?us-ascii?Q?23zx6s6zMSmbRvKsIxwS9n2a67nfgFLtyHHve1Xz2mXg8q6vx8hsDejeIriI?=
 =?us-ascii?Q?q5Lj3TzrmqM7PJMA6LJDiilfQOqtar7za+49jw38X9y9ohkmdhArN0q1AfrK?=
 =?us-ascii?Q?Mi/3Lx4Wppez2ydTyV1dMme0X7h2xpKIEmkoW8zXBvvud2Nc3HjOfxYgU6Cn?=
 =?us-ascii?Q?wemITnnPUKAaYFGw4o9gaMH8rkGxeOdTl7wyn4pO5Tv7O6L34oLi54l2ylEW?=
 =?us-ascii?Q?Niiex52CEWR6hzeLNuZ4Bhjvv12X/Hrhvx90YwKy1FwK1ke7u4EMp1yECZ0a?=
 =?us-ascii?Q?U6AJKkzLE3laSm7rEblX9qljChzByZMoMUiq8eSxkV0APDpJ1N8cqCx1KAjr?=
 =?us-ascii?Q?wdILK5AD89w/QGAelBRmjgcKJLo02mdu2i8Pq+DcR//fEBOO0FHi3SP65kOv?=
 =?us-ascii?Q?EfZzg4Sius3vry88wA9fgT8aQIFo0jlnWtWTk/OL7BvAjXCOP3mWEZnte6K/?=
 =?us-ascii?Q?hjbSbh216BMq69URVLlUPKrWh4DzF1RIjEChV/k9zqCnVVFiViTZw8o3GMqe?=
 =?us-ascii?Q?RrKfZl1ZfAyBTI+TaAoXcuBAAmQEeDlp+Hj1oPtaGKjglvV+vAtmuOBM8oVc?=
 =?us-ascii?Q?CVv9V1U+y1c53VJq7bd4+H2N0Nj4FcyoyJuLS2iXgsaX/Z4lA906nJOAClaP?=
 =?us-ascii?Q?C9djVJ27aJiwLR/2+qSP656buE0eywAr3HzO41Si4XTxUI7ULbIq23ZW5Ca/?=
 =?us-ascii?Q?bKqo6ZRD7rlWfZfmdM+SfD97z1e92Nb0Mv0LaJqEg8kJNZtzDxoW7f1FWpGh?=
 =?us-ascii?Q?v7Iw6cgFJCSHNxQdbjxmtjIHKwpwpyV0kTxGHS2pUZmQalYyZ/61KnsawGVt?=
 =?us-ascii?Q?1sp8mba9reE0DKLiTkPgBrhyUzo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4572.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1fd103e-1c6d-4e07-6793-08df449f7971
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2026 11:39:43.7198 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TAHXP4T8HULOvtN2E1JgBIfOwlfI8k5eKbRxZ4+3061GIaseECYQiaxSXrtyGxcS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB999086
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hello Christian, Alex and Cascardo,

This v3 waits uninterruptibly for explicit sync and root KERNEL move
fences in CPU prepare. Allocation commits the old phase and prepares
another phase before writes resume; CPU update no longer scans the
reservation for every PTE batch.

Changes since v2:
- Use intr=3Dfalse for both CPU waits. Drop the result check for the
  infinite reservation wait, following the MMU-notifier unmap contract.
- Reuse Cascardo's void-commit cleanup [1] and the existing PT teardown
  fix [2] as prerequisites. Remove our duplicate teardown submission.
- Adapt Cascardo's context job-ID proposal [3], including SDMA prepare,
  initial allocation and IB rollover, while preserving his authorship.
- Keep internal SDMA completion tracking before partial-range cleanup.
  Fold nested-clear finalization into the allocation-phase change.
- Explain the same-entity finished-fence ordering and owned-reference
  transfers in the completion-tracking commit description.

Why one internal completion is enough for a range:

A range prefix, its nested clear and its resumed phase all preserve
immediate and select the same VM entity. That entity keeps its engine
while work is unfinished, and SDMA submissions execute in queue order.
amdgpu_job_submit() returns a finished fence, so the latest such fence
covers those submissions. This relies on no cross-entity global order.

Each context owns its last_update reference. Submission replaces it;
missing/empty commits retain it. Nested clear transfers its reference
with a swap and puts the displaced reference. TLB finalization takes
its own reference before the context releases its private reference.
The optional public output and DONT_PIPELINE policy stay unchanged.

Dependency and application order:

The native base is identified below. The November 17 public refs still
lack the three prerequisites carried in the source backup:
  A. Cascardo's missing/empty SDMA job handling (posted as v2 patch 1/6).
  B. Cascardo's void-commit cleanup [1].
  C. The existing publicly posted PT teardown fix [2].

These are native adaptations with original authors and sign-offs. I have
not identified the exact queued reviewed PT-fix commit, so I have not
inferred a Reviewed-by from equivalent public code. The prerequisites
are not resubmitted as new patches in this five-patch series.



The complete stack is backed up here (source backup, not a pull request):
  https://github.com/zihaomu/amdgpu/tree/fix/vm-prepare-uninterruptible-v3-=
polished

To reproduce from a disposable checkout with the native base available:
  git fetch https://github.com/zihaomu/amdgpu.git \
      fix/vm-prepare-uninterruptible-v3-polished
  vm_prereq_tip=3Dadc41aaa1cb5e3103cad42ed9180d68fc384ffc9
  git switch --detach "$vm_prereq_tip"
  git am /path/to/v3/outgoing/v3-000[1-5]-*.patch

That checkout contains prerequisites A-C only. Do not apply them again if
they are already present; port onto the maintainer's queued versions when
the corresponding commits become available. The cover is not a patch.

The five patches are context job ID, internal completion tracking,
partial-range finalization, allocation-phase restart, and CPU prepare
waits, in that order. Original sync and job ID survive allocation.

Validation:
- GCC 13.3.0 compiled the four relevant VM objects at all eight commit
  states, with CONFIG_DRM_AMDGPU=3Dm. Applicable offline checks also ran
  at each of the five outgoing source states.
- The lifecycle fixture executes extracted native walker, cursor, PTE
  flags, free-list, backend, explicit-sync and TLB-worker bodies. On the
  final state it checks 96 range cases, 54 allocation failures, four
  free-list paths and two PDE paths. Unlocked walks do not allocate.
- Pending-signal checks include 16 CPU unmap and four CPU allocation
  restart cases, plus corresponding SDMA cases in the scheduler model.
  Separate CPU/reservation checks cover 960 normal and 960 signal
  combinations, eight signal/unmap cases and two missing-wait controls.
- Nine broken controls are detected, including removed SDMA KERNEL
  dependencies, allocation in unlocked walks, lost original sync,
  lost clear completion and a completion from the wrong entity.
- Nine direct backend/scheduler unit cases are counted separately.
  Two explicit contract controls confirm the unchanged native walker
  still ignores a backend update error; they are not successful unmaps.
- Strict checkpatch passes for the five patches and cover. ASCII EML
  extraction, default git am and per-commit full-tree application match
  the exact sources and authors. ASan/UBSan reported no runtime errors.

The model is bounded to a two-level PT fixture. Hardware encoding,
BO/TTM, scheduler, GPU, list and fence primitives are simulated; this
is not live fault injection or a kernel concurrency proof. Operation
counts are not measured performance gains. SDMA allocation failures,
the complete no-fail unmap conversion and the original queue-stall
cause remain unresolved. The independent fast-path proposal is excluded.

Please review the revised wait contract and phase/fence ordering.
I can rebase onto the queued prerequisite commits when they are known.

[1]
https://lore.kernel.org/amd-gfx/20260924-amdgpu_vm_update_funcs_commit_void=
-v1-1-9ad7a8283920@igalia.com/
[2]
https://lore.kernel.org/amd-gfx/20261109090517.2905697-1-Jesse.Zhang@amd.co=
m/
[3]
https://lore.kernel.org/amd-gfx/avRl4ajLaCSa8AeG@quatroqueijos.cascardo.eti=
.br/

Thanks,
Zihao

---
base-commit: a6836fcbb5b22968019256025321d655b78bc49c
prerequisite-patch-id: 8b58a9b82460d152ba8dbbd77cacb733c73221bd
prerequisite-patch-id: c6ccf9fd4659ee004f8af666adc985bfe4a05de4
prerequisite-patch-id: 6eec44dc54d47d900a5172c4aed842e66e8ce868
--=20
2.43.0
