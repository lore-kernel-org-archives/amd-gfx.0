Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47D5DFF885A
	for <amd-gfx@archiver.kernel.org>; Tue,  5 May 2026 08:16:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E316410E9B5;
	Tue,  5 May 2026 08:16:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cLlotrfZ";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011069.outbound.protection.outlook.com [40.107.208.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A2D1410E9B5
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 May 2026 08:16:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=exhYfi/MQl4gVxXcYNC/WoyG+Ll+Phg/+zMkLDtRzrKR8LgjmkwacckNQ8u+uvUC9mrOgIOtkq8yp8++neljLyBiIBclu/Bp5Hf3rQ6F5nyCoT03OGHxG3TC1Gi1IlNh/CTpnvxnZkv/m1rvazTMCzF8IlSIks3fTXRAsGCz4fbBwiUEXy2dIOVtzsJMduAc0LgLxQkkwx/IJhnH+VwEVHgMtvMfABycIVoXFcA56pvfBnHirl5WvuCTOGaj2TLvsAJbru6x1MeUgWujFsAzPTm5XRB5j4SnasDRJOpBEORdkXHzhHMd3Jzl7faEr9cUs2Xs/qemuvb6dk8TEhA4ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g/Bz76taa6PeCx0azx5/0ZCBa5cxcQzN99DAKO3ygBw=;
 b=Vwoklg0X0vipzKfQ6F1BkB9WwLZXU4RC3rrW2UoBeDfAM+bsgULPvaK5aLSrJEXK2yFk+NtI6N+oe5nzuEfvko5tanDqdYmbmcOtRxc3coMQBijLqslYx/kleQFdlkZg9F1jF8G8zGjIUMaD3K5j3Kpb8MqAGpTkcOPP/8lS0sOxuvswubGK1/Hr5ih+9BAPRx9T8/s5zJwrWsLz+RiPAriwZX2Vm2naBCzRYZvIWsbpVD3xwZq8SfAykb72g+oc+CLTxuFkIrLFpBf4EUyBeVeVpwnpqDoGChn4/Ig6lMsTHP95uMdatOj/85Xj69M9GcmGBGVx/FJx/5xGuGR7Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g/Bz76taa6PeCx0azx5/0ZCBa5cxcQzN99DAKO3ygBw=;
 b=cLlotrfZzYnYq6+NN6xIH/gkMYyrNEHI46PJd0bOIp7hZ/Z3fCfVgzIjW0RH44/Cf/n8Kifw3vgtueDmf/4cxd0wgEJwEi1PTkkJL3k4QCDsddMurNL7OA94cEf7JO6RWLwHAgNT2PvhXRtfUquedaCM8tgaaF7BynDJI/baoTg=
