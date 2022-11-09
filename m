Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C99BEC433FE
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Nov 2022 06:19:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 19F4D10E591;
	Wed,  9 Nov 2022 06:19:00 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2055.outbound.protection.outlook.com [40.107.220.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BBA8010E591
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Nov 2022 06:18:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mo/C5CR4avk23S7vOxtFS85Y2mS6vxAAaGg98fqQU4F6lgNfSuM6PGl7delhxl1gC589UMetbfhW3P5gwP4lgiV1mOUeJrVTUU0WD2gDdrkIeAy0uwndmgesGe+YwWyqa91rkNP0/588nkjjuUly3X5QJZvXJe0BIhZKhypz0r4wEOk7SfEC27uexwFXSINkENO8Oy3hXbJzX7zERi8DqpbOwVdTemFCLDOHo3mzoEsVh+E6ePNouqmWxjrOaqRH7n/AicEtNHcu1Kmg4nvqbJF0+pbff+PY+Qgax0xuOM7aGQGLm86moH490Xg80YzZaWOXABDjYDnm0dcXvgwpiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sDuTvWImsnlxUrt78Nyt1X1jUA9nHgD+UOEkZkxQV9k=;
 b=f/85bfJM1ed1kXvSXmTOySTcGnXrJW0Rij18lWmgvSlSUjF5R2VRpDyoiD0vwkSRY8WyJJIJiusaPUDxNeiqqrhkbeTqb2yYuARna3ffmFPjoBpVhVKZgXPnqnEZZ1nmdV7YeAoY4kHHRJyuZJccVIKRDXtGWs6q7+aMUI78XkCP4eF3wdTHX7AronqdSjUQuwy4tsEy/yLl/oFEDoNvBSZSXCrbyxMYuz+GQvYLhALWij/4oSgAd8Bz70/xrZAPtK67O4OZ0MBd1wO2hjj+pbd9jf/jfyvmqomDXMHKPPh7kN/W1o2c4xvK7hOhLzaoS3/0SqfRI0SBWuNOFnUFZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sDuTvWImsnlxUrt78Nyt1X1jUA9nHgD+UOEkZkxQV9k=;
 b=Ms0J24k64b/BX7iTXl5D/b9HdCh89U1N8oQNfRYl+IBdrw+/FI5Ijz48+A8ncCST8zULiBbQvYVGcDCGMuNnblOVqTpxygv4ZSJSJfPThuoB8x9Tk+7ayyC5nN9iUKNCAupbQx1oOODsUB9m7HHIY6kfXQ7ibYoeQ+FZPglMjRw=
Received: from MW4PR04CA0282.namprd04.prod.outlook.com (2603:10b6:303:89::17)
 by LV2PR12MB5821.namprd12.prod.outlook.com (2603:10b6:408:17a::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Wed, 9 Nov
 2022 06:18:53 +0000
Received: from CO1NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:89:cafe::3d) by MW4PR04CA0282.outlook.office365.com
 (2603:10b6:303:89::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27 via Frontend
 Transport; Wed, 9 Nov 2022 06:18:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT028.mail.protection.outlook.com (10.13.175.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5813.12 via Frontend Transport; Wed, 9 Nov 2022 06:18:52 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 9 Nov
 2022 00:18:46 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 8 Nov
 2022 22:18:29 -0800
Received: from tom-HP.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.31 via Frontend
 Transport; Wed, 9 Nov 2022 00:18:24 -0600
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 29/29] drm/amd/display: 3.2.212
Date: Wed, 9 Nov 2022 14:13:19 +0800
Message-ID: <20221109061319.2870943-30-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221109061319.2870943-1-chiahsuan.chung@amd.com>
References: <20221109061319.2870943-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT028:EE_|LV2PR12MB5821:EE_
X-MS-Office365-Filtering-Correlation-Id: c2dd598b-0f23-4d7c-8738-08dac21a45e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QRqXkxJsEVkfcht4Nj7tijjQUnWBnA7mVFdjHGuEHOO9L73CbmRqJBh/uOLy9yJ10F87DpWkYtnr2pIM3JMUIx69TaE4w81ptAF7hF7YNNNFJL2Sx3bWMfRSwBcQcKXVPQhg2eXGKteb7AJxVTqqv0bGtOuOvIdZfpbpWiOjH3ZvQtut7koYBpwBRjyTHtSNxBhTOrqIQfBrSijKCgv5CGL1UtFxkgSTBqYeZtdaGqm0Uo9UBS7cxa0DHDkIHkl7NxsQITx06Z1uQP2ELlfz9fWKy/RGhSNKUS4gj+LnEq2rA5qX3ds84r656tooOh/Blbzj4Hl9qWT5T9gbV7i4M/tgRqaMjS5/WIxxQbAv1d6ZrSBwCRCMmqKVmXjq2OXxO5AVOhchu0znN6Qi72tWcq3FoQc9AX8IOi53mvbO04b3Tikahn4r29AoQ6wrVRoZkRT000ReHXgy4nm/ZyWFfkAPVlZDdE0DY41sxRKN8L04sNUJgm75Wby5/qy2j6IF4+qZmPr27vjm5Pm8Dv9rs+5KdR6/xc77qJNZwb9iP8aG0KNICTEXScopBlpNPf47j/XyifvEIscPWdl9PUaB133W2PIYRjoIrHT96L88iUwApKc25OqpTKId4EnYy5r6oSuN3MbhmlKQzqTe2hf+8vPZD4B4Oj9FrlK59jMVhPHaY+g5uhiCIuYSsG9IjrgEYZD0Hf2xOgsI7EaMuLgfCCuMXOrbkrKUQrKkanSme1s3HpnUXuViEzAE4qEMcyuA/Onn+lkn9j3HFWH7yS4i9xXVm8uhGoGrwu6ghT/4F3qPbGiGfyR82GMdWeeoRCcJ
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(136003)(346002)(39860400002)(376002)(451199015)(40470700004)(36840700001)(46966006)(47076005)(1076003)(426003)(336012)(2616005)(7696005)(6666004)(36860700001)(186003)(83380400001)(82310400005)(2906002)(40480700001)(26005)(40460700003)(8936002)(316002)(54906003)(6916009)(41300700001)(5660300002)(70586007)(478600001)(70206006)(4326008)(8676002)(86362001)(81166007)(36756003)(356005)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2022 06:18:52.2130 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c2dd598b-0f23-4d7c-8738-08dac21a45e1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5821
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
Cc: stylon.wang@amd.com, Aric Cyr <Aric.Cyr@amd.com>,
 Tom Chung <chiahsuan.chung@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <Aric.Cyr@amd.com>

DC version 3.2.212 brings along the following fixes:

- Fix DPIA AUX timeout issue
- Add HUBP surface flip interrupt handler
- Fix dpms_off issue when disabling bios mode
- Update SubVP Visual Confirm
- Program pipes for ODM when removing planes
- Use min transition for all SubVP plane add/remove
- Support parsing VRAM info v3.0 from VBIOS
- Enable dchub request limit for NV32
- Workaround to increase phantom pipe vactive in pipesplit
- Fix dcn3.1x mode validation on high bandwidth config
- Check context constructed for pipe split flags after pipesplit
- Align phantom pipe dst/src scaling with main for subvp
- Fix calculation for cursor CAB allocation
- Fix unbounded requesting for high pixel rate modes on dcn315
- Revert Disable DRR actions during state commit
- Fix array index out of bound error in bios parser
- Fix optc2_configure warning on dcn314
- Fix Subvp phantom pipe transition
- Fix prefetch calculations for dcn32
- Use uclk pstate latency for fw assisted mclk validation dcn32
- Set max for prefetch lines on dcn32
- Rework macros for DWB register access
- Adjust DP 8b10b LT exit behavior

Reviewed-by: Tom Chung <chiahsuan.chung@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Aric Cyr <Aric.Cyr@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 009dab94310e..b02d1f3d3e7c 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -47,7 +47,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.211"
+#define DC_VER "3.2.212"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.25.1

