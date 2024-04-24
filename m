Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED160C4345F
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Apr 2024 08:52:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6278410FE17;
	Wed, 24 Apr 2024 08:52:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="S8Gja1mh";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2046.outbound.protection.outlook.com [40.107.94.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A36810FE17
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Apr 2024 08:52:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lv0XL7M83SlqpAxbhjh3CZwoOGL9HrTZBF/M0PdtSKdg6jdYIon5ZN/pImbVOeTizPzAskHuUJe+in826HMZXgsWMtrUbdPC/u0PBvOHTaYtDEE6uQYiAh/zuWIVrk+jQreWH1B9LuKR35EVl5Lar1LFL8AkUBwHdIeWG9PoBmXuKxAh7LsyXMDHw3UigKkOGEpJef1ajGi6UrvQklSI16btlLr5QgdtqA+L2KLUdWcsGers3iLMMmveJyUX75LoAdNifxcvFhCNAIr5SNIxh35NvP4imAiEUK2KGeBf2dxkDFt9y6n83WUP6+gXQQUE6Dvta/p92DFBq0Jx2KA+WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lctq6VGoorj/D/HC+FMJ14jiqc+VqSBlFHEfcc+GllQ=;
 b=GIUSqcV5cmesIfbA9qxcb9uw4AZVwZ2DnCwdC1RaKK4IdWZoyjz87GQ3XY4cfzkx8RVRWVTxQCmCZwEdr/RzUGCM1Vbvm56jfMWs08ub2agRWGmLtQPRvhg6QHzV7O48n0KTXDTjljrvDWd3mNeWjz/X31IVvno+cKpbKkTmNk2NBKZkeSkgIYIHOLyBTj6ymq1cKFQaYrYPC7PYQvYYXtcLS3v6VWjQjP6j5kDr58wsGLDHbP4ih6ZO7/Twa+I6MLNpaFzLxSkVh7Rz3yf4KNwb1I4r0UT12b+uGiEiqIkB4Qe2gL2zBBDaVyxiW8KkE+0FIeKkT0YmJWbajmUpGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lctq6VGoorj/D/HC+FMJ14jiqc+VqSBlFHEfcc+GllQ=;
 b=S8Gja1mhfyNJn40otAEymtv5MPUDNbR+B3eok1WbLvOg1PJWPj/EJ9QSQKonNZ2kMnLHxMaG7/Ha9u5Zm+wmFAd0cxwiaL2bOIDCofARd/GT2LjWHcIENLsb1eD2ECK/V895zWlMemQPh+UK+wmlPCJaTTpJf54A5Cx7MwQOKt4=
Received: from BN8PR15CA0072.namprd15.prod.outlook.com (2603:10b6:408:80::49)
 by MW4PR12MB6707.namprd12.prod.outlook.com (2603:10b6:303:1ee::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Wed, 24 Apr
 2024 08:52:47 +0000
Received: from BN1PEPF0000467F.namprd03.prod.outlook.com
 (2603:10b6:408:80:cafe::f) by BN8PR15CA0072.outlook.office365.com
 (2603:10b6:408:80::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22 via Frontend
 Transport; Wed, 24 Apr 2024 08:52:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF0000467F.mail.protection.outlook.com (10.167.243.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Wed, 24 Apr 2024 08:52:46 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 24 Apr
 2024 03:52:45 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 24 Apr 2024 03:52:42 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Nicholas Kazlauskas
 <nicholas.kazlauskas@amd.com>
Subject: [PATCH 26/46] drm/amd/display: Re-enable IPS2 for static screen
Date: Wed, 24 Apr 2024 16:49:11 +0800
Message-ID: <20240424084931.2656128-27-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20240424084931.2656128-1-Wayne.Lin@amd.com>
References: <20240424084931.2656128-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Wayne.Lin@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000467F:EE_|MW4PR12MB6707:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d8e11f5-cfed-4a39-bed1-08dc643be9b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|1800799015|82310400014|376005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?a8oSxGoF9TAGSwUT0sT8gnwg4BXcLmTkRYZfzsQf1dhNKEuPn+IDngLgzldR?=
 =?us-ascii?Q?zr8mvK54buRMaB7y8SBNKkAmIQpskfjQfkgSCgKKgcKUUx4MSzesSNElXgWu?=
 =?us-ascii?Q?yvs3wtOJ6BjJuPsGdUNZT+fR9LAVV6fG4aRyGjBd6CfGpsjpYZwb5dy26Kdf?=
 =?us-ascii?Q?rExirQKFtaa1n6bSqT+dNr9yh05zVlHfUOyeNB1vCpMH3IU9zgzGpcOkndvl?=
 =?us-ascii?Q?d+gSQ8Nh5GAPA4li7a83nVrQd47RxzVeiDFr7KtzXZcFb7+4gr1vR56zrSaI?=
 =?us-ascii?Q?brvBKD4Snh/T4cv4Kc/jnncSRypC1t0VBgsWdECw0jGTSp7F6VVvb9RYEW8T?=
 =?us-ascii?Q?vHAi+wvSdp1s97Opxque7mIRF/oFu8V4HQcDwTDih2UKCwrWreoJzkOEXebF?=
 =?us-ascii?Q?r8wErKOIypxUf82su1socwyBZP7hNPxbb6j5S2fVUnGBQkt+Etg7E/iRKc8R?=
 =?us-ascii?Q?C/eZiQVB8p6FOmSrqsCsO9xaUsZZIurjGsYIRqUcd35P2FjAiwdTEFuJ8PNY?=
 =?us-ascii?Q?BuU/oito6yBoG9cx1/oNlmj+D5L46v4eelP3oJWdph4RtS9eGEAIHs4idlRL?=
 =?us-ascii?Q?9DhPj5qxUCdvfk3+8+yaAzBxlgwkk7TWMx5kbKIeIqWgbtROiCti0X/ibvAB?=
 =?us-ascii?Q?TRHMfJDxXUyoXrn7U9nRs2Mn9lIwxmJog3T70+SVW0flP0DJA/+ofE91uCkT?=
 =?us-ascii?Q?cYtHAj5XdaGAqqu99p4kk3updsaCfxPzWVuV431s1VKPFU47JVFFNJS0s2S/?=
 =?us-ascii?Q?6+zD7pQNFqxktFQe2lBOtrrlB35CFLrjX0g0+PxzyNrOQ6hn9mLcoWgEa6qY?=
 =?us-ascii?Q?BUAw8DcZL4SobzXIu/psBLh0TICueqgSW50IOjwt65X5B0iw20fjqrmKUpVn?=
 =?us-ascii?Q?y0l6WzVorhllYxGuKAbVV++gReHJpbQYU/fYns1UUMchvYaQLSDPzD00ZIi5?=
 =?us-ascii?Q?QScAowDichumApORtV7ACys7pXA+evzb7/oUOaj1Hc3gyITUlrwYbQpXQ12A?=
 =?us-ascii?Q?3KKdQS4d3nBuwX3ziUBM5hFtjONaqUaWhgHSDRBu2MZhdyeQ3zVgwzl1y+vz?=
 =?us-ascii?Q?7aQi2oZopnGBGp+yyF/vSLxDof9bcxq9enPozqXWhQ017MpTITvPpvqOVORV?=
 =?us-ascii?Q?pgYREpxyIv0WmspZrUSFxbk5g2ewUpoNQNU/Z336W3GIzRvhrZWcqsPdEXvN?=
 =?us-ascii?Q?o7HfaiYVS70NJW006RJZEW40BEU+sqfPV4TDf0C34Vnrj/hZGjCoj0ynDBz1?=
 =?us-ascii?Q?hzZVrjBq/1GR+tvlI2sXRuBeWqvEqspLwwk5CWIfEHORXME2XY66mxV6AZdK?=
 =?us-ascii?Q?cws2RQRBAygvp1bXPjCWbihq3+kAxFsgKUETLDy94tLzJiI/evr+0dv3CtT7?=
 =?us-ascii?Q?8Rz9iNC8lsEyhU+eyyS1j5TYtL6N?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(1800799015)(82310400014)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 08:52:46.5821 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d8e11f5-cfed-4a39-bed1-08dc643be9b0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000467F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6707
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

From: Roman Li <roman.li@amd.com>

[Why]
IPS stability was fixed in bios.

[How]
Set disable_ips init flag to DMUB_IPS_ENABLE.

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 961b5984afa0..3ece11883941 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1740,7 +1740,7 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 	if (amdgpu_dc_debug_mask & DC_DISABLE_IPS)
 		init_data.flags.disable_ips = DMUB_IPS_DISABLE_ALL;
 	else
-		init_data.flags.disable_ips = DMUB_IPS_RCG_IN_ACTIVE_IPS2_IN_OFF;
+		init_data.flags.disable_ips = DMUB_IPS_ENABLE;
 
 	init_data.flags.disable_ips_in_vpb = 0;
 
-- 
2.37.3

