Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7D7BC3064D
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Jun 2024 21:13:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 35E9910EB52;
	Thu, 27 Jun 2024 21:13:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CCysAjm/";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2064.outbound.protection.outlook.com [40.107.100.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0740B10EB50
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Jun 2024 21:13:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=klne6uhrNMFJJ7s1NqxQS0oLRK58PV5cfTxjvt9YvEFEqdAd7SumImS4LlCeLqijDZqR3AvOOnSEPoqOHewdPOvfXLHqpNh0ckgRxNu60bIfAwFRyv5MFewXROyP3zX2VNS+6rUov1cVigdkAGjY+zNGwAKZq8lZ9VmDkatLTBg2aSRKmoAJvvRx+iE8aTSj02NcA9LTXbfeEKXaRAEBjOF9AOCFIBxe77OIjdQZESP+Wc8ZJN0XNa/jbQgV4oolsCsSH9TGBTs/8lWB0JudYscd/klKFgotV5LQM8/eu5yxf2S5LuWb7IWqV+pEQYK6I0Q9JIlBXo9B8wfoO4OgNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ohP/zPpsLswjcr/Vmv7ElauArKZw0Gfbn8jm4a0BkuU=;
 b=hmhykPcECGMSKavJ+6Wlpluz4am/ccLgemU0QAXHHiN6DSoywowU/NFE/br//IkwtU9P09wRmhNV0JzXacJjwEjd+fXiOF8hCxyKtn+3dDxhgv52JWTfmJ7+Mrti5Kw6yvhPTuG2dRMGkVrq/ynzDLfILu1Ol6FHg4TB8bMUHPUF2kZWEvcbKrfXposxiGRtK/S6sQQkV3LnIyZzU2oTbR2YPqKiy5gtnFQvDdFqZLnX8bADI82Mvn5yzgb4akG63HzgIofLWX/ZVTa8tMS/gFS100lz9WeTBX7DngYbgY7UXjsC0PEJXSxQS2WGrvZ/BMcRR/P/tJFFbSk6eGno+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ohP/zPpsLswjcr/Vmv7ElauArKZw0Gfbn8jm4a0BkuU=;
 b=CCysAjm/NCykaJ5jUp8quo2XjIeCVUE7kLs4/OK09bG3P/k1ofE2DUKyJhh7UZaQU1MuW1TzPa3NFitTSGVf0vMLh/QykoNfmmLhU3tOxKZsxtiKm7VHoSJX8XCg7OfEDp32oodK/JZn3U2fur9qR1NgVtM0qObiC1H9EM0MLbM=
