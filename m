Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65458C48BEB
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Feb 2024 18:40:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 698D010E182;
	Wed, 14 Feb 2024 18:40:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Lslw9YbF";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2086.outbound.protection.outlook.com [40.107.100.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA4CA10E12B
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Feb 2024 18:40:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bG/U+PPuh3Ruj8lXIenYg+i9l1IRuofNR4sFtFNrEK8M/gtXcIpxRMnVdb4UWsA0uzf9zXtapUjD6q/aqvQcBbT6pU6cf8WJCkZKxdlcbQ8X7iOsyZOqN6uovOW2RFpgFEKVxVy4pdOFxW/xLdVAcVS8OofNUKXgUH6p30OHAKLeK+nFLePAdmlGqAu2WxqKn9qCdrdpGhgewk/06BIzbzYlX+ct8gK0JU2JngPocbBv1dR+J9UsIB2qkeh0cTn1va/s6SVVlwy70IxzbPM04BWhqqvjfIoKM7oKm2Oew09VfEaH6UABD3rd3JUw/GmHzdS9VNbRfqfuSQE4qAWakg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OptyC4CcZ2NCqZEF4d9+dq0EUl9Dd1jmPoVwUBnlht4=;
 b=LRzJTg3ZI/ky84pq94qHV7QAeiadQz6x75y27pJ0++qoUi5cDBQniaoN+5G7vPLuepc3EL/SysHlFhuqV18lzCMJJXIZVTzzSNUijfdhaJIbqPgEbB5QBrhC2wBqXIowNOeezu+D93mH7JL3Om1UqjCAn0bgVnQDxhXpDWkIveiHdjypHEind+1LBWlmwKRP4f/8eTZ2b1jXtbqLQ/hKnB5HMJPYXjGDxaRQiv9CznMI0bFbZKfRZqpxkAnEhZxvbQA7/zdUBsNz5K7TOJtfJEayZ9wYcPPv7COAG9KrRMBDtNb6Cajp+kg1zb7ASYE+RGwFwOzUodriZsNex2aUfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OptyC4CcZ2NCqZEF4d9+dq0EUl9Dd1jmPoVwUBnlht4=;
 b=Lslw9YbFKCbkor5NVXmuWo680995tQoVkQj+Web+ME0nfzxNKeDYuiGeNuXc2nLFFHGe6NH9qdf/NR29sM4X8sI7R2//h1cpeILoLZPwayA4rlenENQb6swTluFTUKLTqvnSYSjEtLGfKMqkv9AyQ929KoaBxflWQrQWhYY1HNE=
