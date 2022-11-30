Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 236ADC433FE
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Nov 2022 06:39:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B94E10E294;
	Wed, 30 Nov 2022 06:39:54 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2043.outbound.protection.outlook.com [40.107.243.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 65BB310E293
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Nov 2022 06:39:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R2xAcAB/EYufCD7bYTcAuapY9C7U3eKQRJkJpbRPcSo5KLI5bUR8nBY/HRQsd2JKaV/LQ3yXNCk3KEnv5ykafIVk96zZt46ZpKYscdHPf01ZxyEtYeGZ0QEAjQU1esSGnZayASBZ7hVG0LmdgCBezFC5A5pb7HpjFbRSXPmdYBjvRBvLAtAwbKs7Sue04ngWS0r+jNxShbOjUf8f6AeJbOeipqIi0D5x0xuHM+5T06cKBpr8ajymhJ+CZB7ePVWExNynrZN3dKbnFlL73fRGpzlQY984yIlCQMrD2MISEWYgYnAKqLJptsJQYQBmBAV/OUNOo2+gdtfA3O3+gQiIiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a2H2L6aaUwNzUyGcyH8jmfbFrp3nhtzDVHVyadakmSA=;
 b=FsGPwmdevUKhm/Tc4QFI5fi4swew3UMiNXSZR/y6n4BUM1vQ3WnPIfr5uLvDc1LkpF1S9eX9mwgH0KO4MZ/i4o2kdfeFMOUVbt+tsJfegyADRaQ9XG7QjoFYWgUrgMQ+pMTPSILP/5OroI+sgLVBZatJVup3H1NTU8GJTnapZk//sW6lbsW5D1Uxfgy9WUDqhJqRHmGtlxzuebkOg4H5734fJOkodzNtBt2xIngpyxQdtwsXbHEaIQPBiAVkPT3TrZblm5nub5N7oZI7lFdgwijhldDSgul7jWUfwODsq4PlL33TmxIl5oYgLxUcYf53KRVlPg0mGt3hq0olXDP1Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a2H2L6aaUwNzUyGcyH8jmfbFrp3nhtzDVHVyadakmSA=;
 b=U5JLh35dMWdVYQ9X0cs4Wfifzufm0bf2Z1O9dJ7ZlBrV3PoFcMtes+rh5cGWMv7lH2hElXuvMWjrMz960SRk7lMIXAdwkARRj696p2x2ql1EgvLbMR6j8ywSDec0nvzOfK91rirHuw27usGm/K0aOqQg4d2zlk08OJXQM6NuyFc=
Received: from BN9PR03CA0406.namprd03.prod.outlook.com (2603:10b6:408:111::21)
 by BY5PR12MB4164.namprd12.prod.outlook.com (2603:10b6:a03:207::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Wed, 30 Nov
 2022 06:39:45 +0000
Received: from BN8NAM11FT087.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:111:cafe::dc) by BN9PR03CA0406.outlook.office365.com
 (2603:10b6:408:111::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23 via Frontend
 Transport; Wed, 30 Nov 2022 06:39:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT087.mail.protection.outlook.com (10.13.177.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5857.18 via Frontend Transport; Wed, 30 Nov 2022 06:39:45 +0000
Received: from stylon-EliteDesk.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 30 Nov
 2022 00:39:41 -0600
From: Stylon Wang <stylon.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 07/14] drm/amd/display: Bypass DET swath fill check for max
 clocks
Date: Wed, 30 Nov 2022 14:36:20 +0800
Message-ID: <20221130063627.2398341-8-stylon.wang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221130063627.2398341-1-stylon.wang@amd.com>
References: <20221130063627.2398341-1-stylon.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT087:EE_|BY5PR12MB4164:EE_
X-MS-Office365-Filtering-Correlation-Id: 65f285fb-8a93-4d95-c6e9-08dad29dab42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /ah0iDzxCtZc1YNjZ4rytTCXGLLGFkMd90nmhtfgB4IplJkSddpwfPx355VrXVltRo3oS5No1woprJElOrYGNZoFGM6ebRTM0RTAG4rdS7UQtFOAtDnY5mdTaW71TLpwctBp0VS5rm4nX0x0HUTn1Kv6tZIa6isHdteKtpCPInJHnjDXIy1qICE8alZ1X7SzYjRo2pboYgyyOg4LWv+MBma6i9GVD7xUa97Hr2GGF2HTJ13KlCQiYv5OK/tvGqGVXvT9hukwZeXdSRYbNmk5gLfqSPC8PkWvJXbDokbxevuwF0c2Ruv1PZpFFqeIDKtHNUmdHGCrcXiYTRg1SN+LFA5Y0ND6L/+fG+hqIUEYxif+UdFjzENQsPpLGr/9qLZAdKWmLxfl9NdJ7Py4Z1HRD1NcQqDDE7Y22lPnHBfYyD/81VfIRJMskZ7GDd8tAr+yJAC3r1E/Gna5JJN+612b9RWXvn23De6oYOivKc+YrJ6Gx44n15YxTXaHqz7t1pcn/rFLgGJmb1re4OfKfFbFFHXHcStLZVN9mf8diI+5LB+S9Guu9lQPOOcVAe6oT6r8tCIpzttuZL7SZ1wqYNWzcpw52AVdJJeQMZgizRw3qUtAVFy4IZwCE3VPEjh+fkyf1TpFNurNiDkpFMdg/3Oj6jsB9D8V4Wu7ciDkMO3aHEPSJXwzTwVJX0AqrzC9qBb5/cbqCFyq23pznjteJX1PnupfHHt1ZhP8kwL2C/R7Hf8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(136003)(346002)(396003)(39860400002)(451199015)(46966006)(36840700001)(40470700004)(47076005)(5660300002)(426003)(44832011)(8936002)(40480700001)(316002)(54906003)(40460700003)(82740400003)(41300700001)(336012)(2616005)(36756003)(1076003)(82310400005)(186003)(70206006)(8676002)(4326008)(16526019)(356005)(26005)(81166007)(70586007)(2906002)(6916009)(83380400001)(86362001)(36860700001)(7696005)(478600001)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2022 06:39:45.0856 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 65f285fb-8a93-4d95-c6e9-08dad29dab42
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT087.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4164
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
Cc: stylon.wang@amd.com, Dillon Varone <Dillon.Varone@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, Alvin Lee <Alvin.Lee2@amd.com>, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Dillon Varone <Dillon.Varone@amd.com>

[Description]
If validating for max voltage level (therefore max clocks) always pass over
the DET swath fill latency hiding check.

Reviewed-by: Alvin Lee <Alvin.Lee2@amd.com>
Acked-by: Stylon Wang <stylon.wang@amd.com>
Signed-off-by: Dillon Varone <Dillon.Varone@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
index 820042f6aaca..4b8f5fa0f0ad 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
@@ -1683,8 +1683,9 @@ static void mode_support_configuration(struct vba_vars_st *v,
 				&& mode_lib->vba.PTEBufferSizeNotExceeded[i][j] == true
 				&& mode_lib->vba.DCCMetaBufferSizeNotExceeded[i][j] == true
 				&& mode_lib->vba.NonsupportedDSCInputBPC == false
-				&& mode_lib->vba.NotEnoughDETSwathFillLatencyHidingPerState[i][j] == false
 				&& !mode_lib->vba.ExceededMALLSize
+				&& (mode_lib->vba.NotEnoughDETSwathFillLatencyHidingPerState[i][j] == false
+				|| i == v->soc.num_states - 1)
 				&& ((mode_lib->vba.HostVMEnable == false
 				&& !mode_lib->vba.ImmediateFlipRequiredFinal)
 				|| mode_lib->vba.ImmediateFlipSupportedForState[i][j])
-- 
2.25.1

