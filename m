Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2349FC433FE
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Apr 2022 18:28:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D26510F0D7;
	Tue, 26 Apr 2022 18:28:00 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2084.outbound.protection.outlook.com [40.107.223.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9458B10F07F
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Apr 2022 18:27:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LiDhHRYGeSZDe1VwMy3BMk2PWNpmCMEWaSecEa88jvlARjJIB2a8bWXmGqCarjjfOR4OqbnI9W6bTRTSH8NoIXlu0R9W53V3d7ukHfp8iK8rFtWdRz4JSisIxH0TrfjbsWTprh8YDg4+R1jgjSoS2SfPT2eRx8Dmdw/huR1lUBpObxeLVTfhYS7FkxIfEC5gjenFrdPMb/8fssB++yYGNWZWo2DTzJ8+VasXNF82muHT7pUqfVA1KgQg+U/cDniJs3ZejkYLIoFn93ZynKNXqlKGkS0gSI08kktFUnWHDOhKxEEzT90ispS2/QCNsfzsDO4gq3Hdhvm/IJobkgSN7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dSm01OJU+DGaszJCnlGvwdDcr/N+nNdW1mo8xgPx6wU=;
 b=dHh+ndAkOkpBLxILMCn6Q1Le3XAnvMxwDDLk7huIqTxLB4Dr/YfEAZbcudhezsGUmEF3F4vP7tc3z+oiXc1ha31odmJ54+BUkFeSigMt4mwImXGMDnn0JL0WW2Fi493xZy/i0WIdb8eIrvlB7/J/hSd7HfDgWDsRz8kep+ZbRjQk7jsIEsXD4qBuMOHor5NwLPHzbiasp1wK+niLaSUhkcdL+HK0k3tHhQ+GKMZHnUjGFYtZV+Z9o463zqnH2AkK6eqBMqjBqZH7W9qStOhThZpLj+ZkQQ2xGiXmbWDojAwkIn8ItZLQ/UZhL80+pbUg7fehHE51XWP5LVIwoQeBCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dSm01OJU+DGaszJCnlGvwdDcr/N+nNdW1mo8xgPx6wU=;
 b=zDVYiQU/ltsaPovd0xA286W9kYweOTqXwxlQheLpZzJYWpecCkIdJFQYsypL+a6hw3PwmNV7YHUMjTD9PvIoduzCpv6GGkhgZZDwzYUeHy5rK+Y06JkWc/6I4wKygOw8r7cuSOWvJUITbHmaikbnemWEx/y64BfVUaInr3PIAuU=
Received: from BN9PR03CA0727.namprd03.prod.outlook.com (2603:10b6:408:110::12)
 by MWHPR12MB1278.namprd12.prod.outlook.com (2603:10b6:300:10::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.18; Tue, 26 Apr
 2022 18:27:45 +0000
Received: from BN8NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:110:cafe::bd) by BN9PR03CA0727.outlook.office365.com
 (2603:10b6:408:110::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15 via Frontend
 Transport; Tue, 26 Apr 2022 18:27:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT048.mail.protection.outlook.com (10.13.177.117) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5186.14 via Frontend Transport; Tue, 26 Apr 2022 18:27:45 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 26 Apr
 2022 13:27:42 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 06/11] drm/amdgpu/discovery: handle UMC harvesting in IP
 discovery
Date: Tue, 26 Apr 2022 14:27:23 -0400
Message-ID: <20220426182728.3006737-6-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220426182728.3006737-1-alexander.deucher@amd.com>
References: <20220426182728.3006737-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f9492cbf-7225-4a73-0f01-08da27b27583
X-MS-TrafficTypeDiagnostic: MWHPR12MB1278:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB127812ADB95CCDEE615F212DF7FB9@MWHPR12MB1278.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vjuuECuTTgE26Hpn3Jzmk91dbIquCGDobdVZLk+yAvYXbE7xNKiCDqIuWpZL6JDo2cO6x0+1GjKGHw0LFoTpaIRH/86KDYGr3ocCsfnC78mNwLISiTZ5vTXwDOZdK0DOlJL84+zwFAf0hlh2k7Ymv7DNJwDO5h/l99g9khyMQkzjVP3w6rqieDnrmtpVndj1YvllBfBbUgYBwyQkD0BTkhEc2ERlTsV+bVeooM0MC9CbgFbLa7PzHkO61bWiOdKHgwf5roQcoV+Ccjy9fiViTB9BlMVdi2fF93svMrLX9GCucYfg2GzvO4HY8xjHzgm/CLHBz+Cp2l4fQYgCKkY/hrqBok1IlQuRmGk1S242HydAH2bYqecl44aCXTZQjUFzaMk2pgLUJaiLh3RYcAw6ydQgpgQHKs1kQPo2N+LP5sr9hX2skXcVwso+kZ9igzo2lgSOOQJOvQFFGIejvY3DY+O1rw0bXHdokdhS7pKiwNL+V6MXSoKM5ASvHRN/hs82fNxemeFUGpDqW/UxgJIJ3js8e7nsYhjwYf9vkDTgSG1L+dKUdZqmoHi+25qM0TwQxM5PmHZcPOYV8GaPLMwnbB5MbeHlKZEZIKv8vy1Q+/aZ2NdP3n23rjqAGvcWwvlwKdxIrsH0rHwCgcp/z3HkAfY3sk+6vLIfZbCJ0oEE630bR7MbTAqhDRJsy9w5dGg0zMRGy4ZMhw/JYkXkMjSd2A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(186003)(508600001)(5660300002)(8936002)(40460700003)(47076005)(1076003)(36756003)(83380400001)(336012)(316002)(426003)(2616005)(82310400005)(6916009)(70586007)(356005)(6666004)(2906002)(70206006)(81166007)(86362001)(26005)(16526019)(7696005)(36860700001)(4326008)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2022 18:27:45.4750 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f9492cbf-7225-4a73-0f01-08da27b27583
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1278
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

Check the harvesting table to determing if any UMC blocks have
been harvested.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 233e03f5f072..c16239e47141 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -436,7 +436,8 @@ static void amdgpu_discovery_read_harvest_bit_per_ip(struct amdgpu_device *adev,
 }
 
 static void amdgpu_discovery_read_from_harvest_table(struct amdgpu_device *adev,
-						     uint32_t *vcn_harvest_count)
+						     uint32_t *vcn_harvest_count,
+						     uint32_t *umc_harvest_count)
 {
 	struct binary_header *bhdr;
 	struct harvest_table *harvest_info;
@@ -460,6 +461,9 @@ static void amdgpu_discovery_read_from_harvest_table(struct amdgpu_device *adev,
 		case DMU_HWID:
 			adev->harvest_ip_mask |= AMD_HARVEST_IP_DMU_MASK;
 			break;
+		case UMC_HWID:
+			(*umc_harvest_count)++;
+			break;
 		default:
 			break;
 		}
@@ -1126,6 +1130,7 @@ int amdgpu_discovery_get_ip_version(struct amdgpu_device *adev, int hw_id, int n
 void amdgpu_discovery_harvest_ip(struct amdgpu_device *adev)
 {
 	int vcn_harvest_count = 0;
+	int umc_harvest_count = 0;
 
 	/*
 	 * Harvest table does not fit Navi1x and legacy GPUs,
@@ -1144,7 +1149,8 @@ void amdgpu_discovery_harvest_ip(struct amdgpu_device *adev)
 				&vcn_harvest_count);
 	} else {
 		amdgpu_discovery_read_from_harvest_table(adev,
-			&vcn_harvest_count);
+							 &vcn_harvest_count,
+							 &umc_harvest_count);
 	}
 
 	amdgpu_discovery_harvest_config_quirk(adev);
@@ -1153,6 +1159,10 @@ void amdgpu_discovery_harvest_ip(struct amdgpu_device *adev)
 		adev->harvest_ip_mask |= AMD_HARVEST_IP_VCN_MASK;
 		adev->harvest_ip_mask |= AMD_HARVEST_IP_JPEG_MASK;
 	}
+
+	if (umc_harvest_count < adev->gmc.num_umc) {
+		adev->gmc.num_umc -= umc_harvest_count;
+	}
 }
 
 union gc_info {
-- 
2.35.1

