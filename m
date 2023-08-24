Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABCC8C27C40
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Aug 2023 21:32:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0CC8410E5BB;
	Thu, 24 Aug 2023 21:32:00 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D0A210E5C9
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Aug 2023 21:31:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PyClsHIzOrBRZ0LeB2YY1koVabdVYngt6Dx3bQe64Id8HL4yyZoVj85ttFx20TAIqfGLDgshK51Sj3UDGHphNm/wesUHraXwUhgen2gtBJ5lISr7N6mEzgWbXtVbyP0rCjwi94DmgVrZQn5j64MgGioGkh/F+tGD8x2JeNpDGUtvTFABCCsa6Vl93b2FkiR0awDqHj2wJfB52tzN35vvB98pq8FQi2mMgHkHc7het9U0nLBDxAF17DPGlsjtP7m/8aKuoNWkq9y7my1Uu+pob6FQkilFTtkbak4pbqdKmancbGNyZ8/eHdcE6rL0fUwTZdDNk008l9OMn/fxChVO2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k8h10UfvanITloDuS7ZWXPJv5Z7jQxIaEUbveiQVAME=;
 b=X1gfeyCwpz2bfFo0WmoYi2kGPO7U/Di005L00dOF+TeBTqnv+8XRxfKHI7mvTq2iKU99Vyf+YZb2nGZy+NifGx5JDTYuH70SKBzbBwUcwgLvuWyiYAoFLvXj745fdo7Y+SHM5nkZ5xXB/iZEoQENrk1pdnUCCDiEx/s4wWpjJqtXDkPa3jzxKMTchyOApQXr2ej14dcs9qb6yqBy2Ky81+DFbJUuYwAR3/K5cacGe9v85rS6Ng/b4jJgXYPvz2iPRbPZJkiccUQRbvj6z6RXZGoFLEktTghoIcTBGLUgs0qaz2zbpjzDco1E0CP2rmTeEwpt/kBck+N/Q8N5Ce3HbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k8h10UfvanITloDuS7ZWXPJv5Z7jQxIaEUbveiQVAME=;
 b=hN8fXZQBvuNC8bBEr5Mr+wbArmW3brd2AVUCSm4aJkBQ11stb+eT2nht72yDTX1V8kZcTR8ngrZ4YiOzU8qNoniBooeI6Dhv1B8NMTIbiPqTkr9a2VXBezw74wsnvhZrmcycS8kqtwBPu/EmQSRUSC9rG7ogGgBQaQjhvcCpw18=
