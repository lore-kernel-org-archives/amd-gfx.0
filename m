Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49231C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 10 May 2022 20:46:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 00D1E10E89E;
	Tue, 10 May 2022 20:46:07 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2064.outbound.protection.outlook.com [40.107.102.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0084310E89E
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 May 2022 20:46:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HI8E2S3LvsLz91rdmqpivJhxlJyXkYZBVv2vzWv1kKKvdf2x9zxH8wtqgbyoBTG0Ym7e6y+BahjFp0nWxa3eV0YY9QhEXGC7BWa3MPudESvyUN9c8nwq2cyhJUauZtv55XRq1CatK6aE/hB4Rw+yUwXyQRTF10lw+58AGQew80h0f5etsZ9Ct/oOw7PAauI1KH5EjBKQIRwff3WvFPHp1aFwK334aAepmN2arMpL0bTirFOsgQMp5Gnsu4Lisr5SoZ+o+WeqwZQ/yfAZ9Wz/vuuWq5KNlAvRNkZo8/GAqeAP+hwEYqvgQbjQkAaRKCvojWLLJ4+vL4oyKRp3LTXdLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vjGFSzLBinIzRkafNAuqR6OLeGgv1M5Zjw16eCgD9Zk=;
 b=B1jaRh3UhKC6w3brKcRmkE9D6BIPFGv9FSbHZ7xV7Tbo1HtrfsGcWPI1wsP/495haQc3iE7JsbBUoAQu4TX1fDEySrrOsu5mCvTM1mnw4qxir2v84Spa1DsWR7v7SO+TRJqEIHiZJZLks27dipL3W1wdRk0BqJlOBroYEw8GHgVs3XpiibHcoh1+VvwE21RvYM2rK26zDn1I9WCSj31jTL0jKZoqVCrQgq4zc9MlGv1LwaFOMHMq2/6jo6ExDYL4PhPgq9Z6qGIjH8lpBt4tXbwo3nHiMJ72ZMin4bX881ffzuUCXBWzRqy3cRrNDRGy4P+eSEzrZ/19mnILW8nZvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vjGFSzLBinIzRkafNAuqR6OLeGgv1M5Zjw16eCgD9Zk=;
 b=vIXuj0t9Q/0Nef0W0i3Pvsc00wT3xmOr3hz8mrmL7x64DEWk5sZtChkY1Hdy/hJKmmBJNB5ohpU4NTkqpkE3+JC+U+xIahfQPMwtV+jkOjgJAQkJTe8R/rJmhCTGNjAXFfLrUoGKeH5wi561kgoyu51u3yCS2jnhFdNKkR2U4Xk=
Received: from MW4P223CA0030.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::35)
 by CY5PR12MB6201.namprd12.prod.outlook.com (2603:10b6:930:26::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.21; Tue, 10 May
 2022 20:46:04 +0000
Received: from CO1NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:80:cafe::6c) by MW4P223CA0030.outlook.office365.com
 (2603:10b6:303:80::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23 via Frontend
 Transport; Tue, 10 May 2022 20:46:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT006.mail.protection.outlook.com (10.13.174.246) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Tue, 10 May 2022 20:46:03 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 10 May
 2022 15:46:02 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 10 May
 2022 13:46:02 -0700
Received: from xiaoT.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.24 via Frontend
 Transport; Tue, 10 May 2022 15:46:00 -0500
From: David Zhang <dingchen.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 09/19] drm/amd/display: add vline time in micro sec to PSR
 context