Received: from BYAPR03CA0002.namprd03.prod.outlook.com (2603:10b6:a02:a8::15)
 by BY5PR12MB4212.namprd12.prod.outlook.com (2603:10b6:a03:202::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.26; Wed, 14 Feb
 2024 18:40:31 +0000
Received: from DS2PEPF0000343F.namprd02.prod.outlook.com
 (2603:10b6:a02:a8:cafe::7) by BYAPR03CA0002.outlook.office365.com
 (2603:10b6:a02:a8::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.26 via Frontend
 Transport; Wed, 14 Feb 2024 18:40:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343F.mail.protection.outlook.com (10.167.18.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Wed, 14 Feb 2024 18:40:30 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 14 Feb
 2024 12:40:29 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Daniel Wheeler
 <daniel.wheeler@amd.com>
Subject: [PATCH 00/17] DC Patches February 14, 2024
Date: Wed, 14 Feb 2024 11:38:31 -0700
Message-ID: <20240214184006.1356137-1-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343F:EE_|BY5PR12MB4212:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d7f7aa4-e92f-4bb2-2aef-08dc2d8c6bed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KvS59C2tjsfeSIgwci/DDZHufSRYWmRN4Cr6SkWVFBMaJ4a0DJi/CC0WR28AHMhmm3+HzPthXOZ1AqtauWRdhJNnhZfTlkR59AjgIf0YIwni29shfKDKb4xP7EabuT95J3m4imHIizmLWEVCw3xonstUkqrWxJPNULI6ehfa2KdBLMJAYL0ZjaI7Y04UgVNytATE3Kq7wwmu2n+gkME6ThYfEEzpi/Yi4n7gNSXrYFHNiBbWE6Tb1FEliCF4evG476vlEpjOE0N9EPPl5QDLOCOkfQPDron/XBzvQyDuo9L+DUo7uY6x3PMtZ/SKbhDmKl4sFPJPtgHKSQIy88pW88p4JatLGQxcyl2+cit+cd8QGCt74RfQrszJtekHG5vpHvt13yeWlFB/TimQPQr/e8ClwqK4gAxdK7dJ3mHGa0qV/iMiMDoNsiLUxxTugB9n5RI+G/aAnwkIi7fwIipE8CmMvJoH86Y6Z/dmAhCGqsa4zDBZIh8dmSPJMvLUCMp4mBmhnDH6WhlXDFe0EMkBTRHoVwIMDNHlzjxOU8Jcy9hRfbp7SZkTn3h0ifu92yQky0rOmDBm1DqWCDjaFySJiobZaxW7uJVF3FV0XVkvQxM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(396003)(346002)(376002)(39860400002)(230922051799003)(82310400011)(451199024)(186009)(1800799012)(64100799003)(46966006)(40470700004)(36840700001)(41300700001)(6666004)(478600001)(8676002)(8936002)(2906002)(4326008)(5660300002)(70586007)(6916009)(54906003)(316002)(70206006)(2616005)(83380400001)(336012)(86362001)(426003)(356005)(81166007)(1076003)(16526019)(82740400003)(36756003)(26005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 18:40:30.8363 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d7f7aa4-e92f-4bb2-2aef-08dc2d8c6bed
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4212
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

This DC patchset brings improvements in multiple areas. In summary, we
highlight:

- Re-enable windowed MPO support for DCN32/321.
- Improvements in the subvp feature.
- Code clean-up.
- USB4 fixes.
 
Cc: Daniel Wheeler <daniel.wheeler@amd.com>

Thanks
Siqueira

Alvin Lee (2):
  drm/amd/display: Generalize new minimal transition path
  drm/amd/display: Remove pixle rate limit for subvp

Aric Cyr (2):
  drm/amd/display: Fix nanosec stat overflow
  drm/amd/display: 3.2.273

Ethan Bitnun (1):
  drm/amd/display: Only log during optimize_bandwidth call

George Shen (1):
  drm/amd/display: Check DP Alt mode DPCS state via DMUB

Lewis Huang (1):
  drm/amd/display: Only allow dig mapping to pwrseq in new asic

Nicholas Kazlauskas (1):
  drm/amd/display: Fix S4 hang polling on HW power up done for VBIOS
    DMCUB

Rodrigo Siqueira (6):
  drm/amd/display: Remove break after return
  drm/amd/display: Initialize variable with default value
  drm/amd/display: Remove unused file
  drm/amd/display: Add SMU timeout check and retry
  drm/amd/display: Remove redundant FPU guard
  drm/amd/display: Drop unnecessary header

Swapnil Patel (1):
  drm/amd/display: fix input states translation error for dcn35 & dcn351

Wayne Lin (1):
  drm/amd/display: adjust few initialization order in dm

Wenjing Liu (1):
  drm/amd/display: reenable windowed mpo odm support on dcn32 and dcn321

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  37 +++--
 .../gpu/drm/amd/display/dc/basics/dce_calcs.c |   2 -
 .../gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c  |   3 -
 .../display/dc/clk_mgr/dce100/dce_clk_mgr.c   |   2 +-
 .../display/dc/clk_mgr/dcn10/rv1_clk_mgr.c    |   2 -
 .../dc/clk_mgr/dcn10/rv1_clk_mgr_clk.c        |  79 ----------
 .../dc/clk_mgr/dcn21/rn_clk_mgr_vbios_smu.c   |  11 +-
 .../display/dc/clk_mgr/dcn301/dcn301_smu.c    |   6 +-
 .../display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c  |   4 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 146 +++++++-----------
 drivers/gpu/drm/amd/display/dc/dc.h           |   2 +-
 .../drm/amd/display/dc/dce/dce_panel_cntl.c   |   1 +
 .../amd/display/dc/dcn301/dcn301_panel_cntl.c |   1 +
 .../amd/display/dc/dcn31/dcn31_panel_cntl.c   |  18 ++-
 .../display/dc/dcn32/dcn32_dio_link_encoder.c |  85 +++++++---
 .../display/dc/dcn32/dcn32_dio_link_encoder.h |   5 +
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  |   1 -
 .../display/dc/dml2/dml2_translation_helper.c |   9 +-
 .../gpu/drm/amd/display/dc/hdcp/hdcp_msg.c    |   2 -
 .../gpu/drm/amd/display/dc/inc/core_types.h   |  31 ++--
 .../drm/amd/display/dc/inc/hw/panel_cntl.h    |   2 +-
 .../display/dc/irq/dcn20/irq_service_dcn20.c  |   2 -
 .../display/dc/irq/dcn21/irq_service_dcn21.c  |   2 -
 .../drm/amd/display/dc/link/link_factory.c    |  26 +---
 .../dc/resource/dcn20/dcn20_resource.c        |   2 -
 .../dc/resource/dcn32/dcn32_resource.c        |   1 +
 .../dc/resource/dcn321/dcn321_resource.c      |   2 +-
 .../gpu/drm/amd/display/dmub/src/dmub_dcn35.c |   8 +-
 .../gpu/drm/amd/display/dmub/src/dmub_srv.c   |   9 +-
 .../drm/amd/display/modules/inc/mod_stats.h   |   4 +-
 30 files changed, 223 insertions(+), 282 deletions(-)
 delete mode 100644 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn10/rv1_clk_mgr_clk.c

-- 
2.43.0

