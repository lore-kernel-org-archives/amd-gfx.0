Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32EB4E7717D
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Dec 2024 21:48:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D330B10EC32;
	Wed, 11 Dec 2024 21:48:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4v58talV";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2088.outbound.protection.outlook.com [40.107.237.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC18410EC2C
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Dec 2024 21:48:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GdHz4Cdy/CTvhG4TCrSnl8O/QPSVMFEv1qriQjrkZ3PN5uiKl8Npli3KEgN5FqHb1o+jhAO5b3jwDTGIanmFkw310VKMdTl0hj+BfsaxkEKXuuPIzHQjTDo0HC8hFbrjYQYc6X1EbxckvqBfVTktBat2kwe5kL+sPICvo5b1cUMsQ7QygrwlOUDxwt0Ww3v++jqNJQMuHBkqydewMe44rlnXtvqKZymyKpBLsQDmak1N6viy+IcQDYVXhQjt/Hfv3GlvqNdfokcqMMB7Vzmj8NvPlPhboiSInWjtJzU/kDfmUHvoImRfw6uzeBzhabElmKBAY01+FmTdcqWc1Z3XMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=90+cAlrylU8mkaQAX1dh7TrC0/ijF2iyFnz3yqFs8gY=;
 b=oTrHpIzj8RMcXhrKjlGBlzeQZyVBC1Gp2w6pCjQDf2wE33YgpZDckd+blt+oopYTcEthuAJ3xoSA5J4MDx1QLWY46wpIiq3vfYmeR/JIJNwVhG2Lkvj1vz3oRuRM+mADxjv1WtArN66Wr6llq8wkYhKMuiDCbId7D1URFLiEqblIUUWbbaCSMLvl0kXxDfhyeTQJKe7mIu3HHFNtxLjypWIBvxI4nlu8Hmk3xT4a22xFaLrl+dKmLDF21rz3UvA+Vuh5yeU2VJ3WIG8WCcZ6exf7HgJtEeUGvzEL0tJQQpLbnFA/xScH6VawTB3aqWfsZ8W+B5AETgVDfuCzMTJAqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=90+cAlrylU8mkaQAX1dh7TrC0/ijF2iyFnz3yqFs8gY=;
 b=4v58talV7N7xDQyyoGNoov2Tvocnil8EWpk3krrWeDrDRE38OgrUAhgeDR1MuBaRDFlObLy3GxOlkvl3mvYrKcX3YNlSGgal6GkQ+HLRlbprWTGzP4VYDNB1OQ0itzlLS3KcTVn/jpDiCLwQ1yqzctriU1r5HmOdWJ4Gpp0JPjk=
