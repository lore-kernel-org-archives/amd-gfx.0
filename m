Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28CA1C10F04
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Dec 2023 22:54:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 080E310E14B;
	Thu,  7 Dec 2023 22:54:47 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2068.outbound.protection.outlook.com [40.107.96.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B0F3E10E0E7
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Dec 2023 22:54:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LDdtQuVYteqo6d1ARTecVUs46y8NNlPUQF475pPe18A/LYBCcIwZL2x+fPW5FnpN9g/wzUoe5FID6VegudKKgs1p4HJU2/YVcbHhuWCkZOqLjTDuFlL8SP+XOdMwW6CU835RkHOA+EkXgSiNQBJyFdP3p3NUyofxpKjPuGL5lB3rL2CgB4B3+DDjkyKsUvGa/g2lkdZOqUTxzeKT+0q+QqgRcLav2si+ECp+SV7O+RbnLJL1qKgQ9UHML3yxhRURm3OJ5SZWRJVvIisNBFrloHrVUlMU6jEIb6buhhfMx9MRADMfkC2p2vnosu2OM2xHXY20Au9THJaAWpQSDOmVeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IZiK0cxNyCS9aegZP6qC4ztCu0oZP335usKTwECNFKM=;
 b=HozOtlysbxveA1jTrGPVn//oFfjPvB5xwKUF+yqgMS7HQFNL9sfwBj1a2BMQ8FIAzuoDUkSjERtkzyqfwEqRDivVacBBlX9DSM/cv4T+IY5/FLd20zreCKApEDxUoN+ZB3jhiz1e/c//yzdq2ABXkBTwmTKM6TzFkNuOFKWr2JxacoN87op4YrnWo0tT1neYbZznntyVPYxifisE3TEthODF/cEHvufCfCHk6RqCLrTNc4mMzMKnQkXJf0aSq2NZB+Rs3xmq7pY/oUidEuACXJJVE6TvLWfGenHlUxXfO/u/NFUwb0rgTD/4hhUML1y/EfZr2OxapvduNKgV5OjGrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IZiK0cxNyCS9aegZP6qC4ztCu0oZP335usKTwECNFKM=;
 b=d9/CKxUTJ3q6/9rfnYZH3e4VxBdAck1AEgqOpcLEvtZlW3ELpYZSRcYYdL93akJPYAk0iWV/YXhjlszb/fUnVHvJ1vfxuCz4j9QDSR11l6M0LlNR3GiWHewWN9UxJsMhJxXp1Y31lE3/qjWtMzg71VaEzk9pKE4WFjw3FemKP8U=
Received: from CH2PR20CA0005.namprd20.prod.outlook.com (2603:10b6:610:58::15)
 by PH7PR12MB7968.namprd12.prod.outlook.com (2603:10b6:510:272::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.25; Thu, 7 Dec
 2023 22:54:38 +0000
Received: from DS2PEPF0000343A.namprd02.prod.outlook.com
 (2603:10b6:610:58:cafe::42) by CH2PR20CA0005.outlook.office365.com
 (2603:10b6:610:58::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.33 via Frontend
 Transport; Thu, 7 Dec 2023 22:54:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343A.mail.protection.outlook.com (10.167.18.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7068.20 via Frontend Transport; Thu, 7 Dec 2023 22:54:37 +0000
Received: from jz-tester2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 7 Dec
 2023 16:54:35 -0600
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 03/23] drm/amdkfd: enable pc sampling query
Date: Thu, 7 Dec 2023 17:54:02 -0500
Message-ID: <20231207225422.4057292-4-James.Zhu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231207225422.4057292-1-James.Zhu@amd.com>
References: <20231207225422.4057292-1-James.Zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343A:EE_|PH7PR12MB7968:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b02996c-41eb-4785-4ae6-08dbf7777d16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7ew2H6qN1KfvjFNh8pMIna9UDd2ubOSJuqE2Jgy7hLAhRU2co0ZsO9yjvnerBWTD0zw3EYXWUQKiLvyb/gV4tw14gM5VobIrhlxk0+FBE/dc8MzzgfxihKhwfZAoCn3ERrv3ThUesWZ68Lr6bLe+8woovAytPvOk/aqEb5hmYBbmYmuaZmQDrZCzk1yUyYvfVpeu+BsVtJ43iDCH1IWaV+7Degp11YbsdnACy8f/n2Wj7pCz5aa5mEyVPL7aX/of4hMRJW6plSRuZo/Q6Ts5GYJNQDlaw92r8gaG0h0r/+qXRLTndzggxN+DAr49P99sCQ2Oahvmkau93ZgELThM3FNojz3AM4CEEkmlTZRNXJ5df08Z+MiJGxBEH9DFds+yNROJs2w4nkURtmFZMS8jzhSBVI0NP4Pwqp09z8P2yvzzFl1pNJL5tJiLdWv5ne+BpEzp+zkz7/J/mzr0XVCUKDo9IDuFm68sYTh/TNJMQtAl7lVhN8cjzYwwNIIQUbvBtL+Txk4PGGNPnjau3PsDO1oTU4kyMgNm5bQAa3DZpHazsjHwGNeLNac2anabP0GCNWNW30OLDFWXAy4PFOJ7Cl7u1O8N3VGEYxtL9mJlmESwGng5qJq4K0viXv2q3YQpKNyl4UmLA0QflVpN8oPclCQNiAEEC9BqCK1IcFZgy0A2uxvJczR+SwfZ/OdHsbfXDMsmOc1L0V3gMuEjO5ySAE62h4khyvIqEXSxfzhNi44WeK5F7DX4WuVtZssSdg9DwuLy2/15U3Fd+1mjJtMFQg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(136003)(39860400002)(376002)(346002)(230922051799003)(1800799012)(186009)(64100799003)(82310400011)(451199024)(40470700004)(36840700001)(46966006)(41300700001)(47076005)(5660300002)(336012)(83380400001)(426003)(2906002)(2616005)(16526019)(86362001)(40480700001)(36860700001)(26005)(1076003)(40460700003)(356005)(4326008)(7696005)(36756003)(8676002)(81166007)(6666004)(6916009)(70206006)(54906003)(70586007)(478600001)(316002)(8936002)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2023 22:54:37.4214 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b02996c-41eb-4785-4ae6-08dbf7777d16
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7968
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

