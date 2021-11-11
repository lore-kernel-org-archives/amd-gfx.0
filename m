Return-Path: <SRS0=G5aM=P6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB513C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Nov 2021 07:57:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC4226115A
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Nov 2021 07:57:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org AC4226115A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 48DE36EA5A;
	Thu, 11 Nov 2021 07:57:52 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2085.outbound.protection.outlook.com [40.107.243.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1135B6EA5A
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Nov 2021 07:57:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ck/CyuoLvRJVn2jvKC7cRbl5B60Pl+URle8bwliUcnNC7jRIZ8mPTbhnAP+76usyREytFaMocvcAp84j4+KiSTI+u7MF/qA0bnoGYJbIQfiMD83AkyNOjBamyZa168A5Dv4L+yxZrx01e/XoIO4suWLs+7DaAiAYRHk278pg5PAa3N9HvZcc7mscSYy+qs/9leG3fX8IIwSTvCwLIykgJYOXMDSvRLnY4mwPOZrIqauNnONIrdGUVtRAnZ/WkSBCG7Bvfbx4TZ4/PGtbX5ZJfz44u14C3DRw32zFk/0rEtNvMe0CtA4+fyKIrwNVlFVlED2PQb6Hf2bXSF9u+8BuLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vakB3/QRXDPUdiUx8whL0gJKNZmbI1TI+6cDUTEgLh0=;
 b=M7gG8XnBBx/zDTmargZVTtiXIuvvNJ82tIrY3qDq7MR8tEpRWeEIX1pvanIRDpbRS83D94Ya5H4JU19lluw4MbLhqVedEL+uRW0gEilESuHoHXziB2nwzypWW9KL3KmKpApi2GqbhZnbC/ayTWjjOPzxhxN1jLKKrKi8tYOutxD8eJIm11xFromfh+Is0FBgXX4g2TlXPbfM+VbpLkQyxLFVvy1XpzDfvR9C1eC/YNRCywpcXignnRPCWhzN+CZoPciDsGJnHuTGcXb+B7woPGHv63gSH2OLuXOsNRw2tLFf4IoBziN6we8IvOOjSxKFX+eukJwx95TNtZTD6DEkYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vakB3/QRXDPUdiUx8whL0gJKNZmbI1TI+6cDUTEgLh0=;
 b=z2ZgLhOlIYVvRHGOXvnW1VRfSsOurJcktrnyY7CENxH4otZk+YvM8l8YE/9VJzafQZ8P3ELK6UMsCrTl3B3qn/lLbnFUCe1CM2sUzZqpU5AEJTXghzNG8ilBpY2L6zHC60WNROhXtQfahzJ3SPLzuR11i14wUM1dDimuZmiUg+M=
Received: from BN0PR08CA0010.namprd08.prod.outlook.com (2603:10b6:408:142::11)
 by CY4PR12MB1159.namprd12.prod.outlook.com (2603:10b6:903:36::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.13; Thu, 11 Nov
 2021 07:57:48 +0000
Received: from BN8NAM11FT062.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:142:cafe::39) by BN0PR08CA0010.outlook.office365.com
 (2603:10b6:408:142::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11 via Frontend
 Transport; Thu, 11 Nov 2021 07:57:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT062.mail.protection.outlook.com (10.13.177.34) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4690.15 via Frontend Transport; Thu, 11 Nov 2021 07:57:48 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 11 Nov
 2021 01:57:46 -0600
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: avoid duplicate powergate/ungate setting
Date: Thu, 11 Nov 2021 15:57:30 +0800
Message-ID: <20211111075730.184218-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 22bd6109-974c-4048-e6cb-08d9a4e8f40d
X-MS-TrafficTypeDiagnostic: CY4PR12MB1159:
X-Microsoft-Antispam-PRVS: <CY4PR12MB11592E92C3EC88A7B223F1DCE4949@CY4PR12MB1159.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:78;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KWLAPIS2VYGLNwOyTGVJJhYUUL9tR805cQk0VcYP+FcAU0UI3/pqwxvxTt9lAzO5oxuE4I8/Uy9QD8xBhsdY+xEu9Ng+nW73bBeCwkwr6HFEQHhJEgkrFu8sllznr59D1NzzZlbvH2zEA/SU4vu7L8vQfJg7WLVveJemkwCuutR1oOtbitjJfPq1M9ZlFFnBDlJxYrq+r+15vY7ISALg0PeBEIahLlmRI1DfU/v9fxPbwC4lI6GaS+XUbgL/Xu0Hsx1EBv6o+fUa2LoOWFyg3gxzLMHNq0B5SYHW0RLFS4ipVDOYsTtzF7DyQkvWFE+RFbQ9EB9ld9yNrh4dO2sjGyVkd7GjqE0mfJ4xuxYgeWVwGedhYByWdcJpSNnRSCgLthbip+NjFmO8xxBymZM1rhMDvmoq2/nhOFTa64KcK1IHs7/ADYJEWyNsAJSrovsBAaUuPEfiyPpITKrZ4RCNuek/DLtsqktAnIu7DtJhKMWAJMki28on4fprxi1F1kaonnXBCKEHRm8IWb0HM5qaXAYl1jNYACc1XntShC6DGlXoVwUW1wD0Nk6jwd3UUm6tSTihfPhCc+yr4e05f8bFxA2Hc1OmYlazazDsjFB7jMm5vOyithK3uXNFJeGNDBQZ94ygbHPOHYiY8fjJbLRRc6VqvEG2bAjGAn9TlRNO+8xFQlWiPniuzQy+OfGos//bK45NttDJpdJoDp1HQESN0zQonHU+pO1y98XFECuqi0BtKxvq7EnhnyrKCR3HEd8pEjQ9KE1OfS//AVfTJ2vDdF249Tz1AGGyLzR3TfB+hjV70zTXkGwCSIC0jbQmAgBG
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(7696005)(5660300002)(316002)(6916009)(508600001)(47076005)(336012)(54906003)(1076003)(44832011)(2616005)(86362001)(82310400003)(16526019)(426003)(2906002)(70206006)(36860700001)(6666004)(186003)(8936002)(70586007)(4326008)(83380400001)(8676002)(26005)(36756003)(966005)(356005)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2021 07:57:48.2356 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 22bd6109-974c-4048-e6cb-08d9a4e8f40d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT062.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1159
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
Cc: Alexander.Deucher@amd.com, Lijo.Lazar@amd.com, Borislav Petkov <bp@suse.de>,
 Evan Quan <evan.quan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Just bail out if the target IP block is already in the desired
powergate/ungate state. This can avoid some duplicate settings
which sometimes may cause unexpected issues.

Link: https://lore.kernel.org/all/YV81vidWQLWvATMM@zn.tnic/

Change-Id: I66346c69f121df0f5ee20182451313ae4fda2d04
Signed-off-by: Evan Quan <evan.quan@amd.com>
Tested-by: Borislav Petkov <bp@suse.de>
--
v1->v2:
  - typo fix and add link for the issue referred in commit
    message(Paul/Boris)
  - update the data type to uint32_t(Paul)
  - better Macro naming(Lijo)
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  3 +++
 drivers/gpu/drm/amd/include/amd_shared.h   |  3 ++-
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c        | 12 +++++++++++-
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h    |  8 ++++++++
 4 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 0bd90ec9e43e..fca592394fa1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3508,6 +3508,9 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 		adev->rmmio_size = pci_resource_len(adev->pdev, 2);
 	}
 
+	for (i = 0; i < AMD_IP_BLOCK_TYPE_NUM; i++)
+		atomic_set(&adev->pm.pwr_state[i], POWER_STATE_UNKNOWN);
+
 	adev->rmmio = ioremap(adev->rmmio_base, adev->rmmio_size);
 	if (adev->rmmio == NULL) {
 		return -ENOMEM;
diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd/include/amd_shared.h
index f1a46d16f7ea..4b9e68a79f06 100644
--- a/drivers/gpu/drm/amd/include/amd_shared.h
+++ b/drivers/gpu/drm/amd/include/amd_shared.h
@@ -98,7 +98,8 @@ enum amd_ip_block_type {
 	AMD_IP_BLOCK_TYPE_ACP,
 	AMD_IP_BLOCK_TYPE_VCN,
 	AMD_IP_BLOCK_TYPE_MES,
-	AMD_IP_BLOCK_TYPE_JPEG
+	AMD_IP_BLOCK_TYPE_JPEG,
+	AMD_IP_BLOCK_TYPE_NUM,
 };
 
 enum amd_clockgating_state {
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
index 03581d5b1836..40fda199a86f 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -927,6 +927,13 @@ int amdgpu_dpm_set_powergating_by_smu(struct amdgpu_device *adev, uint32_t block
 {
 	int ret = 0;
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
+	enum ip_power_state pwr_state = gate ? POWER_STATE_OFF : POWER_STATE_ON;
+
+	if (atomic_read(&adev->pm.pwr_state[block_type]) == pwr_state) {
+		dev_dbg(adev->dev, "IP block%d already in the target %s state!",
+				block_type, gate ? "gate" : "ungate");
+		return 0;
+	}
 
 	switch (block_type) {
 	case AMD_IP_BLOCK_TYPE_UVD:
@@ -976,9 +983,12 @@ int amdgpu_dpm_set_powergating_by_smu(struct amdgpu_device *adev, uint32_t block
 		}
 		break;
 	default:
-		break;
+		return -EINVAL;
 	}
 
+	if (!ret)
+		atomic_set(&adev->pm.pwr_state[block_type], pwr_state);
+
 	return ret;
 }
 
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
index 98f1b3d8c1d5..16e3f72d31b9 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
@@ -417,6 +417,12 @@ struct amdgpu_dpm {
 	enum amd_dpm_forced_level forced_level;
 };
 
+enum ip_power_state {
+	POWER_STATE_UNKNOWN,
+	POWER_STATE_ON,
+	POWER_STATE_OFF,
+};
+
 struct amdgpu_pm {
 	struct mutex		mutex;
 	u32                     current_sclk;
@@ -452,6 +458,8 @@ struct amdgpu_pm {
 	struct i2c_adapter smu_i2c;
 	struct mutex		smu_i2c_mutex;
 	struct list_head	pm_attr_list;
+
+	atomic_t		pwr_state[AMD_IP_BLOCK_TYPE_NUM];
 };
 
 #define R600_SSTU_DFLT                               0
-- 
2.29.0

