Return-Path: <SRS0=UsYE=JJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 327B4C433B4
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Apr 2021 12:15:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF3B6601FF
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Apr 2021 12:15:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF3B6601FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 703B58918F;
	Mon, 12 Apr 2021 12:15:08 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2059.outbound.protection.outlook.com [40.107.220.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 173598918F
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Apr 2021 12:15:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gjrnV9xhO29C1ZhYRu0J3Fkl/v8WrzH3k1UFi29uwxFwjA7h8HCj5S7mtlOU+eipnqKU2m6vU+xP0VOe1YPRECcXWoODf6FJwu5rP28Kz4UFM9mRyr+V5r4ZnoKpcaPwbmpsjxmTjlADcuzBFXXlWZjA/TajSIhzAsLwezwAYeMn++753GQHUcNfC1kpsBQSk0U/S8MesL3quT2ttmPoGgUBqCP7pzGXX1HYQYDWyPc7RecWdTy8EIKTKKavgZX6K4PeAikQZF6d2GV1rJ6yfUmzWIk9EEKqS0F0uu+HvB8jGdbKLBVfhGnGfMlxTWH6kE2NS3k1FC3MUU9XzVQMrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1XKVaGUnytLbPHjCYl1ISIjZamkeRUrfXokGsxcabX0=;
 b=MbH9sDVVloG87FaLmGfCtbcKGMwBQalHTuHtF0pTdCJCZxt8jbq+gXfdQ/hAZ+6uL6Paf4ZaP4acpF7LxnC+JPag4VQnq3L2JCpZ7OR1FHy4cOSZyAPjClnhoDVvXdypC7k7DIryifzEcN4PtnhyAVB1QiVyZIB9x7QV2MHl7VfE39H83ADgJvh6gci4jPkwueLNrIj8LdQqkADvdrqTn33AlIU98zDvOMEN+l+778GIN4jCwG7wjiGOFFFMtnrIXI3/G03avZ8qusnX5Pl+DO727GweCv47icA45jhB8xrJ78f3a8gkrpf32FolZmM4H0Z9d/R8XRFo2tDtVMyUKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1XKVaGUnytLbPHjCYl1ISIjZamkeRUrfXokGsxcabX0=;
 b=ZYBXQq7YF2kjn9lUgASJx/3gAcxQq653Z85KyIbOi9PkGBiBhpcMbyAp5Drw2qsdhtonGQe84Ea3Rhitb54toPZvPpwn6vAq2PU22MqpvZlQ15GzqZicEWPkwC1FB8QHMKSAp6k0K3P9dsk+EHZY1Z5wBIyd2FUa8y1p4bPl//Y=
Received: from DM5PR21CA0012.namprd21.prod.outlook.com (2603:10b6:3:ac::22) by
 DM4PR12MB5037.namprd12.prod.outlook.com (2603:10b6:5:388::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4020.16; Mon, 12 Apr 2021 12:15:05 +0000
Received: from DM6NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:ac:cafe::fd) by DM5PR21CA0012.outlook.office365.com
 (2603:10b6:3:ac::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.0 via Frontend
 Transport; Mon, 12 Apr 2021 12:15:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT008.mail.protection.outlook.com (10.13.172.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4020.17 via Frontend Transport; Mon, 12 Apr 2021 12:15:05 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Mon, 12 Apr
 2021 07:15:04 -0500
Received: from Roy7.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2106.2 via Frontend
 Transport; Mon, 12 Apr 2021 07:15:03 -0500
From: Roy Sun <Roy.Sun@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/amdgpu: Expose some power info through AMDGPU_INFO
Date: Mon, 12 Apr 2021 20:15:05 +0800
Message-ID: <20210412121505.23787-1-Roy.Sun@amd.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 87c011fa-6808-454f-08f3-08d8fdac9b61
X-MS-TrafficTypeDiagnostic: DM4PR12MB5037:
X-Microsoft-Antispam-PRVS: <DM4PR12MB5037C94C1F452C4587C80A3DFF709@DM4PR12MB5037.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D9Eg159sBV4cniF4YQBKNoqd9c4v0bj9t0LbcPv92U12jlv5hKWZu7/6UtPAn5PBLE/aD5X2y9zePKMMbPzUwpbP8bQ8TCbGGhnDCPmsbdSTvazLdYGpGMNIVNeFRPoGckSyIdsXzfCZUk7/5XxocjQkxYt9O+Y5p8K7ox02NcZYV4gH4UnCB+F0LHPUfK+OJ/5/m3O2GPmZ9+KspCbHCMQEd0sMZ8iSWtduzfPAAim5lJGdKI3klyQK4gccrIdc/JXRC/XH8mxdaH1Cljhh77DBd39jbNwxRkTWSGsJGLYljKetOeyA9lNtK6CdS5jIfLhQUrn5ESo9xxGpEDq70MawM6nAbfxU3jZuuVmP420pPhzVCBrRCaWlUtdQtlDiCDa5qR0astmMWKkzf5ok4v81Gl0ijhWRxCSMroP3wg0S1NQV0zjesyMT94LGocDm2rlQCvnQtOoVE/vkV5HgFqY9Wt7H84mX8iTH0DxNNOEsdQk1auuHyiPT+IZePQfbUQt7VBftBJGugoYD3xYU4Da4+4AuffbfTM8CsPydmdWE9WVQ80mehfioqw9lGhgKmqi/J+gGZvAWvnY7hq52r6mDcAfB14GkXlXR6trsU03jME1IPxrFFZ+m5Bk/cPS3PusfhIV9gw1phn5vVzZ2M5rOIeDvKHETtCEUp1wJS5TtXONNmZMSiZXWkPsYfyNb
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(346002)(136003)(39860400002)(376002)(36840700001)(46966006)(6916009)(5660300002)(1076003)(4326008)(7696005)(426003)(2616005)(8676002)(316002)(82310400003)(36860700001)(356005)(336012)(70206006)(70586007)(83380400001)(82740400003)(478600001)(36756003)(2906002)(86362001)(186003)(47076005)(8936002)(81166007)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2021 12:15:05.4975 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 87c011fa-6808-454f-08f3-08d8fdac9b61
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5037
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
Cc: Roy Sun <Roy.Sun@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add interface to get the mm clock, temperature and memory load

Signed-off-by: Roy Sun <Roy.Sun@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 50 +++++++++++++++++++++++++
 include/uapi/drm/amdgpu_drm.h           | 12 ++++++
 2 files changed, 62 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index b2e774aeab45..e5b16e0819ce 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -971,6 +971,56 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 			}
 			ui32 /= 100;
 			break;
+		case AMDGPU_INFO_SENSOR_UVD_VCLK:
+			/* get mm vclk in Mhz */
+			if (amdgpu_dpm_read_sensor(adev,
+						   AMDGPU_PP_SENSOR_UVD_VCLK,
+						   (void *)&ui32, &ui32_size)) {
+				return -EINVAL;
+			}
+			ui32 /= 100;
+			break;
+		case AMDGPU_INFO_SENSOR_UVD_DCLK:
+			/* get mm dclk in Mhz */
+			if (amdgpu_dpm_read_sensor(adev,
+						   AMDGPU_PP_SENSOR_UVD_DCLK,
+						   (void *)&ui32, &ui32_size)) {
+				return -EINVAL;
+			}
+			ui32 /= 100;
+			break;
+		case AMDGPU_INFO_SENSOR_HOTSPOT_TEMP:
+			/* get junction temperature */
+			if (amdgpu_dpm_read_sensor(adev,
+						   AMDGPU_PP_SENSOR_HOTSPOT_TEMP,
+						   (void *)&ui32, &ui32_size)) {
+				return -EINVAL;
+			}
+			break;
+		case AMDGPU_INFO_SENSOR_EDGE_TEMP:
+			/* get current edge temperature */
+			if (amdgpu_dpm_read_sensor(adev,
+						   AMDGPU_PP_SENSOR_EDGE_TEMP,
+						   (void *)&ui32, &ui32_size)) {
+				return -EINVAL;
+			}
+			break;
+		case AMDGPU_INFO_SENSOR_MEM_TEMP:
+			/* get current memory temperature */
+			if (amdgpu_dpm_read_sensor(adev,
+						   AMDGPU_PP_SENSOR_MEM_TEMP,
+						   (void *)&ui32, &ui32_size)) {
+				return -EINVAL;
+			}
+			break;
+		case AMDGPU_INFO_SENSOR_MEM_LOAD:
+			/* get memory load */
+			if (amdgpu_dpm_read_sensor(adev,
+						   AMDGPU_PP_SENSOR_MEM_LOAD,
+						   (void *)&ui32, &ui32_size)) {
+				return -EINVAL;
+			}
+			break;
 		default:
 			DRM_DEBUG_KMS("Invalid request %d\n",
 				      info->sensor_info.type);
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 8b832f7458f2..484c72e17c72 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -780,6 +780,18 @@ struct drm_amdgpu_cs_chunk_data {
 	#define AMDGPU_INFO_SENSOR_STABLE_PSTATE_GFX_SCLK		0x8
 	/* Subquery id: Query GPU stable pstate memory clock */
 	#define AMDGPU_INFO_SENSOR_STABLE_PSTATE_GFX_MCLK		0x9
+	/* Subquery id: Query GPU mm vclk */
+	#define AMDGPU_INFO_SENSOR_UVD_VCLK		0xa
+	/* Subquery id: Query GPU mm dclk */
+	#define AMDGPU_INFO_SENSOR_UVD_DCLK		0xb
+	/* Subquery id: Query junction temperature */
+	#define AMDGPU_INFO_SENSOR_HOTSPOT_TEMP		0xc
+	/* Subquery id: Query edge temperature */
+	#define AMDGPU_INFO_SENSOR_EDGE_TEMP		0xd
+	/* Subquery id: Query memory temperature */
+	#define AMDGPU_INFO_SENSOR_MEM_TEMP		0xe
+	/* Subquery id: Query Memory load */
+	#define AMDGPU_INFO_SENSOR_MEM_LOAD		0xf
 /* Number of VRAM page faults on CPU access. */
 #define AMDGPU_INFO_NUM_VRAM_CPU_PAGE_FAULTS	0x1E
 #define AMDGPU_INFO_VRAM_LOST_COUNTER		0x1F
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
