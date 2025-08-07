Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 912C9C87FCA
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Aug 2025 20:50:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2947B10E012;
	Thu,  7 Aug 2025 20:50:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rAQEdVmx";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2046.outbound.protection.outlook.com [40.107.220.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 656ED10E012
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Aug 2025 20:50:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IQ7kD+JcHG8SLVZ5Vlf5ZYFCwsoq+Ce5P8F896cQ35Jlp1v8RK4eDTojldQn+iak8N+v1muWOaBQi6x+NIIFAWqKg3+LNM+B74PAep9gcvdJGo2t+lGDlelG6IEd8uk9ywWWXqIesBUcp5Tkz2FBraCyUcEMgVqw7brAuZBwLc03pC+TlZ5w4SbgN1QBw02qcMomPQ9+1TY0e7IRdfpGBwqc0jbU7OLIpaDtH5I4jy6JW/6pFVYQiqr97Rz6hnD5X7ueTYVPu3qJ6bcaDnWQFmmAnnWqvomy2qGtrMQKiOJkb69xrH3Y3I9WNdo2CjYgqoxske9HUX1McD1y2iuLww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m3HjKS5bgWhr4XK56JgDwbXl9GjcfJejY6NBTt3gVkU=;
 b=JM3oORqRQA1sgkZJBTilhq8Jws4ZvAeLFCDiWpPdfOwKMMMeEziQqExT6PL4YcJNgimPpihqe5hDNZP1/xW7NYRL0bSdnLTtrqzDUp1sIbZbOrW3UG3T3lbAiYavxGHvHpyzNLqsG4/8YEIWwrOotDOW13EqGkI3NM6ON9Z+i8mq81Y2bT4riJM+MAiE2aUOxjSEEoLgny1+wvX+pfxMqWgl8cShNK+agQA4fF0vHFvojv/sGnnJ6hfI005fFawFfqU6Udr/V8kaud+HpWgPW814o4EP9M+4ElNvwQlqdJC6eFtsn8XpvVIag/emd8nxVmjXRN90sI0NrWzczpPToA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m3HjKS5bgWhr4XK56JgDwbXl9GjcfJejY6NBTt3gVkU=;
 b=rAQEdVmxQa4/LoJ+U6d7lXSs4lMMzPFGgy5gYAu+PYt5+lWgCnbZUT5dthUi+dSJFbEygtZu4huYXStrnbUHmRGiMiMhmtJCdkoLkb34XBiJl83u8Lxy7X5rcfoUiFQnYqczixEt2DjdvVCN96YOTPKCZay9Lv4kOEcaPAYksL8=
