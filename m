Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D347C4167B
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Dec 2023 23:01:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9EC2E10EB58;
	Fri,  8 Dec 2023 23:01:25 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2055.outbound.protection.outlook.com [40.107.100.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B5DB410EB58
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Dec 2023 23:01:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fUqeonKhmB3jWuRa8O0VklX7Qn/VqS3RvztCk7bIhGSffRzL0J1mSAk+S8oCssjjvAA8xZxkT4BRGOZJodyoa9Zy7ssfBsC+2nU3pADT133LgBiCm6WWDil2O0GtDIS7I8VYNng5ieRjPW8YKBYz7laERCCpPW/boR/hJvM8zL4kDD+VOKw2tqHDK3Iz8ZPnv5MbgN5nk7w+UGTpyNApDPoXJ0N6+5eMcL9QLXropVVNTkbmhTky+aVY7sdGD5vWmvZDMTjDpqDW6xqeKjUW5x8AijiWHk2yxWNAymVgz294IzSFaX9AIfN92HUUVUpkU24vmwJZ3vYhuFRltD+xJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iDadxi/axGzBP+e6H3pC1dImJLUc4mGYTNEuh4U2ats=;
 b=ZnTMA2qFepXgtxcNXOsKoAGLTszfHfiUgMT4mZurBeCT/Wcs9CaAhUASM94wBjZgncapbY8dExI/9iPU96n1Calp3pOP2Y3nc5TGfcVCXBfcMTJuYlspleSUHCFMdo0iZhPcHauzYq63hzZudsGBcuDq7tWWy5QsKme8hp0UKVPUs+msGUmmDN5kdHTcChV4clZ0yZSiU2bc24c04TjmXimjL8TMbkBewe4GdNhUFL0q0u5YZJ6mD0HKx1j7s/RjwZlrm2mNLdh2VO4m8+eHBoLuf60HaxQk0I/LFrnFgEaW/gy6RsgVSXQ9En6OSK84unSoBJ6VGfmprsr70u0OMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iDadxi/axGzBP+e6H3pC1dImJLUc4mGYTNEuh4U2ats=;
 b=oj6p7OAN+RYq/qJagzCERoPXKtBNaRzOTxQ/mxO/yxfWNk7o5icQQ+LpwOZramdpM9BzWeA6aJruHHNJMORI5cDY+aireljVeyRyQGwE8+XpLzc3Ui8e/JjuSywrWZ9xIuofIENh4rpyMmhuwGGE8k3MwawyRXxJ/TF8bgNoHoA=
Received: from DS7PR03CA0028.namprd03.prod.outlook.com (2603:10b6:5:3b8::33)
 by DS7PR12MB5933.namprd12.prod.outlook.com (2603:10b6:8:7c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.27; Fri, 8 Dec
 2023 23:01:16 +0000
Received: from DS1PEPF0001709C.namprd05.prod.outlook.com
 (2603:10b6:5:3b8:cafe::27) by DS7PR03CA0028.outlook.office365.com
 (2603:10b6:5:3b8::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.29 via Frontend
 Transport; Fri, 8 Dec 2023 23:01:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001709C.mail.protection.outlook.com (10.167.18.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7091.18 via Frontend Transport; Fri, 8 Dec 2023 23:01:16 +0000
Received: from jz-tester2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 8 Dec
 2023 17:01:15 -0600
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdgpu: increase hmm range get pages timeout
Date: Fri, 8 Dec 2023 18:01:04 -0500
Message-ID: <20231208230105.733781-1-James.Zhu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709C:EE_|DS7PR12MB5933:EE_
X-MS-Office365-Filtering-Correlation-Id: bf4ac977-e72f-449d-38dd-08dbf841953d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WFxzNbgzSdrSeGZ1jQ3XCjbXrFAPPgTspgVYrsh1JGNnxM/wHQPupT5aMxt/1jsp5XI4tEGqm5bZNI6Z6naxH+Zk9PnnR0mEp2MIbR6OqZ2MBzWfFO3lKTmGxbchZqeLzii/p75/hL5fcNIhOxegDO7nhnkFnoVs9IKHlbSpdvzN7KkoYcBRjMx/JbjjBK4v6vQTaBvcGbzwM8N/cnhD96vcdSh9xR8MRyDTRnjdr0lerMTPfcTpyue/Bo6xGiXtYwE6z64hs5pZX5uNjLlt73jOuL2l5Wace2zzJVL5bVhlDvAQr4SeGSeTGLNNpWmPOovXHXp9Pu3ngqzRi5hcWAwMvcJhlv2vTOaGQQiURbk2Guk2rBk4v6vtIi/7ah+CVWjcZ4aS6CpCI8EFz05bUluVeroJBJK2LEfoBsl2AzDXrLbm5gE/ieF2oCgpqEqlXq1/0aZdOPuQgeUqMWuK2xIHC9ES41xCGprMdcjfBKhc4seGzbJvcyiDjz80xucQwIbLhMjva8PzUhdwqvo7SBmxdSTuFDMXYrjo/6la1qoAmGY3Gs2hbKHMNNqSIzY+oYJhysrJ8IfGXx7ssbCDO8IKdb6fbhCLpJrnYV5Bu4lZykmYSxu2JxOU9jg2BwpIrOQrZvHuI26nhqb9+vwOJ5Caew+uYAzPwVc/chZXpV7oLjvhiJP7FfKyMd7paQVXnfgAwBpul9wOfB3dBw+sObUnXZ1IVy33oMrX5yX3GSefOCSSCuwry/kX1lbJFJpv2QAOZkZeudkTD7g1vdIRkg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(39860400002)(376002)(396003)(136003)(230922051799003)(64100799003)(451199024)(82310400011)(1800799012)(186009)(46966006)(36840700001)(40470700004)(40480700001)(40460700003)(2906002)(36860700001)(41300700001)(5660300002)(36756003)(6916009)(8676002)(316002)(4326008)(426003)(7696005)(356005)(81166007)(478600001)(6666004)(16526019)(2616005)(8936002)(70586007)(54906003)(82740400003)(26005)(70206006)(86362001)(47076005)(1076003)(83380400001)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2023 23:01:16.2655 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf4ac977-e72f-449d-38dd-08dbf841953d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5933
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
Cc: Philip.Yang@amd.com, Felix.kuehling@amd.com, jamesz@amd.com,
 christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

When application tries to allocate all system memory and cause memory
to swap out. Needs more time for hmm_range_fault to validate the
remaining page for allocation. To be safe, increase timeout value to
1 second for 64MB range.

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
index 081267161d40..b24eb5821fd1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
@@ -190,8 +190,8 @@ int amdgpu_hmm_range_get_pages(struct mmu_interval_notifier *notifier,
 		pr_debug("hmm range: start = 0x%lx, end = 0x%lx",
 			hmm_range->start, hmm_range->end);
 
-		/* Assuming 128MB takes maximum 1 second to fault page address */
-		timeout = max((hmm_range->end - hmm_range->start) >> 27, 1UL);
+		/* Assuming 64MB takes maximum 1 second to fault page address */
+		timeout = max((hmm_range->end - hmm_range->start) >> 26, 1UL);
 		timeout *= HMM_RANGE_DEFAULT_TIMEOUT;
 		timeout = jiffies + msecs_to_jiffies(timeout);
 
-- 
2.25.1

