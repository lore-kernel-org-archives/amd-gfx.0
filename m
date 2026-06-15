Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD990CD98E8
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jun 2026 23:57:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 91F1710E76A;
	Mon, 15 Jun 2026 23:57:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="d7pXQCHJ";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010054.outbound.protection.outlook.com [52.101.56.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5FB4F10E75E
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jun 2026 23:57:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oSRJ/bcuz3H5GyxlcQx2FjRJFAPrQUiE/hoAUkWGoDk7M64N/RK/2bS6BVuZO4EFIWIq+cQyRsn6uedxVM3UjLALznwqMOQKXc0AcGgJu5SkaJznwwvMD53SQYawV2o1mWId+c4xLuA5qycgpMBxkvlv081D/HBwH5XRC03qr4N5N3hAVTWtuUZVjwfCNofGINfrPyREN/SLPHGMEsZCTqpe1lybrQZVdN7+zVNq2igTE0BizG0fXC5Bsn9heqgy1feTAwVb/9yyDnXSTdAQ9SZBvtj8WCg4Jc4UbYSfQUPkqgUx4G13nqpUgb+fLo6LwmB9GqlaaxgVT7xk40t0gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uci/a5wgJunQNM3cUFCYmDfLDo782EZ+p7zHdUYCOtg=;
 b=hUdkqT1qq8+33RvSD5ZP0pRyzLl7825iTUzQ+DFDRjs1V9AA9HDlGGXi2lGln+eViwH/UYTf/ca0rAtMXbSMYlIRO6ZUbvA3nWtLSIh5bVviwr8AJXu3nrw+HCBnW5MlcGdvcG0N7tPR0hBCZBUIJ0Q+hqU+Er7ovuZhQL7V9daX0w5d3EB+sTwowIsQhveDHMjwjCgih26pdkGJ9kENLKfgXfNFxcl7d5B4I0ukwX+5TaJ3ubP6o+QifYTShhKBlW+zn0p6zqsVz/YDS0nce5g3gQxFkfNYz5kuOLyt6UbpbBQ1g4WNcTf2klD8Ywmrh36o7rffGLMiI6nuG8e95A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uci/a5wgJunQNM3cUFCYmDfLDo782EZ+p7zHdUYCOtg=;
 b=d7pXQCHJlWWyXBZbRn/Bjcq3DTWFwRe1A4yeHbugP0Ef9YZQYISwYpP8WLrP52724pGUwq6ZVolKD/XKcQKsS9uIHPg8SBZ72n2LGUJh0Nf7UvfB7tzZq80OkRmijkd242+5B5pwybSiq+w8sAcXDQW+SxQ6b4Z8H27xPjMAMas=
Received: from SN6PR2101CA0010.namprd21.prod.outlook.com
 (2603:10b6:805:106::20) by DM4PR12MB7549.namprd12.prod.outlook.com
 (2603:10b6:8:10f::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 23:57:03 +0000
Received: from SA2PEPF00003AE4.namprd02.prod.outlook.com
 (2603:10b6:805:106:cafe::2d) by SN6PR2101CA0010.outlook.office365.com
 (2603:10b6:805:106::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.2 via Frontend Transport; Mon, 15
 Jun 2026 23:57:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003AE4.mail.protection.outlook.com (10.167.248.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Mon, 15 Jun 2026 23:57:03 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 15 Jun
 2026 18:57:02 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 15 Jun 2026 18:57:01 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 19/43] drm/amdgpu/cgs: WARN() rather than BUG()
Date: Mon, 15 Jun 2026 19:56:21 -0400
Message-ID: <20260615235645.737189-19-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260615235645.737189-1-alexander.deucher@amd.com>
References: <20260615235645.737189-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE4:EE_|DM4PR12MB7549:EE_
X-MS-Office365-Filtering-Correlation-Id: 6228fc0a-337c-41fb-ad58-08decb39cc19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|82310400026|23010399003|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: DKHbRiTL4RoWGJxny9j/0/V5oKOwBD945FL3wAtUEuaqcwrE8X2jUVu8NZ4jCZhYAtuJqiByij4LAZU6WtJA96Jc/s2wU35iNUHyjSbkKjtFTPVb5ZBEi/SlsOc9nWw47s412pm6+IyPHqJe77T3dnLsEwcZZaR0bDdkyIDNeivvJwJ+nop07gGCfY50EHbyNB7Y2wWo6HqbPPtWSEsiI9AARyyUrFL1i3b/4PD823jyzrb2i6qKQQmGi0a4n+MGrZlcp+zELpwPd2IijxpsB0Y+iWWCe7QR+98w3MtMbHS/oNyUkwwvniAXJLyaJZQohoR4HQdqIyWjp17kgEJY2uznlf/kNa/lnHSrsZK78QWJHQv1j+LcS/he9tne39WgucM4idF1Mpl3bOMi4nl8q1CgkYvlzIPR3hkqCTj0Gss183/oQu6cH03gGz2VpyWR+gvb7CK++S5GO0GBhZY7idt3NPfRyaTbW2Giox/9GP7qAelvt6a/G3HE9k4Srgw9In8OIp1HLJPb5Xg70q2qKB9iGRofWXDJJiuH/JxGEURR6Qq3BdGDJGl7HHuI11CdwBOcOcedeQpukBezty1oHpDz7upWylSA2lVs6MNzOpfUd6YzurhO+v6o/+Ej7iGrfYwxQ2ExFZ7R6ViZu/Cz2lB5Slw6CsemNIcS8zFrHSidjEMikGx3TB8EhMZmL8p0cSY5cfIGaC9zhVsai6aJn/HmP1btYidtiiWhex5hRXg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(23010399003)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 42w/FBSMZ1Mj1ThDIm98Mab75G0IbzVEUkOIr0iD0q8RIkQu7VpLNrIOjPOAcuo4mBvTYQIAAbOJMEuru0NLvB+6/qefgRDa/1acl2K/7ydYes9OjAcbIDocUWm74Sa6FjkITHA8a4re5FsVDthmr0CX9tLVwqvJjO1AXENrOmti5rdmxcvDD6giGV0qyHmveh1pnOiarsor5yg6OMrOJ7Szl5cbUkW06tpMAPKDzmH39ltfSk0sHx7bU0LlvnyIbLh7FeW/9rsZDjraJYs6jp5B5kkk9n3zXfH5ZywbEWRywcxAlV3CrMdd0Mf5znPq35mfnMcmDty7zJxGWJ1ukPzXoCNZ0PGfIQAeUmAcQy7Faorb2t5vBDulKW7Y68ofPb1aSFL80OaXuI9V12JOCll66chBKnILHJipQlYpyI6GVh9JvqhYtHKYDmdUunnX
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 23:57:03.0346 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6228fc0a-337c-41fb-ad58-08decb39cc19
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AE4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7549
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

There's no need to crash the kernel for these cases.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c
index 09c8942c22d3b..b90ed81be420a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c
@@ -76,10 +76,9 @@ static uint32_t amdgpu_cgs_read_ind_register(struct cgs_device *cgs_device,
 		DRM_ERROR("audio endpt register access not implemented.\n");
 		return 0;
 	default:
-		BUG();
+		WARN(1, "Invalid indirect register space");
+		return 0;
 	}
-	WARN(1, "Invalid indirect register space");
-	return 0;
 }
 
 static void amdgpu_cgs_write_ind_register(struct cgs_device *cgs_device,
@@ -104,9 +103,8 @@ static void amdgpu_cgs_write_ind_register(struct cgs_device *cgs_device,
 		DRM_ERROR("audio endpt register access not implemented.\n");
 		return;
 	default:
-		BUG();
+		WARN(1, "Invalid indirect register space");
 	}
-	WARN(1, "Invalid indirect register space");
 }
 
 static uint32_t fw_type_convert(struct cgs_device *cgs_device, uint32_t fw_type)
-- 
2.54.0

