Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2345BC77B6E
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Mar 2023 19:18:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D0EF710EFBE;
	Thu, 30 Mar 2023 19:18:16 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::601])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D1B310EFBC
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 19:18:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N1VDdnUeOy8s4zIF26HLMsCduglCrRzO7e2BKEyhKd4TBCNIJb67R61kcGUMoFySqwOjnOWnVAFNTL26RKR1ajCIdJrN0O2K2s9tafn/YeuNn8aqcJ2C4MJEgBTJiAHLGGTfScVCfrCBLUpwtF+b+LpUt+i3IDWZJ4JSxFO7VvI1wboPIusmpGf3IPORUwsyjdY9VTvpmQZp6cEInsRxLkhR/0moHlk8dm+HrChOUudpDXtgZQ03Hs2heOD2Ya1tHKzjzLaiYvjbIDzcYT7VYq3XMsvaprHQca9GINFyXlv4hZOTGzLbefzi8mJfDBK0RGadkv7pOfOq/R6dPazScg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gjSuPFBiwqrbvFRVrytXO79EfwV62gdyHydViS3dSb0=;
 b=VY4C+naf6pOuAAJCh2oouIQ1Ox7TRth+mUnWnnCPKYAteBvCjCvzDO0iZWPZjTU6TW62NeGlld9FGyxxTx9uWjtIkfza8m4lubEWbn/EgLqv9vfjdWoyPihfCj95Tp/KL1edO7uyhqhudXXuz7lVG8M/CwFkF7gA9UpbiEsGClMHkpNsogamaY0Jq47sQr61ENcIdHRuXSGjzkRgpX0DXIvWUV//M18wY+IqVD+Rh3BHwcQvdwda8B9IkR3dQpq2EuOHImcfHzY2Ftmiz77fPWvTWavrY2H96QcjGu1DGCuNmzR4Yck0UBE6X1knhaUq+GDINOV8pNJKtZGKozQ0Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gjSuPFBiwqrbvFRVrytXO79EfwV62gdyHydViS3dSb0=;
 b=UKTzawpdZoLiX/Q3r11X3Jogm2QipwPb0Z6XLtiVJHoRHK48c0+rKnjpS3Qe0NooNQN5hYmGHSs8wnI7RvhHVzSJy5WTIyqzHefQCfgqDcT9HdoQsJ9SaSvHUX3AnV3ZaeA6l9VxqWxCplRuztbNq3wUWKXsJQ/Ct5ajsckOirM=
Received: from BN9P223CA0029.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:10b::34)
 by CH0PR12MB8577.namprd12.prod.outlook.com (2603:10b6:610:18b::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Thu, 30 Mar
 2023 19:18:07 +0000
Received: from BN8NAM11FT073.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10b:cafe::f7) by BN9P223CA0029.outlook.office365.com
 (2603:10b6:408:10b::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22 via Frontend
 Transport; Thu, 30 Mar 2023 19:18:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT073.mail.protection.outlook.com (10.13.177.231) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6254.22 via Frontend Transport; Thu, 30 Mar 2023 19:18:07 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 30 Mar
 2023 14:18:06 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 08/13] drm/amdgpu: add gfx shadow callback
