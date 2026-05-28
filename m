Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEE56CD6E45
	for <amd-gfx@archiver.kernel.org>; Thu, 28 May 2026 06:42:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 783F510ECAF;
	Thu, 28 May 2026 06:42:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uOr7pggG";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012055.outbound.protection.outlook.com [52.101.48.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D9DC410ECAE
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 May 2026 06:42:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z5kWi71gAViIcfH3mlSSeQaOEg98MXP0g8gfzqNqhQgOb3lzqCYIU5o1L5lZwiPJFlwoZqQ3OjYmSPKeOiKZbH/VTbhuhkayIx70lU80kQCAjGAtu6HCySPgNFgYm9aXTVPIma7kkAXnGqbBZ6EPNLGwpZUwVmn4hdtpGoKYA2+wXsgJdyw+ihjSZ95p0gxYUeOJbodKHnNWTupBB/I0zRTZlRqbuBmocGuwO8Rp7wjM68NMuvWjKylQhuBZ8ibRAKh9tgcZwVzfPzXXwP1OKPtpw35peSWPod/0kDpU0YVQWj3UCu1FZBfaZiIBhheAThdukuHXz5FIz4gUMLXmpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8EpFfxojCDbILxphZItm4FuunP31RRj563gVnA2itdg=;
 b=hyc6PCeEyQb+vsoxbdN+XK5BqcD1B2EiHtTD65UoqdLwVcMQZ2QZWWnScwl7oSy+Ppf4l3SE7SV2UrJZ+uSwCR3zJ5hxV+vuYbofC7GOMpKv6CawsEGWifGoeomRMeF2YCuJbQ0hqm5L4/Oxt43OL9N/Zt8rOJqAwfvuV17UFwDcriGRHNYD2V3y+gVPnHgwvgV74YnWNfnYc1yAu68Kk9aG9rjjzgWhtTyD6y2DpbcUihyn3k5TDGcXr08SM7PJVyj/PeNP7vMCjTcXqoN+ct6pMQUaEwpf27h3tqkqfuhnJfDdg0AnziES8kXdUYDOrk7m074ktpXjRb1MYpwyyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8EpFfxojCDbILxphZItm4FuunP31RRj563gVnA2itdg=;
 b=uOr7pggGhV/abr3ld2GtPYGVk8xVuM4Ijk7C+z1cIAaCXjSMOiHZpe6eML5khX1MXZ7VBwPmjh9jmMRKetMaK3F8khxChrcy1HbYQuqRNXg81zYbkkmwjiydRJA9HSmus+kJ1kH0Xz90SocXO4OpKfdKHxYE/T6j/rsylWwseP8=
