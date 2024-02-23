Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 938B1C48BC4
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Feb 2024 08:24:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 012F810E08C;
	Fri, 23 Feb 2024 08:24:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sy/EfSfa";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2064.outbound.protection.outlook.com [40.107.244.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A5D6F10E08C
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Feb 2024 08:24:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C5o34Rb1OY67u5d8dYUkY3S2GUbBtaa4RCS2Jh0dKjPDAIXLDUVwU8GtOtCq1p6iooN0AQ7ypnHynLorV5ojnqmr0cIo4YmAIdTaO8QdljplDDvHqyyEqxDRgqVimkYoy6xq8tiVEJYXWM1bTiIYwg15Drc/1P66YidgO0vRIQXvc+jOXh+3p+iTToDeiDH9E1hihlVmsdKQdQqK2OBHDXQZq+bHlhtRVEA6vn2VW4+p35fqehyrAz1k0fcrml8ULINsc2cHjUhyq2p988CMCqb9Y0qBgZM6L/8pWjxKrXIz8tPYvXPG9+1HHV5bTas/HuZR/OojAKTm89CVgqHFxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X8fgQjZXpV7MVRHMC+rqxRVDg9NUNslqqbWUD7FPAx0=;
 b=YKzN1mqfhnKEeIMZrSacmmG80mIXYtl3Fo7ctx2MRUfGZ/Uk5Mqkwicam4wC800b7ke72oJbREHqDKvuJqE8fTJab7Ou8feIZhzQFfOYK+qI3np7taRL+jz3Y9WPGITnGnpqwEPE3PKmRRXIKv6rwWYIukTBhy/IIX2SI3wIMZwBUDpLEXqCsBjKUnk49rLdHr7fPLmvT3aHcACLMZlnVqvV8IlxPXRTmIc0Djh8Ymh510Aqn1n67GuPxiN4n8A5+ZA3iAZ/viC003bsa2mpO5OZlAH/6gkaJ3zwqS862U+Wc75EdRW+GlpNY+7oF4myL6v8TnLdBewjf4Mrzp8Eew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X8fgQjZXpV7MVRHMC+rqxRVDg9NUNslqqbWUD7FPAx0=;
 b=sy/EfSfa2Upi1xevteAY6KDre8qFlzKyqoNDl07iLAHaBpb/tcZ9PtNDifY2i9ppTh9D+Mg44yodpKlfwEE3Dtm6ukodcPPGcr6063ac4WvEHmso9N9/aEwB1AaCRg6tx1ODmWc386WzAHx/rji06Au26mS6TiXlt/pWj6+FiZ4=
