Return-Path: <SRS0=RbrA=N6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DF33C433F5
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Sep 2021 14:55:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10B3C60E77
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Sep 2021 14:55:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 10B3C60E77
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3327B6E1FB;
	Wed,  8 Sep 2021 14:55:18 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2082.outbound.protection.outlook.com [40.107.92.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 099166E200
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Sep 2021 14:55:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dwPe1ABJ65/8sHBKJxNJmPA3P2+GfcClkw3SAweBg/6tyaaASH/0s84GfpMvmbWKsBMpGdJ1tfdIwDe3uqE5agFhKnAmZtqPAk1NvSk2raL/M0FA8t2tWrIOsXafLtwTL+4lgwLcYXLkFEqHv7JNHiEaoGnHyIz2bAUv7+yMnXVO3nejPfeksNYTLCJ2uiBBEyFaENRIO5ELJJWU9/UbgKvlD9PAjtaXE8MlwAqybg0MlQ6eS3/WatO6cNARCX0ZExW3yqgz0VYnacwr7/dbZtKpc7ojpfAACaJVE+kAKUCRomdnwdsS/JKnQfdIFkqU0SEDaMiFp86LjekzL6UEcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=m9XR0xFPGsajNKvo6xJa862zLJ/gv+VZk+kg2Nmbc4U=;
 b=m+pC5XZZgd2yFUtRV4//NMEreeJTp32e/xpMw6xAM98ifnWGcCw9aZ6agx8Z4T5aqI0UgwE309bVoUhN3lLW6gvm+is5WZdoeKI0ede4B0yVzPtDCw63pqF+joj82VN0Wi+7aTte95TNxmYbwQc95qfFS2ihNszKC86J0Q7013mQud79jf36FYx/m5Ahlyu/QWUuwHBXZO9YftO3mm1AgwPEYCfxRVtnqaZybWRbQf2SU0bavzAu/2RZs+7/gq4HeQdzD4bJmVlvbeJurdA8hbLiOCltPMgMhblrCQN+13vCeQBFsauI5bCKttHgRl5Wefo5B4JvHZCzqVcaIk6Pjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m9XR0xFPGsajNKvo6xJa862zLJ/gv+VZk+kg2Nmbc4U=;
 b=vqZQyh6qib6l9SlyZoaGNYROqBPsL+aXL9C5IsaYITgqMQYN2y5K+WaTGP5yTlRrOnzVVOK8VDNgqLOxZdim/7SPiik2euu6zwRDS3XCm91eykt9oYLD9GD340i7++ny3AmKbMck4wogpmLGmA8hid6of6JVZkXYIySfWt0+ycY=
Received: from DM3PR12CA0116.namprd12.prod.outlook.com (2603:10b6:0:51::12) by
 CH2PR12MB3768.namprd12.prod.outlook.com (2603:10b6:610:22::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4478.21; Wed, 8 Sep 2021 14:55:14 +0000
Received: from DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:51:cafe::f7) by DM3PR12CA0116.outlook.office365.com
 (2603:10b6:0:51::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend
 Transport; Wed, 8 Sep 2021 14:55:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT050.mail.protection.outlook.com (10.13.173.111) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4500.14 via Frontend Transport; Wed, 8 Sep 2021 14:55:14 +0000
Received: from DESKTOP-9DR2N9S.localdomain (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Wed, 8 Sep 2021 09:55:12 -0500
From: Mikita Lipski <mikita.lipski@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <roman.li@amd.com>, <Anson.Jacob@amd.com>, <wayne.lin@amd.com>,
 <stylon.wang@amd.com>, <solomon.chiu@amd.com>, Ian Chen <ian.chen@amd.com>,
 Wenjing Liu <Wenjing.Liu@amd.com>
Subject: [PATCH 32/33] drm/amd/display: remove force_enable_edp_fec param.
Date: Wed, 8 Sep 2021 10:54:23 -0400
Message-ID: <20210908145424.3311-33-mikita.lipski@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210908145424.3311-1-mikita.lipski@amd.com>
References: <20210908145424.3311-1-mikita.lipski@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5c0a4c9e-7fc4-4a87-6411-08d972d8aa2c
X-MS-TrafficTypeDiagnostic: CH2PR12MB3768:
X-Microsoft-Antispam-PRVS: <CH2PR12MB376806752BB38F3B6180EE79E4D49@CH2PR12MB3768.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XWgECq5GHuHq4aMJvI+aAfUVP+Zz6iKkv0kOotfUoKu5b008rJfOGn17XHcDlOm3cMi6aCbz77u91WDPF7C0RqKtsJrzoWsNJbNCW2+c2UiUuaosJR5qkoS2WGA2Cn7UpIDvR27KkI3Dap4vn776utoDRhrOLGgNqTRO1Q1/1lOrkeLqj4/fLW+/fZ8ZZtCJ8PlVFZ+/rlYdiYFzadEhnCBNcyfK+fI/F05Oc/YLszl/YNsgeowy2sH6ZIHAe5GRYx95M4eQ9BsYWLQeXx4jKnbapMQLzaolmSh7NgQDdHTrMiXJX7m8D0PZ6F7kk4NZTn7+PhlkQhpqo+vkFdKqMrlk9SAixLWajCTKB/r8LGxmV59f+SeGutFoNw/jE4b+mL+kVF1sebtlgd7POrrGExoNkc9xCXeeuoH0luEJdrjNmm2HsunMXOYxwHbCUw7qSmZtpNOCbPMOekpU8XqHB9P8m8rIXAyBWTEMZhRsCw99S3MZnyKAXHuc5NSpo3+hk0g6EcoB2a9nq3e9yu4NZOec3WYe6Q9a3dsHU/Zb4RcW7SXHL2PeofOChHlJg7C6xpRtccfNxWREeAP9SEWaCHYHOjXqhB1gpS3XwFDynDoPSnK4RcJo8SSjbJDo+m2gP6SsXcQuYq7CDG+OImBuiIjYaQFt7vSKnXyeProOne93SHhNTbiB+Y5yWdu06AdT8eIJNANDFM+W5rE4DdMQ6XTZPJ2eahAJucmPCC6wNrw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(136003)(346002)(396003)(36840700001)(46966006)(4326008)(8676002)(81166007)(478600001)(26005)(83380400001)(316002)(70206006)(426003)(44832011)(86362001)(82310400003)(36860700001)(82740400003)(70586007)(2906002)(54906003)(6916009)(8936002)(36756003)(356005)(16526019)(186003)(6666004)(1076003)(336012)(2616005)(5660300002)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2021 14:55:14.2214 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c0a4c9e-7fc4-4a87-6411-08d972d8aa2c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3768
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Ian Chen <ian.chen@amd.com>

Reviewed-by: Wenjing Liu <Wenjing.Liu@amd.com>
Acked-by: Mikita Lipski <mikita.lipski@amd.com>
Signed-off-by: Ian Chen <ian.chen@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 4 ++--
 drivers/gpu/drm/amd/display/dc/dc.h           | 2 --
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index 746b31ba2708..4f4992f5bfd9 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -4282,8 +4282,8 @@ bool dc_link_should_enable_fec(const struct dc_link *link)
 	if ((link->connector_signal != SIGNAL_TYPE_DISPLAY_PORT_MST &&
 			link->local_sink &&
 			link->local_sink->edid_caps.panel_patch.disable_fec) ||
-			(link->connector_signal == SIGNAL_TYPE_EDP &&
-					link->dc->debug.force_enable_edp_fec == false)) // Disable FEC for eDP
+			(link->connector_signal == SIGNAL_TYPE_EDP
+				))
 		is_fec_disable = true;
 
 	if (dc_link_is_fec_supported(link) && !link->dc->debug.disable_fec && !is_fec_disable)
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 15b67239266e..8897750bdaea 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -641,8 +641,6 @@ struct dc_debug_options {
 	/* Enable dmub aux for legacy ddc */
 	bool enable_dmub_aux_for_legacy_ddc;
 	bool optimize_edp_link_rate; /* eDP ILR */
-	/* force enable edp FEC */
-	bool force_enable_edp_fec;
 	/* FEC/PSR1 sequence enable delay in 100us */
 	uint8_t fec_enable_delay_in100us;
 	bool enable_driver_sequence_debug;
-- 
2.25.1

