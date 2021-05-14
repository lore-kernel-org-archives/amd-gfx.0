Return-Path: <SRS0=oeKV=KJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CF17C43460
	for <amd-gfx@archiver.kernel.org>; Fri, 14 May 2021 07:42:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F5C761406
	for <amd-gfx@archiver.kernel.org>; Fri, 14 May 2021 07:42:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F5C761406
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C9D8D6EE36;
	Fri, 14 May 2021 07:42:46 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2074.outbound.protection.outlook.com [40.107.236.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F5AE6EE36
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 May 2021 07:42:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nbmPad1EwTr2LLNo3rF81Dj4fwRXf3y8GUbQAcWGtsa8H5/IrJXjkmDZZJSt40y4BcEoeRdrxxslgL2glZJWSd6OrrBLDa8uDO9S6bFKh9aBClXl8y6LHxBUs5voX7GYp2lPlBzdybJ58lTS0z0r95NYU1eEZUhsRXtmJ2atmprcli8ml4mSywWrldepScMMRDZKAxlw8pQSLV2xsd9ccO7x5NgZap9V070bYyczEQSKytTPdnyjaPZdnEcCXBXY9RebM0QyR3XKAs6sQw2F7ygwAal99mcQyNcfD/GkRMsivRnAhs8h1GWkoT6JqHXOcqqmrEfgqhutu8zoK/1O6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vMVKwF9+WMTMjDUjGQC7Oacg9UaoFcQ/9eron9B9OJk=;
 b=RWjFp5f3Flajg+iP593+Kku44r+bReQUuFNxbrsLnczGbdeB2Cxk1U4HbwrATS7tEnCqyTbUf7ISdu1ugwCz/SKMTz+xAAVyLjycRWKXoK0gqcljXA/+e7sOkezUo2tTwQrxbdX/dyfSylfn36BvDofiwYrDm2oAJVARTdW5866BwEWMQK4mIy/Jl5emL7luAju89laivY/caoRUubJqOrvAuJsby1hu+qxapFVx/WP8w1BInZZPZ8CqEpBN2kWEImj+hbwe55GdDq2N2xwIfXjwhnXtsy81VHO/CspTp0RBYuyP7a/E7LpdFtXk15+lRTu4PNAjk9wawKFERdB11A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vMVKwF9+WMTMjDUjGQC7Oacg9UaoFcQ/9eron9B9OJk=;
 b=pC5d08Nj5W0o8mZRqdGH1hG1c8flIfHOKhHSFTmmulLduBc2CbDoI0KA0S9rYSpUVNUKURdu89QLsO5uWgv3jd44aBQcGp6qcZXP1PBTYV0YdHFBeNLTBiUVaiYwR2jJmO9id9qtiZq20mgyGaehrblqT5uMLQVoi1/lLq8tvk8=
Received: from CO2PR05CA0095.namprd05.prod.outlook.com (2603:10b6:104:1::21)
 by BN6PR12MB1169.namprd12.prod.outlook.com (2603:10b6:404:19::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Fri, 14 May
 2021 07:42:39 +0000
Received: from CO1NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:1:cafe::95) by CO2PR05CA0095.outlook.office365.com
 (2603:10b6:104:1::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.11 via Frontend
 Transport; Fri, 14 May 2021 07:42:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT005.mail.protection.outlook.com (10.13.174.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4129.25 via Frontend Transport; Fri, 14 May 2021 07:42:38 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 14 May
 2021 02:42:37 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 14 May
 2021 02:42:37 -0500
Received: from hawzhang-System-Product.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.4
 via Frontend Transport; Fri, 14 May 2021 02:42:36 -0500
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Alex Deucher <alexander.deucher@amd.com>, 
 John Clements <John.Clements@amd.com>
Subject: [PATCH 1/6] drm/amdgpu: add atomfirmware helper function to query fw
 cap
Date: Fri, 14 May 2021 15:42:28 +0800
Message-ID: <1620978153-4564-1-git-send-email-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 567c81a0-363e-4a33-348a-08d916abd918
X-MS-TrafficTypeDiagnostic: BN6PR12MB1169:
X-Microsoft-Antispam-PRVS: <BN6PR12MB11692B46827AA652D6A2CD50FC509@BN6PR12MB1169.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E5CRxymtGrxHlJksNUwTLmFmLNK0NxhlUdHUVjrIY2Ka31kajYybVP2q8wyVDTO2Hedohj/lMmV0VUQka8leDuVlDL6lyIRr5pg7dMuFP1uPV2fXeGr9SjGvs8YFh2prTb2B59e7sSjN+Z244kXdE8j1nLPRYuK9mQ5ApkthE0YtnTzHdhtfjx7VnFcLU/w0QIRO3A/QI3an3IBopOlHOmmLmf7UOKQUQuFEXcp+yjDjQybesMUjnj1dY4hao4LHe2Nzq7y72t7tT0UErzmgHQPb0W65SRFLoarnSf6RoxlwHUJOEuEa7mwyJ+J1KPr/B1AYps1/N7EhaZ0XZjz/pMNA6/Hmf9kk7/kPFnTupF/hvVZ9hUzhhSHF/RsxCNpMHZMomluqjx5bZtXNpw5ZoAOdcXaExW9C9AW2fewP/irKcRr4CRo3SZjm9T0UIx82CvWAfQgr2dLirndnc05MUWuhJG70jceUNvIvCo3l8I0l1GEdBwVUx9d3sBcwocJprp3BBS1BIZ2eVm/xFmBSlHnxq4+Lysy6kjKn+R1qc/POktVKPJF9NmbrofBu1B3J7acYqM078myLDdpTOriqUusZvayXttgehM4Z2j7/t1goEDRIPLPlK6/xHvJxBUixlQ7xxlgGb39ox8WwhXdXGz0KFjDx/41wV2DpyjtFnBM1i+I3FO2aOjPg6CQirhCy
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(396003)(39860400002)(346002)(376002)(46966006)(36840700001)(82740400003)(8936002)(26005)(478600001)(7696005)(36860700001)(2616005)(5660300002)(186003)(4326008)(316002)(47076005)(6666004)(110136005)(336012)(81166007)(83380400001)(356005)(6636002)(82310400003)(2906002)(70586007)(70206006)(36756003)(8676002)(426003)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2021 07:42:38.5517 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 567c81a0-363e-4a33-348a-08d916abd918
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1169
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fimware capability was changed from 16 bits to 32 bits
for atomfirmware. add helper funciton to query firmware
capability and cache the value at early stage.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c     |  3 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c | 50 ++++++++++++++++++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.h |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h         |  2 +-
 4 files changed, 44 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
index 494b2e1..18bd1b49 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
@@ -1828,6 +1828,9 @@ int amdgpu_atombios_init(struct amdgpu_device *adev)
 	if (adev->is_atom_fw) {
 		amdgpu_atomfirmware_scratch_regs_init(adev);
 		amdgpu_atomfirmware_allocate_fb_scratch(adev);
+		/* cached firmware_flags for further usage */
+		adev->mode_info.firmware_flags =
+			amdgpu_atomfirmware_query_firmware_capability(adev);
 	} else {
 		amdgpu_atombios_scratch_regs_init(adev);
 		amdgpu_atombios_allocate_fb_scratch(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
index 60716b3..c6eb07f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
@@ -29,6 +29,45 @@
 #include "atombios.h"
 #include "soc15_hw_ip.h"
 
+union firmware_info {
+	struct atom_firmware_info_v3_1 v31;
+	struct atom_firmware_info_v3_2 v32;
+	struct atom_firmware_info_v3_3 v33;
+	struct atom_firmware_info_v3_4 v34;
+};
+
+/*
+ * Helper function to query firmware capability
+ *
+ * @adev: amdgpu_device pointer
+ *
+ * Return firmware_capability in firmwareinfo table on success or 0 if not
+ */
+uint32_t amdgpu_atomfirmware_query_firmware_capability(struct amdgpu_device *adev)
+{
+	struct amdgpu_mode_info *mode_info = &adev->mode_info;
+	int index;
+	u16 data_offset, size;
+	union firmware_info *firmware_info;
+	u8 frev, crev;
+	u32 fw_cap = 0;
+
+	index = get_index_into_master_table(atom_master_list_of_data_tables_v2_1,
+			firmwareinfo);
+
+	if (amdgpu_atom_parse_data_header(adev->mode_info.atom_context,
+				index, &size, &frev, &crev, &data_offset)) {
+		/* support firmware_info 3.1 + */
+		if ((frev == 3 && crev >=1) || (frev > 3)) {
+			firmware_info = (union firmware_info *)
+				(mode_info->atom_context->bios + data_offset);
+			fw_cap = le32_to_cpu(firmware_info->v31.firmware_capability);
+		}
+	}
+
+	return fw_cap;
+}
+
 bool amdgpu_atomfirmware_gpu_supports_virtualization(struct amdgpu_device *adev)
 {
 	int index = get_index_into_master_table(atom_master_list_of_data_tables_v2_1,
@@ -400,13 +439,6 @@ bool amdgpu_atomfirmware_mem_ecc_supported(struct amdgpu_device *adev)
 	return ecc_default_enabled;
 }
 
-union firmware_info {
-	struct atom_firmware_info_v3_1 v31;
-	struct atom_firmware_info_v3_2 v32;
-	struct atom_firmware_info_v3_3 v33;
-	struct atom_firmware_info_v3_4 v34;
-};
-
 /*
  * Return true if vbios supports sram ecc or false if not
  */
@@ -466,10 +498,6 @@ int amdgpu_atomfirmware_get_clock_info(struct amdgpu_device *adev)
 		adev->pm.current_sclk = adev->clock.default_sclk;
 		adev->pm.current_mclk = adev->clock.default_mclk;
 
-		/* not technically a clock, but... */
-		adev->mode_info.firmware_flags =
-			le32_to_cpu(firmware_info->v31.firmware_capability);
-
 		ret = 0;
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.h
index 9f0d435..77c5fb1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.h
@@ -26,6 +26,7 @@
 
 #define get_index_into_master_table(master_table, table_name) (offsetof(struct master_table, table_name) / sizeof(uint16_t))
 
+uint32_t amdgpu_atomfirmware_query_firmware_capability(struct amdgpu_device *adev);
 bool amdgpu_atomfirmware_gpu_supports_virtualization(struct amdgpu_device *adev);
 void amdgpu_atomfirmware_scratch_regs_init(struct amdgpu_device *adev);
 int amdgpu_atomfirmware_allocate_fb_scratch(struct amdgpu_device *adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
index 9fd06cb..3a4c1d992 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
@@ -350,7 +350,7 @@ struct amdgpu_mode_info {
 	/* pointer to fbdev info structure */
 	struct amdgpu_fbdev *rfbdev;
 	/* firmware flags */
-	u16 firmware_flags;
+	u32 firmware_flags;
 	/* pointer to backlight encoder */
 	struct amdgpu_encoder *bl_encoder;
 	u8 bl_level; /* saved backlight level */
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