Date: Thu, 30 Mar 2023 15:17:45 -0400
Message-ID: <20230330191750.1134210-9-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230330191750.1134210-1-alexander.deucher@amd.com>
References: <20230330191750.1134210-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT073:EE_|CH0PR12MB8577:EE_
X-MS-Office365-Filtering-Correlation-Id: fe032bed-513a-44e8-fa55-08db31537e5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Xwy1bDq3LcldHxDc5KZ76C5nlSfVm9iGgmpfEks34A0cuHSeAoWeXmAgIez6Db+AswbO/BZNvFhN8tBGUBJxk4pk7ZJplUs2h8aYfF37q9HsibaHpLjiLqL/+qCpH69VzA/gIbioIgntLCLyhwMXymNtPl71AZG0PDm99EHDDgszfakA9H7o7XKPEmOhosCDButlyrSSSX+PsAdYy4gQ836Fi1qjO9d7LfcNCcqSUnaHKha7XTlaKe0kn2ZaQD0QrBATKIY0KiOnAV77t66UAfZwL1WHVj/ea48ug73IUJTk8ciluC0jcee/9snBUNtTADz//BLRor7QuXCGS2oe8B1xKPeKvQFd0dHNu6DtuG67AeJ+7kP2tBGnn5IHD5Sjaf5weZ+OaX9bLND3dxBi5NMZz4hkXLK+VmzvV89t1emmPiVB/NdQorCI1zOBM3K54hKGfqZyXDKt1ls73yoVmyc4Q2k0pSJnqQCxHYt96/1mivKwizIb9e4Jixlu2/XeSM4ct7QKfYQ8QvKc5BNISjr5WpWWSpbVjuQ2v9QU+ULtClDkxlhP8FbWVV3wEeXtwWKKO6u69+bIUkNgslOOxC9BLm9VWB7CsFO3IvWDkNITuF/PlBJ/dI+jXb04sybCDZzB0VgPr1LeoUruJzvh/0S0w27D+Ukp59vCYd9Kd05pfGjPddNiaYBoNJZZgMM1Jm9of9M2TIAPXsVZsudVAJyPyUN/32O879/M/d1b2dY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(396003)(376002)(39860400002)(136003)(451199021)(40470700004)(36840700001)(46966006)(47076005)(426003)(86362001)(336012)(36756003)(83380400001)(82740400003)(16526019)(82310400005)(2616005)(5660300002)(66574015)(186003)(1076003)(8936002)(2906002)(26005)(356005)(81166007)(6666004)(40480700001)(41300700001)(70586007)(70206006)(36860700001)(40460700003)(4326008)(6916009)(7696005)(54906003)(316002)(8676002)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 19:18:07.4723 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe032bed-513a-44e8-fa55-08db31537e5d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT073.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8577
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

To provide IP specific shadow sizes.  UMDs will use
this to query the kernel driver for the size of the
shadow buffers.

v2: make callback return an int (Alex)
v3: drop GDS (Alex)

Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index 4ad9e225d6e6..62047a541c21 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -219,6 +219,13 @@ struct amdgpu_gfx_ras {
 						struct amdgpu_iv_entry *entry);
 };
 
+struct amdgpu_gfx_shadow_info {
+	u32 shadow_size;
+	u32 shadow_alignment;
+	u32 csa_size;
+	u32 csa_alignment;
+};
+
 struct amdgpu_gfx_funcs {
 	/* get the gpu clock counter */
 	uint64_t (*get_gpu_clock_counter)(struct amdgpu_device *adev);
@@ -236,6 +243,8 @@ struct amdgpu_gfx_funcs {
 				 u32 queue, u32 vmid);
 	void (*init_spm_golden)(struct amdgpu_device *adev);
 	void (*update_perfmon_mgcg)(struct amdgpu_device *adev, bool enable);
+	int (*get_gfx_shadow_info)(struct amdgpu_device *adev,
+				   struct amdgpu_gfx_shadow_info *shadow_info);
 };
 
 struct sq_work {
@@ -372,6 +381,7 @@ struct amdgpu_gfx {
 #define amdgpu_gfx_select_se_sh(adev, se, sh, instance) (adev)->gfx.funcs->select_se_sh((adev), (se), (sh), (instance))
 #define amdgpu_gfx_select_me_pipe_q(adev, me, pipe, q, vmid) (adev)->gfx.funcs->select_me_pipe_q((adev), (me), (pipe), (q), (vmid))
 #define amdgpu_gfx_init_spm_golden(adev) (adev)->gfx.funcs->init_spm_golden((adev))
+#define amdgpu_gfx_get_gfx_shadow_info(adev, si) (adev)->gfx.funcs->get_gfx_shadow_info((adev), (si))
 
 /**
  * amdgpu_gfx_create_bitmask - create a bitmask
-- 
2.39.2