Received: from BN9PR03CA0579.namprd03.prod.outlook.com (2603:10b6:408:10d::14)
 by BL1PR12MB5803.namprd12.prod.outlook.com (2603:10b6:208:393::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.34; Thu, 27 Jun
 2024 21:13:47 +0000
Received: from BN1PEPF00004681.namprd03.prod.outlook.com
 (2603:10b6:408:10d:cafe::89) by BN9PR03CA0579.outlook.office365.com
 (2603:10b6:408:10d::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.26 via Frontend
 Transport; Thu, 27 Jun 2024 21:13:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN1PEPF00004681.mail.protection.outlook.com (10.167.243.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Thu, 27 Jun 2024 21:13:46 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 27 Jun
 2024 16:13:45 -0500
Received: from jzuo-linux.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 27 Jun 2024 16:13:40 -0500
From: Fangzhi Zuo <Jerry.Zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Sun peng Li <sunpeng.li@amd.com>
Subject: [PATCH 02/26] drm/amd/display: Reset freesync config before update
 new state
Date: Thu, 27 Jun 2024 17:13:05 -0400
Message-ID: <20240627211329.26386-3-Jerry.Zuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240627211329.26386-1-Jerry.Zuo@amd.com>
References: <20240627211329.26386-1-Jerry.Zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: Jerry.Zuo@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004681:EE_|BL1PR12MB5803:EE_
X-MS-Office365-Filtering-Correlation-Id: a319281e-ce45-4fc6-451d-08dc96ee0890
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+Pl3eHSqM/3J+6MzEAY8co3SOU/8YNsr92dfA6WN4o9hEI0ONiUdZZTPLooR?=
 =?us-ascii?Q?ZukROOG+8obO9clBmtSf35SzYU+rN2nz+GZ+x0e4/rGDyAMeJoSP8FHNNlRj?=
 =?us-ascii?Q?QP5sncmDLZ8KIOrMrNcf3erPA5pGxyxqkXlNRk8TKC5XAQKefR3K7BtJR/H0?=
 =?us-ascii?Q?MIRzQZNOhvwu3ZpCK3d7mtjzyDJPWvCcZipuCQCkvV8xeoVYg/FNj0LOX6oz?=
 =?us-ascii?Q?s8VRWAI1pD0WiripvcTSNN0e/aLVfPI2xtpkhITXunhFafbULL9YlYTulkei?=
 =?us-ascii?Q?lrQCnBzOIsWZ+0JjJVRZko524B/Vj09rNwxJWWXFdIWk2wBxvB8sKSJUaubX?=
 =?us-ascii?Q?DCZyqxxAsO4yzt7SW0bYCbFP9AiKRHZf2w31ztFRtZPZAr1SV/vOjcCiUp1K?=
 =?us-ascii?Q?p6vBRi3n++fLMTtFpFHRGeH0+RmWY7ryVryE7Ns+pfYcaH+zg1TOrwpYVHET?=
 =?us-ascii?Q?tvdlVJ85D4qcLeKeVMbchjGfcZ5kEllp1Y0bgZZ++sUtF1UcxLLueVI1o5QS?=
 =?us-ascii?Q?AeuayKvRx3Q58gmwJRFmv/SYyuGVpzR2QAExTZVeXG5t1upMOU3aDMl2nTvz?=
 =?us-ascii?Q?uvFVFqcXoX7j4aanOrbjc/Nd3SdPiZu1H+DDQujtZjny5fvyvRuJYeAtEG1D?=
 =?us-ascii?Q?0QZX8nr5cAjPAAn6yePgk/z6WPb10cnAGzuMuTmPinv/Y4Dnv0KLJjVbQfgP?=
 =?us-ascii?Q?OpMOGydPYQIdLJceIXvtM4Y3oXYPJfhxXx4E+AYdu+Df5DSj839fq1NUCYSe?=
 =?us-ascii?Q?2yh8+EtYz4hWZU92gLnykaWStFVu6Boh2kka1TGEC5zqcIqGKoFD2aUq2VDR?=
 =?us-ascii?Q?aPnm4PjME/OH7/UbB8TZMbiK3T7pknT0btdsWKwzgOb88qDheNGygOwbDki0?=
 =?us-ascii?Q?Dn3GFcZf9EhexRIvcM8qpuWIBPkxzVN7VsPf/YVw8TrIC1b3VO+srSRkaxOv?=
 =?us-ascii?Q?4zxH2mc1tzxuN3fcROB8oy+ITCVZvIVoyLQl2oFcd5rl2Rb0rZzIKNZFoNOh?=
 =?us-ascii?Q?rfv0KzUFulVQ2dXJN/A5YVV8oOzIPSQGXYbbXkH+vR0RdDxZouw5EGKx424P?=
 =?us-ascii?Q?rKuDmzt4kVVxd5DmapTskhosLGM2QsztTLM4ViOrthAo8S6aD4pGKvC7TQmf?=
 =?us-ascii?Q?eXFj1HMbK47VWL1swcOiTmd4fokl5Xq1EZ4N4yFIRUnoYk++hn8H73amRB6b?=
 =?us-ascii?Q?4XojI5Blh4sfe5/X0CI2li17e7HJLIPI4uRsvEXSIBPfYsNT8ZgtgkffJuxQ?=
 =?us-ascii?Q?pjSl8EADy0yFx9LAfW5cD8LAwEmvRY+3JNeNZ9NhtZNrglz17hLr24FOnluZ?=
 =?us-ascii?Q?B9RsFiOExV/EmFslPlkuAwaryE4rfoq+fvLmqhFUNxs7MsjvMpoczPHd7O77?=
 =?us-ascii?Q?GE5pRxxjiyMxu3ns5pMwrvtS3PbJepeXoOYX1EmzBL6jzeuyTSB4haXYSbG8?=
 =?us-ascii?Q?yr01UXMxP+vgRPpPWBJfgnerqJIr/jUT?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 21:13:46.7166 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a319281e-ce45-4fc6-451d-08dc96ee0890
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004681.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5803
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

From: Tom Chung <chiahsuan.chung@amd.com>

[Why]
Sometimes the new_crtc_state->vrr_infopacket did not sync up with the
current state.
It will affect the update_freesync_state_on_stream() does not update
the state correctly.

[How]
Reset the freesync config before get_freesync_config_for_crtc() to
make sure we have the correct new_crtc_state for VRR.

Reviewed-by: Sun peng Li <sunpeng.li@amd.com>
Signed-off-by: Jerry Zuo <jerry.zuo@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 89e371f870b8..11441c1a998c 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -10471,6 +10471,7 @@ static int dm_update_crtc_state(struct amdgpu_display_manager *dm,
 	}
 
 	/* Update Freesync settings. */
+	reset_freesync_config_for_crtc(dm_new_crtc_state);
 	get_freesync_config_for_crtc(dm_new_crtc_state,
 				     dm_new_conn_state);
 
-- 
2.34.1

