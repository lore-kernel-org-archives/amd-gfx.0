Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05303CAC5A5
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Sep 2025 07:26:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9572110E579;
	Tue, 23 Sep 2025 07:26:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZJ9P57TV";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012060.outbound.protection.outlook.com [52.101.48.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C82710E57A
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Sep 2025 07:26:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DdFrO51+xJsEYAp3Jn8QgQswGmU/xlQjP7kscM0lNrc2vz/jQ3R3Jz4k5EeblTOwtfFDMm38xhJkf4P/DcQqYD77luw1niTmmZVMF4NaIJiUBE83TWIdEbEnrx9sI0gUN9Ye/EIDNlqcM1ZXq0XfEAcCxcmAoV00Rk0GLjqo+eFtOY/Ja3wKbAJvfNPCKKwhKbT1A29lekiTKnFCb7foYTX0zVicPSg07LVOTetXQLMbD7uHar49Fu3/ix15ep+VCLqfhoP80PPVm9m3nYc6nP1th+Shh6e6OOJIOU/Lhc4C88qINAOvb1r4F+XhCZ/Z3MKPCgR3JlyhGhtZCOsfHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OuzGHSKrIsUc3MVDprcS9dHddJ0XYNT88OgkL0xLoDQ=;
 b=QDWDLf+Cf0auwrH1+xs8Q0K8sU97d31Dhiu4SyLvsBwCt7gJostqxNIBwWr4EOIzrvk3pQjZidQ+jgdn4VFpzvQ17xgRKYf5Q5Cr0wbNlBKi+yAaW2bZTSM879VcdgQ5b3HUAFTMoZ1A5tPst2OTufQVNrmgXJfwWXYKAXkkF544WYUk7XodKkKXTX7lHE+cQTVHtXqjcY0Oyb8GfnUoCcm/7HAHZjvLEFMOT19ytrZEUKvYg9Siij6ky/4WjmLLsnD9dRLiwv3wEaZ6rPHNtLGd/OpzjySQqFujopsNyLm0zCyAtwOZ1maWEv/lie299DtDoAOudJPbSg6xiKT8Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OuzGHSKrIsUc3MVDprcS9dHddJ0XYNT88OgkL0xLoDQ=;
 b=ZJ9P57TVu47XbHwfZ4Xo1JSH/sXfcVBaYuN+6808Eodej+6yg+3zyRebfuCc1QivNCDYrmvNZ/08ROo7GRmOCtYVD9BuRL67Cxt/WOLu+8uv/BiAjttF5UzuT4VFpjNoZgbi+tSem9HTEQk4vPFNMhip1CsuWP19++IqJ/G/TNc=
