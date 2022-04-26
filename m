Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83389C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Apr 2022 18:26:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E64E10E7B0;
	Tue, 26 Apr 2022 18:26:11 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2053.outbound.protection.outlook.com [40.107.223.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B894A10EEA6
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Apr 2022 18:26:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DCTWb83q8ZRopSEyt42czq5JGf61ToiL6M0r/9sZe4QI3GDx320r4efjqbjEGixm3v/XDuoLU7XrPPgJdnCPIqNYIrSQazEHzKOW8g7SNQwJt75m7j3g46ldoJHIUqfMuzM3MHrwJw2SQz7Dc8qpRlVkMLpYU7w3rXTEGr0EFIBRlCBaEbEdK6W82a06E/ksgkQmMZvbwDCDltVwVNaMB0y7n3uO9bJXnQsyhmEML/zXBCNHguo1dBAGZB50lGMnJptNmc12pH2atK1pXq3C2tpDTmI3oxCU+pyZEsIbPLiZ+Z0fbFHcLSN2XWtuoDirODtvsUcH3+Vg+N6ymX3IOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ug2F6MkfrQbCR+5SC5VWSMbQvl0BJeRHXXdw5rIl/TA=;
 b=lNljVhYazp/eFm08JGpISmPvioKkd0cD/nzeQ6nn9FW1uiiNORO5y+cNv+e543XHKHgh2+QwlSOaZKezVKXxhwHTnnVfE2CmjUlNeWVLE9xUp5VC+aUwVdFy6mUsqMH0PWrjs6ALE12SshSg82nzAld/grtlRn7Bx2L8gs3zZhq+tNTX4bzROMS6o/jt7eEbLadk1svCRkx7Xo2hZBTmi53Q/4AKFujIfrbqtuk2uKBEHuXWchabTDLvU3AW1sdOH0EbzVL6fV6UwysUdG5TPN0Jk15o2fkeQu32rdlGJ1JN1SxyvA+dQUG5s9ZdR3djCMdivmZEfMMNPrUqsvFSlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ug2F6MkfrQbCR+5SC5VWSMbQvl0BJeRHXXdw5rIl/TA=;
 b=CcGfOlvm9wSUkHFiWE+ziutzb5yqw/EvU6AMjVdPf2j67pFljITG/LTBnc09cHmiUOMM/Peyrp7e8quV91Po33+Arj7jOz4HMU6gLoq+1YlZky0PcpLiLci+l4czuN+4eYMC0NLxVkKJIjlAajKvUMbx7DTgl1bsOeZXQqbTR9g=
Received: from BN0PR08CA0021.namprd08.prod.outlook.com (2603:10b6:408:142::16)
 by BL1PR12MB5850.namprd12.prod.outlook.com (2603:10b6:208:395::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Tue, 26 Apr
 2022 18:26:07 +0000
Received: from BN8NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:142:cafe::42) by BN0PR08CA0021.outlook.office365.com
 (2603:10b6:408:142::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14 via Frontend
 Transport; Tue, 26 Apr 2022 18:26:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT017.mail.protection.outlook.com (10.13.177.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5186.14 via Frontend Transport; Tue, 26 Apr 2022 18:26:07 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 26 Apr
 2022 13:25:59 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: add function to decode ip version
Date: Tue, 26 Apr 2022 14:25:45 -0400
Message-ID: <20220426182545.3006431-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220426182545.3006431-1-alexander.deucher@amd.com>
References: <20220426182545.3006431-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 170c73c9-ad22-4a84-0608-08da27b23af3
X-MS-TrafficTypeDiagnostic: BL1PR12MB5850:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB585070315B217DB31B514642F7FB9@BL1PR12MB5850.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Dmvm41zuKvQ+Inm/fbcggz3848J1fnH/y3C8xV9v3oK6+0X+P41LSWHHdyqk2kEywvjpyyWb+9h++7yYXvwS608gnbYwRKfa1rjKvnaHYTxPSqQYlGtLDqWJSQgmyjPhvjn0QeJlEjksw1SCD7cGTnobiCPTPN3BHQQDQ7+8nl62GeggZZssEytbWhJpNMizBOM7m2w9pY8zq3INirtCCsFqTv9efyBZqzPjsqOYs9MEjM+XY3v+aG8Q3aHSB6NTpWPvzVmJ2RiC8UeqNVajlnqtk90Oxb1KXlXyJoJVdeNwOwNbNpsRTKcmRRl3rSLTFK6ydhIq0T6ToAIWcH+KkKNS50SfLFmmteyNezolHcrkGSUGLgfEnsrQJk2kc4UhAMMlpSSVnPTrYFgxlBwUijS+kzaOebE8Jt2lO6r5aOd8mcwF2LPlpkFTe+F+rC1iYeZjbjPooN3Iu75Ud6QzYb1ewVbIhEYWlZGOn5zUchU1dMJz9LmuAV9w289TIT8GcWeO8SHXA96yYistVMBdLAyCaHr6+ZwjDBDjGzGhX2Zoxv4sYb7upasp7GKu0yf1CkfH3XEJnB09IIzjrCPDq5CXp2CepRKlX8oYCzmekqumLTOgoTn0jTvvznW+5eR9ZvT1X28AzI/eFSd5SqkGPudIXjwikdMmfu2rVSIR3ZnmwHrzINjirPyk80djJabh9//vkzp5NL+LlfhGmAQqWQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(316002)(86362001)(508600001)(47076005)(2616005)(8676002)(6916009)(54906003)(70206006)(81166007)(70586007)(6666004)(356005)(82310400005)(40460700003)(26005)(4326008)(36860700001)(336012)(426003)(8936002)(5660300002)(7696005)(36756003)(83380400001)(1076003)(2906002)(16526019)(186003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2022 18:26:07.2232 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 170c73c9-ad22-4a84-0608-08da27b23af3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5850
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Likun Gao <Likun.Gao@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Likun Gao <Likun.Gao@amd.com>

Add function to decode IP version.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h       |  3 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c | 33 +++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h |  2 ++
 3 files changed, 38 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 62e295fadc6c..aa5b944956d8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -670,6 +670,9 @@ enum amd_hw_ip_block_type {
 
 #define HW_ID_MAX		300
 #define IP_VERSION(mj, mn, rv) (((mj) << 16) | ((mn) << 8) | (rv))
+#define IP_VERSION_MAJ(ver) ((ver) >> 16)
+#define IP_VERSION_MIN(ver) (((ver) >> 8) & 0xFF)
+#define IP_VERSION_REV(ver) ((ver) & 0xFF)
 
 struct amd_powerplay {
 	void *pp_handle;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
index ca3350502618..016477fa2f90 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
@@ -760,3 +760,36 @@ int amdgpu_ucode_init_bo(struct amdgpu_device *adev)
 	}
 	return 0;
 }
+
+void amdgpu_ucode_ip_version_decode(struct amdgpu_device *adev, int block_type, char *ucode_prefix, int len)
+{
+	int maj, min, rev;
+	char *ip_name;
+	uint32_t version = adev->ip_versions[block_type][0];
+
+	switch (block_type) {
+	case GC_HWIP:
+		ip_name = "gc";
+		break;
+	case SDMA0_HWIP:
+		ip_name = "sdma";
+		break;
+	case MP0_HWIP:
+		ip_name = "psp";
+		break;
+	case MP1_HWIP:
+		ip_name = "smu";
+		break;
+	case UVD_HWIP:
+		ip_name = "vcn";
+		break;
+	default:
+		BUG();
+	}
+
+	maj = IP_VERSION_MAJ(version);
+	min = IP_VERSION_MIN(version);
+	rev = IP_VERSION_REV(version);
+
+	snprintf(ucode_prefix, len, "%s_%d_%d_%d", ip_name, maj, min, rev);
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
index 40dffbac85a0..864984d0d3ef 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
@@ -463,4 +463,6 @@ amdgpu_ucode_get_load_type(struct amdgpu_device *adev, int load_type);
 
 const char *amdgpu_ucode_name(enum AMDGPU_UCODE_ID ucode_id);
 
+void amdgpu_ucode_ip_version_decode(struct amdgpu_device *adev, int block_type, char *ucode_prefix, int len);
+
 #endif
-- 
2.35.1

