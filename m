Return-Path: <SRS0=oeKV=KJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11C38C433ED
	for <amd-gfx@archiver.kernel.org>; Fri, 14 May 2021 07:42:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A356961406
	for <amd-gfx@archiver.kernel.org>; Fri, 14 May 2021 07:42:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A356961406
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 51BE66EE32;
	Fri, 14 May 2021 07:42:43 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2065.outbound.protection.outlook.com [40.107.243.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F2DBF6EE32
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 May 2021 07:42:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G657p7POtNrE5w9CoIp3lvo4UUKJwQzgVTpB80Z4BIC90wYNj9xBPRpwznxbMq5TApOzC/SJ6t/aH686GzSskr1rxK++6ctk8imlXUuTn7Vah7IIQDM+cwbxiAGgSYMIKUnoA7BQDG2Lo0WMBQVDIMhu5IZxngyD7JpvKZMg6g83O9gzivXplA6ptVtErM9GMJrM8pnHptXXySGCIm+8y/O6zmxL7hqi4ZvF2EM8PXr0xVM1VRaSxN3fRW4urD8unRqrS3S0FMDDlVsLyppK4oN9EEANQEQ+9tRcelzJwIlAKdk6447az88cWxwxst9jTGOkukKYP7nAhTL0qmySMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tTg4GsmXApkKxCX4Qq/K8Yt6WDBogEJna+rvS718WmE=;
 b=AdnH5ihFnVnYGm9fZgVrBF+QqOHdOZ4akpBO5bYBIwZ7RHu+llA9SavNbgYYUONFIZi1NyDR2eUJvPOf/XwTvP00sQAdLUlYx6C7XIq/+tP0jfmW97Sfn74IeG7On/rzp2tC/l1J0G9UzuKDkhIa3r8dxTDC0mWtLFkL0crhEmF3P4chS75LB4NnpFmUT8mpcnq0AMEJezodi1czIdoFNelgzQiid8EAlc2F3QAtxICZvYpO7W95AgnVyCnwXwouVkhOHp9gOmA7t8daIdlETzpt9yxSsPh3QSMm5mBXg5W54RQwSJpEks+MjD2y3rQOdcemiZoYAZ1fyojJAK9NDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tTg4GsmXApkKxCX4Qq/K8Yt6WDBogEJna+rvS718WmE=;
 b=2tmf9RzapbIqpwdxAQcizL2sm/r/oC7ZnDEASc2DgtuTvrCllYgkq0nLhAkVlwW43IKylchhliN7RJceS8YrJkYVkGgyiLHSs9FgStuhsREYCxg48hLegzc79Cn5e65sbIHSPUb8ycx/cRgE4vF49uK8VhmNKouVj/GRyKKXvTo=
Received: from DM6PR12CA0026.namprd12.prod.outlook.com (2603:10b6:5:1c0::39)
 by BN6PR1201MB0051.namprd12.prod.outlook.com (2603:10b6:405:54::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.28; Fri, 14 May
 2021 07:42:40 +0000
Received: from DM6NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1c0:cafe::3b) by DM6PR12CA0026.outlook.office365.com
 (2603:10b6:5:1c0::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend
 Transport; Fri, 14 May 2021 07:42:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT036.mail.protection.outlook.com (10.13.172.64) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4129.25 via Frontend Transport; Fri, 14 May 2021 07:42:39 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 14 May
 2021 02:42:39 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 14 May
 2021 02:42:38 -0500
Received: from hawzhang-System-Product.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.4
 via Frontend Transport; Fri, 14 May 2021 02:42:37 -0500
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Alex Deucher <alexander.deucher@amd.com>, 
 John Clements <John.Clements@amd.com>
Subject: [PATCH 2/6] drm/amdgpu: switch to cached fw flags for gpu virt cap
Date: Fri, 14 May 2021 15:42:29 +0800
Message-ID: <1620978153-4564-2-git-send-email-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1620978153-4564-1-git-send-email-Hawking.Zhang@amd.com>
References: <1620978153-4564-1-git-send-email-Hawking.Zhang@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cbfab434-bdf4-456c-c5d3-08d916abd9da
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0051:
X-Microsoft-Antispam-PRVS: <BN6PR1201MB0051F8CCD75A33B06192138CFC509@BN6PR1201MB0051.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BdQb8EB/T8Z7SNKx547Wqtxh24vB/LNSraQSr0MDwSIrRtb76TZFvEIZpikxu5Z9oTcswMCTEjLfPnwbttFzNT3xV0O8eO+LxlIn0SlEqrm6Fsi8qKUOr6jLTPi8rEj2/BtbkAjxCmg46/p/YRwCh25TJJaB6gkrOaepoSaLAq67T5uSSqoXiXsGUCiR9M7/A4ITwZy44xzBjtKRplFJqdknTEHGqjL4+UhXNO9DbbKn88aWbYy2uqVtzZp8UDRxLZWw8WA5TGxB75u4mPB73+xDXyI6UbjFJrRv9yypXQ1BSWV5KSESiv5JKWRUcXBWmVnq8K7gRtpvjnklVd1pVscDI0aiaSuQQ5l7EvcAphtU3HUL+sTlySvm/p1eKFk6zKRZbwrARwuKCyJcmzTJ+zDyNwq8vFrtUtr3Z4Zv6/f7DuyZ/xRxnFlEhnxkocqeq27me7toBpN6An2wULlbVxuHfWBmIgZqD1dXD6u3uw3q7CMRZnvYVUog0Xxmdm5lqSni8vhSYBSm9+XKS+mXZZIvucQFxbVwb776wkkbvtrkY5YioMlXU5KNcSBIaMyDVpscy3A2n5rY8JMrv7FbrT7Qy22QYrJhi6sxxasPQR4xMlYBB4PFYEG4apoydmGlI3PuCgqXrIQxoZWzYPQwpexQQhqhTmPjbRmsSCjEDanf42xvECkjnjBKI06Y5EbA
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(376002)(136003)(346002)(36840700001)(46966006)(26005)(186003)(8676002)(7696005)(6666004)(478600001)(5660300002)(2906002)(316002)(426003)(336012)(2616005)(8936002)(47076005)(110136005)(82310400003)(36860700001)(81166007)(356005)(83380400001)(36756003)(82740400003)(86362001)(6636002)(70586007)(70206006)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2021 07:42:39.8918 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cbfab434-bdf4-456c-c5d3-08d916abd9da
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0051
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
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Check cached firmware_flags to determine if gpu
virtualization is supported in vbios

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c | 25 +++++++++++-------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.h |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c       |  2 +-
 3 files changed, 13 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
index c6eb07f..2cb8546 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
@@ -68,23 +68,20 @@ uint32_t amdgpu_atomfirmware_query_firmware_capability(struct amdgpu_device *ade
 	return fw_cap;
 }
 
-bool amdgpu_atomfirmware_gpu_supports_virtualization(struct amdgpu_device *adev)
+/*
+ * Helper function to query gpu virtualizaiton capability
+ *
+ * @adev: amdgpu_device pointer
+ *
+ * Return true if gpu virtualization is supported or false if not
+ */
+bool amdgpu_atomfirmware_gpu_virtualization_supported(struct amdgpu_device *adev)
 {
-	int index = get_index_into_master_table(atom_master_list_of_data_tables_v2_1,
-						firmwareinfo);
-	uint16_t data_offset;
+	u32 fw_cap;
 
-	if (amdgpu_atom_parse_data_header(adev->mode_info.atom_context, index, NULL,
-					  NULL, NULL, &data_offset)) {
-		struct atom_firmware_info_v3_1 *firmware_info =
-			(struct atom_firmware_info_v3_1 *)(adev->mode_info.atom_context->bios +
-							   data_offset);
+	fw_cap = adev->mode_info.firmware_flags;
 
-		if (le32_to_cpu(firmware_info->firmware_capability) &
-		    ATOM_FIRMWARE_CAP_GPU_VIRTUALIZATION)
-			return true;
-	}
-	return false;
+	return (fw_cap & ATOM_FIRMWARE_CAP_GPU_VIRTUALIZATION) ? true : false;
 }
 
 void amdgpu_atomfirmware_scratch_regs_init(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.h
index 77c5fb1..5d83729 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.h
@@ -27,7 +27,7 @@
 #define get_index_into_master_table(master_table, table_name) (offsetof(struct master_table, table_name) / sizeof(uint16_t))
 
 uint32_t amdgpu_atomfirmware_query_firmware_capability(struct amdgpu_device *adev);
-bool amdgpu_atomfirmware_gpu_supports_virtualization(struct amdgpu_device *adev);
+bool amdgpu_atomfirmware_gpu_virtualization_supported(struct amdgpu_device *adev);
 void amdgpu_atomfirmware_scratch_regs_init(struct amdgpu_device *adev);
 int amdgpu_atomfirmware_allocate_fb_scratch(struct amdgpu_device *adev);
 int amdgpu_atomfirmware_get_vram_info(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 6881015..7c6c435e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3034,7 +3034,7 @@ static void amdgpu_device_detect_sriov_bios(struct amdgpu_device *adev)
 {
 	if (amdgpu_sriov_vf(adev)) {
 		if (adev->is_atom_fw) {
-			if (amdgpu_atomfirmware_gpu_supports_virtualization(adev))
+			if (amdgpu_atomfirmware_gpu_virtualization_supported(adev))
 				adev->virt.caps |= AMDGPU_SRIOV_CAPS_SRIOV_VBIOS;
 		} else {
 			if (amdgpu_atombios_has_gpu_virtualization_table(adev))
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
