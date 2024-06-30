Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7943C27C4F
	for <amd-gfx@archiver.kernel.org>; Sun, 30 Jun 2024 14:41:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A31A10E09F;
	Sun, 30 Jun 2024 14:41:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JvInlqmh";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2065.outbound.protection.outlook.com [40.107.236.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B37C010E092
 for <amd-gfx@lists.freedesktop.org>; Sun, 30 Jun 2024 14:40:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=az/rWNh/t2piZjaTiJbz7KrKqXifnpDtJ28bmMBNATuI0bjUoA/JG562aAlhS15CCp81NohWBju4FYlycmV1EW/DCA7onALJ75waKFkae3lgWx/qOw/BBqq1r7rcLwZZDGHYu7JE+dRW9fGfU+lvmNOzRIHFvFyTlS1NzyjVXXHLZPhrVkEjjPwWSRL1TeEEY+KR60MnDvYnG4H/LcAcmwoL2bHRMC2HT14EQrapSWM4SaTkkJVuoCtoBciKzOvoDZCToXVExmq+xg+IDeIeTvuqeT8laG1ubmbM0OE5EA0SOhbS4gUq2f4sf+rPX/J9iveEveI7lLsinHTYBIjcuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tIWf9kM1/ooS9l1S7CVZ7ifXEZHr0YqLQJ0qGhSAUSA=;
 b=Jq5CmyQz4Ho2c7j7SitKLCgUS0F5K/Tdvdx/kUfyPbdCc8Sv6mZtj2L/we96Ss/rN8Jyf2+5B+VVVXgk8NzAjge8ZpJ04+BPyakbGtJxGggzER9z9ukXs5/j8lOSt+NR8Q+YplAJYBS6eHxeBYL9dUT8MpBH63GhQOfdNGSHlC/Dbw9095g3dA/J78mDEMfk+UwJUpa6IHt3URjD4rH65nYBkKfppQjKXm1/nCORUlyg6+etz1v9K4jA2mpsoiRUStuuXf/Kzm/gLjCflGxB0MsqDryVAaaoB1Sfe+JS5pP6hED/UwDOy4FgUOetKKMlJUgnk39bUegDN+gwzPGPNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tIWf9kM1/ooS9l1S7CVZ7ifXEZHr0YqLQJ0qGhSAUSA=;
 b=JvInlqmhdohvzGf7R4l2y8F8P+tFE2QCkWpJTk++ThzGJcv6tGNUEAKXbRXryNmjQ+w6EvArpEShI1YI84I09JG9MRovwfPyBw3o4uieoGbhXd2sL8kKxeZL7n97CC4rQmn5dl7vLIe7H1Db8I3Q9JRHYbencx1d2zTr5RsFWr0=
