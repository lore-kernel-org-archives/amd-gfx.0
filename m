Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE840C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Mar 2022 07:03:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 719E910E2D4;
	Mon, 14 Mar 2022 07:03:51 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2050.outbound.protection.outlook.com [40.107.93.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5EFE410E237
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Mar 2022 07:03:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D3isKRXfU9ktBhR5JvzMQ8oiOet5lMQvDbFR6sBWy3BiuJhEW7iHKX5cbcoQNevENnXcWSg4tbIAggkYMB7vwTH/nLI310njoKbhVXiQ1+hgJ/fZ5SFCYXqMeKMJGv4nH1+Ng7asYlu1jMHmiKdC7ZHVGjqu4N6M0788MkdcqSjIPZTigJylO6g8eKpJfDqIlfMPAxn4ctiO7cCXr+OQkabDwCVA/DK3FfB0tZyhmoVfs7804MHnZtg+SJctreGQwDmK2MAjx8TFDcBAMDwL7CTDAJnF9uGWVu/fkP16UWl8ap8dEDBZ1DHI8J77ttpORA6Fx4Be5/6LsJjEQQSENw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lQMRozgCEJ1lxf0uOnztmgMUqQ7WEZf9QLJ8rls8Ulo=;
 b=j7OadqvjU2N+5TB673eZ6M9FHsaJXlbD+wCH+7LGGXPwOv15+o6iRUVqY1Qn9lkLOrqVZCiPO0yjigUegjHNFo16Vi5+oYADUQq2r2nx2L687mAUmgErRvPoeig6ucaFUosItaNazyvkKVXr0jSXyKHt61ob6iKcLpVA2SKgxWbQOySjlD+32EirZGWJB8bm0zVSVtrWyygwJ9RhzQfxy2SFnB8C57+7aNHhwpkDM+VuVCbq5j34NYY4Y8srwuXOfuyMddGJKF0pEut7CnmXMU7J/Z7tqQGCbqLuKpWI9csdnSZhIHJVZDkE7DiuvAsrxWDrT6zhCmP4sf6YH+fTAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lQMRozgCEJ1lxf0uOnztmgMUqQ7WEZf9QLJ8rls8Ulo=;
 b=CaQyST+pOgz2MwpzfJqEsPTtHmPl/VRWREFrCueuzNf+aRo+Jio5M/bqfdDFKAQ5OKTB3JLTuOmzkQRAErIIZCI1Y1cxI6LKVd9FsR7M+FoffyO3EsjpsqdDizShABNBx14D6fRX0sU/0uHSYxiISBACkN4N1vLq/5q8yZImZPU=
Received: from BN6PR13CA0028.namprd13.prod.outlook.com (2603:10b6:404:13e::14)
 by DM6PR12MB2635.namprd12.prod.outlook.com (2603:10b6:5:45::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.24; Mon, 14 Mar
 2022 07:03:46 +0000
Received: from BN8NAM11FT047.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:13e:cafe::b5) by BN6PR13CA0028.outlook.office365.com
 (2603:10b6:404:13e::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.13 via Frontend
 Transport; Mon, 14 Mar 2022 07:03:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT047.mail.protection.outlook.com (10.13.177.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5061.22 via Frontend Transport; Mon, 14 Mar 2022 07:03:45 +0000
Received: from taozhou1u2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 14 Mar
 2022 02:03:41 -0500
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <hawking.zhang@amd.com>,
 <stanley.yang@amd.com>, <yipeng.chai@amd.com>
Subject: [PATCH 2/3] drm/amdgpu: add utcl2 RAS poison functions for Aldebaran
Date: Mon, 14 Mar 2022 15:03:25 +0800
Message-ID: <20220314070326.21828-2-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220314070326.21828-1-tao.zhou1@amd.com>
References: <20220314070326.21828-1-tao.zhou1@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 12bd843c-94ee-454c-4f30-08da0588c875
X-MS-TrafficTypeDiagnostic: DM6PR12MB2635:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB2635C5B7E57B0E3CA97C2121B00F9@DM6PR12MB2635.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Vs7EnAlsU//DzZIEP8fGPRzdh24nHdSHIm/8NxQ5cTDr8iryzKDxQo7r4aoDQ2gfefu9pKpgqN94Djy3TatwONb8x/wt92yr4F1/RAyjrnEbn8y+uQObdrCB01QAKEX0k2AbxpWuxt+a1KE3tsFfhnm0VnjsLF3zNo+4UwP4wwfd/9rWh64zfsi4w1ICTaul67XYFa7UuXSgH3Amq0pJyXlvt5eZ6+ujvIlRXH80MUP/T9f4Y50UeSilp/Ag19UhdHYIVATcI8XwXFQ7Lgujhr9kLOMa5qZvDI4OEAsPUQMxqMO3+UogA2jJYAUsSuwYIEaFQQZ9g2Dr8hB2RXVmASIJUqfwXJtn63GV8Ae4a6SvLPEXBc0eW/DaehsP9rPw797wCZvDM+o89UcwcUPEHI+reCX9TXzak4i3DLg7WqW+O0q4/grzMCZSgE1arp4FAmt8duiGiGaSHFAn/8w7TnwYBfa2OhF5jbmy1s8AMxddWb40SYhLS8PuGphr+k3T9cjIerhl4f17MqguAhAflUn6b0P2Fl5pynD9U62uWBG0R+re3uN66OgpxUkIIZXv01xLwnFhpw+s9r9OsGvPS5xdqnyEpE6jh+i/rY9n9iQCHmgS/SqDfSrFiGx4ybEiXQsg5i784YtZ3jmKO5/ptQ9ZSVFm9HkhDa/BoV76zKaz/xLxCMP77yPm6RXRVkStg4w5kxqBBbp/8mp5LXHAwQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(5660300002)(70586007)(70206006)(8936002)(4326008)(6666004)(8676002)(47076005)(2616005)(1076003)(316002)(36860700001)(40460700003)(356005)(81166007)(86362001)(82310400004)(2906002)(508600001)(83380400001)(36756003)(16526019)(26005)(186003)(7696005)(336012)(426003)(6636002)(110136005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2022 07:03:45.9575 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 12bd843c-94ee-454c-4f30-08da0588c875
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT047.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2635
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

Add help functions to check and clear RAS utcl2 poison status.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 .../drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c  | 28 ++++++++++++++++++-
 .../gpu/drm/amd/include/kgd_kfd_interface.h   |  3 ++
 2 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
index c8935d718207..ebd7d36d099b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
@@ -23,6 +23,30 @@
 #include "amdgpu_amdkfd.h"
 #include "amdgpu_amdkfd_arcturus.h"
 #include "amdgpu_amdkfd_gfx_v9.h"
+#include "soc15.h"
+#include "gc/gc_9_4_2_sh_mask.h"
+
+static bool kgd_aldebaran_is_ras_utcl2_poison(struct amdgpu_device *adev,
+			uint16_t client_id)
+{
+	uint32_t status = 0;
+	struct amdgpu_vmhub *hub;
+
+	if (client_id != SOC15_IH_CLIENTID_UTCL2)
+		return false;
+
+	hub = &adev->vmhub[AMDGPU_GFXHUB_0];
+	status = RREG32(hub->vm_l2_pro_fault_status);
+	return REG_GET_FIELD(status, VM_L2_PROTECTION_FAULT_STATUS, FED);
+}
+
+static void kgd_aldebaran_utcl2_fault_clear(struct amdgpu_device *adev)
+{
+	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB_0];
+
+	hub = &adev->vmhub[AMDGPU_GFXHUB_0];
+	WREG32_P(hub->vm_l2_pro_fault_cntl, 1, ~1);
+}
 
 const struct kfd2kgd_calls aldebaran_kfd2kgd = {
 	.program_sh_mem_settings = kgd_gfx_v9_program_sh_mem_settings,
@@ -41,5 +65,7 @@ const struct kfd2kgd_calls aldebaran_kfd2kgd = {
 	.get_atc_vmid_pasid_mapping_info =
 				kgd_gfx_v9_get_atc_vmid_pasid_mapping_info,
 	.set_vm_context_page_table_base = kgd_gfx_v9_set_vm_context_page_table_base,
-	.program_trap_handler_settings = kgd_gfx_v9_program_trap_handler_settings
+	.program_trap_handler_settings = kgd_gfx_v9_program_trap_handler_settings,
+	.is_ras_utcl2_poison = kgd_aldebaran_is_ras_utcl2_poison,
+	.utcl2_fault_clear = kgd_aldebaran_utcl2_fault_clear
 };
diff --git a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
index 2f60cf35a444..78400479193e 100644
--- a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
@@ -291,6 +291,9 @@ struct kfd2kgd_calls {
 			int *wave_cnt, int *max_waves_per_cu);
 	void (*program_trap_handler_settings)(struct amdgpu_device *adev,
 			uint32_t vmid, uint64_t tba_addr, uint64_t tma_addr);
+	bool (*is_ras_utcl2_poison)(struct amdgpu_device *adev,
+			uint16_t client_id);
+	void (*utcl2_fault_clear)(struct amdgpu_device *adev);
 };
 
 #endif	/* KGD_KFD_INTERFACE_H_INCLUDED */
-- 
2.35.1

