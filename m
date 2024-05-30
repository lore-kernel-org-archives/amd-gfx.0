Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B904C25B78
	for <amd-gfx@archiver.kernel.org>; Thu, 30 May 2024 03:48:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 724F410E541;
	Thu, 30 May 2024 03:48:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="x8j1lWwP";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2054.outbound.protection.outlook.com [40.107.223.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E17B910E773
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 May 2024 03:47:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hgBNBd7YW1NLpE2X+lbkNz94f0zomttwP69MThQw/qZ201YMbIB2IWsF4H/F/SHaIeAaDg3T9Xnl9BMjBPenwhHURz1KKOdEpQwIsh6x9BtUtac0ssEdDwA27qT5SEVgYWL/UNq878weQTKkZHq27n3cxqHIvAG7aJ0rqm7LkP/Ys8om+6dngGZxN2FEH8eRfoqHJTZzRuAIf7LUEAF9ZFXRFuR2ObZWNxgVuF/MNmFA3zsYuok++GcToVqZKq757tqWdJs4cCsK8eT2+hGpKUXnQ/srysYmHuVAFepy0BhixVY2uXAGixpaQevRzTcxaLBj9pVvt9Pkx4H6wZYuqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uP8+2GnxyEtxHSh5PilmxItuQxVdNWEekitFQEoPJcM=;
 b=WOHAqOBCa9T+I87d0c1OGAXqdMmvLXlyPdBTIYlrWHByDPolyN3pkZzGK8Bf8P/LIJmmcEJiLxzm6UzCxlvZFwvZ7CpPOP+jOYfJtk21KU2nuiXzq/9B6OadzmdPxXl64OlR2TCof7HPX0RcqjWWMoQBNQjV7t5uuu7/nPBC/z6zbOBKV5N+DzTSouTlUpgqoe+cgevl6bvBc0HwU4E5gn++25h6f3vt0urmaI3N0psYdlI9dbT/z4f2UbjzAyTBiRwSKEKsbuFd8CSh7JZa1FqrXFLHw05iSdQCtDIphPTnPgkPmqmpsrXhB1+LrUfcx00McgUpKemtSh4JxIVXxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uP8+2GnxyEtxHSh5PilmxItuQxVdNWEekitFQEoPJcM=;
 b=x8j1lWwPjKj8Sp5r4Tq5h4iH73Yfei0SWTx3Z7wUrp7C1Xd+QqAT5xMoxr7H366j/4vZf7nlvLCPfGXuhB9Lmnv6us2PI2yOjArsd5k3nySD68rmnPUAbcoorsZxRoRgMWoVzrr5DWMkaCg1V5pghB7lHcuRYQOkucQy3rfD8x0=
Received: from BYAPR02CA0065.namprd02.prod.outlook.com (2603:10b6:a03:54::42)
 by SJ0PR12MB5661.namprd12.prod.outlook.com (2603:10b6:a03:422::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Thu, 30 May
 2024 03:47:53 +0000
Received: from MWH0EPF000989E5.namprd02.prod.outlook.com
 (2603:10b6:a03:54:cafe::7f) by BYAPR02CA0065.outlook.office365.com
 (2603:10b6:a03:54::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.18 via Frontend
 Transport; Thu, 30 May 2024 03:47:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E5.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Thu, 30 May 2024 03:47:52 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 29 May
 2024 22:47:51 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 29 May 2024 22:47:44 -0500
From: Jesse Zhang <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Felix Kuehling <felix.kuehling@amd.com>, <jonathan.kim@amd.com>,
 <Tim.Huang@amd.com>, Jesse Zhang <jesse.zhang@amd.com>, Jesse Zhang
 <Jesse.Zhang@amd.com>
Subject: [PATCH 3/8] drm/amdkfd: fix overflow for the function criu_restore_bos
Date: Thu, 30 May 2024 11:47:44 +0800
Message-ID: <20240530034744.2341224-1-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E5:EE_|SJ0PR12MB5661:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f092970-8b73-45d9-ce1a-08dc805b48b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400017|36860700004|376005|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?00xvUmybFmWFk56EGKiwgEjCnaE+Ey35mwHUpNR9GajYOezfpVbQw/XsefQd?=
 =?us-ascii?Q?5pYQUEsPTrbnsZrmVPt9Axg6sEI0lpLz8PvyyETEOBfq+44R4XQC9sW1GmPh?=
 =?us-ascii?Q?TGpF1aw3AbNc67QgLsEGE/s+r299LIuCKKYDZvZCiMpAhhYL5UvrYfgccqH/?=
 =?us-ascii?Q?tmimnkCr/bO9xZwlc2OkxE3LrM4QEf9BeYt86WCeGWiZy6+jCbSvmDLKVDXe?=
 =?us-ascii?Q?2pfiyOXqP8HsLBixy7f+VyQYqC9bfwjSR/ByvNLxGSouOUoXwWonRWdR4I7Q?=
 =?us-ascii?Q?lYOdTSMdaayiiboqrN51omh9MIr1Sr1NFV2d6dwHeapreSs/8Lu9bosLqRLd?=
 =?us-ascii?Q?hGdrsB1I8jBwBkacS9KxGvvZeugyD3Fn/R74nhGpOKqE1dvgpRhnOpb++kFH?=
 =?us-ascii?Q?LVU8RmuNbyOez+ej8lgqM+EaxZO0+buIk1aOu2q3DTnV/ZdC8PhFIEMTJMM/?=
 =?us-ascii?Q?+S00GrsIUXtK4rEDZN1e+GXhpRw8DjyJk105UDPC44SrLgJmw8XRwhF11E1g?=
 =?us-ascii?Q?b2pb36719hV+8N2GgNfnkbGtYQgEGjZ3A5WP7eRrDghFEjodBf0x+mg69XHi?=
 =?us-ascii?Q?Our91piQl+edpWH146WM8xpq6vIgpUksFEWApR2ZXtuQkxguZ+2fB4fBskYj?=
 =?us-ascii?Q?rRMrVyORmqAD3/UDfYHtZj1TBh1W3wYZSUhpbJ7WLwtoEx36bCkuqMPttPaK?=
 =?us-ascii?Q?oubWYLCFIEhuA4C5Xstu2EV92plBKhOw09G2yRc1mZ+Iz9WSK2L+yAABhUAF?=
 =?us-ascii?Q?A8Bfcn5mX/ir8v8uVTuJazYKVI4wyBMvjq1ZRCgsl60bwKP1gdHEUCOmTJGh?=
 =?us-ascii?Q?XlOdCGedz5JiOD3gq+YfxoNaWDr8iBJTMscr8pCfjgk3AvOyJpd/DZTkb6WY?=
 =?us-ascii?Q?8gx6RWiYCB2JhHqhDtwgw8WZaIXQY76lvD27bzKBl6pCXuWKLD6TQy4m7OxQ?=
 =?us-ascii?Q?FSRBiPrdsRJDgo+ml2ntf8K2QL9rxEjYJh6TeQCeb6Lu2TUyPb4sI4+tWsWO?=
 =?us-ascii?Q?G1pl29vRy98hERjKj5md8IwIBhHnJml6h2aCV3p0SnISSe1shNyGHoBbQPv4?=
 =?us-ascii?Q?JhS96rIFDG5z9qDFlJkR+YadY9/1FbayA2ZM886fDWXpRzb+3+F6mFL/aW16?=
 =?us-ascii?Q?rtpIOJq4VD8KaA3gkif0tJQOp4pvKctB9PGsJ7NRqi0dZUjCCiMavAivJK8r?=
 =?us-ascii?Q?iSmp905gRaP9Mogbiuv1VUFAMibTNgbNf2i8/yhISmN6TYjT2fxnA2sKdvse?=
 =?us-ascii?Q?OKEggahR6znAn9TH87NZgDn4H7Kjh6wxlutnmyo+1HYymsDtTFRjPoAY94uC?=
 =?us-ascii?Q?MFBU7tGzOzMhtuxuhnQ9ax0QDd2RNNfa/c6ZIq2f00wzh+sZPqP/uxrhSJ7T?=
 =?us-ascii?Q?dhaZQr97YT+B0qk6owcyJesPeg5O?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400017)(36860700004)(376005)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 03:47:52.8549 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f092970-8b73-45d9-ce1a-08dc805b48b4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5661
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

When copying the information from the user fails, it will goto exit.
But the variable i remains at 0, and do i-- will overflow.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index fdf171ad4a3c..dac8fdc49e3b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -2480,10 +2480,11 @@ static int criu_restore_bos(struct kfd_process *p,
 		ret = -EFAULT;
 
 exit:
-	while (ret && i--) {
+	while (ret && i) {
 		if (bo_buckets[i].alloc_flags
 		   & (KFD_IOC_ALLOC_MEM_FLAGS_VRAM | KFD_IOC_ALLOC_MEM_FLAGS_GTT))
 			close_fd(bo_buckets[i].dmabuf_fd);
+		i--;
 	}
 	kvfree(bo_buckets);
 	kvfree(bo_privs);
-- 
2.25.1

