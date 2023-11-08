Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83F8AC4332F
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Nov 2023 19:38:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA9F110E17C;
	Wed,  8 Nov 2023 19:38:22 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2060b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::60b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 12FA110E195
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Nov 2023 19:38:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZHO9Hxk8ellaG6F/o1EFdQIZCNAeGo518kUlcNO2nNWE5CPlyqCYUHxVsjnvt2Teblw5tD5q/fl/dGhDHaWZ7ce0DxlUG23KtDyINU8N37h1A8ZArZ/6pTL4HwQ2lwrMzG6olZs/mA7yOMGyPgKxPkcaJITiFo0wTciB6qyjRuycWfXNFRRkhNTNgPvxx4UBYS5QRnycHqsWrvlkrIUC5f+9ekWziWHZtuKt5trDhrU+bpGayP33e5hS/Cp/pvQb/0cQUm/pymYtvcbPhv55fHQMD3duZgvkfh8LbrBbB9jCI1iV86LoUTPq5etQuwx5lI3GAbB6Nw2c2edEF5noVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V7GGAUyE8Gg3adAnVmkN5r1qFUV4GJjHbOFkw3bOZ2k=;
 b=KxBa+XIOgG/WUoh9MIAj34/gluhehD/KU2fFs2dEsK8IL9aOinxs8SkiZD0OGlqR9MX2ITW3Br1t+m3hUNy7dTykIOyQNZ5iPKNi4SMvK9QWnoeUsMmBr7Eg+xG44RhoaPdnJlxVL4TdH2c2/s2FTKCgb0SYg2hjMrKt02bTwAkpo0l8zlYcirris93Hei76nmANsf39Z+VEz5yXHqMrgMiMZ3kDKSuBEoNY2HEVsGupVT+TQDI7/EnOITuxxfPtu5pzW4tEwRxJRXcGC27GhWbeHpP8HvzcVNTGotocEWeW2GU9jcI9iSUyxTMbmyoiiAxzoH9NDQ+mE+mBoiWpig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V7GGAUyE8Gg3adAnVmkN5r1qFUV4GJjHbOFkw3bOZ2k=;
 b=0Z9vjvFFdTFKwC2rJgiW79sP2JGtz/1bf88lEkHLRr+jv9VbdK61WeQK/+ReUzDnYNJyPKR+IURQUrT/qFbvt/aYsC/iRDK0OH4th6arpGnB0dVLsGLeQmMlDwoPGN7GoOolOILFGfRMPXE5bD9mUSnd96QFIPhoGczyd6hnvak=
Received: from MW4PR04CA0224.namprd04.prod.outlook.com (2603:10b6:303:87::19)
 by DM4PR12MB6182.namprd12.prod.outlook.com (2603:10b6:8:a8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Wed, 8 Nov
 2023 19:37:59 +0000
Received: from CO1PEPF000042AB.namprd03.prod.outlook.com
 (2603:10b6:303:87:cafe::fa) by MW4PR04CA0224.outlook.office365.com
 (2603:10b6:303:87::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.18 via Frontend
 Transport; Wed, 8 Nov 2023 19:37:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AB.mail.protection.outlook.com (10.167.243.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6977.16 via Frontend Transport; Wed, 8 Nov 2023 19:37:59 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 8 Nov 2023 13:37:55 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Aurabindo Pillai <aurabindo.pillai@amd.com>, Rodrigo Siqueira
 <Rodrigo.Siqueira@amd.com>, Alex Deucher <alexander.deucher@amd.com>, "Harry
 Wentland" <harry.wentland@amd.com>, Hamza Mahfooz <hamza.mahfooz@amd.com>
Subject: [PATCH] drm/amd/display: Remove 'struct drm_device *dev' in
 'amdgpu_dm_fbc_init()'
Date: Thu, 9 Nov 2023 01:07:28 +0530
Message-ID: <20231108193728.3099568-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AB:EE_|DM4PR12MB6182:EE_
X-MS-Office365-Filtering-Correlation-Id: 749cc407-ef10-4e09-be49-08dbe0923706
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RwzRgu9iIL98b99jw14b/WioCbxcAIlgwWD4mbveFkGYJqPR3lvC5f6hnClaXChDiWMT/n+8QMhohz/lYeTE6oVMmw/vdxY4pseAo6Um4wa+AnJOgQWvsKwH8T4WqeMOVvqoIJf1Z1k9VZfzEdtUVxKOlVt/L6v2SFqi2eRC8U9nGn6c0/sCLRtI6EjBsIkzEl6clAdmNCIJ5J+GErK5rZc3MQ1eX6NkFzuHqSt16xxxAXj/QXQ2idWdj86AHWeINB8nW/7AMlVzY9PWwDMx9tNPWojEJaes7ytl6t/gcF2U+EPzVMftFdsR/vjp2cfUGntRqni44UQ3BimXDRza2ltHivRtrENsOHyBz+eyOIFcZXFKuGLrVP2/AG9bhsZHjd39F8Uz891SoJUk+9Yusov25QscD1auCYzTVamud/GIKV501t6s7m+lYwXszQyPaJHmkAhuanPHKSlNYA6is+p2+uYvE3BlZVY0imNQvoB0yf0cFYJFd8StBj33rmJyDO1+NEmNWtZyznGA5SAonGxp0OOoYMbCYhs6dKNEKD0Gvpg79pm826QpDfZ7j+gzJ0RWNVgtq6P30DoV8Rt89+qLn+ips3vqRujQpifUFah8uPc+7F8KsBo70tsog/ISyC5JVWLIdFgaalXAgyH8MgE613kF9wnXRIGef0C2kkt+Hm/KgWeqJstgQg92K7MoGXxcO5vmmc2I2Z77g9j38OwB2zXE9n7ljtD98ORJYjCDzZJiGs+PR2ysNGbmnFbbUvt17dypPHuFoJxmRGcThg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(396003)(376002)(346002)(136003)(230922051799003)(451199024)(82310400011)(64100799003)(186009)(1800799009)(46966006)(36840700001)(40470700004)(2906002)(2616005)(7696005)(6666004)(478600001)(83380400001)(1076003)(426003)(5660300002)(336012)(26005)(16526019)(41300700001)(54906003)(110136005)(44832011)(316002)(4326008)(8676002)(8936002)(70586007)(6636002)(47076005)(70206006)(82740400003)(36860700001)(36756003)(81166007)(86362001)(356005)(40480700001)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2023 19:37:59.4686 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 749cc407-ef10-4e09-be49-08dbe0923706
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6182
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
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Declaration of 'struct drm_device *dev' is redundant in
'amdgpu_dm_fbc_init()', as 'connector->dev' can be directly passed to
'drm_to_adev', without intermediate dev variable

Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index adbeb2c897b5..07f65abe2cfa 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -893,8 +893,7 @@ static int dm_early_init(void *handle);
 /* Allocate memory for FBC compressed data  */
 static void amdgpu_dm_fbc_init(struct drm_connector *connector)
 {
-	struct drm_device *dev = connector->dev;
-	struct amdgpu_device *adev = drm_to_adev(dev);
+	struct amdgpu_device *adev = drm_to_adev(connector->dev);
 	struct dm_compressor_info *compressor = &adev->dm.compressor;
 	struct amdgpu_dm_connector *aconn = to_amdgpu_dm_connector(connector);
 	struct drm_display_mode *mode;
-- 
2.34.1

