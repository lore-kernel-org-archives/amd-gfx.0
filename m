Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 205CBC4167B
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Dec 2023 22:54:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5015910E0E7;
	Thu,  7 Dec 2023 22:54:44 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2086.outbound.protection.outlook.com [40.107.94.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE98510E0E7
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Dec 2023 22:54:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a5DgC7cb1WaJF8yEgl9BZ821pNVWCiDIs9gED48kIbR2bWaRNeBTp5nZ7pqykXcAvOwU1VPTtUkmAMfMLoDARZlzL8C5/3wqiuHR1HTfq0htIITAHV0HIYGb5UWxaezA/XtEgzBAhtODBBAgrSgsBmvk8OJcoYHR+eXJ4h4YtrB0uJrijx6vbcY8psaC7KX/TakuOrEEtS3rgM3g7sYEYVVvnsaOJU8ZGXld8nrBS1jHC5u6JvKurrKTQ4IKmUToy/mdTdUTSpnBJh4nLwJbCdaenmP1Gafu8a3K7Tes39OzcUgsRTXpnt42kDVXXi88zXKcAJQxgDJKVn1gyuL33g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lqp/Qht1llgPstg3WVLc0K1GwkIMQMN2E14AD7qBgr0=;
 b=QstOncoSbLv3xzUnRWOjgGncCq/zDqP43U8JTFMrh/2d1edrSN5LtV7ZHHyrKMAfnTsX6+A3CtvBiunxmBBtFOV7HOJGzCHRmAWTxwGpB6mIL4kT9hcK3h/WpDYASbG/wExU1hFE9vdZU4r/RNhaDH9eVOh8rGtFcWwofItVaxeJGP2iWQLXQrSHVSCw66bNncWhC5faVC03LcJweGc1akWQQi0MZ1n12G8hOiYnXUnEuZxLImWqwDNZTPlzd/VRvN4SUfY5ZC3+iSFfB1iKGsw74e43f4FaSqrhFX8gq6N15TVjIk2CgT09RgwaOT4xcs/Qyzc/C1uv7pmKfG4R9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lqp/Qht1llgPstg3WVLc0K1GwkIMQMN2E14AD7qBgr0=;
 b=b0h35FhB5w/7KpKWl5qYeG2DE7OXkx8geOJ+7NXTccBOx0wrU50Kg1TXlIKErRyTQs9FjQVjB060ebxEPRbrscYzzWCloqE4dtuL9pXBdlwu+Du/PLloEYIz21F4BukGB5SS32tD6WxnpKNUQU9j5YiNEt5H2StZYRU/GqUoyx4=
Received: from CH2PR20CA0020.namprd20.prod.outlook.com (2603:10b6:610:58::30)
 by MN2PR12MB4158.namprd12.prod.outlook.com (2603:10b6:208:15f::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.27; Thu, 7 Dec
 2023 22:54:39 +0000
Received: from DS2PEPF0000343A.namprd02.prod.outlook.com
 (2603:10b6:610:58:cafe::f6) by CH2PR20CA0020.outlook.office365.com
 (2603:10b6:610:58::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34 via Frontend
 Transport; Thu, 7 Dec 2023 22:54:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343A.mail.protection.outlook.com (10.167.18.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7068.20 via Frontend Transport; Thu, 7 Dec 2023 22:54:39 +0000
Received: from jz-tester2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 7 Dec
 2023 16:54:37 -0600
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 05/23] drm/amdkfd: enable pc sampling create
Date: Thu, 7 Dec 2023 17:54:04 -0500
Message-ID: <20231207225422.4057292-6-James.Zhu@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343A:EE_|MN2PR12MB4158:EE_
X-MS-Office365-Filtering-Correlation-Id: b4a21d2e-230c-45de-02b8-08dbf7777e32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ei8nZvt20kU4WwBi02OWH//WbDTaRQBetdorpMcAtBTfq8azTlAy8LbMkmLhZ1jDBioBJCTwCcvLK72TW/vtFP+NE91FFb8go6fdQ61VtQ9lFZ97R0TB24vXF9NY6grmwuN6b63NOhRPU3OIbSsPTCDTCFNDrtcQxRb8yCkrOAXKsESZJXzEjJxrKalhIDbQ5mpeSkymzPL4Yu+2Q/DdFaHjgunUD9gguBf/Zg6BiAcRZfzKeDDk3SWUnjDZt6sMKSuUR1IHL1h5Joul0x9HV87DwNE6SXsXxH/+lx6acNN20Di4sKUK9euyFjo5X96P8J7wPFbnX/EWpvdz245sM3BMBJcjPbR0r4vSsM3y8heHn1c/4uF+2r+8FPQ/AGARRcJ78H/C+XUm/J8Sj2Ij2WjXcNnsS7tFYl0wjN5q23K0ZNGMZcFbCKeYCOX+jUXO5C899xG8tduzAGk2hOGcDpnPmaWopU6T2Oigu3pMHIFj25VMRvjRZGO3MnqrCgXj/5uHCi6/IZ4pQUjd0mtp0tm+iybbGCBKlwq0v84ZhWE0FBYeoJqUSwFvTd1gJnqE9A/xCDZn6zAvNFWypAjpCLM19RRJ0R0L8+B1RjbpG7uJnxO0Lg2k6f+Z7ET4afIaJVGlLyoaS9hBmxc1Vzjrrmm1wHrIljIdTFtXkUnjLvhMfv7vUWRyydFZvI6MF27FwQv5+YF0as5D0VOmv32OpItaywV9+mC9AJujDx8mQ3DtgZFfG8YwKOoI0fBCsYSbZlsQ7rINRd+sMlx1tFEAPw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(396003)(346002)(376002)(39860400002)(230922051799003)(1800799012)(451199024)(82310400011)(64100799003)(186009)(40470700004)(36840700001)(46966006)(6666004)(83380400001)(36860700001)(16526019)(7696005)(8936002)(8676002)(336012)(26005)(426003)(2616005)(1076003)(40480700001)(47076005)(478600001)(40460700003)(6916009)(70206006)(316002)(54906003)(70586007)(41300700001)(86362001)(36756003)(5660300002)(356005)(82740400003)(81166007)(4326008)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2023 22:54:39.2651 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b4a21d2e-230c-45de-02b8-08dbf7777e32
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4158
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

Enable pc sampling create.

Co-developed-by: James Zhu <James.Zhu@amd.com>
Signed-off-by: James Zhu <James.Zhu@amd.com>
Signed-off-by: David Yat Sin <david.yatsin@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c | 53 +++++++++++++++++++-
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h        | 10 ++++
 2 files changed, 62 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
index 49fecbc7013e..7828a6340edf 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
@@ -97,7 +97,58 @@ static int kfd_pc_sample_stop(struct kfd_process_device *pdd)
 static int kfd_pc_sample_create(struct kfd_process_device *pdd,
 					struct kfd_ioctl_pc_sample_args __user *user_args)
 {
-	return -EINVAL;
+	struct kfd_pc_sample_info *supported_format = NULL;
+	struct kfd_pc_sample_info user_info;
+	int ret;
+	int i;
+
+	if (user_args->num_sample_info != 1)
+		return -EINVAL;
+
+	ret = copy_from_user(&user_info, (void __user *) user_args->sample_info_ptr,
+				sizeof(struct kfd_pc_sample_info));
+	if (ret) {
+		pr_debug("Failed to copy PC sampling info from user\n");
+		return -EFAULT;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(supported_formats); i++) {
+		if (KFD_GC_VERSION(pdd->dev) == supported_formats[i].ip_version
+			&& user_info.method == supported_formats[i].sample_info->method
+			&& user_info.type == supported_formats[i].sample_info->type
+			&& user_info.interval <= supported_formats[i].sample_info->interval_max
+			&& user_info.interval >= supported_formats[i].sample_info->interval_min) {
+			supported_format =
+				(struct kfd_pc_sample_info *)supported_formats[i].sample_info;
+			break;
+		}
+	}
+
+	if (!supported_format) {
+		pr_debug("Sampling format is not supported!");
+		return -EOPNOTSUPP;
+	}
+
+	mutex_lock(&pdd->dev->pcs_data.mutex);
+	if (pdd->dev->pcs_data.hosttrap_entry.base.use_count &&
+		memcmp(&pdd->dev->pcs_data.hosttrap_entry.base.pc_sample_info,
+				&user_info, sizeof(user_info))) {
+		ret = copy_to_user((void __user *) user_args->sample_info_ptr,
+			&pdd->dev->pcs_data.hosttrap_entry.base.pc_sample_info,
+			sizeof(struct kfd_pc_sample_info));
+		mutex_unlock(&pdd->dev->pcs_data.mutex);
+		return ret ? -EFAULT : -EEXIST;
+	}
+
+	/* TODO: add trace_id return */
+
+	if (!pdd->dev->pcs_data.hosttrap_entry.base.use_count)
+		pdd->dev->pcs_data.hosttrap_entry.base.pc_sample_info = user_info;
+
+	pdd->dev->pcs_data.hosttrap_entry.base.use_count++;
+	mutex_unlock(&pdd->dev->pcs_data.mutex);
+
+	return 0;
 }
 
 static int kfd_pc_sample_destroy(struct kfd_process_device *pdd, uint32_t trace_id)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index cbaa1bccd94b..db2d09db8000 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -269,9 +269,19 @@ struct kfd_vmid_info {
 
 struct kfd_dev;
 
+struct kfd_dev_pc_sampling_data {
+	uint32_t use_count;         /* Num of PC sampling sessions */
+	struct kfd_pc_sample_info pc_sample_info;
+};
+
+struct kfd_dev_pcs_hosttrap {
+	struct kfd_dev_pc_sampling_data base;
+};
+
 /* Per device PC Sampling data */
 struct kfd_dev_pc_sampling {
 	struct mutex mutex;
+	struct kfd_dev_pcs_hosttrap hosttrap_entry;
 };
 
 struct kfd_node {
-- 
2.25.1

