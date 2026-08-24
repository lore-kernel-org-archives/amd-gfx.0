Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5916FC61CE2
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Aug 2026 22:14:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D45A610E87A;
	Mon, 24 Aug 2026 22:14:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="W0tDG5Q3";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012046.outbound.protection.outlook.com [52.101.48.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 50C7410E867
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Aug 2026 22:14:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uPDUwOe90oE9Y2HVjTLmNBVlijLCSiZii1K/LDXaFhJ1d+MD8no+jlwlW1yUswXk57BJJ4ufA2dTVXaZ3FznMGugppt9tRBqO2rCqPdVI00Hz2YL0g5qd9DnEzF3Hp/TcliSU9zjEjFV1p1Pg7S/YDEyR8waEPDyOoPNgT7wqvcK9eUWK05qLuSf62PSzoctsq9NzbveET9O8vdkBh6ls2p6ukSk+eFwpmGzpvRCz5xrU5rEF+RV0mKsu0zLDoLeIjVUBaif2L/Z4USrCNzTO/2OwzCUm+nBrAg0ocvX6r4/lmS7wCIOgar/Tc4zqvE9Zk/uejy8Ui1nWtiptEmvoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b2hUW4WHDU8VN/VTQKpeWc3Po1hJPDCU1KjgJIiFP9k=;
 b=GDkwJiMa9etCduiE3rmTtAXDn/tR1SBDUjg6CEfw/v170nWSpSNtQ1SIOsHPc9yMzNnfXsbRNMMkM74kL9iXQiDChARGf8KX8PWrf4MSii51Z8dV2HYHD6z5CWySGEyUWNatCpCJoN9HOQvAFacLcRqfpNluYQ6g8YzJIpxdMry61JMMYNxCiN4thg/Q2SwAbkY9Ze2XoHTKmAVdROlj1bkeVWEK6beSd+Dhr61Cz8dflnnm+FD0EEDdxZuMnMmqd9rm1OkZGW7Wut5Ah4lEbtSIYLcX7fdXi4azPgLBduf/o6dg4kSqhPj3XP8BywFL4iMuGMLbeTo8KyvycdxWew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b2hUW4WHDU8VN/VTQKpeWc3Po1hJPDCU1KjgJIiFP9k=;
 b=W0tDG5Q3D7sueHADtfldhNazNUyIw3o7s6VH08E+1/t4ofF2eZk+hrWjBkrdNha1pU8Tbs+HRCJqbIm9Y2TmMlVV0DqwNwiAVo0BwW79QT96E5d/edKzVfDDE8zNYofVtqfNmxvHgOUEVppHk4YcZoxUMhLnOUGZPc4Td11UyPI=
Received: from DS7P220CA0017.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:223::11) by
 SN7PR12MB6743.namprd12.prod.outlook.com (2603:10b6:806:26d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 24 Aug
 2026 22:14:26 +0000
Received: from SN1PEPF0002BA4E.namprd03.prod.outlook.com
 (2603:10b6:8:223:cafe::2) by DS7P220CA0017.outlook.office365.com
 (2603:10b6:8:223::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.12 via Frontend Transport; Mon,
 24 Aug 2026 22:14:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002BA4E.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Mon, 24 Aug 2026 22:14:26 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 24 Aug
 2026 17:14:19 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Mon, 24 Aug 2026 17:14:19 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 28/30] drm/amdgpu/gmc12: use MES or SDMA for pasid TLB
 invalidation
Date: Mon, 24 Aug 2026 18:13:50 -0400
Message-ID: <20260824221352.1793542-29-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260824221352.1793542-1-alexander.deucher@amd.com>
References: <20260824221352.1793542-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4E:EE_|SN7PR12MB6743:EE_
X-MS-Office365-Filtering-Correlation-Id: 126a3efa-da31-493d-9332-08df022d0f7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|36860700016|1800799024|82310400026|22082099003|56012099006|18002099003|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: +x7n4m9u3QEhUoozUrZ847dDPDQyQZ3W1F4q7oL+wYYf1A5LxnYC/KIG0RqpAATdh3td91AWlvS470sbmFW+Lo02TAjXKRgQbVqYOdpfy87/1m3iY/As8cN4PBHi8DUlNuSxykCm5Odbh09rMq7w3enQqSvbfsx5/yXikRxzJOSIMiPPq86OVCkJXBqN8JRO5Q0kzGnjB/E9os7Nq18YorQQ9AqQf16G+ByzSF7oNDhvYPCH+CBvS3tzi7jHADTbBZgKGCO2fSeUbqjw8Nxzdxak9C+wgd44aZ3e/wa85oNVush/CQZt0nhtGnVt5micK1CwPu77ZBvsmHhQsKwuLH71tDLTwSOuZLU94bPP9lE0mvw3CH1+V0yqQKwluWskXu7riDrmXJ97Dan8Ov5mB61ttERxR0h3KSkjC/jNq1YNL8OMddEqLTp7JgDnaEIhLbiA0iY3H7OTCh4zfIN+lmIx0GQ6l6HlnCR7mw0RvLOxcNS7Cqup84x3HE7tuUxiVw2EZJON29d9jk5g9IYKh9cFYOs4Zfv/TswsIIBl3JBGysh3bsMO2MuAiiiSrgtc/ZcPCQb/S1fv8qRQTGRiHn6JOL27dJoXajSNOFhTaDYOgz0JkfrvbRpHDw44GV4IC/5hNN/0kgHKQvUHmFlDt+PEU8iftYolIOtct7yw0L4rRZ3rpqJJjWWagr7iH4jqTcBhdozraFUBtyEBmiODkg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(36860700016)(1800799024)(82310400026)(22082099003)(56012099006)(18002099003)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 1DdlE+uYEN9GP5RDAxAEI+MSZc+CwhAuDO7dcKeXpl9XJ/nZYBdxs6yeUM1n27OoqT0wOFM0Z3wu7Y51hkvTPIYgMfdWs/z5/UxMcyny/sscTJsq1C+ttcuDeqnrNCmByVta0E3/UH/CcA6pF36WPF71Rm5gGO83GXvhXTNN4xTSFR7GCtcOr0USJO+jcAQXVcvW1BqbZGboY43mHBCjrESGTOW6CaJl9DlmeCDZr0rT5jACvy4/bJqmtPZyVMIx7QycT4WPS1W9q2+y7ecCvam58Iy6jMJEIXE12YaI4ZU1qvSUh7KD4DmZymCEd5uF7seCsOS8/LRYY6kBP7MrULYaaicG8CTZKinLIagZ7pLoYsd4KpWbpZs5HT+2fqSrO5hxlYttn2WZp8wzttNgVgPj2dl373V2k7ZdsRIl1rbcamVKjFr4tHpG7Ryo+PEt
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 22:14:26.6006 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 126a3efa-da31-493d-9332-08df022d0f7e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA4E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6743
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

Use SDMA or MES rather than MMIO.  The avoids the need to
disallow gfxoff when invalidating.  Default to SDMA and
then use MES if the MES firmware supports it.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c | 1 +
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c | 4 ++++
 drivers/gpu/drm/amd/amdgpu/mes_v12_1.c | 4 ++++
 3 files changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
index 6ec5798494be1..67eb1b595abe0 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
@@ -1061,6 +1061,7 @@ static int gmc_v12_0_hw_init(struct amdgpu_ip_block *ip_block)
 	int r;
 	struct amdgpu_device *adev = ip_block->adev;
 
+	adev->gmc.pasid_inv_method = AMDGPU_TLB_INV_METHOD_SDMA;
 	adev->gmc.gart_inv_method = AMDGPU_TLB_INV_METHOD_SDMA;
 
 	/* The sequence of these two function calls matters.*/
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
index ee72afdb0a1d3..dd68db14c43f6 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -2097,6 +2097,10 @@ static int mes_v12_0_hw_init(struct amdgpu_ip_block *ip_block)
 	adev->gfx.kiq[0].ring.sched.ready = false;
 	adev->mes.ring[0].sched.ready = true;
 
+	if (adev->enable_uni_mes &&
+	    (adev->mes.sched_version & AMDGPU_MES_VERSION_MASK) >= 0x84)
+		adev->gmc.pasid_inv_method = AMDGPU_TLB_INV_METHOD_MES;
+
 	return 0;
 
 failure:
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
index f1098118d5c05..5eac7615efff5 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
@@ -1962,6 +1962,10 @@ static int mes_v12_1_hw_init(struct amdgpu_ip_block *ip_block)
 			return r;
 	}
 
+	if (adev->enable_uni_mes &&
+	    (adev->mes.sched_version & AMDGPU_MES_VERSION_MASK) >= 0x6f)
+		adev->gmc.pasid_inv_method = AMDGPU_TLB_INV_METHOD_MES;
+
 	return 0;
 }
 
-- 
2.55.0

