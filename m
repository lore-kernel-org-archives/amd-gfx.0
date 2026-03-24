Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C35F2FEC0EE
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Mar 2026 17:58:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E3E710E614;
	Tue, 24 Mar 2026 17:57:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Q2qAbcgF";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013005.outbound.protection.outlook.com
 [40.93.196.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A04EE10E60D
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Mar 2026 17:57:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gK+eWbMpcAGED2DjQDxWYr+tBnuXFZeWzugzjQ/HiJ5X2s9xQhEj0/TWBMdvtJ6TUUv3HXnrysOj+M9ujitH8R3lKMgP8pbb4Vr4RFwdq9zm60LkRt8SAZYkqejnDBAS0CsyVhewWChYAtOVl4Nto/h5QgBW2AdQaB7s3wxnjTfmDiyXc0gNUlwvup1R4LrdIhzCzCRYb/J4g/z/s5JlUKPYyqrzosLH+pdgzNtE9ywohMotN7OecIb75aqHkzzpup22v6KqGwl7gLbRd46OqS74a8AXBQrV/GSQhuPs2073TjVohhy8Vt76QlDo7s3N29z/Z9ALyajB9osG8FbKBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IIN0ysqR7hLVQZ5VqLWKwiGW9ChhvIShlMDKcne0z+E=;
 b=SeMZFzgfKV3IXSsSrsMSdwNStmZYPyn8Z3TXK/VNIY78wI51PtYqiR/HTUSA/E6BPISlHFFfqTLlNtUsIBrlmGu1/XEEdqoybBLcfGWjYXW1MlRoBAQ/o/iFegMvpZzGgqJEfJSyjjJo0z39I/TjHTGdgsEsFgqx80qhNg4ZG+0EE1UajeAuQWUTCDhb1lxTW7SZlLaZVS0OTdnkpQewNKn4TtnUFiRSoVgdCVSYjwjS2jW1qQcmllbID0cO059Qd/wAVvJh9sMkQnfPNRgYVjMCnLq/8DpuKoMiIJ4hb9QYB42TV35q7H+6fhobYP2Q5I+xszZCG0FHe28TU37cOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IIN0ysqR7hLVQZ5VqLWKwiGW9ChhvIShlMDKcne0z+E=;
 b=Q2qAbcgFxrgKJJm7vnowSrWVoU+t9G5v6WaRNw+rtQ5B3RFj2ePIJrb6V7tNd1pnIzzmnL9genONfV0enUw12gYdJwlxpFuWdO3KHRWWeFZwViHafOqWEacVOPnJveelClcehxFWIHJ2enZKFd9XuxG0VP+sA+zYARjXQMi+W0U=
Received: from BY3PR03CA0007.namprd03.prod.outlook.com (2603:10b6:a03:39a::12)
 by MW4PR12MB7481.namprd12.prod.outlook.com (2603:10b6:303:212::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.15; Tue, 24 Mar
 2026 17:57:47 +0000
Received: from MWH0EPF000C6190.namprd02.prod.outlook.com
 (2603:10b6:a03:39a:cafe::29) by BY3PR03CA0007.outlook.office365.com
 (2603:10b6:a03:39a::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Tue,
 24 Mar 2026 17:57:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000C6190.mail.protection.outlook.com (10.167.249.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Tue, 24 Mar 2026 17:57:47 +0000
Received: from amberlin-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 24 Mar
 2026 12:57:42 -0500
From: Amber Lin <Amber.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexdeucher@gmail.com>
CC: <Shaoyun.Liu@amd.com>, <Michael.Chen@amd.com>, <Jesse.Zhang@amd.com>,
 Amber Lin <Amber.Lin@amd.com>
Subject: [PATCH v2 07/10] drm/amdgpu: Enable suspend/resume gang in mes 12.1
Date: Tue, 24 Mar 2026 13:56:49 -0400
Message-ID: <20260324175653.1325754-8-Amber.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260324175653.1325754-1-Amber.Lin@amd.com>
References: <20260324175653.1325754-1-Amber.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6190:EE_|MW4PR12MB7481:EE_
X-MS-Office365-Filtering-Correlation-Id: ccbccd25-b38a-46ff-addd-08de89cedbc1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: IT7Cz0dDE4jRVfA/b35LR/YCI1PpgfGhkUIuZFyE/i+dhYuCOVMoLfMvQ/SX22ykX2yx7Se2qQOv1j+R2ElI7VhqJxYSw0yEZUfcbyE7nuttMwNo+QJLelwKRq3brhyzqY1qV3hy9Xa0jKY95fvjSo2aVZdyRHJayNTWnJYDPLJlp6HxCtyX46Udb7SxEv/JJsO/ddOGJ9w4ivyRPlbZqYVW6sskMUDr3mS3JLGnSeMD+DZ7LaBhRXlWlWaixUxWIhg9ETH/TRNfkSEaGL+4FDyNjpL7oooDauvWSxXt3RNBcMOB4DnR5JnaPwAgzSZzuufzGnppv914PxrBdBTae+ixa5nSCWnRQKgvVBOWLxO01U4am1/6VLOxVi+ydalm4fZjtdAvIs0+MYDkJzM9z556x9Z30ZUjL4HVsREuh3EDKar2lyH48teXuYZNsJqmUcafNVSiOpnNs452MOUlNw9eLhlN8dp7DFTo/V2OAc1xLeUPd+Zid9qtNFywAMRUGsn3d/PK7QdZNA9g52voa7T1BLCC4IG1EeOHjMdu2J/VFaFt5OkBTFjH3dhDlKjpsCcrcewrmxkYwF1W2ObLAZNuM94t234JnirkhXv/mAVjApQIR7bdiNxTGQbMeHmjZd+aisn9zmjQ8WRXDF6PrSHTcarF+iTDlgMjzEoqoUFfQdyZ0yi1awZ8AQd5ouQEnK+tg+oEsLsm7sTTFvd62kjzxAWSRMlOcVK+p7YgonqpjXgAi5z8T7CgPy0TntHOrgBmDpMb4jZ2eH71GtCsMQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: iWOTU9T9BYdsO4RAVMuA+jlhyHK2VRCiuVD7/7WQhN54eMTWhBNmf1q2tOqkb3bg+OLjQ6e2ZPVQV1yURKQTCsQLnTXNjW7EePZcq9l76TRYXKHQAPvDjRUjIkLWCFjDLqwH6mPW8J/w2TvGglPIxBDYF7Zq5BlEtZjWgMbx889dczEs58uOGAsUSXaiSuny8sm/GKwfav3/2A7dguG7ycLwQehcNluZfShoWdQ+waYPX5IRAr4wIXIHGfA1kS70uEsYyaUfztEu3FaMqMRTO0osgO2okt6HSWkUkN2HBT3SOKF07B9xzcERhXkrBipw9GnBLbUIFRILp9Meb1Veo0HKkhfJwup63+hwY0Exda3QDxOswkOq408bt1MUjKQgvxEPdfLrOiLsFR4lzIzpMqZeZdM/gRNDWzdP7jGLHi+fr39L2n21EpeR6FTniou5
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 17:57:47.5016 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ccbccd25-b38a-46ff-addd-08de89cedbc1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C6190.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7481
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch adds code to mes_v12_1_suspend_gang and mes_v12_1_resume_gang.

Signed-off-by: Amber Lin <Amber.Lin@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v12_1.c | 34 ++++++++++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
index 4b279259b9d3..7aea3a50e712 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
@@ -468,13 +468,43 @@ static int mes_v12_1_unmap_legacy_queue(struct amdgpu_mes *mes,
 static int mes_v12_1_suspend_gang(struct amdgpu_mes *mes,
 				  struct mes_suspend_gang_input *input)
 {
-	return 0;
+	union MESAPI__SUSPEND mes_suspend_gang_pkt;
+
+	memset(&mes_suspend_gang_pkt, 0, sizeof(mes_suspend_gang_pkt));
+
+	mes_suspend_gang_pkt.header.type = MES_API_TYPE_SCHEDULER;
+	mes_suspend_gang_pkt.header.opcode = MES_SCH_API_SUSPEND;
+	mes_suspend_gang_pkt.header.dwsize = API_FRAME_SIZE_IN_DWORDS;
+
+	mes_suspend_gang_pkt.suspend_all_gangs = input->suspend_all_gangs;
+	mes_suspend_gang_pkt.gang_context_addr = input->gang_context_addr;
+	mes_suspend_gang_pkt.suspend_fence_addr = input->suspend_fence_addr;
+	mes_suspend_gang_pkt.suspend_fence_value = input->suspend_fence_value;
+
+	/* Suspend gang is handled by master MES */
+	return mes_v12_1_submit_pkt_and_poll_completion(mes, input->xcc_id, AMDGPU_MES_SCHED_PIPE,
+			&mes_suspend_gang_pkt, sizeof(mes_suspend_gang_pkt),
+			offsetof(union MESAPI__SUSPEND, api_status));
 }
 
 static int mes_v12_1_resume_gang(struct amdgpu_mes *mes,
 				 struct mes_resume_gang_input *input)
 {
-	return 0;
+	union MESAPI__RESUME mes_resume_gang_pkt;
+
+	memset(&mes_resume_gang_pkt, 0, sizeof(mes_resume_gang_pkt));
+
+	mes_resume_gang_pkt.header.type = MES_API_TYPE_SCHEDULER;
+	mes_resume_gang_pkt.header.opcode = MES_SCH_API_RESUME;
+	mes_resume_gang_pkt.header.dwsize = API_FRAME_SIZE_IN_DWORDS;
+
+	mes_resume_gang_pkt.resume_all_gangs = input->resume_all_gangs;
+	mes_resume_gang_pkt.gang_context_addr = input->gang_context_addr;
+
+	/* Resume gang is handled by master MES */
+	return mes_v12_1_submit_pkt_and_poll_completion(mes, input->xcc_id, AMDGPU_MES_SCHED_PIPE,
+			&mes_resume_gang_pkt, sizeof(mes_resume_gang_pkt),
+			offsetof(union MESAPI__RESUME, api_status));
 }
 
 static int mes_v12_1_query_sched_status(struct amdgpu_mes *mes,
-- 
2.43.0

