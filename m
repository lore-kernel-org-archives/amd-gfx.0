Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D3A0ECAAA1
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Sep 2022 17:02:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E7EB310EB89;
	Thu, 15 Sep 2022 17:02:10 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2072.outbound.protection.outlook.com [40.107.223.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3BD2610EB89
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Sep 2022 17:02:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YWh1FuipwJbRJDAs+TTB1woDUNoh5ktL36/Vr7i9RypBLpeYF0PY0f6VGcQGEdMOrLvf/ZRNwjiqh4x7Z4y9ZHXdroDW6n5rCLh0fHaIn2hthiuGJQiyRLUs5lG7mEmJJWzhyHQAiiLqgV93rXeXKOFCgBve8o46Xel9zb/soeeGP5vieo7kxd5icDjPmRxk0cqiy0BMjA91CUvJtJ4Ees1jNSSS0Mg8Q7Z/3Y8QyqC117V3V1nzYUJeA+6jYoW6XRdgBQAsr2MBRkEZV10MBz/72ZuZfVzndyUpthy28p5yAuoC6Ixp5Z7hxIv5jsIXKnD8Kikf8bYXuWTMFIS6Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B/h8tTw3ynbCKDrEDiwMxhK8Bgc30D4jrWyt0SZKMv4=;
 b=A2iMmBCfsFOsgjWYUIrw3SBDyygwSLbSvwaC4ex0OGwrmhce+Nd5veWM0MnrcDO8DVyjSGPzRcclZPVXz5GnHlUB+9LfmNRKzLVDe8pIIuUBDNwv6+0WrWlFLpSibVCdT5/YJuz0eC3Grd6kRBSFAFssAymOE5xiiiR9Ij/SSTIZUcyWSpjixkgo3Z/tZf9wQcrecnV8DL84dfSLhd7NSWm+d5Z/pxb8myLIghWxTZB52OEG4rF84/JGr3yhQA46TMkjewY/NHpNGkdmY52D1CQY+XxbkKgCimDAz02AzkjOcNOuYpYzUVqwj4Q5tUgSKr0+6zlqYX4+BeySFY6diw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B/h8tTw3ynbCKDrEDiwMxhK8Bgc30D4jrWyt0SZKMv4=;
 b=aTiDTixlGrwTUTfUxdXwVEPsZFpDz6qO06WojOuQ8SUHy6lneetViV4sE0yKPGnSrMPkguQkWhrVFFDBSZgzyXOXVGHTXGgKGxyxOdP/5pg2lfq5cHQHt6MJGgCIMrlAPjfNoLuInS0teb1oWoKwdAUqQNWObP46b8ZSz7G++Ak=
Received: from CY5PR15CA0009.namprd15.prod.outlook.com (2603:10b6:930:14::22)
 by SA1PR12MB6775.namprd12.prod.outlook.com (2603:10b6:806:25a::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.19; Thu, 15 Sep
 2022 17:02:01 +0000
Received: from CY4PEPF0000B8ED.namprd05.prod.outlook.com
 (2603:10b6:930:14:cafe::d4) by CY5PR15CA0009.outlook.office365.com
 (2603:10b6:930:14::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.15 via Frontend
 Transport; Thu, 15 Sep 2022 17:02:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000B8ED.mail.protection.outlook.com (10.167.241.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.12 via Frontend Transport; Thu, 15 Sep 2022 17:02:01 +0000
Received: from hawzhang-System-Product-Master.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 15 Sep 2022 12:01:58 -0500
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Likun Gao <Likun.Gao@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 04/10] drm/amdgpu: add helper to init rlc fw in header v2_3
Date: Fri, 16 Sep 2022 01:01:29 +0800
Message-ID: <20220915170135.23060-5-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220915170135.23060-1-Hawking.Zhang@amd.com>
References: <20220915170135.23060-1-Hawking.Zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000B8ED:EE_|SA1PR12MB6775:EE_
X-MS-Office365-Filtering-Correlation-Id: 3469740d-81ce-49c8-d0e7-08da973c0231
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WhoPUzXXuuNcgfZ71ogrRH2TB/cmM8SM5jTidnaX8degnlEiJ+A2pXWyYEVUENRk/CiPLdsmdeqAfO6D8hU6kFMkZU7cUNRdRIWBcSfqvZX1MdrDOfX/c2PTyb5stJtCMZOQky2TVRn6vdAjY9ExZ+qFYrkypmwGvzrIrJOsHjXNAMP5c/YQCV5t90srxNSXFiZX7GXG1jYFAcd8skNQBZwAb3ILxBtWeEEiL3InK+smmAF9QBzAfeb2f/ScEPgv90Zo7qv4gGT3qQGIbD4PwykB4Ly8fprgoxDBwPqFmPKSx+CV3j4vvTGQVa4o0IUGSQqIsDHGpFLpYQYuxcc1z1FGfbpE7mG+lHyt9XvdsffLJzoTHBjkSFf3iGcPDUGxE7Jo9OqOIzYTfNR0JP+N1EduFdOVCv8o/5sQK+AApkCBrEbSJBvHves4u5VwUOcnpx3AKSUSfaqdtBw3/YAw+4C0i3pFMdIN+0k3jtdMeabKYGQ2lxRwEfO1GNznptcL5VRjyXKxRSSWGIFZaefRsF6hajrmP1mS8fGTfEbdPv/RLMVN4d+siG3BSMYuyis0cQS3TbBYhUACveejdQjfRJxvfyo97tKbRjllTm0TEEtHE4UVTyf8T7TPHfUNhhJz281/xRk+axOhHVlAiCHY/xVpoYNL1XkXd9VhxC5LpgJJwlxv3vD2qm40+rBkD+bFgJQ+db2/8xHaCW5fIqRVZ5r7avc543KrBdRwBjE4rYTRohrchF+9s2Z/crNna7D+1S0YWtm/9+C23kGn35nucBDavlWaUj5ahA1kQj1+D4tEvzM4wAJaExtsSuP6xKHw
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(39860400002)(346002)(136003)(376002)(451199015)(46966006)(36840700001)(40470700004)(40460700003)(2906002)(86362001)(336012)(36756003)(82310400005)(70586007)(316002)(26005)(47076005)(36860700001)(81166007)(6636002)(1076003)(426003)(186003)(5660300002)(16526019)(70206006)(2616005)(8676002)(356005)(478600001)(110136005)(41300700001)(8936002)(4326008)(40480700001)(82740400003)(7696005)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2022 17:02:01.5749 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3469740d-81ce-49c8-d0e7-08da973c0231
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000B8ED.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6775
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

To initialize rlc firmware in header v2_3

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c | 35 +++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c
index a055818d87f7..adbb9bed86fc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c
@@ -406,3 +406,38 @@ static void amdgpu_gfx_rlc_init_microcode_v2_2(struct amdgpu_device *adev)
 		}
 	}
 }
