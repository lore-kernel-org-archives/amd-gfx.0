Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46B35C4167B
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Nov 2023 20:09:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E5AA710E782;
	Wed,  1 Nov 2023 20:09:10 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2075.outbound.protection.outlook.com [40.107.212.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7224710E783
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Nov 2023 20:09:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MQT0tvsC7s/8iep5p0Tkuy8BpgnnpfuDG396S8L2qRlRoaBRaxgl5abEoFbKx/sIHBs+hJ8/2vJs2wL2Dkom4rI43oNLpZgbbxEoaXIPRVVlGj9gcY6TndgL3GMcYgPTedFdZasCR/81ypr6vf+FmrBYrzEbScSDc0qDKsr7T85rM+gH1LrgnpPsASkuc2n0wFxSAzzwfewy+ZnL/dU52ZTGSWyWnHVAfIIYYXJTvZNUq9/6atNad4GEbkT7/W7cctZiNEJrEhz8RQdh/Jgx59rIcRHeCY1N4Vw0KAtSccyebDU7S2/af4zYwYmoqtD2wYoqMYWyf1Tm+PNhOdk9nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=54Ywy6S7VIF2vLek4ludwFDthxsKR6sDp/adDZYwdq8=;
 b=Lr+Ur4ONstwhYf7QX+lht7hRQNev2I9SpwlhqEFr5m8dhU3QihLKQeOeYjtyzopz6JaxpI+8Tv1XVOxAdkhC2cagQqwwMgZwh1aa9FExx+oeeU1H4pkt7jAXZrcIm+Cj6N/V1tJyx6QcQt54OQv6MwzSETTHW8tMX8YnG18wh3OkWs2gLaDugCOOGxNfIfOZHF5SLQJ2oPRGJZIRA9cYI3K9+Y1EbXknLsCLU8POWmzG/Xk0dZNPMOBeYObDcTZfmbWYCRJ2xMhvsbRNqsBYtdbCBTxAcKXrWdn7HdGGw0KRX3EQyXSv+uu6nW1+FsG1uYibB2xqPdOh0fFp/5i6JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=54Ywy6S7VIF2vLek4ludwFDthxsKR6sDp/adDZYwdq8=;
 b=ZJ1CFrutv1OM8UxLrOHQRguekyE7pGFLNrt2+ci6i51+s0TQGdM25tBfcjchPWgVH+lb2MOSf96MWVc7XlDXGjGImKC/TtuTr6XGzeSGGZWmENOCmJ45ZL26627FllQ1HnPi9Ak3eEoX995GPjzl+rBnP/1gQE8+SrulgvsBAOI=
Received: from DM6PR08CA0049.namprd08.prod.outlook.com (2603:10b6:5:1e0::23)
 by BL1PR12MB5361.namprd12.prod.outlook.com (2603:10b6:208:31f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Wed, 1 Nov
 2023 20:09:04 +0000
Received: from DS2PEPF00003442.namprd04.prod.outlook.com
 (2603:10b6:5:1e0:cafe::f6) by DM6PR08CA0049.outlook.office365.com
 (2603:10b6:5:1e0::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.29 via Frontend
 Transport; Wed, 1 Nov 2023 20:09:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS2PEPF00003442.mail.protection.outlook.com (10.167.17.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6954.19 via Frontend Transport; Wed, 1 Nov 2023 20:09:01 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 1 Nov
 2023 15:08:58 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 1 Nov
 2023 15:08:57 -0500
Received: from hersenwu-Majolica-CZN.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.32
 via Frontend Transport; Wed, 1 Nov 2023 15:08:56 -0500
From: Hersen Wu <hersenxs.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 08/12] drm/amd/display: Remove unused duplicate register
 definition
Date: Wed, 1 Nov 2023 16:08:28 -0400
Message-ID: <20231101200832.995436-9-hersenxs.wu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231101200832.995436-1-hersenxs.wu@amd.com>
References: <20231101200832.995436-1-hersenxs.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003442:EE_|BL1PR12MB5361:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f0ced05-5dac-445b-8eb8-08dbdb16644e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Jqpi1sQQqYSg5kIMCNHFZybn6u+S7eSv9sbwQoMxphekvwev2gsMqdWDJ10bY7F6BBLYUhct+OjlJLMIc7WUzEMrKqcU/wjqdVJlV484Ou+NBGUwJm0LGOvWCkxJe2cFp+Gi4EKrG32OUvxPMuf/K+SBy8XRgLIrCCsYffsaUgZQAPfU/QwZwvJSJhQ8Epbns6NzGxI9zhijeYwxhdv7y6cs0SUKSZbJNIO5rZSfa2zugqMY4YGfb7+McEYLOY1q/41qzIdgpBCg+89FIyyo4DISkMz4vK6ghi+nNdIbE98x94x+d7cwt+wlt0HSrEzijxqjlA41kMWr/q6+28t1nrCIEDyGc77uSS9oBQGgkFfPoWyuFMbiozVew79wERKeIIgRcXLy8/raH0tKfhh6ZvcU0Uj9mwtUQ1K/ZKGFfZe4oQR+7WMc4TfrFfaekY+Ni5b3V+LpNV0HSurQv3WM2G51uXjuhQxFtQdCHRZ5QKc+pP2PcbciYgy0ZWD76gj9yTme6Pj4vv7ufTcpS5ZO/+pJwxq2CEEM/kH6L6WTtwsowkt8doYo1aypyDd14nQKPoZ0KGdLVP8PQPwFz8cm652PQFvJJSQOwT6xTOYBNK+3xIGD+AVCtfp9Idf6sLRLAMCkBW0JbsAteQ9ynbxmCkcIJPCDvUcP8yN6BvUAIYXE10KjBq8Ytc1VHghXsudwLwlsd98ix7VXyVdq3WGuXFUnvaRx+PrRZJheesovGHzgZ7Oe5br+VS35cL5TWSkWaYuEv2k3BddgnSsp6yPIOg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(136003)(376002)(396003)(346002)(230922051799003)(82310400011)(1800799009)(451199024)(186009)(64100799003)(46966006)(36840700001)(40470700004)(26005)(2616005)(40460700003)(2906002)(40480700001)(86362001)(36756003)(81166007)(356005)(82740400003)(83380400001)(5660300002)(336012)(36860700001)(7696005)(6666004)(47076005)(8676002)(4326008)(8936002)(316002)(6916009)(54906003)(1076003)(70206006)(41300700001)(70586007)(478600001)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2023 20:09:01.8878 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f0ced05-5dac-445b-8eb8-08dbdb16644e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003442.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5361
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
Cc: stylon.wang@amd.com, Joshua Aberback <joshua.aberback@amd.com>,
 Dillon Varone <dillon.varone@amd.com>, chiahsuan.chung@amd.com,
 Sunpeng.Li@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 jerry.zuo@amd.com, Aurabindo.Pillai@amd.com, hersenxs.wu@amd.com,
 wayne.lin@amd.com, Harry.Wentland@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Joshua Aberback <joshua.aberback@amd.com>

[Why]
DCN32 uses ABM register definitions in dcn32_resource.h, remove
duplicate from dce_abm.h to avoid confusion.

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Acked-by: Hersen Wu <hersenxs.wu@amd.com>
Signed-off-by: Joshua Aberback <joshua.aberback@amd.com>
Signed-off-by: Hersen Wu <hersenxs.wu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dce/dce_abm.h | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_abm.h b/drivers/gpu/drm/amd/display/dc/dce/dce_abm.h
index c50aa30614be..051e4c2b4cf2 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_abm.h
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_abm.h
@@ -128,21 +128,6 @@
 	SRI(DC_ABM1_ACE_THRES_12, ABM, id), \
 	NBIO_SR(BIOS_SCRATCH_2)
 
-#define ABM_DCN32_REG_LIST(id)\
-	SRI(DC_ABM1_HG_SAMPLE_RATE, ABM, id), \
-	SRI(DC_ABM1_LS_SAMPLE_RATE, ABM, id), \
-	SRI(BL1_PWM_BL_UPDATE_SAMPLE_RATE, ABM, id), \
-	SRI(DC_ABM1_HG_MISC_CTRL, ABM, id), \
-	SRI(DC_ABM1_IPCSC_COEFF_SEL, ABM, id), \
-	SRI(BL1_PWM_CURRENT_ABM_LEVEL, ABM, id), \
-	SRI(BL1_PWM_TARGET_ABM_LEVEL, ABM, id), \
-	SRI(BL1_PWM_USER_LEVEL, ABM, id), \
-	SRI(DC_ABM1_LS_MIN_MAX_PIXEL_VALUE_THRES, ABM, id), \
-	SRI(DC_ABM1_HGLS_REG_READ_PROGRESS, ABM, id), \
-	SRI(DC_ABM1_ACE_OFFSET_SLOPE_0, ABM, id), \
-	SRI(DC_ABM1_ACE_THRES_12, ABM, id), \
-	NBIO_SR(BIOS_SCRATCH_2)
-
 #define ABM_SF(reg_name, field_name, post_fix)\
 	.field_name = reg_name ## __ ## field_name ## post_fix
 
-- 
2.25.1

