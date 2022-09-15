Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3D36ECAAA1
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Sep 2022 17:02:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0331010EB86;
	Thu, 15 Sep 2022 17:02:03 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2050.outbound.protection.outlook.com [40.107.237.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DBA5C10EB81
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Sep 2022 17:01:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KVYmJYfb/KuiT9OjRGIok1epeRvzgAyGKTu1QB/Tf9McSw5oIH2QkDrY3wJa2pMdVJIyFhZeE6G9JtRnQ05NNgMMy2Eg2WaVrFGT1OW4Jg4lcaBaMTGUXNDBs0B5jfCOkbaK+x7pQvBZrsaA6nwS5WoZpfb0F9YAlTOxF89FwKL6X0VgyWCuU3QhtxI8tiD/Eeyru0LIzlVNZy3jZsjuuuj6ILTpgQEY7aEP5Ij68y9q1OKuzSdDXiN1JJR7ANYvNl72yCCoGLBAqA64d86/D/2uCLzZDJgoM3JvU1CSKUI1Mfwd4W+dAU780lYslKh2Dg5Fv2MPa1Uk4VBs/XO0xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u0qUfLZTAck1rSbbf+HKAMC+f5KgG8xHN1ppdah0Y00=;
 b=iaym2Z6SYX7rZZVph9Gb+bdN+p3wPaqdsjNrU1TxWRlZuKKZZcb/OqufqJiZ9lSf1fOFiJFfSFedR830nyBxiWdu/MxUCP57eU7XGGAGsJ0Md6A3YPZ4oJ6MQVyXcFx/iqiL2qQtvh8ltfajd7SxAbaWIOpsMPFlqeZCVR5gUzrtPU973WXPZ0P5gUhpVMFiL6dZ8JdZoFW+JiPnq+BCre4TMzINqG3VSqjo+Exkrt+bEF/HYgI5Gg5NvM6CdqgGei9FQFE5z2f/jH9niUL02PrO7xYcnnHboLJSOoq2+9HZZ/12dH46rXGYsA/EeDIBrSCz8bqrEjL26MIOqQh7Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u0qUfLZTAck1rSbbf+HKAMC+f5KgG8xHN1ppdah0Y00=;
 b=4Bqi8D4S8HnMqUyAojWbtXeoKbDIiF/1gA45zCQk6njF3EV+nwTtrvjbZauHiVJF8SMq3oMUwsjGh+pHkZFw7ceSti0KusoZmrPctgNQLc/VMaDnDaRfDov0Kd1oHeueVtTjpuiDTwbI4Y2yJrAC+xnhlYsaIcMD8+pFvFR8YuI=
Received: from DS7PR06CA0019.namprd06.prod.outlook.com (2603:10b6:8:2a::18) by
 DM6PR12MB5518.namprd12.prod.outlook.com (2603:10b6:5:1b9::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5632.15; Thu, 15 Sep 2022 17:01:57 +0000
Received: from DS1PEPF0000B074.namprd05.prod.outlook.com
 (2603:10b6:8:2a:cafe::6f) by DS7PR06CA0019.outlook.office365.com
 (2603:10b6:8:2a::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.15 via Frontend
 Transport; Thu, 15 Sep 2022 17:01:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000B074.mail.protection.outlook.com (10.167.17.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.12 via Frontend Transport; Thu, 15 Sep 2022 17:01:57 +0000
Received: from hawzhang-System-Product-Master.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 15 Sep 2022 12:01:51 -0500
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Likun Gao <Likun.Gao@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 01/10] drm/amdgpu: add helper to init rlc fw in header v2_0
Date: Fri, 16 Sep 2022 01:01:26 +0800
Message-ID: <20220915170135.23060-2-Hawking.Zhang@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF0000B074:EE_|DM6PR12MB5518:EE_
X-MS-Office365-Filtering-Correlation-Id: 3408e529-ad31-44ff-808d-08da973bffb2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pV81S+CkPjz9bDHWh90zO2MWxaHo7w7c5LbVMDcKUDfAPq1cqG/hOzUcRUXw9oQeJyoxj8xA2w/ZhAfzWDM0G6GNi2SwSIEFlO8a/71aBdHrSTIBv7x3PJe3gg9uRHok0Hit5+axRDNf/NZNjVDfO489132Ya6BbWXyXGhDN80wmagqC+yEfESeM8o6BquefclDrnBuSC+VmKAai58WbMQSCU5P1pWSJyv/degRlhbcgP4j8oi5sYLmTC3Mxtsz7+Rxe5OyRDp+9eguBSMdEfzNxBWlMPcITJQ6eovvab0TRlE8NOMLhzd5aIfb4PBrQSgV7jGOWL/bKbgNqWTjAU8c6RzgdBvbYQub20EMMNUzoMfmIpcN0fQDUrbsOZQvuPRESNfU4YVW/KW7OA2L7uXq45dmMnnM9zawkv7DxtdOCekccWIOf8uExLHcwxOi3PFuohjQxPclPB3SmVScYt6OCObtQYiZZ9AmYdcvUt6sEHn3mthr+hJ8R8nTIB5RVP8MbrhLB6wbBNqE+MHnaR4rhO0tR51wMNkRXwe5QX6j4muscHYUCVCGE3moMsyyt0lwROc2u/xod3p9P+zmHReyPYXuT8qm2StmtpyIHCy2GLomAp3seJthAIfCpDiDsTFTnERhpFPOAlmgHZdpTZlfJAdYyxE9hd1cwZyG84rHIZh3FrQBQ5X3Era6Hjek+JLZgD6aiVZHdmMCC9UdYjVZE59lYc0yladOB0PGuWGCoanOQI8oxDlEiHnS6vQ9Eflp3TvfgQ1Fm20mHYUJYmkuWt525QLJgA4M8575ANvT/5gec+/2RX5wyoEBfJ6+R
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(346002)(396003)(39860400002)(136003)(451199015)(46966006)(36840700001)(40470700004)(83380400001)(16526019)(47076005)(41300700001)(426003)(1076003)(186003)(8936002)(336012)(2616005)(5660300002)(478600001)(86362001)(316002)(82310400005)(110136005)(82740400003)(6636002)(70586007)(70206006)(7696005)(8676002)(6666004)(4326008)(356005)(81166007)(40460700003)(36860700001)(2906002)(36756003)(40480700001)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2022 17:01:57.4005 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3408e529-ad31-44ff-808d-08da973bffb2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000B074.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5518
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

To initialize rlc firmware in header v2_0

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c | 64 +++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c
index 6373bfb47d55..10b998cae1ba 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c
@@ -272,3 +272,67 @@ void amdgpu_gfx_rlc_fini(struct amdgpu_device *adev)
 			      &adev->gfx.rlc.cp_table_gpu_addr,
 			      (void **)&adev->gfx.rlc.cp_table_ptr);
 }
+
+static int amdgpu_gfx_rlc_init_microcode_v2_0(struct amdgpu_device *adev)
+{
+	const struct common_firmware_header *common_hdr;
+	const struct rlc_firmware_header_v2_0 *rlc_hdr;
+	struct amdgpu_firmware_info *info;
+	unsigned int *tmp;
+	unsigned int i;
+
+	rlc_hdr = (const struct rlc_firmware_header_v2_0 *)adev->gfx.rlc_fw->data;
+
+	adev->gfx.rlc_fw_version = le32_to_cpu(rlc_hdr->header.ucode_version);
+	adev->gfx.rlc_feature_version = le32_to_cpu(rlc_hdr->ucode_feature_version);
+	adev->gfx.rlc.save_and_restore_offset =
+		le32_to_cpu(rlc_hdr->save_and_restore_offset);
+	adev->gfx.rlc.clear_state_descriptor_offset =
+		le32_to_cpu(rlc_hdr->clear_state_descriptor_offset);
+	adev->gfx.rlc.avail_scratch_ram_locations =
+		le32_to_cpu(rlc_hdr->avail_scratch_ram_locations);
+	adev->gfx.rlc.reg_restore_list_size =
+		le32_to_cpu(rlc_hdr->reg_restore_list_size);
+	adev->gfx.rlc.reg_list_format_start =
+		le32_to_cpu(rlc_hdr->reg_list_format_start);
+	adev->gfx.rlc.reg_list_format_separate_start =
+		le32_to_cpu(rlc_hdr->reg_list_format_separate_start);
+	adev->gfx.rlc.starting_offsets_start =
+		le32_to_cpu(rlc_hdr->starting_offsets_start);
+	adev->gfx.rlc.reg_list_format_size_bytes =
+		le32_to_cpu(rlc_hdr->reg_list_format_size_bytes);
+	adev->gfx.rlc.reg_list_size_bytes =
+		le32_to_cpu(rlc_hdr->reg_list_size_bytes);
+	adev->gfx.rlc.register_list_format =
+		kmalloc(le32_to_cpu(adev->gfx.rlc.reg_list_format_size_bytes) +
+			le32_to_cpu(adev->gfx.rlc.reg_list_size_bytes), GFP_KERNEL);
+	if (!adev->gfx.rlc.register_list_format) {
+		dev_err(adev->dev, "failed to allocate memory for rlc register_list_format\n");
+		return -ENOMEM;
+	}
+
+	tmp = (unsigned int *)((uintptr_t)rlc_hdr +
+			le32_to_cpu(rlc_hdr->reg_list_format_array_offset_bytes));
+	for (i = 0 ; i < (rlc_hdr->reg_list_format_size_bytes >> 2); i++)
+		adev->gfx.rlc.register_list_format[i] = le32_to_cpu(tmp[i]);
+
+	adev->gfx.rlc.register_restore = adev->gfx.rlc.register_list_format + i;
+
+	tmp = (unsigned int *)((uintptr_t)rlc_hdr +
+			le32_to_cpu(rlc_hdr->reg_list_array_offset_bytes));
+	for (i = 0 ; i < (rlc_hdr->reg_list_size_bytes >> 2); i++)
+		adev->gfx.rlc.register_restore[i] = le32_to_cpu(tmp[i]);
+
+	if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
+		info = &adev->firmware.ucode[AMDGPU_UCODE_ID_RLC_G];
+		info->ucode_id = AMDGPU_UCODE_ID_RLC_G;
+		info->fw = adev->gfx.rlc_fw;
+		if (info->fw) {
+			common_hdr = (const struct common_firmware_header *)info->fw->data;
+			adev->firmware.fw_size +=
+				ALIGN(le32_to_cpu(common_hdr->ucode_size_bytes), PAGE_SIZE);
+		}
+	}
+
+	return 0;
+}
-- 
2.17.1

