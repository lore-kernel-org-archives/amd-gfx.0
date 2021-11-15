Return-Path: <SRS0=ctnh=QC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0030C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Nov 2021 02:52:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C79D613BD
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Nov 2021 02:52:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8C79D613BD
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E75D489C2A;
	Mon, 15 Nov 2021 02:52:03 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2041.outbound.protection.outlook.com [40.107.223.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D43A89C2A
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Nov 2021 02:52:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TaosQGGw48Uf/UCqqruvtxyoXCK3NQdS4CnyVNIj0t82Wy74GG5byl6s9pI2o5Kf2p0y+t9Heh3YV6JSkF96rdfSdpm0oRIPYufzNb3mNGKkM9LCanAV0W5ja6mHD8PO0AIzdEypOAuvGfHTHqBdVF6X+qekvDWIAT7FAFFBPHfyWPPrV+TyWxh829BQdMm9Z0tjDtPHI26WhMQxKzYRC4zv0dIowoWmnVKLa8PT5qMLGfaS0JeF00tHBY3ze0chaUmJzpfgoq2I34Dyc1BkXAb8auNrEU3xzjgxYBWgW+X2QmJyyznp11LZOWQBOoXAvdBWMzqId/RUle1FVf4NZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W0FhO2pEouTRqRvZxLCYlolaMO925VlOttK82K1m2Sk=;
 b=e4ZCjWXRk7Qsfu87xtzoshlDEjuBkE/PKFaab/5/hvRNCQAxqN08xgXzm5KmsGkk8DF8fAQipa67ZZToW2UyoNaFj0hzvqDNbc/O1tOA4uSCOUovozo83f12W4rXBm5zUxjzPQHPdZwo0FCNHWHBnduDTqWuuff6wrWO6iV+oxHFOShzyWuEu6oK/TkeiBkSrb96FsNcGueTRm7hEH8DF2GCyvc2k8m6jKKKhlxRmGZ7XYEhrl6BHiVY3ULfKVj4jIXxabkCeQmfSHMC8cLOwoL2GAV6R1lo2+bT0HYI8VOGeiWTsBbu924Dq/L05aroX6ogpDo30GJolp3LXwZEhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W0FhO2pEouTRqRvZxLCYlolaMO925VlOttK82K1m2Sk=;
 b=d6+oUtHV4PdEY6FddrAN5MxSs53bCSIFK3eLhGsiCzS1prxYfKUSWavvRZCzcXLHS1COCKWvG8si4032PYBrkGA6XiIWisV/xUnhhqjMo3nxSPAC0iq5N+OqG+IKdeLYLQh8XrFzNNZhFc5XbwpQZqgyHJxggDfsDxq3Ux/j0cw=
Received: from CO2PR04CA0198.namprd04.prod.outlook.com (2603:10b6:104:5::28)
 by CH0PR12MB5043.namprd12.prod.outlook.com (2603:10b6:610:e2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.27; Mon, 15 Nov
 2021 02:52:01 +0000
Received: from CO1NAM11FT061.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:5:cafe::6b) by CO2PR04CA0198.outlook.office365.com
 (2603:10b6:104:5::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.19 via Frontend
 Transport; Mon, 15 Nov 2021 02:52:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT061.mail.protection.outlook.com (10.13.175.200) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4690.15 via Frontend Transport; Mon, 15 Nov 2021 02:52:00 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Sun, 14 Nov
 2021 20:51:55 -0600
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V3] drm/amd/pm: avoid duplicate powergate/ungate setting
Date: Mon, 15 Nov 2021 10:51:37 +0800
Message-ID: <20211115025137.639014-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1513609a-0042-4be0-fc0d-08d9a7e2e555
X-MS-TrafficTypeDiagnostic: CH0PR12MB5043:
X-Microsoft-Antispam-PRVS: <CH0PR12MB50438EFCBE343460EAD9298FE4989@CH0PR12MB5043.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:93;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cz8sSEJigV1FMncla0+1A70G3gkmelk6ZElDV/+5YpPYxRpMzpVJV0p2Z4o0R4zblE3SzlWx5mrVjVkPoX3TtpKW/OWNCbaJP3cgg1FP2cbf0wElcxV5kPNW/kjWyz0exOHtCEdvEvzSSBNAEdJccMAQjqLX9i2lEJ03duapqZ5i4jZaPfJbWZ6E1DWiT+jrnQ74E10lytFleM1imAbXdATbmJpx/HD8od9+Kx9qE62CX0xCJKQITaW2uVx+DxM/xfqF0tUBdYDNy4XehkcR6dEgbAEw1p+G34qbKJW+CO/nyZYzDXdfnrzVfnYjURGRPWr9Go5xtX/Qpg+hKa2Mx2lx9Vf/GrwJ+u/EBdNsXs1+KrqOI3uwAQdYWT+rmkoMGMX+dEaX+0RheRToZ8Z8e2KqIcdNUEcRAgQorI148zKAPxXU2p2nHW82abDOl7cRe9s+X71oYzgGE52gE/TNOi/ag27HuuCXomxrG2zRWEKGaRdZ+IaSb4mtO66Fz6IECKSGRtqjdcFeAm1HvrR53E+9fctKMrJm7/3+pvbwU3ro9yjDYYZiRHoDXrgo5BWkBnVO746FneEzhTn5417PoaCRdJH39w/R4UpAJLREKlu2Y9eC9SSmTj3aSp1YrsupM1uQWOwq9ffeHGL6jiM0S3sIp3Z5AehavHdII0XXbRs6JriLHQWJA//5l6QwDxhbhOQqhPdIewowgS57k6eb1MKqHU/oB3aRv6WE6znoTaIIYUsByxloytriIMHgijdFLnSSWxtfVaZDanD1fperNebK6NE5HB6Hday48YpPJRkfpwaAzcxaTfK9SuznQdzu
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(316002)(83380400001)(36860700001)(8676002)(6666004)(70206006)(6916009)(81166007)(16526019)(70586007)(44832011)(82310400003)(4326008)(508600001)(356005)(5660300002)(186003)(966005)(47076005)(8936002)(1076003)(26005)(2616005)(86362001)(2906002)(426003)(36756003)(336012)(54906003)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2021 02:52:00.0131 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1513609a-0042-4be0-fc0d-08d9a7e2e555
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT061.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5043
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
Cc: Alexander.Deucher@amd.com, Lijo.Lazar@amd.com, Borislav Petkov <bp@suse.de>,
 Evan Quan <evan.quan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Just bail out if the target IP block is already in the desired
powergate/ungate state. This can avoid some duplicate settings
which sometimes may cause unexpected issues.

Link: https://lore.kernel.org/all/YV81vidWQLWvATMM@zn.tnic/

Change-Id: I66346c69f121df0f5ee20182451313ae4fda2d04
Signed-off-by: Evan Quan <evan.quan@amd.com>
Tested-by: Borislav Petkov <bp@suse.de>
--
v1->v2:
  - typo fix and add link for the issue referred in commit
    message(Paul/Boris)
  - update the data type to uint32_t(Paul)
  - better Macro naming(Lijo)
v2->v3:
  - stick to original logics on handling unmentioned IP blocks(Lijo)
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  3 +++
 drivers/gpu/drm/amd/include/amd_shared.h   |  3 ++-
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c        | 10 ++++++++++
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h    |  8 ++++++++
 4 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 0bd90ec9e43e..fca592394fa1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3508,6 +3508,9 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 		adev->rmmio_size = pci_resource_len(adev->pdev, 2);
 	}
 