Received: from SJ0P220CA0015.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::19)
 by SJ2PR12MB8649.namprd12.prod.outlook.com (2603:10b6:a03:53c::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Thu, 24 Aug
 2023 21:31:56 +0000
Received: from MWH0EPF000989EA.namprd02.prod.outlook.com
 (2603:10b6:a03:41b:cafe::40) by SJ0P220CA0015.outlook.office365.com
 (2603:10b6:a03:41b::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20 via Frontend
 Transport; Thu, 24 Aug 2023 21:31:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989EA.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Thu, 24 Aug 2023 21:31:55 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 24 Aug
 2023 16:31:53 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 21/21] drm/amdgpu: add VPE FW version query support
Date: Thu, 24 Aug 2023 17:31:27 -0400
Message-ID: <20230824213127.2725850-21-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230824213127.2725850-1-alexander.deucher@amd.com>
References: <20230824213127.2725850-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EA:EE_|SJ2PR12MB8649:EE_
X-MS-Office365-Filtering-Correlation-Id: fbf7369c-47e6-426e-a716-08dba4e98a64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xwtieMK9fjCx69LyiNaY21ZSY+tpFEkn9wrITCVfNLOlgHo0nuhSVMCs57yiXKDWldAgDJo4rtirYJWFZpl/FzP8DRtT8/4dVlINK45w5GOpKWmwZnriFAMPbGqQNpdqKYhjLl01L3B2yHaBl/qEqmSapr50UlbsbuOcOg55ewqDvSF5HucyhlbIYbwV8DQkO2T+mo+3fDlMIBLVqgriB60G+2O58qdqnEF0+fDGt3AqcYgQcq1M6fnIK/Fvl2sYIpH7cM+nSoHHlgCu6iNfa1WFY2t2U8w5BkthtVWJUZA+DcEO5nH86zJx0Y4qy8ln3ylneq8k3+tn8xZX06ML/ePb4A2t10+gLFo7xRPJyYI9bkWwC6/uylwKvyb/66EVWKdSYobyzyuXpYOimktT9dwRiqCTvnbAHc+mVWr+7tiTbELsRvf6SiMM5v9e+jcMx2C6yx8eQTPA88bHerSG23UGE1veCgyTYefd2/A9OkYWQYKH8cnoXidp88ZYX7RUtCH8/uzEelJHiVIXVobSltgRzT5BzUv2mZqplBYG+R2IvfflRJx/fcR+0YohluxFf9XL1uQpQrlsTnlLf6Zi/k/KdR/aDocpGNFjMAV6lXyjKgwFM4Fg1IuV5q40uv4wu6+a6FUijy5bPAa79r+46q1JSd9uGGo+gps6jzTpnnYh3KgZaxGPRaKB6pv4YU4vsQC+op2xVh0aYIMp4S42LKWZQF3/lHd3ZgtyMDZW+DPePjq/SAO1llCS2h7aZ0chUW2hJhaxCHVfI0H+PdJMlA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(39860400002)(396003)(376002)(136003)(186009)(1800799009)(451199024)(82310400011)(40470700004)(46966006)(36840700001)(40460700003)(336012)(426003)(26005)(16526019)(1076003)(2616005)(41300700001)(47076005)(36860700001)(70586007)(54906003)(2906002)(316002)(6916009)(70206006)(5660300002)(8936002)(4326008)(8676002)(478600001)(7696005)(6666004)(40480700001)(86362001)(356005)(82740400003)(81166007)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 21:31:55.7682 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fbf7369c-47e6-426e-a716-08dba4e98a64
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989EA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8649
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Lang Yu <Lang.Yu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Lang Yu <Lang.Yu@amd.com>

Add support to query VPE FW version.

Signed-off-by: Lang Yu <Lang.Yu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 12 ++++++++++++
 include/uapi/drm/amdgpu_drm.h           |  2 ++
 2 files changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 21c4904d283f..3a48bec10aea 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -352,6 +352,10 @@ static int amdgpu_firmware_info(struct drm_amdgpu_info_firmware *fw_info,
 		fw_info->ver = adev->gfx.imu_fw_version;
 		fw_info->feature = 0;
 		break;
+	case AMDGPU_INFO_FW_VPE:
+		fw_info->ver = adev->vpe.fw_version;
+		fw_info->feature = adev->vpe.feature_version;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -1731,6 +1735,14 @@ static int amdgpu_debugfs_firmware_info_show(struct seq_file *m, void *unused)
 	seq_printf(m, "MES feature version: %u, firmware version: 0x%08x\n",
 		   fw_info.feature, fw_info.ver);
 
+	/* VPE */
+	query_fw.fw_type = AMDGPU_INFO_FW_VPE;
+	ret = amdgpu_firmware_info(&fw_info, &query_fw, adev);
+	if (ret)
+		return ret;
+	seq_printf(m, "VPE feature version: %u, firmware version: 0x%08x\n",
+		   fw_info.feature, fw_info.ver);
+
 	seq_printf(m, "VBIOS version: %s\n", ctx->vbios_pn);
 
 	return 0;
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 6289b2575464..ec437120b083 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -798,6 +798,8 @@ struct drm_amdgpu_cs_chunk_cp_gfx_shadow {
 	#define AMDGPU_INFO_FW_MES		0x1a
 	/* Subquery id: Query IMU firmware version */
 	#define AMDGPU_INFO_FW_IMU		0x1b
+	/* Subquery id: Query VPE firmware version */
+	#define AMDGPU_INFO_FW_VPE		0x1c
 
 /* number of bytes moved for TTM migration */
 #define AMDGPU_INFO_NUM_BYTES_MOVED		0x0f
-- 
2.41.0

