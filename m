Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C17C4C3DA6F
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Aug 2023 15:23:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 70CCA10E587;
	Thu, 24 Aug 2023 15:23:52 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2055.outbound.protection.outlook.com [40.107.244.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9679A10E587
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Aug 2023 15:23:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FaaBB+xtLBsYW8KAnC0AzsU8hxCegHQPn+Dzad3PIjACXdTdhDz2h/Z8v1IMXVIierKeHd2VFBrO3G2XJbS3LxF/YEDUkrp2PKG+ra4o89eJ59fuxUAuWqHJjyW2/6b1J928PFIVfL5KFdUh0VQULuIn9mwN8e5ijF8HvMzpj1g3Obl8/myK+tZJqPPuU0B+lGiEYvyrNZyiE6oij4XBuxvlIcOVHq7IQ3fBkB+dsGoa4XVJAytZst8eBI0DH/VfFO3X9UVWZQu8pqdNXWX3R8vi7YjcnaiCjRSXUKaWteyStRPIYGQgHY/7RI5Ci8vPdbpnq7MLRz556OYDlgnPBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o6qMIN0uZW/i0JG/idVEtSR9daaJd1xHJkpfw59qDKE=;
 b=koNprJveq5vLuamxIEBf0h/XujlF7rR+HatKm26OEKwEgXPAzTbNtC2wWrtUYyaZWMwPCuPjX7yRYvZpNtdjuz5giJUfWKs/OxyrhbyUQWd2Wo6fiX9czaGRG8K849/eR7OPQ16RjLjj3B5Jm8JUk8Vre1WcLdFWznMff16ldutKqT09b6eA8XLeytP8oN1arX8yrYSracpCZ7C8EKN33h9nTVXZAJ4eJz/YhgXmSp903eWw3ZU83e528ILoUGOrW6J5tp+6+HI3X9ydAr2LhD+onC45eanABeBGSjf2SQOf2X47k6qX5fJcrZIfzJ6wD1fesxQQDtKYBxqO5SdCMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o6qMIN0uZW/i0JG/idVEtSR9daaJd1xHJkpfw59qDKE=;
 b=20eX/jJiJPrcQm9ZJ3qS4DAusKSIfw5TMFw5fz9aykBVDeifKsfITrJaZ+R42NAyiah74bcdyxrGWK8j5Hpo+HvP/EAtVkgrXA/DyYp8fPjaycmIA2ZWnd9tQvvty5HAj04aGVBkq53gF29vsfdolCSUbtLbIGtrS8Encc/G51w=
Received: from CYXPR02CA0082.namprd02.prod.outlook.com (2603:10b6:930:ce::29)
 by SJ2PR12MB8944.namprd12.prod.outlook.com (2603:10b6:a03:53e::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Thu, 24 Aug
 2023 15:23:46 +0000
Received: from CY4PEPF0000E9CF.namprd03.prod.outlook.com
 (2603:10b6:930:ce:cafe::be) by CYXPR02CA0082.outlook.office365.com
 (2603:10b6:930:ce::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27 via Frontend
 Transport; Thu, 24 Aug 2023 15:23:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9CF.mail.protection.outlook.com (10.167.241.142) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Thu, 24 Aug 2023 15:23:46 +0000
Received: from rajneesh-desk.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 24 Aug
 2023 10:23:45 -0500
From: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Hide xcp partition sysfs under SRIOV
Date: Thu, 24 Aug 2023 11:23:29 -0400
Message-ID: <20230824152329.12276-1-rajneesh.bhardwaj@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CF:EE_|SJ2PR12MB8944:EE_
X-MS-Office365-Filtering-Correlation-Id: 2481d635-ec73-40bd-8fb5-08dba4b61bde
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jwZSzO/v7IGNRMbChb9Oo/pZGhn4LxuHcr1inDL+zOn/jchRX9io/K1E5W0WV3fl9mlDfdBDKCr54B6XKBVG5hhkQOf6n39UW3VXRziJZ6aHuXwP7o4x1nE6GnN+GKuiwqZwe0an/zsGVkNuwfzEfSrOdfaRhfniM73clXbQmITluUN+Gku18zQDRTcl32jo4esRztblfXZoxyrBoMRt+h7UzF9CbtgFYTADNXyD/vAz7xHQoll8YJHB00m1yi29wNsPEEbb0gxbC1yHNvhjWbtaQFuQF1gH9sN6qYToCy6vBIm7wgnYe/PzlHNruwsb3P6s3tMm7Ye9jGll3LQhMF/jrqvpQjv7+1BlL8gVle4sJRvOuNzCt6cPIdDyAZDYB23zlJwR8BtKk0hemIwBLgXgn0o0zUZ6x0nl9vIkQlzdsGzgKMmBfFgIHFmK/KegKB1ybGiOaPq5Sc1NvtFqbp0ELPAnHJ++7IfC4yImYx/R5f670v0oCstKp/LJxvd9QMqM710wfSQ58Lka0oMvWKlEluJDYmVrZ7axSstfeIwL97KUD15BlRR6ZCaoWptKAjFQrkgH6l9ND1GnZwcHPC49/ReMy4MiDZvvsid4cC+QteMj7UV+SGKUTnLZhYy7ExqQVnSOLFfMMp6HiwSlntPb/3L/H46LeCmM3zpoR2eSBaoUgqdLKUUalYsjROYDRgRCkb/jR+Qd1CjedIeNABKE0TIOu7IZtrb49SVY3M/ffoAmoH038Ddlj62OzVptF5qBhqRVelEhIFOk2hXyNw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(346002)(39860400002)(396003)(376002)(186009)(1800799009)(82310400011)(451199024)(46966006)(36840700001)(40470700004)(40460700003)(336012)(26005)(16526019)(426003)(83380400001)(1076003)(2616005)(41300700001)(47076005)(36860700001)(70586007)(54906003)(2906002)(6916009)(70206006)(316002)(5660300002)(44832011)(8936002)(8676002)(4326008)(478600001)(7696005)(6666004)(40480700001)(86362001)(356005)(81166007)(82740400003)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 15:23:46.0537 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2481d635-ec73-40bd-8fb5-08dba4b61bde
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9CF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8944
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
Cc: alexander.deucher@amd.com, felix.kuehling@amd.com, lijo.lazar@amd.com,
 Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

XCP partitions should not be visible for the VF for GFXIP 9.4.3.

Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index b4fdb269f856..b1ca3014a9e2 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -863,11 +863,15 @@ static int gfx_v9_4_3_sw_init(void *handle)
 	if (r)
 		return r;
 
-	r = amdgpu_gfx_sysfs_init(adev);
+	r = amdgpu_gfx_ras_sw_init(adev);
 	if (r)
 		return r;
 
-	return amdgpu_gfx_ras_sw_init(adev);
+
+	if (!amdgpu_sriov_vf(adev))
+		r = amdgpu_gfx_sysfs_init(adev);
+
+	return r;
 }
 
 static int gfx_v9_4_3_sw_fini(void *handle)
@@ -888,7 +892,8 @@ static int gfx_v9_4_3_sw_fini(void *handle)
 	gfx_v9_4_3_mec_fini(adev);
 	amdgpu_bo_unref(&adev->gfx.rlc.clear_state_obj);
 	gfx_v9_4_3_free_microcode(adev);
-	amdgpu_gfx_sysfs_fini(adev);
+	if (!amdgpu_sriov_vf(adev))
+		amdgpu_gfx_sysfs_fini(adev);
 
 	return 0;
 }
-- 
2.17.1