Received: from BLAPR03CA0174.namprd03.prod.outlook.com (2603:10b6:208:32f::11)
 by BY5PR12MB4082.namprd12.prod.outlook.com (2603:10b6:a03:212::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Thu, 28 May
 2026 06:42:36 +0000
Received: from BL6PEPF0001AB76.namprd02.prod.outlook.com
 (2603:10b6:208:32f:cafe::48) by BLAPR03CA0174.outlook.office365.com
 (2603:10b6:208:32f::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Thu, 28
 May 2026 06:42:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB76.mail.protection.outlook.com (10.167.242.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Thu, 28 May 2026 06:42:35 +0000
Received: from BLRPVISHWAK.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 28 May
 2026 01:42:34 -0500
From: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
To: <Alexander.Deucher@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
Subject: [PATCH 6/8] drm/amdgpu: add support for MMHUB IP version 3.4.2
Date: Thu, 28 May 2026 06:42:04 +0000
Message-ID: <20260528064206.12358-6-Pratik.Vishwakarma@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260528064206.12358-1-Pratik.Vishwakarma@amd.com>
References: <20260528064206.12358-1-Pratik.Vishwakarma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB76:EE_|BY5PR12MB4082:EE_
X-MS-Office365-Filtering-Correlation-Id: 44dcb31b-1252-4ae2-d297-08debc844da9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: bTeS7QipCZ15Hc7B40tIb8t+t4yMWujnEV/wutzLWQaYDyPYClybE3q2R8X5ODUpJvkY+lGWFIKxEuiDOkL+SXB2Nr+ghsYMcTZXYpc7pc+DFicx42ArjtNixWiV5cnfTeK+49ExtwOY8ZTMC3n5PBUOzgEo8vBAbhR088a9mxBN2paLMKFs3A+jU+Zq+oEOQGoUP4ubTZv2VF5GHd5uQdWQH1tGZk9XFirPh43/YLgSnvrEqUqyf8E4n1OaJfGMdeNNEb+m41kyWUqrGgziLyR+YxabqxdNFUhR8OfhP73u2Nfvm2CboTVotMsLG9+TdHVkPHUr643jnrGi3Lqs8FK97Y8ngjd9NCOcoKK+0Ja2tjInP8qq71ATBzOZIRcrYxj+4sU2qTo5P+DGhvSLzDWQDrXtrQd+yzyvVCFAhR8AjKFAQ9eT56tMJlx7oLBxXsWlOciG9qy91AtXpvqkHxEqjkaiAra5Gdp8ivGNgGfwJLCUm4k0rndnI3EX+qUpPhjOqvQtQhC176qgffiDVdvxoBZRTye2di1rStGLJLWNg9cOUiK0goxfHumsAptAKPWSsaldf4yGgPBpyl+kfNSs3Rwl48X2G7kl8bJpk9LTQSPyW/vRP09gLkk72HPDytFpMgnM5m+DN/wLVA810T6pFfD5TIEODk3McBJeQfDdTXwiUYMEqMLgKx2/iqNVsPptHQglcuSGDtO3ZoXGwKrtZusAgivzd1AVyhRDHrs=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(22082099003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: JyDAdvPSMCzvWcxqtdmtPMDMV332dKkTc6I/FtZCmgtqv6yZkjLmk5VKHBSrRSEi4gjV5hsPXb8OTkYqcDF1d9rmggED9hgyUv6B+knr8nGKnc2kpXIOtEXXQGIkh8bcxj8kAcuFdU5/onnihCY5ymoDmLieC2rUdrHielzW+LeryL/tocKYuUeL1RKWN6pgXMq4hjLVvgLbM7XBnjkS4AlOLbb3Mt12DmAHB7day9oYicSE1rS5lnurSkTxGanWhvm0R5eEchnhVnggd5iQnyi4vtWofn5lwbYp9hZaS1yohnO7Ec8705T+prTwbCpz4d5xgdjIAL5fyjra7hia/xyDm9nuZuQ2yU21guwACte3LU6uwZGAz4pEom9igkT5wgoyQFVJqzDEYWyene6/3jiI/RpFlkUGnL2OEwJA1l/GCrEvbZZSMHklw6gvNltK
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 06:42:35.7428 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 44dcb31b-1252-4ae2-d297-08debc844da9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB76.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4082
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

This initializes MMHUB IP version 3.4.2.

Signed-off-by: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c  | 1 +
 drivers/gpu/drm/amd/amdgpu/mmhub_v3_3.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index 9664b7b8f0db..41ec28bbff05 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -585,6 +585,7 @@ static void gmc_v11_0_set_mmhub_funcs(struct amdgpu_device *adev)
 	case IP_VERSION(3, 3, 1):
 	case IP_VERSION(3, 3, 2):
 	case IP_VERSION(3, 4, 0):
+	case IP_VERSION(3, 4, 2):
 		adev->mmhub.funcs = &mmhub_v3_3_funcs;
 		break;
 	default:
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_3.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_3.c
index cfce7e1297d4..292b660ead66 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_3.c
@@ -636,6 +636,7 @@ static void mmhub_v3_3_init_client_info(struct amdgpu_device *adev)
 					     ARRAY_SIZE(mmhub_client_ids_v3_3_1));
 		break;
 	case IP_VERSION(3, 4, 0):
+	case IP_VERSION(3, 4, 2):
 		amdgpu_mmhub_init_client_info(&adev->mmhub,
 					     mmhub_client_ids_v3_4,
 					     ARRAY_SIZE(mmhub_client_ids_v3_4));
-- 
2.43.0

