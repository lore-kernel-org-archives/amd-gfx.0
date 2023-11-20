Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F00FBC2BB3F
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Nov 2023 15:35:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 79AD910E40B;
	Mon, 20 Nov 2023 15:35:10 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on20614.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e83::614])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D1A4F10E04E
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Nov 2023 15:35:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EdC9RQ0aZuceP4qJowwkwQQQbWo9aDkPS079qQsTyHf51zfc9u1e5TRM5LphTGszTetMx8haf4FL+JqZEbtbETJ5aMe9CL0sk1HEsDb3X80rF9BwDtSip+P6axL/6r5u1YSk3UiNUemjhGyWqlY/jsDAbCuQEbI0ca7AVAWZvZdhmgPJHl940tSEAUZ88+w51cimNgXl4O7IySAMrrq1Gtt0oYdq8mrWO+NdZleqVXhBzG6IQUGNqj3C6yYGioJY/G6gwH2BzsCwR4yZEQhaZOqSlxD/YUqZfBCFLe9KoBzTCjZVR0ssmiRlrq3361Fnz2+pTR09YmZnz94JvkHAcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IZiK0cxNyCS9aegZP6qC4ztCu0oZP335usKTwECNFKM=;
 b=BKaQ0Jrg7VMAqrX9eEXsNbBiXgaQ5Ox8pHxruNoe5G7ZShsvaKAQnybRFwahGf3srpCPAV8IhwnVoy4F7ZyHQjic/LINja15XC9aey7uUKf1EDp8FXTy6B6FFeTpHi0zY9ivpAJPe95H96W1A6WNJvsodlH5QXCGZS5pLArgY3LKJeiQq4yUdVWqG3eBz+NU0BnC11pEpEbxMnPMxzOGzgQMDMvPVsv8gQQT2J5hrj+NvtFXMa8P7hqvqSNs96BkCYAZl7ghZqkPLGKS0GqhIbOIUS+xUvKIQO0f6yxc/ScxsoHJ6imRcFockX2DFlkGLSqmIuzoDzdpQjoWR27d9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IZiK0cxNyCS9aegZP6qC4ztCu0oZP335usKTwECNFKM=;
 b=UQG/CUll2ELW57nXOri1qbP5XrsCFJKs55hCBjUtJ8lF6lrpCQ4+PW0JQR2yYY0JVgl+nfgQFilnlivnbAo2iFN7i4AoktFGo6D8WwGlJULr/4Quwu5jz5vq5FMMZo5LzHUqu8efc18ZR3yeJP+aCMRI5c7o9u3J8A49fp2JVFk=
