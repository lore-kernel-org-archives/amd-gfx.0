Return-Path: <SRS0=JNIh=LB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75969C47095
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jun 2021 16:48:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 490D760FE5
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jun 2021 16:48:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 490D760FE5
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0CD8E6E934;
	Mon,  7 Jun 2021 16:48:15 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2043.outbound.protection.outlook.com [40.107.94.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 42B2D6E933
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Jun 2021 16:48:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fv7TCN6OaAnPz/ipQM5dhIFRUE7iiQc/3dsffMVkwJ3wKMbEfF8acfm8MVQMP7SJEKjI53IyGXGTYHkF+KjwOVnugyZv+5dI6+OuqvumV4XFrM9vJuxYXaCpE8l+w1SQ74whLEljjA6jG2TUU/cHaDRRU+qXALuuzg7Oacv+5NhVUTewu8brukImpmQZOqM/MF48ytJMRCb5wH9SvHqyLKI5JhdDPNvoaUt/tIyQPV6pnCDPQ6uGBTKvdZXCEa8J+jf6L+31vqP711cLj7lQfdWyjOZsDwJw+Ig888mpq8cRFbcf48RaaaVbfR0OJZgM/Vfxtjgw2JD45yDu+44W2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yna5HNpzYRalUMs1/iZt5KrQDGJVEMVtw46+dr/ChaQ=;
 b=kDg1Nmin1asxpYwUbjagdoQuACQ7ubiZdYbkZgsODVXd/anf3bfHa0OROgqARGrjRp3u+mCiEJHlzVxo1H2woFHsLfl7ybvC8EskKJ5dGxI0vn6ZMDNWHKT43zB7qZbMgspNFqo/ND9K/nfVkuCe7jKOUM5fnmCxM5FUsNZAyG09hefJOb3QpOhI4c8G0xmO5Rekeo9lffzDtLAZuaq7IS7tO1+yoXxcVkHfrUov6WX24oJmcUXkkx70VKeEWZX8+McpGXQqWNDDE24xXOZp33BAn/dLNO4MsF+fFs1JZapTvR0qvOQ5b5LvVkg2G26FXt77yDh3xgHMb7Q/IxDRcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yna5HNpzYRalUMs1/iZt5KrQDGJVEMVtw46+dr/ChaQ=;
 b=x6B0js2J9VQ3Y464Zb9lS7iKfERaCN9ZUDmyueL7tlFOCN5nvytHTdqbyJjfpqwq0eLB6FgboRcvckMEzx0Wg26Vu4OXdn4Kz51immA4TPRLZM0Eq6R4be8rlUnFe9HYmO086jgeqlNrlpgJcSkgJLrAgobhhB+m4rjE9j70J/w=
Received: from BN6PR14CA0005.namprd14.prod.outlook.com (2603:10b6:404:79::15)
 by MN2PR12MB3181.namprd12.prod.outlook.com (2603:10b6:208:ae::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.24; Mon, 7 Jun
 2021 16:48:11 +0000
Received: from BN8NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:79:cafe::48) by BN6PR14CA0005.outlook.office365.com
 (2603:10b6:404:79::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.21 via Frontend
 Transport; Mon, 7 Jun 2021 16:48:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT003.mail.protection.outlook.com (10.13.177.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4195.22 via Frontend Transport; Mon, 7 Jun 2021 16:48:11 +0000
Received: from stylon-rog.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Mon, 7 Jun 2021
 11:48:07 -0500
From: Stylon Wang <stylon.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 07/30] drm/amd/display: add visual confirm colors to
 differentiate layer_index > 0
Date: Tue, 8 Jun 2021 00:46:51 +0800
Message-ID: <20210607164714.311325-8-stylon.wang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210607164714.311325-1-stylon.wang@amd.com>
References: <20210607164714.311325-1-stylon.wang@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a157f7ce-d6b5-41ac-ced4-08d929d40919
X-MS-TrafficTypeDiagnostic: MN2PR12MB3181:
X-Microsoft-Antispam-PRVS: <MN2PR12MB31814E8E2B39F09FB16937B2FF389@MN2PR12MB3181.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7wEJmKg4FRTawEq8+OQGRIq6zOHk2xzApX385TMk7bfR07qAWSJxPHfmXW5EyTaUbbCs5RUsKSJl8C1C8PT+jAleJAWovyTjUWZ94IWPERTQuyvsqysOKAyC0RivDWrfYEBazO3DVXEDO1uJTYWP3Qb7GFTeC4hew2VHRGJjZUQLvdmK1vIPcvRsVah4M32GjIYVkD61gUoIm6TWTUexqCabgRMTepQgTFMPYYXjOwozG+/FUfyHMwy49WWC3EQx5ePJw7c3SmudR3Qtrmuohanw4615R2s2wN5IbSZrnbxi70KPlPtCCBwv04WCICp9hxhNL7jVtqj1E9MR8wcpusfGFrqEoCE4zOiyWJ9eUwhFVtmUS3MgxIO+FeZHzxjG9h8ZQ/swug0jcPS0ndv9lsXYdLBPN18phfcIIJQpCHasNAj8YY7/8oZGWejCpI7cQKqLPqTJAHzTKHNXVF7H4lppSmiz/q1vPpcTSKSfwN/eDjWB3xxpLinsY1ThWreyqKuj6KAuIC6xQC7HW3wVNucG9Lgz0RoyIPr86LvEJt5eCv3CSv+uUclSl/DPJA44Px0LgXtTOniZE6W60VENQ4cedXkxAxO8XWY9QVnyKLkdhst16x5as6Q1JaVVgMbXVj+nOauf962iIhB/5/SdOSipW0U9fWEjHBbCNvr1EuJ/wHuZDzIPLC0fKS7/uSVQ
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(396003)(346002)(136003)(46966006)(36840700001)(1076003)(4326008)(81166007)(54906003)(8936002)(70586007)(36860700001)(336012)(82310400003)(16526019)(70206006)(86362001)(26005)(7696005)(8676002)(82740400003)(6916009)(47076005)(356005)(2616005)(5660300002)(44832011)(2906002)(478600001)(426003)(83380400001)(6666004)(316002)(186003)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2021 16:48:11.1693 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a157f7ce-d6b5-41ac-ced4-08d929d40919
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3181
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
Cc: Stylon Wang <stylon.wang@amd.com>, Aric Cyr <Aric.Cyr@amd.com>,
 Eryk.Brol@amd.com, Evgenii Krasnikov <Evgenii.Krasnikov@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com,
 Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Evgenii Krasnikov <Evgenii.Krasnikov@amd.com>

[WHY]
Currently there is no way to visually identify if there is one or more
layers presented fullscreen on the display

[HOW]
Add new visual confirm colors in get_surface_visual_confirm_color for
planes with layer_index > 0

Signed-off-by: Evgenii Krasnikov <Evgenii.Krasnikov@amd.com>
Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Stylon Wang <stylon.wang@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_hw_sequencer.c  | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
index e0badab842ba..ee3eef5a1f44 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
@@ -323,11 +323,20 @@ void get_surface_visual_confirm_color(
 	case PIXEL_FORMAT_ARGB8888:
 		/* set border color to red */
 		color->color_r_cr = color_value;
+		if (pipe_ctx->plane_state->layer_index > 0) {
+			/* set border color to pink */
+			color->color_b_cb = color_value;
+			color->color_g_y = color_value * 0.5;
+		}
 		break;
 
 	case PIXEL_FORMAT_ARGB2101010:
 		/* set border color to blue */
 		color->color_b_cb = color_value;
+		if (pipe_ctx->plane_state->layer_index > 0) {
+			/* set border color to cyan */
+			color->color_g_y = color_value;
+		}
 		break;
 	case PIXEL_FORMAT_420BPP8:
 		/* set border color to green */
@@ -343,6 +352,11 @@ void get_surface_visual_confirm_color(
 		color->color_r_cr = color_value;
 		color->color_b_cb = color_value;
 		color->color_g_y = color_value;
+		if (pipe_ctx->plane_state->layer_index > 0) {
+			/* set border color to orange */
+			color->color_g_y = 0.22 * color_value;
+			color->color_b_cb = 0;
+		}
 		break;
 	default:
 		break;
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
