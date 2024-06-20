Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15B5DC27C79
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Jun 2024 16:21:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 62AF610EB3D;
	Thu, 20 Jun 2024 16:21:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vYsuBNnB";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2047.outbound.protection.outlook.com [40.107.220.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A59F510EB35
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Jun 2024 16:21:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V7e4/qGYUoYsj1dFh+BI/3IJ5/JIlwbIeSo8l+qX71NjzzYtJeA4UAx9Zb2YSXrIz4kBOLB3TG3B513EhvuPPFnO6q7X3yGW3Xf2zZLEcqloEnqm1rEmnNUrg897TQ9IlITmIeH1rpbbyf3S51OXvFTJ6DvKco43UWcjm53AkExbpj/gp/gL1mXOryrue4+ljoEqRDtG8x33RxMmpA6MTzOOsIkoEe5q23wrAnUgwtHu+xp3BTxvhYboylq3rfNKxs0aeogzqcMlI0Cuw4cgQgiveoMAZHWZ1t6EjIr3L//wPG0i9CRDQ8rU2JydlnYsgvsgjrje6jprA9N/2ZREvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ripsCrrAzQsIo/fq4PV+78XpsSxDxv99o6tUgUmRCJU=;
 b=a1wIT9NLY+YkVIinBEt/cCT5kTsjT8NLnnflpaIEA3DIbg+SwKenrKGx2QHjnGC34ROgYEhQdchdlxbkcvVWhVjmdn0vgdpgYpVX8HGpQ2jvEY0yDfU/zsgztyI5urbnEJUd/EdCZQ4idpBTt7NTPuPSXeL9lanUsDI7j6FnZ5+O1Wh2k8RvgJ0sKTg6rLZ+pMzQtN72tKKdVjSdF1j9iUp624cCLV9ET40YMZhEHYxRQggZTmNcsuoRyJ7ZqfxRCbtetzeQHxHtnIoBfrcyv3FV/FPlTlpyNG3O9u5+3zH6npjAZ+qaP3huLdNlqduHWmMC+QX3GVdm5653hgUH8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ripsCrrAzQsIo/fq4PV+78XpsSxDxv99o6tUgUmRCJU=;
 b=vYsuBNnBxun6UPoSQUjUgrWa6+VqInUJfd4Q3wYGGrS0L8y5XaxM6FAhyG/QkZJkPTTmvgspsvieaS/KhX4XJcn1wA3sWvQN6zXcg0m9CYfBT6t50v5lUiIaCaBiRXR4QZWdF3o4ryFKNtuKeYkaIhxDizRMEatJDnzsA7MGmmE=
