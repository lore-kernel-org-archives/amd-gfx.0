Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96A0BC433F5
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Oct 2022 04:29:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 884C310E913;
	Fri,  7 Oct 2022 04:29:42 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2069.outbound.protection.outlook.com [40.107.93.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C02A910E913
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Oct 2022 04:29:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HZL+79gpb/xtAIJBfEUvg3UWL06nOiU5HZKZ7c1JqeFRpk00xQT2LEwUjeEyvJrNn70Zf3JAda44JzM8B1kq12eIQxk4HJmiF8HcGdZpVK7BjkcsEbnKBhuYAjxurV4hhdg7c19zARQ1gR7yi29uehmvBW+DmswTRzkV7CvTUS7mcICusKmdNVU8v+ZLvIRQpnt7kjcKgjQTNgXInTfgwY1LHW4029dSx7PJkP6hpn45isMuQNdOfYuF7oK0SNUD5zSd/8snP+vhgAzRIQen1k6mK0Eyh1eMi7TgGNfnyCxTKDuwpJwE6jm+GTJK6nO8jCKch5Z7Xnrhndrkb6O4vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lagrBcGyrE3wDpmMXLMlwModzlUdhnAQa33ZRASNF6k=;
 b=SYYiqM/jEqhPznBTSDb4rD/fc+Kr3v3fsk2Db9CsfKHvgT9gY0xp1Z5UqmymZHLkKcYpLappKJi7YoOBJ/wpC8Ebtuv2/m18IHRdUieDbcxQxsl2VhSpwKUvtOrIFAs33WAjpTHwye3wNMCv98TLHPkT8djQHIJb5vowAwqivdRQ9P6WwbGCyLA1KYAepW8EmKWff1WiZXoJwaKP/uizAovHcRf8RxOa+Z/g71VgzrP2ii+p53wc6/Zn7kTxsWDocDvLITxNhqLBhVMWQxbMc04ngUcV+2V6I3RqNGfwQ7MkHzlp0G0XrQtYrgynQhFgWYiOrBW8vd/s0YOS3nCXvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lagrBcGyrE3wDpmMXLMlwModzlUdhnAQa33ZRASNF6k=;
 b=pwDcJl7xjkIQ2s6RxQfgVhoIYafGY05kMsGfy2tO46ILnxBLYMSgyZQZV5pfkpXA9dcrih1XEMKDBWAF0HeqoCszKut62t+1ZMZJBSmnSKNOuE2Vk1A/gynDeLJRpseGoJb65P8ruBVtRLqhKfEwsuAwri2cg8X9oLJsdy8eOYA=
Received: from BN1PR12CA0021.namprd12.prod.outlook.com (2603:10b6:408:e1::26)
 by CO6PR12MB5395.namprd12.prod.outlook.com (2603:10b6:303:13a::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.28; Fri, 7 Oct
 2022 04:29:32 +0000
Received: from BN8NAM11FT074.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e1:cafe::7f) by BN1PR12CA0021.outlook.office365.com
 (2603:10b6:408:e1::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24 via Frontend
 Transport; Fri, 7 Oct 2022 04:29:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT074.mail.protection.outlook.com (10.13.176.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5709.10 via Frontend Transport; Fri, 7 Oct 2022 04:29:31 +0000
Received: from llvm-tr1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 6 Oct
 2022 23:28:48 -0500
From: Shirish S <shirish.s@amd.com>
To: Leo Li <sunpeng.li@amd.com>, Harry Wentland <harry.wentland@amd.com>,
 Roman Li <Roman.Li@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amd/display: explicitly disable psr_feature_enable
 appropriately
Date: Fri, 7 Oct 2022 09:58:19 +0530
Message-ID: <20221007042819.119692-1-shirish.s@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT074:EE_|CO6PR12MB5395:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a49b653-f570-472b-2980-08daa81c87fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fihHBUv1cifGuCWDhZN2F1KL3Yzr1nJ7XECyw4ZHHxq8ngkuAnm1LQTxF4/deutzlFMvp5X7N12kHk6CO6rcujitipzynZTLZnBiHef1Fbc6OmGbbUmY2wjtvnfLAMJLT8iQ9bt9gIBwklO6yLB2NsqP7Yko3EbaLclZglH0dxn9U/1yY2GXEau7UhtjA+V2ufqCw9eq428aeOZ2AcE5SEu19rFHvjJ8ibpCQkaL3T83bBGXMe5XeijuQdF3w51ugXdp4YDq+WM1JIkdrbV+8Mmht5hbhzOajZwM64cdpy30+W19aKcLzbQvrVZMEzOCKMNRKgY0tzkt2eM9MKCCnTCmXtOHfSz6qQV6dQU78MMGEiT8+plZ9K0YTyXESBkm4J2L7vKD9NujzizlzNb11ABOrg2cABLeA+9hnC17kXzqF4RWnw4l0jidjuepKHpzDNJV990Qd8aHFyHkGHYstV3h2x+D/RxsNxCKZpZWXjiEeWRT03skkjAhdnyAoaUSz3oD1RB2gUFldPzNa2Kr/UGsHioSc0eYPcn/QtvBzbpijCf2eA5flCSMZdiBZrZanZvvwIgXAGVLz1pCkqEAgRKWcQj73twHg3vjEzf57Sn5MDmztJVmM95d7tBK46THqtF2D3fzjmtdOq7jTIQY/ULCQhHCNhlIxo9Qb/Nuqnlp7fxuCu7oQqgQMadLLwoAfywdFJiHx2cWYdwZKudvXXQwW/fy981nBEwzwgXnojr2HH710EUvwMFw8dK8L3sV2lS8hRX140UihsxeISy2K6qfH962UlAU0ipgp2e+kVNvQQfOH9v5t+gg1kVKsUNH
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(346002)(136003)(39860400002)(396003)(451199015)(40470700004)(46966006)(36840700001)(316002)(54906003)(6636002)(110136005)(41300700001)(5660300002)(8936002)(70206006)(70586007)(4326008)(8676002)(2906002)(478600001)(82310400005)(356005)(82740400003)(36756003)(7696005)(6666004)(26005)(36860700001)(81166007)(40480700001)(40460700003)(86362001)(16526019)(83380400001)(1076003)(2616005)(186003)(336012)(426003)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2022 04:29:31.9853 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a49b653-f570-472b-2980-08daa81c87fe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT074.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5395
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
Cc: amd-gfx@lists.freedesktop.org, Shirish S <shirish.s@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
If psr_feature_enable is set to true by default, it continues to be enabled
for non capable links.

[How]
explicitly disable the feature on links that are not capable of the same.

Signed-off-by: Shirish S <shirish.s@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
index 8ca10ab3dfc1..26291db0a3cf 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
@@ -60,11 +60,15 @@ static bool link_supports_psrsu(struct dc_link *link)
  */
 void amdgpu_dm_set_psr_caps(struct dc_link *link)
 {
-	if (!(link->connector_signal & SIGNAL_TYPE_EDP))
+	if (!(link->connector_signal & SIGNAL_TYPE_EDP)) {
+		link->psr_settings.psr_feature_enabled = false;
 		return;
+	}
 
-	if (link->type == dc_connection_none)
+	if (link->type == dc_connection_none) {
+		link->psr_settings.psr_feature_enabled = false;
 		return;
+	}
 
 	if (link->dpcd_caps.psr_info.psr_version == 0) {
 		link->psr_settings.psr_version = DC_PSR_VERSION_UNSUPPORTED;
-- 
2.17.1

