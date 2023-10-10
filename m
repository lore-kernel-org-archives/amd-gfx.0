Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97632CD8C99
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Oct 2023 14:42:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 19CDB10E392;
	Tue, 10 Oct 2023 14:42:02 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20630.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::630])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 508A110E38C
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Oct 2023 14:41:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HIYo2S4Q33IjEHgAQupJXO7IQo972yelfkZ5rnHkkOeP62+QQMurKeVjImZDFbvbPrKOzgVEU/bLOb96y+fEncIN/kWW22SB4esMtSHs7WJL3F517Vrg8pOoujO32fzejyIIcBXsbMiaAXcPIhecX0R3a3T1D4rh2KiaJc5UBoRQAW+le7w/B0B1Bmm+3izLR3wLYKVKFBEK5JxaH1wh7aOv06Jsp0OvUeP1UQtu8UcIVxFXg1XX/JCifMsW2mlo3H414Xiq7sgHar1R+vS/sHTmml2/vyR9c8q7TTf4aqVGnSgVtLtcBSH3XgXyjJSNUg1Dn2nVqIFFTxS1WlQtuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pQJqgV4rwZkscvdfk9kWbFA0HFhU+y3IDrG0GRnjzcE=;
 b=B93OxAqAnywKdF/1msDag+sqJdNLqBEoIAytj9vwcvkgNjsekDk3LpcWz5OU5EHt32UHT0qoTjTbNbGLNGmhfFWVHQRqw3nDuJ+TfPwLx1ICBGLQGv6ADRr7f2z3H9W+oAygj+1WO2fqbO5oJrCfpwUoyOmox2QvB1U2cOl2o96W3TdCcCixtO1/jfTYl3yAa8N+VsdqIewoCGyrnjHGsW0BJs2Z9OLiB7zVbrvWQlD08zIQzJBRhvKi2+hO4zw+j65yiOchQb34Ct6EV5EYIXjRrPpKfRRGFCef2vhsTyqEDXQarENHEVSW+iH7qrBjo1R8ceeP6dZFnWopWDkQrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pQJqgV4rwZkscvdfk9kWbFA0HFhU+y3IDrG0GRnjzcE=;
 b=SoPvkWBQvOIMoS2XNQmyXRfVlY0/ka041ZZaBeFfl/XBTIfzSv5Pb/cGrXWw23HpnK0KvZ/21vjrF3u45D8/TJUc9iYaNJf92ZQFLp6G3emsHELcUVz/qLjYS4WJL+mt550VVkI9udsReAyo8RXy4/0Z1GS/RWR/kKiFx0bK8A0=
