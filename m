Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 108C8C5474A
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Aug 2024 06:12:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 33B9F10E40E;
	Wed, 28 Aug 2024 06:12:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EisfivGo";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2043.outbound.protection.outlook.com [40.107.92.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0633B10E40E
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Aug 2024 06:12:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K85q2u3j5sma6oWeZxuc2p7otgAGuyBLzpNFtqAcqgYLJK1XJoJFCUbA2xi/Zxw3UZ2zeGTvLkKVOWvVgAwdITFnTF4bspHpWUgcw+9GIRuDWWjIoUZmZJoAicBV0/juksfd8kRj7RfwfSC64vhJ5Yf8z98ktlST+fPu45hXMxZRQDMR9bEkk6Nn5KY/3WTrRaWzKcjcMGbArOnaq/zJufth2yFuM1tdwAnD5jd+33IqScIRwT6jTlB1lPA966R5GmOLyHeEQq8Q44pY7vzT3yxdrvwgj91qmDx8pgV3Y0sNiKR/huWOuBogECgLro2rI/ZLwN0LpqT/CPb6hqoLPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9EdZA3wRWO3e5PD3ENhVkqWg9IfU8KMLE+WgoyWW5Ng=;
 b=EiImQYeRBuhWgR5SpXK+4nruV5op0+TK5Y9ncvUZyWqoh9+JXcjv02dKnxeXGsQr3+rdTC9ohY68pVSL9dtM2AW8CysdbB2MUOQRnR5z1VUToEld+rmAQB9ZzOUut+bVAGo6DSSoAe25t98Xqf66GMA4SUJrzI876D28cQ0S3CoNuCwRMgALJRG8eyGRaCU6+cPPOnSrqigUIACJxgixSWwsN3ardeCd87RUQMQQrLVc17BqG6+2uvpI1ee2+CyH0b5QrdcZ4g/cPFla2Do/jJX/qsKji9rmVO5FutAbNITKIZF/WSooEOAAvu3rFUylvItFe6f0jnWkP07WR991Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9EdZA3wRWO3e5PD3ENhVkqWg9IfU8KMLE+WgoyWW5Ng=;
 b=EisfivGoOEvVagBtO8idOmabDXGDF1zA0Vftzn0gz2FV97mLUPgwFYc96Ws+RcD1yKhrNRATwpctQIQEPwN1dbaIhw56JzTMwdIWcfJOADQcHP/twLAuTuf09NLvwDvc+KRuSRWXxY3G6izSqVwNBN/2HFjUxS808mQsDFQaVtk=
