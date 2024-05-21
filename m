Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2C1BC25B74
	for <amd-gfx@archiver.kernel.org>; Tue, 21 May 2024 07:17:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A65E710E3CA;
	Tue, 21 May 2024 07:17:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JW5eKw95";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2053.outbound.protection.outlook.com [40.107.236.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E346210E31F
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 May 2024 07:17:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c5qROw1Ahg48gjxrVyZRF0ckLLW5ua1q5bUyVkdXHo9e9qiN/wwgjOGD1iznQIX36XghD6Qysbq/miIUwmVdNNLr532x1GfeiyfxRtP2wgC3r3w0gWUPe612cPTzt7afO1lsrpuvXrMwP6YLp22jeVnYA1qTikKIM3z9aDX9tEze8eWvezpyIrtmhnl5zLzA6FzH5tfmqKuRK7vK37D0MoVvCpGTeKwtdW32fi6R83DprWaLammYrRxJqP4CTQCtcPar85lLo/PWOV3Fi/VhEy8We2hIAqfATs4zQltSpF95BnaT+EiKNv1imL2wAdZZP3nruOQFisexJCjrUGQXuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zo/dssJgMzET1NhICyAgNFUDSvxcj6pJbTmregmUaWA=;
 b=dl+Us/gptEbVQOfddV++rNQyG5zcnRZYt4vBWV5NuXl68XF+l209rJbYEXowzU3GuWvg6cew+t29nU0PenquGmzW7vs8RjUCsOnOk9b4SFQ9uu7JW5qSgfq4k4I0MX/IgU0+vBeJUzLRGJww4wQN/GWg/eCtgd9ghMubLJvAOu+9NeTHzcyYdgRIugkikDVSBqKJtyiU90gGxlxTkPCC5+jbftUoqlgBLExcF3KXfv7k3qHuHgsfjeTCeB5Y5OG8N5PvNrfQequu5fDdbc4Dor0Cr7J86y/oLAvZYx7eChvNRQeKtz8HBGjU8v9BsUm2HcUnOHMgU2gZXkCUgTzbOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 165.204.84.17)
 smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=temperror action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zo/dssJgMzET1NhICyAgNFUDSvxcj6pJbTmregmUaWA=;
 b=JW5eKw959f6gmbP2GdAXViyuah4CFWSQIIIT3WXKE4Hs044lWRq1G1h+3ujJHllrTXdsCPNzbvQFJqJz79OPPeJc2Ru2n0zMwtDoQh+n3FvVfK/o8VunpJzEX32XtdKX5EtWw/9pUkVkdSYR+gq8qDmgda8PQhVihJP1SwId8D8=
