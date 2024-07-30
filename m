Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A46DAC52D1D
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Jul 2024 20:16:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E89310E478;
	Tue, 30 Jul 2024 20:16:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jxey9vkU";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2078.outbound.protection.outlook.com [40.107.93.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD2ED10E58D
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Jul 2024 20:16:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OC07S6xzTyv5QJipkNPag9yiI2pJPjrg2jQwjcQqu/TK3ZwwJOETrxkFZTv6sDXKY9z079VoPtKoVnNF9NugAVFVo+j03O+xAVtKfT8bH+hnX2JaI7CzqQHzJ2yrJwinswkevtUWSKQQEg56bQDjsdZdASOlACHHbhP7CGSfVsdENBbXPwdszlOeAv+XV22R2va9b5/IlC5hgZ8tHRiLVIKgSfIET2+chbQ8FGF+gTg0p2mtG26l/DOoH/HXgOk8XL9qQIiKrY+gTI3FM1XLHm4PYM6BT0xHe20EMg4OfUZAsiLoWA55cDxOn1Gak+yrtigAldUX9ABQGrFGFMIWiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iSyXU8EoCACuA9LCyknUJwCf+7eSgLL30EowW/Al01g=;
 b=m/8RdchTtl/BtxIN34wsgb5Jo1dR2jwA6p/4f73lz6SlJIi402ANtIimjIOOISR2iakBuswQ69TvCFL0NObBhrnv57tqDfj7G8WHZZu0aBK+XfKCHb5rQTDXtXxxcPw0VpIxVTaJOHTCmeE0i1FPayw/z1mkQWcZcBieA5R63SOksdva/4IPZM+6HKVCVutzQC3bHlRG1mLjzqpGiKPPcidaLOG8RYVhVM5LaBIbTsP9uGHxOiwiGb7vwUycH2N8ew4kBrfdXGIQyNnjmlcV9auOcCufB7jT+ZLrdw8Qnfc/s2lPXBi/J05IRhUQ+hzuWvN4TtftX5ySemAJ3Oj73Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iSyXU8EoCACuA9LCyknUJwCf+7eSgLL30EowW/Al01g=;
 b=jxey9vkUDZAukZw2IwmGINCijl3XRUZTdqW1nLxtkxmj5ceXMuPTQNB+mCmCwNL8KihJ2YriQ6SZcrG+k+4sbQvHzpEWQOBPfHGgh4iW4t28Y8ysbpdJvwGDbVHA+wHHlNljsvAHaPn5698t8aA0rQUozPujLzNoxI1tMso2h+w=
