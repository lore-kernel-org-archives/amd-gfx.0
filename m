Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF91CCCD18D
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Oct 2025 16:14:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 51EFB10E498;
	Mon, 13 Oct 2025 16:14:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TUVbWXUQ";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011040.outbound.protection.outlook.com [40.107.208.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A7B110E498
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Oct 2025 16:14:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M8DobZlgXcebT61Z6MJIPKuOJqAFg4Eb3YKZrAh8179JQgSJFPNHVPU5MIC9v+cT1XCaFTSZuyxodD8oyJRqxn3VAkq48fi3U1McAGMjx+tNOJ9SFJtU7dw9+ELW7/zE8DhKwXUd/sieaXGF0qQY2t5RyoBA2SUu/5aS6w09RBXGiue8hgpLNdaw6fbQVyahePD5l9flnNgBVxRHox6znOfmRVTvYZj3500n0d4yq9kR8oP73bqNzhBJadwTX5PYKhsGEgvwioI4KlF9gukFvQ/dkTaD+y/YfL4Vio89jE5B4lQ9QWsKB054zPiTfotijyzjvLlDKIC5T9SfHO/S0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W5e084oL51K7aUZZua4rRIjCCGnr3kWjauOhYaCxgLU=;
 b=gkYskhO0fFcVIUNbpA5yqo2gZUxLnAnyewtzQUzX3TxZlYIeYzdpOlW7GnW0kLnucAMkcX6lW3us/uQQvPxMDD8zUt8lXOv99nuKLexrJnzD/9Z6mkrUvF5IZT5iR4IBhZNfEz5LwL19vtkDADWywgoxiy5hOXl738ySh7CXVTHGsoGMgXw9D1i2XzWrusUnrtDh2THXcqFgZeo7KkdiO40R+EKE5dVc2tnidqf35+RYqqy4y9idaiu3kN3aVXY2WmuFjoxP7X2Q/pcQKG37i1gSNSRfLIuC0FcoZkWh+5rmJ812rpmpeNgk9Q8y0hTWmzn8oBNAYZOOAFzuiEIyNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W5e084oL51K7aUZZua4rRIjCCGnr3kWjauOhYaCxgLU=;
 b=TUVbWXUQO2kabEK6N0JnZ4+0mIp9mxIEk1tvNodm2LQup1gYonGsvkM6mYjXM40dWXygTHSUVZouJizLiRZpm5LUuwf03wZ5tn6kVzlyG9v3TdAK9mw9erqkTCQVRvyipg0Pp+/1hhszP1u81FBNRwnsqt4WXvIIEyInt4iVWVY=
