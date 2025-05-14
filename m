Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E26C3C3DA4A
	for <amd-gfx@archiver.kernel.org>; Wed, 14 May 2025 17:11:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D746B10E6AE;
	Wed, 14 May 2025 17:11:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xxrue5y4";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2058.outbound.protection.outlook.com [40.107.96.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 50CC310E691
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 May 2025 17:11:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k6OxXnQMCohQdGVqYHZOcMltcPEaQ2w2ZVbnyZ3c6lLXmxoMigTRlV75QpgynQYCgK+nekHTstiK7lSPvjqkxHu5wn67xvx7mU7oyeI0iqQ2iLKzpPgUHc8k56Iy57mUJtkPvWi0optU3jL8p7HYOpfF32cqbdw9vIViQaXnsvAdF72R+SfzDLaQ8SJnKJE/upLpumB6zhli/kDg079jJ2N4Pss0uNRNOh2anlPiVdIIYh5YlLFIXXsy6eMMFI/4jvkJt4BcIo4dD/zKI5TjIm/GhJGzecrMUXvUgebjIhtitfHgMS8n3sinsYcYUZT9Jm4fQU14gw2N/ClmmoCACA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0tfY136XOGKcGt4YtcCYGikKLSuXdZoW0+t+tAEqU0U=;
 b=QplQNtGotSWKelCw7oA0H8iHT1AbEyeUF0R6JBC/XgbDuohkuyVZT/+D7vd9qEWQLhPsyiN6TjpAXrK/dTEQI65P/ZW0MeYXQCqpetNLxyKGCSPRukQBY2ISi2QF1Lt+WcA2I1+V4kumBjJvkGDS5RY6L7mW5EJbvslagQ9oioJuj/mgHo8bBdsQUc4ZFBt9e0ubsL3wc3NRWM7LXCnZYsDeOviEsqZAr+fHo0kbjNNM2749W2xFo78Jj/HI9AA5bG/LVSVf//JD/qFh95rJe4oDLuqD5UodrAVFjP8BSY7UfPGq+JzG/OIZ/VS4tw3HRlG5oXbyIf1tGNnxzoY/sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0tfY136XOGKcGt4YtcCYGikKLSuXdZoW0+t+tAEqU0U=;
 b=xxrue5y4U2hm2JKjEsSZa3AmRr88PHOg/tlRt0qQsYvKRahMlZkDo6zqqWl2mu/Z9hTF9mDwB5ohnI73Noa4GU7h6WM6h1Cf9M4J5ZAW0xG/Irbq35ZJZMBiwa7C7VSJaoKbu50vSI6s/N3uU/gUB2QKOAqXsirDj/N0zxvwL78=
