Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89ADAEB64DD
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Jul 2023 13:20:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 31E0010E6CC;
	Thu, 13 Jul 2023 13:20:08 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2061.outbound.protection.outlook.com [40.107.244.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3023E10E6CC
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Jul 2023 13:20:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YeDqrWy3o8i3hWlhfLB6R/CWsjkVbtfP/InVxiUGE4sgo3WkhRtr+b3yA6OYfHhanD7imUaV7gf62//ss0YlrOdytBBh0ATRrZomJqjpNc62jrnSCaiBmuZB1hX5B0YyzRRW+q+5HA7sqhb7y+CJeSxCqNaazz80PnOwzDOxb0WqronQ+ZApEQHEV3TqJuto7GjDZMpJ68kuv/l/2tS9LznOXtK9lH9Yr051RT+d4Gs+qoHGFRHskDZQ6mvnk9Q1uMHpie/4j7r4PUyP6w6wMedYT1708/c/Y1vWx9EJ1AlCx8wex64BVV3zrCgDjSeVHsMwr5AREjRGTp/D1U3sjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dymMHJG//ReZKonCfzMxW6ASKu/xKeDVKM0TtHcSelo=;
 b=IRLihCHF67NAEfe8ZJVOWM2muZSrbp+qYYAqOnPOJ9ctWDjeUcU+FZBs2paXuiWmCIgqmodaQbwF9xLV/TWGyXvYICYzwpiBj8HtnimjulgqOXE1W4JLNgZ8fz6QCSMrlOIEALY32co/2uZiE6WAgv/NE2CTolyzJcNpSgTurX5UPAGHlxbqsagIGVha/3cBpszlvFNtYu2486+TRbkHZjw0wrllzAAdq3OxKrboVR6hpbuV2pN0d3U37xwkOE7U6bGl2LAbnhPF9x3jB8S7/BlyISOQwamzWVBn4s9GJEHdEPnFDAvjaicvqHkCKR8QVroewETjkKfFka/1txoNEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dymMHJG//ReZKonCfzMxW6ASKu/xKeDVKM0TtHcSelo=;
 b=Emk+7Aqw4OFl6lZESOlid8LM8kNWdpSXgxExb4382bL0JFCrx+HaADvI22c7nj0tie7E9JzhbWS4Vvgu0kBjN+glo+sJPGGEoNeJOcLt8RF5RE/18PvZLaEDtedtP50vfRoj14QoZVcUYQ+8uiY2tOEwiJzqROu/nrsnTYfwf9w=
Received: from DM6PR06CA0063.namprd06.prod.outlook.com (2603:10b6:5:54::40) by
 SN7PR12MB8102.namprd12.prod.outlook.com (2603:10b6:806:359::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Thu, 13 Jul
 2023 13:20:03 +0000
Received: from DM6NAM11FT105.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:54:cafe::dd) by DM6PR06CA0063.outlook.office365.com
 (2603:10b6:5:54::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.25 via Frontend
 Transport; Thu, 13 Jul 2023 13:20:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT105.mail.protection.outlook.com (10.13.173.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.24 via Frontend Transport; Thu, 13 Jul 2023 13:20:03 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 13 Jul
 2023 08:20:01 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: Avoid possiblity of kernel crash in 'gmc_v8_0,
 gmc_v7_0_init_microcode()'
Date: Thu, 13 Jul 2023 18:49:37 +0530
Message-ID: <20230713131937.546606-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT105:EE_|SN7PR12MB8102:EE_
X-MS-Office365-Filtering-Correlation-Id: e6bc70ef-cd0e-4bfe-2596-08db83a3de23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p4GqSHkHVHdAP+ZNdhn9uIP0IxzCsfZSd2/5QAbqIhVThqpP+ex1T8vc+a5FyEbbrdUuadoj7r/YzwSkoSlv3UWoep3sk4blmPtJ5iai6Mn6tr12NW1S8tb08pC5owCpMsC62eyYLFEDDI1pcTbRIwivJ0PUFpafDPuYwImfQyPf2LOUA0XKg7kFyHXCBObLe3Qt8d9hgHW1vTD0Ut1JPZ0L+Kjp/+uRRHt7ott9F+42yzrtEwj2DhsADx3Ypntm60VLujLRmgmGaybodRg0G+VvCYvizWSSxQeSorC9w7kv8gDWjGfc7j/7afZrUgcTnT8wJHGjnqQS4OqfFyNGUZsqetlYXPQmFqhCJii/NFnuRFoML534qWQnOqhpBs7i5M2t4at+uQ3NmjimM5L/mULVRABAolqRt7o5f9BVCWYF+Rqd5Q18DqHwnFWUNGwcUyF2hQw9j6EsrT3jNZN2+Fi4eFTLmlw1gvqK9wcqT1h5/E6LThSxBXCDowDMgzg9pWiExyuEoTJMLlWo37USRqbLWKgCU5+FLBwjYwB/xS20oXtt7nFmRynyN6SkLqsJ2W5uPJ6f26DREsS0cNyUQ3JTo3SpOKZPOdK7hjQGAbU+vpQkz1hDXooNjAO+5mTvuMEbF7ltMMmre0eqtnP8LZi2m5xVTsm5FyX+c12fkDXjdU9q/NEAA83vlUSUbXqQnACo1xm3WV0GteaS7cah1tNoXAWcO2P+RdJgnA7WrlJwhpoqZ1zA4egZXlpaEYzxsHwIw1xiuAaoCRYAoq8n1A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(376002)(346002)(136003)(396003)(451199021)(36840700001)(46966006)(40470700004)(40460700003)(186003)(2616005)(2906002)(478600001)(26005)(1076003)(66574015)(44832011)(83380400001)(6636002)(47076005)(336012)(4326008)(41300700001)(36860700001)(426003)(5660300002)(316002)(8676002)(16526019)(8936002)(70206006)(7696005)(6666004)(70586007)(54906003)(36756003)(40480700001)(110136005)(356005)(81166007)(82740400003)(82310400005)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 13:20:03.1872 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6bc70ef-cd0e-4bfe-2596-08db83a3de23
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT105.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8102
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

If the function 'gmc_v8_0_ or gmc_v7_0_init_microcode()' fails, the
driver will just fail to load, hence return -EINVAL rather having BUG(),
fixes WARNING: Do not crash the kernel unless it is absolutely
unavoidable--use WARN_ON_ONCE() plus recovery code (if feasible) instead
of BUG() or variants

'Fixes: 1104113b37210 ("drm/amdgpu: Fix error & warnings in gmc_v8_0.c")'
'Fixes: d68f1d641eba0 ("drm/amdgpu: Fix errors & warnings in gmc_ v6_0,
v7_0.c")'
Suggested-by: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
index 0629b6808cb1..6a6929ac2748 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
@@ -150,7 +150,7 @@ static int gmc_v7_0_init_microcode(struct amdgpu_device *adev)
 	case CHIP_MULLINS:
 		return 0;
 	default:
-		BUG();
+		return -EINVAL;
 	}
 
 	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mc.bin", chip_name);
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
index 23bfadca0fc8..5af235202513 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
@@ -252,7 +252,7 @@ static int gmc_v8_0_init_microcode(struct amdgpu_device *adev)
 	case CHIP_VEGAM:
 		return 0;
 	default:
-		BUG();
+		return -EINVAL;
 	}
 
 	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mc.bin", chip_name);
-- 
2.25.1

