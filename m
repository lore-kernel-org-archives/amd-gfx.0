Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C356CEE347
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Oct 2024 19:26:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 338AD10E7E4;
	Wed,  9 Oct 2024 19:26:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0U5OXCBL";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2041.outbound.protection.outlook.com [40.107.212.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9845710E7DD
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Oct 2024 19:26:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KWOp5Sm09dqoXbNLIIBYQErDtqcfbzi+C2lnHvlzT3BKzsdff6YXsDWo97I2GgEOwmwC8bMxXJwDZSut7ZxNDn4ixQiuxFDn8CRnCqsDIqh6sZvD2WIykncol2SOIPi3qvFUv34o0HRn4gDpyXe9lIR/zd/y1zm+VxtJJOt2dL49ZNK19pnJil1G+oo0mRdwYMvX0KFnIkmnJz4yrZ+v8Ed5WRj3LQ3GT8/yAx+f8t/mK+mM25X4OkkbHLjNWvs3npLeuNfGh83ixg7+hwHbpaUhDlOjJm22N8PDw3NtebSrSxN+ptZkQCGqxLdlq/oP/BYRYMJsS9uLVctlxqJruA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FMfai7NO+6h+SYq+37pnSs4B9/zz08/2hyNNeDF8pzc=;
 b=CfoG55DdhuUoQdK6SbvrIsznqxI9PgM/oalEatQPA3VEwCPZMDgtULsTYLxadaiVoyktksqJpCCZ2FxkZBPSykCWQWH89ol2dEfMEHogD3Dydqhz+nwZw2k2OirzE1Fdpc7DR4KUHTww/nTFtrxRK0ykLhdzQIWsa6Bxo7jYqolxmFfhfsyfIuEO3aufoK9yrUngYxppbMO75soCDf9bBoW6OwQFZ8n8G0ReVmFXIWhypCcJtf7VVr/iw3LI82Gy9Kxz8qfNBV65jYC/o75yW9Or3WQUEw2bgQqzO+PGgYOgKAwT9jwW/E66aCfZNnwLcOStH59ZvxZrGRiJtiCe2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FMfai7NO+6h+SYq+37pnSs4B9/zz08/2hyNNeDF8pzc=;
 b=0U5OXCBL/FJk39BcUrON5UgK1mLgTUr+M1DAEswswdTIIsVY1fesmPDrVG1q1RUAJzSKT80L1M5XscQvF6hPRllMqOFLcfogSgijNrTu/YY1PbDP+Dwi0X5rwWZ1IGtEgUAjA+FgNHq17UqW4yU/2hTSZb3wV8MpqAxZoiMBRVw=
