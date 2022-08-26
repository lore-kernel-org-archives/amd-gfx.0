Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A198ECAAA3
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Aug 2022 18:46:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB0A510E03D;
	Fri, 26 Aug 2022 18:46:05 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2078.outbound.protection.outlook.com [40.107.237.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6EF9710E07F
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Aug 2022 18:46:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B10Mw56LxD0mXCuJ8EUa6DW3D0rszUCiIl6wn3o0U0bj7nDJALDoDkMUO28Z6IkDlbl+nzoKuL5P1KuvhrzH47/yqniW+Qj5Ph/k3tcMnFY5OxKqfeg2tqnJr9rXUf7eAQrA34VceBWNNTRrmXoRkSAdVPwpvYfpgtn1Cf7JvG4udrS8zObyCNO3GajtuDBtEI7TY2L+tuhVsLx1mMVHm0jio2VaYu8HC5QvCFzdvYUH6gO41u2GNfs3rUDOBFreqppJjfhKLjA6Gt2iurUWJWmtESNJCxdRC3ar8P+xMsOrqXIUzHUqfohjrW3jCNKjEzNB+XQ6lZotXtTjLrKtag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qe0RmfARn6w9wDfjvYGOiji44qAGPGgwbz6PbrVA1o8=;
 b=jkN4XG3ERHv3eCz4aTPMybIl73Ew2eDKY2XrEPmB2soTbxFESeJOgveqycR+s6Ug1JLHMtcnuAJ0Avx90nOy2o3ysCbQNar+VHCbzPmoYU1vD7qrUG7o8c5OhQ+008V7wXxbusfzn0Hgv2m8hDsf6BQMUP1Ii9KWX/TGIyYeFhVofUKHb38MvcKV7WHzkrj/Oj3hkoxKYYwHnKMZWY13soJUrXPJSaivgr1hTIJuyHTymYncihfgqUKQDkaZX75YeC/tSfdWGIX431eFcCwakbtGgO1G9iz2pLDwmbUQ2MWAiF0Ani2i89WRalmzhtME/50PW15AFqNlibPf03kVzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qe0RmfARn6w9wDfjvYGOiji44qAGPGgwbz6PbrVA1o8=;
 b=BnunOHimjVuISSsb72KPfjmu7HT8VIr7Q2QImlZT+ool23kuH1zWzpgJCcNFzRm4G5jZRO20TGSzcjdy9sl19F4QHIosZEyO0503pRUCmpM42aaisDVQycEy2Ny1k+wwoJXtTrpO5nEjp/llZTQR67lS23Euswx7FLv3WVSzbA4=
Received: from DS7PR03CA0126.namprd03.prod.outlook.com (2603:10b6:5:3b4::11)
 by BN6PR12MB1538.namprd12.prod.outlook.com (2603:10b6:405:4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Fri, 26 Aug
 2022 18:45:59 +0000
Received: from CO1NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b4:cafe::6b) by DS7PR03CA0126.outlook.office365.com
 (2603:10b6:5:3b4::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15 via Frontend
 Transport; Fri, 26 Aug 2022 18:45:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT015.mail.protection.outlook.com (10.13.175.130) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5566.15 via Frontend Transport; Fri, 26 Aug 2022 18:45:58 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 26 Aug
 2022 13:45:57 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/3] drm/amdgpu: declare firmware for new SDMA 6.0.3
Date: Fri, 26 Aug 2022 14:45:41 -0400
Message-ID: <20220826184543.855686-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: af5f5c42-2af2-418d-a08d-08da87933781
X-MS-TrafficTypeDiagnostic: BN6PR12MB1538:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: exT/MXyl3K4EMKE5w0stnPM0noal2wh2S+uE3piEL+Jw7pGMplKNDjt1TTS0n8LVVqIGKVKtL/S+c3wV0L/6CASaWzSHzcollneCL2g39LfktB2CWecfLbZGQM6+6JGQLCq7bPNr7HFPu5+dWmJh/T7uAnxdAF6NZBmHf5IXWI6Rv/pBKmJ0SMo9E+LPQ/tcEWKvwOqwXijvvaY+J33kF+UESaMrhIPx+wME/y718c3PVMSPzUULEMpMF2oK99RtqbLc5LpxQhqg3FpmjE0wIbapHTYLVj+oTrmETs/xTDAXa5E2Bbz1w6lJ3r/Do3VbCB/7O4ZzFIvLlAEACcBLsZEp3U6GGeYFGmqcRtK0odhV/mUgzLbBf5l0XVwdoN1L1h4HbmJTZCmV1HA1kotWQtsdnJHUxcsWSrYyFFwofLI0wkJux1lz2Qd4c77sNMn8AZxs6YnNMeWCGUJgirMIRDP+oxn7HAB4sRz36XVBy6nilGNxqTq1TlYVIXj25ofhF4t8OApUgagYNysq+kz9aiwCpT4mTWSjJrz3Jp1kh8WFzL3pY+F+yQPtD1F91Pp65+5B09fu9tCL8d0e3GlF/IAU2p0fHT+VwYE7fMp25c2fH7yYJ6iiujFtLojXGMzAUbMMpCxO86hp0AmIWJ2hL0ZMyD6Qwz0inAlEQ8i87BAQ9yn3T22U4XuW3nqvaxx/29YgNMeh21dL/9v/ZNlYFrAEZT3oFX51q68SpktLvI8nJ49ORyy0P+N3Vn6enskBhMt5TZywjKu4TJ8jldd6cALnYNip9cwyFro3/FnfdYk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(346002)(376002)(136003)(396003)(40470700004)(46966006)(36840700001)(426003)(7696005)(83380400001)(186003)(26005)(47076005)(2906002)(2616005)(336012)(1076003)(16526019)(356005)(82740400003)(81166007)(40460700003)(36860700001)(86362001)(40480700001)(6916009)(316002)(82310400005)(8936002)(41300700001)(54906003)(5660300002)(70206006)(478600001)(36756003)(8676002)(6666004)(4744005)(70586007)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2022 18:45:58.5655 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af5f5c42-2af2-418d-a08d-08da87933781
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1538
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Frank Min <Frank.Min@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Hawking Zhang <Hawking.Zhang@amd.com>

To support new sdma ip block

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Frank Min <Frank.Min@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
index 0200cb3a31a4..2bc1407e885e 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -47,6 +47,7 @@
 MODULE_FIRMWARE("amdgpu/sdma_6_0_0.bin");
 MODULE_FIRMWARE("amdgpu/sdma_6_0_1.bin");
 MODULE_FIRMWARE("amdgpu/sdma_6_0_2.bin");
+MODULE_FIRMWARE("amdgpu/sdma_6_0_3.bin");
 
 #define SDMA1_REG_OFFSET 0x600
 #define SDMA0_HYP_DEC_REG_START 0x5880
-- 
2.37.1

