Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A389C4167B
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Dec 2023 13:29:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5937F10E889;
	Fri,  1 Dec 2023 13:29:51 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2073.outbound.protection.outlook.com [40.107.93.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5631510E89C
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Dec 2023 13:29:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oTrHdnMPbwGTWgML763X/L7i2m5SduzxBTlQoEs4zRC44veUbpD8WI1MT2OERiHq0yAake/4njMxNP0F6lQUOqM9kdQ+6dh1Q4HpFm0Qg1IESjq81KZRqUgMiAx0aMnltWJHHzV7z0+soXZYCN4lMdeU+bykhNKJu/0IZQgpGANPlYPeO32dMi/B5/5YH2qj3n5riABVIUrn+Wykz6lK56AWZsekbQ5gct8U7pPDQAALlmaFQ4ZZdnN8MZaJioolUFHa8ItsPPBzi811YVZWKBDdm/JPDWwl+1e7Z6JTfiQP10hklXNK14toFIT+mf+A2SA16wfN1m78l8M4NuYahA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y31x9rhkAeyHjY8Yt2Xf9280VN5O/juSG6LB4CtjOAc=;
 b=YG3H47pxGts4fTENyblJMkTbmkay7LRwqGFPIsCImFvMMkiyCDHs1xlcpTd0rJ5I5I6zEB1M4q6Q2urQG4NFihFaiNPuwWvx2FeDVzv/+YcivXenTBvK3hGeOq/hpLNkChTl0HAv/B2S6PXYbXdX1k6WAJmX28AnwQ2fsekJIreC1UPwVLsItU0h5Noaz3qXjgVJjbRqzG+cHjYgYJWpuQ4l6Isib/T4bgqGqxoXZWQtyneaQJmTnQw5IwGIVEpuaV5EOp52WiC/91S63FDqyzTbYglXJZPXcUP2T2e5j5jfcguVXDo7BhDlAksHPwBfIrZ7aWtYxNF9992AmOzNOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y31x9rhkAeyHjY8Yt2Xf9280VN5O/juSG6LB4CtjOAc=;
 b=ZMQyTOvWLPT85jGDcy5YWdhQ+W5Yqs57PisXQSOvL2dD9VcDIgZKMx6xUke9eR4RBqadMXCeHcGHZqOzsOTNUJyrcwQflHARu61vg14vX3uOIw9tn4NhWWJt7ApzQIB4Br0NgBdrVYsMToDGOuVoXIiw1tFUlrQEvW57gT7A8zo=
Received: from CH2PR10CA0010.namprd10.prod.outlook.com (2603:10b6:610:4c::20)
 by DM6PR12MB4170.namprd12.prod.outlook.com (2603:10b6:5:219::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.27; Fri, 1 Dec
 2023 13:29:37 +0000
Received: from CY4PEPF0000E9D8.namprd05.prod.outlook.com
 (2603:10b6:610:4c:cafe::fa) by CH2PR10CA0010.outlook.office365.com
 (2603:10b6:610:4c::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.27 via Frontend
 Transport; Fri, 1 Dec 2023 13:29:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D8.mail.protection.outlook.com (10.167.241.83) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7046.17 via Frontend Transport; Fri, 1 Dec 2023 13:29:37 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 1 Dec
 2023 07:29:35 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 44/47] drm/amd/display: Fix array-index-out-of-bounds in dml2
Date: Fri, 1 Dec 2023 06:25:40 -0700
Message-ID: <20231201132731.2354141-45-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231201132731.2354141-1-Rodrigo.Siqueira@amd.com>
References: <20231201132731.2354141-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D8:EE_|DM6PR12MB4170:EE_
X-MS-Office365-Filtering-Correlation-Id: ca8f5697-19d9-40e5-3082-08dbf27190a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zNluooLlKJScypPmCQ18BeJzq0cDWmC5CCGFIh4h9p6tdI0DxJDglA7rd5hFVve+/oW1Fe2uJ4oJgIZXlYcs3vxaGQWxm+EkEY+xf7PptStK7vJKd5aBFZyMwnTG/V/SI4XC80yAMWejYelgb+HLSirlEosE3buyo6IppRNqmZXQCopqf4GkpRMKKpFSgmJsqKrnvy+vymbizkcYEMrZ7bQUJH7egkDqJmBrp1sYILeW3t+xY6INwhfWs5ajxwB0gwKo01/gZbx3cGUXbRpgEpvgfJABYGMnwNq6mpnE2SSird6RdL3CG7u0BnDc1jGlrImhl9T+BqcEmmmeu67KUrYucKU42TeW1YKqWVBQhdtOuHAhR5KEwjaZ1SSCetAMrzNCduEhWTV5+zyI3xs+tYtdMELRnzr4lP/gDRASPos6vIN1WflVtsED970pEUh3ShOU16n2b79od3sI18ogCvpMhUO2J/ejyFy9yLq0Fd4KXN6I1mftJHpu4i/l1G7BBr4zsHJxEMlQlHW/wcvbezUH+mD/mUf8XXFbW6F7mKDJj+SMl2p+HHws2HrhlzxLifgUm3GXmr8/SHHpl36YVuVTSxtdhCdpohcU8R5vx4Ea5hBnKaOdpb2cYMMJNvI51M2326STBBINowHncaF51QKodBRFpnkySOTkWJBRizXTlzThaxsk1cCueVVtIl82Hx7gQQ/EmwDZuzql421wU001mxOCHl6ZbXrbmvSV2fbsmsNCj0clQkYXFnaCgnLV/db6sY2KQLU0i+gLVPqcDEAfd82x/SE9eB15AV6BOVI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(346002)(376002)(136003)(39860400002)(230922051799003)(1800799012)(451199024)(186009)(82310400011)(64100799003)(36840700001)(46966006)(40470700004)(2906002)(4326008)(8676002)(8936002)(336012)(26005)(16526019)(316002)(41300700001)(54906003)(6916009)(70206006)(70586007)(1076003)(5660300002)(426003)(2616005)(83380400001)(40480700001)(47076005)(36860700001)(356005)(81166007)(82740400003)(40460700003)(86362001)(6666004)(478600001)(36756003)(36900700001)(44824005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2023 13:29:37.3828 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca8f5697-19d9-40e5-3082-08dbf27190a1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4170
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
Cc: stylon.wang@amd.com, jerry.zuo@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Roman Li <Roman.Li@amd.com>,
 solomon.chiu@amd.com, Daniel Wheeler <daniel.wheeler@amd.com>,
 Aurabindo.Pillai@amd.com, hamza.mahfooz@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Roman Li <Roman.Li@amd.com>

[Why]
UBSAN errors observed in dmesg.
array-index-out-of-bounds in dml2/display_mode_core.c

[How]
Fix the index.

Acked-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Roman Li <Roman.Li@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c b/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c
index 2e7fe46fc689..cf5e8c4fda42 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c
@@ -9438,12 +9438,12 @@ void dml_core_mode_programming(struct display_mode_lib_st *mode_lib, const struc
 
 		// Output
 		CalculateWatermarks_params->Watermark = &s->dummy_watermark; // Watermarks *Watermark
-		CalculateWatermarks_params->DRAMClockChangeSupport = &mode_lib->ms.support.DRAMClockChangeSupport[j];
+		CalculateWatermarks_params->DRAMClockChangeSupport = &mode_lib->ms.support.DRAMClockChangeSupport[0];
 		CalculateWatermarks_params->MaxActiveDRAMClockChangeLatencySupported = &s->dummy_single_array[0][0]; // dml_float_t *MaxActiveDRAMClockChangeLatencySupported[]
 		CalculateWatermarks_params->SubViewportLinesNeededInMALL = &mode_lib->ms.SubViewportLinesNeededInMALL[j]; // dml_uint_t SubViewportLinesNeededInMALL[]
-		CalculateWatermarks_params->FCLKChangeSupport = &mode_lib->ms.support.FCLKChangeSupport[j];
+		CalculateWatermarks_params->FCLKChangeSupport = &mode_lib->ms.support.FCLKChangeSupport[0];
 		CalculateWatermarks_params->MaxActiveFCLKChangeLatencySupported = &s->dummy_single[0]; // dml_float_t *MaxActiveFCLKChangeLatencySupported
-		CalculateWatermarks_params->USRRetrainingSupport = &mode_lib->ms.support.USRRetrainingSupport[j];
+		CalculateWatermarks_params->USRRetrainingSupport = &mode_lib->ms.support.USRRetrainingSupport[0];
 
 		CalculateWatermarksMALLUseAndDRAMSpeedChangeSupport(
 			&mode_lib->scratch,
-- 
2.42.0

