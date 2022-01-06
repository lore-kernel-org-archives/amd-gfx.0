Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EF07C433F5
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jan 2022 16:31:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1819610E9F0;
	Thu,  6 Jan 2022 16:31:01 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2042.outbound.protection.outlook.com [40.107.93.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E31EC10E868
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jan 2022 16:30:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MS+sLBwfRnlQ6uUQ5YFxTcRNIwk67KZDgWuyCJFiEcmZTzEmn0JKZ7p/sCGOQkeuM5tmf6rpdxul+T2tH6zjtkU1LMckK1PD235Mp5EKm1W6528h+fkCIAlLtzg0BrnrEOXldzKzx4yKmSBhqJsdNCEXkkLT/08cXSLI7DK508xjlKnxij4FC5oarFYEtZqotlg163Aar/HInuK3Kzw1LhCGheLtNqgYXmY6PYX/j9h5LItz+PgcBRgFpgduMR7+YRV3BiZB9bYunZaAEu2o1IxneSfYXizBjR6JgAj+eXB/IDxW7kcnaCJIhgAdXRGR9XfB9Fw7FU6BYDT+9rZ1nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A9CzVQ397iIY8b7df0HGbkyiXYqROvNyal/njSvAmYU=;
 b=D4oBVZqXZU+i8IuQRwQW5gvtBQBqrDGkvporvJv0cOaBkwVHS+Xpt+b4YOQj2JtZEwC/VvZBEKbHSjqtVdEs3TGh+yIxcnWFGlQI8lApIRoQsYozamV0GGXAFISGqZ7n2L42GVGZybcs0eN3ROX9sYHPtFot6UDVVFw/PTsXGPUI8i7wiFqKMJQjhd8OU9McMw1Fkh59R8ByuhM6bJZQn4HiWHHDdYI+r8lq3MyxmUEI7atbTFaIcj+w01RqV90RbS+lRv5ldh1U82dsFi3dZQCMpYcSyOj2y2FPivLrDQmK5VHEowp83YTi3oSFTxZIwXLd5k2eMgoopCkAXmfAAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A9CzVQ397iIY8b7df0HGbkyiXYqROvNyal/njSvAmYU=;
 b=PrzLjDNVfQ46WhRigj2odP/fAzit9CcfLkDsO5tFN5vKUZfuq1whq92NvqPyjEyBH58nsCni17qvIyfZRT6P7rkFjBgZumsfdxcoYy0Cu34MdQt1zWcMEZYihYfABjUC9kw+t2ivoU8G55ThW1TmA6MBbHnEYuJp4eFsq4u8EL0=
Received: from MWHPR15CA0067.namprd15.prod.outlook.com (2603:10b6:301:4c::29)
 by BYAPR12MB4792.namprd12.prod.outlook.com (2603:10b6:a03:108::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Thu, 6 Jan
 2022 16:30:57 +0000
Received: from CO1NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:4c:cafe::f4) by MWHPR15CA0067.outlook.office365.com
 (2603:10b6:301:4c::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9 via Frontend
 Transport; Thu, 6 Jan 2022 16:30:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT068.mail.protection.outlook.com (10.13.175.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4867.7 via Frontend Transport; Thu, 6 Jan 2022 16:30:57 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 6 Jan
 2022 10:30:56 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v4 1/3] drm/amd/display: Add power_state member into
 current_state
Date: Thu, 6 Jan 2022 10:30:52 -0600
Message-ID: <20220106163054.13781-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7ec43397-d4a0-41db-3df9-08d9d131eaef
X-MS-TrafficTypeDiagnostic: BYAPR12MB4792:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB47928B184675A12722C09157E24C9@BYAPR12MB4792.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XKavpIKTrbaKjgxXqFmOBEo/CGA2GFjq5eAdXZtEn0gx8bNC3zyxjiZvL+K5jI86Io9csVdhHtBEV7+seLZ8eBnTPu3NgObeElDMOtzKRiY5kKV2ahK/zWDcaJnqJ20oZe1IFJrtHsv+jRdfMtFfDDIVYaiEvYf1+WM7DZnBMjYnvq8KxminVnp4tRG81EvOfgNa9Ox7T/PfVRwQqbwbD1/1qT/yMMN6RzF76DZ8ysU1MgtCw4dxbyZmotF7+pKaPFpQdpVgYdwQWecwgDJ6vP5LAwv6xTSvFEN/JccZve/4HlrjVCtgLRnAfdjPA1ywXiZkpOsExSaUe6bmWF2osld0ElxN4K+YtvpDNA1m12bm0WJMqh48Bh7X93INHj6luaEJV571B0xEJxr6LZEtCLz7QvORv84oPwxLcmzAgUVIQetBhpzSd6pNroME7YrQAcq9KgzUd0kdjSXGcgtP0yGHuHwN7z8mLK3r8YKql+WNKadk/7dh7zckFOUZsLBFpBY7zDu24+FZmh+a2w05VzUgp6ksXFGFdvUPlUjzIn7iEw88g9cgmFkVoHLJWmdhSnHrByTWoajKGGAOxhkMLUBHzRn3HaKUFsDL6tYCedmqNHcDOIUIo8tzEakn2wSzd4r1mcUHwdDwkba40UySOrTpxHK1db5YsMiTSXN2ww5vAAJVt8vUAIgAxPeIu+hOeYZWzTEcqsjrrAIlGJE6+sgb9GcXuHvLgV9yNSqeaTlZ3bQlYK3FTWy8TupXICn2xVTMAXGCgSgXgZ6HmE9VQi+Q17nBwyv7cyCO5lsP2as=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(40470700002)(36840700001)(316002)(70206006)(8936002)(82310400004)(40460700001)(8676002)(44832011)(2616005)(16526019)(426003)(4326008)(54906003)(5660300002)(336012)(186003)(26005)(86362001)(47076005)(2906002)(508600001)(81166007)(36756003)(1076003)(6666004)(7696005)(83380400001)(36860700001)(6916009)(356005)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2022 16:30:57.3223 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ec43397-d4a0-41db-3df9-08d9d131eaef
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB4792
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
Cc: Qingqing Zhuo <qingqing.zhuo@amd.com>, Scott Bruce <smbruce@gmail.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Chris Hixon <linux-kernel-bugs@hixontech.com>, spasswolf@web.de
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This can be used by the display core to let decisions be made based
upon the requested power state.

Cc: Qingqing Zhuo <qingqing.zhuo@amd.com>
Cc: Scott Bruce <smbruce@gmail.com>
Cc: Chris Hixon <linux-kernel-bugs@hixontech.com>
Cc: spasswolf@web.de
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
changes from v3->v4:
 * Initialize power_state when context is created (0 shouldn't be a valid state)
changes from v2->v3:
 * New patch
 drivers/gpu/drm/amd/display/dc/core/dc.c        | 3 +++
 drivers/gpu/drm/amd/display/dc/inc/core_types.h | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 91c4874473d6..8edbb6c70512 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1960,6 +1960,7 @@ static void init_state(struct dc *dc, struct dc_state *context)
 #ifdef CONFIG_DRM_AMD_DC_DCN
 	memcpy(&context->bw_ctx.dml, &dc->dml, sizeof(struct display_mode_lib));
 #endif
+	context->power_state = DC_ACPI_CM_POWER_STATE_D0;
 }
 
 struct dc_state *dc_create_state(struct dc *dc)
@@ -3281,6 +3282,8 @@ void dc_set_power_state(
 	if (!dc->current_state)
 		return;
 
+	dc->current_state->power_state = power_state;
+
 	switch (power_state) {
 	case DC_ACPI_CM_POWER_STATE_D0:
 		dc_resource_state_construct(dc, dc->current_state);
diff --git a/drivers/gpu/drm/amd/display/dc/inc/core_types.h b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
index 943240e2809e..6bd0aeed1856 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/core_types.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
@@ -506,6 +506,7 @@ struct dc_state {
 	struct {
 		unsigned int stutter_period_us;
 	} perf_params;
+	enum dc_acpi_cm_power_state power_state;
 };
 
 #endif /* _CORE_TYPES_H_ */
-- 
2.25.1

