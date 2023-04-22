Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38A6EC77B61
	for <amd-gfx@archiver.kernel.org>; Sat, 22 Apr 2023 01:36:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E7B210E1C3;
	Sat, 22 Apr 2023 01:36:33 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on20602.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eb2::602])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C5D210E1C3
 for <amd-gfx@lists.freedesktop.org>; Sat, 22 Apr 2023 01:36:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=miGvn9gXUTZYQhs/WSNTawuacalP7eUCHwanWbST+U+Ag4AF2TeDjBa51MhBgeSyp5rSbjpI7dhIulleN24lSowhWsztYYzEWEiDq2+fArVI9gJZV0FJ2+niWnK7qemcpfDCiMHtuxvpDjipaC3oNmsAf5LvwGNRnVy6njvm4vBrh2J6sjdXP5nvWK4S8AHM0avAm5aqccHPzPPsYKmOKC7dwxEWvV9H5parW4ji1VDrIT0Za59C2gW2zncOts1zc5uHuGAUeMHRMFSURHBslRFamBY8thxP3DxKCJ2mKo762WOVbmI3bKJGDWlz62QhsF0daHG2NVOWaumB6X8vXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FJz4o8YBCAaECDG7BRWDM4qnVIOzJCET/RKvvqHVAm4=;
 b=ZYzMDTtQz++RY36Rzj+IM6Mp2uh7ykhFu4eFoMGtm0c4S44L+AfPAfKzGgDGAbKxx7KV5UwAPc+xAqepSJtwoZShSgmLahYjfBaDwiP8A6OTj8FV3YbpSFufdqryosfcTEIfKs0x1XrzLDQGLhd0PxeQrpRtQgyMM44B6OwY5fm1YhUBrR2LeOnArNyP9VGRn7DfGCMOeOP5OyI3WZxQdRA4ljMVvS6LM66RDaKHJb6xBXibLPK0d8ZtTjZXc2SKeKD/gTHQd6FlBgpzkDxNYYAc9rLuoc+4BVtA3kO5aMT7b7xEd6ciPe/dgQ2nKKpMrxFxLJjdC6/MA2nls3tdKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FJz4o8YBCAaECDG7BRWDM4qnVIOzJCET/RKvvqHVAm4=;
 b=5i0xH8mIxUCMWfvJXY+AYsiZjQSfJltWURxjVqhyo47CHyV9MInlBlU1qLUdVr6jd3Ulia0grjFpOHAuKpAcAgSsNEjr83UBT+SMKsGjyu1LznxDhQZH8TyAKfCz34sPEkZffqglkB8N9bK/WW4iyNyS/xqar1VXMlj2iLWbyZU=