Received: from SA9PR13CA0073.namprd13.prod.outlook.com (2603:10b6:806:23::18)
 by CYXPR12MB9443.namprd12.prod.outlook.com (2603:10b6:930:db::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.28; Tue, 21 May
 2024 07:17:26 +0000
Received: from SN1PEPF00036F3D.namprd05.prod.outlook.com
 (2603:10b6:806:23:cafe::34) by SA9PR13CA0073.outlook.office365.com
 (2603:10b6:806:23::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.17 via Frontend
 Transport; Tue, 21 May 2024 07:17:26 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=amd.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of amd.com: DNS Timeout)
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF00036F3D.mail.protection.outlook.com (10.167.248.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7611.14 via Frontend Transport; Tue, 21 May 2024 07:17:25 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 21 May
 2024 02:17:23 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 21 May
 2024 02:17:22 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Tue, 21 May 2024 02:17:16 -0500
From: Jesse Zhang <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <Tim.Huang@amd.com>, Jesse Zhang <jesse.zhang@amd.com>, Jesse Zhang
 <Jesse.Zhang@amd.com>
Subject: [PATCH 3/4 V3] drm/amdgpu: fix invadate operation for pg_flags
Date: Tue, 21 May 2024 15:17:15 +0800
Message-ID: <20240521071715.371468-1-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3D:EE_|CYXPR12MB9443:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f225770-50c5-4baf-6a2a-08dc79661093
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|1800799015|82310400017|376005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?D3Z5CKHIy00ixhq+UmyBId7K7X5x0TGbvVaxw21Iqt4qJfJPqhbaAe4dJnpe?=
 =?us-ascii?Q?I3grn2QFudCiXtstxAQIuEVMGNKc642TZb4IV5h3GpVOxJhv75cdPl2P6E9c?=
 =?us-ascii?Q?4QSOn0HaM+CYAHxsJLJBPn0CNtWPYQsUwP/kj2bVzYEfoKfA+l3q90g+yjgt?=
 =?us-ascii?Q?dSYX0cd/i5x0cLspGRvqev0c7rjtFaojAyQ5xGYAelDqw5uYwxyY+iaxjPVx?=
 =?us-ascii?Q?yS0jA+eETY3nb9FSpcSZRvHJK+g6rLlpp54qDzj0qUTrkEu/Rz+y68520/Dv?=
 =?us-ascii?Q?GwwiEysIhy47SHQb2Q1tVx4MaMefa+m73dyWXz9hPEsKEtkLZDwekipot5Aq?=
 =?us-ascii?Q?xFQXIaSyl3dprddXyMUrdthE0vQ9SdUrQFCimI91rjsnRAASgyRbokfXErEP?=
 =?us-ascii?Q?hE35mDNIs9Gu93X95fUYgl00eWxOrStb2wBR6/hZ3IcRPmvFRZRmLGpZmWgz?=
 =?us-ascii?Q?sPRUirJfimRQgL/3IRDZ0adOCfot7UzQvb2sXz+g8Dmhzlbty50aYJ4k5FTG?=
 =?us-ascii?Q?DGI7OC6+oF8VuqkzsQ3zEaoKyL7orybdc5lV5IbDLnJFfhJ9H7AORe5ReAK1?=
 =?us-ascii?Q?geXPSQBUooMXonxFbxyGZw5arjQJtAQvfcPZfPlFoC2F+P7Tc96d0V3u6xHF?=
 =?us-ascii?Q?0gI20a0IF3PbD9BO57xq3cJr7NGVZ+3qESi9c6zhRoIvUv6TwxTy7qQxD1Qr?=
 =?us-ascii?Q?+aZY/nSemsSQZ3RE2l5GIFZJrSzMMS+5deOBpIvgP6Pj7GNTyPJ+iB0RmUIk?=
 =?us-ascii?Q?A+Roe/uoK6ElbnToXiqLBf1p74mR3KAXjBNupK8jCv/Kp7J7NITT++mVjGno?=
 =?us-ascii?Q?Vom7wh6z6S4MYPQsWXr6eg6wA+qzXWrkkgR22cuBtnguwLWxb4Ql6j2m/lHU?=
 =?us-ascii?Q?2oUfy5gSO8xIgjW10j/XN9RpcgupiWuUyPUb5w4fHf++uxzE8KBi5DqyKtLd?=
 =?us-ascii?Q?vt0GEMwcquP7fffvxAZVpznZ3TFaW0UIdPKzwjnQConNU+pCJP06KVkKjSWy?=
 =?us-ascii?Q?ELIeEbyuwr9xG7FA+RFebCNbaiMjViaS6wbudso425PVXvT2LQZQwbAE9ZPy?=
 =?us-ascii?Q?RnDnNMdFYs23wx4bqlxGOAPJL+ERxRER0pZv6ge7/NON/+EEG3fuePpxF6RH?=
 =?us-ascii?Q?b3s+jaZqBlHpAPzVSf07H/BnThYHicejgX7YoxxvkxF5I4f9REPai2Xr81eN?=
 =?us-ascii?Q?s9tMeheNvO3tZ+l8hfa0keiE6QRxZfRrCsuo5mQohxX+lKFKl91BO31Fo+XO?=
 =?us-ascii?Q?LxRqYyibBuAy2RU2PIGaV45RBi+eEeQloxCxxXZ1I7LUH4/qmolhR2yHYRzj?=
 =?us-ascii?Q?CBHNlOxrQ2HnBLwnu7zJNexf7nwI/8VbRiztYmnI8PaWRF6lnxIMxjsSPgxm?=
 =?us-ascii?Q?6O0mSVqWGVSeKZ5pJvRiZ6/zzYwa?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(1800799015)(82310400017)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2024 07:17:25.1020 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f225770-50c5-4baf-6a2a-08dc79661093
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F3D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9443
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

Since the type of pg_flags is u32, adev->pg_flags >> 16 >> 16 is 0
regardless of the values of its operands.

So removing the operations upper_32_bits and lower_32_bits.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
Suggested-by: Tim Huang <Tim.Huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index ac0ba8b8c1aa..0e1a11b6b989 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -918,7 +918,7 @@ static ssize_t amdgpu_debugfs_gca_config_read(struct file *f, char __user *buf,
 
 	/* rev==1 */
 	config[no_regs++] = adev->rev_id;
-	config[no_regs++] = lower_32_bits(adev->pg_flags);
+	config[no_regs++] = adev->pg_flags;
 	config[no_regs++] = lower_32_bits(adev->cg_flags);
 
 	/* rev==2 */
@@ -935,7 +935,7 @@ static ssize_t amdgpu_debugfs_gca_config_read(struct file *f, char __user *buf,
 	config[no_regs++] = adev->flags & AMD_IS_APU ? 1 : 0;
 
 	/* rev==5 PG/CG flag upper 32bit */
-	config[no_regs++] = upper_32_bits(adev->pg_flags);
+	config[no_regs++] = 0;
 	config[no_regs++] = upper_32_bits(adev->cg_flags);
 
 	while (size && (*pos < no_regs * 4)) {
-- 
2.25.1

