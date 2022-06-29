Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A5FDC433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Jun 2022 18:16:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB2F410E514;
	Wed, 29 Jun 2022 18:16:39 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2080.outbound.protection.outlook.com [40.107.92.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1805210E514
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Jun 2022 18:16:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I6pF1mT/hQXpzZ1wqNGyNxw7Hy7hf861h1Xnfnu5rzb71WspGY52BKUiJ7WaAj00fj55YcN+ZU51p+kyibzlgBEiZFlW1kqYkO8uwOKwt3L7qjkyRWBjYy9ro0M03gF8muh5+hGm2OU3ifCUSpKdOVZ1k+v1DqvNbvQFr5tefQb4UGFj8ZOLPUv8UYIc97Wl7JMyIS7ZXkP6CDLzK6D4FzIYWMKm0UhotuhVINMy6acHHuj8mjwaj9LDFOcYOVnBMBBIimY6LNj1vljigjQSXiZZ7suqjc2DNy4ae31TzZCbrFbtcgdBsFTKQGT+LBrsYHxlQSQkx+nu6HW3SpY/IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xdG57uVzP1+/7T0HjIQTtTTiBC8O23rKTw3vf89cIOI=;
 b=Evw97WOWemFv9SCDSpksJQO2SKA1k9u3p0E2tWqL205VPMcs9oYqtP9eoYomWEk+2E500eiiLzgW6uzobT0L/GhoR4RzQQGpODbhRZkIHaE1rBeiG9x/qE051DYtx5uo2cMdymu6DgA4ttQAP8wJ2FN+4Vkce568f4J7D/WsWQlP9uOfoG34Z/ubpoMPbToru2culmziXx5+SOFp0ndvj0CYgKWudfMFOVW77I2GxAFE4f3K1FsQws/kvLOHBgHdsW6Y4pXzuCoTXbysbPpLyadbxQi2IX18dSN0zZaN1v92mYGgJyro2IDc2Fki5evAFhsESxhDkxm7RvuxBZkm8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xdG57uVzP1+/7T0HjIQTtTTiBC8O23rKTw3vf89cIOI=;
 b=SlkVIikZfdtXG2IOqRTJPVhlaLXIQgXkPMGpZmnQ5u8dCx6YFLHxQgP1emeg6w12xjJCfjvaeSLz8OaV5wINMaqpvLjMIv74C1tFvyuPjB8zA3pnErsy5Ds/SdgTnKJoez8Yzkp27XV5i0fbvD8Y/bTDW3RTxi/LoHph9OfFS9Y=
Received: from BN9PR03CA0089.namprd03.prod.outlook.com (2603:10b6:408:fc::34)
 by DM4PR12MB5118.namprd12.prod.outlook.com (2603:10b6:5:391::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Wed, 29 Jun
 2022 18:16:35 +0000
Received: from BN8NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fc:cafe::9e) by BN9PR03CA0089.outlook.office365.com
 (2603:10b6:408:fc::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14 via Frontend
 Transport; Wed, 29 Jun 2022 18:16:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT066.mail.protection.outlook.com (10.13.177.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5373.15 via Frontend Transport; Wed, 29 Jun 2022 18:16:35 +0000
Received: from jonathan-KFD.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 29 Jun
 2022 13:16:34 -0500
From: Jonathan Kim <jonathan.kim@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: fix cu mask for asics with wgps
Date: Wed, 29 Jun 2022 14:16:23 -0400
Message-ID: <20220629181623.741918-1-jonathan.kim@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ba5291e5-4906-4f50-2dab-08da59fb8085
X-MS-TrafficTypeDiagnostic: DM4PR12MB5118:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qXB92dXOZ8Z+SHkPU7dK6h2qg4XpUjHlDoO5SrFjEjxcKW+LaWQwVYqMjSE4z9aocxmlNiNheFgm3YcDPaiYOYWUMA8JwvnPLmf07b/YiVbHUO+C+xhNHibaESHliHFonmcOS87VkfC0RHAJPa7H1zftX8Uw//Acza/gHACPQxJBeqqZ6KQNovev0wQ+CigAguZw5KD6BRD9myDTYJFrI7q5g7RxzSsj4MP4q97Bh96Pxjt15ekODbVjhwMycX+s+Sze6Z/BrrHh32QNKYfJJ41tFdtQKjipELFKeGAvXtJfSqvDyKQZb9uCh9d85+MdlC6WTzEUr15MNvgEQ0zL9FQA58lm3rmGpOgLYVX8VmGidDEQNGBUsUkwdWWXJSJGVuyKOPtLx08BzAprSKnDx/qcnnuhZ6TovAQu/zQtDrRzuUIG1D499zhSu1zjA4bprPMNI7Sk/pQ1A0pAEBL4jrFCfgDJYs4ZFeiqB8HXYUcaHFnonGe/OsquolBWuRWYaYHyETmY8v5QQKkL0NaZxxii1EutLOYf8XNwQy7sblxN5EUfScOIKkcPE2qx5oz+W4ZZ4TL4VAMNHrS/PWTsSdOc90bsGYKNr4ob2m+f93XDg1JFFbq1XndtlxiXzdcpn7dkgi40PRBGpO8xc8x4ggYiJmizG/0vMjZ74mUzT6zaQYWjh38wuwVNHtQtseYBBiGcyTXPXI71SGb3ASPSEk7h1jPGVkgdcJrA/BsTp1k3ZftwbgoNNPqiA13ZNOFjX6XZspgqqakFLu5Nqf88bW6/G8iiCiYsleeQc8LkGG1iRwbUqDOMO4mcXX1pZ0owqolDf/PmLh2dPK4Ek+Nklg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(136003)(376002)(346002)(396003)(36840700001)(40470700004)(46966006)(316002)(70586007)(8676002)(4326008)(70206006)(478600001)(6666004)(6916009)(40480700001)(40460700003)(82310400005)(54906003)(8936002)(2906002)(5660300002)(44832011)(36860700001)(86362001)(36756003)(81166007)(82740400003)(186003)(356005)(336012)(426003)(47076005)(16526019)(2616005)(1076003)(41300700001)(7696005)(26005)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2022 18:16:35.3440 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba5291e5-4906-4f50-2dab-08da59fb8085
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5118
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
Cc: Felix.Kuehling@amd.com, Jonathan Kim <jonathan.kim@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

GFX10 and up have work group processors (WGP) and WGP mode is the native
compile mode.

KFD and ROCr have no visibility into whether a dispatch is operating
in CU or WGP mode.

Enforce CU masking to be pairwise continguous in enablement and
round robin distribute CUs across the SEs in a pairwise manner to
assume WGP mode at all times.

Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c      | 12 +++++++-----
 .../drm/amd/amdkfd/kfd_process_queue_manager.c    | 15 +++++++++++++++
 2 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
index 49a283be6b57..7febd1e69d13 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
@@ -100,7 +100,9 @@ void mqd_symmetrically_map_cu_mask(struct mqd_manager *mm,
 {
 	struct kfd_cu_info cu_info;
 	uint32_t cu_per_sh[KFD_MAX_NUM_SE][KFD_MAX_NUM_SH_PER_SE] = {0};
-	int i, se, sh, cu, cu_bitmap_sh_mul;
+	bool wgp_mode_req = KFD_GC_VERSION(mm->dev) >= IP_VERSION(10, 0, 0);
+	uint32_t en_mask = wgp_mode_req ? 0x3 : 0x1;
+	int i, se, sh, cu, cu_bitmap_sh_mul, inc = wgp_mode_req ? 2 : 1;
 
 	amdgpu_amdkfd_get_cu_info(mm->dev->adev, &cu_info);
 
@@ -167,13 +169,13 @@ void mqd_symmetrically_map_cu_mask(struct mqd_manager *mm,
 		se_mask[i] = 0;
 
 	i = 0;
-	for (cu = 0; cu < 16; cu++) {
+	for (cu = 0; cu < 16; cu = cu + inc) {
 		for (sh = 0; sh < cu_info.num_shader_arrays_per_engine; sh++) {
 			for (se = 0; se < cu_info.num_shader_engines; se++) {
 				if (cu_per_sh[se][sh] > cu) {
-					if (cu_mask[i / 32] & (1 << (i % 32)))
-						se_mask[se] |= 1 << (cu + sh * 16);
-					i++;
+					if (cu_mask[i / 32] & (en_mask << (i % 32)))
+						se_mask[se] |= en_mask << (cu + sh * 16);
+					i = i + inc;
 					if (i == cu_mask_count)
 						return;
 				}
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index c9c205df4a14..fc0416f6f83e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -498,6 +498,21 @@ int pqm_update_mqd(struct process_queue_manager *pqm,
 		return -EFAULT;
 	}
 
+	/* ASICs that have WGPs must enforce pairwise enabled mask checks. */
+	if (minfo && minfo->update_flag == UPDATE_FLAG_CU_MASK && minfo->cu_mask.ptr &&
+			KFD_GC_VERSION(pqn->q->device) >= IP_VERSION(10, 0, 0)) {
+		int i;
+
+		for (i = 0; i < minfo->cu_mask.count; i = i + 2) {
+			uint32_t cu_pair = (minfo->cu_mask.ptr[i / 32] >> (i % 32)) & 0x3;
+
+			if (cu_pair && cu_pair != 0x3) {
+				pr_debug("CUs must be adjacent pairwise enabled.\n");
+				return -EINVAL;
+			}
+		}
+	}
+
 	retval = pqn->q->device->dqm->ops.update_queue(pqn->q->device->dqm,
 							pqn->q, minfo);
 	if (retval != 0)
-- 
2.25.1