Date: Tue, 10 May 2022 16:44:58 -0400
Message-ID: <20220510204508.506089-10-dingchen.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220510204508.506089-1-dingchen.zhang@amd.com>
References: <20220510204508.506089-1-dingchen.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 656f0029-2a05-4d4b-1ec9-08da32c61982
X-MS-TrafficTypeDiagnostic: CY5PR12MB6201:EE_
X-Microsoft-Antispam-PRVS: <CY5PR12MB6201F86CC18D90A0262D2E7D8DC99@CY5PR12MB6201.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3HdqYG+otjc9QjYTSgcni6uF/yA6VDwuqqD7YLesTt9aVM30gzLINQt7ws3L3/U4A5KgyY2ijCu0IFWKQU2e3OT65ipBOXFWmjZf/xeKmZwsYGoO8cvTuMhaOYwMvk36n6gzpimA8OVnQ4+24dK1WxF8ltaRuLdEeCQ6LXy9jnI7Xdg89ADSmjSEWBBk+Zjxa3pbcA26yprkcMmOaVVpfwn0tv9PRzFcBRbDIe0LMU2jH27Zs54/uLZE3VzDEpnwYl1GvHn3IYGdw+DQLDyLe70SqBjOqShSSFlvRIEhZlaxw5QrbXWlW6MG4aP+0uIpyUsAsuyJBKxBO6Z7VgNkz/sjvJ/HGC8A6Sp9JB7h0b7LGBI111TROOgPWYv31e8gL45MKIrwEuPehaXH9mtC/HQMVbQyIGSWiaHhQaC0tz1aEczuOKbBdngJ9U46lUY5x2xKMI0tjBwpt51qXJVfFhv+hqjFeanRitR2a5LHSFXhy6bmtg4VXGb9WynLRlhcQIgbNuBieJ2a8MIkO8Fo7l+mHxAQWrz+MldQ3lmJZpK0xAyzNu6kSJ7I4wesWOyfdfDCXwzp3yNTnJMiTY8Dy11BgpGAwox9rRvrTn/UFqGj4EiKhDWj0neTinYbMfSdWQPiN6E760Xx20WyfeBmm/ZKyXnuVISUVRL5gZHh5qa1mlIAfkFNU5Ae9xd+C2gtOFve8/0YPVQrpSykINxuiA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(2906002)(36756003)(40460700003)(356005)(36860700001)(5660300002)(8936002)(1076003)(4326008)(83380400001)(70206006)(186003)(508600001)(47076005)(426003)(336012)(8676002)(2616005)(70586007)(81166007)(82310400005)(54906003)(316002)(7696005)(6916009)(26005)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2022 20:46:03.7343 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 656f0029-2a05-4d4b-1ec9-08da32c61982
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6201
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
Cc: stylon.wang@amd.com, David Zhang <dingchen.zhang@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 jerry.zuo@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[why]
The current PSR SU programming margin is fixed base on FHD 60HZ
panel. If the resolution and refresh rate become higher, the time
of current margin might not cover the programming SU time.

[how]
Notice that the programming SU time is the same among different
panels.

Instead of fixing the margin with target line number, change the
margin unit to micro second which indicate the time needed for
programming SU. Then FW set the margin line number base on the
line time and margin time.

Signed-off-by: David Zhang <dingchen.zhang@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 2 ++
 drivers/gpu/drm/amd/display/dc/dc_types.h     | 2 ++
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c | 1 +
 3 files changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index d972dea21b2d..1ae48fa65e64 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -3243,6 +3243,8 @@ bool dc_link_setup_psr(struct dc_link *link,
 			psr_config->su_granularity_required;
 		psr_context->su_y_granularity =
 			psr_config->su_y_granularity;
+		psr_context->line_time_in_us =
+			psr_config->line_time_in_us;
 	}
 
 	psr_context->channel = link->ddc->ddc_pin->hw_info.ddc_channel;
diff --git a/drivers/gpu/drm/amd/display/dc/dc_types.h b/drivers/gpu/drm/amd/display/dc/dc_types.h
index d61ea3e2bfbf..119ce8b7a555 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_types.h
@@ -676,6 +676,7 @@ struct psr_config {
 	bool su_granularity_required;
 	/* psr2 selective update y granularity capability */
 	uint8_t su_y_granularity;
+	unsigned int line_time_in_us;
 };
 
 union dmcu_psr_level {
@@ -783,6 +784,7 @@ struct psr_context {
 	bool su_granularity_required;
 	/* psr2 selective update y granularity capability */
 	uint8_t su_y_granularity;
+	unsigned int line_time_in_us;
 };
 
 struct colorspace_transform {
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
index bc4943205bce..c2d65756ce5d 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
@@ -340,6 +340,7 @@ static bool dmub_psr_copy_settings(struct dmub_psr *dmub,
 		copy_settings_data->su_y_granularity = psr_context->su_y_granularity;
 
 	copy_settings_data->line_capture_indication = 0;
+	copy_settings_data->line_time_in_us = psr_context->line_time_in_us;
 	copy_settings_data->fec_enable_status = (link->fec_state == dc_link_fec_enabled);
 	copy_settings_data->fec_enable_delay_in100us = link->dc->debug.fec_enable_delay_in100us;
 	copy_settings_data->cmd_version =  DMUB_CMD_PSR_CONTROL_VERSION_1;
-- 
2.25.1

