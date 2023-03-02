Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A08C0C678D4
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Mar 2023 17:04:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B02A10E4C0;
	Thu,  2 Mar 2023 17:04:42 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C55210E4C0
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Mar 2023 17:04:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZXQu7ty9ajO8W9Z4hVkTdj/f+aiIFl5YZzttkg5vsUC7ovqm5SLk5kGY6wcXsuSnSJwqr+2+POtbisqsGbs5FX0Oo/ChdhlPFvYV9w2tMtaXfip8TQGuCeOVTv1VMRM5v8H+ZV8ExWA70YNPyx0XcQeA2mNOYvTtQtKNkknbm9Bodd6BJMI1xIHsQDiINLfXeufvL/6+vWW2y1izphGAICMg/2k0g/9ovT9cJmRUsanFlWQfasoFwetFxaZ/p/mQ52GTOzkwQlMkzo+ZKP9ccv0cKZHnWBU5wTewOpukWLomwPshuAz5LKIS7aPVY+tbBbZEVNR1z7VcFpIMhjNkCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KFChbeAiWBnz+0k9/DRbxpAKwd3wpgg6fFfg5mrHv2k=;
 b=GpRdJymNJs/WAslaWNhE4TXmxeT7R+kgzfXJpUXsCLEugjFpNDHYhpGVec37VXOWCV8S7EJEgOH6+XR/OOtBpDICHlWLxiE77Ah4lSx9PFiPkwAMkHh+1m/HM59h49Sh1fl/vfKNrbzD3VxUhma68A7VZQlXZe1/yhsaRr3PwxDLxJtiY3+PQa7zSj/bUe5JEaL0sW2Lb5DLM4HKhmItrrztFSe8MNQrpTJPvkj4OCV9kvej76TnweSZvQ+yDrN37ktoZ8/d6VjZytvroeO2Y1rBJrDbuGm5XEc4OvJCo4Utpjsnpex8JXYeMy5tNH/x7WPU1Hgd+Oxn8OnMaiEM7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KFChbeAiWBnz+0k9/DRbxpAKwd3wpgg6fFfg5mrHv2k=;
 b=lgn17UE6yCxdpdGgBH2OFEipRiPkDzlG2QjS3ivlWt3YrFrf4em5G1BdLuFXDe/VTp4/AFxbNddIJooXqcwPmIgbdt8YISB4zLNO5hlEHFPRR+i+dW3egLzdG4WaLr2DAOHhAUNEtSIafZMJeOk0EvWreFxQTHPJCqudFSLrELo=
Received: from MW4PR04CA0241.namprd04.prod.outlook.com (2603:10b6:303:88::6)
 by IA0PR12MB7579.namprd12.prod.outlook.com (2603:10b6:208:43c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.30; Thu, 2 Mar
 2023 17:04:37 +0000
Received: from CO1NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:88:cafe::87) by MW4PR04CA0241.outlook.office365.com
 (2603:10b6:303:88::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.20 via Frontend
 Transport; Thu, 2 Mar 2023 17:04:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT018.mail.protection.outlook.com (10.13.175.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6156.20 via Frontend Transport; Thu, 2 Mar 2023 17:04:37 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 2 Mar
 2023 11:04:32 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 4/4] drm/amdgpu: add PSP ip block for PSP 13.0.6
Date: Thu, 2 Mar 2023 12:04:01 -0500
Message-ID: <20230302170401.20386-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230302170401.20386-1-alexander.deucher@amd.com>
References: <20230302170401.20386-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT018:EE_|IA0PR12MB7579:EE_
X-MS-Office365-Filtering-Correlation-Id: ae50c07b-7a6b-4c60-8d66-08db1b40344f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Osl+cj17R0DFXJAI4aq9F6h3fJsucy6Kowq/8OwEUEgNbzqgLihKuL84n/ox2SLnDPrS0DAXPN0Zb8O1lqJOZLJ8MQcBd2o5xkXfU4jxSUs/SMxwwVtMhVtuXfWXOAZW7HZgf2Ii82Ec85LBU0dekAUAJU4mYbhXYvo+Yhd8n/5VvXyreNokZm90wTToK9tUvYk6yp1b+HqmqXebRjsofjDNZqf9MPZ40HS7hW/RCHfGfOYPg5Vv9pb8dXDuo7g50njmPZyBFAhIv51m5GrvPIwaxeabPS9r9zxHyrZQDzQ7ZrkNdVpdafhuoMm48SbFN3/KiMpuWMaUPRF4dbjBE0ZJoR8cV5QR+tEpFvwrXYc9JEBPs7VglSSyv2wUVJJICrAzMvnorjPKOXURPH2XqrQH62VT56SBMGmv2KplHhU0sDVz+4vYYw2s35HI4XwOr8vCvHAOqaAPKNiJtt/2eC23keDnNtJT56UaTPoRAQXD+HIljuvACNRXJkq6bgprJtyjfX41AS1+480re1hP3fwnv6u6tGCTmVaDk7UTIq/4he2RoQhE5KBGqmjJGkxcfMg3/+D7/l2lZFFyEqA5Q8IT/Auef/s/V443BnYoJamW1Vp/nHYx9x0k47NNkXJMVyvA1Egjv48UyEj/2jFgxBz1sq2s6+4tr5GE0xzVh+XY5DwgOr1d5XsS+UKoUV4nOYB8L96DdbFh6xNbsXZRf9NBZNr5osD7CA0iIb4dss4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(39860400002)(396003)(346002)(136003)(376002)(451199018)(36840700001)(40470700004)(46966006)(86362001)(40480700001)(8676002)(8936002)(41300700001)(36860700001)(4326008)(6916009)(5660300002)(2906002)(81166007)(356005)(36756003)(82740400003)(7696005)(6666004)(316002)(478600001)(4744005)(54906003)(2616005)(70586007)(70206006)(82310400005)(426003)(83380400001)(47076005)(336012)(40460700003)(1076003)(186003)(16526019)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2023 17:04:37.1136 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae50c07b-7a6b-4c60-8d66-08db1b40344f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7579
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Le Ma <Le.Ma@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Hawking Zhang <Hawking.Zhang@amd.com>

Add PSP IP handling for PSP 13.0.6

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Le Ma <Le.Ma@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index c8507731ce7f..1c9261b11ed4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -1643,6 +1643,7 @@ static int amdgpu_discovery_set_psp_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(13, 0, 2):
 	case IP_VERSION(13, 0, 3):
 	case IP_VERSION(13, 0, 5):
+	case IP_VERSION(13, 0, 6):
 	case IP_VERSION(13, 0, 7):
 	case IP_VERSION(13, 0, 8):
 	case IP_VERSION(13, 0, 10):
-- 
2.39.2

