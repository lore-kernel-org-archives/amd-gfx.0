Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 846C810A3D89
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Mar 2026 12:29:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 29F0C10E04F;
	Thu, 26 Mar 2026 12:29:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PIW0rPMH";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012062.outbound.protection.outlook.com
 [40.107.200.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1CA1A10E04F
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2026 12:29:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dhy5KxXt2yEKOJl75slQRiQGhr9I5ooteg3VUV+Q6WT0w8byBDpj1sxqX2Rp+sRgsePI0Qq68rauZAnTFfJNrYUM1wGxoucC+4FQLR5ogRzzN3qxZHLy0wvwPBezkMZVAhbE8l6b4PupOqO5UecsdsChD11Avt9SpH6mgImOoLgIh1okemkooq5y7/GmRAG3ae1OxRA1aBdh8CBi7YLRhtuAvhwCabsWQOaXxajOPKD5ai9jla6rUwYRxPKl0t+A+Zx6cmDoDqZDByrRCzmufxEZ0Q2callrzX1AbJkSLBzpFmSvO7tfJUSJV3P76+FhxTnSaYapLldh9y9vg3F0ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OxGFhCvS6YEd99xlJyVqHG2E9uMPb0KVvHsDyv0fP5U=;
 b=yr0j1XCId3CrpJBSUQgfAxHnZRH9Yrg+vEN2rO53MSiZkV/TE91tE78RWnh/lGHX4nGK0QoPyBSFpC41ADVdV8X1MtQAKa1+wSlQFRpADuMcPZPE2AUkDcwFwcIpcEsePJyYyDFNEqV8NGdyYCaGrqC//eRmd8kbCjNCNftI5ExFOvUbAyj1yoWyvzCOb4EXDZ+Brs8GvWWdqTWAPVjdJEDi3312SG3+YgOLXWh2VdhpDylpWPKutk++uTvouD/lKBTw7w8mIiapZxi3/nu3Hcfn+GZuWok5b3QXum9dv74XQ82b9fIwCuH3qOSrHBieFV5nAFmhaILqChkKb4uifA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OxGFhCvS6YEd99xlJyVqHG2E9uMPb0KVvHsDyv0fP5U=;
 b=PIW0rPMHiO5dpB7SkMUwj8gES/AeAQcgpxvPLYJS5wC2UGTdvQGPm57HnJpfYrN0hOmPQ7gVx3sfsbKdJI8Dk0WoC5appQQ7UH0wtW0G6Ek6rW+tMRqT+pFcaKV0s9trrj4jIsFPTfoM+zFDpaIQIsUW8J+nrpCXBKNaOi2vNLI=
Received: from BYAPR02CA0063.namprd02.prod.outlook.com (2603:10b6:a03:54::40)
 by MW3PR12MB4475.namprd12.prod.outlook.com (2603:10b6:303:55::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.8; Thu, 26 Mar
 2026 12:29:38 +0000
Received: from SJ1PEPF000023CB.namprd02.prod.outlook.com
 (2603:10b6:a03:54:cafe::ea) by BYAPR02CA0063.outlook.office365.com
 (2603:10b6:a03:54::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.32 via Frontend Transport; Thu,
 26 Mar 2026 12:29:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF000023CB.mail.protection.outlook.com (10.167.244.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Thu, 26 Mar 2026 12:29:37 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 26 Mar
 2026 07:29:37 -0500
Received: from bencheng-dev (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 26 Mar 2026 07:29:36 -0500
From: Benjamin Cheng <benjamin.cheng@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 <amd-gfx@lists.freedesktop.org>
CC: Leo Liu <leo.liu@amd.com>, Ruijing Dong <ruijing.dong@amd.com>, "David
 (Ming Qiang) Wu" <David.Wu3@amd.com>, Benjamin Cheng <benjamin.cheng@amd.com>
Subject: [PATCH v2 1/4] drm/amdgpu: Add bounds checking to ib_{get,set}_value
Date: Thu, 26 Mar 2026 08:29:16 -0400
Message-ID: <20260326122918.3486416-2-benjamin.cheng@amd.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CB:EE_|MW3PR12MB4475:EE_
X-MS-Office365-Filtering-Correlation-Id: c17c9556-95be-4b41-80ff-08de8b335867
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700016|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: 2zS0XmiyGuONT17WNRBcUDaoKOlvP3C1Jx/LCjAqRd98DrjV6THpbXV6EKxYHb00AhWl9O2f4bTFh3ldo3lw7Hf4iOO/VPAgUHDUp5NLoOQ2cMmN2qjVjDIbJo7QnoKr02566UJHxiEbT1Y9R/+6YJVdeUtka8ukjTjwMt+Lr5EHPWT3DUUEvi5Djlj6L+nWd3g5Xx0Nhk1GMDZZdmEKm0K71EZkudAVqlqlk+Xd7Z1bJCDM+dXgvhK4se5fCRyywDNUd0MOTiZlHCyb2CesKlFrkZ7A2YjG6qh3mAC2onvmyNF4ZmGL1SpLkHCo2lX68OCrBsud5aEoEK81/7MaEld98kmNhZil2RDL1G4oewmxUnw5dXtDJUjZp8+BxC7nc/YG/bxRE/GowBWxWDjlNUBjRbePbCUCOjangilQGnm9hrxnFaQNX3z6VxJbSoCFNfMCfrO6IqDM2MHPDYCBXhvqFnRXpZlKu3NChrNyp1gn1Ym/U8u1Pdvdrd5tlEoE5wn7wg1KnyqclhDDQ9ekmkaOlTtw2d/x+K9jH2NvfMpZnJUf+NnXoaEAyJpz+0OoerAwd2GfHvjfxc5vCnD/mtkLfRniA6Xqkiu976QsvqqsEMxl2iZc7akdfpM6zTShVubfcGI2z7phacGS9v43CJ++3PbmqDftkJnTNgzTUCV9KDAVcBOEgDKxr1+IZJuxMyaVrHTgUeNsjvwSHYaaZ6dDsSAEb3k/X22kseG2Rlu1+dsd3Q6UospZ4mGEtJazqodqgxQ2lhC3EUqK5AfiVw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700016)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: hyG9grb/HWyniv1IOAORcL6iod/zLrZR30rQUJVat4bHeU/6R4+GsjRrPiEBIBkS2F4bFEG9UuMV+Rcakz7lGf8ZzGK36tYVMp+aJySaZa4iuzllvJ3Im+D9P4rViBzoH9BglXY2eSZJFlOqTzNeUmlIr0Xr3Kc330YAga7ugzf+Xj9VemgkoCjDMBhkv1HNDG6psTppJmC8UjbxnOxoV6720qkLQh9zuERqTyp/tSQr3RxdQeRi975GWXOBP7+bjXPTCB6nOR1+T/+TC43l1bmGasayPHmgkSUi2ztSooDvO+KUdfyDGjCCSj6QpPKDME7MU0/v70eWVmDrLrj7ujhIIR5KNPZ0SCNWHbBzV6PkhtZeqnHGEhWTqoYii3MQvp+iTQtjnTN1wdZ//Y4t7aOfJGC/jsvcsg+nxePELIlWkgfvPeMp4G4e0uj1v+T4
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 12:29:37.5336 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c17c9556-95be-4b41-80ff-08de8b335867
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023CB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4475
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

The uvd/vce/vcn code accesses the IB at predefined offsets without
checking that the IB is large enough. Check the bounds here. The caller
is responsible for making sure it can handle arbitrary return values.

Also make the idx a uint32_t to prevent overflows causing the condition
to fail.

Signed-off-by: Benjamin Cheng <benjamin.cheng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index ce5af137ee40..715c9e43e13a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -559,15 +559,18 @@ void amdgpu_debugfs_ring_init(struct amdgpu_device *adev,
 
 int amdgpu_ring_init_mqd(struct amdgpu_ring *ring);
 
-static inline u32 amdgpu_ib_get_value(struct amdgpu_ib *ib, int idx)
+static inline u32 amdgpu_ib_get_value(struct amdgpu_ib *ib, uint32_t idx)
 {
-	return ib->ptr[idx];
+	if (idx < ib->length_dw)
+		return ib->ptr[idx];
+	return 0;
 }
 
-static inline void amdgpu_ib_set_value(struct amdgpu_ib *ib, int idx,
+static inline void amdgpu_ib_set_value(struct amdgpu_ib *ib, uint32_t idx,
 				       uint32_t value)
 {
-	ib->ptr[idx] = value;
+	if (idx < ib->length_dw)
+		ib->ptr[idx] = value;
 }
 
 int amdgpu_ib_get(struct amdgpu_device *adev, struct amdgpu_vm *vm,
-- 
2.53.0

