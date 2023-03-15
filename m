Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A31EC6FD1D
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Mar 2023 17:53:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E6EDA10E1F3;
	Wed, 15 Mar 2023 17:53:54 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20614.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::614])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C5E4410E1F3
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Mar 2023 17:53:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MiDKlgaSf1wuVc+msXOxy1IhdPvj8Li9mUxrAo8M0KpBSwD3g1G2/PPQM/UxS1D2dwWQdh4tVPV9CroEyw8CPb/vpmEvBfUc7N1PtdK1cosIP/Ez9Iz3csP4BfVieaB5Me2ZBYiV0DkTfjclMmF7y+NCd5DpGpsaGwDW9rNJa7xHIkg3KXqKhlpn+uc3fhitvjhKTBJg7hyGYdFFcmXrH8Ts/aglSjG0jp6UuBNpgDdA6dbG9T/f0xjOTuGwcPGHM33POWXc3XhEHAZ974J0cZedOXweHJQyqXZXHMxMtDIfFmoeBg7Urwxai/nx433uBSspNp0mty3xn3Lq0DgK/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aFk0vKPSGtZAOaTbzmqDgX6r//5Ch452VSVGM0MFev0=;
 b=EdSOyYKqaIMIuiQlAyHp9/O5zmiA2ZSOxG9IF1n9j117ZgIWOT0MsRh9rqB7hPrWB6T84W0+ftgddY8KWgmZfUdlZ2E/iXmaBaflNOcD4m/ODh8Dtfq2XhYUm4EyvBp71LfQKELzVt8bvH8MM6q1kyiJFP+/2OVQKM0TrJKpqas2G36qzJL5/xC0Geqjcch5JYHyhIoXPlRPPRTX233R32rYwEJFIGPK5CL8s/8Rz8Jfs08XaYzHiuHG1RVWtF0qoi6vGZDZTJ+IF76qqloNs5ubxvFth1Rm4qEL2TuHO3syLv+uh9tM4vH4u1fJQCzcWRFbhoVhMYhfcPw3UnpQjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aFk0vKPSGtZAOaTbzmqDgX6r//5Ch452VSVGM0MFev0=;
 b=jpMDx0xcyKhBpuTCKaPCmQraaWnTwUs6uvWCvjnrHu3rkonNq9aaRhaZeR6lbiDGA5u2k5gKZpyHEa16CI82o5OIadtBpGkZhtmoGWr1JoxHCmA0Ri4LQfd5FsJF/Vm6uFPrbtSzqlyoTrYnJt2JM0ybVi1OYKgzZ+YOLrqxkQ8=
Received: from MW4PR04CA0145.namprd04.prod.outlook.com (2603:10b6:303:84::30)
 by CH0PR12MB5043.namprd12.prod.outlook.com (2603:10b6:610:e2::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.29; Wed, 15 Mar
 2023 17:53:51 +0000
Received: from CO1NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:84:cafe::ee) by MW4PR04CA0145.outlook.office365.com
 (2603:10b6:303:84::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.29 via Frontend
 Transport; Wed, 15 Mar 2023 17:53:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT065.mail.protection.outlook.com (10.13.174.62) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6199.16 via Frontend Transport; Wed, 15 Mar 2023 17:53:51 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 15 Mar
 2023 12:53:47 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: drop the extra sign extension
Date: Wed, 15 Mar 2023 13:53:29 -0400
Message-ID: <20230315175329.3774178-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT065:EE_|CH0PR12MB5043:EE_
X-MS-Office365-Filtering-Correlation-Id: 582b1f88-73e0-48a0-95a6-08db257e3c5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jX55f8YUBhdnTaVngusX0eKa7EGwvK6EXEVrY8HmHob5DmuMFQdsVlC4VRGCwFXGWqwA1xTqyIb/7o51sVmEv2WVV4TL9U0yP6mTJU+GBPttcGdDOo+6Q6UcXR8n8OK8kFfI+YbE5zSCok4ZLPv5pfw7kYZemOu+Hfr9ty+NFZtKmI1Rtso+XTA9Rc0uNNYN0valZoJ7qALmslb65U+O5MqlFDxSv1oDn4HPPLxIvS8ovHe0YdUt7xbHSkVIfxLEMGLjdBAYwIgY/6ON8vQh8zw+DHC5qr769GfjeTDZebIY3DxRAPE+6ldm/FePozH9H+aWqYCFc6Uu/E9eIWDiyQzEh8nIh7/e11gaK4DHzWd3eyOVeB0DIwOdEqpDnubPIYa/a1jpSEkB1Yt49fSVQoCk5RV3F2M6ghrecLOBUptMrkOiuA6+9mhFq+mz21dRRBqsrRf2Lkk2NhOmC4RalwRJJdbRqwRxvT6q3cYVV5Ev3hKv5+ayDNUWZn20caHyYpmEV85EzpDVM7T/VU+97LKTQwFYG158izPpaf49lLXUbzTIGVkvHguRMdFEc+suwsgtXnrVKG9GTndrxZ8Xvd/Wefj7ZDJcxRmcgjYien0PfoI8TitNbImW49XzGXZ44NMGOfLF0+zuIRkRVy6UxSiSNdT9Cs8gFu8IQAO+USHD3mqNiW97hts8SMjSjaQgAaXQwOptXyUByLcK+Y3QmQXMW+2DR3ss1UMZ/tA8oSA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(39860400002)(346002)(136003)(396003)(376002)(451199018)(40470700004)(36840700001)(46966006)(5660300002)(2906002)(36756003)(40460700003)(16526019)(186003)(478600001)(336012)(83380400001)(2616005)(47076005)(426003)(7696005)(26005)(6666004)(1076003)(70206006)(70586007)(356005)(86362001)(8936002)(41300700001)(8676002)(6916009)(4326008)(40480700001)(36860700001)(82310400005)(316002)(81166007)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2023 17:53:51.0342 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 582b1f88-73e0-48a0-95a6-08db257e3c5f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT065.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5043
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

amdgpu_bo_gpu_offset_no_check() already calls
amdgpu_gmc_sign_extend() so no need to call it twice.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
index 69e105fa41f6..ce2afd7e775b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
@@ -152,7 +152,7 @@ static void amdgpu_vm_sdma_copy_ptes(struct amdgpu_vm_update_params *p,
 
 	src += p->num_dw_left * 4;
 
-	pe += amdgpu_gmc_sign_extend(amdgpu_bo_gpu_offset_no_check(bo));
+	pe += amdgpu_bo_gpu_offset_no_check(bo);
 	trace_amdgpu_vm_copy_ptes(pe, src, count, p->immediate);
 
 	amdgpu_vm_copy_pte(p->adev, ib, pe, src, count);
@@ -179,7 +179,7 @@ static void amdgpu_vm_sdma_set_ptes(struct amdgpu_vm_update_params *p,
 {
 	struct amdgpu_ib *ib = p->job->ibs;
 
-	pe += amdgpu_gmc_sign_extend(amdgpu_bo_gpu_offset_no_check(bo));
+	pe += amdgpu_bo_gpu_offset_no_check(bo);
 	trace_amdgpu_vm_set_ptes(pe, addr, count, incr, flags, p->immediate);
 	if (count < 3) {
 		amdgpu_vm_write_pte(p->adev, ib, pe, addr | flags,
-- 
2.39.2

