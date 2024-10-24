Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4B58D0BB6A
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Oct 2024 07:40:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7367A10E8BF;
	Thu, 24 Oct 2024 07:40:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KZCdnSeI";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2077.outbound.protection.outlook.com [40.107.96.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6FC9110E8BF
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Oct 2024 07:40:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ON9yTIbrttG+owH0p5GgcgrT8PL0Y62CUU79xzMhykxYwmuM28y4fsSMcfVBsB0X4+mj9dCNEP3WUeFkxHCoe8m1eBhXxX+rc5+fZXVArvdF4A3ZPP6YlmR90DHHgfqfFvHwYO4wuSmOKMXOHyZj6OKSOGupKrB+rW5HlNoBA9AxIhBJ3Vxat7Lg5G5AZFztc9ponGF2poR56GO5ECa+XrJSxBqnCEuK1Z2DgbtfFHKkgfCagbSN5E/WqocI1UxwVlngP6nuys+Uud+9PnIISJtMZN+801SjXxgn4gFlhtWk7EhXUNIHmSuKMBb9+LdOFDup4NF44T0OOu2wkpfbXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XttfQbMSrQi0GDIKiDEQ9gkxYQgxe5VQoyfL4l6X8BQ=;
 b=kd+IKvodQ/aFQc5az3jXQ0BXe/S6C2Rj/5WC8DAFDKUjCHTRvLsDQSPA/1oN7A8LFIkvHUQWB5Sc47D6n0Yqj5CEK+PMxx0pp1trooyVgGojq6pgRmKUYmpe8OtoJ2WgaUa3VyuDTqQ8Mw9sei2E2F2uYnGs7hmHQJQ0FJvpy+mrlCHgeJM+Qsb8z3JL4nU2Y3v4rmwFuRlLva5t1BVMpAwX7bz70+0WcbjyVqHRIna+mv44XFanvFBChuf6I+REDtCeQcMOb3YBYwXNFUvW8YueveTafFiAn8Fb2s3mc5dzaSvPR2HeOTNY5C3rQyOhST489JbktUHXpWvaucXO5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XttfQbMSrQi0GDIKiDEQ9gkxYQgxe5VQoyfL4l6X8BQ=;
 b=KZCdnSeIEWL4dgp9dpztBODS7zi7eXHic5oV8ffphh1bBoWpRFGULpAgGcCahWA8Yyq8e+PIM1V04pEZ1SteqncykS8DU2PPKS7ojwZ/q5jgs+3mpEki+fzapbppLvm51C5b+WVPzZ8kEVzJljm1ZMwPoZ+sQdpNK77II05H5LM=
