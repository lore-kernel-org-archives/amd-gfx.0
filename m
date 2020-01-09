Return-Path: <SRS0=R6+d=26=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28951C32771
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jan 2020 11:42:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF6242072A
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jan 2020 11:42:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="t1IGJJHl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF6242072A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ADBBC6E3F0;
	Thu,  9 Jan 2020 11:42:21 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2066.outbound.protection.outlook.com [40.107.94.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDFD46E3F0
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jan 2020 11:42:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FfDMHr63zSzhB9SQbhf5sqqYXpU0eC6DWWsMGvfSi8ZQJE3m37jwz9M8KM4FfMoVDc2rVAdRwPzBwI9lZh5MUhvt+kL8Pj1Jclvl4hGtDlm+ed4Lar6B8+hmDnbTaSL2USKihizAcPOarAX3pT2n+D1hvHAroWKbKDCJzhmkQbIn79cD9OVIHXy+113eBQ7YtbI5PxLygNBJnDsUMDnTRRNhSKFnSWxvWzx/c0yj4fmJYdBu5RU3OwaixeT4lLUGlHGnJaHBJZtkZWvfyouTTdlRDGMP5gE3yaHG8SB/c7NnygVcpBJiPwVNnZbIKxSKLZuyHP1b3g+5lwCFMyjvGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/7YKJo5CayIQl+w9ZVBsVbL2pmjs+gFSp+uFw3aF0tc=;
 b=azvdTNvpuYHR0I4l0RBUTabrphYqc6PeooTruyeRPGV/6412lTnGvc9R5jViu57aKPWaNjgS4w7ypIpYDBSSOHb3l0QR2MyReeT77tJv95ByNT7ZbVZEGOdCQfPzvWlEDaCkj70oWS/gLtkGtBow9Exok2mg8dwECSpsvEY9GMy/6jG8yQkf6vkDKkN372RO+fZqPyzo7CV/uED6ARm5yBKbJVsCnY7C/FUxGKtjOFPmAu/DKmvvH7sYVvIo7GQ0IvSziz/o4ir/ilkyRHCccKTjqqp/tUxYJCJ6q8hga9y4uMNPmu62ZXkbfWPOf6/+u6So+srJxtWIcjs/Rz05/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/7YKJo5CayIQl+w9ZVBsVbL2pmjs+gFSp+uFw3aF0tc=;
 b=t1IGJJHl8YmL8I7nvzl8xzBBHg51qblDOs2aYuqvCXuqCmVftpGALKKHyrR8t487GoiShk3TuJH8hXzbJV1m6I05tbuVyI+HFf3kIGFDmJ62/i0NnStla13Q3A255C+1rsG19wEr20ndeTzc0eSAWpfXK/nhH/seijGc1vt808s=
Received: from BN6PR12CA0040.namprd12.prod.outlook.com (2603:10b6:405:70::26)
 by BN6PR12MB1347.namprd12.prod.outlook.com (2603:10b6:404:1c::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.10; Thu, 9 Jan
 2020 11:42:18 +0000
Received: from CO1NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eab::202) by BN6PR12CA0040.outlook.office365.com
 (2603:10b6:405:70::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.9 via Frontend
 Transport; Thu, 9 Jan 2020 11:42:18 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT054.mail.protection.outlook.com (10.13.174.70) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2623.9 via Frontend Transport; Thu, 9 Jan 2020 11:42:18 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 9 Jan 2020
 05:42:17 -0600
Received: from hawzhang-System-Product-Master.amd.com (10.180.168.240) by
 SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Thu, 9 Jan 2020 05:42:16 -0600
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: check sdma ras funcs pointer before accessing
Date: Thu, 9 Jan 2020 19:42:13 +0800
Message-ID: <20200109114213.5537-1-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(376002)(346002)(396003)(39860400002)(428003)(189003)(199004)(426003)(336012)(316002)(7696005)(8936002)(2616005)(478600001)(6916009)(5660300002)(2906002)(1076003)(86362001)(36756003)(4326008)(81156014)(8676002)(81166006)(26005)(6666004)(186003)(356004)(70206006)(70586007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN6PR12MB1347; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1b10c95b-cfa9-481e-a5de-08d794f8fb47
X-MS-TrafficTypeDiagnostic: BN6PR12MB1347:
X-Microsoft-Antispam-PRVS: <BN6PR12MB1347F1506E8170AF694CA684FC390@BN6PR12MB1347.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1824;
X-Forefront-PRVS: 02778BF158
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: josqqwye3fz7oK3YtL/cWMvL04osHeYUkf6xhsjeWaZrFXb0VnR56+nelbvmjF26BMV1M0PFkcMpoUvuxlhmBMUHRo1pA7I/HveGEVWYdcsn5YT+bnSWNdhFC5cFLt4coO7fZqyiRVGnsYohE+ErTKbB2N+AZge4CGqG4egqrbGJ3X9tDfR3Tdd+FvfJYAmLpFSJ9+Cv7AkyODUcst/8RDA8dF/s+rraKxOUslOVhwd3chN4950kBl06jjj4sAjXeV/FjSilKGCLjgWmrQ6RE76CFwVkTtk0jKYZe4TnOzdmK1v8b2Ye3rY+40cYCFFbYfS1tH+IM13r+mjdWP1QCbosfbQmAbtwWB1I2bphp51ZrICL22sV4NZK98V6cI6d0BK2LoqCh4e3IVrH0isHV22EMv2zCt/ZbkKFEHlypRo5p1i6iH2EOGwW1GQn+kiH
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2020 11:42:18.3175 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b10c95b-cfa9-481e-a5de-08d794f8fb47
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1347
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
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

sdma ras funcs are not supported by ASIC prior
to vega20

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index f4107f9b75f3..c4b4caaf56fe 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -1810,7 +1810,10 @@ static int sdma_v4_0_late_init(void *handle)
 			RREG32_SDMA(i, mmSDMA0_EDC_COUNTER);
 	}
 
-	return adev->sdma.funcs->ras_late_init(adev, &ih_info);
+	if (adev->sdma.funcs && adev->sdma.funcs->ras_late_init)
+		return adev->sdma.funcs->ras_late_init(adev, &ih_info);
+	else
+		return 0;
 }
 
 static int sdma_v4_0_sw_init(void *handle)
@@ -1882,7 +1885,8 @@ static int sdma_v4_0_sw_fini(void *handle)
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 	int i;
 
-	adev->sdma.funcs->ras_fini(adev);
+	if (adev->sdma.funcs && adev->sdma.funcs->ras_fini)
+		adev->sdma.funcs->ras_fini(adev);
 
 	for (i = 0; i < adev->sdma.num_instances; i++) {
 		amdgpu_ring_fini(&adev->sdma.instance[i].ring);
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
