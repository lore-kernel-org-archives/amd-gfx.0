Return-Path: <SRS0=Ip3g=OV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A127C433F5
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Oct 2021 14:41:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6AB661381
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Oct 2021 14:41:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E6AB661381
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 73CFD6ED92;
	Fri,  1 Oct 2021 14:41:38 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2057.outbound.protection.outlook.com [40.107.237.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 503A6890B9
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Oct 2021 14:41:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IaYRww5vKaMKIAdZ0VRXFoBdX2c+32g/0YkW3n3mP9on/gPcMkMzsvJ3QJ74Oqe11xT2XAu1Bnx9IoxI2WjPqG1caEHHkMd6D3ktgzu8XCeyTuZGaJtl4JVKEpnTMhxIMwIdj2V1U+d7H+C3SkDKZMmuKhZt0vv6gkP8cQkBKdB4hOvmpEGI34Ojlfb0APc2MYIx5ZYOBawtpdpc0RwJjw3swMVqT6eP+sVLuuolC817twRPVomj/nLG5Pt7zCuFzwcFwmh7lt8/rVmBHE/c3Rl8Muv3yBLZpgQn+ijux+pXdpQWEaCpc6zjrn0CSEh9S5zLJDCYrxu3Wt0Pgv9oeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yDdr8O69l1mXyYDCDFwGUiFqLou+LADOWSv+tdo21jc=;
 b=EJqYVusi3ccWGg8VEFo9FMnoXVgLev7VhsshTKseUciZUiRfbSoxXfw8U62Zxms/2J6+19DRJxJIJhJ6Nh+okKcdEzY8lacQacIFH5XFa0XIInX9p15xIo9lxhxZMBHPIy9axFgeeTeuXAmcrUdIDF86G6koh8a+a+OwZfB/CX1mjkIGWRjg/mm+cZWAKoVO55wfdjYDTm0QCcDNlUy9V+RQ5BbUnCXvfWKpb6xOJBuj0S6XhkHvuo0henqmlmqrlzUotwcjnT48h3848QbDEVFoRw4v4fnWbx6wPPTGixbPqwhZlQEmDe/SZssBsvEGAw+oj+UtBcbcJkYXi1FvqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yDdr8O69l1mXyYDCDFwGUiFqLou+LADOWSv+tdo21jc=;
 b=LOD5uQCByhsTc7B/2cZkPUZT3PofhxTppKqN7T5H6079Fh1O9LNus1wGJcWYLbSe6S2NZ/WA0bAPkCzOonplMbHZRqrap5OTOcv9+b14lDsc8xoTsSqqX+3fWUhOw4wedvUawi7k+BbcuzrPGlsR4Ycv+3EqYT3dWgIetH2t9pg=
Received: from MWHPR1701CA0001.namprd17.prod.outlook.com
 (2603:10b6:301:14::11) by BN7PR12MB2833.namprd12.prod.outlook.com
 (2603:10b6:408:27::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.18; Fri, 1 Oct
 2021 14:41:33 +0000
Received: from CO1NAM11FT058.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:14:cafe::e5) by MWHPR1701CA0001.outlook.office365.com
 (2603:10b6:301:14::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14 via Frontend
 Transport; Fri, 1 Oct 2021 14:41:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT058.mail.protection.outlook.com (10.13.174.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4566.14 via Frontend Transport; Fri, 1 Oct 2021 14:41:32 +0000
Received: from solomon-t14.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Fri, 1 Oct 2021
 09:41:28 -0500
From: Solomon Chiu <solomon.chiu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <roman.li@amd.com>, <Anson.Jacob@amd.com>, <wayne.lin@amd.com>,
 <stylon.wang@amd.com>, <solomon.chiu@amd.com>, Jake Wang
 <haonan.wang2@amd.com>, Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Subject: [PATCH 07/14] drm/amd/display: Added root clock optimization flags
Date: Fri, 1 Oct 2021 22:36:13 +0800
Message-ID: <20211001143620.192679-8-solomon.chiu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211001143620.192679-1-solomon.chiu@amd.com>
References: <20211001143620.192679-1-solomon.chiu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 37681d58-f480-4eaf-4e21-08d984e99003
X-MS-TrafficTypeDiagnostic: BN7PR12MB2833:
X-Microsoft-Antispam-PRVS: <BN7PR12MB2833BCC42C8637495D2299B997AB9@BN7PR12MB2833.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nGDzVT+Tt58AYB2PbdWMCZu10OL0pC7ShA3CXGLsr085mdui6HDfYAB9C7q5U3KcwrrmrS2y2WkbzYDMlz20zkdKKfphP9kXVDhZvOucqV4o+LNpsvK3gOTEvhP/qpzpk6hB52J82k5P7ecksIUJ8rs6d23ioS9+yaDQrSWajb/Ux0VJN0higveA7avcs1OXspF0bwAFBvookB5pgRiunHMXrdWZAnqzm+nfupu9Nc1dQL8aIj1N+R8yVIsNIv7RjfDaXQJLIl3c0xvYlvNbG5m9GnEjBinSbWYO38pp2G+SgJ3wWzqvnfzSdpT17RY1S+2KqTrWtw+GSRUBKS6ePK5L5s0IvIatTN63wz0hnp6mkBXlmHdQBuSlHvSrOUMlk2y4Ck4HLh8yl19Z+GjvxXRvBqQX9yDsWVCS9cXfXw9Q0eHAy5b0Q6BOjwlYyBpZ4M+AJJS4IzCIoXoR0tThN5l2fVXSH3c6Q/pHmHSYDDjQG4z2//zbGdeVcKXmPxNQsf+GlWdd0jQ6ku/ZD791g1pLIXGhxf2iM81pyIkDP3w2LQwA53b2nUJBCOGi8cXLH6z+i1QHY1uHp03YltvwtpnXjBeyjl6Ss/ZSsq9aZ1T+vOR6BPLEzTnfLicdeOoTBId9uWT9z442qQClXqv1afWTjmLIsUedalHtM6JgZaMC37sT4AAOQDiH3T6N3WVAM7H+4LcV5/CNJTlCEn5rQwegOrg9cLvTZKdozYQSPho=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(2906002)(86362001)(81166007)(356005)(47076005)(83380400001)(6666004)(2616005)(82310400003)(316002)(1076003)(5660300002)(36860700001)(16526019)(26005)(186003)(54906003)(44832011)(70206006)(70586007)(508600001)(7696005)(36756003)(8676002)(426003)(6916009)(4326008)(336012)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2021 14:41:32.6488 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 37681d58-f480-4eaf-4e21-08d984e99003
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT058.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2833
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jake Wang <haonan.wang2@amd.com>

[Why & How]
Added root clock optimization debug flags for future debugging.

Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Solomon Chiu <solomon.chiu@amd.com>
Signed-off-by: Jake Wang <haonan.wang2@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index c5a091d0bbfc..5ffe2a41258f 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -477,6 +477,23 @@ union mem_low_power_enable_options {
 	uint32_t u32All;
 };
 
+union root_clock_optimization_options {
+	struct {
+		bool dpp: 1;
+		bool dsc: 1;
+		bool hdmistream: 1;
+		bool hdmichar: 1;
+		bool dpstream: 1;
+		bool symclk32_se: 1;
+		bool symclk32_le: 1;
+		bool symclk_fe: 1;
+		bool physymclk: 1;
+		bool dpiasymclk: 1;
+		uint32_t reserved: 22;
+	} bits;
+	uint32_t u32All;
+};
+
 struct dc_debug_data {
 	uint32_t ltFailCount;
 	uint32_t i2cErrorCount;
@@ -637,6 +654,7 @@ struct dc_debug_options {
 	bool legacy_dp2_lt;
 #endif
 	union mem_low_power_enable_options enable_mem_low_power;
+	union root_clock_optimization_options root_clock_optimization;
 	bool force_vblank_alignment;
 
 	/* Enable dmub aux for legacy ddc */
-- 
2.25.1

