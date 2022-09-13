Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40FCBC54EE9
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Sep 2022 20:05:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D71EC10E062;
	Tue, 13 Sep 2022 20:05:52 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2046.outbound.protection.outlook.com [40.107.94.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 09B4C10E44A
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Sep 2022 20:05:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AUxooi0XoUDem7ferNBYPbe24MLI/ELhzfbaAJ1X2U6ynFRAYFdI+94LzmeOOqGOvZWjh7+9quwdPuANAbQ1D3cZN8QhhlGwZv7uYNBrjLCyd8xu30b5/zWWYTSIMw324qxmpdYwcDI3+RqXrIYRFO2xTh/SGUXXxM6q+XUZRwyqGnXcZbZYB0hVy/ECQrXWu4FKOrxmhe31YmEgn1eg5ihtVbG2/dFF1usWENahs6eOnSu2JWjX7hsqhcPOH8Gyhbd1Twqp1WcOpSZ4vLvMk9gdJS31KFiCIEYtdEH+09CO1gepZBWWqDLFnOqLgQiPvgayVSPzQg9MESxm8faQzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8nth1WMLbpPy0mzfrBgrW+a8s+pe/02931fBrHRW9V8=;
 b=ad+ZYvjvcsRlnf+18p8nAv8RGjyGAZ9B4tPgrqsMVusi4g1i/veih6NKxKhaJ1O7XPbB32vSLw7IraV2XEmP9cr7rU4qw/RFCySWPVFHlhrRzSypR9p6EBAyfuK/QTxdVdHO/wzTbrUyAvh95yUbwyMWTPSJcE42FIBTwOEbwqU2cfQGNt0bALLW0xz+u9cYcxWr4NbPG074uHZ+peoyIXk9rwFKV+6jg1noZBGlzS5XP2q7jZtMQH7qy6xT7n2ucTvV1yVro2W2Lksct9U50/lpoV/IqzOrBJrRUKDIOx3/rlLuQJzVmQn+dFzeRvPlQdZSusd0Xra/b12cTaVjUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8nth1WMLbpPy0mzfrBgrW+a8s+pe/02931fBrHRW9V8=;
 b=O/OWKpQn9VZ5HhKBDRjB9EgbhTe6XolCRbaP/a/u132vwz9nA5kK3kTHBR0X2HZdfylx/ewsUGA8mpKfw/hah0zcv3JZFHTnV5PUR0hKC5xMoC/00lkVPEtWwpMd3PFx2JANKhvo2VS8G+KboMKdE/HBnINbElQv9zV1NAQgl0A=
Received: from MW4PR03CA0317.namprd03.prod.outlook.com (2603:10b6:303:dd::22)
 by BL1PR12MB5364.namprd12.prod.outlook.com (2603:10b6:208:314::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14; Tue, 13 Sep
 2022 20:05:43 +0000
Received: from CO1NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:dd:cafe::d4) by MW4PR03CA0317.outlook.office365.com
 (2603:10b6:303:dd::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.15 via Frontend
 Transport; Tue, 13 Sep 2022 20:05:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT033.mail.protection.outlook.com (10.13.174.247) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5632.12 via Frontend Transport; Tue, 13 Sep 2022 20:05:43 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 13 Sep
 2022 15:05:42 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v4 2/2] drm/amdgpu: SDMA update use unlocked iterator
Date: Tue, 13 Sep 2022 16:05:07 -0400
Message-ID: <20220913200507.8849-2-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220913200507.8849-1-Philip.Yang@amd.com>
References: <20220913200507.8849-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT033:EE_|BL1PR12MB5364:EE_
X-MS-Office365-Filtering-Correlation-Id: fb7e17a4-9423-4796-1093-08da95c356ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Aiw6MgF4+88IqzbByHhGwG2IQqoEWcmTRolV1I3pu7Mk04/WepqgRKYhJlXu2BYVci4lvpq2iiF5qi/WTcABkJUjvDUunq+T+nli6z8/Dxa5mbxAjcfZtJIqvYVIREALf1BoOKbcEtZYOFFrgk+XsmhZagKt/Ut3OgEbJRJK0kgKK45wLXcME0jOzVRsDNSCoExI+QgvdL4SsKiOyCFEZHNlm+P258/SQiWC2lOah7RqLetHApiRSKwQhLQQUGjAUAwPAfZ4bitHX07Zt2XECRNviLcI54+7+yPLssVfruTrLUjLyOk85HmaQUduCVbFseVM7hkCrGuTq7bqiCc3lMIq2r1NnIOrYyMIXdQmNrNkgC5zOqI7n3rIQMfAJ62kvR4jdjrUF4qj3t68thBxOIDQ47fhlfE48tCK9Kepl5XzQ4PBsX3EmTqsu/2q5Imd7OeBmTkNsYqGNrgzClKRJx+pwmQkTeU1MCIXxLmHEAOrHZKtilu3yFuQMVCSVVZepkhen7ZwFNXZ/lEaHQuRs9gA1LjrtjnS3VUhPh3E/WvTUypTnjrIv5wzMqZhYbnP9p+vHQW3A3eCATDdQdVBLFJ9ap0AJp4A6to21uhdGJP80elncRODvPInuIXKTPP8kZmNSt8E9P1LwYbsqxcuXWirsJ43RoD9GOi11wjvT5Y1Mwx5gYRwR7X1m14yu6KAZx9pZombpP3MHKOPZb8gfC+y/aCOMiFwrWA795A7FXVuxLDWthOezxl41rldtsQ+XUAa4MRg3y0H50GuOzZoi6Q58CJdbI8tB+9pIrYEc+MtXG8iSf1mAN4hPtYRO2Xy
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(136003)(376002)(39860400002)(396003)(451199015)(36840700001)(40470700004)(46966006)(81166007)(426003)(356005)(36756003)(40460700003)(6916009)(336012)(316002)(8676002)(2616005)(40480700001)(82310400005)(1076003)(6666004)(2906002)(82740400003)(47076005)(70206006)(186003)(7696005)(26005)(15650500001)(478600001)(83380400001)(54906003)(70586007)(41300700001)(86362001)(16526019)(5660300002)(4326008)(36860700001)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2022 20:05:43.1978 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fb7e17a4-9423-4796-1093-08da95c356ce
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5364
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

SDMA update page table may be called from unlocked context, this
generate below warning. Use unlocked iterator to handle this case.

WARNING: CPU: 0 PID: 1475 at
drivers/dma-buf/dma-resv.c:483 dma_resv_iter_next
Call Trace:
 dma_resv_iter_first+0x43/0xa0
 amdgpu_vm_sdma_update+0x69/0x2d0 [amdgpu]
 amdgpu_vm_ptes_update+0x29c/0x870 [amdgpu]
 amdgpu_vm_update_range+0x2f6/0x6c0 [amdgpu]
 svm_range_unmap_from_gpus+0x115/0x300 [amdgpu]
 svm_range_cpu_invalidate_pagetables+0x510/0x5e0 [amdgpu]
 __mmu_notifier_invalidate_range_start+0x1d3/0x230
 unmap_vmas+0x140/0x150
 unmap_region+0xa8/0x110

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
index 1fd3cbca20a2..718db7d98e5a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
@@ -211,12 +211,15 @@ static int amdgpu_vm_sdma_update(struct amdgpu_vm_update_params *p,
 	int r;
 
 	/* Wait for PD/PT moves to be completed */
-	dma_resv_for_each_fence(&cursor, bo->tbo.base.resv,
-				DMA_RESV_USAGE_KERNEL, fence) {
+	dma_resv_iter_begin(&cursor, bo->tbo.base.resv, DMA_RESV_USAGE_KERNEL);
+	dma_resv_for_each_fence_unlocked(&cursor, fence) {
 		r = amdgpu_sync_fence(&p->job->sync, fence);
-		if (r)
+		if (r) {
+			dma_resv_iter_end(&cursor);
 			return r;
+		}
 	}
+	dma_resv_iter_end(&cursor);
 
 	do {
 		ndw = p->num_dw_left;
-- 
2.35.1

