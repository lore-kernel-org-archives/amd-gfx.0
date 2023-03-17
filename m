Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25925C7618A
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Mar 2023 17:18:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5EE5E10E116;
	Fri, 17 Mar 2023 17:18:13 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2072.outbound.protection.outlook.com [40.107.244.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F297610E10E
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Mar 2023 17:18:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m78bR8ARUS2smtrTxFI8aIB8q1x5ZDI6eu8VjCdcSWpD94dRuOvkhizZQN2dd0jkn5XtRqwiy21lpQmIP1MlxvreOWc+8pRHsliLTCddUzw4qvTyFqO+quLNBTbquHPOSJyDb7D0td0Wlh2cWTT5okVgFOEQkmhaEnAeSBTsNRD5nUKdtSvMddJEyHzy6qRtlA9Aym8IOdHThelBZUaV98CR6kjNS1+NKCDqI2ZJ+1mt75LNS4OSCalqmlbJiLdK7YKCHKXP0G3uljnJSD0oEeV87CMCu92FJQ2ugu3aoaIotVID+tNSSrAEfdm8fEbLwvfAyA5p93cJxEdXy/smsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2JC6XwrMmzeLRJJ8YCNgb+o7P5+DIvUfNc9i29Rbk1o=;
 b=bMjNiWBb1jpT/DkN9QmfodnxN6Bn//jUU4F22dRqakB8xEnzKIHUciVqX33VxpzedRmfRzCc9fTvpHVR/vwC3ffYoPM6b7OKdoDT5qgk1QB3XqtLkZBK6LDI01zc57VPSMj2ywjNHWFQDs+m/GoKj9NvTRXuHzbn+R42vvE3/TYERXTV0MW7KDjFXT+AUL08SSJsBCwe8M87byrZTzpSAOcyGgwELuw13DhzDmB0OPK6e824yv4JcU+f2MtwB6vrEGSHELt751/Oj/EkQqJyZzh/w80DVRi8hWjW05Tjrt9CUpfAVYbYMW32smZW2bf/rVlRG+z7FZX2FHArxz1SyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2JC6XwrMmzeLRJJ8YCNgb+o7P5+DIvUfNc9i29Rbk1o=;
 b=sPnFejN2DNQkgAJa4mSUbSNNCKUoZXKfgcB6tivVjuXIE3VyfsppXuStk0VDobmChLIZoT+QYReCPuKeAjgW/jmFBR9gLKegg3D3VaPFZo5mipc/NOD+A/Ndo3X9GncTmozMAaRglZD/gIP+MySHkc547rHhAxt17EjD4lSZqKo=
Received: from DS7PR03CA0169.namprd03.prod.outlook.com (2603:10b6:5:3b2::24)
 by DS0PR12MB8527.namprd12.prod.outlook.com (2603:10b6:8:161::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.29; Fri, 17 Mar
 2023 17:18:04 +0000
Received: from DM6NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b2:cafe::af) by DS7PR03CA0169.outlook.office365.com
 (2603:10b6:5:3b2::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.35 via Frontend
 Transport; Fri, 17 Mar 2023 17:18:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT014.mail.protection.outlook.com (10.13.173.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6199.20 via Frontend Transport; Fri, 17 Mar 2023 17:18:04 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 17 Mar
 2023 12:18:03 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 01/10] drm/amdgpu: add UAPI to query GFX shadow sizes
Date: Fri, 17 Mar 2023 13:17:39 -0400
Message-ID: <20230317171748.682691-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230317171748.682691-1-alexander.deucher@amd.com>
References: <20230317171748.682691-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT014:EE_|DS0PR12MB8527:EE_
X-MS-Office365-Filtering-Correlation-Id: 88cd98ce-75b1-47a9-5a40-08db270b918f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ClPShd3ifd+lpk9lu0moU2BCTFPXQq2Zv3Duxjwir+nZpIPz+uy7uQA2qSxx3ZOA33Bw1f7ZmuUyZYVD7IDd8U9nu8iedQ8VutlZezmemDaoYaukJGQpko4Xe9ewKqkkHRiBP6/YlvMWrZY1fzJQXGoognFmY5+ueQuM/9hV/+E8zLW4S4lAVV97TEP33kIqxBKg61kXfiYW8d/ZskmFwysqZbyIKzAuX/pF+GEPbPAiW9gaFzb3MM/uyNlCU9u67i4SmjQGO+jEFS8JVQ0zU1ivLQmBXDNKaadDCxDO302eK5gz6vd99WIiRlLAKRP4q7IvHlaX8Tbs4OktQbTLXH0BaKFb4HVyB7BRpqYno4fulxE/48GQGjxzzAgGwnTcjOs5ZgmK/gCnTvOdUoIcc8PM+fuXtP8HBeYwEAQzc0PtxLsqhlAQsfLKB3c25jNip6V5JEcMKWZmu638TJgDMh2H81GFnEK8IN/tsbfESSoP/1MlFM964e0IAT0/Qkqb1lO/L3w6trW2DU6wXSqO4EBEdi4z72C/jMxCPWwz6d40yh4QceZumt12az/J8oor2shD64kJjSF5fOFbAwrPhcwvrHo1/VMQvB1NrCq8ypBVw29Y8RerPQYp6Czp0z1+1sAR1zgaHivTp6KfnZ1nYXnfbTRYpuMZ6hgmh9teX6Dy448jsligLc3OG/pf7U0FyfcYpsnaqxTwOUOrsr6f6NLO3RKaVzPweBzJ0GY05NE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(136003)(376002)(396003)(346002)(39860400002)(451199018)(40470700004)(36840700001)(46966006)(8676002)(186003)(478600001)(6666004)(47076005)(336012)(426003)(16526019)(2616005)(70586007)(316002)(70206006)(7696005)(26005)(1076003)(41300700001)(4326008)(6916009)(2906002)(36860700001)(8936002)(5660300002)(81166007)(82740400003)(356005)(40460700003)(82310400005)(86362001)(36756003)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2023 17:18:04.2490 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88cd98ce-75b1-47a9-5a40-08db270b918f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8527
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add UAPI to query the GFX shadow buffer requirements
for preemption on GFX11.  UMDs need to specify the shadow
areas for preemption.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 include/uapi/drm/amdgpu_drm.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index b6eb90df5d05..cb22bb78c373 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -876,6 +876,7 @@ struct drm_amdgpu_cs_chunk_data {
 	#define AMDGPU_INFO_VIDEO_CAPS_DECODE		0
 	/* Subquery id: Encode */
 	#define AMDGPU_INFO_VIDEO_CAPS_ENCODE		1
+#define AMDGPU_INFO_CP_GFX_SHADOW_SIZE		0x22
 
 #define AMDGPU_INFO_MMR_SE_INDEX_SHIFT	0
 #define AMDGPU_INFO_MMR_SE_INDEX_MASK	0xff
@@ -1193,6 +1194,15 @@ struct drm_amdgpu_info_video_caps {
 	struct drm_amdgpu_info_video_codec_info codec_info[AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_COUNT];
 };
 
+struct drm_amdgpu_info_cp_gfx_shadow_size {
+	__u32 shadow_size;
+	__u32 shadow_alignment;
+	__u32 csa_size;
+	__u32 csa_alignment;
+	__u32 gds_size;
+	__u32 gds_alignment;
+};
+
 /*
  * Supported GPU families
  */
-- 
2.39.2

