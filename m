Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8478C433FE
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Dec 2021 03:10:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4264B6E8E8;
	Thu,  2 Dec 2021 03:10:12 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2064.outbound.protection.outlook.com [40.107.220.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 835F36E8E8
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Dec 2021 03:10:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rc6cU4gxcwuayvwXPNS3kqfoCRUkiDJ8y82YkbMXY9VX+J01RUSoIqrWV1YF7HEU55pIM41JSYtJrxjhsVEK5uD6xpa/AqrLpWToM2UdQ67JNpYkms0gcaQR8SqqviwGgrbGyOlR/9+IR82uvg0LSPZTZ9QqV10cRSChsfYPX44uIUreIx1nZJUFUWdA3ue+XKSQ87h6VBNKtK91weQb81R9sZSfG6x/Kui9QxR3nM4vi8ePLcp8cijgNKtu5ys4TIwCEA8KHl3tFgCWmGUBn2lwginsa2/T7UtLGqwtJAJVvGsZLngkVSyuH4oTNcRn8yjb9ftuQ+6HonMe7liADA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OKtCbjbHJ8rXVRkhZUTtAFVYh5BFFIh7Gm+LSRS/T/k=;
 b=ZpWeU+CG/p8pDjC4YMwcL0lZyBRBAzooonwpNYzTSclZMz/++20oKOzeeeTe8xrNiNk2rHedvyU/KU7ul2Xu0A4orX8/C72MiqpWHav1JHypWEwAZ88VVRVgnXH9OXwdRTpTy6QHbcMCI908rkpXJxhiozz+f5rpDqXLH2+Thfnv4+AysXAOp9r+D9+mS8/MyeDcIlL3NO+CbHjG3kfSbYqSUnRGhE8ngW6G7zt1/pN/lpNHZ72XheT2zWXLf9fdcbjn2NuvN3fOR/mACe2Fwp+4m6+OYwoWq73Vw7+vyKtxShGkyNP+dn2JXRwGuX5KaqUYAGP88h0a4vgIxODQ+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OKtCbjbHJ8rXVRkhZUTtAFVYh5BFFIh7Gm+LSRS/T/k=;
 b=kVIrZF1YmtipzDxuLaP7wgjLbAM0/ALKxMMXv3H5rYLhxDD7NewwKcRqMpu8ypq5jS29Js2kfnnzJCR1iTWbv77V7PUASRY7/xL3upfE6hFowdt8Hh4wHNLPcVlkZOR59NWRQOd64gMVyteiIogIijkabN2L5pAlsLTm5g46nxQ=
Received: from DM6PR18CA0033.namprd18.prod.outlook.com (2603:10b6:5:15b::46)
 by BN7PR12MB2707.namprd12.prod.outlook.com (2603:10b6:408:2f::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22; Thu, 2 Dec
 2021 03:10:08 +0000
Received: from DM6NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:15b:cafe::66) by DM6PR18CA0033.outlook.office365.com
 (2603:10b6:5:15b::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23 via Frontend
 Transport; Thu, 2 Dec 2021 03:10:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT028.mail.protection.outlook.com (10.13.173.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4755.13 via Frontend Transport; Thu, 2 Dec 2021 03:10:08 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 1 Dec
 2021 21:10:05 -0600
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V3 04/17] drm/amd/pm: do not expose those APIs used internally
 only in amdgpu_dpm.c
Date: Thu, 2 Dec 2021 11:09:17 +0800
Message-ID: <20211202030930.1681278-5-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20211202030930.1681278-1-evan.quan@amd.com>
References: <20211202030930.1681278-1-evan.quan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9263df53-7557-42e4-1f15-08d9b5413f33
X-MS-TrafficTypeDiagnostic: BN7PR12MB2707:
X-Microsoft-Antispam-PRVS: <BN7PR12MB2707E36028CAE2ACEEC963D6E4699@BN7PR12MB2707.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:418;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2qnZtLNJMj9TDSJh0E1KyQktoQnTxz9rBhUCU1mqaagbwuHPlWbya3VngCFrSRUbRfwcwNXwgfWWniyS4OMowwNOH14TX5LEsz7RKqM/bn+YZdQDymMy8T80K1t4B3ZexdWbQNbVtXuA0KA/0UEI/0Ser+tDNRVZzeq8uJ1eBHZbyOXfRMlhbOrQkaVBf0fgVR61odTHS9jhGW6BvHKyHnbZ7DhlIS0YUD3JqdndDq/uB8GGkzVsq2LOO5rCGiLrtrMiLKy5U5ospXcX9ZFUMSeFuuf3MqE/NXLmNMR13NQWfBmG+y2IJrlVhqcQXFdvnk7N5cm0QBJXeqChsX5uRnoCvlIqIFEhgM+1Ah7Mqnc1G4Q50d1xTaGeZlotJlxkwntBCqR2KOnEDUKGFNNr9qt/7QFNYbl/6o5XtYNPgenwOtezMYj/3+r9NbPufDTa3+TmBYn/FtMsIqj4QIXWY8vJx4namGPMZ79kuoIHjO5In526AqNrbiaHGyk/DCcK78TvNRIBbQ7LDcKkk+AaaNJrJBxcyHawa7MDif0iLIJxBn0LQsq156jRYMwizYq26FEHwaDNV9Olzvi+qE6xU1auer8Z9Ns5NH4qXymb2D6RbAqHvMpv5lU3AwhgzV/HRHjqKp/FFcHglVFszuZC+uDiJ3YCkjanYe6rZXplqG7inetvjelvQvM0Lac/9ZRguN1p/FaYpMx+uCrSebL/QoiYnmvTjH97in7UO86wyg2XXslYlXGyHJ3KHlzeugkymkxhFfEFm1Maam5Kdzunycx6NfbabL5ScenC9kZNmXk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(40470700001)(508600001)(7696005)(336012)(1076003)(54906003)(70586007)(40460700001)(81166007)(47076005)(8936002)(26005)(82310400004)(426003)(2906002)(70206006)(36756003)(16526019)(6916009)(356005)(6666004)(86362001)(36860700001)(186003)(44832011)(83380400001)(2616005)(8676002)(316002)(4326008)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2021 03:10:08.6671 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9263df53-7557-42e4-1f15-08d9b5413f33
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2707
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

Move them to amdgpu_dpm.c instead.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Change-Id: I59fe0efcb47c18ec7254f3624db7a2eb78d91b8c
---
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c     | 25 +++++++++++++++++++++++--
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h | 23 -----------------------
 2 files changed, 23 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
index 3a84c3995f2d..72a8cb70d36b 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -34,6 +34,27 @@
 
 #define WIDTH_4K 3840
 
+#define amdgpu_dpm_pre_set_power_state(adev) \
+		((adev)->powerplay.pp_funcs->pre_set_power_state((adev)->powerplay.pp_handle))
+
+#define amdgpu_dpm_post_set_power_state(adev) \
+		((adev)->powerplay.pp_funcs->post_set_power_state((adev)->powerplay.pp_handle))
+
+#define amdgpu_dpm_display_configuration_changed(adev) \
+		((adev)->powerplay.pp_funcs->display_configuration_changed((adev)->powerplay.pp_handle))
+
+#define amdgpu_dpm_print_power_state(adev, ps) \
+		((adev)->powerplay.pp_funcs->print_power_state((adev)->powerplay.pp_handle, (ps)))
+
+#define amdgpu_dpm_vblank_too_short(adev) \
+		((adev)->powerplay.pp_funcs->vblank_too_short((adev)->powerplay.pp_handle))
+
+#define amdgpu_dpm_enable_bapm(adev, e) \
+		((adev)->powerplay.pp_funcs->enable_bapm((adev)->powerplay.pp_handle, (e)))
+
+#define amdgpu_dpm_check_state_equal(adev, cps, rps, equal) \
+		((adev)->powerplay.pp_funcs->check_state_equal((adev)->powerplay.pp_handle, (cps), (rps), (equal)))
+
 void amdgpu_dpm_print_class_info(u32 class, u32 class2)
 {
 	const char *s;
@@ -120,7 +141,7 @@ void amdgpu_dpm_print_ps_status(struct amdgpu_device *adev,
 	pr_cont("\n");
 }
 
-void amdgpu_dpm_get_active_displays(struct amdgpu_device *adev)
+static void amdgpu_dpm_get_active_displays(struct amdgpu_device *adev)
 {
 	struct drm_device *ddev = adev_to_drm(adev);
 	struct drm_crtc *crtc;
@@ -168,7 +189,7 @@ u32 amdgpu_dpm_get_vblank_time(struct amdgpu_device *adev)
 	return vblank_time_us;
 }
 
-u32 amdgpu_dpm_get_vrefresh(struct amdgpu_device *adev)
+static u32 amdgpu_dpm_get_vrefresh(struct amdgpu_device *adev)
 {
 	struct drm_device *dev = adev_to_drm(adev);
 	struct drm_crtc *crtc;
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
index fea203a79cb4..6681b878e75f 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
@@ -259,27 +259,6 @@ enum amdgpu_pcie_gen {
 	AMDGPU_PCIE_GEN_INVALID = 0xffff
 };
 
-#define amdgpu_dpm_pre_set_power_state(adev) \
-		((adev)->powerplay.pp_funcs->pre_set_power_state((adev)->powerplay.pp_handle))
-
-#define amdgpu_dpm_post_set_power_state(adev) \
-		((adev)->powerplay.pp_funcs->post_set_power_state((adev)->powerplay.pp_handle))
-
-#define amdgpu_dpm_display_configuration_changed(adev) \
-		((adev)->powerplay.pp_funcs->display_configuration_changed((adev)->powerplay.pp_handle))
-
-#define amdgpu_dpm_print_power_state(adev, ps) \
-		((adev)->powerplay.pp_funcs->print_power_state((adev)->powerplay.pp_handle, (ps)))
-
-#define amdgpu_dpm_vblank_too_short(adev) \
-		((adev)->powerplay.pp_funcs->vblank_too_short((adev)->powerplay.pp_handle))
-
-#define amdgpu_dpm_enable_bapm(adev, e) \
-		((adev)->powerplay.pp_funcs->enable_bapm((adev)->powerplay.pp_handle, (e)))
-
-#define amdgpu_dpm_check_state_equal(adev, cps, rps, equal) \
-		((adev)->powerplay.pp_funcs->check_state_equal((adev)->powerplay.pp_handle, (cps), (rps), (equal)))
-
 #define amdgpu_dpm_reset_power_profile_state(adev, request) \
 		((adev)->powerplay.pp_funcs->reset_power_profile_state(\
 			(adev)->powerplay.pp_handle, request))
@@ -412,8 +391,6 @@ void amdgpu_dpm_print_cap_info(u32 caps);
 void amdgpu_dpm_print_ps_status(struct amdgpu_device *adev,
 				struct amdgpu_ps *rps);
 u32 amdgpu_dpm_get_vblank_time(struct amdgpu_device *adev);
-u32 amdgpu_dpm_get_vrefresh(struct amdgpu_device *adev);
-void amdgpu_dpm_get_active_displays(struct amdgpu_device *adev);
 int amdgpu_dpm_read_sensor(struct amdgpu_device *adev, enum amd_pp_sensors sensor,
 			   void *data, uint32_t *size);
 
-- 
2.29.0