Received: from CH5PR05CA0008.namprd05.prod.outlook.com (2603:10b6:610:1f0::17)
 by SA1PR12MB6775.namprd12.prod.outlook.com (2603:10b6:806:25a::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Wed, 28 Aug
 2024 06:11:55 +0000
Received: from CH1PEPF0000AD7C.namprd04.prod.outlook.com
 (2603:10b6:610:1f0:cafe::6b) by CH5PR05CA0008.outlook.office365.com
 (2603:10b6:610:1f0::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.16 via Frontend
 Transport; Wed, 28 Aug 2024 06:11:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD7C.mail.protection.outlook.com (10.167.244.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Wed, 28 Aug 2024 06:11:55 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 28 Aug
 2024 01:11:52 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <leo.liu@amd.com>,
 <jane.jian@amd.com>, <sathishkumar.sundararaju@amd.com>
Subject: [PATCH v2] drm/amdgpu: Normalize reg offsets on JPEG v4.0.3
Date: Wed, 28 Aug 2024 11:41:33 +0530
Message-ID: <20240828061133.1880057-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7C:EE_|SA1PR12MB6775:EE_
X-MS-Office365-Filtering-Correlation-Id: 6222b6ad-96eb-4032-24fb-08dcc7285142
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8R92kl/KUkHHo0g4XP6ScID9XXrAYdPYB3aCrhr0GOEMrYP8rWgjWfrrXi1h?=
 =?us-ascii?Q?as83xBkSpU303h0mSAQTWPXdWnaNXveGfMwLiPAcB95UQ/kh4bv0KhDzXGTg?=
 =?us-ascii?Q?nu6i5zd0I8+yUqhyJCIkZmYg7UwQGprf5hSezkxCSiZ5sFMoIQ82qZmER+TC?=
 =?us-ascii?Q?8wHtk7sLErb5KPDTwC80dgiB37iJukFuEZQYI6RU2wmCuPINbFlP0yk9zgU9?=
 =?us-ascii?Q?MkzpR5aJNY3A5woeei92MJrsvMEMp9rTLj3c5spNzXx3h/iqwhPA4s+7Mm8r?=
 =?us-ascii?Q?SZYiaQ822ffvxqqeF8y7gxZrklqJcabmOMdMxA9wHNFckd3SXTqRTvsBe8j+?=
 =?us-ascii?Q?9ZznlK3WnhoqBNKhnz7tfHX3nTzlJqFdljWghxMwHlz10cIgVZDSKRPczB6N?=
 =?us-ascii?Q?h6dpg77rWzQqzdIqXKmu7m9wLjXjPk+ChYdmzXli8Cqb3fgZz4DRtmarim/I?=
 =?us-ascii?Q?Aty4DoTQ2CtBQeoLQtehBqdAplL1nv82c/V63Wup0b0S8V4ndkF5z3T8IDJq?=
 =?us-ascii?Q?nXf2ZVxW4AfrW2InB40hJ4E18zbbLfrt3wlQimPOawEr+SF1DBlaLS72T8MP?=
 =?us-ascii?Q?dyiwNZvBe9pf/7FG6P3q+7Auj/zAJmxvRka7ITXkxE5r3Jhf09x11gPnWsI1?=
 =?us-ascii?Q?OOsb/WTpTZVB0NMcl8W4eSq9x7hiI9dxaTbWERJJ5hEMY/81Ea9EP0geJmpe?=
 =?us-ascii?Q?9P7JF2/6xB3qhTViP96EZx5Hr9Az5FwLCIUzxpUsqAGeiJLce/RNER+spU5U?=
 =?us-ascii?Q?YA8IUy9gXNYSYvAGvRaaIHCVYQdjj32mRP+6lb8Oj5HJe/zXgYZ4mD4TtMfv?=
 =?us-ascii?Q?Q48IEiDLylVODXZRGbgnYSM/FnGMt6I35ZHEYvRNw+ldtwGEfS/qIgpX27FJ?=
 =?us-ascii?Q?AVnehvpvPGD0sByN45ztVV9Z459IQOAY53rYR2t/GasP51Gg9JJJFtLm8IS9?=
 =?us-ascii?Q?lLvjq6Tj+OQFZvAGMBOwF2okGFP3k4WqUMIQDdL4VWWpJWvkDNHaNIuCNxy2?=
 =?us-ascii?Q?8UOb5u2ikvRXIkAv4b5UQ/KzsTFtQpAganug34uUcOfJJ9Bcq6OqyN5l1cu4?=
 =?us-ascii?Q?UxRRmoptAerAQzX0izx2AVwW0vNk1Ul2iJNaeGdb5XYFDTvWLbvEry7m9qBz?=
 =?us-ascii?Q?z6NV7tcAOuK9Tbv2qF0X8ORbfSrnKn0BKcqqYXZAzHSGL9GZjukgGFPKpnp/?=
 =?us-ascii?Q?eGQSoxXIqgwz1XIf2yIhZ1AvGUWSZ4O1W0wwdJxDnJd4QVl8Lsmlh/Voymo/?=
 =?us-ascii?Q?+mT7NhCZEUl9jVBq7fX4qh2HnYg66osk1EDn9eI2gbwd8sWeYDVs8jNpuujD?=
 =?us-ascii?Q?MC00LFMlj94ZJkirX8Sd9VAmZpVa9JojbL7syJhP7xZ7SfwElimREGATgHGR?=
 =?us-ascii?Q?4GnO6RtR2+cLFcxeJZfV3NVWc96Ch8FbRTQHxESqM5DTDWQjPjjuVUFfmAdr?=
 =?us-ascii?Q?cCmdAayRB+Tdibh0fUBv7M+8Ww8IcEbt?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 06:11:55.4895 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6222b6ad-96eb-4032-24fb-08dcc7285142
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6775
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

On VFs and SOCs with GC 9.4.4, VCN RRMT is disabled.
Only local register offsets should be used on JPEG v4.0.3 as they cannot
handle remote access to other AIDs. Since only local offsets are used,
the special write to MCM_ADDR register is no longer needed.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
v2: Restrict the change to GC 9.4.4 on PFs.

 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c | 36 ++++++++++--------------
 1 file changed, 15 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
index 6ae5a784e187..a4ebceaaa09c 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
@@ -59,6 +59,12 @@ static int amdgpu_ih_srcid_jpeg[] = {
 	VCN_4_0__SRCID__JPEG7_DECODE
 };
 
+static inline bool jpeg_v4_0_3_normalizn_reqd(struct amdgpu_device *adev)
+{
+	return amdgpu_sriov_vf(adev) ||
+	       (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 4));
+}
+
 /**
  * jpeg_v4_0_3_early_init - set function pointers
  *
@@ -734,32 +740,20 @@ void jpeg_v4_0_3_dec_ring_emit_fence(struct amdgpu_ring *ring, u64 addr, u64 seq
 		0, PACKETJ_CONDITION_CHECK0, PACKETJ_TYPE4));
 	amdgpu_ring_write(ring, 0);
 
-	if (ring->adev->jpeg.inst[ring->me].aid_id) {
-		amdgpu_ring_write(ring, PACKETJ(regUVD_JRBC_EXTERNAL_MCM_ADDR_INTERNAL_OFFSET,
-			0, PACKETJ_CONDITION_CHECK0, PACKETJ_TYPE0));
-		amdgpu_ring_write(ring, 0x4);
-	} else {
-		amdgpu_ring_write(ring, PACKETJ(0, 0, 0, PACKETJ_TYPE6));
-		amdgpu_ring_write(ring, 0);
-	}
+	amdgpu_ring_write(ring, PACKETJ(0, 0, 0, PACKETJ_TYPE6));
+	amdgpu_ring_write(ring, 0);
 
 	amdgpu_ring_write(ring,	PACKETJ(regUVD_JRBC_EXTERNAL_REG_INTERNAL_OFFSET,
 		0, 0, PACKETJ_TYPE0));
 	amdgpu_ring_write(ring, 0x3fbc);
 
-	if (ring->adev->jpeg.inst[ring->me].aid_id) {
-		amdgpu_ring_write(ring, PACKETJ(regUVD_JRBC_EXTERNAL_MCM_ADDR_INTERNAL_OFFSET,
-			0, PACKETJ_CONDITION_CHECK0, PACKETJ_TYPE0));
-		amdgpu_ring_write(ring, 0x0);
-	} else {
-		amdgpu_ring_write(ring, PACKETJ(0, 0, 0, PACKETJ_TYPE6));
-		amdgpu_ring_write(ring, 0);
-	}
-
 	amdgpu_ring_write(ring, PACKETJ(JRBC_DEC_EXTERNAL_REG_WRITE_ADDR,
 		0, 0, PACKETJ_TYPE0));
 	amdgpu_ring_write(ring, 0x1);
 
+	amdgpu_ring_write(ring, PACKETJ(0, 0, 0, PACKETJ_TYPE6));
+	amdgpu_ring_write(ring, 0);
+
 	amdgpu_ring_write(ring, PACKETJ(0, 0, 0, PACKETJ_TYPE7));
 	amdgpu_ring_write(ring, 0);
 }
@@ -834,8 +828,8 @@ void jpeg_v4_0_3_dec_ring_emit_reg_wait(struct amdgpu_ring *ring, uint32_t reg,
 {
 	uint32_t reg_offset;
 
-	/* For VF, only local offsets should be used */
-	if (amdgpu_sriov_vf(ring->adev))
+	/* Use normalized offsets if required */
+	if (jpeg_v4_0_3_normalizn_reqd(ring->adev))
 		reg = NORMALIZE_JPEG_REG_OFFSET(reg);
 
 	reg_offset = (reg << 2);
@@ -881,8 +875,8 @@ void jpeg_v4_0_3_dec_ring_emit_wreg(struct amdgpu_ring *ring, uint32_t reg, uint
 {
 	uint32_t reg_offset;
 
-	/* For VF, only local offsets should be used */
-	if (amdgpu_sriov_vf(ring->adev))
+	/* Use normalized offsets if required */
+	if (jpeg_v4_0_3_normalizn_reqd(ring->adev))
 		reg = NORMALIZE_JPEG_REG_OFFSET(reg);
 
 	reg_offset = (reg << 2);
-- 
2.25.1

