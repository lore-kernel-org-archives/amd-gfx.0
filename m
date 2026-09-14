Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51F56C88E50
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Sep 2026 13:07:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB85710EDBB;
	Mon, 14 Sep 2026 13:07:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QwMoHcjI";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010018.outbound.protection.outlook.com [52.101.46.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4921910EDBB
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Sep 2026 13:07:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oioYxkZ8rDLBfwfq7iQf6DKyo8IRHd1vuMGTTRN+Y7uar3AXMoXM0p3i9jUZ0h0KQa7+0y+WVWBhiItXF8Iae3NAfZ7mvaJAZ0eTQ4VVdRbCleX8RpkpbwfB6+dUTZuyPuYw5OPuL0bEtav9LxkG/8ZTmzoZPW61Zzvt7lpbODaGhKWMClJ8DWCc3FYLrnIm56alTu0FsVt3PGPGxFH5JMue4F0Jh5206iz0wE7d/oRlL18H1NYs5FXFn3qlicTEOfbT0eiS43aq/Y2I11kp9/570htRYWD/VYF1/CoOa7bKQYFwNGOCsoCwC+Wocz51JBNI+gDq6AmMwTad05GgUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VN4p3v7xzGQ9qbwtIuK6TxNT3W69vYsrjaS7+CTNgGY=;
 b=ub0xVYO+h3Gf0wSpmU/ZHzeqS3/+ESjGNFYD7bEiueNEW0UfxcCh/FpND5qEThfT7je9DrNWgEbDOOFIxApjTO2DCJysMnNEiEK6f3ZN37WZai/kVDN6oCh2mlbgf4hcXMiZixm1SkNmf/c4Yj2CStAcDwWkmOApOtIcpOoYFrHturrtFdHCvjh+HL7MjEsZ8JGxNBHG1uKkqkmTvqTA3MeQLHjM74WwtchZ50n8fammtauPuP+ZYqOnqLruLuctJxtIt0BSBHORPVVgxQfqJTma07W9FpfdAelgd3x5LGCONnLcxQXJK/FYU+H3/P1Of7RgCabiWA1RmyrEg/rczg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VN4p3v7xzGQ9qbwtIuK6TxNT3W69vYsrjaS7+CTNgGY=;
 b=QwMoHcjIobiEjYe96b7kz9snr2umfZoHn7Cxa6bRJa9dZSq6fiPlIQ1pxnF+mpM/G3xrdsoma0igyKDbSnxPEb7LRmXvMIlA11X8FYyx0e97EG2rliZ/MIPPXVlZ+7Dr9L9zNCEukUaT6smAxJjw+VSjYld258e4KFGcHUz/GWg=
