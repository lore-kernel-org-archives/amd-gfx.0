Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6D99C77B7F
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Jun 2025 09:52:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5212310E350;
	Mon, 23 Jun 2025 09:52:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EZIx/X58";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2050.outbound.protection.outlook.com [40.107.236.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5EEB710E350
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Jun 2025 09:52:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TloB/VGCNS544fk+dwieNET3ecDxhMd6J9AV6bsLu5UN/OassDqmvLWZvk8rvi8C05sJO/I+uUnVjT5tkOeb9NTSOdAYcnoMWPRXFBqv9r7ddzIwl+PgCpGSTUqkywcs8y+6OEUr3CJPLOjKt2laRsX01cBVbAmKts6JMAuBLDaPM13YOHrln8Zvyiw+x7pTYPMILCjpHmxGqR3p7EudhO2h+ftxH84/EzQjbmkIQZDmZDE9so2iTVVb5hjCWNOXEAeCGZKg5S84mufQChBopab0d4pMdOUCSwNRfMoaNEcFC8OyBgUs7jriiHOzb6FpCZuCFEEx7pbIy/C75rZmYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=piRDEbOnYxgoGHlvtis5VVVqD2DLr7jJQd3FYXvnra0=;
 b=HOiA5r0M/OIPs6wAbZkculv6aWR8K5AxmM/CL993yZLy7/bAnSXc0aKpX34G/b0R6yR4eE7TB4znPmatN0IEm+Ph9CF+cxDCH9GM0ZGdOCrH8LxywvW6wCrwyyDEVA/9i6u+0qsX9ADxs/0UTmBQCOuyVwVSfk7VOXDmrDh2yL7XuVvCNlqUX/wsOzY02/yWo4xFQDQFacRUJC/Rzl0u/agkkTI0CIcgKyOcM10wm79QDuuExIfpn9q8g+NcH/46O3fxSgPlJY7i+zNXElP9Pb1rPmbCyARQipOz+hxcnFA+zhEb7hqUhNKw+54YBrn6SGNzyzWCsToFfS8bWqgXlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=piRDEbOnYxgoGHlvtis5VVVqD2DLr7jJQd3FYXvnra0=;
 b=EZIx/X58yZpWjTBaGPoZF1/owCME1mD9Fa1EmbC8lAzFbei/fWvnfkx7lB6KlyCRyqMIyydQ9Qcb+Gx1lkaFSONHtqb6ehbLGmXTnLCluu1qLuExdh5VXBr5uNMPL/OFJ2x0vlw25Tcu/LWEKDo8TJ//5iT1RO/EU4DlOoaIo7s=