+	for (i = 0; i < AMD_IP_BLOCK_TYPE_NUM; i++)
+		atomic_set(&adev->pm.pwr_state[i], POWER_STATE_UNKNOWN);
+
 	adev->rmmio = ioremap(adev->rmmio_base, adev->rmmio_size);
 	if (adev->rmmio == NULL) {
 		return -ENOMEM;
diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd/include/amd_shared.h
index f1a46d16f7ea..4b9e68a79f06 100644
--- a/drivers/gpu/drm/amd/include/amd_shared.h
+++ b/drivers/gpu/drm/amd/include/amd_shared.h
@@ -98,7 +98,8 @@ enum amd_ip_block_type {
 	AMD_IP_BLOCK_TYPE_ACP,
 	AMD_IP_BLOCK_TYPE_VCN,
 	AMD_IP_BLOCK_TYPE_MES,
-	AMD_IP_BLOCK_TYPE_JPEG
+	AMD_IP_BLOCK_TYPE_JPEG,
+	AMD_IP_BLOCK_TYPE_NUM,
 };
 
 enum amd_clockgating_state {
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
index 03581d5b1836..08362d506534 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -927,6 +927,13 @@ int amdgpu_dpm_set_powergating_by_smu(struct amdgpu_device *adev, uint32_t block
 {
 	int ret = 0;
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
+	enum ip_power_state pwr_state = gate ? POWER_STATE_OFF : POWER_STATE_ON;
+
+	if (atomic_read(&adev->pm.pwr_state[block_type]) == pwr_state) {
+		dev_dbg(adev->dev, "IP block%d already in the target %s state!",
+				block_type, gate ? "gate" : "ungate");
+		return 0;
+	}
 
 	switch (block_type) {
 	case AMD_IP_BLOCK_TYPE_UVD:
@@ -979,6 +986,9 @@ int amdgpu_dpm_set_powergating_by_smu(struct amdgpu_device *adev, uint32_t block
 		break;
 	}
 
+	if (!ret)
+		atomic_set(&adev->pm.pwr_state[block_type], pwr_state);
+
 	return ret;
 }
 
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
index 98f1b3d8c1d5..16e3f72d31b9 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
@@ -417,6 +417,12 @@ struct amdgpu_dpm {
 	enum amd_dpm_forced_level forced_level;
 };
 
+enum ip_power_state {
+	POWER_STATE_UNKNOWN,
+	POWER_STATE_ON,
+	POWER_STATE_OFF,
+};
+
 struct amdgpu_pm {
 	struct mutex		mutex;
 	u32                     current_sclk;
@@ -452,6 +458,8 @@ struct amdgpu_pm {
 	struct i2c_adapter smu_i2c;
 	struct mutex		smu_i2c_mutex;
 	struct list_head	pm_attr_list;
+
+	atomic_t		pwr_state[AMD_IP_BLOCK_TYPE_NUM];
 };
 
 #define R600_SSTU_DFLT                               0
-- 
2.29.0

