Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97833C4828F
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Feb 2024 04:55:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4EE3B11310A;
	Wed,  7 Feb 2024 04:55:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cuUA/0Nr";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2056.outbound.protection.outlook.com [40.107.237.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1614211310D
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Feb 2024 04:55:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b8/usvx6RUI1psVcR2xSDY0jnIl1yMB3fApEMqAt49E89aFLE4b4x3TSe1jmYjphHa9EhMJLDZLoK7AuxgUdKznbTwKtOGufW5zi3CEUj+WYaMOt/3K312b0kSUotCGnUB8qVtjJKeRiPGVj+hF62tzolaftV21o008JTvJNVBiLyUNAUlpPPO9U8y8Wzb6MD4AnrqCirABnPuznArssc51Ia67HqmjQtcjXLWmkDGXQk6T5/N+V9Ae4v0uJrgLMLTPxrMGiuV4Uzy1Pa79aZvH78IZBLNgvAurpFCwNhU8wmqCbX9GarCnECNXO3NFlzAsyYDicAiwb9+uX0vaOVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lrdHz4DOmNqvoLGRktLAEKaIjyH3s83lmfiRpiKfpgU=;
 b=X3KZHXirpvEOckg+GdUwTc3l2kQuxAHsFNU9/jw5h139ROTuHd8cYYJMTlX0PXFdMo6D+xxyHPqIowxtq73fiAuyh+xxK4D8XdZkj5bZm/8LZffqdqKPvssHK9wuKOdh9dK4lhz6TV3Qh2RNuuskG4surd2NldvYFHKdfOikH5F+EzqYczVuhl0JJ1fgrbzoT42pN7rhdQoUo2I1cAD7Bl+TqlWkDLJMH8GhToPg5x4Ix7MRugBTSv8zSS94VdCRdjWxc7RnXTK9/j4en0ii3s+c/GKTJBXHEqJ6+cJB3+E9W8rZmiqBIcj5YZPcDfYLw6UpjtZ7X83NWJnonfN5OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lrdHz4DOmNqvoLGRktLAEKaIjyH3s83lmfiRpiKfpgU=;
 b=cuUA/0NrRRDVH528kZPNPGhlIcWMeRoqBoRVDhY0lgsU8s9OzUQa3+7TLgEY/opQUstvoOorTxzR27QzmZQvmTJ/bPLpxXzTdMmLGdY1GuAsW3BTba8/6xreHbwDvvg//7WZFwG8M8q2dd/qp6pjcYCe+JtFIn7mYud3JmCwLRM=
