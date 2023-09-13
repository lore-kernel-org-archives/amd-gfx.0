Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB73DEE3F3F
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Sep 2023 01:52:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3BF5410E0ED;
	Wed, 13 Sep 2023 01:52:26 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 518D510E0ED
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Sep 2023 01:52:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OoWnuj2fi72Sr0ClITBHtNNJicWyxeLgOHmGKQ3MMtty56AxzJRIAE47NwPUsyPYgr5PjvU1B8sr2YKXjzYDqS1xVPVXVwux4AuBCorpekeSvC77JN1i7zIgeyHzJyApM/YZhOvApqfWgrvSyTJwYRhd3hq7e5JcOpTng3+FE4xvJhZXKbaG09nRjYOfxOspQUVTlLKXsb7bWlpostxDJvCT/+Wa8tEQXU1nlTxa1c5jh8JIDx5fCFabV+ryDs2piS1OMPohc/zsmpozHoVjdiGh+20UUAYsW4yH09JjFPs9mnhNvMFHtZ8xJ0XyuKKXWAG2vvKniTQLA3zNzL1BaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BZsNYcuI+XbS6TJLDVidSHZZ8dKUyfmdmjZ1hgc4IWc=;
 b=JlanLBj1hf2yYH4qPDf/bFEMmX5bYal6l4F6Fvlxt6NgjSpMHTMYjpI0AmIvuqQvabuY1pMdll0aPQr/bImB+kvZURrNPA2iZGI4bbQ2OUa0H08WhGVY417YW1rfSj6JmZqQh4pMW0QF8QdblecXIW8jdoE1njgrNnelzbgnNHbg9/AvqS5mQHLwJ//3vsqs0EFt0E0zH8g3xiuZlx7Fs0P5yaKkOoUIwKJoEShA5KVWSAFiAezr/eNz+NnrlOVoxH4IGyML70OjICHeAgIsMQC/F7CbUysNgKvy3B0ObY/jg3tocF6E5fhdvp8vk3QLVagjWKQ+UMAtR84sIHqvvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BZsNYcuI+XbS6TJLDVidSHZZ8dKUyfmdmjZ1hgc4IWc=;
 b=NF+Vs1olhHL1dmj90LuR7dvyYP2HlSgFZtVxCKyKexvnyTCkEMwQPBthrX7RGO3ED2wsBNU/r9R4VsWZY3A07uLMpgrQmKDP3nh6ohlSd6AdpWOLmzQhD6F3L6Yik0+n0cFqxEj01fCATj26+dNa/txxtBdiPXK1TVdwR9r7t2k=
