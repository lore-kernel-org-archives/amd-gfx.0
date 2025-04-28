Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3C6DC369DC
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Apr 2025 13:56:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A9A210E561;
	Mon, 28 Apr 2025 13:56:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GZDCtSJ+";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2055.outbound.protection.outlook.com [40.107.244.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D99EF10E561
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Apr 2025 13:56:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oyqwheRJWlvONJLNwIiSd0U1qzR17NEwaJHFbR9MjeJUELFy9byr7JhFEtt0mkymBXuS3bba7DeKXpsdwNY03CDL6ivB4TIwD3kRJwT7cJRFvIzzuLO+nhgwMYStEAw3XpdMhJqByoSUkkJspICoVYDBOwwWYFLdhu07WhLMixVYPlVhEc53XUnKARzGiIxXM4L3AmgoWNN3ADc9dgEhjt0+CoBVo4O+GGLqo39UOFbdzHvOH80uuOYFRpicsdId+mB1GNqcGzvdxo8QJyc1WsZhGZ7nxn9IVnXTbKasrv23itOGGtLpDYWXn3DvFn1AtNzVFCJowv6sc1VUWUYn3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=86nqX6LNuIzrKoKpVQZX0LTOWkT/6g6xi5DpR67iUlg=;
 b=jwhaOUj3xKzh/84laihYr/dnxgISMrT6kU3xWLS+Duyt/tqLmUU7vIUcxm0PL5KXyeOzKpkp9FwJKRzQnsgm12oapWmMugeKcm7b0io5ETzclyWw3CT+vnm7jGtF5POsi/jNWRQnrjyhtIA7I+XkAnK6yuH5THmp8/jiDZnpvLsS0xIuyxji2u7u7EzZMhjh65KqVyqNyKISFTr482iqJPPyQDgoIxnTtYx8+nG8gpAGq/yqIaPhF/a1zOeo5B8M6prnW5BZfvLYPkr6JbMcACfEjhSbsuMOQFnd4+lB83Y1U38+J9ogCLRtXMLWwY+CMKooaNPnPNLvIU8TmLk/QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=86nqX6LNuIzrKoKpVQZX0LTOWkT/6g6xi5DpR67iUlg=;
 b=GZDCtSJ+7yp8stytHxcVG2PktCxl2o2Ana7zFbiv3fbWc4VupkkC7VweHN/GtPFEsTYuFkiAnGY/pUu8i7tlx15PBqjDvDR/uV7hFGu98lWn/wSkPJkZp8S0zyh5HK4eOFlj0hTCP8LIaXNZVWAytNJvBj5y9Wm6bO2Lt2YZXyU=
