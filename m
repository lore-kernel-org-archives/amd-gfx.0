Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67FC2C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jun 2022 19:03:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E929012A86A;
	Thu, 30 Jun 2022 19:03:49 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2064.outbound.protection.outlook.com [40.107.92.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B9F212A86F
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jun 2022 19:03:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OE7PJG0DqeNUeqxR2vfS+ryRf75N4ql76KYxX2NjA8edo3JUK5O1rEM6ZgFn2DY0JiEXZln5b2HCKmZIb9yfnnMbONJan8LvfVKLvR4BqnmMHvysL0mwMRByzy/XB8QHx+l0nVX91B2FXCQJMcAn1TIG7b/jvHoRIRIb2TzTEwNFGGZ43h/utx7pHwad//kwCfSbp/FIwz5zn3A/1wiM5nId0Ug3W7GGOi9D9yo0RJsQ91Z9CJBWfGtA61deK8uuVBOE0OgLOJbkx/UQ3dAkO9k6wcnxVZH+0qYKYzRfhUQZOhLIL0g1/0hrMIIzwYtCR2lKog38K44b2WF1GRHeCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ouCqI6yQPmbB9u6oFTuJXwDSv4PnbxQLebGgM+LUnz4=;
 b=ZYV2rPvaQKASJiSxE7VFVybSLRSOojq4WIt79hRX/Smlh3e+FBHcxB772/7L7RACxFU8nExEu6BMGgV1GobaEVOlGr5j3WYx90S1KcFjd5A9sEVxeow1sNppvnV9Jen26UFQPlaNm32bir5iH/GaztK2dfIUk9qB0NLJJrPlOfjccvDKCqzyiu80PYtEdy/RsJ6JCitZJZuoRmed6ElIKUhb+8elw/ISZKi7ZiBMzmHIgsQInfut4r3vd1t1jYbUUS5kEs1gEyZvFw/Uk7G8rpKem7uc70KkQnT28fnVV4mwQGtdOPaaEwMp6xYBpW2ADoIGcaBErXpfXbFGdz0szg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ouCqI6yQPmbB9u6oFTuJXwDSv4PnbxQLebGgM+LUnz4=;
 b=K/c86jqfq9HAIt2/nnmpsTTrXCGGcEfVEZNEFjmrjNYBJpREsjVNfpHvektnx6CTn/7j9pyHz3hhmmkRGrMvVlCQwUo2urZrAJs1fKvLJuAFQvocqE+aSWtwU6b48nAKoZb/mkY+Pa7rRY7JeStXmzPqiqX4u6Lze6cI+NJXxRI=
Received: from DS7PR03CA0219.namprd03.prod.outlook.com (2603:10b6:5:3ba::14)
 by CH2PR12MB4646.namprd12.prod.outlook.com (2603:10b6:610:11::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.18; Thu, 30 Jun
 2022 19:03:45 +0000
Received: from DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3ba:cafe::8e) by DS7PR03CA0219.outlook.office365.com
 (2603:10b6:5:3ba::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.17 via Frontend
 Transport; Thu, 30 Jun 2022 19:03:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT010.mail.protection.outlook.com (10.13.172.222) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5395.14 via Frontend Transport; Thu, 30 Jun 2022 19:03:45 +0000
Received: from eric-hp-elitebook-845-g7.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 30 Jun 2022 14:03:44 -0500
From: Eric Huang <jinhuieric.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/5] drm/amdkfd: optimize svm range evict
Date: Thu, 30 Jun 2022 15:03:07 -0400
Message-ID: <20220630190309.119238-4-jinhuieric.huang@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 11357575-a6f3-457a-1690-08da5acb41ac
X-MS-TrafficTypeDiagnostic: CH2PR12MB4646:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OwDixXa2KdWarptD6FyEvDSbMQt4F4vS9Z5g00q/pFeTmbmj6ATNbHfakulaHPPjhgjnwJ2J6yqCBvRnanLt/DqRFsc797OTJ41RPK5KYYs0qC4wL+cMvanY2PLIcGHqGGkzTqUA9riSJhCC06ocX7Va9tq2DCDkZcrmQ9b4CinOScy8Pn+xYBjxD72qSOUfDn/FAkvqffoynpAdj2XgRknbf1d8E/wcL40wQxZCJZs6sMkdIc26xar4kEWW/0RrqcuGcWozPAwG4xdwwAKr9j9nzflZOTpYdfwHdhaJuNRCgKV4q+Qa+KA3324TylTbxQZIZuDgPGt3D+oCCTK8cF/AhKBoBFq16p9N7o3hNqssexp50qhk2bQmgYi44KDQ6ua69OAs1L4Csrta1F378IC/laHVpZDyg7pRHzsRTtLY8TPRCbGZSaDvWRGwt2NTq1YCaRZnLoUI8WgRonUi/0UwkGSh8axhlBMVsICicy3LadsBETrVJ6vBV0OJonYOGu+zIcvaxtl+epuD8K2SkHkDMzmMaRkKyqF9dfgYiC1pW9loPCejcwfHfLp6xKiCSqWDG34Da161mUouG1BFwbZfe1gwuuuzD1g8Grnocygck6w1KTM4Ottffz/7QVc6IwRkcJHsWv8ICj25yYBE5DjXpdmBqOLNB21dLf/nqjPag2M85VjHW5P1VIaS24oe3bH72r3dlslPdMeEDspG5XqjWqvo8eadRQsKQoH4gu6ByUYHwpDIElbTjH9/2/sN6qUyAcsBYvq4PNzwmZsd4mhgRp/70AiBEK+iiwaGWJ2iEd8ubBt5f4Llit8RZ2CvdV6AnpjDYOxYTg8k15UAjELY91PE+1odRLz5gcfOhUk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(376002)(396003)(346002)(39860400002)(46966006)(40470700004)(36840700001)(5660300002)(478600001)(70586007)(7696005)(336012)(1076003)(41300700001)(4326008)(70206006)(186003)(40480700001)(83380400001)(8676002)(54906003)(316002)(81166007)(16526019)(82740400003)(2616005)(356005)(82310400005)(26005)(8936002)(86362001)(6666004)(6916009)(426003)(36860700001)(47076005)(36756003)(40460700003)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2022 19:03:45.2066 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 11357575-a6f3-457a-1690-08da5acb41ac
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4646
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

It is to avoid unnecessary queue eviction when range
is not mapped to gpu.

Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 586bef4fcc8a..1f1f8f2dfa28 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1775,8 +1775,12 @@ svm_range_evict(struct svm_range *prange, struct mm_struct *mm,
 	if (!p->xnack_enabled ||
 	    (prange->flags & KFD_IOCTL_SVM_FLAG_GPU_ALWAYS_MAPPED)) {
 		int evicted_ranges;
+		bool mapped = prange->mapped_to_gpu;
 
 		list_for_each_entry(pchild, &prange->child_list, child_list) {
+			if (!pchild->mapped_to_gpu)
+				continue;
+			mapped = true;
 			mutex_lock_nested(&pchild->lock, 1);
 			if (pchild->start <= last && pchild->last >= start) {
 				pr_debug("increment pchild invalid [0x%lx 0x%lx]\n",
@@ -1786,6 +1790,9 @@ svm_range_evict(struct svm_range *prange, struct mm_struct *mm,
 			mutex_unlock(&pchild->lock);
 		}
 
+		if (!mapped)
+			return r;
+
 		if (prange->start <= last && prange->last >= start)
 			atomic_inc(&prange->invalid);
 
-- 
2.25.1

