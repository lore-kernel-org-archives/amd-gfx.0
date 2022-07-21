Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78987C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Jul 2022 13:45:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 83A00112923;
	Thu, 21 Jul 2022 13:45:47 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2071.outbound.protection.outlook.com [40.107.244.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3779B112D86
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Jul 2022 13:45:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ElXr4/+Hql15UIi1H17Kreu1FQ3R3h43mnSArpAqw7yCGY19D6CKHvJqA88xvjd/E5Ss4wwjyLZcKBjFgmxJXHR16QsaHqoNTY5kZDPW8jto2w/7n5qgsu4st59moGEkCBgs5uu8nxGgEHZ/w3S1wng4gs+1JrqLd4bDPaH1cc+O9kkbQvs3UoFg7t7k6t95OSLuKjeCsi/MqotvSFO6QC2/LwfTEYZXu3hx6bTeW7ubLcDokitleQkt4s/kM+C4WwmkPXh/bSMJuLID+5oLLgSllG4cdlYLOH7chV9JIuJUAF0tzvBi6cZiP/Kd0tmOX6qgRrZMmSOrIVuFkjf5dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MzJdMLPwQ+TQFcdpNEuPXrR+8Uy2+AXXl3bHm/QmFlA=;
 b=WZz4RrfX3Nur+jLF0EPcDYggUaKcvgVa+zvudVq+CDGfhzhRNFoUZJpnLbyQyIG7wP37EYdX9eCz7hoJJGpScnxrLwj37d6PFeOkcXWm/NHTsRp0GePY1i17Ofdfu3uKr7G3Eh1ESoeGEElIh5qfkFZ7Vsn8W0NxIAW1TvZ+sazV/Th5iVUwQLN+bweCEHlo9xz5yD8oJ7EnTiYTBw05kmmq9bxp0jTv8fQAd9u2Vjk7NBhC3vm3v4Gk3/kPgR5kFJzhSNp0wpNtaSmnpvHpKJoKr5z/NGAuhz7zk/RqD0QKb53ZPFnUjdr8nFLNDkfvH7gwDqNkMN2XaPJxeggCOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MzJdMLPwQ+TQFcdpNEuPXrR+8Uy2+AXXl3bHm/QmFlA=;
 b=UqmnBgpG1ViKgVNBTE6FqSwhdx3+omHLQin5+ryxO9tHwmcp/kWE9jfTVkr1q7MBeW7fG7igivF2VsvHnAjn4LBYzeGOLYpGuglMNmvBiplYSCEOaQSerXSkOHS5s63uh1Iuam1U/LCzvFNwgwZ29h2nfuKpkJ6DlKw6c0l3wxM=
Received: from MW3PR06CA0017.namprd06.prod.outlook.com (2603:10b6:303:2a::22)
 by BL1PR12MB5729.namprd12.prod.outlook.com (2603:10b6:208:384::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.18; Thu, 21 Jul
 2022 13:45:42 +0000
Received: from CO1NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:2a:cafe::f4) by MW3PR06CA0017.outlook.office365.com
 (2603:10b6:303:2a::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19 via Frontend
 Transport; Thu, 21 Jul 2022 13:45:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT012.mail.protection.outlook.com (10.13.175.192) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5458.17 via Frontend Transport; Thu, 21 Jul 2022 13:45:41 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 21 Jul
 2022 08:45:31 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/1] drm/amdkfd: Correct mmu_notifier_get failure handling
Date: Thu, 21 Jul 2022 09:44:38 -0400
Message-ID: <20220721134438.23653-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 37101221-d666-4852-b8e0-08da6b1f4dd6
X-MS-TrafficTypeDiagnostic: BL1PR12MB5729:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: irkRqAi3N+LYGszt6yNku6CZ1d0lu3tyxO5nCyJsFKe6gqwONSImUEdDfGiPttWdLABfNmNVYiOPhnScHE9d/gvzlx2ZC0VOtm4ddSIG0BwahddMvYFPZyK5q5Gx4hRYatxDzLOcblNUEHnmctFPvWMKcLT6X9uIrGZzDtVnk4zK/bg9a2UXFGmMwe5vTABdkVCX6IYS6t719wlu/xZ7RSSHRAXq8ciUkI8x7tm1tWJ0A2qRc8o/w2MDu6cWO/zxXIpuoX5t7R7jPlXczsRGWl1TTosHofs7aT55OFVYQGKREpiRlatbZVCOz3gpI6R6eLYpFjWGAYRBKgbNAWHYeEcoZRWUuYEgMk6L5M8C3UdjfoIvwATUGWDP01/BSPYtO+6wUU0jDd/4pq+Vqoe3OW1NOT3J8WkvzA4X2dy0oUpPzP0DF/ddTHObIxYx6KEsWeZ3HkygQdqwkkvwVRLyMveMb8zCpQHidP9To/9yJuD2icOUSxkssP8a5Ny/WBSpSupKAzGUHFFOQeMfXr2FRqtX0jqHysRfbyG9O0MaZVS1dEaWKegNzuV85QdmaL9OVYGKthDFflyNdd3SZk6GsQ5s5XtQIa72QpD1Hxpl4ouJ6FAZSeZwNduoNBPsN+xQ5aJp5igy5w768e2dXL/JeXkMALBtDYtQ3JZqclA9FfFzhA6uTZqcwWga8gruQ7CSCfamqkzfejNqzc9eEO2pGgOAo3xg85yR0Wk3aB+CYqbnYehPlzUr5Bc79eD1kzyYCmG0F6LUPGY/jxlVnVhydOedyxmWtU1X0FWAVqKhROIyJTnwRmOo8ord1pLniJCFNNBygwd3u7DKOJfWunnFfw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(346002)(376002)(396003)(39860400002)(36840700001)(40470700004)(46966006)(2616005)(16526019)(316002)(54906003)(6916009)(186003)(47076005)(426003)(40460700003)(1076003)(70206006)(70586007)(4326008)(83380400001)(8676002)(336012)(356005)(26005)(7696005)(82740400003)(5660300002)(81166007)(86362001)(41300700001)(478600001)(82310400005)(40480700001)(2906002)(36860700001)(36756003)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2022 13:45:41.8547 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 37101221-d666-4852-b8e0-08da6b1f4dd6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT012.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5729
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

If process has signal pending, mmu_notifier_get_locked fails and calls
ops->free_notifier, kfd_process_free_notifier will schedule
kfd_process_wq_release as process refcount is 1, but process structure
is already freed. This use after free bug causes system crash with
different backtrace.

The fix is to increase process refcount and then decrease the refcount
after mmu_notifier_get success.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_process.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index fc38a4d81420..d8591721270b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -1405,6 +1405,11 @@ static struct kfd_process *create_process(const struct task_struct *thread)
 	hash_add_rcu(kfd_processes_table, &process->kfd_processes,
 			(uintptr_t)process->mm);
 
+	/* Avoid free_notifier to start kfd_process_wq_release if
+	 * mmu_notifier_get failed because of pending signal.
+	 */
+	kref_get(&process->ref);
+
 	/* MMU notifier registration must be the last call that can fail
 	 * because after this point we cannot unwind the process creation.
 	 * After this point, mmu_notifier_put will trigger the cleanup by
@@ -1417,6 +1422,7 @@ static struct kfd_process *create_process(const struct task_struct *thread)
 	}
 	BUG_ON(mn != &process->mmu_notifier);
 
+	kfd_unref_process(process);
 	get_task_struct(process->lead_thread);
 
 	return process;
-- 
2.35.1

