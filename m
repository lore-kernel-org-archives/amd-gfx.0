Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9421FC71153
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Aug 2023 15:35:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F386E10E303;
	Mon, 28 Aug 2023 15:35:46 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2062e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::62e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9714010E303
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Aug 2023 15:35:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kU7C/kUPS6YHUTQEwineH3c5k3pPAI1W/ZDmsqGlmeoKotHC1FJIz4vMmG4OEvOzntQc7kKvQl0e1vsnyHPoAwcGpqJuxejWf/HJNMZMeJLMMBk2sBEssY434zrK6m+53YIEYFVs2sLmKF64XrwxIfbdBpXttMIKF9VkATBB3NxF5csKAER9VB00aHF/BRQ6E30+Bqq2faB7J+RVJzl9dDkyUrl/s7WOeq0NpXPr1jLHOXdEWGnclYk11rUF1tN24s8Li8sXV4PfJcBU4kb8eUdd/hb29f/4wfF+FIp/d7wAYvbxYocCbCCL2huz/+MLLUlxQ9V5gHm27OFHa822SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l7x6cCn7ysSK/IuyC5VNTI3CFEJapxphGLtod36d1z4=;
 b=ByLY5ynuLA4AxKHyYZCy0i1bAJT2h7uDJOtdaWybZDDUhZq+I7oVtEii0HKfQvkixg2k6pecAw5eyipuLyJ1BATGVXyKaKeaKQf+Om/c9O4kGXNGaUcW1/Qmg51PfKTtNX9XGNRA+ib8cAxbNOopI283D1HvWLxtqzsHsB/AfUeJ7NeATKPbnfunnRxUau7FwVuzwQfUxdDptPVDf7UR90c7KhTOUajJttjHa5j+K8GF5JJ5KYnGX5oDqvSCyGtVgm7FuuMfWKJpwIHIiZiabEZYMkdYakPiesRjc2xf9kOnolTG6VvWOryK6ndvnUYBcTcYgT9ibFetGJ6IWgPv/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l7x6cCn7ysSK/IuyC5VNTI3CFEJapxphGLtod36d1z4=;
 b=DscqBMMUzggLcx4Dc+8T7T3D4/SJyzmQIefpA9osMsOI6+JJEq2NHzestAxXtj3YuXIV8lpv4aSCQDamSd0pYGg6JIl1fSwa362q5b0AX5qKdEp4ilRQhwV00Fl8v8ZXI778KuovPEkFqawWdmlcB10u2fbrwVLLweg9yyQXQTs=
Received: from CY5PR19CA0072.namprd19.prod.outlook.com (2603:10b6:930:69::14)
 by CYYPR12MB8869.namprd12.prod.outlook.com (2603:10b6:930:bf::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Mon, 28 Aug
 2023 15:35:40 +0000
Received: from CY4PEPF0000E9D1.namprd03.prod.outlook.com
 (2603:10b6:930:69:cafe::53) by CY5PR19CA0072.outlook.office365.com
 (2603:10b6:930:69::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35 via Frontend
 Transport; Mon, 28 Aug 2023 15:35:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D1.mail.protection.outlook.com (10.167.241.144) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6745.16 via Frontend Transport; Mon, 28 Aug 2023 15:35:40 +0000
Received: from alex-MS-7B09.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 28 Aug
 2023 10:35:34 -0500
From: Alex Sierra <alex.sierra@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: use mask to get v9 interrupt sq data bits
 correctly
Date: Mon, 28 Aug 2023 10:35:09 -0500
Message-ID: <20230828153509.30399-1-alex.sierra@amd.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D1:EE_|CYYPR12MB8869:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fa2f318-b38a-454e-a942-08dba7dc6f57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xUHn/ur5yec5yTBUzLgxzLhU5pfEZrfRAidzEGuU/8lB37fdAQ2QgL1Albxv/ro+bTup1weHG6NPn15dVVMkhFqDEUD7/tNvtjVZp3m5q4WJmYkWcJ3Z0OkBCGoyZvYZUn944V/VHdPnzZr3c+gTxLQUhjaWAQBhjxD1SC6fxLdYeDL4lLpZ2vBdjDpeia/jShPylHzCtSM9D6Kur6WCQElqQQXTyFJ0zFbLXtWDgZUPiRYidLgTULYgDDV0nfMWbiKflujgV73FA+XrSDu43+7O4ZBjfNnCqPqSm2SncUEQhbSPb7GSVtRvqb4Gta0ShuwM3x7PtHjAIEjGpEWjZUf8jG3XiazwTjALUQ529u6wx/shFk/6yj128nxySvct6x3HPdeTMifEC/i+6hU8w36IJVdKMU2sIFj/TE252b+8GAbXV14RFZC6I06Myj9DkUuwq1H0iTAD7IM1dOmGs8R/x3jgseX0iZIGA9GCtr/g+zl0o0jTngNYMB6VkqK5l7hrujXNl04WCWp4RUkAxrZjSGOVXmrglp9S7n99v+mr4MAXzUJwH3pJ8nIyk34BwbNTKUhGFwEwq6js06iXG0MnNOPLqZW1xTDuxf4oV7y6NypPHlQwLscDyfGsTKrzIOXt/9bXp1roHeWkifS8mvAUkXOy0s0IONrHd7Id65cEmIR0AOpnqw8Qu81sxB2J3/CuPU9klLuEqwbUmTPnzPporyB5uqImkgiAqgiNJS5hYDhdfEh7ynf/9XOUHO/m6GxJi8L4fmVRp4Z9fZBTlg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(39860400002)(136003)(396003)(346002)(451199024)(1800799009)(82310400011)(186009)(40470700004)(36840700001)(46966006)(8676002)(8936002)(4326008)(2906002)(6916009)(36756003)(54906003)(316002)(70206006)(70586007)(5660300002)(44832011)(336012)(40460700003)(41300700001)(36860700001)(7696005)(2616005)(1076003)(26005)(16526019)(426003)(40480700001)(4744005)(82740400003)(81166007)(356005)(478600001)(83380400001)(86362001)(6666004)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2023 15:35:40.4466 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fa2f318-b38a-454e-a942-08dba7dc6f57
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8869
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
Cc: Alex Sierra <alex.sierra@amd.com>, Felix.Kuehling@amd.com,
 jonathan.kim@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Interrupt sq data bits were not taken properly from contextid0 and contextid1.
Use macro KFD_CONTEXT_ID_GET_SQ_INT_DATA instead.

Signed-off-by: Alex Sierra <alex.sierra@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
index f0731a6a5306..830396b1c3b1 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
@@ -384,7 +384,7 @@ static void event_interrupt_wq_v9(struct kfd_node *dev,
 			default:
 				break;
 			}
-			kfd_signal_event_interrupt(pasid, context_id0 & 0xffffff, 24);
+			kfd_signal_event_interrupt(pasid, sq_int_data, 24);
 		} else if (source_id == SOC15_INTSRC_CP_BAD_OPCODE) {
 			kfd_set_dbg_ev_from_interrupt(dev, pasid,
 				KFD_DEBUG_DOORBELL_ID(context_id0),
-- 
2.32.0

