Return-Path: <SRS0=N7Ef=ON=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9812C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Sep 2021 09:44:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B710F61107
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Sep 2021 09:44:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B710F61107
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 369656E116;
	Thu, 23 Sep 2021 09:44:27 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2065.outbound.protection.outlook.com [40.107.100.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 086766E116
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Sep 2021 09:44:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hmf2etkLxb4CjcuFoK+AMCPurM6eJAieKKiO0bOUDRFSdFyHU4uN/2Wrm1VI9fOqLUosJDcBQ4uffR7rskRGFsP9NK96LwH3fV46fRVdC8zDQ39AGcCc/SF/eGASP7RHhrQ8/tzOPHIq3Hyn3NxZWY2AxEsE03u7NPkXggVvqeHNEt2w06eUQxaWFA5POuct/Cch8mhIcrNTel03hD13O1KvsXdi8rHELL4RPh/ssGiG/eDdfGYR6Ajvzgoz3FIveEt5kxs/TKJennetN5/t0Vr/o8D6Ti4Bma79W0wC9GkRJUUQKz0p2Ct0nl+3GG9LGvVuxsRtar2eYqa4zkD0hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=dnqiNk2muI9HT6XEEGvf0zuuZ5MIIJHJtc3jfoAftHY=;
 b=QNV7ElRspBI8Tgp/pTOVVeIetZWndcaXyAM08L5lH0mzF42F9mVt7GJsg9ECbjCggTajhUPLpa5LcWK/LVKUlWjtCQPa73KxVHqo07/lMS8BFsT2ZeFX7l3EmWCHvqylDswbsboXhosc98Bxe3uM+Ah3N56ZIar2F5TiqrfSYXtsHPiNcnQS5eDhXEvUsesL+ykEz4ye4yt2TiNKy94swlAx1vQCOi7sPw7pivDVJGrjtqcCUBd6mzfT/A6E0x/GtT5nYnIbS7EqDM7qaukcG0rUrHTRJSvEdGYQ2zhPst7UTQIRBGp4uz5FdmGDx0E7oG4hO6uL3DvOs/cvzJ12sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dnqiNk2muI9HT6XEEGvf0zuuZ5MIIJHJtc3jfoAftHY=;
 b=QeOAKV9Xn2R6/kWslh2P4hI4SFeWWheKfJEtQrAVVA8zETUuTkYBYlZPNVw4eE9immxRopbqBKYcvZKuOCIwwBOLzxZy4wrbYJeNw0mYSZmzyjsWevyobWQhQKm/tnRAER3FPIfiDZnLM6qOkFj4jF9R27HUfmrrXJIqDWMl83M=
Received: from MWHPR04CA0034.namprd04.prod.outlook.com (2603:10b6:300:ee::20)
 by BY5PR12MB4097.namprd12.prod.outlook.com (2603:10b6:a03:213::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Thu, 23 Sep
 2021 09:44:22 +0000
Received: from CO1NAM11FT059.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:ee:cafe::d9) by MWHPR04CA0034.outlook.office365.com
 (2603:10b6:300:ee::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend
 Transport; Thu, 23 Sep 2021 09:44:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT059.mail.protection.outlook.com (10.13.174.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4544.13 via Frontend Transport; Thu, 23 Sep 2021 09:44:21 +0000
Received: from lang-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Thu, 23 Sep
 2021 04:44:20 -0500
From: Lang Yu <lang.yu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Felix Kuehling <Felix.Kuehling@amd.com>, Christian K nig
 <C3B6christian.koenig@amd.com>, Huang Rui <ray.huang@amd.com>, Lang Yu
 <lang.yu@amd.com>
Subject: [PATCH] drm/kfd: fix ttm_bo_release warning
Date: Thu, 23 Sep 2021 17:44:05 +0800
Message-ID: <20210923094405.144613-1-lang.yu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5e9feec1-0651-4387-883f-08d97e76b8b5
X-MS-TrafficTypeDiagnostic: BY5PR12MB4097:
X-Microsoft-Antispam-PRVS: <BY5PR12MB4097F9E9A15ABF98D80ACA44FBA39@BY5PR12MB4097.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:660;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7BQ/5FOBlGma+pi2RkI5SsbeCZzf7DCYknhZ5EtSyDG22pKyY2ZCMf90pyQM3i/otx0vkIm2aFeqAwxzyjowjKzh6zyGPufReBCLTIzbNausavDWYNuCJd9zkut/LJ5TgXsBYHfH5yiPwaHSQTSpI1c2AQ0Wr+73GYvzMvZTBI/xZcA8OZv/rTA4E4aodIiS3yph45hW+IKXM0eCsO5bdHLRDAmZRlzN2rPYJc5ZmmRRMwCmaa4Y8BTz0/+SUityuBU5qR5G029Av4Msw4QwxJ5fVXzEQ0UkjbfiAu8KICN6Q7L2aqdyaZiUtRVanfGBQpzsfI45TcsKwPBPEzy8JlbwllmLGoAWQke01CKu2CQQfT6qFPUve0Qx85YVxFxda1TR3YG0Iy8XvG5rZzmQuRryOGrORZdmqaRniLXIwngda5E6+t1p2Frxb1tvYYGTfNWhm04czfV113U0daKMeTzz72W+fqzSVtdzGlK3wPiHVWUN0787BP9BlefVGbBffr+7MCzQ0YTa61zXDy8f+WDJDug6iNfTpv5c24JMlUTdygUgkot97bx8MG1wbRnOAw/tqzOX+bFJPCbHDlVXmDqhHZZhBEtbx69kO/sxwRi2EHmpVuTume6gw5WNn5uYqFndW2vMb2HGzdyiaXvtLA8fzobIMGpZMHgHSYCOGxoQ8dMcgafpM8vDdJ7EHoofeqjjqAzaODNzfi8gcmech9wE2jJ4ytXfwbVkDujqaTI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(8676002)(54906003)(2906002)(2616005)(4326008)(82310400003)(44832011)(1076003)(356005)(36756003)(316002)(7696005)(47076005)(8936002)(36860700001)(426003)(26005)(16526019)(70586007)(6916009)(186003)(336012)(5660300002)(508600001)(70206006)(86362001)(6666004)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2021 09:44:21.8322 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e9feec1-0651-4387-883f-08d97e76b8b5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT059.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4097
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

If a BO is pinned, unpin it before freeing it.

Call Trace:
	ttm_bo_put+0x30/0x50 [ttm]
	amdgpu_bo_unref+0x1e/0x30 [amdgpu]
	amdgpu_gem_object_free+0x34/0x50 [amdgpu]
	drm_gem_object_free+0x1d/0x30 [drm]
	amdgpu_amdkfd_gpuvm_free_memory_of_gpu+0x31f/0x3a0 [amdgpu]
	kfd_process_device_free_bos+0xa3/0xf0 [amdgpu]
	kfd_process_wq_release+0x224/0x2e0 [amdgpu]
	process_one_work+0x220/0x3c0
	worker_thread+0x4d/0x3f0
	kthread+0x114/0x150
	process_one_work+0x3c0/0x3c0
	kthread_park+0x90/0x90
	ret_from_fork+0x22/0x30

Signed-off-by: Lang Yu <lang.yu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 2d6b2d77b738..7e693b064072 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -1567,6 +1567,9 @@ int amdgpu_amdkfd_gpuvm_free_memory_of_gpu(
 	pr_debug("Release VA 0x%llx - 0x%llx\n", mem->va,
 		mem->va + bo_size * (1 + mem->aql_queue));
 
+	if (mem->bo->tbo.pin_count)
+		amdgpu_bo_unpin(mem->bo);
+
 	ret = unreserve_bo_and_vms(&ctx, false, false);
 
 	/* Remove from VM internal data structures */
-- 
2.25.1

