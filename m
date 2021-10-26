Return-Path: <SRS0=fVrT=PO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8204AC433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Oct 2021 15:36:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 442E360F9D
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Oct 2021 15:36:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 442E360F9D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 653CE89B00;
	Tue, 26 Oct 2021 15:36:28 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2050.outbound.protection.outlook.com [40.107.94.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B19589B00
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Oct 2021 15:36:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oLSyXZDSnzFkFCRlQvfGRhUZRQBe83oksqQCf617zL4D3+n1bWeze+RbpjusSxJBj1Nkq89sLX6vfrjv4cEkOdJ6dpGnzTbtd9c7R4W2jJYKtj28d7wNGKnutMCSgGkeCVsBF3Wf2RNMX3BwT8ELlnCb7O8nQXeyTNXQtZC61DMJWhfUr5SllIppJU3BGfSO7ywToXnWDkknzAI8Km02M6dYbJ0dAdy4irqtGmPIWHQoW2bRft9SdNKCXWCnMGBdXabLAoYrVTnW+d0khjc0LeLxcPGFEj10bvipeZUNRxUF3IqsXK0H/H6cLMY8hRH5shWQLV5XTgC7XWDvPW0Y6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=09Cra4mCqLrzYAQ2+gdcNRjZqsNU9nsv81quYo6NfPM=;
 b=iSE4odSdDH0eosbQNmnCzjkcBeCkdThbwlUD//wUie2TTHfh1AA8o37WgvfBi9yRilUmksCFnI6BoB9pYr4JFfjARq16qC3gIsAyqcnHDVj1H182thLYezN5YosueNHmzLUJjza4PaGJiBxqyO7RSlUcnwnRlVZCZMK8GBfLOwLeiNpEFEc3k+UpbKCumQVYIX2hxWgY6LAR73fxpaPEXFtgETcoGCDOUeAqdUtnofmzQtvJiD3kJuilgd8nWjomJxinyeUzTWh1gZ9/74c8mb8k60bW8OMQdq2TCsmyzT4kfCg0O6ygMBX/BCp+hEIJc8J+zEI98RajWLtuuhFpsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=09Cra4mCqLrzYAQ2+gdcNRjZqsNU9nsv81quYo6NfPM=;
 b=lJT/nFVBLKmLoadAjPWBZDqWMql5vYSfzG8KdhVzKM4dLgfi1p7ihmCAbvq1+8U8++nwZUu77PjKjjkCZZiYmFf1KEFx5nWjoeaI4jjSdsCZSGxaYgRtFYj/r5Rgd8dcqDI/H7UNqmL8CuEx7M5SWAsPmlo+/FzvK/VxykSr204=
Received: from BN9PR03CA0697.namprd03.prod.outlook.com (2603:10b6:408:ef::12)
 by BYAPR12MB3319.namprd12.prod.outlook.com (2603:10b6:a03:dc::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.15; Tue, 26 Oct
 2021 15:36:25 +0000
Received: from BN8NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ef:cafe::b4) by BN9PR03CA0697.outlook.office365.com
 (2603:10b6:408:ef::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18 via Frontend
 Transport; Tue, 26 Oct 2021 15:36:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT003.mail.protection.outlook.com (10.13.177.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4628.16 via Frontend Transport; Tue, 26 Oct 2021 15:36:24 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Tue, 26 Oct
 2021 10:36:23 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Philip Yang <Philip.Yang@amd.com>
Subject: [PATCH] drm/amdgpu: fix warning in pr_debug
Date: Tue, 26 Oct 2021 11:36:12 -0400
Message-ID: <20211026153612.474820-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1bfbba64-1ca6-45fa-f64d-08d998965e6b
X-MS-TrafficTypeDiagnostic: BYAPR12MB3319:
X-Microsoft-Antispam-PRVS: <BYAPR12MB331945EE09BF857847C4032FF7849@BYAPR12MB3319.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tmSFXvXWtv2Mmu1BmHZ88J/JO04d7II6pohoF7aUL4dmcGSovKeFc0rkXLR3O4Yc6fBzGXRfN8ZB/mcROdQX8ZLP02nhsi5EqCnnfRMX3sYO/Kg8KLcQc7pVhx82f9bFTC76Sa6zN+WimOVRF8tesU3shT2WGKr1OTKo1K89RrytlVRhdri3440fq6D68U+ujn1rZiw9cj8x7dI9B30UyZgNR9LzrTpTvh+1+BrOVe7B7sanGvNLnJfVTkQ/y8uCGjk81GkGFgp3GARYNoNFonMBtJb/1txnzupvjYNB+JwF3Wn5UQ67cU75OufxIgCKN2EKKrb3N2mDfGnDVKfSnAiByO/ge0FyUIn4lsQEfjU6NDcham2wos8bwJp1HgCluYI3tsQb6tap+Mz1uSMHBudVwFlrVO8wC0x+9vtH6ORSzyvBmlmtM3t0pw3WNhv4Ti4HPGe5DVaDb3OpaATxW8QUonTHEZ5VonTUtWpQR49rJwAQ6fsje7kIN8hNRJvedv7Du5mrJZuxMAPZHs8Uq0Nc8aaXwJuTfjtOgYwuIKvZbSJyOqWRexHrsvKN6Gf03hhd46qKFOQpL77Zm9Z2NxJoTK7kawM9ld4X73ffaq3zQmC0XBxmydlpBrfkHeLLMVRMgx3hnAsF7agSUc/LGDO9SO/Ijs07H/dq+q63RnuBQ+5A8qLFljwxhRjJ2QUp3yfzq3/8RckCCAE27fP7hKTmPFgzYQewl2dNHE1gN5w=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(86362001)(83380400001)(336012)(2906002)(5660300002)(8936002)(36860700001)(186003)(2616005)(36756003)(508600001)(16526019)(6916009)(81166007)(7696005)(356005)(54906003)(316002)(47076005)(26005)(70206006)(70586007)(6666004)(1076003)(4326008)(426003)(8676002)(82310400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2021 15:36:24.5846 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bfbba64-1ca6-45fa-f64d-08d998965e6b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3319
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

In file included from drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c:52:
drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c: In function ‘amdgpu_ttm_tt_get_user_pages’:
drivers/gpu/drm/amd/amdgpu/amdgpu.h:35:21: warning: format ‘%llx’ expects argument of type ‘long long unsigned int’, but argument 4 has type ‘long unsigned int’ [-Wformat=]
   35 | #define pr_fmt(fmt) "amdgpu: " fmt
      |                     ^~~~~~~~~~
./include/linux/dynamic_debug.h:134:15: note: in expansion of macro ‘pr_fmt’
  134 |   func(&id, ##__VA_ARGS__);  \
      |               ^~~~~~~~~~~
./include/linux/dynamic_debug.h:152:2: note: in expansion of macro ‘__dynamic_func_call’
  152 |  __dynamic_func_call(__UNIQUE_ID(ddebug), fmt, func, ##__VA_ARGS__)
      |  ^~~~~~~~~~~~~~~~~~~
./include/linux/dynamic_debug.h:162:2: note: in expansion of macro ‘_dynamic_func_call’
  162 |  _dynamic_func_call(fmt, __dynamic_pr_debug,  \
      |  ^~~~~~~~~~~~~~~~~~
./include/linux/printk.h:424:2: note: in expansion of macro ‘dynamic_pr_debug’
  424 |  dynamic_pr_debug(fmt, ##__VA_ARGS__)
      |  ^~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c:697:3: note: in expansion of macro ‘pr_debug’
  697 |   pr_debug("failed %d to get user pages 0x%llx\n", r, start);
      |   ^~~~~~~~

Fixes: 702dde19d4b0e7 ("drm/amdkfd: restore userptr ignore bad address error")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index ae6694f2c73d..881a91a6ab13 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -694,7 +694,7 @@ int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo, struct page **pages)
 				       ttm->num_pages, &gtt->range, readonly,
 				       false, NULL);
 	if (r)
-		pr_debug("failed %d to get user pages 0x%llx\n", r, start);
+		pr_debug("failed %d to get user pages 0x%lux\n", r, start);
 
 out_putmm:
 	mmput(mm);
-- 
2.31.1

