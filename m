Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EA75C4332F
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Nov 2022 16:54:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6638710E4DE;
	Wed, 16 Nov 2022 16:54:26 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 76FC510E4DE
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Nov 2022 16:54:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=af2497AkYhYRv8mTNhSp7A+z+1kmzzZvVu9KXMv2teDSQ9zC8ibBThQPHkM9234i1PUYOrP85nhlI2OqITVdtg+LZQoLEjQGLpcloZXoxRaoaU0Ga1E0WvHqRzRp7UtydsV1jwEcG6ZenqIkaQTXiJxNQ+EFBr0NgzeFzqw5njo5x734Xtt1ZL0lcbpmOJKF/W+tCfuUxvdKWpqLqxsB+R9MR7P8aDfTsaHGCCCIiv0OAqGJEH09JnAdYgMiEHLH1FQL6IZsMvZ56KO3sOe6tcz3lRV4aTz4DJmr8SNiJdh37u6T4wGRxFFqAZltp15fh74k2OWZTOD2oF1bb35m7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cMI4g8tN1L8RJhshyyUWQVqOdnSKKO78T64n2LzKYoM=;
 b=HqRb7lhH+awUProp8+gBDlLEyVZLCqryqOAQgKxi0IlaAQT1tMVvJdb6eRyh59Hvn8HV5f158R38Cf7QUiuOrR84aPRZ9lEKlu+rcAsShqeLkxBsx+VVWL04O7FJVDx2uUDe89q/Fal9hsL+TBhL61ZZHBvjBh94FzFgcmKzE4po/09bL7lekWYszr3dA3cExDhqUgr22Xax92hq83cyiYsOPE9AsT3liT8NN+rGBgtHfKMZV/GH3YcRr3OAHGVSAdEfFFVbvPgiZvlAg2ZQZc2h9gOhk9zea1KOA09gOa8Dxd1SgbCjo76eObVQil2K+9Zy7d+LRMrBsVz5O90Obg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cMI4g8tN1L8RJhshyyUWQVqOdnSKKO78T64n2LzKYoM=;
 b=PhDBclavtudVOwD49Lvth3RaaCvbJj5h9a5EX+wfZ+BJT2zCp7yucVpZOc/rZxPVTwm/Ds+ZBc1CxTgG5G1+tIn7xq5tZ0pcPRUByrrzzzShi8gEnHVtkYnM7F1C5tSmCRENnhdZbWNsK2rhwVKHgID6LMxYhLSnHh8ANZuYd04=
Received: from BN9PR03CA0874.namprd03.prod.outlook.com (2603:10b6:408:13c::9)
 by MW4PR12MB6732.namprd12.prod.outlook.com (2603:10b6:303:1ea::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13; Wed, 16 Nov
 2022 16:54:17 +0000
Received: from BN8NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13c:cafe::91) by BN9PR03CA0874.outlook.office365.com
 (2603:10b6:408:13c::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.19 via Frontend
 Transport; Wed, 16 Nov 2022 16:54:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT054.mail.protection.outlook.com (10.13.177.102) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5834.8 via Frontend Transport; Wed, 16 Nov 2022 16:54:16 +0000
Received: from RErrabolDevMach.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 16 Nov
 2022 10:54:16 -0600
From: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Enable Aldebaran devices to report CU Occupancy
Date: Wed, 16 Nov 2022 10:54:07 -0600
Message-ID: <20221116165407.2285608-1-Ramesh.Errabolu@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT054:EE_|MW4PR12MB6732:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e4d16b1-2e20-45ee-16c2-08dac7f332bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l8Eh5ELOE1n/s895+Sg0Q0PNuc5Mor0Fks1iZFVIcF2MxnhsiRl8A+aWg99zwhszKoVK/cnlqG9M2sEwXA5R4xzTlLQHCOG08O2Dl0SeXdvUJZ+meTx+GUkbCvV136BiaLHyiYeJyuqPrAlYrPL5Olwxec+iI5Li9Tdgqb3pejfY1cQ2JcY0zCLslj2Ug+9tc0AFokRWjbBM1oGzyKwn1hrYv0IdJkY64HpV2FnGwcGU0B15HDg8kv0GlLIzc02O6C90gNxdsh1zknd8FCl/FvkoGPJA//a8laI/MiMk6ctPC7iAmT222Rg7IjgHcwewcvvJrFIgEhsECTQHaBWz7xBje0eOjOE7I9a0RhvXbTPNldokJ+1en7yDrDyYki6/Jw/uLVEAoIzTHFmZW+Wf2g2rHrsFm+9F0wxS4uLkZjX6Ra1i8QHvCWeorJx+MJI0TJ4JoP5xRW063lg6/qxcwDjyUfgN7Zj9QYpAt0srmzO20ntAzc6DU3Bzt0ra+BCJgN9OF9Nm26pMXp0ZhDDjw22jul9QNztJ7MGyt2YZsTXubdlM4xl9M10f9EYDz3x7eyzi34klxhhbB8qdeRB/IZSeEpMsZhq49KQx6YXIEOj4Mu7JAqXoNCuO0DvSp6s3nPwXrrZmhtdgjb/BET3HuUa17FEBRYOEdK54o4Tp32qU6O0uRO2fF9hlKyTY5T9YVGm1MMwFg7cDWT+J7QAQJdqhGUyhFZlmWHb6saO3Vme/GOUrJQxYtX8UKWTdhHYMsUgNrhmfrfmGnX5ilIpY94+9dA1SBEOeQvi/yPZu5vMOQrkLQ+0b4LbXaDUgrfdC
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(376002)(136003)(396003)(346002)(451199015)(36840700001)(46966006)(40470700004)(8676002)(4326008)(70206006)(70586007)(316002)(6916009)(356005)(36860700001)(5660300002)(8936002)(36756003)(86362001)(2616005)(41300700001)(336012)(186003)(47076005)(16526019)(81166007)(26005)(1076003)(83380400001)(6666004)(7696005)(82310400005)(40460700003)(426003)(4744005)(478600001)(82740400003)(40480700001)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2022 16:54:16.8111 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e4d16b1-2e20-45ee-16c2-08dac7f332bd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6732
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
Cc: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Allow user to know number of compute units (CU) that are in use at any
given moment. Enable access to the method kgd_gfx_v9_get_cu_occupancy
that computes CU occupancy.

Signed-off-by: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
index c8935d718207..4485bb29bec9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
@@ -41,5 +41,6 @@ const struct kfd2kgd_calls aldebaran_kfd2kgd = {
 	.get_atc_vmid_pasid_mapping_info =
 				kgd_gfx_v9_get_atc_vmid_pasid_mapping_info,
 	.set_vm_context_page_table_base = kgd_gfx_v9_set_vm_context_page_table_base,
+	.get_cu_occupancy = kgd_gfx_v9_get_cu_occupancy,
 	.program_trap_handler_settings = kgd_gfx_v9_program_trap_handler_settings
 };
-- 
2.35.1

