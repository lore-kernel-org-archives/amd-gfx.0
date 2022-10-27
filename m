Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8731BECAAA1
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Oct 2022 18:42:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F1A4710E6D6;
	Thu, 27 Oct 2022 18:42:25 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2046.outbound.protection.outlook.com [40.107.93.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D30310E6D6
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Oct 2022 18:42:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZC4tlYl3OfLcmLLqXouNOBCBjhdujmCq2GaAa8uUPm/sjCrmOwLsSzTco1+RFKYziszepGHuF5uxiyckkCtmPo/mvxgllulvMrhqURBzEA9wTQU4yUw/NgLlyQ8sYuU5pp2i3DuMjSYjGhtT3jopnLAL4eSN2UvvYbm/hQn/uybifvPX6nYSRP6S9ILCIFg7IQWeqM4YyaOdzWdBJr+ox1WJ9gUqSdiIUPhPQ37FRvyIG54k53dhohRLr+7lmtt35mJRATdx/5R7hs14yME9yAwlR5I27NsppAfsHnUZyfP7BXtcKNGN96P1d9HSxaUwUgLQo16HwXIDxWu7m3lkaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0R9w14V5WTpxl7zIRDJBTQW+N1yeiL7mKJ2+XkBA/E4=;
 b=DbThFdhtU0oMTrfN0IX7Lc4c58LIYvGIuo727DH5ykzqFfyCPSIFbNHUCbBpA+QkRm7o0OOSKLH9Xu8QliFf5nRw9FCj80G5ggZofbE/FxxvWcEJQWUrCe4aBGi8TyiPCxrbgwcBXRN2IEGyQioevi2OuMOt05FVZ+ugyBKI3xEVY08xb6b+L3ibIFjSOldl8T/kA8sSUv7FmrUrBWukt+xUsruMuAdaNH+T+IqpO1kn0NFj9oH3A3doFKtkfW9OwrKuGYmsHwrMTxf5z72Lr3ScHu7rne91YhGoQZ/UX4/hanihbk04rsu3vcNzO6bq8BqekXMg/GkGig6DlGytpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0R9w14V5WTpxl7zIRDJBTQW+N1yeiL7mKJ2+XkBA/E4=;
 b=uFlYO51xAKmE8rKvOIoucuhJrVjAXsIgNDlt/KAsLAv3SSwzeMAP7Urf0n3HihQurXaJJ5mR8gluFbbD9Opzk+NJjxgFuCpWIYeAPkygWS+oDCUoXTsILQdNhfxo17GSxJVFyOWzTUAFw7Zjymz5c+Ta/GSSylsgpWWc4VC7CUs=
Received: from BN8PR15CA0070.namprd15.prod.outlook.com (2603:10b6:408:80::47)
 by SN7PR12MB8026.namprd12.prod.outlook.com (2603:10b6:806:34b::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Thu, 27 Oct
 2022 18:42:20 +0000
Received: from BN8NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:80:cafe::35) by BN8PR15CA0070.outlook.office365.com
 (2603:10b6:408:80::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.23 via Frontend
 Transport; Thu, 27 Oct 2022 18:42:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT055.mail.protection.outlook.com (10.13.177.62) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5769.14 via Frontend Transport; Thu, 27 Oct 2022 18:42:20 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 27 Oct
 2022 13:42:18 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 16/18] drm/amd/display: Fix null pointer issues found in
 emulation
Date: Thu, 27 Oct 2022 12:35:41 -0600
Message-ID: <20221027183543.1117976-17-alex.hung@amd.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221027183543.1117976-1-alex.hung@amd.com>
References: <20221027183543.1117976-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT055:EE_|SN7PR12MB8026:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e67f518-73ce-4d0d-2f96-08dab84afae2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 34U2nZYjqfwVtvzsnsCV54ytrgzzfjZGI1qqleGRsV5mEYj5bXwyOrDoom1BhcZayxnXBanxoUhsaSFwh+yl+G7nELwwwlTR6jO4RWoXxFNO06BAkwbjXPBf/4LQHcUgvsI5JHTKzEygvGdrKKb9ag0aZ1a1bzrSe/LOBb4YP6i3yo6sTdBJMaA91iuOzG+45u3iyNlnT91fw47zsFPvg5wn6eLs3SXANzs3xrB9DXJ44DEvFkOnOSStVkRUVrTArG57LiK06Kk5ICaf6yXkwpDhCWBfYHKuDOD0uDeegz5Qil0PWkzKeSrzMCWFhRxQ9AVUpgUeZTV8YlmMkM90+fHdVnPrH7JL/QulHL1IrjU6vFdgk3o1GxgAaMgMsLTKEFkQNG+Mbrzp/iUHYxTNS8rnB2FPVp/y4TlpZWPAmhuAporuO62IkNo7mxUXsZW0LZLFGD33UMnQMdf0L0u0N5EbBLlGOg5lr8Yy5cmR/P/olO6JHqbgnXFrtZSh8iojKAB3ImIwGuigkfwzECg6G8SfossdDK75rIH2lEa+ee9j5EE94TqTR8OOkyhYOMNXzD2a4JGT5aOPQnNkctL8Fan5cdtwE08AYWOGdUQO9zvNNy+WgdUYGzsazT3sFYLLFhezOcb8R5ueaYMJy2D+7t1ExVC4fOhZHb5trLmKKr2UtFmzAaeR9eU39O7HEY5MCLoN+60zZSTUpJWfLMz9M7SVvl78zmDjPpQkcZJlE1FHygCn9kbkMXV+M4ek1dZrSls3JV7SQypFXhW/DzPZyrUZuAKhlM4ZmZQ0GeH15hmgSCcaA0z8tXdYFY6UAfeb
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(136003)(376002)(346002)(396003)(451199015)(46966006)(36840700001)(40470700004)(7696005)(336012)(6666004)(186003)(47076005)(83380400001)(1076003)(36860700001)(70206006)(426003)(26005)(2616005)(16526019)(44832011)(2906002)(40460700003)(8936002)(40480700001)(316002)(6916009)(54906003)(4326008)(70586007)(8676002)(41300700001)(478600001)(82310400005)(86362001)(5660300002)(36756003)(82740400003)(356005)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2022 18:42:20.2095 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e67f518-73ce-4d0d-2f96-08dab84afae2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8026
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
Cc: stylon.wang@amd.com, Charlene Liu <Charlene.Liu@amd.com>,
 Chris Park <Chris.Park@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, Alex Hung <alex.hung@amd.com>,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Charlene Liu <Charlene.Liu@amd.com>

[why]
fix null point issues found in emulation

Reviewed-by: Chris Park <Chris.Park@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Charlene Liu <Charlene.Liu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c
index bdf101547484..165c920ca776 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c
@@ -89,7 +89,8 @@ static void enable_memory_low_power(struct dc *dc)
 		REG_UPDATE(MMHUBBUB_MEM_PWR_CNTL, VGA_MEM_PWR_FORCE, 1);
 	}
 
-	if (dc->debug.enable_mem_low_power.bits.mpc)
+	if (dc->debug.enable_mem_low_power.bits.mpc &&
+		dc->res_pool->mpc->funcs->set_mpc_mem_lp_mode)
 		dc->res_pool->mpc->funcs->set_mpc_mem_lp_mode(dc->res_pool->mpc);
 
 
@@ -141,7 +142,8 @@ void dcn31_init_hw(struct dc *dc)
 
 	if (!dcb->funcs->is_accelerated_mode(dcb)) {
 		hws->funcs.bios_golden_init(dc);
-		hws->funcs.disable_vga(dc->hwseq);
+		if (hws->funcs.disable_vga)
+			hws->funcs.disable_vga(dc->hwseq);
 	}
 	// Initialize the dccg
 	if (res_pool->dccg->funcs->dccg_init)
-- 
2.38.1

