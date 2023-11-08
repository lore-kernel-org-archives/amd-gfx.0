Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7940C4332F
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Nov 2023 04:17:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 61C7110E382;
	Wed,  8 Nov 2023 04:17:38 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2051.outbound.protection.outlook.com [40.107.100.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1927E10E382
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Nov 2023 04:17:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tptd6fdSuLRo6rK5fgotRN37uFJTA51rFx9zCeFtsNG5bTKxJCFWZyGX8o6OMjr7CzufDcYOXOYkVXffQNmuDmvZt+PqoZuxL0Wbc9YX1nEK3a0OKbyh3y38LnEQEInjte8oVscjvF1tU+zACpACW8yF4FrlqgiG+cOvelkPRfBWR2bCmRRQ+THjLyDDhckRJIPHeTt0FHpOsZmDS3s7JErsGNU9ORE4kjA1rtclR/QytnjTHPn8xK8i4XOkQFLLec1mAA3Ydg3mTQq0y4RevdSBu6NQYfQkysTVCilw5t78l8CBYABU15/cuc/JukiBmxOuiHTyS7bQYWUr0YRV8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yVduEHarPli1gShXIlfuH+rQ/II1f5NVSGV24EpcJa4=;
 b=UlliaQCPgx+7vsbJt8b9R+hFoczy0R7mO3f0uJ8dY67zC/ZATYqVQ8xvFvTz5VRwtwiQcxDSAhnVWdDkcwb5gHafS8o/WOpXiv6XEnv46u+Pi43tpVsqDQp7Rcqw1qqqG5/wL1shYe+jPFeX6ho0lXxKIFfB0HwHw7Sh+ay1gyP7j2DC8ohAnBRC6p3eQwG1JiKHgdfrfPtq0RostoPDcS45Bm+bntSISToXXLmOQ0DnD8MBMUkXdJZQYqNKLS2Ne/AguMnE8GVhkolv5sPQYHZk2Cs4Deeejpm5nHBNAvfrp1U23zEDFpFwJcfMKatdvfsytf4Ef7uuUlZ0NGma4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yVduEHarPli1gShXIlfuH+rQ/II1f5NVSGV24EpcJa4=;
 b=Y27eJZnRCiBHx2gczws6hLYnItndalc0UufEPAcv+33hB+BwG9WLxIUCJWJWNCZwydUFkq5FnwW7t7gh7LrLL7yTHS1kj+o8yAlZoMj/3qgqhObSQpcK4rZ2duzy1TPr73AogwVfJLvsMzMOyuewasd9YtBRRezwIAuqZdSGfrw=
Received: from DS7PR03CA0041.namprd03.prod.outlook.com (2603:10b6:5:3b5::16)
 by DM8PR12MB5416.namprd12.prod.outlook.com (2603:10b6:8:28::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29; Wed, 8 Nov
 2023 04:17:33 +0000
Received: from DS1PEPF00017090.namprd03.prod.outlook.com
 (2603:10b6:5:3b5:cafe::d9) by DS7PR03CA0041.outlook.office365.com
 (2603:10b6:5:3b5::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29 via Frontend
 Transport; Wed, 8 Nov 2023 04:17:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017090.mail.protection.outlook.com (10.167.17.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6977.16 via Frontend Transport; Wed, 8 Nov 2023 04:17:33 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Tue, 7 Nov
 2023 22:17:31 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/6] drm/amdgpu: Add reg_state sysfs attribute
Date: Wed, 8 Nov 2023 09:47:01 +0530
Message-ID: <20231108041705.528194-2-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231108041705.528194-1-lijo.lazar@amd.com>
References: <20231108041705.528194-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017090:EE_|DM8PR12MB5416:EE_
X-MS-Office365-Filtering-Correlation-Id: 24e32990-6f9d-40b9-2cc5-08dbe011a18d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WRW9OL+UuoFrSTfgf6BH9zo3BtIpKuSDRAn7Xo/GNOw9IJhYn1Q2/RLzEXFgX2GkoMUzmlD7aECFR0kyNZHaQjC081eMKnNmds9UqqOW5n5iAYNWY41myCXesqwx//I1Eum6DAYBrLxSCcnd4L2MpkBweO5feDeE8JmdB/a4Wp8av7u+G7VfbTz2luQpCIHurZ8hFY4Xhkri/HR7JOZSUogET7jlXyYvZavnTHXz6uXkpNtv+UmDKIIfM8oO0BL5/7CVFKSM6wt/eU2P0/IV5GodlOD+YX0DvNFIALTxJCtQfoCTd69AMkO5mtb7h62yGkLWj3tiRwvcIhIN4zH4gSdI4GbmQEzZBCJzBosmrmIIbLokUgNf2mFTS+sCXBSmL4+QV0ylG0TXEavoVOIapbWz5r6EGIV3HMzEk2+Ce81iMHt+DLkdod077UHAyP41dde30hCGN+E0cg0oijUBdj8ZYociEEntkEODl5Z+HCS2Y4noYrDEkUIS85yy4nHG36qNApPl+xQBJfuQmxacUEtFG09NFH3cuDpKwUan1TMeejm/DM/Vig78TwEiPS5KeR42kqFadgLdIcZ9g58IpmcBiUS60468YPgBuglzBBs7hyYP3c3jV+pc0i+6W1cGUTicEAFI6fdV1mS4bWjH7UmSZ4NNPdbVdW4xOeGzOjA5R13MsqQbPUfY8j5F48wouvNHo4UHsYEoGwK0VLk174wOYKWmwWKpQRVIia5dfArsF+lek1kfA5CaOPVmaekyaBVaxIp/dut9lkirLWLqNQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(346002)(39860400002)(136003)(376002)(230922051799003)(1800799009)(82310400011)(451199024)(186009)(64100799003)(36840700001)(40470700004)(46966006)(40460700003)(36756003)(40480700001)(8936002)(41300700001)(8676002)(44832011)(4326008)(2906002)(5660300002)(47076005)(36860700001)(478600001)(6666004)(7696005)(86362001)(16526019)(26005)(1076003)(426003)(316002)(336012)(70206006)(54906003)(70586007)(2616005)(6916009)(356005)(81166007)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2023 04:17:33.1725 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 24e32990-6f9d-40b9-2cc5-08dbe011a18d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017090.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5416
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
Cc: Alexander.Deucher@amd.com, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add reg_state attribute to fetch the register snapshot of different
IPs like XGMI, WAFL,PCIE and USR. To get a snapshot for a particular IP
	1) Open the sysfs file
	2) Seek to the offset as defined in amdgpu_sysfs_reg_offset
	3) Read

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 62 +++++++++++++++++++
 .../gpu/drm/amd/include/amdgpu_reg_state.h    | 13 ++++
 2 files changed, 75 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index e2199d8fd30e..bebc73c6822c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -161,6 +161,65 @@ static ssize_t amdgpu_device_get_pcie_replay_count(struct device *dev,
 static DEVICE_ATTR(pcie_replay_count, 0444,
 		amdgpu_device_get_pcie_replay_count, NULL);
 
+static ssize_t amdgpu_sysfs_reg_state_get(struct file *f, struct kobject *kobj,
+					  struct bin_attribute *attr, char *buf,
+					  loff_t ppos, size_t count)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct drm_device *ddev = dev_get_drvdata(dev);
+	struct amdgpu_device *adev = drm_to_adev(ddev);
+	ssize_t bytes_read;
+
+	switch (ppos) {
+	case AMDGPU_SYS_REG_STATE_XGMI:
+		bytes_read = amdgpu_asic_get_reg_state(
+			adev, AMDGPU_REG_STATE_TYPE_XGMI, buf, count);
+		break;
+	case AMDGPU_SYS_REG_STATE_WAFL:
+		bytes_read = amdgpu_asic_get_reg_state(
+			adev, AMDGPU_REG_STATE_TYPE_WAFL, buf, count);
+		break;
+	case AMDGPU_SYS_REG_STATE_PCIE:
+		bytes_read = amdgpu_asic_get_reg_state(
+			adev, AMDGPU_REG_STATE_TYPE_PCIE, buf, count);
+		break;
+	case AMDGPU_SYS_REG_STATE_USR:
+		bytes_read = amdgpu_asic_get_reg_state(
+			adev, AMDGPU_REG_STATE_TYPE_USR, buf, count);
+		break;
+	case AMDGPU_SYS_REG_STATE_USR_1:
+		bytes_read = amdgpu_asic_get_reg_state(
+			adev, AMDGPU_REG_STATE_TYPE_USR_1, buf, count);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return bytes_read;
+}
+
+BIN_ATTR(reg_state, 0444, amdgpu_sysfs_reg_state_get, NULL,
+	 AMDGPU_SYS_REG_STATE_END);
+
+int amdgpu_reg_state_sysfs_init(struct amdgpu_device *adev)
+{
+	int ret;
+
+	if (!amdgpu_asic_get_reg_state_supported(adev))
+		return 0;
+
+	ret = sysfs_create_bin_file(&adev->dev->kobj, &bin_attr_reg_state);
+
+	return ret;
+}
+
+void amdgpu_reg_state_sysfs_fini(struct amdgpu_device *adev)
+{
+	if (!amdgpu_asic_get_reg_state_supported(adev))
+		return;
+	sysfs_remove_bin_file(&adev->dev->kobj, &bin_attr_reg_state);
+}
+
 /**
  * DOC: board_info
  *
@@ -4123,6 +4182,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 			"Could not create amdgpu board attributes\n");
 
 	amdgpu_fru_sysfs_init(adev);
+	amdgpu_reg_state_sysfs_init(adev);
 
 	if (IS_ENABLED(CONFIG_PERF_EVENTS))
 		r = amdgpu_pmu_init(adev);
@@ -4245,6 +4305,8 @@ void amdgpu_device_fini_hw(struct amdgpu_device *adev)
 	sysfs_remove_files(&adev->dev->kobj, amdgpu_dev_attributes);
 	amdgpu_fru_sysfs_fini(adev);
 
+	amdgpu_reg_state_sysfs_fini(adev);
+
 	/* disable ras feature must before hw fini */
 	amdgpu_ras_pre_fini(adev);
 
diff --git a/drivers/gpu/drm/amd/include/amdgpu_reg_state.h b/drivers/gpu/drm/amd/include/amdgpu_reg_state.h
index e1ca38676663..214f154edfff 100644
--- a/drivers/gpu/drm/amd/include/amdgpu_reg_state.h
+++ b/drivers/gpu/drm/amd/include/amdgpu_reg_state.h
@@ -33,6 +33,15 @@ enum amdgpu_reg_state {
 	AMDGPU_REG_STATE_TYPE_USR_1	= 5
 };
 
+enum amdgpu_sysfs_reg_offset {
+	AMDGPU_SYS_REG_STATE_XGMI	= 0x0000,
+	AMDGPU_SYS_REG_STATE_WAFL	= 0x1000,
+	AMDGPU_SYS_REG_STATE_PCIE	= 0x2000,
+	AMDGPU_SYS_REG_STATE_USR	= 0x3000,
+	AMDGPU_SYS_REG_STATE_USR_1	= 0x4000,
+	AMDGPU_SYS_REG_STATE_END	= 0x5000,
+};
+
 struct amdgpu_reg_state_header {
 	uint16_t		structure_size;
 	uint8_t			format_revision;
@@ -136,4 +145,8 @@ static inline size_t amdgpu_reginst_size(uint16_t num_inst, size_t inst_size,
 						   (size)) :               \
 		 0)
 
+
+int amdgpu_reg_state_sysfs_init(struct amdgpu_device* adev);
+void amdgpu_reg_state_sysfs_fini(struct amdgpu_device* adev);
+
 #endif
-- 
2.25.1