Received: from PH8P220CA0035.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:348::7)
 by PH0PR12MB8051.namprd12.prod.outlook.com (2603:10b6:510:26d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 08:16:27 +0000
Received: from CY4PEPF0000EDD2.namprd03.prod.outlook.com
 (2603:10b6:510:348:cafe::d1) by PH8P220CA0035.outlook.office365.com
 (2603:10b6:510:348::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.27 via Frontend Transport; Tue,
 5 May 2026 08:16:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EDD2.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Tue, 5 May 2026 08:16:26 +0000
Received: from caden-test (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 5 May
 2026 03:16:22 -0500
From: Caden Chien <chih-wei.chien@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
 <christian.koenig@amd.com>
CC: <HaoPing.Liu@amd.com>, <Solomon.Chiu@amd.com>, <Peyton.Lee@amd.com>,
 <Yu.Wang4@amd.com>, <Pratik.Vishwakarma@amd.com>, Caden Chien
 <chih-wei.chien@amd.com>
Subject: [PATCH 0/4] drm/amdgpu: add vpe 2 support with nbio updates
Date: Tue, 5 May 2026 16:13:08 +0800
Message-ID: <20260505081312.14047-1-chih-wei.chien@amd.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD2:EE_|PH0PR12MB8051:EE_
X-MS-Office365-Filtering-Correlation-Id: 09abbbf9-6be2-461f-992f-08deaa7e9a54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|376014|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: A5dwYh9jUoI6DKtGg8GHwrGPorMOXuGW+VaT8Up8ciGT11HVJt1DcWVrQ1xlz/lvWs1ZhQf7TBIxAFten0+ScYMMfid5Y3/34ymmALDJrxCEPyOELU3fbFklysHNpr5qBOvTwzdqpc1jygO8Qq+y7n1OLD+zemBpix8RPlDcagb8Pq9kD4B+xfqqo92iLgsWGSoHaVw8vOHlqpMEqFAUfxOTrHT95HTLOpsTXLFTeIV2OlVdiYdrNYpdzNYiFpY9DmhT2CBaniy5VNxFLdR62Z6+IE8dYdDuRcGXI+uhboVZy/wMInwqbwWZo6zzO8nHHw/TvobRL5cS8u2Rrl3MldZa8L3y0XajkpM5JJKS7IZ4576fP7xRkDTVg6pQbDp28xVBB4/C+wVMwRPOPmmkL6tBDdhDA3rWG+3k2rLsKfv2kG09DXPSRhH0QEAKG5f4vr5wLBIa7K78NBH6AzH0Snh77pLS+xTlMlFSoxGGxciwxQrwfrKWuxYXYkYfUUWLf8T+DYzuodGibq2KJwbCx47dL7siAsAdY8FvIBVoKSlaThhpLXBqbBHlYxnwTt6Rpdyo9OS+mstIn68gqQPtEWJbVvUmrMGoj5I6GxkWUGfT56Pl820KzV1R6N2zyv84hTVf21JPkhKb7x3iIwuOXx3uwYQ4OU24lItmiyd01lcl3w9yDbUTlf8vRGB13aXhlMJVcGXs67WYVzHbAxTGelV1719FVB9/NC+bP28VNc0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: bSm3LEOfWWQC28VrR7CLXuOUZH00enTXeBi/EpytOAeT/C8xVRXRF+5FNFd3JCI4lIpZaOfTnp0kIjVe7Yypma8B+SmYTHu2+ADvNb7bKyBdQfOJ3IjZ+f3yY6POLyt1vDn62u00y73JCpBc2CVEsDrUKy5wjplM3sJIRMfENFHzsJtHgWL35KrWzYFZvgrxMCh5zGVOG9Ss+Rla7n6wi6AZmte8X769elK6NMW4ahgCN8O9IHw8gdoy6rYOeAz2LmZ2rfjhkviTpdSpGAqaNwwJAPyq980q4uyKSCxYQmR60uCyY8wMXvvI39QfWw4IUa75+ZrjOWsNvlzSEDSidudBOQaN53ahYa7UQZ+7yN/hD0mZkUQaeq8rMX9o9AmkZEm4MlJLlUKq7D8EGimAkX39u8XH3HCMuNGhVD5qRNE+e73UsyoMh5ujCF3luzGB
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 08:16:26.4402 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 09abbbf9-6be2-461f-992f-08deaa7e9a54
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8051
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

This series add support for vpe 2.0.0, including updating the use of
doorbell entry, adding new ip funcitons and structs, as well as new
registers offset and sh/mask.

Caden Chien (4):
  drm/amdgpu/nbio: remove doorbell entry5 for vcn on 7.11.4
  drm/amdgpu/nbio: add doorbell range init for vpe on 7.11.4
  drm/amdgpu/vpe: add new vpe v2.0.0 register offset and sh/mask
  drm/amdgpu/vpe: add vpe v2.0.0 support

 drivers/gpu/drm/amd/amdgpu/Makefile           |    3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |    3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c       |   25 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.h       |    1 +
 drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.c      |   58 +-
 drivers/gpu/drm/amd/amdgpu/vpe_v2_0.c         |  350 ++
 drivers/gpu/drm/amd/amdgpu/vpe_v2_0.h         |   29 +
 .../include/asic_reg/vpe/vpe_2_0_0_offset.h   | 1041 ++++++
 .../include/asic_reg/vpe/vpe_2_0_0_sh_mask.h  | 3162 +++++++++++++++++
 9 files changed, 4665 insertions(+), 7 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/vpe_v2_0.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/vpe_v2_0.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/vpe/vpe_2_0_0_offset.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/vpe/vpe_2_0_0_sh_mask.h

-- 
2.53.0

