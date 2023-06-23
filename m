Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2959C0015E
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Jun 2023 19:41:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E87EF10E69F;
	Fri, 23 Jun 2023 19:41:10 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2087.outbound.protection.outlook.com [40.107.93.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D8E9910E02A
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Jun 2023 19:41:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C26nFrc5a08ffz9KXmZjhoBm2lgfciOR3KMEFVIQBDmLSTz2kZDwL+FmDQCc3YXsgzmT00nTqcHuTsRacOLQh65V0u/VC27nLKRoIYH5nJfhunrNUS4g651rsxvPTX9GgQajGOhzW8z+AktiahG+jzn7TNCUthxM8AWn88FouuoTfnhnBQZT1P7326af/Sx5KXg3hOyuB0fJn7R+8VCyt7MT/4s2EdAavAj5u+80XAsnYW0GB3GTsiuY5t2CoT7wbcT2dZ6CrG+opmoYeD7XTOkpREKDuKWIkMMKZqa8RrtcMRYQ6Sjy73oQxPwmwbKB7mVZW0XxfwT+1akfRXPctg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cfy8Ciw++JUXR9r1ag8l1vIBsxuCyAOfE0c/i2rq2Kw=;
 b=H8tp+RvDf58R3/zRVZj3Aa6zOX6xCZmJp/BwDQqJua5h2cFT2T1tm+w4L6WzgNDkmbs7Axnw8rjOygTt3UawNwapPQAc9gnlPiOYV960JgIKaBGiYdO+5/tRsv2YIBg7YHy0eNck8KH8LN79q42RZNwomDk0SKXRxlSHscQ6OR9XvDDSVjkJz0vy4iDsRgVtHp6gUGwVQZ+llfqeZhxwtsH/iijPXJvezULUMrvfbHe12h8TW0qaju7Ex4rVPKQ4vAuZ421UFmhWmrxuuVCUEt7RbmqK7FYF0gsCp9xCzIFVfVUOLc2+tJfZ7B00js681fO6a1W/dC3zntWfljIjgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cfy8Ciw++JUXR9r1ag8l1vIBsxuCyAOfE0c/i2rq2Kw=;
 b=P1FXtaSkNiW3T1D5nP0fiorV7WvXKOGOtrhQbCZ9ubl+Uk9sxNtbASmoBPpcTwNB31TkVadqg4qGZpfpcjip0HRVGl/16aAq/cncqHCXSzwAI868jZ7HJELA7ICE83bysRPJQgcpuN3x3oQXvprhfAdGCiBVKyvIZrJfEP1NUNc=
Received: from SA0PR12CA0007.namprd12.prod.outlook.com (2603:10b6:806:6f::12)
 by IA0PR12MB9046.namprd12.prod.outlook.com (2603:10b6:208:405::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Fri, 23 Jun
 2023 19:41:05 +0000
Received: from SN1PEPF0002636E.namprd02.prod.outlook.com
 (2603:10b6:806:6f:cafe::19) by SA0PR12CA0007.outlook.office365.com
 (2603:10b6:806:6f::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26 via Frontend
 Transport; Fri, 23 Jun 2023 19:41:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636E.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6544.11 via Frontend Transport; Fri, 23 Jun 2023 19:41:05 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 23 Jun
 2023 14:41:04 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 4/4] Revert "drm/amd: Disable PSR-SU on Parade 0803 TCON"
Date: Fri, 23 Jun 2023 10:05:22 -0500
Message-ID: <20230623150522.32494-5-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230623150522.32494-1-mario.limonciello@amd.com>
References: <20230623150522.32494-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636E:EE_|IA0PR12MB9046:EE_
X-MS-Office365-Filtering-Correlation-Id: 54bf695a-7675-44bc-dd4c-08db7421c8c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Lft9mdRGRFedFnFB5UbM8fkWB/61RE9ZUWIRT6RJnqJGYY2LeNkhqNJt5/hK6SXQo0FBdQHDgx10eH49BbLQJs6Ku41liXVQFV5VcTa4xrBTQBpwcc8H67kaEVv9hHTVZ4SzmE8ONafaHB76gXfNzfzkk8FuEQ7emgPg67fjbIeY2R5hNLa2p5pwi9c7f+xBOEucCyOS8Oyq9UX/nwWlSCNpf14LJj19fH7T56tFFBzCy3tXTXRikcrIJvsz10XcWkml1wCJgVM1XQWcmtF/Ef6FfFcyg+nW0YO+t5DEW8DV7DQS2NILKQhcXp+vhLR0QcJSlZSO+Hq8NGSTdEopTAXP+Mv8buvnoJG7YVdo/L8NO5bHmXxGYssMFoWssWmMJtvUlzWNwWouqssTH66oK1ia7TqP3YKNHmf8mJAcKbdJOy4wscdDOasNwhB7L6MGAXfsLg0BT+zM+/ySdQWihs6ZU/NTN2sleoWRwdkKqK4tPV2B4HzhG7tp+ue7zFYUUkMAdawV0rkTNXbQY+RaFbP0gWUP1ixfRKLaj9D51hoeV3VTk50Z4RWVn75XWM0upIRLo/XKdIiVx/x6D3bsg6Hh7kBp0/2PNcMB8UMUpr5Rgw15VcSqwwxIPDoRneHmaV+lYk3w8mPDf1NVBfGc3+8hgeNEMZ3lfHOnH8bawyo8gKELRUnPjhHaX0blYZ9GjFoYDZxO9yG7SEVhoSYAUTQsul3YiLwUdDk19Xrzh/qGuVMUBusMqYEdJG7OeqILtU6ONZmD6ebwVCqDugp5VQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(39860400002)(346002)(376002)(396003)(451199021)(36840700001)(40470700004)(46966006)(86362001)(2616005)(54906003)(16526019)(40480700001)(478600001)(6666004)(7696005)(186003)(41300700001)(4326008)(316002)(82310400005)(47076005)(26005)(83380400001)(6916009)(336012)(426003)(1076003)(70206006)(70586007)(8936002)(8676002)(44832011)(5660300002)(36756003)(40460700003)(36860700001)(2906002)(82740400003)(356005)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2023 19:41:05.3676 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54bf695a-7675-44bc-dd4c-08db7421c8c4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB9046
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
Cc: Leo Li <sunpeng.li@amd.com>, Sean Wang <sean.ns.wang@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>, Marc Rossi <Marc.Rossi@amd.com>,
 Tsung-hua Lin <Tsung-hua.Lin@amd.com>, Hamza Mahfooz <Hamza.Mahfooz@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This reverts commit 33eec907ce0eb50a56dca621aa7310f7fa904b93.
This is no longer necessary when using newer DMUB F/W.

Cc: Sean Wang <sean.ns.wang@amd.com>
Cc: Marc Rossi <Marc.Rossi@amd.com>
Cc: Hamza Mahfooz <Hamza.Mahfooz@amd.com>
Cc: Tsung-hua (Ryan) Lin <Tsung-hua.Lin@amd.com>
Reviewed-by: Leo Li <sunpeng.li@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/display/modules/power/power_helpers.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/modules/power/power_helpers.c b/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
index b9e78451a3d5..30349881a283 100644
--- a/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
+++ b/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
@@ -839,8 +839,6 @@ bool is_psr_su_specific_panel(struct dc_link *link)
 				((dpcd_caps->sink_dev_id_str[1] == 0x08 && dpcd_caps->sink_dev_id_str[0] == 0x08) ||
 				(dpcd_caps->sink_dev_id_str[1] == 0x08 && dpcd_caps->sink_dev_id_str[0] == 0x07)))
 				isPSRSUSupported = false;
-			else if (dpcd_caps->sink_dev_id_str[1] == 0x08 && dpcd_caps->sink_dev_id_str[0] == 0x03)
-				isPSRSUSupported = false;
 			else if (dpcd_caps->psr_info.force_psrsu_cap == 0x1)
 				isPSRSUSupported = true;
 		}
-- 
2.34.1

