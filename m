Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDFDEEB64DC
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Jul 2023 17:20:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 72CE010E419;
	Tue, 11 Jul 2023 17:20:10 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2066.outbound.protection.outlook.com [40.107.93.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9ED9B10E412
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Jul 2023 17:20:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CzPZeLCeUYtui/4yJHPMWhl0tmLcjnLo6wNe3KwpzlWA0T+2ZGm3C0AUK78kTHx8sxcjfzqpu6YzBF5jSdcieTmnf1SQE9eW7w2m/Mpm1P1QfFOq18gtyhGNz+shB+VnpQfOqwlsJm7t9b5znuHxUIGq0Lj35NrYUaxPfkB09Fc1BzZ328dLRogiGkzv3Y88ulDqoACnc3V50dMhDOAY7pQNJidbniSroi3hX8frNoxsZQRKh74pH7p2CdYTpsC3i/oYfGFPUUVQi0mIopnI+qRq1pSsRwXCDxzKWRoPB41gY9iAH/rF6uHoEeO0j4BUfAQGKlM3eAmNmnK/F5GCIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xz/YHLJFv8cpjTMv09BrMbvG1GT1Li1yb8wUC0iE1Ic=;
 b=Ir5mwaCiGoyrAL8ry7DxOk3TAltNIlohhb8jDlm4kFohhIRLCRuuLu0GKoWhPGMc9dQBgWyu1INvvY8FxhQRDThgoytZ2IJipdNCYvcsr1b1s4VtL96V5R3Sou8Jn26/8UBU+E/6yUjEIN9OKTtndFHXQRo1xeNAQ3R0hsAZe5Xx6nPgFBk0pco6JRWV3SSWvEXb/qGuptdkYa3xnWHCILc7K4otvtUsxIr57v5dWFj9Rbg1Hbopv76ii+b1LO4MU02cN3rc42wDu733BycY9IPsLMVfEMRaSQ2G287l363D/5+8VXFKaYlMA/p1hrwuQabTnJhV0ESvAt1qbJh0eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xz/YHLJFv8cpjTMv09BrMbvG1GT1Li1yb8wUC0iE1Ic=;
 b=yxPxWk4kF/W4a96hyTDDYImOhGbBPQj3u9J2XXlkXrJafUUzVCtAfK9ARJrhFKDKMoFIltcVDrGkmQWAdVXqCytnK6nx/rnAuU9TBjj15RLyOyO4M8M1ste2QJK2viZ3bBIyUzIUbJ3KIUR1Urq07PgbxAiE8SwNuAYgk5Yc8pw=
Received: from BN9PR03CA0219.namprd03.prod.outlook.com (2603:10b6:408:f8::14)
 by MW4PR12MB7335.namprd12.prod.outlook.com (2603:10b6:303:22b::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Tue, 11 Jul
 2023 17:20:05 +0000
Received: from BN8NAM11FT088.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f8:cafe::cd) by BN9PR03CA0219.outlook.office365.com
 (2603:10b6:408:f8::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.32 via Frontend
 Transport; Tue, 11 Jul 2023 17:20:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT088.mail.protection.outlook.com (10.13.177.81) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.20 via Frontend Transport; Tue, 11 Jul 2023 17:20:05 +0000
Received: from jonathan-KFD.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 11 Jul
 2023 12:20:01 -0500
From: Jonathan Kim <jonathan.kim@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: report dispatch id always saved in ttmps after
 gc9.4.2
Date: Tue, 11 Jul 2023 13:19:47 -0400
Message-ID: <20230711171947.2914493-1-jonathan.kim@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT088:EE_|MW4PR12MB7335:EE_
X-MS-Office365-Filtering-Correlation-Id: 85e20a0c-ffea-4b4b-e54c-08db82331178
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VVs1rgkY/1itrTdOKMRgXZ/mI0auWTk91/UMvfsbL7qRqpGs3yEcJliUU7wJJ41vY4Lto41w/XrWUw8ibvjn694uIp8T0uGlG+fzE9FLJObHu9NCCo3aJanNFQ0/EIbgmOes/TdeZ/+XxsGk7H5KrnYcU3HRXgU7Yfr/zPnvtGKafIDeCvwSyOpdAyxSvZ143M7eyhDWC7/5jy2qTs9j1TNAMvaqAnbl143RRCL+zVaEU0b/0in6Mc8RNz76Xp/+oqe/n+qoUfsmJpwn4mUdLmv6yFnZHYcXT9ztzYtuXNROp2ylM8PZXxAQBjJZDidpt5JvFTsi89Dzo8g4ZQFIhCMAZMVGdsg0tE1RXPNLuGY46zSus/K4w4dYXXmD0t2Gw1ZZ8F9eX8hKRu8sPcnP40el3EAL8wuFKxriTlScwAjiezj08MHt6Gkndffk7cqaFhlL3SQumD9JaWDWk+GU2trS/yaC6eo/7rC3jdx1XH9RMPpGPi6hJIlpQMvIE50N8uILj1KuHY6LN63qACBzTiDcVU/u1TAkkU4hsZfWwQ36+nAeyV1hNnLqpJ/3aMMfwVbDVfbJ4U4brEpzPKSziCMzCXVMXTAUx7IaIrNRTSnGBgNS6jeqO5x/N/95xIVcZs8LxF4UU6sYELi0YPwjUBWGcC2W8EXQYRrA89bWSxlOhm4DAFc9qXiPQOqSHCfMJfnFq8eBrfAwukzqga/AQ/K9ACSU0Um+5kjWu3k11Z5ED2mQQSOyuG8mmVa+KxdcBYBbmKahQD/6ffQ3ayk+3A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(39860400002)(396003)(136003)(376002)(451199021)(36840700001)(46966006)(40470700004)(2616005)(426003)(47076005)(7696005)(8936002)(8676002)(6666004)(478600001)(54906003)(2906002)(40460700003)(82740400003)(40480700001)(36860700001)(316002)(4326008)(6916009)(83380400001)(36756003)(44832011)(70586007)(356005)(70206006)(86362001)(5660300002)(82310400005)(26005)(81166007)(1076003)(336012)(186003)(41300700001)(16526019)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2023 17:20:05.0667 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 85e20a0c-ffea-4b4b-e54c-08db82331178
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT088.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7335
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
Cc: JinHuiEric.Huang@amd.com, Jonathan Kim <jonathan.kim@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The feature to save the dispatch ID in trap temporaries 6 & 7 on context
save is unconditionally enabled during MQD initialization.

Now that TTMPs are always setup regardless of debug mode for GC 9.4.3, we
should report that the dispatch ID is always available for debug/trap
handling.

Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index 1a4cdee86759..eeedc3ddffeb 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -1941,10 +1941,11 @@ static void kfd_topology_set_capabilities(struct kfd_topology_device *dev)
 				HSA_DBG_WATCH_ADDR_MASK_LO_BIT_GFX9 |
 				HSA_DBG_WATCH_ADDR_MASK_HI_BIT;
 
-		if (KFD_GC_VERSION(dev->gpu) < IP_VERSION(9, 4, 2))
+		if (KFD_GC_VERSION(dev->gpu) != IP_VERSION(9, 4, 2))
 			dev->node_props.debug_prop |=
 				HSA_DBG_DISPATCH_INFO_ALWAYS_VALID;
-		else
+
+		if (KFD_GC_VERSION(dev->gpu) >= IP_VERSION(9, 4, 2))
 			dev->node_props.capability |=
 				HSA_CAP_TRAP_DEBUG_PRECISE_MEMORY_OPERATIONS_SUPPORTED;
 	} else {
-- 
2.25.1

