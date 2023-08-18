Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89700EE498E
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Aug 2023 19:20:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 063E010E0F0;
	Fri, 18 Aug 2023 19:20:55 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2054.outbound.protection.outlook.com [40.107.212.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A15110E0F0
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Aug 2023 19:20:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kjShRXHNtjS1WGzCWyJ6mXutgbscecmeQYHtzPSOipIVYyuOJbHG9kd8XfKRfozDrpHC57OKkI3I0vusraHstVOr5/6EhFcvGdcpw3cinCV+0MbymX8IqeXS3WHgKXmX3fE7zglmLpE93eg+vJiasJSck/CYBb12dWgZM2PyqBDgfAIqtrwgr/nhITjwbJ9FEdQKh1LrtDZlpj0k3wqBUJJxzRC2dXul/mk6DBWJ0mmSAaYjN4Bqv9ybZXP6Lt7nCNHbP2GYAH45iVU8JEHN5lFti4awWRBsk6RfuQMnow1hJzVav2UPZCl54Jhq/obt5hhjcCXF8r0U/B2duu4aGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=96HZPWKxBieddfmL65zojwQjRJWrXdtgv1fR3aGPcZA=;
 b=KpV26lVOjrbSHcgoputtza2PDfFeNHvns2/9FqU5ri/38D6vMIjbmr5R+zIX9uEbArP6l7FPK3dmkVs0v5+2gyzsYHep4Rtr/psjf2Gtr9FU13mjIWLaoCWdVL4kJF3uc4MGXJ4F1jZUuWLtiUMQpY+/eQILhzLdUcUD87R153DbDxWddAslERC2bAq4dbOUiXQ7IgrN/yKk/UVjIN32wYuN7/zg2Eqkt7DW9welaO0BR4Iah/lmNuqGrUDkODaJ2LM3XUw+C/m/VkEKAPa9E8w9PUslxop36NhOlX5cpwS6MCvLbPAiuyUfj9Qe/tQm9H+Mp01H0g7oCJM5cP1jHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=96HZPWKxBieddfmL65zojwQjRJWrXdtgv1fR3aGPcZA=;
 b=ZeNDNIJRQB/UD+nSGBb++Xm0n39Tec1lw9s1I0aZ7Tyc4e02mf6jESkfNl9/vw2Dhf2lhEYOj6pmK4cyW0tUZ2FukHjFDqvI7J9hSeemrSph9+lFWPy51/F9c+XUTbycUjdeRcYlmnFURrFq7ebqkMrpujCVvuWjDb+GJ1EIHtE=
Received: from SJ0PR13CA0085.namprd13.prod.outlook.com (2603:10b6:a03:2c4::30)
 by CY8PR12MB7196.namprd12.prod.outlook.com (2603:10b6:930:58::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Fri, 18 Aug
 2023 19:20:48 +0000
Received: from MWH0EPF000989EA.namprd02.prod.outlook.com
 (2603:10b6:a03:2c4:cafe::7a) by SJ0PR13CA0085.outlook.office365.com
 (2603:10b6:a03:2c4::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.14 via Frontend
 Transport; Fri, 18 Aug 2023 19:20:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989EA.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Fri, 18 Aug 2023 19:20:47 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 18 Aug
 2023 14:20:46 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: fix debugfs pm_info output
Date: Fri, 18 Aug 2023 15:20:35 -0400
Message-ID: <20230818192035.10756-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EA:EE_|CY8PR12MB7196:EE_
X-MS-Office365-Filtering-Correlation-Id: b7d92e77-8566-4c2d-9e59-08dba0203a54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0K5enpZen7gPITz5kRNi5N40Ma4s+7YSt5KBZQCVo8NPgIMJFRVsmUDssso8C6C7lFdPpdTP+YEVUyvE6FQojGm0CNc6ZrjgB0XEuk0+JAl4iBkkLnTZUiIav97x3hfke5il3FCE2Svbq0F5685GasgtZFCTviSHzfrLtbevNwOf7TVxpfb9QlzmEn93WfL6qJ2wG7Z7iVPxNXSjdxodkvIurgifCaDZM+2SwyOhi7eOi/kDa/5k++nKjJabUVVM3dOEyNitVA4Ca11Amh70qj+gDeldEunaaJrBeKYaDoR4IhbWrLvvkJUwYjhMd6aRlT6hiiVJSBjPdcrVUhppuA2wNtKGukZUHHUNjKE7iBl2EV/PESN42jhLsdu2T+bWcWImnLmBY3r5JEGGGzlGGq23nZbNdjRYkNAYt09UHUnEMvoyYSiLI6mY14oskhtRzavgrdjcFpqwsz66itq7mukVs7EZJSO+5mBLAXDez2/Syj3NMi2BgbhW7i06ODXlZEg/5n1y7GwWIMoqeFayAJVH1r1KpSH4Q59PWZeuHTEzsdvs+7DP+sd7FZogW02o/BnxVUj9IQvcMbHsIuI1So/J3SE3KsQT/drYrFOr/o4dw6hZjuojgBS9iOmgaJJeVmpr/Bz6VsYMYtDZH6BQrGzrLXDBqiAFj4sfxXhFQ/e0fluAKqTC6cfAsp2bAqtdXbfEomBvQrTC6zICe9u06pEgrn0L3RTI693LuD7tVyVUzXaxa8C0930N4CFKT7dtit09/0VijOkV9WjTCnlHWQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(39860400002)(346002)(136003)(396003)(451199024)(186009)(1800799009)(82310400011)(40470700004)(46966006)(36840700001)(86362001)(70206006)(70586007)(5660300002)(2616005)(41300700001)(4744005)(2906002)(316002)(6916009)(8676002)(8936002)(4326008)(478600001)(40460700003)(6666004)(7696005)(36756003)(82740400003)(356005)(81166007)(47076005)(16526019)(336012)(426003)(36860700001)(1076003)(26005)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2023 19:20:47.9360 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7d92e77-8566-4c2d-9e59-08dba0203a54
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989EA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7196
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

Print both input and avg power.

Fixes: 47f1724db4fe ("drm/amd: Introduce `AMDGPU_PP_SENSOR_GPU_INPUT_POWER`")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 5b1d73b00ef7..1c3745b3ca85 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -3471,6 +3471,9 @@ static int amdgpu_debugfs_pm_info_pp(struct seq_file *m, struct amdgpu_device *a
 	size = sizeof(uint32_t);
 	if (!amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_GPU_AVG_POWER, (void *)&query, &size))
 		seq_printf(m, "\t%u.%u W (average GPU)\n", query >> 8, query & 0xff);
+	size = sizeof(uint32_t);
+	if (!amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_GPU_INPUT_POWER, (void *)&query, &size))
+		seq_printf(m, "\t%u.%u W (current GPU)\n", query >> 8, query & 0xff);
 	size = sizeof(value);
 	seq_printf(m, "\n");
 
-- 
2.41.0

