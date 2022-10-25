Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5042C38A2D
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Oct 2022 19:21:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 00AA610E0E4;
	Tue, 25 Oct 2022 19:21:29 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 00BEA10E0DE
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Oct 2022 19:21:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dxidarpiTNNyr9dAdCk7ZX2S3av8xDBOLglinbqqUBBMJPiYYbsv+Yk9GWmpU6e8yJMaOZlj/cBU+p/elu8fDcrGTuJ9f1mwPUrzyF2xwMdIyvpaJpUvTg9h5k5H/z7QBXQZhwCSGPMiYIJnA3t1tvDZUNlKhegI7IMdJMi1oM4QP7lBQAD0ZOo/Ji9ZbCiZPEzKbUV4oxBDDPbU3Z6guNoy+7mdWDWh2L4C3LAX4hqXXCcCTXx83UKwTUVCV+UZJ1O6korkiANq4eOgClCMpfQWyfFPFryY243wJkW/pnw56pAKAxJYY+IZGWdT3xFz5sGFZgL/J9CWyk14TrgeTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=COSHpe0B12x+2wXV1w3mYqnqrtYMiZibBM96MmsbyD0=;
 b=WNuJweo00KXKoMKxQI4H8nmoEcvZivf52XZ1uAUdwKaDPL/2u2Fv1xeAW0OAIlzc0RjJzTIzfcz0SONhzlcxeXij+vGbHDiCPxnoPqLK0ZPv9k4Qp3Sq5LzEdRUUkdgan89Yvx00XYcG0WJccQOKJlj8Xnj3K8ZwC/UAxKCJOSslECBF+uZxqk3aG0fE4zMhYgpg2yo/MFrm1pSnifd0HtpDlVn4fI7jDR04KFxjUiji3Iprb9yqmBr70a2rvmsIGkIpQXw3K9HkHTyzG+otQ6RjtZ6YOdWwr7xW6tvrGW346sCruWyIEA8PiPOXBk5o3pcRcPbRqYjEiIzSH8UDuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=COSHpe0B12x+2wXV1w3mYqnqrtYMiZibBM96MmsbyD0=;
 b=CzySaLez+rw1gTancAy+CMi/qM468X5JAAJIIRCawBul3F6PYbZNTjF19exJQXICMaArSIJ+qJt+xP8x2t18CprHtqCx6aW0CM9ZI8QeGnmxP+XbK+woFSnWNyw1CPdUegVMg2Wvs+3i0d+jKdmxQY55EqLrtNRxcK9x0eMFN2k=
