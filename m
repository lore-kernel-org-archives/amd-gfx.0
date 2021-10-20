Return-Path: <SRS0=xYMq=PI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 393B4C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Oct 2021 16:35:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02392611EF
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Oct 2021 16:35:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 02392611EF
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF9DF6E9E7;
	Wed, 20 Oct 2021 16:35:44 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2084.outbound.protection.outlook.com [40.107.237.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2368D6E9E7
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Oct 2021 16:35:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZKqVHd93p1FCdXyuZFnyvQXULiSUJFt7e6jKrQvtw3XzzJKs7GTYmjhgECUxTATm3ESvG8KWZoIps39trHVuisGkDfuDghmR8goLePXURyqYLH5brT6vVevZSfgLicUty8SrmliOfm8AQglhxNbAJhbmKvFrMszhnyE/Ls+NjTBVtPdu1dFSCRHchle2W9DeEAroWqK9Lr/gcqpyOXE17nj5KzRnUFTC+UEYMj1C7UmyFwx+zIO+U60QbQZa3eM/r4a8WWZIg7cxn8TsdmliVOPXPL2+mvL6AAn2wnpQSxwUz8pHoXnxGvarPuaNxb57Z4HyDRCVqE50hmRLRYkoQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x/e3PhbHE9sxYHxI1ZN25hFmroBrvtEMZCPCsKtmImw=;
 b=MynsRJbGiuoJ3ml4PjFWGbJ9mMWkCum19ADP2F3s88MIMiI2CxD1QHkOjDAhamMY3aB53se0I8Zw4Zh5SUzsyZpPoGBHm2DbMS4hyWWcNDAGpEyBCLS2oKpkixC8ozbIcR8abzgQqexgy3F7LLy5spSYgeVwST4TKe4SaGEmSkZ2kdZigO4/qPAffm5TKZh6ofYIW4hA55vqRDeb8aj3SVJ/qwhvYBy/gnGaCfL2cphvGnd+SsepMS4KS3Mgb1WKNQZHxiMMO6/jTZGu9tdKQLRxfpZmaONbjM7hbrKu1LztArThVjW5JMrix6iK0NlGzVVQsVT5HeM4/7Zqg1JtFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x/e3PhbHE9sxYHxI1ZN25hFmroBrvtEMZCPCsKtmImw=;
 b=gBnfusaAFHPKB8PNvNh7g0QgRyGJG6RM9aZo3pSg4M3m4FtryplJ13osvIBiLzswGCdhKg2zHXngz0pQmxN1y2K8Z5MeHSov3yg1oo9dfdw1kLJtGitb1W2U5cJfqP0daZlgxVT/fSk3f5qdM/CHCEeU0Xih+occigNABV4T60Q=
Received: from BN9PR03CA0162.namprd03.prod.outlook.com (2603:10b6:408:f4::17)
 by DM5PR12MB1627.namprd12.prod.outlook.com (2603:10b6:4:10::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.15; Wed, 20 Oct
 2021 16:35:40 +0000
Received: from BN8NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f4:cafe::f0) by BN9PR03CA0162.outlook.office365.com
 (2603:10b6:408:f4::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16 via Frontend
 Transport; Wed, 20 Oct 2021 16:35:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT012.mail.protection.outlook.com (10.13.177.55) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4628.16 via Frontend Transport; Wed, 20 Oct 2021 16:35:39 +0000
Received: from krussell.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Wed, 20 Oct
 2021 11:35:37 -0500
From: Kent Russell <kent.russell@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Kent Russell <kent.russell@amd.com>, Luben Tuikov <luben.tuikov@amd.com>, 
 Mukul Joshi <Mukul.Joshi@amd.com>
Subject: [PATCH 3/3] drm/amdgpu: Implement bad_page_threshold = -2 case
Date: Wed, 20 Oct 2021 12:35:20 -0400
Message-ID: <20211020163520.1167214-3-kent.russell@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211020163520.1167214-1-kent.russell@amd.com>
References: <20211020163520.1167214-1-kent.russell@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0372425d-d08e-4ff9-4204-08d993e7a6ee
X-MS-TrafficTypeDiagnostic: DM5PR12MB1627:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1627A242435D671BC6936CA185BE9@DM5PR12MB1627.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FtsTqnrgdNUCWgURorCXXPQqf0b0tP8cRuONjr8XKlgmy28CoZjes2Mh+uvCa63jcUZziYNGMoptteGlXSz8X2e4ptpAJKP0ol9Kl9ljjy6SA5N0l8VpZnwTmHdnBx4yoxaKh2oBBw4eQCU/9U3lEuTc7W/dbYPuMXzBac5KxkqgLRxtHiHSDJpwOguAqV6gclVJoqV8s+/jjU0skzTRwQvfobVmBbNegNewQwjSyUf8t0bV/K1E4CKWqa6FiS0fvGf5GKFePwCfhOr0nXluqaLnNFlaGgX+fgFkN3OPdiQmhyPATPh5EhYAmljaxpJFVhSz+m/9u20FmQSlFam5yqQs5gE+pBsuV01ii6gtI8d/UgiUhV4PJcwf7FJ18Zu7ejgo7+5dawWXjf72ooYJ/rEDwZmrLRLbKHIx/+WzL4NKEKYdGUJNhf2VwLH5Ug3u49UZzbJfEDSg26Ki8NVicOpXl5mVbDNwc3KsHKs64wUqTjLeACeqxEiZT70bqJanAEhF84ocg2yS97kSUO7wvKCCFjdbI8pYW1HBti51YkLFPMnMbMU8ivZrgbM0f7noTwyS0YmQZ6lVJtnn3ei8Sut6DxufLaXaZ00KTgfVKPWsIoFq0psD7qWOOk/ucXWjkQhujbKJD48RJ3VdeSc4whESXJFAS8w7s5mEvfOXeNFuw9kaW7NR6Rq+idxjO7O/MDEniIRaqmKn/lhAyklMDhtBc6ImgSEf/uE8/X/639I=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(7696005)(2906002)(508600001)(186003)(54906003)(16526019)(356005)(6666004)(44832011)(316002)(426003)(6916009)(336012)(86362001)(2616005)(5660300002)(83380400001)(47076005)(36756003)(70586007)(8936002)(8676002)(26005)(36860700001)(81166007)(82310400003)(70206006)(4326008)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2021 16:35:39.6556 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0372425d-d08e-4ff9-4204-08d993e7a6ee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT012.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1627
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

If the bad_page_threshold kernel parameter is set to -2,
continue to post the GPU. Print a warning to dmesg that this action has
been done, and that page retirement will obviously not work for said GPU

Cc: Luben Tuikov <luben.tuikov@amd.com>
Cc: Mukul Joshi <Mukul.Joshi@amd.com>
Signed-off-by: Kent Russell <kent.russell@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index 1ede0f0d6f55..31852330c1db 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -1115,11 +1115,16 @@ int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_control *control,
 			res = amdgpu_ras_eeprom_correct_header_tag(control,
 								   RAS_TABLE_HDR_VAL);
 		} else {
-			*exceed_err_limit = true;
-			dev_err(adev->dev,
-				"RAS records:%d exceed threshold:%d, "
-				"GPU will not be initialized. Replace this GPU or increase the threshold",
+			dev_err(adev->dev, "RAS records:%d exceed threshold:%d",
 				control->ras_num_recs, ras->bad_page_cnt_threshold);
+			if (amdgpu_bad_page_threshold == -2) {
+				dev_warn(adev->dev, "GPU will be initialized due to bad_page_threshold = -2.");
+				dev_warn(adev->dev, "Page retirement will not work for this GPU in this state.");
+				res = 0;
+			} else {
+				*exceed_err_limit = true;
+				dev_err(adev->dev, "GPU will not be initialized. Replace this GPU or increase the threshold.");
+			}
 		}
 	} else {
 		DRM_INFO("Creating a new EEPROM table");
-- 
2.25.1

