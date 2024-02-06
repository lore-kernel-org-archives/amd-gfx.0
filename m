Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55D4AC4829D
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Feb 2024 15:59:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F61210F9C6;
	Tue,  6 Feb 2024 15:59:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QdkoNFhV";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2042.outbound.protection.outlook.com [40.107.95.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D9B6B10F9D4
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Feb 2024 15:59:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XE+VISb36IUhpjCQzoSPFgGSf/VbePW4XhtdJ+77P8H9wxL53Tjnf/E8v6g9L2kHa1KheIRFW4Aea4c8KLNW0o6wOS7xnKoTnQFwrde3JYCR04XXUiTPUttCLtqXcYdouEU5FHFrquEEdai39Pw0BkrgvRaLSnxdHFxkCmN6KBa8bS6L5aeH9ENvpsksOFE756xMR4aEtSkUQ/y6sAzxa3EMnJ8ffvPhpfs4JJzMHaC1MycZXR99JBTeAzeENaEgyeYSrrPmMMtJYPwAOQ9mbyfeMBVaW4v/CVbJ1VivLOfUAZzXhadi7jheXRu+twmGbOgbIdEcZrTGqSgwB39isw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FWsJuiwoAgEpViqn8GoonazgtCAkKGAZlXPVMiYKPdw=;
 b=VhJPHz6Amzp+4jVkE+P8bYp8Gx/YaswiNMyM+nJNa4yqaB+5dOWkzv3pdwpV09HubvratjZyZgxqaioi+YuUl/DWYBoqRVmtlHTHmugB+TTeoNLd3xZT2KpyVxJl04X6XFrek5z6HrnS2apKrjSeDoBM6W8DCwzGCTeB9CiS/eHk7dH93PRGrBdRW5+B+SM6OsvHl57DKDRnU/cHoY/Y44QrIWosPf1Bdh3x76ZAHvzmZTz24QK1SiWuZeeTOVQQ/FJBEtSQ52mSZ2e9dDM8HJvEQKYBZu40v0sodpPlsF5YJBbXciwzH5CnRfnOtY3dZ5pu7+6bwGUxC5psivKQtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FWsJuiwoAgEpViqn8GoonazgtCAkKGAZlXPVMiYKPdw=;
 b=QdkoNFhVfAptT7eQPHLl+4MNxtHaTpOBCxDgznkew/7bl5G4j3qMPFjl23psIaphAxMqf9JnEnRVz/L7bgBaStr3X8aXfGfb7L2SKYK9wl2FqYeXexLI7tnV3YDrnUcoUXEyjZQAw+pYVPMh1+Dh2XPS1w0SUA13cNxzTHt/ge4=
Received: from SJ0PR03CA0233.namprd03.prod.outlook.com (2603:10b6:a03:39f::28)
 by MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.17; Tue, 6 Feb
 2024 15:59:37 +0000
Received: from SJ1PEPF00001CDD.namprd05.prod.outlook.com
 (2603:10b6:a03:39f:cafe::61) by SJ0PR03CA0233.outlook.office365.com
 (2603:10b6:a03:39f::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36 via Frontend
 Transport; Tue, 6 Feb 2024 15:59:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CDD.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Tue, 6 Feb 2024 15:59:37 +0000
Received: from jz-tester2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 6 Feb
 2024 09:59:33 -0600
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.kuehling@amd.com>, <joseph.greathouse@amd.com>,
 <vladimir.indic@amd.com>, <david.yatsin@amd.com>, <jamesz@amd.com>
Subject: [PATCH v4 05/24] drm/amdkfd: enable pc sampling create
Date: Tue, 6 Feb 2024 10:59:01 -0500
Message-ID: <20240206155920.3171418-6-James.Zhu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240206155920.3171418-1-James.Zhu@amd.com>
References: <20240206155920.3171418-1-James.Zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDD:EE_|MN2PR12MB4192:EE_
X-MS-Office365-Filtering-Correlation-Id: 36891faa-6796-49b8-9a15-08dc272c9eaa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pCPuCh9+1ac4Kqwt+oIy9XZMbs7gC+OHqguOs/GnUf4M1+DpzCnbmxzg1zm2SVXtnsd0vOYsIqmYczv8+RmLCtK5kXQEr20xDQZnplxo5nL+muEhOQ4aATti9A5zzbRRKHMW0Hog1qoFXg+fGc/QURtoYqfwVVaCJz7L7whiU4b9u02RTnrH7581pML8xPZ2xYRpfNZ2e6VPJhMW5vaTHtld1w1qOLsleB8BPu9bcW0N2ylFYt+nIHOsJRVvbbX/RW2P35/kDl4EfJrtOYagfWGYvYp1J+T5xQYi3KONH6N8peCjLCDJbOSWl92weuAbn3VNMMhfP50eFbwZaswiOMlhuYUEFTMm1DqNEOe8XvfDLPPK1x85GdHFWRz8iF0PP4lknzuYruou09CRjIq9w0UOIeWLYx0b7xuckbjkhrlWU06uo7RWK3NoIaxjVr7jV4qT40PSHkOo8wLXoY3g22iQ72Z2OCIKL4mnrxWsgCFwycoavbzeaYSR03KfDP1Cwl3VPvRO6bnpazkWJyeGourBMZZjfIlwmLOGY0gDstbZui3+PjRMlZN/nunbEhXezaHaW7ZJzlsJzUb0Q+eRcX+GR+wW7npz40ZfSf9oUHXjXUPk+IuVVyfk3pVo2ZmM8/yTFhXpc0CxGTlXp9Q+5gakQFsW2/m1Ve3BWfE23kkRgxodwR8RdkCxseZXe7FuL8ildTsixosiPPW0ULyW1TeqbI2HoExlbq41SVnePHbRbfdC1xmhpqaU/U0ysHN8vE7TV2sXVbyBsr6ZD72Xug==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(396003)(346002)(376002)(136003)(230922051799003)(82310400011)(1800799012)(451199024)(186009)(64100799003)(36840700001)(40470700004)(46966006)(70206006)(356005)(47076005)(36860700001)(83380400001)(82740400003)(81166007)(336012)(6916009)(5660300002)(426003)(4326008)(8936002)(316002)(70586007)(478600001)(8676002)(54906003)(2616005)(7696005)(26005)(1076003)(2906002)(6666004)(16526019)(36756003)(86362001)(41300700001)(40480700001)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2024 15:59:37.2542 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 36891faa-6796-49b8-9a15-08dc272c9eaa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CDD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4192
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

From: David Yat Sin <david.yatsin@amd.com>

Enable pc sampling create.

Co-developed-by: James Zhu <James.Zhu@amd.com>
Signed-off-by: James Zhu <James.Zhu@amd.com>
Signed-off-by: David Yat Sin <david.yatsin@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c | 59 +++++++++++++++++++-
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h        | 10 ++++
 2 files changed, 68 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
index e9277c9beec7..9267de0bbdac 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
@@ -108,7 +108,64 @@ static int kfd_pc_sample_stop(struct kfd_process_device *pdd)
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
+	if (user_info.flags & KFD_IOCTL_PCS_FLAG_POWER_OF_2 &&
+		user_info.interval & (user_info.interval - 1)) {
+		pr_debug("Sampling interval's power is unmatched!");
+		return -EINVAL;
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
index f55195fea3df..96999f602224 100644
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

