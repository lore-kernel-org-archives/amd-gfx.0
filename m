Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94211C64ED8
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Feb 2023 08:32:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D2F5A10E0A9;
	Fri, 24 Feb 2023 08:32:58 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2087.outbound.protection.outlook.com [40.107.96.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8624510E0A9
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Feb 2023 08:32:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n6GrdFELl7fwnV1SaeVk36glMNeRhsuxZsdPDG7IoRCWLfEa2TpmWt6VDCAQ/1gkHXyP1cxzXoInxDr/DrnBx+vt0nQqx4TxqRe3h8vltgj8tE7be7jLuSdxEEjIIsW6mqfq/XbpZGsbAQ6q8/o4cH29nmAAdPvlIDMO7WIGSzXPuy5fzAiImmBWQ6kRWS0fFdiQW5Uxxxhu3guUY4p/TGSF7S4yonx2SMzJFpniWeUTZCJ/xYua2gCk8dvtYfMW8MQEsVnLdKYhcoVk6523Hx492K03s/IhCkZ/i/l7q+yzdafVqehYf1H/AQs8ByXIATOXv1cvsNb8ShVMyQNYJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CwnHxDdyQqa5W+5ag4BHSe0i2bgf6ChcE8cN+k8VYh0=;
 b=fngfvV971aKR/q7L+G87ESbW0fCCvlGEGwSV4xtcys6Yc+GFZkpVFqkaj0VhPCW/g8RYjBLIifDKGBOeqHEiV1Z3R26AN8Y7tMEKI/IzNpi0Ubr9Md/IwxYCKfaOnuABwt1mGDJrDYi/G5QNZSi6TEgR5xPIgkEQ7R/cD7HtL6RWw5cLxAIaRMQgVkXlyJ0Lao1k6kh1GrbvS23QHWxgVfzoX/F7ynrZE0Q8ti+5TpcaIM/EcBFi0T03TDG+7ZbxWsqko0YP9yZtgq3ohdXIMuwegmWVtCl8BS+g2UP+Wlb+5A83UvV84KcdS0skalgM1LN7ZIgfaBJ0h1ZBmxooCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CwnHxDdyQqa5W+5ag4BHSe0i2bgf6ChcE8cN+k8VYh0=;
 b=j/w7QL6iZVnDLhqjOkjrgnei6rkmdBylWncs/gPtAO6+Mhk/S94ZEepdFODYl7PPHKffrdwJ64/wwAn85pfR7nj/vXBiyg/RshLoK8A8fTht+ltMX9n4XGLvDU6UlL6AwN5rftFNVcp8naOhcTN/V+pZx46mPPWi5PhddP5oeiY=
Received: from BN9PR03CA0272.namprd03.prod.outlook.com (2603:10b6:408:f5::7)
 by DM6PR12MB4281.namprd12.prod.outlook.com (2603:10b6:5:21e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.24; Fri, 24 Feb
 2023 08:32:52 +0000
Received: from BN8NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f5:cafe::5f) by BN9PR03CA0272.outlook.office365.com
 (2603:10b6:408:f5::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.24 via Frontend
 Transport; Fri, 24 Feb 2023 08:32:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT068.mail.protection.outlook.com (10.13.177.69) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6134.24 via Frontend Transport; Fri, 24 Feb 2023 08:32:52 +0000
Received: from pyuan-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Fri, 24 Feb 2023 02:32:49 -0600
From: Perry Yuan <perry.yuan@amd.com>
To: <Alexander.Deucher@amd.com>, <Evan.Quan@amd.com>, <Lijo.Lazar@amd.com>,
 <Candice.Li@amd.com>, <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 0/3] enable new capped/uncapped power profiles
Date: Fri, 24 Feb 2023 16:32:32 +0800
Message-ID: <20230224083235.3448477-1-perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT068:EE_|DM6PR12MB4281:EE_
X-MS-Office365-Filtering-Correlation-Id: f380063c-5d70-4742-9ea1-08db1641b825
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +9qZ+Hn+7MqfNkFxQL88sUnyRHwMOBjvvSgVEFpNLvjAK+mraiFqVWaQV+/oVnZt7mlD0lF5towzx2omR/FYHfJQDvQRvFmpnN9asK9pr5i6jfgTXGRrpkjiMN4ZVUBU9yjUnT6Uu8scefdwocPkvgnVri8wda3NwQnk2pjOJKfyGxWL5JjVDX4nm8c3ooke4xDi+kPrMKfaci5dOuFpTf5YG4kWsbDLaRvIEKtE5KXG12+IE1ZEKF9xAwYkgivxlQr4v6/OMjqmZVS4EjMvQuyEMWuD/a6kkKXuxByMmeg3WsSnh/uY8JORCVpMYZaGhbmS4HkAFOrAob6/iFPjVjuiCKoSk7GfwhZLkN/Yd+usjsg7kEvX3xhoOZWWidbqydV9sphngILTJ0r4MdHfx3wvj8QFel4jxOdNDq6G/Ez5gw/HP81HlpKfTYU+yAsVQB6iD1NGjRiwdvwlt6MQcw5GaIBriaKfidy6vsS/YZ0u3SrAAdaTP8YZRzPlif5KOvRPhg8QxTfOuO+OBkc/ez9dpdq1awQj8GbKYV1Wq+AdYDnVrqsdQ5rwtFl8sOemuNGaSUfl3uckNCEyIHzlBPNqOQxXxOnoliGlqzYpVpM37MeWw8yCLiM+3p5ZF6+Svbeo+OCct6SIWkQ6geiGf6PEM1F0FmM2q5KmqWbEllSgyKEVSJZrg7NZdK0fXotqZ+IajFWrSxtVEbmLoArhyU8WoChw1puEBLksymyeVPU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(396003)(376002)(39860400002)(346002)(136003)(451199018)(46966006)(36840700001)(40470700004)(26005)(186003)(16526019)(36860700001)(8936002)(44832011)(5660300002)(81166007)(82740400003)(356005)(2906002)(4744005)(1076003)(41300700001)(6666004)(2616005)(478600001)(70206006)(70586007)(40460700003)(8676002)(4326008)(86362001)(316002)(40480700001)(82310400005)(7696005)(54906003)(83380400001)(110136005)(47076005)(336012)(426003)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2023 08:32:52.0746 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f380063c-5d70-4742-9ea1-08db1641b825
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4281
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
Cc: Shimmer.Huang@amd.com, Kun.Liu2@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The patchset will enable the capped and uncapped mode

This new capped power mode has limit DRAM Thresholds 
and conditions in DF-PState Algorithm based on the workload type set 
from driver.
The uncapped mode will reset to normal performance level which has no 
such power limitations.

Perf Centric Workload (Uncapped)	0
Power Centric Workload (Capped) 	1

Perry Yuan (3):
  drm/amdgpu/pm: add capped/uncapped power profile modes
  drm/amdgpu: map new capped and uncapped mode power profiles for
    Vangogh
  drm/amdgpu: skip the invalid workload type

 drivers/gpu/drm/amd/include/kgd_pp_interface.h              | 2 ++
 drivers/gpu/drm/amd/pm/amdgpu_pm.c                          | 2 ++
 .../drm/amd/pm/swsmu/inc/pmfw_if/smu11_driver_if_vangogh.h  | 4 +++-
 drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c            | 6 ++++--
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c        | 4 +++-
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c        | 4 +++-
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c                      | 4 ++--
 7 files changed, 19 insertions(+), 7 deletions(-)

-- 
2.34.1

