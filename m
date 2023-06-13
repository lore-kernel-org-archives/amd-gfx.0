Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91BE8C7EE2E
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Jun 2023 03:53:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9DB8410E308;
	Tue, 13 Jun 2023 03:53:31 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2073.outbound.protection.outlook.com [40.107.93.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0829110E136
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Jun 2023 03:53:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TQes6wg9VjBfdBOnGWVOcFuPeWFFHiXdruPPWXADIzUnB6EBrgaE6Qtpchp4cOESmp1/8k3bqZpBlQp8Zh8P/igoukUF8RkJqdzeVt+ifUhV0+9hZPVfwcrmxj4qLIB2ILGGVidFbtN1rl0G7hgi8GpUpsqiigKaA2xb+62tlUgv17A/mwe6dg37ngJGPDUrY89I20Di9pwQ+VXthnP9mIzD66JpgkO47ISDIRRnowEulLBWaoLspyT9gu9y/0LiqYddIwxPGzZJxe7iN1LbQCi47sILUqnROCfIqhNNqg42P+gGewLyRrrE2c+N3C3qcSnb8/zqLLYIK++N2TE50A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T/zV3f1Tz2nEEbQ4QCDQ7uQbJU78T5qbONd8+vhNzNk=;
 b=WbpnEJtw3vVTMGTtS6o111QdgnwIvyLrUawxZJ273ewPzW1ISxlSykAVTwIiBww6X4DnFz4lqRgVL/AkqZzGI4NuwQak1nIW9XJXlE/+gcAuAM/1N7oIWDGlmxqMFDEdxWV2jgGvifHBuHooi1ToM/97KbKXdL9BrkQhqt0vfE+Tp3b9lkgj5VbHnMJCyi13a1mYUdnYz9MImxMTuy7N1FB/R/CvvahJtXCMTTBvixKJSScXl0hALWYfNE18B8DAIONDUy/lZUGAnL79xv8Bh7T+rNIXdaU6UjWkKtSHxiuEjasfq2h6YFEGsBauR4v//e3DjWGDWToKQAgoguaneA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T/zV3f1Tz2nEEbQ4QCDQ7uQbJU78T5qbONd8+vhNzNk=;
 b=10pO1qzFFHCrLfXJXyMA06BbE8g3KqkDdiwT7H8XpbyC0J2BbKGQlBvACpl5un+moqJkI0Ftr1cZSTr736vYpof3WnYvscE9qxOsaWW22cOEgeMPDl7KSyGlG5Dhg2q+86eRk5KgBi8h+jHT+stxRKydJbT+r+cW7W1sLN6pW2k=
Received: from MW4P223CA0004.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::9) by
 CY8PR12MB7585.namprd12.prod.outlook.com (2603:10b6:930:98::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.46; Tue, 13 Jun 2023 03:53:28 +0000
Received: from CO1NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:80:cafe::b0) by MW4P223CA0004.outlook.office365.com
 (2603:10b6:303:80::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.34 via Frontend
 Transport; Tue, 13 Jun 2023 03:53:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT004.mail.protection.outlook.com (10.13.175.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.22 via Frontend Transport; Tue, 13 Jun 2023 03:53:27 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 12 Jun
 2023 22:53:23 -0500
Received: from stanley-test.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Mon, 12 Jun 2023 22:53:22 -0500
From: Stanley.Yang <Stanley.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Hawking.Zhang@amd.com>,
 <Tao.Zhou1@amd.com>
Subject: [PATCH Review 2/2] drm/amdgpu: Add checking mc_vram_size
Date: Tue, 13 Jun 2023 11:53:18 +0800
Message-ID: <20230613035318.10613-2-Stanley.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230613035318.10613-1-Stanley.Yang@amd.com>
References: <20230613035318.10613-1-Stanley.Yang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT004:EE_|CY8PR12MB7585:EE_
X-MS-Office365-Filtering-Correlation-Id: 9dbae24d-5c1f-41e7-d1bb-08db6bc1bed3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RWtIjvTuBZOHgVS+KWKdAdDx4yZfv8ibsgtYVINQZj4WAN/8fDfTYa1af+GSm4GJB20Uh/k9vDscDqgbaXhQ3TFdn/LB+p/Pz9ksvYPE5P1bDRud+OphtAZmxj//pwBtQLelauqihUpoYYbrJNOs8A/Jkg0gSv+rZUqbWOHIeVW33+QfFQxWj2/x7Ff5Dct4LEHrK0QwcgvzDm4nc822F9PBme5psrKKiVF3ZINBZdh5+1neH69bYG49W7xDKmY6RzYc6cTapV4jNg3iHSiGkVi+IkpSAZXeCrPoBtcy21scFzcqbDF4a9ZHF6BPiIWpEFb2FxLGL1ibtjhQqbSSEzk1hCANdgIs9WrdnsHJBYrfcjuei2ig0xZS6Z7GLYAIMxCCN6xWO1mvH29ex8c6GLyzpofZYIfA72csOmYJ07vcp05vjdZQSsPwHDpsOUoAgTomNlbzXKVxCBQl6U4r40EWBm2+GEy+KbIj5SUagbl6TfTyt5frfxn7XQjZNzFnALE8idqomWUCHGJniqqGg847JL9lKHMx7xYnZe7ihHC8RbC2v0bjnlUHD8gvaeVWMiujMfO9NKkvoR/QRJrSX50RLABiZbsp/qrXXK5qBFH9eOpZF8xTUugK3UYk3ZmNnOpvc7/wuZJE0O6kDe07L6CWM0yDqCW5i19NnBmYwgdhtQP432DYdmRmokvTPU8k3VYfZPZKYpVxVDeUZZyyorja86+5gLAr5mCEiFmTn9wT3SQpUynNizJmVB4oYDYZtcN5jXOXVvQKnOzv7DCgXA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(136003)(376002)(396003)(346002)(451199021)(46966006)(40470700004)(36840700001)(86362001)(36756003)(478600001)(110136005)(4326008)(6636002)(70206006)(6666004)(316002)(70586007)(7696005)(40480700001)(8676002)(41300700001)(5660300002)(4744005)(2906002)(8936002)(82310400005)(356005)(81166007)(82740400003)(2616005)(426003)(336012)(1076003)(26005)(186003)(83380400001)(47076005)(36860700001)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 03:53:27.5907 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dbae24d-5c1f-41e7-d1bb-08db6bc1bed3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7585
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
Cc: "Stanley.Yang" <Stanley.Yang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Do not compare injection address with mc_vram_size
if mc_vram_size is zero.

Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 56bb0db207b9..3c041efcf0c4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -494,7 +494,8 @@ static ssize_t amdgpu_ras_debugfs_ctrl_write(struct file *f,
 		ret = amdgpu_ras_feature_enable(adev, &data.head, 1);
 		break;
 	case 2:
-		if ((data.inject.address >= adev->gmc.mc_vram_size) ||
+		if ((data.inject.address >= adev->gmc.mc_vram_size &&
+		    adev->gmc.mc_vram_size) ||
 		    (data.inject.address >= RAS_UMC_INJECT_ADDR_LIMIT)) {
 			dev_warn(adev->dev, "RAS WARN: input address "
 					"0x%llx is invalid.",
-- 
2.17.1

