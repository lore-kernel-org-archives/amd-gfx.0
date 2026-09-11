Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46056C88E45
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Sep 2026 15:42:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6060910F697;
	Fri, 11 Sep 2026 15:42:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="idhs8sJP";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011027.outbound.protection.outlook.com [40.107.208.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BFB7D10F693
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Sep 2026 15:42:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cHytV7V0QWb/8upVXMUwhF/0Bi0xNQIIFm+OUWy+LN30fZmCpz0m0nAl9xnM1bQtd+R3EbKoa7R/qLx5UrdW1oyEwkfkRecTI2iarQ8tvGBpFZqAi6fdk6pW8v/1NzSoCLm5jZ/6ZyrQggQKNafB+E7AsrvcKi9vdIIURMhL/LiVkfKzlha7SkEzbxMXIECINTA8BaWQomg3K7N92T/clcaRutkjSo3mbDjVFebnn8sjmqs3/SvAcTvoyyf/YJmVRdgd5+dPsMTLO2y+5synC4cqMBBhlNGZc8zQAhYQkoP5L41QPdJaq6DYR8/wAL86jm72of8/KgS+7gX6IIAxzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dz8KeicJnqA9iTEoxmBzuqgnvrtz/maCwmmnMVeeitY=;
 b=c4SmWquoTb4KfDKgYB9a+Y6vovNLoOaSHlZYSuLqksR3VX2tpXQxS8weCwulxu2wUahDsM0RuZFpdtwf/9oVoxqE3WNfgkR65oU4qcF5SPwYjNLR0KXGO8UvfxNxXmfNfjhhsw3WZTKSLJNGfHt3/fEj2gUtfRoYwUi0P8lyHjeznCcucjWScqz90WuaiqbgRzm8ZsRzW5FTOm1X9r8eCNj1k/lUC+KoyJy/VXSMcX3A31zTvrUa2lQtWCwC8wzItF4G9QC8RvyMgfgoC840w0FRFP5AQyM7JAk0TT0ruFQAb+a9Z16YLa65H3r+VuoZsLR3P50UzW8Mnj44Tcsa/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dz8KeicJnqA9iTEoxmBzuqgnvrtz/maCwmmnMVeeitY=;
 b=idhs8sJPe7+ia2AjhPnvRV423jcPb97F3pEmZenjVheC3UgQPCdrO931TGkveMykzgHgPOLsgkFNAJBtH7Y/jRifCd/DX8KivVwspXSYGmHoplkyev4K3WGikQ0/kua9w9EjWgT92KK0pNSImG27PHYTGHZvHWOKj+W4aLWQmkA=
Received: from CH2PR07CA0063.namprd07.prod.outlook.com (2603:10b6:610:5b::37)
 by PHXPR12MB999233.namprd12.prod.outlook.com (2603:10b6:510:3cd::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 15:42:27 +0000
Received: from BL02EPF00021F68.namprd02.prod.outlook.com
 (2603:10b6:610:5b:cafe::84) by CH2PR07CA0063.outlook.office365.com
 (2603:10b6:610:5b::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.10 via Frontend Transport; Fri,
 11 Sep 2026 15:42:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00021F68.mail.protection.outlook.com (10.167.249.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Fri, 11 Sep 2026 15:42:26 +0000
Received: from amd-desktop.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 11 Sep
 2026 10:42:25 -0500
From: Shahyan Soltani <shahyan.soltani@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
 <pierre-eric.pelloux-prayer@amd.com>
Subject: [PATCH 5/8] drm/amdgpu: handle runtime pm in amdgpu_gem_userptr_ioctl
Date: Fri, 11 Sep 2026 11:42:08 -0400
Message-ID: <20260911154212.591213-6-shahyan.soltani@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260911154212.591213-1-shahyan.soltani@amd.com>
References: <20260911154212.591213-1-shahyan.soltani@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F68:EE_|PHXPR12MB999233:EE_
X-MS-Office365-Filtering-Correlation-Id: aa95e669-01d4-4377-cf79-08df101b4819
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700016|82310400026|23010399003|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: AvXndYFYeNiHlw3NQp4SPCzqUL3gpV6mukJdSWVpdENji8RQnEEolJFyJ6TLUIzoyPUcrpHtCVoZ9BqpMso495E1pxabY9Xa24Kb7DNFawzyBKRUFVoRxOltdyn29jOmcQj8HNxeRFjh69ved8JQaWDShmvkYX4AeWcCfbMg2YeUcoDvkDxdwvJpaqDmLhWekEE1FwDcZjLuPC5F03MZTt2BORCkzIVvArXk6jXUoNDK82eTGaJ+fGGfF315HQW4Gv7i0ypEvtpt3DC1sTEsDnujrKfs6W5yixakjSfvQETZ1O7hBnYUsft96n/IEjNMSZMXZpySVSjkUFy+5jceLOZM4yVE2glzluOEDSPP7Z0SUp7f+L3HGXTp5Lc9rNg+Yrs33jb0N5CVdP3NNRpu7DesXlSx5ghiYqOLvrlG06si37VhfDcE5BsllyARHW5Eyqf7IH9tqJ8jbxsaXEFsg/qbSfLuT7/BhSem0B37fbqbjRXqjJES08kR6bfs7iQ8KogI8GjEYsAl577Ix01Rkt0Zl3KvDGeCvOaAP+SP31VkhWVzeA0Q3v+96VVwfp1STABkkTByxlBSjfp1wCg3EZmBd/LxTjN/JYTPOlKc2u9uitMte4eMliNE4hedczN3R2xd8xqEZHVufm2+ERiSkooNd0nyZV7SL754MZvbiWbQIkzJNU+iJV5amoZskMxcVsqu3AGKBZgzuy5Yex1Dkg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700016)(82310400026)(23010399003)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: T4lUEu1wfDc9DBmc+Up+sYM89mc6DGGv/m4uaPQDLUWzxA/uJfIkItWJ+Ti7niLFBdqNmCFXGN+te9pjNu9Vh34sb6oEXSpeVNmvuE/xpYbpAKMQ5XQtx+R0vAFXDWVXs56OSTuBcf0pIfXO/maA+HfDX6GEr7u+8ZJnjV6qHwPhpFJeC9xTgLDSu1ttGwf9qsQfYwIZpJmenoXp5yFWiNlU202gvltb+9vRDOdEzmUO8dXpVYJ6VahsoyuGdX0Z+i1UhPCZqp2q3tI/z1V/VIU650dwlcYughkkrUD256bh1vYL28PCFBSa3w7HuItoGFa4GW7lvusf0G0nhbsHl+hrCdIIBvudlfOnP3bZ4zEs0pQmh5CL8x6UTGfF5YrfyxZBTlZy93s7KHUzfWYgvi6LP2/8fLZGVjwBeG+tT7FFWms0lD+5BA5QCpEEj1Qg
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 15:42:26.9246 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa95e669-01d4-4377-cf79-08df101b4819
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F68.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PHXPR12MB999233
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

From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>

Wake up the GPU while setting up user pages and validating the buffer.

Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
[shahyan.soltani@amd.com: Added commit description]
Signed-off-by: Shahyan Soltani <shahyan.soltani@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index 319afa5e724e..27b7c35559a2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -606,11 +606,18 @@ int amdgpu_gem_userptr_ioctl(struct drm_device *dev, void *data,
 		if (r)
 			goto user_pages_done;
 
+		r = pm_runtime_resume_and_get(adev->dev);
+		if (r < 0)
+			goto user_pages_done;
+
 		amdgpu_ttm_tt_set_user_pages(bo->tbo.ttm, range);
 
 		amdgpu_bo_placement_from_domain(bo, AMDGPU_GEM_DOMAIN_GTT);
 		r = ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
 		amdgpu_bo_unreserve(bo);
+
+		pm_runtime_put_autosuspend(adev->dev);
+
 		if (r)
 			goto user_pages_done;
 	}
-- 
2.55.0

