Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39B87C54EE9
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Sep 2022 18:12:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0136510E808;
	Wed,  7 Sep 2022 18:12:34 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2071.outbound.protection.outlook.com [40.107.220.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D0D2110E7FA
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Sep 2022 18:12:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L0fzsVHUAv2XdBxO66tGaCmR5EbPXAFIBF/h99vHJr3j9fRbh1xd0xnVj+qwKIcUNgCiCvhG3GvDLjFBzCWLy81vpZ4HGcahwTCrPRRmXlXP6h7ZqTiuCVVqncIIy/ACwuoZ2wY0OTUzqoF7EDnFkAl5D7sD26g9uDGWDKwmQiS3ZK8fQLp+oH/NA3YDu/IFbNEJnyjS8P8MKeMKF0TtgZXIBNyRMKQ6Xujvlc/1y6yC1MujOJwHCBd71jV+PvlQBpvLmNLQxODr0ywH3569wyM8kxIy+j/NquyD2531KPD8ot+mSaaPF5VwRPwyD3d4poJrkuRWjV4AAf4oHZ+d3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cv542JNW9EQWNNdH0XwNGruXDNSwTxcbhYpelVSwFM0=;
 b=Ej0RLPhN06t+jwdgw61C5am3UBivBbON2MFs/MxbQ8gep0vvy4C567//B6QYiNsVVVZYVsLXgl5nq71px/VYXrh80IXaSn4ogxJBE70H55l2sgI87yXpmo4aJoCT3SNE20kCMemT5bNYqCngEaNNXtSLdHw7yInmB3ilIms8sA3h6qelCypEpSWMFaqkPYLSk04c3X+9PKOZbZmeQj8P3pxjoe4rEd4jO+JQFTebsxk9h8RKbWnEgxN7LDITTjvfUJc5A+eU65oBTE0cMFOrxw7nV3eKNO6POzCKpWwCDO24txTgDUEp/DJKms++tMBJC5WcrHyjc+X3oMSdevIWRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cv542JNW9EQWNNdH0XwNGruXDNSwTxcbhYpelVSwFM0=;
 b=qvxjI6ec6IzJxO/7b3k7/kBgbl3DJcfG8wzQ8DUqhJBdt7O4cD0Nid0YXOXbbNqtpfy3tCWlgqJB6oO4XJDejnyiw3kw1Pw3iZ/b6IrF7/O2m0xpurKe2CU4b+2H7qYv4BuCQNdAMXkAbBEqOCIGCfMF86GA4SLftCl1MBNguL4=
Received: from DM5PR07CA0065.namprd07.prod.outlook.com (2603:10b6:4:ad::30) by
 SN7PR12MB7370.namprd12.prod.outlook.com (2603:10b6:806:299::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.18; Wed, 7 Sep
 2022 18:12:22 +0000
Received: from DM6NAM11FT026.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:ad:cafe::bd) by DM5PR07CA0065.outlook.office365.com
 (2603:10b6:4:ad::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14 via Frontend
 Transport; Wed, 7 Sep 2022 18:12:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT026.mail.protection.outlook.com (10.13.172.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.13 via Frontend Transport; Wed, 7 Sep 2022 18:12:22 +0000
Received: from promo.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 7 Sep
 2022 13:12:21 -0500
From: Pavle Kotarac <pavle.kotarac@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 06/21] drm/amd/display: Fix compilation errors on DCN314
Date: Wed, 7 Sep 2022 14:11:45 -0400
Message-ID: <20220907181200.54726-6-pavle.kotarac@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220907181200.54726-1-pavle.kotarac@amd.com>
References: <20220907181200.54726-1-pavle.kotarac@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT026:EE_|SN7PR12MB7370:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b6eb507-6315-4375-d206-08da90fc82be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OLyK15375dtJyWrG5muSkaRQuxrKzi2puwWqcRuEHAHRpIB8sfXJT/AUnAy/G7GcOChAoVPBkhztmRMXIgoReQ13wtwDjT7tLWhL7BzauQDcPR+OZnNjoq/iQ/jHmwpy5PltubazCRY8BIrPhWae31P3E0MTTLnVYLf5C9Tgqa7jOgrZSLZ5ub4BhKFw2u2tGm/n1edNHUT3kzeQKu7PTmb7CUS9lDAgi3F2w9CkDmzqbYlME8izUBC6+1p6cIWbIPgdILLrSa/Bzo+krFyCvMe2RJHv7EwsdysUHKqRCBE1rdh+ZpHBmKF6UKF/uC4I1ibm5os48VyZCyeFFS6LYlL2dtRQECVPQXV49+ZZTkv92VsIbusCwnbFy1l0+TCXjJ8cGb1mkdrP6wcXPgHank26M1rpa23wpDlHR7EXY9J3dnuI3ufaa+4rwL4nD/mtUy+ypielqJ9rvOuqUGBFXBMOZzP9nxl1WtDQJNLFrmhBRuYFBvk7U1ixLn5daxKVcfkEcpGUfLOqiWCg7SHWv1EAGu+P8FfoeHSxGjucqkzeAA9lt5GwlLNmURZILFgdK5wRidQjpNP4Sm/Wg37sCa2cTWJayMJWKpofisLyc4foTVKe0JVDW++d/Rv0aksZBxD9Gv04HYRHnztg7G+bNxvJUmmVWuK1A1q3ClFdKIDZ6AwIcyWfJN1SnrCqaFYxcy+wJr98TnPdBrYL9owKupqmc1GulMGgPiim81kpO1/yQUnJdoez9ljV9GIK14FmFhXd98WxnVLVDFGb8QRt+u5lnILZPF1PfboxS6taLr8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(136003)(396003)(346002)(39860400002)(36840700001)(46966006)(40470700004)(82740400003)(6666004)(316002)(83380400001)(70586007)(7696005)(47076005)(426003)(86362001)(4326008)(8676002)(70206006)(41300700001)(478600001)(40460700003)(81166007)(6916009)(356005)(40480700001)(54906003)(186003)(2906002)(82310400005)(1076003)(16526019)(336012)(36756003)(5660300002)(8936002)(44832011)(36860700001)(26005)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2022 18:12:22.4954 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b6eb507-6315-4375-d206-08da90fc82be
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT026.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7370
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

From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

We have some compilation errors in some DML files from DCN314 that we
never noticed because we were not compiling some of the DML files. This
commit fixes those syntax errors before we enable the compilation.

Cc: Roman Li <roman.li@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c b/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c
index 503d9ede0ac1..9fe4dc32fbe0 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c
@@ -61,7 +61,7 @@
 // fudge factor for min dcfclk calclation
 #define __DML_MIN_DCFCLK_FACTOR__   1.15
 
-struct {
+typedef struct {
 	double DPPCLK;
 	double DISPCLK;
 	double PixelClock;
@@ -1599,7 +1599,7 @@ static void CalculateDCCConfiguration(
 	int segment_order_vert_contiguous_luma;
 	int segment_order_vert_contiguous_chroma;
 
-	enum {
+	typedef enum {
 		REQ_256Bytes, REQ_128BytesNonContiguous, REQ_128BytesContiguous, REQ_NA
 	} RequestType;
 	RequestType RequestLuma;
@@ -7159,12 +7159,13 @@ static double CalculateExtraLatencyBytes(
 			HostVMDynamicLevels = dml_max(0, (int) HostVMMaxNonCachedPageTableLevels - 1);
 		else
 			HostVMDynamicLevels = dml_max(0, (int) HostVMMaxNonCachedPageTableLevels - 2);
-	else
+	} else {
 		HostVMDynamicLevels = 0;
+	}
 
 	ret = ReorderingBytes + (TotalNumberOfActiveDPP * PixelChunkSizeInKByte + TotalNumberOfDCCActiveDPP * MetaChunkSize) * 1024.0;
 
-	if (GPUVMEnable == true)
+	if (GPUVMEnable == true) {
 		for (k = 0; k < NumberOfActivePlanes; ++k)
 			ret = ret + NumberOfDPP[k] * dpte_group_bytes[k] * (1 + 8 * HostVMDynamicLevels) * HostVMInefficiencyFactor;
 	}
-- 
2.34.1

