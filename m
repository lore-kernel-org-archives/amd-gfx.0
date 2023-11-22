Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4F72C61D92
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Nov 2023 06:59:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5393510E111;
	Wed, 22 Nov 2023 06:59:14 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20612.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::612])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E432F10E111
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Nov 2023 06:59:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YGcJLYSSKO51FhwVnCUPsgp+w83QVZ3OA7ESVqZiDemTnre0R76jMxpyx05DSyldVefRso1Adq+8HVKEknTT8DSeQuh4gN35MAbjCwTSMWlzqZD6qLNLPy1b5CdDdD2sn7QD0XErUz1f6GvcWiTH8ZhvPuLaxCTb06lnY1ec/fKoG4lgLwKP1+VzT5Hrm2oK2azLzdEomx9j8illR9avQy302cNtSaMFMiWZIG3ns80ljQyXnBE/Xovrjeyq7ksC2GYLMUKdwShDgihOz0+HunsunAYu/NGE6f+d6VvAj3xOI3Y+2I82gdTVF8EK/shr4/JBS+j1qSHVvte5miSdSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qoItIkKj7JJedWsQasVrxhNPm0Q0kAZt6v0cNeNZuDw=;
 b=ZGsh48Fi306g9f5/Vn2Q2RbzEGJRqpL7q1ytwu3jrSefA/DbKxSGUQhlOw8r0whF+R4MN74ASS0Eyudf2kbYAblPALQ5jtkMmjnUZrQvI7pmPKtWj/BVRdxgMb7SgzuAhu49ePZDAKqTJWDGk93lQL18nXugdhEtOum12cAZ1h/DlBy1P5ozKDyL01FZ5liS/WhLv8khpgPdw7gKKQMoSx9kCQbtxhdgDFxvdkBRTI0N5R5/OWL3nOZbrBoLW8yn7/Ax8pOOIDLR5TpdOXllF73corn0EPvn1NQDgU/vOfNoOd7alh0HH9qFwBhOnpnJA+eQOO5u3I7PLrKhL04iLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qoItIkKj7JJedWsQasVrxhNPm0Q0kAZt6v0cNeNZuDw=;
 b=HRAamaWsQDPItGPSLsFCkQLJ2r7+f/OgHFiKMTnw2rVse2KIfupFRRaOlEuP+wOu6J7jZqM87FvUxcDztV95nJFO1vjhF132tYJqsRVC5PbS5o4jtQHppnAkYdctyA9PHF4BUV/Geyhkd47Gsk28fmbj+NzFqxnMVC1hpTUJbnU=
