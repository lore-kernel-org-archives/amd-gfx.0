Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 995EAC3DA4A
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Aug 2024 09:31:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4BDB710E585;
	Tue, 20 Aug 2024 09:31:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Xb3VB2Fm";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2080.outbound.protection.outlook.com [40.107.93.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC30B10E585
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Aug 2024 09:31:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W0U7gz0bWfO17tGGOMPHI27BVu16aq68K3N3Qq/EKXNXi8pJTumveBt3yVLYN/Kp7IDNaKOvXypYXXyu6FcMsB6X9K0RJBPcvmXnzXddVZsqsR6oDnG2/v2FR+EmHPoSAa4kjh6rsqkLcG/ZL8aSezkPuDyFUqaDYKGZ3HB/gajEfdARLyEDoBDo56foH+HcVma6mDJlOa1e8DHIzasIoeyfzekUuXIAHhANYUvy+5g+jns783y1r3FhQL0YLkqn4HMUCK2poqhLDQehazhRZw/NFznYvuoNvSPJeEvImvqrRhl5WcILzfnu3DlXB3zEciNYghcRVUkxrbxzvnk3CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z2rObT/TDMlRf3xfjm/ytu9RYrRunzdjE46qrojZ/F0=;
 b=UgcgeJSOiBHwdlw3vA/bI45fXwx+uyQz1yCaO5T5Ww0+3mn/4o0RpsH1DQl1LzOVzL8HJR7Ym66TZUcEEwU1ySPwLvyFbUh0LGc/ozsFMCpc+AH13INmsdZSnrCNfea0sPPVxsGrz+vtG9AninC/+XqG6FSv8WRU1cKqAUBGbpxEnPNpaHVsmxOp0d9kN4VQn0NO1rnJnx6taOtUqzDNlgP1o5u6IkL9YRJv9VJtf8LWvBwhdLe7xD/J85i0Mh1ThKqz5BbP7s0EGppsUCGelHhVxgNaH11snfwGUsoocLqTgcE8h99/rfTdL8oXkoItqi5OD5GcnP5p9K0wbz20Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z2rObT/TDMlRf3xfjm/ytu9RYrRunzdjE46qrojZ/F0=;
 b=Xb3VB2Fm3tS5x1Vq8l7Tp+SBKGTjc8zSfh7WqrisHimoT0KX0cctqgtLgbfBjVwG+w8rux3UJ5AQKD1lVppZtLf4JWVcX/1JOQGEmK83gQNanc83RrJpAWbFZrnGjnrciPkl5Nl1IOXpP7/udV7TEhpk1J0WWI3A9gVs2ylW0ms=
