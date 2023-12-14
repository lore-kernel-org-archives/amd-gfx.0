Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF061C4332F
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Dec 2023 22:21:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA54310E2FE;
	Thu, 14 Dec 2023 22:21:50 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2064.outbound.protection.outlook.com [40.107.243.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 387D210E2F9
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Dec 2023 22:21:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lyReubKnpEOxLLS774FQoWJHfFNKBy1zB1Shx8kpUeAwgVJwe++hme0bWoeij3GQo3HcYrvKZJYSz5gJmBTfSbC11apek5oYnVyuZ6kLaJR2JH8xlU6iR6ywuVwMezik02nFuTyhtwaD6No59egkh2x5JbkPDlJKFoBEsdTOm3Mtda+VSNit2WNrcu/t9JiIyYcwAtgRI7b0tMopT6PRkEeJ5h1ZJXGNNNNoLgC3K38x50G1ZXKPf2HHz35DnnWTVfnypklPXqSWf5fvFfmKDDeLo5HgkR0bqxcF6pNw1dXqdz50hxCA5p64WltO6IYVmcy61MF/nOP/J9rQtK79Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xZa/3FRJnoCxmVi59dr4khn/eqzwdmfqjy5goVXonpQ=;
 b=WJ9511QXTfF1AYLFpCVwRXzWYmS0g3DrvxCxuDBGATxF1/BBP60htZl6EfKePetfpMLBNHar530lZSCbUwzcJ40R0NRlgvuZhfiqCOFF8pGARzmgbxeth9pkLrL4jm4fe/X37P6hvJuGJo4ZxXu7+EcchWFD8EFhSUhwOUV04dl0Tmaiv8qR1cXmYdylwT3R9Vog6DLmjccKr2nDVqSX6l87zc3rvNM0pH3hwK0QrIkrcidn7xyDrLhfQqaPBeysoS7SLnRDcylE8C1XKdsoYRuNVRmpYgPW9RasRSn5TRVa88Xb/y8J7HP/rDIvUZnr8TQo59uGwsV219e2NyOmVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xZa/3FRJnoCxmVi59dr4khn/eqzwdmfqjy5goVXonpQ=;
 b=LNJa0hFlCL/iUXi3fxYcVSXWoOW0MADZ5F/vJiwn+ihl3OamqNP0OXQ4aF5qxX4xmX4sKZkm4s1+hZd56ZjbpzxpXTcd9ophfjJ+7SlExTBjH9pWmsiTvRTlBd/j5HFODhGuTt9RyPFKL1A0c6McsDvdU68YXniPsxevfczcxgw=
Received: from BYAPR06CA0016.namprd06.prod.outlook.com (2603:10b6:a03:d4::29)
 by MN0PR12MB5883.namprd12.prod.outlook.com (2603:10b6:208:37b::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Thu, 14 Dec
 2023 22:21:44 +0000
Received: from CO1PEPF000042A8.namprd03.prod.outlook.com
 (2603:10b6:a03:d4:cafe::af) by BYAPR06CA0016.outlook.office365.com
 (2603:10b6:a03:d4::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28 via Frontend
 Transport; Thu, 14 Dec 2023 22:21:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042A8.mail.protection.outlook.com (10.167.243.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7091.26 via Frontend Transport; Thu, 14 Dec 2023 22:21:43 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 14 Dec
 2023 16:21:42 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/display: Add a new DC debug mask for PSR-SU
Date: Thu, 14 Dec 2023 15:12:40 -0600
Message-ID: <20231214211240.45719-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A8:EE_|MN0PR12MB5883:EE_
X-MS-Office365-Filtering-Correlation-Id: c851c214-259e-47e4-f2cb-08dbfcf30da2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zeAoIszm9lV4dQ/uFWMYh7v7M9tu8e7evXE7BNTw3qDfO/J43radPFWZ+oTIMsoygtsg+fBxZVEJZ3F98LGXTiOaUUPp8hOtkrRMfIrYFswhQZeCBbFY/5VAiEkuwxNOik2wueP/+quyq6ipKPzZ0pOA5SDcyCi23xfs2H3KK+RZWjw297GP8QC9FzerVGbKQiF+3yUuIrU4tF+h3MGneOh8a4Bj3ZAw2ZFH07zXfn981cAsMizlup91vQ9WjLYuSimMVh1ACduw/4iiu4TJUxWH9FUiT0Hi/u4uLf8nyeKIl7T7bWj4x92zEeAEZ60/vOZJj5c6ORFbS3s7VrVr3EYam4NGdvZeVURSvVB3fLV3XOijN/JRN5YLyNhMeCqHezoTyaYyZbxtQOTdHJwI2PgBb8ptGh5aBvCXIEDcVVDwwiM50WHHs1ocnVFmTbUxOloJp5QV5m5A9RmD2lOBzLY0A7IVIGtlLolOJ5kZdvel+8STbuSKXYDK3exEIZ+C3u8+hiJpxwgUcQpLJ/YkCZR4wSHVi9Hg7ZOx7GIvq27Ew6epi+r8P/fiMxjoYKkbbWRAMhsjTZO8Ixw8bJXPrOQV0bYtfBgfCDuFapOhXrxe0ucffoPvLUXwG7G9YGEhU1bnnISEuHc2j0LNfEZTXy9t10NqjaO7qWlEg9CdFFUx/UusnVOW6tCgkN4vqYtGmtKG1d6JTuVxnuecGoLt6bf5pplLOsxaXfXJbN12N/0lUPG2WWla84KH95foBFJ4MdEnImRmh9hoUaPfpr9SJg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(376002)(39860400002)(136003)(346002)(230922051799003)(64100799003)(82310400011)(186009)(451199024)(1800799012)(46966006)(36840700001)(40470700004)(16526019)(41300700001)(1076003)(478600001)(2616005)(36860700001)(7696005)(336012)(26005)(86362001)(70206006)(70586007)(40480700001)(426003)(6916009)(356005)(81166007)(40460700003)(82740400003)(316002)(83380400001)(36756003)(8676002)(4326008)(8936002)(2906002)(47076005)(44832011)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2023 22:21:43.7686 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c851c214-259e-47e4-f2cb-08dbfcf30da2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042A8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5883
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
Cc: Mario Limonciello <mario.limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Some issues have been raised that appear to be tied to PSR-SU.
To allow users to confirm they're tied to PSR-SU without turning off
PSR entirely introduce a new debug mask:

amdgpu.dcdebugmask=0x200

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c | 3 +++
 drivers/gpu/drm/amd/include/amd_shared.h              | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
index 08ce3bb8f640..1f08c6564c3b 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
@@ -51,6 +51,9 @@ static bool link_supports_psrsu(struct dc_link *link)
 	    !link->dpcd_caps.psr_info.psr2_su_y_granularity_cap)
 		return false;
 
+	if (amdgpu_dc_debug_mask & DC_DISABLE_PSR_SU)
+		return false;
+
 	return dc_dmub_check_min_version(dc->ctx->dmub_srv->dmub);
 }
 
diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd/include/amd_shared.h
index ade68972ec28..5cad456f2e10 100644
--- a/drivers/gpu/drm/amd/include/amd_shared.h
+++ b/drivers/gpu/drm/amd/include/amd_shared.h
@@ -256,6 +256,7 @@ enum DC_DEBUG_MASK {
 	DC_DISABLE_MPO = 0x40,
 	DC_ENABLE_DPIA_TRACE = 0x80,
 	DC_ENABLE_DML2 = 0x100,
+	DC_DISABLE_PSR_SU = 0x200,
 };
 
 enum amd_dpm_forced_level;
-- 
2.34.1