Received: from CH0PR03CA0273.namprd03.prod.outlook.com (2603:10b6:610:e6::8)
 by SJ2PR12MB8807.namprd12.prod.outlook.com (2603:10b6:a03:4d0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.34; Mon, 28 Apr
 2025 13:56:42 +0000
Received: from CH3PEPF0000000D.namprd04.prod.outlook.com
 (2603:10b6:610:e6:cafe::2) by CH0PR03CA0273.outlook.office365.com
 (2603:10b6:610:e6::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.36 via Frontend Transport; Mon,
 28 Apr 2025 13:56:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH3PEPF0000000D.mail.protection.outlook.com (10.167.244.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8678.33 via Frontend Transport; Mon, 28 Apr 2025 13:56:42 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 28 Apr
 2025 08:56:41 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 28 Apr
 2025 08:56:41 -0500
Received: from ray-Ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 28 Apr 2025 08:56:38 -0500
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, "Daniel
 Wheeler" <daniel.wheeler@amd.com>, Alex Hung <alex.hung@amd.com>, Ray Wu
 <ray.wu@amd.com>
Subject: [PATCH 14/28] drm/amd/display: Allow 0 dtbclk for DCN35 and above
Date: Mon, 28 Apr 2025 21:50:44 +0800
Message-ID: <20250428135514.20775-15-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250428135514.20775-1-ray.wu@amd.com>
References: <20250428135514.20775-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000D:EE_|SJ2PR12MB8807:EE_
X-MS-Office365-Filtering-Correlation-Id: 69dc0fa0-64e8-4417-0183-08dd865c8159
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Y1EnPwATG2ki7cHsVxMKPCw+vJQSMAlHiE4vUNHW3AXDJVd4pO9GL91xmqU4?=
 =?us-ascii?Q?i3sEbJPAJGQpFKl8m948bNLjMxgCMUJ5TqzDiDr+qTK9ep3lKTNLZqEjZ6kq?=
 =?us-ascii?Q?zY+2uK4yGoUjULaNPrXr2QznYjHSE7IXbfFwOc2YpptteO0o5wlZ5K1nXe0l?=
 =?us-ascii?Q?iRovcpmOXZskKkJvuOdlMvM6ZLO4oMzMrBMIqSZuJeByWstOuEsyK18Bin/y?=
 =?us-ascii?Q?w91UnqGcptftwdlRDyHt8sUkzQAC34SEYkzYD2y6ora+0gb2hlHAoxNK7rR/?=
 =?us-ascii?Q?HTykiONqpW/wT3sBXHzlaWsDMlBjZzw0VMrQx2GOF938TDbIvZTNA/Nviagb?=
 =?us-ascii?Q?JI2Mk+4Zb3ipXk5dPGCWJIWRglpV80UuEcRP1HXAvuaonZ/Zrx0S88+4CS9I?=
 =?us-ascii?Q?oaL5P8Poyf7A/f2f9WXebuovBWqlxJ12Ra/GM+yvN0v2/oh33NMDyOWOWsSp?=
 =?us-ascii?Q?vs8B6WsC8iclA1NLGkVUazAyD48pfmi+bITJPDuldjyqrAbijldmCeefmjKq?=
 =?us-ascii?Q?OqACcI9E0nf6AcIio9HhwGraNrG6+lq37H8D6B2/KaILtPClTgeDDPYDVsXF?=
 =?us-ascii?Q?6MZmMNnRFx+Z59XiC63izMIOQORWf+eL1Qzyu+FEcwnhtknwsQnzFOWuln8p?=
 =?us-ascii?Q?K23iQaqV6JcaIo4LurTmU7BhZdbNl52lRdg++7Xpfttxte6k0GTf+GCkuzV1?=
 =?us-ascii?Q?k1rxvJ30ulV77deovXfkaDt6oQLKumLbgty64FncOokk7VkywgDuRjt7k+hM?=
 =?us-ascii?Q?qK+1jSlSxzvBdfJ4OC6HMi9pBAnzlCPdN9v5AXYy6ME96jeG50lI1vjxm5X9?=
 =?us-ascii?Q?xWelChuNdF4DaSvBaRLbIOXqGrYhZi3XtNEE3h+6mIpf8ZGkrWUR/9zx2FqE?=
 =?us-ascii?Q?8tWhPMHTgk9xHs2KLIkIyZIbb7UfOIWHMoeweMi/1CSSTAbLqtvcE0CoqBL7?=
 =?us-ascii?Q?DcPEaoH/e6hkfv6o8kxSfsJ89vbWRawbmos1E/hSuuY5GS2r57po3lV7EiwW?=
 =?us-ascii?Q?Y6I4r+lNW9cyDh/+9/ytmoY0KQHSQF7AsVOmrIFhUwAj1LzvNNuADzeoq+6S?=
 =?us-ascii?Q?69mIEY91/TRuAD5TA1u+HZ7Q/w/jZigIra15pWU1QkS41pLevFAoUArKybky?=
 =?us-ascii?Q?KiOwLHhP0kHRqGRSpxJnFRtG8yohw6GKKSmeU023K1/MFVmtDFQHGzPczYY4?=
 =?us-ascii?Q?Gn++0T+xp2WVKFLnpypBiepIS0yGoY7FO8WzA26AWmct5An/OtK+MWukZVj9?=
 =?us-ascii?Q?OWRuJk8zS7dX2l8wXCC/gbeMG6EEaZiG79j/5z9OVyGlBjy8964/x4oSC1oU?=
 =?us-ascii?Q?xNApQ+lp8hO/LROBCAfv/XnLhtZ+Xubxf1fo6mJP2qF9xov5euoFp1uZZzob?=
 =?us-ascii?Q?n+fyfHa8b1oGJ32jay8fsws48EfIwvbOndwrQtuy0PXW9kTy0WWZxlHfeWFX?=
 =?us-ascii?Q?V/xDTwtuTAeNQBmXatjGWKU/G3zezWxxlh1bAJNIsgjFlWp1CzkAGSUxgJ1l?=
 =?us-ascii?Q?da6k0xz56Jmcz7IJSP0ZkJOu3sThYdxJAFnY?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 13:56:42.1054 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69dc0fa0-64e8-4417-0183-08dd865c8159
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8807
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

From: Leo Li <sunpeng.li@amd.com>

[Why & How]

0 dtbclk is supported by ASICs with DCN35 and above, so allow it during
driver init.

Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Leo Li <sunpeng.li@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index bd71f911e279..cd6e7aa91040 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2106,6 +2106,10 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 
 	init_data.flags.disable_ips_in_vpb = 0;
 
+	/* DCN35 and above supports dtb clk disable */
+	if (amdgpu_ip_version(adev, DCE_HWIP, 0) >= IP_VERSION(3, 5, 0))
+		init_data.flags.allow_0_dtb_clk = true;
+
 	/* Enable DWB for tested platforms only */
 	if (amdgpu_ip_version(adev, DCE_HWIP, 0) >= IP_VERSION(3, 0, 0))
 		init_data.num_virtual_links = 1;
-- 
2.43.0

