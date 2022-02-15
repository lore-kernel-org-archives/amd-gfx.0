Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC458C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Feb 2022 19:23:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6CAAC891CB;
	Tue, 15 Feb 2022 19:23:50 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2040.outbound.protection.outlook.com [40.107.93.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 66A1F891CB
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Feb 2022 19:23:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mqAVapmbSYWXRdX49pcPENlBA4kc7b501QTsONwwpE61AVyeYbDAV8HxcU837iuPsFVB4w0ZiXM+BlODTpk+/TrtQIyQQWT3fYcbyy2ujdRI4g8xBQmRhA0UK3z92t2Q7LyFS/3weNS+hc/1zM4TU0eLQWgeALWZN6TgsCq1dQ6/ZOmn3B6Hk6U0R8NXNmr30FtQPIWHFd/ZaniCWV8uarO53D6T6F2atof8U7sz2yTXdXVpIqkfjHbdP5l+rn7tIjU9gaZIsnEKYTCjRqjcU9GFPgv1r8jvnhc0oOmdHR32FhyjjyfkoDbPQJOZD6ArrgkzQehhIHieyaaK5k/1aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FgxgkcAThj99WB6MqegDp1tnvEZVOpF/bKR5zn/UGdM=;
 b=cUunRonIFgTKcLdYKQ0j009EVRteFvbXMdc6WaFnvUKn0KZL3nS7NpCnGlAKHRzDV7b2NQ+X3Fx4SOe2RRRq0nn/t40dXULMJ9F9qnG9C3LTKfjdFHahPriIRRJcj4zSk/nM5l9Y0jKggE2i+GLUGQl/0Td0Wj/ikSGipXAydk4aDh0tg+G1vHZw1fXjg1gnEUxD/VEX+ILM8IFZ1y0UVa7p4Di+/MzTtB+57MOi2qAYp387KvjdMyeFNRUCeuOqbPV1ZDbkaLHKRoMxySUH/BqGNtqmYNvbin/EOhgBrjh2rdUEkQQJEm0E6oJDqwgPWQTqzLuGOQ7xei8IjDDkeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FgxgkcAThj99WB6MqegDp1tnvEZVOpF/bKR5zn/UGdM=;
 b=J9PRz0z0CkBgkEaz5kg7qHOHKnXZBKW+lfBxo7RIZzFjXleFK+r0aKjmGbIMFI+7LmqcPyEWJ70ZTzo+lhSlNWx2KuYvKzvD58ACyPaSiJjfmn5g9EjHlK2k2/RSnCSCol4FOOnkuVvnzPrZKRTXmy8qHk8QyYqNNvgHHSht7Tc=
Received: from MWHPR21CA0026.namprd21.prod.outlook.com (2603:10b6:300:129::12)
 by DM6PR12MB3596.namprd12.prod.outlook.com (2603:10b6:5:3e::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.18; Tue, 15 Feb
 2022 19:23:46 +0000
Received: from CO1NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:129:cafe::7d) by MWHPR21CA0026.outlook.office365.com
 (2603:10b6:300:129::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.8 via Frontend
 Transport; Tue, 15 Feb 2022 19:23:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT057.mail.protection.outlook.com (10.13.174.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Tue, 15 Feb 2022 19:23:46 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Tue, 15 Feb
 2022 13:23:45 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: Add support for MP1 13.0.8
Date: Tue, 15 Feb 2022 14:23:33 -0500
Message-ID: <20220215192333.2232373-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 72999c1b-3b0b-4190-498b-08d9f0b8afd2
X-MS-TrafficTypeDiagnostic: DM6PR12MB3596:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB35963D20D6ECB83EB1A13F93F7349@DM6PR12MB3596.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:949;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xPF0YpakfHfo/nuLdh1QIvQfbQaFMD+9eTezaFcok4aHcVlRjkjlKbke4MDNkVdMIqwRFE4lPeJd3KENEJg15wiAVfH9+yrJSMyz2pNXi4RnoGVQ/SxwBwb0/32LEd230XaBEI5k35MGVNcrTwQGtCAvyiJY1fATinhvdUhPVsni0V+THqW0wj4WyHfFVmw6jEHIbaxeB1PHjTa/mQKpRM8yq7XpRs9aJDVsZnVrLxlnVbTQrngXheuk8u7yx2BfAlDCA5gDOHLlkQhcDoVcRXx9T3p940eewUmibc1M39DKijKuyZb3a5Vt25K9olPixDcPIQzNnJbPWbHKxrBoj9kR8dKc6X6xVg3sK6taFQHhDdYmGjT2hfulp6ZJi5lwpY15TO3RioIgu5hbsbhE1s1494DNKOfVty2DgV1mHMBBo1F4I8ta8900QVIUGwWEL8Cu4rCmc8/N8otdvFtaZ1DczbJSTtWbhw/D5s+4Latt2TMvbPnnT4xdH7+UoSOVuv6GfPecIv0uYnXzBepFSBu2Pf7PRD6DznznXb4F38G/vKsOKzdYJ8o4cRVjF/M6s3KY6z8A0/7fRsdqIQFnnsSxaWbuXx5ZQkbz9xsABSqHBJiJl59WbgUoXwhV1tiH5PBbKPJULlnfeKuweneNomgVNNMJsK3oGxW6nN2MBxuLAeOYV66c1JPx+Bu9oeFgOmRUZMTXsjBdyCNZZqJFCQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(36756003)(40460700003)(2616005)(2906002)(16526019)(26005)(356005)(70586007)(8936002)(186003)(1076003)(5660300002)(8676002)(4326008)(81166007)(70206006)(336012)(508600001)(316002)(6916009)(54906003)(47076005)(36860700001)(426003)(6666004)(82310400004)(83380400001)(7696005)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2022 19:23:46.2516 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 72999c1b-3b0b-4190-498b-08d9f0b8afd2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3596
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Prike Liang <Prike.Liang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Prike Liang <Prike.Liang@amd.com>

Set smu sw function and enable swSMU support for MP1.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c  | 1 +
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c      | 1 +
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c | 1 +
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c         | 1 +
 4 files changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 9513fa36c02a..f09056ee48dd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -1329,6 +1329,7 @@ static int amdgpu_discovery_set_smu_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(13, 0, 1):
 	case IP_VERSION(13, 0, 2):
 	case IP_VERSION(13, 0, 3):
+	case IP_VERSION(13, 0, 8):
 		amdgpu_device_ip_block_add(adev, &smu_v13_0_ip_block);
 		break;
 	default:
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index e846231412bc..35cdc90f1ca2 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -532,6 +532,7 @@ static int smu_set_funcs(struct amdgpu_device *adev)
 		break;
 	case IP_VERSION(13, 0, 1):
 	case IP_VERSION(13, 0, 3):
+	case IP_VERSION(13, 0, 8):
 		yellow_carp_set_ppt_funcs(smu);
 		break;
 	case IP_VERSION(11, 0, 8):
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index f0ab1dc3ca59..df6cbb7feef7 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -218,6 +218,7 @@ int smu_v13_0_check_fw_version(struct smu_context *smu)
 		break;
 	case IP_VERSION(13, 0, 1):
 	case IP_VERSION(13, 0, 3):
+	case IP_VERSION(13, 0, 8):
 		smu->smc_driver_if_version = SMU13_DRIVER_IF_VERSION_YELLOW_CARP;
 		break;
 	default:
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
index 4c12abcd995d..f24111d28290 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -568,6 +568,7 @@ int smu_cmn_get_enabled_mask(struct smu_context *smu,
 	case IP_VERSION(11, 5, 0):
 	case IP_VERSION(13, 0, 1):
 	case IP_VERSION(13, 0, 3):
+	case IP_VERSION(13, 0, 8):
 		ret = smu_cmn_send_smc_msg_with_param(smu,
 						      SMU_MSG_GetEnabledSmuFeatures,
 						      0,
-- 
2.34.1

