Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEDC0CDB46E
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Oct 2023 19:13:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E06A10E549;
	Thu, 12 Oct 2023 19:13:06 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2073.outbound.protection.outlook.com [40.107.100.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F2F010E549
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Oct 2023 19:13:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NTdJJsxFJKb/QSBUnZhamFjGXflb/m2cB/QrY1DB6evqNGkdEq1i0cC07gHV60VKj3J75n2BF2xyAJGuutSUvB3qRXtARnox5gLMC9roQnooV+/idPqRBy1qLc4kv5Z6giwdOYqnXdpNPo3YB2dJy5M1Wh9eCWtr6lW0MzEpQdZeKLf0N5U+yss9HFqk1g9xsP9yPddu8/Vu1gJ/zO825j3xMFCcsXd7TRg+P4OA/74pPeSlHvjMJCLaVie2hfNT093jlnbjm/el9Db0AG8BegQTci/IA0oZ/gdjxPPkaOZZrHxE95BIsw+A9AWRu6vAMA3Ow6Onl7JAukQiqFtXIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wDTo4AjTz5zaNERrpxJZ5fj/C7/kdFiBa4hOaYKUTe8=;
 b=e/ksQ0dP8CvPHgdHzjd/KoIgQhRq+/b8dzOlj3lOXcuhTrTLjMKETnnqqrRft9fxPtsFVXykMpI3sNRCG2mHmXL8qskD4InQx2Kyt+eGThPxqWpZxUMy3BGJiMlQmof+DZxhemrlzYr5HTLoTofBMzP8+oivNGyWeFxEBkBlSdaf4TcqzcxexG6GbY+EQA3qRmky7rnDitgPXJ5w9DVFHnNAByJCQoOHQAFMkAiRb/OS+6VxzwQjzqF7wviWPyX6Xh6lZzR5TCttxSSjKPQ7Y7VRukrtFu3Txeq3BQRRtgzRkUBLfGhZGM0rqisKJ6pIY08CWQfXilcPpEIfJKN8iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wDTo4AjTz5zaNERrpxJZ5fj/C7/kdFiBa4hOaYKUTe8=;
 b=RXyU2GO3uITQkkgdWCxNhjllqPXMdeDQkKbs7Ue+wugU1kXXBCtlxoZ/vAyqKpANuglUyCijFCrjCX/AIt06hxrEyRmuB/vm6MPgqOlaa8R18ZZw6pBrp2NwlMtJWR7MSkz7xHmQU9pjkJdNgZ/9+rtHspl0O0w4G3i9GqTZ7bU=
Received: from CYZPR02CA0011.namprd02.prod.outlook.com (2603:10b6:930:a1::9)
 by PH7PR12MB7796.namprd12.prod.outlook.com (2603:10b6:510:275::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36; Thu, 12 Oct
 2023 19:13:02 +0000
Received: from CY4PEPF0000EE35.namprd05.prod.outlook.com
 (2603:10b6:930:a1:cafe::4b) by CYZPR02CA0011.outlook.office365.com
 (2603:10b6:930:a1::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.30 via Frontend
 Transport; Thu, 12 Oct 2023 19:13:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE35.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Thu, 12 Oct 2023 19:13:01 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 12 Oct
 2023 14:13:00 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu/pm: update SMU 13.0.0 PMFW version check
Date: Thu, 12 Oct 2023 15:12:47 -0400
Message-ID: <20231012191247.505567-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE35:EE_|PH7PR12MB7796:EE_
X-MS-Office365-Filtering-Correlation-Id: 020b31f9-e76c-4b5a-26bd-08dbcb574135
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0VIvQKzRTl1vKIJzIjk+kviXoCxc22sSF5fmk6QoNrNLtwqJshvRK+aPEEgA9gP6V68pk3l4RWZHrZFLbYuFVlCIODMJbRKYcj6+2EtDrdBi24+O5JBs4fydfAp6kX16w8yroZOVoW+wBKYEUnk704yE+GYIQPnFZ0HoHBp1DTT95EpxFBVJniQqQqNxFlUzDvQpi4A+WbHOcfmKzvsA62gkfd0l+5uMRuM9E2QYjewEk1BLA84o5fHxHR8Lld6OOWa0GjatWbHHorGZ+dSqs1AXGO3nn80nKOMyjdqMNYBuR4ifWfsmyewOgrcJ4cd86ON8g/TUmJLGTF5NuMtY2k1OcIAuoPrvrGKENTWkuDGAfuRIwfX1OQ0nrha8GDlSkBecVoe2YRVN1O6PKnPLRcX4V4knaUE8yYCMM255fbP+iLaRj/pER8kLc5w59qMO4GgoobiB4VA6407WgxLSUx41kMzxT4flU0+oVdQXJ9WM2FsACwZPOTWezkYVonq+Nru6fJAsUv6paHA/3eXxwbx3cHZAQKpAWjl1UZeBUMvHZ9hHuSFq3IzXP8nsz+OoECU6ZLkxKfaI2Qjn5IkBmqjonHcOX2wNwpREvJWI74S3HW44a24QC16NpGeGrNgtdat5IcVtgMbQMEne/lpMOrTwPNqGJXb9BKysLzGgXeO83btqPoY90EmVsGJVrHmbqPqcmmKrqqtbsRG6vUq2MlnF/5mQ3A/cWz8tbLjibxc3WkIp72zfUmZcsjtq0SdP6B71tFwWUQo2QDO5urqACg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(136003)(39860400002)(346002)(376002)(230922051799003)(82310400011)(186009)(451199024)(1800799009)(64100799003)(46966006)(36840700001)(40470700004)(40460700003)(26005)(2616005)(16526019)(1076003)(336012)(426003)(8676002)(6666004)(8936002)(83380400001)(5660300002)(478600001)(47076005)(15650500001)(2906002)(4326008)(41300700001)(70206006)(70586007)(6916009)(316002)(36756003)(86362001)(82740400003)(4744005)(81166007)(356005)(40480700001)(36860700001)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2023 19:13:01.8559 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 020b31f9-e76c-4b5a-26bd-08dbcb574135
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE35.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7796
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Update the PMFW version check the the ROCm optimizations.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index 56b11f6386df..cb7e1a22d7ef 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -2562,7 +2562,7 @@ static int smu_v13_0_0_set_power_profile_mode(struct smu_context *smu,
 	if (smu->power_profile_mode == PP_SMC_POWER_PROFILE_COMPUTE &&
 	    (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) == IP_VERSION(13, 0, 0)) &&
 	    ((smu->adev->pm.fw_version == 0x004e6601) ||
-	     (smu->adev->pm.fw_version >= 0x004e7300))) {
+	     (smu->adev->pm.fw_version >= 0x004e7400))) {
 		workload_type = smu_cmn_to_asic_specific_index(smu,
 							       CMN2ASIC_MAPPING_WORKLOAD,
 							       PP_SMC_POWER_PROFILE_POWERSAVING);
-- 
2.41.0

