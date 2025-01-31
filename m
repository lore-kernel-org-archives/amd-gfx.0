Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E526C02196
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jan 2025 16:58:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 74A9C10E404;
	Fri, 31 Jan 2025 16:58:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ch82PUx7";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2079.outbound.protection.outlook.com [40.107.92.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2FAF610E3E3
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jan 2025 16:58:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=foDKLBkhKpgdn4lvaJwTWVFXooN7ZRLS8Sb0DSWQPym5YCBCAoH3BUm1QYEC4toLU6/1fFGKa/QBqnqfVVjKKcv2Q5yLt+i6dnXBGXH/2fHe0/Ntb9FIznLleni2XijcjjqjUW1mcXuAUpRGMjrYnzByzRdbQd+Zphh0AEjaTN9yysPrHkYAipYg/zNNeXhRSgrIU/VI41dImCTBgI36AmianvmUCibHPdYo0Yl3Sck07LGTO/OvlRV2wax2K8qDBX6GSEzlfkalsC9YGd3EXpjJbPnnVfdggQFQ7wV6fHpo3Tnb4DpTmEdqpFX5tHlwMoZ8Afyspa0GRyQJvhtmGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vTT+UgaCg2FcuMhyWbuGezgPRjlI4TPyGYI8c93ECU0=;
 b=gaE2sPj4WKMtCW88iHMqmRSkNtYv20F7Uwb3lBufLZQloFUK6BeeoyS1ibPbOql7BqWxbARIAMKvUIvjoOVmIsdUdk+RhGfzQXNBiERgvRN/XlUv+M1s4LprXARofxYLQu4pAMChB8MvrSmugy+cld3y+IxzB6A4rlj8hMK+1CqfgT4kReQGiTAvMwaL3HHz8ik/6/FmZi10olDNVcLDmPZNr3vSAGuLFUk3tUTwU5cU1/dIaZu+8phj4uFElbAU9YnXgQLeGFz8W8mmuuTJ9Xkb5uggLCnDDaDpFDmxB/5cLx1o90inGbKovLeHP38Xzdz7+qUq2AH2VETWhDyp7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vTT+UgaCg2FcuMhyWbuGezgPRjlI4TPyGYI8c93ECU0=;
 b=Ch82PUx7Z4F1uF0ObdvBn5x40iUlqBPglZBoxyp6vxLuFnnz1tHeGYieIuhvX3aE47wMz8OvcZieVKFG4f9AyRopMChh6iKGs0V84nRn/oWWp/ewweSz+04Z9ZtspyVk+aJ1Q8DhSj3OuEJPlXT+MjRAZRboQ7YWOjWgpIkaw6k=
