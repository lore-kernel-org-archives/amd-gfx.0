Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC081C77B61
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Apr 2023 19:02:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E7D4B10EDDF;
	Fri, 28 Apr 2023 19:02:11 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2061a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::61a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1306F10EDD1
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Apr 2023 19:02:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tg8fnOEB4e8/2sNsZP1pYDhULSCd629dmfrG3nBHKMZu1S+drKwtLmMGsJnOM8RHFWy35FYVOLEbosPj5Bd9tB1j9HCoLmKC4LCIKrDuIUSW5QpP0tpWSLto/8g4Dsp4eJ3jD0lPlZIwk/pR05nHgWER91wVxJLJV50WhiUDKj8qUHNR3WB/GBwSd+1FRpzRvqF0QI7AeiVc5PLL4afoU1mKH3pZAbxAzfLVvfnkE4Xxe8izrlZ0v90213qYwf/5IfNRcWW28Jm+rKr0jXIGG2ExIb9xf5TEqT0wHQCTm3M/UZPdAKbyNC+7aTm9Te8++ACwpR+tOo8ooTRZ2tq0/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YJ9e0s0PN2NLJmNSJYyyPqxIaL/D9OVW/rOQ2wuBS4A=;
 b=kN/795B3b1zpr76W9pZz33fKSbSAOb/Nzfd//ohb9eYe6jTlDixVfweQNPQ5yZHgjf7QsSf+qjFlxMVKV/RUs57azEQupA11TSN1HsTgE7Rf9cCMi9dLGaHp1LiXMax3oDhoU9mb0GqHY4+L2BeNe7mcPBSRNfYK6ukGunBnCK2JIh6Kyt9a/PemNKpQVMAUjGhF2ZIdqfA5Valt7yaZzGD8zeb1jwb2/j+Tp1CUwd6F/DsPxXQ2Pfcql7sQwRBrPEk4gwrVrQeM3kYI7ffxb0FHOVaPLVw0tqpbh8DsIktyZ0mff1HSaPWr7FJbTPHBUDZIpXPnCBMCrjrxjjrvBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YJ9e0s0PN2NLJmNSJYyyPqxIaL/D9OVW/rOQ2wuBS4A=;
 b=DgH7bz2bSXA0IUbEEM9RdyjRB0vvD+V6mwa2ugnJimru/tRaXbkV+9PwjPS0sq5oB1NTcRiVsbotGZD2WN+fgEYOFmVEpXZ7IzyQHjploO0VxNt6F1EqjCjdjzgGxPJk4XQGa8KADG75icAPl7sBZBpyV1l73JK4b5Bztz26/dM=
