Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06630C74A5B
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Mar 2023 20:31:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ADF0A10E1B3;
	Wed, 29 Mar 2023 20:31:13 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2040.outbound.protection.outlook.com [40.107.101.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5383710EC5B
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Mar 2023 20:31:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dvnk+I4FBbCL9C7LKSoRr4UFCqMQ34RDWYCPIF19/Ytk8Q8YJIGXImnszm2tFiXAQzeVs97hePLaSSgP8XfUsgkBxB9hGf0bSTDlAkOjQLfBDVe9F71F2G3tDIFvhWN4z5UnD3Os2113BUpW12yILNTw9ItrYxRqyatlmSSNqFuidRHvfoIKTvSLUPREJ1PX+PDTqBKZJ8r7JjXqcVKJprWOjhdBvOHAfjJQLAgEK9ZFRF4VeZl/l8N9iGC9t+iXTc36CaqHFDviLXtq+UFia4wmvnS9RaCuosWB96tkvYfg7gHG4XqesnH1IQX1VMI1kejponEgnW/S2f+cPVqftw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3wei736x4mzVaeD1gJasn6yn2+uZyflZO9Z2AJQthFo=;
 b=VuT7Xizeb4140txlC2UXlHCHDCH2AsOvU6Ups9yIal1KjQzaJpde5n0nxXanb8hhlEyWpdehDrSwlTz64OTRUZha4IhnhMrbHoUxX5M5lZZUmxoA1kkD6QayQkGDooxgpu1CoVUu3/pZC0IidqM0pXzrhPiy1kpq7n7mVrbaociO0VkdnB/rkVY/gUcljRFVx530cZV4T84prLp/9CFQLTxRRWgiEMIT44DcYeqS/zz/1unnRRk6+QNsvwhZ8ahOpCqbSYF7ThUr11l8Nh8vpCmamW/V+ciDwJiyoibrhL1rOEpCI/JFtPm9AQocJLB/xtEat2Pzklh1A+s+4GxZGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3wei736x4mzVaeD1gJasn6yn2+uZyflZO9Z2AJQthFo=;
 b=VydMtKqyr5lZtp8VsHifRV4fnegUGWglCqbMSXsWYt7gtZmazbdJDPy9Q/XHDYr7/84lJZ77RxLsfXI1Aa7n4ktz7IooEh+ro19CJtfQfdCiY1O2sn4xZ+NboXEkBKw5frqWjHGaZunFwYxhc7MXiEZsstSnTgNttOFaRs3Om3M=
Received: from CY5PR13CA0023.namprd13.prod.outlook.com (2603:10b6:930::9) by
 CH0PR12MB5331.namprd12.prod.outlook.com (2603:10b6:610:d6::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6222.35; Wed, 29 Mar 2023 20:31:10 +0000
Received: from CY4PEPF0000B8E8.namprd05.prod.outlook.com
 (2603:10b6:930:0:cafe::1b) by CY5PR13CA0023.outlook.office365.com
 (2603:10b6:930::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.18 via Frontend
 Transport; Wed, 29 Mar 2023 20:31:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000B8E8.mail.protection.outlook.com (10.167.241.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6277.7 via Frontend Transport; Wed, 29 Mar 2023 20:31:09 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 29 Mar
 2023 15:31:08 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 0/3] Add support for SMUIO 13.0.3
Date: Wed, 29 Mar 2023 16:30:06 -0400
Message-ID: <20230329203009.1983616-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000B8E8:EE_|CH0PR12MB5331:EE_
X-MS-Office365-Filtering-Correlation-Id: d324a0b8-31ea-4584-7ed0-08db30948826
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yLdKWJQpurUOmKJqlLJp/Hqk9lXv9epTgILEFuGTfQu/JSn9KTZG3aSzsDifsexfFChmH2lm5gOfiwZkeokJeyylPKDBdzTNStsXdcDI3qlev7ymQ62ptCpCXiDg3s7Ce+toZ8kQDpS2tFOvnc7XAbDb9wm8rEAfHc+JT08QJJSVfAyY2SyhA09MZqpdFRo+gxlHr8Ahk9UdtTsgMwPOE27vIlPVzjlabh+yC/J8sThwVyl0cEIJEGgqhrD2U1LVf/BkrrVbe0Y7MJ19v1kIZ2ZxaTQuoBsfWA9gUYv7+ZYi05bX9Jr9TtKj4upIcslUrqqlsPMRP0wRVQUWHQGujwe9KqKoe0x3YDYIzlunijgnpTuLx1NnMPsGHTt581mf6lM6TSXqCpk7l1NMqKDW/p1Cq5yiRZeKz7ZV+bbBVUqWBBxMr0vY6Ar0jfVeEQIWWHMgX6A+CqdyNEj1JTVMxHb+6itY1ka4s8M+zTrhEsoXx7n7JV7YarhPBDale5QxFgYWpo7n909wrKnUhZaZB5SigUhnkFr5Eu7uCBEImUVlfl+66E4CoChJdRp3x0I3qfEp/fsvTBkTV87ydbn55x1AZ3NldlXZF5eb605o73WPufXjvnDLKKyaCD7CKDTqoRH846Q51ivja0XILIIV7GWiene0tkBQRUc7AGoNAKU4IGsHqFCxYkviy9m+/Fh9/Tly7s18bRFiKXxcnVx5Ldx3dMawidndM7DQDPt4fhs=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(39860400002)(136003)(376002)(346002)(451199021)(46966006)(36840700001)(40470700004)(336012)(47076005)(426003)(70206006)(316002)(83380400001)(36860700001)(70586007)(7696005)(2616005)(26005)(1076003)(186003)(478600001)(5660300002)(16526019)(2906002)(86362001)(40480700001)(82310400005)(82740400003)(36756003)(40460700003)(4744005)(8676002)(41300700001)(81166007)(6916009)(356005)(4326008)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 20:31:09.9335 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d324a0b8-31ea-4584-7ed0-08db30948826
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000B8E8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5331
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This add support for the SMUIO 13.0.3 block.

Hawking Zhang (2):
  drm/amdgpu: add smuio v13_0_3 ip headers
  drm/amdgpu: init smuio funcs for smuio v13_0_3

Rajneesh Bhardwaj (1):
  drm/amdgpu: implement smuio v13_0_3 callbacks

 drivers/gpu/drm/amd/amdgpu/Makefile           |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |   4 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h       |   5 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_smuio.h     |   1 +
 drivers/gpu/drm/amd/amdgpu/smuio_v13_0_3.c    | 103 +++++
 drivers/gpu/drm/amd/amdgpu/smuio_v13_0_3.h    |  30 ++
 .../asic_reg/smuio/smuio_13_0_3_offset.h      | 177 ++++++++
 .../asic_reg/smuio/smuio_13_0_3_sh_mask.h     | 428 ++++++++++++++++++
 8 files changed, 749 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/smuio_v13_0_3.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/smuio_v13_0_3.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/smuio/smuio_13_0_3_offset.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/smuio/smuio_13_0_3_sh_mask.h

-- 
2.39.2

