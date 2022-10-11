Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 448EAC433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Oct 2022 20:56:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 91D7010E87D;
	Tue, 11 Oct 2022 20:56:43 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2088.outbound.protection.outlook.com [40.107.101.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 311DF10E4E4
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Oct 2022 20:56:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SJbHNewsVzaKYfvm27FB/MMxcod3dii9jQlplRR35FbuwiSyQbidc5SynkSRtronA++yqdDn2b4xAOXLZucYSgJtMSYDFLza83ZDH1geD3qVOCaPB3dLZIHDELbn3IUBzTmN7pgqUa1AWDvRNN3AxUGnkbJ7fWX1WfFpuZRrP8XEFHMKRlN/aAHhISne0ecCymHZv7aGXphPHD2hRbFvhGRhcIH3XQERxRhgNVe8WPHsZvFVIwL/kzxHK7Nsg4e1+K0whUVsQVmv6wWNpiLvzMvY815SM6hTxD9h2LTzwiZSLbnc1gq8XvmLSvbhqoU5ioOrwNQ/98DckcZa/zi/hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LE4Rvy4h6ene8oC13EhfBoMUBx247Dik/qAwGZ52N/0=;
 b=cF+Ht+THfFerssGlX1DNhwOLmVbveUAB8VRbA1OztjcJPCPnhBan1GfDcLhmYSgjxvTu1O0ZmyYZO3i38+bbFiVYuwK32EwXcEZoiwJPMGXQ58it1ZOWD61WnZP394nN92hb3DjKHHucVq9rElvl2f4ogWqjY3BOIPYb2f6XNzweFNFtvB9wW6wsbhbpeBZv4GhG+8mPkGEkNCy0TcDJllt+U/EpvLgxFZmOXJsiCG8LVALXeFYRmi+npB3ITCdLfELfdAKg1GRYlQWAWOHEMmoEmRZH6PI1svbj0WaGmHbg5mUCg6ZWnZ7f25JqvS/Ez4uaZNn/RfF5EOPHBCDfxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LE4Rvy4h6ene8oC13EhfBoMUBx247Dik/qAwGZ52N/0=;
 b=ha7lpe07rOEvQ8vF3kACk3PV4Kcvdt2N2S5eDlX1u6lcJTwAv6hZXOzSH22iCMGbnzHh0uLaVn5JAvghDGpDwN+PbCY6d9obP4v5F7P8KqDETr1N5Mfqd5o8aBc6cK6A/0X9eShwdJLJYLnN6Q/Ssu05HnnzfqsLD9bx1EnBGko=
Received: from BN9P223CA0025.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:10b::30)
 by PH8PR12MB7229.namprd12.prod.outlook.com (2603:10b6:510:227::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.21; Tue, 11 Oct
 2022 20:56:28 +0000
Received: from BN8NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10b:cafe::ea) by BN9P223CA0025.outlook.office365.com
 (2603:10b6:408:10b::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.21 via Frontend
 Transport; Tue, 11 Oct 2022 20:56:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT036.mail.protection.outlook.com (10.13.177.168) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5723.20 via Frontend Transport; Tue, 11 Oct 2022 20:56:27 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 11 Oct
 2022 15:56:25 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 4/4] drm/amdgpu: convert amdgpu_amdkfd_gpuvm.c to IP version
 checks
Date: Tue, 11 Oct 2022 16:56:06 -0400
Message-ID: <20221011205606.2540082-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221011205606.2540082-1-alexander.deucher@amd.com>
References: <20221011205606.2540082-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT036:EE_|PH8PR12MB7229:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a8a62e2-f4aa-4ae7-f2a2-08daabcb10d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F6FBqjGBWQhXRZ2XANDJc86WDVhoj/DM44ckpYsIcZkAwKZjt5DwkbYIMBWpBr2JyiHDJkCHiiIOwfrbg45u+2+iKSvcYle+QIu8azRjrI+cGU9kqXSxRPZbZLgV1icZydIdNg6JBkapJvnnqLipfues1X5p9ZLEyff1VywTW01+8CTgJT/zm/LLcCZURMSFkjCK79MXfBHrDrCfKabXbhThOAR2DVuhab2u3A38l2pB/n9xX3YJRErsu+aoxHA/ARGVBlP44Wst61tUR8kr6/DZ2VX65x8J7H0Nijxvfd0wrsUiQZtr/RsrGmWrPf90eRd1EDgSuDz9F8tNtcYQ1O+P8ANJ4AMjKAKnEA+spJ2ThOGOnOXQuWnUYKKyBhpSSvPIyGPEP0vglqjNo3Vjw8e8zQymUjmkXL1adud4eShm9k5ZpgVae9Y6lg+YqfsqIS7FjUvSR34FJFMxUAbRFOKIrZd7PC29E+7BxFPvV9+YvRtYw86y31rXWdYHoTavVs5vPLcqK7a5yQe7RjyKt9gw/cW4y9RTx2f61k117QP81i+zxSGnTdpX3Na7DyF8Y2BW/cBXVjxzNqjwfG5lMTaoom2DCvKtJLzyN00jbaOWcyasFKz1jxt9dXM8zyB+f3xyTbatBYPYajwHXS9SKwEebAnxQV3YWlZkD7avzjKJfxm/P2VqYwkYwq/i17a/Jxrz2Moa4oAnxXp9iRTfwMLHCSgC9sBeGujmf2lOnxyM9N7oxogAmN5A3KonxEVjolZvtQ2xVBhTSJTq9YpGCj0xBSI/4rfUk9GCYgAGoV6jRgkz4L9/AfDexU16U1CR
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(396003)(39860400002)(376002)(346002)(451199015)(36840700001)(40470700004)(46966006)(40460700003)(82740400003)(6916009)(82310400005)(478600001)(356005)(83380400001)(81166007)(316002)(47076005)(36756003)(5660300002)(36860700001)(426003)(186003)(86362001)(41300700001)(16526019)(1076003)(6666004)(70586007)(336012)(7696005)(70206006)(40480700001)(2906002)(2616005)(8936002)(26005)(8676002)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2022 20:56:27.5201 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a8a62e2-f4aa-4ae7-f2a2-08daabcb10d5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7229
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

For consistency with the rest of the code.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 978d3970b5cc..8ad01e1ee4c6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -418,9 +418,9 @@ static uint64_t get_pte_flags(struct amdgpu_device *adev, struct kgd_mem *mem)
 	if (mem->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_EXECUTABLE)
 		mapping_flags |= AMDGPU_VM_PAGE_EXECUTABLE;
 
-	switch (adev->asic_type) {
-	case CHIP_ARCTURUS:
-	case CHIP_ALDEBARAN:
+	switch (adev->ip_versions[GC_HWIP][0]) {
+	case IP_VERSION(9, 4, 1):
+	case IP_VERSION(9, 4, 2):
 		if (mem->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_VRAM) {
 			if (bo_adev == adev) {
 				if (uncached)
@@ -429,7 +429,7 @@ static uint64_t get_pte_flags(struct amdgpu_device *adev, struct kgd_mem *mem)
 					mapping_flags |= AMDGPU_VM_MTYPE_CC;
 				else
 					mapping_flags |= AMDGPU_VM_MTYPE_RW;
-				if (adev->asic_type == CHIP_ALDEBARAN &&
+				if ((adev->ip_versions[GC_HWIP][0] == IP_VERSION(9, 4, 2)) &&
 				    adev->gmc.xgmi.connected_to_cpu)
 					snoop = true;
 			} else {
-- 
2.37.3

