Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 912C3C79F9F
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Sep 2026 13:18:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 27EB510E57C;
	Thu, 10 Sep 2026 13:18:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dhsjafai";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013033.outbound.protection.outlook.com
 [40.93.196.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A6BD110E57C
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Sep 2026 13:18:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fdOFnplrn4XAn4KKbyxX6fOsBGXFI0Gr2+lhAJGWqhkzMxxhIRa7jGP7+9AFqPm8FhL54EyOfKAjhrYzgvCPnihVl70/JLoPOyTL1Tv0ssemecYN9yQ11VxKioJ1jO6Yi0iuvDuB/W43ejmvIitJDhacURIvRuVNH/JGSFPnewkWjPL25S9fGnAbpFqA2cSasyCCYsh3Yj0zWXpZkSvM9lvI0cFgV8LSoIHw9n3xp3WH6BGo05NzUG/5U0iOLKytYJY8DnmEzz8qZG6IqaSrxR2VPu+bqPk4Lm7DYufHCwPon9KC0+OwHd9zsusZFykeKk5U6mT+QRF4eOSYwAHp+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3YITRL+SAMzf4CM44Ksx25gFNaF1wqNDaTvORRuJll8=;
 b=oWuVsaWzYhNf7lJQLBzjZque1JtWWRTMfEtzIptZwQhsNxX0xLVIlL6az54E8NDf6kpmigmnE3uH7z84JvApiWBnoHSewHuw1Ik2nf64Y9QRlodeplpLhSjWdsFeCl5dRPiDS2ub15EyMrspHJAASaja0HIqgxbdlL7+nE/kdAXRKlSR7OEWzZJtSRIVEKyZOTRY6A8/y5SDTTyCERYcqI6izxnjjhzyZVyj0Luz7remlBYbAQu7XCUx22wE5RFFyxBv67YW+G7+argLh1fh3ERrAjQgjJPULV6QqTqthA2oTddtn7rBxoGdyOXHVEoGxx3oszO5Fi9Zn7Pb5bXPlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3YITRL+SAMzf4CM44Ksx25gFNaF1wqNDaTvORRuJll8=;
 b=dhsjafai+P7fdtXdvVPHAUa2UwW/qxqBgDhZA9o6TPg1rnYgp1nU/VF+JYJ3ffu0hbiPlrAb9/tB7r3Lq+Ut1Uwx65dqtM1un0Io4QrdgGj+rBzgZsUruQYPdDNCfYA054adTiGXPjzysGfkZGdyM3mKR0ANPJal/YKEHmhx/Uo=
Received: from BY5PR12MB4321.namprd12.prod.outlook.com (2603:10b6:a03:204::15)
 by BN5PR12MB9511.namprd12.prod.outlook.com (2603:10b6:408:2a9::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Thu, 10 Sep
 2026 13:18:30 +0000
Received: from BY5PR12MB4321.namprd12.prod.outlook.com
 ([fe80::1b9d:14a9:e7d2:7057]) by BY5PR12MB4321.namprd12.prod.outlook.com
 ([fe80::1b9d:14a9:e7d2:7057%5]) with mapi id 15.21.0406.007; Thu, 10 Sep 2026
 13:18:29 +0000
From: "Han, Zhen" <Zhen.Han@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Yang, Philip" <Philip.Yang@amd.com>, "Joshi, Mukul"
 <Mukul.Joshi@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Hou, Junhua (Richard)"
 <Junhua.Hou@amd.com>
Subject: [PATCH v4] drm/amdkfd: correct vram_available calculation
Thread-Topic: [PATCH v4] drm/amdkfd: correct vram_available calculation
Thread-Index: AQHdQSWOmrRNkSEoT0iornxcewC227bHyrUA
Date: Thu, 10 Sep 2026 13:18:29 +0000
Message-ID: <BY5PR12MB4321E7F91BC20C40F47031808DBF2@BY5PR12MB4321.namprd12.prod.outlook.com>
References: <20260909090756.847617-1-Zhen.Han@amd.com>
 <20260910130905.761369-1-Zhen.Han@amd.com>
In-Reply-To: <20260910130905.761369-1-Zhen.Han@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-09-10T13:15:50.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR12MB4321:EE_|BN5PR12MB9511:EE_
x-ms-office365-filtering-correlation-id: f5eea20b-7b7c-427b-dd1b-08df0f3e015a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|38070700021|11063799006|4143699003|10067099003|56012099006|22082099003|18002099003;
x-microsoft-antispam-message-info: yVBTft/1AqeGOmW1aU99BFnxnqDpHOHe8Kic65JHaNibNpES57TlCBQsPtgChFAV7BSoK/WAvMhi4XHNC7TuEpNaKemCi/EJmbrlNDubszWysEDkH3SJ9IPYBm0AsbXfl6xQjKcMn0qwBHHXQ9lh8xLxZd8G9x8uGJt7OIyJNn5jbC9u6DOiIP/IokyvGYACHZm758b7PvKa2i0MkntIyHb9iEDLjTrQT+aWv22AVBqXLLkWHPglEX5xYQAlP2sbbL9/18OzcWHGqQ02ZdkWzp07T7RPZ+aWD2SxBvGS0yOHU5O2+u5p7d67NxGEvUA8YpfZa4HO5Uva3vqfFug9pL7AgCzlR7CNncmuQnbKLQAQZswPYgm8ada5Xzdqkw5UXtj5KgHmi/FClbu4wbUNCewpGhMGFo/08rSxvXbLEaDh7Q+ANl94ldtIwiL/FwUlL4M7A+CgEkpL9aTPw2F4QIS5GlLe8zxMrDMlUM0BfvorV7TdxxV/QLIO9lDSVUabnW637fREj39fslyyPOfVPOfa16sUIALdYx1wiw5zoXmTTXQTv6eUJ6XMX8lxsW27vn5y9MmWazMkOkAxrxIWNjh4TQEOnbrrmEL0AyjOC8OD32Xsmh7ftVdpZY6w8tARtnVZLCQpZJXTGYicHQsB5FAqSWWJRqw+Q6UXrMGXRECcFwvWUZRMeTFsf5upWoYYs4z2OAp+vY0JpFnwoV5EGc1joQEon88HVNOsNDy7h3E=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4321.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(38070700021)(11063799006)(4143699003)(10067099003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pIm/eJ3TnS0upXgyiqX0nWbYRu11Fo8Z7pIFSniBvEs9BC8PJeiuhIa96fCu?=
 =?us-ascii?Q?aIIypM/SvHKigPA1LMvTcC3j6ef1gPklqofBxydeQ7EpNEANrBdzkCm9SB4F?=
 =?us-ascii?Q?69ejQJprUT9PKplcq6gUE5fmDHUePImGRqpLLghMM9EG9oMk3u4PZHrthvhA?=
 =?us-ascii?Q?H3l5LV333k1ovjMJiVNDBYTigp3iHKeBny3jmD4JhAscFJv5BKhugTa/h9nO?=
 =?us-ascii?Q?dGeJyjVu2vNl5BXK9SMD4nI1GwvvywE7Ez8rxGXjtH+LAQEky19ajcfX0EZz?=
 =?us-ascii?Q?uerpYWUTAjkeQeLE3JGY/vULu6NgYF5zYQGWROIaYKks0F9w23QYez4AYOsP?=
 =?us-ascii?Q?47OXK0pNYJkVKk4TbIkaBy6qV0K2xv3yPT2uyq4bIH00ZEJXCR64mBb9IHay?=
 =?us-ascii?Q?06Xf/1w0v4m5LxCaq9vIKuVTRBl+k9vKTfeUwZHuA714QcEmN+rkxRPQxVU7?=
 =?us-ascii?Q?WGOoQWu9iBrUUu5E4dN/dhVveukpxfOQ2sS9E9D1TCBOqXzZ2cfAh6x+v1HI?=
 =?us-ascii?Q?cP5aEYUznToArxGacaymaSymvy30krpV7AP0duzUMiae2SGZIZKx79DfmsP3?=
 =?us-ascii?Q?CZQavE5PHl8/f+zpbteNoeGYFyUm0xAEAHaXl+hr1ZIaBesgTJRCQB7RiSew?=
 =?us-ascii?Q?Bbqv+CVig4uyLhs+KEFakxfRu1dvaSxckG5iJbitt0QhaG5+DhkCTiuEklac?=
 =?us-ascii?Q?gjtNdgnUK7HXsIo4QvEYKutSk7Ef0iuBknOehQfIPd1bVgMtH+ZbY6cb1IzY?=
 =?us-ascii?Q?tDe1hMutMoGt88jQKksB8K9yOYxmutzGZAmWOgHxEuMxuR3+8RPozEiKTwlS?=
 =?us-ascii?Q?Hb4HhJC+3K6fCRyOQM0cMfKaNAlU2KgUMlxZM0O11ZY1Bzz5c44LpMRKD+nF?=
 =?us-ascii?Q?iAclFLMXo5mkzHVgQ9BP3+LkSAtAww/i88B1OwR4LveLs5fDBz0x3D4VVSgh?=
 =?us-ascii?Q?rLzTnR25oFnQu0s9Tu0g4LG9C5Io3D8tSafmTwKfkmBN4typ2PXu/tHhkczv?=
 =?us-ascii?Q?Kyzxx0so4laWz+4ZFI2j3raf4iaN5X7LuVgCURRa0h+GBR6xxZ2wJ6oGIUS6?=
 =?us-ascii?Q?mabQz6StpQtyg0Ul160jMzjcBpInEYupFUUTOuzPD92yu1LOsZciKMa2xXKp?=
 =?us-ascii?Q?HWStYdzCpSvNrQ0c04CWa4htD9+L46y+GFAvIbQwpt65L7TApUpuwtdpKlfx?=
 =?us-ascii?Q?M/uRjdv79HiQArs9mWxmfUxZxYGbGDbh6M1sF9VJj05fPofHXqrzJnvAuQdc?=
 =?us-ascii?Q?jgQ7Bm8EPfoA1g2fdSAZQMX5w9g30HUc/2hSPNZ2GH2S0wTi7ZPXmB6imZ14?=
 =?us-ascii?Q?aR8+S8Dcm3KE8p95tGJJgC1wCBwUXlT4K610U1DQB88aGeHm5NODrgjMFYYY?=
 =?us-ascii?Q?rZOENbVeV6oiuKtekWaK66NgR2H5WXG2czW6malXRth0f5cbmxgN7JCsx/nG?=
 =?us-ascii?Q?3miY30BKCoHzRazmUtn6/bTRCvklpYECyiLCLlAd6gDLkP3vYrDhyJORfJtq?=
 =?us-ascii?Q?oBy+ghT/4BzZZ8kfBro5ciKvwj18sEkNdbDTIwp0cKsJkPZBONUdFHfl1SbW?=
 =?us-ascii?Q?TY7k80RqcuwdpRmpA/oW8wUyTYibhvVbVDWJ8Ig98tFm4aWKU9hLeMhKRQcB?=
 =?us-ascii?Q?nYHd2ReJ2Ojnt67ll4IgEw7pvpcbjJJSgt+5LV5L1bEe4bztkra25zBaiq1g?=
 =?us-ascii?Q?mqBuHIzmSm5y4zfuGWU+T86/rB+QSaf7A4eWBAmze/t7B/PR?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4321.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5eea20b-7b7c-427b-dd1b-08df0f3e015a
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2026 13:18:29.4981 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p37qgaxrOFC2x1hdS1r83nSxihGrxyfCz3iEdmtussDhidYNrakpUez4RWsKzKXm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9511
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
 bytes twice and causes fake-OOM while VRAM is still free.

New design reuses get_available_memory() for getting available VRAM in rese=
rve_mem_limit(). Move ALIGN_DOWN to the ioctl so the userspace ABI is uncha=
nged.

kfd.vram_pinned is only updated in gpuvm_pin_bo(). dma-buf pin calls amdgpu=
_bo_pin() only, so the counter stays zero.
Update it from amdgpu_bo_pin() through a KFD helper, on first pin and last =
unpin, matching vram_pin_size.

Signed-off-by: Zhen Han <Zhen.Han@amd.com>
---
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

 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    | 18 +++++
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 81 +++++++++++--------
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c    |  2 +
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      | 12 ++-
 4 files changed, 76 insertions(+), 37 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_amdkfd.h
index 4541542a28df..ff6aab8a8657 100644
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
@@ -456,6 +462,8 @@ void amdgpu_amdkfd_gpuvm_destroy_cb(struct amdgpu_devic=
e *adev,
  * Allows KFD to release its resources associated with the GEM object.
  */
 void amdgpu_amdkfd_release_notify(struct amdgpu_bo *bo);
+void amdgpu_amdkfd_account_vram_pin(struct amdgpu_bo *bo); void
+amdgpu_amdkfd_account_vram_unpin(struct amdgpu_bo *bo);
 void amdgpu_amdkfd_reserve_system_mem(uint64_t size);  #else  static inlin=
e @@ -473,6 +481,16 @@ static inline  void amdgpu_amdkfd_release_notify(str=
uct amdgpu_bo *bo)  {  }
+
+static inline
+void amdgpu_amdkfd_account_vram_pin(struct amdgpu_bo *bo) { }
+
+static inline
+void amdgpu_amdkfd_account_vram_unpin(struct amdgpu_bo *bo) { }
 #endif

 void amdgpu_amdkfd_rlc_spm_cntl(struct amdgpu_device *adev, int xcc_id, bo=
ol cntl);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu=
/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 89958d0f7e59..eb894a6fe5ef 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -48,12 +48,6 @@
 #define AMDGPU_USERPTR_RESTORE_DELAY_MS 1
 #define AMDGPU_RESERVE_MEM_LIMIT                       (3UL << 29)

-/*
- * Align VRAM availability to 2MB to avoid fragmentation caused by 4K allo=
cations in the tail 2MB
- * BO chunk
- */
-#define VRAM_AVAILABLITY_ALIGN (1 << 21)
-
 /* Impose limit on how much memory KFD can use */
 static struct {
        uint64_t max_system_mem_limit;
@@ -75,6 +69,8 @@ static const char * const domain_bit_to_string[] =3D {
 #define domain_string(domain) domain_bit_to_string[ffs(domain)-1]

 static void amdgpu_amdkfd_restore_userptr_worker(struct work_struct *work)=
;
+static size_t __get_available_memory(struct amdgpu_device *adev,
+                                    uint8_t xcp_id);

 static bool kfd_mem_is_attached(struct amdgpu_vm *avm,
                struct kgd_mem *mem)
@@ -171,13 +167,8 @@ void amdgpu_amdkfd_reserve_system_mem(uint64_t size)
 int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
                uint64_t size, u32 alloc_flag, int8_t xcp_id)
 {
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
@@ -198,7 +189,6 @@ int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_devic=
e *adev,
                if (WARN_ONCE(xcp_id < 0, "invalid XCP ID %d", xcp_id))
                        return -EINVAL;

-               vram_size =3D KFD_XCP_MEMORY_SIZE(adev, xcp_id);
                if (adev->apu_prefer_gtt) {
                        system_mem_needed =3D size;
                        ttm_mem_needed =3D size;
@@ -234,14 +224,10 @@ int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_dev=
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
+           vram_needed > __get_available_memory(adev, xcp_id)) {
+               ret =3D -ENOMEM;
+               goto release;
        }

        /* Update memory accounting by decreasing available system
@@ -320,6 +306,28 @@ void amdgpu_amdkfd_release_notify(struct amdgpu_bo *bo=
)
        kfree(bo->kfd_bo);
 }

+void amdgpu_amdkfd_account_vram_pin(struct amdgpu_bo *bo)
+{
+       if (!bo->kfd_bo || !bo->tbo.resource)
+               return;
+       if (bo->tbo.resource->mem_type !=3D TTM_PL_VRAM)
+               return;
+
+       atomic64_add(amdgpu_bo_size(bo),
+                    &amdgpu_ttm_adev(bo->tbo.bdev)->kfd.vram_pinned);
+}
+
+void amdgpu_amdkfd_account_vram_unpin(struct amdgpu_bo *bo)
+{
+       if (!bo->kfd_bo || !bo->tbo.resource)
+               return;
+       if (bo->tbo.resource->mem_type !=3D TTM_PL_VRAM)
+               return;
+
+       atomic64_sub(amdgpu_bo_size(bo),
+                    &amdgpu_ttm_adev(bo->tbo.bdev)->kfd.vram_pinned);
+}
+
 /**
  * create_dmamap_sg_bo() - Creates a amdgpu_bo object to reflect informati=
on
  * about USERPTR or DOOREBELL or MMIO BO.
@@ -1626,10 +1634,6 @@ int amdgpu_amdkfd_gpuvm_pin_bo(struct amdgpu_bo *bo,=
 u32 domain)

        amdgpu_bo_sync_wait(bo, AMDGPU_FENCE_OWNER_KFD, false);

-       if (!ret && bo->tbo.resource->mem_type =3D=3D TTM_PL_VRAM)
-                atomic64_add(amdgpu_bo_size(bo),
-                        &amdgpu_ttm_adev(bo->tbo.bdev)->kfd.vram_pinned);
-
 out:
        amdgpu_bo_unreserve(bo);
        return ret;
@@ -1653,10 +1657,6 @@ void amdgpu_amdkfd_gpuvm_unpin_bo(struct amdgpu_bo *=
bo)

        amdgpu_bo_unpin(bo);

-       if (bo->tbo.resource->mem_type =3D=3D TTM_PL_VRAM)
-               atomic64_sub(amdgpu_bo_size(bo),
-                       &amdgpu_ttm_adev(bo->tbo.bdev)->kfd.vram_pinned);
-
        amdgpu_bo_unreserve(bo);
 }

@@ -1760,8 +1760,9 @@ int amdgpu_amdkfd_criu_resume(void *p)
        return ret;
 }

-size_t amdgpu_amdkfd_get_available_memory(struct amdgpu_device *adev,
-                                         uint8_t xcp_id)
+/* Caller must hold kfd_mem_limit.mem_limit_lock. */
+static size_t __get_available_memory(struct amdgpu_device *adev,
+                                    uint8_t xcp_id)
 {
        uint64_t reserved_for_pt =3D
                ESTIMATE_PT_SIZE(amdgpu_amdkfd_total_mem_size);
@@ -1770,7 +1771,8 @@ size_t amdgpu_amdkfd_get_available_memory(struct amdg=
pu_device *adev,
        ssize_t available;
        uint64_t vram_available, system_mem_available, ttm_mem_available;

-       spin_lock(&kfd_mem_limit.mem_limit_lock);
+       lockdep_assert_held(&kfd_mem_limit.mem_limit_lock);
+
        if (adev->apu_prefer_gtt && !adev->gmc.is_app_apu)
                vram_available =3D KFD_XCP_MEMORY_SIZE(adev, xcp_id)
                        - adev->kfd.vram_used_aligned[xcp_id];
@@ -1793,19 +1795,28 @@ size_t amdgpu_amdkfd_get_available_memory(struct am=
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
+       available =3D __get_available_memory(adev, xcp_id);
+       spin_unlock(&kfd_mem_limit.mem_limit_lock);
+
+       return available;
+}
+
 int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
                struct amdgpu_device *adev, uint64_t va, uint64_t size,
                void *drm_priv, struct kgd_mem **mem,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_object.c
index b66a0eeda788..233e94db930e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -1004,6 +1004,7 @@ int amdgpu_bo_pin(struct amdgpu_bo *bo, u32 domain)
                atomic64_add(amdgpu_bo_size(bo), &adev->vram_pin_size);
                atomic64_add(amdgpu_vram_mgr_bo_visible_size(bo),
                             &adev->visible_pin_size);
+               amdgpu_amdkfd_account_vram_pin(bo);
        } else if (bo->tbo.resource->mem_type =3D=3D TTM_PL_TT) {
                atomic64_add(amdgpu_bo_size(bo), &adev->gart_pin_size);
        }
@@ -1039,6 +1040,7 @@ void amdgpu_bo_unpin(struct amdgpu_bo *bo)
                atomic64_sub(amdgpu_bo_size(bo), &adev->vram_pin_size);
                atomic64_sub(amdgpu_vram_mgr_bo_visible_size(bo),
                             &adev->visible_pin_size);
+               amdgpu_amdkfd_account_vram_unpin(bo);
        } else if (bo->tbo.resource->mem_type =3D=3D TTM_PL_TT) {
                atomic64_sub(amdgpu_bo_size(bo), &adev->gart_pin_size);
        }
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd=
/amdkfd/kfd_chardev.c
index 9751a912177c..1baa5d95f71a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1073,11 +1073,19 @@ static int kfd_ioctl_get_available_memory(struct fi=
le *filep,
 {
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
2.43.7

