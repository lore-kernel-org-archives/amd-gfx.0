Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D71DC48291
	for <amd-gfx@archiver.kernel.org>; Fri,  2 Feb 2024 15:32:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B95810E7E7;
	Fri,  2 Feb 2024 15:32:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zGXROckd";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2082.outbound.protection.outlook.com [40.107.223.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 345BD10E7E7
 for <amd-gfx@lists.freedesktop.org>; Fri,  2 Feb 2024 15:32:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n46FVif8Ad0E8y1FgUMrBLashQc+RIkca2cA4d05mhpXgacr1ohuApkHs6GuoqZEqYdXphvKtJBqwSOIcVJdfzDnd2fPS0f55ZXKplYjvlLSizmwGG3SPLNg303WWOxjTNlILJDk7CFMWMIk/GyP8xRfn+tDcMmwJ764vXvFGz0ynAPbGmwxFsywXskr+2RGr6MnCC7JmtSh8XUWoWcczEtN6xWAO2YT5sIXKOc9pmtjCft1PonRxR/pIaBj320s7Fgj3RdC/DvXyO34DaMLRs+htPOY54/322Eaq3GwUK5aiKCaRToxu5tMD8cKgjWWqHXG4qISe2dMs4Ao6tUYxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=32+noRnK3c4SLbT2id0ZcAH8isepnabR6gDoEsqHj5M=;
 b=Tg14OoriAWCb0aGroDwcuX5ZawJsk5VhwJwBIyACvSIcghkd29VTxv71k3E/ZjwyJwDoL0RgV4gPi7lO9Wo+zt2ELJVMLhq/KHKLvwJzlasLTQhFWHN0Tndu2tVhJKegB0PXWWQq1JpFGdd0jFXCw0alDofaIOYrBo4UP3TBesAWh0ZkMLHYRKoKFi7yghw8eZ/HzsEIelwnv08jvc86bXVeasru+hqbSny7mVB9fz8VODH8NnwzR2IZb5mAb2/uOJitUuBQkvS4rRDPyFwjqsR6zdaFJPoLj9hE7bh83fRFQO7+nQ3Et0GbdHzLzx1jSTzvNpUhzSCdugirv1OCdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=32+noRnK3c4SLbT2id0ZcAH8isepnabR6gDoEsqHj5M=;
 b=zGXROckdrOFV+TxrNcqSGPXMqhzTTW2j2V4dqkDQf7N5TM1DIEEsHB/sVxPAzXhD/N+uwT6VEtyeBltMfyizv0dEnryL7RNszc8GzVKfLiYNIwUY1X3p65q3SDDg6ktfkGM+de0PgFB9wGqDOVA4VmZtU+zIDdA8RE7nH97EK6c=
