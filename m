Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFC02C48BC4
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Feb 2024 12:59:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4BBFC10EB2A;
	Fri, 16 Feb 2024 12:59:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CHgpOwMo";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2042.outbound.protection.outlook.com [40.107.94.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8174210E875
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Feb 2024 12:59:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gzTYK32UCXNgvp8hxaHUB9cOKLsxJfP+bC5saz3y6EoZyooF9jvR5yMo+xCIqYadC7mk2L/OkdJEuvqHRVebwg27ZMrQuwWiIQXKXhQF6GIoZ9iYzL3o5syvJ1n9hyQpL5oOgMyIXq0MdAIrhU0fNtUX9lgfagXv9jEChAVRkeqvNZd6xA/6ZaKQG6iyKzhBUaoT7wurHa4aJ91CqWRtKXHlZZrmbGfKuXR/DTjBfCtcSxujH0N9vNdgWSCt7YSktDBtqf0btvYDXMOMY28Lilgs6+bAbcPcAwlaj7ppJe4F4I7xgLyKTtf9itCW79kvxTV44UDrUBxUaZluhMp8jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wNArB9AQ6XBkXs93rdnz+VCH19FlXy3GJI4rerpB0jY=;
 b=i2dv4BcAw0KhZUKKuFNdmOk2Z8DP7HET2Z1OA0RsSo3aqZQwWYS2/eTDmtKdT2rve1t07LxS+0jCe/GlQwub0qQYQcg9tm0NfJrM6hUylW2WbIgD1nAKKBwTAusKVJBE1TxshfcfVwhv84UXKka6ui/JXB/bm4JE98413jYCobvPbO4CN9GDJL9jhWRPqR8RTwyLjzwRXnORCVDW/VG3ZApo68V3rhD29t21BSUn6F22iLWR76UMJ1I53K8xtBrxaHUk76oe6LFaz6GNyjnJHja2k0C1Stxt7UBfL9/UAPSQrxY6kdbcSqZ3fmcv0rskCdlAdHF870MqDnGwDVC/OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wNArB9AQ6XBkXs93rdnz+VCH19FlXy3GJI4rerpB0jY=;
 b=CHgpOwMoiXdYngfG/1DiUHlD00UL5YAbTWx5CY9H8BJ+AzUsEoHt2RjX00wBOjd3M1eDUx3RjpnGRgvXcyoIInY5eDmq4weKn7jjn/g7PXWp1iE6cgbaY3etgcmZU8Qu05l6/CmcwSjaXuOe2Wg77D6Mh37pxf7tezukYqBY5EE=
