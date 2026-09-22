Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1495C982FA
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Sep 2026 09:55:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 39EDA10E46A;
	Tue, 22 Sep 2026 09:55:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mSciycFU";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011056.outbound.protection.outlook.com [40.107.208.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D5A210E46A
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Sep 2026 09:55:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c8CKUWACIo0ala5OYBnKHF1gb8RHp35GxW4Ta+FRbFaBYMKA1GPF4VnC19lrit788ODD6wc2MqspAqwVJeQc2RNw8dDBoqbfSzAj9CYi+S7C781jOZsCZ3jRUXsLqgg3ccb9kVI+jXOkAcnWK2rBhyUFmhjreSh5typbUj6p6fs8DQ9cg7uMQRfTe7HjwGYbmo1ixiEW2h0qLM7a/KT+8QHMbjvtjOQ9DgqYYVRY6Lcf9EXEFvvdiWadJvAHMvxLvPGvLHW5WMjhcoZZ0NbPtDDw/RLr52ne2EW73Z6XYwljLLOA7jW4kr3+M6mCLRgb8d1qYDjIIzTZHKvuS08nfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0mXmbyYwTTWfHh8FKp+Fv4SVehztRAaOT329oYB48gs=;
 b=FDgDBa2VxguVeRiMF/SKKS9BOWNIwHwMidmOHe0hMgLLU9OYcMYlwYeaZt863EXY+uxjMsLRoe8fznB0dKzzzYLZBubMpU2u7OfdcHF5uKW3fKBRcKm15kx+VUXOZG8WDOA+e8DIOqcFDO/ujmWjm4nrq8A1tCCvYDACli9IRaU7SeGadzghHf5o76bn0bUrdwlzLgQDzYfzyzQwP/rYYYbzhgUNLi4NGO982s83+AW2zdyBhRigDOkPbfeN5pGl3Z05OH/ydcanp7PjvvbJFy45ZdKFld10DrlSgWMbL3mEpSkQlhavSOSbJfM37KK04CVT8X0Qn24qjZ3NA8eVOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0mXmbyYwTTWfHh8FKp+Fv4SVehztRAaOT329oYB48gs=;
 b=mSciycFU6oLF5uUqkGmmE2X3J5ESwncD7qYowrgjSk6jegKE8GYz55NoNV+p5F371p8yMU2hgbGBzq8cVD1Gm6zesVLPTcJSfeoTw13l12X1jysygE1u1ziBDOqelg/jkavI/OhDooWk+vfiUxgo8fBIMIW3srNBTXNOJ/y4AMQ=
