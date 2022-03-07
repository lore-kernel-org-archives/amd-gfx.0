Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14A80C433F5
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Mar 2022 05:51:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8717810ED4D;
	Mon,  7 Mar 2022 05:51:27 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2069.outbound.protection.outlook.com [40.107.243.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E62110ED55
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Mar 2022 05:51:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bNQ90/2nNNksOFeP8MG9hBKeYvVolPxh6Ralk+GBTr72cnD6bArRdjkWE320ng4x+76h/VDk/+vGoriDclyw3mQ1O/WltEPNiSPYaB6v+8lu54AU6rGT2vdZCQFCA5v5nbw0STB9RI6kdx5er4jsifklht2sRYa+AxZAOvRpIM/xv9ijcw+oBt8incEhHiTYEH7SCjSRGik8QJToYhF+oYASgS30+ym7MEEnXqo4509Ng/GkV22vnAzliVTuVbHwvbFKKBI/pm8wEwujm9Bn/cbWro9EuuLxahtsipOGDuzrZC3Sw7ok1s7Hl2gEdtRq1VJ8wHnVs9DwPBM/d+XLaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VI0N/RJq8zsoB+R4dCgKEYHkw701E9QbGDs/9tpOEHM=;
 b=jbZILiM2A0/X8AIrSR3o3tTvFoWHTgGjYerTO3hCkBeXr5zcD6Wg9gSTkFZAmfD8MILZlJKfcYUxQ+ZwzqVNAqQQCnLA1kVocLPtgEWj7erD/du0mKda+ut0ZsKsyvwbkasYnliN16w06P2+AYP//PbdlDoVB0UcBMefJFI8RwWGw3TlLbyXP/7UOPi8yh4vtheXwwuLtdnaDqexNMhZhJLjaddZikcSsadao5Bz5nh1h3PGOMjaxvhhYugixiERwyEIwGM91ffI9qyHdWRQRSHFXq71nTh67X1biw8arwDvv+xM+GVMw3kUh/CuF4F2FBY7fLjsygvMfjfFv26BYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VI0N/RJq8zsoB+R4dCgKEYHkw701E9QbGDs/9tpOEHM=;
 b=g1vM72OUhwW/zWZjbSWpbBz4xEwIlNkoU0F35LKLlOA6RoJ/N9PAGRVHXxVNyvSxFTxZMcFmWJ86Rd5+Qxjeu6FTEN32wF3vQ5kUx1CcTXMC/V+Upwadk/82YFF7Zr5M2WfKJhipEZuRRpyfpXm+nDvgYNKjnVMkposmq/pT7ZE=
Received: from CO2PR18CA0055.namprd18.prod.outlook.com (2603:10b6:104:2::23)
 by BL1PR12MB5996.namprd12.prod.outlook.com (2603:10b6:208:39c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.13; Mon, 7 Mar
 2022 05:51:24 +0000
Received: from CO1NAM11FT023.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:2:cafe::e0) by CO2PR18CA0055.outlook.office365.com
 (2603:10b6:104:2::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14 via Frontend
 Transport; Mon, 7 Mar 2022 05:51:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT023.mail.protection.outlook.com (10.13.175.35) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5038.14 via Frontend Transport; Mon, 7 Mar 2022 05:51:22 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Sun, 6 Mar
 2022 23:51:21 -0600
Received: from alan-new-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Sun, 6 Mar 2022 23:51:17 -0600
From: Alan Liu <HaoPing.Liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 14/21] drm/amd/display: [FW Promotion] Release 0.0.107.0
Date: Tue, 8 Mar 2022 05:09:37 +0800
Message-ID: <20220307210942.444808-15-HaoPing.Liu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220307210942.444808-4-HaoPing.Liu@amd.com>
References: <20220307210942.444808-4-HaoPing.Liu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2662ffd9-74b5-4743-d8ba-08d9fffe82a7
X-MS-TrafficTypeDiagnostic: BL1PR12MB5996:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB5996DF6BA190845D5AAB6509F5089@BL1PR12MB5996.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lZNP/loHzoReA5Mkm3INYcQsxB1KEpaXG/KV1RScXlg45uHkg0oduka51NW0xjVEJK7W5d1Hr9/wkAklTcudMuD6B5b66V9tu3DolckmFp4A6ZRmwcpLsg8yjEoIFYYVns33TkSi3HRvDhSBG05lra2kUy8l96M3DDlg0WJG+JeK0m7MOnGx2Gv9CpT88SUXGssW0syBhsTVYA5210Y4aEVJ5rPa5LD6i18hpK1fzfe6eROE5w0rWizNG0sou62faEkFdstsrKbVEQH5fu0AnhYC5z8f+1LBul1PsO8nw8XZJLmNiC5xm6k39qRvMHeDVlfmcTdHYh/HuKXfZ3MbmuRQcGhaxY1/o39GK/Dy5IEGbubd8CeuoJ2Y57PEGvNKzdFDBqSm7Xpf9F2xeLJV6XWRIH5E39cXQ+2YVe4/tXYgIhxSSYhRt0CqDvzxZQfHEHHE0ny8L00TATkg9Jg7H2o/kG+RclVCl5yFnz096d/Cr5cc5iDwjY9tm1V99wJNH3vZgairdIQ/kjT0HYaq0NZBSJZxQSYih+6yezIDglMZ7m4A5ekrs3Nv0vDkEwF0UeYqy5gki4k27VaWUousa8UUPNf8Ig26ICut3QuGzWFf94bwrCQ9C4dGMopPXHnBEGiueB3kUnAA7lIovIME+ph+7cYOzXk3zegpwQksktSbUUXq7gc0xEoh1J1sKobiMwRNhu+F+Djuw3FoiEFOQQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(54906003)(356005)(316002)(6916009)(36860700001)(26005)(186003)(8676002)(83380400001)(40460700003)(70206006)(70586007)(6666004)(47076005)(86362001)(81166007)(36756003)(4326008)(4744005)(2616005)(2906002)(7696005)(1076003)(508600001)(5660300002)(336012)(426003)(8936002)(82310400004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2022 05:51:22.6575 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2662ffd9-74b5-4743-d8ba-08d9fffe82a7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT023.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5996
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
Cc: stylon.wang@amd.com, Alan Liu <HaoPing.Liu@amd.com>,
 Aric Cyr <Aric.Cyr@amd.com>, Anthony Koo <Anthony.Koo@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Anthony Koo <Anthony.Koo@amd.com>

Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Alan Liu <HaoPing.Liu@amd.com>
Signed-off-by: Anthony Koo <Anthony.Koo@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 01b597d021fd..8521508af755 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -46,10 +46,10 @@
 
 /* Firmware versioning. */
 #ifdef DMUB_EXPOSE_VERSION
-#define DMUB_FW_VERSION_GIT_HASH 0x082bd4c8
+#define DMUB_FW_VERSION_GIT_HASH 0xb6b77696
 #define DMUB_FW_VERSION_MAJOR 0
 #define DMUB_FW_VERSION_MINOR 0
-#define DMUB_FW_VERSION_REVISION 106
+#define DMUB_FW_VERSION_REVISION 107
 #define DMUB_FW_VERSION_TEST 0
 #define DMUB_FW_VERSION_VBIOS 0
 #define DMUB_FW_VERSION_HOTFIX 0
-- 
2.25.1

