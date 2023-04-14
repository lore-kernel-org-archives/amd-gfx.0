Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1D75C77B71
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Apr 2023 15:54:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2372810EDD6;
	Fri, 14 Apr 2023 15:54:38 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2075.outbound.protection.outlook.com [40.107.93.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0FE0A10EDD2
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Apr 2023 15:54:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fyVXHZW9RwGEnC1Ky4btXfWRdAPAofa5oEjH1pw8KVLoCftZLsL0UVhx23yrJ68qb6t4paMWN3NpKvL3T8BxiJg/Qe3yaVXGCOUzqOeC422TykZCzVhF/ViXJ+Ve6ko4CLwi1E6rSusDGSRyDWhPZh/3PlINBAnkcIVadwmDx0Pb+kWl753ZxuwlcwuSoFnNj1LlX5YQ4K5RY0az6JVGliJhFoSH2cSqo5vZ1kP7ra0VRfInFAOT/uEOq2MuXM0aKvT8aFv61i6p6aJIaQk5ZXfpEV8VVC7+VL23CPwvv/eMb/mIgWRWzQALJRZyz0QyoXJZrKaj62T4nKxV+4iXVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iF2PSD++zZ5oOXmIvIz31uEbUzQPNPcuWF/GDI3ihGI=;
 b=cfcVLhCphk1t86vVPCPY0HxZmyUdxM6I2tHH33y/p3GJihvoLD0DWJdzExbiIXLDcBaqHHbkeCcC/B0uhhbViQsHxYvkaipWlyfSxbRE2J6Mu/skJOacpqWlEGBgqweHBNg5iTfV7Yb4ai853iPHUoP6+SnV+adySaq0/8uxTiJBZcw5Dfu0TiRN5MCssYWbsqgKb5rXD45NMyMLTNnV4BZKRGFr5ia5XlFDZ9l+LhwOOcsXKsR77zRo7L2FOCZfaXY0t8JO8phfbuvCeAfXaMu6sw1ig0cQIt6/iqO6+0Jhw0mOpIu3khK993YajbegI/YuMfbuqhiBdeTEVomiew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iF2PSD++zZ5oOXmIvIz31uEbUzQPNPcuWF/GDI3ihGI=;
 b=v+FPuXyPFJ+LBlaEFsPL4oVBZscpK7vhHp8TkHESBfDinN97oJ39zEn4Z7laxOaIQzpr1lFNt6r28zrAYD0mcdzGzIVQsuDDHd+0RF5iAMBiK/rl406ENfga5Bn6g5thLOUV0Ns0wjDyqBrmU4Q7OIQ/K40hC3QiKbSgdks7Kn0=
Received: from BN0PR04CA0016.namprd04.prod.outlook.com (2603:10b6:408:ee::21)
 by BL1PR12MB5175.namprd12.prod.outlook.com (2603:10b6:208:318::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Fri, 14 Apr
 2023 15:54:26 +0000
Received: from BN8NAM11FT090.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ee:cafe::bd) by BN0PR04CA0016.outlook.office365.com
 (2603:10b6:408:ee::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.36 via Frontend
 Transport; Fri, 14 Apr 2023 15:54:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT090.mail.protection.outlook.com (10.13.177.105) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6298.33 via Frontend Transport; Fri, 14 Apr 2023 15:54:25 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 14 Apr
 2023 10:54:24 -0500
From: Qingqing Zhuo <Qingqing.Zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 26/66] drm/amd/display: DSC policy override when ODM combine
 is forced
Date: Fri, 14 Apr 2023 11:52:50 -0400
Message-ID: <20230414155330.5215-27-Qingqing.Zhuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230414155330.5215-1-Qingqing.Zhuo@amd.com>
References: <20230414155330.5215-1-Qingqing.Zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT090:EE_|BL1PR12MB5175:EE_
X-MS-Office365-Filtering-Correlation-Id: d41b040b-b4d0-4c22-5424-08db3d0085fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1eG0RtqK2N/ZMP6fQ0F9/rQGTCYbTzHe1Gc58pRiVZzYIvJWYwCs08QN8ozM8uJNMyn7MJH66HR6mLNPX7YvbODClr4YrUdeZPnDFHiwcorkLmU03W0z74F8Dm5Cw1HeqoErYu6NNubDvwv7PcM3fNjcaWeKFM6jcrA3o/TV9jFBZn1Ktb0KAzAarsMFFkRL0KW3HJwE9T+22vzIPQcSghS7gkykL9b5LR0T4w/hXuDMz3MoDkIwNAuHA5Dx15ve3vu4IqJJXnlmIreTlemHPrxXJ0QwnQ4O2VeIS7jMPsXcZ9cNfHwB0NDJ/62IXfu/TJOlnTy9Q3e+rcx5FCKMjsMsZHtR/LHlPnDD0AFMf24ZCdCbagFRyAyjtuUO7ldr+2lpryUXp94gimQPjrm0tblGzLQpW9D7WpdlZET4cI+l6++ySMidalCzvqaAl9VKdCIyILgRaqL9aHvQ/NoIOESOm8MosurjfjMqaYfspM/5UQt5voRW5Lm9GkCdDa1/fPCN9U2OMHJl+nKcnUhLRc73pl9iRDobJADOCxGfp3R/Og1N7z4kj1UnrzhFUi7FiVvu3WAqmYxPuQaYocK8eIya+ry1EAbulKzKcszSikWBP4/T2eXXcH47VxOaqr0Rd7vwhnJPjzGqI9s85PZEwFyzDZttQ36GeFJg0vfkNNJXCbjV+05Z98ybCb3duhr9l0uk+S16h8nHYIKyCVJhCo7CgnUnywW5ipWKltv7z3A=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(346002)(376002)(136003)(396003)(451199021)(36840700001)(46966006)(40470700004)(86362001)(8936002)(36860700001)(40460700003)(2906002)(5660300002)(36756003)(316002)(81166007)(8676002)(40480700001)(6916009)(356005)(82310400005)(41300700001)(4326008)(82740400003)(83380400001)(336012)(426003)(70586007)(47076005)(2616005)(70206006)(54906003)(1076003)(26005)(186003)(478600001)(16526019)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2023 15:54:25.9345 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d41b040b-b4d0-4c22-5424-08db3d0085fa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT090.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5175
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Nasir Osman <nasir.osman@amd.com>, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nasir Osman <nasir.osman@amd.com>

[why]
When we force ODM combine with DSC, we lose several
8 bit and 10 bit modes in validation and thus
not able to use HDR. This is due to the number of
horizontal slices used in DSC not properly being
accounted for currently when 2:1 ODM Combine is forced.

[how]
Enforce at least two horizontal slices are used for DSC when
ODM combine is forced.

Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Nasir Osman <nasir.osman@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_dsc.h     |  1 +
 drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c | 10 +++++++++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_dsc.h b/drivers/gpu/drm/amd/display/dc/dc_dsc.h
index 0e92a322c2ed..9491b76d61f5 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dsc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_dsc.h
@@ -58,6 +58,7 @@ struct dc_dsc_config_options {
 	uint32_t dsc_min_slice_height_override;
 	uint32_t max_target_bpp_limit_override_x16;
 	uint32_t slice_height_granularity;
+	uint32_t dsc_force_odm_hslice_override;
 };
 
 bool dc_dsc_parse_dsc_dpcd(const struct dc *dc,
diff --git a/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c b/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c
index 2bdc47615543..b9a05bb025db 100644
--- a/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c
+++ b/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c
@@ -700,7 +700,7 @@ static int inc_num_slices(union dsc_enc_slice_caps slice_caps, int num_slices)
 		}
 	}
 
