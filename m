Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8333C6FA86
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Sep 2022 17:01:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4EA5610EB7A;
	Thu, 15 Sep 2022 17:01:14 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2049.outbound.protection.outlook.com [40.107.223.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C40F510EB6E
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Sep 2022 17:01:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VI0QGwGJwqsEBflv6uyGC+Bt3b99bLZKdh5W8Sy6OL5nn8eE1U1V1eJ9SNVOEqAK2WgzBn0lAwJzpG+9nI/mWEDGplNetEOmpAaoXCMs3fD4p8kxtXLo5PyglLMX5w2hyxZYFpnB500ElhBW+ZOARGnq0NJPqMi8IOmyHscYvDHHHfg9PdVuDXK6yCmGtSbG4cINH5rZNEOiQxnTIkgUg53otlNo/TDmBub5DxBOcprR6mQDdsG4uALEnCCq1qJnZO5zm3swGa76b8by9emOPTAGtXWA97UapxMz9fVjtHdPciWa3Hb8uLJvG9q23LeUzyp+3c4hr1t+A/NVFEZ5yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QAWk3jBrbHK4hExn9+0cTQTzsnDO5K9Crlo4qcSN75k=;
 b=JBk5GGCXM5pvWRtJ1MOZI5935fJTtOJEKW9RlWKX3f+zxGfM6rnTkglUmbknIQRkfY1+tcukrv26pcF8Pm8iZ4ov1WP85P2Ct4or4f75H57sUk1OKWWfMhzL3oFLV40iHovPffC263bcfixuhmsl4WkrmKWBzf7qh/mO8jNHYuXi0UmLo8v7uaTgBXBbdlQOEVvykrhfVT7W1iQSWmwjsOa0aBp4yygqEsJhBioixRPJ9L5SYmg4HZpcqyf/sO6odfydpOzlS6ziXOt2C7z9ttrU4tR7mSXHLAzSWqVKfxbCjAvDGrCKQRoWsgiFPug3DNvMjQ4lYB6kjWTtIhqKKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QAWk3jBrbHK4hExn9+0cTQTzsnDO5K9Crlo4qcSN75k=;
 b=SHFfwiY2t8qOPQJGLP5V6ZAXlcmcY3Vvm94y/boWdrT5r617HMZOxKQqos4gbFkfyYTI2W/KFpf6KZraw9/XCTCSZf1uVOD/rj8XiVWiJBEWS9Yp+05wMOWuQ0L2e7TmkaI8DLwfsxMRK/Jn6iCeavJ+O9lcmxW6zvY9Dmg4G5A=
Received: from DM6PR03CA0002.namprd03.prod.outlook.com (2603:10b6:5:40::15) by
 SA1PR12MB7151.namprd12.prod.outlook.com (2603:10b6:806:2b1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Thu, 15 Sep
 2022 17:00:58 +0000
Received: from CY4PEPF0000B8EF.namprd05.prod.outlook.com
 (2603:10b6:5:40:cafe::b8) by DM6PR03CA0002.outlook.office365.com
 (2603:10b6:5:40::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.15 via Frontend
 Transport; Thu, 15 Sep 2022 17:00:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000B8EF.mail.protection.outlook.com (10.167.241.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.9 via Frontend Transport; Thu, 15 Sep 2022 17:00:58 +0000
Received: from hawzhang-System-Product-Master.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 15 Sep 2022 12:00:54 -0500
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Likun Gao <Likun.Gao@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 4/4] drm/amdgpu: add rlcv/rlcp version info to debugfs
Date: Fri, 16 Sep 2022 01:00:27 +0800
Message-ID: <20220915170027.23010-5-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220915170027.23010-1-Hawking.Zhang@amd.com>
References: <20220915170027.23010-1-Hawking.Zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000B8EF:EE_|SA1PR12MB7151:EE_
X-MS-Office365-Filtering-Correlation-Id: ec263687-8781-4a82-e829-08da973bdc71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9GDkTIBbF8m5hoTsZFkkETHA0CYeo5PFUztsuj/Bt/caGcpYSAfvQdRJZkRwAqrX6SRMQmqJDAX9RRypaCMTDwHL9zkh7F8tIkJgexl2rW9rIX0v/1ntScVWsOEA6sCamoFeuKSuESaMQGtHG9srp+FgvNnMJLf/pPrL2PbuUPsEzXzo7o1xi5SxwVs3wzMnpHvzulA5beE+5ZpfvV9+8oXUR/sf0/gDEif9pkVOfd50kkkMnZB0XUrsll7WOHbZHvB2FHfOik81SVjlKVS9mVpmJ/l6btd19rTmr0SvBIwXQ3k6Di+96D+DnCrNxjSX0e+dj/UjpQoRjbTfkfxG83Q/2BNq8VYzWkCKlRoJBEw2G09ov60jnVI5o+KK2hTiBx6lyp9HWfAa5EW/wLj8h8xeU5lDXMWzMlCDH7k4Li1onPXN2j+ufpo6PY1AN5L7NfHxTGfyWLR8CoX5UCHS5Us5IDp7pb+pZYla11CHPaX+Cd+izE6G284SZrTyPZXR2PvPO1+cp1IOAFL5ARWe+ZD8HMhlcQSOh9zF1l40cmtg+TRgS5ve4hi2jM+J/4Ku5je1xhgzrPgeDNL4+pluFCHkfo3Hw3fxrzbEXtF7KD2fRT3T6SyLOx026+khAq+kg3IY4Pd5dONqvOMlm4L1+G8Np53D1vJIA3UmiCDiNkl9uLHFjVS7lIoAABNKWZQ5WgVs3DLY5eSnFlQS+FJXaA8XvqEZsn9bV/bDOf1hzXBZJnk5Et7JTBGRlyo1qULMZ4trVGUxQsuucioI6dKuoyKE54ZyCUcSwKR2Ud6r37+y7oxldBt34kW3thTsc5ht
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(136003)(346002)(376002)(39860400002)(451199015)(36840700001)(46966006)(40470700004)(5660300002)(8936002)(316002)(36756003)(41300700001)(86362001)(2616005)(70586007)(70206006)(4326008)(8676002)(7696005)(82740400003)(478600001)(356005)(6666004)(81166007)(82310400005)(6636002)(40460700003)(36860700001)(2906002)(110136005)(47076005)(426003)(1076003)(186003)(336012)(26005)(16526019)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2022 17:00:58.1476 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec263687-8781-4a82-e829-08da973bdc71
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000B8EF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7151
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

amdgpu_firmware_info debugfs will show rlcv/rlcp
ucode version info

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Feifei Xu <Feifei Xu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 4c022785ded1..49d5c43ae9b1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -253,6 +253,14 @@ static int amdgpu_firmware_info(struct drm_amdgpu_info_firmware *fw_info,
 		fw_info->ver = adev->gfx.rlc_srls_fw_version;
 		fw_info->feature = adev->gfx.rlc_srls_feature_version;
 		break;
+	case AMDGPU_INFO_FW_GFX_RLCP:
+		fw_info->ver = adev->gfx.rlcp_ucode_version;
+		fw_info->feature = adev->gfx.rlcp_ucode_feature_version;
+		break;
+	case AMDGPU_INFO_FW_GFX_RLCV:
+		fw_info->ver = adev->gfx.rlcv_ucode_version;
+		fw_info->feature = adev->gfx.rlcv_ucode_feature_version;
+		break;
 	case AMDGPU_INFO_FW_GFX_MEC:
 		if (query_fw->index == 0) {
 			fw_info->ver = adev->gfx.mec_fw_version;
@@ -1514,6 +1522,22 @@ static int amdgpu_debugfs_firmware_info_show(struct seq_file *m, void *unused)
 	seq_printf(m, "RLC SRLS feature version: %u, firmware version: 0x%08x\n",
 		   fw_info.feature, fw_info.ver);
 
+	/* RLCP */
+	query_fw.fw_type = AMDGPU_INFO_FW_GFX_RLCP;
+	ret = amdgpu_firmware_info(&fw_info, &query_fw, adev);
+	if (ret)
+		return ret;
+	seq_printf(m, "RLCP feature version: %u, firmware version: 0x%08x\n",
+		   fw_info.feature, fw_info.ver);
+
+	/* RLCV */
+        query_fw.fw_type = AMDGPU_INFO_FW_GFX_RLCV;
+	ret = amdgpu_firmware_info(&fw_info, &query_fw, adev);
+	if (ret)
+		return ret;
+	seq_printf(m, "RLCV feature version: %u, firmware version: 0x%08x\n",
+		   fw_info.feature, fw_info.ver);
+
 	/* MEC */
 	query_fw.fw_type = AMDGPU_INFO_FW_GFX_MEC;
 	query_fw.index = 0;
-- 
2.17.1

