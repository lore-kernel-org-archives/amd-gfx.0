Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62711CDB474
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Oct 2023 09:59:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 97CA210E591;
	Fri, 20 Oct 2023 09:59:42 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20612.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::612])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB21910E0F8
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Oct 2023 09:59:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O8UbEu1O+mMVSKk/U5vauCrEGdaZkX+3sBpqNQxN66fjuiVZdcd9vzdCvMDWSaUrH1iiTMf2T7bH2sByuFmGGDNrOBgSiW3uvrK+A5q9F7DWp1XNnuYWSR2dAylnVDkwA9gCHKQ5EVYfIzNBGCszaBiRvE4wlO4ndCNTe3rfY67GZShN3MztDC4FxRgEon86LMEE5UTpheBoh+VVcNdr4sIoLI5SJ/6drxR/e5EbLcY+tZl9dj4u90emsXiCofbSYo56500ie0nr0Xfwo0RCRGJqrFJa1uAENuvzC85f7ab8vQMtOz1/1MseS7k9U99MSgTBwnmbJkpy9zZfV/m5OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sbrit9Fo9qW3of+BIbYhiRPfbjTImdJatUgMqIwkEpw=;
 b=ZBfCfAs9vjPcQ9j14KURXtQFNwO6slfwWXn+f+vRhu9FDPwSvkS5WWxutymjhxJwxzwK9CrXxEsWFP5nk3X7AH5zLbuLfIG0L6jKo4trtv9pk8XF9mmhjcn3zvjr4xUo95pQV6/qLBVVMiJH5SzEj40iUFbT+Juiss44vbFL8z+NhzGfbIHc0BlLW2YV2joKS/0GvehQMlp2SKOCLviLGh04emXfnUZJLv85GX059wsjhTlzpwIEoUI87B8OMqt7pNSk78yttcLDIZaWcpdoT4cx7/6oXLbZ85bXm58u3XBoU1bnBs7j/Z80ffBr9OsMNZoeNJPItduP/n79bWT6iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sbrit9Fo9qW3of+BIbYhiRPfbjTImdJatUgMqIwkEpw=;
 b=AXIjSA1yZ3+dfQk7ubMG+xttfVm4ier8Sk5m9tSEUdJfZGWYVPKBjvjFdam5SqTOaO4IBlIMfSpyukyQSe80pRmDPnf7d6tyc+Ve0knmvRAektgwZJ1ArT6m+ZgPvQ/hcTiq5qgCe+2c0quqLuZEi0ZVRqBJJubPjY0BOXuuzak=
