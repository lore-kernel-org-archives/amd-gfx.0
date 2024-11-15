Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A815D637CE
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Nov 2024 13:58:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4741910E0EF;
	Fri, 15 Nov 2024 13:58:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IWGOlhPC";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2083.outbound.protection.outlook.com [40.107.244.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D616610E0EF
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Nov 2024 13:58:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hKSc0KtkWCFlaUZXkGgCm3z8cu5nYo7m7OdAeLL5brQtAlIrVuRgtFdmF04fFSu2Fe2ca7QdjO7m1su7DAKBJ9Hg0x/5KJdY7DkuKCqM6oxg6wAAPEVedsutdiinjJTPXpDvWqoTAReeJPFcHy6M69SaKXmGZcABgkotBXqOc1ofAhAHFaWgK/pvx0DTNxa/URgC7b3zGDYbiN9UI7R3TJ8OtvYU0Ns1Fejnqc39ab/bW6K9eZpBcmcw03jWQaI1tWY4uYZCG5kofKyaYsJD27XJLm0r84fR5XsKaLqkHEMIApUNxW7x5K8dE+JVpK9WS6q0Q+pEBOetU6olJcxXSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sl+4cA2BEOszb8cw5wPjZiXSIkE32oAR7OAmCrlkdxo=;
 b=bVaQL6ZwwSf12PdYgVgSydmYILSMfC724U5Tk0AwOqmaZsXtCuRyuGVQ9Qs6zgx19WzhfrY9k1aQVCNOF7ADI96rqYrVvvI8PFikzU0oToowlnPIjt+A54qKg72LlF6IWWAyHk5CC4j8u1FsFTJ+A3Ixt9P+7bjBucgyIMAiHrNndwc9WR+dUJAauetPHZPmxB3HYOcG8SbtDnyTChVrhM6J5TJYHVg+PakLzkmEiv2GOmnJMcs+KAJK4fqYC6Mf8qjqdzvV4ep+pY4lphw6u4Wl1PZl8RzgxOiA9vM6v6cMlL9UU0oUBGrp+TW3BuZb/GuUBfopDCYlIwmxbPmg4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sl+4cA2BEOszb8cw5wPjZiXSIkE32oAR7OAmCrlkdxo=;
 b=IWGOlhPCHXD2USLg80PzEQiJAdEYGzMR1nsi3mYvvhO0I1JHob0X+f5YQOgQM45WW/tYDLRFBUr1G/Aw488bccaXo20HPTeFyGzMj/nz1OHiA9/mljRxJJ6WdcolIaXw54BLWwlsbkc3zXZudKItEMIZrZiUHv8cLkR9q+JW3uA=