Received: from CY5PR18CA0036.namprd18.prod.outlook.com (2603:10b6:930:13::21)
 by DS0PR12MB9323.namprd12.prod.outlook.com (2603:10b6:8:1b3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.19; Wed, 22 Nov
 2023 06:59:07 +0000
Received: from CY4PEPF0000FCC4.namprd03.prod.outlook.com
 (2603:10b6:930:13:cafe::e4) by CY5PR18CA0036.outlook.office365.com
 (2603:10b6:930:13::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.28 via Frontend
 Transport; Wed, 22 Nov 2023 06:59:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000FCC4.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7025.12 via Frontend Transport; Wed, 22 Nov 2023 06:59:06 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 22 Nov
 2023 00:59:06 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Tue, 21 Nov
 2023 22:59:05 -0800
Received: from tom-HP.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Wed, 22 Nov 2023 00:58:59 -0600
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 0/7] DC Patches Nov 20 2023 
Date: Wed, 22 Nov 2023 14:58:34 +0800
Message-ID: <20231122065841.2267110-1-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC4:EE_|DS0PR12MB9323:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c1e8f5a-96d5-4dfc-e334-08dbeb288532
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AOjPeeiLM/98dqY9U2ZUGKUIARPSrSs8yhX7ng50nF0WhncTh7ajF9lymrbw2BSN2PYhfhJNg9gugMtSeflEJnorVe3o5ob/fhZM8aLc8E/YyTdJnxaX2Lf6/M7tmtHt0OymFTzBl246Ay3Up4Ayj3Z2ZbZvcwmCE/TZTYOSeeDwdyt0I1F2Cd09OEQaD1JSF7JoOqtYj24jsLJ0mgdDA4bkylj+Z5UYFRbmr/8I4iMam4JATCB9Sl91OvzKmBcDan45Ql2P0Egf1t057mV8lG5uNR+hanLT2NJwysAV93APey4aQFsXA4UenC/F+yuOLNEFD67Jq9LWo2p0DSobfLlNzKn1rU1yFFezy3QTxZgyVsQOGwqKbyQDXL6Bmpum5c4VkSPLwPXueTv7DhEFRoxKaZR745UFd8FEa5ytkjw+pfzwTMHsYBse/8S+B3K1YoAVjU5kS5rLbFGtS02XS1XrNk1soZaBn2baMzN8tsSrUHIGMNZqtvRMsnuyKXjx5JzXftIcLe/f5GQ51hzIhdbMAsCtv5LhA2c3vkD7lTNcKBhPx1LhlJd/6W+T7Grpl8y8cZRNKb0gymIDdBATHBcYqqaQGKFCqMqEXv+TYn9Z9d8Z3BNv/VNryApmE/6pX8GdzgoSUxuP4Miq3z6qoxZiG4sQ3M/kTUStfiFF9rUSl4q2iARfbAp8SwWgetf2cMwlI07TpGmx8uXFEgDENm9XtstHrKU7e8WEvNDi/ATOsFwgg+76YjTvBjhQZIfjWEPEfUKjgfKUWqofBRaxuA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(39860400002)(396003)(136003)(376002)(230922051799003)(1800799012)(82310400011)(186009)(64100799003)(451199024)(36840700001)(46966006)(40470700004)(41300700001)(2906002)(5660300002)(8676002)(6916009)(54906003)(316002)(4326008)(8936002)(70586007)(70206006)(478600001)(7696005)(6666004)(40480700001)(426003)(4743002)(36860700001)(336012)(26005)(1076003)(2616005)(40460700003)(83380400001)(47076005)(81166007)(356005)(36756003)(86362001)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 06:59:06.8043 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c1e8f5a-96d5-4dfc-e334-08dbeb288532
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9323
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
Cc: stylon.wang@amd.com, chiahsuan.chung@amd.com, Sunpeng.Li@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Daniel Wheeler <daniel.wheeler@amd.com>, jerry.zuo@amd.com,
 Aurabindo.Pillai@amd.com, hersenxs.wu@amd.com, wayne.lin@amd.com,
 Harry.Wentland@amd.com, agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This DC patchset brings improvements in multiple areas. In summary, we have:

- Add DSC granular throughput adjustment
- Allow DTBCLK disable for DCN35
- Update Fixed VS/PE Retimer Sequence
- Block dcn315 dynamic crb allocation when unintended
- Update dcn315 lpddr pstate latency

Cc: Daniel Wheeler <daniel.wheeler@amd.com>

Anthony Koo (1):
  drm/amd/display: [FW Promotion] Release 0.0.194.0

Aric Cyr (1):
  drm/amd/display: Promote DAL to 3.2.262

Dmytro Laktyushkin (2):
  drm/amd/display: update dcn315 lpddr pstate latency
  drm/amd/display: block dcn315 dynamic crb allocation when unintended

Ilya Bakoulin (1):
  drm/amd/display: Add DSC granular throughput adjustment

Michael Strauss (1):
  drm/amd/display: Update Fixed VS/PE Retimer Sequence

Nicholas Kazlauskas (1):
  drm/amd/display: Allow DTBCLK disable for DCN35

 .../dc/clk_mgr/dcn315/dcn315_clk_mgr.c        |  8 +++---
 .../display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c  | 27 +++++++++----------
 drivers/gpu/drm/amd/display/dc/dc.h           |  2 +-
 drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c   | 10 +++++--
 .../link_dp_training_fixed_vs_pe_retimer.c    | 10 +++++++
 .../dc/resource/dcn315/dcn315_resource.c      |  6 +++--
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |  4 +++
 7 files changed, 43 insertions(+), 24 deletions(-)

-- 
2.25.1

