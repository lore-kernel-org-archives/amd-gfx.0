Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 523F4CCD188
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Oct 2025 18:49:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C3CF910E8BF;
	Wed,  8 Oct 2025 18:49:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FC6V0tGO";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013058.outbound.protection.outlook.com
 [40.107.201.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B5C9D10E8BB
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Oct 2025 18:49:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i2izJkvreSceITxl/OqaD8zjx66sk6Y+g5rE5qA20WIqZms8/mE8FWdAUVthZd2HhXlw1CRGMiUTUr46FEWTo9GoV+nvotbeh0nZMojiaJODP4io7CbSIM4cmu9cH21CCHxgXNuPiQYE8P8Zdsgzjf4TsqJsD5fPdIRwKz6O6VeDkzEfUFvUb9YZX+h420C3finpOrmkkVgYQczducJ2Rm67sOdS+xlpnT0yc2ycjFt6ECuWrMJ33FXvERj7xloNtViii66DOvspoq2pJhj14JlKKMT2wlFOLg1CAf1LAksMsX1XeS5An9roONSf42n1zulQGHqGYLPaYENLijpvAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fI1+1rHWjbUpI/zStfmz8LAJQ66ROel1TUxWGOEMnUg=;
 b=F5Urwiir2tjG6P9RyNysowapN+IEv34wQRgnKWw/EnWh8zeoOXEW6y/eCVEyBzcQ4mV5SU0Qr6o/imkSz3qMKOO/TR6eB6CDoVMHeFC1eBh6HqnHRXOf5GMJYXeStfb2wuA2SaDYZLNG5jl4v2NIs9091sq8pqY3MEuWfxOL2TUb6cwfG+9T7ACJ+y/hz04AIIP2lvqYeOvBFKz4gT11xRKxaCjJy0I6xQiBskoVWf1BwvTVvPoSqAUDnAYzUGD2QidUCPs1UR7oJCBOrkxjqHEwoCCHj8lrynFakd+G7Rg2dI9udZhFUBeZa/+8rDeGGZq8GePlzGL+hzLo+/hcSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fI1+1rHWjbUpI/zStfmz8LAJQ66ROel1TUxWGOEMnUg=;
 b=FC6V0tGOwkX1YyanF4H//3UfUJXA8nDhRPaI/rJvNPuqsj17zL2AMrT2DhsBVhiHFY4II9j7XuKLkIuCMG6O5lTwAsZfPcieviKFiIqRTxjKK6yKrgzgfh1FKcdzaGM0sXIcQ3OdsUC2BYc16u0sAXx0VJ1Al6t6gC/pwOv2Thw=
Received: from BY5PR17CA0033.namprd17.prod.outlook.com (2603:10b6:a03:1b8::46)
 by CY5PR12MB6273.namprd12.prod.outlook.com (2603:10b6:930:22::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Wed, 8 Oct
 2025 18:49:01 +0000
Received: from SJ5PEPF00000209.namprd05.prod.outlook.com
 (2603:10b6:a03:1b8:cafe::18) by BY5PR17CA0033.outlook.office365.com
 (2603:10b6:a03:1b8::46) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.20 via Frontend Transport; Wed,
 8 Oct 2025 18:49:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF00000209.mail.protection.outlook.com (10.167.244.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.9 via Frontend Transport; Wed, 8 Oct 2025 18:49:01 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 8 Oct
 2025 11:48:46 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 8 Oct
 2025 13:48:46 -0500
Received: from aaurabin-tumbleweed.amd.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Wed, 8 Oct 2025 11:48:46 -0700
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Charlene Liu <Charlene.Liu@amd.com>, "Meenakshikumar
 Somasundaram" <meenakshikumar.somasundaram@amd.com>, Chris Park
 <chris.park@amd.com>
Subject: [PATCH 09/22] drm/amd/display: increase max link count and fix
 link->enc NULL pointer access
Date: Wed, 8 Oct 2025 14:47:03 -0400
Message-ID: <20251008184839.78916-10-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251008184839.78916-1-aurabindo.pillai@amd.com>
References: <20251008184839.78916-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: aurabindo.pillai@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000209:EE_|CY5PR12MB6273:EE_
X-MS-Office365-Filtering-Correlation-Id: afac3002-9894-4c6b-c910-08de069b58f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ty1vcjpopmRZhhRDwwDclK0sQ9r8MX5JotLIkyfbQboK32nCMGv53Selx/L0?=
 =?us-ascii?Q?2CQ/ew0FtX16J2oa7W44bd4W5EfW1VZVknVt8I+2AFStlnFNYxYnR8mD00aq?=
 =?us-ascii?Q?dEzLllIN48UgEg26+fsb/DhzF1jrwtF+afuXmLAD6xlGPq6HDsH9ykfIv5xY?=
 =?us-ascii?Q?9PUyjLgditAhFAJ5gYAK8Tkyhpf2Vo+VsxFA20MiP+j8G7krAFfCvvWHMgbS?=
 =?us-ascii?Q?ZmU/OoCn/8KyHSaTcwpIjUTHKzfRWwFQH/OQoqnb9XniS4Xfr09Ck/BNNEIZ?=
 =?us-ascii?Q?mxLoAh7wz8LqFxgHLPZChIClK9pxaHBXmhZuo6gQO6/6syHDe+IJJBb822i7?=
 =?us-ascii?Q?rKdaxudI3L/vV2uSQZFvT4bPClDrLD7S1TeCs/Inp7TLGzKOutYY9blhy34d?=
 =?us-ascii?Q?4WQm4VAq5fYA31OFKzbsEJy2bzwZjeoRzFMxm3MfREwMGUG9QQfXw9bsE9Vm?=
 =?us-ascii?Q?mGtCCR0xVIgUqtXbCcBItiXNyk48SbiKLxT7AArxPe6cN7vbT3/QlEI4PXM+?=
 =?us-ascii?Q?h+iBf2OctndKcj2pmrhREK72tcFdgH5rbghDzUA2qLlDHXS8yZDRjK6AUCvO?=
 =?us-ascii?Q?UQoPbF6Q5JXxcrn6Pkv52EBxOf7aRAuXEFQXl1MAaT4wY+c2cA64X+EVoW5C?=
 =?us-ascii?Q?hVJxajHVtv475lqZ+yVBQ3gFhj9ZYTHg4ByyfFRsykCEO2if+1QbiY/frF+3?=
 =?us-ascii?Q?bneQngxe1kxJT0kF+iVP4q714/rq6e2tCmLIWBXliPJdgNMuGUGTDg8eh+E2?=
 =?us-ascii?Q?I792Q/LySj9/9bsb1NYZKlwm1ary6Dy6YMueaSYojlflL7ku4ag3E2X1u54e?=
 =?us-ascii?Q?J3JqQPL5hzYNSOjrvpD625Po4gjm+0E0IIs+HgI2+4kOvMA2Ru88UaPFo2rK?=
 =?us-ascii?Q?X46hzx/Q/qj7W2rsAtHFnupEiw7vQpN6hZbHDzlTEcufr7s2a+0rVmJha4fv?=
 =?us-ascii?Q?bAWyHD1ZMxDBFDSVmpSe3Hh5qf7MS1RUptJhrDTQtqJK5EBBUcVe47nwUUK5?=
 =?us-ascii?Q?xh1xAXURy/wJAcqKLu0DxDeLI4VNKOi/IUwGGfLttzSs08LEvxCs6aUKtCzg?=
 =?us-ascii?Q?KOYXVUkyHXnHngXELmpSidmKCrrS7JCIB9iyh/GVhdJURIZdzhJ/8GgsrVj/?=
 =?us-ascii?Q?H5l9eMxyvIPtHyFXY0nkx1fx2ptdHiT3VvAXZzQ7xVaJNZVoxcnhjx7PTF01?=
 =?us-ascii?Q?llQiyrJzGt9/5RPrN05oTn4RHjFzXIpZduninKHwd3qHk0oE+W6SR9AbYw6k?=
 =?us-ascii?Q?yxpM60mJxxA08VSTzZYRP0gP7atJflzWFkKrH0oFL6xQ37iqugF1f1aSCZvX?=
 =?us-ascii?Q?MFV5Y5+tADBMV1fc5BH4CRG18XAks4xgMkg09y86Cf1oLSLJGjTS8p8mqYHt?=
 =?us-ascii?Q?hoRDGwSz28iHt4zAJqro7dDPhNH/9+7GNUUMLH96IVbvR1bpEkzCLZ/cZwJ3?=
 =?us-ascii?Q?FCA6zR+0e65cw4ZujYPdeJwD2YS7EJEZmACRkocbhDYlG/bOO4rW7vngwtFG?=
 =?us-ascii?Q?/U30aiMKYhLRVo5TWABkeH4O9EXEJn2P/NI9goS7EU+xK4kEs0+cyDD1zAWP?=
 =?us-ascii?Q?uBwfKj3oReiPH388Pnk=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2025 18:49:01.4196 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: afac3002-9894-4c6b-c910-08de069b58f7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000209.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6273
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

From: Charlene Liu <Charlene.Liu@amd.com>

[why]
1.) dc->links[MAX_LINKS] array size smaller than actual requested.
max_connector + max_dpia + 4 virtual = 14.
increase from 12 to 14.

2.) hw_init() access null LINK_ENC for dpia non display_endpoint.

Reviewed-by: Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>
Reviewed-by: Chris Park <chris.park@amd.com>
Signed-off-by: Charlene Liu <Charlene.Liu@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c | 3 +++
 drivers/gpu/drm/amd/display/dc/inc/hw/hw_shared.h         | 8 +++++++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
index 0870ca19cf59..756ba2d41278 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
@@ -203,6 +203,9 @@ void dcn401_init_hw(struct dc *dc)
 		 */
 		struct dc_link *link = dc->links[i];
 
+		if (link->ep_type != DISPLAY_ENDPOINT_PHY)
+			continue;
+
 		link->link_enc->funcs->hw_init(link->link_enc);
 
 		/* Check for enabled DIG to identify enabled display */
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/hw_shared.h b/drivers/gpu/drm/amd/display/dc/inc/hw/hw_shared.h
index 41c76ba9ba56..62a39204fe0b 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/hw_shared.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/hw_shared.h
@@ -44,7 +44,13 @@
  */
 #define MAX_PIPES 6
 #define MAX_PHANTOM_PIPES (MAX_PIPES / 2)
-#define MAX_LINKS (MAX_PIPES * 2 +2)
+
+#define MAX_DPIA 6
+#define MAX_CONNECTOR 6
+#define MAX_VIRTUAL_LINKS 4
+
+#define MAX_LINKS (MAX_DPIA + MAX_CONNECTOR + MAX_VIRTUAL_LINKS)
+
 #define MAX_DIG_LINK_ENCODERS 7
 #define MAX_DWB_PIPES	1
 #define MAX_HPO_DP2_ENCODERS	4
-- 
2.51.0

