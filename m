Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFF99EB64D8
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Jun 2023 18:25:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6833510E59C;
	Thu, 22 Jun 2023 18:25:32 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20622.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::622])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F54E10E597
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Jun 2023 18:25:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UnddtWDEhK0Nd3l5DvZZa4aLxw+Y/K6MV6POknK/Im3ztVJ7718k/EE4JYPcbzeQXzQi0SJFzOFkwBqLpTxhZ09CnuIfS2LNjFi5HihYx12x9RTiAU96gkEct9QPsseRjjlG/dkgKReANx3hg7FN31dl7vQzvrpSgDVbX8XDNTwzMgT4oUh6DidZkgL6XfS628OOG6aGl8wrJl4Ln/8LO3KjS5VNR5XDUJR/aeqFbhHVyn380nY6ygqtOlLhdw45gwnTujqVzMFuIH48Pk+vJpvNLkG8tR48TcjSXLSi6AcccVAmdirLbQL9nOT1KaIPFSzElGRL/YLE6VyVsOTx0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GfyWIsQr5KxX6yEns9FoR/4neu4HrPXyXLKJ1HEjoLA=;
 b=YKuXrRn92rTiZnCq9B6QEe3/scNvg6GxnbglJzR58xTVCCxPjVlb2usij5HI6mlILOo/hRaqOU21QPgXf6JTcNPwmMtNtsY/kjUL8YK802AzbZj9zqX2HDAfmPLuVR7oMFMD+gmVDjDnwk0loF9lq4EE8xIYLlSEzfsjwSiZJr9AZbJWQ3oBm+xqHGVWWAsnekWazdTBI/VkcntjZ2Rvkg363FaNAkJIWkG1ovupiQq4qqzbbxiv2ry+vrZn+XDYa1VIDBeH1cw4G7cA7GNZj3vTf3woclO27ILiPYWTO1LbCCRgsXajCEQffWLq2f5gjsSLnJ0qtj8Gr+lCaXEkTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GfyWIsQr5KxX6yEns9FoR/4neu4HrPXyXLKJ1HEjoLA=;
 b=e1XH0IKnztcVbNhzdFwfaOzN4GedsmQB9WPmqrS5GgXW6B1efYKA6MyYfIoTdOSzl3crjmy2br3zDZl7+O5SDd2/Q47kLcTewst6Y2nfY5xA6QMIITvyqmoG0kHk/QVrdbASCc+d6h8juq7++fp212Lz4AUNv+C+989BWvTMxiQ=
