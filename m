Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00055C46CD2
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Jan 2024 20:08:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 948D01134E8;
	Tue, 30 Jan 2024 20:08:42 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2044.outbound.protection.outlook.com [40.107.100.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E91401134E8
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Jan 2024 20:08:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f0PRqLQuPvpYDUh2eNe8bgLTKtnLqZeQ8RfabtUlRqZfh+CejRHp50xk2Q+un9HKl9w2HuoXE3DaCXp4bH0MeTLiumhRMVRZtCxe5MR966YCOa0zEjAoFgCIzg7gAd+CoxwKslgffG1BJNNhjnX4z3v2aDz7qtdpLfA/fosVhQvYhot6QiW8lCY5+t5+NMdY6yalsCaoqDukCAzlobahv8rNKCzwuNJt4b9YnxvSV06OXt0AMrhXpE+aQXG8Wtg5rPvraEHSVlzitWpziCIDLgVfFANXwZjK7AO5d8u0bZhDono+AmtNCm3BUlhUW7tfpK2beJ5YBfDUi5yUtO5f6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fc5MmUhgHQjSVSLbi4/d38ljMdlIqFBK7UPfm+t3T9I=;
 b=GLoacAEHYwHeNiGfSGfHH9ykg2fM6TGwcyLowVMrkDKCBFrH0RoKctFMymUl75Hl8ys47DfayROPcyXmY6ZXMxF0AOf4iWtOULVQ2QYaNX17i2ndqC7iR20euSr92QAnhyh9eQGbCdb742BqUmZEqiWHXHAhNX1ywENYunVdbwvuFY3Q0O0y4qiD01jcmJe56+R0oo/CVhhO4tO1Aertbp9P4KBCsyDrV8EduomJS2RXD1a7OgWQPZ9SLiYLRuTso3swXObPNUcM1czKdnNcGIx9v1qoHez2J7WGCwq9szFhFcGLH9LBvDB+1uCZXKqLnoR+cGwRXB3kAhTZhR6clg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fc5MmUhgHQjSVSLbi4/d38ljMdlIqFBK7UPfm+t3T9I=;
 b=ytdnKqhHlfSgm5HgC3hmrpYdn/c8vrU1tDCFO0DjACeioEv+hddLrECTlgeAHd4ZxKKVpd5CJnbgoGlsy322Tie2DJK4H/OfQleTLEPMJxg75NE6u4cmqXp5m/EYbbBBdZBNRDKbFTIX6jNCyQuuG3h51vKAFyrcs0d/YUaPzAI=
Received: from CY8PR19CA0041.namprd19.prod.outlook.com (2603:10b6:930:6::19)
 by CH2PR12MB4312.namprd12.prod.outlook.com (2603:10b6:610:af::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Tue, 30 Jan
 2024 20:08:39 +0000
Received: from CY4PEPF0000EDD2.namprd03.prod.outlook.com
 (2603:10b6:930:6:cafe::27) by CY8PR19CA0041.outlook.office365.com
 (2603:10b6:930:6::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.22 via Frontend
 Transport; Tue, 30 Jan 2024 20:08:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD2.mail.protection.outlook.com (10.167.241.206) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Tue, 30 Jan 2024 20:08:38 +0000
Received: from Harpoon.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 30 Jan
 2024 14:08:37 -0600
From: Felix Kuehling <felix.kuehling@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdgpu: Reduce VA_RESERVED_BOTTOM to 64KB
Date: Tue, 30 Jan 2024 15:08:09 -0500
Message-ID: <20240130200810.2434013-1-felix.kuehling@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD2:EE_|CH2PR12MB4312:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d96a42e-c5d7-47d4-b19b-08dc21cf3f9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AVPu9HH615b5TLun4/DnvPicCYVJZXrv+3IdSULIe6yIjLKs/gDXNPgzYbQj77Kh1dLc/Mz2LYR50TTlbgFN0Ou5umiLEOEzKIV4c9iPVvMdytr0euGALGuthxhqrzz6N3n5I5BI3qj2xe2w6tOY9N0yk9TvWb8I3LSkwwGRnmqNKnJW4OFCoYGcmMHVP7gt7PzG1sDN5qph6v1Ox8u9QTF2fPzUYqc1gtMHajgpgZlGRwySdiNrmMPFJgMk7kxI+Xpmox4tvlTsJAcrj0ZP7F+f3OE6hqQ7voUMMYkXZP7hzetRr+XLzbB5mjcAjH0kST/oBd/BrcSV6allCvBvFWoYTSBnxhI+spQpuOUDtfU8LVVsNZ7hhidlZHh9GC1StllVAYdNK6qwlAa77oYr52kOURAhVsrncjgZv8cu+yrZuWYgmiwPGSdrU5lOgFbDedYJVHiX87iDZyRv3+iMIa1JC1Tq8ax0Fa5CocKt5TpJKrLRDsY2sX3ybuhSbfvAPvXbD68SiY5WIZCq+1zyeJ+qAnJIs2aPWADbRVD6nnCvKomdkk+nD9Bhdb5UanfLBaRUJdDyXtoEL1yMvfqJEjH0SWh6e++4SabUkRiJnmYEVkE8SkkhXk2bfBppLOUyQRRm223ToiCjLIVxDLie7dcgA6Qu7HW+puaYIMBaIWfkTwbIlVKr1+rHhLdBeuVopSZKiTuetHJL7y+oDZ90GffjX4mLzdAdL8NOBFfig5B36sC9P9AgkNuibVhIp+Qj8xmWram2rlaFoDHqJ91daQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(346002)(39860400002)(396003)(376002)(230922051799003)(64100799003)(186009)(451199024)(82310400011)(1800799012)(36840700001)(46966006)(40470700004)(41300700001)(82740400003)(81166007)(40460700003)(40480700001)(356005)(36860700001)(6916009)(70206006)(8676002)(70586007)(316002)(86362001)(7696005)(54906003)(2616005)(44832011)(426003)(336012)(5660300002)(47076005)(2906002)(478600001)(16526019)(4326008)(1076003)(6666004)(26005)(8936002)(36756003)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2024 20:08:38.7789 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d96a42e-c5d7-47d4-b19b-08dc21cf3f9b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4312
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
Cc: jay.cornwall@amd.com, lang.yu@amd.com, christian.koenig@amd.com,
 arunpravin.paneerselvam@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The reservation is there to catch NULL pointer dereferences from the
GPU. Reduce the size to 64KB to make sure that shared virtual address
programming models can map all CPU-accessible virtual addresses for GPU
access. This is also the default for CPU virtual address mappings as
seen in /proc/sys/vm/mmap_min_addr.

Signed-off-by: Felix Kuehling <felix.kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 666698a57192..2c4053b29bb3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -135,10 +135,10 @@ struct amdgpu_mem_stats;
 #define AMDGPU_IS_MMHUB0(x) ((x) >= AMDGPU_MMHUB0_START && (x) < AMDGPU_MMHUB1_START)
 #define AMDGPU_IS_MMHUB1(x) ((x) >= AMDGPU_MMHUB1_START && (x) < AMDGPU_MAX_VMHUBS)
 
-/* Reserve 2MB at top/bottom of address space for kernel use */
+/* Reserve space at top/bottom of address space for kernel use */
 #define AMDGPU_VA_RESERVED_CSA_SIZE		(2ULL << 20)
 #define AMDGPU_VA_RESERVED_SEQ64_SIZE		(2ULL << 20)
-#define AMDGPU_VA_RESERVED_BOTTOM		(2ULL << 20)
+#define AMDGPU_VA_RESERVED_BOTTOM		(1ULL << 16)
 #define AMDGPU_VA_RESERVED_TOP			(AMDGPU_VA_RESERVED_SEQ64_SIZE + \
 						 AMDGPU_VA_RESERVED_CSA_SIZE)
 
-- 
2.34.1

