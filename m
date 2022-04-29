Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38965C433FE
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Apr 2022 17:47:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 911A610F498;
	Fri, 29 Apr 2022 17:47:16 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2067.outbound.protection.outlook.com [40.107.223.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B74610F29D
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Apr 2022 17:47:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U7clW43yQ2qvcUbffMWQdepn4XVhnjpXpt3SN4oxZJSeZK3+PzDJB0c4VhPgWlWBqV0w0wV2ErAyc3Lk2LRH/vosFjCugk7gQIUxXu9H3uY0iR1ZWYPcOxZe2DIX8r6Iec+qphuHpsJGBkJttAs4sEHo7N9/iXfuIVl9zPPk6xByG5merqf4qHPQa5YQe+UxF1ocWKkrth8mIpXcknEcQwR+K/OLAGXoL7tA1ugpMPOmAAjKfzhFBMETsCn1RCMQIkuWKDX2KWm8cSh0wddVCLP2lnMlp54RyjtBXR1CNqzGiN303/OOZFKD73N69aUI1WHZ59cAFc7Lu4LleWaG7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xev8airHsvnk3LIcwamEB7/BpT8bVU2zW3k5yXNvvlk=;
 b=RV6v0zlhJ/Op7TVkJR+E1/WIe240VUv+ILgjcbZpthkaJlr0bcOWSAON2nurJanmfAPVG7ZA0oo6q8vZb2lO2iNuCeAocZA7JAvzGY6My1TR4wWW510m2AZ2CXjQe2ksfBY/BGM4l0jct54ORZoJwT6G4HAe9WTCV7v6UG9Y85NO10cTu8Yo9u987TYgsaX6B9P4/biNyK+MdvAMFoKKaG6j+w6tGGPN/yKrhyZFEuuXA/G5oP+JIz4VX566zrRFv/NJ9fG7X7k5WRhyGh4IipnKbN6chUSJoNhzjdiEBz4FKH8TD/CCDPneFMzowZqN+iktGQw2+9T7iIbfFw8wCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xev8airHsvnk3LIcwamEB7/BpT8bVU2zW3k5yXNvvlk=;
 b=IS8u36CfM9FKyIHkg+FREzKa9RPMKTkin85C5SSAq8mGBj0Q8UEYahOio4dJfx8H+4nbRdo22TC0qu8cWy1JJNJLzrJO4SRTghq0R/Srfvz7I4k+UKrgIHOjyigc/6BreVN4YEU/OyxM7DSCxVkZMTbSdkgzOjFFlovoV1T5IZE=
Received: from DS7PR06CA0015.namprd06.prod.outlook.com (2603:10b6:8:2a::26) by
 DM4PR12MB6039.namprd12.prod.outlook.com (2603:10b6:8:aa::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5206.13; Fri, 29 Apr 2022 17:47:00 +0000
Received: from DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2a:cafe::c3) by DS7PR06CA0015.outlook.office365.com
 (2603:10b6:8:2a::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13 via Frontend
 Transport; Fri, 29 Apr 2022 17:47:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT050.mail.protection.outlook.com (10.13.173.111) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Fri, 29 Apr 2022 17:47:00 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 29 Apr
 2022 12:46:57 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 36/73] drm/amdgpu/mes: add mes kiq callback
Date: Fri, 29 Apr 2022 13:45:47 -0400
Message-ID: <20220429174624.459475-37-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220429174624.459475-1-alexander.deucher@amd.com>
References: <20220429174624.459475-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 332b6419-ac3c-4c73-deb4-08da2a084384
X-MS-TrafficTypeDiagnostic: DM4PR12MB6039:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB60394FD5CAFC97DD15B7DC43F7FC9@DM4PR12MB6039.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gOznQXsWvwg2iDbz+T1UfxnU/NA7PIgKDv1EABnXs9WI1Uv2SGyCHGjBFFA8k1EA8qTTI/JiielTUiQKGbBAdVhHjas5ULL+awnMqb1mtPDcL4u12+6w9yu6BwCqBeudG5BVyOkpSScSQfU6TSqWoPIPwv+s/EisOxT6fufYNaDy2F4kvGEKChJvVRFIqCCL9AzolF+caOYE4IRLiKNxLG9SygZX9CwoACoYqqrkGNuuqP1nMXYcJWPrBEgzfmIhtzc+D6XtwHV5tWHCygeNnzRaMC5eO9kLl1Q8MfSfsspwxPYIL6xWgS4cqeBIFJ+L2dgkYs75xAP8C8DNwk+bWpyEvm4/5qSX22o6B1NwHuwGzgDBESkD75Qq5lhPp2frUDSCFeTTC7JxN6FkObSiCpTnT70/4mrL4dF7KZOnElPVbLBHb61hODtgi799QXir9R9cKihNaa8Jakxvk7KDtkM/390mOjNwdWdZ4y7wLWsHVLnO9TgvwaIfWJR77QOHZyyd3jSz2D2EXTz3qF9GmFbvPcTWbJ3z88h14sDPCKm9+Aq+Nyd67l6ITPg71f/wAtnW0ARHIuiUvCJ4F288VGmWSvpafyu2VIMZkATo/npc3UoKp4XpYBazPr1+qO8WafwLu8ktbNOVpLZarYXbkoE1rxBl3cYP9HLm0Dxf/DlwG7V4IgO9Vkio8Fl1oCNdRWxE/TEciK+/lK5l5WL9ng==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(186003)(40460700003)(36756003)(36860700001)(47076005)(1076003)(82310400005)(16526019)(426003)(336012)(2616005)(4744005)(2906002)(8936002)(5660300002)(508600001)(70206006)(316002)(54906003)(7696005)(6916009)(6666004)(356005)(70586007)(86362001)(26005)(81166007)(8676002)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2022 17:47:00.6139 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 332b6419-ac3c-4c73-deb4-08da2a084384
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6039
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Jack Xiao <Jack.Xiao@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jack Xiao <Jack.Xiao@amd.com>

Needed to properly initialize mes kiq.

Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
index 91b020842eb0..117c95acfd48 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -109,6 +109,9 @@ struct amdgpu_mes {
 	uint64_t			query_status_fence_gpu_addr;
 	uint64_t			*query_status_fence_ptr;
 
+	/* initialize kiq pipe */
+	int                             (*kiq_hw_init)(struct amdgpu_device *adev);
+
 	/* ip specific functions */
 	const struct amdgpu_mes_funcs   *funcs;
 };
@@ -204,4 +207,6 @@ struct amdgpu_mes_funcs {
 			   struct mes_resume_gang_input *input);
 };
 
+#define amdgpu_mes_kiq_hw_init(adev) (adev)->mes.kiq_hw_init((adev))
+
 #endif /* __AMDGPU_MES_H__ */
-- 
2.35.1

