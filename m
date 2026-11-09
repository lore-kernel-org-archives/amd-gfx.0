Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1111B606A321
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Nov 2026 14:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=kPS3t1Om
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C5E010E1F8;
	Mon,  9 Nov 2026 14:57:44 +0000 (UTC)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013003.outbound.protection.outlook.com
 [40.93.201.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B5A4F10E1F8
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Nov 2026 14:57:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=snOrJ8ga+mtsvymx6Vj/g7mfkYnQNXTYV3P5WEXcqqE7KgaLfx+aO7fq2IUobZ0MtroqCpGiMRhHUuAOeGYakna0jgkZa5JFzIRKjmk1AP972zb54n2ywBH5wQmaruQMcRYAiSlJJjBl1JNkQN1FaUAUh/M7N60ywZk73d0TGQoliqiBqUCZ+rD5b3fKftAlrl5QspbFGZ+Xff5r3uSzuW72K4iuAq3nzKLJOdGSJV7FTMIsxwaYBTqlLx75efMh2fJQMXODvrwm+WJhCWjdbdCB+YlaF87kvMYEC6p+66HlT157HPlx8itI8zqKjfq7CrAB6DRGNrEtwUabml1vMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u2IQDXBe/F75ZLqPfMTTqcloi+OkVgTsOxfMNcpbIWA=;
 b=nQW7yY9k2NugNbiOMRtl2aF/T+XBdtIuydqDlZT5edN2la9GfJdMgm4UKYDZ37DUMo9cwoV813nSyIp6L+WRpatyVFsoG7hiU1KADg8aakrTlzGaAdSivqfKvi23MQ7BoQsKWQ4ibIk0EUEZMOIN+h/v/KNp9Kt73TX+Mc/M+aKndFJtxXtDcxHgIacDLBK4nBuE3UmJ/a1XDJMSCAFIevKuyLIV3u1oLNlJs4hS3yXU/ZsXmXZPC1xfm3gAvsPKn90Iu/948qymsO1ma8bia0dxh29xdhlfYa0PNVGQ1PbijgAQiTLFkSIOa0LnhLzHXjY/4XdpfBrSk2Um8LqjjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u2IQDXBe/F75ZLqPfMTTqcloi+OkVgTsOxfMNcpbIWA=;
 b=kPS3t1OmpcDduswc6yDy+3lvl9e6PWdJgt8dbQ3nv0W1yBmQxjH/39yPvehspxPX/G/9N5mLYBYXGfap1F57mPfIbvFYAqsIw/YHL3AzBmFB0N84RycvHNKBU0WyzQBbQ7bv+zZrwBnRIdkCxCjBmwOyNEQg1AZLDS3uOKQiIRE=
Received: from SJ0PR03CA0181.namprd03.prod.outlook.com (2603:10b6:a03:2ef::6)
 by CY1PR12MB9675.namprd12.prod.outlook.com (2603:10b6:930:105::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Mon, 9 Nov
 2026 14:57:34 +0000
Received: from MWH0EPF000C6184.namprd02.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::ae) by SJ0PR03CA0181.outlook.office365.com
 (2603:10b6:a03:2ef::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.8 via Frontend Transport; Mon, 9
 Nov 2026 14:57:34 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MWH0EPF000C6184.mail.protection.outlook.com (10.167.249.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Mon, 9 Nov 2026 14:57:33 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 9 Nov
 2026 08:57:32 -0600
Received: from bencheng-dev (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Mon, 9 Nov 2026 08:57:31 -0600
From: Benjamin Cheng <benjamin.cheng@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 <amd-gfx@lists.freedesktop.org>
CC: Sunil Khatri <sunil.khatri@amd.com>, Benjamin Cheng
 <benjamin.cheng@amd.com>
Subject: [PATCH v3 1/2] drm/amdgpu: wait for tlb flush before freeing BO
Date: Mon, 9 Nov 2026 09:57:17 -0500
Message-ID: <20261109145718.91381-1-benjamin.cheng@amd.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261014022107.2511834-1-benjamin.cheng@amd.com>
References: <20261014022107.2511834-1-benjamin.cheng@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6184:EE_|CY1PR12MB9675:EE_
X-MS-Office365-Filtering-Correlation-Id: fee0595e-6231-4602-dbd4-08df3e71c909
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|36860700016|376014|1800799024|18002099003|22082099003|6133799003|10067099003|5023799004|11063799006|261028144727099003|261102123227099003|261022075727099003|261022105027099003|261021123027099003|56012099006|261021121427099003|261026140227099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: Hv8vB79Kolmz+8QRU8pHjpiFTNcPDGQGO86A6kC8sWljOmPD5sb56Lzl0ZPczIvX/qJU2Z/X/EmC6IrKze9BsVMt+/Jt6W+VoFLhQhMpn5969q5HkGnr4VLd2XMqUQCYIZZY53lO4kVfK+StjlvwtQwjf5ixH+kX3OLBoAxwG1QZWDnRrUhy0kYMMaOEGi6U9/f8/UeyiMVY2uKAcW8Bbvn91G4xP8ViWDbTNN+IWweBSrKj37wzac5e/vaFBexQdrw+m/sBRGSZ48GMZWAP1aIhAtlY5zDPAUlOSQc0HXgUz/l5xQfTpy56bRwlZNwmsFliOSGbIGAZJn8fSiLw71c1nn92/04NZ68OVsyx7LbLqhXymvd8XFwZYWxBABRSXUMQVwM8HcZPsPLgiRhjAyzKqQqlWAi/c1+V+PdvsPnWKurOBDqje3Hgrt9qf1ZJeCfMW0mEyVyerrDE7nc/yT6khdbSpsiA++yVcEW4fmAVj77uRd36o/DYFI5RGLzvIYL6/4XoXJ4ZeagQGmpGpA/Y/+i+Tf6HqMJmz9Vf9/y0ymbyy9/DPRvNQhpO9YpwfIRfKKdT/k1nsBa3GtttHvLVa+QeSTAW5Ev7UDUqdqfNt+3UEz0Ng9X0nds1jx2GZTY4cDF595sCrHPSgFXR5pMf9msUdwsFCc32rl+azs6l4HokHbN5Y8wRe1YxnB6fPebuSKDNDzpD7X0i5aOH0Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(36860700016)(376014)(1800799024)(18002099003)(22082099003)(6133799003)(10067099003)(5023799004)(11063799006)(261028144727099003)(261102123227099003)(261022075727099003)(261022105027099003)(261021123027099003)(56012099006)(261021121427099003)(261026140227099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: sk3uogUQ7VF33AuSE0aSHq/03L+V8zY/kxAQUpSdY+chqxBGzaiNEonvfpL/icGxjCu6a7Ry6/bFfvdGnVKeRgVEaAtguv0y36Y1bSeZkb3CWwdbuFjKKOUu3PSPeipFXQf/EKYkCUizOW643jqlAA5jDj/WsT4bhK47Jl8j5QqoUEeP5dzMyGmL7vxAt57C9JYbzb8OPxIMQmba+K8o87Rp9sZ0w5XBCreygpJPdfRQjJ0P4jKBTchu3GkABq+l5b4CpqXppqP/UHGV6C0wjNc8AzlHBQNTYpngyZL9EIiqU0WJBuHy4ya4lDvBVRzgh7PCpqUqBZ4l2cNtmVD1YeL4sYzXHoaSns26lMiza58w5VOYn14Of8wYEO+98MW5pUxXNwYBKb5cClr5u2tXRV/WTpTpFlTvjDUMPkWy5b9trPbF0F3KtDrNqSnYHjvR
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 14:57:33.3662 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fee0595e-6231-4602-dbd4-08df3e71c909
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C6184.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9675
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On gem object close, we previously only attached the fence of its own
clear_freed() call to the BO's resv. If an unmap of this BO happened
prior to the close call, clear_freed() would be invoked, leaving
vm->freed empty, and no meaningful fence to be attached to the resv.
Because of that the memory may be freed before the TLB flush is
complete, and give a running userq potential access to a stale
address translation.

Fix this by attaching the last_tlb_inv fence to the BO's resv.

Fixes: a1d201e16940 ("drm/amdgpu: enable GFX-V11 userqueue support")
Signed-off-by: Benjamin Cheng <benjamin.cheng@amd.com>
---
v3:
- reserve the extra fence under lock instead of relying on
  amdgpu_bo_fence() as Christian pointed out
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index 6137ab4211be..c9a84257ae5f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -340,7 +340,7 @@ static void amdgpu_gem_object_close(struct drm_gem_object *obj,
 
 	drm_exec_init(&exec, DRM_EXEC_IGNORE_DUPLICATES, 0);
 	drm_exec_until_all_locked(&exec) {
-		r = drm_exec_prepare_obj(&exec, &bo->tbo.base, 1);
+		r = drm_exec_prepare_obj(&exec, &bo->tbo.base, 2); /* clear_freed + last_tlb_inv */
 		drm_exec_retry_on_contention(&exec);
 		if (unlikely(r))
 			goto out_unlock;
@@ -371,11 +371,14 @@ static void amdgpu_gem_object_close(struct drm_gem_object *obj,
 		dev_err(adev->dev, "failed to clear page "
 			"tables on GEM object close (%ld)\n", r);
 	if (r || !fence)
-		goto out_unlock;
+		goto out_tlb;
 
 	amdgpu_bo_fence(bo, fence, true);
 	dma_fence_put(fence);
 
+out_tlb:
+	amdgpu_bo_fence(bo, vm->last_tlb_inv, true);
+
 out_unlock:
 	if (r && !drm_dev_is_unplugged(adev_to_drm(adev)))
 		dev_err(adev->dev, "leaking bo va (%ld)\n", r);
-- 
2.56.0