Received: from CH0PR04CA0075.namprd04.prod.outlook.com (2603:10b6:610:74::20)
 by PH7PR12MB8593.namprd12.prod.outlook.com (2603:10b6:510:1b1::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.14; Fri, 2 Feb
 2024 15:32:33 +0000
Received: from DS3PEPF000099DB.namprd04.prod.outlook.com
 (2603:10b6:610:74:cafe::b7) by CH0PR04CA0075.outlook.office365.com
 (2603:10b6:610:74::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.30 via Frontend
 Transport; Fri, 2 Feb 2024 15:32:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DB.mail.protection.outlook.com (10.167.17.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Fri, 2 Feb 2024 15:32:32 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 2 Feb 2024 09:32:30 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v2] drm/amdgpu: Fix potential out-of-bounds access in
 'amdgpu_discovery_reg_base_init()'
Date: Fri, 2 Feb 2024 21:02:18 +0530
Message-ID: <20240202153218.1639921-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240201173555.1289398-1-srinivasan.shanmugam@amd.com>
References: <20240201173555.1289398-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DB:EE_|PH7PR12MB8593:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a4a11af-92e4-4f75-e4c2-08dc24042ca6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jno/U7fqA1iUMO26OqtCTXL2mzzAL5aQTy+swkIaZnaPqiAxHaNzQHCNudIr9se5KuD391EfeLjtCa0rO5dg5dUWA8VRl3R4qdpfsxFGw+rPcIVSRnAT5UNXBeU36WX5B861qtV3Sf4LWB5KUbQSaevvTgCoudF63mr6TxhejFTEf+eGcTsciBZKcjMZ0sG4m3aGvUdnGhnUwzcWLgMLjEjYDtjoWg2V5f0HLhqVt/DscOXDHJ49KEE8alysUsiB7C6PSPu2Z3sbHWOYMfPwQF2px/lkOihDjt0XWXxeWJbF4E1/KvKJEykdCHRtOWu+Tj26ZQrx15aHfCvuy3BNLL72Ql2q2A6r3qAde6kvRJUPz8lm+J5B2Tj9R7bkH2k7v1GGmtg58jmACpw+R7t1Z1asmPaWkxrBJgUjhJ8XxTC5uXuGCA2o9LHFa0kqcVeqJPTAZLizuj/F/IJudheEucZqYQKOBTAdvIK12ejtiRDkSgDxXWmCiW0gEzJZFa4UkpU2gfAmhBBQShrIiCzH9/6USChUxW1W32Q7RO9JJYPqU5Lb68vci61RevU2Cq4s3GXHhJ+SfDmt+OU5DpCR20ZMby6ZtmqLqL5v3E+7GMUnvZHa/cTl5zwMy1k+P5iHjToLguyU/RKUlK0F/wuh8Ty2f6plMrr1AMPyPS/vNbdE6q6eFOW2pKJ8l9Ak4bl0zxF3lryaeaBkFjNBYjYNX4/jwOsEs51sgr49XJ/j+uBiMGpmRohUzRAULhzADrwQ0gh8u2pzd8jnwRRDGhqeAA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(136003)(346002)(39860400002)(396003)(230922051799003)(64100799003)(82310400011)(451199024)(186009)(1800799012)(46966006)(36840700001)(40470700004)(7696005)(83380400001)(36860700001)(40460700003)(47076005)(40480700001)(82740400003)(81166007)(356005)(336012)(426003)(2616005)(66574015)(4326008)(44832011)(2906002)(54906003)(86362001)(5660300002)(6636002)(316002)(36756003)(8936002)(8676002)(6666004)(110136005)(70586007)(70206006)(16526019)(1076003)(26005)(478600001)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2024 15:32:32.6590 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a4a11af-92e4-4f75-e4c2-08dc24042ca6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8593
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

The issue arises when the array 'adev->vcn.vcn_config' is accessed
before checking if the index 'adev->vcn.num_vcn_inst' is within the
bounds of the array.

The fix involves moving the bounds check before the array access. This
ensures that 'adev->vcn.num_vcn_inst' is within the bounds of the array
before it is used as an index.

Fixes the below:
drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c:1289 amdgpu_discovery_reg_base_init() error: testing array offset 'adev->vcn.num_vcn_inst' after use.

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
v2:
 - `ip->revision &= ~0xc0;` should always be executed, not just if the number of instances < MAX_VCN_INSTANCES. (Alex)

 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index ef800590c1ab..93c84a1c1d3e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -1282,11 +1282,10 @@ static int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
 				 *     0b10 : encode is disabled
 				 *     0b01 : decode is disabled
 				 */
-				adev->vcn.vcn_config[adev->vcn.num_vcn_inst] =
-					ip->revision & 0xc0;
-				ip->revision &= ~0xc0;
 				if (adev->vcn.num_vcn_inst <
 				    AMDGPU_MAX_VCN_INSTANCES) {
+					adev->vcn.vcn_config[adev->vcn.num_vcn_inst] =
+						ip->revision & 0xc0;
 					adev->vcn.num_vcn_inst++;
 					adev->vcn.inst_mask |=
 						(1U << ip->instance_number);
@@ -1297,6 +1296,7 @@ static int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
 						adev->vcn.num_vcn_inst + 1,
 						AMDGPU_MAX_VCN_INSTANCES);
 				}
+				ip->revision &= ~0xc0;
 			}
 			if (le16_to_cpu(ip->hw_id) == SDMA0_HWID ||
 			    le16_to_cpu(ip->hw_id) == SDMA1_HWID ||
-- 
2.34.1