+
+static void amdgpu_gfx_rlc_init_microcode_v2_3(struct amdgpu_device *adev)
+{
+	const struct rlc_firmware_header_v2_3 *rlc_hdr;
+	struct amdgpu_firmware_info *info;
+
+	rlc_hdr = (const struct rlc_firmware_header_v2_3 *)adev->gfx.rlc_fw->data;
+	adev->gfx.rlcp_ucode_version = le32_to_cpu(rlc_hdr->rlcp_ucode_version);
+	adev->gfx.rlcp_ucode_feature_version = le32_to_cpu(rlc_hdr->rlcp_ucode_feature_version);
+	adev->gfx.rlc.rlcp_ucode_size_bytes = le32_to_cpu(rlc_hdr->rlcp_ucode_size_bytes);
+	adev->gfx.rlc.rlcp_ucode = (u8 *)rlc_hdr + le32_to_cpu(rlc_hdr->rlcp_ucode_offset_bytes);
+
+	adev->gfx.rlcv_ucode_version = le32_to_cpu(rlc_hdr->rlcv_ucode_version);
+	adev->gfx.rlcv_ucode_feature_version = le32_to_cpu(rlc_hdr->rlcv_ucode_feature_version);
+	adev->gfx.rlc.rlcv_ucode_size_bytes = le32_to_cpu(rlc_hdr->rlcv_ucode_size_bytes);
+	adev->gfx.rlc.rlcv_ucode = (u8 *)rlc_hdr + le32_to_cpu(rlc_hdr->rlcv_ucode_offset_bytes);
+
+	if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
+		if (adev->gfx.rlc.rlcp_ucode_size_bytes) {
+			info = &adev->firmware.ucode[AMDGPU_UCODE_ID_RLC_P];
+			info->ucode_id = AMDGPU_UCODE_ID_RLC_P;
+			info->fw = adev->gfx.rlc_fw;
+			adev->firmware.fw_size +=
+				ALIGN(le32_to_cpu(adev->gfx.rlc.rlcp_ucode_size_bytes), PAGE_SIZE);
+		}
+
+		if (adev->gfx.rlc.rlcv_ucode_size_bytes) {
+			info = &adev->firmware.ucode[AMDGPU_UCODE_ID_RLC_V];
+			info->ucode_id = AMDGPU_UCODE_ID_RLC_V;
+			info->fw = adev->gfx.rlc_fw;
+			adev->firmware.fw_size +=
+				ALIGN(le32_to_cpu(adev->gfx.rlc.rlcv_ucode_size_bytes), PAGE_SIZE);
+		}
+	}
+}
-- 
2.17.1

