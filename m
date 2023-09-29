Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BE16CE7B1F
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Sep 2023 09:38:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9CA3910E103;
	Fri, 29 Sep 2023 09:38:26 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2043.outbound.protection.outlook.com [40.107.96.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDA2F10E138
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Sep 2023 09:38:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=htgc2kcwQPGy5XuWupEUW5IedAIVO2wndDcEoDDqKAXBpE1MHEydDpsSmfuhr04ukJpMMZts2Uof04qBOX6h2AFTpTw69uySDmYQk1EG/0TyM5ebDxSiZb0dpK+HmVGf5nrcKlam8ZcvR3i8FwzByE/LnSrln1hzQSKBAsb3npDs60q8rG85GsnsZAai78VsS2Bw/FzvXS2uANm49JLC3CW2x9zrAhiXBBAdDmvOepKh7Xt1HSvFhQqL/r9vwuLL64WPgnpntEMpcNIegN+EuIQLp1j0NNkGVqd6kJY5e5IJQPrznk9Ooszpl8e/dYIFaQqCINWjWf7l6zDZUpYWJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i33GQa93tRuwF/116yr1dCbB0RsxJyMVZpJqOQkXEoM=;
 b=LMTRNz1soWzF9fPCRqath8dw3I9enGPLsWzX0HVbglHFmXr7+JqdRq+kkOVVRrJG0iJtSlnmu6xcaD+d3OMmu/j4JwPn/Z2igZCjgbZOPYoXuDp+7W7d3+JfYQfcnRjrq9KOWrGNHHQcaGQqA1M0gtnOCNBxoHDdsmeE59sieCCB/lBAVEy3ULZLafAW1CZ0u6U2tQgYs3aY+fgQpeeCc7mFozRQf1GpfO+HSbI5AZYmL/jWe6VMwMJIC8layF0R9S/Z5jFRgtaEAEDbU1aEm1e4G9hMadLneqkg+lglWTss59Bimd/hPvFAtxvq/9RONU1gLXFZqaH4or9/EIOadQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i33GQa93tRuwF/116yr1dCbB0RsxJyMVZpJqOQkXEoM=;
 b=uaNsr0Txr+YCnoytFwts9TTcu41LJpmoyJFwKj5AiVDRKWfCXjXUQFnj53fWv8CVhnGo/Zjkq4sLRvgqNkeREZeGaskQi6BUkjurfJreQQALxcPrx+H6xeQgStWV+EohFlheVCCWI4VkXZNYULVhuQmRAbjFwyWsmUTkj3kdlIA=
Received: from BL1P223CA0009.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::14)
 by MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.26; Fri, 29 Sep
 2023 09:38:17 +0000
