Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3EA7C61DA4
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Mar 2023 22:43:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3423110E427;
	Mon,  6 Mar 2023 22:43:34 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2064.outbound.protection.outlook.com [40.107.102.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C29F510E427
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Mar 2023 22:43:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RJW/uo30YxVxA444kZmI6QWwXF0LJEM2vqlgt/wfeeNFtprXk2+81vVDXANi703khsaoQwOkbZ09Ij93ilJAjZ5HE9P3xlHDd1JZqi6teZRO5KIvxDJjmP9HDgO4JpiyP5EDC1lHmZFXutjU74dyjECegXJ2ARMf9egBXe3eXIfBmzaPi4h1eHroX81uKCk+9gFksfZqgXwubUJc7ojD7ak6tOyQgOKk9RHeWQdfEq5DmRRESa/+QduZuRGjm09t5acBbwzJ9S17natq0XlxmrrdqEL1D1e6dvoqXB6pjFTjAB86VjpMNjsetvcbczVukV4r6QCM/6fW4kGtkrzsSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jRhDDTGDtopimbntk2qM+Nyig+fOxCViHazawyi3PFM=;
 b=oe0q3UevwtC5VIl0fjgUGnWNNbifzBtH0dzsUWkoEIXLXU+qrX5rypKEukNsDfJTAuCeFMkAwR3xs0gjKgaTqrcUsDJxXi7BfRZVTA8aYIrbiW7O+i0rBXwIgE8NjhLpTxrQd0RhAT180BKgoLiwrsECK4K4BVjkeKuRw+A8k1Pa4dQIOo/8N/wlEidZWhenMdatrWp74Pzirnt8+N3+sZ2h0BFw9Dx9bCgBz3I9jrvFrOKUwQk+CvFai35BDXNH5cgnR+P66e/0sfdSlRKDg8SqPYAsvROeA+B68+WeuJBnWYWl5DYt1JJfbUjd6LmmP8e+p/0pHgMUpxJWXPp0Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jRhDDTGDtopimbntk2qM+Nyig+fOxCViHazawyi3PFM=;
 b=w5xK2Ya9pITdgaKP/oAd7JIDKWFuesEJtwrp3xMPF6c9zzbEf7l4X0Pl9QV8KwyzngLhEFcT5elCgcFEgG5SBYDH6VNkcHSn9sp8/Fgkk4emEqtR9ab+lVknKTYtSBJ1AJ3UVs17iOhwwdeJwTRAaO27pmU8QgsZ484RmycGJPU=
Received: from BN1PR14CA0014.namprd14.prod.outlook.com (2603:10b6:408:e3::19)
 by DM8PR12MB5495.namprd12.prod.outlook.com (2603:10b6:8:33::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Mon, 6 Mar
 2023 22:43:30 +0000
Received: from BL02EPF000108E8.namprd05.prod.outlook.com
 (2603:10b6:408:e3:cafe::3b) by BN1PR14CA0014.outlook.office365.com
 (2603:10b6:408:e3::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28 via Frontend
 Transport; Mon, 6 Mar 2023 22:43:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF000108E8.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.13 via Frontend Transport; Mon, 6 Mar 2023 22:43:30 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 6 Mar
 2023 16:43:29 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: fix warning in SVM debug statement
Date: Mon, 6 Mar 2023 17:43:13 -0500
Message-ID: <20230306224313.891082-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000108E8:EE_|DM8PR12MB5495:EE_
X-MS-Office365-Filtering-Correlation-Id: 12d9ab3a-a76a-468d-b0b8-08db1e943579
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x4TgFSI311FLkFQiuY8e8pQW8HnGlmfsYuGP413iFzYZt/mid0skY5N+lvbFELVtNX+ZvZRZHjpXvCtZ4oXntN2S0xMzG7VVbBtQml+tzcLTmAR8h5Se96aQ2tw2xq3y3AGLS0CNGJCMd9rulDBO/eKpXdiD3TPi40CoxS1mPkdPcX5yy6C4OnIKWtrh72lcNQ9r7aBGtnsiGHS/1MXecIEt78VnJYBBGIMveH0M3M6egHYGGO7NwFEPOgMJ+lDWIzopMKJSj5cGGgWuU1PoTyNO4myMNTGGxysgrG+cCYR+n+UFfyaSSnOAtyVcT2vD7SnO7BCKdhkr/7xU/IiiYSJ1Pyl0iyDCr6S3esum0gcutO2hBiUeemJWqRgFQm9G/SAmh7Uxte3I2niYC0GDMe12Dn+NZmcKAcjH6dIw637oeFe0n3YKUCdY2InTeppWkKyqQnh07Ra9Hak2yz4Z35zlzAAP37yry/JEuYWuCZtuTuMIns3RsyCO0ROAyPwZMc5QEljI6ydr8GWwQEu6L4SfSW8mXJgcroJvwgBnXyKpYmR4I+TZlG8kKDWKRAO2/yQLhkWMfX1DOXQ7JfHP/ogSRdAtt7q38cwH0RyK9OBVyKRGtXYbDqubRctKYO6zUt3L0D7lZBp5x0plvaPykTTtnyiobFrxSMBxpOLuiZU3fMsalxJz6cf8wxEt/uyv12epSPzXyDfD5Mz+B/88js+K9L7eHN5xYs//OQ89JqI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(346002)(39860400002)(136003)(396003)(376002)(451199018)(46966006)(36840700001)(40470700004)(1076003)(6666004)(36860700001)(426003)(36756003)(47076005)(82310400005)(40460700003)(356005)(83380400001)(81166007)(40480700001)(86362001)(82740400003)(16526019)(336012)(186003)(26005)(2616005)(41300700001)(70586007)(70206006)(4326008)(8676002)(6916009)(2906002)(8936002)(5660300002)(7696005)(316002)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2023 22:43:30.3749 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 12d9ab3a-a76a-468d-b0b8-08db1e943579
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000108E8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5495
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Print a long long value.

In file included from ./drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_object.h:32,
                 from drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_migrate.c:29:
drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_migrate.c: In function ‘svm_migrate_copy_to_vram’:
./drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h:35:21: warning: format ‘%lx’ expects argument of type ‘long unsigned int’, but argument 6 has type ‘uint64_t’ {aka ‘long long unsigned int’} [-Wformat=]
   35 | #define pr_fmt(fmt) "amdgpu: " fmt
      |                     ^~~~~~~~~~
./include/linux/dynamic_debug.h:223:29: note: in expansion of macro ‘pr_fmt’
  223 |                 func(&id, ##__VA_ARGS__);                       \
      |                             ^~~~~~~~~~~
./include/linux/dynamic_debug.h:247:9: note: in expansion of macro ‘__dynamic_func_call_cls’
  247 |         __dynamic_func_call_cls(__UNIQUE_ID(ddebug), cls, fmt, func, ##__VA_ARGS__)
      |         ^~~~~~~~~~~~~~~~~~~~~~~
./include/linux/dynamic_debug.h:249:9: note: in expansion of macro ‘_dynamic_func_call_cls’
  249 |         _dynamic_func_call_cls(_DPRINTK_CLASS_DFLT, fmt, func, ##__VA_ARGS__)
      |         ^~~~~~~~~~~~~~~~~~~~~~
./include/linux/dynamic_debug.h:268:9: note: in expansion of macro ‘_dynamic_func_call’
  268 |         _dynamic_func_call(fmt, __dynamic_pr_debug,             \
      |         ^~~~~~~~~~~~~~~~~~
./include/linux/printk.h:581:9: note: in expansion of macro ‘dynamic_pr_debug’
  581 |         dynamic_pr_debug(fmt, ##__VA_ARGS__)
      |         ^~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_migrate.c:302:9: note: in expansion of macro ‘pr_debug’
  302 |         pr_debug("svms 0x%p [0x%lx 0x%lx 0x%lx]\n", prange->svms, prange->start,
      |         ^~~~~~~~

Fixes: b752374fdf3a ("drm/amdkfd: Fix BO offset for multi-VMA page migration")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index ad109403b5cc..391da6acb3e5 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -299,7 +299,7 @@ svm_migrate_copy_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
 	uint64_t i, j;
 	int r;
 
-	pr_debug("svms 0x%p [0x%lx 0x%lx 0x%lx]\n", prange->svms, prange->start,
+	pr_debug("svms 0x%p [0x%lx 0x%lx 0x%llx]\n", prange->svms, prange->start,
 		 prange->last, ttm_res_offset);
 
 	src = scratch;
-- 
2.39.2

