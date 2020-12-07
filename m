Return-Path: <SRS0=y+Th=FL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A1B8C433FE
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Dec 2020 06:47:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC91D227C3
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Dec 2020 06:47:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC91D227C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 309856E570;
	Mon,  7 Dec 2020 06:47:20 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2079.outbound.protection.outlook.com [40.107.92.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B9D56E570
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Dec 2020 06:47:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RqGOdJdU2pcB3cNZsfsE9TEXWYzhcUCYQCXGeE+8L5udBS6Oeno+OrZcr0z7oA04yxgojXRjLqyZmtnx67uSii9lxWVJxidxE742qUpU8sjjCq2TZFTj875H8dVF5p6294NnjsU226jzxckcfTA9QOAI69CaBqeE6d5tfhxMt17X3l1OMEuJiHOu6WXvLyD3a9Ujdi9PInyxOaYjVd9dSCXrEsWXydPT+XnYovRIR05wWm1W44xPnt+gSHIGhaQNWtN1VQeYaPdKoJl9BQoKRlOrLts2ZZ/Fh6QnWmDjb8MI03xCyUSQqDcT3HRMNQpDMThh9Qdc+r4L9yTYuNDTgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pmeDwDn1I3VpUdFklRjJYDq9Hh45uWIxsWbOH2m0YCE=;
 b=FChs9GFCcJfntKcsCscfOjnOIWJppu0XWaYwAJ3K5qVlqZ3B82DUmypEpgwY5qIqK3Rhyfp9p8qeq5RI6cq8qrlZJ/YIsmjvpS3ntbcQ7AiCS+47/5aU8KsQpvdhgAzj6WIz8jZAyCAK4F02lQ584f1cfHfbQk50Xu/S+WGAD0Jq7usrN0QkCyK8Uz+3MZlcAuE4EXX4N99W5kK1rcIdFHneQm99+3C+l4wYTLODDaALORfuT7mLhRliOGCV/Sg1UrjdbforjW8H3uLtNMH9UL3U1OvRBN1DHRIsKTNEZ8SYzUFvK0GyhcQRMvMuYyKIwxCnImVowXBKnx5GHdmbUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pmeDwDn1I3VpUdFklRjJYDq9Hh45uWIxsWbOH2m0YCE=;
 b=Zf7pZMD2blw/Ljjg4xvS52VDVuBx6jRp0Ww39dZJLsAOrGJ9uT113SOlYhyTwJcivZHoXRopFqwVvGHwd1YkuHzy3d3htIRq3hgKzFbYToJ2rdE4xNTSp39JImBmCqiIv6zYO6oqSocWmf/MRQL1zhDTvqQyJ8eIPybRVlbHFEA=
Received: from DM6PR13CA0066.namprd13.prod.outlook.com (2603:10b6:5:134::43)
 by BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.21; Mon, 7 Dec
 2020 06:47:14 +0000
Received: from DM6NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:134:cafe::18) by DM6PR13CA0066.outlook.office365.com
 (2603:10b6:5:134::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.5 via Frontend
 Transport; Mon, 7 Dec 2020 06:47:14 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM6NAM11FT014.mail.protection.outlook.com (10.13.173.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3632.17 via Frontend Transport; Mon, 7 Dec 2020 06:47:14 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Mon, 7 Dec 2020
 00:47:12 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Mon, 7 Dec 2020
 00:47:12 -0600
Received: from stanley-test.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Mon, 7 Dec 2020 00:47:11 -0600
From: Stanley.Yang <Stanley.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/1] drm/amdgpu: fix sdma instance fw version and feature
 version init
Date: Mon, 7 Dec 2020 14:47:09 +0800
Message-ID: <20201207064709.31404-1-Stanley.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c8a9c082-30de-4a11-22c1-08d89a7bee5f
X-MS-TrafficTypeDiagnostic: BN8PR12MB3108:
X-Microsoft-Antispam-PRVS: <BN8PR12MB310803ED9647B754B6BEE4039ACE0@BN8PR12MB3108.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:335;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RZtJzfRGz7e4qv4mVsPyl4MUeEY4fijw++PHJB02niJdo21YAQrc2UolwNJnYxywYCS8tt/h2D3W7IS0wiYFJlSfCSLEGEX0XMX2l97Ptqt4dbqUR+veIEtVFYVkKlPqL28JGX8egyZj23L6gz0dVlEkzF0sSr4rSO2d818Td7HdjuQk5Y3vyUxkgzU6GhmPxkz/ugjGBzCugUkvh1N33ZjtrAR/+RkIar9R2ol1R2ayzv+A/cD201YbYTwcB1N0DDJR29AOpqIrEQGSbzSYMRxipkdcbIPPeZb4DS+IHHbUzlZozACDtGukOXQpdkmbg223pZVDqBnY9PI1nneN2k4V2uw1KQ2j4tzsWmJGLXzlYEsRpv/0Iboj8KNOXkGNkUzcQNL30/RaZ1A/yGyJfw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(396003)(346002)(376002)(39860400002)(46966005)(83380400001)(4326008)(8936002)(1076003)(82310400003)(4744005)(356005)(70586007)(186003)(6916009)(5660300002)(26005)(70206006)(2906002)(47076004)(81166007)(2616005)(316002)(426003)(7696005)(336012)(82740400003)(36756003)(478600001)(8676002)(86362001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2020 06:47:14.2802 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c8a9c082-30de-4a11-22c1-08d89a7bee5f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3108
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

each sdma instance fw_version and feature_version
should be set right value when asic type isn't
between SIENNA_CICHILD and CHIP_DIMGREY_CAVEFISH

Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
Change-Id: I1edbf3e0557d771eb4c0b686fa5299a3b5f26e35
---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index cb5a6f1437f8..3fca9fc20dc4 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -197,7 +197,7 @@ static int sdma_v5_2_init_microcode(struct amdgpu_device *adev)
 			if (err)
 				goto out;
 
-			err = sdma_v5_2_init_inst_ctx(&adev->sdma.instance[0]);
+			err = sdma_v5_2_init_inst_ctx(&adev->sdma.instance[i]);
 			if (err)
 				goto out;
 		}
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
