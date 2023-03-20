Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F03EC6FD1D
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Mar 2023 17:38:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0170310E618;
	Mon, 20 Mar 2023 17:38:37 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2065.outbound.protection.outlook.com [40.107.95.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C5B6B10E617
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Mar 2023 17:38:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dulhjQNfe+LxZqYzu9KGgj9ESQolIDPTjLE0AjJBJMy0E2Tm0bD3TN7AYjxEgBqBQKxBpkYCl3fFgQ4w05gw9ltG4qFT33riUSbCuD6pz6zcYpxKFVC+3RYSjqfjY+wAGJCehlwBKoPvb57Sd6KW+o9oNV95WKg5wP/GHMa6yhI3Lka81aQUVcci32Ifm7Jqz3x/krz35kOQLyFDt4P46qkrw0IZzFT5PpRJtVG+8L+zKIabQd/vle6HotShHMaj9IGp2/VzpPce8r+yCXZmmC68NzasjuokPg3PLZzYe1HbErdcbk4RgvlX6tCsmjoruxNM31sts1zg3/M1r9kuzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MeetGIyqZWBhRP79N90t5BmZoy4wIMiKB1se1H5h59I=;
 b=aArlPevykgBMjRGjjwplBpCRPGUhAs88FAtrEMnL3TeGqvfS7val0cfsPpMEmARC49Hq7u31UYUK0IoPRHy0pMEstY6Ft+tmRDXrXhs0jxZPJU82qU9RnRvJUMicIWKvIvO2YXymVyXqiotqdHcWnehne7pM1HQNdrS4sa8YAc0P/AASxChHhX5tF6wKHbAZ87LTpSwFUxNjEvt44nHHzIcSAlrelPFr9cQE5BEigji54iCwFQ4pKk6guI0dtl5T708JjXgLC1GEOlV2/6PMmfRmMgnp65bdfdRMHyhoiOaRax76lFdXc6LHnvVnwAwvrQa2h0ZXNgUZKNLGWYRGXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MeetGIyqZWBhRP79N90t5BmZoy4wIMiKB1se1H5h59I=;
 b=S+RYFuUckqeTYBoY+bvWUwFw0iYKy5xtxvVfPxOrXoXbLzkmOPiKnydT8o4LK87a2SQK8yOwOve70lAqs7vOqHG7g2i9kkxcYQ90RW1/0cBOjwoJluxnMYoNMfXIFKF4Eo3YQwu1IyH7xHW9Y3DJBTgiFP+biUEN4GcK0bDn5LQ=
Received: from MW4PR03CA0168.namprd03.prod.outlook.com (2603:10b6:303:8d::23)
 by MN0PR12MB6365.namprd12.prod.outlook.com (2603:10b6:208:3c2::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Mon, 20 Mar
 2023 17:38:32 +0000
Received: from CO1NAM11FT078.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8d:cafe::25) by MW4PR03CA0168.outlook.office365.com
 (2603:10b6:303:8d::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37 via Frontend
 Transport; Mon, 20 Mar 2023 17:38:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT078.mail.protection.outlook.com (10.13.175.177) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6222.15 via Frontend Transport; Mon, 20 Mar 2023 17:38:31 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 20 Mar
 2023 12:38:29 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 07/11] drm/amdgpu: add UAPI to query GFX shadow sizes
Date: Mon, 20 Mar 2023 13:38:06 -0400
Message-ID: <20230320173810.250835-8-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230320173810.250835-1-alexander.deucher@amd.com>
References: <20230320173810.250835-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT078:EE_|MN0PR12MB6365:EE_
X-MS-Office365-Filtering-Correlation-Id: db51b11e-50b1-4b26-d04d-08db2969ec3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D+91XpIghxZoaUbgIc3+XKVv6xiUcA4hVsgcW5Ktr01F2WLjid9EAven5vETpLrPjc5pxZElWIKQYiONqwPc4M2MxnW6RxCUjW9fWe/FizUSWiCqFdseuukD4IV7roXmLdfj7+CcOENsGRmc8pv4s29ZAAlNSxQ5woE9D+HV5UjL4idIDz8lrs53Z9sYkPjklh692OjTuLc0aUb5N2ViN9WO7sUymWpiMojC1jpnjVMpQaNkLHEh6m9W4KmdakVYeLUsG00VCGQjAF9blbUYqyi5c0mW5JA4nV/y2HMVwdxTIN4kEutOBL/+fQ53yT2GEEF5keIayUyWxfzoNznGCqukwKfIZe2uUyd3WAhflhn7RNtgtAo4y97cUj41Ye738ZGPTCLyamQULLcg1g7/BC8YOVc0Knd6J4Ip68F5X0VEMS72zgTY1WssatOQSeuOObWZi1vqz36nYYLdEHdKQJyLY1Y2ay0o5E/CQjEszKrZzgjXPmARmf6btHC++HytC35dt+ylsKD2op7OyY23DuNB15CKIohNs2s3iA6CCLb8kBSoxVDmR2UCgqvuVVj3IkPiUBDks29wNW6kfgQp+1kN1TMGwvvZmsjc+Mqg5lAvYrcUNr3HxbGVFBmLwx+Ap8ris6tVcfwy4uxbvDiCRa2pyX2wGEF/sU4DD/F2NWkl95+Uj0suCPcQK/1aNoeVv92lGuIP0bzTbKxpiHs1bI7kemQzKUgc1UBo/pVMbRI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(39860400002)(346002)(376002)(396003)(136003)(451199018)(36840700001)(40470700004)(46966006)(40460700003)(6916009)(5660300002)(41300700001)(8936002)(4326008)(2906002)(36860700001)(86362001)(36756003)(356005)(81166007)(82740400003)(7696005)(478600001)(70206006)(70586007)(26005)(40480700001)(82310400005)(8676002)(6666004)(47076005)(316002)(1076003)(426003)(2616005)(16526019)(186003)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2023 17:38:31.3142 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db51b11e-50b1-4b26-d04d-08db2969ec3b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT078.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6365
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add UAPI to query the GFX shadow buffer requirements
for preemption on GFX11.  UMDs need to specify the shadow
areas for preemption.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 include/uapi/drm/amdgpu_drm.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 3d9474af6566..19a806145371 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -886,6 +886,7 @@ struct drm_amdgpu_cs_chunk_cp_gfx_shadow {
 	#define AMDGPU_INFO_VIDEO_CAPS_DECODE		0
 	/* Subquery id: Encode */
 	#define AMDGPU_INFO_VIDEO_CAPS_ENCODE		1
+#define AMDGPU_INFO_CP_GFX_SHADOW_SIZE		0x22
 
 #define AMDGPU_INFO_MMR_SE_INDEX_SHIFT	0
 #define AMDGPU_INFO_MMR_SE_INDEX_MASK	0xff
@@ -1203,6 +1204,15 @@ struct drm_amdgpu_info_video_caps {
 	struct drm_amdgpu_info_video_codec_info codec_info[AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_COUNT];
 };
 
+struct drm_amdgpu_info_cp_gfx_shadow_size {
+	__u32 shadow_size;
+	__u32 shadow_alignment;
+	__u32 csa_size;
+	__u32 csa_alignment;
+	__u32 gds_size;
+	__u32 gds_alignment;
+};
+
 /*
  * Supported GPU families
  */
-- 
2.39.2

