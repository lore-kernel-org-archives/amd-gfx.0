Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6284CCD128A
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Apr 2024 19:51:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 847A5112E87;
	Wed,  3 Apr 2024 19:51:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lEJCaobO";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2087.outbound.protection.outlook.com [40.107.102.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 33BDA112E80
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Apr 2024 19:51:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ps2vbm/MuEeh39DPhq8K/7Z6xDtTlWRO4CJ1Azs8NjQOy0EMXo2vJqNHHrnFP5KGL2qa86Kk4PBPQGm3g1uXh2uH6YEq1EVwkNnQ8QeGXhSW6CtwQ2ZTNPf4rICR8fww5Wu/Eowz9sOTNzNPHqI8te9jH3g9hqV0t+2pF1Q4rQwR9TEu3H40aQeTNIJYsMYfFtdRnTsfqHbhezzyYuynUNwDB8zxYHVKb4gTa6D41u5sFvhL6yFbBmEqen1Q7D2wKn3h/lKDYHRRs/WArbJQCwkvCvEyO6c1VMamYuuMK/iILy8a7goz15p6KWmXv8mNVYnjwZEiHDCXDtUoArPExg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q9fPUs8+mr5Dz+TOnLNppD/MDgo216osSvGvpj3/DlM=;
 b=XzN2NeRIlPbLGCEhG8W5OsCsWSItBYv7K0gW3YeBQhETpiZBALyvYD/cqqG7BVGjvs7fblwrBQOPbCF9y15vzHQD6ylaIgje6VtlPwbpDgZGujOznIR6YLqFvYo0kyHT0pjbtjzYMJgR6NmR7dmPMnMooeUyoNSM+UeJRW9JqZ+hg38XPSVPVb+Qt1JCvfkI6BB/fiLpim6Wbwv+iom96Fk9JDLpW7WYJxcOWN+kSowij3bT3iIE82V1qErI6Sjjr5Ze+q8Yk6uKn12ooY6O/MOx8n0pc/ByNg5aWCGvi5Bs3/kx4we2H+MBToq9r2MdlK9wNm4g7mNhcnDJ0TCsQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q9fPUs8+mr5Dz+TOnLNppD/MDgo216osSvGvpj3/DlM=;
 b=lEJCaobONf4cwjv6Gq//nu1OuGa31E5/7TLvf92KoRXqylb32REnV7nb0gB4YyZTOqGdVfiwo8DytNnmd3nxmp8W+gf6Hsf8R2oS6rqVA+uTooogA+tvInUk76FqYk8mG/V4NLUiJk6KQiVGn+/rKGEs2qRJ045JicSYreqoWfA=
Received: from CH0PR04CA0065.namprd04.prod.outlook.com (2603:10b6:610:74::10)
 by MN2PR12MB4320.namprd12.prod.outlook.com (2603:10b6:208:15f::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 3 Apr
 2024 19:51:46 +0000
Received: from CH1PEPF0000AD74.namprd04.prod.outlook.com
 (2603:10b6:610:74:cafe::de) by CH0PR04CA0065.outlook.office365.com
 (2603:10b6:610:74::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46 via Frontend
 Transport; Wed, 3 Apr 2024 19:51:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD74.mail.protection.outlook.com (10.167.244.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Wed, 3 Apr 2024 19:51:46 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 3 Apr
 2024 14:51:37 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Allen Pan <allen.pan@amd.com>,
 Charlene Liu <charlene.liu@amd.com>, Hamza Mahfooz <hamza.mahfooz@amd.com>
Subject: [PATCH 08/28] drm/amd/display: expand the non standard link rate for
 testing
Date: Wed, 3 Apr 2024 15:48:58 -0400
Message-ID: <20240403195116.25221-9-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240403195116.25221-1-hamza.mahfooz@amd.com>
References: <20240403195116.25221-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD74:EE_|MN2PR12MB4320:EE_
X-MS-Office365-Filtering-Correlation-Id: 383c9a4f-be7f-48ea-c321-08dc54177e6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rbQ2WnK36Z8YuqRgN3FpGglwSX7K5RDq1FcB62TptBsHdUAlL6O1fqDDLLAyPxwQPvna9T23JuqGBEyGR+f/EWnGTUdgC8C9Ghjl/aRKCNDHBJkwkqCZNCKxp4wS4WYgTyzj85c3Sa2E0JHBkyK7ryeuigFJgB5KtJW5M90hPjMVDxXuouc6P/o48PPSCpq8OCtIM0nb++8Qbd/mYgY5r9RFTEeIGBSjYCZcexeLu6wdca3PYK81JTUTB/kpT/hDGdm1tZmEnelUSnJAf8Rh1zySC1fSpCpVQkZ66+Jfx/ke5rwQvdrQ8RcBc5bl/BxNZh/r9NC2Pukkf1StIEWJ6moccxBCyQZjfnz0utgsXJAnhJVV2u52cqoOp2hp+kGEozrXndSw41aN5YmHxEkuNQee/4OFi/9JHvgrIEiGmCv3Poi/cqQDn/LnFb1HjGOB3YBgPWcmgXZO6IPVQw3iDY50JeXqN2IF9pYvwV5JOvgGrbBSqNBjyJwWmWqkO9HtfRD3I2Hqpm9zUPgCMkLEKxe3dVFyiiDNMUXWs1JP9PwQa7r1S0xQMeyUNWaUIbwpcTX+L+LeeY27jHl3SH/nXtrY3+wC7X279XhvbEKyWiyBLAbHn690vLuL/XTVFWBO1HwzPs9lGHV03lpbjHVff4Glpwgq2NG7Qg/7+1nAWNGIr2sWZhKJouCzANpqKl6KQV+ajCNEEOkyh2YyD7M1AGAIV6tD0ckGyObCIVXqM48KIBpnT3WK7i+sZak6gGbE
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(82310400014)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2024 19:51:46.1115 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 383c9a4f-be7f-48ea-c321-08dc54177e6b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD74.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4320
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

From: Allen Pan <allen.pan@amd.com>

[Why]
6.75 Gbps link rate training for DP_TEST_LINK_RATE_RATE_8

Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Allen Pan <allen.pan@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_dp_types.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_dp_types.h b/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
index b9f8eee5d2d1..519c3df78ee5 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
@@ -137,8 +137,13 @@ enum dp_link_encoding {
 
 enum dp_test_link_rate {
 	DP_TEST_LINK_RATE_RBR		= 0x06,
+	DP_TEST_LINK_RATE_RATE_2    = 0x08,	// Rate_2        - 2.16 Gbps/Lane
+	DP_TEST_LINK_RATE_RATE_3    = 0x09,	// Rate_3        - 2.43 Gbps/Lane
 	DP_TEST_LINK_RATE_HBR		= 0x0A,
+	DP_TEST_LINK_RATE_RBR2      = 0x0C,	// Rate_5 (RBR2) - 3.24 Gbps/Lane
+	DP_TEST_LINK_RATE_RATE_6    = 0x10,	// Rate_6        - 4.32 Gbps/Lane
 	DP_TEST_LINK_RATE_HBR2		= 0x14,
+	DP_TEST_LINK_RATE_RATE_8    = 0x19,	// Rate_8        - 6.75 Gbps/Lane
 	DP_TEST_LINK_RATE_HBR3		= 0x1E,
 	DP_TEST_LINK_RATE_UHBR10	= 0x01,
 	DP_TEST_LINK_RATE_UHBR20	= 0x02,
-- 
2.44.0

