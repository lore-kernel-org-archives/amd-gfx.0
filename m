Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF96ECD343F
	for <amd-gfx@archiver.kernel.org>; Fri, 15 May 2026 06:58:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 62B3D10F411;
	Fri, 15 May 2026 06:58:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ty2SGteN";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011001.outbound.protection.outlook.com [52.101.57.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C1A8310F411
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 May 2026 06:58:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sz5g8nxrQb7Ef30amZqhDqOZuenoreq/ab9GfR+cmvVx4I3DIG4fapRa/q7pZyMo56BDfQHkHQcg7bI6zq7C/3HC0h29F4cZuEZbZwd/9ZXtjUDXckzHOLcCDdVqWyp2LwZgpUhM7Yzx8ZkJWBe4CceApbfO9xJqbzh/hVIW17LinFQYGiikX5dAUu9XQ+ku/GmFsTN9xajCZkSEbqABdKjITU11XPZiW60fUHfj+ZHMcinJdcFs1XAbRDLRLX+r45wZSNPvDWGoF9mQovsVi1kSpmXSnkHb2VtbbRDECyKYJViRLMHbmhiJ4M79Stg01MaxoLCDQpf44csMWpzhsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/UcbF5I/wjcidvKHSAZ8TXm3xFhx8tKM2Mrh1GAjFqg=;
 b=N6qa6jlIH1mRBHPhOl/f9Plre0nPqo8+KWKU72S6ISpM2KlHvZinuki7GdQqtp0oOioKBN93cfn+0VxFWhKVk3OX5Q9MbyWNkPz5cFPs0hthFXdFEbxnF1r/lDHnqjqiBlUC1JnxCooFnNr70rTu9sIn6B3DcRJPVvawqFP/N2Yaur5lI9VwZn/Tze/bpnifYBbhsGWjz/Mkt3YG5849rNLDCoK4E/zZEGepUeO3MhabJcCt05qZ0i91xRRDTchFuA6cTmsduyMerAilhvmPLOQLPVLO0IqV5sb6w+/WtQBq8hvNlFamAzC0EyHzpwSD/L1kElWQCvtq6QuaEE4GYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/UcbF5I/wjcidvKHSAZ8TXm3xFhx8tKM2Mrh1GAjFqg=;
 b=Ty2SGteNcvlTBmMBkVdp6K0bsTbMRIg7cBC714ml3Bc8nJrHB6+9pegbT8KjkjzmRCjZjAs/SanUAlzHLVORhENZ5OyOu2ztfooYQfi73zAty5ORkfPNzTkbnFmIC4Gfzjoyt69HtyXVfyJcuJLSYXrI3RGyBR5FScNMbarAC8w=
