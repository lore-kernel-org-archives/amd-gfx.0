Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 837B1CD4847
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Sep 2023 17:13:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0153110E6A8;
	Fri, 22 Sep 2023 17:13:15 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2052.outbound.protection.outlook.com [40.107.94.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2FA9310E6AD
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Sep 2023 17:13:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EyE4++yhXCplz5QvYptKkBir5nrdO6GGFK61RsDKG7+2QBj+BFlAMPsMTpcS9o6AxBUDMMcsiJeXbpiw/0hu+pa4VaOXr7xUr8ViUahS6DK5n0vH6tHbMBwHWa0VhnldtJ4TY6oTjjKm93hlrxrvCdyTSdijzMieAZZ1KWPKpL44R9Df661dqmdSxiTLYxX4JCysioWwxx93av3cJyzJVzwbov91EOengxS4ngXeLOqIqbfKC5fPPKvTVotfE/9PcYTcl1Pk3GSaOoe0GO0P3RPxFycFa1BCxJesCKux6MKJYeAZzEvXYJQ29zqjxAcV5Cv3nP8658dR2z+TPJtsxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gT/doNCHXcIDwNIIxfyr9rIG/zr1xZPwBUsUQL6l0IM=;
 b=NUvZYWUttGeybBtfRFKNckafAkJBOOwpctE9QX0eEEX47zY1ssXiRK0A1I2yqGull1fcds8TH6Ijm8i76r2ATizchWGAW0/kGORTA7FCHh5ZWkMTt3waRmhgyC1p93mvqMiLDISdkVsxtE1HF9ZvX99aVgHEVsh0/Hr6gVu5h88qmPjjgdhkjEYwGP3lFWzFQbAEwjzqP1ImJJnu6nkk7HpUVyA0jbrdbp57ys54eaXmXVQj5ebBddRAyrE5LVNz5MR/b+yJy9aKAH/Guy7Cx12twXC36uidlZnLEjCux38Ld5qH2xjh+CqR5Md82CdFn+iORNoRmAyypnpA51fJvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gT/doNCHXcIDwNIIxfyr9rIG/zr1xZPwBUsUQL6l0IM=;
 b=u88QaqozKB9z7QHegUNaI47St7ruttluwaK6O8vCdK7PWn5gNgzT+CD9hL0tBvYQc+5wTsr0ZKvzRw9AgaFvlmrEIfsN8908pxhlTuDPL2jd/bzAKZxcygngxiQY0fIXQnjhtsZh8H6G0QUQFBI1m7vg1/D2m4vp1Posz8wiqAM=
Received: from BL1PR13CA0255.namprd13.prod.outlook.com (2603:10b6:208:2ba::20)
 by BY5PR12MB4292.namprd12.prod.outlook.com (2603:10b6:a03:212::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.23; Fri, 22 Sep
 2023 17:13:08 +0000
Received: from MN1PEPF0000ECD8.namprd02.prod.outlook.com
 (2603:10b6:208:2ba:cafe::7) by BL1PR13CA0255.outlook.office365.com
 (2603:10b6:208:2ba::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.12 via Frontend
 Transport; Fri, 22 Sep 2023 17:13:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD8.mail.protection.outlook.com (10.167.242.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Fri, 22 Sep 2023 17:13:07 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 22 Sep
 2023 12:13:06 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: reduce stack size in kfd_topology_add_device()
Date: Fri, 22 Sep 2023 13:12:51 -0400
Message-ID: <20230922171251.934255-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD8:EE_|BY5PR12MB4292:EE_
X-MS-Office365-Filtering-Correlation-Id: bb53102e-ee1c-4965-eaed-08dbbb8f30bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CgYvCYRTHEQprDJMCDQBGXLnT1OHF483x6RREVMZYdHEEiDn/Rts+3aQdHPtnDnOucjXTI4182AX68AeLi+L4yZp3sIOASPDByewhIMYQTklUZMWd+cbHbd9p8UJuiS2kfIF2GaHQZ2OQU2NdxqG1lnStnNsZPehg5pz/MePZdT1JuQwm65syqquHVBI5HqI8BHDhXpa6SJat1ZQV8NHJOfMldjokDEewuki9RYc9FhjKURr1N7FZY7kwbHA75ZN1suCwmj1RZ9r2UJh3gd6xYqh3imFAFrSTR2avJxX9wvASTrHtUHC+CMc9fewHfA/LQx4R28M7GAHstEKL+8GaTTS2alaKX5TXYvcLoJ9eGZGnOVQcbV3YR8Y0NwYMdSY1iuyggN61zT9MYXoiHZAXorYuizfYtSkTIDA5AWFLhAO6q6S+o6VCYv+nKIOc3efs2LYmEKuO8Gp0j2JxOppdld2KRG3s2KANpCHwIxIV10IvgETYqNW1Jub8XO/rXghtFBqjyCd329ZqylZbOcqQfkug64It6Ufjxn5eteK6fAc1H6S/7EYKB1BvmaxAxdiml0By8gTM5AVTFXYSZG7svOt2OBHKMdNeYhPEmaYt/YsJsY6rrdKNQmEv3KJU1HoQ+amAYV+tgakIIuAJicvyEKG4e6HukRXBkGGzjY1D5VJLosMB4QALJItNVNLzCjCsl1N9MF4rwt9u4/WZrKFpQWVF5tBZFbPpSOw6hUB6dvSwFAVQHPQ0714VPJ/PTHaA2Fe30mzPfvqsKMin+NT/VRLpLNAES4JcOW1DY/6NK4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(346002)(136003)(376002)(39860400002)(230921699003)(451199024)(1800799009)(82310400011)(186009)(36840700001)(46966006)(40470700004)(7696005)(40460700003)(36756003)(86362001)(356005)(82740400003)(40480700001)(81166007)(36860700001)(1076003)(16526019)(26005)(2906002)(47076005)(336012)(426003)(478600001)(6666004)(966005)(8936002)(2616005)(83380400001)(5660300002)(8676002)(41300700001)(70586007)(70206006)(4326008)(6916009)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2023 17:13:07.5058 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb53102e-ee1c-4965-eaed-08dbbb8f30bd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4292
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

kfd_topology.c:2082:1: warning: the frame size of 1440 bytes is larger than 1024 bytes

Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2866
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index c8c75ff7cea8..3f9f882d3f5c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -1918,7 +1918,7 @@ int kfd_topology_add_device(struct kfd_node *gpu)
 {
 	uint32_t gpu_id;
 	struct kfd_topology_device *dev;
-	struct kfd_cu_info cu_info;
+	struct kfd_cu_info *cu_info;
 	int res = 0;
 	int i;
 	const char *asic_name = amdgpu_asic_name[gpu->adev->asic_type];
@@ -1959,8 +1959,11 @@ int kfd_topology_add_device(struct kfd_node *gpu)
 	/* Fill-in additional information that is not available in CRAT but
 	 * needed for the topology
 	 */
+	cu_info = kzalloc(sizeof(struct kfd_cu_info), GFP_KERNEL);
+	if (!cu_info)
+		return -ENOMEM;
 
-	amdgpu_amdkfd_get_cu_info(dev->gpu->adev, &cu_info);
+	amdgpu_amdkfd_get_cu_info(dev->gpu->adev, cu_info);
 
 	for (i = 0; i < KFD_TOPOLOGY_PUBLIC_NAME_SIZE-1; i++) {
 		dev->node_props.name[i] = __tolower(asic_name[i]);
@@ -1970,7 +1973,7 @@ int kfd_topology_add_device(struct kfd_node *gpu)
 	dev->node_props.name[i] = '\0';
 
 	dev->node_props.simd_arrays_per_engine =
-		cu_info.num_shader_arrays_per_engine;
+		cu_info->num_shader_arrays_per_engine;
 
 	dev->node_props.gfx_target_version =
 				gpu->kfd->device_info.gfx_target_version;
@@ -2051,7 +2054,7 @@ int kfd_topology_add_device(struct kfd_node *gpu)
 	 */
 	if (dev->gpu->adev->asic_type == CHIP_CARRIZO) {
 		dev->node_props.simd_count =
-			cu_info.simd_per_cu * cu_info.cu_active_number;
+			cu_info->simd_per_cu * cu_info->cu_active_number;
 		dev->node_props.max_waves_per_simd = 10;
 	}
 
@@ -2078,6 +2081,8 @@ int kfd_topology_add_device(struct kfd_node *gpu)
 
 	kfd_notify_gpu_change(gpu_id, 1);
 
+	kfree(cu_info);
+
 	return 0;
 }
 
-- 
2.41.0

