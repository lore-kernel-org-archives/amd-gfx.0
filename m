Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42D93C02198
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Feb 2025 08:02:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A86AC10E18A;
	Mon, 10 Feb 2025 08:02:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Gbp50LvN";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2041.outbound.protection.outlook.com [40.107.243.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F71F10E18A
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Feb 2025 08:02:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h0srGMcDi9JM2MTk9Ex0+nDrgQ1+CqFn0CK9XtzNHatxMBWc7g/SVEMHp2t7gdiXMr0Yh9q/vdz0aSi/1fO+Kdlwd7rJlF2toA6E2A4KSXUw/qFdfk81vT3g+jkmx+iuYP6wHEsebkODdN+Tv0l3ookby1bCAyLvHOobkLNNoqiBmddeIX3jo4YRNiVPjJw8LbDMEUCAATRj/PytFP3PcmJXFyNCSOakxrS+n9POuoQIEEQvTVQq0JVrnYJAGGyAI+l9sKQyLrUnXsl3bEjfZ3xTb9EoyVyDQCfnxUyjaoT9br49iUu9u+PE+uS6g9SPZ1GWxV+TLO0/8ub6E9fmOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pZgAubfIIxsIiDRhGPWXe6CGz1z4awzXpwnzrdD0O2c=;
 b=fcpH0eyG/Pus2+ZxYxGtBBo/AyR6wEucHOfwdeiBwiDeeMh5jHSrtSJKZKHD+3I1EcmeLDcqzcwovqnv5HGxNn4MS4rgCV9T1plAl3L7yQXOfr3LLpru4LOrWvTNrFHu+4SqCTsuRN8xrUo07WbiG49CGlLXULQS9ZXwsTN7zhjJUiyH7l2EflSKjajKVeQJWG9oH48ptxmLF8Qegtlq9Isu7iRLwGQDuWh/xY8nqbOw6fRVx0RWoAwooj6R0wtN3A+iakT/0NN+gFpavFH8Ox3PPSAKaI5uOpNb8AyFgdRKetm01D4jcHn+SEquAzTPGrGdWUpirljv7JQdEEYQ9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pZgAubfIIxsIiDRhGPWXe6CGz1z4awzXpwnzrdD0O2c=;
 b=Gbp50LvN1FkSYyXNkPATnS1TpvwjeND8Q7cMJPdipzh2JJIqJxDwzhvD/SYRzv42Qc5/+UhDwhIGtZ75TRRw7xqMPnj7nzOX6RIJCwCqUE59Hciz9g61oJVl92bbZOyQytMw1Kcu/Q4DNGWgbFkA8QU5Q3kwB53Y00Yy0LRVA60=