Received: from MN2PR05CA0022.namprd05.prod.outlook.com (2603:10b6:208:c0::35)
 by SA0PR12MB4445.namprd12.prod.outlook.com (2603:10b6:806:95::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.21; Thu, 20 Jun
 2024 16:21:27 +0000
Received: from BL02EPF00021F69.namprd02.prod.outlook.com
 (2603:10b6:208:c0:cafe::b0) by MN2PR05CA0022.outlook.office365.com
 (2603:10b6:208:c0::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.32 via Frontend
 Transport; Thu, 20 Jun 2024 16:21:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00021F69.mail.protection.outlook.com (10.167.249.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Thu, 20 Jun 2024 16:21:27 +0000
Received: from 10.254.92.128.in-addr.arpa (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 20 Jun 2024 11:21:24 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Aric Cyr <aric.cyr@amd.com>, Alex Hung
 <alex.hung@amd.com>
Subject: [PATCH 39/39] drm/amd/display: 3.2.290
Date: Thu, 20 Jun 2024 10:11:45 -0600
Message-ID: <20240620161145.2489774-40-alex.hung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240620161145.2489774-1-alex.hung@amd.com>
References: <20240620161145.2489774-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F69:EE_|SA0PR12MB4445:EE_
X-MS-Office365-Filtering-Correlation-Id: 740b3a1f-b978-48ef-1413-08dc9145094b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230037|1800799021|82310400023|376011|36860700010; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?c3VHjRDeNwUXsTaLvSYn1+bjpT3IQprYsLNN559XzdlIsRDgRrKG9SAUd8Qx?=
 =?us-ascii?Q?8Cueijzh3Fkcz/v0s7ehY14HNRPZxHgy/LJDM8NNjZ8Tk5mnJbJf0mks7Aa9?=
 =?us-ascii?Q?SkhDi/sZ2AiTBYidqQtaZ/ecrr61Wt5U2AlnP9sOuQCTs3yi4CzizSJVwjGq?=
 =?us-ascii?Q?DRbksHAQTN7ypfyRW8oI634Rdp6a8/n+iGzrqMs34uPanZ1LwGD+BCN0Xuka?=
 =?us-ascii?Q?/YMeRh76YFw18MbsTlRv7MA2WS8i8vasdF0Xdd/1ETCxamc6nxPTPQGjy6xj?=
 =?us-ascii?Q?3H+SHoDXmWBvt4V9bp5kKaoYuUUCDLRNL+bp9AdSeujxytvJ09SGn+IDHr+t?=
 =?us-ascii?Q?hrjkbfH3e285gLLIRt8SO66gHyXU29F7JaXPyJSUagFpwiCfPv9B5Pzturm0?=
 =?us-ascii?Q?Tma3MGxoui1OIXyj66m8agnJb3WNMTzlmsovFr+N+y+cBtnhocmpGcoQ14h2?=
 =?us-ascii?Q?i/kzK/W7pGAnqdASHoLGa0PWMWGptMCOoa3BY4GwDrb7raZOACse07tl7IU+?=
 =?us-ascii?Q?/kNHS0VT5bYQpUzMvKTMj/Htwf59I8eLbuwjC0yXk4Uis8dOC9UPw8PRHEOm?=
 =?us-ascii?Q?iFR31+Z2uFT6P4hOwv+pxX0GsQp+xwM3ZJzDlblE7QFpOqFpwJnfHUEflmfp?=
 =?us-ascii?Q?Y/naBG2m2JO5mA7UQGMJMWknOJiskd2kq+d4fNtmnkjxmOLI8eDL/HApn8W8?=
 =?us-ascii?Q?pb3oN5thEewg3Jv3UXDGcnsP1qIRA8efWJck7yfo6HkgpC9y6qKpIzXZG9X/?=
 =?us-ascii?Q?9z89AiEUdRft4NSNAZ6rBHZTNg8S2hXkHZdNj30LHPb5CKzHjh3rc7ly3xjx?=
 =?us-ascii?Q?3PKbMsz+hJT9J7US0FC6xVg9MrPC+D9NvGvLl+6C3WEleqfr3neLYaHy40ti?=
 =?us-ascii?Q?lhLhZBYOQkjvvZvwL2py0bp4r6z7MloBR6CV5g8K9m1y1/p4vHpNLmlctjb9?=
 =?us-ascii?Q?GQDHf20FnaHo5Mm5BR5KYjPoaxyQ3fEjFLQYSgDJKGVfKwDKL7y3B338UkTr?=
 =?us-ascii?Q?IJtsPhs95K2y5UXhXkO+SHSy8GROT3A12krhoYpLnjW8q99xD2n9yT5utWsP?=
 =?us-ascii?Q?5SnN3s2ADrdEms35A7s7MK9mtYZKJaS6n/p2L/oj/VtK/PlWklTqFH7VIYq8?=
 =?us-ascii?Q?7Ad6IOLALBSGMRAxIU+Q8UhtpPvpH4RswvwtrFNcVqaKybmSu+5eYa64mhSZ?=
 =?us-ascii?Q?W2VxKDN9H8LoFkDut8vxgFO7c9IabRJ9697Jdw0VVZ5oBrANiQa9Aj52lV6l?=
 =?us-ascii?Q?o674n4SPswV3C9oh0DfCxHasJK9aAlwFZ5twKSkIdmC7K9ic5+eFjKLmI9bQ?=
 =?us-ascii?Q?QzY4uUGqnRiglHFK/b3mTMpmGMoa4qUCpHe+s6aUcFPyz2mFQa3vYU12uXoU?=
 =?us-ascii?Q?j4jQ6xQTFuNW6GZymhcwXNsAq+zJCM1il8G6q9dnMqrVoJdbTA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230037)(1800799021)(82310400023)(376011)(36860700010); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2024 16:21:27.3672 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 740b3a1f-b978-48ef-1413-08dc9145094b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F69.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4445
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

From: Aric Cyr <aric.cyr@amd.com>

This version brings along the following:

- Enable DCC on DCN401
- Add reg definitions for DCN401 DCC
- Remove duplicate null check
- Remove always true condition
- Validate function returns
- Ensure curve to hw translation succeed
- Use periodic detection for ipx/headless
- Fix 1DLUT setting for NL SDR blending
- Adjust reg field for DSC wait for disconnect
- Remove a redundant check in authenticated_dp
- Add HW cursor visual confirm
- Fix cursor issues with ODMs and magnification
- Wait for double buffer update on ODM changes
- Reset DSC memory status
- Program CURSOR_DST_X_OFFSET in viewport space
- Add null checks before accessing struct elements
- Fix reduced resolution and refresh rate
- Make DML2.1 P-State method force per stream
- Add workaround to restrict max frac urgent for DPM0
- Call dpmm when checking mode support
- resync OTG after DIO FIFO resync
- Always enable HPO for DCN4 dGPU
- Use sw cursor for DCN401 with rotation
- Add Replay general cmd
- Check HDCP returned status
- Check and log for function error codes
- Check and log for function error codes
- Remove useless function call
- Fix uninitialized variables in dcn401
- Fix cursor size issues
- Run DC_LOG_DC after checking link->link_enc
- Remove redundant checks for pipe_ctx->stream
- Send DP_TOTAL_LTTPR_CNT during detection if LTTPR is present
- Fix cursor issues with ODMs and HW rotations
- Remove unnecessary variable
- Remove redundant var from display_rq_dig_calc in dml
- Refactor dccg401_get_other_enable_symclk_fe

Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Aric Cyr <aric.cyr@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 40f183816e31..900892855436 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -55,7 +55,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.289"
+#define DC_VER "3.2.290"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.34.1

