Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E49EC433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Mar 2022 10:52:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C631210E17D;
	Mon, 28 Mar 2022 10:52:00 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2075.outbound.protection.outlook.com [40.107.220.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF7D810E17D
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Mar 2022 10:51:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f5TJJSiw0BCMX1sFX0zXKnaD6o2vuSXtJeodQDAe0mCqIoU3cHfMDoR7pyNAzeQyCVSo/JtYglPvG2nGJEol8L656GVO+C6QgzjBaE4ICZwGEn7lXM5FNl1ELrWmzqvAGxg2bS3Kcb0hcHt2BHwAhYqtx9TAWmMWaRcJoQjWr4Xv0LR3vsFfUXvDUEgmBcXJPvfg7ZX3Um4F3L6QD46y6LLtKdopu4QsgZG3JJuQisGWmArmyNWXAEKfaEd1YdFi7wImtMUspQuaJEE+hAEpj4zLBR21W4VT8/NI/JvpggjPKRdztrHW7A6eBYzHbNfGrO16wojEfnr3r4WXAFgfOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/B7vtKO+YYqRamrlFqBxmCNTygkuAzyqL37yxin9xAQ=;
 b=IVepxpQGt/FYiymUua3laLJWwRejtu8yasN8E6UulF/uqOjlwkUAK9UYxqpXeELApyC7uF4k4xWVQKD3nuqgiZxiu+BQxy6OpnEiM+xGo5NcfjRwKZpGD8bNI3Du2mbc0XDbOBpVuPLASC+qt0bptglseuy69kBJxdHg+eHH/7+pkMT43DW7Z37K3GGW7mGVCnIHv9CqGZbs4vIK+tJHKVSdcGFm2wJu3NIpJlns8x0enFKYsBpCU0d2OcpEvxPlyZP4/gfclE5uP2WevBNSh0b9QlVWwNJamBWLX8rVNU/Llpyq6CzG3jSSnQmMwJf56twizqmBo9pj+4RGIUi4+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/B7vtKO+YYqRamrlFqBxmCNTygkuAzyqL37yxin9xAQ=;
 b=05pCG974+OjM/H5Vrv7tnuFip9hRn8JRvCB1t1cHCjfPFmDV3/1eOF3sLzG907u7y1dxaeV8eYwUu5wEnMLkBUUghMYlwRwjdLISWT1hMIcYMJOQvbNzMZnrWND4Xg1s+V4r651rdS5r2TDjjFMbKC9vn/N7pm1QZDAhuD3Uoz8=
Received: from DM5PR04CA0037.namprd04.prod.outlook.com (2603:10b6:3:12b::23)
 by PH7PR12MB5832.namprd12.prod.outlook.com (2603:10b6:510:1d7::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17; Mon, 28 Mar
 2022 10:51:57 +0000
Received: from DM6NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:12b:cafe::47) by DM5PR04CA0037.outlook.office365.com
 (2603:10b6:3:12b::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.26 via Frontend
 Transport; Mon, 28 Mar 2022 10:51:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT014.mail.protection.outlook.com (10.13.173.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5102.17 via Frontend Transport; Mon, 28 Mar 2022 10:51:55 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 28 Mar
 2022 05:51:55 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 28 Mar
 2022 03:51:55 -0700
Received: from amd-zekovic.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.24 via Frontend
 Transport; Mon, 28 Mar 2022 05:51:54 -0500
From: Marko Zekovic <Marko.Zekovic@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] amdgpu/pm: Enable sysfs node for pp_dpm_vclk for NAVI12
Date: Mon, 28 Mar 2022 12:51:51 +0200
Message-ID: <20220328105151.4634-1-Marko.Zekovic@amd.com>
X-Mailer: git-send-email 2.24.1.windows.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 934bc14d-9fcf-43f3-97ea-08da10a8f9f0
X-MS-TrafficTypeDiagnostic: PH7PR12MB5832:EE_
X-Microsoft-Antispam-PRVS: <PH7PR12MB58324A8286876233C9FA4D48EE1D9@PH7PR12MB5832.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zPlDDP0nD91KLQv9N0JUGhx9ze1LOLzY64lQQ0P81JF0Xvt/eOKuMilLPK/SqNFh5xoajkBrYnVArMGin7moSxbWwakGuInzomwkLUgkpX+zyXHioZ4gJBjDQmJ7OsMRxg4H1PrYsh0by2FHWe56hZDkBrByzxLNYvvv04CH3bPoUsd8iguEDX0+IWtZVGpMlBefZUXKUw4Kr8sJZnu8KB/Ng2wi8aAeOu8WPoI11NtJWUVYwX0lscAbZu/RmUFh8iym7f8wteZCaujmT2S8jVXYQWEpaP0SL8+0WVYPZ7gx0bvGD3BOKqdunEQEbBcvNpO4BgRvV3XTRe919xoyOFjI+c6od86QnpeQgSfsRC3/Xvch25vc6jedAYGrW185T5ObXFK//coy7Knxg0tpsf6S0EnRnopS8IQHeVNSGhcO6CniIrNusJljNx1CCWkuV+aXi6U3ePzqyIN2cNxYwYFqiR/V3EkgbVHQlXHvO2Gpuac7uEai91is3/t3gL81TP7kJlz+guxwycknQvke4e4IU9qJvfIos7dkW3LSJ5rtV84XKSh5mgwT3o2eJwcPyaRKoXtStoiq5dgMAdtXsSsbMGSn5umfR9gRU7GYk0mkerjkJ/AD4d7hFa10zOKIFgU8SOiBt4871cBQF/T+DmnWhJuaVhP2BaIr148qI4Yo2xLQjGU/R+P2qT9f8Ke12dqlk8YBEDKWSvE1kn8laA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(86362001)(316002)(83380400001)(6916009)(336012)(70586007)(26005)(8676002)(47076005)(426003)(186003)(40460700003)(8936002)(5660300002)(1076003)(4744005)(4326008)(2906002)(7696005)(70206006)(2616005)(6666004)(82310400004)(356005)(81166007)(508600001)(36756003)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2022 10:51:55.9253 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 934bc14d-9fcf-43f3-97ea-08da10a8f9f0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5832
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
Cc: Marko Zekovic <Marko.Zekovic@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

SMI clock measure API is failing on NAVI12, because
sysfs node for pp_dpm_vclk is not existing

Signed-off-by: Marko Zekovic <Marko.Zekovic@amd.com>
Change-Id: I240fa055600bfc0d46dfec374339ba61764f9ab2
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 9ce597ded31db..5d0602d2c1a1e 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -2001,7 +2001,8 @@ static int default_attr_update(struct amdgpu_device *adev, struct amdgpu_device_
 			*states = ATTR_STATE_UNSUPPORTED;
 	} else if (DEVICE_ATTR_IS(pp_dpm_vclk)) {
 		if (!(gc_ver == IP_VERSION(10, 3, 1) ||
-		      gc_ver == IP_VERSION(10, 3, 0)))
+		      gc_ver == IP_VERSION(10, 3, 0) ||
+		      gc_ver == IP_VERSION(10, 1, 2)))
 			*states = ATTR_STATE_UNSUPPORTED;
 	} else if (DEVICE_ATTR_IS(pp_dpm_dclk)) {
 		if (!(gc_ver == IP_VERSION(10, 3, 1) ||
-- 
2.24.1.windows.2

