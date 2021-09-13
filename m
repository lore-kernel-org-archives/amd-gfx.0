Return-Path: <SRS0=miQW=OD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B4AAC433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Sep 2021 20:11:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10C1A6108B
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Sep 2021 20:11:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 10C1A6108B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B245C6E241;
	Mon, 13 Sep 2021 20:11:20 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2088.outbound.protection.outlook.com [40.107.94.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC2BF6E241
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Sep 2021 20:11:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OhD0nE7ff3VI6wSNv95LXqrStYIanICCOwtT+VeCl2nJK/6iTIl3gstPO5phLY4V2nFYEzj1LmPc2FzRdYfD0e7PBjNG4sRCtYlM1bQC0mfhSkmLTGMlaEWxVYLK9Y3ORTiY/frmoYs/9gyxCAfR5ujCgsTs+rkZwQlSi/FvCzl7Sa83nL0Dzz1IYNPzFJmLsi2xk9WHhI1b9ERe0Uj8d0oXaM0SLPztnHkpHEdkqWw9dkCCqpFWtDu1GzGmZytsjY+XCjyL2Zb4m1upKdG8PP0DYqLT+9gX5NpPJdBDHIv5o+ypFmBgHA3A1aGekcETBZN5Qo/IpzPrjm/SfHexpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=YmqLTeI7sAyK4DmvLr7v8ayZ3vop9W2L8qSF+LJNHAc=;
 b=Wfy1fqNwbU+xuyW6Y9RWpO9m3LDm/TfxQ/Rfne9x7FnTfNk077KpGah0Nw3ZCBibHQNpuWFo/zGcCqHEeVuocyRKJ0Ecur1xQFT9UqSWDPupfN48M0ztW06lYCCAizOKWzCJwYK1QlDIi1q+02pka3DoUlkYRQ9rLoCVYdrLaAIyx0+lQorl0RijARgBgUtGWEqufyFic+FkpY7gs2Y28vo5x+ueYiyQNgLBrIEGDyvOm6UpjedlJOwPpUTtmBujeiqgKu8q89ulbE/pSES5RodFKEg3v5XMYM9Ibt86RUIO03uIrOr8fzX//cpQVXxVopKemUHtNVjnVcOFhw9Jnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YmqLTeI7sAyK4DmvLr7v8ayZ3vop9W2L8qSF+LJNHAc=;
 b=TK+LzrKjlQows+nktky6eqOWQ+g35VYwG2xEnAcRoGrK+zVFGN4aBrKKDs3FNWC4pc64MdfK3qbmtV8ByfCS81P7oiYpQa4kjXOnSQln9lPiHq2IzOGhZ+0Ib7Ki6lv9XIYtrA182HDKMsYYnc4cvAn0lll5/kDRMmriOioe2x0=
Received: from BN6PR19CA0077.namprd19.prod.outlook.com (2603:10b6:404:133::15)
 by SN1PR12MB2589.namprd12.prod.outlook.com (2603:10b6:802:2c::32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.15; Mon, 13 Sep
 2021 20:11:16 +0000
Received: from BN8NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:133:cafe::8a) by BN6PR19CA0077.outlook.office365.com
 (2603:10b6:404:133::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend
 Transport; Mon, 13 Sep 2021 20:11:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT029.mail.protection.outlook.com (10.13.177.68) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4500.14 via Frontend Transport; Mon, 13 Sep 2021 20:11:16 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Mon, 13 Sep
 2021 15:11:15 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Philip Yang <Philip.Yang@amd.com>
Subject: [PATCH] drm/amdkfd: SVM map to gpus check vma boundary
Date: Mon, 13 Sep 2021 16:11:00 -0400
Message-ID: <20210913201100.27146-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 82e39d29-27fe-4a32-a819-08d976f2a4b0
X-MS-TrafficTypeDiagnostic: SN1PR12MB2589:
X-Microsoft-Antispam-PRVS: <SN1PR12MB258972BC197C2279C178C524E6D99@SN1PR12MB2589.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YhaCbsw9hazGl+fcXD1MLNPDqNiggbVPSUoF1goEjk2QOFdmFPAFZOVUhQ0V1dU1DbOkHXLTHdcKmm6wnqxFITBRqOQd4bljJJR+m1vh/izSj4rde3Ye7mTjf/zMkgq1mAFh67zhkdUyHgwtUBeUvqGoPwZIexH59wGD2GTSdTwMTtDFYcNX7Gie2t3uDtnJJRgtbN2CEYhMDZabaPzloTHDWR6LT4H+0Qx8zoGR5waE88tfeJdI0sYXyUoycQpq+OPar+iD/s646IReZGl6lU5PYnT7gi41NaxYuWf6kUqf/wHW0oLALFuQ5dE8lrG1pc+NQsep/9LrYwfI9GDo8jyn7Yg8nCExzHXW+D56essrsQIaM5TNCzRg1WoYJjrvhqGyd/AqthN2qRvMuqPorGD8UlyWMj0cQuYGMpgPMZalqWwf9Ux7euz6VQmmw41QXj3zNLTsJ//325TuAdm+scpj6X6Luo9ml01ZeO+JevQLXy6H6fJhTSuZMNMSdWQYPmHXOzBqfEYZtE4Sdict6uo6UsxoC87T+GRK/QH+Voi0fTg3J2NDBmU8BrBjKTDpJxqJ9ILIFeZkCY91fh8zJ5plSaPn4uNGR8W2b2HW8/yrBufKTxGCgsdNB0mYN4oMU1pRGxf97dp3gNfwlFeg7KIQMCfTS6vgP1UCZ6XaHLviwz2ufdGWZcEAv5nkagsd984Skg+k8jWxIW0/MJmOG9H0VPwG6kRpF6Dh0ELU2E0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(346002)(396003)(136003)(39860400002)(46966006)(36840700001)(36756003)(478600001)(1076003)(186003)(70586007)(2616005)(16526019)(83380400001)(47076005)(336012)(2906002)(36860700001)(81166007)(4744005)(356005)(426003)(26005)(8676002)(70206006)(316002)(6916009)(7696005)(82740400003)(4326008)(8936002)(82310400003)(6666004)(5660300002)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2021 20:11:16.6410 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 82e39d29-27fe-4a32-a819-08d976f2a4b0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2589
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

SVM range may includes multiple VMAs with different vm_flags, if prange
page index is the last page of the VMA offset + npages, update GPU
mapping to create GPU page table with same VMA access permission.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 110c46cd7fac..2e3ee9c46a10 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1178,7 +1178,9 @@ svm_range_map_to_gpu(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	for (i = offset; i < offset + npages; i++) {
 		last_domain = dma_addr[i] & SVM_RANGE_VRAM_DOMAIN;
 		dma_addr[i] &= ~SVM_RANGE_VRAM_DOMAIN;
+
 		if ((prange->start + i) < prange->last &&
+		    i + 1 < offset + npages &&
 		    last_domain == (dma_addr[i + 1] & SVM_RANGE_VRAM_DOMAIN))
 			continue;
 
-- 
2.17.1

