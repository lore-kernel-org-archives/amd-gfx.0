Return-Path: <SRS0=z2P7=BH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1B53C433DF
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jul 2020 02:29:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50FF92070A
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jul 2020 02:29:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="PDfPzzcv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50FF92070A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E3EE6E125;
	Tue, 28 Jul 2020 02:29:44 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680080.outbound.protection.outlook.com [40.107.68.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 59F6A6E125
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jul 2020 02:29:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V/VPJNfxcGbefD2ybl7BnuT33W7nj81LeEPoO7RFfRnhp9kIcYEWYG0BSXFyMTWm+Fp38VtTQqUH9My8V+Y+xGeoER22SQ/sseFGitkaV9RjmQxg9ZpK2HNmMcbfpgXlMTgkes1XnxFVFf5ffh/5drnvq1TFoApItRtpPfPM4pMAVFhuYL3C+292yGWtJk/0M2vQpbuMH1+x/BQdap0OKWG7bIPiEQjH910iUyP0SrFzCgaqRki1CuyLJIwOnh4SV2BSoYt8GvOQu7QPspOtDUBP8U5uRiQzu5zVGrauUy6oASl6TaMgaxk0qYjv0JYA08nPWjP3RcRWARO+J9hR8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HfryDtaZIr186o5JGWwbwEUB5osjSMfD8qykUyOIx5Y=;
 b=Yaww69SNSg5Ys1GJvW8ujbIT8Q5sNAkC0Oc6vS61mzUPKEEEwwgLx3+eyleZxIU9dG6C3QVATvWeEsMYMWuk+XsFFNj0FvPoro0w1vWNrvP6d0JmI+F77vO2B+E88eOBRenmmtP/j3arZgPSc/TQ+pehtX4aqYl5wKzXh/hvO8Sp6PToc/hvyhbvqU3VOdAJwCtShndrnnx6r/iexip+g4boXMFYQaWE6aIhLjZticaGs9wgGPHSRG8fCGUvKGNdLeAkF8tUxiQ95OtKO+/subgDzWJg5iB3HUMAHPWpnpQ/JPibkNfiSnYusy+nEqCYO2Q8ueiz6KZuJA8QfaEPNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HfryDtaZIr186o5JGWwbwEUB5osjSMfD8qykUyOIx5Y=;
 b=PDfPzzcvZOQkN7nUIioFZtriCPsCTqsvMTZ3a9/LLvXieW1zq0/JQgEurHCSqFeHggc6gXEpOepWzWMbsTSKMTSjetEhAQlrFKAKPM5+sccIR5tq9lJwnjfbqOXFltzRHWMePft54kJ2jMbuHnCWpPzDLUa1p8uV9NUL51UWw6I=
Received: from BN0PR03CA0048.namprd03.prod.outlook.com (2603:10b6:408:e7::23)
 by MN2PR12MB3198.namprd12.prod.outlook.com (2603:10b6:208:101::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.27; Tue, 28 Jul
 2020 02:29:40 +0000
Received: from BN8NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e7:cafe::96) by BN0PR03CA0048.outlook.office365.com
 (2603:10b6:408:e7::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.23 via Frontend
 Transport; Tue, 28 Jul 2020 02:29:40 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT010.mail.protection.outlook.com (10.13.177.53) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3216.10 via Frontend Transport; Tue, 28 Jul 2020 02:29:40 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 27 Jul
 2020 21:29:40 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 27 Jul
 2020 21:29:39 -0500
Received: from chengzhe-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Mon, 27 Jul 2020 21:29:37 -0500
From: Liu ChengZhe <ChengZhe.Liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: fix PSP autoload twice in FLR
Date: Tue, 28 Jul 2020 10:29:29 +0800
Message-ID: <20200728022929.411527-1-ChengZhe.Liu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 37aee895-6b4b-4184-abf8-08d8329e14c8
X-MS-TrafficTypeDiagnostic: MN2PR12MB3198:
X-Microsoft-Antispam-PRVS: <MN2PR12MB3198B34E2856C76B1AFFB34793730@MN2PR12MB3198.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2201;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fiRnLaziwe/G/6ozjMC8gxE2dWIFshfCaULzm7lWvkxKxjjZP6NzzwcgSWwR/gj8kQWpTKIN09UubjpuGd4q/woDR7NnzP2m26MmbQMFAuK0HToUY9bR5m4jQX1EjUfsP2bqvq5RoiuSMKbsnAbeXVDoVz2I+a6wmPFeh5mPT7vdie+JO9ANlYGpVyprrAKdaIwOZwFOfWeiiZ7Mm6f1khthkkbfME7YopvkJAFOIUc3IXWwRj4fqYkHifqXlfBQnwepEnkqCE49v1LbzkmA2bGg56o5E0Wcl9iWNx7VWe64EPglh3X+mEuD9vHOZd+ygLWRsfzvczP7BpBIRNHnU0scPqPvr9NEDpeYxTo5OZqwPmQzm2DaNiMTOZIsbPVEAQFkagThV8ZM6ihJ+vZLCA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(396003)(346002)(376002)(136003)(46966005)(5660300002)(83380400001)(186003)(2616005)(4326008)(36756003)(2906002)(1076003)(426003)(86362001)(6916009)(26005)(336012)(7696005)(54906003)(82310400002)(8676002)(6666004)(356005)(316002)(82740400003)(81166007)(8936002)(478600001)(47076004)(70206006)(70586007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2020 02:29:40.6553 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 37aee895-6b4b-4184-abf8-08d8329e14c8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3198
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
Cc: Jack Xiao <Jack.Xiao@amd.com>, Feifei
 Xu <Feifei.Xu@amd.com>, Kevin Wang <Kevin1.Wang@amd.com>,
 Liu ChengZhe <ChengZhe.Liu@amd.com>, Tuikov Luben <Luben.Tuikov@amd.com>,
 Deucher Alexander <Alexander.Deucher@amd.com>,
 Xiaojie Yuan <xiaojie.yuan@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

the block->status.hw = false assignment will overwrite PSP's previous
hw status, which will cause PSP execute resume operation after hw init.

v2: remove the braces

Signed-off-by: Liu ChengZhe <ChengZhe.Liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 62ecac97fbd2..5d9affa1d35a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2574,6 +2574,9 @@ static int amdgpu_device_ip_reinit_early_sriov(struct amdgpu_device *adev)
 		AMD_IP_BLOCK_TYPE_IH,
 	};
 
+	for (i = 0; i < adev->num_ip_blocks; i++)
+		adev->ip_blocks[i].status.hw = false;
+
 	for (i = 0; i < ARRAY_SIZE(ip_order); i++) {
 		int j;
 		struct amdgpu_ip_block *block;
@@ -2581,7 +2584,6 @@ static int amdgpu_device_ip_reinit_early_sriov(struct amdgpu_device *adev)
 		for (j = 0; j < adev->num_ip_blocks; j++) {
 			block = &adev->ip_blocks[j];
 
-			block->status.hw = false;
 			if (block->version->type != ip_order[i] ||
 				!block->status.valid)
 				continue;
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
