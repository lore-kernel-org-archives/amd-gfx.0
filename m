Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1709BC4332F
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Nov 2022 05:52:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 450AC10E375;
	Tue, 22 Nov 2022 05:52:09 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on20605.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e83::605])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 44F5010E375
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Nov 2022 05:52:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Us8LDYBFoqeAWRutIldRwK1SgCVgtZvKNX01iOlwS2rW7r5B2obXNi856dS4Y3YlP387lxHPX9Ku3gBBueuccUwaCYmQkE8NkvZetGJG1+jHwH58ci3eeiSXgP8ZNy9FF6+e08XEmz8cL0Ssukh6YL0XQ0u6PyyCo+Qd6J6O1n+SWVyX/39rcGOZnyq6c2O3bcS90Re9Hc/GMH7OzQHQfMTKjVFbDMBk5twVV8nadLTpUNWbJaHjVPK0r41bXDZMwEynRJh7CdFISS1M/YPUErzldrOoQ2Mq2D14Wx3rBqU04YPNDCrmNOt3uJIVXJYo7NjWJiwSosDhf8TS7eBFww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=auBfFiD1VMV8w/m0Qld0ujqa+Pjw1sHqpDnQBhZwvoY=;
 b=L/ZhkImI8FQQrl6r/HmRw37XJKPU/kJWDvLJx00WfsR2eDICzs5Ut4pJsvcedpK4IzQyx0eRTOxB0JURKey6M60L3/PKlCimgm8w0HHd5VgnCx1I4fPpT0KATLqGsrBHHf5tkox/g/6sNciTZ62SpvgdceZsUMy4vjnbRDHRWQCWVToHeYyuFoN0Rlr5DXrXz4jQhdgEKRhQVXGgWJx9dfat1e6CM+e96uQonxB/Kwzh2dvggTFKrf4FaQBUowSgZM+0eZnJtNey3mQdGIzpaeDF3THa8ILpiyJ9D7JFK+Jzkfpb7tOLk3hhLZ7ivMcAVD2U5PhO1w0B0yZiLYoJWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=auBfFiD1VMV8w/m0Qld0ujqa+Pjw1sHqpDnQBhZwvoY=;
 b=o4cdGekKO0GYMp3nTGxgeajjCQ6fAj1qZprtsuCh/uKgMjZwNrkU0T7ltmRSxDie2bpk6X7d+PFTZfOt/7wruUp/aSqN+rP2soJOzOUX3tRguGgNiTUYmWgokG7PngAdEktmqE/Qin0iT2oKGsdnDOHIeYWILhmSrBp9GOXoZhQ=
Received: from DS7PR03CA0333.namprd03.prod.outlook.com (2603:10b6:8:55::15) by
 SJ0PR12MB7035.namprd12.prod.outlook.com (2603:10b6:a03:47c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.9; Tue, 22 Nov
 2022 05:52:04 +0000
Received: from DM6NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:55:cafe::51) by DS7PR03CA0333.outlook.office365.com
 (2603:10b6:8:55::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.9 via Frontend
 Transport; Tue, 22 Nov 2022 05:52:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT051.mail.protection.outlook.com (10.13.172.243) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5834.8 via Frontend Transport; Tue, 22 Nov 2022 05:51:52 +0000
Received: from yifan.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 21 Nov
 2022 23:51:18 -0600
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 01/19] drm/amdgpu/discovery: enable soc21 common for GC 11.0.4
Date: Tue, 22 Nov 2022 13:50:07 +0800
Message-ID: <20221122055025.2104075-1-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT051:EE_|SJ0PR12MB7035:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f65979b-c2de-4fc6-9588-08dacc4dae81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ib8kVa0QxgLkFvw0hwTYmtB4BiuN2fKBq41ar+yklo1IYhglkmIyPjeI1mQsiZbuuZLq2FJ5cc2ZdBDM5XeSD7znDAy+3UgHA7Z2LiMl4uMMTVUftQ0K14/F/V6qJDuaP2OGepk6bPWtcy9xIjzUYTMjmgfzGh2gR3Si7DeO7vSAiWBXpllm7sLtpAliCt/lF4CzjyrZihJfUU8xRJOvPogFh2AwVOjGly/nXM4DVegGbO5RVUWZzBO1qmNSf5R1okStoGmDNt80A6zN87xQzH8849cSc7A/ro0Ou7BODUWABoF1Xd2QluPMFkleGSFbV9B23IDEEgQg1JnCm2efFmm2oDvFQdeaft9Aq/qSoMbwGZ5gO6R3hJWVYuA1Mlo+fTEkeTg4A1A/3im7rpvo/Vk0vavpbAeomfavJoKO7vAqou++W+iObmLMNN3/tLvkXnQLej1BtlVxqJKwTf2DgW8ArXZbTv/d0VrIYSWy9qaQJuPZtr4xroqo+mmdp7xWE6XBGrZ303CCozRDn8B/keKJU5v5I+zily0K9ifT2RiLr326qFjpTXqaxtxuZxRual+X/9LmjwXi/oaKv6dGMHQ/+JwGn19L8NK3Qodsc56WFVk6vT5D4nwq+ap098NpePq8j8pyWQ2HbYfuoxFqRojkvGNyve4wlLJ+8vXWzTaEvdv8BGnR6OICDdFRsUWSuA9a3acOujbHGhkCczj4Ji2ooWcP2pEHyRKiZeDP6UM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(376002)(136003)(396003)(346002)(451199015)(36840700001)(40470700004)(46966006)(6666004)(478600001)(26005)(7696005)(82310400005)(16526019)(36756003)(83380400001)(47076005)(8936002)(8676002)(2616005)(1076003)(336012)(426003)(81166007)(4326008)(186003)(356005)(2906002)(70586007)(54906003)(70206006)(40460700003)(5660300002)(316002)(4744005)(86362001)(82740400003)(6916009)(40480700001)(36860700001)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2022 05:51:52.8156 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f65979b-c2de-4fc6-9588-08dacc4dae81
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7035
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
Cc: Alexander.Deucher@amd.com, Tim.Huang@amd.com, Xiaojian.Du@amd.com,
 Yifan Zhang <yifan1.zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Enable soc21 common for GC 11.0.4.

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 2509341df92d..b8db6184dcbd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -1512,6 +1512,7 @@ static int amdgpu_discovery_set_common_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(11, 0, 1):
 	case IP_VERSION(11, 0, 2):
 	case IP_VERSION(11, 0, 3):
+	case IP_VERSION(11, 0, 4):
 		amdgpu_device_ip_block_add(adev, &soc21_common_ip_block);
 		break;
 	default:
-- 
2.37.3

