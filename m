Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F37F3ECAAD8
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Sep 2022 04:57:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 986EB10E82C;
	Wed, 21 Sep 2022 04:57:04 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2042.outbound.protection.outlook.com [40.107.223.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E9B6810E828
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Sep 2022 04:56:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=esPr0G20qybuTts0r0vszre8vaF09TafophEf8RmIAuJruQjX+39XnBAwp/D1SnqI5ICku+OkE0kfdSpwWfYbExgt7SeCgdz0rsdu90mE5j0HNnhJKxwahOp2MmhYScYkkRS4P5PL1SbDQhXe4Spe70CCDjvWcCS3yKm2dqx9N/NZgsb8bBcznIbDDqFiwHlfb14C1bDOJM4tFo4Ukq1QwnZPTNIg/4QwWQHWzSSLLvS37/xQLJfD6lOoh5cAbvhUwI1X6HN9XZC+E2A/IDqfIDLYESbXKO+XpCLVPwEuDoGDSfba+pxZW3pIj+ZlZK53Hy7wVn9GEw38/0rzo0KlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PMJVpSUwZzNko7cdgpQBPHGlZO/TBd0Q5AZX9gHWJ4Y=;
 b=Pqm05X9YLo80MXEXY1wGR1IL6WJKsa8nZgz0wr11EQIpld64vvgDjvK/Tb6kshwwrAZv6kt9HnHKSTeoOj+T8wMjvjlHvmmPj/sH1TgFv+28vvPDXVgsnnUdbWs3l8lR485VZYD68DZ7gOtMa2iF1e7SYTJZrCboL5jjM+LX4HBUFr05KLFJco2Cn4sNNM8Vs8gAidWRJA6S2oAawQK1EwRtK0Qg0bwB9ow+B8lUZwUvpNpQawOC+F7O83UTuIGoT/7CmSyq1U4uiFvdSGJaPDuw+vV+f++88KJDGh3dIw3wKdXsJMBXXotMcFXMjzJIZhKh6vDOs5/hb/hJNREtGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PMJVpSUwZzNko7cdgpQBPHGlZO/TBd0Q5AZX9gHWJ4Y=;
 b=u/BTQncJ9E+clAVkexWqbDimgnRQbn85dAazUy03elNQ349BCfOh5YUo6UsahsXwfAhhAsSLIpDE0/JlOb7K5qhzScXUBOcaU5EYNPuXRtYrSBbkb/7vaIvVTQmjIs61dL5DgnJCMc0915RYKQPcm45ytZMLRHc7oGSK6Ss0fMI=
Received: from BN1PR13CA0023.namprd13.prod.outlook.com (2603:10b6:408:e2::28)
 by BL1PR12MB5705.namprd12.prod.outlook.com (2603:10b6:208:384::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21; Wed, 21 Sep
 2022 04:56:52 +0000
Received: from BN8NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e2:cafe::9e) by BN1PR13CA0023.outlook.office365.com
 (2603:10b6:408:e2::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.14 via Frontend
 Transport; Wed, 21 Sep 2022 04:56:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT017.mail.protection.outlook.com (10.13.177.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5654.14 via Frontend Transport; Wed, 21 Sep 2022 04:56:52 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 20 Sep
 2022 23:56:50 -0500
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/3] drm/amd/pm: use adverse selection for dpm features
 unsupported by driver
Date: Wed, 21 Sep 2022 12:56:23 +0800
Message-ID: <20220921045623.43401-3-evan.quan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220921045623.43401-1-evan.quan@amd.com>
References: <20220921045623.43401-1-evan.quan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT017:EE_|BL1PR12MB5705:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a97b35d-2290-4903-70af-08da9b8db345
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oS4wVPgxS4H5Z3Wpoqbzvk/c+Th/wZ1ao+5UslCQHrp0BgRm9HTnIYV9O0yWdiq8RnQJ7GtLEYV0xWprxetvHtxF5uiLPjz5CJyX3Divqc+nhPPiAUvl8Ch58gMe5Dc9L3duxQMiJEkUz0+5xhRvppw5nfncE12XdYhoN0ijcQMJ+CSMRmMFlADMSmk3+XdBD+HHk/Ya1/mqbx5afmj5voiTT3wBmaVg3z2BE20yWsd21WM4Vdaruqr9If7tS5FLR8QjocS1H+w/onotvOLn+NTdzY0OkTFgWStQfMe4voPC5G1zSdyLFmztghPgNVc3eXWRGNEd5ltbjHc4bbPStPEFSbMyaPl7GexJH0sX6CYbyfnj9L6VjZYCG58L8BgqD5N50f/AGPdg66OXzzHmipqpU2YhaQjXaF0mcGx+j2BbfTFlrJ68g2dFX3xszDBWhpBYwRpTKRBpLfe91RVyjGDywUUjKkPYGsqxi/RdEalMAL6ehQBg3Ui3U2t3837vVgyMYDdNGQcdQyedij6d2fcM6GXq9m+ArT+l5BUuGojSdqdEZhOh6eNJqt81fTcy8AXtucZb2vjpyd9Pi0KqBN2RQaDrVoRHhQAPAHLHa904wttpj21TLa1sGjDnk/d2McUxvvlycVYgPf5BntehnHpAhSTrN143PQIhl1FCNxyt2JSxa8FBQZEEDCO89xqsPAopCJGdXp+ktMv8LBGFgSsqb0Zyb9U6xka8fCRyfDK3NLoQE9v8Fw48u3JoOgp47ed+rQq5WhRt53BPdJini2YZcoYAHRj/1azBFOyK6Y44M595jnImbw9186649xS+
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(346002)(39860400002)(376002)(396003)(451199015)(46966006)(36840700001)(40470700004)(44832011)(82740400003)(40460700003)(8676002)(356005)(36756003)(81166007)(2906002)(5660300002)(478600001)(82310400005)(6916009)(40480700001)(47076005)(54906003)(8936002)(316002)(70206006)(70586007)(36860700001)(16526019)(186003)(1076003)(86362001)(83380400001)(41300700001)(4326008)(336012)(6666004)(2616005)(7696005)(26005)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2022 04:56:52.6088 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a97b35d-2290-4903-70af-08da9b8db345
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5705
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
Cc: Alexander.Deucher@amd.com, Evan Quan <evan.quan@amd.com>,
 hawking.zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

It's vbios and pmfw instead of driver who decide whether some dpm features
is supported or not. Driver just de-selects those features which are not
permitted on user's request. Thus, we use adverse selects model.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Change-Id: I184ca0950e75d47ed20895f2643ddfa31417dc22
---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  | 85 ++++++-------------
 1 file changed, 24 insertions(+), 61 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index 03b732bf8cd0..1d454485e0d9 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -244,79 +244,42 @@ smu_v13_0_0_get_allowed_feature_mask(struct smu_context *smu,
 	if (num > 2)
 		return -EINVAL;
 
-	memset(feature_mask, 0, sizeof(uint32_t) * num);
+	memset(feature_mask, 0xff, sizeof(uint32_t) * num);
 
-	*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_FW_DATA_READ_BIT);
-
-	if (adev->pm.pp_feature & PP_SCLK_DPM_MASK) {
-		*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DPM_GFXCLK_BIT);
-		*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_GFX_IMU_BIT);
+	if (!(adev->pm.pp_feature & PP_SCLK_DPM_MASK)) {
+		*(uint64_t *)feature_mask &= ~FEATURE_MASK(FEATURE_DPM_GFXCLK_BIT);
+		*(uint64_t *)feature_mask &= ~FEATURE_MASK(FEATURE_GFX_IMU_BIT);
 	}
 
-	*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_MM_DPM_BIT);
-	*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DS_VCN_BIT);
-
-	if ((adev->pg_flags & AMD_PG_SUPPORT_ATHUB) &&
-	    (adev->pg_flags & AMD_PG_SUPPORT_MMHUB))
-		*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_ATHUB_MMHUB_PG_BIT);
+	if (!(adev->pg_flags & AMD_PG_SUPPORT_ATHUB) ||
+	    !(adev->pg_flags & AMD_PG_SUPPORT_MMHUB))
+		*(uint64_t *)feature_mask &= ~FEATURE_MASK(FEATURE_ATHUB_MMHUB_PG_BIT);
 
