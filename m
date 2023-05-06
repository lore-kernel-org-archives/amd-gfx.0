Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21E69C7EE22
	for <amd-gfx@archiver.kernel.org>; Sat,  6 May 2023 09:04:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8015610E209;
	Sat,  6 May 2023 09:04:05 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on20625.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8c::625])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E465410E209
 for <amd-gfx@lists.freedesktop.org>; Sat,  6 May 2023 09:04:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lGHadGfopZK7LzrreUOSZuNbDAMuAMV79TKB/0mpS9zJuZRy2NRzTWB9BPYAjlsM2FRtKJePDQhoroj5RXKCIP3wi/z4pI6AF4hlwGENfC6ITrtO4wfcbrvifWDbaMdhGFsuURu71y3WDXJLhtAgNo4WLPGn5NNYMiLJEy7f82mKM0B6aikJDxJ85rIzVOaK5wpe/6yxqc9dmf97VVMXHWdBHooDXXeMmt2xqgRm8LrqZfGUsUgQKIxC7bbT/QjU8ZOoL8lFZE6H5VNl7oWLfBQFYzmmqHwoj6KRfzyl0ulGlYW3BvDmOKEkQ6Gy6CuktsrCS1/Iw2nu4bh3/V6Sfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DODiyF2in30heVgZU6iB8STUr3QnkHibB+VCDu7NxTk=;
 b=JNWix4IXYBWSjYxdPp5n7PToQxCVtI1zi0o0fjf0ZlgRHKqxX9QBDzuaz98+p8FEmOZj0qEsioGok5v4BDy7AUq0TeqdMi2eMRyL5TXQrP4HIgOI46NaIHsooZJv0pFGgMHj9lardK9ar3LK+MUlL/zYXJF/8UTb6LSOl3QfyKmy72N4BefGbMYKe6TYYQ/gpOnCFgWj3bBfFa/k7MrmtFCFGX2U5mz35MaE+n+WTJ33+AJdBEBKC7/hri+noxth2e4cboyFMxCEEJU5UT2gECDVjhPPzCJ0hqWCAh+e1oRPoECx7Pwalb4D+70rNXCtEQ89F2+frcWOUGHiRtYmDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DODiyF2in30heVgZU6iB8STUr3QnkHibB+VCDu7NxTk=;
 b=HkD1bsdI94Ndk3bcJ8nr1vRQ4pmEYidQX0EByCnQpoASoNkv3vDQoTDXzKlSbcDOrRpa9Lfy3AQFt2sxSuEC2YYnWkqu4Bvs1zldy4yLbInufOTFkrhKiBeOOSr46eA1HC1Qmml2aeAwVfH/n1yKc34AE9FI+HdN8nj+qllVtvE=
