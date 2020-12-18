Return-Path: <SRS0=OQM/=FW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89C5FC4361B
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Dec 2020 22:29:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D8B823B5D
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Dec 2020 22:29:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D8B823B5D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A24A288E07;
	Fri, 18 Dec 2020 22:29:48 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2061.outbound.protection.outlook.com [40.107.94.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B199893A8
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Dec 2020 22:29:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MpZIU7sFawj/JaCoqH98ZLLPlaavMiIW3YkbyENG4JdUP9VXxKeYZw95XOsLGE/ChqW/ntydPCE4KpyDWZRtfRsWwAamhd/GKKN/91TD3IfsyIr7djItbKV+eAYGTIAbCpZtdsylkWqYKJBH4giyvvDpCuK/Sw9rDSUE9VJUfh5LlmD8sTnBuie8FZUCvOP3C8Ik1yTkF4BVDwPe3FH+NbvFGYOiLlhxn7QFwaiGYwFyQuH4YggSIFq6mMXpTvA7NqPvPSgjBEGD3hpvkDMLj5JEHUXVGmrPMUXoPZzkFHIor2I912yljLUrwBuLpaWTOvrpwXNrDurHw8zaak/b1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I0WOgidJ9hYd4uroH/zlR5uyPLhz2NH1iZjNHA0JuMs=;
 b=GUMGHJNMzZKqhx/kNgW9h5u87wEoUhlcct+xcvFeNRQ8Krt13I/QA23GtIs98OdHGZlKsr1MqyqQ+q+STs3n47ysUD+XKU5tm8WpzWEp8CSG65aRrz7FJPo+LEELi+XAK6RQaFhMBKyOw0Ma+G3w2bMYdTJs0VJh8NqiATuuUr2n9xdmG5/xtoztrdezMWNrQhq5SILbu/YcHAIH2wGDn5mej6gYMdU/Ge82ltyOIGzX8y/wpIFZHvNTjOBvMWwoxJfjoMAgoy6NstkeVLOFaIWPBAGK4S3ZAP3RPEPOqB7PJqR+a9Am3xEhIFCqsuVARF14JehiWfR03h2SxWDBGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I0WOgidJ9hYd4uroH/zlR5uyPLhz2NH1iZjNHA0JuMs=;
 b=RSViJ+CSivTRWI0B8BTQJdacIidiT5QOMbpK5SbvEmdAf2HkbRkYDvLfA8mZTMAMiRNyzXpehVTFFfKfdtMw1AwZQTQ0iZk3OrHIEJV10sk3sWyQ0VqqE0lBBk47ZVz18kyP/e87DXqKjeiHSkr+Ocllob1eGhuFrWXaZ/RAH78=
Received: from DM3PR11CA0021.namprd11.prod.outlook.com (2603:10b6:0:54::31) by
 MN2PR12MB2975.namprd12.prod.outlook.com (2603:10b6:208:ce::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3632.21; Fri, 18 Dec 2020 22:29:45 +0000
Received: from DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:54:cafe::69) by DM3PR11CA0021.outlook.office365.com
 (2603:10b6:0:54::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12 via Frontend
 Transport; Fri, 18 Dec 2020 22:29:45 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM6NAM11FT010.mail.protection.outlook.com (10.13.172.222) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3676.25 via Frontend Transport; Fri, 18 Dec 2020 22:29:44 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 18 Dec
 2020 16:29:43 -0600
Received: from bindu-HP-EliteDesk-705-G4-MT.amd.com (10.180.168.240) by
 SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Fri, 18 Dec 2020 16:29:42 -0600
From: Bindu Ramamurthy <bindu.r@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 00/14] DC Patches December 21, 2020
Date: Fri, 18 Dec 2020 17:28:50 -0500
Message-ID: <20201218222904.393785-1-bindu.r@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 724a078e-d96e-4599-9791-08d8a3a46b36
X-MS-TrafficTypeDiagnostic: MN2PR12MB2975:
X-Microsoft-Antispam-PRVS: <MN2PR12MB29758FFB8C53A20D2130B997F5C30@MN2PR12MB2975.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G1iDN6100D3mwOIZlwRwIJPyi2rzE4t+28hIDlK0TvlEfMAIr3CNPWqaZZARagpOYSNDolhGWz7T2y/Ryoi+6Up7Ht3cSRwgL8pIteVT6m5UOCAONlMm5EE8bYlnnSOaESEvCfJ7ZbLrDzXPMThLv653uSqurP4ygAtvBnzWS/8+MTvEmBhYV/i2bnvArOrrxajZBm7HqIZzZdK8u433Ua7K63/wPNa0h1/yTLxAJgotrZ2JOzykXdhm5SHV3m/32wD+K6o3xxefhHRUGWv2gRBRzC6DAAM397zcv7pt4VZJoF0mvZ84uPnRd4phIOfgrViQSpfwMjRwoVm7qGqxhIIpWzVz6NUGAtP5zCvTCYbtGMrg2cTJ9fG4TaOtOmCWn1CM/8wI+qaLNzk2DOmbGA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(396003)(346002)(39860400002)(136003)(376002)(46966005)(5660300002)(478600001)(83380400001)(8676002)(316002)(356005)(82310400003)(54906003)(70206006)(81166007)(426003)(70586007)(6666004)(47076004)(82740400003)(8936002)(2906002)(186003)(1076003)(86362001)(26005)(336012)(36756003)(7696005)(4326008)(6916009)(2616005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2020 22:29:44.0569 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 724a078e-d96e-4599-9791-08d8a3a46b36
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2975
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
Cc: Eryk.Brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com, Aurabindo.Pillai@amd.com,
 Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This DC patchset brings improvements in multiple areas.
In summary, we highlight:

* Ramp down ABM intensity. 
* Firmware version 0.0.47.
* Updation of wm table for Renoir.
* Extend smu response timeout,Interfaces for hubp blank and soft reset.

Aric Cyr (1):
  drm/amd/display: Multi-display underflow observed

Eryk Brol (1):
  drm/amd/display: Remove unnecessary NULL check

Jake Wang (2):
  drm/amd/display: updated wm table for Renoir
  drm/amd/display: always program DPPDTO unless not safe to lower

Josip Pavic (1):
  drm/amd/display: add getter routine to retrieve mpcc mux

Martin Tsai (2):
  drm/amd/display: Modify the hdcp device count check condition
  drm/amd/display: To modify the condition in indicating branch device

Michael Strauss (1):
  drm/amd/display: Update RN/VGH active display count workaround

Qingqing Zhuo (1):
  drm/amd/display: handler not correctly checked at remove_irq_handler

Rizvi (1):
  drm/amd/display: gradually ramp ABM intensity

Sung Lee (1):
  drm/amd/display: Acquire DSC during split stream for ODM only if
    top_pipe

Wesley Chalmers (1):
  drm/amd/display: Interfaces for hubp blank and soft reset

Yongqiang Sun (2):
  drm/amd/display: change SMU repsonse timeout to 2s.
  drm/amd/display: [FW Promotion] Release 0.0.47

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  2 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c |  5 ++-
 .../amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c | 36 ++++++++-----------
 .../dc/clk_mgr/dcn21/rn_clk_mgr_vbios_smu.c   |  2 +-
 .../display/dc/clk_mgr/dcn301/vg_clk_mgr.c    |  9 +----
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 20 -----------
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  |  8 +----
 .../gpu/drm/amd/display/dc/dcn10/dcn10_hubp.c | 18 ++++++++++
 .../gpu/drm/amd/display/dc/dcn10/dcn10_hubp.h |  4 +++
 .../gpu/drm/amd/display/dc/dcn10/dcn10_mpc.c  | 12 +++++++
 .../gpu/drm/amd/display/dc/dcn10/dcn10_mpc.h  |  1 +
 .../gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c |  2 ++
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    | 12 +++++--
 .../gpu/drm/amd/display/dc/dcn20/dcn20_mpc.c  |  1 +
 .../drm/amd/display/dc/dcn20/dcn20_resource.c |  2 +-
 .../gpu/drm/amd/display/dc/dcn30/dcn30_hubp.c |  2 ++
 .../gpu/drm/amd/display/dc/dcn30/dcn30_mpc.c  |  1 +
 drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h  |  2 ++
 drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h   |  4 +++
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |  4 +--
 .../display/modules/hdcp/hdcp1_execution.c    |  8 +++--
 .../display/modules/hdcp/hdcp2_execution.c    |  7 ++--
 .../amd/display/modules/power/power_helpers.c | 35 ++++++++++++------
 .../amd/display/modules/power/power_helpers.h |  1 +
 24 files changed, 118 insertions(+), 80 deletions(-)

-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
