Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31D3AEB64DA
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Jun 2023 21:29:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD2FD10E581;
	Thu, 22 Jun 2023 21:29:05 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2085.outbound.protection.outlook.com [40.107.237.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8BB1A10E580
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Jun 2023 21:29:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y28kZXFoTK5Fec1hxXKcx+lFaKZNGgPdAHBw1h8bdDl99IILtblLDy/wtikfEoCuWqyeOIQcu7P1WBaV9Vjvx7/UktqXGHPg9xgXxxsMfwEASzjiIq6BROoczCsKqSyInEM3xK3KJPQVYV4an1CQouRssF5ZcNgigxZzXqulL+cp8/DuEVqjir/fDIQ8vKPOz/KndsvVT0HsDDg1QIbQKniaVnmY/1jHc5PH7ezuasBNDQhmRQk2JOebCfCpSx6zT5KgrWYiRtKh1fjrSfZIg7jhkJ2kH3GY53fZ+4B7yphR4zhmBDoFNNOe5SaJMgsAmwC6Ccv6DsAWFutR3OG7Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hie7qc+qO+TndShnm1zpLRNnyReFup6E/LFM2wg7s70=;
 b=W+nwtI3O5mYijGaw0gQf7QrEY4qUEpj8cq6cmxJ16VU7l5SIrCCxcNHP8TSU/JU4CCun3HsdQt9zkVj7AWqYRLjJfRd3HCto6hdBIH+S6+0ZIBAWsyZrXcatL3Svwsb02kvImABoTNf72MoHsnt6+ogFWqGKufnbQPWC3oBxZ2sS+EWGX8CCXYKr5HptG+fRQMv6TzceYvhPviaaj9dibo5pW+WOBZiQ9OPKKQLJnnKsXM967quroGYpiqZbcZAF5KsNck05ttZopQ9VJ8ytVDZwsI+nXQZTSswDIg8SgxMZepr+d+OzcMSrMkqfkyAVxK4NjyJqPEQrkkL+NN/LAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hie7qc+qO+TndShnm1zpLRNnyReFup6E/LFM2wg7s70=;
 b=q07AiMhnazgmE41QUmWKXRxg4uSOOfgs43KD9uyx4jlYWI3TRVRcrtDwPC73ABr5CSVmct9q6z2MBw4gc0PZNbm1dtzz9QjnAOKaSjjJX/ziQdq3NNzVlPZbdxy0XRMO5l8pkfDzNx7vSlEqJfF+lKz3EWQ82v3+w/I/OlqA4R0=
Received: from SJ0PR05CA0151.namprd05.prod.outlook.com (2603:10b6:a03:339::6)
 by DS7PR12MB6142.namprd12.prod.outlook.com (2603:10b6:8:9a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Thu, 22 Jun
 2023 21:28:59 +0000
Received: from CO1PEPF000042A7.namprd03.prod.outlook.com
 (2603:10b6:a03:339:cafe::d5) by SJ0PR05CA0151.outlook.office365.com
 (2603:10b6:a03:339::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23 via Frontend
 Transport; Thu, 22 Jun 2023 21:28:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042A7.mail.protection.outlook.com (10.167.243.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.23 via Frontend Transport; Thu, 22 Jun 2023 21:28:58 +0000
Received: from mukjoshi-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 22 Jun
 2023 16:28:56 -0500
From: Mukul Joshi <mukul.joshi@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu: Correctly setup TMR region size for GFX9.4.3
Date: Thu, 22 Jun 2023 17:28:43 -0400
Message-ID: <20230622212843.1595336-2-mukul.joshi@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230622212843.1595336-1-mukul.joshi@amd.com>
References: <20230622212843.1595336-1-mukul.joshi@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A7:EE_|DS7PR12MB6142:EE_
X-MS-Office365-Filtering-Correlation-Id: 17ab6b30-0a06-44ea-f2ca-08db7367b0e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dekOMhDknryayGN4QJ6pQt2wskQoxLuJqlpJ3AQllTsitp1xDYJVYID1XVNpfMXbpfU6NDPzQunzkzGrELeF55qIv2jJ5b1UBlJTCE3z6FQQPlDpAAiBAdwKEUd3TnHqy/oaa7czNUI3Q90k+yUQpXUX1QCLGtpRYR0Ogkkgdd/BpYcfe9P3Pit99c3VZtfKzsia1gf3zIt/+90Q0VpNvZMvwVG90a1395l8nvXjjY6yb0zhPX6OycnYKJ/f60CyLTGZ5eu9uiXctfsXhohg1cOxqqlwpPhDsmZhg6Ej1srlBF5w39mnOtmRg9pQS0VnLQGgXmk5nPnMOswdF+ORgKX+DNdREBv8sS6FhBfSIHZNneB3Ht9s9bI1Y7psDuQxll1NJPt4CtwWLwLeXJdwbEkzrHId103sokjyHiPOgD4TMYC8V+4xA50dq2K53KVWL7b+GUiBZll7QQlu11WVmJqeRm1MU04PFhAKQJUm++B0NXv0jhjZUx/z5oysfSoUMsJ/nZjbVf56hsiTWRY7JwjkJSP0WVOfZlcaP8c9RHxwAwpbi6PNKQfVvnZYMQDcZANz8ks1TvYWWUrgm6v0oWXjHDv6HUZJDU+iM3GjqYDKhhkIE2NaHWestNTars6E5WIferMTvqn44R1yG0g1DvBdj4QqPhcyhb7x4YU7t4ruYilDHDByWMZGavISlu8wq5HEIcQPWLUzXo8xmG0zWD3LRJMRQ4dDnQD7gfHQD1VJxQjohOsucBly5P2IOwGFmmqszzLzAiUjhD+m3s3Nxw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(136003)(396003)(346002)(39860400002)(451199021)(36840700001)(46966006)(40470700004)(6666004)(7696005)(83380400001)(82310400005)(186003)(356005)(81166007)(40480700001)(1076003)(36756003)(16526019)(47076005)(426003)(2616005)(336012)(36860700001)(40460700003)(316002)(70206006)(6916009)(4326008)(70586007)(4744005)(2906002)(8936002)(8676002)(26005)(86362001)(44832011)(5660300002)(41300700001)(54906003)(82740400003)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 21:28:58.8286 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 17ab6b30-0a06-44ea-f2ca-08db7367b0e9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042A7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6142
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
Cc: amber.lin@amd.com, Mukul Joshi <mukul.joshi@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

A faulty check was causing TMR region size to be setup incorrectly
for GFX9.4.3. Remove the check and setup TMR region size as 280MB
for GFX9.4.3.

Fixes: b6780d70db5e ("drm/amdgpu: bypass bios dependent operations")
Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 7c6dd3de1867..fa5721b3139c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1718,7 +1718,7 @@ static int amdgpu_ttm_reserve_tmr(struct amdgpu_device *adev)
 		reserve_size =
 			amdgpu_atomfirmware_get_fw_reserved_fb_size(adev);
 
-	if (!adev->bios && adev->ip_versions[GC_HWIP][0] == IP_VERSION(9, 4, 3))
+	if (adev->ip_versions[GC_HWIP][0] == IP_VERSION(9, 4, 3))
 		reserve_size = max(reserve_size, (uint32_t)280 << 20);
 	else if (!reserve_size)
 		reserve_size = DISCOVERY_TMR_OFFSET;
-- 
2.35.1

