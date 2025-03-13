Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D484C28B28
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Mar 2025 01:40:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F117610E00C;
	Thu, 13 Mar 2025 01:39:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mkugUuHO";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2043.outbound.protection.outlook.com [40.107.94.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3687810E00C
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Mar 2025 01:39:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uiUTYfCOHIXDIYs+i6R1B7JhCVWmqguMbne6bjvHFQ+/TToDFnUxdlW9CHzO0CtuLpMyi5oIDQEvWD03e6A+h5HPRMcsgWExrfAA0cDvlcfCN+ci7FMR0zoqJdH5hd1uqiXZkDDk/oG3QMF+YUVJjvaVQzdSeZi2MieGQd2jUL4sJ/Akn71Lk5PdJUQqfW9zO4ycnvaRrUsLgfD+BXQ83oJ0+QY4TromBeHEMn58dhIdYQ0O/BTbpKSKkHomiMpApNeoYnQNtlgK+zWq6mZ+3ft/yrk5ui4fCTbAcRNk76lmZAQTfr6AjcsxoqCUKDFkob+moKErF6aVtPgNTdgxtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XeSlNPo3iWauHlYdE0xOdqcBGmDQ0Co2rJwSkVyXJz4=;
 b=AucA7+ahbv3T8mwYP7mzOEecchEkNAFSA/VwUACv0EcumoC4tBQq+vFRAg/aT+kx2iP0p2llPI0TPPuJz/mx6h5pSqd1I0pG35FAL7JD4vMVSGBdedD1QwBBq+/uaQJtMZg7IcHTdXudhIKAJPhq62tgpHKlemJbuNR2hLhVdA1jeEupT/T4R7nu8QaCHaDgCtro0xavLAum3UM/+hhQhSLDFM7lf+mB87TkUnvqxHlh0uXhncz8A7n5EvHgdq2TuQD3/dQx416VXAIjXPB0+RJuzqGkQSkudNHjKGikUpL+K0QbTStP61P580ZhLAfUEvroklEPK4fDy0lwCyqZ/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XeSlNPo3iWauHlYdE0xOdqcBGmDQ0Co2rJwSkVyXJz4=;
 b=mkugUuHOISIglOPPyQ2FC5IEMgAsaxd1WfFHB51v4hM1zN/5/aqg1rUIMWCtCjnN891duywJ8IEq0U2OHp63/NoP9ATK2x3bLCjYXVqhxF0PIjCJzdKBU0S91hTIVkPsJIFGyjTP6cmCM+yPlbaTtb0CM3BXOeSMp4DY4pLrrDQ=
