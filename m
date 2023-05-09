Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E07AC7EE2A
	for <amd-gfx@archiver.kernel.org>; Tue,  9 May 2023 22:14:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5FCC310E419;
	Tue,  9 May 2023 22:14:36 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20618.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::618])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 611D010E3EB
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 May 2023 22:14:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CqciY0pMcjT2oM1S/E8p+DLm7LT5qkDvO/xaus/hvKZlbIEMxObn4FkYDpwd4lTGOMREW/md4GX0EMj3Oe1hz7fBgHgK1jO10o2eTsgRQh9PYVBx3FWBxf90bxWz70KpCav+67VjpG2bKYYMqM39AINpNElyfIIbXkeqNeJ1DCHbnusziG+WBPgU3sxGAikkLLEtGeDSnnQZxtKC47wS1vhEaLpAzciuh92cmmuBSMjMZnpSfPEyx/SB8NffuR4NR8Q7C1dSdAWl3V1MGjxQoByGzNfin/5qx16/liV0a+s7O95p5XqZRXtH2vGXFjcCWjUf3gM7vkKgrXA2vOksJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+WZkOMPQRU3DzS92/2j+OjNfJ9MZFoIn3JkTmzcU0vE=;
 b=XO6KXLIF9OI57hlPWHmLR9OWWbPww5Em5PQLCDUrQpblSyfaTV0XabyupsS+p/gfgJJk4HacZeC0xYBiLNp14Yq78WWhRUIR60Ud5yHcGS3bb+MWZSI1b46EeG9IvaATnLyuf0bksz5041jY1jSFNM9M5yPTre3O4dpYubwFZilsHmn8cxGHBkN4Qw53OoItV4ZdK48xUcetM664qWTZXmN9a6mKu4BxFl/gesKVqH7lDkmF2CTPQIgHgytLzCs1JmTSA6atb6LuuHJQt29KYUpIoE23dK3RWpgh/e8HgicmX5oOIGm5JfAHBZO9bpzao9KQ1LI70h54OMFB3EZvIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+WZkOMPQRU3DzS92/2j+OjNfJ9MZFoIn3JkTmzcU0vE=;
 b=Nwjv+Opu/jWNf2civbuZ2KZ0s1UV+QF991sIuwSf6lAZ3Ku+MGTg4x0mnmeEk2UbqQCFlht4gI00Mj0clZQBqDybGfZdMEzdgNWqQ0+H4VdZuRPWiDN2cgIOqYQIw8e2Z9mOQRd6Pi36hcX9Wft6o1YohqMtgFMZFtHnSdneor0=
