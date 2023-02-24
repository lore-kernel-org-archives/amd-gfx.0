Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AECD7C64ED8
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Feb 2023 08:33:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 36C7C10E5AB;
	Fri, 24 Feb 2023 08:33:13 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20626.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::626])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E5CCA10E5AB
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Feb 2023 08:33:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fwJDX2+nf9Hq3lub42AO1Msvf/7FwucsQAJv2/kEd87J+vsejjwQcVpvWA4Yv3Dnx8l4LxjPeiMePYSAsVLF3CVW06fJ9SFsHX5DSpsHyrxGP8ar35KbSiVeYZwKlw0hwmjuRouGGWYlIEMvC1glIdZM0+cmNphm+SIQ4AMQX6usL1bEv7CrG9PnLUjC1qW2hWTfkEHh+sqkITr5aPJrIbW9gyDcPtHfmy/2Qg2wn6IhzcziRrnKoXGS7Z7d3bO6GjEVX89qlQRYavu9GMxuq/6AUH7ILMsiMIyVzgbZ7bMIuaFvJH9kesuZIJSTEjTaZEyQckOoiLdiG8/ZoVr0vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DkKEyysO0IVWU1eCx0rBqI6jtEOU7O7z8S48TDZ6rqk=;
 b=fctQSv1gOeQC9aU/b0damQC6XRKu8UxC/E+lXXQ3ahffXiBsfTk/KpIbt78KCnmd5v177swFdqcIVcfxUFgMIfmWQjg30/ykA9M8CARFVIzTPmF14VGKh4n7LJMD/43CKSXUO/9n6G0OAwMTlU2kUEahIodan0fuxMCglvxBmbyTli9cnZI1QbHhhTksWwlTooxUmp+etZ1Mj05x4mLJiq6YXa5LUQn+aoyfZCQfHLYaKXKc1xoPHosusKpWmVNpy3ua7bFRC3qjDt6HVpOkN0CeCmmxTKum0DJHQW1q4f+xWxVr/qEeHeclAejxGYRonn8Aug9WFtb1tkM2JAXTJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DkKEyysO0IVWU1eCx0rBqI6jtEOU7O7z8S48TDZ6rqk=;
 b=FQ5LOpUAPNCUrc4JN1NxYdP9p1tmbvAmUH4RGquibioR59v/fsRee3s6Gf6jSlB2Wlz7j6Vb/G6gDbFF6uv7xsCq2At83m2i4TFHuQ3Hq3Q6YRUqkMMgU+KNBf9Mn9ORGAQE9o9h8jlpxu8B76mk5ZRWaDvbHGOv4o3eLuYaOew=
