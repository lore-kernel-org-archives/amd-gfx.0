Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E483C19F2D
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Aug 2022 04:59:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0126F12A5BB;
	Thu, 11 Aug 2022 04:59:20 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2067.outbound.protection.outlook.com [40.107.95.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 79A3BA110C
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Aug 2022 04:58:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XC6HUDMOyUS9QiehvIDGIQeitGUdxH3PTPvqhXjJp0S/H2GN90cYIJQFBDj3LTD5/5kc9YQpSZMpg/C6vFBlQmzHV1v3XKRq+dLKw0We9TBpDOPc06IN8qT0MZ38r2ErzSi+UsND53bt6be4axTOMTbw4an2CVXut73118UhckmjKtvQi+ug0Nj8prQtk29b7f0mKpXCSAr5fS6Tdez/am+bdTHsYrL+7+oGHIYXNX6juzzdR91SOHilH5w43zpYvkiq2JAeS2RaUZE1NPSxA40fhWLtVK7+28llu4hnEmf4nWnPGuoOBwuBspJPC8gIqw4CGTTqos41q2NEaiEKpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y6eFLI3bRG81qxokJdICs+uKaUgcCvkauYb2+vvVwbo=;
 b=Ep2OV4Ae9bW3vPvP81rF/XOSOJVgHbClGSaLNLLfv1QfuwSscsoKWdgLi3xAaOvDTLw6zekvkWPd6ST7QkRJEoIFWMm/Um0Y6ruXhZMAhFfA3K209aNr7VBSfLdwV3fQ0qC+f9OABaW53R6htwHwi6lNOSe1d/0XUGafS/N2rODf/OqjENtcOePKPA8sa3EeVeMBuW1l3VctEj56GwB41EF78sglRW3JC9hJ83vR9qYK/m0zIl2qwSJd+VUpNZgaQKsK7+4nwa6VRPYH5BM0oAbVCBtp+svvoRlu0eFHySJiVeu+tmyh0c5bDuibNnUV8Td/uom9SC32tlb2g9et7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y6eFLI3bRG81qxokJdICs+uKaUgcCvkauYb2+vvVwbo=;
 b=ptEOl4ufkJGAYxBrQYeqgzzQdktNPcaLUL2x+6wS4/jhsduSHX1Zj2VE0W361gyoAxkHnITc8ElN4zebPvm2VUcjgRPj4QIL3urt8VyXtnk31X4k0ohwDushUaFZL0Uf445EQdzrr0DyVRD9aHYpdMcUDajO3OBcXhzuwH3vD0o=
Received: from MW4PR03CA0356.namprd03.prod.outlook.com (2603:10b6:303:dc::31)
 by IA1PR12MB6531.namprd12.prod.outlook.com (2603:10b6:208:3a4::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11; Thu, 11 Aug
 2022 04:58:50 +0000
Received: from CO1NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:dc:cafe::37) by MW4PR03CA0356.outlook.office365.com
 (2603:10b6:303:dc::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11 via Frontend
 Transport; Thu, 11 Aug 2022 04:58:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT019.mail.protection.outlook.com (10.13.175.57) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5525.11 via Frontend Transport; Thu, 11 Aug 2022 04:58:49 +0000
Received: from ldev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 10 Aug
 2022 23:58:47 -0500
From: Tim Huang <tim.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 6/7] drm/amdgpu: enable HDP IP v5.2.1 Clock Gating
Date: Thu, 11 Aug 2022 12:58:03 +0800
Message-ID: <20220811045804.3750344-6-tim.huang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220811045804.3750344-1-tim.huang@amd.com>
References: <20220811045804.3750344-1-tim.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a204c985-1b52-4d84-303a-08da7b562e15
X-MS-TrafficTypeDiagnostic: IA1PR12MB6531:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GhVM6+WsOZcgRcqiZS4qWD/3U9ldA788GTZHyW67NBIOp2v8xEPtFLVyoCKSYAWpb7UhZieqAfuHNjyIgkxR7CjYYjwqDQ9gzr5Sq9Z7aA0lbYq8/SllZAhWAccsbyWi4iDVv5GJaYfcvDDiHL0eP5sD6oLZVe5viBROqlwZcwft0ZMNZtgZVbGgID4YWOPUlJUDnjSaMc4vhXhKcEdAGNszkn85uwjLa4oFI5x2fk2eAB/DBuWn86n4JBPO8EqJsMiIjuBDrfYdeD6vKGOJq25ZmjP6MslbUVD0QKj3yRZf92NZPs2q8rYLaX0U1dV5/C66pLC6kx93m4+zEgJKgk+57AY95yED1klwMyTgUY73/TsxHWVk0y9pIsERiRybpeSgQPlYoqCcBtIAgUWOLXQRxRx/9U9mbLd/ra58OFvXzt/yR441u3WQ/LYZQjtMCRpQDm5SI075q05TtSlfNn+20DEhLrYeru7BE46BAGmFiJNxErkvEhpDSb8U3L2Q/V7tNJA5rXr51PkoMdyqwIZHc1RK0qQ0nBZRz+0vXTjrO5BpLWAQy4zcL0DILzVkxHOTtRaMTbmqGsTNHLWat79ugyy/L095F4pr3NSQCbKdWAOMpRAvhsn/AVHq13cs0LeKhjSuynnlDbEH0DRWKJQTyujqmRklg7NGeofsBbjdf22shg+EAWfbP6K4iVncSR954L7soUHWl30dL86BSnt+1xBJdS8T+ZCzVe+LIwFtFOyczhoTdgIeWmmypMaSF4lKOhZ++WWUWGC3+qKNyZaD09gnZkuHQReiJ1rXvELcX6adWOzt/fdwD2eCl7CbHh9E+grQJU6q9Mfrp0x60Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(136003)(346002)(376002)(396003)(36840700001)(46966006)(40470700004)(478600001)(44832011)(4744005)(5660300002)(70206006)(70586007)(2906002)(82740400003)(81166007)(8936002)(356005)(8676002)(36860700001)(26005)(7696005)(6666004)(36756003)(40480700001)(47076005)(16526019)(2616005)(1076003)(426003)(336012)(186003)(40460700003)(86362001)(41300700001)(54906003)(6916009)(316002)(4326008)(82310400005)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2022 04:58:49.5016 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a204c985-1b52-4d84-303a-08da7b562e15
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT019.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6531
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
Cc: Alexander.Deucher@amd.com, Yifan1.zhang@amd.com, Xiaojian.Du@amd.com,
 Tim Huang <tim.huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Enable AMD_CG_SUPPORT_HDP_MGCG and AMD_CG_SUPPORT_HDP_LS support.

Signed-off-by: Tim Huang <tim.huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc21.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index 543cf40adf8e..d9e5bae82e83 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -598,6 +598,8 @@ static int soc21_common_early_init(void *handle)
 			AMD_CG_SUPPORT_GFX_PERF_CLK |
 			AMD_CG_SUPPORT_MC_MGCG |
 			AMD_CG_SUPPORT_MC_LS |
+			AMD_CG_SUPPORT_HDP_MGCG |
+			AMD_CG_SUPPORT_HDP_LS |
 			AMD_CG_SUPPORT_VCN_MGCG |
 			AMD_CG_SUPPORT_JPEG_MGCG;
 		adev->pg_flags =
@@ -704,6 +706,10 @@ static int soc21_common_set_clockgating_state(void *handle,
 		adev->hdp.funcs->update_clock_gating(adev,
 				state == AMD_CG_STATE_GATE);
 		break;
+	case IP_VERSION(7, 7, 0):
+		adev->hdp.funcs->update_clock_gating(adev,
+				state == AMD_CG_STATE_GATE);
+		break;
 	default:
 		break;
 	}
-- 
2.25.1

