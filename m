Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E51FE82CBB
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Sep 2023 18:02:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB45410E07E;
	Wed, 27 Sep 2023 18:02:14 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2063.outbound.protection.outlook.com [40.107.102.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 735B310E07E
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Sep 2023 18:02:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F05cHQ4rBTTna9LdO5bs2MxnAAc2kwXL2Z93K55Taub6IoaWujFvmvumVAMAD9QWCr+0tNJeJD5qpvXOC8zZNAQo9DfXxZgaMflYkGAfZTVvw98dnSJhY2r18VSa02LB2YG4pm6CTvjssg+Vua+b3VifiTTqw5GYI6X+bjOEfscRaIOxeQzxPvjdoOElGN2++WpWT+tJFapd61q7pQv6hQl3wn3SGYIGdM4MetSANnxUlR4KdXtWf+tELygA0EHf650Ua9aWhjdRxA6gErqR1N4cUyFZXJUE3YN9+WEeFfoJeIk1JD73go9GZmeOW+UhVjqaVJRHDzrQEMCGrgLEXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pU4ir8HiBlV68tKjfFLzhWGm6CBE3pNkQBuRYogfquw=;
 b=YnMEfB90bipMOaBT8470qp2nhYmka+r05s7Lq11yk1lVBbL/a16GhD9R7I1QBOjKt+8TOrAE8wrA+4OpS7GX46cST5vrSQBWmulQwYBw8Zlet1LoicyPcnmlRsK2/elBhwa2qo5WMmX8XexPopGfdlGnUPfcaL5Np34kJiJDjtuKC7arcSdQFOUwkHqNmi4qYFH3V/r7+FTVwMFAoh0l6RoJDzONAWEmxsqebsqv2REqg9R97k0Q1tbtK5Dl1LwNg7TXcdk7nfEYHcVdgml0oSZUHtingclplqk/gh3O0XdcWP5pnnQItTIxoZrU5OyEVfv+2C7FMI9MAac3KOFxmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pU4ir8HiBlV68tKjfFLzhWGm6CBE3pNkQBuRYogfquw=;
 b=m13UxpkANunTg6xUP6WTi3/iCo/eFFeaqwbGi9sRCOfqolXaVi7djbgupmU61OuAZpFMj0yjuUvhJp+9uJFHi91cuVP6WoHHGphA+YjmBjgcwdMNrTRW0CvZqIv6Fjzx0D/mtoJRWAtglYmfuFDy3P4EKnqMVB7ubETG7SOSoSs=
Received: from MWH0EPF000554DF.namprd21.prod.outlook.com
 (2603:10b6:30f:fff2:0:1:0:4) by PH0PR12MB7792.namprd12.prod.outlook.com
 (2603:10b6:510:281::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Wed, 27 Sep
 2023 18:02:10 +0000
Received: from CO1PEPF000044FA.namprd21.prod.outlook.com
 (2a01:111:f403:f807::1) by MWH0EPF000554DF.outlook.office365.com
 (2603:1036:d20::b) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.9 via Frontend
 Transport; Wed, 27 Sep 2023 18:02:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044FA.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6863.9 via Frontend Transport; Wed, 27 Sep 2023 18:02:09 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 27 Sep
 2023 13:02:08 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd: Move `enum drm_amdgpu_ta_fw_type` to uapi
Date: Tue, 26 Sep 2023 07:37:41 -0500
Message-ID: <20230926123741.280030-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FA:EE_|PH0PR12MB7792:EE_
X-MS-Office365-Filtering-Correlation-Id: 50b82f07-ae84-4b57-8669-08dbbf83dea8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eP1AJfxc0O/VUVhAcuAhSlaI3IK2IA7pizzLVJgzap/fFMmCEMVdjs3djYvrjE8S9w7in71y9KR9ulvinZApcA5uYTNXrNwAuZWuJo0vDiWXHdIp7B/oI4Wdg9r5JiKZFtE/vUZxhcolDAZSxjF0Na0KaI5z9eU3eA7xsfe/NU+ciSDcG3pK76F4uGUWPMBkUPnRLOCdEQJiYUX5/5hyDHIqALLQb+fS35vDCv26Qfoibv0m1GI5C3CXQDs+T6RDt6UXkrPzCx6TxYguPRjScCE+1v3QSNVj1hUd/FohXUjkJ+e3s2ayYqGta41f4xqmBGdnSlepixuAgrdySR0HmQEtSPF/2YbQpDkgyE18It1T61gVHlvEVa+ZYeiZe7flM5nW8ItoKHl+ftTtTHzkzesw+AilMJIOpEDRUhhDHKReB0AkJKQl0UIpIMdsW5dn6E2azM54OrWRDTMr/IhDvtK/tlVfxdqnXVJNUNApGkEuBD1mGDn9lC+0k0VLn1WeWQC1fhLk3CSgSF6Tvowdu0i59JH9lldbA8DxY2kgC96OxLTkQWDrZBj0PtMl/zD58ScwGlL4LAnypAzgV/HAv0RmuPJRs58hZr+GPVYk2sp+7+1di1aQUSSQGEQllOzieWhMWu9IP+Y6oqThCsbNcZf1uGIP4v/EcLlvl2O7nobGYXMIkSOjHNDkC/PzQg8kEl+2BMShsbw2KoFIDKVCGTVGoC+WwpxCaGnqYXIuL9DuO6EwnHw2cp9SLS2RHjmMmB7t171BRAF/erd3B07a9FPFhVmbWoiYE/zneEoesIg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(346002)(39860400002)(376002)(136003)(230922051799003)(186009)(451199024)(1800799009)(82310400011)(36840700001)(40470700004)(46966006)(2906002)(44832011)(5660300002)(70586007)(478600001)(70206006)(6666004)(2616005)(1076003)(7696005)(16526019)(336012)(426003)(26005)(4326008)(81166007)(8936002)(316002)(8676002)(6916009)(40460700003)(83380400001)(41300700001)(356005)(82740400003)(36756003)(86362001)(40480700001)(47076005)(36860700001)(81973001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 18:02:09.8701 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 50b82f07-ae84-4b57-8669-08dbbf83dea8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044FA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7792
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
Cc: Mario Limonciello <mario.limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Enum values used by the ioctl `AMDGPU_INFO_FW_VERSION`/`AMDGPU_INFO_FW_TA`
are not exported so clients need to keep their own copy of the definitions
while looking up firmware versions for the TA.

Move this to uapi instead.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h | 12 ------------
 include/uapi/drm/amdgpu_drm.h             | 12 ++++++++++++
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
index ae5fa61d2890..73a84af54d70 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
@@ -145,18 +145,6 @@ struct ta_firmware_header_v1_0 {
 	struct psp_fw_legacy_bin_desc securedisplay;
 };
 
-enum ta_fw_type {
-	TA_FW_TYPE_UNKOWN,
-	TA_FW_TYPE_PSP_ASD,
-	TA_FW_TYPE_PSP_XGMI,
-	TA_FW_TYPE_PSP_RAS,
-	TA_FW_TYPE_PSP_HDCP,
-	TA_FW_TYPE_PSP_DTM,
-	TA_FW_TYPE_PSP_RAP,
-	TA_FW_TYPE_PSP_SECUREDISPLAY,
-	TA_FW_TYPE_MAX_INDEX,
-};
-
 /* version_major=2, version_minor=0 */
 struct ta_firmware_header_v2_0 {
 	struct common_firmware_header header;
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 984fc16577ca..225dec3634f0 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -912,6 +912,18 @@ struct drm_amdgpu_cs_chunk_cp_gfx_shadow {
 #define AMDGPU_INFO_MMR_SH_INDEX_SHIFT	8
 #define AMDGPU_INFO_MMR_SH_INDEX_MASK	0xff
 
+enum drm_amdgpu_ta_fw_type {
+	TA_FW_TYPE_UNKOWN,
+	TA_FW_TYPE_PSP_ASD,
+	TA_FW_TYPE_PSP_XGMI,
+	TA_FW_TYPE_PSP_RAS,
+	TA_FW_TYPE_PSP_HDCP,
+	TA_FW_TYPE_PSP_DTM,
+	TA_FW_TYPE_PSP_RAP,
+	TA_FW_TYPE_PSP_SECUREDISPLAY,
+	TA_FW_TYPE_MAX_INDEX,
+};
+
 struct drm_amdgpu_query_fw {
 	/** AMDGPU_INFO_FW_* */
 	__u32 fw_type;
-- 
2.34.1

