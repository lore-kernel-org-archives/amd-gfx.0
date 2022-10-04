Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07262C433F5
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Oct 2022 14:08:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B4F010E18F;
	Tue,  4 Oct 2022 14:08:41 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2050.outbound.protection.outlook.com [40.107.93.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D4BB10E18F
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Oct 2022 14:08:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hBDmd4O1Ci1KL3p8+l6PaH4oTiufi4ykorXQ7MYaaFfERuad0GzhNQwQiV87hGdp8Z93oBBWHkGWLvrekyq3fn52/mpfMdYV8z9yhiiGxgLAzgFzE6Yps4xLV8VtxGf5eTx27omFoTvkJDT5fZ3SjJLbMuNS/p+EYObDaHG/Bb+10hFzVdePLkn/5RP/oYexJp+clDp12FmoAv/u7d5RjFsXT3TvUxKBJyAqbfu/O2mFbv7udlvldoChwTlrIeFVqBvYT3xVgl1Zd+kojoQ2AV47RqFxxlza/6PE2K9rV5TMspX6hQtu7H3mqeYdNMUC38WeQpcG/lQIBvRS2ekw8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ez8FKZoyi7C9jZlnMX6E34Tve0hPoGR2YcppfTP8K4Q=;
 b=KBz8vZ+Alxy39frBkP5WuciGsWvQhk8TswGQUAWuF7l1BdPipiMYpfNoR7vkDN1vBPK5ZYcvj+VCCv/PELAQGO6t4dJ96+r9UvbJwKVJlKP5fZ9rymVADqzJ/pv9tFG9+hgf9wAWikG2FDC4yJ7Y+IrrB+H77zTAT33uZKCG12jc5fStv2poT4NfccxTlr8Xu+YKzrdulAMQZB8fr6+S56LvMwCtzzX5QfyZ9oMXmJpZRmNbOPOzhNyWQphdB3W8g6XV27sdZllk3WkoX4R38qt49NhNf9WCjk3yYyn1Mfwlv5EeL4fR2EK7svk4rzjE0Rot8qyxIDwQRonuu7MQqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ez8FKZoyi7C9jZlnMX6E34Tve0hPoGR2YcppfTP8K4Q=;
 b=NhkCfqkivTHuK3wZ2Upk2EtvJRVWLukviMan2yYSNt/MkURk55sD/E6DoglC7/UIbDD6dHufG20qDLzXfZpxF6Q7yA+Q/h3ypU/0jaZEb3I1zc+eaifnNRB2JGwRSdhunc6lP/+dqgWWlEYpaP22bTsMLz7wKZD2zgD5ioaggek=
Received: from BN9PR03CA0721.namprd03.prod.outlook.com (2603:10b6:408:110::6)
 by DM4PR12MB5133.namprd12.prod.outlook.com (2603:10b6:5:390::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.20; Tue, 4 Oct
 2022 14:08:36 +0000
Received: from BN8NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:110:cafe::fe) by BN9PR03CA0721.outlook.office365.com
 (2603:10b6:408:110::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.20 via Frontend
 Transport; Tue, 4 Oct 2022 14:08:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT060.mail.protection.outlook.com (10.13.177.211) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5676.17 via Frontend Transport; Tue, 4 Oct 2022 14:08:35 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 4 Oct
 2022 09:08:35 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 4 Oct
 2022 09:08:34 -0500
Received: from sriov-MILEVA-7.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Tue, 4 Oct 2022 09:08:33 -0500
From: Danijel Slivka <danijel.slivka@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] Set vm_update_mode=0 as default for Sienna Cichlid in SRIOV
 case
Date: Tue, 4 Oct 2022 16:08:30 +0200
Message-ID: <20221004140830.18308-1-danijel.slivka@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT060:EE_|DM4PR12MB5133:EE_
X-MS-Office365-Filtering-Correlation-Id: de9dd052-1210-458d-ed55-08daa611ed98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SZKgMMaIpvKam9RwgnztfOS4/3SG/VGt5pd0wV3BH8zmMQ47Vg7z5/DeptfkKwUqeBDcd5rAwT6HuljkYsL8+c3IaMiIn3SG0Q71JzvOjIBP5URqo6oifcViEcFgHwqUcYhS2B0BMYSLwJcEZkGOYGRnLjOEfwQkydTPYwxEtR5B5KFSqhd++FKuZtvJIpHTKJP/I3psTWk5Q5YwBIS6AO/8rEsnVFEyoNaniCzh72DzG8LWdv9tDEA3lxub+VQtOYNdlQmDNbQqOIDK7FI+b66wHmNAj1WJmMQvo5YTUfSfdQOZdcAmJVpDd9ol5zOOPhZRe4XqwAdTzoU8ej0oyW+OR3czwUzIGQzgu6lgJQ9F8RN3/5w3WoH3GtkfvHxRv8uioEZzFOMZgkf/86YKwDhpXbAaT6YGCxLj8hyUPC99qtQ0zY0LR3KFPQSYrCSaXdiCF9sVeaTYS2+I2Pli26Zn6zGrfMreTnvfKWyDkEU3eeMqX7faE2JBxaDTgQRJxkGXBuzFw9uKUTWs9dl2oYHCVPkQa79aSkwmA372Ahuqw4+7oWj7snmFDRL7R438KmTV+/lkxukuw5cO2x2cs0vCMUdYIpmktuLfooLkWxDjJ3p0Dp7Aj8JOnpQUyvoP6sZNLVXSFbv2oA6eZCd1VY0sla8w1jLgmgIqvaxwmTMQxwroTYXvmoBZo/8EVFl1iEjDBynwAHfxuHGoEsfOOmD/8XcBXHI0tPttQjPyUkY4MtV2GPDPgOmtQe5lOQO1HvIdQfi6F3HDAtGvo0b8TABEMlZUqnLJAvb9soayQmVqncSHMxsRVGxCjyldOo97
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(396003)(39860400002)(346002)(376002)(451199015)(36840700001)(46966006)(40470700004)(8936002)(7696005)(4326008)(426003)(40480700001)(41300700001)(86362001)(478600001)(336012)(82310400005)(316002)(6916009)(2906002)(40460700003)(44832011)(36756003)(5660300002)(82740400003)(81166007)(356005)(4744005)(36860700001)(2616005)(47076005)(83380400001)(26005)(1076003)(70586007)(8676002)(186003)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2022 14:08:35.6130 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de9dd052-1210-458d-ed55-08daa611ed98
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5133
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

