Return-Path: <SRS0=fVrT=PO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCEF7C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Oct 2021 14:47:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81281603E5
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Oct 2021 14:47:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 81281603E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 32FF489E5F;
	Tue, 26 Oct 2021 14:47:42 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2081.outbound.protection.outlook.com [40.107.95.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3FCAE89E5F
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Oct 2021 14:47:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gjwQKmS/nN67ZAiLjc42BZE9zJNKvnU/bMuzUpnR7rdCftspcT1EuOGI3MD1yDzaNm/5Tb69C5gV7FEP1C2ZiIngqavvKCIgnxN3EI6y5jy4m2Xt6yhuvdIg1Z2x+rtisLRnu+u+b1BQkROQ7j+GOiKbIV7SLmgHJlF/sLM7J0nrd7m+X2yR1bw/YnKwydUrti317BkbDJ94rOHCjNcyxoq2IN76y12zWOgQeGBP3WGbsQ5uyI/rTNK4T0NSDjBVvORG5jsqiAtNQgkTVplSXVxY7ITbBPc2OlV43IB38z7gO6LxiZEVcV4bBU4Vqe4aAYfyJP+/9IGV+FzfJ6Bsiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9dhvs4NhECODQ8RDlAaBJzevmBZZomRf7HLg19SPZgo=;
 b=Tj41PcYuvYhZpigOpDRdLc90sbQG/TTZMK7jDNaxiIxxBv2Z762u49QVDHvRIXCCOdFtGs/dafxZi05mrJiVLaoQVc0bJLe9v51Oszn+LIrxBcR9Aar0YWruSejD0PJjZc6VDKDpUtYQO6GbBdg7q16KVkVsq1d9h9nwS+6CkC0fNH5qkEliwh4GTAU8r22LAV0bM0tFwUDQ28HQCVNJ5L+VHz4RwRYFeuRquaRucuMfEb7xaz5GX2Q/1GVHjLNfHw3fyUdCTVkwPGHi+af+0I8oz9l9IfH++85JjHPFndD7xd5uSC6xIyIY2eueBYpz3RWsNOt2/PhKBfjmaomHFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9dhvs4NhECODQ8RDlAaBJzevmBZZomRf7HLg19SPZgo=;
 b=rKww6rjGBOCbASL77UVwmTeGH4xf4CFsRp3Qpzn4WbQPKfUyrZSmuz6CfYnPU+lVKoJdqVEP253WlhdQEorBMeYqCS00vXdUZTlpME+Geuzq6rSBH1n0mKRKS1aQb/Qs8UHcs/Pwfs5BsjmPcLiLxCdsZoFBcyVQCVLoF3r6SqE=
Received: from BN9PR03CA0569.namprd03.prod.outlook.com (2603:10b6:408:138::34)
 by CY4PR12MB1224.namprd12.prod.outlook.com (2603:10b6:903:39::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Tue, 26 Oct
 2021 14:47:38 +0000
Received: from BN8NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:138:cafe::3d) by BN9PR03CA0569.outlook.office365.com
 (2603:10b6:408:138::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.22 via Frontend
 Transport; Tue, 26 Oct 2021 14:47:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT003.mail.protection.outlook.com (10.13.177.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4628.16 via Frontend Transport; Tue, 26 Oct 2021 14:47:38 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Tue, 26 Oct
 2021 09:47:37 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu/UAPI: rearrange header to better align related
 items
Date: Tue, 26 Oct 2021 10:47:26 -0400
Message-ID: <20211026144726.191916-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 83c2db50-ddec-483c-cced-08d9988f8e0a
X-MS-TrafficTypeDiagnostic: CY4PR12MB1224:
X-Microsoft-Antispam-PRVS: <CY4PR12MB12242A1AF1B69EC88B59D28FF7849@CY4PR12MB1224.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:551;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9p/elWfW9Vr1e7ZGp0/RqWiAmug31lLqyYFoPZvsQk/qQ/RumSknxR4K5+5415uMs5fKwwFG0B1k9QURKCLltCrsQSfg40TP73s4vy+D/QI5y38EfnpV5VRCYaC79+c+vyY1Pjtxai7Pwbh2UsIpOz+S1o8l6n1Zvu4VfLwaN4rvPi8M04b6DH703Y2VLRZb+rpswPNZLVDhN1SCkHafh6/SpC2tah1N5qAERKbrYSWWdeATVUKjBOHM3rj8HqN8sjZNgeSb/MV2LC0zxTd8mWXzqjt3wZvjkg2LzjmCEJ6xPX36SpmvlNdPfqasN+IpXa20JWpWs2yyUelc0uLbawAqXSAaywNiSIB1rvO+1WKAXZP29F3KneITYp21j1w6sBdymwfjnF0zO08nloVUTf2hctaAvnsmNv7gXE5JBiEleAryfN46OLl/B/BpVQ3MZfqW3iVRQDSxLL0EAR1iAEfNRT60+dH3FdNJ5SPyKL18NfH3+dysh4JF7jhCHxzPPw2XPyMQRbWcX3UL1VORlAKSE4r1A7fikLUR9YxGMBIJgH5vCckPjYJbkNpb9Yr6vPmHdEV++YZVAKrf2B4Sd8pI8qLWfrRxMAe4Pf7X7DQy8hN7COAdnXXc0ccEe2y54aFP+eDpfG3Il2LIjBgbtmueDkDag8h2OomUMKNzet1RRQeBrNa1OCCDbqFtEtk/zUp/8xIwrlG3akE1MFv53GM0mSv8bWNHbBKnG4L0u+M=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(82310400003)(426003)(8676002)(1076003)(70586007)(8936002)(336012)(81166007)(70206006)(2906002)(83380400001)(508600001)(86362001)(6666004)(26005)(5660300002)(4326008)(7696005)(36860700001)(2616005)(36756003)(47076005)(6916009)(16526019)(356005)(186003)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2021 14:47:38.0023 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 83c2db50-ddec-483c-cced-08d9988f8e0a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1224
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

Move the RAS query parameters to align with the INFO query where
they are used.  No functional change.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 include/uapi/drm/amdgpu_drm.h | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 0cbd1540aeac..26e45fc5eb1a 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -786,13 +786,6 @@ struct drm_amdgpu_cs_chunk_data {
 #define AMDGPU_INFO_VRAM_LOST_COUNTER		0x1F
 /* query ras mask of enabled features*/
 #define AMDGPU_INFO_RAS_ENABLED_FEATURES	0x20
-/* query video encode/decode caps */
-#define AMDGPU_INFO_VIDEO_CAPS			0x21
-	/* Subquery id: Decode */
-	#define AMDGPU_INFO_VIDEO_CAPS_DECODE		0
-	/* Subquery id: Encode */
-	#define AMDGPU_INFO_VIDEO_CAPS_ENCODE		1
-
 /* RAS MASK: UMC (VRAM) */
 #define AMDGPU_INFO_RAS_ENABLED_UMC			(1 << 0)
 /* RAS MASK: SDMA */
@@ -821,6 +814,12 @@ struct drm_amdgpu_cs_chunk_data {
 #define AMDGPU_INFO_RAS_ENABLED_MP1			(1 << 12)
 /* RAS MASK: FUSE */
 #define AMDGPU_INFO_RAS_ENABLED_FUSE			(1 << 13)
+/* query video encode/decode caps */
+#define AMDGPU_INFO_VIDEO_CAPS			0x21
+	/* Subquery id: Decode */
+	#define AMDGPU_INFO_VIDEO_CAPS_DECODE		0
+	/* Subquery id: Encode */
+	#define AMDGPU_INFO_VIDEO_CAPS_ENCODE		1
 
 #define AMDGPU_INFO_MMR_SE_INDEX_SHIFT	0
 #define AMDGPU_INFO_MMR_SE_INDEX_MASK	0xff
-- 
2.31.1

