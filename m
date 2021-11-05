Return-Path: <SRS0=ZtFC=PY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D4C4C433EF
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Nov 2021 19:26:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DD2A61053
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Nov 2021 19:26:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0DD2A61053
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5AF626E1BE;
	Fri,  5 Nov 2021 19:26:00 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2051.outbound.protection.outlook.com [40.107.102.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6707989BCD
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Nov 2021 19:25:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L+DAW/8aGxHWFi6P5+Xb+pwJ6HEYAIo9uJvDoVD5DUIGpmGtWSaQo9/OMzKrkiLGhxEo78BED8es739l0llXqfD12vPUe5YICX1Q9pqJudSUOZti1aitZsCQmuUE+o0S6qTpjkz7SSokoCX5zQvdSArkKUTAWkItjb6Cz6GLPcjcA3EnAiJRocVw0C73K+Qywh3zkczT9Fqur3O3ya4GUAmiFtO5/0JEENgqcGByreGTB6/JlyT4UhAT8YlxiHXOqxsnK/KjSOt7aZ0r/R9TsLe0qdLf96KmAE+9oAc6crWOLjzA4jej98GTjshDkVbPbKh8X6X/np2vLF/9XXX81A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MxDtLitjgNAbhfoYdag99hTnFaPeLhiAYJErw/FuDnA=;
 b=IwFDF7+uVOCBr0OKLFFWcVvoLNr7IJY/qJIVZTZucvr6ZS9gK/EruaBqoPmyMIS1FM9Lw23vXlxt0xOOfrp9Ljjy2Krk0lZm+k9gmbOQ9nZcJWg2ZAr2ilo4JgJdz3v4fO89cNWXOlLIZLg25PkYtEDB/yJebDrA3iI3g8nuor1NpG7wdzZrTOQj2y5DjFEJuLwI8biLGQbFVCP//HK72KI/ysyPHyWbEbzr3XWLF/hLfxmaBzNSJzbEVHAkVS2AuYBnjrmQoirpKbvFDosGk9qP+dVRaNie6sYDRYMY+eO1xq/J6u6peUeHFH1AeR8Rn+1YtTHmRDXRZrdQE84HBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MxDtLitjgNAbhfoYdag99hTnFaPeLhiAYJErw/FuDnA=;
 b=jKGWh587qZUrzEIkr2bvO40TB2KK1jIZYNH0l+dzffZCxsX/VUJbWdwBmBlD4gstzHayXQXXjSEIcDdshd0xJV2StF+7udXcCNZzXo4A3E/3wT2QHQgRBCsra4l1MbXoaqd7S03R5SQTVzIKcbSL5JSLnEan1wphYM/lcj4ZH0c=
Received: from CO2PR18CA0061.namprd18.prod.outlook.com (2603:10b6:104:2::29)
 by BN9PR12MB5211.namprd12.prod.outlook.com (2603:10b6:408:11c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11; Fri, 5 Nov
 2021 19:25:56 +0000
Received: from CO1NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:2:cafe::68) by CO2PR18CA0061.outlook.office365.com
 (2603:10b6:104:2::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10 via Frontend
 Transport; Fri, 5 Nov 2021 19:25:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT041.mail.protection.outlook.com (10.13.174.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4669.10 via Frontend Transport; Fri, 5 Nov 2021 19:25:53 +0000
Received: from alex-MS-7B09.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Fri, 5 Nov
 2021 14:25:52 -0500
From: Alex Sierra <alex.sierra@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: lower the VAs base offset to 8KB
Date: Fri, 5 Nov 2021 14:25:40 -0500
Message-ID: <20211105192540.16241-1-alex.sierra@amd.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f43c54ff-b9e1-40f2-b06a-08d9a0921588
X-MS-TrafficTypeDiagnostic: BN9PR12MB5211:
X-Microsoft-Antispam-PRVS: <BN9PR12MB521102DB8AF8E09A5F7D8ADDFD8E9@BN9PR12MB5211.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rHUbDVyIGt5YSJwwaYj6qCQIyid6aGysIAF+2Hlus4vzMRsmG68mpPWSabI5vBSJbDRqLfMd4xGtkDyyHq+fKR2s7K6/4t5u4AnLtqXu2GveIDuCHJHeocwGK59mUsQhmEH9Q7WiQQIfrWWctkvdpXzd4iZFYP33D+fWG/fvu9ovNznVTZiyMKqQNrkInL6gQbqo5xumbe5d4mNIhXdrOrbD1VfkkM19PZrIsWL/rASkQa5rizVb75/CzOOueEyiI9NLgQaOPFnYRB/HSwVBhIBvlaDxkI06wAMvhYc6U+00UFLleklfdLBJ29lqZfbLfsyW00+SiImo9fyzgcIuw0lm2/b+QsKLfOVhjCiRWV8JAnTaGaUhixJX3lIkuIy5ZhU9fkSACCoYLE38pQFbXadSnFK2RlGv5EvJDO5dmWcD+0C8Xbj5mIAx+3sNVhMbUz3jZdEAG5p24y3Zzf76TfOFiymRT/O9B4I0fV8VcPzBL47NYkaTTh0jr0V4l/8i6y0aNzE7sTpl8zTGnqvqpIxw2MvBL+G91QcHh0qWSvqwlTM2Ikm1L/TIGhzyjdYuwKnSIB81CZ6hEeTW778ljewdS+pBQph2rUxiHW+GzAZxXjANWpAKIORCmVE9lR8+QiCmuAxipGdntmvlWu+tF5XjmITrCIjDFOAGVw7RrPWnk+ErOdwLhXmxxasir65eHq6cCornMT9C2Qey/JcVCWXoM5b5KvkQDU/uJA1s7Vg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(81166007)(508600001)(16526019)(186003)(82310400003)(36756003)(26005)(5660300002)(83380400001)(8936002)(70586007)(356005)(36860700001)(7696005)(8676002)(47076005)(316002)(6916009)(86362001)(4326008)(1076003)(426003)(70206006)(2616005)(336012)(2906002)(44832011)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2021 19:25:53.4935 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f43c54ff-b9e1-40f2-b06a-08d9a0921588
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5211
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
Cc: Alex Sierra <alex.sierra@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The low 16MB of virtual address space are currently reserved for kernel
mode allocations mapped into user virtual address space. This causes
conflicts with HMM/SVM mappings at low virtual addresses. We tried to
move those kernel mode allocations to the upper half of the 64-bit
virtual address space for GFX9, which is naturally reserved for kernel
use. However, TBA (trap handler code) has problems to access addresses
in the high virtual space. We have decided to set this to 8KB of the
lower address space as a temporary fix, while investigate TBA address
problem. It is very unlikely for user space to map memory at this low
region.

Signed-off-by: Alex Sierra <alex.sierra@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c b/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
index 2e86692def19..d1388896f9c1 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
@@ -308,7 +308,7 @@
  * 16MB are reserved for kernel use (CWSR trap handler and kernel IB
  * for now).
  */
-#define SVM_USER_BASE 0x1000000ull
+#define SVM_USER_BASE (u64)(KFD_CWSR_TBA_TMA_SIZE + 2*PAGE_SIZE)
 #define SVM_CWSR_BASE (SVM_USER_BASE - KFD_CWSR_TBA_TMA_SIZE)
 #define SVM_IB_BASE   (SVM_CWSR_BASE - PAGE_SIZE)
 
-- 
2.32.0

