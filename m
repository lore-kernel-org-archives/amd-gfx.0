Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89434C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Feb 2022 04:12:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F1F5310E19D;
	Mon, 14 Feb 2022 04:12:12 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2085.outbound.protection.outlook.com [40.107.243.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9588B10E19D
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Feb 2022 04:12:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TJLdXS5RJyhAe8f1Eo25KX7YEfU1Up4pAU7ykz8mjBP0hHta1DoPezgKVfkEGbijHiR6oGyZCxho632oS5QlDPgMuL3+hEClX92hY9dTOfEnGiUwimWhCraT58NLs36clyKoqBi1g9OQljRPqJVGVsEfebl/qZlFzc7QwCHJvn2txHSpst1qjeP9qDaUtEuy5PrOaXj46hhnKuBuF1Y7lxjfAvrMWVpGBdjJmkwAPgIWwzyO4d13paSHpN96x0w30iydktF0IN/jxruUFOHHMX4ewnui0yKmrRPdfpHj/X5MfmfdSdsvk8zBPeRwVyNAWYoZfhmE4moymd01Vsw3aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=603jhppNwal2zOWneeQDvpID2xlks5redC1FNGA9JkI=;
 b=aQ8I8Y1/y5ejcZr7LxhMYXOeaoz1ZC2ptupFzgHoqLt2DTucWl9yYMO1RkHgp0F87VdNJzZt4McSb/0Z9h+Y6Z06/eXusDqgGtpDqWANnVbjJHoErBXwu9nXTrA1N6RV4a0JgM/iux3H9KLtYdi5KJZbCdUy7sahyq8ipFBva52D0monlVwYvwXN+mX6sShQxqQ2I8vmNtXMaJGjX10p9NZ3opOeJQeCfD3JsqiIX95oGqG5Fqn6ujPwYV0TKQroaZGnRyGeJpJLXd5K5RAqpuoNG+ICkOqlWGIdf0qJM/Frl62GRn9Jh1DjU/8KQqEAHE1dh2hQrldYDLv1iZrffA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=603jhppNwal2zOWneeQDvpID2xlks5redC1FNGA9JkI=;
 b=F2DoGc8EY+RHihq95chLJHbyDNzV1uuJJZTXSkOe0jEbk7qT5I2TG0gKSV0z+0APfYHRuKVMvM/8V4bb+WkCXqmEwOKacbXAbHDnFK6WtbkeLHnFeouy4l6DYPLwrjrWVj+F/tL323mNs1ldz90T6+nZdWwN74b8rdIeylGWIk4=
Received: from DM5PR20CA0036.namprd20.prod.outlook.com (2603:10b6:3:13d::22)
 by CH2PR12MB3752.namprd12.prod.outlook.com (2603:10b6:610:15::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15; Mon, 14 Feb
 2022 04:12:08 +0000
Received: from DM6NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:13d:cafe::84) by DM5PR20CA0036.outlook.office365.com
 (2603:10b6:3:13d::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.19 via Frontend
 Transport; Mon, 14 Feb 2022 04:12:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT015.mail.protection.outlook.com (10.13.172.133) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Mon, 14 Feb 2022 04:12:08 +0000
Received: from yifan.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Sun, 13 Feb
 2022 22:12:05 -0600
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: correct the sequence of sending gpu reset msg
Date: Mon, 14 Feb 2022 12:11:42 +0800
Message-ID: <20220214041142.2556519-1-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 064c4a99-0c66-418d-36b6-08d9ef702b01
X-MS-TrafficTypeDiagnostic: CH2PR12MB3752:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB375229A3E28597A2257B7415C1339@CH2PR12MB3752.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1728;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SPHKkIHtlH1tsKXrds8dvE5GQ2Ig7a9gftU1ZO0na9EJMkuG8hY1JCn1UxaMb6mev74fjPjXHuB0EcbuzgAk+B2H2nqpn9XEuqqBOgv1OQoqao8uiTvgUYK2MxplafMEvYfbeWFleenhMLS/jteGsCu6O++Rf5K0yZ/iFmfv8fUb5lurCUSR3dvT29OqMfXprZTImKpk/kZjl3V/Ynswzf4MbNk5+8Hu38CqFLzqLregl8SphQr3QKhDG0l3txCqqozVUAyMXHC8/tHzdZjNDVUvyyBS+2/2LzsmrUJLCuyqo+3tnbwq05LSQq0gL1JPJM4EeM+0fV19kqNKQuB8X5h3mnlYux4PQJTqpaCHDiS3oVMYUs9SOInXWVH5X8bu5GJ50XoA7PcC+EO/SWEoxa0IPcCkMjV69GEy3wCqGq/lv2873XcZ1uZOBwAjcsbntCENSm0EW4g9ADnpmoR8K/OxIGJHroQs2D9+1GSYegrkRouEq8qgYbMq3rPfq66Wkhltt87kJtgjFO2cYs7JzeIk00E2YmI1j5Pnxs+jC8WY5Jr5TYvEeUOoj/uQeti4+SzikupzTgOTgx7YEUrvbzESPjOBUaj7A7KXOgNfXzOslKw1qYp4UpTxJru4LPULtDgdGZKnvD0oJY1bwIN4TBSoVFFTbmW8BAex9AnZszegJYbOQtf/u0eTp0WPaCQXZawTwoBwHLQcxVNh8Ra9gQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(36860700001)(81166007)(47076005)(356005)(82310400004)(7696005)(6666004)(8936002)(36756003)(336012)(316002)(54906003)(6916009)(5660300002)(8676002)(4326008)(70586007)(508600001)(16526019)(186003)(426003)(70206006)(2616005)(26005)(1076003)(40460700003)(86362001)(83380400001)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2022 04:12:08.5573 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 064c4a99-0c66-418d-36b6-08d9ef702b01
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3752
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
Cc: Alexander.Deucher@amd.com, Yifan Zhang <yifan1.zhang@amd.com>,
 Aaron.Liu@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

the 2nd parameter should be smu msg type rather than asic msg index.

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
Change-Id: I0a65fac53b06c053ce193580d68cf586e77d2c2d
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
index e90387a84cbb..e2d099409123 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
@@ -262,14 +262,9 @@ static int yellow_carp_post_smu_init(struct smu_context *smu)
 
 static int yellow_carp_mode_reset(struct smu_context *smu, int type)
 {
-	int ret = 0, index = 0;
-
-	index = smu_cmn_to_asic_specific_index(smu, CMN2ASIC_MAPPING_MSG,
-				SMU_MSG_GfxDeviceDriverReset);
-	if (index < 0)
-		return index == -EACCES ? 0 : index;
+	int ret = 0;
 
-	ret = smu_cmn_send_smc_msg_with_param(smu, (uint16_t)index, type, NULL);
+	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_GfxDeviceDriverReset, type, NULL);
 	if (ret)
 		dev_err(smu->adev->dev, "Failed to mode reset!\n");
 
-- 
2.25.1

