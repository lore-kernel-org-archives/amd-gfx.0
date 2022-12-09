Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FDCEC10F1E
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Dec 2022 16:38:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 08C4910E579;
	Fri,  9 Dec 2022 16:38:02 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2064.outbound.protection.outlook.com [40.107.237.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B729C10E56B
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Dec 2022 16:37:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UZVj/+ZKbzjD1XHuas1DLBIWpH7u6DLi6XGylkkjMIDfIghgl303sLorE38fjttMsFV++wEPWZMSdgpWKMV8OT1lGS4ajctgTJ4tGSN/4S2clitzj4PZwb4KIgWBad0ySPjRcwFHIUNgkS5T3rK1A7FoB3K+8FSXsozXvZk3coQJhyAF3bpUoFhe8OKhCP6qJAPv53DYbpIbsqs5WhT5jPp0vKGwtnwKdo4+InosH95oKevU8XfvmbBBhHTV2xNR7QuDbzE6CujvLszJNGyeqX0H59BoVvql0cOia4StZNtxvD7Xryar564DYI8vfuoIEXPxHZjEVIeHDSDXlnsrpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5X3AJDm54pf61XRLiFl+q/gIComgIdh4PAYg+0zygZ8=;
 b=BrVBYuS10DDLdr6kQlP9bfceYMZiL/b7wUMROZ1oFszYY9b8nA/r0wBT6jEB0dhHz2lGI76fkQ7LTMJdufq8ONGZwexTaRe3+QNEIx41jAOVehf/6GdqvoEItKWy0sLEIFO1DzCo3oZjrZHK1wNmJ5qRgRG8gdV1yPSSeK+2rBd9mmkch6ZWe9yjghJHQ2hIBlRfCb2McdqSmsf3MADMAt954RuSv/TLTjdEFdeyXwCqRVoKK9tNBeSrhvfXNNOKUuC+24Yb2FS7GqTFv59z5k8BgeIdtShgyfaRf2k382ZXTo7u/prbuHttoi2Vc7xRTmfpgFkcF/cDEMrPoWsgdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5X3AJDm54pf61XRLiFl+q/gIComgIdh4PAYg+0zygZ8=;
 b=GXUs1e5Z0mBvNas8xJS1nJiIRjOojz6zvMZb9xS7sLZKRtPwXdx7tnkDQUjVZ8XExYifGJDbwO6Mqgw/6G+Xey/+13tqabtF1DxlWtPcLPr/xcIoPEzwrxYCsHw8cdj+0duS5W8g6qZA2Z2QDz06JZ5qEO4MEcd/zr7/RU7js9w=
Received: from MW2PR2101CA0013.namprd21.prod.outlook.com (2603:10b6:302:1::26)
 by IA0PR12MB8085.namprd12.prod.outlook.com (2603:10b6:208:400::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Fri, 9 Dec
 2022 16:37:43 +0000
Received: from CO1NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:302:1:cafe::aa) by MW2PR2101CA0013.outlook.office365.com
 (2603:10b6:302:1::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.6 via Frontend
 Transport; Fri, 9 Dec 2022 16:37:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT057.mail.protection.outlook.com (10.13.174.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5901.17 via Frontend Transport; Fri, 9 Dec 2022 16:37:43 +0000
Received: from jasdeep-System-Product-Name.phub.net.cable.rogers.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Fri, 9 Dec 2022 10:37:38 -0600
From: jdhillon <jdhillon@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 22/23] drm/amd/display: Reduce expected sdp bandwidth for
 dcn321
Date: Fri, 9 Dec 2022 11:36:46 -0500
Message-ID: <20221209163647.25704-23-jdhillon@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221209163647.25704-1-jdhillon@amd.com>
References: <20221209163647.25704-1-jdhillon@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT057:EE_|IA0PR12MB8085:EE_
X-MS-Office365-Filtering-Correlation-Id: 05a51c2e-1409-4ef8-c0df-08dada03b221
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0E7nu3YUNvWTyfRZCWcbcbxwv6NfMUa7sK/DCb7m9ZoLolix2ocwiB2oWxWvaIKTVmPBqrEoGpEJUpBi68g8J2Pzs9tNjaHq4T1bS5mqTsof4gEDd76QmoOnPJMWyq3pEKUgHcmPdczw5WOIDgdmLFucC43c0AQgiTQSWX+I3/d9bx99qFuUsHbgl6+QduOJA8yqxRWcVniVt/qZ7IDLcdM20ZeVmGW8E2LL+Ob2QUPw5hvTVr5vo0MSvNYxTs24H9XmKI/rPsnbZQ4f2DpaPYQz00jO6nZFBeWy0t6nKUMKC6f931+vxhK0Kd6zuBaCl5v+9x+MNyjd9CVUxwvxcY4Bp2uDFlSGK3sUpXJ/CCCSEHiz7QbsMpSXD97rf4IL/R31mErpgtaaJMa2Ef7rcD+yFjtc0nxt1SZXzDcUPMJgzijzWmZcaHfn/GHaDyWMg82cOCgFKxOMNpcdciFfYSmoyLGETsqGkk8kTUiBuVgPzam0Eaw1SE/ExbMZXn0Y2kPf/qKObWR5Tm9t0cBfPKKiPYvCUIlV9d3HKJRTx4Y5rNK5Oz7yQUUDngfhNyq8sH2Bx9FsUcv5YeH7Z/bkFin4LrhMfeSF+ATq/JPwIbc0Ci8Gz9QzKDZBhIB7b4KnLDXWfU0Ly4BuYg9V5gQ7JRmKTWoFlRWdWrdC6XSuHwhevHw7bnplx9BTMv4cVeloZOf46Y2TkeaW6DyHHd/at4fpWNrJOPpE4vhN7pdVnnw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(396003)(346002)(136003)(376002)(451199015)(36840700001)(46966006)(40470700004)(83380400001)(186003)(47076005)(2906002)(54906003)(336012)(6916009)(16526019)(26005)(40460700003)(82310400005)(2616005)(1076003)(316002)(41300700001)(36756003)(426003)(5660300002)(8936002)(36860700001)(70586007)(66899015)(70206006)(40480700001)(478600001)(82740400003)(81166007)(8676002)(4326008)(356005)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2022 16:37:43.3097 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 05a51c2e-1409-4ef8-c0df-08dada03b221
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8085
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
Cc: stylon.wang@amd.com, Dillon Varone <Dillon.Varone@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Jasdeep Dhillon <jdhillon@amd.com>, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Jun Lei <Jun.Lei@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Dillon Varone <Dillon.Varone@amd.com>

[Description]
Modify soc BB to reduce expected sdp bandwidth and align with measurements to
fix underflow issues.

Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Jasdeep Dhillon <jdhillon@amd.com>
Signed-off-by: Dillon Varone <Dillon.Varone@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml/dcn321/dcn321_fpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn321/dcn321_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn321/dcn321_fpu.c
index f4b176599be7..0ea406145c1d 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn321/dcn321_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn321/dcn321_fpu.c
@@ -136,7 +136,7 @@ struct _vcs_dpi_soc_bounding_box_st dcn3_21_soc = {
 	.urgent_out_of_order_return_per_channel_pixel_only_bytes = 4096,
 	.urgent_out_of_order_return_per_channel_pixel_and_vm_bytes = 4096,
 	.urgent_out_of_order_return_per_channel_vm_only_bytes = 4096,
-	.pct_ideal_sdp_bw_after_urgent = 100.0,
+	.pct_ideal_sdp_bw_after_urgent = 90.0,
 	.pct_ideal_fabric_bw_after_urgent = 67.0,
 	.pct_ideal_dram_sdp_bw_after_urgent_pixel_only = 20.0,
 	.pct_ideal_dram_sdp_bw_after_urgent_pixel_and_vm = 60.0, // N/A, for now keep as is until DML implemented
-- 
2.34.1

