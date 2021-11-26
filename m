Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2472C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Nov 2021 19:49:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DFB196E3EB;
	Fri, 26 Nov 2021 19:49:44 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2061.outbound.protection.outlook.com [40.107.244.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ACC736E950
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Nov 2021 19:49:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SR1bB5SU8MAskTgA/48R0bhNrY0ac3rBy1oCyFgrnOjgXoXii4XLcthUdcE7OCv+53WfOw3l8TrOa/xzGnZBqqApxGTdMtejrzGekwik61kdqH1I3uXb9vSk3tWpj5BzYQQQqjNAOGFJVVuz02C7TvRC5mox293+0HqK17tm4XoAVZjwQyMBr1qFBgfYRisMSOLiYPeqJVnpSqOCCJrwvLyJBXPAo0/3m8OS54SsR76xcMaN01TgNPWTwfesibRTKtQcEuU5PgXnMK26MuRUqKVNPzHRviaZfrL751+sqcbsuAt5ghrMTzFRExxLzVbyQcuOwSkPvpriCOqGIWvS5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7TFBXcPbk+xTU1H++yA4H3yGXGltRV4enFWXMVhNnMU=;
 b=YdhTqZvk0mDeAAx6uL4KtGIFM5Crr6EcKIVaivv0IQteWMmXqdaSHM8651ze7+onNaGUhnzQOMozudEadm+7PRpA8G3o7CuUNk3mauyty0irOeAi565rqEHRpEeMOVkEENhdp51Yls2wthsFf3xBuu6vJQ7s7kKAKCr7W1z2S+zW6BNZJj8SblNIhYabXYDq2UT9Qj3cgGnE1UeR1x/qxhoRYhEXyLFOR7oneTYXY1I0JJ4P251DFNBjvc+4uDxCF9lBMP/uXwF8eEsxW8TpRfnbUmLVT2al32VeLlJMq7H0AxnSZ6B3LjgEA2/8IJcgfMIfuY9UAW4vldSfvLQbwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7TFBXcPbk+xTU1H++yA4H3yGXGltRV4enFWXMVhNnMU=;
 b=JpXQukdrMJvNgo+rR48Fuh7B4dTy5nwBBCzWPvtLgQ4RqGHw0AndEVmOpmqROs4nUMRYEDo0rBh4CjXVaxFxsx/SYVrUtvEjZT0YGxpXEnEOR2jmLoo2uHR5BXIpsngZt2JgZ4iHdJORF4lgrcc4hMYH4VMVcYf43KBYsvImliY=
Received: from MWHPR17CA0074.namprd17.prod.outlook.com (2603:10b6:300:c2::12)
 by BN7PR12MB2611.namprd12.prod.outlook.com (2603:10b6:408:27::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.21; Fri, 26 Nov
 2021 19:49:36 +0000
Received: from CO1NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:c2:cafe::3d) by MWHPR17CA0074.outlook.office365.com
 (2603:10b6:300:c2::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22 via Frontend
 Transport; Fri, 26 Nov 2021 19:49:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT054.mail.protection.outlook.com (10.13.174.70) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4734.22 via Frontend Transport; Fri, 26 Nov 2021 19:49:35 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 26 Nov
 2021 13:49:33 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 26 Nov
 2021 11:49:33 -0800
Received: from blakha.ht.home (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Fri, 26 Nov 2021 13:49:32 -0600
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 07/16] drm/amd/display: add function for eDP and backlight
 power on
Date: Fri, 26 Nov 2021 14:49:13 -0500
Message-ID: <20211126194922.816835-8-Bhawanpreet.Lakha@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211126194922.816835-1-Bhawanpreet.Lakha@amd.com>
References: <20211126194922.816835-1-Bhawanpreet.Lakha@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f2df2f7d-d7d9-45b1-f825-08d9b115dfae
X-MS-TrafficTypeDiagnostic: BN7PR12MB2611:
X-Microsoft-Antispam-PRVS: <BN7PR12MB2611A25575DB504B0654C43EF9639@BN7PR12MB2611.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SJ1BCyn7hf4NyU4H1oNUZLGNsmLJeSLLPoGqdyvxvybzdiYE9G+UW4sso9hXsCJ01EWe3F6iJkURj5Crul4S5xCoYRLcqAjD42yJfhlJSWRYa1a9AM0UDo7eExgWsyHckbkPC58HMVvMD6r14Bd/3sQD3OaOYS39hGjK4ilBWuU1hh/DFfuexqdT6GzFXzvVZMzb+XhDvDi3ntT9dJaSpZIUH9J9Xk6naF32IRdPq2S7yUiKTqEecJZCtr5DpD6HoT/vyVICy6zF3ss2dG3NwKJrVxsyjCx6owQjlSJpQDoPzVHrEiMW4XpjgY/nh4TpCHZaqcJmz/+htCo3BZdZry3BrZ+w0MM6/aq6yU6hoZKZ07o6PftVjamYYT39k18hMBCjPNIK8PjB5fkBUrNMyAKdm0WWVM6CvIFeQpeFkBTSUMQxBoiSuU+n8NUSopE7xtZ1VQT4fXRKKXCdOPZm3D7hvdt4EOk27GKoQEYuTNx4cXE7gNgZgR00niGX9HhBHCbBpNzwBU9THJGiPoa3MZIX6qiOb4UpItGSU/QojlJVjjpF2nEmi84up/fr7C3nZIaYONgjnuHK0aXYhjd+WJIMPTeEQnbWAD2u515DqXv9BUbQWf6ihVzH2U6vimuXuYEKaW0ia4x7pyaLjp0ufSerG/K/6impsRldSQbutnVgsAGSQ0y77RsvFuefMZ8UpEv/e386AWL96FlCX2tij6aIaHBC1PYpiuHnJU3EvvM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(336012)(86362001)(36756003)(6916009)(4326008)(81166007)(6666004)(8676002)(426003)(2616005)(186003)(8936002)(47076005)(54906003)(82310400004)(316002)(36860700001)(26005)(356005)(2906002)(70586007)(508600001)(70206006)(5660300002)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2021 19:49:35.3262 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f2df2f7d-d7d9-45b1-f825-08d9b115dfae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2611
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
Cc: stylon.wang@amd.com, Anthony Koo <Anthony.Koo@amd.com>,
 solomon.chiu@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Evgenii Krasnikov <Evgenii.Krasnikov@amd.com>,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, Anson.Jacob@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, mikita.lipski@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Evgenii Krasnikov <Evgenii.Krasnikov@amd.com>

[HOW&WHY]
Add function to be used for early eDP power on

Reviewed-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Signed-off-by: Evgenii Krasnikov <Evgenii.Krasnikov@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 11 +++++++++++
 drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h  |  1 +
 2 files changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 297553074bfd..ee9b80809fc5 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -6289,3 +6289,14 @@ bool is_dp_128b_132b_signal(struct pipe_ctx *pipe_ctx)
 			dc_is_dp_signal(pipe_ctx->stream->signal));
 }
 #endif
+
+void edp_panel_backlight_power_on(struct dc_link *link)
+{
+	if (link->connector_signal != SIGNAL_TYPE_EDP)
+		return;
+
+	link->dc->hwss.edp_power_control(link, true);
+	link->dc->hwss.edp_wait_for_hpd_ready(link, true);
+	if (link->dc->hwss.edp_backlight_control)
+		link->dc->hwss.edp_backlight_control(link, true);
+}
diff --git a/drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h b/drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h
index a6d3d859754a..8f50b1ba2058 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h
@@ -217,4 +217,5 @@ bool is_dp_128b_132b_signal(struct pipe_ctx *pipe_ctx);
 void reset_dp_hpo_stream_encoders_for_link(struct dc_link *link);
 
 bool dp_retrieve_lttpr_cap(struct dc_link *link);
+void edp_panel_backlight_power_on(struct dc_link *link);
 #endif /* __DC_LINK_DP_H__ */
-- 
2.25.1

