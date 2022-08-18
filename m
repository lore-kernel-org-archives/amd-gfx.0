Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B2CDC00140
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Aug 2022 19:12:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 58C5FC35A9;
	Wed, 24 Aug 2022 19:12:14 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C701010E29A
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Aug 2022 17:37:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=arXFVw+dAciyTEaBNZK+Gl9DYY8XyTb5OEBxULrRzlhAAS+v7deOXFU6zVTPsa0qCTvo0nvKQ0WOx0SiZbPQLmxOYDfO92mTWCQGiOHd4UA7Sh8srJzCy3eBnpSU7zZOdAvHMB/3o69WQTczpiLNGYU6TzP/G8D1SkY4qAA5HvResCburtDNp5u/jV5Q1mji+lwRbGAPKhNuz8yjbN+TjQNhkY/6WJAuE5pSDp4+1IncjlO1CHy0tIV8hc/y6EucnaqlZhZ243uEqSDc47KMXaaWTIHpi+cS6f7cGMrKQWlV0Bt1sg6C6PfR9Rjn1BW/JypkTQTojk4jDJNc9+PlJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dbZ+1Z0ZuhL3L1ZS/MN/G3BKnMVEcWHFNQW0HAuohoU=;
 b=P0Ek/jepMqCxw5e8DfHzTMQTYvvEPZvQjlryx/t+DSIs47b/2wWb6RIy8gsk8ql3SyYNlo17IjjGVmdd/YfnRIlhhHzIqFik3s207HoK65CKD3TyZHOd2fhavgQdxDJqd9h5lH7ohRj3GV0vX9Y2uiLjh/UZFPDmO3WfJBB/RZMbVWfadM/2wWmUB4CptNUHNX/gWsVtnZJHWrPYzbYkE3Zhk79p13G5S13uNF10DRTvgud+PlGDe8Sp61cCZqfqTI3tjHC+jGG6u0qaKm/LahIckS4Kiuz68uoglUuL11uVaKclf+wKvvntFpumbg/6RwWVtSHLRHk6okuDpN7A3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dbZ+1Z0ZuhL3L1ZS/MN/G3BKnMVEcWHFNQW0HAuohoU=;
 b=tQ7Hq2hWZU6ZZbD0fyXLnugh13jMJ6dPQoy/NTTNw82cAih0ResTajB7CzX8MR5dyRfc77YG+OyUN5HKilEx3HTxiWVekEFQEcBzUAukzqOWPRyXAxMNo8GBOWLINvSbRhmIIr5Z6qc8MZYWarIJHDFK7p5ztrD7/odserWbZMU=
Received: from DS7PR05CA0043.namprd05.prod.outlook.com (2603:10b6:8:2f::22) by
 DM5PR12MB2472.namprd12.prod.outlook.com (2603:10b6:4:b9::39) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5525.10; Thu, 18 Aug 2022 17:37:35 +0000
Received: from DM6NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2f:cafe::10) by DS7PR05CA0043.outlook.office365.com
 (2603:10b6:8:2f::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.4 via Frontend
 Transport; Thu, 18 Aug 2022 17:37:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT042.mail.protection.outlook.com (10.13.173.165) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5546.15 via Frontend Transport; Thu, 18 Aug 2022 17:37:35 +0000
Received: from VC-PC.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 18 Aug
 2022 12:37:34 -0500
From: Vignesh Chander <Vignesh.Chander@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: skip set_topology_info for VF
Date: Thu, 18 Aug 2022 13:38:10 -0400
Message-ID: <20220818173810.17368-1-Vignesh.Chander@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 22f3fe11-a6d7-4729-313a-08da81405649
X-MS-TrafficTypeDiagnostic: DM5PR12MB2472:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZlL3S44Lk9WiIDwImHJhYzZ8NrF/FobupawBiNpqi5E16+lpPigtclWC0tKa7wVjhhS6MkM+N5ELUFa4viy43mDIpizf+G6nhq1cOS8BmRPKHaz2jifcUpxWjh42NKl3MYNgvtWVbzyfwYK/NpxTg8Ke2UQg5YLJvOwg2WVvaoeVWdlG3izYBgGTrDwYAZ2zSX3kDddQFOHBOqL5x2YY2MeSKVlSk94fS3XDTD2lii4AEHarj4n/AHaXOOkGzSPMusMspvFWyYVRnGgpAyABmEuaOUjJfHMbLjGbYKCOm1gsI1n1YwBkZZF7qBPv14Nq3v2mbGs+4jxZjPxr08Amq+qmbT6AhwKCikO1FvD9CvFI7r8aaigZJvqPMzMSLPQJIFrLPfz8l1k9Oln53y11mUyTdEXxLcKJzq04GBXtK7UXEdlcE3S/GQMCTKP/Iu5XhbtB9P1pbrti3+6AYGQt+LGzlMOtZm30TLZbF7laERf+tAsCOgVPtLEbfCnUCVI1Kd1fJcqhCMsK3R6BwSsG14zeQC0Q/tCjsyqAvO9NsFDmqu7kfqksmUrlJYRwU4VyqslHVKlo9pepbYf0bTKOpWtK0VMCZPr/tZ/jrOoHXWWn4huxqohsjjltQ0zR+Ifzc8DiUIaKs5hAo3qtFQSCGfeOSMU+ywLp/WUydupTxkqADRRd67nkaHkOJ21aNi4avizVnyo5wtKPnHC7H0ekWpJWPbbeVBK4+IGFHrprbqV+2tqWLTyS9o0qe9Z3QnBy0hG3A5vdHaQ4edqb0M8HMv1ikrgvIg/6/YPsFn3zGO4tdkA7ukEZwwa8JeDo+XOiV4OCR6G2ukgUV3dtKVVM6w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(376002)(346002)(39860400002)(136003)(40470700004)(46966006)(36840700001)(82740400003)(40460700003)(83380400001)(1076003)(2616005)(426003)(47076005)(36860700001)(186003)(40480700001)(82310400005)(356005)(336012)(81166007)(478600001)(16526019)(6916009)(41300700001)(316002)(6666004)(70586007)(54906003)(5660300002)(7696005)(26005)(2906002)(8936002)(8676002)(4326008)(86362001)(36756003)(4744005)(70206006)(16060500005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2022 17:37:35.0780 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 22f3fe11-a6d7-4729-313a-08da81405649
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT042.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2472
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
Cc: Jonathan.kim@amd.com, Vignesh Chander <Vignesh.Chander@amd.com>,
 shaoyun.liu@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Skip set_topology_info as xgmi TA will now block it
and host needs to program it.

Signed-off-by: Vignesh Chander <Vignesh.Chander@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
index 1b108d03e785..1a2b4c4b745c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -504,6 +504,9 @@ int amdgpu_xgmi_update_topology(struct amdgpu_hive_info *hive, struct amdgpu_dev
 {
 	int ret;
 
+	if (amdgpu_sriov_vf(adev))
+		return 0;
+
 	/* Each psp need to set the latest topology */
 	ret = psp_xgmi_set_topology_info(&adev->psp,
 					 atomic_read(&hive->number_devices),
-- 
2.25.1

