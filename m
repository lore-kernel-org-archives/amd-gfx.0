Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74F59C433FE
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Nov 2022 21:20:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B9CA10E283;
	Thu, 24 Nov 2022 21:20:17 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2088.outbound.protection.outlook.com [40.107.93.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E0B510E280
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Nov 2022 21:20:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WhU/IGWaCqZmJWP+p0Zojk/lP13at7OxEqIuI5XwsapxUoqjspCvOpa4OhTNpbwmfyTC0P6v+xFnRQmELVNGekFPTgG/AgK4dBNm/ee8JxFU26IVsiUnSP0JhxkoGDGD/DPWas5AVRh4vGnM3t76/zbX76S62Mf+gmE8gLD91iIgyjaKUQPKtvOeBE0miqTN6nCIy4y3rQNNcDEzei2rQ0HPoodEHjcyUIAq390D4wqieTcXqdF4+rnp4dG9XlC6yIHcm7fljUjxrME8fjeLH9SoxK1vFVZeUsgEC7cVgal/NBhmDU0l9gXyxgvkvd1OBB0ZOXgxDqNhtnSl8WTBaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NkNde7/2fhkujHnqPruXYer4CDt3tYEiC/t6tN7JMAk=;
 b=dNm/sg81Jvd/JYTkND4k/zUPyN44kXNVi1/XIqMQv/1nSy9xQ7nnW0zuVFw8VCQ+o0/zdX1XyJiF6kc152Who8ETXwtCeqQEk2/yKdkW0fv1Fm80yze0RV10/Rqr2YoM6zzzQcpF6Je//VPerR9O44j7CZQCfJP6C6ubnMNghLbieTAZRgLFLrcb63m8Q4YHzq7TjV3ROARSATiuO7mMkzcdAJmRWMKzc6c1JNYy7XsXNaMhUZ62SP6n++O+d3ZiuraTnOC8biG6hH3fXIJ9mVLbM2y+ub3YLOZa+YEquyEukGfY9vXkuYaDCgLqKml3RC6sYTqYmHAQdEEQOQ4lpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NkNde7/2fhkujHnqPruXYer4CDt3tYEiC/t6tN7JMAk=;
 b=l4u25XOWciuzHBO4znEOKqHr5Sms7LJmr1oiBvQ/PCZeHtxUx08FAmRVOHC/pDWHOhxHck4w1htMhxs1UB6B+X4UwLHh7pBbuEl7JyPe6jCdNlcxOVTnIHZcpuho0mmhMt80GXI7k+YPCOF+HcPApP41mHJ7KeoLkb00J+drRL4=
Received: from BN9PR03CA0197.namprd03.prod.outlook.com (2603:10b6:408:f9::22)
 by DM8PR12MB5400.namprd12.prod.outlook.com (2603:10b6:8:3b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.18; Thu, 24 Nov
 2022 21:20:09 +0000
Received: from BN8NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f9:cafe::5c) by BN9PR03CA0197.outlook.office365.com
 (2603:10b6:408:f9::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.19 via Frontend
 Transport; Thu, 24 Nov 2022 21:20:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT050.mail.protection.outlook.com (10.13.177.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5857.20 via Frontend Transport; Thu, 24 Nov 2022 21:20:09 +0000
Received: from fedora.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 24 Nov
 2022 15:20:08 -0600
From: Luben Tuikov <luben.tuikov@amd.com>
To: AMD Graphics <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Fix minmax error
Date: Thu, 24 Nov 2022 16:19:56 -0500
Message-ID: <20221124211956.264282-1-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.39.0.rc0
MIME-Version: 1.0
X-check-string-leak: v1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT050:EE_|DM8PR12MB5400:EE_
X-MS-Office365-Filtering-Correlation-Id: 74e53476-0afc-440a-0967-08dace61aa59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hjB+xAj9tvkVBO0e6tWoetrlYAL1UDzzbaBtstGUOauBZqgvQJqX4sPAPIYjpxc2y+x4JQT2O0lDbQnbtcYdXkXIzWyTf9wmitbfm13eVrakzuruoPtjH0Iv7jltpQtM2YeKwnE6M4dEfA2m/CtkMiWsWWVl+IppYDmKAVC5R6RluTe9vKlf8DSejJEI3TjaAnYZErN6wbfCwfF6FIbYF6nGWrzIXQ2+2EYRq9ucpHeDmgfdxYIRS9zdypu4s/K1M4+7PmKvzzFqCewR4p7Qwu5AX1GUuwnkJF7/zGZzU5bdjAvKSU74ftLeQ8ZSk6fRoK1tK1Cy+l2HMu1oqs5soAlcFFx90/kp2CFb0TUCfyJ9ykt9WvgPipPhImCiF2wmmPkpLRMUL4qc0K0k1CaPzma0LYfaUZC4KaVDtBu6kA1oj/0qmWDZFWcosRZPHIH+EGOCXJydPmBrubdsDHN8zCjquudF545Jt6zX3P9/SqT9xa3mOuHm8mY3I3CyOZnb4Ytt1WyXnqZVRPETQ3APlZ7gsgrFyAPGlpHwWL8IS4NR+++wrvvjHnn1YN5sLqVtXJWgjV5/PuWS6M0gHjOiVs//lg+gw4rO0vB2s8+xGZ+Zb4in9L5mQ6bSucY37Df8QDCeq6aX1ndKb9BP6CbDfhI4fv18pkq++lnOuT5UnqGHszECWBWQFhokul0hA2zdhpTaxa6wpLUufGcxyX3xOpf8APyIBdmqlBProruTuiY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(376002)(346002)(39860400002)(396003)(451199015)(46966006)(40470700004)(36840700001)(36756003)(356005)(86362001)(2906002)(40480700001)(5660300002)(44832011)(82740400003)(81166007)(83380400001)(36860700001)(478600001)(6916009)(336012)(186003)(4326008)(2616005)(54906003)(426003)(16526019)(47076005)(1076003)(6666004)(70586007)(316002)(40460700003)(26005)(82310400005)(41300700001)(8676002)(8936002)(7696005)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2022 21:20:09.0989 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 74e53476-0afc-440a-0967-08dace61aa59
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5400
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
Cc: Felix
 Kuehling <Felix.Kuehling@amd.com>, Luben Tuikov <luben.tuikov@amd.com>,
 James Zhu <James.Zhu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fix minmax compilation error by using min_t()/max_t(), of the assignment type.

Cc: James Zhu <James.Zhu@amd.com>
Cc: Felix Kuehling <Felix.Kuehling@amd.com>
Fixes: 58170a7a002ad6 ("drm/amdgpu: fix stall on CPU when allocate large system memory")
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
index 8a2e5716d8dba2..d22d14b0ef0c84 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
@@ -191,14 +191,18 @@ int amdgpu_hmm_range_get_pages(struct mmu_interval_notifier *notifier,
 	hmm_range->dev_private_owner = owner;
 
 	do {
-		hmm_range->end = min(hmm_range->start + MAX_WALK_BYTE, end);
+		hmm_range->end = min_t(typeof(hmm_range->end),
+				       hmm_range->start + MAX_WALK_BYTE,
+				       end);
 
 		pr_debug("hmm range: start = 0x%lx, end = 0x%lx",
 			hmm_range->start, hmm_range->end);
 
 		/* Assuming 512MB takes maxmium 1 second to fault page address */
-		timeout = max((hmm_range->end - hmm_range->start) >> 29, 1ULL) *
-			HMM_RANGE_DEFAULT_TIMEOUT;
+		timeout = max_t(typeof(timeout),
+				(hmm_range->end - hmm_range->start) >> 29,
+				1ULL);
+		timeout *= HMM_RANGE_DEFAULT_TIMEOUT;
 		timeout = jiffies + msecs_to_jiffies(timeout);
 
 retry:

base-commit: d5e8f4912061ad2e577b4909556e1364e2c2018e
prerequisite-patch-id: 6024d0c36cae3e4a995a8fcf787b91f511a37486
-- 
2.39.0.rc0

