Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 028A8C10DCE
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Dec 2023 22:54:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5748E10E9A0;
	Thu,  7 Dec 2023 22:54:55 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20605.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::605])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7377110E151
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Dec 2023 22:54:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BZp3aXakVPO0QQHOQcfu+9UrrWHOJeStmulU2r8Yk76qi0DCOip+1ucQxia4F+Gz0MJjC1C6PpC4n5jsiQLhgyzikP85ApE217NQ0ANqYHRUAAxqR/4TNQrE+bMcg4t4q0QmImpABCHMYSUiHVK0+HLPlUFNY+GduztiWsdVCCfrl34zrFcAg8ZBHweW7ByZjdEZqeI8SGC78TXzJJ4JuNVSTJLnPXZlzRa/iipP37+0y8dInwxtsN4nZRMjES/cUhDZxtoTzW6dueWyd6axxT3AfMWcP61Dz4POPLYF3aoIp5p/+bnWOonFZd1L5H5a9YYo5qOLOwIb5SXHUg65uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kBdcUlFAkWTH8yTTbFjaLifJgznK3Pw6kLaeohF6W28=;
 b=QnslOVhEtrHyB52C/XAmYriEhuRgFSbm7Jb8+XCMUZUCm1b9d4/wX+zMRBjBWRR4JueawIFmC6MqMwdUYX7KhdMJ+7geuh/KXZylsN/B65sqfbalScOCNR7phHZVOFtQF+YXFsrKOyrx9DHpL+6nosBllv+rSluYjJRjOYenzqMvE2Tdaf+F7ysIts1OgSvXnHQsGkX5IB3mYSikbHQS6iE2WUi7Qy5ab+qoxf+JG3h/5HBtsYysFhMRrIEXmV4MoZkAQPcf+SGgkmbWbcMDFZu6phkhBLrzAQYyTLxB4ppn20Bxuo7cChEjzO57H6SHDgzKG8DR743dLm3KiHRoeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kBdcUlFAkWTH8yTTbFjaLifJgznK3Pw6kLaeohF6W28=;
 b=oHBmuzuUGJLxyeT7AJK03hBkaF08Pu0TLvBqpvtJLsJI/yGRF9x7+WefabWEgqdD62ykuJcZoPG3OLMw89T55dKvpCBBiD2F8n7yfytkTK/F20WNxmBWM59rQyCybU6mkPSKfpfAdGI7wgSh06S4XXm9MCI66KSUM9HMHejlRps=
