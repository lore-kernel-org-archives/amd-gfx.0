Return-Path: <SRS0=BT7C=ID=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51D3CC433E0
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Mar 2021 06:12:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3DBE65000
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Mar 2021 06:12:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3DBE65000
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A89876EAD5;
	Fri,  5 Mar 2021 06:12:23 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770053.outbound.protection.outlook.com [40.107.77.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F1086EAD5
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Mar 2021 06:12:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G7T5wk3O11i7s34FseHqNL4wE3ZavpPU5XNuiYKw77ur+30bgyKN6vwN9/tilcpL1x2leTATJ7ouK1KbSWNcQpLPuhESTRvkDZsUOV2GEQU4+Hns8dTcQrVDFAbcKui+EnJ2aAv6HhaEwfn71AkDGgSkZFyJlNAhPJGMnTVwOfEMdxJoCuojEZn4ZrMkYhXLZBLE4EAhf5LLCcqMoHJPpxfxTqf19VXOgeJH/tCejnBDAhi2huDrUp+GdEhKefVPqug6AGSVTgLCuo5u7PlTCSQvfIXBXfaXGDkWElstNIie1CpfpcCyqc9+Rn7O9C0YN4W6P7/hJG9j9RhrFK8fMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oFITn3+S1Q9PUXuyBrr/W/H3dTfCaqzPddNadEATCHQ=;
 b=OVLPxrnbdLEm5CNabfLdQvjg0sKHtPsn7YeSZjN/JPbrhpW3unKMXL2M6tPFl2XmMASQBVGESbrVmdetq6pY08iNalVmfy+7wxt+R6Q8Hz/8vLmQZ1ytKZqktqLA/mypnEOe3h+SsUS6Pnl0gykwrtXZ0ZLGN+uhSoaPOt+eKkW3Sg8rjbk1lG1aFbd1USHyBCVa6v9K5CeUZjD1wmvAkwkJ0RQ4GvsFYmk0b+r9/SieqhKTJPBNOBfOHWPyn3j1eXgCAQWoj7/LErGFz1MDw/f3ZzVZir186iz0JI+EBfX60CSaNlbFai2pKUglCT2nfB5dnzPdKYAfuwGOctr+0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oFITn3+S1Q9PUXuyBrr/W/H3dTfCaqzPddNadEATCHQ=;
 b=LrnDGTzBE4ydgplDsi5obQTjHBmUIFYLKDgL6w/U5WpCkNIqEnlAMgDPBbihPb70dSH6rCQ51+GgGLw4eNMpq7/a8R0Wpck8Ahp21JTOAjgzZQB61WAEcnG4KSZAfud6AAkstFyk1ytsbgxW1pllmpq5kICPGhgHRRQsqos6FJM=
Received: from MW4PR04CA0105.namprd04.prod.outlook.com (2603:10b6:303:83::20)
 by BY5PR12MB4115.namprd12.prod.outlook.com (2603:10b6:a03:20f::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Fri, 5 Mar
 2021 06:12:18 +0000
Received: from CO1NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:83:cafe::23) by MW4PR04CA0105.outlook.office365.com
 (2603:10b6:303:83::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend
 Transport; Fri, 5 Mar 2021 06:12:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB01.amd.com;
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT020.mail.protection.outlook.com (10.13.174.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3912.17 via Frontend Transport; Fri, 5 Mar 2021 06:12:16 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Fri, 5 Mar 2021
 00:12:13 -0600
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 5 Mar 2021
 00:12:13 -0600
Received: from wayne-build.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.2106.2 via Frontend
 Transport; Fri, 5 Mar 2021 00:12:12 -0600
From: Jingwen Chen <Jingwen.Chen2@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/amdgpu: add fini virt data exchange to ip_suspend
Date: Fri, 5 Mar 2021 14:11:58 +0800
Message-ID: <20210305061157.312421-1-Jingwen.Chen2@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 47f64be7-e0fc-4718-5404-08d8df9da06f
X-MS-TrafficTypeDiagnostic: BY5PR12MB4115:
X-Microsoft-Antispam-PRVS: <BY5PR12MB41157968C107B85EE9D2447EB7969@BY5PR12MB4115.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jiVprAsCV8kX/KimocxPkOKMT/HOe6qidRDm7JOxIWVutlWQIQuRD9VJ6eVWfbcpOApnhoHW9zEHO7FMKAdRXYYpZw/ce411xRvQTCG44HpJQ/tYsWXG16nP1IubVZ3ij0Ii/p5DryudrqCQ6iflZGCgmGf7Wk5p6tD2rBmvjqpVjkilNqUwiVNI91OnDg6GqVUIq+k2/Skw+DCx9BZ/dyeFEZ9SayPiWXXeS/PhnCYh9O3HTSHNoTVEcU1vXSxqVjVWMw4CumPBCr8WaTUdL70ZeSlxsLrSPk3BMZlIE5AFgF55+607zQcSXKQtxxlEcErJZr3ob/AAYOlhWrkEnwq1CcNGp2VPtVY33S0rpMsZYXpJOqoPwakjVZe8JoGAbkQ8s6vRW/yGMhHrvXRwlCbWHKGMI6pVW76V3y7pGndopqY32nOXSs2CL9JDBJzUTmnLzTm0KNh7A380G7Hf0xNLLNKlpjbp+TUoCzRV/m4v3R7MlsP/hqWnAD3pxquZpzYROmXZ+jjpF+zYpkAuQCRVQSWShbSp6EvNFKUFcEVH5KrEhgknZE6I22PzTZfORDpHISl2tb2S60eDgYM7e59iYVq3PrgKgvM4YQoa7qngl5/QBaKvp857nJHWy1MbJ/eq3U5Rti5AS0fikNJmQzO0YhwP+9A/OSf1ZVV+hfdo+69pFl5s03VeeZwoIQdB
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(346002)(136003)(376002)(46966006)(36840700001)(4326008)(478600001)(316002)(6916009)(83380400001)(47076005)(86362001)(5660300002)(54906003)(426003)(4744005)(2616005)(336012)(7696005)(81166007)(186003)(70586007)(8676002)(70206006)(82740400003)(6666004)(26005)(2906002)(36860700001)(8936002)(82310400003)(36756003)(1076003)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2021 06:12:16.5776 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 47f64be7-e0fc-4718-5404-08d8df9da06f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4115
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
Cc: Jingwen Chen <Jingwen.Chen2@amd.com>, horace.chen@amd.com,
 jack.zhang1@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
when try to shutdown guest vm in sriov mode, virt data
exchange is not fini. After vram lost, trying to write
vram could hang cpu.

[How]
add fini virt data exchange in ip_suspend

Signed-off-by: Jingwen Chen <Jingwen.Chen2@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index a11760ec3924..bec725b50c1b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2774,8 +2774,10 @@ int amdgpu_device_ip_suspend(struct amdgpu_device *adev)
 {
 	int r;
 
-	if (amdgpu_sriov_vf(adev))
+	if (amdgpu_sriov_vf(adev)) {
+		amdgpu_virt_fini_data_exchange(adev);
 		amdgpu_virt_request_full_gpu(adev, false);
+	}
 
 	r = amdgpu_device_ip_suspend_phase1(adev);
 	if (r)
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
