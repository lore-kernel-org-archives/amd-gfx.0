Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CAD6C4332F
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Dec 2022 22:11:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E604710E580;
	Thu, 15 Dec 2022 22:11:28 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2052.outbound.protection.outlook.com [40.107.92.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA56710E584
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Dec 2022 22:11:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E6vSYvSkoFEjyFjto8XtM+rkqXA7H3Zu5l/Zybk4tluDM8eRE94AhJ4GeUqiUaNDHRaOCudxa17XK5TFxNCIg9iuvKooZTuxnhR73fVxZEJTQLk7l/AE8iTE8M2G7KFuIy4VF/Q0qCnvwWYPkOcBNeVE2qNAcWkOjQGlE/C5aMYUo6QLony2y6n31zvRoiLZ8+UO2mBzPGDfwf5WlrvdGC8PpHeMzOrD8Onj3yPUNbQB8SSe3swB8ZJKqAyLASAsfhvgQ6QS2xZwt567wPQi3Evi6pldOiqXNxGR+63yzRw6fcD159moIH6QO42HTjwAEKR47nz9okHPg4IKAFA/ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SzNbnk6yBRWUJ2z0AVrC2eKbfKV1jixBU6lQoAQhoQQ=;
 b=W3XqcQtlsd9ToTJsZ8x7LRw9sOrqnPyq6wX/UmSoLzQy8QV9xSM818/Dsxk67X6WOKS6iWGUAbb0wJxhyDoO0TGKy74vF/SNQSIwKULotsFU9wd6BlngkWI+VDHXHbIT0+HiJYkyMVhrAwxk9A5V/uP09uIl2Q4xlMXi+Liba7ZJQV69fjmP5cFritB/5AxkC+DuLziCwXik0Iu2mgTIRbNmzuolm3IqB+HQqFRkQKL37BQ+ZEMxj+dycVI0PiPIg1RfMLr31Knj3cSAAJprHOXRH3pMzGlrhomt+IFKdNmUCvVdGlQgWE8CS4H/YORZffnDi63giUbG1fxaTtVjgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SzNbnk6yBRWUJ2z0AVrC2eKbfKV1jixBU6lQoAQhoQQ=;
 b=u4vXd3URfXz6EfyRnf34Y38BUVWCrFwm+8IxAJk+xgxM/6K1EXyprDHix9zdX/2U3atyiIqfz9w7AFn7lKkLaWz5tx7meHMDr54jrsXyafKDpykJdYH0FdwmLyKRQ0o39cblu9fWzwiPNIQRzYlqQj7KF1iSgdIuM1gyf6URGJg=
Received: from BL1PR13CA0315.namprd13.prod.outlook.com (2603:10b6:208:2c1::20)
 by PH0PR12MB5466.namprd12.prod.outlook.com (2603:10b6:510:d7::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.11; Thu, 15 Dec
 2022 22:11:17 +0000
Received: from BL02EPF00010209.namprd05.prod.outlook.com
 (2603:10b6:208:2c1:cafe::89) by BL1PR13CA0315.outlook.office365.com
 (2603:10b6:208:2c1::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.12 via Frontend
 Transport; Thu, 15 Dec 2022 22:11:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00010209.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5924.10 via Frontend Transport; Thu, 15 Dec 2022 22:11:17 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 15 Dec
 2022 16:11:14 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 4/7] drm/amdgpu: don't mess with SDMA clock or powergating in
 S0ix
Date: Thu, 15 Dec 2022 17:10:56 -0500
Message-ID: <20221215221059.509565-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221215221059.509565-1-alexander.deucher@amd.com>
References: <20221215221059.509565-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00010209:EE_|PH0PR12MB5466:EE_
X-MS-Office365-Filtering-Correlation-Id: c2ec2f1e-4c52-4ff3-23dc-08dadee949a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xIsc+M1hB1Uy1MzcPm7Tf4AqTQ7FcjigiMClUhz9wdA+3hZnaJdWI7IiRGQrDMoHX6o7CE9/IG02CbCjGdNpaGE1MMEjHjYVJRlZuph9cjx3HvjzJPR/CgzNM05+FPjyEhm9RpV8MRE+v7lWZ3AaEMX0fQG6fUMdhuULht2NsLyXJtBtsZQZxcz3yeq37r6TAEPA3PQRk7mRVrR6T3WDKpWYWOd5yLw0K+Hs60gysqfG+5K/pw3gFYNMNhSwJ+r2vUkdCZ8Zz+np1OSl9O3F/EhLcqszJzeX310lvRuq+Xnwb4OZ0GERfsRMIk6Q1njvIclzx5fFgDtp3JHoZtIrKhySTKgB1e52NpLInaBXzUGY16itItjJ87M1TEF+5gPXi5QD+nfqu0s2K7ZI42clpsMiaB2JGVP1/e++SGhXMr7V+zoWd/Dfj+SfzintPNLQCPo55rrBpm1Zw7VWrw1rWtsoCa7gi1feHJUGKe3bqVKR7RLay7GNXrjMuDFNWq+hjOHpqdkSWYplMpHHsgPJsNCz/3V5r6j3nsfYjsFfhbjF2Nd9/id0rb7FZuCVYIdu6OiaiMw92VTZh9/qHh6mIOwFrOZ7R2sNXLCNMDU0O4R1vYxPUlTqM9DeTOMJY11z7SqvcTBD3ItCwHfQK1UiFZWpIU6xOilkqKbDohwfQwQNE58agujiZQ8b5EcgHXYNQUA2Zh8xfSU3iUHMoXEhMfKZKBnRqbVTJ+xcEhuGPEUamUWOo5Najta/ALS14g3RTWXS2ymCn6LBpj0ZgFkSKQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:CA; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(396003)(346002)(376002)(136003)(451199015)(40470700004)(36840700001)(46966006)(36860700001)(1076003)(82310400005)(336012)(16526019)(2616005)(47076005)(86362001)(426003)(40480700001)(83380400001)(40460700003)(36756003)(81166007)(82740400003)(356005)(316002)(2906002)(8936002)(41300700001)(70586007)(70206006)(5660300002)(8676002)(4326008)(6666004)(478600001)(186003)(26005)(7696005)(6916009)(32563001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2022 22:11:17.0601 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c2ec2f1e-4c52-4ff3-23dc-08dadee949a9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00010209.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5466
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

It's handled by GFXOFF for SDMA 5.x and SMU saves the state on
SDMA 4.x.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 64660a41d53c..a99b327d5f09 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2581,9 +2581,10 @@ int amdgpu_device_set_cg_state(struct amdgpu_device *adev,
 		i = state == AMD_CG_STATE_GATE ? j : adev->num_ip_blocks - j - 1;
 		if (!adev->ip_blocks[i].status.late_initialized)
 			continue;
-		/* skip CG for GFX on S0ix */
+		/* skip CG for GFX, SDMA on S0ix */
 		if (adev->in_s0ix &&
-		    adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_GFX)
+		    (adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_GFX ||
+		     adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_SDMA))
 			continue;
 		/* skip CG for VCE/UVD, it's handled specially */
 		if (adev->ip_blocks[i].version->type != AMD_IP_BLOCK_TYPE_UVD &&
@@ -2617,9 +2618,10 @@ int amdgpu_device_set_pg_state(struct amdgpu_device *adev,
 		i = state == AMD_PG_STATE_GATE ? j : adev->num_ip_blocks - j - 1;
 		if (!adev->ip_blocks[i].status.late_initialized)
 			continue;
-		/* skip PG for GFX on S0ix */
+		/* skip PG for GFX, SDMA on S0ix */
 		if (adev->in_s0ix &&
-		    adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_GFX)
+		    (adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_GFX ||
+		     adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_SDMA))
 			continue;
 		/* skip CG for VCE/UVD, it's handled specially */
 		if (adev->ip_blocks[i].version->type != AMD_IP_BLOCK_TYPE_UVD &&
-- 
2.38.1