Received: from DM6PR02CA0058.namprd02.prod.outlook.com (2603:10b6:5:177::35)
 by IA0PR12MB8350.namprd12.prod.outlook.com (2603:10b6:208:40d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Mon, 23 Jun
 2025 09:52:17 +0000
Received: from DS1PEPF00017095.namprd03.prod.outlook.com
 (2603:10b6:5:177:cafe::8d) by DM6PR02CA0058.outlook.office365.com
 (2603:10b6:5:177::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8857.30 via Frontend Transport; Mon,
 23 Jun 2025 09:52:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017095.mail.protection.outlook.com (10.167.17.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Mon, 23 Jun 2025 09:52:17 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 23 Jun
 2025 04:52:15 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH v3 08/11] drm/amdgpu: add userq va unmap validated helper
Date: Mon, 23 Jun 2025 17:51:51 +0800
Message-ID: <20250623095154.1150830-8-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250623095154.1150830-1-Prike.Liang@amd.com>
References: <20250623095154.1150830-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017095:EE_|IA0PR12MB8350:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b176e6d-7f2e-475a-09a6-08ddb23ba3db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?c0f6uhBXuhy0PFYJWB5fobg+rzZjbV1a783UOS/XL8ttUfz6EK2RfGBp+Mey?=
 =?us-ascii?Q?fhSF2Lh+M28Jf9CREFV2fymzzme9R5XTE9Lz1uwfa7so4RJq4z3197o9pQTR?=
 =?us-ascii?Q?94dChyK3z0ugQUs6AMuhabYvpRcrbVFA4DLSQtf7e26Cb1pcSW9H4YrC79H4?=
 =?us-ascii?Q?DJDXxY98MDqq49vet3881kPtR+mlaLEqmeeC8uy/ttLibrvtgW6QMeckkSTO?=
 =?us-ascii?Q?+XiClvuVaJn8iLP3QIyimYoAUA6jQMC4NsdidhBgg39T1b481h8807jZn+l6?=
 =?us-ascii?Q?nhXsxQSF0A/xVldYMHLmpwP30t60UiYdaC0cdZOvAJReKl06JD2GP43WGFXt?=
 =?us-ascii?Q?jU4ntYRtdT9IojKlFBBjI7PEeZsjEoXVdymPN1cG1Y3sGqBPNdZ8nhMNifqs?=
 =?us-ascii?Q?n2uEGsHueAN0wqI/JKcGeR72KFaIHu2Cu2T7Cv34crRQna7ay+NSvzWaSaBC?=
 =?us-ascii?Q?0DGORyS8un2/cOo3fHsszqEf3QNXaEx909r7r9+puNRY3zlJL2s1ECl0d0uC?=
 =?us-ascii?Q?eSD2iha8MDFfLbPqNHHjm0H6PD5C/YcZpww5f5gSlFzSm2EkPtw0XU6081lE?=
 =?us-ascii?Q?GaSMvtwLDLgnuoASIi5Ng/ddFRg9cb6SMC7g9olbd0SZ2vrO8kmhu6+2GsOn?=
 =?us-ascii?Q?Lev79+9pzA3On76dV/qgVE1TEy1IgbSi7Fw57NVpLRvROPaiJu2PkqIQrC8O?=
 =?us-ascii?Q?9A97vZYUw3KVCVzwTwqYzYtCye/AfFkomPXkUjj2Q9JRA7wYBTX0HMPsG6fV?=
 =?us-ascii?Q?193Fl9fexJrRAKUe7fIlXpozoGU0JV2SXFcC+++HumZ4ApaZZSbiUP7uNJpJ?=
 =?us-ascii?Q?Ab4y+B9uqPVghBY37HGy4xcWa+B9/lK77izm1P6iCQZJeeq5llliaUaIIjVD?=
 =?us-ascii?Q?vDw6P32OvZGqaQq8rsXew27eU81R2ALM/74XjeTzcQjfJgkaQRA1LPZUF50l?=
 =?us-ascii?Q?ypH9lwRHXw4k2W328QzJi6f+XcFRQG54bCvUmiDaFiOB52WzSIMNP823G84e?=
 =?us-ascii?Q?bBLF+ulioLLy7ECQfUnEtKoHgAtMlZp7VnXzNWsfJiu/iTQYCvGQVrd/glqy?=
 =?us-ascii?Q?FVu0/+XxwW6XbqNZe7YUnv83IhUNy/CrJPuu4ry0WEnQ+R+f73cn+OTSjTW+?=
 =?us-ascii?Q?XSRZ7qSYsxNtC9Z5qTX1WqejcAEff8iPwwqbWfMCOAKyHz8C82laK/WUmLZR?=
 =?us-ascii?Q?dH47wNWQs1pU6jNn7PeEIwSmDNbDbuvKmB1OugMWa9u3z+BcWYsbgPjtROkr?=
 =?us-ascii?Q?xKgDbnis4j0VDU/HHY5C0faLKyahdFNGU3lHlNIuVgUWkf4LKqQAJ9sXsVpr?=
 =?us-ascii?Q?7WDl6sGUAmQ57sq9suXvjNm1tndQzZplqlG4u0TUSB0u91g5SVu/AVhQegca?=
 =?us-ascii?Q?98Z2UhqocnJDdDSufMOcXmf1zo/VvzLKzQZTrcDBaDMN7sR46R3KOH0ppwtN?=
 =?us-ascii?Q?A/QmKUysTPy/q87g6yLCkQWsJ7SoMpx0gDtslT620CPkcCrQiC3xAPORXWXE?=
 =?us-ascii?Q?Z9mPCDYyP//AiUkFgtgDAML3js0RkAyrOfZE?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 09:52:17.7523 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b176e6d-7f2e-475a-09a6-08ddb23ba3db
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017095.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8350
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

This helper can validate the userq whether can be
unmapped prior to the userq VA GEM unmap.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 57 +++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h |  3 ++
 2 files changed, 60 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 0208c6b8a8e0..534a9c98c011 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -1150,3 +1150,60 @@ int amdgpu_userq_start_sched_for_enforce_isolation(struct amdgpu_device *adev,
 	mutex_unlock(&adev->userq_mutex);
 	return ret;
 }
+
+static bool amdgpu_userq_gem_va_unmap_queue_retrieve(struct amdgpu_usermode_queue *queue,
+							uint64_t va)
+{
+	if (amdgpu_userq_va_align(queue->queue_va) != va &&
+	    amdgpu_userq_va_align(queue->wptr_va) != va &&
+	    amdgpu_userq_va_align(queue->rptr_va) != va &&
+	    amdgpu_userq_va_align(queue->eop_va) != va &&
+	    amdgpu_userq_va_align(queue->shadow_va) != va &&
+	    amdgpu_userq_va_align(queue->csa_va) != va)
+		return false;
+
+	return true;
+}
+
+int amdgpu_userq_gem_va_unmap_validate(struct amdgpu_vm *vm,
+				uint64_t va)
+{
+	struct amdgpu_fpriv *fpriv = vm_to_fpriv(vm);
+	struct amdgpu_userq_mgr *uq_mgr = &fpriv->userq_mgr;
+
+	if (vm->is_userq_context && &fpriv->vm == vm) {
+		struct amdgpu_usermode_queue *queue;
+		int queue_id, r = 0;
+
+		if (mutex_trylock(&uq_mgr->userq_mutex)) {
+			/* If here the userq bo is busy and needs to deactivate and prevent reusing it.*/
+			idr_for_each_entry(&uq_mgr->userq_idr, queue, queue_id) {
+				struct dma_fence *f = queue->last_fence;
+
+
+				if (!amdgpu_userq_gem_va_unmap_queue_retrieve(queue, va)) {
+					dev_dbg(uq_mgr->adev->dev, "queue(id:%d) not belond to vm:%p\n",
+						queue_id,vm);
+					continue;
+				}
+
+				if (f && !dma_fence_is_signaled(f)) {
+
+					dev_warn(uq_mgr->adev->dev, "try to unmap the busy queue(id:%d):%p under vm:%p\n",
+						queue_id, queue, vm);
+					/* Need to set a resonable state for avoiding reusing this queue*/
+					queue->state = AMDGPU_USERQ_STATE_HUNG;
+					r++;
+				}
+			}
+			mutex_unlock(&uq_mgr->userq_mutex);
+			return r;
+		} else {
+			/* do we need a try lock again before return*/
+			return -EBUSY;
+		}
+
+	}
+
+	return 0;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index 194ec7a6b3b2..08c49d738ec1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -31,6 +31,7 @@
 #define to_ev_fence(f) container_of(f, struct amdgpu_eviction_fence, base)
 #define uq_mgr_to_fpriv(u) container_of(u, struct amdgpu_fpriv, userq_mgr)
 #define work_to_uq_mgr(w, name) container_of(w, struct amdgpu_userq_mgr, name)
+#define vm_to_fpriv(v)  container_of(v, struct amdgpu_fpriv, vm)
 
 enum amdgpu_userq_state {
 	AMDGPU_USERQ_STATE_UNMAPPED = 0,
@@ -148,4 +149,6 @@ bool amdgpu_userq_buffer_vas_mapped(struct amdgpu_vm *vm,
 int amdgpu_userq_buffer_va_put(struct amdgpu_vm *vm, u64 addr);
 int amdgpu_userq_buffer_vas_put(struct amdgpu_vm *vm,
 			struct amdgpu_usermode_queue *queue);
+int amdgpu_userq_gem_va_unmap_validate(struct amdgpu_vm *vm,
+				uint64_t va);
 #endif
-- 
2.34.1

