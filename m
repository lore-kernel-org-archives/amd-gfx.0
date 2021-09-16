Return-Path: <SRS0=YYL8=OG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 524FEC433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Sep 2021 21:11:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E0E360EE9
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Sep 2021 21:11:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0E0E360EE9
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A1106E8A8;
	Thu, 16 Sep 2021 21:11:53 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2069.outbound.protection.outlook.com [40.107.243.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1382B6E8A8
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Sep 2021 21:11:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wl9HG85Z4N9J7OKRofEUYEjCSpjdWXBlcjNEBGoi8hvi+/5+6G2xV/5ZXMqJJ3+i/RXV6slewHc8PiCF1dxgzLLhtY4OSV69AI+hoc/JBLAViSCSijXMqcaxm1Hgb0qGBbNBhYPtTnsMGYveZFl/0BFFmk8/74hBnM7LmKbybajjeG8G23LXloiQM7ePppgloRzZJ9gFwmJ9oMGkKJjz+OXoQhI/IlF/aMbfCg0tAlDsrmF5uN5E5NTVenWpPxvSgM4W6MEXR5MVNpEfr2TlyXIrB853Geh7ow9H9WOsNw/78X2Ss+Uqqf0vjoCeTWM9q307SXCkOhmydnFnOkOWJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=Mh7EOnm+CARTRFfhx6CGDvmu4SDDtObxgowzMQJr+JM=;
 b=a3tZ7kKyzepX1MdUCEadwF1j65FZAhrRkr6aGJUxhicy/7r/rfmIIUNV+90QsDUA2fBvdQL8Chp+JcGIt4pCaFIk+cdbt4E8BV+1/7JFYOCAIUCkHer8rxFje+ptG9v0RYXeCykHlIWTOx1imnvLxSB+gR7sqrPpgU8Ruif88okyUBSDEpDm6MtsvF97Uz9JC/jc58kUFYGFfpxGNVEG6h8fo+tglmYhfiTBucOsWGCfHxkjvPjFES0YeVyMJbI2X8XZa27nxyvkzs239oOd+rX53T6AaPGjmzVqEXNmIR//UtO2822YcyOBTZfB3DYPs/IFTVKIGtTOyQLf7Bqkbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mh7EOnm+CARTRFfhx6CGDvmu4SDDtObxgowzMQJr+JM=;
 b=dYQL5+ldTWX+0oi4lFrr+2fPHkeAcKNPf6JGhxBtfe9EXhGUdZKJV0ZDavrJdG+Utr8oCrjPBzPLSh+o/fkcIj7GZCMQ6IcyPb8yOUAAdK+4819i4EpnZV/HEabjyD3D66VnIWfeOlFzbWUL2EASY1F4kaAWrOWECnxX0ulpH1c=
Received: from BN6PR1401CA0006.namprd14.prod.outlook.com
 (2603:10b6:405:4b::16) by DM6PR12MB3210.namprd12.prod.outlook.com
 (2603:10b6:5:185::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.16; Thu, 16 Sep
 2021 21:11:48 +0000
Received: from BN8NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:4b:cafe::25) by BN6PR1401CA0006.outlook.office365.com
 (2603:10b6:405:4b::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend
 Transport; Thu, 16 Sep 2021 21:11:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT065.mail.protection.outlook.com (10.13.177.63) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4523.14 via Frontend Transport; Thu, 16 Sep 2021 21:11:48 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Thu, 16 Sep
 2021 16:11:47 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Philip Yang <Philip.Yang@amd.com>
Subject: [PATCH v2] drm/amdkfd: SVM map to gpus check vma boundary
Date: Thu, 16 Sep 2021 17:11:32 -0400
Message-ID: <20210916211132.20341-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210913201100.27146-1-Philip.Yang@amd.com>
References: <20210913201100.27146-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f453a5c2-7f47-4bd1-cd15-08d979569881
X-MS-TrafficTypeDiagnostic: DM6PR12MB3210:
X-Microsoft-Antispam-PRVS: <DM6PR12MB32103698C606E24CB0239ECAE6DC9@DM6PR12MB3210.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sIHhgJS+fIkr4Wxt/q5Lj38pQDbYtzKEmMDZ6d2WXlPm4HeD4Cc8/e4KZ/GKSfUZpTXsvJpenXWDuynvZCRyQGTOz2n1LKBeV38iWne1nzowLSryPtKT/GS3k6R4TfIa2QQyT95hpl+tvXhuHh941Nm5C6NmkwDPOCbLOiokIXMeo8d9Ug7xVYCMTApA9xmYUoo87Bk39TuHiYy3wCjNkgSJcwPeQ/1IlHcm31gu8K5TvT2MUgkGf5y5gZ3u42z79gPSfgbHik1Ga9/SWwXk5K9uJD6RPmQxztr96RfQlH2/4ai0bT4aw/JqAzPLAC8bSxr7Bb7IJkDbgAxT0BcswL7LdyBdkOX9bFfshg1aifwaf+5A93Cl2BP6hcbL0yxk/qkmv2WaBofQ2FNGTcfpHpZvwE+OCb+4qK+XhhNdtIW0Iqx2CmhiTX1CDY3+sa5/WEnFt6bCH5q10KQs8fFfSuX+hPIQ9pyuLYjSXnAoY5xDvDUjvqkvoZGZn9SrSEN3lLO6woFwXz1VrIMsa0n5IEAp69N7cNYuOqRtxHaPZEUVG2AKh9FZVIu21cEhSemvrHrWc1KkX+Eajf9txyaObHaCqF0o1B23W5AJbBkO0DR0iQO+RwejcxMnvVyzQKQBEiuCf0oKkmyXYg0RWjFkcecTyaFLHvdTB4VP5sFwjFuDI35SJ2jbObgBfWJ7AX/sizgBhI+fcc3wmGbKLNL2L+ZzLoQAQPpirzbDziwM03o=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(336012)(36860700001)(508600001)(26005)(16526019)(1076003)(426003)(356005)(36756003)(186003)(82310400003)(86362001)(5660300002)(2616005)(70206006)(47076005)(70586007)(83380400001)(316002)(6916009)(8676002)(8936002)(4326008)(81166007)(2906002)(7696005)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2021 21:11:48.1997 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f453a5c2-7f47-4bd1-cd15-08d979569881
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT065.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3210
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
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 110c46cd7fac..de91c7e83bb4 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1178,7 +1178,12 @@ svm_range_map_to_gpu(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	for (i = offset; i < offset + npages; i++) {
 		last_domain = dma_addr[i] & SVM_RANGE_VRAM_DOMAIN;
 		dma_addr[i] &= ~SVM_RANGE_VRAM_DOMAIN;
-		if ((prange->start + i) < prange->last &&
+
+		/*
+		 * If i is not the last page in the range and next page is in
+		 * same VRAM or CPU domain
+		 */
+		if (i < offset + npages - 1 &&
 		    last_domain == (dma_addr[i + 1] & SVM_RANGE_VRAM_DOMAIN))
 			continue;
 
-- 
2.17.1

