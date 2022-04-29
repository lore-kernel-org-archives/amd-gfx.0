Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A85BAC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Apr 2022 18:03:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF62A10F8B2;
	Fri, 29 Apr 2022 18:02:57 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2042.outbound.protection.outlook.com [40.107.101.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E9FA810F891
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Apr 2022 18:02:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PcVkDurYpkcNya6R/pcCYuHu8nxtz0QwFIXW4TDWb+jFA7wlj46K/4gReJalV9ewDoqyxJTO1TaUmmHRPMNgV5P7bPc+IJ8XaC/ey6PsWpM0wFyFj8znikM4xd0B65tlHi/Q/txMhL0q5JINhjX+38il1yZVdo9gb9DFWInYhwGimGBfQk0IRMMlNLaNZMKF0uPtER2fsQrHmD5W58N7RtLJ9w2A5lf1IdsTnpv7Y9bEYl6VdjciksJw2Sjre9vMQ4eXUUeHmhuAG1y7gM+SbuUKRrhIkjrViuvBetZDOqDI69u2mAoU+Idq9AJqkINlXoyYQ8LDIFbkrF3oWqm/yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e6xRueFrIzih9ClvwcPc2wxAcil7O8Oi70If+9RUI0c=;
 b=PpCMWY1VIscM2IndoVzD65XRQMYOIyueQyTtolbfQ54DAvO9s6cQTcaUnRC0AojuBObbQ66r2tz0CiHcFUA6WKfGFOi5t/1KSVomW69VM7r6MjPeAOFj7WRUVNfLmhLpKzw69m9r4w51RM9/+lglW8JAYj7LK3g1boabofoJqWXvg45qSQAhbe5qnNZPNCcCaK1DvhasHcIdia2JsCpnNW6mFrsVV/Pi0aWPAgebjDsymimdgwM/0iPY7Zmf9oY1FiL/k2eapx8uzmyRpMwuTCfj1mOjQJ4PnA1lmQNU4nWzCwX58+Q9ir2YIwpa4cx5e+ZMTRTP1zw2rve9tMvnrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e6xRueFrIzih9ClvwcPc2wxAcil7O8Oi70If+9RUI0c=;
 b=vTbZ1oTvhsHJYsv5hK6jXxmPppsvgd4gWeL4ZKsTP5CS2Jemh4H5o+ac94BNxKYK1tAyHfVnYvDIkt4IENKEpyjlMAihcwYg59UU6lIeRZDF5RSgcZEq7wFmoGvE5RG+TSFvSsSzzr7qrSg03Rz1YfM3pYJIKRlWT1UF3iU9dmQ=
Received: from MW2PR16CA0058.namprd16.prod.outlook.com (2603:10b6:907:1::35)
 by CY4PR12MB1846.namprd12.prod.outlook.com (2603:10b6:903:11b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Fri, 29 Apr
 2022 18:02:49 +0000
Received: from CO1NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:1:cafe::c7) by MW2PR16CA0058.outlook.office365.com
 (2603:10b6:907:1::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13 via Frontend
 Transport; Fri, 29 Apr 2022 18:02:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT038.mail.protection.outlook.com (10.13.174.231) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Fri, 29 Apr 2022 18:02:49 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 29 Apr
 2022 13:02:47 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 17/29] drm/amdgpu: support RS64 CP fw front door load
Date: Fri, 29 Apr 2022 14:02:14 -0400
Message-ID: <20220429180226.536084-18-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220429180226.536084-1-alexander.deucher@amd.com>
References: <20220429180226.536084-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2f536a50-f741-43a4-55ba-08da2a0a791b
X-MS-TrafficTypeDiagnostic: CY4PR12MB1846:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB1846EECEA692047CF02D7032F7FC9@CY4PR12MB1846.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AU15Q/l/DnWpHPCQVIdDPgFS0BBuFpT56N5ggMGDVpbGYozKbvtF8+DkGqpNAXoHXtEwx3OoeZb1V7Bp8+Z1PYMTcOS1JVrRvr5Hn9FjnVBxF4/LndLPNwAbHK5iW4OTdpsqc9orII5qMJ0FFkoibpCkNJujg3ejzExq6y66Ft5uIW3DsfYFjcbrXkIS4cJHye6U0yp2aD8UiNJPZjFGBdaah1lX90H1dxZzDL1auekFQOnH0yZV5phYkieX0O1KTex1VsXRYDJC/29IUYyrsLepYejBwuzq7Ut00wlBjWix6tGjj2fbKwkd2adkXPOrXwPLJqwk+dwy46zgdbPYpRC9LK938WltjDUF2b/Flhz35yXO495uzqmQJ79HfRexo1I2PdcDx4oviQBU2zQxnqtzLtspeOgyRq6pjgjj5mPlQ6KE/UNYtSWoFc/wQaOFymP2gi688e77rfmTcfq2LPO0B+rqQjWe8xizbtHzpWZnwosvLBvEYyMx8hnapAMgXbx/tG8xM8bhZ5EDVbq9oTKgKtZQiARxg4QaXE/G0ivfvkHGGLL+o9sujLcv0MZHX9FEbCM5sxNh+zXY6vgX1CXbYvVvTm2RxMbgkzZghc/tZ20lRqRBF7afR5r47u/Kr9w5n5Ecgt6kaTNPKHcnLHscIntmtaH0zzGyxmCaG4sHwZbQoyy2kGk1lxbMKDAnypYQAGf7obQCbTubAKXcMQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(36756003)(8936002)(82310400005)(508600001)(36860700001)(70586007)(8676002)(4326008)(70206006)(316002)(356005)(54906003)(81166007)(6916009)(6666004)(2616005)(26005)(7696005)(1076003)(2906002)(16526019)(186003)(47076005)(336012)(5660300002)(426003)(86362001)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2022 18:02:49.4501 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f536a50-f741-43a4-55ba-08da2a0a791b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1846
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Likun Gao <Likun.Gao@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Likun Gao <Likun.Gao@amd.com>

Support to load RS64 CP firmware front door load.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c | 57 +++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
index 3d1258fec48e..00fa7822458b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
@@ -672,6 +672,7 @@ static int amdgpu_ucode_init_single_fw(struct amdgpu_device *adev,
 {
 	const struct common_firmware_header *header = NULL;
 	const struct gfx_firmware_header_v1_0 *cp_hdr = NULL;
+	const struct gfx_firmware_header_v2_0 *cpv2_hdr = NULL;
 	const struct dmcu_firmware_header_v1_0 *dmcu_hdr = NULL;
 	const struct dmcub_firmware_header_v1_0 *dmcub_hdr = NULL;
 	const struct mes_firmware_header_v1_0 *mes_hdr = NULL;
@@ -690,6 +691,7 @@ static int amdgpu_ucode_init_single_fw(struct amdgpu_device *adev,
 
 	header = (const struct common_firmware_header *)ucode->fw->data;
 	cp_hdr = (const struct gfx_firmware_header_v1_0 *)ucode->fw->data;
+	cpv2_hdr = (const struct gfx_firmware_header_v2_0 *)ucode->fw->data;
 	dmcu_hdr = (const struct dmcu_firmware_header_v1_0 *)ucode->fw->data;
 	dmcub_hdr = (const struct dmcub_firmware_header_v1_0 *)ucode->fw->data;
 	mes_hdr = (const struct mes_firmware_header_v1_0 *)ucode->fw->data;
@@ -802,6 +804,61 @@ static int amdgpu_ucode_init_single_fw(struct amdgpu_device *adev,
 				le32_to_cpu(imu_hdr->header.ucode_array_offset_bytes) +
 				le32_to_cpu(imu_hdr->imu_iram_ucode_size_bytes);
 			break;
+		case AMDGPU_UCODE_ID_CP_RS64_PFP:
+			ucode->ucode_size = le32_to_cpu(cpv2_hdr->ucode_size_bytes);
+			ucode_addr = (u8 *)ucode->fw->data +
+				le32_to_cpu(header->ucode_array_offset_bytes);
+			break;
+		case AMDGPU_UCODE_ID_CP_RS64_PFP_P0_STACK:
+			ucode->ucode_size = le32_to_cpu(cpv2_hdr->data_size_bytes);
+			ucode_addr = (u8 *)ucode->fw->data +
+				le32_to_cpu(cpv2_hdr->data_offset_bytes);
+			break;
+		case AMDGPU_UCODE_ID_CP_RS64_PFP_P1_STACK:
+			ucode->ucode_size = le32_to_cpu(cpv2_hdr->data_size_bytes);
+			ucode_addr = (u8 *)ucode->fw->data +
+				le32_to_cpu(cpv2_hdr->data_offset_bytes);
+			break;
+		case AMDGPU_UCODE_ID_CP_RS64_ME:
+			ucode->ucode_size = le32_to_cpu(cpv2_hdr->ucode_size_bytes);
+			ucode_addr = (u8 *)ucode->fw->data +
+				le32_to_cpu(header->ucode_array_offset_bytes);
+			break;
+		case AMDGPU_UCODE_ID_CP_RS64_ME_P0_STACK:
+			ucode->ucode_size = le32_to_cpu(cpv2_hdr->data_size_bytes);
+			ucode_addr = (u8 *)ucode->fw->data +
+				le32_to_cpu(cpv2_hdr->data_offset_bytes);
+			break;
+		case AMDGPU_UCODE_ID_CP_RS64_ME_P1_STACK:
+			ucode->ucode_size = le32_to_cpu(cpv2_hdr->data_size_bytes);
+			ucode_addr = (u8 *)ucode->fw->data +
+				le32_to_cpu(cpv2_hdr->data_offset_bytes);
+			break;
+		case AMDGPU_UCODE_ID_CP_RS64_MEC:
+			ucode->ucode_size = le32_to_cpu(cpv2_hdr->ucode_size_bytes);
+			ucode_addr = (u8 *)ucode->fw->data +
+				le32_to_cpu(header->ucode_array_offset_bytes);
+			break;
+		case AMDGPU_UCODE_ID_CP_RS64_MEC_P0_STACK:
+			ucode->ucode_size = le32_to_cpu(cpv2_hdr->data_size_bytes);
+			ucode_addr = (u8 *)ucode->fw->data +
+				le32_to_cpu(cpv2_hdr->data_offset_bytes);
+			break;
+		case AMDGPU_UCODE_ID_CP_RS64_MEC_P1_STACK:
+			ucode->ucode_size = le32_to_cpu(cpv2_hdr->data_size_bytes);
+			ucode_addr = (u8 *)ucode->fw->data +
+				le32_to_cpu(cpv2_hdr->data_offset_bytes);
+			break;
+		case AMDGPU_UCODE_ID_CP_RS64_MEC_P2_STACK:
+			ucode->ucode_size = le32_to_cpu(cpv2_hdr->data_size_bytes);
+			ucode_addr = (u8 *)ucode->fw->data +
+				le32_to_cpu(cpv2_hdr->data_offset_bytes);
+			break;
+		case AMDGPU_UCODE_ID_CP_RS64_MEC_P3_STACK:
+			ucode->ucode_size = le32_to_cpu(cpv2_hdr->data_size_bytes);
+			ucode_addr = (u8 *)ucode->fw->data +
+				le32_to_cpu(cpv2_hdr->data_offset_bytes);
+			break;
 		default:
 			ucode->ucode_size = le32_to_cpu(header->ucode_size_bytes);
 			ucode_addr = (u8 *)ucode->fw->data +
-- 
2.35.1

