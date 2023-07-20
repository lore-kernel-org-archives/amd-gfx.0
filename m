Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7934EB64DA
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Jul 2023 05:41:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7ECB210E552;
	Thu, 20 Jul 2023 05:41:58 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C999C10E552
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Jul 2023 05:41:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VPPPNDmoH4TK4XT2KpjlxAnxS1RatYEzCn/ytKU9rzoLVmEee6j3Vfr8yeN8nRYyrx/FIz3EYdURbV/NAImuaaEb5VomttawLaS1ATZWMIPVQ0hMl3IBDvsjR+u8trRl3X/TWR9iCH0QAvXqyjeuS39vLWVRxsz4wBVi95uhy7Ah9YxObSKFKm5y/zEw3TJZTq5ltUglUvDGAgaydM2RITX4DytW06+g6PMzw2T8ATc/UE7VvqRFEYLR8XwrYsLlrh2PykaiJbB1GmvvGAgk5a447pwaE1V963yKOp1R5R8nJbowt9v4C+Ua/uVp0OnvssIbiQPo+mKkfyJkVTIxHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cKBdpH5TKr2cPPmJtxK2UYaswYnnbH9JuxjEXYby0xA=;
 b=jL2CEmZGNcznJSLB3LoUtQyJk13QxZ1FKGn1yI+DsZJg1/O//y+/UbWeg5EaiA9gXM5uQz0JZc+oBid7BE1LT66QD0HcPaVQjG0lhX1zkV6S1EaxBFhgk9HzHto31lp8ptN5WTfr7Y6CjQpZBHKkyDXIEvzPhXoJAFeZc51CUtvzyxbEGn5jrxC8Pw2/2aF4IEtOkuzuT2T3/uiAj4WGxdZ126z4II59X4g1RPb0yRDXxsiSQdWqxdbLJQ0OKBmJLdA2TqNu+fyCUV2ymYnKpY1vM8z297MTLgzEC63OqNdEA6q1DL87ilwyVMZoYqgi0LMUTOqpiBgNaOqmUTqX4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cKBdpH5TKr2cPPmJtxK2UYaswYnnbH9JuxjEXYby0xA=;
 b=Pef4CcSLs+1OVJCCwkp0+HGiq4xG1Kc5GwlLyfQ8Ws98JaoDcJSXO0IOj6g4p/ft2qYotBncHl/BnvMg4Hf28s6HE+WyeIobSrklor51AQf2IDfKWZL8jf3gVskppGJFphDs2R19B/62kfVDUVwv+XoDD11YJf9Nv6ZfjrfqI+k=
Received: from MW4PR03CA0140.namprd03.prod.outlook.com (2603:10b6:303:8c::25)
 by PH8PR12MB7325.namprd12.prod.outlook.com (2603:10b6:510:217::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Thu, 20 Jul
 2023 05:41:54 +0000
Received: from CO1NAM11FT090.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8c:cafe::1) by MW4PR03CA0140.outlook.office365.com
 (2603:10b6:303:8c::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33 via Frontend
 Transport; Thu, 20 Jul 2023 05:41:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT090.mail.protection.outlook.com (10.13.175.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.34 via Frontend Transport; Thu, 20 Jul 2023 05:41:54 +0000
Received: from thomas-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 20 Jul
 2023 00:41:51 -0500
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdgpu: fix printing empty string array
Date: Thu, 20 Jul 2023 13:41:33 +0800
Message-ID: <20230720054134.1187589-1-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT090:EE_|PH8PR12MB7325:EE_
X-MS-Office365-Filtering-Correlation-Id: 781fad69-f022-4758-049f-08db88e40665
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vRmRFnAcyIi44FkHGlVTpc4tJSS5A8WJ1J/OSsuyvWb9lWkiyoJWEbQm9NMFjFCrQH198qX5ayrzi/zthuZeA+YDSAaUgFJq8Dx0mw0+5Xh0hY8GusJhdytV3ZOiVwWS52DZZSoqtjPotvh31hpPmvLufGA6BmjvPHcZpIFrtSdKI8gm/8uuIwk3zhZN4ptETUJzXxooD0VL7VLjVzN4DBCquVlDtCrSbXLGeD6iFYfFQr74PcT7h4+1SgfC8iAUDiK7MeyGNli1N4f0hrpmwxo9+wfyIWNbqhbwbLMuUcVTZ4XvRBtU5X3eVarXUpX3OCw1ONTy9LJxGBKSEXV32u7E9Jskwz8xYRIq1SMck2MhY0eszcB+VoJEGmMXyT3KP2TG2aBvPrbFzDezRsw++IuSargLrLeqPp0GjdcVh2gOmMVt0jLFWv3sxhujAg3/sCZSWX8BWQTI+WxUSBhCstaVT//j5Tcna0ZZDy3myVSjJ+llEKSToQlF4N+BcKjPVDET2YAnWaog2xKyb824/VxXDyG1U1p4Xe5H31Lpi9Ap10HdFwgYiC1KstLduF5ZcDnbct9y3Y6mka6r0Kkt01AdCfQ3GB/3Xx/Xyn5MWN5VteCSSH2f0INFn5nB9Egm55dOcoOe6ekeN94FUB1MbUVm18dRAg0KYnapkUAoi4qRK0/SLODBD542RF85DCuy29MBPZ9uhJxeWk76XMYnciqg/LIUHTTFkrg4/HEcI27KQMml3mllapxnobjNgAQEYMS31hyvBSaX6ME0GuOJpA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(346002)(396003)(136003)(376002)(82310400008)(451199021)(40470700004)(46966006)(36840700001)(6916009)(2906002)(4326008)(8936002)(41300700001)(316002)(5660300002)(47076005)(83380400001)(426003)(36756003)(2616005)(70586007)(8676002)(70206006)(186003)(54906003)(16526019)(336012)(36860700001)(1076003)(478600001)(81166007)(82740400003)(86362001)(26005)(356005)(40460700003)(40480700001)(6666004)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2023 05:41:54.2699 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 781fad69-f022-4758-049f-08db88e40665
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT090.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7325
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
Cc: Tao.Zhou1@amd.com, YiPeng Chai <YiPeng.Chai@amd.com>, Stanley.Yang@amd.com,
 yipechai@amd.com, Candice.Li@amd.com, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fix printing empty string array.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index c571f0d95994..d04fc0f19a29 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -128,8 +128,9 @@ static int gmc_v11_0_process_interrupt(struct amdgpu_device *adev,
 			"for process %s pid %d thread %s pid %d)\n",
 			entry->vmid_src ? "mmhub" : "gfxhub",
 			entry->src_id, entry->ring_id, entry->vmid,
-			entry->pasid, task_info.process_name, task_info.tgid,
-			task_info.task_name, task_info.pid);
+			entry->pasid,
+			task_info.process_name[0] ? task_info.process_name : "NULL", task_info.tgid,
+			task_info.task_name[0] ? task_info.task_name : "NULL", task_info.pid);
 		dev_err(adev->dev, "  in page starting at address 0x%016llx from client %d\n",
 			addr, entry->client_id);
 		if (!amdgpu_sriov_vf(adev))
-- 
2.34.1

