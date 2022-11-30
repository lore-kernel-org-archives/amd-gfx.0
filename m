Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EA6EC4321E
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Nov 2022 06:40:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6054F10E414;
	Wed, 30 Nov 2022 06:40:56 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2049.outbound.protection.outlook.com [40.107.223.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0366510E411
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Nov 2022 06:40:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l3uvZQ+ogpKyc7B5lWIL4KSviCapNDalXbyfSkq4ektw10zV+2GEeKzd0nKlgO4kIAVsiOzRj0kvw5+9CTnmDffo132t4QLzY9W4gBb5CtpM4YQTnsjpwH5Gmq6JBD7KkwSLAUKrzj8RCbTqchEVGmjr2alRdmND6Kh7z9Tq6agkT10pAaiY4qvKYqQ1twN22P80rm9fxLaybo55gYXyBDHu6rMp2a5hhCEcpoHYHuLNpDsL5JwRCIkqgegRIHUWHimUfJ1eeAuGmRwiwBiYVtDDqv2fGfgq6tHIsnj7dP37RVf1jILM177rRX5ewUMxuZ2MB4jdu+oi8WkSJRQlKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qjLfiWthQQ5DI6KPjOumMwV6DvfKxZpUUY4CmHLhFfk=;
 b=PRyRjbhm7uBoxJ8QZLyJeQ+GOjliBh/IZMjoi7uTOhRDEJAVga+BIaH/4j/TljILMohXMqfJYlz2jR6e9XlRjibZKgUVmuWTzuS39Y3O+U2/Ku2ftnL3q4mFKK+m7bIL2mmb10C/Xc3mpbqbAyTrWgxgHn5DRCg3sA+aKrX8iSaL+pejC+Kx/suUQKiP+p9KO+O6eFrjEWTd8An6wItitY89e3Jgk3tbye+fDHexFSuE/Q6pnSOwX3MKRHT3FKHHEGFNS678E/S6kwEtOH4dhzmCzFe+xKuwrNyLbFyTxyXnkvL5DQPIhjKvoCxzgKtX68P/gJCxz2KjP23DuVpu7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qjLfiWthQQ5DI6KPjOumMwV6DvfKxZpUUY4CmHLhFfk=;
 b=SBzS5mim1CRlR1MDBZq2L/HnOv5ec6/PqNBE+b97or/vPXuZrxUkDI8sKDFKlI/Tb7YWazRjdaTMsGCGV5VPodvAWCljhLPn7ghbB9zWeDkwUQzjsny3NeT2KIihmMR2LJQO1/06hK/EXKVDMR16b8ARBoE572PS4z/ETsJRQNM=
Received: from BN9PR03CA0757.namprd03.prod.outlook.com (2603:10b6:408:13a::12)
 by PH7PR12MB6443.namprd12.prod.outlook.com (2603:10b6:510:1f9::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Wed, 30 Nov
 2022 06:40:50 +0000
Received: from BN8NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13a:cafe::dc) by BN9PR03CA0757.outlook.office365.com
 (2603:10b6:408:13a::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23 via Frontend
 Transport; Wed, 30 Nov 2022 06:40:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT021.mail.protection.outlook.com (10.13.177.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5834.8 via Frontend Transport; Wed, 30 Nov 2022 06:40:50 +0000
Received: from stylon-EliteDesk.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 30 Nov
 2022 00:40:46 -0600
From: Stylon Wang <stylon.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 13/14] drm/amd/display: set optimized required for comp buf
 changes
Date: Wed, 30 Nov 2022 14:36:26 +0800
Message-ID: <20221130063627.2398341-14-stylon.wang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221130063627.2398341-1-stylon.wang@amd.com>
References: <20221130063627.2398341-1-stylon.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT021:EE_|PH7PR12MB6443:EE_
X-MS-Office365-Filtering-Correlation-Id: d28ea323-d857-420b-ee2b-08dad29dd1fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j2AE6rCH+JhxL6Gz1B7OoeaOGNBupkJ3kITvGb8Bb1w9xs9gxzl/HtSTlHBNpYWUH0YQgX5M6KXHSzH0Vi2iHGtEgyBh70iUGE+zJ7mY48TRKqwaR4dS7JNfY+TmAIEd8VT2aGPB8jr34t9mYDNF4v7Ei6xGO3dLdympw5Z7Bjc0DcYtN4K4wHSKcMqe1108NlGZaOSGOfW2vMPPw/OLdZmc0iHIyoJlJf++4mMp4dhx7uW2WcA7DShvRUE5uxLe8QuQGjbFnTjWqXcC6Y9ieDo2ZsORyA3OvrdJKO+3CCJ3mRZqxhOlawc6SHNuDjC/mcjnwn6qwNR2zSz90xdjg2SAIFUAkpyeoFhs+B4J0bsJY2OdT+ECHIGuxDTWY6kyGRlHXlIKNWlTwiOWPzcx0sLwozXCEFK7XpnDtnOQtLL+jO5Xo0u6o80cY3Hz2yzkQoZboUudXfyJn0tlimDxPIBCNeXtobNCeKY/5UPMxSfBWDs/B4mVB3qeab+UT5xxH3kL77B24Lyos8e6tqRcL84WVwXPBHEo/yHMj6OT3HUMlSKMPkr9GDBk2c81CoEwBqUC5/aDw4V2ayxGIMWdQl5GsHI9IgPJIQoQx/cY0spFjubX1wBKWz+MYJ3qqiQ4zyOonyD+YrMX+H73du+gL56j+tE09mJI7qjapuEPQKPj4+jmVuLYwmndIk+HP6gVSIjx6x63L7mkSeBYpTtJFZZoNQt2qj7OXpY6MJbFw90=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(136003)(376002)(396003)(346002)(451199015)(40470700004)(36840700001)(46966006)(81166007)(356005)(2906002)(40480700001)(40460700003)(36756003)(7696005)(6666004)(86362001)(16526019)(478600001)(44832011)(26005)(41300700001)(316002)(70586007)(36860700001)(6916009)(5660300002)(70206006)(54906003)(8676002)(4326008)(8936002)(82740400003)(2616005)(186003)(1076003)(336012)(83380400001)(82310400005)(47076005)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2022 06:40:50.0721 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d28ea323-d857-420b-ee2b-08dad29dd1fe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT021.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6443
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
Cc: stylon.wang@amd.com, Aric Cyr <Aric.Cyr@amd.com>,
 Dillon Varone <Dillon.Varone@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Dillon Varone <Dillon.Varone@amd.com>

[Description]
When compressed buffer allocation changes, optimized required flag should be
set to trigger an update in optimize bandwidth.

Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Stylon Wang <stylon.wang@amd.com>
Signed-off-by: Dillon Varone <Dillon.Varone@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
index bc4a303cd864..6291a241158a 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -2011,10 +2011,13 @@ void dcn20_prepare_bandwidth(
 
 	/* decrease compbuf size */
 	if (hubbub->funcs->program_compbuf_size) {
-		if (context->bw_ctx.dml.ip.min_comp_buffer_size_kbytes)
+		if (context->bw_ctx.dml.ip.min_comp_buffer_size_kbytes) {
 			compbuf_size_kb = context->bw_ctx.dml.ip.min_comp_buffer_size_kbytes;
-		else
+			dc->wm_optimized_required |= (compbuf_size_kb != dc->current_state->bw_ctx.dml.ip.min_comp_buffer_size_kbytes);
+		} else {
 			compbuf_size_kb = context->bw_ctx.bw.dcn.compbuf_size_kb;
+			dc->wm_optimized_required |= (compbuf_size_kb != dc->current_state->bw_ctx.bw.dcn.compbuf_size_kb);
+		}
 
 		hubbub->funcs->program_compbuf_size(hubbub, compbuf_size_kb, false);
 	}
-- 
2.25.1

