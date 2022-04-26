Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08BB8C433FE
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Apr 2022 18:53:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 764C910E47B;
	Tue, 26 Apr 2022 18:53:13 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2054.outbound.protection.outlook.com [40.107.92.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BFD8510E1D2
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Apr 2022 18:53:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QJ/bAM4bQpLvgSiOXzyZJe2CfzlZbIcKBRIK0LQ9NdyTM81rMx1KkdOIGFH+Hh89qg3VNhMKDYvTLoh3z4X2oN4vLGyrm6DHjMC0FVI2z0hp3GoxqV8kDh4m+a0FSeXTKbybtxreR/KGckr6JP7/UBDBPm9uJuOSuUvkV2lT/KDYCxD2q3djFF8WFN90VHQKpBkmmZ7dUUQQxrDuh3rUC6O30LE5b05T9SXb5+bLlaeIir76kPQXgyr8r3yAiaxiZknFDS3Df7LrIkx6/FSczb/Zxw2MHtVEZPGswM0rJ1gWR/gIy+RxjnuRFw0/Vupr0j0Q2KenB+lZDgwZYFdtaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L1NtQXYDcFFqWAhSbbJdtd+TY0qarWOYPJpnbcGi5jg=;
 b=hYojZNCDe9LU4gv+eIR+u6ad5d28zDLY3RXm9603wPAGPsv8Gx5EzWbGIpVfnB/hwDf/N2R8PKSWW1hsBsdwKdi4Y5HVqbhwQZquwoNy5B67AVItzOzhGteJcTh+AJvExPWEUBfOrkX9M13LU7J7Zlup9S2fb3d9W6iVomxTbvCjTyJvtEhBzH6zER5RW8NNWkQmcSoW+6rHjvbxEMgnNhXWHmpkIibRqbZImKS0622hW+wcacH5NK5xwwv4wfno8fXnDKAVeQHKeYkPWvRKaNVqez6z5D/wvqaBsm+GJqCTcGBDMolbGaGRBBxQXRwN6nHJDAuuyXv3CKibPG8+qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L1NtQXYDcFFqWAhSbbJdtd+TY0qarWOYPJpnbcGi5jg=;
 b=fHQGvnF3CZfYKpbYRt14WCKKsB3nDDCLqscpW/Z+aTiuWjuwF1911aS/REBU3l306kEzycRzT126Uv2PpkkqqiC85JfATEic11J874XAHan5tKsGUmsMAtVdguhe/sYA4VJXI81mfE5zBt97w+/dDFR0ppnoyC6Y+/p69TrTyp8=
Received: from DM6PR03CA0061.namprd03.prod.outlook.com (2603:10b6:5:100::38)
 by BL1PR12MB5828.namprd12.prod.outlook.com (2603:10b6:208:397::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Tue, 26 Apr
 2022 18:53:10 +0000
Received: from DM6NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:100:cafe::20) by DM6PR03CA0061.outlook.office365.com
 (2603:10b6:5:100::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15 via Frontend
 Transport; Tue, 26 Apr 2022 18:53:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT004.mail.protection.outlook.com (10.13.172.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5186.14 via Frontend Transport; Tue, 26 Apr 2022 18:53:10 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 26 Apr
 2022 13:53:09 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/5] drm/amdgpu: add nbio callback to query rom offset
Date: Tue, 26 Apr 2022 14:52:53 -0400
Message-ID: <20220426185255.3039590-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220426185255.3039590-1-alexander.deucher@amd.com>
References: <20220426185255.3039590-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 85215c8f-761d-4358-dd37-08da27b6028e
X-MS-TrafficTypeDiagnostic: BL1PR12MB5828:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB5828082350F4E7FC5656B256F7FB9@BL1PR12MB5828.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eJkg7wFF/9NPbQ6aEwkelcR6o4VSJ9Qruhx0oZ429rAGj90kChfX29zG6wKQ5YXAoWzy/eLTE3CuoEjnoehkj8AAbRv4zUHbt8N2Ae7oARoxdbnfCmoJWRx6IaFYUDNyEJ8opYYPNbe20++aZ3niQpFEFuWQh+9uLsI7oWdVnPmspbj17rrth3UaVBz+uuK7XcazFwlWdiFjGPKBX16FftxVX3vq0JQS3Gw5irS84KpJbNRLT1YVCZnyxTOZzGUQoCcebYGIK5VsmGrEgkEsrYDWHQPz7QmEy9DwIpN0MFR+Pm3xYajI39hvXjG99TqaZncr/2aPBF+N1eO5lIwsm+7yqLC5T1NGscdTsYL8zXt9I7Rzi8tKW4lPPvxkdlCcWKB+4zM4TnUuWbkU7zOJpnZEJuJxbY4VfVo4gVzY6NkoZ+FHLHxPKQhalC82UhVEijeVnJMNe8HlK8IAqLQlwokBPefTXLU32FUBeX6tk4b8P687/oR8tb2Z+AvgpLFiG7nIlk421cIkHk5Y+rB2yI2kjKGUWXeAt1PUb4hT8MLLZLYvLdOf25wRjMcIfcr/9Gn2bbTIF/9QWtByzawI7MxFFgE7A+Y8lCjESURV1rPYLucINkzFXgJkTfTfRk7P5vy3krTbBxhcM0CKViyI68Bk07AVfQw44ZoB62ar8c/iv1YuBqtcueZ11uBx3yhgvQsnBlFDJk6uAzfngrjg3w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(70206006)(508600001)(2906002)(16526019)(5660300002)(2616005)(86362001)(7696005)(356005)(6666004)(83380400001)(81166007)(336012)(4326008)(1076003)(426003)(47076005)(8676002)(70586007)(186003)(26005)(82310400005)(40460700003)(8936002)(36860700001)(6916009)(54906003)(36756003)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2022 18:53:10.5857 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 85215c8f-761d-4358-dd37-08da27b6028e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5828
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Lijo Lazar <lijo.lazar@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Hawking Zhang <Hawking.Zhang@amd.com>

Add nbio callback func used to query rom offset.
Used to query the rom offset for fetching the vbios.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c | 13 +++++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h |  1 +
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
index 0eddca795e96..e363f56c72af 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
@@ -471,6 +471,7 @@ bool amdgpu_soc15_read_bios_from_rom(struct amdgpu_device *adev,
 {
 	u32 *dw_ptr;
 	u32 i, length_dw;
+	u32 rom_offset;
 	u32 rom_index_offset;
 	u32 rom_data_offset;
 
@@ -494,8 +495,16 @@ bool amdgpu_soc15_read_bios_from_rom(struct amdgpu_device *adev,
 	rom_data_offset =
 		adev->smuio.funcs->get_rom_data_offset(adev);
 
-	/* set rom index to 0 */
-	WREG32(rom_index_offset, 0);
+	if (adev->nbio.funcs &&
+	    adev->nbio.funcs->get_rom_offset) {
+		rom_offset = adev->nbio.funcs->get_rom_offset(adev);
+		rom_offset = rom_offset << 17;
+	} else {
+		rom_offset = 0;
+	}
+
+	/* set rom index to rom_offset */
+	WREG32(rom_index_offset, rom_offset);
 	/* read out the rom data */
 	for (i = 0; i < length_dw; i++)
 		dw_ptr[i] = RREG32(rom_data_offset);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h
index 03439083182a..ccd9fe96fab7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h
@@ -93,6 +93,7 @@ struct amdgpu_nbio_funcs {
 	void (*apply_lc_spc_mode_wa)(struct amdgpu_device *adev);
 	void (*apply_l1_link_width_reconfig_wa)(struct amdgpu_device *adev);
 	void (*clear_doorbell_interrupt)(struct amdgpu_device *adev);
+	u32 (*get_rom_offset)(struct amdgpu_device *adev);
 };
 
 struct amdgpu_nbio {
-- 
2.35.1