Received: from BY5PR13CA0033.namprd13.prod.outlook.com (2603:10b6:a03:180::46)
 by DS0PR12MB6461.namprd12.prod.outlook.com (2603:10b6:8:c7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.26; Mon, 20 Nov
 2023 15:35:05 +0000
Received: from MWH0EPF000971E7.namprd02.prod.outlook.com
 (2603:10b6:a03:180:cafe::d0) by BY5PR13CA0033.outlook.office365.com
 (2603:10b6:a03:180::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.16 via Frontend
 Transport; Mon, 20 Nov 2023 15:35:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E7.mail.protection.outlook.com (10.167.243.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7025.12 via Frontend Transport; Mon, 20 Nov 2023 15:35:04 +0000
Received: from jz-tester2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 20 Nov
 2023 09:35:03 -0600
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 03/24] drm/amdkfd: enable pc sampling query
Date: Mon, 20 Nov 2023 10:34:51 -0500
Message-ID: <20231120153451.2522830-1-James.Zhu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231103131139.766920-4-James.Zhu@amd.com>
References: <20231103131139.766920-4-James.Zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E7:EE_|DS0PR12MB6461:EE_
X-MS-Office365-Filtering-Correlation-Id: 58f2ad47-d31c-4b79-e00e-08dbe9de44f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bQs+TV5YscJyk5mlsm6gD6PeMzFV19GQAidt3lRLEnTiExmZC+i4zgbYZE6nWc0kcxO2gC4F9B2ShVCAbFyqDdwLlhhnpoUP/2bL2PmCncjF/rVavX5Q2kJjzMNYmQ25kG6MjRbIlWR1n27Br+1/7hgaY8GKY4zCtlyLQGCMCky6a91otyvqQULb4qvRcIANiOmGu/u0PFd8aM3jYHtFcV/L4/k44liwyR6u0061fXE4FPk+ENim31QGdkJcTWoX+EeEvitFOYYl/DHU/cVMHybRCNE6ljm6BQ7VlbVSOhYoMphl6Np1XXlVG3pkS1zESAREBqaXIA52QT7uxnP2SjhiBS2eyxqbI2wRM1p0GFSrXO7KRDTtMULc2Lfl6ZHOL2O29ORB1odQIRtBufYYmSWhdIPifa+CM84e5KOUQEC6Un8awYAZocWEjeUPem86vHCYwu4VcgLBSmmS4yezUe/wO3Zi090bMcwuFGAEs146BNzxT/DrjrIRY/bf+ASC/KWJ+Kr7HmjJO9F9adOAww2OFfebAEL+UKw3vi+YCEQmT59qrZX4MY2V+1k/ycebjElrdxVJpNBYvZJlK/SgIaJcXu10qSMZ606czuMBP+HlRKGU6xXBn2ipSjh8PbZd8P9qg2TV6cUqSYbnKq9iY4TzRkFE+XqSagrIBU2TSeSnldWodrOqEqSKTONm2D1iN56t4oDs1nmC5UC5PnIixZpnv1D1ojA9SDOyCLeLxSbN6XGtxBDySuxv6OA+KILN+tDkzs1PHT5p+CeGQQgFqg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(39860400002)(136003)(376002)(396003)(230922051799003)(451199024)(186009)(64100799003)(82310400011)(1800799012)(36840700001)(40470700004)(46966006)(82740400003)(83380400001)(336012)(426003)(16526019)(36756003)(86362001)(40460700003)(36860700001)(47076005)(81166007)(356005)(70206006)(41300700001)(70586007)(6916009)(54906003)(8676002)(316002)(8936002)(4326008)(5660300002)(2906002)(1076003)(40480700001)(7696005)(2616005)(26005)(478600001)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2023 15:35:04.9986 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 58f2ad47-d31c-4b79-e00e-08dbe9de44f0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6461
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
Cc: Felix.kuehling@amd.com, joseph.greathouse@amd.com, jamesz@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: David Yat Sin <david.yatsin@amd.com>

Enable pc sampling to query system capability.

Co-developed-by: James Zhu <James.Zhu@amd.com>
Signed-off-by: James Zhu <James.Zhu@amd.com>
Signed-off-by: David Yat Sin <david.yatsin@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c | 54 +++++++++++++++++++-
 1 file changed, 53 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
index a7e78ff42d07..49fecbc7013e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
@@ -25,10 +25,62 @@
 #include "amdgpu_amdkfd.h"
 #include "kfd_pc_sampling.h"
 
+struct supported_pc_sample_info {
+	uint32_t ip_version;
+	const struct kfd_pc_sample_info *sample_info;
+};
+
+const struct kfd_pc_sample_info sample_info_hosttrap_9_0_0 = {
+	0, 1, ~0ULL, 0, KFD_IOCTL_PCS_METHOD_HOSTTRAP, KFD_IOCTL_PCS_TYPE_TIME_US };
+
+struct supported_pc_sample_info supported_formats[] = {
+	{ IP_VERSION(9, 4, 1), &sample_info_hosttrap_9_0_0 },
+	{ IP_VERSION(9, 4, 2), &sample_info_hosttrap_9_0_0 },
+};
+
 static int kfd_pc_sample_query_cap(struct kfd_process_device *pdd,
 					struct kfd_ioctl_pc_sample_args __user *user_args)
 {
-	return -EINVAL;
+	uint64_t sample_offset;
+	int num_method = 0;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(supported_formats); i++)
+		if (KFD_GC_VERSION(pdd->dev) == supported_formats[i].ip_version)
+			num_method++;
+
+	if (!num_method) {
+		pr_debug("PC Sampling not supported on GC_HWIP:0x%x.",
+			pdd->dev->adev->ip_versions[GC_HWIP][0]);
+		return -EOPNOTSUPP;
+	}
+
+	if (!user_args->sample_info_ptr) {
+		user_args->num_sample_info = num_method;
+		return 0;
+	}
+
+	if (user_args->num_sample_info < num_method) {
+		user_args->num_sample_info = num_method;
+		pr_debug("Sample info buffer is not large enough, "
+			 "ASIC requires space for %d kfd_pc_sample_info entries.", num_method);
+		return -ENOSPC;
+	}
+
+	sample_offset = user_args->sample_info_ptr;
+	for (i = 0; i < ARRAY_SIZE(supported_formats); i++) {
+		if (KFD_GC_VERSION(pdd->dev) == supported_formats[i].ip_version) {
+			int ret = copy_to_user((void __user *) sample_offset,
+				supported_formats[i].sample_info, sizeof(struct kfd_pc_sample_info));
+			if (ret) {
+				pr_debug("Failed to copy PC sampling info to user.");
+				return -EFAULT;
+			}
+			sample_offset += sizeof(struct kfd_pc_sample_info);
+		}
+	}
+
+	return 0;
 }
 
 static int kfd_pc_sample_start(struct kfd_process_device *pdd)
-- 
2.25.1

