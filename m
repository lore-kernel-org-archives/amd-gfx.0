Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F6ABC77B61
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Apr 2023 03:24:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 037E910EA55;
	Thu, 27 Apr 2023 03:24:09 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2083.outbound.protection.outlook.com [40.107.94.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E61A10EA55
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Apr 2023 03:24:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CwU5G5bE59oQ7sVIDV3x/elEQNgrXGPy/fTUeOZf0Ov6iQKnpimNjq/S20SKtTr+b3a3h3/vZhZlydv9tgjxX/JE2DXHlgn9HnNWZ7GGdZFGO68iYeDGDwEErl87DwzzOqOOItd+Bu3Tn7EuXRtr9vRoBo3/RE2/277HwonHeuDVJ+xBZE+NmpFlCggibUTvc2V1BK10PQTzxIpeKye4TmlHBe9rAoJLT5JLG6WZL1PDE32WKRXSf205k7CK17tpcyzKliDwjBKYrN4AY6mazLRqljcNjFqtifJHWXC3cevuxckendCHntbSM+//dTWnI6LiMwDcm89MRlbkhrnr9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0uhf6fd7sTg14PEzqyf7hCXdqoSeKNZwsjkct+z45T4=;
 b=nbm/mH4OlbxYq9nUHXSQX0KI3pjepiHqnqAvRRppkyUCQqEzfNoKRpUUNOoBmxgu3bw9kcszmW9/GmTNLXp0i/zcWatLBUWCUb/U3qbK6twikaqZEGNdcRiDOiHpTPT/sGjBmH0uBXNslgFjIG/nR+Eiea0182cpf13mwFztR16kLWvFju+4h3xhE3Qoxvb8920IhLkx7IjghBIibIWGfPrwqx/HsxpfZvRvt7PSJjjLEwgD1VkSf4nL8vOUeljnjG7OaZ1XmEg2/W/TsyoCzBVf+Q816iS8UaHP5POjQEpxkK8qcjnUzfSuCzLKdRNqLbosR0+4hHTT44PyLA3F1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0uhf6fd7sTg14PEzqyf7hCXdqoSeKNZwsjkct+z45T4=;
 b=XfstuycYsHEnfohVmEc2z2BPdAPOLaLVbiWa2Bt0p3MeARElJLFMWq4Jf+zv9I9jCr+pwQJUdDSvnz2GYt0omtkEorVpWcSoCiEpV7aIqwsNLrx6t2bBWjNiLtkv2hDqxj/FCntYcApI/4bpv6ujBOWp2gHEVFcI/YTw1Sg9Wp4=
Received: from MW2PR2101CA0024.namprd21.prod.outlook.com (2603:10b6:302:1::37)
 by MN2PR12MB4304.namprd12.prod.outlook.com (2603:10b6:208:1d0::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.21; Thu, 27 Apr
 2023 03:24:03 +0000
Received: from CO1NAM11FT105.eop-nam11.prod.protection.outlook.com
 (2603:10b6:302:1:cafe::5c) by MW2PR2101CA0024.outlook.office365.com
 (2603:10b6:302:1::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.5 via Frontend
 Transport; Thu, 27 Apr 2023 03:24:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT105.mail.protection.outlook.com (10.13.175.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6340.22 via Frontend Transport; Thu, 27 Apr 2023 03:24:02 +0000
Received: from primary-host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 26 Apr
 2023 22:23:46 -0500
From: Lin.Cao <lincao12@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Recover vram from vmbo->shadow rather than
 vmbo->bo
Date: Thu, 27 Apr 2023 11:23:29 +0800
Message-ID: <20230427032329.3195820-1-lincao12@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT105:EE_|MN2PR12MB4304:EE_
X-MS-Office365-Filtering-Correlation-Id: 496ecdf8-1184-4940-0c74-08db46ced947
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IHPVuvPM1B9rXP3/uUngySMvS7Wtc4G8lf1pYTBpjvBEJsKnna9A4RmuSkqBImIE3HMsxZo1Y3NOghnipRmpSQSU4HjIvFp0RLMWErhLS9ABbbo3+3xVV+uMVPI1xwv8LFsomTup4UhCHM6noCbgdmhqrCbAw33pP4VnDeaFzwEP6cOVAhQAXQ6Yh8GwrO3QQyiPH2mM6YO0imvoRQyvx1EDYmJ92eoWoNEvvfFdNVqAD8DT7AcUDMKtzYEN53f03baCjpWeeVgB4SAZJpqZsRMAX7xa23/wdvAjanwsDNSXLlaXC8CxQ4hWbKGBSCwwJRvbCVy6JpFQ2X9ei56YJIbyaaA2h7GluMNv1Zw+x0Y4Sll0Yke11VHvpzoWSIfldZ4zZVam9aAYAXU23tILG80AIEr5yOfWfs1CWA8TuvtL4852BT40sVMCzG5k9pEacy2HLQngb8E0yrGrAlMhFQULKYvDJdGpsFVDOtyJjTFJMrzosCzxgaTRqOjVZRO8zinUWbSSRClid76uTEwMGbjeHi5oBsaLQ9Du7FeHhYJMWtTnovqHe+WZAdBnQqVgbJZkQB1SI1TIWEn6riml5eNQk7HmiPBikg4h+hRIzns5PkC8h2phRDOxyNwuDZyZ+2BDwiXWoAuvnkQ/AV/s75+sx96EnIJzXLgD6FMLOCyz3Xox/YTKDuxaiCBA3d9YEDMnDx5lIWW7o7avPhMq1ZFJ7B/7J635g03XcjONA5w=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(346002)(39860400002)(376002)(136003)(451199021)(46966006)(40470700004)(36840700001)(356005)(81166007)(41300700001)(2906002)(8676002)(5660300002)(8936002)(82740400003)(36860700001)(83380400001)(426003)(47076005)(2616005)(336012)(4326008)(40480700001)(6666004)(478600001)(54906003)(70586007)(6916009)(70206006)(316002)(7696005)(16526019)(40460700003)(36756003)(186003)(1076003)(26005)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2023 03:24:02.4170 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 496ecdf8-1184-4940-0c74-08db46ced947
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT105.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4304
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
Cc: zhenguo.yin@amd.com, jingwen.chen2@amd.com, "Lin.Cao" <lincao12@amd.com>,
 Monk.Liu@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Vmbo->shadow is used to back vram bo up when vram lost. So that we should set
shadow as vmbo->shadow to recover vmbo->bo.

Fix: 'commit e18aaea733da ("drm/amdgpu: move shadow_list to amdgpu_bo_vm")'

Signed-off-by: Lin.Cao <lincao12@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index e536886f6d42..a3c8216f554a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4501,7 +4501,13 @@ static int amdgpu_device_recover_vram(struct amdgpu_device *adev)
 	dev_info(adev->dev, "recover vram bo from shadow start\n");
 	mutex_lock(&adev->shadow_list_lock);
 	list_for_each_entry(vmbo, &adev->shadow_list, shadow_list) {
-		shadow = &vmbo->bo;
+
+		/* If vm is compute context or adev is APU, shadow will be NULL */
+		if (vmbo->shadow)
+			shadow = vmbo->shadow;
+		else
+			continue;
+
 		/* No need to recover an evicted BO */
 		if (shadow->tbo.resource->mem_type != TTM_PL_TT ||
 		    shadow->tbo.resource->start == AMDGPU_BO_INVALID_OFFSET ||
-- 
2.25.1

