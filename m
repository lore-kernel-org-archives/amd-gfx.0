Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE213C00140
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Aug 2022 04:14:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A5544A0553;
	Fri,  5 Aug 2022 04:14:39 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2040.outbound.protection.outlook.com [40.107.237.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A623418A68D
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Aug 2022 04:14:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HPoJpLb2/zT+F0wro4v7+qjPvunKEKtj8m6p0RAd+cnH0YjrWLva9KHhdBTs/1BWhJdiLxEP6nBx87icFqTszy5ccU9Afn9+MUeyWBG3dmurJSAVX6MrfYZq2SXivWuyih/3aPj6705xK8sdK5JmmEyakleoDvPoLdMNRggszXTmB/T3IG+j/PVvzTuLBygUNTOne+YcGgXnQeXTpUtrHqZtCteA3HWHVSC8kYbuqMkmK/SSREuy2Rd+FHZ0K0gmdCInBX3Q6fb+RLAZBH5ipYYvBNch7GJjxsjrumz/ReYdlmOVoquLi5DPkQYYAIYmnpPOJTAHFw0/uu32MziGnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WBDnkOoF1SUUx3AvQryyt/zEKtLn7s1J8ykq9i3cIq4=;
 b=nmdWsREKEs5H1R79vNZZmj0sftx7ggT3dQJRele/j2HmdvmlRk3tsmiWMMAcNPK+Gqc8segyOFCq98oJyir703SYIrcjAZi898bAjyAHScoLqvFXdi7v0JZCI/z9AJflPI4MjPCl5bbP8DA4pQp/Vvp5FE5fWZM0xA1xM94ZmwVAqJ7+iHvc3P2omc9VrN2bIylEhlfdaEZRp0YuHuK7HqsgHxjY2Rx8TfEyTDAlSJseDPZMdBLoDc7+0qHOzc5+pyM7THp5zghXFsgh+BorGCOfkykmBidGXbCf4VM7esQ6aJ91rFM9hwa6Brl9so52K5n14+CAyYCqEnr/y+zkXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WBDnkOoF1SUUx3AvQryyt/zEKtLn7s1J8ykq9i3cIq4=;
 b=4PTiIiLBNHGIz5qq5F/k0P3UILdFPwbc+S4CznZGSyqd502cHjvh6ExWAUTndzJdfJDftyiyHciMFsPmgrlme03zSGSDw6VOp26IZcJxbsRZ7mZYmkoLiYlvdlQlUt5Bqnvz5HeRjUWadPVSoD3mVjgfsPColWKTV5D5MnMjVCk=
Received: from DS7PR05CA0007.namprd05.prod.outlook.com (2603:10b6:5:3b9::12)
 by SN1PR12MB2349.namprd12.prod.outlook.com (2603:10b6:802:2a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.15; Fri, 5 Aug
 2022 04:14:25 +0000
Received: from DM6NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b9:cafe::db) by DS7PR05CA0007.outlook.office365.com
 (2603:10b6:5:3b9::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.8 via Frontend
 Transport; Fri, 5 Aug 2022 04:14:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT067.mail.protection.outlook.com (10.13.172.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5504.14 via Frontend Transport; Fri, 5 Aug 2022 04:14:25 +0000
Received: from ldev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 4 Aug
 2022 23:14:19 -0500
From: Tim Huang <tim.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu: enable GFX Clock Gating control for GC IP
 v11.0.1
Date: Fri, 5 Aug 2022 12:13:27 +0800
Message-ID: <20220805041327.2621649-2-tim.huang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220805041327.2621649-1-tim.huang@amd.com>
References: <20220805041327.2621649-1-tim.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 74f1fe84-bfc9-41f7-4f2a-08da7698fb71
X-MS-TrafficTypeDiagnostic: SN1PR12MB2349:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xBGgJXu2noM25f1z1oX5QVPHAYc60D3Q6STo8yiCsWh3R1/ZvsSXSi/x5MJhvHPgQ7IZGPCxZ/NUbSQkNyshr2E9K0+u1B/mcg8h9imPzUap+b5BW8Q1Khy0NPLATuYeYL5cc6fo6RWi6WKhdJyl24tvoogibAjfHfk7fUtbCRbGkeo1dOvnAUS0dL34cDi/cbCqQ2OU1OZ+yByNJxu0enkWkjphgse3Wcdx8wjCU5zZLy96MFvbJJfjudhXTwB3LPrRZxeTCvl5cqBQk7oUQoC2RuQqKf2rnxQJdMBcB7DakcVgUgEoawahtUk66cRshOHAlfWpAIIl6GHK0B/DCRwFHgnAymWpcdMYSow3o+8RJWZsf8Dz8or4G5Hrw6kpdQTaqnpvwB63O93rUgu2VUxWcXtiYTmDzTBW1otckZRftEvZ25B/vVocfRCSw1zLeH4hRe/tvjuqTmRJWKv/YWCBZyDmVJTwJnl72xdxzw/hGnyUR1x9i5auunkKuNHhlzR/LJdKsnaprKjjNNQHV0H1NKUpaAXL3ZY6xZL0r6Bv8Y2ndYaUjcs6bQ17r6DZRtRo2/1pZKtpvC1LZcpSjnSJeghh2h3sVnLnZuT0aqOBRDlpK9RNWwvo5OTKNeZC4Fhgpmg9TIGGx54lJutLY16OhULC8xucwY6aolPdAzuf1vpqrDtsInGO4Aw64MpqcV/R9b3WHcKwH9mD95xH+qqFgftkBbt4lby1UumVXUOfFl9yuGydq6buTMk+BtlHZ2dQjq0ZtFw1e7oq/zpeZB/VLrenec6KgPShVofWT96UU8GX2bDE+MfR//jbFkd1CTOZf3oWceFe34pUZi7C9g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(376002)(39860400002)(346002)(396003)(46966006)(40470700004)(36840700001)(316002)(81166007)(1076003)(70206006)(86362001)(54906003)(6916009)(356005)(40480700001)(4326008)(70586007)(8936002)(26005)(8676002)(7696005)(6666004)(41300700001)(186003)(47076005)(426003)(336012)(16526019)(83380400001)(2616005)(40460700003)(82740400003)(478600001)(82310400005)(36860700001)(2906002)(44832011)(4744005)(36756003)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2022 04:14:25.0866 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 74f1fe84-bfc9-41f7-4f2a-08da7698fb71
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2349
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
Cc: Alexander.Deucher@amd.com, Yifan1.zhang@amd.com, Xiaojian.Du@amd.com,
 Tim Huang <tim.huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Enable GFX CG gate/ungate control.

Signed-off-by: Tim Huang <tim.huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 6fd71cb10e54..e03618803a1c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -5310,6 +5310,7 @@ static int gfx_v11_0_set_clockgating_state(void *handle,
 
 	switch (adev->ip_versions[GC_HWIP][0]) {
 	case IP_VERSION(11, 0, 0):
+	case IP_VERSION(11, 0, 1):
 	case IP_VERSION(11, 0, 2):
 	        gfx_v11_0_update_gfx_clock_gating(adev,
 	                        state ==  AMD_CG_STATE_GATE);
-- 
2.25.1

