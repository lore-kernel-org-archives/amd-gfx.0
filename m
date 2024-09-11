Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B0BEEE0211
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Sep 2024 07:07:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A1ACF10EA10;
	Wed, 11 Sep 2024 07:07:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dzxckUNT";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2066.outbound.protection.outlook.com [40.107.212.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 69E1B10EA10
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Sep 2024 07:07:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gLjeXBcGEltWLfCWKF3hKDAGBwmt7Z/gAEfDE3XUim11wsJdf7ZFVNL71SSdMJzcae3reONMt8cZ6Hazb2XDeR5O77FJ4pg1H3fypGOt+1a5iYko0UPhjfmgxcUnrGVlGXc81XWWeCWRZQmjEYxGA2FavOSDMJAnW8PKOEi0s9ZEG2oZny5o9dwY4DIqOzmUctpZ0M4SY10+KMYt/+0fEWDzgdvu/Wqh/ANkTUea6PxvT2A0w5LDS8d9NREPLZMOFqMDFC+Io1OZFykbjsdrSAuVnYwrmF70ZbU6ZItf+Lp1C7881TCQ8w+vr2MZAxaYLM1zHDre1z2xEHyScD1ZPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XrjpapeI12KbkHKI1SU1ZBfxYC0qL/mbo1Wdwz9gJ8I=;
 b=AJ5HvD48IuxMn7PYi2AR6HzUi3zqj6j+BRP4UAg09tuvvLooLu5yJ3NNnWHtA4WSUcigd6cxIO7HJaFZFh6yPhIra4hENve4994CPle1YXKiXdPpJ38w3Q9KdKim+pCUm08fsWQTHL5ASskn8P6tKyMHSwdk/ZluqJufAMtsDNzUyJ+2l1A/u6rF7zUrlJ17pV9rGskogm7L4iaM/QhzIts51Pm1F7WhS3pjPMCY+P6KjkdrhWNVWqu36LVV9bmFOX5uzLS7nAWYhfOoiEc+CYop/A3ociS4hOsoYIeP4gU2PhAgYFLesFlh6Cx65R0k3xsvmoq3fLx4wqgjOSSStQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XrjpapeI12KbkHKI1SU1ZBfxYC0qL/mbo1Wdwz9gJ8I=;
 b=dzxckUNT66TSw+w9Q0IHz4cfY/jIyuv317V2Bv+RYaxBroJT6I1Q+LqcXBMBT46YZzaV2lxBu/qJr20GL61rhiOW0tIV5qhaNOnz89s3qNVVwBhu0wnlQPeCBVaRFdpc611QvcXE8YgZ5dSfCs+156wQ5HIPaAUY8d794e1za1c=
