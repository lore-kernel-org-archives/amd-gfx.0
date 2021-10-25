Return-Path: <SRS0=aCMl=PN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 768F0C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Oct 2021 17:56:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 445C160EB1
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Oct 2021 17:56:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 445C160EB1
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CCA5C6E1B3;
	Mon, 25 Oct 2021 17:56:29 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2060.outbound.protection.outlook.com [40.107.92.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF9D36E1B3
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Oct 2021 17:56:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VProDPcMiZ8VoBcFSYmxTG9vEhBvCs1WYnUx4nYXfWknW4mxYDcglkwTFuJTnzoKO/oUNDCSyVFTPCk3lvRQZM4n8/CiyptSmwsjExEwhYE5E0LRygU82iuQbGARzv6+zTzpisIFvVyfV2p32qxa1Ko0Ig18Il6bsCPVqDeFAkaIkjHEbvepKzv96rxLDfPzaeSqlnekEf59YMrYCObpcLUyAuolda7kS0tfEzzyrqxgOCa+XmPnfBaxHc7Xlc9FIy87fFZvzepA650YnbEUb+SCSYDGKkl2BETE1Zm+jdyjRBR0EXfgsBFFWBzMLmTWwiA9hcEZfs1hm5WibLK1Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jl2dFbQWo/ttWdJgJoJrxs8oCiSlTEZSfPJud/+u9sg=;
 b=RKHKvcMs03PzU02zcF8ShCJhhRCKb/TXhCYPoY+pMQVg/KyPMCRDkJYhaihFPhTi5xmwCk6hZIoxwAyM+lZdrp5BGXUN3rF0037WMHOKrJXYRPPYTHoo4R846j2Ak+4yCCrwmin/3hLBsse13opcCQdbL3zZfA2j3D1qenVFMDdrwKCBWjkW7g+Qk95F9EOAflB8F9TULY0iMcZsN8K/iBv9ugfOyFmnFjgh8jr5bplsKHVA+SBa42W952bv/d0aAJkcmq0e24rPKI050vo3lREksyXxCMIVgmxSvtMoKLBdDqowyRiRYgRF0bMh9y9XhmT5MVcxOErUfZzZWEWrUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jl2dFbQWo/ttWdJgJoJrxs8oCiSlTEZSfPJud/+u9sg=;
 b=USrdZLMcI7siCIz4gxO7A9MBqsQRcFURyNQM5+7jiKWw8+/T17sVW3xQDKuJkuJ/BdmkhL5cPTaQRgecdRq+tz9bIOBJ2cjPwMF1RKO4FzSXiK9sLK3jNpYTDJkvUZgODSSYI6VzrdX2a/c17Jym32dBdjlfbeKXzapWqcBnxus=
Received: from MWHPR13CA0013.namprd13.prod.outlook.com (2603:10b6:300:16::23)
 by DM5PR12MB1931.namprd12.prod.outlook.com (2603:10b6:3:109::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16; Mon, 25 Oct
 2021 17:56:26 +0000
Received: from CO1NAM11FT007.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:16:cafe::42) by MWHPR13CA0013.outlook.office365.com
 (2603:10b6:300:16::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.8 via Frontend
 Transport; Mon, 25 Oct 2021 17:56:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT007.mail.protection.outlook.com (10.13.174.131) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4628.16 via Frontend Transport; Mon, 25 Oct 2021 17:56:26 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Mon, 25 Oct
 2021 12:56:18 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Mon, 25 Oct
 2021 12:56:18 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2308.15 via Frontend
 Transport; Mon, 25 Oct 2021 12:56:16 -0500
From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Aurabindo.Pillai@amd.com>, Jude Shih <shenshih@amd.com>, "Nicholas
 Kazlauskas" <nicholas.kazlauskas@amd.com>
Subject: [PATCH 5/5] drm/amd/display: Enable dpia in dmub only for DCN31 B0
Date: Mon, 25 Oct 2021 13:55:57 -0400
Message-ID: <20211025175557.148601-6-nicholas.kazlauskas@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211025175557.148601-1-nicholas.kazlauskas@amd.com>
References: <20211025175557.148601-1-nicholas.kazlauskas@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: faa0853f-673e-46d9-b520-08d997e0c3bd
X-MS-TrafficTypeDiagnostic: DM5PR12MB1931:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1931A1802075598C761B8D16EC839@DM5PR12MB1931.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 45u2Yy00+uwJUjd5E4rPpb1QHWqK55wqBt7d8wibxeKp1/Ofg3N9VqEcRjrZaAwZ8Td+XMb5jAGvuCu9/MDHHUpWNnisJ/j76umd2ZyfzWBMIXQSXUzM/E3yKxiE1tvQqAu8D2P1OTUpZPjHsVB45FDMa9e/IGQUDyHtihKxaIRkYKxFvQpJxReZlXOtlIURmn0A+AN7b/Q6+W90WZHTVVgvTDjPhNof4/Vme6dqzvNUR4UknFk2jJwELCCIAMPwinAwOpvIXkG8AbgoS/6kvfwFThFm29tFqGL6fZ18FxbuA/WvOCvJAWW/bZ9BG4R3bWyUFSBnKuJFgSDSfKVphTYt6u+i+SpEmAax8hotKHYTa5xN6h575FSwwBN9wedqLXkcxiX7jyU/FCep5YPJIERRaM36iivRpP0WciB2F3M+q7d+XvoVgmhIyHWMYg3jkwYmsBG/5tsG8xz91BJW3MwBD7iMCg9VOXbyOTg1Hv0IPCXYBNT0Vhf63BkdqEuTmif0ys/bfrifDKeOi9VmnDJ4LJZs8QVSD6yLmxdoR6GwumUgYCkxDg6vSC7CrMHSxNstopuh/QxKCIHdOtJLr3nljRta/Ej1DKQppz+4zQGLG7TKXMnD24Fk5BP6g08umRd4ws/cyu5LPky7Ye9L95brl13ogbHfHUrDlEbhJY3WVy1gmLP/wK21RNfYH+T3ntaONC1wilHOsQigf0Lfk4MAlj10xfd0NKlM0ba/iac=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(8936002)(336012)(26005)(5660300002)(2906002)(8676002)(86362001)(186003)(426003)(316002)(81166007)(82310400003)(2616005)(1076003)(44832011)(47076005)(6916009)(6666004)(70586007)(70206006)(36756003)(4326008)(508600001)(36860700001)(356005)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2021 17:56:26.0544 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: faa0853f-673e-46d9-b520-08d997e0c3bd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT007.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1931
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

From: Jude Shih <shenshih@amd.com>

[Why]
DMUB binary is common for both A0 and B0. Hence, driver should
notify FW about the support for DPIA in B0.

[How]
Added dpia_supported bit in dmub_fw_boot_options and will be set
only for B0.

Assign dpia_supported to true before dm_dmub_hw_init
in B0 case.

Signed-off-by: Jude Shih <shenshih@amd.com>
Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 12 ++++++++++++
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h       |  1 +
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c |  1 +
 3 files changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 0ad6d0e2a2d8..139a7707f317 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1017,6 +1017,7 @@ static int dm_dmub_hw_init(struct amdgpu_device *adev)
 	const unsigned char *fw_inst_const, *fw_bss_data;
 	uint32_t i, fw_inst_const_size, fw_bss_data_size;
 	bool has_hw_support;
+	struct dc *dc = adev->dm.dc;
 
 	if (!dmub_srv)
 		/* DMUB isn't supported on the ASIC. */
@@ -1103,6 +1104,17 @@ static int dm_dmub_hw_init(struct amdgpu_device *adev)
 	for (i = 0; i < fb_info->num_fb; ++i)
 		hw_params.fb[i] = &fb_info->fb[i];
 
+	switch (adev->asic_type) {
+	case CHIP_YELLOW_CARP:
+		if (dc->ctx->asic_id.hw_internal_rev != YELLOW_CARP_A0) {
+			hw_params.dpia_supported = true;
+			hw_params.disable_dpia = dc->debug.dpia_debug.bits.disable_dpia;
+		}
+		break;
+	default:
+		break;
+	}
+
 	status = dmub_srv_hw_init(dmub_srv, &hw_params);
 	if (status != DMUB_STATUS_OK) {
 		DRM_ERROR("Error initializing DMUB HW: %d\n", status);
diff --git a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
index 6c4f0ada163f..717c0e572d2f 100644
--- a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
+++ b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
@@ -238,6 +238,7 @@ struct dmub_srv_hw_params {
 	bool load_inst_const;
 	bool skip_panel_power_sequence;
 	bool disable_z10;
+	bool dpia_supported;
 	bool disable_dpia;
 };
 
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c
index 5df990277dd4..10ebf20eaa41 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c
@@ -338,6 +338,7 @@ void dmub_dcn31_enable_dmub_boot_options(struct dmub_srv *dmub, const struct dmu
 	union dmub_fw_boot_options boot_options = {0};
 
 	boot_options.bits.z10_disable = params->disable_z10;
+	boot_options.bits.dpia_supported = params->dpia_supported;
 	boot_options.bits.enable_dpia = params->disable_dpia ? 0 : 1;
 
 	boot_options.bits.sel_mux_phy_c_d_phy_f_g = (dmub->asic == DMUB_ASIC_DCN31B) ? 1 : 0;
-- 
2.25.1