Received: from BN9PR03CA0161.namprd03.prod.outlook.com (2603:10b6:408:f4::16)
 by DM4PR12MB8473.namprd12.prod.outlook.com (2603:10b6:8:183::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20; Thu, 24 Oct
 2024 07:39:55 +0000
Received: from BL6PEPF0001AB4D.namprd04.prod.outlook.com
 (2603:10b6:408:f4:cafe::db) by BN9PR03CA0161.outlook.office365.com
 (2603:10b6:408:f4::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20 via Frontend
 Transport; Thu, 24 Oct 2024 07:39:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4D.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Thu, 24 Oct 2024 07:39:55 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 24 Oct
 2024 02:39:54 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 24 Oct
 2024 02:39:54 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Thu, 24 Oct 2024 02:39:47 -0500
From: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 "Jesse.zhang@amd.com" <Jesse.zhang@amd.com>, Jesse Zhang
 <Jesse.Zhang@amd.com>
Subject: [PATCH V3 3/5] drm/amdgpu: Add sysfs interface for vcn reset mask
Date: Thu, 24 Oct 2024 15:39:31 +0800
Message-ID: <20241024073933.2709389-3-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241024073933.2709389-1-jesse.zhang@amd.com>
References: <20241024073933.2709389-1-jesse.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4D:EE_|DM4PR12MB8473:EE_
X-MS-Office365-Filtering-Correlation-Id: 478263ad-044e-4d25-3813-08dcf3ff0dae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0x3/E7nz9xHEEJS8IkQas3FeaywGXOLRi/+LMvGr183/tztWtB265mPjy4DR?=
 =?us-ascii?Q?WVLXYYCpyePvaj4G6FTxArIKZXKFqEV8DUXHjIptIWxTWsfWeFnQKXKU/F93?=
 =?us-ascii?Q?RNbFjxkA98PDhGwcHeV3Pzg5qXlAAz52EeNgckMdcvULyOpKG1eSE1L9c0J+?=
 =?us-ascii?Q?KNZ/NPSMaXn89XVc2+j4iPQpJ1eg9oPpmvDHgRPCB0/X+zP/lpneECf7lWGn?=
 =?us-ascii?Q?eBoJiJ8Tgywgy2cgcf78LpyepMEd+mwKR9om6ewSnPX8E/R43prcFtyMeEvB?=
 =?us-ascii?Q?AivN5MTyz1SxrJD7c43UN1vDvooRI4lNKm+SX4zQHegCfJyVRQGVv/5b/kBD?=
 =?us-ascii?Q?jF1An/hppTsxwFS6YyYSjvPcqjnKsHvVLel9Oawv8orQ4LtHTjCbbzFvokcZ?=
 =?us-ascii?Q?17d2gnQRlBI2YsfyogVa+BpkhamIWXFj4wckr98KJ59ISDkXnjpba5zlqwIg?=
 =?us-ascii?Q?djw/LFi2H/wDNPtTQwAQ0EPK1H3guT3wWHSggzwFSBsbzN4wNsf3IiBhvk06?=
 =?us-ascii?Q?y8ICfq8u2zdI4KgRrEHolYPU2R0FpHryxSZecROlUgmCxrIZ/aD9kBXb21gy?=
 =?us-ascii?Q?NifbRpqQAqieR3JHD0LVg4QFYdWHO1O9o0NCp3DovhjpEhcm0Vlz4JV2kTEt?=
 =?us-ascii?Q?1o+v/fvEmUR8u5/aGmoZGjmaHg0TDloplMgWytyKiWEKmrZH8q950ZeQJ9lj?=
 =?us-ascii?Q?1MGQuAwSixF//H46SONtxMPHRTMY5Am8TI6zehkY8KzXCc47mwigQBhQTyIq?=
 =?us-ascii?Q?VQ7UtpaoAZAUuQ+y74BtqCw2D+MXiEtp1XYz+aZLsxrpcUoVNWKskRCFnCZo?=
 =?us-ascii?Q?d2k2b3GRH8pkjp6fZChJZ8eC12gqZ3ZVBfBrapsZWz59CNgSXBO9xzu+Bk37?=
 =?us-ascii?Q?5Yt2ep2gN8gRvRZ88F5Gzsw2OQ98Q5QmbgIUE2lFoF+sHAfhvDJiXsDe1mPF?=
 =?us-ascii?Q?gokhX2iNwop2rmy/WJcJH7Ka3NBFEQFYBXCaCO1phiVNHqAq//8P7Qxb0hTi?=
 =?us-ascii?Q?NhgmoB6bGQ6xC6R3pjk3EQ4koW4BQ2VHyg3sYOwz7I7tzPER2GLADf0Tgld4?=
 =?us-ascii?Q?08zf7T88ON6fSmAT7ICttAMzsZ/IT6pwbz7htxX5MZaR3TDvIB7jNkRRs8Cl?=
 =?us-ascii?Q?TbZFgKRue9yXe5zlNp80AaOf7qCYqhZCfz8Sp/5JKV0AGpthqFMMuWxdMcRF?=
 =?us-ascii?Q?cWq+Iib2TVrnec74wI7jnl+bwAkeprmCERPMNVS+jBjskn4NYY1ITrMMBInY?=
 =?us-ascii?Q?HR6BQHVLikgyL1O1SjDYvBHJ3DZ3rWUVtpexbPIvl6S8wCuN7s6ihkZWp7ar?=
 =?us-ascii?Q?FbB6oYpdSs4NY+0W111zKsz2F2nmAUw/EH0vAHjOGusEus5I4RiHqqcHA0gU?=
 =?us-ascii?Q?56W8Cx2AUK8/J6Hd1CALg/TlLxc4TK5c3OEpFOx4/aaLOcKASg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 07:39:55.0874 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 478263ad-044e-4d25-3813-08dcf3ff0dae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8473
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

From: "Jesse.zhang@amd.com" <Jesse.zhang@amd.com>

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
index e7b7a8150ea7..9c84cfe9ea43 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -225,6 +225,10 @@ static int vcn_v4_0_sw_init(struct amdgpu_ip_block *ip_block)
 		vcn_v4_0_fw_shared_init(adev, i);
 	}
 
+	/* TODO: Check the version that supports queue reset */
+	adev->sdma.supported_reset |=
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
index 6dcae398b2dc..1887a15b7d69 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -180,6 +180,10 @@ static int vcn_v4_0_3_sw_init(struct amdgpu_ip_block *ip_block)
 			amdgpu_vcn_fwlog_init(&adev->vcn.inst[i]);
 	}
 
+	/* TODO: Check the version that supports queue reset ? */
+	adev->sdma.supported_reset |=
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
index 89bf29fa6f8d..a67a0b11027a 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
@@ -170,6 +170,9 @@ static int vcn_v5_0_0_sw_init(struct amdgpu_ip_block *ip_block)
 			amdgpu_vcn_fwlog_init(&adev->vcn.inst[i]);
 	}
 
+	/* TODO: check version which supported queue reset ? */
+	adev->sdma.supported_reset |=
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