Received: from MN2PR22CA0025.namprd22.prod.outlook.com (2603:10b6:208:238::30)
 by DM3PR12MB9349.namprd12.prod.outlook.com (2603:10b6:0:49::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Thu, 13 Mar
 2025 01:39:42 +0000
Received: from BL6PEPF0001AB57.namprd02.prod.outlook.com
 (2603:10b6:208:238:cafe::7f) by MN2PR22CA0025.outlook.office365.com
 (2603:10b6:208:238::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.24 via Frontend Transport; Thu,
 13 Mar 2025 01:39:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB57.mail.protection.outlook.com (10.167.241.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Thu, 13 Mar 2025 01:39:41 +0000
Received: from amberlin-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 12 Mar
 2025 20:39:41 -0500
From: Amber Lin <Amber.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harish.Kasiviswanathan@amd.com>, Amber Lin <Amber.Lin@amd.com>
Subject: [PATCH] drm/amdkfd: Correct F8_MODE for gfx950
Date: Wed, 12 Mar 2025 21:39:21 -0400
Message-ID: <20250313013921.63647-1-Amber.Lin@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB57:EE_|DM3PR12MB9349:EE_
X-MS-Office365-Filtering-Correlation-Id: 537371dd-b390-49b6-17ea-08dd61cfed10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?76bdxECT+DBJzPr3J8fMpjheTAbAu9wY3V9zsLrZV1er4M4AbuzXfj6NDoSF?=
 =?us-ascii?Q?fO+iJzso7oB9motZmk4AQMWmolJLGrMWZK2w8w1II4tDT1uNaOJPxNOASiTe?=
 =?us-ascii?Q?OQH611x+6kUJ3/vhRZ8PfVc6MFwTsDGwqMf5kheWS3ixIi4UbCBmxH8NaQdd?=
 =?us-ascii?Q?ieK5rldtf/J0gXTvsMh6liJ2jMdjJDxh2eGjJZrmDpl4z/MFGxN+/d763BbN?=
 =?us-ascii?Q?7gr9VeWudDOZ4/E2a6KrmdAeLXka4bV4PzE0NxVHcEhO5Df+cX70rLjWcDSQ?=
 =?us-ascii?Q?S2iWRXqDMCW5hFCVjIHxRO0IaRZDfQcbQB5xmFBG/i778JBlgBHf82xqNEhW?=
 =?us-ascii?Q?HmL29fOT94+LG217trikFx4t2d69LtTXc90U5zPrLqedvNeIboATBHEZl+qj?=
 =?us-ascii?Q?M/VpMB0567r4zziytw7/gMehJV8eFZQnuSMsO4skHUCCcBH9uGDVlvJgwXdX?=
 =?us-ascii?Q?utwCuRPrarbbOGtQSS3lw/tBdLDy2OO8O815O/PynyMYssCiS8fCzA4GCKqG?=
 =?us-ascii?Q?5W6rX6uhA+utXKEsMFeJW3Q2us+aF//xAKVxVcj0DVvRPqBA4q3xwmxA32EH?=
 =?us-ascii?Q?cpnBNXOrnWdlWzl1spjJcZRFhgAnT4/sGzD0CagOjw88tkoUq7DEHhhLCkrh?=
 =?us-ascii?Q?AH6x1xjbmHYTwjozoTifu3oOHLO9C09cW4l/PrDuaogT5fEDzFeOEpR04p0D?=
 =?us-ascii?Q?1svXLlfiq5rsXtusLSeByIPRaLt9iHI0xF8xJjlqdmiSSKPlrcX5OTmIZxZu?=
 =?us-ascii?Q?h66d1gEWGfqFNUbhCFia49kSSU0Djkf94lGptPCY4xswvJ/jO3UGF7aYy+Ww?=
 =?us-ascii?Q?QIrbIcxvMrlqGb9R5gNWQHkhqYG1UMfVB1GhieSB1JB8GyFmu/H4A4WSd5C+?=
 =?us-ascii?Q?2bYCyLgIB6uj3xC3cmytybYE8oyX8YvfZ50hW+4p+RAyfCKn4UqnPV88FrkF?=
 =?us-ascii?Q?N1W8ZXwvoTclFv4wQn0Wm2gHS7jz0mZnmpN0+zmMfn9wWzDeVX5e1UR3uDw1?=
 =?us-ascii?Q?SjJZsH2ATE8rXeHWSpcCPSy6+JK8c+Yc+cfvEh+cakJSEvOzZA21ujqCXtOu?=
 =?us-ascii?Q?LPzrx5Pnq0QQmKH7M6tSgGLvG735rJCQT58zqci+9FLblRW4rr7cYwKYHABh?=
 =?us-ascii?Q?nCLNzz7/fSXYv2qAx4kxNomC4K58fxIZBJeGj8wC8jZJ4IIzZ2Nf6Jn0OXxZ?=
 =?us-ascii?Q?U/ufmRIDYTS98CQ88KmHuLWUjYrA7xmGKhAgVENttWjhJbmVWvKGp7SEunCV?=
 =?us-ascii?Q?C0tqQbPhDUybyrZynV47MKzBoorEhyYfPxP5XXMhvpYkle5TmyLJhBKqyNS5?=
 =?us-ascii?Q?ZXl8HGZ6SI7wVNc7VPDEE2p4Ftbu9w0vQxPhAszrQw9xvj0qUmGvnIJxUR8p?=
 =?us-ascii?Q?7Ip1f/+77Kpm5z2Sdk+lXrzlKoWqdnANzi99yLDuGBIZWHTkW/GQtU5hp7H1?=
 =?us-ascii?Q?fOwuYcpXofxEOhA3ddNsazvhfWiL7ChIJp7pKd6RqQBtOnOmXw4Hpg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 01:39:41.9389 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 537371dd-b390-49b6-17ea-08dd61cfed10
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB57.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9349
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

Correct F8_MODE setting for gfx950 that was removed

Fixes: 1a9dbc31d234

Signed-off-by: Amber Lin <Amber.Lin@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v9.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v9.c
index d794c8172b40..9fcc8c6e57b7 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v9.c
@@ -71,8 +71,7 @@ static bool set_cache_memory_policy_v9(struct device_queue_manager *dqm,
 		qpd->sh_mem_config |= 1 << SH_MEM_CONFIG__RETRY_DISABLE__SHIFT;
 
 	if (KFD_GC_VERSION(dqm->dev->kfd) == IP_VERSION(9, 4, 3) ||
-		KFD_GC_VERSION(dqm->dev->kfd) == IP_VERSION(9, 4, 4) ||
-		KFD_GC_VERSION(dqm->dev->kfd) == IP_VERSION(9, 5, 0))
+		KFD_GC_VERSION(dqm->dev->kfd) == IP_VERSION(9, 4, 4))
 		qpd->sh_mem_config |= (1 << SH_MEM_CONFIG__F8_MODE__SHIFT);
 
 	if (KFD_GC_VERSION(dqm->dev->kfd) == IP_VERSION(9, 5, 0)) {
-- 
2.34.1

