Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1B5BC10F16
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Apr 2024 20:37:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 27C991124A6;
	Tue, 30 Apr 2024 20:37:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uqpMXSgk";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2056.outbound.protection.outlook.com [40.107.223.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D4171124A6
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Apr 2024 20:37:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HEwQ7LbsX0PzpPFSzQ1+HZIeb3n8LaO+W1E5zlRhlmxcXrkme9RBtt7U7/GvudcyBNnwK1NNTHNKlbJ/KklSSYdX1HarEkW+OIwQkvwU1v+mAaNzIAopb9HP/u4O4P97hD54T8mQ+kB1MQJB1jG+xgX+UJhmwXJ5wLQknPw1sqbyOj1OzN31COZI8HxerGERAhDloT4RfwPxIOhooubW3w7TutfToM4HiMQTItgfOTEJECeDfXW466lj1GAZ6fNHDshoFebCAY7eccjthg48EGD0+HFDLhfv7BmOitGkzZhHY5eYC4mu4yyGVyKy1Xbw3swLx+PCS/I0V1GTEqQayg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UHLBGFez7u+IeMa3XGnsAfoU1ZXb7buAgWJzCkfVQHk=;
 b=IfhUEm237QSScqaDmDTpNFhZdVepqsX5o0ecvGs0leSeej/R4NgKNQeHwaGlpRiEvrUuENrInPXUohaO+phH8vcoge7cA8xq6g7ErmeHC4s5UMEeZuch+9ev0n1m50eW6b4g7lh4XLVdlisPYpkmXisdNVBQnP1RxiiZEOIY+tOnxfO8fAR00jhdQQNKf5kweAaMgn0Jslzva6FboNhiM6pUNC8JF2koLWlAoJ+MrzZL3VOJTKXC+Y8kDa53tNygOeSk/9cc/akIcHtZooKxGf8GR2zollFUVJ5Utm1rQEILaNkySqQ2QjNGEg/woO5nAFqDY5v40AbW2egfUOjxqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UHLBGFez7u+IeMa3XGnsAfoU1ZXb7buAgWJzCkfVQHk=;
 b=uqpMXSgk3vvmf0RsfW+QV72FA3ycK17pu0L9xtrYGZ9SXbXS2f+psiDn9wJyXKXHh3s7usk8JEEeevuT5gLT2OEBr21iFT4A9V52a51RhJyCX7sep1KdKmPDNEhvjMZb6Ni2FtmGUS7tzgDojCn/jvYBXrC/acckmRqyLfpv2t4=
