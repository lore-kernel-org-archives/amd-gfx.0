Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA6F6E909A3
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Feb 2026 13:59:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6EFE710E20E;
	Tue, 17 Feb 2026 13:59:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5KkKY34s";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012027.outbound.protection.outlook.com [52.101.53.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D83A10E20E
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Feb 2026 13:59:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uVo97RpZ3skff5iH8gBALnY+AfVOpk+vsOxba91EK9EwougZpaaDZn8lHI2IS3UOCMtLUHdH0a3jz8t8uH1L+MES9FVGpF+9zH5wzhVSJdZIbHWIc7zHFYuxWF1w55mxANJjwa3ETHQWW+ie8q24tp3KhkXt1VE1gTnF9tLwApZRo3W2kxHPNmGhoDKkIcfsux6T/G7MQBF3jNbXEj125SnQCRMcviphn3h6Tnp+duIGoy+yYu3VM9SgFjZZ8eDfOMBu5uI7z61vNTStoGL00AXkmvLa2xYb8emMRCqyWoQ3rbLJl1BOtro5e3O2fXxEm/+tsAq+Ro4pXIsDfEDuTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XMZYkA3iRT3eIFLHkyoUc9og29Orpcp81RRwqFWw7+E=;
 b=K9GfLvyd5Jt4iddVDZSeyi2Y6MwB9lakp+e5omPv6hVZ9HhKRYc9uFHCakGJxqlUWrpW+xgIcjXz16QUxjXnwvm2HiGUiqz9WAsUOzkRzNsj6J1HnvuWoLO4ZgfLKRW3yZWtSRT9+kQXA7XWrFlIIe2A6D+w+gNRdp4haTSK4kUnFvoylJ9PjNXY81kd988fl6jXA9FMjVZR3W/ArV8Czdp5LUvGA9nmT5b56z6u/rME03jfjFeahKCJhRcGDIqWEjIeG3+qs0DY1+4V3fUu6/oZtokCW7MjjFOnTwJD/ellRl25ATuzBVAs0MFNMf0nEy/PDKMIoQnoZ84dMieisw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XMZYkA3iRT3eIFLHkyoUc9og29Orpcp81RRwqFWw7+E=;
 b=5KkKY34sJn6CVPT8987JROh367e9zSBc65tG464LQbvKiACPw0U8mIvt6pgHJt4pL0oSsQJn3s5iKBj3ifMroeOpWHBvwUjIa4Nl4ULRg0fFmvdFUBGsNT0KDDEvJOssvi19oymgwODdrwEd2V7kXa9kSRnz03xx4drKIRnimtg=