Received: from CYXPR03CA0028.namprd03.prod.outlook.com (2603:10b6:930:d2::26)
 by MN0PR12MB6125.namprd12.prod.outlook.com (2603:10b6:208:3c7::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Mon, 13 Oct
 2025 16:14:16 +0000
Received: from CY4PEPF0000EE33.namprd05.prod.outlook.com
 (2603:10b6:930:d2:cafe::99) by CYXPR03CA0028.outlook.office365.com
 (2603:10b6:930:d2::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.13 via Frontend Transport; Mon,
 13 Oct 2025 16:14:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE33.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Mon, 13 Oct 2025 16:14:15 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 13 Oct
 2025 09:14:08 -0700
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Prike Liang <Prike.Liang@amd.com>
Subject: [PATCH 4/6] drm/amdgpu: Update AMDGPU_INFO_UQ_FW_AREAS query for
 compute
Date: Mon, 13 Oct 2025 12:13:50 -0400
Message-ID: <20251013161352.1628044-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251013161352.1628044-1-alexander.deucher@amd.com>
References: <20251013161352.1628044-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE33:EE_|MN0PR12MB6125:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fabc653-6cd2-471b-969f-08de0a738dfd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YgumuP3kiqYd6eZt7wNl5RbbC+/ANnmcsk28Bh58MUUwOg3YbAsFN0FD5kyo?=
 =?us-ascii?Q?KlpaNKOfdOaYsiyqgYU7+HTJSfqBE153FpG2rWhd2Qp1OfbfDlzrgXklkbNT?=
 =?us-ascii?Q?5IyKoHWGvbD9aOMWVAVrAcNo31pDYk5fn/7C3zpf5DwXTsmX/Y/PElO+zOAO?=
 =?us-ascii?Q?Pu91eQHLsb081BscsBX7dHtWp8FQ47GKHIkUuhefAsx8neVGrh0MdI3+pP/q?=
 =?us-ascii?Q?sbmuSMb8QkDNZhYA3Q1nAhSEeXafcjok1sUWrD8M8Ds0TtIgMd0uKYkHUB5t?=
 =?us-ascii?Q?x9Zw+KvZuA4ZmUHVitwLWd0BlEIKApbyOqMveWcks7HwL9yWgzUni7POlWdT?=
 =?us-ascii?Q?F/y9VA/Nn8EDPc38yms/6OF5BGwjAWoqkJ7wTW3mG9iYSmYGB+lKMCpdfJAn?=
 =?us-ascii?Q?/RAtsh4GemeebgqO7HBrlSEcFvnqmrkg2E4jXpeZ2rNfeStCb0EYbuS5Qsxz?=
 =?us-ascii?Q?1upT2W09UZke4L0IFlPr45XUTibVt2gIubTsR2OujPCOVX9f9a+S3TE3Ed+I?=
 =?us-ascii?Q?A066aUweOW22HiPeGCOhIfa06K6xytIQVoFzkjZqsyteAUYpaSBu4J0jT8ur?=
 =?us-ascii?Q?OpgEiRM1vXiDoD0LvAMaac4QS+D8AeQ691oqw7EWl7h5sNsvCh4uiwxc4T9+?=
 =?us-ascii?Q?E/b6lODiS/lHadWYARqjM0feiheG7CLOT9E4wjNbVMGCE1NnDRf2DYXw8o2w?=
 =?us-ascii?Q?MAP5/OSqv8E8viFolGr/RpBIlekZhR2/z6zCi2pFE01ttNDOm/vjnrlLMcTu?=
 =?us-ascii?Q?DL5lJ4JbLq5cWFbkf16DQgBiSjaH1oXQproemhSLXhdKWcDw6s+dXR8S7SrW?=
 =?us-ascii?Q?+bDUhsOqVjVEOhO0KawbEpJFPPWhi2Akm5kzhvx29eta8Trh5/1JmiOCJEep?=
 =?us-ascii?Q?0NK4lYkxgAlLG7kncoygghdFwn50phV2/HYXLF5fVeWcCqZvBePaWiKu+VKN?=
 =?us-ascii?Q?TlWCPaBp9wCgfpgeDIT+NhmX7YJ/r/HPyMiHN/QDLd5ZAbXUOmIGlqaqYuta?=
 =?us-ascii?Q?QaUkLlI2OBbsVoCjvlQyX6SIOV6yHD9aMzauAMcnDBK0V5ythYDSYdQ50rJD?=
 =?us-ascii?Q?gqqf8xBc52WaczRewz/LSF1Tw2/WFd6yvit1cauK7Jur6RqtX0obxneQ5GGn?=
 =?us-ascii?Q?+MvqZoVPlEk9A3tiOhEtQGrXkUfAvQxEcFQ1dA8SWyxlSsBcNj1UqosCibWf?=
 =?us-ascii?Q?Q59xZNzri24QtkQ6zlxMOq/QVZnw6I/82ssypLi3g77wE0Zt65WihwpW4F3q?=
 =?us-ascii?Q?o9kDlRgdQ+/yQZSfODOUZpUWScBKwynNfYl5HyNDUB0M50KV9ytEkcHPN3Aa?=
 =?us-ascii?Q?KUZqrdHMd29vF1QsHL9CPCEDGaJDfq5x31yY8cZHIqzOW3rOCN5aAr3RldIH?=
 =?us-ascii?Q?GrkcmNU9r0ntiPlaQxwjVLKDK7TJg4yvuHaevGuLYopd4qvy4QbwFFesMPN4?=
 =?us-ascii?Q?XaG3evjThz/H8xJqQZdfyR98qe92ZCxdROuuZtnQ8CMGDhBI5U14sEK7BBVY?=
 =?us-ascii?Q?acixcHOFqhcpQ5rU/pdVHtEdyRs5wu6uSVCucTb1A0DuIWuD99NrS8zoNPA4?=
 =?us-ascii?Q?8RzFeJ9Kwbn6Tl2GGz4=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 16:14:15.2035 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fabc653-6cd2-471b-969f-08de0a738dfd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE33.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6125
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

Add a query for compute queues.  Userspace can use this to
query the size of the EOP buffers for compute user queues.

Reviewed-by: Prike Liang <Prike.Liang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 26 +++++++++++++++++++++++++
 include/uapi/drm/amdgpu_drm.h           |  8 ++++++++
 2 files changed, 34 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index b3e6b3fcdf2cb..8a90b7ba59e6b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -391,6 +391,24 @@ static int amdgpu_userq_metadata_info_gfx(struct amdgpu_device *adev,
 	return ret;
 }
 
+static int amdgpu_userq_metadata_info_compute(struct amdgpu_device *adev,
+					      struct drm_amdgpu_info *info,
+					      struct drm_amdgpu_info_uq_metadata_compute *meta)
+{
+	int ret = -EOPNOTSUPP;
+
+	if (adev->gfx.funcs->get_gfx_shadow_info) {
+		struct amdgpu_gfx_shadow_info shadow = {};
+
+		adev->gfx.funcs->get_gfx_shadow_info(adev, &shadow, true);
+		meta->eop_size = shadow.eop_size;
+		meta->eop_alignment = shadow.eop_alignment;
+		ret = 0;
+	}
+
+	return ret;
+}
+
 static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
 			     struct drm_amdgpu_info *info,
 			     struct drm_amdgpu_info_hw_ip *result)
@@ -1360,6 +1378,14 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 			if (ret)
 				return ret;
 
+			ret = copy_to_user(out, &meta_info,
+						min((size_t)size, sizeof(meta_info))) ? -EFAULT : 0;
+			return 0;
+		case AMDGPU_HW_IP_COMPUTE:
+			ret = amdgpu_userq_metadata_info_compute(adev, info, &meta_info.compute);
+			if (ret)
+				return ret;
+
 			ret = copy_to_user(out, &meta_info,
 						min((size_t)size, sizeof(meta_info))) ? -EFAULT : 0;
 			return 0;
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 406a42be429b2..0840853fa447d 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -1629,9 +1629,17 @@ struct drm_amdgpu_info_uq_metadata_gfx {
 	__u32 csa_alignment;
 };
 
+struct drm_amdgpu_info_uq_metadata_compute {
+	/* EOP size for gfx11 */
+	__u32 eop_size;
+	/* EOP base virtual alignment for gfx11 */
+	__u32 eop_alignment;
+};
+
 struct drm_amdgpu_info_uq_metadata {
 	union {
 		struct drm_amdgpu_info_uq_metadata_gfx gfx;
+		struct drm_amdgpu_info_uq_metadata_compute compute;
 	};
 };
 
-- 
2.51.0

