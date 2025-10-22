Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2467ECCD195
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Oct 2025 07:31:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C1B7510E6E2;
	Wed, 22 Oct 2025 07:31:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="q8KTBsX8";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010025.outbound.protection.outlook.com [52.101.56.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 25B3810E6E2
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Oct 2025 07:31:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ORXgV2WpeeENYQmscwaw4tYmPZXxdq+o8A/wWJrf3o3lz6310LnGQggxGYuF3C4L0YOiSEXoLnfuQXGMVLDZcpfx1uKDF71t2fvYGxRWW9Z7b+/RmsnQOeKjyfL+IcHzrZtB2cIQOW/VElV6uoXejEjX4+yT33GJc+xvM4QSV1liUzFMIMlYCGRUNO7zdXnKZvhlTbTI9d2zXNfzRiN3MrFwDukZcSYOkvtt3Qp47qcZwWmePXUXH1Lvq6KdW9BalvGIFsV6TNRzKzD2a8c/oWAOx3pgfu30bt58IzpBYk+W9Ur7CFakKK1GRKeh/dVi0UCuo/PTM8G8+0smiLrDNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=op0pmFp5GQmCrHbnDQDN0WtBHjLh5kFT++o9VS0uXfo=;
 b=XHp4fqOvl0qenqKjWsyLTurQmTySg5Wjpm8yQfQkrOCcYPuI3gwv51kp3a2NeZJNgMfJTLkXC9MYvIhJ0ljbnqYi636KE8DCMk2XB9TLu7az9uNeX97baNc/pxyw4Ow8/kS3q9+hLpBO+hzfxCqFbGxH9nfrvNyCOU+D4lq5XO4AXRaiufXsrhaMoLZp05quVW0JhJtjrrwagVeunykmtrrCe4HkNkNt/MuBFeTRWYnh7YL5pAiCOqa6gN1xPZl8oCr0bZ3l5OVZ1fBqvod0qA6bsYrfBCncp5TyXitnpbQO3mfHin+4a8bCw85WoeXYNnY5/WukEUQo+pObOLDO0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=op0pmFp5GQmCrHbnDQDN0WtBHjLh5kFT++o9VS0uXfo=;
 b=q8KTBsX82l7MEQkX866Vfvlb9aJHpgdjPpn674wFFpiqJ2O2kOjftmoIN6sg4DJUmnB7zB0q99mk/XY6dH10rCSwclpSPHXCqZ0/rc1cATDU40rUh6ZHNsa7+xEHjvHDceOFz5ZhjARbnEFLuO22HvSJ6vsd46sgTxHa7ib/3Cg=
Received: from SJ0PR03CA0033.namprd03.prod.outlook.com (2603:10b6:a03:33e::8)
 by MW6PR12MB8957.namprd12.prod.outlook.com (2603:10b6:303:23a::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Wed, 22 Oct
 2025 07:31:39 +0000
Received: from SJ5PEPF000001D1.namprd05.prod.outlook.com
 (2603:10b6:a03:33e:cafe::cf) by SJ0PR03CA0033.outlook.office365.com
 (2603:10b6:a03:33e::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.12 via Frontend Transport; Wed,
 22 Oct 2025 07:31:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001D1.mail.protection.outlook.com (10.167.242.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Wed, 22 Oct 2025 07:31:39 +0000
Received: from fedora.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 22 Oct
 2025 00:31:37 -0700
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <felix.kuehling@amd.com>, <alexander.deucher@amd.com>
CC: <ray.huang@amd.com>, <amd-gfx@lists.freedesktop.org>, Zhu Lingshan
 <lingshan.zhu@amd.com>
Subject: [PATCH V6 17/18] amdkfd: process debug trap ioctl only on a primary
 context
Date: Wed, 22 Oct 2025 15:30:42 +0800
Message-ID: <20251022073043.13009-18-lingshan.zhu@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251022073043.13009-1-lingshan.zhu@amd.com>
References: <20251022073043.13009-1-lingshan.zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D1:EE_|MW6PR12MB8957:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c37b97f-b3dc-452c-0372-08de113d0a3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?26zYaXSlTOXeel+/oMp2GFapRY+zoSNNINbiuRieFhlPCimvfBgBfcQzRuga?=
 =?us-ascii?Q?bzMh6Mohh3zqu9FcsnxXKhRC4BJUBj7O5cQz8gORFZzwLD0GrpwQ+3c+/Ovd?=
 =?us-ascii?Q?CmBjrnAH6KXauziWSGEodYpro+1nVXCOm90z6ei2uDqCR5vfhtD4HG7UCYK0?=
 =?us-ascii?Q?SGaNk9MqKbg38jdgxJ1PLddC9h8fLa2dLHxZO36mIrxJNOTTD66uhrAIy3fw?=
 =?us-ascii?Q?8WQN973KOfKpdYMT5kUJU2OJCORsy7OLalRc5ZYV+vGqVQGd8SP4gQ+Vr6ai?=
 =?us-ascii?Q?W7wfawHA11xLKIpT0kClhmurAxLNZzqXRCsdaqk0rN3T+G7E2zHo5IDv78V8?=
 =?us-ascii?Q?Q4yp+++EWhrv/eexa3CiDw3IUW0axLXAZV5Jx4aQNUWXzlK/27ZDjddvoY9K?=
 =?us-ascii?Q?jZI8VHsylHSxEl/UkuSKTVDglgeViKi4PZXx5HPgz28LZi4Hc270RWQgLybw?=
 =?us-ascii?Q?oY/FBOsPQeGqkFFbjDRRWU31rLlY74096g5sJ4SHaYTsdjQY+gfMpk/3tboS?=
 =?us-ascii?Q?uZXUFeE+GhU1CcYysKO8Qyfvdzgdb5i6MEhpeF2b5nfLmPpV0zWk56rAPBm0?=
 =?us-ascii?Q?2ShKlj19/T9dui0cpkTpy/mV4mzU0o+Sf4G7DMaftw3uNrz0mZk9SvhLIOVF?=
 =?us-ascii?Q?J01Ct11wYHn2g0wMBjfkrY7Uy/sIz+Ho1P0EeCgoL1nXnk81jzhufrUeNP65?=
 =?us-ascii?Q?vNjDK7632LeOgzGLdZFLHYEUPeGhyf2SEmppaYPFjs0umeX/7VkGNOEKzYui?=
 =?us-ascii?Q?Tx9E2NTKs4Fq7F4ILsGcu7nUOjue3AuQ0d0iTo4tLm/zBskyi98nAMKZNTXs?=
 =?us-ascii?Q?ZjPVl5KFFoOcXlQ9ZMia4CTXuIvkPIjihLsMeN5+do/rgeHt45XW7MF+iNaJ?=
 =?us-ascii?Q?7AH+TR34rJe4DtEDSgWm6aKpQF3YO9leGS/y2mxuPl7o/Ct12B/i1Vzzk9fC?=
 =?us-ascii?Q?MLFsUq4kmRvVVbbkCRkwaTLnwEybIko9iorDWAUHpmgL9XPGUDRnOBn+W/9P?=
 =?us-ascii?Q?PYwxFzRSXMxy/bLds9SoHhNrdmv6ndPzqmqSir1AglUrowCY39dk4v/PHSNN?=
 =?us-ascii?Q?etPSX5msaHHvEGYEwh6YGi6HnWOTAYRrlBYCYYIsk0Sy1j+g0058OK16P3q1?=
 =?us-ascii?Q?O7urOhFGo2fZ2RTNKUnD7nhdwbYbJZZm6oebVUYcbbu8Ynbf1f7M6xR4Vhw8?=
 =?us-ascii?Q?876lqRNcYSptQAGBJxwkUe76/4KPGAYYEv835xAQDB8ycJ140r+SSlx8WBQJ?=
 =?us-ascii?Q?ogUfa/VtnnX0ZUukZ5lBQLCkLu00KxHGz8CdI5aNQs2G7WbOIVDEOZBL8vOJ?=
 =?us-ascii?Q?tkeuaQzy5IW4tH9HFpGZq6CrZmAXm2FI0POQcpDIlHaVVTOo0UJZcpFm+u3Y?=
 =?us-ascii?Q?Ofyg4fn02HkAtTfMxHSFi35SoZhlx6CzNdljgfIGFC1/8G/i9LrrUR1qriY/?=
 =?us-ascii?Q?pllF6vRoaihDJrFFC+x6Z6UhRjKD2lcMAayYuF8bqUocYrTthaIxNIpmfwTu?=
 =?us-ascii?Q?kg51D8sxje/KTfF5XUppWwEvI0HpMtrlg/dZ1Hz4sOsZj8jShhmTRCmKaRUi?=
 =?us-ascii?Q?NgkN/Z+SKmEKSO1XT8k=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 07:31:39.4411 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c37b97f-b3dc-452c-0372-08de113d0a3f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8957
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

Set_debug_trap ioctl should work on a specific kfd_process
even when multiple contexts feature is implemented.

For consistency, this commit allow set_debug_trap ioctl only work on the
primary kfd process of a user space program

Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 73de2de8be0f..ad5ca3fd847c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -2927,6 +2927,12 @@ static int kfd_ioctl_set_debug_trap(struct file *filep, struct kfd_process *p, v
 	struct kfd_process_device *pdd = NULL;
 	int r = 0;
 
+	if (p->context_id != KFD_CONTEXT_ID_PRIMARY) {
+		pr_debug("Set debug trap ioctl can not be invoked on non-primary kfd process\n");
+
+		return -EOPNOTSUPP;
+	}
+
 	if (sched_policy == KFD_SCHED_POLICY_NO_HWS) {
 		pr_err("Debugging does not support sched_policy %i", sched_policy);
 		return -EINVAL;
@@ -2971,6 +2977,12 @@ static int kfd_ioctl_set_debug_trap(struct file *filep, struct kfd_process *p, v
 		goto out;
 	}
 
+	if (target->context_id != KFD_CONTEXT_ID_PRIMARY) {
+		pr_debug("Set debug trap ioctl not supported on non-primary kfd process\n");
+		r = -EOPNOTSUPP;
+		goto out;
+	}
+
 	/* Check if target is still PTRACED. */
 	rcu_read_lock();
 	if (target != p && args->op != KFD_IOC_DBG_TRAP_DISABLE
-- 
2.51.0

