Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EEEBC001B0
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Aug 2023 05:18:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E7EFB10E64F;
	Fri, 11 Aug 2023 05:18:57 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20602.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::602])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C05910E64D
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Aug 2023 05:18:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WGcccuOPFkM0UQMThK7rM7M2M0EmzH8OQwonYGB8Zmnzpk5QYNg2hX+B5YdeZmjBpxuVc4S4+4KYjTuCFQYqDNeWt1vxP5PREpImthd9thKJQQG/U2jyLjQZiWuewa4HGDaoJNBzBvgrrZqVBeP5Uey19nfJsOVFD6Bunaagh7d8RVBElDvPBh/WwLFO/z9KxlDjYSYyr1U9UJUQIHqp3rJnHCaHqVyqmVRp345LjpEqaG+wJnJCcMg8X+jb13Hu4wWQfGes9viscS29m8gvgN05LruQTuqKLaeP/3hacuMZ7ynuQDH0XZL3+LZkB+gZ+b8LqgEgeEbtdvKmM5VgTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/uo+JEsvQ3AmKEQfbKsrItkBTX3oF0jJgjD6L3oVymo=;
 b=PP2tyMc9z7reDFNX0daypuQVFTTBk4Qtm/lUl2e360xZfVz26M14HcNQgq6mjUjp8bE+/aXb/OPnlpc1owPJtiTG1OTybz7PghK6TdEHw47H8ZXZw5cEIJLKokvRUnE75inu/AFefkY0XSWGlz8uGnuGk154xbauR5I3JZCVuvLWs1xLzV4WmZsp2mr3cV22DOyDiKLiNzadooc3A+lzPFeoTOHtITP2tCwly/wgp63bmWGgTKDze5JlDMFuWmVjRT9tEOSHbOYJ794Sz/JGEYSvpqsJKXBR+H955/oI26CpSOIEfZCAFV5DMLYph2xTqX0PMj2oIiZm4LhATtooJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/uo+JEsvQ3AmKEQfbKsrItkBTX3oF0jJgjD6L3oVymo=;
 b=T/qqUukZSQbQqvt4/4tx9hsUP9RzdtMKh8vZZAFNyMVxse9ulkZY2ORiivG1M124Dcn2hq3fTeC08+oo0Epwtbms2qEu0vc9hfAZVnueiiEOQt7Is8FxJGvcofTaoYytBWOoOjMCCtlzEXeaDC5h+JhKJVBZ7HKdi4d9Q5yzTiw=
Received: from MW4P223CA0008.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::13)
 by BY5PR12MB4115.namprd12.prod.outlook.com (2603:10b6:a03:20f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.19; Fri, 11 Aug
 2023 05:18:51 +0000
Received: from CO1PEPF000042AA.namprd03.prod.outlook.com
 (2603:10b6:303:80:cafe::28) by MW4P223CA0008.outlook.office365.com
 (2603:10b6:303:80::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30 via Frontend
 Transport; Fri, 11 Aug 2023 05:18:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AA.mail.protection.outlook.com (10.167.243.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.20 via Frontend Transport; Fri, 11 Aug 2023 05:18:50 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 11 Aug
 2023 00:18:48 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 4/4] drm/amdgpu: Add SMU v13.0.6 default reset methods
Date: Fri, 11 Aug 2023 10:47:56 +0530
Message-ID: <20230811051756.653422-5-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230811051756.653422-1-lijo.lazar@amd.com>
References: <20230811051756.653422-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AA:EE_|BY5PR12MB4115:EE_
X-MS-Office365-Filtering-Correlation-Id: f4663588-4e55-451c-61b1-08db9a2a72da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5REwd47+zeftXLsRmBu4sWRVvkVQ8Gkmshkbq/mw/Rv5M7Xd0/I+zLBrC379zCOtvaiaxYm1FJW6efaza8u5W7xA/oiRLVXYHfWCQOdAPOWmu4q1YO2mLmGFGziF6i+IsPUj7eryzUC0yE+mfMPPHFGnB2yuHHOmZ4my1qmlXWnNNuiHaBQXP11Hv3cR2UFFjV3I9dMrR/mn4WDm/9eZlKGaVh2oVc6VlXFxUHeqhzYOxdAU44KFDEhgJxtplzOvhvKKqRwUWKn6eVdJkr45I8o7Bs6aapeBLlth+OlzO/hgqGX8ES2pnwoAjJ0qa+OezPG/VtFrdxzkyJyVsy/SS/tbqWiFaElhwngPQdWbJIBmYirL750VTFhgUrM+X6a4HYvW1xfY1ZnMzyQazcISFdJlLZka3J5y0iEWCfKv0/o68gUmiPzTjk3fR17FAQuj/lSO6oTdAi3+V6LwnFGKfUF40gkoDtIQeU+sduFgP6KLplbAPqp97Jx5+hu/i71ZLpac44gD/aByn8Q27t+1prBDju4yDD7Oj5Dfi5WEAO8Z1Z1zyCxD5cQNKQ8dUuUVFv0cGDUvT2wHs+BgIpIMUaf4OvD6o9RQNktwSWO/JRDpneVNsjsridysUF/RDx6dbl6RmWoaKhfxVQRcXgnH6uLsaFWBASpokOwjbgpQ8y/N7869zPQ7rYzlkuBrVm2HPDr0Bxp2WwSowVVp6m+sHa5SIYnlZyFJJlI0wsGYHQOURzt0MR2iHzg+mSVcWFW+OYBUEI7d/u0LHkxKoAUReg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(346002)(396003)(39860400002)(376002)(451199021)(82310400008)(1800799006)(186006)(46966006)(36840700001)(40470700004)(2906002)(44832011)(8676002)(8936002)(5660300002)(41300700001)(316002)(4326008)(6916009)(70586007)(70206006)(40460700003)(478600001)(36756003)(7696005)(6666004)(83380400001)(47076005)(336012)(26005)(2616005)(16526019)(426003)(1076003)(36860700001)(54906003)(81166007)(82740400003)(356005)(40480700001)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 05:18:50.7869 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f4663588-4e55-451c-61b1-08db9a2a72da
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AA.namprd03.prod.outlook.com
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
Cc: Alexander.Deucher@amd.com, Le.Ma@amd.com, Asad Kamal <asad.kamal@amd.com>,
 Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

For APUs with SMU v13.0.6, mode-2 reset is kept as default and for
others mode-1 is the default reset method.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Asad Kamal <asad.kamal@amd.com>
Tested-by: Asad Kamal <asad.kamal@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc15.c                   | 4 +++-
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 3 +--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index c45721ca916e..f5be40d7ba36 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -559,8 +559,10 @@ soc15_asic_reset_method(struct amdgpu_device *adev)
 		 */
 		if (amdgpu_gpu_recovery == 4 || amdgpu_gpu_recovery == 5)
 			return AMD_RESET_METHOD_MODE2;
+		else if (!(adev->flags & AMD_IS_APU))
+			return AMD_RESET_METHOD_MODE1;
 		else
-			return AMD_RESET_METHOD_NONE;
+			return AMD_RESET_METHOD_MODE2;
 	default:
 		break;
 	}
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 362acbb242bb..552a739533ea 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -2096,8 +2096,7 @@ static int smu_v13_0_6_mode1_reset(struct smu_context *smu)
 
 static bool smu_v13_0_6_is_mode1_reset_supported(struct smu_context *smu)
 {
-	/* TODO: Enable this when FW support is added */
-	return false;
+	return true;
 }
 
 static bool smu_v13_0_6_is_mode2_reset_supported(struct smu_context *smu)
-- 
2.25.1

