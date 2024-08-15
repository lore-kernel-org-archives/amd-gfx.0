Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46E2CC531DE
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Aug 2024 22:46:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED63A10E553;
	Thu, 15 Aug 2024 22:46:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4HDAJVjw";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2064.outbound.protection.outlook.com [40.107.94.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 960F510E551
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Aug 2024 22:46:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S1+PDtbBuURVPi/z/XPfYVEDe5F7uMZm0/5kkM4Inkz4Yq6UycWgmjA9DBea5/4XJninURFxU+0j2qZUFh19m0RW2QWi1S41kCd5BquqPPZWJ2wyEXc65207b84BE46kzq/h3iwc9HNGxravuvw73NfPq4hmlFYHNuPFrxqoy+q3BpR4XSDHPXnQztApbwtxAGG1OSffuhQ5skuoHM7vMK8kAyKou4xmTi1KNEAkJEnnUu0xI1qdH1CpVbE0h0kmuzTtVkCkgLh99HOAGXGA8LqNSoEUNCh3SvyHBXjWGUZeLxxoLXDK/xp7vWYVXBP6/7tHAqlRlG5phWv+q1Hj+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vwvjUPDYuICO/W8yEhK/AZ3jPpivyeKr3kXXg+ibch8=;
 b=GJPbd9/g/w/XkWCPBUHzWaJ6MvWvCH2Mj8/vFo9MFgpRGmhTdMV9i+LZG6sIuiTzyx/NcnhtH4MFFmb7aiMTC99rzH66Q6+Qd2EP42S23qaHeRReWQx88hH7kwirJQCXi+gpU/d9+cBgzQcdO3PuSMAGVdF2p0Puk2K/OFNLmQPeOIeT4bHXIPs1qaIB5uCMBhqZVf0LA6stgThJaM1SmU50Lgj5UerG6+Ox5VLM8oAzK00FUDsnzVZum2+hMOxZFWoRCnTY51hggqTDSt6GUOaOJIE6TJNNDvOwgWvmUiPlIj0K8SN1NM52PpfiDC2a6GjMuSuQX3KBDX1YQr715w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vwvjUPDYuICO/W8yEhK/AZ3jPpivyeKr3kXXg+ibch8=;
 b=4HDAJVjwE6F8oah0kGMd9Tfy2/bSOT27m+qhmJ3tmyQNv1bCHbvCIKtXdoVOW6kIYxZBTNKmQx4qTgIPCYTFmRyIpeKFDJ576iiMWOdgq0ZbpN91XZ3ltx198zKs4nRPbh7EkyEFM7er/xG4SYcVZdui7OOfseFrmCe+6j3S3Vc=
