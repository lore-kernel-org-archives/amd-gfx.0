Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 706B3EE49A6
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Aug 2023 21:30:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D51E110E18B;
	Fri, 25 Aug 2023 21:30:53 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::600])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E17310E18B
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Aug 2023 21:30:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CwH/zTsrW/UihjjHI/bMD+aaOEZWkfsxebkXxXzrGJcZyVK26xT8aHz2go6Cp59yCvWGa/0xSoz4cbzzH7L3FcaJboKQWnKpk9pzGHNXhajUqstfeDMwg3hOC1K5Mqs24aeMfCoCZA7BtalJwqNt0XhATfsItmjiBDYJrnanBy1zT+SNFM1Q3GSIJj/LzAFfX/lXAjnbNlGbXwWMHFR0xBVNBBsLuVAS6+t5E/x5VNL3gl/wGKTwba/W6LHaEzLhx0YyRdaXl+Y7pjQGKZ1r5Wb+e7h2QXBduXcnQhz2ND3qWoD3BCer3ZhCDfCjGoibbWvtvvwKxXEH4fKljGHmhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RbljWhErr5BNE55+Bie4GQpn8jRdheTgbStm3QIK4RA=;
 b=XHHgNCqOJplJAIioDUkImid9W1NliNo4shkg+TWLPmA/yqZEiMT6U1+rPgsSowXeJCKnewpwnJn59AUTwQlv+Mu61pXViGnVZ+8v+Rao4pwgWyNQsZsifWZbZ534nJvGraHO9cfT3sorO316QIn9RRxQGMDX+EBucDMZCtTTUoicTcmLj9ko3f0FgyEoX2MjXNj+S7MrdY85AAPNikuc9nWmXqWyf/EmVh/Y5BSgzv4FZiuuuKKVPYNZ5BYeTNHn2+/2d5mr7KXo+oAd1ACSHhlwoCpWqO8SlCRM4HE2NmL16PssHSVGOT0iABEG9RYVVEcLSixJSbWo7RR+5jK+iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RbljWhErr5BNE55+Bie4GQpn8jRdheTgbStm3QIK4RA=;
 b=vrqOCE3SR7KnSYKmDQPSPVU4WRe5gbDbYUTqlV8DfOH96q6DpUtAMBGAykEGgnAIBDuY/HGByV1aJbBDqWTWv3Ubn2rTbpjOBQmTg80dkS1V3Yuwfymk1ApGL61y9F9G2kp0buxhiv6xjZpkd3pPyRwf9UlPTSFG/u23Hp8jyZg=
