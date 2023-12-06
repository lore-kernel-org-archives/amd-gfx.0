Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAD83C4167B
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Dec 2023 19:39:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A7CE10E0F4;
	Wed,  6 Dec 2023 19:39:26 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2066.outbound.protection.outlook.com [40.107.243.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A76F10E109
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Dec 2023 19:39:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BSiLOo/A8gwtsfVdrwHQltOQRvBikVoYBYiCmyTrTUpFlYED/HUBvA1204ySEUIOZQ840q7I8jr2Lep/2mIcXpQS50HKbQDzlQ+nENiuk57SoINiFC13zIhtwvpxVZXc85uVT0KWBME1eVXZo3WL52kewZOjxB01WFF7pRgfHUA03aKb8sT18NPiqAg1JJUM4CALCH78ETwZ15VhmGDGk2e0w4G0pAuolM4AA5XzsokB0qkMkXbQegKUkyeVju2AGo3Nvi5KDueGwfLya9Xjq9rKto1riPS7XukHaJvc8K+ruQ3oywdl9/DXibPseZdNCqrga5NQSQRWt/4KB91rcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K2lVd7Ta/OPBzdR+uIcqrPPRjSaPEb9V292bbHd+nLE=;
 b=KfViE6qEvW7r2BaO9rqXAHr5InzZ8btbcucrjNSSU9Cgr4IFwtWV346Xvgk0RYz4dqrokqsHMR0xMSxnrorUYwBpEX7xqcCg5HfbYbSmKRmSZm9rEmbZmpbQ4/xeS+hl6fBKOh3WTwl6bgAwqXVsuZwmOHwMdYY+72vjclxBhhREwwh3YyrSoauaiJ7q42WWMhgK6aY2/Jb4xymZRCd9W/zRo8eXGVyWMBs0Xaz/zuEYLZCLVHJp7HIKOcRZEXt+lsVpfoQmfzC7e60qR/tiHmeEgSFoNg4DsR/SGJI76SnUmJauR6tkcgcjnhZ9zGC6sKDnZZrI9EeLtA0r81V+MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K2lVd7Ta/OPBzdR+uIcqrPPRjSaPEb9V292bbHd+nLE=;
 b=veSfcR/fsMSG3MRVuq41PKDFgbSzl76y9reVd/27JQmQsJL6gdnTnoNWhOj+zCgyuMMs4Wh3qaZnlavZQ7GU+Qj5jWFD2zEkbu7mFlLOSsEMNv6Buv2y5shJZO/Ap66jCFnYkPvCSn0MWOAjv2h2daR8oB9IJKqFJJdEOxoJsoo=
Received: from BY3PR05CA0034.namprd05.prod.outlook.com (2603:10b6:a03:39b::9)
 by MN0PR12MB5788.namprd12.prod.outlook.com (2603:10b6:208:377::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Wed, 6 Dec
 2023 19:39:21 +0000
Received: from CO1PEPF000044F0.namprd05.prod.outlook.com
 (2603:10b6:a03:39b:cafe::42) by BY3PR05CA0034.outlook.office365.com
 (2603:10b6:a03:39b::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.26 via Frontend
 Transport; Wed, 6 Dec 2023 19:39:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F0.mail.protection.outlook.com (10.167.241.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7068.20 via Frontend Transport; Wed, 6 Dec 2023 19:39:21 +0000
Received: from lsttdev4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 6 Dec
 2023 13:39:20 -0600
From: Dmitrii Galantsev <dmitrii.galantsev@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: fix pp_*clk_od typo
Date: Wed, 6 Dec 2023 13:39:03 -0600
Message-ID: <20231206193903.14623-1-dmitrii.galantsev@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F0:EE_|MN0PR12MB5788:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c6b6c7f-02f5-4f76-5769-08dbf6930b44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RzlFrGogeT85CiM+tHVWrKfoFVzj4dEXsYYo1aHZ6e5Dn4c4bDQe/t0ceaby6T6BK+xjr5JsZrqREj7v+oHa6mykIeBiBC+Fu3Ct2o4Y3a1GthOXRvXumj5t6Lc64LzaafOKEUedooxPbaGse+OpSQbjAIPmsYpvOjDSWMxS90mKMYShdVfEuf48y8zzdzYcFCb1cQK1asETJbFV5hgV0woWGxI6ABaKeoUQggXPSb2WtpAOpSykkv93P4tJXry971/4P38EPb9BLUIe9uWosAEKRmh+zPfzlzIurChY434IBh+3Vsj2eu+AkwZebhKUsa+fCfr+95YNrN6j9ogSiSlljkum7Y51t+aC47/X2/OjSuKX/doX7ZY/tJnXR2Pu26svPYPxFi+QvIWMTPxiZOJ7unWvoXUAL3tVSlCOrAgnLeDzLJm8DTHw/JAzdCvcsLbRRS8XxhK0tMCtZwwIG6s/Jd07XJRy6XMSnKQWoscXpk5VWSVyqcf/XU5P1TTJCop99WYkO2N1AXNl5VL3+uMPEBNu60TnSvq6UpEieqQi8LnlUHWn/7fdsQk92VupoLUm/cVHYM0tqLH1CvMGSM2nD858yoAoacToHCZMqnCD9v7ONrr4k8femIrfocjZBi8xIYc5Dpg0CHrzhQr3P1vPSJpWF9SMp2KfDWNNcFweM44MBZqOm33GdhFYpHNqSkeYqoyxhPzMPCedpCOcQBbIBfRHwJ969wYgt0Rrg1V7MpLIkre3GgSu5igoPsJE2PvZCbLQVrp8CSu+lluvmA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(346002)(376002)(39860400002)(136003)(230922051799003)(1800799012)(82310400011)(64100799003)(451199024)(186009)(36840700001)(40470700004)(46966006)(82740400003)(81166007)(356005)(478600001)(5660300002)(2906002)(40480700001)(36860700001)(47076005)(44832011)(40460700003)(83380400001)(426003)(86362001)(26005)(1076003)(36756003)(2616005)(41300700001)(70206006)(6916009)(316002)(8676002)(7696005)(8936002)(6666004)(4326008)(70586007)(16526019)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 19:39:21.1148 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c6b6c7f-02f5-4f76-5769-08dbf6930b44
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5788
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
Cc: dmitrii.galantsev@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fix pp_dpm_sclk_od and pp_dpm_mclk_od typos.
Those were defined as pp_*clk_od but used as pp_dpm_*clk_od instead.
This change removes the _dpm part.

Signed-off-by: Dmitrii Galantsev <dmitrii.galantsev@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index e1497296afee..2cd995b0ceba 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -2238,10 +2238,10 @@ static int default_attr_update(struct amdgpu_device *adev, struct amdgpu_device_
 	} else if (DEVICE_ATTR_IS(xgmi_plpd_policy)) {
 		if (amdgpu_dpm_get_xgmi_plpd_mode(adev, NULL) == XGMI_PLPD_NONE)
 			*states = ATTR_STATE_UNSUPPORTED;
-	} else if (DEVICE_ATTR_IS(pp_dpm_mclk_od)) {
+	} else if (DEVICE_ATTR_IS(pp_mclk_od)) {
 		if (amdgpu_dpm_get_mclk_od(adev) == -EOPNOTSUPP)
 			*states = ATTR_STATE_UNSUPPORTED;
-	} else if (DEVICE_ATTR_IS(pp_dpm_sclk_od)) {
+	} else if (DEVICE_ATTR_IS(pp_sclk_od)) {
 		if (amdgpu_dpm_get_sclk_od(adev) == -EOPNOTSUPP)
 			*states = ATTR_STATE_UNSUPPORTED;
 	} else if (DEVICE_ATTR_IS(apu_thermal_cap)) {
-- 
2.43.0

