Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AE4EC74A5B
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Mar 2023 03:15:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0AAE610E0DD;
	Thu, 30 Mar 2023 03:15:47 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2089.outbound.protection.outlook.com [40.107.237.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7DBD10E0A5
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 03:15:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HvyPF8KCfiWkbsJ64VGncekfuqYH6JhnUmLJs6yeGdFc43/NxCzqKVhZ2hDYhuJVCm0M518yqeY6UCoGVrmfESaqjHgEEqQDxRMVUgkKGt3crqnHJBJ9bAYsMYQQHze60yBfR/KYbR7KHbQsUU1nBVzifD6JWOc8a+2QM5ilfq2DjquisrHUsdPePVOXwE4zdsGteSZ3d2P80DPJ70QFhja7OQdSSAPBWRXXJboUR9ngEAfMvjDUAYUgyFgsAjDhIVgQOVlM9j3ja5HjD1EZrq1Aw2nNdo9QTjHI3PasXDHzy1PwESlYC/LiZDVZxtYHE2TNH49pO1LyGTiSIsiqDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RBCTlYf3N17qRU4gmI98o5a90Za8GSQKycNHm+evLEI=;
 b=at2oQ7hpWf/11CcU+T7V9D3JAFFPZT38coBoAd3WmiWRdyuuKeYI6JovjKun+pkbpl3GCHJA1/mC5DihiRGcIyD+w/alShY7lSRawtB1Kf6BgTUZO+TdchvSoJ1gbe2L3edaAyFs1W9XjwH0F2hjyaTzMNaWB4TFvNU0Qo++AJtaz43ZtV4+gl1z2tm2KxIAfeSxm7FgypDioXB0Mf1puWgxFLliolrRPGQII+Vk6DdHUd08xOSy7ngiZJ+Rja/v2voMDxcVNTOd0vb5RZeNpBkT/qCZsH3B1UOa5CK4T6nejpo158lKKePREKZmZRmLtHuYKxwzwcT4BEpywb7BiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RBCTlYf3N17qRU4gmI98o5a90Za8GSQKycNHm+evLEI=;
 b=2pH6zJ4HlkVl08JYcUpKctJFIlI6b5sDmCOLrk4qF6eZkpOAAfx5/pO73kRgZnMy79o7mwtrkCixNG3y8kgW6qrDvWLCXXqW5ERwtIjb2JrMWzOqh7mFON/klLLnC4SGgSfjOQcmUI38iPxglsGEHJduekj06LPqozcwT4JYGPc=
Received: from BN0PR04CA0146.namprd04.prod.outlook.com (2603:10b6:408:ed::31)
 by SJ0PR12MB5453.namprd12.prod.outlook.com (2603:10b6:a03:37f::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.35; Thu, 30 Mar
 2023 03:15:41 +0000
Received: from BN8NAM11FT084.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ed:cafe::7f) by BN0PR04CA0146.outlook.office365.com
 (2603:10b6:408:ed::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20 via Frontend
 Transport; Thu, 30 Mar 2023 03:15:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT084.mail.protection.outlook.com (10.13.176.169) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6254.20 via Frontend Transport; Thu, 30 Mar 2023 03:15:40 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 29 Mar
 2023 22:15:39 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 29 Mar
 2023 22:15:39 -0500
Received: from amd-SYS-7048GR-TR.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34
 via Frontend Transport; Wed, 29 Mar 2023 22:15:36 -0500
From: Tong Liu01 <Tong.Liu01@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/3] drm/amdgpu: enable sysfs node vclk1 and dclk1 for NV2X
Date: Thu, 30 Mar 2023 11:15:12 +0800
Message-ID: <20230330031513.6547-2-Tong.Liu01@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230330031513.6547-1-Tong.Liu01@amd.com>
References: <20230330031513.6547-1-Tong.Liu01@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT084:EE_|SJ0PR12MB5453:EE_
X-MS-Office365-Filtering-Correlation-Id: f8d67d29-bc56-4ac0-8eef-08db30cd0a53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W83ZPqcGAMpR/v/3TQDgnl9XXeLPUR1WjN468FLR1TyJnihu2OnKElKU/j3ftrY6NJo7h0DWKRQugC/4wuZTe+wxn1kpL4UIK458KZtyiEUIv2tyOMci+5DfH2BiMClQJIYlMoTUO/w0LV0hyotYroXlAa5Lr6zwYyKTixo7bj+vq0OHJhh/cPiTM61YZBYcXECzhHB8uZhGlbTi0RWMg5TxUvvXsPxNyOq5oZymaCGSh8xD3nO/uLTZyII2TI2pGPJHRfi27knG7M/nm4t/5evI1znE9FJjpnLa/MlO1/1ezgDTjIN+/lAmRaGwf81fhUCKyIuP7B3y80TGi0oBpHMDBIJvZEaqOL+ISh7n+GC2Ye/6RIKN2fE625TYYR/rv6KoRrzZTfO32QyFQOpZuKthWMYzZ9LnkBbpikVr1TBYO0f1TAy5Ou6isOPjUU/evcGdYTu+4iC4hJIVsNzV75DAThgkmA9ubn14QREG/eqcVVAq3VmvcqufcrNfyfxxF2t39L0eM1smRLoESCCzuRho7zNqHyav9qK0XGauS1bCWEERlb16P+ZMOawjVlw4YFLNMXSFG6rTD7JtINs6OzTtdSt+ZOt384cCf4yb20WlRJ81aNefbR8QREUqLFfteob2gAKnbsqu2eLvgM11CpmpAlNyF+RR7/yGs1kyOXyjUZTeMo81z9Y2Nw0FPcf4AJqGnjP4EmXcQreYFJwwD8muQz2LhaffeyxMNgo8Eng=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(396003)(376002)(39860400002)(136003)(451199021)(46966006)(36840700001)(40470700004)(336012)(47076005)(426003)(7696005)(70206006)(83380400001)(36860700001)(70586007)(6666004)(2616005)(26005)(54906003)(1076003)(478600001)(5660300002)(186003)(2906002)(86362001)(82310400005)(8676002)(82740400003)(40480700001)(36756003)(40460700003)(6916009)(41300700001)(356005)(81166007)(8936002)(4326008)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 03:15:40.2265 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f8d67d29-bc56-4ac0-8eef-08db30cd0a53
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT084.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5453
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
Cc: Jack Xiao <Jack.Xiao@amd.com>, Feifei Xu <Feifei.Xu@amd.com>,
 horace.chen@amd.com, Kevin Wang <Kevin1.Wang@amd.com>,
 Tong Liu01 <Tong.Liu01@amd.com>, Tuikov Luben <Luben.Tuikov@amd.com>,
 Deucher Alexander <Alexander.Deucher@amd.com>, Evan Quan <Evan.Quan@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Monk
 Liu <Monk.Liu@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Enable vclk1 and dclk1 node for gc10.3.0 and gc10.3.1

Signed-off-by: Tong Liu01 <Tong.Liu01@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index ced295eeaf97..d8b9c6136fc0 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -2123,6 +2123,10 @@ static int default_attr_update(struct amdgpu_device *adev, struct amdgpu_device_
 		      gc_ver == IP_VERSION(11, 0, 2) ||
 		      gc_ver == IP_VERSION(11, 0, 3)))
 			*states = ATTR_STATE_UNSUPPORTED;
