Return-Path: <SRS0=G8as=BB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34D65C433E1
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Jul 2020 13:37:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D69EC20717
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Jul 2020 13:37:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="JkH+nCKR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D69EC20717
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 96B9989DA9;
	Wed, 22 Jul 2020 13:37:12 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2047.outbound.protection.outlook.com [40.107.244.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8DA0089DA9
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Jul 2020 13:37:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DeYULJrG4NPpf8Th1SOe1NGmjkVJyAQh496V5EIuYAcLWXT6JFFa0Nan+M0q8wEH5mPU8+b46sqYIzVnbXFSh9UtOy3MVS7kWm0LXLWOsm+kNJHQMFW779unecMYU7FnN1oaaMTStf+UrODLG9yxz7zruXUe9UCYF3KYOf20RC0u6nDQjfZYKYDZNv8kUFdY1sGETrs/2uxTfze5MpeGpxg/ZM1X0AIbWPJn8JxuI0nKOI++WQ4cVLW1YUBZSy+X2qlxL7VnSEwEcwq7MYBScGW87gmvVf0Q2VbZkyFLCTlVRdgKVVoWEGt1/cYiS18eIFN9sbRW95ZBmM0WtNx22A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mcp/xQBe0AA5wYCMPkotPK/Ln7IA7EIxT5d4Vu51jsQ=;
 b=VTiRm+RycKDQg5W89ajL9qgRJDATymRHmzGf7PPOSiGEeIeqA7nHmIMVNwwxqazOEYQoxAdqCgoRCE5+nWp+k9xC+2MDV6mXXV2KrOh5+Y4BlrzRv/IkM2gZnX9eqOJjKLnRkHPlno7/5M3igRGhEtGz7KPFO176PJzH7IObXplcUuPf3tbRsQGm25/Wfm73WA2S1cLL751fOJlUn1u9oKA1IlzJSIYRGM1QjLZxVJKj05jOlau20W9x0RemlvfM2qQdFJ81F3+lKnYwCq7BjNJU/mgIRGUe8wqgWXc0q0OMqpf/2vpQW18aOXuODsukcyQT6v55DnCzDPA26JTWnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mcp/xQBe0AA5wYCMPkotPK/Ln7IA7EIxT5d4Vu51jsQ=;
 b=JkH+nCKRAMdaeBRAH98eK6NOHE7IVIrbuBOoOumVd8gGG5BSRyYjbS4nM0k82qERtlUKnSHaMeAR0jTkF8pWDd/d7CgrOJPekcFwS2USEiiPC9nN43R/8qGbuo9MgXg8R8pk+j4Wvd9Fjp9KeY7hANd48Q9qtlWtB8k+HB7LZR4=
Received: from BN4PR12CA0010.namprd12.prod.outlook.com (2603:10b6:403:2::20)
 by BN6PR12MB1233.namprd12.prod.outlook.com (2603:10b6:404:1c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.20; Wed, 22 Jul
 2020 13:37:09 +0000
Received: from BN8NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:403:2:cafe::60) by BN4PR12CA0010.outlook.office365.com
 (2603:10b6:403:2::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.23 via Frontend
 Transport; Wed, 22 Jul 2020 13:37:09 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT054.mail.protection.outlook.com (10.13.177.102) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3216.10 via Frontend Transport; Wed, 22 Jul 2020 13:37:09 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 22 Jul
 2020 08:37:09 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Wed, 22 Jul 2020 08:37:08 -0500
From: Kenneth Feng <kenneth.feng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/powerplay: remove the dpm checking in the boot
 sequence
Date: Wed, 22 Jul 2020 21:37:05 +0800
Message-ID: <20200722133705.6633-1-kenneth.feng@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(396003)(136003)(376002)(346002)(46966005)(186003)(26005)(83380400001)(47076004)(82740400003)(478600001)(2906002)(82310400002)(316002)(6916009)(1076003)(81166007)(356005)(5660300002)(4744005)(86362001)(2616005)(70586007)(36756003)(70206006)(4326008)(8676002)(6666004)(8936002)(336012)(44832011)(426003);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d1d58014-a6ea-4f0d-82ab-08d82e445544
X-MS-TrafficTypeDiagnostic: BN6PR12MB1233:
X-Microsoft-Antispam-PRVS: <BN6PR12MB1233567CD90B8C3AF531B5168E790@BN6PR12MB1233.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ECgDuTcHkK90Av8DJ7jfqP0LWpS2pJ3sTe4wX8VhsuSSZ/eqXiB7NbfApNwipwcBYKokm+T8N9UJ8dqfTqDIc75pwkmPzE7EcQQqUEAJVh1olSFSoNg95W1/8AbGMNWbdeA2yLvV8nEpnc/UXMbu7Ee8AKvpC7fJmyX+TEZy+b7pBDsUK9hCvccUauySVu8CAo9tqWSDa/5o1zsQUjABxfcSiRUuaRe9aFtk8xfjWqhYRLzUmoVYheyyroQCTRnSS/G8skMH9YZ/xvXjK4A4FRqFUaDRygmIFzMos24V6RRAEr8qdGrY2ppty+G+SzhdLodqGKxTNusEsNfKxaNZfQ94bmZ76syoHrPMul+OSXtMYqFBYu0+CSwVeEqp0luc1JoVcfjBaQiIAnsydSW6XA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2020 13:37:09.5702 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d1d58014-a6ea-4f0d-82ab-08d82e445544
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1233
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
Cc: Kenneth Feng <kenneth.feng@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

It's not necessary to retrieve the power features status when the
asic is booted up the first time. This patch can have the features
enablement status still checked in suspend/resume case and removed
from the first boot up sequence.

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
index f778b00e49eb..6b03f750e63b 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -735,7 +735,7 @@ static int smu_smc_hw_setup(struct smu_context *smu)
 	uint32_t pcie_gen = 0, pcie_width = 0;
 	int ret;
 
-	if (smu_is_dpm_running(smu) && adev->in_suspend) {
+	if (adev->in_suspend && smu_is_dpm_running(smu)) {
 		dev_info(adev->dev, "dpm has been enabled\n");
 		return 0;
 	}
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
