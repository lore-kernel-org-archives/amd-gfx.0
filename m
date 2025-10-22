Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E40FBCCD195
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Oct 2025 07:31:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 686F210E6DB;
	Wed, 22 Oct 2025 07:31:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Z9GzAVAS";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013060.outbound.protection.outlook.com
 [40.107.201.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 828C910E6DB
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Oct 2025 07:31:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oYZTyL9Gq20eT1wmcp0nOKcEe/jbPZZhiTsZV3su7IRNPV1PzSKV1rvfM5g67LwvFu1qaY5Y2DZq/VJ8Elm1gAl/Ywccc+3M7yVNfsSIrDhNjl4gJJahoa+W778bQpwFwtqEAUEanSVj0RV5XWUwQeBzyxShOHm/NScwpkqz0p+Wrv/yc1SnwJBz4uOog7dqf6q8rNVt39NqvoffW6dLhdnUL1Mcz9eyrqRu5IAntgxnXjlND3JejQLaKqecKGojd578N30jQ7DPzEjZThr4S4p0RWTh8phcX+sucGUAwQSPgPM98hkLa2FYhMUIn2KD68bYc7gbS+qMitnZgK+PYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=75EPQJrca93QVJSU9GM3gLMlunZm2RozQEz+SMF8MjU=;
 b=MrwnEv5wdAIIPAXEqP+LEddKHhGY1r+7p9AhMErZ1/KpimjAccg8BsNPNbdDawYzV3ifS0Xv7TVaE3sUXs58OGiph34iIbkvc5Ffh27IDvNIeOotzPvy7f6VlmFXVobE6HGkkE1K5xGWf8gro/i5hBFhGbW6rocagUJagLVM1XFD4vcfYnXbn2xKSR9nReQ3Sd2cDQyF7ERFUrOdfMjVSNg+s8C1WTHcO8TamXC8MOBhDCTC6aTyNgaw++LnbDbALbMty0et991XgVrNsOH7E4cw8/c90Zn4LlJxHegsACb1iRQO0ee6DmYO9VSoj03p+bwBNxO0UQQKq4+tRHL7Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=75EPQJrca93QVJSU9GM3gLMlunZm2RozQEz+SMF8MjU=;
 b=Z9GzAVASmiLAWgEPWxnvoJn2wDM0Y8GbYNp8TltTSTtjI9QesoCFwvrXXaW/ivpplaM/Uke1QHqC1Sbur3x9qH7UCjlOMtt3vt8iU61xW3erU9+3iqEUJKv+yf4/TTGTYtx/6/KoZ0TqYBiKIV45W3U+oc8+udQ7v9LtlN6KSXg=
Received: from MW4P221CA0017.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::22)
 by CY3PR12MB9704.namprd12.prod.outlook.com (2603:10b6:930:102::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Wed, 22 Oct
 2025 07:31:21 +0000
Received: from SJ5PEPF000001D5.namprd05.prod.outlook.com
 (2603:10b6:303:8b:cafe::7d) by MW4P221CA0017.outlook.office365.com
 (2603:10b6:303:8b::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.12 via Frontend Transport; Wed,
 22 Oct 2025 07:31:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001D5.mail.protection.outlook.com (10.167.242.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Wed, 22 Oct 2025 07:31:21 +0000
Received: from fedora.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 22 Oct
 2025 00:31:19 -0700
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <felix.kuehling@amd.com>, <alexander.deucher@amd.com>
CC: <ray.huang@amd.com>, <amd-gfx@lists.freedesktop.org>, Zhu Lingshan
 <lingshan.zhu@amd.com>
Subject: [PATCH V6 07/18] amdkfd: process USERPTR allocation only on the
 primary kfd process
Date: Wed, 22 Oct 2025 15:30:32 +0800
Message-ID: <20251022073043.13009-8-lingshan.zhu@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D5:EE_|CY3PR12MB9704:EE_
X-MS-Office365-Filtering-Correlation-Id: 00428316-8143-444e-6be7-08de113cff4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?lFwGbiGQ0adRlTMLoQGZReb5FdqWyYYTA36iIt3Y6QR15z7xhb8DhvCm/Obx?=
 =?us-ascii?Q?6m6FQJcRbzEsUUTCGMeI5hYFQEd3d7Pdc5QE49B01JK36mtiTVP4rLTVw3/V?=
 =?us-ascii?Q?2wCs8uYGvyOSaU7Hnl/faCHhlcn4mX2ITFGdZw9WKgIF7Q4cM8/+oCe8jXXC?=
 =?us-ascii?Q?mZ070PYq1ikuvJ+iKUbnna1Ld+o93Y/VlNIaVNOZwXhsb/jBDlUWFU2EltXI?=
 =?us-ascii?Q?t0N+4rrais/Q8/aeHk/xfJDSYwHuGOIUvWv4CX9PUkv5gndJZfmeJ5wCS1k8?=
 =?us-ascii?Q?OB+O1YiYnSzy2eA7Xj5l4IC05zGdKMwjwLwu7o9UUD4VYN30xqSEAC1V98ep?=
 =?us-ascii?Q?nYGkf0CeXCRfQCIdRXXyTqVc/q4Mg9BPGHnvd+hXMSSu7UJLkA/3uYi3N9YU?=
 =?us-ascii?Q?Au56VDghk1h2CKZYjxA+WRQpkQSPjRjH+A/837OFNd2pw+g7a3IAQp0UM2up?=
 =?us-ascii?Q?FJeLQhBT1m6u537IdJKHt8SO87CI316lRCswHcs0siDeo0cwSbjO0cekws5f?=
 =?us-ascii?Q?8cnAWV81OLPqEbMVSOdMBYZcKyeb0uilnbSffNfhzoAWAuvebd/UrsljGbdF?=
 =?us-ascii?Q?rbidlUYU8aY9l5cMC4qye0Yz4PJlxtK3U+nOE/ZLFzbtaXwZk+kGjqiW5hA3?=
 =?us-ascii?Q?rpvrIsp2E6IhAcd7KHRTlD9EQPwjcW33UPwNc1djqPeFGDalzzCsW5YSJkq+?=
 =?us-ascii?Q?c1U2dDBRkE2fEYCVrRqMIsvEELEjLAAKW+B8+Hgna9hOmXJGcSw1hmYiadlQ?=
 =?us-ascii?Q?hRrmsrFe9+o8MH0t0+bJx8C1L1iSp9pK2bTo2u45nZTos175JxkykabVb/5r?=
 =?us-ascii?Q?z15ThrMNg2KUC5H5xjwcwXwPW42fxOr+ye0Efhn6zBU21NkATfdF8MDqPPz4?=
 =?us-ascii?Q?f+Uze+9h/lM2rdUMv9jQvMClj43qMn6PePF3zsFB7+dt5s5KH1LIZ3zRg30e?=
 =?us-ascii?Q?61dZLuNbeOKatNa12Nc4oQ9TTcC5Za6d5xYY/G2QU4VpAcy0mrwUP6TApRh+?=
 =?us-ascii?Q?2l9NoC65b842ZRx57sPvpuPJNAUY0zuh0nwijH2zC+TqsU+wCkCaxw81FsDt?=
 =?us-ascii?Q?NSkPB8Z6vdN8GqRmQ8oer6bWUMKcDW84oBEkyeKabIlXY6Q9pgT5UBOo/rmS?=
 =?us-ascii?Q?wOVb5rFZ0yjIGADDsmalg5X8Wy0VtwClCp32VSJPFWyXVp4Z93LOvUJG4m+m?=
 =?us-ascii?Q?uWw3hlWyIQrM+GuXeAm4x07b5G+Sg/Cz0j3SndQkMd6Eke6IokaBEA3iIFKc?=
 =?us-ascii?Q?ZxbOVbgZAjPZlAwVbFFHOBecV9VvaZgMQod4CFxhjualnMh3qqdW/Zw83LuE?=
 =?us-ascii?Q?MkWN1BdcVi4aoCqzVbhrZ5Ppnz1CxXytHI6K+lD1BDva3DlnEVnUId1UbbCZ?=
 =?us-ascii?Q?uq5SjFkthKhmGrfP9p43/8DoK7uHHqFcwZ88TJe9+u8y2I0rsLw2zAdwAYuI?=
 =?us-ascii?Q?ii1o74++PgpOmdIeoNomaForhxFSsKAAOC/KziZ4QbgIEZyluIBXn8JDxUh7?=
 =?us-ascii?Q?7N2+rFKm3SDDtM0irbZqzwjd7lpznCr1zWClCCCWPlW2cA8U4nMtGjJrQoIV?=
 =?us-ascii?Q?e5SahJvVOpqzd59/3S0=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 07:31:21.0685 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 00428316-8143-444e-6be7-08de113cff4b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9704
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
index 58d90bebdff7..d1cb22f48b00 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1062,6 +1062,12 @@ static int kfd_ioctl_alloc_memory_of_gpu(struct file *filep,
 	if (args->size == 0)
 		return -EINVAL;
 
+	if (p->context_id != KFD_CONTEXT_ID_PRIMARY && (flags & KFD_IOC_ALLOC_MEM_FLAGS_USERPTR)) {
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

