Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 713E5C433EF
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Apr 2022 14:02:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA4D810E178;
	Fri,  1 Apr 2022 14:02:47 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2073.outbound.protection.outlook.com [40.107.92.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC74A10E178
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Apr 2022 14:02:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gq3NRioK1X3dByypRVgUCXGgvfC4CkOErEvL+ZBlGoyL5BifRhalPXhqy3Q0yMzP1n1bYJq5SOFQZ0Fp6OcGhx8oIFZo6TVflSJC80e9Iv16TKDT8eXHkBhdIgyL4OHAb7/mZtGNVyr+9i+fgnVfaXwDVvjGvy/wGZ7HLb4LVKlyNlJSKugMvf5aLL7iI9H0FDuCa2YGzg3lt6tUa0U8CFVyw8TOcN12g62IcK5V3KRCwIKOJrzNhkMyyactGRix4oiTwUNsxXnrhv/u+Mq6LhvDZol51144SCRcBDU8HbwFD21j9s0BcVvZp8Tqbo84zUJoyDhGb8s8YvPnijseYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WcxTaHFw9NShjeYtVmNDzOwVnU1txQvCXkN6hfzZw7A=;
 b=LJKlDnKqPu7M5j53FVI0UyIKRXXMjyQHPyvvQlxwsyyHkBcVVCu1ikkRM3ULQRNuXp/v1N71vjp1GbHh1ywE6JMLWPsM3iDLCS9W+NaWCVywi92BapUeU/UQ0a8rmqfSJy0aHJsQuiSKoEbjAlzAfGCEpTXFkbM9fiMEfvOmtanJnzjhKsOuRW7BPJ07fm/UgCHnuST0DEVHvKCVeqSalTawUVhbNFJdBZrM/vi/FlUBKH8jEq6piP2VESyAW9kCP7BJfz7rVxfeOnDuXPK3cBWBc22R/nJ/kwAXxgTph+mpg79kw8K9zMU/KqDzTinopzbAimj9X2w9N4tMQFcEGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WcxTaHFw9NShjeYtVmNDzOwVnU1txQvCXkN6hfzZw7A=;
 b=F7w9EjiHzv6sh6v/IA+dCdRQUyVkuIrWn1blM4kWKK5CO9VtjCqjB1dTPQuK8w6PEgMFSOFE8Khq7uVchHRTQ7ojFPu8R7znWiDwv+4jKmFY/Bco7CQtMTfzdK2Y0sfwqwRA1iLVqOF+vSOBwUIVb/fbAgjx0pHJ3i2Sy+XFCzQ=
Received: from DM6PR02CA0098.namprd02.prod.outlook.com (2603:10b6:5:1f4::39)
 by DM5PR12MB1321.namprd12.prod.outlook.com (2603:10b6:3:78::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.21; Fri, 1 Apr
 2022 14:02:44 +0000
Received: from DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1f4:cafe::59) by DM6PR02CA0098.outlook.office365.com
 (2603:10b6:5:1f4::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.23 via Frontend
 Transport; Fri, 1 Apr 2022 14:02:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT010.mail.protection.outlook.com (10.13.172.222) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5123.19 via Frontend Transport; Fri, 1 Apr 2022 14:02:43 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 1 Apr
 2022 09:02:42 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] drm/amdgpu: don't use BACO for reset in S3
Date: Fri, 1 Apr 2022 10:02:30 -0400
Message-ID: <20220401140230.2628733-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0070aa6b-eb6a-490c-0652-08da13e84afb
X-MS-TrafficTypeDiagnostic: DM5PR12MB1321:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB132198F34FE94258572C45ABF7E09@DM5PR12MB1321.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wu4WaAWGfmRRWkTq2/Gr8xeKZgBetAP69DIvUghlM6E47KMia1AApvmDsrcuTPOMSAyhCtg3WlhfqkwWJ/vbMTQ+fknfOdD99IQbrsexfwBKlNnKGEakYWPw+vIXWOPBWxXUH4H6+h4bGZp5RHryDT9BAXO72bc0jfuVB6jLGRslJDvbXT9LgVakVzmxDVISxGYrSQXWfv5qEJl3U48oLOVdIVKi7t82Z8hym5WoXv+BmHhjtF07wgnAtPr/yCVwJBmzkOpwMzNE/e/yU8O/rCqWBF6tnpJ35BMsmwdW2oh1KtiJBMcjlFeh8ajSWINH3Gf7oNeJz/uhJ4E9wWB/SIxP9LBBsRfKUpCw9zTppF504IOTMB/y4qK+oD/GdriJWQzX4YuEQ+Ir4VYz+TjHBmvMA+PPxzzaF+SXBb/+zVarP4pIdjjF4DMd+rEfxkJEf6q8k5+O15qkdnZ1T+/j3pRdpr3By6+Jl+pkOxcU7KCV7Rjefw8xbHfHRJbGP5iLADWgkChIiQtY8pjXLKmWTK/uu38sBub+y3D9Cz1BSYxba6+PkGfzzyPW9r8+6lSGKp4J74JqqD/mnZNync1WM3JWyDsftW72zKsN/dZ25sP4c7LzcEgSQqtr7SRGN+cuwR0oIPuco/ClppeIJOISUoqa8hUHwE+QFrFTY6zUhGwkw3vhw/KcGkWoAy7lcHNz7NS0IjDoffrf4Wv6Uky9aQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(316002)(4744005)(81166007)(70206006)(70586007)(5660300002)(6916009)(8936002)(426003)(86362001)(82310400004)(4326008)(8676002)(508600001)(966005)(336012)(356005)(16526019)(186003)(1076003)(2906002)(6666004)(83380400001)(47076005)(36860700001)(40460700003)(26005)(7696005)(36756003)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2022 14:02:43.6558 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0070aa6b-eb6a-490c-0652-08da13e84afb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1321
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Seems to cause a reboots or hangs on some systems.

Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1924
Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1953
Fixes: daf8de0874ab5b ("drm/amdgpu: always reset the asic in suspend (v2)")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
index c73fb73e9628..ee62c74685ae 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -173,6 +173,13 @@ bool amdgpu_dpm_is_baco_supported(struct amdgpu_device *adev)
 
 	if (!pp_funcs || !pp_funcs->get_asic_baco_capability)
 		return false;
+	/* Don't use baco for reset in S3.
+	 * This is a workaround for some platforms
+	 * where entering BACO during suspend
+	 * seems to cause reboots or hangs.
+	 */
+	if (adev->in_s3)
+		return false;
 
 	mutex_lock(&adev->pm.mutex);
 
-- 
2.35.1

