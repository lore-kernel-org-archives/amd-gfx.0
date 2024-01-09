Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C223C3DA6E
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Jan 2024 02:06:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E0C510E357;
	Tue,  9 Jan 2024 02:06:57 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2059.outbound.protection.outlook.com [40.107.102.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 99E0410E36A
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Jan 2024 02:06:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CMT3IVeJmTxZykKQOitKMigbZM/6RVbkETjW/7wwbFsjQ6gd5IHc5LZNK68wNEbJOvam3ofKCVNFas8mDngdLPQw88R4Oe0HeEmoWzAICxJdhELsb/4axbQIlpw9ULbG/xePQxFN5zmvqDuAnSq1eFKZuIMJ5ALvwQTFn5qJjnsXyle/DsjD3flIxzWxszOthlJZos8KQeozPBmqvFvQLDm8IFE9HDeXKJz65PARP3hpSEDG3l24daZiqoPgNRhZkbHTvoncvhE5BGmiu5bk6NxFG5CKSpRkgnpEVdohulGhxnosaRME0SscOA9Lir4chHgXl9NXJ+aXszs5cCV1Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ymqCexWH5MTe6ko19gpttyv48AfBc9epdD8sOBMd4JE=;
 b=XY88e5pKiHqE5aeSLEWjt3kCseGWqZ6lgG5jYSDkTs1aGwdEGkWJ4o7SmMDJaV/GIeJ2TbHAVUsQO4nYyMfl4+sjSynM0uv/fBs0jbCJSg8U85iz5bWzMC57k4ZOwcTwVEMGvdlyVXO/MrCvWzM+s6TFbzrzOQqFfl+pO7TGhOXHAYuWc7PyaXvyt2Pu3pYYZ2ys6Bs4YEkmg6xjzADDcZcQyFD+zrWDzACwdWsa8yVSOguM1NHAX/F7UuA5gjnlEm/nKpJhEuc5Jw1ANzuhv9YxyvYlEnoDLAGSmJsHa3OoFipf9bQCaX4zVHHqQtIQfYFxv4zhqPVvgntErNJM3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ymqCexWH5MTe6ko19gpttyv48AfBc9epdD8sOBMd4JE=;
 b=cC34j4qZw+Fw/NFtVsGyqHjTu+NVcJSi0q0AgTukr4ghu4s8aUwwGHJJ30uzKWFIbLSk9TmKQYsXv9Hw2mBVcofFUvhiaU8MY60ar93mliIcJ/k/eaZhDnpaQ8OKmQX8tpY29UmnzELzcdVSzZG4siHK0FCDjTAR6ESORYo/W7Y=
Received: from CH0PR04CA0096.namprd04.prod.outlook.com (2603:10b6:610:75::11)
 by DS0PR12MB8366.namprd12.prod.outlook.com (2603:10b6:8:f9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Tue, 9 Jan
 2024 02:06:53 +0000
Received: from DS3PEPF000099D5.namprd04.prod.outlook.com
 (2603:10b6:610:75:cafe::61) by CH0PR04CA0096.outlook.office365.com
 (2603:10b6:610:75::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23 via Frontend
 Transport; Tue, 9 Jan 2024 02:06:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D5.mail.protection.outlook.com (10.167.17.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.13 via Frontend Transport; Tue, 9 Jan 2024 02:06:53 +0000
Received: from yifan.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 8 Jan
 2024 20:06:51 -0600
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu: update ATHUB_MISC_CNTL offset for nbio v3.3
Date: Tue, 9 Jan 2024 10:06:10 +0800
Message-ID: <20240109020610.1132395-2-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20240109020610.1132395-1-yifan1.zhang@amd.com>
References: <20240109020610.1132395-1-yifan1.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D5:EE_|DS0PR12MB8366:EE_
X-MS-Office365-Filtering-Correlation-Id: 408e8656-855e-4729-9d07-08dc10b7a64b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZJkvcP9XbLkIO4WKeheQZY2NNGcMV84Nfi13pQT55oDPWgCPFngwjONdw9Xt44UeozGhKFa940vp3XKpQHsgkDx0zJl+N28aB/ewuT5rXV7uUJMkG4RmliC77LFq6bTVkPvNf4+IEISAytHExy4jFhnw2QKjy3aVI9kPKCVk6RIjvGYdJ4aLoWn8TG/bGYxDepBsJ8de4T2bWkfT+LHXfvrgEBdM7YnXqf7vLBlLI9cfhXmqrFzB3IxQ88v/UwI/fJVA5diDwHJY9BFqi2vBny0MLFcibK3BLfZAjCkWNrQwaDd2yQoJnT66Y6EyI8Q+FejQjl7yrgOoTxBGl7wb8Im06wzn8e6mnc+50OuOJqTJqiPvwwNr2nB5XvUJ81C4wmxtNkeCBV8yNMmjotI+dVnjp5w8FWSCsVs5C9gNEh/0QKn1jG4Fy1LOnXf4lxDAXriKZdTEzmudhSXwYQoOhEkBsLSh6tRm38+k+SDa0zwccjb81ORy8qHwcHQLSUoIJKJbpS6F3Tp3d0T8hcwYC0Utb2YAWaT/rf+Ft4x6uwRPc6NJJJh/V2UovNqc3Kdwc1SUvKo5wDlWKJjEZE1IVBNQ/wH/q0O2HfNEXnT4amNapcMA0j/6Bo3Pe2jaYkR5mZ9d416cnTc/CC1w1pEzGRQCwosiPEXEXknBUbYKzBmv2s6Czb0UyjgTlqAId1MPlRA/Kgc83yCrthbA6zOmQvyCAsdc2G5eZWsO/AafA+Scrdoq64GYILBBE02GQAGUP3HlGRzwWV1lY5m68MGxBA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(376002)(39860400002)(346002)(396003)(230922051799003)(451199024)(64100799003)(186009)(82310400011)(1800799012)(36840700001)(46966006)(40470700004)(83380400001)(16526019)(1076003)(426003)(336012)(2616005)(26005)(82740400003)(47076005)(36860700001)(8676002)(8936002)(4326008)(5660300002)(15650500001)(2906002)(7696005)(6666004)(478600001)(54906003)(6916009)(316002)(70206006)(70586007)(41300700001)(356005)(81166007)(36756003)(86362001)(40480700001)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2024 02:06:53.4019 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 408e8656-855e-4729-9d07-08dc10b7a64b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8366
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Yifan
 Zhang <yifan1.zhang@amd.com>, Lang.Yu@amd.com, Li.Ma@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch to update ATHUB_MISC_CNTL offset for nbio v3.3

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/athub_v3_0.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/athub_v3_0.c b/drivers/gpu/drm/amd/amdgpu/athub_v3_0.c
index f0737fb3a999..644dbae9f1d6 100644
--- a/drivers/gpu/drm/amd/amdgpu/athub_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/athub_v3_0.c
@@ -30,6 +30,8 @@
 
 #define regATHUB_MISC_CNTL_V3_0_1			0x00d7
 #define regATHUB_MISC_CNTL_V3_0_1_BASE_IDX		0
+#define regATHUB_MISC_CNTL_V3_3_0			0x00d8
+#define regATHUB_MISC_CNTL_V3_3_0_BASE_IDX		0
 
 
 static uint32_t athub_v3_0_get_cg_cntl(struct amdgpu_device *adev)
@@ -40,6 +42,9 @@ static uint32_t athub_v3_0_get_cg_cntl(struct amdgpu_device *adev)
 	case IP_VERSION(3, 0, 1):
 		data = RREG32_SOC15(ATHUB, 0, regATHUB_MISC_CNTL_V3_0_1);
 		break;
+	case IP_VERSION(3, 3, 0):
+		data = RREG32_SOC15(ATHUB, 0, regATHUB_MISC_CNTL_V3_3_0);
+		break;
 	default:
 		data = RREG32_SOC15(ATHUB, 0, regATHUB_MISC_CNTL);
 		break;
@@ -53,6 +58,9 @@ static void athub_v3_0_set_cg_cntl(struct amdgpu_device *adev, uint32_t data)
 	case IP_VERSION(3, 0, 1):
 		WREG32_SOC15(ATHUB, 0, regATHUB_MISC_CNTL_V3_0_1, data);
 		break;
+	case IP_VERSION(3, 3, 0):
+		data = RREG32_SOC15(ATHUB, 0, regATHUB_MISC_CNTL_V3_3_0);
+		break;
 	default:
 		WREG32_SOC15(ATHUB, 0, regATHUB_MISC_CNTL, data);
 		break;
-- 
2.37.3