-	if (new_num_slices == num_slices) // No biger number of slices found
+	if (new_num_slices == num_slices) // No bigger number of slices found
 		new_num_slices++;
 
 	return new_num_slices;
@@ -952,6 +952,13 @@ static bool setup_dsc_config(
 		else
 			is_dsc_possible = false;
 	}
+	// When we force 2:1 ODM, we can't have 1 slice to divide amongst 2 separate DSC instances
+	// need to enforce at minimum 2 horizontal slices
+	if (options->dsc_force_odm_hslice_override) {
+		num_slices_h = fit_num_slices_up(dsc_common_caps.slice_caps, 2);
+		if (num_slices_h == 0)
+			is_dsc_possible = false;
+	}
 
 	if (!is_dsc_possible)
 		goto done;
@@ -1163,6 +1170,7 @@ void dc_dsc_policy_set_disable_dsc_stream_overhead(bool disable)
 void dc_dsc_get_default_config_option(const struct dc *dc, struct dc_dsc_config_options *options)
 {
 	options->dsc_min_slice_height_override = dc->debug.dsc_min_slice_height_override;
+	options->dsc_force_odm_hslice_override = dc->debug.force_odm_combine;
 	options->max_target_bpp_limit_override_x16 = 0;
 	options->slice_height_granularity = 1;
 }
-- 
2.34.1