Received: from BN0PR04CA0009.namprd04.prod.outlook.com (2603:10b6:408:ee::14)
 by BL0PR12MB4913.namprd12.prod.outlook.com (2603:10b6:208:1c7::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.12; Fri, 16 Feb
 2024 12:59:46 +0000
Received: from BN3PEPF0000B075.namprd04.prod.outlook.com
 (2603:10b6:408:ee:cafe::4c) by BN0PR04CA0009.outlook.office365.com
 (2603:10b6:408:ee::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39 via Frontend
 Transport; Fri, 16 Feb 2024 12:59:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B075.mail.protection.outlook.com (10.167.243.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Fri, 16 Feb 2024 12:59:46 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 16 Feb
 2024 06:59:44 -0600
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <lijo.lazar@amd.com>, <hawking.zhang@amd.com>, <le.ma@amd.com>,
 <shiwu.zhang@amd.com>, <asad.kamal@amd.com>
Subject: [PATCH 3/3] drm/amdgpu: Remove pcie bw sys entry
Date: Fri, 16 Feb 2024 20:59:26 +0800
Message-ID: <20240216125927.1821169-3-asad.kamal@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240216125927.1821169-1-asad.kamal@amd.com>
References: <20240216125927.1821169-1-asad.kamal@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B075:EE_|BL0PR12MB4913:EE_
X-MS-Office365-Filtering-Correlation-Id: b9ef4ce4-4d65-4ef6-0e5e-08dc2eef26cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9XSUYiVXbkAWkWwaDvC318riU/mpJG+lhXwE7A4LIUlvujzYZGLKvIRN7dlDnsz9/0c9yq7F86H//NL5SmbDJc2jqhBCz08Und2K7rlvAzn0NzEsTR7Uf8FHpr+Wj2YFcNRlXPtSbvBfrtUKya1dVPXanjiai5OX2GlUtBnKq2w8lWmfbldw05Rb1yT784dhSmoxwoSOlLB2RjRP5tlgpIsuArGohs0/l+Ca2jIMuTLVuzFuGHrQD6oSXjsqxw3z0FzH7/+H3gulvGI7aDpAbole1yPKAmnXxwSg28lJAHAaUs+GgxV9XYLxgQCt71DfFe/maJdwslTLJmYKrmGCIebsCVlbxtQ6mkWrLBlf6zhrCZTO816qbltbGFcUI6yngr1U9+GuZ96FxHj+/N8suQ54HnCkUSDNwzuSlKe9IA8j8VUxoIr6YGq7l/zkkcB8HmFrYAvU1Uv7DwMEbYymDOonFTS3Ew/+zRYojJWIwybiDmLIMJwzKI8I2ejztIml/UPzIbQeXqO62iDujjdHa9eKpHx4EZO+VOzT0xnDPGdDY+33xrHJGDSW+GxX1l7P68j+JPQw3PSHoQFZ/r4RkFVbrVLy/1Pk3hbM3I/I3MOtgF173P0rSkQvX3fx9yn5huzNrLpTnBMfyLICI5YSD9QXHu1it3R/A6OO9ycsB+k=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(39850400004)(376002)(396003)(136003)(230922051799003)(1800799012)(451199024)(186009)(82310400011)(64100799003)(36860700004)(46966006)(40470700004)(5660300002)(81166007)(44832011)(82740400003)(2906002)(70206006)(70586007)(6916009)(8936002)(8676002)(4326008)(356005)(86362001)(478600001)(41300700001)(2616005)(16526019)(1076003)(26005)(336012)(426003)(316002)(6666004)(54906003)(36756003)(83380400001)(7696005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2024 12:59:46.2464 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b9ef4ce4-4d65-4ef6-0e5e-08dc2eef26cf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B075.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4913
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

Remove pcie bw sys entry for asics not supporting
such function

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc15.c | 1 -
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 3 ++-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index 7fc55e3262eb..20a4582885cc 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -895,7 +895,6 @@ static const struct amdgpu_asic_funcs aqua_vanjaram_asic_funcs =
 	.get_config_memsize = &soc15_get_config_memsize,
 	.need_full_reset = &soc15_need_full_reset,
 	.init_doorbell_index = &aqua_vanjaram_doorbell_index_init,
-	.get_pcie_usage = &vega20_get_pcie_usage,
 	.need_reset_on_init = &soc15_need_reset_on_init,
 	.get_pcie_replay_count = &amdgpu_nbio_get_pcie_replay_count,
 	.supports_baco = &soc15_supports_baco,
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 087d57850304..1ff7fc821871 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -2174,7 +2174,8 @@ static int default_attr_update(struct amdgpu_device *adev, struct amdgpu_device_
 			*states = ATTR_STATE_UNSUPPORTED;
 	} else if (DEVICE_ATTR_IS(pcie_bw)) {
 		/* PCIe Perf counters won't work on APU nodes */
-		if (adev->flags & AMD_IS_APU)
+		if (adev->flags & AMD_IS_APU ||
+		    !adev->asic_funcs->get_pcie_usage)
 			*states = ATTR_STATE_UNSUPPORTED;
 	} else if (DEVICE_ATTR_IS(unique_id)) {
 		switch (gc_ver) {
-- 
2.42.0

