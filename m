Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0955410F2863
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Mar 2026 18:00:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D98410E212;
	Fri, 27 Mar 2026 18:00:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="c0TXnDNB";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011056.outbound.protection.outlook.com [40.107.208.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3519A10EC95
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Mar 2026 18:00:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tM+m0tVIZeu9B7WtrLcwHjAqp/WI8WlJ/JxYvdVk3PkqX6BgbeX55rElwCH/psT9ysco5RKMpByuee9pJAY0IFDvl2GWK1SiSJltfeBtphawGLnSzMwgE/OHMp8KRmzhJo460/ZLVmR59dfREQc66scjXdX7cXrf9KO7IfNDLnO9rnUQPr2TEvSv6hJT5e+sWIr3TyYgY3AhkN/xWFNy0zdrV8zyhXVOVI/uBMrhydGxjZ5q20+YJB/CBCOHo5xBEka/UIDkxNKNmlRVnILZzx+uRLH3YwPd80fcayBNupc09V0xtsrzI/oL+LkMIL901jqvYXMyW8xUxGzbf+Grjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YzpwEoQF4bzjUb12JP42uwErccdERuD/iOqGh25MLEM=;
 b=x92wqHu13za921ZxwvPC1CmmxNm/q50R4VzCLZd5hUNnqW63OTpvuX1u5q44pxybDU7x4wlhsRwut25BprbEb9i8Y54wI8phkHxfQfueUrGIkqFbsz/T9XXP54ynOBAPgAIsZ7ThCZLlfkzG/D5tI9TGtYjk2si+pzvIsx/UyCI7UqGfvAcjubVo2gw7DoIZUydZU8xFLOnwLyVkoPF2aG8Q0jmP4kWdfMs5o4UnFGg4sqh5Y5Cnr5N7gIOYg4MvULg+pc4KJuEbspf79qYN7WRsJWkSMzIKGp9rglEqDHV2xKdeESG3TAfdPljW40XfwEocqRuB3dBZM6vpWHGBGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YzpwEoQF4bzjUb12JP42uwErccdERuD/iOqGh25MLEM=;
 b=c0TXnDNBFoJbQh/ZJgoYuvYvfyGbotVPPDa//WnF/MWZkBhGmyZt9FCfaZYLz4sVifJ4Y8Jwyy0YeY4RvyLZ8eOLVAIUb3JqH5T6GxIz1x5Dt4wW6j4CUO8XV7Z7DWk4Is3hUFabghKVoT2PMtApls1fXwazO6Bmyp7HTNcov8Q=
Received: from CY8PR12CA0010.namprd12.prod.outlook.com (2603:10b6:930:4e::25)
 by DS3PR12MB999218.namprd12.prod.outlook.com (2603:10b6:8:38e::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.10; Fri, 27 Mar
 2026 18:00:52 +0000
Received: from CY4PEPF0000EDD3.namprd03.prod.outlook.com
 (2603:10b6:930:4e:cafe::1e) by CY8PR12CA0010.outlook.office365.com
 (2603:10b6:930:4e::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.24 via Frontend Transport; Fri,
 27 Mar 2026 18:00:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EDD3.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Fri, 27 Mar 2026 18:00:51 +0000
Received: from eric-hp-elitebook-845-g7.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 27 Mar 2026 13:00:50 -0500
From: Eric Huang <jinhuieric.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Eric Huang <jinhuieric.huang@amd.com>
Subject: [PATCH] drm/amdkfd: fix kernel crash on releasing NULL sysfs entry
Date: Fri, 27 Mar 2026 14:00:36 -0400
Message-ID: <20260327180036.131096-1-jinhuieric.huang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD3:EE_|DS3PR12MB999218:EE_
X-MS-Office365-Filtering-Correlation-Id: adabbf78-a528-42b1-bbfc-08de8c2ac8a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: s44xufo3vDyNM5jpPHbw1qI2Hu26LyOURvP6hfEEQTlt1ZaG3N6NBgi2ZzcrKmFm0gxlbyICDxr9QOJA0/tQHkS3hHyOs9Jzf+PVL8kVJkXh7TZEV3qNKlvSqmspKsaOfGTwE0hIaWZG/Qbi1EyHiad2tBEpE9ogxta4gb6SayMwUxAncXDg+eoCzqyOxuyQvW41yt45U4hbOpc4YCfOl2u4KmsBsqcVWvzqfKBpTbF79W5GVV2xF7UbL0HPZE771/xqiGHJjLqgK0i9JMi0R10sFvLKhqmEv+7PEz8WWQT+PUxkz1Ws8k3w4AJ3XaMOCktTMKPUvdjV7uqOrc9DjqZ7iM1EF3I2BSdYB4a+NYyQPon0sAeHJd4CKMHINkcexBOFaLLRo2vtsQd5XjrqkycnAVQVK/jxOWe6YEbjKxrX7IZL7eDGQPFRAUgFnjBRlbEmuzXwjIM5TtlinIj2CZcagryGqL3XI1Q6C7K5oml1amA2kxDk9I+563uz4jf8ry5DZnILR2FkNmADH5Iurc4dIy1NqE41+bZ62/6EEAy/Zhkr0dyH/zNfPVXaUFADg3pqIFIL5aKAPdhywIL0QsY2VpCq/JvIYyMr78u2CZdL0xTm10djUICStQT29NaRV39zEMN8SSVO9uM+7jTw4c8vAtGrMYc6dbF8A0Z9tNqLXUpKP4wsl7YposmTjQaYIRbczPwasAP2fIlHuutS5iP4+8Sa1wJPh89+2YoKF6Xru4LM52dgcKn/WwbBqjRusiizLcAZ62TnZ1UZlOvDHQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: dtZW4xqOC8ns9CvZ6k4iISbYMjJcJqRFNbYbpUzp9ePqG+WLWeKEVAs17pahui3uXXhPAUlIinnCxdMEOzXBkjvL5T6jG/O6EU5CUih5O9zeSGhDF2/g82H/KGvWhHFYxiygYt2fd7pSad2k18YZKdcasQD1kloKppF3JMe/pMRST5b1Z3bJYb52kun2CtBvCiA/ZnihbbDq/GMxdmyj05lzhLslNLzcl8u2Px6sWh7zm3m9WDlEm7Npm3sM9sHg2zE0zquYHjg8S6+ehMugOjExS5mv1Y4Bgr2snPzDo7XLeJclVGbPPhtY0EIof4v3p31xSIYo5rNaJrTO91QhDoVe1MNdPMXCudtjGdPBY6++yYZ4l2bd0xo112zSHPDrQ795Bkx8uxNl0m7HYV+dXmubhERkKLb/ADdf8AeywBQ73XjRW9Uxz4fiWzjKs0dx
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2026 18:00:51.5060 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: adabbf78-a528-42b1-bbfc-08de8c2ac8a4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS3PR12MB999218
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

there is an abnormal case that When a process re-opens kfd
with different mm_struct(execve() called by user), the
allocated p->kobj will be freed, but missed setting it to NULL,
that will cause sysfs/kernel crash with NULL pointers in p->kobj
on kfd_process_remove_sysfs() when releasing process, and the
similar error on kfd_procfs_del_queue() as well.

Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_process.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 8df76c24b394..4333a9623a14 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -679,7 +679,7 @@ static void kfd_procfs_add_sysfs_files(struct kfd_process *p)
 
 void kfd_procfs_del_queue(struct queue *q)
 {
-	if (!q)
+	if (!q || !q->process->kobj)
 		return;
 
 	kobject_del(&q->kobj);
@@ -858,6 +858,7 @@ int kfd_create_process_sysfs(struct kfd_process *process)
 	if (ret) {
 		pr_warn("Creating procfs pid directory failed");
 		kobject_put(process->kobj);
+		process->kobj = NULL;
 		return ret;
 	}
 
-- 
2.34.1

