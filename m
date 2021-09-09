Return-Path: <SRS0=g6Hj=N7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1F42C433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Sep 2021 07:15:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 881F160F13
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Sep 2021 07:15:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 881F160F13
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A0916E44D;
	Thu,  9 Sep 2021 07:15:22 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2050.outbound.protection.outlook.com [40.107.220.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 752446E44D
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Sep 2021 07:15:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eSYmljHXMoSGTTqEuUcoL5Z7+AARTzch1YwPNqBGk0LKMnAdvZNkSmvYU6sroo22udMU9NEQfcxmT6F8N2P77tA99fwKEyQ43M1Wr7EsvI8ERG+JlAKmWHn2qhdsaXeGNOq7ScXWoBjdKmF65iU7vUbmQMKLFXru9nrtwF4VJP63rX9bXQEmYEzf9jGc9h/8qK2wqzC0wAketvXFvmiKmg+KAc5BPzyEO9ln+5VZC/sAOhmb21O75nwpZ1QWHUFF5ivKc9eIsHrJp2OeZ1NbtFn5CL49X0T7/xoElYhiNxB1NyranNnRwM0/tLXauhJrYeOLaZ0tg8ZhXYM2zhlhvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=xtCDqkboyKG1x1y+BZ1agCftgYMOuT29BPS/hxYrELI=;
 b=Fu9S/VGUo5vvqrDqSW/IMBrwXuRxPv7LH9anQMmQLyGGI8xq8M9VGWubCqGXtad1tmhPh0x28ZiC4PkFNSb9syJbY1MTznXIfAyayaW4zbQsKdXx2feb7vwaTAdxAnW5R98oAHKlIucX+8MWXhyNIb1/tGaDL9BLPdSpee1w/mdnsz/c89f//7iJFT0BGMsmeKBejAjqwmz4V+R1SOq4Io7OcFfJCe421xOyFu5965fzomsy++uJsssgdZHoeWJ0NGvX4YgekrXU4lRgVzuIipRElUI6OR6uFQyhxrx5kN7rPwnZvW+Wtl3jkA0rpD5h7MuhSqCwwE6y6KNpnwmrBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xtCDqkboyKG1x1y+BZ1agCftgYMOuT29BPS/hxYrELI=;
 b=YyBOlL1XL7bZk2LUy7qZMuBOd4fPpGuGSIDc+KYCqQlteGxH8NtVBdnBmwUenUc3atMh7p/Rzv6OEpfMmU1g8h5XRfSR5i6SySvzK/ublkBgnUBOMrMT/+mO4aVXni60nbTDE/lsV9iA0Md3nBKsPxgbork3owC+3dLoWJO05EA=
Received: from DM5PR07CA0033.namprd07.prod.outlook.com (2603:10b6:3:16::19) by
 CH0PR12MB5107.namprd12.prod.outlook.com (2603:10b6:610:be::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4500.14; Thu, 9 Sep 2021 07:15:19 +0000
Received: from DM6NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:16:cafe::fa) by DM5PR07CA0033.outlook.office365.com
 (2603:10b6:3:16::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend
 Transport; Thu, 9 Sep 2021 07:15:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT060.mail.protection.outlook.com (10.13.173.63) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4500.14 via Frontend Transport; Thu, 9 Sep 2021 07:15:18 +0000
Received: from lnx-glk.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Thu, 9 Sep 2021
 02:15:16 -0500
From: Likun Gao <likun.gao@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Hawking Zhang <hawking.zhang@amd.com>, Likun Gao <Likun.Gao@amd.com>
Subject: [PATCH] drm/amdgpu: refactor function to init no-psp fw
Date: Thu, 9 Sep 2021 15:15:02 +0800
Message-ID: <20210909071502.3322586-1-likun.gao@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 95d9980f-7809-4e7a-b9a8-08d97361947a
X-MS-TrafficTypeDiagnostic: CH0PR12MB5107:
X-Microsoft-Antispam-PRVS: <CH0PR12MB5107A94FB59C69E4B29C1477EFD59@CH0PR12MB5107.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cwU3VpfNOB70ADZTi71/3HqDL/Nm+ftDZEgcYa+KuqXDSQ9IN71UKSzUWKJpy4GeCl+HGg+y/zShkksRnG4wUj9/lYKGjYw+8mVYFve0fB2wpAYKsLDiEKMfXQrTlsd1yzJH1GQfQGhDzEwkzxcb45gYipiRXJbdlteAqz1XRplVmpX/Vv2pvs92/2pLJwjJalY718ANgFjXPP+4V6qOJxDPW1TY/ukKxMkSB/oeZNxCThhSPpEfFcps/IPzO4ezj38p5xtbgHv3zcrF/DWRzp305Z8HVLlEELEaQfV6pfoDEemvu/xUtZOeWaGnteJqtQBU2WzGWTLldq84z/t1NPOS0hCE8L6TPTg73f1S8s5orMBSqnCxFYGVXjh0XFzVgc6DCtnEfYExQrHSPdSEu0MA9vz317e2bNQdg5UkQZSU7UYR86EjCnx9eBVlhnXBPTXsHu1d5yaYR5OXWKLDYj5aQjnTVUsL0SnXp572wHNbbVc70JXgLYJAD906EaddyKwHy+9x2O+xgtxBFyzlLG/EZGTl5I/g/+vlnsuuQ38f8/f144QqvaACAQCNqRDf9KvmpbNiMK2Vg6l1YrJ2+h8C6P8CgWFb7OaB6mXFzj6FvH+9CvNvwWoCcPU2hHY1PuEuhrvACJqvleb2wE5wmH5p6IJ8XZJWtInACAsUF4tGO/2ly9TRSlfKrRhsiUmdJO6zXFS4Bst1MtVaUdmWhDqU8jXiNeSFQUsoMGRgipo=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(376002)(136003)(346002)(36840700001)(46966006)(186003)(7696005)(16526019)(26005)(36860700001)(44832011)(82740400003)(4326008)(2616005)(47076005)(70586007)(336012)(426003)(6916009)(70206006)(478600001)(54906003)(8676002)(36756003)(6666004)(83380400001)(81166007)(316002)(2906002)(86362001)(82310400003)(8936002)(5660300002)(356005)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2021 07:15:18.8829 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 95d9980f-7809-4e7a-b9a8-08d97361947a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5107
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

From: Likun Gao <Likun.Gao@amd.com>

Refactor the code of amdgpu_ucode_init_single_fw to make it more
readable as too many ucode need to handle on this function currently.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c | 160 ++++++++++------------
 1 file changed, 75 insertions(+), 85 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
index abd8469380e5..5f396936c6ad 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
@@ -572,6 +572,7 @@ static int amdgpu_ucode_init_single_fw(struct amdgpu_device *adev,
 	const struct dmcu_firmware_header_v1_0 *dmcu_hdr = NULL;
 	const struct dmcub_firmware_header_v1_0 *dmcub_hdr = NULL;
 	const struct mes_firmware_header_v1_0 *mes_hdr = NULL;
+	u8 *ucode_addr;
 
 	if (NULL == ucode->fw)
 		return 0;
@@ -588,94 +589,83 @@ static int amdgpu_ucode_init_single_fw(struct amdgpu_device *adev,
 	dmcub_hdr = (const struct dmcub_firmware_header_v1_0 *)ucode->fw->data;
 	mes_hdr = (const struct mes_firmware_header_v1_0 *)ucode->fw->data;
 
-	if (adev->firmware.load_type != AMDGPU_FW_LOAD_PSP ||
-	    (ucode->ucode_id != AMDGPU_UCODE_ID_CP_MEC1 &&
-	     ucode->ucode_id != AMDGPU_UCODE_ID_CP_MEC2 &&
-	     ucode->ucode_id != AMDGPU_UCODE_ID_CP_MEC1_JT &&
-	     ucode->ucode_id != AMDGPU_UCODE_ID_CP_MEC2_JT &&
-	     ucode->ucode_id != AMDGPU_UCODE_ID_CP_MES &&
-	     ucode->ucode_id != AMDGPU_UCODE_ID_CP_MES_DATA &&
-	     ucode->ucode_id != AMDGPU_UCODE_ID_RLC_RESTORE_LIST_CNTL &&
-	     ucode->ucode_id != AMDGPU_UCODE_ID_RLC_RESTORE_LIST_GPM_MEM &&
-	     ucode->ucode_id != AMDGPU_UCODE_ID_RLC_RESTORE_LIST_SRM_MEM &&
-	     ucode->ucode_id != AMDGPU_UCODE_ID_RLC_IRAM &&
-	     ucode->ucode_id != AMDGPU_UCODE_ID_RLC_DRAM &&
-		 ucode->ucode_id != AMDGPU_UCODE_ID_DMCU_ERAM &&
-		 ucode->ucode_id != AMDGPU_UCODE_ID_DMCU_INTV &&
-		 ucode->ucode_id != AMDGPU_UCODE_ID_DMCUB)) {
-		ucode->ucode_size = le32_to_cpu(header->ucode_size_bytes);
-
-		memcpy(ucode->kaddr, (void *)((uint8_t *)ucode->fw->data +
-					      le32_to_cpu(header->ucode_array_offset_bytes)),
-		       ucode->ucode_size);
-	} else if (ucode->ucode_id == AMDGPU_UCODE_ID_CP_MEC1 ||
-		   ucode->ucode_id == AMDGPU_UCODE_ID_CP_MEC2) {
-		ucode->ucode_size = le32_to_cpu(header->ucode_size_bytes) -
-			le32_to_cpu(cp_hdr->jt_size) * 4;
-
-		memcpy(ucode->kaddr, (void *)((uint8_t *)ucode->fw->data +
-					      le32_to_cpu(header->ucode_array_offset_bytes)),
-		       ucode->ucode_size);
-	} else if (ucode->ucode_id == AMDGPU_UCODE_ID_CP_MEC1_JT ||
-		   ucode->ucode_id == AMDGPU_UCODE_ID_CP_MEC2_JT) {
-		ucode->ucode_size = le32_to_cpu(cp_hdr->jt_size) * 4;
-
-		memcpy(ucode->kaddr, (void *)((uint8_t *)ucode->fw->data +
-					      le32_to_cpu(header->ucode_array_offset_bytes) +
-					      le32_to_cpu(cp_hdr->jt_offset) * 4),
-		       ucode->ucode_size);
-	} else if (ucode->ucode_id == AMDGPU_UCODE_ID_DMCU_ERAM) {
-		ucode->ucode_size = le32_to_cpu(header->ucode_size_bytes) -
+	if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
+		switch (ucode->ucode_id) {
+		case AMDGPU_UCODE_ID_CP_MEC1:
+		case AMDGPU_UCODE_ID_CP_MEC2:
+			ucode->ucode_size = le32_to_cpu(header->ucode_size_bytes) -
+				le32_to_cpu(cp_hdr->jt_size) * 4;
+			ucode_addr = (u8 *)ucode->fw->data +
+				le32_to_cpu(header->ucode_array_offset_bytes);
+			break;
+		case AMDGPU_UCODE_ID_CP_MEC1_JT:
+		case AMDGPU_UCODE_ID_CP_MEC2_JT:
+			ucode->ucode_size = le32_to_cpu(cp_hdr->jt_size) * 4;
+			ucode_addr = (u8 *)ucode->fw->data +
+				le32_to_cpu(header->ucode_array_offset_bytes) +
+				le32_to_cpu(cp_hdr->jt_offset) * 4;
+			break;
+		case AMDGPU_UCODE_ID_RLC_RESTORE_LIST_CNTL:
+			ucode->ucode_size = adev->gfx.rlc.save_restore_list_cntl_size_bytes;
+			ucode_addr = adev->gfx.rlc.save_restore_list_cntl;
+			break;
+		case AMDGPU_UCODE_ID_RLC_RESTORE_LIST_GPM_MEM:
+			ucode->ucode_size = adev->gfx.rlc.save_restore_list_gpm_size_bytes;
+			ucode_addr = adev->gfx.rlc.save_restore_list_gpm;
+			break;
+		case AMDGPU_UCODE_ID_RLC_RESTORE_LIST_SRM_MEM:
+			ucode->ucode_size = adev->gfx.rlc.save_restore_list_srm_size_bytes;
+			ucode_addr = adev->gfx.rlc.save_restore_list_srm;
+			break;
+		case AMDGPU_UCODE_ID_RLC_IRAM:
+			ucode->ucode_size = adev->gfx.rlc.rlc_iram_ucode_size_bytes;
+			ucode_addr = adev->gfx.rlc.rlc_iram_ucode;
+			break;
+		case AMDGPU_UCODE_ID_RLC_DRAM:
+			ucode->ucode_size = adev->gfx.rlc.rlc_dram_ucode_size_bytes;
+			ucode_addr = adev->gfx.rlc.rlc_dram_ucode;
+			break;
+		case AMDGPU_UCODE_ID_CP_MES:
+			ucode->ucode_size = le32_to_cpu(mes_hdr->mes_ucode_size_bytes);
+			ucode_addr = (u8 *)ucode->fw->data +
+				le32_to_cpu(mes_hdr->mes_ucode_offset_bytes);
+			break;
+		case AMDGPU_UCODE_ID_CP_MES_DATA:
+			ucode->ucode_size = le32_to_cpu(mes_hdr->mes_ucode_data_size_bytes);
+			ucode_addr = (u8 *)ucode->fw->data +
+				le32_to_cpu(mes_hdr->mes_ucode_data_offset_bytes);
+			break;
+		case AMDGPU_UCODE_ID_DMCU_ERAM:
+			ucode->ucode_size = le32_to_cpu(header->ucode_size_bytes) -
 				le32_to_cpu(dmcu_hdr->intv_size_bytes);
-
-		memcpy(ucode->kaddr, (void *)((uint8_t *)ucode->fw->data +
-					      le32_to_cpu(header->ucode_array_offset_bytes)),
-		       ucode->ucode_size);
-	} else if (ucode->ucode_id == AMDGPU_UCODE_ID_DMCU_INTV) {
-		ucode->ucode_size = le32_to_cpu(dmcu_hdr->intv_size_bytes);
-
-		memcpy(ucode->kaddr, (void *)((uint8_t *)ucode->fw->data +
-					      le32_to_cpu(header->ucode_array_offset_bytes) +
-					      le32_to_cpu(dmcu_hdr->intv_offset_bytes)),
-		       ucode->ucode_size);
-	} else if (ucode->ucode_id == AMDGPU_UCODE_ID_DMCUB) {
-		ucode->ucode_size = le32_to_cpu(dmcub_hdr->inst_const_bytes);
-		memcpy(ucode->kaddr,
-		       (void *)((uint8_t *)ucode->fw->data +
-				le32_to_cpu(header->ucode_array_offset_bytes)),
-		       ucode->ucode_size);
-	} else if (ucode->ucode_id == AMDGPU_UCODE_ID_RLC_RESTORE_LIST_CNTL) {
-		ucode->ucode_size = adev->gfx.rlc.save_restore_list_cntl_size_bytes;
-		memcpy(ucode->kaddr, adev->gfx.rlc.save_restore_list_cntl,
-		       ucode->ucode_size);
-	} else if (ucode->ucode_id == AMDGPU_UCODE_ID_RLC_RESTORE_LIST_GPM_MEM) {
-		ucode->ucode_size = adev->gfx.rlc.save_restore_list_gpm_size_bytes;
-		memcpy(ucode->kaddr, adev->gfx.rlc.save_restore_list_gpm,
-		       ucode->ucode_size);
-	} else if (ucode->ucode_id == AMDGPU_UCODE_ID_RLC_RESTORE_LIST_SRM_MEM) {
-		ucode->ucode_size = adev->gfx.rlc.save_restore_list_srm_size_bytes;
-		memcpy(ucode->kaddr, adev->gfx.rlc.save_restore_list_srm,
-		       ucode->ucode_size);
-	} else if (ucode->ucode_id == AMDGPU_UCODE_ID_RLC_IRAM) {
-		ucode->ucode_size = adev->gfx.rlc.rlc_iram_ucode_size_bytes;
-		memcpy(ucode->kaddr, adev->gfx.rlc.rlc_iram_ucode,
-		       ucode->ucode_size);
-	} else if (ucode->ucode_id == AMDGPU_UCODE_ID_RLC_DRAM) {
-		ucode->ucode_size = adev->gfx.rlc.rlc_dram_ucode_size_bytes;
-		memcpy(ucode->kaddr, adev->gfx.rlc.rlc_dram_ucode,
-		       ucode->ucode_size);
-	} else if (ucode->ucode_id == AMDGPU_UCODE_ID_CP_MES) {
-		ucode->ucode_size = le32_to_cpu(mes_hdr->mes_ucode_size_bytes);
-		memcpy(ucode->kaddr, (void *)((uint8_t *)adev->mes.fw->data +
-			      le32_to_cpu(mes_hdr->mes_ucode_offset_bytes)),
-		       ucode->ucode_size);
-	} else if (ucode->ucode_id == AMDGPU_UCODE_ID_CP_MES_DATA) {
-		ucode->ucode_size = le32_to_cpu(mes_hdr->mes_ucode_data_size_bytes);
-		memcpy(ucode->kaddr, (void *)((uint8_t *)adev->mes.fw->data +
-			      le32_to_cpu(mes_hdr->mes_ucode_data_offset_bytes)),
-		       ucode->ucode_size);
+			ucode_addr = (u8 *)ucode->fw->data +
+				le32_to_cpu(header->ucode_array_offset_bytes);
+			break;
+		case AMDGPU_UCODE_ID_DMCU_INTV:
+			ucode->ucode_size = le32_to_cpu(dmcu_hdr->intv_size_bytes);
+			ucode_addr = (u8 *)ucode->fw->data +
+				le32_to_cpu(header->ucode_array_offset_bytes) +
+				le32_to_cpu(dmcu_hdr->intv_offset_bytes);
+			break;
+		case AMDGPU_UCODE_ID_DMCUB:
+			ucode->ucode_size = le32_to_cpu(dmcub_hdr->inst_const_bytes);
+			ucode_addr = (u8 *)ucode->fw->data +
+				le32_to_cpu(header->ucode_array_offset_bytes);
+			break;
+		default:
+			ucode->ucode_size = le32_to_cpu(header->ucode_size_bytes);
+			ucode_addr = (u8 *)ucode->fw->data +
+				le32_to_cpu(header->ucode_array_offset_bytes);
+			break;
+		}
+	} else {
+		ucode->ucode_size = le32_to_cpu(header->ucode_size_bytes);
+		ucode_addr = (u8 *)ucode->fw->data +
+			le32_to_cpu(header->ucode_array_offset_bytes);
 	}
 
+	memcpy(ucode->kaddr, ucode_addr, ucode->ucode_size);
+
 	return 0;
 }
 
-- 
2.25.1