Received: from BN8PR03CA0019.namprd03.prod.outlook.com (2603:10b6:408:94::32)
 by PH8PR12MB7183.namprd12.prod.outlook.com (2603:10b6:510:228::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Thu, 7 Aug
 2025 20:50:08 +0000
Received: from BN1PEPF00004684.namprd03.prod.outlook.com
 (2603:10b6:408:94:cafe::5b) by BN8PR03CA0019.outlook.office365.com
 (2603:10b6:408:94::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.21 via Frontend Transport; Thu,
 7 Aug 2025 20:50:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00004684.mail.protection.outlook.com (10.167.243.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.8 via Frontend Transport; Thu, 7 Aug 2025 20:50:07 +0000
Received: from eric-hp-elitebook-845-g7.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 7 Aug 2025 15:50:03 -0500
From: Eric Huang <jinhuieric.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Eric Huang <jinhuieric.huang@amd.com>
Subject: [PATCH] drm/amdkfd: set uuid for each partition in topology
Date: Thu, 7 Aug 2025 16:49:48 -0400
Message-ID: <20250807204948.286132-1-jinhuieric.huang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004684:EE_|PH8PR12MB7183:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fe5a38b-332f-4140-fe9e-08ddd5f3fe2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JMUd7Koj4mkGT6YiWg7i/V1oha6fbnxk6rrI6CG4/0PEbewcClo4RPI1ig3c?=
 =?us-ascii?Q?DirJU7qjSlXB2y3sRgwd/Kl4GOYX1kEZSH4RnEo6EhjrieTlTwmz0Iy+s4aU?=
 =?us-ascii?Q?BIs0qZryI7CDpCZVZZagJTBrQvxZ4t+Y1uQz2Q0yIVQrZAUTJNjxUuNJyCmo?=
 =?us-ascii?Q?qHePefvciXda61pznZs0bwswZuS4TJLvCBt/LwLe6Y0z9o9hKB2bpRUfSeQI?=
 =?us-ascii?Q?qN+HCSng14h9pYIE9zv27ByBLUD3RKswL4xF4rmpNEqh8vm/BlnzlBhCCM7r?=
 =?us-ascii?Q?2C3pjaXAO0inA1BgIL26d4uktMhXSIJZz0TVuMF/pNoNSPtAI93yA9YQk++s?=
 =?us-ascii?Q?YRGv2+OM7ZbsMXJ9e1hF742QFMgv0Fbq/1H4qc2sniZLeL41+4PXGTxcWu/r?=
 =?us-ascii?Q?2HjNZxjb77UrY5YB06exdQx67GTz40e/+a7O+xrd7CeDkbO2ed+qj6IWkCEM?=
 =?us-ascii?Q?GZGD8f8O8HDQzWPeIfZFMogzNuigRHlq39adyjc3N96OO4weGcji4+2aj1EK?=
 =?us-ascii?Q?fHTsumHG9IUNAz7R5Qsp2kmtTOaAPs5cgGEqWd0XMq0Lv9IchXNOXdIJzp6R?=
 =?us-ascii?Q?W3pbOVw9Gecj6TWW3e2qveOUFiu1ybRpKKdHiGv4wIFUOtICLauZ7GIZz8vD?=
 =?us-ascii?Q?wqE6TJpWygoJV8YrRuZOKI1OwpH9cGquRLmASrEYEP7388h/7iUGsDDzvE1D?=
 =?us-ascii?Q?VXyqNqGl/09j5gWfq4u1yc6Cm/oDrYZk7Zvk7WK9/bpktalWgBb2g8mQOeDe?=
 =?us-ascii?Q?u5ArsLEYbaXb3KTJJ2l8qOAuw7qtZqyXnJ4fDPQOigINZNgfHnjKrF7eUZgh?=
 =?us-ascii?Q?QUj5E3La4ZT+WL1X9F/9YSAM4juzbMrDS+ZFJhUgSRGPhpLTh+PpxxDE3xxL?=
 =?us-ascii?Q?n1WZfGPKqLBeSbzJkNxmS1dBBnYo2ESCuRDtt9j5x53kq7xtkS5J4jW+MNYK?=
 =?us-ascii?Q?a/JYCEsNlbI1uVijKbfU4X1mgrToKnGICoRNq6TbKRnmlLWMPnazzQsRSQ4f?=
 =?us-ascii?Q?CKfTElKyxBpKI3ylpTtIAulMIkk4kFzd4bgTxhCUHqwWrlCEJA5KZC5qulpk?=
 =?us-ascii?Q?mYeqMtRAlTcrkfkS7n6Qo0rZy2CegKltO5I7B5ilB02tw0oep5TLeZtYbpXp?=
 =?us-ascii?Q?b+DMWD+RGHBmq4Fsozi8/jt0ynAdIHy0i8zz20Fn2rG+xAiKB0HnXDLt+uMK?=
 =?us-ascii?Q?SO3BZI3ANliKt05/Bk6tndFU3rbMoU2lXxmae86kMc8qIXk/X6k/4vaF5umR?=
 =?us-ascii?Q?8DvlWjvxbmjmObkjFY83rdynY6yNee8qFN28uEJUYtFiQLbuy/2z2Ao62nFo?=
 =?us-ascii?Q?eiaSsi7BmBpanSeguquysLrRifnZEqr/uTxBYG3ZAs8miufPrAOP/jhXAZVU?=
 =?us-ascii?Q?Y1Vvx8jzdpWvqCsoTQcarfsTA4esqUsxGKgo5dB0dOmOrQQla868kHNzJKcO?=
 =?us-ascii?Q?1p5IeJbXuUItD1wZXpA0NsXj5hQgpfB9ecW+HlisIVTo7EwzFl4KuEtBgPw/?=
 =?us-ascii?Q?FAmrYdnktjIBR29GXRusAGznuiotnVRD8LfL?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2025 20:50:07.4180 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fe5a38b-332f-4140-fe9e-08ddd5f3fe2c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004684.namprd03.prod.outlook.com
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

Currently each kfd compute partition/node is sharing
the same uuid of AID, which doen't meet the CUDA spec
for visible device, so corresponding XCD id for each
partition in smu has been assigned to xcp, and exposed
to kfd topology.

Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index 4ec73f33535e..14b5fa670727 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -530,7 +530,7 @@ static ssize_t node_show(struct kobject *kobj, struct attribute *attr,
 		sysfs_show_32bit_prop(buffer, offs, "sdma_fw_version",
 				      dev->gpu->kfd->sdma_fw_version);
 		sysfs_show_64bit_prop(buffer, offs, "unique_id",
-				      dev->gpu->adev->unique_id);
+				      dev->gpu->xcp->unique_id);
 		sysfs_show_32bit_prop(buffer, offs, "num_xcc",
 				      NUM_XCC(dev->gpu->xcc_mask));
 	}
-- 
2.34.1