Received: from BLAPR03CA0092.namprd03.prod.outlook.com (2603:10b6:208:32a::7)
 by DM4PR12MB6469.namprd12.prod.outlook.com (2603:10b6:8:b6::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.12; Mon, 14 Sep 2026 13:07:12 +0000
Received: from BN1PEPF0000467F.namprd03.prod.outlook.com
 (2603:10b6:208:32a:cafe::34) by BLAPR03CA0092.outlook.office365.com
 (2603:10b6:208:32a::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.12 via Frontend Transport; Mon,
 14 Sep 2026 13:07:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF0000467F.mail.protection.outlook.com (10.167.243.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Mon, 14 Sep 2026 13:07:11 +0000
Received: from ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 14 Sep
 2026 08:07:09 -0500
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <Alexander.Deucher@amd.com>, <felix.kuehling@amd.com>
CC: <Ray.Huang@amd.com>, <amd-gfx@lists.freedesktop.org>, Zhu Lingshan
 <lingshan.zhu@amd.com>
Subject: [PATCH RESEND 05/10] drm/amdgpu: implement asynchronous userq
 destruction routine
Date: Mon, 14 Sep 2026 21:07:19 +0800
Message-ID: <20260914130724.130794-6-lingshan.zhu@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260914130724.130794-1-lingshan.zhu@amd.com>
References: <20260914130724.130794-1-lingshan.zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000467F:EE_|DM4PR12MB6469:EE_
X-MS-Office365-Filtering-Correlation-Id: 76863957-3b0b-4e20-f354-08df12611710
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|23010399003|1800799024|82310400026|11063799006|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: yQlxd67uccPwySHf6+fR40lSSJMwU6R+L0G1uGRFYDxiyoxRihXL1RtoPKOd2otkkq9Evt3lgZZhWaa1G4tbuhtKhhwkUAAsrA38T+/ZlzFkdg6f6HWIQVRxkAewNyUf93LunvR7F748oJr2+jLsNrBD/bBv1Nh92v+HEddrSNvVoaCyRBvR3NUnxYckh19c1XPDpBCGmYKQuaRZGZ/khJS3n/CbG91nPmn7nLux1YyRyU6hMacZpvN+frOL4fPTnKkIGHM6w+lAizFNCxC4fZFXxKCxf/M+fzmFUSW97yCVBwgpEjV+mTrLN8NRHy9wZIRBaMOmOfJu1/6cvjr0hPsXCxlhcZ2aGl4Y54rl6dLM87dloNiIn+upKkgH2ZSwI3Vx2VnIvKdaU5hsExzHA6orbFqaKY4WzlJjQCFVWID93hWEA/qsoadPt8Oh9XwDai7jz33Zs9iGpbGPqcrRqug598e2qeBg6/jRHD7o6uE8InUPzKNq5LNNhHeO2hZv9lEDDSD4NPxs+LbIUWwIBUd/IVoagHyYmnYJw0/JTFTB2bhQb7SmqAOpYyDos4zFkgK+bnr6qiN8XnVKRzYqOUl9w13EbfoZ+EH8Lpnd16S6GKzmBA6WohJ9Gk+Y34TCMt4GGESZ7/lq70pwKO8DvySn5ltdhe+qPkastjOCbueaIdmmXSuFENA1ANYWqCW51/HPBBZ3SNmFWk3frkc7AA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(23010399003)(1800799024)(82310400026)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: hZsL+1Dp/FYoGcvpj7XuIpJ1qEqN5IbP/64eRGDB53GFBG9GF33yT3LlvJ6OHHKcAN3di3Lt0hbXkgoasE921YleT1UupAGXeKK4pjntv8XvZVYrijlx4RXTRlOBWFHhgmptwURnTQiOtPpAzl9Z12Nji4i2NBKDbYLmgux7wMSELVIk+tfYNiYQU6FjoVPhpwx7OE/X0VitaqJnJASen7/lR5fPpEb/m2xqcB/ORXL/qF5NoLVuejqj5RhWRWM8q82jd9aT7DUX280+8sJh6cHAmD+k5/7omY8RMqk7ex04pxVDi+rL+urfXt5oyr1JxVKY36bWyCxWalYjrMiIS6LUx+mIpowOCsFZjp8E9kC0/c99b/FvHn1rlay7fIooWunLgJHV2da5yFE3L7R8aNm11aIAp6GhC4uJdOX30YbC+Tb4pINABeeNh8sxrEPN
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 13:07:11.7583 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 76863957-3b0b-4e20-f354-08df12611710
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000467F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6469
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

The last kref of a user queue may be released
from a context where can not sleep or
require an alrady hold lock(reset_domain->sem, reset_mutext, etc)
in the same context.

This commit helps resovle these issues by refactoring
the user queue destruction function to a deferred
work item, so it does not conflict with the caller context.

Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 15 ++++++++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h |  7 +++++++
 2 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index f398986a61a5..9fe20cb9af58 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -596,11 +596,11 @@ amdgpu_userq_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_que
 	return r;
 }
 
-static void amdgpu_userq_kref_destroy(struct kref *kref)
+static void amdgpu_userq_destroy_worker(struct work_struct *work)
 {
 	int r;
 	struct amdgpu_usermode_queue *queue =
-		container_of(kref, struct amdgpu_usermode_queue, refcount);
+		container_of(work, struct amdgpu_usermode_queue, destroy_work);
 	struct amdgpu_userq_mgr *uq_mgr = queue->userq_mgr;
 
 	r = amdgpu_userq_destroy(uq_mgr, queue);
@@ -610,6 +610,14 @@ static void amdgpu_userq_kref_destroy(struct kref *kref)
 	amdgpu_userq_mgr_dec_refs(uq_mgr);
 }
 
+static void amdgpu_userq_kref_release(struct kref *kref)
+{
+	struct amdgpu_usermode_queue *queue =
+		container_of(kref, struct amdgpu_usermode_queue, refcount);
+
+	WARN_ON_ONCE(!queue_work(system_unbound_wq, &queue->destroy_work));
+}
+
 struct amdgpu_usermode_queue *amdgpu_userq_get(struct amdgpu_userq_mgr *uq_mgr, u32 qid)
 {
 	struct amdgpu_usermode_queue *queue;
@@ -656,7 +664,7 @@ amdgpu_lookup_queue_by_doorbell(struct xarray *xa, u32 doorbell)
 void amdgpu_userq_put(struct amdgpu_usermode_queue *queue)
 {
 	if (queue)
-		kref_put(&queue->refcount, amdgpu_userq_kref_destroy);
+		kref_put(&queue->refcount, amdgpu_userq_kref_release);
 }
 
 static int amdgpu_userq_priority_permit(struct drm_file *filp,
@@ -724,6 +732,7 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	amdgpu_userq_mgr_inc_refs(uq_mgr);
 	INIT_DELAYED_WORK(&queue->hang_detect_work,
 			  amdgpu_userq_hang_detect_work);
+	INIT_WORK(&queue->destroy_work, amdgpu_userq_destroy_worker);
 
 	r = amdgpu_userq_fence_driver_alloc(adev, &queue->fence_drv);
 	if (r)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index a13d8d4dd5c7..ecc450be7eb2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -87,6 +87,13 @@ struct amdgpu_usermode_queue {
 	 * Delayed work which runs when userq_fences time out.
 	 */
 	struct delayed_work	hang_detect_work;
+
+	/**
+	 * @destroy_work:
+	 *
+	 * Work struct used to destroy the queue when kref == 0
+	 */
+	struct work_struct	destroy_work;
 	struct kref		refcount;
 
 	union {
-- 
2.53.0

