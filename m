Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CCBBC4829C
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Feb 2024 20:07:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC84C112DCB;
	Tue,  6 Feb 2024 20:07:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TDWVRqPb";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2060.outbound.protection.outlook.com [40.107.93.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F1EFC112DC9
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Feb 2024 20:07:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YcQrfgt84MGNEPypmXxGTut3W5F0njFaEpm+W14NkM+LQlligOE6lTNlh5vFjxkmr8gXBTe37RwB5bPGGYmmOAAouUvv3+Hn47OjRLyOH7ZpGGnKBtP2PsMwMDwsU5cboPkuEO4SvLQWCYtqZt4IiI6jQd2RgyPR/0QWuJDzDYR7qEUJZ/nhz1zm6HE9KNpXV1XSD6Bvo7Dj1z2m9x7eZz/Huz+aGBdVxi1hXy24BmBn15pod93f2x8jwwMDl1mR/7hV14W4rDK39qJnBXALClx/LvAGuRMGUDBoy9w5qVZUBMLSNlbRDC7qvodG4quJqs4ZkmHZhCJxAHh/h/Uk4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ncJbbcBysQbPhl0Be1Rzl09sa20If5kaUJdj54KbIZc=;
 b=ZL/v1cWL89EAfCIk848qnMWn1iFiaFCqY7kipzuMg9xfF98Ry+rV6AVDVMcJcUXxri/eJFLKZlTXfF2mN6uoo4ss3va8mf21tJcMx6PhII4ynCuWpRhCrqoanWUHZ96Icyp9jCn0JCUywXG2z4UQyP8nAmx0ADhc/gLNTupZUMAaYb+fougY5c/FI0tti89YjRQt702F6OSW0bleqRc+PUyTt+G4BkYBsHpuWUsOaS2n9S4/ezaft76a8QC01Ms1q6jUCxk+vCm3oaKBlv+GwwhxtM3aURgHPrp5EbF8xU56knOAl0vAgIlkiQYNa5sR5kA9NjxXOogA4kUbXQOJVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ncJbbcBysQbPhl0Be1Rzl09sa20If5kaUJdj54KbIZc=;
 b=TDWVRqPbGyZpC0rVGPiLYDDUvN8pemc+aOjhVeSIKZPMRf0nSNGuzEB9P81U7m863gUQO81w/etWvoMMs3BI+eA5/uQCmMasu0yUfQmh5FhcPxswuDOElZm4zI16qcVhalbY1tjLIYg1kmy4UKZ2ZJsLpTTPGE4H0P99Rm2/fD8=
Received: from SN7PR04CA0196.namprd04.prod.outlook.com (2603:10b6:806:126::21)
 by SJ0PR12MB7083.namprd12.prod.outlook.com (2603:10b6:a03:4ae::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.14; Tue, 6 Feb
 2024 20:06:55 +0000
Received: from SA2PEPF0000150B.namprd04.prod.outlook.com
 (2603:10b6:806:126:cafe::9b) by SN7PR04CA0196.outlook.office365.com
 (2603:10b6:806:126::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36 via Frontend
 Transport; Tue, 6 Feb 2024 20:06:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF0000150B.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Tue, 6 Feb 2024 20:06:54 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 6 Feb
 2024 14:06:53 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Jonathan Kim <jonathan.kim@amd.com>, Jonathan Kim <Jonathan.Kim@amd.com>, 
 Felix Kuehling <Felix.Kuehling@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdkfd: fill in data for control stack header for gfx10
Date: Tue, 6 Feb 2024 15:06:36 -0500
Message-ID: <20240206200639.1670753-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF0000150B:EE_|SJ0PR12MB7083:EE_
X-MS-Office365-Filtering-Correlation-Id: c1b40f8d-d6ef-485b-3609-08dc274f2a85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aCCEN+6MtlqdYvNtCYoRuuO176LH9DmFJBAnG8/5ejduSqramOy1jfsGPUl6W+J9lsVXHgs7rX144FXJ7zXTgmj85je6YM1+fEgIunz0bBOiu3MBoxfegpFkdgzJXJVTBxc0dKF86OlT91WuXqSIezP74PJWtH4FThVmH8UOCPAoTkOXyzet6+5LM2sujXqpeyi1gOtvL9ttkwh5Ao9u6Pqvs/v/yf9jrinhJGBsYYo1D79l6wWZZF8yAvumb1KNmJG7rASFB49C+gp4jL6A3K8pfmKOWL5iSpxKV/EepO9wZTSuLMm/K6L6t3+OG7SIKHzsOl9/6Ie6A/2f/yateb0LGVGmTPqs6E0LA8Dol0ATAQ6iJvP/6/JEoghwx7Wfxvuo/WBMUr/s2QFoV5DgWfRd0P8RpcbEh59limfTpXszxbBReLaQ1gCnh2dLs5I+De6CyRBAwJKq8JHsu8xE5UeNYLeTsS5CP8B8iabT8BfmdKNcr50Y+6DdrJXL6rqlS4i9snFduiehWpAan3oPenwEsKOSjYXNTwBjxiRz09mzXioYQFtGlfyOipvx9UDg+Y4UcEOm2PXGSNYuIXD6QunKEg1Avp0ftXCjfg1QcN/zNeiISQG+18rs8amJeiveORdoU1tmInXhytfW27N+BtFJmCSUPOgRgoWJcRgi6Rl95qKI74C5Yau4Xy06/YLwwl/qxNgCVe/O68XwqH/1VfWEOVZeNx8wzAgX+MKTCQXWfd/WXxozbgCbLaHa2urpkj0drAyjlUWEM5WFDBtpDg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(39860400002)(346002)(376002)(136003)(230922051799003)(451199024)(64100799003)(82310400011)(186009)(1800799012)(40470700004)(36840700001)(46966006)(36756003)(40480700001)(40460700003)(478600001)(86362001)(426003)(1076003)(336012)(356005)(36860700001)(47076005)(82740400003)(41300700001)(70586007)(16526019)(83380400001)(2616005)(5660300002)(8676002)(6916009)(2906002)(8936002)(6666004)(70206006)(4326008)(54906003)(81166007)(316002)(26005)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2024 20:06:54.8259 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1b40f8d-d6ef-485b-3609-08dc274f2a85
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF0000150B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7083
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

From: Jonathan Kim <jonathan.kim@amd.com>

The debugger requires the control stack header to be filled in to
update_waves.

Signed-off-by: Jonathan Kim <Jonathan.Kim@amd.com>
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h | 25 ++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h
index 57bf5e513f4d..e5cc697a3ca8 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h
@@ -128,6 +128,31 @@ struct mqd_manager {
 	uint32_t mqd_size;
 };
 
+struct mqd_user_context_save_area_header {
+	/* Byte offset from start of user context
+	 * save area to the last saved top (lowest
+	 * address) of control stack data. Must be
+	 * 4 byte aligned.
+	 */
+	uint32_t control_stack_offset;
+
+	/* Byte size of the last saved control stack
+	 * data. Must be 4 byte aligned.
+	 */
+	uint32_t control_stack_size;
+
+	/* Byte offset from start of user context save
+	 * area to the last saved base (lowest address)
+	 * of wave state data. Must be 4 byte aligned.
+	 */
+	uint32_t wave_state_offset;
+
+	/* Byte size of the last saved wave state data.
+	 * Must be 4 byte aligned.
+	 */
+	uint32_t wave_state_size;
+};
+
 struct kfd_mem_obj *allocate_hiq_mqd(struct kfd_node *dev,
 				struct queue_properties *q);
 
-- 
2.42.0