+	} else if (DEVICE_ATTR_IS(pp_dpm_vclk1)) {
+		if (!((gc_ver == IP_VERSION(10, 3, 1) ||
+			   gc_ver == IP_VERSION(10, 3, 0)) && adev->vcn.num_vcn_inst >= 2))
+			*states = ATTR_STATE_UNSUPPORTED;
 	} else if (DEVICE_ATTR_IS(pp_dpm_dclk)) {
 		if (!(gc_ver == IP_VERSION(10, 3, 1) ||
 		      gc_ver == IP_VERSION(10, 3, 0) ||
@@ -2131,6 +2135,10 @@ static int default_attr_update(struct amdgpu_device *adev, struct amdgpu_device_
 		      gc_ver == IP_VERSION(11, 0, 2) ||
 		      gc_ver == IP_VERSION(11, 0, 3)))
 			*states = ATTR_STATE_UNSUPPORTED;
+	} else if (DEVICE_ATTR_IS(pp_dpm_dclk1)) {
+		if (!((gc_ver == IP_VERSION(10, 3, 1) ||
+			   gc_ver == IP_VERSION(10, 3, 0)) && adev->vcn.num_vcn_inst >= 2))
+			*states = ATTR_STATE_UNSUPPORTED;
 	} else if (DEVICE_ATTR_IS(pp_power_profile_mode)) {
 		if (amdgpu_dpm_get_power_profile_mode(adev, NULL) == -EOPNOTSUPP)
 			*states = ATTR_STATE_UNSUPPORTED;
-- 
2.34.1