Received: from BN9PR03CA0031.namprd03.prod.outlook.com (2603:10b6:408:fb::6)
 by BL0PR12MB4945.namprd12.prod.outlook.com (2603:10b6:208:1c4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Tue, 9 May
 2023 22:14:28 +0000
Received: from BN8NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fb:cafe::e5) by BN9PR03CA0031.outlook.office365.com
 (2603:10b6:408:fb::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.18 via Frontend
 Transport; Tue, 9 May 2023 22:14:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT041.mail.protection.outlook.com (10.13.177.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6387.18 via Frontend Transport; Tue, 9 May 2023 22:14:28 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 9 May
 2023 17:14:26 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 09/14] drm/amdgpu: Fill xcp mem node in aquavanjaram
Date: Tue, 9 May 2023 18:14:03 -0400
Message-ID: <20230509221408.476829-9-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230509221408.476829-1-alexander.deucher@amd.com>
References: <20230509221408.476829-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT041:EE_|BL0PR12MB4945:EE_
X-MS-Office365-Filtering-Correlation-Id: c2416f84-13a4-41f0-19f2-08db50dac1d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jbmwH1zPce9GZORl+eQxJ0fLYqeBmbcFvuis9u2wRO/RP7Gkfc3/vaLYAx8bH6YwtTaqTvrsPynjnM5G6JY++2FKZ5O2dDL3B3CFQ9J+owvO4PJ0AzFJunlQKrh08glbcHLQOYgYFkgN0vrJxITKb4z2UyHVpnMzTKxXjKJ45QJiVMtkbMg4YsBLOSya3h96BxQwTAN16obkr3kvm3C7U74Ms0kPHr3EWmSr11VvyEHID6UVedXzwwI0ZAs35m+DS+CpRTibGn+RoWTA9C59UDYvt1m7qBzSZuITCK3qxSzPnKiKDxxMNlS7e9Hn7MS9o+SJ1G/UFiGlZcu0wUHhZP6BrFls5pWFN6G61fBbQ4ERlLqkyVmnrN/CZlOXDRYyMxqxG8sVqB6K5myeLxdGL6FmjZmi4c9m9eBIFsu2inXLV0eU1xUebzk9QKPyHq5HwHtUBPBffmqKLJuTr7/J+2TjwpfCEN0VeG73smzTKFpWgWstzaRolvOtYMY7k6bN9LpizTfoa/ASguzX1WSuaKTc5XKnfkC4Pycxq8z7VZ8z1gzKxTq37BXSzM9kbWt0ySEFgQCGgL/5zpIzJ9TRRZIoMen1ZgPe7M99DjCGPmegmolja2Spg7iJMY/uN/698ZbYop/lntejDOX92r17PGNbgGHGix4tpMAtC3DvkqifiZIVOOYClmNWs2QuShEovubOfibc0KiEcCSpqTw86sSw6mHpHCD3yhYmK7KORcg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(39860400002)(396003)(136003)(346002)(451199021)(46966006)(40470700004)(36840700001)(7696005)(2906002)(2616005)(186003)(478600001)(40460700003)(16526019)(36756003)(6666004)(40480700001)(41300700001)(1076003)(26005)(316002)(356005)(82740400003)(81166007)(54906003)(47076005)(83380400001)(70586007)(6916009)(4326008)(70206006)(82310400005)(36860700001)(5660300002)(8936002)(336012)(426003)(86362001)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2023 22:14:28.7518 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c2416f84-13a4-41f0-19f2-08db50dac1d3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4945
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Le Ma <le.ma@amd.com>,
 Lijo Lazar <lijo.lazar@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Lijo Lazar <lijo.lazar@amd.com>

Implement callbacks to fill memory node information in aquavanjaram.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Le Ma <le.ma@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../drm/amd/amdgpu/aqua_vanjaram_reg_init.c   | 61 ++++++++++++++++++-
 1 file changed, 60 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram_reg_init.c b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram_reg_init.c
index 68d732dd9ecb..aa1bb7883158 100644
--- a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram_reg_init.c
+++ b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram_reg_init.c
@@ -331,6 +331,64 @@ static int aqua_vanjaram_switch_partition_mode(struct amdgpu_xcp_mgr *xcp_mgr,
 	return ret;
 }
 
+static int __aqua_vanjaram_get_xcp_mem_id(struct amdgpu_device *adev,
+					  int xcc_id, uint8_t *mem_id)
+{
+	/* TODO: Check if any validation is required based on current
+	 * memory/spatial modes
+	 */
+	*mem_id = xcc_id / adev->gfx.num_xcc_per_xcp;
+
+	return 0;
+}
+
+static int aqua_vanjaram_get_xcp_mem_id(struct amdgpu_xcp_mgr *xcp_mgr,
+					struct amdgpu_xcp *xcp, uint8_t *mem_id)
+{
+	struct amdgpu_numa_info numa_info;
+	struct amdgpu_device *adev;
+	uint32_t xcc_mask;
+	int r, i, xcc_id;
+
+	adev = xcp_mgr->adev;
+	/* TODO: BIOS is not returning the right info now
+	 * Check on this later
+	 */
+	/*
+	if (adev->gmc.gmc_funcs->query_mem_partition_mode)
+		mode = adev->gmc.gmc_funcs->query_mem_partition_mode(adev);
+	*/
+	if (adev->gmc.num_mem_partitions == 1) {
+		/* Only one range */
+		*mem_id = 0;
+		return 0;
+	}
+
+	r = amdgpu_xcp_get_inst_details(xcp, AMDGPU_XCP_GFX, &xcc_mask);
+	if (r || !xcc_mask)
+		return -EINVAL;
+
+	xcc_id = ffs(xcc_mask) - 1;
+	if (!adev->gmc.is_app_apu)
+		return __aqua_vanjaram_get_xcp_mem_id(adev, xcc_id, mem_id);
+
+	r = amdgpu_acpi_get_mem_info(adev, xcc_id, &numa_info);
+
+	if (r)
+		return r;
+
+	r = -EINVAL;
+	for (i = 0; i < adev->gmc.num_mem_partitions; ++i) {
+		if (adev->gmc.mem_partitions[i].numa.node == numa_info.nid) {
+			*mem_id = i;
+			r = 0;
+			break;
+		}
+	}
+
+	return r;
+}
+
 int aqua_vanjaram_get_xcp_ip_details(struct amdgpu_xcp_mgr *xcp_mgr, int xcp_id,
 				     enum AMDGPU_XCP_IP_BLOCK ip_id,
 				     struct amdgpu_xcp_ip *ip)
@@ -344,7 +402,8 @@ int aqua_vanjaram_get_xcp_ip_details(struct amdgpu_xcp_mgr *xcp_mgr, int xcp_id,
 struct amdgpu_xcp_mgr_funcs aqua_vanjaram_xcp_funcs = {
 	.switch_partition_mode = &aqua_vanjaram_switch_partition_mode,
 	.query_partition_mode = &aqua_vanjaram_query_partition_mode,
-	.get_ip_details = &aqua_vanjaram_get_xcp_ip_details
+	.get_ip_details = &aqua_vanjaram_get_xcp_ip_details,
+	.get_xcp_mem_id = &aqua_vanjaram_get_xcp_mem_id
 };
 
 static int aqua_vanjaram_xcp_mgr_init(struct amdgpu_device *adev)
-- 
2.40.1

