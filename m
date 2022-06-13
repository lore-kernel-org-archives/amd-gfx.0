Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21C07C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jun 2022 15:20:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C35B10E8B8;
	Mon, 13 Jun 2022 15:20:21 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2068.outbound.protection.outlook.com [40.107.220.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9884D10E8B8
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jun 2022 15:20:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OS8uPyRVyAdvWhmACGm0UUnkwQI+Dt4/e06JY8o58eY5mHs9frU5q0RhQCga0eyYm8Fg4winIfPvcovHOnxvlIJQBTx5dJW4iKWeCRE8b94j/bPAr0zExBYy4Z/383p3UdCHwxLgHPldtqjMYvnAa2YTBIbk7/ADRI6usBWdJT7IiU3rvkftKvoQciTbb0snrHbCiH0MqViIhlCg0K5kA//p/eIt+STzx9nudKticbWMgfBFfEVIaen/GzRJ0UFfN8pH2ZKeLGIvKB/qF5ZjL5haGlpIVsxUEHbGE/SQO1gwgEAKeUEUeDWCQnIYg8pxGdOqTjhBAnXJA8PAvFymXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JJKNySNLgMnn+A3SGDFSBBDiiaviYoGud4I1D8OMLzk=;
 b=Rc1oTzMF/1rN+B/gbbOYW2ZYmf4fMC1Jo67pOxxgNS5huaRm11WvrHNo+cpEAw2Bf1Tw4aKFngVphmUNtLN62YLd7UXl+CVMKb6yjOjxyCOMt2W5X42UP5kDfjPXy6ygTqhOBCGhUpyEB5SHOZDiMTF64U9kYalhUwpP56X6nAtWfCh8ii1+02k2w+kHh6YB5G0uT39mCwo1hB5rVXnRaebEnezU7DMYN5Btsq5YIi5H+5OWvqz575rNpV4tmMQdYWNkKuTlsoIQd7/FYLR5ss9SSUl9GvdHWTwKSrfKWxP4tvJdW5f/rpyAALWeF1YFm6R/CtlkCvaAZSOWm0Ootg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JJKNySNLgMnn+A3SGDFSBBDiiaviYoGud4I1D8OMLzk=;
 b=awyTglIA96/Bj0/tgFv+4ZlNAYDE1hu7k8Rz1mD2izY+67dfxgP3mUm2INmGuKumuKOp9D9cR9kRTRde/FF8vnUlZ/0csiFUpTa5FEPmIMi3L6Oe4AQ4rgq4+OFMyr2+kuIOpnIBjfiIMSVHbi8wVNTm4m69ZTJi4Dgmd0Sg0B8=
Received: from MWHPR11CA0021.namprd11.prod.outlook.com (2603:10b6:301:1::31)
 by BY5PR12MB3825.namprd12.prod.outlook.com (2603:10b6:a03:1a2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.16; Mon, 13 Jun
 2022 15:20:17 +0000
Received: from CO1NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:1:cafe::ec) by MWHPR11CA0021.outlook.office365.com
 (2603:10b6:301:1::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13 via Frontend
 Transport; Mon, 13 Jun 2022 15:20:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT051.mail.protection.outlook.com (10.13.174.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5332.13 via Frontend Transport; Mon, 13 Jun 2022 15:20:16 +0000
Received: from mkgs-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 13 Jun
 2022 10:20:15 -0500
From: Graham Sider <Graham.Sider@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 1/3] drm/amdgpu: Fetch MES scheduler/KIQ versions
Date: Mon, 13 Jun 2022 11:19:59 -0400
Message-ID: <20220613152001.3045911-1-Graham.Sider@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7edcd15f-bde1-48ca-3c2c-08da4d503890
X-MS-TrafficTypeDiagnostic: BY5PR12MB3825:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB38256244900B410705CCE9CF8AAB9@BY5PR12MB3825.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /laSG7/xURuqLJ1YpbHwI3S4x8cm4INwSAx+5ko0DeZ3MuDNv4/q/C0PIpxBP7y9I2nSwsePVW65qCSjXumaYdaxLMJf+3Juqd28hA4/ecfy2mmECq6B8QBsPh0Od8Yj+3IM0H1csTDc3YSfbM7OvP85RtzTJqIt1Y/bBxKEzO7yeyVSo+ogp2ML7pPgG3y5BD35lX1iqtTydTHZ6crRfHde8OvRwzN87pdpBZ2uTDdxgX6oNeidP/5rAFalWehFLnRwJJfen3rQHhdHzpPZjET6YtxGGEtfAHqpJh19D9GILxm6ZRQAYNb+B634keqtCvfex/x0vZK370swmqIyTRmPWXlXPOC+bN57+GsdP5Ap3OjpwxCc51xSwRkCgb4xh5B2kELgUYWqwv4oslyWSg8cRHJtXbQCGa/vXMC13h4bt+f8PQfJsj2jP8oIxgPM2driCfk2SoPx/vwYcvkp2LixiWGUMIRuVqUVungbaaiyNd72sLP/NlFTgHQwiL49fYzd5YjSxYvkRUyz8BN97FN4HRaKQ4OeRQDsxPfTGT0BF4o3CUjNiC9Vkd3b9r97FH5WFFyfcnWmJLNFCOegJvQ9NE89uuGhp2BKNef344ITuV4SAm7CYbZropor6YHy/WUK/JeahaohpMSRWKW4WPG34h2hHYata4RYegQd8KxfXfrsjiK7qHyUaLBLAHVSflH2IJo78xzgXfEpGKwV5Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(36840700001)(40470700004)(46966006)(83380400001)(186003)(2616005)(16526019)(426003)(47076005)(336012)(1076003)(81166007)(36756003)(8936002)(5660300002)(356005)(8676002)(36860700001)(82310400005)(2906002)(508600001)(70206006)(70586007)(7696005)(26005)(4326008)(54906003)(6666004)(40460700003)(6916009)(316002)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2022 15:20:16.6170 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7edcd15f-bde1-48ca-3c2c-08da4d503890
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3825
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
Cc: Mukul.Joshi@amd.com, Felix.Kuehling@amd.com,
 Graham Sider <Graham.Sider@amd.com>, Philip.Yang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Store MES scheduler and MES KIQ version numbers in amdgpu_mes for GFX11.

Signed-off-by: Graham Sider <Graham.Sider@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h |  3 +++
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c  | 12 ++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
index 92ddee5e33db..aa06c8396ee0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -64,6 +64,9 @@ struct amdgpu_mes {
 
 	spinlock_t                      queue_id_lock;
 
+	uint32_t			sched_version;
+	uint32_t			kiq_version;
+
 	uint32_t                        total_max_queue;
 	uint32_t                        doorbell_id_offset;
 	uint32_t                        max_doorbell_slices;
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index e4eb87689f7f..2a9ef308e71c 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -890,6 +890,18 @@ static int mes_v11_0_queue_init(struct amdgpu_device *adev,
 		mes_v11_0_queue_init_register(ring);
 	}
 
+	/* get MES scheduler/KIQ versions */
+	mutex_lock(&adev->srbm_mutex);
+	soc21_grbm_select(adev, 3, pipe, 0, 0);
+
+	if (pipe == AMDGPU_MES_SCHED_PIPE)
+		adev->mes.sched_version = RREG32_SOC15(GC, 0, regCP_MES_GP3_LO);
+	else if (pipe == AMDGPU_MES_KIQ_PIPE && adev->enable_mes_kiq)
+		adev->mes.kiq_version = RREG32_SOC15(GC, 0, regCP_MES_GP3_LO);
+
+	soc21_grbm_select(adev, 0, 0, 0, 0);
+	mutex_unlock(&adev->srbm_mutex);
+
 	return 0;
 }
 
-- 
2.25.1

