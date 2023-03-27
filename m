Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8124EC76195
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Mar 2023 07:25:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 15F4510E245;
	Mon, 27 Mar 2023 07:25:06 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20604.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::604])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4247010E245
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Mar 2023 07:25:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=arnQYn4yyXDkqRFrxJmTRYslMq9a4oSHXc9iDejwfuk1PyFMGp9wGBpPIcGwFltagk5v61RC+pSfcI0Lai9WVjlf5z/OjNmTD0uVDQz0EhtNMQKXYJbupnSujmMV8PITn5lTDhGNHg6lEftMkNv1J+xR23/uYw8GlC9L9VzsN4cklZvnsqVwcgpWG+KK4ctzKQoZ6Ajv+EbnQAkXmeKFBx7SnSyuwOJ/1NgpfjRR+lNson8yVj6Q8A14YRJ1tQnPER/f7ioZTy6qb8LOW+BH/vCyy2bzZmf1cCmxMOjXZWOFFL3gK1sjhzmZEhLKXtjlKeApisFf0DxOxvwU3WsDYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3kMVKG7ZSq+wxRxXlL1w+mKysE93l6aNwmIYcED5RVk=;
 b=ZotFm0h/PoG/8IgUHRLzlwgWeyluVustpgiNHOwIC/Qj4CoyL/fUtj0WmkZ3IplBrdyot+NBi78jl+1apXed2kBaEu445zj7wh2lZKeIY/20UaogYwTzcQbjO5E3Yv3emiPf2FJOngHH+SYTpMd5XKhpNpU1YM2lksiPZTtcUPIBj7R9jGuIuq6jZAnyVvGPFifrtOAb/pYQet4LzmcG69VQqISLuNRD+hqSgpix7R5X/OtDYeE3yz4JTfY5Shdxl/PDQpYvFlN8Q8UkmFkM2LWh3vJbjX75hWOKkyB6/b5DX+cnLODfWsequpO6ZoZtU/c0kvJaGd9xZGS3NiwkPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=igalia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3kMVKG7ZSq+wxRxXlL1w+mKysE93l6aNwmIYcED5RVk=;
 b=jNXMWdw3uT5aNrV/L5Dj3oYWPyw6lbWxhDyaV3gwNOdL8TMO0CPe0ye06ZmPCUsa4XE3K+uL8kGo+v5tQRYiwaFe9sREzycyNYARt1WzMCTwwxNzailF1hF1TSer835WMkQQFGsbmJH8UCzRRsGsmYbJzwtWxoad+sUwinFtExk=
Received: from DM5PR07CA0067.namprd07.prod.outlook.com (2603:10b6:4:ad::32) by
 DS0PR12MB8366.namprd12.prod.outlook.com (2603:10b6:8:f9::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6222.30; Mon, 27 Mar 2023 07:25:02 +0000
Received: from DM6NAM11FT040.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:ad:cafe::da) by DM5PR07CA0067.outlook.office365.com
 (2603:10b6:4:ad::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.42 via Frontend
 Transport; Mon, 27 Mar 2023 07:25:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT040.mail.protection.outlook.com (10.13.173.133) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6254.9 via Frontend Transport; Mon, 27 Mar 2023 07:25:01 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 27 Mar
 2023 02:25:00 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 27 Mar
 2023 00:24:41 -0700
Received: from archlinux.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Mon, 27 Mar 2023 02:24:38 -0500
From: Wenyou Yang <WenYou.Yang@amd.com>
To: <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
 <Xinhui.Pan@amd.com>, <evan.quan@amd.com>, <mario.limonciello@amd.com>
Subject: [PATCH v2 0/3] send message to pmfw when SMT changes
Date: Mon, 27 Mar 2023 15:24:34 +0800
Message-ID: <20230327072437.580766-1-WenYou.Yang@amd.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT040:EE_|DS0PR12MB8366:EE_
X-MS-Office365-Filtering-Correlation-Id: 010afbd0-0498-44b1-6bb3-08db2e9460ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5H6BVINUmcNZY7NFBqLxFXFidaWinmCX82R3Hy6R3sdxtBUj59aDX7sMnXIAIcBwLr027UtjFAdG1lPo50dybZmr00fCbr01sAPF9g23C4HomWlSJRxz17z/xls/S6C3A2qdnNBVCWcFEFLYZXDrZ6JRuiusS5dKUHfelM7662Kr+5z25U7Cmr4TUyZaS/bEynDZoqvSa3aseVmmye+88ovcwIgdV72ViNB108nbewkOEb711sBIbKK1538QobOz+s64GfQqSriD5i3U/ne6DLI2+c8moiISBRe60W9n59g/C/280xSUUm6vckyqiPVzRPKLFvk9NH4gSOx4BpEKRYmQIs0P62lnS+IycaMn6v/fEsK9V4aMh5s0bD3s0Bl+s/8Cib72mFLL/IgoK9+B1U/MgmtC1RsnJNaNxcH+fDsrF/1Iu6lzRVww4uYwcM9JIHT496cxNSwdzDT48ZRGjBA0K6LZZpfzu5hQg74oCRqZ3OGFFdL1jg6f+IK213EG5rdtLmCrkhKLjiPWrloCs0l6fZ+FoWMCotS4ehVRulc5snFx7I2DaFk2DCG38oh2loa7keKrHERdgzFMe2jicp7LWzOYQCkoHRuyzOd9T3j1mZz4R1SyL+lErm3D0MQmJe3Wfxn+9ApaXliUXYYGgvClWuBEnOXAIkFKCmSsc6AwYm5En6Zmbpt85I0ro2M4Etum/qLYgt9YfnlkH1ycoYGMpptGIybvC9Qe6UE4a9A=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(346002)(376002)(39860400002)(396003)(451199021)(46966006)(40470700004)(36840700001)(1076003)(26005)(40480700001)(41300700001)(6666004)(186003)(7696005)(2616005)(83380400001)(426003)(336012)(47076005)(478600001)(54906003)(316002)(110136005)(6636002)(36860700001)(40460700003)(15650500001)(4326008)(2906002)(4744005)(8676002)(70206006)(70586007)(81166007)(82740400003)(356005)(36756003)(82310400005)(86362001)(5660300002)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2023 07:25:01.8551 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 010afbd0-0498-44b1-6bb3-08db2e9460ee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT040.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8366
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
Cc: weiyuan2@amd.com, ying.li@amd.com, amd-gfx@lists.freedesktop.org,
 Wenyou Yang <WenYou.Yang@amd.com>, gpiccoli@igalia.com, kunliu13@amd.com,
 richardqi.liang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

When the CPU SMT changes on the fly, send the message to pmfw
to notify the SMT status changed.

Changes in v2:
1/. Embed the smt notifer callback into "struct smu_context" structure.
2/. Correct the PPSMC_Message_Count value.
3./ Improve several code styles and others.

Wenyou Yang (3):
  cpu/smt: add a notifier to notify the SMT changes
  drm/amd/pm: send the SMT enable message to pmfw
  drm/amd/pm: vangogh: support to send SMT enable message

 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 39 +++++++++++++++++++
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  7 ++++
 .../pm/swsmu/inc/pmfw_if/smu_v11_5_ppsmc.h    |  3 +-
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h  |  3 +-
 .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  |  8 ++++
 include/linux/cpu.h                           |  5 +++
 kernel/cpu.c                                  | 10 ++++-
 7 files changed, 72 insertions(+), 3 deletions(-)

-- 
2.39.2