Received: from MN2PR01CA0044.prod.exchangelabs.com (2603:10b6:208:23f::13) by
 DM4PR12MB6134.namprd12.prod.outlook.com (2603:10b6:8:ad::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6768.30; Wed, 13 Sep 2023 01:52:21 +0000
Received: from BL02EPF0001A106.namprd05.prod.outlook.com
 (2603:10b6:208:23f:cafe::89) by MN2PR01CA0044.outlook.office365.com
 (2603:10b6:208:23f::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.19 via Frontend
 Transport; Wed, 13 Sep 2023 01:52:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A106.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.19 via Frontend Transport; Wed, 13 Sep 2023 01:52:20 +0000
Received: from jonathan-KFD.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 12 Sep
 2023 20:52:19 -0500
From: Jonathan Kim <Jonathan.Kim@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: fix add queue process context clear without
 runtime enable
Date: Tue, 12 Sep 2023 21:52:05 -0400
Message-ID: <20230913015205.3173952-1-Jonathan.Kim@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A106:EE_|DM4PR12MB6134:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ed760e3-e261-474d-e61b-08dbb3fc113d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m2MlLZs9/LVO4YKKQ+lDWVVaWUDEJdEui5SlLyN6x3PiSZZaPteXyWhE4RXsgH8dpI40UMb6p+7Vsd1fvwa49UCsNx/x/TeSh0bO6aat1cW1WKD6w79EK3uG4YwPEVNtTzKHVucPzqkSmPV/L1+h/27obYfO0zx4B3jvNL9xmXnzBCFqtz+GGqBU82GM3Zms+uCUYporH75tK2sc6+ZbIv+qKIbE+ZBLft0TgVQ5b9xa9MhI0EK0fzqd+4vDd6msf/RbJ3hP9JQFxn5ltbyKP+H8OKjWYv1XOHi2W2v/MiosBk0nmyPCzh1NJJIpABsrScp4W7745Ezq5tPf3hQdqU79bUwb1+X+b3Huw319t3Lb9rEqwf4Fr+wFgiomPwsuVjrASF75/rVxXGRmuNxw0T9HvTeZGZz+M3/Fo7/KJpRAs0PGtJg+4YwCxXKR0kWyHvXvHZ5McksNY6H9uRBCsJlLPkohBgM4YocVLmg3H9RQvGfxM02KBBRhPhQtfrcgQqbyd/xgJQD62H51eN+3J5xmo8TTw+7P7h8WdElygpG3+ZsvvVc5GBI+dAEEbWsUOKQaH7Ntd+a3jntM2cNI6gr97qQbqSI9Y+wgUSn27ef0YBnr7+3m/DBXYSzurQ/NRLkYNILX8zh+V+gFAI8UnCaxs5vzpFfkvCtnkWO9f9+R3vETFicfv6fvBC4WJadRdsyJUi1nG5SLZE5jIr5dhCf7wGqsMNoksvbFmlvWnYMt2ZMlMk3jFLO7xzByYxYoBZwiOuoMt8oGCy6T3/wFOw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(346002)(376002)(396003)(136003)(186009)(1800799009)(451199024)(82310400011)(46966006)(40470700004)(36840700001)(8676002)(4326008)(8936002)(5660300002)(70586007)(40480700001)(41300700001)(54906003)(316002)(6916009)(70206006)(2906002)(36860700001)(40460700003)(86362001)(81166007)(82740400003)(83380400001)(2616005)(16526019)(1076003)(26005)(336012)(6666004)(36756003)(478600001)(356005)(47076005)(426003)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2023 01:52:20.4988 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ed760e3-e261-474d-e61b-08dbb3fc113d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A106.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6134
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
Cc: JinHuiEric.Huang@amd.com, Ruili.Ji@amd.com, Felix.Kuehling@amd.com,
 Jonathan Kim <jonathan.kim@amd.com>, Shikai Guo <shikai.guo@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

There are cases where HSA runtime is not enabled through the
AMDKFD_IOC_RUNTIME_ENABLE call when adding queues and the MES ADD_QUEUE
API should clear the MES process context instead of SET_SHADER_DEBUGGER.
Such examples are legacy HSA runtime builds that do not support the
current exception handling and running KFD tests.

The only time ADD_QUEUE.skip_process_ctx_clear is required is for
debugger use cases where a debugged process is always runtime enabled
when adding a queue.

Tested-by: Shikai Guo <shikai.guo@amd.com>
Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 6d07a5dd2648..77159b03a422 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -227,8 +227,10 @@ static int add_queue_mes(struct device_queue_manager *dqm, struct queue *q,
 	queue_input.tba_addr = qpd->tba_addr;
 	queue_input.tma_addr = qpd->tma_addr;
 	queue_input.trap_en = !kfd_dbg_has_cwsr_workaround(q->device);
-	queue_input.skip_process_ctx_clear = qpd->pqm->process->debug_trap_enabled ||
-					     kfd_dbg_has_ttmps_always_setup(q->device);
+	queue_input.skip_process_ctx_clear =
+		qpd->pqm->process->runtime_info.runtime_state == DEBUG_RUNTIME_STATE_ENABLED &&
+						(qpd->pqm->process->debug_trap_enabled ||
+						 kfd_dbg_has_ttmps_always_setup(q->device));
 
 	queue_type = convert_to_mes_queue_type(q->properties.type);
 	if (queue_type < 0) {
-- 
2.34.1

