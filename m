Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76B46C4167B
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Dec 2023 13:28:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BCAFE10E89D;
	Fri,  1 Dec 2023 13:28:27 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2045.outbound.protection.outlook.com [40.107.237.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 05B3410E888
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Dec 2023 13:28:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ckUAdCtzmOyN1ANd0ntRAEfVWtsbVBKeb0vQClLE60/E8cpSwFFnLYI3Md/Av2A8a2pOo7zZtEkufBBC9I64xpL8goFPKHX0JYyq95uycMPE1f4/56RDDqKD8k6DDtka2e5XYYfuFEYhIJrSqJ5hwkcQb4ek6DWFUP522vjecqba9DkftsaQfGInMEZQpNIaILsiACm6wUSG4gR5F3bVLqxDSmE+mfhgBBNUKKPCub4/qf82OttZS/HusCRnndxZDra9ysMB8BGA1uUzMp8iAIB4kOPAEv6VnC6czV3kpKG8uNdrh496hZZo7cDN2Q529eG3kMxW4zn1JmwJ4kCfsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UGRqL+qiAsA2H62FY0XT75xd7RNIj7ad17XHFNF7Npc=;
 b=nRePhRWg+0GKtDMdeKj+xS4Jh6eBiQ9kXp33dIGL5A804H163KnlD5BkN6HYPJEJytuicg8iN+Iw3lSFIa+6B3E/7Z55aSxP9njI2SZ3RR0i2pC+sU/SztNL7HQc3eeljdVNgSOqIvyuGVZOgYJ2IXyeRkQM5Te1ZVpwMvapxGHwEZ71NoNwqsedjfMpa5nz/A3r7DyvDWmVgSwNPWkSVWSd2yLxZbwnh4Pl8dfdB9QSfYKmGGWM6O00nmu6pyWiDTghSTgvIFaG2vzih9rDV6ob6y5wJINTiKOTQUYWecdJj6S980LFQa6CZfAi0TuSS9CkGr3tU2OpCZDjYz7RZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UGRqL+qiAsA2H62FY0XT75xd7RNIj7ad17XHFNF7Npc=;
 b=DMTFa+TFrfn3HP9Y0HHimsCgekaICk2fQWzu/pQYv2vcmSMagXZyLtAsxWNOfpdLlkt8HEHTtRqobCg645wWUS5XRorZdp2ZlCPizL8IqFa7VosyauaTKzTqpJOk9IJWJZFOj0tJUQA2HKBVSlhUM9JlC1w0REL17QBLOUtJCfM=
Received: from CH2PR08CA0029.namprd08.prod.outlook.com (2603:10b6:610:5a::39)
 by DS7PR12MB8276.namprd12.prod.outlook.com (2603:10b6:8:da::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.27; Fri, 1 Dec
 2023 13:28:18 +0000
Received: from DS2PEPF00003445.namprd04.prod.outlook.com
 (2603:10b6:610:5a:cafe::26) by CH2PR08CA0029.outlook.office365.com
 (2603:10b6:610:5a::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.24 via Frontend
 Transport; Fri, 1 Dec 2023 13:28:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003445.mail.protection.outlook.com (10.167.17.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7046.17 via Frontend Transport; Fri, 1 Dec 2023 13:28:18 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 1 Dec
 2023 07:28:15 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 11/47] drm/amd/display: Use channel_width = 2 for vram table
 3.0
Date: Fri, 1 Dec 2023 06:25:07 -0700
Message-ID: <20231201132731.2354141-12-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231201132731.2354141-1-Rodrigo.Siqueira@amd.com>
References: <20231201132731.2354141-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003445:EE_|DS7PR12MB8276:EE_
X-MS-Office365-Filtering-Correlation-Id: 16b04449-2241-4ba5-3b41-08dbf271615e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LakF6amRLyeko1GuEJQ/u9F1puTLDUfuK4I1uScOBVtU3e+PasG6+CfowwVhOAbfUyVJo5no24S3QPzrR27+X7KUDA3QOq67YwxsztdmluUskDupChufpsOuq83Ozka57czyF/1O8Ysvp9U5K0CXTuZvcYIAt0dVUfJKJstNt2m8q2sBN0t4mDLieMl3M57T/pfWkMDop5ysPLdwX0qo54qHkZlEm0eFOSZqWOGL11QTbsx7xVHL43UDkT0lf0Zjq+u+mkExIJxXb8YwN2N6BrRgTYHsNZstRx0bf/6jyLANpo1Acd+IVUZUbRRqoD0G6S66DrTzaAn/zT88lCNmnGgyrgzsaiD6Tcup5RL21pygUOYb+f6sWDlK3naNzwbDx9cna18Lol/gyYRbXxWuJdiJAZg/lcOifdqomio7++V6lDFOtnq7VY5B3nu/UptOsRGE+wmylFEILjnTjwoWRdA2bF/wA+mQ1Zv12Gteww81E1w5HXwuj11uHSvh2B+E0DOUuYfKawI65nnUrIoxyfd2GBV0kFXV/1aaZADzjIacN6caS8fk7G7hHBNMB1WvMuLiWhgdgOwaWn+zL88XVm31JF9c72Fh15EKB4LExl1xB3mvuMfk0Q+kYKmU3XrM+35J6IFBwEvQjbgUPBo6L7+ldOEDYhZxFGrqvOJyTXo6NaBeDGCHcMo56GoVjyOArHKS6B/jGOgDSNcduHfrThLEGfzGr3BaAW+SswV/ZP1h5gDTzcAQc9uOJU8jEHri0IM7fx4kNqrX3ux9jSxpCA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(396003)(376002)(346002)(39860400002)(230922051799003)(1800799012)(451199024)(64100799003)(82310400011)(186009)(36840700001)(40470700004)(46966006)(40460700003)(426003)(336012)(83380400001)(82740400003)(86362001)(36756003)(81166007)(356005)(47076005)(36860700001)(70586007)(70206006)(4326008)(8676002)(8936002)(54906003)(6916009)(316002)(40480700001)(5660300002)(2906002)(2616005)(1076003)(16526019)(478600001)(26005)(41300700001)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2023 13:28:18.0911 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 16b04449-2241-4ba5-3b41-08dbf271615e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003445.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8276
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
Cc: stylon.wang@amd.com, jerry.zuo@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, roman.li@amd.com,
 Samson Tam <samson.tam@amd.com>, solomon.chiu@amd.com,
 Daniel Wheeler <daniel.wheeler@amd.com>, Aurabindo.Pillai@amd.com,
 hamza.mahfooz@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, Alvin Lee <alvin.lee2@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <alvin.lee2@amd.com>

VBIOS has suggested to use channel_width=2 for any ASIC that uses vram
info 3.0. This is because channel_width in the vram table no longer
represents the memory width

Reviewed-by: Samson Tam <samson.tam@amd.com>
Acked-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Alvin Lee <alvin.lee2@amd.com>
---
 drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
index 2fb804eb5702..01abc2f3081a 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
@@ -2386,7 +2386,13 @@ static enum bp_result get_vram_info_v30(
 		return BP_RESULT_BADBIOSTABLE;
 
 	info->num_chans = info_v30->channel_num;
-	info->dram_channel_width_bytes = (1 << info_v30->channel_width) / 8;
+	/* As suggested by VBIOS we should always use
+	 * dram_channel_width_bytes = 2 when using VRAM
+	 * table version 3.0. This is because the channel_width
+	 * param in the VRAM info table is changed in 7000 series and
+	 * no longer represents the memory channel width.
+	 */
+	info->dram_channel_width_bytes = 2;
 
 	return result;
 }
-- 
2.42.0

