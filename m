Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91BB7C43334
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jul 2022 22:09:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2BD0E10ED72;
	Fri,  8 Jul 2022 22:09:22 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2085.outbound.protection.outlook.com [40.107.102.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE9AE10ED7D
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Jul 2022 22:09:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LsCNml7bq2+teblIwKiQebEduhx+inYqfDsxRg/SRWmj/fP6m43HKDmwVCdVtm7vuZko02pOMz3wcNcPztJguUGfy+kdoLNhE/a44TeV34a4dg8zqg9d+zuwogxfmduNucD9fLkzwlYJAMahB3zIK28riZ0s5SCw6Zq3z3yJqafrK3OIJp8OOIc9Dtu23B0yXNZRJgEJ06iOJWBfPTiovIcUMokyGmG+18GiNCFxY80yv2xmCAJUv+jVAhHi310X9U5MgJYlZ7okqE11gUD//OfZxVfAD2AjueWtfuV4cl3MjxMfop7qWxTwRr8Tms1/oqzdXoqJxs/1ftI8/udOgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J4HMtfdIoE681fVF4Kou8U9RIPx3p4BcfgcCi3WSZN4=;
 b=AkFx/7h6lDg/wJBmQkeaqN7L4Bm0yt12Ck7vIN7woXVm4KcOZs9VLYjfD+1CwbJG/r1AQXz+T/JTUdnYlcUFgsnQGPC59KUdkUqmYHOAedJVjKd6/6itJ8aWXIOxfWHrY6draJ5TD2kQblvAUJvovCLr4701b+1fdmHJIihh9jRXjVNEiUg5Iwru4JNeEaJu3geYt404JYPFxmkHz1YUafXbJ/ajAUIAJ0WhPo9L202E1tfJb766Hzlb/PTyT4/vumls9gEMZ89ckvUc61SlgAgSscDzTXkzLn2AfQj6KOoMFhGtIgumQ6rZG4NcugeMMfpCcH3KGYhhvNbwlWs0yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J4HMtfdIoE681fVF4Kou8U9RIPx3p4BcfgcCi3WSZN4=;
 b=bW+frtZxBvzH3XnbrMx1n4D/O9sZqxdghbYzdSDSsdUE4ozs3DQODtTLanwRfwDzGzD6Cvnn/V3FoPRT4ose8KXYxXx19nBXkyfHxdWJDa1acI1f3s1Qko+1xdNsYvYHQXtPZvH9ZWMQgfgWO0F5RgWj1vQ+F138KiRYm0e+qJw=
Received: from DM6PR05CA0050.namprd05.prod.outlook.com (2603:10b6:5:335::19)
 by BYAPR12MB3526.namprd12.prod.outlook.com (2603:10b6:a03:13d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Fri, 8 Jul
 2022 22:09:15 +0000
Received: from DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:335:cafe::8) by DM6PR05CA0050.outlook.office365.com
 (2603:10b6:5:335::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14 via Frontend
 Transport; Fri, 8 Jul 2022 22:09:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT010.mail.protection.outlook.com (10.13.172.222) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5417.15 via Frontend Transport; Fri, 8 Jul 2022 22:09:15 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 8 Jul
 2022 17:09:13 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 9/9] drm/amd/display: Enable DCN314 in DM
Date: Fri, 8 Jul 2022 18:08:55 -0400
Message-ID: <20220708220855.1475213-9-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220708220855.1475213-1-alexander.deucher@amd.com>
References: <20220708220855.1475213-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 705ede2a-0a52-4e11-e0ad-08da612e7efd
X-MS-TrafficTypeDiagnostic: BYAPR12MB3526:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 66CkuPmtPR3At0LWQSn4NJa4Uyw816iJcxed2+juKWggAoOGQfyeyuSFgYtz1eOZ2lH+uZnHhpOvzOmvRa01dBZsEcSiNO9EEpyfGneMub2dONvZTcfBiLPT806bLn9RP4wGtiy+TkbhjqVwpeR9+A7CmNdHltRrGsKbeEyU+bh+taceXKmixQdTeIfetCHX/JTpkLagNJdLc792mElrnmo/oRQAENzJRmq91aQL+Av3dlvThEG5LY2GAjlsq8k2Esbl3KkicR9skJX9Ir+kIoo+bK/2GOQki/U9U3iWhHj1MR9K5dIF6wQUSmh2/cHWGPHcItpj/l/SELrkWTjOa1Lcg5AMZ1yxo1ebL2U3j1241wWXnWKEh9lkj5YH46EVfuOGPgVHDlZ1JlJC78YJvra1EWni/HkvwVy8G9uXBpRN94M4RqUmoL9ezefhT8LgmQbN22wcyrqIJ+08K2QS8Rj/A04BP85NeHea4lnVai7/IG/BryB9KA3mTR8D3sUgD8abbSyio1gTNLYwsqZ2WZ7HoNu8wehq+EVALMpHKZ5Fo214ihSmaSmNr9zv+RbtVEDx05zQAVYT4Trj7K/GEpcN9SMzA5NVM2s5R6vK1ULmY5GQE2Zylfr6sIdvyRY1l4XsgDi5Ls4R9g8UxfGfrxoe2kxA+ETRDmcY+w5FvJmTr0S03YGOusjHRemO9mnX/Ub4/lxXpjG8YPeLLe4fTZYKTt3frx5A3V4YPqnhNJz9SYMri/SyyTrRm88zuGQfJrnzLpMMDsoSGTq49ZfTXZ04zlA5MN4T7/VajYtRJmN/UjOc1u9mapFLWi+tEhb9FRNG4rwc8uvzveXucvFYT7PfL3JOzE1DFYKHr+BtVlR6yYtNm4mF5iHLmALgyZMZ
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(346002)(136003)(376002)(39860400002)(46966006)(36840700001)(40470700004)(16526019)(426003)(7696005)(186003)(336012)(47076005)(4326008)(70206006)(54906003)(40480700001)(8676002)(70586007)(2616005)(36756003)(1076003)(6916009)(26005)(86362001)(40460700003)(81166007)(82310400005)(41300700001)(36860700001)(34020700004)(2906002)(8936002)(5660300002)(6666004)(356005)(316002)(82740400003)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2022 22:09:15.2366 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 705ede2a-0a52-4e11-e0ad-08da612e7efd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3526
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Roman Li <roman.li@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Roman Li <roman.li@amd.com>

Add support for DCN 3.1.4 in Display Manager

Signed-off-by: Roman Li <roman.li@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c     | 11 +++++++++++
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c    |  1 +
 2 files changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index eb5efb4aa2ba..15dac00317ad 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -116,6 +116,8 @@ MODULE_FIRMWARE(FIRMWARE_DIMGREY_CAVEFISH_DMUB);
 MODULE_FIRMWARE(FIRMWARE_BEIGE_GOBY_DMUB);
 #define FIRMWARE_YELLOW_CARP_DMUB "amdgpu/yellow_carp_dmcub.bin"
 MODULE_FIRMWARE(FIRMWARE_YELLOW_CARP_DMUB);
+#define FIRMWARE_DCN_314_DMUB "amdgpu/dcn_3_1_4_dmcub.bin"
+MODULE_FIRMWARE(FIRMWARE_DCN_314_DMUB);
 #define FIRMWARE_DCN_315_DMUB "amdgpu/dcn_3_1_5_dmcub.bin"
 MODULE_FIRMWARE(FIRMWARE_DCN_315_DMUB);
 #define FIRMWARE_DCN316_DMUB "amdgpu/dcn_3_1_6_dmcub.bin"
@@ -1941,6 +1943,10 @@ static int dm_dmub_sw_init(struct amdgpu_device *adev)
 		dmub_asic = (adev->external_rev_id == YELLOW_CARP_B0) ? DMUB_ASIC_DCN31B : DMUB_ASIC_DCN31;
 		fw_name_dmub = FIRMWARE_YELLOW_CARP_DMUB;
 		break;
+	case IP_VERSION(3, 1, 4):
+		dmub_asic = DMUB_ASIC_DCN314;
+		fw_name_dmub = FIRMWARE_DCN_314_DMUB;
+		break;
 	case IP_VERSION(3, 1, 5):
 		dmub_asic = DMUB_ASIC_DCN315;
 		fw_name_dmub = FIRMWARE_DCN_315_DMUB;
@@ -4222,6 +4228,7 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
 	case IP_VERSION(3, 0, 0):
 	case IP_VERSION(3, 1, 2):
 	case IP_VERSION(3, 1, 3):
+	case IP_VERSION(3, 1, 4):
 	case IP_VERSION(3, 1, 5):
 	case IP_VERSION(3, 1, 6):
 	case IP_VERSION(3, 2, 0):
@@ -4242,6 +4249,7 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
 		switch (adev->ip_versions[DCE_HWIP][0]) {
 		case IP_VERSION(3, 1, 2):
 		case IP_VERSION(3, 1, 3):
+		case IP_VERSION(3, 1, 4):
 		case IP_VERSION(3, 1, 5):
 		case IP_VERSION(3, 1, 6):
 		case IP_VERSION(3, 2, 0):
@@ -4358,6 +4366,7 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
 		case IP_VERSION(3, 0, 1):
 		case IP_VERSION(3, 1, 2):
 		case IP_VERSION(3, 1, 3):
+		case IP_VERSION(3, 1, 4):
 		case IP_VERSION(3, 1, 5):
 		case IP_VERSION(3, 1, 6):
 		case IP_VERSION(3, 2, 0):
@@ -4546,6 +4555,7 @@ static int dm_early_init(void *handle)
 		case IP_VERSION(2, 1, 0):
 		case IP_VERSION(3, 1, 2):
 		case IP_VERSION(3, 1, 3):
+		case IP_VERSION(3, 1, 4):
 		case IP_VERSION(3, 1, 5):
 		case IP_VERSION(3, 1, 6):
 		case IP_VERSION(3, 2, 0):
@@ -5296,6 +5306,7 @@ get_plane_modifiers(struct amdgpu_device *adev, unsigned int plane_type, uint64_
 			add_gfx10_1_modifiers(adev, mods, &size, &capacity);
 		break;
 	case AMDGPU_FAMILY_GC_11_0_0:
+	case AMDGPU_FAMILY_GC_11_0_2:
 		add_gfx11_modifiers(adev, mods, &size, &capacity);
 		break;
 	}
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
index 71e6d98410fc..d76c8dfaf3f0 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
@@ -667,6 +667,7 @@ struct hdcp_workqueue *hdcp_create_workqueue(struct amdgpu_device *adev, struct
 
 		hdcp_work[i].hdcp.config.psp.handle = &adev->psp;
 		if (dc->ctx->dce_version == DCN_VERSION_3_1 ||
+		    dc->ctx->dce_version == DCN_VERSION_3_14 ||
 		    dc->ctx->dce_version == DCN_VERSION_3_15 ||
 		    dc->ctx->dce_version == DCN_VERSION_3_16)
 			hdcp_work[i].hdcp.config.psp.caps.dtm_v3_supported = 1;
-- 
2.35.3

