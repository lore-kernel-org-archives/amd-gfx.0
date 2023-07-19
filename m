Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3742C001B0
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Jul 2023 18:36:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E00510E4E7;
	Wed, 19 Jul 2023 18:36:25 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2084.outbound.protection.outlook.com [40.107.92.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B130F10E4EB
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Jul 2023 18:36:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cCYc2cB+zH/7tx+wwRLQ6xBVyWU+lntIXTQkeXcMU55hpg1AfQBqL1zVC3RBi8UGfNJdaVXg1P+BP8TjOF6lL0fDrxKMWx7VuCBrRL2IB75rC7FlXLNAnGbL9oDd4GWRM62C/cn6lB0zgoiMShvzwRvvelsoytOV3Fm2kdEmtZdpCZkQ1i+eKMB3qftlwphz8TGAr/YSir29NN7paXYwZx2RnuiaN6BMylyCwnbZgoXaO8r0n7O6SeFNmcACmIYGGCLJPOaag4IBhi9wW7TbNxC169g988VLQwLGqcYz9S/Iuq3Uy2iddYV+rWbV+O/YNeyGp2D9qvpCFHilLWODkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GTNFDH4rqDogG3xTTFef4EDB5M4p27/lUN+88e/i5TY=;
 b=BHyuc+HYua7k4U/68SEIuh52PXz8WaGzhurL+LIQMTukR//5XBZAKs/q74qOug+a89KFnC9QMvfFU0NREDfsO2oAdrckDUG8xhkxBxeUXkh9aM9BO0ySJwkxV/3JpoTrEad4s+P5oo2h7Zi8uuB7E1K4nwwCYZk90C2eGd0VFMn7G/cDt8mUWruuuZBdjrdqfYlQV2swCiTPqtvLN/7xDT6lk0xusiOdY/1P1FgNJzHX8nBwu/dL+bNAIR4bG/b9V/CSwOXWogr5itmlWMv7nh4uvdTd2mMhJrQI4K8epNIfQvSZN7dwYwreJjmn57EA8gUm7xuAMrS8kDIq1geQRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GTNFDH4rqDogG3xTTFef4EDB5M4p27/lUN+88e/i5TY=;
 b=diVqaTVJWBsW5VtsMwCvzedVXgLSiAZIh1BAb+y19YsNA3KKvJgM48UL+x4RZq8CTw/z1K+FH8UKOAiI9e+VfayvTIzSgYFfXBL031MMr+VQgudThzpXvkI/QWynJB6wgksrJGtUXIGcpMRD0DheXrEnyU7sPW/zCkX+Hh+BhvI=
Received: from BN0PR07CA0027.namprd07.prod.outlook.com (2603:10b6:408:141::29)
 by DS0PR12MB7584.namprd12.prod.outlook.com (2603:10b6:8:13b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33; Wed, 19 Jul
 2023 18:36:19 +0000
Received: from BN8NAM11FT075.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:141:cafe::79) by BN0PR07CA0027.outlook.office365.com
 (2603:10b6:408:141::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24 via Frontend
 Transport; Wed, 19 Jul 2023 18:36:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT075.mail.protection.outlook.com (10.13.176.208) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.34 via Frontend Transport; Wed, 19 Jul 2023 18:36:19 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 19 Jul
 2023 13:36:16 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 15/16] drm/amd/display: Fix underflow issue on 175hz timing
Date: Wed, 19 Jul 2023 12:28:05 -0600
Message-ID: <20230719183211.153690-16-alex.hung@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230719183211.153690-1-alex.hung@amd.com>
References: <20230719183211.153690-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT075:EE_|DS0PR12MB7584:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d3ffb1a-0cb7-4879-dcdc-08db88870b3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DBFNx7OODa6r9x+TwUI9dNeLjsDfivYGPFTbMLHyULTAj4WhwxuU4go9jQ9qwdP3CS3urSH3qPtetARFiSc8I1Wu+gVdHE+kg3FrgDR/xq3HX8xT3PB4go+0Y86Fj2PcouywFegVITHV9xSxHGIksEmmGUrzacosdW2h3GxcOb2iuzs2xqEG3npRjCUmLyvBC4uM4mcq+4YPtKwwjK8dZ890G2vGv25djZEp/v6AXnl655FPQSKiyC6M8ze0+BisaP9zHgnO1Ry3emxVVodmwWN9XWrPTdi1wYCtchsZ1c76QrMS1ZZEtICnFgWBH8r6S8+69WXKM8DM4B1VkJxtRJVcCHZQRQ2oF8NgEQ94om8Z0+SRFIh7ZJGctrZpCjeRCa6BQbiXjCw6OMVkDZ0sIfLUzaMAoXYdcASEziIicM9w7Yn4g7qc3yg9/Za/TVpqOa4Mjfw9vTrS4IDbaRA5kt9TCycYY2GMvC2qYBzvRzHrfEAeXXUAkIh6dWALWB5YBan29PKJr7UtLfGCZuI9oJzTClJtJwIuOVExWj9h5Oi9pYt3EXFqbVItS76f8XFEJTXdSM3oT2rlgi6p+t6juGaTxfyH0Q/6/nTKIXGdp0q+CDnRFZa/AH7Ih8Hs5GCkofQqDpPUYr8bLBE513lvNIRLRDqpRbv4tIqQ2cbuWfQCvrvbwSz9WpEl2lGFgYDnpYYxUU5uSkK8RJk4LdCzeM1pfjrBaVVHdWPbb2qlSmyzXssY8sDb+RSdNkS+YNpaDDaUpz3ZURJaXahtjdaczQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(39860400002)(136003)(376002)(346002)(82310400008)(451199021)(36840700001)(46966006)(40470700004)(26005)(356005)(1076003)(81166007)(82740400003)(16526019)(336012)(426003)(2616005)(47076005)(2906002)(186003)(83380400001)(36756003)(36860700001)(44832011)(5660300002)(478600001)(54906003)(40460700003)(7696005)(86362001)(6666004)(41300700001)(70586007)(8676002)(8936002)(6916009)(316002)(70206006)(4326008)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2023 18:36:19.2957 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d3ffb1a-0cb7-4879-dcdc-08db88870b3a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT075.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7584
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
Cc: stylon.wang@amd.com, Dillon Varone <dillon.varone@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, Alex Hung <alex.hung@amd.com>, wayne.lin@amd.com,
 Leo Ma <hanghong.ma@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Leo Ma <hanghong.ma@amd.com>

[Why]
Screen underflows happen on 175hz timing for 3 plane overlay case.

[How]
Based on dst y prefetch value clamp to equ or oto for bandwidth
calculation.

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Leo Ma <hanghong.ma@amd.com>
---
 .../amd/display/dc/dml/dcn32/display_mode_vba_util_32.c    | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
index 890797ecf0f9..ecea008f19d3 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
@@ -3459,6 +3459,7 @@ bool dml32_CalculatePrefetchSchedule(
 	double TimeForFetchingMetaPTE = 0;
 	double TimeForFetchingRowInVBlank = 0;
 	double LinesToRequestPrefetchPixelData = 0;
+	double LinesForPrefetchBandwidth = 0;
 	unsigned int HostVMDynamicLevelsTrips;
 	double  trip_to_mem;
 	double  Tvm_trips;
@@ -3888,11 +3889,15 @@ bool dml32_CalculatePrefetchSchedule(
 			TimeForFetchingMetaPTE = Tvm_oto;
 			TimeForFetchingRowInVBlank = Tr0_oto;
 			*PrefetchBandwidth = prefetch_bw_oto;
+			/* Clamp to oto for bandwidth calculation */
+			LinesForPrefetchBandwidth = dst_y_prefetch_oto;
 		} else {
 			*DestinationLinesForPrefetch = dst_y_prefetch_equ;
 			TimeForFetchingMetaPTE = Tvm_equ;
 			TimeForFetchingRowInVBlank = Tr0_equ;
 			*PrefetchBandwidth = prefetch_bw_equ;
+			/* Clamp to equ for bandwidth calculation */
+			LinesForPrefetchBandwidth = dst_y_prefetch_equ;
 		}
 
 		*DestinationLinesToRequestVMInVBlank = dml_ceil(4.0 * TimeForFetchingMetaPTE / LineTime, 1.0) / 4.0;
@@ -3900,7 +3905,7 @@ bool dml32_CalculatePrefetchSchedule(
 		*DestinationLinesToRequestRowInVBlank =
 				dml_ceil(4.0 * TimeForFetchingRowInVBlank / LineTime, 1.0) / 4.0;
 
-		LinesToRequestPrefetchPixelData = *DestinationLinesForPrefetch -
+		LinesToRequestPrefetchPixelData = LinesForPrefetchBandwidth -
 				*DestinationLinesToRequestVMInVBlank - 2 * *DestinationLinesToRequestRowInVBlank;
 
 #ifdef __DML_VBA_DEBUG__
-- 
2.41.0

