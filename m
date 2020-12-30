Return-Path: <SRS0=0XED=GC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD338C433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Dec 2020 09:23:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8994520791
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Dec 2020 09:23:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8994520791
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D39E08924C;
	Wed, 30 Dec 2020 09:23:12 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2078.outbound.protection.outlook.com [40.107.220.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7ADD18924C
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Dec 2020 09:23:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hibANEdrK3ZJ9GNqe73ECZiIwiPXf1m+OCvpsJvPwVV9ZG/FxzHqMIIJjBKRea12h47s1nqol5GezZVMpzAq8unnGAoL0aHOLRajRSFrbceFt3UV4cxaxW7k1PRcnyzdFEKnblbzjhXGNJzBUtZaRtJHQ/x/f1cB1fH/xsf+I3pnBfH6+Y/IOBf1qe2+CzVxdnNQZA1iO8r2MlYf91kIttSERxBQk66d3sEeMmDMf3ZkaCDh6TDWD11WcTbPtX3j8Idm/KlfWCfK++fYwIJNLa0890qcPkn2IooPNyVDQ08L1HSRiS8AT+71amV5ndZm/PTIproH7wMSzF8smY6vpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lKy1KjsFojozNmd6+VZC+xHqGBHbQ3q612c3z528TrQ=;
 b=U6fuS568YZCS2mckVaRH6KrrvVT0Llw/FOZOKNedY6L/kGPhvFR3MxGEYW+i6cI00PR15l24/wyiqReryHzTrNUGx6rFyBbztjJWWZ2jq1nU3oET0O9jpcrDAt2WSKtAqQ4bZE41U5cCi+q/Xu5adGy2SA0V9TxsZZJPDiUaLt6XsiN1F4C2M05tAGOSf7f06664y76rDHaiLrfEzuTI5F7HxamuaQ36tNCcFDkrWD3fK+5O5+EO0nUMmAniK82GkfQ3bcb7t0e3AFvuZeuGTAROBmTLaMDhPpvTAKhw+j40z6Jhhn2ULcgDntK6tyxA5yzixCmiJ1zYZ7YLXswZrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lKy1KjsFojozNmd6+VZC+xHqGBHbQ3q612c3z528TrQ=;
 b=c5FjSFdDz8PdIAVDDPO26XbHXLggutaEVW4y50lK3hiahkP7JvrGWm/R+eZqLm2VgDzAnDvhQbtt6/nKiI0py3/GQRRHrYQQ7v99L7aYdr1V3vV15PsTeJ7YjuLGleTU+zhQi56yqZR2ZaRPMR5b1gqJYIkywGC3x5p1iNEePDQ=
Received: from DM5PR12CA0064.namprd12.prod.outlook.com (2603:10b6:3:103::26)
 by BYAPR12MB3350.namprd12.prod.outlook.com (2603:10b6:a03:ab::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3700.28; Wed, 30 Dec
 2020 09:23:07 +0000
Received: from DM6NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:103:cafe::c5) by DM5PR12CA0064.outlook.office365.com
 (2603:10b6:3:103::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.19 via Frontend
 Transport; Wed, 30 Dec 2020 09:23:07 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM6NAM11FT057.mail.protection.outlook.com (10.13.172.252) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3700.29 via Frontend Transport; Wed, 30 Dec 2020 09:23:05 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 30 Dec
 2020 03:23:03 -0600
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 30 Dec
 2020 03:23:03 -0600
Received: from navi10-sut.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3 via Frontend
 Transport; Wed, 30 Dec 2020 03:23:02 -0600
From: Jiansong Chen <Jiansong.Chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: correct releasing the same sdma fw repeatedly
Date: Wed, 30 Dec 2020 17:22:53 +0800
Message-ID: <20201230092253.3137-1-Jiansong.Chen@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 47893205-5533-4f4b-3243-08d8aca4835d
X-MS-TrafficTypeDiagnostic: BYAPR12MB3350:
X-Microsoft-Antispam-PRVS: <BYAPR12MB335049A8E24624EE9290D205EAD70@BYAPR12MB3350.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wAzGrIPg0TIQ8EJFEcujaS9pZdQukpHIGht2Ptn7Hn3fLka62IBE84xaF+GGQYUMkmKGWvz5jfH8ANLyEvKsrzBiaC6KQY0y3EuOaC4gi5c02JtvgmQDsZOmRhmr4YdZRAYZR8j3/nO7qvcMsVkV+1ac/GdUYQ1XXnseMD+b0Uudb0seA+LloJQxuxXY/52ByTTuzmhqBC03Hvk75+PbOgEURgiLVU9xP+Eka3CSUVICoCzz2jcfCLBwbOCkVmKDaFWMx7HhuzV9vRm/RmhVzJhfN9TAsigB1xHVHVYKILLxIYzwgn2c9DfmsgfdjLCfXiNaeynWrhLkiTwkpnJakAa70kyAevGmv7Hw8+RiR8L5AZy7AMJecpjnu6CfXzi3KDbNGqk/3GwUvmtuKbuNyL6jV2bnt6rgzAXzkNhD6GQE/dd6moVt2nfqIt2E121NYiq88BR5HYsVNskWfkM59w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(376002)(396003)(136003)(46966006)(2616005)(82310400003)(426003)(36756003)(5660300002)(186003)(8676002)(83380400001)(2906002)(6666004)(356005)(7696005)(316002)(82740400003)(81166007)(70206006)(54906003)(26005)(4744005)(6916009)(4326008)(8936002)(70586007)(86362001)(336012)(47076005)(1076003)(478600001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Dec 2020 09:23:05.0462 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 47893205-5533-4f4b-3243-08d8aca4835d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3350
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
Cc: Jiansong Chen <Jiansong.Chen@amd.com>, Tao.Zhou1@amd.com,
 Hawking.Zhang@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Same as sienna_cichlid, dimgrey_cavefish and navy_flounder
reuse sdma0 fw for other instances, so free it only once.

Signed-off-by: Jiansong Chen <Jiansong.Chen@amd.com>
Change-Id: I9dda4a9b73e20243ee48f54d8f0c7593d7e7354b
---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index f1ba36a094da..6ac314c8be32 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -125,7 +125,8 @@ static void sdma_v5_2_destroy_inst_ctx(struct amdgpu_device *adev)
 		release_firmware(adev->sdma.instance[i].fw);
 		adev->sdma.instance[i].fw = NULL;
 
-		if (adev->asic_type == CHIP_SIENNA_CICHLID)
+		if (adev->asic_type >= CHIP_SIENNA_CICHLID &&
+		    adev->asic_type <= CHIP_DIMGREY_CAVEFISH)
 			break;
 	}
 
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
