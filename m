Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31A14C4332F
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Dec 2023 06:13:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC6BD10E6D1;
	Wed, 13 Dec 2023 06:13:16 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2058.outbound.protection.outlook.com [40.107.243.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4DE0310E6D1
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Dec 2023 06:13:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H2TBJ0Rl3vPGb+2AedG3PxiAHsiFfLtKlnKWOONcWUljvOkREe2neogeT+2N/mfmf8yu8QSQlEkO6wSBjJvI6BJhPiNgWNY5kAM5aEneUiYRWCJ73yPpyNlf6P1GA+9W6coqe7XcX9AJa1k18BX9w75UUxOnhmwFNrt4ndpVeGzM4WlTjzyswaHLlG7nWeEpMhMbpiI1ng6I896RLtuKUyvCzf7V8dTNQU4mspJo8RPLCdVtinMINMfHDsxQeorHyRdxnPymAQybnrKmjtL5xOiBonkNSZcP0QTdK99plRcMBv2VLeYLLJ4YrVhJZY4vcB248t/BaaenUabNzs20fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CPP84OIAF3gHIXH3/DLBiFZiQwJWEqQorgD3KhPN+QQ=;
 b=WlaR9esd7R8L7LbuNev+85LSJeR6lLAwUhNEIzvPRHeyE7pY8H+6OXndYE26E3jiUjZJ198Om5OelAogiiQmGxajyGc2cTcaNDJCMTM62pJBPV3CHWt8Jqb/juhA7KJgYSW8eMdnwRcmp7PXPfyc0b6hqfgmshI9iISlPpys8H1Nm+ry+KHtroCupqI8QcLwj1DFDDenAAse/wmBLTuj5DyvHUMIwl1NESmvQYb2YHS0k2NiMlu73koZ9aALGFJWTnaNQdZOFbQzdGoz3HhkQKS8Rz5W+9g0qZCYKWl5gKIYy3SdSJwNzaIjaUEY1MFwxsmHx4gYU7WzHWxPNTgA8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CPP84OIAF3gHIXH3/DLBiFZiQwJWEqQorgD3KhPN+QQ=;
 b=kwWiuj7OEtNGqKSHbpUfUh7HuoPCZn4xmWxnfrSS7m3AKI9+UUX43SnpW3iPiYbjX5TaRFf/wrZyeAP+btlu0WGnV4ojlSyzVcg54rD+0aWXd91lN5wEwufqfn2mtD7tWcG9DknhPC5C5VvRA1YI32ebxQPiY/Mod83GlIRXkY0=
Received: from SJ0PR05CA0020.namprd05.prod.outlook.com (2603:10b6:a03:33b::25)
 by SN7PR12MB7955.namprd12.prod.outlook.com (2603:10b6:806:34d::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Wed, 13 Dec
 2023 06:13:13 +0000
Received: from CO1PEPF000042AB.namprd03.prod.outlook.com
 (2603:10b6:a03:33b:cafe::ea) by SJ0PR05CA0020.outlook.office365.com
 (2603:10b6:a03:33b::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.25 via Frontend
 Transport; Wed, 13 Dec 2023 06:13:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AB.mail.protection.outlook.com (10.167.243.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7091.26 via Frontend Transport; Wed, 13 Dec 2023 06:13:12 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 13 Dec
 2023 00:13:09 -0600
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Wed, 13 Dec 2023 00:13:04 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 03/25] drm/amd/display: Revert " drm/amd/display: Use
 channel_width = 2 for vram table 3.0"
Date: Wed, 13 Dec 2023 14:12:05 +0800
Message-ID: <20231213061227.1750663-4-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20231213061227.1750663-1-Wayne.Lin@amd.com>
References: <20231213061227.1750663-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AB:EE_|SN7PR12MB7955:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b87d9b0-b168-4d7e-d01c-08dbfba29620
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SlQBBSYK3E7pLnqEL/Ajh5doMuPGqa5ScycgnKDiMgI/eOCD3rMrC1VCyDA4i6km+bMfpY8/iLCBMP8IOUlZXrsKvfDtiseqgvnY4QlkVqsQlhOSAeiBz2YgR9Tp6fYe+bqLtwSjBsYglhgeUNDqiAng0wdWj1wAgIHDiyzHe/wvkMQFtRXCem21Gbmx+2j3qu7MK1O/MGBhT01t+cctlCsIvYN+0mGDZUuTfordREQibDNV7d+aFcruRBoRHPVd+sDRRsyuKbYmIMPuxtCcotbcObRKCokOPMwHiAQLJ9UbwERGSt4A/bXTY4+fkrN0DyzRmq+c03AzSFoFUBxJzf6QyV1eimXiCy9toxusWk/DB6XseHWPMmrE1W9cCvLbXVFEq21mDzfJ4Q3AavoY7uc1sGvtB+zxFVT71jwlnWCLVnsNV6tGLDlcU5qU8kG0HhsQvN+nyalmxA8QWBSip/qu0su3D20WF3GLyRYkYds2+UadjGaFao3U3KQ0stDJOdifdFnO5NDFNvt4wOfJb6aA3/coEszTVDd/K2SoaPlc2/mi+VfAdhUBqQ/V55hC764DfFd8lrEOXRFnDVXVXQtPl0gwcVCEr8KDaDqnCr7aZAj7YAQoMZoC5W+D0eY7OFBvPoMb7AbY1TGMInJIjfgdQHqy27g8p0t+90yMvtDBkOJT8BApG0gRb4gdVK89zWGEhVxsJGofITHzj0UnJgRtHTlfFScF50j52L5VXNxj5Q1eY72hUub0AfIGcY3dMldwDoL40plymnAmXux2CA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(39860400002)(396003)(376002)(346002)(230922051799003)(451199024)(82310400011)(64100799003)(1800799012)(186009)(40470700004)(36840700001)(46966006)(40480700001)(1076003)(2616005)(426003)(336012)(26005)(7696005)(40460700003)(86362001)(82740400003)(81166007)(356005)(36756003)(5660300002)(8676002)(8936002)(4326008)(36860700001)(83380400001)(47076005)(54906003)(6916009)(70206006)(70586007)(41300700001)(2906002)(316002)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 06:13:12.3501 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b87d9b0-b168-4d7e-d01c-08dbfba29620
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7955
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
Cc: stylon.wang@amd.com, chiahsuan.chung@amd.com, Sunpeng.Li@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, Samson Tam <samson.tam@amd.com>,
 jerry.zuo@amd.com, Aurabindo.Pillai@amd.com, hersenxs.wu@amd.com, Alvin
 Lee <alvin.lee2@amd.com>, wayne.lin@amd.com, Harry.Wentland@amd.com,
 agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <alvin.lee2@amd.com>

[Description]
Revert commit 8c5660987ee1 ("drm/amd/display: Use channel_width = 2 for vram table 3.0")
Because the issue is being fixed from VBIOS side.

Reviewed-by: Samson Tam <samson.tam@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Alvin Lee <alvin.lee2@amd.com>
---
 drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
index 875a064bb9a5..fcd65a2057ad 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
@@ -2386,13 +2386,7 @@ static enum bp_result get_vram_info_v30(
 		return BP_RESULT_BADBIOSTABLE;
 
 	info->num_chans = info_v30->channel_num;
-	/* As suggested by VBIOS we should always use
-	 * dram_channel_width_bytes = 2 when using VRAM
-	 * table version 3.0. This is because the channel_width
-	 * param in the VRAM info table is changed in 7000 series and
-	 * no longer represents the memory channel width.
-	 */
-	info->dram_channel_width_bytes = 2;
+	info->dram_channel_width_bytes = (1 << info_v30->channel_width) / 8;
 
 	return result;
 }
-- 
2.37.3

