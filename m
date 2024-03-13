Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6B09C54791
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Mar 2024 09:41:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD8D910F077;
	Wed, 13 Mar 2024 09:41:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="c9CZhZnk";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1469F10F077
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Mar 2024 09:41:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lJv1h83TZB3XWj+raUd0SrNrhBnrtCOTLGRYamONWbdV5VWfvJECsjpieinyOZkZm/xNNJK0my/a4AAQlPwMfRGZO+VSCnwRe61RHkA6bEPzGrEDdySOmFtluBU4AmU4VAILEhke8AlIPrAuLm/pUWogYPy6BdVgSgCtitK9YqNlyMpinnmOIe2JlzjsHhZrdTYKc6kxyJeNhtpFo7E16DkMSHO8PE7HtEgQdtqVz2BVqEtMjd3bJZt4rt1QQg8u6f0ouinFBaQeymnaCpEoBWO4IJkpwLd3liHZ4Eds3phEY/rALCeyEe3pmO/GpEe04Dn/Ok8fIG1N6Q4VBY5HWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GFScBVfwgNW8tGV39ZRkNK7Mp+ZNKx9o2R1PW34qdbs=;
 b=lZXKIY0jl83ASvOeXS+V7gRXwSM05rsE9rj1K7H6NurJBVnXth+HlYXTEqf+fmvGthWD6cFSHxuLgTtfi7/RTOhFf7rEg6wYVFfQZsL6uJfeAJw0Qu5wHeBrTqmV8L4KjfbTFgmWZblLyh/hsxGI9elvtftlYKLJ2JDHJ8cx0bMlja1WEesErd7TEeYbonwyMi2EDCESyFNS7PR3iPXBbtBiY0itfxjxICaxtwPLmlaHpN9Y5q1FrQsqXRc30DSaYUWv4DYJDFwQQ3kadAAR24n6qpiG9SiwKaR5khl0Lg7nD4Y9fgxK/45KdoCe9AzbNd7f0OX/u6ge2EAuuNsGtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GFScBVfwgNW8tGV39ZRkNK7Mp+ZNKx9o2R1PW34qdbs=;
 b=c9CZhZnkC6lDJ9Rcy2W85aCo+kDQH8zCexpWaDBL8IkiPjj4rdKpoDgoR9MeF4Z7MHXN8yXFRFxqna4PBEpaA8Q5K83lnl0FOdU4Kc0fgZwxOnFqBfhoscKLNV+BhPADNDAkrjQ1uhZV5f03Lk4XuGUDHxGeoVtUgOEXaanY+L8=
Received: from BN9PR03CA0973.namprd03.prod.outlook.com (2603:10b6:408:109::18)
 by PH7PR12MB6538.namprd12.prod.outlook.com (2603:10b6:510:1f1::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Wed, 13 Mar
 2024 09:41:51 +0000
Received: from BN3PEPF0000B372.namprd21.prod.outlook.com
 (2603:10b6:408:109:cafe::10) by BN9PR03CA0973.outlook.office365.com
 (2603:10b6:408:109::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.18 via Frontend
 Transport; Wed, 13 Mar 2024 09:41:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B372.mail.protection.outlook.com (10.167.243.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.0 via Frontend Transport; Wed, 13 Mar 2024 09:41:50 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 13 Mar
 2024 04:41:48 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <Asad.Kamal@amd.com>
Subject: [PATCH] drm/amdgpu: Do a basic health check before reset
Date: Wed, 13 Mar 2024 15:11:32 +0530
Message-ID: <20240313094132.668370-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B372:EE_|PH7PR12MB6538:EE_
X-MS-Office365-Filtering-Correlation-Id: bbfb28e4-b04f-4d26-7a36-08dc4341cefd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R9IKXgDHgdeqH2ZEXFkYsnCk5NsPUqiZKpRh3WBz19NW/pq3Ns8jNsEue+JjZD++qJKlkm4ayZ+9PIbRRpLIYIBQG6uceYh6eJ762cB5WU8i4Vg7rPOQo5FXVvULzjaxV9sv+Add0URGfHAqhlGqWrA9y5/cNusqPdhv6qX0+8Kv8pShMdPwF4yWgWogBozCsrAJkBwhQ1bm5mASZhM6MB+Td0IFeSWtKS7yS16bQuyJPBUnqAilOrZKqpeXiMxwn9mqitUDiEpnI5l/GTqCNdUnvq+L1zRR7OfADfNbPFEASY/k6SdEYTiT/DjhxJvgaHwj8fx0xdfV4kdtbdAYDpmdXgSQcKnWVf8P++ukms40/x0i1nse1sJW4YvLcA/YlVO0TcPxTZY8PpAKrKUTRTiRROyZfkPGfi8ybt5nLv1WQQ9ljFWo812VJcB2oeDBjUYIpGp/3DbjwPaFIHWZ+gUFgwXuyKCy+JxE4PbxJk+gAzozBd8el3fLOLdBol5QmPTCFd+RnfFtKnsQ9acYVwxHLxTa5W4nLEaFUURkGIEdIjrKhErvdsDxAG8uYEzsnn78wnXcp0CJKVaXyp6XrB2Xjkh7jnjYWMiPk6/YWitG6R4eB+2SO1eKGYG+QHENlNQp9R1kV/KrKXtuMZXmp7E+J3weS8gYrnIq8FwryiI0Q0YYweidJ8K4T7oT+giB+ptCIyq0mu3NEzlR1Bv5bQPeiCtK9S1KXqfHt2q+mIdsm6ZxlkwRaYpn8vEBZcyh
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(36860700004)(1800799015)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2024 09:41:50.4108 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bbfb28e4-b04f-4d26-7a36-08dc4341cefd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B372.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6538
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

Check if the device is present in the bus before trying to recover. It
could be that device itself is lost from the bus in some hang
situations.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 24 ++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 1e9454e6e4cb..b37113b79483 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5536,6 +5536,23 @@ static inline void amdgpu_device_stop_pending_resets(struct amdgpu_device *adev)
 
 }
 
+static int amdgpu_device_health_check(struct list_head *device_list_handle)
+{
+	struct amdgpu_device *tmp_adev;
+	int ret = 0;
+	u32 status;
+
+	list_for_each_entry(tmp_adev, device_list_handle, reset_list) {
+		pci_read_config_dword(tmp_adev->pdev, PCI_COMMAND, &status);
+		if (PCI_POSSIBLE_ERROR(status)) {
+			dev_err(tmp_adev->dev, "device lost from bus!");
+			ret = -ENODEV;
+		}
+	}
+
+	return ret;
+}
+
 /**
  * amdgpu_device_gpu_recover - reset the asic and recover scheduler
  *
@@ -5607,6 +5624,12 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 		device_list_handle = &device_list;
 	}
 
+	if (!amdgpu_sriov_vf(adev)) {
+		r = amdgpu_device_health_check(device_list_handle);
+		if (r)
+			goto end_reset;
+	}
+
 	/* We need to lock reset domain only once both for XGMI and single device */
 	tmp_adev = list_first_entry(device_list_handle, struct amdgpu_device,
 				    reset_list);
@@ -5772,6 +5795,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 					    reset_list);
 	amdgpu_device_unlock_reset_domain(tmp_adev->reset_domain);
 
+end_reset:
 	if (hive) {
 		mutex_unlock(&hive->hive_lock);
 		amdgpu_put_xgmi_hive(hive);
-- 
2.25.1

