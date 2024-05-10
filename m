Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F113C25B10
	for <amd-gfx@archiver.kernel.org>; Fri, 10 May 2024 07:07:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 95FD610E198;
	Fri, 10 May 2024 07:07:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4YZA2pu3";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2070.outbound.protection.outlook.com [40.107.244.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2795310E198
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 May 2024 07:07:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EnbWpq6eWhpqzmWB7oiokBEEELZznmQWZRacN/1YJVsDyJeBMhSQ4QW3wCLpvPPGr0C5p5L62ospRX/ucJmdjTdX2A5zReUawkA5B1iAxPjcLgSiisCxaKM8t5S7TPppetb61CwV80zI9BKUSdz2NM0tzTVPl6XUMCts600p37XrpHNNS9J98GeWbMj11kIvTb0hFyh3xMIzffIki5z5ede6B+0/NfAwW1vtHiuj6/M4cZ252RRgMTC9QQwngOtSN4Ux+M1wPSHk9XrzvIVXCt6USMMuuEv19quvfkFkQm+memHHMOpewFH2dmLpJyX1qY/YCG68LBdVDWyeNrzzPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5IN7G5kejr8BKeHsRFTjifdt/SxKZzs+n/EPpOcmNBw=;
 b=Tu9abdoETx0F7Php6DA2BKT6ge7AotrTLJBdsIv5rcC7dDTnIz03PKhamFKV/uJQO1nuzjTdUaC5NTKv7gcyLOYGcEMcGNY1EHMJ6BBk9aCorj5FGxNquNv2hDj1cCDu/S6zqvMmBnpI5lKEugKLS9+402bQ4DN26/9aSr7ik9OgTAdb3gIuikUik9Op1AAjezHp46SHzVwp773lwbovQhK94C1AHLpDDvvxKroYnT0tLW9q04MUTBz7IPj/CxZ3rkEahXbD/+PyN0BrYRNsqD1aHVHgK7tu+cLXQsV1zhTam6iyfRA3radHJzN28GsnlDWC1wL/4oChoCdiuDsQ0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5IN7G5kejr8BKeHsRFTjifdt/SxKZzs+n/EPpOcmNBw=;
 b=4YZA2pu3rq8ReNHrWUln9ZSAYpRaKIy1GC9yv9OnCS6ArIpYcQzrxofct+4jnvFpVElIHIXt/2a/BpEwAFh4TD+lSWRi42e4kQYi9LQLxEnEu3EXRvaw0JeToKUc1FELSY7O9nqvAc8gB7iFm+/P/M3eN0VfwPP9VgF4ys2q0Zw=
