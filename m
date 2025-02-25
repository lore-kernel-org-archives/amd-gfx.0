Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFE99C021B8
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Feb 2025 06:37:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7141A10E564;
	Tue, 25 Feb 2025 06:37:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DGCjHhKe";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2061.outbound.protection.outlook.com [40.107.243.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3379310E564
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Feb 2025 06:37:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=px1G/IDc6q3RjrVdLkIZtL8HDX+aHxpKZOf5W+tDV2unzMG4JnkWhZB+KBb2sefb7Ea+1nDDWSDFnzXXLdFLKhDhPgnqtPzB7sdPpjSZ9KbX638rZDr2643zUrp5Q+VEa/L6tWl9Q9GSu+Gb76ietkU2HqGWjtEICwkGRnZI2ZiRI8Tetj1vL8cTeAX4Z/LgKYaBB4SmT4fzNYXWGx9d9KlQI7tvZO2s5ir3wwnttzpXrtr6MXLHkMqysKB23J2+hjB/HRL90R0tg9najxLC/DoDbvJTH8+7GoKc3VZAQp4jq7ped68shkaHRVXYCG5SuERGnOmTW1rpApK+FuPhIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XkYB82hkFOMGBnyQvJWXOj2CITUOnX2zhRJUmPO7c98=;
 b=lXeByAOtDgfdsA25c52Ow+dQFfVt5GaEjXEjBV9eIHuToMRMTftjIUJKiLmgdBiRd7jyq3TuBXKRdePUO80mbj0EYtDXpbGWe6osGO029BXRcuA9g9czSQDOG1UmtRUY/zWuWYznIp+1wtCfJ4fq3qxvof80+bijGpbBY96gnTrZtAiQY82qQbxtWJOpFOrlTsH2S3g3AdPYaiNnEKNOIGYysR2M5EpWquXxR2dfKqC2cPqpOOha8dLxFK+nGJ9MJuauku1PUdLICNH0/qi/qVXc+VkWq0hJoI6IE+OtJDi+U2WCUlTHMyhUAj+vQxLvWxxXlfg6lIYhFJzUZaUInQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XkYB82hkFOMGBnyQvJWXOj2CITUOnX2zhRJUmPO7c98=;
 b=DGCjHhKedW9frDxvQL/UaMxeZ2Vhtls0YrueoT1B5G4IoEkfXZLLF+9tms+EcMrOzak29WxLBWle0awcAMkZeIieMZP2Nn2nApptZnl5NZosrhEgJ+IrfoRu2ibjOigjgJQie6+m1Ute/Deaq4JEFK1lsB2lCH7aFhUCiaLvhfo=
