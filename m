Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57B90C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Apr 2022 21:30:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC3B210E9C2;
	Thu, 28 Apr 2022 21:30:07 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2074.outbound.protection.outlook.com [40.107.212.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9281010E86B
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Apr 2022 21:30:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eecA25+uNvXlaC4dNLg8spduUUk1kycJYy3kma5zYmpr2bk9yOUepqqzoy2YzbXTUYoqgVoX1HH4ZyKpVQ2VEsW/u6kXh0+o7HTS3ch3cJWgKB1E7hHwDBe8NOOSKmgkfNc04Wi/nW+53RH5bJQX+nDDtdDKqlfosX1PqujfFT6Xo6F+W3cO50dTi/0lj/e77g8d38gFi6rf/1MVe/pw6zjomOTL1uPSleLO/WXkkW70S8wbqenZRP9gJcSgo321l7SFzSjsn+bGXtYuqQZHWkVxYYZE+UlLxVPyZav3Glo8eXpO8yJJ2ReGRI9gKrdTNWTXX54mZ9SbgPMq7MFCiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TvfDkGp8s55DC2MImMLZ/hTGK0y79EtJ27H3UyRgctU=;
 b=c+hOtZm43oUOhF3EriHs076FyqnFAdNXeDvRfwYZcwz/zSJBk1LMj6H01n6YwtaZCQ1t+b+Yxhphn9cAypcthKinwQffKU8zzcYV/6GCKUrHJbWD0XJjT+WU/ihSYpmHgqX2R05dUp7ErIH4uuTZN9EgkfCOBK2vz8WCuDSCBvnKcrWMYhYupODkOqW/h1hOUQu3+DsEcJlOQ9GDtr01/G5aQBaX3JmOf2n6UTKgBEW2FamEZMCHMiHB5SBe48CCwmGQ2GwqZ5vCM1zwuNLmYzexjDlnajuCU95x5yst3MlsTmh3XP89OP/4+cSMJ2Hvo5qPez1lmf4OCVDbJx4vJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TvfDkGp8s55DC2MImMLZ/hTGK0y79EtJ27H3UyRgctU=;
 b=w1tpjVWJp03YT+gK5dUirdH76Ipa1KbjEruVpJUJ+Rg9pHMqym2F2mq4sz8uP65Jr1rFJoeHfr/oO4+tB5z2goAAf8YhV8KzjKe35HJhWetWcZZGuSB5GJofvp06m4c0BRvKBn/+r+DzmPn23bskU3TtPDH2i+MF2V78GweK6vU=
Received: from MW4PR03CA0164.namprd03.prod.outlook.com (2603:10b6:303:8d::19)
 by MN2PR12MB4605.namprd12.prod.outlook.com (2603:10b6:208:3d::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Thu, 28 Apr
 2022 21:30:01 +0000
Received: from CO1NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8d:cafe::a1) by MW4PR03CA0164.outlook.office365.com
 (2603:10b6:303:8d::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14 via Frontend
 Transport; Thu, 28 Apr 2022 21:30:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT006.mail.protection.outlook.com (10.13.174.246) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Thu, 28 Apr 2022 21:30:01 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 28 Apr
 2022 16:29:58 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: query core refclk from bios for smu v13
Date: Thu, 28 Apr 2022 17:29:37 -0400
Message-ID: <20220428212946.700296-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220428212946.700296-1-alexander.deucher@amd.com>
References: <20220428212946.700296-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 47e9af68-84de-457d-756e-08da295e40b2
X-MS-TrafficTypeDiagnostic: MN2PR12MB4605:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB46056AB673219575E89FD1CFF7FD9@MN2PR12MB4605.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lfqWNS7ZN6HNe03TjlF3U/k5uUzcBsC660cWYUhCnHkbN4/NOoCEuzadriMmRiPCGhuMqAPSETdYICXfW6GPtD4l5PTtK7BU6UvAtQutHha25Quwo9Efe1Xpb3Z4yWqgUyizeEdaNGDObvW/GN6Bd08rgs44dgayV+vlpEpcovK+Rnt7U4EiVBHIxWrobUV35vk5P6ty0L1OGgDrkM+pAEDXPO5/4ew1NkSmsoFrxYemsHeXd/EP9gQNOqRY7Ly5cQyLIvTZoUg8TWZWmhbJPqtscVUp+J2aafSXeOmNDpJ2ZYEYvUsPGSTD7sS+A6CCW2ToJSjpd1D+hzgc1uDGqATYOv9EireC7p5koQEwat2+mnyVXPlfhwAOuUFxVcVbcOhZRJGAmUsgYhit1emP7tbGKPwwISxBquyU3aW3YQcrNDPWX3zc0DC/NizmV5BUar7Bo4YfLpjvhE+TCE04CjGhSByNzRhlgYVg/6rHEgK7RxY/nWbjqcFs4kAO6GtrEj3gWnkXBvE+7wLV5hDpCoP+dxG/PFO/N5aWNSZLla7KhmXsXEqy/vZa95ym5GrUzZsmU6Cae5W6dXM5BwjEgZlC5MVOKPJJXZOe9Hhs//CAajM7f1+fvAgPX9O1bWI8ow1bAwiMQDowx65x1uhBqVKc1G3g2mkpz+zHcCYN87JnUs7N6QTshkYMDED5LzYOv1wyR+xjvlzVHf7sI6QjyA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(5660300002)(508600001)(8936002)(336012)(8676002)(16526019)(426003)(1076003)(47076005)(186003)(70206006)(2616005)(4326008)(2906002)(316002)(26005)(81166007)(356005)(6916009)(6666004)(54906003)(82310400005)(7696005)(36756003)(86362001)(40460700003)(83380400001)(36860700001)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2022 21:30:01.3573 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 47e9af68-84de-457d-756e-08da295e40b2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4605
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Likun Gao <Likun.Gao@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Hawking Zhang <Hawking.Zhang@amd.com>

The smu_info structrue for smu v13 is changed that
core_refclk in v31 strucuture is not correct for
smu v13_0_0

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Likun Gao <Likun.Gao@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
index 494ca6a0f47a..63e0293edc5f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
@@ -556,6 +556,7 @@ bool amdgpu_atomfirmware_ras_rom_addr(struct amdgpu_device *adev,
 
 union smu_info {
 	struct atom_smu_info_v3_1 v31;
+	struct atom_smu_info_v4_0 v40;
 };
 
 union gfx_info {
@@ -602,7 +603,10 @@ int amdgpu_atomfirmware_get_clock_info(struct amdgpu_device *adev)
 					   data_offset);
 
 		/* system clock */
-		spll->reference_freq = le32_to_cpu(smu_info->v31.core_refclk_10khz);
+		if (frev == 3)
+			spll->reference_freq = le32_to_cpu(smu_info->v31.core_refclk_10khz);
+		else if (frev == 4)
+			spll->reference_freq = le32_to_cpu(smu_info->v40.core_refclk_10khz);
 
 		spll->reference_div = 0;
 		spll->min_post_div = 1;
-- 
2.35.1

