Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64F37C624D6
	for <amd-gfx@archiver.kernel.org>; Sat,  5 Sep 2026 04:30:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7807610E139;
	Sat,  5 Sep 2026 04:30:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="l6PwQHET";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012049.outbound.protection.outlook.com [52.101.48.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 72CDB10E139
 for <amd-gfx@lists.freedesktop.org>; Sat,  5 Sep 2026 04:30:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bYXYN0EmaWY5w5GP2mwUgfG+y5LMfCK2Oj+nyr/wzundZWhtCtRXTjfwBLpBA23hU3jFRjTeYtjH9gTo8JxdyTFbJ96hb/3EQxUqF1KJ5EQgaJD5VrXl0xFllAjlymqr5AR69aQrTUsjiU3EHlayuJDpz8dUvXsrkVguOsNG1zuIPDnFllEtPq/SQnNdKdMn0ztNKpe4EfO26iTBuVNQC4M8icqlk5HPpuHoOnoZSNNsGz0Sz6T+xjX7mj5tD2A++TTHewYBUAM/AzxEu+D++xGwYAmihAO2mDfKCTFiSkXmv5u3C4PGzCKzl2zFcGXagW4VCXbiqjhkJhs8I2+/WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LfkT+iZFPy6SithgCekb1JWFrGbSvSt3fgjnLOdz16w=;
 b=Dj+ezIBrYBrxKOvf4OGYTyhbhLZqrzWtlqYP/t9KZPIfu0NJ7L90pWqU2mB7dCIhpOoD5qkHOON8Jkb9xgfNCYRcK3+/fPkOryKDYvmryEL2fH6UcbucoAt8q3gqN+0ZpOozngAce9wotCS+CPq7seJjTZeKM5b3ztNMvxA0LMtXjUhTspPLRCu6GBvKHyjJSL3U/Mp6xlCv/67I/4/f9LPQU4M5mrMvX4cxhXJXZlvbO6iB7y0J3GRu4hWGYNRXJH7JUK51+Z2tH8XSL7BYUwBY3+3b3lAtJELuFrVjdusoeT/Vlwp0WEG1yTSnDZ5SIjhMIMCJAcB0gAp1aXKrtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LfkT+iZFPy6SithgCekb1JWFrGbSvSt3fgjnLOdz16w=;
 b=l6PwQHETla6gOncFDEZRcuCu8dVSgiY9haPBfRKhhYOPLgaihDSXYUI64gnVfPJl1y4iXZbjJDkeHoeHOh1Hzs5QlnhAOTjA3LbjwbcdTObeToSLcarWWptNnONlUrhB7EAlaNntbbSuMMiLC33ppj0tvWu7Z+wQraUeHspiem4=
Received: from MN2PR03CA0011.namprd03.prod.outlook.com (2603:10b6:208:23a::16)
 by SA3PR12MB9131.namprd12.prod.outlook.com (2603:10b6:806:395::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Sat, 5 Sep
 2026 04:30:52 +0000
Received: from BL6PEPF00020E66.namprd04.prod.outlook.com
 (2603:10b6:208:23a::4) by MN2PR03CA0011.outlook.office365.com
 (2603:10b6:208:23a::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.13 via Frontend Transport; Sat, 5
 Sep 2026 04:30:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00020E66.mail.protection.outlook.com (10.167.249.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Sat, 5 Sep 2026 04:30:52 +0000
Received: from liuxiang-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 4 Sep
 2026 23:30:50 -0500
From: Xiang Liu <xiang.liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>, <Stanley.Yang@amd.com>,
 <YiPeng.Chai@amd.com>, Xiang Liu <xiang.liu@amd.com>
Subject: [PATCH 1/3] drm/amd/ras: reprogram MCA settings after reset
Date: Sat, 5 Sep 2026 12:30:29 +0800
Message-ID: <20260905043031.1015676-1-xiang.liu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E66:EE_|SA3PR12MB9131:EE_
X-MS-Office365-Filtering-Correlation-Id: c4e8ac2c-bb4b-4af9-de3c-08df0b067820
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|82310400026|1800799024|376014|6133799003|18002099003|18092099006|10086099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: WzxiDRW0JYIUbFckX3dxZT9mLDgHlf1vSwTD13XZjJ2xKGJzste52vmTuATYuEqbTJ9pmgzTem6EOk+gS7iWeC0iLYG2JaMmzwdXhmu6jrh10fNVPb10k0C2Zf8Fkc/t7WBKWZD37Y8t0FHtzVyGA+yN6uMzi7KWF4LGPnwGq9s8mlxljjEBsP0KwfMDIFxtjLI5hrOinQEKrK1R4DjR15lnRAZwXkGxhVwP6HuQjLBq7zaHdxeaf7zm5lreF08dKAmAr9QvYffV6KuDyW8QOof6UVT1TPHVLfIRa6+lD8XlWrGzEV92cXQVBFgl/lCi3Ouy4J8ZbUV1zpMyR5nSuMSJtdbzV9Gja2osoSw01gniaymWdjDVf9XffAgEccCzrVT0sNkS7CuDSW2sqL58PWVURgNQAbZwXctkn5i06E1VyZ3XqA5P+PIeasncUANhchtONI7ZRS58PVLw28xG7AyIAQQTBiuBjkk7CQ3FcA4UwnmVsDzn+QFhCAH4LSQB454VOCXeHazekBnKj62IxrmwSOME4nWetL7OrJ3717E7YMXYBKJVu3EVU90GwupvcKY+Gueb0TInXGuU1oI8uOJQzSUtkNpTDqIYMsxdf4mDwUnEFf5Xf7kWVyF4J+kZcFBoWo+z603WRadhKKMgm8pb3cIBsjo24G55x84/TjHJFVSjrglFdMzk29FQcMdnxC3wkjWMASQCrnyHpjr4DQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(82310400026)(1800799024)(376014)(6133799003)(18002099003)(18092099006)(10086099003)(56012099006)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: lxYqY2BP3RcuXIdiEPUPW5d4q6rnVTU5SuGZi7LBTbDy+QhX3GudAPLF48QjQLzpanIiJn1xQtihEBdwYK518L57/DyS0/x0CdfrfE0p+6BpedHaOZPVQ4z1dEfiUcv+QfGn5cCdEfJEM/LsCk3RBFoIJnoZ4AAxreZNtc3hJe3PP21oZpWsIgP02iAOKRlxAjTHzAf0CDL5Ow286Td47cgNoO5bqQdi4sDLV8ippgvorQWx4O0m2AXtw5GlOX1S8yl2JVt9X5/n7uW+JQA079Hr3cGTRhWmxbqMTeHbLI5q9XHsQ05xfI4iWN/Fm/hH9IMXe02oEmiQL6Ivy0+IcEjIlYtMIxxnPRdKcxy3KRd6wJ7qStkte/c6/yNsrI4DYVCyWp/M5N6Z3zzYGoTP7ViUByGH2MlPeq8jOPXxBn/x8cRGyUNS7ds27Sleq7DJ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2026 04:30:52.2599 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c4e8ac2c-bb4b-4af9-de3c-08df0b067820
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E66.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9131
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

When the driver is loaded on a device that still needs a hive reset,
the RAS IP hw_init is deferred to amdgpu_ras_mgr_resume_after_reset().
The MCA configuration is sent to PMFW from amdgpu_ras_late_init(),
which runs during the reset while RAS is not ready yet, so the request
is dropped and CE polling stays disabled. Correctable errors are then
never harvested and only show up on the next driver load.

Re-apply the current debug mode once hw_init has completed.

Signed-off-by: Xiang Liu <xiang.liu@amd.com>
---
 drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
index a02167397ce2..f550e83f2b96 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
@@ -483,6 +483,7 @@ int amdgpu_ras_mgr_resume_after_reset(struct amdgpu_device *adev)
 	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
 	struct amdgpu_ras_mgr *ras_mgr = amdgpu_ras_mgr_get_context(adev);
 	struct amdgpu_ip_block *ip_block;
+	int ret;
 
 	if (!con || !con->uniras_enabled)
 		return 0;
@@ -497,7 +498,12 @@ int amdgpu_ras_mgr_resume_after_reset(struct amdgpu_device *adev)
 	if (!ip_block)
 		return -EINVAL;
 
-	return amdgpu_ras_mgr_hw_init(ip_block);
+	ret = amdgpu_ras_mgr_hw_init(ip_block);
+	if (ret)
+		return ret;
+
+	/* amdgpu_ras_late_init() runs before RAS is ready on this path */
+	return amdgpu_ras_mgr_set_debug_mode(adev, ras_mgr->is_debug_mode);
 }
 
 struct amdgpu_ras_mgr *amdgpu_ras_mgr_get_context(struct amdgpu_device *adev)
-- 
2.34.1