Received: from DM6PR18CA0017.namprd18.prod.outlook.com (2603:10b6:5:15b::30)
 by PH0PR12MB8824.namprd12.prod.outlook.com (2603:10b6:510:26f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Fri, 15 Nov
 2024 13:58:25 +0000
Received: from DS3PEPF0000C37C.namprd04.prod.outlook.com
 (2603:10b6:5:15b:cafe::a3) by DM6PR18CA0017.outlook.office365.com
 (2603:10b6:5:15b::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.18 via Frontend
 Transport; Fri, 15 Nov 2024 13:58:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF0000C37C.mail.protection.outlook.com (10.167.23.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Fri, 15 Nov 2024 13:58:25 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 15 Nov
 2024 07:58:24 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: update MODULE_PARM_DESC for freesync_video
Date: Fri, 15 Nov 2024 08:58:05 -0500
Message-ID: <20241115135805.496376-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37C:EE_|PH0PR12MB8824:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d4786f0-6af7-49c1-9970-08dd057d932a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4t5Z8bXDxZ3HkUGQ+E45Gt33r32XGJn5XANxuvq2ihPNpvAdIxgUyu/uzRLX?=
 =?us-ascii?Q?i0H+6Gdld3Cwo8E3LG2HtZ+x8eaQbN4w/O8SVo8iWdE307AmKIzt3DrFJsNW?=
 =?us-ascii?Q?A/YlHqRbslTYvTbqVWyOKCm3Wk2CglKXbeANAbrqR3Fpk7wbo5upx72UbIs1?=
 =?us-ascii?Q?04Sigt0hmzKCowPuHE0mhjOoLfwzc2+QeMSizWDDYhvBFPrCiP6HLNIHwBON?=
 =?us-ascii?Q?VacptBIVdJUCfZW/al0PsiOhsW7apdG+af2kljqkbeYscvaUTMALHmmF/xVe?=
 =?us-ascii?Q?7tpn17dLi5tGrXA7RQc8ZUDKcPJHlgKueUM10wsEFoumZuEumMCq6clIsu/V?=
 =?us-ascii?Q?jabLEJxwkiezI7EOCBui7FlU7lM3hRciYDj3+eU1+T3NhNL6TIo1Bcy9Ski5?=
 =?us-ascii?Q?roEXb3VLoa6FMHelVhN4ruMsHNstOA5L5JC9iXvgQ7r78ovfUk0drzd/yvcV?=
 =?us-ascii?Q?RyRlRliskMPh+uD3jCEQvkOeXsMcubdZRg0XqGVmToAszfzZK5vAJ1ENAuBJ?=
 =?us-ascii?Q?+AFP/JQrL0LlR8RYEbCnxrV1eBmGf1pMSpxFCm/dHYZ794iMI22f/k0+jWQ3?=
 =?us-ascii?Q?RYE28gMaMfPmZIm67wY7ZwSYMnE8kcNVABG5C6a8F8Mmja6R2tPjamRmQTF1?=
 =?us-ascii?Q?R/DkrOWdy7cqTt2UPfDD6Y6ozzHr+Uz3jU0KAuG9tEviun88QeVlJqyNBtil?=
 =?us-ascii?Q?ABRuk5YTNx3E+Iwn0egXVuDZN/M2KZIXfaahcsIVpFFOhgjcsoMZ/uPUfSao?=
 =?us-ascii?Q?uPgU51uwKB/wiQmyuNoGb11w70uFNaCrpRO1hmlFYg94IvmLsXTrY9aF0B7E?=
 =?us-ascii?Q?ooeBEsJ0CjizieECJyCKuuo+Af+C0DhDW0wDNe1S0B76rLpGvfq68Y57zNK7?=
 =?us-ascii?Q?G36Bza5fMT/61rdxifUWUgRBkQXu17xXJDRKtCIF6YnpngCx31RwzZUZrkts?=
 =?us-ascii?Q?YTrQlR10vUHoCLEmyex3Oo81IxJKweDvBHFslijPqDNj9hNGqppviL96jkfC?=
 =?us-ascii?Q?+ZyE/d8ey+ObkQUnSx1E5GE+9jMf6EMRncg5A8hmzrehIYsiDJ697XGrQ4TZ?=
 =?us-ascii?Q?LShKQj+L7RfQM4hBcTTNkjrIbdgLSkQ1qt4W+12LA90yrZfDyMj+UEsYuIjD?=
 =?us-ascii?Q?auSR4/88kcMH/0oojpVGNsS5Wg5mHr9z71yr45VA3VRKU7JxxwaPvWmvfJLG?=
 =?us-ascii?Q?5UIZL8P8hVr9b5kDQz9siUTHFv49pCSIOnXNzeTtUBixazyxlvTf1TUQu2oD?=
 =?us-ascii?Q?7FSWRGe7il/TTCx1ClG79qoNHox32mboTRoQ+wnP6zWKUtrGEN3j42o2dDkL?=
 =?us-ascii?Q?XrPjuToVuUbcBYw2ts5K5OhcbrycqrMD4bmJrqapCPyhhMi/zMqwUfi3LH3g?=
 =?us-ascii?Q?NdyQowY=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2024 13:58:25.3478 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d4786f0-6af7-49c1-9970-08dd057d932a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8824
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

To better describe what it does.

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3756
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 38686203bea6..c8efe65586db 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -945,7 +945,7 @@ module_param_named(tmz, amdgpu_tmz, int, 0444);
  */
 MODULE_PARM_DESC(
 	freesync_video,
-	"Enable freesync modesetting optimization feature (0 = off (default), 1 = on)");
+	"Adds additional modes via VRR for refresh changes without a full modeset (0 = off (default), 1 = on)");
 module_param_named(freesync_video, amdgpu_freesync_vid_mode, uint, 0444);
 
 /**
-- 
2.47.0

