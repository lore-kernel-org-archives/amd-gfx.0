Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD3A5C74A5B
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Mar 2023 21:40:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 32C5310EB51;
	Thu, 23 Mar 2023 21:40:56 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2066.outbound.protection.outlook.com [40.107.94.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 54C4289612
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Mar 2023 21:40:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HpRHJr90PbR1AYB7iFDDL9CeECFuf/nPQCRnozh7/dRzgIjFc3GbOI/LitKa517v+PE5wrAVnBwUVD8HaaJ1BoO3wx3m8e9gtbXq3CAAsLUsbEfctKbpDBFXImboKS5RZ5sjQzTZOPVCQsZGJfad2gsGrub+wj70WfFLmKt1KiJDx3SeJkOAUR+qEIqcZMMcFlJhC9Y37TtXQiDg7NAi/tVPropqTDcUyYzZrO5jo5zLW+PYgj1Rp9mWzIy1k939ws5zYTg02A64pg4ByTky5Nf/lv8xQkKqpOcGGSXAH5cxc51i/m0gQsJ0luSsiL5kCAzKOnfr8rIuMTPC7dYMiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eWJ5Z/aU+yOnmuaUBP2O0+l7owFFx1x+tDKzLIvxfcE=;
 b=blFLL8aXGB+g1TNcFObNy7A+h7uhDZMG2UFLcxvTkctZUciMqp1G81SuSfrph4yHvEIN6QXU8qe6xnTYIyEpV3csBbSGN1LNe14DU4nV4nbN6DGsugZvAHi7mNTpcM6sithO2y2wGMEMDXWjV9Q0i+J8Uk2Hohm+Yc2td37eMxr3UzWfXs7KQAPew+fU5UkWQ75P3OW25yz1B0yhbqJKXw6Wv7NZW2GZxu3KipKDR36e5MZXPutt4Shq+wZrFnd+aq7L/vEvMuUDaCeksEVXyGdJRGOsywdNTUyTFC/nyUW6RhtvcKf2s4a79xmuYsHnVrG3dWjnxte27uW+WOSBkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eWJ5Z/aU+yOnmuaUBP2O0+l7owFFx1x+tDKzLIvxfcE=;
 b=vLC47lBRHcSOzeZYhlDNMfKgvZcV2SlRb+dD4k8ewTxPe5I2K85xatbI38WG1JK+yhEL/i7SQxoSxCaeoucCfzgOeCX2hr8fcQb0j6NFTGkzQYsLroR36lGEgFAb/8RSwky3Fh08FGuz1gliTmKzY5G9M9WPV+VF6ANgSO2ueX4=
Received: from DM6PR06CA0100.namprd06.prod.outlook.com (2603:10b6:5:336::33)
 by BY5PR12MB4949.namprd12.prod.outlook.com (2603:10b6:a03:1df::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Thu, 23 Mar
 2023 21:40:49 +0000
Received: from DM6NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:336:cafe::cd) by DM6PR06CA0100.outlook.office365.com
 (2603:10b6:5:336::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38 via Frontend
 Transport; Thu, 23 Mar 2023 21:40:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT048.mail.protection.outlook.com (10.13.173.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6222.17 via Frontend Transport; Thu, 23 Mar 2023 21:40:49 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 23 Mar
 2023 16:40:48 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 01/13] drm/amdgpu/gfx11: add FW version check for new CP GFX
 shadow feature
Date: Thu, 23 Mar 2023 17:40:22 -0400
Message-ID: <20230323214034.1169310-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230323214034.1169310-1-alexander.deucher@amd.com>
References: <20230323214034.1169310-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT048:EE_|BY5PR12MB4949:EE_
X-MS-Office365-Filtering-Correlation-Id: 63fe3b8a-66c9-44c5-6067-08db2be744dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uqbSYjl3SRdAPpnZ6I+goLdC3dHe5aaMh6YGgyE/DoJI22ao4OoHAklzdA6dKvjJKeK+K31v6M77zpYLp6BbYvXDDq0vjeB+obc85M317pN8Cc98GhNSWvoN/+zrtjLCEiACwuDCQjI+GqJPBINILkzunTt16lUeLGLjmAYc9qZW31fi1v5+uJK9fX06jRYI+8HSnp6OjvFIE93TwmAzxxjW5IPWWNv3isajkz4ys9XpMiOn0K4G9mRsSUlDD0EoOhd2KCiUvRdgNdvbX3QivTuRDo2+VBVQFNm2/jBSeGpxc2pZXkA8wYURPnbz5/T9r5aOhDdxbsDJz0emJo0RHZTrJkaEHGJuf7LCivIq9wGf1h8XsL/gvS+8w7xSwEw6bbJzZSUPo6Fth/Rxesfs9wgDg8842v9vFm/gvNIygiItn/zniIc+60Xe/L2o4iol/TDMgnsl3WJsPkPJo1icsucupkRrLxrxnlHySiiIhy+6yQl8shS4XpaFELOs3WkLxoqAoZAL0mQKYgaQbNaz7nkExpDm8ZdUDrm+K93v2nAUM8uPRsRl6Q4knHF0xHhmhXygEfQ/MclA55b+/qzXAwbo3sfavCHkcsDh3Ipi60AjK1lURqu6UBEQRHKEtPGd8/N6+5DgNDkgHYea6N7KPsfeodHioDKHPB1yc1GO4WWKqT9J8Jkg13jT+zHmvSpQZpIDxXEMU8rAvTjchYVHr6d7plySr0yRfjClncVs3bo=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(136003)(346002)(376002)(396003)(39860400002)(451199018)(46966006)(40470700004)(36840700001)(36756003)(40460700003)(6916009)(86362001)(8676002)(4326008)(70206006)(8936002)(70586007)(41300700001)(316002)(478600001)(7696005)(2906002)(5660300002)(82740400003)(36860700001)(40480700001)(26005)(81166007)(356005)(1076003)(6666004)(186003)(16526019)(82310400005)(426003)(2616005)(47076005)(336012)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2023 21:40:49.5008 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 63fe3b8a-66c9-44c5-6067-08db2be744dc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4949
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

Use this to determine if we support the new SET_Q_PREEMPTION_MODE
packet.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |  2 ++
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c  | 13 +++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index de9e7a00bb15..4ad9e225d6e6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -364,6 +364,8 @@ struct amdgpu_gfx {
 
 	struct amdgpu_ring		sw_gfx_ring[AMDGPU_MAX_SW_GFX_RINGS];
 	struct amdgpu_ring_mux          muxer;
+
+	bool				cp_gfx_shadow; /* for gfx11 */
 };
 
 #define amdgpu_gfx_get_gpu_clock_counter(adev) (adev)->gfx.funcs->get_gpu_clock_counter((adev))
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index ecf8ceb53311..a0d830dc0d01 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -463,6 +463,18 @@ static int gfx_v11_0_init_toc_microcode(struct amdgpu_device *adev, const char *
 	return err;
 }
 
+static void gfx_v11_0_check_fw_cp_gfx_shadow(struct amdgpu_device *adev)
+{
+	switch (adev->ip_versions[GC_HWIP][0]) {
+	case IP_VERSION(11, 0, 0):
+	case IP_VERSION(11, 0, 2):
+	case IP_VERSION(11, 0, 3):
+	default:
+		adev->gfx.cp_gfx_shadow = false;
+		break;
+	}
+}
+
 static int gfx_v11_0_init_microcode(struct amdgpu_device *adev)
 {
 	char fw_name[40];
@@ -539,6 +551,7 @@ static int gfx_v11_0_init_microcode(struct amdgpu_device *adev)
 	/* only one MEC for gfx 11.0.0. */
 	adev->gfx.mec2_fw = NULL;
 
+	gfx_v11_0_check_fw_cp_gfx_shadow(adev);
 out:
 	if (err) {
 		amdgpu_ucode_release(&adev->gfx.pfp_fw);
-- 
2.39.2

