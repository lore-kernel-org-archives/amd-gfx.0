Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0B42C7EE22
	for <amd-gfx@archiver.kernel.org>; Wed, 10 May 2023 21:24:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2666810E547;
	Wed, 10 May 2023 21:24:23 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2065.outbound.protection.outlook.com [40.107.244.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD6EF10E53B
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 May 2023 21:24:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oX91IcmRMjfKPigLECZfZ1rIWWTAYBt8T+oU/4oDwavOLLi2P63R4ShXL+e4NmiLsX3LNG7/y29z+wAurTNsZT8EfFSoIr/dplxJyY4MjoCRgGznAGKLHRi/t8PRm6kGvkZZrftCuZd3V1+NrYrd7LysaUWf2YMrC61pG7xPX8LpAuNs5/bfNZz5W8+dRevDbUGOu3y1Ptqqa2kbd5beV12+EF4xzC71T9Tew4tWOzM5wHIUxe8Ws/g9riO3s7M0IqDR4U55yVGsaLgZsz73/iMzrBZBMiNyGJyN41juC/xTX/Yu/Ae2F1XJF73i3fdmzNImWDjCUuADhg8tqx063A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bcdYVHa2hOM6gUT0AZfKnc0hiQpCfQCti42DQ61q4CQ=;
 b=gYlckCCOAclN13biGN+RHVQ43XexksOyCZstyEk0jwwiWfYeiEmIjOtrbtPyr2jTwef/YezLk1WcYVk3F8ZdEs3yD3zf5ESn+hSbfBD6o3AuRr0Fw6eLa3C0XQ+DB5mOLRmjTFx9j1Bndem7WzRkby7FDz60Q9yE5jexdpPTstoEzUHrAgn2Vy3L9MfflfDWDI3K+mYQfylwp5dRg+C677kWhnEtIgD4S2d/pq5RdboZqdsb8tSMQkgAe47I0oNhcMjzVTekD6XAjKxn7dVFEQggQMM+0WjLacqsmIbSrXeuslHfLM6GZy4Y1WpFgaCt1QwEWTtxnSRv6r9SZ2J8JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bcdYVHa2hOM6gUT0AZfKnc0hiQpCfQCti42DQ61q4CQ=;
 b=D9WqLvrjeebA8YpZg83AM6t5gzlkeeWhRZ85J8IZok605/J5o4whZYuslvwiCEoU5Ec5yMWDvgOiOlXSYM7VARwTtkepyHWstWBB4RqGZe/RaCIS3et2/IxYeheX+noNa6qcrwfhvrthk2yTepF5TNvb3QlRS5iIg3TS8CzZUv0=
Received: from MW4PR03CA0200.namprd03.prod.outlook.com (2603:10b6:303:b8::25)
 by BL1PR12MB5142.namprd12.prod.outlook.com (2603:10b6:208:312::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.20; Wed, 10 May
 2023 21:24:00 +0000
Received: from CO1NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b8:cafe::e3) by MW4PR03CA0200.outlook.office365.com
 (2603:10b6:303:b8::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.18 via Frontend
 Transport; Wed, 10 May 2023 21:24:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT014.mail.protection.outlook.com (10.13.175.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6387.21 via Frontend Transport; Wed, 10 May 2023 21:24:00 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 10 May
 2023 16:23:57 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 19/29] drm/amdgpu: Alloc page table on correct memory partition
Date: Wed, 10 May 2023 17:23:23 -0400
Message-ID: <20230510212333.2071373-19-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230510212333.2071373-1-alexander.deucher@amd.com>
References: <20230510212333.2071373-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT014:EE_|BL1PR12MB5142:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b40d6f9-83f1-4f5f-92f7-08db519cdf2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PfQChjjkaFWt7Wy4Jd9Vpl6ul+Il2/ugJREeDzf2YP3/CrmLqUor4xfPdrQuxR3BxFwgJjRye15izfXc3rJJIqcJx6LO/v2Qjcp36jWeXcHxAaKWTmzAWTgMgH7AWDEJ506Sq4eshjWTeLzo+CTqWF9vbAzzVC1VjTS5wJxrkq61t5vFM1oTnrLSszWzAiRpj4+3nMbp8timFg4btamUjFC6++8udNt2TafzLbWsVw9NgfuqIUs1FGg2PyhcBU9mLUcGVHE21/9IoYpaDt5TRZDUMBpRY3m0r84ip6qFLX9qT9nkUuTT5g6LjoCe1tRMyml1EJrtu7TJGlEkXrAiNh4FV688QoYEJjl3XDNxSYR5qNZIsuSOJsfDHg2XHjVWb0y7ixDULQFQSzptAdg2oCEpyVMMQMJyb/7C1H6Bhc4CyY4igVZPVU4MhnpoRoFSGpeToASMUBbFM6KmbwKHdb7t+VMHTXUziXxKmebBakiTJzLfKBCLhXNGJ6lUY5nbZ/tSbefcf7POTf05pegnHYJSBYHTcEnX/W4e6w56S2RKvUeBFsgS4cSIKDDuhOC/Dp1iL5yy7+4uu9XDYH3GPOwjw7VsBO/Sw/PQeQvfPCMc0BEsNT3Aev1b5YE4Uz4fdyHj4Zo8o3Q5Xq1S/FSqFE0K+S+U0mFEphpvmiq+I20XtqAZdyf1S/+Ra7ftW49anf2OQJ1mU8b2jvaI8XIIHx6eC2FZMx/TXeXnIm4XSUlL/kisLNG7N78VgFgiw8cKkuS20OpISJzUUdsKp5UT8w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(136003)(376002)(39860400002)(396003)(451199021)(36840700001)(46966006)(40470700004)(36860700001)(40480700001)(36756003)(8676002)(336012)(86362001)(2616005)(426003)(8936002)(5660300002)(47076005)(83380400001)(40460700003)(70586007)(6666004)(7696005)(70206006)(54906003)(82310400005)(478600001)(41300700001)(16526019)(4326008)(316002)(6916009)(26005)(186003)(1076003)(356005)(2906002)(81166007)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2023 21:24:00.2417 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b40d6f9-83f1-4f5f-92f7-08db519cdf2b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5142
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Philip Yang <Philip.Yang@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Philip Yang <Philip.Yang@amd.com>

Alloc kernel mode page table bo uses the amdgpu_vm->mem_id + 1 as bp
mem_id_plus1 parameter. For APU mode, select the correct TTM pool to
alloc page from the corresponding memory partition, this will be the
closest NUMA node. For dGPU mode, select the correct address range for
vram manager.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
index 60b1da93b06d..62fc7e8d326e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
@@ -534,6 +534,8 @@ int amdgpu_vm_pt_create(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 
 	bp.type = ttm_bo_type_kernel;
 	bp.no_wait_gpu = immediate;
+	bp.mem_id_plus1 = vm->mem_id + 1;
+
 	if (vm->root.bo)
 		bp.resv = vm->root.bo->tbo.base.resv;
 
@@ -558,6 +560,7 @@ int amdgpu_vm_pt_create(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	bp.type = ttm_bo_type_kernel;
 	bp.resv = bo->tbo.base.resv;
 	bp.bo_ptr_size = sizeof(struct amdgpu_bo);
+	bp.mem_id_plus1 = vm->mem_id + 1;
 
 	r = amdgpu_bo_create(adev, &bp, &(*vmbo)->shadow);
 
-- 
2.40.1

