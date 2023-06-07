Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7162C7EE25
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Jun 2023 12:16:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 001BD10E4CD;
	Wed,  7 Jun 2023 12:16:28 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2041.outbound.protection.outlook.com [40.107.212.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F1E0E10E4CD
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Jun 2023 12:16:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BQITriK0A4EB36Al9cE0qPB/rwawQgqUnbdP3rrWz6T5u9E+N7t3vAtyCnAri/xjtui0s8ihBUEBnWYtEfpH7qkZd/y5fK1EOX1zw6AR0T0l5QWXDpC4BIbnKym/XOD/lTqNPtiIadFIA7aOOYR6ZqtjTvveDU0X9cFA/Gty62sURGxHNVIyz7tE9SWb6PZz0S2FnfwfzmRk/3QnyezzwCJlUIMN2o9r2fpUPWEIa5wMjMg3nOaCxH188JbLdJpqgtMbGektXKoKclrwbrWiJtCh018ADcYLOuGegoLjTaWbELjR8Lh8fF5ck9LKscy29MUi39dP24JNa0jAVD5XJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WacPc3PYjl2Z3cSTk4WktGKMXWwnc0p4yiY58Nvq9dQ=;
 b=MGEyrBRBpK1s2A7eECk01TUdc0BaAlripDAUKTFf4TeCJENrxU3kjHer1/COvIBE5EYuHhNaFCDUCubPoSdUAZCT2lIkotWXhUtSQk0x1aPUJGKUXmEMsSpqCoIQbqjSyk90ZaYCvM8z4KT+dqZ8qs18BZAQnuYPmGYpbWX2GtG8KPBJcSjuG6ZGO4XmNHUGcsZ6zFUga46OAv29w7UGb3OAFMb51K32+rlTt6qGOWkkusfW3cKmhAi4dw2AqZs+XKUoUBEtZgaMEpwVHNYH450ZJ9AZntdBgfpr6f1NhOpzSTecLMf47QZKDtp9l+YeV99IXEjD2iSwxf0rw7fEwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WacPc3PYjl2Z3cSTk4WktGKMXWwnc0p4yiY58Nvq9dQ=;
 b=PGK7Shb/4ss3rbQheXyET1841pjEA5ulZmG4i0TqoCqjfPXt3/WM6ePaU4V0b2IfbIVW/w3A0+3k/JJSp2jVrdeJQKu5/qif4816MnX8i9LDAn1nH7Qo+3e/ZxX3DSNaTAc5ahNPYIjYsUhPqpYg4nHURVT813x8ZHxXpsb40tQ=
Received: from DS7PR03CA0064.namprd03.prod.outlook.com (2603:10b6:5:3bb::9) by
 DS0PR12MB7536.namprd12.prod.outlook.com (2603:10b6:8:11c::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.33; Wed, 7 Jun 2023 12:16:24 +0000
Received: from CY4PEPF0000EE32.namprd05.prod.outlook.com
 (2603:10b6:5:3bb:cafe::f4) by DS7PR03CA0064.outlook.office365.com
 (2603:10b6:5:3bb::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.19 via Frontend
 Transport; Wed, 7 Jun 2023 12:16:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE32.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6477.13 via Frontend Transport; Wed, 7 Jun 2023 12:16:23 +0000
Received: from stylon-rog.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 7 Jun
 2023 07:16:19 -0500
From: Stylon Wang <stylon.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 03/20] drm/amd/display: Add DP2 Metrics
Date: Wed, 7 Jun 2023 20:15:31 +0800
Message-ID: <20230607121548.1479290-4-stylon.wang@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230607121548.1479290-1-stylon.wang@amd.com>
References: <20230607121548.1479290-1-stylon.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE32:EE_|DS0PR12MB7536:EE_
X-MS-Office365-Filtering-Correlation-Id: 49be1db6-ba08-4aca-b241-08db675102aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ts0ze9jUAjF/F/1B42iA3zljIvo+5k0HEKsC+j3RlgDrygZgpb56G2vgzLwWkWbGr++LOqyGRXQieO9vj3vW6CcdISUzeQtQSj7eiov3uQ66rUUMJDIYCKjGWB6FIIY4LlVIbRMrdaHi332jocIlVRCEEikLkUf55NJr2oMy/15SaLLtCo1trZoj322INjtttmFH1ikWK5RzxrZcFJzmUuqMKBXGjvpMezWCna+gHeru+i4YiJN8b90oAHwyqyBfBYaUXcw4EHvrqi8XXFh6oDMQdklZEWGznfnmSgTs4Cw524YIdQFoRSifKFOLqQ4MYXNYx8Asy+sWwR1ColLg8C1+weppD6exmkr/RC+7KRGanmI8qlH+mxg09MNptdl1g4t+IQ0zrAE2OY0gcFrsU6P0b6KT64vUXgD06jhvdaU87YCu8RcQxM8H4UWX7KMZ8/xkZsTEVBUrTxbUZgpn9tzkGtH1u8tdmVHpezg3XANhDwGpNSOS+YXv2lHQ1Gn9m96xbOxaBjAMZxuJiadU5jTxUakIxFs0pMeiI/y9IMgZpkr+H7bTLFlldpp4O21VoCYt9zjamK4ncAhrl+/kcNglTg0Trhw8bjWkQ3V2qmuNOVdqZq44GpkG1zpdFU+Oy8mq1IdVyRVp/bayzSoNQLMuVUdZ/uNO8fvOAgjz5/VUCYrpi2RiySdBe8tEoKyC8N06nxLp6PcUhHhBQnixwBJxAQfWyfnQHTD+PFcGURM7HPe1QT4W4nWNSH472vEGFKft2wk2nqLitgwccGIT8Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(136003)(396003)(376002)(39860400002)(451199021)(36840700001)(40470700004)(46966006)(8676002)(478600001)(8936002)(54906003)(6666004)(5660300002)(316002)(41300700001)(7696005)(1076003)(16526019)(26005)(6916009)(186003)(44832011)(70206006)(70586007)(4326008)(336012)(2616005)(83380400001)(40460700003)(2906002)(47076005)(426003)(82740400003)(81166007)(356005)(40480700001)(36860700001)(86362001)(82310400005)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 12:16:23.6716 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 49be1db6-ba08-4aca-b241-08db675102aa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE32.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7536
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
Cc: stylon.wang@amd.com, Austin Zheng <austin.zheng@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Martin Leung <Martin.Leung@amd.com>, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Austin Zheng <austin.zheng@amd.com>

Why:
Log DP2 data to be used for debugging purposes

How:
Check the reported link rate of the DP connection and
translate it to the DP version.

Acked-by: Stylon Wang <stylon.wang@amd.com>
Signed-off-by: Austin Zheng <austin.zheng@amd.com>
Reviewed-by: Martin Leung <Martin.Leung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h          | 6 ++++--
 drivers/gpu/drm/amd/display/dc/dc_dp_types.h | 2 +-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 360dd83b1a7a..7cf3e9510043 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1,5 +1,5 @@
 /*
- * Copyright 2012-14 Advanced Micro Devices, Inc.
+ * Copyright 2012-2023 Advanced Micro Devices, Inc.
  *
  * Permission is hereby granted, free of charge, to any person obtaining a
  * copy of this software and associated documentation files (the "Software"),
@@ -60,7 +60,9 @@ struct dc_versions {
 };
 
 enum dp_protocol_version {
-	DP_VERSION_1_4,
+	DP_VERSION_1_4 = 0,
+	DP_VERSION_2_1,
+	DP_VERSION_UNKNOWN,
 };
 
 enum dc_plane_type {
diff --git a/drivers/gpu/drm/amd/display/dc/dc_dp_types.h b/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
index 4a7f6497dc5a..55139d7bf422 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
@@ -61,7 +61,7 @@ enum dc_link_rate {
 	 */
 	LINK_RATE_UHBR10 = 1000,	// UHBR10 - 10.0 Gbps/Lane
 	LINK_RATE_UHBR13_5 = 1350,	// UHBR13.5 - 13.5 Gbps/Lane
-	LINK_RATE_UHBR20 = 2000,	// UHBR10 - 20.0 Gbps/Lane
+	LINK_RATE_UHBR20 = 2000,	// UHBR20 - 20.0 Gbps/Lane
 };
 
 enum dc_link_spread {
-- 
2.40.1

