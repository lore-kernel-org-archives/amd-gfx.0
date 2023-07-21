Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2828EB64DC
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Jul 2023 13:17:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 546F410E14B;
	Fri, 21 Jul 2023 13:17:59 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2061e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::61e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A2ADC10E14B
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Jul 2023 13:17:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g2Nw+/yUu8qWZYd4JYCgnAIEKCYEdy799Afd8l7vWzfXXkvVGRgz7oeMLHkst/M96O2hyWZjjiicAMzYtx1A9pgqqgvbSMVhrh/NQbCNBkPrxFyO76/gJULQuontyYbwhgIuA8G5+nBJgK8koeGiRzSWolM/PiVBDXofGDI3jeWy410oDB3U8Kck+CfBOeiGgcYK8+GserD+Bn8CyEbvhaWLpGuuAMjAHesI/nSNHgiPysoHVeHeDON+bx+eG2IN86cmoZMb3ahlOjG8eaRG2WCzy1uGQQSmEajfY5gL9m+AtU1gPYue29Iucar+XDK6P7OThZwBuvSh7vfGG9bpaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z9nLiKrZkTc/whfgI6sV5R/VTxO68tzfjE8klg5fuBs=;
 b=UJzuEuknnSxV4uC5QB49j0BXKA0w5YeXiqATyBeRVOPwCjxwN6uQGe7HFcI/VCtE1mg7fd4O2vPZG2WTezSb/JmqIe6siVx6UfUBn0V+KBe+RfuLkYlZbshMb/sAXesMpuw0DKa2sWcnAOZJA0NtgJIRXbC5CPrzunQZHDw/NXbdf8FVhr6ndukFjJ/cQFqKHDE2J+8FkCOyhXLUN70qvirSMZNWPvI/5e9B+7qa66DF4YXs7FnaZIh/6S9Ft64AmDPqIq/AKcpmg5TxQZ2EcpoklcYVXTqxMmobAQHi/VB3wdq+e8OJG7JNZLK/JypWrw5+fN10WCrBMNShHIOk5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z9nLiKrZkTc/whfgI6sV5R/VTxO68tzfjE8klg5fuBs=;
 b=fbPab6wUtbTMl8VAU0mLjuxw/hGf+O57HijaCYHZoCfec6PdEijpGqWIL6iYbVXyyCIodpuzc4OqbE6AEAlHGgFnu0tX5o6BSTMX5GelyYm0iQLZ6qjqQmeF4YfYSJoCKjPhCOjvdyXkU6cWQsGSVL19pYR7tkzXgjvQhE3zYvc=
Received: from BN0PR04CA0019.namprd04.prod.outlook.com (2603:10b6:408:ee::24)
 by MN2PR12MB4173.namprd12.prod.outlook.com (2603:10b6:208:1d8::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.28; Fri, 21 Jul
 2023 13:17:51 +0000
Received: from BN8NAM11FT109.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ee:cafe::63) by BN0PR04CA0019.outlook.office365.com
 (2603:10b6:408:ee::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.28 via Frontend
 Transport; Fri, 21 Jul 2023 13:17:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT109.mail.protection.outlook.com (10.13.176.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6609.25 via Frontend Transport; Fri, 21 Jul 2023 13:17:51 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 21 Jul
 2023 08:17:51 -0500
Received: from stanley-test.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Fri, 21 Jul 2023 08:17:49 -0500
From: Stanley.Yang <Stanley.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Hawking.Zhang@amd.com>,
 <Tao.Zhou1@amd.com>, <YiPeng.Chai@amd.com>, <Candice.Li@amd.com>
Subject: [PATCH Review 1/1] drm/amdgpu: Check APU flag to disable RAS
Date: Fri, 21 Jul 2023 21:17:47 +0800
Message-ID: <20230721131747.608514-1-Stanley.Yang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT109:EE_|MN2PR12MB4173:EE_
X-MS-Office365-Filtering-Correlation-Id: e8a759e5-17cd-4140-80f8-08db89ece2ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8reytf7kJuZ7uUh2Mq5uaIuxo9krUPftEzIjBR1+hZNFfsXMVr993+0R82IShSCV2YfzLqoEushzIrHIf65LIe+kpidA0Gpyt+LeGXIdAPXNcPkSxWZnESTiRZ5pvr311fSlovqaugFJIhWc+D11cxzDUI86wn6m1RWRChoOtuLL/M8CEc17wi2Fd82QZyIsrxtZOaXs8b8UsBGbHl19aGTPZ43XDZAez4s4kTQV8ZCAqW328pw9xYUB/oKWSdTsxVLngozunwDXTOmrgvhFYJcvy7ZdMSBgk7FK9RqGKHOJZx6Jfr5I2gv3TeuRMKJEWm0OC74FUJjkezV+VP3EOv8TUUPqQaCcZTNwzZIANiOEncr4lhsf8EjBNczjTIdIst76JhKvNxsNGZJ59nXPFazUXn3N77K745gSA3rAlGJmXGY7S4WSrZaOn2P6cq2cJxsrHkWk2z+mUy4AfKGKR2F4RmeBoo0czCCMoILRL/ALHta7DhyIcYjU5y0ySw2WMmZYCFdHxMQazzzvGkPCHO377MXmiMz6RSPdstthyaLXXgtN8L3MAn4lelke18tuqrO+xWYjIi6dKs8u90JuehE3gXrC7TIelOaXO+KoVoZ6KkOeRcsJrt26kf7MTgn6xVLewAw6xSZqmQw1Wi5p6jJ+Nj6C03AwPqEyEEHAs2hBQPAJnHrXSig53g38s0ioDCQN+Z1HhOQIPjRZozSnA9Rt+i6nF5jETU3S5KdvJl+7pIHcaq4K00HeMrXQRTQi3HT5Te40yVhvBMUE6w1SrQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(376002)(136003)(346002)(396003)(82310400008)(451199021)(36840700001)(46966006)(40470700004)(86362001)(7696005)(82740400003)(81166007)(356005)(36860700001)(426003)(2616005)(2906002)(4744005)(83380400001)(47076005)(26005)(40460700003)(1076003)(336012)(40480700001)(186003)(478600001)(8936002)(8676002)(70206006)(5660300002)(110136005)(36756003)(41300700001)(70586007)(316002)(4326008)(6636002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2023 13:17:51.5051 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8a759e5-17cd-4140-80f8-08db89ece2ea
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT109.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4173
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

Only disable RAS by default for aqua vanjaram on APU platform.

Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 2221460e23e4..00a3863a6017 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2529,7 +2529,8 @@ static void amdgpu_ras_check_supported(struct amdgpu_device *adev)
 	 * Disable ras feature for aqua vanjaram
 	 * by default on apu platform.
 	 */
-	if (adev->ip_versions[MP0_HWIP][0] == IP_VERSION(13, 0, 6))
+	if (adev->ip_versions[MP0_HWIP][0] == IP_VERSION(13, 0, 6) &&
+	    adev->gmc.is_app_apu)
 		adev->ras_enabled = amdgpu_ras_enable != 1 ? 0 :
 			adev->ras_hw_enabled & amdgpu_ras_mask;
 	else
-- 
2.25.1

