Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03476C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Jan 2022 11:19:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B8C910E5DE;
	Thu, 20 Jan 2022 11:19:02 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2077.outbound.protection.outlook.com [40.107.220.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BFFEE10E5D9
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Jan 2022 11:19:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AhJiIkkc6KaQggKj/6eprUglRqUgHekrm8J81dtjUEoeVMit0kLhXzDpE6AU1qVwhLkhJDrZYJBSiLdliYR5Wj7Utsis+p7NKEAj+9cSc5FNT1lKWWmlEtn1jvBHmt0MRcVP302uZBi7GMOKq7GNUgUFiJvPQixHscSV307oXZJhcbKEUVFzEcYWOt6vCtpwv2v6zERdfRXnYW3CCVoGiw/m+/aQ5BuKYjEM3d2mYRnZGbw/rnnNOHP3s7PBVyBz6BMEopvlCskHEU/NyPtoyyjkH5tSXWKAYqrbaYeadZ50w+UYSVNYVUZ18hXPZeQorrPuVGJ48F2G4Icvm+dE1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sHOY72OPZQtTic/opUg3olu3HGUFEpNty7fq/Q5zPZk=;
 b=CPmGgoTgA3Hf+c2kgCIUbU06kYNaBnDtkEk9PSfBdoMYsaNvfX4T1jnd1Xe1SCU/doHwGfMDAkmtttxc61vwCw2t6lzfTAcujigojIj1JZEZeE4dIWp7MQR7Zms5UhRRgFwtd0TrUbP6AOHmyFVPBneNLYVNdb83LmDBPK7WWaBXKAWnj0dXFAcUatxh4h1q6soV+PqmFk+0BAbJPnPqQq8I0O5olql/3p0bsvM7ou9aY7A2oP3EM/UAmCsN9fDcERZlqc3+zLqg3UVK/Xa/944HmiRMs2dJRBlhK+06THRNreKDYc+Vx19Gr8A3UvMT7iz9JpN+4ScYEGS3nlIFjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sHOY72OPZQtTic/opUg3olu3HGUFEpNty7fq/Q5zPZk=;
 b=Pkuqf71Q5UfDrOfZn3zKiYvz9YHAZU+Eq3MuJYn87uiPtTMqnotKELmmPLlqlqxTi5xoPw8wFiiEUdQtWCQlpNNcFiQ/ibgOw704pK8WPH22XOwxqHP3tKrJiPmHRxNpwiUadAPRJk9rvbH9KzY5aCIoFvst04UHlRZu8foRAVo=
Received: from MWHPR20CA0031.namprd20.prod.outlook.com (2603:10b6:300:ed::17)
 by MN2PR12MB4830.namprd12.prod.outlook.com (2603:10b6:208:1bc::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.12; Thu, 20 Jan
 2022 11:18:58 +0000
Received: from CO1NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:ed:cafe::44) by MWHPR20CA0031.outlook.office365.com
 (2603:10b6:300:ed::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8 via Frontend
 Transport; Thu, 20 Jan 2022 11:18:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT052.mail.protection.outlook.com (10.13.174.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4909.7 via Frontend Transport; Thu, 20 Jan 2022 11:18:58 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 20 Jan
 2022 05:18:57 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 20 Jan
 2022 05:18:57 -0600
Received: from hawzhang-System-Product-Next-Generation.amd.com
 (10.180.168.240) by SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP
 Server id 15.1.2375.18 via Frontend Transport; Thu, 20 Jan 2022 05:18:56
 -0600
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 1/9] drm/amdgpu: add helper to query rlcg reg access flag
Date: Thu, 20 Jan 2022 19:18:45 +0800
Message-ID: <20220120111853.11674-1-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7bf7a9ec-4a18-473b-8036-08d9dc06a764
X-MS-TrafficTypeDiagnostic: MN2PR12MB4830:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB48305967E37BE79A4A50213FFC5A9@MN2PR12MB4830.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2399;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oq9ytsr/RDc1LNc3m/Syrbidp/DlKW044Dn7XQjCyfpALiGmpBni/dXzRX/8oeru5uynnDkOuZB4k+Ye0ScqDkg8ClxPZwgXaph1f95ee8n6MYN9tbSFfTWbN0grTzy3Uebf+u5gyP4xnTD8cG78QgVZyOjVMrIj55YuID/t5OAqEJb7E+y3t8W7WiN8Tq7wMdarlJq7oxEGT6j/yUKx6ndDDCbaC/juysv692mupO25xb62ALeMd9xWR9Ik9S5r8/RECocbCm/um3sp54eIZLwTiI8xHnUTQUCmvRr6nTAZicgoJbP6V3min2/mDw/PY+vW6UzsDwyHTZarJLm4DtTu3Gwc1bwaEpJ9oXHrw8kpVSvSdvo4IKDalswCMuY67Ku1EyCjheR3Aj+ySWNLM52sScXvDx1qO6PMxQpBPfuGRcJUhl2zNPHoERlUSQqiwSmq5626OQWK6FFxESJoAUiK9zPIXZNfulpnfGTyEC6qXX6kAMl5nyRxw7y4aHgUmimXn+Yr+ZoqrNkMWqRzrPidDPR05lJ7LsCmpVg2adiWggvOEblWZKn2RTOuilpvFLk8JGHgFp9n6S1LGm15XY51P7t3ePOGVmkaoS7aHaXWrPWYJNEJHVXiEvU+qpnxARF+/tf6M3gwXLJTXYxIF49lzxPH5uA/M7GGl2dxFbUgizRbdoC3lsYEKitByJV2CH8LYQjyr4TItNuNiRwr0j6nSHiJg6sFHOIycihls24F8q2PLqeA6CQT63psxWAU68H7CGrcVD2iMdydhQTd0nXG9SNUMjbNUH2rm0JiinA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(40470700002)(46966006)(26005)(426003)(81166007)(356005)(2906002)(7696005)(8676002)(336012)(4326008)(8936002)(1076003)(6636002)(508600001)(36860700001)(6666004)(40460700001)(186003)(66574015)(83380400001)(86362001)(2616005)(36756003)(82310400004)(47076005)(70586007)(70206006)(5660300002)(316002)(110136005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2022 11:18:58.4213 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bf7a9ec-4a18-473b-8036-08d9dc06a764
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4830
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Query rlc indirect register access approach specified
by sriov host driver per ip blocks

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Zhou, Peng Ju <PengJu.Zhou@amd.com>
Acked-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 35 ++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h |  8 ++++++
 2 files changed, 43 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index 07bc0f504713..a40e4fcdfa46 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -820,3 +820,38 @@ void amdgpu_virt_update_sriov_video_codec(struct amdgpu_device *adev,
 		}
 	}
 }
+
+bool amdgpu_virt_get_rlcg_reg_access_flag(struct amdgpu_device *adev, u32 acc_flags,
+					  u32 hwip, bool write, u32 *rlcg_flag)
+{
+	bool ret = false;
+
+	switch (hwip) {
+	case GC_HWIP:
+		if (amdgpu_sriov_reg_indirect_gc(adev)) {
+			*rlcg_flag =
+				write ? AMDGPU_RLCG_GC_WRITE : AMDGPU_RLCG_GC_READ;
+			ret = true;
+		/* only in new version, AMDGPU_REGS_NO_KIQ and
+		 * AMDGPU_REGS_RLC are enabled simultaneously */
+		} else if ((acc_flags & AMDGPU_REGS_RLC) &&
+			   !(acc_flags & AMDGPU_REGS_NO_KIQ)) {
+			*rlcg_flag = AMDGPU_RLCG_GC_WRITE_LEGACY;
+			ret = true;
+		}
+		break;
+	case MMHUB_HWIP:
+		if (amdgpu_sriov_reg_indirect_mmhub(adev) &&
+		    (acc_flags & AMDGPU_REGS_RLC) && write) {
+			*rlcg_flag = AMDGPU_RLCG_MMHUB_WRITE;
+			ret = true;
+		}
+		break;
+	default:
+		dev_err(adev->dev,
+			"indirect registers access through rlcg is not supported\n");
+		ret = false;
+		break;
+	}
+	return ret;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
index 9adfb8d63280..404a06e57f30 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
@@ -32,6 +32,12 @@
 #define AMDGPU_PASSTHROUGH_MODE        (1 << 3) /* thw whole GPU is pass through for VM */
 #define AMDGPU_SRIOV_CAPS_RUNTIME      (1 << 4) /* is out of full access mode */
 
+/* flags for indirect register access path supported by rlcg for sriov */
+#define AMDGPU_RLCG_GC_WRITE_LEGACY    (0x8 << 28)
+#define AMDGPU_RLCG_GC_WRITE           (0x0 << 28)
+#define AMDGPU_RLCG_GC_READ            (0x1 << 28)
+#define AMDGPU_RLCG_MMHUB_WRITE        (0x2 << 28)
+
 /* all asic after AI use this offset */
 #define mmRCC_IOV_FUNC_IDENTIFIER 0xDE5
 /* tonga/fiji use this offset */
@@ -321,4 +327,6 @@ enum amdgpu_sriov_vf_mode amdgpu_virt_get_sriov_vf_mode(struct amdgpu_device *ad
 void amdgpu_virt_update_sriov_video_codec(struct amdgpu_device *adev,
 			struct amdgpu_video_codec_info *encode, uint32_t encode_array_size,
 			struct amdgpu_video_codec_info *decode, uint32_t decode_array_size);
+bool amdgpu_virt_get_rlcg_reg_access_flag(struct amdgpu_device *adev, u32 acc_flags,
+					  u32 hwip, bool write, u32 *rlcg_flag);
 #endif
-- 
2.17.1

