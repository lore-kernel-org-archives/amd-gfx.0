Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D319FEB64D8
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Jun 2023 14:13:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6777210E568;
	Thu, 22 Jun 2023 14:13:03 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2073.outbound.protection.outlook.com [40.107.96.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 646F910E568
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Jun 2023 14:13:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yk5JmRTv38QAiHhJKRiuyfKU4s/0+1WhB/2aTaH+TejW2bpfZWc9sLtNYVdwXGFLRq9I52ZjHPsiRir3ybc/V/+mYYXlc1M1KW1h/bzafJCleMDYjJ955TYDwUfX46va68CjBhX2OQE4Ez1vR7ikmi7UB4OY4+NCGbJRw1/ZSAcdJUgBb2sgeND41kvjozBnL5HLeiyDHe3UaoFVJLzQEa6eWDatSCkC6YShv+9aoXv7RbhIhUHkIef/TkVF+Rq4L7RbhIt9mE03t+rbfBw255XUMiLkmvwGMPu59THMBEdePoSl0DetFKcI1NLMDIswHQl14cN+xG6UhJNTePo9Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fu22i1mfx10N9mzlC8/5m3lJE6ndl7B1fsk0O2Q8AE4=;
 b=fr1+bmiBVBNCc3nBMMBDM2pGMp2Pdhf9D1lSAfSYYRexVpsG6JDqK9WGXYy+zeSqB72rtkWpoxiXO1qg3+fbGNONd1b+knXH4seksCb99cshWZpOYQud0ef6yBDo9Zc9rTLg/Ffj8OdspVIFEOFqCqyeyhZZriwA5lcAr6siSkwscRCUi0RY+2Bi5XciP3nzJO6u5SJz7ptJKETVb4BcxR12spfQRlRAsOrLMr41cb4rWl9c7GUUpIqOsh+hqNigh/IerIL6c5d7TcjVdFV/YBy6KUJnTSQ6xp5HQpOb6+Kf7BvLZJkNNH3pulI2/EknwKYkpiOHKHMruLuB8ZpZ6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fu22i1mfx10N9mzlC8/5m3lJE6ndl7B1fsk0O2Q8AE4=;
 b=hWcSI2G2tAw+TRn+IKRrL9TS6Jsd/9zlYNcMnh67brpDr2xIDRimeN81ByGvcNuPgjUkXLLep2N+fhF82UsHCuViAnwvhnLN/SNWhKau3bH9aHpFHpUK3q1dJ8e3Q+ANKt2FI9Ncuf8r1HtgjdN2L5tvgX1deRWThQZCydjs+gQ=
Received: from BN1PR13CA0018.namprd13.prod.outlook.com (2603:10b6:408:e2::23)
 by SJ1PR12MB6052.namprd12.prod.outlook.com (2603:10b6:a03:489::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Thu, 22 Jun
 2023 14:12:55 +0000
Received: from BN8NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e2:cafe::1e) by BN1PR13CA0018.outlook.office365.com
 (2603:10b6:408:e2::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.9 via Frontend
 Transport; Thu, 22 Jun 2023 14:12:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT046.mail.protection.outlook.com (10.13.177.127) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.41 via Frontend Transport; Thu, 22 Jun 2023 14:12:55 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 22 Jun
 2023 09:12:53 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Aurabindo Pillai <aurabindo.pillai@amd.com>, Rodrigo Siqueira
 <Rodrigo.Siqueira@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amd/display: Clean up style problems in amdgpu_dm_irq.c
Date: Thu, 22 Jun 2023 19:42:39 +0530
Message-ID: <20230622141239.1096287-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT046:EE_|SJ1PR12MB6052:EE_
X-MS-Office365-Filtering-Correlation-Id: ceee2dd1-0e75-4813-6423-08db732ac63e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: de+C/4atHzwrMfmLuZRfmrzhidYiHW3D9LVRywrZmBQgwH9D+8pK4H9XIblqSnGrtP8BJTdy1CjiKmKdATbm6/ywAhGBtPl7MS3KDjR67EiXgw1VIKcsIBopybqlPaDbQkV+5M/5WYk42tzfWRc7MVuNvCdkbZJo8AU54ZiPBf3/rL7IUQ0JR3JBAtraa5P3PHggmyLVyGedEy0DTFO6DucEQc0cBH+dCMBXO4MVITEQ+Cvj0xKL/Go/E9EXQOST8DBzYiTMYrvVl7tk1WeDnHWZePJgRbYk39vCN/THmjMydMSqwiT8DF5jf95a0KHqUzWd7SD4y0ctC/kHSD0irYaGBA6RUuledXQkrsotYxvnrEzqUoLTpD+XNsuK/yj3cmS2Hbc8pyU7dZYJhynGIY+0w0jeVBgky2oFfxf9q/17+775CARCQa/NXaBlr+mZ7y0dIDZ8o26xJ/zbuAlnzdDnziDxXmPzzNcYLoCme/5z01LfU8hxpYgOMohrxSPfoT/fw+XoDHoA+You8YtVFeeArXWzXP6mXqiiPvx/yN4SvrpCNsGhupHa+ih60LA2tA6FjySc39znx/6nsZJ+UtuIrnvPyhQ507s3afz6WfiZsoEKFY8p/cl0ETLSnHNmDQi5bNB3HZ2W3y8NAmRBEwerrrEA4lJGPzGwukv1zK7WieYEQxaOWhQKTnVXzLAh3JZs0wr/WbmgnHv2rNMinNFMheICKMQmmG/fWLHp22DjB5eZAJy/4o3VC7g8vfl30kRZ8pFqRcoXcaZPYDpf0w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(39860400002)(136003)(376002)(396003)(451199021)(36840700001)(40470700004)(46966006)(82310400005)(16526019)(8676002)(8936002)(6666004)(316002)(7696005)(40460700003)(40480700001)(36756003)(186003)(26005)(1076003)(41300700001)(81166007)(478600001)(336012)(426003)(356005)(83380400001)(82740400003)(70586007)(70206006)(6636002)(4326008)(54906003)(110136005)(44832011)(47076005)(2906002)(36860700001)(2616005)(5660300002)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 14:12:55.2355 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ceee2dd1-0e75-4813-6423-08db732ac63e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6052
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
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fix the following warnings reported by checkpatch:

WARNING: Block comments use a trailing */ on a separate line
WARNING: Comparisons should place the constant on the right side of the test
WARNING: space prohibited between function name and open parenthesis '('
WARNING: Prefer 'unsigned int' to bare use of 'unsigned'

Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c | 42 +++++++++++--------
 1 file changed, 24 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
index 19f543ba7205..51467f132c26 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
@@ -120,7 +120,8 @@ static void dm_irq_work_func(struct work_struct *work)
 
 	/* Call a DAL subcomponent which registered for interrupt notification
 	 * at INTERRUPT_LOW_IRQ_CONTEXT.
-	 * (The most common use is HPD interrupt) */
+	 * (The most common use is HPD interrupt)
+	 */
 }
 
 /*
@@ -172,7 +173,8 @@ static struct list_head *remove_irq_handler(struct amdgpu_device *adev,
 
 	if (handler_removed == false) {
 		/* Not necessarily an error - caller may not
-		 * know the context. */
+		 * know the context.
+		 */
 		return NULL;
 	}
 
