Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7112C433F5
	for <amd-gfx@archiver.kernel.org>; Tue,  3 May 2022 20:37:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 464C310F436;
	Tue,  3 May 2022 20:37:39 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2087.outbound.protection.outlook.com [40.107.100.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 95CF110F41A
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 May 2022 20:37:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ihuTVy7HQu58eDD371igxAR/Tv8Piq7CiWE69CykBvnEYuEYoLF/bvTTmH5S291J29g7IEhkaSD12FSUQ2wUCS7lkJ2r2vJFuTJWoqz+wy+KpVhHZWrOS4NmuoDTrJsxugwp+lhroICgFdwoskGDFX9lJgR5/skS2KcvfUue2VEktzwTIzg1SVYA428UKZUllc2iPq+Q5CeCnim/bsagGbF/7ZBoz1aPXU2Hbzmj/1Ahwx4Pg6E6/+tIrX9eC3WbeyeLgRs4/q9hxgCtUpTst5565tmO9DhYEoI3EbJkWXQNS25MbKXM5bldhrlNEKiDNspN7j3I4apo90VB8Odwwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Z4ZRJfGbzkmMdj+qoI342kTQ+aLaeAhr8BkZ5GEPko=;
 b=i/ob/lw/MSLj+GwPxGdBoj+zcvN+8nx/CiDcAd+Vn53aNnGCU1S90vXNvb1kUBIYb9NS9+OidulvRbsAWCcHfwp9tOTBNM7uJR9VYW9QmJNdvtIs2FjAcdKncf4eRNxQ5Brj5qibL0hCBrhMfY7Mgvd1N9Jl/Tyb1b96BN5NGm4IWh4CZnzq0dhWBzWE7+SozIxrDm/Z74feUpEaEfp//8kZ/1ClOvwuQNrTjeaMlIgKsN+/okWZojP9ngVokb4GR+p+eOLmChV/vZiujaa4nHKPF5OgrciLLrgPbro1R2crs5rTHHZopMTmRBAOj6X3dMrBitRcfy1uYPEdxiK8rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Z4ZRJfGbzkmMdj+qoI342kTQ+aLaeAhr8BkZ5GEPko=;
 b=xvYIOh3aIEBJIjGbP1zTjiiAg9U0BRNLBTpkpufqhAkhHUk3j+9dN+n2juq5iZDs5Jf7myv7C2SXk3OKHzhkegpS/8ksFjR5RjKwUAguwqAeNGXeblIp7IdAUAUCVsy0BwU0VGXYAmJu7s5Owch+GNY0BJI9c/6pWFDZl93Hkn0=
Received: from MW4PR04CA0136.namprd04.prod.outlook.com (2603:10b6:303:84::21)
 by DM6PR12MB4124.namprd12.prod.outlook.com (2603:10b6:5:221::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24; Tue, 3 May
 2022 20:37:35 +0000
Received: from CO1NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:84:cafe::f7) by MW4PR04CA0136.outlook.office365.com
 (2603:10b6:303:84::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24 via Frontend
 Transport; Tue, 3 May 2022 20:37:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT009.mail.protection.outlook.com (10.13.175.61) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Tue, 3 May 2022 20:37:35 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 3 May
 2022 15:37:32 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 08/26] drm/amd/pm: enable link dpm and link ds on smu_v13_0_7
Date: Tue, 3 May 2022 16:36:58 -0400
Message-ID: <20220503203716.1230313-8-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220503203716.1230313-1-alexander.deucher@amd.com>
References: <20220503203716.1230313-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8fbf4671-94db-4d4b-8c05-08da2d44c182
X-MS-TrafficTypeDiagnostic: DM6PR12MB4124:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB41242DD8A7D45D7F842F2809F7C09@DM6PR12MB4124.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wRKSZ4+md4Do0myCmYaPA5C77cXkkEf1JNlLwx/D3iBORhZmv0e/pyxaDO7cVu63vS/JMwUZ7L33wPakdSj2K3ktwoJ2TDTLNG7yERs7iVhY2xr79D6nvOjDw993tHbTGdlV3NymuvHzVTtJtCn8WjCdcmZqvnfOOy3fb870M8KwATzud06jJBLx3dtCkGdg4gpX3ppuNJfytahX6stm84QV+hYX17vIm6q6IEDcB2O/GPAf9B2LDrq7ARlvwhqEoG8/Tq+P62GYsSpDBkxRDutZyI5v2wTVRUpelD6EW+ElYtGPx7whQVF2dEjPUT+Xk/zvH8fb4f1bg8hr51LJouYhvUfAz/DwFQ8f9Jha/RpGKZO8lXVZw3D3XPDVlB4mS7k8Eh5Wlu3w6l2LNQnBMBRX6IBTc7fPBeBD1sJsmC8KOwrQxGsMV7V3cygCnLT/tu/neGkWeydp2GjjwMaFlPag5vwpX2tbbjb9XDDaNHXdPm/2GaJqEGEeoYlPjJb6NJNjrqcnQz6w1igPGSophxmyepduH+DwmJ1Rg73vjwsyjnImOr4PVP36s8GW1NOxSeGbSpVSzHffqhVmlBzFoCqMMBTJiX0zO9TxdMf6mfspOg2BHPIwK8EGTQkrjfHr3tW0A0rEX67/xqacxVAHPudxCz634ZkkYZwa9ePAutZo2kf0FZCkUfUbAIqQOnFJWA4bgeuUn1NxxyW80k3i+Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(54906003)(6916009)(8936002)(4326008)(8676002)(70206006)(70586007)(316002)(5660300002)(82310400005)(86362001)(40460700003)(81166007)(36860700001)(4744005)(7696005)(6666004)(508600001)(26005)(16526019)(2616005)(1076003)(336012)(426003)(47076005)(186003)(36756003)(356005)(83380400001)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2022 20:37:35.2055 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fbf4671-94db-4d4b-8c05-08da2d44c182
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4124
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
Cc: Alex
 Deucher <alexander.deucher@amd.com>, Kenneth Feng <kenneth.feng@amd.com>,
 Jack Gui <Jack.Gui@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Kenneth Feng <kenneth.feng@amd.com>

enable link clock dpm and link clock deep sleep on smu_v13_0_7

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
Reviewed-by: Jack Gui <Jack.Gui@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index 7d994145d028..b2e858e431b3 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -172,6 +172,11 @@ smu_v13_0_7_get_allowed_feature_mask(struct smu_context *smu,
 
 	*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DPM_SOCCLK_BIT);
 
+	if (adev->pm.pp_feature & PP_PCIE_DPM_MASK)
+		*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DPM_LINK_BIT);
+
+	*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DS_LCLK_BIT);
+
 	return 0;
 }
 
-- 
2.35.1