Received: from BN9PR03CA0766.namprd03.prod.outlook.com (2603:10b6:408:13a::21)
 by IA1PR12MB6649.namprd12.prod.outlook.com (2603:10b6:208:3a2::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.21; Fri, 24 Feb
 2023 08:33:04 +0000
Received: from BN8NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13a:cafe::c7) by BN9PR03CA0766.outlook.office365.com
 (2603:10b6:408:13a::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.24 via Frontend
 Transport; Fri, 24 Feb 2023 08:33:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT015.mail.protection.outlook.com (10.13.176.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6134.24 via Frontend Transport; Fri, 24 Feb 2023 08:33:03 +0000
Received: from pyuan-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Fri, 24 Feb 2023 02:32:57 -0600
From: Perry Yuan <perry.yuan@amd.com>
To: <Alexander.Deucher@amd.com>, <Evan.Quan@amd.com>, <Lijo.Lazar@amd.com>,
 <Candice.Li@amd.com>, <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/3] drm/amdgpu: skip the invalid workload type
Date: Fri, 24 Feb 2023 16:32:35 +0800
Message-ID: <20230224083235.3448477-4-perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230224083235.3448477-1-perry.yuan@amd.com>
References: <20230224083235.3448477-1-perry.yuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT015:EE_|IA1PR12MB6649:EE_
X-MS-Office365-Filtering-Correlation-Id: a77372af-fd38-4864-7f41-08db1641bf40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kfjILT554ONcGPqHRRnfbVyocpOkiydurP5KFv9uLtlmv5ZOp7JmEGMdTFf956hHtGr2zCWCc0+P4jXdqn64cEds4s4T2pG9TNuNIWYvkECauAwdSaCotDxPkj2dMf3CIQfE7PqTh8FuLmNgdusUIhQ3SJOUJao/FfqqyPRr7lHzpViDdzPZUCu/uHKavcmU1FvVN9ZvoJfZikgaM1yNO8BukfGNNbLS/CwoxBN30goM0avgJpNzwqgQ/uCdu0XYh9mgR0HeAPvcEhY58dtkAbgPYSog8vU8ij8j9cahUsoU2QODAHiTi6lmX1Vfm/w/mkd2SxhV4n8/gtOjkoUGqFRWV/EUKnGQ9K2VDppLNCq6Q5Shy7IMZrER01erQvp4jOYSzq6NYuyQm5o62r3pfYouku5maMgqWchZ+E9F8RTGciZnvZMwFYc4vYbR8V6V+ztl9Vc1dAvvR6JK+5NxFX6BVqQZcGoD8+mLY/ScycAF0pme/RhBGHAqCfSKptNI5Z0yxZV/3bDjMQnQ1/SnTnqp+0bpsn8X/fATzver81Svlt8NUP34ckkqKeSSe0dZNGeWtGXats7fC100fayVVGG/Yafpn3K73ILN9E/vBppd9HY+iHEhRUnPX/N8kaev5+EzWHYY/gT8ZoAyM2uDh/fhHFwPcEWrjUXtkI0WHrD9xPjC30+oR8ovvjeXdACQcRHhaKIAfExhz2iGgpEtuqiAGp5/Bbjn8eaeiaQb0J0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(39860400002)(396003)(346002)(376002)(136003)(451199018)(46966006)(36840700001)(40470700004)(336012)(7696005)(16526019)(186003)(40460700003)(2616005)(478600001)(26005)(47076005)(426003)(8676002)(4326008)(54906003)(83380400001)(316002)(110136005)(6666004)(1076003)(82740400003)(70586007)(70206006)(41300700001)(8936002)(36860700001)(5660300002)(81166007)(44832011)(2906002)(356005)(40480700001)(82310400005)(86362001)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2023 08:33:03.9948 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a77372af-fd38-4864-7f41-08db1641bf40
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6649
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
Cc: Shimmer.Huang@amd.com, Kun.Liu2@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

If some invalid workload types exposed by the power profile sysfs node,
it will be failed to set the unsuported profiles.
So we can skip to show the invalid workload type in the profiles list to
avoid that failure happen.

Signed-off-by: Perry Yuan <perry.yuan@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c | 4 +++-
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c | 4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index aebdd9747c37..c76dced727b9 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -1561,7 +1561,9 @@ static int smu_v13_0_0_get_power_profile_mode(struct smu_context *smu,
 		workload_type = smu_cmn_to_asic_specific_index(smu,
 							       CMN2ASIC_MAPPING_WORKLOAD,
 							       i);
-		if (workload_type < 0)
+		if (workload_type == -ENOTSUPP)
+			continue;
+		else if (workload_type < 0)
 			return -EINVAL;
 
 		result = smu_cmn_update_table(smu,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index 5c6c6ad011ca..8aa3fda156a6 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -1477,7 +1477,9 @@ static int smu_v13_0_7_get_power_profile_mode(struct smu_context *smu, char *buf
 		workload_type = smu_cmn_to_asic_specific_index(smu,
 							       CMN2ASIC_MAPPING_WORKLOAD,
 							       i);
-		if (workload_type < 0) {
+		if (workload_type == -ENOTSUPP)
+			continue;
+		else if (workload_type < 0) {
 			result = -EINVAL;
 			goto out;
 		}
-- 
2.34.1

