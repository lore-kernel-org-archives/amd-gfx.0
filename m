Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 856B8C433FE
	for <amd-gfx@archiver.kernel.org>; Sun, 23 Jan 2022 18:21:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D43EE10E29F;
	Sun, 23 Jan 2022 18:21:02 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2072.outbound.protection.outlook.com [40.107.92.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B63B10E29F
 for <amd-gfx@lists.freedesktop.org>; Sun, 23 Jan 2022 18:21:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ehdgMLyOrYhBC8jEwc+r6lQsuGPRRJk4iXvx4f+sJIgqoosDMknJ6GvbqMSiUXTepICgshPkM9uDk57CHBVJB7XnrwC1CKS8RWllsjAhtQobAcKHooy0IVpIuNdFwgTeW2LhXVpK610EMQ2wuBnhvnQKQT1vInkjT4U1aAqXwZyOROsFQyL+MirhedJFr2AKg2rGujg2dvL2Bk8R+KhRXqIsOCoXlRyEk3cdw/YikyvWTB7Tg52eQVVEAyetufTbiZQn1IzoK5B/i+HT0pxtk4DO1OM4KqpcVmkCAJLcPnn4gJJvnvWgYf6bKBW7kNDG4TQPPh0AtMeHe13Gv8lsLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gdrey9WNX2cDmWXqjBmSgOpS1Om+3T2kOaFz4sfKyrU=;
 b=IXphpraaeh3G/K6OIpUbI5RuAXzkP6vKPNNG4rdlIvj0ojTj15keNYjDn2FpDResgVGud2Y4iGeKRFyDlg7Alp5xGz6fIUli9KX3Yg+iiWVjBNRWhzrQhmZEg6AqFEAyIuz+yiUvUyhCqkUKfUEYIhpSjHfUzUgPg3IgTSgSFHBN2TxsQJu7ptKXC+4CzK1suIqPMPtHJKY0Wo9Eofl7IKC7J8ECX9968cnZFV51zMBWlt0MP+MapXzkreCHMuSgwWKa/gmS2qrDB+IW0Ph5hdvg28/X0A58Y5hDerF5pwT1Oje2eT2KMcde1xlBpLeCscqKqLyalfpK5GkjFamDVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gdrey9WNX2cDmWXqjBmSgOpS1Om+3T2kOaFz4sfKyrU=;
 b=zxXK76qzMcKJbLqdbNzSofM2hbTaDKK6HxL+48ImDj2e71OBYgrKRnUhEURTDqjnawwtOhsiDMvHVSwISAgaXOo4b0u8cU9LVdRyIXZgjuzt5WWS/tYK714vVPSpvzCt6Mm2tKSGKeLKf8kh1wBklUZUoYm3H406blxYA24yC6c=
Received: from BN6PR14CA0002.namprd14.prod.outlook.com (2603:10b6:404:79::12)
 by DM5PR12MB1193.namprd12.prod.outlook.com (2603:10b6:3:70::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4909.10; Sun, 23 Jan 2022 18:20:57 +0000
Received: from BN8NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:79:cafe::39) by BN6PR14CA0002.outlook.office365.com
 (2603:10b6:404:79::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8 via Frontend
 Transport; Sun, 23 Jan 2022 18:20:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT046.mail.protection.outlook.com (10.13.177.127) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4909.7 via Frontend Transport; Sun, 23 Jan 2022 18:20:56 +0000
Received: from atma2.hitronhub.home (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Sun, 23 Jan
 2022 12:20:54 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 02/24] drm/amd/display: do not compare integers of different
 widths
Date: Sun, 23 Jan 2022 13:19:59 -0500
Message-ID: <20220123182021.4154032-3-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220123182021.4154032-1-Rodrigo.Siqueira@amd.com>
References: <20220123182021.4154032-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e44535f6-46fd-48d8-3f4f-08d9de9d198f
X-MS-TrafficTypeDiagnostic: DM5PR12MB1193:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB1193C57ADEC778286271DEBB985D9@DM5PR12MB1193.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:285;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OHknHQr8s/3DbhCTbPfpqNu+hOuCzk6BDWxtkpFMCdWHjajrcOHtyOnpjUBlIQzE0gX9GcSfWvOzja1UNSNAyL8SdYo2B/DnJyyJoW+Y/qNY8jcobtZi56gMcU1OpPfJstvKF18gvbooMz1WPJVlKI+UGPPRILV2TJ0L7w3mE7VtAhxxBZNlywbr20GAn9XwxvpPai8Hfk5CjLl9E3Ozr0nwIvngUw1MWAbD03SinXxTSEhdKxGLxYudqRZ74GZxFhsUFe/RfBHko4m1mGi37JgD1ppMhOxtqiH69LfD9Gq3wQcqfz4dU+JfDM3be/67MwmdT3i89DQQtfNOqoQ152HDWUuVmcIb4hVSiixYWLaTzxutUY0/r9NYhdzjDI/t0dRDauzPa9exiQ1ki4o4rGIwB+7U+KIzimsgZF2tlOHd64jO/58oxiSse/A4Pc9aOfAtVdOmbHM/2dL6ZaXwUcryRunqY61x6bdYyxUKWWSk/QMGqEbuVPcCC769qWoGL2rG3zJIYih5Kn6Ncwn6HY/90cvbsCR2UoKuXepx+/nr+xfyi07JeVz/8pg5Qom44+es1fuAksqoY5gwZTbhY0V4yU9mj7rv5rdxykqqW587ZDsZ0GdKZBpVa0gXLBiGlKj4dUO53Zz3ZrMTGtOa4cQrljIbivl05C4UDVnX1g2dwC3ORqoosWHyRG2+s9hssu1zUP/agd+tVbVS6HrODZ98OxW3AZx/5phczxIAHHY3D3utSUvRtxd5hah3G381X0NUfnKrBihFUq1EK1X4CTGBf42b44Izi6DV3uURD/E=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700004)(336012)(426003)(8936002)(2906002)(6916009)(82310400004)(40460700003)(16526019)(2616005)(8676002)(356005)(36756003)(81166007)(47076005)(36860700001)(70206006)(86362001)(316002)(54906003)(1076003)(83380400001)(26005)(508600001)(5660300002)(186003)(4326008)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2022 18:20:56.9217 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e44535f6-46fd-48d8-3f4f-08d9de9d198f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1193
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
Cc: stylon.wang@amd.com, Josip Pavic <Josip.Pavic@amd.com>,
 Anthony Koo <Anthony.Koo@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Josip Pavic <Josip.Pavic@amd.com>

[Why & How]
Increase width of some variables to avoid comparing integers of
different widths

Reviewed-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Josip Pavic <Josip.Pavic@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index 2ff4869d190c..b94927eaba8d 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -4743,7 +4743,7 @@ const struct link_resource *dc_link_get_cur_link_res(const struct dc_link *link)
 void dc_get_cur_link_res_map(const struct dc *dc, uint32_t *map)
 {
 	struct dc_link *link;
-	uint8_t i;
+	uint32_t i;
 	uint32_t hpo_dp_recycle_map = 0;
 
 	*map = 0;
@@ -4784,7 +4784,7 @@ void dc_get_cur_link_res_map(const struct dc *dc, uint32_t *map)
 void dc_restore_link_res_map(const struct dc *dc, uint32_t *map)
 {
 	struct dc_link *link;
-	uint8_t i;
+	uint32_t i;
 	unsigned int available_hpo_dp_count;
 	uint32_t hpo_dp_recycle_map = (*map & LINK_RES_HPO_DP_REC_MAP__MASK)
 			>> LINK_RES_HPO_DP_REC_MAP__SHIFT;
-- 
2.25.1