Received: from CH2PR20CA0005.namprd20.prod.outlook.com (2603:10b6:610:58::15)
 by MN0PR12MB6003.namprd12.prod.outlook.com (2603:10b6:208:37f::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.27; Thu, 7 Dec
 2023 22:54:46 +0000
Received: from DS2PEPF0000343A.namprd02.prod.outlook.com
 (2603:10b6:610:58:cafe::42) by CH2PR20CA0005.outlook.office365.com
 (2603:10b6:610:58::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.33 via Frontend
 Transport; Thu, 7 Dec 2023 22:54:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343A.mail.protection.outlook.com (10.167.18.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7068.20 via Frontend Transport; Thu, 7 Dec 2023 22:54:45 +0000
Received: from jz-tester2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 7 Dec
 2023 16:54:44 -0600
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 16/23] drm/amdkfd: use bit operation set debug trap
Date: Thu, 7 Dec 2023 17:54:15 -0500
Message-ID: <20231207225422.4057292-17-James.Zhu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231207225422.4057292-1-James.Zhu@amd.com>
References: <20231207225422.4057292-1-James.Zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343A:EE_|MN0PR12MB6003:EE_
X-MS-Office365-Filtering-Correlation-Id: d2e7e243-c015-403a-86db-08dbf7778203
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 23w3i32TDr5Exu4SNNuoS7vvyRaihPUVpLxW68mr0IQo3fUBtCSJnIiI9GuzNVuv2E1bXmFT/GqGqpSVVha/69apuwJAgLa/eMMPm0FIRGs+cWxdBN/ZkllQKv15GmNQ7iU0pPQE+ZslvNsbMGpvM8WY8EDvYJpvTLx5coKmqGbuL91kjMKfE5EgS1SQ2ymLV6utIapOXxKqKqbvq0l03sdDVsi/JmRKBDPNa6tOeu7W4RbCn4dosA8aLwimaAWnEK83rDb2wzrAk6LoVUIRsz/YxcJSlEtIItnolyfligvjNIl7Lw4KBf+pcK7mQWD+MvG8ry6abTXeYeug9pyQ9XbsGVtAAywdaqQ5llee3W1XRMrJkdA0p00J6LzTlp3SxaxLwUvNlxpqZscmzufnDwcWODBqmpazvsC00l0IX4nxNxGuiivL57T8AGVbsM//GhiLL7LrGwP6wO7y/1SaRXnZmPA/UCNUzNH6J77ip2e/l/R2+l15L0NNBmkW2z4wBap/I3jV0z8T2a0X2b1W8bQ0dghBGVlM2QYTmsbw0M8zOf2gb4vXM/4Q6HKTUngV+1AzKwvh6YnHvBkslMSybf1UwRfua+DxphGTiuBw8SACxoxBO6+WUk9Jiz4UaHzrdzI1fuj2tXFqPZ+2LWQ5GjN1j1nAiEEbasId62ohzJKDBglta8/M7teKQGGCJHBs2wH3NA+nsT27HzMNFIy2mhzS7FagWUUnKxuatHs3fQMp+QEjwxdEqQfJ0z2F2X7ePgFzGThE+m2+BsaT1EEp6A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(346002)(39860400002)(396003)(136003)(230922051799003)(82310400011)(1800799012)(64100799003)(451199024)(186009)(46966006)(36840700001)(40470700004)(40480700001)(40460700003)(36860700001)(41300700001)(5660300002)(2906002)(36756003)(8676002)(316002)(4326008)(6916009)(1076003)(16526019)(336012)(356005)(426003)(81166007)(478600001)(6666004)(7696005)(2616005)(86362001)(70586007)(82740400003)(54906003)(26005)(70206006)(47076005)(8936002)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2023 22:54:45.6714 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d2e7e243-c015-403a-86db-08dbf7778203
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6003
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
Cc: Felix.kuehling@amd.com, joseph.greathouse@amd.com, jamesz@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

1st level TMA's 2nd byte which used for trap type setting,
to use bit operation to change selected bit only.

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_process.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 71df51fcc1b0..1a31b556a5ff 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -1440,13 +1440,23 @@ bool kfd_process_xnack_mode(struct kfd_process *p, bool supported)
 	return true;
 }
 
+/* bit offset in 1st-level TMA's 2nd byte which used for KFD_TRAP_TYPE_BIT */
+enum KFD_TRAP_TYPE_BIT {
+	KFD_TRAP_TYPE_DEBUG = 0,		/* bit 0 for debug trap */
+	KFD_TRAP_TYPE_HOST,
+	KFD_TRAP_TYPE_STOCHASTIC,
+};
+
 void kfd_process_set_trap_debug_flag(struct qcm_process_device *qpd,
 				     bool enabled)
 {
 	if (qpd->cwsr_kaddr) {
-		uint64_t *tma =
-			(uint64_t *)(qpd->cwsr_kaddr + KFD_CWSR_TMA_OFFSET);
-		tma[2] = enabled;
+		volatile unsigned long *tma =
+			(volatile unsigned long *)(qpd->cwsr_kaddr + KFD_CWSR_TMA_OFFSET);
+		if (enabled)
+			set_bit(KFD_TRAP_TYPE_DEBUG, &tma[2]);
+		else
+			clear_bit(KFD_TRAP_TYPE_DEBUG, &tma[2]);
 	}
 }
 
-- 
2.25.1