Received: from BN9PR03CA0569.namprd03.prod.outlook.com (2603:10b6:408:138::34)
 by SA1PR12MB8968.namprd12.prod.outlook.com (2603:10b6:806:388::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Tue, 25 Feb
 2025 06:37:43 +0000
Received: from BN1PEPF0000468A.namprd05.prod.outlook.com
 (2603:10b6:408:138:cafe::a2) by BN9PR03CA0569.outlook.office365.com
 (2603:10b6:408:138::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.21 via Frontend Transport; Tue,
 25 Feb 2025 06:37:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF0000468A.mail.protection.outlook.com (10.167.243.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Tue, 25 Feb 2025 06:37:42 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 25 Feb
 2025 00:37:42 -0600
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 25 Feb 2025 00:37:37 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Alex Hung
 <alex.hung@amd.com>, Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 14/27] drm/amd/display: Change amdgpu_dm_irq_suspend() to void
Date: Tue, 25 Feb 2025 14:35:57 +0800
Message-ID: <20250225063610.631461-15-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20250225063610.631461-1-Wayne.Lin@amd.com>
References: <20250225063610.631461-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Wayne.Lin@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468A:EE_|SA1PR12MB8968:EE_
X-MS-Office365-Filtering-Correlation-Id: dd68aa18-ac7e-4d20-fecf-08dd5566e843
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?XESHQZfBRHEgOZ8i0XQJDkcbvxSPIGh0Gyl2lsW58xbKSDIwWlw4Ly6ySWzQ?=
 =?us-ascii?Q?Mg6IyucpJZlkQsnDgTrricJ1/uXsXEu9HIBnRr9+GlX9i1pJIsbq8OMfpyRO?=
 =?us-ascii?Q?EL1MckmY3xPIM6gRJKxvyoQ1KCE17WxbVZi+OOuHg/IsOFtDUbTIL8zFU+Oz?=
 =?us-ascii?Q?WAVBODZ7UQ5/+mmPwq3eFaRrP5x5nrx2QB3FIaszHFA6MjHIRn6AxgZATF9P?=
 =?us-ascii?Q?ox/HvS01xUNsa2tR5F3r/Mvo58ZGRPIw+wSMlWZeC3fjzhBu2lJYhtIjJcZ5?=
 =?us-ascii?Q?kZr4NR+87bIKihvUgT4FymBoO9XIEcJc6Y6E+Yxr7C9Uws23Qyt5O5+P6Njh?=
 =?us-ascii?Q?B7tFhE/K/9lGXnl5aXHqwsSXO/xYQ3dx0Eehua1rMiEzzjxSzqPjPZsfVqhz?=
 =?us-ascii?Q?Jx+Ekpwg29zfAIevmWAZRXB+UfVjddlv5yrUDkEN+gK7p90ucDpRmAyD2A6s?=
 =?us-ascii?Q?GqAtFof90IORAuUzjhHcfDYsLOKbHiXWttMBxGavkY4jRWgjH4wxYjhhScJP?=
 =?us-ascii?Q?MX8Hiym/UDqsYPToGJFh6pwaAYeWGFml3ZmD0wxsYcSkJ5x77a81xZf3+Bkg?=
 =?us-ascii?Q?6WodUSib70SKEvkRBbzFTm5WVU4OO4vC0qeS7GOCoifkfCQIWxDk6HXPqbUe?=
 =?us-ascii?Q?Nm6MlM5P9YMkOC+uUBhJU0d02G/5g7rDH/rQJ9aSA2DOFG9UWB6nUoJ7MmAY?=
 =?us-ascii?Q?TZvKYsuxqOycUFSpMebA+sIT8Pp05cb1A6kjuU44Phd4ohwTf9Ptcdxe6vMa?=
 =?us-ascii?Q?a56gTnkOvdT8A6+zAgYS+NC8D3DJ580naFrGcWh99c2ZF1x2plPxMWC6PGa6?=
 =?us-ascii?Q?O7w9k+yZYCKrkarCaDNW3uVte85IV2M/PjYbYrRcqtkQf5G+7IQLq0VvN+SK?=
 =?us-ascii?Q?6hTi11RmP1v7P3VPYD235VMvSQj2gzBIqyAuw6n5WHSQS1zFNmJSljYnSAmE?=
 =?us-ascii?Q?yBOnkefulaB8cqhS5fGuXPy6g8yByC0GOTX2ZzacJEHs8mjIxR4G7YiLxF+8?=
 =?us-ascii?Q?jZaQ17ay+7fQJ1QqPU43I1Rvo809cwNIVjVZeNTMYTGBnrEd+cL+44mA5LTk?=
 =?us-ascii?Q?gmV85R8MouF0MyZPfIG2ONlCVN+24nQ9bMeVg5Xq4lQb72mPQUqoXhHxcrex?=
 =?us-ascii?Q?NOP+U84FdsAgfECGnII+p5YIXNxDwMnj7bkFx/Nga6RFU1ao22RRnN0Hf22+?=
 =?us-ascii?Q?fqZAdJ2bjdfNyAJDsFDtKSux8FNkwZN12y03kuZMm7WyxqqApWyaygxrQyfn?=
 =?us-ascii?Q?HiZuYdvJj6B2GJOHEU7LkBr3O40IF3pG3IiXx2OdUHq9mw+zlvxxsKiK2nJR?=
 =?us-ascii?Q?A/J5iCDYry3UZW0MKbrvqmMU8pEWc418zjM6Fl79SOgjqMAhzjcELMg1w0YJ?=
 =?us-ascii?Q?QTPB3+37HQMSM70YRjVcTomTCo5pLCsGD3f0bh79EVlf9mP03MUCvaYBvZFt?=
 =?us-ascii?Q?/1M15gY/WyieQfDXetoF25ja4xBMgVka4nThJLdeY2gpApIStKWYSNfOcAqg?=
 =?us-ascii?Q?XkoIqpKadfVPVNM=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 06:37:42.7766 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd68aa18-ac7e-4d20-fecf-08dd5566e843
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8968
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

From: Mario Limonciello <mario.limonciello@amd.com>

amdgpu_dm_irq_suspend() doesn't have any error flows and always
returns zero.

Change the function to void.

Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c | 3 +--
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.h | 2 +-
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
index c4a7fd453e5f..34cd39488ad0 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
@@ -473,7 +473,7 @@ void amdgpu_dm_irq_fini(struct amdgpu_device *adev)
 	unregister_all_irq_handlers(adev);
 }
 
-int amdgpu_dm_irq_suspend(struct amdgpu_device *adev)
+void amdgpu_dm_irq_suspend(struct amdgpu_device *adev)
 {
 	int src;
 	struct list_head *hnd_list_h;
@@ -511,7 +511,6 @@ int amdgpu_dm_irq_suspend(struct amdgpu_device *adev)
 	}
 
 	DM_IRQ_TABLE_UNLOCK(adev, irq_table_flags);
-	return 0;
 }
 
 int amdgpu_dm_irq_resume_early(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.h
index 2349238a626b..c37bcd631e10 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.h
@@ -90,7 +90,7 @@ void amdgpu_dm_hpd_fini(struct amdgpu_device *adev);
  * amdgpu_dm_irq_suspend - disable ASIC interrupt during suspend.
  *
  */
-int amdgpu_dm_irq_suspend(struct amdgpu_device *adev);
+void amdgpu_dm_irq_suspend(struct amdgpu_device *adev);
 
 /**
  * amdgpu_dm_irq_resume_early - enable HPDRX ASIC interrupts during resume.
-- 
2.37.3

