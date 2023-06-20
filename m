Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10F1CEB64D7
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jun 2023 17:16:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 352D610E2FD;
	Tue, 20 Jun 2023 17:16:36 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2042.outbound.protection.outlook.com [40.107.100.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0049210E2FC
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Jun 2023 17:16:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cyLv8iDmWAmUulpYz2ILoG0j/O3wKnFitar/2fqAXQk6ht4986uXWrxmoWeZSzFAXcNcLrHNu66BPWFqCODcSOuM/jDpCvDHINTTTHKSpf9NMjq1jgGepRqa839AucrhmhlTY0+nbSQ791O+64+RNn0RyRStuC7g0wXVKJ3AicN7Q2E6rnBUOmkbuhfMNEhzwoGq5HYvdhkIVpnM7u1QJoVrnthuAkuXu1J/qDT7O7QJpFgUuMaXYgloBj7X9KGYMsPZ/nnjX62edqTwBUciE2JvEXFJmiRQGv6o1NcSExAT2Drb3nj3YlNgxefdA/qMRJTACIX7MqbWFhOegJLrMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/nlhadS9dAI2O3PvvF6vvnRQPVBIiLZbfR3Ptca1a3A=;
 b=dWI8lT075rJOQzb/FZcaUctcKmgFQIuEuEmhjgOcs+vZT3Wwsfbs1NSEfi604V259/EnaFnYbJsLbqI6XtvkZeZsLD7qQ67mxz7FUmWUBTbEHTsO38vubAbk1hsMEYS1o2oGKSDfk+qERATZ5JnhcUAJPIvnPVXb94vwspAG//m91xyW5SWtwTy/35D0/dr9AQZPmKyZRJODFsROTV95kybZqiSTuRFk5aD9W81p/g4dUQSTYuixAkV02UkfAKrwO4haCbq2EjXW6FBOjYotE45sGB2g6OOLEuzqxGZS/r+vajY3O9sbvUDun9BFn/d9Qhx53NleaT1QOWWBFNwr7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/nlhadS9dAI2O3PvvF6vvnRQPVBIiLZbfR3Ptca1a3A=;
 b=bPgWJTLfO2OyNPxuZfX+Smi9YgxsDHISp7tZHGAvei27OINEvoHmmXlvM89YGPkDBLj4kWe/lMblsc82OvBdkZVSH9w9h85aet79eaK0QtAQCIQ6JBo1/toekCqGQU7QCi70efsAD92Vf075stgL66kuajVhWaW0et6d3zO+f8Q=
Received: from BYAPR07CA0071.namprd07.prod.outlook.com (2603:10b6:a03:60::48)
 by MN0PR12MB5906.namprd12.prod.outlook.com (2603:10b6:208:37a::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Tue, 20 Jun
 2023 17:16:31 +0000
Received: from DM6NAM11FT107.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:60:cafe::5a) by BYAPR07CA0071.outlook.office365.com
 (2603:10b6:a03:60::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.21 via Frontend
 Transport; Tue, 20 Jun 2023 17:16:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT107.mail.protection.outlook.com (10.13.172.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.37 via Frontend Transport; Tue, 20 Jun 2023 17:16:31 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 20 Jun
 2023 12:16:29 -0500
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 05/12] drm/amdgpu: initialize ttm for doorbells
Date: Tue, 20 Jun 2023 19:16:01 +0200
Message-ID: <20230620171608.2131-6-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
In-Reply-To: <20230620171608.2131-1-shashank.sharma@amd.com>
References: <20230620171608.2131-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT107:EE_|MN0PR12MB5906:EE_
X-MS-Office365-Filtering-Correlation-Id: 95e1ee94-9a4d-4151-fe63-08db71b2173e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VcIfgg4/HN/BQ+k4TQFboTTYt7esIjuV9Xmkp9aSZml/2T1HiEyOYwWxftOzv1AvvpUkfHJ5wx4HshXvxlUyp+0zYP6T/M7sELjppR2f0r2ObuAgsWP50PioAbXSSuL4xuSLuxPhgTLNzt3rvdQbqeujNtt9miYwjaK+2+wA5JDdIrSHopBIl57gE4nGyS8i1D6gLF32glwgTPV5ez19mXp/ZuKbGk/Jm/wvsjCDQU1mkKZQf8wpNIhLStkrt6ApOUlAQ2JrH0dUWELLVy1Ac83fMWNeszTSLgEjuzFva5dMOLAq2ZUcc9FJko7CNkN8bI71K/ky6Sp3WqGQVb6D99PiLryrJpPBeI1kddRDZ5uKriSpFag8XJTGcxoNgsLpKfYjdbCZ95bn0OIVShlM9tL1hw2U8gCvdio/VUol83OzJCX5URV6v2MYrybcofHZjoBogDOgbZhQSIk6e2vtD0jENG/7lfaBnxyfw/rwM4qihAG+Io7XT/QnrwFYiTCvmSLqe0T4ImBD1AJkfm7leDwG0gbNKjBzILzTDWV7mXgOsFbx/HHNxaIFiRaOnTQEekuzwq8VP5TOzeQUnrlBmJCOWh+teTuY22vx2y+jYCGYAzw8S85cHO3u4ajm0uZ22lFUHjTiH/SVKeMNjDL76vOvk+Iht8gzR9fH8sT62p7Lru0XVBiKn0QNEao9qNdmtwu4Qwqot5yZkddUpwi5simFa2+ENUEhOCfwJjWZ0z2fJW5kMJ924fWvdMXNicyfmDnQ9w8/X5IhSBAjrbALag==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(396003)(346002)(376002)(39860400002)(451199021)(36840700001)(40470700004)(46966006)(82310400005)(44832011)(336012)(426003)(47076005)(86362001)(41300700001)(8936002)(8676002)(70586007)(5660300002)(6916009)(316002)(70206006)(82740400003)(36860700001)(2616005)(81166007)(356005)(26005)(40460700003)(1076003)(40480700001)(6666004)(16526019)(186003)(478600001)(7696005)(54906003)(4326008)(2906002)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2023 17:16:31.0397 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 95e1ee94-9a4d-4151-fe63-08db71b2173e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT107.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5906
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Christian Koenig <christian.koenig@amd.com>, arvind.yadav@amd.com,
 Shashank Sharma <shashank.sharma@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch initialzes the ttm resource manager for doorbells.

V2: Do not round up doorbell size (Alex)

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Reviewed-by: Christian Koenig <christian.koenig@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 29066e9a3439..6d1587bbda52 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1847,6 +1847,13 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
 	DRM_INFO("amdgpu: %uM of GTT memory ready.\n",
 		 (unsigned)(gtt_size / (1024 * 1024)));
 
+	/* Initiailize doorbell pool on PCI BAR */
+	r = amdgpu_ttm_init_on_chip(adev, AMDGPU_PL_DOORBELL, adev->doorbell.size / PAGE_SIZE);
+	if (r) {
+		DRM_ERROR("Failed initializing doorbell heap.\n");
+		return r;
+	}
+
 	/* Initialize preemptible memory pool */
 	r = amdgpu_preempt_mgr_init(adev);
 	if (r) {
-- 
2.40.1

