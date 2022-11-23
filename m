Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75D2EC433FE
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Nov 2022 01:43:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F0D4010E1EA;
	Wed, 23 Nov 2022 01:43:40 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2062c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::62c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 64ECA10E1EA
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Nov 2022 01:43:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NGLohnBorv4pjA1KDeXKovHOavWviYNJzif5pHC/5GafbIoUNrEncgeGR4tQLni5D+FRq9KOTODBHsF7cR76vG2BIEoHjl+gnxWnfU/g08TQCos4ufzrPginMhOrHJOMtdGBZH0mz5JqJCUmCpYawCIleK8Fazyu47ONWpGv5qOipxeYFfRkY9+gJy36eXzWSAoi/1Vx+PunfmB/o1Bh1l/EHfHwTESuuk+OaOgeqX18QBOYjg3OA6ARDjExoTkdUDeeu4mQ8MgqMoE9xf1JwnRrSJk6VOMDu1KN4tJmrYRzRM4OqGhjSEGouBT7o69rT+ZpDRzUmuPgVTU6N3yLpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+UvsfMGzMfHzBFFjfhm+n8Grn9P13sn7p8dwcqn3S0c=;
 b=N0C5VxonvaeOqxrvy0NGqRcf1LMGWtwcT+b3vF4ROgfEvpSo63+58EGLFLbbo6DzQ4hQGXz4G2/+IpStQBFoBfwga0E+y1Gt0E8W47mJedxd10tkqu19ipW8Bzbwjmd/8bHE29gjEEjuIZFcYqL+qQzMPemFImPzyv8NcgaurACrGpLIFWSkqebECs3M8KDreH2Far3iG5lT/J/npvHecD5Xucoo1PDhKR6uAe2rHAlDAucNyMqjF7VIiAp2l0Xke1O1o40H82OoUasqprJKyigY+sBdsUv2lG4st8k3hdoUZbg763dH4kW1MowZsYBkMa5w+foscgU0H+pqY+mzyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+UvsfMGzMfHzBFFjfhm+n8Grn9P13sn7p8dwcqn3S0c=;
 b=MUVOx1yYzxtj5r564nMzkq5SPuPaSuAP4Vp0QU3byYkxU+q1TZdfejzfnLEq9+NkcYoCBkeQhSP0CR2QBiAj9flDeviPKt28lK20sWLkDq70E0XHOxEjoimnx1AEohbTEwPDie4c8dOM8wjzBZHvI4vNuwlaP/X+Ba/TnTLD118=
Received: from MW4P222CA0020.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::25)
 by PH7PR12MB6418.namprd12.prod.outlook.com (2603:10b6:510:1fe::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Wed, 23 Nov
 2022 01:43:35 +0000
Received: from CO1NAM11FT049.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:114:cafe::24) by MW4P222CA0020.outlook.office365.com
 (2603:10b6:303:114::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15 via Frontend
 Transport; Wed, 23 Nov 2022 01:43:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT049.mail.protection.outlook.com (10.13.175.50) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5857.17 via Frontend Transport; Wed, 23 Nov 2022 01:43:35 +0000
Received: from guchchen-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Tue, 22 Nov 2022 19:43:21 -0600
From: Guchun Chen <guchun.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
 <hawking.zhang@amd.com>, <lijo.lazar@amd.com>, <evan.quan@amd.com>
Subject: [PATCH 1/3] drm/amd/pm/smu11: BACO is supported when it's in BACO
 state
Date: Wed, 23 Nov 2022 09:43:07 +0800
Message-ID: <20221123014307.263178-1-guchun.chen@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT049:EE_|PH7PR12MB6418:EE_
X-MS-Office365-Filtering-Correlation-Id: 752ffc3f-527e-47a2-410f-08daccf422da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HStClzxjd4tVtdMUUv2jdK6ycK334Ta1ZHOpertWPuc55CFcVQ0IB1nSZ1/uHSE/PqiPRjeLlP5pA9gWolwtR8+wKyZ4Y72gIEWmmbjD/F7AScLhCyXEWtRQ3LlWDKHfxut0mD/BioIbFq2JPW8Q1ZXYgz28rQ/BUQ+3CNXhTfBNMXmGCKF054USGXBkwfM3u2GJpMQWRNw6bZ5OB7dzdGX0mcbQ+H5K4mUvyWt7PIPnPGgZiSdqqBd44AjfpWXZbM96LbI6vAJp5jgGUN06mPvXtBVDmLDbvkC1gO0Q0WQUKG7URcxINobVSomv+SYCjYFspORXuY8g72hRv8DacYGDF55gMHtuWJ8NZVjVR8AB//P8vnwAptdztFRV5jqmRHNh8nUOxGFoT54fOuSQhQMi5ZjAeAN2zFrZmqCRg4feDo5Np7Ew89ARTxr5L1/ktKQCWjezBUJo16pNgcWMyMkXpWj8e2ZH3rps8X+ILaIPQC6zt/AAZQlYsl2m1+4WL49SQqedaQJ6uw9fg4A8PNf0DS5DXlP1h4gwRvu/DuTI/vJJhQj7Uo6vBauh2S+WfJnwRh1p8wlbDnpWi/m6IweNrLHx5PbSbETDwWRc17fAHX8GHY95ildQMwByiiamYnRYx/+gSLZC7jkMNHhEHvdAA0dUt/CCTDNJ9JKGZwBvoi9CgdFyjBY+AFm+CD1T/Q+q3xwroGaBO2zMYPYMjxYFQmyNir0f0AOYGEb5exy2PlsK5ZO0nwRKLIsHsc/n
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(346002)(136003)(376002)(396003)(451199015)(36840700001)(46966006)(40470700004)(2906002)(44832011)(8936002)(6636002)(5660300002)(82310400005)(316002)(36860700001)(41300700001)(40460700003)(110136005)(8676002)(70206006)(4326008)(70586007)(81166007)(478600001)(36756003)(86362001)(2616005)(6666004)(47076005)(26005)(426003)(186003)(7696005)(1076003)(16526019)(336012)(356005)(82740400003)(40480700001)(36900700001)(2101003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2022 01:43:35.3755 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 752ffc3f-527e-47a2-410f-08daccf422da
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT049.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6418
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
Cc: Guchun Chen <guchun.chen@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Return true early if ASIC is in BACO state already, no need
to talk to SMU. It can fix the issue that driver was not
calling BACO exit at all in runtime pm resume, and a timing
issue leading to a PCI AER error happened eventually.

Fixes: 8795e182b02d ("PCI/portdrv: Don't disable AER reporting in get_port_device_capability()")
Suggested-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
index 70b560737687..ad5f6a15a1d7 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -1588,6 +1588,10 @@ bool smu_v11_0_baco_is_support(struct smu_context *smu)
 	if (amdgpu_sriov_vf(smu->adev) || !smu_baco->platform_support)
 		return false;
 
+	/* return true if ASIC is in BACO state already */
+	if (smu_v11_0_baco_get_state(smu) == SMU_BACO_STATE_ENTER)
+		return true;
+
 	/* Arcturus does not support this bit mask */
 	if (smu_cmn_feature_is_supported(smu, SMU_FEATURE_BACO_BIT) &&
 	   !smu_cmn_feature_is_enabled(smu, SMU_FEATURE_BACO_BIT))
-- 
2.25.1

