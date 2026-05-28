Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E0FDCD5BD1
	for <amd-gfx@archiver.kernel.org>; Thu, 28 May 2026 06:42:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 730ED10ECAE;
	Thu, 28 May 2026 06:42:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pHs6qeeA";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013066.outbound.protection.outlook.com
 [40.93.196.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2268510ECAE
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 May 2026 06:42:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vcVRiOvL+dm4EKf5A24ak3aKrp/YPcjfFpLHob9Fxq1eNCHIKLgxpjgnFLkdCoMPJ4fRCIDhUQ/K5PDBXPlr23XBN0hkpbhtdPWkPU/Y4QrLNotu0NK31AMmedzZE5jh3/ZZhdXBhcokdpYC8NH/0Gf/saQZKhrycJJENBPa5eGoumZ/WQcvP5fQzsrc+Yof1+MzTtjRmCVezOYUMjh3eaJkVCCU77Hbp3KQnsJoYZgu6bLDDyd3NUo6lvdzMYjlwS/S++ZXOJx91ibPhIeKkBJ0gdyWmbMeLrOKH5cmeJxppybVLNkJmWxcKiM3vHDnFbB7OUFqmMl77IqGGTlydA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EkF/57fGLTaR2rqlN36c+6dYDiCBMb2D9LX0tHL8LCw=;
 b=yeAOjSg3j9C8pUt1LAcip9dOIwg/NjlDkBaiscv1rYLijuP5N+sh4+FYzHNiBjVmMJvVtb9DdDuBtqxHUe+C3/x/TzQ5nZuBMeTZco24R4kHKYRdhQtFT+6M5JBU4Y7OLkepKLdZgQA652y+oj6v12BO98XkjChZzzQ6TIK9P4vbVD9Qm2MEf8bbPyzWLV+q6GOaSr8uZvV9ZnkulWAPToWxAAufPUjfbIgwU1NywGtFV6JcVL3s5rH9SK488qYogJ3CzmabydrU0br2zwEjF2SVaj+Z+OMmwHgDOs72S1heblmi/45lM9fO6s7ijXnDfxmSSm53VnXzUi1MK/hcfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EkF/57fGLTaR2rqlN36c+6dYDiCBMb2D9LX0tHL8LCw=;
 b=pHs6qeeAjW1ZrrrRoMymjBoDW5pPPPgRgs+6B7TCw5fFwdE2m+KRfK/9pHb/Wi773Wos1UIE19NU+EURcZBtrV2HY3H5zYvVCxNPxRBrQeMzVpYUsPX22CrvNswo9jSf+daZ/hkmxsXGmoSHZ+DWJ/ylPkH1fr1WUeQSj2J5JrM=
Received: from BL1PR13CA0086.namprd13.prod.outlook.com (2603:10b6:208:2b8::31)
 by IA1PR12MB7495.namprd12.prod.outlook.com (2603:10b6:208:419::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.13; Thu, 28 May
 2026 06:42:34 +0000
Received: from BL6PEPF0001AB75.namprd02.prod.outlook.com
 (2603:10b6:208:2b8:cafe::ab) by BL1PR13CA0086.outlook.office365.com
 (2603:10b6:208:2b8::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.4 via Frontend Transport; Thu, 28
 May 2026 06:42:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB75.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Thu, 28 May 2026 06:42:34 +0000
Received: from BLRPVISHWAK.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 28 May
 2026 01:42:32 -0500
From: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
To: <Alexander.Deucher@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
Subject: [PATCH 5/8] drm/amdgpu: add support for HDP IP version 6.4.0
Date: Thu, 28 May 2026 06:42:03 +0000
Message-ID: <20260528064206.12358-5-Pratik.Vishwakarma@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260528064206.12358-1-Pratik.Vishwakarma@amd.com>
References: <20260528064206.12358-1-Pratik.Vishwakarma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB75:EE_|IA1PR12MB7495:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e4776e7-40f6-4cea-547e-08debc844cb8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|82310400026|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: YIuxiQ9INgpKklUoSuiNZHuEX0y5DHJTF/5FV6BGiRtwfnhdxX++7GML2GzLFXv+Svx7ZG9FVKiNPndlaUyoL+8Zj/E4FbcX3iwJq+AK3bDP+8/DA9oK2qDTilA2doO+mx+TKQEpx49XTUuIHok/varFh3Tvqw9Q8ViqEM+ipQCdfXIXHDrIkWoyiFTfOMudTs6euVF5jmERYMCfTCUV4tRohwfpWOaCJjNap7tIyK3KEseslYy7WS1jPJK7WxYW5B1ApnU5hPWabBBCHJgCyCzA+eHZ8yDK6YXq243B3sIdJQW0eTQryDfo4XCr2Atg4aCLYru2IHrHuEHAcHMm+/VAzn5tN98C0B7KedwYZ1AHjmFEj8flChHbrF9XGCsHwsCmtnqIIMnmq6bX9WfzSorlju4dEwYueHHFLWgQSxA+5uUAWW95/TEtyWM4EyJeXI0kCRAIrO4tkKKqGMRpJ+cnVJpfDjUtph6HB6eVEos4ytxJ6GAKWpLj1CFV13IZB4Cln96sVKftT3E+OTu0+GxHxW6Y00I2wPo54eqZHfDwnHByDfZGGu74eEYtqzK33CQ1XzEvd00fSABvsonQAdCsXZK6OcY4HBdd2lrycsQi3E0RcfunOCAyHS02Zq7g0uMqurq+FAFpDEW4KbuzPisi0NIMDo3Dy20p0Lz19NbOqtnU7dMx3O2GT8JeRbtsTfsdP7lC0R/M/Yai0ApspeZW5Inxy/mGXmiBdvFk7j8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: hGpv0Le1S54nvK/l6ROVceIzg0+GoQIlzyqk9RK/chmrWj/4ghrw2c9NJbVVWGLLq1Zwz3Zkb4ZQFST/hsNakYYFZYslmLEmX8S47AWpFVZVST1VXpug4ChGqj4ahBjh8K/IACRApD7y31Yqhr35X2obbMVKTx5ujW/QZMRw5zsNwHB+16rXmS4rNJYggalIclf1kcQitXB08PUZPQjtmYMLwdvDQdpL7AIHzypsLwXUhw6ycLzOtrqGU92pjGbWFGZv3yNtba8noXA3GwVW6r3FiyV1KcA5/0h1avNNFDCRv3aeCbb6e99YOFkpeSQ8/lC4hSLib10YAwjjUMhtoFHq7wVqVG1dyGjB0xvTEjRCn9OJjYRVvcBdg+dvHszOw+I1V4z9nO5iqIaHblrlkB7mfjsnbQjE6F24fztoha58W89qH08AtpQpFDfftu0+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 06:42:34.1614 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e4776e7-40f6-4cea-547e-08debc844cb8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB75.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7495
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

This initializes HDP IP version 6.4.0.

Signed-off-by: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 968cac5bcd5b..1af18c820d4f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -3242,6 +3242,7 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(6, 0, 1):
 	case IP_VERSION(6, 1, 0):
 	case IP_VERSION(6, 1, 1):
+	case IP_VERSION(6, 4, 0):
 		adev->hdp.funcs = &hdp_v6_0_funcs;
 		break;
 	case IP_VERSION(7, 0, 0):
-- 
2.43.0

