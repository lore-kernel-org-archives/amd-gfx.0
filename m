Return-Path: <SRS0=majj=GJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11D07C433DB
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Jan 2021 01:05:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E627221E2
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Jan 2021 01:05:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E627221E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D91889C1B;
	Wed,  6 Jan 2021 01:05:28 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2076.outbound.protection.outlook.com [40.107.93.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB4BB89BB2
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Jan 2021 01:05:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dpuEMwNB0kEQRujIiQaObfO2NFO+EcA/xMk0xSyx32kPzf0da9E2GAsG/idYTyAyuA6r/FKyAPSz+X3W8OmpzJs4vMxdCIAUJL+zp9m1r59RJIMD8Jj8CbduaPfLVEo95V7mpD+RHB8P7CztLL8lTVQRlIUn3fQDfXupOgXa6PXsg29wkxEyJzZb8gwovcpWWI9fjilSt8t/hbxaf8TNHpvTDP6x1ArJD9JF2p7wOxlSt4kA2S6e3ePxc9x8bKY0YTe2UyJEz4EXz8rlD3cSndalCtrhVWw1J6VRHBdWwKs2SihnsjCD4rPgWUvfTrej2236ScbnhX+wry5O8PJ4pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ko6Q+mxDaWRrTFp23Md3xWOzMDkF6yHuZ/DBw8CJ+PA=;
 b=Ic+41bgEuAsIXm2aT0fLjZSRo3uX7x9Ge/LkEaDCk7wX7L/K/JIpLS5yYyunBjtdHpiX7xShl8KSCpbJOvZBOajslWBBjFuXdGrjfuB+nUIjNaeaZLSfTn/EQMozqkqOmvz33Onu4BcmXfDWJqEOE89nsSU7ZUvjQ/EyNCny++521Vmh2gOGngCgn9b16Z6OS3mPOV2gkf9hyz8AFrpk4e7Lh2cWxOSapd1UntepbFnoAYus5PrQxIVX3klJz3WLGi/8pHtwmEX+m6jCIGqEOc/xLj2D43kwe8MaWZeldXws7FpoRXAb+gKs5ROgbo1ijxL4/rpxb2wGekXBYkgx0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ko6Q+mxDaWRrTFp23Md3xWOzMDkF6yHuZ/DBw8CJ+PA=;
 b=jgMwvL/WTVTbobcR92RxjTG64+OB7odPD4c8Z0z0fZO6/jp6NDVLZOzABFx9zHFMh2HXgWJeH8c4vOVz1zQP7YVz6VUA6NWrtP8Y1H2KfO7XH1Dv6MjyDAE/cEX4W2dg7vMKuCipxiAR9m0KuCEox1jYwlkni4UrwUo3FtIwz7o=
Received: from DS7PR03CA0196.namprd03.prod.outlook.com (2603:10b6:5:3b6::21)
 by DM6PR12MB3481.namprd12.prod.outlook.com (2603:10b6:5:11a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.23; Wed, 6 Jan
 2021 01:05:25 +0000
Received: from DM6NAM11FT062.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b6:cafe::67) by DS7PR03CA0196.outlook.office365.com
 (2603:10b6:5:3b6::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6 via Frontend
 Transport; Wed, 6 Jan 2021 01:05:25 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM6NAM11FT062.mail.protection.outlook.com (10.13.173.40) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3721.23 via Frontend Transport; Wed, 6 Jan 2021 01:05:24 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Tue, 5 Jan 2021
 19:05:23 -0600
Received: from emiy-Z10PA-U8-Series.amd.com (10.180.168.240) by
 SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Tue, 5 Jan 2021 19:05:22 -0600
From: Emily.Deng <Emily.Deng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/3] drm/amdgpu: Correct the read sclk for navi10
Date: Wed, 6 Jan 2021 09:05:14 +0800
Message-ID: <20210106010515.486545-2-Emily.Deng@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210106010515.486545-1-Emily.Deng@amd.com>
References: <20210106010515.486545-1-Emily.Deng@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e2dfdcd8-5b24-4e1d-e697-08d8b1df25ce
X-MS-TrafficTypeDiagnostic: DM6PR12MB3481:
X-Microsoft-Antispam-PRVS: <DM6PR12MB34814F4F3D9FFA708E251EC18FD00@DM6PR12MB3481.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CWso/4lUqHOhP1jd++WcDQJOHl2mzJx30Q2JCQfYGm80e6kSoFiBOl+cWP5viz4mcvYPlqX8FfGgbXO0XiU0hZKgOjJM7qt5RPG1wSAwNkqWqdc5olVhrQPVo5Jp+kStpxsii7SmRJkpj9a5llKKAHfb2kCwhcGuNI0yrKtKHNDysZa7ZgRGKxJEpcCXl7pDq1EsGVZyVmi11PlpQwbWamB+qX+7kbcVErelY+LyUkJniJXTgfk/7qWIhW29EWefgftEKcbn1UCl8rsBb6aGyOT3JFOOcnuNGruHIv/kHDTs4Ap/lSHYeU4iyj7PIsKcq9uLMIo4G6ZIz7Mh2xRPQHBQI3eohcp7sGdPfpIFo3X6bYRfIUr9qfYtJJZGJ7GpZsB5/i1LuQMezXJwOdOlAfovhAbIiQwuMCoqZBX7HKqpPaiCcR1ZGaSSMbW1Ny/eVT0ibHGlQBb8VWn+9VgEYGCB/4uRH1bE4b9wsxQUgdCL6tgSIxfiQ/oF4aeiL1Da
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(376002)(136003)(396003)(39860400002)(346002)(46966006)(478600001)(83380400001)(36756003)(5660300002)(6916009)(4744005)(1076003)(82310400003)(34070700002)(4326008)(7696005)(6666004)(81166007)(26005)(2616005)(426003)(356005)(70206006)(70586007)(336012)(47076005)(2906002)(8936002)(86362001)(186003)(8676002)(82740400003)(316002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2021 01:05:24.2015 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2dfdcd8-5b24-4e1d-e697-08d8b1df25ce
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT062.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3481
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
Cc: "Emily.Deng" <Emily.Deng@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

According to hw, after navi10,it runs in dfll mode, and should
read sclk from AverageGfxclkFrequency.

Signed-off-by: Emily.Deng <Emily.Deng@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index 51e83123f72a..7ebf9588983f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -1673,7 +1673,7 @@ static int navi10_read_sensor(struct smu_context *smu,
 		*size = 4;
 		break;
 	case AMDGPU_PP_SENSOR_GFX_SCLK:
-		ret = navi10_get_current_clk_freq_by_table(smu, SMU_GFXCLK, (uint32_t *)data);
+		ret = navi10_get_smu_metrics_data(smu, METRICS_AVERAGE_GFXCLK, (uint32_t *)data);
 		*(uint32_t *)data *= 100;
 		*size = 4;
 		break;
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