Received: from DS7PR03CA0188.namprd03.prod.outlook.com (2603:10b6:5:3b6::13)
 by CY5PR12MB6130.namprd12.prod.outlook.com (2603:10b6:930:26::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.19; Fri, 15 May
 2026 06:58:00 +0000
Received: from CY4PEPF0000E9DC.namprd05.prod.outlook.com
 (2603:10b6:5:3b6:cafe::67) by DS7PR03CA0188.outlook.office365.com
 (2603:10b6:5:3b6::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9913.13 via Frontend Transport; Fri,
 15 May 2026 06:57:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000E9DC.mail.protection.outlook.com (10.167.241.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Fri, 15 May 2026 06:57:59 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 15 May
 2026 01:57:58 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 15 May
 2026 01:57:58 -0500
Received: from fc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Fri, 15 May 2026 01:57:56 -0500
From: Feifei Xu <Feifei.Xu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Feifei.Xu@amd.com>, <alexander.deucher@amd.com>, <Hawking.Zhang@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: fix shift-out-bounds warning of
 number_instance
Date: Fri, 15 May 2026 14:57:53 +0800
Message-ID: <20260515065753.3488208-2-Feifei.Xu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260515065753.3488208-1-Feifei.Xu@amd.com>
References: <20260515065753.3488208-1-Feifei.Xu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DC:EE_|CY5PR12MB6130:EE_
X-MS-Office365-Filtering-Correlation-Id: 30d43ed0-e4a9-4148-4fa2-08deb24f4cc6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|1800799024|18002099003|56012099003|22082099003|11063799003;
X-Microsoft-Antispam-Message-Info: VSrOw+YIUjccE2K4mWU7h9P66r5MspH3WPtKccrWXyQSgHpOBxFQEagxWbBU/AzkjfXc6H8Z4nU9S9k/UngLoZS8PC+TBX+F6Ew8IzVu2m8NsbjjZZBvVn6KDM6uVA1GWQh1Zefils0tpsLcHhlPCvEH1dMC6UNB9UXkqhigrXFzZwT5YW2tTPKZoqMSUBv9tucaOt5qE6HG3p3BKIpBMGKX30oPe4aJs9f8QHIjaZJ2IeSmQ8hUf203v2zh7KndUudk4pYlOunu++mTGwYj1We8Fo/wszyTH2tHzkdRopgFYhi/FHYl0TR/zIMe4oVuJh//IvBLQ4gUkZjRhnYGd7sXz+dZaSo5B+CJ9dwQvqoZEx0Ql39+fsKBpNFzXg+puDAPqjh4SuIR2H583j6MavDiC89MqODgAE1QEZMxRZA+O2NlsS2OcilErkXvpNOVYcJIL+RQTN3Rh1sFezWU5MfhDqk4twzPZ6BY0r7MDiF75ix+BtJVh8iiXLaxNERn29n8RoIubZfAOJp+zaUpcgy8u4Y+WJOt7v4nyRtkgSV0yK2EzKA9lYyTuwv4pe5E9/DOVvtnV5nyPk2/+CsjL5RVPWDTRyjemUfR1DZf3nUq/tif0j5tMUsl0o8qgTJzegIR/d7aOa3hfqsafqN4NWCJ33R4G227AXc/CdDQjepSgrExXXOG6UDGWz2JgOksjcPYl7lw+prz+QHgLQDjMNgkzmmdtNKZLrxOSI+se2o=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(18002099003)(56012099003)(22082099003)(11063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: vKi1KqoD5G7baqa2uWpEINLGjW9uJddUtJy1i/eNhkjaUa4Hu5I/efP6e8xK9QR4WLvfY1j1+iGklDqAxceS/0jjNHvh/Xd+Ctts4Kl42kECtFDIiBxNgJ1U71bMaDG1EpLHoMTE0nqW6jKsOcooztBhom2gOSnGQC3x5+DlRyGaezT4aPmaYMXuVO767kl1FlBi1j8U+zBOOf3splgTK+NL2f/fUYUzTo1H6pnZBmPr1qJCZ1WIJLRHM9+CfoUIIKPPagr1X2ZrPpViDiHxGdej9xOjNAbxf2bEYq9hb6A3RNfhK2R0dUlYsiKTe74LrxibFKulA1p56pQbfiyW1Q7a0RDH46zIx1gQW+9VWm9Ns8ba7LYuunqtLCVWxp8INSAu22qWTL3OcLfzjuHO3TzX48Ui72ZMIlHTIu6A2fJUoP7qkAiTUIuZ6dDLb+XW
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2026 06:57:59.2600 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 30d43ed0-e4a9-4148-4fa2-08deb24f4cc6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9DC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6130
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

Clamp number_instance using BIT/BIT_ULL with the <32 check to avoid the
shift-out-bounds warning.

Signed-off-by: Feifei Xu <Feifei.Xu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 40 ++++++++++---------
 1 file changed, 21 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index c9073935e1a4..314fe4a00002 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -840,42 +840,44 @@ static void amdgpu_discovery_read_from_harvest_table(struct amdgpu_device *adev,
 	harvest_info = (struct harvest_table *)(discovery_bin + offset);
 
 	for (i = 0; i < 32; i++) {
-		if (le16_to_cpu(harvest_info->list[i].hw_id) == 0)
+		u16 hw_id = le16_to_cpu(harvest_info->list[i].hw_id);
+		u8 inst = harvest_info->list[i].number_instance;
+
+		if (hw_id == 0)
 			break;
 
-		switch (le16_to_cpu(harvest_info->list[i].hw_id)) {
+		if (inst >= 32) {
+			dev_warn(adev->dev,
+				 "bogus harvest instance %u for hw_id %u\n",
+				 inst, hw_id);
+			continue;
+		}
+
+		switch (hw_id) {
 		case VCN_HWID:
 			(*vcn_harvest_count)++;
-			adev->vcn.harvest_config |=
-				(1 << harvest_info->list[i].number_instance);
-			adev->jpeg.harvest_config |=
-				(1 << harvest_info->list[i].number_instance);
-
-			adev->vcn.inst_mask &=
-				~(1U << harvest_info->list[i].number_instance);
-			adev->jpeg.inst_mask &=
-				~(1U << harvest_info->list[i].number_instance);
+			adev->vcn.harvest_config |= BIT(inst);
+			adev->jpeg.harvest_config |= BIT(inst);
+
+			adev->vcn.inst_mask &= ~BIT(inst);
+			adev->jpeg.inst_mask &= ~BIT(inst);
 			break;
 		case DMU_HWID:
 			adev->harvest_ip_mask |= AMD_HARVEST_IP_DMU_MASK;
 			break;
 		case UMC_HWID:
-			umc_harvest_config |=
-				1 << (le16_to_cpu(harvest_info->list[i].number_instance));
+			umc_harvest_config |= BIT_ULL(inst);
 			(*umc_harvest_count)++;
 			break;
 		case GC_HWID:
-			adev->gfx.xcc_mask &=
-				~(1U << harvest_info->list[i].number_instance);
+			adev->gfx.xcc_mask &= ~BIT(inst);
 			break;
 		case SDMA0_HWID:
-			adev->sdma.sdma_mask &=
-				~(1U << harvest_info->list[i].number_instance);
+			adev->sdma.sdma_mask &= ~BIT(inst);
 			break;
 #if defined(CONFIG_DRM_AMD_ISP)
 		case ISP_HWID:
-			adev->isp.harvest_config |=
-				~(1U << harvest_info->list[i].number_instance);
+			adev->isp.harvest_config |= ~BIT(inst);
 			break;
 #endif
 		default:
-- 
2.34.1

