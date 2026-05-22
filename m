Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DA6BCD5BAB
	for <amd-gfx@archiver.kernel.org>; Fri, 22 May 2026 00:22:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D03A010F491;
	Fri, 22 May 2026 00:22:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zeYaNX9z";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012028.outbound.protection.outlook.com [40.107.209.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0261310F491
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 May 2026 00:22:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AvG7/fbGVEXDNtH7nfNTRH7LhvI2E0KVWshq3Q8W3FoyClK1HKRugxIrf8VircpMeEA54olUaoAADOzebUliwA12zU7eG/q6ORSWOmY6TH4ChQMQbRyIzO5Ye2EDR7QItrEEgA/zLb45EIkqr91aIXCAAtCuRsZutS/8I5sYBdniMeuIMNprArvBB+azPMUus17Yho0QcsihX7ZecGd0s0DTzSHAKcM0ieTlrq2IpuYlCc5W5zc2QFL4S7NM3k7rxnMdwiyZwXgXWIS6iVwOZh6Ajs6MJ5xQjLqwbIsXcbOzvulDfdXqPfLGd4Jd6cBFTF+yVeWQZ5t6zydPq6H1Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Abjbtj/sm6Tdxg94dCjgWLUqCfu5jKfc/VeRd6SgGv4=;
 b=MInIeIIYUqWpwsmC3hh398Xqwzj3gf5JqJDrHdgnhcqs172ZQkB98a1lh99HOoASNg7ec1GGzrRwjEkHt5qiSZFFTgDE7BzWqDw/4cumnM6oBb/iaqYab0PSn0dYv86ZvoISpmsiHWkcygHt8M+ONI8CC35I/7jxeNHXvilL62yBeXHCiIV0iNJCqdBypNADbtzJHk95FJ7QA25uno4tn6wgtps/rzDwt6vZMgd8+qZYsYLVLzgZsnR0aoFVFTtoGPkuMrx6H782Xc4ybX3j31R2IdG3SqhFnqkF/bzM++N0oteJMfj5S4Ef9tvQaMaa+PRqlKkvxpxuD/wu8vSZKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Abjbtj/sm6Tdxg94dCjgWLUqCfu5jKfc/VeRd6SgGv4=;
 b=zeYaNX9zjjFEKFMkL2rEDWo9Pjg/Qjre6vrEd176XUeiZVlM6KgwiCCq8DlkLJdimsYtF3c0kkcyZQL3XSq0S8h3ffVXhgVpBkD4dqcZ5t+1ok8Bzct31WQWdTuG/zVXAvamJ72hzCoiRr557Q4z0A6lMn14WLlrJm8O8hku9Vo=
