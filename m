Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0602FC001B0
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Aug 2023 11:33:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F14FC10E35F;
	Wed, 16 Aug 2023 11:33:22 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2065.outbound.protection.outlook.com [40.107.237.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E304C10E35F
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Aug 2023 11:33:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MykJzoqGxb01W6ozMZGtFcB+xav/2LuNLFY8EvpQN0f3M2PMAvhsN4AJjsSL5LML76z8KW3sEi3XnZXgIIjCIwwWNJuymBQDv5nPAT05CuvwJY5YYqsFZ0YOHDWXz0RIYkjdLZ6DSSGE6y+j6B5GH1eIO+buPDlbEE5GCSSB6XWl3iGALdnPzSqBCtUkSOErK3ecD85ruWC3VHownCzt0DqKp5PiOoR/BSPmwmWFxETBYsKSHqBcY3zFPqI2Gcr1R7DfowS3TCxDpQDXoJErEI97wpDc5fgI759HFQBN3WU3t8kSlGi1ujNwSPze4K8ssf0crC9CBsYWZEFiuO3gag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CAstsDPcs0VJK/rMrx8/SDcknNRsaYRh1VoyCL4hPJc=;
 b=mcqVx2hkyJ3dRlwg0B67DP5S44TBbjde2rC80iMNvjPqlrdSJaP1iIFmKZ/2yefOs6UiPMDWF7mu7Bknaq81SeI2h0S/cklDUMgATRHpUoyPkJs6wrgFFaVCyROmN8ij3Uj4caGaEfNyvEsUmd3KRqxmOONOr3J3L5taZh+PBaPneNkwqzLCPcsYWjqszHCITrQt/lRR6WoC+22Osz4NoZAs5mQKXf8WkHdLQY14xrAP/uTIAp5QYd/8ralvXpXBX09wvwGQ6boDJP9D2Mov7gtKeSyG9zFwUpQ+nz3dltIvRAaRCoejeq2cmGAc2lXCZ4iWeobFOoTZiK3pDfK4Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CAstsDPcs0VJK/rMrx8/SDcknNRsaYRh1VoyCL4hPJc=;
 b=LOth+DgFUpuNIUcafc9URtkkxLKQ9Fu0iysIdqCU6/4+S0lPWxvUYoYKhHsDFQwS6gXeQSoIGd7bPO9J7ShxnitxqiBFbLrucIAqxztj9Dam8F/KID/qJzrOjKzuJf8MbPyerzdjNN2CL+7yXvcwNgcLybo1cmg1i13GbWyvhNY=
Received: from SN7P220CA0021.NAMP220.PROD.OUTLOOK.COM (2603:10b6:806:123::26)
 by SA1PR12MB8161.namprd12.prod.outlook.com (2603:10b6:806:330::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Wed, 16 Aug
 2023 11:33:18 +0000
Received: from SA2PEPF000015C9.namprd03.prod.outlook.com
 (2603:10b6:806:123:cafe::18) by SN7P220CA0021.outlook.office365.com
 (2603:10b6:806:123::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.14 via Frontend
 Transport; Wed, 16 Aug 2023 11:33:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015C9.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Wed, 16 Aug 2023 11:33:18 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 16 Aug
 2023 06:33:15 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>, Guchun Chen <guchun.chen@amd.com>,
 "Hamza Mahfooz" <hamza.mahfooz@amd.com>, Harry Wentland
 <harry.wentland@amd.com>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>
Subject: [PATCH v2 1/3] drm/amd/display: Update ternary operator with min_t()
 in 'do_aquire_global_lock'
Date: Wed, 16 Aug 2023 17:02:11 +0530
Message-ID: <20230816113213.716108-2-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230816113213.716108-1-srinivasan.shanmugam@amd.com>
References: <20230816113213.716108-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C9:EE_|SA1PR12MB8161:EE_
X-MS-Office365-Filtering-Correlation-Id: 6db4dbcf-aabd-424e-1201-08db9e4c96a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DFchvyX4iVBwLdAEnpG8dcYDP9xYkqpx9ddt/iJzd/EgmqFbXsB4XRvRrSGLzOL0chvoPknJh7zN4RWIF6V4hWp/G67iN/99t8Qvnjm6hfEETORjnScuw3At9tHkYWk0wG7uGeKMYsueToZgySkKyLgHfSVyUdAWXNdfvcPpH0/59Q2/CNFbyyoYTbx+aolM0EY2Xi8qkQbCHuHHK3Qy8j7KoDk3VPtqdSeNX6ncCfhjR3CFOmfG7LQN34lEI0Q369VUOPamZ8/qSDhCHlwHjzu/WrC3hLT33dOmIaRKCnJ5xePV7Pc3m3X1mRpmf60auI9LcRPqt0PUFR1ANYCWi+5E5KT8yIgNKFWHVhnn9GJ/128XALHwn0QXWaVBuJqCGiI58/hOFZIoF8XgnStfQiRJDXyAbuR/Ao/E4TLY2bKAbxEiiDrtZLIoy02I+QmN2+ZkDXSKGpWclPKYwQZ9Joa49ErAvpFhW9JCCuLn3UynQemxzdPG/SXYBtJuVBIW0HclgCb0yVQPzHGW8ozEnbmwe6G12O5R/vs5MgjS1o6HNtd9iJfaFSEKRCndLGu0jNpqHj5dnDW432luA6LkGfCA1VrppG21o9UgI7W/9KzOZr8Nzwrcs3huCQdGYWmF/wyuNtfJUKq85rIaITOfKhmMl6/gZ/AQWaiviZMTY0m5zRebnNQUNuJW5ax1TKMFn+mY+yki4+8fA073f/vu4p1r8lHXdWxaALC6uWAy8KzgxrrSAA6wiZTHPUbUQpdVFkEMmUYUl1uXflpu9HHxzg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(396003)(136003)(346002)(376002)(1800799009)(451199024)(186009)(82310400011)(46966006)(36840700001)(40470700004)(316002)(54906003)(356005)(82740400003)(6636002)(81166007)(110136005)(70586007)(70206006)(36860700001)(41300700001)(5660300002)(44832011)(66574015)(47076005)(8676002)(4326008)(8936002)(40460700003)(2906002)(83380400001)(26005)(16526019)(40480700001)(478600001)(426003)(336012)(86362001)(7696005)(36756003)(6666004)(1076003)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 11:33:18.4208 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6db4dbcf-aabd-424e-1201-08db9e4c96a0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8161
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

drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c:9079:12-13: WARNING opportunity for min()

Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index b1245b732cc9..e8c6949fa5a1 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -9076,7 +9076,7 @@ static int do_aquire_global_lock(struct drm_device *dev,
 		drm_crtc_commit_put(commit);
 	}
 
-	return ret < 0 ? ret : 0;
+	return min_t(long, ret, 0);
 }
 
 static void get_freesync_config_for_crtc(
-- 
2.25.1