@@ -261,7 +263,7 @@ validate_irq_registration_params(struct dc_interrupt_params *int_params,
 static bool validate_irq_unregistration_params(enum dc_irq_source irq_source,
 					       irq_handler_idx handler_idx)
 {
-	if (DAL_INVALID_IRQ_HANDLER_IDX == handler_idx) {
+	if (handler_idx == DAL_INVALID_IRQ_HANDLER_IDX) {
 		DRM_ERROR("DM_IRQ: invalid handler_idx==NULL!\n");
 		return false;
 	}
@@ -343,7 +345,8 @@ void *amdgpu_dm_irq_register_interrupt(struct amdgpu_device *adev,
 	/* This pointer will be stored by code which requested interrupt
 	 * registration.
 	 * The same pointer will be needed in order to unregister the
-	 * interrupt. */
+	 * interrupt.
+	 */
 
 	DRM_DEBUG_KMS(
 		"DM_IRQ: added irq handler: %p for: dal_src=%d, irq context=%d\n",
@@ -390,7 +393,8 @@ void amdgpu_dm_irq_unregister_interrupt(struct amdgpu_device *adev,
 
 	if (handler_list == NULL) {
 		/* If we got here, it means we searched all irq contexts
-		 * for this irq source, but the handler was not found. */
+		 * for this irq source, but the handler was not found.
+		 */
 		DRM_ERROR(
 		"DM_IRQ: failed to find irq handler:%p for irq_source:%d!\n",
 			ih, irq_source);
@@ -450,7 +454,8 @@ void amdgpu_dm_irq_fini(struct amdgpu_device *adev)
 		DM_IRQ_TABLE_LOCK(adev, irq_table_flags);
 		/* The handler was removed from the table,
 		 * it means it is safe to flush all the 'work'
-		 * (because no code can schedule a new one). */
+		 * (because no code can schedule a new one).
+		 */
 		lh = &adev->dm.irq_handler_list_low_tab[src];
 		DM_IRQ_TABLE_UNLOCK(adev, irq_table_flags);
 
@@ -494,7 +499,7 @@ int amdgpu_dm_irq_suspend(struct amdgpu_device *adev)
 		DM_IRQ_TABLE_UNLOCK(adev, irq_table_flags);
 
 		if (!list_empty(hnd_list_l)) {
-			list_for_each_safe (entry, tmp, hnd_list_l) {
+			list_for_each_safe(entry, tmp, hnd_list_l) {
 				handler = list_entry(
 					entry,
 					struct amdgpu_dm_irq_handler_data,
@@ -571,7 +576,7 @@ static void amdgpu_dm_irq_schedule_work(struct amdgpu_device *adev,
 	if (list_empty(handler_list))
 		return;
 
-	list_for_each_entry (handler_data, handler_list, list) {
+	list_for_each_entry(handler_data, handler_list, list) {
 		if (queue_work(system_highpri_wq, &handler_data->work)) {
 			work_queued = true;
 			break;
@@ -627,7 +632,8 @@ static void amdgpu_dm_irq_immediate_work(struct amdgpu_device *adev,
 			    &adev->dm.irq_handler_list_high_tab[irq_source],
 			    list) {
 		/* Call a subcomponent which registered for immediate
-		 * interrupt notification */
+		 * interrupt notification
+		 */
 		handler_data->handler(handler_data->handler_arg);
 	}
 
@@ -664,7 +670,7 @@ static int amdgpu_dm_irq_handler(struct amdgpu_device *adev,
 	return 0;
 }
 
-static enum dc_irq_source amdgpu_dm_hpd_to_dal_irq_source(unsigned type)
+static enum dc_irq_source amdgpu_dm_hpd_to_dal_irq_source(unsigned int type)
 {
 	switch (type) {
 	case AMDGPU_HPD_1:
@@ -686,7 +692,7 @@ static enum dc_irq_source amdgpu_dm_hpd_to_dal_irq_source(unsigned type)
 
 static int amdgpu_dm_set_hpd_irq_state(struct amdgpu_device *adev,
 				       struct amdgpu_irq_src *source,
-				       unsigned type,
+				       unsigned int type,
 				       enum amdgpu_interrupt_state state)
 {
 	enum dc_irq_source src = amdgpu_dm_hpd_to_dal_irq_source(type);
@@ -698,7 +704,7 @@ static int amdgpu_dm_set_hpd_irq_state(struct amdgpu_device *adev,
 
 static inline int dm_irq_state(struct amdgpu_device *adev,
 			       struct amdgpu_irq_src *source,
-			       unsigned crtc_id,
+			       unsigned int crtc_id,
 			       enum amdgpu_interrupt_state state,
 			       const enum irq_type dal_irq_type,
 			       const char *func)
@@ -729,7 +735,7 @@ static inline int dm_irq_state(struct amdgpu_device *adev,
 
 static int amdgpu_dm_set_pflip_irq_state(struct amdgpu_device *adev,
 					 struct amdgpu_irq_src *source,
-					 unsigned crtc_id,
+					 unsigned int crtc_id,
 					 enum amdgpu_interrupt_state state)
 {
 	return dm_irq_state(
@@ -743,7 +749,7 @@ static int amdgpu_dm_set_pflip_irq_state(struct amdgpu_device *adev,
 
 static int amdgpu_dm_set_crtc_irq_state(struct amdgpu_device *adev,
 					struct amdgpu_irq_src *source,
-					unsigned crtc_id,
+					unsigned int crtc_id,
 					enum amdgpu_interrupt_state state)
 {
 	return dm_irq_state(
@@ -893,13 +899,13 @@ void amdgpu_dm_hpd_init(struct amdgpu_device *adev)
 
 		const struct dc_link *dc_link = amdgpu_dm_connector->dc_link;
 
-		if (DC_IRQ_SOURCE_INVALID != dc_link->irq_source_hpd) {
+		if (dc_link->irq_source_hpd != DC_IRQ_SOURCE_INVALID) {
 			dc_interrupt_set(adev->dm.dc,
 					dc_link->irq_source_hpd,
 					true);
 		}
 
-		if (DC_IRQ_SOURCE_INVALID != dc_link->irq_source_hpd_rx) {
+		if (dc_link->irq_source_hpd_rx != DC_IRQ_SOURCE_INVALID) {
 			dc_interrupt_set(adev->dm.dc,
 					dc_link->irq_source_hpd_rx,
 					true);
@@ -928,13 +934,13 @@ void amdgpu_dm_hpd_fini(struct amdgpu_device *adev)
 				to_amdgpu_dm_connector(connector);
 		const struct dc_link *dc_link = amdgpu_dm_connector->dc_link;
 
-		if (DC_IRQ_SOURCE_INVALID != dc_link->irq_source_hpd) {
+		if (dc_link->irq_source_hpd != DC_IRQ_SOURCE_INVALID) {
 			dc_interrupt_set(adev->dm.dc,
 					dc_link->irq_source_hpd,
 					false);
 		}
 
-		if (DC_IRQ_SOURCE_INVALID != dc_link->irq_source_hpd_rx) {
+		if (dc_link->irq_source_hpd_rx != DC_IRQ_SOURCE_INVALID) {
 			dc_interrupt_set(adev->dm.dc,
 					dc_link->irq_source_hpd_rx,
 					false);
-- 
2.25.1

