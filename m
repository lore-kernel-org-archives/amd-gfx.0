Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AA3AC77B61
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Apr 2023 19:12:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B6DDD10E420;
	Fri, 28 Apr 2023 19:12:38 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2060.outbound.protection.outlook.com [40.107.243.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 00EFE10E420
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Apr 2023 19:12:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UYF1uLuigWTQng7jJdCKmK8nqDhpKzH9Xd7j5/2FLbxKkVFmBDafCsXaQulftyZfE8RiC+TjLvvNg9E+DpvLY4jaJYKPF02vyCYKnSmmN8KWlJCa62HCOwJOkfGD+Sz5pwjcdUZiGahrLVCRoIqrYcOZARowotnCYl1oTGs2NCS2+wj3mWSzS97/V31HoSO2km+KmtfbRQakfK8Gb6jMPpAKm+5E5kM4tKuC5jygIuRL33qvzj2pOKMT2NoeuqmlvqdlzIKF9CBOwtQ39FsO/J/h1tjyQj4cv8ewM0lWUEjx6PDoulszQ1pHooZ3A5lAMUFOs22Z6t3dNAsUNG9F+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ot7V1gM+++ZVHakrz/ycm+hxEndbRYjA59XerGKZIzM=;
 b=TzJGBr3qemtDp+GjpxfkcdO6iZzkLgLS86ZW8+Q5wA1Igu7jEWOYjGK7KwEqrqT+YXuavGUDjJ/jM3VPceG9NhNNz6NqPj0HS9DlEqsQSd7UuhgIcp+1F9GOUJvaXcqyTJB902BB5x+c5oQa1MBQ8cLYAmXTu0I4EA4QtQnfTD8H7/MMlCPmO29xvgqPVuBGY/BsssKSYDHWIYNKxbkQKAD9JCuDubvyoFKIPcqaoai98DlLj+TcpnGE30ob7cX3Q8zPYcDfFw35NK5f9T5rcrxd1vpQXOrUI5GBKR4aZqoDsUJBmDSqXb6HrSkLtjgq/Gs5ii7clqLQB/8RhA2c8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ot7V1gM+++ZVHakrz/ycm+hxEndbRYjA59XerGKZIzM=;
 b=yZh6lnPU/ITwhhQbWkYnlenZF3k1AuzZzWPG/IqNRTtBJGZCTNKd++X2PWUjjCKJN+jRAdM4IAmUEN+hoyEr8GLVpBjJiL1k5nS2uu53PPZxk10TWvbrpWzYz29x3jcgNvZ1+dvFxB5AfHYHVQmUITs01e1BRR3/hgB1Q5Rq7Y4=
Received: from BN1PR14CA0019.namprd14.prod.outlook.com (2603:10b6:408:e3::24)
 by CH2PR12MB4039.namprd12.prod.outlook.com (2603:10b6:610:a8::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.24; Fri, 28 Apr
 2023 19:12:34 +0000
Received: from BN8NAM11FT083.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e3:cafe::e8) by BN1PR14CA0019.outlook.office365.com
 (2603:10b6:408:e3::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.24 via Frontend
 Transport; Fri, 28 Apr 2023 19:12:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT083.mail.protection.outlook.com (10.13.177.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6340.25 via Frontend Transport; Fri, 28 Apr 2023 19:12:34 +0000
Received: from ssomasek-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 28 Apr
 2023 14:12:33 -0500
From: Sreekant Somasekharan <sreekant.somasekharan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] drm/amdkfd: Expose proc sysfs folder contents after
 permission check
Date: Fri, 28 Apr 2023 15:12:19 -0400
Message-ID: <20230428191219.533646-1-sreekant.somasekharan@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT083:EE_|CH2PR12MB4039:EE_
X-MS-Office365-Filtering-Correlation-Id: 30c2842c-13a9-40c2-6694-08db481c85b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gMOy4o02qAFuwuJVM+K953+n1UNcBI+vrmWfi9PVDWMvm1NYFhrEsPmlJws67dASwGczvaI3LHorNO+f+zKCKdLB4GYInd4sPCIG5+/6fUFvf+nYA5UJBDqXUyrRxmen3TErhexzOAY6WrINWSF1toHtmDUUhDkLnaWdyb7pA71oXkjErkWWvQLBt5gsrX6yCprSSZ5EUR1AN4263ZvuWYPXsOktmmmgsk5JlGxmsf1+dAtJGxD48MlQfuXFod527t45N7L5bcYEywkqrer2O3bduWtAG+wbXVuCKAe1KklL+pWjtj0aVpVntXkIe3uK5ziMz0rsW0ZlX/4E3kdDPBXClCcOrKEl3xX+mlo36qEmn8Gjb/z4ZCnGImsj8MD58HFExsNdzD+Gw/iG9MyEItvut5wyEt5NjIFN3iQt5c2H/il0CcRj86orFG3gKujiDXpQP4o5OQ6vrgojFLbjY1xBzw/wdCM3MkgDQqdl2cnlmRbukI5FLwx84aeO1vgHwzZ/tqDfEMgTMexqidGoC3OLss+rA6igre0Hw3tLZL/w//ez56mosDTjRR0LfRiU3r4CxouLQVN9bBlHcDLqPE3ZzS9gQ0Qas1/XG65FS+pTdqXUfkKsaYKCavqLDGW8no0ylTEMJTuvlpxR6/EuEQAQqY/PS2bT/rwjKBoHFMu2PZuGJ3GPTSCASnFa7ts0JN8BEEAKee1rOSWPgdO1M//jpWjclks4+gLnqcAUKT4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(136003)(346002)(39860400002)(396003)(451199021)(40470700004)(46966006)(36840700001)(40460700003)(478600001)(5660300002)(8936002)(8676002)(36756003)(2906002)(86362001)(44832011)(82310400005)(70206006)(70586007)(4326008)(316002)(6916009)(40480700001)(82740400003)(81166007)(26005)(356005)(41300700001)(1076003)(83380400001)(36860700001)(2616005)(16526019)(186003)(336012)(426003)(6666004)(47076005)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2023 19:12:34.2327 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 30c2842c-13a9-40c2-6694-08db481c85b8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT083.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4039
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
 drivers/gpu/drm/amd/amdkfd/kfd_process.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 95cc63d9f578..8ff505d29bb4 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -275,6 +275,8 @@ static int kfd_get_cu_occupancy(struct attribute *attr, char *buffer)
 
 	pdd = container_of(attr, struct kfd_process_device, attr_cu_occupancy);
 	dev = pdd->dev;
+	if (dev && kfd_devcgroup_check_permission(dev))
+		return -EPERM;
 	if (dev->kfd2kgd->get_cu_occupancy == NULL)
 		return -EINVAL;
 
@@ -308,10 +310,14 @@ static ssize_t kfd_procfs_show(struct kobject *kobj, struct attribute *attr,
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
@@ -379,6 +385,8 @@ static ssize_t kfd_procfs_queue_show(struct kobject *kobj,
 				     struct attribute *attr, char *buffer)
 {
 	struct queue *q = container_of(kobj, struct queue, kobj);
+	if (q->device && kfd_devcgroup_check_permission(q->device))
+		return -EPERM;
 
 	if (!strcmp(attr->name, "size"))
 		return snprintf(buffer, PAGE_SIZE, "%llu",
@@ -402,6 +410,8 @@ static ssize_t kfd_procfs_stats_show(struct kobject *kobj,
 				attr_evict);
 		uint64_t evict_jiffies;
 
+		if (pdd->dev && kfd_devcgroup_check_permission(pdd->dev))
+			return -EPERM;
 		evict_jiffies = atomic64_read(&pdd->evict_duration_counter);
 
 		return snprintf(buffer,
@@ -427,16 +437,22 @@ static ssize_t kfd_sysfs_counters_show(struct kobject *kobj,
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

