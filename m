Return-Path: <SRS0=BT7C=ID=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A68AC433DB
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Mar 2021 20:05:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05C7D650A3
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Mar 2021 20:05:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05C7D650A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD2876EC44;
	Fri,  5 Mar 2021 20:05:21 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2050.outbound.protection.outlook.com [40.107.244.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 702CE6EC4B
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Mar 2021 20:05:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TtpsX7I3usracx5/RsGhzwK2QCxcxJ26MceSNf9OALHZ4OZ+115AKx05ndZ4vPzT4SPC0AjyArIP3vLL/2L4il+jK9XrmReGZEd8/YxHmqW05X/jYDCf/8sM4amUeJuKyi3NDFuQS83D8vON51OMVoyaZkGMQB1UUWTbbP2tW1Bok+y79G8Wp3OtMK68gCUFEnfTTvb1bjOzfF3BDTNim+W5HfMRPEq/uUeqXlsWxFWvtdO4qi7JYfcCJCPQZ58Hkzor0cj/WNnAyDzh0fVXWfQonfkpy3c10Ui1e7RNRA94LI0XFkaswF7gmytBnCDppfamr9+CpbsX3finj0Sxvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2UBnHI4BY5M3DzU5l+XzZGLlzxZyrvFzDprkvmFSvZ0=;
 b=iZeL6Wm4uv9pJcT4CSIwIAm9L6YkYqMWUc6BP52+ghFRmh8ph1zxK7kYiV6BIEI4OhXRIie/Q032Cvdqc+5WgotdP5IF5FL8646ZHjz68fsyPUU6Ni4V/lVTpIEV6X9unczSeYR/p3Na4EG6lr6JRQ+CqFbQP+WsTufmINLk0P4jEAFerby9J+VQNAty07mkvgLg5ieeU4V7h6N7eCgrL7OT7jO0xZ8r944uhGQHFB2+0xmZ641hXBl8Xhcbik3nrBbpqsk9MnovETI1XkVA7gwYmr+6ru6Dab6SgVRYFyIm/nK9hDEHwtOcdKtEBuh7avtI9n2A7hgRmat3L5Im7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2UBnHI4BY5M3DzU5l+XzZGLlzxZyrvFzDprkvmFSvZ0=;
 b=uIdiO7QK9rLmG2KVXrwcK7yLyR2Q8HA4GP2JuKbUyOuzs59gk7+IpdJ61c9MYQh05OGkP1+Hv43NFPKXm6r5nIEuw4aeSp4pIKQW2y0QRGK2H3TavR6NpJlAzZc/ESISutgLoyttdTr/CAHAKh/7cSxDJlSNELmQ5FTHZe00fDA=
Received: from MWHPR10CA0064.namprd10.prod.outlook.com (2603:10b6:300:2c::26)
 by SN6PR12MB4685.namprd12.prod.outlook.com (2603:10b6:805:b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Fri, 5 Mar
 2021 20:05:18 +0000
Received: from CO1NAM11FT043.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:2c:cafe::74) by MWHPR10CA0064.outlook.office365.com
 (2603:10b6:300:2c::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend
 Transport; Fri, 5 Mar 2021 20:05:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB01.amd.com;
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT043.mail.protection.outlook.com (10.13.174.193) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3912.17 via Frontend Transport; Fri, 5 Mar 2021 20:05:17 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Fri, 5 Mar 2021
 14:05:17 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Fri, 5 Mar 2021
 14:05:16 -0600
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.2106.2 via Frontend
 Transport; Fri, 5 Mar 2021 14:05:11 -0600
From: Eryk Brol <eryk.brol@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 14/14] drm/amd/display: Align cursor cache address to 2KB
Date: Fri, 5 Mar 2021 15:03:01 -0500
Message-ID: <20210305200301.17696-15-eryk.brol@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210305200301.17696-1-eryk.brol@amd.com>
References: <20210305200301.17696-1-eryk.brol@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4fa489e7-4dd8-4b75-7e26-08d8e011ff70
X-MS-TrafficTypeDiagnostic: SN6PR12MB4685:
X-Microsoft-Antispam-PRVS: <SN6PR12MB46855A4F265D49F85723BE48E5969@SN6PR12MB4685.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cyxQzHlnc94PFlJPfUG+I+Qw/yFf89Sqwwqt5k037r+3aDHfvkUktm4qengC9KJ0SxdindIr02ZJ0bU0TEkf3LERmYL6YAx0BKEO3iBMqhVtutNXP/V6yhmKpqAymcjaks4ihmaniLSL1QI/f5opH27OA9SzNw2FGTpFDZb+UHt6Sgg6Z0PGlKai7b29DO6J/uRqKmsrG7F5ppI2PwYFzlJwffpJcDpfX5O86Bf4LTDvNe9GKza0/QJ+qRnLp2LPOzsiTZ3EheJ91uQo/Tf2qHe7+6kLRiy/L/TKzSpkm7tRQVk660MUtSM4pxTQ7RaOndUPAy02YjO9mRdJzZw4fGZZRRzfd4x7Vdc7YJTybGvt7sKtBPgEz5MO4SmYVMpUG5FSm4Dy+ZySrhD/bUuhDUO+Aj5QXk1FvcUGxNyjREicIm4Wgoo/cXALFhL8mP354sgbmUz93xUn1g5Aepohg/TpRJBGJ0GTJcqXHGiYV2StyiB3d5+bNJiRDhV6YUMZQ4/HQtfSz0SUO0DjOmJ+VvwMyrECZxFI4uQzG1ntqpQfGUWR4h/Er+ycOMEn2gZLSLgYgoT6lxBFsIerwb3TP0AsZ45vk5EkxV7XPype+NPMNubJbv+bswRy5Nw+MlXQoG+SR5S2nBB+F5IiRMeuH04hxuVJr95US9lE+EWQsDiC/2JiTnggjZ5f9c7UF8vH
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(346002)(396003)(136003)(46966006)(36840700001)(70206006)(82740400003)(82310400003)(70586007)(5660300002)(36860700001)(83380400001)(8676002)(54906003)(356005)(36756003)(6916009)(6666004)(8936002)(81166007)(426003)(44832011)(4326008)(316002)(186003)(26005)(2906002)(336012)(2616005)(47076005)(86362001)(1076003)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2021 20:05:17.5924 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fa489e7-4dd8-4b75-7e26-08d8e011ff70
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT043.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB4685
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
Cc: Joshua Aberback <joshua.aberback@amd.com>, Eryk Brol <eryk.brol@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com,
 Jun Lei <Jun.Lei@amd.com>, Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Joshua Aberback <joshua.aberback@amd.com>

[Why]
The registers for the address of the cursor are aligned to 2KB, so all
cursor surfaces also need to be aligned to 2KB. Currently, the
provided cursor cache surface is not aligned, so we need a workaround
until alignment is enforced by the surface provider.

[How]
 - round up surface address to nearest multiple of 2048
 - current policy is to provide a much bigger cache size than
   necessary,so this operation is safe

Signed-off-by: Joshua Aberback <joshua.aberback@amd.com>
Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Eryk Brol <eryk.brol@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
index c626334e9346..d53f8b39699b 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
@@ -855,7 +855,7 @@ bool dcn30_apply_idle_power_optimizations(struct dc *dc, bool enable)
 
 					cmd.mall.cursor_copy_src.quad_part = cursor_attr.address.quad_part;
 					cmd.mall.cursor_copy_dst.quad_part =
-							plane->address.grph.cursor_cache_addr.quad_part;
+							(plane->address.grph.cursor_cache_addr.quad_part + 2047) & ~2047;
 					cmd.mall.cursor_width = cursor_attr.width;
 					cmd.mall.cursor_height = cursor_attr.height;
 					cmd.mall.cursor_pitch = cursor_attr.pitch;
@@ -865,8 +865,7 @@ bool dcn30_apply_idle_power_optimizations(struct dc *dc, bool enable)
 					dc_dmub_srv_wait_idle(dc->ctx->dmub_srv);
 
 					/* Use copied cursor, and it's okay to not switch back */
-					cursor_attr.address.quad_part =
-							plane->address.grph.cursor_cache_addr.quad_part;
+					cursor_attr.address.quad_part = cmd.mall.cursor_copy_dst.quad_part;
 					dc_stream_set_cursor_attributes(stream, &cursor_attr);
 				}
 
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
