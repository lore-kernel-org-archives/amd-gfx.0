Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC679CDB471
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Jun 2026 07:41:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6405510E9A3;
	Tue, 23 Jun 2026 07:41:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RPyCzpOI";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010026.outbound.protection.outlook.com [52.101.46.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7094810E9A2
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Jun 2026 07:41:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SwdxALjy8dDwDH8UoPS6efw/KioABy9KKi2fBF70WNFrvSylUI6YYWFsR/0n24fX7X/aDDrKaIHEEMlIbbZ4PQ+tk37vTuCIhAe4SRbsQ9cs4+Tp/BG1rDwwey2FuoqhVZBky3vzX8sPbK1WJpJTwsBZ5qYwRdafpxPRBI2PSLfy2MLL/IuofuyMc2hFoDBo7onZcAdeOiQcNxfBfm9ExaxpAssQ6rtFIyK1Txd0YOAPkNiPh0b/2Wv1IAN8TUNBLNAHk22cjeNETZyUX7o4jyo+gR8DOdYIDl66+kdUGdc9ahlTn/kOkrblFvIt1Birvo0GSu5nOsThyZOSMw7w9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oV2RjqbaO2HBjzJe14Upqs9FXfCcsMdPxPz0OStEt7I=;
 b=GwtR7F8vmA5fltMdFxfhJAeBW7NLAFwP5Cii9MtmHRYV5mgkOyeFTDqKmaT6b6eoKJJEoxz+xPkPE2bkOFXiiC+kXYfeePfrm50NwloWnVpm2gdcFsOy+TtlUFbsETrQ5gMloPM+FV99UObLLEAIlsGvI0uBU38xbWKOe8P344FL53RWrA4hjJ+ScEsnqQToycFjHekj+An3XRfNZnBrDK8k9Cclq5Qtq+gUXJEvVxzeCy50SfAPN7UCmxmZyeQbPF4hEAt2I4Qn4R0jLh1bmZShyRpGN+oZBNOirMmCpmXZiEU4/wEH6cSSChOgHefxz05oapKfmd+7CzU4wSzggQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oV2RjqbaO2HBjzJe14Upqs9FXfCcsMdPxPz0OStEt7I=;
 b=RPyCzpOIgzmP/x1ISsQkg7WjOa+URyq5sQYcaaxrY1QoXM6XfQxdMLbXEgcsFUbXm4LFzGk8mX5p6d+MiLN+714D64l3iOFuGCvS+y3xjhqOTvX4+BQuQO7M01e76tHCy3QQnIjCho3Tzy2rsl1/vEGLRa6dTGQP59988FkApyA=
