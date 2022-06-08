Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1170CCA47F
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jun 2022 09:05:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F92610E023;
	Wed,  8 Jun 2022 09:05:51 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2088.outbound.protection.outlook.com [40.107.237.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E5F2D10E023
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Jun 2022 09:05:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lvQUyhZ5LLKbxynhOK1nH0v0UsO6pXx8zpQ+iMwFrLjzKA2EbDA9TjX/ICgoXKpnMajO1dMsMTIn4rDwxw3GExTzHfryi2TM5UUqpCSNJY7SnNg4SdPdvH1c9qx2Qs2os4IxVn3wt7sf/sKSeZdVNwI3T9Yoi8n1/mOtg8CpDc297kTSo0TnD4f+i/1FkVQ6xm3EyLDBudrlTo+Xviixn9HKFBGtiJalqIYfnJI+PC0rO1BesYh4x7oOIeQmWrkgb19ECTnc6Ilw3A050qIdQTsoUWD52MBYAThTaAm0sdZemX45ARsapdy5Y3LLn6IAKLqQmmCEYkSazFMfFtiLjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yHNzstg5knMzdHbQ5gZRJuK9BIzJ8bbLzgKOM9uwzLw=;
 b=YdYvPRXRMQpRL4C9aTe02lvm8/AfFFt2AyPqHypE3SXF411GVOc+/NgbSNQtQZbIexoZPjnRNWAYszuZIxzTUPYZ4ORqz6bJTZSk2Ec9dt37Ahbsph4fFbrjvkpM6WbHg5MzkGgZpoixzNPCZke6pkow6RABrDZHLjtkDiV76v45pu4ukpTxHx8B8nuvHChhhZbmIWObCon/JpL3LHCKBnbdkVxD0oWRWgJPQmDRtV5AUEDWEkXJiNXr436l7tVeND1MnVstlFwUVeubDon0WwzUeGDir4cKmsk5a06NdKLPe5gqxPVqz4MppquHGIqgzYgFGNROltZIgzrBl9OItQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yHNzstg5knMzdHbQ5gZRJuK9BIzJ8bbLzgKOM9uwzLw=;
 b=cJEEIJVWLBbm7+mDyEg3dN3wEGqHA+JjCeDRsXLI55lQEkSzkwwa+PHbSCVKFjvrp60atpt96cd+np/EuABPZzUOdL0ep7/W+2qCoV787Hrf8cNONSwRgWOR34w/TFBsQ0EQiIyVm3gpFhYMxd3Pwnl8Rw1A4clrCACWGJyTZYc=
Received: from MWHPR2001CA0017.namprd20.prod.outlook.com
 (2603:10b6:301:15::27) by DM6PR12MB3212.namprd12.prod.outlook.com
 (2603:10b6:5:186::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Wed, 8 Jun
 2022 09:05:46 +0000
Received: from CO1NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:15:cafe::84) by MWHPR2001CA0017.outlook.office365.com
 (2603:10b6:301:15::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.19 via Frontend
 Transport; Wed, 8 Jun 2022 09:05:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT055.mail.protection.outlook.com (10.13.175.129) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5314.12 via Frontend Transport; Wed, 8 Jun 2022 09:05:46 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 8 Jun
 2022 04:05:45 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 8 Jun
 2022 04:05:45 -0500
Received: from kenneth-u2004-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via
 Frontend Transport; Wed, 8 Jun 2022 04:05:44 -0500
From: Kenneth Feng <kenneth.feng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/5] drm/amd/pm: add interface to deallocate power_context for
 smu_v13_0_7
Date: Wed, 8 Jun 2022 17:05:32 +0800
Message-ID: <20220608090536.1969621-1-kenneth.feng@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9170692f-d3d5-450d-82a9-08da492e131a
X-MS-TrafficTypeDiagnostic: DM6PR12MB3212:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB3212005808E4136026700F0D8EA49@DM6PR12MB3212.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R06tNd/KeqeWRgY8uWOvM3gl9eABXfxiLpT+N2ym/k3ilgOlsDsL/T0puO1c5X6bqdHM1w71BrcLjmDJBXZ7o8oEIRsFzPqUv/Sw1U1bgr1LsaBcNQ2AEnonHB5emQ/XKydw6gs2cY1SJP56LN0tMjLmNDqsF9OOyU0xPhHgfoEX6zTKtXMEsDKKMI9i05HgBjPkE2Hgmoqc1oQFcoRWUf8zQEmxGwegiwTfLy+JwqQw8tAqvsBX2D639oW+ftizA34E8t7A4RLGcsxs9GfDY/I9YtJbnKWUNFcZwmhra5jTv/eMYYxLBmeo38mOcPrzr1ybomfeDyLgeUBLmJ0ph+zqH4S0kDfhoZXaGxr9LOW3dHoaKxgLlQbukTU5AAzkJWs8BMpiIJDvI0h35NoyEclgaF7uzQYA4O8NWAD/oF/zJVezmd6+mst19j48GjlspX1DBzXuneDn8Mtb/vHrKR5SQFekvx7Ri8hAIHNx76NbID5nvP9n272D+cxXLZN/J+BV8wCrI0iCBGdM3rDiMjDmCOuM/VU37kxIZIGFZ9Fpme5wL8Iss7+kQ0afoPXiHynWti45/VwDgkulZHExFS82uwbzjhjl/j0VvqQApKewINaeGHRSANw1vT1Cu12gD2VjOxnJhTdePZsKbQJkLPqhEFqYwkR3RKcl/fbTJDbvPDWXIi3RKBrp6DHSEDmChvh/i6z10QMCMCHR3dmlvg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(7696005)(6666004)(316002)(4326008)(8676002)(356005)(2906002)(5660300002)(40460700003)(36756003)(70206006)(8936002)(81166007)(70586007)(2616005)(26005)(336012)(426003)(1076003)(47076005)(186003)(508600001)(4744005)(44832011)(86362001)(82310400005)(36860700001)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2022 09:05:46.2455 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9170692f-d3d5-450d-82a9-08da492e131a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3212
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
Cc: Kenneth Feng <kenneth.feng@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

add interface to deallocate power_context for smu_v13_0_7

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index bdea7bca3805..7da42cae5d6e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -1541,6 +1541,7 @@ static const struct pptable_funcs smu_v13_0_7_ppt_funcs = {
 	.load_microcode = smu_v13_0_load_microcode,
 	.init_smc_tables = smu_v13_0_7_init_smc_tables,
 	.init_power = smu_v13_0_init_power,
+	.fini_power = smu_v13_0_fini_power,
 	.check_fw_status = smu_v13_0_7_check_fw_status,
 	.setup_pptable = smu_v13_0_7_setup_pptable,
 	.check_fw_version = smu_v13_0_check_fw_version,
-- 
2.25.1

