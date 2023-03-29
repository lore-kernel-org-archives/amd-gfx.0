Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADF02C74A5B
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Mar 2023 20:18:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 279AB10E3BB;
	Wed, 29 Mar 2023 20:18:04 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2062.outbound.protection.outlook.com [40.107.93.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3546E10E3A1
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Mar 2023 20:18:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fMw4zmilvprimEF5nf/ktO3DTrq1jvNuw1RiX3d3eyMOFUvUr15fRfnw1+Ha3MSIHbZDoWg/TqJXByZ8O5zK2QlgpZYDd0JlKYabU3yBlueQL9eQ0D8cYa+kfMgjrD54sXzOvzBV5jRT7eAYgVKxfZjFzmuyDh+Nb0Fa5cnLE2+lWD/vxuV2OuvdNRR0B12kwOFJXEdtQfJjemFcfS2P8C8oh3Pph86/08Oq7ceAYiwcgofUT52/SOT0hGfNsXQ32KTgug32dkmV2oty9DIGp7nXlTX0B5A+F4jsGUDvqbIP+KHKjXfPLKgdq30POXyPCYABDlzzaxVmOPYqf7bbxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ulUOCB2hL8SZkY6GScn2ns58VvdCBDAC8sEyubQ/wR8=;
 b=FQRH5reu48lP2uAL4xi51b6yn2PZxWbvPL1HDyE0by7zYMXlP1wuo4IEFESvr5wyxncMcM+7C1xDaCEIlv3qD6Fa0lHxRg5tEdtw+23Yxe7y8rS9ZIJ2dQLIKfRMb0nbsYuw760ARXaOtxk/miAcFJeTFcaThuPtN5tqcirkjBL1GYgEvZYabEZKFmiic31TfmxShKcmTQMxMi+0t7Acb9yPNrwy73vL3hgZuOauJAv/Ui2Of2eTsKTsdCHNN+U4wCubYN+8WH0HmVEtqxs1iQerD/VpdDRCPEuhY+PAVnbXIeHBdGUAnjfK78wLU4eIVnWos/NlRdCCCTvBaR7LrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ulUOCB2hL8SZkY6GScn2ns58VvdCBDAC8sEyubQ/wR8=;
 b=VFfP1vmakmIYrGQqR5o1XrGpdwMjKK0lX59wQqxSvB+WDMpXDLW0gFh+aTO0dLsOhciKkrHt0xLYznB5MZsufLphserbQfwODJexqy2xutOhQjSoP+apFjdLCIXm8Z29ioMwnFT2qwLMCNytqtM5h5e5Oeqb4rXnlc3ymgErl7E=
Received: from BL0PR1501CA0016.namprd15.prod.outlook.com
 (2603:10b6:207:17::29) by DS0PR12MB6584.namprd12.prod.outlook.com
 (2603:10b6:8:d0::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.28; Wed, 29 Mar
 2023 20:18:00 +0000
Received: from BL02EPF000100D3.namprd05.prod.outlook.com
 (2603:10b6:207:17:cafe::66) by BL0PR1501CA0016.outlook.office365.com
 (2603:10b6:207:17::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20 via Frontend
 Transport; Wed, 29 Mar 2023 20:17:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF000100D3.mail.protection.outlook.com (10.167.241.207) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.30 via Frontend Transport; Wed, 29 Mar 2023 20:17:59 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 29 Mar
 2023 15:17:59 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/5] drm/amdgpu: Add IP instance map for aqua vanjaram
Date: Wed, 29 Mar 2023 16:17:41 -0400
Message-ID: <20230329201744.1982926-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230329201744.1982926-1-alexander.deucher@amd.com>
References: <20230329201744.1982926-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000100D3:EE_|DS0PR12MB6584:EE_
X-MS-Office365-Filtering-Correlation-Id: f02cf302-2982-4e3e-e272-08db3092b134
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bo4YFsQSOBjt76dpOk5qrLxbFQTWaCFs2m+HCiBavcAa2/IU1nmX2I0r6DlRaH6CN4YYLCcoIkdnfd7w7U2BQujpFIx5M1ZIXR2LWyLTbrp5qOyvIpHFy9IchPy4fgt9wLN3LSsL33AVrF5EZMbErPC3vS3D7uyaKvIvB9MEBpQSAU6TP3SYwswzfijugJ94znC7Bf5cZrs800WSJ57pTFk1lVNQJcbVGw208c4wKTdwydbpfIa91KcTKxNejUUBIHsDky4/s3JoLRWpQyWoCxVWn6B0GPEfLMv9zbBeNJn5AZX6pIGkzMHxiBtYT6dcthm3+5pNvY7zfAF+DBFxvMIpi7AleDMKBzpm/0KiiSfraJKE5CnZIZqO2DMOnz09nzcAjcmKOzgAUc1oyn7BFnyMkn0S8kFlHYZEpsGaQcT8sC8aJa/utdrWQbknHRaioddQ8yVgsCK4BKITy0CoFNZmqt3L8y+kYd1IvlanQ5aq+z74I8nGhNZf4kCa1ovRUOSWVoo8eXyQMUUESuSPf4hdCQaMEoYa/9iTgzOSTbZRRFLPIKZfED2g+vo1MFl3QlsKqFfjzli8xi+dP7UUn8TmTUmujAE5JHcsyl9x5jvsygAPSrS59n0x4OPtwAQFuQ1/eZ0H9tR2T84XI2Ukm0XozLK50EKfQDUyy96pQVB0Rc/4asm6IiPxbsTcJgrcdIuzFoNjLe7ilwVOat4zdU4YeFZluMihLRqGVF3Q0t8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(39860400002)(396003)(376002)(136003)(451199021)(40470700004)(46966006)(36840700001)(8936002)(47076005)(2906002)(336012)(83380400001)(426003)(2616005)(41300700001)(86362001)(36860700001)(36756003)(40460700003)(82740400003)(5660300002)(81166007)(356005)(40480700001)(478600001)(7696005)(8676002)(54906003)(6916009)(70206006)(70586007)(4326008)(16526019)(6666004)(186003)(82310400005)(1076003)(26005)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 20:17:59.8978 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f02cf302-2982-4e3e-e272-08db3092b134
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000100D3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6584
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Le Ma <Le.Ma@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>, Lijo Lazar <lijo.lazar@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Lijo Lazar <lijo.lazar@amd.com>

Add XCC logical to physical instance map for aqua vanjaram

v2:
	Keep look up table only for required IPs, for others return
default mapping (Felix).

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Le Ma <Le.Ma@amd.com>
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 13 +++++++
 .../drm/amd/amdgpu/aqua_vanjaram_reg_init.c   | 39 +++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/soc15.h            |  1 +
 3 files changed, 53 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 0ecce0b92b82..f5d146c998a1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -2000,6 +2000,17 @@ static int amdgpu_discovery_set_mes_ip_blocks(struct amdgpu_device *adev)
 	return 0;
 }
 
+static void amdgpu_discovery_ip_map_init(struct amdgpu_device *adev)
+{
+	switch (adev->ip_versions[GC_HWIP][0]) {
+	case IP_VERSION(9, 4, 3):
+		aqua_vanjaram_ip_map_init(adev);
+		break;
+	default:
+		break;
+	}
+}
+
 int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 {
 	int r;
@@ -2177,6 +2188,8 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 		break;
 	}
 
+	amdgpu_discovery_ip_map_init(adev);
+
 	switch (adev->ip_versions[GC_HWIP][0]) {
 	case IP_VERSION(9, 0, 1):
 	case IP_VERSION(9, 2, 1):
diff --git a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram_reg_init.c b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram_reg_init.c
index 3b97bc922d4a..dbff8220fc19 100644
--- a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram_reg_init.c
+++ b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram_reg_init.c
@@ -50,3 +50,42 @@ void aqua_vanjaram_doorbell_index_init(struct amdgpu_device *adev)
 
 	adev->doorbell_index.max_assignment = AMDGPU_DOORBELL_LAYOUT1_MAX_ASSIGNMENT << 1;
 }
+
+static int8_t aqua_vanjaram_logical_to_dev_inst(struct amdgpu_device *adev,
+					 enum amd_hw_ip_block_type block,
+					 int8_t inst)
+{
+	int8_t dev_inst;
+
+	switch (block) {
+	case GC_HWIP:
+		dev_inst = adev->ip_map.dev_inst[block][inst];
+		break;
+	default:
+		/* For rest of the IPs, no look up required.
+		 * Assume 'logical instance == physical instance' for all configs. */
+		dev_inst = inst;
+		break;
+	}
+
+	return dev_inst;
+}
+
+void aqua_vanjaram_ip_map_init(struct amdgpu_device *adev)
+{
+	int xcc_mask;
+	int l, i;
+
+	/* Map GC instances */
+	l = 0;
+	xcc_mask = adev->gfx.xcc_mask;
+	while (xcc_mask) {
+		i = ffs(xcc_mask) - 1;
+		adev->ip_map.dev_inst[GC_HWIP][l++] = i;
+		xcc_mask &= ~(1 << i);
+	}
+	for (; l < HWIP_MAX_INSTANCE; l++)
+		adev->ip_map.dev_inst[GC_HWIP][l] = -1;
+
+	adev->ip_map.logical_to_dev_inst = aqua_vanjaram_logical_to_dev_inst;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.h b/drivers/gpu/drm/amd/amdgpu/soc15.h
index 2b41ee968dd1..d8a2a6c2c6e3 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.h
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.h
@@ -111,6 +111,7 @@ int vega10_reg_base_init(struct amdgpu_device *adev);
 int vega20_reg_base_init(struct amdgpu_device *adev);
 int arct_reg_base_init(struct amdgpu_device *adev);
 int aldebaran_reg_base_init(struct amdgpu_device *adev);
+void aqua_vanjaram_ip_map_init(struct amdgpu_device *adev);
 
 void vega10_doorbell_index_init(struct amdgpu_device *adev);
 void vega20_doorbell_index_init(struct amdgpu_device *adev);
-- 
2.39.2

