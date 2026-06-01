Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD328CD5BD1
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2026 05:53:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7BC07112DC9;
	Mon,  1 Jun 2026 05:53:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HX9AMYC5";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012030.outbound.protection.outlook.com [40.107.209.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B2A5112DCA
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2026 05:53:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bh0BsGMd+BDTvWsVQp1ZX8fdQL2l9YirQhBefpjiaWnFLB+Q/SfM4bKbnRKYVmbUrCmaRWFkZCM6/yBn2exS/Wwjqtwgnw7PLAPF7xy6kUVMxdLsBRR1wSLBSj7YgAIXhi+owPaTt0Ck3NMC0SGDg56208IpyH8czu8HhLhtH5z1P19DMCPlbgwINlB08O0tJLUumRXg+W8olPUnxeWLTv/wzn2qKdvxm6sdPTuerIQCzzu9mQdYgXMBYTghZRfiZXRgaVQM/4hrFe23pVCOAzbyHWqEctKfLTN7cs8105ofRUZ5NNxnOofmD6z2/4XPrJovJ6pcC64CVNKt4+61Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N+y6kjRRuVSWudpeiVCdYOM4BjNF23t+g8T4Z4fAUKw=;
 b=Sa71BUFSZNzuaqGLkqHoYyrvAnbOCIIJs2GKd817c682ciIuuCaA7FxNf73Xm2+07SDtiB1A+RWsvhELmBsO673pg6p285kXKkES/xKrM8qNflNuu/0SUIAQ4aOTEe7Gl5WJBEE5FbuI/t1MysiJ1v3Jzu9m/eCy1wuMmWN2+dsY8btHD+cwzmwHtZACcY6/wUDdI98WHNJR5hncFlaYVUW4DfuAaeonY9VaeQtm6Ra0YTYcWxNEu9ngfS2OqOTCpm12b9Qgp6phHP+tbaGbM8qdhBiAHFLQdHBQOtyA+EmU6t30ws9a1D4Ots0m/cdPshitrhmnWcyNcmieIvdxng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N+y6kjRRuVSWudpeiVCdYOM4BjNF23t+g8T4Z4fAUKw=;
 b=HX9AMYC5YVCny8SPfP8VCOSvOoJTy37xlkKb4rzmpmF/GwlNIG5rbqRVeAVFRhWRuqQhvu1Lih45cEs7WMLK82KuoxGoKZp141qBvKGky4RN1gdHGmEToVYsxfgqSE1S3Wy9d5UaRRBS+cb6DI36CU5K13B3errwK5gpIP/tJGQ=
Received: from BN9PR03CA0775.namprd03.prod.outlook.com (2603:10b6:408:13a::30)
 by MW4PR12MB5665.namprd12.prod.outlook.com (2603:10b6:303:187::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Mon, 1 Jun 2026
 05:53:13 +0000
Received: from BN1PEPF00006000.namprd05.prod.outlook.com
 (2603:10b6:408:13a:cafe::14) by BN9PR03CA0775.outlook.office365.com
 (2603:10b6:408:13a::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.16 via Frontend Transport; Mon, 1
 Jun 2026 05:53:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00006000.mail.protection.outlook.com (10.167.243.232) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Mon, 1 Jun 2026 05:53:12 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 1 Jun
 2026 00:53:12 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 1 Jun 2026 00:53:05 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH v2 20/42] drm/amdgpu/userq: add per queue reset callback
Date: Mon, 1 Jun 2026 13:49:06 +0800
Message-ID: <20260601055034.3700921-20-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260601055034.3700921-1-Jesse.Zhang@amd.com>
References: <20260601055034.3700921-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00006000:EE_|MW4PR12MB5665:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e70d924-027c-4923-07a8-08debfa21120
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|1800799024|11063799006|22082099003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: 7onXH+O6F1AABtQjh2M2j9R2vgG2f5KF0DsBD99/73YDBB03u3hsaJzAuUdMGGbkxPN+ysrvmpRhc+ErZBGlKySQJd3A/nJUyd61haZejggkHNLtUBU6AN/CKq02LYzN605KpLDmbzvD7FeHMJd0ZexVdy7ER3g0pk6ZFIogMyoyO1Gsv4/l+MZOYYgD7BeFgjU3Bdv515fJxkI/oXgMiNlkE89R3jc9tObpNeWgZsz/yn+ZcjDPHJ49wpAGvmYDibHEGMDWTAHCo35pFFgwmfXyka+TB1kPVOVMsl/6oOl8iCvji1y9AdMJV5gUuBYQBRgSXTrL/cbVxSPW72f0Dl+qQtlGfc82WB9wsWk6LvdrU1gruoF0CwKJevOWSbqD9j6KvU/oeaV9TSYqiZHiJTwq+xr4n1jFfBa5S5h6xaD/YpC/5R5BP0glLVmv7+0v+nPe/weLUmh5yLy2xdLFEBmhtlr86yaLDed/pKMY+/5Z+AFcHpdDAUAY3lfiCOLHsfALjz+X0GecmfR8UbcT3tNKRIl/s/eCAeiVQx5uRaODdNAGMLdrZXvwQLYnX4LlpzVB38B2YN0T2oQDtQ6H/sdN0Pr9ct5TimKH5keWfl2cgEVwzHLayOlAv44cqsWqamAZ+LkHvYOpjNUOqEDCqKB4cimpjhMw0zMmAlst/ZXmt9aC4HwPz5wK6iphC7tQjaq4pjyGNFTvEYZkKGTgz/csH36HDI9Td7pQNgR92hU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(11063799006)(22082099003)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: HoAuyqCJ85Pfb7Wh+eZhbhzFIJvk4amxBUuFeSMDhmM+DOrncB2jyQWQhnSTZWzRQU3frgO/ErtGviHd17WKaPlA09dhTNnGOwx4KO7y7NZJMFvIXOM+B7OJeW3hDPwVWsURj+m8aVS9UD/uJYs7I0St4FLEs45ktDyzNNSFJigi/Luih8qcXRG3BwJEr+fKti4buZf3IXr3+HVqMrHe/LjX9DwyGJk5y5pw4bOrh1ogTIjyUp8JI85//NW9lzA2Uk1To2YfSDoBP8H5hvjoucFHcemjYvAw8/sSt6VUfcWbVuPNjxAmKZI2c9oiMLnriv4J938oM1+EWl5JeyGjhDaOMDQ+DuUQ3GB5zHBf2Gq+zrqEpfJwYJPB9TMMQWsl0cDK0RDWJ4LSEiMSezLTXSA1LtfYfU+taSQEIEYfNErAdYG1UUC3L5LDPISlzCNb
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 05:53:12.5673 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e70d924-027c-4923-07a8-08debfa21120
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00006000.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5665
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

From: Alex Deucher <alexander.deucher@amd.com>

Add a per queue reset callback.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index 49b33e2d6932..2403a5d990f2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -108,6 +108,7 @@ struct amdgpu_userq_funcs {
 	int (*restore)(struct amdgpu_usermode_queue *queue);
 	int (*detect_and_reset)(struct amdgpu_device *adev,
 		  int queue_type);
+	int (*reset)(struct amdgpu_usermode_queue *queue);
 };
 
 /* Usermode queues for gfx */
-- 
2.49.0

