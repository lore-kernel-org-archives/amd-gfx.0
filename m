Return-Path: <SRS0=2QJd=G6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B97F6C433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Jan 2021 01:42:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 662C7206A4
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Jan 2021 01:42:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 662C7206A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D5E8B8967A;
	Wed, 27 Jan 2021 01:42:23 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2047.outbound.protection.outlook.com [40.107.220.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 327BE8967A
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Jan 2021 01:42:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MTf5id5RM9jpB8b5cEAklN/MbpGPPaQ74KtZ7TBFJWP0BBOFC4BkfeAM6L6fQb7G/tZrnzt10BPiCgptoe8byfr1CGRLeTiYrS9HG5u2+vXympJBMDsoryTEGSMSXYkbHyTyGbfSKIeEweUQa/wr5PbFkzJAhumEi/I+t3NC4VjzQYtca9IGl98QIAyUcJREuLrlNYx9CyaklfWUMSx6YimLsvR+9jXZ2KPScARTXyGcRtpaSDsW4LDVzy5fI3rzNd2tsKDtbjOO64ycq5O/y4zircgo1f6ZILA6JfYAxcs5VPs0c49/mKWx0FiZMt6CfoVao9K8MY9fpyEqan4SWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RVffawLyB2yKjEmJ1QknKtvkHxto4f8eZmrF5E1hhS4=;
 b=fyBk3j65kH5e8PtrlmGYKLuO37TkZrs174hZcP8xDlTXs5sDH7u/Wh3XsxBRaGpqUIRXvXGIcpOL9xnFPli9GVztPsNIZoqmyL4qN+bFfGtjD+ka49RHDdADwC0Y3gUv0KdAbU9jPkiT2gmb3Sajdyd73n5YcKHZ5bRHORxFJeN+d4js/3o4tX8aDhiSt6EnOAiNrAzRdgLK2E3tMmbCsmyZinkEUGu/wNkeFgVBFEUj0EGaecsn20iVsbvuWSRfAFHuv2vsiB7yLdR/7aTygcXfbKYMRkH3F1RaO5TlpOkccDW6WksZuh/q/Jb+MY+u03FHK7WpKt5QM4AqAmvxUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RVffawLyB2yKjEmJ1QknKtvkHxto4f8eZmrF5E1hhS4=;
 b=ua8Hs1rUHKWORV/mgB/OELuthXDxHgGAYlbjqg/Omo8FkntHUKPx9Y1qxdcN6JFLAyZG49Upmds7Zvo9lp7JdJGvhKpHn9PqzidIWf5HBe5m55R3GnAY2HH/WuJj8cWyyAaC3KrM6zagWSanhqwsPz2d05J/txAmw50sGNy710Y=
Received: from MWHPR04CA0041.namprd04.prod.outlook.com (2603:10b6:300:ee::27)
 by MW2PR12MB2459.namprd12.prod.outlook.com (2603:10b6:907:c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.11; Wed, 27 Jan
 2021 01:42:19 +0000
Received: from CO1NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:ee:cafe::a5) by MWHPR04CA0041.outlook.office365.com
 (2603:10b6:300:ee::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.14 via Frontend
 Transport; Wed, 27 Jan 2021 01:42:19 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT009.mail.protection.outlook.com (10.13.175.61) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3784.12 via Frontend Transport; Wed, 27 Jan 2021 01:42:17 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Tue, 26 Jan
 2021 19:42:16 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Tue, 26 Jan
 2021 19:42:16 -0600
Received: from kenneth-u1804-kvm.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Tue, 26 Jan 2021 19:42:15 -0600
From: Kenneth Feng <kenneth.feng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: Enable gfx DCS feature
Date: Wed, 27 Jan 2021 09:41:46 +0800
Message-ID: <20210127014146.10902-1-kenneth.feng@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8d247587-115c-47a5-c758-08d8c264c7ad
X-MS-TrafficTypeDiagnostic: MW2PR12MB2459:
X-Microsoft-Antispam-PRVS: <MW2PR12MB2459B9F7D4D9796AB7658F288EBB9@MW2PR12MB2459.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yLCY+cYdP6J/oItYFDNKwzb5CqPN1FuI5CfXIRCRZ53sZOFJVsDm1xs4IvKATVjguLeH0aXMovJw95YGzXJ97m1oOoYVnPVCLSH+w056do8ASB79teTFn7egJOUwIMV2mbEQca9ebK0b+ASvxjto6sw19JCH1ki7QZNkiDHMb09L5tHT4IGC3NCokp6KfCo/KCmtk1mry/szmf3gcKu0hOgKpsYKfSlRInsotYKKMBudUZvNPg8cPSyRlnYr1fsnkT4fSKjsLt5Jn98pVmjLwhjVBIasgeZgi/zfRtFviagWOmlIDkrUqWh2+4hm0Qrsjm5BvMsN5vyPbvej+02iUHq3M2twl4g5QJu7F8rmBTLHxkRrzOi2fH5XbQQm5MCrdyyXtUScyGBSSrZbwR/yvtTcIsJPqaaBTq5rcRHDxT+G1T3id2LO4KSM5raf30Wy5SbLMDMD1kBONcU5+aEALYccipeDnvtiP0Q22ookRg7vR5EXPvIHakDES2lwwMaLX1slRzx/kpccxVa4IaYqhMjlwdsOxDyeSRmYA7W6BEw+ign83ez41WWOUqyljwxinoySHfZOjh/21/XCd9viMTkSsYPI2WRKSLmR3VHPuZrdgZOrrLD2XkBzkrujceB6
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(396003)(136003)(376002)(346002)(39860400002)(46966006)(6666004)(47076005)(81166007)(82310400003)(356005)(54906003)(336012)(86362001)(83380400001)(26005)(478600001)(44832011)(2906002)(1076003)(186003)(7696005)(6916009)(426003)(8936002)(70586007)(8676002)(70206006)(36756003)(316002)(2616005)(5660300002)(4326008)(82740400003)(36610700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2021 01:42:17.3789 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d247587-115c-47a5-c758-08d8c264c7ad
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2459
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
 .../gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c  | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 24f3c96a5e5e..436d94cbb166 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -261,6 +261,9 @@ sienna_cichlid_get_allowed_feature_mask(struct smu_context *smu,
 		*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DPM_GFX_GPO_BIT);
 	}
 
+	if (adev->asic_type == CHIP_NAVY_FLOUNDER || adev->asic_type == CHIP_DIMGREY_CAVEFISH)
+		*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_GFX_DCS_BIT);
+
 	if (adev->pm.pp_feature & PP_MCLK_DPM_MASK)
 		*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DPM_UCLK_BIT)
 					| FEATURE_MASK(FEATURE_MEM_VDDCI_SCALING_BIT)
@@ -1437,6 +1440,15 @@ static int sienna_cichlid_set_power_profile_mode(struct smu_context *smu, long *
 	smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetWorkloadMask,
 				    1 << workload_type, NULL);
 
+	/* have to disable dcs if it's the 3D fullscreen or VR workload type */
+	if (smu->adev->asic_type == CHIP_NAVY_FLOUNDER ||
+		smu->adev->asic_type == CHIP_DIMGREY_CAVEFISH) {
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
