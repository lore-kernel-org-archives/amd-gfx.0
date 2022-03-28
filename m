Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79369C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Mar 2022 13:07:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 222D910E43C;
	Mon, 28 Mar 2022 13:07:35 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2043.outbound.protection.outlook.com [40.107.236.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 40FDE10E43C
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Mar 2022 13:07:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n92LgRaoHHNSluYpEld4zgDRu067O/rpniD5lOk0SCX1BdS9ROc8RvbfvUCCjYqWsBJAmNWAhZGV303BXfInF75s/Is2xocg/zBX8I5EfdWlNlZIlAla3pQIFoKOZfJTzZ8ks3G7jQaALbp0lTGHK0Qomp3LQ3y0FpTPeCQnWoeL+bRx33xLWCPKgbgUQYIWmv3stL0gR97AQpyC/FEc3bZClr1ZeWxBHk60IL+T+OHW6EtBGO2Rm7PrIbEriEgN5KBo22z12kCvrl8/Zsm3PvxKoe9qXeEJqvgrTuoQIBZEj1E097kRMLnpuqB/MPhetXsdGFcneNKam8ysIjx41A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wn9cAU0kotC3CC3iwUMx+4gxJ12GvwuIglKEiCWTO90=;
 b=EO0HsupAS86Gsw9b4su3jkN7mH6kg+2ZllU5XbG3M0k95XK8702dJM964znJ6n6TNlNHSxOmeXHgiN7ZTlfpyql7eSFRwr7Yj1gvAtqMtqaLTdhcqMQU5FDd0iHiFbfcJmMNHvaSMdyOcpGSiVRGkPzUT60DwNJfaR4SSDU9D7wpruxe/FzqPGIOOaXec4omIDkqkfkl95pzwlOBABjewZWT2aN/AoMhajjKheJbpUXrsyuTThUIDw9myGCa8HeGDXftlyZjeSKG+RIM3cQdwlr9irnEiWsf+eklVTTIXahK6tBs0pK+D6iHmktd26flQRHO8SpjZ4miy8JBcJU1NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wn9cAU0kotC3CC3iwUMx+4gxJ12GvwuIglKEiCWTO90=;
 b=HHOyIiB4rm+dqzM1EpRTXNQ57Ufk3y6fguNNTu7TCGnammFgpYjpd4q5JMF292k7FgAg5N1g6n+O1Ir6In/U4X1CAQT49ELIaSWXOZcITNTggJ4JnNnG9o318LhUIo8V3G1bkzu34ym26s29jO5OeLgSi1zL+chMnoGRHi8XVpE=
Received: from BN9PR03CA0686.namprd03.prod.outlook.com (2603:10b6:408:10e::31)
 by CH2PR12MB4956.namprd12.prod.outlook.com (2603:10b6:610:69::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.16; Mon, 28 Mar
 2022 13:07:31 +0000
Received: from BN8NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10e:cafe::e9) by BN9PR03CA0686.outlook.office365.com
 (2603:10b6:408:10e::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17 via Frontend
 Transport; Mon, 28 Mar 2022 13:07:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT029.mail.protection.outlook.com (10.13.177.68) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5102.17 via Frontend Transport; Mon, 28 Mar 2022 13:07:30 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 28 Mar
 2022 08:07:24 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 2/3] drm/amdgpu: Add tlb_cb for unlocked update
Date: Mon, 28 Mar 2022 09:06:59 -0400
Message-ID: <20220328130700.29642-2-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220328130700.29642-1-Philip.Yang@amd.com>
References: <20220328130700.29642-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c03c9a5e-f1eb-40d2-d811-08da10bbeabf
X-MS-TrafficTypeDiagnostic: CH2PR12MB4956:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB4956D0952422628332C96680E61D9@CH2PR12MB4956.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NC4LRgSY3x7WhBe1gVUeuhRYOfavppjWz6RihSM2booJjN2U775AN1AwWO4DEouDST5JCV/EdrEHD9xbmYwoYLJB1cWujNxHmz+//TZ0DRe15hVhSV4YDjCZ/SEMAE77UB36hAW1EXKW53Y6232mWIXr6LTKX0kU89ka0KdsNmznD0ddu3JWZOsDA8gI1kTT/6yKw980+o3izJxABbwIC5FOiFtJl7LpKd4JdJKMq1EyYyYNjvmiRkfSEmmkHRbkxvMdA+eA/FTt9aFRuvqKiMKWErztVHv0NT73XxdPwV966KflpPRbHd93VCT1/QY7juvz/johU4wDOgGYuPCfaBGaGSZP87oiENO8wRpPqGUNh4xVb5I0JaIYJciPUOghdfpI4lxqBtgmig8TEHw/TL+1AnW4Hlm3CTlkdZ6pp6l2SzsRWatMhvveSy7H954MUDz70lZlLSDfGH+P/cKxQmtEbbnjlLPfgn1aOFYFQVsGWnvmcwHVtQkRCKDQc/e8NtG4txyXKT+s4fBbJGIlJ5VBYC7EiIpv8Ac8l7rvDlH8mUkZKMUyr4zNdd+l5hg1O+Lm4GOW9GOtjN00iCEhJ79gno5VqFypY6McCSDyxkNcR707bKD0mlMbmi65iUYD9GACHdn6JMpvI+cHxgxkMAin4e6/mj3UN3QuPoPCm2OkNIw0pyQFkFKYP/fgRkFUCGvIV10DLWbI+t2ZU0I9+Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(36860700001)(15650500001)(4744005)(2906002)(81166007)(356005)(86362001)(40460700003)(2616005)(426003)(336012)(6916009)(26005)(54906003)(508600001)(16526019)(1076003)(7696005)(186003)(8676002)(4326008)(47076005)(6666004)(70586007)(70206006)(8936002)(5660300002)(316002)(83380400001)(82310400004)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2022 13:07:30.8935 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c03c9a5e-f1eb-40d2-d811-08da10bbeabf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4956
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
Cc: Philip Yang <Philip.Yang@amd.com>, felix.kuehling@amd.com,
 christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Flush TLB needs wait for GPU update fence done. MMU notify callback to
unmap range from GPUs uses unlocked GPU page table update, so add tlb_cb
to unlocked update fence to increase vm->tlb_seq.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 48f326609976..683b08f756ed 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -927,7 +927,7 @@ int amdgpu_vm_bo_update_mapping(struct amdgpu_device *adev,
 
 	r = vm->update_funcs->commit(&params, fence);
 
-	if (!unlocked && (!(flags & AMDGPU_PTE_VALID) || params.table_freed)) {
+	if (!(flags & AMDGPU_PTE_VALID) || params.table_freed) {
 		tlb_cb->vm = vm;
 		if (!fence || !*fence ||
 		    dma_fence_add_callback(*fence, &tlb_cb->cb,
-- 
2.35.1

