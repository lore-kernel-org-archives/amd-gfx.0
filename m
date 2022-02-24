Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44B34C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Feb 2022 23:07:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A466B10E927;
	Thu, 24 Feb 2022 23:07:29 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2083.outbound.protection.outlook.com [40.107.220.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A94810E927
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Feb 2022 23:07:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AsL7DbwUfWU8NlvJzREaa/NYoQ4YILCXMCaSTJaezoTfOzryAC5LYqdYxSdMRr8HPEqa/byw+o+4Tk4EzbkV3EFGfNCMb3LBOj3Ohcbj+D/8LqiEHSCa6rM3v0pUlXtRVaTLfLcny0s3r1mSnQa9S/eP0LEehXLb0Qp4Q80GEfjuKJGSm+8B3ZhaRR2v9z+yRegEnbZF+it2zFwa1MqgnFoBPJuKcvm46f6HeoTzaLXl0Mefx/i1pahspF98vz8GjSeReiU6ugIstx7d9QLkQDnr74AtJW3uEr5/atYjdW8mqRypEE+pUuJFAz7D7lZ6iWV28g2Acd+3CPRh43Zc/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zUGilvEW8lgSLrD75arImiT4yfJ5N3GfSPgWO8OKeWw=;
 b=i8ZTlBdJkRpaJUxXFFSq6xMR2B1VIXDcUG3JIsl7upVZq8qEFnKdHJUB0hmFW2mWq4fgqNq+d3n7jT9dQXCAqS+52kUe9GKNyDJS7nRSDRmTmEdBvhT8dlmxRjqHRCKVTUK50vWVZTJ6kxmVctF6Ve854j8+NjKGmS6n3q2QWJ0hD075xvku4zW7IE2IYxGbGLFGeFA42MLbpmyZoqiff6XvGTrSyNc+nuc14Kwr8EQt6U8FJY8hNqINRuc94Do+QC3g2utP+2UwNoQU4Z93VYDItKTNXqaCMqpGlZpC0tf9x5KhaB5oJ1aR1ercZJhVtbO8LiaQYW+wwNxciqSwdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zUGilvEW8lgSLrD75arImiT4yfJ5N3GfSPgWO8OKeWw=;
 b=HtuSEYvfe1POi6FLufFuNdFApWDPg44FDvvXjbsir20+wfLNSbIm/opyUSA2HWiZFzfscbA4Gj4ahGFdI8h2N8Nii9R94GPpXz4oeM8CnRhbcRJoI4Wy9qRMkgHCyvmHwteJBc0bYckgO23Rsdb6Z3A1qvhNs3j9vC3q2ZStTN8=
Received: from CO2PR04CA0169.namprd04.prod.outlook.com (2603:10b6:104:4::23)
 by DM5PR12MB1260.namprd12.prod.outlook.com (2603:10b6:3:78::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.24; Thu, 24 Feb
 2022 23:07:27 +0000
Received: from CO1NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:4:cafe::81) by CO2PR04CA0169.outlook.office365.com
 (2603:10b6:104:4::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22 via Frontend
 Transport; Thu, 24 Feb 2022 23:07:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT020.mail.protection.outlook.com (10.13.174.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5017.22 via Frontend Transport; Thu, 24 Feb 2022 23:07:26 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 24 Feb
 2022 17:07:25 -0600
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/1] drm/amdkfd: Use mmap_write_trylock to avoid deadlock
Date: Thu, 24 Feb 2022 18:07:02 -0500
Message-ID: <20220224230702.1624-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a52db831-80d8-4410-7eac-08d9f7ea6c98
X-MS-TrafficTypeDiagnostic: DM5PR12MB1260:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB126016E99C3B4E6798208142E63D9@DM5PR12MB1260.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UJPuab08FPJ4FfVBzZgq5tvGVY6v2VoeisdTFHk08IHMzj7l12/m0/k5QADKoPqh0nugI7iEiScM60DKm/GEc4jrkB3UdgYMz4TODHNYhYFjBXTJYoA1kN7fvgI7ivzWXKE5BivwtuHdMoeT56PdGHeL31HerkM0SYNl7oxcKej/pkg3zu5ydMb51/1qN2HRRVG8ERKsWyKSYXwyaIwfCW+gTIWEqt5oLPVFZkGQntOvrF5dHDPxT1v666Sdt/rJkCQUzGJkxlv8Lvlk0IvzhBuRXmFnuHdfwdHR7yd0HNNv23DEjtsVLU8UAzIhivg8eWvk2sdjmVNu04BgAs8j2UPTki5J84GpS8t6MXC2fZdxt5E/u6AweO+bWMWG3fXzQR4pJSBFVOja4gXNvduDzZ/e711arfKAUJVPt3ZGrt0hqYySbcAjyhjqeSaKhZH1XHuNWNtMW8Z61Ly2ynuojPbp9e8km0HWPcAzlLgcuiaMqKAKyIPoaVcfEQbcFC+Pv84r7ov8J5mWUZhArw/7t9l4hdTKMbOOULXqh1NKOvfqdDEX/jl+kjplFbcdXdM/MasRf+P5XZget0jtCB1pvEkf0ZdcpB+7TzsvUODBpT4jHjqVYgQOT4xSSOgEJCisb33UD08vTf70zkkZikSFD6krme9ND0JeRZkaC4tIi3f7IRFCq/UW/NToJRSHAjcweQR38LN4SqLyYPpCOltm7Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(6666004)(5660300002)(83380400001)(7696005)(40460700003)(6916009)(2906002)(54906003)(426003)(336012)(47076005)(8936002)(36860700001)(36756003)(16526019)(8676002)(81166007)(86362001)(1076003)(2616005)(70206006)(508600001)(4326008)(316002)(356005)(82310400004)(26005)(70586007)(186003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2022 23:07:26.4102 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a52db831-80d8-4410-7eac-08d9f7ea6c98
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1260
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
Cc: Philip Yang <Philip.Yang@amd.com>, felix.kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

If one thread takes read lock, one thread to acquire write lock, then
other thread can not acquire read lock while the writer is stalled. This
causes below deadlock case:

thread 1: prefetch range migrate to VRAM, take mmap read lock
thread 2: svm_range_evict_svm_bo_worker, migrate to RAM, take mmap read
lock
thread 3: svm_range_restore_work, for xnack off case only, take mmap
write lock to flush deferred list

To avoid deadlock, use write_trylock, go to sleep if lock contention,
then trylock again.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index b71d47afd243..1983849c4070 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1608,22 +1608,25 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
  * @svms: the svm range list
  * @mm: the mm structure
  *
- * Context: Returns with mmap write lock held, pending deferred work flushed
+ * Context: Non-atomic context, may sleep
  *
+ * Returns with mmap write lock held, pending deferred work flushed
  */
 void
 svm_range_list_lock_and_flush_work(struct svm_range_list *svms,
 				   struct mm_struct *mm)
 {
-retry_flush_work:
-	flush_work(&svms->deferred_list_work);
-	mmap_write_lock(mm);
-
-	if (list_empty(&svms->deferred_range_list))
-		return;
-	mmap_write_unlock(mm);
-	pr_debug("retry flush\n");
-	goto retry_flush_work;
+	while (true) {
+		flush_work(&svms->deferred_list_work);
+		if (!mmap_write_trylock(mm)) {
+			usleep_range(1000, 2000);
+			continue;
+		}
+		if (list_empty(&svms->deferred_range_list))
+			return;
+		mmap_write_unlock(mm);
+		pr_debug("retry flush\n");
+	}
 }
 
 static void svm_range_restore_work(struct work_struct *work)
-- 
2.17.1

