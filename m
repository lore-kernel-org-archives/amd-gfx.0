Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CEF5C9830B
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Sep 2026 17:03:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D737A10F0EC;
	Wed, 23 Sep 2026 17:03:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uyGvkwXk";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011015.outbound.protection.outlook.com [40.107.208.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 52A4510E09B
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Sep 2026 17:03:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=egJnySRBlfwGhrbucM0CjLZF2dcghLc63OaqD7EGNaKQIOQyXyskXoymW3m9lEwvny9j0dcMpUQg0ii+PN3YNg2V/SpCttGZQPVyY8UDVwSgfb+qf9wLhK580YLA6hA5+RGyWOhNKxXWZLjvQ1S9tygSpcNNgZZjMj8b3WZMRuqsxA0Mn/l4nwe3ngWNeaEGo0FfpKK9gY52P0S4ZHxAfIaNAGI1G/1QtVzDTxu/VRQlZ4Or5oEGKBDOsitKpqQMkRDCTD4RWQdJda+JCbaWdPtTVIlGDOIIUrni9WS8wmVLHSLiX180dAffG8UsyRW7nEZX6T4Uepl8V+iKBiYFGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yc5UZS07GBzMeHrRtGn3NGdIjcpsJDk8NSBGo8hT9cg=;
 b=MiE/OXKA8jDWaPaC9+4g4GIi1775W5XhJg95uc4XtAj2uhvDzGAdvRnZr7zCjwGTf3vcs46TzJ6MqV6Ds8wKqql7HIT+83dsqnUT9F1UY0vUxRKT8efLXf195hJH9VTuSXkXdUyZi5Gsr+zHXmVWCMXC+49eumlwFW4+p0kggOw84di1ilkxabt5PrJNomZuhcc1kD4uacpwg+KltM1TjMkzxa2NiG/Diz3WI8RIk+HHeD5uW6VYs0LjIOmNBhUMke9LzNVxIK2qCGFoAHY++ZBW9In3hwiMh8Oc1sfrfaKjDiL6uB+cqGXJy/SZmTBOVIUjIF2TsGG3K8ZSvMh2vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yc5UZS07GBzMeHrRtGn3NGdIjcpsJDk8NSBGo8hT9cg=;
 b=uyGvkwXkYCMvQPrVTZXxEVpJQT5xpxazc1LfK3RP24IkMQRjsxrTAfNMqMLpQ9BPLGvo6LhwASyhau+2o4YDoFsWSCXw1DRkkIOWYlgO1VL/XEBA3iPqEkBbrQgivbWvbeCAStsyCxKNCfWA6z7G6vJME9UYLq7Bsm8sWAlYvFI=
