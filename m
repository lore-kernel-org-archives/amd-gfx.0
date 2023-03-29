Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4B30C74A5B
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Mar 2023 15:48:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B4B710EB78;
	Wed, 29 Mar 2023 15:48:39 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2055.outbound.protection.outlook.com [40.107.93.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6285110EB72
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Mar 2023 15:48:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P1ydxdp+oQVXSN+Ay5m48YB1Jxw/8WZGjz28c9q5HG+BK1cyHDMpeuACFe4Ei9pD95Uy+ma7w/La9pMfyqCKhFJTiX57mKk8vlHd6/3HdOTaqIlbvd/Tx3mOXlXuG+X8Ls11pOCF+xtTFBcUm6oG4Yvw8LOLgIC34winPxD7eq7gzBPVykhg4g9lr6PJG/6ryBerASV7gFVNcuSvWuM1TrjoXa6deSHwH2dzCIKXmJacGR26Mqw2SUh6yiBHPbhf165xT6HCzwEsOAMyzdWInwqLYZeWUWVEp6yrRHb0PRRpys2+60/X3tCqcqYVj1SZMQxCwNSgCDUDc6dxxR9SPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vd8TCdbZCOVUERq0QESZgg6ijNR/gAOG71A44m5vAlc=;
 b=jvECUi3bJLs+3ijQYddkfqUxBFd7ECoLsY53RpjXHXY9Jrb882geIXWGxjsARpUkOWDKixPMQys7I3QmQXNuEWdQLj9BjMfZ0BZhwHyC2WP1hzALrrhJ2IcyJT7EXUL69lPLJEA+U+gJkV+q8pydTCFIY0Pj3qJQEu81rdem1j4jhDkyYVM/WIXWhcwWQEPOP+Gea1ItcvYfUSUKIxTdWXUCjIlyG/x645mqpHC/GYY5N6asMp5xWAlws0zhNSSE+ckfI/+zCgDzXVwVAts/N5BKWSgFJl5eYHPuuuEcezt6qAxAbJtCArLhbX227JdJzuMSVU9hOaHriYTOpnxgKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vd8TCdbZCOVUERq0QESZgg6ijNR/gAOG71A44m5vAlc=;
 b=WiEpZYxTI628XOAo3RP0xsa7jhZ+a+bu7D4QhqaN7n/8em7DsM/KnuWDXnp5xmJHeKtlEBJEMDMxIicvHYeqS7M1CT3YD5dYPBrO+aUebBg/89U5BnM593X5FBLlmpaH8WwZ2DH/ckG45HQds5Y7fGX3Ec3Vb0AROdJAkwjHOFw=
Received: from DS7PR03CA0094.namprd03.prod.outlook.com (2603:10b6:5:3b7::9) by
 DS0PR12MB7778.namprd12.prod.outlook.com (2603:10b6:8:151::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6222.33; Wed, 29 Mar 2023 15:48:32 +0000
Received: from DM6NAM11FT074.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b7:cafe::48) by DS7PR03CA0094.outlook.office365.com
 (2603:10b6:5:3b7::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20 via Frontend
 Transport; Wed, 29 Mar 2023 15:48:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT074.mail.protection.outlook.com (10.13.173.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6254.21 via Frontend Transport; Wed, 29 Mar 2023 15:48:32 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 29 Mar
 2023 10:48:30 -0500
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 10/16] drm/amdgpu: validate doorbell read/write
Date: Wed, 29 Mar 2023 17:47:47 +0200
Message-ID: <20230329154753.1261-11-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
In-Reply-To: <20230329154753.1261-1-shashank.sharma@amd.com>
References: <20230329154753.1261-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT074:EE_|DS0PR12MB7778:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f36f3de-385b-46dd-0a6e-08db306d0c7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FbiWYf40hes95gWt3Cmll/7SL3J0LvSeY5XxYa2L3s060d4ZnCoGrAUp886fkexpE4Izyy9TsYbliIKvqmN10SBLVihywwo9+d0gQIygdNqLWEvRhoG/9g7WjUSUHwiW6oyLvkELju4PF1jq0e7qLGTaqjBLjTPFVrHZan8TdCYu1ZjL3Z0QdAQwW5XKR94WNHYa2DahCNZ/i8pBccTlq3Ws4ejCfhUO6dhZdX0PJMrw7N4XSpPSln6vpk0hf1GWOv0cOi3mzGLetZHI6W5G7+bpxE3ojqn8q0YEK0Df1PgtELOeheznm79NhN/QF/tPaA+eZy2pyuWpDY08Tw/YvETmLxXneWgp9Vtlly1d3v8hb7t17XuoQ8hyFXAGiJ/7XUKAfcky/ApgHYsHpa5LfLWOR0f+YY0t+E4GkVdgiYUSkePfGbM8sGJli3ssg2cbFFjJnde2ZQu6YYl1gtmYU6Bq6Kr6DI4O/TyPSxtHObLYDhwQyszjmLllk9fKnVrjPhwLeuk8qyyTLV4rXcwlBa9gkM8QArF89oMnXGdLcnux4RKR6kXkEvn16pQjXW2SVhq8bfEguKYdcyr8DHBc+0CA+UVzmLoCSM99xt4ANT8Y8VtT1d/cl10MHrVM0iQNHf/Ek5/mvDXjCt7vNBKZndRjAagD5zwhGO450b1L3fQAf0a6R5UPwhIanmon6HUNLkcrZyBzJ6xtl3fEc9M/a6ytGw+kh+J7AVEU0EVcGsY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(346002)(136003)(396003)(376002)(451199021)(46966006)(40470700004)(36840700001)(8936002)(70206006)(83380400001)(70586007)(356005)(15650500001)(44832011)(5660300002)(54906003)(81166007)(2906002)(6916009)(36860700001)(8676002)(4326008)(41300700001)(426003)(316002)(336012)(478600001)(2616005)(82740400003)(40460700003)(47076005)(7696005)(40480700001)(86362001)(186003)(82310400005)(16526019)(1076003)(26005)(6666004)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 15:48:32.1012 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f36f3de-385b-46dd-0a6e-08db306d0c7a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT074.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7778
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
Cc: Mukul
 Joshi <mukul.joshi@amd.com>, Shashank Sharma <shashank.sharma@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>,
 =?UTF-8?q?=EF=BF=BCArvind=20Yadav?= <arvind.yadav@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Christian Koenig <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch:
- updates start/end values for each of the doorbell object
  created.
- adds a function which validates that the kernel doorbell read/write
  is within this range.
- uses this function during doorbell writes from kernel.

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
Signed-off-by: ￼Arvind Yadav <arvind.yadav@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c  | 29 ++++++++++++++++---
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
index b46fe8b1378d..81713b2c28e1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
@@ -22,6 +22,25 @@
  */
 
 #include "amdgpu.h"
+#include "kfd_priv.h"
+
+static inline
+bool amdgpu_doorbell_valid(struct amdgpu_device *adev, u32 index)
+{
+	if (index >= adev->doorbell.kernel_doorbells.start &&
+	    index < adev->doorbell.kernel_doorbells.end)
+		return true;
+
+	if (index >= adev->mes.kernel_doorbells.start &&
+	    index < adev->mes.kernel_doorbells.end)
+		return true;
+
+	if (index >= adev->kfd.dev->kernel_doorbells.start &&
+	    index < adev->kfd.dev->kernel_doorbells.end)
+		return true;
+
+	return false;
+}
 
 /**
  * amdgpu_mm_rdoorbell - read a doorbell dword
@@ -37,7 +56,7 @@ u32 amdgpu_mm_rdoorbell(struct amdgpu_device *adev, u32 index)
 	if (amdgpu_device_skip_hw_access(adev))
 		return 0;
 
-	if (index < adev->doorbell.num_kernel_doorbells) {
+	if (amdgpu_doorbell_valid(adev, index)) {
 		return readl(adev->doorbell.ptr + index);
 	} else {
 		DRM_ERROR("reading beyond doorbell aperture: 0x%08x!\n", index);
@@ -60,7 +79,7 @@ void amdgpu_mm_wdoorbell(struct amdgpu_device *adev, u32 index, u32 v)
 	if (amdgpu_device_skip_hw_access(adev))
 		return;
 
-	if (index < adev->doorbell.num_kernel_doorbells) {
+	if (amdgpu_doorbell_valid(adev, index)) {
 		writel(v, adev->doorbell.ptr + index);
 	} else {
 		DRM_ERROR("writing beyond doorbell aperture: 0x%08x!\n", index);
@@ -81,7 +100,7 @@ u64 amdgpu_mm_rdoorbell64(struct amdgpu_device *adev, u32 index)
 	if (amdgpu_device_skip_hw_access(adev))
 		return 0;
 
-	if (index < adev->doorbell.num_kernel_doorbells) {
+	if (amdgpu_doorbell_valid(adev, index)) {
 		return atomic64_read((atomic64_t *)(adev->doorbell.ptr + index));
 	} else {
 		DRM_ERROR("reading beyond doorbell aperture: 0x%08x!\n", index);
@@ -104,7 +123,7 @@ void amdgpu_mm_wdoorbell64(struct amdgpu_device *adev, u32 index, u64 v)
 	if (amdgpu_device_skip_hw_access(adev))
 		return;
 
-	if (index < adev->doorbell.num_kernel_doorbells) {
+	if (amdgpu_doorbell_valid(adev, index)) {
 		atomic64_set((atomic64_t *)(adev->doorbell.ptr + index), v);
 	} else {
 		DRM_ERROR("writing beyond doorbell aperture: 0x%08x!\n", index);
@@ -157,6 +176,8 @@ int amdgpu_doorbell_alloc_page(struct amdgpu_device *adev,
 		return r;
 	}
 
+	db_obj->start = amdgpu_doorbell_index_on_bar(adev, db_obj->bo, 0);
+	db_obj->end = db_obj->start + db_obj->size / sizeof(u32);
 	return 0;
 }
 
-- 
2.40.0

