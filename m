Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49EA6EB64D9
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Jun 2023 21:28:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD81C10E147;
	Mon, 19 Jun 2023 21:28:38 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2063.outbound.protection.outlook.com [40.107.102.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D9BD110E08A
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Jun 2023 21:28:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MS00l/xThDrGUdUz+4T8hVuKbIhkjjf9yyY/KTLM+07GuQwXhde2D2n72k4eQn9a9AgNknRr+DWm/G6KTTqYFdRDqA3gQyP4jAUnsUEttdSyVyUD7RI2VAwBS1nIwY0zq9o2V//vk06lp1f/jQvDmElTdohTORJuy6ViGytC33W4mqDLWJoyKWazQ7G+9ubd0s8c3+XuKAExW57102LEK+/b26j7DhS4olpgmm3XmOQak4rZFGVp3436N2mj9fUcgAKXl77KFp4McqQq6uq2NXsaFqupI/n/gGOpcyyi/Lkrx3VB38lzT/tfTiMjalGxheLN2GfTvxsgBBfsOb98jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=REUj3OoM/cEmGXQhl9yF5qsw4dC2MjEjZL8tMt815NU=;
 b=JkI+jMaHduQiKu1NfgRcWG9eIdxrjPc7Hhe0/nW2sK8AsBWRW3jahL5NI0XMTJCJH3Z6+ZfG1yP7hKejJWF59u++8aIMKX8umKhYteGvPe1exGoeIg9Q7QMCUPlWG8RgXVe2GpxD5qQJnaSiUbhuV8p24PQ99sJc+qnAZ/YnQKqGpKlJkKJALAZSeu+8+lItp928wvZJFDQqEir7KTs6Kihc9ihC2so8Kk4UzlDXJHgeZijY7YB3t0HgDy556f/5Cywi9xIx0lOB+kJZUCfr3FCpzO8XUd6l1GG27btLx5hgsKjTYuyrFdQf+cbIVdCctHISGRU4ron1vf4xgm8pKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=REUj3OoM/cEmGXQhl9yF5qsw4dC2MjEjZL8tMt815NU=;
 b=39mfN7qKrPYhFUO6qe8rTJVh3lNr/+j4Hoo5TE4AFwEJI6vHCVTt7MZz5vrOVZtKEAL1wZyHTFXcMN15En7kRCPWpe9+v04/4tRabqcR5D2sOoiyrpZweas8vyvlbxCKdtduLpaI2MSQfIMj1h60PaEjrVZ3omHzKx9ECxyn/V0=
Received: from MW4P220CA0024.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::29)
 by CH0PR12MB5299.namprd12.prod.outlook.com (2603:10b6:610:d6::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Mon, 19 Jun
 2023 21:28:34 +0000
Received: from CO1NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:115:cafe::2d) by MW4P220CA0024.outlook.office365.com
 (2603:10b6:303:115::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37 via Frontend
 Transport; Mon, 19 Jun 2023 21:28:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT006.mail.protection.outlook.com (10.13.174.246) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.37 via Frontend Transport; Mon, 19 Jun 2023 21:28:33 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 19 Jun
 2023 16:28:32 -0500
Received: from Xiaogang-ROCM-Dev.attlocal.net (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.23
 via Frontend Transport; Mon, 19 Jun 2023 16:28:26 -0500
From: Xiaogang.Chen <xiaogang.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: remove vm sanity check from amdgpu_vm_make_compute
Date: Mon, 19 Jun 2023 16:28:27 -0500
Message-ID: <20230619212827.54893-1-xiaogang.chen@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT006:EE_|CH0PR12MB5299:EE_
X-MS-Office365-Filtering-Correlation-Id: acf8379e-0aae-48ae-ab23-08db710c22d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OV6nZe1Yk+FkTOuy5jlncgiWetWYtcjzbpYQcBmDPuGCnsiVVBCYXxV2UA+i27wpvRUGXMATO8YJ9x6L96mvSz4oZAB02Io/u8on71M1btKf5eduyt7B0YBPvDtihpxCgzzexNDr8JtxHijv/wQNMHF+9x092GX3H9f3fHXE4+793zlbMh1hcIqEjT0Z7kzWskkpHrqzXPk4zOdbg2d1adIhvYfFEYoE5JzlAVn9E/QvVkrhUNvk1hk+fPk3adoipa1KbYU4n6a3TsGuTfOyqiRgNj3hEKNO3+O0p2omw7eJEHxPqy+6yJ3Zc8Iq302vYdnwbuCbAFfTfiOht5xP6hZkuReMiCCiy8O/Sz/mZmdAzJkXxOvz7T7UFqGrgH4sox+pf+pbZXvGdfyshO/mYDYSfFOreGIVJXKpq1uSEmad8h/sww8SZiLGECeE5EvDdbCVO7EV2+tefreXcswj4WycHlC+y4FBnOvaQuS4VGE0UdMYY/aZBpFTCjfORLHomwbyQCQHau4zJ/NeRLeLvDJlNWvblFqsSeVRcQUuWfecyIu5pAOCQSK5MfslzsavRG0db0jKyEDEm/TsBKKMarbdnFFgJWiu3/SfmhFT0Tk3OtXqxnaRHo9P4/2mZoML53O1qdHcLy4B8cKF4LwIxjWrq5JH26BMzCt3Ey2ZWMjhqvJp29FfK8k38qQJ+QyeONSCnM4N0qBbtsvTKYvgTfcvdPGtnVtH5UejBQOs2839ffvQyu2Wi+MTmoNjxfWmlL2lNagb6RHpotA1nXgMsA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(39860400002)(136003)(396003)(376002)(451199021)(46966006)(40470700004)(36840700001)(478600001)(336012)(426003)(83380400001)(47076005)(86362001)(26005)(316002)(82740400003)(81166007)(70586007)(70206006)(6916009)(4326008)(1076003)(36860700001)(356005)(186003)(54906003)(2616005)(41300700001)(5660300002)(8676002)(8936002)(40460700003)(2906002)(40480700001)(36756003)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2023 21:28:33.9116 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: acf8379e-0aae-48ae-ab23-08db710c22d2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5299
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
Cc: Xiaogang
 Chen <Xiaogang.Chen@amd.com>, felix.kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Xiaogang Chen <xiaogang.chen@amd.com>

Since we allow kfd and graphic operate on same GPU VM to have interoperation
between them GPU VM may have been used by graphic vm operations before kfd turns
a GPU VM into a compute VM. Remove vm clean checking at amdgpu_vm_make_compute.

Signed-off-by: Xiaogang Chen<Xiaogang.Chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index eff73c428b12..291977b93b1d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2245,16 +2245,16 @@ int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 	if (r)
 		return r;
 
-	/* Sanity checks */
-	if (!amdgpu_vm_pt_is_root_clean(adev, vm)) {
-		r = -EINVAL;
-		goto unreserve_bo;
-	}
-
 	/* Check if PD needs to be reinitialized and do it before
 	 * changing any other state, in case it fails.
 	 */
 	if (pte_support_ats != vm->pte_support_ats) {
+		/* Sanity checks */
+		if (!amdgpu_vm_pt_is_root_clean(adev, vm)) {
+			r = -EINVAL;
+			goto unreserve_bo;
+		}
+
 		vm->pte_support_ats = pte_support_ats;
 		r = amdgpu_vm_pt_clear(adev, vm, to_amdgpu_bo_vm(vm->root.bo),
 				       false);
-- 
2.25.1

