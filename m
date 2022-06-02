Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28FF4C43334
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Jun 2022 19:31:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9DC12112CF5;
	Thu,  2 Jun 2022 19:31:34 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2061.outbound.protection.outlook.com [40.107.244.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 09884112CF5
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Jun 2022 19:31:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oT8MqnD8LC4qaO8Q9OqXLR7Bak1X8mHkdq9ITnElcg/4tuFB/xh0wePbGVZghBNr4mxknWAIc2Mn0HG9CxhiL7y7FPuziQNlzgu9T6M1NrGHvt7BzPwlv9bq2k2qW7X8+psmF/5f+jnNH3WYhNnkZ5crxBbH17zkBZXz+R880Oml21ICA9lM04htmgELR1LZsADz1wYtLB7lDmkMx+amtv1eYRrxV6x1DlFEe2N8cv7A37mJPbX81JcQqTXZX5SHPqVrtaNKHYYSaEVnQ1wICo7++LuFfZZ5HUkdLAl4vj56P4Xw2kEKfzsgKB0fInIDSwfT4gNgTCEfl6N7917EPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WOlMCeYxQ2Xo1lN3bdoBAvwjTmaZErK/24nc5lwI1KE=;
 b=MW/cOYS1W6lej0+2q7xxw0nM9uVEH/87nOpGjIfC4H7fVoNMVQCxroqhcn8mNnayPf0JzuMx2LnV6eqAYTYPC16OuGUGAuksCQ7UtgedatJsgpXheJLOBPSv0V1SmLMmx0W1ZXovX4etwVXnbhsZCzwbhW5IwVpLdPjYsGLZbXHIJ+4F+pLc7go+E6Ft9OPfjLaMg+HhZnuT0Tm2ufSKCd8GZYKzVM5rAvTBIQg1QfZsyjTXPNT5hJYl87vsoQekt9GDqKwz95s1g/urElHHbqHXtXFtIXEAiL8k0gq3uq/MMr9IpmKr3/P/sXKKnK6rjXnW/NMHwqxLTTwc87v+wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WOlMCeYxQ2Xo1lN3bdoBAvwjTmaZErK/24nc5lwI1KE=;
 b=waqbie8n+Q1EfedXbFGUX5rbjq3BVrZ9lF5dnz0do0V4FTYy3TgVeYDp/lavmhdrlf3hV7HDE3rZhoHLHJsTm0weZ59FxARYjgbpYykqzrtSINLVHjS314v/iSW9wKv644X0J7f+d7bPSyjSbrh1w5IVe32/vzKQUYQPOJkYEdw=
Received: from DS7PR03CA0215.namprd03.prod.outlook.com (2603:10b6:5:3ba::10)
 by DM4PR12MB5389.namprd12.prod.outlook.com (2603:10b6:5:39e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12; Thu, 2 Jun
 2022 19:31:32 +0000
Received: from DM6NAM11FT040.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3ba:cafe::aa) by DS7PR03CA0215.outlook.office365.com
 (2603:10b6:5:3ba::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13 via Frontend
 Transport; Thu, 2 Jun 2022 19:31:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT040.mail.protection.outlook.com (10.13.173.133) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5314.12 via Frontend Transport; Thu, 2 Jun 2022 19:31:31 +0000
Received: from leodev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 2 Jun
 2022 14:31:31 -0500
From: <sunpeng.li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 0/4] PSR-SU-RC DC support and some PSR-SU fixes
Date: Thu, 2 Jun 2022 14:03:43 -0400
Message-ID: <20220602180347.754067-1-sunpeng.li@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1437300b-1b7e-4cfc-d2f1-08da44ce7f88
X-MS-TrafficTypeDiagnostic: DM4PR12MB5389:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB5389EC8B05B991E80D68C9A482DE9@DM4PR12MB5389.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wJhG09SP4ac+5bg1m21YEY+6+AkMNyg5E9kQ0f3R60zt8+QDK8bHmMHx6hxzNhaxmpNPey1zWzUhLSz1Jt+sRaUMbe8Hk0yl8j/pLaU+gyCB7w5anFLrisgffqECR/EnWPE+pWk8nz88vMyJupixOZDt7Fz5ZbuqzZaEM5h73q3pSxQDn5hAXCRZXz0YX1dClm4/lTutCQz5hcO5pKOBMmItJLsWwnh2psk3I6szPdoxI9TMXWXb15ALEAi6A2uggFlGkUdYhmTgWVBwbG8lX/+QOAdB27OrsIoJymfxbdr22FLfQIXYqrLo8Eh9zJLdLcHShTsEbSTX/yVgDHgGTG8d7zf/akIALDvo10pwLfiOoliqSKBrMWx2JQgHuA9asNTBieRkvC97bXqtH8Jt8eYSflD4nZ9/rZXkbHvttl5QskL2OBOSUkFlR3CGNQIy6tSbMfdI723ehVx2wsqrhC6gNo+dVngADhrHPu8R7cuTWdDUoOBxybUelIYdV1f53igjtWrdk0EZzx3/SiuwAMi39DggiR3pTUSG2T0jnVuEWjOuibiHIJWEfEeXePilp7LB8yt3FIWjECj4d/2KiWbBaQGlphwt6GqoORjldK+ynJbgPwWXucWVfhJ+Rnfs+kbNbHACaL0ihNWSm+N5C1bZO2IMHHBXIMAV58AuNXCADJoFOO7FUO9lTxfS1nAlVilD50TJuYRfAl/v0ktbBw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(336012)(16526019)(6666004)(7696005)(2616005)(186003)(1076003)(83380400001)(426003)(47076005)(356005)(81166007)(86362001)(40460700003)(26005)(316002)(36860700001)(2906002)(82310400005)(70586007)(70206006)(2876002)(4326008)(8676002)(6916009)(54906003)(508600001)(5660300002)(36756003)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2022 19:31:31.8877 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1437300b-1b7e-4cfc-d2f1-08da44ce7f88
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT040.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5389
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
Cc: alexander.deucher@amd.com, Leo Li <sunpeng.li@amd.com>,
 harry.wentland@amd.com, dingchen.zhang@amd.com, roman.li@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Leo Li <sunpeng.li@amd.com>

The first two patches here add PSR SU Rate Control support to DC. Support in
amdgpu_dm is still pending to enable this fully.

The last two patches are some fixes for PSR SU.

David Zhang (3):
  drm/amd/display: expose AMD specific DPCD for PSR-SU-RC support
  drm/amd/display: Add PSR-SU-RC support in DC
  drm/amd/display: pass panel instance in dirty rect message

Robin Chen (1):
  drm/amd/display: refactor dirty rect dmub command decision

 drivers/gpu/drm/amd/display/dc/core/dc.c      | 19 ++++++++++++++-
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 22 +++++++++++++++++
 drivers/gpu/drm/amd/display/dc/dc_link.h      |  3 +++
 drivers/gpu/drm/amd/display/dc/dc_types.h     |  2 ++
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c | 23 ++++++++++++++++++
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.h |  2 ++
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c | 24 ++++++++++++++-----
 .../drm/amd/display/dc/inc/hw/link_encoder.h  |  8 +++++++
 .../amd/display/include/ddc_service_types.h   |  4 ++++
 9 files changed, 100 insertions(+), 7 deletions(-)

-- 
2.36.1

