Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1861CD5BC4
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Sep 2023 14:10:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D511210E131;
	Tue, 19 Sep 2023 14:10:31 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C430010E131
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Sep 2023 14:10:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W0ugheNDyegtEzIbKCLmc3YsdgRGiMjYF3XXqJiJ355lExoHBEs5llfduP1v+l81PQLD+vG/9tDtsIHW6vNztQSyeL26d58THl7Wxi9AJLPUjYSyzwYsNx+WKAlFkzjG5V4Qq/6bOpSW0JGVQu8u412EIEpxjTOXZVk21DIwjXtO/XrJ4SGSlAbGkH52EH0M6l+38ghKCcNtth+MMbTztFxn3TqBSijXhcp1MYYNcBGEOmkr7XoDAlqFE/5PcDAgmJLLHbQD7PwaxLTXOwSXKQXOBN8D2FBZCF7RZ50aJOBRHVSXY4Zu/Ujo73ougVYce/NlNqhj2mzJaizFY/8SOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i//DCXP1QBLKtkW+ZU1kyNmyAxjKcvB5nl501/f6jTQ=;
 b=go0ue6CEYazrAAM+d9iNeuX+qQYRYcL4+ZkT+cDH7fV6AoFI7+uGfOwWUpFgRHMMuNYwZFHyhX9my/0X2o24EJYun/GG0mJf5DDL6+8tj1B6OgrcBdfxa4uncaJ0CGpdyxaETt/Su6Hl26rnv+X7MQnGF/Npq797hMcaAtleVXZL1YsPuZZy7jBtOIIJAb1qVg9tbfCEjgyyyDqhkJ2nAiB2ZKrKTzHc4V6HWYzliSuJEBacf6qeHfc8TbAoc+kCHG00Vbk8nXOR9xMGwRsNGnygFRmGET/AY0klOG31pQ8JafGqzduDb8Be3iFCNA/MGpt7yOyoO/h0cxrMBbtSog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i//DCXP1QBLKtkW+ZU1kyNmyAxjKcvB5nl501/f6jTQ=;
 b=uMRtMzRr5kqzW8xSCAbjeLfhez9JswbA/ILvVafTikg9yfxMDzquInaCWfu1iqNG3W0reNlFDqa4IFcJxkWI+0BEdjPp4a6V4MYPP4Bdugj8K++DWMnYtMxU6pgLG465G1RL4R1BBsvllqWZzugghjlMIYEEfCPDaA/MXp7oB+4=
Received: from DM6PR07CA0108.namprd07.prod.outlook.com (2603:10b6:5:330::14)
 by CH3PR12MB9249.namprd12.prod.outlook.com (2603:10b6:610:1bc::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Tue, 19 Sep
 2023 14:10:28 +0000
Received: from DS1PEPF0001709D.namprd05.prod.outlook.com
 (2603:10b6:5:330:cafe::55) by DM6PR07CA0108.outlook.office365.com
 (2603:10b6:5:330::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28 via Frontend
 Transport; Tue, 19 Sep 2023 14:10:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001709D.mail.protection.outlook.com (10.167.18.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.19 via Frontend Transport; Tue, 19 Sep 2023 14:10:28 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 19 Sep
 2023 09:10:27 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: Don't use sw fault filter if retry cam enabled
Date: Tue, 19 Sep 2023 10:09:54 -0400
Message-ID: <20230919140954.8150-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709D:EE_|CH3PR12MB9249:EE_
X-MS-Office365-Filtering-Correlation-Id: 75b88e3b-d83c-49d1-3fc8-08dbb91a2d2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sa2JZO14P+9JhVEMn7aBNuHisR0thkH0vpHaFMGS73g2IiQNDz0p4sNTUAISjmzvOiZTHqqWenH6lNH6WF3rdSyLaotx3Q0+K3+04lq7jf9I4LOlmuOkm7nsA5mbEVgfP7YzNOw1v2o3jTWZDhkAgN8hby7JavEjV54kMgDGwzEDBLZihYmekU6ftAAkwXfcKq7PbXRU6vbf0fcIynQfkMtwGgNjJXwOzoY+VOEbBfRjVuPzOJx5oYHVvt2okaHYuTBHWRLJqZGEjGVAnAjny1fDApBI+EzeNp71ta/FH1DhPGaUzvGULcr5YWR8WHRsN48JXVQqLfsadQ2lnTg8Uy5evl6uJvhCEwyTYNney8EmCvFf13tneiXtecnan5dSI9s7/1SAjnAuMoQxXW9PnkhbJPqwUdWEZlxZq/jl7GEpNVQgcOM6JwFc/AvGefVNs9YpOEm7x/hYF8PGa5qR7dR5LL8pIjtj7xYc3TaBx69NpTm20THdnG3+RaEWj3rCg+Tf4ScLsFQK4f0ey/WYqk5tgIScQw52yLaHyjYVI6q0Xrxuy3ithEzYv4VvzUTDNAEuEEpAI2fVV8vgh6Ux9+hFfAFitz/x7c2zaG8ajxoiU1VIsw476H3oFbKnpHl1n1NBaE2LOp9beBE2ivzdCwBySrW+P8CIBjRm9R/YSq0JfJ3ZzHstKK5JHpOluGPhoYajebSsFRFTJ9ZLbeVgDlyAIALNfFmznBGOiin6lW4/G6PPPqFhQKG+4BRG+/OsocGg9ZMJePbRTw0estJ9Fg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(136003)(346002)(396003)(376002)(451199024)(1800799009)(82310400011)(186009)(36840700001)(46966006)(40470700004)(6666004)(7696005)(40460700003)(86362001)(81166007)(82740400003)(40480700001)(36756003)(356005)(36860700001)(8676002)(2616005)(26005)(47076005)(1076003)(426003)(336012)(2906002)(4744005)(16526019)(83380400001)(478600001)(8936002)(4326008)(6916009)(5660300002)(41300700001)(54906003)(316002)(70586007)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2023 14:10:28.0477 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75b88e3b-d83c-49d1-3fc8-08dbb91a2d2f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9249
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
Cc: mukul.joshi@amd.com, Felix.Kuehling@amd.com,
 Philip Yang <Philip.Yang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

If retry cam enabled, we don't use sw retry fault filter and add fault
into sw filter ring, so we shouldn't remove fault from sw filter.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index c7793db6d098..f357d1f7353a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -452,7 +452,10 @@ void amdgpu_gmc_filter_faults_remove(struct amdgpu_device *adev, uint64_t addr,
 	uint32_t hash;
 	uint64_t tmp;
 
-	ih = adev->irq.retry_cam_enabled ? &adev->irq.ih_soft : &adev->irq.ih1;
+	if (adev->irq.retry_cam_enabled)
+		return;
+
+	ih = &adev->irq.ih1;
 	/* Get the WPTR of the last entry in IH ring */
 	last_wptr = amdgpu_ih_get_wptr(adev, ih);
 	/* Order wptr with ring data. */
-- 
2.35.1