Received: from BN0PR03CA0045.namprd03.prod.outlook.com (2603:10b6:408:e7::20)
 by SJ0PR12MB7008.namprd12.prod.outlook.com (2603:10b6:a03:486::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.18; Thu, 15 Aug
 2024 22:46:26 +0000
Received: from BN3PEPF0000B074.namprd04.prod.outlook.com
 (2603:10b6:408:e7:cafe::c3) by BN0PR03CA0045.outlook.office365.com
 (2603:10b6:408:e7::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.33 via Frontend
 Transport; Thu, 15 Aug 2024 22:46:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B074.mail.protection.outlook.com (10.167.243.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Thu, 15 Aug 2024 22:46:26 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 15 Aug
 2024 17:45:56 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 15 Aug 2024 17:45:55 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, <zaeem.mohamed@amd.com>, Martin Leung
 <Martin.Leung@amd.com>
Subject: [PATCH 13/13] drm/amd/display: Promote DC to 3.2.297
Date: Thu, 15 Aug 2024 18:45:25 -0400
Message-ID: <20240815224525.3077505-14-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240815224525.3077505-1-Roman.Li@amd.com>
References: <20240815224525.3077505-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Roman.Li@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B074:EE_|SJ0PR12MB7008:EE_
X-MS-Office365-Filtering-Correlation-Id: b28baa5f-3d20-4bda-7eab-08dcbd7c18a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Hgm4XMYiOQ6ejWv88OlcajLYEztcsAcZRjVBzDPoRuls2a3aEfu3lj3XE9gK?=
 =?us-ascii?Q?wAcuiAgz3v5iEUnRWwTVFjQbRpR9cU2vUJuGzWlV1kI6U6iE06x5G1EUQIcj?=
 =?us-ascii?Q?ms9DTvuz0UU4Xf9ak7XuSwHgY3sHJwU83DU+eTVtScwcXhWbKi4i2VgSyhra?=
 =?us-ascii?Q?Y8uyiP+2wkGkxA9B53y2wUfQGgG8sNeD2vMB5Qp4NdQml5diCF3AP4cXpiZ9?=
 =?us-ascii?Q?mPjbRBewculoxuYPh/EJyJbofe6Xz8blSOItoe2xcx3vcK3OeMMvDTt1gskb?=
 =?us-ascii?Q?MhzInG19fY8WO82TFo8QuJN3sB5pBcBJeOTF2EcxwU5zhW4Pr3yN1KdGjNkv?=
 =?us-ascii?Q?nSXTj4jemSRgjjwr/W9RF8KkPPH+LTS27mN89ugSqHYHB6KXGChQeL5eaXWn?=
 =?us-ascii?Q?Y1BQ/5iVYwOw4/VFlYMZo94TH79TLwgC4hpDvH3tL6kGg1QrNieeJ68++k5D?=
 =?us-ascii?Q?d1aNKhMAfnYLCn41oFfDey0EuRzDlHUwB7LJvsqYUW2iuMCWD28VhkWb1iNv?=
 =?us-ascii?Q?X+5KaToeeYr7vnbcXj5I3oa5qeU9CWMwq+B+oSgjC3UF/3LCVFG+mykZTHPY?=
 =?us-ascii?Q?J9OzAzspWVip0ORhEBpAFcAL8ArwU9uU3YZRokjJ3MFbWtvb8jmjLJHEql4m?=
 =?us-ascii?Q?vo1/WnRQcK0W+wNe353Gde8G2MY1GTh6hoGpw+yYlujNxItKbzSqFt53+ygm?=
 =?us-ascii?Q?/xbYrSJp4jSR1PJWJDmPmz3qUFwxizmLGlsb5pDJzvXDGs1ySU/1tTE+1vTq?=
 =?us-ascii?Q?/Om5bMIT9hJ/r014evCABqz3JQAbhkMohM4PR1FyWMyhvGFfUzih1drb365n?=
 =?us-ascii?Q?laNRq+PeBiSJns/GlVBqZDUoAZnvkfo6+oir2TZBKv+4m1UZrjYvPjyN8Oh1?=
 =?us-ascii?Q?Y7J/g5mPU2IF/j3dOq1Z1cZSg6S/AjFGIgyo8672JBV+iXFX6bDXB3WHn+N9?=
 =?us-ascii?Q?+5BffJd53MjdDLhdpp3XRMEmorUy/CS4amjzg1Z6arUcU96xnUN2UHIXXYnv?=
 =?us-ascii?Q?bX6A8Rs81kxeJwkFR2tawoSE0GTA7E945iTWmjQ/xbmuJ3tUjn0g41mZRhF+?=
 =?us-ascii?Q?yuwEnuYp42gr56gowV2YOMfx+H8OodOZvoP/ewqBcV0Z1SCEhgi2rNHUz9op?=
 =?us-ascii?Q?bP1zn1qVx4pFjPgqgoY08nVBTEZHaQN3gMRIP3w1EgD+Ad1De+lYKd14VAcu?=
 =?us-ascii?Q?GatFRV86pB/Eo1rVzp/cPNSC4t7iwn+0uObswyIrghWiUhERFvUvPTiwYWOB?=
 =?us-ascii?Q?xp1i3tEgwY+BXjvXYFcDQ9/DDkK1PeQZLxXCvGmZG4C5MClZWB3WPsnpKMI9?=
 =?us-ascii?Q?ybNteQCB6bfiRCc4WOU1RMUsBAhXk3a6d273hSv7CCue6BrtiYQsq8TM523O?=
 =?us-ascii?Q?R1miMzqRcXA5kv8jS/n5a/fUZYgaWXna9LYy795lCL6AWYGz3O86cdsKJ+PU?=
 =?us-ascii?Q?R2zdTJ7U7XHSwvHmdr1s5PV3Ie4j+nHO?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2024 22:46:26.6342 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b28baa5f-3d20-4bda-7eab-08dcbd7c18a9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B074.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7008
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

From: Martin Leung <Martin.Leung@amd.com>

- Various DML 2.1 fixes
- Fix MST Regression
- Fix module unload
- Fix construct_phy with MXM connector
- Support UHBR10 link rate on eDP
- Revert updated DCCG wrappers

Signed-off-by: Martin Leung <Martin.Leung@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 3de311533571..5bbc7d2daca6 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -55,7 +55,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.296"
+#define DC_VER "3.2.297"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.34.1