Received: from BN9P220CA0016.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:13e::21)
 by DS0PR12MB6630.namprd12.prod.outlook.com (2603:10b6:8:d2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.17; Wed, 11 Sep
 2024 07:07:35 +0000
Received: from BN1PEPF0000468E.namprd05.prod.outlook.com
 (2603:10b6:408:13e:cafe::1e) by BN9P220CA0016.outlook.office365.com
 (2603:10b6:408:13e::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.23 via Frontend
 Transport; Wed, 11 Sep 2024 07:07:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF0000468E.mail.protection.outlook.com (10.167.243.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Wed, 11 Sep 2024 07:07:35 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 11 Sep
 2024 02:07:32 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Christian.Koenig@amd.com>, <feifxu@amd.com>, <rajneesh.bhardwaj@amd.com>,
 Feifei Xu <Feifei.Xu@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH v2 08/10] drm/amdgpu: Support reset-on-init on select SOCs
Date: Wed, 11 Sep 2024 12:28:56 +0530
Message-ID: <20240911065858.2224424-9-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240911065858.2224424-1-lijo.lazar@amd.com>
References: <20240911065858.2224424-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468E:EE_|DS0PR12MB6630:EE_
X-MS-Office365-Filtering-Correlation-Id: 18a782f5-805a-44c7-7347-08dcd23069ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZHVenjBSJOWqP6VjspD3n4SQGuLaAiTDyy2M+cURVXieuj8DBWv/vV13MRD2?=
 =?us-ascii?Q?gxlAvqzdf8cvW/cr6ZvfOI7a75yX8PG9gt8vMnrcvLoBtGMcDehKzrZq7sSy?=
 =?us-ascii?Q?ss/zomyqgS+zdWE5jiGVdi7L8X9/FTY5Y1y1tJarjcTBNVLOV/u7OAHsl0Jb?=
 =?us-ascii?Q?Do7jeaWrTXTIrhqiWTZOl6W6wyAGx94OdVdxzf+G1haabnTex1/TE1lnsHQn?=
 =?us-ascii?Q?DI5Ys9GE4U0Yb2rTQeM2X7sEIPsNg3i99yO5qh0HX/QdbgHDTomWakB2NvqT?=
 =?us-ascii?Q?WHhYmKaDpWJYLPVBy5JtGQJZ9BFPwNY450BSGilMxaaduB8SPhJ8Yf4sp3iu?=
 =?us-ascii?Q?O2dza6Q4D47+wCwqtoug4dLeyMJlcCpo4Uf6zS5hxoUtOIJjCpQmjQYlwfnp?=
 =?us-ascii?Q?/bfE0ZVuve0G9DUyEI9xawF7P0VXP/mc7mEeCk3YMphu2/zIBohzThu7FEoz?=
 =?us-ascii?Q?CYRg/RtPJC+fIXex3ca7q5hEEB0rERbOvelnAZ6nedhEv6wwPxAJnkxCWgKa?=
 =?us-ascii?Q?D6GXGdQtzRnAR8kHXWHMVVEY+yqFuemeeSq0zSHTuq9CEqKRxfTqdsQAYncS?=
 =?us-ascii?Q?WMWLXuMMzJbQaJlxnsiExuu+c/xlMqQH84VcIGz0AikAOzCCRhxVVmswNjTk?=
 =?us-ascii?Q?O2fa+ZGt2LSrUlib9tyKqG0XQ3m3/yNnxuUnaNX6ugyPTUDeR59CBCPwybjC?=
 =?us-ascii?Q?7AS78tY1mZP3wAxzbbHH5mBtfer2lGwaQXYX3c0H8QDbT+EydVgUSstx59l9?=
 =?us-ascii?Q?SVy/NKXzrHzsHk3RfOLBwcz5s/g/gKepLnWjC+Zau5MP+IhbyqIYDeBmrSW0?=
 =?us-ascii?Q?G/3hflGPNMVbmT4Em/ElMA9tmxhRIyyUiYuLxbhbplPvYQvbyZkjI0XiUAYU?=
 =?us-ascii?Q?e//hraZnlmSOc2HfY3jNuByGOubIGZsdcml22eHZaa9ihDlWLr6o9sGiNOk/?=
 =?us-ascii?Q?40vjzz/uJ0R7Sq3NNA5y7l3wVxHrLk5VxUauBCgStwYNZrhm4v6tBUPb4Gey?=
 =?us-ascii?Q?KqoXNwHQ43FxECYEZhuAogJQjobIt/JShSBphSan6qKsPdHILCJ37CNSmjx9?=
 =?us-ascii?Q?+4HhRpx65KWE2rieuHXmDa/D4+Cy/zen1UKQaJXKXXVhTUt8yRzPppIedNoz?=
 =?us-ascii?Q?E9AldCE+XofyCEnLyF6MKA8Gy+HgEEEfklSwX6AiSkTKJksYYYmkWYz/IqIR?=
 =?us-ascii?Q?sLkhSCZiBH7AOGnh2+xdUAjLHHjWBN9KQu+MAmjsEa8T9Ku2wGleN+mdFPjZ?=
 =?us-ascii?Q?V8NtT8SRW+yNERmoGB+omHlCEjq64Pm9IlS7ohLJ6INLKEcke3iLIawvyjVi?=
 =?us-ascii?Q?J8H12i7c401g5Mhun+CBmveK8cmzCwdrtfrTYViKeYquaj8x/se7ZQUbIsFl?=
 =?us-ascii?Q?PPK990v7GzZHBVNFowU7lNMWSGOSVdjOnEwfxO0dXcnnutV9mEoA9H9cqOKA?=
 =?us-ascii?Q?aPalvK2zDWfepSLuL5BHckVz54ag95pu?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2024 07:07:35.2446 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18a782f5-805a-44c7-7347-08dcd23069ae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6630
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add XGMI reset on init support to aldebaran and SOCs with GC v9.4.3.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Feifei Xu <Feifei.Xu@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
v2:
	Use renamed variable

 drivers/gpu/drm/amd/amdgpu/aldebaran.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/aldebaran.c b/drivers/gpu/drm/amd/amdgpu/aldebaran.c
index b0f95a7649bf..98fb0ba4f9cb 100644
--- a/drivers/gpu/drm/amd/amdgpu/aldebaran.c
+++ b/drivers/gpu/drm/amd/amdgpu/aldebaran.c
@@ -417,6 +417,7 @@ static struct amdgpu_reset_handler aldebaran_mode2_handler = {
 static struct amdgpu_reset_handler
 	*aldebaran_rst_handlers[AMDGPU_RESET_MAX_HANDLERS] = {
 		&aldebaran_mode2_handler,
+		&xgmi_reset_on_init_handler,
 	};
 
 int aldebaran_reset_init(struct amdgpu_device *adev)
-- 
2.25.1

