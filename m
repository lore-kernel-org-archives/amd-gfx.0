Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22242E95A96
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Oct 2023 15:21:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7042210E287;
	Mon,  9 Oct 2023 15:21:45 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2050.outbound.protection.outlook.com [40.107.220.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 32FEE10E280
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Oct 2023 15:21:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mef5GcE/PyZhiFQETEuSp1PrMvO30TP+uCNqOaTUCglNBNoWSImSTW1uCrUwSwdbeA9+H9gYj6TPKetwOcvC5mF42ehYFC14orUCRCeO56Oc0SItaYabvVJUpA3VK+OFxhxwzktODjpT00CXXoJ+C08wLcyeqrqpIwc6khXGYD56xKNNrq2rdkNx7aDK+OqIHSjwo/lCjm3fDc7QC7baTMVxowtcbJnesZKh3XSRO4mksFxoDSheJTd1apHklVzUP1+uk1KDi13QWq4nddZo1zx+qrr+9cSQ59whPzoNZqkGl2SZIbNCmlcLBDdzXzqnE+X5YlF+YcMu0tNCKzIGbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JkEvfqwnZMVgg6Usk1ysbWZSP6CKih2RhEgc6iKNepw=;
 b=ZpOne+JysMb8RLzoDUdoZuWasAsCsYtAMgbLHLXc/zhmis7cMwLtIZDwnhCxX5MVsBoYRTZ8aXuzB6rODfyO8RROHpEbYyl+eWOl6OhTaDmQ+jo0Wry6h+QzioOUiCN4lZjxkDi9oLAhs3q8oCykbi1PSqZDrhfngPZE2fOECPwsH4W1vx//fwUbqo0fwdE69u42mD0ZiPXn6f/HSoJbGVsuLbNkUA4DZ1TOAidu7d4xMABNmzCBL3Zbr7f27LMIViSYGjM13sx4aSihfnSMhn4Lt0OdMvzkv6dGx42CUbwV9ZntSPBNjBgMYfLzairCh4EVVRaLkeEQF8PMr7OF7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JkEvfqwnZMVgg6Usk1ysbWZSP6CKih2RhEgc6iKNepw=;
 b=xsio53+4GnbWbRmCXESxIidtOzAjulKbA2ZwlNIskgllOQqs3TKOyrIIXLm8GGwQJ7l0UlDwmCIoM6ZDR5/1jKv/+1Dv3IpF7NB8whQObC8iox9j0qxrhOo4sRP6J9OAAq9/B0qbjcuS9kkNViji+1Q259ck7I2SeME2KhOokBU=
Received: from DM6PR06CA0057.namprd06.prod.outlook.com (2603:10b6:5:54::34) by
 DS0PR12MB7994.namprd12.prod.outlook.com (2603:10b6:8:149::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.28; Mon, 9 Oct 2023 15:21:42 +0000
Received: from DS1PEPF00017092.namprd03.prod.outlook.com
 (2603:10b6:5:54:cafe::fb) by DM6PR06CA0057.outlook.office365.com
 (2603:10b6:5:54::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38 via Frontend
 Transport; Mon, 9 Oct 2023 15:21:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017092.mail.protection.outlook.com (10.167.17.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Mon, 9 Oct 2023 15:21:42 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 9 Oct 2023 10:21:40 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH v2] drm/amdgpu: Address member 'gart_placement' not described
 in 'amdgpu_gmc_gart_location'
Date: Mon, 9 Oct 2023 20:51:22 +0530
Message-ID: <20231009152122.172858-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231009145933.164871-1-srinivasan.shanmugam@amd.com>
References: <20231009145933.164871-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017092:EE_|DS0PR12MB7994:EE_
X-MS-Office365-Filtering-Correlation-Id: 2533c205-e57c-43a8-e196-08dbc8db70f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZG+MGFkyCGowm5t362dN1H2/VwKEi2a3/OfbrKMSn3G13Njjhc1nPV5tEmJTCyunmcZu/xG0dgF/QWlA4QFP6u9OKI0vyLwXChdIXqJ2ylJGfR90GQU8MwR8LLwW4ZMrg+xqMrjQJ6AfFUy2HAhpYZNTLMa5xhZOioCc3OtJ7preWETSbT17YM8t1VZRqEdQwPfwm6rJJY4Pa4gFJhhNKkuRV1TrVGgQpXwEqO/YJVjEqz6CNnvkokjh1r8cr4cYEFmurJEN6McWj0e28cWCDvgT+oQPVU2Dm2Jnlhgb6uIhSppXwe8Z/nd6WFSvGaurE39rSqNPzibiuEYwpuEOT1JzuNKJDC/WrkICHV6VJbxD1yC5enmzxPK9ZYjM8CmAq476qvQbIjyem9ojXZrJXGDEP5EFs3amq3ryS/IcsUWlgvAx+YFd6sYMskfqvO3LhlJmIDb+o8S8qE1T83LT4jJjqqgf6w3s9XgPMDSrnztyQx/TXk36ZFGjKCYQfehb+mYhRzaXJnUx1oDcWzNtlEfpAAkwY98e5OC46J+OWvK7jR/h0JFcRQP/fvy1Txmlq5hVuKvyDeKb7cSW1I/gl2P9wa1eX1H+G08AosJiKKVjkvYGz2zb2U7N4iOGt3wt7BXKeMLHePCtIhByM+4gaS8i/uGMWNt8bp37ck8tcHL/9UZoZJGkHMQC3lnuRHsylaTbdUHuH6ZbKAtjMIc811bdp7eSEVJmHuIrc/+efkMKs7HPIbc93hHzM0xvDo97XU/5Wskj+yYBecY66xWoGQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(136003)(39860400002)(376002)(396003)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(82310400011)(46966006)(40470700004)(36840700001)(8676002)(26005)(8936002)(426003)(336012)(83380400001)(16526019)(66574015)(5660300002)(2616005)(4326008)(44832011)(7696005)(47076005)(1076003)(82740400003)(356005)(81166007)(36860700001)(40480700001)(6666004)(6636002)(316002)(54906003)(70586007)(41300700001)(70206006)(86362001)(36756003)(478600001)(110136005)(2906002)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 15:21:42.1093 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2533c205-e57c-43a8-e196-08dbc8db70f9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017092.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7994
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
Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fixes the below:
drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c:274: warning: Function parameter or member 'gart_placement' not described in 'amdgpu_gmc_gart_location'

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---

v2:
 - s/in/around

 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 60c81c3d29d5..47772f233a4d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -264,6 +264,7 @@ void amdgpu_gmc_sysvm_location(struct amdgpu_device *adev, struct amdgpu_gmc *mc
  *
  * @adev: amdgpu device structure holding all necessary information
  * @mc: memory controller structure holding memory information
+ * @gart_placement: GART placement region around VRAM
  *
  * Function will place try to place GART before or after VRAM.
  * If GART size is bigger than space left then we ajust GART size.
-- 
2.34.1

