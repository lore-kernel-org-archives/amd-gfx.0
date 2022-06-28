Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90A3CCCA479
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jun 2022 21:44:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 91CF810EA9F;
	Tue, 28 Jun 2022 21:44:16 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2087.outbound.protection.outlook.com [40.107.237.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 32DD910EA9F
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jun 2022 21:44:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BlTH+9Tb4Ym/feNbqmaJjqEmzVTzf067ESvWWC/RjwLVerzyKQTNyUoslGXD3/tfUDyOrUhLSXMLA5rpeLmHxf5LWJoHd+7m/Vrq646X37oKp0nA3YILd5xZI+yhvyuoAND1wCMy0UreDc+QQEasF/cHOaPGKaV/CMsK40ekJ9KrqsjEjRpuUxoTgkVN8WRSgPmNN7ZQUQCyAfSucONBwh44vQEV+n1D6MgB/k7no2yrnUwJl1eYo2HkSZnhY75I4HLEUR9vZBBl/1xaaA8WKwAapr+F420o1gMAkKNZINp/HfEt5OyLJr5JMiZsW2Nz2KYg18kPpgB9l5pLROXw0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=il2FFVZ9fdkcyrj2oYft2tMkgFL70sKdNjrAAVre16U=;
 b=mhn0sEZqS2npa7Mo+8VY0KV7nnxm387SYDwwfNled+jSHkns/InJukdXXpo+x5H71Ha7duSpaneAno5Qca5rI8epRCQLPUtN/JA9PVJ4O90svpxsZcipuul0MgfJKF8FC1NPgXFSJHsyCs1e15y7u96mbqoBPZqDql9iiI/pn991LGLHb/SWaGuttn47fIM2TMHpw9y8/enuPM4RDcx4vBdyIne4F+zVW9t9Eb0dbdxPY8n5KUlOK7wVniyE44dHtlOuVZNJhM5JwUeTTZm7EJ/MUYY5bpRCyZheCaq5ZfS+GMs813IC0xe5CWCpOasNGb/lWJZFzb1P0Z78iadT4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=il2FFVZ9fdkcyrj2oYft2tMkgFL70sKdNjrAAVre16U=;
 b=X84O0Zp4anZOYqrOU2xZYXjDclOasZDT6+IpnxhzCo2jFocfN7zKmlJ9R46AEo/sZk6q6pxIBbRSC5/9utkVn5vnz6Wl5NqgE0gsctMed6HFNNet/WYUyLJIB+CDTgfolAKdOC9K7tZBxEz3OAF6Xli2PYaWbIygeaDaBs0/feg=
Received: from DM6PR18CA0024.namprd18.prod.outlook.com (2603:10b6:5:15b::37)
 by PH0PR12MB5466.namprd12.prod.outlook.com (2603:10b6:510:d7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.17; Tue, 28 Jun
 2022 21:44:10 +0000
Received: from DM6NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:15b:cafe::69) by DM6PR18CA0024.outlook.office365.com
 (2603:10b6:5:15b::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.21 via Frontend
 Transport; Tue, 28 Jun 2022 21:44:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT032.mail.protection.outlook.com (10.13.173.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5373.15 via Frontend Transport; Tue, 28 Jun 2022 21:44:09 +0000
Received: from eric-hp-elitebook-845-g7.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 28 Jun 2022 16:44:03 -0500
From: Eric Huang <jinhuieric.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdkfd: change svm range evict
Date: Tue, 28 Jun 2022 17:43:13 -0400
Message-ID: <20220628214315.235160-3-jinhuieric.huang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220628214315.235160-1-jinhuieric.huang@amd.com>
References: <20220628214315.235160-1-jinhuieric.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a30a6a26-efc8-4543-24aa-08da594f555d
X-MS-TrafficTypeDiagnostic: PH0PR12MB5466:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m07QHVnLi8iDh7iEPARa+PCohs9xiL1MhMdgglI5wx9PDVUiQjxVc9pHeDbAaDf+c6Udg6PiayhH3kWhsGVNOHmPH2wDlnALn2kofxIKAA/r8y+gQVlwji2mpl2GT1LFhmJuUkJUjTnz/3MPMxS/wjkGnb93MvH0M0I7WV7s0Yxu/scP1217xxbHDIhsgJ5+gZ7985EV4a0hcSKf2QEnGlDjdIB4hc0XBPv60coNxZYmuAckBpXEtqKeFLqLn9zT4L9YuD7YdPIyaKbduyaKaTezk6V2zCzotJmG5JPyUuRFixz6PEBno+mGi+rGis/Dpo0pNU5TodAWVHshLVLyFa1XKzGVP1b38fp8XyQ4b7CHnFpSv18uxuUFE/vACg+tCZ3UsrfUbkRgYOscy9cpHC2lm0RVovTYeXXi7oKCdLf7JLaNq7/QwLUUOz3BLBm8+84yjcC+smEoMyIcN5sNNjR163/tKdm3rSW4sjqbaphlSJkv3KofEecJGDLJnLAvMCMxJ1S+J37PqHU2V6e+AxJXrtrzksExbo5Wpb5KtzOcPk2NUeIX4eM7BA4iRLdyd3RJmQjBi6iWmfvxgqe77sM/7fWyUHU9pU+0fKv/0Yug4RnzOL9MMtRKR5XoOiF9RMNeU0KoQsKMXp+ViEtQkoa5clQDv76FiMMMEiRu0Ldmek60LLn9o3NcWLKPtmSNJi4DxuPSFF7RgU33KPpvqStTixcVL2a7ygx1vp011fd0alB5WxvwfiZUPCwSAIL+ELWCNA/IUIyeku2MKtmr4lVBTI1v+fkDqyP3x0aGstAeEbbdexIvYDsSEaBN556KWnyGs1JOP8biMppmVgLiMg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(396003)(136003)(376002)(39860400002)(46966006)(40470700004)(36840700001)(36756003)(40460700003)(86362001)(316002)(6916009)(83380400001)(2906002)(16526019)(47076005)(186003)(36860700001)(82310400005)(336012)(426003)(70206006)(7696005)(81166007)(8936002)(8676002)(40480700001)(70586007)(5660300002)(4326008)(82740400003)(2616005)(54906003)(41300700001)(26005)(6666004)(356005)(478600001)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2022 21:44:09.4865 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a30a6a26-efc8-4543-24aa-08da594f555d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5466
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
Cc: Eric Huang <jinhuieric.huang@amd.com>, Philip.Yang@amd.com,
 felix.kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Two changes:
1. reducing unnecessary evict/unmap when range is not mapped to gpu.
2. adding always evict when flags is set to always_mapped.

Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 4bf2f75f853b..76e817687ef9 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1767,12 +1767,16 @@ svm_range_evict(struct svm_range *prange, struct mm_struct *mm,
 	struct kfd_process *p;
 	int r = 0;
 
+	if (!prange->mapped_to_gpu)
+		return 0;
+
 	p = container_of(svms, struct kfd_process, svms);
 
 	pr_debug("invalidate svms 0x%p prange [0x%lx 0x%lx] [0x%lx 0x%lx]\n",
 		 svms, prange->start, prange->last, start, last);
 
-	if (!p->xnack_enabled) {
+	if (!p->xnack_enabled ||
+	    (prange->flags & KFD_IOCTL_SVM_FLAG_GPU_ALWAYS_MAPPED)) {
 		int evicted_ranges;
 
 		list_for_each_entry(pchild, &prange->child_list, child_list) {
@@ -3321,7 +3325,9 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
 		if (r)
 			goto out_unlock_range;
 
-		if (migrated && !p->xnack_enabled) {
+		if (migrated && (!p->xnack_enabled ||
+		    (prange->flags & KFD_IOCTL_SVM_FLAG_GPU_ALWAYS_MAPPED)) &&
+		    prange->mapped_to_gpu) {
 			pr_debug("restore_work will update mappings of GPUs\n");
 			mutex_unlock(&prange->migrate_mutex);
 			continue;
-- 
2.25.1

