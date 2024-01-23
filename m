Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ADE7C47258
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Jan 2024 15:02:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E5E4F10E0A6;
	Tue, 23 Jan 2024 15:02:28 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2064.outbound.protection.outlook.com [40.107.243.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D00D110E0A6
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Jan 2024 15:02:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=awLXWZ0VAVaFp1BAulN+t+wRhzOsSJsSuVrpI2ZZr7GLCr6nDAVburhcvEBX1UmUEpnQjyAS/aFsE4ewATD1KNhU4ZI+j7AWHhECElpuehnrq4A364R250otBXgYYAfWpbtTtqeYR4AlRa4Knsg8ty5Igg3ty9SX8eAqSJjFM/kXj7rsc2qM8PyKMp5TAycTjH5kmUQS7mdmw04BUdLG+kYkL77VwHa2v1GbDgprFsXWwRrNT/tySMCTeGqacZcbi3hrRfDHtMzOTri8NWMHDz915bFgCBR1/GXZXonOr+QQnRMVNVASlT5UDJWrE1k5dpkne6rqZX/Tjhz6d9KWZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EuvraPMVbu4ppcBgSIcZ3DPQ5ulGUeTwOJIS3sXzf0U=;
 b=GEWzgiow/ooFfbgqJuLm2qnV2B0F/YE2RhdF35nYKCGkMh1And/QA6DmKz3XuxPPlPDoaGT8SV6ZMq/kW8uD03uPWBnnss81LvZU4+rEbjsrVd5Ex6973Ymnpq4DhULM4S0PNjwNmWSxDbpO0/BhmC0yOpO4AEPAY6JebDGhX0Y3aVYPUZJXBfBixAVwZToeXOQBUYm0WgVjYJ+tEtGiosQU36puVyA5jTHkLC3vbvaJqRdvkxqXi2JRwh2qE+HgeDB+oRZmTNZVQlGM12XH+hZ6+Zvj5WMKfDUT7NV0FGbC+zxRAJaWI5X/3Z9GjKqw79AAjdl5VhC98T9krp/thA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EuvraPMVbu4ppcBgSIcZ3DPQ5ulGUeTwOJIS3sXzf0U=;
 b=mOK46mU4vQGOLWjIYXKYIedGkoWHbWIvK2p7tvoeR46ZbSKNcXR5Xek3Jaof1CVmb/NJTgNjdflOH+WvGwriN3f8T9PbQMo3qArayNal0Y5tGTnbMGowg/JLwsbPY25HH2wy4mwc1tFuqBJaQpwOSliIcw5bLOfHvtuWLiO+TlU=
Received: from SJ0PR13CA0025.namprd13.prod.outlook.com (2603:10b6:a03:2c0::30)
 by IA0PR12MB8325.namprd12.prod.outlook.com (2603:10b6:208:407::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.32; Tue, 23 Jan
 2024 15:02:19 +0000
Received: from SJ1PEPF00001CEB.namprd03.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::d6) by SJ0PR13CA0025.outlook.office365.com
 (2603:10b6:a03:2c0::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.20 via Frontend
 Transport; Tue, 23 Jan 2024 15:02:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CEB.mail.protection.outlook.com (10.167.242.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Tue, 23 Jan 2024 15:02:18 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 23 Jan 2024 09:02:14 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>
Subject: [PATCH] drm/amd/display: Fix a potential buffer overflow in
 'dp_dsc_clock_en_read()'
Date: Tue, 23 Jan 2024 20:31:29 +0530
Message-ID: <20240123150129.496102-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CEB:EE_|IA0PR12MB8325:EE_
X-MS-Office365-Filtering-Correlation-Id: 070bcecd-3eba-407d-5d64-08dc1c244b71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yiBefedGwEQsUGRp1Lw9TM5mwMmLhZkPQuHe7GlBr3SsA5mHuUI4jXJeh+Uxope33p9ahGmaUwyaz7dThqaQEk2fsjIS+1Q+G3NtCzTPNN/CYg38/hkCwp9AQWthqBfOs4Xwp0sOX4AgliDM5clmnUWJ7ek4DeCoqeyRYk5sim3V7c1rtHkvq1l97qzzf8y/cULkBHmt9++chTIMg1M+mKYDnb1fT94hL4eBWWdaFivh+65u+2m0M5g15SR8gc8Jzv5z3JJ2dN/mfz5ORNyH7/7eN6EJiwtcHfjp13FdDhP0aIOZ+y3DeahUkF2ZHIP+M2/T9Kdgtia4HQ0mOlxzZWdvR6L3Tv7Rk0dUHUCwLg9+1L5zNcdNPbh5/jsiP10BFQa73xtVe2WE39S4mKgrLhG9dzyNuQw4vqQkcgTzVvgpdIiqfSzMelnzefTG3A3tRejti1yjUm6co7OSZyRWhucVPpFUB/XAUGJnt2DundpGk9P5BKl5l9JR02b/hw5M9GPYs6jKYCeXl79VySWeA3Zax36h4rm8fPo/D7O+jht6ubxf0Z04xnzzb8BQcKlMJaTGVyUzU8Rro7syTtEAHd89SljMaoGLfs8Z2sQ4ZEqP0dxX1EGvCr4oyDxac6cIwNiAPNUDcZBOvjJ+6wdTjeMJ4cyN+D/CBYEtuinPI+kmsJyfAdSSc+DWR4UGuk4zNsJNfZl5xK2zxOKXNLOyHyZwTfjpSR1QWXsMenUN07dd6VOafQwT6SFOPTUI+jte8rTTsu4FFwbV1aMPjr8ZRw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(39860400002)(136003)(376002)(396003)(230922051799003)(82310400011)(64100799003)(186009)(1800799012)(451199024)(40470700004)(46966006)(36840700001)(110136005)(70206006)(356005)(70586007)(54906003)(81166007)(8676002)(8936002)(40460700003)(316002)(40480700001)(4326008)(47076005)(83380400001)(6636002)(6666004)(7696005)(82740400003)(2616005)(26005)(478600001)(36860700001)(41300700001)(36756003)(5660300002)(2906002)(44832011)(336012)(1076003)(426003)(86362001)(16526019)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2024 15:02:18.8482 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 070bcecd-3eba-407d-5d64-08dc1c244b71
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CEB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8325
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
Cc: Alex Hung <alex.hung@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Qingqing Zhuo <qingqing.zhuo@amd.com>,
 Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Tell snprintf() to store at most 10 bytes in the output buffer
instead of 30.

Fixes the below:
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_debugfs.c:1508 dp_dsc_clock_en_read() error: snprintf() is printing too much 30 vs 10

Fixes: c06e09b76639 ("drm/amd/display: Add DSC parameters logging to debugfs")
Cc: Alex Hung <alex.hung@amd.com>
Cc: Qingqing Zhuo <qingqing.zhuo@amd.com>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index 68a846323912..85fc6181303b 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -1483,7 +1483,7 @@ static ssize_t dp_dsc_clock_en_read(struct file *f, char __user *buf,
 	const uint32_t rd_buf_size = 10;
 	struct pipe_ctx *pipe_ctx;
 	ssize_t result = 0;
-	int i, r, str_len = 30;
+	int i, r, str_len = 10;
 
 	rd_buf = kcalloc(rd_buf_size, sizeof(char), GFP_KERNEL);
 
-- 
2.34.1

