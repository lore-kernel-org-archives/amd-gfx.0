Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B8DBC433EF
	for <amd-gfx@archiver.kernel.org>; Sat, 16 Jul 2022 14:43:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1744811295F;
	Sat, 16 Jul 2022 14:37:11 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5741D10E1EA
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Jul 2022 18:17:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OkXDq4iMSNGS55opCnnqbhUwYnX7Vput0QoTdJDsNgesh4Y+X+w060MxzwV1pNZzlhl6wlPclgSJxWzs49vfgOjDUQMaL2gjRFU8UNWPyVRSgoRV0NTbGZ0/+X11qWJyG6N94wrq4kKzcPuMHIDU/zC2rx0n2z6DWkJcEIoRJ3Zx6hYDm3EZExjSTlH3GjM5AQtbI2kXq0M3qcNDfJUYG+5ygOT3xgUSG/gjzi/hrUcYyMBDY8H5WUkBVTjMVIdMNv6EA3OieMkm7yzHkfx11IRl+d7fM5+weYuO/NHgj/83P2VcSMD6B9Ws7weBGFsVE9AYZkI/LJMQfIIP4Wi4Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wxh/6qAPgtNUsMeoerHHmWH3j0J2P6S2ofkOfL4Hjd4=;
 b=RF50RFVC9Yx6Nv9ObLUyKXjSjvQF/rlsqA6W3BOy2ATIFx+WkasokkN/JVTJZyQFAjemCDH616MYP7cXHZGDSUK9X/a7wXlur/IU3bClf/UXBfdzwGzeU3iNyOLQHaDSKCUiTUDw0oyQRRdJmNTFzr31B4bFfE7x0cpHuSL57I9Z789Bp+3fyyNWhEaMP5nEgegjocv6jLFF0zxE33nEl0dCOQpZKHxTd5PLy0HkjS4DLt7VucvtIGx+7NLcKAtk3PTgXWcvLJM1xCqqRRcNe7M7Wp7paR/kN5svK3AOKAnMCCagSwOnPy5jkigJM5AL48d4YVvkMQudmOJbdo5dLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wxh/6qAPgtNUsMeoerHHmWH3j0J2P6S2ofkOfL4Hjd4=;
 b=GQTOVzW22fwp3VM3/xtfhlxkYblmfcQfWfV673IXXzz1MQJodJQJcwkSeRa27blrr5wUxtDWxoei3aN7RKw/tYOs86I5/vwxnWgOoMJ+EU+lhg8vZP9JPtWUn6LOij3p0hpWFbwal46m+vzNMWVLNFf+5At/iZDnH73potJNj9E=
