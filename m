Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C5E2C7EE2A
	for <amd-gfx@archiver.kernel.org>; Tue,  9 May 2023 22:14:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9579F10E3E8;
	Tue,  9 May 2023 22:14:30 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2057.outbound.protection.outlook.com [40.107.237.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0DE3E10E1D5
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 May 2023 22:14:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XofmGGUPhfK11w8NPpdgcdEtqYATMkIzVAXfMH/5lyAuH4QUFJim58c10MtsO2vjOaKZrn6pjsLwbeJTQ8odcvFIQ/d7a8dvTwybXGdNWTM3UipBZc4oZtUIh618IUJOghUBJH+CtQrQzkA/f5KlDmR4JchQt8lRWtbRyfMOINmL0qSPID1xHWsjKtcuaKYlcq8aWEcSygK09KjjveVIWBlnMDol9wLnzYERqX5Zp5Io2d3+IqmtCSWi5id5gySRPh3rsuBM1iaJN7Cwv1Xk5e62FVDOzuoGLZH+fOB5l99v7KXMlU2jywAmNf9dBUTZtzQsBvi93NJaDUcD2Xs7AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3PRXyGzG7U3aEATd+1V1K7Phd9NwRiT7ZFOdInEANsw=;
 b=kwiskFBUV7QszsDfq8L50kuQe1FrXAAodn1wtPUlwastrIWdgygQlN9J4RLI0n9bNXS1msrGcQJHQvaxVf2ejueg03ggxFnaw2ilQ65Pmj4fa6ps4l7X7d5C4DU1Q4ey/Jkb13kWQorXjE8HsWn9PxyKlksAVGsFlfd5N3bT8iiwnkF9Y2Qvp1FRfvhP8OIViO2mUrJrNWrHpxu2dzJA6jsuG/DCJNI6VA2In6R8PHEXPBmtiTGKuyhMm87jAiWp0Wl9ATgh8KOW1wnjqi6AOpJNGuafx99f+2HbgI3g7HM0I/Qn3Vw+54Y5fsfKUsaMS+IMfgZKvl3+CfE3mBpU3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3PRXyGzG7U3aEATd+1V1K7Phd9NwRiT7ZFOdInEANsw=;
 b=ft3Z44ScHHnZMhFSryjjzGW2SNFqNafUQBt9Vo9H6voSNI9rUK74HKRyqE+BsI/faq2tsGnoh/oVVlN2Y/YYhULIqn6YITUoc3J89dQw+eoRFykz/mDMPPijpDVOK83X8KCDaCz6uMOIlHjFb7oEOt9Kma5dPz9mBE2VqR3JlQc=
Received: from BN1PR12CA0016.namprd12.prod.outlook.com (2603:10b6:408:e1::21)
 by DM6PR12MB4156.namprd12.prod.outlook.com (2603:10b6:5:218::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Tue, 9 May
 2023 22:14:25 +0000
Received: from BN8NAM11FT109.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e1:cafe::dd) by BN1PR12CA0016.outlook.office365.com
 (2603:10b6:408:e1::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.34 via Frontend
 Transport; Tue, 9 May 2023 22:14:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT109.mail.protection.outlook.com (10.13.176.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6387.18 via Frontend Transport; Tue, 9 May 2023 22:14:25 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 9 May
 2023 17:14:24 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 05/14] drm/amdgpu: Add API to get numa information of XCC
Date: Tue, 9 May 2023 18:13:59 -0400
Message-ID: <20230509221408.476829-5-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT109:EE_|DM6PR12MB4156:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c63cdec-76c8-451f-5dd3-08db50dabfa4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XrLjwVmkbZYbznUCHSd9YFrRS6ovoGIwwf3GnYfH9Pxsd84zzkqujIjM/+NMAG5mv7twlvieKVsadxPcx2XIW2zQU/aNaw5CvIGd+1pQo6gCUiI1Jic6jWUDiEww5JFxLW2aT15yR7zbsQVfM71cgIIs7utRbwJPEho/gQgrV+yP/eCoHQKEA8g1NGNFcjnxNYTo14zSlfY0k6WDJoxmbE4tjICoJopuD/k0Pq8I5DctysbqsGip9a3xDWbB9nSqLwmmSvPyPyTjM8zT3rJndETpimc5GpoDRDLB8JzhM7ynPXxP1gTK/h+dDwOQBkVj0ZqBIy02KoC9giRHrA+GvldlAMmyEmEgT5jtf2glIi9CzSRhAz+ujMn8XLDQoKpBtlcE31BVVR2HURSRBRsFCK33NaGSFr3I7pXsEIjTQBL69QO5tGjQWDA5Ky9JKpv9f5Cxd/GhzD4+AGJEEzxQ2c/MQLKOLTtZ48ICIMAQ2QQ4YDhC0rrJoup1IpOt1Abhkssqn2kNIj8k7mBlayH9+7VCNBhYVfDAK/wZXG8KwmrS9gz2+OONdALIppyYmDuFtbrEjzji7ubBJ0YuDEBNRnvc4o3RzHbHNFMIzGubixFvALNwB2iURvhoKNKtlJSY2upWphic03PGG+/H3pKmhDibI/3yNQ/kgQFSwKTIUTmx9aLNe7WKZeH8mMKWnlvlqPqT4WXkXVcpqmcwi169o5HHys1rzjTVbv6wcqDPjGU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(376002)(396003)(39860400002)(346002)(451199021)(36840700001)(40470700004)(46966006)(40460700003)(6666004)(6916009)(478600001)(4326008)(70586007)(7696005)(70206006)(54906003)(316002)(86362001)(36756003)(336012)(83380400001)(1076003)(36860700001)(26005)(2616005)(426003)(8676002)(8936002)(356005)(41300700001)(2906002)(47076005)(40480700001)(82310400005)(5660300002)(82740400003)(81166007)(16526019)(186003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2023 22:14:25.0901 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c63cdec-76c8-451f-5dd3-08db50dabfa4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT109.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4156
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

Add interface to get numa information of ACPI XCC object. The interface
uses logical id to identify an XCC.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Le Ma <le.ma@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h      | 14 +++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 32 +++++++++++++++++++-----
 2 files changed, 40 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 65b3aeef37ed..4ecaff14f2b3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1404,6 +1404,12 @@ struct amdgpu_afmt_acr amdgpu_afmt_acr(uint32_t clock);
 
 /* amdgpu_acpi.c */
 
+struct amdgpu_numa_info {
+	uint64_t size;
+	int pxm;
+	int nid;
+};
+
 /* ATCS Device/Driver State */
 #define AMDGPU_ATCS_PSC_DEV_STATE_D0		0
 #define AMDGPU_ATCS_PSC_DEV_STATE_D3_HOT	3
@@ -1423,6 +1429,8 @@ int amdgpu_acpi_smart_shift_update(struct drm_device *dev, enum amdgpu_ss ss_sta
 int amdgpu_acpi_pcie_notify_device_ready(struct amdgpu_device *adev);
 int amdgpu_acpi_get_tmr_info(struct amdgpu_device *adev, u64 *tmr_offset,
 			     u64 *tmr_size);
+int amdgpu_acpi_get_mem_info(struct amdgpu_device *adev, int xcc_id,
+			     struct amdgpu_numa_info *numa_info);
 
 void amdgpu_acpi_get_backlight_caps(struct amdgpu_dm_backlight_caps *caps);
 bool amdgpu_acpi_should_gpu_reset(struct amdgpu_device *adev);
@@ -1435,6 +1443,12 @@ static inline int amdgpu_acpi_get_tmr_info(struct amdgpu_device *adev,
 {
 	return -EINVAL;
 }
+static inline int amdgpu_acpi_get_mem_info(struct amdgpu_device *adev,
+					   int xcc_id,
+					   struct amdgpu_numa_info *numa_info)
+{
+	return -EINVAL;
+}
 static inline void amdgpu_acpi_fini(struct amdgpu_device *adev) { }
 static inline bool amdgpu_acpi_should_gpu_reset(struct amdgpu_device *adev) { return false; }
 static inline void amdgpu_acpi_detect(void) { }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
index 26efca660f0d..7150c09933cf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
@@ -54,12 +54,6 @@ static const guid_t amd_xcc_dsm_guid = GUID_INIT(0x8267f5d5, 0xa556, 0x44f2,
 
 #define AMD_XCC_MAX_HID 24
 
-struct amdgpu_numa_info {
-	uint64_t size;
-	int pxm;
-	int nid;
-};
-
 struct xarray numa_info_xa;
 
 /* Encapsulates the XCD acpi object information */
@@ -1156,6 +1150,32 @@ int amdgpu_acpi_get_tmr_info(struct amdgpu_device *adev, u64 *tmr_offset,
 	return 0;
 }
 
+int amdgpu_acpi_get_mem_info(struct amdgpu_device *adev, int xcc_id,
+			     struct amdgpu_numa_info *numa_info)
+{
+	struct amdgpu_acpi_dev_info *dev_info;
+	struct amdgpu_acpi_xcc_info *xcc_info;
+	u16 bdf;
+
+	if (!numa_info)
+		return -EINVAL;
+
+	bdf = (adev->pdev->bus->number << 8) | adev->pdev->devfn;
+	dev_info = amdgpu_acpi_get_dev(bdf);
+	if (!dev_info)
+		return -ENOENT;
+
+	list_for_each_entry(xcc_info, &dev_info->xcc_list, list) {
+		if (xcc_info->phy_id == xcc_id) {
+			memcpy(numa_info, xcc_info->numa_info,
+			       sizeof(*numa_info));
+			return 0;
+		}
+	}
+
+	return -ENOENT;
+}
+
 /**
  * amdgpu_acpi_event - handle notify events
  *
-- 
2.40.1