Received: from MW4PR03CA0242.namprd03.prod.outlook.com (2603:10b6:303:b4::7)
 by CH3PR12MB7595.namprd12.prod.outlook.com (2603:10b6:610:14c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Wed, 14 May
 2025 17:11:10 +0000
Received: from SJ5PEPF000001D5.namprd05.prod.outlook.com
 (2603:10b6:303:b4:cafe::26) by MW4PR03CA0242.outlook.office365.com
 (2603:10b6:303:b4::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.18 via Frontend Transport; Wed,
 14 May 2025 17:11:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001D5.mail.protection.outlook.com (10.167.242.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Wed, 14 May 2025 17:11:09 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 14 May
 2025 12:11:08 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <christian.koenig@amd.com>, Philip Yang
 <Philip.Yang@amd.com>
Subject: [PATCH 0/3] Remove process exit error message
Date: Wed, 14 May 2025 13:10:01 -0400
Message-ID: <20250514171004.4259-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D5:EE_|CH3PR12MB7595:EE_
X-MS-Office365-Filtering-Correlation-Id: da858f85-c2e4-4d6c-9672-08dd930a5277
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?RMn4EtM+KmlL88rOQy96zNRFFu3Wus9rY4Fb5frPPPU8ogNxjtPLvM3nN4aj?=
 =?us-ascii?Q?OrY7NDXfjhc1thvmGZU01WsKOGZHIeTzMUiZihhVOQS3k8mOUN1loRUVBSVV?=
 =?us-ascii?Q?9SL4sg78570tCvQmGddJwei4mJhkstjv8rpJH1Sxjq7etTkMvG2W7j7W0fEi?=
 =?us-ascii?Q?b57tT0gOk6yrmc7Atntyg6VXpE+hDIhDkPzyzqOjJbiWG8hnHdOhMu9f/iT3?=
 =?us-ascii?Q?IBK3p/YBjoS8vZjuF4uibMi+2CUAev8po6ylzE4htucCphIhbOKM5aM++CNI?=
 =?us-ascii?Q?/70YOH4E2+wejUHpv5A9J4Z3CdANxb30AXHu4YZdlwILXImfUQPtJBoSLgq4?=
 =?us-ascii?Q?qPo8c6GcvwdlTBHaf53y223vymplvwWov3f74tosnegTN4Y4/cpNAx+PJRAA?=
 =?us-ascii?Q?QMgb2SbAgu2Bk3vERa6NhjuLaA/NB0895pluqwH47sTay0uBup5fNuAt4LTE?=
 =?us-ascii?Q?YXlfrxXNrnQZJ7opCvsSs8YAdQsTD9T/O7dsUoaDOUe/mWNvzBNk6rTJABqU?=
 =?us-ascii?Q?luGws6prH7NXzbSEjaE99WIEgHQq/JCBvM87BuC8PYrMNIXFYYwtg4MfVvyf?=
 =?us-ascii?Q?PYWwqXlrToVvLxVIGCo/eyKIC3fcIjG0EAbjQ6Bf8ZY5HffpB1P1U30L3Leo?=
 =?us-ascii?Q?kUiQBlQRPg1ItdsNZe5ACzvm+7FGQLBortSdDZ/ux3n0vQHkW15u3iMHDa/9?=
 =?us-ascii?Q?Bp96tU5B5m5AyIJf3n9QWWz+MsCpZe2M8BdvK5K5ltJpB/ePVvyVmAvhCugr?=
 =?us-ascii?Q?1KE4QOTGrooQMWmFx5mld3xFOm8p5IXxl3W5J6GnpVBBAdpfzP/AUJuoJj9d?=
 =?us-ascii?Q?VMI604GYwxhRWaYh8aeDHfoHuofjs5AStRTNrdQJV6k43bKR9ypOuXx2TCwW?=
 =?us-ascii?Q?VrXSnCtF+cxkjh3eU0O59ZXQ9j0M0cgaWp1yb1HMlmpucMbnred/xWbn9fOa?=
 =?us-ascii?Q?AvSa1UmTMhLOL5Du7ty5i08z+KVPtl+GTx7d/IeWGzQ8A6KbJ0W29YppVlOB?=
 =?us-ascii?Q?Az2dO9CKyKiQe2JYjDlF0Q7/gEOK+m1K2bVxmPw38ntLXBZ1ogmUBJHR1ceB?=
 =?us-ascii?Q?OLkXXGlS4WTdy9KmUslllejSBcrb0reO2671F9o3yEJq6pSktoIpnu1HWuhO?=
 =?us-ascii?Q?O41CK8g2v9letMJ0AP69DuthO32k0RY1Bbiv3qlXRDpbvYecdeF6aN4Ir8EC?=
 =?us-ascii?Q?9E38hHipIyWiKNlDdiO8CvZlxfUfQz5ukqXQpndygkVPwCtbHkM93NKLZ5Ti?=
 =?us-ascii?Q?gZJ81xtRxtmUs8LONfTyu6ecE3Vo4F/CThLxRzcRVnzW8edkNx9JFYujmQTR?=
 =?us-ascii?Q?b4cvXdnqwJMxSRpEwrLruBW1AWxM8OcqXtLpH80qGOy3ODc6IPUBKH6CyoZE?=
 =?us-ascii?Q?A4sry7QLP+QJlqcMmO5QNVVetvUqxgBVo86En5JMfccT1dVFgVomzUpbAtsB?=
 =?us-ascii?Q?0K2r91poqju9bE+2pXNiohZ3riUbqdwBPWm67wsUlwIHw/CPabSZ3J7ilFkz?=
 =?us-ascii?Q?prCu9frDSZhHj8t6fuOI7lXxe1tU01JeVga2?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2025 17:11:09.6456 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da858f85-c2e4-4d6c-9672-08dd930a5277
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7595
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

This series fix the dmesg error message "still active bo inside vm" and
2 potential races when process exit and vm cleanup.

Philip Yang (3):
  drm/amdgpu: seq64 memory unmap uses uninterruptible lock
  drm/amdgpu: amdgpu_vm_fini hold vm lock to access vm->va
  drm/amdkfd: destroy_pdds release pdd->drm_file at end

 drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    |  8 ++++----
 drivers/gpu/drm/amd/amdkfd/kfd_process.c  | 10 +++++++---
 3 files changed, 12 insertions(+), 8 deletions(-)

-- 
2.49.0

