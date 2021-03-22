Return-Path: <SRS0=Az3f=IU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C87AC433DB
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Mar 2021 02:54:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E701E61930
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Mar 2021 02:54:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E701E61930
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A511189F61;
	Mon, 22 Mar 2021 02:54:39 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2060.outbound.protection.outlook.com [40.107.93.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3FC7B89F61
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Mar 2021 02:54:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ddw58khLpfeGeTAfaJzjcQBVqMWOfSI+TqadY+hFmIs1fPO1B5nvhNNNjDGPR/XUM7GEWtZSk7d/dznargH8cuPtXAO7sF4V3t+UaTPGgCpQlBEJ2UfNGW2VUME3ePxABmVdYSiguh74kZY3mHJ+zDyy42ZOk/69cKSa03nn1ex0+b58WZ8WGeljiTlmSw2npQibiLPMzbT57ITHU1h43zStVdD/3tuX/J+Sm/wUVs8WWbzj3xGqlnlZY98B6GO9jh1ADrKSSU8KIYwtkhXMRYnLQAd5/ZR5XsgI16LBDt6OzwW22A1uFCDQiErGYSsAlEGjnDXmmUlfowDycz8fCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D1eMXrT6uyvg8aNsCP7cDCR1JCUjZDg8rnjWB38dn4s=;
 b=Abw7gVJ2XF65+gvP8GaDFPprVZz9oNL9IGHSzufZQ6YwgmGphuzWjD0fNAkxiZxF33M//BNkfgDaZByQ9SmOUCp6xstLwgc/WxI3qazwLqMvQzRT8geRJdYBKD5e18yB/5fQZuDoEeuTcJIPX25S0uHys64VNP2Fiqx1PrClsjizOkgUazW+ActW/7WaVGf6/8ANAWdQRgDbS6xfXzWg+QmuZTgcrmmCX4/r2LEJSx9SnKvpwd03z+SQ6//W+9J1PxbVBoJEO/NPVGGGFhQImTgWirx9shptiqWE/8lYO6JNZBFJf2UOrRKecft+/f4AboN0iutXyNp8+S6we8Kplw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D1eMXrT6uyvg8aNsCP7cDCR1JCUjZDg8rnjWB38dn4s=;
 b=UxW8TQua3eFOQ/Ugv1Dq76/SGhwruFpN/j1KSYTqa4lyusc1BCnE8tG2RVBx14Pzzo6CspBy/vr2cKPULCJX46vgtEFMYvI52d33+KiGgWdE//nvpmDFJdJl9L/KoN7n1aREBxZHHQ3PdOzg2HpS6fuLRS2LNeEPfOqTUF9lN38=
Received: from MWHPR19CA0049.namprd19.prod.outlook.com (2603:10b6:300:94::11)
 by BYAPR12MB4776.namprd12.prod.outlook.com (2603:10b6:a03:10d::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Mon, 22 Mar
 2021 02:54:34 +0000
Received: from CO1NAM11FT058.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:94:cafe::d8) by MWHPR19CA0049.outlook.office365.com
 (2603:10b6:300:94::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend
 Transport; Mon, 22 Mar 2021 02:54:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB01.amd.com;
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT058.mail.protection.outlook.com (10.13.174.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3955.18 via Frontend Transport; Mon, 22 Mar 2021 02:54:34 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Sun, 21 Mar
 2021 21:54:33 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Sun, 21 Mar
 2021 21:54:33 -0500
Received: from Roy7.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2106.2 via Frontend
 Transport; Sun, 21 Mar 2021 21:54:32 -0500
From: Roy Sun <Roy.Sun@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/7] SWDEV-275015 - drm/amdgpu: Add SMI-LIB ioctl
Date: Mon, 22 Mar 2021 10:54:05 +0800
Message-ID: <20210322025410.30570-1-Roy.Sun@amd.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8422f0d4-a2e8-4b29-d01a-08d8ecddd334
X-MS-TrafficTypeDiagnostic: BYAPR12MB4776:
X-Microsoft-Antispam-PRVS: <BYAPR12MB47760072DB43D12662691450FF659@BYAPR12MB4776.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Crz4abj+2LDZR0d8BzJFLUAa44N1sLAKabtvon8bBVBzXIEtKcdWWfBkejCn4KYZLNIBW/ZZpxCJKV1wsMII+EwnkwfgjV6heLTBvL21vAoeUX1wz0F/mfjZlAPgaNihlknvvuDMQr8/WITz4/HSVP8lGmuuHq1F3kUsVd3tTFcpWfty7eQ9O7Sp9UngaPqw3bbJ/mNIDjhOcjS9rLJMTerDx2sxxmh0k0NSufi9X37rDmlILdvBRLMmJrOGKm0aMNsLPeYHUfXgLDXS6h7mnZV+2GFOB8XwUoawvKeFE+aae/kyVmMPnhS01AdmSFoHwN59TLIm8xPX3czQ4BKBcdCqxWLboXIAUaoknTLegpyCCR7yJEvXQ8sDwlmd0l1q4xQ8LZGSMz5wUvOoGmjn6+JGkjiP/p/yovHETIwa2r7lAOa8XtmyxSPjQmhbzlSm/di7bqomqCQrr54Kby8dDmdu3vTk1sPDo2Bso+vKLfDqNvP+S522d0rHT84E3Ov3Bf7ZLcrSsb38+jSU4kq/OnkiK0b7bT3yc1gC6wsi6+8v24d2krCbRx6r9cUML47OotsYobvYQKOlfW5UvU5Gi3Y9V64aQ3CnTjkD4hJo4aAMLc+LV4NExTJNUEN9aeEiTVE5aOETJG1+LxCqp4+xFnHoqbR7G8skZQ5yKNvUGGVhxqkXsqnI4AbnzNPRx4dY
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(396003)(376002)(346002)(39860400002)(36840700001)(46966006)(86362001)(82740400003)(4326008)(8676002)(70586007)(70206006)(81166007)(356005)(1076003)(7696005)(6666004)(82310400003)(426003)(26005)(316002)(54906003)(478600001)(36860700001)(47076005)(2616005)(5660300002)(6916009)(8936002)(36756003)(2906002)(336012)(186003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2021 02:54:34.6717 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8422f0d4-a2e8-4b29-d01a-08d8ecddd334
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT058.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB4776
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
