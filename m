Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABBFAC7EE25
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Jun 2023 12:16:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A3D9E10E4C8;
	Wed,  7 Jun 2023 12:16:16 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20610.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::610])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A52F910E4C8
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Jun 2023 12:16:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pg25yBzEIXbo3Yhgo4E/P7VWlnaNE/2ofR1dgkX3/tvDQ80khVZ58jOrYiWrYmZ5ieTjbdkr53Z4ToA46rQFbwgj0CCZOA7Xvs7LctJ7of9eZdHoRxAjk90yzxDqWse9l6OU2Df3xq2o19S/JQLoajoz4wxdzRiAiEBjRZelyG/czSUYN7ITrQNOFUKqx+S76nhEJ191dZqx0SbTQ6AIAzjqhpVWTJBrGFZCVzdd6csyfYtOsVEAuCwaxwJ5bDXMl+uRUYI9ZvHcHjtHe0e9T2BTqzE0WxzI252+YgtDFs7HSn/RiPExg8j2SYxv3pFCGqkuPutXSD/oHs1jAIJ0KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BssD2TTdOPUFMXU/V9r10UG3L2QZz5tQJewTeIrOmfA=;
 b=JfQMvzy8tMFK2O+TTleCJVfGFW9hk99EW4x9DSSc76btkZfmBwmOQMJr+R3lAbiSg3e2Hp6E+wq+pTQAqz9atbMYr3oOapluJ1bk5awao2uoxpSPWmTdNFWbkKfkNSffY/T8XYplhfaOMJRP/aeDTnFKa8QDSehbhaFQMB2RcZlXfOL+/+hY3zmB9WWXVRVLDel78Osqv52ribbpyep4dhpmPVHRWAJHsVdcpdS/Sj8BNlKthNaamf/Q2i4EPjTj9USYV7FlAQumvAMm9wd/JDJwNm/9IGivtO7IY4WlNbkqQCDEq8NCnopmPH6cRTxLlw10mavNJL3FkITpsphV5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BssD2TTdOPUFMXU/V9r10UG3L2QZz5tQJewTeIrOmfA=;
 b=nIcIM9NtgE1X07cgnu2rmgffr4JfSMNk0JBtuW5V8WEP+dYWhn6drgvgr41WgTUUTotp/LQApEeP374ys9pL5e4aKPT4fBAlClHwWol9RImt0aKitoJaaVa3ffFjNLTuxgAoF1K3nRYfxQ1UvPC+rFK0M98NIdNQ5pm518XDwkM=
