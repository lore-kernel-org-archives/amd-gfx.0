Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65DA7C77B7A
	for <amd-gfx@archiver.kernel.org>; Tue, 30 May 2023 20:34:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EBB0710E42C;
	Tue, 30 May 2023 20:34:36 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2063.outbound.protection.outlook.com [40.107.212.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF33110E1AB
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 May 2023 20:34:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ivNkrUvSgUb3UOBOko3auyI1ZoKUhb2CBzyrMQ5ueHrnp+orwIQ4pMCFaVv3fWdq5VFRCruhF/qbY2D2GpFKW9WkjuBJnn4QLRM9yMSTMLV79lDgd0NjZt35mz2bvwk/EScVlZTYZAODuUdAC9md3/mkQJrGlKGQrQbyaoXz47mTAE3W8EgFWMb3qnMqvtaWpbJgp2dBNyHIJajw83bSDWYBDbVCdcbA15iyCw8AeKkOLkRAeLevaxMH3E5LLws6Q8xaxfcTKRam3AoW4OMVqWVBhBvBt3/lldO5Ao+58igzemOyDbv7VmbN3vRDzd9toikTEzaesyGI28dtIYBo8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8KV6l7Y71wJelWeenfIpgB/zp8SP8MoAeH3nwYZ0KUM=;
 b=EGSBDaAXOnya4SAkt4NwRTUDgh9X4gYFgVzZHdEQ3MxWZ+btwN27f1nvlgNL00d4ojLeOYwjPbbM1SQLZv9NTW0rD3Ozaf3n4lyTJ9fJNCAvhBZNUJ5VNYOUSbMSjHcg4kK3G5uWENTCuhFAY4pqCBxbUpkITysSRrtkIf3C6+1eO6mLVKYS4u2sy5Wj6ZLO8BWkszEjPfvSB4WbWO1eLRcfdtHECLKqcG4MheyrNL7dsQfX8MyV9pTUMxUM1922Qe68SCT0pVjmigN6Vs22lFVQS1KW+mTeOvs4002pQMm9pqH5vAz1CzYscv3jUdCKAD9mCtPok4L/Yro7pvorbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8KV6l7Y71wJelWeenfIpgB/zp8SP8MoAeH3nwYZ0KUM=;
 b=BGsYHQp16H1c9dMcK40en520NvgvqKR9Hwul8NHA699VrhusOHy0aI811PRwX5gFwx18eUu3uyOtr4pRyuYPM7HfBLBFK42YMJZNY8S7MD/H8lkd1xhLbh5q+TBrIWE208v1CFv0Y1KBO5pxqEveE3zQ6QPeswQNr5BVtRuVA1I=
Received: from MW4P221CA0017.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::22)
 by MN0PR12MB5930.namprd12.prod.outlook.com (2603:10b6:208:37d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Tue, 30 May
 2023 20:34:31 +0000
Received: from CO1NAM11FT090.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8b:cafe::97) by MW4P221CA0017.outlook.office365.com
 (2603:10b6:303:8b::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.22 via Frontend
 Transport; Tue, 30 May 2023 20:34:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT090.mail.protection.outlook.com (10.13.175.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.22 via Frontend Transport; Tue, 30 May 2023 20:34:30 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 30 May
 2023 15:34:28 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Aurabindo Pillai <aurabindo.pillai@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, "Harry
 Wentland" <harry.wentland@amd.com>
Subject: [PATCH] drm/amd/display: Add gnu_printf format attribute for
 snprintf_count()
Date: Wed, 31 May 2023 02:03:42 +0530
Message-ID: <20230530203342.3161018-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT090:EE_|MN0PR12MB5930:EE_
X-MS-Office365-Filtering-Correlation-Id: 7861617c-77c5-4e77-b78a-08db614d4594
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pJtbUpIDSboughB2jzJSNyz1vy/SnYruQo3fovHuiQQrwSa01T/VXVzqCzOL++72+6siE2/PnmFArahmifA3c6+brKNIYTq0hLQwnTO7KHJVfb9w/+fwsHo7tByVxBaA8mnYdr2liwSlJOyc1zsAm20hlgBKHGmYJGeK5kKpdfKBbBjlzNujVeBu8ZHzers7vORmp7v5AoB7aAhD0s1bSsXkEai2pAkhyhrTb4BHXZqOge6ZnGGtkmlVIcKZpxleGHTIZigj2l4kYlmc8Rugzs2dRkhRJk9fvFJJ1evH3ROotSi28iNfAh7+6TJB5fKEEZjw+pvmmW7YoiOKrqs/sNb+eTMtX1+Y/GmHpzLc0st+Nn4u7pwikDojy3uWYAxdeBNmTsEfF0y7yavVlf4HpoZYjtJWjTQ91tcv0Ra7ZQPYW39DoOn5L82Ea3fsu3BelMFV5NIyNgHbxiaHMJgbaL/b1glGGffeQ4fV+usD9Ol8hHs2ApITHaQ9py3Zi2qPq+2Q5FKLzMRscFkVSu9wk+FUAFwQRMNpSTidafDugZg2NOsK8xzYUj+FfFiwV3l4lIlnh8I6jf5pDkcrsHLumNSva++nutoFsdQqP8Ok7Vw3Ul5Oe0gWgH4/TTr0gymTu5DamOIzICLIoZCRuSiPc5D9+YEvMacsM/eWM+l0tRmX9OKQlr5LWkH9PxNGe5pKE0aH3W0epn2DuEc1D5rz8z4cJTFCO2Z9cab6sPicNSFeuuWZpdD0xkDTUIxx5W+i5BpRamUrr8CP6Tgwo7CaBg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(136003)(39860400002)(396003)(376002)(451199021)(40470700004)(46966006)(36840700001)(86362001)(36756003)(4326008)(54906003)(478600001)(110136005)(6636002)(316002)(70586007)(70206006)(6666004)(7696005)(40480700001)(82310400005)(8936002)(8676002)(41300700001)(2906002)(44832011)(82740400003)(356005)(81166007)(2616005)(5660300002)(336012)(426003)(1076003)(26005)(186003)(16526019)(36860700001)(47076005)(83380400001)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2023 20:34:30.9401 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7861617c-77c5-4e77-b78a-08db614d4594
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT090.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5930
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
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fix the following W=1 kernel build warning:

display/dc/dcn10/dcn10_hw_sequencer_debug.c: In function ‘snprintf_count’:
display/dc/dcn10/dcn10_hw_sequencer_debug.c:56:2: warning: function ‘snprintf_count’ might be a candidate for ‘gnu_printf’ format attribute [-Wsuggest-attribute=format]

Use the __printf() attribute to let the compiler warn if
invalid format strings are passed in.

And fix the following checks:

CHECK: Avoid CamelCase: <pBuf> +unsigned int __printf(3, 4)
snprintf_count(char *pBuf, unsigned int bufSize, char *fmt, ...)

CHECK: Avoid CamelCase: <bufSize> +unsigned int __printf(3, 4)
snprintf_count(char *pBuf, unsigned int bufSize, char *fmt, ...)

Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 .../drm/amd/display/dc/dcn10/dcn10_hw_sequencer_debug.c  | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer_debug.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer_debug.c
index a0f8e31d2adc..46a2ebcabd1a 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer_debug.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer_debug.c
@@ -45,7 +45,8 @@
 #include "dcn10_cm_common.h"
 #include "clk_mgr.h"
 
-unsigned int snprintf_count(char *pBuf, unsigned int bufSize, char *fmt, ...)
+__printf(3, 4)
+unsigned int snprintf_count(char *pbuf, unsigned int bufsize, char *fmt, ...)
 {
 	int ret_vsnprintf;
 	unsigned int chars_printed;
@@ -53,15 +54,15 @@ unsigned int snprintf_count(char *pBuf, unsigned int bufSize, char *fmt, ...)
 	va_list args;
 	va_start(args, fmt);
 
-	ret_vsnprintf = vsnprintf(pBuf, bufSize, fmt, args);
+	ret_vsnprintf = vsnprintf(pbuf, bufsize, fmt, args);
 
 	va_end(args);
 
 	if (ret_vsnprintf > 0) {
-		if (ret_vsnprintf < bufSize)
+		if (ret_vsnprintf < bufsize)
 			chars_printed = ret_vsnprintf;
 		else
-			chars_printed = bufSize - 1;
+			chars_printed = bufsize - 1;
 	} else
 		chars_printed = 0;
 
-- 
2.25.1

