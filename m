Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D374BC4707B
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jan 2024 07:36:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F2D9210E0F6;
	Thu, 18 Jan 2024 07:36:06 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C259110E14A
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jan 2024 07:36:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZEm8OHSI53cj7zIL6pUKaJRCphtecBTi+3a+WrYWepoCO7oGlB0LN4h+6Y+zz6O7wJVkT67mxG3QhlhpMCE9pp49116FSGQdCwlFgKqb4mHh06urc05IsAJ9n+7iCShyh1HrApEuFiptrV3c5uWOQ4vrvxgLTDJ2wE2tYxl7tU6dsLOpQ5SQJ/ffoXHQw48ssSnpuHbJEa4Uu8Wx77xcm41NRzxZtD4Xrq8tUCA6UAoMm2T7A996FIGVPcts0srHT6oFNYe87zKGEwbU4iW/iLb+dGzy29jS7XaRkeJw0s7OJqGhBadIs5zUA8AFdP8ugzDTKA5fbzvIL4fh/Uk/CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TntpUh58sL5nrkL9ISMgXVw1FnN8BY3QcX0XD/FIxkA=;
 b=m16sTwr+/1JiEx8KAHzidQTE0W4F6CKftY8wKe96A2f2E0c6SdG1dovt2KEk7hbMLQKId7XIdpXny90pKWDSD5ZYI4EQ9u3F1vGz0pWBGKk3/u5k09ZCe8WJBGRQsc6M+5q3WtiIXwK0xOyBTShy3dVV2SXuY79fReHZLJgWMCayfBjtpU5Fbi/EswaV9UX/r6PXLaL+cPdvtjMZtGZgjO760CD1Fy/OcnEtcm5/6ep7bbIN3tF6SLoVSDXHj+zsBc1I+wwT1OIjbdqP7wrVkJqeh7r9GJoom3GKN5WuAurIfdA4MXzac1BIw/W9Yn5uukzk04cwOsxVXMBBuwopfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TntpUh58sL5nrkL9ISMgXVw1FnN8BY3QcX0XD/FIxkA=;
 b=b82jAbNyDZFwW7vgw3JJBW73IVVJ7HfKz9zrJPLg42qoZPO4d397Bnt5usLm7i/YAU4GdjmpbxiNCkH62mk7OC/FgAqN0FnP3eMa4tbH6qPsNw+eS6QxfvwAOsgNe+UfUq/fnPm/FhprJ2nAxmbeke63iNZs1A7A2U6+8SmBEUQ=
