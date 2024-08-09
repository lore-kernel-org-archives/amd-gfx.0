Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97058C3DA4A
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Aug 2024 07:37:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C36B10E711;
	Fri,  9 Aug 2024 07:37:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Vj+udy4Q";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2079.outbound.protection.outlook.com [40.107.244.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 44E3A10E711
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Aug 2024 07:37:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m5EUUqSysl/rWzw3ZWmHFfJ4Tp3uzun3ZGIsA776w811ImILWwl1yXSNFm2/kkkxoQDmT+LYQwqhPS/sLOl43BrQPKrn3iN8S8AYqMQo2nriPXoMyHj4NIfP19r27H8M46eRRoY1k9weB30XoSkGviRC3U683pS4o1hmAzRc3pffHBX3/2qaI7iE3LbF0aMuk6FSj+9w+E+WqXCOTGraVKI5rfThy1wudfNE7iz2C9Lxio29JfIvoSMaMXiDrx5Alo0j5OkLFpU3oOLIbetMIIDgEK/Cp6O69nW9Iz/zxVXitgyQMLe2crdSJU7hnPkizGuEU9oqo12rvHz7ig9f2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bLaiBXP175AS9OeO+IPpTdSbavFASl+UhK7k8Hy3Rew=;
 b=a0ADEAu9hGneCRr+AD/9mmLuEHbrCp5rKv1JdbvFr7LcvTXI5x61LMr41FTQt5C2Kv3+l3ruaji3aLDf7yR1A/Ywc7Kr3gQRrT3W4+N56D7Gf3a/+YBXo+iwaD9r9y4UQ2fVJcNgxEquJZb/QL4lIy7kG7Oq5SR/Gve51Btqc1Pze+p9xovMIOaMJ2FODvIrgpqS1ZFM2vGg0e/57w61U+qzl1QtizwqO8ZnGQ5mPLJzmv2lvkjyOetYWBsKgjQ3dxaairrceQhg3nrrYv6IK//H1FcibIVcHAlQVCvozcsS9Icbuoy0nPiwLIe+krkdOrjldflDYmvW/SlCWVai0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bLaiBXP175AS9OeO+IPpTdSbavFASl+UhK7k8Hy3Rew=;
 b=Vj+udy4QhLatzbAGJtnLKtsA1nNX4rNcSdZoPneHspuQxvvuIjylluhhvNNMbYa3n4zHJ02OyyEU9t9PZ0cB2NM4/cqlUBB6zNxz+ZaYdl9xvQlQ7/wfbFfKkcyNGosChESJ4wUd5G56xdPBMf3KSPIFdWE0cMoViEGWxpKjAkY=
