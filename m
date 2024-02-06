Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90B59C4828D
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Feb 2024 15:59:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CCBF710FAB8;
	Tue,  6 Feb 2024 15:59:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ih/4+Cbp";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2071.outbound.protection.outlook.com [40.107.96.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA4F810FAB8
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Feb 2024 15:59:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M2kXyfCgXlHQd9sKoEeTNcSkWJU8BN2Pncj9gElbnzY3ZdFGy62nH9q/SDnNTwGcXptoc9c6GZNGUQa4BP2fuGUfX6WMbfspnt03A2c+5h3SqWMW2EtxHN8uZm1lzwC3NRNzKnS7Vy4QxwwHShj7kz4x3RFK26ZGsz8JTBjWMeKro4RKqTG3O+/E8sULnSteAxtzJ9qMi7twTr3Oy5au0O+GcWgPbHQX3SBUkGFtv3pZd8aWhas5eC4LQ/X1eMA9tDggHw68nSOXDispL1ynjo4d8lKhHeClNq9oDaaZODVyWeqgzirs+ZBWn4HSuPq9olUNdQki7EnBresZ/zDQvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WSf69vwT+lmG/SvwgBfLRWA2So5is6C22jFG9fYAdGQ=;
 b=C4g5vBl38nP+8M0Jb62+nplnbogzO4ZY8X9pLWOYtwDPdfZzbTJq7cFcdgGsMA3tlMQ0rvFQnRcc8yjitbcplo6WXtHyhH1nSp3th5FQpSVJhZgf1fUT7ZqmISlx8fCRJHOdVzfJY5cxgfzr1vmExuFBYZMRWl91rJ9gR6vdFzDDK+/QZZOhTOS+OHgIGIzJMLA3Vsa542kHwBsMdt9PJur0/RjIiTSG1Z9XKUUyY8jZBb+e+c2T9lzbhlEor0SS4cPRPAat67bz5esdk0yO5zxj5uDeUj2bDvhjfbGVc3XeBmi48OE24jFOdAaZhYG4cbu+Uf1ohyK4W9IvnB7VUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WSf69vwT+lmG/SvwgBfLRWA2So5is6C22jFG9fYAdGQ=;
 b=ih/4+Cbpegp0tD0gPm9BQuZmjmca5cFdvFbs3XiLRHtb0k5cVRkO3YOqVln4URr6FHEfxbixVd5IlrE05vXErO7ApycAmLrssba+vRaCi4XkUMB5JmcTUUl8RXszAy92NejgIfZL8mazjrcepsPRJm8tZhqihFO+D5ET0mbkAaA=
