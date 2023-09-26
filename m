Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6E06E82CBB
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Sep 2023 18:43:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F03610E080;
	Wed, 27 Sep 2023 18:43:19 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2064.outbound.protection.outlook.com [40.107.92.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F60110E080
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Sep 2023 18:43:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jMLAaBj5MBtsO2S6z5odk/2/6R4qY+owgSqtq3iUMrspwL0J6rGiFk5a+jJVtsENOPo9GERflCA8vObmJJnO2d410WTrFiJGKOwtZ7CcGEAt+QoFbg3iEDB/dKRdCEpO90qY0KcgnEKlFQebe/8bh4g5KlS8ZtW7I7UoWz3IUsD0AKn34jCTnS80iJF0U5/8MapRh+fD7pFyeV5bv5qvtbGM6Zv9EgtCxGCHd1FIxcz7qWwM8ZVvrk5B4WTNoTkslqSm2RYQ4Hb5+Cut9I3qp7sLw+XraA2I/oj1w1/1L/wywS038yRN21He64IqCPhp8JeLPtit/yXEZmcXr6cRaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4egWvAxuRbo6xm385HMv7ZJYF0SKe2a+Zz/JcQC/QVM=;
 b=m7BR4xjySVkDKeR4ipWHV+a0Bdk4p+K293AeJgEssdhAJpHxWU9hQiammjzbGFnljpsq51BG7P2XVqVq65Fdrg3ET47QU0Lew1LKVvy+3A8gJu2f775Lp3lCcDnTZbgr7DGBxrTVMIMd8D/6eQemEpl2c0/RJxB6z7id7pJvur3SAHq4N7lsliLuH2HuyHJzlqRqdk5IY/hbxWN1KoIvXl8Y9s1YsIXMbQ+MtOgbRirIsGug9MQIyuq8sx3rkN/iKGrMdoiBETu32tq19JTVIM0ZjLsPZzoQ0heNrG11M2uHZr94N3NYX0NoIgyhVP5GkXtGsAEb02OL02F8erdO9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4egWvAxuRbo6xm385HMv7ZJYF0SKe2a+Zz/JcQC/QVM=;
 b=BQnvWrE+86UcR65xjvW/iE8r0O+dx/ykHuvQ4z0Cnh5Ajo5YlodjTnP5VBo/CVudc6QrAjF2Di8EXeRI+kARZn4S6GQXh5Z0ZXgg3Phcj0XTPS7ouHuk1JighhtBj4l5ZvXZgp120/ABwTeJSZp/c64zHn0b7nrGiBjLydH1fmw=
Received: from CY5P221CA0159.NAMP221.PROD.OUTLOOK.COM (2603:10b6:930:6a::26)
 by LV8PR12MB9181.namprd12.prod.outlook.com (2603:10b6:408:18d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.23; Wed, 27 Sep
 2023 18:43:14 +0000
Received: from CY4PEPF0000E9D0.namprd03.prod.outlook.com
 (2603:10b6:930:6a:cafe::d6) by CY5P221CA0159.outlook.office365.com
 (2603:10b6:930:6a::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.22 via Frontend
 Transport; Wed, 27 Sep 2023 18:43:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D0.mail.protection.outlook.com (10.167.241.143) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.21 via Frontend Transport; Wed, 27 Sep 2023 18:43:14 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 27 Sep
 2023 13:43:12 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 2/2] drm/amd: Also export `AMDGPU_TA_FW_TYPE_PSP_ASD` for
 `AMDGPU_INFO_FW_TA`
Date: Tue, 26 Sep 2023 08:21:43 -0500
Message-ID: <20230926132143.295344-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230926132143.295344-1-mario.limonciello@amd.com>
References: <20230926132143.295344-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D0:EE_|LV8PR12MB9181:EE_
X-MS-Office365-Filtering-Correlation-Id: 35b7e326-436e-419a-5151-08dbbf899b8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CLrauqyHIqhpH0C/BKEXPEwbXdGVhfmALFSJPVRL2CgnzbyMewHOvMOQO/qjO5bEKbh3TyryKpwRePWwP/leUswMBUuvOjXvjZMAejUz9l3DKZ7UgIVEDbvhfWA59tMnBEB8iQuaZhmgfc+56lyC+zmZWRwIiDFToMH/EkcC/8OrEXLfu8QPc9ke189d+//daFH4HL38EHxd8NALweiw1fbKL+13MI+Rlwl/j9WucuJvoSM2hYKiki6j54xEBy+f+3VRwjw0uEnFEFs+cmcq4ElRRL36JPf2+FGxKcP0VXoakmQ2shzoDGyOMrJDs4NEstDyJZulaOfkFQX50OTlf6Udj1DVgrEey6JigX00X3OhVLCWwf1EGl5vEjrW/RORc7hezt8lOK/d9Qj0LbRYbQLN6E2++KYsw5QGgPvjpw0F5XIJQnX+HQ5HlIDzxh3IQpCzZADpeMXvdn0p1nitBy1N5gp8uoKwR/JSDr0UhpAa+FoIDUzBr8vLjOMz2YoPDcWwyIN1uhilqJJAXnAxkgKPsrsPOg4ITQMGEySMg8BuxjNUuEdjJGjj8uaZLziCUquQYFtSGTRL1+/sLDO2t8yIAv7cpTo+APwX0CLXz4SiHzMF9t8y4sbChdCsMGbsGGBWhkGnehXHqhnHRBVjXUypOx+34mi/xBuD8kLCo+uXwmjQHHq0JRHYODquWPEN8vIkdxQ+mjFpjts/ga/vGtxsdhfAAky1I+S9bzehOCPjsIwa++3ILLj4LDTzTPy60rvEeo7jaHGJ8k5oj2hnnXlHTfubL1A6VLiZFNqhiS0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(346002)(136003)(376002)(39860400002)(230922051799003)(1800799009)(186009)(451199024)(82310400011)(36840700001)(40470700004)(46966006)(26005)(2616005)(86362001)(40480700001)(36756003)(82740400003)(41300700001)(40460700003)(356005)(8936002)(6916009)(1076003)(70586007)(316002)(70206006)(4326008)(8676002)(16526019)(426003)(47076005)(7696005)(336012)(478600001)(6666004)(5660300002)(36860700001)(2906002)(44832011)(81166007)(81973001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 18:43:14.3249 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 35b7e326-436e-419a-5151-08dbbf899b8f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9181
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
Cc: Mario Limonciello <mario.limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

All other `drm_amdgpu_ta_fw_type` enums are exported for
`AMDGPU_INFO_FW_TA`. ASD is available via `AMDGPU_INFO_FW_ASD` but
for symmetry in other values export as part of `AMDGPU_INFO_FW_TA` as well.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 6eff7eb18322..77863d6af6c4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -311,6 +311,11 @@ static int amdgpu_firmware_info(struct drm_amdgpu_info_firmware *fw_info,
 		break;
 	case AMDGPU_INFO_FW_TA:
 		switch (query_fw->index) {
+		case AMDGPU_TA_FW_TYPE_PSP_ASD:
+			fw_info->ver = adev->psp.asd_context.bin_desc.fw_version;
+			fw_info->feature = adev->psp.asd_context
+						    .bin_desc.feature_version;
+			break;
 		case AMDGPU_TA_FW_TYPE_PSP_XGMI:
 			fw_info->ver = adev->psp.xgmi_context.context.bin_desc.fw_version;
 			fw_info->feature = adev->psp.xgmi_context.context
-- 
2.34.1

