Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4443FC6FA90
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Sep 2022 09:42:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D3A610E2F1;
	Wed, 21 Sep 2022 09:42:34 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2082.outbound.protection.outlook.com [40.107.220.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E824C10E906
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Sep 2022 09:42:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TLSyFClSXOpENBpaTyy7x8HKPRDCdzttV3ApJKtxqHbzjSXV688SCB0yJBWzdgONWf9NBDzG7EKW+4Gjk0SMyCjliZ5czJ3Asxg4LNqe/DIDT4MO1/AK4OGL6FMuJb+P4KE8/N74B4nkvflv3GCZuaBabeEjCPsW0IiWA35bRsA2AbHoRpB1Tlx/LmwvXniAsebf4UTjhSLltxjQIdpUQ7zUulPDIdtTFaK51vac8b63pgGLZ2NcKS3jB+YZFuaUpT2JsgO3ogspNMNbDwsOlVZbDTzQvH0JE8w4DD0hEUUlEmzKJkBhvsxwgLLWL9Prpz1CiDcO58jMYblVDdcvdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qmusQ8/dEhfWiRsk2BBAj3FpEkWOywkfIX29VVIoCg0=;
 b=A1nHAAcqbsuwLx32edtyW8Dgg/XuwycHwc4bl4g6YirI+XM41SiyAWdYQ3IYzX3N2d3HVe4xd6TW96GqiBs+Je9tTjS0araspVbt4p5opseFmsGx2GXYorNcEe65h7gDAqi9f3oi22T764cPoyctx5fvcyqEcpKt13YglKAQsrPPCGEOIKNNYrSnC/khG/jvSBeNKqyeB0t/tdvTFHA21B8CZjAQ9gSBGv9Urk29kKkIxxZ/G3VPF0CtAvRz6NNVLVs//Z6Lyndmrrol7iayS/PTXXt/5MTlXC5tgn5GtDMtIRXoIV5rPcEpJd1Oy0GOKMUWPI2NscoD/TvJ3oj9yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qmusQ8/dEhfWiRsk2BBAj3FpEkWOywkfIX29VVIoCg0=;
 b=n5KJNc0oCXcdvxiPse407OlGCMyFp4/hcU8IFDMAZORoPTtHpNNSzoG6t1UtbT7dWC5Vb6dgZc7BHgnCLcLBxddGfVwVk946J4rr0zWDDefylvncO66KMI9PkFH/wVPFoOkJuO3LLW1WpVZn3T035agFm1+oAbGQYbRD7CAchLc=
Received: from DM6PR17CA0033.namprd17.prod.outlook.com (2603:10b6:5:1b3::46)
 by CH0PR12MB5372.namprd12.prod.outlook.com (2603:10b6:610:d7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.16; Wed, 21 Sep
 2022 09:42:25 +0000
Received: from DM6NAM11FT049.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1b3:cafe::72) by DM6PR17CA0033.outlook.office365.com
 (2603:10b6:5:1b3::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.14 via Frontend
 Transport; Wed, 21 Sep 2022 09:42:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT049.mail.protection.outlook.com (10.13.172.188) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5654.14 via Frontend Transport; Wed, 21 Sep 2022 09:42:25 +0000
Received: from jenkins-jiadong-1.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 21 Sep 2022 04:42:23 -0500
From: <jiadong.zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 5/5] drm/amdgpu: Correct the position in patch_cond_exec for
 gfx9
Date: Wed, 21 Sep 2022 17:41:17 +0800
Message-ID: <20220921094117.1071106-5-jiadong.zhu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220921094117.1071106-1-jiadong.zhu@amd.com>
References: <20220921094117.1071106-1-jiadong.zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT049:EE_|CH0PR12MB5372:EE_
X-MS-Office365-Filtering-Correlation-Id: 43560176-a4e9-48dc-9a39-08da9bb59717
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6+jM47cIPW9ceezNlr7iSTQWj+BqneHZGZIrchKUhbYeLW8qcIEU6qFKIngPmF/2xxuIV1prgMczZcUIcmrsiNU4MICwbpv7aErl/+lmVC1s+CX7CAXN/oZRAE+ww5d05SqaUk9nYRIDcUPPmyuZt+T9/Q2isl/kDjQj4So+O3JIR4V9UsJM8SshUvXHKcFoMkbP3TEbr0Ft7Rb1Xtcd3oUu9sWJjG+ofInzB/znkjtniYQU6E2Guul2W+LxP4JjsHDyjVhO6KZEA5VMMo6db8lspZbe3nRkv+NYdA8cD/DjDWhTWiouBi9I4p5DVURSjdzfkKVBe0QCMG0O3BmAUlWbwrJHRQaXBxPbpBiAWxWNEpk4G+cR68jQTUJBjsBLkzom+qDx1iM6PRMIfoLkcEam7a4fbqPc/RioeA3MG8eqwE1ZDKolczhyJaou62AcsebcqTBcdhizYwih0LQUPOs192hl214rYLjIKVx6I6Pv5mJ+5Pw+iMc75RNnOLkzXSryvI45Fceso1t5evskaTf01L1fGWnTabznCsRcfNTTDcwUPQgPmfrCL8Ms/BfuzakEyjWZd5BDu5AjUlbXT/TsNIxsIwGW+ueLBXOwpnSbH3+sbFyH4rcMkMtjQyO7AgyfWNZav47LDUz1wGKj+C/Wh+390hvyuXhGVhMU4mpgjyy9tqf4Qw+823sZ7Y4/ayIwX8vkThYRHAkIO8Vt6xZApwjpOtHObnnbGKD8YnSkoVX+c4mB5sFdtvmgvNq1fUheKGhqA3eoHrD5RXlg5aIXwPD46vaQcWmUWdwpn5oS69QkdCjxJiqZjcXR5ZDR
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(136003)(376002)(396003)(346002)(451199015)(40470700004)(36840700001)(46966006)(6916009)(316002)(36756003)(86362001)(81166007)(356005)(36860700001)(1076003)(2616005)(186003)(336012)(4744005)(82740400003)(83380400001)(47076005)(426003)(16526019)(7696005)(40460700003)(70586007)(478600001)(8676002)(70206006)(4326008)(26005)(6666004)(41300700001)(8936002)(5660300002)(2876002)(2906002)(40480700001)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2022 09:42:25.1701 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 43560176-a4e9-48dc-9a39-08da9bb59717
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT049.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5372
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
Cc: "Jiadong.Zhu" <Jiadong.Zhu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: "Jiadong.Zhu" <Jiadong.Zhu@amd.com>

The current position calulated in gfx_v9_0_ring_emit_patch_cond_exec
underflows when the wptr is divisible by ring->buf_mask + 1.

Signed-off-by: Jiadong.Zhu <Jiadong.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index c568a4f5b81e..65f8c8d4f4ae 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -5754,7 +5754,7 @@ static void gfx_v9_0_ring_emit_patch_cond_exec(struct amdgpu_ring *ring, unsigne
 	BUG_ON(offset > ring->buf_mask);
 	BUG_ON(ring->ring[offset] != 0x55aa55aa);
 
-	cur = (ring->wptr & ring->buf_mask) - 1;
+	cur = (ring->wptr - 1) & ring->buf_mask;
 	if (likely(cur > offset))
 		ring->ring[offset] = cur - offset;
 	else
-- 
2.25.1

