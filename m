Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5E8EC54F54
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jul 2026 04:08:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A8C210E14D;
	Fri, 31 Jul 2026 04:08:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0WVyXPe5";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010031.outbound.protection.outlook.com [52.101.85.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 08AEE10E14D
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jul 2026 04:08:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bb/npOSjZdI+JzP4TmRhtlrfw4HGMPVNc6MeQl88GkNRN+l7y5KYsD+71Isy32W9T/ixKxLqObzJB+u+bMusnHoIb5PNY+uGfGpdbmd6BCX9v1nhC8SWD9eenOZHqRlw2b210q/VdPuOa0RaLHNWs82W0ssgU+1wAbPl4eQOJmspGQUpY5BkqgZ95KcZ+fLZMTM6sdHKZKj3FJ8243ddMhCMCFNNeAEWfzQwnJ6z2sXCqpqTy54LQVxRl/THmctzMtOvPL5r/UVYsJqdClniMVF3C5/+fl1j2gsLQiQASFAHgFbSD73hDOkGPWTHldN6x1aO6dwUGNdiY6gcB1U8fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yRSBESOsiOzg30Vpj/3wNd2npj3c5POvSXk+UwE4UrE=;
 b=bQwlNAuTeqBcWKwzubH5pXFm4ztroIyV4HbHRuAzwavbDtFefV48yN70kjefdlmAoiZVhyVXOZqn/exLHGAvGtlMmlR4oT2wprDoqduZAmkuUgDaOyNDgijlAzt6NYhLRBBLmeRbpCzZP1de5RW8NJaetAjqJ+o1ZQfPOTPk0RHHerppAhp85wi1nDGv7Pwasg9WIDXFmO0UaJH6TAxGg4wRnUOCJwV0ZiM+3kQ6sNWI5znGkhaJbwzahlYFP0WbtVN2L5qcsHg3jfC2DZRF4FRC4qsxPn4h26IhNhzgET5Pp7aR4n+ift6OYlgclwkxfPJqGP7/9z0KRA7PAZJwdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yRSBESOsiOzg30Vpj/3wNd2npj3c5POvSXk+UwE4UrE=;
 b=0WVyXPe5YWpOU0ByeJzgaVKouqMhADG43mt9A93afWajPs1/BH+CGpFPN21XIn76uaSZdkaMEryIfqLJ3tNQ+f5zU5AfHFfDd8TwNIJl5j9nGrlP1Q1VSTTiNyq/uVd8uBn6tCGb9W8yDVrPGSAI9F0SYoZwn9RfT2JhTnvFQn8=
Received: from SN7PR12MB8172.namprd12.prod.outlook.com (2603:10b6:806:352::20)
 by CH1PPF931B95D07.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::619) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Fri, 31 Jul
 2026 04:08:30 +0000
Received: from SN7PR12MB8172.namprd12.prod.outlook.com
 ([fe80::50de:d764:1129:66d6]) by SN7PR12MB8172.namprd12.prod.outlook.com
 ([fe80::50de:d764:1129:66d6%5]) with mapi id 15.21.0270.012; Fri, 31 Jul 2026
 04:08:30 +0000
