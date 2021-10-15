Return-Path: <SRS0=EPaF=PD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88952C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Oct 2021 15:11:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F34F611C1
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Oct 2021 15:11:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3F34F611C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 43A826E30C;
	Fri, 15 Oct 2021 15:11:19 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2076.outbound.protection.outlook.com [40.107.102.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 18CEE6E30C
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Oct 2021 15:11:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iidCdNhvvn4UCJMOyZCMGmbEhPM5FdL56WqJmPqcvo37BftlJ02UkAJmzAlWJLuPWcPDmeBSfJCOMPfoOoAqZ63J4LmzQizX1fBYWhlT8HoCQCfsjUpOa9qJtS3nsLPpB6VD/Qc3nE/pscKPR4/Ib3CkdujRMNh4wfBbRTOOhHlrf7F2VkVEDQUFWfRbNMC2Or/+bUk6ww3B1MW2WdfM0BOJd7Tr2ksRgj8Hdm3dPVEPRKsCPZR/WKhqZlT4mWAUWa5XZcQXwr6PuaikpPIru2fif+7joWvOe9Yy7F73RDMmW/ZtLDS2LLx6nkZBrR+m+xuI6hevLGmt+gFqAixI8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6t3W+CcXYx1TcDvH09cwjCu39I28lzbYL7v1L2rDbx0=;
 b=XVaDao7f5zJX8vVumjwilmT/XPljCFAd/15D8lQu+Sjd3H4guN5DDjFxdutsnDzDhyp3Jh0JiJ1JoKm7tEe78pxYsrp4UgtzFlyWWRUVYyK6DRxobjyMebdnLdk1/4tQUpzhbXNDZwJmPXmBHes77CeOdbIGPyYmvmFCvDe07lp3Btb/zb8e1tXGY0417SgGO8PgjCxNt2nCHzVd1lOnp7Z1SPZkCUZEW+0843EP/r3Mw3Rd+xFY0HUYe/2tbiQQooMGSPxy14siiuKyhdN3WEnQYKk3DUwS2s/VYdSssNkmr6zz+fvDxcfbVoeviHaN59PmJHn5sx44CUphhpX5YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6t3W+CcXYx1TcDvH09cwjCu39I28lzbYL7v1L2rDbx0=;
 b=z4b6a4uwf8YIEZafUzJ8L8+v02kbtjdJGTkia43h86tUw8x7l1k0IznnXa+AVAT4CFYBimx4/KUZFQu4UmUnH9CO1S/niKPOuTi6t3LC1FO4C9CGKk5p/QDRsA2Xg374sMZ0b77KKFwYd8BvNS+j5SdJBaux27i2Vb2yAr7Vzmg=
Received: from MWHPR13CA0029.namprd13.prod.outlook.com (2603:10b6:300:95::15)
 by DM6PR12MB2746.namprd12.prod.outlook.com (2603:10b6:5:41::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.17; Fri, 15 Oct
 2021 15:11:16 +0000
Received: from CO1NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:95:cafe::c4) by MWHPR13CA0029.outlook.office365.com
 (2603:10b6:300:95::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.10 via Frontend
 Transport; Fri, 15 Oct 2021 15:11:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT037.mail.protection.outlook.com (10.13.174.91) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4608.15 via Frontend Transport; Fri, 15 Oct 2021 15:11:15 +0000
Received: from jonathan-KFD.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Fri, 15 Oct
 2021 10:11:14 -0500
From: Jonathan Kim <jonathan.kim@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <Sean.Keely@amd.com>, Jonathan Kim
 <jonathan.kim@amd.com>
Subject: [PATCH] drm/amdkfd: map gpu hive id to xgmi connected cpu
Date: Fri, 15 Oct 2021 11:11:03 -0400
Message-ID: <20211015151103.3590983-1-jonathan.kim@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f5e9f2b1-5553-4e75-54c7-08d98fee0878
X-MS-TrafficTypeDiagnostic: DM6PR12MB2746:
X-Microsoft-Antispam-PRVS: <DM6PR12MB27464497E0672CE986ADBF9285B99@DM6PR12MB2746.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kvO+QVyIOujzNU8T4AZ0bc1M4mJysv4PoSUyhjuOaE7pKIsQyTTj7T0on6cYDP+Bo14zg7iKPOTSMI9L5CaLjqXhy7M2s2nwFAm4P31ckDiJa7rlgA6qfIj8Vgf5e1uWeQWfr91bZF6ziNtfFxPvy92yCbu8NIEMKG1BdsJQF0+mOTBFC7WnMkU0cRAwqG5yMZ48+8zXiwp9svi9k+IWaV66qwpIIsPShCxYYAGBQL3KivR4fPT1gJcHCsd/KeFxWS9rMdx5V2+MDdXIVpf3ceAFY4nTaebBUHOTgaclBlCMdhKpjuiqvDgLRvis0IKjZlb1tjTU14lfNVQYLm1ukms+hBSvqSyO+iP4uqCt+f7rP4kNwE/7XmXk7hhAf617FOjBvFlG6DrGvV9be7qfESnAZWM9cxYqk5o1qpPBZClS5soVwU/LqnlTTT7OGVr0Vbne+VmyD6+XNZ1gcs9zuqaWv6yMfeXoJw4Xz5WlESP4vpSn2CKSOoCzKxl+WPfB4k7bzEEzf2Qi8ndTz0D7XGfgDyOk4Yh8jzTz38XFv6SAewuMy8p6Vc9vfX7r2lfZXV/9Fqh8SK6JiO6tt/pB299TTSWjFj+HulOpFz5bQAczAkBsqueEJCeK8n0B7E6cZt5jTjEC3yMKwVIExr0FCdnv1Pk0eVSZCKLn+pVSBG5PcVLaf/ewYXugx21msoFkjKT1d5e50ESKnmBRKgrlne38Z3Um8TpHQU77X2VfK7c=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(83380400001)(44832011)(2616005)(426003)(8936002)(82310400003)(336012)(508600001)(86362001)(7696005)(1076003)(5660300002)(8676002)(36756003)(6666004)(6916009)(70586007)(47076005)(54906003)(16526019)(2906002)(26005)(70206006)(356005)(4326008)(36860700001)(316002)(81166007)(186003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2021 15:11:15.5238 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f5e9f2b1-5553-4e75-54c7-08d98fee0878
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2746
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

ROCr needs to be able to identify all devices that have direct access to
fine grain memory, which should include CPUs that are connected to GPUs
over xGMI. The GPU hive ID can be mapped onto the CPU hive ID since the
CPU is part of the hive.

v3: avoid quadratic search by doing linear list read instead querying per
proximity id

v2: fixup to ensure all numa nodes get the hive id mapped

Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index 98cca5f2b27f..dd593ad0614a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -1296,6 +1296,24 @@ int kfd_topology_add_device(struct kfd_dev *gpu)
 
 	proximity_domain = atomic_inc_return(&topology_crat_proximity_domain);
 
+	adev = (struct amdgpu_device *)(gpu->kgd);
+
+	/* Include the CPU in xGMI hive if xGMI connected by assigning it the hive ID. */
+	if (gpu->hive_id && adev->gmc.xgmi.connected_to_cpu) {
+		struct kfd_topology_device *top_dev;
+
+		down_read(&topology_lock);
+
+		list_for_each_entry(top_dev, &topology_device_list, list) {
+			if (top_dev->gpu)
+				break;
+
+			top_dev->node_props.hive_id = gpu->hive_id;
+		}
+
+		up_read(&topology_lock);
+	}
+
 	/* Check to see if this gpu device exists in the topology_device_list.
 	 * If so, assign the gpu to that device,
 	 * else create a Virtual CRAT for this gpu device and then parse that
@@ -1457,7 +1475,6 @@ int kfd_topology_add_device(struct kfd_dev *gpu)
 		dev->node_props.max_waves_per_simd = 10;
 	}
 
-	adev = (struct amdgpu_device *)(dev->gpu->kgd);
 	/* kfd only concerns sram ecc on GFX and HBM ecc on UMC */
 	dev->node_props.capability |=
 		((adev->ras_enabled & BIT(AMDGPU_RAS_BLOCK__GFX)) != 0) ?
-- 
2.25.1