Received: from SJ0PR03CA0369.namprd03.prod.outlook.com (2603:10b6:a03:3a1::14)
 by SA3PR12MB8761.namprd12.prod.outlook.com (2603:10b6:806:312::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.14; Wed, 11 Dec
 2024 21:48:43 +0000
Received: from CY4PEPF0000E9D8.namprd05.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::17) by SJ0PR03CA0369.outlook.office365.com
 (2603:10b6:a03:3a1::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.15 via Frontend Transport; Wed,
 11 Dec 2024 21:48:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D8.mail.protection.outlook.com (10.167.241.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Wed, 11 Dec 2024 21:48:41 +0000
Received: from dell-1e707-d05-15.mkm.dcgpu (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 11 Dec 2024 15:48:39 -0600
From: Bokun Zhang <bokun.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Bokun Zhang <bokun.zhang@amd.com>
Subject: [PATCH] drm/amdgpu/vcn: reset fw_shared under SRIOV
Date: Wed, 11 Dec 2024 15:48:22 -0600
Message-ID: <20241211214822.28160-1-bokun.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D8:EE_|SA3PR12MB8761:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f778b80-a184-4d74-4e9e-08dd1a2d944d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1IvhoJCwr8Bs/ibHPremrfIgEuxi39mdYmssqM01O1owP6ZhN6azdn9Bs8RV?=
 =?us-ascii?Q?7Sv6Tn2W23qxLGPPl0TvT48SP7H8OiipOwbPAkLqPppRYpDtXwlHVP44kYWO?=
 =?us-ascii?Q?USClijnE4LqjNXCOjhnsRp3Ra2OqshVtMiaCR7p8GQofPwwl97iev+owzw4I?=
 =?us-ascii?Q?Vbx3PQvo7dIuRucYTKU7w+nzvurAit3xGzl08rQMxJc4uAQ9CnwGFX3wM6Hf?=
 =?us-ascii?Q?AIEC14abfJvBm9KUY8CrmMLiObaKCWoWckc+YvAWREh83stX5qpMx8tg61ZB?=
 =?us-ascii?Q?1ueP7WbCbpS25m0jjnZeINN6VTjnet7ctIEX4oCcXh/DOPDMBsIO5X4BeqGl?=
 =?us-ascii?Q?MZMVH5gp7HWQGZy5LsaoYUeeB4UJcLcfv/2Jrk3TGYErBVEKs9DMmDVyP8Io?=
 =?us-ascii?Q?TtyHZXTSigZHr34B4RMk+pcrvZTWTZmIIfBcZ6JTuzPRbmrBSyBgMuUyE9Qr?=
 =?us-ascii?Q?+DPoEIAKq3Pionzc2UBlGUiFqxNjWzDto7qpXGLbK4Ay/d1GTont4EkzKHAZ?=
 =?us-ascii?Q?BKX+qPKfT8MlVdtjhLi2ZdTo92PCJv+PoTPzM+rVzLIgcn/25/NG14uNVG9P?=
 =?us-ascii?Q?HqOBmrUXvWhv4w7v/lo3Vao4Sd1jIaN7uPTLe8DR0iDoqUm3szigTPaNQVn8?=
 =?us-ascii?Q?Vd+P+TWssJCFVU7Fzzovb8MmaMYALlLkG+eKV5GnxF7isgBuRjj73yVnZ7j6?=
 =?us-ascii?Q?1AXNCUuVaxhX3IQeXw0cEwiIZKQB1QhQh6Y7NNv83VkUVGp+42Ya24/7A1M2?=
 =?us-ascii?Q?Xnov1gchaSlF9cqNWe82bKHeYRLu97zMQmUM/5Au80X2MKnH2kBnMFzQ5h4Y?=
 =?us-ascii?Q?Spaid+PLxRfiLci6ulM4cdCY3/aUdlgzL8SeITP8CdiI6327Cs4WNwtvV0uU?=
 =?us-ascii?Q?6MQ95VZAmhkd+cc0lrEgbC8cEztwQ4qNVJiNkJ4dhLAdwe7n+xPtJ+we5ATx?=
 =?us-ascii?Q?mbDSa+hQ3LpRrIRywj+IBqoJoZnrB+wWvgkEiCjcQ3qP2GZk7GY+CZN8gaLB?=
 =?us-ascii?Q?RNyjm550c47GDms2/NWYmAkqTPzYIDp6eKy7VCSYrZw/VWYRcVuvziQq76l+?=
 =?us-ascii?Q?egK/rF5bxQQheGsEHG8cuz1y8SWQm5lz2gA0BbSFrRVLKXvx7aqrGYuy4aSE?=
 =?us-ascii?Q?dP2lqVNw9HzwbjdnDHq6wOrmRfi0hZSSS7ovAK36Hnc4kBvuHQil0kjV8Ed9?=
 =?us-ascii?Q?tb8/VxmYsh5T8gVXPj+zndCYRstGcCnQr5XKyIsevScGn98VHnDZb9Hxi5rr?=
 =?us-ascii?Q?KWgF4kSQgvgVLEoWUslAfVMmRjlpg6W8eSv5POkAW9ogVlNanjVWzNGOa3HY?=
 =?us-ascii?Q?YvIFuqRQssKKaqwowwngecsKVubmZF1nBmyzNckt9atYWgkoigeCwajjfs80?=
 =?us-ascii?Q?0MJPtFd1RF730Yks/iWcO7v/1F0kqBk9aJR5P0pabKLYQw2EOtbTnblVYzjl?=
 =?us-ascii?Q?40LXygxWXKEnfP/wVS3XcHc9FD+j0FMn?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 21:48:41.8704 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f778b80-a184-4d74-4e9e-08dd1a2d944d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8761
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

- The previous patch only considered the case for baremetal
  and not applicable for SRIOV code path. We also need to
  init fw_share for SRIOV VF

Signed-off-by: Bokun Zhang <bokun.zhang@amd.com>
Change-Id: If26a377a2fe8f2aa09bfa21fc54bf26e80fd564c
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index eeade7366e82..ecdc027f8220 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -957,6 +957,8 @@ static int vcn_v4_0_3_start_sriov(struct amdgpu_device *adev)
 	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
 		vcn_inst = GET_INST(VCN, i);
 
+		vcn_v4_0_3_fw_shared_init(adev, vcn_inst);
+
 		memset(&header, 0, sizeof(struct mmsch_v4_0_3_init_header));
 		header.version = MMSCH_VERSION;
 		header.total_size = sizeof(struct mmsch_v4_0_3_init_header) >> 2;
-- 
2.34.1