Received: from BN1PR12CA0013.namprd12.prod.outlook.com (2603:10b6:408:e1::18)
 by CYYPR12MB9016.namprd12.prod.outlook.com (2603:10b6:930:c4::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.13; Fri, 9 Aug
 2024 07:37:15 +0000
Received: from MN1PEPF0000ECD5.namprd02.prod.outlook.com
 (2603:10b6:408:e1:cafe::d9) by BN1PR12CA0013.outlook.office365.com
 (2603:10b6:408:e1::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.15 via Frontend
 Transport; Fri, 9 Aug 2024 07:37:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD5.mail.protection.outlook.com (10.167.242.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Fri, 9 Aug 2024 07:37:14 +0000
Received: from ldev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 9 Aug
 2024 02:37:12 -0500
From: Tim Huang <tim.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
 <jesse.zhang@amd.com>, <bob.zhou@amd.com>, Tim Huang <tim.huang@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: ensure the connector is not null before using
 it
Date: Fri, 9 Aug 2024 15:34:24 +0800
Message-ID: <20240809073425.54632-1-tim.huang@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD5:EE_|CYYPR12MB9016:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f08ec25-7b92-48fb-756a-08dcb8461692
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?KFO1YyktZNfKwL/Ngn9eYs67LX95eZ0Z7j4uS9jM7HYKQ8npwYOtcPqc8lyT?=
 =?us-ascii?Q?WV++wPCQkqhgqNJqBg5qn7SwV2kD9LVUTlBYUBMacp7C3eKR+CwlgCP5HBzQ?=
 =?us-ascii?Q?94nTDweNcktfe61fQkPW86aVaba3oqO8OobEifQzJMFK56bIYyjBonFxZz1f?=
 =?us-ascii?Q?syHLI2hSRdY5SJEY1xjfz0ICSptK6OgsYrl1VtgLukB55zoltjwk6+nzhod6?=
 =?us-ascii?Q?JNkYoxLLNpodRntIrkwbaHt7fZezlO6q4vYycc1hRQJ3eIDFLxBlOKdpAW5z?=
 =?us-ascii?Q?/wb20R8J/UVbJYYMPGu+rn0UPbsqHbDys+Up4st4hFzl9LTvF/TDzEHJ0CFn?=
 =?us-ascii?Q?juCg3RpcCUKWCVqVGAfjz3PA6/Gan4s+EQuttdNN4WBzWXLqd5Pe91OJKIsK?=
 =?us-ascii?Q?rRvdILiL0WrCZnT4hZxpwQ+fhSIoDqNnqOjIjS4YkRdUYCb8OP26t1PCzoZo?=
 =?us-ascii?Q?mHGvNgW0TJZ0X6fAC8rEuo8d2CTHDfjd1DeeHA7VZdoEaialP+B3ocHzTJk/?=
 =?us-ascii?Q?Xyz8oxnBu0Y/08FljH2dlWkcy79a7LfIgL9yxDRXcYW9tnWqCLL6aa3wSrz1?=
 =?us-ascii?Q?AQPCsb/5CXs7+8O/USeiJIZ3tocqN9Y/7Mz65E0a4J0BKhZXbQ1tMn2qR9GG?=
 =?us-ascii?Q?9WumtuC2ac8wbfHk6G4O/InlfCZV63U4LgNBFcoYdHsS8xEnxAUuV2PtkMBx?=
 =?us-ascii?Q?Uw1SfbCmqauxT7HeTiv3tMmQYjkmfTx40NuA7nbhk46auK3P9Jjz6TE7yE/S?=
 =?us-ascii?Q?2MXchrSjVBQz9iaSWvZLht9Qw/uOVAiJC1JI9AC3o7AoMMNhUwIBHFzaen+X?=
 =?us-ascii?Q?Z1SENYMnreYucOPCbWMgJeJO3JGhCXOQCVlHcPmif21uc2kpF6RFtkAyDAwW?=
 =?us-ascii?Q?/+CvV8EfPUzJOvFzUd1sCRHhmqZpHY+wVD0oCTS15jCGinTLVIqw3r/OA63d?=
 =?us-ascii?Q?jbROaY8saje9IC577tssTiNimlzhsZULeM1nwU/HyPhqFERLC5m+p4SFWVKU?=
 =?us-ascii?Q?m1AZKrEoTEzxdZyPp7doPAJkpYst2wKw8CGA1wO+jubfR9QVnTfUqVz1rcxs?=
 =?us-ascii?Q?dLeVRYEnpTr8LaYaDOKkt5UBKE5BbVzM89fqUQHc3QpCoFnzb5zzC5eluSSb?=
 =?us-ascii?Q?u4OqElvJkEVBCsHXPy9rvGObt0/iFNLTe3peDyrq8uHfqsp+uPppJtFGogLz?=
 =?us-ascii?Q?lDeXnUq+MisMm7TPUEyvdLxCbUyufBPiRvj5tJVnVvQXsw8xhjA9Y/M47xYh?=
 =?us-ascii?Q?q9ArOtPu7gc9d7Xj39+06CBT8a9h5BMdezFQ9uUbvKfddQdDXUYTuLyNbGlz?=
 =?us-ascii?Q?tgsUmCRYvrdLVTyxCvDrilw3fY8LxtzBnyxCb/mCUS7drupiZOB7i3C5k9jZ?=
 =?us-ascii?Q?z2hJHGLObAMffx5YWsY+Hc5UYlfo3uMjlw3FL0W1RtUbM05xqnrtm88K89Hk?=
 =?us-ascii?Q?U/VmeAXvAxlwAZygCGMiQEXzHLTFsLO5?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2024 07:37:14.4905 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f08ec25-7b92-48fb-756a-08dcb8461692
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB9016
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

This resolves the dereference null return value warning
reported by Coverity.

Signed-off-by: Tim Huang <tim.huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
index 092ec11258cd..046d4c4e0299 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
@@ -1474,7 +1474,7 @@ bool amdgpu_display_crtc_scaling_mode_fixup(struct drm_crtc *crtc,
 		if ((!(mode->flags & DRM_MODE_FLAG_INTERLACE)) &&
 		    ((amdgpu_encoder->underscan_type == UNDERSCAN_ON) ||
 		     ((amdgpu_encoder->underscan_type == UNDERSCAN_AUTO) &&
-		      connector->display_info.is_hdmi &&
+		      connector && connector->display_info.is_hdmi &&
 		      amdgpu_display_is_hdtv_mode(mode)))) {
 			if (amdgpu_encoder->underscan_hborder != 0)
 				amdgpu_crtc->h_border = amdgpu_encoder->underscan_hborder;
-- 
2.43.0

