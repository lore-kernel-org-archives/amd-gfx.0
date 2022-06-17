Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF5FBC43334
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Jun 2022 08:56:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 02FBA11AB8F;
	Fri, 17 Jun 2022 08:56:07 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2050.outbound.protection.outlook.com [40.107.237.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 063AE11AB8F
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Jun 2022 08:56:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ihmMD0CjwE7pmXQzK53MBv/K/RgzhDzH0cLmy6nDw/IA4xcyVAD72YBOHSLjb7Oez8c5lbLHKQoCbEczZ/370/Lx0aNhXK3akhQIj3i1YzreNc9SaHcN7/hk4oi/qYDBW3vlAZOA+pGlNzqcKxU0nUukdP3pwqr9VwcaQBq4gev4NquYdy7ENydX+HDDWHsp/ImCBBhg0tYUFIMWlrnFFpygLi6O+DvW305O2NcUaq6WB44kCbDNwN5D7ivMx4jMBId6kzwBJ0OP1lt6tHMxFYsnTpmma8Ve5eeleORi7qIqFzPAIeVBK3q20swC18VOOw2h4eu/Z7PICuwUYSKP7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ANiJ14XrImgT22rEjNNV2E+AVqg/7fgPCAD6E1bew0I=;
 b=Dw8lICSU8tc3+D5R8MFcdeJe2E1IhxAjSe0L5cYotcZ6YwjvdUZSpY6Wz0q67l3icpD5MOFS18PTvJDHdlwXi2SGsMsx2NIMFK5BhCuZD6WONz1BxjW7I7XNxOL8TagMxzKnbHdsZfSyEPHMVPf2M8T0BA9ulAP8IAqjydgJF49Zv8TC6vGkV8G2F3cYfsQesgwfgR1WCxhMocmaDhNKJ7nkOsdt9ObxrYXzYd5FCBn/GbCoBaMnMG2BXOdJuhvj8TuNlcd/fmu3YwMwAhrRqLY3HLOthm+3wmON72mYTEa+/YF2DOTDqR3Bxk0VLrzn+/5Et9M7QXQSvnd8V2rHRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ANiJ14XrImgT22rEjNNV2E+AVqg/7fgPCAD6E1bew0I=;
 b=BP7AdPuClgeKxa7g+47C3XVW76Af8t+ixC9mWDrDE/lBdWgUaJA7xlELrQZc52caPAhvPbB+FyJIUVqAs12pFDoqu5qQddkp2lp2vHKTz+gR45Dx37DmZUR5SbnEPexeAbYZmEeGdSShqF0/tqk2R5pPc34OLRqZFT4rg/6s2i4=
Received: from DM5PR07CA0099.namprd07.prod.outlook.com (2603:10b6:4:ae::28) by
 DM5PR12MB1436.namprd12.prod.outlook.com (2603:10b6:3:78::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5332.15; Fri, 17 Jun 2022 08:55:59 +0000
Received: from DM6NAM11FT030.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:ae:cafe::34) by DM5PR07CA0099.outlook.office365.com
 (2603:10b6:4:ae::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15 via Frontend
 Transport; Fri, 17 Jun 2022 08:55:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT030.mail.protection.outlook.com (10.13.172.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5353.14 via Frontend Transport; Fri, 17 Jun 2022 08:55:59 +0000
Received: from syl-dev-machine.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 17 Jun
 2022 03:55:57 -0500
From: Leslie Shi <Yuliang.Shi@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>
Subject: [PATCH] drm/amd/display: Fix 64 bit wraparound resulting in illegal
 drm mode
Date: Fri, 17 Jun 2022 16:55:38 +0800
Message-ID: <20220617085538.610901-1-Yuliang.Shi@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 08a6355c-4c6d-4318-ab19-08da503f32e1
X-MS-TrafficTypeDiagnostic: DM5PR12MB1436:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB143660E17E265A0ACB9F2DBEE0AF9@DM5PR12MB1436.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vpV1sS7eyMShZY4wxlM+l/koBeDuWqeWw5mn/PFIHucBiaCnnbGc30SEpVTGCD+xGCvs0uxlPvtBcoFlMl38Z9bUugpd85e3iOrrJJwKRP8PvqROrulXlqAKFknVE72D87p/I6eXQYKeUzqy6W8setpxoMRenfypN1u6h7yS3LX0Y4LJdzATN6cqRuvVK/FpfaXY0XMw5ehoEys/Uye0UUPrGdSc2IRVJqrFIsM4D1Ipc3PsOm3/UpaOj+A4xot8I0lu9MH4gE3Cf6dmNe+xSobC3cWmNx9ldXDw+X6vxIUvWdEgr39GPBoWWZUUXE9Lj98x/HyQX89gFI7UwYW2WDqWYz3AO9+IbtCLiNRLElIbNKG0XxgQYZhmoLRK64sTyeaeiJ1L1LG1Et/AWK4U57MnCyY2Sis3Vjzfb43ixptgyFW3OEd0SpNwFlZ6x0l7aI/y9eWH0A2NaflPaQ5JrFBdzwKXcTrMcWF0LCqhWLg90GntV85KEAH0q+qHXE8VVnv7M3Wi7vv5cBO4+4l8OBg5tlOOZifVAkhACCXkLerR1gJ1+llfREhoEtFBHrK8cZvpy5R5Vl6xYz5OVwxbFyhL19EMVshNQhFFB26DI0/Rz8ygqgOje7ZNEv6Cw/JblXPn7bj21gClzPdQoGYf8S6kUP7Fi9jbjuxPDhy3UbCh9smkGc84KLEEuAH+VPDa1x7TxKDPWc6cbgXsQBaoQ9TOBDPg60B6xwQORnHhx54=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(46966006)(40470700004)(36840700001)(8936002)(6666004)(1076003)(26005)(81166007)(8676002)(7696005)(70206006)(82310400005)(5660300002)(36860700001)(6636002)(54906003)(316002)(508600001)(356005)(86362001)(4326008)(2906002)(2616005)(70586007)(83380400001)(40460700003)(110136005)(16526019)(336012)(426003)(47076005)(36756003)(186003)(36900700001)(2101003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2022 08:55:59.2220 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 08a6355c-4c6d-4318-ab19-08da503f32e1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT030.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1436
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
Cc: yuliang.shi@amd.com, guchun.chen@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
For m = drm_display_mode{.clock = 533250, .htotal = 4000, .vtotal = 2222},
common_rates[i] = 60000, the result of target_vtotal is 2221. This cause
wraparound of variable target_vtotal_diff.

On RHEL7.9 kernel, the type of vsync_start is int and the value of new
calculated vsync_start equals 67698. This lead to the following call
trace:

WARNING: CPU: 9 PID: 424 at drivers/gpu/drm/drm_modes.c:1642 drm_mode_convert_to_umode+0x42/0x1c0 [drm]
timing values too large for mode info
CPU: 9 PID: 424 Comm: plymouthd Tainted: G           OE  ------------   3.10.0-1160.el7.x86_64 #1
Hardware name: HP HP Z8 G4 Workstation/81C7, BIOS P60 v02.73 06/16/2021
Call Trace:
[<ffffffff93981340>] dump_stack+0x19/0x1b
[<ffffffff9329b228>] __warn+0xd8/0x100
[<ffffffff9329b2af>] warn_slowpath_fmt+0x5f/0x80
[<ffffffffc041b4e2>] ? __drm_mode_object_find+0x72/0x100 [drm]
[<ffffffffc040b622>] drm_mode_convert_to_umode+0x42/0x1c0 [drm]
[<ffffffffc041a2d6>] drm_mode_getconnector+0x3c6/0x560 [drm]
[<ffffffffc0419f10>] ? drm_connector_property_set_ioctl+0x60/0x60 [drm]
[<ffffffffc040392c>] drm_ioctl_kernel+0xbc/0x100 [drm]
[<ffffffffc0403bb4>] drm_ioctl+0x244/0x450 [drm]
[<ffffffffc0419f10>] ? drm_connector_property_set_ioctl+0x60/0x60 [drm]
[<ffffffffc051b30e>] amdgpu_drm_ioctl+0x4e/0x80 [amdgpu]
[<ffffffff934632e0>] do_vfs_ioctl+0x3a0/0x5b0
[<ffffffff9398e678>] ? __do_page_fault+0x238/0x500
[<ffffffff93463591>] SyS_ioctl+0xa1/0xc0
[<ffffffff93993f92>] system_call_fastpath+0x25/0x2a

[How]
Skip the loop if target_vtotal less than m->vtotal

Signed-off-by: Leslie Shi <Yuliang.Shi@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index c2bc7db85d7e..ed7ab089b224 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -8537,6 +8537,10 @@ static uint add_fs_modes(struct amdgpu_dm_connector *aconnector)
 		num = (unsigned long long)m->clock * 1000 * 1000;
 		den = common_rates[i] * (unsigned long long)m->htotal;
 		target_vtotal = div_u64(num, den);
+
+		if (target_vtotal < m->vtotal)
+			continue;
+
 		target_vtotal_diff = target_vtotal - m->vtotal;
 
 		/* Check for illegal modes */
-- 
2.25.1

