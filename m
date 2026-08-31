Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9E1AC61DD3
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2026 18:28:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 68B4210EA5A;
	Mon, 31 Aug 2026 18:28:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YPngN1AM";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012066.outbound.protection.outlook.com [52.101.43.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6FBB10EA53
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2026 18:28:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uCPgypg5X4dlhZ33BeNUYXZA9DVSyFaYtyeLzL8HJnWQqCQwmEE3rEhQy6tKSbAK3e6UrxIvhlNgLaHKkTBlfueKwyWyBWnuOq+MSU0y3OlIFLbdDRvLHdbFehK08R6CcAF3C75yQdoLmdS8tr+P4JbxQUHqD/wNVd/s3/WMP3WwkzsL3sWWhAyXG3LD+25Ezinl007oM1LR1Nl/aTnHrT4idjDLkI8G72Uj7e1/ej3LLLeDXKlyuEzitojRrGgb+JmxMDrI5C3xbnzvQ6wCr51C1nNxAo/ERXjjO7h518LL6TnUb3dp3HRLBOLOkNL2Z4cAWZLVeJWacur8zK8BaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SlksjwC/Ucgj/puVPU89BqTWo1aEetN6QOdgunLAkmQ=;
 b=gfUCXSM3L8cvQ7e2oTHP+cnXsVi8FIafO/7Vl33uRzh+JAlxoaMxj1zQGPvjam+1hAYa/in6IkdLQb9FaEizUsbpkHNui0sw5JvaJhHHMsGU1M9yZav9xxSUDecIrhrrbba22e7gKSX5TOPJHoPgeQMC4M98vFXKjkVxErcHinXIGw9vgRkBCFpYvOVbHmnlRSoor1VneL2FFsxMBr4/N3kMGu5G/diUcBv7tjcQUZpXpyZCD147aKP1bXNTkHizOpxc7Y3Uzexd+nStHFaCdfFa0IYx7ciWb23P8wYf2kUDfPSyuFanyMBWwBbMW756SuWFhPl0Y4mOlcxh3aT0Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SlksjwC/Ucgj/puVPU89BqTWo1aEetN6QOdgunLAkmQ=;
 b=YPngN1AMDUWNlkIcG7YVNdM46dlNA7K5zQKZBPFsz7yU5q3nx8Is6JYSrk9qModrnTawbHdNsP3He2q/WqenwkbyoR5KchN8Glj8ilf5LaFFivN0bcx57mgvFgPqLp4kuSc//R3+e4YoDyo3BX6TAmvkwof3FdEi0ZZ2Zk2TvaI=
