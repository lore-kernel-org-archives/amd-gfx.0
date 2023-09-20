Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E253CE79AD
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Sep 2023 06:16:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CCA0D10E445;
	Wed, 20 Sep 2023 06:16:51 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2089.outbound.protection.outlook.com [40.107.237.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1DAD910E446
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Sep 2023 06:16:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LuxiHZxPwj0QBCcIqYJGHEIjFoXGNbgiINsIVEakTNiiX91lcykrVVD/nFwEgB/bTlGtzCXoeVV4DlxsIR8/otcZ/NB+6QZy9vUECxV0nQ6jV16ez9wfk4ka9uTM9FQ6deDGAEkWoER9damwPL9ASgLkgWs/NPsByS/Wm4Yco8HNS9SYb7uS7iSVIOV6PN9RpxQ38raXLjs2dASL6DeaNEv79Xgof1DXjiyQTdQKQoSu5Z9L/lwpaJt2uvvXqT0xFjMpIrCjhz7Ub3nA1ue9qe2d922oN45SsaRwwfs7455LfVCkWVY0uEwGRXfunX4gj1SqtfK5SdaAJaZKXmd3YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eG3LzGx0EnAWtMTZsE9Ad9qXQLefHnZDw+Ofekvzg5M=;
 b=R+f5YpjlSYb73S4yrMpQLaKGgJ81TOmEaMeeDX+F0OTubl1vUE0ujJgk82XY5DhTkzeORJrKyp+ucH84VYreNzp7OdvoDf9KStV3NNAyKUV8sgiOafEFbC8eOKE9VfGos+rSWzowU8QzASSiKtCw7Ac7SJQtPSBKR20Xy9HtkoGv/eIFVy0+9aJbu8tfdjs92Mdo+L0iGgTM60X60M2K2JGUEs97oqe+trUra0zMDxWO21HXhqfAL3CSNSoH+7pOXGa30kfQj6MRC1vu84A2Y5gUkgX9XudG6zIkd3SGkk5WUMIsVD0wtAMgQtAazMHd/ABhRR1b+oGvcozeHBqipw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eG3LzGx0EnAWtMTZsE9Ad9qXQLefHnZDw+Ofekvzg5M=;
 b=J1FyHviRyiDJfzSfkjvgSgasraIUpn8PsuaKHKholkXmw875XSGtTOpXz97zTu9Fu80j4GRGk02TQexmAAi9nuzdZRFqstlAjAf6x+IXPlne9ZZChIyOeBn2w/Ll+OqEOuvqNjUqbNJMRKOnx4GLoDAKUhQMLMTqybJ+kHyvFxo=
Received: from CY5PR15CA0148.namprd15.prod.outlook.com (2603:10b6:930:67::17)
 by DS0PR12MB7533.namprd12.prod.outlook.com (2603:10b6:8:132::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.19; Wed, 20 Sep
 2023 06:16:45 +0000
Received: from CY4PEPF0000E9DB.namprd05.prod.outlook.com
 (2603:10b6:930:67:cafe::fe) by CY5PR15CA0148.outlook.office365.com
 (2603:10b6:930:67::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.30 via Frontend
 Transport; Wed, 20 Sep 2023 06:16:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000E9DB.mail.protection.outlook.com (10.167.241.81) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Wed, 20 Sep 2023 06:16:44 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 20 Sep
 2023 01:16:44 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 19 Sep
 2023 23:16:44 -0700
Received: from Xiaogang-ROCM-Dev.attlocal.net (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27
 via Frontend Transport; Wed, 20 Sep 2023 01:16:38 -0500
From: Xiaogang.Chen <xiaogang.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: fix some race conditions in vram buffer
 alloc/free of svm code
Date: Wed, 20 Sep 2023 01:17:41 -0500
Message-ID: <20230920061741.41382-1-xiaogang.chen@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DB:EE_|DS0PR12MB7533:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c29e4db-2600-4e40-4e1c-08dbb9a12a15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5LAnRUQc1TBJjiZ9UMzQiV9QW5NspCkbhQuCDH0hiBVxwXfSs09ZQWS0RPtkuq1DpDlWw0FjNqdTVo52Ukxx9N1eJZ+jU5oQU9nhwWhFVdZ7oXyDWZx838f2vuzxkEB+jiOXYfqzIJBpZvAFmYI3dAXKWHdrKpLfWMgOEGIdYPTHIZklMdGU68AujhquaGX6Wc6CmTUdHcLweOZCHYy73/6jayjaIj0FXKHBfTuWkmzyZ1WZCNW84DCUQ3WXgSBYFZaHrE8ZUljh7XoLZr1iFIQ1CKFo1EhAosRMoG1LebE/Xsx8vk1k4S7vnzguTgSVHwIAJ81KggHApxw8BXXeh/Kyzlrp6GLwlssEO+2g9tdGIBu/MuAhkO0OdlJCq5S+zaafSWrO6CXkVwm+ZktfWLye7ZJFn7c90sQUyrqc8U2C6ZQOw6cStOkgqm94Hw+Upp+ctEnMglva93WRMpRmes3BEF9jxhgiCIdGpDPHLOza2d1Jgj8ylQgSrHXtWx/K8vavD7Q6gP5vkSs7UDSTOzOP2SjNh7QPuaodavjTROy0X9tuQaw/XwU/2Lr2Ovt03BNmDlU+7/l7zVn6W0Vl6g+5BpAJkXJVGHYoJxOdCKIqNSavaIiqm3i0CZx+R6NR6CQPs5TfbvbwWb6mNMvbM/1JfIAqvViOAfYDKWF4rBQGskh77/VQPo99Igd5f3JHSmD0OuXxZGLlDhMmhoRyouupQ9fMdB2EV2GkeCGke4fmDMwbf3nUWeRkBxZltRYm5hUtdEZWQBe6JIHNP21pIg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(396003)(136003)(39860400002)(346002)(451199024)(186009)(1800799009)(82310400011)(46966006)(36840700001)(40470700004)(2906002)(5660300002)(1076003)(26005)(40480700001)(336012)(426003)(70206006)(70586007)(54906003)(41300700001)(316002)(6916009)(8936002)(4326008)(8676002)(478600001)(6666004)(40460700003)(36756003)(2616005)(36860700001)(47076005)(356005)(81166007)(86362001)(82740400003)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2023 06:16:44.8875 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c29e4db-2600-4e40-4e1c-08dbb9a12a15
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9DB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7533
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
Cc: "Xiaogang . Chen" <Xiaogang.Chen@amd.com>, Philip.Yang@amd.com,
 felix.kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Xiaogang Chen <xiaogang.chen@amd.com>

This patch fixes:
1: ref number of prange's svm_bo got decreased by an async call from hmm. When
wait svm_bo of prange got released we shoul also wait prang->svm_bo become NULL,
otherwise prange->svm_bo may be set to null after allocate new vram buffer.

2: During waiting svm_bo of prange got released in a while loop should schedule
current task to give other tasks oppotunity to run, specially the the workque
task that handles svm_bo ref release, otherwise we may enter to softlock.

Signed-off-by: Xiaogang.Chen <Xiaogang.Chen@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index bed0f8bf83c7..1074a4aedf57 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -502,11 +502,11 @@ svm_range_validate_svm_bo(struct kfd_node *node, struct svm_range *prange)
 
 	/* We need a new svm_bo. Spin-loop to wait for concurrent
 	 * svm_range_bo_release to finish removing this range from
-	 * its range list. After this, it is safe to reuse the
-	 * svm_bo pointer and svm_bo_list head.
+	 * its range list and set prange->svm_bo to null. After this,
+	 * it is safe to reuse the svm_bo pointer and svm_bo_list head.
 	 */
-	while (!list_empty_careful(&prange->svm_bo_list))
-		;
+	while (!list_empty_careful(&prange->svm_bo_list) || prange->svm_bo)
+		schedule();
 
 	return false;
 }
-- 
2.25.1

