Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7BB3C61D97
	for <amd-gfx@archiver.kernel.org>; Sun, 29 Jan 2023 04:01:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09D8310E053;
	Sun, 29 Jan 2023 04:01:33 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2046.outbound.protection.outlook.com [40.107.100.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 85CE010E053
 for <amd-gfx@lists.freedesktop.org>; Sun, 29 Jan 2023 04:01:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gvGPp0H8hCk5KenMOKay8pFYS8N6KKRLhaUUj5T/vTX0sTWcyF80vBam1iSXo079KhQqPAKvvZyVH/xHYo5YUMLBB+J9ETYVIuuXeagscXsiRc5Vj4RXvTOLItiDvi4a80YpGCtX1v4mGmAqy6w1d6jHYa1gF/7cEnsvFB1AShDMrXACWG1NSPHd+/ZizcHfLlHcRZlph7hQiSOfkTvveT2z2ZbhPOC3SW2iuduMAT0A68rnCmiNdQkxlKZ3Z2I/4WPFZHY/nrtYl4U28CD0nuoUAdXLEvzk7roI7fQ92OZGhHoIxKFmCDud9TnvseQSt95fEjQMXhAFCqGrSbHxnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yoWD3bNNhVsIhvYl2+eulYx5RlCEh7XoR8UDAzmiPCY=;
 b=np4Fd40w1LnJP+ekEQdm6Vpc3PDgBAXCsaQEUtDL1Y4BTjmFfB6aoU9lufAQhF17mgeKDHmPttkIPC7seXXPqNOzyA1mEA/1OgdU773E/xXstyE+iCRMx0q1cynFFlbGUW8Yp0JPqYSBg4vjzV5zIWNYqU3IFujaXi+x9sG2uS/EhPEG5+X/0GDtVFfXdZJ7afeq27ZhyG+4XyH2jQ/ytHmpwn1CHV6/qHQvcNS2cuLUSWYZdhx+nAKaB6hVryMsT8ptyzqcPN7b5elDxi4TXYi4I6ZchwVv9vUtbNJInq9X2mxDILFwxqhoaL5NkU5xPOocmGFffGcaPatuHahs2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yoWD3bNNhVsIhvYl2+eulYx5RlCEh7XoR8UDAzmiPCY=;
 b=UE7OwPU6SbALNPhYxjCBASQYc289D6FWUSa4T28BqTrTmuEKJrLHwyp8V6oAtVHpbXJjQSS5IJybNH6zXzGlDYVS0w/ze/jaImWMD7/ydy+OvrqliMpqJE70T9wcHLPOlJ7z5ITqWZXeD4cAbAs0W+VwNwrZyLpbd13XCOtCLnc=
Received: from CY5PR13CA0003.namprd13.prod.outlook.com (2603:10b6:930::31) by
 IA1PR12MB6258.namprd12.prod.outlook.com (2603:10b6:208:3e6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.22; Sun, 29 Jan
 2023 04:01:28 +0000
Received: from CY4PEPF0000C96A.namprd02.prod.outlook.com
 (2603:10b6:930:0:cafe::3f) by CY5PR13CA0003.outlook.office365.com
 (2603:10b6:930::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.19 via Frontend
 Transport; Sun, 29 Jan 2023 04:01:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000C96A.mail.protection.outlook.com (10.167.241.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6064.17 via Frontend Transport; Sun, 29 Jan 2023 04:01:27 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Sat, 28 Jan
 2023 22:01:27 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Sat, 28 Jan
 2023 22:01:23 -0600
Received: from desktop-host.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Sat, 28 Jan 2023 22:01:23 -0600
From: <vitaly.prosyak@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <alexander.deucher@amd.com>, <yipeng.chai@amd.com>
Subject: [PATCH 2/3] drm/amdgpu: always sending PSP messages LOAD_ASD and
 UNLOAD_TA
Date: Sat, 28 Jan 2023 23:01:20 -0500
Message-ID: <20230129040120.72405-1-vitaly.prosyak@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000C96A:EE_|IA1PR12MB6258:EE_
X-MS-Office365-Filtering-Correlation-Id: 01696a44-eaf7-49f3-eea4-08db01ad7f5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: auEweOUN5aGvL9ZxPt106btuJ5iuvBI+KYfeVgslq4OIhRraAL7y7vs1kmKH4b0pN766JJJ2X16zIY74VSynilppihgs4k+aWiXASP6xuc2P58Idk14HdVUwyfHJsOP1qwyCL7Z+h3EJtKDdZII9qJLmhpqwd8kCKXXcOXNZ8R9YYZd5+6ykM8sGCgKjKWOnjGc6Pso+7ALOWDkWnYZoUkwN5+DqiHwq8VOUqfr5X4AMBo9ekehft9/WEFJE8i5TVQEJKppd8nWWbTyKXLaPY0s4whJeTiwr7O6eTPYez3EL2g2FbpL/8IsJbDavkFPJCkrMNQZlf8rHBCyedjYFTYJyEajR++sTgu+kPAWAhwB+10nKkao+TlcNJbOHRzOxjjCxOgF+hlMik7q/qCMu5cYEFMcsua37lwUJcY6zniIL19WW83p/GxmGF4DNjIctH+nYryj97tXwuSC8Vid5H8HtxyIvrZpc4KecbsfE9lfTiViySFGL5zbhIW+DEnjLufMGvujbgoCIybtMyZSJOhHR1pI8mQU8ButwU6t5JVtmJ7cBLAQ2tdUOhJArKHhefptJX/m3uPghSpKeYGy4obxV78V0//Vt+ZxfgHIBKCg++2rIz2ia8gX+bGmCljmmX9qPiFFxRLiv8znpeB00veB2TRDRO2vUgMTPoLV/Nl0OrnxiRee5rMLY1L2JPorV/yY+nyOdRW0+l6NbPmbqqW9KQxyxEMdz7ZXY6wqaS3o=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(39860400002)(346002)(136003)(396003)(376002)(451199018)(46966006)(40470700004)(36840700001)(40460700003)(110136005)(2906002)(356005)(2876002)(81166007)(6636002)(36860700001)(1076003)(2616005)(8936002)(15650500001)(40480700001)(86362001)(426003)(26005)(83380400001)(186003)(4326008)(36756003)(70586007)(70206006)(8676002)(336012)(5660300002)(47076005)(7696005)(316002)(82740400003)(478600001)(41300700001)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2023 04:01:27.9861 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01696a44-eaf7-49f3-eea4-08db01ad7f5e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000C96A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6258
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
Cc: Vitaly Prosyak <vitaly.prosyak@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Vitaly Prosyak <vitaly.prosyak@amd.com>

We allow sending PSP messages LOAD_ASD and UNLOAD_TA without
acquiring a lock in drm_dev_enter during driver unload
because we must call drm_dev_unplug as the beginning
of unload driver sequence.
Added WARNING if other PSP messages are sent without a lock.
After this commit, the following commands would work
 -sudo modprobe -r amdgpu
 -sudo modprobe amdgpu

Signed-off-by: Vitaly Prosyak <vitaly.prosyak@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index a8391f269cd0..40929f34447c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -606,12 +606,21 @@ psp_cmd_submit_buf(struct psp_context *psp,
 	int timeout = 20000;
 	bool ras_intr = false;
 	bool skip_unsupport = false;
+	bool dev_entered;
 
 	if (psp->adev->no_hw_access)
 		return 0;
 
-	if (!drm_dev_enter(adev_to_drm(psp->adev), &idx))
-		return 0;
+	dev_entered = drm_dev_enter(adev_to_drm(psp->adev), &idx);
+	/*
+	 * We allow sending PSP messages LOAD_ASD and UNLOAD_TA without acquiring
+	 * a lock in drm_dev_enter during driver unload because we must call
+	 * drm_dev_unplug as the beginning  of unload driver sequence . It is very
+	 * crucial that userspace can't access device instances anymore.
+	 */
+	if (!dev_entered)
+		WARN_ON(psp->cmd_buf_mem->cmd_id != GFX_CMD_ID_LOAD_ASD &&
+			psp->cmd_buf_mem->cmd_id != GFX_CMD_ID_UNLOAD_TA);
 
 	memset(psp->cmd_buf_mem, 0, PSP_CMD_BUFFER_SIZE);
 
@@ -676,7 +685,8 @@ psp_cmd_submit_buf(struct psp_context *psp,
 	}
 
 exit:
-	drm_dev_exit(idx);
+	if (dev_entered)
+		drm_dev_exit(idx);
 	return ret;
 }
 
-- 
2.25.1

