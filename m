Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CF09C46CD2
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Dec 2023 14:40:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 81BDF10E5AC;
	Wed, 20 Dec 2023 14:40:42 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2065.outbound.protection.outlook.com [40.107.237.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 07F0510E5AC
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Dec 2023 14:40:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fIpKa6d3VeFYpcr84JpbWH7SXWJwN6lHjuokCOubcser3pOEQV+BmkUBo2IzuI3aPe7TD/Qy968Ol4jxHFkttqAbrEOlzcWIfrPSTQ6yc73zmfA35kH7VAh1cXDJQZwmayuaC7w0pu1ZVLFE+PqEuQ70AFl+P2AFhKU7iBT54sH68GlgxBHJDA6ivXssYjOV+L1olzrmAhUp3/JXxrqM89jlrFOa2COuJyCgmBMnqmFMSya7xE+VhMxdNGhWK/EP10nnVGZ2jBPjO4mmZYvsz0VMMFcaHIV7GR0M06we7YdCsit+dBJxt8zKA/wR4ld1wihPgPqdQd0aHm5b7CWPzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Q3g/x3Cz+IZP0MifmuINEMiG0xExNMsly58/J95phI=;
 b=UUXwWGmDe7WBbJgvZErYrUMcKKgBFFm3BABlX7wBsxFd6O/Lw1maDxXJzuAFUDRiXhpEGc3MyU5zOMLD2RcACGo41MZocTjKBU8UT7vtDVWCxtvZiCxf2UmUCdv/+lxsSTGOy6qLuz0QMPOH3Qf1xf4c7SUEMMq+XpszQ6o/wMYey/FZWYAQEY3hx2JjHD5HIlvEPk6il9Z5cEthsozVkfDo3Pszz/d3DRHq93XTkxPOvYIqB/BmqZBTnSqy1DG/d3HZbJWPWJCrSBWEsuXrediclw9FImULzUCyUMCvEbPM5Vi/5Vx1jB+rJEN8bP2BN+CRkLSCE+tDKEJVxlAqIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Q3g/x3Cz+IZP0MifmuINEMiG0xExNMsly58/J95phI=;
 b=m3Kudkz39tHL08bso3dBH3V36CzKuJS6UG7YiTIDXDIL9jxbF5ZO3NJRHAMP3y2MtkY1pQcZ1FiKdPQrIT0OJK3wG0jIsb2NYzAt6RzHpwNdCPj83tGeZx7X0VuQFabdeclGK3PEKLBG6KUZcxdHXRzidspH5EW++bOLk6dx+oA=
Received: from PH8PR22CA0023.namprd22.prod.outlook.com (2603:10b6:510:2d1::21)
 by CO6PR12MB5409.namprd12.prod.outlook.com (2603:10b6:5:357::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18; Wed, 20 Dec
 2023 14:40:37 +0000
Received: from SA2PEPF000015C9.namprd03.prod.outlook.com
 (2603:10b6:510:2d1:cafe::ea) by PH8PR22CA0023.outlook.office365.com
 (2603:10b6:510:2d1::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18 via Frontend
 Transport; Wed, 20 Dec 2023 14:40:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015C9.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.14 via Frontend Transport; Wed, 20 Dec 2023 14:40:37 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 20 Dec 2023 08:40:35 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH] drm/amdgpu: Drop redundant unsigned >=0 comparision
 'amdgpu_gfx_rlc_init_microcode()'
Date: Wed, 20 Dec 2023 20:09:44 +0530
Message-ID: <20231220143944.962364-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C9:EE_|CO6PR12MB5409:EE_
X-MS-Office365-Filtering-Correlation-Id: 64176078-29d0-4975-625f-08dc0169a1b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jLd0nwW7aOPgCp6LQ/9Esci1zBONMQ4aO9smMMQdGSjvGtPAksg+6moOI1YfHtiLoornatYlPA3ojew/zcdW1oEsn4XQifYZX38cBjlQXALEZYXAE5j3pGfur7yJR9Jcg9nkcqfkbFRPQ7DKSwWE7iKq0xRlVRt612wm8V7wgVjN6a3eCTPlx9CyOfeszvxw44DAG22kYjPuyrl8L4KA94D2O1HmIHBcMAQFdagEGoDg9UDY9pU13WJ4kXwpY0EQ2HbPgO5X2WtGuBww6isGbsWMPsbhh38ekrXxSMTBUHFExnkgKPcwLUeRg3cGer5eU6D+WVLbgj0ropfRp/IaIeWdTB1K6/T9zYs3yVIM4ZmLZQxl4AqY9z838n5V3C1X4SjXK9/TwywuGWiLJTTk9Uql9ZNQ3M3cFLCqWM8TICvA/Ac20rIKlcKLFNzVK8ydoaYj6wVtLDAgirOtZWueXb0cF7sacsN4WNkKXYACgLwlg3eDEV+E7SWXXeEwC2JNPt6nOD1yJf/U723yM0Su2pb/V474FIot33riDb2tk68WIKZ3kdHBFhqNzsZpFAsakRPjUO3npsmUsTAMrxYtgxeIOE9VBk/EGZQBICSRBCl4HXnvxhct47z8F3vMwwAlJUVglIbMsCwiavB2aGwuIEpvKlYip0wgLBJdvFfwnjiu8rKc2Z/A/aRqhnRciZM7Q1ejobtBidBviBBIlSOz2hu29RHAMQFf6gQKYYjzz0/yFcduIHgV98+xW5+qgMLDlFDOjMj1B03l2CztiECgLg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(136003)(39860400002)(396003)(346002)(230922051799003)(1800799012)(451199024)(82310400011)(64100799003)(186009)(40470700004)(46966006)(36840700001)(356005)(81166007)(82740400003)(7696005)(41300700001)(86362001)(16526019)(26005)(36860700001)(36756003)(83380400001)(426003)(47076005)(336012)(1076003)(2616005)(5660300002)(2906002)(8936002)(8676002)(4326008)(6636002)(70206006)(70586007)(316002)(54906003)(478600001)(40480700001)(110136005)(40460700003)(6666004)(44832011)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2023 14:40:37.4261 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 64176078-29d0-4975-625f-08dc0169a1b5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5409
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

unsigned int "version_minor" is always >= 0

Fixes the below:
drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c:534 amdgpu_gfx_rlc_init_microcode() warn: always true condition '(version_minor >= 0) => (0-u16max >= 0)'

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c
index 35e0ae9acadc..2c3675d91614 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c
@@ -531,13 +531,12 @@ int amdgpu_gfx_rlc_init_microcode(struct amdgpu_device *adev,
 	if (version_major == 2 && version_minor == 1)
 		adev->gfx.rlc.is_rlc_v2_1 = true;
 
-	if (version_minor >= 0) {
-		err = amdgpu_gfx_rlc_init_microcode_v2_0(adev);
-		if (err) {
-			dev_err(adev->dev, "fail to init rlc v2_0 microcode\n");
-			return err;
-		}
+	err = amdgpu_gfx_rlc_init_microcode_v2_0(adev);
+	if (err) {
+		dev_err(adev->dev, "fail to init rlc v2_0 microcode\n");
+		return err;
 	}
+
 	if (version_minor >= 1)
 		amdgpu_gfx_rlc_init_microcode_v2_1(adev);
 	if (version_minor >= 2)
-- 
2.34.1

