Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1688C04FFE
	for <amd-gfx@archiver.kernel.org>; Thu,  9 May 2024 01:55:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5DF6210E33A;
	Thu,  9 May 2024 01:55:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2lpYUHmd";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2053.outbound.protection.outlook.com [40.107.220.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C494410E33A
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 May 2024 01:55:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lE3kVYWLMABKFidspfTV6ofycCo2d529kDvGAtVqA3+6ptyZS3MFStFJ3whwerazxDp+qU6lqyvHF52MhGMD2iY1kH1WmLMgTXqUrO6lYb/IH68LTrNX5ZG8lOtGavAR7pOruTRQSrXSA1iJYHoGvr92rlyNWUQ/bgg9eLwxkDhOsQ6ADuGLieo9ZzeD48C8EyDkmGKtmh42BSonNJFZ/xAHulyUGSPrzP5a5JmiRTcGsLBZAWi5rFceDxyvdYgzH8RZkWVrusqaOYVYpxVJ/lyNi2Zu98j36Ldw8sPowBHSqML0dBsEIXT73b0M1ylV8mbEjcr3gO/9vdkwWc36RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/bR3sgd0OoVrnq5KcFL5qcWIwf3i1SxCrcgOyTn5iAA=;
 b=GngHKbBqSVtEgIVByFHQMDs5ViFOnq7rVeIgUtCFw6QHU3GevV2RvFkGZYknCqrUVB5ziVGbMMyJ3rTfu2LvAx47DG+JcWJpjtUdq6h4jEKTaiV8Ls8kYl8ircieZInkY7c7GpBu+R1W7R44d93J+UfpPNq+MGzbp+X0U/0Hf6RAPNcA5ofqt88EPXvRTUlNsUB/sRyRcCPWNJH7Da1/SufyKyqbsO+wmfV1GVtTrXo++mAI/swWTSj6nUqlPYJEykuBzPjclgY6mEEQ340poaFaXy3vB/EjAPOsVmXknw66EzRYec9Lmp1PVW9MJqjhiopk/WoJUlnIm5IFiQSLEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/bR3sgd0OoVrnq5KcFL5qcWIwf3i1SxCrcgOyTn5iAA=;
 b=2lpYUHmdDsn6sWC6u4EMudFjkTZALt7TPx2GCAZ3LxzOc61xJrakVNx7rGJIkHgIp0vcIxJ/LEv7gUinvN6uCJFCSoouFWjbH0ZC56DtQ0kQHLUc/OnigSF/K/UTEZtzgteL3IiwJAwaN1/hiV0EJHPEDh6GmyZD0UClVQkkNNU=
