Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D53BD13590
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Oct 2024 06:42:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BAAEE10E5A4;
	Tue, 29 Oct 2024 06:42:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="J0Ar2jxe";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2081.outbound.protection.outlook.com [40.107.93.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E64C410E5A4
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Oct 2024 06:42:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ooh4ybxZTPu7hOCuu14n7Ju+eislkdM6VCFnxBQrtZYgYUUATrbmT8Lxum/7Aeu1Jv/mkcytvQ3aaY2/TP5I1r0c+xefLB0y5RH2u/xtxwCqOSwjvs+0ILc05JmjvDzWcnPW+SF0cCRPXVk1oO58Ka7EWSv7uN8AGl1Rabs4L+oIWcgEwh+6DenFrYC1DqkCRAQuJpWy6I5NY+NIkLMgfIiZYfLh/btIOZ2Z2oTvtZIajxjwhIxyD1fgpoOFDDzgwHaOGpDCPhwBuMrY8OmEWYpn5SPw7DQVEagSMZRqv2HfrT6rOgFjKONZoOi1Rpohdsa4m8+8zBH71l/iZ0LebA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VIpmi0sWHzjSzrcBVZa5Q9TTivubJlDq1a6xlsnRoT8=;
 b=JAcl4tmNVzP44sB0t1EC/ACaAW5ahKV2G5JFEaFYrKcVTiWByJHAJzXMY4PGFOCYpTRP9ivcH+5bEbW4UEPrhH2b7YHvqeCWbowb6o0sj5leeU59obUwoTBGzPHfeopLKO8nTvMN+5rmx1VF+jELw8FSQFnTSZxzI8m6iPq7h5JPwq80cIO/g0TU2haZ0MzzyfSvyCh1RDMC3hDEFBpc9MXblWm2h4y54aRfEduJ70Zfe6ZPp2ga4J/gGkuFOleJQvOi7RsyP2TZm0qwf/5Bz+TtpJDYA2zJp35fz5mmvIpM8FuPHoExl+R2vfGP6bsBJNPhsEwP6t/hHTqju8ftzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VIpmi0sWHzjSzrcBVZa5Q9TTivubJlDq1a6xlsnRoT8=;
 b=J0Ar2jxezskqUBpKQI7BvY6vL7lJfy8lWNOQ5zSsOj2It6WTS9ILWjZl8A1NIgfdY36xDqBXBn6yz+Y4NlfnSKGgkYMr1M7aonaBfNvjWyVNw9u3gjBZ0O5CIpXx7JTn81NAIjIhjD4wS1ieM6EDVavxZTxd5sdZXMb9IiHo0EU=
Received: from MW4PR02CA0002.namprd02.prod.outlook.com (2603:10b6:303:16d::10)
 by CYYPR12MB8656.namprd12.prod.outlook.com (2603:10b6:930:c3::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.18; Tue, 29 Oct
 2024 06:41:58 +0000
Received: from SN1PEPF00036F3E.namprd05.prod.outlook.com
 (2603:10b6:303:16d:cafe::de) by MW4PR02CA0002.outlook.office365.com
 (2603:10b6:303:16d::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25 via Frontend
 Transport; Tue, 29 Oct 2024 06:41:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF00036F3E.mail.protection.outlook.com (10.167.248.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Tue, 29 Oct 2024 06:41:58 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 29 Oct
 2024 01:41:57 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 29 Oct
 2024 01:41:57 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Tue, 29 Oct 2024 01:41:50 -0500
From: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <Tim.Huang@amd.com>, "Jesse.zhang@amd.com" <jesse.zhang@amd.com>,
 Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH V4 3/5] drm/amdgpu: Add sysfs interface for vcn reset mask
Date: Tue, 29 Oct 2024 14:41:34 +0800
Message-ID: <20241029064136.3057034-3-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241029064136.3057034-1-jesse.zhang@amd.com>
References: <20241029064136.3057034-1-jesse.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3E:EE_|CYYPR12MB8656:EE_
X-MS-Office365-Filtering-Correlation-Id: b6972021-0069-43ba-1e33-08dcf7e4c95f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2YdRkfEORKEwT/Dz9la/8FdT1AS34DJqPXm1akggpFlULMX1uBu5dUADHnrZ?=
 =?us-ascii?Q?d0AWi85ow7MwAjvpHyPnR7cvwflbMoiIezYnUhUQ2doVX6G6Y+TRVU47Ya1P?=
 =?us-ascii?Q?Z3rm5R6nvVJyDc2X+9tdTsvs+L9H8NrcFNKtAicqbWzD5SLKlloXt7uDuAdP?=
 =?us-ascii?Q?GMXPf2Co4kL+ZJ3LESJE7kHcxb/82boJm1useNmr6TebgutUvyiaGf3WJuIi?=
 =?us-ascii?Q?RoNvbSexILE2Q8W3M/zH5cucQeAFZ6AcvcUvkbsMf1pdvCdzgqACmGO347dt?=
 =?us-ascii?Q?7fI7X6GKyF5PsVXSQ1isEV3udrihXoPGCZ9XezGQLgvhYrEqMggi1xOzhypF?=
 =?us-ascii?Q?gppxW6bKhifZpf5hOL+ifrBuQ+yhAwYoSr7+eIV5Vv+hJGqNAyZTsg9458Y1?=
 =?us-ascii?Q?bdETj1AIwLg3WMMe40YBPhX4cNo+P5xDB4PRpzyAaq504qZ+FPXH9BmMo27D?=
 =?us-ascii?Q?BNI9WpRWFLddm12GxfQbjjBLEncSnl0+DJhLkTro0f2c6nqiExxxlKGhYEZp?=
 =?us-ascii?Q?O0zPjO15SHhwje+XpfYu0bbS8eQ+rn0fYpBHcZVDd5fCmOIQgeE7KD91BvVh?=
 =?us-ascii?Q?t++eIfv+DlZLvgjQnpEiQwCALKUHzw+t9DR497RghntPBC4OojjIle3E8X4i?=
 =?us-ascii?Q?SK56KHwCpSWiflwF+ydxVeL6dLiQFStbPVsxqzTNbvTmaUSS/jeDqzvy7dDc?=
 =?us-ascii?Q?SJyLU6jNvkmqTeUqcUKaEllh6n2WP5GYQzQbFCahc1x9q5QmSF3i/IAT6/xx?=
 =?us-ascii?Q?ZgD2Bi2+T2pRw+aOQNHOvoZiQlREganIemZ86M16rujZ+9SFX/lcX8/MDz+B?=
 =?us-ascii?Q?bAUDygWT42gc5Ebmv+1ApEvNOvBj2muJjf+zT/rgDKugeCeAFnDeZELZ8csp?=
 =?us-ascii?Q?RDDxq6Jztke7pha2wri6hYQUKB4bD7/OS60I3/g6E4IlZHnMACEZDpJEyzPs?=
 =?us-ascii?Q?MDdECo9kf8E8i65ZCjdicHgv2XX3dFlxQ4r1VW3AIacXYhwAdGPv3UidnH7V?=
 =?us-ascii?Q?8l0kLqOmbgA/t27sb5t9gBVSDBZ9Wxh//Xw2V3onNSaXuI+qSrFiefIwu/42?=
 =?us-ascii?Q?X/az93DLvMN98F+OdHffru1NqNJ95cOF10XXrojEhcXC7ZDzzMDoMb4IJ2hl?=
 =?us-ascii?Q?EUsIJCDxsUcEAGQiorwVwNiBSbwlhzHg3GjUL+XvQaapsx1AETG016PCjItM?=
 =?us-ascii?Q?cmKIUqtUiC5+C0VvgjZa1GmJonLEgbxvkzJStVKpmJZeMXk3Y3YtYxd7qsDO?=
 =?us-ascii?Q?TxONf7lUCn3p4M6Vsn7MHN3Yxzt+y7crIL6TT7ZrA77zhXWgk+T4XTZBlfWk?=
 =?us-ascii?Q?jZyXYuSj+SYAGAt3nM5c12POu4VWiBppXWgH+F7OzjE1hGe6djzFc9CDGnWv?=
 =?us-ascii?Q?/8xMtImaKMU0uktR/examPSBCB5L+BngdKSduiUjqa+gxWQNIw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 06:41:58.1888 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b6972021-0069-43ba-1e33-08dcf7e4c95f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F3E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8656
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

Add the sysfs interface for vcn:
vcn_reset_mask

The interface is read-only and show the resets supported by the IP.
For example, full adapter reset (mode1/mode2/BACO/etc),
soft reset, queue reset, and pipe reset.

V2: the sysfs node returns a text string instead of some flags (Christian)

V2: the sysfs node returns a text string instead of some flags (Christian)
v3: add a generic helper which takes the ring as parameter
    and print the strings in the order they are applied (Christian)

    check amdgpu_gpu_recovery  before creating sysfs file itself,
    and initialize supported_reset_types in IP version files (Lijo)

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
Suggested-by:Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 35 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  4 +++
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c   |  9 +++++++
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c |  8 ++++++
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c |  9 +++++++
 5 files changed, 65 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 43f44cc201cb..9bbae298189a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -1277,3 +1277,38 @@ int amdgpu_vcn_psp_update_sram(struct amdgpu_device *adev, int inst_idx,
 
 	return psp_execute_ip_fw_load(&adev->psp, &ucode);
 }
+
+static ssize_t amdgpu_get_vcn_reset_mask(struct device *dev,
+						struct device_attribute *attr,
+						char *buf)
+{
+	struct drm_device *ddev = dev_get_drvdata(dev);
+	struct amdgpu_device *adev = drm_to_adev(ddev);
+
+	if (!adev)
+		return -ENODEV;
+
+	return amdgpu_show_reset_mask(buf, adev->vcn.supported_reset);
+}
+
+static DEVICE_ATTR(vcn_reset_mask, 0444,
+		   amdgpu_get_vcn_reset_mask, NULL);
+
+int amdgpu_vcn_sysfs_reset_mask_init(struct amdgpu_device *adev)
+{
+	int r = 0;
+
+	if (adev->vcn.num_vcn_inst) {
+		r = device_create_file(adev->dev, &dev_attr_vcn_reset_mask);
+		if (r)
+			return r;
+	}
+
+	return r;
+}
+
+void amdgpu_vcn_sysfs_reset_mask_fini(struct amdgpu_device *adev)
+{
+	if (adev->vcn.num_vcn_inst)
+		device_remove_file(adev->dev, &dev_attr_vcn_reset_mask);
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
index 2a1f3dbb14d3..904336ff0b39 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -333,6 +333,8 @@ struct amdgpu_vcn {
 
 	/* IP reg dump */
 	uint32_t		*ip_dump;
+
+	uint32_t		supported_reset;
 };
 
 struct amdgpu_fw_shared_rb_ptrs_struct {
@@ -518,5 +520,7 @@ int amdgpu_vcn_ras_sw_init(struct amdgpu_device *adev);
 
 int amdgpu_vcn_psp_update_sram(struct amdgpu_device *adev, int inst_idx,
 			       enum AMDGPU_UCODE_ID ucode_id);
+int amdgpu_vcn_sysfs_reset_mask_init(struct amdgpu_device *adev);
+void amdgpu_vcn_sysfs_reset_mask_fini(struct amdgpu_device *adev);
 
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index e7b7a8150ea7..4c8046f5b209 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -225,6 +225,10 @@ static int vcn_v4_0_sw_init(struct amdgpu_ip_block *ip_block)
 		vcn_v4_0_fw_shared_init(adev, i);
 	}
 
+	/* TODO: Add queue reset mask when FW fully supports it */
+	adev->sdma.supported_reset =
+			amdgpu_get_soft_full_reset_mask(&adev->vcn.inst[0].ring_enc[0]);
+
 	if (amdgpu_sriov_vf(adev)) {
 		r = amdgpu_virt_alloc_mm_table(adev);
 		if (r)
@@ -247,6 +251,10 @@ static int vcn_v4_0_sw_init(struct amdgpu_ip_block *ip_block)
 		adev->vcn.ip_dump = ptr;
 	}
 
+	r = amdgpu_vcn_sysfs_reset_mask_init(adev);
+	if (r)
+		return r;
+
 	return 0;
 }
 
@@ -284,6 +292,7 @@ static int vcn_v4_0_sw_fini(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
+	amdgpu_vcn_sysfs_reset_mask_fini(adev);
 	r = amdgpu_vcn_sw_fini(adev);
 
 	kfree(adev->vcn.ip_dump);
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index 6dcae398b2dc..3031ae57a37a 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -180,6 +180,10 @@ static int vcn_v4_0_3_sw_init(struct amdgpu_ip_block *ip_block)
 			amdgpu_vcn_fwlog_init(&adev->vcn.inst[i]);
 	}
 
+	/* TODO: Add queue reset mask when FW fully supports it */
+	adev->sdma.supported_reset =
+			amdgpu_get_soft_full_reset_mask(&adev->vcn.inst[0].ring_enc[0]);
+
 	if (amdgpu_sriov_vf(adev)) {
 		r = amdgpu_virt_alloc_mm_table(adev);
 		if (r)
@@ -206,6 +210,10 @@ static int vcn_v4_0_3_sw_init(struct amdgpu_ip_block *ip_block)
 		adev->vcn.ip_dump = ptr;
 	}
 
+	r = amdgpu_vcn_sysfs_reset_mask_init(adev);
+	if (r)
+		return r;
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
index 89bf29fa6f8d..6e9d2e1927eb 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
@@ -170,6 +170,9 @@ static int vcn_v5_0_0_sw_init(struct amdgpu_ip_block *ip_block)
 			amdgpu_vcn_fwlog_init(&adev->vcn.inst[i]);
 	}
 
+	/* TODO: Add queue reset mask when FW fully supports it */
+	adev->sdma.supported_reset =
+		amdgpu_get_soft_full_reset_mask(&adev->vcn.inst[0].ring_enc[0]);
 	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
 		adev->vcn.pause_dpg_mode = vcn_v5_0_0_pause_dpg_mode;
 
@@ -181,6 +184,11 @@ static int vcn_v5_0_0_sw_init(struct amdgpu_ip_block *ip_block)
 	} else {
 		adev->vcn.ip_dump = ptr;
 	}
+
+	r = amdgpu_vcn_sysfs_reset_mask_init(adev);
+	if (r)
+		return r;
+
 	return 0;
 }
 
@@ -215,6 +223,7 @@ static int vcn_v5_0_0_sw_fini(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
+	amdgpu_vcn_sysfs_reset_mask_fini(adev);
 	r = amdgpu_vcn_sw_fini(adev);
 
 	kfree(adev->vcn.ip_dump);
-- 
2.25.1

