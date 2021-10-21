Return-Path: <SRS0=oZ58=PJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDB47C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Oct 2021 00:47:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8439660C4C
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Oct 2021 00:47:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8439660C4C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 25ED789D8E;
	Thu, 21 Oct 2021 00:47:42 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2045.outbound.protection.outlook.com [40.107.93.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB52E89D53
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Oct 2021 00:47:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ALtebQXa8AOJLfwNmf3SC4pvBQY2hUbzCZGKqekwPvirgai5n523BgGPrZI2qGlJHFEuz6mFOJ7LenFu9FyteUVhJm0o+5HQ+NnzXMs1U1NGUJni+LD3xb4ZmQfLG9/mDH8cWxBMf1PQRzia9ij4OTK5ZtPPaZ+/EimIGvm/nmjSGSBTK8YsmaH1oQZwRa7N8UGLmt5EtjnESKVwVzJbj6QXUwlZww6BDr8XiTghHWVgMHJwZaOuqAup95nzE5N88iedFSSXfGJYhPfiJl/1aO0Xcf7cbLUlNs5kb8r+QAy12zHnscu6BXzg0iN99UywVwtH56RrTdRUz/1zO2fWsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kK9BRPjdtBX39vkYxKDcLJKcbvhpmXcrTU1D0Clpz6Y=;
 b=IT3KS+LCyGsL3q/O6/zVRCZua1EEQ1CwWa1PhWLQ351Au6YeIrZzd7WymTamXIIaJ4/rHV+xirQXrzUzdUyJr+GyO9Ls5W1AVckjUK5GstbmLyuzY0k8IifixMxllkzVBPuPKUr8VqisWToQufDazIImzSaT8YcV1vycWZnd2JJjvAXo3q1BM7Yg3iX41KFFsSMd+SEkVY1XtBFYfNjfB3a3djvzWfVb4Ao3YLEMXLs7exSP/vAUHGS0+oo8Nd7JYLQQ8/YCmkNFoPkSW7sWjkiJYF/OpgNYwoIPIZqyFVdaVpC+TQY8z0WOCqw8utvkYwG6DjIsref8dqF1N3C14Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kK9BRPjdtBX39vkYxKDcLJKcbvhpmXcrTU1D0Clpz6Y=;
 b=Ad+YC4Ek7PGyjPdBeCpTAFdKuNuJ+5OyqNosxfD0VZiW/i3unhBUt43Om9EB19CYW1EmGBuWZuMBC7bNZwHjGfFwiAc87ogX2JWcvwcdx8VOCw+oUbl9T4U9Kc8BsE152zj+ZQIhT6fXn3mA500OAxiO1gPPtJ+ntKOynYOvxvA=
Received: from DM5PR16CA0025.namprd16.prod.outlook.com (2603:10b6:4:15::11) by
 MWHPR1201MB0272.namprd12.prod.outlook.com (2603:10b6:301:52::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16; Thu, 21 Oct
 2021 00:47:37 +0000
Received: from DM6NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:15:cafe::c6) by DM5PR16CA0025.outlook.office365.com
 (2603:10b6:4:15::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16 via Frontend
 Transport; Thu, 21 Oct 2021 00:47:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT018.mail.protection.outlook.com (10.13.172.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4628.16 via Frontend Transport; Thu, 21 Oct 2021 00:47:37 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Wed, 20 Oct
 2021 19:47:36 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Philip Yang <Philip.Yang@amd.com>
Subject: [PATCH 1/2] drm/amdkfd: clarify the origin of cpages returned by
 migration functions
Date: Wed, 20 Oct 2021 20:47:18 -0400
Message-ID: <20211021004719.15575-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e7ba9db4-eed6-465b-90fb-08d9942c60ec
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0272:
X-Microsoft-Antispam-PRVS: <MWHPR1201MB02720F1EBE57EDFB7EBD57BFE6BF9@MWHPR1201MB0272.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2MYIEF7yzrlgOWdm5bZr58QoaK7kFyTYbEzltqSrBVHxqWlWs9OezbrBya90Ty0IEBUqJEzs1ua7srPZXQBd+Jnn8ZL1hDmxpttRaS54Fa+RP0BancrTcVCTqEJYpl3KPxxn4uMOHbtVqYpTMlvaXAihXizMFvFThKTrinS/MNK4ITjf+T1YbuMe6wk/G+xQcSrEnPcf+iHFjGZy8VE0rAdHFNzfscmSBWbfB9EHVr97wIcmRjESmbeqxefLRGtKq4LU620PI5MdDuoyc/6kC9YZWfuat1619J1jC+Dbg6fkSPjpKAP7w84yGm3CJydpZdheu8PDHDyXdWeqBQ5kB5vGO3uFAaAwK2jrdknBD28Av0HNvGYCX8vhJcMFOAIW84fEFkk4THV3tO6THBfP/wxilfXwMPorOMpdkF2nUgwK96GpMubuPJBCNKJTuRD+M5d2E1RnMzQh7Ms0mAnJ2odgPKLk2iyKtkqlJGWrHEyZ3Z4o5Mh/pSK6yB5gcnJ5U+lsU2R8VHVBg2O5Igj3CggeXVHb3HLhnLhHOs7I6jU92F7ENkDx+uHFfm6ybmvMb1gd3169vKaUiQAzVHv8pkhEAuikiQyF9jQKQNRhR44X5srzccjmjaVf0sW1HolOL5qjLg4DFY/7V+P+dTS/XlbrOvGGV76AgWp7Gx1o+sgnz2UGRXotrnlYyGBgcTvPwCalCczJGmqA7zZhdVel9mGOz+79FHrMd6hnnhyNHeI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(316002)(6666004)(5660300002)(426003)(8936002)(2616005)(81166007)(2906002)(86362001)(356005)(336012)(26005)(82310400003)(47076005)(83380400001)(6916009)(1076003)(16526019)(186003)(8676002)(7696005)(36860700001)(36756003)(508600001)(4326008)(70586007)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2021 00:47:37.4024 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e7ba9db4-eed6-465b-90fb-08d9942c60ec
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0272
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

cpages is only updated by migrate_vma_setup. So capture its value at
that point to clarify the significance of the number. The next patch
will add counting of actually migrated pages after migrate_vma_pages for
debug purposes.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 43 ++++++++++++------------
 1 file changed, 22 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index 147300a161d0..a14d0077e262 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -385,6 +385,7 @@ svm_migrate_vma_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
 	struct kfd_process_device *pdd;
 	struct dma_fence *mfence = NULL;
 	struct migrate_vma migrate;
+	unsigned long cpages = 0;
 	dma_addr_t *scratch;
 	size_t size;
 	void *buf;
@@ -414,17 +415,17 @@ svm_migrate_vma_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
 		goto out_free;
 	}
 
-	if (migrate.cpages != npages)
-		pr_debug("partial migration, 0x%lx/0x%llx pages migrated\n",
-			 migrate.cpages, npages);
-	else
-		pr_debug("0x%lx pages migrated\n", migrate.cpages);
-
-	if (!migrate.cpages) {
+	cpages = migrate.cpages;
+	if (!cpages) {
 		pr_debug("failed collect migrate sys pages [0x%lx 0x%lx]\n",
 			 prange->start, prange->last);
 		goto out_free;
 	}
+	if (cpages != npages)
+		pr_debug("partial migration, 0x%lx/0x%llx pages migrated\n",
+			 cpages, npages);
+	else
+		pr_debug("0x%lx pages migrated\n", cpages);
 
 	r = svm_migrate_copy_to_vram(adev, prange, &migrate, &mfence, scratch);
 	migrate_vma_pages(&migrate);
@@ -437,12 +438,12 @@ svm_migrate_vma_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
 out_free:
 	kvfree(buf);
 out:
-	if (!r && migrate.cpages) {
+	if (!r && cpages) {
 		pdd = svm_range_get_pdd_by_adev(prange, adev);
 		if (pdd)
-			WRITE_ONCE(pdd->page_in, pdd->page_in + migrate.cpages);
+			WRITE_ONCE(pdd->page_in, pdd->page_in + cpages);
 
-		return migrate.cpages;
+		return cpages;
 	}
 	return r;
 }
@@ -619,6 +620,7 @@ svm_migrate_vma_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
 	struct kfd_process_device *pdd;
 	struct dma_fence *mfence = NULL;
 	struct migrate_vma migrate;
+	unsigned long cpages = 0;
 	dma_addr_t *scratch;
 	size_t size;
 	void *buf;
@@ -648,17 +650,17 @@ svm_migrate_vma_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
 		goto out_free;
 	}
 
-	if (migrate.cpages != npages)
-		pr_debug("partial migration, 0x%lx/0x%llx pages migrated\n",
-			 migrate.cpages, npages);
-	else
-		pr_debug("0x%lx pages migrated\n", migrate.cpages);
-
-	if (!migrate.cpages) {
+	cpages = migrate.cpages;
+	if (!cpages) {
 		pr_debug("failed collect migrate device pages [0x%lx 0x%lx]\n",
 			 prange->start, prange->last);
 		goto out_free;
 	}
+	if (cpages != npages)
+		pr_debug("partial migration, 0x%lx/0x%llx pages migrated\n",
+			 cpages, npages);
+	else
+		pr_debug("0x%lx pages migrated\n", cpages);
 
 	r = svm_migrate_copy_to_ram(adev, prange, &migrate, &mfence,
 				    scratch, npages);
@@ -670,13 +672,12 @@ svm_migrate_vma_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
 out_free:
 	kvfree(buf);
 out:
-	if (!r && migrate.cpages) {
+	if (!r && cpages) {
 		pdd = svm_range_get_pdd_by_adev(prange, adev);
 		if (pdd)
-			WRITE_ONCE(pdd->page_out,
-				   pdd->page_out + migrate.cpages);
+			WRITE_ONCE(pdd->page_out, pdd->page_out + cpages);
 
-		return migrate.cpages;
+		return cpages;
 	}
 	return r;
 }
-- 
2.17.1

