Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01EFFC4332F
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Nov 2022 07:15:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A35DB10E706;
	Fri, 25 Nov 2022 07:15:56 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4AA3910E706
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Nov 2022 07:15:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tf0Iw+MVM2Dp3FA/Xwey1wNKkbeaYhv79eCqHkYQ3sxAvRCwaxhMktca2K21ysgmS5XZ5aSbxjTx4HYtCVZUkbdmCKMBuqMOQATwSbWEDx1rZHuNtelMa8gRhYo0U4+6Ewo+tViWV67SjZIvbQ2jQb8PiKS46FTJYxRFwH23rM2saTWP/qkHkx6DftvOab5QBean7zaG2FV7ibbM7AisvIrpewAMVxG36RNZC+E/z9umXE67EGhk3EDWqH+3GPDjM4Zu9CDDlrG87OeqNOgA3aPT+433yO4krpaihjsTkFzOKRcShCrdQHI7HXPw6Cp8dF/gY/FivJIcaBmmq/umlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e8avMi/bhCKHpJ4iqxX7BqS1e+H4eYuhU+n5QrrTZUE=;
 b=oB+/H6EcJtrnmzGzRXcckK0IMW20jGXzvwuocYUhr4v2Vrhy2czcju5or95K2u1Y7lPn4fpsrG3qcxQdkkz6ymnAuaKK5gxFhUzYw5tnFPSsccBaR5u6ILqHqd2DYDlN4wJQQ+zxDpSFTp+WDzi1U8x96pjtfjiQZ6G2v6jGv8jK9IEAGhaIJ62IWTEgj/Ce82VFFD5983v0KABcUfMg2OaMDt0qJL/gqJbQIXvWBmH+8/v/ybnPIybvfp6H/WNLjMlG85xpmResBuK6qtQGbtHPCGXR6hgO9b9zu/DjzH6NqdYZeZRLeyfvUYyfrK6yRayYu5LDozXvG0sDym37iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e8avMi/bhCKHpJ4iqxX7BqS1e+H4eYuhU+n5QrrTZUE=;
 b=klWishJGLH2dWHjPj+LEswP6ntGgAfEKtr2hUufio7ENvvjZE2GFx5LDVcFn7+QRn7qkoKbNcerTEC44AK3haFFRRfBtcROi7BQKG7g2AZKj+w42I+2oaeAXrwk+5YhXiZPSnw61RV3BmmvGjk+o64f7e61L2pzku3WQOaLZPsw=
Received: from MW4PR03CA0134.namprd03.prod.outlook.com (2603:10b6:303:8c::19)
 by LV2PR12MB6016.namprd12.prod.outlook.com (2603:10b6:408:14e::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Fri, 25 Nov
 2022 07:15:47 +0000
Received: from CO1NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8c:cafe::61) by MW4PR03CA0134.outlook.office365.com
 (2603:10b6:303:8c::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.20 via Frontend
 Transport; Fri, 25 Nov 2022 07:15:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT041.mail.protection.outlook.com (10.13.174.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5857.19 via Frontend Transport; Fri, 25 Nov 2022 07:15:46 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 25 Nov
 2022 01:15:42 -0600
Received: from shikangserver.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Fri, 25 Nov 2022 01:15:41 -0600
From: Shikang Fan <shikang.fan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: fix for set df cstate failed under sriov
Date: Fri, 25 Nov 2022 15:15:18 +0800
Message-ID: <20221125071518.3522-1-shikang.fan@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT041:EE_|LV2PR12MB6016:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c2370c8-3f24-4af4-d410-08daceb4df9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DONCnKHWrvKPy1u+l/nIdnFGxEXJT3vCRpQdEa7PmKCJ5ktv3yBBNg8wTH7GyP/okfoA5yUu2kFSkfxLO6Q/YBtJWK5X8VdfPpJofMXK1AzeqLkOyt7yy6mtLqkVOgu08E4yFTzWcEU3xVUrL9/HFuDr+Fr+4Y8wN2NzML+wrA6iXkT3ZHpHzD6loC35EmD35AEc6kRA8NoKtzKO2LBkiN5X3oh5tVf6ps5uCDIxnOJwZ2LzzHPZ93JaTwYa5H4cZzVzdJz0dLY3a5tyq+LpwTrGWi26CRG82bFzLMXKwAuOs/Fjbi3P7xkoydUWuDkyq/c7mF55a46Bcu1i6+Fb+3lIk95oYw+M3qmcw+HtyxjJTzCBhsn9tNkAlOLreK9OeULfyGffhN0g6IjzmEKDvWB0NXVFCOb22Fh18Scn5x29mxsA3tJ1BnyYURQeHcftHKd6YwyMWMpv5JPBXLJNe4+CoIZmSjbqKG8e2fnNPgBFmWNrgJNfnkJyjDfmr+HUmNTGsjPFe6hvLfP2HtfDfDYnBtrD1bjHxWeSGDxBNVXmRgqSOW66G5FwNzKVCHs3q6z+97biafzj+FN/YJQVQVWALM/HVXTqZ4E6bGMqprUHRzRrAuCgkIaizwW5xj5IKftxbp7OAilv0R/4cKBX2NnhcaE79mw6NQKgg2PoXbhCgcy+scYRLXwlWZwsEe4RetqxEO3HNrIY1bTEO4fw5DTHLudDt4Jg2ZYnyh87F6U=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(396003)(136003)(39860400002)(346002)(451199015)(36840700001)(46966006)(40470700004)(44832011)(40480700001)(36860700001)(47076005)(5660300002)(8936002)(7696005)(478600001)(82310400005)(36756003)(8676002)(70206006)(26005)(4326008)(6666004)(70586007)(86362001)(40460700003)(316002)(6916009)(82740400003)(41300700001)(81166007)(356005)(336012)(426003)(83380400001)(2616005)(2906002)(186003)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2022 07:15:46.5841 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c2370c8-3f24-4af4-d410-08daceb4df9a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB6016
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
Cc: Shikang Fan <shikang.fan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

- set_df_cstate won't be called under sriov case.

Signed-off-by: Shikang Fan <shikang.fan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 818fa72c670d..c557585aa46c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2943,13 +2943,15 @@ static int amdgpu_device_ip_suspend_phase1(struct amdgpu_device *adev)
 	amdgpu_device_set_pg_state(adev, AMD_PG_STATE_UNGATE);
 	amdgpu_device_set_cg_state(adev, AMD_CG_STATE_UNGATE);
 
-	/*
-	 * Per PMFW team's suggestion, driver needs to handle gfxoff
-	 * and df cstate features disablement for gpu reset(e.g. Mode1Reset)
-	 * scenario. Add the missing df cstate disablement here.
-	 */
-	if (amdgpu_dpm_set_df_cstate(adev, DF_CSTATE_DISALLOW))
-		dev_warn(adev->dev, "Failed to disallow df cstate");
+	if (!amdgpu_sriov_vf(adev)) {
+		/*
+		 * Per PMFW team's suggestion, driver needs to handle gfxoff
+		 * and df cstate features disablement for gpu reset(e.g. Mode1Reset)
+		 * scenario. Add the missing df cstate disablement here.
+		 */
+		if (amdgpu_dpm_set_df_cstate(adev, DF_CSTATE_DISALLOW))
+			dev_warn(adev->dev, "Failed to disallow df cstate");
+	}
 
 	for (i = adev->num_ip_blocks - 1; i >= 0; i--) {
 		if (!adev->ip_blocks[i].status.valid)
-- 
2.25.1

