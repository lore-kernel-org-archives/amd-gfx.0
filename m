Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C686AC43334
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jun 2022 19:03:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F60512A86C;
	Thu, 30 Jun 2022 19:03:48 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2074.outbound.protection.outlook.com [40.107.243.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B4C6012A86C
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jun 2022 19:03:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JzPmQHWIHRuitLG1TKOzhCgr3SXjN7ECcoIXL2naUHltw1z1gXIv4NoQLcjTw69oQqeLPt4eP/yTxhTJsH9qHom8Dmh+BaRd5rRUwucr8I4uetAesldL62uuIdBBt8ak+T8YsK/vE8zTQztGJA/qoc8gCyrlE+kpi3OSSoExL69jtSMdEaGinVQ25R4ZALZuObQ3YT9rJy9LrsEymAXUaYC581lNE5Z3b5uDWHREjyVrBuOH9kbcANOK0G0GzD0ZsWBu1GR9hiRItltOFgn8Wnvf/qqy1o1vMy7nCwAO42JhgqUchlhtVxaimM8YH4wzztbhfftyPsOuOevBGF3cHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A2TK/Mi+jN4TmvMuMbEfYQO3qPS/pKCk/K049uEoQuU=;
 b=DMBuyOfsNguuq2IWjdufjjUQ46oD1NEhZrR0db5sJOAjUSsOPKf+SO8HoNoZrfylNZYhwoC3nScT/YQiZ17FD31hTMir4gjEwYc5c1uSbeS2IjxJOACAzOEZszM1NusdN/yspZo+mHPLhpQeA1ko/PNLUJPturD1s1nbQYH2xEzSTuBXzgU0GihFuj8I0wTjoGO6Kpb5rkPIKnBD8unEpaCLn5uUHN70vMyXysLhK8Kc+Q/pceWJiEKHS7oZONGjdNChvcqa1WZHsq24a1rAzWqSRtaV4IV3r4VQH36+L+ju20BUpE+OF8WZr5pLcJ566G/FRVIjE5xTv53lXuffiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A2TK/Mi+jN4TmvMuMbEfYQO3qPS/pKCk/K049uEoQuU=;
 b=qJmUT4/LV4MAhi8/CHT9rkPQzUUQKWqQU/vuBjdZuGfoernFZyw+lRt9V7gX5Tg2HvFnOK5zUOvgt0VTRQ+PooZDGyz+hrEGtAEA/VHzisG3YKzprPOUsON646XnLktkcPlDqtgm/0hIDzpdF0zBU8ZaNCrSsEhPHf9bPapzUeA=
Received: from DS7PR03CA0239.namprd03.prod.outlook.com (2603:10b6:5:3ba::34)
 by BN8PR12MB3635.namprd12.prod.outlook.com (2603:10b6:408:46::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Thu, 30 Jun
 2022 19:03:44 +0000
Received: from DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3ba:cafe::69) by DS7PR03CA0239.outlook.office365.com
 (2603:10b6:5:3ba::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14 via Frontend
 Transport; Thu, 30 Jun 2022 19:03:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT010.mail.protection.outlook.com (10.13.172.222) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5395.14 via Frontend Transport; Thu, 30 Jun 2022 19:03:44 +0000
Received: from eric-hp-elitebook-845-g7.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 30 Jun 2022 14:03:43 -0500
From: Eric Huang <jinhuieric.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/5] drm/amdkfd: change svm range evict
Date: Thu, 30 Jun 2022 15:03:06 -0400
Message-ID: <20220630190309.119238-3-jinhuieric.huang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220630190309.119238-1-jinhuieric.huang@amd.com>
References: <20220630190309.119238-1-jinhuieric.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 806552db-1401-4a32-912b-08da5acb4164
X-MS-TrafficTypeDiagnostic: BN8PR12MB3635:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D4MYwj31aN74Ev7VAEb54LzkD9SxmJERDfI376fhe1tbmGXxDqgH4MP65HYLQnprqv2YbgwyvXumubrvd2/sZdkqi2xyvRgCfIR//ddDjkoidxbOPWkt3iQoTYDOhICNFfL6lO2BVoxoBV5oODTBdX8Knj891kNnESKcJLN3V95G+YfUjkV5bEpriwe9/yuzniTs0dNpmjHvqeuO98OCojdWm6xuLZidReIWx3IDqrQkMN0zvXnI3kS6Uq33pjWXjdNt3H0TImjCcQN88zQ0v0+uR/XyxGqjSrDwC7ljeZISV8TU0qiUw6JvgIasD4F2g13CvAA7RZm1eN5Um+tN7OBRwlYuikzwkypZfmbUFt6x3mlAxerIJDlrrVU5pgxTh2yqMEh1dzQ3zRmCe/LQVv3q9d0DZdEBfPzPgnqrmlyuJYOKjPbjkLQiNgQqZ3KaPtnsbN0apu+u4+jh8tNxWslDdOlmgNlN0ctop6v0j79+xvqgvnrMEc2ouAZ6iibe8i4nXHNPjc/OzZ6oNBi3sgODeRhsngfYyjiB0DrdcuqrEZ22BXFWULClYrokYf7hY4MyDVV6jm1yoqnf/gKsNTMeSkEFnIr9XcfTDu9dqoCpTAeizfpj4F9lWN7Tmo4ZtWTPjIYPbtG8PaqqsHGsVn+ioyy+zig5u/I9SE5j0b+kd46zMAoF17EyWgLPyJGhMz7k5JrvTmRVa3O+jfB8pdHr/Lqt8bTOJpteRXpbn2w3dJ8KUqfnoqDAIWC2S2oPO13Dr1t2XNto9EnbrmFldepBY66x5CpjbBbbuUczhykm1SE2p26+Ql8E8sUxd8RIO8X/t+T/64IfYLuQ3zujdElOZTUys6n0MLydLB87JiM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(39860400002)(376002)(396003)(346002)(46966006)(36840700001)(40470700004)(86362001)(356005)(70586007)(8936002)(7696005)(82740400003)(70206006)(40460700003)(2906002)(81166007)(478600001)(41300700001)(6666004)(16526019)(6916009)(36860700001)(186003)(4326008)(26005)(8676002)(54906003)(36756003)(2616005)(82310400005)(316002)(426003)(336012)(47076005)(1076003)(40480700001)(5660300002)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2022 19:03:44.7379 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 806552db-1401-4a32-912b-08da5acb4164
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3635
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

Adding always evict queues when flag is set to
KFD_IOCTL_SVM_FLAG_GPU_ALWAYS_MAPPED as if XNACK off.

Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 4bf2f75f853b..586bef4fcc8a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1772,7 +1772,8 @@ svm_range_evict(struct svm_range *prange, struct mm_struct *mm,
 	pr_debug("invalidate svms 0x%p prange [0x%lx 0x%lx] [0x%lx 0x%lx]\n",
 		 svms, prange->start, prange->last, start, last);
 
-	if (!p->xnack_enabled) {
+	if (!p->xnack_enabled ||
+	    (prange->flags & KFD_IOCTL_SVM_FLAG_GPU_ALWAYS_MAPPED)) {
 		int evicted_ranges;
 
 		list_for_each_entry(pchild, &prange->child_list, child_list) {
@@ -3321,7 +3322,8 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
 		if (r)
 			goto out_unlock_range;
 
-		if (migrated && !p->xnack_enabled) {
+		if (migrated && (!p->xnack_enabled ||
+		    (prange->flags & KFD_IOCTL_SVM_FLAG_GPU_ALWAYS_MAPPED))) {
 			pr_debug("restore_work will update mappings of GPUs\n");
 			mutex_unlock(&prange->migrate_mutex);
 			continue;
-- 
2.25.1

