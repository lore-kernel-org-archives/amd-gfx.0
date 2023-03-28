Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE58DC76196
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Mar 2023 15:15:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B27DE10E927;
	Tue, 28 Mar 2023 15:15:04 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2048.outbound.protection.outlook.com [40.107.243.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C84E510E90A
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Mar 2023 15:14:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bnzibr6oejGEeawbuE/8MTK92EANadKbY6rq/6p6wFMue6NqoMFKzz2bLDx10PgwpJ6/t29lua1xRba+KIPCh6ZRn3TQGlV1dYoWe/7JH0Irm+a2bZkmfbG5XkRW3j5j9rUaakkSWJfg2olFOF6xNgTqOhGr0i/XrfRMY4/92FW/SueXid3yDly+qIeILwDbtzVL+EFnIyF0Ewbidf2ha3iWTvIbazgtEiXB1lM+6AWZI4+0s/nIN1DhtKodtvTpLvZTsqSiEfqwCMTebRIoz/7dGTI2upgCBw2xzXdhCPdcFzqCJ29cP/4DYlfOWjyIZ642ofVclmiVdxV25RuSUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nsTLCN9RTiySEijjcajvXGMV6K1IVzkFueixWXKRBJc=;
 b=L82urfJgtlDGoOgFyrM0wmg3HbVayfOn+c+cI8kbJNJhUtp6S3SC07hHMMFn1D3rxfFP4jScCrh49/tIjIRwAtDaaxUj8UajeEZTDbwshoXkAHMi2Veq2d7D8mbCeeh6J2MHUY1qIDE+3rCEvyNFJvJdX92MeMdqpFc8ERoxaMGCz1INSrSXWYs41ZWo578w+BMkIA086S2tQE0SNIvGvQy5hLGGoxqEoV5N/podLbpA3TrnZUTV74wrCkjWk5ovZl8fx4jZwLZHICr4ST2jriAJaJ6txrcj8ra+Rica7B0hjegAKRvp9eCVakgU1MmqlIZN+4+tpQrS1XXQlyO2Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nsTLCN9RTiySEijjcajvXGMV6K1IVzkFueixWXKRBJc=;
 b=BiSqd8PyNAQF7vgCAGVvJpWhfiH/wFJLUKuRgWKuAFngLghditWIIDyqcwtTfiyL6S6YaYweGsMZEz7G5/H8EgSOO/jjC69PaOtDGC/RVM5FihsNOSotFBQjHmsxa0DlIs0PrXdxdG5Ux5YI9z2hyUEhZPJFkVm4NQBc+jISDq4=
Received: from BN0PR02CA0036.namprd02.prod.outlook.com (2603:10b6:408:e5::11)
 by SA1PR12MB6995.namprd12.prod.outlook.com (2603:10b6:806:24e::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41; Tue, 28 Mar
 2023 15:14:39 +0000
Received: from BL02EPF000100D3.namprd05.prod.outlook.com
 (2603:10b6:408:e5:cafe::24) by BN0PR02CA0036.outlook.office365.com
 (2603:10b6:408:e5::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.43 via Frontend
 Transport; Tue, 28 Mar 2023 15:14:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF000100D3.mail.protection.outlook.com (10.167.241.207) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.30 via Frontend Transport; Tue, 28 Mar 2023 15:14:39 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 28 Mar
 2023 10:14:37 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 14/32] drm/amdkfd: Call DQM stop during DQM uninitialize
Date: Tue, 28 Mar 2023 11:13:26 -0400
Message-ID: <20230328151344.1934291-14-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230328151344.1934291-1-alexander.deucher@amd.com>
References: <20230328151344.1934291-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000100D3:EE_|SA1PR12MB6995:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e26a62b-98a9-4440-4045-08db2f9f2636
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZWsq2+s1tuOF8iYP+wrmV/LzqJQmPWnhmoUnAuYz0SHQfStVjA85S6lHIo6z1JHsWHcM8tgF0H12+t6HYw9YaHtoyqJfRPcQnsMpohKLnW7G10WRN7CjSe77Q5M14IRkggXgOTXICAIRxGyF2jiH3jycaGYLdwUhwARnFYKuIhu5YORVWdFBVQ27PUUeR4per6ZkD5zDGRQ1wlyqTdPPE8nsAdtES8ay9Q8SoPMOm/PHTIHpW5DQZbiZNv7kCEaSU35Nh1j0r7HQTbPMNc/phSy1e6lTBZGEfGNEV9op1os3J1gkWHfsILKAEAZBoKDM5zXCWurCJQ0AayDcKp088Fbia0iwLb8Ygpia9KqBYgLGmJbtIEjGevd0euK5KxKivLo6/JBw8BYMO9t+kG55ulAOTqFZFgLG/wo4reCg3JIEUu1/eFuxDGo3AdVeBHM+pNAD9f9UixGvZskjKGzlXyEnfEaQhYaquHZWtXMp+UWy1oCfbyXLJT5v2HIKGximZEIyxHKyh2aUC/oCVyxFufs2/tG9fxnyJrmV/4S3Q2p0XrEwc+dxxNBmtMv4N1RUDvhETKnolw2lx6To1e8JviXndas6kmHPlDmAkKOsYPbfSBM0JRASUpQldAbYJbANK+gvH+egINoACRKjOuqkVHIhXjV4eBVW+i2jHsGJ0v8HpS5+BQ4OVuPnMAYEzBb9uutodPrY5b0j/buE5Pt7M/b/3ebcXg8Q4PPbCSIzMqQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(396003)(346002)(376002)(136003)(451199021)(40470700004)(36840700001)(46966006)(70206006)(4326008)(6916009)(70586007)(5660300002)(54906003)(7696005)(316002)(26005)(1076003)(8936002)(81166007)(8676002)(2616005)(186003)(41300700001)(478600001)(16526019)(426003)(336012)(47076005)(83380400001)(82740400003)(36860700001)(66899021)(356005)(40460700003)(86362001)(36756003)(82310400005)(40480700001)(6666004)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2023 15:14:39.0139 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e26a62b-98a9-4440-4045-08db2f9f2636
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000100D3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6995
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Mukul Joshi <mukul.joshi@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Mukul Joshi <mukul.joshi@amd.com>

During DQM tear down, call DQM stop to unitialize HIQ and
associated memory allocated during packet manager init.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 07a04c41e92a..d18aa01a47e4 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -1348,9 +1348,16 @@ static int start_nocpsch(struct device_queue_manager *dqm)
 
 static int stop_nocpsch(struct device_queue_manager *dqm)
 {
+	dqm_lock(dqm);
+	if (!dqm->sched_running) {
+		dqm_unlock(dqm);
+		return 0;
+	}
+
 	if (dqm->dev->adev->asic_type == CHIP_HAWAII)
 		pm_uninit(&dqm->packet_mgr, false);
 	dqm->sched_running = false;
+	dqm_unlock(dqm);
 
 	return 0;
 }
@@ -2423,6 +2430,7 @@ static void deallocate_hiq_sdma_mqd(struct kfd_node *dev,
 
 void device_queue_manager_uninit(struct device_queue_manager *dqm)
 {
+	dqm->ops.stop(dqm);
 	dqm->ops.uninitialize(dqm);
 	if (!dqm->dev->kfd->shared_resources.enable_mes)
 		deallocate_hiq_sdma_mqd(dqm->dev, &dqm->hiq_sdma_mqd);
-- 
2.39.2