Received: from SJ0PR03CA0297.namprd03.prod.outlook.com (2603:10b6:a03:39e::32)
 by MN0PR12MB6365.namprd12.prod.outlook.com (2603:10b6:208:3c2::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.17; Wed, 7 Feb
 2024 04:55:30 +0000
Received: from CO1PEPF000042AE.namprd03.prod.outlook.com
 (2603:10b6:a03:39e:cafe::d9) by SJ0PR03CA0297.outlook.office365.com
 (2603:10b6:a03:39e::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36 via Frontend
 Transport; Wed, 7 Feb 2024 04:55:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AE.mail.protection.outlook.com (10.167.243.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Wed, 7 Feb 2024 04:55:29 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 6 Feb 2024 22:55:25 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Harry Wentland <harry.wentland@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH] drm/amd/display: Fix possible use of uninitialized
 'max_chunks_fbc_mode' in 'calculate_bandwidth()'
Date: Wed, 7 Feb 2024 10:25:00 +0530
Message-ID: <20240207045501.3344729-3-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240207045501.3344729-1-srinivasan.shanmugam@amd.com>
References: <20240207045501.3344729-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AE:EE_|MN0PR12MB6365:EE_
X-MS-Office365-Filtering-Correlation-Id: f4b9a6e2-7c04-45dd-a0c0-08dc27990227
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FUxPyXKvi5NfL271rks2Rvp75kss/gEoJlqUF4NkIebc+pkUgWOHrc7399Il13BCCtjzB2IC5bhVeVpcN7iMydV6g6y1L2h2abSADCs3dBa17JbGgKqhADc4GupRXdy4NpUueyqvOUyMzZ4bx/9DWOmWdG9HoKJuNwNBSjjpBbflKjHxnXzC4c+hVtWcGKHxWZG8iDsjWB2CemAwAzp6DLwM7zsMmU7NBJMAJ4Cgxm/6TbFgB07aKAUMwnfzI+epefburTXcMKD4xCsxo+VoFKAObeA0AgvrE4xpiUQ0r8ZPJbeE7Z9BsSFBBHx/jjEGeqndZk+9kMSQcKolklNkEnhgJMS/gzPgL1+lRovSE1OWrJ6cCK62Wnb9ksMqD4Y0tfIeUmJLFzulHTWE9oq+m4MqjMePr8I2pusFyGe0WN0UXJQiXoLNS8RXqS8ejrFYF5KTucWfp42x2YpkId16dkuNj3td1cXfn2M2apjMNyU04NIRv2obHGMEF1w4KUFN01ssfjAGUsmwwEzPHo5Rvvs3DIdBL/XuOouiDLjaT+3MwPcB33NWP8oTwEXl5q7Ep3XSJ9YUps93Do0xl4LQr4g5r+5ENYtVZXMtSqxINK4I2fGB4sUs1a5QN904AqDfXzIFVMkCCB7uc3KSqL/JF49Qs5T39dskGQ+stOoEe23L8jbLNPIFEIisZU3fniS3m9TxjsBH8j49B0h5dWjBalh91kLs/fvTvH7VzSCYbq+CqMBz7gynQynybGrY4Yh+FgtfpVprkHThkn0FJFVbIg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(136003)(346002)(39860400002)(396003)(230922051799003)(1800799012)(82310400011)(451199024)(64100799003)(186009)(46966006)(40470700004)(36840700001)(44832011)(41300700001)(36756003)(8676002)(4326008)(8936002)(70586007)(316002)(54906003)(6636002)(110136005)(36860700001)(5660300002)(356005)(86362001)(70206006)(2906002)(81166007)(2616005)(47076005)(478600001)(82740400003)(16526019)(26005)(336012)(6666004)(426003)(1076003)(83380400001)(40480700001)(40460700003)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2024 04:55:29.7680 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f4b9a6e2-7c04-45dd-a0c0-08dc27990227
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6365
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

'max_chunks_fbc_mode' is only declared and assigned a value under a
specific condition in the following lines:

if (data->fbc_en[i] == 1) {
	max_chunks_fbc_mode = 128 - dmif_chunk_buff_margin;
}

If 'data->fbc_en[i]' is not equal to 1 for any i, max_chunks_fbc_mode
will not be initialized if it's used outside of this for loop.

Ensure that 'max_chunks_fbc_mode' is properly initialized before it's
used. Initialize it to a default value right after its declaration to
ensure that it gets a value assigned under all possible control flow
paths.

Thus fixing the below:
drivers/gpu/drm/amd/amdgpu/../display/dc/basics/dce_calcs.c:914 calculate_bandwidth() error: uninitialized symbol 'max_chunks_fbc_mode'.
drivers/gpu/drm/amd/amdgpu/../display/dc/basics/dce_calcs.c:917 calculate_bandwidth() error: uninitialized symbol 'max_chunks_fbc_mode'.

Fixes: 4562236b3bc0 ("drm/amd/dc: Add dc display driver (v2)")
Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/display/dc/basics/dce_calcs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/basics/dce_calcs.c b/drivers/gpu/drm/amd/display/dc/basics/dce_calcs.c
index f2dfa96f9ef5..39530b2ea495 100644
--- a/drivers/gpu/drm/amd/display/dc/basics/dce_calcs.c
+++ b/drivers/gpu/drm/amd/display/dc/basics/dce_calcs.c
@@ -94,7 +94,7 @@ static void calculate_bandwidth(
 	const uint32_t s_high = 7;
 	const uint32_t dmif_chunk_buff_margin = 1;
 
-	uint32_t max_chunks_fbc_mode;
+	uint32_t max_chunks_fbc_mode = 0;
 	int32_t num_cursor_lines;
 
 	int32_t i, j, k;
-- 
2.34.1

