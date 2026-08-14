Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6924C5DF77
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2026 21:03:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05D2E10F6EB;
	Fri, 14 Aug 2026 21:03:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="D/OTHRKU";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012014.outbound.protection.outlook.com [52.101.53.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CBB3410F6E6
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Aug 2026 21:03:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AwgeaNkzm/D6RZPlVVsPoUqwbZ1UZI2icx1ul+IgH22XN9aAC3zXOTG7TENi3F0h5cbkh4nOxf6Oq9MxaFz6LJPx7ryP+DUVOof0biDOKLP9/n3m96nIMQiw/56h0wu85fWLhLizNCkYfU3eocHYLrtB2b3FWyBLp8TG4/41wnr+s8M/HzvRzoU6qQcTx1Cz/aHXEqoamE+Mwgsqqz1Vr6NfbdVu1i7I+hsSGRCNHUQcaHp3X+Ek+4evVzheDkwh/keIzkwFAiY0YsmcGoah0Jy3CHBclyxYHs3JyTQhFMDT+gIIDY3BrQyyvuFQT3OoMNjSMnGePeDaYpN+31FNtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/9DyPoChmPolzlrG5ay2px1XWzMb2yG2c21gSGABIjc=;
 b=XlFsJLh2u5JjD04mp4zEE3dzxt15neQgLtU0NUkzpCG4DTOnzqDiT8CSjVBB5lEBCnC4dCNEygtL4bKw2jHy1ulyID/jYj1S4oN2r6C/RUeOqZZrLQpefBZS0sYF63S8fI8TzydTojuQonuFGraCTv+kPRXnTogShgKWQ7w3iDiwY0HhmGXgJ7HrN8Q5/YSMGQ/IUjENlHe4egxlD3J+/863P465tutbA/I5vWAU2o1iTWQv3uyGlop57ZMmQ760y/OG9iMjodc5+vkYIdP1/MfpODCSK/PKnTE/YITqq0GlhX3/9sO05t8kXPyW14YOO68bgEmGxwkyZV5JCj66Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/9DyPoChmPolzlrG5ay2px1XWzMb2yG2c21gSGABIjc=;
 b=D/OTHRKU7cpKcP7et2ZqbSW+6fI1NiH7N2pM7D3qrCsj3HkrEugHTUAskfpYZw0kwKFxlxbZYodv///OyYO7n5DJWhwx88ISyD7PQDVM8RH8QtSBxjNgJyA42atsxKhFH7j3czm+QQESlUuxoKlRRPxeQ+E7NWtepGfOCy47qA0=
Received: from CH2PR10CA0005.namprd10.prod.outlook.com (2603:10b6:610:4c::15)
 by SJ5PPFE4FC9FAB3.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::9a7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.15; Fri, 14 Aug
 2026 21:03:22 +0000
Received: from CH3PEPF00000017.namprd21.prod.outlook.com
 (2603:10b6:610:4c:cafe::55) by CH2PR10CA0005.outlook.office365.com
 (2603:10b6:610:4c::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.14 via Frontend Transport; Fri,
 14 Aug 2026 21:03:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000017.mail.protection.outlook.com (10.167.244.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.0 via Frontend Transport; Fri, 14 Aug 2026 21:03:22 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 16:03:16 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 16:03:14 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 14 Aug 2026 16:03:14 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: YiPeng Chai <YiPeng.Chai@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 028/109] drm/amd/ras: Remove unused function interfaces
Date: Fri, 14 Aug 2026 17:01:25 -0400
Message-ID: <20260814210246.3067612-29-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814210246.3067612-1-alexander.deucher@amd.com>
References: <20260814210246.3067612-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000017:EE_|SJ5PPFE4FC9FAB3:EE_
X-MS-Office365-Filtering-Correlation-Id: ea94607e-54a9-4427-4183-08defa4779a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|36860700016|82310400026|11063799006|56012099006|18002099003|22082099003|10067099003;
X-Microsoft-Antispam-Message-Info: GCGV0Jtw7uC+APrWbU5PIxeHNdtHJdCk1SWbuN5geCuoad+LNSHGvmom1yG4nhEnJZ1WRXk1oNf3lTFPKx8DKPwUgLPOr/ZDIWdiapXA+Z1dHyMTmDPFR+GGekhg86pXXp28lZGj702bfadv0xu+qOi9IX06PTE+mNEnTzGYbQEq8G59HohhuqWHudYj2MhCo0ZNAKs7jXrABDE5PVGD/zTTFhp5lGMhrDDr9mXI1tzSBsUMIUMxAT2BwcvVxknY3RwvJOUXf2LPIt+6nf+kVKuDNb1yhC/rzurd1aNxnQWH3EX/Xbr+cp5FwSj7aWpADfqarnnzMzrViDJVMIVkejgopYl3vF8mVYwX9BxWXQe306cBSV+393qIJT/JYaA3zBHUBsocfgrJxqD3KdkG7I4xf2qO4E7eUqfmSgWcktXudm/i53Win65ruw10JV5wICXmg8ou8ME8t1B2q/dYaePjpNhUD28RJX/ZZFC0M6m1G5sePkJMCuQdltEhfxbDt2t4d7DSwdMrQgyUDhhAOffIQhoy9+UuEcts/jHplRkEb9QITqHDsbhExQXBb1qW7mocAYuf/+08Spm2C2gbvCmNTM+zTkZJWmSKpDl7ApcVCCxGrRY4GFcbuiUruO4k85mABMN+iZPQNFHV1gLd5Wjs9O/lRbXyUvMSYpEt2ro=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(36860700016)(82310400026)(11063799006)(56012099006)(18002099003)(22082099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: LhT7bQCsYeMAwAkOdAi5Wl9ekzpCkPe0Pq4v7j68GKSTKtY5JoqzHK+Xw1N25LjSd0Lh244QkqZttUL/jRCnXTSbc79qhixY7HE69hQcUDGtapaLAi+96q74KDXayZdd6pM79u0rN05bYd54GXmYh6uvmqO/VoTZaeYLbK9YFY3n1pDxzRfSBLKj5THEAqoFLpHH3XaUd3zKY6zUsLpnAWd+Op92LeepZf9cNlEf2N2yJrl2T7JTKZpuclPlNwUbFV2JNr5qeNulMW8J0bOS50tq1xnj1GY4QTwbXYyg8kDdGYIwk2oYAPr6+hMtCWsv+XBmsGHYxICsTNZSJh4XGLSqaikKRIwhBml36DmCFxT4LMF0iFtta9v1rx0ia3DKSSrGvsL19/aQ4WbnyD+83IyUzzeur1ySpcrOu7PqY8uyIRt4/uqptELas2lhbzXE
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 21:03:22.3179 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea94607e-54a9-4427-4183-08defa4779a2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000017.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFE4FC9FAB3
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

From: YiPeng Chai <YiPeng.Chai@amd.com>

Remove unused function interfaces.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c  | 37 -------------------
 .../gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.h  |  2 -
 2 files changed, 39 deletions(-)

diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
index 3b8d61785a897..9f193cf2ab385 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
@@ -613,35 +613,6 @@ uint64_t amdgpu_ras_mgr_gen_ras_event_seqno(struct amdgpu_device *adev,
 	return seq_no;
 }
 
-int amdgpu_ras_mgr_handle_controller_interrupt(struct amdgpu_device *adev, void *data)
-{
-	struct amdgpu_ras_mgr *ras_mgr = amdgpu_ras_mgr_get_context(adev);
-	struct ras_ih_info *ih_info = (struct ras_ih_info *)data;
-	uint64_t seq_no = 0;
-	int ret = 0;
-
-	if (!amdgpu_ras_mgr_is_ready(adev))
-		return -EPERM;
-
-	if (ih_info && (ih_info->block == AMDGPU_RAS_BLOCK__UMC)) {
-		if (ras_core_poison_supported(ras_mgr->ras_core)) {
-			seq_no = amdgpu_ras_mgr_gen_ras_event_seqno(adev, RAS_SEQNO_TYPE_DE);
-			RAS_DEV_INFO(adev,
-				"{%llu} RAS poison is created, no user action is needed.\n",
-				seq_no);
-		}
-
-		ret = amdgpu_ras_process_handle_umc_interrupt(adev, ih_info);
-	} else if (ras_core_poison_supported(ras_mgr->ras_core)) {
-		ret = amdgpu_ras_process_handle_unexpected_interrupt(adev, ih_info);
-	} else {
-		RAS_DEV_WARN(adev,
-			"No RAS interrupt handler for non-UMC block with poison disabled.\n");
-	}
-
-	return ret;
-}
-
 int amdgpu_ras_mgr_dispatch_interrupt(struct amdgpu_device *adev, struct ras_ih_info *ih_info)
 {
 	struct amdgpu_ras_mgr *ras_mgr = amdgpu_ras_mgr_get_context(adev);
@@ -673,14 +644,6 @@ int amdgpu_ras_mgr_dispatch_interrupt(struct amdgpu_device *adev, struct ras_ih_
 	return ret;
 }
 
-int amdgpu_ras_mgr_handle_consumer_interrupt(struct amdgpu_device *adev, void *data)
-{
-	if (!amdgpu_ras_mgr_is_ready(adev))
-		return -EPERM;
-
-	return amdgpu_ras_process_handle_consumption_interrupt(adev, data);
-}
-
 int amdgpu_ras_mgr_update_ras_ecc(struct amdgpu_device *adev)
 {
 	struct amdgpu_ras_mgr *ras_mgr = amdgpu_ras_mgr_get_context(adev);
diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.h b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.h
index b81fd88fca711..056d482644984 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.h
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.h
@@ -66,8 +66,6 @@ struct amdgpu_ras_mgr *amdgpu_ras_mgr_get_context(
 int amdgpu_enable_uniras(struct amdgpu_device *adev, bool enable);
 bool amdgpu_uniras_enabled(struct amdgpu_device *adev);
 int amdgpu_ras_mgr_handle_fatal_interrupt(struct amdgpu_device *adev, void *data);
-int amdgpu_ras_mgr_handle_controller_interrupt(struct amdgpu_device *adev, void *data);
-int amdgpu_ras_mgr_handle_consumer_interrupt(struct amdgpu_device *adev, void *data);
 int amdgpu_ras_mgr_dispatch_interrupt(struct amdgpu_device *adev, struct ras_ih_info *ih_info);
 int amdgpu_ras_mgr_update_ras_ecc(struct amdgpu_device *adev);
 int amdgpu_ras_mgr_reset_gpu(struct amdgpu_device *adev, uint32_t flags);
-- 
2.55.0