Received: from MW4PR03CA0307.namprd03.prod.outlook.com (2603:10b6:303:dd::12)
 by DM4PR12MB5184.namprd12.prod.outlook.com (2603:10b6:5:397::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Thu, 22 Jun
 2023 18:25:24 +0000
Received: from MWH0EPF000989E9.namprd02.prod.outlook.com
 (2603:10b6:303:dd:cafe::cc) by MW4PR03CA0307.outlook.office365.com
 (2603:10b6:303:dd::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24 via Frontend
 Transport; Thu, 22 Jun 2023 18:25:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E9.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.17 via Frontend Transport; Thu, 22 Jun 2023 18:25:24 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 22 Jun
 2023 13:25:22 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/4] drm/amd/display: Set minimum requirement for using PSR-SU
 on Phoenix
Date: Thu, 22 Jun 2023 13:25:06 -0500
Message-ID: <20230622182507.25531-4-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230622182507.25531-1-mario.limonciello@amd.com>
References: <20230622182507.25531-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E9:EE_|DM4PR12MB5184:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bc0fd8c-3b73-4998-d3e4-08db734e0bf4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /qY6m/MWMaciJn+OCkeXuXSx6kM+K6BK9fy7aSJoCpAc9H6IbSVV3o4BucE1xq4fX7WdEaZfBByyFUyCZi/eIx5RlxF+EJcPqA63In6n/lwOOm19qMPEVNQxEh6qJ3//mfDzAyie+s4h1PLU41u08R2+clhpBvH2ouoalU/xkqPWEiC94tDxtDrmAJuuqPe1rNQZhpCugOIW5DSQC0yI6jP/w9Q82KCGETt7732905oqqXDEPHcCOCXAAe/N937wKOuNumrnmVDSXFtrta8H6q9fKh6HNDAwxpOuEDe0MWcWgclZa0MvpnrEEeyQMs/+Tlzyt64CzgneRZ2qZp8E+hIEDEsyB4qbtiv3ISzXnwV7VbrnBm8Gbz3y+DeSsfmR4TmaWlaRCzgPQ4ZuAsJ6KSRyiCQ/BbziX1ggxQdC5DgBRN0GsFacXD2C5zYwuyLmDxCHy7Dp1UqEfql5y/+i6EvwFW0o/pWzd0oUHP8hSngSIw7MIBINTlNJTxp+IGfs6TQwQLBs5TR2Kz0Xm79sLM+rZJZi/jmR7yyNZYFruKjdarzeQN+iofNW1dcw5Xk6GVL3zUzUE1HxOAbHYMpe4R6aSGl7BANwCizqJly8UDHDlStCcuX8T81Lah5O/jav19t+qkrmCFF7XbkSyfKfihb9yQDOqT3gCNwLGsIZ7YJmEfX2HB4h62zA7SvPVPOjUo4Cv4gWiCjkHUp5C1c30RZopfFTX2cbe+3DzEKr8EcQ4vGULkaFT1Nl9Za/fgiRXE0zkw/H3bQwYi5KDQdJEA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(39860400002)(396003)(136003)(376002)(451199021)(36840700001)(40470700004)(46966006)(6666004)(478600001)(1076003)(7696005)(426003)(5660300002)(54906003)(70206006)(70586007)(4326008)(8676002)(41300700001)(6916009)(8936002)(336012)(44832011)(2906002)(47076005)(36860700001)(36756003)(82740400003)(26005)(186003)(16526019)(356005)(81166007)(82310400005)(40460700003)(316002)(2616005)(40480700001)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 18:25:24.6732 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bc0fd8c-3b73-4998-d3e4-08db734e0bf4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5184
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
Cc: Tsung-hua Lin <Tsung-hua.Lin@amd.com>, Marc Rossi <Marc.Rossi@amd.com>,
 Sean Wang <sean.ns.wang@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Hamza Mahfooz <Hamza.Mahfooz@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The same parade TCON issue can potentially happen on Phoenix, and the same
PSR resilience changes have been ported into the DMUB firmware.

Don't allow running PSR-SU unless on the newer firmware.

Cc: Sean Wang <sean.ns.wang@amd.com>
Cc: Marc Rossi <Marc.Rossi@amd.com>
Cc: Hamza Mahfooz <Hamza.Mahfooz@amd.com>
Cc: Tsung-hua (Ryan) Lin <Tsung-hua.Lin@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn314.c | 5 +++++
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn314.h | 2 ++
 drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c    | 1 +
 3 files changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn314.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn314.c
index 48a06dbd9be7..f161aeb7e7c4 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn314.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn314.c
@@ -60,3 +60,8 @@ const struct dmub_srv_dcn31_regs dmub_srv_dcn314_regs = {
 	{ DMUB_DCN31_FIELDS() },
 #undef DMUB_SF
 };
+
+bool dmub_dcn314_is_psrsu_supported(struct dmub_srv *dmub)
+{
+	return dmub->fw_version >= DMUB_FW_VERSION(8, 0, 16);
+}
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn314.h b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn314.h
index 674267a2940e..f213bd82c911 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn314.h
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn314.h
@@ -30,4 +30,6 @@
 
 extern const struct dmub_srv_dcn31_regs dmub_srv_dcn314_regs;
 
+bool dmub_dcn314_is_psrsu_supported(struct dmub_srv *dmub);
+
 #endif /* _DMUB_DCN314_H_ */
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
index fd5b043dd32d..bdaf43892f47 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
@@ -235,6 +235,7 @@ static bool dmub_srv_hw_setup(struct dmub_srv *dmub, enum dmub_asic asic)
 			dmub->regs_dcn31 = &dmub_srv_dcn316_regs;
 		} else {
 			dmub->regs_dcn31 = &dmub_srv_dcn31_regs;
+			funcs->is_psrsu_supported = dmub_dcn31_is_psrsu_supported;
 		}
 		funcs->reset = dmub_dcn31_reset;
 		funcs->reset_release = dmub_dcn31_reset_release;
-- 
2.34.1

