Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E33BEC433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Apr 2022 15:52:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 808FE10E50F;
	Wed, 13 Apr 2022 15:52:04 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2049.outbound.protection.outlook.com [40.107.223.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F1E2010E50F
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Apr 2022 15:52:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XyaSj4tkQ7XJ571hIOPy095N0nVtv5iq745BSUzKe0AXa0Q7OVGycNlgcWYUJKcJJ9WTa/78qC/onfjxaERoOX0RGpAH6s84YwMfYx8pEqobrVqZ+W8OxwBki9nyAKfWlLLKmNsv/K55us/GFdJYLApFBlXWYIpXw6PIpVMYLHbF+nuJRVyoesRnOPqxQK4X4zxlwkCFp+zKn0+W4Fw27gcNG3yjHqW/tgAS0B1NQJgHKLajBXmGVQUHP9qncH8bvAGdZyx/6PnTWf8sn0i7kn2HPt5AVUHLzqUMeN6q0xXqm0RpDovGT/RqL+jFtIh8yTX5dHaJL3aYczHuIFyLuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MRtSrXwxOzikikGvJPyGmjXpn8EhOo4pZOrWzBwkHHE=;
 b=a8T4RLIa/JbS1+bhBqJ/FAHRElcwrZAVK1gYeuoIM+n/c944v5TNYdB50s/WHECxa1jY8/ELVI/jMNIk3Wb+9DE1f9km1V9iRtzVoPA6VGYLJy10vrJccMOvTzcY1LN6A+7Bz09T5L5Vq+J/1j1Wiopa1jD8ScdrGUCgqA7WE0s/x9yDGDoCjuaFXxUEIbL5oSQtU53zAoVxJV7Z7O4inGk6OJ0vrwfw9dhIoIWgDiGjUhQ4nyGzstXoq/BrghMcRN32dSpzKpCjAm57eIJ/zvNLk3eOdx6so3VDquffyaObmtawUNKu4Tfgedv/soSdQhe0zQzLERej4o4pTeHetw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MRtSrXwxOzikikGvJPyGmjXpn8EhOo4pZOrWzBwkHHE=;
 b=o+3FilVUOR55lgrcg0g006hG3hk9G1r7MbAnYnuNTT3TcFt1r2DqhclF99Gy32eYa835M2mF7TMjQOQOKocwXJA3fqVr8bfMORcduKjEU4bQSW4eMSdn3wBD7qULZrbJub2h8wFwwR8oGeQP9wuiWoE7bsFW7DlBgplv/D2XSVM=
Received: from MW4PR03CA0102.namprd03.prod.outlook.com (2603:10b6:303:b7::17)
 by MN2PR12MB4143.namprd12.prod.outlook.com (2603:10b6:208:1d0::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Wed, 13 Apr
 2022 15:52:00 +0000
Received: from CO1NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b7:cafe::d9) by MW4PR03CA0102.outlook.office365.com
 (2603:10b6:303:b7::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.18 via Frontend
 Transport; Wed, 13 Apr 2022 15:52:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT034.mail.protection.outlook.com (10.13.174.248) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5164.19 via Frontend Transport; Wed, 13 Apr 2022 15:51:59 +0000
Received: from dayatsin-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 13 Apr
 2022 10:51:57 -0500
From: David Yat Sin <david.yatsin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdkfd: Fix GWS queue count
Date: Wed, 13 Apr 2022 11:51:44 -0400
Message-ID: <20220413155145.861750-1-david.yatsin@amd.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 88fe6c4c-90d2-4733-07d8-08da1d658bba
X-MS-TrafficTypeDiagnostic: MN2PR12MB4143:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB4143E16075E9236279776F5095EC9@MN2PR12MB4143.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0SnmRfdfnWxjLTgpiHmqx21qQIwu3CwS6/0sO0yWFrDZUxcnSNE9eFIt2dFIp23BXsHPUTSAUiZx9+A0Mvg8XICkkbHxEs3LsXv+IRJ/42XMRxi+EUIb66EIZLSlX93xwmblDowwJxpjBKATLaWMvwQq74IEbdeflS2sNSSAAFNqXduCNHZ7selGD5hIbjgVwDsfJP35tow6t2NugXbMLrVgqqu58wazjAjVpsGTUI83KFs16CEIpkylzM6P0Q2MNUsZU8G+7kRi/3p6rI64oK8wn+9nqMgddrviKFXTLPYJQkA73MczLBYv6j43M52D2G0UhJOHhRIXyMuoZNjSdwrKBqGBYJrMPw7f8+LgFi7V45+YLHtZwprwf9MajT6nZh/XUnUQB3FsQSbqd51Jkot44rb4FDnLl/gnAAtxMZ+MhSp+9XOvMZx9YRcHlhFGsjWpamlwkg6jquhn6QHZgUgtlrsf7OBpG6Wa6wmvkWmmjLdeGC5WnyZKzIuJHLetCHISD1BPayfmvA5B77nujO5E+cxtjnkJ182IaSQh1DfLUGwffX0gRQTd8SxgEvYdtdAZ1mWjUI7bOtm0UrZerpssJC01hIy5/uRybZB1LJkJYQ5TGTmUrPaD9HfhY7QK1LqW8iHISKF1LOlm6MaUslx13fF+m09FPxi7034A4kGoFBdNbgOhsHMWNWE7DgcoBJiQi9FkNa3LTM2a1oaOJg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(36756003)(82310400005)(6916009)(6666004)(81166007)(86362001)(83380400001)(336012)(36860700001)(47076005)(70586007)(4326008)(8676002)(70206006)(508600001)(16526019)(8936002)(2616005)(186003)(426003)(54906003)(5660300002)(316002)(26005)(1076003)(356005)(7696005)(2906002)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2022 15:51:59.7754 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88fe6c4c-90d2-4733-07d8-08da1d658bba
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4143
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
Cc: Felix.Kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Queue can be inactive during process termination. This would cause
dqm->gws_queue_count to not be decremented. There can only be 1 GWS
queue per device process so moving the logic out of loop.

Signed-off-by: David Yat Sin <david.yatsin@amd.com>
---
 .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.c    | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index acf4f7975850..7c107b88d944 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -1945,17 +1945,17 @@ static int process_termination_cpsch(struct device_queue_manager *dqm,
 		else if (q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI)
 			deallocate_sdma_queue(dqm, q);
 
-		if (q->properties.is_active) {
+		if (q->properties.is_active)
 			decrement_queue_count(dqm, q->properties.type);
-			if (q->properties.is_gws) {
-				dqm->gws_queue_count--;
-				qpd->mapped_gws_queue = false;
-			}
-		}
 
 		dqm->total_queue_count--;
 	}
 
+	if (qpd->mapped_gws_queue) {
+		dqm->gws_queue_count--;
+		qpd->mapped_gws_queue = false;
+	}
+
 	/* Unregister process */
 	list_for_each_entry_safe(cur, next_dpn, &dqm->queues, list) {
 		if (qpd == cur->qpd) {
-- 
2.30.2

