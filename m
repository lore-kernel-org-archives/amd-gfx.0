Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 943D0EB8FDE
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Sep 2023 12:09:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E3DA10E19C;
	Thu,  7 Sep 2023 12:09:18 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20606.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::606])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF86A10E19C
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Sep 2023 12:09:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZoCYGUaCQgmvxld1EDMGAn7aYtW/YZAMQSoya4He0DS3JIMFAIxX8OC08JYE8UTDLd30u+kouAI/JD/dmXS7bvlyr9xM84xDPBOSdI3l+Vr0Os6CoCq7R3FgBGQ3RObNVUWvr9QTJSHM0DFavwPdOk0azYHcZcxZoLJZx5U19Yha1KuR7NO38ja4dhsmAYgssOZky/9Y4FHxmIhYW4BeWBL/lpXhNkJ2cfJp152XEAcAbJC0kNuh4GtZwwVZwmHQ5z3EO75qRJMVsCTTNPh09TKgZsBQ+9ji/7GjQtHDYww/0prgcyqS3lQ2Q2+czfTouDOjDcCurw+FjGzBdwx+xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JcghHWMUTNWQcfx9IALQ1o7cfCe8bQVIuS59aSarmlk=;
 b=IbU9aPEx9F5fe8yONC2jNT46GNvv93KXmw5KYnFq86xkdWXG6mMnGDDSRBgKYaJWtTM4YrPA9T5o4/2h7tfjWk4rFv0ZAmdjPqEH80GUGQKkz3/lEJWL0bHq+VurXhbMbjBuLeqg+0A8b4gZQfJjSd/hrz0K4gXqJbGmoXgsh8542RM2Nd24/0TFf9C1P2KvCWRrpYVwb11o7GPzhZ3ZKWggqMMUH+5b1j0LV4gEbhFCtg5437Q5NxV76Vqb/a/sHncWNTgyy+5Txt8jB8Cod2BBJaCJBofr464lTrg1WiWkuUyBFzFhZRWCvNg3+qiP1xTwMS5c/SVKRwDSDEr4rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JcghHWMUTNWQcfx9IALQ1o7cfCe8bQVIuS59aSarmlk=;
 b=agqHeG7h0XZ+A3QpvS8Hk4egGaEopb0CvBSYfKc6ObSb+OB02M3cQkVv7q0BGShIVejY8EE0YNe+wy9bnLi0e0R06nLXi/GFrEMXKV1DWL7B512R2aPy7AIK+krDdYdkM6vnrkpVd6N9DcCPui3r3B3cYNFMitQKqJPzwfz5yIU=