Received: from BY3PR05CA0003.namprd05.prod.outlook.com (2603:10b6:a03:254::8)
 by IA1PR12MB7567.namprd12.prod.outlook.com (2603:10b6:208:42d::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Tue, 30 Apr
 2024 20:37:34 +0000
Received: from CO1PEPF000042AC.namprd03.prod.outlook.com
 (2603:10b6:a03:254:cafe::63) by BY3PR05CA0003.outlook.office365.com
 (2603:10b6:a03:254::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.22 via Frontend
 Transport; Tue, 30 Apr 2024 20:37:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AC.mail.protection.outlook.com (10.167.243.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Tue, 30 Apr 2024 20:37:33 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 30 Apr
 2024 15:37:31 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Kenneth Feng <kenneth.feng@amd.com>, Jack Gui <Jack.Gui@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 3/4] drm/amd/pm: add tool log support on smu v14.0.2/3
Date: Tue, 30 Apr 2024 16:37:11 -0400
Message-ID: <20240430203712.800427-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240430203712.800427-1-alexander.deucher@amd.com>
References: <20240430203712.800427-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AC:EE_|IA1PR12MB7567:EE_
X-MS-Office365-Filtering-Correlation-Id: 68275523-a2d1-4790-b89d-08dc69555d50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400014|1800799015|376005|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rHq3FBqSpbVfQyJF3xXmCqcRXuDH7a0FcbEri0KdpaExNMAcx/xXYLFvydUa?=
 =?us-ascii?Q?2tk4MiINTbYnMN/n/0DvhYXZLgNBh2zTqZlBmHyIoyx92x96dJWQyVWs2vAf?=
 =?us-ascii?Q?p9Vij8YoNIpmURNSIPHKXSBEYLCTYz1JBZv8BGwmIwN/2/HLtyZ1LaD6oP8J?=
 =?us-ascii?Q?QEAzFun/s9AAAAgWR5xIdqzUeVrKHKO4DYpNcQ6AOgo7Zt3i6MosEETFI6Yl?=
 =?us-ascii?Q?nVKMRMpXXmxMl1J9o6bvm+xboMHa11IG5B6yGRkqMFGBHpS8LM/OwUNd6lXR?=
 =?us-ascii?Q?YejZgOdcctCpLlWWLc1Kwbpe35DfEMhhjsp15DHy/S5pnfj/bhJ9eoVVQZ1Y?=
 =?us-ascii?Q?gYn4t2IqaFi5fjFYsFqkxa0Ib7b4Rn579tnja4YSiVLXhgvPKN+VvTius4eT?=
 =?us-ascii?Q?1pioHNZ8hM+PsjoY+EOSMix5BHeEfke7WO1xp5KZEZkMmV5qWQ2WRmvtWqtk?=
 =?us-ascii?Q?l2IxIgBVGXqMo01XCqwDoipfFHY87/P2HVQVIIW196uYkI4cFBZAeUNNQ0wc?=
 =?us-ascii?Q?CaXodC3Y9jqFLUXcLIaunWfbCKYl6cxmk4t7G/8hUDYA+aDkcekBehUnErIh?=
 =?us-ascii?Q?u+5LlUG7GX1bXvPezcdI3Eo9NjD55G2f8ULT4HhXMPNgBf8rlO/BUgUgYbNx?=
 =?us-ascii?Q?7X9r60j463Fe22++rSSOGKwtvSlVsLkBapjCrubX743vfLfxWd5YzQXo5KKF?=
 =?us-ascii?Q?3vkaykrC/9X54zy9dV0M3cnb3bflgjXLJ0yMYfE0YFW4A0UTyZ8TfcSDrSfU?=
 =?us-ascii?Q?S8pJTTFlh2DtU/S6dlr2g1OZdiXbWgBaNr7guOKzA+gvVdEAZxtfFXI/SA3A?=
 =?us-ascii?Q?462FsEsdog5ltTttaQx/xADkRuaX+k2X5PgE03v94EsemLSg/yWPABa/XdD2?=
 =?us-ascii?Q?t/ySYVbD3FRKDRSxpcsNLhp74xXRgNgKQ5Qx8iT6IiXMU0dpwQa8c4zXKIRi?=
 =?us-ascii?Q?ufsWujgEsY9lKMRF1HYM1h2ScHDC5CPmF4JLX/Y6RIO+H4PYm6tZitto6mjH?=
 =?us-ascii?Q?ksbrVGOeTxgbODHGXxRtiP3p/eKiaVhTZuNH3agqKfBK/wzsor90F3MeFAEg?=
 =?us-ascii?Q?oifU62wQdjZ7UwrlP5T4a/Z30oMRD/ICNDnl5X4vIh033oIWoL1rvqmmbaVT?=
 =?us-ascii?Q?q199ZO1cia87NY601F80yyB4ZYtZPozI/+X1HFpw5vlAMsV4QTATuKcC67Ao?=
 =?us-ascii?Q?UP57wOMz22GMCA0AZoIwEusphHBmlYyzoczuYcd5dWkFvGP0GLcK0iCH5/fM?=
 =?us-ascii?Q?2i4IqlSqOLmNKhAnjmUVkKj7w2ShibPYaTy/xqP7k+GKbJNZHAcfxCClG6ab?=
 =?us-ascii?Q?oZBl3ipxeiOjj7wU9/aAFlSep3ASLewchFGi1cs0b8vkzfpvkodj5hm7pFYY?=
 =?us-ascii?Q?Rv7CncI4iYQgdjcuuWyYlPskpSRu?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(1800799015)(376005)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2024 20:37:33.7069 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 68275523-a2d1-4790-b89d-08dc69555d50
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7567
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

From: Kenneth Feng <kenneth.feng@amd.com>

add tool log support on smu v14.0.2/3

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
Reviewed-by: Jack Gui <Jack.Gui@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v14_0.h         | 2 ++
 drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v14_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v14_0.h
index 1fc4557e6fb44..2617d94b4c4de 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v14_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v14_0.h
@@ -46,6 +46,8 @@
 #define MAX_DPM_LEVELS 16
 #define MAX_PCIE_CONF 3
 
+#define SMU14_TOOL_SIZE			0x19000
+
 struct smu_14_0_max_sustainable_clocks {
 	uint32_t display_clock;
 	uint32_t phy_clock;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
index b5bd8dd38dfdf..83bca23c3ebee 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
@@ -465,6 +465,8 @@ static int smu_v14_0_2_tables_init(struct smu_context *smu)
 		       PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
 	SMU_TABLE_INIT(tables, SMU_TABLE_OVERDRIVE, sizeof(OverDriveTable_t),
 		       PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
+	SMU_TABLE_INIT(tables, SMU_TABLE_PMSTATUSLOG, SMU14_TOOL_SIZE,
+		       PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
 	SMU_TABLE_INIT(tables, SMU_TABLE_ACTIVITY_MONITOR_COEFF,
 		       sizeof(DpmActivityMonitorCoeffIntExternal_t), PAGE_SIZE,
 		       AMDGPU_GEM_DOMAIN_VRAM);
-- 
2.44.0

