Return-Path: <SRS0=0Dgm=LQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1E32C48BDF
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Jun 2021 13:32:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC858613B2
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Jun 2021 13:32:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC858613B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B21D6E069;
	Tue, 22 Jun 2021 13:32:39 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2089.outbound.protection.outlook.com [40.107.223.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB0016E069
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Jun 2021 13:32:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AdH6Hm2KBlPfCbPqVw40wZDbUo+5aEj31YDlg91qyVAivOdYTFEcdZVvOzQND/rRyOLE6PLkSjXpePzeKOle41xB4uOSTnzXlI3zsDluu0pVEtHwt04D6Fz/blI99hx2+lHLHrZ9AGz8RmwZpoJoE8sQb2CPceA/T4XY/b1KUNAlfLPVk2FzoffqmRJQiWo2QXFDILCwyFdrdub2CPdXuBvQrd6FLKMoHnLMMK4CIp5RR+KQhU8Lc3+Ol3rAbLlS5MxnqdLO8xaUNoPRMT/18JOAc5A/Gi91VVnUmvKswegusaawa0V/Kj9M3TlCHVL2WEkpnrbMIyRg5NVOrDGS8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H8zXk+iUYmCwP3gls5mIKdigAkP8n2bZI8MicXarulc=;
 b=N2eR4EJ+Ebw6AN8T0I1JpocluAyADYJf6VnAQsUoJ2RupafI5zUXV7UlBR5rCj7ZSG61iQi9VklRgtyR0+BTBGOOBpaQw94k3kAVIwQTBkAv1NzPuj1o9CrPE2tNfC1fiQn8LLcDweDzWyNIXhfYxiYKeCo5oAWgIN0LlRHCuiP0vYN9GL+EAwSvuBWOt3NKPGBoL8kHhsg6EvTOY2MYeBmd/hmus5JxZOOyEl1CDyp21Eqac/BtgsUhPr+LuuLf+Q8S1nTj5/ncEn8+q7KFcyDhiPQP87C9vkjdEZTYGMpycAeKX3ZbB4n/i5iP8XJvvHtwTxewxYteg8zZampBPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H8zXk+iUYmCwP3gls5mIKdigAkP8n2bZI8MicXarulc=;
 b=MznbBAOXb/71WdlLq4a7dh5Y82qAUR4ITVlR7oKLGPAal32KkwrK9kBsf0jZQw2fXYnZWwzNTJMY6AHZZQA0a1fcEWECSQwhIbTtsJwOVFVixv7qIudBs9PGwqJHSonwVpjKmz6JdqVt6Kbkx61kLGWzTrGNC2AwRKmUlEL2pUs=
Received: from MW4PR03CA0025.namprd03.prod.outlook.com (2603:10b6:303:8f::30)
 by MW2PR12MB4682.namprd12.prod.outlook.com (2603:10b6:302:e::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.21; Tue, 22 Jun
 2021 13:32:35 +0000
Received: from CO1NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8f:cafe::54) by MW4PR03CA0025.outlook.office365.com
 (2603:10b6:303:8f::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18 via Frontend
 Transport; Tue, 22 Jun 2021 13:32:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT019.mail.protection.outlook.com (10.13.175.57) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4242.16 via Frontend Transport; Tue, 22 Jun 2021 13:32:34 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Tue, 22 Jun
 2021 08:32:33 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/4] drm/amdkfd: fix sysfs kobj leak
Date: Tue, 22 Jun 2021 09:32:11 -0400
Message-ID: <20210622133213.21393-2-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210622133213.21393-1-Philip.Yang@amd.com>
References: <20210622133213.21393-1-Philip.Yang@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b9695a30-54b3-481b-2519-08d9358231e0
X-MS-TrafficTypeDiagnostic: MW2PR12MB4682:
X-Microsoft-Antispam-PRVS: <MW2PR12MB468230D2B515A86758F04254E6099@MW2PR12MB4682.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:989;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +Wl396YknCUc7Al9YAhWM5qhvAp94SVSt/uOOfnVUr2VpEvEsmlotR+CKr/uWIWqTPi89qucySszc7j4OrPBrRIhSbdrmoDKHONF+FEXUSO/GNCcDwPu/52gV3yurunPjELZt+GkjbN5o4YuVhrUxedTvAeh1hczdnORgp7jZo9M7eOVeE0S9ROg+TwwMngA5cEdXP8TSjVltdAQjHPf0nBQ+67REgS3MzPj6O+NOc1ZukTnb7IPxZja5wkzBNmYqeatZLPZCZ/ax3Dzy+9t5dUEr6McZlUkohIINrx3HN4jOz/y3earbqbtSOAY+0YtbpiTLUwFWmTjNtW6vBNyX0KYn6AeEklhIHbBnHiH7jxkbxOT+pVsn2SA+3nXRfSf1Za5AGzUUx8w4nsnEVzYss0R9+4x/HhIKsri6BQYvY3T7ZsydaxIO4EvqWEkMDQBQXW10XzEkn8IgHZllWElXZ0bWYwEVAChNbZBcgCc7oWbBLfY9SQZJT288+6zzTVN4CZUWI8Nf/OjXhclO+/kSWRzcLqrWJ6Jl7MZHTI7TLWfi1TchqHeqDGIJ0nXHDp4oCiN75vMLnrVyK6c4uzEOBU5UfOipi1etIgTaVqEm41Pa9wMwz8L+u0Jlpd0g315P9OY5PXHlrcae/e5rI7KjCAtbrFfOIMi6DEUH12ygRUoGtee656VdzIeys0Z0KLKPNV6OeX+T1qw4SR6gODtBmAskHZlbfuwOHv5IU6c7oU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(396003)(376002)(346002)(46966006)(36840700001)(336012)(16526019)(70586007)(70206006)(356005)(1076003)(186003)(83380400001)(478600001)(36860700001)(86362001)(2906002)(26005)(7696005)(81166007)(36756003)(2616005)(6916009)(47076005)(8936002)(4326008)(426003)(316002)(8676002)(82310400003)(82740400003)(5660300002)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2021 13:32:34.6680 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b9695a30-54b3-481b-2519-08d9358231e0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT019.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB4682
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
Cc: Philip Yang <Philip.Yang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

3 cases of kobj leak, which causes memory leak:

kobj_type must have release() method to free memory from release
callback. Don't need NULL default_attrs to init kobj.

sysfs files created under kobj_status should be removed with kobj_status
as parent kobject.

Remove queue sysfs files when releasing queue from process MMU notifier
release callback.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_process.c           | 14 ++++++--------
 .../gpu/drm/amd/amdkfd/kfd_process_queue_manager.c |  1 +
 2 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 3147dc8bb051..cfc36fceac8a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -451,13 +451,9 @@ static const struct sysfs_ops procfs_stats_ops = {
 	.show = kfd_procfs_stats_show,
 };
 
-static struct attribute *procfs_stats_attrs[] = {
-	NULL
-};
-
 static struct kobj_type procfs_stats_type = {
 	.sysfs_ops = &procfs_stats_ops,
-	.default_attrs = procfs_stats_attrs,
+	.release = kfd_procfs_kobj_release,
 };
 
 int kfd_procfs_add_queue(struct queue *q)
@@ -946,9 +942,11 @@ static void kfd_process_wq_release(struct work_struct *work)
 
 			sysfs_remove_file(p->kobj, &pdd->attr_vram);
 			sysfs_remove_file(p->kobj, &pdd->attr_sdma);
-			sysfs_remove_file(p->kobj, &pdd->attr_evict);
-			if (pdd->dev->kfd2kgd->get_cu_occupancy != NULL)
-				sysfs_remove_file(p->kobj, &pdd->attr_cu_occupancy);
+
+			sysfs_remove_file(pdd->kobj_stats, &pdd->attr_evict);
+			if (pdd->dev->kfd2kgd->get_cu_occupancy)
+				sysfs_remove_file(pdd->kobj_stats,
+						  &pdd->attr_cu_occupancy);
 			kobject_del(pdd->kobj_stats);
 			kobject_put(pdd->kobj_stats);
 			pdd->kobj_stats = NULL;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index 95a6c36cea4c..243dd1efcdbf 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -153,6 +153,7 @@ void pqm_uninit(struct process_queue_manager *pqm)
 		if (pqn->q && pqn->q->gws)
 			amdgpu_amdkfd_remove_gws_from_process(pqm->process->kgd_process_info,
 				pqn->q->gws);
+		kfd_procfs_del_queue(pqn->q);
 		uninit_queue(pqn->q);
 		list_del(&pqn->process_queue_list);
 		kfree(pqn);
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
