Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B556C433F5
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Oct 2022 11:03:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E7E710E4A1;
	Wed,  5 Oct 2022 11:03:49 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2081.outbound.protection.outlook.com [40.107.96.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9447F10E4A1
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Oct 2022 11:03:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L/AOXFCoWlscbSGV1bzW50dBrLvHcn3Wn6TobGKsTSC+1BRQkRw/iOhTzlqycHvw15nBfMiMAd4w1s7UGkadmRzq/npvX0IRa2Ml14maAjXU6tLK6Se+/edkUAdKNiFYO0H/dtdyGmEy+pI0FV5LL2iFRPfIrye1zIa9aSSPqtAWaaRuyO2LqToLkoWbwNhk+DmDGR5bYfC57WBvWenTlXififSxLUHCca0IAqTFHeBZR1gHNd7H1/zq60RACWIZVNwP+Xkoby/+xhi9vohWC9ZN5NayUR5xT2FKJQR9UXc5sEhqq4rC7WW758ZRpJB3JNwQZXOdyVEoVQY49OegJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ez8FKZoyi7C9jZlnMX6E34Tve0hPoGR2YcppfTP8K4Q=;
 b=XjafRIXJoxn390deA2SO0/tMUJcaaPUD2DL7LjFe1BeFMAQGA7NfPKNOa56ubm9dFmSuzimfY0fosZ96PTQz4/y5zrq1LmnYHwrTZgaQYWbHiB5MFBVX0h0OTMY8eCWiNnNhu5DOEge2UlEqKbz7gaPlyCs3I6iIGrUkJK0mODK3aymzpbbEAa8jGtronb6vAeJLfQZ8cPzayKh0RXZay0Z0yuPz2/JudbSjn4vv+338zLGFk6mRIfLoOWcreU996eAxj8rmJX4pXu5xty2oQtNdPr2dgwlBp7HpBIGIw3mKa2lNPWymxSj9x0Ukvl5a+qb+ycOW5TlIAIVgEL37Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ez8FKZoyi7C9jZlnMX6E34Tve0hPoGR2YcppfTP8K4Q=;
 b=FbNDuO6nV6ayPpKrLX21pL7MBYOI//3zqyclk52Vn7U4ancWpXXAmW3/YXDGikdnLcpDtzwPP5/3WlG4zcWZ8fJtVPgp/H+/plOhT3AT6eaPnXx5tdBGpQaiPFqlwgN8dp27xhSQZPL4xaizs3Sq/sFLvsadkg3LzINOCrS6o5s=
Received: from BN8PR15CA0018.namprd15.prod.outlook.com (2603:10b6:408:c0::31)
 by CY8PR12MB7124.namprd12.prod.outlook.com (2603:10b6:930:5f::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.23; Wed, 5 Oct
 2022 11:03:41 +0000
Received: from BN8NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:c0:cafe::60) by BN8PR15CA0018.outlook.office365.com
 (2603:10b6:408:c0::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.31 via Frontend
 Transport; Wed, 5 Oct 2022 11:03:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT033.mail.protection.outlook.com (10.13.177.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5709.10 via Frontend Transport; Wed, 5 Oct 2022 11:03:40 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 5 Oct
 2022 06:03:35 -0500
Received: from sriov-MILEVA-7.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Wed, 5 Oct 2022 06:03:34 -0500
From: Danijel Slivka <danijel.slivka@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] drm/amdgpu: set vm_update_mode=0 as default for Sienna
 Cichlid in SRIOV case
Date: Wed, 5 Oct 2022 13:03:25 +0200
Message-ID: <20221005110325.31871-1-danijel.slivka@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT033:EE_|CY8PR12MB7124:EE_
X-MS-Office365-Filtering-Correlation-Id: d4c074ca-7b62-4036-5fc0-08daa6c14304
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vq/PggR3XLSK7xyZ5dLnA0R8Nsx9e6z11jXyJqXAD0ruwRZEdAI1nJk8B7t0KNui138kgFPatlCIseisSdqxcGBVaJowpow+xhgbWYmdOmJ2tf+VveawAI53VugpQWWC62AI3kHQS5Oa/ShCzik4fn8V5aifwe08QImLL23TC5MHZE2dKRVhhYDm/Su8cTVBSdzBh+LKuZzvCacPh7xVyRxZyqGb/XJnImxpCLU8FVpnivzdwrQx7FzMt9A6rpz9mab7DVfyDKXYFMKlvw1/UDDKi7LsBGjtO8P9X4tV/hTZ/ImpXzSBNvSt6oFFu3p+IhnxTcyMaB2X2IVYy+/+7VWtuHmOMu6TBe3fURSy8jxFJEwB39/pyDLbvZaTjIUJqZhEmQuN6rj8uOfxdQFEjlFS9mz2yoyxRCWKO0ThE4HdnAX4SJ9K7nSJ0jo1sGcaZofW603xarR60Dbjk4ee6enLaqt+1EGYZqcktFoDYMt1hcg+WeXBk+lUU42KsdP6knOmnbgBfY+DZj09tXYoS42pPNlfZ9Ivm0o1GYJ6+b1OadaXdLZXJR1yVOQJ9ISSezhDnhY0Om6BT48653yYEtuZa6CI1t3jvCsoTEGG7IwtiSxEiYArIHYXywwSApW2g/ZU5JbkdIpJHvHzW6P8LvNf4Vz9wtuT/QdbmuFuZ1Qos44kFvFPr0EaI/vldzXa2y634y3tjQNPQ+AianbqIPbG7wMFxSOUKlD7YseeEtHGVoSxhrKIyIeEAUywIFcKxGA8tKjDbY5Q2NWl2enTYOXkY+oyD1IErQYyt4BRcCsZaFMAaNS008QgxjH3kObz
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(136003)(376002)(39860400002)(396003)(451199015)(36840700001)(46966006)(40470700004)(6666004)(70586007)(6916009)(316002)(478600001)(4744005)(40460700003)(41300700001)(7696005)(70206006)(83380400001)(82310400005)(36756003)(8676002)(81166007)(4326008)(5660300002)(8936002)(82740400003)(2616005)(1076003)(336012)(47076005)(2906002)(356005)(44832011)(26005)(36860700001)(426003)(86362001)(186003)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2022 11:03:40.8980 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d4c074ca-7b62-4036-5fc0-08daa6c14304
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7124
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
Cc: Danijel Slivka <danijel.slivka@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

CPU pagetable updates have issues with HDP flush as VF MMIO access
protection is not allowing write during sriov runtime to
mmBIF_BX_DEV0_EPF0_VF0_HDP_MEM_COHERENCY_FLUSH_CNTL

Signed-off-by: Danijel Slivka <danijel.slivka@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 83b0c5d86e48..32088ac0666c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2338,7 +2338,9 @@ void amdgpu_vm_manager_init(struct amdgpu_device *adev)
 	 */
 #ifdef CONFIG_X86_64
 	if (amdgpu_vm_update_mode == -1) {
-		if (amdgpu_gmc_vram_full_visible(&adev->gmc))
+		if (amdgpu_gmc_vram_full_visible(&adev->gmc) &&
+		    !(adev->asic_type == CHIP_SIENNA_CICHLID &&
+		    amdgpu_sriov_vf(adev)))
 			adev->vm_manager.vm_update_mode =
 				AMDGPU_VM_USE_CPU_FOR_COMPUTE;
 		else
-- 
2.25.1