Received: from DS7PR12MB8348.namprd12.prod.outlook.com (2603:10b6:8:e5::12) by
 PH8PR12MB7207.namprd12.prod.outlook.com (2603:10b6:510:225::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Wed, 23 Sep
 2026 17:03:35 +0000
Received: from DS7PR12MB8348.namprd12.prod.outlook.com
 ([fe80::68b0:8811:d3fc:aeaf]) by DS7PR12MB8348.namprd12.prod.outlook.com
 ([fe80::68b0:8811:d3fc:aeaf%6]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 17:03:34 +0000
From: "Han, Zhen" <Zhen.Han@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Hou, Junhua (Richard)" <Junhua.Hou@amd.com>, "Han, Zhen"
 <Zhen.Han@amd.com>, "Yang, Philip" <Philip.Yang@amd.com>, "Joshi, Mukul"
 <Mukul.Joshi@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Zhou, Tony"
 <Tony.Zhou@amd.com>, "Li, Chuan (Richard)" <Chuan.Li2@amd.com>, "Russell,
 Kent" <Kent.Russell@amd.com>, "Tudor, Alexandru" <Alexandru.Tudor@amd.com>
Subject: [PATCH v5] drm/amdkfd: correct vram_available calculation
Thread-Topic: [PATCH v5] drm/amdkfd: correct vram_available calculation
Thread-Index: Ad1LfFJ43S1TL7gdR++NLZMnxS9u6w==
Date: Wed, 23 Sep 2026 17:03:33 +0000
Message-ID: <DS7PR12MB83488299309DFE280FC0D7398D822@DS7PR12MB8348.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-09-23T16:55:00.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB8348:EE_|PH8PR12MB7207:EE_
x-ms-office365-filtering-correlation-id: f1ba6efd-5ca7-4ca1-51ae-08df19949a0e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|10067099003|56012099006|11063799006|18002099003|38070700021;
x-microsoft-antispam-message-info: 3cCI31suEr3z4Ix++kN1++K/Dhko3fULW7s2ca8iN3kzIWnn1mGDIs9Y2GU2xhDKvIbpUM1YkS8PZbC8JqCCMtlyHuAo+azGco37QmSwpWP0ii99iKXZtHIk+bDl7IoylNRl+D/xV35DybsGxvlMvZd/hoje+LfCiyEcbKt6NoL0Blw5ntwO0Gg103RADKF011dySzeCt1OduYvEDaD2Rc3Pbrl22IxMXdkTmt9N1Iy/gqComGUkiSDZ4BDApDtDuhymAMOpZy2lTcjqfc5hkAF0qS8RXEliu5VkiuQLCBzW2k1ZHSbuaOMh8mfczmyr9Spiv0QVRQ3FVwFxLLxiaSI9kkou4Rxd6n15OAzjZleqanhijCMH2KGFdBevP4qzrYHqwd6ga5d2ftkDH0b2mWVvbxA/MIx8vrFrNqckbsPxB6LDyQ0+grEsz5exzEYOT5PglTyfna8B4kCwXiFTcCCedw1ZGuHlTInl81HZsrhtxhshhdhKMk9l6PwmOTinixmia+zmQ2V04HLo2tZDPocUHohPoVK4fDWLIQ2ak7fWFc9uY7MgTJu9aIiI4CJqMNstBvVRZDegXUwJrn6JVG81XnWpY5lzNLvOf4nHpnQeWRFN8WAOqAxSKMNehcUaSQlRkDOVtQuEQwcAUtkpSCQeXDIj9wzOys7iR3xzypeaSKlvzzx11WwJG1eD74Q5AOFNPEyS7VkIGRH8XvG0vQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB8348.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(10067099003)(56012099006)(11063799006)(18002099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?OBgNnWcRv28jkhZX9apaOJdSumA7Z0C3kVQSD/4ucvlHptueHZR8JppKsVc2?=
 =?us-ascii?Q?StUvgUgFLT5YGGptPEpC7o/pbcbhaYtxfKGDMETHjxIsh9tMS/Q7WYE0z7gQ?=
 =?us-ascii?Q?NdVefmais5RO+MPr68i5SLJUeGcrmdghCmyL0U/ImjNiNFLPKlGgmbLLmAok?=
 =?us-ascii?Q?Ely7VPjZsWzcgCPpc0EDLF3jQpc4W9cqO5vERU0uXJsQNMFeobgwD6Nj2Wep?=
 =?us-ascii?Q?by77OWjPtkR1y3sar9/tMHmFuQiTathCuL/MnN1noltCceA5s70ainhfhaBW?=
 =?us-ascii?Q?leh3v7muJ6ANoKPsSkLwRz6JpanyNb4fEKUFd0YsNW9K2BajkDTqLNrgEO7T?=
 =?us-ascii?Q?flFm56khT0NQd2gEFihg+WAGKcg+650XtAX7ABqxTW1GbBnuzXR65SAjWDjB?=
 =?us-ascii?Q?5bVjzkoFfFKh6HRDZLICIbSTbu7pSh8hg2m/pWfqPn7tMawyHnr6f0KN0Rko?=
 =?us-ascii?Q?NvMmZap/KWHLjSy3bMxkJ9TsnBr2/zBq9PWVAqV+UP+viyD0I93+7G1JRNWt?=
 =?us-ascii?Q?4EPWADfsexGaxb0j6cGgXRGaeSEi9ossQhMxmYvMm6eprVpl0uYuu2iIhjk3?=
 =?us-ascii?Q?HoajcFlsaEYP32gaM2Y8CtC4RF2GRMnCcIfpTMNtqm9GSYyqc/+QELEUmmer?=
 =?us-ascii?Q?kb4lhWb7hpjqEkEezQj9SEQIIuerOFE+t663F+mtnW1Zmn2bhen9ARuylpsa?=
 =?us-ascii?Q?PK7VXjQ2+xAcysBrfmW1Y04pZA/LxhR1NwAAaYRUBpSb/zLPzHL4RzQS6T+X?=
 =?us-ascii?Q?0ySIFrfzLmPxv0Gv7DTctyyum2q90JYThHkTrSJ70wxGU5LGAjsaWJb1fYYZ?=
 =?us-ascii?Q?sxi3vnlsy+XsIjae695kSVugEUrKmGpXRZI6rRN53N6W3Y/5h44e+pg+JH/0?=
 =?us-ascii?Q?4iCOX9qpysmg7vnQ8mp4LLtSixOSJJEAikWY3EIBTfH/R+lDJTaoUuZ9RuIS?=
 =?us-ascii?Q?JhyrO5FLnkPv4Bblp2/eRIRpAJMVJxH8yv9n5qWw3FPGgBPlRnAIhPpkPSTd?=
 =?us-ascii?Q?x8uxVnhZs4bKRF0rjagHyGN+6TUfXsTp5baXqZ3rj4WLC23Vp35psA/YsELA?=
 =?us-ascii?Q?uRVakqMXtTjp/ReoPOd2QfrkWv/4JEQZYykZELZFrMf0Hki8mlVJO8LuTwAT?=
 =?us-ascii?Q?hRMivy+FbD/FEWdtZs6jc0HjbV5ABT2SuZiYOGoUmxycdBSMg9YRRPz/U873?=
 =?us-ascii?Q?T060O7Yzo7mUS50e1Hg5FeSCCnNs3d5Q0f3BYOzsRXf3fSyoqsd90V4+gFQW?=
 =?us-ascii?Q?xvQfv5mAUH9tE+Avl6m1AanYD2FdNBDdiaJGaxxTDRIkS+G4lVfCI8X6n0mK?=
 =?us-ascii?Q?4LSi9y5bz0304Acqmxd0GmRasGbG6c7o2qwat54ztc+UD6b+LitwX5Oa6gwJ?=
 =?us-ascii?Q?tnjuguFmY+P57tKt3wHqIKfWIucT9/aJ6J8ph5L9P6Rflh66eVpq1BoHnaKE?=
 =?us-ascii?Q?YKKOkzS4WvsXdXbQcHZGQTb75YQr6lKe0uitGCtvaQ+hQ+R7rA/ajMiywPTC?=
 =?us-ascii?Q?FH0uYKO3gcro4kYCcgtu4eWQdd+irpaQKz/jbeQwit0nYXyXusW7J2MwTVPW?=
 =?us-ascii?Q?/4gSlBqR79MNa3RSSr3QSBq9Iss2tHLfPzlYAhyaBqWreSPv3baXng2+tnH+?=
 =?us-ascii?Q?wpCNWoIJc7B1bREEY3E0/EaoRAmIhgHw975QJP67uUgUFRWM2G8xLGr+J/Do?=
 =?us-ascii?Q?0p+Moi/l/WMyTrTHeTGuOVb6Ay+TwC2H38Lyrb7ocbiu4PKc?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8348.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1ba6efd-5ca7-4ca1-51ae-08df19949a0e
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2026 17:03:34.0085 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sLO92kCIzqAMhZRKjpBbvBFDMBimg7bWnAOi3JD2BOizgU3LIe8J/9kvvkKfZhfR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7207
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

reserve_mem_limit() computes available VRAM as
        vram_size - reserved - vram_pin_size - kfd.vram_used
However, kfd.vram_used already includes BOs that are later pinned.
Pinning does not consume extra VRAM. Subtracting vram_pin_size counts those=
 bytes twice and causes fake-OOM while VRAM is still free. A KFD BO reaches=
 the VRAM pin path through the P2P dma-buf export, through the dma-buf vmap=
 and through map_bo_to_kernel().

Reuse get_available_memory() in reserve_mem_limit(). Move ALIGN_DOWN to the=
 ioctl so the userspace ABI is unchanged. The VRAM counter is a parameter: =
the ioctl passes vram_used_aligned[], the gate passes vram_used[] so a 4K B=
O is not charged 2MB.

Add kfd.vram_pinned[] to credit back the bytes that vram_pin_size already c=
overs for a KFD BO. Update it from amdgpu_bo_pin() through a KFD helper, on=
 first pin and last unpin, matching vram_pin_size, so every path that pins =
a KFD BO in VRAM is covered.

Track per-XCP pins in vram_pin_size_xcp[] and kfd.vram_pinned[].
Pins that are not owned by a single partition go to vram_pin_size_common, w=
hich every partition subtracts.

A KFD VRAM BO always carries a partition, so the KFD credit is only correct=
 for xcp >=3D 0. Call the helper for both branches and let it warn once and=
 skip if that ever stops holding: without the credit the BO would be subtra=
cted through vram_pin_size_common and never added back, which is the double=
 counting this patch removes, and kfd.vram_pinned[] would be indexed out of=
 bounds.

Signed-off-by: Zhen Han <Zhen.Han@amd.com>
---
v5:
- add the kfd.vram_pinned[] counter. v4 read it in get_available_memory()
  but it does not exist in the tree (Mukul Joshi)
- track pins per XCP in vram_pin_size_xcp[]; pins with no partition go to
  vram_pin_size_common (Philip Yang, Lijo Lazar)
- pass the VRAM counter into the shared helper: the gate uses vram_used[],
  the ioctl vram_used_aligned[]
- WARN_ONCE if a KFD BO reaches the VRAM pin path with xcp < 0 (Tony Zhou)

v4:
- use get_available_memory() in reserve_mem_limit()
- move ALIGN_DOWN from get_available_memory() to the ioctl
- drop v3 extra call in amdgpu_dma_buf.c
- update kfd.vram_pinned from amdgpu_bo_pin() via a KFD helper

v3:
- update kfd.vram_pinned from dma-buf pin/vmap and gpuvm_pin_bo
  on first pin / last unpin in amdgpu_dma_buf.c

v2:
- keep vram_pin_size; add kfd.vram_pinned in reserve_mem_limit (Mukul Joshi=
)
- leave get_available_memory unchanged
- drop former 2/2 pin/unpin changes in amdgpu_object.c

 drivers/gpu/drm/amd/amdgpu/amdgpu.h           | 11 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    | 19 +++++
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 85 ++++++++++++-------
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c    | 33 +++++++
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      | 12 ++-
 5 files changed, 127 insertions(+), 33 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdg=
pu/amdgpu.h
index 79b69d74eb2e..04151eab3b3f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -839,8 +839,17 @@ struct amdgpu_device {
        struct mutex    mn_lock;
        DECLARE_HASHTABLE(mn_hash, 7);

-       /* tracking pinned memory */
+       /* tracking pinned memory
+        *
+        *      vram_pin_size =3D sum(vram_pin_size_xcp[]) + vram_pin_size_=
common
+        *
+        * vram_pin_size         total pin size in device
+        * vram_pin_size_xcp[i]  pins owned by partition i (bo->xcp_id =3D =
i, i >=3D 0)
+        * vram_pin_size_common  pins not owned by any partition, bo->xcp_i=
d =3D -1
+        */
        atomic64_t vram_pin_size;
+       atomic64_t vram_pin_size_xcp[MAX_XCP];
+       atomic64_t vram_pin_size_common;
        atomic64_t visible_pin_size;
        atomic64_t gart_pin_size;

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_amdkfd.h
index 1b7dc0d3963b..f462b40220eb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -42,6 +42,12 @@

 extern uint64_t amdgpu_amdkfd_total_mem_size;

+/*
+ * Align VRAM availability to 2MB to avoid fragmentation caused by 4K
+ * allocations in the tail 2MB BO chunk.
+ */
+#define VRAM_AVAILABLITY_ALIGN (1 << 21)
+
 enum TLB_FLUSH_TYPE {
        TLB_FLUSH_LEGACY =3D 0,
        TLB_FLUSH_LIGHTWEIGHT,
@@ -106,6 +112,7 @@ struct amdgpu_kfd_dev {
        struct kfd_dev *dev;
        int64_t vram_used[MAX_XCP];
        uint64_t vram_used_aligned[MAX_XCP];
+       atomic64_t vram_pinned[MAX_XCP];
        bool init_complete;
        struct work_struct reset_work;

@@ -390,6 +397,8 @@ void amdgpu_amdkfd_gpuvm_destroy_cb(struct amdgpu_devic=
e *adev,
  * Allows KFD to release its resources associated with the GEM object.
  */
 void amdgpu_amdkfd_release_notify(struct amdgpu_bo *bo);
+void amdgpu_amdkfd_account_vram_pin(struct amdgpu_bo *bo, int xcp_id);
+void amdgpu_amdkfd_account_vram_unpin(struct amdgpu_bo *bo, int
+xcp_id);
 void amdgpu_amdkfd_reserve_system_mem(uint64_t size);  #else  static inlin=
e @@ -407,6 +416,16 @@ static inline  void amdgpu_amdkfd_release_notify(str=
uct amdgpu_bo *bo)  {  }
+
+static inline
+void amdgpu_amdkfd_account_vram_pin(struct amdgpu_bo *bo, int xcp_id) {
+}
+
+static inline
+void amdgpu_amdkfd_account_vram_unpin(struct amdgpu_bo *bo, int xcp_id)
+{ }
 #endif

 #if IS_ENABLED(CONFIG_HSA_AMD_SVM)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu=
/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index a5d1d83ee5d3..94c507bd52a8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -46,12 +46,6 @@
 #define AMDGPU_USERPTR_RESTORE_DELAY_MS 1
 #define AMDGPU_RESERVE_MEM_LIMIT                       (3UL << 29)

-/*
- * Align VRAM availability to 2MB to avoid fragmentation caused by 4K allo=
cations in the tail 2MB
- * BO chunk
- */
-#define VRAM_AVAILABLITY_ALIGN (1 << 21)
-
 /* Impose limit on how much memory KFD can use */  static struct {
        uint64_t max_system_mem_limit;
@@ -73,6 +67,8 @@ static const char * const domain_bit_to_string[] =3D {  #=
define domain_string(domain) domain_bit_to_string[ffs(domain)-1]

 static void amdgpu_amdkfd_restore_userptr_worker(struct work_struct *work)=
;
+static size_t __get_available_memory(struct amdgpu_device *adev,
+                                    uint8_t xcp_id, int64_t vram_used);

 static bool kfd_mem_is_attached(struct amdgpu_vm *avm,
                struct kgd_mem *mem)
@@ -169,13 +165,8 @@ void amdgpu_amdkfd_reserve_system_mem(uint64_t size)  =
int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
                uint64_t size, u32 alloc_flag, int8_t xcp_id)  {
-       uint64_t reserved_for_pt =3D
-               ESTIMATE_PT_SIZE(amdgpu_amdkfd_total_mem_size);
-       struct amdgpu_ras *con =3D amdgpu_ras_get_context(adev);
-       uint64_t reserved_for_ras =3D (con ? con->reserved_pages_in_bytes :=
 0);
        size_t system_mem_needed, ttm_mem_needed, vram_needed;
        int ret =3D 0;
-       uint64_t vram_size =3D 0;

        system_mem_needed =3D 0;
        ttm_mem_needed =3D 0;
@@ -196,7 +187,6 @@ int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_devic=
e *adev,
                if (WARN_ONCE(xcp_id < 0, "invalid XCP ID %d", xcp_id))
                        return -EINVAL;

-               vram_size =3D KFD_XCP_MEMORY_SIZE(adev, xcp_id);
                if (adev->apu_prefer_gtt) {
                        system_mem_needed =3D size;
                        ttm_mem_needed =3D size;
@@ -232,14 +222,11 @@ int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_dev=
ice *adev,
         * VRAM check since ttm_mem_limit check already cover this allocati=
on
         */

-       if (adev && xcp_id >=3D 0 && (!adev->apu_prefer_gtt || adev->gmc.is=
_app_apu)) {
-               uint64_t vram_available =3D
-                       vram_size - reserved_for_pt - reserved_for_ras -
-                       atomic64_read(&adev->vram_pin_size);
-               if (adev->kfd.vram_used[xcp_id] + vram_needed > vram_availa=
ble) {
-                       ret =3D -ENOMEM;
-                       goto release;
-               }
+       if (adev && xcp_id >=3D 0 && (!adev->apu_prefer_gtt || adev->gmc.is=
_app_apu) &&
+           vram_needed > __get_available_memory(adev, xcp_id,
+                                                adev->kfd.vram_used[xcp_id=
])) {
+               ret =3D -ENOMEM;
+               goto release;
        }

        /* Update memory accounting by decreasing available system @@ -318,=
6 +305,30 @@ void amdgpu_amdkfd_release_notify(struct amdgpu_bo *bo)
        kfree(bo->kfd_bo);
 }

+void amdgpu_amdkfd_account_vram_pin(struct amdgpu_bo *bo, int xcp_id) {
+       if (!bo->kfd_bo)
+               return;
+
+       if (WARN_ONCE(xcp_id < 0, "KFD BO pinned in VRAM with no partition"=
))
+               return;
+
+       atomic64_add(amdgpu_bo_size(bo),
+                    &amdgpu_ttm_adev(bo->tbo.bdev)->kfd.vram_pinned[xcp_id=
]);
+}
+
+void amdgpu_amdkfd_account_vram_unpin(struct amdgpu_bo *bo, int xcp_id)
+{
+       if (!bo->kfd_bo)
+               return;
+
+       if (WARN_ONCE(xcp_id < 0, "KFD BO unpinned in VRAM with no partitio=
n"))
+               return;
+
+       atomic64_sub(amdgpu_bo_size(bo),
+                    &amdgpu_ttm_adev(bo->tbo.bdev)->kfd.vram_pinned[xcp_id=
]);
+}
+
 /**
  * create_dmamap_sg_bo() - Creates a amdgpu_bo object to reflect informati=
on
  * about USERPTR or DOOREBELL or MMIO BO.
@@ -1661,8 +1672,9 @@ int amdgpu_amdkfd_criu_resume(void *p)
        return ret;
 }

-size_t amdgpu_amdkfd_get_available_memory(struct amdgpu_device *adev,
-                                         uint8_t xcp_id)
+/* Caller must hold kfd_mem_limit.mem_limit_lock. */ static size_t
+__get_available_memory(struct amdgpu_device *adev,
+                                    uint8_t xcp_id, int64_t vram_used)
 {
        uint64_t reserved_for_pt =3D
                ESTIMATE_PT_SIZE(amdgpu_amdkfd_total_mem_size);
@@ -1671,14 +1683,17 @@ size_t amdgpu_amdkfd_get_available_memory(struct am=
dgpu_device *adev,
        ssize_t available;
        uint64_t vram_available, system_mem_available, ttm_mem_available;

-       spin_lock(&kfd_mem_limit.mem_limit_lock);
+       lockdep_assert_held(&kfd_mem_limit.mem_limit_lock);
+
        if (adev->apu_prefer_gtt && !adev->gmc.is_app_apu)
                vram_available =3D KFD_XCP_MEMORY_SIZE(adev, xcp_id)
-                       - adev->kfd.vram_used_aligned[xcp_id];
+                       - vram_used;
        else
                vram_available =3D KFD_XCP_MEMORY_SIZE(adev, xcp_id)
-                       - adev->kfd.vram_used_aligned[xcp_id]
-                       - atomic64_read(&adev->vram_pin_size)
+                       - vram_used
+                       - atomic64_read(&adev->vram_pin_size_xcp[xcp_id])
+                       - atomic64_read(&adev->vram_pin_size_common)
+                       + atomic64_read(&adev->kfd.vram_pinned[xcp_id])
                        - reserved_for_pt
                        - reserved_for_ras;

@@ -1693,19 +1708,29 @@ size_t amdgpu_amdkfd_get_available_memory(struct am=
dgpu_device *adev,

                available =3D min3(system_mem_available, ttm_mem_available,
                                 vram_available);
-               available =3D ALIGN_DOWN(available, PAGE_SIZE);
        } else {
-               available =3D ALIGN_DOWN(vram_available, VRAM_AVAILABLITY_A=
LIGN);
+               available =3D vram_available;
        }

-       spin_unlock(&kfd_mem_limit.mem_limit_lock);
-
        if (available < 0)
                available =3D 0;

        return available;
 }

+size_t amdgpu_amdkfd_get_available_memory(struct amdgpu_device *adev,
+                                         uint8_t xcp_id)
+{
+       size_t available;
+
+       spin_lock(&kfd_mem_limit.mem_limit_lock);
+       available =3D __get_available_memory(adev, xcp_id,
+                                          adev->kfd.vram_used_aligned[xcp_=
id]);
+       spin_unlock(&kfd_mem_limit.mem_limit_lock);
+
+       return available;
+}
+
 int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
                struct amdgpu_device *adev, uint64_t va, uint64_t size,
                void *drm_priv, struct kgd_mem **mem, diff --git a/drivers/=
gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_obje=
ct.c
index fc6d3fa62d79..dc0ab5bc467f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -923,6 +923,19 @@ void amdgpu_bo_unref(struct amdgpu_bo **bo)
        *bo =3D NULL;
 }

+/* Map a BO onto vram_pin_size_xcp[]. bo->xcp_id < 0 means "any partition"=
:
+ * such pins are not owned by a single partition and go to
+ * vram_pin_size_common, which every partition subtracts.
+ */
+static int amdgpu_bo_get_xcp(struct amdgpu_bo *bo) {
+       s8 xcp =3D bo->xcp_id;
+
+       if (xcp >=3D 0 && xcp < MAX_XCP)
+               return xcp;
+       return -1;
+}
+
 /**
  * amdgpu_bo_pin - pin an &amdgpu_bo buffer object
  * @bo: &amdgpu_bo buffer object to be pinned @@ -1003,7 +1016,17 @@ int a=
mdgpu_bo_pin(struct amdgpu_bo *bo, u32 domain)
        ttm_bo_pin(&bo->tbo);

        if (bo->tbo.resource->mem_type =3D=3D TTM_PL_VRAM) {
+               int xcp =3D amdgpu_bo_get_xcp(bo);
+
                atomic64_add(amdgpu_bo_size(bo), &adev->vram_pin_size);
+               if (xcp >=3D 0) {
+                       atomic64_add(amdgpu_bo_size(bo),
+                                    &adev->vram_pin_size_xcp[xcp]);
+               } else {
+                       atomic64_add(amdgpu_bo_size(bo),
+                                    &adev->vram_pin_size_common);
+               }
+               amdgpu_amdkfd_account_vram_pin(bo, xcp);
                atomic64_add(amdgpu_vram_mgr_bo_visible_size(bo),
                             &adev->visible_pin_size);
        } else if (bo->tbo.resource->mem_type =3D=3D TTM_PL_TT) { @@ -1036,=
7 +1059,17 @@ void amdgpu_bo_unpin(struct amdgpu_bo *bo)
                dma_buf_unpin(bo->tbo.base.import_attach);

        if (bo->tbo.resource->mem_type =3D=3D TTM_PL_VRAM) {
+               int xcp =3D amdgpu_bo_get_xcp(bo);
+
                atomic64_sub(amdgpu_bo_size(bo), &adev->vram_pin_size);
+               if (xcp >=3D 0) {
+                       atomic64_sub(amdgpu_bo_size(bo),
+                                    &adev->vram_pin_size_xcp[xcp]);
+               } else {
+                       atomic64_sub(amdgpu_bo_size(bo),
+                                    &adev->vram_pin_size_common);
+               }
+               amdgpu_amdkfd_account_vram_unpin(bo, xcp);
                atomic64_sub(amdgpu_vram_mgr_bo_visible_size(bo),
                             &adev->visible_pin_size);
        } else if (bo->tbo.resource->mem_type =3D=3D TTM_PL_TT) { diff --gi=
t a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/k=
fd_chardev.c
index 7fcfc150a7fc..2295f9bcc5e4 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1069,11 +1069,19 @@ static int kfd_ioctl_get_available_memory(struct fi=
le *filep,  {
        struct kfd_ioctl_get_available_memory_args *args =3D data;
        struct kfd_process_device *pdd =3D kfd_lock_pdd_by_id(p, args->gpu_=
id);
+       struct amdgpu_device *adev;
+       size_t available;

        if (!pdd)
                return -EINVAL;
-       args->available =3D amdgpu_amdkfd_get_available_memory(pdd->dev->ad=
ev,
-                                                       pdd->dev->node_id);
+
+       adev =3D pdd->dev->adev;
+       available =3D amdgpu_amdkfd_get_available_memory(adev, pdd->dev->no=
de_id);
+       if (adev->apu_prefer_gtt)
+               args->available =3D ALIGN_DOWN(available, PAGE_SIZE);
+       else
+               args->available =3D ALIGN_DOWN(available, VRAM_AVAILABLITY_=
ALIGN);
+
        kfd_unlock_pdd(pdd);
        return 0;
 }
--
2.43.0
