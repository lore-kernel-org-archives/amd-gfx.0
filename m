Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C068C982F1
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Sep 2026 07:59:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 027BE10E5DD;
	Tue, 22 Sep 2026 07:59:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="og8OU919";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013033.outbound.protection.outlook.com
 [40.107.201.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D92410E42D
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Sep 2026 07:59:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AKMb1jKnBnW3uFhBQCs+tleiJNKShnz1Ef4uvy4uBPRwG1bxGkY/WrkLBWgGLLzCugfnv1XAw5s6xc/EgduDSbfTDs31Br3lGdyQ30lIndyW98EZ++nTdiKH66+OYhQvAbzRYCAn2ZZUwPfxnawv86GNVmK62m1ln5+vodG3SoO/rPOK8iXlPM7QI8H+uCuyNzxeoRFzNhvzfKb9JXaxc44gcgY1R8vjTK9aUSOcEra7qWoafwip0tovuEPhU6eqguikDIp0nxn9iWPMqzXKfoJ3CAHVx9ZF7Bq/7NFSQJYSwd6CV5SPuvALbcWOpaTe7MWWx+AWwHbnY4Pa8BbFPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sKuFKABGU8Qy6VIAVP56qeYu39oMN1NAHg3iE3+PI0k=;
 b=g+RPkHBMmeV7y42FMMfenrnzXOt2JOPWRb8W0H7Bn6+vjJs/3L7ySezQkC8mEHhXPif6cFJ1jw3+jxGYw96VK0kwaI9jA2F0d98ti3N/k4Tw1CYQuQw5ERF9xmT4Getc2EJAn2HSG2B/TkAie5QYSpv7Ic+Wgb+ul3DnYStxMYJEQVs1RRKCC48nyjMokVxX7Wb5xQsK/So+MqUWgFOXw6XBNGwf5xiN5H362tH+aK+gZtHkxQrgAdKTjvvWt3RZExFzZH5abZh7bZp8lmtV39SWWqNlGFvEjg/heUIKaEnNnqq+P+ckvuIrJ7csWrjV7sciZBAeNdK8s81zdOE8lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sKuFKABGU8Qy6VIAVP56qeYu39oMN1NAHg3iE3+PI0k=;
 b=og8OU919JTeP4MxyA/v8RC/Yq6oQG/bdjCRXT+6LelgiqgVQB5h6b8+21JNmvTgNsOERAyMqRa1PCg6C95ynQPLhCltnmLS/k6QlqAwnOlWZ9h7meMDfo6jgoqBE2bpdnMamurwz0uweJDD3zabFUV4aU2J+vYr3a/B5/1Bdrxw=
Received: from PH8PR15CA0020.namprd15.prod.outlook.com (2603:10b6:510:2d2::20)
 by CH9PR12MB962943.namprd12.prod.outlook.com (2603:10b6:610:310::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.13; Tue, 22 Sep
 2026 07:59:10 +0000
Received: from SJ1PEPF000037B8.namprd05.prod.outlook.com
 (2603:10b6:510:2d2:cafe::25) by PH8PR15CA0020.outlook.office365.com
 (2603:10b6:510:2d2::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.14 via Frontend Transport; Tue,
 22 Sep 2026 07:59:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000037B8.mail.protection.outlook.com (10.167.244.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Tue, 22 Sep 2026 07:59:09 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 22 Sep
 2026 02:59:07 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Pierre-eric.Pelloux-prayer@amd.com>, Prike Liang <Prike.Liang@amd.com>
Subject: [PATCH v3 4/5] drm/amdgpu: extend UAPI for reporting userq invalid VA
Date: Tue, 22 Sep 2026 15:58:51 +0800
Message-ID: <20260922075852.2335748-4-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260922075852.2335748-1-Prike.Liang@amd.com>
References: <20260922075852.2335748-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037B8:EE_|CH9PR12MB962943:EE_
X-MS-Office365-Filtering-Correlation-Id: eda76d4b-d8da-4933-8a93-08df187f624f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|36860700016|1800799024|82310400026|56012099006|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: zIwrsJUVD+snWxT/Anhh6DnJkvK9EqU34YiVbE1F+TTLT4syQrTXfQadk2JO9TtAk2kDz5yTPSJYiWI0wty5qBNT/mEZfOOEpuEcZYLoZw19nh2h5ArY1fYDOVZUX2MUmJUNDGrtHdi3kBp5DO+pqF3pr3BY/zLWIMeGgJRnmb3+luppSZflpaO5OCbafDqSQnWaH4YE6fPoYg5LD3lZ1jfpXLRJv5Uzxu6iVLfdkzHFgW6s61jseMZGwLBOmZDt7q1PfW31o1+98lJIZlGSf0caPsK9og5hyamxsQhZVtz6ENkarSHmn9MvWWT9MgBu1QuLAiy2stJHD7QtwrW9RLDTwdxIiNBEz4AU5E9DeM78M2Bg/Z4xpkTQpr7f684eyhKNPeJ8SUmvfzr5spFrq4I+KGtTESGO95LpZNiYTWJ/O4p/A5aM8OJut8rNAdyuhn32tkaaBKdFORqw/XxpCLpRP54ITumc6231FtuFopYPz598pQbV0PccynARBsyJ4VheAMf1TlkeUtJXMAMemOEBzs/NQxw7GsU9KatBfGwZJ6teF+lDS7bSJGHoOoiqSK8PFe0ct5HYOxuyePQD4NR3HdlvecDCnd7FIFC/k7fF95G9PDNMDd7xirpNSUVNoXQxFDgoSzwLxw9tTkeDVNg61kyclgwj/VpYJzR5MAn1+Jr4ANNTFrXefrELDnSuUd0E9/SA935KA5Hki0Yr1g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(36860700016)(1800799024)(82310400026)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: MwgigekoX0tOL6edU23p5XUpgbz9STYkNdoIZj/fP1H9q521r9tRF/fBCXyAKGLxPz+MrlqwKC88Pj708GcjcoWlh8KNkTlx5FxnKI9WH5TGndpFjxdnpaQ2dm9fvvDy0RvHtVjln6uith8Y5Sr89YMGjnZ4EpjOi5kP0Cgto/NX4LcuyR+2NjeLP2xM7LzyXmkllITC5gmfxNtTbI9n9noEVzrHxpA9G24Xsn9ahB5h5WuPxx3kqkdoM9BYtRJiFRq5WjCbT8WhAskmEAIhIjAzayieou9gvwTc6dLB0T0N6dX/SgOckrDMvk3jjgv7To1ZY+/PPphUeMtq5LqTohJTniWTEX5Xycq7Bn0Z0cWIpefZ4Sg0+997INtKb7PQBHtF5FrDLctGBdAMWsevoKWngeuDRJ78kKi5ufOEzn4OSnjzLsMkPHMQv1ICcafv
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 07:59:09.7922 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eda76d4b-d8da-4933-8a93-08df187f624f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000037B8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH9PR12MB962943
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

Add UAPI new definition for reporting userq invalid
virtual address status to user space.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index b3287368e577..4ddd22af63c5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -835,6 +835,8 @@ amdgpu_userq_query_status(struct drm_file *filp, union drm_amdgpu_userq *args)
 		args->out_qs.flags |= AMDGPU_USERQ_QUERY_STATUS_FLAGS_HUNG;
 	if (queue->generation != amdgpu_vm_generation(adev, &fpriv->vm))
 		args->out_qs.flags |= AMDGPU_USERQ_QUERY_STATUS_FLAGS_VRAMLOST;
+	if (queue->state == AMDGPU_USERQ_STATE_INVALID_VA)
+		args->out_qs.flags |= AMDGPU_USERQ_QUERY_STATUS_FLAGS_INVALID_VA;
 	amdgpu_userq_put(queue);
 	mutex_unlock(&uq_mgr->userq_mutex);
 
-- 
2.34.1