Received: from DM4PR12MB5748.namprd12.prod.outlook.com (2603:10b6:8:5f::19) by
 DS7PR12MB8081.namprd12.prod.outlook.com (2603:10b6:8:e6::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.16; Tue, 22 Sep 2026 09:55:29 +0000
Received: from DM4PR12MB5748.namprd12.prod.outlook.com
 ([fe80::6c62:e99c:480d:2729]) by DM4PR12MB5748.namprd12.prod.outlook.com
 ([fe80::6c62:e99c:480d:2729%3]) with mapi id 15.21.0428.011; Tue, 22 Sep 2026
 09:55:28 +0000
From: "Kamal, Asad" <Asad.Kamal@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Ma, Le" <Le.Ma@amd.com>, "Wang, YuBiao (Ethan)"
 <YuBiao.Wang@amd.com>
Subject: RE: [PATCH v2] drm/amdgpu: Use offset macros for sdma v7.1
Thread-Topic: [PATCH v2] drm/amdgpu: Use offset macros for sdma v7.1
Thread-Index: AQHdSnQBe0yI/y/2202GI7UilwmgK7baXAQg
Date: Tue, 22 Sep 2026 09:55:28 +0000
Message-ID: <DM4PR12MB5748E7CC0F5B4EEAD0940A028E832@DM4PR12MB5748.namprd12.prod.outlook.com>
References: <20260922092253.2320788-1-lijo.lazar@amd.com>
In-Reply-To: <20260922092253.2320788-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-09-22T09:55:13.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5748:EE_|DS7PR12MB8081:EE_
x-ms-office365-filtering-correlation-id: 45dd3265-c5a4-41d0-d0c6-08df188fa200
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|6133799003|22082099003|18002099003|11063799006|56012099006|10067099003|38070700021;
x-microsoft-antispam-message-info: ad5M7t758qaBHe2h3C6+IeGZwD04qLhD8bJPjVhAiMIaSXuG23A5bGNmaXpWqHJ+eyY1B8/w4j1ZdgCqSjeibmu/0DcVCNB7VMaVEzkBXX+v+QrmrGKewJfUTaCxFEQfpY3j2DPzUxmGAO1Y0YbHnvZg/s/7P4oFEniSSn2HfpUSH/PrMD7x8vr9I4fUdCFqhiWBS+y7q7E0xf6BnK746k5dxbtkxqokP9lxsu4iwTaz+axF4uAONOG10OJ8lJ2Z9MKSy+LeU1hhKRs+kQZNxUL+KpcON+YqrvrwFdKhBINT2rzjG0uP2gBKKOWN1gBn+DezL2j2iKgZ4PtMWoxz8ASnySOlRkI5HUZnfmUW9Ftq5o+bOXF6EpKWuIIiNEfhZb+2Y1drfu57trmYWhLsXjRo7chidnWNKRil+ciQOJl2rC6dSiZOF0QbMHL7xcZdeYPDNP+Ta8KMEic7vbenYt5k6NZeKfyNVgSl3w6qVDc3eXHcx02fuhaLknt1yWXmRJP2GNbk2+VxvhYffyM979IE+z/ajEMwQGzLlz3on2qSnsCmDDQLHFqrHuqKjvd0uBa/qaJgep+c8hkZJ4eBHVgUmGumb53KBDIYEQDpMCownslq5yRYl6d/BG9Z1HRTZ/z0VDzBjHInPIx2tUFQQpjgjmT3R5r1YSlnkRQBvQF7iosEPAx+K4jmAbi02/7qYNcx2jPxzL/iy/erl38AwFUA2HjK8hfTfUoKKGRrO6Y=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5748.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(6133799003)(22082099003)(18002099003)(11063799006)(56012099006)(10067099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0ZyAot0eQYtB4BYNkJ+09D0Wgn5UBh+MqJFqc1OLG+yuCXuRbRxpkCNW1HPV?=
 =?us-ascii?Q?Ufv78mvI1GgcEVStcEzTevY58ER0joBm0opkmIIM2CkocB7z492kV94q4PXn?=
 =?us-ascii?Q?rA4dFsQT0gW12R5UvUhU0sx5c48WXpBT/ZkpcKmqcum0GCbgXiZpcOHc5J4Z?=
 =?us-ascii?Q?izWFIBOpc8yvfdKEJjuAvq/zjFjWttTLAMUlBBOOjGz0t+0a/e+G2oK9btUK?=
 =?us-ascii?Q?HzeVwY+4F1I473ItVa5fGBY0+PgNUnvXgLICN7N4x5CdaqYgC/QGtgWaARAv?=
 =?us-ascii?Q?uD0vVfXf+Fb2q8+wWgaUQnXrwrCDTOJFhseecaA0TBokA5pciaJP8OwD1bgl?=
 =?us-ascii?Q?e9GpQjWrkB+A7VSsG7/3OlGAuSxPqVkewqpUIdTTSWLm9rz0lZ5fBAZZDjeT?=
 =?us-ascii?Q?CL3igyfWZ7gLLQlIxV9AcXXs3FJ9Wida+xXnmwcQJB+VzBz/aY0wq+QOm7s/?=
 =?us-ascii?Q?O2suY/4+byhbt2zWYBiXsu4mb/Eh+5YxWv6A7f/iu0q6TBROp2aYjIiuNAIu?=
 =?us-ascii?Q?BNeWvjzc04F5fBmeup4Jv1hv3f1vEJD25InEPszr/nSJ/RnPIop238BVCKh0?=
 =?us-ascii?Q?5yXXYLobsxQMXtN3bmKgLGrfM+VFdJFmc3rliLEyTgPYR5oJ1wVdNm/bNoTV?=
 =?us-ascii?Q?en3uMat1LDfpM3/pfImvZqXWEHbESV/kH7QdISD9OutaXsQ8tn6gzQofr1Yf?=
 =?us-ascii?Q?BQwRhZnSCdlcWZa6CSHFL7+zWHoYv6FEse+P06hB7uYkp5p9ZIm5fad7X2Yl?=
 =?us-ascii?Q?m64wKsNkW7qU4QXA2NjE5iNJMHx9MUwT867wbLOWJOl1WQfQAvgX2ZnBPMR8?=
 =?us-ascii?Q?ovPcii6xGTZPL7cuMt+LIa8BF8terOLXPjLsfEjEWIuKM6jtrOPhK1mwJlyc?=
 =?us-ascii?Q?iQchoIhFgZuST9BlgFuv85GD2onOn6JdXC3NpIY//wGPiXN8nLE6BovSjzNn?=
 =?us-ascii?Q?hJ6QehW6hCkioHK/5nDUREaSrIFaaPQfAXYNMDAVc8FlqwF0xkHlg0mstJHa?=
 =?us-ascii?Q?T4LS3nHC7Wq+8wvnNRJekXWu8lDSzIPvEtAmrcKs0il0zPHdw1pOpFpdjcMi?=
 =?us-ascii?Q?4AamOcmbZS/mADSprAMXnE7ZSaf8BZSHR1dBPqECynCba7X96L3s8znUGdwu?=
 =?us-ascii?Q?Kj98g76cWyfGYTf6pCeBa/VSIbyddRCRXcareh+56NZusgL/cVt46LSlMRpm?=
 =?us-ascii?Q?rnZM/Ze4xvcZ4WjNcfUlYyIM7YxSFFuQnmkFseOlDqmsU6ayujUGEuyjdZME?=
 =?us-ascii?Q?f9eaK0sRUaCwzz7MZmDixS//znJPXhznzT7fTs73nf7/g/bQ/RowlbPji+sM?=
 =?us-ascii?Q?2Lj8xNTHvfPK25qBbat61blczAATvFKpA1lk97xABsEV6VdLe0ErEcIFq5QZ?=
 =?us-ascii?Q?G/mAfZcnunuJAYxcbawAp33evL7wLUBtb+mVI8dMrstSlt9vYEsJesf1Ac0Q?=
 =?us-ascii?Q?YNgR8etivNAUxQpa46f4N5EgMmpsVDguoEsfr0uwiQd9A5Meti4hW2UZ6uSs?=
 =?us-ascii?Q?kLCZIyN6Fgi2sEs9ck+T+CgTA5zKxKz2ylWrRmpiJ/4ssDoGBeqeH4ZWUJEq?=
 =?us-ascii?Q?3XCHqPKH674sbIGLRRWeaaiy553Zfou3+0VMHJ5rc9h22+0T1Ib92NIB46GL?=
 =?us-ascii?Q?w0M2XtXoMMnC7C2cGOr3+2VhDFiEBa91bfISD9BEO79JVOx7T28BF3tfnCVc?=
 =?us-ascii?Q?dDdvYitdt3WAC//NrX7p3xtaq2eMuFV8Qed1GifinINpwUV/?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5748.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45dd3265-c5a4-41d0-d0c6-08df188fa200
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2026 09:55:28.6707 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MUc6gdEezpTfD9QGP9BI2CC6jqz3FP39KakNULxHIk454yd+LmIiF8Fx83WNmiyUjwNyFWDqj555qDouQ0RTiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8081
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

Reviewed-by: Asad Kamal <asad.kamal@amd.com>

Thanks & Regards
Asad

-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Tuesday, September 22, 2026 2:52 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Ma, Le <Le.Ma@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>; =
Wang, YuBiao (Ethan) <YuBiao.Wang@amd.com>
Subject: [PATCH v2] drm/amdgpu: Use offset macros for sdma v7.1

Use WREG32_SOC15_OFFSET/RREG32_SOC15_OFFSET macros for register accesses of=
 SDMA instances within a XCD. Those macros take instance arg which is helpf=
ul in SRIOV accesses to identify the XCC through which access can be routed=
. Use build time assert to make sure only register offsets from the mapped =
segments are accessed.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---

v2: Read GRBM_STATUS2 separately for IP dump. That doesn't need offset calc=
ulation.

 drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c | 321 ++++++++++++++++---------
 1 file changed, 207 insertions(+), 114 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c b/drivers/gpu/drm/amd/a=
mdgpu/sdma_v7_1.c
index 50058118235f..f02092939d3b 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
@@ -46,9 +46,9 @@

 MODULE_FIRMWARE("amdgpu/sdma_7_1_0.bin");

-#define SDMA1_REG_OFFSET 0x600
-#define SDMA0_SDMA_IDX_0_END 0x450
-#define SDMA1_HYP_DEC_REG_OFFSET 0x30
+/* per-instance stride is the SDMA0 to SDMA1 delta of the owning
+address block */ #define SDMA1_DEC_REG_OFFSET (regSDMA1_SDMA_DEC_START
+- regSDMA0_SDMA_DEC_START) #define SDMA1_HYP_DEC_REG_OFFSET
+(regSDMA1_SDMA_VM_CTX_LO - regSDMA0_SDMA_VM_CTX_LO)

 static const struct amdgpu_hwip_reg_entry sdma_reg_list_7_1[] =3D {
        SOC15_REG_ENTRY_STR(GC, 0, regSDMA0_SDMA_STATUS_REG), @@ -104,8 +10=
4,8 @@ static const struct amdgpu_hwip_reg_entry sdma_reg_list_7_1[] =3D {
        SOC15_REG_ENTRY_STR(GC, 0, regSDMA0_SDMA_QUEUE2_DUMMY_REG),
        SOC15_REG_ENTRY_STR(GC, 0, regSDMA0_SDMA_INT_STATUS),
        SOC15_REG_ENTRY_STR(GC, 0, regSDMA0_SDMA_VM_CNTL),
-       SOC15_REG_ENTRY_STR(GC, 0, regGRBM_STATUS2),
        SOC15_REG_ENTRY_STR(GC, 0, regSDMA0_SDMA_CHICKEN_BITS),
+       SOC15_REG_ENTRY_STR(GC, 0, regGRBM_STATUS2),
 };

 static void sdma_v7_1_set_ring_funcs(struct amdgpu_device *adev); @@ -114,=
26 +114,27 @@ static void sdma_v7_1_set_irq_funcs(struct amdgpu_device *ade=
v);  static int sdma_v7_1_inst_start(struct amdgpu_device *adev,
                                uint32_t inst_mask);

-static u32 sdma_v7_1_get_reg_offset(struct amdgpu_device *adev, u32 instan=
ce, u32 internal_offset)
+/* per-instance stride of each SDMA address block, indexed by register
+BASE_IDX */ static const u32 sdma_v7_1_inst_stride[] =3D {
+       SDMA1_DEC_REG_OFFSET,
+       SDMA1_HYP_DEC_REG_OFFSET,
+};
+
+/*
+ * Offset from an SDMA0 register to the same register of SDMA instance
+ * within its own XCC, i.e. SDMA0 to SDMA1 register address delta.
+ */
+static u32 sdma_v7_1_inst_offset(struct amdgpu_device *adev, u32 instance,
+                                u32 base_idx)
 {
-       u32 base;
-       u32 dev_inst =3D GET_INST(SDMA0, instance);
-       int xcc_id =3D adev->sdma.instance[instance].xcc_id;
-       int xcc_inst =3D dev_inst % adev->sdma.num_inst_per_xcc;
-
-       if (internal_offset >=3D SDMA0_SDMA_IDX_0_END) {
-               base =3D adev->reg_offset[GC_HWIP][xcc_id][1];
-               if (xcc_inst !=3D 0)
-                       internal_offset +=3D SDMA1_HYP_DEC_REG_OFFSET * xcc=
_inst;
-       } else {
-               base =3D adev->reg_offset[GC_HWIP][xcc_id][0];
-               if (xcc_inst !=3D 0)
-                       internal_offset +=3D SDMA1_REG_OFFSET * xcc_inst;
-       }
+       u32 xcc_inst =3D GET_INST(SDMA0, instance) %
+adev->sdma.num_inst_per_xcc;

-       return base + internal_offset;
+       return xcc_inst * sdma_v7_1_inst_stride[base_idx];
 }

+#define SDMA_INST_OFFSET(i, reg) \
+       (BUILD_BUG_ON_ZERO(ARRAY_SIZE(sdma_v7_1_inst_stride) <=3D reg##_BAS=
E_IDX) + \
+        sdma_v7_1_inst_offset(adev, (i), reg##_BASE_IDX))
 static unsigned sdma_v7_1_ring_init_cond_exec(struct amdgpu_ring *ring,
                                              uint64_t addr)
 {
@@ -199,6 +200,7 @@ static uint64_t sdma_v7_1_ring_get_wptr(struct amdgpu_r=
ing *ring)  static void sdma_v7_1_ring_set_wptr(struct amdgpu_ring *ring)  =
{
        struct amdgpu_device *adev =3D ring->adev;
+       u32 xcc_id =3D adev->sdma.instance[ring->me].xcc_id;

        DRM_DEBUG("Setting write pointer\n");

@@ -224,14 +226,12 @@ static void sdma_v7_1_ring_set_wptr(struct amdgpu_rin=
g *ring)
                          lower_32_bits(ring->wptr << 2),
                          ring->me,
                          upper_32_bits(ring->wptr << 2));
-               WREG32_SOC15_IP(GC, sdma_v7_1_get_reg_offset(adev,
-                                                            ring->me,
-                                                            regSDMA0_SDMA_=
QUEUE0_RB_WPTR),
-                               lower_32_bits(ring->wptr << 2));
-               WREG32_SOC15_IP(GC, sdma_v7_1_get_reg_offset(adev,
-                                                            ring->me,
-                                                            regSDMA0_SDMA_=
QUEUE0_RB_WPTR_HI),
-                               upper_32_bits(ring->wptr << 2));
+               WREG32_SOC15_OFFSET(GC, xcc_id, regSDMA0_SDMA_QUEUE0_RB_WPT=
R,
+                                   SDMA_INST_OFFSET(ring->me, regSDMA0_SDM=
A_QUEUE0_RB_WPTR),
+                                   lower_32_bits(ring->wptr << 2));
+               WREG32_SOC15_OFFSET(GC, xcc_id, regSDMA0_SDMA_QUEUE0_RB_WPT=
R_HI,
+                                   SDMA_INST_OFFSET(ring->me, regSDMA0_SDM=
A_QUEUE0_RB_WPTR_HI),
+                                   upper_32_bits(ring->wptr << 2));
        }
 }

@@ -367,15 +367,22 @@ static void sdma_v7_1_inst_gfx_stop(struct amdgpu_dev=
ice *adev,
                                    uint32_t inst_mask)
 {
        u32 rb_cntl, ib_cntl;
+       u32 xcc_id;
        int i;

        for_each_inst(i, inst_mask) {
-               rb_cntl =3D RREG32_SOC15_IP(GC, sdma_v7_1_get_reg_offset(ad=
ev, i, regSDMA0_SDMA_QUEUE0_RB_CNTL));
+               xcc_id =3D adev->sdma.instance[i].xcc_id;
+
+               rb_cntl =3D RREG32_SOC15_OFFSET(GC, xcc_id, regSDMA0_SDMA_Q=
UEUE0_RB_CNTL,
+                                             SDMA_INST_OFFSET(i, regSDMA0_=
SDMA_QUEUE0_RB_CNTL));
                rb_cntl =3D REG_SET_FIELD(rb_cntl, SDMA0_SDMA_QUEUE0_RB_CNT=
L, RB_ENABLE, 0);
-               WREG32_SOC15_IP(GC, sdma_v7_1_get_reg_offset(adev, i, regSD=
MA0_SDMA_QUEUE0_RB_CNTL), rb_cntl);
-               ib_cntl =3D RREG32_SOC15_IP(GC, sdma_v7_1_get_reg_offset(ad=
ev, i, regSDMA0_SDMA_QUEUE0_IB_CNTL));
+               WREG32_SOC15_OFFSET(GC, xcc_id, regSDMA0_SDMA_QUEUE0_RB_CNT=
L,
+                                   SDMA_INST_OFFSET(i, regSDMA0_SDMA_QUEUE=
0_RB_CNTL), rb_cntl);
+               ib_cntl =3D RREG32_SOC15_OFFSET(GC, xcc_id, regSDMA0_SDMA_Q=
UEUE0_IB_CNTL,
+                                             SDMA_INST_OFFSET(i, regSDMA0_=
SDMA_QUEUE0_IB_CNTL));
                ib_cntl =3D REG_SET_FIELD(ib_cntl, SDMA0_SDMA_QUEUE0_IB_CNT=
L, IB_ENABLE, 0);
-               WREG32_SOC15_IP(GC, sdma_v7_1_get_reg_offset(adev, i, regSD=
MA0_SDMA_QUEUE0_IB_CNTL), ib_cntl);
+               WREG32_SOC15_OFFSET(GC, xcc_id, regSDMA0_SDMA_QUEUE0_IB_CNT=
L,
+                                   SDMA_INST_OFFSET(i, regSDMA0_SDMA_QUEUE=
0_IB_CNTL), ib_cntl);
        }
 }

@@ -405,11 +412,14 @@ static void sdma_v7_1_inst_rlc_stop(struct amdgpu_dev=
ice *adev,  static void sdma_v7_1_inst_ctx_switch_enable(struct amdgpu_devi=
ce *adev,
                                             bool enable, uint32_t inst_mas=
k)  {
+       u32 xcc_id;
        int i;

        for_each_inst(i, inst_mask) {
-               WREG32_SOC15_IP(GC,
-                       sdma_v7_1_get_reg_offset(adev, i, regSDMA0_SDMA_UTC=
L1_TIMEOUT), 0x80);
+               xcc_id =3D adev->sdma.instance[i].xcc_id;
+
+               WREG32_SOC15_OFFSET(GC, xcc_id, regSDMA0_SDMA_UTCL1_TIMEOUT=
,
+                                   SDMA_INST_OFFSET(i, regSDMA0_SDMA_UTCL1=
_TIMEOUT), 0x80);
        }
 }

@@ -426,6 +436,7 @@ static void sdma_v7_1_inst_enable(struct amdgpu_device =
*adev,
                                  bool enable, uint32_t inst_mask)
 {
        u32 mcu_cntl;
+       u32 xcc_id;
        int i;

        if (!enable) {
@@ -437,9 +448,13 @@ static void sdma_v7_1_inst_enable(struct amdgpu_device=
 *adev,
                return;

        for_each_inst(i, inst_mask) {
-               mcu_cntl =3D RREG32_SOC15_IP(GC, sdma_v7_1_get_reg_offset(a=
dev, i, regSDMA0_SDMA_MCU_CNTL));
+               xcc_id =3D adev->sdma.instance[i].xcc_id;
+
+               mcu_cntl =3D RREG32_SOC15_OFFSET(GC, xcc_id, regSDMA0_SDMA_=
MCU_CNTL,
+                                              SDMA_INST_OFFSET(i, regSDMA0=
_SDMA_MCU_CNTL));
                mcu_cntl =3D REG_SET_FIELD(mcu_cntl, SDMA0_SDMA_MCU_CNTL, H=
ALT, enable ? 0 : 1);
-               WREG32_SOC15_IP(GC, sdma_v7_1_get_reg_offset(adev, i, regSD=
MA0_SDMA_MCU_CNTL), mcu_cntl);
+               WREG32_SOC15_OFFSET(GC, xcc_id, regSDMA0_SDMA_MCU_CNTL,
+                                   SDMA_INST_OFFSET(i, regSDMA0_SDMA_MCU_C=
NTL), mcu_cntl);
        }
 }

@@ -462,13 +477,15 @@ static int sdma_v7_1_gfx_resume_instance(struct amdgp=
u_device *adev, int i, bool
        u32 doorbell_offset;
        u32 temp;
        u64 wptr_gpu_addr;
+       u32 xcc_id =3D adev->sdma.instance[i].xcc_id;
        int r;

        ring =3D &adev->sdma.instance[i].ring;

        /* Set ring buffer size in dwords */
        rb_bufsz =3D order_base_2(ring->ring_size / 4);
-       rb_cntl =3D RREG32_SOC15_IP(GC, sdma_v7_1_get_reg_offset(adev, i, r=
egSDMA0_SDMA_QUEUE0_RB_CNTL));
+       rb_cntl =3D RREG32_SOC15_OFFSET(GC, xcc_id, regSDMA0_SDMA_QUEUE0_RB=
_CNTL,
+                                     SDMA_INST_OFFSET(i, regSDMA0_SDMA_QUE=
UE0_RB_CNTL));
        rb_cntl =3D REG_SET_FIELD(rb_cntl, SDMA0_SDMA_QUEUE0_RB_CNTL, RB_SI=
ZE, rb_bufsz);  #ifdef __BIG_ENDIAN
        rb_cntl =3D REG_SET_FIELD(rb_cntl, SDMA0_SDMA_QUEUE0_RB_CNTL, RB_SW=
AP_ENABLE, 1); @@ -476,32 +493,49 @@ static int sdma_v7_1_gfx_resume_instan=
ce(struct amdgpu_device *adev, int i, bool
                                RPTR_WRITEBACK_SWAP_ENABLE, 1);
 #endif
        rb_cntl =3D REG_SET_FIELD(rb_cntl, SDMA0_SDMA_QUEUE0_RB_CNTL, RB_PR=
IV, 1);
-       WREG32_SOC15_IP(GC, sdma_v7_1_get_reg_offset(adev, i, regSDMA0_SDMA=
_QUEUE0_RB_CNTL), rb_cntl);
+       WREG32_SOC15_OFFSET(GC, xcc_id, regSDMA0_SDMA_QUEUE0_RB_CNTL,
+                           SDMA_INST_OFFSET(i, regSDMA0_SDMA_QUEUE0_RB_CNT=
L), rb_cntl);

        /* Initialize the ring buffer's read and write pointers */
        if (restore) {
-               WREG32_SOC15_IP(GC, sdma_v7_1_get_reg_offset(adev, i, regSD=
MA0_SDMA_QUEUE0_RB_RPTR), lower_32_bits(ring->wptr << 2));
-               WREG32_SOC15_IP(GC, sdma_v7_1_get_reg_offset(adev, i, regSD=
MA0_SDMA_QUEUE0_RB_RPTR_HI), upper_32_bits(ring->wptr << 2));
-               WREG32_SOC15_IP(GC, sdma_v7_1_get_reg_offset(adev, i, regSD=
MA0_SDMA_QUEUE0_RB_WPTR), lower_32_bits(ring->wptr << 2));
-               WREG32_SOC15_IP(GC, sdma_v7_1_get_reg_offset(adev, i, regSD=
MA0_SDMA_QUEUE0_RB_WPTR_HI), upper_32_bits(ring->wptr << 2));
+               WREG32_SOC15_OFFSET(GC, xcc_id, regSDMA0_SDMA_QUEUE0_RB_RPT=
R,
+                                   SDMA_INST_OFFSET(i, regSDMA0_SDMA_QUEUE=
0_RB_RPTR),
+                                   lower_32_bits(ring->wptr << 2));
+               WREG32_SOC15_OFFSET(GC, xcc_id, regSDMA0_SDMA_QUEUE0_RB_RPT=
R_HI,
+                                   SDMA_INST_OFFSET(i, regSDMA0_SDMA_QUEUE=
0_RB_RPTR_HI),
+                                   upper_32_bits(ring->wptr << 2));
+               WREG32_SOC15_OFFSET(GC, xcc_id, regSDMA0_SDMA_QUEUE0_RB_WPT=
R,
+                                   SDMA_INST_OFFSET(i, regSDMA0_SDMA_QUEUE=
0_RB_WPTR),
+                                   lower_32_bits(ring->wptr << 2));
+               WREG32_SOC15_OFFSET(GC, xcc_id, regSDMA0_SDMA_QUEUE0_RB_WPT=
R_HI,
+                                   SDMA_INST_OFFSET(i, regSDMA0_SDMA_QUEUE=
0_RB_WPTR_HI),
+                                   upper_32_bits(ring->wptr << 2));
        } else {
-               WREG32_SOC15_IP(GC, sdma_v7_1_get_reg_offset(adev, i, regSD=
MA0_SDMA_QUEUE0_RB_RPTR), 0);
-               WREG32_SOC15_IP(GC, sdma_v7_1_get_reg_offset(adev, i, regSD=
MA0_SDMA_QUEUE0_RB_RPTR_HI), 0);
-               WREG32_SOC15_IP(GC, sdma_v7_1_get_reg_offset(adev, i, regSD=
MA0_SDMA_QUEUE0_RB_WPTR), 0);
-               WREG32_SOC15_IP(GC, sdma_v7_1_get_reg_offset(adev, i, regSD=
MA0_SDMA_QUEUE0_RB_WPTR_HI), 0);
+               WREG32_SOC15_OFFSET(GC, xcc_id, regSDMA0_SDMA_QUEUE0_RB_RPT=
R,
+                                   SDMA_INST_OFFSET(i, regSDMA0_SDMA_QUEUE=
0_RB_RPTR), 0);
+               WREG32_SOC15_OFFSET(GC, xcc_id, regSDMA0_SDMA_QUEUE0_RB_RPT=
R_HI,
+                                   SDMA_INST_OFFSET(i, regSDMA0_SDMA_QUEUE=
0_RB_RPTR_HI), 0);
+               WREG32_SOC15_OFFSET(GC, xcc_id, regSDMA0_SDMA_QUEUE0_RB_WPT=
R,
+                                   SDMA_INST_OFFSET(i, regSDMA0_SDMA_QUEUE=
0_RB_WPTR), 0);
+               WREG32_SOC15_OFFSET(GC, xcc_id, regSDMA0_SDMA_QUEUE0_RB_WPT=
R_HI,
+                                   SDMA_INST_OFFSET(i, regSDMA0_SDMA_QUEUE=
0_RB_WPTR_HI), 0);
        }
        /* setup the wptr shadow polling */
        wptr_gpu_addr =3D ring->wptr_gpu_addr;
-       WREG32_SOC15_IP(GC, sdma_v7_1_get_reg_offset(adev, i, regSDMA0_SDMA=
_QUEUE0_RB_WPTR_POLL_ADDR_LO),
-              lower_32_bits(wptr_gpu_addr));
-       WREG32_SOC15_IP(GC, sdma_v7_1_get_reg_offset(adev, i, regSDMA0_SDMA=
_QUEUE0_RB_WPTR_POLL_ADDR_HI),
-              upper_32_bits(wptr_gpu_addr));
+       WREG32_SOC15_OFFSET(GC, xcc_id, regSDMA0_SDMA_QUEUE0_RB_WPTR_POLL_A=
DDR_LO,
+                           SDMA_INST_OFFSET(i, regSDMA0_SDMA_QUEUE0_RB_WPT=
R_POLL_ADDR_LO),
+                           lower_32_bits(wptr_gpu_addr));
+       WREG32_SOC15_OFFSET(GC, xcc_id, regSDMA0_SDMA_QUEUE0_RB_WPTR_POLL_A=
DDR_HI,
+                           SDMA_INST_OFFSET(i, regSDMA0_SDMA_QUEUE0_RB_WPT=
R_POLL_ADDR_HI),
+                           upper_32_bits(wptr_gpu_addr));

        /* set the wb address whether it's enabled or not */
-       WREG32_SOC15_IP(GC, sdma_v7_1_get_reg_offset(adev, i, regSDMA0_SDMA=
_QUEUE0_RB_RPTR_ADDR_HI),
-              upper_32_bits(ring->rptr_gpu_addr) & 0xFFFFFFFF);
-       WREG32_SOC15_IP(GC, sdma_v7_1_get_reg_offset(adev, i, regSDMA0_SDMA=
_QUEUE0_RB_RPTR_ADDR_LO),
-              lower_32_bits(ring->rptr_gpu_addr) & 0xFFFFFFFC);
+       WREG32_SOC15_OFFSET(GC, xcc_id, regSDMA0_SDMA_QUEUE0_RB_RPTR_ADDR_H=
I,
+                           SDMA_INST_OFFSET(i, regSDMA0_SDMA_QUEUE0_RB_RPT=
R_ADDR_HI),
+                           upper_32_bits(ring->rptr_gpu_addr) & 0xFFFFFFFF=
);
+       WREG32_SOC15_OFFSET(GC, xcc_id, regSDMA0_SDMA_QUEUE0_RB_RPTR_ADDR_L=
O,
+                           SDMA_INST_OFFSET(i, regSDMA0_SDMA_QUEUE0_RB_RPT=
R_ADDR_LO),
+                           lower_32_bits(ring->rptr_gpu_addr) & 0xFFFFFFFC=
);

        rb_cntl =3D REG_SET_FIELD(rb_cntl, SDMA0_SDMA_QUEUE0_RB_CNTL, RPTR_=
WRITEBACK_ENABLE, 1);
        if (amdgpu_sriov_vf(adev))
@@ -511,22 +545,32 @@ static int sdma_v7_1_gfx_resume_instance(struct amdgp=
u_device *adev, int i, bool

        rb_cntl =3D REG_SET_FIELD(rb_cntl, SDMA0_SDMA_QUEUE0_RB_CNTL, MCU_W=
PTR_POLL_ENABLE, 1);

-       WREG32_SOC15_IP(GC, sdma_v7_1_get_reg_offset(adev, i, regSDMA0_SDMA=
_QUEUE0_RB_BASE), ring->gpu_addr >> 8);
-       WREG32_SOC15_IP(GC, sdma_v7_1_get_reg_offset(adev, i, regSDMA0_SDMA=
_QUEUE0_RB_BASE_HI), ring->gpu_addr >> 40);
+       WREG32_SOC15_OFFSET(GC, xcc_id, regSDMA0_SDMA_QUEUE0_RB_BASE,
+                           SDMA_INST_OFFSET(i, regSDMA0_SDMA_QUEUE0_RB_BAS=
E), ring->gpu_addr >> 8);
+       WREG32_SOC15_OFFSET(GC, xcc_id, regSDMA0_SDMA_QUEUE0_RB_BASE_HI,
+                           SDMA_INST_OFFSET(i, regSDMA0_SDMA_QUEUE0_RB_BAS=
E_HI),
+                           ring->gpu_addr >> 40);

        if (!restore)
                ring->wptr =3D 0;

        /* before programing wptr to a less value, need set minor_ptr_updat=
e first */
-       WREG32_SOC15_IP(GC, sdma_v7_1_get_reg_offset(adev, i, regSDMA0_SDMA=
_QUEUE0_MINOR_PTR_UPDATE), 1);
+       WREG32_SOC15_OFFSET(GC, xcc_id, regSDMA0_SDMA_QUEUE0_MINOR_PTR_UPDA=
TE,
+                           SDMA_INST_OFFSET(i, regSDMA0_SDMA_QUEUE0_MINOR_=
PTR_UPDATE), 1);

        if (!amdgpu_sriov_vf(adev)) { /* only bare-metal use register write=
 for wptr */
-               WREG32_SOC15_IP(GC, sdma_v7_1_get_reg_offset(adev, i, regSD=
MA0_SDMA_QUEUE0_RB_WPTR), lower_32_bits(ring->wptr) << 2);
-               WREG32_SOC15_IP(GC, sdma_v7_1_get_reg_offset(adev, i, regSD=
MA0_SDMA_QUEUE0_RB_WPTR_HI), upper_32_bits(ring->wptr) << 2);
+               WREG32_SOC15_OFFSET(GC, xcc_id, regSDMA0_SDMA_QUEUE0_RB_WPT=
R,
+                                   SDMA_INST_OFFSET(i, regSDMA0_SDMA_QUEUE=
0_RB_WPTR),
+                                   lower_32_bits(ring->wptr) << 2);
+               WREG32_SOC15_OFFSET(GC, xcc_id, regSDMA0_SDMA_QUEUE0_RB_WPT=
R_HI,
+                                   SDMA_INST_OFFSET(i, regSDMA0_SDMA_QUEUE=
0_RB_WPTR_HI),
+                                   upper_32_bits(ring->wptr) << 2);
        }

-       doorbell =3D RREG32_SOC15_IP(GC, sdma_v7_1_get_reg_offset(adev, i, =
regSDMA0_SDMA_QUEUE0_DOORBELL));
-       doorbell_offset =3D RREG32_SOC15_IP(GC, sdma_v7_1_get_reg_offset(ad=
ev, i, regSDMA0_SDMA_QUEUE0_DOORBELL_OFFSET));
+       doorbell =3D RREG32_SOC15_OFFSET(GC, xcc_id, regSDMA0_SDMA_QUEUE0_D=
OORBELL,
+                                      SDMA_INST_OFFSET(i, regSDMA0_SDMA_QU=
EUE0_DOORBELL));
+       doorbell_offset =3D RREG32_SOC15_OFFSET(GC, xcc_id, regSDMA0_SDMA_Q=
UEUE0_DOORBELL_OFFSET,
+                                             SDMA_INST_OFFSET(i, regSDMA0_=
SDMA_QUEUE0_DOORBELL_OFFSET));

        if (ring->use_doorbell) {
                doorbell =3D REG_SET_FIELD(doorbell, SDMA0_SDMA_QUEUE0_DOOR=
BELL, ENABLE, 1); @@ -535,8 +579,11 @@ static int sdma_v7_1_gfx_resume_inst=
ance(struct amdgpu_device *adev, int i, bool
        } else {
                doorbell =3D REG_SET_FIELD(doorbell, SDMA0_SDMA_QUEUE0_DOOR=
BELL, ENABLE, 0);
        }
-       WREG32_SOC15_IP(GC, sdma_v7_1_get_reg_offset(adev, i, regSDMA0_SDMA=
_QUEUE0_DOORBELL), doorbell);
-       WREG32_SOC15_IP(GC, sdma_v7_1_get_reg_offset(adev, i, regSDMA0_SDMA=
_QUEUE0_DOORBELL_OFFSET), doorbell_offset);
+       WREG32_SOC15_OFFSET(GC, xcc_id, regSDMA0_SDMA_QUEUE0_DOORBELL,
+                           SDMA_INST_OFFSET(i, regSDMA0_SDMA_QUEUE0_DOORBE=
LL), doorbell);
+       WREG32_SOC15_OFFSET(GC, xcc_id, regSDMA0_SDMA_QUEUE0_DOORBELL_OFFSE=
T,
+                           SDMA_INST_OFFSET(i, regSDMA0_SDMA_QUEUE0_DOORBE=
LL_OFFSET),
+                           doorbell_offset);

        if (i =3D=3D 0)
                adev->nbio.funcs->sdma_doorbell_range(adev, i, ring->use_do=
orbell, @@ -547,53 +594,66 @@ static int sdma_v7_1_gfx_resume_instance(stru=
ct amdgpu_device *adev, int i, bool
                sdma_v7_1_ring_set_wptr(ring);

        /* set minor_ptr_update to 0 after wptr programed */
-       WREG32_SOC15_IP(GC, sdma_v7_1_get_reg_offset(adev, i, regSDMA0_SDMA=
_QUEUE0_MINOR_PTR_UPDATE), 0);
+       WREG32_SOC15_OFFSET(GC, xcc_id, regSDMA0_SDMA_QUEUE0_MINOR_PTR_UPDA=
TE,
+                           SDMA_INST_OFFSET(i, regSDMA0_SDMA_QUEUE0_MINOR_=
PTR_UPDATE), 0);

        /* Set up sdma hang watchdog */
-       temp =3D RREG32_SOC15_IP(GC, sdma_v7_1_get_reg_offset(adev, i, regS=
DMA0_SDMA_WATCHDOG_CNTL));
+       temp =3D RREG32_SOC15_OFFSET(GC, xcc_id, regSDMA0_SDMA_WATCHDOG_CNT=
L,
+                                  SDMA_INST_OFFSET(i, regSDMA0_SDMA_WATCHD=
OG_CNTL));
        /* Disable sdma hang watchdog, need revist this when issue resolved=
.
        Once issue resoved, the QUEUE_HANG_COUNT should be set to max(adev-=
>usec_timeout/100000,1)
        */
        temp =3D REG_SET_FIELD(temp, SDMA0_SDMA_WATCHDOG_CNTL, QUEUE_HANG_C=
OUNT, 0);
        temp =3D REG_SET_FIELD(temp, SDMA0_SDMA_WATCHDOG_CNTL, CMD_TIMEOUT_=
COUNT, 0);
-       WREG32_SOC15_IP(GC, sdma_v7_1_get_reg_offset(adev, i, regSDMA0_SDMA=
_WATCHDOG_CNTL), temp);
+       WREG32_SOC15_OFFSET(GC, xcc_id, regSDMA0_SDMA_WATCHDOG_CNTL,
+                           SDMA_INST_OFFSET(i, regSDMA0_SDMA_WATCHDOG_CNTL=
), temp);

        dev_dbg(adev->dev, "Disable SDMA Hang WatchDog, regSDMA0_SDMA_WATCH=
DOG_CNTL =3D %d\n",
-               RREG32_SOC15_IP(GC, sdma_v7_1_get_reg_offset(adev, i, regSD=
MA0_SDMA_WATCHDOG_CNTL)));
+               RREG32_SOC15_OFFSET(GC, xcc_id, regSDMA0_SDMA_WATCHDOG_CNTL=
,
+                                   SDMA_INST_OFFSET(i, regSDMA0_SDMA_WATCH=
DOG_CNTL)));

        /* Set up RESP_MODE to non-copy addresses */
-       temp =3D RREG32_SOC15_IP(GC, sdma_v7_1_get_reg_offset(adev, i, regS=
DMA0_SDMA_UTCL1_CNTL));
+       temp =3D RREG32_SOC15_OFFSET(GC, xcc_id, regSDMA0_SDMA_UTCL1_CNTL,
+                                  SDMA_INST_OFFSET(i, regSDMA0_SDMA_UTCL1_=
CNTL));
        temp =3D REG_SET_FIELD(temp, SDMA0_SDMA_UTCL1_CNTL, RESP_MODE, 3);
        temp =3D REG_SET_FIELD(temp, SDMA0_SDMA_UTCL1_CNTL, REDO_DELAY, 9);
-       WREG32_SOC15_IP(GC, sdma_v7_1_get_reg_offset(adev, i, regSDMA0_SDMA=
_UTCL1_CNTL), temp);
+       WREG32_SOC15_OFFSET(GC, xcc_id, regSDMA0_SDMA_UTCL1_CNTL,
+                           SDMA_INST_OFFSET(i, regSDMA0_SDMA_UTCL1_CNTL), =
temp);

        /* program default cache read and write policy */
-       temp =3D RREG32_SOC15_IP(GC, sdma_v7_1_get_reg_offset(adev, i, regS=
DMA0_SDMA_UTCL1_PAGE));
+       temp =3D RREG32_SOC15_OFFSET(GC, xcc_id, regSDMA0_SDMA_UTCL1_PAGE,
+                                  SDMA_INST_OFFSET(i, regSDMA0_SDMA_UTCL1_=
PAGE));
        /* clean read policy and write policy bits */
        temp &=3D 0xFF0FFF;
        temp |=3D ((CACHE_READ_POLICY_L2__DEFAULT << 12) |
                 (CACHE_WRITE_POLICY_L2__DEFAULT << 14));
-       WREG32_SOC15_IP(GC, sdma_v7_1_get_reg_offset(adev, i, regSDMA0_SDMA=
_UTCL1_PAGE), temp);
+       WREG32_SOC15_OFFSET(GC, xcc_id, regSDMA0_SDMA_UTCL1_PAGE,
+                           SDMA_INST_OFFSET(i, regSDMA0_SDMA_UTCL1_PAGE), =
temp);

        if (!amdgpu_sriov_vf(adev)) {
                /* unhalt engine */
-               temp =3D RREG32_SOC15_IP(GC, sdma_v7_1_get_reg_offset(adev,=
 i, regSDMA0_SDMA_MCU_CNTL));
+               temp =3D RREG32_SOC15_OFFSET(GC, xcc_id, regSDMA0_SDMA_MCU_=
CNTL,
+                                          SDMA_INST_OFFSET(i, regSDMA0_SDM=
A_MCU_CNTL));
                temp =3D REG_SET_FIELD(temp, SDMA0_SDMA_MCU_CNTL, HALT, 0);
                temp =3D REG_SET_FIELD(temp, SDMA0_SDMA_MCU_CNTL, RESET, 0)=
;
-               WREG32_SOC15_IP(GC, sdma_v7_1_get_reg_offset(adev, i, regSD=
MA0_SDMA_MCU_CNTL), temp);
+               WREG32_SOC15_OFFSET(GC, xcc_id, regSDMA0_SDMA_MCU_CNTL,
+                                   SDMA_INST_OFFSET(i, regSDMA0_SDMA_MCU_C=
NTL), temp);
        }

        /* enable DMA RB */
        rb_cntl =3D REG_SET_FIELD(rb_cntl, SDMA0_SDMA_QUEUE0_RB_CNTL, RB_EN=
ABLE, 1);
-       WREG32_SOC15_IP(GC, sdma_v7_1_get_reg_offset(adev, i, regSDMA0_SDMA=
_QUEUE0_RB_CNTL), rb_cntl);
+       WREG32_SOC15_OFFSET(GC, xcc_id, regSDMA0_SDMA_QUEUE0_RB_CNTL,
+                           SDMA_INST_OFFSET(i, regSDMA0_SDMA_QUEUE0_RB_CNT=
L), rb_cntl);

-       ib_cntl =3D RREG32_SOC15_IP(GC, sdma_v7_1_get_reg_offset(adev, i, r=
egSDMA0_SDMA_QUEUE0_IB_CNTL));
+       ib_cntl =3D RREG32_SOC15_OFFSET(GC, xcc_id, regSDMA0_SDMA_QUEUE0_IB=
_CNTL,
+                                     SDMA_INST_OFFSET(i, regSDMA0_SDMA_QUE=
UE0_IB_CNTL));
        ib_cntl =3D REG_SET_FIELD(ib_cntl, SDMA0_SDMA_QUEUE0_IB_CNTL, IB_EN=
ABLE, 1);  #ifdef __BIG_ENDIAN
        ib_cntl =3D REG_SET_FIELD(ib_cntl, SDMA0_SDMA_QUEUE0_IB_CNTL, IB_SW=
AP_ENABLE, 1);  #endif
        /* enable DMA IBs */
-       WREG32_SOC15_IP(GC, sdma_v7_1_get_reg_offset(adev, i, regSDMA0_SDMA=
_QUEUE0_IB_CNTL), ib_cntl);
+       WREG32_SOC15_OFFSET(GC, xcc_id, regSDMA0_SDMA_QUEUE0_IB_CNTL,
+                           SDMA_INST_OFFSET(i, regSDMA0_SDMA_QUEUE0_IB_CNT=
L), ib_cntl);
        ring->sched.ready =3D true;

        if (amdgpu_sriov_vf(adev)) { /* bare-metal sequence doesn't need be=
low to lines */ @@ -675,6 +735,7 @@ static int sdma_v7_1_inst_load_microcod=
e(struct amdgpu_device *adev,
        const __le32 *fw_data;
        u32 fw_size;
        uint32_t tmp, sdma_status, ic_op_cntl;
+       u32 xcc_id;
        int i, r, j;

        /* halt the MEs */
@@ -692,6 +753,8 @@ static int sdma_v7_1_inst_load_microcode(struct amdgpu_=
device *adev,
        fw_size =3D le32_to_cpu(hdr->ucode_size_bytes);

        for_each_inst(i, inst_mask) {
+               xcc_id =3D adev->sdma.instance[i].xcc_id;
+
                r =3D amdgpu_bo_create_reserved(adev, fw_size,
                                              PAGE_SIZE,
                                              AMDGPU_GEM_DOMAIN_VRAM,
@@ -708,25 +771,31 @@ static int sdma_v7_1_inst_load_microcode(struct amdgp=
u_device *adev,
                amdgpu_bo_kunmap(adev->sdma.instance[i].sdma_fw_obj);
                amdgpu_bo_unreserve(adev->sdma.instance[i].sdma_fw_obj);

-               tmp =3D RREG32_SOC15_IP(GC, sdma_v7_1_get_reg_offset(adev, =
i, regSDMA0_SDMA_IC_CNTL));
+               tmp =3D RREG32_SOC15_OFFSET(GC, xcc_id, regSDMA0_SDMA_IC_CN=
TL,
+                                         SDMA_INST_OFFSET(i, regSDMA0_SDMA=
_IC_CNTL));
                tmp =3D REG_SET_FIELD(tmp, SDMA0_SDMA_IC_CNTL, GPA, 0);
-               WREG32_SOC15_IP(GC, sdma_v7_1_get_reg_offset(adev, i, regSD=
MA0_SDMA_IC_CNTL), tmp);
-
-               WREG32_SOC15_IP(GC, sdma_v7_1_get_reg_offset(adev, i, regSD=
MA0_SDMA_IC_BASE_LO),
-                       lower_32_bits(adev->sdma.instance[i].sdma_fw_gpu_ad=
dr));
-               WREG32_SOC15_IP(GC, sdma_v7_1_get_reg_offset(adev, i, regSD=
MA0_SDMA_IC_BASE_HI),
-                       upper_32_bits(adev->sdma.instance[i].sdma_fw_gpu_ad=
dr));
-
-               tmp =3D RREG32_SOC15_IP(GC, sdma_v7_1_get_reg_offset(adev, =
i, regSDMA0_SDMA_IC_OP_CNTL));
+               WREG32_SOC15_OFFSET(GC, xcc_id, regSDMA0_SDMA_IC_CNTL,
+                                   SDMA_INST_OFFSET(i, regSDMA0_SDMA_IC_CN=
TL), tmp);
+
+               WREG32_SOC15_OFFSET(GC, xcc_id, regSDMA0_SDMA_IC_BASE_LO,
+                                   SDMA_INST_OFFSET(i, regSDMA0_SDMA_IC_BA=
SE_LO),
+                                   lower_32_bits(adev->sdma.instance[i].sd=
ma_fw_gpu_addr));
+               WREG32_SOC15_OFFSET(GC, xcc_id, regSDMA0_SDMA_IC_BASE_HI,
+                                   SDMA_INST_OFFSET(i, regSDMA0_SDMA_IC_BA=
SE_HI),
+                                   upper_32_bits(adev->sdma.instance[i].sd=
ma_fw_gpu_addr));
+
+               tmp =3D RREG32_SOC15_OFFSET(GC, xcc_id, regSDMA0_SDMA_IC_OP=
_CNTL,
+                                         SDMA_INST_OFFSET(i, regSDMA0_SDMA=
_IC_OP_CNTL));
                tmp =3D REG_SET_FIELD(tmp, SDMA0_SDMA_IC_OP_CNTL, PRIME_ICA=
CHE, 1);
-               WREG32_SOC15_IP(GC, sdma_v7_1_get_reg_offset(adev, i, regSD=
MA0_SDMA_IC_OP_CNTL), tmp);
+               WREG32_SOC15_OFFSET(GC, xcc_id, regSDMA0_SDMA_IC_OP_CNTL,
+                                   SDMA_INST_OFFSET(i, regSDMA0_SDMA_IC_OP=
_CNTL), tmp);

                /* Wait for sdma ucode init complete */
                for (j =3D 0; j < adev->usec_timeout; j++) {
-                       ic_op_cntl =3D RREG32_SOC15_IP(GC,
-                                       sdma_v7_1_get_reg_offset(adev, i, r=
egSDMA0_SDMA_IC_OP_CNTL));
-                       sdma_status =3D RREG32_SOC15_IP(GC,
-                                       sdma_v7_1_get_reg_offset(adev, i, r=
egSDMA0_SDMA_STATUS_REG));
+                       ic_op_cntl =3D RREG32_SOC15_OFFSET(GC, xcc_id, regS=
DMA0_SDMA_IC_OP_CNTL,
+                                                        SDMA_INST_OFFSET(i=
, regSDMA0_SDMA_IC_OP_CNTL));
+                       sdma_status =3D RREG32_SOC15_OFFSET(GC, xcc_id, reg=
SDMA0_SDMA_STATUS_REG,
+                                                         SDMA_INST_OFFSET(=
i, regSDMA0_SDMA_STATUS_REG));
                        if ((REG_GET_FIELD(ic_op_cntl, SDMA0_SDMA_IC_OP_CNT=
L, ICACHE_PRIMED) =3D=3D 1) &&
                            (REG_GET_FIELD(sdma_status, SDMA0_SDMA_STATUS_R=
EG, UCODE_INIT_DONE) =3D=3D 1))
                                break;
@@ -746,6 +815,7 @@ static int sdma_v7_1_soft_reset(struct amdgpu_ip_block =
*ip_block)  {
        struct amdgpu_device *adev =3D ip_block->adev;
        uint32_t inst_mask;
+       u32 xcc_id;
        u32 tmp;
        int i;

@@ -753,15 +823,22 @@ static int sdma_v7_1_soft_reset(struct amdgpu_ip_bloc=
k *ip_block)
        sdma_v7_1_inst_gfx_stop(adev, inst_mask);

        for_each_inst(i, inst_mask) {
-               //tmp =3D RREG32_SOC15_IP(GC, sdma_v7_1_get_reg_offset(adev=
, i, regSDMA0_SDMA_FREEZE));
+               xcc_id =3D adev->sdma.instance[i].xcc_id;
+
+               //tmp =3D RREG32_SOC15_OFFSET(GC, xcc_id, regSDMA0_SDMA_FRE=
EZE,
+               //                          SDMA_INST_OFFSET(i, regSDMA0_SD=
MA_FREEZE));
                //tmp |=3D SDMA0_SDMA_FREEZE__FREEZE_MASK;
-               //WREG32_SOC15_IP(GC, sdma_v7_1_get_reg_offset(adev, i, reg=
SDMA0_SDMA_FREEZE), tmp);
-               tmp =3D RREG32_SOC15_IP(GC, sdma_v7_1_get_reg_offset(adev, =
i, regSDMA0_SDMA_MCU_CNTL));
+               //WREG32_SOC15_OFFSET(GC, xcc_id, regSDMA0_SDMA_FREEZE,
+               //                    SDMA_INST_OFFSET(i, regSDMA0_SDMA_FRE=
EZE), tmp);
+               tmp =3D RREG32_SOC15_OFFSET(GC, xcc_id, regSDMA0_SDMA_MCU_C=
NTL,
+                                         SDMA_INST_OFFSET(i, regSDMA0_SDMA=
_MCU_CNTL));
                tmp |=3D SDMA0_SDMA_MCU_CNTL__HALT_MASK;
                tmp |=3D SDMA0_SDMA_MCU_CNTL__RESET_MASK;
-               WREG32_SOC15_IP(GC, sdma_v7_1_get_reg_offset(adev, i, regSD=
MA0_SDMA_MCU_CNTL), tmp);
+               WREG32_SOC15_OFFSET(GC, xcc_id, regSDMA0_SDMA_MCU_CNTL,
+                                   SDMA_INST_OFFSET(i, regSDMA0_SDMA_MCU_C=
NTL), tmp);

-               WREG32_SOC15_IP(GC, sdma_v7_1_get_reg_offset(adev, i, regSD=
MA0_SDMA_QUEUE0_PREEMPT), 0);
+               WREG32_SOC15_OFFSET(GC, xcc_id, regSDMA0_SDMA_QUEUE0_PREEMP=
T,
+                                   SDMA_INST_OFFSET(i, regSDMA0_SDMA_QUEUE=
0_PREEMPT), 0);

                udelay(100);

@@ -857,6 +934,7 @@ static int sdma_v7_1_mqd_init(struct amdgpu_device *ade=
v, void *mqd,
                              struct amdgpu_mqd_prop *prop)
 {
        struct v12_1_sdma_mqd *m =3D mqd;
+       u32 xcc_id =3D adev->sdma.instance[0].xcc_id;
        uint64_t wb_gpu_addr;

        m->sdmax_queuen_rb_cntl =3D
@@ -876,8 +954,8 @@ static int sdma_v7_1_mqd_init(struct amdgpu_device *ade=
v, void *mqd,
        m->sdmax_queuen_rb_rptr_addr_lo =3D lower_32_bits(wb_gpu_addr);
        m->sdmax_queuen_rb_rptr_addr_hi =3D upper_32_bits(wb_gpu_addr);

-       m->sdmax_queuen_ib_cntl =3D RREG32_SOC15_IP(GC, sdma_v7_1_get_reg_o=
ffset(adev, 0,
-                                                       regSDMA0_SDMA_QUEUE=
0_IB_CNTL));
+       m->sdmax_queuen_ib_cntl =3D RREG32_SOC15_OFFSET(GC, xcc_id, regSDMA=
0_SDMA_QUEUE0_IB_CNTL,
+                                                   SDMA_INST_OFFSET(0, reg=
SDMA0_SDMA_QUEUE0_IB_CNTL));

        m->sdmax_queuen_doorbell_offset =3D
                prop->doorbell_index << SDMA0_SDMA_QUEUE0_DOORBELL_OFFSET__=
OFFSET__SHIFT;
@@ -1380,13 +1458,18 @@ static int sdma_v7_1_sw_fini(struct amdgpu_ip_block=
 *ip_block)  static void sdma_v7_1_rb_cmd_switch(struct amdgpu_device *adev=
,
                                    uint32_t inst_mask)
 {
+       u32 xcc_id;
        int i, fe_cntl;
-
+
        if (adev->sdma.sdma_debug) {
                for_each_inst(i, inst_mask) {
-                       fe_cntl =3D RREG32_SOC15_IP(GC, sdma_v7_1_get_reg_o=
ffset(adev, i, regSDMA0_SDMA_FE_CNTL0));
+                       xcc_id =3D adev->sdma.instance[i].xcc_id;
+
+                       fe_cntl =3D RREG32_SOC15_OFFSET(GC, xcc_id, regSDMA=
0_SDMA_FE_CNTL0,
+                                                     SDMA_INST_OFFSET(i, r=
egSDMA0_SDMA_FE_CNTL0));
                        fe_cntl &=3D 0x7fffffff;
-                       WREG32_SOC15_IP(GC, sdma_v7_1_get_reg_offset(adev, =
i, regSDMA0_SDMA_FE_CNTL0), fe_cntl);
+                       WREG32_SOC15_OFFSET(GC, xcc_id, regSDMA0_SDMA_FE_CN=
TL0,
+                                           SDMA_INST_OFFSET(i, regSDMA0_SD=
MA_FE_CNTL0), fe_cntl);
                }
        }
 }
@@ -1442,8 +1525,10 @@ static int sdma_v7_1_wait_for_idle(struct amdgpu_ip_=
block *ip_block)

        for (i =3D 0; i < adev->usec_timeout; i++) {
                for (j =3D 0; j < adev->sdma.num_instances; j++) {
-                       sdma[j] =3D RREG32(sdma_v7_1_get_reg_offset(adev,
-                                               j, regSDMA0_SDMA_STATUS_REG=
));
+                       u32 xcc_id =3D adev->sdma.instance[j].xcc_id;
+
+                       sdma[j] =3D RREG32_SOC15_OFFSET(GC, xcc_id, regSDMA=
0_SDMA_STATUS_REG,
+                                       SDMA_INST_OFFSET(j, regSDMA0_SDMA_S=
TATUS_REG));
                        if (!(sdma[j] & SDMA0_SDMA_STATUS_REG__IDLE_MASK))
                                break;
                }
@@ -1459,11 +1544,10 @@ static int sdma_v7_1_ring_preempt_ib(struct amdgpu_=
ring *ring)
        int i, r =3D 0;
        struct amdgpu_device *adev =3D ring->adev;
        u32 index =3D 0;
-       u64 sdma_gfx_preempt;
+       u32 xcc_id;

        amdgpu_sdma_get_index_from_ring(ring, &index);
-       sdma_gfx_preempt =3D
-               sdma_v7_1_get_reg_offset(adev, index, regSDMA0_SDMA_QUEUE0_=
PREEMPT);
+       xcc_id =3D adev->sdma.instance[index].xcc_id;

        /* assert preemption condition */
        amdgpu_ring_set_preempt_cond_exec(ring, false); @@ -1480,7 +1564,8 =
@@ static int sdma_v7_1_ring_preempt_ib(struct amdgpu_ring *ring)
        amdgpu_ring_commit(ring);

        /* assert IB preemption */
-       WREG32(sdma_gfx_preempt, 1);
+       WREG32_SOC15_OFFSET(GC, xcc_id, regSDMA0_SDMA_QUEUE0_PREEMPT,
+                           SDMA_INST_OFFSET(index, regSDMA0_SDMA_QUEUE0_PR=
EEMPT), 1);

        /* poll the trailing fence */
        for (i =3D 0; i < adev->usec_timeout; i++) { @@ -1496,7 +1581,8 @@ =
static int sdma_v7_1_ring_preempt_ib(struct amdgpu_ring *ring)
        }

        /* deassert IB preemption */
-       WREG32(sdma_gfx_preempt, 0);
+       WREG32_SOC15_OFFSET(GC, xcc_id, regSDMA0_SDMA_QUEUE0_PREEMPT,
+                           SDMA_INST_OFFSET(index, regSDMA0_SDMA_QUEUE0_PR=
EEMPT), 0);

        /* deassert the preemption condition */
        amdgpu_ring_set_preempt_cond_exec(ring, true); @@ -1508,14 +1594,15=
 @@ static int sdma_v7_1_set_trap_irq_state(struct amdgpu_device *adev,
                                        unsigned type,
                                        enum amdgpu_interrupt_state state) =
 {
+       u32 xcc_id =3D adev->sdma.instance[type].xcc_id;
        u32 sdma_cntl;

-       u32 reg_offset =3D sdma_v7_1_get_reg_offset(adev, type, regSDMA0_SD=
MA_CNTL);
-
-       sdma_cntl =3D RREG32(reg_offset);
+       sdma_cntl =3D RREG32_SOC15_OFFSET(GC, xcc_id, regSDMA0_SDMA_CNTL,
+                                       SDMA_INST_OFFSET(type, regSDMA0_SDM=
A_CNTL));
        sdma_cntl =3D REG_SET_FIELD(sdma_cntl, SDMA0_SDMA_CNTL, TRAP_ENABLE=
,
                       state =3D=3D AMDGPU_IRQ_STATE_ENABLE ? 1 : 0);
-       WREG32(reg_offset, sdma_cntl);
+       WREG32_SOC15_OFFSET(GC, xcc_id, regSDMA0_SDMA_CNTL,
+                           SDMA_INST_OFFSET(type, regSDMA0_SDMA_CNTL), sdm=
a_cntl);

        return 0;
 }
@@ -1620,11 +1707,17 @@ static void sdma_v7_1_dump_ip_state(struct amdgpu_i=
p_block *ip_block)

        amdgpu_gfx_off_ctrl(adev, false);
        for (i =3D 0; i < adev->sdma.num_instances; i++) {
+               u32 xcc_id =3D adev->sdma.instance[i].xcc_id;
+
                instance_offset =3D i * reg_count;
-               for (j =3D 0; j < reg_count; j++)
+               for (j =3D 0; j < reg_count - 1; j++)
                        adev->sdma.ip_dump[instance_offset + j] =3D
-                               RREG32(sdma_v7_1_get_reg_offset(adev, i,
-                                      sdma_reg_list_7_1[j].reg_offset));
+                               RREG32(SOC15_REG_ENTRY_OFFSET_INST(sdma_reg=
_list_7_1[j], xcc_id) +
+                                      sdma_v7_1_inst_offset(adev, i, sdma_=
reg_list_7_1[j].seg));
+               /* last register is GRBM_STATUS2, read it separately*/
+               adev->sdma.ip_dump[instance_offset + j] =3D
+                       RREG32(SOC15_REG_ENTRY_OFFSET_INST(sdma_reg_list_7_=
1[j],
+                                                          xcc_id));
        }
        amdgpu_gfx_off_ctrl(adev, true);
 }
--
2.49.0

