Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49595C38145
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Sep 2022 12:34:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B34910E746;
	Wed,  7 Sep 2022 12:34:12 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2051.outbound.protection.outlook.com [40.107.244.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B2AB10E746
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Sep 2022 12:34:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dko/cD5W3Qb6xLXImKO0bBGmFQUeFrnYIQrBHgViTkdo7IwUBMqqA0CzOjqdVcIobDVbx/OIY1EuNwaB7mvMv8CGf+t/hsLxKQNfdOLGT1bgDzyTLDGhxJ7iVrCwui81RknTfDfrcT/ZpBNZshxU5MaqAUuJD2BJqDkF7Wke4JvqnbhqXwq0BppA8YkueMkyXr5EyskkqpUQP0fESIdSF2C49i0Lgk2Upli1UTfgpsA7ZS09buaZgPAKuO8xP6qc0mcHjAVgcTHw9ijJnjmkB9icDsTDj3fz+8Ya+8cMY0cns4YX601BiCKKafv1BO9HejOIcd/VgT4lM2PmTkAKbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vA82LRXKDy3iHBjTYOMBPcCkynU474ePQZLeJh8JdXE=;
 b=TyQXAm2cl/D4JVUqCwhwnaOw46kfMwRIHlQ6yCVIojUpsDWdK4ERIGPlYqtbK3GJ+5ZJVwMq3eElf2XdQbVhJ2IJoulMWZ1N88VpLKhKnRtLiN4cXrQhS1P766DcqXOTjpQojPC92u/acKc8n8l+9iW/qRlWr10/to+nv2EGrd9mJfYGMhq1UAEwn+u/vBIIwaUgI14dhZvAHHSwrxmUCU/rWOi63CFz55hZXFmck1OcczlRO1G407EZwx9BzzE8dX0yDqBwJhDZsTm62Yb+yzW1mH4rCxurwECbRCmcREKKheOZ+LYQALYbf7cvpldRnbsD9T8/G5VrKcOQD5M2kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vA82LRXKDy3iHBjTYOMBPcCkynU474ePQZLeJh8JdXE=;
 b=eBH5B1i50aYVqb5LbP9K7iqU+qElhHUG3oSH6WyQD1eXwzMO2A+CBNRgoqH2XClHGf6aBTSlu5ppAIsUByS+EfrDtPO8KU5r95qxRUwiNB7wA1akk76JNMryelvfsD7g68VAlJiI6fjYDvE943yrh+8dTjovlPVHF/A3cQxqmfs=
Received: from DM6PR17CA0013.namprd17.prod.outlook.com (2603:10b6:5:1b3::26)
 by MW3PR12MB4537.namprd12.prod.outlook.com (2603:10b6:303:5b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Wed, 7 Sep
 2022 12:34:06 +0000
Received: from DM6NAM11FT069.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1b3:cafe::bc) by DM6PR17CA0013.outlook.office365.com
 (2603:10b6:5:1b3::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.18 via Frontend
 Transport; Wed, 7 Sep 2022 12:34:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT069.mail.protection.outlook.com (10.13.173.202) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.13 via Frontend Transport; Wed, 7 Sep 2022 12:34:05 +0000
Received: from guchchen-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 7 Sep 2022 07:34:03 -0500
From: Guchun Chen <guchun.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
 <hawking.zhang@amd.com>, <lijo.lazar@amd.com>, <evan.quan@amd.com>,
 <kenneth.feng@amd.com>
Subject: [PATCH] drm/amd/pm: disable BACO entry/exit completely on several
 sienna cichlid cards
Date: Wed, 7 Sep 2022 20:33:48 +0800
Message-ID: <20220907123348.2958910-1-guchun.chen@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT069:EE_|MW3PR12MB4537:EE_
X-MS-Office365-Filtering-Correlation-Id: 027fcf52-88b1-4eb6-56e7-08da90cd4117
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j/QU5xUXUKXIqJWjNoTBeFADh1YquKLPMjBsq9r2fVwxWET9NzBAdDU8sbWZxFHBxHFRtpVK2u6phFOJqeP5TzZXl7zkdiahwT98RlhU+NsjswyDeTcIXRUN52q2Xz5DuK18HpicXeW9v1euDwEdlcD2PkQUUk2U4S2Z3ZWZfWasrWnSxuxG6uliWZijVWPl6KUfNdNvMIOQic/AjGsQiTsqOmQ0evWlI7rIPa7z+4Ss8ZBZwHdyleuF0xUfKBP+QVVmP/rAaYyS0N3NpkZx9ckb97uD8qpSiqIUsYSQKFle07veM0txFVMQN2heQ6JhsRwz9jmXhygcyZLUEnFDYoCoK8x9mAUGRI6i5ScEI1J3JBi/E8tFrw0FOLt2DY0NdOMIvTLOeqY2q6zGS2w20TiomrVCByG87invIqV2NR5lvuc7zF+6Kqbxw4GRecawYD/cjMMq4uKf1j1d4sZYY8vFR2DcJZKXQeZTUN2Aa0y1PEcl9hrUDIN+u0XJao6nKbDOXOzuzQmNIdc6pNdL+lrsG75Iz4WNxKDGYxRZlYrfdUXCrZH2WJg+pFehBPeOOBdBKIqmQtS0PhHS3gKw5jNDSU/cA7Wk8OQWob/KLSrU2NeVajryO5Tv3Ug64Mvv+bjpOzfrCNLNpPNjJBz3vHKiiPUcjVLm4ymxdZo59+kZh4daQK8gZ+xpzhIGhZrcENLmRybQYGW9mxIYOuTmEFVLlLK3XWclG0FJvGBYJBlr+4iZdkX8qfGqv9OrTo8wt5kXm3gPnHndoHFBx3qQ1hU/+nHaas+xUuCVne6ciN88GhmtLEv6y6aiVYwlcxUA8+FU6gv1NSnZ9/luDK3Zvg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(346002)(39860400002)(376002)(136003)(46966006)(40470700004)(36840700001)(40460700003)(36756003)(86362001)(40480700001)(316002)(110136005)(6636002)(82740400003)(2906002)(356005)(44832011)(4744005)(81166007)(426003)(36860700001)(5660300002)(8936002)(4326008)(70206006)(82310400005)(83380400001)(16526019)(336012)(47076005)(8676002)(70586007)(2616005)(6666004)(186003)(1076003)(478600001)(26005)(41300700001)(7696005)(36900700001)(2101003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2022 12:34:05.9996 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 027fcf52-88b1-4eb6-56e7-08da90cd4117
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT069.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4537
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

To avoid hardware intermittent failures.

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 7ed4d4265797..74996a8fb671 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -369,6 +369,17 @@ static void sienna_cichlid_check_bxco_support(struct smu_context *smu)
 		smu_baco->platform_support =
 			(val & RCC_BIF_STRAP0__STRAP_PX_CAPABLE_MASK) ? true :
 									false;
+
+		/*
+		 * Disable BACO entry/exit completely on below SKUs to
+		 * avoid hardware intermittent failures.
+		 */
+		if (((adev->pdev->device == 0x73A1) &&
+		    (adev->pdev->revision == 0x00)) ||
+		    ((adev->pdev->device == 0x73BF) &&
+		    (adev->pdev->revision == 0xCF)))
+			smu_baco->platform_support = false;
+
 	}
 }
 
-- 
2.25.1

