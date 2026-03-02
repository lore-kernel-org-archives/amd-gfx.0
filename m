Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D452D58E5F
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Mar 2026 06:13:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C28FE10E1B1;
	Mon,  2 Mar 2026 06:13:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="viOWPNlM";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011020.outbound.protection.outlook.com [40.107.208.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EEDDC10E1B1
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Mar 2026 06:13:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aWOgyjPJrrL1T/MrATeiX28MNV8fQaDR1kFWQizspaFR+vV9zMbGcDMrhQGW0FdYsmBHKYEBu60Gj6nQZeWFjQ/PfzEXdv8hjVU6TOpnHqpSYbEWyay0oc9Dy59IWQhOtsXCFNcse7DuHPMBYu9StueD4i062V3mjMgNrL/37H3/wRKbzXy+IzJEOi6uWfmOTufBSWf59HsuJfV+JDFgJBbQ+qMu7jpsjBl9qOWVU6WhZ+Dl0H+rs+ZtNJbw6VdJoSTaaJLQWcqm4ddA7CdW1l+69yfd2aPdeBEU7I5RBeRJpOqBPIXzerQmL5HoY0YVmvxlYj0PRIpVQZtHERLJgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0oB0toCsyMnYG5UY7RlTwMZnrHmuPCjq/vfmybF7lo0=;
 b=YH41kmNRgFl8Zn1984p7pQYenjev+tANu+/tfwvT43mEoAT94Ua8yxRbB0MhCknvjTJD7xvYmy9TN9aaYJtqCXdCyPzHYfkedMu/Z6kF0hdas/K+tiSpz3aMwUzsv3r7yA3oPUKFLoIKLcizXPK5UIv36tHoY/9tzOPe2+1KBGMQlk+PxWTgzdXldXBuLnDTleOXGp2bBAvlAG+fyQc+PI/k3U4hMzmYazrH0r556AFicCZbZrULVw5saxyqE5druslhG6SNu/NXmC+Acpxj9Yvo9sQCIBmdpapTa2/AzEjG5C6m8Yyq1LxYDPdgCDI82/eNgze1C1I/7FZbunSRXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0oB0toCsyMnYG5UY7RlTwMZnrHmuPCjq/vfmybF7lo0=;
 b=viOWPNlMFgF0C2s2PrXq/IZSmLNmlWndIEeTq7Bh3tlAfn5sGIq2wzynJU9Ek9tV6j2H2JkJs5RCUn3YwxoZ9+D42qZl9U5n6LHKHxj312amQk49Z/WxDsW2lkmDdDV+zXSthMS7P2htZJ3sRxI8DSYM3gHq9+RbGbrkXYc28Vc=
Received: from DM6PR06CA0092.namprd06.prod.outlook.com (2603:10b6:5:336::25)
 by LV2PR12MB5749.namprd12.prod.outlook.com (2603:10b6:408:17f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.21; Mon, 2 Mar
 2026 06:13:18 +0000
Received: from CY4PEPF0000FCC4.namprd03.prod.outlook.com
 (2603:10b6:5:336:cafe::71) by DM6PR06CA0092.outlook.office365.com
 (2603:10b6:5:336::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.21 via Frontend Transport; Mon,
 2 Mar 2026 06:13:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000FCC4.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Mon, 2 Mar 2026 06:13:18 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 2 Mar
 2026 00:13:15 -0600
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <lijo.lazar@amd.com>, <hawking.zhang@amd.com>, <le.ma@amd.com>,
 <shiwu.zhang@amd.com>, <alexander.deucher@amd.com>, <kevinyang.wang@amd.com>, 
 <asad.kamal@amd.com>
Subject: [PATCH] drm/amd/pm: Avoid overflow when sorting pp_feature list
Date: Mon, 2 Mar 2026 14:12:42 +0800
Message-ID: <20260302061242.3062232-1-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC4:EE_|LV2PR12MB5749:EE_
X-MS-Office365-Filtering-Correlation-Id: d4596d16-0f9b-4046-9d08-08de7822cc1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: OoUaweg0c5nuS7P+vq3LmSl/C58i0loQzSirHbkwcacdcUa1ueVnOEYRCAzBu5VJK/AUEfsoYah3YKKKyQ5RcKaj3E1umDTsSR1DYLygXqfyf4n+aO1rYSX0JBq3L8hAlGb3/X8bXbIt94z0eS2oEZgOVGTR2+92QpV1Olg3HQe8lbjqMAD67TtK0o/9ZfmAr3C3RcF/Oy3YixCPOKDNaXngFNbIXMlSi1GHdlHDun7KlRAUtWzDkWwGuiSIA3UfLFwxa3HP3z6h8dreGpLERyI+tTiNNGZedLMDowWnbik53aWlFeqMRWDqhzpcOMsvjZPgzhc/9/L1BSeT4LLdvgKHSVvT63rZdkulWPg4BMJ44DPlb2wmbMqJB0qYbt8cjEL1KT2UGniH2VYJ3tWw+uNe3Biqcs/5dydmULneERiurl7v4viRKO5s1pWTfYOIK5LV+aP0uXg2qTLqGeDPWdXHPbkcOASfxXv9hiX0W4n8dGEDM6K9AnhPbrg8lk1tWbZEug5yJbFevD3H972FskM+QFibyP5bHET3O+1W5Jsf99o+jbU1vqluMuYeK+UJQqipuLCKQZAy1rMTfNjTKv1bTvRWTiDXSvlWtZeS4V9xnvbD4t7tANVUlH1yQzB+Jn4VgT6Zy+2PwUbe/ThR1EweD8rmOAlrdbIpPgLsBxCjfRsO8qJVNPTdTNe5c1I62uMKNAUILYOSt47l1VC6xsfVUzpGfljmcbFgBe4q2Z/rFc1RvD8jsNmkPv2yo8WVamaxL2rLjV54Olmnb5MR41U6AODJA7IJjCEUmFVBhHC0JFgwLkPUK/Dxz9pUi+LqW8n3CFDDFf/eTTbB8ENf8A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Zv+cDTRqWoLJ662f9qIzmRtVnPYRmfYNCz3sCV48H1ZQsJnJuUff21NSPDXKQq4K12saFJS+ytCTZVbUCTNkZZXj9ZUqJPo7QbaG3C9C6Bgi9hulnWiPthzC1kvrpo+ImnAB3SUgjBX632WZOYC53C04V9oJP8vP8t5AXXkWdPFK0fqya2JYaYzgTX+U3TaqlaLUpOs0+V/dnVS9TgmtgJgUySt3V0LTHWVInT58J9SnVhpW8biShbQjtT3tongnNvpRMjurkusuz6WDNc5izYrh3HyHTQ7hwzJVQezEeY0oMNe4mLYanRMhz9WqtWa9+XANGaCxmiv9EzCOdg2fWYR7YK70wZvMUZHfhu0n15GfSZ+D0dAPutDKOBouFQVi31yHrI2fx3jZ8vNeiXWJW7CLSmQ8fOPUdkhjBDSbv9YI5/AGahZ6APO+9ievx9qC
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 06:13:18.0831 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d4596d16-0f9b-4046-9d08-08de7822cc1a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5749
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

pp_features sorting uses int8_t sort_feature[] to store driver
feature enum indices. On newer ASICs the enum index can exceed 127,
causing signed overflow and silently dropping entries from the output.
Switch the array to int16_t so all enum indices are preserved.

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
index c471c0e2cbd1..326c86b920a2 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -880,7 +880,7 @@ static const char *smu_get_feature_name(struct smu_context *smu,
 size_t smu_cmn_get_pp_feature_mask(struct smu_context *smu,
 				   char *buf)
 {
-	int8_t sort_feature[MAX(SMU_FEATURE_COUNT, SMU_FEATURE_MAX)];
+	int16_t sort_feature[MAX(SMU_FEATURE_COUNT, SMU_FEATURE_MAX)];
 	struct smu_feature_bits feature_mask;
 	uint32_t features[2];
 	int i, feature_index;
-- 
2.46.0

