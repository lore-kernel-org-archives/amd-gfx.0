Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BF89CD4F4C
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Sep 2024 01:20:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AFF6910E2AC;
	Mon,  9 Sep 2024 01:20:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZDcTN2l/";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2049.outbound.protection.outlook.com [40.107.94.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 77E5110E29C
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Sep 2024 01:20:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HeENbNj3SF3B38HnRotbseKWQFrq++P9HYnvn5JexVvD7sQj6cfIifDRjWpGaOJ4ImBoLwnOc+g7UZ3vwSsWNzfdHbJeOtTJvsHWZmEVxgbeZr3kPON5GnKirSckSrLfCvlVJvLRt8tOAE2/Hnw+E6SL65fUxlKbIJDZCMKDwKscb6d1SnjStLButLAloyOnOqDYE8oMqzfWRiFxOHe5RncU58lxWj2TPHsuNsSjnSoFQyL1OKioHmXxg5HrNt+ljhzs1vUlflJCHx0NRkAtWNvbYwwZ6cj+FYGFhQ7DtLIDwtpCiyegAey2GjbnwggNghOBof9HinAAqfyrcOoOPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uz3FaCQeiYl4btrEc0T6ekY3s39xvh1HPs5yTmhwcag=;
 b=yLaISTPZWfloVRnfBggC496EMp6tl953gLMvUPSS/r9VXAbgpf99R+Y10wwJpJWnmQlgwF47c8+ojLCSUPADWcNyG4vjwpxz6KXgZF+8Zgx/Oyt2qf6gbY7xfqqj3aZ6lu2vYvAcjQxvuSu79J7H2cogAOWnozhuE/YqAj90j/EwQXeMtZZhskLQhKEgVDYRnpBxyHEX5RCnc+mRn1ccnY8ekvrhAjdtZ1QoNGIRO1SRcwZ8GnLsy90StKfVn/U6+5+gBOBe4EEZIXgab1AG5o10CwV+EjXmrclNoyI3/61zNCo/ABbSEVn/j+FFnHdYEn1c4RmNXzf2wgZ9h/Hrvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uz3FaCQeiYl4btrEc0T6ekY3s39xvh1HPs5yTmhwcag=;
 b=ZDcTN2l/Fik3pyTGIOO5kN/TPhEcG/+IqkJyFRwP14hTiCOTrQ+zdRBiVGHdUN+oCqvb1PLPAw1M19/LGGb6WgQBWmCVbfiu0mFwHCqSJcrgUE0aO0ROy5T0FtTZh0m+VTItQzzNiur9d3Z1JuxYmz/4TwX0r7dd28+Do9c6nN0=
