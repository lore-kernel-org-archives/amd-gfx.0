Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B997C6FA86
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Sep 2022 17:02:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9008810EB8C;
	Thu, 15 Sep 2022 17:02:21 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2059.outbound.protection.outlook.com [40.107.95.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 98E0E10EB8C
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Sep 2022 17:02:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kh2FkXW7Bz8ATv44vaRQRtDEyR07Ezr322VH/JrdSSZv1FA+0ZszPnNajD6us44uC9mMZZ3zJ94O8mu5xKz5bjWZS4FSnNwN+mWAGgX344ffBaRC5c2+5utXZNQlNI7Evb5JEtAXdPMusJ/Tz1dxgx4XD65rcSX+h0e9hiN0abM56znDA8lfEaOVfvxwzfqu1tvoKQSa76Or8XnUl0EbckKleSXTR4fLsomcGE8S6gjoXWCQdhNSONbh4evdii8wWejbXbqUegPoYQIomp5WXtO1SLs/mozxCIL1y77mh9mma9LxUW/8piCVbwyuA9nHGwHEELR585xwS/IJkgp/7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1k9a5lm1B1yBjKoO2wh+37VSyK0zdFs2zx973kunFik=;
 b=Zm4Z/CmX4x1eq8bjGP5Do+jLf8fRreWo1Xkaa1aFHC0KxuE2R3aw218eN0H8fS7Dix5xWrr8vxieeVLM+RAxe63iFzhbNIZL3Rj/0otYYp7yDhTAG1f+eDfl8uqkR4vUS1DsKpZzxTLwI+JGQoFOqBdCIlW31uK/MFAqQDIOxg1AQXO4G24T5QcCEIEOIOSVnXz3niKE4YLweiDbzuyGpUdSamRDpT+kHQcKsp7PAr/KDZd/TTVJwr/Hq+9twCms4qF5PQbLSTQJpPHhD44lbpMZ6w2VSyDWn9k66HqY9GZWYpUK/VG4gdMk0ezg0dSylxoDMBkDLVqoVlGzRJ9rQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1k9a5lm1B1yBjKoO2wh+37VSyK0zdFs2zx973kunFik=;
 b=xFMAYcQdHoKobgsWv3FgRyyuaZj/qWviSTV/YOV3O/HAwdfBJfejlswZxgKfDp1QBiyVDqo4UZzWjS7PxXcFL+e9njHpgC4cvUCtxKu/Rr1dK2+1N0Qdr215EgY6q//KwYVX3kX28s9+OVInu7poCCItpxWuFmwqIKo6NKlKZgo=
Received: from CY5PR15CA0167.namprd15.prod.outlook.com (2603:10b6:930:81::13)
 by MW4PR12MB7015.namprd12.prod.outlook.com (2603:10b6:303:218::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.15; Thu, 15 Sep
 2022 17:02:16 +0000
Received: from CY4PEPF0000B8E8.namprd05.prod.outlook.com
 (2603:10b6:930:81:cafe::a6) by CY5PR15CA0167.outlook.office365.com
 (2603:10b6:930:81::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22 via Frontend
 Transport; Thu, 15 Sep 2022 17:02:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000B8E8.mail.protection.outlook.com (10.167.241.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.12 via Frontend Transport; Thu, 15 Sep 2022 17:02:15 +0000
Received: from hawzhang-System-Product-Master.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 15 Sep 2022 12:02:03 -0500
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Likun Gao <Likun.Gao@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 06/10] drm/amdgpu: add helper to init rlc firmware
Date: Fri, 16 Sep 2022 01:01:31 +0800
Message-ID: <20220915170135.23060-7-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220915170135.23060-1-Hawking.Zhang@amd.com>
References: <20220915170135.23060-1-Hawking.Zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000B8E8:EE_|MW4PR12MB7015:EE_
X-MS-Office365-Filtering-Correlation-Id: 720e51ba-4ec6-4935-b6df-08da973c0a4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jj5RFt+ntSadAourtONZgv5ZOIUXiYVLciXmpSNd4mcsC8a2k83iQwEVekmydIKK/y60Iuz9uqSc7g/c6kgChgyYpKExPCvKIkLlS2taDhnH/i+CgIYOILWB7TPhGdCu3jJa9Hd7eFwF+AiC3xqg+nJfKXaLdh6gXsT8EhYCFx+37erbzDJ1s9wF1sZpOc5fRWsz3Noy/3W9TrtVBKviwXBcUZAjO1+QeEZ8/kmljAB+nKgtPUX5ovyC4OwhzGfJpccHmp9mvq/3vdgW3HWLOC3gWv8nibsgxnboJYAHk4zrbRrhYN5QxTWvHGeCQDgP6/imEPMm+j99w74/s9knDvgEXre7QzI4fc9c+oTkoS3yolxjOkW7IHSzagNVwNdBQXyXzjm+vSRe6KfW404xHHDA1x7sLXCQvRR2VSrbdV1xtv2WNHOzeOZMauUQtewis/GYVE+EVjAGQd+ZoGnHXdXsXxBDWm+UVE+8XLgihQXeQYhlYgwlNvO/qWpiChrvT49ew7zZbAjCbQQAWTlE2SzH7pmoPwwkdP0aYq0mfm87JwSH7LkcSTLASVJ+w8au+XpV9ATDHVgjAjYrVoYHw1YZv9MTdbQs07FHpsvgHFhiDYYMzZ98jAXhSt1OrN7JiVe2UBY1I1HhlQbzKhzbvrgnjWhtcbZC7ernTLdRyRbjeh7sm0knupjIcZgvVn5EK3Yzqx3GE9R1FSoFDEHxPqGQHgFhNChu2tsS6qqyf8auwc01f6lqVMO6Whgoow465wzkW4OUL33kMazLXFlWrIHix2Nq5hjVj3p2R1NcfhwHRVEfMA5B3KjDrdrM66nN
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(39860400002)(346002)(376002)(396003)(451199015)(40470700004)(46966006)(36840700001)(356005)(82310400005)(82740400003)(40480700001)(478600001)(81166007)(36860700001)(8676002)(41300700001)(5660300002)(2616005)(1076003)(86362001)(47076005)(2906002)(16526019)(186003)(36756003)(336012)(40460700003)(26005)(6666004)(8936002)(4326008)(70586007)(7696005)(6636002)(70206006)(316002)(83380400001)(426003)(110136005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2022 17:02:15.1259 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 720e51ba-4ec6-4935-b6df-08da973c0a4c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000B8E8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7015
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

To initialzie rlc firmware according to rlc
firmware header version

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c | 35 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h |  4 ++-
 2 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c
index 34b3290de746..8b115003986a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c
@@ -501,3 +501,38 @@ static void amdgpu_gfx_rlc_init_microcode_v2_4(struct amdgpu_device *adev)
 		}
 	}
 }
+
+int amdgpu_gfx_rlc_init_microcode(struct amdgpu_device *adev,
+				  uint16_t version_major,
+				  uint16_t version_minor)
+{
+	int err;
+
+	if (version_major < 2) {
+		/* only support rlc_hdr v2.x and onwards */
+		dev_err(adev->dev, "unsupported rlc fw hdr\n");
+		return -EINVAL;
+	}
+
+	/* is_rlc_v2_1 is still used in APU code path */
+	if (version_major == 2 && version_minor == 1)
+		adev->gfx.rlc.is_rlc_v2_1 = true;
+
+	if (version_minor >= 0) {
+		err = amdgpu_gfx_rlc_init_microcode_v2_0(adev);
+		if (err) {
+			dev_err(adev->dev, "fail to init rlc v2_0 microcode\n");
+			return err;
+		}
+	}
+	if (version_minor >= 1)
+		amdgpu_gfx_rlc_init_microcode_v2_1(adev);
+	if (version_minor >= 2)
+		amdgpu_gfx_rlc_init_microcode_v2_2(adev);
+	if (version_minor >= 3)
+		amdgpu_gfx_rlc_init_microcode_v2_3(adev);
+	if (version_minor >= 4)
+		amdgpu_gfx_rlc_init_microcode_v2_4(adev);
+
+	return 0;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
index 03ac36b2c2cf..23f060db9255 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
@@ -267,5 +267,7 @@ int amdgpu_gfx_rlc_init_csb(struct amdgpu_device *adev);
 int amdgpu_gfx_rlc_init_cpt(struct amdgpu_device *adev);
 void amdgpu_gfx_rlc_setup_cp_table(struct amdgpu_device *adev);
 void amdgpu_gfx_rlc_fini(struct amdgpu_device *adev);
-
+int amdgpu_gfx_rlc_init_microcode(struct amdgpu_device *adev,
+				  uint16_t version_major,
+				  uint16_t version_minor);
 #endif
-- 
2.17.1

