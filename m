Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CB35C43334
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jul 2022 01:54:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 941BB10E953;
	Fri,  8 Jul 2022 01:54:15 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2053.outbound.protection.outlook.com [40.107.223.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D973010E953
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Jul 2022 01:54:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jMF0tZStQ81j8Vds5dgDJSUr2Qb+wip03k1nGzcSBgO1it67g1e5/SV4acntJSkkYn6tSgoFPJvH4qvKSHqV5ZYe6I0As0G0zRO3wvkRhtWHyv7HbAnGrJnmN6bhRyySRMiF/Y5sk35idcZ/jRsovrEpchpUf2BdWw2IwfwuUYZE5sR0hH7vaKpZ0uBC6uOsBTJ4hooihBKyvfiz7njrVvEBR9LmrQt43Z8dM6r2E4wfIyOfvSUTCGARPzOVdb69UiczyaqniGWDnBkD9f0XHMc09wE7kNRRTYcYQgNiqSfyoyQxSealnWjqgWG/NU0j6iysHOwy+avPie/O6gW4KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=unDGF1ET8QnpjkfvEgEJk/tt2GoV3ZbyDnUTXD7rTWw=;
 b=EehtwmDpKzZozgHmKicVDWfkA3dD/oThkptHDL3bd2cIJoheCVSaHk842b/xMru/Z4M2Av+9y7LXfLwS/PkkwpYWihVHkcRLppmaMpADq5rKSoDcfDyDyA7H4kGDENH4Wh8mdRRB6DUSK9wZ1t+vHq7dTYpMawPHDRulD12WU4bt1mwdfZfjPsxKTnFI5mb/CMijfR3kxCf9P6c2v4NAD6S2wKTXKNZUEGJiMMFXsCoNplAWkhfMAye83pqnkaHeGwwFG/+BgPzCaFd+tYZzQGsi8YnX8/WLFlOAFurAnCE0rFHDgxZqgYzoOVCgSigZoeISATNXy/cDRp1aHAp/fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=unDGF1ET8QnpjkfvEgEJk/tt2GoV3ZbyDnUTXD7rTWw=;
 b=Qs/iFN+HrtBBUtlBiZI9FFJ78LbjEHiPx0MQVdQA338DoansmftCZrITqmN1vmptn19nhXj21y/pQ9yU6DCPa4GE0J1tJUHG1fi2QVzVR4GLcER5mDVjZsJD5sHllPpIcQs8NJQ6CZh8eKjOnpie3JxfF3Om1j8qCJqNTVJuHhg=
Received: from BN9PR03CA0500.namprd03.prod.outlook.com (2603:10b6:408:130::25)
 by BL0PR12MB4865.namprd12.prod.outlook.com (2603:10b6:208:17c::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Fri, 8 Jul
 2022 01:54:03 +0000
Received: from BN8NAM11FT030.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:130:cafe::82) by BN9PR03CA0500.outlook.office365.com
 (2603:10b6:408:130::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.19 via Frontend
 Transport; Fri, 8 Jul 2022 01:54:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT030.mail.protection.outlook.com (10.13.177.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5417.15 via Frontend Transport; Fri, 8 Jul 2022 01:54:03 +0000
Received: from pp-server-two.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 7 Jul
 2022 20:54:01 -0500
From: xinhui pan <xinhui.pan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Remove one duplicated ef removal
Date: Fri, 8 Jul 2022 09:53:46 +0800
Message-ID: <20220708015346.3027-1-xinhui.pan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4aef9882-8ca9-40a8-b4d9-08da6084bc26
X-MS-TrafficTypeDiagnostic: BL0PR12MB4865:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CstyOWMMZ1ct68AfJ2Q5tvJdUYFMqyHxyjCgHIOAE/BWOsEApPc4/dfzZe/Clo30j+jID6qH/X50X4orrGw/rfnGNd3OlMYp9i5Iej6eiIBPZlTUadxoLScZCh8Mgs3HiaS3QZKIFxbeOOPWKhrmtZ85JgAM7cdfLCu3i1rlHOIUX/FKEDC3XCYwGz0Bi5q9aXqrzhXMs1uI8UgZvujclFoJq5C7hc7wDG1x3dddA0TYOPee8DbhPTxNbycHNZtsbi9f69R7iaUwd1GU0wQ1T/OHViYLeS8LbHHWWQfThpqnPl64nS3xvVo9qEj+5mIdvnxmz+/j4EovFVAbVwQ7W2X1iBfnkD83WVXXHNL4Z6V0Sf5rnIPeiW/iaxJONZLCfiB9uEBrCTTpB/GHeGdU6gbVeGW8atY5hUxuf4pYEdWj0kFTaH/JYd7uh/WqwGl5MTODL7HABmZ1iQfh7CHiJ8Kp3lMynbhlVHV/FTYTQScjinZlozbf91pPYJgrwxcTAHE6/QKsc1j0IeGOD7SEwaS9gik0LX6wDJ5I/FJ23wfOxFEcYOBxiau7L70PviWtUYAjw8Jzj/wgVwGsbLX3yynGx9qIZEnuXgnZNi7F6tlq709r07LNKyAWCgrw/4Yl5KSIatJgXi1UgsUy2VoxVb/F585nFIUZk8VALK0YZ6RNQ/cDVmPiY/kcOUKkz6HsVz+lh4Ag25aHeibuLq17R8F+tIADRHl6KqC9xaGhAhdNZJS697f6zRV+qjh68oADhLdDiO+iKQBLvOzbYQ5XAb/k3PIKNoaYwmgp2fcZgBl7RG61ZQ41MWrRSJhVFgjtHXWat3Z7S6qZexXef7nY7bVdLZ3hOlGvHjCEpUiLe8pOROfLHzoSBgYF2u/6C/KK
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(136003)(39860400002)(396003)(346002)(46966006)(40470700004)(36840700001)(2616005)(2906002)(16526019)(26005)(1076003)(47076005)(186003)(82740400003)(41300700001)(7696005)(426003)(81166007)(356005)(83380400001)(6666004)(336012)(4326008)(6916009)(34020700004)(40460700003)(36756003)(40480700001)(36860700001)(82310400005)(54906003)(478600001)(4744005)(70586007)(8936002)(86362001)(8676002)(5660300002)(316002)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2022 01:54:03.4168 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4aef9882-8ca9-40a8-b4d9-08da6084bc26
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT030.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4865
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
Cc: alexander.deucher@amd.com, Felix.Kuehling@amd.com,
 xinhui pan <xinhui.pan@amd.com>, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

That has been done in BO release notify.

Signed-off-by: xinhui pan <xinhui.pan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 0f9811d02f61..49536fa8d269 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -1583,11 +1583,6 @@ void amdgpu_amdkfd_gpuvm_destroy_cb(struct amdgpu_device *adev,
 	if (!process_info)
 		return;
 
-	/* Release eviction fence from PD */
-	amdgpu_bo_reserve(pd, false);
-	amdgpu_bo_fence(pd, NULL, false);
-	amdgpu_bo_unreserve(pd);
-
 	/* Update process info */
 	mutex_lock(&process_info->lock);
 	process_info->n_vms--;
-- 
2.34.1