Received: from BN1PR14CA0023.namprd14.prod.outlook.com (2603:10b6:408:e3::28)
 by SJ2PR12MB8808.namprd12.prod.outlook.com (2603:10b6:a03:4d0::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 18:28:34 +0000
Received: from BN3PEPF0000B075.namprd04.prod.outlook.com
 (2603:10b6:408:e3:cafe::68) by BN1PR14CA0023.outlook.office365.com
 (2603:10b6:408:e3::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Mon,
 31 Aug 2026 18:28:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B075.mail.protection.outlook.com (10.167.243.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Mon, 31 Aug 2026 18:28:34 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 13:28:19 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Mon, 31 Aug 2026 13:28:18 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>, Felix Kuehling
 <felix.kuehling@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 20/95] drm/amdgpu: Add ual_config_state to ual_get_config
Date: Mon, 31 Aug 2026 14:26:39 -0400
Message-ID: <20260831182754.1089811-21-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831182754.1089811-1-alexander.deucher@amd.com>
References: <20260831182754.1089811-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B075:EE_|SJ2PR12MB8808:EE_
X-MS-Office365-Filtering-Correlation-Id: b70b8cae-3be8-4747-600b-08df078daa6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|1800799024|376014|82310400026|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: LqIdcAjJQ/8D1rsYVajQoac9WkZMWbhKrRy7cbaVOeVm0DpLlVq5LeIx0luKup/kneZDa5SKXLU8rZGMuhIjPWJK69cwRJ6HL3+vAb0+dvTBIHLh3BcxkZcxMeUuFV2T+qOkQHvi38caxSv3LNi1k3b2HB6bg4zPxfZzEYkYe9879QGeza0Js54qZya2Sq4fpmoiJyZsvSBSnAdBeU5Als9vNt7JXna22glMV+MHdvTyN5AfiHU39FIcb99HBg3BbwW4YnBjQW9jnDw6RD4aD+YM2jKboTxeTixjjgeMjeiWZnsODLZIpC+mCPOVcAMeKzY4vbWdV7WHqlkarTup+Mb0ZwfMdNBQmUO2mKAWA8oxO7kZhSNTLiVLlmaJh0F2QTIRakIyQMCQybXA5ySe8s1YVB9uZsAlAyjpiIWRst9acKzVXPPJlxfApSQBvjEmqQ99RoDMKeReABjZAKmxyYr/Mjvp/mXNgXAO6QDYvlY1DAfexFzQhai/odLnCnAQIIzHb7kdE+RFvP62oNK1PXWwnvQb7yG2AQQEk2pwLCyGBPKWJlWdrLFo4Ta71iqJMV8TZYQFFnHXVyDHTRo78JTInybHbPnphAB0gg/1EQQBJQR25hSL+x38k93GB9zfM1C6PP9rrVss0VdgmIw6KYuwkJCQJjbzMdT5HoAHFOIcyJB/cr9FVAbYmUpUEVtkVk2/GUsx+MkDUbihILNOxg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(1800799024)(376014)(82310400026)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ijkq1Bh7FzPFZriKYYpGVvYpD6Z+sYZTt67vz05iWUl7iBoT04P7GSfqpOsVvLLOaf+sIL01G3L7BUmR1m+mK7zpAP0FS+UGqreM9i2uabAjSxt+8vT/kR3ZzHZq9JMZOp60aOdk3qOQEFOMQsPwlLX4yR1EIrVaYlPhAaf9lLVWiaXkkvlNPeybhKQHW4wG9XAxQAayiYidX0y/HXe0Z+kYlw/3uZHlxryDIX4brjw2qYLmmTrjB82O6A4XGGpCoZ1Kn6HrLlqrHpuC0wuBrnD2Cne6ngUQsRyHyVqmKdDBpDOPEPqCJ75O1PdVPWtV2C05jJh6M27ibY0Q9PX7kfKC8Tr4erTjw3SVJ9duO1mW1Zjg0CniQoS/rsZYPKNcgBnoekqRhHbzWrQNLOW5r1O9bkb+LKig5UGdxvPowogGgzVvuvmy1aCroqr3gpQJ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 18:28:34.0612 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b70b8cae-3be8-4747-600b-08df078daa6e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B075.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8808
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

From: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>

Add psp_gfx_ual_config_state

Signed-off-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h b/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h
index 6bcc04109d4cb..77be21c3eada3 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h
+++ b/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h
@@ -421,6 +421,17 @@ enum psp_gfx_ual_link_type
     PSP_GFX_UALMAX
 };
 
+enum psp_gfx_ual_config_state
+{
+	UAL_CFG_IDLE        = 0,
+	UAL_CFG_PPOD        = 1,
+	UAL_CFG_VPOD        = 2,
+	UAL_CFG_PAUSE       = 3,
+	UAL_CFG_STATION     = 4,
+	UAL_CFG_COMPLETE    = 5,
+	UAL_CFG_INVALID     = 0xFF
+};
+
 struct psp_gfx_cmd_set_ppod_config_ual_v1
 {
     uint32_t accelerator_id;     // Accelerator ID
@@ -477,6 +488,7 @@ struct psp_gfx_get_config_ual_v1 {
     uint32_t vpod_size;
     uint32_t vpod_active_accelerators[PSP_GFX_UAL_MAX_ACC_BIT_MASK];
     enum psp_gfx_ual_npa_address_mode addr_mode;
+    enum psp_gfx_ual_config_state config_state;
 };
 
 struct psp_gfx_cmd_send_completion_ual_v1
-- 
2.55.0

