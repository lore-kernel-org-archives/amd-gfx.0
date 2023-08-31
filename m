Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68EEAC83F2F
	for <amd-gfx@archiver.kernel.org>; Thu, 31 Aug 2023 21:04:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE13A10E104;
	Thu, 31 Aug 2023 21:04:37 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2082.outbound.protection.outlook.com [40.107.220.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A43710E104
 for <amd-gfx@lists.freedesktop.org>; Thu, 31 Aug 2023 21:04:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NqCPkxy+dN7eF+a6qelR/T1SSO/sUHDiSk/U8q/ArONT+qqHQw+fYbxUIM92srjUZ9avqtRtsT3khZPq0UQqTENJp4cCJo2Mimglu4aoaqp59igh0ig16NV3YyNZHgfebc9YId3/KArv3dSWp3TyGbunHmJXXBBU0TUs5suRIbWF7KSYzWjGzotYlgQ+CONoUb+Lwu/jgBrKQQ97J5GWhA0jyejNCYqEi9uB2TwJLSqw99VVmpjYDcpFM5YvvLnj1saMrLbuW9dsHjvMoXLzS3TAfCHrewgf8LRb088nddotvySPYLw72snx5t7/EnMKrn/MGsuyKcrVPA9N+BpreQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T7aagzAvkFOnzBpGkqdlRpZKWt3B1WsXVQDffQ820kc=;
 b=XJEktxgMkn82nPiyos14iEi8kXw9rxP4/Kvt3EWgDaPnT9uxUFTaS5PO0rUPhLxTH+d5wVZomTNWsQmcFuRHgUT784MD++sh/CqTcV8aRgYemMwzt3471ivSAcLwgNoaSK3QfxyiA6CkFbB092Bflufb4Aawa2M8gG+Sn7ffVK+lReDcLEZvfCc2vgYKg3W8DB4tMYOfMXGuEwoUi6oGXy7qx2dLDd6LqyprBZCBFIoKfqvj99sst1MvckOlYlN/3ha1XA8Gp43rd+tAxNQLnEpEFD72uAt+TOGIy6xA/Cb1W6MiEoy0enZDKiQDR0FLB3PWJ4jfr7YHcVaJzl5vIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T7aagzAvkFOnzBpGkqdlRpZKWt3B1WsXVQDffQ820kc=;
 b=j1vhjDWXvx0f7+R4GchY6qWB3jRleOuj6S7N0/iwtyQXBUzyRvxwdJKFlBjMZ3KBChog9jtljecG6rgYx7qA0cBjobvKrXh1dzeJHe4NTffxMaHRnqIqt/6p/aLOYhYUiDlZjt7I8qEtRGTfeyyL7RSclXVyJxgbdClbbXknzN8=
Received: from CY8PR19CA0017.namprd19.prod.outlook.com (2603:10b6:930:44::21)
 by MW4PR12MB6802.namprd12.prod.outlook.com (2603:10b6:303:20f::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.20; Thu, 31 Aug
 2023 21:04:33 +0000
Received: from CY4PEPF0000E9DB.namprd05.prod.outlook.com
 (2603:10b6:930:44:cafe::a3) by CY8PR19CA0017.outlook.office365.com
 (2603:10b6:930:44::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.22 via Frontend
 Transport; Thu, 31 Aug 2023 21:04:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9DB.mail.protection.outlook.com (10.167.241.81) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6745.16 via Frontend Transport; Thu, 31 Aug 2023 21:04:33 +0000
Received: from user-Virtual-Machine.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 31 Aug 2023 16:04:32 -0500
From: Timmy Tsai <timmtsai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd : Add HDP flush during jpeg init
Date: Thu, 31 Aug 2023 17:04:19 -0400
Message-ID: <20230831210419.104784-1-timmtsai@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DB:EE_|MW4PR12MB6802:EE_
X-MS-Office365-Filtering-Correlation-Id: f2fe5afc-e61c-410f-0c6f-08dbaa65e037
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DMVx55U2nLR3zWWCJVqTNC4IP1jJUfVGUNCx6dKeEZdU8f9JBdKEk7kcQ5aJxVjW279DXdFLAMsaTyJzYUmLV4GvEXq7ceDzkcp4FR+Dzgw8vXANYlk5hpMYknIc1BKht8FtZDpwdY0teR/DyAY5d8TkiUaG07hSORCNCUOLBQ2jGygcOvoxrsrtHjcdUHIMG+HpEx041UEpFPPFJijorjqpiVH8OQfEqcMD/x5QOU+xrG/z2RwywMcHLtSZNVx8q70nPGmDfEDd5eAZQ5J7HCmIhanZgTTPZiwOOqS07aPQdy38EjqYP0eVBGqV4vZm0ow9XWPPle+xHTi8qJ6ldqpBY1sbtP4IX0GlBhnXAAVIZgX8XIitj7N0U94Gqety24OTzFiGUu7cW1ZUAEyl9HUTlXIW1LmD7U2LJ7ptLy1har6YWlzn9UNLXgVVKELW9gXlGzO/ioxGLmNP9FBpx4MPDKxQxfSwwd0D4JcLDT1kSNve81O0C51YV3C7yPIQmPbbb+YDpxJwU7kvdtOXOzrPaOLDqKmvrXFRfeES1PvOcddlTE+LYevNhElvOTvhKwLsNgH/xSOPM+QSsgjzpsU3v2kglmy8Y4nZV6Eu8AvD6Ysnsf5PqTlzShZW9KaK8zOvpmd1WV5QeRF8XTR+8baom7XbSLDN8elVFJ5Iva3YYkd1CpTBbCofFfkciDsULTkN+fqVoaCW0nS5N4qAbcWJHoS48LgDpINUz2OmcNwiRTQHUUBwrEyuqNm5p2GmFVepncwt85rGzriA6dPpmg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(396003)(376002)(346002)(136003)(186009)(1800799009)(451199024)(82310400011)(40470700004)(36840700001)(46966006)(40480700001)(40460700003)(82740400003)(316002)(2906002)(70586007)(70206006)(6916009)(478600001)(356005)(2616005)(41300700001)(8936002)(5660300002)(4326008)(8676002)(47076005)(83380400001)(6666004)(36860700001)(7696005)(1076003)(336012)(426003)(16526019)(26005)(81166007)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2023 21:04:33.2242 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f2fe5afc-e61c-410f-0c6f-08dbaa65e037
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9DB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6802
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
Cc: Timmy Tsai <timmtsai@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

During jpeg init, CPU writes to frame buffer which can be cached by HDP,
occasionally causing invalid header to be sent to MMSCH.  Perform HDP flush
after writing to frame buffer before continuing with jpeg init sequence.

Signed-off-by: Timmy Tsai <timmtsai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
index 3eb3dcd56..27efba2da 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
@@ -33,6 +33,7 @@
 #include "vcn/vcn_4_0_0_offset.h"
 #include "vcn/vcn_4_0_0_sh_mask.h"
 #include "ivsrcid/vcn/irqsrcs_vcn_4_0.h"
+#include "nbio/nbio_4_3_0_offset.h"
 
 #define regUVD_JPEG_PITCH_INTERNAL_OFFSET                  0x401f
 
@@ -468,6 +469,15 @@ static int jpeg_v4_0_start_sriov(struct amdgpu_device *adev)
 	table_loc = (uint32_t *)table->cpu_addr;
 	memcpy((void *)table_loc, &header, size);
 
+	/* Perform HDP flush before writing to MMSCH registers */
+	WREG32_SOC15(NBIO, 0, regBIF_BX_PF0_GPU_HDP_FLUSH_DONE, 0x0);
+	WREG32_SOC15(NBIO, 0, regBIF_BX_PF0_GPU_HDP_FLUSH_REQ, 0xFFF);
+	if (SOC15_WAIT_ON_RREG(NBIO, 0,
+			regBIF_BX_PF0_GPU_HDP_FLUSH_DONE, 0xFFF,
+			0xFFF)) {
+		DRM_ERROR("Failed to flush HDP during jpeg init\n");
+	}
+
 	/* message MMSCH (in VCN[0]) to initialize this client
 	 * 1, write to mmsch_vf_ctx_addr_lo/hi register with GPU mc addr
 	 * of memory descriptor location
-- 
2.34.1