Received: from BN9PR03CA0207.namprd03.prod.outlook.com (2603:10b6:408:f9::32)
 by BL0PR12MB5012.namprd12.prod.outlook.com (2603:10b6:208:1ca::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.28; Sat, 22 Apr
 2023 01:36:23 +0000
Received: from BN8NAM11FT115.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f9:cafe::ac) by BN9PR03CA0207.outlook.office365.com
 (2603:10b6:408:f9::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.27 via Frontend
 Transport; Sat, 22 Apr 2023 01:36:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT115.mail.protection.outlook.com (10.13.177.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6340.15 via Frontend Transport; Sat, 22 Apr 2023 01:36:23 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 21 Apr
 2023 20:36:21 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Jerry Zuo <jerry.zuo@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>
Subject: [PATCH] drm/amd/display: DSC passthrough is for DP-HDMI pcon (SST
 pcon).
Date: Sat, 22 Apr 2023 07:06:00 +0530
Message-ID: <20230422013600.553498-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT115:EE_|BL0PR12MB5012:EE_
X-MS-Office365-Filtering-Correlation-Id: b9b1cb01-1f4e-425f-070f-08db42d1fb24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UhSQkvfDw4OfC+SJNeBN/hlcRxjDwmXmTOm0dFgUaZ14hlps+8eXU0DK/Sed77/YkojxLQrKY+e7gpzn5zlZk746Oy3NznppPSRjXhHySnqonBN+kgfnTB7k91MolMJ6qr1xOSVKE/sOqkXka1J/iBTlYENS01UvWJ1ffocfa8NWrVI3q4jXmVe/qNXXCQDv1MCse95HQqOmQqu3rtR4I++76vDu1nkqVCLO1OhkDl9izcqXgnNOCJlVyX+nFdXpPNlYGnXygFP2hSAoe7AaC/t58EbQbHH7vUL1MB/Yx42uJEWYnRnVZxcJtHuAcrATPUNS9brX1Drnv/Eky62p6WGdPDs5YWpObAagNhJVdAPQzuZNVIcYy7EIf1wqOHpnxWzSvrkV0UjqRFqe2JmyyO/vdVs8Ch74rQAo04sAfxaMCZ52tVb5tWKH0lRE0bxpavisA48YrtVYOlO5dU1HdEXkvxfThMeGrGVoc58e24QHsGyiwUbVSTppQjzkeHsuC9BLwVSnqMjzRw7EPwC7aLGhETlph1dm7KmyPDT532jHZ9GcFzsZzohFvFhX8o7o7ZPl/R1vwQ1dWtl0bOS6dfOMlUB5vlQXkscGOFumrNEbzs0t+cI6xN/3SgsvjYkY8ay+WMNZ1l1j7R98kEdpC0uEKMjlXxQyg97NNXxInIKBYkeJb/n7BjijKn7nJ5SFX0Lc3Rs1ReO/RnwEKfFAxwhY3eUCpSV1Tzk9H9jjNp0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(396003)(376002)(39860400002)(136003)(451199021)(36840700001)(46966006)(40470700004)(82310400005)(356005)(82740400003)(81166007)(36756003)(86362001)(40480700001)(40460700003)(7696005)(2906002)(6666004)(186003)(16526019)(2616005)(26005)(1076003)(70206006)(70586007)(316002)(41300700001)(4326008)(478600001)(8936002)(8676002)(44832011)(5660300002)(110136005)(54906003)(6636002)(47076005)(83380400001)(426003)(336012)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2023 01:36:23.1628 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b9b1cb01-1f4e-425f-070f-08db42d1fb24
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT115.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5012
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
Cc: Fangzhi Zuo <Jerry.Zuo@amd.com>,
 Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

if check over DSC passthrough is removed, as this is not for
MST use case. It is for DP-HDMI pcon use case. sst pcon is
detected as sst not mst. In sst pcon dsc passthrough message
will not get below log printed

'Fixes: 8dc5bfdab0ecf ("drm/amd/display: Check & log if receiver supports
MST, DSC & FEC.")'
Suggested-by: Fangzhi Zuo <Jerry.Zuo@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 .../drm/amd/display/dc/link/protocols/link_dp_capability.c   | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
index 84265dc66bba..577f74cc50fb 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
@@ -1820,9 +1820,8 @@ static bool retrieve_link_cap(struct dc_link *link)
 				  str_yes_no(is_fec_supported));
 			DC_LOG_DC("%s: DSC_Basic_Sink_Support: %s\n", __func__,
 				  str_yes_no(is_dsc_basic_supported));
-			if (link->dpcd_caps.is_mst_capable)
-				DC_LOG_DC("%s: DSC_Passthrough_Sink_Support: %s\n", __func__,
-					  str_yes_no(is_dsc_passthrough_supported));
+			DC_LOG_DC("%s: DSC_Passthrough_Sink_Support: %s\n", __func__,
+				  str_yes_no(is_dsc_passthrough_supported));
 		}
 		if (link->dpcd_caps.dongle_type != DISPLAY_DONGLE_NONE) {
 			status = core_link_read_dpcd(
-- 
2.25.1

