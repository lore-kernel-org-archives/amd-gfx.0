Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E7FBC433FE
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Jan 2022 08:51:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BDF7711AE9D;
	Fri,  7 Jan 2022 08:51:41 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2088.outbound.protection.outlook.com [40.107.92.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 10AA711AEA5
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Jan 2022 08:51:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eeymVZmGr2Y0PWRTt6/I7aI4+40NQAIM2EjS5QYh6IyS99hYIktWO6wkafRRRNPl7VGe7Y55CH4Yu/SIfwaKXY3Lz/J5vGeTiUFbzpZ6Z+kwoWDuGp9vzJ3ivftYj0kpxaxFNLBbGFNFUbi5OquruSaadeU7qohPf7iEAkVVrgUwxrQsG3VWGcGtv/XB0fCnKlxpRy71MM3DiccOhshrvVQa6N69xk4bVd6SrZB+7xId1PCn2l/9Q9ICCkCdte8y+80KCrJJahwLlzBR5sQ+rGaG1cXbTkF3f3MhpPB5xV5rLuelF/QKQi79kK8vtdi3blNtvGVaB+uskskJNutaVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pfbKp0X8kx35GzFLfhzOclpThr+WcSVpPqLJZtmgzRs=;
 b=IU/NY5hJajcSxsZIF1AjzlQCgPH2xQ9LP71CkUFjkiBs6vC9Z/p1GbrgOoIV+UuiESLvVMIim22MALpyyZUWu7K1KJZo5qqneYtqRkrNQtCgYQlvg4OGn5jnjDcDwyu46NgYfKved4Cd3SYH05R9caFd24aK7Y5nnJuGeVd8h16SSCuP7RNMGvBSZYkWeL9fORw+fxaLfJ/JeCWDeUqEvVnWgIiDl8jMjYGTTk/j2hJR2mMQ6zusFeBH4WIWY48f3KR6sfN2O/t8vVIwEa47KLoWI3WcLmqkDhW/bNSCUK0P6cMdMkhi/pRIA0CGl6xH2oAAcrLL0CTdLtJYdcgBJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pfbKp0X8kx35GzFLfhzOclpThr+WcSVpPqLJZtmgzRs=;
 b=Z7reFTfRWxBXTmKm2gBy+IPgGurunAnopQhVIpreaMxoPdicz+sXKY5j2xN5Bf49hfc3IQzN3Y5fz/vlKveXvkBPI5uDNzggVQO+LfhF9dwh3JhjMSBbpl7aUrgo6Oa4eHzEzeYqCiqqwKaCkqtW3BG7e/mzzDL29QWkVP9CKfc=
Received: from MWHPR17CA0091.namprd17.prod.outlook.com (2603:10b6:300:c2::29)
 by DM5PR12MB1531.namprd12.prod.outlook.com (2603:10b6:4:f::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4867.9; Fri, 7 Jan 2022 08:51:37 +0000
Received: from CO1NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:c2:cafe::97) by MWHPR17CA0091.outlook.office365.com
 (2603:10b6:300:c2::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7 via Frontend
 Transport; Fri, 7 Jan 2022 08:51:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT009.mail.protection.outlook.com (10.13.175.61) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4867.7 via Frontend Transport; Fri, 7 Jan 2022 08:51:37 +0000
Received: from brihaspati.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 7 Jan
 2022 02:51:35 -0600
From: Nirmoy Das <nirmoy.das@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/4] drm/amdkfd: remove unused function
Date: Fri, 7 Jan 2022 09:51:13 +0100
Message-ID: <20220107085115.8820-2-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220107085115.8820-1-nirmoy.das@amd.com>
References: <20220107085115.8820-1-nirmoy.das@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0f48688c-6926-404b-8db1-08d9d1baea47
X-MS-TrafficTypeDiagnostic: DM5PR12MB1531:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB153115559C324D95A7EC694E8B4D9@DM5PR12MB1531.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k9DJpXwQikZgXlN9YsK/ZidNIWe49M/1Kk0pCEmvaYtgPe1f0AfV2w061Yu6/s6h+edSwqnI1yxoP4bnRkI1m+BDz/nWI/TGw+u1Qgax8oaHkdPxNSV9l7cf2PfhC6XIIByMQJVfo4iZOYRqCgSZyEY30stIE3wmgGCubXspqmR9gaXp0z2vWEFI9RIcSztsB0qoi3XddmcT/F4c+u3UnNCNOtAJ0Fnisl5jRTjrS9Qz331EQ5CJSwVqB5GWHm7WoCBood0YcGvJteSUiM9dYBlj5fsPxHHK7yrnjDke+v7q3YAwX2IL7fB9+YqaQMrYmt+SfpRlVi1AakY88WFLdmK3XLEYjWBkf48Ha8Qu1+gHFP2C+3T9EvJwZugTvlmbpnNjuSxjAwo5Yx9Kc9mVevOczxv7FkI12S5XY1iKLvUjM/Yz5Xo03FAb15Shtw6bDxg8+eo4fQvUrhHgd+Ms5L+Cib4/mgyWOCmdwJWUQycggD3LX/PJHrolNo1QIB5k+ml/1y2N73klToHAfxkWvuOuYV5ZKoO4nMYbS8unEHtNI5AWwQl3WWZJjrJvXoyV1CGDCZGBNUXrKQ3Sex8uCoj0Vu1upBSL9a09OXxdkhDeN0Ds1hVIbAQhtz7pj7sqvt1MarwMywYJOyueQovbvuWDu64slfrvPuH+QSgu5HPJoMD0puaMF+C9apDO4MNatpoYhoW4S8TID04fZf9e3J4MIBA8oXgPvVwowJ+PPSkPX6INRgLiJg2oSk3AymLIevrqmqIPPpEXgRn9Ovn60iTngCk/bmKBEEtHGwTX5xA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(40470700002)(46966006)(36840700001)(44832011)(316002)(6916009)(7696005)(2906002)(356005)(81166007)(508600001)(36756003)(6666004)(70586007)(5660300002)(8936002)(26005)(86362001)(54906003)(16526019)(47076005)(186003)(70206006)(1076003)(8676002)(36860700001)(4326008)(2616005)(82310400004)(40460700001)(83380400001)(426003)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2022 08:51:37.2128 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f48688c-6926-404b-8db1-08d9d1baea47
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1531
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
Cc: andrey.grodzovsky@amd.com, Felix.Kuehling@amd.com,
 Nirmoy Das <nirmoy.das@amd.com>, Christian.Koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Remove unused amdgpu_amdkfd_get_vram_usage()

CC: Felix.Kuehling@amd.com

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 7 -------
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h | 1 -
 2 files changed, 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index 776a947b45df..6ca1db3c243f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -514,13 +514,6 @@ int amdgpu_amdkfd_get_dmabuf_info(struct amdgpu_device *adev, int dma_buf_fd,
 	return r;
 }

-uint64_t amdgpu_amdkfd_get_vram_usage(struct amdgpu_device *adev)
-{
-	struct ttm_resource_manager *vram_man = ttm_manager_type(&adev->mman.bdev, TTM_PL_VRAM);
-
-	return amdgpu_vram_mgr_usage(vram_man);
-}
-
 uint8_t amdgpu_amdkfd_get_xgmi_hops_count(struct amdgpu_device *dst,
 					  struct amdgpu_device *src)
 {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index 61f899e54fd5..ac841ae8f5cc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -223,7 +223,6 @@ int amdgpu_amdkfd_get_dmabuf_info(struct amdgpu_device *adev, int dma_buf_fd,
 				  uint64_t *bo_size, void *metadata_buffer,
 				  size_t buffer_size, uint32_t *metadata_size,
 				  uint32_t *flags);
-uint64_t amdgpu_amdkfd_get_vram_usage(struct amdgpu_device *adev);
 uint8_t amdgpu_amdkfd_get_xgmi_hops_count(struct amdgpu_device *dst,
 					  struct amdgpu_device *src);
 int amdgpu_amdkfd_get_xgmi_bandwidth_mbytes(struct amdgpu_device *dst,
--
2.33.1

