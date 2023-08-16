Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DBC1C04A94
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Aug 2023 06:19:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2107010E2E1;
	Wed, 16 Aug 2023 06:19:37 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2082.outbound.protection.outlook.com [40.107.94.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0BA7C10E2F2
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Aug 2023 06:19:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m6mdCtC+ufCByjaUh+OZf6/dQ75Be/GdbCcTkqFmo1waxqJ50HvdheCzEo/NluPTZftVoBxRNPOjYftF/Om+N26+ZlsRzEbi+b2MBsgwm3PmUMugH7BvZssgknZoOIZlULftnaFMfbQWiplV3Kyy10FHd2GjmPoYjqb028y4bSSY8IQXFPTQca1NIzOO2/WSm3A8uOq8wz1OiMpsPA+DpFLHH6AmXPWyHebRJN4qNwpi1/TKy0Myj5rvDuUDday9pL18OYHzH9vyBCe2KdELbPj8ZjBAoGiiQ/CGsLyy1X4C7swcxAObIIcKpcYzEMPoLs9+MFcTs5rWnETsw0Q0yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uDxcjjD5CobytoxSCdLqlvLDAmuuOQaZY8ocakl9lPw=;
 b=RNlWfSdkZLfgFCJrUsC0ULDuVC4kJFognAnNNt9EcLUue0rymJaXFOVverFIGSn+5LkaE2+8eqWHqRJaiVJTrkKHUi0NiFdRG8bS2iMMelJh0DyhBbP7rsR+sdN2bV9H0R763E4vUniWStg6IXZ1lDbYNrNyThFSE3LH+ZK/lQ+jrA2IWF9KiukPgdRfDsg95UJrOMxFt9Wi4Vnes3QPONGkeY2Db1kE7IdEG1K5TR91S4tU5sJ/CFByU1aBY3SwaAwk2+chpL3jGy/LdyoexJqFrroVvM/ctmwM6UXurtESzpEwZpjftnlniv9bxenSCCbtcPfz+qGirEWIo519NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uDxcjjD5CobytoxSCdLqlvLDAmuuOQaZY8ocakl9lPw=;
 b=BPrfwumu6xzeYipu6DKM0LXkHxeOmOYQYuRETmpu+DEJJK3FwHWTtWvvEhVvhr9eDNPf25srL5viifUu3q+SSJXKwA8TM8MuyJm1dyfz6mMawQBMA3xlfjBBRhBe35yamvJemL0ZNJJamPQNZb8M0yRmUKc/2fsPpPVnqwihdH0=
Received: from MW4PR04CA0230.namprd04.prod.outlook.com (2603:10b6:303:87::25)
 by MW6PR12MB8833.namprd12.prod.outlook.com (2603:10b6:303:23f::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.29; Wed, 16 Aug
 2023 06:19:32 +0000
Received: from MWH0EPF000989E9.namprd02.prod.outlook.com
 (2603:10b6:303:87:cafe::b2) by MW4PR04CA0230.outlook.office365.com
 (2603:10b6:303:87::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.14 via Frontend
 Transport; Wed, 16 Aug 2023 06:19:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E9.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Wed, 16 Aug 2023 06:19:32 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 16 Aug
 2023 01:19:28 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>, Guchun Chen <guchun.chen@amd.com>,
 "Hamza Mahfooz" <hamza.mahfooz@amd.com>, Harry Wentland
 <harry.wentland@amd.com>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>
Subject: [PATCH 2/3] drm/amdgpu: Update ternary operator with max() in
 'amdgpu_fence_wait_polling'
Date: Wed, 16 Aug 2023 11:48:54 +0530
Message-ID: <20230816061855.695281-3-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230816061855.695281-1-srinivasan.shanmugam@amd.com>
References: <20230816061855.695281-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E9:EE_|MW6PR12MB8833:EE_
X-MS-Office365-Filtering-Correlation-Id: 42853e0d-a7d6-4d67-14a9-08db9e20c160
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TEA0BO6rxc7XjabbKaa4SKJIb4NPyrUeVGCy9ZFY4rkhkSfTV7goHogGuIFAAzb3FCbCpyBJKC0qF/DonbLGBo4l3LyJimMTI49bD/Ju/SZGtprfMU+OqnS2PyIqaHqiyOs5ex0VXAbzgH1tP4t96BWSGViShX8b/9/FnS4N7aXHd9ey8Zox+7fAnAKDJ3BnJ/ApJj74BjJuK9w7bQo4ITCt6iaQyMrqlFMUbvzxm+G+NZXHxKcPcPMWOVdcLCDAtdb/Sg0o7wFiHxR2I4sN7Rq2xuHG9u+Qk0N+W6noUdbhpjljvQ2+ZaIrIjOyHvpG7WVGpp7rmN/r9rVHnRSPVgyInfTtDGuMJrvET0jxSvuXnPzWjp7q4wd3tZNgYxCdDwB94hxfOPlAr0j+UtKRRWzM1SfJbdJsPay5RUOEq1VRH6gKmL+wZgFLHc88bAuwzqQ1J5RhV0H/lMLDHMdfRCHLvZwYAgX5SNB3Ttnd/8wzxxHFE4B4tMe8ePRFBXS+u9uqa4J2v+8SBvVmRdutBd7yMVz9kjmhMiXLwqVqNv5Fo+3NJW0UpxlRlc0syX6MUco6JlSuBggIDsZEMoGhCoIohg1ITRcBDRkxJHyR1qOGGHM0mBf1Mu0uNpq4zW9HRXlOq0hm9oQDEEa3q8nWWJzEH52fXwVgwDUNBMsVKNVeHzm5HXcXGfiuut9nmbilRIOz7GPqzhTUPNhXjdOpdR5LUcpSbafoXqJZ5/fVK750rTFL5XKec3QLvQhrRHTmqbMAYI5HmzWsgOWqaxig7Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(39860400002)(396003)(346002)(136003)(1800799009)(82310400011)(451199024)(186009)(46966006)(36840700001)(40470700004)(6666004)(54906003)(70586007)(70206006)(7696005)(4744005)(2906002)(478600001)(16526019)(1076003)(336012)(426003)(26005)(110136005)(5660300002)(2616005)(83380400001)(6636002)(41300700001)(316002)(66574015)(47076005)(44832011)(36860700001)(8936002)(4326008)(82740400003)(8676002)(81166007)(356005)(40460700003)(36756003)(86362001)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 06:19:32.1779 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 42853e0d-a7d6-4d67-14a9-08db9e20c160
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8833
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
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fixes the following coccicheck:

drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c:384:16-17: WARNING opportunity for max()

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
index c694b41f6461..cb0cb354208b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
@@ -381,7 +381,7 @@ signed long amdgpu_fence_wait_polling(struct amdgpu_ring *ring,
 		udelay(2);
 		timeout -= 2;
 	}
-	return timeout > 0 ? timeout : 0;
+	return max(timeout, (signed long)0);
 }
 /**
  * amdgpu_fence_count_emitted - get the count of emitted fences
-- 
2.25.1