Received: from MW4PR03CA0172.namprd03.prod.outlook.com (2603:10b6:303:8d::27)
 by SA0PR12MB4416.namprd12.prod.outlook.com (2603:10b6:806:99::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.27; Sat, 6 May
 2023 09:03:59 +0000
Received: from CO1NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8d:cafe::41) by MW4PR03CA0172.outlook.office365.com
 (2603:10b6:303:8d::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.29 via Frontend
 Transport; Sat, 6 May 2023 09:03:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT055.mail.protection.outlook.com (10.13.175.129) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6363.29 via Frontend Transport; Sat, 6 May 2023 09:03:58 +0000
Received: from guchchen-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Sat, 6 May 2023 04:03:56 -0500
From: Guchun Chen <guchun.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
 <hawking.zhang@amd.com>, <lijo.lazar@amd.com>, <Tao.Zhou1@amd.com>,
 <christian.koenig@amd.com>
Subject: [PATCH] drm/amdgpu: disable sdma ecc irq only when sdma RAS is
 enabled in suspend
Date: Sat, 6 May 2023 17:03:36 +0800
Message-ID: <20230506090336.1879435-1-guchun.chen@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT055:EE_|SA0PR12MB4416:EE_
X-MS-Office365-Filtering-Correlation-Id: 595e6498-2b14-49fe-a6e8-08db4e10d442
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: biaUxWX5V2uVqI7BTYY+uv/8buE5AHuFqraNpPgWbBhmpfjV41QoTZWJXIUV9h0KLahy6weIt/QYoUW0JhTkaACWl6TRPIJE/DIOfHgkQ5GaAYkCNGvYdmxVHWOa0nR+gkkaYrgOFOfIX5rqMHgQKzh1IUeaybebjs1mCBao2V9c0/IG02dyvdIRHzpCYgYU5gr/Ba5a8hyIyiNvNgaVFZYmnb/noVhpbsn3hEG/i1ltCi5mRbVeZVgjkRcPb5Y0IokK4JLwwLU5LFafVITH/kWHewJoQzkJfLftRiXzEXNdIgA86RQr9vqD4LjjTtnufEUA3O3zV1wnCCZwesJc2xxyshmu3tBgubZqch8nKw7rgsa2yBr7up7WZ/s396v5jWsQOfyOG6u+0MnveZTosrW3egpHkXjHkQBAhg/nlnFb859TMpgfQqGKryWKxB7ldqS+oxvVwUtaQ4hvC+2Ar+eRVv/zM6A4/VORRFIed+Ft3conh2/MMv9YqygT0QRU8ziEVjibfeAxhj20J9cS8VZ0KdPa3+WtQCBo7gc5kLE6eVp7y1H8dvdNGPSPdTtkIrwlP5shaOmiNkC660bSulkHqq5VNOLb5Q3Tvkqff9d7o6oEh5t3AFhzRW3XXgYstcYn6b8sJie5fk/bWVfjer0LMNDBYBDOhQ0JsxBI8lPhREVLnF9kFdQFtNymyNwcHDPPy45KwInM1kCkqDNktQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(39860400002)(346002)(376002)(136003)(451199021)(36840700001)(40470700004)(46966006)(86362001)(36756003)(110136005)(316002)(6636002)(4326008)(70586007)(70206006)(7696005)(966005)(6666004)(478600001)(41300700001)(40480700001)(82740400003)(82310400005)(8676002)(8936002)(5660300002)(2906002)(15650500001)(44832011)(16526019)(356005)(81166007)(186003)(1076003)(2616005)(26005)(36860700001)(426003)(336012)(47076005)(83380400001)(40460700003)(36900700001)(2101003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2023 09:03:58.8919 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 595e6498-2b14-49fe-a6e8-08db4e10d442
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4416
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
Cc: Guchun Chen <guchun.chen@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

sdma_v4_0_ip is shared on a few asics, but in sdma_v4_0_hw_fini,
driver unconditionally disables ecc_irq which is only enabled on
those asics enabling sdma ecc. This will introduce a warning in
suspend cycle on those chips with sdma ip v4.0, while without
sdma ecc. So this patch correct this.

[ 7283.166354] RIP: 0010:amdgpu_irq_put+0x45/0x70 [amdgpu]
[ 7283.167001] RSP: 0018:ffff9a5fc3967d08 EFLAGS: 00010246
[ 7283.167019] RAX: ffff98d88afd3770 RBX: 0000000000000001 RCX: 0000000000000000
[ 7283.167023] RDX: 0000000000000000 RSI: ffff98d89da30390 RDI: ffff98d89da20000
[ 7283.167025] RBP: ffff98d89da20000 R08: 0000000000036838 R09: 0000000000000006
[ 7283.167028] R10: ffffd5764243c008 R11: 0000000000000000 R12: ffff98d89da30390
[ 7283.167030] R13: ffff98d89da38978 R14: ffffffff999ae15a R15: ffff98d880130105
[ 7283.167032] FS:  0000000000000000(0000) GS:ffff98d996f00000(0000) knlGS:0000000000000000
[ 7283.167036] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 7283.167039] CR2: 00000000f7a9d178 CR3: 00000001c42ea000 CR4: 00000000003506e0
[ 7283.167041] Call Trace:
[ 7283.167046]  <TASK>
[ 7283.167048]  sdma_v4_0_hw_fini+0x38/0xa0 [amdgpu]
[ 7283.167704]  amdgpu_device_ip_suspend_phase2+0x101/0x1a0 [amdgpu]
[ 7283.168296]  amdgpu_device_suspend+0x103/0x180 [amdgpu]
[ 7283.168875]  amdgpu_pmops_freeze+0x21/0x60 [amdgpu]
[ 7283.169464]  pci_pm_freeze+0x54/0xc0

Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2522

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index b5affba22156..8b8ddf050266 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -1903,9 +1903,11 @@ static int sdma_v4_0_hw_fini(void *handle)
 		return 0;
 	}
 
-	for (i = 0; i < adev->sdma.num_instances; i++) {
-		amdgpu_irq_put(adev, &adev->sdma.ecc_irq,
-			       AMDGPU_SDMA_IRQ_INSTANCE0 + i);
+	if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__SDMA)) {
+		for (i = 0; i < adev->sdma.num_instances; i++) {
+			amdgpu_irq_put(adev, &adev->sdma.ecc_irq,
+				       AMDGPU_SDMA_IRQ_INSTANCE0 + i);
+		}
 	}
 
 	sdma_v4_0_ctx_switch_enable(adev, false);
-- 
2.25.1

