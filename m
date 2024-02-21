Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE315C48BC3
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Feb 2024 06:39:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1BD4910E62B;
	Wed, 21 Feb 2024 06:39:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="o9d++MWQ";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2075.outbound.protection.outlook.com [40.107.101.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B0BA910E62B
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Feb 2024 06:39:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=khNhmzCG/XDhE4tV3e6DHm0QmD71ekeFNqKZJxtSNoxh/FXVsdrFLlLLnN88/1xlqlZebGgpFAVcFlYQu2Mnd5jKC8f+8+T9QAKx8jKWSByKhFCPpHKWOZRw90ZU60JLNxit4QWJ0U1L4upXwFIUgkwtIKfWGfH8jxQELVcCTE/QvrIJf1DbHisWTEG/XbpWMS+7XwXKQruaomKuHiiER55dKTe4PIfbRXwq11xA8Uai+TQ7K5dC+83Q5LwkpvM1I4GzgGBLVO22cnuM2EgdXKfG7PxZRsUj/GDVf2eUyuuDaIwrYxr9lyLYVEZuZHAGG99uhDikuaKS/fBt0gcg/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R4WnEOyOt5j+0Scj/EH5qLatg3GETGq8AJ7fX0eQJfc=;
 b=gKgCLXH86hew4JxoBnlLmbpfonf6eS5DaTiYo8P9+55Yx9ea5anIrIsAqPmnygN7/3xi6v2MxD8bHr2KwmG3jwMH9F2vlOcJVJYL/x7l1d50tq7+SwENkW73B1Lj84d6pikdICUCLbnjpWAf3vQz2M8yz7t80XNDvvtQNArKJHZgPmc0CNmkgZ/QivYZln8PCkDr90KBDdR/PHcx4eDtu5YcxV93eQ7+8XZPcuZAa2J1W//vL6sRaQU2QSNZssvpVCuZtTiJ/Ph29scvXFYsRKYrbQYR3uCZpcMjbggOcyPGZ/E5r3Spe3PE8myeoDGowGdVvGrdAseaUPdES+D9rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R4WnEOyOt5j+0Scj/EH5qLatg3GETGq8AJ7fX0eQJfc=;
 b=o9d++MWQRV2zOJJYKQZFdS1VE/b3EaKVQvzQPQu9ONsBwK8fgjwJ32TJA1K13k9hNQ1xF48k07KrHoJ+lpyADb5wE5siVqXFvF7b4qFj3TLr3jTL0GxmfpIHXyHTPQrih7rVwR8L7wfKroCGyQnf0hPwgFT1+xooO9wxIWNKYSQ=
Received: from SA0PR11CA0068.namprd11.prod.outlook.com (2603:10b6:806:d2::13)
 by BY5PR12MB4049.namprd12.prod.outlook.com (2603:10b6:a03:201::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.20; Wed, 21 Feb
 2024 06:39:05 +0000
Received: from SN1PEPF0002BA50.namprd03.prod.outlook.com
 (2603:10b6:806:d2:cafe::97) by SA0PR11CA0068.outlook.office365.com
 (2603:10b6:806:d2::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.40 via Frontend
 Transport; Wed, 21 Feb 2024 06:39:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA50.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Wed, 21 Feb 2024 06:39:05 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 21 Feb 2024 00:39:02 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Roman Li
 <roman.li@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Qingqing Zhuo <Qingqing.Zhuo@amd.com>
Subject: [PATCH] drm/amd/display: Prevent potential buffer overflow in
 map_hw_resources
Date: Wed, 21 Feb 2024 12:08:50 +0530
Message-ID: <20240221063850.293956-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA50:EE_|BY5PR12MB4049:EE_
X-MS-Office365-Filtering-Correlation-Id: ac58c4fc-cec2-4557-adf2-08dc32a7cc9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uI1MaeUNHde4ZvR8zFdEch28cnutyR3fRHyhbHktoUGOUvR3wJwPRwdwW1ajdjs8wwuuOLF+n347oX+mvDfKKJfNqjcUXHEIYNel2xmcToNAI6iNq+KG0JzJbT9maZJVBYwJLHQCPklGgcrVjTvp58eKBUhJStrc11Hk8+7CBXE0/O8XML483w9Y+d7uF5qjUXo8Dp8Z4HSw45ShJ/SfFIxUWvQpT7QGT9G30xKcSMH78qERp9EpdWj2bgI9irBqGQYCr7Kp/6Nkr8q7Q67sLqcjLS6RxlxNyz6758H97IazkN9eEMGJ4qZE+qmOxSuUXP6romPaCFe2jGbRLqrQsvq+2dQozE1F+HV0TyngVpk1AJghl9CX4xkIAVq2+8SIgXggy9PiRV9Gobxwb07zD+P7J+P0CF9ZW1G9i0jBDR/HDgtSXuTY4OjKDYoda/n3Yb57sp/9dI2xCNAuf5mMbMXm6rOly48D+lut6FWOth6gBselhuzxGUwTZZqVXR7LTueSNLqYbSxPMZ28laMa1jLwJXcGU1r9+2kieEurctYjHLcETgHO6Lef6NcUTIP8OQdDOR3BRExOunVj8X327aAiGhOmNVhwU946XpRS27o3Amu3qyTYBU6OemSONFaAwEn/Ydlmf5C781s9siNkk8OKrXBt3fcFz4zRxkJw+EE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(40470700004)(46966006); DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2024 06:39:05.3021 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac58c4fc-cec2-4557-adf2-08dc32a7cc9e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA50.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4049
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

Adds a check in the map_hw_resources function to prevent a
potential buffer overflow. The function was accessing arrays using an
index that could potentially be greater than the size of the arrays,
leading to a buffer overflow.

Adds a check to ensure that the index is within the bounds of
the arrays. If the index is out of bounds, an error message is printed
and the function returns early to prevent the buffer overflow.

Reported by smatch:
drivers/gpu/drm/amd/amdgpu/../display/dc/dml2/dml2_wrapper.c:79 map_hw_resources() error: buffer overflow 'dml2->v20.scratch.dml_to_dc_pipe_mapping.disp_cfg_to_stream_id' 6 <= 7
drivers/gpu/drm/amd/amdgpu/../display/dc/dml2/dml2_wrapper.c:81 map_hw_resources() error: buffer overflow 'dml2->v20.scratch.dml_to_dc_pipe_mapping.disp_cfg_to_plane_id' 6 <= 7

Fixes: 482ce89eec1b ("drm/amd/display: Introduce DML2")
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Roman Li <roman.li@amd.com>
Cc: Qingqing Zhuo <Qingqing.Zhuo@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c b/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c
index 26307e599614..0531d54b3d68 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c
@@ -76,6 +76,12 @@ static void map_hw_resources(struct dml2_context *dml2,
 			in_out_display_cfg->hw.DLGRefClkFreqMHz = 50;
 		}
 		for (j = 0; j < mode_support_info->DPPPerSurface[i]; j++) {
+			if (i >= __DML2_WRAPPER_MAX_STREAMS_PLANES__) {
+				dml_print("DML::%s: Index out of bounds: i=%d,
+					  __DML2_WRAPPER_MAX_STREAMS_PLANES__=%d\n",
+					  __func__, i, __DML2_WRAPPER_MAX_STREAMS_PLANES__);
+				return;
+			}
 			dml2->v20.scratch.dml_to_dc_pipe_mapping.dml_pipe_idx_to_stream_id[num_pipes] = dml2->v20.scratch.dml_to_dc_pipe_mapping.disp_cfg_to_stream_id[i];
 			dml2->v20.scratch.dml_to_dc_pipe_mapping.dml_pipe_idx_to_stream_id_valid[num_pipes] = true;
 			dml2->v20.scratch.dml_to_dc_pipe_mapping.dml_pipe_idx_to_plane_id[num_pipes] = dml2->v20.scratch.dml_to_dc_pipe_mapping.disp_cfg_to_plane_id[i];
-- 
2.34.1