Received: from SA9PR13CA0153.namprd13.prod.outlook.com (2603:10b6:806:28::8)
 by DM6PR12MB5021.namprd12.prod.outlook.com (2603:10b6:5:208::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.24; Fri, 23 Feb
 2024 08:24:03 +0000
Received: from SA2PEPF000015CC.namprd03.prod.outlook.com
 (2603:10b6:806:28:cafe::4f) by SA9PR13CA0153.outlook.office365.com
 (2603:10b6:806:28::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.11 via Frontend
 Transport; Fri, 23 Feb 2024 08:24:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Fri, 23 Feb 2024 08:24:03 +0000
Received: from tao-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 23 Feb
 2024 02:24:02 -0600
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH 2/5] drm/amdgpu: add utcl2 poison query for gfxhub
Date: Fri, 23 Feb 2024 16:23:49 +0800
Message-ID: <20240223082352.323583-2-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240223082352.323583-1-tao.zhou1@amd.com>
References: <20240223082352.323583-1-tao.zhou1@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CC:EE_|DM6PR12MB5021:EE_
X-MS-Office365-Filtering-Correlation-Id: 679790ad-4e09-4f47-a3bf-08dc3448cb6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Kv1M0k3VxLaondkEFfscFDP98z5yyC6A99HbsLFFv7PgB0GKodvS/wGfc6O57Kd8rod/LHNU+4qsPRqdQ752Bf5PxO5o9Moy8ppTI1SONDSHWFnnAk5AdJ3EpjuERlBJqQvYzHhz9plu7Idu56Kn88BmdItEzY6UGLg2CLtCBDcHqNq/SL9X5R/0WSnKSyNt0aI0xYEQxFaIO2ooXR6iKDptfNN6/4AHpaY+TLeTKtjxwXWLCM329/HMeDsQRpkSXtJKzhBs1a4PlJK8NHHJ196oY/dUUYMM/tftm+HcxiIe2xm6JUTsLl1wzC9OEbqvsrizeJdNTbSiCWOsDS9JohVSzxzHlYercobcuH868Ywi7vmxipdzqHGq2bjOYSkGLJT1pgDsi8bGogrf44kv3pW6gqov0IDiewaVH8hgKtlaI5dwhfoyuQh/XGlCEsHj7/jXSUKnU3aMNAJOA5MHizqTXAA3DZp6ZSBvgPvZzLhy1Z+DgiFwd69HvkXiWPZInmHfg2Y5PZt00yCLbnSpk6VP16Op+lUmRSnskhP9LHRLbbCKDexYrvp39K7m7aNQMkj5eEQ0FjCfl7zGHyW8Eg+yy6HMTa3FadgiH2qnXpAK502WlR61OMK3hJZoX/4rWtEOrekSjBlK8ZV8wwNyp5fnsCWDU6x9qfVzyMAAY/k=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(40470700004)(46966006); DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2024 08:24:03.4392 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 679790ad-4e09-4f47-a3bf-08dc3448cb6d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5021
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

Implement it for gfxhub 1.0 and 1.2.

v2: input logical xcc id for poison query interface.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfxhub.h |  2 ++
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c   | 17 +++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c   | 15 +++++++++++++++
 3 files changed, 34 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfxhub.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfxhub.h
index c7b44aeb671b..103a837ccc71 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfxhub.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfxhub.h
@@ -38,6 +38,8 @@ struct amdgpu_gfxhub_funcs {
 	void (*mode2_save_regs)(struct amdgpu_device *adev);
 	void (*mode2_restore_regs)(struct amdgpu_device *adev);
 	void (*halt)(struct amdgpu_device *adev);
+	bool (*query_utcl2_poison_status)(struct amdgpu_device *adev,
+			int xcc_id);
 };
 
 struct amdgpu_gfxhub {
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
index 22175da0e16a..d200310d1731 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
@@ -443,6 +443,22 @@ static void gfxhub_v1_0_init(struct amdgpu_device *adev)
 		mmVM_INVALIDATE_ENG0_ADDR_RANGE_LO32;
 }
 
+static bool gfxhub_v1_0_query_utcl2_poison_status(struct amdgpu_device *adev,
+				int xcc_id)
+{
+	u32 status = 0;
+	struct amdgpu_vmhub *hub;
+
+	if (amdgpu_ip_version(adev, GC_HWIP, 0) != IP_VERSION(9, 4, 2))
+		return false;
+
+	hub = &adev->vmhub[AMDGPU_GFXHUB(0)];
+	status = RREG32(hub->vm_l2_pro_fault_status);
+	/* reset page fault status */
+	WREG32_P(hub->vm_l2_pro_fault_cntl, 1, ~1);
+
+	return REG_GET_FIELD(status, VM_L2_PROTECTION_FAULT_STATUS, FED);
+}
 
 const struct amdgpu_gfxhub_funcs gfxhub_v1_0_funcs = {
 	.get_mc_fb_offset = gfxhub_v1_0_get_mc_fb_offset,
@@ -452,4 +468,5 @@ const struct amdgpu_gfxhub_funcs gfxhub_v1_0_funcs = {
 	.set_fault_enable_default = gfxhub_v1_0_set_fault_enable_default,
 	.init = gfxhub_v1_0_init,
 	.get_xgmi_info = gfxhub_v1_1_get_xgmi_info,
+	.query_utcl2_poison_status = gfxhub_v1_0_query_utcl2_poison_status,
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
index 49aecdcee006..77df8c9cbad2 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
@@ -620,6 +620,20 @@ static int gfxhub_v1_2_get_xgmi_info(struct amdgpu_device *adev)
 	return 0;
 }
 
+static bool gfxhub_v1_2_query_utcl2_poison_status(struct amdgpu_device *adev,
+				int xcc_id)
+{
+	u32 fed, status;
+
+	status = RREG32_SOC15(GC, GET_INST(GC, xcc_id), regVM_L2_PROTECTION_FAULT_STATUS);
+	fed = REG_GET_FIELD(status, VM_L2_PROTECTION_FAULT_STATUS, FED);
+	/* reset page fault status */
+	WREG32_P(SOC15_REG_OFFSET(GC, GET_INST(GC, xcc_id),
+			regVM_L2_PROTECTION_FAULT_STATUS), 1, ~1);
+
+	return fed;
+}
+
 const struct amdgpu_gfxhub_funcs gfxhub_v1_2_funcs = {
 	.get_mc_fb_offset = gfxhub_v1_2_get_mc_fb_offset,
 	.setup_vm_pt_regs = gfxhub_v1_2_setup_vm_pt_regs,
@@ -628,6 +642,7 @@ const struct amdgpu_gfxhub_funcs gfxhub_v1_2_funcs = {
 	.set_fault_enable_default = gfxhub_v1_2_set_fault_enable_default,
 	.init = gfxhub_v1_2_init,
 	.get_xgmi_info = gfxhub_v1_2_get_xgmi_info,
+	.query_utcl2_poison_status = gfxhub_v1_2_query_utcl2_poison_status,
 };
 
 static int gfxhub_v1_2_xcp_resume(void *handle, uint32_t inst_mask)
-- 
2.34.1