Received: from CY8PR02CA0014.namprd02.prod.outlook.com (2603:10b6:930:4d::28)
 by DS0PR12MB6632.namprd12.prod.outlook.com (2603:10b6:8:d0::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.33; Wed, 7 Jun 2023 12:16:11 +0000
Received: from CY4PEPF0000EE30.namprd05.prod.outlook.com
 (2603:10b6:930:4d:cafe::31) by CY8PR02CA0014.outlook.office365.com
 (2603:10b6:930:4d::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.36 via Frontend
 Transport; Wed, 7 Jun 2023 12:16:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE30.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6477.13 via Frontend Transport; Wed, 7 Jun 2023 12:16:11 +0000
Received: from stylon-rog.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 7 Jun
 2023 07:16:07 -0500
From: Stylon Wang <stylon.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 00/20] DC Patches June 9, 2023
Date: Wed, 7 Jun 2023 20:15:28 +0800
Message-ID: <20230607121548.1479290-1-stylon.wang@amd.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE30:EE_|DS0PR12MB6632:EE_
X-MS-Office365-Filtering-Correlation-Id: e9666a4a-38fd-4a88-f6f5-08db6750fb78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VI4JbcM2VD3ipOEkeKJSfq+Qp65zFz4Q9Itc9HC4EWP1t371QxhiZSj2B01HyCEgQK1GA2sskTX/fs4W3cpfAosIKefv656M/K2XxTUDeqF+5zEOm9ze2FdYHPwR67jdFbBV+az0eOmkALsHbM4W+jtrX+6Pn0RRWMz1vd4uf1JX+d6hRo4Oq4hPVouyW3djPKg2yXCBeVdlXBaqcqPYPP6lkuo7FKOpDQkaVmbcZKPBV7RQ5LxzQUp0JpMvqEPax4wLzNZ8mlm6/fUOeW+2f7u1zzotwhM+Mz/f6FMthEZcLvHBdyCiKCmM8vYccHjjnu3YwhGykf/6JJZIVVRpu/qVn9Yt7RMOWES5B0vMTyqdZ53aS8DUWZ6cGq4PUYxj0OfySaoUcJs7McHBh8WVQUC+aIxY1zo3fXP1RjW2RfMtkb813kb+GlK58yZ2OzS5RXLLH0yPsnfNZs6jW1sXvlgRJ3/tk6RScoDmFD6rD1Bl3W1jqqsCZUxqQD/Q+kxBrUaUhbl3OgpXnHRb7IuGSE+f61evKjT1Zt3Y3P38mS4r6vf6kypLqVbq0HRIg7MCuY3CWakIQGWROHwwoOi/5CgkE1e9sTSFnWSJtc4+afiFc7Tt8cmKwbMSsm76NkNkY5w5sQEpMMV4dPX6gNvtMrzJkJcXXun3UkJMV4PpqMba3T2H9juAIeSGDqZm3/GLMX7CQEzqtch+hpvkQFUTlUhM1wkDAUYmj/3PlIFjcoOQdCGYFOAmOkCO/v4olXusA20Oc1h4OqKYcQlfkUqU2g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(376002)(346002)(136003)(396003)(451199021)(36840700001)(40470700004)(46966006)(36756003)(40480700001)(26005)(82310400005)(16526019)(41300700001)(1076003)(186003)(5660300002)(83380400001)(426003)(336012)(2616005)(8676002)(8936002)(54906003)(478600001)(70586007)(70206006)(4326008)(316002)(6666004)(7696005)(81166007)(356005)(82740400003)(2906002)(86362001)(6916009)(44832011)(36860700001)(47076005)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 12:16:11.6173 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e9666a4a-38fd-4a88-f6f5-08db6750fb78
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE30.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6632
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Daniel Wheeler <daniel.wheeler@amd.com>,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This DC patchset brings improvements in multiple areas. In summary, we highlight:

- Improvement on eDP
- PSR bug fixes
- SubVP bug fixes
- Improvements on pipe handling to address potential issues
- Freesync bug fix
- DPIA bug fix
- Fix multi-display issues

Cc: Daniel Wheeler <daniel.wheeler@amd.com>

Alvin Lee (4):
  drm/amd/display: SubVP high refresh only if all displays >= 120hz
  drm/amd/display: Re-enable SubVP high refresh
  drm/amd/display: Block SubVP + DRR if the DRR is PSR capable
  drm/amd/display: Include CSC updates in new fast update path

Aric Cyr (2):
  drm/amd/display: Promote DAL to 3.2.238
  drm/amd/display: 3.2.239

Artem Grishin (1):
  drm/amd/display: Bug fix in dcn315_populate_dml_pipes_from_context

Austin Zheng (2):
  drm/amd/display: Add DP2 Metrics
  drm/amd/display: Limit Minimum FreeSync Refresh Rate

Daniel Miess (2):
  drm/amd/display: Re-enable DPP/HUBP Power Gating
  Revert "drm/amd/display: Move DCN314 DOMAIN power control to DMCUB"

Dmytro Laktyushkin (1):
  drm/amd/display: fix pixel rate update sequence

Fangzhi Zuo (1):
  drm/amd/display: Add Error Code for Dml Validation Failure

Hersen Wu (2):
  drm/amd/display: edp do not add non-edid timings
  drm/amd/display: add debugfs for allow_edp_hotplug_detection

Peichen Huang (1):
  drm/amd/display: limit DPIA link rate to HBR3

Saaem Rizvi (1):
  drm/amd/display: Do not disable phantom pipes in driver

Samson Tam (1):
  Revert "drm/amd/display: reallocate DET for dual displays with high
    pixel rate ratio"

Tom Chung (2):
  drm/amd/display: fix the system hang while disable PSR
  drm/amd/display: Fix disbling PSR slow response issue

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  18 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c |  32 ++++
 .../drm/amd/display/dc/core/dc_hw_sequencer.c |  70 +++++++
 drivers/gpu/drm/amd/display/dc/dc.h           |   9 +-
 drivers/gpu/drm/amd/display/dc/dc_dp_types.h  |   2 +-
 drivers/gpu/drm/amd/display/dc/dc_types.h     |   1 +
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c |   2 +
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    |  11 --
 .../drm/amd/display/dc/dcn30/dcn30_resource.c |   1 +
 .../amd/display/dc/dcn302/dcn302_resource.c   |   1 +
 .../amd/display/dc/dcn303/dcn303_resource.c   |   1 +
 .../drm/amd/display/dc/dcn314/dcn314_hwseq.c  |  30 +--
 .../drm/amd/display/dc/dcn314/dcn314_hwseq.h  |   4 +-
 .../drm/amd/display/dc/dcn314/dcn314_init.c   |   2 +-
 .../amd/display/dc/dcn314/dcn314_resource.c   |  11 +-
 .../amd/display/dc/dcn315/dcn315_resource.c   |   1 +
 .../drm/amd/display/dc/dcn32/dcn32_hwseq.c    |  11 +-
 .../drm/amd/display/dc/dcn32/dcn32_hwseq.h    |   2 +-
 .../drm/amd/display/dc/dcn32/dcn32_resource.c |   3 +-
 .../drm/amd/display/dc/dcn32/dcn32_resource.h |   4 +
 .../display/dc/dcn32/dcn32_resource_helpers.c | 158 +++++++++++-----
 .../amd/display/dc/dcn321/dcn321_resource.c   |   3 +-
 .../dc/dml/dcn314/display_mode_vba_314.c      |  59 ++++++
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  | 178 +++++++++++-------
 .../amd/display/dc/dml/display_mode_enums.h   |   8 +
 .../gpu/drm/amd/display/dc/inc/hw_sequencer.h |  32 ++++
 .../amd/display/dc/inc/hw_sequencer_private.h |   2 +-
 .../drm/amd/display/dc/link/link_detection.c  |   5 +
 .../amd/display/modules/freesync/freesync.c   |  11 +-
 29 files changed, 493 insertions(+), 179 deletions(-)

-- 
2.40.1

