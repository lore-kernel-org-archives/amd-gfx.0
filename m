Return-Path: <SRS0=uqvu=KN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 153D2C433ED
	for <amd-gfx@archiver.kernel.org>; Tue, 18 May 2021 02:01:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8D94613BA
	for <amd-gfx@archiver.kernel.org>; Tue, 18 May 2021 02:01:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8D94613BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4AC606E59B;
	Tue, 18 May 2021 02:01:27 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2040.outbound.protection.outlook.com [40.107.100.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 81CF26E59D
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 May 2021 02:01:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MB7cTFucvWP3+QQzG80qycQS4LzuGdTF7Kh9mcxnzpfVoSVPox09F7V0bv46eDYxv4sbvQGVIU3XHJKmmONFQcWjq1pHXcJCSSZeCh+Mky6nd2Ev4vDIAxLtNdz/pjV2c8CXg1NBL2Ir0KNksI5TQhAOsUqYRWCWDg8JEWKMSAEdFNFfHaAGmGk735j48C3VS4GiOZLqA9HeLmNNRPwBzAQST6luhNP/yjE3q6ry4AFY0/Sl6Rjnmo2GHp+5S4UIenDKzQ6F1NHu3EjU268ME22qmEefpoa+iLNHNx4f1lQZrQwNCfBQyonKlaA3mEh4afAlFsRLD+UwzW71OXKFvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9fgCRA3Rg8zI3loHoOoySbkSro3G8ZSOtaJh0nDeFHY=;
 b=A6CKj57QoTutElzuViTieWX6V+HfH0Y2I4otPC2M2gXw6kYowohc0kH6vH++FPDuHSuaUjgwOR4sCLX05ytgHPqFXHno6eVYaaFYgxot0kmHWhxQFqdE3GKKrnqsZv/oY9VunSRMz7JnWPM2m0vzy2QzaqrkEC2hyleNgHixBllGUExPm8GOFTIl6tyA/qDFcCaUh06ANAKkK0tfCjOPLKUNFWwVV1mNDUP6XK+6TxS18vuraWWdw7L4zU8rDlG8qzIr7DPhhy3gzpMmYkz6LO46LZpayBGCHNyGX8OblFzCvfOFDf5Mgc4NayikGECF82bcyLhtXxr5S+xcO1OxFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9fgCRA3Rg8zI3loHoOoySbkSro3G8ZSOtaJh0nDeFHY=;
 b=m5xT/1UmwCZob6xf/KBVyM9fmfHDbhVRrkv2FI3sw0MftBJzTRqYDZuAgMP3iPDX3NU8Dq90/ckmL3UaTfV+PKPzoZ1BJ7hL5Zv29+u7Gjgk5LHHkWQLyXNgwa7FDL9ZasU6YL+1NnqnQNQihNgDZkFKh+gvcYTKNUTx99N+HkA=
Received: from BN9PR03CA0931.namprd03.prod.outlook.com (2603:10b6:408:108::6)
 by DM5PR1201MB0185.namprd12.prod.outlook.com (2603:10b6:4:55::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Tue, 18 May
 2021 02:01:23 +0000
Received: from BN8NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:108:cafe::7f) by BN9PR03CA0931.outlook.office365.com
 (2603:10b6:408:108::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.24 via Frontend
 Transport; Tue, 18 May 2021 02:01:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT052.mail.protection.outlook.com (10.13.177.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4129.25 via Frontend Transport; Tue, 18 May 2021 02:01:23 +0000
Received: from guchchen-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Mon, 17 May 2021 21:01:20 -0500
From: Guchun Chen <guchun.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
 <Hawking.Zhang@amd.com>, <kenneth.feng@amd.com>, <jiansong.chen@amd.com>,
 <jack.xiao@amd.com>, <evan.quan@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: update sdma golden setting for Navi12
Date: Tue, 18 May 2021 10:00:55 +0800
Message-ID: <20210518020055.2132-2-guchun.chen@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210518020055.2132-1-guchun.chen@amd.com>
References: <20210518020055.2132-1-guchun.chen@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 31ce27cf-5e5d-47a2-3403-08d919a0d679
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0185:
X-Microsoft-Antispam-PRVS: <DM5PR1201MB0185173B436595C8379ED4ACF12C9@DM5PR1201MB0185.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:324;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O+WjS5BkgspxEGDMcbiwg4W9kufn+xZKrnYtyLdurOfw6mVzMm41xX2y7lMsF4USczyXqvhK9arS+SNXlkzNbqeBLLOxkYMfuQJh0+R2f7yURcW2HpPGPAV/hcX+c+EKLNjJoL+ELK8VZ0Bq+0yBTxBeyZgQhurHbVkf9lpuhCHxctT4/wMzKx45TwUMggx8Ii+xGauIFGvrLjz9FlXGFVC9YCP27hAxKBJk01VKKBQy5+T1sn7/k8RWdF2ceAzilNVepPi2KX7CCb5fzok18g62I5jW/NmgfmjIYJgCyOuCywLDLcta8nvukNaEELOboIfbqacJHA1cAnH8jEgUmLF+h1Q15iYssj2DipC+2QE3Y5wOQf0xbQd5fiBYQRjzX7TrS5yS89U0EeannK3zwvUvwJQz/1DxXzqB6AJ5poY6UvRxz/l7C+z/wUXDUuMEIpVjDydJyUx4GPQ4f7/SNjkgwr0gkJ81AnA8yERkAVLMvhOQtukhzd/df5klDXsctF1XjpzTqakxoUUXfUOJDNapz0KyXI/Hyf/kh307afe4R8xWA9gTUAwcxmPpVOeaicq+fDgm5F7xbA4w5nvuNdCDHHFtjksXSsDD8Kz4f7ARhsPjXTDbGK44w4PieJBUvUll3I9MjgWfwYKBeY53hsIena9UZIP3bZo/PTO739Flj/zKhwOXAGs51pZiHcsYoQQT7JBzl7PZ4dsFdf/ftg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(346002)(376002)(39860400002)(396003)(46966006)(36840700001)(110136005)(426003)(186003)(7696005)(16526019)(36756003)(1076003)(316002)(356005)(83380400001)(47076005)(26005)(82740400003)(336012)(81166007)(2906002)(6666004)(44832011)(4326008)(86362001)(36860700001)(8676002)(6636002)(2616005)(8936002)(5660300002)(70586007)(478600001)(82310400003)(70206006)(2101003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2021 02:01:23.2935 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 31ce27cf-5e5d-47a2-3403-08d919a0d679
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0185
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Current golden setting is out of date.

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
index 04c68a79eca4..75d7310f8439 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -123,6 +123,10 @@ static const struct soc15_reg_golden golden_settings_sdma_nv14[] = {
 
 static const struct soc15_reg_golden golden_settings_sdma_nv12[] = {
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSDMA0_RLC3_RB_WPTR_POLL_CNTL, 0xfffffff7, 0x00403000),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSDMA0_GB_ADDR_CONFIG, 0x001877ff, 0x00000044),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSDMA0_GB_ADDR_CONFIG_READ, 0x001877ff, 0x00000044),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSDMA1_GB_ADDR_CONFIG, 0x001877ff, 0x00000044),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSDMA1_GB_ADDR_CONFIG_READ, 0x001877ff, 0x00000044),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSDMA1_RLC3_RB_WPTR_POLL_CNTL, 0xfffffff7, 0x00403000),
 };
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
