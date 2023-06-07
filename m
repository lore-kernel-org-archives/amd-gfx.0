Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 194F3C7EE23
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Jun 2023 12:17:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 915B110E4DF;
	Wed,  7 Jun 2023 12:17:35 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20609.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::609])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE1BE10E4E2
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Jun 2023 12:17:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J5qkU+7y6QBrCPA1j/6HfoIWPVw8E7qfrstp8nwOL5dnXqGBh9lfg6RBuWSP3Sm0kroWzXX0t7Vgt4n18vGa6XIenPtkKn0kvcQNxEKvJppePm7aDh6St3lf4fbS1cFYqNQ+bjq0WjNQEVNq0Z6liK7qyQ6UAf/aiu6Ey02AG6RDRAn7jTlpXa94MFTFm2XueKKk/WDDkpJJjilTe50Dzhxf2IjubXS6OYgJeaehzRcJR45euN/cgaNk0KmVQSHI1aEEjRyrQur4clhBLbBeVoQC20e2T5YZz93gCOVAy6udCdcDtyc1q5ZHV4gTZR1AiGmjhEKr6l8DiHfAfzIRrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WYKA+DXhCcExUzJJyjFosHiOpuj8++h8MnbQn3uzRGg=;
 b=FyynBpnTCkdrjX/mdKT9Fb52til2tSb313rfsZ3VNUeh4RttPwq8cEv16/tSdAuMboi4a9/jT6VlwpU4wO3FoHMfeg2XspWgPfOID5N9GAsQ8PoYY/WhUQbgwHFaTpVdSXv8RuNAqWTbOHoER6JvHB9KVTR9osPoAGbiRA8oiH4BqDDEvMeImd3yOxhvMhIcBG8iz5ABZhJ6A57UCHNhgFcqm8FuilYbDdSqcppnBVXu3MtEDTes6vq7TIns5smy92EQQkN+nbNgrVrlb/31QHyG8OHq0jj5lULoRYORb9W0FdUTZzgP+G8Bakra2fbAFEJBwXc+DJK5E/Hf+6CI7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WYKA+DXhCcExUzJJyjFosHiOpuj8++h8MnbQn3uzRGg=;
 b=G4+hq9AvbS4fPO5CVUHccX7/OlbUxZcL8jiuMJxp3Hnxr2RAS7aEmxcWMimuXLhH+92S2HQegF/KDxVb7Zj6+P+zq9unXFVeYDQX2txsUP02Px4y6PLwN6E5eY6f6UYZtM1o3exrZ9DQwUsGkjEYoJXqOVzQvfk6nsu4I+kfl9Q=
Received: from DS7PR05CA0084.namprd05.prod.outlook.com (2603:10b6:8:57::25) by
 CH3PR12MB9146.namprd12.prod.outlook.com (2603:10b6:610:19c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Wed, 7 Jun
 2023 12:17:31 +0000
Received: from CY4PEPF0000EE36.namprd05.prod.outlook.com
 (2603:10b6:8:57:cafe::f) by DS7PR05CA0084.outlook.office365.com
 (2603:10b6:8:57::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.20 via Frontend
 Transport; Wed, 7 Jun 2023 12:17:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE36.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6477.13 via Frontend Transport; Wed, 7 Jun 2023 12:17:31 +0000
Received: from stylon-rog.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 7 Jun
 2023 07:17:27 -0500
From: Stylon Wang <stylon.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 20/20] drm/amd/display: 3.2.239
Date: Wed, 7 Jun 2023 20:15:48 +0800
Message-ID: <20230607121548.1479290-21-stylon.wang@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230607121548.1479290-1-stylon.wang@amd.com>
References: <20230607121548.1479290-1-stylon.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE36:EE_|CH3PR12MB9146:EE_
X-MS-Office365-Filtering-Correlation-Id: c10de818-0785-449c-8bec-08db67512afd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ij5azbnOwr35dqplBiBjA1RvMSigGnQ+u1cLjvlTj1pNOoCuZDySpTDiRM+NNk7Y6P07FaUd4K4E9knWCM8dWnGJ9J06Vjub3gRcydwbcXrHyb/eMT3q/c0LutFXXeDo/QgbwZKXOZ2BXHmqGaOR3p3DIQNv76CuiPUJYa9W36KcwluOKbb/BjljxWWkoisZ5LLsOCzycr9I/MYb1M+lvxRSZq1NS9Ljbt5ZNJjcNPbCcBXbyud+GH74YFVG91ZsAUCT76XGa0ZPCmCmHXcEMa1JA0FJSpZBJMhxHqJWshKqF2sn0RmGjG+q5KSczfmE7VC9IqGtJFcHeyip8wPUalVqMFKOjCb4vjycOUc7fgcU2qS1KyobeCRBxHxGC6bxgnKD4GwRoKCrNhc0PCkczkOGzRtR7NFeoMj1V5umCqnzGFoXjLgcm1Grf6YwjVtyOIDhbW8k7moe5tcYUhr0o6ftQUZaT29778Bg699edU1vd4hxQ67JYndcEMOjOqBGWIXgFAc2J+tt7daJ2xKvXaFO4STh81zZME6tFka76JmadMgirW5unK0S4EqOp2DqzopymUM/X2AKlobKpM7+IhdgsVICToJp9m83F9tOZISPAVXFHruR2nDEI8S+w0t6Y5LqFjFW3NG9A5gV8uGksO1ZqgOvSImt7xX4GtmDEEGdQfNIRzn88d2Dg2nWlH9wk8sEa/IevjWoHe51Z7OzAVEsm7EF5qGkKZ62NuoLVXyepM3Jnz56YWOEU04q84lMr33AzO+f1jEirM2sdRR2KQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(376002)(136003)(39860400002)(396003)(451199021)(36840700001)(46966006)(40470700004)(40480700001)(7696005)(54906003)(70586007)(82740400003)(478600001)(81166007)(356005)(316002)(6916009)(47076005)(8676002)(8936002)(41300700001)(4326008)(70206006)(2616005)(186003)(426003)(336012)(36860700001)(16526019)(6666004)(83380400001)(1076003)(40460700003)(26005)(86362001)(44832011)(5660300002)(2906002)(4744005)(82310400005)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 12:17:31.3391 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c10de818-0785-449c-8bec-08db67512afd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE36.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9146
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
Cc: stylon.wang@amd.com, Aric Cyr <aric.cyr@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

This version brings along following fixes:
- Improvement on eDP
- PSR bug fixes
- SubVP bug fixes
- Improvements on pipe handling to address potential issues
- Freesync bug fix
- DPIA bug fix
- Fix multi-display issues

Acked-by: Stylon Wang <stylon.wang@amd.com>
Signed-off-by: Aric Cyr <aric.cyr@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index a239dcd8e9fb..26d05e225088 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -45,7 +45,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.238"
+#define DC_VER "3.2.239"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.40.1

