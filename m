Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80B5AC4332F
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Nov 2023 11:22:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1006210E6CA;
	Wed,  1 Nov 2023 11:22:44 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2057.outbound.protection.outlook.com [40.107.243.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F259310E6CA
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Nov 2023 11:22:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hOPZB6BdvdvOn3gGsMaynGlA+BVN/GmjxCEUQuKsPKXycohliO76bNC4qR5ZvDgqqYLW9ia93aOaq0zbEleYIWU9Hu5AmY14zURrNRyDHQslw2kD4+z6R0kMCXQKdJHjb0e2cVz9UqWyf46lsR8/rKDB75LIbhyt3YTaBNGYYYqtsPy4WvPMzVx18l+k8QXFxlAMhTCbLabnYKW92/JVz77EQ/A1HTi+70pbgsfdBQHE67er81hbH0FjWvH3j1tDZNK/kLRqhB8jIpkYsU97vt3oESGIoAIvd7YgG28co0N9LLovG7O4YDDAwHyZ2kbDKuw1ZKgZ8xqaiOHSH3RlPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4NL3CNkr104GN9WWc0Uq1rAUpvCJJcyHj2i2cef5KcM=;
 b=eK3Cj+FCbGbrDpwlBdQQEyhkabVAjNkE3zwNCTIy92ATpx1wLL7I2KUgpvnxl1/bJpNn4rl2u2MhXVwkKfEXyrtnNDrnYE8jlqL5veMw6DlX80zEOfo5jyGMHFaLAODBbgyOQ4hgwRkzpLuKiIdmx+i783rRs6jpWvnrz3qlSq7XSUHon3SK3Lh6ihBFSgSoH5j5QggTaEAJm8ceEOx40UQ1wATXpB8uBh2FZh/pkXSrIC/YY+bJR48P6+VgVbOMI8SbiNMfdFeBUNT3PVfyQqAr/TIM9agr2CxeXw9PO/vKFkKFhklayo1Uy15CbaXEtAImMzksH3za01wxuUwBwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4NL3CNkr104GN9WWc0Uq1rAUpvCJJcyHj2i2cef5KcM=;
 b=hEJH4BR8mxT7C+Jok1QS0N8cWsdVetvc/mj5JjsoE/zH5mDDyorbzlszxmJWrQ6vFjXQnKpVMhdA3kJ8xVBungBhlfGB2XUR5bGCUgHC92Memw+4lVE4l8/4Js6J6lK/KKOEChgtm3YIgsnJ/CFPQjILDvVsMgbQoo5uWnmrmTQ=
Received: from SJ0PR03CA0082.namprd03.prod.outlook.com (2603:10b6:a03:331::27)
 by PH8PR12MB6820.namprd12.prod.outlook.com (2603:10b6:510:1cb::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Wed, 1 Nov
 2023 11:22:36 +0000
Received: from MWH0EPF000971E9.namprd02.prod.outlook.com
 (2603:10b6:a03:331:cafe::94) by SJ0PR03CA0082.outlook.office365.com
 (2603:10b6:a03:331::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19 via Frontend
 Transport; Wed, 1 Nov 2023 11:22:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MWH0EPF000971E9.mail.protection.outlook.com (10.167.243.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6954.19 via Frontend Transport; Wed, 1 Nov 2023 11:22:35 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 1 Nov
 2023 06:22:35 -0500
Received: from hawzhang-System-Product-Next-Generation.amd.com
 (10.180.168.240) by SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP
 Server id 15.1.2507.32 via Frontend Transport; Wed, 1 Nov 2023 06:22:34 -0500
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/3] drm/amdgpu: Query and report boot status
Date: Wed, 1 Nov 2023 19:22:25 +0800
Message-ID: <20231101112225.5731-3-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231101112225.5731-1-Hawking.Zhang@amd.com>
References: <20231101112225.5731-1-Hawking.Zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E9:EE_|PH8PR12MB6820:EE_
X-MS-Office365-Filtering-Correlation-Id: f1192f63-56bc-496a-e6a7-08dbdaccd96e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5qQSaCk1Gbr07r1AGntZyI1DExbO1L1KMihvIlU7DVEhWjvs41laI7Lf8xfbETQQOzW4STMBAJarVx20hYwqm+XSUNt4lPEHWHg44IXZ78CK7ZNZr4YDTgEL2Y3GUaxGAhC+A5GunDqzUwNwmp/Z9Ob7ZEDskiYRdujxCysvSeJuToeYdc6FNiLB7SQxHcPHT9XuZLI3DRvlGvOMRPyaEiWaQD/FcIbHYoT1D19GU3howODjlxXfZBBTRYiQNeYrl1e0zyKbvxaviW70SVBeSzP1CNZOW0xTlBgLRR/wyVV6ZM/yzc0NXGjQUP4UdbMFuz1tqRaPurnH7/zB3+T5Zr8tsWVnoHtFB+iCMX/PzQxS3Pdjwy3MSiixbSNeJAl8WULdBwQ8tmXDxF4Wu9An825DXr7uoCZcDN1NE9nCa2npoAjmsSoFtvWM+GYmI6LOoWHWDznjCEwA+Jp5XsVCENaC4pYPhC00KdzA5dt3BQhx8jSWzfGta4xNRByaTCNmXfRnfSnkrcRMEnrOFEtHe6Jr7ORONzh0EpKNSaPUue0Gmf3s8w4Dz9hrtJKSfIsOclYvVk8RytoxVEQh5kLcYwd9Sp5OWwHkbREiW+CDhqEScTayFGYuHAFcmNGCL0ra1AyMZL3wX+E/m+a8GxoOzApYKl/iyZaz6B/M42Z0MwYrejLhTaugbqt0mfWlRMaMLSS02QfD5Y8LI16jNCktNO1scGqLogSSIdIgP2gcEGE2es9OxzfKV5fTKMq/3VaiC73I0LLG35Hl7MbwuIorEw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(396003)(136003)(346002)(376002)(230922051799003)(451199024)(186009)(1800799009)(82310400011)(64100799003)(46966006)(36840700001)(40470700004)(40480700001)(478600001)(6666004)(7696005)(40460700003)(47076005)(5660300002)(4326008)(36860700001)(8936002)(8676002)(2906002)(26005)(1076003)(70586007)(316002)(6916009)(2616005)(36756003)(86362001)(41300700001)(82740400003)(426003)(356005)(336012)(81166007)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2023 11:22:35.7758 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1192f63-56bc-496a-e6a7-08dbdaccd96e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6820
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
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Query boot status and report boot errors. A follow
up change is needed to stop GPU initialization if boot
fails.

v2: only invoke the call for dGPU (Le/Lijo)

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
Reviewed-by: Yang Wang <kevinyang.wang@amd.com>
Reviewed-by: Le Ma <le.ma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index c317a4869492..02d6246df938 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1070,6 +1070,8 @@ static int amdgpu_device_asic_init(struct amdgpu_device *adev)
 	    amdgpu_ip_version(adev, GC_HWIP, 0) >= IP_VERSION(11, 0, 0)) {
 		amdgpu_psp_wait_for_bootloader(adev);
 		ret = amdgpu_atomfirmware_asic_init(adev, true);
+		/* TODO: check the return val and stop device initialization if boot fails */
+		amdgpu_psp_query_boot_status(adev);
 		return ret;
 	} else {
 		return amdgpu_atom_asic_init(adev->mode_info.atom_context);
-- 
2.17.1

