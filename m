Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03BE2C77B60
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Mar 2023 19:46:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D279F10F002;
	Thu, 30 Mar 2023 19:46:09 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2067.outbound.protection.outlook.com [40.107.92.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D76D310EFDC
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 19:46:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q0f6QcfMElqgbzs+7HzbVb8/jK6TWCLlKiLxdm3U9uAxoU51Bw0OU2ms0wg3EfKC2QQ4Fyyfxvo/ITKWF7MN3bkFn74CNKHgWaKC3X9dodlNf8K0EaloMf5k3LZ4StbZmGzI5JJcgjcMIXbo+9xisTfohB/zPWDg5qPgprkAOsB8MMvfJsqvugLTi9x0kgv6ah0v0l6gIbzOxKO9/+Gbhb36BD6WLetkSLzI5BdgLHr0BCOJXvvs+sN6o+/mqpf8+Cayphj1SeYwn4L1iGGfY/Ja9BRvfjQzR5aABfz3QjPvlvFITxvtvSQgfVxPr2Hux+6+W74Jy8pZyxtur4t36Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ztyLR4WjznPwhUE40k+EhH4K5Am2EOrWkgcqoPo2fLU=;
 b=gCHBwAa4hoEITunZluSU3yey+EiSyhVhx6lTIwzN1ywQgu+v/SxShsYABj7HBdINbCWocKG303Ceun35tQnnpszxtL0QFJxsBP3rpbD8dQAWeNiYhbSY2PggoDxAxP4PFPeBjP0WUWY5wiFQyN6EpkkAu5J9S0tNC8hW7eNV/JcepYrHXrV0e9meLCNFyePi3U5NNv3f057b8u9GG59DNysCMW/4t6RCfGFIzG220qNJvpRC//HX2illMp0nf8AfMNMyXEsLj1bU6nBLEKLasVYmblBtyKyBoWNwVYXvWAfmc2rptCXs2JMm9mZj5T8v1Ecs6jnB5NFVxqDPR9cdgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ztyLR4WjznPwhUE40k+EhH4K5Am2EOrWkgcqoPo2fLU=;
 b=rFNRvDlSjTw+On14AjJ0TJHnKzjMRntu78HTzs9SEJNcLTlXdHseBhrn6190gt4OATWHj7KJyXiCWxWly8+/1BzcQq40v9etelpDTG2XQtQePuoqAC3UaE86kMZ5eU50KNCQLoNC4K3HTdunBhVYRm7I3mT6yG6fCpGSzMQ5V00=
Received: from DM6PR13CA0028.namprd13.prod.outlook.com (2603:10b6:5:bc::41) by
 SA0PR12MB4384.namprd12.prod.outlook.com (2603:10b6:806:9f::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6254.22; Thu, 30 Mar 2023 19:46:02 +0000
Received: from DS1PEPF0000E636.namprd02.prod.outlook.com
 (2603:10b6:5:bc:cafe::20) by DM6PR13CA0028.outlook.office365.com
 (2603:10b6:5:bc::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20 via Frontend
 Transport; Thu, 30 Mar 2023 19:46:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000E636.mail.protection.outlook.com (10.167.17.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.30 via Frontend Transport; Thu, 30 Mar 2023 19:46:01 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 30 Mar
 2023 14:46:01 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 4/8] drm/amdgpu: enable vcn/jpeg on vcn_v4_0_3
Date: Thu, 30 Mar 2023 15:45:43 -0400
Message-ID: <20230330194547.1135862-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230330194547.1135862-1-alexander.deucher@amd.com>
References: <20230330194547.1135862-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E636:EE_|SA0PR12MB4384:EE_
X-MS-Office365-Filtering-Correlation-Id: 9498c1fd-5d70-4348-e1e9-08db31576470
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LDvgPZuOB4c1kd39nLFV0WOz1I1S0qM992r8ITgldqpcauOrrrq2YFiNn/Jsn7UGyzVaDS/onyIrV2d6dLYFNiPIFECOkjySNS3GJDTuJ+D6ZfG8IgwvbxODzOTaLiM4Hv9xAMQBGKQy8I8Tn2esEMIuShT/ju2lwhnt/PlVqRVbingQogNpycQoFn4EEQn4Hd70K5RWMr+TDQXbuKG2YkltOZUkPpC4GSPZqvRMmVqDgDtyyRod4w7Ku9lECtdDlOMxs/TKCvF//MqD+UZy3KA3ETIoORcCsDsZtKMp4yBXFjkNIpVa10yeLr8dQ1N0+uRpiDWkO11Thv1q14jAQIvQTbraH1mb/1caGdle+o7sakmVdfhT4dJe1yxbZB86FqWhVANJGwUDW4jUU3Q1GjKwTpJRwKsVpXkWGqwjYdFwHiCaet8YqK0GhqVQUdG24VMgwAXAfnVbKwwkATH1ULxm0QFBdoKRNjiX4RnSTVVNNGjcVa755+MffWcc7FSuF6YzcRmEf0/kf9pOj5izBVMcTUAgoFCtTPPXxbiQu/V2g2udJiBoMIaNhLPmmnmZrnFbORYII2nImvhye2Dfx+PtrSqSWr4/a/Dc0VPAHitzKbokxWhAErpdH0CxxswL1ulP9R7VuwZOy7YliLf1uY3N4vj9/oPrUfY0pYHz1BlC752Y5tq3y4VCTXQrmQIM3bc+jSJAXnIfIK+y1uU9XJH4riimq7f80QZw9DyZEPg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(376002)(39860400002)(346002)(396003)(451199021)(46966006)(40470700004)(36840700001)(70586007)(40480700001)(336012)(186003)(16526019)(40460700003)(41300700001)(2616005)(8676002)(4326008)(6916009)(7696005)(70206006)(316002)(426003)(36860700001)(2906002)(6666004)(36756003)(86362001)(82310400005)(82740400003)(81166007)(356005)(54906003)(5660300002)(8936002)(83380400001)(478600001)(47076005)(26005)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 19:46:01.9311 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9498c1fd-5d70-4348-e1e9-08db31576470
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E636.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4384
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
Cc: Alex Deucher <alexander.deucher@amd.com>, James Zhu <James.Zhu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: James Zhu <James.Zhu@amd.com>

Enable vcn/jpeg on vcn_v4_0_3.

Signed-off-by: James Zhu <James.Zhu@amd.com>
Acked-by Leo Liu <leo.liu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 5dc89cfa86ad..200cbb0d3052 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -76,6 +76,8 @@
 #include "jpeg_v3_0.h"
 #include "vcn_v4_0.h"
 #include "jpeg_v4_0.h"
+#include "vcn_v4_0_3.h"
+#include "jpeg_v4_0_3.h"
 #include "amdgpu_vkms.h"
 #include "mes_v10_1.h"
 #include "mes_v11_0.h"
@@ -1999,7 +2001,11 @@ static int amdgpu_discovery_set_mm_ip_blocks(struct amdgpu_device *adev)
 		case IP_VERSION(4, 0, 4):
 			amdgpu_device_ip_block_add(adev, &vcn_v4_0_ip_block);
 			amdgpu_device_ip_block_add(adev, &jpeg_v4_0_ip_block);
-			return 0;
+			break;
+		case IP_VERSION(4, 0, 3):
+			amdgpu_device_ip_block_add(adev, &vcn_v4_0_3_ip_block);
+			amdgpu_device_ip_block_add(adev, &jpeg_v4_0_3_ip_block);
+			break;
 		default:
 			dev_err(adev->dev,
 				"Failed to add vcn/jpeg ip block(UVD_HWIP:0x%x)\n",
-- 
2.39.2

