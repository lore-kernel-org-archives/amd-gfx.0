Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EF0AC04A6A
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Aug 2023 15:09:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A1C6A10E463;
	Wed,  9 Aug 2023 15:09:35 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2058.outbound.protection.outlook.com [40.107.244.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 55CF410E462
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Aug 2023 15:09:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NXVHxWtIM6oZFTq86qlGWqP4aeRKulFHp/cQgxCkBtuazw37QjiwXu92qXkXrF4NCp6J6/CrTNSHXMK/fVFFhThSXuvHi5fnTaB0dOSdVda4l+vPgxTQmjIWAuugE5/jdsZQxeQh5Cz66+8RlE7MPOpEycXIhA95Nq9ZdjxyJya0HWHce2RqQIU2U89JexUrRXPU+kbjrbEyYl3USyXx0TbDZwMWYxjE+AdpmIBRsuLX6x8yWtgdgFVXIsULSGsDeWA40vzqdwBomjbLIsBiI1TLGGDsAZxa3yZdj/6hk5ZjInI9NyEjnCiI+fBxB/7Ab6LbX0b9JwWyvCdK1KhJjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eD+Tw1AJqaobmQ7Yl1W5DGdKHMHtnH7x5Qfpsg3KesU=;
 b=dgEA7DxGXOqwnjEyiv+yl3oS3C6GMJdT3pcSpB8IH4OkO3ikJuPJOtswMHtC0DVmv+fpOd/GarzI09i8GXNZL/NUXmDEqHYUNLTewSoAybHCQP9XNVarJSESmZsKS+q5VTJl57tveNdodoASevUeADE8RtT14jI2rXuwesQceYsNrDX7Ae6BFhJ3kGbtyYmQbsXy/XKyshSlahJBvYdDVhwugNyzyJnPxIoRPL2h6L8PBsJqcmCnJ4H7bZrEuZGCIY2OnkvUcuupiyjMDA/2Y6fK+Jj7IPqaephTMWKkj04xHDbwZY4W39Gpe1L/yVob80UguJWR7kFXM70UtFlNRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eD+Tw1AJqaobmQ7Yl1W5DGdKHMHtnH7x5Qfpsg3KesU=;
 b=3XyL7IGdJmOovLUC/aEZbL5Y6exnarAL/F0Yvjc9tHvHy2OulOpxjHYAu93zLTm8jIEc7VyHy5LPYhiz744fwiOQn7sycRY/irtA5/LkWWRLjOMzPBEJAadRyC9hWWr7wfH/EWej57IslJAYXJ2lSNQq204unrHQSFdtGLblUOs=
Received: from CYZPR05CA0030.namprd05.prod.outlook.com (2603:10b6:930:a3::18)
 by MN2PR12MB4421.namprd12.prod.outlook.com (2603:10b6:208:26c::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.28; Wed, 9 Aug
 2023 15:09:32 +0000
Received: from CY4PEPF0000EE3F.namprd03.prod.outlook.com
 (2603:10b6:930:a3:cafe::9) by CYZPR05CA0030.outlook.office365.com
 (2603:10b6:930:a3::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.18 via Frontend
 Transport; Wed, 9 Aug 2023 15:09:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3F.mail.protection.outlook.com (10.167.242.19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Wed, 9 Aug 2023 15:09:32 +0000
Received: from stylon-EliteDesk.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 9 Aug
 2023 10:09:04 -0500
From: Stylon Wang <stylon.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 15/15] drm/amd/display: Promote DAL to 3.2.247
Date: Wed, 9 Aug 2023 23:05:05 +0800
Message-ID: <20230809150620.1071566-16-stylon.wang@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809150620.1071566-1-stylon.wang@amd.com>
References: <20230809150620.1071566-1-stylon.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3F:EE_|MN2PR12MB4421:EE_
X-MS-Office365-Filtering-Correlation-Id: ce0f9adb-1b5b-4e56-d9fe-08db98eaa2a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZIWO5ajjMJFBV0y/bHneN1ACohfCxT/FwCtmrcB5m2PKzgBdKIv7jeljqAvchNMBQgLidJgR5VhvFDPi6K/lQNqvKicsEgDfV2ftxl1MJw0kwjWatAUf07VCuBP9O3YYKO5AqtwWJtOLCWursN/Gc7FP5KtMajelEwUfjsJtfDDLZhPbf4b3T/6WM25pjw96eI6OCWyhhyH8FxnOmt87w+enJ97mpFZBIcewrunab262n3fBC08r/n0IXECUsi24ofI1hN8/3MJhZPCHQRjh7tphghj9sUTWYSzWM/nBbc7Ram00JaihQpSEigZwUfyv1oelJWPmqBigSlm+ReqW40lSvlCGs9Zx7sU9eL1np9CiHa9iCB4GFS7aPex84ce8fu4g+5TYW20VtSzly/xt5yBp4K4gGx7PZ8JjaxZq0stSG+1L6XNiM87F/g+cyOqC+BY1ivSB4rh9IOgwtUkoDeuoUW7ciq+QYMD64LySzIryKzFASpUME3ocNgaBUJ8WLO3y1WuqEFmG6lGcQWrI7Edv84HQ1gi/KJmLnevW18TMTOAVltABAXXT6+l3iA+67zwC3l191C2Kd9mko5yUx+y/+37BJyTypPsXRbaymI7pPx+hTQLJWCmmiDzmr4uRJF/Y1Ch9GXMKKtc0gPyT92oWsagtyhyWw5c9TsHdtU0g90S/vVkVdrTCJCWcQxOKAxbbkCdGGwhuQkeZitko/h33RhjXCOlIxeXf/388AYAFOENRS/RtVIttDXlqiEz5lVIe5fdh9YSb4v4uW6s++Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(39860400002)(396003)(376002)(136003)(186006)(451199021)(1800799006)(82310400008)(40470700004)(46966006)(36840700001)(36860700001)(2616005)(356005)(478600001)(82740400003)(81166007)(336012)(83380400001)(47076005)(426003)(16526019)(40460700003)(1076003)(26005)(40480700001)(70586007)(70206006)(41300700001)(316002)(8676002)(4744005)(2906002)(4326008)(6916009)(7696005)(8936002)(36756003)(54906003)(5660300002)(86362001)(44832011)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2023 15:09:32.0798 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce0f9adb-1b5b-4e56-d9fe-08db98eaa2a7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4421
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
Cc: stylon.wang@amd.com, Aric Cyr <aric.cyr@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

This version brings along following fixes:
- Improve power saving feature
- Clean up for code clarity
- Fix MST issues in system resume
- Fix crashing bug
- Fix pipe allocation for older ASIC
- Fix for gamut remap
- Fix 8K 60Hz display in test cases
- Fix bug in clock gating
- Improve DP2 compliance

Acked-by: Stylon Wang <stylon.wang@amd.com>
Signed-off-by: Aric Cyr <aric.cyr@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index fc9756ea7cc5..0d0bef8eb331 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -47,7 +47,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.246"
+#define DC_VER "3.2.247"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.41.0