-	if (adev->pm.pp_feature & PP_SOCCLK_DPM_MASK)
-		*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DPM_SOCCLK_BIT);
+	if (!(adev->pm.pp_feature & PP_SOCCLK_DPM_MASK))
+		*(uint64_t *)feature_mask &= ~FEATURE_MASK(FEATURE_DPM_SOCCLK_BIT);
 
 	/* PMFW 78.58 contains a critical fix for gfxoff feature */
 	smu_cmn_get_smc_version(smu, NULL, &smu_version);
-	if ((smu_version >= 0x004e3a00) &&
-	    (adev->pm.pp_feature & PP_GFXOFF_MASK))
-		*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_GFXOFF_BIT);
-
-	*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_THROTTLERS_BIT);
-	*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_FAN_CONTROL_BIT);
-
-	*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DF_CSTATE_BIT);
-
-	if (adev->pm.pp_feature & PP_MCLK_DPM_MASK) {
-		*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DPM_UCLK_BIT);
-		*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_VMEMP_SCALING_BIT);
-		*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_VDDIO_MEM_SCALING_BIT);
+	if ((smu_version < 0x004e3a00) ||
+	     !(adev->pm.pp_feature & PP_GFXOFF_MASK))
+		*(uint64_t *)feature_mask &= ~FEATURE_MASK(FEATURE_GFXOFF_BIT);
+
+	if (!(adev->pm.pp_feature & PP_MCLK_DPM_MASK)) {
+		*(uint64_t *)feature_mask &= ~FEATURE_MASK(FEATURE_DPM_UCLK_BIT);
+		*(uint64_t *)feature_mask &= ~FEATURE_MASK(FEATURE_VMEMP_SCALING_BIT);
+		*(uint64_t *)feature_mask &= ~FEATURE_MASK(FEATURE_VDDIO_MEM_SCALING_BIT);
 	}
 