From: "Jiang, Sonny" <Sonny.Jiang@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu/gmc12.1: implement tlb inv semaphore
Thread-Topic: [PATCH] drm/amdgpu/gmc12.1: implement tlb inv semaphore
Thread-Index: AQHdIEi/p44aM/3UyUC02j7b8EnUKLaHAycw
Date: Fri, 31 Jul 2026 04:08:30 +0000
Message-ID: <SN7PR12MB817282202B518E0F7BAE6C6FFDC82@SN7PR12MB8172.namprd12.prod.outlook.com>
References: <20260730172740.1268133-1-alexander.deucher@amd.com>
In-Reply-To: <20260730172740.1268133-1-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-07-31T04:05:45.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB8172:EE_|CH1PPF931B95D07:EE_
x-ms-office365-filtering-correlation-id: 622c7683-f939-4e73-9f4d-08deeeb96163
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|22082099003|18002099003|56012099006|11063799006|38070700021|6133799003|10067099003;
x-microsoft-antispam-message-info: 01/etO0eDIHmSiGULN37IEPvoBXoFMdF9taqUtQS+3qNbJM7s81dYc72YMg3YAKhRfuI8KU+1XSMvIxwiRltdW6rfv+ro70bfSIBLrW7lMDvkZSvG5vC/JXr0fpOmz2zSs9CyCraJ+RfL5gxuA/BGP16u7qB7QwmcL5ptGVs7Dyp4CIUk6uxDDOBsjZPIqR6kkDYjPmOllUOWnOLRR5gZZ03hhBqXbbtAYw/zcOUdub+AxBmv/SJY3TT2NWZtfVCKXguNWPaviQgdYhSLHU8uARJBJFXCe8zeoJasUqKbfcvNDzT/Y+iXVlk57ENo4WWF8qVJOLuaPYsN2t5CmYSZsRR5C0g2j85hFQpSZqUeRfCSrhUZoCk8hONFl0VLA8aCHLSSPzyhbNe6wj7C7M55Ad62lFrqd49CMIX21R5S7IYzPiBf0TzRLCFJ4M1qkB9TzTjL8nM9IVvfyWfMBa6LoNi5I+dFzkgr5l1mxi158ouFsTUnugC26qQjI23kxZebqVjBLMMcROWHItzBGJTRR2xGVSEHE+S8EYNU89gxg2AJ+1vUCa65K0wo2mP9TP1ERs3XQ7ISzoHlghHb7ItDlY54adzBCLKt7iTeJAKs+0JEecQ0yTeV8JjX8k5xnL2dYUNV1+r/yomTHK/Hk82Tq6xHavWFgn6/oXmOT2mGQDTbLeBVB/Ja1J25DFO4EnNvJcuV7Hrxa6SjmjLNXcLdx70qxD/13Q4XMoVenGbMZM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR12MB8172.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(22082099003)(18002099003)(56012099006)(11063799006)(38070700021)(6133799003)(10067099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Ovw9BIkt2WC6Qwl6Gugm2us4FOBlJdbffYN7yDi0x0HaAFsckeW/UJxuYbB/?=
 =?us-ascii?Q?1G12040vAUZZZzTQvRJ+t+pIUGLhFJYP38BpDNPHNGEgqOVnoKaFKk9bzAmC?=
 =?us-ascii?Q?qjSAKvM25u/tuBX24jdz/Te2mIhHMNeswXjUuVVjt2X6v0HEZKNgqJe1YwFO?=
 =?us-ascii?Q?gt1/fz/e3wbtU5urTQcSTuoHQSIdiKMNrCrEs9RcZnO53lXUVu1WIcXq9ei0?=
 =?us-ascii?Q?P+hSOXMkr2+NW+w0bRcLDV1zc/zzhFcEHWRZtKBPE+EjlRANkLuNVSolI4jy?=
 =?us-ascii?Q?/+slpX4KYL3Mp0VZ68pRWiH1uTQQtjnzUkuxczn89S3SlE9hM0aCEBMYzIEM?=
 =?us-ascii?Q?EaHFeZnH8xllYFp72p7SCCnChrpIcvAWMn4I+Apu1lQO564s5ZN8Om1ZoFF+?=
 =?us-ascii?Q?BBeOZGuhaKIh466AULO/nKeBErpVO3VIOAZliFE9ujMpMpbzdBycoqyXxHbh?=
 =?us-ascii?Q?4F8DS08M8oKFXXfH+kKrDTT3O1oM7038yv0hRUcdwHgBZEQ9gVHgK2cZlH3S?=
 =?us-ascii?Q?JIN6etXZvpp3qGOE/tnR9tZ1QbGoE/zKB5yoiiIMaoq9arYJAap8MaKMFtFX?=
 =?us-ascii?Q?pY8tsj3/BfetjPq/6yN4NF2Y5a9rAYa6n6ONWUYSp47Cr8dU37929phqTT6F?=
 =?us-ascii?Q?1ECZF2yrq1clNLyr6sAYj2GACVobUuM8hxXAzl/ONUFqMNXHyhPvuHHUYvqv?=
 =?us-ascii?Q?pjVhe8Xv8oz6n2LHNhMbtH+mh6Md6Gk3yM0AIGJ3h7SqOOx9isM+CUe23W/e?=
 =?us-ascii?Q?M0jzgP6TrNhu0mJX3QdAUBk06cyirsYsqMt8SAZRoksPOl5dTHOgYzPya/IQ?=
 =?us-ascii?Q?SJOmsL7Jc/xZrr1Pt103rL2T3xDzJ3pEXAofYFPR0aPfrrFyB5wZuoRDbyv0?=
 =?us-ascii?Q?lMeQlMq+hn6rOe2xePkCYMsAikkLQFSox/cugry2HwkzfUdVaAU/rQ2k2Piq?=
 =?us-ascii?Q?oo1NtfjSUV8hINsJ/Ify+Kp2Epq1bb06UsiLUEDOTIGX7BSUfK4P+bmY33sw?=
 =?us-ascii?Q?4MolJSaLpaWmRtxjCgrorx0gaBlckyIGfFBdiktoLKFHRCH6OTjQ3HvOcxgT?=
 =?us-ascii?Q?DTjg05Mk6m7O24qY1mGdNST31FVLfXjh8etGrmZYuBZVbwM2xfEBbHO7zvtY?=
 =?us-ascii?Q?HnXsbFBrguJSOHnBMNDELROiZ0XYR1VnypIIwVwpERej9Qe7iqfMBBFwEQHL?=
 =?us-ascii?Q?D15sQnAZnUkJfIL4eFrZUCkeVew8klVRRlxhCe4GJbbg0mw8TEK1HduW7Ppi?=
 =?us-ascii?Q?p8c9WevjcCSREyXExZeC23kOPKnXOSzdBPOLZlMeZFXrwWSKaQC/LlX8fVZu?=
 =?us-ascii?Q?PSPKsGJra0lNq0ai5Vu7jdaIzqduw78F4SuX0QNsVF77PPOpQs1AXokvAeII?=
 =?us-ascii?Q?Prwk+G1bZl+Uw30VFIU3DC9Raem0n/mdl2hjvdR3pEJIV3poVuxQpYBO4ICR?=
 =?us-ascii?Q?ioQMexKb0/SB/SGUtQ3iJ/KgwMvAEqYSiTSwDCVfz3DFyS79n/tqNLhcmaUs?=
 =?us-ascii?Q?AoxINLwCOd+yutW5adyHKmcg+IttqnkvaSWd0mbfCUsrO0QVv3+XUue41K/H?=
 =?us-ascii?Q?WLKyORuDc5WmPQUqU2Fu6mIKZXdQ12E1xbW7EZzCNd2ccxUftTvQfhz2reNz?=
 =?us-ascii?Q?8WLsDCddLleu36TB3nidLDTl96vmyL4vwwjCQBBMb9GFZXrhs2puKcEsglqM?=
 =?us-ascii?Q?czNfB5aBVsCelVk2ojn22H4VooZPoxrLKDXrNLSVKN5ZdixZ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8172.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 622c7683-f939-4e73-9f4d-08deeeb96163
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2026 04:08:30.3436 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E5FGA4pLG2WmK6hI6IbEhpxBOFEQ/EAzz+cKgCs22AdGZP6WDWTK2uAS/D4ZZ6++iGVgTozozgDsgmk8FDAWEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF931B95D07
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

This is
Reviewed-by: Sonny Jiang <sonny.jiang@amd.com>

-----Original Message-----
From: Alex Deucher <alexander.deucher@amd.com>
Sent: Thursday, July 30, 2026 1:28 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Jiang, Sonny <Sonny.Jia=
ng@amd.com>
Subject: [PATCH] drm/amdgpu/gmc12.1: implement tlb inv semaphore

Needed to properly lock the interface before using it.

Cc: Sonny Jiang <sonny.jiang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c | 46 ++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c b/drivers/gpu/drm/amd/a=
mdgpu/gmc_v12_1.c
index 855cd29cbffaa..bdf6788b85b58 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
@@ -267,9 +267,24 @@ static bool gmc_v12_1_get_vmid_pasid_mapping_info(stru=
ct amdgpu_device *adev,
  * by the amdgpu vm/hsa code.
  */

+/**
+ * gmc_v12_1_use_invalidate_semaphore - judge whether to use semaphore
+ *
+ * @adev: amdgpu_device pointer
+ * @vmhub: vmhub type
+ *
+ */
+static bool gmc_v12_1_use_invalidate_semaphore(struct amdgpu_device *adev,
+                                      uint32_t vmhub)
+{
+       return ((!AMDGPU_IS_GFXHUB(vmhub)) &&
+               (!amdgpu_sriov_vf(adev)));
+}
+
 static void gmc_v12_1_flush_vm_hub(struct amdgpu_device *adev, uint32_t vm=
id,
                                   unsigned int vmhub, uint32_t flush_type)=
  {
+       bool use_semaphore =3D gmc_v12_1_use_invalidate_semaphore(adev, vmh=
ub);
        struct amdgpu_vmhub *hub =3D &adev->vmhub[vmhub];
        u32 inv_req =3D hub->vmhub_funcs->get_invalidate_req(vmid, flush_ty=
pe);
        u32 tmp;
@@ -283,6 +298,19 @@ static void gmc_v12_1_flush_vm_hub(struct amdgpu_devic=
e *adev, uint32_t vmid,

        spin_lock(&adev->gmc.invalidate_lock);

+       if (use_semaphore) {
+               for (i =3D 0; i < adev->usec_timeout; i++) {
+                       /* a read return value of 1 means semaphore acuqire=
 */
+                       tmp =3D RREG32_RLC_NO_KIQ(hub->vm_inv_eng0_sem + hu=
b->eng_distance * eng, hub_ip);
+                       if (tmp & 0x1)
+                               break;
+                       udelay(1);
+               }
+
+               if (i >=3D adev->usec_timeout)
+                       DRM_ERROR("Timeout waiting for sem acquire in VM fl=
ush!\n");
+       }
+
        WREG32_RLC_NO_KIQ(hub->vm_inv_eng0_req + hub->eng_distance * eng, i=
nv_req, hub_ip);

        /* Wait for ACK with a delay.*/
@@ -296,6 +324,9 @@ static void gmc_v12_1_flush_vm_hub(struct amdgpu_device=
 *adev, uint32_t vmid,
                udelay(1);
        }

+       if (use_semaphore)
+               WREG32_RLC_NO_KIQ(hub->vm_inv_eng0_sem + hub->eng_distance =
* eng, 0,
+hub_ip);
+
        /* Issue additional private vm invalidation to MMHUB */
        if (!AMDGPU_IS_GFXHUB(vmhub) &&
            (hub->vm_l2_bank_select_reserved_cid2) && @@ -431,10 +462,17 @@=
 static void gmc_v12_1_flush_gpu_tlb_pasid(struct amdgpu_device *adev,  sta=
tic uint64_t gmc_v12_1_emit_flush_gpu_tlb(struct amdgpu_ring *ring,
                                             unsigned vmid, uint64_t pd_add=
r)  {
+       bool use_semaphore =3D gmc_v12_1_use_invalidate_semaphore(ring->ade=
v,
+ring->vm_hub);
        struct amdgpu_vmhub *hub =3D &ring->adev->vmhub[ring->vm_hub];
        uint32_t req =3D hub->vmhub_funcs->get_invalidate_req(vmid, 0);
        unsigned eng =3D ring->vm_inv_eng;

+       if (use_semaphore)
+               /* a read return value of 1 means semaphore acuqire */
+               amdgpu_ring_emit_reg_wait(ring,
+                                         hub->vm_inv_eng0_sem +
+                                         hub->eng_distance * eng, 0x1, 0x1=
);
+
        amdgpu_ring_emit_wreg(ring, hub->ctx0_ptb_addr_lo32 +
                              (hub->ctx_addr_distance * vmid),
                              lower_32_bits(pd_addr));
@@ -449,6 +487,14 @@ static uint64_t gmc_v12_1_emit_flush_gpu_tlb(struct am=
dgpu_ring *ring,
                                            hub->eng_distance * eng,
                                            req, 1 << vmid);

+       if (use_semaphore)
+               /*
+                * add semaphore release after invalidation,
+                * write with 0 means semaphore release
+                */
+               amdgpu_ring_emit_wreg(ring, hub->vm_inv_eng0_sem +
+                                     hub->eng_distance * eng, 0);
+
        return pd_addr;
 }

--
2.55.0