Received: from DM5PR07CA0071.namprd07.prod.outlook.com (2603:10b6:4:ad::36) by
 SJ2PR12MB8012.namprd12.prod.outlook.com (2603:10b6:a03:4c7::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7939.17; Mon, 9 Sep 2024 01:20:50 +0000
Received: from CY4PEPF0000E9D0.namprd03.prod.outlook.com
 (2603:10b6:4:ad:cafe::1e) by DM5PR07CA0071.outlook.office365.com
 (2603:10b6:4:ad::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.23 via Frontend
 Transport; Mon, 9 Sep 2024 01:20:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D0.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Mon, 9 Sep 2024 01:20:49 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 8 Sep
 2024 20:20:48 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 8 Sep
 2024 20:20:48 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Sun, 8 Sep 2024 20:20:47 -0500
From: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <Tim.Huang@amd.com>, "Jesse.zhang@amd.com" <jesse.zhang@amd.com>
Subject: [PATCH] drm/amdkfd: Fix resource leak in riu rsetore queue
Date: Mon, 9 Sep 2024 09:20:41 +0800
Message-ID: <20240909012041.1433796-1-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D0:EE_|SJ2PR12MB8012:EE_
X-MS-Office365-Filtering-Correlation-Id: fa7029a1-e6a9-427e-0184-08dcd06da3d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WgfqKuUa1g67VsCg4Rd46GUh8aqip+Rk1kJ4cFZtEGDH8MS9o6DIGKU/I+lG?=
 =?us-ascii?Q?Wwosw2vFzf3g3XkK+rplytnt+4z1GOkzqtDfWueh+MQhTOuycPjTV+wYTfTp?=
 =?us-ascii?Q?/8FiSagqSvdiTZfvyx1+Io843R/juCO2pKTo3IsdU/yoe7zxTgRhG0LMux3P?=
 =?us-ascii?Q?yVvPK0lVmWf7FjsK3hrReUm4k/3Z5D441dSHh+j16L1VeX1AQYog7iuLFnvf?=
 =?us-ascii?Q?q9G2fWvHlks77OiM9+p5R3iAovk8GJ2wYFUC7nSF32bbpti8HUDWPu2Hwrh9?=
 =?us-ascii?Q?XkE0xs2pD+Lz+yuuoUnA9Fs6o2FM6/Y4y/zspgVBg8xzj/+or+aEcbEvfLVP?=
 =?us-ascii?Q?a1QyHJTTjcmIos7N7T9LeIoW2GJXoDtD+rXjyesRHVumVjUcB0FuiYQ3jGot?=
 =?us-ascii?Q?J/R7f001AI9KWfZjAMengDRAie0lcec8Rac9dHKnfW5yTQrPpCvGYYMgwI/4?=
 =?us-ascii?Q?dvIJJ/Xxxc3zsCzC4PE/fp0YRO9Fzh2YzqscGyjR/xOqQJt5zvxRwJsc22Zs?=
 =?us-ascii?Q?P2sSy5se9uYWpXX8yQmPNQTte0CHE1gqMuIN/0Lnzfwv0KZb3F13i9ZxYGEp?=
 =?us-ascii?Q?uQ2VyfoFKbTcPx9OLqm9cUe+bXAiEQoPrXCbZ+6PrM5NC2lqn4ULKRMRcfMO?=
 =?us-ascii?Q?YAO7XTi1+AsQ7X0HwLfOWLwfXhS0pl09ja19MSyN4x377s1u3sUa7Ws9CjWi?=
 =?us-ascii?Q?x9f9CKA6cwCcfFJXeOCRNSh1YCUcVVBbpkPg/vV9Sg56NLXkKS0w9z9vBuDt?=
 =?us-ascii?Q?UyGe8H8QOtzP/ahTJb73ndGmJ23qCledWuA5oqSCLvzLAir8svUmPCQLqMqc?=
 =?us-ascii?Q?i12fr961T8W5c/qSDmLPmnzfLosTshNBNkB5Ch2BDosF3ULO3NzaUrG9KtFJ?=
 =?us-ascii?Q?vTXYFGDE/BXe2km8DQR+JkbMcXdeFZa3/wik2BOk9fDEz4kjsspIk18fEVPO?=
 =?us-ascii?Q?Wf5HHOVcOyodJGw+aT75QsjgsecCTpSp0CzXHE9pYmiz91kO8E5KMuOuz1SP?=
 =?us-ascii?Q?9Dq9nKe7BwYOLApBBDQ0LG258nzIdlbbRocyfsQgRhxTpXOY5KcOrabsDlvu?=
 =?us-ascii?Q?e6NDcKw5DhxW9+TzazbYAJR4RSRbXeSxlwtL1Y9bqbJcxJvXDJ3h0Vh0UjZI?=
 =?us-ascii?Q?DReJcX93d4t3Wwo6I3vsuw5vuVesgh6c0NVTDcpL7nZaKUI8n7zh6wBbw5r3?=
 =?us-ascii?Q?zGm0TE/h036gxkVcMPnKxVWtEtK4jB7XRLdNIZMHxHw7SPlzMtXgBXIJMMUr?=
 =?us-ascii?Q?xzARHoZXP3fxTkVitCBU/FWXy+lfQdALYP4+DejiDKncorFC97I+s8Ok9JVx?=
 =?us-ascii?Q?Fd5jTsjnJCEBHKvymcHg+NMCivb2WC8g8BdwNofWWgCdmTw7HqRDGN3GOgpQ?=
 =?us-ascii?Q?t+hHgLbhdpc1ZIxjXJAMHt/R5zA46dcVgFlRtTbVsKclnQsOCrVMhkt2f5SK?=
 =?us-ascii?Q?2njvSETvQwGbMdAxHw8wfnljF5J0uPgI?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2024 01:20:49.6420 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa7029a1-e6a9-427e-0184-08dcd06da3d3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8012
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

To avoid memory leaks, release q_extra_data when exiting the restore queue.
v2: Correct the proto (Alex)

Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index 20ea745729ee..b439d4d0bd84 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -1046,6 +1046,7 @@ int kfd_criu_restore_queue(struct kfd_process *p,
 		pr_debug("Queue id %d was restored successfully\n", queue_id);
 
 	kfree(q_data);
+	kfree(q_extra_data);
 
 	return ret;
 }
-- 
2.25.1

