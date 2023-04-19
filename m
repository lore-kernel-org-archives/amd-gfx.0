Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07462C6FD18
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Apr 2023 13:15:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A60FA10E988;
	Wed, 19 Apr 2023 13:15:57 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2071.outbound.protection.outlook.com [40.107.95.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7CFC210E988
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Apr 2023 13:15:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uf1PdCzxMSYR3lBqDHrd69LYyWBzTd+N0zd1pBqU9VMyFLjeFaVVaHhgqOeLvchZsxYeNfyr2skL96mgqQuaATI6G+WYgkCueqVU0t7kR6tubL1RBsjy74VoQ/XkvIhnmAsxz6QXb99fPMsM72pXXoJHhbHonFfQqAwNqCbd5uR5v00eiNPL5OKsC3dQdYzQAvLftdk6C86ESbBGs1+fmBf84ieokCRlCvzsPjFRv+IR4tD+SmiHPFkCqL1WE/0TBHwvdR17VnJMjlfhIog1gckWVboNlmxeuC3VnQdZciwysJpmj96jiYK5OgKyxHo1Euodb2esrIMtf+wIbDQkIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z7zeKTOQj45iFDQIc8n0msKmQTTALJauqQ6I1eSTCaI=;
 b=duZLKPA8ohPB9jJiT5hoiOnSFJSgt2Y/1wgLIaYSmD1Furl05gXkYNB3x2ClU77PNsx87IVwomv2UMHloLmcxoeiI6qviydSQhSm8hKAmpkmf5S/wrjie4kgwVZ6urLXtwTLM2IQ0sjJQGfwG/GF9dFEE29bZtKZfo8xK0gMQ5uvY/ys+aXxxEm6cNkLX/lR8zeg+KNeXTHwRp/3+PSoLTuT7X1qO0bXRrnIHWyEcGXxv3GApe4d6QMBAhpylzA2PzkeEbGI2vLg0URDTIV6JAzWP+ZN2gCnxbg/2EV0OIrCNzRFMU+aR+U6yajwUBlgPiq5pFnXXJTkvcCUR5vi7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z7zeKTOQj45iFDQIc8n0msKmQTTALJauqQ6I1eSTCaI=;
 b=b4FAzUFsIRB1toYbtiu/GTXnOe98D6iHVCYzBSJkrKK9h91z8DrfUEkt+lmqB6SzjtOfYF3oA/zSVNhQXBWNyfhouLVrR/Dfjv2tIPQ17zEOazCWsLuGlfynb+I2qTrgzjA5rQPLEcitO1dd/FCQe5Amm7f3GNwidtKkYwuai70=
Received: from BN9PR03CA0781.namprd03.prod.outlook.com (2603:10b6:408:13f::6)
 by IA0PR12MB7752.namprd12.prod.outlook.com (2603:10b6:208:431::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Wed, 19 Apr
 2023 13:15:50 +0000
Received: from BN8NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13f:cafe::ea) by BN9PR03CA0781.outlook.office365.com
 (2603:10b6:408:13f::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.47 via Frontend
 Transport; Wed, 19 Apr 2023 13:15:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT056.mail.protection.outlook.com (10.13.177.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6319.22 via Frontend Transport; Wed, 19 Apr 2023 13:15:50 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 19 Apr
 2023 08:15:47 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>, Mario Limonciello
 <mario.limonciello@amd.com>
Subject: [PATCH] drm/amd/amdgpu: Fix style issues in amdgpu_discovery.c
Date: Wed, 19 Apr 2023 18:45:18 +0530
Message-ID: <20230419131518.234133-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT056:EE_|IA0PR12MB7752:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cc71b0e-c377-4483-652f-08db40d83273
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 88LqXhVD9f7ErRZXTX6tu52JFrpX8xfDuX1xXg55nktGU+LQYnqk0A7ahp2ZZa11AOmhHIhIVE2Wa6LkBurgFyRXKFjrQ1+n8VXGjxYy5ueO83kpp3nCgNet9i+XGerCnqkKeMingka1sdJNGUW+esjFOfKz6RD7qEK157tUrmheEUSaqx2riME2uP3GgEJaXd9ID8d5zKrFl+b+89U9vL7bcSHEPnafkhoF6qLC0PIxRHeAIDMzGDSg0t6/gD0CKFhR07wtIlP71gGC2/nSaaT2a4jH4TZGviE/tNsuYwPAFZ61z+qc5LH/UvUsLtEs83KN62iG7ZRTu7ZMJMiGxquWR+DmhmuAUrrgAsj8kd+pFWFrILVhK0RTlrfMXG7l+9EVP8J32gdZOFhCHCsE3zEd38e7W0k3Y8hrYFn7Glu2SpEAav85ha5rJQs72UTMj7Xg29qbZtT2dCPRFLB9asNbvqUOPWGEpvFtDonVAXvSZHFdGQeMK+VBBrUXFi8uzAcIf2GyHR8btoorPb8pofTjX6fpttqjvJLJtaaucN1cYvXJ6LznafGuLtKpn9WKPziQgnU6AxGI4kxLOtwiQ/8QZPx3h7eHy/2OXIiPicE8wehWMMZRvi6nTSm5ru3ISM6SKj5me0KPpGP+wVy6/rJ+q2rncbMsnXy3c5+t01tnCBA21QIs9LjaYtf6439KFdEG3/T71cVFMhbGZjTuCd5u3gFHvC6EccCMX3ec89o=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(376002)(136003)(346002)(39860400002)(451199021)(40470700004)(36840700001)(46966006)(356005)(81166007)(2906002)(82740400003)(40480700001)(40460700003)(478600001)(6666004)(7696005)(2616005)(83380400001)(36860700001)(47076005)(66574015)(26005)(1076003)(336012)(426003)(36756003)(186003)(86362001)(41300700001)(5660300002)(16526019)(316002)(44832011)(8936002)(8676002)(82310400005)(6636002)(110136005)(54906003)(4326008)(70206006)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2023 13:15:50.6125 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cc71b0e-c377-4483-652f-08db40d83273
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7752
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

Fix following checkpatch errors in amdgpu_discovery.c

ERROR: space required after that ',' (ctx:VxV)
ERROR: space required before the open parenthesis '('
ERROR: code indent should use tabs where possible

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 0ecce0b92b82..0ba013275dc1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -311,7 +311,7 @@ static int amdgpu_discovery_init(struct amdgpu_device *adev)
 	if (!amdgpu_discovery_verify_binary_signature(adev->mman.discovery_bin) || amdgpu_discovery == 2) {
 		/* ignore the discovery binary from vram if discovery=2 in kernel module parameter */
 		if (amdgpu_discovery == 2)
-			dev_info(adev->dev,"force read ip discovery binary from file");
+			dev_info(adev->dev, "force read ip discovery binary from file");
 		else
 			dev_warn(adev->dev, "get invalid ip discovery binary signature from vram\n");
 
@@ -323,7 +323,7 @@ static int amdgpu_discovery_init(struct amdgpu_device *adev)
 			goto out;
 		}
 		/* check the ip discovery binary signature */
-		if(!amdgpu_discovery_verify_binary_signature(adev->mman.discovery_bin)) {
+		if (!amdgpu_discovery_verify_binary_signature(adev->mman.discovery_bin)) {
 			dev_warn(adev->dev, "get invalid ip discovery binary signature from file\n");
 			r = -EINVAL;
 			goto out;
@@ -529,8 +529,8 @@ static void amdgpu_discovery_read_harvest_bit_per_ip(struct amdgpu_device *adev,
 					break;
 				default:
 					break;
-                                }
-                        }
+				}
+			}
 next_ip:
 			ip_offset += struct_size(ip, base_address, ip->num_base_address);
 		}
-- 
2.25.1