Received: from DS7PR05CA0097.namprd05.prod.outlook.com (2603:10b6:8:56::26) by
 IA1PR12MB7616.namprd12.prod.outlook.com (2603:10b6:208:427::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.30; Tue, 25 Oct
 2022 19:21:24 +0000
Received: from DM6NAM11FT112.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:56:cafe::91) by DS7PR05CA0097.outlook.office365.com
 (2603:10b6:8:56::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.8 via Frontend
 Transport; Tue, 25 Oct 2022 19:21:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT112.mail.protection.outlook.com (10.13.173.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5746.16 via Frontend Transport; Tue, 25 Oct 2022 19:21:24 +0000
Received: from mkgs-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 25 Oct
 2022 14:21:23 -0500
From: Graham Sider <Graham.Sider@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu: remove deprecated MES version vars
Date: Tue, 25 Oct 2022 15:20:56 -0400
Message-ID: <20221025192056.647389-2-Graham.Sider@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221025192056.647389-1-Graham.Sider@amd.com>
References: <20221025192056.647389-1-Graham.Sider@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT112:EE_|IA1PR12MB7616:EE_
X-MS-Office365-Filtering-Correlation-Id: 83f8967b-0a4d-4263-4a23-08dab6be1b5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lUtM+G977rXl7mbAid0FyJFRewdBSp5H4x2uITSEfeIU7JuqOPKLyzDbriU5G70qDftIyf0IMSvGd98zDZpFNNhDmtQ20OFQJOmiB0RIqjDbpI0L3D3QHjZD4SX96VM2BRKNnyOryj3hQ3/FqfzORGD+lAwoBLVvpph54xROHePb8J5TXTkt12gKWeLlu7cfriIbKrnJs0GT6D4Oc9NoolreJeqNvGryGI+yAk5O027Vq4BgSTrqlBA3/Gw4Evs6AxE14OLDWrN4dFUFlz0NwdlspBy1oe7cz5ZLs5cMBaIG2ESuPifx1ORBetvQlkvq9FHDUhWe/9UuFpCEhT4cT1mI2KdkhqDUXwini60MF6vC+RZ9s4R7ElOsK7y7imLcOzyy5G0KV0yI/nm2Fh/bf21D74hB88E8EmKUI2CY7oGSeZGpyMM2k3cDsjC8eGG+ngTPjABvsQ/rMKJ/XaPweVCXzyvGakW9qI815tHLmR8LaGVbCzWNjGT5IlH9zJ9gnDpuQDV+kZcrPlkbRoRO8A0gnbxD4cX8us2tUUd3NJACjoslrczkNy5ByMl9pDOMc8dGXFuK9xPCRzTORJugcwnQLoC0HNDKGsI6snAjsfrlodiZDOHtbUg9zpocb5myxEmec3R44moFhartRDy8+g18eSBtdKHTGFgbJ4X6ivP8z3j6H/Nz1IeWQxB9tfgFRtGsNxSD327SEoZ14OTn9CmWvNpgRPlD2IViTdbzk55McIwCHCV/9ZNxwq7If05YJNIw97if48YtjolKhjW/a7qj20YV1hEj4SXtCXI8QnjtHkL16GbY94Zcfi28XHPM
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(396003)(376002)(136003)(39860400002)(451199015)(46966006)(36840700001)(40470700004)(16526019)(83380400001)(186003)(2616005)(336012)(1076003)(2906002)(4326008)(86362001)(7696005)(41300700001)(70206006)(40480700001)(40460700003)(8676002)(426003)(47076005)(82310400005)(478600001)(82740400003)(81166007)(356005)(36756003)(70586007)(316002)(6916009)(26005)(8936002)(36860700001)(54906003)(6666004)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2022 19:21:24.4992 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 83f8967b-0a4d-4263-4a23-08dab6be1b5f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT112.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7616
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
Cc: Jack.Xiao@amd.com, Graham Sider <Graham.Sider@amd.com>,
 Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

MES scheduler and kiq versions are stored in mes.sched_version and
mes.kiq_version, respectively, which are read from a register after
their queues are initialized. Remove mes.ucode_fw_version and
mes.data_fw_version which tried to read this versioning info from the
firmware headers (which don't contain this information).

Signed-off-by: Graham Sider <Graham.Sider@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h | 2 --
 drivers/gpu/drm/amd/amdgpu/mes_v10_1.c  | 4 ----
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c  | 4 ----
 3 files changed, 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
index ad980f4b66e1..97c05d08a551 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -91,14 +91,12 @@ struct amdgpu_mes {
 	struct amdgpu_bo		*ucode_fw_obj[AMDGPU_MAX_MES_PIPES];
 	uint64_t			ucode_fw_gpu_addr[AMDGPU_MAX_MES_PIPES];
 	uint32_t			*ucode_fw_ptr[AMDGPU_MAX_MES_PIPES];
-	uint32_t                        ucode_fw_version[AMDGPU_MAX_MES_PIPES];
 	uint64_t                        uc_start_addr[AMDGPU_MAX_MES_PIPES];
 
 	/* mes ucode data */
 	struct amdgpu_bo		*data_fw_obj[AMDGPU_MAX_MES_PIPES];
 	uint64_t			data_fw_gpu_addr[AMDGPU_MAX_MES_PIPES];
 	uint32_t			*data_fw_ptr[AMDGPU_MAX_MES_PIPES];
-	uint32_t                        data_fw_version[AMDGPU_MAX_MES_PIPES];
 	uint64_t                        data_start_addr[AMDGPU_MAX_MES_PIPES];
 
 	/* eop gpu obj */
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c b/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
index 067d10073a56..1abdf8b7ab50 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
@@ -415,10 +415,6 @@ static int mes_v10_1_init_microcode(struct amdgpu_device *adev,
 
 	mes_hdr = (const struct mes_firmware_header_v1_0 *)
 		adev->mes.fw[pipe]->data;
-	adev->mes.ucode_fw_version[pipe] =
-		le32_to_cpu(mes_hdr->mes_ucode_version);
-	adev->mes.ucode_fw_version[pipe] =
-		le32_to_cpu(mes_hdr->mes_ucode_data_version);
 	adev->mes.uc_start_addr[pipe] =
 		le32_to_cpu(mes_hdr->mes_uc_start_addr_lo) |
 		((uint64_t)(le32_to_cpu(mes_hdr->mes_uc_start_addr_hi)) << 32);
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index e14f314902b1..27a330f51c7d 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -480,10 +480,6 @@ static int mes_v11_0_init_microcode(struct amdgpu_device *adev,
 
 	mes_hdr = (const struct mes_firmware_header_v1_0 *)
 		adev->mes.fw[pipe]->data;
-	adev->mes.ucode_fw_version[pipe] =
-		le32_to_cpu(mes_hdr->mes_ucode_version);
-	adev->mes.ucode_fw_version[pipe] =
-		le32_to_cpu(mes_hdr->mes_ucode_data_version);
 	adev->mes.uc_start_addr[pipe] =
 		le32_to_cpu(mes_hdr->mes_uc_start_addr_lo) |
 		((uint64_t)(le32_to_cpu(mes_hdr->mes_uc_start_addr_hi)) << 32);
-- 
2.25.1