Received: from BL6PEPF0001AB55.namprd02.prod.outlook.com
 (2603:10b6:208:2c4:cafe::79) by BL1P223CA0009.outlook.office365.com
 (2603:10b6:208:2c4::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.25 via Frontend
 Transport; Fri, 29 Sep 2023 09:38:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB55.mail.protection.outlook.com (10.167.241.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Fri, 29 Sep 2023 09:38:17 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 29 Sep
 2023 04:38:15 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 5/5] Documentation/amdgpu: Add board info details
Date: Fri, 29 Sep 2023 15:07:47 +0530
Message-ID: <20230929093747.1456991-5-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230929093747.1456991-1-lijo.lazar@amd.com>
References: <20230929093747.1456991-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB55:EE_|MW4PR12MB5667:EE_
X-MS-Office365-Filtering-Correlation-Id: d6b879f5-7508-41b4-182f-08dbc0cfcf6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MhsKdrAt+nap8W00UfK6u6HOo3Dkt3OSrXZPw5/XX9Jeo4sjHwhkitXLtrr/KHL7mzI6wh39w6s1Rb7bFKtYV6HEdFcSTnjodEpWgmebr1b7tPmP/RcWI/uKZnklC7Qh+Vb74sTLZkr4DCnwi6Dyp5pKy+COWaSG72HbDYM7tU36wxpzUllSjTYk0l9JFyVeZCfkN2oihcMKJxkiCgDfJLX0W4t/Il+M11e+wU6YzN4OTbRNU4Yv7jO8pszvHV4i+PHS7qtwdgXizFzx93ScfCj9AKc6/aGRJIxGMF4KUvEnxS+RxT/XR2QbeK7BM3zgrNbg1U08JJYGXf4DQHLte+hRvPlNbI3Z3E5SC+7kp/3XTfz79P0kDOorTOyyvJQAbUfmo4qVPqcT5cO6kAKX29V1f7IgDAkVYBCwsmp5Yu0DA0fbtWM5PEVB3UYiTbInRUI9riCxJN5CAqL9YoK/vwH6xuc/ZnR7lobpUicAX4KmTdK0diAYZuEagy/IAG7oknR2CJz1nqCHrXhmJIUwD6fpbKsBHAzXIqT8AGIuZbC14WoNy9FOIxhcua0S3L8bJ7wlVgik2CgfNxFjKBlqCH8qtZmSvIfja6CB95ZNi+D4DCwPOTpdK6QvF0zxPKRS+Gy/QDDgH/B4FjebDxAEdyFKta74kkVkSe1XQdEfQmmGxSU2QivJfwF69nQ4MRLEZX0fEFplFGszquu8jX+z5MEgMka1mt3t6yZ3WJxCPu3/YSsCxp+QO3KwauAf/Tj7uYJDmidyGEQJEHHZr3CbvA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(136003)(396003)(346002)(376002)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(82310400011)(36840700001)(40470700004)(46966006)(7696005)(2616005)(40460700003)(36756003)(86362001)(40480700001)(81166007)(356005)(82740400003)(36860700001)(336012)(1076003)(16526019)(426003)(26005)(2906002)(6666004)(478600001)(47076005)(8676002)(316002)(8936002)(4326008)(41300700001)(44832011)(70586007)(70206006)(5660300002)(54906003)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2023 09:38:17.3384 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d6b879f5-7508-41b4-182f-08dbc0cfcf6d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB55.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5667
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
Cc: Alexander.Deucher@amd.com, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add documentation for board info sysfs attribute.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 Documentation/gpu/amdgpu/driver-misc.rst   |  6 ++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 16 ++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/Documentation/gpu/amdgpu/driver-misc.rst b/Documentation/gpu/amdgpu/driver-misc.rst
index 4321c38fef21..82b47f1818ac 100644
--- a/Documentation/gpu/amdgpu/driver-misc.rst
+++ b/Documentation/gpu/amdgpu/driver-misc.rst
@@ -32,6 +32,12 @@ unique_id
 .. kernel-doc:: drivers/gpu/drm/amd/pm/amdgpu_pm.c
    :doc: unique_id
 
+board_info
+----------
+
+.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+   :doc: board_info
+
 Accelerated Processing Units (APU) Info
 ---------------------------------------
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 139a7fb2d4b0..40b19f225cc3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -162,6 +162,22 @@ static ssize_t amdgpu_device_get_pcie_replay_count(struct device *dev,
 static DEVICE_ATTR(pcie_replay_count, 0444,
 		amdgpu_device_get_pcie_replay_count, NULL);
 
+/**
+ * DOC: board_info
+ *
+ * The amdgpu driver provides a sysfs API for giving board related information.
+ * It provides the form factor information in the format
+ *
+ *   type : form factor
+ *
+ * Possible form factor values
+ *
+ * - "cem"		- PCIE CEM card
+ * - "oam"		- Open Compute Accelerator Module
+ * - "unknown"	- Not known
+ *
+ */
+
 static ssize_t amdgpu_device_get_board_info(struct device *dev,
 					    struct device_attribute *attr,
 					    char *buf)
-- 
2.25.1

