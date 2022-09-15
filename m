Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47C73ECAAA1
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Sep 2022 17:01:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 68C4210EB88;
	Thu, 15 Sep 2022 17:01:23 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A5AA10EB79
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Sep 2022 17:01:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JNmPjJgO3PoXBsjAJnjDC8LN50jEICUwLjNVePfhRYDlWYx5sEsTmFsF5j8Tuat6z1O//H+NG9oOHJKAiAhNP5o/L/+3SRmuUxV3a6WgM5+OedGRcgLf7Lq031aIen6xXeJCx82gyYscd0fFctqCkHoAFFrz27PZNw4exlP5RMHwsB+USrnrmq7/7V2085DJrESBiw8/XRKIjQqesjP7liYryE9Cpsnz611DTxDww6zvvY4D8kQJkB4XFeLVVYCXnEidl+EYsqCfQgDiqlKiU1wWaZD/KXXuE9+dP0Pv1z5HUcrB/YSaym+TJ1DUvb9uylRv7uUM8YU3miJUDz3h/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PSQu87jj6YDCAdIjK4rUn/vFmtcNMyTJkTnghID3qrc=;
 b=EannSKa5E0NywVFqdFDOHRD4XsVvL3QWkLba3xIZmpF+0601AzDXfD1IFS4zXZK+RzOAqAZ8DbSIcxOqqg0n7V81JuWFAB2kbiXmvbvaE1egGZRV8yQfZPDYtIebXZPs+Y3Q4Or/JEYCTr5D4x/sK2msZQaavkKhXf5By/N1Vr0uAFGJBZp90hSRziDi/j7/22UA7nOBgSf5ZHGd4/HxZtkmcC+6Y96dDnkt8i8NLbGfL9lVcbi8/6Qts6SFLUj3M8KBan+advYOlltR3s+Nz72K4i4zBDfxpVkJOJtbF8S3TNMl9rVLmVcQGAzPeY/S/mxVQJZkJkDd7cEl8qaCYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PSQu87jj6YDCAdIjK4rUn/vFmtcNMyTJkTnghID3qrc=;
 b=a4hlBG1ol1XAHUXonixU1RqpDwy/loSQDJcxoHAB1vO6qR9X3ZDFVbnfNS1r6MQMgIhaMVK4FHDZ45m3WBRZ3S3BVop/g3l6oYLu7whdNsYRNLPF06KdFNZa96VyVKXlOy+JgB5A7zd2HzkcP/i/U8GCmfDQTG/rl7cEP01uNNk=
Received: from DM6PR11CA0036.namprd11.prod.outlook.com (2603:10b6:5:190::49)
 by PH0PR12MB7012.namprd12.prod.outlook.com (2603:10b6:510:21c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.15; Thu, 15 Sep
 2022 17:01:04 +0000
Received: from CY4PEPF0000B8EB.namprd05.prod.outlook.com
 (2603:10b6:5:190:cafe::60) by DM6PR11CA0036.outlook.office365.com
 (2603:10b6:5:190::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.15 via Frontend
 Transport; Thu, 15 Sep 2022 17:01:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000B8EB.mail.protection.outlook.com (10.167.241.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.10 via Frontend Transport; Thu, 15 Sep 2022 17:01:03 +0000
Received: from hawzhang-System-Product-Master.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 15 Sep 2022 12:00:50 -0500
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Likun Gao <Likun.Gao@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 3/4] drm/amdgpu: add two new subquery ids
Date: Fri, 16 Sep 2022 01:00:26 +0800
Message-ID: <20220915170027.23010-4-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220915170027.23010-1-Hawking.Zhang@amd.com>
References: <20220915170027.23010-1-Hawking.Zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000B8EB:EE_|PH0PR12MB7012:EE_
X-MS-Office365-Filtering-Correlation-Id: 30d01116-3e88-4530-e030-08da973bdf93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j08103AlThEtIbgm69uXUsWZETfgtDTje23YKCDb8E6BODUjJCni7miKjCAT5MY6UOPqIdf1NSMktWTc1OvQE4hknEgIRx3Slvg7zwOH/1g5iSYf5KcQi/+8x4jCdV/rhiiFLJLLvzGucuHqx3kesUO6+KvfjyqsbH6yGiGO4/RUfEhdOrlurfnPQ9MHDX9syHbzZ1XCgtkRhQEMwuVD4QJcG3SPMeH3tY8/wrhZuQlCknhLNKxxM0S9ngC75VHfs4wbalVHKeF/5xLaCTvrp8fqyZk20gmDy6ICsAtF2RpCG0GopcEKckqmIJXfovPtkuUUyN309PsZv6lHyYFiUon0TbW83jJMmp5AmLC922a4ZGm4mJ4hvpuzLEBVRBTOIpi1NIsLj/lyHfYFHvsRdnJ2T8sada79ox3nzxYmgoTttV9VK7MXqzTIc/KLXnMys5NcRWZtno+/AwI9OyfVu5iJjuam4VYqRF+6HoY9gtWuOuyWuDcGXT7yOEzaqpbn+Ox/XozfQj1WFsPEMBQwq0cCuO3r32dQJpjQ0m5HJfNW3/j+dRsIlwXCEOJgSppZDbqvVV/2uzv7P6xoMjSsAm3eE8uI2lZRjzbIVYIXF70f/NnWY3E/fJcnxTyATe7PRhYSvcWDuBv+/gjUHZR3D1Ok5p2CjW6V+KkIcp112Lv9j2fQbZIbgQCFA8GEJMLVpwbpLMcplTWPwFxAmIFBTPzLe9uHo1+9gMN10hIy/KOcFoCbO06euUBx7KMAgtkwPtvUepYYPz+rkDy8D1B+DvPt8aX24VbL9BcoGvztJVlPWMioYE4zjb/WNWVeE/Ak
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(376002)(136003)(346002)(396003)(451199015)(40470700004)(36840700001)(46966006)(426003)(70206006)(1076003)(16526019)(186003)(336012)(82310400005)(82740400003)(81166007)(36860700001)(47076005)(2906002)(5660300002)(8936002)(4326008)(4744005)(40460700003)(40480700001)(356005)(8676002)(478600001)(2616005)(26005)(41300700001)(6666004)(7696005)(316002)(6636002)(110136005)(36756003)(70586007)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2022 17:01:03.1845 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 30d01116-3e88-4530-e030-08da973bdf93
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000B8EB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7012
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
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

To support query rlcp and rlcv firmware version from
existing AMDGPU_INFO_FW_VERSION interface

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Feifei Xu <Feifei Xu@amd.com>
---
 include/uapi/drm/amdgpu_drm.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index f01498fe55fa..61a89bc27983 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -816,6 +816,10 @@ struct drm_amdgpu_cs_chunk_data {
 	#define AMDGPU_INFO_FW_TOC		0x15
 	/* Subquery id: Query CAP firmware version */
 	#define AMDGPU_INFO_FW_CAP		0x16
+	/* Subquery id: Query GFX RLCP firmware version */
+	#define AMDGPU_INFO_FW_GFX_RLCP		0x17
+	/* Subquery id: Query GFX RLCV firmware version */
+	#define AMDGPU_INFO_FW_GFX_RLCV		0x18
 
 /* number of bytes moved for TTM migration */
 #define AMDGPU_INFO_NUM_BYTES_MOVED		0x0f
-- 
2.17.1

