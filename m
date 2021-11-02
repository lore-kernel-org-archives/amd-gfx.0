Return-Path: <SRS0=itHt=PV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EC66C433F5
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Nov 2021 10:25:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEDA460F56
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Nov 2021 10:25:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BEDA460F56
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 612D66FF0D;
	Tue,  2 Nov 2021 10:25:15 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2086.outbound.protection.outlook.com [40.107.237.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 251836FF0D
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Nov 2021 10:25:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dLpDysZeNSonN/B0XP+mm4unffSsNwqHnoSaXq9IGelciD1lY77mxgsByixArfjzstI0woC/ZVhrZYpEn23o4k9hzF81eXzljl4NoWNmTwxxc+xwj7GiWF9xrOZ6zSluN1DRcxe6JO/d93aq1zAybdtuVsKacrDq+13pa4aKYNjBNp/K+EGRGfXUrgvqpvDzwBsZ+4L05pQ4upUQ7fEe4JS9wxOqjIvIDs3RfnpjxHrY0VqiGk/EREDcoy1oR6netIArz5wMcdYw7AU9i3xyWV7+xwOtHNI5Rg+A5+VO6Th1H2CWqcyzwq8w0T8HrEqPTirZ+cnUckof8pmNLG31gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G0FXWShZ0V49m0tHYiNXh4OS3SVJzSMlgbediOXpF8Q=;
 b=Z6NvyotWKl7DHLivSQSQ+Ldca4Cyqe/HW5JyGV9e/g+rlyY8zucYw3SmftdHrigwVebmaFI5wmF8ibkhqQmRuICIiUCfrYYkKX0Ty5sDyW3zpRBN8bgJP/SGEQ51rh+Fq4qFmdlPFV1khptgRd0csjrBN9/ECSgl5wzZe+FELQIERYGltcx9HpGTNhU9dLyyOmU9AYPprKznNA1WL/lP4oRmwtx875KC35ftFniUbDLSAknMC8zHmQ6bOB3Y3YobnnuczaT6qnqBI+VpiUNMyhmvhLpzjL6WNwDhXKaTK0jA9JRjtlUHaX6UufE4jD3SXQYthAAlUicglnuhPApRUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G0FXWShZ0V49m0tHYiNXh4OS3SVJzSMlgbediOXpF8Q=;
 b=LUYyCrXp/9dSN35mS6eBvY+RQxhLYECxMqSSf5L0ofpvUK7VT+Nf8xtG6opjmgZgHIwDQoPOIEbj3N9usUBWNmBLOSEIK9rDxOe8rGPLpWN4d5RTFN4dE3XtDdMvMU81YB8IcsRowHfnA+4mMjWsSCcQegDPr58ZDl3n6VEcWmA=
Received: from DM5PR06CA0096.namprd06.prod.outlook.com (2603:10b6:3:4::34) by
 BYAPR12MB4693.namprd12.prod.outlook.com (2603:10b6:a03:98::27) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4649.17; Tue, 2 Nov 2021 10:25:12 +0000
Received: from DM6NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:4::4) by DM5PR06CA0096.outlook.office365.com (2603:10b6:3:4::34)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14 via Frontend
 Transport; Tue, 2 Nov 2021 10:25:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT015.mail.protection.outlook.com (10.13.172.133) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4649.14 via Frontend Transport; Tue, 2 Nov 2021 10:25:11 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Tue, 2 Nov
 2021 05:25:10 -0500
Received: from yubiwang-dev-linux.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2308.15
 via Frontend Transport; Tue, 2 Nov 2021 05:25:07 -0500
From: YuBiao Wang <YuBiao.Wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/amdgpu: Avoid writing GMC registers under sriov in
 gmc9