Received: from MN2PR20CA0017.namprd20.prod.outlook.com (2603:10b6:208:e8::30)
 by CYXPR12MB9278.namprd12.prod.outlook.com (2603:10b6:930:e5::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.19; Thu, 18 Jan
 2024 07:36:02 +0000
Received: from BL02EPF0001A0F9.namprd03.prod.outlook.com
 (2603:10b6:208:e8:cafe::d4) by MN2PR20CA0017.outlook.office365.com
 (2603:10b6:208:e8::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24 via Frontend
 Transport; Thu, 18 Jan 2024 07:36:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0F9.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Thu, 18 Jan 2024 07:36:01 +0000
Received: from tao-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 18 Jan
 2024 01:35:56 -0600
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] update check condition of query for ras page retire
Date: Thu, 18 Jan 2024 15:35:41 +0800
Message-ID: <20240118073541.107391-2-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240118073541.107391-1-tao.zhou1@amd.com>
References: <20240118073541.107391-1-tao.zhou1@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0F9:EE_|CYXPR12MB9278:EE_
X-MS-Office365-Filtering-Correlation-Id: 6dffe745-76ac-4d0d-0d3a-08dc17f81ef0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K9WqJDoaeYDfmKLl11p+xqm8Z2P55ej21X6OsQ+et+BZ3VL+qPAYloINNI8MFKu2cDHIPVdKPsvDFybMUec757FuRyNeGG3V3F1YBi9L+MFuAPdt3+povYbw5JmJ32/yL9xunAqjhMVK2b/fa5EFZABSkC+uPzda/KlD9Q/Jv/zPuKGhDMD89dZpT+eDYKMuzf4nTnN7hGqwd9NulW5jAF3VPkKfnfsjikDBkarErm6oxumOP37iG2eIAQjdKkATNrbD9eqjM9vJV4gpW9/WQTKLeMaT0DCql92FheaZbDzxfAgEEtMnxKP+yydFA5H/GBe8yDbp6Fkls0hJT9s9QRVauuxhbvFwZ0I1jcrlvhFNa7jb7yPFMRmsCkIzUj7MjO0YnfYLSp4Tb5iLQEUTyBMd5UDL1tbz6fCWef2Rt4xu1n+VWFOziqyMRcqFFEkfuFGrYQP4JMr9ZxB8oje/UTp9GN2LRmEhC/6NplUMWyUBPQrR6Zi9UMVzEtbL32+g4tKzLqi8fllzSRdFljz9SESJTDRZvxQCIvlBcEG1Qe8R3Ga1zCsGbzLtNl9l4IQW9jx2LgoNtsqyLbWusATevfdoxuhziGKEn3wGyB4MuJ0Em5E0Ft+m3jgPIhrikHCrkaVLOTddqQVvM+vQKeS7swgTaY4RcLQ4IELccDTFf9IMO3kgzodYtvIIFnHQjWjgXfpEojR4Modo3huGGu+mOiUm+1Q5LxsOl/BNVnWt76m9EGuZmd5LicAO7cWgxF5HXm5B0QMC6bpKJR2/FhC/yw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(346002)(396003)(376002)(39860400002)(230922051799003)(451199024)(82310400011)(64100799003)(1800799012)(186009)(36840700001)(40470700004)(46966006)(82740400003)(356005)(47076005)(336012)(2906002)(36756003)(5660300002)(8676002)(26005)(86362001)(41300700001)(6666004)(478600001)(36860700001)(426003)(2616005)(1076003)(70586007)(16526019)(8936002)(83380400001)(7696005)(4326008)(70206006)(6916009)(316002)(81166007)(40480700001)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2024 07:36:01.7832 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dffe745-76ac-4d0d-0d3a-08dc17f81ef0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0F9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9278
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
Cc: Tao Zhou <tao.zhou1@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Support page retirement handling in debug mode.

v2: revert smu_v13_0_6_get_ecc_info directly.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
Change-Id: I0aaa807d7fe87b3da0f023c380e57ab6dd446fcf
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
index 9d1cf41cf483..d8d263956e85 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
@@ -93,11 +93,14 @@ static int amdgpu_umc_do_page_retirement(struct amdgpu_device *adev,
 	struct ras_err_data *err_data = (struct ras_err_data *)ras_error_status;
 	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
 	int ret = 0;
+	unsigned int error_query_mode;
 	unsigned long err_count;
 
 	kgd2kfd_set_sram_ecc_flag(adev->kfd.dev);
+	amdgpu_ras_get_error_query_mode(adev, &error_query_mode);
 	ret = amdgpu_dpm_get_ecc_info(adev, (void *)&(con->umc_ecc));
-	if (ret == -EOPNOTSUPP) {
+	if (ret == -EOPNOTSUPP &&
+	    error_query_mode == AMDGPU_RAS_DIRECT_ERROR_QUERY) {
 		if (adev->umc.ras && adev->umc.ras->ras_block.hw_ops &&
 		    adev->umc.ras->ras_block.hw_ops->query_ras_error_count)
 		    adev->umc.ras->ras_block.hw_ops->query_ras_error_count(adev, ras_error_status);
@@ -121,7 +124,8 @@ static int amdgpu_umc_do_page_retirement(struct amdgpu_device *adev,
 			 */
 			adev->umc.ras->ras_block.hw_ops->query_ras_error_address(adev, ras_error_status);
 		}
-	} else if (!ret) {
+	} else if (error_query_mode == AMDGPU_RAS_FIRMWARE_ERROR_QUERY ||
+	    (!ret && error_query_mode == AMDGPU_RAS_DIRECT_ERROR_QUERY)) {
 		if (adev->umc.ras &&
 		    adev->umc.ras->ecc_info_query_ras_error_count)
 		    adev->umc.ras->ecc_info_query_ras_error_count(adev, ras_error_status);
-- 
2.34.1

