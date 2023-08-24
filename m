Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47403C7113B
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Aug 2023 21:31:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9ABCB10E153;
	Thu, 24 Aug 2023 21:31:53 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on20629.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8d::629])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A342510E153
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Aug 2023 21:31:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U+Kk27cf5IpPL3Adr5lzYgTXR6I59SDT6l0ICGrN/qZVyZuNCOILrUNfVYfvXEHu095Ye8s7bIslgTzIBaIqEOlCov669wCLxPvg4PWJnB1YQLo2jDGI8q08mc0IES4Y+ahYstM03iBZByVsmzYEqWWEj5HGK+rQfaKnCtdHk098hUHkEGvV92ruGXiVCTi5dymBNw1RmRjvOwpka5dHMVdxxOnIHjOm8LF3XAeqVb+wnUyphIW9RFIjTx5VBehlY9GUfae+XLjfuYRBas6gguCZdF7UIgUc6sVUgOkdTx4KUcAu7J3objfXWVKYWgWnn7EHIzIvF9o+k+unuLWEaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9ZuVGKfYHIZsHF42WG7ZeCUvs2nw4vCu3REbUpk39q8=;
 b=UTiznzL4brRe32sGpuLJahIacHn+5m/ZnaOW3hHoNlyI/UJIpRA0WZi+jV2p8DS+2x8ytklmKoMV9OYkWqvwAzdnWgwqg+g0rgMgZH7de2gvWxGQXyHNCip0PnxiB3mlMYRkZYotPmGoOsV6cM4xVhgAd6fDVB1M4Ki4lvwhfewAtT5OHPMnytsLBsKUkOvVgyHQBUUbv+178EP6Y0yH2UD4lcvmaE0ADzXyWNxbiZWbTxfYx48iLzjHKumP45c3nELQA2A6hk+oweC65rpvI8dlCWO3iJjBhLVmv1IF3XfBZZx5OHqMWa+NTIzBbit9xgQNkMiRWJGZnLW2PpW1Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ZuVGKfYHIZsHF42WG7ZeCUvs2nw4vCu3REbUpk39q8=;
 b=Z7Ce38MuQVjzKeHTStHHLiOi5vfNE6lbtx5Hs6a3DJRpZFKWJyW9JpWZBmLHwCc+L9GJZp3cQVe3OqvVPN5AgIjNuU9JdowpkZ8pZjbPxMccPO6CgnJuvn/A34Z4hej92jOFXHj+h97KLlU0OzFMz/wPYde5rb8vrSmFllkrHUQ=
Received: from SJ0P220CA0002.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::10)
 by DM6PR12MB4266.namprd12.prod.outlook.com (2603:10b6:5:21a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Thu, 24 Aug
 2023 21:31:45 +0000
Received: from MWH0EPF000989EA.namprd02.prod.outlook.com
 (2603:10b6:a03:41b:cafe::3b) by SJ0P220CA0002.outlook.office365.com
 (2603:10b6:a03:41b::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27 via Frontend
 Transport; Thu, 24 Aug 2023 21:31:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989EA.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Thu, 24 Aug 2023 21:31:45 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 24 Aug
 2023 16:31:43 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 03/21] drm/amdgpu: add VPE RING TYPE definition
Date: Thu, 24 Aug 2023 17:31:09 -0400
Message-ID: <20230824213127.2725850-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230824213127.2725850-1-alexander.deucher@amd.com>
References: <20230824213127.2725850-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EA:EE_|DM6PR12MB4266:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e6585af-9e9d-4218-ef98-08dba4e98418
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: riDXUmEF+ony0EiTBU/7QjcX+6x43rn9K1icONVq9mzrio/98HKWXvvKpWCr4OSwUYShfv3oin3/lFF6TaLUF8sJd6UD/+ymA71ArznKtpLVQGmtcea1/yVE2p0LfSFpOgkheA2COnEkiU6jD5gnz1c75uAbI4a4CKeiYp1DknAHkqEH1ZZR6l3rNzUvH/9Bss/GddXVUBG2YUzrOO0C6I6NWu9zfJFMBrg4z1rYTdDKj62dbSpcv2h1MtcCquID2bbaPrGA6mla79jepXJirf6PyfBg3G8AXfywQlEfWzmCVb1i1rS74Oq2JcyncISiw6NLfSKbnzxaFxujw+j6/7+beQ8CRYh7M93i7CuwAIIaBCX5QlL3Gdnmp4d3EpqChPiwXAqlhvS7FK6YPdyvbmfEm7AD4mtZxyHN77FmWol4Edpn78YYkWaptXfuuRv1Woyhr5KX0XECa2iJlEMpQ6m+vAfMJlC2IJNO5mMEUabvQSWftz91Y/5CU41tmL24xw/gE0m188cFAQmo/DRDUXTVMQZqx94lcuf/AOGT61vmsvEvM3atipJmr/F77ytveO68mtbmyeVVgmKM/a7btmx5PWF6zP/qHxPG48j9dycKyH8ioPvblFGukcEGaWM9wwGCQv09TpO1tJ/sKAmjMGseh2xlJqv0PylE87mkbi/Pp7zRf9W7/hAPXV35uzeODRIlk3dJkBmKooCuUDakAEb+pbWopJkSNXkTiXhEEUFlOnuUpj4zmOcAKNyYiBhq9ZJhjG7XgPrcJTAT5OxWRg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(136003)(396003)(346002)(376002)(82310400011)(1800799009)(186009)(451199024)(40470700004)(46966006)(36840700001)(47076005)(5660300002)(36756003)(40460700003)(36860700001)(2906002)(356005)(82740400003)(81166007)(86362001)(40480700001)(41300700001)(54906003)(70586007)(70206006)(7696005)(6916009)(316002)(2616005)(4326008)(8676002)(8936002)(478600001)(6666004)(26005)(16526019)(1076003)(336012)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 21:31:45.2056 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e6585af-9e9d-4218-ef98-08dba4e98418
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989EA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4266
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Huang Rui <ray.huang@amd.com>

Add RING TYPE for Video Processing Engine.

Signed-off-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index 5823dfae27da..09a7e93744fe 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -44,6 +44,7 @@ struct amdgpu_vm;
 #define AMDGPU_MAX_COMPUTE_RINGS	8
 #define AMDGPU_MAX_VCE_RINGS		3
 #define AMDGPU_MAX_UVD_ENC_RINGS	2
+#define AMDGPU_MAX_VPE_RINGS		2
 
 enum amdgpu_ring_priority_level {
 	AMDGPU_RING_PRIO_0,
@@ -77,6 +78,7 @@ enum amdgpu_ring_type {
 	AMDGPU_RING_TYPE_VCN_DEC	= AMDGPU_HW_IP_VCN_DEC,
 	AMDGPU_RING_TYPE_VCN_ENC	= AMDGPU_HW_IP_VCN_ENC,
 	AMDGPU_RING_TYPE_VCN_JPEG	= AMDGPU_HW_IP_VCN_JPEG,
+	AMDGPU_RING_TYPE_VPE		= AMDGPU_HW_IP_VPE,
 	AMDGPU_RING_TYPE_KIQ,
 	AMDGPU_RING_TYPE_MES
 };
-- 
2.41.0