Received: from BYAPR02CA0059.namprd02.prod.outlook.com (2603:10b6:a03:54::36)
 by SA0PR12MB4461.namprd12.prod.outlook.com (2603:10b6:806:9c::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Mon, 10 Feb
 2025 08:02:10 +0000
Received: from CO1PEPF000075F0.namprd03.prod.outlook.com
 (2603:10b6:a03:54:cafe::89) by BYAPR02CA0059.outlook.office365.com
 (2603:10b6:a03:54::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.31 via Frontend Transport; Mon,
 10 Feb 2025 08:02:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000075F0.mail.protection.outlook.com (10.167.249.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Mon, 10 Feb 2025 08:02:09 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 10 Feb
 2025 02:02:02 -0600
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <lijo.lazar@amd.com>
CC: <le.ma@amd.com>, <hawking.zhang@amd.com>, <shiwu.zhang@amd.com>,
 <Asad.Kamal@amd.com>, <alexander.deucher@amd.com>
Subject: [PATCH] drm/amd/pm: Rename pmfw message SetPstatePolicy
Date: Mon, 10 Feb 2025 16:01:49 +0800
Message-ID: <20250210080149.275167-1-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F0:EE_|SA0PR12MB4461:EE_
X-MS-Office365-Filtering-Correlation-Id: af878d83-5153-4d60-06a5-08dd49a93832
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?RR2xWNc2JMO6AyitFkV4zboMNvK4NqeDu0W9hpBOhijh/01Fx1sso/joSx/4?=
 =?us-ascii?Q?hQVzFlIgpf2wD+NrQ+MZwf03CtmfdNerGIfUrF8QNf/IJP/+lxZYpI2CL37Z?=
 =?us-ascii?Q?7uZWY9zIXxDdilj6wptN3WueWwEYeST0MVv3XzUjLLFJ3C7jOtP9murSUVDI?=
 =?us-ascii?Q?eY7Pv6Bflc/lXTaBbp2iFGT6v5/5Z40AWv2UrqIB4NLNtu17bvr/TrjxNBoY?=
 =?us-ascii?Q?q8jad01LDBFLOFmzMljnreuuFWvCDLQVPbpfb848i5u2Rpk6uJDBfIFNTqCm?=
 =?us-ascii?Q?+ohAykUKwWPLU4f0Wt82cPxZmTiCfr+pI2fju5bosJrY/+1My5uAJR1/TQRA?=
 =?us-ascii?Q?KkIq5H0VF2CD0B7Ms2z+Gd8g82tZHWLVzEtr1jVBqRtmyQzUBTL/U3YdrT6o?=
 =?us-ascii?Q?jtt6ndRzSMfXQ+qfnDOBUTdpwJREXA/BxqYGXUQ9LGA8Sr6KysCNIi8UAcQT?=
 =?us-ascii?Q?0kscFaKbqXZSSztvwQA+SK/1ra8rd6hesiIr6AwD4WWKjPe4ILQGtUdzLBNO?=
 =?us-ascii?Q?l24UxEyfB8vWjo+3o0iAf5syHRsSWQJzN6fzg8Z/bh4GiqFwl1VeukCgZePO?=
 =?us-ascii?Q?InG7wcezgH4huRbTdNLAZboDhRWVtRE95Cw0I5HP3iG1QQV69c88LBU2Vy1T?=
 =?us-ascii?Q?n46+oGMhobTyYXWQp6z30VociDIrQIxPutUmvWKmsiCwf2lwT5fFTAt5IH7y?=
 =?us-ascii?Q?UNU8Gl0Hm5G0CnhkSLlfoYVS9tjtP+lYeqaFf0RbTDPfBp56WAQ0SS5GKujo?=
 =?us-ascii?Q?TYxxd/loOX5re2DpEHjRG4PR7R18fPDnUj828i2bDPLB/LrFpAAoTyBbs7TO?=
 =?us-ascii?Q?w+L96tjThU8+m7fSYbjP/q3pXe33xNJ6MHLcuDgk5SVyKfPOB+VDjOyTQGKe?=
 =?us-ascii?Q?A0Jl/OneMbofYiQFegjDDHyQk0MYM148EzsbGO9SSJNwGIgwoPmmBbhIVMl8?=
 =?us-ascii?Q?djc4pF+QkwNVF1wb6KfqSM7O8PNHVwjkuT9Hk0W88X0uJ4lCDnce+uaG9BXn?=
 =?us-ascii?Q?fUYCm8AOKX5s+SYd4EU3zsToKwC2bP1HRXymngqq0YOykCLWH7uDe+mXC8O4?=
 =?us-ascii?Q?VJRzmcgU6xHI+9w6M9l6SQGLqcY/Go/FgxFUf4kRDNj4gVjG/lw+wcMkAFK9?=
 =?us-ascii?Q?QWjHwyJPccBmdv6Bs5nevsHPZo0cmwTMlWX8cpMz7BKTEPnAuZ66d/a0msHY?=
 =?us-ascii?Q?R2w9G0hB2sY6rogWi53Qh+JWzI1NLVV0fqDpkqajLZKS4zdLydqZp00V6+cO?=
 =?us-ascii?Q?sUG6XFXFwzr70OKvlF5GyYrLCFXGE/be5Zd70Ykf9muAgtwjxlHxNMvqAqtd?=
 =?us-ascii?Q?uRyfF8K8L4xHruEUlhyP0DZ/IeZT5/apgrlMrx17P5Tym2bhuq8cWBd7VE1w?=
 =?us-ascii?Q?OmIXK0GPMWK0nVuvO0k6TDBFOV0raJ0xSpQRgNuzb7YrhK5unih2H2W+E1T8?=
 =?us-ascii?Q?0tQpo0mZVh5JVLA7bTy0NZl1eH3KeoZ+a54BmSk4OqEEYVPrysMzXw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2025 08:02:09.6019 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af878d83-5153-4d60-06a5-08dd49a93832
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075F0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4461
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

Rename pmfw message SelectPstatePolicy to SetThrottlingPolicy as per
pmfw interface header for smu_v_13_0_6

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h | 2 +-
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h                 | 2 +-
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c         | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h
index 147bfb12fd75..288b2576432b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h
@@ -92,7 +92,7 @@
 #define PPSMC_MSG_McaBankCeDumpDW                   0x3B
 #define PPSMC_MSG_SelectPLPDMode                    0x40
 #define PPSMC_MSG_RmaDueToBadPageThreshold          0x43
-#define PPSMC_MSG_SelectPstatePolicy                0x44
+#define PPSMC_MSG_SetThrottlingPolicy               0x44
 #define PPSMC_MSG_ResetSDMA                         0x4D
 #define PPSMC_Message_Count                         0x4E
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
index e4cd6a0d13da..9ccd5a1986d3 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
@@ -273,7 +273,7 @@
 	__SMU_DUMMY_MAP(GetMetricsVersion), \
 	__SMU_DUMMY_MAP(EnableUCLKShadow), \
 	__SMU_DUMMY_MAP(RmaDueToBadPageThreshold), \
-	__SMU_DUMMY_MAP(SelectPstatePolicy), \
+	__SMU_DUMMY_MAP(SetThrottlingPolicy), \
 	__SMU_DUMMY_MAP(MALLPowerController), \
 	__SMU_DUMMY_MAP(MALLPowerState), \
 	__SMU_DUMMY_MAP(ResetSDMA),
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index d645387beaa4..3fa671f4981c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -192,7 +192,7 @@ static const struct cmn2asic_msg_mapping smu_v13_0_6_message_map[SMU_MSG_MAX_COU
 	MSG_MAP(McaBankCeDumpDW,                     PPSMC_MSG_McaBankCeDumpDW,                 SMU_MSG_RAS_PRI),
 	MSG_MAP(SelectPLPDMode,                      PPSMC_MSG_SelectPLPDMode,                  0),
 	MSG_MAP(RmaDueToBadPageThreshold,            PPSMC_MSG_RmaDueToBadPageThreshold,        0),
-	MSG_MAP(SelectPstatePolicy,                  PPSMC_MSG_SelectPstatePolicy,              0),
+	MSG_MAP(SetThrottlingPolicy,                 PPSMC_MSG_SetThrottlingPolicy,             0),
 	MSG_MAP(ResetSDMA,                           PPSMC_MSG_ResetSDMA,                       0),
 };
 
@@ -584,7 +584,7 @@ static int smu_v13_0_6_select_policy_soc_pstate(struct smu_context *smu,
 		return -EINVAL;
 	}
 
-	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SelectPstatePolicy,
+	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetThrottlingPolicy,
 					      param, NULL);
 
 	if (ret)
-- 
2.46.0

