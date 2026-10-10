Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55085CA9EBB
	for <amd-gfx@archiver.kernel.org>; Sat, 10 Oct 2026 02:50:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E67B510E9E8;
	Sat, 10 Oct 2026 02:50:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gdta0PNM";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012062.outbound.protection.outlook.com
 [40.93.195.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2686F10EB63
 for <amd-gfx@lists.freedesktop.org>; Sat, 10 Oct 2026 02:50:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SERVmdZlvJlcoDDqnzrmeacblyFLe98uYojI2BNrdAUxwOisqYaa9+ypw2zAqXOkJ6TVFnBuZj7pg0OcGqXs+jud2rpnPF9l5fVszjcNMo32espGskna/HvGxBoXnmISuAUrEDITGwGjQ8azwmKloscsVGNpIN8ux+XdVrgOYOksmrKOR+CR+XhmHREUNLkX4ZhfTmHtD6XPPuC3TVbN3TjzX1hytLwFUj8wF1QCMPHH1FzIV35NAZ+kqE+HjqI1XguTuscASdq+2ye0DF/UF6de8BYYftD+Z2g97TkSl4vJZjAJAJ1+g6soVzHGE9rbb+OJIyMW5J+ybagd8owLOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M/u0fZquSnNwtPsanEJPtymNzod/4b4BaO0spZqhRZo=;
 b=pkPu6m/rZv/dJDp4jXnYDsi1mVL3zrdTsFO8Jpi+CH+3DwDLu76kHkU386YKtR5pAC1bB3Zf6IfwEh98UQSL+QSzMqynUJENUvhWjBsEMFGrue6afwaF+YnrHOKhEESpXsceEkr4e1P9Vkc3E2ih5OA6G68ENaMl3kMbbWufUuA9ferwnsTbJG+y82j1y+QaHifh2Hlpax6Bv0Zyy7F+do81l7rciFPN1wXD+Z+XLy7OIEkeMMhsl8lGVGVQBKnUPIaEmwxLfKwg85Wm1TU8XYk+duuddxGSDNCJMDo7DFHCZgBxfObI6wK4+swn97zYFlIBCAPREBrexKSokCinXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M/u0fZquSnNwtPsanEJPtymNzod/4b4BaO0spZqhRZo=;
 b=gdta0PNM6pwUsIcVZ2TK0taytAqKllkzSm8wW4zn0M37Vk0VWleNdcCeTHz/imQF+QKLTkBV+YSctwjKrEN/+necGFE7SGXCHrE+rLiDfMo7yStmqJA9IozxE28MQESKlh1p3369ougNnnmMrF8Y8rhNIkDpKvZPYCmeYnRiDso=
Received: from SJ0PR05CA0178.namprd05.prod.outlook.com (2603:10b6:a03:339::33)
 by SN7PR12MB8025.namprd12.prod.outlook.com (2603:10b6:806:340::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.16; Sat, 10 Oct
 2026 02:50:50 +0000
Received: from SJ1PEPF000037AD.namprd03.prod.outlook.com
 (2603:10b6:a03:339:cafe::c) by SJ0PR05CA0178.outlook.office365.com
 (2603:10b6:a03:339::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.6 via Frontend Transport; Sat, 10
 Oct 2026 02:50:50 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000037AD.mail.protection.outlook.com (10.167.244.180) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Sat, 10 Oct 2026 02:50:50 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 9 Oct
 2026 21:50:34 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Pierre-eric.Pelloux-prayer@amd.com>, Prike Liang <Prike.Liang@amd.com>
Subject: [PATCH v4 4/4] drm/amdgpu/userq: report GPU reset in progress
Date: Sat, 10 Oct 2026 10:50:24 +0800
Message-ID: <20261010025024.2453900-4-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261010025024.2453900-1-Prike.Liang@amd.com>
References: <20261010025024.2453900-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037AD:EE_|SN7PR12MB8025:EE_
X-MS-Office365-Filtering-Correlation-Id: 38163822-f407-46b7-2538-08df26794b4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|82310400026|36860700016|1800799024|10067099003|56012099006|6133799003|261009223027099003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 3YDWHtzd/Q5CGg5mhmlh1oNPG5LiSjDGRI+l4eapDK9Uvkl/mYKRuhfZo180CnlptsgEsmII5t9RtTVlqip8XoiKSCrqkL/KkQuQvUTqqLeGKbbtP1RAqjsW75ssq+vG9m/CYU5eXDkKbfT30P29Qenzv1NbUwWf+FkzaozlXrmny28OkGXMuZBywRoUFTBAq+IBf0va4yMEaE5dNR1Z1tjb2c8gYgDRwl86CNMRrzKI/W6wv6TAZHGTzd91xBlIqOB+utpILMAJ96jdfH54hUDSE97syOVTj3a2D9pCsUWlqFrr5xR5t882WPboAIikUUSWGS8bp9fZm/0UQwf6c+xUrUVDvPAfsqGdpSoZy82c3QNDB1Av4jdP0UlzCSc4jo3cZ038qhtZzmrzQwbHPaT3Ig5inGsIdntC1HOhPXnerdEfs/iWd3xTKletR8jqltKArEmV94VTlaknkDHVto0J17V8ZObElAoyDSi0yvKbccwGn0JgYH6KzywkFwf+KYQjJHjy2GCBWBEMPDZ+5GTkSSqnhaJ9l17q9twKAAY1GEW+mf9iYs/ZDRHNAE23dr2YQVhjoTMDn8rTc5f88HAq+TcLh1Sp3oAWbGc1N9drYPSq//w2jz88rjjlDLt6yK4jyKAjYABAGvnRu3wyFUjvnJdm1HMA1afRsAD37UcVbyt6hZzbKmceZI0E+JjgybbjSqOUy74UIKXoxlueug==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(82310400026)(36860700016)(1800799024)(10067099003)(56012099006)(6133799003)(261009223027099003)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 2esckoWEOoM9CdHtN4QrzUnVUQNRyKJYG1AVeMtj90wDxYLZhHuPssGZyOjkWEDyI3N0PJlUsDmqHnhahbQ9JIeLDjnraC+4+0rff0wutPWK4hG3jdziuk8JXZp+PXv5adJSLMI1D5a8JkkokfnHw3xzSLUyRfAd4kmWuqECNAMaK/nWILRsmGpxEFr0jJYDjihXsY9dMaqOFAyTmLRmdkeJhx38e22229oKG1u47h30hUxRUAnfW89OHfyO9n62sT8DfYIIcPbnN7DatnYpTd+2xev5V5fWUZNh0MjOZTdpt3gl2+OhAPld+cg1PGnomqcCEa/jE7rhovKvYcp1eLQYmvf+5Uk63mgTn/fD6XlWzjs3xA8skVrATMBnsMXp7i5fQWzRYBdP/dwoqN4YsJ4eahtO/uhKB+CjF337lDIWUtpSZkmjepYqJXDYGd+P
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2026 02:50:50.4883 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 38163822-f407-46b7-2538-08df26794b4d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000037AD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8025
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

Report an ongoing GPU reset through RESET_IN_PROGRESS at bit 1, alongside
BROKEN at bit 0, so userspace can query whether GPU recovery is ongoing.

Validate query inputs using the same rules as queue deletion and document
the required fields. Drop the queue reference after releasing userq_mutex
because the final put may destroy the queue and acquire that mutex.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 6 +++++-
 include/uapi/drm/amdgpu_drm.h             | 8 +++++---
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 6340e647a67d..6c4743ddf04a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -835,8 +835,11 @@ amdgpu_userq_query_status(struct drm_file *filp, union drm_amdgpu_userq *args)
 	    queue->state == AMDGPU_USERQ_STATE_INVALID_VA ||
 	    queue->generation != amdgpu_vm_generation(adev, &fpriv->vm))
 		args->out_qs.flags |= AMDGPU_USERQ_QUERY_STATUS_FLAGS_BROKEN;
-	amdgpu_userq_put(queue);
+	if (amdgpu_in_reset(adev))
+		args->out_qs.flags |= AMDGPU_USERQ_QUERY_STATUS_FLAGS_RESET_IN_PROGRESS;
 	mutex_unlock(&uq_mgr->userq_mutex);
+	/* The final put may destroy the queue and take userq_mutex. */
+	amdgpu_userq_put(queue);
 
 	return 0;
 }
@@ -898,6 +901,7 @@ static int amdgpu_userq_input_args_validate(struct drm_device *dev,
 		}
 		break;
 	case AMDGPU_USERQ_OP_FREE:
+	case AMDGPU_USERQ_OP_QUERY_STATUS:
 		if (args->in.ip_type ||
 		    args->in.doorbell_handle ||
 		    args->in.doorbell_offset ||
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 98c3fa8a4a72..32ed4c4349a4 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -355,19 +355,21 @@ union drm_amdgpu_ctx {
 
 /* the queue is broken because it is hung, has an invalid VA, or VRAM was lost */
 #define AMDGPU_USERQ_QUERY_STATUS_FLAGS_BROKEN  (1 << 0)
+/* indicate that a GPU reset has not completed yet */
+#define AMDGPU_USERQ_QUERY_STATUS_FLAGS_RESET_IN_PROGRESS (1 << 1)
 
 /*
  * This structure is a container to pass input configuration
  * info for all supported userqueue related operations.
  * For operation AMDGPU_USERQ_OP_CREATE: user is expected
  *  to set all fields, excep the parameter 'queue_id'.
- * For operation AMDGPU_USERQ_OP_FREE: the only input parameter expected
- *  to be set is 'queue_id', eveything else is ignored.
+ * For operations AMDGPU_USERQ_OP_FREE and AMDGPU_USERQ_OP_QUERY_STATUS:
+ *  only 'op' and 'queue_id' should be set; all other fields must be zero.
  */
 struct drm_amdgpu_userq_in {
 	/** AMDGPU_USERQ_OP_* */
 	__u32	op;
-	/** Queue id passed for operation USERQ_OP_FREE */
+	/** Queue id passed for operations USERQ_OP_FREE and USERQ_OP_QUERY_STATUS */
 	__u32	queue_id;
 	/** the target GPU engine to execute workload (AMDGPU_HW_IP_*) */
 	__u32   ip_type;
-- 
2.34.1

