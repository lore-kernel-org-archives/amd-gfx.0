Return-Path: <SRS0=CFUU=N4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53821C433F5
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Sep 2021 12:58:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0314F6108F
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Sep 2021 12:58:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0314F6108F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C7FE89857;
	Mon,  6 Sep 2021 12:58:49 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2055.outbound.protection.outlook.com [40.107.243.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 05A1E89857
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Sep 2021 12:58:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JYlTYHGTcieJyh1GdE08w7n1ipyjxi9m7NS2ZKHhQvxqDq+joX+uhV3CoJaoS2XKcrU350ywA0qCYIkq72gHkJxyUyxlSmSrUjie58kuJWQ1j43/a0qLE4wSZ0+Tb/lNko7lUuO23sQ2b9Nx14dbgG3U7a+j5ciU3W69eHPtron7vfE3U6qIbmcF7jtx8a7yunfb3Cd+UzGXGadqM57PzXeNwWlHWv3w8fnyFMl92KY0XdejhgPlP62WbUR4fT1UaNr9zCMgIYaeEBEiJLTxL36OgA61WRlxyv9jmS+M2/Bx2zTaF6azIOsPrIDKTFb+8vLbNnzOhnCLXl0Exgb6DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=f56p9/kwG5ich8jspNXv3Q9IEepxDlxNFoTd71eoQQY=;
 b=bRurDQ/U4L45T8w6EogkqSDVuxqDKPDIbQUgy6r4FXXbu/VKgwsvJqm67OLi5cyVvXQx5pReJty18qhdGXl7MssSjVAaoI2pkcwYD4B0LQMatil6QJmxlqXzYSrRFelRccRyiys1F/+LdD7ST/r3Y16paNW3WYeBz5L3EVgjkepbP4nCkiMZw/9/f5OG/IEml5DSRyWUhytlY2dhrZFQ3OxK4pdYLH9i9bIKP9nK+WbTHWo3+AqiJOj6Tz2GR3SgEq4b1IpYVNf/odLDxEM+ycQQnn8ttn3dS4/Rav9axVszxXm5Pm/wkNYJNApbhecn/rwNzXfF94KgkhB3iHs+Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f56p9/kwG5ich8jspNXv3Q9IEepxDlxNFoTd71eoQQY=;
 b=dQbLn9JziOj5r5Kq9S6ce+tFXhpo1x/JnSD52n6Ur6mBODtVGhLSUBmuUiWG1Y8TEHpgxhc2SPw69Mg2OK9vp93L0p0YwuL1zCY6v6mS2yS2ZucTXjwWm8xuTUMfyO8Y3qz/ib6B0+PSGpR9bKuRARMSeIQt0au9rdcnw6PwKZ4=
Received: from BN9P220CA0007.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:13e::12)
 by CH2PR12MB3752.namprd12.prod.outlook.com (2603:10b6:610:15::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.17; Mon, 6 Sep
 2021 12:58:46 +0000
Received: from BN8NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13e:cafe::12) by BN9P220CA0007.outlook.office365.com
 (2603:10b6:408:13e::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.20 via Frontend
 Transport; Mon, 6 Sep 2021 12:58:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT052.mail.protection.outlook.com (10.13.177.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4478.19 via Frontend Transport; Mon, 6 Sep 2021 12:58:46 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Mon, 6 Sep 2021
 07:58:46 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Mon, 6 Sep 2021
 07:58:45 -0500
Received: from Roy7.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2308.8 via Frontend
 Transport; Mon, 6 Sep 2021 07:58:44 -0500
From: Roy Sun <Roy.Sun@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Roy Sun <Roy.Sun@amd.com>
Subject: [PATCH] drm/amd/amdgpu: Enable some sysnodes for guest smi
Date: Mon, 6 Sep 2021 20:58:41 +0800
Message-ID: <20210906125841.40876-1-Roy.Sun@amd.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e79c1b55-2b2e-4abe-d1ea-08d97136103d
X-MS-TrafficTypeDiagnostic: CH2PR12MB3752:
X-Microsoft-Antispam-PRVS: <CH2PR12MB3752E619D4108BE7A9A959B8FFD29@CH2PR12MB3752.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:366;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o87Ood9eANoDKmthBffXGT0XXUbYqsbMHV2P5iG9nJMI65QRD6/Nn4wyoasJk9E2gEYkuM6SpanJ2uYiQzbyP47CSKgGciQcN8XF93bIMHpPYkTJYcFkMioy0xS/vu1Q/T/GiLFscjZQPmv9ZVwjU4X0mJ1MgmhBKMbb/J1JBMIpsWmtSIdh+Y3tt2SVu24hRL4mc64t/kHYe3K9V4nXnpNKXzRbYlcdtqUwxGLJJ2s2ymuj1UHXF0BHp+8jDbptEACmwiG6fuPkSlCBK2VBGDiGb1dAINaWba0oChvIV5vA69+5MrF3xh4sWXrsT6Ut+8cMm73GFEXW8DQBVc8CTCQKmLl1y7FfYUXbWmB8UQ+e9e8NTFftmHCirhu2LrcK2LHGD2l/NaD7sAtSoTdA3y95zYUxSdrO82kgnmA9FrsDaxxzMMjUZZ0u9DTo0qUTETYMYfAFvylvkSXd9rI+YiQYvQyJl2Kda+uQhTbpz1SUW+7vJyRHir+e8a3CBuSwZ3ElJb3hMWuKS8d4c66un+c7rbEIGraltFU/wFQCQOzEk1Yqb7DtHc7v2sC0JPFj6aJtlUQ8e2+RVbK0cwaBQWq04cvj7leUc/2kAse6ahVBBDCZAzqcuSpChh30aYuuwljr+atODc7kUyTWRIINNji4kzzuIGytF3xZgDixttZle/HHpzss8edg7TNLDEXOoH8Z0m5XPLGMfKygHBXv9uRxsTlhLTpNw/WsLX19R3Y=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(4326008)(6666004)(81166007)(336012)(47076005)(86362001)(2616005)(7696005)(8936002)(426003)(8676002)(316002)(5660300002)(2906002)(36756003)(356005)(82310400003)(70586007)(70206006)(36860700001)(26005)(1076003)(4744005)(186003)(83380400001)(6916009)(508600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2021 12:58:46.3875 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e79c1b55-2b2e-4abe-d1ea-08d97136103d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT052.eop-nam11.prod.protection.outlook.com
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Enable sysnode vclk and dclk on Navi21 asic for guest smi

Signed-off-by: Roy Sun <Roy.Sun@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 249cb0aeb5ae..c255b4b8e685 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -2087,10 +2087,10 @@ static int default_attr_update(struct amdgpu_device *adev, struct amdgpu_device_
 		if (asic_type < CHIP_VEGA12)
 			*states = ATTR_STATE_UNSUPPORTED;
 	} else if (DEVICE_ATTR_IS(pp_dpm_vclk)) {
-		if (!(asic_type == CHIP_VANGOGH))
+		if (!(asic_type == CHIP_VANGOGH || asic_type == CHIP_SIENNA_CICHLID))
 			*states = ATTR_STATE_UNSUPPORTED;
 	} else if (DEVICE_ATTR_IS(pp_dpm_dclk)) {
-		if (!(asic_type == CHIP_VANGOGH))
+		if (!(asic_type == CHIP_VANGOGH || asic_type == CHIP_SIENNA_CICHLID))
 			*states = ATTR_STATE_UNSUPPORTED;
 	}
 
-- 
2.32.0