Received: from BY5PR13CA0032.namprd13.prod.outlook.com (2603:10b6:a03:180::45)
 by BL1PR12MB5803.namprd12.prod.outlook.com (2603:10b6:208:393::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.13; Tue, 17 Feb
 2026 13:59:11 +0000
Received: from SJ1PEPF000023D4.namprd21.prod.outlook.com
 (2603:10b6:a03:180:cafe::4e) by BY5PR13CA0032.outlook.office365.com
 (2603:10b6:a03:180::45) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.13 via Frontend Transport; Tue,
 17 Feb 2026 13:59:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF000023D4.mail.protection.outlook.com (10.167.244.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.0 via Frontend Transport; Tue, 17 Feb 2026 13:59:10 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 17 Feb
 2026 07:59:10 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 17 Feb
 2026 07:59:10 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 17 Feb 2026 07:59:09 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Xiaogang Chen
 <xiaogang.chen@amd.com>, Philip Yang <Philip.Yang@amd.com>
Subject: [PATCH] Revert "drm/amdkfd: Use huge page size to check split svm
 range alignment"
Date: Tue, 17 Feb 2026 08:59:01 -0500
Message-ID: <20260217135901.21032-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D4:EE_|BL1PR12MB5803:EE_
X-MS-Office365-Filtering-Correlation-Id: f84cf276-1083-4355-3f39-08de6e2cb9f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024|13003099007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?iELDflLzLX66bH8GZN8bLgzQyhIaWLOhHu43y2I3BnYE1bqtZsGYoqiVGEZ8?=
 =?us-ascii?Q?BQN7jLCfNi7ZDeOYOhBMtdFx5M22SEL3plx9ilGGCRJdrUWLBJm6mw0h2ZSF?=
 =?us-ascii?Q?/Mbw60GmTLM1GuFdiJB6z/Ktf0mDu9Odp4EEo+IK3anq2P82ZwnBUB5j9+N9?=
 =?us-ascii?Q?9ldJvpory4mbUvD9s6u3KshJO7wKAL/XCr5p8YhFXonmMocOYV0MWXHsskCH?=
 =?us-ascii?Q?rgIyGaruE4QRKheuIoInXz4RF8glq2Nb2GDy2YOy60cYp9ieBquB19WdF0Jx?=
 =?us-ascii?Q?bv/qYb29n+WwyiMKFHisY8YrkDob+K88Qy/W7Dh9wDgmF0xXjm+qUGcKQ0bD?=
 =?us-ascii?Q?XCtfvBJzT7fgAPLDpDScj2/5oCOQcjXt3AhdpfZrlan4P5Z6EeThJLodmIrF?=
 =?us-ascii?Q?rBB7WeqobljZDEN3K3f9WLs6mOPiG2yRg33knzjKMeMiccCgy3bmRO+4FQ4U?=
 =?us-ascii?Q?Ehlg7wYsW+08S6AOn0nsz/Iiow2kAG8kggQFD3MPImZ7gSnpFeig41DRd4YR?=
 =?us-ascii?Q?c0hszKecfty4kKo3MvQqL/Je0VzNb09OgFwgOtbbMWnjL9M9c1XREdLg76Kg?=
 =?us-ascii?Q?+ijNKBM85CV2J9cLQE9jSgllO8yv28R5wOevvnyeFBOvERXAdM8qP13fYze0?=
 =?us-ascii?Q?7McB9RwJALsIAfHNvxmUrpjkQUjCqR3i/SgCxSzEoR7v0aHifej96k5gMrQu?=
 =?us-ascii?Q?wsuCrt9y5FAgOc2Su8l+KuFPB2tLh77QH3BwdBZAZP4lZQVqllR2XdbTGT8h?=
 =?us-ascii?Q?OqeROmiRVz3ddsnqLsxvbptu+djBOOQ+cm97OIG4u4CZZRtmvgxY2W57Wvm5?=
 =?us-ascii?Q?kscOm9jfT5oCdnCw5aDOhrnNSvjzcHJx0qv3aDYVhO9kfa9uYuUILbnWF77G?=
 =?us-ascii?Q?gQU4NrlP8RO/fUfhDTq6kQZYz7O7JeFGjdm7nIeeElcq20NfvIQI4i1EGfQK?=
 =?us-ascii?Q?SWsPMxRjtCwlFpBfS8yH+klTzYIGEY56FHkO1vM8Jb3m5mJ9Mx0SmahOrN4f?=
 =?us-ascii?Q?zirh6u7QO9zHQmPuyiLHIVKUKDiksb6/Fq2NwPV32dwHOFXUxAz4QidEDjre?=
 =?us-ascii?Q?zqBvZIhciNfJ7b9mdWlmhVzAfQstZcOVZtHJM6qNL9Ei/DTNYFCGDUCNeaBy?=
 =?us-ascii?Q?NEewL2bCt9k7R6hkTCitWMaA/68e9/atybo7RrN/30aG0//nUTpCYRCfWOkA?=
 =?us-ascii?Q?NCSMoFeS+KvBmixWS0hHB+anGGyfe58dOhP10JAjwbQtWQqxJ2evg+9F9KIX?=
 =?us-ascii?Q?UA7VkutmVDe0NCOy+tPBYC1e9glf5t6jE1KJ2AgsVZ/NBSEnrHRftzTdHzjJ?=
 =?us-ascii?Q?FMt1BmYP0g2T9xlxDR23vu+25TuyNn5HoSQz4uumkHRPLzud+WgecgSAlsEc?=
 =?us-ascii?Q?KUbnNbZoPYr3Ylg6z+vYHeMWuZ9/JXJ1W17wcEOEvWd5kiI3Nrb4zmYuwCA0?=
 =?us-ascii?Q?FSngYkQJvHUfVDWFg4kFOH48q6tV88RXyggAuGg9uc9PPso04vrGyD8um2Wv?=
 =?us-ascii?Q?yAHmP8OEbAfwhjYlYfF4GpJSFirYYFXEoHRsT64/WpHNL+qD2JcbA3GRJxLG?=
 =?us-ascii?Q?mG2jIBUa3uWNrXgikwHf3QBS5gP4F+IAFaDXsx1udVRaZV0oMfo/xDCyvelR?=
 =?us-ascii?Q?sQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 92l1XNHcuWwYmjnpqwHzny9/zwBTZEVE6CqnnxxcdmqIfsNHB/DYNpy3ojmBDcMpVso1BRiknRA8AMVoGz+LgribOuH89rc9lSR0+1GAfto8Ob9x9jWmdl7oEbbrzgmFOZhJyhQ/VBO0LVYoiWIHwgTp7MCq6MWHXjA6Y4x1ehujszqwuuwxZMkNvp67FAdGDUo1vBPB/TwkVjKD5Qb38jt6jro+/7lmhSbs7JIhNkcv+N+klgTv7N5F4YhhhJEN2vh0IoyByu/sKntklPSRAN6qhO2+5GaipD7190TK8AFRYJ35oHBAmL1X7N/DAxiwyQrNwNsXPUr/PlK4/WZwiyqzZtMh8i3quEQ2Ovxk+m79OlUgdaR+Fohrocff6QEt09OSTXSotA35c1vNv8N9UCHsCBZv+kqNoVrEfUHK80rfbm0rC4e6TckV1rMJk5xi
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2026 13:59:10.9394 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f84cf276-1083-4355-3f39-08de6e2cb9f6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D4.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5803
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

This reverts commit 448ee45353ef9fb1a34f5f26eb3f48923c6f0898.

This causes GPU pagefaults in some HIP applications.

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4914
Cc: Xiaogang Chen <xiaogang.chen@amd.com>
Cc: Philip Yang <Philip.Yang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 46 +++++++++-------------------
 1 file changed, 14 insertions(+), 32 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index fcddb54a439f9..bbca6d61a35b4 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1145,48 +1145,30 @@ static int
 svm_range_split_tail(struct svm_range *prange, uint64_t new_last,
 		     struct list_head *insert_list, struct list_head *remap_list)
 {
-	unsigned long last_align_down = ALIGN_DOWN(prange->last, 512);
-	unsigned long start_align = ALIGN(prange->start, 512);
-	bool huge_page_mapping = last_align_down > start_align;
 	struct svm_range *tail = NULL;
-	int r;
-
-	r = svm_range_split(prange, prange->start, new_last, &tail);
-
-	if (r)
-		return r;
+	int r = svm_range_split(prange, prange->start, new_last, &tail);
 
-	list_add(&tail->list, insert_list);
-
-	if (huge_page_mapping && tail->start > start_align &&
-	    tail->start < last_align_down && (!IS_ALIGNED(tail->start, 512)))
-		list_add(&tail->update_list, remap_list);
-
-	return 0;
+	if (!r) {
+		list_add(&tail->list, insert_list);
+		if (!IS_ALIGNED(new_last + 1, 1UL << prange->granularity))
+			list_add(&tail->update_list, remap_list);
+	}
+	return r;
 }
 
 static int
 svm_range_split_head(struct svm_range *prange, uint64_t new_start,
 		     struct list_head *insert_list, struct list_head *remap_list)
 {
-	unsigned long last_align_down = ALIGN_DOWN(prange->last, 512);
-	unsigned long start_align = ALIGN(prange->start, 512);
-	bool huge_page_mapping = last_align_down > start_align;
 	struct svm_range *head = NULL;
-	int r;
-
-	r = svm_range_split(prange, new_start, prange->last, &head);
-
-	if (r)
-		return r;
+	int r = svm_range_split(prange, new_start, prange->last, &head);
 
-	list_add(&head->list, insert_list);
-
-	if (huge_page_mapping && head->last + 1 > start_align &&
-	    head->last + 1 < last_align_down && (!IS_ALIGNED(head->last, 512)))
-		list_add(&head->update_list, remap_list);
-
-	return 0;
+	if (!r) {
+		list_add(&head->list, insert_list);
+		if (!IS_ALIGNED(new_start, 1UL << prange->granularity))
+			list_add(&head->update_list, remap_list);
+	}
+	return r;
 }
 
 static void
-- 
2.53.0