Received: from DM6PR11CA0005.namprd11.prod.outlook.com (2603:10b6:5:190::18)
 by DS0PR12MB6416.namprd12.prod.outlook.com (2603:10b6:8:cb::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6907.26; Fri, 20 Oct 2023 09:59:33 +0000
Received: from DS1PEPF00017090.namprd03.prod.outlook.com
 (2603:10b6:5:190:cafe::1d) by DM6PR11CA0005.outlook.office365.com
 (2603:10b6:5:190::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.25 via Frontend
 Transport; Fri, 20 Oct 2023 09:59:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS1PEPF00017090.mail.protection.outlook.com (10.167.17.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6907.20 via Frontend Transport; Fri, 20 Oct 2023 09:59:33 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 20 Oct
 2023 04:59:32 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 20 Oct
 2023 04:59:32 -0500
Received: from emily-Z10PA-U8-Series.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27
 via Frontend Transport; Fri, 20 Oct 2023 04:59:31 -0500
From: Emily Deng <Emily.Deng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdgpu: handle the return for sync wait
Date: Fri, 20 Oct 2023 17:59:10 +0800
Message-ID: <20231020095911.591988-1-Emily.Deng@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017090:EE_|DS0PR12MB6416:EE_
X-MS-Office365-Filtering-Correlation-Id: a81fd5ce-9e05-47a4-58ba-08dbd15342bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S8qzwke6pA1IRe+BHEEhDig+WKQh4GqbMSH/HtL+Hn94KeVxjEzcxurBb4f4IFX00XHvyJTAffUxjqwIxPs/mVOvxc66aK2AoqlkCchapQKtSS7SPrSr6OzwLOwKt3JQzeemzr6JTmaP9si4ul4bAKMykOT0F1jilCfI0lAZ2/oTXC00HyTgGwVTyAoAoFtiqNtyZOvxp2HJ55Euo5OFqeU/FBz+yPNuaLcIVsCL6rzbibAgYLGhckhwbvd9xBjg6whC4d2HE0OHlpQYKL4O1S3ezwipDuMusShL/3jJi0eRnh46Pz9RwIJKzPHDM3cHqZi8AWJePkF6j+zB6CqVd4KVt932TAjkoiAwtgntEemBFayGLSvq1f+V9/oXGp61egSJs7FpItKEWqc6fE39AYlQ2Ez6qONffEUZ68xBm0rRzZ7Dc+Yuntv87yksBT47AaHzRZrLOPLLYnC/rqobzbnY4aVl9a7kTmcxU7vkEKMjm2oDwhxAXumFloaUbRlcMeOX3c8rHWOeLZgabs1cQXMjDdoe+5ALgwb7t4YPIT3es+5Eu+5qD4o12miAVnULRpOEGyjirPPJ+Ft0yZImBYctJt2+0hIBvAWy+sia5Qiw9J+TDtMXcS72+LeyuTHkLK/9N837GxvSvZjgLOpIt82cbN9F5HDLlkvh3IAeo89rtx2EZIjZvHoCluYiphd8MbFCXl8S8AqBRAe4SvvarL48QbAOXJKpu9cMjBAlByy1S6JNxVDysTtWipk29OFJ6gqQhSYr1oaTjW62YI6nRQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(39860400002)(396003)(376002)(136003)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(82310400011)(46966006)(36840700001)(40470700004)(316002)(6916009)(356005)(81166007)(70586007)(70206006)(4326008)(8936002)(8676002)(478600001)(82740400003)(5660300002)(41300700001)(40460700003)(7696005)(26005)(426003)(36756003)(336012)(2906002)(86362001)(40480700001)(83380400001)(1076003)(2616005)(6666004)(47076005)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2023 09:59:33.4340 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a81fd5ce-9e05-47a4-58ba-08dbd15342bb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017090.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6416
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
Cc: Emily Deng <Emily.Deng@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add error handling for amdgpu_sync_wait.

Signed-off-by: Emily Deng <Emily.Deng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 9 ++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c          | 6 +++++-
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 54f31a420229..3011c191d7dd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -2668,7 +2668,7 @@ static int validate_invalid_user_pages(struct amdkfd_process_info *process_info)
 
 unreserve_out:
 	ttm_eu_backoff_reservation(&ticket, &resv_list);
-	amdgpu_sync_wait(&sync, false);
+	ret = amdgpu_sync_wait(&sync, false);
 	amdgpu_sync_free(&sync);
 out_free:
 	kfree(pd_bo_list_entries);
@@ -2939,8 +2939,11 @@ int amdgpu_amdkfd_gpuvm_restore_process_bos(void *info, struct dma_fence **ef)
 	}
 
 	/* Wait for validate and PT updates to finish */
-	amdgpu_sync_wait(&sync_obj, false);
-
+	ret = amdgpu_sync_wait(&sync_obj, false);
+	if (ret) {
+		pr_err("Failed to wait for validate and PT updates to finish\n");
+		goto validate_map_fail;
+	}
 	/* Release old eviction fence and create new one, because fence only
 	 * goes from unsignaled to signaled, fence cannot be reused.
 	 * Use context and mm from the old fence.
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index 70fe3b39c004..a63139277583 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -1153,7 +1153,11 @@ int amdgpu_mes_ctx_map_meta_data(struct amdgpu_device *adev,
 	}
 	amdgpu_sync_fence(&sync, vm->last_update);
 
-	amdgpu_sync_wait(&sync, false);
+	r = amdgpu_sync_wait(&sync, false);
+	if (r) {
+		DRM_ERROR("failed to wait sync\n");
+		goto error;
+	}
 	ttm_eu_backoff_reservation(&ticket, &list);
 
 	amdgpu_sync_free(&sync);
-- 
2.36.1

