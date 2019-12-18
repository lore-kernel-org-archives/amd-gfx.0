Return-Path: <SRS0=4PMp=2I=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EE1CC43603
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Dec 2019 12:14:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 447122072B
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Dec 2019 12:14:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="nI+a3nLE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 447122072B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F2E226E2E5;
	Wed, 18 Dec 2019 12:14:30 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2060.outbound.protection.outlook.com [40.107.237.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B1B56E2E5
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Dec 2019 12:14:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hHRm8tsq9iRM7ao8OoD+HMrma6CAaNeJiEm3nhGPZ0vYLZFavA7SHyRu3qQLO+A7en1M7fE+0SEfay7HAszKkd01ndi5K0RQrPRo3evvN4xprVyAQQKE0Pu9G1De4SDdj1Tn5ndXgnSHD/fLKkijmGHoTSRGeDMhOAaoGBTwREttUFg7G7qFpTxBvBDukdkzzyQmTQywK4ieq0v/EDzzrnajrwqfxoTTJhL+a11CXNpcYnOFfQIH9oV1dc+Zr3JU/N4sfvFMMozzPxcFSoxlvMY3Got9b0nJJco3Oh3XPbYVc80mXQ+DizRAQmb+EfFetcYCaI58QKfX8+rtn/9MDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M2hyVkugHQNmM9LpC8KsGIBMbpOf1gA/3H3l4JEvfRU=;
 b=LAjIRUltmGfL9/2VUpl5PnPECsrxtdL2MR07+xsYGXZvMT1ACuM4UUUAl4pNhv6Avm8ZCxCPwCkL2Grgbn5JH+a8qNqcpw0/3isAz+LVRliPgulwL9Lrwe1bkHIUrQjDO1SrgyY95wwjtImMlgNOEvV7/XSiyii0FWIp8flCDJeT8YhCm3033AlQFMOr0YfTMoW2rjJBjjxfgpk0R8thWdY7TWs6eMGG3RRdUzVsSoVgsZHd4SgxTYUp5Nsxhye9GU0IiS96wJdOiwpZ10AvGT3mbo3R1XeCwQh0fbv+Sp0q7VnI8Z5b0f4x8cTnNmb4PrnaQgk5g3XU4gIGAEKfMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M2hyVkugHQNmM9LpC8KsGIBMbpOf1gA/3H3l4JEvfRU=;
 b=nI+a3nLExZjaPP4DAoEtATMFZynq6HPgu0w/XchmEirPvWaP30yrWSbnc4g2owzBQTzot6TThZ6sztMbdJvB/GkVhZ4+1MMTEYqwSsM3oiHWWtfrYxfptWieq0OnM594cT6swn8hfPrw3OpXfD+ec5kzDpT5j8GlRxrEHjPXB+Y=
Received: from CY4PR1201CA0019.namprd12.prod.outlook.com
 (2603:10b6:910:16::29) by MN2PR12MB4334.namprd12.prod.outlook.com
 (2603:10b6:208:1d1::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2559.14; Wed, 18 Dec
 2019 12:14:28 +0000
Received: from BN8NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eae::205) by CY4PR1201CA0019.outlook.office365.com
 (2603:10b6:910:16::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2559.14 via Frontend
 Transport; Wed, 18 Dec 2019 12:14:28 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT020.mail.protection.outlook.com (10.13.176.223) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2538.14 via Frontend Transport; Wed, 18 Dec 2019 12:14:27 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 18 Dec
 2019 06:14:26 -0600
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 18 Dec
 2019 06:14:26 -0600
Received: from vbox-debug.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Wed, 18 Dec 2019 06:14:23 -0600
From: Frank.Min <Frank.Min@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu: enlarge agp_start address into 48bit
Date: Wed, 18 Dec 2019 20:13:28 +0800
Message-ID: <20191218121328.31759-2-Frank.Min@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191218121328.31759-1-Frank.Min@amd.com>
References: <20191218121328.31759-1-Frank.Min@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(346002)(376002)(39860400002)(136003)(428003)(189003)(199004)(36756003)(86362001)(6916009)(478600001)(2906002)(5660300002)(7696005)(8676002)(8936002)(26005)(70206006)(316002)(2616005)(70586007)(4326008)(81166006)(81156014)(1076003)(186003)(4744005)(336012)(426003)(356004)(161623001)(147533002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB4334; H:SATLEXMB01.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 187f5bb2-c7f7-4e32-96e0-08d783b3d41e
X-MS-TrafficTypeDiagnostic: MN2PR12MB4334:
X-Microsoft-Antispam-PRVS: <MN2PR12MB4334F4067E085F3CC4133A12E9530@MN2PR12MB4334.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:346;
X-Forefront-PRVS: 0255DF69B9
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AZvzokLZDxvBx7axBv+j4hVF+KwMCY62T2EFGT7dTutqzw9yM2Sa0IVoDEqT3ossW5JYx8O4JlbJ5Nn8ObxXaaUMqfbrLagY4kbfLlrme3FkLmXX6d3+knqbx8rjGFIQPDt2y/j7qjfNjnkrT9D9jEoav/34XYaQYyRysUbF7zZOL86G7w196FZNBJDs4c594UrdnZ4jaoUPI0+8VauSpsPmjDVjMBO1CtPZH+1NwXLzAS1lwqyF49Ri7/JN+gUmWGlPOYlcMxxho8kq7KQ/TPsM9HFyxQFAl1TOB3QjFPv6iVaWPfawot4Wa0qVSeVw82Jr4byKrQi8FIjw7IN2fTYhT5CwS82Mayhjj2JWm29S09FvUpKaoJrXI2YnswQxxU29DyfkA6YbdO/5by6SJt5MYdE/oS8m0sUWZC02olIJhGryWFRI4EG+/jIbaQXCOpmYcpIMCjU3YIa8zFSSn0+NFu/FxeOSiBpS/Jp3XLVIfcaR3zQ+z9FU4gpwf8viZ23pctX9n2a9YSIZE9md8w==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2019 12:14:27.6943 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 187f5bb2-c7f7-4e32-96e0-08d783b3d41e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4334
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
Cc: "Frank.Min" <Frank.Min@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

enlarge agp_start address into 48bit with all bits set

Change-Id: I36eb757310fa71555c8355f99f89c89fed306638
Signed-off-by: Frank.Min <Frank.Min@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index a12f33c0f5df..bbcd11ac5bbb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -223,7 +223,7 @@ void amdgpu_gmc_agp_location(struct amdgpu_device *adev, struct amdgpu_gmc *mc)
 	u64 size_af, size_bf;
 
 	if (amdgpu_sriov_vf(adev)) {
-		mc->agp_start = 0xffffffff;
+		mc->agp_start = 0xffffffffffff;
 		mc->agp_end = 0x0;
 		mc->agp_size = 0;
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