-	*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_MEM_TEMP_READ_BIT);
-
-	if (adev->pm.pp_feature & PP_SCLK_DEEP_SLEEP_MASK)
-		*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DS_GFXCLK_BIT);
-	*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DS_SOCCLK_BIT);
-	*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_SOC_MPCLK_DS_BIT);
-	*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_BACO_MPCLK_DS_BIT);
+	if (!(adev->pm.pp_feature & PP_SCLK_DEEP_SLEEP_MASK))
+		*(uint64_t *)feature_mask &= ~FEATURE_MASK(FEATURE_DS_GFXCLK_BIT);
 
-	*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DPM_FCLK_BIT);
-	*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DPM_DCN_BIT);
-	*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DS_DCFCLK_BIT);
-
-	if (adev->pm.pp_feature & PP_PCIE_DPM_MASK) {
-		*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DPM_LINK_BIT);
-		*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DS_LCLK_BIT);
+	if (!(adev->pm.pp_feature & PP_PCIE_DPM_MASK)) {
+		*(uint64_t *)feature_mask &= ~FEATURE_MASK(FEATURE_DPM_LINK_BIT);
+		*(uint64_t *)feature_mask &= ~FEATURE_MASK(FEATURE_DS_LCLK_BIT);
 	}
 
-	*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_BACO_BIT);
-
-	*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DPM_MP0CLK_BIT);
-	*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_FW_DSTATE_BIT);
-
-	*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_OUT_OF_BAND_MONITOR_BIT);
-	*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_SOC_CG_BIT);
-
-	*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DS_FCLK_BIT);
-
-	*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_FW_CTF_BIT);
-
-	*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DS_UCLK_BIT);
-
-	*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_VR0HOT_BIT);
-
-	*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DPM_GFX_POWER_OPTIMIZER_BIT);
-
-	if (adev->pm.pp_feature & PP_ULV_MASK)
-		*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_GFX_ULV_BIT);
+	if (!(adev->pm.pp_feature & PP_ULV_MASK))
+		*(uint64_t *)feature_mask &= ~FEATURE_MASK(FEATURE_GFX_ULV_BIT);
 
 	return 0;
 }
-- 
2.34.1

