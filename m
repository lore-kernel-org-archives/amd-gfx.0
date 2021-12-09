Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19779C433FE
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Dec 2021 16:56:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 16CBD10E6ED;
	Thu,  9 Dec 2021 16:53:21 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2078.outbound.protection.outlook.com [40.107.244.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E195189F2D
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Dec 2021 07:50:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aGrDgcIo+L61mrQ7cmZge36SHlc996iyawfoxUqI7y3iRxt2Glcn1folcflEvZeP9CWnmfIGktTYTt7q5LQBfTmOIdE74/zHO3KA9Hi6uKSeRtEOE7MFgEweJSJkkjUp0rp0viBwfX0aj3+HGcDdIs/joGMYh8F/FtEUnhA9TtohZIgWcJOkhYczdb53TMKwAbFhvLajdVjk9Ds2nXc59KWSnB++m4gyb02QkZm0CZCAZCSAINfRCVVeKHONL0ysljY5SCnkE6CyQsqIacZqgrgY9ER3/s2pYnvdRORXIxUzmiJciOKpy52cGcvEVrg9JcAhx4mdTSpbRQo90DwkzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/WLBm8cf1s5U65wM4pJJNdH5UOCP/I1ZcmB/YrZqO/g=;
 b=JFIW8u7JWNnNOTkD1rN945hikvxvj1PTbTTAUXGNpm/UIzYUvkIUwh6ulNc3NwObm/4TCGX1ajtLGCi0ABswgcRGqChqXipam4x2aP+ktt4lpfvROy1BRRNSWhRABzvf1IEH5Iv7HEoXHja+IiDfdU0HtNSebuqgACUwo8ZKYXQvuQcR1ztzOZNj5W49Z5Jji2kaOGH+M6stmQqW4bMvfBErbOXqxDxxs86P2Le4joISIPQIG667XejOkK5lzAu23pDRUl+2MV6ZS6v1C+NMxp0zjPLToV8UhIb0s+N1s7ySj96U5V+am2fSEGp8oS0rcM7n27sfkFC1LwRfJL+sBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/WLBm8cf1s5U65wM4pJJNdH5UOCP/I1ZcmB/YrZqO/g=;
 b=M3/Lc4hPxxPsdNKsnyAxZGD31pp1Ll9bybz7S3exbU66tFnpzz28trbp5nAPnfMcHZk9B0lUNsDOU9KwsqKWdJwWSWxX7yLdZ/NUgISMVuCRMzDP+PPeT3xBNWUSLIjTbtWH9Nx8/GcZS/vnJO6QQPFVtPPkB9LEglePV7BXnbQ=
Received: from DM5PR20CA0043.namprd20.prod.outlook.com (2603:10b6:3:13d::29)
 by DM6PR12MB3131.namprd12.prod.outlook.com (2603:10b6:5:11d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Thu, 9 Dec
 2021 07:50:22 +0000
Received: from DM6NAM11FT053.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:13d:cafe::a0) by DM5PR20CA0043.outlook.office365.com
 (2603:10b6:3:13d::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.17 via Frontend
 Transport; Thu, 9 Dec 2021 07:50:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT053.mail.protection.outlook.com (10.13.173.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4755.13 via Frontend Transport; Thu, 9 Dec 2021 07:50:22 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 9 Dec
 2021 01:50:13 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 9 Dec
 2021 01:50:13 -0600
Received: from Xiaogang-ROCM-Dev.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.17
 via Frontend Transport; Thu, 9 Dec 2021 01:50:12 -0600
From: Xiaogang.Chen <xiaogang.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: explicitly create/destroy queue attributes under
 /sys
Date: Thu, 9 Dec 2021 01:49:18 -0600
Message-ID: <20211209074918.1555320-1-xiaogang.chen@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 10177d98-6202-47d3-ffe7-08d9bae88e0c
X-MS-TrafficTypeDiagnostic: DM6PR12MB3131:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB31314C263ED48A91885944E2E3709@DM6PR12MB3131.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:248;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oeTtT3Qsz8ppWYzIWiROU7lQwZIp/qeYwmCKZgveSjG/NeEsYVRwRPlNkjODNTldKq7/q23vw2nVh28FJNkXcC7B66BqS2dQvBFyM4EALyjbLL2THx8uE6Nr28NbuSiISnT+Nd/VApG4+M64DnPQUUfIetmpW3Yw86XYEoAw5gDtMFl1zi0Nqq19LDIcUay+YLofRZLesVT0Z0REbqnyCecrAuZcC3NTDv41WJrxsmCOLGkLRYIACQT5YO+mEFl4ihfd2V6g/gtgPa7XxACtHiC+oxCXszPyDll5owHJTBuxHAKMxdNfhGD7vRvNWI70u0g2nxKTAeU3WCppT2g4Iut8SxpXnX6N0hIqOcRWip1/hpmqu6ilmFV23SGUlnm/SkWgtOvaXlUpk2JJMdzX9Ys30ZHIkjCw1zefdICdyYAWNnENTw6UcA3887yxs4tc6+Rgr+Z4eqo+G6VVc18KwwKrzXfQKpmEb3WlVGSC4HPsZhP277Sjm72dTweiV39sLBOCJFWMyYXClEqmsJujyfBFwsdqWJmhHvWvQv9zOoLtlV937Oy3iwcPYtugcwrjrwe/0NmJABVocZg+RtzL1iXkwSB50QdoK3dFmBNRr+fTOsqRFntmqb6jzXWRHjtMkbToe48rWGEW7hZT/L9aWh3x78WiQl83NGx9A9DXaRMB6GMloqhHZJpSgjOOu9Q3HUTz8JVzLITKZ2sRFJiFN91aw/E74LmJyaufYjdAyOzkQvfiXIRm69GN7gh2B4N+NopbleXvF4TDDEF0qDmchj4sqTr3Bl+uN3a/7XBfZfo=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700001)(83380400001)(36756003)(8676002)(86362001)(8936002)(26005)(81166007)(36860700001)(186003)(47076005)(7696005)(356005)(316002)(4326008)(336012)(70206006)(2906002)(70586007)(2616005)(426003)(82310400004)(508600001)(6916009)(40460700001)(5660300002)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2021 07:50:22.7250 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 10177d98-6202-47d3-ffe7-08d9bae88e0c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT053.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3131
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
Cc: xiaogang.chen@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Xiaogang Chen <xiaogang.chen@amd.com>

When application is about finish it destroys queues it has created by
an ioctl. Driver deletes queue entry(/sys/class/kfd/kfd/proc/pid/queues/queueid/)
which is directory including this queue all attributes. Low level kernel
code deletes all attributes under this directory. The lock from kernel is
on queue entry, not its attributes. At meantime another user space application
can read the attributes. There is possibility that the application can
hold/read the attributes while kernel is deleting the queue entry, cause
the application have invalid memory access, then killed by kernel.

Driver changes: explicitly create/destroy each attribute for each queue,
let kernel put lock on each attribute too.

Signed-off-by: Xiaogang Chen <xiaogang.chen@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h    |  3 +++
 drivers/gpu/drm/amd/amdkfd/kfd_process.c | 33 +++++++-----------------
 2 files changed, 13 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 0c3f911e3bf4..045da300749e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -546,6 +546,9 @@ struct queue {
 
 	/* procfs */
 	struct kobject kobj;
+	struct attribute attr_guid;
+	struct attribute attr_size;
+	struct attribute attr_type;
 };
 
 enum KFD_MQD_TYPE {
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 9158f9754a24..04a5638f9196 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -73,6 +73,8 @@ static void evict_process_worker(struct work_struct *work);
 static void restore_process_worker(struct work_struct *work);
 
 static void kfd_process_device_destroy_cwsr_dgpu(struct kfd_process_device *pdd);
+static void kfd_sysfs_create_file(struct kobject *kobj, struct attribute *attr,
+				char *name);
 
 struct kfd_procfs_tree {
 	struct kobject *kobj;
@@ -441,35 +443,12 @@ static ssize_t kfd_sysfs_counters_show(struct kobject *kobj,
 	return 0;
 }
 
-static struct attribute attr_queue_size = {
-	.name = "size",
-	.mode = KFD_SYSFS_FILE_MODE
-};
-
-static struct attribute attr_queue_type = {
-	.name = "type",
-	.mode = KFD_SYSFS_FILE_MODE
-};
-
-static struct attribute attr_queue_gpuid = {
-	.name = "gpuid",
-	.mode = KFD_SYSFS_FILE_MODE
-};
-
-static struct attribute *procfs_queue_attrs[] = {
-	&attr_queue_size,
-	&attr_queue_type,
-	&attr_queue_gpuid,
-	NULL
-};
-
 static const struct sysfs_ops procfs_queue_ops = {
 	.show = kfd_procfs_queue_show,
 };
 
 static struct kobj_type procfs_queue_type = {
 	.sysfs_ops = &procfs_queue_ops,
-	.default_attrs = procfs_queue_attrs,
 };
 
 static const struct sysfs_ops procfs_stats_ops = {
@@ -511,6 +490,10 @@ int kfd_procfs_add_queue(struct queue *q)
 		return ret;
 	}
 
+	kfd_sysfs_create_file(&q->kobj, &q->attr_guid, "guid");
+	kfd_sysfs_create_file(&q->kobj, &q->attr_size, "size");
+	kfd_sysfs_create_file(&q->kobj, &q->attr_type, "type");
+
 	return 0;
 }
 
@@ -655,6 +638,10 @@ void kfd_procfs_del_queue(struct queue *q)
 	if (!q)
 		return;
 
+	sysfs_remove_file(&q->kobj, &q->attr_guid);
+	sysfs_remove_file(&q->kobj, &q->attr_size);
+	sysfs_remove_file(&q->kobj, &q->attr_type);
+
 	kobject_del(&q->kobj);
 	kobject_put(&q->kobj);
 }
-- 
2.25.1

