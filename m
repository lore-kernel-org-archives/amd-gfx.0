Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DD9BC3DA6E
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Jan 2024 10:44:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A406010E5B0;
	Fri,  5 Jan 2024 10:44:13 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2085.outbound.protection.outlook.com [40.107.92.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 68C4310E59A
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Jan 2024 10:44:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DrfKkw77ds0wvEA9PK1th7tMOBRWPImImVvTlt7BIizzp09pMEuKtm6KAUilf0e5i4F1fMlTFFKhVN9XqfU7W6GEhnLbsW+VBZmLV8yGrFzyrJZ64oM8FRJLyz97WtbhI5X0TiswSs9w9xF9abrNFc2yTc5GPvTvL+08+Y3Fa8ivUCccRFAPQ0W/Uq7aGNgwJrMa4Mr07EEPJ8r9R2w84lTAObd79AlMG5gflWC0YkphnxNNHlgwPUCzs02Da2BiG5dWaiHP05JwxsMSCn1LsV0+b+cbMBgHWfbSdparaSY6qKpWPc81Y3xzurNBDepHcxRduI7lb5xK72w4zIkJmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ElgFkRxZHSoN8DoMLhYtA3yhDLZWFG0PkNj7oFFTZlY=;
 b=FEVQiRoUBMaclcV4lBWnCqIifRXAGpvGhl8Pv4ak2B3Mrc3PHal2Zi8e/KcGYZlDVPNlnkKL2Q7tra+0BBVqx11zl+X1LcaEuWMEQeQPfvJYrWvUbr7aKA/hMeD1+ckD2kDOEDPjqDX0qjLbUPU5ey7ps98rcQolviBYcNR03eMzHTG9/jK+QwS74UkG9d0do62fO3fRLlCBMgf38mt5GAiAuELmato5Qn8quXMEdTFE3SKmpdBcYIszo5C6QYFkU7rSteVhPAx2wKvHDZsxlm+uE4fwkHF97txEF61xq7rhf+b7pmRskCZpoaonmZ3qwgr4+WO79n9Cphq/k/KYjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ElgFkRxZHSoN8DoMLhYtA3yhDLZWFG0PkNj7oFFTZlY=;
 b=bX4Uv4N5Nr5CZdC3kyOjnYa7pukAs2jzBSBzbtQPF9DHiRDgOFKAWUEe5Q8LH33PWNO+F3c9kG1xQVmm0uDtTJKJkEcka8jx5dNa+kcnc6VNkhRauSXMiFYo/128/TufVCUeetsYbW/3IvnOGif5fOFv03eK1eNfVZARm58tRss=
Received: from DM6PR17CA0029.namprd17.prod.outlook.com (2603:10b6:5:1b3::42)
 by PH7PR12MB5619.namprd12.prod.outlook.com (2603:10b6:510:136::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.17; Fri, 5 Jan
 2024 10:44:08 +0000
Received: from DS2PEPF00003443.namprd04.prod.outlook.com
 (2603:10b6:5:1b3:cafe::b4) by DM6PR17CA0029.outlook.office365.com
 (2603:10b6:5:1b3::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25 via Frontend
 Transport; Fri, 5 Jan 2024 10:44:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003443.mail.protection.outlook.com (10.167.17.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7159.9 via Frontend Transport; Fri, 5 Jan 2024 10:44:08 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 5 Jan 2024 04:44:03 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH] drm/amd/powerplay: Fix kzalloc parameter
 'ATOM_Tonga_PPM_Table' in 'get_platform_power_management_table()'
Date: Fri, 5 Jan 2024 16:13:55 +0530
Message-ID: <20240105104355.2773937-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003443:EE_|PH7PR12MB5619:EE_
X-MS-Office365-Filtering-Correlation-Id: 225f9fcf-8ecf-40ed-63f3-08dc0ddb3eed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dYMvUNBzBoQmQXNaH707Fg5EbwTgdliSHryfHb6dUdmYWhQs5OgGIZSoBH2TXikGtuP58TQ30a2CHxpCdnAHmAJNICxIM518c8qagx1VN3+IinAT8T5SO4VJ26Y83bvY8HAk7whcxgqW0/eiAy1ZaGpydkVuRRGS4YMKfK0Aw0kHjzuG7APPQqRPKqh+D8N+acjCFzmngMR3TC36R76AsWlToskuzFTUJgYMZFdfrux4N8eFJaXNSkb4PK7NA74swaLLlYupgQ88aoiQYNizAkgvbf84p3lu04VakMxPlQS0okkwgZ9FfQwOiSZPNGlJnlaqi91de2coE2bSv+uaEh4fMiRJd9WYHTpzLQ8711JxS6o5Mml3nGW6rrZEuDQh/EgCQ7YK0mwtgoHJ6oScnB/PYGsg6KWWGfhFxXWSG7FsIMporTB2k3uJOf3hLOHQ3O1hNe9q7IYZUF9fWiY7Sk2YwL7NggXfzWyNL7697b3sA3upHi4Iy02w2kkiohB53UuH4WYvXIVjIKSQ9KkBNX+ekd/n+sh1qmr9oAu8tAZlc+1/wgzBlTLktL/gf2fzJ/qJhM/eZrPLI+RxyhWvxB/e5lgSCE1ozi1rUFeauPJ1+adZyRb7y8unF6rDbDhra25UccqoUWEh6rPDk2NaNFdUUs0N1WBAv2z+t2zV1s7nu9PJ63VP/uNMpfiUJleLxs12aq5UMS/fhH/YJCrr5iOZT1XzkftZANk5a9jUUGdwE+Ez90ISdFl7DtDo5I8WqrlEZNvdH7F7cjSkcQjjQg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(39860400002)(376002)(396003)(346002)(230922051799003)(451199024)(82310400011)(1800799012)(64100799003)(186009)(40470700004)(36840700001)(46966006)(5660300002)(478600001)(6666004)(7696005)(2616005)(86362001)(8936002)(8676002)(110136005)(36756003)(316002)(41300700001)(70586007)(54906003)(70206006)(6636002)(47076005)(36860700001)(83380400001)(1076003)(26005)(336012)(426003)(66574015)(16526019)(82740400003)(356005)(81166007)(44832011)(4326008)(40480700001)(40460700003)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2024 10:44:08.3730 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 225f9fcf-8ecf-40ed-63f3-08dc0ddb3eed
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003443.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5619
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
Cc: Eric Huang <JinHuiEric.Huang@amd.com>,
 Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

In struct phm_ppm_table *ptr allocation using kzalloc, an incorrect
structure type is passed to sizeof() in kzalloc, larger structure types
were used, thus using correct type 'struct phm_ppm_table' fixes the
below:

drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/process_pptables_v1_0.c:203 get_platform_power_management_table() warn: struct type mismatch 'phm_ppm_table vs _ATOM_Tonga_PPM_Table'

Cc: Eric Huang <JinHuiEric.Huang@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/process_pptables_v1_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/process_pptables_v1_0.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/process_pptables_v1_0.c
index f2a55c1413f5..17882f8dfdd3 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/process_pptables_v1_0.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/process_pptables_v1_0.c
@@ -200,7 +200,7 @@ static int get_platform_power_management_table(
 		struct pp_hwmgr *hwmgr,
 		ATOM_Tonga_PPM_Table *atom_ppm_table)
 {
-	struct phm_ppm_table *ptr = kzalloc(sizeof(ATOM_Tonga_PPM_Table), GFP_KERNEL);
+	struct phm_ppm_table *ptr = kzalloc(sizeof(*ptr), GFP_KERNEL);
 	struct phm_ppt_v1_information *pp_table_information =
 		(struct phm_ppt_v1_information *)(hwmgr->pptable);
 
-- 
2.34.1

