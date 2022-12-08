Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D625BC4332F
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Dec 2022 07:52:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0355410E46C;
	Thu,  8 Dec 2022 07:52:05 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2086.outbound.protection.outlook.com [40.107.93.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 923B110E468
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Dec 2022 07:52:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O6cbiEWXbElXIanyjMiSLvIZCxhdPdaApwU8VliCMCiYa/cdx0rMpxwFksutH2lXNB2nVHfFVj4dw2gwC3Oi051c6+h/weRtieBPqscVbAW9vZhS2Uz0VffKlMUjgcdkvGMYD7fFzRIp8Vl1umqqoNxG8l+QulkMtDzdtzxfg3lVvK4nL63nsQjWDc3RuwLwM0JOdHZ4+V1Zk8Fq/+ZQDbanYKj6i2N5DqMDgFMLKtd2RuNQodqcz2n7hwrAt0b/W82INtr+JqwvdKgJxUCh40xqpUEJgdFt6xK40OsCmIJYivxnBxnlsBRuXTuskRe7RzB+uaScwU71B9rQ95UxYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N8LiNaAvhNjNZOcISpnz1EXPKlnQskXNWUgZQArj/2s=;
 b=dG3DyRbu3VLL7DbR7TqXmSmT2p4yqvrfISvgQ5vVb2IGLu7KGlrH5JP2JQheuIgqhKK+T4C0K7s+7JHIAH/A3VlsGyy6G44pA8uBVyzoQmov5LT9aD8QnTDRHPC5URWqxKdG6dZCAcEe8NTlUey5YLF+rQI2K+zYXTvzuxjIZTbjbAYz+umJgPtlvmgDjroXAAFjsMw2d/qWaAeVs/BXRAJI9XpZDN+1hJJOVqQpc6TJrZbAJgjEpKgR/6amEOj4AX38+6FEck3Pt1/gI2w6TPfPH1slBUJSKUW26JJC3Eofxbv2YkaEgYFHjYsmAC0pS1NCkEIA6ngFW2zFYdxXAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N8LiNaAvhNjNZOcISpnz1EXPKlnQskXNWUgZQArj/2s=;
 b=OCaIUV3KckRIpCOw1qF9CHc7FzZ6DgaHWuYa4ifa5P872gz6siEYo04gDPlrBiaHsUlv6Fe3Mtv8wFrFHU7gLCWE7oJaqfqeqHs05jUTk2l3LV64sOzC8Yp9kF7OJJjdctvxzxcTynVQElQMmYCUz1VOnPsjPZ9ipWZNRXGJAcA=
Received: from MW4PR04CA0379.namprd04.prod.outlook.com (2603:10b6:303:81::24)
 by BL1PR12MB5731.namprd12.prod.outlook.com (2603:10b6:208:386::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Thu, 8 Dec
 2022 07:51:55 +0000
Received: from CO1NAM11FT061.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:81:cafe::f5) by MW4PR04CA0379.outlook.office365.com
 (2603:10b6:303:81::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14 via Frontend
 Transport; Thu, 8 Dec 2022 07:51:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT061.mail.protection.outlook.com (10.13.175.200) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5901.15 via Frontend Transport; Thu, 8 Dec 2022 07:51:53 +0000
Received: from taozhou1u2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 8 Dec
 2022 01:51:37 -0600
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <hawking.zhang@amd.com>,
 <stanley.yang@amd.com>, <Gavin.Wan@amd.com>, <Vignesh.Chander@amd.com>,
 <david.yu@amd.com>
Subject: [PATCH 4/7] drm/amdgpu: add VCN poison consumption handler for SRIOV
Date: Thu, 8 Dec 2022 15:51:19 +0800
Message-ID: <20221208075122.28702-4-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221208075122.28702-1-tao.zhou1@amd.com>
References: <20221208075122.28702-1-tao.zhou1@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT061:EE_|BL1PR12MB5731:EE_
X-MS-Office365-Filtering-Correlation-Id: 6477979b-3f5a-452a-58d3-08dad8f1129a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YyKX1bTaQrfQuqgVSya8iHLLqDA45ruu3u1e4Jle6QJVGgfKpxR0rcHjxO9LRszbfK5FslIq2feTrrxoiPLp3R6P6ioctzVNCJ7UK/wFdEvdipHnMBhCAaT0MKVVCFyciFUGrLDqoFTBtiJVx5WHTBf8GS2R10mctYd+Gyl7Z57cG9VdZby5NxVfOpdjx3septg1+QAxQKVsUEKtJeA7DtB0Y70dB96qP/g26orG5zKQHKny12xtNDzjbtSvTZ5YBbDm7sRoMSbniTnBeRdg3sDbtgSQnX42240cnvJsk9IZBAqQUJ4JN9PMkLvfDgOkGo3c7fYcoXc0SWHOSdNcW9WC9+y2JLQbonDh/oHy6Tjgofcu06b99U+37fU8o2waCgWggyTYYbqPJHHYyDL2+h0F4pWL6TJ4S4gnapLlr7Uwgwt2HVAQqsM0kD+1znEE+9QNfsSMQHrW1B5J5oXPn7lHZ5cSrLW7lMN8+hx9E4V6lb/Fk0+ZSkPPU1NMhn/mine6M/2n97fczYJCkWMImWfUfLhSD0UpuopWxVBb/H/Ub3i+7U0K8BgqDHGaFjRnS/qCbS9Q7jkCuwh/nnwLIlBtO6QWsy0tkfszRPLVO68kHU13yIIZ5m5rEAUsWM5MY2zoMqLPoOd5RYC9Lg6lm5hwwx4nM6/uX08t8eCUlj2WFvJ89w5lpwEWbqHC1kc2k377Og2yPTVjJnDjSgKtAT2uylBrzPh/x5gnpQe3t6c=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(376002)(136003)(39860400002)(396003)(451199015)(36840700001)(46966006)(40470700004)(36756003)(81166007)(356005)(41300700001)(8936002)(4326008)(40460700003)(2906002)(5660300002)(4744005)(83380400001)(36860700001)(86362001)(82740400003)(70206006)(70586007)(316002)(110136005)(2616005)(6636002)(478600001)(82310400005)(7696005)(1076003)(6666004)(8676002)(426003)(336012)(16526019)(40480700001)(26005)(186003)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2022 07:51:53.5763 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6477979b-3f5a-452a-58d3-08dad8f1129a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT061.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5731
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
Cc: Tao Zhou <tao.zhou1@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Inform host and let host handle consumption interrupt.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 72fa14ff862f..a23e26b272b4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -1246,8 +1246,16 @@ int amdgpu_vcn_process_poison_irq(struct amdgpu_device *adev,
 	if (!ras_if)
 		return 0;
 
-	ih_data.head = *ras_if;
-	amdgpu_ras_interrupt_dispatch(adev, &ih_data);
+	if (!amdgpu_sriov_vf(adev)) {
+		ih_data.head = *ras_if;
+		amdgpu_ras_interrupt_dispatch(adev, &ih_data);
+	} else {
+		if (adev->virt.ops && adev->virt.ops->ras_poison_handler)
+			adev->virt.ops->ras_poison_handler(adev);
+		else
+			dev_warn(adev->dev,
+				"No ras_poison_handler interface in SRIOV for VCN!\n");
+	}
 
 	return 0;
 }
-- 
2.35.1

