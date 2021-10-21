Return-Path: <SRS0=oZ58=PJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D437C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Oct 2021 00:47:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED71E61052
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Oct 2021 00:47:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org ED71E61052
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D6EA89DA2;
	Thu, 21 Oct 2021 00:47:43 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2068.outbound.protection.outlook.com [40.107.220.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 05E8E89D53
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Oct 2021 00:47:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q2EtksHSZN290lDFZmKwb6X0RLfloSty9QVMeZfonVgGZT9L1HqwpnNh3zbJI9RWRcfIjyIe0cMMy0aTC/xn0i6s2CIEZ5SQhqU58cAnWZs3KNW1apkWkPI2jJHX7QpiXh371hp7zhwFKq9+TUHg831Ir10cd4o+05tz3utM+4xiNfpS07gbtNDDo1IYrjLGyISkWnYU4nGSl1oTkzhaDe7H/JwNeGuiT9Zcqcp0Lz9fAeAfWs9bJAcwHolAapoQ4DSWlPZld5Mo0xk4NWlXARCnIyk2htn+LrCSo2QAE4NBJB1gFvKmxaER6EoVD5V82oratF1G6JLoojhxQBmT7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=45f2s6+jVEngmyzvRA5nGRWl3C7jRidhQkGKwm9Oqqo=;
 b=ULhEnLpn6ThvoYMG7r40zqBMzHYDZzdrvJvsJev18H5num1g3dSp6kPSStWV/jh34EO4YOZN2RVtQ0Srmn+tpFgKqpMMJqMazN+GOMRYLkuiKHuYoWE//uoTlJV9Ml0V6j70B9tuIopIlozcnvuZGK4VCuwSVplPxs07mZpUW+bPScdLwJAJqhAhMk/stJ/b/dY+ZpKXTCXStnhstiw2rk8deR6aNEDfePDlZlRM5H3AASWCwykbqYKktqYAD3519dZrw9jNQ4CH4rfBA646iWN46+eL7YHjFBPXqjPNEpq7PYLMKqtqfnOSY+nMMaL8b7RAQFQpuQxUG3qIYgy4aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=45f2s6+jVEngmyzvRA5nGRWl3C7jRidhQkGKwm9Oqqo=;
 b=zBAqsgY35ffAzo+EzQ6nBKEVhn5Ro2bfAJBpkA5gu8WA/Ru5pAS5ZgI9xaF10QxW4Vse/PJ5omsHIHFTNcmT1bTAHEKfR4N620DG+D+BsG4NquDG7vW0UVjhuJpllHBKsycvUNoHcymZbS9lLJgBXaMKK7885GBq3r9SEBZpzdo=
Received: from DM5PR06CA0092.namprd06.prod.outlook.com (2603:10b6:3:4::30) by
 BN6PR12MB1937.namprd12.prod.outlook.com (2603:10b6:404:108::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.15; Thu, 21 Oct
 2021 00:47:40 +0000
Received: from DM6NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:4:cafe::d0) by DM5PR06CA0092.outlook.office365.com
 (2603:10b6:3:4::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16 via Frontend
 Transport; Thu, 21 Oct 2021 00:47:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT066.mail.protection.outlook.com (10.13.173.179) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4628.16 via Frontend Transport; Thu, 21 Oct 2021 00:47:39 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Wed, 20 Oct
 2021 19:47:38 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Philip Yang <Philip.Yang@amd.com>
Subject: [PATCH 2/2] drm/amdkfd: debug message to count successfully migrated
 pages
Date: Wed, 20 Oct 2021 20:47:19 -0400
Message-ID: <20211021004719.15575-2-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211021004719.15575-1-Philip.Yang@amd.com>
References: <20211021004719.15575-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 190ccdd5-1762-4fff-833b-08d9942c6275
X-MS-TrafficTypeDiagnostic: BN6PR12MB1937:
X-Microsoft-Antispam-PRVS: <BN6PR12MB1937695D3943C756AC366FDAE6BF9@BN6PR12MB1937.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 02wP1HR2VpGTSse2ThoxSlcoMzFVlOM4799x/nf+lqjjInIRbI7ccV4PZOte2zEUFeeVjq0A+aolhSgHH6yHB2YT9SNqmhj8N8OzJe51yLc1jJt4eRdV/+MldQ3dQ0Kyax4yT+qceslzUkMGKyVtzQU3O7TLOrSM46m7v6yozWFz6bMJytBommCY6drD9JEdi/6qWRMJEd1i9Vjds6rWh882e0PpAEhMysjSMvJaiIUTtMgxdsiNTboz6EoGX/yJ8I7mrstDOhgYAVfTsvHplgaLzcTBlu2suFz2+sQQ9mGx9kmxXFiymMr1WyBDhPF6Z6lCNTssEraC98pGXmibp/UTlj9vMV2ZZctWoNg/jZ5WrPJMU1mTMl13eUZ0mxySQzqiPUuCJ8BgY8yVzz6rBr2qeHQqd4yYRpcUkeTE4EKWYInPv/2/ITlbwq1RoQOy57czPWEYBdun40nvPdJ2SOlurSVLSmCEZD3uUUCeuAZBy44JBj4u9rgGNGA40DyWBgPfBdLJpyATIV+KqZ7WnBxJQCn2ZnLmlFDfYZBRyD8V4vDttvIa2v9cpM/ym0g9jVgpaAHmkSigJf4q33pEJTiknziQ3CvWusJFG5qEGsHgKCB0TKdfsxZNqImMEFmAzZge9lSgfbXKh3TUK4HOouhS8viTZbnnQOpIOhA/RAYQuOzni6AYQX4achl0T/YUbXDKm4MN0ScVv8fJZkB5Oo7xU5WeMmg3dKRPkk8aPZU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(7696005)(2906002)(186003)(356005)(16526019)(6666004)(316002)(6916009)(86362001)(2616005)(508600001)(83380400001)(336012)(426003)(36756003)(47076005)(8676002)(70586007)(8936002)(15650500001)(36860700001)(5660300002)(81166007)(26005)(70206006)(82310400003)(4326008)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2021 00:47:39.9826 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 190ccdd5-1762-4fff-833b-08d9942c6275
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1937
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

Not all migrate.cpages returned from migrate_vma_setup can be migrated,
for example non anonymous page, or out of device memory. So after
migrate_vma_pages returns, add debug message to count pages are
successfully migrated which has MIGRATE_PFN_VALID and
MIGRATE_PFN_MIGRATE flag set.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index a14d0077e262..6d8634e40b3b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -268,6 +268,19 @@ static void svm_migrate_put_sys_page(unsigned long addr)
 	put_page(page);
 }
 
+static unsigned long svm_migrate_successful_pages(struct migrate_vma *migrate)
+{
+	unsigned long cpages = 0;
+	unsigned long i;
+
+	for (i = 0; i < migrate->npages; i++) {
+		if (migrate->src[i] & MIGRATE_PFN_VALID &&
+		    migrate->src[i] & MIGRATE_PFN_MIGRATE)
+			cpages++;
+	}
+	return cpages;
+}
+
 static int
 svm_migrate_copy_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
 			 struct migrate_vma *migrate, struct dma_fence **mfence,
@@ -429,6 +442,10 @@ svm_migrate_vma_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
 
 	r = svm_migrate_copy_to_vram(adev, prange, &migrate, &mfence, scratch);
 	migrate_vma_pages(&migrate);
+
+	pr_debug("successful/cpages/npages 0x%lx/0x%lx/0x%lx\n",
+		svm_migrate_successful_pages(&migrate), cpages, migrate.npages);
+
 	svm_migrate_copy_done(adev, mfence);
 	migrate_vma_finalize(&migrate);
 
@@ -665,6 +682,10 @@ svm_migrate_vma_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
 	r = svm_migrate_copy_to_ram(adev, prange, &migrate, &mfence,
 				    scratch, npages);
 	migrate_vma_pages(&migrate);
+
+	pr_debug("successful/cpages/npages 0x%lx/0x%lx/0x%lx\n",
+		svm_migrate_successful_pages(&migrate), cpages, migrate.npages);
+
 	svm_migrate_copy_done(adev, mfence);
 	migrate_vma_finalize(&migrate);
 	svm_range_dma_unmap(adev->dev, scratch, 0, npages);
-- 
2.17.1

