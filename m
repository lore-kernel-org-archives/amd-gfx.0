Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C0EFE8FDD1
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Oct 2023 07:40:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B691410E33F;
	Wed,  4 Oct 2023 07:40:07 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2066.outbound.protection.outlook.com [40.107.94.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E9F8510E33D
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Oct 2023 07:40:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wh6WHrH/guErUsA22/KSJCJlLy6+Dn+Xy/XOSZUp3xH1hFiou9uckP8RYRrXzoO+zfbF/zqNdiweGJCRBHehHIpPsjiRbFELIFiZHK0T5pZAU4XppMv6PEOQMaKDInoePUQKR94INk6MPf6Zc58MH0zb3sxQ3uYB4nSDG+4w2Gvs34Y9miyx2iy+++PzJODPQLQqGhzM2QYW7mkzAjH/CB1nOeYpjx1YkHJq1SLQMpPWs4pMXyDVZtZuNHjqs4604gwsE1lepK8DbjBfl+KRrQmisHPOvc3jMXgex0t036wZfT9rSbUXVtIfHGsc+YTdLJkMol2IIHRgbmARUubIOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GLB8we2ZJfBKyhG4V0XBkIwKjRtTbMoDwFPmqjgZyBA=;
 b=Xbs3BV+Wt3dT4co5WLARrlT0xabOzGVvKXeEwPbmGSvHUO/tK3txDmpVBorlShnoQxvS8bNl+7EBT8ZJYa9SB9HPgOeiqlNh6lgWt6/GMAQoY6yQDJHef/O7u7apHM/A62TWeLr7cDuVUQjv/g5btpPeOGbZxCSVEKraS+6nVJtDNm9sqz179BVdqfM06dyb+/pX+NhWyX6Dz4JiY9iilSyyWeEZrC/0RfnSR6gRpfMvbiPxng6lZIHYg/QpO4mDlVVuRF0N6LH+FbiA8C3/tEdaP+GIjeH/pFBzS8p8H9tUZjmVylfi0w660BT2gzRA15HcfKst5nXpxNU7pCgSOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GLB8we2ZJfBKyhG4V0XBkIwKjRtTbMoDwFPmqjgZyBA=;
 b=nPTT0uYz1ImN8N9+dqZovNfJrhufmTbk2of38hYQfkRUcPFikELPMcR9IoCCMqUzf7/d+UqvOCh2empR+osjpiFCSeuEB1uIiJqQfwSmO6SoRAMOQDqrNjhLRBspbUfC5NpXwR+0Yz5N/owTNIEZu2r8hdly0OxBdk3nTg6JroI=
Received: from CH0P220CA0005.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:ef::8) by
 IA1PR12MB7662.namprd12.prod.outlook.com (2603:10b6:208:425::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.24; Wed, 4 Oct
 2023 07:40:04 +0000
Received: from DS2PEPF00003439.namprd02.prod.outlook.com
 (2603:10b6:610:ef:cafe::2f) by CH0P220CA0005.outlook.office365.com
 (2603:10b6:610:ef::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.25 via Frontend
 Transport; Wed, 4 Oct 2023 07:40:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003439.mail.protection.outlook.com (10.167.18.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Wed, 4 Oct 2023 07:40:03 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 4 Oct
 2023 02:40:01 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 3/5] drm/amdgpu: Get package types for smuio v13.0
Date: Wed, 4 Oct 2023 13:09:39 +0530
Message-ID: <20231004073941.1489693-3-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231004073941.1489693-1-lijo.lazar@amd.com>
References: <20231004073941.1489693-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003439:EE_|IA1PR12MB7662:EE_
X-MS-Office365-Filtering-Correlation-Id: 3062a5aa-2691-43be-92c2-08dbc4ad1f47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PXIGglbnf7NKZMp9qPZgaYKCb8d4wuTAh1UYXFONFFW5USsr2LLQaH3p6u0Pp4XUKTEOuP42J2ZCh3dQlc/+fiJZURVoOvm+4sqcoAgGW2kpLRSjlyGhY56Tsf39+2lnPc+c7i0NkNAEWmypX6rRzT0TFYjx3L/c7/lTjDFixClqbjYkjQz1moGSQIuGEOnnb94MGm5lNMaECkJnYzKGNCkNkdZQY/nqy5uXuUXYPj9uXMj4f9TYE0ZKAsWwSJYp8s2i6PbjLqk2TT/1OQ34Q5rQcPJ4q7HAsdqIyUs+51kkcDsXYMXIl14J9neL1e3Rn0ealS9EBn5iPi3MlnaKcdax5L8LyeYUC+YoxdKWwiVuYN+G7BHcap0WwJUBEOOcYK7zWyvV7fI/A8hsK8pFnSorY1yJPGMXvfrnsyRXTxrsMMbg+/Lera4DtB34H4Sp25TYvdHkAGxYRGTjmQIwAk/GR42+9uLF2cIfI4irfqLj4gF0lI4yHAMsW95GUHtrEmbFac9PLWT9xcTX5fB9qNPrV9hfZy/Cfyo7Qb2GvvPy8e11yERsQfliIFbme29cUetc5sMR2SE78rvlaAox1ZNEyrNDAoSEUVChnga16xhF8ca1x/XBq4WzLzLomeM1hxFmAXiWVJF/pLhdkErO3OQ9THSwkYtKpwAbuuLHuISVt1WnPn36CJm9Vcj2ohKcdq026+IPqO/yvRTn4z+XaFjusg5auLIZOuaO27qsC2t/b9lkEvWIabF9NZUO3D6spkIwveBGbD52HRrzPn+2vA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(376002)(346002)(39860400002)(396003)(230922051799003)(186009)(1800799009)(82310400011)(64100799003)(451199024)(40470700004)(36840700001)(46966006)(478600001)(8676002)(2616005)(7696005)(16526019)(336012)(316002)(47076005)(426003)(44832011)(5660300002)(70206006)(6916009)(41300700001)(70586007)(54906003)(26005)(8936002)(1076003)(4326008)(356005)(40480700001)(86362001)(40460700003)(81166007)(2906002)(36756003)(36860700001)(82740400003)(6666004)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 07:40:03.5602 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3062a5aa-2691-43be-92c2-08dbc4ad1f47
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003439.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7662
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add support to query package types supported in smuio v13.0 ASICs.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/smuio_v13_0.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/smuio_v13_0.c b/drivers/gpu/drm/amd/amdgpu/smuio_v13_0.c
index 13e905c22592..bf8b8e5ddf5d 100644
--- a/drivers/gpu/drm/amd/amdgpu/smuio_v13_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/smuio_v13_0.c
@@ -128,6 +128,27 @@ static bool smuio_v13_0_is_host_gpu_xgmi_supported(struct amdgpu_device *adev)
 	return data ? true : false;
 }
 
+static enum amdgpu_pkg_type smuio_v13_0_get_pkg_type(struct amdgpu_device *adev)
+{
+	enum amdgpu_pkg_type pkg_type;
+	u32 data;
+
+	data = RREG32_SOC15(SMUIO, 0, regSMUIO_MCM_CONFIG);
+	data = REG_GET_FIELD(data, SMUIO_MCM_CONFIG, TOPOLOGY_ID);
+
+	switch (data) {
+	case 0x4:
+	case 0xC:
+		pkg_type = AMDGPU_PKG_TYPE_CEM;
+		break;
+	default:
+		pkg_type = AMDGPU_PKG_TYPE_OAM;
+		break;
+	}
+
+	return pkg_type;
+}
+
 const struct amdgpu_smuio_funcs smuio_v13_0_funcs = {
 	.get_rom_index_offset = smuio_v13_0_get_rom_index_offset,
 	.get_rom_data_offset = smuio_v13_0_get_rom_data_offset,
@@ -136,4 +157,5 @@ const struct amdgpu_smuio_funcs smuio_v13_0_funcs = {
 	.is_host_gpu_xgmi_supported = smuio_v13_0_is_host_gpu_xgmi_supported,
 	.update_rom_clock_gating = smuio_v13_0_update_rom_clock_gating,
 	.get_clock_gating_state = smuio_v13_0_get_clock_gating_state,
+	.get_pkg_type = smuio_v13_0_get_pkg_type,
 };
-- 
2.25.1

