Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03717C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Jun 2022 16:03:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 934DF10E284;
	Fri, 24 Jun 2022 16:03:14 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2086.outbound.protection.outlook.com [40.107.94.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E19D010E284
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Jun 2022 16:03:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K3j3/0yb4H6YoSfhMt06Io0pgp8AQb5Nt7FvPd7Ch45sbvsjPA6ukYOBk2VzeZjwzTmVAC3vI9eFZJSs+S2Vgh3bxQo9OA5O1YVdjrhLTOgqfsu9ZD3UN0IGmuu2BpWeA/13wuC9B5H527ECkKSeWDzARoNug+2Ir7zCHdgEFWrMcunVvxnwfCLr9QScjykFbYyx41RwJESGuRCehVQ6pjrQzrIZli2Y5zFEJNgqZI2MDLMtsiLtH/2nagAFDX3ESQXqF0s9lFiDRmNRTYTRzpYDW10Z96QZalGMxx0nUp+OPnULQnLX8+OIx2RuQxUZgFY/Ow2E+rrfO26xRVCH4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0br+6r8tzHlCg2ZvtfOF5YNjiCm5VCLlpXOfwiZ1mk0=;
 b=NHrxIic+YPbMo3b3NtIDCIHMjRHq0MAFcjgfR94XFrrCh32UdKl2oMMfY1ryFjzpLL8V1Qa0VR2KI30nN+KPlv72yJ7nSiyJFQ449Mb3ZqbHP1MIuqHbhrrAtJoqDlbmfrj90PxwHwYukXpMfbi71IGeoloDzf321ZUMgxVOLF/19cNeeI55AKIbnQCBVfXjl7TLWeo48X6pF4gLnPVKZ5qYwMELAFW2aFzJQSakCwOuCe4VQS/7WTjXczIKRMN51BxJNzk/uE1WDkzhIK2CJCwF3Pu1rqN2ep3LPjLSKsEVcFXJtx+Z26+6lK1scWwbN8pCrwiZgBRLd+uwOBstnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0br+6r8tzHlCg2ZvtfOF5YNjiCm5VCLlpXOfwiZ1mk0=;
 b=rWZ3l9HoG3+zeeoB0ohD9eqcVflSBOkcMEbw2n/vVVRMCS9igLDKuQE7biSO16HzcKniGtkV8lXoShEOQKnAhdV6J+1vn7h8PWfFZAU+lafUTkqLn2l4jnY/mcvjnq7p+cBpvrzmHoZSybY/GsJ/pPxJRVpUdmGhfd+frXmwWu0=
Received: from BN9PR03CA0737.namprd03.prod.outlook.com (2603:10b6:408:110::22)
 by DM5PR12MB1708.namprd12.prod.outlook.com (2603:10b6:3:10e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.18; Fri, 24 Jun
 2022 16:03:10 +0000
Received: from BN8NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:110:cafe::32) by BN9PR03CA0737.outlook.office365.com
 (2603:10b6:408:110::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.15 via Frontend
 Transport; Fri, 24 Jun 2022 16:03:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT016.mail.protection.outlook.com (10.13.176.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5373.15 via Frontend Transport; Fri, 24 Jun 2022 16:03:09 +0000
Received: from eric-hp-elitebook-845-g7.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Fri, 24 Jun 2022 11:03:08 -0500
From: Eric Huang <jinhuieric.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/3] drm/amdkfd: change svm range evict
Date: Fri, 24 Jun 2022 12:02:42 -0400
Message-ID: <20220624160243.83693-2-jinhuieric.huang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220624160243.83693-1-jinhuieric.huang@amd.com>
References: <20220624160243.83693-1-jinhuieric.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bea3d69f-dad3-4e34-a0ad-08da55fb088d
X-MS-TrafficTypeDiagnostic: DM5PR12MB1708:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A9a7kSZ4/b5ogIdzIVyRQQ1Y2SJMAYZxnR5UTD1+OyClFgW6JbxRWmmu9s4WdIDsAgGJ9qbpDOgxHkbRXi/pf517f2RpuIqo2+HDbtufEC1XnvRxLImAP8zOqP4qnJSfJ1NI9XVlDhgnCCz6Sf+7G+FyX5Nk8v/vzQvmP08NHYqbMyQNVZ+wBaH5mXU78h4phmfSglvUcALfU/Ll7t0fukEEZe17HhexbAK6lsSlD3j6fkYVtolX/rjs8foS+6eYISA6ETXvyr3pbx7tUsWQqqMk3qhJ31WFzZdbUKsxeWC0TaghDLW+zc0DuLfSQ/bwsdBLvRjqlZB2yW5+DuJMhIkTL4sFBnzQPfndgpK816oxLNsRL+5dtJR76ua5DQy7hCJDzu54WH4drqfVlELbgFOMAt/x0x9IV0BN5PzhBSwt1gkkY3S9eYZUoxNWxhRh3m9yM0J7Ww/bwpxO/NgKcoyH7VXqi5zkvrcjkyFiVAILL6JNBjXPicfFFBHFgT36d4EI7Lh6QPBuWel8WL254vAMroON3GDSmVRrdXMQKZ3BguyRAH1n9kOfxZLD80Ysvqr25o7weaeidF4M/GTSiRrv8oBVGSdoPHupaTkN+X+IFEAS5//RXeFV2xNxXzJubpoFNJl3aHZIgRlXtW8tm2IzLdN9O5IjYTjDJg7/NfmxJIf9e2PH4ly5xCn7lUTVCZPbX3AWdn9CrgPU7tohEm1XqAwKsJj223yHyLj/Dp8RdiuS+Y9VbmFIpeqeWE7zAA4wNgV5O+aYfU6kO4CyuQDG7GFhP8bbLroh83G5GGVemN6NRphN71agBYePi73wJM9M++H/EiYF3SR/fwBKRw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(346002)(39860400002)(136003)(396003)(46966006)(40470700004)(36840700001)(6916009)(316002)(54906003)(41300700001)(8936002)(86362001)(2616005)(1076003)(8676002)(70586007)(70206006)(81166007)(356005)(82740400003)(26005)(7696005)(4326008)(6666004)(478600001)(40460700003)(83380400001)(2906002)(47076005)(426003)(40480700001)(36860700001)(336012)(82310400005)(5660300002)(36756003)(186003)(16526019)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2022 16:03:09.4216 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bea3d69f-dad3-4e34-a0ad-08da55fb088d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1708
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
Cc: Eric Huang <jinhuieric.huang@amd.com>, Philip.Yang@amd.com
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
index 4bf2f75f853b..353306037959 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1767,12 +1767,16 @@ svm_range_evict(struct svm_range *prange, struct mm_struct *mm,
 	struct kfd_process *p;
 	int r = 0;
 
+	if (prange->mapped_to_gpu)
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

