Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 387B9C0015E
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Aug 2023 08:57:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8937E10E162;
	Tue, 15 Aug 2023 08:57:22 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8d::601])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 70A1310E162
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Aug 2023 08:57:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KW7McNtRw9n6VQQPN96q/jfQKj10lDxOdlEf349i6Gs6kF6DnKEbqBsobC4GqotKaf3f2KVFh1JvIR/1gkOcCYCVSUmBvopN9zTKrhy2NkD0lNYvjaJH349fAXBQsw83qWkRhHdDMqywUTE8kxM03xRU/suYeO0hObNx4JKd8HynU9v/vChRj2V3O+m5zfg4Uc0Qc2a6ln292KXffsGwsW6f9zPe4NrIAj5DLhXrL3z781buz2dCyvg7o/ik3bFf7uJbhM1CfbDRCiYCI9xAU81VF6x8Z5GU8FV2xg1iZjnm6XKn50j8QB6PnSYJ6qWjvhGdZyNteSziDodulOzhZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EM2HPAM5iRjZwQZQqf8JNiG67TEvu4294yoshJgrSKM=;
 b=FEzNQ5Ildg2fJpnFnHlnjEgxGc6bFnyPbHUE9VoXjXDLVNjETBE2Zgh1fkn8wSM3ZG7GLQdtuWCSJStdjv0TqpDRIP3Dlt2dK2vN/lPpEscPzbwlFpKV7Rs6xvq7agLibj6Iva5QdmtTTcmJJWxtPQ74gfCebYwTQrNB2RnBYedz4X/S3VbwSSyuhx/PmrZLXqVmKaeDNBtZ2Hf07gkytqUY+NTpFfNTg2ySofbPDvB6cIypXu85d24O8H+oJvm3eK/616swkf7uATsHNWt6++J7Atjgq4NyYbp9YZgEIGoPPEmWJCpkLc95Nih/eui3lkV30uOKb0dgjUxzns6Ygw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EM2HPAM5iRjZwQZQqf8JNiG67TEvu4294yoshJgrSKM=;
 b=wvLZ4maAE5bbp0L8IaHJaEKa9HqjH16orJL6WFFR3d0l82j5spjT4PJjxS+k2n6UlbJjdh+4OblbURnEo6d7iWhD/FFR+z5GVdkygbVzr9O+6tMCbtWOrzADkMcGzHkD+Q5lghO3ERDtwOghBJji+MQbi3o6GE6o7Sk8EsX7uWY=
