Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEEE9C433FE
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Oct 2022 14:42:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 223BB10E623;
	Mon, 10 Oct 2022 14:42:46 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2063.outbound.protection.outlook.com [40.107.96.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7013210E623
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Oct 2022 14:42:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iEoC3hGKiXBAaLzF+Kr0BBpT7so0/0916JbfmbuclNFJrz63CB1MkswalAVZ5eL/FOQC8+qXtzapwTL3DmfY1Mpahovx/bK70L30LYP76Jd+ANTVdpxbCod+CYnTCve8U8ukSqSI22yg6dNXt57sb4rd981LX+uHzHH2meMQb7Enh/fjS4lw1b/lWzOrSTciYZ9sXY3SyGudwT7himXwClsxnoaycS4Xx6M7k4tqGwXn2MXPXEICyZNWYH1UvwM5JlRAePfA/pr6qTwKfPSUM/H7xHupcUxZWZw/VwKscnDahXF/smGNVIztAGvW3mq/pSn5n5aDdHjDCN49wlY6rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cyNW78w9ZwHSdRoG/0pK4MYe9MtkvVdwSB1q4o0l12o=;
 b=PijQTNmzcb8Nh281omwJz5O8NGI1zw0pfOZcwF7kT/BOGKcUamAb9h30peng8qtGK3LFlCjB34YYODcuKXxC/9evOp4p8ZT3EQxYS/Jefeoy/TDBGRY/nxok9qsjZx6U4XZolv6PhiXc39WUoChBRbdLWk9EwQWfwCSLr2dVUygmtEzUI3syU7ZGIRgZrNNU7C6WNIPSegLOeRkewee4oDg4QyUXd+JNOzMfGIZIDNNytWMBrGq1ieSdaquOzfDwjCq4CpH6ZsLuITBPHhec3SvX9dFOgdqMCODkBRHZdx5xr6C68x6DGg08dbdQCK5RTxt78ultAJJypqDENV9hZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cyNW78w9ZwHSdRoG/0pK4MYe9MtkvVdwSB1q4o0l12o=;
 b=vqO1Jat5nPNOOw6k+MspyY1YIHv6O33qhfXJB1THAXdvIiVisu9v7HvsWJbRaF1WVBjEgOsW/zYYjhQBimC3upe3BDUMHd/z+cK/lVk6ds2EtOKwB9HdmOdVKkr1l10VaF+JXCfDRrATfztJWpiv65Fs03gmtVMmCJ83BzOzRDs=
Received: from DM6PR06CA0054.namprd06.prod.outlook.com (2603:10b6:5:54::31) by
 MW3PR12MB4457.namprd12.prod.outlook.com (2603:10b6:303:2e::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5709.15; Mon, 10 Oct 2022 14:42:41 +0000
Received: from DM6NAM11FT084.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:54:cafe::16) by DM6PR06CA0054.outlook.office365.com
 (2603:10b6:5:54::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.17 via Frontend
 Transport; Mon, 10 Oct 2022 14:42:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT084.mail.protection.outlook.com (10.13.172.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5709.10 via Frontend Transport; Mon, 10 Oct 2022 14:42:40 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 10 Oct
 2022 09:42:36 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/display: make virtual_disable_link_output static
Date: Mon, 10 Oct 2022 10:41:58 -0400
Message-ID: <20221010144158.4025735-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT084:EE_|MW3PR12MB4457:EE_
X-MS-Office365-Filtering-Correlation-Id: 937c9a62-1b82-4e8d-4a41-08daaacdaf31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zUvOvmRxBE47oig7pJ9n8AzAschUy2r8C7VQefJ0eqnlFMj3v3rgFlluN7ANWi5FW/GKwcw7xztS5N8rNiW/ZxAFZ+rYkKCIf1DtZJRTW+3wBUOAIG8/ICwYyf2knDkoX/Cm7w9lxfWVpdI7LpVGVF6USlbqkxYi3om3YbUrCKrB2Avoo5/+auqK25n2EwO/33jdJO20nYrlk1pSkf+9GUjLPNmeRune1UqCOJCCHuxCKSzp/MIBmMAOAKAS2npCJeEiP1aZEMWJVUBBYscWXTuvtUaC3k4NHgKDxtJoJIp8TwSkC4uo+jS/UiHz4FgkFOOp3KIj13oyVE+8o9s77lnK/soFkt/S/+TKIBkYHz951ssy7eSEwTq3uf6K/FVhKoKE+lzmKB+BVnXKppMuyR07XyQOdP5+IIR1aOGu9vhnixvLCwqXvJLyYCOL0Nl+b0etpZKHygSTtYSjslgl/Djg2FWjOGAty3jH8l4jZRK1ok+0xcgAjpMca8uYBTtOFBDpuIIwT87+HvoEcqsJg95e8ENL9ERz8Zcv1uzx+Ijqt4L3RG+QjajZgAsnTjiE375diurh32U6JjiN7HCsT6LKcsIjbAFH33RXjfff7gSd16XLEruNXTV4cUluv8f5d8W7DXqZbMe4/xd4yPlzs8DZuEhiQxuMDFVBZ5ppnuHo7SCqj6Ho8xPrPaNKmITnU8rpPx2FyohPVjB9Iqd3m/TzzgLX6Aa+De6LykjVx5HC1y7+ezf3X/IQHyEStWgYRH/DTtSPJ6I+k/+gn8aGlaoJ8ytfXv9/rOMRfcpASdYq0Wu57OrLORTxJ5PahWCS
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(376002)(39860400002)(396003)(136003)(451199015)(46966006)(36840700001)(40470700004)(2616005)(40480700001)(426003)(86362001)(36860700001)(40460700003)(356005)(81166007)(70586007)(8676002)(70206006)(82310400005)(4326008)(6916009)(36756003)(6666004)(41300700001)(2906002)(82740400003)(47076005)(336012)(316002)(83380400001)(4744005)(478600001)(5660300002)(8936002)(1076003)(26005)(186003)(7696005)(16526019)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2022 14:42:40.9982 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 937c9a62-1b82-4e8d-4a41-08daaacdaf31
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT084.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4457
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

It's not used outside of virtual_link_hwss.c.  Fixes
a -Wmissing-prototypes warning.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/dc/virtual/virtual_link_hwss.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/virtual/virtual_link_hwss.c b/drivers/gpu/drm/amd/display/dc/virtual/virtual_link_hwss.c
index 9522fe0b36c9..4f7f99156897 100644
--- a/drivers/gpu/drm/amd/display/dc/virtual/virtual_link_hwss.c
+++ b/drivers/gpu/drm/amd/display/dc/virtual/virtual_link_hwss.c
@@ -37,7 +37,7 @@ void virtual_reset_stream_encoder(struct pipe_ctx *pipe_ctx)
 {
 }
 
-void virtual_disable_link_output(struct dc_link *link,
+static void virtual_disable_link_output(struct dc_link *link,
 	const struct link_resource *link_res,
 	enum signal_type signal)
 {
-- 
2.37.3

