Return-Path: <SRS0=5bFg=L7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EF65C07E95
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Jul 2021 16:28:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FD3E613B2
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Jul 2021 16:28:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FD3E613B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D6FCC6E13C;
	Wed,  7 Jul 2021 16:28:18 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2064.outbound.protection.outlook.com [40.107.94.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 952BF6E13C
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Jul 2021 16:28:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XVzta6YIqqClaVvOXvTb/hRWxgxXry6u+KBGjovO3YX585IrlMRY3SsaRlpdYdR75C7+Ca3JHwWR7AuEN9VzU0QMm4FMUtulUDfSWUQV9ON1BO3NCm/sCGMRTJ6vck+XT6Ydu9b5tE3FZoWFTWSrbfTb3TuXmdNAIEBGCfRGlekhqsmbKsFHMabwVY0zFdC1W6vN4n8Pe6mNpUN/joOz4X2OGCpDiAE61KYzdjmyAlYNKiHDnHr3LLj4zKhFf5BPSfMWeUVNZ5ty72E9l/wQFSpuBjHmYx2/NDo4MfdDtYcZ2EXzVtCAJo1x66ewEWA8NHzhEkfBJ7FomidFtTvuxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dMY3WcfQ2RfJ6mj9vjcAFZwTdJ0NAMljKKiwSyl+DuI=;
 b=edhvb7gd0RkRWrhlYZCHuZ5HqbzuHpGkpFQ0xxWlA68IY8665YC4VgavNecXx+Fb3e5ZwKJTdLhib+l6JCaVpmq5D2EdW5XdCUuxDM6jRkySMBmH0FeB3zajN4g4+osGOkyJ9aZ2S6E5kCtaYU8ZF0du+iVw4dseHAWw479MzAwDKxVlVzOfB3eNK8J6FrZGIyzefe3AAwQnrfn7Nw4xTRMnHRSYvEsH+UlsdOw0vDIOzSDjBYh8PiOo8yhw/UV0OsLcPnAA26jmGmCqMhNI+wGRIxr0DbdwKVCYhtKjUjLe7cTyOY8/jDizPUzWqmq8Q6CT00gJdTz/WoHUlm2b0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dMY3WcfQ2RfJ6mj9vjcAFZwTdJ0NAMljKKiwSyl+DuI=;
 b=29b3w/lDXLoeXCNCoQEI3uToK28G/D+Q5HfCPXsGOybvgc2qxsLR8iQngHtAJqzYrwvCxfEfyXi19e5P1VxAttxhTviL52HsesX63vPYGH9oSklGZqPu+6fAHUmcYwpFitA0/telqQYZwlj52jrxnsTengeJ3376Rhqo4EgsdBg=
Received: from MWHPR1701CA0017.namprd17.prod.outlook.com
 (2603:10b6:301:14::27) by BN8PR12MB3426.namprd12.prod.outlook.com
 (2603:10b6:408:4a::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.32; Wed, 7 Jul
 2021 16:28:15 +0000
Received: from CO1NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:14:cafe::79) by MWHPR1701CA0017.outlook.office365.com
 (2603:10b6:301:14::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20 via Frontend
 Transport; Wed, 7 Jul 2021 16:28:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT051.mail.protection.outlook.com (10.13.174.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4308.20 via Frontend Transport; Wed, 7 Jul 2021 16:28:14 +0000
Received: from ozeng-develop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Wed, 7 Jul 2021
 11:28:13 -0500
From: Oak Zeng <Oak.Zeng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: Disallow debugfs to hang hws when GPU is resetting
Date: Wed, 7 Jul 2021 11:28:07 -0500
Message-ID: <1625675287-8484-1-git-send-email-Oak.Zeng@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2bae41d8-9b60-4749-4f59-08d941643849
X-MS-TrafficTypeDiagnostic: BN8PR12MB3426:
X-Microsoft-Antispam-PRVS: <BN8PR12MB3426C54EE24E38241F251DF9801A9@BN8PR12MB3426.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2201;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zlTTEYT/Df/1qhknZJC4kW7NC9sSeY+siCBrRF9JRjO4yELO9yZ28I8jdnIgqldlSxFADUOJpgYmEHaPxhOMCoXKeuRNn1eBBVKC1B703J52LjFJrQSsJvH/Z6v3Rd2ec+KKf94dNA3Z2fPgECxCsRysC7mlmSNViralJmGG+EDBjJH3rvHER0RiYLIFx3Zh88sp5GPlM02ZZRNEBF5rBmN2zvJqtFQJr4O5PMNH0h/rHZOCazD6dp+gXoQ819lwLJu9Dqlm8/FsockuQObGpcMEaw/3CszS2Ye3UXrqIyPgtKEQmpRXH9/3iwAPvouvYU8fHYVjEbBGXQ7E7PLHMeIjCvsd2vtOclU1NK5qwWWuWY0KJClNWO5AUD18Z8aE0gBEbtWhGusSAJKnivj4USQufcfJiNJBzMx0yIzaFoybnwIVCBNvjhdoXuZyapBOmqz/+70gdf7Xiy8gaqv95/sJuPFd2q2EyZlGtLPre+wZrgDo02h++wujmalpGu1V0dP78Ir+4R39GwFroc8km2kIj0XhxLZJY0oB8VxWTMfyw4gYId64PdLhhPS/0BMR0zxdT4Km5NS2DJG7rPIAyEKku39hAhqS66aoZ0B20Eman87Y04VTwu21ZT4ujcEqmRljW0WQpBm0tL8BjHKgiZk8W7Ildu/ftD3F8WsAkcS9vaTEX4mQKL3AHCmQekeLCCkeB2wEBKTsCkVjUjUz/Ta3YtXOlhLrHCif9Ny6lEI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(136003)(396003)(39860400002)(346002)(36840700001)(46966006)(426003)(6916009)(70206006)(8676002)(356005)(81166007)(8936002)(5660300002)(4744005)(2906002)(82740400003)(82310400003)(36756003)(336012)(478600001)(4326008)(316002)(54906003)(7696005)(6666004)(26005)(36860700001)(86362001)(47076005)(70586007)(186003)(16526019)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2021 16:28:14.4830 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bae41d8-9b60-4749-4f59-08d941643849
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3426
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
Cc: zoy.bai@amd.com, feifei.xu@amd.com, Felix.Kuehling@amd.com,
 lijo.lazar@amd.com, Oak Zeng <Oak.Zeng@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

If GPU is during a resetting cycle, writing to GPU can cause
unpredictable protection fault. Disallow using kfd debugfs
hang_hws to hang hws if GPU is resetting.

Signed-off-by: Oak Zeng <Oak.Zeng@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 9e4a05e..c380be9 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -1390,6 +1390,11 @@ int kfd_debugfs_hang_hws(struct kfd_dev *dev)
 		return -EINVAL;
 	}
 
+	if (dev->dqm->is_resetting) {
+		pr_err("HWS is already under resetting, please wait the current reset to finish\n");
+		return -EBUSY;
+	}
+
 	r = pm_debugfs_hang_hws(&dev->dqm->packets);
 	if (!r)
 		r = dqm_debugfs_execute_queues(dev->dqm);
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
