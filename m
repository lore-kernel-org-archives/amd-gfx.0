Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07EB1C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Mar 2022 22:21:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7EA6B10E244;
	Thu, 10 Mar 2022 22:21:14 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2077.outbound.protection.outlook.com [40.107.237.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 04E6F10E244
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Mar 2022 22:21:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NV/HWZXw9G6czJu00i4dkv9onPRskK2xg/tfdfedq9M+7SLxd9ZyqAYv+H4rEv5XKgHdVF3Fha8NpLgrsM0HmDV1Fk44frpmu6Uaw8ZJTG/FmX9ctZPdnZOaQelRKTKhTXQWwVda8Mz3k9xJ6f1QgHz5HDVPgmyOYhbM8VpvWzfZJEg9ehG9MDTG+9LP4JtrOLbDLlt0MA3C45gyhu1b0G+ojr/btSd9jNrEWWWECVNvo69fQPNICW8sASir8oEPZT8O7bplG4DA+JXbOX4xUfJ/BuNxZw73yCuzKFxqWWRBZ2GBmQB47wqT6MuZNeJ0ojT39qJ74I1yOnvjkj1TXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mB8oipVrnIeE/IqfW1DhK00wHquLdpd26/w7umrriHA=;
 b=BUw2CJsP5GovyHN5B17fBfvwCnsoGGd3CxACofsIqTaY4ThK26jwkww7yMazokoH7E92hsYzVHGXl7Ibx6IJasLcsX1rTgc4OA24Ezr7+jtGz9x0fQQyEjeZjYyEClNLThXl+aWSEDrP6LbOrYBxwdgnQ9rkfSzxWLx/iMIwACl756zqjBheFuEB6uakgKWK37+EjJ96lQlTr02/5DBczY3IWYQMy3tYfel0N6oqaJ/n5jTm63Zk4pUXpGXCMnLgDA3PRE9KfJnpYuANRwrO/bdrN8lSq8xzgrB6b1hOPORPtT2OFhJR7VxOgowM0/me6bx9TkRkbTm2zjBlJGT6MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mB8oipVrnIeE/IqfW1DhK00wHquLdpd26/w7umrriHA=;
 b=seCxNvyHfWtKyH2gOssoHefdbXtppOK9WYzyowYw82avSB8/KgrJRLC90uK8nBefnJOB4gnE1Y7BHlacN20BmF16afd3smcenxfiie6Yps1CViX8S/KgM5xnZ2/l8HhKXSt43hY8zh21Zr5xx6+gst8APRitfY8ip0RdZOdmvlI=
Received: from BN1PR13CA0015.namprd13.prod.outlook.com (2603:10b6:408:e2::20)
 by MN2PR12MB4990.namprd12.prod.outlook.com (2603:10b6:208:fe::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Thu, 10 Mar
 2022 22:21:06 +0000
Received: from BN8NAM11FT025.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e2:cafe::59) by BN1PR13CA0015.outlook.office365.com
 (2603:10b6:408:e2::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.7 via Frontend
 Transport; Thu, 10 Mar 2022 22:21:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT025.mail.protection.outlook.com (10.13.177.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5061.22 via Frontend Transport; Thu, 10 Mar 2022 22:21:06 +0000
Received: from Linux-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 10 Mar
 2022 16:21:02 -0600
From: Agustin Gutierrez <agustin.gutierrez@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 00/12] DC Patches March 10, 2022
Date: Thu, 10 Mar 2022 17:20:33 -0500
Message-ID: <20220310222045.664867-1-agustin.gutierrez@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 03aa4a76-843b-4386-8494-08da02e44542
X-MS-TrafficTypeDiagnostic: MN2PR12MB4990:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB499054838A62EB54F7320FDFF50B9@MN2PR12MB4990.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hncY8k6YDugMUcfndk1nA+iXkoWr1Ip7JyNMVxauUdhcHJtPbl3TUhxRosHshPCiTb64Ruhiu2Wsm35IFPOVKD+2kI/oW2uZjTam71huI2+Z2e873JgBxiFCx4g6+yvOnErxHVze6VMBEkpmi1vbJYx7GjhDrXhKZIDSGsb3MTK9ybiuZ2FHVGGvFY8N8PME5QwfgevvP31BtMV7InkUnTK4YUculpYl8Rs3wQiMd+5HBEAzBYvvmVJIl3Cl9WVsaMRoboXIQBxlpaHZ9fHpcUEm4sMXPE/9bOyrQGyyCY9//huGVMyKLSJP50ZC3zCPHE22hUSSwLvl0QMKgtHcE4ht1oitQIIrBMx6uYLaShBN7/P2TsQbE9rsP2DdefinNCj1f/95hUSpF69uN25bSt/bxmmJYYYA6Xi4haTvmuwuVJv++HnPtO0qLQ9PIFKl78mB40BmBaWi2p3dJI3YYgr7lEvnp2qEbyZNiVkoA6X8dZOVMikc28AZS/s4ZxpGjUwD4rny6nGKe4+FPX0Q2ETghSc3DdHzGLA8+Ya1vApfe3EgRbj2bnn5fk1KNtPJGb5zmU+TKCfSNW+H1LayiKBfHDpIvUnZSVv9VflfRh5ZnZLucjRiGZYWhuYMMmvds6VUOYAFRTu1IxMnT9DXPe573gj7S8SoRpOsL5QGiFMDSIdK7GDpaEUPbrFsXjaG/1uaN+zRTSAGqKnDsoiSiA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(186003)(47076005)(81166007)(356005)(2906002)(86362001)(36756003)(82310400004)(54906003)(26005)(1076003)(44832011)(7696005)(16526019)(6916009)(70206006)(6666004)(8676002)(508600001)(316002)(4326008)(70586007)(426003)(336012)(2616005)(8936002)(40460700003)(83380400001)(36860700001)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2022 22:21:06.2101 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03aa4a76-843b-4386-8494-08da02e44542
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT025.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4990
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
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This DC patchset brings improvements in multiple areas. In summary:

  * Fixes on lane status, zstate, engine ddc, debugfx entry.
  * Enhancements for Pollock, EDID status.
  * Amongst other.

Anthony Koo (1):
  drm/amd/display: [FW Promotion] Release 0.0.108.0

Aric Cyr (1):
  drm/amd/display: 3.2.177

Becle Lee (1):
  drm/amd/display: Wait for hubp read line for Pollock

Charlene Liu (1):
  drm/amd/display: Add save/restore PANEL_PWRSEQ_REF_DIV2

Dale Zhao (1):
  drm/amd/display: Add new enum for EDID status

Eric Yang (1):
  drm/amd/display: Block zstate when more than one plane enabled

JinZe.Xu (1):
  drm/amd/display: Add I2C escape to support query device exist.

Jing Zhou (2):
  drm/amd/display: Update engine ddc
  drm/amd/display: Add null pointer filter

Leo (Hanghong) Ma (1):
  drm/amd/display: Add function to get the pipe from the stream context

Wayne Lin (2):
  drm/amd/display: Fix a few parts in debugfs entry
  drm/amd/display: Retry when fail reading lane status during LT

 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 10 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 13 +++
 drivers/gpu/drm/amd/display/dc/core/dc_link.c |  3 +
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  | 30 +++---
 .../gpu/drm/amd/display/dc/core/dc_stream.c   | 14 +++
 drivers/gpu/drm/amd/display/dc/dc.h           |  2 +-
 drivers/gpu/drm/amd/display/dc/dc_link.h      |  5 +
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |  2 +
 drivers/gpu/drm/amd/display/dc/dc_types.h     |  1 +
 drivers/gpu/drm/amd/display/dc/dce/dce_aux.c  |  1 +
 drivers/gpu/drm/amd/display/dc/dce/dce_i2c.c  | 26 ++++++
 drivers/gpu/drm/amd/display/dc/dce/dce_i2c.h  |  6 ++
 .../gpu/drm/amd/display/dc/dcn10/dcn10_hubp.c | 15 +++
 .../gpu/drm/amd/display/dc/dcn10/dcn10_hubp.h |  4 +
 .../drm/amd/display/dc/dcn10/dcn10_resource.c | 15 +++
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    | 10 ++
 .../amd/display/dc/dcn31/dcn31_panel_cntl.c   |  5 +-
 .../drm/amd/display/dc/dml/dcn20/dcn20_fpu.c  | 16 ++--
 .../drm/amd/display/dc/gpio/gpio_service.c    |  6 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h  |  1 +
 .../drm/amd/display/dc/inc/hw/panel_cntl.h    |  1 +
 .../amd/display/dc/inc/hw_sequencer_private.h |  1 +
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 92 ++++++++++++++++++-
 23 files changed, 253 insertions(+), 26 deletions(-)

-- 
2.35.1

