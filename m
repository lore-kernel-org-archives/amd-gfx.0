Return-Path: <SRS0=hpB+=NE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32848C4338F
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Aug 2021 06:35:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFBC2610A5
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Aug 2021 06:35:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org EFBC2610A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A4D1D6E511;
	Fri, 13 Aug 2021 06:35:16 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2070.outbound.protection.outlook.com [40.107.244.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D83AA6E511
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Aug 2021 06:35:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XqjEL7J/IK5H3vjm/6bTry5TzzdPvV6jZQnj9RwtD7ql0H/IzeRIb8QXVAHjbSrFHECjDS8rNhz8L0UpmnbHcyr5GLzXEBJ2QZg0LxNphktlW6lcyZ7Bg42BeO9LS9lVKyxv/aAEaFORXWNwTTAj+AZsuGW/CP4UBLrqPMXJB7G5XINUDZnquq4CxdZpN66pwS4sokWOFykl31PmLKtBwlwpQGu7SWIwev5HsmWyAFbu2X5QooebX6qGga6m496sCOWwWr4ue2jnYspwdvjqcLMnS+bgzOe7m7d0Ybrg/LpIyW2g0W+UfMsOGXiMMA8njCORKkup19d0rvrCotyeNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y4spmR/HqQAtDVim+q7E+MLq3jSOaUz4HmSDjunJqgY=;
 b=TuQ9KsWJrvtvYlOMIDDzTbnlkjlnSNamhD119jZnRVHYM4oJYFhY+EkUONhYnqn+JMKBAZKqkAuaZuLKpeewAoT7oOtGPxXX5UwVkTwLEUvYItH0ttZZwL4JbimV7MfeVZ3HrfPkvoOnSiqfuZ/ECxIDC1wyH6tMlXZB8lAtrgC3hMZDir1L2zLSnbiWh7iDdO3JVwj6elx9+sMUrc0tx5VsnBmgM7hXHlUO6FcnOPQhN6XmtpG0IsNmLfG9fcqenSTpyY7Gema24oJxjgN6/+2s0iLjgVfzBNuRbWCMeFf75zPKJ52xKg1fOb3QvsDZ1CKxTCvfzJsIONI0kYN7Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y4spmR/HqQAtDVim+q7E+MLq3jSOaUz4HmSDjunJqgY=;
 b=BkwBpbKN2c24DmO4J+G9YbDFsk9FnL5A9fI8PDh2OmTKXtX2SI6FmcR6AjugsVQziwVlNkaDZsA8OBKvS17GioFDxhzCqpDyD4q0P/AENXNsjVfDtuvzJXud8W0Bt1gg9QCzedgXA9cI1viTrRDNGTccXH+POaA9kMzksZaK/7I=
Received: from BN0PR04CA0146.namprd04.prod.outlook.com (2603:10b6:408:ed::31)
 by MWHPR12MB1821.namprd12.prod.outlook.com (2603:10b6:300:111::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.17; Fri, 13 Aug
 2021 06:35:13 +0000
Received: from BN8NAM11FT061.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ed:cafe::28) by BN0PR04CA0146.outlook.office365.com
 (2603:10b6:408:ed::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.16 via Frontend
 Transport; Fri, 13 Aug 2021 06:35:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT061.mail.protection.outlook.com (10.13.177.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4415.16 via Frontend Transport; Fri, 13 Aug 2021 06:35:13 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Fri, 13 Aug
 2021 01:35:12 -0500
Received: from wayne-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.12
 via Frontend Transport; Fri, 13 Aug 2021 01:35:09 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <Qingqing.Zhuo@amd.com>, <bindu.r@amd.com>,
 <Anson.Jacob@amd.com>, Wayne Lin <Wayne.Lin@amd.com>
Subject: [PATCH 0/7] DC Patches August 13, 2021
Date: Fri, 13 Aug 2021 14:34:55 +0800
Message-ID: <20210813063502.3106309-1-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 77e68efb-f797-4803-8053-08d95e24814e
X-MS-TrafficTypeDiagnostic: MWHPR12MB1821:
X-Microsoft-Antispam-PRVS: <MWHPR12MB1821A22A705D0C116639904FFCFA9@MWHPR12MB1821.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zegVc4j0JdzDz0gX4xMUKKGuGz+QrY3+m/8YRWEdQaXizmlcFJYuIFaz2zkPGb6WjMjgyIoMAQcggzI239vHlH7uaVNJIPtsf4B+B7fD1XqDvLve1GKY1JNhGz4GZQYorZVmIiOdNAb1k/dRRWlQw3/9cMvPLCHgcbiqKQ0DCdIUK+Fa96vdo7KlPRjS6pELLK5ZsIebn5Cm0v96Y04HraNXxJWHsXACNEoRN/l9YA5bacnTtq8Dy1NRqI4eh0M4w1HupjGsBBY+hE+7Qp19t3RJSDmyrdRO1r8BAyxDDyuVuv+rSCjwNberhY4UaVgaAKmpwKwNH0lmxjKMKvIrbhPMqB7Xf2IpKOaoVk1E9gleT6I0G/rd0J4Xwzo6UNUEjCmy3th5FxgtMEgznaTb8+88Z8/+n/j7kIVhOL96nMEIkR1+I1kG7Czasc4EaZwMQIpKMhM+B/VfNYdyW96Y25txJ8n65mWZHNZXpvRoG6tFX4ym39wszcaVSPDnuDklRDe0LhUh76W50wiw5imE7raKasgP9ncNkKgQPUAxL5ZHvy42wI+sK4VEpYTSgdCtW8ZIbty15N4o0eCP4MI5A5f4aYQdkdPKLPtWLd2gZD3X/15tdJwW7hVkOUKl2nIlBCJdyC0bsoqOxKiPPU8wtuD7hlqtpVTgZDuV1wtffiMwSiGRhypwcFWAQ9jmRUkxr/IyxfGOlNMSxU+Vk40rV2uRst/xPFKZ4jvjAS1sfBgS5bjjsM7drLj+y+masjXXFFh1JSLxQuiWhf0fbfkEJg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(426003)(2616005)(26005)(5660300002)(6916009)(186003)(336012)(8676002)(1076003)(86362001)(356005)(81166007)(83380400001)(54906003)(36756003)(4326008)(82310400003)(34020700004)(316002)(6666004)(508600001)(47076005)(70206006)(7696005)(8936002)(36860700001)(2906002)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2021 06:35:13.0445 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 77e68efb-f797-4803-8053-08d95e24814e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT061.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1821
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

This DC patchset brings improvements in multiple areas. In summary, we highlight:

* Ensure DCN save init registers after VM setup
* Fix multi-display support for idle opt workqueue
* Use vblank control events for PSR enable/disable
* Create default dc_sink when fail reading EDID under MST

---

Anthony Koo (1):
  drm/amd/display: [FW Promotion] Release 0.0.79

Aric Cyr (1):
  drm/amd/display: 3.2.149

Jake Wang (1):
  drm/amd/display: Ensure DCN save after VM setup

Nicholas Kazlauskas (3):
  drm/amd/display: Fix multi-display support for idle opt workqueue
  drm/amd/display: Use vblank control events for PSR enable/disable
  drm/amd/display: Guard vblank wq flush with DCN guards

Wayne Lin (1):
  drm/amd/display: Create dc_sink when EDID fail

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 112 +++++++++++-------
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  23 ++--
 .../display/amdgpu_dm/amdgpu_dm_irq_params.h  |   1 +
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   |  23 ++++
 drivers/gpu/drm/amd/display/dc/core/dc.c      |   6 +
 .../drm/amd/display/dc/core/dc_vm_helper.c    |   3 +
 drivers/gpu/drm/amd/display/dc/dc.h           |   3 +-
 .../drm/amd/display/dc/dcn31/dcn31_hwseq.c    |  12 ++
 .../drm/amd/display/dc/dcn31/dcn31_hwseq.h    |   1 +
 .../gpu/drm/amd/display/dc/dcn31/dcn31_init.c |   1 +
 .../gpu/drm/amd/display/dc/inc/hw_sequencer.h |   1 +
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |  19 ++-
 12 files changed, 148 insertions(+), 57 deletions(-)

-- 
2.25.1

