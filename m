Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F031C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 10 May 2022 14:59:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C0B1F10E6DA;
	Tue, 10 May 2022 14:59:29 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2071.outbound.protection.outlook.com [40.107.237.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B590810E6DA
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 May 2022 14:59:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B8Wh+0kw1MYRpgkSmv7CJsH/N3F6mSJvJkeFxjAsk5gphjgVTfYWyB+KqA0GFyRNkeVVxZFGFAQk5PCv2qBnC8k4z6q/QTUZQN2xbky4r95cWYnQtKjLEbrlbvFSOv29FB/+spFsBKX1n/rCBwN5MhieFyu/t+DdXuExT56pFkYDoPwW8eZ2CxMHUs5wEpM5z79VUDmc2ZzhB0f+wlLcCRKZ65VcQNantIYTVLzsM8OfCs3GTe7nB52fFUyUXpWFOdFoWHJL5qpi9yRuXr0WnUfPTai7JZ6UX++XJHOIxNjyYaAo+3dqcIKIO4JtVqIixdYyhXWNSVLFaoulNn6YVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VRs8WJ+akXo6VhMJvdGJKmziuDlCju1Oe07rns/jNNs=;
 b=lGHhEuldtGqj98OuU52yNTQrmYi3cii0FiKpYlGr4hdM5T37/BFbSMqhbsjO8hu7/fO3Yw5ZFGYxwwNcXvr3MRlAZxwJCwPQcZP1OemzaNFEHBOE2j1JgmTFN/dv0RAD2dvdPDkDcocaYhzgTjamS+beGCIpy6grjqKzmrk6BgadZ7OsulUL86c4zefl+DX7bqneNs7e37JaOyj336qfKdYA1VFDMEFGDMGbZId8O+Xdbn0mVMTsI577hTP+6UJi9N6lo3SDGW24e5N1cI6tqn4n1YhMhFQ0hjqzOXvvZrIQqBMxzadNd3Hyf2MZTl+nFrRwWU91SNFV5o9KQWtRxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VRs8WJ+akXo6VhMJvdGJKmziuDlCju1Oe07rns/jNNs=;
 b=zT52tv9Tnf3pHNragWpUxP//b7mq/Ub73hU2pbEGMSOPt1ActzqQZVZOphKjdkC7o+FbaM4A8SLv0aEjTcg7392HiJILbiU7e8FBI92JawyaMnU2gC6LC/S0NqazVHJRb1QiV6fQl6h3h9y7W8dFRhb4o8ZC6UHKrKnsQbF/wC0=
Received: from BN9P222CA0017.NAMP222.PROD.OUTLOOK.COM (2603:10b6:408:10c::22)
 by DM5PR12MB1484.namprd12.prod.outlook.com (2603:10b6:4:11::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23; Tue, 10 May
 2022 14:59:25 +0000
Received: from BN8NAM11FT043.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10c:cafe::72) by BN9P222CA0017.outlook.office365.com
 (2603:10b6:408:10c::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.21 via Frontend
 Transport; Tue, 10 May 2022 14:59:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT043.mail.protection.outlook.com (10.13.177.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Tue, 10 May 2022 14:59:25 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 10 May
 2022 09:59:24 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu/psp: use proper vmalloc API
Date: Tue, 10 May 2022 10:58:42 -0400
Message-ID: <20220510145842.659401-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 09904854-d4b7-4cd4-a028-08da3295aca9
X-MS-TrafficTypeDiagnostic: DM5PR12MB1484:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB1484844531580D4802025115F7C99@DM5PR12MB1484.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ewsqmMeCSPyOAmEfNi64tqsoSCSCD6wmx6PRu6A/H/O44aWYIP4PAK1r3A0N3Blsk5XOVBTxQxfllTdMMpVwrc5Cb8lblf8bWgxbCNNFcCaxHPvXfR4KNNQJdJt6/incDxployoWqRpUEN2W6Y8iC5iVw3Aouj4+ueZvxiqRVbONBlbFDiCEAidfgHRle25aJfsFSuAbjPOwd+CHdIbLE4d+JVsBZJ7VU3A2x/E5ItDmp3c5c6WbM6oCOyMQk6HsnQh7N38RghHycPrTrHYpmFWyvlnRAAq16aOsrpp3eXx8J3v67orOgUIO3vY8FtR2tVgP9H+nOMKaSZ3u/YRsZ5ZfxAxn0fQEwhJSf5Cnt2mVgYp2wOBSIlENZ8da9YSpXPI9O4llUgTqgzsgM/MmriJgYW7IrTlqejE+fXHtJb6CvvTJBoLShqBJjH+GRgqn3BR0SK8+Jz6vncmwZZ9nYApzHiN++TXkBH1FegwpSby+QwgycLfrZOyBrxLiMcW1ZJ3VTDJLN5WVgGtcDtZatq+GRcBF5ieQqjnoR/4Efe9EIXtKoCYkLjuSDAgjwHH+cHb51K7IUeOwJLULwUJ85fyMdeDA+YONmmbkeVYFdqHKwI65O9ueu4Hh5NYjRNYhWduzAdSA5ipenBXU80eHQyo15PbYpKlWomQtXIf5SdFbsiBqMINW2dRI6tcAe0rjm98xkT0H/F5ak6mpA+/HFA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(86362001)(7696005)(8936002)(6666004)(2906002)(5660300002)(508600001)(81166007)(356005)(83380400001)(26005)(36860700001)(2616005)(40460700003)(47076005)(186003)(426003)(336012)(1076003)(16526019)(54906003)(70206006)(70586007)(316002)(6916009)(82310400005)(4326008)(8676002)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2022 14:59:25.4035 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 09904854-d4b7-4cd4-a028-08da3295aca9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT043.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1484
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
Cc: Alex Deucher <alexander.deucher@amd.com>, kernel test robot <lkp@intel.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Use kvmalloc and kvfree.

Fixes: 31aad22e2b3c ("drm/amdgpu/psp: Add vbflash sysfs interface support")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index bbc232697069..214e4e89a028 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -3459,7 +3459,7 @@ static ssize_t amdgpu_psp_vbflash_write(struct file *filp, struct kobject *kobj,
 	/* Safeguard against memory drain */
 	if (adev->psp.vbflash_image_size > AMD_VBIOS_FILE_MAX_SIZE_B) {
 		dev_err(adev->dev, "File size cannot exceed %u", AMD_VBIOS_FILE_MAX_SIZE_B);
-		vfree(adev->psp.vbflash_tmp_buf);
+		kvfree(adev->psp.vbflash_tmp_buf);
 		adev->psp.vbflash_tmp_buf = NULL;
 		adev->psp.vbflash_image_size = 0;
 		return -ENOMEM;
@@ -3467,7 +3467,7 @@ static ssize_t amdgpu_psp_vbflash_write(struct file *filp, struct kobject *kobj,
 
 	/* TODO Just allocate max for now and optimize to realloc later if needed */
 	if (!adev->psp.vbflash_tmp_buf) {
-		adev->psp.vbflash_tmp_buf = vmalloc(AMD_VBIOS_FILE_MAX_SIZE_B);
+		adev->psp.vbflash_tmp_buf = kvmalloc(AMD_VBIOS_FILE_MAX_SIZE_B, GFP_KERNEL);
 		if (!adev->psp.vbflash_tmp_buf)
 			return -ENOMEM;
 	}
@@ -3514,7 +3514,7 @@ static ssize_t amdgpu_psp_vbflash_read(struct file *filp, struct kobject *kobj,
 	amdgpu_bo_free_kernel(&fw_buf_bo, &fw_pri_mc_addr, &fw_pri_cpu_addr);
 
 rel_buf:
-	vfree(adev->psp.vbflash_tmp_buf);
+	kvfree(adev->psp.vbflash_tmp_buf);
 	adev->psp.vbflash_tmp_buf = NULL;
 	adev->psp.vbflash_image_size = 0;
 
-- 
2.35.1

