Return-Path: <SRS0=Az3f=IU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD339C433C1
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Mar 2021 03:05:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 854E361930
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Mar 2021 03:05:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 854E361930
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2395E6E077;
	Mon, 22 Mar 2021 03:05:12 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2061.outbound.protection.outlook.com [40.107.220.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B56ED6E077
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Mar 2021 03:05:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BuUIeVHlPePCelkWnrHVbyG07d0NgwuCN9HS3rVJmYnbfp81AtTxUX/X268jlxGjFy2P7oRQqthTFjzAFV+UeXx+zNSkxNKMhWNhQ+KJmGwvUCge7OktGgMJ/U36gKJ9EL4RafrQ0lwTcoq7wY826Z/CXneePgcHoqIzey60a4+gMirui4D0MDG6t5ghq5K6J2hQ9ceb/1lVps2pPS03ehHw7n6K40AAwo2t36CO+fB8YABMbQ44DzeDC8+f4Q8gIUJ/gexVML5rHjwjNGZerzeTqVPfZFdfM9H+7HewDZ8CSmoOykKBlHw+kY9qgJ5gAJhxtGQAzlbsGZjgkJfzZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D1eMXrT6uyvg8aNsCP7cDCR1JCUjZDg8rnjWB38dn4s=;
 b=jSwDOl2iUK/bOZ0TQ2kRCAelEtOYWLhi/KmzzxwQ6HaA6TMZt60lvItpzOwOZY4JovJoWoX4sGBXMRJjnfgQwI+qyiiwX8WCBO/rV5EsjLm2aYLA70NdRKVKk2G3NOnK4cNvX4JX5F4D30by4K4LzbCS/lJjwgQIpXyTQI8HiEa+L8iTxulcezhDyrwDSLuN1qCsd9fIlbY+USgRMQVf45IRXU/oMAXaJ5u32TZ+49RZq6jiUb1vyibdcB9PCQ3bEfjw/QeMUboNFnaCTGSReAOzYg9WtryY4Q3tHBvXH7BNiDd8GlxVgHip/XG6F1YRyGrVFUWtuMWlv2J1HqrsHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D1eMXrT6uyvg8aNsCP7cDCR1JCUjZDg8rnjWB38dn4s=;
 b=Ld7SXAAifoMI3oLOBMwAlJCIL7uF34ZN6yugMsMOBfTSAQumm4x2an8kIpqquWWO/jA0Dxi1U6qqWMfuWNvVsbldtJHwnHxO/nbaH3tag4lfESQYsOwiEqdphRRbz2rb9eEL69XxyeIetZPI9jdc3zDCSeWn0bU6zJSdRVM8SaI=
Received: from BN0PR04CA0174.namprd04.prod.outlook.com (2603:10b6:408:eb::29)
 by BN9PR12MB5068.namprd12.prod.outlook.com (2603:10b6:408:135::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Mon, 22 Mar
 2021 03:05:08 +0000
Received: from BN8NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:eb:cafe::db) by BN0PR04CA0174.outlook.office365.com
 (2603:10b6:408:eb::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend
 Transport; Mon, 22 Mar 2021 03:05:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB01.amd.com;
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT011.mail.protection.outlook.com (10.13.176.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3955.18 via Frontend Transport; Mon, 22 Mar 2021 03:05:08 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Sun, 21 Mar
 2021 22:05:07 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Sun, 21 Mar
 2021 22:05:07 -0500
Received: from Roy7.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2106.2 via Frontend
 Transport; Sun, 21 Mar 2021 22:05:06 -0500
From: Roy Sun <Roy.Sun@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/7] drm/amdgpu: Add SMI-LIB ioctl
Date: Mon, 22 Mar 2021 11:05:05 +0800
Message-ID: <20210322030510.31607-1-Roy.Sun@amd.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b585a67e-7fc7-4b2b-9adc-08d8ecdf4ce1
X-MS-TrafficTypeDiagnostic: BN9PR12MB5068:
X-Microsoft-Antispam-PRVS: <BN9PR12MB5068293AE6D9E2E6691E5399FF659@BN9PR12MB5068.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +O8mKqOmcMbutrWUt5wC1gwlwRxdc1eHXQTvHH52JwE8XMrsjfeAT7FaGNkss4/tDTADgW9VusMANLY8UTa1BRlTV2BDTBWYZgOM0xce3vB5vh7EbNFW21rrj37937IWVCjlD90xAnBK68hn2m3nwrZ8s1dYR7Iwpwor1Za4HhBn02aZUsGbCoT9SGCszR7cQ4Xt+NnJxkmOKyCk08PN5O95OlBDLBrJrjVUkHZPetFUkFmGKZUGvJFMnkfsBurIoKdnmjynxDFHdndRozxgW9GH72r+ARVrfqd6OIiMqPv46xqnh1NSX9Y/FXOrRxQrc7BiV74qDgS1mTr+5Ki6aVwR845B8UhQ2WNFxQdQG+knTBv/5ua6FehZzzGq6FqK4zncyeNCnfPJgBXUjc7pE7ic+uSKDUBsylCm8SOl1C+mH42oRXlOeXyPGUli5H50ZlvBXxdlGzrhwu6BRM0L756tlb5DerJcGBxXqbeAwLHDyc4LL8MiBMNmHsIK0fTnJKYR8AqJDMA6v5GAX+ZmURGDBxY5z0EwguDIV/yt1gB3beAf8aggbFpJHzqSmhreCCy1wlC9rXUskEDwF8zgTYRJI7X9GOiet74nwHsVSPULkTzGBiIkFfrhvCSxGk/q5IXxMiMzQ7fmOx1BxIYMWPHVL0ldZkHn0Q4rm2531nOLV9eSvLGtGoVFm0OTsRF0
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(396003)(346002)(376002)(36840700001)(46966006)(54906003)(26005)(82740400003)(186003)(356005)(70586007)(36860700001)(70206006)(8676002)(426003)(8936002)(2906002)(81166007)(6916009)(316002)(2616005)(47076005)(1076003)(5660300002)(336012)(478600001)(82310400003)(7696005)(36756003)(86362001)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2021 03:05:08.4191 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b585a67e-7fc7-4b2b-9adc-08d8ecdf4ce1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5068
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
Cc: Roy Sun <Roy.Sun@amd.com>, yehonsun@amd.com,
 David M Nieto <david.nieto@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: David M Nieto <david.nieto@amd.com>

Add definition for the SMI ioctl

Signed-off-by: David M Nieto <david.nieto@amd.com>
Signed-off-by: Roy Sun <Roy.Sun@amd.com>
---
 include/uapi/drm/amdgpu_drm.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 8b832f7458f2..1d0261239627 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -56,6 +56,7 @@ extern "C" {
 #define DRM_AMDGPU_SCHED		0x15
 /* not upstream */
 #define DRM_AMDGPU_FREESYNC	        0x5d
+#define DRM_AMDGPU_SMI			0x5e
 
 #define DRM_IOCTL_AMDGPU_GEM_CREATE	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_CREATE, union drm_amdgpu_gem_create)
 #define DRM_IOCTL_AMDGPU_GEM_MMAP	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_MMAP, union drm_amdgpu_gem_mmap)
@@ -74,6 +75,7 @@ extern "C" {
 #define DRM_IOCTL_AMDGPU_FENCE_TO_HANDLE DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_FENCE_TO_HANDLE, union drm_amdgpu_fence_to_handle)
 #define DRM_IOCTL_AMDGPU_SCHED		DRM_IOW(DRM_COMMAND_BASE + DRM_AMDGPU_SCHED, union drm_amdgpu_sched)
 #define DRM_IOCTL_AMDGPU_FREESYNC	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_FREESYNC, struct drm_amdgpu_freesync)
+#define DRM_IOCTL_AMDGPU_SMI		DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_SMI, struct drm_amdgpu_smi)
 
 /**
  * DOC: memory domains
@@ -1138,6 +1140,24 @@ struct drm_amdgpu_freesync {
 	__u32 spare[7];
 };
 
+/* Definition of the SMI handlers */
+#define AMDGPU_SMI_MAX_PAYLOAD 1024
+struct drm_amdgpu_smi_in_hdr {
+	__u32		code;
+	__u16		in_len;
+	__u16		out_len;
+};
+
+struct drm_amdgpu_smi_out_hdr {
+	__s32		status;
+};
+
+struct drm_amdgpu_smi {
+	struct drm_amdgpu_smi_in_hdr	in;
+	struct drm_amdgpu_smi_out_hdr	out;
+	__u64		payload;
+};
+
 #if defined(__cplusplus)
 }
 #endif
-- 
2.29.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
