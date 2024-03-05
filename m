Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54530C54798
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Mar 2024 19:46:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4710B11268D;
	Tue,  5 Mar 2024 19:46:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QDUCEUJT";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 362EE10EC37
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Mar 2024 19:46:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W+4eLlElVmAI4EKHLMN/HgyEjhpdsxrW0fLFLTLV1KnPI6nOjk5GXYG311G0fPb2/F6htd2oMgZIllJuqfIUIeh5LywIn0rsm194907/5G1EY9glhlj8P0XJX3EdOABL4NLvz+FQ0rovXX8SOKBWWljhU0nLN250qsvuhF/c87g0RcBqvvUwLB6ys92P4ZmVhdcavj0stWClY1w324miVe3DE0M2zbH7f1EshR6sKx9DmG1hXta1PeSCXUaFBymo/44OZ74ztcIivvut4usbm9cF2SgsDnc0XoNwqKWipgqLXqbEohBfBfeE4eMcfhJebNyav6Ge+CHMIhE+8L3GNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rylrBbCpKBsA9P6YqNIjG4Imeq3Jc1FSKTLPsp6F2E0=;
 b=GXY4WzaiKH39TBmlS5bDTJakvp8luwqh7pvrfdaH/VVkKjNCgrU0bTJo65xIek7O2X9auHxWZCK7hfEB9+OhxtGHx+dbnqr0YZW6bmbaV2sk/AjO1i93N4u0rSMqv9md3GeMHZFfUxV92Rryvlk15UheOmvv1xJfH3CLo6adyFAyJoqHxOHN20XkEwj/p247D+idiOsJzaKLGjHr2S5VGp32ivx/5c5uni5QSv9Tn3nPDy9aE6gkcVsG8PnRvxioiRYYiBmwhaU193eb5NZq3oIxwgwxpXbLji+z1Yk1fQ1SEWBDDXWutRSU8/T5KI90yHA7U9OBe8EAK4v85KxWDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rylrBbCpKBsA9P6YqNIjG4Imeq3Jc1FSKTLPsp6F2E0=;
 b=QDUCEUJTsdqaxy9IsJWJEUnhwTY2HGm0uF6OYNlbHMH9WMDPfuwyvhRsX1RoK7qPbOPbNiqTHeyBLOWL9wUFHJjkXtwqdrwvUwptYoSM5koeeUtTwzJtOYufk9Mr5O4G/Sg52BhBMuYWkNpa24T+PnOPeIfrpRNiAo9+D1igcLU=
Received: from BLAPR03CA0132.namprd03.prod.outlook.com (2603:10b6:208:32e::17)
 by DS0PR12MB8019.namprd12.prod.outlook.com (2603:10b6:8:14e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.39; Tue, 5 Mar
 2024 19:46:45 +0000
Received: from BL6PEPF0001AB4F.namprd04.prod.outlook.com
 (2603:10b6:208:32e:cafe::8d) by BLAPR03CA0132.outlook.office365.com
 (2603:10b6:208:32e::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24 via Frontend
 Transport; Tue, 5 Mar 2024 19:46:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4F.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7362.11 via Frontend Transport; Tue, 5 Mar 2024 19:46:45 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 5 Mar
 2024 13:46:44 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Likun Gao <Likun.Gao@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 4/4] drm/amdgpu/discovery: add nbif v6_3_1 ip block
Date: Tue, 5 Mar 2024 14:46:26 -0500
Message-ID: <20240305194626.1783473-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240305194626.1783473-1-alexander.deucher@amd.com>
References: <20240305194626.1783473-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4F:EE_|DS0PR12MB8019:EE_
X-MS-Office365-Filtering-Correlation-Id: 587ebe96-5a1a-4136-cc42-08dc3d4cfd05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fHj1a3HlQnvpHXOsScCRYqZ6bq4mltWAA6HyG5N5b8g0MmW68wlMpVxnt/SgC0wvedvA61W3uZkxdMvFq8bX5+NlEhr4BEBp/ZRprGI4EcNollRQrGN92dXdTLBCE4mwC6qn61RVYAa3+et3LRcpzYY5bgmZhFUspUrhJglpye4gNIgkLt0TRoIS+AgivStC9LgEuWu8l9+RaxYmng7/MPyL2PeeXkDEbFstXszTm1/P1ZDdsmny7yWfRJpqX3DH/apZi7PSZjA90gqmYUiXkx/FEAoauPuWsrVCsfCYzohXZ5GH4Edf0kHRjHg/pm/vH84H95ONgY4exVf49CVPRVCvmAOnrJf/chrFqotOfKPvjIqyUtQ8K4qnvhO1P68lrVSg3YmcbD8oJFiViar3AgLf1k02BFeShg+IbagLdZOiRsCBEKGr1xnW1gM00j8aUxAAs2mEU5ZjVssCC/TJs/cz6hVuQTzm3+4w+aTGMr+zqD6yp+QURdkaiO0DTq829VQrcixsOFbSTu1b09rnVOHqlIBJF39BNqVBMvFHlE62YVP4yB1f5VPP/jUfxEbdbqACcnzKi7RLsNn0++ZwIER0kILrPoCTLeuy8jytKV4wRKcEL+CslLuUc/hq7GQ6oSFXUWsPa9TJApStaQwGftyTNC+jiQRpBKcKJ0vyPvtOgiDpC4mUWXikRCPr/4wEEajOb/mJSLydX9TZtdnjAP7Rh2nGJ7K3OL3PTNF1B+tJh03yZW1hfEwHT6O49WBl
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(376005)(36860700004); DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2024 19:46:45.1279 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 587ebe96-5a1a-4136-cc42-08dc3d4cfd05
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8019
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

From: Likun Gao <Likun.Gao@amd.com>

Add nbif v6_3_1 ip block.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 502333725b49f..ec42f473acda0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -61,6 +61,7 @@
 #include "nbio_v4_3.h"
 #include "nbio_v7_2.h"
 #include "nbio_v7_7.h"
+#include "nbif_v6_3_1.h"
 #include "hdp_v5_0.h"
 #include "hdp_v5_2.h"
 #include "hdp_v6_0.h"
@@ -2558,6 +2559,10 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 		adev->nbio.funcs = &nbio_v7_7_funcs;
 		adev->nbio.hdp_flush_reg = &nbio_v7_7_hdp_flush_reg;
 		break;
+	case IP_VERSION(6, 3, 1):
+		adev->nbio.funcs = &nbif_v6_3_1_funcs;
+		adev->nbio.hdp_flush_reg = &nbif_v6_3_1_hdp_flush_reg;
+		break;
 	default:
 		break;
 	}
-- 
2.44.0

