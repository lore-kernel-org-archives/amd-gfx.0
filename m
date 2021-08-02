Return-Path: <SRS0=SMOw=MZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C86A2C4338F
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Aug 2021 16:28:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 885B060EB2
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Aug 2021 16:28:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 885B060EB2
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A1136E083;
	Mon,  2 Aug 2021 16:28:24 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2046.outbound.protection.outlook.com [40.107.244.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8BC6F6E083
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Aug 2021 16:28:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h7uNtzXMiuUbOm56eAOr5+lRMXJ71HGHD9E9tMmtowjEAn8je9vFfkY0saSmbFSsngkJlbRLKag45QWQtP7YM3t84Am6N6rXQocOcRLRYDAF58mqrwNWFmiaynPqgM1VA///4CY7XxNnYQ8h0GK/g74F8IHfcTbEKjcdMIxkFnVes+MLQ6r9a77UMcVHq0TYVEcrRzhSA8kMVZy+a5StDriyVOIBlPbdQRNwmK2ljgMQsoUE6prN7ceZvlLIMD/XJ6abOEqtoWXrPnI5k5fgscHvU6NKpagtkAJ2Q7rwyGqWtiJkzmph2xBQXWpQizPpwZuKuJzeymV7g7zpHsoGbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vWqvncKX0SX8Gt/nLPFjEyCSEtVfPu+cmzyvjMdzfhY=;
 b=Xp6XKkFTyVAFlgOKahzvr7Ua8vsaffXHSJb3aFA92ZzhhJdM/xZGb3X0kqj6MONKzEVMVOylI0tYZG+q3a8SSeQwpa6gXY0O6BdQxMsqnkalaX5RzFuHXl9rUGwukTAaJ1alVBbsa3cInndzdf7GOvdMl9dgV+bYOzrUZcH2UYg3dGoK4mQCRWzHF0UZPPClyrQkxIth/MswVLWUuVatZRmITWG6xd7gRD/NCmpA1oDQh4DUlNp6bkNcH3Q8swej4LpBPh74/wqulRM9Dk0g5BnrockS2PnUadyYVdFr8G2RY9LAudApslEHCTSd+fgqpnjO10yqxRBZ6iFvC5xsmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vWqvncKX0SX8Gt/nLPFjEyCSEtVfPu+cmzyvjMdzfhY=;
 b=gPCM9Ai5r/Z0U4kKahd0gHylBmosxGMvMI/fA1Jm/+k4CAostvQQyeimtZXq9O1pU80a/xZ818IHetKEezn9x978jCU5JUUUFeepE6IE0yR2Hkxji82ST/MMJZrpDfPe5V1wMAPDNHWlADbKj8rkiy+SRSE/7KzsiU7ZI9dTCjk=
Received: from DM5PR20CA0004.namprd20.prod.outlook.com (2603:10b6:3:93::14) by
 BL1PR12MB5288.namprd12.prod.outlook.com (2603:10b6:208:314::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18; Mon, 2 Aug
 2021 16:28:20 +0000
Received: from DM6NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:93:cafe::4a) by DM5PR20CA0004.outlook.office365.com
 (2603:10b6:3:93::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.17 via Frontend
 Transport; Mon, 2 Aug 2021 16:28:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT055.mail.protection.outlook.com (10.13.173.103) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4373.18 via Frontend Transport; Mon, 2 Aug 2021 16:28:20 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Mon, 2 Aug
 2021 11:28:19 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Philip Yang <Philip.Yang@amd.com>
Subject: [PATCH] drm/amdkfd: AIP mGPUs best prefetch location for xnack on
Date: Mon, 2 Aug 2021 12:28:06 -0400
Message-ID: <20210802162806.12631-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f1605a34-6cfe-4bab-a268-08d955d28a81
X-MS-TrafficTypeDiagnostic: BL1PR12MB5288:
X-Microsoft-Antispam-PRVS: <BL1PR12MB528823A7A51F4CFFD75AE789E6EF9@BL1PR12MB5288.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vr4vNqD4VPJlKVphr815AIAlUzBd8R5vD7kNEOlj9+f5QSVaBDhei2gW4ivOt0FX2Xe6e4bQIsk3YwNdztJGZ6QV5MpluCmxu971yLBwrseq/vPO8QqHvKXiuaWBDjQZfmce0gJMmowKcZny8c+5jsraAoU5sjr4SikvtrpkbErUbozcrgZWfTwopLqO/uNqwEY2EH95Tm/1wrm0TjMvpPdDituJ/XVCagRDJXcdyWU6b2URTogB/Pv5+CXPjjiYa4WO89UEfh42isGRUgR0NaoCutXSOYJ3iY7y2/9SOqqxZV90u9pPWGIKDkzynDPSW/4Y9p0SLWF6lHNEEejG1WVRsLnFNpHJBoyWIe1I4cHAwhb99rEM8gd1dQLqjKjFXYo8d3lWrcPG2I00uJqaJBFUrieVD+YJI52NXysQuJ3u2ZH8S1GUvIi2AQ+pQMtQyfQFVYfipez9haPQeVV3k6d+f9wL/ZRe2faqHhp/x1QB9rnxMOa5/VvBoOaAVKBWc3fVA/XU0PHzLIdjE8lS2C8JosNiPW/tWTVEVQJJ+OEhZbaQGaqYOWfz8rKKKM5n3s9ojCStt9InR6zJI9Y4AekTff8RBzP606uouUZ02OSH6YuLdLzAjaqn2nygYGETVASdVVbYvBgozQ/NLSNpYOGbWHCSFck2kgJdiecLm4ThJKwDW9OFspRrMA1w2PwlRQn4glFTTpxJXQD/9+Fq6/GIa8kjp3shKIeCxcaTUHE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(346002)(39860400002)(396003)(136003)(46966006)(36840700001)(82740400003)(2616005)(83380400001)(36860700001)(86362001)(478600001)(81166007)(356005)(336012)(4326008)(5660300002)(316002)(70206006)(6666004)(36756003)(2906002)(70586007)(16526019)(8676002)(8936002)(1076003)(47076005)(6916009)(186003)(7696005)(426003)(26005)(82310400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2021 16:28:20.3911 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1605a34-6cfe-4bab-a268-08d955d28a81
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5288
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

For xnack on, if range ACCESS or ACCESS_IN_PLACE (AIP) by single GPU, or
range is ACCESS_IN_PLACE by mGPUs and all mGPUs connection on xgmi same
hive, the best prefetch location is prefetch_loc GPU. Otherwise, the best
prefetch location is always CPU because GPU can not map vram of other
GPUs through small bar PCIe.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 44 +++++++++++++++++-----------
 1 file changed, 27 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 69237d2ab2ad..6160c301f78b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -2754,22 +2754,29 @@ svm_range_add(struct kfd_process *p, uint64_t start, uint64_t size,
 	return 0;
 }
 
-/* svm_range_best_prefetch_location - decide the best prefetch location
+/**
+ * svm_range_best_prefetch_location - decide the best prefetch location
  * @prange: svm range structure
  *
  * For xnack off:
- * If range map to single GPU, the best acutal location is prefetch loc, which
+ * If range map to single GPU, the best prefetch location is prefetch_loc, which
  * can be CPU or GPU.
  *
- * If range map to multiple GPUs, only if mGPU connection on xgmi same hive,
- * the best actual location could be prefetch_loc GPU. If mGPU connection on
- * PCIe, the best actual location is always CPU, because GPU cannot access vram
- * of other GPUs, assuming PCIe small bar (large bar support is not upstream).
+ * If range is ACCESS or ACCESS_IN_PLACE by mGPUs, only if mGPU connection on
+ * xgmi same hive, the best prefetch location is prefetch_loc GPU. If mGPUs
+ * connection on PCIe, the best prefetch location is always CPU, because GPU
+ * cannot map vram of other GPUs, assuming PCIe small bar (large bar support is
+ * not upstream).
  *
  * For xnack on:
- * The best actual location is prefetch location. If mGPU connection on xgmi
- * same hive, range map to multiple GPUs. Otherwise, the range only map to
- * actual location GPU. Other GPU access vm fault will trigger migration.
+ * If range map to single GPU or is not ACCESS_IN_PLACE by mGPUs, the best
+ * prefetch location is prefetch_loc, other GPU access vm fault will trigger
+ * migration.
+ *
+ * If range is ACCESS_IN_PLACE by mGPUs, only if mGPU connection on xgmi same
+ * hive, the best prefetch location is prefetch_loc GPU. If mGPUs connection on
+ * PCIe, the best prefetch location is always CPU, because GPU cannot map vram
+ * of other GPUs.
  *
  * Context: Process context
  *
@@ -2787,14 +2794,13 @@ svm_range_best_prefetch_location(struct svm_range *prange)
 	struct kfd_process *p;
 	uint32_t gpuidx;
 
-	p = container_of(prange->svms, struct kfd_process, svms);
-
-	/* xnack on */
-	if (p->xnack_enabled)
+	if (!best_loc || best_loc == KFD_IOCTL_SVM_LOCATION_UNDEFINED)
 		goto out;
 
-	/* xnack off */
-	if (!best_loc || best_loc == KFD_IOCTL_SVM_LOCATION_UNDEFINED)
+	p = container_of(prange->svms, struct kfd_process, svms);
+
+	if (p->xnack_enabled &&
+	   bitmap_weight(prange->bitmap_aip, MAX_GPU_INSTANCE) <= 1)
 		goto out;
 
 	bo_adev = svm_range_get_adev_by_id(prange, best_loc);
@@ -2803,8 +2809,12 @@ svm_range_best_prefetch_location(struct svm_range *prange)
 		best_loc = 0;
 		goto out;
 	}
-	bitmap_or(bitmap, prange->bitmap_access, prange->bitmap_aip,
-		  MAX_GPU_INSTANCE);
+
+	if (p->xnack_enabled)
+		bitmap_copy(bitmap, prange->bitmap_aip, MAX_GPU_INSTANCE);
+	else
+		bitmap_or(bitmap, prange->bitmap_access, prange->bitmap_aip,
+			  MAX_GPU_INSTANCE);
 
 	for_each_set_bit(gpuidx, bitmap, MAX_GPU_INSTANCE) {
 		pdd = kfd_process_device_from_gpuidx(p, gpuidx);
-- 
2.17.1