Received: from DS7PR05CA0008.namprd05.prod.outlook.com (2603:10b6:5:3b9::13)
 by SA0PR12MB4381.namprd12.prod.outlook.com (2603:10b6:806:70::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Fri, 22 May
 2026 00:22:43 +0000
Received: from DM2PEPF00003FC7.namprd04.prod.outlook.com
 (2603:10b6:5:3b9:cafe::77) by DS7PR05CA0008.outlook.office365.com
 (2603:10b6:5:3b9::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.8 via Frontend Transport; Fri, 22
 May 2026 00:22:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DM2PEPF00003FC7.mail.protection.outlook.com (10.167.23.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Fri, 22 May 2026 00:22:43 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 21 May
 2026 19:22:25 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 21 May
 2026 19:22:25 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Thu, 21 May 2026 19:22:24 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sunil.khatri@amd.com>, <Amber.Lin@amd.com>, <Jesse.Zhang@amd.com>,
 <Shaoyun.Liu@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 40/42] drm/amdgpu/mes12: enable compute MMIO pipe reset
Date: Thu, 21 May 2026 20:20:46 -0400
Message-ID: <20260522002048.98506-41-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260522002048.98506-1-alexander.deucher@amd.com>
References: <20260522002048.98506-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM2PEPF00003FC7:EE_|SA0PR12MB4381:EE_
X-MS-Office365-Filtering-Correlation-Id: ec81b389-6a30-443f-5438-08deb7983e12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|376014|82310400026|18002099003|22082099003|56012099003|11063799006;
X-Microsoft-Antispam-Message-Info: d5CRlAxa8jqYxM+l/ufVFFmw1M81qFAacNSN01f6WYlQOODCUd+0uLkaUbbtejrbfqfKqlPjUGvRCFb2MXy1CwGctae2Uk5VCGcFHQ9AOtS5ovjl/4fmHC0NZfsiH1leUpwtvA6uJuYdqthItdnf+NydRaO062NvMbZph30rceXbdjvEbAonPwNi+4VmKGIbvvxRruLRFhDyVb0v7pIOjS10+coGbACVgt016kcJqxfeP1PXC1Fl/6gS/ArHVkSW9lequ1T5XFh7IqOdfrtSlU7mNPfh4pCWm58ZpZtJwForiAIBV/oD2qvWga/WxIDiY/RPYJMtYKOw4a/u1+8yRIVLOaQsDNT5SLu9nNKENlA/vUdLA+jOtXvpheBkaIGbXuEPbAhnBFPeX2Q+fSTHT695A5vqLIQfdM5Wb6Tq9lHL8xI6328lIUTLwIuD5FbUKqsuxx1w+8oIR46W+pCkUlP+55RuwtRj/q44hxsAGsZGBKKaLU6sce041AXoM+HLAZpuAWk+Qyh38PSyiWI3lKpQf657Q+iGbxP6M4BWS1I6BSkptnef3GxKzDYREz1Kfz4hH6c/z09uiIrzyNnUCRsvMGrBXkLaXckuNylu5hiAHKcaoHdIHF2r2jLhMqtzWrgYPXd3kCnfM8KkToFZh0vEsSU0uVJ+lIlhBrNPvhOAaUr3NnhkY58pDr/iAP9yP4OZk97dexDC4rkGED1L/x07f213l39MwuquCIMIBhg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(376014)(82310400026)(18002099003)(22082099003)(56012099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 9goFmvS4fd8/AsknX+/5G0KTWvvXU6ng4R57ryF6Dx4RBX9lM26WjnzpIYjjHkGJ+Eq69NpxECMTAxD+x28kMIE5EELcF/XAmAkS6BV31NhCtpPRmWjxIjU4zfa+8K6DWIXdpW4GUi/RsvCwkAIC3BNXGQvGpieIH+lSX9sG3d1z+q/7Ep1tvNSjB6noB7TYuGNImq1xNxA6oWqS3BFbMBxqZMD9KSsTaz2XTk9yHLB6sij8UINWE48+8//wiaDbRxeB3R06hDf9nSjMa+xU1rlwwdf9UpbyxhPgeUK7fejYnOY59YSZmmhpyaj30CPFDT0Equ+FDaKM6zSUOawXVQmysoqxDRgPJOL+HitIeVDilOaO3TnYuOM7qtJ1PjizsndoEkSUk0e4WHzlQfUjJ3ZtImakHlCQ3jX3VSfoTOVZdhIRsolIVeFWkH2leWT6
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2026 00:22:43.6791 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec81b389-6a30-443f-5438-08deb7983e12
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM2PEPF00003FC7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4381
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

Enable MMIO pipe reset for compute pipes.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
index ac75b7d65cb7a..b86279f4776eb 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -510,9 +510,6 @@ static int mes_v12_0_reset_compute_pipe_mmio(struct amdgpu_device *adev,
 	uint32_t reset_val, clean_val;
 	int r = 0;
 
-	if (!mes_v12_0_pipe_reset_support(adev))
-		return -EOPNOTSUPP;
-
 	amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
 	mutex_lock(&adev->srbm_mutex);
 	soc24_grbm_select(adev, me, pipe, queue, 0);
-- 
2.54.0