Received: from CY5P221CA0138.NAMP221.PROD.OUTLOOK.COM (2603:10b6:930:1f::29)
 by IA1PR12MB6114.namprd12.prod.outlook.com (2603:10b6:208:3ea::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Fri, 25 Aug
 2023 21:30:46 +0000
Received: from CY4PEPF0000E9D9.namprd05.prod.outlook.com
 (2603:10b6:930:1f:cafe::db) by CY5P221CA0138.outlook.office365.com
 (2603:10b6:930:1f::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27 via Frontend
 Transport; Fri, 25 Aug 2023 21:30:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D9.mail.protection.outlook.com (10.167.241.77) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Fri, 25 Aug 2023 21:30:46 +0000
Received: from harish-base-compute.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 25 Aug 2023 16:30:45 -0500
From: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: Add missing gfx11 MQD manager callbacks
Date: Fri, 25 Aug 2023 17:30:29 -0400
Message-ID: <20230825213029.194197-1-Harish.Kasiviswanathan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D9:EE_|IA1PR12MB6114:EE_
X-MS-Office365-Filtering-Correlation-Id: 5dbb8bb4-4769-44e7-d32b-08dba5b28b45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8IQZGAr4k2MB7gThA+/DLaKGlzdvPCeGAusFWSSw7DP9WxkuUcYXTAaSWHx5H+mSDQgWhY+frFCzJ7e/uDKalBq+JWNm69EQ1VDly1ag4/3bPAo1/QdTnO3nooqnCGhiFcpqrQSq7HRMNdNUFBnQ1GQ9MpLh9vWN/MhDYSQ/0EpKZ4rM5EPWVH/ndxEMYLcB4wmCfLlcoQAGI+ydYUNVRoKCRqng56Zn8BzsS7lUFx2yzqmDX+h1Vx7dyNAdX3udmoWcJZAl7yNvT1HHooat3FXkT2AqqmZD+b9zbVCltKXxpNL3A0+Qof8T+0Mk21/Kw79bnXGg/ClUex32ikXwAN/r5Q6KLy07f+fDnzagzKkx3X0ZxRod4Yi2+rz+eo76H9oSABbH0cKbIcxDGPaqwzZys17goYHNLgTeiPpCd7PN7lRYumVFJ3bdA6/fIzUp8Qu11wIWNdMYrE8fCVSRh+xCbAdMncgCbd7Tqvr79EVmooJuEKiX8aTveu7MChjZc2jyRkf1yckdFknYGX2ZVJgXOkV//irrRoUwT4bLuaDzLjWLyYlmhP61yCU7V2bNn+UPi3HdD+t8N6VB27MmRkfSgVwgRVo9B4H4mZtEtj6lG+BUGSVqr/v8Mc3ZJaC7makV9RnOGge206+Zi+/YnWIpC46FTRVbDNw5xTcwCJVfZQvBkHEZ9VOH5T97gkrc3zeCUTWIfTTCD/5tF/rMtNVYwNSke0j2VBKQKbV9oy1c5gDA1nTE7sAZKk5WJiMz3/+Fpps+KqJDXVdsMXTF2A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(346002)(39860400002)(376002)(396003)(451199024)(186009)(1800799009)(82310400011)(46966006)(40470700004)(36840700001)(54906003)(7696005)(70586007)(6916009)(316002)(70206006)(81166007)(478600001)(26005)(36860700001)(356005)(6666004)(16526019)(40480700001)(82740400003)(41300700001)(86362001)(2906002)(8676002)(8936002)(4326008)(1076003)(40460700003)(2616005)(5660300002)(83380400001)(36756003)(336012)(426003)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2023 21:30:46.1334 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dbb8bb4-4769-44e7-d32b-08dba5b28b45
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6114
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
Cc: Jay Cornwall <jay.cornwall@amd.com>,
 Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jay Cornwall <jay.cornwall@amd.com>

mqd_stride function was introduced in commit 129c7b6a0217
("drm/amdkfd: Update MQD management on multi XCC setup")
but not assigned for gfx11. Fixes a NULL dereference in debugfs.

Signed-off-by: Jay Cornwall <jay.cornwall@amd.com>
Signed-off-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
index 2319467d2d95..0bbf0edbabd4 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
@@ -457,6 +457,7 @@ struct mqd_manager *mqd_manager_init_v11(enum KFD_MQD_TYPE type,
 		mqd->is_occupied = kfd_is_occupied_cp;
 		mqd->mqd_size = sizeof(struct v11_compute_mqd);
 		mqd->get_wave_state = get_wave_state;
+		mqd->mqd_stride = kfd_mqd_stride;
 #if defined(CONFIG_DEBUG_FS)
 		mqd->debugfs_show_mqd = debugfs_show_mqd;
 #endif
@@ -472,6 +473,7 @@ struct mqd_manager *mqd_manager_init_v11(enum KFD_MQD_TYPE type,
 		mqd->destroy_mqd = destroy_hiq_mqd;
 		mqd->is_occupied = kfd_is_occupied_cp;
 		mqd->mqd_size = sizeof(struct v11_compute_mqd);
+		mqd->mqd_stride = kfd_mqd_stride;
 #if defined(CONFIG_DEBUG_FS)
 		mqd->debugfs_show_mqd = debugfs_show_mqd;
 #endif
@@ -501,6 +503,7 @@ struct mqd_manager *mqd_manager_init_v11(enum KFD_MQD_TYPE type,
 		mqd->destroy_mqd = kfd_destroy_mqd_sdma;
 		mqd->is_occupied = kfd_is_occupied_sdma;
 		mqd->mqd_size = sizeof(struct v11_sdma_mqd);
+		mqd->mqd_stride = kfd_mqd_stride;
 #if defined(CONFIG_DEBUG_FS)
 		mqd->debugfs_show_mqd = debugfs_show_mqd_sdma;
 #endif
-- 
2.34.1

