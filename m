Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 708EBC4332F
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Apr 2022 18:54:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 003A210EA30;
	Thu, 28 Apr 2022 18:54:08 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2055.outbound.protection.outlook.com [40.107.93.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B5E810EA27
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Apr 2022 18:54:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hC2vhwm4f6enFxOJ9SLxm9Zg2+vivgJAGrS6wBTrrimOEhKlBZnUMPW3zZjFfgQjJYS7j8v+Jv1Z8Uw/TOraZIslNhQxxwGilaue+3zxCxsg0xxJ1oXN0iNqlh0Crn/Fmr6qYeDlaX1gNOGVw4sGDZn+6pAT1pAecsAh4o7R9VvY3Z4GsuHistJ5MRGAKAAKnzrzOjaTtmG5I0Te42/IUNMXOqaggtsTwQiS7yx3/vqbSX9cIFUniEi1wnnWXJlmdi5wZ9wzrrhvatH110Jz/TKQ49utvFKUnAe2jzYwG6MBUn0AIZh7MvAiQYa4CyhGm1+lbNrD22q2DOnKihtZbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V2JpS543eQf+dCibvt8X3E6X7+VZQIjb9zWuhRosX00=;
 b=c+IUVVBVeAzxy4DYjahHW04uohZTq+wH0jEqIeoTOFc0M3VUzaDYwEgq0hc3yAqYMJIyHL5EM/KkUfl6M7nxZF4bxvf4WXy/FMQVMc6UxrVGY8En1B8lhn3LkUfVTV1BvajNHv1QsySHC0fb4EuSuLLg0W87qfggMmeHk3Otkmlm7HMDhssNu1Lau7t+tExTIo3V++YQ2u/2WYu3FFfMGZkvLQ877q21yqiGeBOWnHPe98RlMoP6kg73ev1UrGkAKhjzJt7ZsbSUscK1LhixWlUS0U+tMxaw5ic10YbrSBQmNHR+LdKGieoesKuhm63ijt+Lp3mJRfcgLiw3Jjcf6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V2JpS543eQf+dCibvt8X3E6X7+VZQIjb9zWuhRosX00=;
 b=SfyO7yxeJwl8n7b7Y47YlkL2tJcxh2tHCKhqZEgR64SWWS68iNRs13HkslzRbNxHLUCooA6zz9tZ/AW7Iqi2XMTg6+cpSP2zw7mfBkvYrwfakcOIHnQUmuj04cIvM/xwvCstCeyLFGvGjHX+tcVN5Ggq7xyFPMBlUCjIsSv/B1o=
Received: from MW4PR03CA0108.namprd03.prod.outlook.com (2603:10b6:303:b7::23)
 by BN6PR12MB1684.namprd12.prod.outlook.com (2603:10b6:405:6::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Thu, 28 Apr
 2022 18:54:03 +0000
Received: from CO1NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b7:cafe::da) by MW4PR03CA0108.outlook.office365.com
 (2603:10b6:303:b7::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14 via Frontend
 Transport; Thu, 28 Apr 2022 18:54:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT065.mail.protection.outlook.com (10.13.174.62) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Thu, 28 Apr 2022 18:54:03 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 28 Apr
 2022 13:54:00 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/3] drm/amdgpu/discovery: add GMC 11.0 Support
Date: Thu, 28 Apr 2022 14:53:49 -0400
Message-ID: <20220428185349.672503-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220428185349.672503-1-alexander.deucher@amd.com>
References: <20220428185349.672503-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a7eb2471-e2c1-476a-841f-08da294876d1
X-MS-TrafficTypeDiagnostic: BN6PR12MB1684:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB1684483ECD6ADBBDDAF5C758F7FD9@BN6PR12MB1684.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k61LLSvHGOdYr9brWniM0D5GDBaD3STMQWm7GnLFu0Jc75qgqoOF5ZNkr/8nNHc4cBdaz6EBKQecAqLRAr0TKGF8ASJzVP/yjMgXqzYAp7gk3b9TqzqexiBIyyqtBqxRRXYU67vIkyQWUAnwRetEIbTG1aAdNf0PopTmhdYZ7wnY7RDEgLRqT35N+U2PFAEwTm0nLoFVMOY+D6ygPyF1rvoj8Ny4GORM9THC7FEQLCW/pFNVZr7KdP8XvE5egasHbGxvmSLTFZHSWdyOhvmmF5YSbyGu/ify13UarjjRqC76a007gVVNchngsgXU27PH9UatJM0hrHT32lcfD5Lf/Ja9F8sQjXuxaomqjN1sHweSfbYul4Gs5mK2Q0wQ1bDUPY8x2JTSnduKiBcGvkc98YEiJjP70XE2fFiwBa3azbiz4oRHGA8Y//B+ukbxhyUmLVgwLNuE/pj6CX1HcWcmEeKZnjrpUIwZJNs27NXr3nqAJzg0Rcnsh3f/8zMKOrfgjbjpN/eNlgLKgaC5vuj3YvM/3/HrWCP/zhRXZCCBOMjdX0sESdSElGWJJ9UhnR16RYdUVhA34yZuCH09jJprN7t3cMsPxONaTvpdmJ6z3J3XdmlN6yV00Pqgf8oGznyzz+Nb3gsgZb3/O2Yl7LnuH++iGKMWXoiTeO1D/SFGZaheZ4ltDsiEnSBpVUuVT4R2ZhchsS64ayTJ2Zmby/YIkQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(83380400001)(7696005)(36860700001)(5660300002)(508600001)(8936002)(86362001)(6666004)(316002)(356005)(81166007)(6916009)(26005)(40460700003)(70586007)(8676002)(1076003)(70206006)(4326008)(2616005)(82310400005)(47076005)(36756003)(186003)(336012)(426003)(16526019)(54906003)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2022 18:54:03.2454 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a7eb2471-e2c1-476a-841f-08da294876d1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT065.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1684
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Likun Gao <Likun.Gao@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Likun Gao <Likun.Gao@amd.com>

Enable GMC 11.0 on asics where it is present.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index fceaef64485d..35598193dc7b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -47,6 +47,7 @@
 #include "jpeg_v2_5.h"
 #include "smuio_v9_0.h"
 #include "gmc_v10_0.h"
+#include "gmc_v11_0.h"
 #include "gfxhub_v2_0.h"
 #include "mmhub_v2_0.h"
 #include "nbio_v2_3.h"
@@ -1513,6 +1514,9 @@ static int amdgpu_discovery_set_gmc_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(10, 3, 7):
 		amdgpu_device_ip_block_add(adev, &gmc_v10_0_ip_block);
 		break;
+	case IP_VERSION(11, 0, 0):
+		amdgpu_device_ip_block_add(adev, &gmc_v11_0_ip_block);
+		break;
 	default:
 		dev_err(adev->dev,
 			"Failed to add gmc ip block(GC_HWIP:0x%x)\n",
-- 
2.35.1

