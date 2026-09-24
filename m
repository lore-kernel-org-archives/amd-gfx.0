Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 748B3C9830D
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Sep 2026 03:30:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C2BC10F2AF;
	Thu, 24 Sep 2026 03:30:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0HAnErPu";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013027.outbound.protection.outlook.com
 [40.93.196.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CEA8C10F2B0
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Sep 2026 03:30:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZWPQxJACCBJaZRTUdsqOECxd8KO2gM+CY43j9/athB0ioJz/CSfAFJ5OII+jCbb4IchNS0IGVBsFWXiqIiquXwlee973h+ryJF1HLACa5YzAnFGT/FnPkJ8OUYtNy1jdU8K2WfjftiiavDhb7/TNzPB3tQvtw7n+w9o3hmmKQe02qPdDo7se0GaxqF13Ok/O/T2oKO5Y6r6cTjqln7ao2axAR8qKclhgWeC93KO+gcaUJ+T0QSnHPFx9wcY7+QLFrpCpEhu45iSe73Tyrhz62B82ki5HptGbl70SIH0+6YdCZGVtCOek7F2E2x5Mkop/kj59CUzSoHhliuCAlgPxIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wIzKOY2ACzbwSnj3V8FUTrecXd8iHx+8PkYmZ3ydkxo=;
 b=whnU5n9E0hhkBeBFo4+Dr54ajz4xgyJJUFy0CEDXnACXD8mOzLX5KaWTjtQJPTFfVgN2DQwGcZvcXeOYnFNF3FpBlUObz0nuKIY8DyECvmTli6ZrzengROmXDOMTkilT6PT2dXtui6Kblk4vzAsyqSRRWix1aCGgQKsLsb5lKGP3PHCvKGKJa+2/G8WRWS6rt0Iy0cyW2NHKZkA2PIogqAvJRUbHK5hrCPf+GY/7x8PCLTkTH2NeKOkL90JxbDV7X/qHB4HvxdPJxHvxibgZuun32zyqcW/TbEOrSKmznwgidhpFaXI4/zTB/pCgSmx5a6qHA6+a7DpCfaH8SGAV8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wIzKOY2ACzbwSnj3V8FUTrecXd8iHx+8PkYmZ3ydkxo=;
 b=0HAnErPuCENfi7+rZQiZb32cEmJUUo7SDQlOfNdNdgedArWbkxRdLZ/vMp6qfLAZM71ZywVa3WbmPSMOtwgMdOaKBjG3V84y8ETQiRWJmX+qZoldD4Upe/NMQSX1d1LrygBezI7Ir2eUoBT/C/XdC/BjXisdEc1e4BFzAek76As=
Received: from DS7PR12MB8348.namprd12.prod.outlook.com (2603:10b6:8:e5::12) by
 CH3PR12MB8970.namprd12.prod.outlook.com (2603:10b6:610:176::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.17; Thu, 24 Sep
 2026 03:30:38 +0000
Received: from DS7PR12MB8348.namprd12.prod.outlook.com
 ([fe80::68b0:8811:d3fc:aeaf]) by DS7PR12MB8348.namprd12.prod.outlook.com
 ([fe80::68b0:8811:d3fc:aeaf%6]) with mapi id 15.21.0451.014; Thu, 24 Sep 2026
 03:30:38 +0000
From: "Han, Zhen" <Zhen.Han@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Hou, Junhua (Richard)" <Junhua.Hou@amd.com>, "Han, Zhen"
 <Zhen.Han@amd.com>, "Yang, Philip" <Philip.Yang@amd.com>, "Joshi, Mukul"
 <Mukul.Joshi@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Zhou, Tony"
 <Tony.Zhou@amd.com>, "Li, Chuan (Richard)" <Chuan.Li2@amd.com>, "Russell,
 Kent" <Kent.Russell@amd.com>, "Tudor, Alexandru" <Alexandru.Tudor@amd.com>,
 "Wu, Cindy" <Xiucheng.Wu@amd.com>
Subject: [PATCH v6 2/2] drm/amdkfd: correct vram_available calculation
Thread-Topic: [PATCH v6 2/2] drm/amdkfd: correct vram_available calculation
Thread-Index: AQHdS9PxT975y23kg0C/CPlfdVS06bbdEX3w
Date: Thu, 24 Sep 2026 03:30:37 +0000
Message-ID: <DS7PR12MB8348EA535EEDD5E6EEAA62CA8D812@DS7PR12MB8348.namprd12.prod.outlook.com>
References: <20260924032211.3705774-1-Zhen.Han@amd.com>
In-Reply-To: <20260924032211.3705774-1-Zhen.Han@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-09-24T03:27:05.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB8348:EE_|CH3PR12MB8970:EE_
x-ms-office365-filtering-correlation-id: 2aad44b0-5dfb-4203-feda-08df19ec33b3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|22082099003|18002099003|38070700021|56012099006|11063799006|10067099003;
x-microsoft-antispam-message-info: /HdVgcfUC41moGW7jz4hteRmzSi/JH2fZWkwpiYDZDo4yvsUQcqtPzqVedCj9fsm+VBqbsRtEGbwplhw9L9dm7s8BjlYVTM1MylFLkBEBSwOeQWLsB1PhCNBMPxtulay5MoAG5NZd0HPC+uAs6Fd4ldQNd0jnTFytJ4MZAH4+F91C5McowjTjCURZNnTkoPxIQ2FRDgbcmXO1Jl+vWOZDlZsJIoXU6/OrAPX7pVVwEAnXivkkMPGUufGDsW/cr+FW51q2AEql8jXKRPaaK+rSzXUTqpYoG5e6XuY9qQXsTx1C2EFtw43JKOWOeLyOdaidglm7QMj3+froAex8+Hw6znkTgN5jpk1QGJhO7W7kHloBhGjnhvlIQ6vUmrS8T6XSUu91qAwInCZyew5hKpsDYz29aCtWM3kSkoF4ZUCUnmKbhpylxtixHkfwCGzLiGQSIqKMF4SHqaJ3Q1JtqX+t8WlvcbRxfylINgOdfwXss7DfKoH2+/X8ooKTqI5O8VWPLJtzj+7JnjAZMlvlz27zmc1cCEUUs+AOpsm7mc2jkFbbacuSKgnnSKQlEceiaSju1EkrR/T0OLWO9Fx0nxulac9iambJL5bKe5rR+eq4w4qVInviWjqYL0GvblU3FUKqokhMp93T/8t8mCoV9CJP5+NhFm1I/Tj84BcmRnqbzBZU8GGRFmyb2efvdEs8pW1zh6iRdFKRlxFkw/btOR75g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB8348.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(22082099003)(18002099003)(38070700021)(56012099006)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xok7EAycc6XcH3YVGCkHB0VcT15F4KCXjr6QGt4QXYmFuHglCbSGrC/jeALk?=
 =?us-ascii?Q?M9nKzIV3lM/cLs5cO3EQ6YinqN7qN45XaPp2Hf9Ky9t78lpGw6/fKV/xSMYe?=
 =?us-ascii?Q?g1pJ7L+HgoJqw6kgFYOvwONSkLAzEIdLaAMcWRCt/ayZvhmY8GUPRTqbbYgA?=
 =?us-ascii?Q?e0e4dzdhR85I7Qsrby0zwQE2aR8+gqkMZ9YbP4zH1W1/WjlOV1b1HHxNeqHK?=
 =?us-ascii?Q?3iv7vmc4ZIo60JWdJE/z0RyRwA009gekEH99VPo6Bi8GFUN2gfBwNhhg9Q3s?=
 =?us-ascii?Q?H/jdnrKYZHHZeDrOd4oJ8W2PdWp4PqfVcRcXsaPxJhEqF7Z9y/5hMmB2GQGA?=
 =?us-ascii?Q?C+p9dwRy79JbmLuI9a0kzaI+PsOFP7mRVlFSHnaZujVS1XNUXnN+nHqNRxHF?=
 =?us-ascii?Q?NpGXKCKOkVrtdSH+aXUF9tfZSiHPW7aQIWn3kBVxBeet6HMYSsl21qVvwFsc?=
 =?us-ascii?Q?JTdm4WvZ/tpRKxTnY4zWyBvgOSOfbx7Pzyk6APDOi0O7zK5VnqtHaH4P2ra4?=
 =?us-ascii?Q?uZ2sh65KTyLa8hOmc9D7E/v6gFCsKz3oDrio5GaHVOCehwQgiqUWUktWPEwu?=
 =?us-ascii?Q?Pa6TTqQyG4YOgoJ5p2Q5xvCR6AaXhEt2yF4tsGU9KvDVwIyQw3C8yjM3CwVG?=
 =?us-ascii?Q?5yzuJZy8JwpZ1lS65qS2GE6xpL93XNJIc0OaArbFM8Kajaz0dXHPEBNjkl+q?=
 =?us-ascii?Q?QFqtKVtqcHQBCPoTBII17tJZ4u3EH9bnMRqoSWPeUP/7gJDHGPzUeHFpyeY3?=
 =?us-ascii?Q?T1jhZSJmtl8eFD8PPWRZGXAOG04HlR4QJDtA02D8e4QtOnsrisHQ7hNRfqgh?=
 =?us-ascii?Q?UgCnvYgHyLQXzGBHYXGWHlTjs5VyTLEn6dcElavEhZEIlYSEcQFRfiGPME03?=
 =?us-ascii?Q?wGRpCB3a5Ozpzx2Ayg+KbFkJzgY5n8aniV9zXpXY5+CYlHqUDNXAEfPs0A6Z?=
 =?us-ascii?Q?3rJNNFKGggSX0MhQOJeJiO6qyWcy2v9DNZHF6PmXLgaSonfRiumCcUXSVdqH?=
 =?us-ascii?Q?Db2b+sx8QY7rXdkfFeiiCOQI3Dd+6xYXmrA3lO3Z/qM0ZFBrlkHMHt0CcTvg?=
 =?us-ascii?Q?WmcS/UviduaIRXNqTRjdXd6S/g+7vJWZUj261C2fMCsff9jc0ToBCI7e9WmK?=
 =?us-ascii?Q?lVnHNoMrqd/VXZJZW5z/PK+N5d1bMIqxjECJWokCPGAEMbnvVfeJiRh+R/OI?=
 =?us-ascii?Q?ypI7GscGPn7oguA3IpCAhjtFj019dpE5kx6Z3Srx9IzMnlLGStJHh6QSipbn?=
 =?us-ascii?Q?dN9tIT57jxS8ZaoO3IrHpU19Wl4vaiNBRHDTC1cQvVdSKTxkCaBPkc+dZtHo?=
 =?us-ascii?Q?FMVb/u2v49vWnT3aBbzcQSzQaskr6iZHfROS95fpxAKACylSKvPc/Clekpe7?=
 =?us-ascii?Q?8c/mZ9M24sPm/I2rnBTDTCZhVsYTfsmmuikNkV8xwXwTG6LWcDBA6PPHrTOG?=
 =?us-ascii?Q?PEK9wEaPDsIMoPHmaN5KEZIHj7k1ihMHVo81JRho4Hfp8mn8YGOiTIbW6ytm?=
 =?us-ascii?Q?fLkRpr4DsA54CF3OVsKNDiicYElW9IdqcHf8VfFdUug4y0VzqUqKGmUCjKnt?=
 =?us-ascii?Q?PgNGydbyJPTbFKcfkUxkIaHhQYD02ruLOScqthjvt4ptckm5I6YQBf+2B2BB?=
 =?us-ascii?Q?yUUx5GFAip+80Y72M8wlRIsL0GV07Hm2ZFHUrM5faEeZSIqVFSEmtWFR9qmM?=
 =?us-ascii?Q?bsY1zRnqxMFugE7qrRbUfdgPz3AgS1vPJBnZDKKd2oMoWyHz?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8348.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2aad44b0-5dfb-4203-feda-08df19ec33b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2026 03:30:37.9943 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q7Ejoz7Q+CFjntR1Sorw4h4r2VyWyNb42xD5GLZLrLj2pCFRWTxWZbeh1k2LlvM9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8970
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
        vram_size - reserved - vram_pin_size - kfd.vram_used However, kfd.v=
ram_used already includes BOs that are later pinned.
Pinning does not consume extra VRAM. Subtracting vram_pin_size counts those=
 bytes twice and causes fake-OOM while VRAM is still free. A KFD BO reaches=
 the VRAM pin path through the P2P dma-buf export, through the dma-buf vmap=
 and through map_bo_to_kernel().

Reuse get_available_memory() in reserve_mem_limit(). Move ALIGN_DOWN to the=
 ioctl so the userspace ABI is unchanged. The VRAM counter is a parameter: =
the ioctl passes vram_used_aligned[], the gate passes vram_used[] so a 4K B=
O is not charged 2MB.

kfd.vram_pinned is only updated in gpuvm_pin_bo(). dma-buf pin calls amdgpu=
_bo_pin() only, so the counter stays zero. Update it from amdgpu_bo_pin() t=
hrough a KFD helper, on first pin and last unpin, matching vram_pin_size.

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
v6:
- rebase v5 on patch 1/2, which adds kfd.vram_pinned (Mukul Joshi)

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
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    | 20 +++-
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 94 +++++++++++--------
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c    | 33 +++++++
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      | 12 ++-
 5 files changed, 127 insertions(+), 43 deletions(-)

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
index 056dd7375d24..f462b40220eb 100644
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
@@ -106,7 +112,7 @@ struct amdgpu_kfd_dev {
        struct kfd_dev *dev;
        int64_t vram_used[MAX_XCP];
        uint64_t vram_used_aligned[MAX_XCP];
-       atomic64_t vram_pinned;
+       atomic64_t vram_pinned[MAX_XCP];
        bool init_complete;
        struct work_struct reset_work;

@@ -391,6 +397,8 @@ void amdgpu_amdkfd_gpuvm_destroy_cb(struct amdgpu_devic=
e *adev,
  * Allows KFD to release its resources associated with the GEM object.
  */
 void amdgpu_amdkfd_release_notify(struct amdgpu_bo *bo);
+void amdgpu_amdkfd_account_vram_pin(struct amdgpu_bo *bo, int xcp_id);
+void amdgpu_amdkfd_account_vram_unpin(struct amdgpu_bo *bo, int
+xcp_id);
 void amdgpu_amdkfd_reserve_system_mem(uint64_t size);  #else  static inlin=
e @@ -408,6 +416,16 @@ static inline  void amdgpu_amdkfd_release_notify(str=
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
index 5a4072792a57..34cd791d826e 100644
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
@@ -1537,10 +1548,6 @@ static int amdgpu_amdkfd_gpuvm_pin_bo(struct amdgpu_=
bo *bo, u32 domain)

        amdgpu_bo_sync_wait(bo, AMDGPU_FENCE_OWNER_KFD, false);

-       if (!ret && bo->tbo.resource->mem_type =3D=3D TTM_PL_VRAM)
-               atomic64_add(amdgpu_bo_size(bo),
-                       &amdgpu_ttm_adev(bo->tbo.bdev)->kfd.vram_pinned);
-
 out:
        amdgpu_bo_unreserve(bo);
        return ret;
@@ -1564,10 +1571,6 @@ static void amdgpu_amdkfd_gpuvm_unpin_bo(struct amdg=
pu_bo *bo)

        amdgpu_bo_unpin(bo);

-       if (bo->tbo.resource->mem_type =3D=3D TTM_PL_VRAM)
-               atomic64_sub(amdgpu_bo_size(bo),
-                       &amdgpu_ttm_adev(bo->tbo.bdev)->kfd.vram_pinned);
-
        amdgpu_bo_unreserve(bo);
 }

@@ -1671,8 +1674,9 @@ int amdgpu_amdkfd_criu_resume(void *p)
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
@@ -1681,15 +1685,17 @@ size_t amdgpu_amdkfd_get_available_memory(struct am=
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
-                       + atomic64_read(&adev->kfd.vram_pinned)
+                       - vram_used
+                       - atomic64_read(&adev->vram_pin_size_xcp[xcp_id])
+                       - atomic64_read(&adev->vram_pin_size_common)
+                       + atomic64_read(&adev->kfd.vram_pinned[xcp_id])
                        - reserved_for_pt
                        - reserved_for_ras;

@@ -1704,19 +1710,29 @@ size_t amdgpu_amdkfd_get_available_memory(struct am=
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

