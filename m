Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6784606A31C
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Nov 2026 19:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=JoZOPmHG
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B9E510F8C9;
	Tue, 17 Nov 2026 19:24:55 +0000 (UTC)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012029.outbound.protection.outlook.com
 [40.107.200.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4AB9310F8CB
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Nov 2026 19:24:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GlS2pPTfqllWxyYaKM4mp+/9nEC7AZs+rqtiEj1NZAD/NT1LJ9z1KzeU6gMQFPU7LyDQ4kdx2Z1rUyh6Lv+Byb3jjpCO+cjrZuCoLRi4R2uwqsPkuvRGCQbB/s7aX8HJ+hFbSlPYs3Y8IAysU/0FAwRuLWeCrBglTF5fAAOzDSAdONt+dcEXAzU7/dLZvaB5OFe/YwRh1KeDWOssbpky1QGdFSprBe0XEQx5dGRMD7RBWatN3ygL36MaRQwdc7aOKZcFeDvjIu7F/AVliq4DRwGceX5HX5OUu4HN00TdGIYyxXIFbJhx9QWLXRG4gMmnDDWtsZg+Ioy53h3Aqd4o+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d7NyczUj662VKH32UbnSq23guGykHKjY4gsaDSK+XgM=;
 b=YP4K5TCFKkBtgHKEbBUa0YK+AvlZgpkfa5VXN0PxGvAUnGThOp+qPzShz+34AQSLROw3yoTsoMvOMyDwskCCmRI2FhFLAdBOVnN/BdCb+DlR6hmzJn5+zpbE+XPmfPFzC/bFcyUNIYGf+Tjg/hhJh6Pi818jzFT6QDz2G8C96ecKKvcB3Nnll2no3Q330KRj/qdscw9malGMFLOHndkx9hVW/gyNt/umQf9/CnO/AqZQHj71xFYZ8YGFt3XcOTdny+2dtZh2ubSaDdiK9AzMhBVqgmBC8JmAIkvFm6ck37stcZ7bmE3dJDHheopS+m1/tBsITmeGPXMypzEaERnMNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d7NyczUj662VKH32UbnSq23guGykHKjY4gsaDSK+XgM=;
 b=JoZOPmHG4pZzvmkUDY58Ly+P5zLT1AHmiDnYt4Hawh3WZsAQC9ZIfm+AnbOcTForCxFMNtOAY0J6inBt5n3vA1WydvfdHCfD2D55MId5kyaQnVKT/P2Z7al9Z0YeyYZm/LbZRF0aNtUgDuKGSqDficNhLVEPGai10WlgR5wmP28=
Received: from MN0P220CA0007.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:52e::25)
 by CYXPR12MB9338.namprd12.prod.outlook.com (2603:10b6:930:e5::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.13; Tue, 17 Nov
 2026 19:24:29 +0000
Received: from BN7PEPF00000094.namprd03.prod.outlook.com
 (2603:10b6:208:52e:cafe::41) by MN0P220CA0007.outlook.office365.com
 (2603:10b6:208:52e::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Tue,
 17 Nov 2026 19:24:29 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN7PEPF00000094.mail.protection.outlook.com (10.167.245.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Tue, 17 Nov 2026 19:24:29 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 17 Nov
 2026 13:24:28 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Tue, 17 Nov 2026 13:24:28 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Yogesh Mohan Marimuthu
 <yogesh.mohanmarimuthu@amd.com>
Subject: [PATCH 4/9] drm/amdgpu/mes12: add support for setting gang submit
Date: Tue, 17 Nov 2026 14:24:10 -0500
Message-ID: <20261117192415.810117-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261117192415.810117-1-alexander.deucher@amd.com>
References: <20261117192415.810117-1-alexander.deucher@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PEPF00000094:EE_|CYXPR12MB9338:EE_
X-MS-Office365-Filtering-Correlation-Id: db579737-e438-48ad-824f-08df44e06660
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|376014|23010399003|22082099003|18002099003|261009223027099003|261022075727099003|261022105027099003|261021121427099003|261026140227099003|261028144727099003|56012099006|11063799006|10067099003|261102123227099003;
X-Microsoft-Antispam-Message-Info: BjGkN1OVcPQC0+cC3VxPwjd8Ro1QxdeMizgvjRm8K4mW/I8BozgJt9/rDD4AVZwhlCiCvk5SzmUgd8F+GijDWDtpibOUv4GJan/zpCOM3XtmZ4aLpXhwtMUNUV1a8TGlQph9xYwqWtcIccQjI5eeVX4xQCkLHlu/mnQcI1xgfueLtfi29zt6amAOrNG6hKM7x33I37ZWrsKDMQptdjcrdmsd0UpSy5VHm4Hj+JmkoZ4dcQBsWUlN3q1PwZe/94VE0VZk3m1/2qOeAts07VR2HcGeRh4zqOj0P0ZA+th6T5WAb3kopFQPzH/SK3x/rTowsuDvqbriIZYtQCE8rVtuR5GlX7DPYDubXz8wRxt9m950G1BKZ1MTa8mE38EIogfIHfNrCCrRp3qrNKMLkDJwxnUL/Eg2dw8yxp3G0taMgvBZcwZf42kGKsYXnnlwfLJoPabaIBhjZf5zONIc3aAFi/fVPendrWMqbZM5m55tldo1STgDdwxwU+xd96q7ZDLJNb8rbYNOo2ymtB+pTCRwh7ypi/Gf7tRcW1Ug5+5kV5trwiYuYETH9EpbKnY2LfprcmV7Wm9RhVauQUb1N1YZlfFfhp12TnOE5KiJU1HZMQk+MsdFhsJ6LE4Fnhj8dFOf9dMRxmfvqpnUqCi/U+Y9MyLE4aqYdQk/lb9vPIcDnqhQa6sGyrf0Y+1ZU4bDPw54fj6XTyNMhRmzbPXadVE2ZQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(23010399003)(22082099003)(18002099003)(261009223027099003)(261022075727099003)(261022105027099003)(261021121427099003)(261026140227099003)(261028144727099003)(56012099006)(11063799006)(10067099003)(261102123227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ZvvWv7VpKVXs7+M282zPdPbkCYFyTF/sYD8ESQhzGJ09+tpxt7lTRtPUBvAm5Ey5nf1CpcTVxI8g18n0WLGwJQYDmoevp7H9Ne39h89CN17fG8de50Tgvge9Iw5plk6LBT1LgBoH4atlZT9nFTwxz18I223IOXiQcqg3cw+XNajKIQ/MVO2XZtK6wYCG8bhspziVJfZt0JeT1+kZXXMg31UAIju6JCVHp4IE1ixXc+I4xNJII2Cnlrgg2LQO3/8FLyjHnzOVs2UDHquqYgfkBJenjUw53CRhZjJbiqS1gTgywacM4hHgNyV8iBlgj7d9qmlfg+Hteo+7waw8alnvUbHN1Dakw3Hq/bnpcbeSXgl8wytfs9+sevCYWzglLKJQfFGp9acVJ/bVjEq4Hn+X19chK7Dzbu+rwjRnNSURzz01XLm21MS2WTShZ2RZihtH
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 19:24:29.0442 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db579737-e438-48ad-824f-08df44e06660
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN7PEPF00000094.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9338
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Enable a primary and secondary queue that schedule together.

v2: fix offset of api_status (Prike)
v3: use AMDGPU_MES_SCHED_PIPE (Michael)

Cc: Yogesh Mohan Marimuthu <yogesh.mohanmarimuthu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
index 988e05823d2d7..87646eb0a9ab9 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -1313,7 +1313,27 @@ static int mes_v12_0_inv_tlbs_pasid(struct amdgpu_mes *mes,
 	return mes_v12_0_submit_pkt_and_poll_completion(mes, AMDGPU_MES_KIQ_PIPE,
 			&mes_inv_tlbs, sizeof(mes_inv_tlbs),
 			offsetof(union MESAPI__INV_TLBS, api_status));
+}
+
+static int mes_v12_0_set_gang_submit(struct amdgpu_mes *mes,
+				     struct mes_set_gang_submit_input *input)
+{
+	union MESAPI__SET_GANG_SUBMIT mes_gang_submit_pkt;
+
+	memset(&mes_gang_submit_pkt, 0, sizeof(mes_gang_submit_pkt));
 
+	mes_gang_submit_pkt.header.type = MES_API_TYPE_SCHEDULER;
+	mes_gang_submit_pkt.header.opcode = MES_SCH_API_SET_GANG_SUBMIT;
+	mes_gang_submit_pkt.header.dwsize = API_FRAME_SIZE_IN_DWORDS;
+
+	mes_gang_submit_pkt.set_gang_submit.gang_context_addr =
+		input->primary_gang_context_addr;
+	mes_gang_submit_pkt.set_gang_submit.slave_gang_context_addr =
+		input->secondary_gang_context_addr;
+
+	return mes_v12_0_submit_pkt_and_poll_completion(mes, AMDGPU_MES_SCHED_PIPE,
+			&mes_gang_submit_pkt, sizeof(mes_gang_submit_pkt),
+			offsetof(union MESAPI__SET_GANG_SUBMIT, api_status));
 }
 
 /*
@@ -1367,6 +1387,7 @@ static const struct amdgpu_mes_funcs mes_v12_0_funcs = {
 	.invalidate_tlbs_pasid = mes_v12_0_inv_tlbs_pasid,
 	.detect_and_reset_hung_queues = mes_v12_0_detect_and_reset_hung_queues,
 	.enable_dbgext_irq = mes_v12_0_enable_dbgext_irq,
+	.set_gang_submit = mes_v12_0_set_gang_submit,
 };
 
 static int mes_v12_0_allocate_ucode_buffer(struct amdgpu_device *adev,
-- 
2.56.1