Received: from SJ0PR03CA0228.namprd03.prod.outlook.com (2603:10b6:a03:39f::23)
 by SJ1PR12MB6026.namprd12.prod.outlook.com (2603:10b6:a03:48b::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.24; Tue, 6 Feb
 2024 15:59:39 +0000
Received: from SJ1PEPF00001CDD.namprd05.prod.outlook.com
 (2603:10b6:a03:39f:cafe::9c) by SJ0PR03CA0228.outlook.office365.com
 (2603:10b6:a03:39f::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36 via Frontend
 Transport; Tue, 6 Feb 2024 15:59:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CDD.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Tue, 6 Feb 2024 15:59:39 +0000
Received: from jz-tester2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 6 Feb
 2024 09:59:34 -0600
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.kuehling@amd.com>, <joseph.greathouse@amd.com>,
 <vladimir.indic@amd.com>, <david.yatsin@amd.com>, <jamesz@amd.com>
Subject: [PATCH v4 07/24] drm/amdkfd: check pcs_entry valid
Date: Tue, 6 Feb 2024 10:59:03 -0500
Message-ID: <20240206155920.3171418-8-James.Zhu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240206155920.3171418-1-James.Zhu@amd.com>
References: <20240206155920.3171418-1-James.Zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDD:EE_|SJ1PR12MB6026:EE_
X-MS-Office365-Filtering-Correlation-Id: 31d7c5a1-b09c-4231-515e-08dc272c9fc6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l+lFFmmftkAqzrarUg+A3eipQ/vWWZL++CFhTsLxTUWLBokufX9kZ/MHM1VnICYxnJU6DO2dqmDKfkJVAQIjWj2K5Whx4anS58O8yGLjqlomO/fVXD7PE6hdZyXTdHRhoDtyRVRECL5nv/uzNFiVGHwJ2OZURzvpzYM+hDZmS4fY4isyWPV0DiP7bhO0O81IRn/NIzINtMTafHZwuLLz6gzxkpRnlkbBOXzOnTG7Hj8ekImKU7SliDcDQdy+8mxN3NKcBGAkAhJ4rusFGp1uV5WYrGWBb5qEtyWRwZcKkWfDlLcLFyKQ3qzYrnQStNBx89i70+T4UH0NbBlNG6rD/ZUU0XEG315GSzJA8mCVzZyV6T9sf3+5tCEOyDHkpy6rauHgLslHUDvuagmiQM7K4OTO+dM+Qxokjlw/vNwPBBvh9tfu5Ji51tIzhdUrbReoA69L9mU5DOvtcIzOhvoKGH/HexVY7MlTfivsA4XX3QSKGE6FeWY4Y3GxhN/tK3/atC8LNZWaAIZsBpeP/CC1iDbJUG2ETGSzuc6hg3P+VQ4zaRH3tgj8gfWLvFo5CVG7xgKVoP2zA9yvgZKLRZelFKM8Sq3YQDSCtchTxFK1QIlT+CSdWxiPN+AUF28SM088vnZR1DoT0TSPv5Ow3+0SfZvIhKRNqr9RvULssY9cjK4nGALWJH1wlWQ7xzPtmt/4BySs4OS0F92/0RUgx6sM6yrtGmePkSZIxqG6Oi9wLmZa+SQWZOvDbC4S6dzklUcqjNinBoAcfvgPI4ZMfY9/+A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(396003)(39860400002)(136003)(376002)(230922051799003)(1800799012)(186009)(64100799003)(82310400011)(451199024)(46966006)(36840700001)(40470700004)(6916009)(54906003)(6666004)(7696005)(70206006)(8936002)(70586007)(4326008)(5660300002)(8676002)(2906002)(82740400003)(36860700001)(336012)(83380400001)(316002)(1076003)(478600001)(16526019)(26005)(2616005)(426003)(356005)(86362001)(81166007)(36756003)(41300700001)(40460700003)(40480700001)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2024 15:59:39.1136 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 31d7c5a1-b09c-4231-515e-08dc272c9fc6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CDD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6026
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

Check pcs_entry valid for pc sampling ioctl.

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c | 33 ++++++++++++++++++--
 1 file changed, 30 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
index a607fc148958..72c66d4bd24f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
@@ -195,6 +195,24 @@ static int kfd_pc_sample_destroy(struct kfd_process_device *pdd, uint32_t trace_
 int kfd_pc_sample(struct kfd_process_device *pdd,
 					struct kfd_ioctl_pc_sample_args __user *args)
 {
+	struct pc_sampling_entry *pcs_entry;
+
+	if (args->op != KFD_IOCTL_PCS_OP_QUERY_CAPABILITIES &&
+		args->op != KFD_IOCTL_PCS_OP_CREATE) {
+
+		mutex_lock(&pdd->dev->pcs_data.mutex);
+		pcs_entry = idr_find(&pdd->dev->pcs_data.hosttrap_entry.base.pc_sampling_idr,
+				args->trace_id);
+		mutex_unlock(&pdd->dev->pcs_data.mutex);
+
+		/* pcs_entry is only for this pc sampling process,
+		 * which has kfd_process->mutex protected here.
+		 */
+		if (!pcs_entry ||
+			pcs_entry->pdd != pdd)
+			return -EINVAL;
+	}
+
 	switch (args->op) {
 	case KFD_IOCTL_PCS_OP_QUERY_CAPABILITIES:
 		return kfd_pc_sample_query_cap(pdd, args);
@@ -203,13 +221,22 @@ int kfd_pc_sample(struct kfd_process_device *pdd,
 		return kfd_pc_sample_create(pdd, args);
 
 	case KFD_IOCTL_PCS_OP_DESTROY:
-		return kfd_pc_sample_destroy(pdd, args->trace_id);
+		if (pcs_entry->enabled)
+			return -EBUSY;
+		else
+			return kfd_pc_sample_destroy(pdd, args->trace_id);
 
 	case KFD_IOCTL_PCS_OP_START:
-		return kfd_pc_sample_start(pdd);
+		if (pcs_entry->enabled)
+			return -EALREADY;
+		else
+			return kfd_pc_sample_start(pdd);
 
 	case KFD_IOCTL_PCS_OP_STOP:
-		return kfd_pc_sample_stop(pdd);
+		if (!pcs_entry->enabled)
+			return -EALREADY;
+		else
+			return kfd_pc_sample_stop(pdd);
 	}
 
 	return -EINVAL;
-- 
2.25.1

