Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1655AC41535
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Dec 2023 07:01:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 85B1910E09A;
	Tue, 19 Dec 2023 07:01:52 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2064.outbound.protection.outlook.com [40.107.96.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A6D0110E09A
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Dec 2023 07:01:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kMkvWmSZavCpO+2nEmxfoyOhDzkMthCnFsHZRJqQR8aVFSiYn37+ETUiiRn/7BAMDIYCs1DoaHUKelVgE4sQiqL8mmLfoCz9/0q4o2MaRluegxWC5XNoqBo5lQ7FacIatwAhCMi6ZpTHFxsBzCaEPX2Ol2mg9GFL3QhNjdybqEnq6uxRukXjewp8lXHnq2w4n/tUth2mkfmk4cS3zR/GED917nIw8ho2TIR/t/WIzf9LOqtjdR7C22TMwiZTjFcL4qFlF+ABmexaZ585z9djltcmDBrjBD0mJb79fTavn8Yqep4xPaly3nGckhYOLePziIaZGILw7vOokXMQL1aAYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OAJ2vsYm8oto3u0fjKpVwC2soypkNcojAFE0jSs6tIk=;
 b=MFfMSlnQwD4Sf/yRFTtPWs+BhtE2fpgQGHXfuQU15sJFGZgDJMMtW44gk2jK9gL0AFZuthwiF8dfCjgiWEByEW64MaMtxcgEJSmWBfFk5GZm7qPf1x6ceh3e0n++2ZyZ001iQf5DYYs+KgmxUUupknYfqlyJWh3G7ZWOSsrsccKa71B9PIsm0BcWoRu3J3sKXxWrvQZVxgc+VMqAGV53qQFLsdFS/n5Wg5u/K1d8uz65OPWIFiXyPIg2HAkkFTwQjzyUA6dZjn2deW+y1DldL8hgKaZF/VP5YaUGPqaNGPES8aEtLnEyAlByDfwvQ/o2pBVdnXTfgeeU9tckrr5avQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OAJ2vsYm8oto3u0fjKpVwC2soypkNcojAFE0jSs6tIk=;
 b=wVH+LYgMTA1CUCwBQR5bLr8zhR4ByWxxyW3aBtbnODkRo8zdnC9/NxlpxfBPeUw/uhyIPL+5V8MPtVk2CJBayyDBdSLp++gHnTRGkif2gURclowsZFnsKG65r8dW1CcFDeK7bt1UV/umjnebEFksRWaV2IXm0pXE385Vr7VmAQw=
Received: from CH2PR19CA0028.namprd19.prod.outlook.com (2603:10b6:610:4d::38)
 by BL1PR12MB5826.namprd12.prod.outlook.com (2603:10b6:208:395::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Tue, 19 Dec
 2023 07:01:48 +0000
Received: from DS3PEPF000099E1.namprd04.prod.outlook.com
 (2603:10b6:610:4d:cafe::ce) by CH2PR19CA0028.outlook.office365.com
 (2603:10b6:610:4d::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38 via Frontend
 Transport; Tue, 19 Dec 2023 07:01:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099E1.mail.protection.outlook.com (10.167.17.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.14 via Frontend Transport; Tue, 19 Dec 2023 07:01:48 +0000
Received: from amdoffice.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 19 Dec
 2023 01:01:44 -0600
From: ZhenGuo Yin <zhenguo.yin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: re-create idle bo's PTE during VM state machine
 reset
Date: Tue, 19 Dec 2023 15:00:10 +0800
Message-ID: <20231219070010.1568585-1-zhenguo.yin@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E1:EE_|BL1PR12MB5826:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e39e6e9-c16d-4ccb-332e-08dc00605e85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +PN+7MXp7xeaL5BzkdfEEUbjaTKDA6LHZRRgDZIs33yRD70WFLQbKMeS/EZn6RoBN0fwbCXzknubOzGRggmAlOlrg5W6KevTiK7cAh+YHv3ICFDTAq5uRL1FqjYN0PoktNnG6k8ngn7gfhrEsVI1u4dHJr84Y1pamm0rxgFiaauxxC9e84ZSeGP2P0i4halfUS4jEDDnE8XExG4FEq6/nLGqbnomNUa0iVnVOFSoHknZs6/ie6qHayqwk2a9BaL9W/Xn0Ei3KkCtjU0gkwWZKwcrOc8Obeo+rAF5x01lrfrG2y5KZTKpq/iyupU1fVPrkt2i2QP3z3U3ifvtW/nvCVlyGlMzSboJG7Wr6BON4P//TYQfCmBru4NuDs22v+RNhaV5L3vCN/FzT/VCCPAtkcVxzYgBe7MQAKLI+L/e4woD+RnntVvMBIDJWClBrliclGDm3+zL4qtGyLrsMYca+2ohi+fvp+N9+TK8zWGtZoYXS82oA+zla1HWeJFjLJviLaTeUUH/DN7DkPuK/KeEsGwAPGpgy3U+Hra5bCFCSzTN+OQDhRv3yQbUJq76r0q+xdAFd/yKi8MXpWj6N8OEsYtbc19yPLG61lkEXGUOHp5E/dB8SQ5NWb2gcIKJgHVwiJTP3ioVVKWFbaJUFXZmc1oeO/+JjGBjGBieCSO/PQ/32bSuWsB+aYnl8sCukoVhlH5U1VJ0axU+FNHyfsfKUpbR7Jnbo8XuNpSB/SZuY6DDgvow2fluU2kqwzq0FAmU
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(39860400002)(346002)(136003)(376002)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(82310400011)(36840700001)(46966006)(40470700004)(316002)(6916009)(8936002)(8676002)(4326008)(70586007)(70206006)(40480700001)(54906003)(40460700003)(16526019)(41300700001)(336012)(426003)(2616005)(47076005)(83380400001)(82740400003)(26005)(1076003)(81166007)(356005)(5660300002)(36756003)(7696005)(86362001)(6666004)(2906002)(4744005)(478600001)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2023 07:01:48.1634 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e39e6e9-c16d-4ccb-332e-08dc00605e85
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099E1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5826
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
Cc: alexander.deucher@amd.com, ZhenGuo Yin <zhenguo.yin@amd.com>,
 luben.tuikov@amd.com, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Idle bo's PTE needs to be re-created when resetting VM state machine.
Set idle bo's vm_bo as moved to mark it as invalid.

Fixes: 55bf196f60df ("drm/amdgpu: reset VM when an error is detected")
Signed-off-by: ZhenGuo Yin <zhenguo.yin@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 7da71b6a9dc6..b8fcb6c55698 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -285,6 +285,7 @@ static void amdgpu_vm_bo_reset_state_machine(struct amdgpu_vm *vm)
 	list_for_each_entry_safe(vm_bo, tmp, &vm->idle, vm_status) {
 		struct amdgpu_bo *bo = vm_bo->bo;
 
+		vm_bo->moved = true;
 		if (!bo || bo->tbo.type != ttm_bo_type_kernel)
 			list_move(&vm_bo->vm_status, &vm_bo->vm->moved);
 		else if (bo->parent)
-- 
2.35.1

