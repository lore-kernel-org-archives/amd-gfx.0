Return-Path: <SRS0=eRNB=F5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BF50C433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Dec 2020 06:31:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C74BC23129
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Dec 2020 06:31:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C74BC23129
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E7F389A16;
	Fri, 25 Dec 2020 06:31:24 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2060.outbound.protection.outlook.com [40.107.243.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B12E089A16
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Dec 2020 06:31:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SO2H3NAOTesttf+LdqpwCBx9uYpxnGx9BDpT+aBgfmCxDh+zO5uhoZtjymiMtaWYmAmWowDpHwHQbA+ntQvSt2p7P3EqywL1MJ7rN51yG5nPQ4zA+HCUD3KMtXryuofqpg6S22msGz23rnM9iH2jRIId6MLt4twKGs5cCZzQnIbh8Kx2h19dHtKvi7J/HPmgDhtnu3ljw0Kxo4lJNfVIRULvZ9dT5x3BWACB5KMgVu+DLA2+Hx8EnQlfX7MLUbxL8iEJK1GRHBXr9kUhdqF/wLpucXCd/yal0hMdbO1JhtBI4Ww0+OmyFPB2ina5l0PoBoa3lDswfBda0G1gFWWI/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wsn8iLiXIvG2/kBl161SvqFoaq44Ec5dkiHvWWq8b38=;
 b=jLqNvP9A3NCq2OWk1pPNPTI2FEacKMurs0b7uQrBypcsZT9ynHDmB4oVWpY5a/v681oe851u20AwukIi2b3DX6Xo2qeh+ah9oqCWUSwpdhkmPYxDJSrQmrqV/OBkzWIuwsjXrClVDk+UZmDkSmunF9G3JxoJE8iWJESj1d6IAvUYtSykiTP8Z09dcMoH95HH2Jo3mnuNMYlS1C5dFG+bZdvS/s4cWqaXAQvJ+fPgch7zOb7Jq6cRrFChJCuLjsxLirM8C8cYIk01lKIGAQzJu3rsN3F/AJaZcOsTLtxhKmFT1gQAr/4In50k1b3f6N6B54iGsuZqgktoq2KvCBwHPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wsn8iLiXIvG2/kBl161SvqFoaq44Ec5dkiHvWWq8b38=;
 b=FSR7KTHcRKMAa/EPHkJp8U0PuVX01JbbloVxh64C/Ego+bKvgRdPKYsrSLEMuWdltGYsGOeucfBHjPj2VxfYCVwLF9RgIbtjJA4zvUF1QFY+/+XyJysIn3psbGGEWw63QJR316EiF2fv+4sHFusM1AnxUxoILggNcha3qxleA5E=
Received: from BN8PR16CA0035.namprd16.prod.outlook.com (2603:10b6:408:4c::48)
 by DM6PR12MB3658.namprd12.prod.outlook.com (2603:10b6:5:1c8::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3700.27; Fri, 25 Dec
 2020 06:31:21 +0000
Received: from BN8NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:4c:cafe::3) by BN8PR16CA0035.outlook.office365.com
 (2603:10b6:408:4c::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3700.27 via Frontend
 Transport; Fri, 25 Dec 2020 06:31:21 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT017.mail.protection.outlook.com (10.13.177.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3676.25 via Frontend Transport; Fri, 25 Dec 2020 06:31:20 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 25 Dec
 2020 00:31:16 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 25 Dec
 2020 00:31:16 -0600
Received: from build-u18.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3 via Frontend
 Transport; Fri, 25 Dec 2020 00:31:15 -0600
From: Peng Ju Zhou <PengJu.Zhou@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: reduce delay in psp command submit
Date: Fri, 25 Dec 2020 14:31:06 +0800
Message-ID: <20201225063106.12781-1-PengJu.Zhou@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6cbe5ba3-cc37-4bab-432c-08d8a89eb13a
X-MS-TrafficTypeDiagnostic: DM6PR12MB3658:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3658E4C0527A7808EC04A84EF8DC0@DM6PR12MB3658.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2803;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RoQGg8dFmhATrm/oY9vvLwqrL0BWeEvlh/o/sDQzDS6t8WPHOkB8XXLRUlaPciA+uBQ/3SpG5r1PpLgvij8tjmJaqvx8VOvTt4zDIx6vtN1MhxmZSjyNb/XXLqwkYd4XE+Y1rS6am9iIlUNjdfKZKDxp2g94qh50FdX3CYLBONEAFBq1R9M8oR4gmMb/wROl5PoDR2pqj3rO2SjY1pwXyZqMhxnUuyyFehuOK27D1uE1yIpcS4j6WsyEFLdEijg49sr8UKdCkL51Wg2MiHNe2e3WI29YGdlrXEDe9EgtPZWPsfEh5URGEs8Nyyvwd1RJAZJbmfFCwHAOz8d1Bk+VOfauW4YaJBRhriAYhrVciKk7sxCyvmCNMr+7cVnHvu3W7HAAqYKHWRmX9O71jIj4kc+RqC0USm72c4E59e8tt88pOiJQAeKzd3qWuH+MRddWah7Bc++ID5S41XLMSw6adg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(396003)(136003)(376002)(46966006)(26005)(70586007)(82310400003)(8676002)(2616005)(5660300002)(336012)(426003)(186003)(83380400001)(36756003)(4326008)(2906002)(316002)(478600001)(82740400003)(1076003)(6666004)(8936002)(81166007)(7696005)(70206006)(47076005)(356005)(6916009)(86362001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Dec 2020 06:31:20.4170 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cbe5ba3-cc37-4bab-432c-08d8a89eb13a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3658
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: pengzhou <PengJu.Zhou@amd.com>

In the psp command submit logic,
the function msleep(1) can be delayed to 10+ ms sometimes,
During the driver init, it will hit msleep(1)
several times which increased the total time of full access.

Changing msleep(1) to usleep_range(10, 100)
and it can reduce about 50ms delay of the total time of full access.

Signed-off-by: Peng Ju Zhou <PengJu.Zhou@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 523d22db094b..8d11b34fe40e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -249,7 +249,7 @@ psp_cmd_submit_buf(struct psp_context *psp,
 {
 	int ret;
 	int index;
-	int timeout = 2000;
+	int timeout = 20000;
 	bool ras_intr = false;
 	bool skip_unsupport = false;
 
@@ -282,7 +282,7 @@ psp_cmd_submit_buf(struct psp_context *psp,
 		ras_intr = amdgpu_ras_intr_triggered();
 		if (ras_intr)
 			break;
-		msleep(1);
+		usleep_range(10, 100);
 		amdgpu_asic_invalidate_hdp(psp->adev, NULL);
 	}
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