Received: from BY5PR03CA0001.namprd03.prod.outlook.com (2603:10b6:a03:1e0::11)
 by MN2PR12MB4048.namprd12.prod.outlook.com (2603:10b6:208:1d5::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Tue, 15 Aug
 2023 08:57:17 +0000
Received: from MWH0EPF000971E3.namprd02.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::fd) by BY5PR03CA0001.outlook.office365.com
 (2603:10b6:a03:1e0::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.33 via Frontend
 Transport; Tue, 15 Aug 2023 08:57:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MWH0EPF000971E3.mail.protection.outlook.com (10.167.243.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.12 via Frontend Transport; Tue, 15 Aug 2023 08:57:16 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 15 Aug
 2023 03:57:13 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 15 Aug
 2023 01:57:13 -0700
Received: from kenneth-mlse-vm.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via
 Frontend Transport; Tue, 15 Aug 2023 03:57:12 -0500
From: Kenneth Feng <kenneth.feng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: allow the user to force BACO on smu v13.0.0/7
Date: Tue, 15 Aug 2023 16:57:10 +0800
Message-ID: <20230815085710.842188-1-kenneth.feng@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E3:EE_|MN2PR12MB4048:EE_
X-MS-Office365-Filtering-Correlation-Id: af9ea6db-cb67-4fcc-af37-08db9d6d9ffe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GhGh24K9LDqd+S24KiuJywkB7ZxJL9NGdgYzIwJNJqQFVWlKhwlkGDNJRELhhTOUCdkb8Cd3hvfOa8oLi6P+0bjO5n0K2+DLBPyg7651J02AIuiZWNpZltx09bFQaKGOyB3cqX3Yd9ntmu7fAMJ5Qwwow2fIOP35ztrDoHhciCWhWwbbSqLrZzLVKso6yiTu574DZiZLQ7eKd7S2gPpIjAn2yz9O4dTuIhHry8gM9vk8WZDtEmY87SQ57VhOlOygJMQ1ATrysXP1dvHaSeII6KgcXWe4rC4PEqevx9XwWq+K2D/1bMI35P+y/S3tGvRUN4OrLyqM0p/lMmXDZCyaIhx4EA9uzxtg+sgYWNvMJoxY5rdWNZ9scpY5xvVQICjCbzxBINfTleExTwwCurQ0NqHdn3f3fV/RB82k4p4fBs0hbqwJKjAX/XVg5BzHQh5kfMkjCbGnSEVvsugX4yocG2ykg9Wnsqe4qABzOJwHZz8h3yP+9rMfvkaJWuz3HMrsW5emX46Wxsemjd1C/1BA5mkYmhhwMf6A0N5/HgOxqJjeU9I4qkEW1set6LmkAKLFWQXOPGal3ZdVihhTSBD9XEXChZ9ZVolSZQ2KVVCwC+wWN2qor/U78Vl1DcWkEOZ59U6uL+C/iRaVo5MmB4ebWTHrAbpCshSIVsSoqMVFitNjvPohzdZ5dPf43ShsXVGUR2DsDpJuw8lw5ckhzlB7nPQeFJTX1hLq4DxYzp8CC2rIV0ql1LYprReVC6mnVfNBv7U7B/7/UtxZG/i/lO8gcQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(346002)(396003)(376002)(136003)(82310400008)(186006)(1800799006)(451199021)(40470700004)(36840700001)(46966006)(2906002)(47076005)(316002)(40480700001)(6916009)(83380400001)(70586007)(70206006)(36860700001)(41300700001)(7696005)(478600001)(426003)(336012)(26005)(1076003)(2616005)(86362001)(5660300002)(36756003)(40460700003)(44832011)(8936002)(82740400003)(81166007)(8676002)(4326008)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 08:57:16.2759 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af9ea6db-cb67-4fcc-af37-08db9d6d9ffe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4048
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
Cc: Kenneth Feng <kenneth.feng@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

allow the user to force BACO on smu v13.0.0/7

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c       | 2 +-
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c | 3 ++-
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c | 3 ++-
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index 895cda8e6934..52e9c7611013 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -2263,7 +2263,7 @@ int smu_v13_0_baco_set_state(struct smu_context *smu,
 	if (state == SMU_BACO_STATE_ENTER) {
 		ret = smu_cmn_send_smc_msg_with_param(smu,
 						      SMU_MSG_EnterBaco,
-						      smu_baco->maco_support ?
+						      (smu_baco->maco_support && amdgpu_runtime_pm != 1) ?
 						      BACO_SEQ_BAMACO : BACO_SEQ_BACO,
 						      NULL);
 	} else {
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index a5857acee641..12ccc12657d7 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -2211,7 +2211,8 @@ static int smu_v13_0_0_baco_enter(struct smu_context *smu)
 
 	if (adev->in_runpm && smu_cmn_is_audio_func_enabled(adev))
 		return smu_v13_0_baco_set_armd3_sequence(smu,
-				smu_baco->maco_support ? BACO_SEQ_BAMACO : BACO_SEQ_BACO);
+				(smu_baco->maco_support && amdgpu_runtime_pm != 1) ?
+					BACO_SEQ_BAMACO : BACO_SEQ_BACO);
 	else
 		return smu_v13_0_baco_enter(smu);
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index 93b3e8fa8238..f0bcc7995983 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -2139,7 +2139,8 @@ static int smu_v13_0_7_baco_enter(struct smu_context *smu)
 
 	if (adev->in_runpm && smu_cmn_is_audio_func_enabled(adev))
 		return smu_v13_0_baco_set_armd3_sequence(smu,
-				smu_baco->maco_support ? BACO_SEQ_BAMACO : BACO_SEQ_BACO);
+				(smu_baco->maco_support && amdgpu_runtime_pm != 1) ?
+					BACO_SEQ_BAMACO : BACO_SEQ_BACO);
 	else
 		return smu_v13_0_baco_enter(smu);
 }
-- 
2.34.1

