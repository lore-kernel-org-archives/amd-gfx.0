Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E1FEC54E58
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Mar 2024 09:21:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2314110FC9D;
	Tue, 12 Mar 2024 09:21:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="t6b/ipVP";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2069.outbound.protection.outlook.com [40.107.223.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3204B1123E7
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Mar 2024 09:21:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lZalz607A44ZyF4Pl94zFWTYsZa+s/W7tTVWsTfw8VGnm/EEaiQEi8Pj/GsAuHJXIU72lqQiVVnFVgX2Tqjmll9aMJRFR6jZ6s91qR3crLAnbJzDIyG+5Lo/v0sZCQ5WYEiEegxD/yFss4pyRawU0qC2cMnbF/aOTOwFWDKc4JSa3t0uCALCBE8kLbJbxSFddG+B0TSNj9VQx10XB/gVgjcRVtaYWEz+P1uNU4Ma+6PlXSGoTh+hLR34yCsdb65YWkfxmb8JklN3ZoVPzlCKHROcbP5FlMn1fkVe42NlLA71xEwKTjF6jmzJA30AAXRPblQS/z2YFwVzZRu4TkuOLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cfzXEoSHjqLtJidwcXwq5zagAOQmy/e0DmZucTVmxEQ=;
 b=JCnO7HAVsb4c0NPkBpga8LwkG0wdMj8B5gwC3PP5KFHffLo2rgI4LvG1IchPBb0IT2qk2HzpPSjwLIegAigKsLpZcj4wEbWc8TamrkZLJ7GSNQplDrddMLKJWF8fd4C6E0b/SWfw52V0FSLSDdIqSRaIgfdM4xbaGdrgmXIc5+gc7ANrhCjshPkWKqSgJMvbobWPHZsO56MAqgpARn66XjBMgo83qPMD0I/x2fz5eGyw8RGDG5f+GYUbf3UYKIjCk5mhPsttKgJW/W4/8djJthCYuFWM6ap8sW1UTvsW5wBe46Zk29S0Bj7TJ8YdQHbtyPx6urDVrSJNUC0B3Hi2JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cfzXEoSHjqLtJidwcXwq5zagAOQmy/e0DmZucTVmxEQ=;
 b=t6b/ipVPK8oELDNbCZRBINTRlmxlURBlN3AQzOwAr9NhmvJLBOXrWCwyVUMnR4PRLgm+oY0Owwy7sL7K+INadAQveRnlElFTyg5HLxNItMuqXoax50TzC7dBh0HLm9s+R2hInGrYXCi3E4UQfnLJZFdozUSJn9Tefj5POHesrAM=
Received: from MW4P221CA0008.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::13)
 by SJ0PR12MB6781.namprd12.prod.outlook.com (2603:10b6:a03:44b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Tue, 12 Mar
 2024 09:21:09 +0000
Received: from MWH0EPF000971E8.namprd02.prod.outlook.com
 (2603:10b6:303:8b:cafe::59) by MW4P221CA0008.outlook.office365.com
 (2603:10b6:303:8b::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38 via Frontend
 Transport; Tue, 12 Mar 2024 09:21:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MWH0EPF000971E8.mail.protection.outlook.com (10.167.243.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7386.12 via Frontend Transport; Tue, 12 Mar 2024 09:21:09 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 12 Mar
 2024 04:21:08 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 12 Mar
 2024 04:21:07 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Tue, 12 Mar 2024 04:21:04 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>
Subject: [PATCH 02/43] drm/amd/display: Remove wrong signal from vrr
 calculation
Date: Tue, 12 Mar 2024 17:19:55 +0800
Message-ID: <20240312092036.3283319-3-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20240312092036.3283319-1-Wayne.Lin@amd.com>
References: <20240312092036.3283319-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E8:EE_|SJ0PR12MB6781:EE_
X-MS-Office365-Filtering-Correlation-Id: 37076f8e-aa30-4efd-1f87-08dc4275c10e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OxU3SKMNBCiEfSiqX4I/sFduphtgk+mfdZfb057cQTDI8lOP7X7AypYkHGHxO9I52jJZGHTnOmoR9bQyh6dCfkGyOp1Js1auPcRmGS+c6zvCSDbyNXTOtiIRBYBdBGf6mdaqJyPly27fyEJcY4BlRqaMTGkXVrk/hnZ0n66OG4O60YXqGIUroGDPuMiV4k3QZG7PltxrevJu+GfgG1ma2yZfqssiQhDEbnungX26FpSfM/oE6+kf17r6nrVS3RvvQxaic2CjLJzlMgtZIMPEMCPWK0eF20hRwszEnN33qY4mZh7Mnp0+X3TNq7ZKoS4EL2XvtU5EqtCHiJ9tyf+0buNAZv1NIaIoqbWVSATNk7atW/cdlrpYpk36pDCFu1Ez5WMeexELX7Mwc9UQ6sGc1ieUSjVB3HWqWriwMKq1BrAY5wzT912FZjPyu6ynSUyy+tw+Q8FCcD78Vwhjclfz9BANwND6fAHcI47qVvquDgiM7V9YhxcDhUFr7MYv3Fa2gto1KiDeAXQVnFufvQPmFtzxhV/04Hb1nVyxEwiQFEvyYKVSG2c/GvsGgW1sgnEqTnyxbqtmNlpbceKWPnrV0Ek8PRh1tBixd1edo2rKLlhpali0XHdd78KGXgeV1S7VPTWBaDpzPJWYSU9nmz2bSBqT9NexEk0bGhoZK5k/cFb0uQ3Y2SWZuw2V6S4c/PinqrosbeWJ78goaHwoD8hd/ZYYJLRDLYXRx09g5yQhlOzF2oKTbTLAMGq84857OJoz
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(1800799015)(376005)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 09:21:09.5584 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 37076f8e-aa30-4efd-1f87-08dc4275c10e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6781
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

From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

In some of the merge conflict fixes, one '+' was accidentally left at
the beginning of the line. Fortunately, this did not cause any major
issues since it acted as a number signal. This commit addresses this
issue by removing the extra '+'.

Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/modules/freesync/freesync.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
index b19ef58d1555..d09627c15b9c 100644
--- a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
+++ b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
@@ -1057,7 +1057,7 @@ void mod_freesync_build_vrr_params(struct mod_freesync *mod_freesync,
 			in_out_vrr->fixed_refresh_in_uhz = 0;
 
 		refresh_range = div_u64(in_out_vrr->max_refresh_in_uhz + 500000, 1000000) -
-+				div_u64(in_out_vrr->min_refresh_in_uhz + 500000, 1000000);
+				div_u64(in_out_vrr->min_refresh_in_uhz + 500000, 1000000);
 
 		in_out_vrr->supported = true;
 	}
-- 
2.37.3