Received: from CH5P220CA0006.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1ef::29)
 by SN7PR12MB6741.namprd12.prod.outlook.com (2603:10b6:806:26f::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.20; Fri, 31 Jan
 2025 16:58:25 +0000
Received: from DS2PEPF0000343F.namprd02.prod.outlook.com
 (2603:10b6:610:1ef:cafe::6c) by CH5P220CA0006.outlook.office365.com
 (2603:10b6:610:1ef::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.20 via Frontend Transport; Fri,
 31 Jan 2025 16:58:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343F.mail.protection.outlook.com (10.167.18.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Fri, 31 Jan 2025 16:58:25 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 31 Jan
 2025 10:58:22 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 37/44] drm/amdgpu/vcn3.0: use generic set_power_gating_state
 helper
Date: Fri, 31 Jan 2025 11:57:33 -0500
Message-ID: <20250131165741.1798488-38-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250131165741.1798488-1-alexander.deucher@amd.com>
References: <20250131165741.1798488-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343F:EE_|SN7PR12MB6741:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d8fda11-9b2b-4492-19ce-08dd42187a4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xKLkt8vK/Wri5zpXwuclIOt963z2R6OY9nmYnSd7kP/GjabG7syfZ8a5DUwE?=
 =?us-ascii?Q?2a8D3SNxI5ppwdYWqoQbZB4uK/8SyulV+PKIoTDHc0+sbwfBnMwYJAuy2rQ9?=
 =?us-ascii?Q?TlS3aXS6jMoUQnyDzB2hNAV8Zu8yWYRYiMxNPnkQisQaPyIyDNWr9mtyr9EW?=
 =?us-ascii?Q?bQbl6oqyV/WIiwviE3IMH6qjLEPYR/0YFm84AvwGQWTRr5quzOpeTNHZBEjN?=
 =?us-ascii?Q?HMuzH+xe8D3B+enbSBnG6GXVxIMCdPVJw6ajnonuEUafLbI0m4tpxyw+wVO3?=
 =?us-ascii?Q?GVtb1cWw9M3LEGB86FapaiFPC2kT2znOLj4izBqyFf9QHBOdP/EP2Tx8WQiU?=
 =?us-ascii?Q?Hwf5BnW2X/zR/Zy/DxniYPypgxxwG/UIB5Hu2TTXJic/CpBrQE+C4zmew/EU?=
 =?us-ascii?Q?xdbpTpSYurvSDotdVtkW5qx2uG8oHXyf1pG6lczKuOELHWVlzdhzfQqptApf?=
 =?us-ascii?Q?9Nurw6Lv/WuexNLAiTVVKWaMAAgmyN4V+cpFFVuhoWOfrhKmkrAKlbFr8Xbg?=
 =?us-ascii?Q?coaDICtY28thwZMTBpLzXBCoCHwfSS+clz/Qa9yX0vH0WkujyY3nMyfD9c99?=
 =?us-ascii?Q?69x3zfgMw8pf2GE86LxiwDJiAshcX0Q48RC0yfw3NS4i+AGvVZUPps8+y16H?=
 =?us-ascii?Q?tcfsNo/ZFxBTw2JK6wDOy4msVsXdpq6Xs1d7ksrTs66L/ZWqAiGvb3/wxHnd?=
 =?us-ascii?Q?keyE+OXNistpJzLgTISPXh6pghHzLbyXj8ZCHtEmhGIIUymTgPye7zNdwCEz?=
 =?us-ascii?Q?Y83S43tmYPRMw7nPS7obhtDiHIgIA2M0J7u+NEDIZ8y51AMZtOGfIpk63/rV?=
 =?us-ascii?Q?Xd7UuQvUxWApSRZ0Xwin8Z9Z2dKQbfrOxhZlW/IrgZakd5akgPMQ2zGQVfsc?=
 =?us-ascii?Q?nGB8s2ZNKAVsolJC3ZXv8VyYBFaMUEK+Wwp07N8/hT6HdvabNmFWZlA4cDtD?=
 =?us-ascii?Q?Y+uBMeB1gQYoy9NgbU9rF+T8Lg46MTd5CQaxvZHsgC3nBhQlQgSUAWdymb5M?=
 =?us-ascii?Q?wpMHPP+m5OxLyQcbwv2cs9KpojuJkvshPpYKerjbhMAIWeXb1qpLUPsARO7X?=
 =?us-ascii?Q?uikVNU5onluoVAXVKVDVLurzFV67t4wKUZDUn2gSOvlU5wi3WyunT2TmmdlI?=
 =?us-ascii?Q?RxRCmC5oXo9V4Ou/0gQRD0PEZu+/DkHA5+oIA9LZ4EVpoTquHAwLjrvALARk?=
 =?us-ascii?Q?0jgoJtDNYblw6nDjermXMvwkWcGSzLPtwn6nQgkM5fF6mhWg2S06lNxx2Ash?=
 =?us-ascii?Q?Ko7wiTcGIMTmZJ4W5+3Ids71kPb/lQ0wMiy6uq71cvHUEOTKOCZKCypcXYDS?=
 =?us-ascii?Q?TeaZ7lgQn515C88LaBPSSgxISTPOJ1Pg/e1+sckiEZ1aNGq3P6iPbP7qndSH?=
 =?us-ascii?Q?xdCt118XBGQ+F6UEyhJa8WL5hvP3oSooHip2l+G9v6KtPVVdB0wBAin3QYzu?=
 =?us-ascii?Q?cjdlArXYA/obYOgpC+TIND99K4HxNbqICV9cmjVDTGYGckYrNRhbWQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2025 16:58:25.3775 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d8fda11-9b2b-4492-19ce-08dd42187a4b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6741
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

No need for an IP specific version.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c | 19 +------------------
 1 file changed, 1 insertion(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index 353aab5565702..2fb3eb3b007d5 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -107,8 +107,6 @@ static void vcn_v3_0_set_enc_ring_funcs(struct amdgpu_device *adev);
 static void vcn_v3_0_set_irq_funcs(struct amdgpu_device *adev);
 static int vcn_v3_0_set_pg_state(struct amdgpu_vcn_inst *vinst,
 				 enum amd_powergating_state state);
-static int vcn_v3_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
-					  enum amd_powergating_state state);
 static int vcn_v3_0_pause_dpg_mode(struct amdgpu_vcn_inst *vinst,
 				   struct dpg_pause_state *new_state);
 
@@ -2230,21 +2228,6 @@ static int vcn_v3_0_set_pg_state(struct amdgpu_vcn_inst *vinst,
 	return ret;
 }
 
-static int vcn_v3_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
-					  enum amd_powergating_state state)
-{
-	struct amdgpu_device *adev = ip_block->adev;
-	int ret = 0, i;
-
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[i];
-
-		ret |= vinst->set_pg_state(vinst, state);
-	}
-
-	return ret;
-}
-
 static int vcn_v3_0_set_interrupt_state(struct amdgpu_device *adev,
 					struct amdgpu_irq_src *source,
 					unsigned type,
@@ -2383,7 +2366,7 @@ static const struct amd_ip_funcs vcn_v3_0_ip_funcs = {
 	.is_idle = vcn_v3_0_is_idle,
 	.wait_for_idle = vcn_v3_0_wait_for_idle,
 	.set_clockgating_state = vcn_v3_0_set_clockgating_state,
-	.set_powergating_state = vcn_v3_0_set_powergating_state,
+	.set_powergating_state = vcn_set_powergating_state,
 	.dump_ip_state = vcn_v3_0_dump_ip_state,
 	.print_ip_state = vcn_v3_0_print_ip_state,
 };
-- 
2.48.1