Received: from DM6PR01CA0013.prod.exchangelabs.com (2603:10b6:5:296::18) by
 BN9PR12MB5145.namprd12.prod.outlook.com (2603:10b6:408:136::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.36; Thu, 7 Sep
 2023 12:09:14 +0000
Received: from DS3PEPF000099DF.namprd04.prod.outlook.com
 (2603:10b6:5:296:cafe::7c) by DM6PR01CA0013.outlook.office365.com
 (2603:10b6:5:296::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30 via Frontend
 Transport; Thu, 7 Sep 2023 12:09:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DF.mail.protection.outlook.com (10.167.17.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6768.25 via Frontend Transport; Thu, 7 Sep 2023 12:09:14 +0000
Received: from lang-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 7 Sep
 2023 07:09:10 -0500
From: Lang Yu <Lang.Yu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: disable SVM for GC 10.1.3/4
Date: Thu, 7 Sep 2023 20:08:48 +0800
Message-ID: <20230907120848.3169535-1-Lang.Yu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DF:EE_|BN9PR12MB5145:EE_
X-MS-Office365-Filtering-Correlation-Id: c144bb26-5008-41cd-b5fd-08dbaf9b40e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IdsUaNHn5c5MUjrUxIuLfLbnOePt+UfMXcmS/6+i4dS8EJFT59b09VZG+dVG3cTbeYKSYKI8zZHgN68uwDPQsxapkFnSs10V4/o+RUW3Ti6p30ef9E7uqqAdlTgMlz8UypXxrpTbD4yFz6DO/jwrkmPj4ZnB2t4c2dErpnpyCA7IxIUqf+ZCrkGuhpPRDCoToyM8nz5M7gd5dSUPcu2FAFfn87GD8Hix9sRAw+YmcT5Wj9zLIzw1/M2GWoToExbvuctdh+pSMki9O1cvuPEyeykMpPWm8M+H3l6wE1W+gp/RjvQvUU5CXtoNcESVzuIfe7xJm71hXtNF8sa2lkQA44e8LlpsLohiqhdaYPRq1/Khgsq21cCU+kPlBK+jIPosSKeLMlglpds/o7xfCOGBEhvb9NqDJuYccolZjEVfRnf2xzWo5pkqMr1rWnH828FpsG+uHHB07J4cYfs55vmkrWyziePjdGDn6uI1oHFww9WjURDwB4hCNQL2vDI2hSJTmy2p2dlDmJ8cZn9S6y6td4B7pPjUPTidctxtL1fNLTt8v1la08Vg6s+MWMr8O100szWilfigoFGGOQiOdeiThgaEvMDlhkqFBFBPnGfyu/8qO3WcPmAld+Na5fNIAiH8gIEOsOxUPWwr6lEJH0mPxQBrbgbhmR5OLWF54Z1IpYZmd8xmocEsQ35hywOjFBIiCJnKWAjt6UD/9XdVlTuxC4z9ngC7qC3ec4pyRTl1lcLi/DvsHTKXWSZ5JxRDzzXL1qfuU053pmLfe0fdfq1Pig==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(376002)(346002)(39860400002)(136003)(186009)(451199024)(1800799009)(82310400011)(40470700004)(36840700001)(46966006)(36756003)(316002)(2906002)(41300700001)(40460700003)(82740400003)(86362001)(40480700001)(356005)(81166007)(5660300002)(2616005)(36860700001)(426003)(8936002)(4326008)(8676002)(47076005)(83380400001)(26005)(1076003)(16526019)(336012)(7696005)(6666004)(54906003)(478600001)(70206006)(70586007)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2023 12:09:14.5798 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c144bb26-5008-41cd-b5fd-08dbaf9b40e4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5145
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
Cc: Philip Yang <Philip.Yang@amd.com>, Felix Kuehling <Felix.Kuehling@amd.com>,
 Lang Yu <Lang.Yu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

GC 10.1.3/4 have problems with TLB_FLUSH_HEAVYWEIGHT
which is used by SVM in svm_range_unmap_from_gpus().
This causes problems on GC 10.1.3/4.

Signed-off-by: Lang Yu <Lang.Yu@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index 7d82c7da223a..dd3db3d88d59 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -992,6 +992,22 @@ static const struct dev_pagemap_ops svm_migrate_pgmap_ops = {
 /* Each VRAM page uses sizeof(struct page) on system memory */
 #define SVM_HMM_PAGE_STRUCT_SIZE(size) ((size)/PAGE_SIZE * sizeof(struct page))
 
+static inline bool is_zone_device_needed(struct amdgpu_device *adev)
+{
+	/* Page migration works on gfx9 or newer */
+	if (adev->ip_versions[GC_HWIP][0] < IP_VERSION(9, 0, 1))
+		return false;
+
+	if (adev->ip_versions[GC_HWIP][0] == IP_VERSION(10, 1, 3) ||
+	    adev->ip_versions[GC_HWIP][0] == IP_VERSION(10, 1, 4))
+		return false;
+
+	if (adev->gmc.is_app_apu)
+		return false;
+
+	return true;
+}
+
 int kgd2kfd_init_zone_device(struct amdgpu_device *adev)
 {
 	struct amdgpu_kfd_dev *kfddev = &adev->kfd;
@@ -1000,11 +1016,7 @@ int kgd2kfd_init_zone_device(struct amdgpu_device *adev)
 	unsigned long size;
 	void *r;
 
-	/* Page migration works on gfx9 or newer */
-	if (adev->ip_versions[GC_HWIP][0] < IP_VERSION(9, 0, 1))
-		return -EINVAL;
-
-	if (adev->gmc.is_app_apu)
+	if (!is_zone_device_needed(adev))
 		return 0;
 
 	pgmap = &kfddev->pgmap;
-- 
2.25.1

