Return-Path: <SRS0=QzDn=C2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2852C433E2
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Sep 2020 08:16:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61CAE2083B
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Sep 2020 08:16:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="inMWl7iz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61CAE2083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E95E96E22A;
	Thu, 17 Sep 2020 08:16:31 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2071.outbound.protection.outlook.com [40.107.223.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 46FFC6E22A
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Sep 2020 08:16:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NN0SkmzsEJb5WvHoZnc7PrtmUpxmiBnzeam44STRnVSaQ+W8nBNbQiNORMEn9dVuzUpSl+nis+OEekB2TcJfWLvklkXdyjpTZ4+sVnfLLH0Q2EmTTJPPH9KizPE+swy3GpXzlCVscVoMQ/t0O7XQcavqRrqflN25Bm9gwdNIKDzz/u/E2bOWKDxsQvRi5qbFF9somCilnflSnu6wHJrt52B4L3bAFOb7MhVTa1iU5rvv2eCVi2jN5UQzIXcsY/k9GB0J1rvk+CV+3wQBp0rSvp6EFh8t3bdI1VML4aThjg17Dy5Fsqu7Jjyvb0n1FO+DEbCu99c3cp130b5Pyk7n6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GZM5zcfn/xjqKGjsGxgEh8FU037few/YPuQVf1sri1Q=;
 b=LJtbCpwR1xBKkl1CG+n9onY0W3jKLRIBzMWEiwzaiCCi56IVXhtAE0N0Eisblpijs6EGo5wb7vaQXiIPjlHgErAZKxde8sQekUfcJATUu9fjFrK1FPMR9RmkLPo7cQac/rQjMkqZf4+vqE0vShbI+F3MNbvcNEgzfYFhWuK/UUDNcgy8DuivXg83tCkeZYXR29qj4aA1vVMwfMyk1w60eNKzwKwNAbTzYV/X3UbyD7uGZqnP8XqfqP6LAJr39yAmHdoXS445A521xC8+CpBZwx9YDQMJX+Rmu7ivq1YmeGbrm8w6ojWGDDulriskrDPtBKqlwVU2SJ3Bfqj3eD4thA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GZM5zcfn/xjqKGjsGxgEh8FU037few/YPuQVf1sri1Q=;
 b=inMWl7izdKZ2XwPzJ4jnUol9kTRzXYDfUuIzik9A/OUKZU2xKDna5ROJmwMeLvY2ImxQVPPk31ygxFkVj7YrR+1gVDKTyTruDJiA5OC9/UOqfpCF6xwsBordAqxdu3Eb0y0jw8GA1ap6hWm9XSp46KKMmhEiiRsee/nxSDX1N/I=
Received: from BN4PR12CA0005.namprd12.prod.outlook.com (2603:10b6:403:2::15)
 by BY5PR12MB3825.namprd12.prod.outlook.com (2603:10b6:a03:1a2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Thu, 17 Sep
 2020 08:10:40 +0000
Received: from BN8NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:403:2:cafe::bb) by BN4PR12CA0005.outlook.office365.com
 (2603:10b6:403:2::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.13 via Frontend
 Transport; Thu, 17 Sep 2020 08:10:39 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT057.mail.protection.outlook.com (10.13.177.49) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3391.15 via Frontend Transport; Thu, 17 Sep 2020 08:10:39 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Thu, 17 Sep
 2020 03:10:39 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Thu, 17 Sep
 2020 03:10:38 -0500
Received: from wayne-build.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Thu, 17 Sep 2020 03:10:38 -0500
From: Jingwen Chen <Jingwen.Chen2@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: Skip smu_post_init in SRIOV
Date: Thu, 17 Sep 2020 16:10:35 +0800
Message-ID: <20200917081035.1024221-1-Jingwen.Chen2@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 41436139-28f0-41c7-8b62-08d85ae12a44
X-MS-TrafficTypeDiagnostic: BY5PR12MB3825:
X-Microsoft-Antispam-PRVS: <BY5PR12MB38251E57B5E69FE123E3D08BB73E0@BY5PR12MB3825.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2PvO3BNQDoBlj/x23UUbyZhTIUbkFnFw72Z3xNabk4oD4GT2w1CXVcE5DEFfXtG2SIGdRa5W2W+fylFgowgI34jXbkuFBODm/MttDdYy/D/oyzeD5EC/CzlDNaYNzd7aKx0g/dZ2gXBlXR7gA2c+JKjPievxiryic8NKmXKqTjznCcvehRbU68SvtztXZZjrnSvLyytsyGu5txwrGLYujJlJJcZtyIcxnqIGnGlNp/iPSRyXNjMM1KgGgfdqTQtXYpeD5kZeioQ0mp0oxkF1+1r9b0XEh7g1AYWdKD032Q9nBhpUrfNstTQ7c2l4LFtWDZc7156Mlv/qV/zV4cZcsHTghjYKh8iFsJ4iWxsveRr9eHxu/uWY0gWh+c8bepVm1LcX63hYF+JLRnZ6Gj5x1g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(346002)(396003)(136003)(46966005)(6916009)(316002)(8936002)(36756003)(2616005)(5660300002)(8676002)(336012)(70206006)(6666004)(478600001)(186003)(2906002)(4326008)(26005)(70586007)(86362001)(356005)(426003)(83380400001)(82310400003)(81166007)(7696005)(82740400003)(47076004)(1076003)(4744005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2020 08:10:39.5772 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 41436139-28f0-41c7-8b62-08d85ae12a44
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3825
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
Cc: Jingwen Chen <Jingwen.Chen2@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

smu_post_init needs to enable SMU feature, while this require
virtualization off. Skip it since this feature is not used in SRIOV.

Signed-off-by: Jingwen Chen <Jingwen.Chen2@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 5c4b74f964fc..79163d0ff762 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -469,10 +469,12 @@ static int smu_late_init(void *handle)
 	if (!smu->pm_enabled)
 		return 0;
 
-	ret = smu_post_init(smu);
-	if (ret) {
-		dev_err(adev->dev, "Failed to post smu init!\n");
-		return ret;
+	if (!amdgpu_sriov_vf(adev)) {
+		ret = smu_post_init(smu);
+		if (ret) {
+			dev_err(adev->dev, "Failed to post smu init!\n");
+			return ret;
+		}
 	}
 
 	ret = smu_set_default_od_settings(smu);
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
