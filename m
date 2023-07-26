Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FC56C0015E
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Jul 2023 19:32:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D11C210E4A9;
	Wed, 26 Jul 2023 19:32:02 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2067.outbound.protection.outlook.com [40.107.92.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C47F310E4A9
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Jul 2023 19:32:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fis2GLYrFjamjGd7JC3Q8gsxiZBbqT7M15YORybf3HBacefDpT1aGIBUL2/ZUbUDmN26rc2Xue8R6scbWrD/ByISmagFIf7q7ibzR/FcxVbi4dSsaOp6s1/X8Fe+Oa32qwXrGiHliydAo3Q6oeelwXqHilCAB3pw80P5IDOvq9LK+ZoQqY8qXiUE148vOlMo3khr7siAPqq5fSmXzSwLPsLM3IK49RMOJhVdMGrnb1gBwNV/mNZNFhoO8A478oKroNbCpMHFWHu9L+6K3PaDePGc/q+y0SB3R9gsyuwF6jKCUsOA8yAadcDP9uIgaa++JDCq2Vh2Okc67EdAg732cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E6hHyChh/DhZTgCoM9TFwUf65m74BkrjPBUDmSJDRP8=;
 b=VRSFZBH9xYux6K9+vDIMVx32ThDqjMQohxaTRV8OjBN+b3TBP8WtImPP6/OOgK48R/0WRd4SoFhtv3YNFFd3G8x/CP+iBE+Agtl34RTkhxMSmlIaOxAuLzmjFlFCDY+d7csh8gsH34q7xXMZgmNrtJ6c8o4FatMGTwZSXKl2IewmCTG32cwlOXTKCXEUSE6ZX29pmYW8oFATYe9p9Zk/tRDY4+GbHHXqDsV7oIUwrlYCxeidmdDAgKFlLkT48ogWY4U3Ncd/4/v8wWTHAU4NHEkpmhwIB8XhNT3LgxdC+drrFmaQbd7h4LfYi2sJym2iMSLCNGGpxJ6Fo2HZ8M48lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E6hHyChh/DhZTgCoM9TFwUf65m74BkrjPBUDmSJDRP8=;
 b=NtpjBa678FVCSqgEi7WhB1mq+WLcDHtaO1/FkGjQSAo7XAbZ6RyOZUoH9NmXm+S0p0DC3EZq9kR/60xVq3bdlPwQQEOy9RsrS9hqRgUJMBFnIW7A2cLGOIuLL6CrnH6+ZSMaF5xMQjdfBAyYZtqLsr2Pet5x5mCGOzgacZF6sQA=
Received: from BN0PR10CA0018.namprd10.prod.outlook.com (2603:10b6:408:143::29)
 by CYYPR12MB9013.namprd12.prod.outlook.com (2603:10b6:930:c2::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.25; Wed, 26 Jul
 2023 19:31:57 +0000
Received: from BN8NAM11FT045.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:143:cafe::5b) by BN0PR10CA0018.outlook.office365.com
 (2603:10b6:408:143::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29 via Frontend
 Transport; Wed, 26 Jul 2023 19:31:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT045.mail.protection.outlook.com (10.13.177.47) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.29 via Frontend Transport; Wed, 26 Jul 2023 19:31:56 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 26 Jul
 2023 14:31:56 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 26 Jul
 2023 12:31:56 -0700
Received: from fedaura-ryzen.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Wed, 26 Jul 2023 14:31:55 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 0/7] DC Patches for July 31, 2023
Date: Wed, 26 Jul 2023 15:27:39 -0400
Message-ID: <20230726193155.2525270-1-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT045:EE_|CYYPR12MB9013:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f5bfd13-2165-4469-e775-08db8e0ef974
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6O8VkZjQAprf5c0TGGmGa1ebyRh1UhbdH9mLmpN+jeHlNBKX22btB7gHQAaRhC+Ke63GowvhfrGOCFoIPZKfx18+zA2Cy4gH9iCsKk7W3ENxHfG6AjPSseXOnqrcdgZAcmiMSQjxF6iV2CXRHfAEdWgnBpKl3sOTKHpYLMnIoxVBj7g9YAOgn+feWEvlIeNjqRLfx6XCPw9GYXCC4I3IehVGfDjOUeO7+3ANI8vRXXGZh3v1mI4J8U2PMqC/t4+qL3PsuNoHPw6mlZqa6cIrsCgsfU1i2ZELXHTwlMOeOsmvcESgDbmRl62hvggPCfErjEMoTN12/apLm4s3MtTOoU6COjDimwUk2GrFYCR3JjUEeau+0405gGsZUKN9Vx55xfG23MxcejrFxoeoxJhGsL5+UV4khMIm5NAjvFAwlVRiXQAkHT+coNOd4Jm1gEM274bJ8HddVTxkFyOd1L+ayp0EBuFdJRX8luP7TkxOLIjb6dNg8a8X7preKp8kA3vNAwSip6zeuXMLJElLDBbtHhp+Bo/R0/yCjRxOvxIk4ySQh5OIL28yTAFbR1nrSQonKegkX47YLBMkjz9AOHeDEkDM2Mayj/ABwMeSJ80PmBEfX+jjIiUXtP1jwhxcRH2zd+i1B8gGtLqHq8GtwVtIwNBk+sWDs1wtf4eow6ZJ17WARnLGfc/HOrL5hhIU4T1lJDxsfZB1GBNyfLfp6n1ZXvnFsz+mcgf/E5UmzPDvhWxtOMnWGIBob8SROAiDIXw3Y7YmzjlPVVFlkFd7wSZLeA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(396003)(39860400002)(346002)(376002)(451199021)(82310400008)(36840700001)(40470700004)(46966006)(36756003)(478600001)(316002)(86362001)(7696005)(4326008)(6666004)(70586007)(70206006)(6916009)(82740400003)(336012)(5660300002)(186003)(41300700001)(26005)(1076003)(8676002)(54906003)(8936002)(44832011)(81166007)(2616005)(426003)(47076005)(40480700001)(40460700003)(36860700001)(356005)(2906002)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 19:31:56.8462 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f5bfd13-2165-4469-e775-08db8e0ef974
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT045.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB9013
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
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This DC patchset is rather small. In summary, we have:

* Fix for warning with MST hardware and IGT test failure
* Correct sequence for enabling/disable symclk
* Some code cleanups

===========================

Alvin Lee (1):
  drm/amd/display: Implement interface for notify cursor support change

Aric Cyr (1):
  drm/amd/display: Promote DC to 2.3.245

Aurabindo Pillai (1):
  Revert "drm/amd/display: Implement zpos property"

Fangzhi Zuo (1):
  drm/amd/display: Temporary Disable MST DP Colorspace Property

Joshua Aberback (1):
  drm/amd/display: Clean up flip pending timeout handling

Taimur Hassan (2):
  drm/amd/display: Add symclk enable/disable during stream
    enable/disable
  drm/amd/display: Fix typo in enable and disable symclk_se

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  2 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_plane.c   |  9 --------
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 14 +++++++++++
 drivers/gpu/drm/amd/display/dc/dc.h           | 12 +++++++++-
 .../display/dc/dce110/dce110_hw_sequencer.c   |  6 ++++-
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    | 23 +++++++++++--------
 drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h  | 10 ++++++++
 .../amd/display/dc/inc/hw/stream_encoder.h    |  1 +
 .../amd/display/dc/link/hwss/link_hwss_dio.c  |  3 +++
 9 files changed, 59 insertions(+), 21 deletions(-)

-- 
2.41.0

