Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3F4EC433EF
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Dec 2021 03:06:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1ED776EB95;
	Fri,  3 Dec 2021 03:06:29 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2088.outbound.protection.outlook.com [40.107.236.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D82176EBAC
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Dec 2021 03:06:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=crGPh063Kgf4G0A4cY3slu8pBO+2M1mo2JoTdhjXoQpAD02PYF/KtuWds9sFs6bu18jhv7/Ea8mk2fJy2twwAU8x7UBG5eDST3FNA4TzXpy6igdZQ1HASLgZJE5IxbVa0Z0keSllphhz4060MTno8Hij0BJJhuLGcxf+UHqp1Uw6NxVenUjqA1w9KxTDsKNp5JV/rErjC+oVVIyNLZWOqHlyAjdb181hACJvph+CSt/svV4+xqpmPtFI2WLTVRRrbxxyHhUkxZ9wDAdDKNn5V8ZITBVH/Kg2ahx205oCS6WtYNK2krj8/A4qDH1qnaB0a4YpC5PFrHrLSfeSxwvBzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BaxbVyMTYGwXnFYlWt78Kx1K9rB+WwdSw/ZmejaQIKw=;
 b=EPeq3tMEWFEM8+HRNqfCx4QrbJtCEgiosG6buSzBrDSISQBVlPDEovGXV6voqArC+EFYt7C+cmTMuMA2YB+rzFdN2V+QXyIyaRuJz9UoioUIYGvaNk9OFSaEFMWQkjvbgIDHNWxsCD80ubrF1xwLE0Q/VKI5WQe3YL6LqXTnVSKb/9ygRKv3uPeT/PbDPFuoTdRB0WSgqAZ17DRgJRfftJ0q2+wy1sr89GVxmCuN5qQHNs7EcIk9Gz4X2sTF59t10ee+2ElgfWub2IaqosDwObgEZlPnHO+PALvhCE6b8oqAQaXYxoX53Zr1YtTTATXqSGKzXal2lelnAxHQZOBYdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BaxbVyMTYGwXnFYlWt78Kx1K9rB+WwdSw/ZmejaQIKw=;
 b=cfMz+syoUKxlaEzAR2xO1Wy2VVWSjqbXUqshwqX5DRwDa8cw3ve4G/t0f/bIfnp9vBJ5EGvJp8Z5Pcl8jLKxVT/oK+Z/D0Ye7+H6OgqkF+1zJGOD0pF8nIKhjpEPFQBnBvqcDyRKjN6gIPoI0sfD7TDDbB0lzo1NI2RH6jkN05o=
Received: from MWHPR12CA0049.namprd12.prod.outlook.com (2603:10b6:300:103::11)
 by MWHPR12MB1695.namprd12.prod.outlook.com (2603:10b6:301:f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.16; Fri, 3 Dec
 2021 03:06:25 +0000
Received: from CO1NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:103:cafe::c8) by MWHPR12CA0049.outlook.office365.com
 (2603:10b6:300:103::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.17 via Frontend
 Transport; Fri, 3 Dec 2021 03:06:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT036.mail.protection.outlook.com (10.13.174.124) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4755.13 via Frontend Transport; Fri, 3 Dec 2021 03:06:25 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 2 Dec
 2021 21:06:22 -0600
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V4 12/17] drm/amd/pm: drop redundant or unused APIs and data
 structures
Date: Fri, 3 Dec 2021 11:05:35 +0800
Message-ID: <20211203030540.1710564-12-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20211203030540.1710564-1-evan.quan@amd.com>
References: <20211203030540.1710564-1-evan.quan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5788394a-2347-43aa-c71e-08d9b609e469
X-MS-TrafficTypeDiagnostic: MWHPR12MB1695:
X-Microsoft-Antispam-PRVS: <MWHPR12MB1695F9EA938108BAA4F11C4CE46A9@MWHPR12MB1695.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:81;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tIVmgVMyP0Esg5uM81+jUsOL6d8MGtAqNaTUz4HeJuXJdho4KLOeaHM36Llw67KzjrDqjg9GrvGZ75sxY1a0jta4oj9P8NJOTwg/je6+UOYoo4E5dKhXjB/N2Idm5A6nbZ64qdBhj13Hz4yWoIpdZHJRlB9mCionVncUt3EdYLUilv9TwEpNufzps+ClvmoasM0EIY/1U+GHH2kIX1Iry2nSKOB0qxgQgN3+5fVKLFaJ3tjcNvk7k2LhvxPBgopmHRKTIAtE8dHAO9hjzHsnIf/AZps1CoDuShrlE7Zzn+yMvsNIu4jtWqWZy5bNBo+Zxi2owTnWVgOE5TuFxCaHRL7nYlpuEwbxdHkvKQ7mBt0c3hFVJ3Pdz1d4iUCEF3dqtmD49bP41oN+IqoNQrbkpzKWi4M+4QntFMdwsTVCQ5sw+tE6Ebgt/wGPoJwT+GKlO10FF1GRqKJ6L/37AnTaUqPVQO1pVnAUxrYek2/O3/YW8yFNTN15JP1WTTqQFtNn5bMy9ZtD5pn63o01oKIin/mERgsUSFPMv0btMEmVVc08sW6n8FUT0dvw3Hr0AEmuvRQG0OnIFQu9DWS0ElbaHKPKugvFnWB7d6otTjN+ZrarlfVmM2SruzHuhQi6kboczwE+dDjYmhN94a1uouKwxVsh6jiOzutdK9F0fXv2/HWSYiYJFQxySJXQWzpHvUlVjjqn8vkhozw5IIbHTeHCeaSPnxuaHY15X/A4PtDw/MKeqSS3JDLt1wexyqRkRccwGcYClKB2bvjm6f5cl2VYMNw1+8/SsPnkb8odaC2jbnCOMJ9UejHW7v+ukDDbPkQD
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700001)(4326008)(82310400004)(83380400001)(40460700001)(6666004)(8936002)(26005)(336012)(44832011)(16526019)(36860700001)(7696005)(81166007)(36756003)(186003)(2616005)(356005)(8676002)(70586007)(70206006)(426003)(47076005)(54906003)(316002)(86362001)(6916009)(508600001)(5660300002)(2906002)(1076003)(21314003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2021 03:06:25.1015 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5788394a-2347-43aa-c71e-08d9b609e469
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1695
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
Cc: Alexander.Deucher@amd.com, lijo.lazar@amd.com, Kenneth.Feng@amd.com,
 christian.koenig@amd.com, Evan Quan <evan.quan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Drop those unused APIs and data structures.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Change-Id: I57d2a03dcda02d0b5d9c5ffbdd37bffe49945407
---
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h | 49 -------------------------
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h  |  4 ++
 2 files changed, 4 insertions(+), 49 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
index b0791e855ad3..de76636052e6 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
@@ -88,19 +88,6 @@ struct amdgpu_dpm_thermal {
 	struct amdgpu_irq_src	irq;
 };
 
-enum amdgpu_clk_action
-{
-	AMDGPU_SCLK_UP = 1,
-	AMDGPU_SCLK_DOWN
-};
-
-struct amdgpu_blacklist_clocks
-{
-	u32 sclk;
-	u32 mclk;
-	enum amdgpu_clk_action action;
-};
-
 struct amdgpu_clock_and_voltage_limits {
 	u32 sclk;
 	u32 mclk;
@@ -239,10 +226,6 @@ struct amdgpu_dpm_fan {
 	bool ucode_fan_control;
 };
 
-#define amdgpu_dpm_reset_power_profile_state(adev, request) \
-		((adev)->powerplay.pp_funcs->reset_power_profile_state(\
-			(adev)->powerplay.pp_handle, request))
-
 struct amdgpu_dpm {
 	struct amdgpu_ps        *ps;
 	/* number of valid power states */
@@ -339,35 +322,6 @@ struct amdgpu_pm {
 	bool			pp_force_state_enabled;
 };
 
-#define R600_SSTU_DFLT                               0
-#define R600_SST_DFLT                                0x00C8
-
-/* XXX are these ok? */
-#define R600_TEMP_RANGE_MIN (90 * 1000)
-#define R600_TEMP_RANGE_MAX (120 * 1000)
-
-#define FDO_PWM_MODE_STATIC  1
-#define FDO_PWM_MODE_STATIC_RPM 5
-
-enum amdgpu_td {
-	AMDGPU_TD_AUTO,
-	AMDGPU_TD_UP,
-	AMDGPU_TD_DOWN,
-};
-
-enum amdgpu_display_watermark {
-	AMDGPU_DISPLAY_WATERMARK_LOW = 0,
-	AMDGPU_DISPLAY_WATERMARK_HIGH = 1,
-};
-
-enum amdgpu_display_gap
-{
-    AMDGPU_PM_DISPLAY_GAP_VBLANK_OR_WM = 0,
-    AMDGPU_PM_DISPLAY_GAP_VBLANK       = 1,
-    AMDGPU_PM_DISPLAY_GAP_WATERMARK    = 2,
-    AMDGPU_PM_DISPLAY_GAP_IGNORE       = 3,
-};
-
 u32 amdgpu_dpm_get_vblank_time(struct amdgpu_device *adev);
 int amdgpu_dpm_read_sensor(struct amdgpu_device *adev, enum amd_pp_sensors sensor,
 			   void *data, uint32_t *size);
@@ -417,9 +371,6 @@ int amdgpu_dpm_smu_i2c_bus_access(struct amdgpu_device *adev,
 
 void amdgpu_pm_acpi_event_handler(struct amdgpu_device *adev);
 
-int amdgpu_dpm_read_sensor(struct amdgpu_device *adev, enum amd_pp_sensors sensor,
-			   void *data, uint32_t *size);
-
 void amdgpu_dpm_compute_clocks(struct amdgpu_device *adev);
 void amdgpu_dpm_enable_uvd(struct amdgpu_device *adev, bool enable);
 void amdgpu_dpm_enable_vce(struct amdgpu_device *adev, bool enable);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
index beea03810bca..67a25da79256 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
@@ -26,6 +26,10 @@
 #include "amdgpu_smu.h"
 
 #if defined(SWSMU_CODE_LAYER_L2) || defined(SWSMU_CODE_LAYER_L3) || defined(SWSMU_CODE_LAYER_L4)
+
+#define FDO_PWM_MODE_STATIC  1
+#define FDO_PWM_MODE_STATIC_RPM 5
+
 int smu_cmn_send_msg_without_waiting(struct smu_context *smu,
 				     uint16_t msg_index,
 				     uint32_t param);
-- 
2.29.0

