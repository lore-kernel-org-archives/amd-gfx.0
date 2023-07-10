Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 513F7EB64DC
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Jul 2023 03:10:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9AD0210E099;
	Mon, 10 Jul 2023 03:10:47 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2070.outbound.protection.outlook.com [40.107.94.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 09F4A10E099
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Jul 2023 03:10:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KVLH6fzeBHRCiYA4DQQFgXTCWQYIIaWiQ0YpoYx9nNyYwe1tQgZ0IxnWwGssG4rKpvYBTE58ZyzIXFwBqxRppSRcJCqso971XA4EfoT7yT4DqCI1QhsR1wYyv97QpGQzLliMbRnbeUji7KLXVmM5tM6w/Lv4Ap+K2V7pKU7rkx/oxK6CQ2ZcPKzUS1obT9CQ8RiiGKlHLnFscAY8SOIY0q3jOGwhEjSiAa4Ascezz+yV/DOeux/LGUeZkkiY8mE/GhZXbM/3Fh/f72fqmE7ME4MbmDhf87dI0WtlAFcvcB2pqaf3av2nGTYtKD6BKko6JU+nUhQxvixPlcso9qKNSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PteG7QFkGGnF9ejKt17cDH4kDEqtv5fLWykB7jQjZfE=;
 b=FCzFcW1JssN+r2WcGUU2HAEowglL2i5atXj+RAW3jkA5yNkmH22e5Sz8wKAMaBYuug0QMCiF5eYuQG0ATMCNQuqn6OFE6G6OFq9JmfVVdVkPilffTCGEX6zU4qlOLlNsF39FQiQ+xlJgFlqWTpwCHVmHkfUQM5hPJGxJayU4uNPI5YFEWewNvYVOn7L15Mbe+L+M0p54aAJzG3NjG15P+kGYiU8sx8uGe7mnRlBeWVyemXcbHJReb8qOt9WBNUs2ph4+T492nVUrZ7F2nrYY5L+QGTSP/sIodgw7UjR/F6y/HwdWuS8+YWLDO/caWoemTac3jE3zkCgqythEgHt+nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PteG7QFkGGnF9ejKt17cDH4kDEqtv5fLWykB7jQjZfE=;
 b=hb/rZnTkjv8kbj+Qn0lMoNyWdzmgy/jNJc3c6r7H9PsbsYOQxX9ON+W1fJ8kPj0dyrdpkIHlgnZ7203DvYKeQPBpwvGQO+rEfJ/9Wvc0u58qrYFBXD2462TZNUFRS7TCAwK52EnRwvRCKvdYJDDjUllmPXWKFTQNlS8oZTMPePw=
Received: from MW4P222CA0008.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::13)
 by BL1PR12MB5335.namprd12.prod.outlook.com (2603:10b6:208:317::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Mon, 10 Jul
 2023 03:10:43 +0000
Received: from CO1NAM11FT007.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:114:cafe::b0) by MW4P222CA0008.outlook.office365.com
 (2603:10b6:303:114::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30 via Frontend
 Transport; Mon, 10 Jul 2023 03:10:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT007.mail.protection.outlook.com (10.13.174.131) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.18 via Frontend Transport; Mon, 10 Jul 2023 03:10:43 +0000
Received: from lang-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Sun, 9 Jul
 2023 22:10:19 -0500
From: Lang Yu <Lang.Yu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdgpu: rename psp_execute_non_psp_fw_load and make
 it global
Date: Mon, 10 Jul 2023 11:10:03 +0800
Message-ID: <20230710031004.1106582-1-Lang.Yu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT007:EE_|BL1PR12MB5335:EE_
X-MS-Office365-Filtering-Correlation-Id: ebb8eae8-501b-48f0-5533-08db80f33f8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +8p6bx5TQpgjTOfrMSaH+pY+rFA+aq/b83k9cdSosV8dlPl7CbWE37XGIyCt9ckVbY9ScJNaasV6Etd8E9Q/EYynJavu/cP1Bkcw1X53SXCC/WTxaSUh1k5d4CPU9K9YwxW1/TNu0xoS+oQq3twR7diYAS+cjz0IrwyMoGKXqJ3sKYq7ZvOrB0oWXqV9fEZMmqhlbvCHEK4VaMvMIg1sw7L6HNV6eee/GvNyJfH7ynbNw8q7s9UGIHBHNNPCD/typgkJ0rpkUGRXOqD0nd9NRvW6+L8U5W7XuJ+omBMcGVLggxZubE9wSmY56ykClxpZF581qZacXcQMNy7iQvDjU5OsEAfoHfjPpOWi1xBVWZWyaKdHx0nF4Q4wbvsYhpGut01Q3VLCvPfAT06X+Hh2jhc/ULrh28Fmxbqli1ZVqVwqAZO0kwAd6mO0dnASnllGNudIKD+WYuXpixNZARWxbJCWzVejUlH4rmvRGDdOi5GwAuIRwpkbHHa1jhRqGT69Nh1N5H2HI4XcE1iYDF5jCamQT3dBhJBhPSc5dnvFaDd3AlJkM2wll3EHYhdWgmY6ugd2g3MPcF+mU0eIf7SI11Fl6vHpngXVyWm75kLCnbaTlOY5eGKf0JIOCAbI8SQKl3t3/qcwzOKyGEoLjXviSsjxM5lvslCpRk1ErrRcA9xLGqp2KnOrFd4ZZQkBttL8tQo7KLhgfMnjyQapL4u/ZLbLLktVoJzrGik9+wJcf0cS4OBWSS/EOS7N+gB7842nnQGxRsh1eOD2RlCZDnD3rw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(39860400002)(346002)(136003)(396003)(451199021)(46966006)(36840700001)(40470700004)(40460700003)(186003)(16526019)(26005)(2616005)(1076003)(36860700001)(336012)(426003)(83380400001)(47076005)(41300700001)(4326008)(6916009)(2906002)(316002)(5660300002)(8676002)(8936002)(478600001)(7696005)(6666004)(70206006)(70586007)(54906003)(40480700001)(36756003)(81166007)(356005)(82740400003)(86362001)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2023 03:10:43.2842 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ebb8eae8-501b-48f0-5533-08db80f33f8b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT007.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5335
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
Cc: Veerabadhran Gopalakrishnan <Veerabadhran.Gopalakrishnan@amd.com>,
 Lijo Lazar <lijo.lazar@amd.com>, Leo Liu <leo.liu@amd.com>,
 Lang Yu <Lang.Yu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This will make this function more general, and then serve other IPs.

Suggested-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Lang Yu <Lang.Yu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 12 ++++++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h |  3 +++
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index c2508462e02f..a1a4408e524d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -2448,8 +2448,8 @@ static int psp_prep_load_ip_fw_cmd_buf(struct amdgpu_firmware_info *ucode,
 	return ret;
 }
 
-static int psp_execute_non_psp_fw_load(struct psp_context *psp,
-				  struct amdgpu_firmware_info *ucode)
+int psp_execute_ip_fw_load(struct psp_context *psp,
+			   struct amdgpu_firmware_info *ucode)
 {
 	int ret = 0;
 	struct psp_gfx_cmd_resp *cmd = acquire_psp_cmd_buf(psp);
@@ -2492,7 +2492,7 @@ static int psp_load_smu_fw(struct psp_context *psp)
 			DRM_WARN("Failed to set MP1 state prepare for reload\n");
 	}
 
-	ret = psp_execute_non_psp_fw_load(psp, ucode);
+	ret = psp_execute_ip_fw_load(psp, ucode);
 
 	if (ret)
 		DRM_ERROR("PSP load smu failed!\n");
@@ -2534,7 +2534,7 @@ int psp_load_fw_list(struct psp_context *psp,
 	for (i = 0; i < ucode_count; ++i) {
 		ucode = ucode_list[i];
 		psp_print_fw_hdr(psp, ucode);
-		ret = psp_execute_non_psp_fw_load(psp, ucode);
+		ret = psp_execute_ip_fw_load(psp, ucode);
 		if (ret)
 			return ret;
 	}
@@ -2581,7 +2581,7 @@ static int psp_load_non_psp_fw(struct psp_context *psp)
 
 		psp_print_fw_hdr(psp, ucode);
 
-		ret = psp_execute_non_psp_fw_load(psp, ucode);
+		ret = psp_execute_ip_fw_load(psp, ucode);
 		if (ret)
 			return ret;
 
@@ -2930,7 +2930,7 @@ int psp_update_vcn_sram(struct amdgpu_device *adev, int inst_idx,
 	ucode.mc_addr = cmd_gpu_addr;
 	ucode.ucode_size = cmd_size;
 
-	return psp_execute_non_psp_fw_load(&adev->psp, &ucode);
+	return psp_execute_ip_fw_load(&adev->psp, &ucode);
 }
 
 int psp_ring_cmd_submit(struct psp_context *psp,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
index 050230114e88..efb3972bfebd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -462,6 +462,9 @@ extern int psp_wait_for(struct psp_context *psp, uint32_t reg_index,
 extern int psp_wait_for_spirom_update(struct psp_context *psp, uint32_t reg_index,
 			uint32_t field_val, uint32_t mask, uint32_t msec_timeout);
 
+int psp_execute_ip_fw_load(struct psp_context *psp,
+			   struct amdgpu_firmware_info *ucode);
+
 int psp_gpu_reset(struct amdgpu_device *adev);
 int psp_update_vcn_sram(struct amdgpu_device *adev, int inst_idx,
 			uint64_t cmd_gpu_addr, int cmd_size);
-- 
2.25.1