Received: from MW2PR2101CA0030.namprd21.prod.outlook.com (2603:10b6:302:1::43)
 by IA1PR12MB8191.namprd12.prod.outlook.com (2603:10b6:208:3f3::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Tue, 30 Jul
 2024 20:16:28 +0000
Received: from SJ5PEPF00000204.namprd05.prod.outlook.com
 (2603:10b6:302:1:cafe::90) by MW2PR2101CA0030.outlook.office365.com
 (2603:10b6:302:1::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.5 via Frontend
 Transport; Tue, 30 Jul 2024 20:16:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF00000204.mail.protection.outlook.com (10.167.244.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Tue, 30 Jul 2024 20:16:27 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 30 Jul
 2024 15:16:24 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, Philip Yang <Philip.Yang@amd.com>
Subject: [PATCH v2 3/4] drm/amdkfd: Increase SMI event fifo size
Date: Tue, 30 Jul 2024 16:15:46 -0400
Message-ID: <20240730201547.13590-4-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240730201547.13590-1-Philip.Yang@amd.com>
References: <20240730201547.13590-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000204:EE_|IA1PR12MB8191:EE_
X-MS-Office365-Filtering-Correlation-Id: 37873e30-8078-4159-1c7c-08dcb0d47e54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0F1EjRf14PSp3PxNZNJT7fwa88VHIgrwjNtXaCSNWSc7JNk3OPYw49wW1h5O?=
 =?us-ascii?Q?8vVO7bpcsFSN+8Pm0vjXTElt/hjhgw2MvLb4lOtgd83vaUIA0oDGtPWri3ts?=
 =?us-ascii?Q?Nq0GTncSQgFczQXi1WzpN4mKuqNnQpBoLIMjunsCtU4woIcL1Ykkpq3FuaQ7?=
 =?us-ascii?Q?veo3hnKO6UlXZTiUPSBGSblsY83nUHRearKxxeKRSi3N9b2P1KgMRI73Zs6R?=
 =?us-ascii?Q?l7lYZK/66UwWSJmJKtTMxLSl8HSgpHfjuO18ggDRK2osgaiZFrb+yqNp0z4b?=
 =?us-ascii?Q?h9Ka0Vx8gIWEyyk3w/Um6pFhz+qudU5KNrtMGzYOY0G9PCJX6bqgS1r97bpR?=
 =?us-ascii?Q?71yhIj0OCiUHhDwUUIOiqxX8y2h1aHNgPJZyqRUmqVqwo5LElAoax8Cgvi+B?=
 =?us-ascii?Q?RdZvqmOP7si5ybRnCC68iFJYTDmnJDDFBBLQGDmA4rnvQTCO/769idZeogbr?=
 =?us-ascii?Q?tWyEN78sHem/qv27wRupzFex8A9Le9ECnAJDaqFplnYAQTNq7eDHdGHU1Gxo?=
 =?us-ascii?Q?Z73P+ou9p08E2765a+7tY2x+eYrqs5Lr0/gmi0Q2oBU7tvYKoNKYtV/RmpmZ?=
 =?us-ascii?Q?phRZ+wB+FACcVu2TQ9NSZnookUboRzqifOVGzT+Lx5FwnFiWlTpnZ/NQQZwa?=
 =?us-ascii?Q?fI6g5laUIMjmRWoPnwOP1/O3qiHDD+vPJz+cxLymfi6+WnuGIxUukWzm2OiQ?=
 =?us-ascii?Q?K5t8WSpJ4e/kCZc+YM2PuL/btYtL9TB0aN1o1/Z6hckFWGai9/eBDqXUed43?=
 =?us-ascii?Q?sqKFzFyP4q/HNFT/n8LBpZV3s8Y4qM7oOFPNiYQ3FBb0OT8QBx7D3SHmdUKs?=
 =?us-ascii?Q?LLrVsp0FuAU8014hQGQOsevmn/huD44/309OdGTzJdV0N7lcZ8+fJCxDRK10?=
 =?us-ascii?Q?kQJXCJ168GkOXcuTfjF3ZcjKPCsmIGBS4Z7AFUN6l/QqhV3mWRcKueHQkzfg?=
 =?us-ascii?Q?2BPsqLLv3RxB33FQ2IL/zqKBzrU3NW/wUfmYkLNDBdtefSq+bBg//tchG/ys?=
 =?us-ascii?Q?LnJ9NzAlnrRbLA5iB40QykbbWw31RlvQUUMcrUT1OZ9hCOCKdiiJqRHOpFAc?=
 =?us-ascii?Q?Yxgk2aotSDZNpD2e5cjlEhczE3GyqUdWKMWC/a7chttJgP7nnETNKdu/XwI8?=
 =?us-ascii?Q?LgTlz7xW6hvB6B6nejbYNqSdjW1XEEjbt/YcmzqIWDuV35X8LZY1bisCsuct?=
 =?us-ascii?Q?rrJn0HIGwSWkf8uSB7ooiuH3Ja2G3xGamr0jICcdjGPw7VxJ23TEI+08Ku6Q?=
 =?us-ascii?Q?SqOSOSBXBZQcYavLYLpshySq0fvZRASy98H/Gfpd7BWIZkZU5sqEzIeuH/Ot?=
 =?us-ascii?Q?mwgY+vn0rNiTHHAoQ9iM589QrAVCgUCohhalMLOrLOwCtkicmuX2f3GGFiuQ?=
 =?us-ascii?Q?00183Pmp/gB5cYWqu6aFVZG9cwEoD27w/cqylffqS0I/XWnHXQf/RtsAgNbw?=
 =?us-ascii?Q?F1m9pJEeRGd5e7u3EYE1qvMp06KlkJjJ?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2024 20:16:27.7045 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 37873e30-8078-4159-1c7c-08dcb0d47e54
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000204.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8191
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

SMI event fifo size 1KB was enough to report GPU vm fault or reset
event, increase it to 8KB to store about 100 migrate events, less chance
to drop the migrate events if lots of migration happened in the short
period of time. Add KFD prefix to the macro name.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
index 1d94b445a060..9b8169761ec5 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
@@ -44,7 +44,7 @@ struct kfd_smi_client {
 	bool suser;
 };
 
-#define MAX_KFIFO_SIZE	1024
+#define KFD_MAX_KFIFO_SIZE	8192
 
 static __poll_t kfd_smi_ev_poll(struct file *, struct poll_table_struct *);
 static ssize_t kfd_smi_ev_read(struct file *, char __user *, size_t, loff_t *);
@@ -86,7 +86,7 @@ static ssize_t kfd_smi_ev_read(struct file *filep, char __user *user,
 	struct kfd_smi_client *client = filep->private_data;
 	unsigned char *buf;
 
-	size = min_t(size_t, size, MAX_KFIFO_SIZE);
+	size = min_t(size_t, size, KFD_MAX_KFIFO_SIZE);
 	buf = kmalloc(size, GFP_KERNEL);
 	if (!buf)
 		return -ENOMEM;
@@ -355,7 +355,7 @@ int kfd_smi_event_open(struct kfd_node *dev, uint32_t *fd)
 		return -ENOMEM;
 	INIT_LIST_HEAD(&client->list);
 
-	ret = kfifo_alloc(&client->fifo, MAX_KFIFO_SIZE, GFP_KERNEL);
+	ret = kfifo_alloc(&client->fifo, KFD_MAX_KFIFO_SIZE, GFP_KERNEL);
 	if (ret) {
 		kfree(client);
 		return ret;
-- 
2.43.2

