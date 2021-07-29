Return-Path: <SRS0=5qjI=MV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5F33C4338F
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Jul 2021 20:37:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F7E360F46
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Jul 2021 20:37:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8F7E360F46
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 451396EE51;
	Thu, 29 Jul 2021 20:37:28 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2069.outbound.protection.outlook.com [40.107.223.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 250366EE60
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Jul 2021 20:37:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ikXVXRV6GArU9L+kIYpNJZzcaY+fYqcw9n/R/tAI+F2hge3T6gXapZ1T6cc8MjHdmgjCYhsD+S75W6Za2fYTuGjSMhJ5bQfpkcBkWj1hYFK8KDyxLYsmf5wzI11KCGoJahIY5Gj22dMWaQqc2w/Z9OJfC2Y8PYYHrhKf0sXcmC7Dy6p9tCEeCxnvCX3kI3eguC5LBt2F/xIHK9Zwi5suthhFozg/scfQaDisLuIv80UwcFmf/qqZVihgYzhHs5ctV7d5eMhj/umIFghVwvf5+AcE7dSh7aGk5PHbvxmigHtlZedkIjXlSoa+8E/sQbhIhQUfCsT9yCypxoSdUQ1sLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QgfxiY6ouYZr9oectUVNkIgYIjCuE3OpxTJX4/7XIxI=;
 b=Iw0cH/s+MsIr05K2yxShgRzksJVKM8liy7ro/JVVNqv7fL8Jgn3G1wxMlmJbs3ok4q5l1RpPpL5HU5qjnLUhNn0O9NZ3xcdb0zk+TM33HDghA8ZH9MqkaiGUL5wBD/6ZdC7bQifilb6vL7aAplvnq1c9ntU5mRJKfjQh/iEpLJaGgx4zVAzi6iU0rttonliKoIbhDiPXipgJZkGBRB719a0ROsWkVMiUgYYnC0Dc+vAoWuOwj14tafi/1yhYH6Z1+TLXYAib16t4QwgZo2dSwEgDQ4LwC0fY63T2igb8zP+G/ZkMtUhLEuVPyzwD2gxrAFCDkBXhxp+Y4JaB6nnUDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QgfxiY6ouYZr9oectUVNkIgYIjCuE3OpxTJX4/7XIxI=;
 b=UmbnHwbpPSA8SCpAFOVURlbBSyOhc0JayiCzo24PLluOlYn1j7aPdee882OEAJZajCXcLB4iXsz7gEv66fmihODzq9myknwVUZdpL3ykrtudnRrv869cMUvKRZEMpjV18nUD37mXU4uZEdoYMgmo4LxdYhI0rv7guE8Wpu/tqA4=
Received: from DM5PR07CA0117.namprd07.prod.outlook.com (2603:10b6:4:ae::46) by
 MW2PR12MB2396.namprd12.prod.outlook.com (2603:10b6:907:9::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4373.20; Thu, 29 Jul 2021 20:37:24 +0000
Received: from DM6NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:ae:cafe::c) by DM5PR07CA0117.outlook.office365.com
 (2603:10b6:4:ae::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.22 via Frontend
 Transport; Thu, 29 Jul 2021 20:37:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT022.mail.protection.outlook.com (10.13.172.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4373.18 via Frontend Transport; Thu, 29 Jul 2021 20:37:24 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Thu, 29 Jul
 2021 15:37:23 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Thu, 29 Jul
 2021 15:37:23 -0500
Received: from elite-desk-aura.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.12 via
 Frontend Transport; Thu, 29 Jul 2021 15:37:22 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 6/9] drm/amd/display: Add check for validating unsupported ODM
 plus MPO case
Date: Thu, 29 Jul 2021 16:37:09 -0400
Message-ID: <20210729203712.1566129-7-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210729203712.1566129-1-aurabindo.pillai@amd.com>
References: <20210729203712.1566129-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 12cd591f-1734-4ac6-f4f2-08d952d0ac1e
X-MS-TrafficTypeDiagnostic: MW2PR12MB2396:
X-Microsoft-Antispam-PRVS: <MW2PR12MB239616018207DF0FE83FDE088BEB9@MW2PR12MB2396.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2E2isjaySiz1eYS/U0dutS/tUKbSo5Tm7IrXOf4CqDmM4p1vw3vxp1dr7lgJviblRf4G5zYX9HWQCGyX2jio7nMG4sdY0OoobWnonLSXnx1OvI8xc/OCyjIfR7Hjk2Yk/pVy2g2sMgVMZPKJ/mYYfip7ry7jLDlpG77xbF96OC1Svl59r1fNX4X/bDJ0kFGg/4QwmWhFy1CJ0J/c0RDEs4ryWK/AGFjmMm2u7aJTewdJFzvsusRYlPX92kvrIhyuA2pcRww9mDL8nltm8MHwng89dJxsPbwolrcwn0Z+6nbqaj582Gu4X+E7X+rAtBvXeEuwaRLQAP4rCj/NXHST7tBH7MGQ2RxtrwdlRT1x4z7FbA6uce2o+Ug6EMUsISlNZm0nhlyzpTfPx4SE9DEP4LnFecjg5h9jpm1kHMm0MDMEZj1cg1N+Op8f4BAz8K/rDeFZ0a/aDkizZ25RfmrCp8vMnpYnU+79Qg/84pvZG9LqfjuYMh+4I4EssqSvqbzUVWjiBNh/3NMiJoJDx7WqYsGPB4ohU7pXTiTVtb6AGL0MT15man92khaOGDO0oJIo1TC/FWTphV1+Tm3FsUodMP5XXoHvjVPtNbiGYTT4nlq2aXjak+QGozuQMqx25UoF3oCaJlMKKTFOIcPMuiXkA8TKzxqPvJNnf4UURp28EdoJ0KmZICxaq2E0coa6Nipd95+eadoukpz4vRKQ2ABBKXVknvbByhUFB8ZjjjaJbhU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(346002)(376002)(136003)(46966006)(36840700001)(6916009)(316002)(82310400003)(2906002)(36756003)(82740400003)(8676002)(44832011)(426003)(8936002)(54906003)(336012)(81166007)(4326008)(2616005)(47076005)(1076003)(26005)(36860700001)(86362001)(478600001)(7696005)(6666004)(5660300002)(70586007)(356005)(70206006)(186003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2021 20:37:24.3001 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 12cd591f-1734-4ac6-f4f2-08d952d0ac1e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2396
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
Cc: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>, Eryk.Brol@amd.com,
 Jaehyun Chung <jaehyun.chung@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com,
 Jaehyun Chung <jaehyum.chung@amd.com>, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jaehyun Chung <jaehyum.chung@amd.com>

[Why]
We do not currently support ODM plus MPO on only one side of the
screen. This unsupported case causes validation calculations to
divide by zero due to invalid viewport values.

[How]
Add stopgap for the validation of ODM plus MPO on one side of
screen case.

Reviewed-by: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Jaehyun Chung <jaehyun.chung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 1596f6b7fed7..f1b8c1292035 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -1051,6 +1051,11 @@ bool resource_build_scaling_params(struct pipe_ctx *pipe_ctx)
 	/* depends on scaling ratios and recout, does not calculate offset yet */
 	calculate_viewport_size(pipe_ctx);
 
+	/* Stopgap for validation of ODM + MPO on one side of screen case */
+	if (pipe_ctx->plane_res.scl_data.viewport.height < 1 ||
+			pipe_ctx->plane_res.scl_data.viewport.width < 1)
+		return false;
+
 	/*
 	 * LB calculations depend on vp size, h/v_active and scaling ratios
 	 * Setting line buffer pixel depth to 24bpp yields banding
-- 
2.32.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