Received: from DS7PR03CA0170.namprd03.prod.outlook.com (2603:10b6:5:3b2::25)
 by SN7PR12MB7204.namprd12.prod.outlook.com (2603:10b6:806:2ab::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.20; Fri, 28 Apr
 2023 19:02:05 +0000
Received: from DS1PEPF0000E63D.namprd02.prod.outlook.com
 (2603:10b6:5:3b2:cafe::e) by DS7PR03CA0170.outlook.office365.com
 (2603:10b6:5:3b2::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.24 via Frontend
 Transport; Fri, 28 Apr 2023 19:02:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000E63D.mail.protection.outlook.com (10.167.17.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6340.19 via Frontend Transport; Fri, 28 Apr 2023 19:02:04 +0000
Received: from ssomasek-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 28 Apr
 2023 14:02:04 -0500
From: Sreekant Somasekharan <sreekant.somasekharan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: Expose proc sysfs folder contents after
 permission check
Date: Fri, 28 Apr 2023 15:01:38 -0400
Message-ID: <20230428190138.532524-1-sreekant.somasekharan@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E63D:EE_|SN7PR12MB7204:EE_
X-MS-Office365-Filtering-Correlation-Id: be2bcb87-167e-43b9-1959-08db481b0e89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qLKdXhHmPBUwEKiYlhZeu+VX3LKbLbTG2q2YJze8P+PSbakQWUrQXyKb7i++hWIFqwobYenEqAnJrU1Od4U5dMP6FNPQkPyPJjhN1VjelOEahS+1sY5ZIVfOA+L20337NZPQlgHOgENL78p4t5VrF9AsEnbiGYcmYweH4p4s+Rg97xghq2uftCaVBO4O946z13Si7ubJBvH4ppP2ENTQ8196F0l3JVshsForJ+qFcxOMfjq8vQlR7VGTK6ticKIYhHD/F5gh4aEx8N9UGLJTht42IzklZVWsDL1fhFsDPsuJ0Kj6Sdb7614mvIGHNdbe470nPsDn0DToZnASH8a3WONUpyFVgjZB2a4Uyz1qRpT/GIinOhT6o1nnia6UehbN8J6y0wC8lO0akqFVc8+xUf+pgvVPp145OTC3HJS0v9RiXo6KuYT4hE/BCdWWVQtp/BKZNkbM+QfiJbnAr/GMUtm2aiXP1AcXKFLs3BLXQRcT8MowFVzKvCcMiBdyXSuwQSk+9lbpo4re1YslHFT95DbyeqvDgcYtE51ZFugpLCIDTKmFjGQW2iTumxzRlQp8zh/rWLRJMlV3475kU4RpF0pWqrSujQdeeS6UeRInYLaftugUIxFb0QZtn6fGWMZo5LwCDMMwJIWsNXHon+RFBxIooH0j5p/oOjlrzMv9g336TJwLdIRPxjuvwOy5rNL/I7lNhLpuBgi7HdRzkQygQhuDEU18yn7/X+Tr+4Zvs9k=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(39860400002)(346002)(376002)(136003)(451199021)(40470700004)(36840700001)(46966006)(40460700003)(36756003)(44832011)(82310400005)(478600001)(81166007)(86362001)(8676002)(2906002)(8936002)(40480700001)(4326008)(356005)(82740400003)(70586007)(70206006)(316002)(41300700001)(5660300002)(26005)(16526019)(186003)(1076003)(83380400001)(426003)(336012)(47076005)(6916009)(2616005)(7696005)(36860700001)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2023 19:02:04.7458 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be2bcb87-167e-43b9-1959-08db481b0e89
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E63D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7204
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
Cc: Sreekant Somasekharan <sreekant.somasekharan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Access to proc sysfs folder/subfolder contents are permitted only
if kfd_devcgroup_check_permission() function returns success. This
will restrict users from accessing sysfs files for a process running
on a device to which users has no access.

Signed-off-by: Sreekant Somasekharan <sreekant.somasekharan@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_process.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 95cc63d9f578..195e4491a763 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -275,6 +275,8 @@ static int kfd_get_cu_occupancy(struct attribute *attr, char *buffer)
 
 	pdd = container_of(attr, struct kfd_process_device, attr_cu_occupancy);
 	dev = pdd->dev;
+	if (dev && kfd_devcgroup_check_permission(dev))
+		return -EPERM;
 	if (dev->kfd2kgd->get_cu_occupancy == NULL)
 		return -EINVAL;
 
@@ -303,15 +305,18 @@ static ssize_t kfd_procfs_show(struct kobject *kobj, struct attribute *attr,
 	if (strcmp(attr->name, "pasid") == 0) {
 		struct kfd_process *p = container_of(attr, struct kfd_process,
 						     attr_pasid);
-
 		return snprintf(buffer, PAGE_SIZE, "%d\n", p->pasid);
 	} else if (strncmp(attr->name, "vram_", 5) == 0) {
 		struct kfd_process_device *pdd = container_of(attr, struct kfd_process_device,
 							      attr_vram);
+		if (pdd->dev && kfd_devcgroup_check_permission(pdd->dev))
+			return -EPERM;
 		return snprintf(buffer, PAGE_SIZE, "%llu\n", READ_ONCE(pdd->vram_usage));
 	} else if (strncmp(attr->name, "sdma_", 5) == 0) {
 		struct kfd_process_device *pdd = container_of(attr, struct kfd_process_device,
 							      attr_sdma);
+		if (pdd->dev && kfd_devcgroup_check_permission(pdd->dev))
+			return -EPERM;
 		struct kfd_sdma_activity_handler_workarea sdma_activity_work_handler;
 
 		INIT_WORK(&sdma_activity_work_handler.sdma_activity_work,
@@ -379,6 +384,8 @@ static ssize_t kfd_procfs_queue_show(struct kobject *kobj,
 				     struct attribute *attr, char *buffer)
 {
 	struct queue *q = container_of(kobj, struct queue, kobj);
+	if (q->device && kfd_devcgroup_check_permission(q->device))
+		return -EPERM;
 
 	if (!strcmp(attr->name, "size"))
 		return snprintf(buffer, PAGE_SIZE, "%llu",
@@ -402,6 +409,8 @@ static ssize_t kfd_procfs_stats_show(struct kobject *kobj,
 				attr_evict);
 		uint64_t evict_jiffies;
 
+		if (pdd->dev && kfd_devcgroup_check_permission(pdd->dev))
+			return -EPERM;
 		evict_jiffies = atomic64_read(&pdd->evict_duration_counter);
 
 		return snprintf(buffer,
@@ -427,16 +436,22 @@ static ssize_t kfd_sysfs_counters_show(struct kobject *kobj,
 	if (!strcmp(attr->name, "faults")) {
 		pdd = container_of(attr, struct kfd_process_device,
 				   attr_faults);
+		if (pdd->dev && kfd_devcgroup_check_permission(pdd->dev))
+			return -EPERM;
 		return sysfs_emit(buf, "%llu\n", READ_ONCE(pdd->faults));
 	}
 	if (!strcmp(attr->name, "page_in")) {
 		pdd = container_of(attr, struct kfd_process_device,
 				   attr_page_in);
+		if (pdd->dev && kfd_devcgroup_check_permission(pdd->dev))
+			return -EPERM;
 		return sysfs_emit(buf, "%llu\n", READ_ONCE(pdd->page_in));
 	}
 	if (!strcmp(attr->name, "page_out")) {
 		pdd = container_of(attr, struct kfd_process_device,
 				   attr_page_out);
+		if (pdd->dev && kfd_devcgroup_check_permission(pdd->dev))
+			return -EPERM;
 		return sysfs_emit(buf, "%llu\n", READ_ONCE(pdd->page_out));
 	}
 	return 0;
-- 
2.25.1

