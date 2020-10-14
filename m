Return-Path: <SRS0=q64Q=DV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14A96C433DF
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Oct 2020 17:25:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 703FD2173E
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Oct 2020 17:25:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="AxK8N5oq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 703FD2173E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB4696EB0B;
	Wed, 14 Oct 2020 17:25:02 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2089.outbound.protection.outlook.com [40.107.93.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B608B6EB0D
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Oct 2020 17:25:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fkTs+RGJI3EB21+47BhyOIESDbDAHO3xeD6nxyqSn26UJRJsL8YTMO56HHyTjVL/jnS8iZcQ1V9pIOutFzBT/WWg6EgAgx1UDIbzFxHbOTxTYj4SLXKQLCtj4tlatN4erf51QMzQfnYDKbxRLLe4E8GuYXhFNmnsRI6xutNoM6nIlBjNAIprDwuLqOrb41r9mLKimKQ5rcsDnxeyH56YLnUvbKuES1HzCmkuFww6UPvoY0ZyVKwG8vIxs2fofKiDnm3H1OmoEhUhAibkuYFEKk8uOt6xJBKL6johlHAKqWYBk8WrGPPvSH09HXoBEMbpPBkkikrM8t/qJmMIa2sFAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rtFnUZZbyxjtIQCa34ZbXrPuYsVNOcx6vU7UjWKnO8k=;
 b=WyzhudFqqEw9xOcyC4Ho8qWZTPNckgyX2B3AI3wQGd+RnwYuZi7YMO+EQcLs8gr8UpQIb1nPnOm+HcnRdp55NBtX60BCzEcCTwipWTHnXrjgtZ3HKLZSw6YCbCIXKcvpqR2lT/U7+jx4Npprygym1WwC+YeBTDXkK+vKgiMTRkNTa9R0R4Y5YtENYkKJhdQCrwQZ3iQ9R/N89Agj1utc8W0lvtXv+arPWmx82Z0DlbVqkVAv/B459rj7hsff6t+qMdwxV1LtLQEWtjfixiji6AGzh4Vo7VbjdMbBpzAv50AvnFUkIyXvNagxGRezZKulgviHUTZevxrhgzOaMWY5cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=none action=none header.from=amd.com; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rtFnUZZbyxjtIQCa34ZbXrPuYsVNOcx6vU7UjWKnO8k=;
 b=AxK8N5oqzAsMt0kTjKCIAHaI9eXhbo6atduXWPigcx9VQdc6Y3hSftSeSe8RHc6ICkoy1+UoowhcxS3RIEuVOtS4qHgFFB9gBj+Ket3bQ9YGuHehgn6k603CJTdkgIYCmP3A7IVVmhIlSJ2XeP8Sfr5dT4dlxnDHla6Zu1prSYI=
Received: from BN6PR04CA0086.namprd04.prod.outlook.com (2603:10b6:404:c9::12)
 by CH2PR12MB4104.namprd12.prod.outlook.com (2603:10b6:610:a4::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.23; Wed, 14 Oct
 2020 17:25:00 +0000
Received: from BN8NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:c9:cafe::bf) by BN6PR04CA0086.outlook.office365.com
 (2603:10b6:404:c9::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.21 via Frontend
 Transport; Wed, 14 Oct 2020 17:25:00 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=none action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT008.mail.protection.outlook.com (10.13.177.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3455.23 via Frontend Transport; Wed, 14 Oct 2020 17:25:00 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 14 Oct
 2020 12:24:59 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 14 Oct
 2020 12:24:59 -0500
Received: from agrodzovsky-All-Series.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Wed, 14 Oct 2020 12:24:58 -0500
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amd/display: Avoid MST manager resource leak.
Date: Wed, 14 Oct 2020 13:24:54 -0400
Message-ID: <1602696294-5611-2-git-send-email-andrey.grodzovsky@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1602696294-5611-1-git-send-email-andrey.grodzovsky@amd.com>
References: <1602696294-5611-1-git-send-email-andrey.grodzovsky@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4e2e719e-5221-4f01-c60b-08d870661440
X-MS-TrafficTypeDiagnostic: CH2PR12MB4104:
X-Microsoft-Antispam-PRVS: <CH2PR12MB4104EBC2793BC3FD74239B38EA050@CH2PR12MB4104.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +AeiXterSvmybwzLeImRbQ6kfwa7+DE6aRm0cfaIAq72FtA1J/WWP1JaJc9/K/YGAhcY6ql96Rc1KPU8XJ6wx6UAAfHrasd8Ag12f5uc0X5hPzlrbXKQW6yC3cirwEb8M5+8lVK9wK0VaYIlJkkWDFSiJb7jFvzdgNWJRdqu45fIAVLsYun/9N8tsXTnYFBQNJP1MECKuyF8sYNLxSlw5YSyhQPplb5kEGje4J7y2e+vYm6fJWIPM1f7Hx8Qr3zsZZdkkV2ca28ZNY6ESrOS7OSu7vEc8VQtzfSWuVxs9S46By3ZOFJWCrQIO+HtKKIkfp9WdX34LvhkoqF+JvRJQzZ6t6HPUnvjoKeXRna2ghJ8fh0kDeQWKqPiHx9dtGQkY08BEVnvhPBkZYkTB5X7sg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(376002)(136003)(39860400002)(346002)(46966005)(6666004)(8936002)(336012)(2616005)(44832011)(316002)(82310400003)(6916009)(36756003)(26005)(54906003)(5660300002)(70206006)(7696005)(356005)(186003)(8676002)(478600001)(4326008)(82740400003)(86362001)(70586007)(426003)(81166007)(2906002)(47076004);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2020 17:25:00.0680 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e2e719e-5221-4f01-c60b-08d870661440
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4104
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
Cc: Andrey Grodzovsky <andrey.grodzovsky@amd.com>, xinhui.pan@amd.com,
 harry.wentland@amd.com, nicholas.kazlauskas@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On connector destruction call drm_dp_mst_topology_mgr_destroy
to release resources allocated in drm_dp_mst_topology_mgr_init.
Do it only if MST manager was initialized before otherwsie a crash
is seen on driver unload/device unplug.

Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index a72447d..64799c4 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -5170,6 +5170,13 @@ static void amdgpu_dm_connector_destroy(struct drm_connector *connector)
 	struct amdgpu_device *adev = drm_to_adev(connector->dev);
 	struct amdgpu_display_manager *dm = &adev->dm;
 
+	/*
+	 * Call only if mst_mgr was initialized before since it's not done
+	 * for all connector types.
+	 */
+	if (aconnector->mst_mgr.dev)
+		drm_dp_mst_topology_mgr_destroy(&aconnector->mst_mgr);
+
 #if defined(CONFIG_BACKLIGHT_CLASS_DEVICE) ||\
 	defined(CONFIG_BACKLIGHT_CLASS_DEVICE_MODULE)
 
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
