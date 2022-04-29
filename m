Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18FEFC433FE
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Apr 2022 18:03:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D0E1810F8BF;
	Fri, 29 Apr 2022 18:03:15 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2071.outbound.protection.outlook.com [40.107.243.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57B1710F8B6
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Apr 2022 18:03:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TmHTRrSmUFU6Fh5y9v0iDtyF9hEeD4dVaqF/iloKSkOqf6oJzoX6dU8V/y3pngl8kzek9RW2D9zK2YAzboKPx6AqWhIWCIwfiFPRWDpwMYech0ez6/LXJMc9u2qJMqF9QRMPz7GqW9pedbYw8yixOxujykIq5QZm/88NHZyTc13gTdKhC89bp1uIUeaf9bQrUHKze1VLZIATNSfEj+nhhl6NFjB1p3r9gFSQVn7d8mRJ0aD1+cQtHjiH8RfmfpYIaTR9gZhY7dzO2lwjv0RYVVOhvCGbAqURVcrqo8+Uk12oRF6uF+mdGT19UDe5bs3O9M3C3K4mJQmUbptoQTNcHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HSlRjh8kDkyrWN5PecIOJP+EfCPzdheePxR2JjY4o4E=;
 b=Ha/ElR33CrQUQfMsjl7vZNwI45ln/PZbDrmacYoMP8FIr5mSHvR3HPG4468obrRU+KgsiU6WHpyV0Y3jXYc6V8okdfdx2DmxUzCbbXKpu+7gzP87ALzis1L0CT1Q12pqSdu0m27FfsKVlTz6WPY36hNFGHVq4J5zjLOc+4wIXnL1TGno8LCiIkieMbbJlLTfjxx6D40vRfLB7kGbKoEVnRbL+drE7sQLMWulXN4iwgrDrWc11m4t6YKhA6XT+hsnFDsnJ/RK1SUvQWHvF59J3F4KRkyNN+v3xu8yIS/rNYmlWOdmrhuoH6x4EWs/IMMY7No3koBn8Lvqs24zwXoSeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HSlRjh8kDkyrWN5PecIOJP+EfCPzdheePxR2JjY4o4E=;
 b=YU7rvRwBz/+DBuEi8syrupm5yqbjgJH+pvN8gS3230kAWLXdxiI6jUm3e3q/encOm2MLQL92nrs+FZQS9RqeJweGEJ0KUOICSpHTwTGBlLtzvzJfsn1rd68bq5vtL9RY+i/s2adq7PUXKTvu02xYo4WegQL8M7mP5bg8jkSPh00=
Received: from MW3PR06CA0019.namprd06.prod.outlook.com (2603:10b6:303:2a::24)
 by CH2PR12MB4167.namprd12.prod.outlook.com (2603:10b6:610:7a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Fri, 29 Apr
 2022 18:02:59 +0000
Received: from CO1NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:2a:cafe::db) by MW3PR06CA0019.outlook.office365.com
 (2603:10b6:303:2a::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.20 via Frontend
 Transport; Fri, 29 Apr 2022 18:02:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT003.mail.protection.outlook.com (10.13.175.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Fri, 29 Apr 2022 18:02:59 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 29 Apr
 2022 13:02:54 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 29/29] drm/amdgpu/discovery: add MES11 support
Date: Fri, 29 Apr 2022 14:02:26 -0400
Message-ID: <20220429180226.536084-30-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220429180226.536084-1-alexander.deucher@amd.com>
References: <20220429180226.536084-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a1d534c2-b5ed-4c9f-e0a2-08da2a0a7ed5
X-MS-TrafficTypeDiagnostic: CH2PR12MB4167:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB4167D77BC99AE921FD692A77F7FC9@CH2PR12MB4167.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bDNCWRLK3ukGIBqlMQ1geJ0dwWd98E4IodDmcjz+Ut9XFKQCdZ+kXf/6uIUVOcoO/vrH1325K6/f137E8YfWxFQDhDjcfs6bQTl9TmdQrcNTrmSRXQweY4ck2PNvV1+cQx1ayaLUBWVXRNCBVdpj7j/tJS0N0sU7lnc8wCOkR6+lc74jrtGeuFqfB0f8v3eH2ytXN0RCvOleOv95vuPofSqq6svesFvR/oFCPPxmyMThBgrtDlpHZoBNhH6PvgjS1kLHSaZvlmP2AalzzXx1EnQWvLrIaeUQF7wpUmKJPuzPRsFfpyNWrOaoAeYd/623unM5Bb7IrmSW1q8fzzaD4Yg0ygdlNjFvKTIQ7PSxfbFsS4HoQpCsycUa43CSsua7JhUS0LMtbCLLs0qsRhxSb1TCXlK+iQSfhFEsOio3Kqe5jJpcwYy0EDU+rWsHtCpZIg4ykZQTY4HNdQbZxdF0XWSGpGI72LESYhfCl8LXmpuyj+l7aQDIMbJg9oXPr38ALmdDBnY0v9FfrZFfOhliEs9PYTbeplJ4gqNNha1kZsu5LbaCOC+6HZgAqxpV0NBXUDn+ZtjNGYk7HUSJ47CkYaB8f9wlc1VhQesgxof1mT8Nq9fmPwZtcpRajhX2IJY0FEWwbLN4IEe1t1ndDuSeF3ajCbEDx2jcOfZC4n4do4eGxJTCEvUfqAEBxFwVnfjlLlqhrGIBE14FlA9X1pRIKw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(508600001)(6666004)(7696005)(86362001)(2906002)(82310400005)(26005)(16526019)(8936002)(186003)(5660300002)(356005)(426003)(47076005)(336012)(2616005)(83380400001)(40460700003)(1076003)(81166007)(36860700001)(316002)(36756003)(6916009)(70586007)(4326008)(8676002)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2022 18:02:59.0613 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1d534c2-b5ed-4c9f-e0a2-08da2a0a7ed5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4167
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 21 +++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index d3c9f07a43af..0edb7c8f3b05 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -69,6 +69,7 @@
 #include "jpeg_v3_0.h"
 #include "amdgpu_vkms.h"
 #include "mes_v10_1.h"
+#include "mes_v11_0.h"
 #include "smuio_v11_0.h"
 #include "smuio_v11_0_6.h"
 #include "smuio_v13_0.h"
@@ -1873,7 +1874,17 @@ static int amdgpu_discovery_set_mes_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(10, 3, 4):
 	case IP_VERSION(10, 3, 5):
 	case IP_VERSION(10, 3, 6):
-		amdgpu_device_ip_block_add(adev, &mes_v10_1_ip_block);
+		if (amdgpu_mes) {
+			amdgpu_device_ip_block_add(adev, &mes_v10_1_ip_block);
+			adev->enable_mes = true;
+			if (amdgpu_mes_kiq)
+				adev->enable_mes_kiq = true;
+		}
+		break;
+	case IP_VERSION(11, 0, 0):
+		amdgpu_device_ip_block_add(adev, &mes_v11_0_ip_block);
+		adev->enable_mes = true;
+		adev->enable_mes_kiq = true;
 		break;
 	default:
 		break;
@@ -2308,11 +2319,9 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 	if (r)
 		return r;
 
-	if (adev->enable_mes) {
-		r = amdgpu_discovery_set_mes_ip_blocks(adev);
-		if (r)
-			return r;
-	}
+	r = amdgpu_discovery_set_mes_ip_blocks(adev);
+	if (r)
+		return r;
 
 	return 0;
 }
-- 
2.35.1

