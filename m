Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A64A7C77B60
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Mar 2023 19:27:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5EF3610EFB1;
	Thu, 30 Mar 2023 19:27:20 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2084.outbound.protection.outlook.com [40.107.95.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C5A710E33A
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 19:27:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U1azCO336X4BzjX/351KR0Qw29OfyJ7KDSjMpg5+br28FBdEiSXRHg8kTICYxLkumaR0eHz5MJAMe1+M60cq6sEeDcHfB9xpUDOJDCkA9fh7uKlYmcd/fHrv24F/FS7JzV/Gyp4RmuPDU0Y+6W3aq8xlm196ACrNwtjVBP+LOJVx7xSzXoAHE6epJZXqyQECBxBRiBDfQnyrZogmuNSrClSJFCa+PtPPtfI3I5GokPJhrAG/6LkfR20K5LrKXokZUOLUbw824r+zWt5Vr9IQZncfPlQEFMtD6s5n0xjbl60ttbuoQu2+kYTIp06lbSDJiRWR76QfwCnrQnXhpadHsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CNiprUSjkGjmwaiXZVD1mWA3wmXHtx/O0El5NxrHfco=;
 b=Q/quCxcRJJ4iFaaekXt1CCQ3MLHhwg66f+4uFQe8W/qn2ZVP3XuhAOAhiTiaCbs0r8V+bP7naIgqKhq21Ad0u7VWa6gF0jcBfX044sBoartWd2o0rGwhxG9IE8VE8RCrCfM4AqYOSlkxQjjnlvajGjUdgn+qVYUO0zAr3VmGxM7f7Ne73ZUd6tFrVKDhstuMNZA7iHGVC1roPO7wtTwskM/4gKsgEt1TL8GbSfhaq3eAiUfkMdr7F14kuScHh3yAknJ22F5Jkhwix6xMvKcNQmUbCT4ILtnz6MEhoDyMV8oKD+SuW7j2TI7SvjDQEEBTGh+zLCM8NkqyrlDI1MpYbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CNiprUSjkGjmwaiXZVD1mWA3wmXHtx/O0El5NxrHfco=;
 b=li4L6oY9qUu9KTe9Y4IlLUMaJ+3E0TKDKxScBBDOe4jlVfmiEFJca2RW8xrwBeiHtkerWzNswgtmkJZbgxN8jYXTkAoKC7KRoT/gdQ6tF9AeAibSTegMrsTxb0YOCuebo31Fs3W1dTZod8hLplFJUhQ3Utqxw2XOE6R7YJN55C4=
Received: from BN8PR12CA0022.namprd12.prod.outlook.com (2603:10b6:408:60::35)
 by BY5PR12MB5013.namprd12.prod.outlook.com (2603:10b6:a03:1dc::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22; Thu, 30 Mar
 2023 19:27:13 +0000
Received: from BN8NAM11FT043.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:60:cafe::de) by BN8PR12CA0022.outlook.office365.com
 (2603:10b6:408:60::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20 via Frontend
 Transport; Thu, 30 Mar 2023 19:27:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT043.mail.protection.outlook.com (10.13.177.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6254.21 via Frontend Transport; Thu, 30 Mar 2023 19:27:13 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 30 Mar
 2023 14:27:11 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 5/9] drm/amdgpu: fix kcq mqd_backup buffer double free for
 multi-XCD
Date: Thu, 30 Mar 2023 15:26:53 -0400
Message-ID: <20230330192657.1134433-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230330192657.1134433-1-alexander.deucher@amd.com>
References: <20230330192657.1134433-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT043:EE_|BY5PR12MB5013:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c17a84f-9182-483e-24e3-08db3154c3d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Rf85f7bhdCLgQ6wKXLpeVzP1EgF8ORpcKDF+u0mePia0QUlfcTw0eTVhEmvk1P3tbeCoYZbe3mVjdjgJTHWSVcS/LpvQPJvTENOr1jNUxNl7YfCJxGNJHGZc+Jhue5LUemyK/biVEIngn/jtgXUZ24vRl1ye9Jfwnj1H9CkJLpceYAj0OiA4SCSwvkBUrsD/ob8cPnLJ7saw24YIDpg3i17yRqIyN9gVwU0uGKnHarZkc21khq8Ut8NYpIn1z2Jrptz9/JcMV7zkNW7p5P4SqAzEsVx0DAgq7BdVkBQSxHRjxGP5vq65g8/vPNenhIUcV+GO7U7xAjnqv9EvGhJRU/IYT4mMrq/s+sO3Bal0NpH/OWWZ+FADsgJtXv2X2UfTkZ5ymtTt5pkxKneKUqMI4CjovcyZsGMjSPb5WAU9NQRAihq7kT+VY7VKIX8si3dHQ8FP0a6Mp0h9PWf9di0Kju5/2yDIYDRluAAcH8yHy93AAwaw7b+l0ClKnXo6t25V4DfXju1heYe3hXK9BgtKdXp5Am3sL9Q4SzHxlZfOItHss4VTwyryI9J5B68i3feajSi/T6WCVkL3rcgUKoW59+eal6ps5FubxD/ZdpRM63ItWFSuB/c1ChZ7ADgPfcLyW3EC+KjegmrEypL9XDuvExlsAPMN/0VK2Oy3dL8dxM4wX0Celk67YXO0E+ZF+XkgfvO2YuJ7YpdTfUJNZGr85Nnu3dGZPZbd0+9J5N6GO4U=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(346002)(376002)(136003)(396003)(451199021)(46966006)(40470700004)(36840700001)(4326008)(186003)(16526019)(54906003)(26005)(6916009)(8676002)(41300700001)(1076003)(426003)(336012)(478600001)(5660300002)(2616005)(83380400001)(316002)(47076005)(7696005)(2906002)(82740400003)(36860700001)(70206006)(70586007)(356005)(81166007)(82310400005)(8936002)(6666004)(40460700003)(36756003)(86362001)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 19:27:13.5128 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c17a84f-9182-483e-24e3-08db3154c3d5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT043.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB5013
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Le Ma <le.ma@amd.com>,
 Shiwu Zhang <shiwu.zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Shiwu Zhang <shiwu.zhang@amd.com>

For gfx_v9_4_3 and beyond, struct kiq has its own mqd_backup pointer
rather than using the last pointer from mec struct. Then the kfree
operation on the pointer from the mec struct should be removed otherwise
it will cause double free on the first kcq's mqd_backup buffer on XCD1.

Signed-off-by: Shiwu Zhang <shiwu.zhang@amd.com>
Reviewed-by: Le Ma <le.ma@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index febdd074bc1b..f14de1c579e6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -472,7 +472,6 @@ void amdgpu_gfx_mqd_sw_fini(struct amdgpu_device *adev, int xcc_id)
 
 	ring = &kiq->ring;
 	kfree(kiq->mqd_backup);
-	kfree(adev->gfx.mec.mqd_backup[AMDGPU_MAX_COMPUTE_RINGS]);
 	amdgpu_bo_free_kernel(&ring->mqd_obj,
 			      &ring->mqd_gpu_addr,
 			      &ring->mqd_ptr);
-- 
2.39.2