Date: Tue, 2 Nov 2021 18:25:00 +0800
Message-ID: <20211102102500.109229-1-YuBiao.Wang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 59b02669-d988-4040-78d1-08d99deb0d4e
X-MS-TrafficTypeDiagnostic: BYAPR12MB4693:
X-Microsoft-Antispam-PRVS: <BYAPR12MB4693F7DB55F44F7EEDEF7FB2E58B9@BYAPR12MB4693.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: crRCW2yBk8MMdmjGLC2TOHgt/DO+K9jWwkDNjhm0qrllpW/3ednpGGo44Ithe7I6S75TzKaxtQnMRh97y2FZ7jJ/m9w5KZy/Nons2wbv/xMRATyvbyuwGLtWvYtpQQ588dNqQPYLu9m+KdlmtBxzwC5wWwlb2He3J1/H6SxwI6MnvGLNzitgsUHvDr+64hXR0LdQ2gput4E4pS2h818pchSXx0tn4ejnXbsjxNeSFZy/PnPvJf8iSIex2FX/C0zEwXY0cl5cdtsbg8TAURzUzyx4wqiyXynXK4YbCeKpHO1MiP8SLGT92Ky7nl/KZ2Dwvo1o+NXmDao1jAvDk9c76sanAVr8+x3NS1aC6Z9ztc7XokehoGP3Y9oh+xbLgQyT8Bm3mqKKV69LYEbgtECRu6FjctFFIQSBRniAFaR/w2OpcTjX6ol/QryHvfG8dkbwzCiP1G+WdbsvWh5bf0QpFXPiJJrKPuypw2KwJy0L/ROGCfMZZvRGVYDAJKsUuNmjIciOMte6+6BKZg5+VmYtt0vfLVJA2VzmI8Yrea2wSJEmgpSdsFpiOOhpveVv4P6lfBTHe8mDseph7RVolqpjHfbdf3/TYpi4S5GjfmONn+k6zzvbeqfP0v7WsJkrEwDpblxLlA8YIkzqN++a5J501NCvRxDHlScgd/o4jIztApBBBRQajnrxwKD0nCcmazw7/Tq2R6WqA92VJeB/q6j4FV3tAhEQrqsg+RFXWhmmWt8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(83380400001)(186003)(426003)(70586007)(82310400003)(36756003)(316002)(8936002)(7696005)(508600001)(54906003)(356005)(26005)(336012)(81166007)(1076003)(70206006)(47076005)(36860700001)(8676002)(5660300002)(86362001)(2906002)(6666004)(4326008)(6916009)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2021 10:25:11.4978 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 59b02669-d988-4040-78d1-08d99deb0d4e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB4693
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
Cc: YuBiao Wang <YuBiao.Wang@amd.com>,
 Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>, Jack Xiao <Jack.Xiao@amd.com>,
 Feifei Xu <Feifei.Xu@amd.com>, horace.chen@amd.com,
 Kevin Wang <Kevin1.Wang@amd.com>, Tuikov Luben <Luben.Tuikov@amd.com>,
 Deucher Alexander <Alexander.Deucher@amd.com>,
 Jingwen Chen <Jingwen.Chen2@amd.com>, Evan Quan <Evan.Quan@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Monk
 Liu <Monk.Liu@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
For Vega10, disabling gart of gfxhub and mmhub could mess up KIQ and PSP under sriov mode, and lead to DMAR on host side.

[How]
Do not call gmc_gart_disable under sriov but keep vram_unpin to avoid
pin_count leak.

Signed-off-by: YuBiao Wang <YuBiao.Wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index cb82404df534..365059a20ae8 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1793,14 +1793,13 @@ static void gmc_v9_0_gart_disable(struct amdgpu_device *adev)
 {
 	adev->gfxhub.funcs->gart_disable(adev);
 	adev->mmhub.funcs->gart_disable(adev);
-	amdgpu_gart_table_vram_unpin(adev);
 }
 
 static int gmc_v9_0_hw_fini(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
-	gmc_v9_0_gart_disable(adev);
+	amdgpu_gart_table_vram_unpin(adev);
 
 	if (amdgpu_sriov_vf(adev)) {
 		/* full access mode, so don't touch any GMC register */
@@ -1808,6 +1807,7 @@ static int gmc_v9_0_hw_fini(void *handle)
 		return 0;
 	}
 
+	gmc_v9_0_gart_disable(adev);
 	amdgpu_irq_put(adev, &adev->gmc.ecc_irq, 0);
 	amdgpu_irq_put(adev, &adev->gmc.vm_fault, 0);
 
-- 
2.25.1