Received: from MW4PR03CA0149.namprd03.prod.outlook.com (2603:10b6:303:8c::34)
 by BYAPR12MB2773.namprd12.prod.outlook.com (2603:10b6:a03:72::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Fri, 15 Jul
 2022 18:17:42 +0000
Received: from CO1NAM11FT059.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8c:cafe::c7) by MW4PR03CA0149.outlook.office365.com
 (2603:10b6:303:8c::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20 via Frontend
 Transport; Fri, 15 Jul 2022 18:17:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT059.mail.protection.outlook.com (10.13.174.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5438.12 via Frontend Transport; Fri, 15 Jul 2022 18:17:42 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 15 Jul
 2022 13:17:38 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 15 Jul
 2022 11:17:38 -0700
Received: from arch-sec.hitronhub.home (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.28 via
 Frontend Transport; Fri, 15 Jul 2022 13:17:37 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 10/31] drm/amd/display: remove number of DSC slices override
 in DML
Date: Fri, 15 Jul 2022 14:16:44 -0400
Message-ID: <20220715181705.1030401-11-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220715181705.1030401-1-Rodrigo.Siqueira@amd.com>
References: <20220715181705.1030401-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 65479c91-e2d2-48c1-16d4-08da668e4eef
X-MS-TrafficTypeDiagnostic: BYAPR12MB2773:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NbSMZ8y8SW/8cNQ8fp4BM33rtlKsBNvJAFraU3MNTkajrEu+4Dt94A+mvbxYzcHneNQdnzqqA/4qoAIWwdbEKDvtJzIl168yXBGcqT45+tspVouwZLjsJ222oZysBxBHHuSOE7mtKmF3YLxn7uSv3GHy88h5w6QMFOL/GXBcZODjZR3D+mSzLc/AdiwmElGGqSyNsmlgG+mt5QapmDDDTNGTjq+QlMFC3I1V7wb8r4oDwhXn3Etd0B2DsmY1PeHzhnyRpYaniyBnvx4S6ozlykt/Piz+KNkghn0nuW2MNXromUMEo9o48bKA7rn/IjS3xuoDlEVhF3SpkMO2NZg3p9D3COq+dlAoJJM9wyhZUdDE7xSF846nkwvEVmVGU7cQ5/Uf6CxLW73Xl4rChh9kHwOhKoimdIId61o0EythufSV/TVuMShXlBPrveoIb8Itw3IwvaNshyPW/4eX448iBdWGR+p9yD4ESZpu/+FBwxAt9Yw/jIGCAR1/omFVAmuD0yinEpKREF7uHVAjnTp4yh8lxdUNf5OBAPYOvmhDEW2i6CYbRO4Pue1Lr1ff2hi8nkwBTGDHq/SNDFEdC5Z12s0MUWC7SLEtC8Iy1bYmcSGDePQRZiGZ3RoqIvE/sjSgFXv2Nqugaz123LBs5TV8r6xbQ93HbdSIqNgT/xCPj4TUaeh4TvaOARKAjCt8iiLT3GlnS0Wi2yyEoyZlcn8CfAink6HCY2ZZvPeNcMEETpoT1GpidWA3VjnZ5/G60jn2yjKx6aUlQ/oaeleDxMiGGr6+vS4XJSetCF8ztGoayNT02tX3m3jOUW+oL57od1wTyC1z6zZHsnEEzP1lxf6XdUr1Mgj2EilqcVSj0+HmKBIfuSycXtHYOYjeKs/bBlaD
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(376002)(39860400002)(396003)(136003)(40470700004)(46966006)(36840700001)(82310400005)(36860700001)(1076003)(41300700001)(6916009)(336012)(426003)(26005)(6666004)(4326008)(186003)(5660300002)(54906003)(2616005)(8676002)(2906002)(478600001)(70206006)(81166007)(47076005)(70586007)(40480700001)(86362001)(316002)(36756003)(356005)(8936002)(82740400003)(40460700003)(83380400001)(36900700001)(44824005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2022 18:17:42.0152 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 65479c91-e2d2-48c1-16d4-08da668e4eef
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT059.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2773
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
Cc: stylon.wang@amd.com, Alan Liu <HaoPing.Liu@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, Wenjing Liu <wenjing.liu@amd.com>, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, Alvin Lee <Alvin.Lee2@amd.com>, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wenjing Liu <wenjing.liu@amd.com>

[why]
Number of DSC slices is an input to DML with high dependency
on display specific capability. This isn't something DML can decide
on its own. DML has to use the original number of DSC slices input
to DML during validation without modification. Otherwise the
computed DSC delay will not reflect the current configuration
and therefore causes validation failures.

[how]
Remove DML override for number of DSC slices parameter.

Reviewed-by: Alvin Lee <Alvin.Lee2@amd.com>
Acked-by: Alan Liu <HaoPing.Liu@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
---
 .../dc/dml/dcn32/display_mode_vba_32.c        | 20 -------------------
 1 file changed, 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
index c6c3a9e6731a..1712843dafaa 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
@@ -1897,26 +1897,6 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 				v->MaximumSwathWidthInLineBufferChroma);
 	}
 
-	/*Number Of DSC Slices*/
-	for (k = 0; k < mode_lib->vba.NumberOfActiveSurfaces; ++k) {
-		if (mode_lib->vba.BlendingAndTiming[k] == k) {
-			if (mode_lib->vba.PixelClockBackEnd[k] > 4800) {
-				mode_lib->vba.NumberOfDSCSlices[k] = dml_ceil(mode_lib->vba.PixelClockBackEnd[k] / 600,
-						4);
-			} else if (mode_lib->vba.PixelClockBackEnd[k] > 2400) {
-				mode_lib->vba.NumberOfDSCSlices[k] = 8;
-			} else if (mode_lib->vba.PixelClockBackEnd[k] > 1200) {
-				mode_lib->vba.NumberOfDSCSlices[k] = 4;
-			} else if (mode_lib->vba.PixelClockBackEnd[k] > 340) {
-				mode_lib->vba.NumberOfDSCSlices[k] = 2;
-			} else {
-				mode_lib->vba.NumberOfDSCSlices[k] = 1;
-			}
-		} else {
-			mode_lib->vba.NumberOfDSCSlices[k] = 0;
-		}
-	}
-
 	dml32_CalculateSwathAndDETConfiguration(
 			mode_lib->vba.DETSizeOverride,
 			mode_lib->vba.UsesMALLForPStateChange,
-- 
2.37.0