Received: from SA1P222CA0150.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c2::20)
 by CY5PR12MB6323.namprd12.prod.outlook.com (2603:10b6:930:20::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Tue, 23 Jun
 2026 07:41:26 +0000
Received: from SA2PEPF00003F61.namprd04.prod.outlook.com
 (2603:10b6:806:3c2:cafe::f) by SA1P222CA0150.outlook.office365.com
 (2603:10b6:806:3c2::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.12 via Frontend Transport; Tue,
 23 Jun 2026 07:41:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SA2PEPF00003F61.mail.protection.outlook.com (10.167.248.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Tue, 23 Jun 2026 07:41:26 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 23 Jun
 2026 02:41:26 -0500
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 23 Jun
 2026 00:39:17 -0700
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <YiPeng.Chai@amd.com>, <Tao.Zhou1@amd.com>,
 <Stanley.Yang@amd.com>, Ce Sun <cesun102@amd.com>
Subject: [PATCH v1 2/2] drm/amdgpu: fix resource leak on ACP reset timeout
Date: Tue, 23 Jun 2026 15:39:03 +0800
Message-ID: <59a681f3168143ef939bdd806a2b30ea4be441d5.1782200200.git.cesun102@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <5db799323a211d12937f69a1ba28d3c740bf2569.1782200200.git.cesun102@amd.com>
References: <5db799323a211d12937f69a1ba28d3c740bf2569.1782200200.git.cesun102@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F61:EE_|CY5PR12MB6323:EE_
X-MS-Office365-Filtering-Correlation-Id: e0b10896-7717-492f-4c58-08ded0fad4db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|36860700016|82310400026|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: uOsAvt3R+rlMPb39ZdKhPFPqAqw9LQ+dTjaIi1I2B07WA80caOeeJMuZAaxMo3n4E4abYA+GgIg76QWu71korFZXeeH++JYy4YejmXNpI5iugf7gyiYiMfEmEtLgoqizmSJ2ordca6FzvJBqU9Ih8szz/r6wsBIDQLA/PdgDeKhy516aJ8bf94T/nkKP6ixovku2bcisZfohA3gz1XJtpKwZ5PWntZ0iNjGAw8u3JUBxZTyWaaE3M30563fa+udWUUhz+6Rmg1BovCeeGVW43BLpQAqvOk5ZyE9QD5zXNQNg5ecHExpO8XLQPsNKb9lazXHxRxLpo5YYHPXKYwOm//JulSHEBiOh68NBjbmoBqC6yV7KUl03I8HY+QWY02ssuCNsTNtE0tyhxW4jfzj9fNSO8SE+wO91sEx6twLetiEZ0oPDmNSM4A+lxd06jYVsHRUkQQj2fsXDQjQ4dpEfq+48QpqkvJAfiUK54qzA8iZnkfU50uuK5h4UtVE2Nj6iV4SHTzyaNPKs/El+x+4VFYLMsI3nT/hAGN02CT0CGXYSn04gWT9b6pBzB2U/sEqtN+uDYwJ6pybbP0O5eaCCWMBfvlUjtNJKEv89Z5k6OqquVQtXLwpCuC/mXLkljoEc8ZZS3oID+xURxKSZIekY0yIYKmK2FkjROuGE1wIv6OpidNV0/AjIGcxXmvW5L6GldSansMt64UHkPyJGMo1MxA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(36860700016)(82310400026)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: zVPRruemvbmeoeT+8kj5u3ddaX3d09ACx6Bbm4hvyKBXXahegoRKxtcpQdnHazkLquT2rRVCYR+Vdb9zKLuEdxDHDQbJVGBhmKFsOQiyEXvhxBv3NpURG5od+MHTB9FUH4+2Mu7bqmWdAuSezCXHGGOnVihiwf/goZfb/qby+nPdI9zEh/TbnBwiDt+SDC5pG9YsErg0pyPx5HgJSk5YZMUB5ofJjFIOXq0p1U1LdJsRAwAp0yEjxpnzb9iX5pCq8uODICi9/EIZ3zbOPV+E4nT/1ZBmhWC6aPH3/dFhHkQOoShY6zzoMxAcKXkdLMXCGWGKZZcp5XlUFlibUxdr+YXLXUXpxGSWCRcIDPmx9K4HT+hw0RIelNopY5E4Sm4QV9mKhHqrrhc+AiFP9wuS+2X3zCrjGFMFXHYYaZfalmJx/0oxhZZoWaAcLrT1+VcH
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 07:41:26.4391 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e0b10896-7717-492f-4c58-08ded0fad4db
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F61.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6323
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

When ACP soft reset poll times out, original code returns early without cleanup,
leaking MFD child devices, genpd links and all ACP heap allocations.

Replace direct early return with goto out to force run all cleanup logic
regardless of reset success, preserve timeout error code for caller.

Signed-off-by: Ce Sun <cesun102@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
index b0db0834bfff..1d77d0cd3ec3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
@@ -510,6 +510,7 @@ static int acp_hw_fini(struct amdgpu_ip_block *ip_block)
 	u32 val = 0;
 	u32 count = 0;
 	struct amdgpu_device *adev = ip_block->adev;
+	int ret = 0;
 
 	/* return early if no ACP */
 	if (!adev->acp.acp_genpd) {
@@ -531,7 +532,8 @@ static int acp_hw_fini(struct amdgpu_ip_block *ip_block)
 			break;
 		if (--count == 0) {
 			dev_err(&adev->pdev->dev, "Failed to reset ACP\n");
-			return -ETIMEDOUT;
+			ret = -ETIMEDOUT;
+			goto out;
 		}
 		udelay(100);
 	}
@@ -548,11 +550,12 @@ static int acp_hw_fini(struct amdgpu_ip_block *ip_block)
 			break;
 		if (--count == 0) {
 			dev_err(&adev->pdev->dev, "Failed to reset ACP\n");
-			return -ETIMEDOUT;
+			ret = -ETIMEDOUT;
+			goto out;
 		}
 		udelay(100);
 	}
-
+out:
 	device_for_each_child(adev->acp.parent, NULL,
 			      acp_genpd_remove_device);
 
@@ -564,7 +567,7 @@ static int acp_hw_fini(struct amdgpu_ip_block *ip_block)
 	adev->acp.acp_genpd = NULL;
 	kfree(adev->acp.acp_cell);
 
-	return 0;
+	return ret;
 }
 
 static int acp_suspend(struct amdgpu_ip_block *ip_block)
-- 
2.34.1

