Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1545FC021BE
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Feb 2025 02:42:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 058D810E83E;
	Wed, 26 Feb 2025 02:41:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="K2bK2MpS";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2083.outbound.protection.outlook.com [40.107.96.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 83E8110E835
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Feb 2025 02:41:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nuiiCyC4snyl618d7z766ickFW5XEHLVUmN8rDywRLcm4b7cx54Pjpz7k+iq8NWT5LCIBEgiOP18+1tmosfRVkcQNAE770zeUinz9Ly+rxCP+KwkE6qD+rFGmqkHiwKyRgv3uR9m7XcmcZMC4z0RzL6XZ0XcheFFRaHTX+4OeDySDr394u/HMfCcQWUULXfIMYXU3zpGVy4/V/Q9wgx4zFpWLLaKAfPsrZY7VIUT/6Vdclp1ELKDLWVmJlA/Yh3UQKkfgan/xShrTc1rtnH+4LEo/SUwnNqG++NnRmKZPeauug+hV7SNztwARpTk0xiavOndJBt1MRuawrYBZYyBvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=abRa2/vQ4i0a3rlW/mtss6ochRKNtHm4BaxeQE8xEiU=;
 b=R+ddOGVmOYGhZd5FaKd8BFMNKtLWyACMV2ccUffC+DiWpMVwAcMFlY1mSsmZEEZgGq9uvo1XJDnJYWIQsILm0S47pZL9EOMgDeD+N8HaDc76ChBg84uClrT7ZkhVM+XuXpzPaiXUvCjQFnhviCQEkGe8L1XyeHS2WT4Ua92wg2NsjejposhcSQpsqNtZn8PMel+gZKQd1oyZEHJ+2Ky3WFLmxK68etqjnOBWPkRfdbMYgsF8LeK1hJgwT039AZsrP+p3D08gok1C3jLq7EMYIoNKKeieDzDGCKvr2g5ZWJBCJL2ax+/Vqsl3YsRDlhhuNadLIxNJGOSmXJGykaj86Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=abRa2/vQ4i0a3rlW/mtss6ochRKNtHm4BaxeQE8xEiU=;
 b=K2bK2MpSeEJkL7qxqNtVBB81Sy9/qufWP9FAk+3mqdFf9aOyXmEVLVzOqR5NqXVekEmxsNWEI2TfxwyC2KGqFUsq17poqkG3l4gcPz+tZcHlYwV+7//RN5rnXLGYcF/CYeZOZl5RQm7kVAPmU8sWNS6sdWfBx/haXj+7AQ+gEmw=
Received: from SA1P222CA0123.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c5::10)
 by DS7PR12MB5815.namprd12.prod.outlook.com (2603:10b6:8:77::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.18; Wed, 26 Feb
 2025 02:41:47 +0000
Received: from SN1PEPF000397AF.namprd05.prod.outlook.com
 (2603:10b6:806:3c5:cafe::12) by SA1P222CA0123.outlook.office365.com
 (2603:10b6:806:3c5::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.18 via Frontend Transport; Wed,
 26 Feb 2025 02:41:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000397AF.mail.protection.outlook.com (10.167.248.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Wed, 26 Feb 2025 02:41:47 +0000
Received: from dayatsin-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 25 Feb
 2025 20:41:46 -0600
From: David Yat Sin <David.YatSin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <harish.kasiviswanathan@amd.com>, <jay.cornwall@amd.com>, David Yat Sin
 <David.YatSin@amd.com>
Subject: [PATCH] drm/amdkfd: clamp queue size to minimum
Date: Wed, 26 Feb 2025 02:41:32 +0000
Message-ID: <20250226024132.613233-1-David.YatSin@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397AF:EE_|DS7PR12MB5815:EE_
X-MS-Office365-Filtering-Correlation-Id: 63e089a2-49a8-4d32-9a1c-08dd560f1d40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?fh1v3PxPrmeKQPwluiBoL/VY4fAoZSsOVkxKngyEECGKjJnXiI+sscbva9Wl?=
 =?us-ascii?Q?oNLx0CngelNzaCd/ay9AMj8+3P2kSVK0vqp49jYpCn4TMNbniawKooLqpj1E?=
 =?us-ascii?Q?FzR8OeJXBnV+9KCN6dXoz+BqARlJx1rnfN7hpVSu+yEaCsUsbHOlYBmovTvN?=
 =?us-ascii?Q?Dm2+zo1dl97JnXHrwb4vWRuYpQkun/gS4v4tIFsfOyg1jAz+IVK0sifxMULb?=
 =?us-ascii?Q?q7aBnOQr0sSgye6PmyzPE2KYHNDBkOoNEGRPQHaVvRrrLpxNQtwSg/23MJHC?=
 =?us-ascii?Q?7ROzNSdFaapK97ms12ewYSDm3nPmQpJNxfPZzFDJTa7y6ACTHbyaVLt0oP4e?=
 =?us-ascii?Q?05tzw6k6t9uqeD2u+XYdJFXT/OdPqCGrAys12an4Ky7WWrdRXFvPYEy06LwZ?=
 =?us-ascii?Q?bEJuF/I4rXLsnlSy4pnHjqa3bwiJiXrjuYaWAqZIXemyCXMrHq3ea1QZqvYc?=
 =?us-ascii?Q?+452Pc3eyY3XXwmNsyg/Mh0DLdHC62w+xXKsVQYD1hpzpFb4g3QWfs2IO72u?=
 =?us-ascii?Q?INKXf9S0Q2rtQhbWIpJQ3SAtkJavtMZ3F7l3zGp8Ha3fEh7MjwfzDnBsOTE2?=
 =?us-ascii?Q?5rO5xhxzp2WTK2KnepmUmEzYO0Dbwd5FjId4eNdzkgUq+Q3Xd2vG1XdGGu0T?=
 =?us-ascii?Q?DDg6Z3eZlG+qoSpfNDB9Je26z8Bv6FPMZ+v7qNUV3vtBS7rLHsO6dNrPekYN?=
 =?us-ascii?Q?Ohg02NWSMTnlh37ZAcrLLdebw9yNei+F1D4u4hY7L9IdtW9N0q/ULhiBV2C1?=
 =?us-ascii?Q?zhNeiBIGF264byrmli+XVLCyL3HNMWvpwjCg/hmJj4klIYkaec+uuO6GLLjI?=
 =?us-ascii?Q?vPZ2t0fjwtoai+OVhqiU5ps/zY+Y4ucTAELsROj4dftHIkEJ87NsQVdFgsLd?=
 =?us-ascii?Q?AX5YqV8iCpNFbShAJfGxrVSk+RhViSSW70aIuY5+uUQD+8B3VoveNBUpfc6Z?=
 =?us-ascii?Q?ieCYOVs/kMDMFFKqyGYnAIbIrIIyQRKpYAKIKm/LMzakEgGiqZNtG7BrM7NO?=
 =?us-ascii?Q?75Pic9u3FEbcW30Vc45R6j4JPbphiCL03DRHl/NEHAEi5A5GTvseHAuB0Yhc?=
 =?us-ascii?Q?0/tTvJwf+UyJo6RJz8EL5ds+V+gNUiJA5E4rL4e8+/ev7eDmCjT5IsC8Tzr2?=
 =?us-ascii?Q?K5RcsCt4ygJzT0Dx+4mMaIzEHuwAZQjQS0E+qqQQdo1xCqAkq8jD/gAelT0U?=
 =?us-ascii?Q?EOLnqom51hEyQx9gBJeyIOFqUtMvxth3X5l99+SdDW0rO3r/V97knVg6qFCk?=
 =?us-ascii?Q?9D0J9QOKHaiNU3ezzyWnpZCwtw89h36dYofNeLMdl6ANJDrBKT/A/p2XV+4Q?=
 =?us-ascii?Q?Xco1f+o82Tr/H2Ij5e7ekOJbDBhjz/1QCqqpiaXwlVFH1PJcNBSdzyi8krIg?=
 =?us-ascii?Q?Y87JgawjXN0mUW4ixHZE3hAhoRQTwkvIGeQjFZoo/VfJvvqFWi6bA9umHmrM?=
 =?us-ascii?Q?S5iA5WazlOV7vddXTKvK5sNwi0EjuP9/lbCENaUHeyjmpFjynSxNmtO1DQCX?=
 =?us-ascii?Q?zHY8sdtJ9PrHruE=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 02:41:47.0812 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 63e089a2-49a8-4d32-9a1c-08dd560f1d40
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397AF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5815
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

If queue size is less than minimum, clamp it to minimum to prevent
underflow when writing queue mqd.

Signed-off-by: David Yat Sin <David.YatSin@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 4 ++++
 include/uapi/linux/kfd_ioctl.h           | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 433de9e9a77e..e90c3d1c8f8a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -212,6 +212,8 @@ static int set_queue_properties_from_user(struct queue_properties *q_properties,
 		return -EINVAL;
 	}
 
+	args->ring_size = max(args->ring_size, KFD_MIN_QUEUE_RING_SIZE);
+
 	if (!access_ok((const void __user *) args->read_pointer_address,
 			sizeof(uint32_t))) {
 		pr_err("Can't access read pointer\n");
@@ -461,6 +463,8 @@ static int kfd_ioctl_update_queue(struct file *filp, struct kfd_process *p,
 		return -EINVAL;
 	}
 
+	args->ring_size = max(args->ring_size, KFD_MIN_QUEUE_RING_SIZE);
+
 	properties.queue_address = args->ring_base_address;
 	properties.queue_size = args->ring_size;
 	properties.queue_percent = args->queue_percentage & 0xFF;
diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
index fa9f9846b88e..b0160b09987c 100644
--- a/include/uapi/linux/kfd_ioctl.h
+++ b/include/uapi/linux/kfd_ioctl.h
@@ -62,6 +62,8 @@ struct kfd_ioctl_get_version_args {
 #define KFD_MAX_QUEUE_PERCENTAGE	100
 #define KFD_MAX_QUEUE_PRIORITY		15
 
+#define KFD_MIN_QUEUE_RING_SIZE		1024
+
 struct kfd_ioctl_create_queue_args {
 	__u64 ring_base_address;	/* to KFD */
 	__u64 write_pointer_address;	/* from KFD */
-- 
2.17.1

