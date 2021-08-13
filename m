Return-Path: <SRS0=hpB+=NE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99BEBC4320A
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Aug 2021 08:49:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 539096103A
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Aug 2021 08:49:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 539096103A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD9BF6E581;
	Fri, 13 Aug 2021 08:49:57 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2080.outbound.protection.outlook.com [40.107.212.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0ECA66E580
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Aug 2021 08:49:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mcODYUPKt1naiJyXNIjvP+kZ7icg+fa1oAigP7JH/4QyyasSN1CBOW26poyB7qz5TtQQgQA7RWZsOTtHuhmgVwYEXR9jhlTU3SmGHb6q/Mm4kruiL/Klg8c83wAJWhasz8oQLlhCRGVU3FyUm5k5Z8XDyBqvS3jbQMxOEt4G/bcLFLmJrceNiYB4pPl6KBLCSVe1QABUZEQlo6JzWRVXeY/jjJpzaUnz8yeRTDz/KW3Qgm7j5ozE70c8BEZTxay+/pUpcXp9i8EwKTP1n+A3nbtHd1YSl3VTXePoaOLbC1zDfD4tZgJbk7JQVU6DCRGTr33hB2eyf9h6XJxy0lGiGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JELa9m+/mPe/xnszV7PO2fgNAwj6hL0onSZuWm5Jd7I=;
 b=ZOXyMNDMzBIv/lKEUJVLumzhigPCqYW0QH0xoH9WWebAMqOgv4ciZcctmUKA7gCeXmCmDT+Dt1gDF4Ej13Oahk6KAdQrWl0P4pPxEFXRqbDHhRxXHfydPovx7MsIJfV727Fwy9SSy5izTj8hk5593hJnfvM9N4nnbUkeYSORAW3hLR0Rs9wgrV+y/XE4azswxzSbR9hDY8AR7hAqKVsbHbaC9aHAogSoaMghKYcLjVi/+8AOh2DSdqO8XRWhUCWK5/hSlPl6S2mjCyhrBhqq3dTwSfLuZkrUE7p1L6MXE0NbliyU1nSiIZswptvET3mqcJBw8yD9gsC19n80SoW9kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JELa9m+/mPe/xnszV7PO2fgNAwj6hL0onSZuWm5Jd7I=;
 b=GumGfogjlLEbHF8nULdTciakSLsxXQvAdOTAxYbvLGUeOlD/Ev9LZ2ztIkiOMXL7jn6pcJfJ0GQcf5b0XVLvBHqHd9k5v4c0UnfbaOPVOOH+Fx0nBFxT7jdGE51GV/bD4jGSzKEXR4VGr2Oalmft0KINSDhEaGGAhUlf5o7vk+E=
Received: from MW4P222CA0026.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::31)
 by BL1PR12MB5190.namprd12.prod.outlook.com (2603:10b6:208:31c::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.14; Fri, 13 Aug
 2021 08:49:55 +0000
Received: from CO1NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:114:cafe::f0) by MW4P222CA0026.outlook.office365.com
 (2603:10b6:303:114::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.13 via Frontend
 Transport; Fri, 13 Aug 2021 08:49:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT034.mail.protection.outlook.com (10.13.174.248) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4415.14 via Frontend Transport; Fri, 13 Aug 2021 08:49:53 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Fri, 13 Aug
 2021 03:49:53 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Fri, 13 Aug
 2021 01:49:52 -0700
Received: from kenneth-u1804-kvm.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.12
 via Frontend Transport; Fri, 13 Aug 2021 03:49:51 -0500
From: Kenneth Feng <kenneth.feng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <hawking.zhang@amd.com>, Kenneth Feng <kenneth.feng@amd.com>
Subject: [PATCH 2/2] drm/amd/pm: change the workload type for some cards
Date: Fri, 13 Aug 2021 16:48:14 +0800
Message-ID: <20210813084814.17213-2-kenneth.feng@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210813084814.17213-1-kenneth.feng@amd.com>
References: <20210813084814.17213-1-kenneth.feng@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6bda9bfa-3a7b-4cf5-daaa-08d95e3751ef
X-MS-TrafficTypeDiagnostic: BL1PR12MB5190:
X-Microsoft-Antispam-PRVS: <BL1PR12MB519028C293F5685B75A2C9618EFA9@BL1PR12MB5190.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: emQ3LolL+TJMmuMcF7mcn7h8vu3lHd1BBk+aaT0XAw64GtvGfm+euqMr5zP7i6088U7wax0g68/ZjD37w9c6HFCsMghxwmPb77hZnvmm97ppcWv1PSa8/sN/2RkkPvmbd6vjoceig+w7VvP5xR8XDQWz/1djJeNSW4lnp8f4Gs456dzUMfimikj/21/nfTgpzE/0yu2arvV7Z5K443A1MZIg2YZgI8LF8Dkm6vuQYzKhHhp4JY9G6We7XZJVNuv7l8g1X5Gt6wK/9gMqCTkbZy6Aet8NrjwHF6uHtLT5Nrkw5gicQGe8WDZYzi8H6nPIgbzT1sxjSjEkwFmzMZzBsHluTLcwn031bnoWuGJIWj+wbL5pEvbfiVnlfg7rDOqN9hgqR1IDS2sLNEPSvaDEFDdwlZ6mf//OPaf5aQI/LH85fQe2oi3FPa4vzBLk4O6EU0y1afoSE6ccgV01tmTgDLMO1Jz+roCDUt9pnWBBXxixWfzkUR+mQ05Bi7hF3tjYoa2jfkHx9uwLzXG0dOnDGRlTjTgOCyMwSRUqo/vXVORNoinTKpksKmrpvBIaH1G31SPyXkwHHozsCqi63sJnVpNdw+qe9L0FlCo5HuOJw7BpnabP8Yk68f74E+2A46X3v+TfeLQJFbU+W2igIObj6ZGzH9BI6zWeRKCsjTIcoI0iF8hW1UJIkbMHIB6gRw0iYG8Vfn11nmke3s9l8t0n5q0THEZ8m31Q0OsAu0Yty6un0MU2Nd/ctBZdA+1nkxEnQNgfB/Wke57rxjiMP8Jswg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(346002)(136003)(376002)(36840700001)(46966006)(356005)(44832011)(8936002)(26005)(478600001)(36756003)(336012)(81166007)(8676002)(6666004)(426003)(36860700001)(82740400003)(86362001)(186003)(7696005)(2906002)(4326008)(47076005)(34020700004)(70586007)(6916009)(1076003)(316002)(2616005)(70206006)(82310400003)(5660300002)(83380400001)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2021 08:49:53.8872 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bda9bfa-3a7b-4cf5-daaa-08d95e3751ef
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5190
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

change the workload type for some cards as it is needed.

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 .../gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
index a9bd8265b508..f3cd397cb56b 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
@@ -5127,6 +5127,13 @@ static int vega10_get_power_profile_mode(struct pp_hwmgr *hwmgr, char *buf)
 	return size;
 }
 