Received: from SJ0PR05CA0044.namprd05.prod.outlook.com (2603:10b6:a03:33f::19)
 by PH8PR12MB7183.namprd12.prod.outlook.com (2603:10b6:510:228::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Tue, 23 Sep
 2025 07:26:50 +0000
Received: from SJ5PEPF000001EA.namprd05.prod.outlook.com
 (2603:10b6:a03:33f:cafe::51) by SJ0PR05CA0044.outlook.office365.com
 (2603:10b6:a03:33f::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.19 via Frontend Transport; Tue,
 23 Sep 2025 07:26:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001EA.mail.protection.outlook.com (10.167.242.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Tue, 23 Sep 2025 07:26:50 +0000
Received: from fedora.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 23 Sep
 2025 00:26:41 -0700
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <felix.kuehling@amd.com>, <alexander.deucher@amd.com>
CC: <ray.huang@amd.com>, <amd-gfx@lists.freedesktop.org>, Zhu Lingshan
 <lingshan.zhu@amd.com>
Subject: [PATCH V4 07/18] amdkfd: process USERPTR allocation only on the
 primary kfd process
Date: Tue, 23 Sep 2025 15:25:57 +0800
Message-ID: <20250923072608.252345-8-lingshan.zhu@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250923072608.252345-1-lingshan.zhu@amd.com>
References: <20250923072608.252345-1-lingshan.zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EA:EE_|PH8PR12MB7183:EE_
X-MS-Office365-Filtering-Correlation-Id: aa6099c6-9317-47d3-928f-08ddfa728fc1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Ol7NJhzMxO2ht8Md0avwpwS2xFCeATWDjIVbnNpIQqpPsTgW9FoAcS6yVww9?=
 =?us-ascii?Q?4+dReOulq4PaU5whMso6+qMBTdoNpe3KWAQQSVsIZzzD/OeA1LkaDTi0mUra?=
 =?us-ascii?Q?hfu/5UCVhDytayq51CrXZpqJmYnWU2TDRboRw+X4LPQGsxnabifNxZ+m07/Q?=
 =?us-ascii?Q?X7/t23QCNYBWDqpZS257h3yKozrdb3F8nHZtELcuWIfCEDYYt7U/bldGEWID?=
 =?us-ascii?Q?iynKZ57yKQLCNpRiCDkBbV3TP9M5mR21+85kojBeJjBoPm9Ykmy1YLkh+21O?=
 =?us-ascii?Q?pB7kiVL3XWcaBqCoaAcAcDOKLCDIvUisFo00qGJ4Lyfar7GlBLGcOwwldXvH?=
 =?us-ascii?Q?m1NfBm1XzKb1VeKk80BXWG4stDPyplvyI/i8UyPnqTEtnI46eSc86W3ofyOq?=
 =?us-ascii?Q?X7aojll7XweHOKNZ0WtBMnKmSiLYdYjiC4b02hmPtvIaMY0zlB31WZ9CxDtF?=
 =?us-ascii?Q?hsAk7PW6d/ZlUWR5xIQOodbE+ZzzMqKhK7bRqS+TcKqDWLJPotetd55OQE5e?=
 =?us-ascii?Q?YouDDv6RUMCflDdOAs7nwU2o3lpQTeA+kM3SD9jDXV4OzhnVEnuCTn1pzkt7?=
 =?us-ascii?Q?KyuBod9+uTRGdZqhAyTS64Caixj0vIEwCuTx6Ac5xd7eFbeWMbCedgzQXVaL?=
 =?us-ascii?Q?EbJh6l0b4JOleZNS5MxHHUEzKr+N7ojVa2eF9eVtVT2nUTrIKzjDdPs7F6Yo?=
 =?us-ascii?Q?I8Ryl8if2qVgxvQxo5MhqXRqpM46EDkA8WZfiq1e5sA3Mm0YY7XLzQygwnXA?=
 =?us-ascii?Q?ZImKkRwejjEfTH/vG+/1RvtqBD7fM9UYMp+rZ3GQHSvCorbVnbXYlFSGHYLh?=
 =?us-ascii?Q?Ix8Qu6jzxE1Xek/mMQyROCfZVUfNmJtfjFXi6GOcBcEMwEHvWgfDR2FQeLsZ?=
 =?us-ascii?Q?hbtj10mBAjy3TyP/rN08ajSohgsBOCWD7TcI2ZnXTNNBcfFNVRoDgdLEdBNE?=
 =?us-ascii?Q?8Gm/ncNzaF2MV/i6T9Qy38RC3lNCn383vpd4egsh/6Xxm/xshmNAOXxKfdfP?=
 =?us-ascii?Q?hAG8uZgm5udnMIKg4vy9jAmuDgJzZbHvEiT8UWlDcvz9Xb3MIvOOxrpBgfu8?=
 =?us-ascii?Q?WnPfrd4GeoAbYUZ3youLEJug4o6LJFXM9d6+0bcjwI6NeV0tPSjO/TR2lkez?=
 =?us-ascii?Q?2+S4qfQmu9ElAtdQxlgMffaluP4MniGXjystk84Fc1RZvd8PiHY6geOgVE96?=
 =?us-ascii?Q?2fK0waRpjWbhDonVVsrKD4P5zQqjGIa9ZbQc5PQzaZhPnDIH3nHPSy08bYae?=
 =?us-ascii?Q?2A8vYYZ5jBaKA9mSPmr+zUs1b/YgcocHnN9+cfWANNVrx/Tx2z5kwcRH+HCF?=
 =?us-ascii?Q?XVTkMWl3bhZTLE1GKNXi4TwnIs5qOiAbf4r8IvnPNqXXbO8eQr808BcnLbV0?=
 =?us-ascii?Q?ssdhka9Y3RAKwwizN5/iFiFgRlfeP9YvP+NgWoBGppLuZrsrGzXiLxM8RXTU?=
 =?us-ascii?Q?4fZmyJpDE3KQKrlLBBXSsFguRVH3jS0qn8BdEMhV4tpncYhuj/9xduRcNYLx?=
 =?us-ascii?Q?i2VEoTCdURa/LUFLg/e4tQi12apRCdlGuicn?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 07:26:50.0177 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa6099c6-9317-47d3-928f-08ddfa728fc1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001EA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7183
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

The lifecycle of the primary kfd process is tied to
the user space program, all secondary kfd process
would be destroyed when fd close. Thus only the primary
kfd process should process USERPTR memory allocation.

Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index f56faf11ee43..28df35a63c29 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1068,6 +1068,12 @@ static int kfd_ioctl_alloc_memory_of_gpu(struct file *filep,
 	if (args->size == 0)
 		return -EINVAL;
 
+	if (!p->primary && (flags & KFD_IOC_ALLOC_MEM_FLAGS_USERPTR)) {
+		pr_debug("USERPTR is not supported on non-primary kfd_process\n");
+
+		return -EOPNOTSUPP;
+	}
+
 #if IS_ENABLED(CONFIG_HSA_AMD_SVM)
 	/* Flush pending deferred work to avoid racing with deferred actions
 	 * from previous memory map changes (e.g. munmap).
-- 
2.51.0

