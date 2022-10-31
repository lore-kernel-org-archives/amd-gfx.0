Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E55B1FA3741
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Oct 2022 16:25:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5ADFA10E2F5;
	Mon, 31 Oct 2022 16:25:06 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2078.outbound.protection.outlook.com [40.107.96.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5BA8089349
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Oct 2022 16:24:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TrrI/SU4lBn70tW9QcsujmqHopm+3biiekrd6iHZTK2FStnCq07C2hd7l+4Izjnhn6u2KELNCPe6o3iN8UYSBfDHrI2DmvU6Q0k1ILPp/odwCTwTbVTa6kPN5KAxQw2gAtpqUMeWO+mtw/rfyd+Bj5JCtEnaK1l/1JShzylI1a0VrQLRrvRIQ8/lb8Eytl3+9UGmpTWF7IMYBQe54VrCwXvbAnnyI5dOn00vFyW8J9LgWYs+lOsuZz8vxxHlL6QWwVmQIAGR4DlqsoEDE+AZqwdP+mBiloNyOwfuouvFqjiArt3173AFSiTvIAIlkO2sqv+PDVOVohJxQja+IzSuMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lNArw5aI9bgkDcL9AOfYnRf1tRmB6IgO+bIhy3y/jiY=;
 b=GHaG2SswI2h5BTfknkOu3f5hjW7BkTtXpvdOvayafaHq7L23ZuAObwS4kH/97Pb9bXWFj+Pc8y6yDXFTbHptyHXw2cOMeDU2phHcgZHAbCJStAqsHGKpZgiPsPMc+wc8tcCkBEcU4UzoykQi0t/JvQ7PcptXAW6e7uTmNbQvh4VAdA4p/fp+ytFzyp9eXSTSFdh+DtOfgiuy2cU/ZowIUeaHvLjt3f32IgK7E/41AJbJ1e3FWW3qRSS3BGjXaPe3WS3lzVf5xbcCaKvCxfkwCqHoVxIK+tHjYlx/CZdhWkfiKsTmZ8olUOzc9tYR/SIxW3qyok6IGT5hH554Qgf+hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lNArw5aI9bgkDcL9AOfYnRf1tRmB6IgO+bIhy3y/jiY=;
 b=i3YX3LL/9SaNfIcZVGmow6sZueLwI9tep4obbdfha/Aq9I4cmtJPAtHMXHETFLB48aOEzzlzUgXt8WajsM0fKADexQeP1OCFPD9WOF/CujladfqXDWrvO8ak+r/a+22AXx+6tmQuS0XWQjh5zh19D+18QbDxBBZdCygVYeJIQjY=
Received: from MW4PR04CA0110.namprd04.prod.outlook.com (2603:10b6:303:83::25)
 by BN9PR12MB5321.namprd12.prod.outlook.com (2603:10b6:408:102::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.15; Mon, 31 Oct
 2022 16:24:28 +0000
Received: from CO1NAM11FT091.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:83:cafe::c8) by MW4PR04CA0110.outlook.office365.com
 (2603:10b6:303:83::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.19 via Frontend
 Transport; Mon, 31 Oct 2022 16:24:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT091.mail.protection.outlook.com (10.13.175.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5769.14 via Frontend Transport; Mon, 31 Oct 2022 16:24:28 +0000
Received: from jonathan-KFD.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 31 Oct
 2022 11:24:24 -0500
From: Jonathan Kim <jonathan.kim@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 09/29] drm/amdgpu: add gfx9.4.2 hw debug mode enable and
 disable calls
Date: Mon, 31 Oct 2022 12:23:39 -0400
Message-ID: <20221031162359.445805-9-jonathan.kim@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221031162359.445805-1-jonathan.kim@amd.com>
References: <20221031162359.445805-1-jonathan.kim@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT091:EE_|BN9PR12MB5321:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d26f953-5550-4b35-2e2f-08dabb5c6204
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CJzLZw+7Je/kfmzBCtqBi1K+hdd+4eojw6ofQvV/jXbQ5yIvUhBOqZrzavkK33uiPJs6VXjncYT1gCLThGuPCUhM6OsI3T5t5MsB4OO0s0FtqxZ0vMVmM9mSaX6Lf4YSnNLUKR/hPUPBgvDhpAr489Zx63UG56s/5A+gtIlow5ACqiMKNjDqOxicrZ7Q++HJGEcOtv7KqJrQE/9XKIQjzvQBHPZ9FZSBw+ExXFXfn/eIryIfvRlJ7McCEt7knv852ccJjpGtIaGWpeo5oiHz4QqGX0+i4RaC7RLtUe5g6ydx4kS9TLWP9vPKIY4b0iaISAxxI+FPrr39EyznneZ0S6IzjtbT4N2wQSaWQOk81hqusbCWG7ADHs5CJ5wz40UHx/onVPa9i3ikTi5k5xu1Hyja1ANEBA51LyNx5xyRQUkyzHnRGf5+cp5/7xy8JTW9SwOEw7189mS+lQ/0w64QusuR1b7i1tci8AQ+qMwFJaWn79EVSnjkOq2Qb5T7gPWhiqv3VHu+beY1kpkc27bRnxJTFcwQxkol0nPIMvLme7lTst4mrjhkQe/3N6qUeRzyHeid7iU3lKaIeS7sMVdSayF3uZwWcsvNtyzAoCtbyjqORHWkDwM2xv69G5tKg5Y422V3Op6j08McSAYYtjQLaHx6oW/cWM8geWALbk44QsuQQGOcRfUQSaEmWEXL5de8IGTsDoa2P+nHux1cxOm5U1bdwWjrnUXZPtprJWkTWw0SZ6Du7f7DZs35kSfoXvRty85H+MuIJIErlbEp1xx1/g4DXVRuMDiusWFTeGUJhvqOj0dneP18j2V2Z7a8dDtV
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(136003)(346002)(376002)(396003)(451199015)(36840700001)(46966006)(40470700004)(1076003)(8936002)(70206006)(70586007)(316002)(41300700001)(6916009)(36756003)(186003)(6666004)(82740400003)(356005)(40480700001)(2906002)(2616005)(478600001)(16526019)(4326008)(26005)(7696005)(81166007)(40460700003)(44832011)(336012)(36860700001)(47076005)(82310400005)(5660300002)(8676002)(426003)(86362001)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2022 16:24:28.0454 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d26f953-5550-4b35-2e2f-08dabb5c6204
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT091.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5321
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
Cc: Felix.Kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

GFX9.4.2 now supports per-VMID debug mode controls registers
(SPI_GDBG_PER_VMID_CNTL).

Because the KFD lets the HWS handle PASID-VMID mapping, the KFD will
forward all debug mode setting register writes to the HWS scheduler
using a new MAP_PROCESS API, so instead of writing to registers, return
the required register values that the HWS needs to write on debug enable
and disable.

Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
---
 .../drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c  | 34 ++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
index c8935d718207..42491a31f352 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
@@ -23,6 +23,36 @@
 #include "amdgpu_amdkfd.h"
 #include "amdgpu_amdkfd_arcturus.h"
 #include "amdgpu_amdkfd_gfx_v9.h"
+#include "gc/gc_9_4_2_offset.h"
+#include "gc/gc_9_4_2_sh_mask.h"
+
+/* returns TRAP_EN, EXCP_EN and EXCP_REPLACE. */
+static uint32_t kgd_aldebaran_enable_debug_trap(struct amdgpu_device *adev,
+					    bool restore_dbg_registers,
+					    uint32_t vmid)
+{
+	uint32_t data = 0;
+
+	data = REG_SET_FIELD(data, SPI_GDBG_PER_VMID_CNTL, TRAP_EN, 1);
+	data = REG_SET_FIELD(data, SPI_GDBG_PER_VMID_CNTL, EXCP_EN, 0);
+	data = REG_SET_FIELD(data, SPI_GDBG_PER_VMID_CNTL, EXCP_REPLACE, 0);
+
+	return data;
+}
+
+/* returns TRAP_EN, EXCP_EN and EXCP_REPLACE. */
+static uint32_t kgd_aldebaran_disable_debug_trap(struct amdgpu_device *adev,
+						bool keep_trap_enabled,
+						uint32_t vmid)
+{
+	uint32_t data = 0;
+
+	data = REG_SET_FIELD(data, SPI_GDBG_PER_VMID_CNTL, TRAP_EN, keep_trap_enabled);
+	data = REG_SET_FIELD(data, SPI_GDBG_PER_VMID_CNTL, EXCP_EN, 0);
+	data = REG_SET_FIELD(data, SPI_GDBG_PER_VMID_CNTL, EXCP_REPLACE, 0);
+
+	return data;
+}
 
 const struct kfd2kgd_calls aldebaran_kfd2kgd = {
 	.program_sh_mem_settings = kgd_gfx_v9_program_sh_mem_settings,
@@ -41,5 +71,7 @@ const struct kfd2kgd_calls aldebaran_kfd2kgd = {
 	.get_atc_vmid_pasid_mapping_info =
 				kgd_gfx_v9_get_atc_vmid_pasid_mapping_info,
 	.set_vm_context_page_table_base = kgd_gfx_v9_set_vm_context_page_table_base,
-	.program_trap_handler_settings = kgd_gfx_v9_program_trap_handler_settings
+	.enable_debug_trap = kgd_aldebaran_enable_debug_trap,
+	.disable_debug_trap = kgd_aldebaran_disable_debug_trap,
+	.program_trap_handler_settings = kgd_gfx_v9_program_trap_handler_settings,
 };
-- 
2.25.1

