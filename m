Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70F33EB64DC
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Jun 2023 21:10:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC1C610E596;
	Thu, 22 Jun 2023 21:10:55 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2051.outbound.protection.outlook.com [40.107.100.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C992410E062
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Jun 2023 21:10:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kXpUjUINAOVrHc54YsRIS+nL0t+PAN2JQw0b+u0FwgkU3tPfiYRqS4RjrHfl8LlhlLlo9+GC95v7339+EjmsJ7D0W3yEH6QwDanPUzu5NXyfFhfjW38rQED9x5NxLzhUJvFrt8q1RDK5DUlDTuqziFvxqwKHQfkHys4EGx6En2oxK38T43jRon8lRrZuaRCpNxU/dWiOwqJLYyonbJqYyL0f5d5dpXXOn5sPiMdRyRQHhnBdd7ImX4zLBoS5Dlf1NyZqrna9KvKGsGwOUr7qiyKWQ4M+oA3Y4ukKxeJtWprNl7sv49p960M+JgfVB9oGLBrPAwEd8MA50sQzRwA7aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KUYBLPKdH7A8LoX/T1McDLq4Kym0hhAZDJVqvGunLlw=;
 b=hg94Xae55rMRuaKIZ6TLSPF+3B+yccQMd8Dq1AOYf6JOkNGaZz9WPXaSGOZb5FEVKN+kLS85hishRP2mQ9WQ7sj1apKfbdtz41ECymFe395VJajsXG5xsQ0gT6ruoT3OYiH4q5kpBCQSD7pX+wdF7Ip5U/OdGVnunRowQbSJhefGUZ7PTnZiV1zNoypGMQ+MxGO2vm5l1OXQVCDHZMpTD7v9UH2cf5yOZTecwF+AorIS9UnQ9LVWwxKb93TFjYCtjiFNM7kB2uGTAZTgtIWtv1rwfedW0XwFGGx2AlnqEjKFnsazHs9LrBUZOFkOQsrtztbtxsjHNc6AvljVona1/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KUYBLPKdH7A8LoX/T1McDLq4Kym0hhAZDJVqvGunLlw=;
 b=AL5AqRpWbeJVabGIBy45lE8+BCU4/th9KI5YSoX7wmyo37PiCFc2qZeldqts6cDun5ENBDm3G6U0oGAqHiwYWsLTSsXo0M/2/hkSk1OwnCfYiD+5eDkPjGF+Mu/mQ3UYFZrUi6R6D4jfVLtMM3+3NYshumxnPnAAX1wuzdSzM7I=
Received: from MW4PR03CA0193.namprd03.prod.outlook.com (2603:10b6:303:b8::18)
 by CY5PR12MB6322.namprd12.prod.outlook.com (2603:10b6:930:21::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Thu, 22 Jun
 2023 21:10:51 +0000
Received: from CO1PEPF000042AA.namprd03.prod.outlook.com
 (2603:10b6:303:b8:cafe::94) by MW4PR03CA0193.outlook.office365.com
 (2603:10b6:303:b8::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24 via Frontend
 Transport; Thu, 22 Jun 2023 21:10:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AA.mail.protection.outlook.com (10.167.243.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.17 via Frontend Transport; Thu, 22 Jun 2023 21:10:51 +0000
Received: from KfdLnx23.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 22 Jun
 2023 16:10:50 -0500
From: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [patch V2] drm/amdkfd: Access gpuvm_export_dmabuf() api
Date: Thu, 22 Jun 2023 16:10:41 -0500
Message-ID: <20230622211041.3863864-1-Ramesh.Errabolu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AA:EE_|CY5PR12MB6322:EE_
X-MS-Office365-Filtering-Correlation-Id: 98acd7eb-9294-43af-9103-08db7365289b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vMjsFIUseyzJ/TlLe6hBkMzQ+uZf5cLapzXxfDuQuTTLrb3lUMLLJt8HxFQKKlYFB8uWRlT2h79RyqnvRDAwNNSiw15VkdZFbjqbIogmqOgzWUkyxJm5R+bRfyUfuPjwA2/sjUilezqVvowezig1CQRi3iPCARYajaDM+d8dpmjB1AsBnWV0SYsHuoQiS5qJ7yF03CChPRrrcdVQEeymb4QQQM7NNZSJkxJvCrxIEcA5BzErRhdm5JqyWy4hKWRXFMG/4yi0txHErgHXrow98J0uw388TPuROCAJZUE/6QAaR9Qj5IjwZNeCqcyCQSfen7PZJ4D4b6r3gdnwPAwR7VSGSAdSjk1IQ6rT4wvvChYkpRLUyH8yMvaVPeqRUZiWtTZfzUNPtl2CV103+9oolaFVizqeq8HSo5aRh7J9jNGh43YbqQp+OGshhg+u6EFAxow77rVISJ0BHdwYKo2oic8SngMsR9suJLSldNmuuz0lU65Z7w0LHCGxz4OokN42Rtp8toGpGMjm8t1wylVjtiWqWO8hZPEgr6tZvZExWOpSltFAcA13dzOsNeZN+7gGt9J5MUVXsoR67wSDzSoHs2N8V+aIfxOKema9tfEM/4QbtjK8yILQP3hYpgLTwGtf2eEpM55GZw3UI8E5bgL7wF5d4K4rYsS2ZmpcUNUl+A+EIsvOtp8o/0fPdclFwZxaVETduOA42ARfwFQcqcaTTJ8HtUbzM7aFdXj9th8XcTrnxRx5ET5rZzyDVI8YfrmXSoUsx2eHTOJdj75nSkhIsQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(396003)(346002)(136003)(39860400002)(451199021)(36840700001)(46966006)(40470700004)(26005)(83380400001)(336012)(426003)(1076003)(5660300002)(2616005)(16526019)(186003)(47076005)(41300700001)(6666004)(8676002)(8936002)(40460700003)(7696005)(2906002)(36860700001)(70206006)(6916009)(81166007)(356005)(40480700001)(70586007)(36756003)(82310400005)(478600001)(82740400003)(54906003)(316002)(86362001)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 21:10:51.1513 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 98acd7eb-9294-43af-9103-08db7365289b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6322
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
Cc: felix.kuehling@amd.com, Ramesh Errabolu <Ramesh.Errabolu@amd.com>,
 rajneesh.bhardwaj@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Call KFD api to get Dmabuf instead of calling GEM Prime API

Signed-off-by: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index cf1db0ab3471..40ac093b5035 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1852,15 +1852,14 @@ static uint32_t get_process_num_bos(struct kfd_process *p)
 	return num_of_bos;
 }
 
-static int criu_get_prime_handle(struct drm_gem_object *gobj, int flags,
+static int criu_get_prime_handle(struct kgd_mem *mem, int flags,
 				      u32 *shared_fd)
 {
 	struct dma_buf *dmabuf;
 	int ret;
 
-	dmabuf = amdgpu_gem_prime_export(gobj, flags);
-	if (IS_ERR(dmabuf)) {
-		ret = PTR_ERR(dmabuf);
+	ret = amdgpu_amdkfd_gpuvm_export_dmabuf(mem, &dmabuf);
+	if (ret) {
 		pr_err("dmabuf export failed for the BO\n");
 		return ret;
 	}
@@ -1940,7 +1939,7 @@ static int criu_checkpoint_bos(struct kfd_process *p,
 			}
 			if (bo_bucket->alloc_flags
 			    & (KFD_IOC_ALLOC_MEM_FLAGS_VRAM | KFD_IOC_ALLOC_MEM_FLAGS_GTT)) {
-				ret = criu_get_prime_handle(&dumper_bo->tbo.base,
+				ret = criu_get_prime_handle(kgd_mem,
 						bo_bucket->alloc_flags &
 						KFD_IOC_ALLOC_MEM_FLAGS_WRITABLE ? DRM_RDWR : 0,
 						&bo_bucket->dmabuf_fd);
@@ -2402,7 +2401,7 @@ static int criu_restore_bo(struct kfd_process *p,
 	/* create the dmabuf object and export the bo */
 	if (bo_bucket->alloc_flags
 	    & (KFD_IOC_ALLOC_MEM_FLAGS_VRAM | KFD_IOC_ALLOC_MEM_FLAGS_GTT)) {
-		ret = criu_get_prime_handle(&kgd_mem->bo->tbo.base, DRM_RDWR,
+		ret = criu_get_prime_handle(kgd_mem, DRM_RDWR,
 					    &bo_bucket->dmabuf_fd);
 		if (ret)
 			return ret;
-- 
2.25.1

