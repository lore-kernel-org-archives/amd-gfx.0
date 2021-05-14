Return-Path: <SRS0=oeKV=KJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCD19C433B4
	for <amd-gfx@archiver.kernel.org>; Fri, 14 May 2021 07:42:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69F4C611CE
	for <amd-gfx@archiver.kernel.org>; Fri, 14 May 2021 07:42:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69F4C611CE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 10A7B6EE39;
	Fri, 14 May 2021 07:42:48 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2060.outbound.protection.outlook.com [40.107.93.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8DFFA6EE36
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 May 2021 07:42:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C6UlmM9V3HlBARO9p90dwL0Xu3Dfu001kSVW7W0WoKL4xxOT8Nx9Bm0QCMol/j9NGRzmTn3T0hIfMKghLz39ELZuNaETkp5BVa/1qaDvuutmLsOKSK2CYaCIjxWej5FwAphGIqUs6vuT/gUwzk+bA6TxvCV+skfFG5siONJSJX5m3q12e09qIpnmNVWp1AyviQ+INRjRNr1yGkIuHai8KgFqCQoinbqBZiTBVkKEwWAE8J5yj016/rlhxIvZPyBkHIDmd++G2KWtwT+/tJseY8LpnrYujtlZDNMnbS/74/4+dYTadVcl0m6OHsLx2Igedm05wkX1LkH5d1jTOp7sJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gq4YfqFBKJFgYr+Saly8NbqEyL8zY3RTom1lbmPBJ3E=;
 b=c5V7AESc7A8CeUFEvqYB97JbxoYxakiJzjyS4qYK4eWb8tF45OQK//5x4bmQJHHKPwDZAQbjKkzCspDS3oDSS1zR/3SD7eorVKee6MdYdsvkrthRCHN26S0uT23WTxhr4e7GzvsN4KXNGCqAHx040TlqTPG34fDmVjDhZTKL7APxaZHkhIpzKIaKosOs0Mw6roNMG9raQVqIoyCRqJTV8bkvcXziqFcO5vtcHnjoESVdq37U1G2AX0vDjYCSZujt9zs3jASI5RXv0VnwmOvC0XTxBSZ5Rw/U1dx1MCNz1VwiokZILSDt1NIa6YmYOFmHC9NMB4K8ybYF+re59V3FrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gq4YfqFBKJFgYr+Saly8NbqEyL8zY3RTom1lbmPBJ3E=;
 b=akaxF+VakZy++Pnu/qLbNsNlnQJyYPgXZba5Pr1+nX481A7JLxjymhrpX8esUBQ+9hk+lNXDxL0pQS6SaBMA7glfoatc3TnCIhu111DpwqShGnY5XSqAgi0DZlwOti+ts87ylmtNGcJt7zcvrF1jueB2qXJxsMoXHGKyTEPF6jA=
Received: from DM6PR02CA0071.namprd02.prod.outlook.com (2603:10b6:5:177::48)
 by DM6PR12MB4548.namprd12.prod.outlook.com (2603:10b6:5:2a1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Fri, 14 May
 2021 07:42:44 +0000
Received: from DM6NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:177:cafe::8d) by DM6PR02CA0071.outlook.office365.com
 (2603:10b6:5:177::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend
 Transport; Fri, 14 May 2021 07:42:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT029.mail.protection.outlook.com (10.13.173.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4129.25 via Frontend Transport; Fri, 14 May 2021 07:42:44 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 14 May
 2021 02:42:43 -0500
Received: from hawzhang-System-Product.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.4
 via Frontend Transport; Fri, 14 May 2021 02:42:42 -0500
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Alex Deucher <alexander.deucher@amd.com>, 
 John Clements <John.Clements@amd.com>
Subject: [PATCH 5/6] drm/amdgpu: add helper function to query dynamic boot
 config cap
Date: Fri, 14 May 2021 15:42:32 +0800
Message-ID: <1620978153-4564-5-git-send-email-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1620978153-4564-1-git-send-email-Hawking.Zhang@amd.com>
References: <1620978153-4564-1-git-send-email-Hawking.Zhang@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9d060322-227f-4eed-4019-08d916abdc9f
X-MS-TrafficTypeDiagnostic: DM6PR12MB4548:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4548A4D160943257ECACB7D3FC509@DM6PR12MB4548.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1051;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9Pw06QHb14LrhkVGaarfMHjaURJzGWnoURQsPcPe755n1lY9WZeVNCySFaz9ri/7p6BP7s0e5tE+XYCVYQCpch9acBUAFdSapTKJVSFmyvow0liMp+/j6N4b+q81DINCOziFZPRLTumDwogd9/V2Yo9gacKGm2hVavP18kPf833PaF4GgdBfCOrmh6OS241NxRAbNAXNBDhV+sQcKvnxwNApG6Cl1ddsHnl6H8pfrJ5GLXf9LQ5UhKzumz3KGtKU5dpbsvnfSTGW/ZxKQOkT0pitmhytNzD8crHJkGlKJAszjE4u+glV7u9G/YueF7+rOOHNXufhS2+YVcUV24GBuR5/DgFb3DZcweN5Hsm7uuf0qYf4/zqgTSM64rrZ2Gs1GagwVGzKCfv454vLGDbuAcGew4/GJMgaBnO/SYB2X/MhWvP/AROAyqDnMgBRQTlDXp76KenYK/uqtwXoQwzit9CfJYVobGNjbLWtratwDUG8nf39EftEDL60zlz7rIIiDVTGMmtqtWvAiwADiq451BErGrT6MAuP+cPkicwMS9Bu0OsMiZV5CGV2N/dd6DO4u3ZH/7ypPVjyr1T2tvDrue7HYj5apyaetp2/SwYhaPYM3ymsalJzY/WHc3d3ZqVK+jVqJpxFA1ozbOVd9e1yNYB8xh28jVJ7Z02HGHRlC6pmuU5IEVC2T1b/0TIR77kh
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(136003)(376002)(39860400002)(346002)(36840700001)(46966006)(86362001)(336012)(426003)(110136005)(2616005)(70206006)(36756003)(2906002)(186003)(316002)(47076005)(70586007)(4326008)(82310400003)(6666004)(356005)(81166007)(36860700001)(82740400003)(26005)(8936002)(478600001)(8676002)(7696005)(6636002)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2021 07:42:44.5369 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d060322-227f-4eed-4019-08d916abdc9f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4548
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

Check firmware flags to determine whether dynmaic
boot config is supported or not.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c | 16 ++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.h |  1 +
 drivers/gpu/drm/amd/include/atomfirmware.h       |  1 +
 3 files changed, 18 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
index cfd009a..8c41701 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
@@ -452,6 +452,22 @@ bool amdgpu_atomfirmware_sram_ecc_supported(struct amdgpu_device *adev)
 	return (fw_cap & ATOM_FIRMWARE_CAP_SRAM_ECC) ? true : false;
 }
 
+/*
+ * Helper function to query dynamic boot config capability
+ *
+ * @adev: amdgpu_device pointer
+ *
+ * Return true if vbios supports dynamic boot config or false if not
+ */
+bool amdgpu_atomfirmware_dynamic_boot_config_supported(struct amdgpu_device *adev)
+{
+	u32 fw_cap;
+
+	fw_cap = adev->mode_info.firmware_flags;
+
+	return (fw_cap & ATOM_FIRMWARE_CAP_DYNAMIC_BOOT_CFG_ENABLE) ? true : false;
+}
+
 union smu_info {
 	struct atom_smu_info_v3_1 v31;
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.h
index 8be95d8..1bbbb19 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.h
@@ -37,6 +37,7 @@ int amdgpu_atomfirmware_get_gfx_info(struct amdgpu_device *adev);
 bool amdgpu_atomfirmware_mem_ecc_supported(struct amdgpu_device *adev);
 bool amdgpu_atomfirmware_sram_ecc_supported(struct amdgpu_device *adev);
 bool amdgpu_atomfirmware_mem_training_supported(struct amdgpu_device *adev);
+bool amdgpu_atomfirmware_dynamic_boot_config_supported(struct amdgpu_device *adev);
 int amdgpu_atomfirmware_get_fw_reserved_fb_size(struct amdgpu_device *adev);
 
 #endif
diff --git a/drivers/gpu/drm/amd/include/atomfirmware.h b/drivers/gpu/drm/amd/include/atomfirmware.h
index 41d6018..14d0d7d5 100644
--- a/drivers/gpu/drm/amd/include/atomfirmware.h
+++ b/drivers/gpu/drm/amd/include/atomfirmware.h
@@ -505,6 +505,7 @@ enum atombios_firmware_capability
 	ATOM_FIRMWARE_CAP_SRAM_ECC      = 0x00000200,
 	ATOM_FIRMWARE_CAP_ENABLE_2STAGE_BIST_TRAINING  = 0x00000400,
 	ATOM_FIRMWARE_CAP_ENABLE_2ND_USB20PORT = 0x0008000,
+	ATOM_FIRMWARE_CAP_DYNAMIC_BOOT_CFG_ENABLE = 0x0020000,
 };
 
 enum atom_cooling_solution_id{
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