Received: from CH5P221CA0019.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1f2::26)
 by PH7PR12MB8124.namprd12.prod.outlook.com (2603:10b6:510:2ba::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.16; Tue, 20 Aug
 2024 09:31:42 +0000
Received: from CH3PEPF00000015.namprd21.prod.outlook.com
 (2603:10b6:610:1f2:cafe::6d) by CH5P221CA0019.outlook.office365.com
 (2603:10b6:610:1f2::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21 via Frontend
 Transport; Tue, 20 Aug 2024 09:31:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF00000015.mail.protection.outlook.com (10.167.244.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7897.4 via Frontend Transport; Tue, 20 Aug 2024 09:31:42 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 20 Aug
 2024 04:31:39 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <leo.liu@amd.com>,
 <jane.jian@amd.com>, <sathishkumar.sundararaju@amd.com>
Subject: [PATCH] drm/amdgpu: Normalize reg offsets on JPEG v4.0.3
Date: Tue, 20 Aug 2024 15:01:23 +0530
Message-ID: <20240820093123.1780101-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000015:EE_|PH7PR12MB8124:EE_
X-MS-Office365-Filtering-Correlation-Id: 83a37c90-c9df-496a-31b2-08dcc0fae6c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+s+/8NNpH8ZYMJaEwkbP0OG4MXvVQipvKrX7N9BEOYLUTq+AIpqwZwdLC5ZW?=
 =?us-ascii?Q?yRN66PW9fqJsr/QFXywmq8uEbK07IxnzFc1fLwri8eN4roHKMwhQczmHUgDv?=
 =?us-ascii?Q?zMH7s//NvfdeQwNOvk6Bl6jPenf2wSj8vhmwnnioNo1MEMyxd63jAf3uITJt?=
 =?us-ascii?Q?SZhm0iD6ZqS6v54ccVjQjJdrYeq4h+LTwMdzSsvjeWOuR4eRCRNi2jQRD5NJ?=
 =?us-ascii?Q?o0DFGOdbGIeo8uxXl4gAnzvYLkWNtf9SXTVhbcPQBh5aC3gV4e+8HYftD4X0?=
 =?us-ascii?Q?x1rZ9eQH4LtRmmkGzpPdu4g3qiHCELS+VxbYubHFuIHwW4kZv0xn2SqsYTqY?=
 =?us-ascii?Q?MPfbIK4L7nFCxu9tC8yBSHBtYr8YOrdgk8B5yo7mpWBEdUBapoMNFe61/sv8?=
 =?us-ascii?Q?6ycMclDwghUllGebrLpi83eOqObxTBwkdp6oZC0X+PeaupON76xI/bhbk/9Z?=
 =?us-ascii?Q?D2QAoem7USeEHTxgsyhnfL4mmqgnVpm1VEZtsYpkf4zPgcRjOLSGLDRZ3NfN?=
 =?us-ascii?Q?wapYHylsdgrhkevlHqULCeC27RSmpq2Wm3WWcmAlEriBlyvkvMWacINbTDTk?=
 =?us-ascii?Q?XriX08pOAGS8iGT7TdAsZjVfQRXuL3V9qBeu7JKovAOoo8+85PS78F3UcHZ4?=
 =?us-ascii?Q?LzCw/L87Xq2wI6RZW4aqoC8PYeWRQQwhMkRMChNg60p6wJs7KlHzzqnIoAn8?=
 =?us-ascii?Q?Q6zeeBYRaIeZ9oRH7DUxBOVQdovfpCe/2MMaD5RBF0CAOb8/14Y6ELDyXivS?=
 =?us-ascii?Q?nXgD1Z3BbjcJ5mYeIRS3Vp/72blGXRpMbDDDYNxH1aW3sKXCT4VFAGLFOIvF?=
 =?us-ascii?Q?X6yWd1WL4CDvKYnmb5Tv6O+WrOf5gMP9QVwdofimraQq+3e/1fq1EKuuVefR?=
 =?us-ascii?Q?qVoQ3qYooyUFQ3vdFs3dxNNcK9gnRz5M66gAqZToINdJRNDNql9ewNDBWLcl?=
 =?us-ascii?Q?5SlbQYwXtm4xnUlA8NC8C/p1r87hu9Dj55ThkKd7IIsrWbBTju+m7ocx1anw?=
 =?us-ascii?Q?Dq5lIENK10zsxOBkw/G3Pn5er1D7wTumqLpqDodhd4tWsZV+/ZIK2utWMwcD?=
 =?us-ascii?Q?hWFEfaQTBh4M5RrelyZhEjPLuqRYmE0knX2EtgB89BRn3r7Sh23036RaxQYw?=
 =?us-ascii?Q?hMyBsJT4eoMlY8wvub8FsVWYl7+6IOelCD7QNtfLAPaAN88S0eRAjZFA913G?=
 =?us-ascii?Q?jXZ4y8HnIMbtA/tlAe5ZwWN08O23KDZaWfW6w6bf9vEBb154n3f5lyK7iDgg?=
 =?us-ascii?Q?Ifetd+KxJkosctCAHZLoQ6inbrsIkGCCfxjh0gccZ36gQBb4EUqaU1ZAoU9J?=
 =?us-ascii?Q?i2LagvqISkb9x0DdT40UEJNeh643RPDXl1LrLxXAbDuznXe6SkjrNf6ovrqC?=
 =?us-ascii?Q?sluAAbGI5wp0MFyYFSVC2VEoKp92UBai7GbdP+6M6JpgzLMx9FmAB3VyvFOC?=
 =?us-ascii?Q?wBbiXD+66ccCSF1FeKvFeF9N2crRcWDx?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2024 09:31:42.4829 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 83a37c90-c9df-496a-31b2-08dcc0fae6c2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000015.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8124
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

Only local register offsets should be used on JPEG v4.0.3 as they cannot
handle remote access to other AIDs. Since only local offsets are used,
the special write to MCM_ADDR register is no longer needed.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c | 32 +++++++-----------------
 1 file changed, 9 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
index 6ae5a784e187..a07dc55c28ec 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
@@ -734,32 +734,20 @@ void jpeg_v4_0_3_dec_ring_emit_fence(struct amdgpu_ring *ring, u64 addr, u64 seq
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
@@ -834,9 +822,8 @@ void jpeg_v4_0_3_dec_ring_emit_reg_wait(struct amdgpu_ring *ring, uint32_t reg,
 {
 	uint32_t reg_offset;
 
-	/* For VF, only local offsets should be used */
-	if (amdgpu_sriov_vf(ring->adev))
-		reg = NORMALIZE_JPEG_REG_OFFSET(reg);
+	/* Only local offsets should be used */
+	reg = NORMALIZE_JPEG_REG_OFFSET(reg);
 
 	reg_offset = (reg << 2);
 
@@ -881,9 +868,8 @@ void jpeg_v4_0_3_dec_ring_emit_wreg(struct amdgpu_ring *ring, uint32_t reg, uint
 {
 	uint32_t reg_offset;
 
-	/* For VF, only local offsets should be used */
-	if (amdgpu_sriov_vf(ring->adev))
-		reg = NORMALIZE_JPEG_REG_OFFSET(reg);
+	/* Only local offsets should be used */
+	reg = NORMALIZE_JPEG_REG_OFFSET(reg);
 
 	reg_offset = (reg << 2);
 
-- 
2.25.1

