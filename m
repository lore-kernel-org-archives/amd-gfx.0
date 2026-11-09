Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67875606A321
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Nov 2026 21:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=YSFyF8S3
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F40FC10E5B1;
	Mon,  9 Nov 2026 21:36:07 +0000 (UTC)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010054.outbound.protection.outlook.com [52.101.201.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 920EF10E5B1
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Nov 2026 21:36:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G6tezgLtoRKKme6rMj2oc1+P4O7Agpk2pwiV3BUX7KciggLQGHfDcamXv/dW/UrcHFm6zpZHwWB8ETy+29ATtYvARC8ZStxXRiZzazuBjlbQLBcv2GEufMPs5ovEoeMsnhCwZ2u/H5odi0dPjuMygxaCXFbBZ/BDxg4+A6yWkWgf1c/ELgAT8s5rlEjUpWs+SmcrNqXB31N4EoFRtKm/tMgYIHRQ69Zb5dwJzn0/1FKvA2qJXuHCIxqaLyx47SRk9nwO5L8fGyNt9B0i0vxY8Npt9Qv2ZGNnGvUrHqmfuDJ1mJbW3YD4GLDKnAbW13Om6ihKlxgY759+zjBwMxyxLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hjZEAAlN0vib3zI4KXEq82lTFy+yInq+LWhS0JYECi0=;
 b=LmqSNgcp3KgVBg/zHXaiih9C7PNGxdGSyYzrYUyUVl57QPhUUcgGCfSE7MTahjw34jNk6ID7hoKtsui9lw9d9VKvRMpsUnIK3RinlvZc3NqPO1YwUsIb5iNF7pfPc205q8GUrz6xdd5kiWIpLP+NnQEtU+yG7AUxDpmR8wa30JEq1ZyRnZnq8Wb6kiyP5aZHirps1Fa0C0UZYgMtl3yrw+ONlkjFfuN+UvuZ+zeIgHGHeHWm8jv0d8XlO+hFRhWKA0zC3waEGvrPZ+fIQq9bkGKBLSODik8tRMhAYc4Dk8lYTuPovAG87KbXzlpZ7DkRU4ASwSP8jYW6KP5ja1/Wnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hjZEAAlN0vib3zI4KXEq82lTFy+yInq+LWhS0JYECi0=;
 b=YSFyF8S37EiwImGfQ84q+Cl9nRGJyLj6GRRGPdy8BxBqrqv74duDxGiC2i3xu8VWxT2L4aSFToY8ZbWbhAgjVpbO4cQzTjjKntqQWhpA01oJI4+KdlwTBQpQuPrtozKh9seTq6IO/Y/yNXGZxgbSOeVdIdtBtj1zf5qUbB+JTrU=
Received: from CY8PR12MB7337.namprd12.prod.outlook.com (2603:10b6:930:53::9)
 by IA4PR12MB432591.namprd12.prod.outlook.com (2603:10b6:207:12d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Mon, 9 Nov
 2026 21:35:57 +0000
Received: from CY8PR12MB7337.namprd12.prod.outlook.com
 ([fe80::3368:7778:6a7b:957]) by CY8PR12MB7337.namprd12.prod.outlook.com
 ([fe80::3368:7778:6a7b:957%3]) with mapi id 15.21.0592.012; Mon, 9 Nov 2026
 21:35:57 +0000
From: "Han, Qiang" <Qiang.Han@amd.com>
To: "Yang, Philip" <Philip.Yang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "Gandham, Shashidhar" <Shashidhar.Gandham@amd.com>, "Zhao, Huasha"
 <Huasha.Zhao@amd.com>, "Gu, Zhenyu" <Zhenyu.Gu@amd.com>
Subject: RE: [PATCH] drm/amdkfd: wait for the queue quiesce in concurrent SVM
 evictions
Thread-Topic: [PATCH] drm/amdkfd: wait for the queue quiesce in concurrent SVM
 evictions
Thread-Index: AQHdcI9/alR+TjKW30KlOF56Q1N5lrcmQxhw
Date: Mon, 9 Nov 2026 21:35:57 +0000
Message-ID: <CY8PR12MB73377D93CC90D214E17B2143E4732@CY8PR12MB7337.namprd12.prod.outlook.com>
References: <20261109211514.3737466-1-Philip.Yang@amd.com>
In-Reply-To: <20261109211514.3737466-1-Philip.Yang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: Huasha.Zhao@amd.com,Zhenyu.Gu@amd.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-11-09T21:34:32.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7337:EE_|IA4PR12MB432591:EE_
x-ms-office365-filtering-correlation-id: dd1fc0e4-117e-449b-a341-08df3ea970ba
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|921020|38070700021|261009223027099003|261022115727099003|11063799006|261021121427099003|261021130227099003|261021135927099003|261022075727099003|261026130827099003|261022113327099003|56012099006|261022105027099003|261021123027099003|261021133027099003|261026135527099003|261026140227099003|261028144727099003|261102123227099003|261026121527099003|10067099003|18002099003|22082099003|6133799003;
x-microsoft-antispam-message-info: odBgZnOxtc1w+wSyxwYA/nixq+Z02lmrbGfPFseP6poAymjFLGCM8O0rMfBOZ/XJNpRDi/3LCibK1biMn6G0GPeYGW1uawEWEZ8XymADL8fcJklYEPBcaR8O73fwUhfaqWj9GUc5LECRwUsMJpEp/fzHu9zwMjlYi9qRdRZVedmRUOpHZ2M2cbhjr6FxI5X3fIMRBL8UAAVRSPUK4M5NKb/Srl8qdqeMufXMj9zaLxLc5a54BiOJ2dwvMc9wnqb4GgxlrB6OUKsLkIY2w1ZSUEsKalYD9xnKj0skUgyiPiT/NDVSdrCtNLSXswg5llcYuvxhsnQa7WcHs55oN5I60tpPGDhsbPuecPQ1tvsnZ2/ru2FCyd2pZANjrAac9wjZmaGZR422THVeMsiRNNzKqCOvz4YiyePVnaRjJgjSBbDbHKUFvnBYmVReTgbUCOgz4GpmY/038oTTewssBppeSGSGVK4f//rGyzYtk8mufV+79QoHw6WYqcw+K/XDK98I+QnVIqNM76XBiqSgHS4vVCjBOOHNtEH2mkGbQtw6gQ7gsM92iJB/wJWajg8jx9kGl6rjMOiX4b4E0BYFidoH4hirD5w7gvj6UIqlAFWrEFlj10XJlk29FJV6GKVrTXBxXBMIREHD2FXh3F+KrG2FOmJBrthDHUswzB4uBZmtud/UXWKEXsUcErwvbPFtg8SUTukMPLMaekxevZ/STQ/IQvRM/GuLdK4BiiWj/090yC6C7OOO5krGfXB14SyGVl+k
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7337.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(921020)(38070700021)(261009223027099003)(261022115727099003)(11063799006)(261021121427099003)(261021130227099003)(261021135927099003)(261022075727099003)(261026130827099003)(261022113327099003)(56012099006)(261022105027099003)(261021123027099003)(261021133027099003)(261026135527099003)(261026140227099003)(261028144727099003)(261102123227099003)(261026121527099003)(10067099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BEAhLE2Ffblto04WraSdjyiOytauWMICS8JP0qgAQcKIDlMCFmfRC69cCQp2?=
 =?us-ascii?Q?4ZuXTALF47wx7qfpH6oUX8wkQ0jeI6GGqjObnzFjAhxtg3AbhMfuqInHIqG3?=
 =?us-ascii?Q?kEyY5lUgGFTXJOMrxfexX28Ht3RWcWshkRvsrsiZkELmCBLnGfn7S40yxfRx?=
 =?us-ascii?Q?S3C6SkjO0hu1B7R/8HS9Q8V1QweyE2XA8k65ff1SL/j+TnefP4+09cPlyfmu?=
 =?us-ascii?Q?yChrURzWxJ+xYjNM1QV9zFsNL5KRZJrwf2BXh20fkUNXs8pT6fd/cPrJsk0W?=
 =?us-ascii?Q?sOUzsIQdI/oBCfCSGnHg1UzCMkZoGkzdM51BkafWpw1RlReXlrJgWElbfNie?=
 =?us-ascii?Q?2zVfhvIU7EZaPiwolyjFLJjp//t/XnaJ/HXUDodR7xwep7y8Hw9L6yKK8FDB?=
 =?us-ascii?Q?f+7OlXnj8mnfU4i9OyOjETZzIiq90g1ApUKoziLPsODtateb4Vm4KEg45DGy?=
 =?us-ascii?Q?Vp5FmGttP88V5rEltrjq4amnwMkcELc1U4M0sz4fuoqVGPb8YS4t0GNvke7X?=
 =?us-ascii?Q?a5NyGh00szIot/pTjEbKUY6eOW22s88wb658d4KM7JwWo7fPF6utNr8bNvBP?=
 =?us-ascii?Q?0bV06QIzwlg/YIAvjk0b6rXfFLnILbowbO8r9Ha1ijhn3kipgYv0wzmGeTFv?=
 =?us-ascii?Q?yBi8TNQU5yVpCb4+iIyjAF03XH5UfPGAIzNUlN4odkCE+llrh4MXs+Pas14n?=
 =?us-ascii?Q?lWxKohN48bQ9diqENffk9LGmOT+o+TRW1+SKTmn7dVTVaXA8R9P0TXg4cd/p?=
 =?us-ascii?Q?ZuKfCL2Ulzsvqbh8JNhOMP9qKAcSkidjxbW3XuD//kBXJc0uKmaRLjK9Sgx7?=
 =?us-ascii?Q?UkK3LmbctPwyLJ32O4doXQiQQoliw8ACe4rCuiC/1dyIkmNMfkGSi/m7R5Px?=
 =?us-ascii?Q?+Tzo77sDtz0dApyXx9972EYYMH1hWZ+UyPQi1TwKXnZfFy5gf4uS7ClN9L5p?=
 =?us-ascii?Q?4znFpEIIGfaSqjhQqq9a49GWiQE52uYFhPVScfzzAtI5p/V/XiRj4yVO9aCC?=
 =?us-ascii?Q?lJs5dlEr6QxqvTCjzyTkSRNRKl8HKkaIHkjCo4Y7Qi165JDDBPrOGyHU+/mo?=
 =?us-ascii?Q?pQcne0UdZyWpIGsHHV/AZruoJc1StTmudc92znjY+7IwnMqViux9TJKyOJGz?=
 =?us-ascii?Q?GmGgcdeisO+HQqjJJBQjZp+rR49FIIDKoeMxrX0TA6Md1EAdkx0r7JyJDaGt?=
 =?us-ascii?Q?13ivqSLg6uA/ELd/+AI4pLKrEgifTA1r4VmeLVV10Qe1/4UPl1rgmjH6ebKU?=
 =?us-ascii?Q?lQV99otX4VXSZQB1My1nJX0jTOmqTM/RHiePTf0tOo8iVcfS8/7s6wD5HLFu?=
 =?us-ascii?Q?v9YBCSZ9Qc2E/NrmY5d93aNHT5PuBMfAqoWcMpAtBY8H34C25bd5gRpXkXvB?=
 =?us-ascii?Q?5G+cridZA4lMllPZFfpLc2vJkgHwEyj0F3TZe1IBxE1cfq8A8JgZLiG7/IOJ?=
 =?us-ascii?Q?YznwdPUbTuxqClTAlI7qa5teM353/+IhMt8H74/pUwQEHi6OW2NiAkm2j2EC?=
 =?us-ascii?Q?3Ggtx5t3xZt0XMVphlAXmNoPgJbZ/epaeI556XAhqnukRfvOK30wWbHek/LO?=
 =?us-ascii?Q?qXuBFUr83xcaXv1N0NxW472iDa1M/msY/EDgpnbozhUxc3YpakQUZ8x5JfD1?=
 =?us-ascii?Q?Ot1om3Inxn7M6AMejjQrjHHP5RKcZH97Ot7ukqcCufbg88Lau/NHPxhxbnDf?=
 =?us-ascii?Q?7Ejzoc6nQUu8q1xCD29i0jDKqh5S8OprQSLxRWZVug64Jugl?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7337.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd1fc0e4-117e-449b-a341-08df3ea970ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2026 21:35:57.1005 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VrgWRwrHE7QjO8gYLxCzLmU3jp4d7urqYqUdd7T5KeMVeaBZTvbfbZXxICllBToB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB432591
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

AMD General

cc @Zhao, Huasha @Gu, Zhenyu

-----Original Message-----
From: Yang, Philip <Philip.Yang@amd.com>
Sent: Monday, November 9, 2026 1:15 PM
To: amd-gfx@lists.freedesktop.org; Kuehling, Felix <Felix.Kuehling@amd.com>=
; Gandham, Shashidhar <Shashidhar.Gandham@amd.com>; Han, Qiang <Qiang.Han@a=
md.com>
Cc: Han, Qiang <Qiang.Han@amd.com>; Yang, Philip <Philip.Yang@amd.com>
Subject: [PATCH] drm/amdkfd: wait for the queue quiesce in concurrent SVM e=
victions

From: Qiang Han <qiangh@amd.com>

With XNACK off, svm_range_evict() leaves the GPU page tables in place and r=
elies on the process's queues being stopped before the MMU notifier returns=
.

Only the first eviction (evicted_ranges =3D=3D 1) calls kgd2kfd_quiesce_mm(=
). The quiesce preempts every GPU the process has opened and takes millisec=
onds. Any other range invalidated in the meantime sees evicted_ranges > 1 a=
nd returns at once. The core mm then frees, migrates or reuses the page whi=
le the queues still run, and an in-flight SDMA or blit copy accesses it thr=
ough the old GPU PTE. The result is silent corruption of the copy, or of wh=
atever process now owns the page.

Hold a new svms->evict_lock across the first evictor's quiesce, so that con=
current evictions return only after the queues have stopped. This is the sc=
heme amdgpu_amdkfd_evict_userptr() uses with process_info->notifier_lock. e=
vict_lock nests inside prange->lock and is taken nowhere else. Under it, th=
e quiesce path takes the dqm lock, which is already used in MMU notifiers (=
memalloc_noreclaim).

One way to reach this: a pageable hipMemcpy() larger than 1 MiB. ROCclr pin=
s the buffer with hsa_amd_memory_lock(), libhsakmt registers it as a KFD SV=
M range, and host memory pressure (reclaim, compaction, allocator purge) in=
validates the range.

Fixes: 8a7c184a16d7 ("drm/amdkfd: svm range eviction and restore")
Signed-off-by: Qing Hang <Qiang.Han@amd.com>
Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h |  2 ++  drivers/gpu/drm/amd/amdkfd/=
kfd_svm.c  | 35 ++++++++++++++++++---------
 2 files changed, 25 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/am=
dkfd/kfd_priv.h
index 158fa70a1a8e..581fb7ceba40 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -909,6 +909,8 @@ struct svm_range_list {
        struct list_head                deferred_range_list;
        struct list_head                criu_svm_metadata_list;
        spinlock_t                      deferred_list_lock;
+       /* serializes XNACK-off evictions with the queue quiesce */
+       struct mutex                    evict_lock;
        atomic_t                        evicted_ranges;
        atomic_t                        drain_pagefaults;
        struct delayed_work             restore_work;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amd=
kfd/kfd_svm.c
index 3688ae7ba35e..8b84333a85b7 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -2141,21 +2141,30 @@ svm_range_evict(struct svm_range *prange, struct mm=
_struct *mm,
                if (prange->start <=3D last && prange->last >=3D start)
                        atomic_inc(&prange->invalid);

+               /* The MMU notifier must not return before the GPU has stop=
ped
+                * accessing the invalidated pages. Only the first eviction=
 stops
+                * the queues, which takes milliseconds (HWS preemption on =
every
+                * GPU of the process). Serialize all evictions of this pro=
cess so
+                * that a concurrent invalidation of another range waits un=
til
+                * that quiesce has completed instead of returning while qu=
eues
+                * still run on stale PTEs.
+                */
+               mutex_lock(&svms->evict_lock);
                evicted_ranges =3D atomic_inc_return(&svms->evicted_ranges)=
;
-               if (evicted_ranges !=3D 1)
-                       return r;
-
-               pr_debug("evicting svms 0x%p range [0x%lx 0x%lx]\n",
-                        prange->svms, prange->start, prange->last);
+               if (evicted_ranges =3D=3D 1) {
+                       pr_debug("evicting svms 0x%p range [0x%lx 0x%lx]\n"=
,
+                                prange->svms, prange->start, prange->last)=
;

-               /* First eviction, stop the queues */
-               r =3D kgd2kfd_quiesce_mm(mm, KFD_QUEUE_EVICTION_TRIGGER_SVM=
);
-               if (r)
-                       pr_debug("failed to quiesce KFD\n");
+                       /* First eviction, stop the queues */
+                       r =3D kgd2kfd_quiesce_mm(mm, KFD_QUEUE_EVICTION_TRI=
GGER_SVM);
+                       if (r)
+                               pr_debug("failed to quiesce KFD\n");

-               pr_debug("schedule to restore svm %p ranges\n", svms);
-               queue_delayed_work(system_freezable_wq, &svms->restore_work=
,
-                       msecs_to_jiffies(AMDGPU_SVM_RANGE_RESTORE_DELAY_MS)=
);
+                       pr_debug("schedule to restore svm %p ranges\n", svm=
s);
+                       queue_delayed_work(system_freezable_wq, &svms->rest=
ore_work,
+                                          msecs_to_jiffies(AMDGPU_SVM_RANG=
E_RESTORE_DELAY_MS));
+               }
+               mutex_unlock(&svms->evict_lock);
        } else {
                unsigned long s, l;
                uint32_t trigger;
@@ -3437,6 +3446,7 @@ void svm_range_list_fini(struct kfd_process *p)
                svm_range_free(prange, true);
        }

+       mutex_destroy(&p->svms.evict_lock);
        mutex_destroy(&p->svms.lock);

        pr_debug("process pid %d svms 0x%p done\n", @@ -3450,6 +3460,7 @@ i=
nt svm_range_list_init(struct kfd_process *p)

        svms->objects =3D RB_ROOT_CACHED;
        mutex_init(&svms->lock);
+       mutex_init(&svms->evict_lock);
        INIT_LIST_HEAD(&svms->list);
        atomic_set(&svms->evicted_ranges, 0);
        atomic_set(&svms->drain_pagefaults, 0);
--
2.50.1