Received: from CY5PR16CA0003.namprd16.prod.outlook.com (2603:10b6:930:10::7)
 by DM4PR12MB6040.namprd12.prod.outlook.com (2603:10b6:8:af::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.49; Fri, 10 May
 2024 07:07:34 +0000
Received: from CY4PEPF0000FCC3.namprd03.prod.outlook.com
 (2603:10b6:930:10:cafe::63) by CY5PR16CA0003.outlook.office365.com
 (2603:10b6:930:10::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.51 via Frontend
 Transport; Fri, 10 May 2024 07:07:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000FCC3.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Fri, 10 May 2024 07:07:34 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 10 May
 2024 02:07:32 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Fri, 10 May 2024 02:07:26 -0500
From: Jesse Zhang <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <Tim.Huang@amd.com>, Jesse Zhang <jesse.zhang@amd.com>, Jesse Zhang
 <Jesse.Zhang@amd.com>
Subject: [PATCH 09/22 V2] drm/amd/pm: check specific index for smu13
Date: Fri, 10 May 2024 15:07:17 +0800
Message-ID: <20240510070717.3496839-1-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC3:EE_|DM4PR12MB6040:EE_
X-MS-Office365-Filtering-Correlation-Id: edc7f10b-058f-4946-9b13-08dc70bfddeb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|376005|1800799015|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?G/7qz5WHGUt0wRqobMhvn4JPQNIOA9HlJ44LAtmvvZIabP3LiYzlkzC2YKR+?=
 =?us-ascii?Q?/GPafUUdi/uDhKcboqBErAmWjK6DJubeLAWE71ticwMsAhnxh3R9aiLgxgwH?=
 =?us-ascii?Q?YpveHEGpJ+1A3EpNl2NxYIrDN04tUq9b6Ag9A/eAYuE0abxtb0smDZwtU8js?=
 =?us-ascii?Q?cYoPfqNgs+hnra0E6wftiq2XCuk1Zw4erap0YYwcppmLBGXLQdK4vf8X9wD3?=
 =?us-ascii?Q?8iSvZE2kLcm11grU2l6jbGbaIafOl932oCFvko6Pj8afYfCX5zss0Gx8ZlP1?=
 =?us-ascii?Q?dWQFVPsEzImiQpk5He02EH21tF19OWoOr538JcNZfCc9sWlMLGGrYs6g+CII?=
 =?us-ascii?Q?EhDgy4BG8A+uxaI/7KtkWLbXaLU+3L3L0OOXwVyYd2iVrnkukhHDIJj1TD/d?=
 =?us-ascii?Q?yn3Nf3EIH9d8mkdTGnuP6v0+qCFSDzL4CTbJm2W/34j4gVeVriBW1ERGnbqw?=
 =?us-ascii?Q?g+ymgl+s6E0Vx62gHYDDmEIxk22sKhawA/jLPkfxurOW4BFQxoQt6S61SKam?=
 =?us-ascii?Q?4dNYUVAKmkWTwztWhMSk7M3ky0mx96bi5C5jtuwi+SjRcHXaOgpCmxPiX+rS?=
 =?us-ascii?Q?8g2CPqF/D0LsOnXTZVJaNMG3cQRV1LpsvWcHcW4sRc2RXvt1JVwO/wymovOn?=
 =?us-ascii?Q?fVzdEmSzacNW3KTwNiNAilSBYAmndyoSSMgAGorhyZnJuw40oO0OgbIxuuqR?=
 =?us-ascii?Q?oR1RU+FyTL/thAIF9CXsn/Pz3HUGni4Kl/PP0JI3Yovztr3UBp0R+uxTa/na?=
 =?us-ascii?Q?tcy7CnzRmXo7C0tY5cyQZlEPuCUftwkVaBb/mcTOKyHuS7LXTUX9Vh9MJMaH?=
 =?us-ascii?Q?egDxuJeaYSCV4P0jP0Mtb7Yx6xQgAu7iK7f7nA26dofXMlbH2u/d+SMqADTe?=
 =?us-ascii?Q?5AEEJE6Vt80rxTAKR2BuWk9RLfcjc8JQ6C5dkZ2q0eBh6qBnat+gA3BKERkS?=
 =?us-ascii?Q?u08z5VMTpX3vmbt8XR/q9sz6JxYuZjLISv5GjgRZsSWtWUtDNDa0AFwlGv+M?=
 =?us-ascii?Q?NGOHYOUJJJ7b61PBOF8Ht7MqdorEFeMnyukwr82e3o/peoZQHLPGHloC0s9X?=
 =?us-ascii?Q?+QnL0FXveh0kv0KT8KY0NyZQa8HVVwDmqWOlROYip+SNcDhXSUhdwLyFt6Fe?=
 =?us-ascii?Q?6+Qa3kweQ052zsBFkeDRGAZu+8NawsRY7NNhkW+HstitaccPtZk90588bwBb?=
 =?us-ascii?Q?0rgEFCyvWz+15T3d+2ncpK++vmtfWv203Q7XlYZorQ55+XhH9hvnT1g7bsLe?=
 =?us-ascii?Q?rsDU/h5QYFYJmYR55cJNiVhq5PgfNU8wCOJZQcb/t5ENK/2zlPSP05/65qfS?=
 =?us-ascii?Q?t30pLGXWrvTTYptLyxyq3ijKOim2rfYWoIRx5KAmydj1FgXHuJXLHDN71eqe?=
 =?us-ascii?Q?nODuk28=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(376005)(1800799015)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2024 07:07:34.3100 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: edc7f10b-058f-4946-9b13-08dc70bfddeb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6040
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

Check for specific indexes that may be invalid values.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
Suggested-by: Tim Huang <Tim.Huang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 051092f1b1b4..7c343dd12a7f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -2336,6 +2336,8 @@ static int smu_v13_0_6_mode2_reset(struct smu_context *smu)
 
 	index = smu_cmn_to_asic_specific_index(smu, CMN2ASIC_MAPPING_MSG,
 					       SMU_MSG_GfxDeviceDriverReset);
+	if (index < 0)
+		return index;
 
 	mutex_lock(&smu->message_lock);
 
-- 
2.25.1