Received: from BL1PR13CA0430.namprd13.prod.outlook.com (2603:10b6:208:2c3::15)
 by MW4PR12MB6849.namprd12.prod.outlook.com (2603:10b6:303:20d::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Wed, 9 Oct
 2024 19:26:02 +0000
Received: from BN2PEPF00004FBC.namprd04.prod.outlook.com
 (2603:10b6:208:2c3:cafe::f8) by BL1PR13CA0430.outlook.office365.com
 (2603:10b6:208:2c3::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16 via Frontend
 Transport; Wed, 9 Oct 2024 19:26:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN2PEPF00004FBC.mail.protection.outlook.com (10.167.243.182) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Wed, 9 Oct 2024 19:26:01 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 9 Oct
 2024 14:26:00 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 9 Oct
 2024 14:26:00 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 9 Oct 2024 14:25:54 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, "Roman
 Li" <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed
 <zaeem.mohamed@amd.com>, Solomon Chiu <solomon.chiu@amd.com>, Daniel Wheeler
 <daniel.wheeler@amd.com>, Roman Li <Roman.Li@amd.com>
Subject: [PATCH 05/16] drm/amd/display: Add check for headless for idle
 optimization
Date: Wed, 9 Oct 2024 15:23:33 -0400
Message-ID: <20241009192344.650118-6-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241009192344.650118-1-Roman.Li@amd.com>
References: <20241009192344.650118-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBC:EE_|MW4PR12MB6849:EE_
X-MS-Office365-Filtering-Correlation-Id: 7dc11a43-eeb2-4b27-a534-08dce89835b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Kr3v4HhHkPr0G5H3m338hyfrDfZA60TjvoDNURbtq3TXuji58xSe6mKvWDuA?=
 =?us-ascii?Q?Q2Hs067d0UUgP+ZzZf2VcERuAE94Xn/WAqSmkLeWXubqXVW6oQ3DD8pihPA8?=
 =?us-ascii?Q?2+8QbB55OXMuFHqL4VMvLtCkMbOFjvvuoB/MmIGiXqWbDExFNXLc+r+i4ee2?=
 =?us-ascii?Q?jb/Rt87UjtAUNktQhoOS0IPjE3DDsLM8PMFuD0f2QG6R0hB6C2Cu9d/QbUlr?=
 =?us-ascii?Q?/RDawCX0eZwfz9a1bxPhH50XSUNXpRHTdKilM1GU9L+qF2LdTNlaKCxEIrA3?=
 =?us-ascii?Q?OElZqJaiO3hK4mF0C42nZJ2RDE9KpefyN51IPFcuvisBI3s2n+PGP/B8eIeD?=
 =?us-ascii?Q?fIZsjDK/ha9eVXdrw0iK/P9rsG4XyfwWtY1DMZ+umfrJigEPF4YJTR4t29C+?=
 =?us-ascii?Q?Av13CEdeCAKqKUC6e6a+G1uoN0r51wqKHI2NtcXK+5M2o2OxtB577J61BQ+T?=
 =?us-ascii?Q?H9MSw9jy49AraQ1ho9GlKS8zKdL4crXATObOdF6T+7J8ValdHOervUW8k7P/?=
 =?us-ascii?Q?pI/wgB1E4Qvp7ekTH97w983BCQlhTd0YXySb7CBcwhjTShB1kLNdVrzYe4tV?=
 =?us-ascii?Q?tlncdPIjgEHhRLMCpEkPJ+WBxW8VA+DbpiTOgqftfu0UsGOOfXHnB1DxV2+3?=
 =?us-ascii?Q?d1sUSPxOvozZwvb6TmgmXK7+q5TmtSam4bZM+TIsG+TxP3YosELSZBOYUmjN?=
 =?us-ascii?Q?6YzVh77aQw1Xqe7hpMJXfhS2JmeAq3/+pCO1mBRvrPY3qYE5buztks6M7G4W?=
 =?us-ascii?Q?EZDOasj7hHrYLVFNtdDxsxvdLmQeDzHk5AQWK5BpvsqUBXCNaqJqI4r9xzmb?=
 =?us-ascii?Q?skExcn+Lp7eiMOROzuoIX3sNZLMRbKSXLhJAjj4DIhYjVfrEkjUVSQvWT7zd?=
 =?us-ascii?Q?h+hpzjSwDCtTytkRtJUBRQVpUrgNXeuNt2UWWHtTYqhf46/jeHjuzJNdWTjm?=
 =?us-ascii?Q?BXfKgrTXNjzfWs1t+W4LabYXw5+LpyD0XnMbJehvx+tzOX1GAjoKm6XdYSQA?=
 =?us-ascii?Q?Gd/cw7GeBP3QBF7zE7ZA3FpNcPtgprL5r/i6aUEAmSozcXYAmxQegq39mkk6?=
 =?us-ascii?Q?rdeArNxBRYVGatX21fQeXAOgslUxJOftVuua6K6zvVqwsG7WmaJjXqI2qa3K?=
 =?us-ascii?Q?BAgiL3118S/kO9E2oC7NoLfbyc9g43CktKMQVtB1GStZx29uCJjT8y1ylMDL?=
 =?us-ascii?Q?Dv95tA6J9vI6ADyYKteINV4rQs5r+YKj277M6+aYxg5mgSaxhVxUchRGHa1x?=
 =?us-ascii?Q?tfrUwnFPZSjs8Zmhvtff4ao1nOKHmq7jEOoCauORBXWPCmbXevKkjC78QmET?=
 =?us-ascii?Q?1GGZNlBVPMJ45gKOIOsAykTiAYH3zq1u5ez6bMRwheaWVeLvUlAQ/QSDhMfm?=
 =?us-ascii?Q?qEsHfdo=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 19:26:01.2978 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dc11a43-eeb2-4b27-a534-08dce89835b6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FBC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6849
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

From: Roman Li <Roman.Li@amd.com>

[Why]
Currently idle worker thread that checks for HPD while system is in IPS2
only supports headless and static screen use-cases.
In other display-off scenarios hotplug may not work.

[How]
For display-off only allow idle optimization when no display is connected.

Reviewed-by: Sun peng Li <sunpeng.li@amd.com>
Signed-off-by: Roman Li <Roman.Li@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index e4511f2fb929..b19f94255c43 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -9549,7 +9549,7 @@ static void amdgpu_dm_commit_streams(struct drm_atomic_state *state,
 	WARN_ON(!dc_commit_streams(dm->dc, &params));
 
 	/* Allow idle optimization when vblank count is 0 for display off */
-	if (dm->active_vblank_irq_count == 0)
+	if ((dm->active_vblank_irq_count == 0) && amdgpu_dm_is_headless(dm->adev))
 		dc_allow_idle_optimizations(dm->dc, true);
 	mutex_unlock(&dm->dc_lock);
 
-- 
2.34.1

