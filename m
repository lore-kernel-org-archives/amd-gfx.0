Return-Path: <SRS0=2QJd=G6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FBA5C433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Jan 2021 08:17:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D22C52074F
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Jan 2021 08:17:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D22C52074F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 39A086E5AB;
	Wed, 27 Jan 2021 08:17:25 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2067.outbound.protection.outlook.com [40.107.244.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1EDFF6E5AB
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Jan 2021 08:17:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VW/YkmDA+F/pI5YVgK60BOIbOBGbQXWMtDmBIzEIHszTxRax82gzmbrAA7+P2iBvaXgQInWJx4HQmMyG/Crr/8YsgPFi07q3DMQEbnSDpQLL88xCjkFDwLxHfqhOzeAjVlRGfeO7Z7iIvB7rMWwEVSoYbakUnba8BV5sNN4VC7LiHKgEcsSBD7d13KiKxX+rezgi/C3Z+9/PM6LyvWfQasAAGLhEuoOADQL6lcx5/7PEcG81TOdihU9T2dqNFUSjBsBrA3soIbmR+hkNS0A5GKuTXQ+KSLZpIVEU1JD5i7QsDd36uyE3H9Xm9KVDHNkpx7lXU2QYJOn2pmrZ2rKmwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q9bFzw6uMQEjdsrmxsBBNxyyuzL6EQu7Ea8CPofL8t4=;
 b=LDzsVGtjUA5hehO7u7DUfzhkOM+y41eb1n3diN7YoX2FNQUCxdosDeFlykWmapftQoggCI8z62H4mz4at7s84VK7yDtHOu98oVmGVaO8CpTd7KQKRUd7zG2lqGYLnpqGho3E0O1imd1RCEAG9mRFeLYgXJ3itaOV9R8hVBkV2ieKBTgoAlTaPBKAlPdrRu/aiiVsAF6JMS2RZwhZaNIPNKOeMVJK4Am/i1zlZEiypSZn+Kncz7igdnm3OO+VcBT9/MDkV8nhiFILU0g1nUwGx6dIQ5v1jJ9ZSDUo/SjO+2uopjcG46C21gj5Z+EaJEfGeiP8lo4u0WeRsY5ub7VcgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q9bFzw6uMQEjdsrmxsBBNxyyuzL6EQu7Ea8CPofL8t4=;
 b=x2BcoHV/Dl7qmepwVk6R71azjPRJBAUcn5mRDnBKa3Mc8TodbJM5ACmQB6R/M8AauoqUrOy8ey7ZsZC21zoQhrDEXyd9C0pRo8c0fR6csN9cGJkI0Aq0Mo8H/0v3B4FTvmuJfBVqpKAunXjcL9nPCMl/0VoTThhKW/UpArj0E7E=
Received: from DM5PR21CA0054.namprd21.prod.outlook.com (2603:10b6:3:129::16)
 by SA0PR12MB4446.namprd12.prod.outlook.com (2603:10b6:806:71::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.11; Wed, 27 Jan
 2021 08:17:22 +0000
Received: from DM6NAM11FT040.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:129:cafe::28) by DM5PR21CA0054.outlook.office365.com
 (2603:10b6:3:129::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.1 via Frontend
 Transport; Wed, 27 Jan 2021 08:17:22 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM6NAM11FT040.mail.protection.outlook.com (10.13.173.133) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3784.12 via Frontend Transport; Wed, 27 Jan 2021 08:17:21 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 27 Jan
 2021 02:17:20 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 27 Jan
 2021 02:17:20 -0600
Received: from kenneth-u1804-kvm.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Wed, 27 Jan 2021 02:17:19 -0600
From: Kenneth Feng <kenneth.feng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] drm/amd/pm: Enable gfx DCS feature
Date: Wed, 27 Jan 2021 16:16:48 +0800
Message-ID: <20210127081648.28759-1-kenneth.feng@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9a615337-83fb-4d84-42c2-08d8c29bf867
X-MS-TrafficTypeDiagnostic: SA0PR12MB4446:
X-Microsoft-Antispam-PRVS: <SA0PR12MB44460D0E49663C8B8EAC89AE8EBB9@SA0PR12MB4446.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SEyGkz6FiYNHILCVSEYgU4JcvrHgHFWSKJR5SDJ8yk7fMf35KO6OKoOsQoXZw7xaI2XpyZEzmOMz0lDl+R8dl6pj8+iyt7RteB1pLrKZ4XOrh+2DkZGmxoeBYPqUwDifMji+zBSTNmL2iZiiAYVQWEO1SHDAg6Nq7BD+uHNfXJ9rN/+DvI3juxgYfAXDQvQzt6hGpecj+Uvyd4dAxSqFxHNNt8QRVOYj/dL+j2dv1rWFmIH2T6P0wpCinZUAM6IMpzoROn9FCdrzkOmzy7s/43KbcBE+R8Q2eQAH1hmm3qyyvZyF9cY04x3VfxlV8G//20Fu6awnB4a3t3aEQzlqu16+xTw3CWpG3wAuVZclBJUymFC3B1FrKlwK/2ETF9OPdKxiU/Vz29mRsj7WYum2aS15oAC4Iq3kHDEAx0U5RRjhZymEUE7s9kHF4INF2BLFP9Ne76VP5rYsQtHdbkJnMOCLqsicgh2J9fHBcktc+TATxq/z+OxiT3r1hutB+YX8csLkavCwZKCeCBUt7bB2fwMBnmnmtHfpA7XmL36x55i5l5nw0tPGDUnd8pMzapUCQ9PwMjiVKRkpLte7GQtIYMqwWK35U1nOUzhmxLkUSl92ELAzz52bZSuIRJtLmzxJ
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(346002)(376002)(396003)(136003)(39860400002)(46966006)(7696005)(6666004)(81166007)(83380400001)(26005)(8676002)(6916009)(8936002)(426003)(336012)(82310400003)(316002)(54906003)(2906002)(2616005)(70206006)(86362001)(186003)(36756003)(4326008)(70586007)(5660300002)(47076005)(356005)(478600001)(1076003)(82740400003)(44832011)(36610700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2021 08:17:21.5112 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a615337-83fb-4d84-42c2-08d8c29bf867
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT040.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4446
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
Cc: tao.zhou1@amd.com, Kenneth Feng <kenneth.feng@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Background:
Gfx Duty Cycle Scaling(DCS) is applied on the small power limit skus.
When the current/power/temperature exceeds the limit with the heavy workload,
the gfx core can be shut off and powered on back and forth.
The ON time and OFF time is determined by the firmware according to
the accumulated power credits.
This feature is different from gfxoff.Gfxoff is applied in the idle case
and DCS is applied in the case with heavey workload.There are two types of DCS:
Async DCS and Frame-aligned DCS.Frame-aligned DCS is applied on 3D fullscreen
and VR workload.
Since we only supports Async DCS now,disalbe DCS when the 3D fullscreen or
the VR workload type is chosen.

Verification:
The power is lowerer or the perf/watt is increased in the throttling case.
To be simplified, the entry/exit counter can be observed from the firmware.

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c              |  8 ++++++--
 drivers/gpu/drm/amd/include/amd_shared.h             |  1 +
 .../gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c  | 12 ++++++++++++
 3 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 82c2fa8a67cd..186bbe139bde 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -131,8 +131,12 @@ uint amdgpu_pg_mask = 0xffffffff;
 uint amdgpu_sdma_phase_quantum = 32;
 char *amdgpu_disable_cu = NULL;
 char *amdgpu_virtual_display = NULL;
-/* OverDrive(bit 14) disabled by default*/
-uint amdgpu_pp_feature_mask = 0xffffbfff;
+
+/*
+ * OverDrive(bit 14) disabled by default
+ * GFX DCS(bit 19) disabled by default
+ */
+uint amdgpu_pp_feature_mask = 0xfff7bfff;
 uint amdgpu_force_long_training;
 int amdgpu_job_hang_limit;
 int amdgpu_lbpw = -1;
diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd/include/amd_shared.h
index 9676016a37ce..43ed6291b2b8 100644
--- a/drivers/gpu/drm/amd/include/amd_shared.h
+++ b/drivers/gpu/drm/amd/include/amd_shared.h
@@ -213,6 +213,7 @@ enum PP_FEATURE_MASK {
 	PP_ACG_MASK = 0x10000,
 	PP_STUTTER_MODE = 0x20000,
 	PP_AVFS_MASK = 0x40000,
+	PP_GFX_DCS_MASK = 0x80000,
 };
 
 enum DC_FEATURE_MASK {
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 24f3c96a5e5e..dffdcebc80e1 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -261,6 +261,9 @@ sienna_cichlid_get_allowed_feature_mask(struct smu_context *smu,
 		*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DPM_GFX_GPO_BIT);
 	}
 
+	if ((adev->pm.pp_feature & PP_GFX_DCS_MASK) && adev->asic_type > CHIP_SIENNA_CICHLID)
+		*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_GFX_DCS_BIT);
+
 	if (adev->pm.pp_feature & PP_MCLK_DPM_MASK)
 		*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DPM_UCLK_BIT)
 					| FEATURE_MASK(FEATURE_MEM_VDDCI_SCALING_BIT)
@@ -1437,6 +1440,15 @@ static int sienna_cichlid_set_power_profile_mode(struct smu_context *smu, long *
 	smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetWorkloadMask,
 				    1 << workload_type, NULL);
 
+	/* have to disable dcs if it's the 3D fullscreen or VR workload type */
+	if ((smu->adev->pm.pp_feature & PP_GFX_DCS_MASK) &&
+	    smu->adev->asic_type > CHIP_SIENNA_CICHLID) {
+		ret = smu_cmn_feature_set_enabled(smu, SMU_FEATURE_GFX_DCS_BIT, (workload_type ==
+			WORKLOAD_PPLIB_FULL_SCREEN_3D_BIT || workload_type == WORKLOAD_PPLIB_VR_BIT) ? 0 : 1);
+		if (ret)
+			return ret;
+	}
+
 	return ret;
 }
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