Received: from BL1P223CA0007.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::12)
 by MW6PR12MB8913.namprd12.prod.outlook.com (2603:10b6:303:247::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.39; Thu, 9 May
 2024 01:55:41 +0000
Received: from MN1PEPF0000ECDA.namprd02.prod.outlook.com
 (2603:10b6:208:2c4:cafe::9f) by BL1P223CA0007.outlook.office365.com
 (2603:10b6:208:2c4::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42 via Frontend
 Transport; Thu, 9 May 2024 01:55:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECDA.mail.protection.outlook.com (10.167.242.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Thu, 9 May 2024 01:55:40 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 8 May
 2024 20:55:40 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mario Limonciello <mario.limonciello@amd.com>, <chiahsuan.chung@amd.com>
Subject: [PATCH] drm/amd/display: Drop pixel_clock_mhz
Date: Wed, 8 May 2024 20:55:27 -0500
Message-ID: <20240509015527.754-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECDA:EE_|MW6PR12MB8913:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f52ea41-c4a8-4940-e415-08dc6fcb2146
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|376005|82310400017|1800799015|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3UVCJRM4ZtUl1iAJp+Mp9xfPYRKh3aofIE0bYXJ0Y0x2rPvnB/JFAmwguRV1?=
 =?us-ascii?Q?EBH4SEQ3aWJ2/bZbx/KKGdentJdKacZcaoBlygdhnj+EVMm3dCpQ5NsAUZS/?=
 =?us-ascii?Q?eXRAtwWfpC5XV0l58lrO9zc8c4Vi2G6cq6/PWO3VqgVoU6PFWi9ZkQ+kgvSs?=
 =?us-ascii?Q?2aFhAAG5Or6sy0GnuiPyWSum4PfMJneDfTGlM/UrgvNCYViIOVhwJ4LDot5b?=
 =?us-ascii?Q?8eTxe3eHQKyYkvGuytIlOX5bFDdSJ4K7+Wg+vC1zAFkeuSmstU0F72hIf3cu?=
 =?us-ascii?Q?xgLNtUDpOHUWPJhxH8MlI9w+ONxlZXMBjzpB9ewHSpToTkJj/kJM+UWMVojL?=
 =?us-ascii?Q?Au0f8Zs+Dyo3Z9DsXwSd/34i4LZ7iD1MMR/oesbI1q5rgendx3Pc2utdrSoZ?=
 =?us-ascii?Q?O7uRJmCb+od2ULPi0GwU7/aswLBKtybJHNrevYN/MozrsSzBl1Hyxb4o5y5f?=
 =?us-ascii?Q?DZHwVVm/wTwiBL+2lhgx4G1mwGZxVizn7Mg1veEqVyDUg9TYnkOE036CLFpQ?=
 =?us-ascii?Q?N1jv2pw22T8hAWFiRX0r76aQmvz1tvcE+xp1xndVOgkjYK2uqIn6FBkoAp9/?=
 =?us-ascii?Q?shyxOaMV/vDp/7T6+GlFwjfqmXS/Ni27pmGNdW24goRJTfixu0zwWmgedX+b?=
 =?us-ascii?Q?N0e6Y7IvK7tMAOPIGK3hO5/5r0EYM8XVzSZwx+x/iM7Vm/MVpYd9OGpJuJxW?=
 =?us-ascii?Q?PVIaP3UdhpdtrcYCe8U5jcq2tVfS08m6QxwN2QATCO/nfOGl4beF4ZYKQAo2?=
 =?us-ascii?Q?y+FPIIEz8iBrPvI0YofkfLymGFOVK09hYs8KbWchYOLdxBOQlZ5uysEkHh6H?=
 =?us-ascii?Q?FuSJPig92ZoRbY5dJDyQOG39o6Tl4DR2sAqLb8arg3d26Gur/fzFLJdoUkCp?=
 =?us-ascii?Q?WfcMye1avOSaNqINxCGASjbv3ZRImqhncyATeAWYoDLeBXC9O1Jn3qS07YWc?=
 =?us-ascii?Q?4HuJVAg0MTWDdEDtq9L/060KrxTcBYy0LG/aTBspWIOtbmNqdwelO4RiDhJK?=
 =?us-ascii?Q?0yq/5Ynh/apTq+r7ThwDBudBRt76Wt1sHYQcZmSXZ3WdIYyY3Hpt61aDQU5t?=
 =?us-ascii?Q?zi79UT/cneZAkk6ZgiAUGXOe+RXBeFtEDFKY/9sxIIU3+LM1Y/WiIU+/yaV4?=
 =?us-ascii?Q?AnliKB4tEc58hISR9hjv+60xgRZAi31sqfwWv7iPOTDT6nPU7aL+hXjwJwVi?=
 =?us-ascii?Q?oNwqkZx/9HC1iKBMaY49lsKERFDB10bh+5i2yg4UcPhd+3pUBTW3FUE7UNTK?=
 =?us-ascii?Q?pZNoxHfvBttS/zLNT97VzcxkrxPZ9SpugNl1EwaZoTk19qerllMqvkwL6bBx?=
 =?us-ascii?Q?e58BZyb0mnrJU1Ung7870EbOiddmbUZzqXBc6Eac1pQP+nPxG//dY06mIjGv?=
 =?us-ascii?Q?cfi5TY3z3DuVM/V5PUI/NdNhUpmP?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(82310400017)(1800799015)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2024 01:55:40.6637 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f52ea41-c4a8-4940-e415-08dc6fcb2146
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECDA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8913
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

The pixel_clock_mhz property is populated in amdgpu_dm when Freesync is setup,
but it is not used anywhere in amdgpu_dm. Remove the dead code.

Cc: chiahsuan.chung@amd.com
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 ---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h | 1 -
 2 files changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index f80213b7e9f7..3054bf79fc99 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -11274,7 +11274,6 @@ void amdgpu_dm_update_freesync_caps(struct drm_connector *connector,
 
 		amdgpu_dm_connector->min_vfreq = 0;
 		amdgpu_dm_connector->max_vfreq = 0;
-		amdgpu_dm_connector->pixel_clock_mhz = 0;
 		connector->display_info.monitor_range.min_vfreq = 0;
 		connector->display_info.monitor_range.max_vfreq = 0;
 		freesync_capable = false;
@@ -11338,8 +11337,6 @@ void amdgpu_dm_update_freesync_caps(struct drm_connector *connector,
 					connector->display_info.monitor_range.min_vfreq;
 				amdgpu_dm_connector->max_vfreq =
 					connector->display_info.monitor_range.max_vfreq;
-				amdgpu_dm_connector->pixel_clock_mhz =
-					range->pixel_clock_mhz * 10;
 
 				break;
 			}
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index 09519b7abf67..67647bb5999b 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -678,7 +678,6 @@ struct amdgpu_dm_connector {
 	 * value is set to zero when there is no FreeSync support.
 	 */
 	int max_vfreq ;
-	int pixel_clock_mhz;
 
 	/* Audio instance - protected by audio_lock. */
 	int audio_inst;
-- 
2.43.0

