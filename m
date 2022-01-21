Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF8EEC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Jan 2022 20:22:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 626C910E1CD;
	Fri, 21 Jan 2022 20:22:42 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2087.outbound.protection.outlook.com [40.107.102.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E031110E2FB
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Jan 2022 20:22:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SxlgJs+eiB1QGk6Zw164O1MVTzzumKGIiyYqQYA0DFra5dfE+xb8IUt+PCUNUiqEBSfdbiCiinaaC/gKk7VKjkHj4pG3vwKo2AEcaTt/e9obmkK3c5ZVQB+1dOJx6o30n7S+uS9b/kfiLT+crDoK2yKWrurCZxodExYv1mk8zfBh6yckEs8NQoA1isrFWQAQUnOZ5mA2ihCmV6zTiDXeuS7PqSCgZrP/an4Zk+CT6obvKCDCsiHy/HpuYhhezvRIc26FN5YEvNMSsVZiHVOHQdh/Ko/7qqSh/WZdWsr1o91iNEhAuhzuo/9BS+OYYT5ZSsuJdDpmybK9gTw+GZk4pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=POluszu9xC8sUUbas451eUL/SKHtJXgGXFPM91PQwmM=;
 b=YGH889BCwFr+0/gpJh11RKbyqsD4xIYiL/a01UBDzAwHEfzdnKDqEs1C7Isvsd4sRot85Z9jAKqGz5ZIEaPimQhwqTlfwr6Fvjgf7G7Vme6D7++1DQOAYoip5nL2DtAXdL82kvst3OSfyiNSNpJkHtGTwPImzFhBZ6+NOcApZVqpwdPgUP/+8lleD73YohbqDR6mNgHz9MeSyqTno3o7WfCESflGzixvvCEV+CbXk8ioLoOLQQO9B4LSvEU6pLXJM9iETwweyl4wdPBgEauAB9mzm7YKw56A9DVuUPP77PsrdP6OOMeiQ8XYeqbacb33A5ad/69MQaLVseHLAxzyKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=POluszu9xC8sUUbas451eUL/SKHtJXgGXFPM91PQwmM=;
 b=mTcTp1H7covkLJWXusOBRiimJLgeXD7C3+dXlvGSSZ41CpAfCeoa27iOfTO1SinYuFuBNXkwTQuCXg9lc8LLat5ogDOLhvR4frhkZ9B4zkaLNBwlMjfEG5qMo9jhYw0bSNCzGKfxiOFjXHukMddTd1nsYdKfxxslTfOiKrWr3Vo=
Received: from BN9PR03CA0549.namprd03.prod.outlook.com (2603:10b6:408:138::14)
 by BN6PR12MB1633.namprd12.prod.outlook.com (2603:10b6:405:5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.12; Fri, 21 Jan
 2022 20:22:36 +0000
Received: from BN8NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:138:cafe::34) by BN9PR03CA0549.outlook.office365.com
 (2603:10b6:408:138::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.10 via Frontend
 Transport; Fri, 21 Jan 2022 20:22:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT037.mail.protection.outlook.com (10.13.177.182) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4909.7 via Frontend Transport; Fri, 21 Jan 2022 20:22:35 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 21 Jan
 2022 14:22:35 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/5] drm/amdgpu: set APU flag based on IP discovery table
Date: Fri, 21 Jan 2022 15:22:16 -0500
Message-ID: <20220121202220.5557-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0113d3d7-ec2d-46b1-59c3-08d9dd1bc32f
X-MS-TrafficTypeDiagnostic: BN6PR12MB1633:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB16337C98398D61B98A1618A0F75B9@BN6PR12MB1633.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:800;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kZC0UBSEQGvbSkPEb683ppOZL11gUsEu1ywllF2VOX3xduy4OV7EhG+f1Mhj3eHOba0ddDXa22KwZv7xP5fTNsSspq/bbLId7vDQamqlTpZmYQ0/+l8/3fVaJ9EjgYtGPTOgQ7dIaCWqNK0i2JIyZbnrPkOSjHqrDBnrpVFcqhkrRWIpTGQYRTqcf7GHnbfKBOjwbUZaUpiwAEOoIhsgFU4fqkQIseDowBEjIt2E9lX/DR34jmiPkEtIl4gQ3SkuEJ+eG4k4OC7gDluWeG+OdiWg9nJnARCv8qxB6ljzGjV3Ijp/CHpIPSJMh8d7Q33IYLsBonqhpp/1Ru3bj+NppYRoxjW0gGWQ/RhyKuuwSts6cPmivYQKKWdf58i3lTYs8kLmxicGNLx//sr/7GD5HCaFF32o0rTxshCf30BPP2aJdEjEXO80Koz20ti+87P4DHGiRDpdQJepXuMQV1ifpE+apUMAcC/HjRmD793bWfhGGi0JheQuo3+6nckxfG3/J3T1yZSb+0b6Q/B02xmzt7FRqpySO0srNc5tG59+aQhvLJI0BH3ZbALejanBCmX0KxAR21IaCOZNls8dE71w/PoEPVsOqY5kX7wFctWPsj6OtN2PlKJgRfvIkmek8IcuwaCOSBDageM0tSVx3EFMiJvq8sHtvOUKiMiiXMAB486Qw1r/vB1Hsr3T+xKMm92QEVzmhoFxuleWJkGk5h9Fa385hhT3uF1LxdQAYBXDSO67ufrqb6/9EzfC02k+RMA5eHnHFaBWrEFILsNLxWeVfqqQCetZJHzwRuBDH/DsSvQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(40470700002)(46966006)(40460700001)(47076005)(8936002)(16526019)(26005)(2616005)(8676002)(86362001)(186003)(2906002)(426003)(356005)(82310400004)(316002)(336012)(83380400001)(36860700001)(7696005)(4744005)(4326008)(81166007)(1076003)(36756003)(70586007)(70206006)(6666004)(508600001)(6916009)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2022 20:22:35.7682 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0113d3d7-ec2d-46b1-59c3-08d9dd1bc32f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1633
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

Use the IP versions to set the APU flag when necessary.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index e6a26b554254..ddbe13c9e4c7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -1253,6 +1253,19 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 		return -EINVAL;
 	}
 
+	switch (adev->ip_versions[GC_HWIP][0]) {
+	case IP_VERSION(9, 1, 0):
+	case IP_VERSION(9, 2, 2):
+	case IP_VERSION(9, 3, 0):
+	case IP_VERSION(10, 1, 3):
+	case IP_VERSION(10, 3, 1):
+	case IP_VERSION(10, 3, 3):
+		adev->flags |= AMD_IS_APU;
+		break;
+	default:
+		break;
+	}
+
 	if (adev->ip_versions[XGMI_HWIP][0] == IP_VERSION(4, 8, 0))
 		adev->gmc.xgmi.supported = true;
 
-- 
2.34.1

