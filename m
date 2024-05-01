Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E5EEC4345F
	for <amd-gfx@archiver.kernel.org>; Wed,  1 May 2024 07:18:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1BAA21130B7;
	Wed,  1 May 2024 07:18:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="V8igqEEC";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2066.outbound.protection.outlook.com [40.107.220.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B8AD01130B7
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 May 2024 07:18:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EZTAnxkGhtuEkmePy88p9kx/D0UY2FY/65ek2q25mikjRObl7ceK0ZGU766NNd7uHG981UtWfI3TYz01NmKAhtAEh12KHGTfQVTSC1LBZs8gZpmBa6onKtX0vm60Z4DbukyOnWzn/n6iJ5JjaAQkj68DnTwQC5WlH76ah3KezmytJjkxDjs0LgKMopRMx8qK7k4GXlapqgZxmSri64oSmqsjrOwau382LGstUC6IjJRU32YG7pThoQLSFlX7vKxKWI1glBaWYpf+PyesyAyp5D3HooB0Ap0Z0EXIkqVIky/S3CUvkcXCAtsMpCGkXaq0yhZnRXdO1ouT4KngaEL2mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ceOFSwfjyDd5/p108+bL8Lpb/JmqIotSEik0MdXPenM=;
 b=eegmk3oYrfakIBtlx6N3CTw5HcV0WCbSen38n+hxrZ9uj/P/gLQX/K4QqMC1Hv2FLjzZsMBOPN/0RJsIRu9EKa2b2/J7l9EGYc/loH7D1iu8ndvqKBLPaz2z2PzGRXXmD8rGUMMdr0urwIl/bpPXDEJ1QA8u4WqpK1/88erU2/zOuNQaMsVP77o0czhlCqxRI7YFDCN8flrCr8bVGs1U/cMUdbGgcUcWMmFMkzoa8scaj01cbo1nhgKrWMdKJoW6bog4zqGLYAsXJZO6L50dLLa2VOUnswXBQhIGj2XyEgJ3BHG3wHZctnqnPhcwyMbuEnaOCSdW8Zc7LgOxvrEqoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ceOFSwfjyDd5/p108+bL8Lpb/JmqIotSEik0MdXPenM=;
 b=V8igqEEC7Zqox6pBBbasmHFW6+bcbWz1NMJWE19C2rDRq03J3CArnVi89S90yISZwC4IaM0o8JmR+Ruv2XIROHvfOV4JgQsuh1AuKWnuVgK5ViyNp6yzlvA78OPtxT2lpHV3Cy8EHKrdIcwppz3aITqUJfBVsDR0RzlKDSjRq5M=
Received: from CH2PR14CA0057.namprd14.prod.outlook.com (2603:10b6:610:56::37)
 by DM6PR12MB4074.namprd12.prod.outlook.com (2603:10b6:5:218::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.36; Wed, 1 May
 2024 07:18:32 +0000
Received: from CH1PEPF0000AD7C.namprd04.prod.outlook.com
 (2603:10b6:610:56:cafe::2c) by CH2PR14CA0057.outlook.office365.com
 (2603:10b6:610:56::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35 via Frontend
 Transport; Wed, 1 May 2024 07:18:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD7C.mail.protection.outlook.com (10.167.244.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Wed, 1 May 2024 07:18:32 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 1 May
 2024 02:18:31 -0500
Received: from tom-r5.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 1 May 2024 02:18:23 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Alex Hung <alex.hung@amd.com>,
 Harry Wentland <harry.wentland@amd.com>
Subject: [PATCH 16/45] drm/amd/display: Fix incorrect size calculation for loop
Date: Wed, 1 May 2024 15:16:22 +0800
Message-ID: <20240501071651.3541919-17-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240501071651.3541919-1-chiahsuan.chung@amd.com>
References: <20240501071651.3541919-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: chiahsuan.chung@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7C:EE_|DM6PR12MB4074:EE_
X-MS-Office365-Filtering-Correlation-Id: 38d00438-35b0-4566-1ab6-08dc69aee833
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|376005|82310400014|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JidxDXWTxS5xh04nAxyQZ0/EdXLft+bhJj9RCJFm4YEdvsXgx4lHzwK4geaS?=
 =?us-ascii?Q?J3pFMUIODL4piej2/IwYA8Gfczo09spcYOClqKnTeQjWSfGnokIwWvZNO2fO?=
 =?us-ascii?Q?fVu0glzzoOxtZnNu1GoIn4TgvdNGMLVpOjZayHLSzi8NbiNuLBPXWzAbYSfx?=
 =?us-ascii?Q?q20LQ9OiW2Qxt5H3sMEnkznepxjtnh5NRDDJZAygfMvBHz83hr/fSRAbgJKu?=
 =?us-ascii?Q?V3Pr/ATMVV1iPd49Wa2aqRIDLEb34aXcP+O6sTFcw/ogPq7staM3w20Nzp9W?=
 =?us-ascii?Q?747F+0KPZaSqYJZa5B2FYO7wiAzRrvSUT6Z3RrPpaQ4+Sa934i1a4SCPurF+?=
 =?us-ascii?Q?fbDnqp+038a6p/mXfncgqeJMN15EvlTOfTij2rGbp/d9eI03u205k02sooLi?=
 =?us-ascii?Q?NQ9FzQx1mBnxLcYE/fUBQ3+GLNXg8K3pGSS2AH3bSARfGvjBGPqWtz1dcXo3?=
 =?us-ascii?Q?CZfita+HAkf8csUeTmyHIyTWCaoGg9ZLXFisMRYNlvIsCD7n6+IXaQJ1W+LB?=
 =?us-ascii?Q?GhM3a7G8USNtejnC4ya/EDahpHdwJFjFU0ZDVJwraxEgzpAT6JwLzEjTHAf8?=
 =?us-ascii?Q?6hFqj9QnQiB9Xpaa24zrUSU4nyGZnCCfl13Dc+5C5CxtK/jfnJOhBnjEBA15?=
 =?us-ascii?Q?7b9TOBX7YO+EGYHp1gBDeqmg7XvAxk2OMoCVFzz5Pv1wKvSm9OpurPWCMGCz?=
 =?us-ascii?Q?MXnfoLU+QWQ2r5Xnt6v+TV4OyXnkCcTByK4AH4C5paVRezeUHe2b110FcreQ?=
 =?us-ascii?Q?vxtQX9xHovcHpELOK1O9JphBwxXjhYrU1w3LbIvgshiwu25lkCaLeGZoRCKU?=
 =?us-ascii?Q?bViFBuScWiLIcWHz/8vBT/D6sCCnubulD06WAH40J7cK+XPh8U3vJ5I4gkvM?=
 =?us-ascii?Q?FV6joiTpceMDSX1s686FICo2viRrcAqa5AgJGfUsiH5hIWJSEcCsQTDCCFSs?=
 =?us-ascii?Q?3rJdCF0DgPYDgYfjRAYMe8QIA84MrglkHQx29LEW6/ROfsHe6t4iq9Cqwago?=
 =?us-ascii?Q?0kFk4knWKp6F7DF5CFSFvsK1+st3DLDypXKf4CGSSDCZfQtHJMEEh1t1taEB?=
 =?us-ascii?Q?zHypl7x4gtxUbbAj0Tz9EPUt3+jx2MlWeckw1/OL9RbP7irqtVBLXMhueoHk?=
 =?us-ascii?Q?xxBpH/87Gkp2VtppHX58vJjMcz68Hqdax76/tHtsBY9JWthDtf6bi/nOhf2H?=
 =?us-ascii?Q?W7dmeN+tlobmFZlGKPp19f9FC/Vd2+s8VPlY4tL1uYtQu1GIy0D/MW5tZIJX?=
 =?us-ascii?Q?plh77BEViuaUFHRkBON9YelcjwqFWFTeBvj4fn3DBZhSB7DVXJlNC699ZiJf?=
 =?us-ascii?Q?/yxrcBe2oa196XKu1IrIVYZPCvhVEX0J62vLZZuYeIXdGMZbzIP8NDD8u9bQ?=
 =?us-ascii?Q?YX+9ScXPk3yuVhed0UNaMGhGeOnC?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(82310400014)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2024 07:18:32.0032 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 38d00438-35b0-4566-1ab6-08dc69aee833
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4074
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

From: Alex Hung <alex.hung@amd.com>

[WHY]
fe_clk_en has size of 5 but sizeof(fe_clk_en) has byte size 20 which is
lager than the array size.

[HOW]
Divide byte size 20 by its element size.

This fixes 2 OVERRUN issues reported by Coverity.

Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c b/drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c
index 02ec16bf381f..1fc3aa2b507b 100644
--- a/drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c
@@ -904,7 +904,7 @@ static uint8_t dccg35_get_other_enabled_symclk_fe(struct dccg *dccg, uint32_t st
 	/* for DPMST, this backend could be used by multiple front end.
 	only disable the backend if this stream_enc_ins is the last active stream enc connected to this back_end*/
 		uint8_t i;
-		for (i = 0; i != link_enc_inst && i < sizeof(fe_clk_en); i++) {
+		for (i = 0; i != link_enc_inst && i < ARRAY_SIZE(fe_clk_en); i++) {
 			if (fe_clk_en[i] && be_clk_sel[i] == link_enc_inst)
 				num_enabled_symclk_fe++;
 		}
-- 
2.34.1

