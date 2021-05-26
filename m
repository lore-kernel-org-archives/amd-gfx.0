Return-Path: <SRS0=Zxj3=KV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC288C2B9F7
	for <amd-gfx@archiver.kernel.org>; Wed, 26 May 2021 08:06:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B08B8606A5
	for <amd-gfx@archiver.kernel.org>; Wed, 26 May 2021 08:06:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B08B8606A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 65B8E6E497;
	Wed, 26 May 2021 08:06:47 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2075.outbound.protection.outlook.com [40.107.223.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C51486E497
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 May 2021 08:06:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YpfgvwDx/BuhsIgaEoZBE+QRQyFinhToTBhEYDdcgsH41F1KWZdnWKOxrT687XIXy+v+wrLFZB03EBVsgCt9RcAPYwbloeoPRGckXtvB2Fry1kf6U4+dBLJygO2ZCKxsxJy9Gfh95Tm/XxSW3xeawRJWxog0/R788sm1EhgNx+5kQi0JJb9eaHc9GiJVKW9F3hSGysuSXd6G7VCGbzJQQMIGW4IVY92JDI8/nU4YIgq8jS6AmV+YDVviwCaZqi9jcnxkmM/41EKkYbcwUJbQnKU0DYoGhtkKXlidUZRywSKP25DkufGxUbZZ8d3veEW8L15Ri/BTZyKK/5qGW7OjAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cz5VlM8TPGqcfsZLqGxHF7Q48Z1Xs5AiZj6pQrB26eo=;
 b=B3ZDR9xphF6EdcaDTMIiOI0C4k9CIkR8zsodZwVyIwR1wfS5P0BcQBAsP1o7VphAdbbPaWbQNMNXVF8FpOMy6qe1U0xA/PoRsgu2pZxqB/tWEnIcFKX4YZBYiauTxTk4yEVpgMlYdB2cVFOGDakMZbE9kODh7nwT3xgMqKf4LMSWDoEN7euRJh9AhwHgWa299jfE9pYjfSTlGCTerRcv7OGJkQ72ga1UqZfSAw0uhjDbQV5sKHuNFcWsoIyD3DzZQq74+VPs5KJN+XWBWmbBnYML31RE4NRADjrCbjov8gwSdZW8rSkCcMBhFfE48qt2LD6NOAzWEx+kzrOtMtI0kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cz5VlM8TPGqcfsZLqGxHF7Q48Z1Xs5AiZj6pQrB26eo=;
 b=DRrAe1YEaGy3bTZVZLlECmd26vWm2MYrq9n+Hv55hy67ZuAiCzC6Zl+iFd7VAN12KtQ8kmmX0l0n8kWrHC7pmYSlx8auh4UqsqqzNbce9+XL3LDSpNHtRVwrAc1eBpxOO/jbaArOhHkLfpzV+iIbzAyOJvG4EnqzYaX/Gd+KRfI=
Received: from BN9P220CA0007.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:13e::12)
 by MN2PR12MB3213.namprd12.prod.outlook.com (2603:10b6:208:af::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.23; Wed, 26 May
 2021 08:06:43 +0000
Received: from BN8NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13e:cafe::b6) by BN9P220CA0007.outlook.office365.com
 (2603:10b6:408:13e::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend
 Transport; Wed, 26 May 2021 08:06:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT054.mail.protection.outlook.com (10.13.177.102) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4129.25 via Frontend Transport; Wed, 26 May 2021 08:06:43 +0000
Received: from jenkins-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Wed, 26 May
 2021 03:06:41 -0500
From: Xiaojian Du <Xiaojian.Du@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: retain the fine grain tuning parameters after
 resume
Date: Wed, 26 May 2021 16:06:25 +0800
Message-ID: <20210526080625.1210268-1-Xiaojian.Du@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5adff520-aaac-4e23-6949-08d9201d3345
X-MS-TrafficTypeDiagnostic: MN2PR12MB3213:
X-Microsoft-Antispam-PRVS: <MN2PR12MB321321A506C68906DDF6CC43F1249@MN2PR12MB3213.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: inRhot9wv5EF8NnyWpr0qxUkjFZpgynOLErxaEjifFUP3fDMqjAHd2cQQCYjICvfVjLm7iBhMMUxV+XOLzf3/yvBcYAAe5jg5ppjLqEeg/Lq1x/L6v4eyYCRmnOOnUAric1Hk8g54x61kJteoSk/Z5O666Uq/CzRQkm3RSfv4ek1XScHcUDdLSBchCzNNBgoJ3sQHISVfw567OX75fm47W7k6ebZmaehpwMhdnAHa7aiR2P9abG+u4b0yskD4PnUybcz13jb3A8v5bqpx9EnkHvjl2+PupZcy8oqx6Yk7lLrNCPfeN/B0JWD/qEq21PBHlXKF2ElF8kd8C40jyBlWcK24YymSrPTW5b2SEsbb7sGbRfDPnrWXgJisHaX8FhHzXma9eLbkGER3iQVxklZ+wZKrEQ4ZsQFSZx3kXP11S7ulU2fSOV9a/7QY/uSZpp3hOXF7bj/zxQeV8PXbMOeZFu/LxadQlQB0i5qnken3T8TpqoRzvrmtyQ5e2n/kuOgYM9z5GbhlQ6opNQ20WyRp44qRpDa5mbhIRim8uBY3ywsvtJG1AfeB0AYU6BpccFahO2u/G/j5JFj8D+pkj2jieHLSePUhKbESb5wsnMUFTKgmrYLtNsdLlbdO4oaZiUBB3dCZ8NXc2gFU6HWugWb7YHHfagz1PDbOzlMvSiCubXowpgRrls2N8u1nyLndUhc
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(136003)(396003)(376002)(46966006)(36840700001)(356005)(86362001)(6666004)(2616005)(47076005)(81166007)(83380400001)(1076003)(16526019)(5660300002)(2906002)(26005)(426003)(6916009)(82310400003)(8676002)(7696005)(54906003)(336012)(186003)(316002)(8936002)(36756003)(19627235002)(478600001)(36860700001)(70206006)(82740400003)(70586007)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2021 08:06:43.5533 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5adff520-aaac-4e23-6949-08d9201d3345
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3213
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
Cc: Alexander.Deucher@amd.com, Anatoli.Antonovitch@amd.com, ray.huang@amd.com,
 Xiaojian Du <Xiaojian.Du@amd.com>, Pavan.Ramayanam@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch is to retain the fine grain tuning parameters after resume for
legacy APU, it will cover Raven/Raven2/Picasso.

Signed-off-by: Xiaojian Du <Xiaojian.Du@amd.com>
---
 .../amd/pm/powerplay/hwmgr/hardwaremanager.c  |  3 ++-
 .../drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c  | 21 +++++++++++++++++++
 2 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/hardwaremanager.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/hardwaremanager.c
index 25b5831a15cd..370deae7b054 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/hardwaremanager.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/hardwaremanager.c
@@ -82,7 +82,8 @@ int phm_enable_dynamic_state_management(struct pp_hwmgr *hwmgr)
 
 	/* Skip for suspend/resume case */
 	if (!hwmgr->pp_one_vf && smum_is_dpm_running(hwmgr)
-	    && !amdgpu_passthrough(adev) && adev->in_suspend) {
+	    && !amdgpu_passthrough(adev) && adev->in_suspend
+		&& !adev->apu_flags) {
 		pr_info("dpm has been enabled\n");
 		return 0;
 	}
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
index f5fe540cd536..8f71f6a4bb49 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
@@ -377,6 +377,27 @@ static int smu10_enable_gfx_off(struct pp_hwmgr *hwmgr)
 
 static int smu10_enable_dpm_tasks(struct pp_hwmgr *hwmgr)
 {
+	struct amdgpu_device *adev = hwmgr->adev;
+	struct smu10_hwmgr *smu10_data = (struct smu10_hwmgr *)(hwmgr->backend);
+	int ret = -EINVAL;
+
+	if (adev->in_suspend) {
+		pr_info("restore the fine grain parameters\n");
+
+		ret = smum_send_msg_to_smc_with_parameter(hwmgr,
+					PPSMC_MSG_SetHardMinGfxClk,
+					smu10_data->gfx_actual_soft_min_freq,
+					NULL);
+		if (ret)
+			return ret;
+		ret = smum_send_msg_to_smc_with_parameter(hwmgr,
+					PPSMC_MSG_SetSoftMaxGfxClk,
+					smu10_data->gfx_actual_soft_max_freq,
+					NULL);
+		if (ret)
+			return ret;
+	}
+
 	return 0;
 }
 
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