Received: from PH7P220CA0038.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32b::21)
 by CYYPR12MB8963.namprd12.prod.outlook.com (2603:10b6:930:c3::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.28; Sun, 30 Jun
 2024 14:40:56 +0000
Received: from SN1PEPF000252A3.namprd05.prod.outlook.com
 (2603:10b6:510:32b:cafe::2c) by PH7P220CA0038.outlook.office365.com
 (2603:10b6:510:32b::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29 via Frontend
 Transport; Sun, 30 Jun 2024 14:40:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A3.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7741.18 via Frontend Transport; Sun, 30 Jun 2024 14:40:56 +0000
Received: from ldev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 30 Jun
 2024 09:40:54 -0500
From: Tim Huang <Tim.Huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Yifan1.zhang@amd.com>, Tim Huang
 <Tim.Huang@amd.com>, Yifan Zhang <yifan1.zhang@amd.com>
Subject: [PATCH 6/7] drm/amdkfd: add KFD support for GC IP v11.5.2
Date: Sun, 30 Jun 2024 22:38:35 +0800
Message-ID: <20240630143836.2015991-6-Tim.Huang@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240630143836.2015991-1-Tim.Huang@amd.com>
References: <20240630143836.2015991-1-Tim.Huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A3:EE_|CYYPR12MB8963:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d25e6a4-5056-4623-4e01-08dc9912a695
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9MhXO/tUjWXbJx53aPKzbZV/lH5O4esgwPBSycPi16Blvw4KL97G85wbp7jY?=
 =?us-ascii?Q?SQqfciQFtqNiRE1YGFdI9GKazRMWTCQkyQzrkkCIyUJ3yEgDIc3KTAGNTjcq?=
 =?us-ascii?Q?MmNWJLq0zCaeFQbkwPZSuKucdfSTDMkOdYXyQqk1m3JtATXfkkfafrfNN9Wd?=
 =?us-ascii?Q?GeOevKn94J3vWipUfrrTDYJoUzFoi31Aai4zP5LTAdkvFAtVOZbCRRQBkLlk?=
 =?us-ascii?Q?63Ls2yYHXKLKApDDZMbQyD/R66UPp1d0PIQA4iiYXh3uzJrn1/lybYV6Rtrj?=
 =?us-ascii?Q?8DfbmdcUiiPWEG+V1fdamX2unm03WfQSMqq4txt4tQxJmJvsJ4TyJ0J8p+nH?=
 =?us-ascii?Q?Sz/u6d/ayIdOahPBL53VEMHoj1dL70pdlIU1/cXaQthQl8BWHr3togFHWJjZ?=
 =?us-ascii?Q?uT6vu6e5rci15H5I44tVSQyv/xP84Zj9J3ezoOvuuch7dkDn6TMX1luWMFDf?=
 =?us-ascii?Q?2t8OOBoZRCVqu2EvbceSSUc45LTXLOZjqyix2yH2fr1ZV9y4K/Io5Ha5MFFP?=
 =?us-ascii?Q?itYN4miPW2v5Qt9TFxe/O3tE7JvsjuZ3Uq45OozKmoLkW7YacpszC6ZsPmeZ?=
 =?us-ascii?Q?b9hI75+knb8D8CaYDcV3oI5cA/++rrkwov/AcT5+8uUDeepmXYZyz7QOVaGc?=
 =?us-ascii?Q?5a4oQSGDgUpsKxJODYGYgyhbF18Xg41GErantVKRYFik6tum7zu6M2QsUYWz?=
 =?us-ascii?Q?bvG832RI6X+Buo9xlK62OCqHzWqWpLps3nrnhe5t1zvBGGWiyOm2sohYhKWD?=
 =?us-ascii?Q?lVCWkRFPTETQuoYxG0SmHcf/Vowa84pnaFML80ZZ5qby625+kmQhxEzGtZ7t?=
 =?us-ascii?Q?YhzEN3BJp2pPPIkz6eQ0YY2VagwvMDX+KkPkvBBy6tcUpkwot6GC26PN8YtE?=
 =?us-ascii?Q?f4U6NbUzNYL8MWZnFvSFukJneaFksimd4YrkkvWb9XyJzVRmxwvjxQKcbTp/?=
 =?us-ascii?Q?pdsPM2lQ2taz+yFkf3TlNHGxiJaUezi/d3VrjkPFUkXD5BS+y0633fMrNxpN?=
 =?us-ascii?Q?lxReUin79QWWvtfxCwdZVyZOPahFcK8mJvGEFPbBjMXwCg8F5zOScMiIEdQQ?=
 =?us-ascii?Q?S8+SjUDrxdixZkr2p8yfwjKdPojhlPcSRYSDK1YThF5dQt8cyesQfW5M5yWv?=
 =?us-ascii?Q?8SMDBa0NIj6Der4RqTtNQZd6BTUfa5+5HeWQPtvgXud/xgegKVvhHwEUeK4q?=
 =?us-ascii?Q?X7moVEbQDnBwxf2QnjCaThooacTfI27OuSuoR63vpzQ7C8dQfiIj8rfbikQI?=
 =?us-ascii?Q?qzgEqQFziS9+A13q4XvfLg+rcfImS13fKWL2ktlVMkT8akkFLFdr/M61ljQa?=
 =?us-ascii?Q?eNNo7CPR5hsDFSMuDCmZyMpB0O4oATCUwn6FoikexpqjRX6v+lB7Vw8555DH?=
 =?us-ascii?Q?XjL5E8/xW6nU6HtliVry2L2YjNdTK3g2FnZLFv5caKEoA6+qAP9F1AOxMgKq?=
 =?us-ascii?Q?d9cIW8t7zAuPMMvKmftQhL46qqWJsEiL?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2024 14:40:56.2250 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d25e6a4-5056-4623-4e01-08dc9912a695
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8963
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

Enable KFD for GC 11.5.2.

Signed-off-by: Tim Huang <Tim.Huang@amd.com>
Reviewed-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c   | 1 +
 drivers/gpu/drm/amd/amdkfd/kfd_device.c | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
index ead43386a7ef..cd7b81b7b939 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
@@ -1678,6 +1678,7 @@ int kfd_get_gpu_cache_info(struct kfd_node *kdev, struct kfd_gpu_cache_info **pc
 		case IP_VERSION(11, 0, 4):
 		case IP_VERSION(11, 5, 0):
 		case IP_VERSION(11, 5, 1):
+		case IP_VERSION(11, 5, 2):
 		case IP_VERSION(12, 0, 0):
 		case IP_VERSION(12, 0, 1):
 			num_of_cache_types =
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 6040ee7918bf..e6debd63a116 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -175,6 +175,7 @@ static void kfd_device_info_set_event_interrupt_class(struct kfd_dev *kfd)
 	case IP_VERSION(11, 0, 4):
 	case IP_VERSION(11, 5, 0):
 	case IP_VERSION(11, 5, 1):
+	case IP_VERSION(11, 5, 2):
 		kfd->device_info.event_interrupt_class = &event_interrupt_class_v11;
 		break;
 	case IP_VERSION(12, 0, 0):
@@ -438,6 +439,10 @@ struct kfd_dev *kgd2kfd_probe(struct amdgpu_device *adev, bool vf)
 			gfx_target_version = 110501;
 			f2g = &gfx_v11_kfd2kgd;
 			break;
+		case IP_VERSION(11, 5, 2):
+			gfx_target_version = 110502;
+			f2g = &gfx_v11_kfd2kgd;
+			break;
 		case IP_VERSION(12, 0, 0):
 			gfx_target_version = 120000;
 			f2g = &gfx_v12_kfd2kgd;
-- 
2.43.0