+static bool vega10_get_power_profile_mode_quirks(struct pp_hwmgr *hwmgr)
+{
+	struct amdgpu_device *adev = hwmgr->adev;
+
+	return (adev->pdev->device == 0x6860);
+}
+
 static int vega10_set_power_profile_mode(struct pp_hwmgr *hwmgr, long *input, uint32_t size)
 {
 	struct vega10_hwmgr *data = hwmgr->backend;
@@ -5163,9 +5170,15 @@ static int vega10_set_power_profile_mode(struct pp_hwmgr *hwmgr, long *input, ui
 	}
 
 out:
-	smum_send_msg_to_smc_with_parameter(hwmgr, PPSMC_MSG_SetWorkloadMask,
+	if (vega10_get_power_profile_mode_quirks(hwmgr))
+		smum_send_msg_to_smc_with_parameter(hwmgr, PPSMC_MSG_SetWorkloadMask,
 						1 << power_profile_mode,
 						NULL);
+	else
+		smum_send_msg_to_smc_with_parameter(hwmgr, PPSMC_MSG_SetWorkloadMask,
+						(!power_profile_mode) ? 0 : 1 << (power_profile_mode - 1),
+						NULL);
+
 	hwmgr->power_profile_mode = power_profile_mode;
 
 	return 0;
-- 
2.17.1