Received: from MW4P222CA0021.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::26)
 by DM6PR12MB4420.namprd12.prod.outlook.com (2603:10b6:5:2a7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Tue, 10 Oct
 2023 14:41:50 +0000
Received: from CO1PEPF000044F1.namprd05.prod.outlook.com
 (2603:10b6:303:114:cafe::a2) by MW4P222CA0021.outlook.office365.com
 (2603:10b6:303:114::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36 via Frontend
 Transport; Tue, 10 Oct 2023 14:41:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F1.mail.protection.outlook.com (10.167.241.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Tue, 10 Oct 2023 14:41:49 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 10 Oct
 2023 09:41:47 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 4/7] amd/amdkfd: Unmap range from GPUs based on granularity
Date: Tue, 10 Oct 2023 10:40:21 -0400
Message-ID: <20231010144024.3016-4-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20231010144024.3016-1-Philip.Yang@amd.com>
References: <20231010144024.3016-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F1:EE_|DM6PR12MB4420:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a6d5bed-278e-4a0c-ff9b-08dbc99f0987
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u1Bi7YdE4NrIbXs4R6FcX5vZs6kxz68yzLEnWNULqph4SliRdybHdjnjIeYdy5l9elXVFYOlIvrnUD55d8vn0U/W11JGj9qz0lpl8w9sNaS8o1EbpkoILQ2o9ZnoIMn4L3vxav3kVtZ49AR57Sr2WHYlyYgKllTX0I7+Zvf4fqznpu4daSn4P44oAtRHz5PLWQBpqIhsjK7OFBEqdB3u7o0pfP8WGHMsLwe3xMsUh6AgvM+R0B52xn5GjPWYCWTSoxVSe87WNge0l3S7dBGOsieWvG8rf+zwJRE+l5aMU1a2h+VKB9xLLrHe2Xiuil9G+nCPBpXSGjHq52ZTM1mpEz9KY7nxZ2P9Ghc65uRGP0t/VbRQ0cPiSA+0Re10SX9bvBJJ6rJN0MjMZWmIO+J6ShDc3XGOYMHQRsyUurYtp4MVvS1xDKYfpQp12p9QD1XtpHV+ywdLM75TMzzi5jaFVbknbDtukIzMI94yUaOszAFr+04/S2Xsjt4fetpk+wIuzhhAOY34MBnx52mZ0jyeWtRdI7EdnXv6zESg1A5e6vaTxH/OvfjgTkG1GycyPgeA1GEOTm68ei1CRZIGPmVUNzUVgoc80vUNEBAMbkPkrJb6qSz6dhq0aAyj6e5E3X3bExCAadNAZt6viToufI6RpD2n9axP4deLok9FmxET7fpmVErNZwXaolCDP42QE8HKgIgjp3KzSA048AzOGTxlJZqKm+J8tY9W+W0v3ytRhEJRUyQj/V68Gg9QMVxtHuiR
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(230922051799003)(1800799009)(186009)(82310400011)(451199024)(36840700001)(46966006)(40470700004)(508600001)(316002)(6916009)(83380400001)(5660300002)(8676002)(8936002)(4326008)(70206006)(6666004)(70586007)(54906003)(40460700003)(7696005)(2906002)(2616005)(1076003)(47076005)(36860700001)(16526019)(336012)(426003)(36756003)(26005)(356005)(86362001)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 14:41:49.7447 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a6d5bed-278e-4a0c-ff9b-08dbc99f0987
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4420
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
Cc: Philip Yang <Philip.Yang@amd.com>, Felix.Kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

When migrating the range to unmap the range from GPUs, align unmap start
and last address to the range granularity boundary. Skip unmap from
GPU if range is already unmapped from GPUs based on bitmap_mapped flag.

This optimizes the TLB flush and also solve the rocgdb CWSR migration
related issue.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 35 ++++++++++++++++++++++++----
 1 file changed, 31 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 4e1af4b181ea..daa996d7039d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -2066,6 +2066,26 @@ static void svm_range_restore_work(struct work_struct *work)
 	mmput(mm);
 }
 
+static unsigned long
+svm_range_align_start(struct svm_range *prange, unsigned long start)
+{
+	unsigned long start_align;
+
+	start_align = ALIGN_DOWN(start, 1UL << prange->granularity);
+	start_align = max_t(unsigned long, start_align, prange->start);
+	return start_align;
+}
+
+static unsigned long
+svm_range_align_last(struct svm_range *prange, unsigned long last)
+{
+	unsigned long last_align;
+
+	last_align = ALIGN(last + 1, 1UL << prange->granularity) - 1;
+	last_align = min_t(unsigned long, last_align, prange->last);
+	return last_align;
+}
+
 /**
  * svm_range_evict - evict svm range
  * @prange: svm range structure
@@ -2126,6 +2146,12 @@ svm_range_evict(struct svm_range *prange, struct mm_struct *mm,
 		unsigned long s, l;
 		uint32_t trigger;
 
+		if (!svm_range_partial_mapped(prange, start, last)) {
+			pr_debug("svms 0x%p [0x%lx 0x%lx] unmapped already\n",
+				prange->svms, start, last);
+			return 0;
+		}
+
 		if (event == MMU_NOTIFY_MIGRATE)
 			trigger = KFD_SVM_UNMAP_TRIGGER_MMU_NOTIFY_MIGRATE;
 		else
@@ -2133,16 +2159,17 @@ svm_range_evict(struct svm_range *prange, struct mm_struct *mm,
 
 		pr_debug("invalidate unmap svms 0x%p [0x%lx 0x%lx] from GPUs\n",
 			 prange->svms, start, last);
+
 		list_for_each_entry(pchild, &prange->child_list, child_list) {
 			mutex_lock_nested(&pchild->lock, 1);
-			s = max(start, pchild->start);
-			l = min(last, pchild->last);
+			s = svm_range_align_start(pchild, start);
+			l = svm_range_align_last(pchild, last);
 			if (l >= s)
 				svm_range_unmap_from_gpus(pchild, s, l, trigger);
 			mutex_unlock(&pchild->lock);
 		}
-		s = max(start, prange->start);
-		l = min(last, prange->last);
+		s = svm_range_align_start(prange, start);
+		l = svm_range_align_last(prange, last);
 		if (l >= s)
 			svm_range_unmap_from_gpus(prange, s, l, trigger);
 	}
-- 
2.35.1

